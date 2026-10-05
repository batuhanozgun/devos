#!/usr/bin/env python3
"""test_merge_gate.py: planted cases for tools/merge_gate.py and guard rule M7 (D-010; PC-06).

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
    ok = bool(RESULTS) and all(RESULTS)
    print(f"MERGE_GATE_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
