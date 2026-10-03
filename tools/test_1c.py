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


def main():
    head = subprocess.run(["git", "rev-parse", "HEAD"], cwd=REPO, capture_output=True, text=True).stdout.strip()
    dirty = bool(subprocess.run(["git", "status", "--porcelain"], cwd=REPO, capture_output=True, text=True).stdout.strip())
    print(f"HEAD {head}{' (working tree DIRTY: not valid as gate evidence)' if dirty else ' (clean)'}")
    tests = [("T-M8", t_m8), ("T-R12", t_r12b)]
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
