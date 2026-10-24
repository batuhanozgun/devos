#!/usr/bin/env python3
"""Exploratory, offline HERMES two-module component continuity probes.

Default source location points to the older, unchanged repository evidence.
Use --source-dir for a standalone copy. Does NOT install or launch HERMES.
"""
from __future__ import annotations

import argparse
import contextvars
import hashlib
import importlib.util
import json
import logging
import platform
import socket
import sys
import tempfile
import types
from contextlib import contextmanager
from datetime import datetime, timezone
from pathlib import Path
from unittest.mock import patch

PIN = "c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a"
EXPECTED = {
    "skill_manager_batch.py": "9f38adff284eede4234948f67e99a43752c0926e",
    "write_approval.py": "f1e99b46e934595c002c2bc659143fcbc1f9fe8d",
}


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def load_source(name: str, path: Path):
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def offline_audit(event, args):
    if event in {"socket.connect", "socket.connect_ex", "socket.getaddrinfo", "subprocess.Popen", "os.system"}:
        raise RuntimeError(f"Probe forbids external action: {event}")


class Lab:
    """All substituted dependencies are installed only in this probe process."""
    def __init__(self, source_dir: Path):
        self.home = contextvars.ContextVar("synthetic_home")
        self.origin = contextvars.ContextVar("synthetic_origin", default="foreground")
        self.bypass = contextvars.ContextVar("synthetic_skill_gate_bypass", default=False)
        self.config_value = True
        self.config_failure = False
        self.callback_choice = "once"
        self.callback_absent = False
        self.callback_failure = False
        self.guard_denies = False
        self.fail_mode = None
        self.trace = []
        self.mutation_count = 0
        self.snapshot_paths = []
        self.real_mkdtemp = tempfile.mkdtemp
        for name in ("tools", "hermes_cli"):
            m = types.ModuleType(name)
            m.__path__ = []
            sys.modules[name] = m
        deps = {}
        for name in ("hermes_constants", "hermes_cli.config", "tools.skill_provenance",
                     "tools.terminal_tool", "tools.skill_manager_tool", "tools.registry",
                     "tools.skill_manager_guards"):
            deps[name] = types.ModuleType(name)
            sys.modules[name] = deps[name]
        deps["hermes_constants"].get_hermes_home = self.home.get
        deps["hermes_cli.config"].load_config = self.load_config
        deps["hermes_cli.config"].cfg_get = lambda cfg, subsystem, key, default=False: cfg.get(subsystem, {}).get(key, default)
        deps["tools.skill_provenance"].get_current_write_origin = self.origin.get
        deps["tools.terminal_tool"]._get_approval_callback = lambda: None if self.callback_absent else self.callback
        deps["tools.registry"].tool_error = lambda text, **kw: json.dumps({"error": text, **kw})
        deps["tools.skill_manager_guards"]._background_review_preflight = self.preflight
        smt = deps["tools.skill_manager_tool"]
        smt._skill_gate_bypass = self.bypass
        smt._find_skill = self.find_skill
        smt._run_write_gate = self.gate_adapter
        smt._skill_manage_from = self.mutate
        smt.skill_manage = self.unsupported_single
        sys.modules["tools"].skill_manager_tool = smt
        self.wa = load_source("tools.write_approval", source_dir / "write_approval.py")
        self.batch = load_source("tools.skill_manager_batch", source_dir / "skill_manager_batch.py")

    def load_config(self):
        if self.config_failure:
            raise OSError("synthetic config read failure")
        return {s: {"write_approval": self.config_value} for s in ("skills", "memory")}

    def callback(self, *args, **kwargs):
        self.trace.append({"event": "synthetic_inline_callback", "allow_permanent": kwargs.get("allow_permanent")})
        if self.callback_failure:
            raise OSError("synthetic callback failure")
        return self.callback_choice

    def preflight(self, action, name):
        self.trace.append({"event": "synthetic_guard", "action": action, "name": name,
                           "origin": self.origin.get(), "bypass": self.bypass.get()})
        if self.guard_denies:
            return {"success": False, "error": "synthetic policy rejects target"}
        return None

    def find_skill(self, name):
        if not isinstance(name, str) or name not in {"alpha", "beta"}:
            raise ValueError("Only safe fixture names alpha/beta are allowed")
        p = self.home.get() / "skills" / name
        return {"path": p} if p.is_dir() else None

    def gate_adapter(self, prepare):
        """Synthetic adapter. The production _run_write_gate is NOT imported."""
        self.trace.append({"event": "synthetic_gate_adapter"})
        decision = self.wa.evaluate_gate("skills")
        if decision.allow:
            return None
        if decision.blocked:
            return json.dumps({"success": False, "error": decision.message})
        payload, summary = prepare(self.wa)  # real batch closure generates these
        rec = self.wa.stage_write("skills", payload, summary=summary, origin=self.wa.current_origin())
        return json.dumps({"success": True, "staged": True, "pending_id": rec["id"]})

    def mutate(self, op, task_id=None, session_id=None):
        """Synthetic writer with real disposable files, NOT HERMES single-op semantics."""
        self.mutation_count += 1
        self.trace.append({"event": "synthetic_mutator", "name": op["name"], "action": op["action"],
                           "origin": self.origin.get(), "bypass": self.bypass.get(),
                           "task_id": task_id, "session_id": session_id})
        if self.mutation_count == 2 and self.fail_mode:
            if self.fail_mode == "exception":
                raise OSError("synthetic second-operation exception")
            if self.fail_mode == "interleaved":
                self.file().write_text("EXTERNAL-WRITER\n", encoding="utf-8")
                self.trace.append({"event": "deterministic_external_fixture_write", "content": "EXTERNAL-WRITER\n"})
            return json.dumps({"success": False, "error": "synthetic ordinary second-operation failure"})
        p = self.home.get() / "skills" / op["name"] / (op.get("file_path") or "SKILL.md")
        if p.parent != self.home.get() / "skills" / op["name"]:
            raise ValueError("Only fixture-root files are allowed")
        p.parent.mkdir(parents=True, exist_ok=True)
        if op["action"] == "patch":
            p.write_text(p.read_text(encoding="utf-8").replace(op["old_string"], op["new_string"]), encoding="utf-8")
        elif op["action"] == "write_file":
            p.write_text(op["file_content"], encoding="utf-8")
        else:
            raise ValueError(f"Unsupported synthetic action: {op['action']}")
        return json.dumps({"success": True})

    def unsupported_single(self, **kwargs):
        raise RuntimeError("Single-delete caller is not part of this probe")

    def file(self):
        return self.home.get() / "skills" / "alpha" / "SKILL.md"

    def mkdtemp(self, *args, **kwargs):
        kwargs["dir"] = self.home.get() / "snapshots"
        p = self.real_mkdtemp(*args, **kwargs)
        self.snapshot_paths.append(Path(p))
        return p

    @contextmanager
    def fixture(self):
        self.trace = []
        self.mutation_count = 0
        self.snapshot_paths = []
        self.config_value = True
        self.config_failure = self.callback_absent = self.callback_failure = self.guard_denies = False
        self.callback_choice, self.fail_mode = "once", None
        with tempfile.TemporaryDirectory(prefix="hermes_u01b2_fixture_") as td:
            ht = self.home.set(Path(td))
            ot = self.origin.set("foreground")
            bt = self.bypass.set(False)
            try:
                self.file().parent.mkdir(parents=True)
                self.file().write_text("BASELINE\n", encoding="utf-8")
                (Path(td) / "snapshots").mkdir()
                with patch.object(self.batch.tempfile, "mkdtemp", self.mkdtemp):
                    yield self
            finally:
                self.bypass.reset(bt)
                self.origin.reset(ot)
                self.home.reset(ht)

    def state(self):
        return {"skill_content": self.file().read_text(encoding="utf-8"),
                "pending_count": self.wa.pending_count("skills"),
                "mutator_calls": self.mutation_count,
                "snapshot_roots_created": len(self.snapshot_paths),
                "snapshot_roots_remaining": sum(p.exists() for p in self.snapshot_paths),
                "bypass": self.bypass.get(), "trace": list(self.trace)}

    def execute(self, operations, default_name=None):
        return json.loads(self.batch._skill_manage_batch(operations, default_name=default_name,
                                                        task_id="fixture-task", session_id="fixture-session"))

    def component_reentry(self, payload):
        """Test-side re-entry using serialized payload. NOT apply_skill_pending."""
        token = self.bypass.set(True)
        try:
            return self.execute(payload["operations"], default_name=payload.get("name"))
        finally:
            self.bypass.reset(token)


def single_op(explicit=True):
    op = {"action": "patch", "old_string": "BASELINE", "new_string": "PROPOSED"}
    if explicit:
        op["name"] = "alpha"
    return [op]


def double_ops():
    return [single_op()[0], {"action": "write_file", "name": "alpha", "file_path": "extra.txt", "file_content": "SECOND\n"}]


def check(condition: bool, message: str):
    if not condition:
        raise AssertionError(message)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--source-dir", type=Path, default=Path(__file__).resolve().parent.parent / "2026-09-07-u01b" / "component-probe" / "upstream")
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    if args.output.exists():
        raise SystemExit("Refusing to overwrite existing evidence; choose a new --output")
    source_dir = args.source_dir.resolve()
    identities = {}
    for filename, expected in EXPECTED.items():
        data = (source_dir / filename).read_bytes()
        blob = hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()
        if blob != expected:
            raise SystemExit(f"Source mismatch for {filename}: {blob}")
        identities[filename] = {"git_blob": blob, "sha256": sha256(data), "bytes": len(data)}
    spec_path = Path(__file__).resolve().with_name("SPEC.md")
    report = {"kind": "EXPLORATORY_COMPONENT_OBSERVATIONS_NOT_PRODUCT_PASS", "upstream_pin": PIN,
              "research_archive_ref": "a218acfc20e7ece488709e00a9762166ec970fba",
              "started_at_utc": datetime.now(timezone.utc).isoformat(),
              "runtime": {"python": platform.python_version(), "platform": platform.platform()},
              "source_identity": identities, "harness_sha256": sha256(Path(__file__).read_bytes()),
              "spec_sha256": sha256(spec_path.read_bytes()), "results": [],
              "limits": ["Only two archived upstream modules are real.", "Production caller/dispatcher/replay/profile/guards/mutator/ledger/sync not imported.",
                         "Test-side adapter and serialized-payload re-entry are synthetic.",
                         "No HERMES installation, provider, network, account or credential use.",
                         "Interleaving is a deterministic fixture schedule, not production concurrency reachability.",
                         "Assertions encode diagnostic observations, including limitations; not product acceptance."]}
    sys.addaudithook(offline_audit)
    lab = Lab(source_dir)

    def record(ident, fn):
        with lab.fixture():
            try:
                observation = fn()
                report["results"].append({"id": ident, "observation_assertions_satisfied": True, "observation": observation})
            except Exception as exc:
                report["results"].append({"id": ident, "observation_assertions_satisfied": False,
                                           "exception_type": type(exc).__name__, "exception": str(exc), "state": lab.state()})

    def gate_matrix():
        rows = [
            ("off", "memory", False, "foreground", "once", False, False, False, "allow", 0),
            ("skill-on", "skills", True, "foreground", "once", False, False, False, "stage", 0),
            ("background-memory", "memory", True, "background_review", "once", False, False, False, "stage", 0),
            ("approve-once", "memory", True, "foreground", "once", False, False, False, "allow", 1),
            ("approve-session", "memory", True, "foreground", "session", False, False, False, "allow", 1),
            ("deny", "memory", True, "foreground", "deny", False, False, False, "blocked", 1),
            ("no-channel", "memory", True, "foreground", "once", True, False, False, "stage", 0),
            ("unknown-answer", "memory", True, "foreground", "unknown", False, False, False, "stage", 1),
            ("callback-error", "memory", True, "foreground", "once", False, True, False, "stage", 1),
            ("config-error", "memory", True, "foreground", "once", False, False, True, "allow", 0),
        ]
        observations = []
        for label, subsystem, value, origin, choice, absent, cb_err, cfg_err, expected, callback_count in rows:
            lab.trace = []
            lab.config_value, lab.callback_choice = value, choice
            lab.callback_absent, lab.callback_failure, lab.config_failure = absent, cb_err, cfg_err
            token = lab.origin.set(origin)
            try:
                d = lab.wa.evaluate_gate(subsystem, inline_summary="synthetic memory", inline_detail="fixture")
            finally:
                lab.origin.reset(token)
            active = [k for k in ("allow", "blocked", "stage") if getattr(d, k)]
            count = sum(e["event"] == "synthetic_inline_callback" for e in lab.trace)
            check(active == [expected] and count == callback_count, f"gate row {label}")
            observations.append({"case": label, "decision": active[0], "callback_calls": count})
        check(lab.wa.pending_count("memory") == 0 and lab.wa.pending_count("skills") == 0, "decision unexpectedly persisted a record")
        return {"rows": observations, "pending_after_decisions_only": 0, "note": "stage decision is not stage_write"}
    record("G01", gate_matrix)

    def explicit_roundtrip():
        lab.origin.set("background_review")
        result = lab.execute(single_op())
        staged_state = lab.state()
        check(result.get("staged") and staged_state["mutator_calls"] == 0 and staged_state["snapshot_roots_created"] == 0, "staging had effects")
        rec = lab.wa.get_pending("skills", result["pending_id"])
        check(rec and rec["payload"]["operations"][0]["name"] == "alpha", "explicit name lost")
        lab.origin.set("foreground")
        replay = lab.component_reentry(json.loads(json.dumps(rec["payload"])))
        check(replay["success"] and lab.file().read_text() == "PROPOSED\n" and not lab.bypass.get(), "explicit re-entry failed")
        return {"stored_record": rec, "staged_state": staged_state, "synthetic_component_reentry": replay,
                "final_state": lab.state(), "warning": "Origin changed by fixture; production replay NOT tested. Pending consumption is outside these calls."}
    record("T01", explicit_roundtrip)

    def fallback_no_gate():
        lab.config_value = False
        result = lab.execute(single_op(False), default_name="alpha")
        check(result["success"] and lab.file().read_text() == "PROPOSED\n", "default_name direct path failed")
        return {"result": result, "state": lab.state()}
    record("T02", fallback_no_gate)

    def fallback_staged():
        result = lab.execute(single_op(False), default_name="alpha")
        rec = lab.wa.get_pending("skills", result["pending_id"])
        check(rec and "alpha" in rec["summary"], "expected target in gist")
        check("name" not in rec["payload"] and "name" not in rec["payload"]["operations"][0], "payload unexpectedly retained name")
        replay = lab.component_reentry(rec["payload"])
        check(not replay["success"] and "needs a 'name'" in replay["error"] and lab.mutation_count == 0, "expected missing-name failure")
        return {"stored_record": rec, "synthetic_component_reentry": replay, "state": lab.state()}
    record("T03", fallback_staged)

    def normalization_intervention():
        normalized = [{**op, "name": "alpha"} for op in single_op(False)]
        staged = lab.execute(normalized, default_name="alpha")
        rec = lab.wa.get_pending("skills", staged["pending_id"])
        replay = lab.component_reentry(rec["payload"])
        check(replay["success"] and lab.file().read_text() == "PROPOSED\n", "explicit normalization did not restore component replay")
        return {"intervention": "fixture inserts operation names before staging; upstream unchanged", "result": replay, "state": lab.state()}
    record("T04", normalization_intervention)

    def invalid_shape():
        result = lab.execute([{"name": "alpha"}])
        check(not result["success"] and lab.state()["pending_count"] == 0 and not lab.trace, "invalid shape reached effect path")
        return {"result": result, "state": lab.state()}
    record("T05", invalid_shape)

    def bypass_guard():
        lab.guard_denies = True
        token = lab.bypass.set(True)
        try:
            result = lab.execute(single_op())
            check(lab.bypass.get(), "call destroyed pre-existing bypass")
        finally:
            lab.bypass.reset(token)
        check(not result["success"] and lab.mutation_count == 0 and len(lab.trace) == 1 and lab.trace[0]["event"] == "synthetic_guard", "bypass skipped preflight")
        return {"result": result, "state": lab.state(), "scope": "preflight routing only; guard policy is synthetic"}
    record("T06", bypass_guard)

    def live_diff():
        rec = lab.wa.stage_write("skills", {"action": "edit", "name": "alpha", "content": "PROPOSED\n"}, summary="fixture edit", origin="foreground")
        pending = lab.home.get() / "pending" / "skills" / (rec["id"] + ".json")
        before_hash = sha256(pending.read_bytes())
        first = lab.wa.skill_pending_diff(rec)
        lab.file().write_text("EXTERNAL-WRITER\n", encoding="utf-8")
        second = lab.wa.skill_pending_diff(lab.wa.get_pending("skills", rec["id"]))
        after_hash = sha256(pending.read_bytes())
        check(first != second and "-BASELINE" in first and "-EXTERNAL-WRITER" in second and before_hash == after_hash, "live preview observation failed")
        return {"first_diff": first, "second_diff": second, "pending_bytes_sha256_before": before_hash,
                "pending_bytes_sha256_after": after_hash, "record_keys": sorted(rec), "applied_write_tested": False}
    record("D01", live_diff)

    def snapshot_failure():
        lab.config_value = False
        with patch.object(lab.batch.shutil, "copytree", side_effect=OSError("synthetic snapshot failure")):
            result = lab.execute(single_op())
        state = lab.state()
        check(not result["success"] and state["mutator_calls"] == 0 and state["skill_content"] == "BASELINE\n" and state["snapshot_roots_remaining"] == 0, "snapshot-failure guard failed")
        return {"result": result, "state": state}
    record("R01", snapshot_failure)

    def failure(mode):
        lab.config_value = False
        lab.fail_mode = mode
        result, exception = None, None
        try:
            result = lab.execute(double_ops())
        except OSError as exc:
            exception = {"type": type(exc).__name__, "message": str(exc)}
        state = lab.state()
        check(state["snapshot_roots_remaining"] == 0 and not state["bypass"], "cleanup/reset observation failed")
        if mode == "exception":
            check(exception is not None and state["skill_content"] == "PROPOSED\n", "exception compensation observation failed")
        else:
            check(result is not None and not result["success"] and state["skill_content"] == "BASELINE\n", "ordinary rollback failed")
            if mode == "interleaved":
                check(any(e["event"] == "deterministic_external_fixture_write" for e in lab.trace), "interleaving did not occur")
        return {"result": result, "raised_exception": exception, "state": state}
    record("R02", lambda: failure("ordinary"))
    record("R03", lambda: failure("exception"))
    record("R04", lambda: failure("interleaved"))
    report["finished_at_utc"] = datetime.now(timezone.utc).isoformat()
    report["all_observation_assertions_satisfied"] = all(r["observation_assertions_satisfied"] for r in report["results"])
    report["scenario_count"] = len(report["results"])
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("x", encoding="utf-8") as fh:
        json.dump(report, fh, ensure_ascii=False, indent=2)
        fh.write("\n")
    print(json.dumps({"scenarios": report["scenario_count"], "all_observation_assertions_satisfied": report["all_observation_assertions_satisfied"],
                      "product_conformance_claim": False, "output": str(args.output)}, ensure_ascii=False))
    return 0 if report["all_observation_assertions_satisfied"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
