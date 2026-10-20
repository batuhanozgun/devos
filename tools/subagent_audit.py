#!/usr/bin/env python3
"""subagent_audit.py: read a subagent's transcript and the guard's decision log, read-only (W-C00-15; CHK-C00-041 C4).

Claude Code keeps each subagent's transcript at <home>/.claude/projects/*/*/subagents/agent-<id>.jsonl, one JSON
event per line (an assistant event holds one content block: text, thinking or tool_use), with a sibling
agent-<id>.meta.json whose toolUseId names the Agent call that started it. An agent started by a workflow keeps the
same two files one level deeper, at .../subagents/workflows/<run-id>/agent-<id>.jsonl, and its meta names no
toolUseId (observed on 2026-10-06), so its start cannot be matched to a guard record by tool-use ID. Every
command looks in both places and needs exactly one transcript. The guard (.claude/hooks/tool_allowlist.py)
appends to <log dir>/<session>.jsonl one PreToolUse record per tool call, a workflow agent's included, with the
subagent's agent_id, the tool and, for Read, Glob and Grep, the logged path (its summary: Read's file_path, Glob's or
Grep's path, empty when none). PermissionRequest records come in addition and are not counted. Rule B5 lets only a
reader or a tools/ script name these locations; this is that script. It reads and never writes.

The end (PC-24; N-149). A subagent's own transcript holds no reliable end mark: it has no end or result record, its
meta has no status, the final event's stop_reason is mostly empty (observed 2026-10-11, version 2.1.296), and its
last text block can be followed by a tool call of the same response. The platform's end status is recorded
elsewhere: for an Agent-tool subagent in its session's transcript (<session>.jsonl beside the <session>/ folder that
holds subagents/): a background call's completion notification (a user event whose origin kind is
"task-notification", or a queued_command attachment of that mode, its text starting <task-notification> with
<task-id> the agent ID and <status>, read before its <summary> or <result>), or a foreground call's own result (the
tool result of the meta's toolUseId, whose toolUseResult status is not "async_launched"); the last of these decides;
for a workflow agent, a "result" record with its agentId in the run's journal.jsonl. So last, disciplines and audit
first need status "completed" (a workflow agent: a non-null result); else they print nothing on stdout, NOT
FINISHED with the reason on stderr, and exit 3. Observed in this form: the background notification and the
journal; the foreground result's form is inferred from the launch's toolUseResult and the documented status.

  last <agent-id>               the agent's report, as stored, followed by one newline (how checker verdicts are
                                filed verbatim): the message of its first SubagentHandback call (the hand-back
                                call) with a non-blank message whose result does not say success false (the
                                platform delivers one report and refuses later calls, and plain text after it is
                                not delivered); else the input of its last StructuredOutput call (a workflow agent
                                given a schema): its "text" string if non-empty, else the input as JSON; else the
                                text of its last assistant event that has text (read in the installed Claude Code's
                                code on 2026-10-11; a hand-back is not yet observed in a transcript)
  audit <agent-id> <workspace>  the isolation audit of evidence/C00/EV-C00-016_baseline_preregistration.md section 7:
                                the transcript's path, SHA-256 and kind (Agent-tool subagent, or workflow agent with
                                its run ID), the meta toolUseId (for a workflow agent whose meta names none, a line
                                saying so: its starting call cannot be found in the guard log as an Agent call's can;
                                that does not void the run), each call with its path arguments judged inside or
                                outside the workspace, the call counts of the transcript
                                and the guard log (a difference is recorded; as section 7 says, it does not void a
                                run by itself), the guard records that break the rules, and AUDIT VALID or
                                AUDIT VOID: <reasons>
  calls <agent-id>              the per-call lines only, without the rules
  disciplines <agent-id>        D-016's two presence checks (N-104; N-110): whether the task the agent was given (the
                                agent's opening: each user event before its first assistant event, one of which
                                must hold the block; a workflow harness may put a message of its own, relaying the
                                user's request, before the task in that opening, observed 2026-10-11, W-C01-43; a
                                user message after the first assistant event, or a tool result, does not count)
                                carries the whole discipline block of
                                plan/Installation_Working_Order.md section 9 (the quotation after its paragraph
                                "**Discipline block**"), compared after normalising whitespace, so that a task that
                                keeps the lead-in with a placeholder body fails (CHK-C01-001 finding 6); the block is
                                read at run time from the working order of the checkout this script is in, and a
                                file that cannot be read or holds no such block is a reading error (exit 2); and
                                whether its report (the text `last` prints) holds a "## Disciplines (D1–D9)"
                                heading whose next nine non-blank lines answer D1 to D9 in order, each "Dn: no"
                                (then ".", ";" or nothing), "Dn: yes: <text>" or "Dn: uncertain: <text>", a list
                                marker "- " or "* " allowed before it; then DISCIPLINES OK, or DISCIPLINES MISSING
                                when either fails. Whether an answer is right is not judged here; that is the
                                checkers' to sample (D-016 item 3).
  launch <agent-id>             W-C02-24 M1b (B8): whether the run was launched in guard rule T5's writer form. It
                                prints the UTF-8 byte length and SHA-256 of the run's first task message (the first
                                user event of its transcript: a string, or its text blocks joined by newlines), the
                                same of the prompt the session's own Agent call sent (the tool_use in the session's
                                transcript whose ID is the meta's toolUseId; W-C02-24's observation (12)), and the
                                guard records whose tool_use_id is that toolUseId. LAUNCH CONFIRMED (exit 0) when one
                                of them has rule T5 (exactly), decision allow and a prompt_sha256 in its detail equal
                                to the first task message's; else "could not confirm" with its reason ID (exit 1):
                                [LAUNCH-MISMATCH] a linked T5 allow record with another SHA-256, [LAUNCH-T5R] a linked
                                T5R allow (the reader form), [LAUNCH-NORECORD] no linked T5 allow record (none, a
                                denial only, or a workflow agent's meta that names no starting call),
                                [LAUNCH-NOTRANSCRIPT] no single transcript or no task message in it. A finished run
                                is not required. Self-contained, so that later subcommands do not change it.
  launch <agent-id> --item <id> W-C02-24.1 Part B: the same, bound to the item <id> (W-C<dd>-<dd>[.<n>], matched
                                whole; any other argument list is a usage error). It also prints each Item: line of
                                the first task message (a line that T5's Item: pattern matches at column 0, the lines
                                split on "\n" as T5 splits them) as "item line: <JSON string>", and an Item: line
                                names <id> when the first match of T5's path pattern in it equals plan/work/<id>.md
                                exactly. A producer (a linked T5 allow record of the same SHA-256) ends LAUNCH
                                CONFIRMED only when exactly one Item: line names <id>, else [LAUNCH-ITEM]. Where no
                                T5 allow record is linked and a T5R allow record is, the run's type decides, read from
                                its meta.json agentType only (the platform writes it), never from a record: no
                                agentType string, or an empty one, is [LAUNCH-NOTYPE] (read first); any type other
                                than exactly test-designer is [LAUNCH-T5R], as without --item; a test designer whose
                                T5R records carry another SHA-256 or none is [LAUNCH-T5R-MISMATCH]; without --item it
                                is [LAUNCH-NOITEM]; with no, two or an unknown T5 form line (T5's Writer or reader:
                                pattern at column 0, its first word lower-cased) [LAUNCH-FORM]; with the form reader
                                [LAUNCH-READER]; unless exactly one Item: line names <id>, [LAUNCH-ITEM]; else its
                                last line is "TEST-DESIGNER CONFIRMED: <id> (test and oracle paths only)" (exit 0),
                                which shows that the run was launched with that Item: line, not that an approach or
                                acceptance reached it (T5R reads no item file). Every refusal exits 1. Without
                                --item, a producer's lines, their order, its last line and its exit code are those
                                of launch <agent-id> above; a line added for the T5R branch stands before the last.

audit and calls print tool names, path arguments (Read file_path; Glob path and pattern; Grep path and glob; the
path of each file-writing call, the guard's FILE_WRITE_TOOLS copied here: Write and Edit file_path, NotebookEdit
notebook_path, or "<key>=none (no string path)" when that key holds no string) and the input key names of any other
tool; never file content (Write content, Edit old_string and new_string, NotebookEdit new_source), tool output or
prompt text. A printed write is an attempt: a denied or failed call still shows, and the path says nothing of the
bytes; a file written through Bash or a script is not traced. Strings are printed JSON-quoted, so that no argument
can forge an output line (json.dumps leaves U+2028 and U+0085 as they are, so a reader splits lines on "\n" only).
disciplines prints three fixed lines (its reasons name only answer numbers and counts), never prompt or report text;
launch prints byte lengths, hashes, record numbers and rules, the meta's agentType and T5's form word on the T5R
branch, and with --item the Item: lines; never other prompt text. calls lists a transcript as it stands, finished or
not. Exit codes:
0 done (audit: valid; disciplines: both present), 1 audit void or disciplines missing, 2 usage or reading error, 3
not finished. Locations: $DEVOS_AUDIT_HOME (default: the home directory), $DEVOS_GUARD_LOG_DIR (default
/tmp/devos-guard).
"""
import glob
import hashlib
import json
import os
import re
import signal
import sys

ALLOWED = ("Read", "Glob", "Grep", "TodoWrite", "ToolSearch")   # TodoWrite and ToolSearch reach no file (section 7)
PATH_KEYS = {"Read": ("file_path",), "Glob": ("path", "pattern"), "Grep": ("path", "glob")}
# W-C02-24.1: the file-writing tools and their path keys, copied from the guard's FILE_WRITE_TOOLS
# (.claude/hooks/tool_allowlist.py), never imported; tools/test_subagent_audit.py (W-A6) compares the two.
FILE_WRITE_TOOLS = {"Write": "file_path", "Edit": "file_path", "NotebookEdit": "notebook_path"}
# W-C02-24.1 (B4, B6): guard rule T5's form and Item: grammars, copied from the guard, never imported (each matched at
# column 0 of a "\n"-separated line); tools/test_subagent_audit.py (W-B6 patterns) compares the source text.
T5_FORM = re.compile(r"(?:\*\*)?Writer or reader:(?:\*\*)?[ \t]*([A-Za-z]*)")
T5_ITEM = re.compile(r"(?:\*\*)?Item:")
T5_PATH = re.compile(r"plan/work/W-C\d\d-\d\d(?:\.\d+)?\.md")
ITEM_ID = re.compile(r"W-C[0-9][0-9]-[0-9][0-9](?:\.[0-9]+)?")   # launch's --item value, matched whole
NEEDED = {"file_path", "path"}       # absent: Read has no file; Glob or Grep searches the session's working directory
PATTERNS = {"pattern", "glob"}       # relative to the call's path unless they start with /
WORKING_ORDER = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), "plan",
                             "Installation_Working_Order.md")   # section 9 holds the block every task carries
DISC_HEAD = "## Disciplines (D1–D9)"
# W-C02-25: the hand-over headings of every role file's Output list, in order, Take-up: included and the disciplines
# heading apart; and the binding verdict's front-matter keys, in .claude/agents/checker.md's template order (the same
# list as tools/merge_gate.py's VERDICT_KEYS; tools/test_agent_hooks.py H1 and H2 and tools/test_merge_gate.py B9.keys
# compare them with the role files). The stop hook (.claude/hooks/agent_hooks.py) reads both.
HANDOVER_HEADINGS = ("Package:", "Nonce:", "Take-up:", "Read, and what each changed:", "Relied on:", "Unsure:",
                     "For:", "Received from / Returned to:", "Product:", "Guard denials:")
VERDICT_KEYS = ("id", "target", "item", "reviewed_head", "verdict", "conditions", "independence", "checker_run", "date",
                "take_up", "triage", "floor", "own_breaks", "shared_with_producer", "producer_run", "package", "nonce",
                "read", "relied_on", "unsure", "for", "received_returned", "guard_denials")
USAGE ="usage: subagent_audit.py last <agent-id> | calls <agent-id> | audit <agent-id> <workspace> | " \
        "disciplines <agent-id> | launch <agent-id> [--item W-C<dd>-<dd>[.<n>]]"


class Error(Exception):
    pass


class NotFinished(Exception):
    pass


def session_log(log_dir):
    """This session's guard decision log, named by the guard's session_key (one key; W-C02-25), loaded from this
    checkout's guard file."""
    import importlib.machinery
    import importlib.util
    path = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), ".claude", "hooks",
                        "tool_allowlist.py")
    try:
        ldr = importlib.machinery.SourceFileLoader("devos_guard_for_subagent_audit", path)
        g = importlib.util.module_from_spec(importlib.util.spec_from_loader(ldr.name, ldr))
        ldr.exec_module(g)
        key = g.session_key({})
    except Exception as e:   # a guard that cannot be loaded is a reading error, never an empty log set
        raise Error(f"cannot take session_key from {path}: {type(e).__name__}") from e
    return os.path.join(log_dir, key + ".jsonl")


def q(s):
    s = str(s)
    return s if re.fullmatch(r"[\w.:+-]+", s) else json.dumps(s, ensure_ascii=False)


def jsonl(path):
    try:
        with open(path, "rb") as f:
            data = f.read()
    except OSError as e:
        raise Error(f"cannot read {path}: {e.strerror}")
    recs = []
    for i, raw in enumerate(data.splitlines(), 1):
        if raw.strip():
            try:
                recs.append(json.loads(raw))
            except ValueError:
                recs.append(None)
            if not isinstance(recs[-1], dict):
                raise Error(f"{path}: line {i} is not a JSON object")
    return data, recs


def transcript(agent):
    """(path, run): the agent's one transcript, and its workflow run's ID (None for an Agent-tool subagent)."""
    if not re.fullmatch(r"[A-Za-z0-9_-]{1,64}", agent):
        raise Error(f"not an agent ID: {q(agent)}")
    home = os.environ.get("DEVOS_AUDIT_HOME") or os.path.expanduser("~")
    sub, name = os.path.join(glob.escape(home), ".claude", "projects", "*", "*", "subagents"), f"agent-{agent}.jsonl"
    found = [(p, None) for p in glob.glob(os.path.join(sub, name))] + \
            [(p, os.path.basename(os.path.dirname(p))) for p in glob.glob(os.path.join(sub, "workflows", "*", name))]
    if len(found) != 1:
        raise Error(f"{len(found)} transcripts of agent {agent} under {home}/.claude/projects, in subagents/ or "
                    "subagents/workflows/<run-id>/ (one is needed)")
    return found[0]


def tool_calls(events):
    """(name, input, cwd) of each tool_use block of the assistant events, in order, once per tool-use ID."""
    seen, out = set(), []
    for e in events:
        m = e.get("message")
        if e.get("type") != "assistant" or not isinstance(m, dict) or not isinstance(m.get("content"), list):
            continue
        for b in m["content"]:
            if isinstance(b, dict) and b.get("type") == "tool_use" and (b.get("id") is None or b["id"] not in seen):
                seen.add(b.get("id"))
                out.append((str(b.get("name")), b["input"] if isinstance(b.get("input"), dict) else {}, e.get("cwd")))
    return out


def call_line(i, name, inp):
    if name in PATH_KEYS:
        shown = " ".join(f"{k}={json.dumps(inp[k], ensure_ascii=False)}" for k in PATH_KEYS[name] if k in inp)
    elif name in FILE_WRITE_TOOLS:          # its path only, never content, old_string, new_string or new_source
        k = FILE_WRITE_TOOLS[name]
        v = inp.get(k)
        shown = f"{k}={json.dumps(v, ensure_ascii=False)}" if isinstance(v, str) else f"{k}=none (no string path)"
    else:
        shown = "keys=" + json.dumps([str(k) for k in inp], ensure_ascii=False)
    return f"{i} {q(name)} {shown}".rstrip()


def outside(p, ws, cwd, pattern=False):
    """None when p resolves inside the workspace ws (os.path.normpath), else the reason."""
    if not isinstance(p, str) or not p:
        return "is empty or not a string"
    if pattern and ".." in p:
        return "contains .."
    if p.startswith("~"):
        return "starts with ~ (the home directory)"
    if not p.startswith("/"):
        if pattern:
            return None                  # relative to the call's path, which is judged on its own
        if not isinstance(cwd, str) or not cwd.startswith("/"):
            return "is relative and no working directory is recorded"
        p = os.path.join(cwd, p)         # a relative path resolves against the session's working directory
    n = os.path.normpath(p)
    return None if n == ws or n.startswith(ws + os.sep) else f"resolves to {json.dumps(n, ensure_ascii=False)}"


def judge(name, inp, ws, cwd):
    if name not in ALLOWED:
        return [f"tool {q(name)} is not allowed"]
    why = []
    for k in PATH_KEYS.get(name, ()):
        if k not in inp:
            if k in NEEDED:
                why.append(f"no {k}" + (" (searches the session's working directory)" if k == "path" else ""))
        else:
            r = outside(inp[k], ws, cwd, pattern=k in PATTERNS)
            if r:
                why.append(f"{k} {r}")
    return why


def judge_record(r, ws):
    tool = str(r.get("tool"))
    if tool not in ALLOWED:
        return f"tool {q(tool)} is not allowed"
    if tool in PATH_KEYS:
        if not r.get("summary"):
            return "no path logged" + (" (searches the session's working directory)" if tool != "Read" else "")
        why = outside(r.get("summary"), ws, r.get("cwd"))
        return f"logged path {why}" if why else None
    return None


def texts(m):
    """The text of a message: a string content as it stands, else its text blocks joined by newlines."""
    c = m.get("content") if isinstance(m, dict) else None
    if isinstance(c, str):
        return c
    return "\n".join(b["text"] for b in c if isinstance(b, dict) and b.get("type") == "text"
                     and isinstance(b.get("text"), str)) if isinstance(c, list) else ""


def tolerant(path, needles):
    """The JSON objects of the lines of path that hold one of the needles (bytes); a line that does not parse (one
    being appended) is skipped. None when path cannot be read."""
    try:
        with open(path, "rb") as f:
            data = f.read()
    except OSError:
        return None
    out = []
    for raw in data.splitlines():
        if any(n in raw for n in needles):
            try:
                e = json.loads(raw)
            except ValueError:
                continue
            if isinstance(e, dict):
                out.append(e)
    return out


def note_status(text, agent):
    """The <status> of a task notification about agent, read before its <summary> or <result>; None if text is no
    notification about agent."""
    if not isinstance(text, str) or not text.lstrip().startswith("<task-notification>"):
        return None
    head = re.split(r"<(?:summary|result)>", text, maxsplit=1)[0]
    tid, status = re.search(r"<task-id>([^<]*)</task-id>", head), re.search(r"<status>([^<]*)</status>", head)
    return (status.group(1).strip() if status else "") if tid and tid.group(1).strip() == agent else None


def end_problem(path, run, agent):
    """None when the platform's end status says the agent has finished; else why not (see "The end" above)."""
    if run is not None:
        journal = os.path.join(os.path.dirname(path), "journal.jsonl")
        recs = tolerant(journal, [agent.encode()])
        if recs is None:
            raise Error(f"cannot read the workflow run's journal {journal}")
        if any(r.get("type") == "result" and r.get("agentId") == agent and r.get("result") is not None for r in recs):
            return None
        return f"no result for agent {agent} in its workflow run's journal {journal}"
    session = os.path.dirname(os.path.dirname(path)) + ".jsonl"
    try:
        with open(path[:-len(".jsonl")] + ".meta.json", "rb") as f:
            tid = json.loads(f.read()).get("toolUseId")
    except (OSError, ValueError, AttributeError):
        tid = None
    tid = tid if isinstance(tid, str) and tid else None
    recs = tolerant(session, [agent.encode()] + ([tid.encode()] if tid else []))
    if recs is None:
        raise Error(f"cannot read the session's transcript {session}, where the end status is recorded")
    status = None
    for e in recs:
        m, a, r = e.get("message"), e.get("attachment"), e.get("toolUseResult")
        s = None
        if e.get("type") == "user" and isinstance(e.get("origin"), dict) and \
                e["origin"].get("kind") == "task-notification" and isinstance(m, dict):
            s = note_status(m.get("content"), agent)
        elif e.get("type") == "attachment" and isinstance(a, dict) and a.get("type") == "queued_command" and \
                a.get("commandMode") == "task-notification":
            s = note_status(a.get("prompt"), agent)
        elif e.get("type") == "user" and tid and isinstance(r, dict) and r.get("status") != "async_launched" and \
                isinstance(m, dict) and isinstance(m.get("content"), list) and any(
                    isinstance(b, dict) and b.get("type") == "tool_result" and b.get("tool_use_id") == tid
                    for b in m["content"]):
            s = str(r.get("status"))
        status = s if s is not None else status
    if status is None:
        return f"no end status for agent {agent} yet in its session's transcript {session}"
    return None if status == "completed" else f"the end status of agent {agent} is {q(status)}, not completed"


def finished(path, run, agent):
    why = end_problem(path, run, agent)
    if why:
        raise NotFinished(why)


def last_text(events):
    """The agent's report (see last in the docstring): a hand-back, a structured output or the last text, or None."""
    failed = {b.get("tool_use_id") for e in events if e.get("type") == "user" and isinstance(e.get("toolUseResult"),
              dict) and e["toolUseResult"].get("success") is False and isinstance(e.get("message"), dict)
              and isinstance(e["message"].get("content"), list)
              for b in e["message"]["content"] if isinstance(b, dict) and b.get("type") == "tool_result"}
    hand, out = [], []
    for e in events:
        m = e.get("message")
        if e.get("type") == "assistant" and isinstance(m, dict) and isinstance(m.get("content"), list):
            for b in m["content"]:
                inp = b.get("input") if isinstance(b, dict) and b.get("type") == "tool_use" else None
                if isinstance(inp, dict) and b.get("name") == "SubagentHandback" and b.get("id") not in failed \
                        and isinstance(inp.get("message"), str) and inp["message"].strip():
                    hand.append(inp["message"])
                elif isinstance(inp, dict) and b.get("name") == "StructuredOutput":
                    out.append(inp)
    if hand:
        return hand[0]
    if out:
        t = out[-1].get("text")
        return t if isinstance(t, str) and t else json.dumps(out[-1], ensure_ascii=False, indent=2)
    for e in reversed(events):
        m = e.get("message")
        if e.get("type") == "assistant" and isinstance(m, dict) and isinstance(m.get("content"), list):
            t = texts(m)
            if t.strip():
                return t
    return None


def last(agent):
    path, run = transcript(agent)
    finished(path, run, agent)
    t = last_text(jsonl(path)[1])
    if t is None:
        raise Error(f"agent {agent} has no assistant event with text")
    print(t)
    return 0


def block_problem(text):
    """None when text holds the disciplines block (see disciplines in the docstring); else what is wrong, in fixed
    words that quote nothing of the text."""
    lines = text.splitlines()
    head = [i for i, line in enumerate(lines) if line.strip() == DISC_HEAD]
    if not head:
        return f'no "{DISC_HEAD}" heading'
    rest = [line.strip() for line in lines[head[0] + 1:] if line.strip()]
    for n in range(1, 10):
        if n > len(rest) or rest[n - 1].startswith("#"):
            return f"{n - 1} answer lines, nine needed"
        m = re.fullmatch(rf"(?:[-*] )?D{n}:\s*(?:no[.;]?|(yes|uncertain):(.*))", rest[n - 1])
        if m is None:
            return f"line {n} of the block is not a D{n} answer"
        if m.group(1) and not re.search(r"\w", m.group(2)):
            return f'D{n}: "{m.group(1)}" without text'
    return None


def task_block():
    """The discipline block of the working order's section 9, whitespace normalised: the quotation (lines starting
    with ">") after the paragraph that starts "**Discipline block**". A "## " line inside a ``` fence (the verdict
    template's) is not a heading. Fails closed: an Error when the file cannot be read or holds no such block."""
    try:
        with open(WORKING_ORDER, encoding="utf-8") as f:
            lines = f.read().splitlines()
    except (OSError, ValueError) as e:
        raise Error(f"cannot read the discipline block's file {WORKING_ORDER}: {getattr(e, 'strerror', None) or e}")
    heads, fence = [], False
    for i, line in enumerate(lines):
        fence = not fence if line.startswith("```") else fence
        if not fence and line.startswith("## "):
            heads.append(i)
    start = next((i for i in heads if lines[i].startswith("## 9. ")), len(lines))
    end = next((i for i in heads if i > start), len(lines))
    i = next((i for i in range(start + 1, end) if lines[i].startswith("**Discipline block**")), end)
    while i < end and lines[i].strip() and not lines[i].startswith(">"):   # the rest of that paragraph
        i += 1
    while i < end and not lines[i].strip():
        i += 1
    quote = []
    while i < end and lines[i].startswith(">"):
        quote.append(lines[i][1:])
        i += 1
    block = " ".join(" ".join(quote).split())
    if not re.search(r"\w", block):
        raise Error(f'no discipline block in {WORKING_ORDER}: section 9 ("## 9. ") needs a paragraph starting '
                    '"**Discipline block**" followed by a quotation (lines starting with ">") that holds it')
    return block


def opening(events):
    """The messages of the agent's opening: every user event before its first assistant event (W-C01-43). A workflow
    harness may put a message of its own before the task there; a tool result is not text (texts reads text only)."""
    out = []
    for e in events:
        if e.get("type") == "assistant":
            break
        if e.get("type") == "user":
            out.append(e.get("message"))
    return out


def disciplines(agent):
    block = task_block()
    path, run = transcript(agent)
    finished(path, run, agent)
    _, events = jsonl(path)
    task = any(block in " ".join(texts(m).split()) for m in opening(events))
    t = last_text(events)
    why = "no assistant text" if t is None else block_problem(t)
    print("task: carries the D-016 questions" if task else "task: does NOT carry the D-016 questions")
    print("report: nine answers" if why is None else f"report: missing or incomplete ({why})")
    print("DISCIPLINES OK" if task and why is None else "DISCIPLINES MISSING")
    return 0 if task and why is None else 1


def calls(agent):
    _, events = jsonl(transcript(agent)[0])
    for i, (name, inp, _) in enumerate(tool_calls(events), 1):
        print(call_line(i, name, inp))
    return 0


def audit(agent, workspace):
    if not os.path.isabs(workspace):
        raise Error(f"the workspace must be an absolute path: {q(workspace)}")
    ws = os.path.normpath(workspace)
    path, run = transcript(agent)
    data, events = jsonl(path)
    meta_path = path[:-len(".jsonl")] + ".meta.json"
    try:
        with open(meta_path, "rb") as f:
            meta = json.loads(f.read())
    except (OSError, ValueError):
        meta = None
    if not isinstance(meta, dict) or (run is None and "toolUseId" not in meta):   # a workflow agent's may lack it
        raise Error(f"no readable {'meta' if run else 'toolUseId'} in {meta_path}")
    finished(path, run, agent)
    log_dir = os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard"
    own = session_log(log_dir)   # this session's log when it exists; else every log, as before W-C02-25
    logs = [own] if os.path.isfile(own) else sorted(glob.glob(os.path.join(glob.escape(log_dir), "*.jsonl")))
    if not logs:
        raise Error(f"no guard decision log (*.jsonl) in {log_dir}")
    records = [r for name in logs for r in jsonl(name)[1] if r.get("agent_id") == agent]

    out, void = [f"transcript: {path}", f"sha256: {hashlib.sha256(data).hexdigest()}",
                 "kind: " + (f"workflow agent (run {q(run)})" if run else "Agent-tool subagent"),
                 f"toolUseId: {q(meta['toolUseId'])}" if "toolUseId" in meta else
                 "toolUseId: none (the meta of this workflow agent names no starting call, so its start cannot be "
                 "found in the guard log by tool-use ID as an Agent call's can; recorded, not void by itself)",
                 f"workspace: {json.dumps(ws, ensure_ascii=False)}"], []
    cs = tool_calls(events)
    for i, (name, inp, cwd) in enumerate(cs, 1):
        why = judge(name, inp, ws, cwd)
        out.append(call_line(i, name, inp) + (": OUTSIDE (" + "; ".join(why) + ")" if why else ": inside"))
        if why:
            void.append(f"call {i} outside")
    pre = sum(1 for r in records if r.get("event") == "PreToolUse")
    out.append(f"tool calls in the transcript: {len(cs)}")
    out.append(f"guard-log PreToolUse records for {agent}: {pre} ({'agree' if pre == len(cs) else 'DIFFER'})")
    if pre != len(cs):    # recorded, not void by itself: a call that breaks a rule in either source voids (section 7)
        out.append(f"note: the counts differ by {abs(pre - len(cs))}; every call in both sources is judged below")
    bad = [(r, w) for r in records for w in [judge_record(r, ws)] if w]
    out.append(f"guard records breaking the rules: {len(bad) or 'none'}")
    for r, w in bad:
        out.append(f"  #{q(r.get('n'))} {q(r.get('time'))} {q(r.get('event'))} {q(r.get('tool'))} "
                   f"{q(r.get('decision'))}: {w}")
        void.append(f"guard record #{q(r.get('n'))} breaks the rules")
    out.append("AUDIT VALID" if not void else "AUDIT VOID: " + "; ".join(void))
    print("\n".join(out))
    return 1 if void else 0


LAUNCH_SHA = re.compile(r"(?:^|[\s;,])prompt_sha256=([0-9a-f]{64})(?![0-9a-f])")


def launch(agent, item=None):
    """See launch in the docstring (W-C02-24 M1b, B8; observation (12); W-C02-24.1 Part B for item and the T5R
    branch)."""
    def fail(token, why):
        print(f"LAUNCH: could not confirm [{token}]: {why}")
        return 1

    def digest(text):
        data = text.encode("utf-8")              # strict, as guard rule T5 encodes the prompt
        return len(data), hashlib.sha256(data).hexdigest()

    try:
        path, run = transcript(agent)
        _, events = jsonl(path)
    except Error as e:
        return fail("LAUNCH-NOTRANSCRIPT", str(e))
    first = next((e for e in events if e.get("type") == "user"), None)
    msg = first.get("message") if first else None
    content = msg.get("content") if isinstance(msg, dict) else None
    blocks = [b for b in content if isinstance(b, dict) and b.get("type") == "text"] if isinstance(content, list) else []
    if not isinstance(content, str) and not blocks:
        return fail("LAUNCH-NOTRANSCRIPT", f"no task message in the first user event of {path}")
    task = content if isinstance(content, str) else texts(msg)
    try:
        n, sha = digest(task)
    except UnicodeEncodeError:
        return fail("LAUNCH-NOTRANSCRIPT", "the first task message cannot be encoded as UTF-8")
    print(f"transcript: {path}")
    print(f"first task message ({'a string' if isinstance(content, str) else f'{len(blocks)} text blocks'}): "
          f"bytes={n} sha256={sha}")
    lines = task.split("\n")                     # T5's lines: a "\r" stays part of its line
    items = [x for x in lines if T5_ITEM.match(x)]
    if item is not None:                         # each Item: line JSON-quoted, so that none can forge an output line
        for x in items:
            print(f"item line: {json.dumps(x, ensure_ascii=False)}")
    try:
        with open(path[:-len(".jsonl")] + ".meta.json", "rb") as f:
            meta = json.loads(f.read())
    except (OSError, ValueError):
        meta = None
    meta = meta if isinstance(meta, dict) else {}
    tid = meta.get("toolUseId")

    def item_problem():
        """None when exactly one Item: line names plan/work/<item>.md (its first T5 path match, compared exactly)."""
        want = f"plan/work/{item}.md"
        named = sum(1 for x in items for m in [T5_PATH.search(x)] if m and m.group(0) == want)
        return None if named == 1 else f"{named} Item: lines name {want} ({len(items)} Item: lines); exactly one must"
    if run is not None or not isinstance(tid, str) or not tid:
        return fail("LAUNCH-NORECORD", "its meta names no starting call (toolUseId), so no guard record can be linked"
                    + (" (a workflow agent)" if run is not None else ""))
    print(f"toolUseId: {q(tid)}")
    session = os.path.dirname(os.path.dirname(path)) + ".jsonl"
    sent = [b["input"]["prompt"] for e in (tolerant(session, [tid.encode()]) or []) if e.get("type") == "assistant"
            and isinstance(e.get("message"), dict) and isinstance(e["message"].get("content"), list)
            for b in e["message"]["content"] if isinstance(b, dict) and b.get("type") == "tool_use"
            and b.get("id") == tid and isinstance(b.get("input"), dict) and isinstance(b["input"].get("prompt"), str)]
    try:
        s = digest(sent[0]) if len(sent) == 1 else None
    except UnicodeEncodeError:
        s = None
    print(f"sent prompt (the session's Agent call {q(tid)}): " + (
        f"bytes={s[0]} sha256={s[1]} ({'equal to' if s[1] == sha else 'differs from'} the first task message)" if s
        else f"not read ({len(sent)} such calls with a prompt string in {session})"))
    log_dir = os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard"
    linked = [r for name in sorted(glob.glob(os.path.join(glob.escape(log_dir), "*.jsonl")))
              for r in (tolerant(name, [tid.encode()]) or []) if r.get("tool_use_id") == tid]
    found = []
    for r in linked:
        m = LAUNCH_SHA.search(r.get("detail") if isinstance(r.get("detail"), str) else "")
        found.append((r, m.group(1) if m else None))
        print(f"guard record #{q(r.get('n'))} {q(r.get('event'))} {q(r.get('tool'))} {q(r.get('decision'))} rule "
              f"{q(r.get('rule'))}" + (f" prompt_sha256={m.group(1)}" if m else " (no prompt_sha256)"))
    t5 = [(r, h) for r, h in found if r.get("rule") == "T5" and r.get("decision") == "allow"]
    same = [r for r, h in t5 if h == sha]
    if same:
        if item is not None and item_problem():
            return fail("LAUNCH-ITEM", item_problem())
        print(f"T5 allow record #{q(same[0].get('n'))} carries the first task message's SHA-256")
        print("LAUNCH CONFIRMED")
        return 0
    if t5:
        return fail("LAUNCH-MISMATCH", f"the linked T5 allow record #{q(t5[0][0].get('n'))} carries another SHA-256")
    t5r = [(r, h) for r, h in found if r.get("rule") == "T5R" and r.get("decision") == "allow"]
    if not t5r:
        return fail("LAUNCH-NORECORD", f"no T5 allow record for {q(tid)} in {log_dir} ({len(linked)} linked records)")
    # A T5R allow decides (W-C02-24.1 B4): the type comes from the platform-written meta.json only, never a record.
    kind = meta.get("agentType")
    if not isinstance(kind, str) or not kind:
        return fail("LAUNCH-NOTYPE", "the linked record is a T5R allow and the meta names no agentType string, so the "
                    "run's type is unknown")
    print(f"agentType (meta.json): {json.dumps(kind, ensure_ascii=False)}")
    if kind != "test-designer":
        return fail("LAUNCH-T5R", "the linked record is a T5R allow: the run was launched in the reader form")
    same = [r for r, h in t5r if h == sha]
    if not same:
        return fail("LAUNCH-T5R-MISMATCH", f"the linked T5R allow record #{q(t5r[0][0].get('n'))} of this test "
                    "designer carries another SHA-256 or none")
    print(f"T5R allow record #{q(same[0].get('n'))} carries the first task message's SHA-256")
    if item is None:
        return fail("LAUNCH-NOITEM", "a test designer is confirmed only with --item <the verdict's item>")
    forms = [m for m in map(T5_FORM.match, lines) if m]
    word = forms[0].group(1).lower() if len(forms) == 1 else None
    if word not in ("writer", "reader"):
        return fail("LAUNCH-FORM", f"{len(forms)} Writer or reader: lines" + (
            ", whose first word is neither writer nor reader" if len(forms) == 1 else "; exactly one is read"))
    print(f"form line: {word}")
    if word == "reader":
        return fail("LAUNCH-READER", "the test designer was launched in the reader form")
    if item_problem():
        return fail("LAUNCH-ITEM", item_problem())
    print(f"TEST-DESIGNER CONFIRMED: {item} (test and oracle paths only)")
    return 0


def main(argv):
    sys.stdout.reconfigure(encoding="utf-8", errors="backslashreplace")
    try:
        if len(argv) == 2 and argv[0] == "last":
            return last(argv[1])
        if len(argv) == 2 and argv[0] == "calls":
            return calls(argv[1])
        if len(argv) == 3 and argv[0] == "audit":
            return audit(argv[1], argv[2])
        if len(argv) == 2 and argv[0] == "disciplines":
            return disciplines(argv[1])
        if len(argv) == 2 and argv[0] == "launch":
            return launch(argv[1])
        if len(argv) == 4 and argv[0] == "launch" and argv[2] == "--item" and ITEM_ID.fullmatch(argv[3]):
            return launch(argv[1], argv[3])
        print(USAGE, file=sys.stderr)
    except NotFinished as e:
        print(f"subagent_audit: NOT FINISHED: {e}", file=sys.stderr)
        return 3
    except Error as e:
        print(f"subagent_audit: {e}", file=sys.stderr)
    return 2


if __name__ == "__main__":
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)   # a reader that stops early (head) is not an error
    sys.exit(main(sys.argv[1:]))
