# W-C02-11: reading R7, the session-tools bridge (documentation, uses, guard rules)

- **What:** researcher R7 (agent a921df8e76ba81ba2; DISCIPLINES OK), its final report verbatim, filed by the executor on 2026-10-12. Documentation read on 2026-10-12 about 17:40Z; every documentation answer is labelled documented, not independently tested. Its scratch copies of the pages stay in the container, not here.
- **Its denial:** #17153 (G0, a read-only grep with an unbalanced backtick; repeated with the Grep tool).

---

## Disciplines (D1–D9)
D1: yes: I kept what the docs state apart from my reading of them, and I give the two load-bearing points as conditions: whether a deny hides a tool or only refuses the call, and that the server's tool set depends on how the session was created.
D2: yes: I checked the task's example uses against the sources instead of adopting them, and found that N-202's check uses `git ls-remote`, not `list_triggers`/`get_trigger`, and that the guard denies both of those today.
D3: yes: I kept to acceptance points 1, 2 and 4 and N-181, and I name the observation that only the producer can make (a session's own raw tool list), because I could not make it.
D4: uncertain: every documentation answer is labelled "documented, not independently tested", and the routine runs' tool lists are treated as those sessions' self-reports.
D5: yes: I read the raw markdown pages with curl instead of WebFetch summaries, and I based the absence claims on a search of the full docs dump that I showed finds the three server names.
D6: no
D7: no
D8: yes: I read the live `.claude/settings.json`, the guard code and the notes at `main` `b641215`, not EV-C01-004's summary of them.
D9: uncertain: I did not consult the research library, because the question is about the platform's current documentation, which item 4 requires from a primary source; library findings would be older.

**Question.** What does the current documentation say about the S9 bridge's entries, and what has the installation used each session, messaging or routine tool for? This is for W-C02-11, acceptance points 1, 2 and 4, and N-181. The producer writes the bridge and its record from this; the checker judges it.

**Sources.** Documentation was read on 2026-10-12 at about 17:40Z. I downloaded each page's raw markdown with `curl https://code.claude.com/docs/en/<page>.md`, plus `https://code.claude.com/docs/llms-full.txt` (9.4 MB). The copies are in `/tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/r7/docs/`, my only scratch files. All documentation answers are **documented, not independently tested**. The Claude Code version observed by the installation is 2.1.296 (`plan/ledger/C02-log.md:105`).

## 1. Documentation

**(a) Form of `permissions.deny` entries** (stated)
- **Built-in tool:** the bare tool name. "A bare tool name like `Bash` removes the tool from Claude's context entirely" (permissions, "Manage permissions"). For messaging the page says to deny "`SendMessage` and `ListAgents`. Both take the bare tool name with no specifier", with the example `"deny": ["SendMessage", "ListAgents"]` (cross-session-messaging, "Turn off cross-session messaging"). Nothing gives a special form for `RemoteTrigger`; tools-reference lists it as a built-in tool name ("Creates, updates, runs, and lists Routines on claude.ai"). So the entries are `"RemoteTrigger"`, `"SendMessage"`, `"ListAgents"`.
- **One tool of one MCP server:** `mcp__<server>__<tool>`, e.g. "`mcp__puppeteer__puppeteer_navigate`" (permissions, "MCP"). For this server: "append two more underscores and the tool name to each rule, as in `mcp__Claude_Code_Remote__add_repo`" (self-hosted-environments-configuration, "Turn off built-in session tools").
- **All tools of one MCP server:** `mcp__<server>`. "`mcp__puppeteer` matches any tool provided by the `puppeteer` server" (permissions, "MCP").
- **What the docs say about MCP wildcards** (stated):
  - "`mcp__puppeteer__*` uses wildcard syntax and also matches all tools from the `puppeteer` server."
  - "Deny and ask rules also accept glob patterns in the tool-name position. The pattern must match the full tool name … `"mcp__*"` matches every MCP tool across all servers."
  - "Allow rules accept tool-name globs only after a literal `mcp__<server>__` prefix" (permissions, "Tool name wildcards").
- **Qualifiers that bear on the entries** (stated, permissions):
  - "An allow rule can't carve an exception out of a deny rule." So a server-level deny cannot keep `get_session`; that is why the bridge is per-tool.
  - "Claude Code … skips any `mcp__` rule that has parentheses."
  - A deny rule naming no known tool gives a startup warning, but "Tool names containing `_` or `*` are exempt."
  - Inference: a rule for a tool absent from a session warns only if its name has no underscore, so `RemoteTrigger` (absent from routine sessions) may warn.

**(b) `crossSessionInbound`** (stated, settings-reference `crossSessionInbound`; settings, exceptions table; cross-session-messaging)
- **Where it goes:** a top-level key, "Scope: Any file". It is not under `permissions`, e.g. `{"crossSessionInbound": "refuse"}`. It requires v2.1.224 or later.
- **Values:** `"accept"` (delivers), `"hold"` ("shows a notice … without delivering it"), `"refuse"` ("Claude Code drops the message"). The default is unset, which decides per message by the two sessions' permission modes.
- **Project file precedence:** "A project or local value applies only when it's stricter". Also: "From project or local settings, `refuse` applies over every other source."
- **Limits:**
  - "Claude Code still binds each session's inbox socket, but drops every message."
  - "A refusing session shows no visible change … to confirm it, check the settings files that apply to that session rather than its status." Its effect therefore cannot be self-observed.
  - Not found in the docs: whether `refuse` also drops routine firings or `send_later` deliveries into a running session.

**(c) The three documented names**
- EV-C01-004 S9 does not spell the names out. It says only that the server "is registered under one of three names" (`/home/user/devos/evidence/C01/EV-C01-004_environment_separation_one_account.md:205,214`). Section 8 item 7 (line 370) names the plan text to change.
- The names are still documented, on self-hosted-environments-configuration, "Turn off built-in session tools" (stated). The page says the server is registered "under one of three names, depending on how the session was created. Claude Code matches the name in a rule exactly, including case". Its rules:
  - `mcp__Claude_Code_Remote`
  - `mcp__claude-code-remote`
  - `mcp__bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a`
- Also on that page (stated):
  - "A rule that names the whole server covers tools the server gains later too."
  - It places the rules in server-managed settings or the runner's `~/.claude/settings.json`, not in a repository file.
- Support for the repository file (stated, settings, "Settings in cloud sessions"): `.claude/settings.json` is "read in a session with one repository". A session with several repositories in an Anthropic-hosted environment reads only `enabledPlugins` and `extraKnownMarketplaces` from it, "not permission rules". So the bridge holds only in single-repository sessions (inference).
- Observed in DevOS: only `claude-code-remote`, in all nine routine runs' `OPENING.md` and in this session's guard log. No record shows the other two names.

**(d) `ccd_session`**
- It is **not** one of the three names. It is a separate server (stated by the docs list above; observed in `evidence/C01/routine/runs/P1-20261011T1337Z/P1/OPENING.md:23`, tools `spawn_task` and `dismiss_task`).
- No documentation: `ccd_session`, `spawn_task` and `dismiss_task` have 0 hits in `llms-full.txt`. The same search finds the three names and `Claude Code Remote` 7 times, so it would have found them.
- CS2 describes its tools as the desktop app's "suggested-task cards" (`evidence/C01/routine/runs/CS2-20261012T0808Z/CS2/OPENING.md:14`). That is the session's reading, not documentation.
- Exact name matching (stated) means **no rule under the three names matches `mcp__ccd_session__*`**. Covering it needs its own entry: `mcp__ccd_session` (server-level) or per-tool `mcp__ccd_session__spawn_task` and `mcp__ccd_session__dismiss_task` (inference from the MCP rule form).

**(e) When the tool list is fixed**
- **Documented** (mcp, "Tool availability"; "Dynamic tool updates"; "Configure tool search"; stated):
  - Servers can still be "connecting in the background".
  - "With tool search enabled, when a server finishes connecting while Claude is working, Claude Code lists the server's tool names to Claude on its next request in the same turn."
  - A server may change its tools mid-session through `list_changed`, and Claude Code then fetches the updated list.
  - Tool search is on by default and MCP tools are deferred.
  - No documented point after which a session's list is complete, and nothing on when platform-attached servers connect.
- **Observed in DevOS (self-reports):**
  - `ccd_session` arrived after the first call in P1, P2, P4 (about 19:16Z, run at 19:14Z) and CS2 (about 08:10Z, boot 08:09:51Z).
  - It was present in both P3 runs, with no timing stated.
  - It was absent all run in R1a, R1b and CS1.
  - `github` was "still connecting at start" in P2, P4, CS1 and CS2.
- **Inference for N-181:**
  - A list taken at start, or only once, can miss a server.
  - `ccd_session` does not appear in every session, so the ✔ control list may lack it, and its absence after the change would then prove nothing.
  - The confirming list therefore needs to be taken after the session's first calls and again later in the same session, at a stated minimum delay; the observed arrivals were within about 2 minutes.
  - If the control did not show `ccd_session`, the record must say that its absence is not evidence.

**(f) Hidden or only refused?** (stated)
- Hidden, for rules in the tool-name position. A bare name, `Bash(*)`, or a tool-name glob removes the tool from context; "Scoped deny rules like `Bash(rm *)`, and all allow and ask rules, don't change which tools Claude sees" (prompt-caching, "Denying an entire tool"; permissions).
- The self-hosted page: "Claude Code removes a denied tool from Claude's context, so the denied tools are absent from its answer."
- **Qualifier:** a deny added mid-session blocks calls "from your next request on". With tool search active "the request's tool definitions don't change", and the permissions page refers separately to "a definition Claude has already seen".
- Interpretation: a session that saw the tool before the deny may still show it from history. The confirming list should therefore come from a **fresh session started after the merge and sync**.

## 2. Uses by the installation (point 1)

**How I searched each source:**
- Ledgers: `grep -o`/`-c` for each tool name over `plan/ledger/C00-log.md`, `C01-log.md` and `C02-log.md`, then the context around each hit.
- Working order: the Grep tool for the names (sections 3 to 10).
- Evidence: `grep -rl` per name over `evidence/`, then the contexts and every run's `OPENING.md`.
- Hooks: grep over `tool_allowlist.py` and `record_owned_id.py`. `reread_after_compact.py` has 0 hits.
- Guard log: `jq` over `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl` (17,200 records, 2026-10-10T20:58:07Z to 2026-10-12T17:42:17Z). It selects the tool by regex and prints only tool, rule, decision, event, first/last time, and main vs subagent. `unknown.jsonl` holds only AskUserQuestion, ExitPlanMode and Read.
- No guard logs of earlier (C00) sessions exist on this machine. A ledger mention counts as a use only where it records a call.

**Limit:** I could not take a session's own list; my tool list has no MCP tools. The full `claude-code-remote` tool list of the executor's session is therefore not observed by me. The names below come from the guard's code and the records. Routine sessions showed only 3 tools of the server: `add_repo`, `subscribe_pr_activity` and `unsubscribe_pr_activity` (P1 `OPENING.md:22`). So the server's tool set differs by how the session was created.

| Tool | Uses found (source) | Needed now? |
|---|---|---|
| `get_session` | Opening check (working order §3 item 1, line 34); usage readings (§7, line 79; C02-log:105); N-111 version comparison (`plan/work/C05.md` N-111). Guard log: 32 allows under S1 (31 main, 2026-10-10T20:58Z to 2026-10-12T17:09Z; 1 subagent, 2026-10-12T16:25Z). | **Keep**: opening check, usage, N-111 |
| `send_later` | Check-ins L-250 (C01-log:813, 822) and L-274 `trig_01A8…` (C01-log:1037, 1054; C02-log:63); C00 resume wake-up (C00-log:134); P-W12-5 sample (C00-log:719). Guard log: 3 allows under S1 (2026-10-11T19:16Z to 2026-10-12T09:14Z). The platform refused it once in an earlier session ("requires approval", C00-log:1322). | Executor's decision. If kept, `ReadNotifications` must stay (deliveries arrive as notifications, C00-log:484, 497) and N-194 stays. If denied, N-194's need goes. |
| `get_trigger` | Only a denied attempt (#14659, S1, on the N-202 check-in; C02-log:63). N-202 itself uses `git ls-remote` (`plan/work/C02.md` N-202). | Not needed for N-202 |
| `list_triggers` | None. The guard denies it (C01-log:1045; R-C00-BOM-7:37). | No |
| `delete_trigger` | Only a denied attempt (#10579, S1; C01-log:822, 824). | No, unless N-194 is fixed and `send_later` kept |
| `update_trigger` | Only a C00 denial (#140, C00-log:1360) | No |
| `create_session`, `send_message`, `create_trigger`, `list_events` | C00 only (C00-log:619, 807, 1274–1289, 1381; 291–295; EV-C00-005). None in this guard log; EV-C01-030:57: "The executor started no session". | No (routines start sessions; EV-C01-004 S9 "Need") |
| `add_repo` | Library attachments in C00 (C00-log:14, 661, 1049); refused by the platform (C00-log:1415; C02-log:60, 2026-10-12T14:44Z). Guard log: 2 allows under S5 at 14:45:11Z. | Executor's decision. Its only recent use was refused by the platform, and S9 says no session needs another repository. |
| `get_event`, `archive_session`, `unarchive_session`, `interrupt_session`, `set_session_title`, `set_session_tags`, `fire_trigger`, `list_sessions`, `list_environments` (one C00 use, C00-log:1268), `list_repos`, `read_documentation`, `subscribe_pr_activity`, `unsubscribe_pr_activity` | No use found (0 ledger hits except as noted; evidence hits are checks, reviews and tool listings) | No |
| `RemoteTrigger` | None; not in any routine session's observed list | No |
| `SendMessage` | No call in the guard log. The working order (§4, line 46) and C02-log:71 state the guard denies resuming a helper. Doc: denying it "also removes messaging to subagents"; the Agent tool is unaffected. | No |
| `ListAgents` | None | No |
| `mcp__ccd_session__spawn_task`, `dismiss_task` | None (0 hits in ledgers and guard log) | No |
| `ReadNotifications` | 6 allows under T1 (2 main, 4 subagent) | Only if `send_later` is kept |
| `PushNotification`, `SendUserFile` | No call. C00-log:620 proposes `PushNotification` as a reminder channel. | Not a session tool in S9's sense; executor's decision |
| `ScheduleWakeup`, `CronCreate`, `CronList`, `CronDelete` | One `ScheduleWakeup` denial by a subagent (#14060, C02-log:49); working order §10, line 163 calls these known over-blocking | No (in-session scheduling only) |

## 3. The guard's current rules (`/home/user/devos/.claude/hooks/tool_allowlist.py`)

- **Allowed MCP prefixes:**
  - `ALLOWED_PREFIXES` (lines 91–96) includes `mcp__claude-code-remote__` only.
  - `mcp__Claude_Code_Remote__*`, `mcp__bf7c680d-…__*` and `mcp__ccd_session__*` are **denied under M1** (lines 2019–2020).
  - Consequence (inference): in a session where the server registers under another name, even `get_session` is denied, so the opening check could not run.
- **`claude-code-remote` tools go through `session_checks` (lines 1455–1515):**
  - `create_session` S2/S3; `add_repo` S5 (`devos`, or the library read-only); `create_trigger` S4/S3.
  - `get_session` S1: allowed without `session_id` or on an owned ID.
  - The `OWNED_TARGET_FIELDS` tools (lines 132–139) are S1 on owned IDs only. `set_session_tags` is S1, owned only.
  - `subscribe_pr_activity` and `unsubscribe_pr_activity` are S1, `devos` only.
  - `send_later`, `list_environments`, `list_repos` and `read_documentation` are allowed freely under S1 (line 140).
  - Any other tool, including `list_sessions` and `list_triggers`, is denied under S1.
- **Non-MCP tools:** an allow list (lines 100–108). `RemoteTrigger`, `SendMessage`, `ListAgents`, `ScheduleWakeup` and `Cron*` are **denied under T1**. `PushNotification`, `SendUserFile` and `ReadNotifications` are allowed under T1.
- **Recorder hook:** `record_owned_id.py` watches only `create_session` and `create_trigger` (lines 16–17; settings.json:44).
- **What the bridge adds on top:**
  - The same denials in Claude Code's permission layer, documented to hold in every mode and to remove the tools from context.
  - `crossSessionInbound: refuse`. Inbound messages are not tool calls, so the guard has no rule for them.
  - It needs no new guard rule family.

## Counter-evidence and alternatives
- The docs place the server deny in managed or runner settings, not a repository file. "Settings in cloud sessions" supports the repository file only for single-repository sessions.
- With tool search on, a deny added mid-session may leave an already-seen definition visible.
- Option (interpretation, not a recommendation): a deny glob such as `mcp__claude-code-remote__*_trigger` is allowed in the tool-name position. The docs show no way to exclude a tool from a glob, so per-tool entries stay the documented route.

## Open
- The executor session's own raw tool list (point 4) is not taken.
- Not found in the docs: whether `refuse` affects `send_later` or routine deliveries; when platform servers connect; what `ccd_session` is.
- Not read: managed-mcp, server-managed-settings and the agent-sdk RemoteTrigger reference.

## For the decision
- The bridge needs entries under `Claude_Code_Remote`, `claude-code-remote` and `bf7c680d-5fdc-5ef4-b4a0-abadb619bf0a`, and a **separate** `ccd_session` entry if N-181 decides to cover it.
- Its per-tool list cannot come from routine sessions' 3-tool view alone.
- `list_triggers` and `get_trigger` have no current need.
- Keeping `send_later` also keeps `ReadNotifications` and N-194.
- Confirmation needs a fresh session and a list taken after the first calls and again later.

## Guard denials
- #17153, rule G0 ("an unbalanced backtick substitution"), on a read-only `grep` of my scratch copy of tools-reference. I repeated the read with the Grep tool rather than a re-quoted Bash command. Please judge whether that fits "repeat the call in a well-formed way"; I did not record it with `tools/guard_report.py` because I am read-only.
