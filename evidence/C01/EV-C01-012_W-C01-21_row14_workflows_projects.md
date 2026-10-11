# EV-C01-012 · W-C01-21: row 14, dynamic workflows and Projects (the working session, 2026-10-10 and 2026-10-11)

**What this is.** The record W-C01-21 asks for: plan C01 row 14, point by point against W-C01-21's acceptance block. Row 14 needs no probe setup, and nothing was turned on to observe it. Dynamic workflows were observed in the working session, a cloud session opened from the app, where the installation's own work ran eight of them. Whether Projects is enabled on the account could not be checked from a session, so that part is a failed part, and the row's fail path applies to Projects (PC-28). The PC-21 note under the C01 table does not name row 14; its item 9's claim form is used for every documentation fact below. A number after a colon is a line number at `main` `f957519`; `C01-log` is `plan/ledger/C01-log.md`.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527` (PR #221), at which this record is written. At it: `plan/DevOS_Kurulum_Plani.md` blob `eb1ffa5`; `plan/work/W-C01-21.md` blob `59a959b`; `.claude/settings.json` blob `ce7d09d` (last changed in `5223552`, 2026-10-05; `"ultracode": true` since `889cb68`, 2026-10-04, D-008); `.claude/hooks/tool_allowlist.py` blob `35c23f7` (last changed in `1764100`, 2026-10-06). Both configuration blobs are older than the first run below, so every run met the same settings and the same guard |
| Deployment configuration | The working session `session_01XyxvJd3RayQk4HCrjurbVH` (local ID `0cb29c90-d12e-56b6-9751-2217078b0a90`). A cloud session (EV-C01-004:29), in the environment `devos-kurulum` (EV-C01-007:92). Opened by Batu from the app on 2026-10-10 at about 20:58Z; its first message is the installation `/goal` of Appendix F (C01-log:126, L-178; `plan/ledger.md`:21). Claude Code 2.1.296 as `get_session` reports the session's container (EV-C01-004:29, about 06:03Z; C01-log:351, 08:53Z). Model Opus 5.5. Permission mode `default`, the app's Accept edits, from guard record #27 (C01-log:126) and on every Workflow record below. Effort `xhigh` and `ultracode` true in `get_session`'s `flag_settings` (C01-log:126) and in `.claude/settings.json`:3-4. The guard live: its hooks as configured at `ce7d09d`. Account: Claude Max, extra usage off (plan criterion 25, line 232). For comparison only: the routine `devos-c01-rutin` in `devos-kurulum`, runs R1a and R1b (EV-C01-005 to EV-C01-008) |
| Criterion version | W-C01-21's acceptance block. Its text dates from `ea525d9` (W-C01-01, 2026-10-06) and is unchanged since: the re-plan `44cef4e` (W-C01-31) changed only `depends_on` and added its paragraph, which carries no flag. Read with plan C01 row 14 (line 957, unchanged since the translation `5cf796e`), plan Section 8 items 9 and 14 (lines 837, 842) and plan 5.2 (lines 495-496). The PC-21 note (lines 963-972) does not name row 14 |
| Input | None made for this row. The runs below did the installation's own work (analyses and checks), each with its own tasks; none was started for row 14. Documentation: the raw pages `workflows`, `claude-projects` and `agents` under `https://code.claude.com/docs/en/`, and the index `https://code.claude.com/docs/llms.txt`, fetched with a plain GET on 2026-10-11 at 12:12Z. No page shows a date of its own |
| Actual observation | Points 1 to 5 below: the session's run files, the guard's records of the session's Workflow calls, the log entries that used the runs' outputs, R1a's and R1b's opening records, and the documentation |
| Raw evidence ID | The run files `~/.claude/projects/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/workflows/<run>.json`, one per run of Point 1 (container-local, not published; lost when the container is reclaimed). The guard's decision log `/tmp/devos-guard/session_01XyxvJd3RayQk4HCrjurbVH.jsonl`, records #403, #598, #973, #1698, #2517, #2773, #3147, #3184, #3678 and #4040; `tools/guard_report.py` at about 12:20Z: hash chain intact, last record #4229, `T3 10`. The outputs on `main` that Point 1 names. R1a's and R1b's opening records: `evidence/C01/routine/runs/R1a-20261011T0808Z/R1a/OPENING.md` and `evidence/C01/routine/runs/R1b-20261011T0913Z/R1b/OPENING.md` |
| Independence level | Verified by self-observation (D-017 item 2(a)): the working session's own run files, and the guard's records of the session's own calls, dated 2026-10-10 and 2026-10-11. A fresh-context producer subagent of the same session read them directly on 2026-10-11, between about 12:13Z and 12:25Z. The guard's records are written by the hook, not by the executor's account of its work. The documentation was read by the same producer. Judged by a fresh-context checker (declared, Ek A 5.3). Shared by the runs, the producer and the checker: the session, the model and the guard |

## How the criterion is read

- **"Dynamic workflows."** The platform feature of that name: "A dynamic workflow is a JavaScript script that orchestrates many subagents at once. Claude writes the script for the task you describe, and a runtime executes it in the background" (workflows page, opening). Each `wf_…` run below is one call of the Workflow tool. Plan 5.2 describes the same feature (line 496).
- **"A cloud session"** is any cloud session. The block asks for "the kind of session" (`W-C01-21.md`:33), and the item names the kinds: "the working session, opened from the app, or a probe session started by a routine" (`W-C01-21.md`:20). This record names the kind.
- **"As shown to a session"** (`W-C01-21.md`:34) is what a session itself can see, not what Batu sees on his own screens.
- **The two "if it is enabled" parts** (`W-C01-21.md`:35-36) are reached only when part 2 shows Projects enabled.
- **Fail results** are fixed in the block before the observation (`W-C01-21.md`:45). A part that could not be observed is "could not check", never met, and is handled as a failed part; it moves to a later stage only where its components cannot be stood in for (`W-C01-21.md`:47).

## Point 1. Whether a dynamic workflow runs in a cloud session, with the run's reference and the kind of session: met (the working session)

Eight runs completed in the working session:

| Run | Workflow call: guard record, time (UTC) | Agents (state `done`) | Run file status | Where the records use it |
|---|---|---|---|---|
| `wf_768f4409-f00` | #403, 2026-10-10T22:27:15Z | 3 (3) | `completed` | L-183 (C01-log:181): EV-C01-002, EV-C01-003 and the routine's design |
| `wf_f0a73b27-b6a` | #598, 2026-10-10T23:00:21Z | 3 (3) | `completed` | L-183 (C01-log:182): CHK-C01-025 to CHK-C01-027 |
| `wf_f172f804-e71` | #973, 2026-10-11T06:05:13Z | 6 (6) | `completed` | L-187 (C01-log:221); EV-C01-004:33; `evidence/C01/raw/W-C01-42_platform_settings.md`, `evidence/C01/raw/W-C01-42_practice.md` |
| `wf_8c817917-fe6` | #1698, 2026-10-11T08:02:13Z | 4 (4) | `completed` | L-196 (C01-log:297), L-197 (C01-log:305); `evidence/C01/raw/FR-06_disciplines_analysis.md` |
| `wf_f272e23b-eb3` | #2517, 2026-10-11T09:39:50Z | 6 (6) | `completed` | L-202 (C01-log:352): ran, but its outputs were not used (its tasks lacked the discipline block's exact form); re-run as the next |
| `wf_e413035a-d00` | #2773, 2026-10-11T10:14:04Z | 6 (6) | `completed` | L-202 (C01-log:352): CHK-C01-047, CHK-C01-048; L-203 (C01-log:360): EV-C01-008's analyses |
| `wf_1c8b8c6e-125` | #3147, 2026-10-11T10:59:46Z | 2 (2) | `completed` | L-203 (C01-log:362): CHK-C01-049, CHK-C01-050 |
| `wf_9bd9131a-fd2` | #3184, 2026-10-11T11:01:08Z | 6 (6) | `completed` | Not yet named on `main`: five analyses and a synthesis that classified C01's remaining items; two of its reports were this record's producer's hints |

- **The calls are the session's own.** Each guard record has tool `Workflow`, `agent_id` null (the executor, not a helper), session `session_01XyxvJd3RayQk4HCrjurbVH`, local session `0cb29c90-d12e-56b6-9751-2217078b0a90`, mode `default`, decision `allow`, rule T3, detail "an in-process workflow". Rule T3 allows a workflow only in-process: it denies a script that names isolation, a worktree or a remote value, or one it cannot read (`.claude/hooks/tool_allowlist.py`:193, :1979-1994).
- **The runs ran.** The run files sit in that local session's `workflows/` directory, one per run. Each has `"status":"completed"`, and every one of its agents has the state `done`. Their outputs are filed on `main`, as the table shows, except the last run's and the unused run's.
- **The times agree with the log.** `wf_f172f804-e71` started at 06:05:13Z, and EV-C01-004:33 gives "started 06:05Z, guard record #973". `wf_8c817917-fe6` started at 08:02Z, just after Batu's messages of about 07:56Z and 08:00Z (C01-log:305).
- **Two more calls were allowed while this record was written:** #3678 (11:47:51Z) and #4040 (12:09:29Z). Neither had a run file at the reading, which points to runs still in progress. This record's producer received its task through the workflow harness, so it works inside one of them [inference].
- **The kind of session.** The working session is a cloud session (EV-C01-004:29, accepted on CHK-C01-036), in `devos-kurulum` (EV-C01-007:92). It was opened by Batu from the app with the installation `/goal` (C01-log:126; `plan/ledger.md`:21). It is not a session started by a routine.
- **Sessions started by a routine.** R1a and R1b were offered the Workflow tool, loaded at start, and the bundled skill `workflow-authoring` (R1a `OPENING.md`:22, :38; R1b `OPENING.md`:22, :38). Neither ran a workflow: their records name none, and their steps asked for none. So a workflow has not been observed in a session started by a routine. Row 14 does not require that kind. But DevOS's own sessions are started by routines (`W-C01-21.md`:20). Note N-159 on `plan/work/C06.md` carries this to where DevOS's routines are built, before any work in such a session relies on a workflow.

## Point 2. Whether Projects is enabled on the account, as shown to a session: could not check

- **Where the platform shows it.** The documentation names one place: "If **Projects** doesn't appear in the sidebar at claude.ai/code or in the Code tab of the desktop app, the rollout hasn't reached your account" (claude-projects page, note at the top). That is a screen Batu sees, not a session.
- **Routine sessions.** R1a and R1b list their tools, deferred tools, MCP servers, agent types, skills and plugins (`OPENING.md`:21-24, :32-40 in each). None of them concerns Projects. The platform's own server `claude-code-remote` offers them 3 tools. No routine session was shown whether Projects is enabled.
- **The working session.** Its recorded `get_session` readings name the model, the permission mode, `flag_settings`, the goal, the container's version and the rate-limit fields (C01-log:126, :131; EV-C01-004:29; C01-log:351). None names Projects. These records do not list every field, so they do not show that no such field exists.
- **This record's producer.** It has no `get_session` tool. Reading the session's environment was denied (guard #4149, rule B8); it was not tried another way. The guard names no session tool about projects (`tool_allowlist.py`: no match for "project").
- **Result: could not check** (plan Section 8 item 14). It is handled as a failed part. Its components, the account and its sessions, exist now, so it does not move to a later stage (`W-C01-21.md`:47). The fail path applies to Projects (Point 6; PC-28).
- **What would not change the result.** Batu looking at his sidebar: his answer would not be "as shown to a session", and it would not change the outcome (Point 6). Context only, not evidence of the state: the rollout starts "with accounts that have used cloud sessions and don't have existing projects in claude.ai chat or Cowork" (claude-projects page, note at the top), and Batu has existing claude.ai projects (`plan/Inceleme_Degerlendirmesi_Claude.md`:46). So his account may be late in the rollout [inference].

## Point 3. If Projects is enabled, whether the coordinator starts the next work item without a user message: could not check (not reached)

- Not reached: Point 2 is not shown. Observing it would also need a project on Batu's account, which is a change to his account; nothing is turned on to observe this row (`W-C01-21.md`:20).
- What the documentation says, recorded with PC-21 item 9's claim below: Claude "starts a thread for each task"; you can "send a batch of tasks, tell Claude to start without asking you to confirm, walk away"; on a first project, "Claude takes a turn of its own as soon as the project is created, unless you send a message first"; a thread that reached the plan's limit "continues on its own when the limit resets, so work you left running starts using your next usage window without a message from you"; scheduled work asked for in a project runs as a routine whose runs are threads. It does not say in so many words that the coordinator starts the next task after a thread finishes, with no message. Whether it would is not stated, and is not inferred here.
- Recorded as "could not check", never as met. It falls with Point 2: the fail path applies to Projects as a whole.

## Point 4. If Projects is enabled, the number of new sessions a day it allows, as the platform shows it, with its date: not shown

- Not shown to any session (Point 2), and not reached.
- Documented: "The enforced limit is 200 new threads per day across your projects", and each running thread "is a full session" (claude-projects page, "What draws on your plan"); see the facts below. This gives plan 5.2's figure (line 495) a dated primary source. PC-28 place 1 replaces its "[Assumption: no dated primary source recorded; checked in C01 #14 if Projects is enabled on the account]" with it, and with this row's result (CHK-C01-005 condition 2; `plan/work/C01.md`:131).

## Point 5. Nothing was turned on for the observation: met

- No setting, account option or feature was changed for row 14. The runs of Point 1 were the installation's own work; none was started for this row.
- **Workflows.** "Dynamic workflows are available on all paid plans … On Pro, turn them on from the Dynamic workflows row in `/config`" (workflows page, note at the top). The account is Max (plan line 232). So nothing had to be turned on [inference from the two].
- **Ultracode.** The repository's `"ultracode": true` (`.claude/settings.json`:4) turns on "automatic workflow orchestration for the session" (workflows page, "Let Claude decide with ultracode"). It was set in `889cb68` on 2026-10-04 for Batu's decision D-008, before C01 started on 2026-10-06 (L-168); the file last changed in `5223552` on 2026-10-05. It was not set for this row.
- **Usage.** Workflow runs "count toward your plan's usage and rate limits" (workflows page, "Cost"). They are not a paid feature, and no usage credits were turned on for them. C01's third condition ("No test enabled a paid feature") is judged across the stage at its close (W-C01-30).
- **Projects.** No project was created, nothing was asked of Batu, and nothing on his account changed.
- **This record's producer** fetched three public documentation pages and the index with a plain GET, and changed nothing.

## Point 6. The fail path

The block fixes the results that apply the fail path, "The optional layers are not used", before the observation (`W-C01-21.md`:45): dynamic workflows do not run in a cloud session; or Projects is not enabled on the account; or, if it is enabled, the coordinator does not start the next work item without a user message. Here:

- **Dynamic workflows** run in a cloud session (Point 1). That is not a fail result. They stay what plan 7.2 allows (line 806): helpers inside a single session, under the single-writer rule. N-159 carries the session kind not yet observed.
- **Projects** could not be checked (Point 2), a failed part, so Points 3 and 4 are not reached. The fail path applies. The layer that is not used: Claude Code Projects, the coordinator conversation with its worker threads (plan 5.2, line 495). Why:
  - (a) whether it is enabled on the account could not be shown to a session;
  - (b) separately, by the documentation, every cloud thread in a project gets all of the account's connectors with no per-project setup, and a project runs its threads in one cloud environment. DevOS's sessions run with their connectors removed (row 2; EV-C01-006), and no DevOS environment is a project's environment (EV-C01-004:369).
  - Reason (b) does not replace (a). It says why a later "enabled" would not by itself bring the layer back (PC-28, `reopen_if`).
- **The decision:** PC-28, a plan change under plan Section 14 and working order section 6. The fail path sends no choice to Batu, so no decision record of his is needed (`W-C01-21.md`:43).

## What this record cannot show

- **Self-observation in one session.** The runs, the guard and this reading share the working session. The run files' `completed` status is the runtime's own record; that the runs did their work rests on the outputs filed on `main`.
- **Other kinds of session.** No workflow was observed in a session started by a routine (Point 1; N-159). The documentation says the `ultracode` keyword "doesn't start a workflow" when it reaches the session in "a scheduled task prompt"; it does not say what a routine's prompt that asks for a workflow in other words does.
- **Version and date.** The result is tied to Claude Code 2.1.296 and to the run dates, 2026-10-10 and 2026-10-11. The documentation names version thresholds for parts of the feature (for example, starting a session with ultracode on needs v2.1.203 or later).
- **The raw files are container-local.** The run files and the guard's log live in the working session's container and go with it. The documentation says that in a cloud session the run's results are also saved with the session's conversation history.
- **Projects is a public beta**, and the documentation is undated; these readings are repeated when the platform changes (plan 0.3 item 12).

## Facts taken from the documentation (PC-21 item 9)

Each is guaranteed by platform (documented in the named page, read 2026-10-11 at 12:12Z); not independently tested. Pages under `https://code.claude.com/docs/en/`.

- What a workflow is: "a JavaScript script that orchestrates many subagents at once"; "a runtime executes it in the background while your session stays responsive" (`workflows`, opening).
- Who has it: "available on all paid plans … On Pro, turn them on from the Dynamic workflows row in `/config`" (`workflows`, note at the top).
- Ultracode: "a Claude Code setting that turns on automatic workflow orchestration for the session"; "to have every session start with it, set the `ultracode` setting" (`workflows`, "Let Claude decide with ultracode").
- The keyword in a scheduled prompt: the `ultracode` keyword "doesn't start a workflow when it reaches the session" through "a scheduled task prompt" (`workflows`, "Where the keyword works").
- Approval: in "Manual, accept edits" mode Claude Code prompts for every run unless "Yes, and don't ask again" was chosen; "A hook: a `PreToolUse` hook that allows the call approves it" (`workflows`, "Approve the plan before it runs").
- Where a run is kept: "Every run writes its script to a file under your session's directory in `~/.claude/projects/`"; "In a cloud session, Claude Code also saves the run's results with the session's conversation history, which survives when the session's VM is reclaimed" (`workflows`, "How a workflow runs", "Resume after a pause").
- Cost: "Runs count toward your plan's usage and rate limits" (`workflows`, "Cost").
- Projects' availability: "in public beta on Pro and Max plans and rolling out gradually, starting with accounts that have used cloud sessions and don't have existing projects in claude.ai chat or Cowork"; the sign is **Projects** in the sidebar at claude.ai/code or in the desktop app's Code tab (`claude-projects`, note at the top).
- The coordinator: "one long-running session where Claude acts as coordinator"; "it starts a thread for each task"; "tell Claude to start without asking you to confirm"; on a first project "Claude takes a turn of its own as soon as the project is created, unless you send a message first" (`claude-projects`, opening, "When to use a project", "How a project is organized", "Create a project").
- Threads at a usage limit: a thread "waits and continues on its own when the limit resets, so work you left running starts using your next usage window without a message from you" (`claude-projects`, "Usage and cost").
- The daily figure: "The enforced limit is 200 new threads per day across your projects"; each running thread "is a full session" (`claude-projects`, "What draws on your plan").
- Environment and connectors: "Every new cloud thread starts in the project's cloud environment"; cloud threads get their MCP tools from the account's connectors, and "Every cloud thread can use all of them with no per-project setup"; threads run in auto mode when the thread's model supports it (`claude-projects`, "Choose an environment for threads", "Get skills, plugins, connectors, and tools into threads", "Unblock a thread waiting on approval").
- Routines in a project: "Claude creates a routine that runs as threads in that project" (`claude-projects`, "How projects relate to other Claude Code features").
- Qualifiers (PC-21 item 9):
  - per environment, only the variables, secrets and network setting are separate;
  - the GitHub identity and the account's connectors are shared across the account;
  - an environment's variables are readable inside its own sessions;
  - the channel to the model's own service stays open whatever the network setting;
  - routines are a research preview, and Projects a public beta, so these readings are repeated when the platform changes (plan 0.3 item 12);
  - no page showed a last-updated date.

## Result

| Part | Result | Where |
|---|---|---|
| Whether a dynamic workflow runs in a cloud session, with the run's reference and the kind of session | met: eight completed runs in the working session, a cloud session opened from the app (`wf_768f4409-f00` to `wf_9bd9131a-fd2`); not observed in a session started by a routine (N-159) | Point 1 |
| Whether Projects is enabled on the account, as shown to a session | could not check; handled as a failed part | Point 2 |
| If enabled: whether the coordinator starts the next work item without a user message | could not check (not reached) | Point 3 |
| If enabled: new sessions a day, as the platform shows it, with its date | not shown (not reached); documented "200 new threads per day", read 2026-10-11 | Point 4 |
| Nothing was turned on for the observation | met | Point 5 |

Row 14's success condition is not met: its Projects part could not be checked. The fail path applies to Projects, which is not used (PC-28). Dynamic workflows run in a cloud session and stay as plan 7.2 allows them.
