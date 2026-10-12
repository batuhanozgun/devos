#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the skeleton workflow used by --self-check is made up for
# this test; its steps run `true` and it names no secret value. Not made up, because the rules under test name them:
# DevOS's workflow path, job, step and environment names (EV-C02-001 "Names" and section 5).
"""test_workflow_order.py: W-C02-03 point 14's break; tests/C02/W-C02-03/T-W03-14_order_and_stop.md.

READS the workflow; it does not run it. The live run of point 14 stays the observation of the order (point 14:
"if that test reads the workflow rather than running it, the record says so"). It checks, in
.github/workflows/migrate.yml, the order and stop of EV-C02-001 M07 and section 5 ("The job's shape"):
  devos-test  environment migrate-devos-test; steps apply, compare, dbtests in that order; compare runs even when the
              apply failed (its `if` holds always() or !cancelled()); dbtests' `if` depends on compare; the job's
              output `go` depends on apply, compare and dbtests;
  devos       environment migrate-devos; needs devos-test; runs in every case (its `if` holds always() or
              !cancelled()); steps decide, dryrun, apply in that order (and crosscheck between dryrun and apply if O3
              is adopted); dryrun's and apply's `if` require steps.decide.outputs.apply == 'yes' (and crosscheck's);
              decide's GO comes from needs.devos-test.outputs.go;
  other jobs  no step with id apply or dryrun, and no `db push` or `migration up` in any run text.
Then, as the break, it makes copies of the same workflow in memory with one part of the stop removed and checks that
each copy fails. Options: --repo PATH; --self-check (runs all of this on a synthetic skeleton instead of the build's
workflow). Final line: W03_ORDER_TEST PASS (exit 0) | FAIL (exit 1) | COULD NOT CHECK (exit 3).
"""
import copy
import re
import sys
from pathlib import Path

sys.dont_write_bytecode = True
MIGRATE = ".github/workflows/migrate.yml"
RUNS_ALWAYS = ("always()", "!cancelled()")

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
        run: "true"
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
      - id: decide
        shell: python
        env:
          GO: ${{ needs.devos-test.outputs.go }}
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


def check(wf):
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
        if "steps.compare." not in norm(step(t, "dbtests").get("if")):
            p.append("devos-test's dbtests does not depend on compare")
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
    i_dec, i_dry, i_app, i_x = idx(d, "decide"), idx(d, "dryrun"), idx(d, "apply"), idx(d, "crosscheck")
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
        if "needs.devos-test.outputs.go" not in norm((step(d, "decide").get("env") or {}).get("GO")):
            p.append("devos's decide does not take GO from needs.devos-test.outputs.go")
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


def mutations():
    """(label, function that changes a copy; returns False if it could not be applied)."""
    def no_needs(w):
        return w["jobs"]["devos"].pop("needs", None) is not None

    def apply_ungated(w):
        return set_if(w, "devos", "apply", "${{ always() }}")

    def dryrun_ungated(w):
        return set_if(w, "devos", "dryrun", None)

    def go_literal(w):
        s = step(w["jobs"]["devos"], "decide")
        if not s or "GO" not in (s.get("env") or {}):
            return False
        s["env"]["GO"] = "yes"
        return True

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
    return [("devos without needs (both at once)", no_needs), ("apply runs after any decide result", apply_ungated),
            ("dryrun without the decide gate", dryrun_ungated), ("GO forced to yes", go_literal),
            ("apply before decide", apply_first), ("compare skipped after a failed apply", compare_only_on_success),
            ("dbtests without the clean-comparison condition", dbtests_without_compare),
            ("go ignores dbtests", go_without_dbtests), ("devos skipped when devos-test fails", devos_not_always),
            ("another job applies to devos", apply_in_check_job)]


def run(wf, label):
    bad = cnc = 0
    probs = check(wf)
    if probs:
        for x in probs:
            print(f"BAD  {label}: {x}")
        bad += 1
    else:
        print(f"ok   {label}: order and stop present as written")
    for name, mut in mutations():
        w = copy.deepcopy(wf)
        if not mut(w):
            print(f"CNC  break '{name}': could not be applied to this workflow")
            cnc += 1
            continue
        if check(w):
            print(f"ok   break '{name}': the copy fails, as it must")
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
        wf, label = yaml.safe_load(SKELETON), "synthetic skeleton"
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
    bad, cnc = run(wf, label)
    if bad:
        print(f"W03_ORDER_TEST FAIL ({label})")
        return 1
    if cnc:
        print(f"W03_ORDER_TEST COULD NOT CHECK ({cnc} break(s) could not be applied to {label}; not a pass)")
        return 3
    print(f"W03_ORDER_TEST PASS ({label})")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
