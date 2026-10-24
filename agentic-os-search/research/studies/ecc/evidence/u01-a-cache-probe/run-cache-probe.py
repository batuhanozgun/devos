#!/usr/bin/env python3
"""Source-bound, presence-only ECC cache-checker probe; never invokes Codex.

Supply the two reviewed upstream files at the pinned commit. The program checks
Git blob identities, copies only these files into an isolated temporary tree,
and runs the unchanged checker against synthetic caches. No network access,
package installation, real user configuration, or host execution is required.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import tempfile

PIN = "8321021c54d670126ce3b2969d5deb880b4b0c2a"
EXPECTED = {
    "checker": "6839b413cc78d6755cc56f61be0d57f4754b5fa6",
    "manifest": "7ad227cac60a8ce5d97e6d152e449812857d13eb",
}


def git_blob(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--checker", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--plan", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    source = {"checker": args.checker.read_bytes(), "manifest": args.manifest.read_bytes()}
    for key, data in source.items():
        actual = git_blob(data)
        if actual != EXPECTED[key]:
            raise ValueError(f"{key} identity mismatch: {actual} != {EXPECTED[key]}")
    plan_bytes = args.plan.read_bytes()
    plan = json.loads(plan_bytes)
    if plan.get("source_ref") != PIN or len(plan.get("cases", [])) != 3:
        raise ValueError("Unexpected probe plan: expected pinned three-case design")
    node = shutil.which("node")
    if node is None:
        raise RuntimeError("Node.js is required; no installation is performed")
    args.output.mkdir(parents=True, exist_ok=True)
    report: dict = {
        "probe_id": plan["id"], "source_ref": PIN,
        "source_git_blobs": EXPECTED,
        "plan_sha256": hashlib.sha256(plan_bytes).hexdigest(),
        "runner_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "environment": {
            "platform": platform.platform(), "python": platform.python_version(),
            "node_executable": node,
            "node_version": subprocess.check_output([node, "--version"], text=True).strip(),
        },
        "fixture_notes": [
            "Root package.json is synthetic and contains only version=2.2.1.",
            "Checker and cached plugin manifest bytes match upstream Git blob SHA-1 identities.",
            "Referenced file contents are dummy values; only existence/type is at issue.",
            "Explicit temporary --plugin-dir, --codex-home and HOME isolate real user state.",
            "Neither Codex nor ECC install/lifecycle scripts are invoked.",
        ],
        "cases": [],
    }
    with tempfile.TemporaryDirectory(prefix="ecc-u01a-cache-probe-") as temp:
        root = Path(temp)
        script = root / "source/scripts/codex/check-plugin-cache.js"
        script.parent.mkdir(parents=True)
        script.write_bytes(source["checker"])
        (root / "source/package.json").write_text('{"version":"2.2.1"}\n')
        home = root / "fake-home"
        home.mkdir()
        env = {"PATH": os.environ.get("PATH", ""), "HOME": str(home),
               "USERPROFILE": str(home), "CODEX_HOME": str(home / ".codex"),
               "LANG": "C.UTF-8"}
        for spec in plan["cases"]:
            case_id = spec["id"]
            cache = root / case_id / "cache"
            (cache / ".codex-plugin").mkdir(parents=True)
            (cache / ".codex-plugin/plugin.json").write_bytes(source["manifest"])
            (cache / "skills").mkdir()
            for relative, contents in {
                ".mcp.json": "{}\n", "hooks/codex-hooks.json": "{}\n",
                "assets/ecc-icon.svg": "<svg/>\n", "assets/hero.png": "dummy-file\n",
            }.items():
                file = cache / relative
                file.parent.mkdir(parents=True, exist_ok=True)
                file.write_text(contents)
            if case_id == "C1":
                (cache / "hooks/codex-hooks.json").unlink()
            elif case_id == "C2":
                (cache / ".mcp.json").unlink()
            command = [node, str(script), "--plugin-dir", str(cache),
                       "--codex-home", str(home / ".codex")]
            result = subprocess.run(command, cwd=root, env=env, capture_output=True,
                                    text=True, timeout=15, check=False)
            observed = {
                "id": case_id, "command": command,
                "hooks_file_exists": (cache / "hooks/codex-hooks.json").exists(),
                "mcp_file_exists": (cache / ".mcp.json").exists(),
                "exit_code": result.returncode,
                "expected_exit_from_source": spec["expected_exit_from_source"],
                "stdout": result.stdout, "stderr": result.stderr,
                "matches_source_prediction": result.returncode == spec["expected_exit_from_source"],
            }
            report["cases"].append(observed)
    cases = {c["id"]: c for c in report["cases"]}
    report["interpretation"] = {
        "presence_baseline_accepted": cases["C0"]["exit_code"] == 0,
        "missing_hook_missed": not cases["C1"]["hooks_file_exists"] and cases["C1"]["exit_code"] == 0,
        "missing_mcp_detected": not cases["C2"]["mcp_file_exists"] and cases["C2"]["exit_code"] != 0,
        "host_runtime_or_effectiveness_tested": False,
        "upstream_test_suite_run": False,
    }
    (args.output / "RESULTS.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"environment": report["environment"],
                      "cases": [{k: c[k] for k in ("id", "hooks_file_exists", "mcp_file_exists", "exit_code")} for c in report["cases"]],
                      "interpretation": report["interpretation"]}, indent=2))
    if not all(c["matches_source_prediction"] for c in report["cases"]):
        raise SystemExit("Unexpected result; preserve evidence and investigate")


if __name__ == "__main__":
    main()
