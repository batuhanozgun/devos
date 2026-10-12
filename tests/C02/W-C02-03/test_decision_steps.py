#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): every input below is made up for this test and holds no
# personal or business data and no credential: the versions 2999..., the names w03_fixture_*, the slugs w03-fixture-*,
# the hashes made of one repeated hex digit, the commits, the listings and the changed-file lists. Not made up, because
# the rules under test name them: DevOS's workflow paths, job, step and environment names (EV-C02-001 "Names"), the
# path supabase/migrations/, and deployment_drift's result kinds (EV-C02-001 section 4; Appendix B section 4).
"""test_decision_steps.py: W-C02-03 points 6, 7 and 14; tests/C02/W-C02-03/T-W03-DEC_decision_steps.md.

Runs the code the migration workflows run for three decisions, fed synthetic inputs, and checks each output:
  decide      job `devos` of .github/workflows/migrate.yml, step id `decide`: section 5's step (5) result and the
              first-migration exception's three reads decide "apply" or "skip, with reason" (EV-C02-001 M07, M16,
              section 5, section 10 point 6);
  crosscheck  optional, the same job, step id `crosscheck`: O3's dry-run cross-check, tested only if the build adopts O3;
  pr_decide   .github/workflows/migration-checks.yml, step id `pr_decide`: what the pull-request check stops (M16).
"The code the workflow runs" (EV-C02-001 section 10 point 6): the step's own `run` body when its `shell` is `python`,
or, when its `run` is a single line `python3 [-I] <path>` with <path> on a class-high path (tools/merge_gate.py's
HIGH_PREFIXES), that file. Inputs reach the step only through its `env:` mapping; outputs go to $GITHUB_OUTPUT.
The interface is stated in T-W03-DEC_decision_steps.md, section "Interface".

Options:
  --repo PATH            repository root (default: three levels above this file)
  --impl STEP=FILE       run FILE instead of STEP's code (a break copy, EV-C02-001 section 10 point 6); the static
                         checks of that step's wiring are then still made on the workflow if it exists
  --self-check           run this test against generated programs that are wrong by construction (always apply,
                         never apply, crash) and against a repository without the workflow: shows that the test turns
                         red and reports "could not check" without the build; it holds no decision logic
Output: one line per case ("ok", "BAD", "CNC" for could not check, "n/a"), then one final line:
  W03_DECISION_TEST PASS (n/n) exit 0 | W03_DECISION_TEST FAIL (...) exit 1 | W03_DECISION_TEST COULD NOT CHECK (...) exit 3
  With --impl the final line begins "W03_DECISION_TEST (break-copy run)" and names the files run instead of the
  workflow's code, so it is never a result of the build.
The report line of `decide` is checked as T-W03-DEC "Interface" item 3 states: "taken" with the three reads' results
and the table state it saw (no table, or an empty table), "not taken" with the name of the state that kept it from
being taken.
The first-migration exception is tested as EV-C02-001 section 5 states it after its change on P13 (the executor's
decision of 2026-10-12; T-W03-DEC "Depends on"): taken with the function absent, the history table absent or present
and holding no row, and a clean listing, all read completely in one snapshot; every other state "could not check".
A read whose fields disagree, the history table reported absent with a row count given (0 included), is "could not
check" and names history_rows; the table absent with the row count null is read as before (the executor's decision
of 2026-10-12, E25 and E26; T-W03-DEC "Depends on").
"""
import json
import os
import re
import shlex
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True

MIGRATE = ".github/workflows/migrate.yml"
CHECKS = ".github/workflows/migration-checks.yml"
HIGH_PREFIXES = (".claude/", "tools/", ".github/workflows/", "methods/", "supabase/migrations/", "supabase/functions/",
                 "pipelines/")
DECIDE_ENV = ("GO", "FM_READS", "DRIFT_CALL", "DRIFT_RESULT", "EXPECTED")
CROSS_ENV = ("PENDING", "DRY_RUN")
PR_ENV = ("CHANGED", "RUN_REPORT", "MAIN_HEAD")

# ---- synthetic fixtures -------------------------------------------------------------------------------------------
COMMIT = "a3" * 20
OTHER_COMMIT = "b4" * 20
V1, V2, V3 = "29990101000001", "29990101000002", "29990101000003"
EXPECTED = {"commit": COMMIT,
            "migrations": [{"version": V1, "name": "w03_fixture_alpha"}, {"version": V2, "name": "w03_fixture_beta"}],
            "functions": []}
LISTING_DEVOS = ["schema devos_api", "schema devos_private", "function devos_api.deployment_drift(jsonb)",
                 "table devos_private.function_deployment"]


def reads(function_exists, table, listing, snapshot="one_statement", complete=True, rows=None, drop=None):
    d = {"complete": complete, "snapshot": snapshot, "function_exists": function_exists,
         "history_table_exists": table, "history_rows": rows, "listing": listing}
    if drop:
        d.pop(drop)
    return json.dumps(d)


PUSHED = reads(True, True, LISTING_DEVOS, rows=1)
NEVER = reads(False, False, [])
EMPTY_TABLE = reads(False, True, [], rows=0)  # what a failed first apply leaves (P13): the history table, no row


def result(status, diffs, complete=True, drop=None):
    d = {"status": status, "complete": complete, "differences": diffs,
         "compared": {"migrations_expected": 2, "migrations_applied": 1, "functions_expected": 0,
                      "functions_recorded": 0}}
    if drop:
        d.pop(drop)
    return json.dumps(d)


def diff(kind, key):
    return {"kind": kind, ("slug" if kind.startswith("function_") else "version"): key}


R_PENDING = result("differences", [diff("on_main_not_applied", V2)])
R_NODIFF = result("no_difference", [])
R_CNC = result("could_not_check", [], complete=False)


def kind_result(kind, key=V3):
    return result("differences", [diff(kind, key)])


# The report line (EV-C02-001 section 5, "The report says when it was taken"; T-W03-DEC "Interface" item 3).
# "taken" must carry the three reads' results, each as <field>=<value> or "<field>": <value> (case-insensitive), and
# so name which of the two table states it saw (EV-C02-001 section 5 as changed after P13): no table, or an empty one.
# The check reads the same field names as the "not taken" check below.
TAKEN_READS = {
    "no table": (("function_exists", r"false"), ("history_table_exists", r"false"), ("listing", r"\[\s*\]")),
    "empty table": (("function_exists", r"false"), ("history_table_exists", r"true"), ("history_rows", r"0(?![0-9.])"),
                    ("listing", r"\[\s*\]")),
}
TAKEN_SHOWN = {"no table": "function_exists=false, history_table_exists=false, listing=[]",
               "empty table": "function_exists=false, history_table_exists=true, history_rows=0, listing=[]"}
TAKEN_STATE = {"E05": "empty table", "E20": "empty table", "E21": "empty table"}  # the other "taken" cases: no table
# "not taken" must name the state that kept it from being taken, by the name of the input or read field that shows
# it (case-insensitive). Cases not listed have the function present (FM_READS says so), so any of the three reads'
# names is a true account of that state.
FUNCTION_PRESENT = ("function_exists", "history_table_exists", "listing")
NOT_TAKEN_STATE = {"E04": ("history_table_exists", "history_rows"),
                   "E06": ("function_exists", "history_table_exists"), "E06b": ("function_exists",
                                                                                "history_table_exists"),
                   "E07": ("function_exists", "history_table_exists"), "E08": ("listing",), "E09": ("listing",),
                   "E10": ("complete",), "E11": ("snapshot",), "E12": ("snapshot",), "E13": ("fm_reads",),
                   "E14": ("fm_reads",), "E15": ("function_exists",), "E16": ("history_table_exists",),
                   "E17": ("listing",), "E18": ("drift_call", "drift_result"), "E19": ("expected",),
                   "E22": ("history_rows",), "E23": ("history_rows",), "E24": ("listing",),
                   "E25": ("history_rows",), "E26": ("history_rows",)}


def report_line_problems(cid, want_exc, stdout):
    lines = [ln for ln in stdout.splitlines() if "first-migration exception:" in ln]
    taken = [ln for ln in lines if "first-migration exception: taken" in ln]
    not_taken = [ln for ln in lines if "first-migration exception: not taken" in ln]
    if want_exc == "taken":
        if not taken or not_taken:
            return ["stdout lacks the report line 'first-migration exception: taken' (or also says 'not taken')"]
        state = TAKEN_STATE.get(cid, "no table")
        if not any(all(re.search(rf"{f}[\"']?\s*[=:]\s*{v}", ln, re.I) for f, v in TAKEN_READS[state])
                   for ln in taken):
            return [f"the 'taken' line does not carry the three reads' results for the {state} state "
                    f"({TAKEN_SHOWN[state]})"]
        return []
    if not not_taken or taken:
        return ["stdout lacks the report line 'first-migration exception: not taken' (or also says 'taken')"]
    names = NOT_TAKEN_STATE.get(cid, FUNCTION_PRESENT)
    if not any(n in ln.lower() for ln in not_taken for n in names):
        return [f"the 'not taken' line does not name the state that kept it from being taken ({' or '.join(names)})"]
    return []


# decide cases: (id, what, env, expected apply, expected result_kind or None, expected exception)
# result_kind None: any of the three kinds is accepted (the apply and the exception still are checked).
def decide_cases():
    c = []
    ok = dict(GO="yes", FM_READS=PUSHED, DRIFT_CALL="ok", EXPECTED=json.dumps(EXPECTED))

    def add(cid, what, apply, kind, exc, **env):
        e = dict(ok)
        e.update(env)
        c.append((cid, what, e, apply, kind, exc))
    # deployment_drift exists: (5) is its result (M07)
    add("D01", "positive control: only 'on main, not applied', go=yes", "yes", "differences", "not_taken",
        DRIFT_RESULT=R_PENDING)
    add("D02", "only pending, devos-test go=no", "no", None, "not_taken", DRIFT_RESULT=R_PENDING, GO="no")
    add("D03", "only pending, devos-test go empty (job failed before setting it)", "no", None, "not_taken",
        DRIFT_RESULT=R_PENDING, GO="")
    add("D04", "only pending, devos-test go=superseded", "no", None, "not_taken", DRIFT_RESULT=R_PENDING,
        GO="superseded")
    add("D05", "no difference: nothing to apply", "no", "no_difference", "not_taken", DRIFT_RESULT=R_NODIFF)
    add("D06", "applied and not on main (break target: a copy that applies on it)", "no", "differences",
        "not_taken", DRIFT_RESULT=kind_result("applied_not_on_main"))
    add("D07", "name differs", "no", "differences", "not_taken", DRIFT_RESULT=kind_result("name_differs", V1))
    add("D08", "function missing", "no", "differences", "not_taken",
        DRIFT_RESULT=kind_result("function_missing", "w03-fixture-fn"))
    add("D09", "function extra", "no", "differences", "not_taken",
        DRIFT_RESULT=kind_result("function_extra", "w03-fixture-fn"))
    add("D10", "function differs", "no", "differences", "not_taken",
        DRIFT_RESULT=kind_result("function_differs", "w03-fixture-fn"))
    add("D11", "pending plus applied-not-on-main", "no", "differences", "not_taken",
        DRIFT_RESULT=result("differences", [diff("on_main_not_applied", V2), diff("applied_not_on_main", V3)]))
    add("D12", "an unknown difference kind", "no", None, "not_taken",
        DRIFT_RESULT=kind_result("w03_fixture_unknown_kind"))
    add("D13", "result 'could not check'", "no", "could_not_check", "not_taken", DRIFT_RESULT=R_CNC)
    add("D14", "the call raised an error", "no", "could_not_check", "not_taken", DRIFT_CALL="error",
        DRIFT_RESULT="")
    add("D15", "the call timed out or the connection was cut", "no", "could_not_check", "not_taken",
        DRIFT_CALL="timeout", DRIFT_RESULT="")
    add("D16", "call ok, result empty", "no", "could_not_check", "not_taken", DRIFT_RESULT="")
    add("D17", "result not JSON", "no", "could_not_check", "not_taken", DRIFT_RESULT='{"status": "differences"')
    add("D18", "result not an object", "no", "could_not_check", "not_taken", DRIFT_RESULT="[]")
    add("D19", "completeness flag absent", "no", "could_not_check", "not_taken",
        DRIFT_RESULT=result("differences", [diff("on_main_not_applied", V2)], drop="complete"))
    add("D20", "completeness flag false", "no", "could_not_check", "not_taken",
        DRIFT_RESULT=result("differences", [diff("on_main_not_applied", V2)], complete=False))
    add("D21", "'no difference' with a non-empty list", "no", "could_not_check", "not_taken",
        DRIFT_RESULT=result("no_difference", [diff("on_main_not_applied", V2)]))
    add("D22", "'differences' with an empty list", "no", "could_not_check", "not_taken",
        DRIFT_RESULT=result("differences", []))
    add("D23", "status absent", "no", "could_not_check", "not_taken",
        DRIFT_RESULT=result("differences", [diff("on_main_not_applied", V2)], drop="status"))
    add("D24", "function exists but the call was not made", "no", "could_not_check", "not_taken",
        DRIFT_CALL="not_called", DRIFT_RESULT="")
    # deployment_drift absent: the first-migration exception (section 5)
    nc = dict(DRIFT_CALL="not_called", DRIFT_RESULT="")
    add("E01", "positive control: never-pushed state, one statement (R6 form 1)", "yes", None, "taken",
        FM_READS=NEVER, **nc)
    add("E02", "positive control: never-pushed state, read-only REPEATABLE READ transaction (R6 form 2)", "yes",
        None, "taken", FM_READS=reads(False, False, [], snapshot="repeatable_read_transaction"), **nc)
    add("E03", "never-pushed state but devos-test go=no", "no", None, "taken", FM_READS=NEVER, GO="no", **nc)
    add("E04", "history table holding a row, no function (breaks: without the table check; a copy that takes a "
        "table holding a row)", "no", "could_not_check", "not_taken", FM_READS=reads(False, True, [], rows=1), **nc)
    add("E05", "positive control: history table empty, no function, listing clean, one statement (section 5 as "
        "changed after P13)", "yes", None, "taken", FM_READS=EMPTY_TABLE, **nc)
    add("E06", "function present, table absent, listing clean, the function answers 'could not check' "
        "(break: without the function check)", "no", "could_not_check", "not_taken",
        FM_READS=reads(True, False, []), DRIFT_CALL="ok", DRIFT_RESULT=R_CNC)
    add("E06b", "function present, table absent, listing clean, no call made (break: without the function check, "
        "even where another guard refuses a call made while the reads say 'no function')", "no", "could_not_check",
        "not_taken", FM_READS=reads(True, False, []), **nc)
    add("E07", "function present, table absent, listing clean, the call errors", "no", "could_not_check",
        "not_taken", FM_READS=reads(True, False, []), DRIFT_CALL="error", DRIFT_RESULT="")
    add("E08", "a schema in the listing (break: without the listing check)", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, ["schema w03_fixture_schema"]), **nc)
    add("E09", "a role in the listing", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, ["role w03_fixture_role"]), **nc)
    add("E10", "reads incomplete", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, [], complete=False), **nc)
    add("E11", "reads not taken in one snapshot", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, [], snapshot=None), **nc)
    add("E12", "snapshot form unknown", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, [], snapshot="w03_fixture_other"), **nc)
    add("E13", "reads absent", "no", "could_not_check", "not_taken", FM_READS="", **nc)
    add("E14", "reads not JSON", "no", "could_not_check", "not_taken", FM_READS='{"complete": true', **nc)
    add("E15", "the function read missing", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, [], drop="function_exists"), **nc)
    add("E16", "the table read missing", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, [], drop="history_table_exists"), **nc)
    add("E17", "the listing failed (null)", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, None), **nc)
    add("E18", "reads say no function but a call returned a result (contradiction)", "no", "could_not_check",
        "not_taken", FM_READS=NEVER, DRIFT_CALL="ok", DRIFT_RESULT=R_PENDING)
    add("E19", "never-pushed state but expected malformed", "no", "could_not_check", "not_taken",
        FM_READS=NEVER, EXPECTED='{"commit": 1}', **nc)
    # the empty history table (EV-C02-001 section 5 as changed after P13; T-W03-DEC "Depends on")
    add("E20", "positive control: history table empty, no function, listing clean, read-only REPEATABLE READ "
        "transaction (R6 form 2)", "yes", None, "taken",
        FM_READS=reads(False, True, [], rows=0, snapshot="repeatable_read_transaction"), **nc)
    add("E21", "history table empty, no function, listing clean, but devos-test go=no", "no", None, "taken",
        FM_READS=EMPTY_TABLE, GO="no", **nc)
    add("E22", "history table present, its row count not read (null)", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, True, [], rows=None), **nc)
    add("E23", "history table present, the row-count read missing", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, True, [], rows=0, drop="history_rows"), **nc)
    add("E24", "history table empty, no function, but a schema in the listing", "no", "could_not_check",
        "not_taken", FM_READS=reads(False, True, ["schema w03_fixture_schema"], rows=0), **nc)
    # a read whose fields disagree (the executor's decision of 2026-10-12; T-W03-DEC "Depends on")
    add("E25", "reads disagree: history table reported absent with a row count of 3, no function, listing clean "
        "(break: a copy that ignores the row count when the table is absent)", "no", "could_not_check", "not_taken",
        FM_READS=reads(False, False, [], rows=3), **nc)
    add("E26", "reads disagree: history table reported absent with a row count of 0, no function, listing clean",
        "no", "could_not_check", "not_taken", FM_READS=reads(False, False, [], rows=0), **nc)
    return c


def cross_cases():
    s = json.dumps
    return [("X01", "dry run equals the pending list", {"PENDING": s([V1, V2]), "DRY_RUN": s([V1, V2])}, "yes"),
            ("X02", "same set, other order", {"PENDING": s([V2, V1]), "DRY_RUN": s([V1, V2])}, "yes"),
            ("X03", "dry run lists one more", {"PENDING": s([V2]), "DRY_RUN": s([V1, V2])}, "no"),
            ("X04", "dry run lists one fewer", {"PENDING": s([V1, V2]), "DRY_RUN": s([V2])}, "no"),
            ("X05", "dry run empty", {"PENDING": s([V2]), "DRY_RUN": s([])}, "no"),
            ("X06", "dry run not JSON", {"PENDING": s([V2]), "DRY_RUN": "[29990101"}, "no"),
            ("X07", "pending absent", {"PENDING": "", "DRY_RUN": s([V2])}, "no")]


def report(dt, dv, commit=COMMIT, completed=True, drop=None):
    projects = {"devos-test": dt, "devos": dv}
    if drop:
        projects.pop(drop)
    return json.dumps({"commit": commit, "completed": completed, "projects": projects})


def proj(result_kind, applied, diffs=()):
    return {"result": result_kind, "applied_versions": list(applied), "differences": list(diffs)}


CLEAN = report(proj("no_difference", [V1, V2]), proj("no_difference", [V1, V2]))
UNAPPLIED_BOTH = report(proj("differences", [V1], [diff("on_main_not_applied", V2)]),
                        proj("differences", [V1], [diff("on_main_not_applied", V2)]))
ONE_NOT_OTHER = report(proj("no_difference", [V1, V2]), proj("differences", [V1], [diff("on_main_not_applied", V2)]))
MIG2 = f"supabase/migrations/{V2}_w03_fixture_beta.sql"
MIG3 = f"supabase/migrations/{V3}_w03_fixture_gamma.sql"


def ch(*items):
    return json.dumps([dict(path=p, status=s) if not o else dict(path=p, status=s, old_path=o) for p, s, o in items])


# pr_decide cases: (id, what, env, expected verdict, text that must appear in the state or stdout, or None)
def pr_cases():
    base = {"MAIN_HEAD": COMMIT}

    def e(changed, rep):
        d = dict(base)
        d.update(CHANGED=changed, RUN_REPORT=rep)
        return d
    return [
        ("P01", "positive control: adds a migration, records clean", e(ch((MIG3, "A", None)), CLEAN), "pass", None),
        ("P02", "adds a migration, no completed run (could not check is shown, not blocking)",
         e(ch((MIG3, "A", None)), ""), "pass", "could not check"),
        ("P03", "adds a migration while devos lacks V2: the state names it", e(ch((MIG3, "A", None)), ONE_NOT_OTHER),
         "pass", V2),
        ("P04", "changes a migration applied in both", e(ch((MIG2, "M", None)), CLEAN), "fail", None),
        ("P05", "changes a migration applied in devos-test only", e(ch((MIG2, "M", None)), ONE_NOT_OTHER), "fail",
         None),
        ("P06", "positive control: changes a migration shown unapplied in both", e(ch((MIG2, "M", None)),
                                                                                    UNAPPLIED_BOTH), "pass", None),
        ("P07", "changes a migration, no run report", e(ch((MIG2, "M", None)), ""), "fail", None),
        ("P08", "changes a migration, report lacks devos (break: skips a project)",
         e(ch((MIG2, "M", None)), report(proj("differences", [V1], [diff("on_main_not_applied", V2)]), None,
                                         drop="devos")), "fail", None),
        ("P09", "changes a migration, report at another commit",
         e(ch((MIG2, "M", None)), report(proj("differences", [V1]), proj("differences", [V1]), commit=OTHER_COMMIT)),
         "fail", None),
        ("P10", "changes a migration, run not completed",
         e(ch((MIG2, "M", None)), report(proj("differences", [V1]), proj("differences", [V1]), completed=False)),
         "fail", None),
        ("P11", "deletes a migration applied in both", e(ch((MIG2, "D", None)), CLEAN), "fail", None),
        ("P12", "renames a migration applied in both", e(ch((MIG3, "R", MIG2)), CLEAN), "fail", None),
        ("P13", "positive control: changes a database test, not a migration",
         e(ch(("supabase/migrations/tests/w03_fixture_test.sql", "M", None)), CLEAN), "pass", None),
        ("P14", "positive control: unrelated change while devos differs: passes and names it",
         e(ch(("docs/w03_fixture.md", "M", None)), ONE_NOT_OTHER), "pass", V2),
        ("P15", "changes a migration, report not JSON", e(ch((MIG2, "M", None)), '{"commit": '), "fail", None),
        ("P16", "changes a migration unapplied in both, but devos-test could not check",
         e(ch((MIG2, "M", None)), report(proj("could_not_check", []), proj("differences", [V1],
                                                                            [diff("on_main_not_applied", V2)]))),
         "fail", None),
    ]


# ---- harness -------------------------------------------------------------------------------------------------------
LINES = []
COUNT = {"ok": 0, "bad": 0, "cnc": 0}


def say(tag, label, detail=""):
    COUNT[{"ok": "ok", "BAD": "bad", "CNC": "cnc"}.get(tag, "ok")] += tag in ("ok", "BAD", "CNC")
    line = f"{tag:<4} {label}" + (f": {detail}" if detail else "")
    LINES.append(line)
    print(line)


def load_yaml(path):
    import yaml  # noqa: imported here so that its absence is a "could not check", not a crash
    with open(path, encoding="utf-8") as f:
        return yaml.safe_load(f)


def find_step(wf, step_id, job=None):
    jobs = (wf or {}).get("jobs") or {}
    names = [job] if job else list(jobs)
    for name in names:
        for st in (jobs.get(name) or {}).get("steps") or []:
            if isinstance(st, dict) and st.get("id") == step_id:
                return name, st
    return None, None


def code_of(repo, step):
    """The code the step runs: its python body, or the class-high file its one-line run names. (code, why-not)."""
    run = step.get("run")
    if not isinstance(run, str):
        return None, "the step has no run body"
    if step.get("shell") == "python":
        if "${{" in run:
            return None, "the run body holds a ${{ }} expression (inputs must come through env)"
        return run, None
    words = shlex.split(run.strip()) if "\n" not in run.strip() else []
    if len(words) in (2, 3) and words[0] == "python3" and (len(words) == 2 or words[1] == "-I"):
        rel = words[-1]
        if not rel.startswith(HIGH_PREFIXES) or ".." in rel.split("/"):
            return None, f"{rel} is not on a class-high path"
        p = repo / rel
        if not p.is_file():
            return None, f"{rel} does not exist"
        return p.read_text(encoding="utf-8"), None
    return None, "the step is neither shell: python nor a one-line python3 <class-high file>"


def wiring(step, needed, label, go_expr=None):
    env = step.get("env") or {}
    bad = [k for k in needed if k not in env]
    if bad:
        say("BAD", f"{label} wiring", f"env lacks {bad}")
        return False
    if any("secrets." in str(v) for v in env.values()):
        say("BAD", f"{label} wiring", "the step's env names a secret (M21: the deciding step holds none)")
        return False
    if go_expr and go_expr not in str(env.get("GO")):
        say("BAD", f"{label} wiring", f"GO is not taken from {go_expr}")
        return False
    say("ok", f"{label} wiring", f"env names {list(needed)}; no secret")
    return True


def parse_output(text):
    out, lines, i = {}, text.splitlines(), 0
    while i < len(lines):
        ln = lines[i]
        m = re.match(r"^([A-Za-z_][A-Za-z0-9_-]*)<<(.+)$", ln)
        if m:
            name, delim, buf = m.group(1), m.group(2), []
            i += 1
            while i < len(lines) and lines[i] != delim:
                buf.append(lines[i])
                i += 1
            out[name] = "\n".join(buf)
        elif "=" in ln:
            k, v = ln.split("=", 1)
            out[k.strip()] = v.strip()
        i += 1
    return out


def run_code(code, env_in):
    with tempfile.TemporaryDirectory(prefix="w03dec-") as d:
        prog, outf = Path(d, "step.py"), Path(d, "github_output")
        prog.write_text(code, encoding="utf-8")
        outf.write_text("", encoding="utf-8")
        env = {"PATH": os.environ.get("PATH", "/usr/bin:/bin"), "GITHUB_OUTPUT": str(outf), "LANG": "C.UTF-8"}
        env.update(env_in)
        try:
            r = subprocess.run([sys.executable, "-I", str(prog)], env=env, cwd=d, capture_output=True, text=True,
                               timeout=60)
        except subprocess.TimeoutExpired:
            return None, "", "timeout"
        return parse_output(outf.read_text(encoding="utf-8")), r.stdout, f"exit {r.returncode}"


def check_decide(code):
    for cid, what, env, want_apply, want_kind, want_exc in decide_cases():
        out, stdout, how = run_code(code, env)
        if out is None:
            say("BAD", f"{cid} {what}", "the step did not finish")
            continue
        problems = []
        if out.get("apply") != want_apply:
            problems.append(f"apply={out.get('apply')!r}, wanted {want_apply!r}")
        kind = out.get("result_kind")
        if kind not in ("no_difference", "differences", "could_not_check"):
            problems.append(f"result_kind={kind!r} is not one of the three outcomes")
        elif want_kind and kind != want_kind:
            problems.append(f"result_kind={kind!r}, wanted {want_kind!r}")
        if out.get("exception") != want_exc:
            problems.append(f"exception={out.get('exception')!r}, wanted {want_exc!r}")
        problems += report_line_problems(cid, want_exc, stdout)
        if not out.get("reason"):
            problems.append("no reason output")
        if out.get("apply") == "yes" and "pending" in out:
            want_p = [V1, V2] if cid.startswith("E") else [V2]
            try:
                if sorted(json.loads(out["pending"])) != want_p:
                    problems.append(f"pending={out['pending']}, wanted {want_p}")
            except ValueError:
                problems.append("pending is not JSON")
        say("BAD" if problems else "ok", f"{cid} {what}", "; ".join(problems) or f"{how}; reason: {out['reason'][:80]}")


def check_cross(code):
    for cid, what, env, want in cross_cases():
        out, _, how = run_code(code, env)
        got = (out or {}).get("apply")
        say("ok" if got == want else "BAD", f"{cid} {what}", f"apply={got!r}, wanted {want!r}; {how}")


def check_pr(code):
    for cid, what, env, want, must_name in pr_cases():
        out, stdout, how = run_code(code, env)
        out = out or {}
        problems = []
        if out.get("verdict") != want:
            problems.append(f"verdict={out.get('verdict')!r}, wanted {want!r}")
        shown = (out.get("state") or "") + "\n" + stdout
        if must_name and must_name not in shown:
            problems.append(f"the state does not name {must_name!r}")
        say("BAD" if problems else "ok", f"{cid} {what}", "; ".join(problems) or how)


def target(repo, wf_path, job, step_id, needed, label, impl, checker, required=True, go_expr=None):
    """Find, wire-check and run one step. Returns 'ran', 'cnc' or 'n/a'."""
    wf = None
    if (repo / wf_path).is_file():
        try:
            wf = load_yaml(repo / wf_path)
        except ImportError:
            say("CNC", f"{label}", "PyYAML is not installed, so the workflow cannot be read")
            return "cnc"
        except Exception as exc:  # a workflow that does not parse is the build's defect, shown, not hidden
            say("BAD", f"{label}", f"{wf_path} does not parse: {type(exc).__name__}")
            return "ran"
    step = find_step(wf, step_id, job)[1] if wf else None
    if step is not None:
        wiring(step, needed, label, go_expr)
    if impl:
        say("n/a", f"{label}", f"running {impl} instead of the workflow's code (a break copy)")
        checker(Path(impl).read_text(encoding="utf-8"))
        return "ran"
    if wf is None:
        if required:
            say("CNC", f"{label}", f"{wf_path} is absent (the build has not added it)")
            return "cnc"
        return "n/a"
    if step is None:
        if required:
            say("CNC", f"{label}", f"no step with id {step_id!r}" + (f" in job {job!r}" if job else ""))
            return "cnc"
        say("n/a", f"{label}", f"no step {step_id!r}: O3 not adopted, nothing to test")
        return "n/a"
    code, why = code_of(repo, step)
    if code is None:
        say("CNC", f"{label}", f"cannot run the step's own code: {why}")
        return "cnc"
    checker(code)
    return "ran"


def main(argv):
    repo = Path(__file__).resolve().parents[3]
    impls = {}
    args = list(argv)
    while args:
        a = args.pop(0)
        if a == "--repo":
            repo = Path(args.pop(0)).resolve()
        elif a == "--impl":
            k, _, v = args.pop(0).partition("=")
            impls[k] = v
        elif a == "--self-check":
            return self_check()
        else:
            print(f"unknown argument {a}")
            return 2
    states = [target(repo, MIGRATE, "devos", "decide", DECIDE_ENV, "decide (devos job)", impls.get("decide"),
                     check_decide, go_expr="needs.devos-test.outputs.go"),
              target(repo, MIGRATE, "devos", "crosscheck", CROSS_ENV, "crosscheck (O3)", impls.get("crosscheck"),
                     check_cross, required=False),
              target(repo, CHECKS, None, "pr_decide", PR_ENV, "pr_decide (pull-request check)",
                     impls.get("pr_decide"), check_pr)]
    n = COUNT["ok"] + COUNT["bad"] + COUNT["cnc"]
    # Under --impl the line names the break-copy run, so it cannot be filed as the build's result (CHK-C02-017 Rf1).
    head = "W03_DECISION_TEST" + (" (break-copy run)" if impls else "")
    tail = (f"; {', '.join(f'{k}={v}' for k, v in sorted(impls.items()))} ran instead of the workflow's code; "
            f"not a result of the build") if impls else ""
    if COUNT["bad"]:
        print(f"{head} FAIL ({COUNT['bad']} bad, {COUNT['cnc']} could not check, of {n}{tail})")
        return 1
    if COUNT["cnc"] or "cnc" in states:
        print(f"{head} COULD NOT CHECK ({COUNT['cnc']} of {n} could not be checked; none passed in "
              f"their place{tail})")
        return 3
    print(f"{head} PASS ({COUNT['ok']}/{n}{tail})")
    return 0


def self_check():
    """Wrong-by-construction programs must turn the test red; a repository without the workflow must give CNC."""
    always_apply = ("import os\nwith open(os.environ['GITHUB_OUTPUT'],'a') as f:\n"
                    " f.write('apply=yes\\nresult_kind=differences\\nexception=taken\\nreason=w03 fixture\\n')\n"
                    "print('first-migration exception: taken')\n")
    never_apply = ("import os\nwith open(os.environ['GITHUB_OUTPUT'],'a') as f:\n"
                   " f.write('apply=no\\nresult_kind=could_not_check\\nexception=not_taken\\nreason=w03 fixture\\n')\n"
                   "print('first-migration exception: not taken (w03 fixture)')\n")
    crash = "raise SystemExit(1)\n"
    pr_pass = ("import os\nwith open(os.environ['GITHUB_OUTPUT'],'a') as f:\n f.write('verdict=pass\\nstate=x\\n')\n")
    pr_fail = ("import os\nwith open(os.environ['GITHUB_OUTPUT'],'a') as f:\n f.write('verdict=fail\\nstate=x\\n')\n")
    me = Path(__file__).resolve()
    results = []
    with tempfile.TemporaryDirectory(prefix="w03self-") as d:
        empty = Path(d, "repo")
        empty.mkdir()
        for name, code, step in (("always apply", always_apply, "decide"), ("never apply", never_apply, "decide"),
                                 ("crash", crash, "decide"), ("pr always pass", pr_pass, "pr_decide"),
                                 ("pr always fail", pr_fail, "pr_decide"), ("crosscheck always yes",
                                                                            always_apply, "crosscheck")):
            f = Path(d, name.replace(" ", "_") + ".py")
            f.write_text(code, encoding="utf-8")
            r = subprocess.run([sys.executable, "-I", str(me), "--repo", str(empty), "--impl", f"{step}={f}"],
                               capture_output=True, text=True)
            last = r.stdout.strip().splitlines()[-1] if r.stdout.strip() else ""
            results.append((f"{name}: red, named a break-copy run", r.returncode == 1 and last.startswith(
                "W03_DECISION_TEST (break-copy run) FAIL"), last))
        r = subprocess.run([sys.executable, "-I", str(me), "--repo", str(empty)], capture_output=True, text=True)
        last = r.stdout.strip().splitlines()[-1] if r.stdout.strip() else ""
        results.append(("no workflow: could not check", r.returncode == 3 and "COULD NOT CHECK" in last, last))
    for label, good, last in results:
        print(f"{'ok  ' if good else 'BAD '} self-check {label} ({last})")
    good = all(g for _, g, _ in results)
    print(f"W03_DECISION_SELF_CHECK {'PASS' if good else 'FAIL'} ({sum(g for _, g, _ in results)}/{len(results)})")
    return 0 if good else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
