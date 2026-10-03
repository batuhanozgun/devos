#!/usr/bin/env python3
"""test_check_records.py: the gate tests of W-C00-12 tranche 1b-ii (12_tranche_plan.md section 2.2; carrier A-11).

Run from the repository root of a clone with full history (`git fetch --unshallow` first). Every fixture is a
scratch repository in a temporary directory: a `--shared` clone of this repository, never this working tree.
Procedures: plan/builder/w-c00-12/11_test_register.md section 2, made concrete in
plan/builder/w-c00-12/15_tranche_1b-ii_intent.md section 3. Prints one line per outcome, `T-xx PASS|FAIL` per test,
the two mutation checks, and `GATE 1b-ii PASS` only if every test passes and both mutations are caught.
Derived service terms used by T-M15 and T-MAP7 live only in the temporary fixtures and are never printed.
"""
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timedelta, timezone
from pathlib import Path

sys.dont_write_bytecode = True
REPO = Path.cwd().resolve()
NOW = datetime.now(timezone.utc).replace(second=0, microsecond=0)
PRODUCER = "session_01TESTPRODUCERxxxxxxxxxxxx"
REVIEWER = "session_01TESTREVIEWERxxxxxxxxxxxx"
RUN = "session_01TESTRUNxxxxxxxxxxxxxxxxx"
RESULTS = {}
TMPROOT = tempfile.mkdtemp(prefix="tcr-")


def iso(t):
    return t.strftime("%Y-%m-%dT%H:%MZ")


def sh(cmd, cwd, env=None, input_=None):
    e = dict(os.environ)
    e.pop("ISSUE_API_URL", None)
    e.update(env or {})
    r = subprocess.run(cmd, cwd=cwd, env=e, capture_output=True, text=True, shell=isinstance(cmd, str),
                       input=input_)
    return r.returncode, r.stdout + r.stderr


class Scratch:
    n = 0

    def __init__(self, rev="HEAD", remote=False, overlay_tools=False):
        Scratch.n += 1
        self.d = Path(TMPROOT) / f"s{Scratch.n}"
        sh(["git", "clone", "-q", "--shared", "--no-checkout", str(REPO), str(self.d)], TMPROOT)
        rc, out = self.git("checkout", "-q", "-B", "main", subprocess.run(
            ["git", "rev-parse", rev], cwd=REPO, capture_output=True, text=True).stdout.strip())
        assert rc == 0, out
        self.git("config", "user.name", "Fixture")
        self.git("config", "user.email", "fixture@example.invalid")
        self.git("config", "commit.gpgsign", "false")
        if overlay_tools:  # the current checker on an old tree (T-M1 a, T-M14 a)
            for f in ("tools/check_records.py", "tools/records.py"):
                (self.d / f).parent.mkdir(parents=True, exist_ok=True)
                shutil.copy(REPO / f, self.d / f)
        self.fixture_url = None
        if remote:
            bare = Path(TMPROOT) / f"r{Scratch.n}.git"
            sh(["git", "init", "-q", "--bare", str(bare)], TMPROOT)
            self.git("remote", "set-url", "origin", str(bare))
            self.git("push", "-q", "origin", "main")
            self.git("branch", "-q", "-u", "origin/main", "main")

    def p(self, path):
        return self.d / path

    def read(self, path):
        return self.p(path).read_text()

    def write(self, path, text):
        self.p(path).parent.mkdir(parents=True, exist_ok=True)
        self.p(path).write_text(text)

    def sub(self, path, old, new, count=1):
        t = self.read(path)
        assert old in t, f"{path}: '{old[:50]}' not found"
        self.write(path, t.replace(old, new, count))

    def append(self, path, text):
        t = self.read(path)
        self.write(path, t + ("" if t.endswith("\n") else "\n") + text)

    def git(self, *a, env=None):
        return sh(["git", *a], self.d, env)

    def rev(self, r="HEAD"):
        return self.git("rev-parse", r)[1].strip()

    def commit(self, msg, session=PRODUCER, date=None):
        self.git("add", "-A")
        env = {}
        if date:
            env = {"GIT_AUTHOR_DATE": date.strftime("%Y-%m-%dT%H:%M:%S+0000"),
                   "GIT_COMMITTER_DATE": date.strftime("%Y-%m-%dT%H:%M:%S+0000")}
        rc, out = self.git("commit", "-q", "--allow-empty", "-m", f"{msg}\n\nClaude-Session: https://claude.ai/code/{session}",
                           env=env)
        assert rc == 0, out
        return self.rev()

    def merge(self, branch, msg="Merge fixture PR"):
        self.git("checkout", "-q", "main")
        rc, out = self.git("merge", "-q", "--no-ff", branch, "-m", msg)
        assert rc == 0, out
        return self.rev()

    def cr(self, *a, env=None):
        return sh(["python3", "tools/check_records.py", *a], self.d, env)

    def records(self, *a):
        return sh(["python3", "tools/records.py", *a], self.d)

    def bc(self, *a, env=None):
        e = {"CLAUDE_CODE_REMOTE_SESSION_ID": RUN, "ISSUE_API_URL": self.comments_url()}
        e.update(env or {})
        return sh(["bash", "tools/builder_check.sh", *a], self.d, e)

    def comments_url(self, comments=None):
        if comments is None and self.fixture_url:
            return self.fixture_url
        f = Path(TMPROOT) / f"comments{Scratch.n}_{len(os.listdir(TMPROOT))}.json"
        f.write_text(json.dumps(comments if comments is not None else
                                [{"id": 5946719804, "user": {"login": "batuhanozgun"}}]))
        url = f"file://{f}"
        if comments is None:
            self.fixture_url = url
        return url

    def log(self):
        return sorted(self.p("plan/ledger").glob("*-log.md"))[-1].relative_to(self.d).as_posix()

    def release_and_baseline(self):
        """Release the lease (so the scratch lease never expires under the test), render, commit: the baseline."""
        rc, out = self.records("lease", "--session", RUN, "--release")
        assert rc == 0, out
        self.records("render")
        return self.commit("fixture baseline", session=RUN)

    def push(self, branch="main"):
        return self.git("push", "-q", "origin", branch)


MUTANT = [False]


def outcome(test, label, ok, detail=""):
    if MUTANT[0]:  # under a mutation a FAIL is the expected result: the disabled check is caught
        print(f"MUTANT  {test} {label}: {'outcome as expected' if ok else 'outcome NOT as expected (the disabled check shows)'}")
    else:
        print(f"{'PASS' if ok else 'FAIL'}  {test} {label}" + (f": {detail[:200]}" if detail and not ok else ""))
    RESULTS.setdefault(test, []).append(ok)
    return ok


def fails(out, sub=None, needle=None):
    lines = [l for l in out.splitlines() if l.startswith("FAIL")]
    if sub:
        lines = [l for l in lines if l.startswith(f"FAIL  [{sub}]")]
    if needle:
        lines = [l for l in lines if needle in l]
    return lines


def state_row(s, name, state, asof):
    t = s.read("plan/ledger.md")
    lines = t.splitlines()
    for i, l in enumerate(lines):
        if l.startswith(f"| {name} |"):
            lines[i] = f"| {name} | {state} | {asof} |"
            break
    else:
        raise AssertionError(f"row {name} not found")
    s.write("plan/ledger.md", "\n".join(lines) + "\n")


def front_edit(s, path, fn):
    import yaml
    t = s.read(path)
    end = t.index("\n---\n", 3)
    meta = yaml.safe_load(t[4:end])
    fn(meta)
    s.write(path, "---\n" + yaml.safe_dump(meta, sort_keys=False, allow_unicode=True) + "---\n" + t[end + 5:])


def verdict_text(sha, verdict="PASS-WITH-CONDITIONS", extra=""):
    return f"# Review fixture\n\n- **Target:** `{sha}`\n\n## Verdict: {verdict}\n\n{extra}\n"


def new_item(s, iid, parent, **fields):
    meta = {"id": iid, "kind": "item", "parent": parent, "title": f"Fixture {iid}", "scope": "installation",
            "admission": "admitted", "execution": "planned", "acceptance": "proposed"}
    meta.update(fields)
    import yaml
    s.write(f"plan/work/{iid}.md", "---\n" + yaml.safe_dump(meta, sort_keys=False) + "---\n\n# " + iid +
            "\n\n## Acceptance\n\n<!-- acceptance -->\nFixture acceptance.\n<!-- /acceptance -->\n")


# ---------------------------------------------------------------- memory tests

def t_m1():
    s = Scratch("b74ab11", overlay_tools=True)
    rc, out = s.cr("docstatus")
    outcome("T-M1", "(a) b74ab11 fails naming the operating model",
            bool(fails(out, "docstatus", "plan/Builder_Operating_Model.md")), out)
    s = Scratch()
    rc, out = s.cr("docstatus")
    outcome("T-M1", "(b) the migrated tree passes", rc == 0, out)
    s.write("plan/fixture.md", "# Fixture\n\nThe operating model is <!--fact:govdoc-status:plan/Builder_Operating_Model.md-->binding<!--/fact-->.\n")
    rc, out = s.cr("docstatus")
    outcome("T-M1", "(c) a fact marker differing from its home fails naming the marker",
            bool(fails(out, "docstatus", "govdoc-status:plan/Builder_Operating_Model.md")), out)


def t_m2(mutant=False):
    s = Scratch()
    if mutant:  # committed, so that the fixture's own checkout below keeps it
        s.sub("tools/check_records.py", "def check_views(out):\n", "def check_views(out):\n    return\n")
        s.commit("mutant: views disabled")
        s.records("render")
        s.commit("mutant: rendered")
    rc, out = s.cr("views")
    ok0 = outcome("T-M2", "unmodified tree passes", rc == 0, out)
    s.sub("plan/ledger.md", "**Ready (startable now):**", "**Ready (startable now, edited):**")
    rc, out = s.cr("views")
    ok1 = outcome("T-M2", "a hand-edited generated line fails", bool(fails(out, "views", "frontier")), out)
    s.git("checkout", "-q", "--", ".")
    front_edit(s, "plan/work/W-C00-12.5.md", lambda m: m.update(execution="finished"))
    rc, out = s.cr("views")
    ok2 = outcome("T-M2", "a state change without a re-render fails", bool(fails(out, "views")), out)
    return ok0 and ok1 and ok2


def t_m3(mutant=False):
    def pr(name, edit):
        s = Scratch()
        if mutant:
            s.sub("tools/check_records.py", "def check_kinds(base, head, out):\n",
                  "def check_kinds(base, head, out):\n    return\n")
        base = s.commit("fixture base") if mutant else s.rev()
        s.git("checkout", "-q", "-b", name)
        edit(s)
        head = s.commit(name)
        return s, s.cr("kinds", "--base", base, "--head", head)[1]

    def mod_decision(s):
        s.sub("plan/decisions/D-001.md", "\n# ", "\n# Fixture word. ", 1) if "\n# " in s.read("plan/decisions/D-001.md") \
            else s.append("plan/decisions/D-001.md", "Fixture word.")

    def log_mod(s):
        lg = s.log()
        t = s.read(lg)
        i = t.index("### L-001")
        s.write(lg, t[:i] + "### L-001 (edited)" + t[i + len("### L-001"):])

    _, out = pr("a", mod_decision)
    oka = outcome("T-M3", "(a) a modified decision record without a Record changes line fails",
                  bool(fails(out, "kinds", "plan/decisions/D-001.md")), out)
    if mutant:
        return oka
    _, out = pr("b", log_mod)
    outcome("T-M3", "(b) a modified log entry fails", bool(fails(out, "kinds", "append-only")), out)

    def c(s):
        mod_decision(s)
        s.append(s.log(), "- **Record changes:** D-001 · correction")
    _, out = pr("c", c)
    outcome("T-M3", "(c) a correction without a reason fails", bool(fails(out, "kinds", "gives no reason")), out)

    def d(s):
        mod_decision(s)
        log_mod(s)
        s.append(s.log(), "- **Record changes:** D-001 · correction · a fixture typo")
    _, out = pr("d", d)
    outcome("T-M3", "(d) the decision change with a correct block passes; the log modification still fails",
            not fails(out, "kinds", "D-001") and bool(fails(out, "kinds", "append-only")), out)
    # (e): through the stop check, with a remote and a merged main
    s = Scratch(remote=True)
    base = s.release_and_baseline()
    s.push()
    s.git("checkout", "-q", "-b", "e")
    mod_decision(s)
    s.append(s.log(), "- **Record changes:** D-001 · correction · patch:M-R14 · a fixture typo")
    s.records("render")
    s.commit("e")
    rc, out = s.cr("kinds", "--base", "main", "--head", "e")
    oke = outcome("T-M3", "(e) a correction line with patch:M-R14 is accepted", rc == 0, out)
    s.merge("e")
    s.push()
    rc, out = s.bc("--since", base)
    outcome("T-M3", "(e) the stop check passes and prints a patch count of 1 for M-R14",
            "BUILDER_CHECK PASS" in out and re.search(r"\[patch\].*M-R14 1\b", out) is not None, out)
    return oka


def t_m4():
    s = Scratch()
    s.write("plan/decisions/D-999.md", "---\nid: D-999\nclass: technical\nstatus: open\ntitle: Fixture\n---\n\n# D-999\n")
    rc, out = s.cr("chain")
    outcome("T-M4", "a decision file not in its index fails", bool(fails(out, "chain", "D-999")), out)
    s = Scratch()
    t = s.read("plan/builder/w-c00-12/02_memory.md")
    t2 = "\n".join(l for l in t.splitlines() if not l.startswith("| Decision |")) + "\n"
    assert t2 != t
    s.write("plan/builder/w-c00-12/02_memory.md", t2)
    rc, out = s.cr("chain")
    outcome("T-M4", "a home removed from the map fails", bool(fails(out, "chain", "plan/decisions/")), out)
    s = Scratch()
    s.append("CLAUDE.md", "\nSee `plan/nothing.md`.")
    rc, out = s.cr("chain")
    outcome("T-M4", "a missing file named in CLAUDE.md fails", bool(fails(out, "chain", "plan/nothing.md")), out)


def t_m5r():
    s = Scratch()
    s.sub("DURUM.md", "**Aşama:**", "**Aşama (elle):**")
    rc, out = s.cr("views")
    outcome("T-M5r", "(a) a hand-edited DURUM.md fact line fails", bool(fails(out, "views", "DURUM.md")), out)
    s = Scratch()
    front_edit(s, "plan/decisions/D-001.md", lambda m: m.update(status="open"))
    rc, out = s.cr("views")
    outcome("T-M5r", "(b) a waiting-for-Batu change without a re-render fails", bool(fails(out, "views", "DURUM.md")), out)
    s = Scratch()
    lines = [l for l in s.read("DURUM.md").splitlines() if l.strip()]
    outcome("T-M5r", "(c) the template's first content line is 'Senden beklenen' and it states the check-in residual",
            lines[1].startswith("**Senden beklenen:**") and "dört boş kontrolden sonra" in s.read("DURUM.md"))


def t_m6r():
    batu = "batuhanozgun"
    s = Scratch()
    url = s.comments_url([{"id": 5946719804, "user": {"login": batu}}, {"id": 111111, "user": {"login": batu}}])
    rc, out = s.cr("answers", "--url", url)
    outcome("T-M6r", "(a) an unrecorded comment by batuhanozgun fails naming its ID", bool(fails(out, "answers", "111111")), out)
    rc, out = s.cr("answers", "--url", "file:///nonexistent/comments.json")
    outcome("T-M6r", "(b) an unreachable URL fails with ISSUE_READ_FAILED",
            bool(fails(out, "answers", "ISSUE_READ_FAILED")) and rc == 1, out)
    rc, out = s.cr("answers", "--url", s.comments_url([{"id": 5946719804, "user": {"login": batu}},
                                                       {"id": 7, "user": {"login": "someone-else"}}]))
    outcome("T-M6r", "(c) all comments by batuhanozgun recorded passes", rc == 0, out)
    state_row(s, "answers seen through", "issue #6 comment `222222`", iso(NOW))
    rc, out = s.cr("answers", "--url", s.comments_url([{"id": 5946719804, "user": {"login": batu}},
                                                       {"id": 222222, "user": {"login": batu}}]))
    outcome("T-M6r", "(d) the cursor moved past an unrecorded comment fails naming it", bool(fails(out, "answers", "222222")), out)
    # (e) through the stop check
    s = Scratch(remote=True)
    base = s.release_and_baseline()
    s.push()
    bad = {"ISSUE_API_URL": "file:///nonexistent/comments.json"}
    rc, out = s.bc("S3", "ISSUE_READ_FAILED", "--since", base, env=bad)
    outcome("T-M6r", "(e) S3 ISSUE_READ_FAILED without the MCP line fails", bool(fails(out, "answers", "ISSUE_READ_FAILED")), out)
    s.append(s.log(), "- issue read by MCP: 5946719804 (fixture)")
    s.commit("log the MCP read", session=RUN)
    s.push()
    rc, out = s.bc("S3", "ISSUE_READ_FAILED", "--since", base, env=bad)
    outcome("T-M6r", "(e) S3 ISSUE_READ_FAILED with the MCP line passes", "BUILDER_CHECK PASS" in out, out)
    rc, out = s.bc("S1", "--since", base, env=bad)
    outcome("T-M6r", "(e) S1 with the MCP line still fails", bool(fails(out, "answers", "ISSUE_READ_FAILED")), out)


def stamps_case(test, label, edit, expect_fail, date=None):
    s = Scratch()
    base = s.rev()
    edit(s)
    head = s.commit(label, date=date or NOW)
    rc, out = s.cr("stamps", "--base", base, "--head", head)
    got_fail = bool(fails(out, "stamps"))
    return outcome(test, f"{label}: {'fails' if expect_fail else 'passes'}", got_fail == expect_fail, out)


def t_m7a():
    def lock(t):
        return lambda s: state_row(s, "Run lock", f"`{RUN}` (fixture). Expires {iso(t)}", iso(NOW))
    stamps_case("T-M7a", "(a) lease expiry 3h20m ahead", lock(NOW + timedelta(hours=3, minutes=20)), True)
    stamps_case("T-M7a", "(b) lease expiry in the past", lock(NOW - timedelta(minutes=10)), True)
    stamps_case("T-M7a", "(c) lease expiry 3h ahead", lock(NOW + timedelta(hours=3)), False)
    stamps_case("T-M7a", "(d) a prose log line with a future time and no sched: mark",
                lambda s: s.append(s.log(), f"- Fixture: the wake fires at {(NOW + timedelta(hours=1)):%H:%M}Z."), True)
    stamps_case("T-M7a", "(e) the same line marked sched:",
                lambda s: s.append(s.log(), f"- Fixture: the wake fires at sched:{iso(NOW + timedelta(hours=1))}."), False)
    resets = NOW + timedelta(days=3)

    def wakes(entry):
        def f(s):
            state_row(s, "Usage", f"`seven_day` `allowed_warning` at {(NOW - timedelta(minutes=5)):%H:%M}Z "
                                  f"(`get_session`), resets {iso(resets)}", iso(NOW))
            state_row(s, "Armed wakes", entry, iso(NOW))
        return f
    stamps_case("T-M7a", "(f) an S5 wake at resets plus 15 minutes",
                wakes(f"S5 {iso(resets + timedelta(minutes=15))} trig_01FIXTURE"), False)
    stamps_case("T-M7a", "(f) an S5 wake at resets plus 2 hours",
                wakes(f"S5 {iso(resets + timedelta(hours=2))} trig_01FIXTURE"), True)
    stamps_case("T-M7a", "(f) a Watchdog wake 3 days ahead", wakes(f"Watchdog {iso(NOW + timedelta(days=3))} trig_01FIXTURE"), True)


def t_m7b():
    def asof(t):
        return lambda s: state_row(s, "summary_tr", "Fixture summary.", iso(t))
    stamps_case("T-M7b", "(a) As-of 10 minutes after the commit", asof(NOW + timedelta(minutes=10)), True)
    stamps_case("T-M7b", "(b) As-of 20 minutes before the commit", asof(NOW - timedelta(minutes=20)), True)
    stamps_case("T-M7b", "(c) As-of 5 minutes before the commit", asof(NOW - timedelta(minutes=5)), False)
    stamps_case("T-M7b", "(d) Usage As-of is the write time, quoting a 40-minute-old observation with its source",
                lambda s: state_row(s, "Usage", f"`five_hour` `allowed` at {(NOW - timedelta(minutes=40)):%H:%M}Z "
                                                f"(`get_session`), resets {iso(NOW + timedelta(hours=2))}", iso(NOW)), False)
    stamps_case("T-M7b", "(e) an added plan/ file whose Written: line says 18:31Z against an 18:25:01Z commit",
                lambda s: s.write("plan/builder/w-c00-12/FIXTURE_INTENT.md",
                                  "# Fixture write-ahead\n\n**Written:** 2026-10-03 18:31Z by run `session_fixture`.\n"),
                True, date=datetime(2026, 10, 3, 18, 25, 1, tzinfo=timezone.utc))


def t_m7c():
    if subprocess.run(["git", "rev-parse", "--is-shallow-repository"], cwd=REPO, capture_output=True,
                      text=True).stdout.strip() != "false":
        outcome("T-M7c", "(a) needs full history: run git fetch --unshallow", False)
    else:
        s = Scratch("d69d7c6")
        sys.path.insert(0, str(REPO / "tools"))
        import check_records as C  # the real check's line function, run against the old tree's blame
        cwd = os.getcwd()
        os.chdir(s.d)
        try:
            times = C.blame_times("d69d7c6", "plan/ledger/C00-log.md")
            lines = C.content("d69d7c6", "plan/ledger/C00-log.md").splitlines()
        finally:
            os.chdir(cwd)
        got, entry, other = [], None, []
        for ln, line in enumerate(lines):
            m = re.match(r"### (L-\d+)", line)
            if m:
                entry = m.group(1)
            if not entry or not ("L-016" <= entry <= "L-041"):
                continue
            for prob in C.line_problems("plan/ledger/C00-log.md", line, times[ln], None):
                tm = re.search(r"time '([^']+)' is later", prob)
                (got if tm else other).append((entry, tm.group(1)) if tm else (entry, prob))
        ev = (REPO / "evidence/C00/probes/W12-R3_times_walkthrough.md").read_text()
        pinned = ev.split("Re-run pinned at `d69d7c6`", 1)[1].split("```text\n", 1)[1].split("```", 1)[0]
        want = [(m.group(1), m.group(2)) for m in re.finditer(r"\('(L-\d+)', '[\w-]+', '[\d:]+', '([^']+)'", pinned)]
        outcome("T-M7c", f"(a) the real check over L-016 to L-041 at d69d7c6 fails exactly on the prototype's "
                         f"{len(want)} rows", sorted(got) == sorted(want) and not other,
                f"got {len(got)}, want {len(want)}; only got {sorted(set(got) - set(want))[:3]}; "
                f"only want {sorted(set(want) - set(got))[:3]}; other {other[:2]}")
    stamps_case("T-M7c", "(b) a dateless quoted time 5 minutes after the commit",
                lambda s: s.append(s.log(), f"- Fixture: observed at {(NOW + timedelta(minutes=5)):%H:%M}Z."), True)
    late = datetime(2026, 10, 4, 0, 10, tzinfo=timezone.utc)
    stamps_case("T-M7c", "(c) committed at 00:10Z quoting '23:50Z' without its date",
                lambda s: s.append(s.log(), "- Fixture: the reading at 23:50Z last evening."), True, date=late)
    stamps_case("T-M7c", "(c) the same with its date",
                lambda s: s.append(s.log(), "- Fixture: the reading at 2026-10-03T23:50Z last evening."), False, date=late)


def t_m11():
    s = Scratch()
    s.write("plan/work/W-C00-99.md", "<!-- note N-990 status=open origin=fixture -->\nA note with no item.\n<!-- /note -->\n")
    rc, out = s.cr("chain")
    outcome("T-M11", "a note written into a non-existent item path fails the chain check",
            bool(fails(out, "chain", "W-C00-99")), out)
    s = Scratch()
    new_item(s, "W-C03-01", "C03")
    s.append("plan/work/W-C03-01.md", "\n<!-- note N-991 status=open origin=fixture -->\nA discovery for C03.\n<!-- /note -->\n")
    rc, out = s.records("render")
    zoom = s.read("plan/ledger.md").split("<!-- generated:zoom -->", 1)[1].split("<!-- /generated -->", 1)[0]
    outcome("T-M11", "a note on a planned later-stage item appears under that item in the zoom view",
            re.search(r"`W-C03-01`[^\n]*open notes: N-991", zoom) is not None, zoom[-300:])


def t_m14():
    named = set()
    for rev, want in (("05ba7c9", "R-C00-BOM-3.md"), ("ef4bd4d", "R-C00-BOM-4.md")):
        s = Scratch(rev, overlay_tools=True)
        rc, out = s.cr("claims", "--base", f"{rev}^", "--head", rev)
        f = fails(out, "claims")
        named |= {m for l in f for m in re.findall(r"R-C00-BOM-\d\.md", l)}
        outcome("T-M14", f"(a) claims at {rev} fails naming {want}", any(want in l for l in f), out)
    outcome("T-M14", "(a) together they name R-C00-BOM-3.md and -4.md", {"R-C00-BOM-3.md", "R-C00-BOM-4.md"} <= named)
    s = Scratch()
    s.append(s.log(), "- Fixture: library path `hermes-agent/evidence/2026-09-11-cron-scheduling-delivery/RESEARCH.md`.")
    base = s.rev()
    head = s.commit("library path")
    rc, out = s.cr("claims", "--base", base, "--head", head)
    outcome("T-M14", "(b) a library path containing evidence/ is not reported", not fails(out, "claims"), out)


def t_m15():
    sys.path.insert(0, str(REPO / "tools"))
    import check_records as C
    cwd = os.getcwd()
    os.chdir(REPO)
    try:
        pat, _ = C.leak_terms()
    finally:
        os.chdir(cwd)
    term = sorted(pat.pattern[3:-3].split("|"), key=len)[-1].replace("\\", "")  # never printed

    def case(label, branch_text, copy_text, branch_session=REVIEWER, expect_fail=True):
        s = Scratch()
        if branch_session != "session_01UNOWNEDxxxxxxxxxxxxxxx":
            s.append(".claude/hooks/owned_ids.txt", branch_session)
        main = s.commit("fixture: the reviewer is an owned session")
        vt = branch_text(main)
        s.git("checkout", "-q", "-b", "claude/review-R-FX1")
        s.write("evidence/C00/reviews/R-FX1.md", vt)
        s.commit("R-FX1 verdict", session=branch_session)
        s.git("checkout", "-q", "main")
        s.git("checkout", "-q", "-b", "pr")
        s.write("evidence/C00/reviews/R-FX1.md", copy_text(vt))
        head = s.commit("copy R-FX1", session=PRODUCER)
        rc, out = s.cr("claims", "--base", main, "--head", head)
        got = bool(fails(out, "claims", "R-FX1"))
        return outcome("T-M15", f"{label}: {'fails' if expect_fail else 'passes'}", got == expect_fail,
                       out.replace(term, "[term]"))
    plain = lambda sha: verdict_text(sha, "PASS", "Line one.\nLine two.")  # noqa: E731
    withterm = lambda sha: verdict_text(sha, "PASS", f"The server {term} was listed.\nLine two.")  # noqa: E731
    case("(a) one byte changed from the branch blob", plain, lambda t: t.replace("Line one.", "Line one!"))
    case("(b) committed on the review branch by the producer's session", plain, lambda t: t, branch_session=PRODUCER)
    case("(b2) committed on the review branch by a session that is not owned (critic of 1b-ii #2)", plain,
         lambda t: t, branch_session="session_01UNOWNEDxxxxxxxxxxxxxxx")
    case("(c) a redacted copy whose differing line is a pattern substitution", withterm,
         lambda t: t.replace(term, "[service]"), expect_fail=False)
    case("(d) a redacted copy that also changes a non-pattern word", withterm,
         lambda t: t.replace(term, "[service]").replace("listed", "named"))
    s = Scratch()
    s.git("fetch", "-q", str(REPO), "refs/remotes/origin/claude/review-R-W12-1:refs/remotes/origin/claude/review-R-W12-1")
    s.git("rm", "-q", "evidence/C00/reviews/R-W12-1.md")
    base = s.commit("fixture: remove R-W12-1")
    s.git("checkout", "-q", "HEAD^", "--", "evidence/C00/reviews/R-W12-1.md")
    head = s.commit("fixture: copy R-W12-1 again")
    rc, out = s.cr("claims", "--base", base, "--head", head)
    outcome("T-M15", "(e) R-W12-1's committed copy passes", not fails(out, "claims"), out)


# ---------------------------------------------------------------- work-model tests

def accept(meta, ab, label="session"):
    meta.update(execution="finished", acceptance="accepted", accepted_by=ab, acceptance_label=label)


def t_w1_r11():
    s = Scratch()
    s.write("tools/x_echo.py", "print('A')\n")
    s.commit("fixture script")
    new_item(s, "W-C00-12.9", "W-C00-12", targets=["plan/notes/x.md"], triage="evidence/C00/tests/triage_fx.md",
             execution="running")
    s.write("evidence/C00/tests/triage_fx.md", "Triage: normal (fixture).\n")
    running = s.commit("item running")
    s.write("evidence/C00/reviews/R-FX9.md", verdict_text(running, "PASS", "Reviews W-C00-12.9."))
    s.write("evidence/C00/reviews/R-FX8.md", verdict_text(running, "PASS", "Reviews W-C00-12.9.\nTests: T-M5"))
    s.write("evidence/C00/tests/handwritten.md", "Deterministic result: PASS (written by hand).\n")
    s.write("evidence/C00/tests/rerun_differs.md", f"Deterministic-Command: python3 tools/x_echo.py\n"
                                                  f"Deterministic-Commit: {running}\nDeterministic-Result: B\n")
    s.commit("evidence fixtures")
    p = "plan/work/W-C00-12.9.md"

    def check(label, fn, expect_fail):
        front_edit(s, p, fn)
        rc, out = s.cr("work")
        got = bool(fails(out, "work", "W-C00-12.9"))
        s.git("checkout", "-q", "--", p)
        return outcome("T-W1", f"{label}: {'fails' if expect_fail else 'passes'}", got == expect_fail, out)
    check("accepted_by names the producer session", lambda m: accept(m, PRODUCER), True)
    check("accepted_by empty", lambda m: accept(m, ""), True)
    check("a retired test cited", lambda m: accept(m, "evidence/C00/reviews/R-FX8.md"), True)
    check("a hand-written 'deterministic' file naming no command",
          lambda m: accept(m, "evidence/C00/tests/handwritten.md", "deterministic"), True)
    check("a command whose re-run differs", lambda m: accept(m, "evidence/C00/tests/rerun_differs.md", "deterministic"), True)
    # (g): the script changed in a PR without a verdict, after the item became running
    s.git("checkout", "-q", "-b", "g")
    s.write("tools/x_echo.py", "# changed after the item started\nprint('A')\n")
    s.commit("change script")
    mg = s.merge("g")
    s.write("evidence/C00/tests/g.md", f"Deterministic-Command: python3 tools/x_echo.py\nDeterministic-Commit: {mg}\n"
                                       "Deterministic-Result: A\n")
    s.commit("g evidence")
    check("(g) the command's script changed in a normal-class PR after the item became running",
          lambda m: accept(m, "evidence/C00/tests/g.md", "deterministic"), True)
    s.git("checkout", "-q", "-b", "h")
    s.write("plan/notes/h.md", "unrelated\n")
    hh = s.commit("unrelated change")
    s.merge("h")
    s.write("evidence/C00/reviews/R-FX7.md", verdict_text(hh, "PASS"))
    s.commit("verdict on the unrelated PR")
    check("(h) the same, after a later PR with a bound verdict that did not touch the script",
          lambda m: accept(m, "evidence/C00/tests/g.md", "deterministic"), True)
    check("an existing verdict of another item reused (critic of 1b-ii #1)",
          lambda m: accept(m, "evidence/C00/reviews/R-W12-3.md"), True)
    check("a bound verdict", lambda m: accept(m, "evidence/C00/reviews/R-FX9.md"), False)
    front_edit(s, p, lambda m: (accept(m, "evidence/C00/reviews/R-FX9.md"), m.pop("acceptance_label")))
    rc, out = s.cr("work")
    outcome("T-R11", "an accepted item without an independence label fails", bool(fails(out, "work", "acceptance_label")), out)


def t_w3r():
    s = Scratch()
    s.write("evidence/C00/reviews/R-FX9.md", verdict_text(s.rev(), "PASS"))
    new_item(s, "W-C00-12.9", "W-C00-12", assumes=["D-001", "D-002"], targets=["plan/notes/x.md"])
    s.records("render")
    fr = lambda: s.read("plan/ledger.md").split("**Running:**")[0]  # noqa: E731
    outcome("T-W3r", "precondition: the fixture item is ready", "`W-C00-12.9`" in fr())
    front_edit(s, "plan/decisions/D-001.md", lambda m: m.update(status="superseded"))
    s.records("render")
    outcome("T-W3r", "(a) superseding an assumed decision marks the item stale and drops it from the frontier",
            "`W-C00-12.9`" not in fr() and "stale" in s.read("plan/ledger.md"))
    s.git("checkout", "-q", "--", "plan/decisions/D-001.md")
    s.append(s.log(), "\n### L-999 · 2026-10-03 · Fixture\n\n- **Record changes:** D-002 · correction · fixture")
    s.records("render")
    outcome("T-W3r", "(b) a correction line for another assumed decision marks it stale", "`W-C00-12.9`" not in fr())
    front_edit(s, "plan/work/W-C00-12.9.md", lambda m: (accept(m, "evidence/C00/reviews/R-FX9.md"),
                                                         m.update(triage="evidence/C00/reviews/R-FX9.md")))
    rc, out = s.cr("work")
    outcome("T-W3r", "(c) accepting the stale item fails", bool(fails(out, "work", "stale")), out)
    front_edit(s, "plan/work/W-C00-12.9.md", lambda m: m.update(rechecked="L-999"))
    rc, out = s.cr("work")
    outcome("T-W3r", "(d) a recheck note clears it", not fails(out, "work", "stale"), out)


def t_w4():
    s = Scratch()
    new_item(s, "W-C00-12.8", "W-C00-12", execution="running")
    new_item(s, "W-C00-12.8.1", "W-C00-12.8", execution="running")
    run = s.commit("parent and child running")
    s.write("evidence/C00/reviews/R-FXC.md", verdict_text(run, "PASS", "Reviews W-C00-12.8.1."))
    front_edit(s, "plan/work/W-C00-12.8.1.md", lambda m: accept(m, "evidence/C00/reviews/R-FXC.md"))
    child = s.commit("child accepted")
    s.write("evidence/C00/reviews/R-FXP.md", verdict_text(child, "PASS", "Composition review of W-C00-12.8."))
    s.commit("composition verdict")
    front_edit(s, "plan/work/W-C00-12.8.md", lambda m: accept(m, "evidence/C00/reviews/R-FXP.md"))
    rc, out = s.cr("work")
    outcome("T-W4", "a parent accepted without a composition record fails", bool(fails(out, "work", "W-C00-12.8: a parent")), out)
    front_edit(s, "plan/work/W-C00-12.8.md", lambda m: m.update(composition_by="evidence/C00/reviews/R-FXP.md"))
    rc, out = s.cr("work")
    outcome("T-W4", "with a composition record it passes", not fails(out, "work", "W-C00-12.8"), out)
    front_edit(s, "plan/work/W-C00-12.8.md", lambda m: m.update(composition_by="evidence/C00/reviews/R-FXC.md"))
    rc, out = s.cr("work")
    outcome("T-W4", "a child's verdict reused as the composition record fails", bool(fails(out, "work", "W-C00-12.8: composition")), out)


def t_w9():
    T = "T-W9"

    def klass(label, edit, want, s=None, base=None):
        s = s or Scratch()
        base = base or s.rev()
        s.git("checkout", "-q", "-b", f"pr{abs(hash(label)) % 10**6}")
        edit(s)
        head = s.commit(label)
        rc, out = s.cr("impact", "--base", base, "--head", head)
        got = "high" if "class high" in out else ("normal" if "class normal" in out else "?")
        s.git("checkout", "-q", "main")
        return outcome(T, f"{label}: class {want}", got == want, out), s, head

    gov = lambda s: s.sub("plan/ledger.md", "| Governing documents: `plan/Builder_Operating_Model.md` | version: 1.7; status: governs",  # noqa
                          "| Governing documents: `plan/Builder_Operating_Model.md` | version: 1.7; status: Status: binding; governs")
    klass("(a) 'Status: binding' written into a Governing-documents row", gov, "high")
    klass("(b) one word changed inside an existing acceptance block",
          lambda s: s.sub("plan/work/W-C00-12.5.md", "<!-- acceptance -->\n", "<!-- acceptance -->\nFixture "), "high")
    klass("(c) a lease renewal", lambda s: s.records("lease", "--session", RUN), "normal")
    s = Scratch(remote=True)
    base = s.release_and_baseline()
    s.git("checkout", "-q", "-b", "d")
    gov(s)
    s.append(s.log(), "- **Record changes:** plan/ledger.md Governing documents · supersession · fixture")
    s.records("render")
    s.commit("d")
    s.merge("d")
    s.push()
    rc, out = s.bc("--since", base)
    outcome(T, "(d) (a) merged without a session verdict: the stop check fails", bool(fails(out, "impact")), out)
    new = lambda s: new_item(s, "W-C00-12.7", "W-C00-12")  # noqa: E731
    klass("(e) a new item with its first acceptance block", new, "normal")
    klass("(f) one line of plan/Ek_A_Rol_Sozlesmeleri.md", lambda s: s.append("plan/Ek_A_Rol_Sozlesmeleri.md", "Fixture."), "high")
    klass("(g) one line of tools/records.py", lambda s: s.append("tools/records.py", "# fixture"), "high")

    def revert_case(label, change, want, extra=None):
        s = Scratch()
        s.git("checkout", "-q", "-b", "m1")
        change(s)
        s.commit("m1")
        m1 = s.merge("m1")
        def revert(s2):
            for p in s2.git("diff", "--name-only", f"{m1}^1", m1)[1].split():
                if extra is not None and not extra(p):
                    continue
                if s2.git("cat-file", "-e", f"{m1}^1:{p}")[0] == 0:
                    s2.git("checkout", "-q", f"{m1}^1", "--", p)
                else:
                    s2.git("rm", "-q", "--", p)  # the merge added it, so its revert removes it
        return klass(label, revert, want, s=s, base=m1)

    exec_only = lambda p: p.startswith(("tools/", ".claude/"))  # noqa: E731
    revert_case("(h) the exact revert of a merge that changed only tools/check_records.py",
                lambda s: s.append("tools/check_records.py", "# fixture change"), "normal")
    # (h2): the stop check after the revert and its break-glass line, with no later verdict
    s = Scratch(remote=True)
    base = s.release_and_baseline()
    s.git("checkout", "-q", "-b", "m1")
    s.append("tools/check_records.py", "# fixture change")
    s.commit("m1")
    m1 = s.merge("m1")
    s.git("checkout", "-q", "-b", "rev")
    s.git("checkout", "-q", f"{m1}^1", "--", "tools/check_records.py")
    s.commit("break-glass revert of m1")
    s.merge("rev")
    s.git("checkout", "-q", "-b", "bgline")
    s.append(s.log(), f"- break-glass: {m1}")
    s.commit("break-glass line")
    s.merge("bgline")
    s.push()
    rc, out = s.bc("--since", base)
    outcome(T, "(h2) after the break-glass revert and its line, with no verdict, the stop check fails",
            bool(fails(out, "break-glass")), out)
    s.git("checkout", "-q", "-b", "p2")
    s.write("plan/notes/p2.md", "unrelated\n")
    p2 = s.commit("unrelated PR")
    s.merge("p2")
    s.git("checkout", "-q", "-b", "claude/review-R-P2")
    s.write("evidence/C00/reviews/R-P2.md", verdict_text(m1, "PASS", f"Unrelated PR at {p2}."))
    s.commit("R-P2", session=REVIEWER)
    s.git("checkout", "-q", "main")
    s.git("checkout", "-q", "-b", "copy")
    s.git("checkout", "-q", "claude/review-R-P2", "--", "evidence/C00/reviews/R-P2.md")
    s.append(".claude/hooks/owned_ids.txt", REVIEWER)
    s.commit("copy R-P2")
    s.merge("copy")
    rc, out = s.cr("merged", "--since", base, "--main", "main")
    outcome(T, "(h3) an unrelated verdict naming the reverted merge does not cover the break-glass revert",
            bool(fails(out, "break-glass")), out)
    s = Scratch()
    s.git("checkout", "-q", "-b", "m1")
    s.append("tools/records.py", "# fixture one")
    s.commit("m1")
    m1 = s.merge("m1")
    s.git("checkout", "-q", "-b", "m2")
    s.append("tools/records.py", "# fixture two")
    s.commit("m2")
    m2 = s.merge("m2")
    klass("(h4) restoring the content before M1 after a later merge M2 is not break-glass",
          lambda s2: s2.git("checkout", "-q", f"{m1}^1", "--", "tools/records.py"), "high", s=s, base=m2)
    revert_case("(i) the exact revert of a merge that changed an acceptance block",
                lambda s: s.sub("plan/work/W-C00-12.5.md", "<!-- acceptance -->\n", "<!-- acceptance -->\nFixture "), "high")
    revert_case("(i) the exact revert of a merge that changed a Governing-documents row", gov, "high")
    klass("(j) deleting an existing depends_on entry",
          lambda s: front_edit(s, "plan/work/W-C00-12.5.md", lambda m: m.update(depends_on=[])), "high")
    klass("(k) adding on: finished to an edge",
          lambda s: front_edit(s, "plan/work/W-C00-12.5.md", lambda m: m.update(
              depends_on=[{"id": "W-C00-12.4", "on": "finished", "reason": "fixture"}])), "high")
    klass("(l) admission admitted -> candidate",
          lambda s: front_edit(s, "plan/work/W-C00-12.5.md", lambda m: m.update(admission="candidate")), "high")
    s = Scratch()
    new_item(s, "W-C00-12.7", "W-C00-12", admission="candidate")
    s.commit("a candidate")
    klass("(l) candidate -> admitted on an item with no waits_for",
          lambda s2: front_edit(s2, "plan/work/W-C00-12.7.md", lambda m: m.update(admission="admitted")), "normal", s=s)
    klass("(m) one word of the Stage row", lambda s: s.sub("plan/ledger.md", "| Stage | **C00 on hold.**", "| Stage | **C00 on hold (fixture).**"), "high")
    klass("(n) a new tools/x_check.py", lambda s: s.write("tools/x_check.py", "print('x')\n"), "high")
    klass("(n) one line of plan/builder/w-c00-12/check_ids.py", lambda s: s.append("plan/builder/w-c00-12/check_ids.py", "# fixture"), "high")
    klass("(o) appending a recorder-form line to owned_ids.txt",
          lambda s: s.append(".claude/hooks/owned_ids.txt", "session_01FIXTUREappendedxxxxxxx"), "normal")
    klass("(o) deleting a line of owned_ids.txt",
          lambda s: s.write(".claude/hooks/owned_ids.txt", "\n".join(s.read(".claude/hooks/owned_ids.txt").splitlines()[1:]) + "\n"), "high")

    def p_change(s):
        s.append("tools/check_records.py", "# fixture change")
        s.append(s.log(), "\n### L-998 · 2026-10-03 · Fixture entry\n")
    revert_case("(p) the exact revert of the executable part of a merge that also added a log entry", p_change, "normal", exec_only)
    revert_case("(q) the exact revert of a merge that changed .github/workflows/watchdog.yml",
                lambda s: s.write(".github/workflows/watchdog.yml", "name: fixture\non: workflow_dispatch\n"), "high")
    revert_case("(q) the exact revert of a merge that changed tools/builder_check.sh",
                lambda s: s.append("tools/builder_check.sh", "# fixture"), "high")
    s = Scratch()
    new_item(s, "W-C00-12.7", "W-C00-12", admission="candidate", waits_for=["D-001"])
    s.commit("candidate waiting on Batu")
    front_edit(s, "plan/work/W-C00-12.7.md", lambda m: m.pop("waits_for"))
    s.commit("waits_for removed")
    klass("(r) candidate -> admitted on a candidate whose history once carried waits_for",
          lambda s2: front_edit(s2, "plan/work/W-C00-12.7.md", lambda m: m.update(admission="admitted")), "high", s=s)
    def lift(s2):
        for iid in ("W-C00-12.1", "W-C00-12.3", "W-C00-12.4", "W-C00-12.5", "W-C00-12"):
            front_edit(s2, f"plan/work/{iid}.md", lambda m: m.update(
                acceptance="accepted", accepted_by="evidence/C00/reviews/R-W12-3.md", acceptance_label="session",
                composition_by="evidence/C00/reviews/R-W12-3.md"))
    ok, s, head = klass("(t) reusing an existing verdict to accept W-C00-12 and its children (critic of 1b-ii #1)",
                        lift, "high")
    s.git("checkout", "-q", head)
    rc, out = s.cr("work")
    outcome(T, "(t) the work check rejects the reused verdict", bool(fails(out, "work", "W-C00-12: ")), out)
    ok, s, head = klass("(s) a new admitted item under a stage with hold_until",
                        lambda s: new_item(s, "W-C00-13", "C00"), "normal")
    s.git("checkout", "-q", head)
    s.records("render")
    fr = s.read("plan/ledger.md").split("<!-- generated:frontier -->", 1)[1].split("<!-- /generated -->", 1)[0]
    outcome(T, "(s) the render shows it blocked by the hold",
            re.search(r"`W-C00-13`: stage C00 on hold until W-C00-12", fr) is not None and
            "`W-C00-13` Fixture" not in fr.split("**Running:**")[0], fr[:300])


def t_r4():
    s = Scratch()
    s.write("evidence/C00/tests/subagent_fx.md", "Verdict: PASS\nIndependence: subagent (fixture)\n")
    new_item(s, "W-C00-12.6", "W-C00-12", impact="normal", targets=[".claude/hooks/tool_allowlist.py"])
    front_edit(s, "plan/work/W-C00-12.6.md", lambda m: accept(m, "evidence/C00/tests/subagent_fx.md", "subagent"))
    rc, out = s.cr("work")
    f = fails(out, "work", "W-C00-12.6")
    outcome("T-R4", "an item marked small touching .claude/hooks/: computed class high, acceptance below a session "
                    "verdict rejected", any("R-R3" in l and "impact normal is below" in l for l in f) and
            any("below a session verdict" in l for l in f), out)
    new_item(s, "W-C00-12.61", "W-C00-12", targets=["plan/notes/x.md"], execution="running")
    rc, out = s.cr("work")
    outcome("T-R4", "an item of class normal without a triage record is rejected",
            bool(fails(out, "work", "W-C00-12.61: class normal at running without a triage record")), out)


def t_r9():
    s = Scratch()
    full = "premises: [x]\nalternatives: [y]\nchosen_because: z\nconsulted: [none relevant]\n"
    s.write("plan/decisions/D-901.md", "---\nid: D-901\nclass: batu\nstatus: open\ntitle: F\nreopen_if: r\n" + full + "---\n")
    s.write("plan/decisions/D-902.md", "---\nid: D-902\nclass: technical\nmajor: true\nstatus: open\ntitle: F\n"
            "premises: [x]\nalternatives: [y]\nchosen_because: z\nconsulted: [n]\n---\n")
    s.write("plan/decisions/D-903.md", "---\nid: D-903\nclass: batu\nowner_reason: his accounts (Appendix E)\n"
            "status: open\ntitle: F\nreopen_if: r\n" + full + "---\n")
    rc, out = s.cr("decisions")
    outcome("T-R9", "class batu without an owner reason fails", bool(fails(out, "decisions", "D-901")), out)
    outcome("T-R9", "a major decision without reopen_if fails", bool(fails(out, "decisions", "D-902.md: major decision without reopen_if")), out)
    outcome("T-R9", "a complete record passes", not fails(out, "decisions", "D-903"), out)


def t_r20():
    s = Scratch(remote=True)
    s.release_and_baseline()
    s.push()
    since = s.rev()
    s.git("checkout", "-q", "-b", "work")
    state_row(s, "summary_tr", "Fixture summary.", iso(NOW + timedelta(hours=1)))
    s.append(s.log(), "- **Record changes:** plan/ledger.md summary_tr · supersession · fixture")
    s.records("render")
    s.commit("future stamp", session=RUN)
    bad = s.merge("work")  # merged reports a failure against the first-parent merge
    s.push()
    _, o1 = s.bc("--since", since)
    _, o2 = s.bc("--since", since)
    outcome("T-R20", "(a) the second failure of one class on a pushed head prints HAND-OVER DUE naming stamps",
            bool(fails(o1, "stamps")) and not fails(o1, "ahead") and "HAND-OVER DUE" not in o1 and
            re.search(r"HAND-OVER DUE \(R-R9\): a failure class repeated at a checkpoint: stamps", o2) is not None, o2)
    _, o3 = s.bc("S1", "--since", since)
    outcome("T-R20", "(a) S1 then fails", bool(fails(o3, "R-R9")), o3)
    s.append(s.log(), f"- record-check exception: {bad[:12]} stamps: the fixture's future stamp, acknowledged")
    s.commit("acknowledge the merged stamp error", session=RUN)
    s.push()
    _, o4 = s.bc("S4", "--since", since)
    outcome("T-R20", "(a) S4 is accepted once the failures are fixed (acknowledged by a later exception line)",
            "BUILDER_CHECK PASS" in o4 and "HAND-OVER DUE" in o4, o4)
    s = Scratch(remote=True)
    s.release_and_baseline()
    s.push()
    since = s.rev()
    state_row(s, "summary_tr", "Fixture summary.", iso(NOW + timedelta(hours=1)))
    _, o1 = s.bc("--since", since)
    _, o2 = s.bc("--since", since)
    outcome("T-R20", "(b) two failures of one class on an uncommitted tree print no signal",
            bool(fails(o2, "tree")) and "HAND-OVER DUE" not in o1 + o2, o2)


# ---------------------------------------------------------------- map tests

def t_map():
    s = Scratch()
    rc, out = s.cr("map")
    outcome("T-MAP1", "the migrated tree with every carrier mapped passes", rc == 0, out)
    s.write("tools/new_tool.py", "print('x')\n")
    s.write(".claude/hooks/new_hook.py", "print('x')\n")
    st = json.loads(s.read(".claude/settings.json"))
    st["hooks"]["PostToolUse"][0]["hooks"].append({"type": "command", "command": "python3 .claude/hooks/new_hook.py"})
    s.write(".claude/settings.json", json.dumps(st, indent=2))
    s.write(".claude/agents/foo.md", "---\nname: foo\n---\nFixture agent.\n")
    rc, out = s.cr("map")
    f = "\n".join(fails(out, "map"))
    outcome("T-MAP1", "a script, a hook entry and an agent definition without rows fail, each named",
            all(x in f for x in ("tools/new_tool.py", ".claude/hooks/new_hook.py", ".claude/agents/foo.md")), out)
    s = Scratch()
    os.remove(s.p("tools/test_tool_allowlist.sh"))
    rc, out = s.cr("map")
    outcome("T-MAP2", "a removed mapped script fails naming its row", bool(fails(out, "map", "row A-06")), out)
    for path, row in ((".claude/hooks/tool_allowlist.py", "row A-01"), ("tools/builder_check.sh", "row B9"),
                      ("CLAUDE.md", "row B2")):
        s = Scratch()
        os.remove(s.p(path))
        rc, out = s.cr("map")
        outcome("T-MAP2", f"removing {path} fails naming {row} (critic of 1b-ii #6)", bool(fails(out, "map", row)), out)
    s = Scratch()
    t = s.read("plan/builder/mechanisms.md")
    row = next(l for l in t.splitlines() if l.startswith("| B3 |"))
    cells = row.split(" | ")
    cells[5] = ""  # the Her column
    s.write("plan/builder/mechanisms.md", t.replace(row, " | ".join(cells)))
    rc, out = s.cr("map")
    outcome("T-MAP3", "a blank coverage cell fails naming the row and column", bool(fails(out, "map", "row B3: cell 'Her'")), out)
    s = Scratch()
    base = s.commit("fixture base")
    s.git("checkout", "-q", "-b", "status-only")
    st = json.loads(s.read(".claude/settings.json"))
    st["fixture"] = "status-only"
    s.write(".claude/settings.json", json.dumps(st, indent=2))
    s.commit("status-only: touch .claude/settings.json")
    s.merge("status-only", "Merge PR: status-only")
    rc, out = s.cr("merged", "--since", base, "--main", "main")
    outcome("T-MAP5", "a PR touching .claude/settings.json described as status-only needs a session verdict",
            bool(fails(out, "impact", "no session verdict covers")), out)
    s = Scratch(remote=True)
    base = s.release_and_baseline()
    s.push()
    sys.path.insert(0, str(REPO / "tools"))
    import check_records as C
    cwd = os.getcwd()
    os.chdir(REPO)
    try:
        pat, _ = C.leak_terms()
    finally:
        os.chdir(cwd)
    term = sorted(pat.pattern[3:-3].split("|"), key=len)[0].replace("\\", "")
    s.append(s.log(), f"- Fixture line naming {term}.")
    s.git("add", s.log())
    rc, out = s.bc("--since", base)
    outcome("T-MAP7", "a planted derived term in a staged log line fails the stop check through the leak check",
            bool(fails(out, "leak")) and "BUILDER_CHECK FAIL" in out, out.replace(term, "[term]"))


# ---------------------------------------------------------------- main

def main():
    head = subprocess.run(["git", "rev-parse", "HEAD"], cwd=REPO, capture_output=True, text=True).stdout.strip()
    dirty = bool(subprocess.run(["git", "status", "--porcelain"], cwd=REPO, capture_output=True, text=True).stdout.strip())
    print(f"HEAD {head}{' (working tree DIRTY: not valid as gate evidence)' if dirty else ' (clean)'}")
    print(f"run at {datetime.now(timezone.utc):%Y-%m-%dT%H:%M:%SZ}")
    tests = [("T-R20", t_r20), ("T-M1", t_m1), ("T-M2", t_m2), ("T-M3", t_m3), ("T-M4", t_m4), ("T-M5r", t_m5r),
             ("T-M6r", t_m6r), ("T-M7a", t_m7a), ("T-M7b", t_m7b), ("T-M7c", t_m7c), ("T-M11", t_m11),
             ("T-M14", t_m14), ("T-M15", t_m15), ("T-W1", t_w1_r11), ("T-W3r", t_w3r), ("T-W4", t_w4),
             ("T-W9", t_w9), ("T-R4", t_r4), ("T-R9", t_r9), ("T-MAP", t_map)]
    for name, fn in tests:
        try:
            fn()
        except Exception as e:  # a crashing test is a failing test
            outcome(name, f"crashed: {type(e).__name__}: {e}", False)
    print("--- mutation checks (the check disabled in a scratch copy; the test must then report FAIL)")
    saved = dict(RESULTS)
    RESULTS.clear()
    MUTANT[0] = True
    m1 = not t_m2(mutant=True)
    m2 = not t_m3(mutant=True)
    MUTANT[0] = False
    RESULTS.clear()
    RESULTS.update(saved)
    print(f"{'PASS' if m1 else 'FAIL'}  M1 (views disabled): T-M2 reported FAIL: {m1}")
    print(f"{'PASS' if m2 else 'FAIL'}  M2 (kinds disabled): T-M3 (a) reported FAIL: {m2}")
    gate = ["T-R20", "T-M1", "T-M2", "T-M3", "T-M4", "T-M5r", "T-M6r", "T-M7a", "T-M7b", "T-M7c", "T-M11", "T-M14",
            "T-M15", "T-W1", "T-W3r", "T-W4", "T-W9", "T-R4", "T-R9", "T-R11", "T-MAP1", "T-MAP2", "T-MAP3", "T-MAP5",
            "T-MAP7"]
    print("--- per test")
    ok = True
    for t in gate:
        r = RESULTS.get(t, [])
        good = bool(r) and all(r)
        ok &= good
        print(f"{t} {'PASS' if good else 'FAIL'} ({sum(r)}/{len(r)} outcomes)")
    for k in RESULTS:
        if k not in gate:
            ok = False
            print(f"{k} FAIL (crashed outside a gate test)")
    ok &= m1 and m2
    shutil.rmtree(TMPROOT, ignore_errors=True)
    print("GATE 1b-ii PASS" if ok else "GATE 1b-ii FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
