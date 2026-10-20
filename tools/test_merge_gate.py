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
Cases (N270*) (note N-270 on plan/work/C02.md; tests/C02/N-269_N-270/README.md): tests/C02/W-C02-07/shared/, whose
two files guard rule L4 reads at every call, is class high in every form a change touches it, and the rest of
tests/C02/W-C02-07/ stays class normal. Their pull requests are 700 up and their verdicts CHK-C00-070 up.
Cases (RP*) (W-C02-23, PR-A2): the gate runs its own tree's tools/check_role_packages.py --rev <head> for a head
that touches the role packages' trigger set, in a fixture of their own (role_package_gate).
Cases (B1*) to (B9*) and (R1) to (R7) (W-C02-24 M1b, Part B of its acceptance block): the verdict keys and grammars,
the floor paths, the condition lines, the diff-confirmed closure, the writes: rule, approach blocks, the revert route
and the template, in a fixture of their own (m1b); the Form C0 block and the interface they state stand above m1b.
Every fixture verdict is written in the new form (verdict_text). An optional first argument names the gate to test.
Prints one line per case and MERGE_GATE_TEST PASS only if every case behaves as written.
"""
import importlib.util
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
REPO = Path(__file__).resolve().parent.parent
# The gate under test: this tree's tools/merge_gate.py, or the path given as the first argument (a checker's break
# copy or a sketch kept outside the repository: python3 tools/test_merge_gate.py /path/to/merge_gate.py).
GATE = [REPO / "tools/merge_gate.py"]
RESULTS = []
INDEPENDENCE = 'independence: "same session, fresh-context subagent (declared, Ek A 373)"\n'
# W-C02-24 M1b (B1, B9): every fixture verdict is written in the new form, so that the older cases keep testing what
# they tested once the gate refuses the old form (B9, disposition 4). One source: verdict_text() below.
AGENT = "a0123456789abcdef"
NEW_KEYS = {"item": "W-C00-01", "triage": "none: a fixture verdict has no triage", "floor": "merge gate (fixture)",
            "own_breaks": "fixture break run: one rule removed, its case red", "shared_with_producer": "none",
            "producer_run": AGENT}
ITEM_C00 = """---
id: W-C00-01
kind: item
parent: C00
title: "a fixture item with no approach block"
admission: admitted
execution: running
acceptance: proposed
---

# W-C00-01

<!-- acceptance -->
A fixture condition.
<!-- /acceptance -->
"""


def verdict_text(n, sha, verdict="PASS", independence=INDEPENDENCE, body="Findings: none (fixture).\n", **over):
    """A fixture verdict file. over: a key's value (written as given, quotes included), None to drop the key, or a
    list to write the key once per element (a repeated key)."""
    keys = {"id": f"CHK-C00-{n:03d}", "target": "the fixture change", "reviewed_head": sha, "verdict": verdict,
            "conditions": "none", "independence": None, "checker_run": "fixture run", "date": "2026-10-05",
            **NEW_KEYS}
    keys.update(over)
    lines = []
    for k, v in keys.items():
        if k == "independence" and "independence" not in over:
            if independence:
                lines.append(independence.rstrip("\n"))
        elif isinstance(v, list):
            lines += [f"{k}: {x}" for x in v]
        elif v is not None:
            lines.append(f"{k}: {v}")
    return "---\n" + "\n".join(lines) + "\n---\n\n" + body
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
        for f, src in (("tools/merge_gate.py", GATE[0]),
                       (".claude/hooks/tool_allowlist.py", REPO / ".claude/hooks/tool_allowlist.py")):
            self.write(f, src.read_text())
        # W-C02-20, rule L4: the guard reads the token formats from these files at every call; copied byte for byte
        for f in ("tests/C02/W-C02-07/shared/scan_patterns.json", "tests/C02/W-C02-07/shared/token_format.md"):
            (self.d / f).parent.mkdir(parents=True, exist_ok=True)
            (self.d / f).write_bytes((REPO / f).read_bytes())
        self.write(".claude/hooks/owned_ids.txt", "# owned IDs\n")
        self.write("CLAUDE.md", "rules\n")
        self.write("plan/notes.md", "notes\n")
        self.write("plan/work/W-T-01.md", ITEM)
        self.write("plan/work/T01.md", "# T01 (a stage file without an acceptance block)\n")
        self.write("plan/work/W-C00-01.md", ITEM_C00)                     # NEW_KEYS' item: (B1)
        self.write("evidence/C00/EV-C00-001_fixture.md", "# a fixture triage record\n")   # a triage: path (B1)
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

    def verdict(self, n, sha, verdict="PASS", independence=INDEPENDENCE, **over):
        self.write(f"evidence/C00/checks/CHK-C00-{n:03d}.md",
                   verdict_text(n, sha, verdict=verdict, independence=independence, **over))
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


def shared_token_files(s):
    """Cases (N270a) to (N270n5): note N-270 (plan/work/C02.md), in W-C02-19's form. Pull requests 700 up, verdicts
    CHK-C00-070 up. The fixture's base holds the two shared files byte for byte (Fixture.__init__)."""
    prs, verdicts = iter(range(700, 800)), iter(range(70, 100))
    sh = "tests/C02/W-C02-07/shared"
    pat, fmt = f"{sh}/scan_patterns.json", f"{sh}/token_format.md"
    # Form C0 (Appendix C), for (N270a) to (N270n5); the breaks and what is not covered: tests/C02/N-269_N-270/README.md.
    # - Claim: tests/C02/W-C02-07/shared/ is class high: a pull request that adds, changes or deletes a file under it
    #   merges only with a covering checker verdict; a file elsewhere under tests/C02/W-C02-07/ stays class normal.
    # - Failure class: a pull request changes what guard rule L4 reads at every call (its finder patterns and the
    #   Finder table they must equal) and merges with no fresh-context verdict: a change to either file, a new file
    #   there, a deletion, a rename out (the gate reads diffs with --no-renames), or the folder replaced by a symbolic
    #   link (its files deleted).
    # - Examples: (N270a) scan_patterns.json changed (the original finding, EV-C02-010 section A.8); (N270b)
    #   token_format.md changed; (N270c) a new file there; (N270d) scan_patterns.json deleted; (N270e) token_format.md
    #   renamed out; (N270f) the folder replaced by a symbolic link.
    # - Negative control: each lettered case: no verdict, so GATE FAIL, exit 1 and a "class high:" line naming the
    #   touched file. (N270g): the fixture's guard denies (N270c)'s merge_pull_request by rule M7.
    # - Positive control: (N270ap) to (N270fp): the same pull request with a PASS verdict it adds naming its head gives
    #   GATE PASS, exit 0 and "covered by"; (N270h): the guard then allows (N270c)'s merge by rule M7. (N270n1) to
    #   (N270n5): the rest of tests/C02/W-C02-07/ and near misses stay class normal with no verdict.
    # - Break: in a copy of the gate, the folder's class rule removed (the gate at main f39c96f): every lettered case,
    #   its verdict case, (N270g) and (N270h) print BAD; a rule without the path boundary, for the whole of
    #   tests/C02/W-C02-07/, for any component named shared, or by substring: the matching (N270n*) case prints BAD.
    # - Stage and environment: C02; the fixture repository with a local bare origin, the gate run as M7 runs it.
    # - Independence: written by a test designer (a fresh-context subagent) before the gate change; run by the
    #   producer, and again by a fresh-context checker that builds the breaks itself.
    # - Evidence layer: structural (the gate's class rules); (N270g) and (N270h) behavioural, at the guard's M7 call.
    # - Evidence envelope: the commit, the command and the raw output of each run, in the change's record.

    def high(cid, label, path, *steps, guard=False):
        """Negative control, then positive: a pull request made by steps, with no verdict GATE FAIL, exit 1 and a
        "class high:" line naming path; with a PASS verdict it adds naming its head, GATE PASS, exit 0, "covered by"."""
        pr = next(prs)
        head = s.planted(pr, *steps)
        rc, out = s.gate(pr, head)
        case(f"(N270{cid}) {label}, no verdict: GATE FAIL naming {path}",
             rc == 1 and "GATE FAIL" in out and high_named(out, path), out)
        if guard:
            dec, why = s.guard(pr, head)
            case(f"(N270g) the guard denies (N270{cid})'s merge by rule M7", dec == "deny" and "rule M7" in why, why)
        h = s.verdict(next(verdicts), head)
        s.push(pr)
        rc, out = s.gate(pr, h)
        case(f"(N270{cid}p) {label}, with a covering verdict it adds: GATE PASS, covered by",
             rc == 0 and "GATE PASS" in out and "covered by" in out, out)
        if guard:
            dec, why = s.guard(pr, h)
            case(f"(N270h) the guard allows (N270{cid})'s merge by rule M7 once its verdict is added",
                 dec == "allow" and "rule M7" in why and "covered by" in why, why)

    def normal(cid, label, *steps):
        """A pull request made by steps, no verdict: GATE PASS, exit 0, class normal."""
        pr = next(prs)
        rc, out = s.gate(pr, s.planted(pr, *steps))
        case(f"(N270{cid}) {label}, no verdict: GATE PASS, class normal",
             rc == 0 and "GATE PASS" in out and "class normal" in out, out)

    # Main also holds a made-up README beside the shared folder (merged in the fixture without the gate), so that a
    # change to another file of tests/C02/W-C02-07/ can be planted.
    s.branch("seed-w07")
    s.write("tests/C02/W-C02-07/README.md", "# a fixture README of the test folder\n")
    s.commit("a made-up README under tests/C02/W-C02-07/")
    s.merge("seed-w07")
    patterns = json.loads((s.d / pat).read_text(encoding="utf-8"))
    patterns["n270_fixture_note"] = "a fixture change beside the token patterns, which stay as they are"
    high("a", "tests/C02/W-C02-07/shared/: scan_patterns.json changed (a key added)", pat,
         ("write", pat, json.dumps(patterns, indent=2) + "\n"))
    high("b", "tests/C02/W-C02-07/shared/: token_format.md changed (a line appended)", fmt,
         ("append", fmt, "A fixture line after the last section."))
    p = f"{sh}/n270_fixture_note.md"
    high("c", f"tests/C02/W-C02-07/shared/: a new file ({p})", p, ("write", p, "a fixture note\n"), guard=True)
    high("d", "tests/C02/W-C02-07/shared/: scan_patterns.json deleted", pat, ("remove", pat))
    high("e", "tests/C02/W-C02-07/shared/: token_format.md renamed out (to tests/C02/W-C02-07/token_format_old.md)",
         fmt, ("move", fmt, "tests/C02/W-C02-07/token_format_old.md"))
    high("f", "tests/C02/W-C02-07/shared/: the folder replaced by a symbolic link (to archive/w07-shared-old, where "
              "its files moved)", pat, ("move", sh, "archive/w07-shared-old"),
         ("link", sh, "../../../archive/w07-shared-old"))
    normal("n1", "tests/C02/W-C02-07/README.md changed (another file of the test folder)",
           ("append", "tests/C02/W-C02-07/README.md", "a fixture change"))
    normal("n2", "a new file under tests/C02/W-C02-07/job/ (another folder of the test folder)",
           ("write", "tests/C02/W-C02-07/job/n270_fixture_case.sql", "select 1;\n"))
    normal("n3", "near miss tests/C02/W-C02-07/shared-old/scan_patterns.json (the folder's name without its boundary)",
           ("write", "tests/C02/W-C02-07/shared-old/scan_patterns.json", "{}\n"))
    normal("n4", "near miss tests/C02/W-C02-08/shared/scan_patterns.json (a folder named shared under another item)",
           ("write", "tests/C02/W-C02-08/shared/scan_patterns.json", "{}\n"))
    normal("n5", "near miss docs/tests/C02/W-C02-07/shared/token_format.md (the folder's path below another directory)",
           ("write", "docs/tests/C02/W-C02-07/shared/token_format.md", "a fixture near miss\n"))


def role_package_gate(tmp):
    """Cases (RP1) to (RP8): W-C02-23 (PR-A2; SB-COR 2.3; EV-C02-028 part 10.1, agreed (5)), written by its test
    designer before the change. (RP9), at the end: W-C02-25's agent hooks in the trigger set, its own form there. A fixture of its own (tmp), whose main holds the six fixture packages, the records
    they cite and the compaction hook, all built by tools/test_check_role_packages.py's build_tree (their one source),
    and a copy of this working tree's tools/check_role_packages.py. Every head carries a covering PASS verdict (except
    RP7), so a refusal can come only from the role-package check. The gate is always run from the fixture's main
    checkout, as M7 runs it from the live tree at main; so the working tree's copy of the check is main's.
    Form C0 (Appendix C):
    - Claim: the gate runs its own tree's tools/check_role_packages.py --rev <head> whenever the head's diff from main
      touches .claude/roles/, .claude/hooks/reread_after_compact.py or tools/check_role_packages.py, and refuses the
      merge on FAIL or COULD NOT CHECK with the check's lines; it does not run it for a head outside that set.
    - Failure class: the call missing; a trigger set that misses an input the check reads (a head that only grows
      MESSAGE; a head that only changes the check); the head's own copy of the check run, so a head can raise LIMIT
      in it; a could-not-check result read as a pass; the check run on every head (a lock-out surface, RP7).
    - Examples: RP2 (size), RP3 (MESSAGE only), RP4 (LIMIT raised in the head's copy), RP5 (could not check), RP6 (a
      package deleted), RP8 (only the check changed).
    - Negative control: each of those: GATE FAIL, exit 1, the check's FAIL line or COULD NOT CHECK in the output.
    - Positive control: RP1 (a sound change to a package: GATE PASS with ROLE_PACKAGES PASS); RP7 (a head outside the
      set passes while main's own packages fail the check, and no ROLE_PACKAGE line is printed).
    - Break: in a copy of the gate: the call removed (RP1 to RP3, RP4b, RP5, RP6, RP8b BAD); the hook path dropped
      from the trigger set (RP3, RP5); the check's path dropped (RP8b); the head's copy run (git show <head>:...)
      (RP4b); the check run on every head (RP7, and every older case, whose fixture holds no check); a could-not-check
      exit read as a pass (RP5). Stage and environment: C02; the container's python3 and git, a scratch fixture with a
      local bare origin, the gate run as M7 runs it. Evidence envelope: W-C02-23's record.
    """
    tool, hook = "tools/check_role_packages.py", ".claude/hooks/reread_after_compact.py"
    if not (REPO / tool).is_file():
        case("(RP0) the role-package gate cases need tools/check_role_packages.py beside this file", False,
             f"{tool} absent")
        return
    spec = importlib.util.spec_from_file_location("test_check_role_packages", REPO / "tools/test_check_role_packages.py")
    tcr = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(tcr)
    tmp.mkdir()
    s = Fixture(tmp)
    tool_bytes = (REPO / tool).read_bytes()
    tcr.build_tree(s.d, packages={"executor.md": tcr.pad(tcr.PACKAGE.format(role="executor"), 9000)},
                   extra={tool: tool_bytes})
    s.commit("role packages, their check and the records they cite")
    s.git("push", "-q", "origin", "main")
    prs, ns = iter(range(1, 100)), iter(range(1, 100))

    def head_with(files=None, remove=(), verdict=True):
        pr = next(prs)
        s.branch(f"pr{pr}")
        for p, b in (files or {}).items():
            (s.d / p).parent.mkdir(parents=True, exist_ok=True)
            (s.d / p).write_bytes(b)
        for p in remove:
            s.remove(p)
        x = s.commit(f"fixture pull request {pr}")
        if verdict:
            s.verdict(next(ns), x)
        return pr, s.push(pr)

    def gate_main(pr, head):
        s.git("checkout", "-q", "main")
        return s.gate(pr, head)

    def fail_line(out, name, token):
        for line in out.splitlines():
            m = re.fullmatch(rf"ROLE_PACKAGE {re.escape(name)} bytes=\S+ limit=\S+ FAIL (.*)", line.strip())
            if m and token in tcr.tokens(m.group(1)):
                return True
        return False

    def refused(label, pr, head, name, token):
        rc, out = gate_main(pr, head)
        case(label, rc == 1 and "GATE FAIL" in out and "GATE PASS" not in out and fail_line(out, name, token) and
             "ROLE_PACKAGES FAIL" in out, out)

    sound = tcr.PACKAGE.format(role="producer") + "One more sound line.\n"
    pr, head = head_with({".claude/roles/producer.md": sound.encode("utf-8")})
    rc, out = gate_main(pr, head)
    case("(RP1) a sound change to producer.md with a covering verdict: GATE PASS, and the output carries "
         "ROLE_PACKAGES PASS", rc == 0 and "GATE PASS" in out and "ROLE_PACKAGES PASS" in out, out)
    # W-C02-24 M1b, B2: tools/check_role_packages.py is a floor path. Run here, where the check exists and main's
    # packages pass it, so that the role-package call passes and only the floor rule can refuse.
    for label, over, token in (("floor: none", {"floor": "none: no floor path"}, "F-NONE"),
                               ("own_breaks: none", {"own_breaks": "none"}, "F-BREAKS"), ("a floor and own breaks",
                                                                                        {}, None)):
        pr = next(prs)
        s.branch(f"pr{pr}")
        (s.d / tool).write_bytes(tool_bytes + b"# a fixture comment line (B2)\n")
        s.verdict(next(ns), s.commit(f"fixture pull request {pr}"), **over)
        rc, out = gate_main(pr, s.push(pr))
        case(f"(B2.rp) a head touching only tools/check_role_packages.py, {label}: " +
             (f"GATE FAIL with [{token}]" if token else "GATE PASS"),
             (rc == 1 and "GATE FAIL" in out and f"[{token}]" in out) if token else (rc == 0 and "GATE PASS" in out),
             out)
    pr, head = head_with({".claude/roles/producer.md": tcr.pad(tcr.PACKAGE.format(role="producer"), 9301)})
    refused("(RP2) producer.md at 9,301 bytes with a covering verdict: GATE FAIL with producer.md's FAIL size line",
            pr, head, "producer.md", "size")
    msg = tcr.real_hook().split('MESSAGE = """', 1)[-1].split('"""', 1)[0]
    grown = tcr.planted_hook('MESSAGE = """' + msg + "x" * 300 + '"""') or ""
    pr, head = head_with({hook: grown.encode("utf-8")})
    only = s.git("diff", "--name-only", "main", head).splitlines()   # the hook and the verdict file, nothing else
    rc, out = gate_main(pr, head)
    case("(RP3) a head that only grows MESSAGE by 300 bytes (executor.md at 9,000 on main): GATE FAIL with "
         "executor.md's FAIL size line", [p for p in only if not p.startswith("evidence/")] == [hook] and rc == 1 and
         "GATE FAIL" in out and
         fail_line(out, "executor.md", "size") and "ROLE_PACKAGES FAIL" in out, f"diff: {only!r}\n{out}")
    src = tool_bytes.decode("utf-8")
    raised = src.replace("LIMIT = 9500 - RESERVE", "LIMIT = 99999", 1)
    pr, head = head_with({tool: raised.encode("utf-8"),
                          ".claude/roles/producer.md": tcr.pad(tcr.PACKAGE.format(role="producer"), 9400)})
    (tmp / "head_copy.py").write_text(raised, encoding="utf-8")
    r = subprocess.run([sys.executable, "-I", str(tmp / "head_copy.py"), "--rev", head], cwd=s.d,
                       capture_output=True, text=True)
    case("(RP4a) the head raises LIMIT in its own copy of the check, and that copy passes its own head",
         raised != src and r.returncode == 0 and "ROLE_PACKAGES PASS" in r.stdout,
         ("the line 'LIMIT = 9500 - RESERVE' is not in the tool\n" if raised == src else "") + r.stdout + r.stderr)
    refused("(RP4b) ... and the gate, running its own tree's copy, refuses it with producer.md's FAIL size line",
            pr, head, "producer.md", "size")
    pr, head = head_with({hook: (tcr.planted_hook('MESSAGE = "a" + "b"') or "").encode("utf-8")})
    rc, out = gate_main(pr, head)
    case("(RP5) a head whose MESSAGE is not a literal: GATE FAIL, and the output carries ROLE_PACKAGES COULD NOT "
         "CHECK", rc == 1 and "GATE FAIL" in out and "GATE PASS" not in out and "ROLE_PACKAGES COULD NOT CHECK" in out,
         out)
    pr, head = head_with(remove=(".claude/roles/checker.md",))
    refused("(RP6) a head that deletes checker.md: GATE FAIL with checker.md's FAIL missing line", pr, head,
            "checker.md", "missing")
    # main now loses a record every package cites (a class-normal records change), so main's packages fail.
    s.git("checkout", "-q", "main")
    s.remove("evidence/C99/EV-C99-001_fixture.md")
    s.commit("a cited record removed on main")
    s.git("push", "-q", "origin", "main")
    r = subprocess.run([sys.executable, "-I", tool, "--rev", "main"], cwd=s.d, capture_output=True, text=True)
    pr, head = head_with({"plan/notes.md": b"notes\na class-normal change\n"}, verdict=False)
    rc, out = gate_main(pr, head)
    case("(RP7) main's packages now fail the check, and a head outside the trigger set still gets GATE PASS with no "
         "ROLE_PACKAGE line", r.returncode == 1 and rc == 0 and "GATE PASS" in out and "ROLE_PACKAGE" not in out,
         f"check at main: exit {r.returncode}\n{r.stdout}\ngate:\n{out}")
    pr, head = head_with({tool: tool_bytes + b"# a comment line added by the fixture\n"})
    only = s.git("diff", "--name-only", "main", head).splitlines()
    case("(RP8a) the RP8 head touches tools/check_role_packages.py and, besides its verdict, nothing else",
         [p for p in only if not p.startswith("evidence/")] == [tool], repr(only))
    refused("(RP8b) ... and the gate refuses that head: GATE FAIL with the packages' FAIL "
            "unresolved lines (EV-C99-001)", pr, head, "producer.md", "unresolved")
    # W-C02-25 (approach "Trigger set"; its condition's point 10 and "Not covered" (h)), added by its producer: the
    # agent hooks deliver the packages, so a head touching only .claude/hooks/agent_hooks.py runs the check. main's
    # packages still fail it here (RP7's removed record), so only the trigger can refuse this head; RP7 is the control
    # (a head outside the set passes). Break: the hook's path dropped from ROLE_PACKAGE_TRIGGER (RP9b turns BAD).
    agent_hooks = ".claude/hooks/agent_hooks.py"
    pr, head = head_with({agent_hooks: b"# a fixture stand-in for the agent hooks (W-C02-25)\n"})
    only = s.git("diff", "--name-only", "main", head).splitlines()
    case("(RP9a) the RP9 head touches .claude/hooks/agent_hooks.py and, besides its verdict, nothing else",
         [p for p in only if not p.startswith("evidence/")] == [agent_hooks], repr(only))
    refused("(RP9b) ... and the gate runs the check for that head: GATE FAIL with the packages' FAIL unresolved lines "
            "(EV-C99-001)", pr, head, "producer.md", "unresolved")


# ------------------------------------------------------------------------------------------------------------------
# W-C02-24 M1b, Part B of plan/work/W-C02-24.md's acceptance block (B1 to B9; B10 through R1). Written by M1b's test
# designer after PR-A2's merge (#421) and before any M1b product, at main 8d90be3. Form C0 (Appendix C), per group:
# - Claim: the merge gate reads the verdict keys and their grammars (B1), the floor-path constant (B2), the condition
#   lines (B3) and the diff-confirmed closure (B4); applies the writes: rule read at the merge base (B5); classes a
#   changed or removed approach block high (B6); evaluates the revert route first, by resulting tree (B7); its key
#   list, checker.md's binding template and working order section 9 are one list, and the filled template passes (B9).
# - Failure class: a verdict whose form the gate cannot read covers a head (a key absent, repeated, outside its grammar,
#   or filled but meaningless); a floor path without own breaks; a blocking condition that still covers; a product path
#   an open item declares, merged under another item's verdict or none; a head escaping by flipping its item's state;
#   an approach block edited without a verdict; a revert route that accepts what is not the inverse, or refuses a true
#   revert; the template drifting from the gate; and over-blocking (a sound verdict, a records-only head, a shared path,
#   a true revert after main moved, a real verdict refused).
# - Examples: at least two per failure class, below; real verdicts CHK-C02-128, 129, 131, 133 and 137 are read from
#   evidence/C02/checks/ beside this file at run time (one source; never copied).
# - Negative control: each refusal asserts GATE FAIL, exit 1 and its own reason ID in brackets (REASONS below); never
#   "any failure".
# - Positive control: each sound case asserts GATE PASS and exit 0; the default verdict (B1.0) passes on each head kind.
# - Break: each case is built so that removing its rule turns it red (the breaks the binding checker applies are listed
#   in the item's B points and in the hand-over of this test designer).
# - Stage and environment: C02; the container's python3 3.13.16 and git 2.43.0 (item C1), a scratch fixture with a
#   local bare origin, the gate run as M7 runs it, from the fixture's checkout of main.
# - Independence: written before the build by a test designer that is not M1b's producer or checker.
# - Evidence layer: structural (the gate's reading of verdict text and git trees). Envelope: the item's record.
#
# The interface these tests state where Part B leaves it open (the producer builds to it; a pin that cannot be built
# goes back to the executor before the build):
# - Reason IDs. Each refusal prints its ID in square brackets on a reason line, e.g. "[K-ABSENT-floor]":
REASONS = {
    "K-ABSENT-<key>": "a required key is absent", "K-REPEAT-<key>": "a key repeats",
    "K-FORM-<key>": "a value outside its grammar (B1); K-FORM-floor's line names the eight floor classes",
    "K-ITEMFILE": "item: names a plan/work/<id>.md absent at the merge base",
    "K-TRIAGEPATH": "triage: names a path absent at the head",
    "P-NONE": "producer_run: none for a verdict that is not a revert, stage or branch verdict",
    "F-NONE": "floor: none on a head touching a floor path", "F-BREAKS": "own_breaks: none (or none...) there",
    "C-FORM": "a line between the markers that does not parse (unknown type, blocks or closure, or malformed)",
    "C-CONTRA": "a type whose blocks: contradicts it", "C-EMPTY": "see markers with no well-formed line",
    "C-OUTSIDE": "a column-0 C<n> · type: line outside the markers", "C-PASSBLOCK": "PASS with a blocking line",
    "C-PWCNONE": "PASS-WITH-CONDITIONS with conditions: none",
    "D-CLOSURE": "a blocks: merge line whose closure is not diff-confirmed",
    "D-NOLATER": "a blocks: merge verdict with nothing but verdict files after reviewed_head",
    "D-HIGHLATER": "a blocks: merge verdict followed by a class-high commit",
    "W-ITEM": "a touched writes: path of an open item is not in the covering verdict's item's writes:",
    "W-NOVERDICT": "a head that is not records-only touches such a path with no covering verdict",
    "W-UNPARSED": "a head touches the file of an item whose writes: does not parse, and no verdict names that item",
    "R-NOTMERGE": "revert <sha>: not a merge commit", "R-NOTMAIN": "revert <sha>: not on origin/main",
    "R-TREE": "revert <sha>: the inverse does not give the head's tree", "R-CONFLICT": "revert <sha>: the inverse "
    "conflicts with origin/main (the route's limit)"}
# - B6's class-high note is "(an existing approach block changed or removed)", as the acceptance block's is.
# - Grammars B1 leaves open, settled here (CHK-C02-131 C2):
#   floor: the list splits at ";" and "," outside parentheses only; a separator inside a parenthesis does not split.
#     Each item is, after trimming, one class (case-insensitive, an optional plural "s"), optionally followed by one
#     balanced parenthesis, and nothing else: no text outside a parenthesis ("guard rail", "public text" refused), no
#     empty item. A merge-gate class value ("class high (...)", CHK-C02-129, CHK-C02-133) is not a floor class and is
#     refused with K-FORM-floor, whose reason line names the eight classes so the checker can rewrite it.
#   B4: "a commit follows reviewed_head" means reviewed_head..head changes a path other than the pull request's verdict
#     files; every blocks: merge line in the markers counts as open (the gate cannot read a closure).
#   B5: the writes: line is the writes: key of the item's approach block (A3's key grammar); it parses when its value
#     is "; "-separated parts, each a repository path or a dir/ prefix with no space and no ".." component, and none
#     the item's own file. A head is records-only when every path it touches is class normal and a record path; these
#     cases pin plan/decisions/*.md and plan/work/*.md as record paths and docs/ as not one. "That item's file" (B5)
#     is read as the item's own plan/work file.
#   B7: the tree compared is the head's tree without the verdict files the pull request adds or changes.
# - Interfaces: python3 -I tools/merge_gate.py --items <rev> prints one line per plan/work/*.md at <rev>,
#   "ITEM <path> <open|closed> writes=<none|ok|unparsed|exempt>[ <text>]", and exits 0 (B5's listing and mirror).
#   tools/merge_gate.py holds VERDICT_KEYS (the template's front-matter keys, in order), REQUIRED_KEYS (a subset that
#   holds at least MIN_REQUIRED) and FLOOR_PATHS (B2's constant).
CLASSES = ("guard", "merge gate", "leak check", "CI gate", "migration", "schema rules", "test oracle", "hook")
FLOOR_PATHS = (".claude/hooks/", ".claude/settings.json", ".github/workflows/", "supabase/migrations/", "tools/")
B1_KEYS = ("item", "triage", "floor", "own_breaks", "shared_with_producer", "producer_run")
MIN_REQUIRED = ("reviewed_head", "verdict", "independence", "checker_run") + B1_KEYS
BLOCK_KEYS = ("base", "asked", "not_asked", "library", "agreed", "writes", "consumer", "dispositions", "open")
COND = "C{n} · type: {t} · blocks: {b} · closure: {c} · {text}"


def item_text(iid, writes=None, admission="admitted", execution="running", acceptance="proposed", accepted_by=None):
    """A fixture work item; writes: the approach block's writes: value (None: no approach block)."""
    head = (f"---\nid: {iid}\nkind: item\nparent: C00\ntitle: \"a fixture item\"\nadmission: {admission}\n"
            f"execution: {execution}\nacceptance: {acceptance}\n" + (f"accepted_by: {accepted_by}\n" if accepted_by
                                                                      else "") + "---\n\n")
    body = f"# {iid}\n\n<!-- acceptance -->\nA fixture condition.\n<!-- /acceptance -->\n"
    if writes is not None:
        vals = {"base": "0" * 40, "asked": "producer: a fixture role (evidence/C00/EV-C00-001_fixture.md)",
                "not_asked": "none", "library": "none", "agreed": "a fixture approach", "writes": writes,
                "consumer": "the fixture", "dispositions": "none", "open": "none"}
        body += "\n## Approach\n\n<!-- approach -->\n" + "".join(f"{k}: {vals[k]}\n" for k in BLOCK_KEYS) + \
            "<!-- /approach -->\n"
    return head + body


# The fixture's items (B5, B6, the mirror): id -> (writes, admission, execution, acceptance, accepted_by), and what
# the gate's listing must print for each at main: (state, writes form or None when not asserted).
M1B_ITEMS = {
    "W-C00-02": (("tools/w02_tool.py; docs/w02/",), ("open", "ok")),
    "W-C00-03": (("tools/shared_tool.py",), ("open", "ok")),
    "W-C00-04": (("tools/shared_tool.py; plan/decisions/PC-99.md",), ("open", "ok")),
    "W-C00-05": (("the item's records and a new test under tools/ (its name the test designer's)",),
                 ("open", "unparsed")),                                                          # prose
    "W-C00-06": (("tools/w06_tool.py",), ("open", "ok")),
    "W-C00-07": (("tools/closed_tool.py", "admitted", "cancelled"), ("closed", None)),
    "W-C00-08": (("tools/w08_tool.py",), ("open", "ok")),
    "W-C00-09": (("tools/w09_tool.py; plan/work/W-C00-09.md",), ("open", "unparsed")),         # its own file
    "W-C00-10": (("tools/w10_a.py, tools/w10_b.py",), ("open", "unparsed")),                   # comma list
    "W-C00-12.3": ((None,), ("open", "none")),                                                 # a dotted ID
    "W-C00-13": ((None, "declined"), ("closed", None)),
    "W-C00-14": ((None, "admitted", "finished", "accepted", "evidence/C00/EV-C00-001_fixture.md"), ("closed", None)),
    "W-C00-15": ((None, "admitted", "finished", "accepted", "evidence/C00/EV-C00-404_absent.md"), ("open", None)),
    "W-C00-16": ((None, "admitted", "finished", "accepted", "plan/notes.md"), ("open", None)),  # not under evidence/
    "W-C00-17": ((None, "admitted", '"cancelled"'), ("closed", None)),                         # a quoted value
}


def real_verdict(n):
    """(keys, body) of evidence/C02/checks/CHK-C02-<n>.md beside this file, values as written; (None, why) if not
    readable."""
    p = REPO / f"evidence/C02/checks/CHK-C02-{n}.md"
    try:
        t = p.read_text(encoding="utf-8")
        fm, body = t[4:].split("\n---\n", 1)
    except (OSError, UnicodeDecodeError, ValueError) as e:
        return None, f"{p} unreadable ({type(e).__name__})"
    keys = {}
    for line in fm.splitlines():
        m = re.match(r"([a-z_]+): ?(.*)", line)
        if m:
            keys[m.group(1)] = m.group(2)
    return keys, body


def load_module(name, path):
    import importlib.machinery
    src = importlib.machinery.SourceFileLoader(name, os.fspath(path))
    mod = importlib.util.module_from_spec(importlib.util.spec_from_loader(name, src))
    src.exec_module(mod)
    return mod


def template(path, lead):
    """The fenced block after the line holding lead in path: (front-matter lines, body) or (None, why)."""
    try:
        t = path.read_text(encoding="utf-8")
        block = t[t.index(lead):].split("```\n", 2)[1]
        fm, body = block[4:].split("\n---\n", 1)
    except (OSError, ValueError, IndexError) as e:
        return None, f"no template after {lead!r} in {path} ({type(e).__name__})"
    return fm.splitlines(), body


def m1b(tmp):
    """W-C02-24 M1b, Part B (see the Form C0 block above). A fixture of its own, pull requests 1000 up."""
    tmp.mkdir()
    s = Fixture(tmp)
    s.branch("seed-m1b")
    for iid, ((writes, *state), _) in M1B_ITEMS.items():
        keys = dict(zip(("admission", "execution", "acceptance", "accepted_by"), state))
        s.write(f"plan/work/{iid}.md", item_text(iid, writes, **keys))
    s.write("plan/decisions/PC-99.md", "# a fixture decision record\n")
    s.write("tools/fx_tool.py", "print('a fixture tool')\n")
    s.commit("M1b fixture items and files")
    s.merge("seed-m1b")
    prs, ns = iter(range(1000, 2000)), iter(range(100, 999))
    tag = lambda t: f"[{t}]"   # noqa: E731

    def make(files=None, appends=None, v=None, body=None, verdict="PASS", after=None, reviewed=None):
        """A pull request from main: files written (path: text), lines appended (path: line); then, unless v is
        None, a verdict with the overrides v naming the change commit X (or reviewed); then after (path: line)
        appended in one more commit. Returns (pr, head)."""
        pr = next(prs)
        s.branch(f"m{pr}")
        for p, t in (files or {}).items():
            s.write(p, t)
        for p, t in (appends or {}).items():
            s.append(p, t)
        x = s.commit(f"fixture pull request {pr}")
        if v is not None:
            s.verdict(next(ns), reviewed or x, verdict=verdict,
                      **({"body": body} if body is not None else {}), **v)
        if after:
            for p, t in after.items():
                s.append(p, t)
            s.commit(f"a commit after the verdict, pull request {pr}")
        return pr, s.push(pr)

    def gate(pr, head):
        s.git("checkout", "-q", "main")
        return s.gate(pr, head)

    def refused(label, token, pr_head, also=None):
        rc, out = gate(*pr_head)
        case(f"{label}: GATE FAIL with {tag(token)}", rc == 1 and "GATE FAIL" in out and tag(token) in out and
             (also is None or also(out)), out)

    def passed(label, pr_head):
        rc, out = gate(*pr_head)
        case(f"{label}: GATE PASS", rc == 0 and "GATE PASS" in out, out)

    hi = {"CLAUDE.md": "a class-high change that is not a floor path"}

    # ---- B1, the verdict keys
    passed("(B1.0) the default new-form verdict on a class-high head", make(appends=hi, v={}))
    for k in B1_KEYS:
        refused(f"(B1.{k}.absent) {k}: absent", f"K-ABSENT-{k}", make(appends=hi, v={k: None}))
        refused(f"(B1.{k}.repeated) {k}: given twice with the same value", f"K-REPEAT-{k}",
                make(appends=hi, v={k: [NEW_KEYS[k], NEW_KEYS[k]]}))
    for val in ("W-T-01", "stage C0", "branch SB-cor", "revert abc123", "yes"):
        refused(f"(B1.item.form) item: {val}", "K-FORM-item", make(appends=hi, v={"item": val}))
    refused("(B1.item.file) item: W-C00-99, whose file is absent at the merge base", "K-ITEMFILE",
            make(appends=hi, v={"item": "W-C00-99"}))
    refused("(B1.item.head) item: W-C00-98, whose file only the head adds", "K-ITEMFILE",
            make(appends=hi, files={"plan/work/W-C00-98.md": item_text("W-C00-98")}, v={"item": "W-C00-98"}))
    passed("(B1.item.dotted) item: W-C00-12.3", make(appends=hi, v={"item": "W-C00-12.3"}))
    passed('(B1.item.quoted) item: "W-C00-01" (double quotes are read without them)',
           make(appends=hi, v={"item": '"W-C00-01"'}))
    passed("(B1.item.stage) item: stage C00 with producer_run: none",
           make(appends=hi, v={"item": "stage C00", "producer_run": "none"}))
    passed("(B1.item.branch) item: branch SB-COR-2 with producer_run: none",
           make(appends=hi, v={"item": "branch SB-COR-2", "producer_run": "none"}))
    r128, r129, r131, r133, r137 = (real_verdict(n) for n in (128, 129, 131, 133, 137))
    reals = {n: r for n, r in zip((128, 129, 131, 133, 137), (r128, r129, r131, r133, r137))}
    for n, (keys, why) in reals.items():
        if keys is None:
            case(f"(B1.real{n}) the real verdict CHK-C02-{n} is readable beside this file", False, why)
    rv = lambda n, k: (reals[n][0] or {}).get(k, "<unreadable>")   # noqa: E731
    for val in ("none", "none:", "nonesuch triage", "plan/notes.md", rv(133, "triage")):
        refused(f"(B1.triage.form) triage: {val[:60]}", "K-FORM-triage", make(appends=hi, v={"triage": val}))
    refused("(B1.triage.path) triage: a well-formed path absent at the head", "K-TRIAGEPATH",
            make(appends=hi, v={"triage": "evidence/C00/EV-C00-002_absent.md"}))
    for label, val, files in (
            ("a path at the head", "evidence/C00/EV-C00-001_fixture.md", None),
            ("a path, then text", "evidence/C00/EV-C00-001_fixture.md part 2, read after my pass", None),
            ("a path the head adds", "evidence/C00/EV-C00-003_new.md", {"evidence/C00/EV-C00-003_new.md": "x\n"}),
            ("none, then a reason", "none, a scoped re-review has no triage", None),
            ("CHK-C02-128's value (quoted none:)", rv(128, "triage"), None),
            ("CHK-C02-129's value (none, a space, a reason)", rv(129, "triage"), None),
            ("CHK-C02-137's value", rv(137, "triage"), None)):
        passed(f"(B1.triage.ok) triage: {label}", make(appends=hi, files=files, v={"triage": val}))
    # floor: CHK-C02-131 C2. The class-high case's reason line names the eight classes.
    names_classes = lambda out: any(tag("K-FORM-floor") in ln and all(c.lower() in ln.lower() for c in CLASSES)  # noqa
                                    for ln in out.splitlines())
    refused("(B1.floor.C2) floor: class high (…), the merge gate's class, not a floor class; its reason line names "
            "the eight classes", "K-FORM-floor", make(appends=hi, v={"floor": "class high (…)"}), also=names_classes)
    for label, val in (("yes (filled but meaningless)", "yes"), ("CHK-C02-129's value", rv(129, "floor")),
                       ("CHK-C02-133's value", rv(133, "floor")),
                       ("CHK-C02-137's value (public text is not a class)", rv(137, "floor")),
                       ("text after a class outside a parenthesis", "guard rail"),
                       ("an unbalanced parenthesis", "test oracle (tools/a.sh"), ("none with no reason", "none"),
                       ("an empty item", "guard;; hook"), ("nonesense", "nonesense")):
        refused(f"(B1.floor.form) floor: {label}", "K-FORM-floor", make(appends=hi, v={"floor": val}))
    for label, val in (("C2's case: test oracle (tools/a.sh, tools/b.py); guard",
                        "test oracle (tools/a.sh, tools/b.py); guard"),
                       ("CHK-C02-131's value", rv(131, "floor")), ("Test Oracles, hooks (case, plural)",
                                                                  "Test Oracles, hooks"),
                       ("every other class", "CI gates; migrations; schema rules, leak check"),
                       ("none: a reason", "none: no floor path is touched"), ("none, a reason", "none, records"),
                       ("CHK-C02-128's value (quoted none:)", rv(128, "floor")), ('"merge gate" quoted',
                                                                                 '"merge gate"')):
        passed(f"(B1.floor.ok) floor: {label}", make(appends=hi, v={"floor": val}))
    for val in ("yes", "the producer's notes", "N-"):
        refused(f"(B1.shared.form) shared_with_producer: {val}", "K-FORM-shared_with_producer",
                make(appends=hi, v={"shared_with_producer": val}))
    for val in ("L-450", "EV-C02-028 part 9", "evidence/C02/EV-C02-028_pra2_m1_triage.md part 9.2", "CHK-C02-131 C2",
                "N-315 and its triage"):
        passed(f"(B1.shared.ok) shared_with_producer: {val}", make(appends=hi, v={"shared_with_producer": val}))
    for val in ("a0123456789abcde", "A0123456789ABCDEF", "agent a0123456789abcdef", "yes", "a0123456789abcdef0"):
        refused(f"(B1.run.form) producer_run: {val}", "K-FORM-producer_run", make(appends=hi, v={"producer_run": val}))
    refused("(B1.run.none) producer_run: none with item: W-C00-01", "P-NONE", make(appends=hi, v={"producer_run": "none"}))
    passed('(B1.run.ok) producer_run: "ae8b7fdebcfbd9f53" (a real agent ID, quoted)',
           make(appends=hi, v={"producer_run": '"ae8b7fdebcfbd9f53"'}))

    # ---- B2, the floor-path constant
    try:
        fp = load_module("merge_gate_under_test", GATE[0]).FLOOR_PATHS
        case("(B2.0) tools/merge_gate.py's FLOOR_PATHS is exactly B2's five literal paths and prefixes",
             tuple(sorted(fp)) == tuple(sorted(FLOOR_PATHS)), repr(fp))
    except Exception as e:   # noqa: BLE001  (a missing constant is this case's failure, never a crash of the test)
        case("(B2.0) tools/merge_gate.py's FLOOR_PATHS is exactly B2's five literal paths and prefixes", False,
             f"{type(e).__name__}: {e}")
    for path, how in (("tools/credential_value_scan.py", {"files": {"tools/credential_value_scan.py": "x = 1\n"}}),
                      ("supabase/migrations/0002_fx.sql", {"files": {"supabase/migrations/0002_fx.sql": SQL}}),
                      (".claude/hooks/tool_allowlist.py", {"appends": {".claude/hooks/tool_allowlist.py": "# fx"}}),
                      (".claude/settings.json", {"files": {".claude/settings.json": "{}\n"}}),
                      (".github/workflows/fx.yml", {"files": {".github/workflows/fx.yml": YML}}),
                      ("tools/new_fx_helper.py (the whole tools/ prefix)", {"files": {"tools/new_fx_helper.py": PY}})):
        refused(f"(B2.none) {path}: floor: none", "F-NONE", make(v={"floor": "none: no floor path"}, **how))
        refused(f"(B2.breaks) {path}: own_breaks: none", "F-BREAKS", make(v={"own_breaks": "none"}, **how))
        passed(f"(B2.ok) {path}: a floor and own breaks", make(v={}, **how))
    refused("(B2.breaks2) tools/fx_tool.py: own_breaks: none: nothing to break (starts with none)", "F-BREAKS",
            make(appends={"tools/fx_tool.py": "# fx"}, v={"own_breaks": "none: nothing to break"}))
    for label, how in (("CLAUDE.md", {"appends": hi}),
                       (".claude/agents/checker.md (class high, not a floor path)",
                        {"files": {".claude/agents/checker.md": "a fixture role file\n"}}),
                       (".claude/settings.json.bak (near miss of a literal path)",
                        {"files": {".claude/settings.json.bak": "{}\n"}})):
        passed(f"(B2.nofloor) {label}: floor: none and own_breaks: none",
               make(v={"floor": "none: no floor path", "own_breaks": "none"}, **how))
    rc, out = gate(*make(appends={"plan/notes.md": "a records change"}))
    case("(B2.records) a head touching only plan/ records needs no verdict and no floor: GATE PASS, class normal",
         rc == 0 and "class normal" in out, out)

    # ---- B3, the condition lines
    def cond(t="preference", b="none", c="diff-confirmed", n=1, text="a fixture condition"):
        return COND.format(n=n, t=t, b=b, c=c, text=text)

    def marked(*lines, before="", after=""):
        return before + "Findings: none (fixture).\n\n<!-- conditions -->\n" + "".join(f"{x}\n" for x in lines) + \
            "<!-- /conditions -->\n" + after

    see = {"conditions": "see markers"}
    passed("(B3.ok1) PASS-WITH-CONDITIONS, see markers, a preference blocking none",
           make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS", body=marked(cond())))
    passed("(B3.ok2) PASS-WITH-CONDITIONS, a defect blocking the producer task and missing evidence blocking acceptance",
           make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS",
                body=marked(cond("defect", "producer task"), cond("missing evidence", "acceptance", n=2))))
    passed("(B3.ok3) PASS, conditions: none, empty markers", make(appends=hi, v={}, body=marked()))
    passed("(B3.ok4) PASS, conditions: none, a condition line quoted indented outside the markers",
           make(appends=hi, v={}, body="A scoped re-review quotes:\n\n    " + cond("defect", "merge") + "\n"))
    for label, line in (("defect blocking none", cond("defect", "none")),
                        ("missing evidence blocking none", cond("missing evidence", "none")),
                        ("preference blocking merge", cond("preference", "merge")),
                        ("scope conflict blocking acceptance", cond("scope conflict", "acceptance"))):
        refused(f"(B3.contra) {label}", "C-CONTRA",
                make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS", body=marked(line)))
    for label, line in (("an unknown type", cond("bug")), ("an unknown blocks value", cond(b="everything")),
                        ("an unknown closure", cond(c="trust me")),
                        ("no text after the closure", "C1 · type: preference · blocks: none · closure: diff-confirmed")):
        refused(f"(B3.form) {label}", "C-FORM",
                make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS", body=marked(line)))
    refused("(B3.empty1) see markers with no markers", "C-EMPTY",
            make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS"))
    refused("(B3.empty2) see markers with empty markers", "C-EMPTY",
            make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS", body=marked()))
    refused("(B3.outside1) conditions: none and a column-0 condition line after the markers", "C-OUTSIDE",
            make(appends=hi, v={}, body=marked(after=cond() + "\n")))
    refused("(B3.outside2) see markers, one line inside and one at column 0 before the markers", "C-OUTSIDE",
            make(appends=hi, v=see, verdict="PASS-WITH-CONDITIONS", body=marked(cond(), before=cond(n=2) + "\n\n")))
    refused("(B3.passblock1) PASS with a defect blocking acceptance", "C-PASSBLOCK",
            make(appends=hi, v=see, body=marked(cond("defect", "acceptance"))))
    refused("(B3.passblock2) PASS with missing evidence blocking the producer task", "C-PASSBLOCK",
            make(appends=hi, v=see, body=marked(cond("missing evidence", "producer task"))))
    refused("(B3.pwcnone) PASS-WITH-CONDITIONS with conditions: none", "C-PWCNONE",
            make(appends=hi, v={}, verdict="PASS-WITH-CONDITIONS"))
    for n in (128, 129, 133, 137):
        keys, body = reals[n]
        if keys is None:
            continue
        passed(f"(B3.real{n}) CHK-C02-{n}'s body and its verdict and conditions values, under a fixture front matter "
               "(its condition lines parse line by line)",
               make(appends=hi, v={"conditions": keys["conditions"]}, verdict=keys["verdict"], body=body))
    if r131[0] is not None:
        refused("(B3.real131) CHK-C02-131's body (C1 blocks merge, closure scoped re-review), a class-normal commit "
                "after it", "D-CLOSURE", make(appends=hi, v={"conditions": r131[0]["conditions"]},
                                              verdict=r131[0]["verdict"], body=r131[1],
                                              after={"plan/notes.md": "a fix"}))

    # ---- B4, the diff-confirmed closure
    def merge_block(c="diff-confirmed"):
        return marked(cond("defect", "merge", c))

    pwc = dict(v=see, verdict="PASS-WITH-CONDITIONS")
    refused("(B4.nolater) blocks: merge, diff-confirmed, nothing but the verdict after reviewed_head (round 2 "
            "DEFECT 1)", "D-NOLATER", make(appends=hi, body=merge_block(), **pwc))
    passed("(B4.ok) blocks: merge, diff-confirmed, one class-normal commit after it",
           make(appends=hi, body=merge_block(), after={"plan/notes.md": "the fix"}, **pwc))
    refused("(B4.high) blocks: merge, diff-confirmed, a class-high commit after it", "D-HIGHLATER",
            make(appends=hi, body=merge_block(), after={"CLAUDE.md": "a class-high fix"}, **pwc))
    for c in ("scoped re-review", "full fresh check"):
        refused(f"(B4.closure) blocks: merge, closure {c}, a class-normal commit after it", "D-CLOSURE",
                make(appends=hi, body=merge_block(c), after={"plan/notes.md": "the fix"}, **pwc))

    # ---- B5, the writes: rule (state and writes: read at the merge base)
    refused("(B5.item1) tools/w02_tool.py (W-C00-02's writes:) under a verdict for W-C00-08", "W-ITEM",
            make(files={"tools/w02_tool.py": PY}, v={"item": "W-C00-08"}))
    refused("(B5.item2) docs/w02/guide.md (under W-C00-02's docs/w02/ prefix) under a verdict for W-C00-08", "W-ITEM",
            make(files={"docs/w02/guide.md": "a guide\n"}, v={"item": "W-C00-08"}))
    refused("(B5.item3) tools/w02_tool.py under a verdict for W-C00-08, whose writes: the head extends to it (read at "
            "the base)", "W-ITEM", make(files={"tools/w02_tool.py": PY, "plan/work/W-C00-08.md": item_text(
                "W-C00-08", "tools/w08_tool.py; tools/w02_tool.py")}, v={"item": "W-C00-08"}))
    passed("(B5.ok1) tools/w02_tool.py under a verdict for W-C00-02", make(files={"tools/w02_tool.py": PY}, v={"item": "W-C00-02"}))
    passed("(B5.ok2) docs/w02/guide.md under a verdict for W-C00-02",
           make(files={"docs/w02/guide.md": "a guide\n"}, v={"item": "W-C00-02"}))
    refused("(B5.noverdict) docs/w02/guide.md (class normal, not a record path) with no verdict", "W-NOVERDICT",
            make(files={"docs/w02/guide.md": "a guide\n"}))
    refused("(B5.run) tools/w02_tool.py under a verdict for W-C00-02 with producer_run: none", "P-NONE",
            make(files={"tools/w02_tool.py": PY}, v={"item": "W-C00-02", "producer_run": "none"}))
    for iid in ("W-C00-03", "W-C00-04"):
        passed(f"(B5.shared) tools/shared_tool.py (in W-C00-03's and W-C00-04's writes:) under a verdict for {iid}",
               make(files={"tools/shared_tool.py": PY}, v={"item": iid}))
    refused("(B5.shared.neither) tools/shared_tool.py under a verdict for W-C00-02", "W-ITEM",
            make(files={"tools/shared_tool.py": PY}, v={"item": "W-C00-02"}))
    rc, out = gate(*make(appends={"plan/decisions/PC-99.md": "an addendum"}))
    case("(B5.records1) a records-only head on plan/decisions/PC-99.md (in W-C00-04's writes:), no verdict: GATE PASS",
         rc == 0 and "GATE PASS" in out, out)
    rc, out = gate(*make(appends={"plan/work/W-C00-05.md": "A log line."}))
    case("(B5.records2) a records-only head on W-C00-05's own file (its writes: does not parse), no verdict: GATE PASS",
         rc == 0 and "GATE PASS" in out, out)
    refused("(B5.state1) tools/w06_tool.py with W-C00-06 set to cancelled in the same head, verdict for W-C00-08",
            "W-ITEM", make(files={"tools/w06_tool.py": PY, "plan/work/W-C00-06.md": item_text(
                "W-C00-06", "tools/w06_tool.py", execution="cancelled")}, v={"item": "W-C00-08"}))
    refused("(B5.state2) tools/w06_tool.py with W-C00-06 set to accepted in the same head, verdict for W-C00-08",
            "W-ITEM", make(files={"tools/w06_tool.py": PY, "plan/work/W-C00-06.md": item_text(
                "W-C00-06", "tools/w06_tool.py", execution="finished", acceptance="accepted",
                accepted_by="evidence/C00/EV-C00-001_fixture.md")}, v={"item": "W-C00-08"}))
    passed("(B5.closed) tools/closed_tool.py (W-C00-07 is cancelled at the base) under a verdict for W-C00-01",
           make(files={"tools/closed_tool.py": PY}, v={}))
    for iid in ("W-C00-05", "W-C00-09"):
        refused(f"(B5.unparsed) a class-high head touching {iid}'s file (writes: does not parse), verdict for W-C00-01",
                "W-UNPARSED", make(appends={**hi, f"plan/work/{iid}.md": "A log line."}, v={}))
        passed(f"(B5.unparsed.ok) the same with a verdict for {iid}",
               make(appends={**hi, f"plan/work/{iid}.md": "A log line."}, v={"item": iid}))
    s.git("checkout", "-q", "main")
    r = subprocess.run([sys.executable, "-I", "tools/merge_gate.py", "--items", "main"], cwd=s.d, capture_output=True,
                       text=True)
    line_re = re.compile(r"ITEM (\S+) (open|closed) writes=(none|ok|unparsed|exempt)(?: .*)?")
    got = {m.group(1): (m.group(2), m.group(3)) for m in map(line_re.fullmatch, r.stdout.splitlines()) if m}
    files = [p for p in s.git("ls-tree", "--name-only", "main", "plan/work/").splitlines() if p.endswith(".md")]
    want = {f"plan/work/{i}.md": w for i, (_, w) in M1B_ITEMS.items()}
    bad = [p for p, (st, wf) in want.items() if p not in got or got[p][0] != st or (wf and got[p][1] != wf)]
    case(f"(B5.list) --items main in the fixture: one ITEM line per plan/work file ({len(files)}), each state and "
         "writes form as M1B_ITEMS states (prose, a comma list and the item's own file do not parse)",
         r.returncode == 0 and len(files) == len(M1B_ITEMS) + 3 and sorted(got) == sorted(files) and not bad,
         f"exit {r.returncode}; wrong: {bad}\n{r.stdout[-1500:]}{r.stderr[-500:]}")
    try:
        rec = load_module("records_under_test", REPO / "tools/records.py")
        rec.ROOT_FOR_ACCEPT[0] = s.d
        diff = []
        for p in files:
            text = (s.d / p).read_text(encoding="utf-8")
            if not text.startswith("---\n"):
                continue              # T01.md has no front matter; records.py cannot read it either
            meta, _ = rec.split_front(text, p)
            if got.get(p, ("?",))[0] != ("closed" if rec.is_closed(meta) else "open"):
                diff.append(p)
        case("(B5.mirror) the gate's state of every fixture item equals tools/records.py's is_closed (declined, "
             "cancelled, accepted with and without its evidence file, a quoted value)", bool(got) and not diff,
             f"differ: {diff}; listing exit {r.returncode}")
    except Exception as e:   # noqa: BLE001
        case("(B5.mirror) the gate's state of every fixture item equals tools/records.py's is_closed", False,
             f"{type(e).__name__}: {e}")
    real_items()

    # ---- B6, approach blocks are class high
    changed_block = item_text("W-C00-02", "tools/w02_tool.py; docs/w02/").replace("a fixture approach",
                                                                                   "a fixture approach.")
    for label, text in (("changed by one byte", changed_block),
                        ("removed", item_text("W-C00-02").replace("\n## Approach", ""))):
        rc, out = gate(*make(files={"plan/work/W-C00-02.md": text}))
        case(f"(B6.{label.split()[0]}) W-C00-02's approach block {label}, no verdict: GATE FAIL, class high naming it "
             "with the approach-block note", rc == 1 and high_named(out, "plan/work/W-C00-02.md") and
             "plan/work/W-C00-02.md (an existing approach block changed or removed)" in out, out)
    rc, out = gate(*make(files={"plan/work/W-C00-12.3.md": item_text("W-C00-12.3", "tools/w12_tool.py")}))
    case("(B6.added) an approach block added to W-C00-12.3, which had none, no verdict: GATE PASS, class normal",
         rc == 0 and "class normal" in out, out)

    # ---- B7, the revert route by resulting tree (and B10: R1 reverts a guard change)
    revert_route(s, prs, ns, gate)

    # ---- B9, the template and the key list
    template_cases(s, make, gate, refused, passed)


def real_items():
    """B5 at this checkout: the gate's listing of every real plan/work/*.md at HEAD, against tools/records.py, and no
    open item whose writes: line neither parses nor is listed exempt. The records are read only once the listing
    works, so a gate without --items reads none of them."""
    r = subprocess.run([sys.executable, "-I", str(GATE[0]), "--items", "HEAD"], cwd=REPO, capture_output=True,
                       text=True)
    line_re = re.compile(r"ITEM (\S+) (open|closed) writes=(none|ok|unparsed|exempt)(?: .*)?")
    got = {m.group(1): (m.group(2), m.group(3)) for m in map(line_re.fullmatch, r.stdout.splitlines()) if m}
    ls = subprocess.run(["git", "ls-tree", "--name-only", "HEAD", "plan/work/"], cwd=REPO, capture_output=True,
                        text=True)
    files = sorted(p for p in ls.stdout.splitlines() if p.endswith(".md"))
    ok = r.returncode == 0 and ls.returncode == 0 and len(files) > 90 and sorted(got) == files
    case(f"(B5.real.list) --items HEAD lists every real plan/work/*.md once ({len(files)} at HEAD)", ok,
         f"exit {r.returncode}; listed {len(got)}\n{r.stdout[-800:]}{r.stderr[-800:]}")
    if not ok:
        case("(B5.real.mirror) the gate's state of every real item equals tools/records.py's is_closed", False,
             "not checked: the listing above failed")
        case("(B5.real.writes) every open real item's writes: parses or is listed exempt", False,
             "not checked: the listing above failed")
        return
    try:
        rec = load_module("records_real", REPO / "tools/records.py")
        items, _ = rec.load_records(REPO)
        diff = [i for i, m in items.items()
                if got.get(m["_path"], ("?",))[0] != ("closed" if rec.is_closed(m) else "open")]
        case(f"(B5.real.mirror) the gate's state of every real item ({len(items)}) equals tools/records.py's is_closed",
             len(items) == len(files) and not diff, f"differ: {diff}")
    except Exception as e:   # noqa: BLE001
        case("(B5.real.mirror) the gate's state of every real item equals tools/records.py's is_closed", False,
             f"{type(e).__name__}: {e}")
    unparsed = [p for p, (st, wf) in got.items() if st == "open" and wf == "unparsed"]
    case("(B5.real.writes) every open real item's writes: parses or is listed exempt", not unparsed,
         f"unparsed: {unparsed}")


def revert_route(s, prs, ns, gate):
    """R1 to R7 (B7). M changes the guard file and tools/rev_b.py in one merge commit on main."""
    rev = {"triage": "none: a revert", "producer_run": None, "floor": None, "own_breaks": None}
    rev_b = "".join(f"line {i}\n" for i in range(1, 11))
    s.branch("rev-seed")
    s.write("tools/rev_b.py", rev_b)
    s.commit("a file the revert cases change")
    s.merge("rev-seed")
    s.branch("rev-m")
    s.append(".claude/hooks/tool_allowlist.py", "# a fixture guard change, reverted below")
    s.write("tools/rev_b.py", rev_b.replace("line 5\n", "line 5 changed by M\n"))
    m_plain = s.commit("the change M merges")
    s.merge("rev-m")
    m = s.git("rev-parse", "main")

    def revert_pr(label, target, token=None, edit=None, manual=None):
        """A pull request from main whose change is git revert -m 1 of target (or, with manual, the files given),
        then edit (path: text) applied in the same commit, and a revert verdict naming that commit."""
        pr = next(prs)
        s.branch(f"r{pr}")
        if manual is None:
            parents = s.git("rev-list", "--parents", "-n", "1", target).split()
            s.git("revert", "--no-edit", "--no-commit", *(["-m", "1"] if len(parents) > 2 else []), target)
        else:
            for p, t in manual.items():
                s.write(p, t)
        for p, t in (edit or {}).items():
            s.write(p, t)
        x = s.commit(f"revert pull request {pr}")
        s.verdict(next(ns), x, item=f"revert {target}", **rev)
        head = s.push(pr)
        rc, out = gate(pr, head)
        if token:
            case(f"{label}: GATE FAIL with [{token}]", rc == 1 and "GATE FAIL" in out and f"[{token}]" in out, out)
        else:
            case(f"{label}: GATE PASS", rc == 0 and "GATE PASS" in out, out)

    guard_at_m = (s.d / ".claude/hooks/tool_allowlist.py").read_text()
    guard_before = guard_at_m.removesuffix("# a fixture guard change, reverted below\n")
    revert_pr("(R1) a true revert of M (a guard change) with main unmoved, no producer_run, floor or own_breaks "
              "(B10's route)", m)
    revert_pr("(R4) a partial revert: tools/rev_b.py restored, the guard change kept", m, "R-TREE",
              manual={"tools/rev_b.py": rev_b})
    revert_pr("(R5) item: revert <a commit on main that is not a merge commit>", m_plain, "R-NOTMERGE")
    s.branch("side")
    s.append("plan/notes.md", "a side change")
    s.commit("a side change")
    s.branch("side2")
    s.git("checkout", "-q", "-B", "side2", "side")
    s.append("plan/side.md", "another side change")
    s.commit("another side change")
    s.git("checkout", "-q", "side")
    s.git("merge", "-q", "--no-ff", "-m", "Merge side2 into side", "side2")
    off_main = s.git("rev-parse", "side")
    revert_pr("(R6) item: revert <a merge commit that is not on origin/main>, on a class-high head", off_main,
              "R-NOTMAIN", manual={"tools/rev_side.py": PY})
    s.branch("rev-shift")
    s.write("tools/rev_b.py", "header 1\nheader 2\nheader 3\n" + (s.d / "tools/rev_b.py").read_text())
    s.commit("a later change that shifts the lines M changed")
    s.merge("rev-shift")
    revert_pr("(R2) a true revert of M after a later commit shifted its lines", m)
    shifted = "header 1\nheader 2\nheader 3\n" + rev_b
    revert_pr("(R3) R2 plus one byte in a reverted file", m, "R-TREE", edit={"tools/rev_b.py": shifted + "x"})
    s.branch("rev-same")
    s.write("tools/rev_b.py", (s.d / "tools/rev_b.py").read_text().replace("line 5 changed by M\n",
                                                                           "line 5 changed again\n"))
    s.commit("a later edit of the same line M changed")
    s.merge("rev-same")
    revert_pr("(R7) a revert that conflicts with a later edit of the same line, resolved by hand", m, "R-CONFLICT",
              manual={"tools/rev_b.py": shifted, ".claude/hooks/tool_allowlist.py": guard_before})


def template_cases(s, make, gate, refused, passed):
    """B9 and CHK-C02-131 C2's template line: one key list across tools/merge_gate.py, checker.md and section 9; the
    template filled by FILL_MAP passes; one required key dropped refuses, one case per key."""
    lead_c, lead_w = "**Binding verdict:**", "**Checker verdict**"
    cm, wo = REPO / ".claude/agents/checker.md", REPO / "plan/Installation_Working_Order.md"
    tc, tw = template(cm, lead_c), template(wo, lead_w)
    keys_of = lambda t: [re.match(r"([a-z_]+):", ln).group(1) for ln in t[0] if re.match(r"([a-z_]+):", ln)]  # noqa
    try:
        mg = load_module("merge_gate_keys", GATE[0])
        vk, rk = tuple(mg.VERDICT_KEYS), tuple(mg.REQUIRED_KEYS)
    except Exception as e:   # noqa: BLE001
        vk, rk = None, None
        case("(B9.keys0) tools/merge_gate.py holds VERDICT_KEYS and REQUIRED_KEYS", False, f"{type(e).__name__}: {e}")
    if tc[0] is None or tw[0] is None:
        case("(B9.tpl0) checker.md's and section 9's verdict templates are readable", False, f"{tc[1]}; {tw[1]}")
        return
    kc, kw = keys_of(tc), keys_of(tw)
    case("(B9.keys) one key list: checker.md's template, section 9's template and the gate's VERDICT_KEYS are equal, in "
         "order, and hold B1's six keys", vk is not None and kc == kw == list(vk) and set(B1_KEYS) <= set(kc),
         f"checker.md {kc}\nsection 9 {kw}\ngate {vk}")
    case("(B9.required) REQUIRED_KEYS is inside VERDICT_KEYS and holds at least " + ", ".join(MIN_REQUIRED),
         rk is not None and set(MIN_REQUIRED) <= set(rk) <= set(vk or ()), f"{rk}")
    for name, t, path in (("checker.md", tc, cm), ("section 9", tw, wo)):
        fl = [ln for ln in t[0] if ln.startswith("floor:")]
        case(f"(B9.floorline) {name}'s template floor: line names the eight floor classes (CHK-C02-131 C2)",
             len(fl) == 1 and all(c.lower() in fl[0].lower() for c in CLASSES), repr(fl))
        text = path.read_text(encoding="utf-8")
        case(f"(B9.duty) {name} states the binding checker's confirmation duty with tools/subagent_audit.py launch "
             "and calls (B8)", "subagent_audit.py launch" in text and "calls" in text, path.name)
    fill = {"id": None, "target": "the fixture change", "reviewed_head": None, "verdict": "PASS", "conditions": "none",
            "independence": '"same session, fresh-context subagent (declared, Ek A 5.3)"',
            "checker_run": f"subagent {AGENT} (checker), fixture", "date": "2026-10-20",
            "take_up": "PROCEED: a fixture task", "triage": "evidence/C00/EV-C00-001_fixture.md (read after my pass)",
            "floor": "test oracle (tools/fx_tool.py); merge gate", "own_breaks": "fixture break: a rule removed, red",
            "package": "none delivered", "nonce": "none delivered", "read": "the fixture", "relied_on": "the fixture",
            "unsure": "none", "for": "the merge", "received_returned": "none", "guard_denials": "none",
            "item": "W-C00-01", "shared_with_producer": "none", "producer_run": AGENT}
    missing = [k for k in kc if k not in fill]
    case("(B9.fillmap) the fill map gives a value inside B1's grammar for every key of the template", not missing,
         f"no value for {missing}")
    body = "\n".join("" if re.match(r"C<n> · type:", ln) else ("fixture text" if re.fullmatch(r"<.*>", ln) else ln)
                     for ln in tc[1].splitlines()) + "\n"

    pr_iter, n_iter = iter(range(1900, 2000)), iter(range(900, 999))

    def head_with(drop=None):
        pr = next(pr_iter)
        s.branch(f"t{pr}")
        s.append("tools/fx_tool.py", f"# template case {pr}")
        x = s.commit(f"template pull request {pr}")
        n = next(n_iter)
        lines = []
        for k in kc:
            if k == drop:
                continue
            v = {"id": f"CHK-C00-{n:03d}", "reviewed_head": x}.get(k) or fill.get(k, "fixture")
            lines.append(f"{k}: {v}")
        s.write(f"evidence/C00/checks/CHK-C00-{n:03d}.md", "---\n" + "\n".join(lines) + "\n---\n" + body)
        s.commit(f"filled template verdict {n}")
        return pr, s.push(pr)

    passed("(B9.filled) checker.md's template filled by the fill map, on a head touching a floor path (tools/)",
           head_with())
    for k in sorted(set(MIN_REQUIRED) | set(rk or ())):
        if k not in kc:
            case(f"(B9.drop.{k}) {k} is a template key, so its drop case can run", False, f"{k} not in {kc}")
            continue
        refused(f"(B9.drop.{k}) the filled template with {k} dropped", f"K-ABSENT-{k}", head_with(drop=k))


def main():
    if len(sys.argv) > 1:
        GATE[0] = Path(sys.argv[1]).resolve()
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
        shared_token_files(s)
        role_package_gate(Path(tmp) / "role_packages")
        m1b(Path(tmp) / "m1b")
    ok = bool(RESULTS) and all(RESULTS)
    print(f"MERGE_GATE_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
