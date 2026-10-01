# T-H3 probe: MCP tool prefixes and hook block on GitHub get_me

Date: 2026-10-01. Branch: claude/probe-hook-report.

## Step 1: MCP servers and tool-name prefixes (names only, none called)

ToolSearch query used: "github get_me".

| Prefix | Example tools |
|---|---|
| `mcp__github__` | `get_me`, `actions_get`, `add_issue_comment` |
| `mcp__claude-code-remote__` | `add_repo`, `create_session`, `send_later` |
| `mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__` | `execute_sql`, `list_tables`, `search_docs` (the read-only Supabase connector, by inference) |
| 9 further account connectors under opaque IDs | *redacted by the builder on 2026-10-01 (R-C00-BOM-2 M9): the list named third-party services on Batu's account; it is personal account metadata and not needed here* |


## Step 2: GitHub get_me call

Tool called: `mcp__github__get_me` (no arguments).

Exact result text:

```
PreToolUse:mcp__github__get_me hook error: [python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/selftest_block_get_me.py"]: selftest: blocked by temporary hook
```

Blocked by hook: yes ("selftest: blocked by temporary hook").
