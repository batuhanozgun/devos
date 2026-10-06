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

  last <agent-id>               the text of the agent's last assistant event that has text, as stored, followed by
                                one newline (how checker verdicts are filed verbatim)
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

audit and calls print tool names, path arguments (Read file_path; Glob path and pattern; Grep path and glob) and the
input key names of any other tool; never file content, tool output or prompt text. Strings are printed JSON-quoted,
so that no argument can forge an output line. Exit codes: 0 done (audit: valid), 1 audit void, 2 usage or reading
error. Locations: $DEVOS_AUDIT_HOME (default: the home directory), $DEVOS_GUARD_LOG_DIR (default /tmp/devos-guard).
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
NEEDED = {"file_path", "path"}       # absent: Read has no file; Glob or Grep searches the session's working directory
PATTERNS = {"pattern", "glob"}       # relative to the call's path unless they start with /
USAGE = "usage: subagent_audit.py last <agent-id> | calls <agent-id> | audit <agent-id> <workspace>"


class Error(Exception):
    pass


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


def last(agent):
    _, events = jsonl(transcript(agent)[0])
    for e in reversed(events):
        m = e.get("message")
        if e.get("type") == "assistant" and isinstance(m, dict) and isinstance(m.get("content"), list):
            texts = [b["text"] for b in m["content"]
                     if isinstance(b, dict) and b.get("type") == "text" and isinstance(b.get("text"), str)]
            if any(t.strip() for t in texts):
                print("\n".join(texts))
                return 0
    raise Error(f"agent {agent} has no assistant event with text")


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
    log_dir = os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard"
    logs = sorted(glob.glob(os.path.join(glob.escape(log_dir), "*.jsonl")))
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


def main(argv):
    sys.stdout.reconfigure(encoding="utf-8", errors="backslashreplace")
    try:
        if len(argv) == 2 and argv[0] == "last":
            return last(argv[1])
        if len(argv) == 2 and argv[0] == "calls":
            return calls(argv[1])
        if len(argv) == 3 and argv[0] == "audit":
            return audit(argv[1], argv[2])
        print(USAGE, file=sys.stderr)
    except Error as e:
        print(f"subagent_audit: {e}", file=sys.stderr)
    return 2


if __name__ == "__main__":
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)   # a reader that stops early (head) is not an error
    sys.exit(main(sys.argv[1:]))
