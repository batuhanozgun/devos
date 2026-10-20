#!/usr/bin/env python3
# Synthetic test data (plan Section 8 item 13; criterion 20): the fixtures and inputs in this file are made up for
# the test and hold no personal or business data. Not made up, because the formats under test name them: the tool
# names and the field names of Claude Code's subagent transcripts and meta files and of the guard's decision log,
# and the discipline block of plan/Installation_Working_Order.md section 9 (BLOCK), which every task must carry.
"""test_subagent_audit.py: planted cases for tools/subagent_audit.py (W-C00-15; CHK-C00-041 C4).

The fixture is a fake home directory with transcripts and meta files under .claude/projects/x/y/subagents/ (an
Agent-tool subagent's) and under its workflows/<run-id>/ (a workflow agent's, whose meta has no toolUseId), and a
fake guard-log directory, both in a temporary directory that the tool is pointed at through DEVOS_AUDIT_HOME and
DEVOS_GUARD_LOG_DIR. Every tool result, prompt, thinking block and non-path argument holds a marker string that no
output may contain. The disciplines cases (D-016) plant tasks with and without the whole discipline block and
reports with and without a complete block; the tool reads the block from this checkout's working order, which must
hold BLOCK as written here. N-110's cases (b) to (e) (25 to 28) kill CHK-C01-001's mutants S14, S12, S1 and S3;
cases 29 to 33 judge the whole-block task check (CHK-C01-001 finding 6), on a copy of the tool beside a fixture
working order where a case needs another file. Case 47 (N-127; CHK-C01-009 finding 3) kills mutant Y7 (only the
first quoted line of the block is read): beside that fixture working order, whose block is quoted over three lines,
a task carrying only the first quoted line does not carry the block. Case 48 pins D-031: a report answer
"Dn: no: <text>" fails, since the form of a "no" stays "Dn: no" with nothing after it (W-C02-15). Cases 38 to 46
judge N-149 (PC-24): every agent gets its end status
by default (a completion notification in the fake session transcript .claude/projects/x/y.jsonl, or a result in its
workflow run's journal.jsonl), and the cases plant transcripts without one, statuses that are not an end, and reports
handed back through a SubagentHandback or StructuredOutput call. The cases labelled "(W-...)" judge W-C02-24.1 (its
acceptance block, Parts A and B; see w241_cases): each carries its group, [new] (an outcome the base's tool does not
give, red there) or [keep] (an outcome the base's tool already gives, green there), and the cases that compare with the
base's tool read it with git show from this checkout's history (BASE), never from the working tree. Prints one line per
case and SUBAGENT_AUDIT_TEST PASS only if every case behaves as written.
"""
import ast
import hashlib
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path
from shutil import copy as copy_file
from textwrap import fill, indent

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
        self.session = self.sub.parent.with_suffix(".jsonl")   # the coordinator's transcript, beside its folder
        self.sub.mkdir(parents=True)
        self.logs.mkdir()
        self.n = 0

    def put(self, path, *events):
        with open(path, "a", encoding="utf-8") as f:
            f.write("".join(json.dumps(e) + "\n" for e in events))

    def end(self, agent, folder="", status="completed", form="user", head=None):
        """The platform's end status for agent: a workflow agent's result in its run's journal (status: its result
        or None), else a completion notification in the session transcript, as a user event or a queued_command
        attachment (form), with head (default: the agent's task-id and status) before its summary and result."""
        if folder.startswith("workflows"):
            return self.put(self.sub / folder / "journal.jsonl", {"type": "result", "agentId": agent,
                                                                  "result": FINAL if status == "completed" else status})
        head = f"<task-id>{agent}</task-id>\n<status>{status}</status>" if head is None else head
        note = f"<task-notification>\n{head}\n<summary>Agent done {MARKER}</summary>\n<result>{MARKER}</result>\n" \
               "</task-notification>"
        origin = {"kind": "task-notification", "producer": "session-task"}
        self.put(self.session, {"type": "user", "origin": origin, "message": {"role": "user", "content": note}}
                 if form == "user" else {"type": "attachment", "attachment": {
                     "type": "queued_command", "commandMode": "task-notification", "origin": origin, "prompt": note}})

    def raw(self, agent, events, end=True):
        """An Agent-tool subagent with the given transcript events, its meta and, if end, its end status."""
        self.put(self.sub / f"agent-{agent}.jsonl", *events)
        (self.sub / f"agent-{agent}.meta.json").write_text(json.dumps(
            {"agentType": "general-purpose", "description": "fixture", "toolUseId": f"toolu_fx_launch_{agent}"}))
        if end:
            self.end(agent)

    def agent(self, agent, calls, guard=None, final=FINAL, after=(), extra=(), log="session_fx1.jsonl", folder="",
              meta=None, prompt=f"Prompt text {MARKER}", result=f"file content {MARKER}",
              earlier="An earlier text, not the final message.", later=None, opening=(), end=True):
        """calls, then the final message, then after: (tool, input) pairs; guard: (event, tool, logged path)
        records, by default one PreToolUse per call; extra: further records. folder: where under subagents/ the
        transcript and meta go (a workflow agent's: workflows/<run-id>); meta: the meta file's object, by default an
        Agent-tool subagent's with its toolUseId. prompt: the content of the user event that holds the task, the
        first user event unless opening is given (a string or a list of blocks); result: every tool result's content; earlier: the assistant text after the prompt; later: if
        given, a user text message after that one (a string content, not a tool result); opening: user text
        messages put before the prompt, with no assistant event between (a workflow harness's relay, W-C01-43);
        end: whether its end status is written (Fixture.end)."""
        where = self.sub / folder
        where.mkdir(parents=True, exist_ok=True)
        ev = [{"type": "user", "message": {"role": "user", "content": o}} for o in opening] + \
            [{"type": "user", "message": {"role": "user", "content": prompt}}, self.text(earlier)]
        if later is not None:
            ev.append({"type": "user", "message": {"role": "user", "content": later}})
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
        if end:
            self.end(agent, folder)
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

    def run(self, *args, tool=None):
        r = subprocess.run([sys.executable, str(tool or TOOL), *args], capture_output=True,
                           env={**os.environ, "DEVOS_AUDIT_HOME": str(self.home), "DEVOS_GUARD_LOG_DIR": str(self.logs)})
        out = r.stdout.decode("utf-8") + r.stderr.decode("utf-8")
        OUTPUTS.append(out)
        return r.returncode, r.stdout.decode("utf-8"), out


GOOD = [("Glob", {"path": WS + "/materials", "pattern": "**/*.md"}),
        ("Read", {"file_path": WS + "/materials/overview.md"}),
        ("Read", {"file_path": WS + "/materials/sub/../ops.md", "offset": 1, "limit": 50}),
        ("Grep", {"path": WS + "/materials", "glob": "*.md", "pattern": MARKER}),
        ("ToolSearch", {"query": MARKER})]


BLOCK = ('**Thinking disciplines (mandatory; D-016).** Before your main work, read '
         '/home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md section 2, item "3. Thinking disciplines — trigger '
         'questions" (the nine trigger questions D1 to D9), and evaluate all nine for this task. Answer each "no", '
         '"yes" or "uncertain"; a question that does not apply is "no". For "yes" or "uncertain", read that '
         "discipline's full text in section 3 of the same file and apply it to your work. Evaluate again after any "
         'material change of plan or evidence. Your final message must contain a block headed "## Disciplines '
         '(D1–D9)" with nine lines, one per question: "Dn: no" or "Dn: yes|uncertain: <what you did because of it, '
         'in one sentence>". Put it right after the front matter or header your output form requires (for a '
         'verdict, after the closing "---" and before "## Findings"). A final message without this block is not '
         'accepted.')   # plan/Installation_Working_Order.md section 9, "Discipline block", without its "> "
TASK = f"Task {MARKER}.\n\n{BLOCK}\n\nMore of the task {MARKER}."
CHANGED = [("first", "Before your main work, read", "When you have time, read"),   # one sentence of BLOCK changed
           ("middle", "Evaluate again after any material change of plan or evidence.", "Evaluate again if you wish."),
           ("last", "A final message without this block is not accepted.", "A final message is accepted.")]
FX_BLOCK = "**Thinking disciplines (mandatory; D-016).** Fixture block, wrapped over three quoted lines."
FX_ORDER = "# Fixture working order\n\n## 8. Before\n\n**Discipline block** (in section 8, not 9).\n\n> Not it.\n\n" \
           "## 9. Record formats\n\n```\n## Findings (a template line, not a heading)\n```\n\n{}\n\n" \
           "## 10. After\n\n> A later quotation, not the block.\n"
FX_NINE = "**Discipline block** (fixture). Every task carries this text,\nverbatim:\n\n" \
          "> **Thinking disciplines (mandatory; D-016).** Fixture block,\n>   wrapped over\n> three quoted lines."
ANSWERS = [f"D1: yes: {MARKER}.", "D2: no", f"D3: uncertain: {MARKER}", "D4: no.", f"- D5: yes: {MARKER}", "D6: no;",
           "* D7: no", f"D8: yes: {MARKER}", "D9: no"]
CARRIES, LACKS = "task: carries the D-016 questions", "task: does NOT carry the D-016 questions"
FIXED = r"task: (carries|does NOT carry) the D-016 questions|report: nine answers|report: missing or incomplete " \
        r"\(.*\)|DISCIPLINES (OK|MISSING)"


def report(answers):
    return "---\nid: CHK-FX-002\nverdict: PASS\n---\n\n## Disciplines (D1–D9)\n\n" + "\n".join(answers) + \
        f"\n\n## Findings\n\nNone ({MARKER})."


PLAIN = report([a.replace(MARKER, "fixture") for a in ANSWERS]).replace(MARKER, "fixture")   # printable by last


def user(content, **kw):
    return {"type": "user", "message": {"role": "user", "content": content}, **kw}


def say(text):
    return Fixture.text(text)


def call(tid, name, inp):
    return {"type": "assistant", "message": {"role": "assistant", "content": [
        {"type": "tool_use", "id": tid, "name": name, "input": inp}]}}


def result(tid, tur=None):
    """A tool result for tid; tur: its event's toolUseResult."""
    return user([{"type": "tool_result", "tool_use_id": tid, "content": f"result {MARKER}"}],
                **({} if tur is None else {"toolUseResult": tur}))


def unfinished(fx, label, agent, why, cmds=("last", "disciplines", "audit")):
    """Each command exits 3 with nothing on stdout and NOT FINISHED, with why, on stderr."""
    rs = [fx.run(c, agent, *([WS] if c == "audit" else [])) for c in cmds]
    case(label, all(rc == 3 and not out and both.startswith("subagent_audit: NOT FINISHED: ") and why in both
                    for rc, out, both in rs), "".join(r[2] for r in rs))


def disc_case(fx, label, agent, rc_want, lines_want, tool=None, **kw):
    """One disciplines case: the agent gets one call, the task TASK and the report report(ANSWERS) unless kw says
    otherwise; the output of tool (by default this checkout's) must be exactly lines_want."""
    fx.agent(agent, GOOD[:1], **{"prompt": TASK, "final": report(ANSWERS), **kw})
    rc, out, both = fx.run("disciplines", agent, tool=tool)
    DISC_OUT.append(both)
    case(label, rc == rc_want and out.splitlines() == lines_want, both)


def void_case(fx, label, agent, calls, expect, guard=None, log="session_fx2.jsonl", folder="", meta=None):
    fx.agent(agent, calls, guard=guard, log=log, folder=folder, meta=meta)
    rc, out, both = fx.run("audit", agent, WS)
    lines = out.splitlines()
    case(label, rc == 1 and lines and lines[-1].startswith("AUDIT VOID: ") and expect in out
         and "AUDIT VALID" not in lines, both)


def launch_cases(fx):
    """Cases (L1) to (L7): W-C02-24 M1b, B8 of its acceptance block, written by M1b's test designer before the build.
    Form C0 (Appendix C):
    - Claim: python3 -I tools/subagent_audit.py launch <agent id> (read-only) prints the UTF-8 byte length and SHA-256
      of the run's first task message, read from its transcript, never its text, and the guard's T5 allow record with
      the same SHA-256 and rule T5; otherwise "could not confirm" and a non-zero exit.
    - Failure class: a reader-form launch (T5R) or a denied one taken as a writer launch; a record of another launch
      taken for this one; a hash of characters, not bytes; the prompt printed; a missing transcript read as a pass.
    - Interface stated here (B8 leaves it open): the run is linked to its guard record by the meta's toolUseId, equal
      to the record's tool_use_id (A10's linkage; the docstring's observation that an Agent-tool subagent's meta names
      its starting call); the record's detail holds prompt_sha256=<64 hex> (item A3's log field). Success prints
      "bytes=<n>", "sha256=<hex>", the record's "#<n>" and "LAUNCH CONFIRMED", and exits 0. Each failure prints "could
      not confirm" with its reason ID in brackets and exits non-zero: [LAUNCH-MISMATCH] (the linked T5 record's hash
      differs), [LAUNCH-T5R] (the linked record is a T5R allow), [LAUNCH-NORECORD] (no linked T5 allow record: none at
      all, only a T5.n denial, or a record of the same hash with another tool_use_id), [LAUNCH-NOTRANSCRIPT].
    - Negative control: L2 to L7, each with its own reason ID. Positive control: L1.
    - Break: hashing str length instead of bytes (L1, the prompt holds non-ASCII); rule matched by prefix (L5, L3);
      linkage dropped (L2 gives NORECORD, L6 confirms); the prompt printed (case 11).
    - Not covered: a first task message given as a list of content blocks (observation (12), A10, settles its form);
      calls' path mapping, which B8 assigns to the checker's procedure, not to a change of calls."""
    import hashlib
    prompt = f"Writer or reader: writer\nItem: plan/work/W-C00-01.md\nTask {MARKER} ğüşiöç\n"
    data = prompt.encode("utf-8")
    sha, other = hashlib.sha256(data).hexdigest(), hashlib.sha256(b"another prompt").hexdigest()
    log = fx.logs / "session_fx_launch.jsonl"

    def launched(agent, records):
        """An Agent-tool subagent whose first task message is prompt, and guard records (rule, decision, sha,
        linked) for its launch; returns the record numbers."""
        fx.raw(agent, [user(prompt), say("Working."), say(PLAIN)])
        ns = []
        with open(log, "a", encoding="utf-8") as f:
            for rule, decision, h, linked in records:
                fx.n += 1
                ns.append(fx.n)
                f.write(json.dumps({"n": fx.n, "time": "2026-01-01T00:00:00Z", "event": "PreToolUse",
                                    "tool_use_id": f"toolu_fx_launch_{agent}" if linked else "toolu_fx_other",
                                    "agent_id": None, "cwd": "/fx/session-cwd", "tool": "Agent", "decision": decision,
                                    "rule": rule, "summary": "Agent", "detail": "input_keys=description,prompt,"
                                    f"subagent_type prompt_bytes={len(data)} prompt_sha256={h}"}) + "\n")
        return ns

    n1 = launched("a1f0000000000000a", [("T5", "allow", sha, True)])
    rc, out, both = fx.run("launch", "a1f0000000000000a")
    case("(L1) launch: a writer-form run whose linked T5 allow record has the same SHA-256: bytes, sha256, the "
         "record's number, LAUNCH CONFIRMED, exit 0", rc == 0 and f"bytes={len(data)}" in out and f"sha256={sha}" in out
         and f"#{n1[0]}" in out and "LAUNCH CONFIRMED" in out and len(data) != len(prompt), both)
    for label, agent, records, token in (
            ("(L2) the linked T5 record's SHA-256 differs", "a1f0000000000000b", [("T5", "allow", other, True)],
             "LAUNCH-MISMATCH"),
            ("(L3) the linked record is a T5R allow (reader form)", "a1f0000000000000c", [("T5R", "allow", sha, True)],
             "LAUNCH-T5R"),
            ("(L4) no guard record for the launch", "a1f0000000000000d", [], "LAUNCH-NORECORD"),
            ("(L5) only a T5.13 denial of the same hash", "a1f0000000000000e", [("T5.13", "deny", sha, True)],
             "LAUNCH-NORECORD"),
            ("(L6) a T5 allow of the same hash for another tool_use_id", "a1f0000000000000f",
             [("T5", "allow", sha, False)], "LAUNCH-NORECORD")):
        launched(agent, records)
        rc, out, both = fx.run("launch", agent)
        case(f"{label}: could not confirm, [{token}], non-zero exit", rc != 0 and "could not confirm" in both and
             f"[{token}]" in both and "LAUNCH CONFIRMED" not in both, both)
    rc, out, both = fx.run("launch", "a1f00000000000099")
    case("(L7) no transcript for the agent: could not confirm, [LAUNCH-NOTRANSCRIPT], non-zero exit", rc != 0 and
         "could not confirm" in both and "[LAUNCH-NOTRANSCRIPT]" in both, both)


# W-C02-24.1 (plan/work/W-C02-24.1.md, the acceptance block merged at cec4e20): the base and the tokens its test commit
# fixes. BASE is the pull request's base on main (W-C02-25's merge, #437); the base's tool is read from it by git show
# and checked against its SHA-256, so a missing or wrong base fails the cases that compare with it ("could not check"),
# never passes them.
BASE = "13d310a3915c7b60605735bf76dcdbd2a32ba27d"
BASE_TOOL_SHA256 = "2cdcf4506c1df33c0773d57614b3a4c4b816f26ce7523899749b395b9fc6be2b"
ROOT = Path(__file__).resolve().parent.parent
GUARD = ROOT / ".claude" / "hooks" / "tool_allowlist.py"
DISPLAY = {"Write": "file_path", "Edit": "file_path", "NotebookEdit": "notebook_path"}   # A1; A6 compares the guard's
PATHLESS = "{n} {tool} {key}=none (no string path)"            # [test commit] A4's defined line
TD_OK = "TEST-DESIGNER CONFIRMED: {} (test and oracle paths only)"   # [test commit] the test designer's last line
ITEM_LINE = "item line: {}"                                    # [test commit] each Item: line, JSON-quoted (B6)
REFUSAL = re.compile(r"LAUNCH: could not confirm \[(LAUNCH-[A-Z0-9-]+)\]: \S.*")   # today's form (B4, pinned)
# [test commit] the refusal tokens of the T5R branch and of --item, besides LAUNCH-MISMATCH, LAUNCH-T5R,
# LAUNCH-NORECORD and LAUNCH-NOTRANSCRIPT, which keep their meaning:
NOTYPE, TDMISMATCH, NOITEM, READER, FORM, ITEM = ("LAUNCH-NOTYPE", "LAUNCH-T5R-MISMATCH", "LAUNCH-NOITEM",
                                                 "LAUNCH-READER", "LAUNCH-FORM", "LAUNCH-ITEM")
P241, P24, P25 = "plan/work/W-C02-24.1.md", "plan/work/W-C02-24.md", "plan/work/W-C02-25.md"
ABSENT = object()
W_GROUPS = {}                                                  # case label -> "new" or "keep" (Part D, D1)
W_NEW, W_KEEP = 28, 8                                          # the groups' sizes as written (the denominator)


def gcase(group, label, ok, detail=""):
    """A W-C02-24.1 case in exactly one D1 group: new (red on the base's tool) or keep (green there)."""
    assert group in ("new", "keep") and label not in W_GROUPS, label
    W_GROUPS[label] = group
    case(f"[{group}] {label}", ok, detail)


def base_tool(tmp):
    """(path, None): the base's tool, beside the base's guard (audit loads session_key from it); else (None, why)."""
    d = Path(tmp) / "base"
    for rel in ("tools/subagent_audit.py", ".claude/hooks/tool_allowlist.py"):
        r = subprocess.run(["git", "-C", str(ROOT), "show", f"{BASE}:{rel}"], capture_output=True)
        if r.returncode != 0:
            return None, f"could not check: git show {BASE}:{rel} failed: {r.stderr.decode(errors='replace')}"
        (d / rel).parent.mkdir(parents=True, exist_ok=True)
        (d / rel).write_bytes(r.stdout)
    tool = d / "tools" / "subagent_audit.py"
    sha = hashlib.sha256(tool.read_bytes()).hexdigest()
    return (tool, None) if sha == BASE_TOOL_SHA256 else (None, f"could not check: the base's tool is {sha}")


def lines_of(out):
    return out[:-1].split("\n") if out.endswith("\n") else (out.split("\n") if out else [])


def refused(r, token):
    """rc 1; the last line is today's refusal form with token; no line confirms either way (B4, B7)."""
    rc, out, _ = r
    ls = lines_of(out)
    m = REFUSAL.fullmatch(ls[-1]) if ls else None
    return rc == 1 and m is not None and m.group(1) == token and "LAUNCH CONFIRMED" not in ls[-1] and \
        "TEST-DESIGNER CONFIRMED" not in ls[-1] and not any(x == "LAUNCH CONFIRMED" or
                                                            x.startswith("TEST-DESIGNER CONFIRMED") for x in ls)


def td_confirmed(r, item):
    rc, out, _ = r
    ls = lines_of(out)
    return rc == 0 and bool(ls) and ls[-1] == TD_OK.format(item) and "LAUNCH CONFIRMED" not in out.splitlines() and \
        sum(x.startswith("TEST-DESIGNER CONFIRMED") for x in out.splitlines()) == 1


def p_confirmed(r):
    rc, out, _ = r
    ls = lines_of(out)
    return rc == 0 and bool(ls) and ls[-1] == "LAUNCH CONFIRMED" and ls.count("LAUNCH CONFIRMED") == 1 and \
        out.splitlines().count("LAUNCH CONFIRMED") == 1 and "TEST-DESIGNER CONFIRMED" not in out


def usage(r):
    rc, out, both = r
    return rc == 2 and out == "" and both.startswith("usage: ")


def assigned(path, names):
    """{name: ast node of its module-level value} for each of names assigned once at the top of the file at path."""
    tree = ast.parse(Path(path).read_text(encoding="utf-8"))
    found = {}
    for node in tree.body:
        if isinstance(node, ast.Assign) and len(node.targets) == 1 and isinstance(node.targets[0], ast.Name) \
                and node.targets[0].id in names:
            found.setdefault(node.targets[0].id, []).append(node.value)
    return {k: v[0] for k, v in found.items() if len(v) == 1}


def task_text(items=(f"Item: {P241}",), forms=("Writer or reader: writer",)):
    """A first task message: its Item: lines, its form lines, and a body holding the marker (never printed)."""
    return "\n".join([*items, *forms, f"**Purpose:** fixture task {MARKER} ğüşiöç", "", f"More {MARKER}."])


def w_launched(fx, agent, prompt, mtype=ABSENT, records=(("T5R", True, "test-designer"),)):
    """An Agent-tool subagent whose first task message is prompt, its meta's agentType mtype (ABSENT: no key), and
    linked guard allow records (rule, same SHA-256 or another, the role type the detail names), in the guard's
    detail form (tool_allowlist.py t5: "...; prompt_bytes=<n>; prompt_sha256=<hex>")."""
    fx.put(fx.sub / f"agent-{agent}.jsonl", user(prompt), say("Working."), say(PLAIN))
    meta = {"description": "fixture", "toolUseId": f"toolu_fx_launch_{agent}"}
    if mtype is not ABSENT:
        meta["agentType"] = mtype
    (fx.sub / f"agent-{agent}.meta.json").write_text(json.dumps(meta))
    fx.end(agent)
    data = prompt.encode("utf-8")
    with open(fx.logs / "session_fx_w241.jsonl", "a", encoding="utf-8") as f:
        for rule, same, dtype in records:
            fx.n += 1
            h = hashlib.sha256(data if same else b"another prompt").hexdigest()
            f.write(json.dumps({"n": fx.n, "time": "2026-01-01T00:00:00Z", "event": "PreToolUse",
                                "tool_use_id": f"toolu_fx_launch_{agent}", "agent_id": None, "cwd": "/fx/session-cwd",
                                "tool": "Agent", "decision": "allow", "rule": rule, "summary": "Agent",
                                "detail": f"an in-process subagent of the role type '{dtype}' (T2, T4); fixture "
                                          f"{rule}; input_keys=description,prompt,subagent_type; hook_keys=cwd; "
                                          f"prompt_bytes={len(data)}; prompt_sha256={h}"}) + "\n")


def w241_cases(fx, tmp):
    """W-C02-24.1's cases (its acceptance block, merged at cec4e20), written before the build (approach, Order (D3)).
    Form C0 (Appendix C):
    - Claims: Part A (C1): calls and audit print each Write, Edit and NotebookEdit call as <n> <Tool> <key>=<JSON
      string> (the guard's FILE_WRITE_TOOLS), never a content key, on one line each, a defined line when no string path
      exists, every other line byte for byte as the base's. Part B (C2): launch <id> [--item W-C<dd>-<dd>[.<n>]] reads
      the type from meta.json's agentType only, and only where a linked T5R allow record decides; a test designer with
      the same SHA-256, --item, exactly one Item: line naming plan/work/<id>.md and exactly one form line reading writer
      ends with TD_OK; a producer's output keeps the base's lines, order, last line and exit code.
    - Failure class rule: a write shown without its path, or with content, or forging a line; a type, item or form read
      from a place or in a way T5 does not use (a record's prose, a prefix, an indented line, a reader-form run); a
      confirmation of one kind readable as the other; a producer's existing outcome changed.
    - Examples: at least two per class: Write, Edit and NotebookEdit paths (one non-ASCII); newline-forged LAUNCH
      CONFIRMED and call lines; pathless inputs of four shapes; type absent, null, number and empty; prefixes in both
      directions; reader, none, two and an unknown word for the form; a carriage return for a test designer and a
      producer.
    - Interface fixed here (the condition's [test commit] points): PATHLESS (A4's line), TD_OK, ITEM_LINE, the tokens
      NOTYPE to ITEM, rc 1 for every refusal and rc 2 with nothing on stdout and stderr starting "usage: " for a
      malformed --item; the grammar is exactly launch <id> or launch <id> --item <id>, the item ID matching
      W-C\\d\\d-\\d\\d(\\.\\d+)? whole; the tool keeps module-level T5_ITEM, T5_PATH and T5_FORM, each assigned
      once as the guard assigns it (B6's comparison reads both files with ast, never imports the guard). On the T5R
      branch the type is read first, so a run that also lacks --item ends NOTYPE (the one case here that fails two
      conditions, (W-B4 notype-noitem)).
    - Negative controls: every refusal case; positive controls: (W-B1 parse), (W-B4 confirm), (W-B4 bold writer),
      (W-B4 two items), (W-B6 bold item), (W-B3 meta td).
    - Breaks (D3's own breaks; each turns its named case red): a display tool removed (W-A1 <tool>, W-A6); every
      input key printed (W-A2, (11)); JSON quoting dropped (W-A3); Write in ALLOWED (W-A5 void); the type read from the
      record's detail (W-B3 both); a missing type defaulted (W-B4 notype); any T5R accepted (W-B4 t5r-item); the T5R
      SHA-256 comparison dropped (W-B4 mismatch); --item ignored (W-B4 other item, W-B5 other item); prefix matching
      (W-B4 prefix); the form check dropped (W-B4 reader); a copied pattern changed (W-B6 patterns).
    - Stage and environment: C02; counted environment E1: this container's python3 3.13.16 and git 2.43.0, a fresh
      non-shallow clone (git show BASE must work).
    - Independence: written by W-C02-24.1's test designer before any product; run and judged by the test verdict's
      checker (D1) and the binding checker (D3).
    - Evidence layer: structural (the tool's output on synthetic transcripts); the real runs are D3's, not here.
    - Not covered here: the real transcripts (A7, D3: the binding checker runs the head's tool on them); the duty
      texts (Part C); a test designer under a T5 record; a line separator other than \\n and \\r (json.dumps with
      ensure_ascii=False leaves U+2028 and U+0085 as they are, as Read's line already does)."""
    base, why_base = base_tool(tmp)
    CLONE = "/fx/scratch/w241/devos"

    def both(*args):
        """(head, base) results of one command; base is (None, why) when it could not be read."""
        h = fx.run(*args)
        return h, (fx.run(*args, tool=base) if base else (None, "", why_base))

    # Part A fixtures.
    writes = [("Read", {"file_path": f"{CLONE}/plan/a.md"}),
              ("Write", {"file_path": f"{CLONE}/tools/new.py", "content": MARKER}),
              ("Edit", {"file_path": f"{CLONE}/plan/Türkçe ğ.md", "old_string": MARKER, "new_string": MARKER,
                        "replace_all": False}),
              ("NotebookEdit", {"notebook_path": f"{CLONE}/nb/a.ipynb", "new_source": MARKER, "cell_id": "c1"}),
              ("Glob", {"path": CLONE, "pattern": "*.py"}),
              ("Grep", {"path": CLONE, "glob": "*.md", "pattern": MARKER}),
              ("TodoWrite", {"todos": [{"content": MARKER}]}),
              ("Bash", {"command": f"echo {MARKER} > {CLONE}/x", "description": "x"}),
              ("MultiEdit", {"file_path": f"{CLONE}/m.py", "edits": [{"old_string": MARKER, "new_string": MARKER}]}),
              ("FxUnknownTool", {"file_path": f"{CLONE}/u.py", "notebook_path": f"{CLONE}/u.ipynb", "x": MARKER}),
              ("Write", {"file_path": "/fx/scratch/w241/devos2/tools/x.py", "content": MARKER})]   # outside the root
    fx.agent("aw241write", writes, prompt=task_text())
    hc = fx.run("calls", "aw241write")
    ha = fx.run("audit", "aw241write", CLONE)
    cl, al = lines_of(hc[1]), lines_of(ha[1])

    def jq(p):
        return json.dumps(p, ensure_ascii=False)

    for tool, idx in (("Write", (2, 11)), ("Edit", (3,)), ("NotebookEdit", (4,))):
        want = [f"{i} {tool} {DISPLAY[tool]}={jq(writes[i - 1][1][DISPLAY[tool]])}" for i in idx]
        gcase("new", f"(W-A1 {tool}) calls prints one line per tool_use (11, asserted first) and each {tool} call as "
              f"<n> {tool} {DISPLAY[tool]}=<JSON string>; audit shows the same text before its OUTSIDE suffix",
              hc[0] == 0 and len(cl) == len(writes) and all(cl[i - 1] == w for i, w in zip(idx, want))
              and all(f"{w}: OUTSIDE (tool {tool} is not allowed)" in al for w in want), ha[2] + hc[2])

    launches = [fx.run("launch", "aw241write"), fx.run("launch", "aw241write", "--item", "W-C02-24.1")]
    gcase("keep", "(W-A2) no planted marker in Write content, Edit old_string and new_string or NotebookEdit "
          "new_source reaches stdout or stderr of calls, audit or launch (with and without --item)",
          all(MARKER not in r[2] for r in [hc, ha] + launches) and len(cl) == len(writes),
          "\n".join(r[2] for r in [hc, ha] + launches if MARKER in r[2]))

    forge = [("Write", {"file_path": "/fx/a\nLAUNCH CONFIRMED", "content": MARKER}),
             ("Edit", {"file_path": '/fx/b\n2 Write file_path="x"', "old_string": MARKER, "new_string": MARKER}),
             ("Read", {"file_path": "/fx/c.md"})]
    fx.agent("aw241forge", forge)
    r = fx.run("calls", "aw241forge")
    gcase("new", "(W-A3) a file_path holding a newline and LAUNCH CONFIRMED, or a newline and a call line, prints on "
          "one line with the newline escaped; the line count equals the tool_use count",
          r[0] == 0 and lines_of(r[1]) == ['1 Write file_path="/fx/a\\nLAUNCH CONFIRMED"',
                                           '2 Edit file_path="/fx/b\\n2 Write file_path=\\"x\\""',
                                           '3 Read file_path="/fx/c.md"'] and len(r[1].splitlines()) == 3, r[2])

    pathless = [("Write", {"content": MARKER}), ("Write", {"file_path": None, "content": MARKER}),
                ("Write", {"file_path": 7, "content": MARKER}),
                ("Write", {"file_path": [f"/fx/list/{MARKER}"], "content": MARKER}),
                ("NotebookEdit", {"new_source": MARKER}), ("Edit", f"/fx/not-an-object/{MARKER}"),
                ("Read", {"file_path": f"{CLONE}/ok.md"})]
    fx.agent("aw241pathless", pathless)
    r = fx.run("calls", "aw241pathless")
    want = [PATHLESS.format(n=i, tool=t, key=DISPLAY[t]) for i, (t, _) in enumerate(pathless[:6], 1)] + \
        [f'7 Read file_path="{CLONE}/ok.md"']
    gcase("new", "(W-A4) a Write with no file_path, or a null, number or list one, a NotebookEdit with no "
          "notebook_path and an Edit whose input is not an object each print the defined line (number, tool, key, no "
          "value); the Read after them is unchanged; exit 0", r[0] == 0 and lines_of(r[1]) == want
          and "/fx/" not in "".join(lines_of(r[1])[:6]), r[2])

    fx.raw("aw241denied", [user(task_text()), call("toolu_fx_dn_1", "Write", {"file_path": f"{CLONE}/e.py",
                                                                              "content": MARKER}),
                           user([{"type": "tool_result", "tool_use_id": "toolu_fx_dn_1", "is_error": True,
                                  "content": f"error {MARKER}"}]),
                           call("toolu_fx_dn_2", "Write", {"file_path": f"{CLONE}/d.py", "content": MARKER}),
                           result("toolu_fx_dn_2"), say(PLAIN)])
    with open(fx.logs / "session_fx_w241.jsonl", "a", encoding="utf-8") as f:
        fx.n += 1
        f.write(json.dumps({"n": fx.n, "time": "2026-01-01T00:00:00Z", "event": "PreToolUse",
                            "agent_id": "aw241denied", "tool_use_id": "toolu_fx_dn_2", "cwd": "/fx/session-cwd",
                            "tool": "Write", "decision": "deny", "rule": "F1", "summary": f"{CLONE}/d.py"}) + "\n")
    r = fx.run("calls", "aw241denied")
    gcase("new", "(W-A8) a Write whose tool_result is an error, and one the guard log records as a deny, still print "
          "their paths (a tool_use is an attempt)", r[0] == 0 and lines_of(r[1]) ==
          [f'1 Write file_path="{CLONE}/e.py"', f'2 Write file_path="{CLONE}/d.py"'], r[2])

    # A5: byte for byte against the base's tool, on these fixtures and on earlier ones.
    rows, detail = [], []
    for agent, ws in (("aw241write", CLONE), ("aw241forge", WS), ("aw241pathless", CLONE), ("aw241denied", CLONE),
                      ("afx0valid", WS), ("afx5bash", WS), ("afxawf", WS)):
        (h1, b1), (h2, b2) = both("calls", agent), both("audit", agent, ws)
        if b1[0] is None:
            rows.append((False, False))
            detail.append(why_base)
            continue
        hcl, bcl, hal, bal = lines_of(h1[1]), lines_of(b1[1]), lines_of(h2[1]), lines_of(b2[1])
        n = len(bcl)
        same_shape = h1[0] == b1[0] and h2[0] == b2[0] and len(hcl) == n and len(hal) == len(bal) and n > 0 \
            and hal[:5] == bal[:5] and hal[5 + n:] == bal[5 + n:]
        names = [x.split(" ", 2)[1] for x in bcl]
        other = same_shape and all(hcl[i] == bcl[i] and hal[5 + i] == bal[5 + i]
                                   for i in range(n) if names[i] not in DISPLAY)
        disp = same_shape and all(bal[5 + i].startswith(bcl[i]) and hal[5 + i] == hcl[i] + bal[5 + i][len(bcl[i]):]
                                  for i in range(n) if names[i] in DISPLAY)
        rows.append((other, disp))
        detail.append(f"{agent}:\n" + h1[2] + b1[2] + h2[2] + b2[2])
    gcase("keep", "(W-A5 other tools) for 7 fixtures, every calls and audit line of a tool outside the display set, "
          "audit's other lines (AUDIT line included) and both exit codes are byte-identical to the base's tool's; "
          "MultiEdit and an unknown tool still print keys=[...]",
          len(rows) == 7 and all(o for o, _ in rows) and '9 MultiEdit keys=["file_path", "edits"]' in cl
          and '10 FxUnknownTool keys=["file_path", "notebook_path", "x"]' in cl, "\n".join(detail))
    gcase("keep", "(W-A5 display suffix) for the same 7 fixtures, each display-set call's audit line ends with the "
          "base's suffix (: OUTSIDE (tool <T> is not allowed)) after the head's own call text",
          len(rows) == 7 and all(d for _, d in rows), "\n".join(detail))
    gcase("keep", "(W-A5 void) audit of a run holding a Write is AUDIT VOID naming that call, exit 1",
          ha[0] == 1 and al and al[-1].startswith("AUDIT VOID: ") and "call 2 outside" in al[-1], ha[2])

    # A6 and B6: the display set and the copied patterns against this checkout's guard, read as text.
    try:
        fwt = ast.literal_eval(assigned(GUARD, {"FILE_WRITE_TOOLS"})["FILE_WRITE_TOOLS"])
        ok = isinstance(fwt, dict) and {"Write", "Edit"} <= set(fwt) and all(isinstance(v, str) for v in fwt.values())
        why = "" if ok else f"could not check: FILE_WRITE_TOOLS in {GUARD} is {fwt!r}"
    except Exception as e:      # an unreadable guard is "could not check", never a pass
        fwt, ok, why = {}, False, f"could not check: FILE_WRITE_TOOLS in {GUARD}: {type(e).__name__}: {e}"
    six = [(t, {k: f"/fx/a6/{t}.txt", "content": MARKER}) for t, k in sorted(fwt.items())] + \
          [(t, {"file_path": f"/fx/a6/{t}", "notebook_path": f"/fx/a6/{t}.ipynb"})
           for t in ("MultiEdit", "Bash", "TodoWrite", "FxUnknownTool")]
    fx.agent("aw241guardset", six)
    r = fx.run("calls", "aw241guardset")
    lone = Path(tmp) / "noguard" / "tools"          # a copy with no guard beside it: the display imports no guard
    lone.mkdir(parents=True)
    r2 = fx.run("calls", "aw241guardset", tool=Path(copy_file(TOOL, lone / "subagent_audit.py")))
    want = [f'{i} {t} {k}="/fx/a6/{t}.txt"' for i, (t, k) in enumerate(sorted(fwt.items()), 1)] + \
        [f'{len(fwt) + i} {t} keys=["file_path", "notebook_path"]'
         for i, t in enumerate(("MultiEdit", "Bash", "TodoWrite", "FxUnknownTool"), 1)]
    gcase("new", f"(W-A6) the display set equals the guard's FILE_WRITE_TOOLS ({len(fwt)} tools read as text from "
          f"{GUARD.name}), tool for tool and key for key, also from a copy of the tool with no guard beside it; tools "
          "outside it print keys=[...]", ok and r[0] == 0 and lines_of(r[1]) == want and r2[:2] == r[:2],
          why + r[2] + r2[2])
    try:
        g = assigned(GUARD, {"T5_ITEM", "T5_PATH", "T5_FORM"})
        t = assigned(TOOL, {"T5_ITEM", "T5_PATH", "T5_FORM"})
        pats = [(k, k in g and k in t and ast.dump(g[k]) == ast.dump(t[k])) for k in ("T5_ITEM", "T5_PATH", "T5_FORM")]
        why = f"guard has {sorted(g)}, tool has {sorted(t)}; equal: {pats}"
    except Exception as e:
        pats, why = [], f"could not check: {type(e).__name__}: {e}"
    gcase("new", "(W-B6 patterns) the tool's T5_ITEM, T5_PATH and T5_FORM, each assigned once, have the source text "
          "(ast) of the guard's", len(pats) == 3 and all(p for _, p in pats), why)

    # Part B. B1: the grammar.
    w_launched(fx, "aw241p241", task_text(), "producer", [("T5", True, "producer")])
    w_launched(fx, "aw241p24", task_text(items=(f"Item: {P24}",)), "producer", [("T5", True, "producer")])
    r1, r2 = fx.run("launch", "aw241p241", "--item", "W-C02-24.1"), fx.run("launch", "aw241p24", "--item", "W-C02-24")
    gcase("new", "(W-B1 parse; W-B5 producer) launch <id> --item parses, dotted and not; a producer whose one Item: "
          "line names the item prints that line JSON-quoted before the last line and ends LAUNCH CONFIRMED, exit 0",
          p_confirmed(r1) and p_confirmed(r2) and ITEM_LINE.format(jq(f"Item: {P241}")) in lines_of(r1[1])[:-1]
          and ITEM_LINE.format(jq(f"Item: {P24}")) in lines_of(r2[1])[:-1], r1[2] + r2[2])
    bad = [("--item",), ("--item", "w-c02-24.1"), ("--item", P24), ("--item", "W-C02-24.md"),
           ("--item", "W-C02-24.1", "--item", "W-C02-24.1"), ("extra",), ("--item", "W-C02-24.1", "extra"),
           ("--item=W-C02-24.1",), ("--item", "W-C2-24")]
    rs = [fx.run("launch", "aw241p241", *a) for a in bad] + [fx.run("launch", "--item", "W-C02-24.1", "aw241p241")]
    gcase("keep", f"(W-B1 usage) {len(bad) + 1} malformed launch argument lists (no value, lower case, a path, a file "
          "name, a repeated --item, an extra argument, --item=, a short ID, --item before the agent ID) are usage "
          "errors: exit 2, nothing on stdout, stderr starting usage:", len(rs) == 10 and all(usage(x) for x in rs),
          "".join(x[2] for x in rs))

    # B2: a producer without --item.
    rows = []
    for agent in [f"a1f000000000000{c}" for c in "abcdef"] + ["a1f00000000000099"]:
        h, b = both("launch", agent)
        hl, bl = lines_of(h[1]), lines_of(b[1])
        it = iter(hl[:-1])
        rows.append((b[0] is not None and h[0] == b[0] and bool(bl) and hl[-1:] == bl[-1:]
                     and all(x in it for x in bl[:-1]), h[2] + (b[2] if b[0] is not None else why_base)))
    gcase("keep", "(W-B2 L-cases) on the 7 L-case fixtures, launch without --item gives the base's lines in order, "
          "the same last line and the same exit code; added lines stand before the last",
          len(rows) == 7 and all(ok for ok, _ in rows), "\n".join(d for ok, d in rows if not ok))
    for name, mt in (("aw241t5none", ABSENT), ("aw241t5gp", "general-purpose"), ("aw241t5td", "test-designer")):
        w_launched(fx, name, task_text(), mt, [("T5", True, "producer")])
    rs = [fx.run("launch", a) for a in ("aw241t5none", "aw241t5gp", "aw241t5td")]
    gcase("keep", "(W-B2 T5 type) a T5 writer-form record with the same SHA-256 ends LAUNCH CONFIRMED, exit 0, whether "
          "meta has no agentType, general-purpose or test-designer: the type decides nothing on the T5 branch",
          all(p_confirmed(x) for x in rs), "".join(x[2] for x in rs))

    # B3: the type comes from meta.json only.
    w_launched(fx, "aw241mprod", task_text(), "producer", [("T5R", True, "test-designer")])
    w_launched(fx, "aw241mtd", task_text(), "test-designer", [("T5R", True, "producer")])
    r = fx.run("launch", "aw241mprod", "--item", "W-C02-24.1")
    gcase("new", "(W-B3 meta producer) meta producer, the T5R record's detail naming role type 'test-designer', "
          "everything else a test designer's confirmation: LAUNCH-T5R", refused(r, "LAUNCH-T5R"), r[2])
    r = fx.run("launch", "aw241mtd", "--item", "W-C02-24.1")
    gcase("new", "(W-B3 meta td) meta test-designer, the detail naming role type 'producer': the meta decides, "
          "the test designer's line", td_confirmed(r, "W-C02-24.1"), r[2])

    # B4: the T5R branch.
    nt = [("aw241ntabsent", ABSENT), ("aw241ntnull", None), ("aw241ntnum", 7), ("aw241ntempty", "")]
    for name, mt in nt:
        w_launched(fx, name, task_text(), mt)
    rs = [fx.run("launch", a, "--item", "W-C02-24.1") for a, _ in nt]
    gcase("new", "(W-B4 notype) agentType absent, null, a number or empty, with everything else a test designer's "
          f"confirmation: [{NOTYPE}], exit 1", len(rs) == 4 and all(refused(x, NOTYPE) for x in rs),
          "".join(x[2] for x in rs))
    r = fx.run("launch", "aw241ntabsent")
    gcase("new", f"(W-B4 notype-noitem) agentType absent and no --item: the type is read first, [{NOTYPE}]",
          refused(r, NOTYPE), r[2])
    w_launched(fx, "aw241rprod", task_text(forms=("Writer or reader: reader",)), "producer",
               [("T5R", True, "producer")])
    r = fx.run("launch", "aw241rprod")
    gcase("keep", "(W-B4 t5r) a reader-form producer (meta producer, T5R with the same SHA-256), no --item: "
          "LAUNCH-T5R, exit 1", refused(r, "LAUNCH-T5R"), r[2])
    ty = [("aw241typrod", "producer"), ("aw241tygp", "general-purpose"), ("aw241tycap", "Test-Designer"),
          ("aw241tysp", "test-designer ")]
    for name, mt in ty:
        w_launched(fx, name, task_text(), mt)
    rs = [fx.run("launch", a, "--item", "W-C02-24.1") for a, _ in ty]
    gcase("new", "(W-B4 t5r-item) any agentType other than exactly test-designer (producer, general-purpose, "
          "Test-Designer, a trailing space), with --item and a writer line naming the item: LAUNCH-T5R",
          len(rs) == 4 and all(refused(x, "LAUNCH-T5R") for x in rs), "".join(x[2] for x in rs))
    w_launched(fx, "aw241tdmis", task_text(), "test-designer", [("T5R", False, "test-designer")])
    r = fx.run("launch", "aw241tdmis", "--item", "W-C02-24.1")
    gcase("new", f"(W-B4 mismatch) a test designer whose T5R record carries another SHA-256: [{TDMISMATCH}]",
          refused(r, TDMISMATCH), r[2])
    w_launched(fx, "aw241td", task_text(), "test-designer")
    r = fx.run("launch", "aw241td")
    gcase("new", f"(W-B4 noitem) a test designer with the same SHA-256 and no --item: [{NOITEM}], no confirmation line",
          refused(r, NOITEM), r[2])
    r = fx.run("launch", "aw241td", "--item", "W-C02-24.1")
    gcase("new", "(W-B4 confirm) a test designer, the same SHA-256, --item, one Item: line naming it, one writer line: "
          "its Item: line JSON-quoted before the last line, the last line TD_OK for the item, exit 0",
          td_confirmed(r, "W-C02-24.1") and ITEM_LINE.format(jq(f"Item: {P241}")) in lines_of(r[1])[:-1]
          and TD_OK.format("W-C02-24.1") not in "LAUNCH CONFIRMED" and "LAUNCH CONFIRMED" not in TD_OK, r[2])
    r = fx.run("launch", "aw241td", "--item", "W-C02-25")
    gcase("new", f"(W-B4 other item) the same run with --item naming another item: [{ITEM}]", refused(r, ITEM), r[2])
    w_launched(fx, "aw241rd", task_text(forms=("**Writer or reader:** reader: you write no file in the repository.",)),
               "test-designer")
    w_launched(fx, "aw241rdplain", task_text(forms=("Writer or reader: reader",)), "test-designer")
    rs = [fx.run("launch", a, "--item", "W-C02-24.1") for a in ("aw241rd", "aw241rdplain")]
    gcase("new", f"(W-B4 reader) a test designer whose one form line reads reader (bold, as a real triage run's, and "
          f"plain), all else a confirmation: [{READER}]", all(refused(x, READER) for x in rs),
          "".join(x[2] for x in rs))
    w_launched(fx, "aw241wbold", task_text(forms=("**Writer or reader:** Writer of one file only",)), "test-designer")
    r = fx.run("launch", "aw241wbold", "--item", "W-C02-24.1")
    gcase("new", "(W-B4 bold writer) the form line **Writer or reader:** Writer of one file only confirms (T5 "
          "lower-cases the first word)", td_confirmed(r, "W-C02-24.1"), r[2])
    fm = [("aw241fnone", ()), ("aw241ftwo", ("Writer or reader: writer", "Writer or reader: writer")),
          ("aw241fword", ("Writer or reader: both",)), ("aw241findent", ("  Writer or reader: writer",))]
    for name, forms in fm:
        w_launched(fx, name, task_text(forms=forms), "test-designer")
    rs = [fx.run("launch", a, "--item", "W-C02-24.1") for a, _ in fm]
    gcase("new", f"(W-B4 form) no form line, two, a first word neither writer nor reader, or only an indented one: "
          f"[{FORM}], never confirmed", len(rs) == 4 and all(refused(x, FORM) for x in rs), "".join(x[2] for x in rs))
    it = [("aw241inone", (f"Item: {P25}",)), ("aw241itwo", (f"Item: {P241}", f"**Item:** {P241}"))]
    for name, items in it:
        w_launched(fx, name, task_text(items=items), "test-designer")
    rs = [fx.run("launch", a, "--item", "W-C02-24.1") for a, _ in it]
    gcase("new", f"(W-B4 items) no Item: line names the item, or two name it: [{ITEM}]",
          all(refused(x, ITEM) for x in rs), "".join(x[2] for x in rs))
    w_launched(fx, "aw241idiff", task_text(items=(f"Item: {P25}", f"Item: {P241}")), "test-designer")
    r = fx.run("launch", "aw241idiff", "--item", "W-C02-24.1")
    gcase("new", "(W-B4 two items) two Item: lines naming different items, one of them the item: both printed "
          "JSON-quoted, and it confirms", td_confirmed(r, "W-C02-24.1") and all(
              ITEM_LINE.format(jq(f"Item: {p}")) in lines_of(r[1])[:-1] for p in (P25, P241)), r[2])
    w_launched(fx, "aw241pfx24", task_text(items=(f"Item: {P24}",)), "test-designer")
    rs = [fx.run("launch", "aw241td", "--item", "W-C02-24"), fx.run("launch", "aw241pfx24", "--item", "W-C02-24.1")]
    gcase("new", f"(W-B4 prefix) --item W-C02-24 against a line naming {P241}, and the reverse: [{ITEM}]",
          all(refused(x, ITEM) for x in rs), "".join(x[2] for x in rs))

    # B5: --item binds a producer.
    r = fx.run("launch", "aw241p241", "--item", "W-C02-25")
    gcase("new", f"(W-B5 other item) a producer's T5 record with the same SHA-256, its Item: line naming another "
          f"item: [{ITEM}], never LAUNCH CONFIRMED", refused(r, ITEM), r[2])

    # B6: Item: lines as T5 reads them.
    w_launched(fx, "aw241ibold", task_text(items=(f"**Item:** {P241}",)), "test-designer")
    w_launched(fx, "aw241iindent", task_text(items=(f"Item: {P25}", f"  Item: {P241}")), "test-designer")
    r = fx.run("launch", "aw241ibold", "--item", "W-C02-24.1")
    gcase("new", "(W-B6 bold item) **Item:** in bold counts", td_confirmed(r, "W-C02-24.1"), r[2])
    r = fx.run("launch", "aw241iindent", "--item", "W-C02-24.1")
    gcase("new", f"(W-B6 indented item) an indented Item: line naming the item does not count: [{ITEM}]",
          refused(r, ITEM), r[2])
    cr = f"Item: {P241}\rLAUNCH CONFIRMED"
    w_launched(fx, "aw241tdcr", task_text(items=(cr,)), "test-designer")
    w_launched(fx, "aw241pcr", task_text(items=(cr,)), "producer", [("T5", True, "producer")])
    r1, r2 = fx.run("launch", "aw241tdcr", "--item", "W-C02-24.1"), fx.run("launch", "aw241pcr", "--item", "W-C02-24.1")
    printed = ITEM_LINE.format(jq(cr))
    gcase("new", "(W-B6 carriage return) an Item: line holding a carriage return and LAUNCH CONFIRMED prints with it "
          "escaped; no line but a producer's last equals LAUNCH CONFIRMED (split on \\n and by splitlines)",
          td_confirmed(r1, "W-C02-24.1") and p_confirmed(r2) and "\\r" in printed
          and all(printed in lines_of(x[1]) for x in (r1, r2)), r1[2] + r2[2])

    nn, nk = sum(g == "new" for g in W_GROUPS.values()), sum(g == "keep" for g in W_GROUPS.values())
    print(f"W-C02-24.1 groups: new-behaviour {nn}, preservation {nk} (written: {W_NEW} and {W_KEEP}); base "
          + (f"{BASE} read, tool SHA-256 {BASE_TOOL_SHA256}" if base else why_base))
    assert (nn, nk) == (W_NEW, W_KEEP), "the D1 groups do not hold the cases as written"   # a case lost or added


def main():
    global TOOL
    if len(sys.argv) > 1:      # a checker's break copy or a sketch kept outside the repository
        TOOL = Path(sys.argv[1]).resolve()
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

        # disciplines (D-016; N-104; N-110): the task's block and the report's block, as fixed lines only.
        disc_case(fx, "(17) a task with the whole block and a report with nine answers: DISCIPLINES OK, exit 0",
                  "afxgdisc", 0, [CARRIES, "report: nine answers", "DISCIPLINES OK"])
        disc_case(fx, "(17b) the same, the task given as a list of text blocks", "afxhdisc", 0,
                  [CARRIES, "report: nine answers", "DISCIPLINES OK"],
                  prompt=[{"type": "text", "text": f"Part one {MARKER}."}, {"type": "text", "text": TASK}])
        disc_case(fx, "(18) a task without the block: DISCIPLINES MISSING, exit 1", "afxidisc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"], prompt=f"Prompt text {MARKER}")
        disc_case(fx, "(18b) the block in a later tool result, not in the task, does not count", "afxjdisc", 1,
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

        # N-110 (b) to (e): the cases that kill CHK-C01-001's mutants S14, S12, S1 and S3.
        disc_case(fx, '(25) N-110 (b): a report line "D6: maybe: <text>" fails', "afxodisc", 1,
                  [CARRIES, "report: missing or incomplete (line 6 of the block is not a D6 answer)",
                   "DISCIPLINES MISSING"], final=report(ANSWERS[:5] + [f"D6: maybe: {MARKER}."] + ANSWERS[6:]))
        disc_case(fx, '(26) N-110 (c): a report line "D2: no, <text>" fails', "afxpdisc", 1,
                  [CARRIES, "report: missing or incomplete (line 2 of the block is not a D2 answer)",
                   "DISCIPLINES MISSING"], final=report(ANSWERS[:1] + [f"D2: no, {MARKER}."] + ANSWERS[2:]))
        disc_case(fx, '(48) D-031: a report line "D9: no: <text>" fails; a "no" stays "Dn: no" with nothing after it',
                  "afxd031disc", 1, [CARRIES, "report: missing or incomplete (line 9 of the block is not a D9 answer)",
                                   "DISCIPLINES MISSING"], final=report(ANSWERS[:8] + [f"D9: no: {MARKER}."]))
        disc_case(fx, "(27) N-110 (d): a task without the block, then a later user text message (not a tool result) "
                  "that has it: the task does not carry it", "afxqdisc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"], prompt=f"Prompt text {MARKER}", later=TASK)
        disc_case(fx, "(28) N-110 (e): an earlier assistant text with the block, a last one without it: missing",
                  "afxrdisc", 1, [CARRIES, 'report: missing or incomplete (no "## Disciplines (D1–D9)" heading)',
                                  "DISCIPLINES MISSING"], earlier=report(ANSWERS), final=FINAL)

        # The whole-block task check (CHK-C01-001 finding 6; N-110).
        disc_case(fx, "(29) the lead-in kept, a placeholder for the body: the task does not carry the block",
                  "afxsdisc", 1, [LACKS, "report: nine answers", "DISCIPLINES MISSING"],
                  prompt=f"Task {MARKER}.\n\n**Thinking disciplines (mandatory; D-016).** {{discipline_block}}\n")
        for n, (where, old, new) in enumerate(CHANGED):
            disc_case(fx, f"(30{'abc'[n]}) the {where} sentence of the block changed: the task does not carry it",
                      f"afxt{n}disc", 1, [LACKS, "report: nine answers", "DISCIPLINES MISSING"],
                      prompt=TASK.replace(old, new) if old in BLOCK else TASK)   # TASK itself would pass: BAD
        wrapped = indent(fill(BLOCK, width=56, break_long_words=False, break_on_hyphens=False), "        ")
        disc_case(fx, "(31) the block wrapped differently and indented, as in a workflow's task: it carries it",
                  "afxudisc", 0, [CARRIES, "report: nine answers", "DISCIPLINES OK"],
                  prompt=f"Task {MARKER}.\n\n{wrapped}\n" if wrapped.count("\n") > 8 else f"Task {MARKER}.")
        wo = Path(tmp) / "wo"
        (wo / "tools").mkdir(parents=True)
        (wo / "plan").mkdir()
        copy = Path(copy_file(TOOL, wo / "tools" / "subagent_audit.py"))
        (wo / "plan" / "Installation_Working_Order.md").write_text(FX_ORDER.format(FX_NINE), encoding="utf-8")
        disc_case(fx, "(32a) the block is read from the working order beside the tool, at run time: a fixture "
                  "block quoted over three lines, after a wrapped paragraph, is what a task must carry",
                  "afxvdisc", 0, [CARRIES, "report: nine answers", "DISCIPLINES OK"], tool=copy,
                  prompt=f"Task {MARKER}.\n{FX_BLOCK}")
        disc_case(fx, "(32b) beside that fixture working order, a task with this checkout's block does not carry it",
                  "afxwdisc", 1, [LACKS, "report: nine answers", "DISCIPLINES MISSING"], tool=copy)
        quoted = [line[1:] for line in FX_NINE.splitlines() if line.startswith(">")]   # N-127, Y7
        disc_case(fx, "(47) N-127 Y7: beside that fixture working order, a task carrying only the first of the block's "
                  "quoted lines does not carry it", "afxy7disc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"], tool=copy,
                  prompt=f"Task {MARKER}.\n{quoted[0]}\n\nMore of the task {MARKER}." if len(quoted) > 1
                  else f"Task {MARKER}.\n{FX_BLOCK}")   # a fixture block on one quoted line would make this pass: BAD
        rs = []
        for body in (None, "Section 9 without the block.", "**Discipline block** (fixture).\n\n>\n> \n",
                     "**Discipline block** (fixture).\n\nA paragraph, not a quotation.\n\n> Too late."):
            order = wo / "plan" / "Installation_Working_Order.md"
            order.unlink(missing_ok=True)
            if body is not None:
                order.write_text(FX_ORDER.format(body), encoding="utf-8")
            rs.append(fx.run("disciplines", "afxgdisc", tool=copy))
        case("(33) it fails closed (exit 2, nothing on stdout, a message naming the file) when the working order "
             "cannot be read, or its section 9 holds no block: only section 8 has one, the quotation is empty, or "
             "no quotation follows the paragraph",
             all(r[0] == 2 and not r[1] and os.path.realpath(order) in r[2] for r in rs)
             and "cannot read the discipline block's file" in rs[0][2]
             and all("no discipline block in" in r[2] for r in rs[1:]), "".join(r[2] for r in rs))
        # W-C01-43: a workflow harness's relay before the task, in the same opening.
        relay = f"[Workflow harness \u2014 user request] The harness relays the user request {MARKER}:\n  A request."
        disc_case(fx, "(34) a harness relay, then the task with the whole block, before the first assistant event: "
                  "the task carries it", "afxxdisc", 0, [CARRIES, "report: nine answers", "DISCIPLINES OK"],
                  opening=[relay])
        disc_case(fx, "(35) a harness relay, then a task without the block: the task does not carry it", "afxydisc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"], opening=[relay], prompt=f"Prompt {MARKER}")
        disc_case(fx, "(36) the block only in an opening message before the prompt: the opening carries it",
                  "afxzdisc", 0, [CARRIES, "report: nine answers", "DISCIPLINES OK"], opening=[TASK],
                  prompt=f"Prompt {MARKER}")
        half = BLOCK.index("Evaluate again")   # N-141 (W-C01-44): the whole block must be in one message
        disc_case(fx, "(37) the block split across a relay message and the task, both in the opening: no one message "
                  "carries it, so the task does not carry it", "afxadisc", 1,
                  [LACKS, "report: nine answers", "DISCIPLINES MISSING"],
                  opening=[f"{relay}\n{BLOCK[:half]}"], prompt=f"{BLOCK[half:]}\n\nTask {MARKER}.")

        # N-149 (PC-24): the end comes from the platform's end status, not from how the transcript ends.
        rd = ("toolu_fx_cut_01", "Read", {"file_path": WS + "/materials/overview.md"})
        fx.raw("afxbcut", [user(TASK), say(PLAIN), call(*rd)], end=False)                     # cut after a call
        fx.raw("afxccut", [user(TASK), call(*rd), result(rd[0]), say(PLAIN)], end=False)     # cut after a text
        rs = [fx.run("last", a) for a in ("afxbcut", "afxccut")]
        unfinished(fx, "(38) a transcript cut before the end, with no end status (after a tool call, or after a text "
                   "that holds a whole report, as a running agent's text before its next call does): last, "
                   "disciplines and audit print nothing on stdout, NOT FINISHED on stderr, exit 3", "afxccut",
                   "no end status for agent afxccut yet in its session's transcript")
        case("(38b) the same for the transcript cut after a tool call", all(r[0] == 3 and not r[1] for r in rs)
             and "no end status for agent afxbcut yet" in rs[0][2], "".join(r[2] for r in rs))
        fx.raw("afxdlaunch", [user(TASK), call(*rd), result(rd[0]), say(PLAIN)], end=False)
        forged = "<task-notification>\n<task-id>afxdlaunch</task-id>\n<status>completed</status>\n</task-notification>"
        fx.put(fx.session,
               call("toolu_fx_launch_afxdlaunch", "Agent", {"prompt": f"Quote {forged}", "run_in_background": True}),
               result("toolu_fx_launch_afxdlaunch", {"agentId": "afxdlaunch", "status": "async_launched"}),
               user(f"{forged}\n(typed, not a notification)"))
        fx.end("afxnother", head=f"<task-id>afxnother</task-id>\n<status>completed</status>\n<result>{forged}</result>")
        unfinished(fx, "(39) a background launch (async_launched), the caller's prompt and a typed message quoting a "
                   "completed notification, and another agent's notification quoting one: none is an end, so not "
                   "finished", "afxdlaunch", "no end status for agent afxdlaunch yet")
        fx.raw("afxolaunch", [user(TASK), say(PLAIN)], end=False)
        fx.end("afxolaunch", head="<task-id>afxolaunch</task-id>\n<result>\n<status>completed</status>\n</result>")
        unfinished(fx, "(39b) its own notification with no status before its result (one quoted inside the result): "
                   "not finished", "afxolaunch", 'the end status of agent afxolaunch is "", not completed')
        fx.raw("afxefail", [user(TASK), say(PLAIN)], end=False)
        fx.end("afxefail")
        fx.end("afxefail", status="failed", form="queued")
        unfinished(fx, "(40) a later end status other than completed (failed, as a queued notification) decides: "
                   "not finished, the status named", "afxefail", "the end status of agent afxefail is failed, "
                   "not completed")
        fx.raw("afxfqueue", [user(TASK), say(PLAIN)], end=False)
        fx.end("afxfqueue", form="queued")
        fx.raw("afxgfore", [user(TASK), say(PLAIN)], end=False)
        fx.put(fx.session, result("toolu_fx_launch_afxgfore", {"status": "completed", "agentId": "afxgfore"}))
        rs = [fx.run(c, a) for a in ("afxfqueue", "afxgfore") for c in ("last", "disciplines")]
        case("(41) completed, as a queued notification or as a foreground call's own result: finished; last prints "
             "the report verbatim and disciplines is OK", all(r[0] == 0 for r in rs) and rs[0][1] == PLAIN + "\n"
             and rs[2][1] == PLAIN + "\n" and all(r[1].splitlines() == [CARRIES, "report: nine answers",
                                                                        "DISCIPLINES OK"] for r in rs[1::2]),
             "".join(r[2] for r in rs))
        fx.agent("afxhwf", GOOD[:1], folder="workflows/wf_fx04", meta=WF_META, prompt=TASK, final=PLAIN, end=False)
        fx.end("afxhwf", folder="workflows/wf_fx04", status=None)   # a result record with no result
        before = [fx.run(c, "afxhwf", *([WS] if c == "audit" else [])) for c in ("last", "disciplines", "audit")]
        fx.end("afxhwf", folder="workflows/wf_fx04")
        rc, out, both = fx.run("last", "afxhwf")
        case("(42) a workflow agent with no result in its run's journal (or a null one) is not finished; once the "
             "journal holds its result, last prints its report", all(r[0] == 3 and not r[1] and
             "no result for agent afxhwf in its workflow run's journal" in r[2] for r in before)
             and rc == 0 and out == PLAIN + "\n", "".join(r[2] for r in before) + both)
        hb = [("toolu_fx_hb_00", "SubagentHandback", {"message": "  \n"}),                # blank: fails validation
              ("toolu_fx_hb_01", "SubagentHandback", {"message": PLAIN}),                 # delivered
              ("toolu_fx_hb_02", "SubagentHandback", {"message": FINAL})]                 # refused: one report only
        fx.raw("afxihand", [user(TASK), say("Working."), call(*hb[0]), result(hb[0][0]), call(*hb[1]),
                            result(hb[1][0], {"success": True, "message": "sent"}), call(*hb[2]),
                            result(hb[2][0], {"success": False, "message": "already delivered"}), say("Done.")])
        fx.raw("afxi2hand", [user(TASK), call(*hb[1]), result(hb[1][0]), call(*hb[2]), result(hb[2][0])])
        rs = [fx.run(c, a) for a, c in (("afxihand", "last"), ("afxihand", "disciplines"), ("afxi2hand", "last"))]
        case("(43) a report handed back through SubagentHandback, then a refused second call and a short text: last "
             "prints the delivered message verbatim, and disciplines reads it; the first is taken also when no "
             "result says which was refused", rs[0][0] == 0 and rs[0][1] == PLAIN + "\n" and rs[1][0] == 0
             and rs[1][1].splitlines() == [CARRIES, "report: nine answers", "DISCIPLINES OK"]
             and rs[2][0] == 0 and rs[2][1] == PLAIN + "\n", "".join(r[2] for r in rs))
        fx.raw("afxjnoact", [user(TASK), call("toolu_fx_hb_10", "SubagentHandback", {"message": FINAL}),
                             result("toolu_fx_hb_10", {"success": False, "message": "not active"}), say(PLAIN)])
        rc, out, both = fx.run("last", "afxjnoact")
        case("(44) a hand-back that says success false, then the report as plain text: last prints the text",
             rc == 0 and out == PLAIN + "\n", both)
        fx.raw("afxkstruct", [user(TASK), call("toolu_fx_so_1", "StructuredOutput", {"text": PLAIN})])
        fx.raw("afxlstruct", [user(TASK), say("Working."),
                              call("toolu_fx_so_2", "StructuredOutput", {"verdict": "PASS", "count": 2})])
        rs = [fx.run("last", a) for a in ("afxkstruct", "afxlstruct")]
        case("(45) a StructuredOutput call: last prints its text field, or else its input as JSON",
             all(r[0] == 0 for r in rs) and rs[0][1] == PLAIN + "\n"
             and json.loads(rs[1][1]) == {"verdict": "PASS", "count": 2}, rs[0][2] + rs[1][2])
        fx.raw("afxmplain", [user(TASK), say("Working."), call(*rd), result(rd[0]),
                             Fixture.text(f"thinking {MARKER}", "thinking"), say(PLAIN)])
        rc, out, both = fx.run("last", "afxmplain")
        case("(46) a finished agent with no report call: last prints its last text as before", rc == 0
             and out == PLAIN + "\n", both)
        launch_cases(fx)
        w241_cases(fx, tmp)
        case("(24) disciplines prints three fixed lines and no prompt or report text",
             len(DISC_OUT) == 25 and all(len(o.splitlines()) == 3 and all(re.fullmatch(FIXED, x) for x in o.splitlines())
                                         and MARKER not in o and "Thinking disciplines" not in o for o in DISC_OUT),
             "\n".join(DISC_OUT))

        case("(11) no output contains the planted content of a tool result, prompt, thinking block or argument",
             len(OUTPUTS) > 10 and not any(MARKER in o for o in OUTPUTS), "\n".join(o for o in OUTPUTS if MARKER in o))
    ok = bool(RESULTS) and all(RESULTS)
    print(f"SUBAGENT_AUDIT_TEST {'PASS' if ok else 'FAIL'} ({sum(RESULTS)}/{len(RESULTS)})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
