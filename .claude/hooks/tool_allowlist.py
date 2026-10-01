#!/usr/bin/env python3
"""PreToolUse hook: allow only listed MCP servers; block every other mcp__ tool.

Why: account connectors (mail, calendar, files, ...) must never be used by
DevOS sessions (plan 0.5, K-9; Builder Operating Model section 9). A deny
list misses connectors added later; this is an allow list, enforced by the
Claude Code harness, not by the model.
Exit code 2 blocks the call and returns the message to the model.
"""
import json
import sys

ALLOWED_PREFIXES = (
    "mcp__github__",                      # GitHub as the machine account
    "mcp__claude-code-remote__",          # session, routine and repo tools
    "mcp__Supabase_DevOS_Salt-okuma__",   # read-only Supabase (database-enforced)
)

def decide(tool_name: str) -> bool:
    if not tool_name.startswith("mcp__"):
        return True
    return tool_name.startswith(ALLOWED_PREFIXES)

def main() -> int:
    try:
        data = json.load(sys.stdin)
    except Exception:
        print("tool_allowlist: unreadable hook input; blocking", file=sys.stderr)
        return 2
    name = str(data.get("tool_name", ""))
    if decide(name):
        return 0
    print(f"tool_allowlist: '{name}' is not an allowed MCP server for DevOS sessions "
          "(Builder Operating Model, section 9).", file=sys.stderr)
    return 2

if __name__ == "__main__":
    sys.exit(main())
