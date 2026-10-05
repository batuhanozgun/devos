#!/usr/bin/env python3
"""test_merge_gate.py: planted cases for tools/merge_gate.py and guard rule M7 (D-010; PC-06; R-TRANS-1).

The fixture is a scratch repository whose origin is a local bare repository; it carries copies of this working
tree's gate and guard. Each pull request head is pushed to refs/pull/N/head and the gate is run as M7 runs it
(python3 tools/merge_gate.py --pr N --head SHA, fetching from origin); the guard cases give the fixture's guard a
merge_pull_request call. Prints one line per case and MERGE_GATE_TEST PASS only if every case behaves as written.
"""
import json
import os
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


def run(args, cwd, stdin=None, env=None):
    r = subprocess.run(args, cwd=cwd, input=stdin, capture_output=True, text=True, env={**os.environ, **(env or {})})
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
    ok = bool(RESULTS) and all(RESULTS)
    print(f"MERGE_GATE_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
