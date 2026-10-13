#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the skeleton workflow used by --self-check is made up for
# this test; it is only read, never run, and it names no secret value. Not made up, because the rules under test name
# them: DevOS's workflow path, job, step and environment names (EV-C02-001 "Names" and section 5).
"""test_workflow_order.py: W-C02-03 point 14's break; tests/C02/W-C02-03/T-W03-14_order_and_stop.md.

READS the workflow; it does not run it. The live run of point 14 stays the observation of the order (point 14:
"if that test reads the workflow rather than running it, the record says so"). It checks, in
.github/workflows/migrate.yml, the order and stop of EV-C02-001 M07 and section 5 ("The job's shape"):
  devos-test  environment migrate-devos-test; steps apply, compare, dbtests in that order; compare runs even when the
              apply failed (its `if` holds always() or !cancelled()); dbtests' `if` requires
              steps.compare.outputs.<x> == 'no_difference', not negated and not or-ed; dbtests' runner stops on errors
              (psql's ON_ERROR_STOP set true) and looks for the files' PASS notice; the job's output `go` depends on
              apply, compare and dbtests;
  devos       environment migrate-devos; needs devos-test; runs in every case (its `if` holds always() or
              !cancelled()); its own comparison step `compare` before `decide`; then steps decide, dryrun, apply in
              that order (and crosscheck between dryrun and apply if O3 is adopted); dryrun's and apply's `if` require
              steps.decide.outputs.apply == 'yes' (and crosscheck's); decide's GO comes from
              needs.devos-test.outputs.go, its DRIFT_CALL and DRIFT_RESULT from steps.compare.outputs (this job's own
              comparison, never needs.*), and its FM_READS from steps of this job before decide;
  other jobs  no step with id apply or dryrun, and no `db push` or `migration up` in any run text.
Then, as the break, it makes copies of the same workflow in memory with one part of the stop removed and checks that
each copy fails, and fails on the rule that copy removes. Options: --repo PATH; --self-check (runs all of this on a
synthetic skeleton instead of the build's workflow). Final line: W03_ORDER_TEST PASS (exit 0) | FAIL (exit 1) |
COULD NOT CHECK (exit 3).
After that line it runs T-W03-15 (test_workflow_guards.py; N-265), whose own final lines follow, and exits with the
worse of the two results (1 over 3 over 0), so that step w03_tests runs both with no workflow change.
"""
import copy
import re
import shlex
import subprocess
import sys
from pathlib import Path

sys.dont_write_bytecode = True
MIGRATE = ".github/workflows/migrate.yml"
RUNS_ALWAYS = ("always()", "!cancelled()")
HIGH_PREFIXES = (".claude/", "tools/", ".github/workflows/", "methods/", "supabase/migrations/", "supabase/functions/",
                 "pipelines/")

SKELETON = """
name: w03-fixture-skeleton
on:
  push:
    branches: [main]
permissions: {}
jobs:
  devos-test:
    runs-on: ubuntu-24.04
    environment: migrate-devos-test
    outputs:
      go: ${{ steps.go.outputs.go }}
    steps:
      - id: apply
        run: "true"
      - id: compare
        if: ${{ !cancelled() }}
        run: "true"
      - id: dbtests
        if: ${{ steps.compare.outputs.result == 'no_difference' }}
        run: |
          for f in supabase/migrations/tests/*.sql; do
            psql -X -v ON_ERROR_STOP=1 -f "$f" > w03_fixture_out.txt 2>&1 || exit 1
            grep -q ' PASS (' w03_fixture_out.txt || exit 1
          done
      - id: go
        if: ${{ always() }}
        env:
          A: ${{ steps.apply.outcome }}
          C: ${{ steps.compare.outputs.result }}
          T: ${{ steps.dbtests.outcome }}
        run: "true"
  devos:
    runs-on: ubuntu-24.04
    environment: migrate-devos
    needs: devos-test
    if: ${{ always() }}
    steps:
      - id: compare
        run: "true"
      - id: decide
        shell: python
        env:
          GO: ${{ needs.devos-test.outputs.go }}
          FM_READS: ${{ steps.compare.outputs.fm_reads }}
          DRIFT_CALL: ${{ steps.compare.outputs.call }}
          DRIFT_RESULT: ${{ steps.compare.outputs.result }}
          EXPECTED: ${{ steps.compare.outputs.expected }}
        run: "pass"
      - id: dryrun
        if: ${{ steps.decide.outputs.apply == 'yes' }}
        run: "true"
      - id: apply
        if: ${{ steps.decide.outputs.apply == 'yes' }}
        run: "true"
"""


def norm(s):
    return re.sub(r"\s+", "", str(s or "")).replace('"', "'")


def steps(job):
    return [s for s in (job or {}).get("steps") or [] if isinstance(s, dict)]


def idx(job, sid):
    for i, s in enumerate(steps(job)):
        if s.get("id") == sid:
            return i
    return None


def step(job, sid):
    i = idx(job, sid)
    return steps(job)[i] if i is not None else None


def env_name(job):
    e = (job or {}).get("environment")
    return e.get("name") if isinstance(e, dict) else e


def clean_gate(cond):
    """dbtests' `if`: steps.compare.outputs.<x> == 'no_difference', not negated (no `!` but in !cancelled()), no `||`."""
    n = norm(cond)
    eq = re.search(r"steps\.compare\.outputs\.[A-Za-z0-9_-]+=='no_difference'|"
                   r"'no_difference'==steps\.compare\.outputs\.[A-Za-z0-9_-]+", n)
    return bool(eq) and "||" not in n and not re.search(r"!(?!cancelled\(\))", n)


def file_ref(run):
    """The repository path a one-line run names (`bash|sh|python3 [-I|-e] <path>` or `<path>`), or None."""
    run = str(run or "").strip()
    if not run or "\n" in run:
        return None
    try:
        words = shlex.split(run)
    except ValueError:
        return None
    if words and words[0] in ("bash", "sh", "python3"):
        words = [w for w in words[1:] if w not in ("-I", "-e", "-eu", "-euo", "pipefail")]
    if len(words) != 1:
        return None
    rel = words[0][2:] if words[0].startswith("./") else words[0]
    return rel if rel.startswith(HIGH_PREFIXES) and ".." not in rel.split("/") else None


def runner_text(st, repo):
    """The text of dbtests' runner: its run body, plus the class-high file a one-line run names, if readable."""
    run = str((st or {}).get("run") or "")
    rel = file_ref(run)
    if rel and repo is not None and (repo / rel).is_file():
        run += "\n" + (repo / rel).read_text(encoding="utf-8")
    return "\n".join(ln for ln in run.splitlines() if not ln.lstrip().startswith(("#", "--")))


ERROR_STOP_ON = re.compile(r"ON_ERROR_STOP\s*=\s*['\"]?(1|on|true|yes)\b", re.I)
ERROR_STOP_OFF = re.compile(r"ON_ERROR_STOP\s*=\s*['\"]?(0|off|false|no)\b", re.I)


def check(wf, repo=None):
    """Returns a list of problems; empty means the order and stop are present as written."""
    p = []
    jobs = (wf or {}).get("jobs") or {}
    t, d = jobs.get("devos-test"), jobs.get("devos")
    if not t or not d:
        return ["jobs devos-test and devos are not both present"]
    if env_name(t) != "migrate-devos-test":
        p.append("devos-test does not use environment migrate-devos-test")
    if env_name(d) != "migrate-devos":
        p.append("devos does not use environment migrate-devos")
    ia, ic, it = idx(t, "apply"), idx(t, "compare"), idx(t, "dbtests")
    if None in (ia, ic, it) or not ia < ic < it:
        p.append("devos-test lacks steps apply, compare, dbtests in that order")
    else:
        if not any(x in norm(step(t, "compare").get("if")) for x in RUNS_ALWAYS):
            p.append("devos-test's compare does not run after a failed apply")
        if not clean_gate(step(t, "dbtests").get("if")):
            p.append("devos-test's dbtests does not require steps.compare.outputs.<x> == 'no_difference' "
                     "(alone: not negated, not or-ed)")
        text = runner_text(step(t, "dbtests"), repo)
        if not ERROR_STOP_ON.search(text) or ERROR_STOP_OFF.search(text):
            p.append("devos-test's dbtests runner does not run psql with errors stopping the file (ON_ERROR_STOP "
                     "set true; if the build uses another client, the test designer revises this check first)")
        if not re.search(r"\bPASS\b", text):
            p.append("devos-test's dbtests runner does not look for the files' PASS notice")
    go = norm(((t.get("outputs") or {}).get("go")))
    text = go
    for ref in re.findall(r"steps\.([A-Za-z0-9_-]+)\.", go):
        s = step(t, ref)
        if s:
            text += norm(s.get("env")) + norm(s.get("run")) + norm(s.get("if"))
    if not go:
        p.append("devos-test has no output go")
    for sid in ("apply", "compare", "dbtests"):
        if f"steps.{sid}." not in text:
            p.append(f"devos-test's go does not depend on {sid}")
    needs = d.get("needs")
    needs = [needs] if isinstance(needs, str) else (needs or [])
    if "devos-test" not in needs:
        p.append("devos does not need devos-test (the two could run at once)")
    if not any(x in norm(d.get("if")) for x in RUNS_ALWAYS):
        p.append("devos does not run in every case (its comparison and report would be skipped)")
    i_cmp, i_dec, i_dry, i_app, i_x = (idx(d, "compare"), idx(d, "decide"), idx(d, "dryrun"), idx(d, "apply"),
                                       idx(d, "crosscheck"))
    if i_cmp is None or i_dec is None or not i_cmp < i_dec:
        p.append("devos has no comparison step (id compare) of its own before decide")
    if None in (i_dec, i_dry, i_app) or not i_dec < i_dry < i_app:
        p.append("devos lacks steps decide, dryrun, apply in that order")
    else:
        gate = "steps.decide.outputs.apply=='yes'"
        for sid in ("dryrun", "apply"):
            cond = norm(step(d, sid).get("if"))
            if gate not in cond or "||" in cond:
                p.append(f"devos's {sid} does not require {gate} alone")
        if i_x is not None and (not i_dry < i_x < i_app or "steps.crosscheck.outputs.apply=='yes'" not in norm(
                step(d, "apply").get("if"))):
            p.append("crosscheck is present but does not gate the apply")
        env = step(d, "decide").get("env") or {}
        if "needs.devos-test.outputs.go" not in norm(env.get("GO")):
            p.append("devos's decide does not take GO from needs.devos-test.outputs.go")
        before = {s.get("id") for s in steps(d)[:i_dec]}
        for k in ("DRIFT_CALL", "DRIFT_RESULT"):
            v = norm(env.get(k))
            refs = set(re.findall(r"steps\.([A-Za-z0-9_-]+)\.", v))
            if "steps.compare.outputs." not in v or "needs." in v or refs != {"compare"} or "compare" not in before:
                p.append(f"devos's decide does not take {k} from steps.compare.outputs (job devos's own comparison, "
                         f"before decide; never needs.*)")
        v = norm(env.get("FM_READS"))
        refs = set(re.findall(r"steps\.([A-Za-z0-9_-]+)\.outputs\.", v))
        if not refs or "needs." in v or not refs <= before:
            p.append("devos's decide does not take FM_READS from steps of job devos before decide (never needs.*)")
    for name, job in jobs.items():
        if name in ("devos-test", "devos"):
            continue
        for s in steps(job):
            if s.get("id") in ("apply", "dryrun") or re.search(r"\bdb\s+push\b|\bmigration\s+up\b", str(s.get("run"))):
                p.append(f"job {name} holds an apply step")
    return p


def set_if(wf, job, sid, value):
    s = step(wf["jobs"][job], sid)
    if s is None:
        return False
    if value is None:
        s.pop("if", None)
    else:
        s["if"] = value
    return True


def set_env(wf, job, sid, key, value):
    s = step(wf["jobs"][job], sid)
    if not s or key not in (s.get("env") or {}):
        return False
    s["env"][key] = value
    return True


def mutations(repo=None):
    """(label, function that changes a copy and returns False if it could not be applied, text the problem it must
    cause contains)."""
    def no_needs(w):
        return w["jobs"]["devos"].pop("needs", None) is not None

    def apply_ungated(w):
        return set_if(w, "devos", "apply", "${{ always() }}")

    def dryrun_ungated(w):
        return set_if(w, "devos", "dryrun", None)

    def go_literal(w):
        return set_env(w, "devos", "decide", "GO", "yes")

    def apply_first(w):
        st = w["jobs"]["devos"].get("steps") or []
        i = idx(w["jobs"]["devos"], "apply")
        if i is None:
            return False
        st.insert(0, st.pop(i))
        return True

    def compare_only_on_success(w):
        return set_if(w, "devos-test", "compare", None)

    def dbtests_without_compare(w):
        return set_if(w, "devos-test", "dbtests", "${{ success() }}")

    def dbtests_inverted(w):
        s = step(w["jobs"]["devos-test"], "dbtests")
        cond = str((s or {}).get("if") or "")
        if "==" not in cond:
            return False
        s["if"] = cond.replace("==", "!=")
        return True

    def runner_without(pattern):
        def mut(w):
            s = step(w["jobs"]["devos-test"], "dbtests")
            if s is None:
                return False
            text = runner_text(s, repo)
            new = "\n".join(re.sub(pattern, "", ln) for ln in text.splitlines())
            if new == text:
                return False
            s["run"] = new  # the file's text, if any, inlined without the removed part; this test only reads it
            return True
        return mut

    def go_without_dbtests(w):
        t = w["jobs"]["devos-test"]
        go = str((t.get("outputs") or {}).get("go", ""))
        for ref in re.findall(r"steps\.([A-Za-z0-9_-]+)\.", go):
            s = step(t, ref)
            if s:
                for k in ("env", "run", "if"):
                    if k in s:
                        s[k] = re.sub(r"steps\.dbtests\.[A-Za-z_]+", "'success'", str(s[k])) if k != "env" else {
                            a: re.sub(r"steps\.dbtests\.[A-Za-z_]+", "'success'", str(b)) for a, b in s[k].items()}
        t.setdefault("outputs", {})["go"] = re.sub(r"steps\.dbtests\.[A-Za-z_]+", "'success'", go)
        return True

    def devos_not_always(w):
        return w["jobs"]["devos"].pop("if", None) is not None

    def apply_in_check_job(w):
        w["jobs"]["w03-fixture-extra"] = {"runs-on": "ubuntu-24.04", "environment": "migrate-devos",
                                          "steps": [{"id": "apply", "run": "true"}]}
        return True

    def devos_without_compare(w):
        d = w["jobs"]["devos"]
        i = idx(d, "compare")
        if i is None:
            return False
        d["steps"] = [s for s in d.get("steps") or [] if not (isinstance(s, dict) and s.get("id") == "compare")]
        return True

    def compare_after_decide(w):
        d = w["jobs"]["devos"]
        st = d.get("steps") or []
        i = idx(d, "compare")
        if i is None or idx(d, "decide") is None:
            return False
        s = st.pop(i)
        st.insert(idx(d, "decide") + 1, s)
        return True

    def drift_result_from_devos_test(w):
        return set_env(w, "devos", "decide", "DRIFT_RESULT", "${{ needs.devos-test.outputs.drift_result }}")

    def fm_reads_from_devos_test(w):
        return set_env(w, "devos", "decide", "FM_READS", "${{ needs.devos-test.outputs.fm_reads }}")

    return [("devos without needs (both at once)", no_needs, "does not need devos-test"),
            ("apply runs after any decide result", apply_ungated, "devos's apply does not require"),
            ("dryrun without the decide gate", dryrun_ungated, "devos's dryrun does not require"),
            ("GO forced to yes", go_literal, "does not take GO"),
            ("apply before decide", apply_first, "decide, dryrun, apply in that order"),
            ("compare skipped after a failed apply", compare_only_on_success, "compare does not run after"),
            ("dbtests without the clean-comparison condition", dbtests_without_compare, "dbtests does not require"),
            ("dbtests condition inverted (runs on a comparison that is not clean)", dbtests_inverted,
             "dbtests does not require"),
            ("dbtests runner without errors stopping the file", runner_without(
                r"(-v|--set|--variable)?[ =]?ON_ERROR_STOP\s*=\s*['\"]?\w+['\"]?"), "errors stopping the file"),
            ("dbtests runner not looking for the PASS notice", runner_without(r".*\bPASS\b.*"), "PASS notice"),
            ("go ignores dbtests", go_without_dbtests, "go does not depend on dbtests"),
            ("devos skipped when devos-test fails", devos_not_always, "devos does not run in every case"),
            ("another job applies to devos", apply_in_check_job, "holds an apply step"),
            ("devos without its own comparison step", devos_without_compare, "no comparison step"),
            ("devos's comparison after decide", compare_after_decide, "no comparison step"),
            ("decide's DRIFT_RESULT taken from needs.devos-test.outputs (skips a project)",
             drift_result_from_devos_test, "does not take DRIFT_RESULT"),
            ("decide's FM_READS taken from needs.devos-test.outputs (skips a project)", fm_reads_from_devos_test,
             "does not take FM_READS")]


def run(wf, label, repo=None):
    bad = cnc = 0
    probs = check(wf, repo)
    if probs:
        for x in probs:
            print(f"BAD  {label}: {x}")
        bad += 1
    else:
        print(f"ok   {label}: order and stop present as written")
    for name, mut, why in mutations(repo):
        w = copy.deepcopy(wf)
        if not mut(w):
            print(f"CNC  break '{name}': could not be applied to this workflow")
            cnc += 1
            continue
        got = check(w, repo)
        hit = [x for x in got if why in x]
        if hit:
            print(f"ok   break '{name}': the copy fails, as it must ({hit[0]})")
        elif got:
            print(f"BAD  break '{name}': the copy fails, but not on the rule it removes: {'; '.join(got)}")
            bad += 1
        else:
            print(f"BAD  break '{name}': the copy still passes, so the test does not see this part of the stop")
            bad += 1
    return bad, cnc


def main(argv):
    try:
        import yaml
    except ImportError:
        print("W03_ORDER_TEST COULD NOT CHECK (PyYAML is not installed)")
        return 3
    repo = Path(__file__).resolve().parents[3]
    if "--repo" in argv:
        repo = Path(argv[argv.index("--repo") + 1]).resolve()
    if "--self-check" in argv:
        wf, label, repo = yaml.safe_load(SKELETON), "synthetic skeleton", None
    else:
        path = repo / MIGRATE
        if not path.is_file():
            print(f"W03_ORDER_TEST COULD NOT CHECK ({MIGRATE} is absent; the build has not added it)")
            return 3
        try:
            wf = yaml.safe_load(path.read_text(encoding="utf-8"))
        except Exception as exc:
            print(f"BAD  {MIGRATE} does not parse: {type(exc).__name__}")
            print("W03_ORDER_TEST FAIL")
            return 1
        label = MIGRATE
    print("note: this test reads the workflow and does not run it; the live run of point 14 is the observation")
    bad, cnc = run(wf, label, repo)
    if bad:
        print(f"W03_ORDER_TEST FAIL ({label})")
        return 1
    if cnc:
        print(f"W03_ORDER_TEST COULD NOT CHECK ({cnc} break(s) could not be applied to {label}; not a pass)")
        return 3
    print(f"W03_ORDER_TEST PASS ({label})")
    return 0


def guards(argv):
    """T-W03-15 (T-W03-15_workflow_guards.md; N-265): run here so that the pull-request check's step w03_tests runs it
    with no workflow change (the executor's decision of 2026-10-13). Its own final lines are its result; this file's
    exit code is the worse of the two (1 over 3 over 0). --repo and --self-check are passed on."""
    prog = Path(__file__).resolve().parent / "test_workflow_guards.py"
    if not prog.is_file():
        print("W03_GUARDS COULD NOT CHECK (test_workflow_guards.py is absent)")
        return 3
    args = ["--self-check"] if "--self-check" in argv else []
    if "--repo" in argv and argv.index("--repo") + 1 < len(argv):
        args += ["--repo", argv[argv.index("--repo") + 1]]
    sys.stdout.flush()
    r = subprocess.run([sys.executable, "-I", str(prog), *args])
    return r.returncode if r.returncode in (0, 1, 3) else 1


if __name__ == "__main__":
    order, guarded = main(sys.argv[1:]), guards(sys.argv[1:])
    sys.exit(1 if 1 in (order, guarded) else 3 if 3 in (order, guarded) else 0)
