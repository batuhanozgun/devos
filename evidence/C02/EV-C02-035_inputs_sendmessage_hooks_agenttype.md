---
id: EV-C02-035
title: "Inputs read before builds: what the documentation states on SendMessage (for W-C02-27) and on the agent hooks (for W-C02-25); the subagent meta files' agentType (for W-C02-24.1)"
stage: C02
kind: observation
source: "researcher a3a38b7edd8cb88c3 (SendMessage), researcher a396ce35152701fcc (hooks), prober a7dceb91bd085dc8c (agentType); each taken with tools/subagent_audit.py last after its end status, DISCIPLINES OK"
---

# EV-C02-035 · Three inputs: SendMessage, the agent hooks, and agentType

Filed by the executor. The reports are verbatim as `tools/subagent_audit.py last` returned them, but for library paths written as `[library id: …]` where the leak check matched them, and one documentation address written as [docs page: ...] for the same reason. Each feeds a later step: part 1 goes to W-C02-27's producer and binding checker with their tasks; part 2 is read against W-C02-25's post-sync rows and fallbacks; part 3 goes to W-C02-24.1's test designer and producer (the `LAUNCH-NOTYPE` case and the type read).

## 1. SendMessage, as the documentation states it (researcher `a3a38b7edd8cb88c3`, for W-C02-27)

Package: none delivered. No start header arrived, so I read /home/user/devos/.claude/roles/researcher.md in full before starting.
Nonce: none delivered
Take-up: PROCEED. The question holds. The producer and the binding checker need to know what the pages state before the schema row exists, and any of the five answers could change how T6's keys, recipient forms and fallbacks are judged. Depth: primary sources, after a short library route. The library holds only older readings of the same pages (September 2026). Its harness study says runtime and tool-API facts must be re-checked against current primary sources. So I read today's official pages as raw markdown with curl rather than through WebFetch's summarising model, and grepped each page whole for `SendMessage`.

## Disciplines (D1–D9)
D1: yes: what the pages state and what the binary does are two different frames, so I kept "stated" apart from "not stated", and wrote as a condition the one caveat that could change the schema-row recipe (whether `SendMessage` is a deferred tool).
D2: uncertain: the approach is already agreed, which pulls toward confirming it, so I looked for statements against it (the documented `summary` key, the forms of session addresses, the reply route) and report them.
D3: yes: I laid out the product as the task's five questions, each with what is stated and what is not, so the producer and the checker can use each line.
D4: yes: a note like this could make T6 look checked against platform behaviour, so I label everything [V] (documentation) and claim no observation.
D5: yes: I read raw page text, not summaries, counted `SendMessage` across each whole page, and re-checked the line numbers EV-C02-023 and EV-C02-030 cite, which have shifted on today's pages.
D6: no
D7: no
D8: yes: I checked the earlier evidence (EV-C02-030 parts 3, 8 and 9.2; EV-C02-023 section 3) against today's pages and the changelog head (2.1.304) before relying on it.
D9: yes: I read the library route (INDEX, CATALOG, the harness study's META, EXP-006 P1-01 and P4-01, the 2026-09-07 review). It justified going to primary sources and changed no fact.

Read, and what each changed:
- Official pages, raw markdown with curl, 2026-10-20 about 14:52Z. The pages carry no version stamp, so the read date is their version. The changelog head is 2.1.304, which matches the session's stated version. Abbreviations:
  - SA: https://code.claude.com/docs/en/sub-agents.md (109,509 bytes, 6 `SendMessage` lines). Read "Available tools" (444), "Run subagents in foreground or background" (909–963), "Subagent names" (964–969), "What loads at startup" (1107), "Resume subagents" (1121–1163) and "Observe and steer running forks" (1225–1272). This is most of the product.
  - TR: https://code.claude.com/docs/en/tools-reference.md (6 lines). Read the table header, the rows `ListAgents` (36), `SendMessage` (49), `SubagentHandback` (53), `TaskStop` (58) and `ToolSearch` (61), and "Configure tools with permission rules and hooks" (68–96). Product.
  - CSM: https://code.claude.com/docs/en/cross-session-messaging.md (11 lines). Read 26–79, 98–156, 157–265 and 266–336. Product; it changed questions 4 and 5.
  - AT: [docs page: agent-teams] (4 lines). Read 48–63 and 222–318. Product; it added the teammate conditions.
  - SR: https://code.claude.com/docs/en/settings-reference.md (3 lines). Read `permissions.deny` (1567–1590) and the agents section (5079–5160: `crossSessionInbound`, `isolatePeerMachines`). Product.
  - H: https://code.claude.com/docs/en/hooks.md (0 `SendMessage` lines). Read the event table (43–44), "PreToolUse" (1725–1745) and the list of PreToolUse input subsections (1775–1952). This limited the work: the page documents no `tool_input` for `SendMessage`.
  - permissions.md and settings.md: 0 `SendMessage` lines in either. Bore on nothing.
  - errors.md: grepped. Lines 4441–4480 cover teammate inbox and restore errors. There is no entry for an unknown subagent recipient.
  - mcp.md: grepped for "deferred". It states only that MCP tools are deferred. That limited question 1.
  - CL: https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md, every entry naming `SendMessage` or `notify_when_idle` (2.1.77 to 2.1.299), plus `ToolSearch` and deferred-tool entries. This changed questions 1, 3 and 4.
- /home/user/devos/plan/work/W-C02-27.md (whole): the acceptance and approach the note serves.
- /home/user/devos/evidence/C02/EV-C02-030_m2_m3_triage.md: grep, parts 3 (240–309) and 8 (1420–1422). It gave the baseline; part 9.2 is pasted in the item.
- /home/user/devos/evidence/C02/EV-C02-023_platform_capability.md, 13–112: how a [V] row carries its source, and the earlier rows 2.16 to 2.21.
- /home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md, 69–96 and 155–337: the method.
- Library /home/user/agentic-os-search (HEAD 941f027):
  - research/INDEX.md (1–40) and research/studies/CATALOG.md (grep): routing.
  - [library id: context study, META], freshness section (52–54): justified the primary-source route.
  - EXP-006 P1-01 (lines 1, 9, 35, 47) and P4-01 (51, 96, 144), and soul-context review 2026-09-07 REVIEW.md:52: older readings of the same pages (dated 27 September and earlier). They agree in substance and changed nothing.
- Deliberately not read: the hooks page's SubagentStart and SubagentStop sections (EV-C02-030 part 3 covers them, and I did not re-read them today); the full errors page; `.claude/hooks/tool_allowlist.py` and the tests (the producer's and checker's field); any binary text (the prober's earlier observation is cited, not repeated).

Relied on:
- `to` is the target field. It takes an agent ID or a name, and resumes a subagent. SA:1131, stated. CL 2.1.77 gives the form `SendMessage({to: agentId})` and says the Agent tool's `resume` parameter was removed. Stated.
- `summary` is an optional input, typically 5 to 10 words, shown as a one-line preview. When it is omitted on a plain-text message, the first line of the message is used, and anything over 200 characters is truncated. TR:49, stated. CL 2.1.222 (a long summary is truncated, not rejected) and 2.1.236 (text left inside the summary field), stated.
- `notify_when_idle` is an input: a one-shot notice when another session on this machine goes idle. CSM:92, stated. Only the main conversation's Claude may subscribe, only to sessions on this machine. For any other target, a teammate or a subagent included, the platform refuses the whole call, message and all. CSM "Limits" under "Get a notice…", 98–107, stated.
- The body field's name is not stated on any page read. CL 2.1.212 speaks of "`SendMessage` bodies" without naming the field. Not stated.
- A message to a completed subagent resumes it in the background, with no new Agent call. SA:1143, stated.
- The same holds for a subagent stopped with `TaskStop`, once its run has exited. SA:1143, stated.
- A subagent the user stopped is refused, and Claude is told it was cancelled. SA:1147, stated.
- A resumed subagent keeps its full history and picks up where it stopped. SA:1125, stated.
- A resume is a new run under the same ID: no new agent ID. SA:1151, stated.
- A resumed run keeps the tool set from its first run. SA:1143, stated.
- Explore and Plan return no ID and cannot be resumed. SA:1128, stated.
- CL 2.1.304 fixed subagents sometimes forgetting recent work when messaged or resumed right after finishing. Stated.
- A running agent is reached by its agent ID. SA:1153, stated.
- How a message reaches a still-running subagent is not stated on SA.
- For messages between sessions, the receiver reads a message between tool calls during an active turn, and an idle receiver gets a new turn. CSM:59, stated for cross-session only.
- CL 2.1.277 speaks of messages from other agents, such as a subagent's `SendMessage`, that arrived mid-turn. Stated. That subagents receive messages the same way is interpreted from it.
- An in-process teammate that is no longer running gets the message as its next prompt. AT:285, stated for teammates only.
- The roster lists `main` and every other named agent, each a valid `to`. It appears only if the agent has `SendMessage` and another agent is named, and it is a snapshot taken at start. SA:1107, stated.
- If a newer agent has taken a name, the send is refused and the error names the agent the name now reaches. IDs are advised. SA:1153, stated.
- An unknown recipient for a subagent target: the outcome is not stated on any page read. CL 2.1.239 names an earlier result, "no agent named …", for a send to one's own session name. Stated in the changelog only.
- A refused cross-session send returns a result beginning `Not sent`. CSM:149 and :323, stated.
- Other sessions are addressed by session name. CSM:131–137, stated.
- Where several sessions share a name, or not every place could be checked, a short identifier is added to each row and used in the address. CSM:131–137, stated.
- Remote Control rows show as `name [ref]`. CL 2.1.225, stated.
- A reply can go to a "session id". CL 2.1.251, stated.
- The prefixes `session_` and `cse_` appear on no page read. Not stated.
- No broadcast is documented: to reach everyone, send one message per recipient. AT:315, stated.
- Team-protocol messages need agent teams. SA:1131, stated.
- Messaging across sessions is plain text only. CSM:330, stated.
- In an interactive session, a resumed agent reports to the subagent that resumed it, which waits for the result. SA:1145, stated as interactive only.
- When a subagent messages its own launcher, the launcher is resumed without its results being redirected. SA:1145, stated.
- Background results arrive as a completion notification in a later turn. SA:953, stated.
- CL 2.1.260 fixed a resuming subagent not being woken by the resumed agent's completion, which had gone to the main conversation. Stated.
- When a subagent sends to another session, the result notes that any reply goes to the parent session, not the subagent. CL 2.1.248, stated.
- A resume report comes back in the sender's tool result. errors.md:4470, stated for teammates.
- A delivered cross-session message can be answered the same way. CSM 75–79, stated.
- `SendMessage` needs no permission in Manual mode. TR:49's last column, "No"; stated.
- A deny rule takes only the bare name. TR:90 (tools not listed accept only the bare name) and CSM:287, stated.
- Denying it removes the tool, and with it messaging to subagents and teammates. CSM:300 and :318, stated.
- CL 2.1.293 fixed Claude being told to message subagents when a permission rule had removed the tool. Stated.
- `isolatePeerMachines: true` asks before a message leaves the machine, even in bypass mode. A `true` from any scope applies. There is no prompt for same-machine messages. SR:5138–5154 and CSM:272–280, stated.
- `crossSessionInbound` governs messages arriving from other sessions only. SR:5098–5115 and CSM 189–219, stated.
- No setting for messages between subagents is stated, other than the deny and the tools lists.
- In auto mode, a classifier reviews each message between agents before delivery. AT:299–302 and CL 2.1.222, stated.
- A message from another agent carries no user authority. AT:297 and CSM:157–163, stated.
- A subagent treats its launcher's messages as task direction, within its own permissions. SA:1155, stated.
- PreToolUse matches any tool name except `EndConversation`. H:1727, stated. That this covers `SendMessage` is interpreted.
- The PreToolUse input reference has no `SendMessage` subsection. H:1775–1952, stated. TR:96 sends readers there for `tool_input` field names.
- A background subagent keeps `SendMessage` and `ToolSearch`. SA:444, stated.
- With agent teams on, a named subagent launches as a teammate. AT:60–62, stated. A teammate needs an interactive session.
- An in-process teammate gets `SendMessage` added even when its `disallowedTools` names it. AT:276 and :278, stated.
- CL 2.1.295 fixed in-process teammates failing their first `SendMessage` until they loaded it through tool search. Stated.
- Tool search defers MCP tools. mcp.md:1512, stated. Whether built-in `SendMessage` is deferred is not stated.
- EV-C02-030 part 8: with the deny in force, `ToolSearch select:SendMessage` answered "No matching deferred tools found". Observed (the record).

Unsure:
- The full input schema (the body field's name and type, and whether the object takes extra keys). Not on any page. Settled by the executor's schema row after W-C02-25's sync.
- Whether `SendMessage` is deferred for the main session or for role subagents. Settled by the executor checking whether `SendMessage` is in its own tool list before reading the `ToolSearch` result (see For the decision, item 3).
- How a message reaches a running subagent (between tool calls, or after the turn), and what an unknown subagent recipient returns. Not stated. Settled by the first natural occurrences (row (ii)).
- Whether this cloud session counts as "interactive" for SA:1145's reply route. Not stated, and not observed here. It decides who receives a resumed sibling's reply (a recorded row in point 10).
- Whether agent teams are enabled in this session. I did not read `.claude/settings.json` or the environment. If they were, the teammate rules in AT would apply.
- What the pages state on SubagentStart at a resume was not re-read today. I rely on EV-C02-030 part 3 (H:2535).

For: the executor, who gives this note to W-C02-27's producer with its task and to its binding checker. The producer builds T6's keys, recipient forms and fallbacks against what the platform states and does not state. The checker judges the build against the same lines.

Received from / Returned to: none taken. Out of scope, reported to the executor: (a) the schema-row recipe in point 11 may misread a tool that loads upfront as "not found" (item 3 below); (b) the documented `summary` input may make T6.1 refuse legitimate calls (item 1 below). Both are the executor's, with the test designer, to weigh. Not done by me.

Product:
- **Question**: what the official Claude Code documentation states, as of 2026-10-20 at 2.1.304, about `SendMessage` on five points: its input fields, messaging running and finished subagents, recipient forms and unknown recipients, delivery and replies, and permission and settings controls. It also asks what the documentation leaves unstated on each. It serves W-C02-27's build and binding verdict for T6, before the executor's schema row exists.
- **Findings** (all [V], page:line as read 2026-10-20 about 14:52Z; "stated" unless marked):
  1. Input fields:
     - `to` is the target, as an agent ID or a name (SA:1131; CL 2.1.77).
     - `summary` is optional, used as a preview, defaulting to the first line, and truncated past 200 characters (TR:49; CL 2.1.222, 2.1.236).
     - `notify_when_idle` exists, and the platform itself refuses it unless the main conversation asks it of a session on this machine (CSM:92, 98–107).
     - The body field's name is not stated. The prober's binary reading gives `message` [O, EV-C02-030 part 4, not a page].
     - Whether other keys are refused or dropped is not stated.
     - No page documents `SendMessage`'s `tool_input` as a hook sees it (H:1775–1952).
     - Whether the tool is deferred for main or for subagents is not stated. CL 2.1.295 shows it was deferred for in-process teammates at least once.
  2. Running and finished subagents:
     - Finished, or `TaskStop`-stopped once exited: resumed in the background, with no Agent call (SA:1143).
     - It keeps its full history and continues where it stopped (SA:1125).
     - The run is new, under the same ID (SA:1151).
     - It keeps the tool set from its first run (SA:1143).
     - Stopped by the user: refused, with "cancelled" (SA:1147).
     - Explore and Plan: no ID, so they cannot be resumed (SA:1128).
     - Running: reachable by ID (SA:1153). How and when the message is read inside a running subagent is not stated (interpretation from CL 2.1.277: mid-turn arrival happens).
  3. Recipients:
     - An agent ID, or a name, checked against the agent the name reached earlier, with a refusal and retarget error on mismatch (SA:1153).
     - `main` is a valid `to`, documented through the roster (SA:1107).
     - Other sessions go by session name, or by name plus a short identifier, or `name [ref]` (CSM:131–137; CL 2.1.225, 2.1.251).
     - No broadcast is documented (AT:315).
     - The unknown-recipient outcome is not stated for subagent targets. CL 2.1.239 implies a "no agent named …" result. For sessions, a refusal begins `Not sent` (CSM:149).
     - The `session_` and `cse_` address prefixes are not stated anywhere read (inference: T6.5 is the item's own pin, and T6.6's exact registry match covers every other form anyway).
  4. Delivery and reply:
     - Between sessions: read between tool calls during a turn, or as a new turn when the receiver is idle (CSM:59).
     - To a stopped teammate: the message becomes its next prompt (AT:285).
     - To a subagent: not stated beyond resumption.
     - Reply: in an interactive session, the resumed agent reports to the subagent that resumed it (SA:1145). Otherwise, background results come as a completion notification (SA:953; CL 2.1.260).
     - Across sessions, the receiver can reply the same way (CSM 75–79). A reply to a subagent's cross-session send goes to the parent session (CL 2.1.248).
     - The sender's tool result is a send or resume report (errors.md:4470; CL 2.1.271). There is no synchronous answer.
  5. Controls:
     - `permissions.deny` takes the bare name and removes the tool entirely, subagent and teammate messaging included (TR:90; CSM:287, 300, 318).
     - `SendMessage` needs no permission in Manual mode (TR:49).
     - `isolatePeerMachines` prompts only for messages leaving this machine (SR:5138–5154).
     - `crossSessionInbound` applies only to inbound messages from other sessions (SR:5098–5115).
     - The auto-mode classifier reviews messages between agents (AT:299–302).
     - With agent teams on, in-process teammates get `SendMessage` whatever their tools lists say (AT:276, 278).
     - No setting scopes messaging between subagents. Not stated.
- **Counter-evidence and alternatives**:
  - `summary` is documented, and the platform fills it in when it is absent. That cuts against T6.1 refusing it (N-K2). The approach's choice stands as a deliberate narrowing, not a platform fact.
  - EXP-006 P4-01 (line 96) imagined direct role-to-role answers within scope, which W27-1 narrows. That is a design choice, not a documentation conflict.
  - EV-C02-023 row 21 and EV-C02-030 part 3 cite SA:1128 and 1131, and SA:1132 and 1143, for the same sentences. Today the `to` sentence is at 1131 and the resume sentence at 1143. Same text, shifted lines.
  - Where I looked for contrary statements and found none: the errors page, the permissions and settings pages, and the hooks PreToolUse section.
- **For the decision**:
  1. T6's keys: the pages support `to`, and state `summary` and `notify_when_idle` as real inputs. Refusing `notify_when_idle` duplicates a platform refusal for subagent targets, so it costs nothing.

     Refusing `summary` may over-block if the model often adds it (inference). Row (ii)'s comparison of the guard record with the tool-use input will show whether it does.
  2. W27-4 (IDs only, no name hint) and T6.6's exact match are consistent with the documentation, which advises IDs (SA:1153).

     The resume facts back P-1 and point 10's recorded row: the same `agent_id`, a new run, and history kept. Point 10's expected "Start record for the same `agent_id`" fits SA:1151.
  3. Schema-row caveat (inference, for the executor): `ToolSearch` loads deferred tools (TR:61). If `SendMessage` loads upfront in the main session, `select:SendMessage` could answer "No matching deferred tools" even when the tool is present. Point 11 would then wrongly take the "not found, settings not picked up" branch. Checking the executor's own tool list first avoids that.
  4. PermissionRequest will seldom see `SendMessage`: it needs no permission, and the only documented prompt is the cross-machine one. PreToolUse is the operative event (H:1727). That supports keeping the "PreToolUse does not see it, so revert" fallback and the transcript check in row (ii).
  5. Who receives a resumed sibling's reply is documented only for interactive sessions. Point 10's recorded row stays the way to settle it.

Guard denials:
- #3097, rule G0 (an unbalanced backtick substitution in a curl and grep pattern). I repeated the read without backticks in the pattern.
- #3114, rule B7 (the `claude` command line carries account credentials; I had tried `claude --version`). I did not pursue the version another way and took 2.1.304 from the changelog head and L-439.

I did not record these with tools/guard_report.py, because my role is read-only; the executor may record them.

## 2. The agent hooks, as the documentation states them (researcher `a396ce35152701fcc`, for W-C02-25)

Package: none delivered
Nonce: none delivered
Take-up: PROCEED. The question is bounded and serves a real consumer: the executor reading W-C02-25's post-sync rows and fallbacks against what the documentation says, not against memory. Depth: a fresh primary-source re-read of the raw pages today, plus the library route. The library cannot settle platform facts, and its freshness rule asks for runtime facts to be checked again. EV-C02-023 and EV-C02-030 part 3 are earlier readings by other agents (views), and the hooks page has changed since 2026-10-11, when the pickup sentence was at H:718; it is at H:720 today. No start header arrived, so I read /home/user/devos/.claude/roles/researcher.md in full. I followed the reading order: Ek D was read only from line 69 on. Line 69 there is the trigger-question block, which the file heads "3." inside section 2. The full texts I applied are that file's section 3, as the task directs, not `.claude/protocols/Dn.md`.

## Disciplines (D1–D9)
D1: yes: I kept "stated" apart from "not stated" for each premise, and gave P-2 as a conditional because some documented conditions would reverse it (the multi-repository cloud rule, trust, a broken file, a ConfigChange block).
D2: uncertain: the build wants P-2 and P-3 to hold, so I reported the conditions that defeat them as prominently as the statements that support them.
D3: yes: I tied each finding to the W-C02-25 row or fallback it bears on, because the consumer reads observations, not pages.
D4: yes: everything is labelled [V] (a page states, it does not show behaviour here), and the one earlier [O] (C01 A3) is named for what it does not show.
D5: yes: I re-read the raw markdown instead of relying on EV-C02-023 and EV-C02-030 part 3, and found facts they do not carry: the settings page's "When edits take effect", the cloud multi-repository rule, the `background_tasks` input, tag escaping and the phrasing warning.
D6: no
D7: no
D8: yes: I read the package, the work item's points 13 and 16 and its approach, and the named evidence first, and noted that the hooks page today is 273,459 characters, against the 273,449 recorded by EV-C02-028.
D9: yes: I read the library's INDEX and the harness study's freshness section; they hold no platform hook facts, and the freshness rule justified the primary-source re-read.

Read, and what each changed:
- /home/user/devos/.claude/roles/researcher.md (package, whole): set the labels (M3), long pages (M6) and failure classes F4 to F6. Justified the work.
- /home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md, lines 69 to 336 only: the method.
- /home/user/devos/plan/work/W-C02-25.md, lines 19, 37, 88, 166 to 195, 230 to 234: defined the rows and fallbacks to read against.
- /home/user/devos/evidence/C02/EV-C02-023_platform_capability.md, lines 11, 23, 56 to 123: the earlier [V] rows. Limited the work to re-checking them and finding gaps.
- /home/user/devos/evidence/C02/EV-C02-030_m2_m3_triage.md, part 3 (by grep over lines 231 to 442) and part 8 (lines 1420 to 1422): the earlier reading. Part 8 bears on none of the five questions.
- /home/user/devos/evidence/C01/EV-C01-017_W-C01-38_guard_fails_closed.md, lines 175 and 196 to 200, and /home/user/devos/evidence/C02/EV-C02-022_correction_plan_rounds.md, lines 768 to 773 (found by a grep of evidence/plan/log): the only earlier [O] touching pickup. Changed the counter-evidence section.
- Library /home/user/agentic-os-search at 941f027: `research/INDEX.md` lines 84 to 95; `research/studies/CATALOG.md` line 29; `[library id: context study, META]` lines 52 to 54 (freshness rule). A grep for SubagentStop, SubagentStart and "file watcher" over research, explorations and development-os found EXP-006 P1-01:61 and :123, and P4-01:131, :132 and :150: older design notes, no version-bound facts. Justified the method; changed no fact.
- Web, all read 2026-10-20 as raw markdown with curl and grep/sed (no file saved):
  - CL https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md: latest 2.1.304 (CL:3).
  - H https://code.claude.com/docs/en/hooks.md (4,232 lines).
  - SET https://code.claude.com/docs/en/settings.md.
  - SA https://code.claude.com/docs/en/sub-agents.md.
  - WEB https://code.claude.com/docs/en/claude-code-on-the-web.md.
  - CE https://code.claude.com/docs/en/cloud-environments.md.
  These are the product. SET's "When edits take effect" and its cloud section changed the answer to (1).
- Deliberately not read: the settings-reference page; the permissions page; the managed-settings page; SET "Fix a broken settings file" (SET:603) beyond its summary line; the agent-teams and env-vars pages; earlier versions of the pages; `.claude/settings.json`, beyond counting that it has no `ConfigChange` entry (0 matches); the hook scripts (the producer's and checker's field).

Relied on:
- CL:3 is `## 2.1.304`, and no later section exists [V, observed today]. The pages carry no version stamp, so the reading date is their version.
- Every page fact below is [V], stated on the page at the line given, unless it is marked interpreted or inferred.

Unsure:
- Whether this session counts as "a session with one repository" under SET:754, with devos at start and the library attached mid-session. The page does not say what attaching a repository mid-session does to which settings keys are read. What would settle it: the guard's log showing PreToolUse decisions after the library was attached, or the post-sync `launch`/`start` records themselves.
- Whether this cloud session is treated as interactive (trust gate, H:4163) or as `-p`/SDK (trusted, H:4165). It already ran settings hooks before the sync, so the gate is evidently passed now [inferred].
- Whether the `agentId` in PostToolUse equals `agent_id` in SubagentStart and SubagentStop. Not stated; the doc examples differ. Settled by acceptance row (iii).
- Whether `stop_hook_active` stays true at a SubagentStop that follows tool calls made during the continuation. Not stated.
- Line numbers are today's; the page moved about 2 lines since 2026-10-11, so a later re-read may shift them.

For: the executor, who files this note as evidence for W-C02-25 and reads the post-sync rows of point 13 and the four fallbacks against it. W-C02-25's binding checker may cite it.

Received from / Returned to: none taken or returned. Two things outside my scope, reported to the executor and not acted on:
- (a) SET:754 may decide P-2 for this session's source configuration, so it is worth a line in W-C02-25's "Counted environment".
- (b) H:1140 warns that imperative, system-style text in `additionalContext` can trigger Claude's prompt-injection defences, and H:1128 says `<system-reminder>` tags inside it are escaped. Both bear on the SubagentStart package text: for the producer and checker of W-C02-25 to weigh, not mine.

Product:

**Question.** What the Claude Code documentation (read 2026-10-20, changelog latest 2.1.304) states, and does not state, on five points. Decision served: the executor's reading of W-C02-25's post-sync observations (point 13 rows (i) to (iv), the rows recorded when they occur, the four fallbacks) and point 16's premises P-2 and P-3. The findings inform the reading, not the decision.

**Findings**

(1) When project settings hook changes take effect in a running session
- SET:582 to 584, heading "When edits take effect" [V, stated]. Claude Code watches the settings files and reloads them on change, and applies most edits to the running session without a restart. Hooks are named among the keys this covers. It also loads a settings file created mid-session if its folder existed at session start (for the project `.claude/` folder, even when the folder is created in the same session).
- SET:586 [V, stated]. The reload covers user, project, local and managed files, and runs the `ConfigChange` hook for each settings-file change it detects.
- SET:588 to 591 [V, stated]. Keys read only at session start: `model`, `effortLevel`, `modelSettings` (and admin-side keys on another page). Hooks are not among them.
- H:720, end of "Disable or remove hooks" [V, stated]. Direct edits to hooks in settings files are "normally" picked up by the file watcher. "Normally" is not explained.
- H:704 to 706 [V, stated]. `/hooks` is a read-only browser. No review or approval step is stated for an edited hook. A grep of today's page for "snapshot", "restart" and "reload" found no text requiring one.
- Timing [not stated]: whether a change applies at once, at the next tool call or at the next turn. The pages say only that the watcher detects the change and reloads.
- CL:1005, under 2.1.290 [V, stated]: a fix for sandboxed Bash commands on Linux that triggered `ConfigChange` hooks and a settings reload mid-command when the settings files did not exist. CL:3115, under 2.1.257: a fix for settings in a `.claude/` folder created after startup not being picked up until restart. Both show a live reload path exists in the product [interpretation].
- Settings and modes that change it [V, stated]:
  - A `ConfigChange` hook that blocks keeps new settings from applying to the running session (H:2898 to 2941, "ConfigChange decision control"). This repo has no such hook (0 matches) [observed].
  - Invalid JSON or a rejected value makes Claude Code skip the file or the entry (SET:702). A skipped file would also drop the guard's entries [inferred].
  - Interactive sessions hold back hooks from every settings file until workspace trust is accepted; `-p` and SDK sessions are treated as trusted (H:4161 to 4166).
  - `disableAllHooks` (H:716) and managed `allowManagedHooksOnly` (H:271) can turn hooks off.
  - In an Anthropic-hosted cloud session with several repositories, the session starts above the clones and reads only `enabledPlugins` and `extraKnownMarketplaces` from each repository's `.claude/settings.json`, not hooks or permission rules (SET:754; CE:299 says repo hooks carry over "in a session with one repository").
- Not stated: whether a subagent already running when the settings change gets the new hooks. Point 13 only counts runs started after the sync, so this does not matter for the rows [inferred]. Also not stated: what attaching a second repository mid-session does to the settings keys read. The `.claude/agents/` watcher (SA:251 to 256) is a separate mechanism for role files, not hooks.

(2) SubagentStart
- Fires when Claude spawns a subagent with the Agent tool, when Claude resumes a subagent, and per new message to an in-process teammate (H:2535) [V, stated]. Settings hooks fire for subagents' start and finish (SA:753) [V, stated]. Background is not singled out; the spawn wording covers both modes [interpretation].
- Input: the common fields plus `agent_id` and `agent_type` (H:2541; common fields at H:745 to 749) [V, stated]. For custom subagents `agent_type` is the front-matter `name` (H:2535).
- Cannot block creation (H:2554). Output `additionalContext` is added to the subagent's context at the start of its conversation, before its first prompt (H:2554 table; H:1118 to 1120: wrapped as a system reminder at that point) [V, stated].
- Size: `additionalContext` is capped at 10,000 characters, measured per field per hook. Above that, Claude Code saves it to a file and passes the path and a preview of up to 2,000 characters. No setting raises the cap, and Claude is not asked to read the file (H:1032 "JSON output", the cap list just after it; H:1130) [V, stated]. W-C02-25's 9,500-byte limit is safe because bytes ≥ characters [inferred].
- At a resume: the hook runs again, but the returned context is injected only if the subagent's context no longer holds the earlier copy, for example after auto-compaction (H:2569) [V, stated].
- New since the earlier readings [V, stated]: a `<system-reminder>` tag inside the string reaches Claude with `<` escaped (H:1128). Text phrased as out-of-band system commands can trigger prompt-injection defences (H:1140).
- Plain stdout is not context on SubagentStart. It goes to the debug log; only SessionStart, UserPromptSubmit, UserPromptExpansion and PostModelSwitch add plain stdout as context (H:808 "Exit code 0" section; H:1161) [V, stated]. So the start hook must emit JSON [inferred].
- Not stated: the order of SubagentStart against PostToolUse on Agent for a background launch.

(3) SubagentStop
- Fires when a subagent has finished responding (H:2573) [V, stated].
- Input: `stop_hook_active`, `agent_id`, `agent_type`, `agent_transcript_path` (the subagent's own transcript, under a nested `subagents/` folder) and `last_assistant_message` (the text of the final response) (H:2577). Also `background_tasks` and `session_crons`, scoped to the parent session (H:2585). That last line was not carried by EV-C02-030 part 3; whether it is new to the page is unknown [V, stated].
- It also fires for internal agents, with `agent_type` empty or the session's own agent name; an agent-type matcher does not match an empty value (H:2579 to 2581) [V, stated].
- Under `SubagentHandback` (2.1.271+, auto mode), `last_assistant_message` is not the report (H:2583) [V, stated]. For Stop, the transcript file is not guaranteed to hold the final message at Stop time on all versions (H:2734) [V, stated for Stop]. This bears on the hook's fallback read of `agent_transcript_path` [interpretation].
- Block: `decision: "block"` with `reason` keeps the subagent running and delivers `reason` as its next instruction. Exit 2 delivers stderr the same way (H:2604; H:2792 to 2803). `hookSpecificOutput.additionalContext` also keeps it running, as non-error "Stop hook feedback" (H:2604, H:2815) [V, stated].
- `stop_hook_active` is true when Claude Code is already continuing because of a stop hook (H:2730). This is stated under Stop input; SubagentStop shares Stop's decision format (H:2604), and "Stop and SubagentStop hooks" share the decision table (H:2794). So that it is true at the run's next SubagentStop after one block is interpretation, not a separate statement.
- How often a block is honoured: under Stop, after eight consecutive continuations by stop hooks the next block is overridden; the count resets whenever Claude calls a tool; `CLAUDE_CODE_STOP_HOOK_BLOCK_CAP` raises it (H:2732) [V, stated for Stop; applies to SubagentStop by interpretation]. The pages state no case where a first block is ignored. "Once" in W-C02-25 is the hook's own rule (C15, C16), not a platform limit [inferred].
- Not stated: a size limit for `reason` (the 10,000 cap lists `additionalContext`, `systemMessage`, `initialUserMessage` and stdout only); whether `stop_hook_active` stays true after tool calls during the continuation.

(4) PostToolUse on Agent, background launch
- A background launch returns at once, and `tool_response` carries `status: "async_launched"`, `agentId`, `description`, `prompt`, `outputFile` and `resolvedModel`, with no usage fields (H:1925). The same applies to a foreground task moved to the background mid-run (H:1925). Foreground results carry `agentId`, `content` and telemetry (H:1909 to 1922) [V, stated].
- Matcher: Task was renamed Agent in 2.1.63, and `Task(...)` references in settings and agent definitions still work as aliases (SA:504) [V, stated]. A hook-matcher alias is not stated; `Agent|Task` matches `Agent` either way [inferred].
- Tool events inside subagents fire the same settings hooks, with `agent_id`/`agent_type` (H:269) [V, stated]. A role's own Agent call would also produce a `launch` record [inferred].
- Not stated: that `agentId` equals `agent_id` in SubagentStart/SubagentStop. The examples differ: "a4d2c8f1e0b3a297" (H:1913), "agent-abc123" (H:2549), "def456" with transcript `agent-def456.jsonl` (H:2596 to 2598).

(5) Timeout and failure for these four events
- Default `timeout` is 600 s for command hooks (H:428). W-C02-25 sets 15 [V, stated]. A hook that reaches its timeout is cancelled and its output discarded; "on most events" it then renders no decision (H:881) [V, stated].
- Exit codes (H:782 to 790, H:855) [V, stated]:
  - Exit 0 applies valid JSON. Exit 0 with unparseable or invalid JSON is a non-blocking error with a `hook error` notice.
  - Any exit other than 0 or 2, or a failure to start, is a non-blocking error: the action goes ahead.
  - Exit 2 per event (H:977 to 1015): SubagentStop prevents the subagent from stopping. PostToolUse shows stderr to Claude (the tool already ran). SubagentStart and SessionStart show stderr to the user only.
  - For SubagentStart the notice lands in the subagent's own transcript, and Claude does not see it (H:1017).
  - On Stop and SubagentStop, exit 2 with empty stdout and a "No such file or directory" stderr is a non-blocking error (H:782 section, per-event rules list).
- `onFailure: "block"` has no effect on Stop or SubagentStop hooks (H:955 to 957). It is not used here [V, stated].
- With `|| true` in the command, a script's exit 2 is masked to 0, so the only block path is the JSON decision on stdout. A timeout kills the shell before `|| true`, so the output is discarded and nothing is decided [inferred from H:881 and shell semantics].
- Not stated per event: what a timed-out SubagentStop does beyond "no decision". The subagent then stops [inferred]. Also not stated: whether a timeout notice appears in the subagent's transcript for SubagentStart.

**Counter-evidence and alternatives**
- No observation in this installation yet shows a new hook event picked up mid-session. C01 A3 (EV-C01-017:198) observed a live guard after a sync, and says itself that this does not show the setting was applied. The guard script is re-read on every call, so its liveness does not test the watcher [interpretation]. EV-C02-022:771 lists pickup without a restart as a thing to observe; EV-C02-023:69 found no changelog entry on it.
- My recollection is that older documentation described a startup snapshot of hooks, with external edits needing review in `/hooks`. Today's page has no such text, and `/hooks` is read-only (H:706). This is memory, not a source, and does not count against [V].
- SET:754 is the strongest documented defeater of P-2 for this session if it counts as multi-repository. Hooks were running before the attachment, and the guard still runs, which points the other way [inferred, not checked].
- Where I looked for counter-evidence: the package's F-classes, our C01 and C02 records (grep for "picked up", "file watcher", "ConfigChange"), the changelog (grep for reload and snapshot terms), and the library (no hook facts).

**For the decision**
- Fallback "neither record means the settings were not picked up": the documentation states live pickup (SET:584; H:720). Read against it, a missing `launch` and `start` points first to the documented exceptions before platform behaviour: the multi-repository rule (SET:754), a skipped file or entry (SET:702), the trust gate (H:4163), or a script that failed quietly (non-blocking, H:786).
- A `launch` without a `start`: the documentation states that SubagentStart fires on every Agent spawn (H:2535; SA:753). Read against it, the likely causes are a matcher miss (`agent_type` must equal the front-matter `name`) or a non-JSON or oversize output before platform non-firing. The `skills:` fallback stays valid.
- Block honoured: documented as continuing the subagent, with `reason` as the next instruction, up to an 8-continuation cap (H:2604, H:2732). An ignored first block would contradict the pages and is worth recording as such.
- Rows (iii) and (iv): `agentId` is documented in the background PostToolUse (H:1925); that it is the same string as `agent_id` is only settled by row (iii).
- Nothing here changes W-C02-25's design. It narrows how a red row is read.

Guard denials: none.

## 3. The subagent meta files' agentType (prober `a7dceb91bd085dc8c`, for W-C02-24.1)

Package: none delivered (no start header arrived). I read /home/user/devos/.claude/roles/prober.md in full before starting.
Nonce: none delivered
Take-up: PROCEED. This is a question I settle myself, and it can be settled with readers over files the container holds. The claim's environment is this session (session_01JDJ8fJQmrKpXfiRh1yEoxv, Claude Code 2.1.304, 2026-10-20), and that is the environment I observed.

## Disciplines (D1–D9)
D1: yes: I matched the three sources (the meta's `toolUseId`, the executor's Agent `tool_use.id`, the guard record's `tool_use_id`) by tool-use ID instead of by order or time, so a pairing artefact cannot make the types look equal; the workflow-folder layout is a second case and is absent here, so I limit the claim to it.
D2: no
D3: no
D4: yes: real data has no meta that lacks `agentType`, so I checked that my `grep -L` detector catches one, using a synthetic file in scratch; I also state that `LAUNCH-NOTYPE` has no real negative case in this session.
D5: yes: I read the meta files, the main transcript's tool_use inputs and the guard log directly rather than the docstring of `subagent_audit.py`, and I checked the guard summary (which drops some keys) against the executor's own tool-use input.
D6: no
D7: no
D8: yes: I recorded HEAD, time and version before the rows, and I mark the four unfinished runs (mine is one) as live state that will change.
D9: yes: I read the library line; it supports recording the version from each transcript record and limits the claim to this session and version (drift).

Read, and what each changed:
- /home/user/devos/.claude/roles/prober.md (package): it shaped how I worked (M2, M8, F1, F2). I had already hit F1 once before reading it; see Guard denials.
- /home/user/devos/plan/Ek_D_Dusunme_Protokolleri.md section 3 (lines 69-96) and the full texts of D1, D4, D5 and D9: justified the cross-source join and the negative control. Section 3 points to `.claude/protocols/Dn.md`, which does not exist, so I used the full texts in the same file.
- /home/user/devos/tools/subagent_audit.py (header lines 1-80, grep around lines 268, 434-548): shows that `launch` looks for the meta at `<transcript path minus .jsonl>.meta.json`, either in `subagents/` or in `subagents/workflows/<run-id>/`. It told me which layout to check.
- Library: `[library id: work-environment vertical KEY]` (lines 1-40). The finding sits at `[library id: work-environment vertical, finding 02]` (the task's path leaves out `findings/`), and I grepped it for declared versus observed (lines 8-29). I also read `[library id: hands-on LLM study, its development OS assessment]` section 7.2 (lines 326-330). Together they limit the claim to this realized environment and version; they bore on nothing else.
- Not read, on purpose: any message text in the transcripts or the meta `description` values (removed from my output); finding 07; the rest of the map.

Relied on:
- [O] 59 subagent transcripts, 59 meta files and 55 prefix files, all directly under `/root/.claude/projects/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/subagents/`. There is no `workflows/` folder and no meta file anywhere else under `/root/.claude/projects` (Glob).
- [O] All 59 metas carry `agentType` and `toolUseId` (`grep -L` printed nothing). For all 59, meta `agentType` = the executor's tool_use `subagent_type` = the guard summary's `subagent_type`, joined on the tool-use ID. Count: 59 EQUAL, 0 DIFF, 0 MISSING.
- [O] The guard log holds 59 Agent records (#34 to #3035), all `allow`, all PreToolUse, all from the main session. Rules: T2 ×50, T5 ×3, T5R ×6. The main JSONL holds 59 unique Agent tool_use IDs; 62 lines contain `"name":"Agent"`, and the 3 extra lines are unexplained but add no ID.
- [O] Every transcript record carries `"version":"2.1.304"` (3887 in the main transcript, 11867 across the subagent transcripts). The task also states this version.
- [O] HEAD 9c33473e2083a54127365e1d742b93e223b9e67e; start 2026-10-20T14:51:58Z.
- [I] The run a7dceb91bd085dc8c is this prober run: it is the newest Agent call (#3035, prober) and my first guard record is #3038.
- [O] The four runs without `"finished"` in their meta are also exactly the four without a `prefix.json`: a4fa2557312934f3d, a2b36145a2fa8f0e3, a3a38b7edd8cb88c3, a7dceb91bd085dc8c. All four already have `agentType`.

Unsure:
- The `subagents/workflows/<run-id>/` layout was not exercised in this session, so I cannot say whether a workflow agent's meta carries `agentType`. A session that starts a workflow agent would settle it.
- No real run lacks a meta file or `agentType`, so this session cannot show the fail-closed path on real data. Only a synthetic case can (the test designer's).
- When the meta is first written relative to the launch is not established. The live runs show it exists, with `agentType`, before the run finishes; I did not observe the exact moment it is written.
- I did not explain the 3 extra `"name":"Agent"` lines.

For: the executor files this as evidence for W-C02-24.1 (via `tools/subagent_audit.py last`). The test designer pins `LAUNCH-NOTYPE` against it: no real negative case exists, and every meta is a sibling file `agent-<id>.meta.json`. The producer builds the type read on it, with the workflow layout left unobserved.

Received from / Returned to: none. Noticed outside my scope, for the executor: the task's path to finding 02 leaves out `findings/`; `.claude/protocols/Dn.md`, which Ek D section 3 refers to, does not exist; `prefix.json` is a third file in each run's folder that the `subagent_audit.py` docstring does not mention.

Product:
- **Test and claim:** For every subagent run of this session that the container holds: does it have a `meta.json`, does that carry `agentType`, and does the value equal the launching Agent call's `subagent_type` (in both the guard log and the executor's tool_use)? Where does the meta sit, and is any transcript or meta unpaired? Written before observing: an observation counts as "present and equal" only if the tool-use IDs join across all three sources. A missing key, a missing file or a type difference would each count against the claim. Negative control: a synthetic meta without `agentType` must be listed by `grep -L`. Environment: 2026-10-20, 14:51Z onward; HEAD 9c33473e; Claude Code 2.1.304 (observed in transcript records and stated by the task); the model is as the session states (Opus 5.5), not observed by me.
- **Steps:**
  1. Grep line counts of `subagents/*.jsonl`, exit 0: 59 transcripts. Pass.
  2. Grep of every `*.meta.json` with descriptions omitted, exit 0: 59 metas, each with `agentType`, `toolUseId`, `spawnDepth:1`, `requestShape:"background"` and `launchedWithDefaults:true`; 55 have `finished:true`. Pass.
  3. Pairing with `comm`, exit 0: no transcript without a meta, no meta without a transcript. Every meta is the sibling `agent-<id>.meta.json` of `agent-<id>.jsonl` in the same `subagents/` folder, which is the path `launch` derives. Pass.
  4. Guard log Agent records tabulated, exit 0: 59 records. Main-JSONL Agent tool_use IDs with their `subagent_type` (PCRE grep, prompt text cut away), exit 0: 59.
  5. Three-way join, exit 0: 59 rows, 59 EQUAL, 0 MISSING. Pass.
  6. Negative control, exit 0: `grep -L` listed only the synthetic `agent-neg.meta.json`. The detector works.
  - Raw outputs are in /tmp/claude-0/-home-user-devos/e177dd92-42b7-5480-8039-2655653745ba/scratchpad/ (`joined.txt`, `meta_fields.txt`, `exec_calls.txt`, `guard_calls.txt`, `transcripts.txt`, `metas.txt`, `prefixes.txt`, `neg/`).
  - Table. For every row the transcript and meta are siblings in `.../e177dd92-42b7-5480-8039-2655653745ba/subagents/` and the meta `agentType` equals the type shown. "no prefix" marks the four unfinished runs.

| agent | tool_use_id | guard # / rule | call type = meta agentType |
|---|---|---|---|
| ae8b7fdebcfbd9f53 | toolu_01DZVnqftzFkx595xBcFubrM | 34 T2 | checker |
| a63eb9c7980da259e | toolu_019NpPgAvsQgeE5q5gjNvhgZ | 133 T2 | producer |
| a12dfcbcf90db177e | toolu_01PW48Vc9jGP4cPoCzVKu3PF | 140 T2 | researcher |
| a708d159143834d2d | toolu_01MG9NJrtKu4wxTMK5ohf3JE | 154 T2 | prober |
| a0cc50f9a9191fc93 | toolu_012bBrGvT82U97mUwnBNDQyu | 175 T2 | checker |
| a2e944787a01ea36f | toolu_01E852ueWdXA9gErQiAByoqd | 192 T2 | test-designer |
| aff003977e965b4ee | toolu_01U9TitgwZqAcXZ6ivcBKmtK | 302 T2 | checker |
| ab7920215dfc6c85f | toolu_01JStQG6ppARHoP2toFfQiJs | 482 T2 | producer |
| ab24c84d8f77dbbb1 | toolu_01FBDbH276QoWekvBriKYLY8 | 489 T2 | researcher |
| ae4d875f0b3826b32 | toolu_014x2SqzU1mq4Ynb51iChwVQ | 496 T2 | prober |
| a1d0941b5e8c59178 | toolu_01JyhJQe6Ct2cYyVrj7UhTDn | 502 T2 | checker |
| a01d7b83cc35aa15c | toolu_01VpG3We7csuXRPpWzZfQ9ip | 514 T2 | test-designer |
| a0004abfedb986b57 | toolu_018fjRpvVvk2x3bwq46TZmZS | 666 T2 | test-designer |
| a62f5e18d8d76772e | toolu_01PqLCsuGAYwuyEp9M27ERgR | 673 T2 | test-designer |
| af96c513111bd4214 | toolu_01QNr7mUDEmz1tWvUBkSQYYD | 794 T2 | checker |
| a219e82ff883cf66f | toolu_01UoUnCHHvbi5KWPG6Vt4uzu | 826 T2 | producer |
| ad67bb232bb50343b | toolu_0183Y7WKnXqg7QGNWkcJodp3 | 835 T2 | researcher |
| abc86b55790c7fd15 | toolu_0196xy3hmFwTpfYQ4gqANVB2 | 851 T2 | prober |
| a5309384b6fd9cecb | toolu_017YsCXeq1t5kkPioBfNnWze | 873 T2 | checker |
| a312472717fb8bd4f | toolu_011oRRRMX3R2U5XXj6aDd16A | 888 T2 | test-designer |
| a8a1719bc6b34c5cb | toolu_01MBbfV3F2GAT4EmyJBsDSsg | 1038 T2 | checker |
| a213e56dd62d70fcb | toolu_01JTwHbPVTutCxzSKYH5aris | 1143 T2 | producer |
| abd4a1c4825e250e3 | toolu_01X2KH9mxNurkxSdFfAytxsr | 1154 T2 | checker |
| a3357e0760db31cb3 | toolu_01Y4pcuYXnouTyFPiXdAx8yb | 1218 T2 | test-designer |
| a3fb1e8eadd357b5a | toolu_01NxLCCttiVkpBFFEBUapqGz | 1224 T2 | test-designer |
| ab93b1f522746169e | toolu_01TXMLnA6kXuwV4pT7tPzVzN | 1344 T2 | test-designer |
| add5345412f3a2a03 | toolu_013iaRLGYRUuTirJcrS3ZGBi | 1395 T2 | checker |
| ae43fbfa30d84fd04 | toolu_01GpiZaN1Hp3zhEZfaPR7BHH | 1496 T2 | checker |
| aa5d92b5f5e236415 | toolu_017egM8c486v4MwMvHcnq58F | 1503 T2 | checker |
| a95f40ed306d3a2a6 | toolu_01791JWYGKYykLAf7tdSM9yU | 1543 T2 | checker |
| a780f294ca31e5c6d | toolu_01R5UQAmjxtaoWqPdFnwex8q | 1592 T2 | producer |
| a4185c04bc29e3f0f | toolu_0156Nqi4JXnis5C3cydcWi8i | 1658 T2 | test-designer |
| a7a01aac114f044d8 | toolu_0125DLEZ3v8YnqtemDu7MWUD | 1664 T2 | checker |
| a2f8c2c275156b6ab | toolu_017QDhbqNrS2Uweta6H7S94s | 1744 T2 | producer |
| aff83b01710314731 | toolu_01UgM6ncZrWGpgFATVw4gVnd | 1772 T2 | checker |
| a072ae4c6fedbb95b | toolu_01YHv4LXFPLrzELAG7B5jv51 | 1810 T2 | test-designer |
| a23cb6ab0f24313d4 | toolu_01Qy2RBrWVisYyubdX4mmLbq | 1884 T2 | test-designer |
| a511fc509e57f7b92 | toolu_01ML6PJRMBqunkEQVRJ5x3Rw | 1948 T2 | checker |
| ab50053ed16c6a551 | toolu_0163spk6hU4ejC21htmjRsVy | 2033 T2 | checker |
| a38fc45e28014ad7f | toolu_01FHi2r7WjHMEuJxYnXPNVPq | 2053 T2 | checker |
| affd3d111f37eb182 | toolu_01Ur9HwAc7nbbUV5j6iwxG4N | 2100 T2 | checker |
| ae6341b380e039202 | toolu_01JRsQDXSJSnctZqfCo1nR3H | 2110 T2 | test-designer |
| ab9261648145bad87 | toolu_01WSSCeJPaeohGhayFRZgQnQ | 2284 T5 | producer |
| a5b339bbbefae9987 | toolu_01MWFhAR5Y1bN4s1NTyPmarw | 2365 T5R | test-designer |
| a305b3806c027239b | toolu_01M9cfGFwf2B3DuqayHxFm5e | 2413 T2 | checker |
| ab2fc183532e831c0 | toolu_01X9vZyQQugFBmrMiHgNVLTb | 2511 T5 | producer |
| a122eb8cf11d834cc | toolu_01HioQf3q8CiPPPRgL8ZLo7m | 2611 T2 | checker |
| a52c2fc190f2169bf | toolu_01Wq5DtpzdwWsGebzUqnapje | 2693 T5 | producer |
| a9399b30c91a7ed7b | toolu_019aYz1EV5iEDALNUGmvg5fg | 2713 T5R | producer |
| a920e9d78566eb4ad | toolu_01FsRrwAFQ68FBMQ3fi7Drxt | 2722 T5R | test-designer |
| a7b2114f1f498fa53 | toolu_01AGsZKwQbgoEf2Xpma4HTzK | 2739 T2 | checker |
| a14a3efb001ccc75d | toolu_011bz5ee7JvWKLraJM8r7Fjt | 2846 T5R | producer |
| a7f9429e1c0c07f6c | toolu_01PphrsjsyowGbqC19pqHzZp | 2851 T5R | test-designer |
| a4130a35c857b1edc | toolu_01USgTuZJbnNJzsvykBau9YZ | 2858 T2 | checker |
| a3a03bc5d74e7707b | toolu_01FzgMnc96YLUGBDUzgwS9d6 | 2917 T5R | test-designer |
| a4fa2557312934f3d | toolu_01PP7XCx8ZJzHaEwgAH6ahDw | 2970 T2 | checker (unfinished, no prefix) |
| a2b36145a2fa8f0e3 | toolu_01LFodsyb6jjaur1bwBpotft | 3008 T2 | checker (unfinished, no prefix) |
| a3a38b7edd8cb88c3 | toolu_01Xs98ySoemxG7PwbiteUcYf | 3028 T2 | researcher (unfinished, no prefix) |
| a7dceb91bd085dc8c | toolu_01LgdT5bUgeJPLEFuxxE6uaz | 3035 T2 | prober (this run, live) |

- **Not run:** a version read through the CLI (denied; the version comes from transcript records and the task instead); the workflow-layout case (none exists in this session); a real `LAUNCH-NOTYPE` case (none exists).

Guard denials:
- #3038, rule B7: my first command included `claude --version`, the known failure class F1, made before I had read the package. Instead I took the version from the transcripts' `version` fields and the task's statement, and did not run the CLI again.
- #3059, rule B5: `find` naming `~/.claude`. Instead I listed and read with the Glob tool and `grep -r`, the readers the denial names, and ran no interpreter on guarded paths.
- I did not run `tools/guard_report.py`; the executor records these in its log entry.
