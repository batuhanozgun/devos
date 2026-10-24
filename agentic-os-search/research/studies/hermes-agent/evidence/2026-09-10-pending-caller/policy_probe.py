#!/usr/bin/env python3
"""Offline exact-module diagnostics; no gateway, provider, or pending writes."""
from __future__ import annotations
import hashlib
import importlib.util
import json
import platform
import sys
import tempfile
from datetime import datetime, timezone
from pathlib import Path
from types import SimpleNamespace as NS

EXPECTED = "07204201e411f29f912bb9bba6beec0566acab9d"
HERE = Path(__file__).resolve().parent

def git_blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()

def load_checked(path: Path, name: str):
    data = path.read_bytes()
    actual = git_blob(data)
    if actual != EXPECTED:
        raise ValueError(f"SOURCE_IDENTITY_REJECTED expected={EXPECTED} actual={actual}")
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise RuntimeError("Cannot create source loader")
    mod = importlib.util.module_from_spec(spec)
    sys.modules[name] = mod
    spec.loader.exec_module(mod)
    return mod

def run() -> dict:
    source = HERE / "upstream" / "slash_access.py"
    mod = load_checked(source, "hermes_m3_slash_access")
    cases = []
    def record(case_id, observed, expected):
        cases.append({"id": case_id, "observed": observed, "expected": expected,
                      "expectation_matched": observed == expected})
    def decisions(p, user="guest"):
        return {cmd: p.can_run(user, cmd) for cmd in ("memory", "skills", "help", "whoami")}
    def cfg(extra):
        return NS(platforms={"fixture": NS(extra=extra)})
    def src(profile="alpha", chat="dm", user="guest", plat="fixture"):
        return NS(platform=plat, profile=profile, chat_type=chat, user_id=user)
    yes = {k: True for k in ("memory", "skills", "help", "whoami")}
    limited = {"memory": False, "skills": False, "help": True, "whoami": True}
    mem = {**limited, "memory": True}

    p = mod.policy_from_extra({"user_allowed_commands": ["help"]}, "dm")
    record("SA01", {"enabled": p.enabled, "guest": decisions(p)},
           {"enabled": False, "guest": yes})
    p = mod.policy_from_extra({"allow_admin_from": ["owner"]}, "dm")
    record("SA02", {"enabled": p.enabled, "guest": decisions(p), "owner": decisions(p, "owner")},
           {"enabled": True, "guest": limited, "owner": yes})
    p = mod.policy_from_extra({"allow_admin_from": ["owner"], "user_allowed_commands": [" /MeMory "]}, "dm")
    removed = mod.policy_from_extra({"allow_admin_from": ["owner"]}, "dm")
    record("SA03", {"names": sorted(p.user_allowed_commands), "guest": decisions(p),
                    "removed_grant_denies_memory": not removed.can_run("guest", "memory"),
                    "uncanonical_input_allowed": p.can_run("guest", "/MeMory")},
           {"names": ["memory"], "guest": mem, "removed_grant_denies_memory": True,
            "uncanonical_input_allowed": False})
    extra = {"allow_admin_from": ["dm-owner"]}
    only_dm = mod.policy_from_extra(extra, "group")
    both = mod.policy_from_extra({**extra, "group_allow_admin_from": ["group-owner"]}, "group")
    record("SA04", {"dm_only_group_enabled": only_dm.enabled,
                    "dm_only_group_guest_skills": only_dm.can_run("guest", "skills"),
                    "both_dm_owner_skills": both.can_run("dm-owner", "skills"),
                    "both_group_owner_skills": both.can_run("group-owner", "skills")},
           {"dm_only_group_enabled": False, "dm_only_group_guest_skills": True,
            "both_dm_owner_skills": False, "both_group_owner_skills": True})
    p = mod.policy_from_extra({"allow_admin_from": ["dm-owner"], "user_allowed_commands": [],
                              "group_allow_admin_from": ["group-owner"], "group_user_allowed_commands": ["memory"]}, "dm")
    record("SA05", {"names": sorted(p.user_allowed_commands), "guest": decisions(p),
                    "group_owner_is_dm_admin": p.is_admin("group-owner")},
           {"names": ["memory"], "guest": mem, "group_owner_is_dm_admin": False})
    strict = cfg({"allow_admin_from": ["owner"]})
    permissive = cfg({"allow_admin_from": ["owner"], "user_allowed_commands": ["memory"]})
    a, b = mod.policy_for_source(strict, src("alpha")), mod.policy_for_source(strict, src("beta"))
    c = mod.policy_for_source(permissive, src("beta"))
    record("SA06", {"profile_only_equal": a == b, "alpha": a.can_run("guest", "memory"),
                    "beta_same_config": b.can_run("guest", "memory"),
                    "beta_different_config": c.can_run("guest", "memory")},
           {"profile_only_equal": True, "alpha": False, "beta_same_config": False,
            "beta_different_config": True})
    absent = mod.policy_for_source(None, src())
    missing = mod.policy_for_source(strict, src(plat="unconfigured"))
    record("SA07", {"absent_config_enabled": absent.enabled, "missing_platform_enabled": missing.enabled,
                    "absent_memory": absent.can_run("guest", "memory"),
                    "missing_memory": missing.can_run("guest", "memory")},
           {"absent_config_enabled": False, "missing_platform_enabled": False,
            "absent_memory": True, "missing_memory": True})
    out = {str(chat): mod.policy_for_source(strict, src(chat=chat)).can_run("guest", "skills")
           for chat in ("dm", "", None)}
    record("SA08", out, {"dm": False, "": True, "None": True})
    with tempfile.TemporaryDirectory(prefix="hermes-m3-identity-") as temp:
        bad = Path(temp) / "bad.py"
        bad.write_bytes(source.read_bytes() + b"\n")
        try:
            load_checked(bad, "hermes_m3_rejected_source")
        except ValueError as exc:
            identity = {"rejected": str(exc).startswith("SOURCE_IDENTITY_REJECTED"),
                        "module_imported": "hermes_m3_rejected_source" in sys.modules,
                        "error": str(exc)}
        else:
            identity = {"rejected": False, "module_imported": True}
    return {"kind": "BOUNDED_EXACT_SLASH_POLICY_COMPONENT_NOT_GATEWAY_EXECUTION",
            "run_at_utc": datetime.now(timezone.utc).isoformat(),
            "python": sys.version, "platform": platform.platform(),
            "upstream_ref": "c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a",
            "source_git_blob": git_blob(source.read_bytes()),
            "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
            "source_bytes": len(source.read_bytes()),
            "spec_sha256": hashlib.sha256((HERE / "SPEC.md").read_bytes()).hexdigest(),
            "probe_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "cases": cases, "source_identity_negative_control": identity,
            "all_diagnostic_expectations_matched": all(c["expectation_matched"] for c in cases),
            "product_conformance": "NOT_ASSESSED",
            "limits": ["Synthetic config/source values; no real person authenticated",
                       "No real gateway, CLI, profile-scope or caller construction",
                       "No pending mutation, provider, network or credential use",
                       "Profile-only comparison does not prove a deployment isolation failure",
                       "Source-informed exploratory cases, not independent verification"]}

if __name__ == "__main__":
    result = run()
    (HERE / "POLICY-RESULT.json").write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n")
    print(json.dumps({"cases": len(result["cases"]),
                      "matched": result["all_diagnostic_expectations_matched"],
                      "negative_guard": result["source_identity_negative_control"]["rejected"]}))
    if not result["all_diagnostic_expectations_matched"] or not result["source_identity_negative_control"]["rejected"]:
        raise SystemExit(1)
