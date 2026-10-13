# Frozen copy of step `pr_decide`'s run body in .github/workflows/migration-checks.yml at main d33c8e9
# (byte-identical below the line of dashes; SHA-256 of that text 1e79b465c5e6e9ce983d917f575d05dbefa9fe92855b2f76a879cf96ef2c05c8).
# Used only by tests/C02/W-C02-03/test_workflow_guards.py --self-check, as the deciding step the self-check feeds; pr_decide itself is T-W03-DEC's.
# Not the workflow's code: the workflow's own body is read from the workflow at the head under test.
# ----------------------------------------------------------------------------------------------------
# What the pull-request check stops (EV-C02-001 M15, M16; tests/C02/W-C02-03/T-W03-DEC_decision_steps.md). A pull
# request that changes, removes or renames a merged migration file fails unless the run report shows that version
# unapplied in both projects; "could not check" cannot show that. Every other pull request passes, with the state
# written. Inputs only through env; outputs to GITHUB_OUTPUT.
import json, os, re

PROJECTS = ("devos-test", "devos")
RESULTS = ("no_difference", "differences", "could_not_check")
MIGRATION = re.compile(r"supabase/migrations/[^/]+\.sql")
VERSION = re.compile(r"([0-9]+)_.*\.sql")


def load(name):
    text = os.environ.get(name, "")
    try:
        return json.loads(text) if text else None
    except ValueError:
        return None


def esc(s):
    return "".join(c if c.isprintable() else ascii(c)[1:-1] for c in str(s))


def words(result):
    return {"no_difference": "no difference", "differences": "differences",
            "could_not_check": "could not check"}.get(result, "could not check")


changed, report, main_head = load("CHANGED"), load("RUN_REPORT"), os.environ.get("MAIN_HEAD", "")
problem = None
if not isinstance(report, dict):
    problem = "no readable run report of migrate.yml at main's head"
elif report.get("commit") != main_head or not main_head:
    problem = f"the run report is at {esc(report.get('commit'))}, not at main's head {esc(main_head or 'unknown')}"
elif report.get("completed") is not True:
    problem = "the run report's run is not completed"
elif not isinstance(report.get("projects"), dict):
    problem = "the run report has no projects"
projects = {}
for p in PROJECTS:
    r = (report or {}).get("projects", {}).get(p) if problem is None else None
    ok = isinstance(r, dict) and r.get("result") in RESULTS and isinstance(r.get("applied_versions"), list) \
        and isinstance(r.get("differences"), list)
    projects[p] = r if ok else None
parts = []
for p in PROJECTS:
    r = projects[p]
    if r is None:
        parts.append(f"{p}: could not check ({problem or 'the report lacks this project or its fields'})")
    else:
        listed = ", ".join(f"{esc(d.get('kind'))} {esc(d.get('version') or d.get('slug'))}" for d in r["differences"]
                           if isinstance(d, dict))
        parts.append(f"{p}: {words(r['result'])}" + (f" ({listed})" if listed else ""))
state = "; ".join(parts)

touched, unusable = [], not isinstance(changed, list)
for c in changed if isinstance(changed, list) else []:
    if not isinstance(c, dict) or not isinstance(c.get("path"), str):
        unusable = True
        continue
    status = str(c.get("status", ""))[:1]
    if status in ("A", "C"):
        continue
    old = c.get("old_path") if status == "R" else c["path"]
    for path in {old, c["path"]} if status not in ("M", "D", "T", "R") else {old}:
        if isinstance(path, str) and MIGRATION.fullmatch(path):
            touched.append(path)


def unapplied_in_both(version):
    for p in PROJECTS:
        r = projects[p]
        if r is None or r["result"] == "could_not_check" or version in r["applied_versions"]:
            return False
        if not any(isinstance(d, dict) and d.get("kind") == "on_main_not_applied" and d.get("version") == version
                   for d in r["differences"]):
            return False
    return True


blocked = []
for path in sorted(set(touched)):
    m = VERSION.fullmatch(path.rsplit("/", 1)[1])
    if not m or not unapplied_in_both(m.group(1)):
        blocked.append(path)
if unusable:
    verdict, why = "fail", "the list of changed files could not be read (could not check)"
elif blocked:
    verdict, why = "fail", ("a merged migration is changed, removed or renamed and the records do not show it "
                            "unapplied in both projects: " + ", ".join(esc(p) for p in blocked))
elif touched:
    verdict, why = "pass", "each changed migration is shown unapplied in both projects: " + ", ".join(
        esc(p) for p in sorted(set(touched)))
else:
    verdict, why = "pass", "no merged migration is changed, removed or renamed"
print(f"migration records at main's head: {state}")
print(f"pr check: {verdict}: {why}")
with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as f:
    f.write(f"verdict={verdict}\nstate={state}\n")
if os.environ.get("GITHUB_STEP_SUMMARY"):
    with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as f:
        f.write(f"### Migration records\n\n- {state}\n- check: {verdict}: {why}\n")
raise SystemExit(0 if verdict == "pass" else 1)
