# EV-C01-015 · W-C01-24: row 18, platform-side readers (the `/goal` evaluator and the auto-mode permission classifier)

**What this is.** The record W-C01-24 asks for: plan C01 row 18, a reading of the platform's current official documentation, with its date (plan 0.3 item 12), for the two platform-side readers the 6.7 row names. For each reader it records what it reads of the session, what it keeps and for how long, where it sends what it reads, and whether it makes a write of its own; for the classifier, also whether it acts in Accept edits and in sessions started by a routine. A point the documentation does not state is recorded as "not stated". Reading only, no probe (row 18). Observations that are not documentation are kept apart and labelled.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | The plan, the item and the stage files were read at `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527` (the branch base). `main` moved to `fe69e1f68ee1ab6fc39d33b34c7d8abd459f760a` (L-204, L-205) while this record was written; the files this record reads or changes have the same blobs there: `plan/DevOS_Kurulum_Plani.md` `eb1ffa5`, `plan/work/W-C01-24.md` `f9ceb45`, `plan/work/C01.md` `7237fb4`, `plan/work/C06.md` `141b410`. The repository's settings: `.claude/settings.json` blob `ce7d09d` (last changed in `5223552`, 2026-10-05), `"defaultMode": "acceptEdits"` (line 9) |
| Deployment configuration | The Claude Code documentation at `https://code.claude.com/docs/en/`, ten pages (table below), fetched with plain `curl` as their Markdown exports on 2026-10-11 between 12:32Z and 12:40Z. The platform they describe as DevOS uses it: cloud sessions in the environment `devos-kurulum`; the working session at Claude Code 2.1.296 by its `get_session` (EV-C01-004:29; L-202); the routine sessions' version not visible to them (EV-C01-007:10) |
| Criterion version | W-C01-24's acceptance block (`plan/work/W-C01-24.md`, blob `f9ceb45` at `f957519` and at `fe69e1f`), whose text dates from `3becfca` (2026-10-06); `62f9e46` changed only the item's opening paragraph, and the C01 re-plan (`44cef4e`, W-C01-31) only `depends_on` and its note. Read with plan C01 row 18 (plan line 961), the 6.7 row it serves (line 731), and the PC-21 note under C01 (lines 963-972), which governs where they differ |
| Input | The ten documentation pages below. Records: R1a and R1b `OPENING.md`:18; R1b `ROW4.md`:10, 28; L-178; D-008; D-014; EV-C00-001 row 7; `.claude/settings.json`; `.claude/hooks/tool_allowlist.py`:95-104; `evidence/C01/routine/CONTROL.md` version 4 at `fe69e1f` (rule 1.5, step P1) |
| Actual observation | The passages quoted in points 1 to 4, with their line numbers in the fetched exports |
| Raw evidence ID | The page URLs with their reading time and the SHA-256 (first 16 hex digits) of each fetched export (table below). The exports are not copied into this public repository; a checker fetches the same URLs and compares the hash. A changed hash means the page changed after this reading |
| Independence level | Verified by documentation (D-017 item 2(a)): the producer's own reading of the primary pages, quoted, not through a summarising tool. Routine sessions' mode: self-observation by those sessions (D-017 item 2(a)). Judged by a fresh-context checker (declared, Ek A 5.3) |

## Sources (read 2026-10-11)

No page shows a date to the reader. Each page's HTML carries a `dateModified` in its metadata, given here as the page's own date. Citations below are `ID:line` in the Markdown export, for example `G:120`.

| ID | Page (`https://code.claude.com/docs/en/<name>.md`) | Page date (`dateModified`) | SHA-256 of the export (first 16) |
|---|---|---|---|
| G | `goal` | 2026-10-09T14:23:13Z | `ee86d204c45ddee9` |
| P | `permission-modes` | 2026-10-10T16:37:53Z | `ab7d5ffbac699350` |
| R | `routines` | 2026-10-10T18:10:14Z | `9cfb8c114e4563ea` |
| W | `claude-code-on-the-web` | 2026-10-09T20:45:36Z | `ff605017d6d49a3e` |
| U | `data-usage` | 2026-09-28T00:07:53Z | `ef5260591575f5c4` |
| PM | `permissions` | 2026-10-10T18:06:28Z | `64687fdf1daa39cc` |
| H | `hooks` | 2026-10-10T17:51:50Z | `3a1f944503d05a61` |
| A | `auto-mode-config` | 2026-10-10T16:37:53Z | `22735f1d1ee1f308` |
| T | `tools-reference` | 2026-10-10T17:45:40Z | `64b179bbd125a9fa` |
| S | `settings-reference` | 2026-10-10T18:17:11Z | `632ca58b63afeac3` |

## Point 1. The `/goal` evaluator

- **What it reads.** "Each time Claude finishes a turn, Claude Code sends the condition and the conversation so far to your configured small fast model." (G:120). "It doesn't run commands or read files independently" (G:56); "It does not call tools, so it can only judge what Claude has already surfaced in the conversation." (G:173). A turn that ends while a subagent or background command runs is not evaluated (G:152). Whether "the conversation so far" includes tool results: not stated.
- **What it keeps, and for how long.** Not stated. Nearby, stated: "the transcript shows each verdict the evaluator returns" (G:52); on "Met", Claude Code "records an achieved entry in the transcript"; on "Impossible", it "records a failed entry in the transcript along with the reason" (G:123-124). For a cloud session, "Anthropic stores the session transcript so you can return to the session later", under the account's retention policies (U:95), which are 30 days, or 5 years where a consumer account allows data use for model improvement, and 30 days by default for commercial accounts (U:44-56). Which of these applies to Batu's account is not read here. Whether the evaluator, or its model request, keeps what it reads apart from the transcript: not stated.
- **Where it sends what it reads.** To "your configured small fast model" (G:120), which "runs on whichever provider your session is configured for" (G:173). The model can be changed with `ANTHROPIC_DEFAULT_HAIKU_MODEL`, which also moves the small fast model's "background functionality, such as conversation summarization" (G:167-171). No other destination is stated.
- **Writes of its own.** None stated: it "does not call tools" (G:173). The writes the page names are Claude Code's: the transcript entries above, and clearing the goal. Its reason steers the session: on "Not yet met", "Claude keeps working and takes the reason as guidance for the next turn" (G:122). It is "a wrapper around a session-scoped prompt-based Stop hook" (G:120) and is unavailable when `disableAllHooks` is true (G:181).

## Point 2. The auto-mode permission classifier

- **What it reads.** "In the classifier requests sent by Claude Code itself, the classifier sees user messages, tool calls other than read-only lookups such as file reads and searches, and your CLAUDE.md content. Tool results are stripped from those requests" (P:536; also A:62). "Each check sends a portion of the transcript plus the pending action" (P:556); which portion, beyond this, is not stated. Boundaries the user states are re-read "from the transcript on each check" (P:466). It may also read a hook's `classifierContext` note on a call's result, as "unverified, application-provided context" for hooks from settings files (H:2196, H:2211), and the output of a `git status` that Claude Code runs before a command that would discard work (P:534).
  What it judges: an action the decision order sends to it, after rules and the auto-approval of read-only actions and working-directory edits (P:504-518; "Everything else goes to the classifier", P:517); each message sent with `SendMessage`, before delivery (P:308); a subagent's task at spawn, each of its actions, and "its work and its final report before the parent reads the report" (P:546-548); a `SubagentHandback` report "before it's delivered" (T:53). By default it does not review critical-path removals (P:310).
- **What it keeps, and for how long.** Not stated. Nearby, stated: Claude Code lists a denied action under `/permissions`, "Recently denied" (P:480; A:356); how long that list is kept is not stated. Whether the classifier's requests are kept, and under which retention: not stated.
- **Where it sends what it reads.** To the classifier model: "Claude Sonnet 5 by default rather than on your `/model` selection. A classifier model that Anthropic configures server-side takes precedence over that default" (P:552). Or, with server-side review, Claude Code asks "the server to check the actions ... as part of the session's model requests, in place of sending its own classifier requests", and "its verdicts decide them" (P:345, P:351). The sessions the page names for server-side review do not include cloud sessions (P:347-349), so whether a cloud or routine session uses it is not stated. Cloud sessions "call the Anthropic API from Anthropic-managed infrastructure" (W:438). No destination other than the model service is stated.
- **Writes of its own.** None stated. It returns a verdict: "If the classifier blocks, Claude receives the reason", in most sessions a rule label (P:518). The writes the pages name are Claude Code's: the "Recently denied" entry (P:480); for a flagged subagent's work or report, "the report is still delivered, prepended with a security warning" (P:548). After 3 blocks in a row or 20 in all, auto mode pauses and prompts resume (P:481).
- **The guard and the classifier.** The guard answers a call it allows with a `PreToolUse` `"allow"` (`tool_allowlist.py`:2087). The hooks page says `"allow"` "skips the permission prompt" (H:1909); the classifier is "a second gate that runs after the permissions system" (A:77); a hook's `"ask"` still lets the classifier deny (H:1920). Whether a hook's `"allow"` keeps a call from the classifier in auto mode: not stated.

## Point 3. Whether the classifier acts in Accept edits

**No.** Guaranteed by platform (documented in P, read 2026-10-11); not independently tested. The documentation states it through its per-mode statements, not in one sentence:
- "In auto mode, a second model, the classifier, reviews actions instead of you" (P:9).
- The mode table names the classifier only for `plan` ("classifier-approved commands when auto mode is available") and `auto` ("with background safety checks"); `default` runs "Reads only" and `acceptEdits` "Reads, file edits, and common filesystem commands" (P:19-22). In `acceptEdits`, "all other Bash commands except the built-in read-only set still prompt" (P:252). The settings reference gives the same split (S:1678-1680).
- Per-mode tables: protected-path writes are "Prompted" in `default` and `acceptEdits` and "Routed to the classifier" in `auto` (P:637, P:639); a critical-path removal "Asks you to approve it" in `default` and `acceptEdits` (P:751), unlike `auto` (P:753).
- In cloud sessions, "Accept edits corresponds to `default` mode" (P:232), and Manual mode (`default`) is the setup "without a classifier" (P:54). The `PermissionDenied` hook "only fires in auto mode" (H:2346).

Two routes into the classifier from a session in Accept edits, both documented: plan mode, where "the classifier reviews shell commands other than critical-path removals instead of prompting you" when auto mode is available and `useAutoModeDuringPlan` is on, its default (P:271); `EnterPlanMode` "Switches to plan mode" (T:30), and the guard allows it (`tool_allowlist.py`:99). And an Auto window under D-014, Batu's decision. Auto mode is available on the account: the working session opened in it on 2026-10-10 (L-178).

A hint, not evidence: this producer, a subagent of the working session in Accept edits (L-178), was given no `SubagentHandback` tool, which is "Provided only in auto mode" (T:53).

**N-102:** row 18 finds that the classifier does not act in Accept edits, so N-102 closes with that result (its own rule; dated line on `plan/work/C01.md`). The D-008 cost text is still corrected, for routine sessions (point 6 (c)).

## Point 4. Whether the classifier acts in sessions started by a routine

**Not stated.** What the documentation says:
- "Routines run autonomously as full Claude Code cloud sessions: there is no permission-mode picker, and the session runs shell commands, uses skills committed to the cloned repository, and calls any connectors you include, all without stopping for approval apart from some artifact actions." (R:51)
- Cloud sessions offer "Accept edits, Plan, and Auto"; "Cloud sessions still honor `defaultMode: "acceptEdits"` from settings" (P:232); the mode is picked "both when you create the task and while the session runs" (W:245); in cloud sessions `defaultMode` is honoured only for `acceptEdits`, `plan`, `default` and `auto` (S:1695).
- No page names the permission mode of a session that a routine starts, or says whether the classifier acts in one.

**What was observed (self-observation, D-017 item 2(a); not documentation):**
- R1a and R1b, the routine's two runs on 2026-10-11: "Permission mode: the system context says auto mode is active." (R1a `OPENING.md`:18; R1b `OPENING.md`:18).
- In R1b, subagent reports arrived "as a message from the subagent's hand-back call" (R1b `ROW4.md`:10, 28). The tools reference says `SubagentHandback` is "Provided only in auto mode" and that "the classifier reviews the report before it's delivered" (T:53). This is a second sign, from the session's tool behaviour rather than its context's statement; it is also the session's own record.
- Both runs started from a `main` whose `.claude/settings.json` sets `"defaultMode": "acceptEdits"` (blob `ce7d09d`). The working session opened on 2026-10-10 under the same file with `get_session` `permission_mode` `auto`, and Batu switched it (L-178). So, by these records, the repository's setting did not set the starting mode of either kind of cloud session; the documentation does not say what does.
- No classifier denial is recorded in R1a or R1b. `CONTROL.md` asks runs to record guard denials only (rule 1.5, version 4), so the absence shows nothing.

**How the row treats it.** Row 18 is reading only, and its answer here is the documentation's: "not stated". That point stays in the 6.7 row as a residual (the fail path's last sentence). The runs' report is not documentation and is not read into it. It is two sessions' record of themselves on one day, without a `get_session` reading (routine sessions have none, R1a `OPENING.md`:16).
For the fail path, the unfavourable case is taken, as PC-21 does where the documentation is silent: two routine sessions report auto mode, and in auto mode the classifier reviews actions (P:9, P:304). So the decision treats the classifier as acting in sessions started by a routine, and applies that branch (point 6 (c)). If a later documentation reading or a run's record shows routine sessions outside auto mode, the listings that branch makes lapse (N-168).

## Point 5. Where the documentation differs from the 6.7 row

The 6.7 row "Platform-side readers of the session's content" (plan line 731):
1. "The `/goal` evaluator is a small model that sees only the conversation": consistent (G:120, G:173). Made precise.
2. "the classifier judges a tool call before it runs": narrower than the documentation. It also judges each `SendMessage` before delivery (P:308) and a subagent's task at spawn and its work and final report before the parent reads it (P:546-548), and it reads user messages, tool calls and `CLAUDE.md`, without tool results (P:536). **Differs.**
3. "DevOS cannot change them": the repository can steer the classifier through `CLAUDE.md` (A:62) and a hook's `classifierContext` note (H:2196, H:2211), and a settings file can keep sessions out of auto mode with `disableAutoMode`, "Any file" (S:1461-1463; its effect in cloud and routine sessions not stated). The repository cannot set the classifier's rules: it "doesn't read `autoMode` from project settings" (A:72). The evaluator's model follows `ANTHROPIC_DEFAULT_HAIKU_MODEL` (G:167). **Differs.**
4. The marked part ("That they make no writes of their own, what each of them reads, keeps and sends, and whether the classifier acts in Accept edits and in routine sessions **[Awaiting verification ...]**"): answered by points 1 to 4.
5. The row names two readers. The documentation names others that read the session's content: "A separate server-side probe scans incoming tool results and flags suspicious content before Claude reads it" (P:540); "a separate API safety check", which can refuse the classifier's review (P:548; P:482); and the small fast model's "background functionality, such as conversation summarization" (G:170). Row 18 does not ask about them, and this record did not read them further. **Differs** (the row presents two readers as the platform-side readers).

PC-30 corrects the row.

## Point 6. The fail path, branch by branch (plan line 961)

- **(a) "Where the documentation differs from the 6.7 row, the row is corrected, with its source and date, before C02."** Applied: PC-30, places 1 and 2, with this record and the reading date.
- **(b) "If either reader writes on its own, or keeps or sends the session's content beyond the platform's processing of the session itself ..."** On the documentation, no: neither page states a write of the reader's own (points 1 and 2). Both send the session's content to a model: the evaluator to the small fast model on the session's provider (G:120, G:173), the classifier to its model or within the session's own model requests (P:345, P:552, P:556); no destination beyond the model service is stated. What each keeps is not stated; that goes to branch (d), not here. So the 6.7 row does not name either as a channel through which content leaves the session, and the threat-model decision on private content (Section 0.5) is not triggered by this row. The residual (d) covers private content that reaches a session's conversation.
- **(c) "If the classifier acts in Accept edits or in routine sessions ..."** Accept edits: no (point 3). Routine sessions: taken as acting (point 4), so:
  - *The actions it can deny that a stage needs are listed against that stage before its work.* C01 is the current stage, and its routine runs P1, P2, P3, CS1 and CS2 are still to come. From the documented default lists (P:362-445): P1 installs `torch` and `sentence-transformers` from public indexes with `pip`, outside any manifest, and downloads and runs two models (`CONTROL.md` version 4, step P1). That touches "Downloading and executing code, like `curl | bash`", blocked by default (P:364), while "Installing dependencies declared in your lock files or manifests" is allowed (P:431). How the classifier judges P1's commands is not stated. Pushes to the run's own `claude/probe-c01-*` branch fall under "Pushing to any branch of the repository you're working in", allowed by default (P:434); R1a and R1b pushed so. Subagent tasks, work and reports in any run are reviewed (P:546-548). This listing is put on `plan/work/C01.md` as N-167, with what a run does when a denial is not the guard's. For DevOS's own routine sessions, from C06, N-168 on `plan/work/C06.md`.
  - *The cost stated with D-008 in `plan/Installation_Working_Order.md` section 10 ("the classifier's general protection is gone") is corrected.* The file is class high, so it is not changed here. The proposed dated note, and the one line to Batu (Appendix E 1.4), are carried by N-167.
- **(d) "A point the documentation does not state stays in the 6.7 row as a residual."** Applied: PC-30 place 2 lists them: what each reader keeps and for how long, beyond the transcript; whether the classifier acts in routine sessions; whether a hook's `"allow"` keeps a call from the classifier; and the other readers of point 5 item 5.

## Noticed outside the row's question (reported, not done)

1. **Routine sessions and D-008.** D-008's answer (3) reads: "The system does not run in auto mode; it runs in Accept edits with the builder's own written rules deciding". By their own record, the routine's sessions run in auto mode (point 4), and routines have no mode picker (R:51). DevOS's working, audit and exam sessions are to be started by routines (C06; N-139). The settings reference documents `disableAutoMode` for "Any file": "Any session that would otherwise start in auto mode ... starts in `default` instead" (S:1461-1463); whether that holds in cloud and routine sessions is not stated. Trying it is the builder's technical step, through a checked change of `.claude/settings.json` (class high) and a run's record. If routine sessions still run in auto mode, the gap between D-008 and what the platform allows goes to Batu as his decision (working order section 8; Appendix E section 3, last rule), as D-014 treated its Auto window as an exception to D-008. N-169 on `plan/work/C06.md` carries it. No decision of Batu's is drafted now: the first step asks nothing of him, and the conflict is not shown until that step's result is seen.
2. **The host's automatic content review** (D-017) also reads a session's content. It comes from D-017, not from this documentation, so PC-30 does not add it; whether the 6.7 row names it is for the executor.
3. **Version-gated statements.** Several passages depend on the Claude Code version (for example the `SendMessage` review from 2.1.222, P:308; `SubagentHandback` from 2.1.271, T:53). The working session's version, 2.1.296, is above every gate cited here. The routine sessions' version is not visible to them (EV-C01-007:10): could not check which gated statements hold there. This is an envelope limit, as in EV-C01-007, not a part of the row.

## Facts taken from the documentation (PC-21 item 9)

Each is: guaranteed by platform (documented in the page named, read 2026-10-11); not independently tested.
- The `/goal` evaluator receives the condition and the conversation so far after each turn, runs on the small fast model of the session's provider, and calls no tools (G:120, G:173).
- Claude Code records the evaluator's verdicts in the transcript (G:52, G:123-124); Anthropic stores a cloud session's transcript under the account's retention (U:44-56, U:95).
- The classifier sees user messages, tool calls other than read-only lookups, and `CLAUDE.md`, without tool results; each check sends a portion of the transcript plus the pending action (P:536, P:556).
- The classifier judges actions, `SendMessage` messages, and subagents' tasks, work and reports (P:308, P:517, P:546-548); it runs on Sonnet 5 by default or a model Anthropic configures, or server-side within the session's model requests (P:345, P:552).
- The classifier acts in auto mode and in plan mode while auto mode is available, not in Accept edits (point 3).
- Routines run as cloud sessions with no permission-mode picker, without stopping for approval (R:51).
- `disableAutoMode` may be set in any settings file (S:1461-1463); `autoMode` is not read from project settings (A:72).
- Qualifiers: per environment only the variables, secrets and network setting are separate; the GitHub identity and the account's connectors are shared across the account; an environment's variables are readable inside its own sessions; the channel to the model's own service stays open whatever the network setting; routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12). No page shows a date to the reader; the dates above are the pages' metadata. Several statements are gated by version (above).

## Result

| Part (W-C01-24's block) | Result | Where |
|---|---|---|
| The documentation read with its date, for both readers | met (2026-10-11; page dates from metadata) | Sources |
| `/goal` evaluator: reads; keeps and for how long; sends; own writes | met: reads the condition and the conversation; keeps: not stated; sends to the session provider's small fast model; no own write stated | Point 1 |
| Classifier: reads; keeps and for how long; sends; own writes | met: reads user messages, tool calls, `CLAUDE.md`, not tool results; keeps: not stated; sends to the classifier model or the server's review; no own write stated | Point 2 |
| Classifier in Accept edits | met: does not act (documented by per-mode statements) | Point 3 |
| Classifier in sessions started by a routine | met as "not stated"; the routines' self-reported auto mode is kept apart and used only for the fail path | Point 4 |
| Each point's passage, address, page date and reading date, or "not stated" | met | Points 1 to 4; Sources |

No part is "could not check". The success condition is met as recorded. The result meets fail-path branches (a), (c) and (d), and PC-30 with notes N-167 and N-168 applies them before C02; branch (b) does not apply on the documentation. N-102 closes: the classifier does not act in Accept edits. The D-008 cost text is corrected for routine sessions through N-167's checked change (class high). N-169 carries the routine sessions' auto mode against D-008's answer (3).
