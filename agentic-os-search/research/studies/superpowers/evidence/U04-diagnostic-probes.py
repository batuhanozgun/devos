#!/usr/bin/env python3
"""Source-informed U04 diagnostic checks; no live agent or project tests.

Usage: python3 U04-diagnostic-probes.py /path/to/pinned/source-root
The root needs only the two exact files in SOURCES. SHA checking occurs before
execution. All fixtures and stub npm commands are temporary. Network access,
credentials, installation and real npm/project tests are not used.
A FAIL means a study-defined claim-scope criterion failed, not that the runner
failed. Exit 0 means evidence collection finished. Criteria precede this run.
"""
from __future__ import annotations
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import tempfile

PIN = "b36e0829c6d0140e93cfef2ca599b1b07d4a7797"
SOURCES = {
    "skills/systematic-debugging/find-polluter.sh": "985f5d08ccf8a3f2d40739cfcaf4413bb24bf1cb",
    "tests/systematic-debugging/test-find-polluter.sh": "0902e7d9d606a94916a098f92312977397a7860b",
}
STUB = '''#!/usr/bin/env bash
printf '%s\\n' "$*" >> "$CALL_LOG"
case "$PROBE_MODE" in
  clean) exit 0 ;;
  pollute) touch "$POLLUTION_TARGET"; exit 0 ;;
  launcher_error) echo 'synthetic test launcher unavailable' >&2; exit 127 ;;
  test_failure) echo 'synthetic assertion failed' >&2; exit 1 ;;
  *) exit 99 ;;
esac
'''


def run(argv: list[str], cwd: Path, env: dict[str, str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(argv, cwd=cwd, env=env, text=True,
                          capture_output=True, timeout=15, check=False)


def main() -> int:
    if len(sys.argv) != 2:
        raise SystemExit("Usage: U04-diagnostic-probes.py PINNED_SOURCE_ROOT")
    root = Path(sys.argv[1]).resolve()
    verified: dict[str, dict[str, str | int | bool]] = {}
    for relative, expected in SOURCES.items():
        data = (root / relative).read_bytes()
        got = hashlib.sha1(f"blob {len(data)}\0".encode() + data).hexdigest()
        if got != expected:
            raise SystemExit(f"Source identity mismatch: {relative}: {got}")
        verified[relative] = {"blob": got, "bytes": len(data), "verified": True}
    bash = shutil.which("bash")
    if not bash:
        raise SystemExit("bash is required")
    cases = []
    with tempfile.TemporaryDirectory(prefix="superpowers-u04-") as temporary:
        temp = Path(temporary)
        home = temp / "home"
        home.mkdir()
        env = {"PATH": os.defpath, "HOME": str(home), "LC_ALL": "C.UTF-8", "TMPDIR": str(temp)}
        copied = temp / "source"
        for relative in SOURCES:
            dest = copied / relative
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes((root / relative).read_bytes())
            dest.chmod(0o755)
        helper = copied / "skills/systematic-debugging/find-polluter.sh"
        suite = copied / "tests/systematic-debugging/test-find-polluter.sh"
        first_party = run([bash, str(suite)], copied, env)
        upstream_record = {
            "command": "bash tests/systematic-debugging/test-find-polluter.sh",
            "exit_code": first_party.returncode,
            "passed_assertion_lines": first_party.stdout.count("[PASS]"),
            "stdout": first_party.stdout,
            "stderr": first_party.stderr,
            "scope": "One exact first-party fixture file; it substitutes npm. Not the repository-wide suite or real project tests.",
        }
        specs = [
            ("bad_arguments", "clean", "src/**/*.test.ts", False, True),
            ("clean_matching_files", "clean", "src/**/*.test.ts", False, False),
            ("polluter_detected", "pollute", "src/**/*.test.ts", False, False),
            ("no_matching_files", "clean", "nomatch/**/*.test.ts", False, False),
            ("preexisting_pollution", "clean", "src/**/*.test.ts", True, False),
            ("launcher_failed", "launcher_error", "src/**/*.test.ts", False, False),
            ("test_failure_without_pollution", "test_failure", "src/**/*.test.ts", False, False),
        ]
        for name, mode, pattern, preexisting, bad_args in specs:
            project = temp / name
            (project / "src/nested").mkdir(parents=True)
            (project / "src/top.test.ts").write_text("// synthetic fixture, never interpreted\n")
            (project / "src/nested/child.test.ts").write_text("// synthetic fixture, never interpreted\n")
            (project / "bin").mkdir()
            stub = project / "bin/npm"
            stub.write_text(STUB)
            stub.chmod(0o755)
            call_log = project / "calls.log"
            marker = project / "pollution.marker"
            if preexisting:
                marker.write_text("preexisting synthetic artifact\n")
            case_env = env | {"PATH": str(project / "bin") + os.pathsep + os.defpath,
                              "CALL_LOG": str(call_log), "PROBE_MODE": mode,
                              "POLLUTION_TARGET": str(marker)}
            argv = [bash, str(helper)] + ([] if bad_args else ["pollution.marker", pattern])
            result = run(argv, project, case_env)
            calls = call_log.read_text().splitlines() if call_log.exists() else []
            clean = "all tests clean!" in result.stdout
            found = "FOUND POLLUTER!" in result.stdout
            observed = {
                "exit_code": result.returncode, "stub_invocations": calls,
                "invocation_count": len(calls), "pollution_exists": marker.exists(),
                "blanket_clean_claim": clean, "polluter_reported": found,
                "stdout": result.stdout, "stderr": result.stderr,
            }
            kind = "mechanism"
            if name == "bad_arguments":
                criterion = "Reject missing arguments without invoking the test launcher"
                ok = result.returncode == 1 and len(calls) == 0 and not clean
            elif name == "clean_matching_files":
                criterion = "Discover both fixture levels, invoke both, and report no observed target pollution"
                ok = result.returncode == 0 and len(calls) == 2 and clean and not marker.exists()
            elif name == "polluter_detected":
                criterion = "Detect controlled target creation and stop after the first invoked fixture"
                ok = result.returncode == 1 and len(calls) == 1 and found and marker.exists() and not clean
            elif name == "no_matching_files":
                kind = "claim-scope-challenge"
                criterion = "Without any candidate test execution, do not issue an unqualified all-tests-clean conclusion"
                ok = not clean
            elif name == "preexisting_pollution":
                kind = "claim-scope-challenge"
                criterion = "Preexisting target pollution causing all tests to be skipped must not end with all-tests-clean"
                ok = not clean
            elif name == "launcher_failed":
                kind = "claim-scope-challenge"
                criterion = "A launcher returning 127 without running tests must not support an unqualified all-tests-clean conclusion"
                ok = not clean
            else:
                kind = "scope-observation"
                criterion = "Record intentional suppression of test failure when no target artifact appears; this is not a passing-test verdict"
                ok = result.returncode == 0 and len(calls) == 2 and clean and not marker.exists()
            cases.append({"id": name, "kind": kind, "criterion": criterion,
                          "result": "PASS" if ok else "FAIL", "observed": observed})
        bash_version = run([bash, "--version"], temp, env).stdout.splitlines()[0]
    print(json.dumps({
        "study_date": "2026-09-17", "upstream_commit": PIN,
        "sources": verified,
        "environment": {"os": platform.system(), "python": platform.python_version(), "bash": bash_version},
        "scope": "Exact diagnostic helper and one exact first-party fixture file; controlled npm stubs only. No live agent, real project test, credentials, install or network.",
        "criteria_status": "Source-informed exploratory. Three claim-scope criteria are study-defined; exit-zero alone is not judged a defect. Full output also exposes zero/skipped counts.",
        "first_party_fixture_test": upstream_record,
        "cases": cases,
        "summary": {"local_cases": len(cases),
                    "expected_observations": sum(c["result"] == "PASS" for c in cases),
                    "failed_claim_scope_criteria": sum(c["result"] == "FAIL" for c in cases),
                    "upstream_fixture_exit": first_party.returncode},
    }, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
