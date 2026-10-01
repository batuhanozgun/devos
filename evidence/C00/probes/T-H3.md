# T-H3 probe: MCP tool prefixes and hook block on GitHub get_me

Date: 2026-10-01. Branch: claude/probe-hook-report.

## Step 1: MCP servers and tool-name prefixes (names only, none called)

ToolSearch query used: "github get_me".

| Prefix | Example tools |
|---|---|
| `mcp__github__` | `get_me`, `actions_get`, `add_issue_comment` |
| `mcp__claude-code-remote__` | `add_repo`, `create_session`, `send_later` |
| `mcp__1aad5c8b-b3ea-46da-9a96-aef41be5e5dc__` | `create_event`, `list_events`, `list_calendars` |
| `mcp__28a70be6-ee0d-46d7-a7f6-073a2f78850f__` | `query-docs`, `resolve-library-id` |
| `mcp__380de831-eccb-493e-a3eb-78ab449ff7af__` | `copy_file`, `create_file`, `search_files` |
| `mcp__86834617-a1d9-4f19-9bb1-96d74b1319ce__` | `execute_sql`, `list_tables`, `search_docs` |
| `mcp__9c01eb9f-d108-4a67-8a1c-59fbea9a1f7c__` | `create_draft`, `get_message`, `send_message` |
| `mcp__1a59c906-04da-521d-bda7-7f71b9f9e01c__` | `batch`, `guide`, `update` |
| `mcp__42732e05-b1be-4758-8bbb-90f2ff4e44ed__` | `get_account_info`, `get_meeting`, `search_meetings` |
| `mcp__48f556e8-e315-4d64-95d2-6884a27030c6__` | `generate`, `get_gammas`, `read_gamma` |
| `mcp__c50cf86e-bfcf-453a-8ce2-b6a1ded34198__` | `get_my_scores`, `get_career_paths`, `get_network_summary` |
| `mcp__c5c20b67-6dfb-42c1-a230-b1b5865cb66f__` | `get_design_context`, `use_figma`, `whoami` |

Server `5c0f8748-6290-4c01-98f4-4b15ba01f0de` reported as requiring authentication; no tools exposed.

## Step 2: GitHub get_me call

Tool called: `mcp__github__get_me` (no arguments).

Exact result text:

```
PreToolUse:mcp__github__get_me hook error: [python3 "$CLAUDE_PROJECT_DIR/.claude/hooks/selftest_block_get_me.py"]: selftest: blocked by temporary hook
```

Blocked by hook: yes ("selftest: blocked by temporary hook").
