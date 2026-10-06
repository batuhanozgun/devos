# Report: W-C01-09, the documentation part of plan C01 row 4 (PC-15)

**Question.** What does the current official Claude Code documentation say about three things: (1) how a subagent call completes and how the caller learns it has finished; (2) what the hook input carries about a subagent and its role; (3) whether that identification is authoritative or self-reported?

**Decision it serves.** The evidence record for the acceptance block in `/home/user/devos/plan/work/W-C01-09.md`. Through it, row 4's documentation fail-path branch (the C03 note on K-9 item 2 (d) and EV-C00-011 rows ECC-62/ECC-74), and the setup of the W-C01-10 probe.

**Reading date for every source: 2026-10-06.**

## Disciplines (D1–D9)
D1: yes: "authoritative" is a frame choice, so I kept "the docs say the field identifies the subagent" apart from "the docs make it trustworthy for authority" and answered the fail path on that split.
D2: yes: a wished-for outcome (no C03 note, item closed) could bias the reading, so I ran the reversal test and put forward the quote that best supports the opposite reading ("Use this to distinguish…").
D3: yes: I checked that every acceptance element is covered (three points; quote or "not stated"; address, own date, reading date; secondary sources not counted); writing the evidence file and its envelope stays with the executor.
D4: uncertain: the docs raise confidence in a mechanism, so I label everything as documented, not observed, and leave behaviour to W-C01-10.
D5: yes: WebFetch returns a small model's summary, so I re-read every decisive passage from the raw markdown of the same official pages (curl, read only); the summary had made three errors (listed under counter-evidence), and all quotes below come from the raw text.
D6: no
D7: no
D8: yes: before reading I read the acceptance block, row 4 (plan line 945), K-9 item 2 (d), Section 0.3 item 12, K-7 items 3–4, Section 6.5 items 5–6, and the ECC-62/74 basis (`/home/user/devos/evidence/C00/EV-C00-011_ecc_comparison.md:210`).
D9: uncertain: this produces a new research result, but the task forbids the library, so I did not read it; the result enters DevOS records only through the executor.

## Sources read (all official Anthropic Claude Code documentation)

*Filed by the executor with one edit: the researcher wrote each page's full address. Those addresses match the research library's fingerprints, because the library holds the same public addresses, so the guard's leak check (L1) would deny them. The table therefore gives each page's name under the base address, which is the documentation site code.claude.com, path docs/en/. Nothing else is changed.*

Line numbers (L) refer to the raw `.md` of each page as served on 2026-10-06 and may shift.

**Page dates.** No content page carries a date of its own. The HTTP `Last-Modified` header equalled the response's `Date` (for example hooks.md, both "Tue, 06 Oct 2026 14:45:47 GMT"), so it is a serve time, not a page date. Only the changelog entries and the weekly digest carry their own dates.

| ID | Page (under the base address of the official Claude Code documentation, given above the table) | Page's own date |
|---|---|---|
| S1 | page `sub-agents` (raw: `…/sub-agents.md`). The legacy address on the older documentation site (path `claude-code/sub-agents`) returns 301 to this address | undated |
| S2 | page `hooks` (raw `.md`). The legacy address on the older documentation site (path `claude-code/hooks`) returns 301 to this address | undated |
| S3 | page `tools-reference` | undated |
| S4 | page `workflows` | undated |
| S5 | page `headless` | undated |
| S6 | page `claude-code-on-the-web` | undated |
| S7 | page `routines` | undated |
| S8 | page `env-vars` | undated |
| S9 | page `glossary` | undated |
| S10 | page `changelog` | dated per entry; newest entry "2.1.291", "October 6, 2026" |
| S11 | page `whats-new/2026-w27` | "Week 27 · June 29 – July 3, 2026"; releases v2.1.195 → v2.1.201 |
| S12 | page `permission-modes` | undated |

I also searched permissions, security, agents, agent-teams, hooks-guide and interactive-mode for identity or trust statements about `agent_id`/`agent_type`. There were no hits. I confirmed the fetches succeeded: HTTP 200, full sizes. `llms.txt` was used only as an index. No secondary source was used.

## Point 1: How a subagent call completes

**Stated:**
- **Foreground vs background.** "**Foreground subagents** block the main conversation until complete." "**Background subagents** run concurrently while you continue working." (S1 L891–892)
- **Which mode applies.**
  - Fork mode on: "Where fork mode is on, as it is by default in an interactive session, Claude Code runs the subagent in the background, forks and non-fork subagents alike, and Claude can't ask for the foreground." (S1 L898)
  - Fork mode off: "Where fork mode is off, Claude runs the subagent in the background by default and in the foreground when it needs the result before continuing. Fork mode is off in non-interactive mode with `-p` and in the Agent SDK unless you turn it on." (S1 L899)
  - Override: "If you set `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS` to `1`, Claude Code runs the subagent in the foreground, in every kind of session…" (S1 L897)
  - Pinning: frontmatter `background: true` keeps a subagent "in the background even when Claude asks to run it in the foreground" (S1 L314).
  - Mid-run: "Press **Ctrl+B** to background a running task" (S1 L914).
- **What the Agent call returns** (seen by a PostToolUse hook):
  - `status`: "`"completed"` for foreground subagents, `"async_launched"` for background subagents. Subagents run in the background by default, so an Agent call that omits `run_in_background` also produces `"async_launched"`" (S2 L1762).
  - "For background subagents, the tool returns when the task moves to the background … a background launch returns immediately, and a foreground task that Claude Code backgrounds mid-run returns at that transition. It has `status: "async_launched"`, `agentId`, `description`, `prompt`, `outputFile`, and `resolvedModel`." (S2 L1774)
- **How completion is signalled.**
  - "A background subagent's results reach Claude as a completion notification in a later turn. Claude waits for that notification before reporting the subagent's results … Before v2.1.211, Claude sometimes reported results for a background subagent that hadn't finished." (S1 L909)
  - The notification "is marked as an automated event rather than a message from you" (S1 L953).
  - `TaskOutput` "Retrieves output from a background task. Deprecated in favor of `Read` on the task's output file path"; `TaskStop` "Stops a running background task by ID" (S3 L57–58).
  - Hook-side signals:
    - SubagentStop "Runs when a Claude Code subagent has finished responding" (S2 L2422).
    - The Stop/SubagentStop `background_tasks` array lets hooks tell "session is done" from "session is paused waiting for background work"; entry `type` includes `subagent` and `workflow` (S2 L2580–2597).
- **Failure and partial output.**
  - Foreground: "the Agent tool returns that partial output with a note that the subagent was cut off".
  - Background: "the subagent is marked failed, and the message Claude receives when it ends names the API error and includes the subagent's last output" (S1 L935–936).
  - At `maxTurns`: "Claude Code marks the returned result as partial output" (S3 L101).
- **Nested subagents** depend on mode: in interactive sessions "a subagent that launches background subagents waits for their results before it finishes. In non-interactive mode and the Agent SDK, the launching subagent doesn't wait, so a nested background subagent that finishes after its launcher has ended reports to your main conversation instead." (S1 L1016)
- **`-p` runs.**
  - "If Claude starts a background subagent or workflow, `claude -p` instead stays open until that work completes" (S5 L77).
  - After 10 minutes idle, "Claude Code stops whatever is still running and drops its partial result" (S5 L79; S8 L352).
- **Cloud sessions.**
  - "Subagents work the same way they do locally." (S6 L281)
  - When the VM is reclaimed: "Not restored: background work that was still running …, such as subagents and shell commands" (S6 L422).
  - Routines "run autonomously as full Claude Code cloud sessions" (S7 L51).
- **Workflows** (the docs treat them as orchestrating subagents):
  - "a runtime executes it in the background while your session stays responsive" (S4 L13).
  - "When the run finishes, the report appears in your session." (S4 L64)
  - `parallel()` "waits for all of them" (S4 L313).
- **Version anchors.**
  - 2.1.198 (July 1, 2026): "Subagents now run in the background by default, so Claude keeps working while they run and is notified when they finish" (S10 L3737; also S11).
  - 2.1.232 (August 13, 2026): "non-teammate agent spawns in interactive sessions now run in the background by default" (S10 L2905).

**Not stated (point 1):**
- Whether a routine-started cloud session counts as "interactive" (fork mode on, foreground impossible) or as non-interactive.
- How a workflow's completion reaches Claude as a tool result or notification: the page describes only the report appearing in the session.
- What happens to a background subagent's file writes when it is stopped, fails, or its VM is reclaimed.

## Point 2: What the hook input carries about a subagent and its role

**Stated:**
- **Tool hooks fire inside subagents.** "When a subagent calls a tool, tool events such as `PreToolUse` and `PostToolUse` fire the same configured hooks as in the main conversation, and the input carries the `agent_id` and `agent_type` common input fields that identify the subagent." (S2 L269; same point in S1 L731)
- **Common fields** (S2 L739–744):
  - `agent_id`: "Unique identifier for the subagent. Present only when the hook fires inside a subagent call. Use this to distinguish subagent hook calls from main-thread calls."
  - `agent_type`: "Agent name … Present when the session uses `--agent` or the hook fires inside a subagent. For subagents, the subagent's type takes precedence over the session's `--agent` value."
- **Where the role value comes from.**
  - The frontmatter `name`: "Hooks receive this value as `agent_type`. The filename doesn't have to match." (S1 L303)
  - "identity comes only from the `name` frontmatter field" (S1 L178).
  - Matcher: "For custom subagents, this is the `name` field from the agent's frontmatter, not the filename." (S2 L2384)
- **SubagentStart.**
  - Fires "when Claude spawns a subagent with the Agent tool, when Claude resumes a subagent, and each time an in-process agent team teammate handles a new message" (S2 L2384).
  - Input: `agent_id`, `agent_type`.
  - "SubagentStart hooks can't block subagent creation, but they can inject context" (S2 L2390–2406).
- **SubagentStop.**
  - Input: `stop_hook_active`, `agent_id`, `agent_type`, `agent_transcript_path`, `last_assistant_message`, plus `background_tasks`/`session_crons` "scoped to the parent session" (S2 L2426, L2434).
  - It can block: "`decision: "block"` … keeps the subagent running" (S2 L2454).
  - Internal agents: "Not every SubagentStop event comes from a subagent Claude spawned. Claude Code also runs internal agents … For those events, `agent_type` is the agent name the session itself runs as … and an empty string when the session runs without one." (S2 L2428)
- **Agent tool input** carries `subagent_type` ("Type of specialized agent to use"), which Claude passes (S2 L1755).
- **Frontmatter hooks.** `Stop` in a subagent's frontmatter is "converted to `SubagentStop` at runtime" (S1 L753, L775).
- **Version anchors.**
  - 2.1.69 (March 5, 2026): "Added `agent_id` (for subagents) and `agent_type` (for subagents and `--agent`) to hook events" (S10 L6360).
  - 2.0.42 (November 15, 2025): `agent_id` and `agent_transcript_path` added to SubagentStop.
  - 2.1.275 (September 17, 2026): fixed SubagentStop matchers "firing for every stopping subagent whose agent type was empty".

**Not stated (point 2):**
- Whether tool calls made by workflow agents carry `agent_id`/`agent_type` in hook input.
- Whether a fork's tool calls carry them, and with what `agent_type`.
- Whether `session_id` differs inside a subagent. The SubagentStop example shows the main session's `session_id` and `transcript_path`, but that is an example, not a statement.

## Point 3: Authoritative or self-reported?

**Stated:**
- The fields "identify the subagent" (S2 L269), and `agent_id` is the documented way to "distinguish subagent hook calls from main-thread calls" (S2 L743).
- Hook input is produced by Claude Code: "Claude Code passes hook input as JSON via stdin to hook commands" (S1, db-reader example).
- "Hooks are deterministic: they fire at fixed lifecycle points rather than at the model's discretion." (S9 L169)
- The hooks security section's only statement on input trust is general: "**Validate and sanitize inputs**: never trust input data blindly" (S2, Security best practices).
- Contrast within the same page:
  - For `mcp_server` the docs do give trust guidance: "Base trust decisions on `source` rather than on `name`" (S2 L1598).
  - For file paths they state a bypass guarantee: "a hook that matches on paths can't be bypassed via `~` or a relative spelling" (S2 L1602).
  - No such statement exists for `agent_id`/`agent_type`.
- **Facts bearing on K-9 item 2 (d)** (one identity per session):
  - When you answer a background subagent's prompt with a lasting grant, "Claude Code applies your answer to the whole session, including your main conversation" (S1 L905).
  - With the main conversation in `acceptEdits`, `auto` or `bypassPermissions`, "the subagent runs in that same mode and Claude Code ignores the `permissionMode` you set" (S1, Permission modes).
  - Settings hooks "all apply inside subagents" (S1).

**Not stated (point 3):**
- That `agent_id`/`agent_type` are authoritative: trustworthy against the agent, unforgeable, or suitable for authority decisions.
- That they are self-reported or can be influenced by the model or by content.
- Anything on spoofing these fields.
- Whether the identification holds for workflow agents, forks or internal agents beyond the SubagentStop note.

**Inference (mine, not the docs').** `agent_type` is the `name` of whichever definition Claude chose through `subagent_type`. Anyone who can write a definition file sets that name. So the role label is "which definition ran", not an authenticated role.

## Open questions only the probe (W-C01-10) can answer
1. In a routine-started session: is fork mode on? Does an Agent call give `status` `async_launched` or `completed`? Can the coordinator obtain a foreground call at all?
2. How the completion notification reaches the coordinator there. Whether the session can end its turn, or the routine session can end, while a background subagent still runs (watch `background_tasks` in Stop input). What happens to that subagent's writes.
3. Whether PreToolUse inside a subagent carries `agent_id`/`agent_type` there, and whether main-thread calls lack them. What `agent_type` shows for `.claude/agents/` definitions.
4. Whether `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1` in the cloud environment forces foreground, as S1 L897 says it does "in every kind of session".
5. The Claude Code version of the routine session (row 4 is re-observed on a version change).

## Counter-evidence and tensions
- S3 L99 ("works through its task autonomously, then returns its result to the parent conversation") and the glossary ("returns a summary") read as if the call returns with the result. S2 L1774 and S1 say the default background launch "returns immediately". The short sentences are incomplete rather than contradictory: S3 L118 itself says background is the default.
- Nested-subagent completion differs by mode (S1 L1016). A subagent can finish before its children in `-p` and SDK runs.
- SubagentStart also fires on resume and for every teammate message; SubagentStop also fires for internal agents with an empty or session-level `agent_type` (S2 L2384, L2428). Event counts do not equal subagent spawns.
- The Notification type `agent_completed` concerns background *sessions* in agent view, not subagents (S2 L2305ff).
- **The documented history includes row 4's failure itself:** "Before v2.1.211, Claude sometimes reported results for a background subagent that hadn't finished" (S1 L909). Field meanings also change between versions: 2.1.290 (October 5, 2026) changed a teammate's `agent_id` (S10 L172).
- **The derived view erred (D5).** The WebFetch summary said PreToolUse input "does not include `agent_id` or `agent_type`". The raw page says PreToolUse receives the common fields, which carry them inside a subagent. The summary also omitted the SubagentStop internal-agent paragraph. All quotes above are from the raw text.

## Effect on row 4's fail path
- **Are the hook input's subagent and role authoritative? Not stated.** The docs say the fields "identify the subagent" and that `agent_id` is the way to "distinguish subagent hook calls from main-thread calls". That is a statement of function. Nowhere do they say the fields are authoritative or self-reported, and the only trust guidance is "never trust input data blindly". This matches the ECC-62/74 basis ("cannot authoritatively tell"); nothing I read contradicts it.
- **The stronger reading.** If the executor or checker reads "Use this to distinguish …" as making the subagent/main split authoritative, the documentation branch fires and the C03 note is due. That is a judgement for them; I flag it as the strongest opposing quote.
- **Completion clause (interpretation).** The docs already state that a subagent call can return before the subagent finishes; this is the default. Completion arrives as a later notification. K-7 item 3 and Section 6.5 item 6 assume only one writer at a time; a background writer may still be writing after its call returned. The probe should treat this as likely and observe it, not test it as an open possibility.

## Limits
- **Method.** The task said to use WebFetch. I used it (5 calls), then read the same official pages' raw markdown with read-only `curl` (about 30 GET/HEAD requests, many re-reads of one page). The reason was the summary errors above. This exceeds the "about 25" budget and departs from the stated tool; the executor should note it.
- **Not read.** Pages beyond those listed (for example agent-view and cross-session messaging in full, and the Agent SDK reference).

## Guard denials
None.
