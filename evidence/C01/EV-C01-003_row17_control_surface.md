# EV-C01-003 · C01 row 17 under PC-21 item 7: what the documentation says a session can do to the account's sessions, routines and environment settings outside its own environment (W-C01-36)

**What this is.** This is the evidence for W-C01-36 (`plan/work/W-C01-36.md`). It covers plan C01 row 17, "Control surface across environments", as the PC-21 note under C01 item 7 takes it. The platform's current official documentation was read on 2026-10-10 for one question: what a session's own tools are documented to do to sessions, routines and environment settings outside the session's own environment, and whether the documentation states any limit by environment. The reading is set beside L-119's observation that a session in Accept edits cannot start sessions. The record then gives the two dispositions the item asks for: (a) row 17's unfavourable case, recorded as the design, and (b) N-047. This is a documentation reading only. Apart from L-119, which is cited, nothing here is an observation of the platform's behaviour.

## Disciplines (D1–D9)
D1: yes: I kept the documented isolation of each session's machine apart from the account-level controls a session may reach, so that the isolation statements are not read as a limit by environment.
D2: yes: PC-21 item 7 already says "not stated", so I searched the full documentation text for a statement either way before recording "not stated", and I list the favourable statements as counter-evidence in section 6.
D3: yes: I mapped each part of the acceptance block to a section here: the reading with its date and L-119 (sections 1 to 3), the PC-21 item 9 claim (section 4), and dispositions (a) and (b) (section 5).
D4: yes: every documentation fact is recorded as "not independently tested", and the independence level is declared as same-session fresh-context; nothing here is presented as a verification of platform behaviour.
D5: yes: I read the raw page text with read-only requests instead of a fetch-tool summary, quoted from it, and backed each "not stated" with a term search of the documentation's full text.
D6: no
D7: no
D8: yes: before reading the documentation I confirmed the working tree is clean at `main` `7d07ef7`, and read the item, PC-21 items 7 and 9, row 17, the 6.7 row, N-047, L-119, W-C01-32 and W-C01-41 at that head.
D9: uncertain: the task limits sources to current official documentation, and a platform fact needs a current primary source (D9 item 4), so I did not consult the library; this reading is new research with candidate status.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `7d07ef7d36efa2f6a9dbbbe7d2ace4eafa3e2389` (PR #201, the C01 re-plan under FR-05 and PC-21), at which W-C01-36's acceptance condition is in force |
| Deployment configuration | Working session `session_01XyxvJd3RayQk4HCrjurbVH`, cloud. The documentation's changelog names 2.1.296 (9 October 2026) as its newest release. The pages describe the current release; this session's Claude Code version was not read |
| Criterion version | W-C01-36's acceptance block at `7d07ef7`; plan C01 row 17 and the PC-21 note under C01 (items 7 and 9) at the same commit |
| Input | The question above, given to a researcher subagent together with the acceptance block, PC-21 items 7 and 9, row 17's success condition and fail path, the 6.7 row "The Claude account's control surface", N-047, L-119, and sections N1 and N4 of `evidence/C01/raw/FR-05_counter_assessment.md` |
| Actual observation | Sections 1 to 3 below: what the documentation states (quoted), what it does not state, and how it relates to L-119 |
| Raw evidence ID | This researcher report, working session above, 2026-10-10 |
| Independence level | Same session, fresh-context researcher subagent (declared, Ek A 5.3) |

**The documentation read.** The official Claude Code documentation, base address `https://code.claude.com/docs/en/`. Each page was read in its raw form (`<page>.md`) with read-only requests between about 22:28Z and 22:35Z on 2026-10-10. **Reading date: 2026-10-10.** **Page dates:** no page read carries a last-updated date of its own. The HTTP `last-modified` header equals the time of the request, so it is not a page date. The changelog is dated per entry. No fetch-tool summary and no secondary source was used.

| ID | Page (under the base address) | Read |
|---|---|---|
| S1 | `claude-code-on-the-web` (Use Claude Code in the cloud) | Overview, environments, terminal and cloud, work with sessions, security and isolation, limitations |
| S2 | `cloud-environments` | Overview, Default environment, configure, `/remote-env`, archive, shared environments, what carries over |
| S3 | `routines` | Overview, create, triggers (API, GitHub), manage, repositories, connectors, environments, usage, troubleshooting |
| S4 | `permission-modes` | Available modes, actions no mode auto-approves, cloud-session modes, the bypass section's notes on cloud and messaging |
| S5 | `permissions` | The passage on tools that require user interaction (L-119's basis) |
| S6 | `tools-reference` | The tool table (`ListAgents`, `RemoteTrigger`, `SendMessage`, and others) |
| S7 | `agent-sdk/typescript` | The `RemoteTrigger` input reference |
| S8 | `cross-session-messaging` | Reach, cross-machine delivery, incoming-message handling, restriction, availability, limitations |
| S9 | `remote-control` | Headings; its statements about cloud sessions and messages |
| S10 | `claude-projects` | Overview, organization, approvals, environment, settings, relation to other features, limitations |
| S11 | `security` | Cloud execution security |
| S12 | `model-config` | Effort resolution order; ultracode |
| S13 | `settings-reference` | The `effortLevel` and `ultracode` rows |
| S14 | `mcp` | "Require approval for a specific tool" |
| S15 | `ultrareview` | Launch, pricing |
| S16 | `changelog` | Newest entries |
| S17 | `llms.txt`, `llms-full.txt` (the index and full text, one level up at `https://code.claude.com/docs/`) | Used to find pages and to search for terms behind "not stated" |

## 1. What is stated

**1.1 Sessions: starting, steering and messaging them**
- Isolation: "Each cloud session is separated from your machine and from other sessions through several layers". The layers named are an isolated VM, network access controls, credential protection and network secrets. (S1; S11 states the same.)
- Starting cloud sessions: the surfaces listed are the browser, mobile, the Desktop app, the terminal (`claude --cloud`) and routines. `--cloud` with `-p` and a session ID "queues a message into that existing session". Follow-ups are sent from "the `claude` CLI on any machine where you're logged in with `claude auth login`". (S1)
- Projects: the project conversation is "one long-running session where Claude acts as coordinator", and "In a project, Claude starts and tracks the sessions instead of you". "Every new cloud thread starts in the project's cloud environment". Project settings are changed "at claude.ai/code or in the desktop app, not in `settings.json`". Projects are in public beta on Pro and Max. (S10)
- Cross-session messaging: `ListAgents` lists, among others, "while this session is connected to Remote Control, your cloud sessions". A message to a cloud session travels "Through Anthropic servers, straight to the cloud session" (S6, S8). The Remote Control connection also carries messages "from your cloud sessions" (S9).
- An incoming message "can't approve anything". The receiving Claude is told never to change permission settings, `CLAUDE.md` or other configuration because another session asked, commands in the message do not run, and permission prompts still fire. Sending and listing are removed by deny rules naming `SendMessage` and `ListAgents`; receiving is stopped by `crossSessionInbound: refuse`. (S8)
- Ultrareview: `/code-review ultra` "launches a fleet of reviewer agents in a cloud sandbox" and runs as a cloud session. A confirmation dialog with an estimated cost comes first. After three free runs a review is billed as usage credits. (S15)
- Basis of L-119, re-read: MCP tools marked `requiresUserInteraction` "also still prompt when a hook returns `"allow"`" (S5). Such tools are listed under "Actions no mode auto-approves" (S4). A server sets this mark through `_meta["anthropic/requiresUserInteraction"]` (S14). Cloud sessions offer Accept edits, Plan and Auto; "Accept edits corresponds to `default` mode" (S4).

**1.2 Routines: creating, changing and triggering them**
- Scope: "Routines belong to your individual claude.ai account". The web, the Desktop app and the CLI "write to the same cloud account". (S3)
- Commands: `/schedule` can be run "in any session" to create a routine, and `/schedule list`, `update` and `run` manage routines. However, "inside a cloud session ... submitting `/schedule` answers that the command isn't available in that environment. Manage routines from the web UI instead". (S3)
- The `RemoteTrigger` tool "Creates, updates, runs, and lists Routines on claude.ai. Backs the `/schedule` command". Its actions are `list`, `get`, `create`, `update`, `run`, `create_webhook_trigger`, `list_runs` and `get_run_log`. In the tool table it is marked "Permission required: No". It is available only with a claude.ai login on a plan with Routines, and absent when an organization policy turns off cloud sessions or routines. (S6, S7)
- Triggers: a schedule; an API trigger, whose token is "scoped to triggering that routine only" and is created on the web only; a GitHub trigger, which "starts a new session automatically when a matching event occurs on a connected repository"; and **Run now** on the web. (S3)
- Each routine "uses a cloud environment". The routine's Edit form changes its prompt, repositories, environment, connectors and triggers. (S3)
- In a project, "Claude creates a routine that runs as threads in that project" when asked for scheduled work. (S10)
- Routine sessions: "there is no permission-mode picker". They run "without stopping for approval apart from some artifact actions". The form has a model selector. "Routines are in research preview." (S3)

**1.3 Environment settings**
- Environments are created, edited and archived "from the environment selector, which you reach at claude.ai/code ... or from the prompt box in the Desktop app". Environments you create "are personal to your account". (S2)
- "`/remote-env` only sets the default: it doesn't start a session, and it can't add or edit environments." (S2)
- After archiving, "No new session can start in an archived environment, on any surface". (S2)
- "Anyone who uses the environment can read its environment variables and setup script." (S2)

## 2. What is not stated

1. **No limit by environment is stated for any control in section 1.** This covers starting, steering or messaging sessions; creating, changing or triggering routines; and environment settings. Where the documentation gives a scope, it is the account: routines "belong to your individual claude.ai account", environments are "personal to your account", and messaging reaches "your cloud sessions". It states the environment only as what a session runs in. A search of S17 for wording about other, each, per or across environments found no statement on this question.
2. **Which session-management tools a cloud session is offered.** The tools L-119 records (`create_session` and the executor's other session tools) are not documented by name. A search of S17 for `create_session` and `get_session` finds only the Agent SDK's functions over local session files. Whether those tools carry `requiresUserInteraction` is not stated; L-119 already recorded this.
3. **Whether `RemoteTrigger` is present in a cloud session.** Only `/schedule`'s answer there is stated. If the tool is present, no limit to the session's environment is stated.
4. **Whether a cloud session is, or can be, connected to Remote Control.** So it is not stated whether `ListAgents` and `SendMessage` reach the account's other cloud sessions from inside a cloud session.
5. **Whether `claude --cloud`, to start a session or send a follow-up, works from inside a cloud session.** The documentation asks for a CLI "logged in with `claude auth login`" and says nothing about a cloud session's own CLI.
6. **Any tool or command by which a session creates, changes or archives an environment, or changes a routine's or project's environment.** The documented ways are the claude.ai/code selector, the Desktop app, the routine Edit form and project settings. How far `/schedule update` reaches into a routine's environment is not stated.
7. **The permission mode and the effort level of a routine session.** Whether a tool that requires user interaction is refused, waits or runs in a routine session is also not stated.
8. **The environment in which a project's coordinating conversation, or an ultrareview, runs.**

## 3. L-119's observation, read with this documentation

On 5 October 2026 a session in Accept edits was refused twice when starting a session ("MCP tool call requires approval"; `plan/ledger/C00-log.md` L-119). The documentary basis it cited is still on the pages today (S5, S4).

The observation covers one tool path, in Accept edits. It says nothing about the following, so it is not a limit by environment *(researcher's reading)*:
- routine sessions, which have no permission-mode picker and run without stopping for approval (S3; section 2 item 7);
- messaging;
- routines;
- environment settings.

Row 17's own text already notes that "the mode of routine sessions is not known". That remains so.

## 4. The recorded claim (PC-21 item 9)

Each bullet of section 1 is recorded as: **"guaranteed by platform (documented in Sn, read 2026-10-10); not independently tested"**, where Sn is the page named at the end of that bullet. For example: "`/schedule` is not available inside a cloud session: guaranteed by platform (documented in S3, read 2026-10-10); not independently tested."

A capability stated in section 1, such as `RemoteTrigger` creating routines, is recorded in the same form. There it means the documentation states the platform offers it, and the design treats it as possible. It is not a positive observation (D-017 item 3).

Qualifiers, each confirmed on 2026-10-10:
- Per environment, only the variables, secrets and network setting are separate. An environment is "the saved configuration that controls network access, environment variables, and setup scripts", plus network secrets on Pro and Max (S1, S2).
- The GitHub identity and the account's connectors are shared across the account: "Anything a routine does through your connected GitHub identity or connectors appears as you" (S3).
- An environment's variables are readable inside its own sessions (S2).
- The channel to the model's own service stays open whatever the network setting: "Claude Code can still communicate with the Anthropic API" (S1).
- Routines are a research preview (S3), so these readings are repeated when the platform changes (plan 0.3 item 12).
- Added for this row: the documentation scopes routines, environments and reachable sessions to the account, and states no limit by environment (section 2 item 1).

## 5. Dispositions

**(a) Row 17: the unfavourable case is recorded as the design (PC-21 item 7).**

The documentation states no limit by environment for any part of the account's control surface. It scopes routines and reachable sessions to the account, and it does not state which of these controls a cloud session has (section 2, items 1 to 6). Row 17's fail path therefore applies as the design:
- Separation of authority between environments rests on the guard hook alone. The guard is a check inside the session, and FR-05 B does not count that as an authority boundary.
- The binding enforcement stays where DevOS controls it: the tokens, the database's role rules and GitHub's rules (FR-05 A.4).
- FR-05 is the frame review the fail path requires before C02.

For the 6.7 row "The Claude account's control surface":
- This record answers its mark "[Awaiting verification: C01 #17]": the documentation does not state the point (read 2026-10-10), so it is treated as possible.
- Its layers stay as written: the guard hook (session tools only on the session's own work), and L-119, which covers sessions in Accept edits but not routine sessions.
- Its layer is tested by W-C01-38 (the guard fails closed, before C02 opens DevOS's environments) and by C03 test 3.

W-C01-41 takes the account-change option, with its effect on Batu's other work, to Batu as his decision under Appendix E section 3, before C02 builds DevOS's environments and the identity chain. Inputs from this reading: the account-level scope of routines, environments and reachable sessions (section 1.2, 1.3), and the shared GitHub identity and connectors (section 4).

Design notes for the executor (researcher's inference, untested):
- Documented configuration can remove `SendMessage` and `ListAgents` with deny rules (S8), and tool names are what permission rules use (S6). In DevOS's single-repository sessions, the repository's permission rules load (S2). This is a check inside the session, the same kind as the guard, so it does not change the disposition.
- A GitHub-triggered routine starts on any matching event on its repository (S3). The documentation states no condition about which session or environment caused the event. A design that gives DevOS's routines GitHub triggers should treat the start of such a run as not proof that an authorized party caused it.

**(b) N-047: carried, with a named place: W-C01-32.**

- The original question, the effort of sessions *the builder creates*, no longer applies: under D-008 the builder does not start sessions (L-119), and D-009 was withdrawn.
- The re-homed question, the mode and effort of sessions the builder does not open from the app (routine sessions), stays open. The documentation does not state either (section 2 item 7), and W-C01-36 runs no routine.
- **Named place:** W-C01-32, the design of PC-21 item 1's single routine, is the only place in C01 where such a session is observed. Its runs record the permission mode and effort shown to that session, or "not visible". This is the session observing itself (D-017 item 2(a)), and it stays within W-C01-32 acceptance item 1 ("what a run records").
- **Condition:** W-C01-32's acceptance does not name N-047. Before W-C01-32's design is written, a dated line on N-047 must name W-C01-32, and W-C01-32's "Serves" line must name N-047. Its acceptance block is unchanged.
- If the record shows a settings change is needed, that becomes a new item (`plan/work/C01.md`, N-047 row).
- Alternative, if the executor prefers: a note carrying N-047 to C06, where DevOS's routines are built.

Documentation for the carry:
- Routines have a model selector and no permission-mode picker (S3).
- Effort is resolved in this order: `CLAUDE_CODE_EFFORT_LEVEL`, `--effort` or `/effort`; then `effortLevel` or `modelSettings` in any settings file; then the model default, which is `medium` on Opus 5.5 (S12, S13).
- "Ultracode is a Claude Code setting rather than a model effort level" (S12). This bears on the wording "ultracode effort" in D-008.

## 6. Counter-evidence and alternatives

- **Statements that lean favourable:**
  - each session's isolation from other sessions (S1, S11);
  - `/schedule` not available inside a cloud session (S3);
  - cloud sessions listed for messaging only while connected to Remote Control (S6, S8);
  - environments edited only from the selector or the Desktop app, and `/remote-env` unable to edit them (S2);
  - incoming messages unable to approve anything or change configuration (S8).

  Each of these concerns a machine, a command, a channel condition or a user interface. None states a limit by environment. If any were read as a limit, it would apply to all environments alike, not separate one from another *(researcher's reading)*.
- **Alternative frame: "not documented" means "not possible".** Rejected. Absence in the documentation is not absence on the platform, and L-119 itself shows session tools in use that the documentation does not name.
- **If a later reading finds a stated limit by environment,** the record is re-read under FR-05's reopen_if. This does not change today's design.

## 7. Limits of this reading

- About 45 read-only requests. Most pages were read by section and by search, not in full (see the table). The following were searched only: `scheduled-tasks`, `commands`, `agent-view`, `agents`, `sub-agents`, `workflows`. The following were not read: `agent-teams`, `channels`, the Claude Tag, self-hosted environment, Desktop and mobile pages, `server-managed-settings` and `data-usage`.
- Process deviations:
  1. At the start, the documentation index and its response headers were saved as two scratch files in the session's scratchpad directory, outside the repository. This goes against the researcher role's "write no file". Every later read went to standard output only.
  2. A search of `plan/` for "N-047" returned one line from the body of W-C01-11, which the task excludes. That body was not read further and is not used.
  3. Beyond the listed inputs I read FR-05's "Decision" A and B and "What is Batu's", D-017, D-009's front matter, W-C01-32 and W-C01-41. None of these is excluded. FR-04 was not read.
- The pages are undated. Because routines are a research preview, this reading is repeated at a platform change (plan 0.3 item 12).

Guard denials: none.
