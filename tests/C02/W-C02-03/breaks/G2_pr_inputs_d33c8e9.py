# Frozen copy of step `pr_inputs`'s run body in .github/workflows/migration-checks.yml at main d33c8e9
# (byte-identical below the line of dashes; SHA-256 of that text 66be8fc9252adad7c0fe7308c0b160ac4b1ce2c7975174ddaf21ee7a5acd9221).
# Used only by tests/C02/W-C02-03/test_workflow_guards.py --self-check, as the known-faulty body of T-W03-15 cases (d) and (e): it asks for every job's log inside one try, so a skipped job's 404 leaves the whole report unreadable.
# Not the workflow's code: the workflow's own body is read from the workflow at the head under test.
# ----------------------------------------------------------------------------------------------------
# The inputs of pr_decide (M15): this pull request's changed files, main's head, and the report of the latest
# completed run of migrate.yml at main's head, read from that run's job logs with this job's own GITHUB_TOKEN
# (actions: read). No database credential. The logs are read as data: only lines of the report's fixed form are parsed.
import json, os, re, subprocess, urllib.error, urllib.request

def git(*args):
    return subprocess.run(["git", *args], capture_output=True, text=True)

# The changed files, NUL-separated (git diff -z): git then gives every path verbatim, never quoted, whatever its
# name holds (non-ASCII, tab, quote, backslash, control character; CHK-C02-035 C2). A diff that fails, or output
# that does not parse, leaves the list unreadable (an empty output), which pr_decide reads as "could not check".
changed = None
diff = subprocess.run(["git", "diff", "-z", "--name-status", "-M", "HEAD^1", "HEAD"], capture_output=True)
if diff.returncode:
    print("changed files: could not be read (git diff failed); pr_decide reads that as could not check")
else:
    fields, changed, i = diff.stdout.decode("utf-8", "surrogateescape").split("\0"), [], 0
    if fields[-1] == "":
        fields.pop()
    while i < len(fields):
        status = fields[i][:1]
        n = 2 if status in ("R", "C") else 1
        paths = fields[i + 1:i + 1 + n]
        if status not in ("A", "C", "D", "M", "R", "T") or len(paths) != n or not all(paths):
            print("changed files: could not be read (git diff's output does not parse); pr_decide reads that "
                  "as could not check")
            changed = None
            break
        changed.append({"path": paths[1], "status": status, "old_path": paths[0]} if n == 2
                       else {"path": paths[0], "status": status})
        i += 1 + n
main_head = git("ls-remote", "origin", "refs/heads/main").stdout.split("\t")[0].strip()
repo, api = os.environ["GITHUB_REPOSITORY"], os.environ.get("GITHUB_API_URL", "https://api.github.com")

def get(url):
    req = urllib.request.Request(url, headers={"Accept": "application/vnd.github+json", "User-Agent": "devos-checks",
                                               "X-GitHub-Api-Version": "2022-11-28"})
    req.add_unredirected_header("Authorization", "Bearer " + os.environ["GH_TOKEN"])
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read()

report = ""
LINE = re.compile(r"^\S+ W03REPORT (\{.*\})\s*$")
try:
    runs = json.loads(get(f"{api}/repos/{repo}/actions/workflows/migrate.yml/runs?branch=main&status=completed"
                          f"&head_sha={main_head}&per_page=20")).get("workflow_runs", []) if main_head else []
    if not runs:
        print(f"run report: none (no completed run of migrate.yml at main's head {main_head or 'unknown'})")
    else:
        run = runs[0]
        # Each migration job prints exactly one report line, for its own project; every other line a job prints
        # from data is escaped, except the test programs' own output in devos-test. So a project is read only from
        # its own job (devos-test or check-devos-test; devos or check-devos), and only if that job's log holds
        # exactly one report line, for that project, at the run's commit; anything else leaves the project out,
        # which pr_decide reads as "could not check". A line cannot replace another.
        OWN = {"devos-test": "devos-test", "check-devos-test": "devos-test", "devos": "devos", "check-devos": "devos"}
        projects, unusable = {}, set()
        for job in json.loads(get(f"{api}/repos/{repo}/actions/runs/{run['id']}/jobs?per_page=100")).get("jobs", []):
            jname = str(job.get("name") or "").split(" ", 1)[0]
            own = OWN.get(jname)
            log = get(f"{api}/repos/{repo}/actions/jobs/{job['id']}/logs").decode("utf-8", "replace")
            found = []
            for ln in log.splitlines():
                m = LINE.match(ln)
                if m:
                    try:
                        found.append(json.loads(m.group(1)))
                    except ValueError:
                        found.append(None)
            label = "".join(c if c.isprintable() else ascii(c)[1:-1] for c in jname)
            if own is None:
                if found:
                    print(f"run report: job {label} is not a migration job; its {len(found)} report lines are not read")
                continue
            r = found[0] if len(found) == 1 else None
            if own in projects or own in unusable or not isinstance(r, dict) or r.get("project") != own \
                    or r.get("commit") != run.get("head_sha"):
                print(f"run report: job {label}: {len(found)} report lines, not exactly one for {own} at the run's "
                      f"commit; {own} is not read (could not check)")
                unusable.add(own)
                projects.pop(own, None)
                continue
            projects[own] = {k: r.get(k) for k in ("result", "applied_versions", "differences")}
        report = json.dumps({"commit": run.get("head_sha"), "completed": run.get("status") == "completed",
                             "run_id": run.get("id"), "event": run.get("event"), "projects": projects},
                            separators=(",", ":"))
        print(f"run report: run {run.get('id')} ({run.get('event')}) at {run.get('head_sha')}: "
              f"projects reported: {sorted(projects)}")
except (urllib.error.URLError, OSError, ValueError, KeyError) as exc:
    print(f"run report: could not be read ({type(exc).__name__})")
    report = ""
with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as f:
    for k, v in (("changed", "" if changed is None else json.dumps(changed)), ("run_report", report),
                 ("main_head", main_head)):
        f.write(f"{k}<<W03EOF\n{v}\nW03EOF\n")
