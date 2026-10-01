#!/usr/bin/env python3
# PROBE ONLY (branch claude/probe-hook): block any tool whose name ends in "__get_me", to prove hooks run in builder-created sessions.
import json, sys
try:
    d = json.load(sys.stdin)
    if str(d.get("tool_name", "")).endswith("__get_me"):
        print("selftest: blocked by temporary hook", file=sys.stderr)
        sys.exit(2)
except Exception:
    sys.exit(2)
sys.exit(0)
