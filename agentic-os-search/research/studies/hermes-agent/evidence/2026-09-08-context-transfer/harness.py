"""Offline, bounded transport probe; synthetic policy is NOT Hermes dispatch."""
from __future__ import annotations
import contextvars
import hashlib
import importlib.util
import json
import platform
import sys
import threading
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
from pathlib import Path
from types import ModuleType

ROOT = Path(__file__).resolve().parent
EXPECTED = {
    "thread_context.py": "d8c37af8f5a529680e81e867177140e41c4c6656",
    "daemon_pool.py": "5682a8f6ae103a421c1081b69ee6f9272957acdf",
    "skill_provenance.py": "3df9cf143045644310fa7d27a65666c8c23caf95",
    "LICENSE": "75410e73319c72cd3e991a501c5455eb78f38375",
}

def digest(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()

identities = {}
for name, expected in EXPECTED.items():
    data = (ROOT / "upstream" / name).read_bytes()
    actual = digest(data)
    if actual != expected:
        raise RuntimeError(f"Source identity mismatch: {name}: {actual} != {expected}")
    identities[name] = {"git_blob": actual, "sha256": hashlib.sha256(data).hexdigest(), "bytes": len(data)}

# Only the terminal callback API is stubbed. It never invokes a callback or tool.
terminal = ModuleType("tools.terminal_tool")
callback_tls = threading.local()
terminal._get_approval_callback = lambda: getattr(callback_tls, "approval", None)
terminal._get_sudo_password_callback = lambda: getattr(callback_tls, "sudo", None)
terminal.set_approval_callback = lambda value: setattr(callback_tls, "approval", value)
terminal.set_sudo_password_callback = lambda value: setattr(callback_tls, "sudo", value)
tools = ModuleType("tools")
tools.__path__ = []
tools.terminal_tool = terminal
sys.modules["tools"] = tools
sys.modules["tools.terminal_tool"] = terminal

def load(name: str):
    spec = importlib.util.spec_from_file_location("probe_" + name, ROOT / "upstream" / (name + ".py"))
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load {name}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module

transport = load("thread_context")
pool = load("daemon_pool")
origin = load("skill_provenance")
profile_marker = contextvars.ContextVar("synthetic_profile", default="unset")
allowlist_tls = threading.local()  # A stand-in for plugins._thread_tool_whitelist, NOT imported upstream.
allowed_names = {"memory", "skill_manage", "read_file"}
harmless_name = "synthetic_not_allowed"
parent_id = threading.get_ident()
origin_token = origin.set_current_write_origin("background_review")
profile_token = profile_marker.set("synthetic-profile-A")
terminal.set_approval_callback("approval-A")
terminal.set_sudo_password_callback("sudo-A")
allowlist_tls.allowed = set(allowed_names)

def observe() -> dict:
    allowed = getattr(allowlist_tls, "allowed", None)
    return {
        "worker_is_parent": threading.get_ident() == parent_id,
        "origin": origin.get_current_write_origin(),
        "synthetic_profile": profile_marker.get(),
        "approval_callback_marker": terminal._get_approval_callback(),
        "sudo_callback_marker": terminal._get_sudo_password_callback(),
        "synthetic_allowlist": sorted(allowed) if allowed is not None else None,
        "synthetic_name_blocked": allowed is not None and harmless_name not in allowed,
    }

records = []
def record(case_id: str, obs: dict, expected: dict) -> None:
    mismatches = {k: {"expected": v, "actual": obs.get(k)} for k, v in expected.items() if obs.get(k) != v}
    records.append({"id": case_id, "observation": obs, "expected_subset": expected, "diagnostic_matched": not mismatches, "mismatches": mismatches})

try:
    parent = observe()
    record("P01", parent, {"worker_is_parent": True, "origin": "background_review", "synthetic_profile": "synthetic-profile-A", "approval_callback_marker": "approval-A", "sudo_callback_marker": "sudo-A", "synthetic_name_blocked": True})
    with ThreadPoolExecutor(max_workers=1) as executor:
        record("P02", executor.submit(observe).result(timeout=5), {"worker_is_parent": False, "origin": "foreground", "synthetic_profile": "unset", "approval_callback_marker": None, "sudo_callback_marker": None, "synthetic_allowlist": None})
    with pool.DaemonThreadPoolExecutor(max_workers=1) as executor:
        record("P03", executor.submit(observe).result(timeout=5), {"worker_is_parent": False, "origin": "background_review", "synthetic_profile": "synthetic-profile-A", "approval_callback_marker": None, "sudo_callback_marker": None, "synthetic_allowlist": None})
    with pool.DaemonThreadPoolExecutor(max_workers=1) as executor:
        record("P04", executor.submit(transport.propagate_context_to_thread(observe)).result(timeout=5), {"worker_is_parent": False, "origin": "background_review", "synthetic_profile": "synthetic-profile-A", "approval_callback_marker": "approval-A", "sudo_callback_marker": "sudo-A", "synthetic_allowlist": None, "synthetic_name_blocked": False})
    def explicit_binding():
        allowlist_tls.allowed = set(allowed_names)
        try:
            return observe()
        finally:
            allowlist_tls.allowed = None
    with pool.DaemonThreadPoolExecutor(max_workers=1) as executor:
        record("P05", executor.submit(transport.propagate_context_to_thread(explicit_binding)).result(timeout=5), {"synthetic_name_blocked": True, "origin": "background_review", "approval_callback_marker": "approval-A"})
    class DiagnosticError(Exception):
        pass
    def raises():
        raise DiagnosticError("deliberate bounded fixture")
    with pool.DaemonThreadPoolExecutor(max_workers=1) as executor:
        caught = False
        try:
            executor.submit(transport.propagate_context_to_thread(raises)).result(timeout=5)
        except DiagnosticError:
            caught = True
        obs = executor.submit(observe).result(timeout=5)
        obs["diagnostic_exception_observed"] = caught
        record("P06", obs, {"diagnostic_exception_observed": True, "approval_callback_marker": None, "sudo_callback_marker": None})
    record("P07", observe(), parent)
finally:
    origin.reset_current_write_origin(origin_token)
    profile_marker.reset(profile_token)
    terminal.set_approval_callback(None)
    terminal.set_sudo_password_callback(None)
    allowlist_tls.allowed = None

report = {
    "recorded_at_utc": datetime.now(timezone.utc).isoformat(),
    "python": sys.version,
    "platform": platform.platform(),
    "upstream_pin": "c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a",
    "scope": "Three exact upstream modules; synthetic callback API/profile marker/thread-local policy; no AIAgent, actual tool dispatch, provider, credentials or network.",
    "upstream_identity": identities,
    "harness_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    "challenge_sha256": hashlib.sha256((ROOT / "CHALLENGE.md").read_bytes()).hexdigest(),
    "cases": records,
    "all_diagnostic_expectations_matched": all(r["diagnostic_matched"] for r in records),
    "product_conformance_verdict": "NOT_ASSESSED",
}
text = json.dumps(report, indent=2, ensure_ascii=False)
(ROOT / "RESULT.json").write_text(text + "\n", encoding="utf-8")
print(text)
if not report["all_diagnostic_expectations_matched"]:
    raise SystemExit(1)
