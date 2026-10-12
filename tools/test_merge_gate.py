#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixtures and inputs in this file are made up for
# the test and hold no personal or business data. That includes the fixtures of cases (20) to (30) (W-C02-19): file
# names and contents, SQL, function, pipeline and workflow code, CODEOWNERS lines (an address under the reserved
# .invalid domain, no account handle), verdict files, names with a space, a non-ASCII or a non-UTF-8 character, and
# symbolic links. Not made up, because the rules under test name them: the name of DevOS's repository devos and of
# its GitHub owner (in the guard's merge_pull_request call), DevOS's own file paths (the gate's class-high paths and
# plan 6.7's high-impact path list), and the text of plan 6.7's "High-impact path list" bullet, which case (28) reads
# from plan/DevOS_Kurulum_Plani.md beside this file at run time and does not copy.
"""test_merge_gate.py: planted cases for tools/merge_gate.py and guard rule M7 (D-010; PC-06; R-TRANS-1; W-C02-19).

The fixture is a scratch repository whose origin is a local bare repository; it carries copies of this working
tree's gate and guard. Each pull request head is pushed to refs/pull/N/head and the gate is run as M7 runs it
(python3 tools/merge_gate.py --pr N --head SHA, fetching from origin); the guard cases give the fixture's guard a
merge_pull_request call. Cases (20) to (27) plant, for each path of plan 6.7's high-impact path list, pull requests
that touch it in different forms; (28) reads that list from plan/DevOS_Kurulum_Plani.md beside this file and checks
that the gate classes every path it names, and that it names those eight, printing what it found ("plan 6.7:"
lines) or that it could not check; (29) near misses stay class normal; (30) a name that is not UTF-8 fails closed.
Prints one line per case and MERGE_GATE_TEST PASS only if every case behaves as written.
"""
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
REPO = Path(__file__).resolve().parent.parent
RESULTS = []
VERDICT = """---
id: CHK-C00-{n:03d}
target: the fixture change
reviewed_head: {sha}
verdict: {verdict}
conditions: []
{independence}checker_run: fixture run
date: 2026-10-05
---

Findings: none (fixture).
"""
INDEPENDENCE = 'independence: "same session, fresh-context subagent (declared, Ek A 373)"\n'
ITEM = """---
id: W-T-01
---

# W-T-01

<!-- acceptance -->
All 20 cases pass, reviewed by a fresh-context checker
<!-- /acceptance -->

## Notes
"""
# W-C02-19: plan 6.7's high-impact path list as point 1 of the item names it, the plan file case (28) reads it from,
# and the list's one phrase that names no path. Made-up contents for the files cases (20) to (27) plant.
LISTED = ("CLAUDE.md", ".claude/", "methods/", "supabase/migrations/", "supabase/functions/", "pipelines/",
          ".github/workflows/", ".github/CODEOWNERS")
PLAN = "plan/DevOS_Kurulum_Plani.md"
NO_PATH = "the code of the decision channel once C06 writes it"
SQL = "create table fixture_item (id bigint primary key);\n"
TS = 'export default () => new Response("fixture");\n'
PY = 'print("fixture pipeline step")\n'
YML = "name: fixture\non: workflow_dispatch\njobs: {}\n"
OWNERS = "# fixture owners: an address under the reserved .invalid domain, no account\n* fixture@example.invalid\n"


def run(args, cwd, stdin=None, env=None):
    # errors="replace": an undecodable byte in a tool's output (case (30)) is shown, not a crash of this test
    r = subprocess.run(args, cwd=cwd, input=stdin, capture_output=True, text=True, errors="replace",
                       env={**os.environ, **(env or {})})
    return r.returncode, r.stdout, r.stderr


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {detail[-600:]}"))
    RESULTS.append(ok)


class Fixture:
    def __init__(self, tmp):
        self.tmp, self.d = tmp, tmp / "work"
        run(["git", "init", "-q", "--bare", str(tmp / "origin.git")], tmp)
        run(["git", "init", "-q", "-b", "main", str(self.d)], tmp)
        for k, v in (("user.name", "Fixture"), ("user.email", "fixture@example.invalid"), ("commit.gpgsign", "false")):
            self.git("config", k, v)
        self.git("remote", "add", "origin", str(tmp / "origin.git"))
        for f in ("tools/merge_gate.py", ".claude/hooks/tool_allowlist.py"):
            self.write(f, (REPO / f).read_text())
        self.write(".claude/hooks/owned_ids.txt", "# owned IDs\n")
        self.write("CLAUDE.md", "rules\n")
        self.write("plan/notes.md", "notes\n")
        self.write("plan/work/W-T-01.md", ITEM)
        self.write("plan/work/T01.md", "# T01 (a stage file without an acceptance block)\n")
        self.commit("base")
        self.git("push", "-q", "origin", "main")

    def git(self, *a):
        rc, out, err = run(["git", *a], self.d)
        assert rc == 0, f"git {' '.join(a)}: {err}"
        return out.strip()

    def write(self, path, text):
        (self.d / path).parent.mkdir(parents=True, exist_ok=True)
        (self.d / path).write_text(text)

    def append(self, path, text):
        p = self.d / path
        self.write(path, (p.read_text() if p.exists() else "") + text + "\n")

    def link(self, path, target):
        (self.d / path).parent.mkdir(parents=True, exist_ok=True)
        os.symlink(target, self.d / path)

    def move(self, old, new):
        (self.d / new).parent.mkdir(parents=True, exist_ok=True)
        (self.d / old).rename(self.d / new)

    def remove(self, path):
        self.git("rm", "-q", "--", path)

    def planted(self, pr, *steps):
        """Pull request pr from main: each step is (method, arguments...) on this fixture; returns the pushed head."""
        self.branch(f"pr{pr}")
        for name, *args in steps:
            getattr(self, name)(*args)
        self.commit(f"fixture pull request {pr}")
        return self.push(pr)

    def commit(self, msg):
        self.git("add", "-A")
        self.git("commit", "-q", "-m", msg)
        return self.git("rev-parse", "HEAD")

    def branch(self, name):
        self.git("checkout", "-q", "-B", name, "main")

    def push(self, pr):
        self.git("push", "-q", "origin", f"+HEAD:refs/pull/{pr}/head")
        return self.git("rev-parse", "HEAD")

    def merge(self, name):
        self.git("checkout", "-q", "main")
        self.git("merge", "-q", "--no-ff", "-m", f"Merge {name}", name)
        self.git("push", "-q", "origin", "main")

    def verdict(self, n, sha, verdict="PASS", independence=INDEPENDENCE):
        self.write(f"evidence/C00/checks/CHK-C00-{n:03d}.md",
                   VERDICT.format(n=n, sha=sha, verdict=verdict, independence=independence))
        return self.commit(f"checker verdict CHK-C00-{n:03d}")

    def gate(self, pr, head):
        rc, out, err = run([sys.executable, "tools/merge_gate.py", "--pr", str(pr), "--head", head], self.d)
        return rc, out + err

    def guard(self, pr, head):
        call = {"hook_event_name": "PreToolUse", "tool_name": "mcp__github__merge_pull_request", "cwd": str(self.d),
                "tool_input": {"owner": "batuhanozgun", "repo": "devos", "pullNumber": pr, "expectedHeadSha": head,
                               "merge_method": "merge"}}
        _, out, err = run([sys.executable, ".claude/hooks/tool_allowlist.py"], self.d, json.dumps(call),
                          {"DEVOS_GUARD_LOG_DIR": str(self.tmp / "log")})
        try:
            d = json.loads(out)["hookSpecificOutput"]
            return d["permissionDecision"], d["permissionDecisionReason"]
        except (ValueError, KeyError):
            return "?", out + err


def high_named(out, path):
    """True when the gate's "class high:" line names path (a note in parentheses after a path is dropped)."""
    for line in out.splitlines():
        line = line.strip()
        if line.startswith("class high: "):
            return path in [e.split(" (")[0] for e in line[len("class high: "):].removesuffix(" ...").split(", ")]
    return False


def plan_list():
    """(paths, skipped, None): the backticked spans of plan 6.7's "High-impact path list" bullet in the plan beside
    this file, and whether the phrase that names no path is in it; (None, None, why) when that cannot be read."""
    try:
        text = (REPO / PLAN).read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as e:
        return None, None, f"{PLAN} is missing or unreadable ({type(e).__name__}: {e})"
    sec = re.search(r"^### 6\.7 .*?(?=^#{1,3} |\Z)", text, re.M | re.S)
    bullet = sec and re.search(r"^- \*\*High-impact path list\*\*.*?(?=\n- |\n\s*\n|\n#|\Z)", sec.group(0),
                               re.M | re.S)
    if not bullet:
        return None, None, (f"no \"High-impact path list\" bullet in section 6.7 of {PLAN}" if sec else
                            f"no section 6.7 in {PLAN}")
    return re.findall(r"`([^`]+)`", bullet.group(0)), NO_PATH in bullet.group(0), None


def listed_paths(s):
    """Cases (20) to (30): W-C02-19, the gate and plan 6.7's high-impact path list. Its pull requests are 100 up."""
    prs = iter(range(100, 1000))

    def neg(label, path, *steps):
        """Negative control: a pull request made by steps, no verdict: GATE FAIL, exit 1, "class high:" naming path."""
        pr = next(prs)
        head = s.planted(pr, *steps)
        rc, out = s.gate(pr, head)
        case(label, rc == 1 and "GATE FAIL" in out and high_named(out, path), out)
        return pr, head

    def pos(pr, x, n, label):
        """Positive control: pull request pr (head x) adds a PASS verdict naming x: GATE PASS, exit 0, "covered by"."""
        h = s.verdict(n, x)
        s.push(pr)
        rc, out = s.gate(pr, h)
        case(label, rc == 0 and "GATE PASS" in out and "covered by" in out, out)
        return h

    # Point 1 of W-C02-19 (plan 6.7, "High-impact path list"; PC-08; plan 6.1). Form C0 (Appendix C), for (20) to (27):
    # - Claim: each of the eight paths plan 6.7 lists is class high in the gate, in whatever form a change touches it.
    # - Failure class: a pull request touching a listed path merges with no fresh-context verdict: a new file at any
    #   depth, a change, a deletion, a rename into or out of it (the gate reads diffs with --no-renames), an unusual
    #   name (a space, a non-ASCII character), or a file or symbolic link standing at a listed directory's own path or
    #   a parent's path, which redirects everything the list names below it while no listed path is in the diff (for
    #   .claude also nested, as the gate treats a nested .claude/ component, case (18)); also when it is mixed with a
    #   class-normal change.
    # - Examples: the lettered cases of each path, at least two per path; across the eight every form appears, and the
    #   link form for every directory path ((21c), (22c), (23c), (24b), (24c), (25b), (25c), (26b), (27b), (27c)).
    # - Negative control: each lettered case: no verdict, so GATE FAIL, exit 1 and a "class high:" line naming the
    #   touched path. (23g): the fixture's guard denies (23a)'s merge_pull_request by rule M7.
    # - Positive control: (NNp): the first pull request of the path, with a PASS verdict it adds naming its reviewed
    #   head (independence and checker_run fields, as the fixture's verdicts have them), gives GATE PASS, exit 0 and
    #   "covered by"; (23h): the guard then allows the merge by rule M7.
    # - Break: in a copy of the gate, every rule that classes the path is removed (for CLAUDE.md and .claude/ more
    #   than one rule does), one path at a time; that path's lettered cases must then print BAD and the run
    #   MERGE_GATE_TEST FAIL. Procedure and commands: evidence/C02/raw/W-C02-19_tests_before_change.md.
    # - Stage and environment: C02; a scratch fixture repository with a local bare origin, the gate run as M7 runs it.
    # - Independence: written by W-C02-19's test designer before the gate change; run by the producer, and again by a
    #   fresh-context checker that builds the breaks itself and judges from the raw output.
    # - Evidence layer: structural (the gate's class rules); (23g) and (23h) behavioural, at the guard's M7 call.
    # - Evidence envelope: the commit, the command and the raw output of each run, in W-C02-19's record.

    # (20) CLAUDE.md: deleted; renamed out (its old path is in the diff).
    pr, x = neg("(20a) CLAUDE.md: deleted, no verdict: GATE FAIL naming CLAUDE.md", "CLAUDE.md", ("remove", "CLAUDE.md"))
    pos(pr, x, 20, "(20p) CLAUDE.md: (20a) with a covering verdict it adds: GATE PASS, covered by")
    neg("(20b) CLAUDE.md: renamed out (to archive/rules-old.md), no verdict: GATE FAIL naming CLAUDE.md", "CLAUDE.md",
        ("move", "CLAUDE.md", "archive/rules-old.md"))
    # (21) .claude/: a new file one level down; a file renamed into it; a symbolic link at a nested .claude path.
    p = ".claude/protocols/D10.md"
    pr, x = neg(f"(21a) .claude/: a new file one level down ({p}), no verdict: GATE FAIL naming it", p,
                ("write", p, "a fixture protocol\n"))
    pos(pr, x, 21, "(21p) .claude/: (21a) with a covering verdict it adds: GATE PASS, covered by")
    neg("(21b) .claude/: plan/notes.md renamed into it (.claude/notes.md), no verdict: GATE FAIL naming "
        ".claude/notes.md", ".claude/notes.md", ("move", "plan/notes.md", ".claude/notes.md"))
    neg("(21c) .claude/: a symbolic link at a nested .claude path (docs/.claude -> ../.claude), no verdict: GATE FAIL "
        "naming docs/.claude", "docs/.claude", ("link", "docs/.claude", "../.claude"))
    # (22) methods/: a new file one level down; a non-ASCII name; a symbolic link at its own path.
    p = "methods/review/checklist.md"
    pr, x = neg(f"(22a) methods/: a new file one level down ({p}), no verdict: GATE FAIL naming it", p,
                ("write", p, "a fixture method\n"))
    pos(pr, x, 22, "(22p) methods/: (22a) with a covering verdict it adds: GATE PASS, covered by")
    p = "methods/ölçüm-yöntemi.md"
    neg(f"(22b) methods/: a new file with a non-ASCII name ({p}), no verdict: GATE FAIL naming it", p,
        ("write", p, "a fixture method\n"))
    neg("(22c) methods/: a symbolic link at its own path (methods -> docs), no verdict: GATE FAIL naming methods",
        "methods", ("link", "methods", "docs"))
    # (23) supabase/migrations/: a new migration, with the route M7 takes ((23g), (23h), as (1g) and (2g)); a name
    # with a space; a symbolic link at its own path; mixed with a class-normal path; deleted ((23e), below).
    p = "supabase/migrations/20261012000001_fixture_item.sql"
    pr, x = neg(f"(23a) supabase/migrations/: a new migration ({p}), no verdict: GATE FAIL naming it", p,
                ("write", p, SQL))
    dec, why = s.guard(pr, x)
    case("(23g) supabase/migrations/: the guard denies (23a)'s merge by rule M7", dec == "deny" and "rule M7" in why,
         why)
    h = pos(pr, x, 23, "(23p) supabase/migrations/: (23a) with a covering verdict it adds: GATE PASS, covered by")
    dec, why = s.guard(pr, h)
    case("(23h) supabase/migrations/: the guard allows that merge by rule M7 once (23p)'s verdict is added",
         dec == "allow" and "rule M7" in why and "covered by" in why, why)
    p = "supabase/migrations/20261012000002 fixture index.sql"
    neg(f"(23b) supabase/migrations/: a new file whose name has a space ({p}), no verdict: GATE FAIL naming it", p,
        ("write", p, "create index fixture_idx on fixture_item (id);\n"))
    neg("(23c) supabase/migrations/: a symbolic link at its own path (supabase/migrations -> ../docs), no verdict: "
        "GATE FAIL naming supabase/migrations", "supabase/migrations", ("link", "supabase/migrations", "../docs"))
    p = "supabase/migrations/20261012000003_fixture_mixed.sql"
    neg(f"(23d) supabase/migrations/: a pull request mixing a new migration ({p}) with a class-normal change "
        "(plan/notes.md), no verdict: GATE FAIL naming the migration", p, ("write", p, SQL),
        ("append", "plan/notes.md", "a class-normal change beside a migration"))
    # (24) supabase/functions/: a new function one level down; symbolic links at its own and its parent's path;
    # changed ((24d), below).
    fn = "supabase/functions/fixture-hello/index.ts"
    pr, x = neg(f"(24a) supabase/functions/: a new function one level down ({fn}), no verdict: GATE FAIL naming it",
                fn, ("write", fn, TS))
    pos(pr, x, 24, "(24p) supabase/functions/: (24a) with a covering verdict it adds: GATE PASS, covered by")
    neg("(24b) supabase/functions/: a symbolic link at its own path (supabase/functions -> ../docs), no verdict: "
        "GATE FAIL naming supabase/functions", "supabase/functions", ("link", "supabase/functions", "../docs"))
    neg("(24c) supabase/functions/ and supabase/migrations/: a symbolic link at their parent's path (supabase -> "
        "docs), no verdict: GATE FAIL naming supabase", "supabase", ("link", "supabase", "docs"))
    # (25) pipelines/: a new file one level down; a regular file and a symbolic link at its own path; changed and
    # renamed out ((25d), (25e), below).
    p = "pipelines/embedding/embed.py"
    pr, x = neg(f"(25a) pipelines/: a new file one level down ({p}), no verdict: GATE FAIL naming it", p,
                ("write", p, PY))
    pos(pr, x, 25, "(25p) pipelines/: (25a) with a covering verdict it adds: GATE PASS, covered by")
    neg("(25b) pipelines/: a regular file at its own path (pipelines), no verdict: GATE FAIL naming pipelines",
        "pipelines", ("write", "pipelines", "a fixture file where the directory would stand\n"))
    neg("(25c) pipelines/: a symbolic link at its own path (pipelines -> docs), no verdict: GATE FAIL naming "
        "pipelines", "pipelines", ("link", "pipelines", "docs"))
    # (26) .github/workflows/: a new workflow whose name has a space; a symbolic link at its own path; deleted
    # ((26c), below). Its parent .github: (27b), (27c).
    p = ".github/workflows/nightly fixture.yml"
    pr, x = neg(f"(26a) .github/workflows/: a new workflow whose name has a space ({p}), no verdict: GATE FAIL "
                "naming it", p, ("write", p, YML))
    pos(pr, x, 26, "(26p) .github/workflows/: (26a) with a covering verdict it adds: GATE PASS, covered by")
    neg("(26b) .github/workflows/: a symbolic link at its own path (.github/workflows -> ../docs), no verdict: "
        "GATE FAIL naming .github/workflows", ".github/workflows", ("link", ".github/workflows", "../docs"))
    # (27) .github/CODEOWNERS: new; a symbolic link and a regular file at its parent's path .github; changed and
    # renamed out ((27d), (27e), below).
    pr, x = neg("(27a) .github/CODEOWNERS: a new file, no verdict: GATE FAIL naming .github/CODEOWNERS",
                ".github/CODEOWNERS", ("write", ".github/CODEOWNERS", OWNERS))
    pos(pr, x, 27, "(27p) .github/CODEOWNERS: (27a) with a covering verdict it adds: GATE PASS, covered by")
    neg("(27b) .github/CODEOWNERS and .github/workflows/: a symbolic link at their parent's path (.github -> docs), "
        "no verdict: GATE FAIL naming .github", ".github", ("link", ".github", "docs"))
    neg("(27c) .github/CODEOWNERS and .github/workflows/: a regular file at their parent's path (.github), no "
        "verdict: GATE FAIL naming .github", ".github", ("write", ".github", "a fixture file where a directory "
                                                          "would stand\n"))
    # Main now holds made-up files under the listed paths (merged in the fixture without the gate), for the forms
    # that need a file already there: changed, deleted, renamed out.
    mig, run_py, ci = "supabase/migrations/20261001000000_fixture_init.sql", "pipelines/ingest/run.py", \
        ".github/workflows/ci.yml"
    s.branch("seed")
    for p, text in ((mig, SQL), (fn, TS), (run_py, PY), (ci, YML), (".github/CODEOWNERS", OWNERS)):
        s.write(p, text)
    s.commit("made-up files under the listed paths")
    s.merge("seed")
    neg(f"(23e) supabase/migrations/: a migration deleted ({mig}), no verdict: GATE FAIL naming it", mig,
        ("remove", mig))
    neg(f"(24d) supabase/functions/: a function changed ({fn}), no verdict: GATE FAIL naming it", fn,
        ("append", fn, "// a fixture change"))
    neg(f"(25d) pipelines/: a file changed ({run_py}), no verdict: GATE FAIL naming it", run_py,
        ("append", run_py, "# a fixture change"))
    neg(f"(25e) pipelines/: a file renamed out ({run_py} to archive/run.py), no verdict: GATE FAIL naming {run_py}",
        run_py, ("move", run_py, "archive/run.py"))
    neg(f"(26c) .github/workflows/: a workflow deleted ({ci}), no verdict: GATE FAIL naming it", ci, ("remove", ci))
    neg("(27d) .github/CODEOWNERS: changed, no verdict: GATE FAIL naming .github/CODEOWNERS", ".github/CODEOWNERS",
        ("append", ".github/CODEOWNERS", "/docs/ fixture@example.invalid"))
    neg("(27e) .github/CODEOWNERS: renamed out (to archive/CODEOWNERS.old), no verdict: GATE FAIL naming "
        ".github/CODEOWNERS", ".github/CODEOWNERS", ("move", ".github/CODEOWNERS", "archive/CODEOWNERS.old"))

    # (28) Point 2 of W-C02-19: the gate follows plan 6.7's list, not a copy of it. Form C0:
    # - Claim: every path plan 6.7's "High-impact path list" bullet names, read from the plan at the tested commit, is
    #   class high in the gate, and the bullet names point 1's eight.
    # - Failure class: the plan's list and the gate's rules part: a path added to or renamed in the bullet that the
    #   gate does not class; the bullet moved, reworded or removed, or the plan file missing, read as a pass.
    # - Examples: today's five unclassed paths; a ninth path added to the bullet; the bullet removed; the file missing.
    # - Negative control: a listed path the gate does not class, or a set other than the eight, gives BAD; a missing or
    #   unreadable plan file or bullet is printed as "could not check" and gives BAD (plan Section 8 item 14).
    # - Positive control: at a head whose gate classes the eight, the eight are found, each class high: ok.
    # - Break, in a scratch copy: a ninth synthetic path added to the bullet: BAD; the bullet removed, or the plan
    #   file deleted: "could not check", BAD; a path's class rules removed from the gate (point 1's break): BAD.
    # - Stage, independence, evidence layer (structural) and envelope: as for (20) to (27).
    label = ("(28) every path that plan 6.7's \"High-impact path list\" names (read from plan/DevOS_Kurulum_Plani.md) "
             "is class high, and the list names the eight of (20) to (27)")
    paths, skipped, problem = plan_list()
    if problem:
        print(f"     plan 6.7: could not check: {problem}")
        case(label, False, f"could not check: {problem}")
    else:
        found = list(dict.fromkeys(paths))
        print(f"     plan 6.7: {len(found)} backticked paths found: {', '.join(found) or 'none'}")
        print("     plan 6.7: skipped, as it names no path: " + (repr(NO_PATH) if skipped else "nothing (not found)"))
        low = []
        for p in found:
            touched = p + "fixture-probe/probe.txt" if p.endswith("/") else p
            if not re.fullmatch(r"[\w.-]+(/[\w.-]+)*/?", p) or ".." in p.split("/"):
                low.append(f"{p} (not a relative repository path; not probed)")
                continue
            pr = next(prs)
            try:
                rc, out = s.gate(pr, s.planted(pr, ("append", touched, "a fixture change to a path plan 6.7 lists")))
            except (OSError, AssertionError) as e:
                s.git("reset", "-q", "--hard")
                s.git("clean", "-qfd")
                low.append(f"{p} (could not plant {touched}: {e})")
                continue
            if not (rc == 1 and "GATE FAIL" in out and high_named(out, touched)):
                low.append(p)
        missing, extra = [p for p in LISTED if p not in found], [p for p in found if p not in LISTED]
        print(f"     plan 6.7: not class high: {', '.join(low) or 'none'}; of the eight, not in the list: "
              f"{', '.join(missing) or 'none'}; in the list, not of the eight: {', '.join(extra) or 'none'}")
        case(label, not (low or missing or extra),
             f"not class high: {low}; of the eight, not in the list: {missing}; not of the eight: {extra}")

    # (29) Point 3 (b) of W-C02-19: near misses stay class normal. Form C0:
    # - Claim: no path's class changes but the eight's and the link form's ((20) to (27)).
    # - Failure class: a rule wider than the list: a prefix without the path boundary (supabase/migrations-notes.md,
    #   methods.md, pipelines-old/x.py, .github/CODEOWNERS.md); a listed directory's name anywhere in the path
    #   (docs/methods/x.md, tests/supabase/migrations/x.sql, tests/pipelines/x.py, a link tests/methods); all of
    #   supabase/ or .github/ (supabase/config.toml, supabase/seed.sql, .github/ISSUE_TEMPLATE/x.md).
    # - Examples: (29a) to (29k).
    # - Negative control: each near miss, with no verdict, must give GATE PASS and "class normal"; a wider rule gives BAD.
    # - Positive control: (20) to (27): the listed paths themselves stay class high.
    # - Break, in a copy of the gate: a prefix rule without the trailing "/" for the listed directories and
    #   .github/CODEOWNERS, or a rule classing any path with a component named like a listed directory: the matching
    #   near misses print BAD.
    # - Stage, independence, evidence layer (structural) and envelope: as for (20) to (27).
    near = ("supabase/config.toml", "supabase/seed.sql", "supabase/migrations-notes.md", "methods.md",
            "pipelines-old/x.py", ".github/CODEOWNERS.md", "docs/methods/x.md", "tests/supabase/migrations/x.sql",
            "tests/pipelines/x.py", ".github/ISSUE_TEMPLATE/x.md")
    for letter, p in zip("abcdefghij", near):
        pr = next(prs)
        rc, out = s.gate(pr, s.planted(pr, ("write", p, "a fixture near miss\n")))
        case(f"(29{letter}) near miss {p}, no verdict: GATE PASS, class normal", rc == 0 and "GATE PASS" in out and
             "class normal" in out, out)
    pr = next(prs)
    rc, out = s.gate(pr, s.planted(pr, ("link", "tests/methods", "../docs")))
    case("(29k) near miss tests/methods, a symbolic link named like a listed directory below another directory, no "
         "verdict: GATE PASS, class normal", rc == 0 and "GATE PASS" in out and "class normal" in out, out)

    # (30) Point 3 (d) of W-C02-19: unreadable input still fails closed. Form C0:
    # - Claim: a file name under a listed path that is not valid UTF-8 never gives GATE PASS.
    # - Failure class: a name the gate cannot decode is dropped, replaced or skipped, so the diff looks class normal.
    # - Examples: (30a) under supabase/migrations/ (newly classed), (30b) under .github/workflows/ (classed before).
    # - Negative control: each case: GATE FAIL or GATE ERROR, exit 1 or 2, and no GATE PASS line.
    # - Positive control: (22b): a valid non-ASCII name is read and classed, not an error.
    # - Break, in a copy of the gate: changed() returns no paths when the diff cannot be decoded: GATE PASS, BAD.
    # - Stage, independence, evidence layer (structural) and envelope: as for (20) to (27).
    for letter, raw in (("a", b"supabase/migrations/20261012000009_fixture_\xff.sql"),
                        ("b", b".github/workflows/fixture_\xfe.yml")):
        p = os.fsdecode(raw)
        pr = next(prs)
        rc, out = s.gate(pr, s.planted(pr, ("write", p, "select 1;\n")))
        case(f"(30{letter}) a file name that is not valid UTF-8 under {raw.split(b'/')[0].decode()}/"
             f"{raw.split(b'/')[1].decode()}/: GATE FAIL or GATE ERROR, never GATE PASS",
             rc in (1, 2) and ("GATE FAIL" in out or "GATE ERROR" in out) and "GATE PASS" not in out, out)


def main():
    with tempfile.TemporaryDirectory() as tmp:
        s = Fixture(Path(tmp))
        # (1) class normal
        s.branch("pr1")
        s.append("plan/notes.md", "a class-normal change")
        s.commit("a class-normal change")
        h1 = s.push(1)
        rc, out = s.gate(1, h1)
        case("(1) a class-normal head passes without a verdict", rc == 0 and "GATE PASS" in out and
             "class normal" in out, out)
        dec, why = s.guard(1, h1)
        case("(1g) the guard allows that merge by rule M7, which runs tools/merge_gate.py",
             dec == "allow" and "rule M7" in why and "GATE PASS" in why, why)
        # (2) class high, no verdict
        s.branch("pr2")
        s.append("CLAUDE.md", "a class-high change")
        x2 = s.commit("a class-high change")
        s.push(2)
        rc, out = s.gate(2, x2)
        case("(2) a class-high head without a verdict fails", rc == 1 and "GATE FAIL" in out and
             "class high: CLAUDE.md" in out, out)
        dec, why = s.guard(2, x2)
        case("(2g) the guard denies that merge by rule M7", dec == "deny" and "rule M7" in why, why)
        # (3) the checker's verdict on the reviewed commit, written on the branch
        h3 = s.verdict(1, x2)
        s.push(2)
        rc, out = s.gate(2, h3)
        case("(3) the same change with a PASS verdict naming the reviewed commit passes", rc == 0 and
             "covered by evidence/C00/checks/CHK-C00-001.md" in out, out)
        rc, out = s.gate(2, x2)
        case("(4) a SHA that is no longer the pull request's head fails", rc == 1 and "head moved" in out, out)
        # (5, 6) a verdict for an older commit X covers only while X..head is class normal
        s.append("plan/notes.md", "a class-normal change after the review")
        h5 = s.commit("a class-normal change after the review")
        s.push(2)
        rc, out = s.gate(2, h5)
        case("(5) a verdict for an older X passes when X..head is class normal", rc == 0 and "covered by" in out, out)
        s.append(".claude/agents/checker.md", "a class-high change after the review")
        h6 = s.commit("a class-high change after the review")
        s.push(2)
        rc, out = s.gate(2, h6)
        case("(6) a verdict for an older X fails when X..head touches a class-high path", rc == 1 and
             "touches class-high paths: .claude/agents/checker.md" in out, out)
        # (7, 8, 9) verdict files that do not cover
        for n, label, kw, want in ((2, "a FAIL verdict", {"verdict": "FAIL"}, "is not PASS"),
                                   (3, "a verdict without the independence field", {"independence": ""},
                                    "field is missing"),
                                   (4, "a verdict naming a short SHA", {}, "not a full 40-character SHA")):
            s.branch(f"pr{n + 5}")
            s.append("CLAUDE.md", f"class-high change {n}")
            x = s.commit(f"class-high change {n}")
            h = s.verdict(n, x[:12] if n == 4 else x, **kw)
            s.push(n + 5)
            rc, out = s.gate(n + 5, h)
            case(f"({n + 5}) {label} does not cover", rc == 1 and want in out, out)
        # (10) a short head SHA: the gate fails and the guard denies by M6 before the gate runs
        rc, out = s.gate(1, h1[:7])
        dec, why = s.guard(1, h1[:7])
        case("(10) a short head SHA fails in the gate and is denied by the guard's M6", rc == 1 and
             "not a full 40-character SHA" in out and dec == "deny" and "rule M6" in why, out + why)
        # (11) owned_ids.txt: added recorder lines are class normal, any other change is class high
        s.branch("pr11")
        s.append(".claude/hooks/owned_ids.txt", "session_FIXTURE123")
        s.commit("recorder line")
        rc, out = s.gate(11, s.push(11))
        case("(11) a change that only adds recorder lines to owned_ids.txt is class normal", rc == 0, out)
        s.append(".claude/hooks/owned_ids.txt", "not an ID")
        s.commit("another line")
        rc, out = s.gate(11, s.push(11))
        case("(11b) any other change to owned_ids.txt is class high", rc == 1 and "not only added recorder lines" in
             out, out)
        # (12) a pull request the remote does not hold
        rc, out = s.gate(99, h1)
        case("(12) a pull request number the remote does not hold fails", rc == 1 and "cannot fetch" in out, out)
        # (13) the working order is class high (it replaces the retired plan/Builder_Operating_Model.md)
        s.branch("pr13")
        s.append("plan/Installation_Working_Order.md", "a change to the executor's rules")
        s.commit("working order change")
        rc, out = s.gate(13, s.push(13))
        case("(13) a change to plan/Installation_Working_Order.md is class high", rc == 1 and
             "class high: plan/Installation_Working_Order.md" in out, out)
        # (14, 15, 16) acceptance conditions (R-TRANS-1 B1; probe P1): changing, removing or deleting is class high
        s.branch("pr14")
        s.write("plan/work/W-T-01.md", ITEM.replace("All 20 cases pass, reviewed by a fresh-context checker",
                                                    "Most cases pass"))
        s.commit("loosen an acceptance condition")
        rc, out = s.gate(14, s.push(14))
        case("(14) changing the text of an existing acceptance block is class high", rc == 1 and "GATE FAIL" in out
             and "plan/work/W-T-01.md (an existing acceptance block changed or removed)" in out, out)
        s.branch("pr14b")
        s.write("plan/work/W-T-01.md", ITEM.split("<!-- acceptance -->")[0] + "## Notes\n")
        s.commit("remove an acceptance block")
        rc, out = s.gate(14, s.push(14))
        case("(14b) removing an existing acceptance block is class high", rc == 1 and
             "plan/work/W-T-01.md (an existing acceptance block changed or removed)" in out, out)
        s.branch("pr15")
        s.git("rm", "-q", "plan/work/W-T-01.md")
        s.commit("delete a work item file")
        rc, out = s.gate(15, s.push(15))
        case("(15) deleting a plan/work/*.md file is class high", rc == 1 and
             "plan/work/W-T-01.md (work item file deleted)" in out, out)
        s.branch("pr16")
        s.append("plan/work/T01.md", "<!-- acceptance -->\nA new condition\n<!-- /acceptance -->")
        s.write("plan/work/W-T-02.md", ITEM.replace("W-T-01", "W-T-02"))
        s.append("plan/work/W-T-01.md", "A note outside the acceptance block.")
        s.commit("add acceptance blocks where none existed")
        rc, out = s.gate(16, s.push(16))
        case("(16) adding a block where none existed, and editing outside a block, stay class normal", rc == 0 and
             "class normal" in out, out)
        # (17) a repeated front-matter key fails closed (R-TRANS-1 m1; probe P3)
        s.branch("pr17")
        s.append("CLAUDE.md", "class-high change 17")
        x = s.commit("class-high change 17")
        s.verdict(8, x, verdict="FAIL\nverdict: PASS")
        rc, out = s.gate(17, s.push(17))
        case("(17) a verdict file with a repeated key does not cover", rc == 1 and "a key repeats" in out, out)
        # (18) nested rule files are class high (R-TRANS-1 m2; probe P4)
        s.branch("pr18")
        s.write("plan/CLAUDE.md", "nested rules\n")
        s.write("docs/.claude/settings.json", "{}\n")
        s.commit("nested rule files")
        rc, out = s.gate(18, s.push(18))
        case("(18) a nested CLAUDE.md and a nested .claude/ path are class high", rc == 1 and
             "docs/.claude/settings.json" in out and "plan/CLAUDE.md" in out, out)
        # (19) only a verdict the pull request adds, for a commit of the pull request, covers (R-TRANS-1 B2; probe P2)
        s.branch("prA")
        s.append("CLAUDE.md", "rule A")
        rules_a = (s.d / "CLAUDE.md").read_text()
        xa = s.commit("rule A")
        s.verdict(5, xa)
        s.merge("prA")
        s.branch("prB")
        s.append("CLAUDE.md", "security rule B")
        s.verdict(6, s.commit("security rule B"))
        s.merge("prB")
        s.branch("prC")
        s.write("CLAUDE.md", rules_a)
        s.commit("remove rule B")
        rc, out = s.gate(19, s.push(19))
        case("(19) a pull request that reverts a reviewed change, adding no verdict, is not covered by an older "
             "verdict on main", rc == 1 and "class high: CLAUDE.md" in out and "GATE FAIL" in out, out)
        s.verdict(7, xa)
        rc, out = s.gate(19, s.push(19))
        case("(19b) a verdict the pull request adds for a commit already on main does not cover", rc == 1 and
             "is an ancestor of the merge base" in out, out)
        listed_paths(s)
    ok = bool(RESULTS) and all(RESULTS)
    print(f"MERGE_GATE_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
