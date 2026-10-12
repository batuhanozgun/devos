---
id: EV-C02-006
item: W-C02-11
kind: record
title: "The session-tools bridge before the environments: the installation's uses, the bridge's entries, the rule-change route, the recorder hook, and the confirmation and guard tests made after the merge (W-C02-11)"
date: 2026-10-12
main_at: db2ebd9
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (same session; declared, Ek A 5.3)"
sources:
  - "R7: evidence/C02/raw/W-C02-11_doc_reading_R7.md (researcher R7, agent a921df8e76ba81ba2): Claude Code documentation read 2026-10-12 at about 17:40Z; the installation's uses from the ledgers, the evidence, the working order, the hooks and the guard's decision log of session_01XyxvJd3RayQk4HCrjurbVH (2026-10-10T20:58:07Z to 2026-10-12T17:42:17Z)."
  - "CTL: evidence/C02/raw/W-C02-11_executor_tool_list_before_20261012.md, the working session's own tool list before the bridge, read at about 17:46Z on 2026-10-12 at main db2ebd9 (a self-report)."
  - "plan/work/W-C02-11.md (acceptance points 1 to 10); plan/work/C02.md (N-136, N-174, N-181, N-209, the work list); N-194 on plan/work/C01.md; N-200 on plan/work/C06.md; N-140 on plan/work/C12.md; N-137 on plan/work/C03.md. Read 2026-10-12 at main db2ebd9."
  - "evidence/C01/EV-C01-004_environment_separation_one_account.md (S9, S10, sections 4, 6, 7 and 8); EV-C01-020 as N-181 summarises it; evidence/C00/probes/P-W12-5_send_later_sample.md. Read 2026-10-12."
  - "plan/Installation_Working_Order.md and plan/DevOS_Kurulum_Plani.md at main db2ebd9 (working order sections 2, 3, 4, 7 and 10; plan 6.7 and lines 927, 964 and 974); plan/Ek_E_Iletisim.md line 85; plan/decisions/D-014, D-017 and D-020, and the titles and dates of D-001 to D-031; PC-40."
  - "The producer's searches, 2026-10-12: the four tool names R7's table lacks (check_repo_access, register_repo_root, watch_url, unwatch_url), with the Grep tool over the clone at db2ebd9 (plan/, evidence/, .claude/) and over /tmp/devos-guard/ (the guard's decision logs on this machine)."
  - ".claude/settings.json, .claude/hooks/tool_allowlist.py (lines 91 to 141), .claude/hooks/record_owned_id.py (lines 16 to 17) and tools/test_tool_allowlist.sh (its settings checks and its last line), read only at db2ebd9."
claim: "Points 1, 2, 3, 5, 7, 8 and 10 are records from the documentation (documented, not independently tested), the installation's records and the control list (a self-report). Points 4 and 6 are carried out by the executor after the merge, as sections 4 and 6 set out. Nothing here is observed after the change."
---

# EV-C02-006 · The session-tools bridge before the environments (W-C02-11)

**What this is.** W-C02-11's record of S9's bridge (EV-C01-004 S9): which session, messaging and routine tools the installation has used and which it keeps; the entries added to `.claude/settings.json` and their documented form; the route by which the change merges (PC-45); the recorder hook's fate; and, for points 4 and 6, exactly what the executor runs and records after the merge and what counts as pass or fail. The technical decisions are the executor's (working order section 2), given to the producer on 2026-10-12; each is recorded here with its reason, and the evidence that weighs against any of them is stated (section 1.4). The guard, the recorder hook and `tools/test_tool_allowlist.sh` do not change. The research library was not consulted: the question is about the platform's current documentation, which R7 read from its primary source.

**Labels.** "[doc]" marks a documentation fact with PC-21 item 9's claim: guaranteed by the platform (documented in the named page of `https://code.claude.com/docs/en/`, read 2026-10-12 at about 17:40Z by R7 unless another date is given); not independently tested. PC-21 item 9's qualifiers apply; among them, routines are a research preview, so these readings are repeated when the platform changes (N-220). "R7 1 (a)" is section 1 item (a) of R7's report; "CTL" is the control list. An "inference" is this record's reading, not a documented fact.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `db2ebd9` (PR #289), at which W-C02-11's acceptance condition is in force; the change is written on branch `claude/c02-w11-bridge` from it. |
| Deployment configuration | Working session `session_01XyxvJd3RayQk4HCrjurbVH`, cloud, Opus 5.5, Claude Code 2.1.296 (`get_session` at 17:09Z, L-289, as CTL records). |
| Criterion version | W-C02-11's acceptance block as it stands at `db2ebd9`. |
| Input | The executor's decisions for W-C02-11 (2026-10-12); R7; CTL. |
| Actual observation | None after the change. CTL is the session's own report before it. |
| Raw evidence ID | `evidence/C02/raw/W-C02-11_doc_reading_R7.md`; `evidence/C02/raw/W-C02-11_executor_tool_list_before_20261012.md`; the post-merge raw files named in sections 4.4 and 6. |
| Independence level | Producer: same session, fresh-context subagent (declared, Ek A 5.3). Its own checks are not independent assurance; a fresh-context checker judges points 1 to 8 and 10 (point 9). |

## 1. Uses listed (point 1; N-136)

### 1.1 Sources, and how each was searched

From R7 2 unless marked:
- **Ledgers:** `grep -o` and `grep -c` for each tool name over `plan/ledger/C00-log.md`, `C01-log.md` and `C02-log.md`, then the context around each hit; a ledger mention counts as a use only where it records a call.
- **Working order:** the Grep tool for the names, sections 3 to 10.
- **Evidence:** `grep -rl` per name over `evidence/`, then the contexts and every routine run's `OPENING.md`.
- **Hooks:** grep over `.claude/hooks/tool_allowlist.py` and `record_owned_id.py`; `reread_after_compact.py` has no hit.
- **The guard's decision log:** `jq` over `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl` (17,200 records, 2026-10-10T20:58:07Z to 2026-10-12T17:42:17Z), selecting the tool by regex and printing tool, rule, decision, event, first and last time, and main or subagent; `unknown.jsonl` holds only `AskUserQuestion`, `ExitPlanMode` and `Read`. No guard log of an earlier (C00) session exists on this machine.
- **The producer, for the four names R7's table lacks** (`check_repo_access`, `register_repo_root`, `watch_url`, `unwatch_url`): the Grep tool over the clone at `db2ebd9` (every file) and over `/tmp/devos-guard/`. Hits: `register_repo_root` in `plan/ledger/C00-log.md` lines 16 and 943 and `evidence/C00/EV-C00-001_library_access.md` row 3; `watch_url` in `evidence/C00/reviews/R-C00-BOM-4.md` line 31; otherwise only CTL and this change's settings; no hit in the guard logs.

**The tool set.** CTL lists 27 tools of the session-tools server, under the name `claude-code-remote`, loaded in full; `get_session`'s answer at 17:09Z names a 28th, `check_repo_access`, that is not among CTL's definitions. Routine sessions showed only 3 of the server's tools (`add_repo`, `subscribe_pr_activity`, `unsubscribe_pr_activity`; R7 2, "Limit"), so the set depends on how a session was created ([doc] R7 1 (c)). The bridge's per-tool list is CTL's 27 and `check_repo_access`.

### 1.2 The session-tools server (28 tools)

| Tool | In CTL | Uses the installation has made (source) | Bridge | Reason |
|---|---|---|---|---|
| `add_repo` | yes | Library attachments in C00 (C00-log:14, 661, 1049); refused by the platform in Accept edits (C00-log:1415; C02-log:60, 2026-10-12T14:44Z). Guard log: 2 allows under S5 at 14:45:11Z. | **kept** | Attaching the research library read-only, for D9 consultations and C04's ingestion (D-014's route); the guard's S5 limits it to `devos` and the library read-only. See 1.4 item 1. |
| `archive_session` | yes | None found | denied | No use |
| `check_repo_access` | named by `get_session`, not in CTL's definitions | None (producer's search) | denied | No use; listed so that a session that has it is covered |
| `create_session` | yes | C00 only (C00-log:619, 807, 1274–1289, 1381; EV-C00-005); none in this session's guard log; "The executor started no session" (EV-C01-030:57) | denied | Routines start the sessions and Batu creates the routines (EV-C01-004 S9, "Need"); a session in Accept edits cannot start one (L-119) |
| `create_trigger` | yes | C00 only (as `create_session`) | denied | As `create_session` |
| `delete_trigger` | yes | Only a denied attempt (#10579, S1; C01-log:822, 824) | denied | No use; see section 5 on N-194 |
| `fire_trigger` | yes | None found | denied | No use |
| `get_event` | yes | None found | denied | No use |
| `get_session` | yes | The opening check (working order section 3 item 1, line 34); the usage readings (section 7, line 79; C02-log:105); N-111's version comparison (`plan/work/C05.md`). Guard log: 32 allows under S1 (31 by the working session, 2026-10-10T20:58Z to 2026-10-12T17:09Z; 1 by a subagent, 16:25Z). | **kept** | The opening check, the usage readings and N-111; EV-C01-004 S9: "At least the installation's own-session reading is kept" |
| `get_trigger` | yes | Only a denied attempt (#14659, S1, on N-202's check-in; C02-log:63); N-202 itself uses `git ls-remote` (`plan/work/C02.md`) | denied | Not needed for N-202 |
| `interrupt_session` | yes | None found | denied | No use |
| `list_environments` | yes | One C00 use (C00-log:1268) | denied | No current use; X3's method must not need S9's tools (EV-C01-004 section 3) |
| `list_events` | yes | C00 only (C00-log:291–295) | denied | No current use |
| `list_repos` | yes | None found | denied | No use |
| `list_sessions` | yes | None found; the guard denies it (S1) | denied | No use |
| `list_triggers` | yes | None; the guard denies it (C01-log:1045; R-C00-BOM-7:37) | denied | No use |
| `read_documentation` | yes | No use found (no ledger hit) | **kept** | The platform's own documentation of the container and its settings, read-only; the session's instructions name it for questions about the environment (the executor's decision) |
| `register_repo_root` | yes | Deliberately not called (C00-log:16, 943; EV-C00-001 row 3) | denied | By `add_repo`'s result it would load another repository's `CLAUDE.md`, skills and plugins into the session (C00-log:16) |
| `send_later` | yes | Check-ins of L-250 (C01-log:813, 822) and L-274, `trig_01A8…` (C01-log:1037, 1054; C02-log:63); C00's resume wake-up (C00-log:134); the P-W12-5 sample (C00-log:719). Guard log: 3 allows under S1 (2026-10-11T19:16Z to 2026-10-12T09:14Z). Refused once by the platform, "requires approval" (C00-log:1322). | **kept** | The check-ins (L-250): the session's only way to wake itself, since the guard denies `ScheduleWakeup` and `CronCreate` (working order section 10). See 1.4 items 2 and 3. |
| `send_message` | yes | C00 only (as `create_session`) | denied | No session messages another (EV-C01-004 S9, "Need") |
| `set_session_tags` | yes | None found | denied | No use |
| `set_session_title` | yes | None found | denied | No use |
| `subscribe_pr_activity` | yes | None found | denied | No use (the guard allows it on `devos`) |
| `unarchive_session` | yes | None found | denied | No use |
| `unsubscribe_pr_activity` | yes | None found | denied | No use |
| `unwatch_url` | yes | None (producer's search) | denied | No use |
| `update_trigger` | yes | Only a C00 denial (#140, C00-log:1360) | denied | No use |
| `watch_url` | yes | None; the guard blocked it in C00's re-run (R-C00-BOM-4:31) | denied | No use |

### 1.3 The other session, messaging and routine tools a session of the installation has

| Tool | In CTL | Uses (source) | Bridge | Reason |
|---|---|---|---|---|
| `RemoteTrigger` | no | None; in no routine session's observed list | denied | It "Creates, updates, runs, and lists Routines on claude.ai" ([doc] tools-reference); Batu creates routines |
| `SendMessage` | yes (deferred) | No call in the guard log; the working order (section 4, line 46) and C02-log:71: the guard denies resuming a helper | denied | No session messages another; denying it "also removes messaging to subagents", and the Agent tool is unaffected ([doc] R7 2) |
| `ListAgents` | yes (loaded) | None | denied | It lists what `SendMessage` can reach |
| `ccd_session`: `spawn_task`, `dismiss_task` | yes (arrived during the session) | None (no hit in the ledgers or the guard log) | denied, server-level (`mcp__ccd_session`) | No use, so nothing to keep; see N-181's answer in section 2 |
| `ReadNotifications` | yes | 6 allows under T1 (2 main, 4 subagent); `send_later`'s deliveries arrive as notifications (C00-log:484, 497; P-W12-5's annotation) | not in the bridge; the guard allows it (T1) | Kept with `send_later`; it reads only this session's own queue |
| `PushNotification` | yes (deferred) | No call; proposed as a reminder channel (C00-log:620); Appendix E's second channel, "a Claude app notification", tested in C06 (`plan/Ek_E_Iletisim.md` line 85) | not in the bridge; the guard allows it (T1) | Reaches only Batu's own devices, no other session or environment, so it is not S9's control surface |
| `SendUserFile` | yes | No call | not in the bridge; the guard allows it (T1) | Reaches only the user, not S9's control surface; no use (reported in "Open") |
| `ScheduleWakeup`, `CronCreate`, `CronList`, `CronDelete` | yes (`ScheduleWakeup` loaded; the others deferred) | One `ScheduleWakeup` denial of a subagent (#14060, C02-log:49) | not in the bridge; the guard denies them (T1; working order section 10, "Known over-blocking") | They schedule within the session itself, not another session or a routine of the account (R7 2), so they are outside S9's need; the guard is their layer |

`Monitor` and the `Task…` tools in CTL act on the session's own background work and are not session, messaging or routine tools; they are not listed further.

**The two uses point 1 names.** The session's own reading for the opening check and the usage readings is kept (`get_session`). The check-ins armed with `send_later` (L-250) are kept, with `ReadNotifications`, for the reason in table 1.2.

### 1.4 Evidence that weighs against a decision (none is decisive)

1. **`add_repo` kept.** (a) Its last use was refused by the platform in Accept edits (C02-log:60), as in C00 (C00-log:1415), so in the working session it works only in the approval window D-014's terms set. (b) EV-C01-004 S9, "Need": "No DevOS session needs to … attach a repository other than `devos`". (c) The bridge is per repository, not per environment, so `add_repo` also stays in the sessions of the three environments, where only the guard's S5 limits it, and routine sessions run in auto mode by their own record (plan 6.7), where the approval that stopped the working session may not apply. Against these: D-014 (Batu, 2026-10-06) set direct reading of the library before C04, and plan 6.7's library row already treats the library as reachable by every session ("a session can attach a repository to itself", L-002), so keeping the tool widens no reach the plan does not already assume. Named as a residual.
2. **"`send_later` stays, so N-194's need stays."** The need stays, but N-194's change (the recorder records `send_later`'s trigger ID) would enable no call under the bridge: every session tool that acts on an owned trigger ID (`delete_trigger`, `update_trigger`, `fire_trigger`, `get_trigger`; the guard's `OWNED_TARGET_FIELDS`) is denied. Section 5; carried by N-250 on `plan/work/C06.md`.
3. **`send_later` is itself a routine-creating tool.** Its own definition, read by the executor as CTL was (`evidence/C02/raw/W-C02-11_send_later_definition_20261012.md`, CHK-C02-018 C2): its five parameters are a time (`at` or `delay_minutes`), a provenance label, the text and a list label, and none names a session, routine or recipient other than the calling session; its description says the message is delivered "back into THIS SESSION". So it cannot be aimed at another session by its own definition, and the keep decision stands. Each call puts a one-off entry in Batu's routine list that fires a message into the calling session (C01-log:813; C00-log:134). The recorded calls take a delay and a message and name no target, and the delivery arrived in the caller's own queue (P-W12-5); the guard checks no target for it (`FREE_SESSION_TOOLS`). Whether it can be aimed at another session is not stated in what R7 read, and whether `refuse` drops its deliveries is not documented (R7 1 (b)); section 4.4 step A5 observes the second.
4. **The guard's prefix list.** The guard allows only the prefix `mcp__claude-code-remote__` (`ALLOWED_PREFIXES`) and denies the other two names under M1, so in a session where the server registers under another name the guard denies even `get_session`, and the opening check could not run there (R7 3). This item does not change the guard; it is reported for W-C02-12's sessions.

## 2. The bridge (point 2; N-136; EV-C01-004 S9)

**Entries added to `.claude/settings.json`** (every existing entry kept; the file stays valid JSON):
- `permissions.deny`, 76 entries:
  - `RemoteTrigger`, `SendMessage`, `ListAgents`;
  - under each of `claude-code-remote`, `Claude_Code_Remote` and `bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a`, one entry `mcp__<name>__<tool>` for each of the 24 tools table 1.2 denies: `archive_session`, `check_repo_access`, `create_session`, `create_trigger`, `delete_trigger`, `fire_trigger`, `get_event`, `get_trigger`, `interrupt_session`, `list_environments`, `list_events`, `list_repos`, `list_sessions`, `list_triggers`, `register_repo_root`, `send_message`, `set_session_tags`, `set_session_title`, `subscribe_pr_activity`, `unarchive_session`, `unsubscribe_pr_activity`, `unwatch_url`, `update_trigger`, `watch_url`;
  - `mcp__ccd_session`.
- `"crossSessionInbound": "refuse"`, at the top level.

No kept tool is named under any name, and no entry has parentheses.

**The entries' form, quoted from the documentation** (read 2026-10-12 at about 17:40Z by R7; documented, not independently tested):
- **(a) Deny entries.**
  - A built-in tool takes its bare name: "A bare tool name like `Bash` removes the tool from Claude's context entirely" (https://code.claude.com/docs/en/permissions, "Manage permissions"). For messaging, deny "`SendMessage` and `ListAgents`. Both take the bare tool name with no specifier", with the example `"deny": ["SendMessage", "ListAgents"]` (https://code.claude.com/docs/en/cross-session-messaging, "Turn off cross-session messaging"). `RemoteTrigger` is a built-in tool name, "Creates, updates, runs, and lists Routines on claude.ai" (https://code.claude.com/docs/en/tools-reference); no page gives it a special form.
  - One tool of one MCP server: `mcp__<server>__<tool>`, as "`mcp__puppeteer__puppeteer_navigate`" (permissions, "MCP"); for this server, "append two more underscores and the tool name to each rule, as in `mcp__Claude_Code_Remote__add_repo`" (https://code.claude.com/docs/en/self-hosted-environments-configuration, "Turn off built-in session tools").
  - A whole server: "`mcp__puppeteer` matches any tool provided by the `puppeteer` server" (permissions, "MCP").
  - Qualifiers: "An allow rule can't carve an exception out of a deny rule", so a server-level deny cannot keep `get_session`, and the bridge is per tool; "Claude Code … skips any `mcp__` rule that has parentheses"; a deny rule naming no known tool gives a startup warning, but "Tool names containing `_` or `*` are exempt" (permissions). Inference (R7): `RemoteTrigger`, absent from CTL, may give that warning.
- **(b) `crossSessionInbound`** (https://code.claude.com/docs/en/settings-reference, `crossSessionInbound`; https://code.claude.com/docs/en/settings, the exceptions table; cross-session-messaging): a top-level key, "Scope: Any file", not under `permissions`; it needs v2.1.224 or later (the installation runs 2.1.296). `"refuse"`: "Claude Code drops the message". "A project or local value applies only when it's stricter", and "From project or local settings, `refuse` applies over every other source". Its limits: "Claude Code still binds each session's inbox socket, but drops every message"; "A refusing session shows no visible change … to confirm it, check the settings files that apply to that session rather than its status".
- **(c) The three names** (self-hosted-environments-configuration, "Turn off built-in session tools"): the server is registered "under one of three names, depending on how the session was created. Claude Code matches the name in a rule exactly, including case": `mcp__Claude_Code_Remote`, `mcp__claude-code-remote`, `mcp__bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a`. "A rule that names the whole server covers tools the server gains later too." The page places these rules in server-managed settings or the runner's `~/.claude/settings.json`; the repository file is supported by https://code.claude.com/docs/en/settings, "Settings in cloud sessions": `.claude/settings.json` is "read in a session with one repository", and a session with several repositories in an Anthropic-hosted environment reads only `enabledPlugins` and `extraKnownMarketplaces` from it, "not permission rules". Observed in DevOS: only `claude-code-remote` (the nine routine runs' `OPENING.md`, this session's guard log, CTL).
- **(d) Removal from the context:** "Claude Code removes a denied tool from Claude's context, so the denied tools are absent from its answer" (self-hosted page); "Scoped deny rules like `Bash(rm *)`, and all allow and ask rules, don't change which tools Claude sees" (https://code.claude.com/docs/en/prompt-caching, "Denying an entire tool"). The bridge's entries are all whole-tool or whole-server rules.

**N-181's answer on `ccd_session`.** It is not one of the three names. The page lists the three names, and `ccd_session` is a separate server, observed with the tools `spawn_task` and `dismiss_task` (`evidence/C01/routine/runs/P1-20261011T1337Z/P1/OPENING.md` line 23; CTL). It has no documentation: `ccd_session`, `spawn_task` and `dismiss_task` have no hit in `https://code.claude.com/docs/llms-full.txt`, where the same search finds the three names and "Claude Code Remote" 7 times (R7 1 (d)). CS2 read its tools as the desktop app's "suggested-task cards" (`evidence/C01/routine/runs/CS2-20261012T0808Z/CS2/OPENING.md` line 14), a session's reading, not documentation. Since names match exactly, no rule under the three names matches `mcp__ccd_session__*`. **So the bridge denies `ccd_session` with its own entry, at server level** (`mcp__ccd_session`), because none of its tools has a use (table 1.3): nothing needs carving out, and a server-level rule also covers tools the server gains later (inference from the MCP rule form, R7 1 (d); the documented sentence is about the session-tools server). The guard already denies it under M1. Whether the entry removes it from a list is shown only by a list that showed it before (section 4.5).

**No guard rule family is added** (FR-05 B; EV-C01-004 S10). `.claude/hooks/tool_allowlist.py`, `.claude/hooks/record_owned_id.py` and `tools/test_tool_allowlist.sh` are unchanged. The bridge moves the same denials into Claude Code's permission layer, where they are documented to hold in every mode ([doc] permission-modes, read 2026-10-11, EV-C01-004 S9) and to remove the tools from the context; `refuse` covers inbound messages, which are not tool calls and which the guard cannot see. The tests' settings check reads only `model`, `effortLevel`, `ultracode` and `permissions.defaultMode` and the hook entries, which are unchanged.

## 3. Rule-change route (point 3)

- `.claude/settings.json` and `plan/Installation_Working_Order.md` are class high (`tools/merge_gate.py`); `plan/DevOS_Kurulum_Plani.md`, `plan/work/C06.md`, PC-45 and this record are class normal. The change merges only with a fresh-context checker's verdict at the head that adds it (working order section 4; the merge gate).
- `plan/decisions/PC-45.md` (status proposed) carries the plan text through Section 14, each place with its old text from `main` `db2ebd9`, its line, its new text, its reason and the affected stages; the new texts are applied in this change:
  - place 1: plan 6.7's row "The Claude account's control surface" (line 731), the text EV-C01-004 section 8 item 7 names: S9's layer and its bridge, the guard as the second layer, and D-020's residual;
  - place 2: working order section 10, the bullet "Sessions and repositories" (line 139), whose statement that the recorder hook records the owned IDs the bridge makes untrue going forward.
- PC-45 lists the working-order and plan sentences checked and left unchanged, with the reason for each (sections 2, 3, 4, 7 and 10 of the working order; plan lines 730, 927, 964 and 974).
- The plan text and the settings merge in the same change, so they are merged before W-C02-12 relies on the bridge.

## 4. Confirmed by a session's own tool list (point 4; N-136, N-181; D-017 item 2 (a)): made after the merge

### 4.1 N-181's answer: when the confirming list is taken

**The answer.** The confirming list is taken twice, after the merge and the live tree's sync, each time by a fresh subagent started then (route (ii), 4.3): first after the working session's first calls after the sync (steps A2 and A3), and again at least 10 minutes later, after the session has gone on making calls. A list taken only at a session's start, or only once, does not count.

**Reason and evidence.**
- [doc] The mcp page ("Tool availability", "Dynamic tool updates", "Configure tool search"; R7 1 (e)): servers can still be "connecting in the background"; "With tool search enabled, when a server finishes connecting while Claude is working, Claude Code lists the server's tool names to Claude on its next request in the same turn"; a server may change its tools mid-session (`list_changed`). Tool search is on by default and MCP tools are deferred. No page gives a point after which a session's list is complete, or says when platform-attached servers connect.
- Observed in DevOS (the sessions' self-reports, R7 1 (e)): `ccd_session` arrived after the first call in P1 (2026-10-11), P2 and P4 (about 19:16Z for a run started at 19:14Z, 2026-10-11) and CS2 (about 08:10Z, boot 08:09:51Z, 2026-10-12); it was present in both P3 runs with no timing stated, and absent all run in R1a, R1b and CS1; `github` was "still connecting at start" in P2, P4, CS1 and CS2. In this working session its schemas were offered at about 17:03Z on 2026-10-12, after a compaction, in a session started 2026-10-10T20:57Z; when it connected is not known (CTL).
- [doc] R7 1 (f): a deny added mid-session blocks calls "from your next request on"; with tool search active "the request's tool definitions don't change", and the permissions page speaks separately of "a definition Claude has already seen". So a context that saw the tools before the deny may still show them, and the confirming list comes from a fresh context.
- The 10-minute interval is five times the longest delay observed after a routine session's first call (about 2 minutes). It is a check against a late server, not a proof that a list is complete: no documented point gives that, and this session's own late `ccd_session` has no known connecting time (a residual).

### 4.2 What the control list can and cannot show

- **Can.** In the working session before the change, CTL shows 23 of the 24 tools the bridge denies tool by tool under `claude-code-remote` (all but `check_repo_access`), `SendMessage`, `ListAgents`, and `ccd_session`'s two tools. So, for that session, a listing taken the same way would show them if the deny did not hold.
- **Cannot.**
  - `RemoteTrigger` is not in CTL, so its absence later shows nothing.
  - No tool under `Claude_Code_Remote` or `bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a` is in CTL, so the entries under those two names have no control in any list DevOS has seen; they rest on the documentation.
  - `check_repo_access` is not among CTL's definitions.
  - `ccd_session` arrived late in this session and is absent from some sessions (R1a, R1b and CS1 all run). A later list that lacks it shows nothing about the deny unless the same kind of list showed it before; where the control lacks it, its absence after the change is not evidence, and the record says so.
  - CTL is one long-running session's self-report, taken before the change in a context that has seen every tool. It is not "the same way" as a fresh subagent's list, so the chosen route takes a control of its own (step S0).

### 4.3 How a fresh list can be had, given that the executor cannot start sessions (working order section 2)

| Route | For | Against |
|---|---|---|
| (i) The working session's own list after the sync | No cost; the same way as CTL, so CTL is its control | Not fresh: the session saw every denied tool, so their definitions may stay visible after the deny (R7 1 (f)); a list that still shows them would not separate "the deny did not hold" from "an already-seen definition" |
| (ii) A fresh subagent started after the sync, of a type whose own list includes MCP tools | No step for Batu; minutes; a fresh context that has seen no definition; the guard allows the built-in `general-purpose` type (T4, `BUILTIN_AGENT_TYPES`), whose list is expected to carry the session's MCP tools; a control can still be taken the same way before the sync (S0) | Not a new session: it shows the permission layer as the running session holds it after the file changed ([doc] settings, "When edits take effect": edits to `permissions` reach the running session, read 2026-10-11, EV-C01-004 S9), not as a new session reads it at its start; it sees the servers already connected to the working session, not a new connection; that a subagent's list is filtered by the session's deny rules is not in what R7 read, so the control decides whether the route can show anything; the repository's own role types carry no MCP tools (their `tools:` fields; R7 2, "Limit"), so the type must be `general-purpose` |
| (iii) Batu opens one session in `devos-kurulum` with `devos` only, from a first message the builder gives | A new session: the settings read at its start from a fresh clone, its servers connecting afresh, as W-C02-12's sessions will be | A step for Batu (criterion 21; working order section 2: one narrow question), and a wait of his response time; a control taken the same way would need a second step before the merge |

**Choice: (ii)**, with (i) recorded beside it as a supplement (step A7), and (iii) as the fallback when (ii)'s control shows no session tool or a confirming list is "could not check".
- **The residual (iii) would have covered:** the bridge as a new session reads it at its start, with its servers connecting afresh, including a server that arrives late in a new session. It is covered before any DevOS work runs in the three environments: W-C02-12's first session in each environment records its own tool list first (X1; the item's "Not covered here"), and C03 test 3 repeats it (N-137); a denied tool in any of those lists stops that work.
- **The residual (i) would have covered:** the list of the session that actually runs the installation. Step A7 records it, and steps A2, A5 and A8 show its kept tools at work; it is not the confirmation.

### 4.4 What the executor runs and records

Each step's output is filed raw under `evidence/C02/raw/`, with the envelope fields of section 8, and the item's record of point 4 cites them.

**Task text T** (the same for S0, A4 and A6, with working order section 9's discipline block added): "Task (W-C02-11 point 4; data only, no plan work). List the names of the tools in your own tool list, exactly as they are presented to you: (a) every tool whose name begins with `mcp__`, grouped by server; (b) any of these built-in tools you have: `RemoteTrigger`, `SendMessage`, `ListAgents`, `ReadNotifications`, `PushNotification`, `SendUserFile`, `ScheduleWakeup`, `CronCreate`, `CronList`, `CronDelete`. Give the tools loaded in full and the names offered as deferred tools, and say which is which. Names only: do not call, load or search for any tool to make this list, and do not change a name. If you cannot see your tool list, say so."

**Before the sync** (while the live tree's `.claude/settings.json` has no bridge; it can run beside the checker, before the merge):
- **S0. Control for route (ii).** A fresh `general-purpose` subagent with task T. File its report as `W-C02-11_subagent_tool_list_control_<UTC>.md`, with its agent ID and the guard's record numbers.

**After the merge, in this order:**
- **A1. Sync.** `tools/sync_worktree.sh`; record the time (T_sync), the live tree's HEAD, and `git rev-parse HEAD:.claude/settings.json`, which must equal the merge commit's blob.
- **A2. The opening check's own-session reading.** `get_session` without `session_id`; record the model, the permission mode and the Claude Code version (working order section 3 item 1).
- **A3. The guard is live.** `python3 tools/guard_report.py`; record that it shows decisions made after T_sync, with the first such record number.
- **A4. First confirming list.** A fresh `general-purpose` subagent with task T, run in the background; record whether its completion started the next turn by itself (working order section 7). File as `W-C02-11_subagent_tool_list_after1_<UTC>.md`.
- **A5. `send_later` at its use.** Arm one check-in into the session at least 10 minutes ahead, whose message asks for step A6; record the returned `trigger_id` and `fire_at`, and whether and when it was delivered (a notification read with `ReadNotifications`, or the turn it starts), or that nothing came within 10 minutes after `fire_at`. Its result also applies to the check-in armed earlier for N-202's listing (`trig_01A8FuZxG7Qs7TQ32nHSJjNi`, due about 2026-10-13T08:37Z; CHK-C02-018 R6).
- **A6. Second confirming list.** A fresh `general-purpose` subagent with task T, started at least 10 minutes after A4 and after A5's `fire_at`, the working session having made calls in between. File as `W-C02-11_subagent_tool_list_after2_<UTC>.md`.
- **A7. The working session's own list**, read as CTL was, as a supplement. File as `W-C02-11_executor_tool_list_after_<UTC>.md`.
- **A8. `read_documentation` at its use.** One read-only call for one page of the platform's documentation; record the page and that it returned.
- **`add_repo`** is not exercised: the platform refuses it in Accept edits (C02-log:60), and attaching the library needs D-014's window. Recorded "not shown", with that reason.

### 4.5 What counts as pass or fail

| Check | Pass | Fail, or not shown, and what follows |
|---|---|---|
| S0, the control (✔) | Its list shows at least one tool the bridge denies under `mcp__claude-code-remote__` (CTL's 23 are expected) | No tool of the session-tools server in it: route (ii) can show nothing; recorded "could not check", and route (iii) follows; W-C02-12 waits for it |
| A4 and A6, the confirmation (✘) | Neither list holds any tool the bridge denies: none of the 24 under any of the three names, no `mcp__ccd_session__` tool, no `RemoteTrigger`, `SendMessage` or `ListAgents` | Any of them in either list: **fail**, recorded raw; for that tool the guard stays the only layer (EV-C01-004 section 6 item 3), and W-C02-12 does not rely on the bridge until the executor has found the cause (D6: the entry's form or name, the file not read, the subagent route) and corrected it through the merge gate, then repeated A1 to A8 |
| The kept tools are listed (✔) | Each kept tool that S0 lists is in A4 and A6 | A kept tool missing: **fail** (the bridge over-denies); corrected the same way |
| A tool neither kept nor denied (point 1; CHK-C02-018 C1) | No such tool in S0, A4, A6 or A7 | Any tool in S0, A4, A6 or A7 under `mcp__claude-code-remote__`, `mcp__Claude_Code_Remote__`, `mcp__bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a__` or `mcp__ccd_session__`, or any other session, messaging or routine tool, that is neither one of the four kept tools nor matched by a bridge entry: **fail** of point 1's inventory; recorded raw, and W-C02-12 does not rely on the bridge until the tool is denied through the merge gate or kept with its use |
| A fail caused by the observing route (CHK-C02-018 R2) | — | A confirmation fail whose cause (D6) turns out to be the route itself, not the bridge (a subagent's list that the deny rules do not filter, or settings the running session did not reload), has nothing to correct through the merge gate: it counts as "could not check", and route (iii) follows |
| A2 (✔) | `get_session` returns the session's fields | An error or a denial: **fail** |
| A subagent call returns its result (✔) | A4 and A6 return their reports; A4's completion starts a turn by itself | A report missing, or no turn started: **fail** (the bridge or `refuse` stops in-process subagents, against the documented reading) |
| A3 (✔) | Decisions after T_sync | None: **fail** (the guard is not live, or the platform rejected or ignored the file) |
| A5 | The check-in is delivered | Not delivered: `send_later` does not do its use under `refuse`; **fail** for that kept tool, and the executor decides again whether it is kept (point 1 keeps a tool only with its use) |
| A8 | The call returns | An error: **fail** for that kept tool, decided the same way |
| `ccd_session` | S0 shows it and A4 and A6 lack it: covered, by self-observation | S0 lacks it: "not shown"; its absence after the change is no evidence; it rests on the documented name rule (an inference), first shown by a session that has it (W-C02-12's sessions; C03 test 3) |
| The two other names; `RemoteTrigger`; `check_repo_access` | — | "Not shown" unless S0 shows them; they rest on the documentation |
| A7 (supplement) | Recorded as it is | A denied tool still shown is recorded as the "definition already seen" case (R7 1 (f)), not as a fail |
| Any step | — | A step that cannot be made or read (the agent type denied, a report without a list, a call that cannot be made) is "could not check", never a pass; for S0, A4 or A6 route (iii) follows |

### 4.6 The claim the confirmation rests on (PC-21 item 9)

"Guaranteed by the platform (documented in permissions, self-hosted-environments-configuration, settings, settings-reference and cross-session-messaging, read 2026-10-12, and permission-modes, read 2026-10-11); not independently tested." Its qualifiers: the repository's settings are read only in a session with one repository; a definition already seen may stay visible after a deny added mid-session; servers may connect later, and no documented point says a list is complete; routines are a research preview, so the readings are repeated when the platform changes (N-220); `refuse` cannot be confirmed from the session. What steps A4 and A6 add is self-observation (D-017 item 2 (a)) for the tools S0 showed, as subagents' self-reports.

## 5. The recorder hook (point 5; N-136)

- **Decision: kept unchanged**, with its `PostToolUse` entry (`mcp__claude-code-remote__create_session|mcp__claude-code-remote__create_trigger`).
- **Reason.** The bridge denies both tools it watches (`record_owned_id.py` lines 16 and 17), so it no longer fires: it is inert, not harmful. Removing it would be a change of the recorder hook, the checked change N-194 waits for, and it would take the guard's owned-ID rule (S1) out of step with the code its tests check (`tools/test_tool_allowlist.sh`, the recorder's cases), for no gain while the bridge holds. If a watched tool ever comes back (the bridge changed, or a session without it), the recorder works as before.
- **N-194 and N-200.** Neither the guard nor the recorder hook changes in this item, so N-194 (`plan/work/C01.md`) and N-200 (`plan/work/C06.md`) keep their deadline: the next checked change of the guard or the recorder hook, and before C06 builds DevOS's routines. `send_later` stays, so N-194's need stays (the builder cannot cancel a check-in it armed).
- **What the bridge changes for N-194** (1.4 item 2): its change (recording `send_later`'s trigger ID) would by itself let the builder do nothing with the ID, since `delete_trigger`, `update_trigger`, `fire_trigger` and `get_trigger` are denied. Carried as **N-250** on `plan/work/C06.md`: the change that makes N-194's recorder change also decides whether to keep `delete_trigger` (owned IDs only, S1), with a test, or to close N-194 with the reason that the bridge removes its route.

## 6. The guard's tests at the commit that will be live (point 6; N-174; PC-21 item 5): made after the merge

- **When.** After this item's last change to `.claude/hooks/tool_allowlist.py`, `.claude/settings.json` or `tools/test_tool_allowlist.sh`: this change's merge commit M, unless a checker's condition changes one of them again, in which case M is that later merge.
- **What the executor runs.** In a scratch clone of `devos` whose `main` is M (`git rev-parse HEAD` equals M, and M is on the remote, so the branch controls run), from the clone's root: `bash tools/test_tool_allowlist.sh`, its whole output filed raw as `evidence/C02/raw/W-C02-11_guard_test_<M>.md`.
- **What it records:** M; the three blobs (`git rev-parse M:.claude/hooks/tool_allowlist.py`, `M:.claude/settings.json`, `M:tools/test_tool_allowlist.sh`); the counts of lines beginning `ok`, `BAD` and `info`; each `info` line; and the last line. It judges only the three properties (the guard denies a tool not on its list, never answers "ask", and denies when it fails or runs past its time limit) and carries no rule detail (D-017).
- **Pass:** no `BAD` line; no skipped control (no `info` line saying controls are `SKIPPED`); the last line `ALLOWLIST_TEST PASS`. A run that stops early, or ends in `ALLOWLIST_TEST FAIL` with no `BAD` line, is not a pass: it is "could not check" until repeated (CHK-C02-018 R3).
- **Fail:** any `BAD` line or skipped control. The guard is corrected through the merge gate and the run repeated before W-C02-12 (plan C01 row 9's fail path).
- **Validity.** The run counts only while its three blobs are the live tree's. Before the first session runs in one of the three environments, the executor compares the live tree's three blobs with the recorded ones; if any differs, the run is repeated before that session.

## 7. PC-23 (point 7)

The parameters this item sets that decide when W-C02-12 can start, with what plan 6.12 item 1 names:

1. **N-181's timing** (4.1): S0 before the sync; A4 after the session's first calls after the sync; A6 at least 10 minutes after A4.
   - **Time on the critical path.** About 15 to 25 minutes after the merge (two subagent runs of a few minutes each, the 10-minute interval, the filing); S0 runs before the merge, beside the checker, and adds nothing. W-C02-12 also waits on W-C02-03 (running), W-C02-09 and W-C02-10 (planned) at `db2ebd9` (`plan/work/C02.md`, the work list), so as things stand it adds nothing to the critical path.
   - **The reason's sources, with their dates.** The mcp page, read 2026-10-12 (R7 1 (e)); the routine runs' self-reports of 2026-10-11 and 2026-10-12 (P1, P2, P4, CS2; R1a, R1b, CS1); CTL, 2026-10-12; R7 1 (f), read 2026-10-12. These are not plan text.
   - **Sooner at the same quality?** One list right after the sync saves about 10 minutes but would miss a server that connects later, so it is not the same quality. Route (iii) is not sooner.
2. **The confirmation by a fresh subagent** (4.3). Its reason from the plan is EV-C01-004 S9's confirmation by self-observation and D-017 item 2 (a) (2026-10-10): "prefer … what a single ordinary session can observe about itself". **Checked against Batu's later decisions:** D-018 (2026-10-10); D-019 and D-020 (2026-10-11): D-020 (a) keeps the three environments in his one account, which is why the bridge exists, and its residual stands; D-021, D-022, D-027 and D-028 (2026-10-11), D-029 and D-030 (2026-10-12): each shortened the critical path with one press of his, and this route adds minutes and asks nothing of him; D-031 (2026-10-12): no bearing; D-002's amendment of 2026-10-12 (the usage pace): two short subagents are light work. None decides how or when a session's tool list is taken.
3. **The fallback (iii):** it adds Batu's response time, only if S0 shows no session tool or a confirming list is "could not check".
4. **Point 6's run and its validity rule** (section 6): the run goes beside A4 to A6, its duration not measured here; a repeat is needed only if a blob changes before the first session in the three environments.

## 8. Tests and evidence (point 8)

- **No test is added or changed.** The guard, the recorder hook and `tools/test_tool_allowlist.sh` are unchanged, so no test in Appendix C's form C0 and no fixture is written; the recorder's existing cases keep running in point 6's run.
- **No automatic check is added**, so the cases of missing, unreadable and partial input do not arise. The producer's own checks on this change (the file is valid JSON; the deny list equals CTL's 27 tools plus `check_repo_access`, less the four kept, under each name, with the three built-ins and `mcp__ccd_session`; PC-45's old texts are on `db2ebd9` and its new texts in the files) are its own, not independent assurance.
- **The envelope.** Each result of sections 4 and 6 is filed raw with plan Section 8 item 9's fields: the source commit (the merge commit), the deployment configuration (the session and the Claude Code version from A2), the criterion version (W-C02-11's acceptance block at the merge commit), the input (task T verbatim, or the command), the actual observation, the raw evidence ID (the file, the agent ID and the guard's record numbers), and the independence level (the executor's own reading, or a subagent's self-report).

## 10. N-209 (point 10)

N-209's corrections (1) to (3) were carried by PC-40 (W-C02-16; L-288), merged at `eba94b1` (PR #280), and N-209 is closed. PC-45 carries none of them, since none remains.

## Residuals

- **The guard's single prefix** (1.4 item 4; CHK-C02-018 R5): in a session where the session-tools server registers under one of the other two names, the guard denies `get_session` too, so that session's opening check fails visibly; W-C02-12's first session in each environment reads such a denial as this case, not as the bridge. Carried by N-251 on `plan/work/C02.md`.

- **One repository only.** The bridge is read only in a session with one repository ([doc] R7 1 (c)); a session opened with several repositories runs without it, as it runs without the guard (working order section 10; N-048).
- **Added later.** A tool the session-tools server adds later, or a fourth name, is not covered by per-tool entries; only the server-level deny (S9's target, C12, N-140) covers later tools. The guard is the second layer: it denies a session-tools tool S1 does not name, and an MCP prefix not on its list (M1). X1 records such a tool at each registration (W-C02-12; C03 test 3).
- **A deny added mid-session** may leave an already-seen definition visible ([doc] R7 1 (f)); calls are blocked from the next request on. Step A7 records it for the working session.
- **`refuse` cannot be observed from the session** ([doc] R7 1 (b)); its platform side is C03 test 3's (N-137). Whether it also drops routine firings or `send_later`'s deliveries is not documented; step A5 observes the second.
- **The kept tools rest on the guard alone** (EV-C01-004 R1): `add_repo` stays in the three environments' sessions, limited only by S5; `send_later` lets any DevOS session with this repository put one-off entries in Batu's routine list, limited to the calling session only by its observed form (1.4 items 1 and 3).
- **Another name in a session.** Where the server registers as `Claude_Code_Remote` or by its UUID, the guard's M1 also denies the kept tools (1.4 item 4).
- **Not observed through any list DevOS has:** the entries under the two other names, `RemoteTrigger` and `check_repo_access` (4.2).
- **D-003's and D-020's residuals stand.** Both layers run inside the session, from files DevOS can change, and neither is an authority boundary (FR-05 B; EV-C01-004 S9, section 4 R1 and R5). The verdict claims nothing beyond that layer (point 9).

## Not covered here

As the item states: the bridge in sessions of `devos-calisma`, `devos-denetim` and `devos-sinav` (W-C02-12's sessions first, then X1 and C03 test 3, N-137); the platform side of `onFailure: "block"` and of refusing inbound messages (C03 test 3); the server-level deny that replaces the bridge (C12, N-140); which role may read which sessions and routines (C03, N-203); routine sessions (C06).

## Open

- `SendUserFile` is allowed by the guard (T1) with no recorded use; it reaches only the user, so it is outside S9 and outside this item.
- Whether a `general-purpose` subagent's list carries the session's MCP tools, and whether the session's deny rules filter it, is not in what R7 read; step S0 settles the first, and the pair S0, A4 and A6 the second.
- The mcp, permissions and self-hosted pages give no point at which a list is complete; the 10-minute interval is a check, not a proof (4.1).
