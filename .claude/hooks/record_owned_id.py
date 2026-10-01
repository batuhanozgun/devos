#!/usr/bin/env python3
"""PostToolUse hook: when this session creates a session or a routine, append the
returned ID to owned_ids.txt automatically (R-C00-BOM-4 M2). The model never
has to add IDs by hand, so a hand edit of owned_ids.txt is never routine and
stays a high-impact change. Never blocks; on any doubt it records nothing.
"""
import json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
WATCH = {"mcp__claude-code-remote__create_session": r'"id"\s*:\s*"(session_[A-Za-z0-9]+)"',
         "mcp__claude-code-remote__create_trigger": r'"id"\s*:\s*"(trig_[A-Za-z0-9]+)"'}

def main():
    try:
        d = json.load(sys.stdin)
        pat = WATCH.get(d.get("tool_name"))
        if not pat:
            return 0
        resp = d.get("tool_response")
        text = resp if isinstance(resp, str) else json.dumps(resp)
        m = re.search(pat, text)
        if not m:
            return 0
        path = os.path.join(HERE, "owned_ids.txt")
        with open(path) as f:
            ids = {l.strip() for l in f}
        if m.group(1) not in ids:
            with open(path, "a") as f:
                f.write(m.group(1) + "\n")
    except Exception:
        pass
    return 0

if __name__ == "__main__":
    sys.exit(main())
