# W-C02-11: step S0, the control for route (ii) (a fresh general-purpose subagent's own tool list, before the sync)

- **What:** EV-C02-006 section 4.4, step S0: a fresh `general-purpose` subagent (agent `af908111632a6a16b`; DISCIPLINES OK) given task T, before the bridge reached the live tree (`main` `db2ebd9`, the live tree's `.claude/settings.json` without the bridge).
- **When:** started about 18:07Z and finished by 18:10Z on 2026-10-12 (the guard's last record when its report was taken: #17679, 18:10:29Z).
- **Label:** observed, as the subagent's own report of its tool list (a self-report).
- **What is kept here.** The report's discipline block, its part (b) on the built-in tools, and every name it gave under the session-tools server's three names and under `ccd_session`, verbatim. The repository is public, so the names of the account's other connectors (outside this item's scope) are not listed: the report gave 653 other `mcp__` names under 23 other servers, all offered as deferred tools except three of one document server, loaded in full. The full report stays in the working session's scratchpad.

## Disciplines (D1–D9)
D1: uncertain: "Loaded in full" here means the tool's full schema is in my function list. "Deferred" means the name appears only in the deferred-tools system reminder. MCP servers that failed to connect or still need authentication have no tool names in my list, so I name them below only as servers.
D2: no
D3: yes: The goal was exact names only, so I called no tool to build the list. The only tool calls were reads of the discipline file, which the task required.
D4: yes: The per-server counts are my own tally of the list as shown to me and have not been checked independently, so treat them as a guide and the names as the data.
D5: yes: I give only names that are actually in my tool list or the deferred reminder. A later notice lists servers that need authentication, ending "…and 26 more"; it is truncated and is not part of the tool list, so I took no tool names from it.
D6: no
D7: no
D8: no
D9: no

## (b) Built-in tools from the list you gave
- `SendMessage`: present, **deferred**. This is separate from `mcp__claude-code-remote__send_message`, which is loaded in full.
- `RemoteTrigger`, `ListAgents`, `ReadNotifications`, `PushNotification`, `SendUserFile`, `ScheduleWakeup`, `CronCreate`, `CronList`, `CronDelete`: **not present**, either loaded or deferred.

## (a) The session-tools server and `ccd_session` (loaded in full)

```
mcp__ccd_session__dismiss_task
mcp__ccd_session__spawn_task
mcp__claude-code-remote__add_repo
mcp__claude-code-remote__archive_session
mcp__claude-code-remote__create_session
mcp__claude-code-remote__create_trigger
mcp__claude-code-remote__delete_trigger
mcp__claude-code-remote__fire_trigger
mcp__claude-code-remote__get_event
mcp__claude-code-remote__get_session
mcp__claude-code-remote__get_trigger
mcp__claude-code-remote__interrupt_session
mcp__claude-code-remote__list_environments
mcp__claude-code-remote__list_events
mcp__claude-code-remote__list_repos
mcp__claude-code-remote__list_sessions
mcp__claude-code-remote__list_triggers
mcp__claude-code-remote__read_documentation
mcp__claude-code-remote__register_repo_root
mcp__claude-code-remote__send_later
mcp__claude-code-remote__send_message
mcp__claude-code-remote__set_session_tags
mcp__claude-code-remote__set_session_title
mcp__claude-code-remote__subscribe_pr_activity
mcp__claude-code-remote__unarchive_session
mcp__claude-code-remote__unsubscribe_pr_activity
mcp__claude-code-remote__unwatch_url
mcp__claude-code-remote__update_trigger
mcp__claude-code-remote__watch_url
```

Count: 27 under `mcp__claude-code-remote__`; 2 under `mcp__ccd_session__`; 0 under `mcp__Claude_Code_Remote__`; 0 under `mcp__bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a__`.

## What it shows (EV-C02-006 section 4.5)

- **S0 passes:** it shows at least one tool the bridge denies under `mcp__claude-code-remote__` (it shows all 23 of CTL's), and `ccd_session`'s two tools, and `SendMessage` (deferred). So route (ii) can show the deny for these.
- **Not shown by the control:** `RemoteTrigger` and `ListAgents` (absent from this list); `check_repo_access`; any tool under the other two names. Their absence after the change is no evidence; they rest on the documentation (EV-C02-006 section 4.5).
