#!/usr/bin/env python3
"""Offline, source-pinned slash-access diagnostics. No provider or gateway startup."""
from __future__ import annotations
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import platform
import sys
import tempfile
from datetime import datetime, timezone
from types import SimpleNamespace as NS, ModuleType

ROOT = Path(__file__).resolve().parent
EXPECTED = "07204201e411f29f912bb9bba6beec0566acab9d"

def blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()

def identity(path: Path) -> dict:
    data = path.read_bytes()
    return {"bytes": len(data), "git_blob": blob(data), "sha256": hashlib.sha256(data).hexdigest()}

def load_verified(path: Path):
    if blob(path.read_bytes()) != EXPECTED:
        raise ValueError("source identity mismatch; import refused")
    spec = importlib.util.spec_from_file_location("hermes_research_slash_access", path)
    if spec is None or spec.loader is None:
        raise RuntimeError("cannot construct import spec")
    mod = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = mod
    spec.loader.exec_module(mod)
    return mod

def resolve(mod, extra=None, *, scope="dm", user="reader", platform_name="fixture", missing=False):
    platforms = {} if missing else {"fixture": NS(extra=extra or {})}
    source = NS(platform=platform_name, chat_type=scope, user_id=user)
    return mod.policy_for_source(NS(platforms=platforms), source)

def observations(mod):
    admin = {"allow_admin_from": ["owner"]}
    a01 = resolve(mod)
    a02 = resolve(mod, admin)
    a03 = resolve(mod, admin, user="owner")
    a04 = resolve(mod, {**admin, "user_allowed_commands": ["memory"]})
    scoped = {"allow_admin_from": ["dm-owner"], "group_allow_admin_from": ["group-owner"]}
    dm = resolve(mod, scoped)
    group = resolve(mod, scoped, scope="group")
    fallback = {**admin, "group_user_allowed_commands": ["memory"]}
    inherited = resolve(mod, fallback)
    own = resolve(mod, {**fallback, "user_allowed_commands": ["skills"]})
    normalized = resolve(mod, {"allow_admin_from": [123], "user_allowed_commands": " /MEMORY, /SKILLS "})
    absent = resolve(mod, missing=True)
    return [
      ("A01", {"enabled": a01.enabled, "memory": a01.can_run("reader", "memory")},
               {"enabled": False, "memory": True}),
      ("A02", {n: a02.can_run("reader", n) for n in ("memory", "skills", "help", "whoami")},
               {"memory": False, "skills": False, "help": True, "whoami": True}),
      ("A03", {n: a03.can_run("owner", n) for n in ("memory", "skills", "approvals")},
               {"memory": True, "skills": True, "approvals": True}),
      ("A04", {n: a04.can_run("reader", n) for n in ("memory", "skills", "memory approve")},
               {"memory": True, "skills": False, "memory approve": False}),
      ("A05", {"dm_owner_in_dm": dm.is_admin("dm-owner"), "dm_owner_in_group": group.is_admin("dm-owner"),
               "group_owner_in_group": group.is_admin("group-owner"), "group_owner_in_dm": dm.is_admin("group-owner")},
               {"dm_owner_in_dm": True, "dm_owner_in_group": False, "group_owner_in_group": True, "group_owner_in_dm": False}),
      ("A06", {"fallback_memory": inherited.can_run("reader", "memory"),
               "explicit_memory": own.can_run("reader", "memory"), "explicit_skills": own.can_run("reader", "skills")},
               {"fallback_memory": True, "explicit_memory": False, "explicit_skills": True}),
      ("A07", {"numeric_admin": normalized.is_admin("123"), "commands": sorted(normalized.user_allowed_commands)},
               {"numeric_admin": True, "commands": ["memory", "skills"]}),
      ("A08", {"enabled": absent.enabled, "memory": absent.can_run("reader", "memory")},
               {"enabled": False, "memory": True}),
    ]

def main():
    source = ROOT / "upstream/slash_access.py"
    mod = load_verified(source)
    rows = [{"id": k, "observed": o, "expected": e, "matched": o == e} for k, o, e in observations(mod)]
    # Distinct identity rejection: changed source is never imported.
    with tempfile.TemporaryDirectory(prefix="hermes-policy-id-") as d:
        changed = Path(d) / "changed.py"
        changed.write_bytes(source.read_bytes() + b"\n# altered fixture\n")
        try:
            load_verified(changed)
        except ValueError as exc:
            identity_control = {"rejected_before_import": True, "error": str(exc)}
        else:
            identity_control = {"rejected_before_import": False}
    # Deliberate test mutation, explicitly not upstream. Only policy body changes.
    tree = ast.parse(source.read_text())
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef) and node.name == "can_run":
            node.body = [ast.Return(value=ast.Constant(value=True))]
    ast.fix_missing_locations(tree)
    mutant = ModuleType("research_deliberate_allow_all_mutant")
    sys.modules[mutant.__name__] = mutant
    exec(compile(tree, "<deliberate-test-mutation>", "exec"), mutant.__dict__)
    mutation_rows = observations(mutant)
    mismatches = [k for k, o, e in mutation_rows if o != e]
    mutation_control = {"mutation": "can_run always True", "detected_by": mismatches,
                        "A02_detected": "A02" in mismatches}
    result = {
      "kind": "BOUNDED_FULL_POLICY_MODULE_DIAGNOSTICS_NOT_GATEWAY_E2E",
      "executed_at_utc": datetime.now(timezone.utc).isoformat(),
      "python": sys.version, "platform": platform.platform(),
      "upstream_pin": "c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a",
      "source": identity(source), "spec": identity(ROOT / "SPEC.md"),
      "probe": identity(Path(__file__)),
      "synthetic": ["configuration namespace", "platform key", "source/user/chat holders"],
      "not_executed": ["GatewayRunner", "ingress authorization", "profile resolution", "slash handlers", "memory/store mutation", "provider"],
      "cases": rows, "identity_negative_control": identity_control,
      "oracle_mutation_control": mutation_control,
      "all_diagnostic_expectations_matched": all(r["matched"] for r in rows),
      "product_conformance": "NOT ASSESSED"
    }
    (ROOT / "RESULT.json").write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"cases": len(rows), "matched": sum(r["matched"] for r in rows),
                      "identity_rejected": identity_control["rejected_before_import"], "mutation_detected": bool(mismatches)}))
    return 0 if all(r["matched"] for r in rows) and identity_control["rejected_before_import"] and mutation_control["A02_detected"] else 1

if __name__ == "__main__":
    raise SystemExit(main())
