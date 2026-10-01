#!/usr/bin/env python3
"""PreToolUse hook for DevOS sessions (Builder Operating Model, section 9).

1. MCP allow list: only the listed servers' tools may run; every other mcp__
   tool is blocked, including account connectors under opaque IDs.
2. GitHub write scope: GitHub write tools may target only batuhanozgun/devos;
   repository creation and forking are blocked.
3. Session-tool scope (R-C00-BOM-2 B1): new sessions only with a full
   checkout of devos in the builder's environment; repositories may be
   attached only as devos, or the library read-only; tools that act on an
   existing session or routine only for IDs in owned_ids.txt; routines
   never with connectors.
4. Non-MCP surfaces that publish or reach account data (artifacts, design
   sync) are blocked.

Exit code 2 blocks. Every error path that runs inside this script returns 2.
The settings command wraps the script so that any other non-zero exit
(syntax error, missing python3) is also turned into 2.
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BUILDER_ENV = "env_01AMBDuHjjTsXMeXFyYgk1zR"     # devos-kurulum
DEVOS_URL = re.compile(r"^https://github\.com/batuhanozgun/devos(\.git)?/?$", re.I)

ALLOWED_PREFIXES = (
    "mcp__github__",
    "mcp__claude-code-remote__",
    "mcp__Supabase_DevOS_Salt-okuma__",
    "mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__",   # read-only Supabase connector, opaque ID (inferred: T-H3)
)
BLOCKED_NON_MCP = {"Artifact", "ArtifactData", "ArtifactComments", "DesignSync"}

WRITE_REPOS = {("batuhanozgun", "devos")}
READ_ONLY_GITHUB = {"get_me", "pull_request_read", "issue_read", "actions_get", "actions_list"}
READ_ONLY_GITHUB_PREFIXES = ("get_", "list_", "search_")
REPOLESS_GITHUB_ALLOWED = {"resolve_review_thread", "unresolve_review_thread"}
BLOCKED_GITHUB = {"create_repository", "fork_repository"}

TARGETED_SESSION_TOOLS = {
    "send_message": "session_id", "archive_session": "session_id",
    "unarchive_session": "session_id", "interrupt_session": "session_id",
    "set_session_title": "session_id",
    "fire_trigger": "trigger_id", "update_trigger": "trigger_id",
    "delete_trigger": "trigger_id",
}


def block(msg):
    print(f"tool_allowlist: {msg} (Builder Operating Model, section 9).", file=sys.stderr)
    return 2


def owned_ids():
    with open(os.path.join(HERE, "owned_ids.txt")) as f:
        return {l.strip() for l in f if l.strip() and not l.startswith("#")}


def check_session_tool(tool, args):
    if tool == "create_session":
        if not DEVOS_URL.match(str(args.get("source_url", ""))):
            return block("create_session needs a full checkout of batuhanozgun/devos (source_url)")
        if args.get("sparse_checkout_paths"):
            return block("create_session with a sparse checkout runs without the barrier")
        if args.get("environment_id") not in (None, BUILDER_ENV):
            return block("create_session only in the builder environment")
        return 0
    if tool == "add_repo":
        owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
        if (owner, repo) == ("batuhanozgun", "devos"):
            return 0
        if (owner, repo) == ("batuhanozgun", "agentic-os-search") and args.get("access", "read") == "read":
            return 0
        return block(f"add_repo {owner}/{repo} with access {args.get('access', 'read')} is not allowed")
    if tool == "create_trigger":
        if args.get("connectors"):
            return block("routines may not carry connectors")
        return 0
    if tool == "set_session_tags":
        ids = args.get("session_ids") or []
        if not isinstance(ids, list) or not set(map(str, ids)) <= owned_ids():
            return block("set_session_tags only on builder-owned sessions")
        return 0
    if tool in TARGETED_SESSION_TOOLS:
        target = str(args.get(TARGETED_SESSION_TOOLS[tool], ""))
        if target not in owned_ids():
            return block(f"{tool} on '{target}', which is not a builder-owned ID (owned_ids.txt)")
        return 0
    return 0   # read-only and self-scoped session tools (get_*, list_*, send_later, ...)


def check(data):
    if not isinstance(data, dict):
        return block("hook input is not an object; blocking")
    name = data.get("tool_name")
    if not isinstance(name, str) or not name:
        return block("missing tool name; blocking")
    args = data.get("tool_input") or {}
    if not isinstance(args, dict):
        return block("tool input is not an object; blocking")
    if name in BLOCKED_NON_MCP:
        return block(f"'{name}' publishes or reaches account data")
    if not name.startswith("mcp__"):
        return 0
    if not name.startswith(ALLOWED_PREFIXES):
        return block(f"'{name}' is not an allowed MCP server for DevOS sessions")
    if name.startswith("mcp__claude-code-remote__"):
        return check_session_tool(name[len("mcp__claude-code-remote__"):], args)
    if name.startswith("mcp__github__"):
        tool = name[len("mcp__github__"):]
        if tool in BLOCKED_GITHUB:
            return block(f"'{tool}' is not allowed for DevOS sessions")
        if tool in READ_ONLY_GITHUB or tool.startswith(READ_ONLY_GITHUB_PREFIXES):
            return 0
        if tool in REPOLESS_GITHUB_ALLOWED and "repo" not in args:
            return 0
        owner, repo = str(args.get("owner", "")).lower(), str(args.get("repo", "")).lower()
        if (owner, repo) not in WRITE_REPOS:
            return block(f"GitHub write tool '{tool}' targets {owner}/{repo}, which DevOS may not write")
    return 0


def main():
    try:
        return check(json.load(sys.stdin))
    except Exception as exc:
        return block(f"hook error {type(exc).__name__}; blocking")


if __name__ == "__main__":
    sys.exit(main())
