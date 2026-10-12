"""T-W07-DM47: the database's high-impact path table equals plan 6.7's list, path by path, and every path in it is
class high in the merge gate (EV-C02-002 DM-47; W-C02-10 point 4). Specification: tests/C02/W-C02-07/T-W07-DM47_path_table.md.

Synthetic test data (plan Section 8 item 13): the self-test's plan text, paths and rows are made up (w07_fixture);
the real run reads only the repository's plan file, tools/merge_gate.py and the table's rows. No key, token or
password is read, held or printed: the database is reached through the libpq environment of the step that runs
this program (README section 4's hygiene), and only paths, counts and exit codes are printed.

Run, from the repository root (python3 -I; standard library only):
  python3 -I supabase/migrations/tests/w07_dm47_merge_gate_list.py < <JSON>   the migration job's devos-test step: no
      arguments, the job's one JSON object on standard input (N-255; this program reads nothing from it), the table
      read with psql in the step's own libpq environment (never a credential on the command line)
  ... --rows-file F   rows already read, one path per line
  ... --self-test     its own could-not-check cases (point 6)
With no psql or no libpq target it gives COULD NOT CHECK. It takes no publishable key and no token. Last line:
W07_DM47_MERGE_GATE_LIST PASS (n/n), FAIL (...) or COULD NOT CHECK (...) (README section 3); exit 0, 1 or 3.
The gate's high paths beyond plan 6.7's list are printed as notes, never a failure (the executor's decision on Group
C's open 1).
"""
import argparse
import importlib.util
import pathlib
import re
import shutil
import subprocess
import sys
import tempfile

sys.dont_write_bytecode = True
REPO = pathlib.Path(__file__).resolve().parents[3]
PLAN = "plan/DevOS_Kurulum_Plani.md"
NULL = "<w07-null-row>"
QUERY = ("select case when path is null then '" + NULL + "' else path::text end "
         "from devos_private.high_impact_path order by 1")


class CouldNotCheck(Exception):
    pass


def plan_paths(repo):
    """The backticked spans of plan 6.7's "High-impact path list" bullet (as tools/test_merge_gate.py's plan_list)."""
    try:
        text = (repo / PLAN).read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as e:
        raise CouldNotCheck(f"{PLAN} is missing or unreadable ({type(e).__name__})")
    sec = re.search(r"^### 6\.7 .*?(?=^#{1,3} |\Z)", text, re.M | re.S)
    bullet = sec and re.search(r"^- \*\*High-impact path list\*\*.*?(?=\n- |\n\s*\n|\n#|\Z)", sec.group(0), re.M | re.S)
    if not bullet:
        raise CouldNotCheck("no section 6.7" if not sec else "no \"High-impact path list\" bullet in section 6.7")
    paths = re.findall(r"`([^`]+)`", bullet.group(0))
    if not paths:
        raise CouldNotCheck("the bullet names no path (partial)")
    # The bullet names .github/CODEOWNERS twice ("is kept in step with it" and in the list); each path counts once.
    return list(dict.fromkeys(paths))


def gate_predicate(repo):
    """The merge gate's own class-high test of one path (tools/merge_gate.py, high_paths, the elif at its line 94)."""
    path = repo / "tools" / "merge_gate.py"
    try:
        spec = importlib.util.spec_from_file_location("w07_merge_gate", path)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        prefixes, files, dirs = mod.HIGH_PREFIXES, mod.HIGH_FILES, mod.HIGH_DIR_PATHS
    except Exception as e:  # noqa: BLE001 - any failure to read the gate is "could not check"
        raise CouldNotCheck(f"tools/merge_gate.py could not be read ({type(e).__name__})")

    def high(p):
        parts = p.split("/")
        return (p.startswith(prefixes) or p in files or parts[-1] == "CLAUDE.md" or ".claude" in parts[:-1]
                or p in dirs or parts[-1] == ".claude")
    return high, sorted(set(prefixes) | set(files))


def rows_psql():
    if shutil.which("psql") is None:
        raise CouldNotCheck("psql is not available")
    try:
        r = subprocess.run(["psql", "-X", "-A", "-t", "-q", "-v", "ON_ERROR_STOP=1", "-c", QUERY],
                           capture_output=True, text=True, timeout=60)
    except (OSError, subprocess.TimeoutExpired) as e:
        raise CouldNotCheck(f"psql did not run ({type(e).__name__})")
    if r.returncode != 0:
        raise CouldNotCheck(f"psql exited {r.returncode} (its message is not printed)")
    return [x for x in r.stdout.splitlines() if x != ""]


def rows_file(path):
    try:
        return [x for x in pathlib.Path(path).read_text(encoding="utf-8").splitlines() if x != ""]
    except (OSError, UnicodeDecodeError) as e:
        raise CouldNotCheck(f"the rows file is missing or unreadable ({type(e).__name__})")


def compare(repo, get_rows):
    """Returns (cases, notes): cases is a list of (case_id, outcome, detail), outcome ok | bad | could_not_check."""
    cases = []
    try:
        plan = plan_paths(repo)
    except CouldNotCheck as e:
        return [("DM47-plan", "could_not_check", str(e))], []
    cases.append(("DM47-plan", "ok", f"plan 6.7 lists {len(plan)}: {', '.join(plan)}"))
    try:
        rows = get_rows()
        if NULL in rows:
            raise CouldNotCheck("a row of the table has no path (partial)")
    except CouldNotCheck as e:
        cases.append(("DM47-cmp", "could_not_check", str(e)))
        rows = None
    if rows is not None:
        missing = sorted(set(plan) - set(rows))
        extra = sorted(set(rows) - set(plan))
        dup = sorted({x for x in rows if rows.count(x) > 1})
        ok = not missing and not extra and not dup
        cases.append(("DM47-cmp", "ok" if ok else "bad",
                      f"table {len(rows)} rows; on the plan's list, not in the table: {missing or 'none'}; in the table, "
                      f"not on the list: {extra or 'none'}; duplicated: {dup or 'none'}"))
    notes = []
    try:
        high, gate_list = gate_predicate(repo)
        low = [p for p in sorted(set(plan) | set(rows or [])) if not high(p)]
        cases.append(("DM47-gate", "ok" if not low else "bad",
                      f"paths of the plan's list and the table that the merge gate classes normal: {low or 'none'}"))
        beyond = [p for p in gate_list if p.rstrip("/") not in {x.rstrip("/") for x in plan}]
        notes.append(f"the merge gate also classes high, beyond plan 6.7's list (named, not a failure): {beyond}")
    except CouldNotCheck as e:
        cases.append(("DM47-gate", "could_not_check", str(e)))
    return cases, notes


def verdict(cases):
    bad = sum(1 for c in cases if c[1] == "bad")
    cnc = sum(1 for c in cases if c[1] == "could_not_check")
    n = len(cases)
    if bad:
        return f"FAIL ({bad} bad, {cnc} could not check, of {n})", 1
    if cnc or not n:
        return f"COULD NOT CHECK ({cnc} of {n} could not be checked)", 3
    return f"PASS ({n}/{n})", 0


SYN_PLAN = ("# W07 synthetic plan\n\n### 6.7 Trust boundaries\n\n"
            "- **High-impact path list** (PC-08): synthetic: `CLAUDE.md`, `.claude/`, `w07_fixture/`, and the code of a "
            "w07_fixture channel once it exists.\n- **Other bullet**: none.\n\n### 6.8 Next\n")
SYN_ROWS = ["CLAUDE.md", ".claude/", "w07_fixture/"]


def self_test():
    """Point 6: missing, unreadable and partial inputs give could not check, apart from clean and from fail."""
    def run(name, want, plan_text, rows, plan_as_dir=False):
        with tempfile.TemporaryDirectory(prefix="w07_dm47_") as d:
            root = pathlib.Path(d)
            (root / "plan").mkdir()
            if plan_as_dir:
                (root / PLAN).mkdir()
            elif plan_text is not None:
                (root / PLAN).write_text(plan_text, encoding="utf-8")
            (root / "tools").mkdir()
            shutil.copy(REPO / "tools" / "merge_gate.py", root / "tools" / "merge_gate.py")

            def get_rows():
                if isinstance(rows, Exception):
                    raise rows
                return rows
            cases, _ = compare(root, get_rows)
        got = {c[0]: c[1] for c in cases}
        cmp_out = got.get("DM47-cmp", got.get("DM47-plan"))
        kind = {"ok": "clean", "bad": "fail", "could_not_check": "could_not_check"}[cmp_out]
        print(f"{name} | {'ok' if kind == want else 'bad'} | wanted {want}, got {kind}: {cases}")
        return kind == want, kind
    plan_no_bullet = SYN_PLAN.replace("- **High-impact path list**", "- **Some other list**")
    plan_no_path = re.sub(r"`[^`]+`", "a path", SYN_PLAN)
    checks = [
        ("DM47-st-control", "clean", SYN_PLAN, SYN_ROWS, False),
        ("DM47-st-plan-missing", "could_not_check", None, SYN_ROWS, False),
        ("DM47-st-plan-unreadable", "could_not_check", None, SYN_ROWS, True),
        ("DM47-st-plan-partial-no-bullet", "could_not_check", plan_no_bullet, SYN_ROWS, False),
        ("DM47-st-plan-partial-no-path", "could_not_check", plan_no_path, SYN_ROWS, False),
        ("DM47-st-rows-unreadable", "could_not_check", SYN_PLAN, CouldNotCheck("synthetic: psql exited 2"), False),
        ("DM47-st-rows-partial", "could_not_check", SYN_PLAN, SYN_ROWS + [NULL], False),
        ("DM47-st-rows-extra", "fail", SYN_PLAN, SYN_ROWS + ["w07_fixture_other/"], False),
        ("DM47-st-rows-missing", "fail", SYN_PLAN, SYN_ROWS[:2], False),
        ("DM47-st-rows-empty", "fail", SYN_PLAN, [], False),
    ]
    results = [run(*c) for c in checks]
    seen = {k: sum(1 for _, g in results if g == k) for k in ("clean", "fail", "could_not_check")}
    print(f"answers seen, denominator {len(results)}: clean {seen['clean']}, fail {seen['fail']}, "
          f"could not check {seen['could_not_check']}")
    bad = sum(1 for ok, _ in results if not ok)
    if bad:
        print(f"W07_DM47_MERGE_GATE_LIST self-test FAIL ({bad} of {len(results)} not as wanted)")
        return 1
    print(f"W07_DM47_MERGE_GATE_LIST self-test PASS ({len(results)}/{len(results)})")
    return 0


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    src = ap.add_mutually_exclusive_group()
    src.add_argument("--psql", action="store_true", help="read the table with psql in the step's libpq environment (the default)")
    src.add_argument("--rows-file", help="read the table's rows from a file, one path per line")
    src.add_argument("--self-test", action="store_true", help="run the could-not-check self-test")
    ap.add_argument("--repo", default=str(REPO), help="the repository root (default: this file's repository)")
    a = ap.parse_args(argv)
    if a.self_test:
        return self_test()
    if a.rows_file:
        def get_rows():
            return rows_file(a.rows_file)
    else:  # the job's run (N-255): psql in the step's own libpq environment
        get_rows = rows_psql
    cases, notes = compare(pathlib.Path(a.repo), get_rows)
    for c in cases:
        print(" | ".join(c))
    for n in notes:
        print("note | " + n)
    line, code = verdict(cases)
    print(f"W07_DM47_MERGE_GATE_LIST {line}")
    return code


if __name__ == "__main__":
    sys.exit(main())
