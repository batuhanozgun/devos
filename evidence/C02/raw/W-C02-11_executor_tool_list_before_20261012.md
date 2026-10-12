# W-C02-11: the working session's own tool list, before the bridge (control)

- **What:** the session, messaging and routine tools in the working session's own tool list (`session_01XyxvJd3RayQk4HCrjurbVH`), as the tool definitions are presented to the session itself. W-C02-11 point 4's control: "a list taken the same way before the change shows the tools the bridge will deny".
- **When:** 2026-10-12, read at about 17:46Z (the clock read at 17:46:36Z), at `main` `db2ebd9`, with the repository's `.claude/settings.json` as merged there (no bridge yet). The session started 2026-10-10T20:57Z; this is not a fresh session.
- **Who and how:** the executor, reading its own tool definitions in this conversation. Two layers: the definitions loaded in full (callable now), and the names offered as deferred tools (callable after their schema is fetched). Names only; no tool was called for this list.
- **Label:** observed, as the session's own report of its context (a self-report; no other reader can see this list). Claude Code 2.1.296 (`get_session`, 17:09Z, L-289).

## Loaded in full

The session-tools server, under the name `claude-code-remote` (27 tools): `add_repo`, `archive_session`, `create_session`, `create_trigger`, `delete_trigger`, `fire_trigger`, `get_event`, `get_session`, `get_trigger`, `interrupt_session`, `list_environments`, `list_events`, `list_repos`, `list_sessions`, `list_triggers`, `read_documentation`, `register_repo_root`, `send_later`, `send_message`, `set_session_tags`, `set_session_title`, `subscribe_pr_activity`, `unarchive_session`, `unsubscribe_pr_activity`, `unwatch_url`, `update_trigger`, `watch_url`.

The server `ccd_session` (2 tools), which arrived during this conversation (its schemas were offered after the session's context was compacted, about 17:03Z): `spawn_task`, `dismiss_task`.

Built-in tools in scope: `ListAgents`, `ScheduleWakeup`, `ReadNotifications`, `SendUserFile`.

## Offered as deferred tools (names only)

`SendMessage`, `CronCreate`, `CronDelete`, `CronList`, `PushNotification`, `Monitor`, `TaskCreate`, `TaskGet`, `TaskList`, `TaskStop`, `TaskUpdate`, among others outside this item's scope.

## Not in the list

`RemoteTrigger`; no tool under `mcp__Claude_Code_Remote__` or `mcp__bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a__`.

## Also seen

`get_session`'s answer at 17:09Z names, in its own hand-over list, `mcp__claude-code-remote__check_repo_access`, which is not among the definitions above.

## Limits

This is one long-running session. A server can arrive after a session's first call (EV-C01-020; R7 1 (e)), and `ccd_session` did here. A fresh session's list may differ. This is the control list, not the confirming one (W-C02-11 point 4).
