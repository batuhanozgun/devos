#!/usr/bin/env python3
"""PreToolUse hook for DevOS sessions (Builder Operating Model, section 9).

1. MCP allow list: only the listed servers' tools may run. Every other mcp__
   tool is blocked, including account connectors (mail, calendar, files, ...).
   In builder-created sessions those appear under opaque IDs, so a deny list
   by display name cannot catch them (review R-C00-BOM-1, probe T-H3).
2. GitHub write scope: GitHub tools may write only to the repositories in
   WRITE_REPOS. Read-only GitHub tools may read any repository. Repository
   creation and forking are blocked.

Exit code 2 blocks the call. Every error path also returns 2 (fail closed).
Depends on python3 being available in the session image.
"""
import json
import sys

ALLOWED_PREFIXES = (
    "mcp__github__",                                    # GitHub as the machine account
    "mcp__claude-code-remote__",                        # session, routine and repo tools
    "mcp__Supabase_DevOS_Salt-okuma__",                 # read-only Supabase, display name (builder's first session)
    "mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__",      # same connector under its opaque ID (T-H3)
)

WRITE_REPOS = {("batuhanozgun", "devos")}

READ_ONLY_GITHUB = {"get_me", "pull_request_read", "issue_read"}
READ_ONLY_GITHUB_PREFIXES = ("get_", "list_", "search_")
BLOCKED_GITHUB = {"create_repository", "fork_repository"}


def block(msg: str) -> int:
    print(f"tool_allowlist: {msg} (Builder Operating Model, section 9).", file=sys.stderr)
    return 2


def check(data) -> int:
    if not isinstance(data, dict):
        return block("hook input is not an object; blocking")
    name = data.get("tool_name")
    if not isinstance(name, str) or not name:
        return block("missing tool name; blocking")
    if not name.startswith("mcp__"):
        return 0
    if not name.startswith(ALLOWED_PREFIXES):
        return block(f"'{name}' is not an allowed MCP server for DevOS sessions")
    if name.startswith("mcp__github__"):
        tool = name[len("mcp__github__"):]
        if tool in BLOCKED_GITHUB:
            return block(f"'{tool}' is not allowed for DevOS sessions")
        if tool in READ_ONLY_GITHUB or tool.startswith(READ_ONLY_GITHUB_PREFIXES):
            return 0
        args = data.get("tool_input") or {}
        if not isinstance(args, dict):
            return block("GitHub tool input is not an object; blocking")
        owner, repo = args.get("owner"), args.get("repo")
        if (owner, repo) not in WRITE_REPOS:
            return block(f"GitHub write tool '{tool}' targets {owner}/{repo}, which DevOS may not write")
    return 0


def main() -> int:
    try:
        return check(json.load(sys.stdin))
    except Exception as exc:  # fail closed on any error
        return block(f"hook error {type(exc).__name__}; blocking")


if __name__ == "__main__":
    sys.exit(main())
