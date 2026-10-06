#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixtures and inputs in this file are made up for
# the test and hold no personal or business data. Not made up, because the formats under test name them: the tool
# names and the field names of Claude Code's subagent transcripts and meta files and of the guard's decision log.
"""test_subagent_audit.py: planted cases for tools/subagent_audit.py (W-C00-15; CHK-C00-041 C4).

The fixture is a fake home directory with transcripts and meta files under .claude/projects/x/y/subagents/ (an
Agent-tool subagent's) and under its workflows/<run-id>/ (a workflow agent's, whose meta has no toolUseId), and a
fake guard-log directory, both in a temporary directory that the tool is pointed at through DEVOS_AUDIT_HOME and
DEVOS_GUARD_LOG_DIR. Every tool result, prompt, thinking block and non-path argument holds a marker string that no
output may contain. The disciplines cases (D-016) plant tasks with and without its marker and reports with and
without a complete block. Prints one line per case and SUBAGENT_AUDIT_TEST PASS only if every case behaves as written.
"""
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

sys.dont_write_bytecode = True
TOOL = Path(__file__).resolve().parent / "subagent_audit.py"
MARKER = "PLANTED-FIXTURE-CONTENT-q7Zx"
WS = "/fx/scratch/bl/rfx01"
FINAL = "---\nid: CHK-FX-001\nverdict: PASS\n---\n\nFindings: none (fixture).\nTürkçe satır: ğüşiöç"
WF_META = {"agentType": "checker", "description": "fixture", "workflowPhase": "Review", "spawnDepth": 1,
           "requestShape": "foreground", "requestNonInteractive": True}   # a workflow agent's meta: no toolUseId
RESULTS, OUTPUTS, DISC_OUT = [], [], []


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

    def agent(self, agent, calls, guard=None, final=FINAL, after=(), extra=(), log="session_fx1.jsonl", folder="",
              meta=None, prompt=f"Prompt text {MARKER}", result=f"file content {MARKER}"):
        """calls, then the final message, then after: (tool, input) pairs; guard: (event, tool, logged path)
        records, by default one PreToolUse per call; extra: further records. folder: where under subagents/ the
        transcript and meta go (a workflow agent's: workflows/<run-id>); meta: the meta file's object, by default an
        Agent-tool subagent's with its toolUseId. prompt: the first user event's content (a string or a list of
        blocks); result: every tool result's content."""
        where = self.sub / folder
        where.mkdir(parents=True, exist_ok=True)
        ev = [{"type": "user", "message": {"role": "user", "content": prompt}},
              self.text("An earlier text, not the final message.")]
        for i, (tool, inp) in enumerate(list(calls) + list(after)):
            if i == len(calls):
                ev += [self.text(f"thinking {MARKER}", "thinking"), self.text(final)]
            tid = f"toolu_fx_{agent}_{i:02d}"
            ev.append({"type": "assistant", "cwd": "/fx/session-cwd", "message": {"role": "assistant", "content": [
                {"type": "tool_use", "id": tid, "name": tool, "input": inp}]}})
            ev.append({"type": "user", "message": {"role": "user", "content": [
                {"type": "tool_result", "tool_use_id": tid, "content": result}]}})
        if not after:
            ev += [self.text(f"thinking {MARKER}", "thinking"), self.text(final)]
        (where / f"agent-{agent}.jsonl").write_text("".join(json.dumps(e) + "\n" for e in ev), encoding="utf-8")
        (where / f"agent-{agent}.meta.json").write_text(json.dumps(meta if meta is not None else
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


TASK = f"Task {MARKER}.\n\n**Thinking disciplines (mandatory; D-016).** Evaluate D1 to D9 {MARKER}."
ANSWERS = [f"D1: yes: {MARKER}.", "D2: no", f"D3: uncertain: {MARKER}", "D4: no.", f"- D5: yes: {MARKER}", "D6: no;",
           "* D7: no", f"D8: yes: {MARKER}", "D9: no"]
CARRIES, LACKS = "task: carries the D-016 questions", "task: does NOT carry the D-016 questions"
FIXED = r"task: (carries|does NOT carry) the D-016 questions|report: nine answers|report: missing or incomplete " \
        r"\(.*\)|DISCIPLINES (OK|MISSING)"


def report(answers):
    return "---\nid: CHK-FX-002\nverdict: PASS\n---\n\n## Disciplines (D1–D9)\n\n" + "\n".join(answers) + \
        f"\n\n## Findings\n\nNone ({MARKER})."


def disc_case(fx, label, agent, rc_want, lines_want, **kw):
    """One disciplines case: the agent gets one call, the task TASK and the report report(ANSWERS) unless kw says
    otherwise; its output must be exactly lines_want."""
    fx.agent(agent, GOOD[:1], **{"prompt": TASK, "final": report(ANSWERS), **kw})
    rc, out, both = fx.run("disciplines", agent)
    DISC_OUT.append(both)
    case(label, rc == rc_want and out.splitlines() == lines_want, both)


def void_case(fx, label, agent, calls, expect, guard=None, log="session_fx2.jsonl", folder="", meta=None):
    fx.agent(agent, calls, guard=guard, log=log, folder=folder, meta=meta)
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
        want = [f"transcript: {fx.sub / 'agent-afx0valid.jsonl'}", "kind: Agent-tool subagent",
                "toolUseId: toolu_fx_launch_afx0valid",
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

        # A workflow agent: transcript and meta under subagents/workflows/<run-id>/, a meta without toolUseId.
        fx.agent("afxawf", GOOD, folder="workflows/wf_fx01", meta=WF_META)
        rc, out, both = fx.run("last", "afxawf")
        rc2, out2, both2 = fx.run("calls", "afxawf")
        rc3, out3, both3 = fx.run("audit", "afxawf", WS)
        lines = out3.splitlines()
        want = [f"transcript: {fx.sub / 'workflows' / 'wf_fx01' / 'agent-afxawf.jsonl'}",
                "kind: workflow agent (run wf_fx01)", "tool calls in the transcript: 5",
                "guard-log PreToolUse records for afxawf: 5 (agree)", "guard records breaking the rules: none"]
        case("(12) a workflow agent's transcript is found by last, calls and audit; audit names its kind and run, "
             "says that its meta names no starting call instead of failing, and is valid",
             rc == 0 and out == FINAL + "\n" and rc2 == 0 and [x + ": inside" for x in out2.splitlines()] == lines[5:10]
             and rc3 == 0 and lines[-1] == "AUDIT VALID" and all(w in lines for w in want)
             and lines[1].startswith("sha256: ") and lines[3].startswith("toolUseId: none (")
             and sum(x.endswith(": inside") for x in lines) == 5, both + both2 + both3)
        void_case(fx, "(13) a workflow agent's Read outside the workspace voids, as any agent's", "afxbwf",
                  GOOD[:2] + [("Read", {"file_path": "/fx/scratch/bl/criteria.md"})],
                  'OUTSIDE (file_path resolves to "/fx/scratch/bl/criteria.md")', folder="workflows/wf_fx02",
                  meta=WF_META)

        fx.agent("afxctwo", GOOD[:1], folder="workflows/wf_fx01", meta=WF_META)   # in two workflow runs
        fx.agent("afxctwo", GOOD[:1], folder="workflows/wf_fx03", meta=WF_META)
        fx.agent("afxdtwo", GOOD[:1])                                              # in each layout once
        fx.agent("afxdtwo", GOOD[:1], folder="workflows/wf_fx01", meta=WF_META)
        rs = [fx.run(cmd, a, *([WS] if cmd == "audit" else [])) for a in ("afxctwo", "afxdtwo")
              for cmd in ("last", "calls", "audit")]
        case("(14) two transcripts of one agent (in two workflow runs, or one in each layout) exit 2 for last, calls "
             "and audit", all(r[0] == 2 and not r[1] and "2 transcripts of agent" in r[2] for r in rs),
             "".join(r[2] for r in rs))

        fx.agent("afxenone", GOOD[:1], folder="workflows", meta=WF_META)            # no run folder
        fx.agent("afxenone", GOOD[:1], folder="workflows/wf_fx01/deeper", meta=WF_META)   # one level too deep
        fx.agent("afxenone", GOOD[:1], folder="other/wf_fx01", meta=WF_META)        # not under workflows/
        rs = [fx.run(cmd, "afxenone", *([WS] if cmd == "audit" else [])) for cmd in ("last", "calls", "audit")]
        case("(15) no transcript in either layout (files directly under workflows/, one level below a run folder or "
             "outside workflows/ are not one) exit 2 for last, calls and audit",
             all(r[0] == 2 and not r[1] and "0 transcripts of agent afxenone" in r[2] for r in rs),
             "".join(r[2] for r in rs))

        fx.agent("afxfnoid", GOOD[:1], meta=WF_META)
        rc, out, both = fx.run("audit", "afxfnoid", WS)
        case("(16) an Agent-tool subagent's meta without toolUseId is still a reading error (exit 2)",
             rc == 2 and not out and "no readable toolUseId in " in both, both)

        # disciplines (D-016; N-104): the task's marker and the report's block, as fixed lines only.
        disc_case(fx, "(17) a task with the marker and a report with nine answers: DISCIPLINES OK, exit 0",
                  "afxgdisc", 0, [CARRIES, "report: nine answers", "DISCIPLINES OK"])
        disc_case(fx, "(17b) the same, the task given as a list of text blocks", "afxhdisc", 0,
                  [CARRIES, "report: nine answers", "DISCIPLINES OK"],
                  prompt=[{"type": "text", "text": f"Part one {MARKER}."}, {"type": "text", "text": TASK}])
        disc_case(fx, "(18) a task without the marker: DISCIPLINES MISSING, exit 1", "afxidisc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"], prompt=f"Prompt text {MARKER}")
        disc_case(fx, "(18b) the marker in a later tool result, not in the task, does not count", "afxjdisc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"], prompt=f"Prompt text {MARKER}",
                  result=f"file content {MARKER}\n{TASK}")
        disc_case(fx, "(19) a report without the block", "afxkdisc", 1,
                  [CARRIES, 'report: missing or incomplete (no "## Disciplines (D1–D9)" heading)',
                   "DISCIPLINES MISSING"], final=FINAL)
        disc_case(fx, "(20) a block with eight lines", "afxldisc", 1,
                  [CARRIES, "report: missing or incomplete (8 answer lines, nine needed)", "DISCIPLINES MISSING"],
                  final=report(ANSWERS[:8]))
        disc_case(fx, '(21) a "yes" without text', "afxmdisc", 1,
                  [CARRIES, 'report: missing or incomplete (D8: "yes" without text)', "DISCIPLINES MISSING"],
                  final=report(ANSWERS[:7] + ["D8: yes: .", "D9: no"]))
        disc_case(fx, "(22) answers out of order", "afxndisc", 1,
                  [CARRIES, "report: missing or incomplete (line 4 of the block is not a D4 answer)",
                   "DISCIPLINES MISSING"], final=report(ANSWERS[:3] + [ANSWERS[4], ANSWERS[3]] + ANSWERS[5:]))
        rc, out, both = fx.run("disciplines", "afx9unknown")
        case("(23) disciplines for an unknown agent ID is a reading error (exit 2)",
             rc == 2 and not out and "0 transcripts of agent afx9unknown" in both, both)
        case("(24) disciplines prints three fixed lines and no prompt or report text",
             len(DISC_OUT) == 8 and all(len(o.splitlines()) == 3 and all(re.fullmatch(FIXED, x) for x in o.splitlines())
                                        and MARKER not in o and "Thinking disciplines" not in o for o in DISC_OUT),
             "\n".join(DISC_OUT))

        case("(11) no output contains the planted content of a tool result, prompt, thinking block or argument",
             len(OUTPUTS) > 10 and not any(MARKER in o for o in OUTPUTS), "\n".join(o for o in OUTPUTS if MARKER in o))
    ok = bool(RESULTS) and all(RESULTS)
    print(f"SUBAGENT_AUDIT_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
