#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixtures and inputs in this file are made up for
# the test and hold no personal or business data. Not made up, because the formats under test name them: the tool
# names and the field names of Claude Code's subagent transcripts and meta files and of the guard's decision log.
"""test_subagent_audit.py: planted cases for tools/subagent_audit.py (W-C00-15; CHK-C00-041 C4).

The fixture is a fake home directory with transcripts and meta files under .claude/projects/x/y/subagents/ and a
fake guard-log directory, both in a temporary directory that the tool is pointed at through DEVOS_AUDIT_HOME and
DEVOS_GUARD_LOG_DIR. Every tool result, prompt, thinking block and non-path argument holds a marker string that no
output may contain. Prints one line per case and SUBAGENT_AUDIT_TEST PASS only if every case behaves as written.
"""
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
TOOL = Path(__file__).resolve().parent / "subagent_audit.py"
MARKER = "PLANTED-FIXTURE-CONTENT-q7Zx"
WS = "/fx/scratch/bl/rfx01"
FINAL = "---\nid: CHK-FX-001\nverdict: PASS\n---\n\nFindings: none (fixture).\nTürkçe satır: ğüşiöç"
RESULTS, OUTPUTS = [], []


def case(label, ok, detail=""):
    print(f"{'ok  ' if ok else 'BAD '} {label}" + ("" if ok else f": {detail[-800:]}"))
    RESULTS.append(ok)


class Fixture:
    def __init__(self, tmp):
        self.home, self.logs = Path(tmp) / "home", Path(tmp) / "guard"
        self.sub = self.home / ".claude" / "projects" / "x" / "y" / "subagents"
        self.sub.mkdir(parents=True)
        self.logs.mkdir()
        self.n = 0

    def agent(self, agent, calls, guard=None, final=FINAL, after=(), extra=(), log="session_fx1.jsonl"):
        """calls, then the final message, then after: (tool, input) pairs; guard: (event, tool, logged path)
        records, by default one PreToolUse per call; extra: further records."""
        ev = [{"type": "user", "message": {"role": "user", "content": f"Prompt text {MARKER}"}},
              self.text("An earlier text, not the final message.")]
        for i, (tool, inp) in enumerate(list(calls) + list(after)):
            if i == len(calls):
                ev += [self.text(f"thinking {MARKER}", "thinking"), self.text(final)]
            tid = f"toolu_fx_{agent}_{i:02d}"
            ev.append({"type": "assistant", "cwd": "/fx/session-cwd", "message": {"role": "assistant", "content": [
                {"type": "tool_use", "id": tid, "name": tool, "input": inp}]}})
            ev.append({"type": "user", "message": {"role": "user", "content": [
                {"type": "tool_result", "tool_use_id": tid, "content": f"file content {MARKER}"}]}})
        if not after:
            ev += [self.text(f"thinking {MARKER}", "thinking"), self.text(final)]
        (self.sub / f"agent-{agent}.jsonl").write_text("".join(json.dumps(e) + "\n" for e in ev), encoding="utf-8")
        (self.sub / f"agent-{agent}.meta.json").write_text(json.dumps(
            {"agentType": "general-purpose", "description": "fixture", "toolUseId": f"toolu_fx_launch_{agent}"}))
        if guard is None:
            guard = [("PreToolUse", t, i.get("file_path", i.get("path", "")) if t in ("Read", "Glob", "Grep")
                      else json.dumps(i)) for t, i in list(calls) + list(after)]
        with open(self.logs / log, "a", encoding="utf-8") as f:
            for event, tool, logged in list(guard) + list(extra):
                self.n += 1
                f.write(json.dumps({"n": self.n, "time": "2026-01-01T00:00:00Z", "event": event, "agent_id": agent,
                                    "tool_use_id": None, "cwd": "/fx/session-cwd", "tool": tool, "decision": "allow",
                                    "rule": "T1", "summary": logged}) + "\n")

    @staticmethod
    def text(t, kind="text"):
        return {"type": "assistant", "message": {"role": "assistant", "content": [{"type": kind, kind: t}]}}

    def run(self, *args):
        r = subprocess.run([sys.executable, str(TOOL), *args], capture_output=True,
                           env={**os.environ, "DEVOS_AUDIT_HOME": str(self.home), "DEVOS_GUARD_LOG_DIR": str(self.logs)})
        out = r.stdout.decode("utf-8") + r.stderr.decode("utf-8")
        OUTPUTS.append(out)
        return r.returncode, r.stdout.decode("utf-8"), out


GOOD = [("Glob", {"path": WS + "/materials", "pattern": "**/*.md"}),
        ("Read", {"file_path": WS + "/materials/overview.md"}),
        ("Read", {"file_path": WS + "/materials/sub/../ops.md", "offset": 1, "limit": 50}),
        ("Grep", {"path": WS + "/materials", "glob": "*.md", "pattern": MARKER}),
        ("ToolSearch", {"query": MARKER})]


def void_case(fx, label, agent, calls, expect, guard=None, log="session_fx2.jsonl"):
    fx.agent(agent, calls, guard=guard, log=log)
    rc, out, both = fx.run("audit", agent, WS)
    lines = out.splitlines()
    case(label, rc == 1 and lines and lines[-1].startswith("AUDIT VOID: ") and expect in out
         and "AUDIT VALID" not in lines, both)


def main():
    with tempfile.TemporaryDirectory() as tmp:
        fx = Fixture(tmp)
        fx.agent("afx0valid", GOOD, after=[("TodoWrite", {"todos": [{"content": MARKER}]})],   # a later tool-only event
                 extra=[("PermissionRequest", "Read", WS + "/materials/overview.md")])   # not counted
        fx.agent("afx1other", [("Bash", {"command": "true"})])   # another agent's records are not counted

        rc, out, both = fx.run("last", "afx0valid")
        case("(1) last prints the final multi-line message verbatim and skips a later tool-only event",
             rc == 0 and out == FINAL + "\n", both)

        rc, out, both = fx.run("audit", "afx0valid", WS)
        lines = out.splitlines()
        want = [f"transcript: {fx.sub / 'agent-afx0valid.jsonl'}", "toolUseId: toolu_fx_launch_afx0valid",
                "tool calls in the transcript: 6", "guard-log PreToolUse records for afx0valid: 6 (agree)",
                "guard records breaking the rules: none"]
        case("(2) audit of a valid run: all six calls inside, counts agree, AUDIT VALID, exit 0",
             rc == 0 and lines[-1] == "AUDIT VALID" and all(w in lines for w in want)
             and sum(x.endswith(": inside") for x in lines) == 6 and lines[1].startswith("sha256: ")
             and f'2 Read file_path="{WS}/materials/overview.md": inside' in lines, both)

        rc, out, both = fx.run("calls", "afx0valid")
        lines = out.splitlines()
        case("(3) calls prints the six call lines only, without the rules",
             rc == 0 and len(lines) == 6 and lines[3] == f'4 Grep path="{WS}/materials" glob="*.md"'
             and lines[5] == '6 TodoWrite keys=["todos"]' and "inside" not in out, both)

        void_case(fx, "(4) a Read outside the workspace voids, and its path cannot forge a line", "afx2read",
                  GOOD[:2] + [("Read", {"file_path": "/fx/scratch/bl/criteria.md\nAUDIT VALID"})],
                  'OUTSIDE (file_path resolves to "/fx/scratch/bl/criteria.md\\nAUDIT VALID")')
        void_case(fx, "(4b) a Read whose .. leaves the workspace voids", "afx2dots",
                  GOOD[:2] + [("Read", {"file_path": WS + "/materials/../../rfx02/materials/overview.md"})],
                  'OUTSIDE (file_path resolves to "/fx/scratch/bl/rfx02/materials/overview.md")')
        void_case(fx, "(5) a Grep without path voids", "afx3grep", GOOD[:2] + [("Grep", {"pattern": "run"})],
                  "OUTSIDE (no path (searches the session's working directory))")
        void_case(fx, "(6) a Glob pattern with .. voids", "afx4glob",
                  [("Glob", {"path": WS + "/materials", "pattern": "../../**/*.md"})] + GOOD[1:2],
                  "OUTSIDE (pattern contains ..)")
        void_case(fx, "(7) a disallowed tool (Bash) voids, in the transcript and in the guard log", "afx5bash",
                  GOOD[:2] + [("Bash", {"command": f"cat {MARKER}", "description": "x"})],
                  '3 Bash keys=["command", "description"]: OUTSIDE (tool Bash is not allowed)')
        case("(7b) the Bash case names the guard record", "tool Bash is not allowed" in OUTPUTS[-1].split(
            "guard records breaking the rules")[-1], OUTPUTS[-1])
        fx.agent("afx6count", GOOD, guard=[("PreToolUse", "Read", WS + "/materials/overview.md")] * 4)
        rc, out, both = fx.run("audit", "afx6count", WS)
        lines = out.splitlines()
        case("(8) a guard log whose count differs from the transcript is recorded, not void by itself (section 7)",
             rc == 0 and lines and lines[-1] == "AUDIT VALID"
             and "guard-log PreToolUse records for afx6count: 4 (DIFFER)" in lines
             and f"note: the counts differ by {abs(4 - len(GOOD))}; every call in both sources is judged below" in lines, both)
        void_case(fx, "(9) a guard record whose logged path is outside voids though the transcript is inside",
                  "afx7logged", GOOD[1:2], 'logged path resolves to "/home/fx/other.md"',
                  guard=[("PreToolUse", "Read", "/home/fx/other.md")])

        rc, out, both = fx.run("audit", "afx9unknown", WS)
        rc2, _, both2 = fx.run("last", "afx9unknown")
        rc3, _, both3 = fx.run("audit", "afx0valid")
        rc4, _, both4 = fx.run("audit", "afx0valid", "relative/ws")
        case("(10) an unknown agent ID, a missing workspace and a relative workspace exit 2",
             rc == 2 and rc2 == 2 and rc3 == 2 and rc4 == 2 and "0 transcripts of agent afx9unknown" in both,
             both + both2 + both3 + both4)

        case("(11) no output contains the planted content of a tool result, prompt, thinking block or argument",
             len(OUTPUTS) > 10 and not any(MARKER in o for o in OUTPUTS), "\n".join(o for o in OUTPUTS if MARKER in o))
    ok = bool(RESULTS) and all(RESULTS)
    print(f"SUBAGENT_AUDIT_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
