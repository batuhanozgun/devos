C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13).

# P4 item 1: plugins and user-level skills

Read as data, with readers only (`du`, `ls`, `grep`, `wc`, piped through `cut`, `sed`, `sort`, `uniq`, `awk`); every count below is from a full output shown in the session (none was saved to a file). The session cannot see the account's settings: these folders are what reached the session.

## User-level plugins folder `~/.claude/plugins`

- Readable. The listing command of P4 item 1 (`du -a … | sed -E -n …`) printed nothing: no `SKILL.md`, `plugin.json`, `hooks.json`, `.mcp.json` or `agents/*.md` at or below the third level.
- The whole folder holds 4 entries (`du -a`): the folder itself; one subfolder `synced`; in it, one folder (the sync folder; its name is account identifiers, written here as `<sync folder>`), which is empty (4 KB, no entries), and one empty file `.bucket-<sync folder>` (0 bytes).
- Plugin folders: 0 (in `synced`: 0; no `.trash` subfolder). Distinct plugins: 0.
- So, per plugin: no skills, no agent definitions, no MCP configuration, no hooks file and no `hooks` key; the `jq` hooks and `mcpServers` tests had no file to run on and were not run.

## User-level skills folder `~/.claude/skills`

- Readable. Skills (`SKILL.md` files one level below a folder that holds skill folders): 25 in total.
  - `skills/` (the top level): 1.
  - `synced/other-folder-1` (a sync folder named by account identifiers): 24.
- Each of the 25 has a `name:` line (P4 item 3).

## User-level agents

- `~/.claude/agents`: no agent definition file (`ls` shows 0 entries).

## Which of it the session offers

- Skills the session offers: 42. By origin: repository 1; built-in 16 (no `SKILL.md` for them in either user-level folder); plugin 0; user-level skills folder 25 (top level 1, `synced/other-folder-1` 24).
- The user-level skills folder's skills are offered in full: 25 of 25, each matched by its `name:` line to a name the session lists (24 listed with one shared `<prefix>:` before the name; 1 listed by its folder name, with its `name:` line in parentheses).
- Agent types the Agent tool offers: 11. By origin: repository 5; built-in 6; plugin 0; user-level 0.
- MCP servers: 3, all the platform's own or built in (`claude-code-remote`, `github`, `ccd_session`); from plugins 0.
- Per plugin: none (no plugin present), so no plugin's skills, agent types or MCP servers are offered, in full or in part.
