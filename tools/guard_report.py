#!/usr/bin/env python3
"""guard_report.py: what the guard decided in a session, for its log entry (W-C00-12.6 (c); D-008).

The guard (.claude/hooks/tool_allowlist.py) appends every decision to <log dir>/<session>.jsonl. This prints
the denials in full and the allowed calls counted by rule, so that a run's log entry records every denial
with its rule and reason (operating model section 11). Only summaries are printed: the guard already
redacted credentials, and the session's transcript keeps the full call under the logged tool-use ID.

Usage: tools/guard_report.py [--session ID] [--since 2026-10-04T17:00Z] [--dir DIR]
The session defaults to this cloud session ($CLAUDE_CODE_REMOTE_SESSION_ID, cse_ read as session_);
the directory to $DEVOS_GUARD_LOG_DIR or /tmp/devos-guard.
"""
import argparse
import json
import os
import signal
import sys
from collections import Counter


def main(argv=None):
    ap = argparse.ArgumentParser(prog="guard_report.py")
    env = os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID", "")
    ap.add_argument("--session", default="session_" + env[4:] if env.startswith("cse_") else env)
    ap.add_argument("--since", default="")
    ap.add_argument("--dir", default=os.environ.get("DEVOS_GUARD_LOG_DIR") or "/tmp/devos-guard")
    a = ap.parse_args(argv)
    sid = "session_" + a.session[4:] if a.session.startswith("cse_") else a.session
    names = [f for f in sorted(os.listdir(a.dir)) if f.endswith(".jsonl")] if os.path.isdir(a.dir) else []
    if sid:
        names = [f for f in names if f[:-6] == sid]
    if not names:
        print(f"GUARD REPORT: no decision log for session '{sid or 'any'}' in {a.dir}")
        return 1
    since = a.since.replace("Z", "")
    denials, allowed, passed = [], Counter(), 0
    for name in names:
        with open(os.path.join(a.dir, name)) as f:
            for line in f:
                try:
                    r = json.loads(line)
                except ValueError:
                    continue
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
    for r in denials:
        first = (r.get("reason") or "").split("\n")[0]
        print(f"- {r.get('time')} #{r.get('n')} {r.get('event') or 'PreToolUse'} {r.get('tool')} "
              f"(tool use {r.get('tool_use_id') or '-'}): {first} What matched: {r.get('detail')}. "
              f"Call: {r.get('summary')}")
    return 0


if __name__ == "__main__":
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)   # a reader that stops early (head) is not an error
    sys.exit(main())
