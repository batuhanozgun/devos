#!/usr/bin/env python3
"""guard_report.py: what the guard decided in a session, for its log entry (W-C00-12.6 (c); D-008).

The guard (.claude/hooks/tool_allowlist.py) appends every decision to <log dir>/<session>.jsonl. This prints
the denials in full and the allowed calls counted by rule, so that a run's log entry records every denial
with its rule and reason (operating model section 11). Only summaries are printed: the guard already
redacted credentials, and the session's transcript keeps the full call under the logged tool-use ID.
Each record names the hash of the record before it, so a record edited or removed inside the log shows as a
broken chain. Records removed from the end, or a deleted log, do not show: the report prints the last record
number, which the session states in its log entry. The log is written in the audited session's own container;
the transcript on the platform is the independent record.

Usage: tools/guard_report.py [--session ID] [--since 2026-10-04T17:00Z] [--dir DIR]
The session defaults to this cloud session ($CLAUDE_CODE_REMOTE_SESSION_ID, cse_ read as session_);
the directory to $DEVOS_GUARD_LOG_DIR or /tmp/devos-guard.
"""
import argparse
import hashlib
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


if __name__ == "__main__":
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)   # a reader that stops early (head) is not an error
    sys.exit(main())
