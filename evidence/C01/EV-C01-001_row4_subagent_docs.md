# EV-C01-001 · C01 row 4, documentation part: how a subagent call completes, and what the hook input says about a subagent (W-C01-09)

**What this is.** The evidence for W-C01-09 (`plan/work/W-C01-09.md`): the documentation part of plan C01 row 4, "Completion" (PC-15). The platform's current official documentation is read, with its date, on three points (plan Section 0.3 item 12): how a subagent call completes; what the hook input carries about a subagent and its role; and whether the documentation makes that identification authoritative or leaves it self-reported (K-9 item 2 (d)). The probe part of row 4 is W-C01-10. This record reads documentation only: nothing here is an observation of the platform's behaviour.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `411391577842932e3ab4e8ff25892fa06b69b250` (PR #189, the C01 work list), at which W-C01-09's acceptance condition was in force |
| Deployment configuration | The working session `session_01WKJi23FwAjFtiyD1DbQ2Rs` (cloud, `get_session` `external_metadata.container_cc_version` 2.1.289 at 14:11Z). The documentation's changelog names 2.1.291 (6 October 2026) as its newest release; the pages describe the current release, not this session's version |
| Criterion version | W-C01-09's acceptance block at `4113915`; plan C01 row 4 at the same commit (unchanged since `c843988`) |
| Input | The three questions above, given to a researcher subagent with the row's text, K-9 item 2 (d) and the acceptance block |
| Actual observation | Sections 1 to 3 below: what the documentation states, quoted, and what it does not state |
| Raw evidence ID | The researcher's report: agent `a42e1b2b6506713b8`, working session above, 2026-10-06 (a run of about seven minutes; its fetches carry server times from about 14:45Z), taken with `tools/subagent_audit.py last` and checked with `tools/subagent_audit.py disciplines` (DISCIPLINES OK). Filed at `evidence/C01/raw/W-C01-09_researcher_report.md`, with one edit stated at its head: the full page addresses are given as page names under the documentation's base address, because the full addresses match the research library's fingerprints and the guard's leak check denies them |
| Independence level | Same session, fresh-context researcher subagent (declared, Ek A 5.3); a reading of documentation, judged by a fresh-context checker (W-C01-09's acceptance) |

**The documentation read.** The official Claude Code documentation, on the site `code.claude.com`, path `docs/en/`. Pages: `sub-agents` (S1), `hooks` (S2), `tools-reference` (S3), `workflows` (S4), `headless` (S5), `claude-code-on-the-web` (S6), `routines` (S7), `env-vars` (S8), `glossary` (S9), `changelog` (S10), `whats-new/2026-w27` (S11) and `permission-modes` (S12). The older addresses of S1 and S2 on the earlier documentation site redirect (HTTP 301) to these. **Page dates:** no content page carries a date of its own ("undated"); the changelog is dated per entry (newest: 2.1.291, 6 October 2026), and the weekly digest S11 covers 29 June to 3 July 2026. **Date of reading:** 2026-10-06. Quotes come from each page's raw text; the researcher found that the fetch tool's summary had misstated points and re-read them from the raw text (its report counts three and names two under "Counter-evidence"). No secondary source was used.

## 1. How a subagent call completes

**Stated.**
- Two modes: "**Foreground subagents** block the main conversation until complete." "**Background subagents** run concurrently while you continue working." (S1)
- Background is the default. Fork mode, "on … by default in an interactive session", runs every subagent in the background, and "Claude can't ask for the foreground". With fork mode off (non-interactive `-p`, the Agent SDK), "Claude runs the subagent in the background by default and in the foreground when it needs the result before continuing". `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1` forces the foreground "in every kind of session". (S1)
- What the call returns: `status` is "`"completed"` for foreground subagents, `"async_launched"` for background subagents"; "a background launch returns immediately", with `agentId`, `description`, `prompt`, `outputFile` and `resolvedModel`. (S2)
- How completion is signalled: "A background subagent's results reach Claude as a completion notification in a later turn. Claude waits for that notification before reporting the subagent's results … Before v2.1.211, Claude sometimes reported results for a background subagent that hadn't finished." The notification "is marked as an automated event". `SubagentStop` "Runs when a Claude Code subagent has finished responding"; the Stop and SubagentStop input's `background_tasks` tells a finished session from one paused for background work. (S1, S2)
- Failure: a foreground call returns partial output "with a note that the subagent was cut off"; a background subagent "is marked failed", and the message names the error with its last output. (S1)
- Nested subagents: in interactive sessions a launching subagent waits for its background children; in non-interactive mode and the SDK it does not, and a late child "reports to your main conversation instead". (S1)
- Cloud sessions: "Subagents work the same way they do locally." When a cloud VM is reclaimed, "background work that was still running … such as subagents" is not restored. Routines "run autonomously as full Claude Code cloud sessions". (S6, S7)
- Workflows: "a runtime executes it in the background while your session stays responsive"; "When the run finishes, the report appears in your session." (S4)
- Versions: 2.1.198 (1 July 2026): "Subagents now run in the background by default … and is notified when they finish"; 2.1.232 (13 August 2026): agent spawns in interactive sessions run in the background by default. (S10, S11)

**Not stated.** Whether a session started by a routine counts as interactive (fork mode on) or not; how a workflow's completion reaches Claude beyond "the report appears"; what happens to a background subagent's file writes when it is stopped, fails or its VM is reclaimed.

## 2. What the hook input carries about a subagent and its role

**Stated.**
- "When a subagent calls a tool, tool events such as `PreToolUse` and `PostToolUse` fire the same configured hooks as in the main conversation, and the input carries the `agent_id` and `agent_type` common input fields that identify the subagent." (S2; also S1)
- `agent_id`: "Unique identifier for the subagent. Present only when the hook fires inside a subagent call. Use this to distinguish subagent hook calls from main-thread calls." `agent_type`: "Agent name … Present when the session uses `--agent` or the hook fires inside a subagent." (S2)
- The role value is the definition's `name`: "Hooks receive this value as `agent_type`. The filename doesn't have to match"; "identity comes only from the `name` frontmatter field". (S1)
- `SubagentStart` (input `agent_id`, `agent_type`) fires on a spawn, on a resume and for each teammate message, and "can't block subagent creation". `SubagentStop` adds `agent_transcript_path` and `last_assistant_message`, and can block. Internal agents also produce `SubagentStop` events, with the session's own agent name or an empty `agent_type`. (S2)
- The Agent tool's input carries `subagent_type`, which Claude passes. (S2)
- Versions: 2.1.69 (5 March 2026) added `agent_id` and `agent_type` to hook events. (S10)

**Not stated.** Whether tool calls of workflow agents or of forks carry `agent_id` and `agent_type`; whether `session_id` differs inside a subagent.

## 3. Authoritative or self-reported?

**Stated.** The fields "identify the subagent", and `agent_id` is the documented way to "distinguish subagent hook calls from main-thread calls" (S2). Hook input is produced by Claude Code and passed to the hook as JSON on stdin (S1); hooks "fire at fixed lifecycle points rather than at the model's discretion" (S9). The hooks page's only statement on trusting input is general: "never trust input data blindly" (S2). For other fields it gives trust guidance (`mcp_server`: "Base trust decisions on `source` rather than on `name`"; paths: a path matcher "can't be bypassed via `~` or a relative spelling"); for `agent_id` and `agent_type` it gives none.

**Not stated.** That `agent_id` or `agent_type` is authoritative (unforgeable, or fit for authority decisions); that either is self-reported or open to the model's or content's influence; anything on spoofing them.

**What the documentation implies, labelled as the executor's reading (not the documentation's statement).** `agent_type` is the `name` of whichever definition ran; whoever can write a definition file sets that name. So the field says which definition ran, not an authenticated role.

## 4. Reading against row 4's fail path

**The documentation branch** ("If the documentation makes the hook input's subagent and role authoritative, K-9 item 2 (d) and the basis of EV-C00-011 rows ECC-62 and ECC-74 are re-read against it before C03 tests the guard"): **it does not fire.** The documentation states the fields' function ("identify", "distinguish") but makes no statement of authority, and its only trust guidance on hook input is not to trust it blindly. This agrees with the basis of ECC-62 and ECC-74 (`evidence/C00/EV-C00-011_ecc_comparison.md`, "cannot authoritatively tell"). The strongest quote for the other reading is "Use this to distinguish subagent hook calls from main-thread calls" (S2); it is a statement of what the field is for, not of its trustworthiness, so no note on `plan/work/C03.md` is required by this branch. W-C01-09's checker judges this reading.

**The completion branch** ("If a subagent call can return before the subagent has finished, or its completion is signalled otherwise than K-7 items 3–4 and Section 6.5 items 5–6 assume …"): the documentation already states that a background call "returns immediately", that background is the default in interactive sessions, and that completion arrives as a later notification. Whether this holds in a session started by a routine, and what such a session does, is what row 4's probe part observes (W-C01-10; the open questions below). The branch is applied, or not, on that observation, with this reading as its documentary basis.

**Open questions for the probe part (W-C01-10).** In a routine-started session: whether fork mode is on, whether an Agent call gives `async_launched` or `completed`, and whether the foreground can be obtained; how completion reaches the caller, and whether the session or its turn can end while a background subagent still runs (the Stop input's `background_tasks`), with what happens to that subagent's writes; whether `PreToolUse` inside a subagent carries `agent_id` and `agent_type`, and what `agent_type` shows for `.claude/agents/` definitions; whether `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1` in the environment forces the foreground; the Claude Code version.

## 5. Limits of this reading

- The researcher used the fetch tool and then read the same official pages' raw text with read-only `curl` (about 30 requests), beyond the task's "about 25 fetches", because the fetch tool's summary had misstated points; the guard allowed every call and denied none.
- Not read: the agent view, cross-session messaging and the Agent SDK reference in full.
- The pages are undated; a later reading (N-111, at a version change) reads them again.
