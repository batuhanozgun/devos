#!/usr/bin/env python3
"""guard_report.py: what the guard decided in a session, for its log entry (W-C00-12.6 (c); D-008), and with
--liveness whether this session's agent hooks were live (W-C02-25; SB-COR 3.5).

The guard (.claude/hooks/tool_allowlist.py) appends every decision to <log dir>/<session>.jsonl. This prints
the denials in full and the allowed calls counted by rule, so that a run's log entry records every denial
with its rule and reason (plan/Installation_Working_Order.md section 9). Only summaries are printed: the guard already
redacted credentials, and the session's transcript keeps the full call under the logged tool-use ID.
Each record names the hash of the record before it, so a record edited or removed inside the log shows as a
broken chain. Records removed from the end, or a deleted log, do not show: the report prints the last record
number, which the session states in its log entry. The log is written in the audited session's own container;
the transcript on the platform is the independent record.

Usage: tools/guard_report.py [--session ID] [--since 2026-10-04T17:00Z] [--dir DIR]
       tools/guard_report.py --liveness [--dir DIR] [--session ID]
The session key is the guard's session_key (one function, imported from this checkout's guard): by default this
cloud session's ($CLAUDE_CODE_REMOTE_SESSION_ID, cse_ read as session_), a given --session read the same way; with no
cloud session and no --session the report reads every log in the directory. The directory is $DEVOS_GUARD_LOG_DIR or
/tmp/devos-guard.

--liveness reads this checkout's .claude/settings.json and plan/ledger/, the session's registry
(<dir>/<key>.agents, written by .claude/hooks/agent_hooks.py) and guard log, and the transcripts under
$DEVOS_AUDIT_HOME as tools/subagent_audit.py reads them. It prints: `MISSING <path>` for each hook command path that
does not exist; `SELFTEST PASS` or `SELFTEST FAIL: <why>` for a run of the hook commands as settings.json holds them,
in a scratch log directory that is removed afterwards (never the live registry); the executor's session_start
records; per finished run (the platform's end status, as subagent_audit.py's end_problem reads it) after the cutoff
(the registry's first record) a `RUN` line with its item, start, stop outcomes and receipts; and the flags, one line
each with the agent ID: `NO_START` (an agent in the guard log or a launch record, with a platform meta file and no
start record; one with no meta file is internal and excluded), `BLOCK_NO_STOP` (a run whose last stop was a block),
`NOT_DELIVERED` (a first run with no stop whose receipt is delivered). A line `- **Liveness:** <agent id>: <reason>`
in the newest log entry exempts that agent (`EXEMPT`). Running runs and runs that finished before the cutoff are named
and not counted. The last line is `LIVENESS PASS` (exit 0), `LIVENESS FAIL` (exit 1) or `LIVENESS COULD NOT CHECK:
<why>` (exit 2). Its claim is narrow: the scripts are present and working, and the hooks were live as of the last
finished run's records; re-read it after a worker restart.
"""
import argparse
import glob
import hashlib
import importlib.machinery
import importlib.util
import json
import os
import re
import shutil
import signal
import subprocess
import sys
import tempfile
import uuid
from collections import Counter

sys.dont_write_bytecode = True
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))   # this checkout
FLAGS = ("NO_START", "BLOCK_NO_STOP", "NOT_DELIVERED")
EXCLUDED = ("not matched by the hooks, so not counted: internal agents (no meta file), counter-designer, the built-in "
            "types (general-purpose, Explore, Plan, claude, fork and others) and workflow agents")


def load(rel, name):
    ldr = importlib.machinery.SourceFileLoader(name, os.path.join(ROOT, rel))
    mod = importlib.util.module_from_spec(importlib.util.spec_from_loader(name, ldr))
    ldr.exec_module(mod)
    return mod


def guard():
    return load(os.path.join(".claude", "hooks", "tool_allowlist.py"), "devos_guard_for_guard_report")


def report(a, sid):
    names = [f for f in sorted(os.listdir(a.dir)) if f.endswith(".jsonl")] if os.path.isdir(a.dir) else []
    if sid:
        names = [f for f in names if f[:-6] == sid]
    if not names:
        print(f"GUARD REPORT: no decision log for session '{sid or 'any'}' in {a.dir}")
        return 1
    since = a.since.replace("Z", "")
    denials, allowed, passed, breaks, efforts, last = [], Counter(), 0, [], Counter(), 0
    for name in names:
        prev = b""
        with open(os.path.join(a.dir, name), "rb") as f:
            for raw in f.read().splitlines():
                try:
                    r = json.loads(raw)
                except ValueError:
                    breaks.append(f"{name}: an unreadable line")
                    prev = raw
                    continue
                want = hashlib.sha256(prev).hexdigest() if prev else ""
                if r.get("prev", "") != want:  # each record names the hash of the one before it
                    breaks.append(f"{name} #{r.get('n')}")
                prev = raw
                last = max(last, r.get("n") or 0)
                efforts[r.get("effort") or "not reported"] += 1
                if since and str(r.get("time", "")).replace("Z", "") < since:
                    continue
                if r.get("decision") == "deny":
                    denials.append(r)
                elif r.get("decision") == "allow":
                    allowed[r.get("rule")] += 1
                else:
                    passed += 1
    print(f"GUARD REPORT: {', '.join(names)}{' since ' + a.since if a.since else ''}: "
          f"{len(denials)} denied, {sum(allowed.values())} allowed, {passed} passed to the user")
    print("Allowed by rule: " + (", ".join(f"{k} {v}" for k, v in sorted(allowed.items())) or "none"))
    print("Effort reported by the harness: " + ", ".join(f"{k} {v}" for k, v in sorted(efforts.items())))
    print("Hash chain: " + ("intact" if not breaks else "BROKEN at " + ", ".join(breaks[:10]) +
                            " (a record was edited or removed inside the log, or written by something else)"))
    print(f"Last record: #{last} (state it in the log entry; a later report with a lower number shows records "
          "removed from the end, which the chain alone cannot show)")
    for r in denials:
        first = (r.get("reason") or "").split("\n")[0]
        print(f"- {r.get('time')} #{r.get('n')} {r.get('event') or 'PreToolUse'} {r.get('tool')} "
              f"(tool use {r.get('tool_use_id') or '-'}): {first} What matched: {r.get('detail')}. "
              f"Call: {r.get('summary')}")
    return 0


# ---------------------------------------------------------------- liveness (W-C02-25)

def hook_commands(settings):
    """[(event, matcher, command)] of every hook command in settings.json."""
    return [(ev, e.get("matcher"), h.get("command", "")) for ev, entries in (settings.get("hooks") or {}).items()
            for e in entries for h in e.get("hooks", [])]


def missing_paths(settings):
    paths = [p for _, _, c in hook_commands(settings) for p in re.findall(r"\$CLAUDE_PROJECT_DIR/([^\"'\s]+)", c)]
    return [p for p in dict.fromkeys(paths) if not os.path.isfile(os.path.join(ROOT, p))]


def selftest(settings, ah):
    """None when the hook commands, as settings.json holds them, write a launch, deliver a start and block an
    incomplete stop in a scratch log directory; else why not. The scratch directory is removed afterwards."""
    cmds = {ev: c for ev, _, c in hook_commands(settings) if "agent_hooks.py" in c}
    if set(cmds) < {"PostToolUse", "SubagentStart", "SubagentStop"}:
        return f"settings.json has agent_hooks.py commands only for {sorted(cmds)}"
    d = tempfile.mkdtemp(prefix="devos-liveness-selftest-")
    try:
        env = {k: v for k, v in os.environ.items() if k != "CLAUDE_CODE_REMOTE_SESSION_ID"}
        env.update(CLAUDE_PROJECT_DIR=ROOT, DEVOS_GUARD_LOG_DIR=d, PYTHONDONTWRITEBYTECODE="1",
                   CLAUDE_CODE_REMOTE_SESSION_ID="cse_livenessselftest")
        aid = "selftest" + uuid.uuid4().hex[:12]

        def run(ev, payload):
            p = subprocess.run(["bash", "-c", cmds[ev]], input=json.dumps(payload).encode(), capture_output=True,
                               env=env, cwd=ROOT, timeout=60)
            return p.stdout.decode("utf-8", "replace")
        run("PostToolUse", {"session_id": "selftest", "hook_event_name": "PostToolUse", "tool_name": "Agent",
                            "agent_id": None, "tool_use_id": "toolu_selftest",
                            "tool_input": {"subagent_type": "producer", "prompt": "Writer or reader: reader\n"
                                           "Item: plan/work/W-C02-25.md\n"},
                            "tool_response": {"status": "async_launched", "agentId": aid}})
        out = run("SubagentStart", {"session_id": "selftest", "hook_event_name": "SubagentStart", "agent_id": aid,
                                    "agent_type": "producer"})
        try:
            ctx = json.loads(out)["hookSpecificOutput"]["additionalContext"]
        except (ValueError, KeyError, TypeError):
            return "the start hook delivered no additionalContext"
        lines = ctx.split("\n")
        with open(os.path.join(ROOT, ".claude", "roles", "producer.md"), "rb") as f:
            sha12 = hashlib.sha256(f.read()).hexdigest()[:12]
        crp = load(os.path.join("tools", "check_role_packages.py"), "devos_role_packages_for_guard_report")
        if lines[0] != crp.HEADER.format(role="producer", sha12=sha12) or \
                not re.fullmatch(r"Nonce: [0-9a-f]{16}", lines[-1]):
            return "the start hook's context lacks the header or the last Nonce: line"
        out = run("SubagentStop", {"session_id": "selftest", "hook_event_name": "SubagentStop", "agent_id": aid,
                                   "agent_type": "producer", "stop_hook_active": False,
                                   "last_assistant_message": "selftest: an incomplete report"})
        try:
            blocked = json.loads(out).get("decision") == "block"
        except (ValueError, AttributeError):
            blocked = False
        if not blocked:
            return "the stop hook did not block an incomplete report"
        recs = ah.read_registry(os.path.join(d, "session_livenessselftest.agents"))
        if [r.get("event") for r in recs] != ["launch", "start", "stop"] or \
                any(tuple(r) != ah.KEYS for r in recs) or recs[1].get("run") != 1:
            return f"the scratch registry holds {[r.get('event') for r in recs]}, not launch, start, stop"
        return None
    except Exception as e:   # noqa: BLE001  a self-test that cannot run is a failure, never a pass
        return f"{type(e).__name__}: {e}"
    finally:
        shutil.rmtree(d, ignore_errors=True)


def exemptions():
    """{agent id: reason} from the `- **Liveness:** <id>: <reason>` lines of the newest log entry."""
    entries = {}
    for p in sorted(glob.glob(os.path.join(ROOT, "plan", "ledger", "*-log.md"))):
        cur = None
        with open(p, encoding="utf-8") as f:
            for line in f.read().splitlines():
                if re.match(r"#{1,3} ", line):
                    h = re.match(r"### L-(\d+) ", line)
                    cur = entries.setdefault(int(h.group(1)), []) if h else None
                elif cur is not None:
                    cur.append(line)
    if not entries:
        return {}
    return {m.group(1): m.group(2) for line in entries[max(entries)]
            for m in [re.match(r"- \*\*Liveness:\*\* ([A-Za-z0-9_-]+): (.+)$", line)] if m}


def guard_log_agents(path):
    out = []
    try:
        with open(path, "rb") as f:
            for raw in f.read().splitlines():
                try:
                    r = json.loads(raw)
                except ValueError:
                    continue
                if isinstance(r, dict) and isinstance(r.get("agent_id"), str) and r["agent_id"]:
                    out.append(r["agent_id"])
    except OSError:
        pass
    return list(dict.fromkeys(out))


def end_time(sa, path, run, agent):
    """The latest timestamp of the records that hold the agent's ID where its end status is recorded, or None."""
    where = os.path.join(os.path.dirname(path), "journal.jsonl") if run is not None else \
        os.path.dirname(os.path.dirname(path)) + ".jsonl"
    stamps = [str(e.get("timestamp") or e.get("time") or "") for e in (sa.tolerant(where, [agent.encode()]) or [])]
    stamps = [s for s in stamps if s]
    return max(stamps) if stamps else None


def runs_of(recs, aid):
    """[(start record, [its stop records])] of an agent, in order."""
    out = []
    for r in recs:
        if r.get("agent_id") != aid:
            continue
        if r.get("event") == "start":
            out.append((r, []))
        elif r.get("event") == "stop" and out:
            out[-1][1].append(r)
    return out


def liveness(a, key):
    lines, fail = [], False
    try:
        with open(os.path.join(ROOT, ".claude", "settings.json"), encoding="utf-8") as f:
            settings = json.load(f)
    except (OSError, ValueError) as e:
        print(f"LIVENESS COULD NOT CHECK: cannot read .claude/settings.json ({e})")
        return 2
    print(f"LIVENESS: session {key}, directory {a.dir}, checkout {ROOT}")
    for p in missing_paths(settings):
        print(f"MISSING {p} (a hook command path in .claude/settings.json)")
        fail = True
    try:
        ah = load(os.path.join(".claude", "hooks", "agent_hooks.py"), "devos_agent_hooks_for_guard_report")
        sa = load(os.path.join("tools", "subagent_audit.py"), "devos_subagent_audit_for_guard_report")
    except Exception as e:   # noqa: BLE001
        print(f"LIVENESS {'FAIL' if fail else 'COULD NOT CHECK: cannot load the hook or subagent_audit.py'}"
              f"{'' if fail else f' ({type(e).__name__})'}")
        return 1 if fail else 2
    why = selftest(settings, ah)
    print("SELFTEST PASS (the hook commands, in a scratch log directory)" if why is None else f"SELFTEST FAIL: {why}")
    fail = fail or why is not None
    reg = os.path.join(a.dir, f"{key}.agents")
    recs, cnc = [], None
    if os.path.exists(reg):
        try:
            recs = ah.read_registry(reg)
        except ah.Unreadable as e:
            cnc = f"the registry {reg} cannot be read ({e})"
    else:
        print(f"registry: none at {reg} (no hook has written a record for this session)")
    cutoff = recs[0].get("time") if recs else None
    print(f"cutoff: {cutoff or 'none'} (the registry's first record; a run that finished before it is not counted)")
    for r in recs:
        if r.get("event") == "session_start":
            print(f"session_start {r.get('time')} source {r.get('outcome')} package {r.get('package')}")
    if not any(r.get("event") == "session_start" for r in recs):
        print("session_start: none recorded (SessionStart fires at startup, resume, clear, compact and fork)")
    print(f"excluded: {EXCLUDED}")
    exempt = exemptions()
    view = ah.merged_view(recs)
    for aid in list(dict.fromkeys(list(view) + guard_log_agents(os.path.join(a.dir, f"{key}.jsonl")))):
        v = view.get(aid, {})
        try:
            path, wrun = sa.transcript(aid)
        except sa.Error:
            print(f"not counted {aid}: no single transcript under $DEVOS_AUDIT_HOME (running elsewhere or unknown)")
            continue
        started = v.get("runs", 0) > 0
        if not started and not os.path.isfile(path[:-len(".jsonl")] + ".meta.json"):
            print(f"excluded {aid}: internal (no platform meta file)")
            continue
        try:
            why = sa.end_problem(path, wrun, aid)
        except sa.Error as e:
            why = str(e)
        if why:
            print(f"running {aid}: not counted ({why})")
            continue
        end = end_time(sa, path, wrun, aid)
        if cutoff and end and end[:19] < cutoff[:19]:
            print(f"before cutoff {aid}: finished {end}; not counted")
            continue
        flags, runs = [], runs_of(recs, aid)
        if not started:
            flags.append("NO_START")
            print(f"RUN {aid} type {v.get('agent_type')} item {v.get('item') or 'none'} start none stop none")
        for n, (start, stops) in enumerate(runs, 1):
            outcomes = ",".join(str(s.get("outcome")) for s in stops) or "none"
            receipts = ",".join(str(s.get("receipt")) for s in stops) or "none"
            print(f"RUN {aid} run {n} type {start.get('agent_type')} item {v.get('item') or 'none'} start "
                  f"{start.get('outcome')} package {start.get('package')} stop {outcomes} receipt {receipts}")
            if stops and stops[-1].get("outcome") == "block":
                flags.append("BLOCK_NO_STOP")
            if n == 1 and not any(s.get("receipt") == "delivered" for s in stops):
                flags.append("NOT_DELIVERED")
        if aid in exempt:
            print(f"EXEMPT {aid}: {exempt[aid]} ({len(set(flags))} flag kinds waived by the newest log entry)")
            continue
        for fl in dict.fromkeys(flags):
            print(f"{fl} {aid}")
            fail = True
    print("claim: scripts present and working; hooks live as of the last finished run's records "
          "(re-read after a worker restart)")
    if fail:
        print("LIVENESS FAIL")
        return 1
    if cnc:
        print(f"LIVENESS COULD NOT CHECK: {cnc}")
        return 2
    print("LIVENESS PASS")
    return 0


def main(argv=None):
    ap = argparse.ArgumentParser(prog="guard_report.py")
    ap.add_argument("--session", default=None)
    ap.add_argument("--since", default="")
    ap.add_argument("--dir", default=os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard")
    ap.add_argument("--liveness", action="store_true")
    a = ap.parse_args(argv)
    g = guard()
    if a.session is not None:
        sid = g.key_of(a.session) if a.session else ""   # --session "" reads every log, as before
        if a.liveness and not sid:
            print("LIVENESS COULD NOT CHECK: --liveness needs one session")
            return 2
    elif os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID") or a.liveness:
        sid = g.session_key({})
    else:
        sid = ""
    return liveness(a, sid) if a.liveness else report(a, sid)


if __name__ == "__main__":
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)   # a reader that stops early (head) is not an error
    sys.exit(main())
