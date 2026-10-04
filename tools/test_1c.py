#!/usr/bin/env python3
"""test_1c.py: the deterministic gate tests of W-C00-12 tranche 1c (12_tranche_plan.md section 2.2; carrier A-13).

Run from the repository root. Every fixture is a scratch repository or a scratch copy in a temporary directory, never
this working tree. Procedures: plan/builder/w-c00-12/11_test_register.md section 2, made concrete in
plan/builder/w-c00-12/16_tranche_1c_intent.md section 3. Prints one line per outcome, `T-xx PASS|FAIL` per test, and
`GATE 1c (deterministic part) PASS` only if every test it runs passes. The live tests of gate 1c are recorded
separately (intent section 3); this script does not claim them.
"""
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
REPO = Path.cwd().resolve()
TMP = tempfile.mkdtemp(prefix="t1c-")
RESULTS = {}


def sh(cmd, cwd, input_=None, env=None):
    e = dict(os.environ)
    e.update(env or {})
    r = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, input=input_, env=e)
    return r.returncode, r.stdout + r.stderr


def outcome(test, label, ok, detail=""):
    print(f"{'PASS' if ok else 'FAIL'}  {test} {label}" + (f": {detail[:300]}" if detail and not ok else ""))
    RESULTS.setdefault(test, []).append(ok)
    return ok


def t_m8():
    """T-M8 (M-R10): two branches each append a line to owned_ids.txt, then merge."""
    d = Path(TMP) / "m8"
    sh(["git", "clone", "-q", "--shared", str(REPO), str(d)], TMP)
    for k, v in (("user.name", "Fixture"), ("user.email", "fixture@example.invalid"), ("commit.gpgsign", "false")):
        sh(["git", "config", k, v], d)
    f = d / ".claude/hooks/owned_ids.txt"
    base = sh(["git", "rev-parse", "HEAD"], d)[1].strip()
    for br, line in (("a", "session_01FIXTUREAxxxxxxxxxxxxxx"), ("b", "session_01FIXTUREBxxxxxxxxxxxxxx")):
        sh(["git", "checkout", "-q", "-B", br, base], d)
        f.write_text(f.read_text() + line + "\n")
        sh(["git", "commit", "-qam", f"append {br}"], d)
    sh(["git", "checkout", "-q", "a"], d)
    rc, out = sh(["git", "merge", "-q", "--no-edit", "b"], d)
    text = f.read_text()
    both = "session_01FIXTUREAxxxxxxxxxxxxxx\n" in text and "session_01FIXTUREBxxxxxxxxxxxxxx\n" in text
    outcome("T-M8", "two appended recorder lines merge without conflict and both are present",
            rc == 0 and both and "<<<<<<<" not in text, out)


def clone(name):
    d = Path(TMP) / name
    sh(["git", "clone", "-q", "--shared", str(REPO), str(d)], TMP)
    for k, v in (("user.name", "Fixture"), ("user.email", "fixture@example.invalid"), ("commit.gpgsign", "false")):
        sh(["git", "config", k, v], d)
    return d


def t_r12b():
    """T-R12 (b) (R-R7): a pattern with qualified_by equal to its producer fails; a candidate row and a row qualified
    by another session pass."""
    d = clone("r12")
    f = d / "plan/builder/heritage/FAILURE_PATTERNS.md"
    t = f.read_text()
    rc, out = sh(["python3", "tools/check_records.py", "chain"], d)
    outcome("T-R12", "(b) control: the file as committed passes chain", rc == 0, out)
    row = next(l for l in t.splitlines() if l.startswith("| FP-01 |"))
    prod = row.split("|")[7].strip()
    f.write_text(t.replace(row, row.rsplit("| candidate |", 1)[0] + f"| qualified | {prod} | {prod} |"))
    rc, out = sh(["python3", "tools/check_records.py", "chain"], d)
    outcome("T-R12", "(b) FP-01 qualified by its own producer fails chain",
            rc != 0 and "FP-01 is qualified by its own producer" in out, out)
    f.write_text(t.replace(row, row.rsplit("| candidate |", 1)[0] + f"| qualified | {prod} | — |"))
    rc, out = sh(["python3", "tools/check_records.py", "chain"], d)
    outcome("T-R12", "(b) FP-01 qualified without a qualifier fails chain",
            rc != 0 and "FP-01 is qualified without a qualifier" in out, out)
    f.write_text(t.replace(row, row.rsplit("| candidate |", 1)[0] + f"| qualified | {prod} | R-W12-99 |"))
    rc, out = sh(["python3", "tools/check_records.py", "chain"], d)
    outcome("T-R12", "(b) control: FP-01 qualified by another reviewer passes chain", rc == 0, out)


def t_m17b():
    """T-M17 (b) (M-R18): the SessionStart command from .claude/settings.json, run with the script made to raise,
    prints an error line and exits 0 (the session continues); run normally it prints both clocks, the main SHA, the
    chain result and every failure pattern with its label, and no work state (the part of T-M17 (a) a script can
    show; (a) itself is read from a builder-created session's first context)."""
    import json
    cmd = json.load(open(REPO / ".claude/settings.json"))["hooks"]["SessionStart"][0]["hooks"][0]["command"]
    env = {"CLAUDE_PROJECT_DIR": str(REPO), "BOOT_MAP_FAIL_TEST": "1"}
    rc, out = sh(["sh", "-c", cmd], REPO, env=env)
    outcome("T-M17", "(b) the script made to raise prints an error line and the hook exits 0",
            rc == 0 and "BOOT_MAP ERROR" in out, out)
    rc, out = sh(["sh", "-c", cmd], REPO, env={"CLAUDE_PROJECT_DIR": str(REPO)})
    fps = [l.split("|")[1].strip() for l in (REPO / "plan/builder/heritage/FAILURE_PATTERNS.md").read_text().splitlines()
           if l.startswith("| FP-")]
    need = ["UTC;", "Turkey time", "main (last fetched origin/main", "Chain check (M-R4): "] + [f"- {f} " for f in fps]
    missing = [n for n in need if n not in out]
    labels = all(("[candidate" in l) for l in out.splitlines() if l.startswith("- FP-") and "candidate" in
                 next((r for r in (REPO / "plan/builder/heritage/FAILURE_PATTERNS.md").read_text().splitlines()
                       if r.startswith(f"| {l[2:7]} |")), ""))
    work = [w for w in ("Run lock", "frontier", "Ready (startable", "claimed_by", "W-C00-") if w in out]
    outcome("T-M17", "(a, script part) clocks, main SHA, chain result and every pattern with its label; no work state",
            rc == 0 and not missing and labels and not work, f"missing={missing} work={work}")


def t_m17_c12():
    """T-M17 (a, script part), 1c Critic finding 12: the main SHA is labelled as the last-fetched ref, and a failing
    chain check is reported by count only, so an item ID in a FAIL line cannot carry work state into the boot map."""
    d = Path(TMP) / "m17c12"
    shutil.copytree(REPO, d, ignore=shutil.ignore_patterns(".git"))
    sh(["git", "init", "-q"], d)
    (d / "tools/check_records.py").write_text('print("FAIL  [chain] W-C00-99 planted work state")\nraise SystemExit(1)\n')
    rc, out = sh([sys.executable, "tools/boot_map"], d, env={"CLAUDE_PROJECT_DIR": str(d)})
    outcome("T-M17", "(c12) a failing chain check is reported without its FAIL lines",
            "Chain check (M-R4): FAIL" in out and "W-C00-99" not in out, out)
    outcome("T-M17", "(c12) the main SHA is labelled as the last-fetched origin/main", "last fetched origin/main" in out, out)


def t_r22():
    """T-R22 (R-R3a, W-R5; N-053 a confirms that case (a2) runs): records.py brief <ID> --role verifier refuses without
    a target SHA, with a blank or unresolvable one, and with an empty failure-class list; with both, the header names
    the claims, the failure classes and the SHA. Read-only on this tree."""
    b = ["python3", "tools/records.py", "brief", "W-C00-12.4", "--role", "verifier"]
    sha = subprocess.run(["git", "rev-parse", "HEAD"], cwd=REPO, capture_output=True, text=True).stdout.strip()
    for label, extra in (("(a) without target_sha", ["--failure-classes", "x"]),
                         ("(a2) with a blank target_sha", ["--target-sha", " ", "--failure-classes", "x"]),
                         ("(a2) with a target_sha that resolves to no commit", ["--target-sha", "0" * 40, "--failure-classes", "x"]),
                         ("(b) with an empty failure_classes", ["--target-sha", sha, "--failure-classes"])):
        rc, out = sh(b + extra, REPO)
        outcome("T-R22", f"{label} refuses with an error", rc != 0 and "Task-Brief" not in out, out)
    rc, out = sh(b + ["--target-sha", sha, "--failure-classes", "class one", "class two"], REPO)
    ok = rc == 0 and f"Target SHA: {sha}" in out and "- class one" in out and "- class two" in out and \
        "Claims to test" in out and out.rstrip().splitlines()[-1].startswith("Task-Brief: W-C00-12.4 verifier ")
    outcome("T-R22", "(c) with both, the header names the claims, the failure classes and the SHA", ok, out)


def main():
    head = subprocess.run(["git", "rev-parse", "HEAD"], cwd=REPO, capture_output=True, text=True).stdout.strip()
    dirty = bool(subprocess.run(["git", "status", "--porcelain"], cwd=REPO, capture_output=True, text=True).stdout.strip())
    print(f"HEAD {head}{' (working tree DIRTY: not valid as gate evidence)' if dirty else ' (clean)'}")
    tests = [("T-M8", t_m8), ("T-R12", t_r12b), ("T-M17", t_m17b), ("T-M17", t_m17_c12), ("T-R22", t_r22)]
    for name, fn in tests:
        try:
            fn()
        except Exception as e:  # a crashing test is a failing test
            outcome(name, f"crashed: {type(e).__name__}: {e}", False)
    print("--- per test")
    ok = True
    for name, _ in tests:
        r = RESULTS.get(name, [])
        good = bool(r) and all(r)
        ok &= good
        print(f"{name} {'PASS' if good else 'FAIL'} ({sum(r)}/{len(r)} outcomes)")
    shutil.rmtree(TMP, ignore_errors=True)
    print("GATE 1c (deterministic part) PASS" if ok else "GATE 1c (deterministic part) FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
