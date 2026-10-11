# EV-C01-007 · W-C01-06: row 1, session duration and chunked work (R1a and R1b, 2026-10-11)

**What this is.** The record W-C01-06 asks for: plan C01 row 1, judged from the C01 routine's two working runs, R1a and R1b, point by point against W-C01-06's acceptance block. It also records the hook events N-063 D18 and U2 need, and gives a recommendation on plan 6.4's starting budget. Run records are cited as `<run>/<file>:<line>` under `evidence/C01/routine/runs/R1a-20261011T0808Z/` or `evidence/C01/routine/runs/R1b-20261011T0913Z/`. Those copies are byte-identical to the branch files under `c01-run/` at the two heads below: `git diff 67fcd98:c01-run HEAD:evidence/C01/routine/runs/R1a-20261011T0808Z` is empty, and R1b's copy differs from `568cf6a:c01-run` only by leaving out the `R1a/` folder, which R1b's branch carries unchanged from R1a's head.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | R1a read `main` `5d0cc58a9bff5a88087bee3c509a851628e642e0`, with `CONTROL.md` version 1, blob `22f76469720f4fb6ff40b0c3b4dc32a3b991951f` (R1a/STAMP.md:11-12). R1b read `main` `fdaf4e50c360994ea2cb8be3a4ade92fa0a0035c`, with `CONTROL.md` version 2, blob `7def65012ac2e41e4637e423fa4fd10692b965c7` (R1b/STAMP.md:11-12). Version 2 changes only the version line and rule 1.2, and adds rule 1.9. Steps R1a and R1b and the queue (sections 5 and 6.1) are the same in both versions. This record is written at `main` `680031a9df186b279db925f2e4897a964f9b685c` |
| Deployment configuration | The routine `devos-c01-rutin` in the cloud environment `devos-kurulum`, with the one repository `batuhanozgun/devos` and every connector removed (ROUTINE_DESIGN.md section 1; EV-C01-005; EV-C01-006). Each run records environment `match`, the starting checkout's remote `batuhanozgun/devos`, and no server but `claude-code-remote` and `github` (R1a/OPENING.md:14-15, 24; R1b/OPENING.md:14-15, 24). R1b did not count other checkouts (denial #19). Sessions: R1a `session_01P5d7WNny3Jpuabt2A2V3Bm`; R1b `cse_014hehG4ta6ADXdHPSDCSTs1` (guard log `session_014hehG4ta6ADXdHPSDCSTs1.jsonl`). In both runs: model Opus 5.5 by one statement of the context and "selected at run time, not visible" by another; permission mode auto; effort `xhigh` as the guard counts it. Claude Code version: `not visible` in both runs (R1a/OPENING.md:20; R1b/OPENING.md:20, after denial #22). The executor reports that the working session's `get_session` gave `external_metadata.container_cc_version` 2.1.296 on 2026-10-11 at 08:53Z; EV-C01-004 records the same value at about 06:03Z. That reading is the working session's container, not a run's, so it does not show the runs' version. Start: R1a by the schedule (daily at 08:07Z); R1b by Batu's one Run now press (D-021; section "R1b's start" below) |
| Criterion version | W-C01-06's acceptance block (`plan/work/W-C01-06.md`, blob `227fdb257563e819154db23d381839437b8ee459`, the same at `5d0cc58`, `fdaf4e5` and `680031a`), as merged with the C01 re-plan (W-C01-31: commit `44cef4e`, merge `7d07ef7`, L-182). The re-plan changed only `depends_on` and added its note; the block's text dates from `ea525d9` (2026-10-06). Read with plan C01 row 1 (plan line 944) and the PC-21 note, items 1 and 2 (lines 963-965) |
| Input | The stored prompt (ROUTINE_DESIGN.md section 3); `CONTROL.md` steps R1a and R1b; the synthetic queue Q1 to Q4 with T1, L1 and N1 (`CONTROL.md` 6.1; plan Section 8 item 13). No text arrived with either start (R1a/STAMP.md:10; R1b/STAMP.md:10) |
| Actual observation | The two runs' records (below), and a direct read of the two branches: the commit order, and the diff of R1a's outputs between the two heads |
| Raw evidence ID | Branch `claude/probe-c01-r1a-20261011T0808Z`, head `67fcd98a8ec84f3a2269f4227cca6cdbbbc9b251`: `9e97811` stamp, `a15313c` opening, `d3c751f` queue, `e686797` Q1, `78b33da` Q2, `416b294` hand-over, `67fcd98` closing. Branch `claude/probe-c01-r1b-20261011T0913Z`, head `568cf6a1bf5ad96002bf41d0423ddd6edda7217f`: `c2d8bbf` stamp (its parent is `67fcd98`), `ac7afaf` opening, `44af4bc` package, `06a20e3` continuity, `b9e15c2` Q3, `f690ea2` Q4, `942481d` hand-over, `047991a` and `50a2218` row 4, `568cf6a` closing. Copies under `evidence/C01/routine/runs/R1a-20261011T0808Z/` and `evidence/C01/routine/runs/R1b-20261011T0913Z/` |
| Independence level | Verified by self-observation (D-017 item 2(a)) for what each run records of itself: times, boot IDs, compaction, hook output, and its reading of the hand-over (dated 2026-10-11). The branch structure and the diff were read directly from git by the executor's producer subagent; the commit dates come from the sessions' own clocks. Judged by a fresh-context checker (declared, Ek A 5.3) |

## How the criterion is read

PC-21's note governs where it and the row differ (plan line 963). "P2 in `devos-probe-a`" reads as the routine `devos-c01-rutin` in `devos-kurulum` (item 1). Item 2: "Unchanged in substance; "P2" reads as the routine of item 1. Row 1's queue is a small synthetic list on the routine's own branch, in place of P3's queue." Success and failure are as in ROUTINE_DESIGN.md section 7, "Row 1". R1a must do more than one item. Each run's duration and its pause observation must be recorded. R1b, the routine's next run, must take the item R1a's hand-over names, finish the queue and redo no done item: "the outputs of the items R1a did are unchanged between R1a's head and R1b's head". This reading is the disposition that the re-plan note in `plan/work/W-C01-06.md` asks for when the item starts; the executor records it.

## Point 1. Two runs in a row; the first runs more than one queue item

Met.
- R1a: S 2026-10-11T08:08:23Z, step R1a, first attempt (R1a/STAMP.md:6-8). It wrote the queue and then took two items: Q1 (taken 08:12:10Z, done 08:12:13Z) and Q2 (taken 08:12:24Z, done 08:12:27Z) (R1a queue/QUEUE.md:7-8). Each output was pushed in its own commit (`e686797`, `78b33da`). "Result: done" (R1a/CLOSING.md:63). It stopped at two because its step says so ("Stop taking items when two are done", `CONTROL.md` step R1a item 3), not because of a limit.
- R1b: S 09:13:03Z, step R1b, "this branch starts from that branch's head `67fcd98`" (R1b/STAMP.md:6-7). "Result: done" (R1b/CLOSING.md:67).
- In a row: the remote holds exactly two `claude/probe-c01-*` branches, these two (`git ls-remote`, read for this record). Every run, including an idle one, creates such a branch before doing anything else (`CONTROL.md` 2.4, 2.5), and no other run's record lies between the two. A run that ended before its first push would leave no branch; nothing points to one.
- The outputs are right. Recomputed for this record: T1 has 29 words (`wc -w`); L1 in byte order is apple, cherry, fig, pear, quince (`LC_ALL=C sort`); N1 sums to 63. These match `out/Q1.md` to `out/Q3.md`.

## Point 2. How long each session ran, and whether its sandbox was paused

Met; the pause is an indirect observation.

| | R1a | R1b |
|---|---|---|
| Duration, as the run records it | "Duration from S (08:08:23Z): 5 min 2 s." (R1a/CLOSING.md:7) | "Duration from S (09:13:03Z): 6 min 38 s." (R1b/CLOSING.md:8) |
| Last commit on the branch (the closing record) | `67fcd98`, 08:13:55Z: 5 min 32 s after S | `568cf6a`, 09:20:11Z: 7 min 8 s after S |
| Queue items, taken to done | Q1 3 s; Q2 3 s | Q3 7 s; Q4 5 s |
| From S to the first queue item | 3 min 47 s (step choice, stamp, opening) | 2 min 49 s (the same, plus package and continuity) |
| Boot ID | "`c7f565fa-1f62-4d67-a74c-2778f88a19ce` at 08:09:27Z, 08:10:36Z, 08:12:13Z, 08:12:27Z and 08:13:07Z: unchanged" (R1a/CLOSING.md:18) | "`e65bd452-cc0a-4776-863f-211a3d191c34` at 09:14:42Z, 09:15:59Z, 09:16:12Z, 09:19:09Z, 09:19:24Z and 09:19:41Z: unchanged" (R1b/CLOSING.md:20) |
| Gaps of more than 5 minutes | "none" (R1a/CLOSING.md:18). The largest gap between the times it lists is 1 min 4 s (08:08:23Z to 08:09:27Z) | "none" (R1b/CLOSING.md:21). The largest gap between the times its closing record lists is 1 min 33 s (09:16:34Z to 09:18:07Z, while the foreground prober worked) |
| Compaction | "None occurred" (R1a/CLOSING.md:22) | "None occurred" (R1b/CLOSING.md:25) |
| Usage or routine limit message | "None." (R1a/CLOSING.md:51) | "None." (R1b/CLOSING.md:56) |

Neither session shows a sign of a pause: the boot ID did not change within either run, and no gap comes near 5 minutes. The two runs have different boot IDs, so each ran on a freshly booted machine. That R1b had nothing from R1a except what R1a had pushed rests on stronger signs: R1b's starting checkout was shallow again and needed rule 1.9's fetch (R1b/STAMP.md:13), which shows a fresh clone, and its session ID is new, which shows a new context.

## Point 3. The second session continued correctly from the first's structured hand-over

Met.
- **The hand-over.** R1a's `HANDOVER.md` names the done items with their commits, then "## Next item" with "Q3.", and ends with "Step R1b takes Q3." (R1a/HANDOVER.md:9-12, 16-18, 55). It also carries open questions, alternatives not taken, external effects and sources (lines 20-51), which are the fields `CONTROL.md` step R1a item 4 asks for.
- **Read first.** R1b read the hand-over on its own branch, at `67fcd98`, before any queue work (R1b/CONTINUITY.md:5). It recorded "Items done: Q1 (output 29, commit `e686797`) and Q2 (apple, cherry, fig, pear, quince; commit `78b33da`). They are not redone." and "Next item: Q3; then Q4, the end of the queue." (lines 9-10), and that the queue file agrees (line 11). The commit chain shows the same order: `06a20e3` (continuity), then `b9e15c2` (Q3), then `f690ea2` (Q4).
- **Took the named item.** Q3 was taken at 09:15:52Z and done at 09:15:59Z; Q4 was then taken at 09:16:07Z and done at 09:16:12Z (R1b queue/QUEUE.md:9-10). The queue is finished (R1b/HANDOVER.md:7-20).
- **Redid no done item.** Compared at the two heads, after `git fetch origin claude/probe-c01-r1a-20261011T0808Z claude/probe-c01-r1b-20261011T0913Z`:
  - `git diff 67fcd98 568cf6a -- c01-run/queue/out/Q1.md c01-run/queue/out/Q2.md` is empty. The blobs are the same at both heads: Q1 `ff9419c`, Q2 `ab76a7f`.
  - `git log 67fcd98..568cf6a -- c01-run/queue/out/Q1.md c01-run/queue/out/Q2.md c01-run/R1a` lists no commit.
  - `git diff 67fcd98 568cf6a -- c01-run/queue/QUEUE.md` changes only the Q3 and Q4 lines, from `open` to taken and done by step R1b. The Q1 and Q2 lines are unchanged.
  - Sensitivity: these checks would show it if R1b had re-marked Q1 or Q2, or written a different output for either. They would not show a recomputation inside the session that wrote nothing, or that wrote identical bytes. On that, there is only R1b's own statement: "No item was redone." (R1b/HANDOVER.md:16).
- **What R1b took from elsewhere**, by its own record (R1b/CONTINUITY.md:19-21):
  - the inputs N1 and T1, from the queue file the hand-over names;
  - how to take an item, from `CONTROL.md`;
  - that R1a was closed, and which commit to start from, from the branch list and R1a's `CLOSING.md`.

  This is as designed: the hand-over names the next item, and the procedure is in the control file. R1b also took up R1a's three open questions (R1b/CONTINUITY.md:12-14).

## Point 4. Hook events at start, resume or compaction (N-063 D18, U2)

Recorded for both runs:
- **At start:** "Hook events: none (no hook output reached the session at its start)." (R1a/OPENING.md:26; R1b/OPENING.md:26).
- **Compaction:** none in either run (R1a/CLOSING.md, R1b/CLOSING.md section 3).
- **Resume:** not shown either way at one point. R1b ended its turn at 09:19:09Z to wait, and the background prober's hand-back message woke it as a new turn at 09:19:24Z (R1b/ROW4.md:20). Whether the platform treated that boundary as a resume is not shown. The boot ID was unchanged across it, and the in-process task notification arrived after the wake, which points to the same process. No hook output was recorded there, and no repository hook was due: the only SessionStart matcher is `compact` (`.claude/settings.json`, blob `ce7d09d`). Elsewhere no turn ended to wait, and no gap came near a pause.
- **What this shows for D18 and U2: little.** The repository configures one SessionStart hook, with matcher `compact` (`.claude/settings.json`, blob `ce7d09d`, the same at `5d0cc58` and `fdaf4e5`; R1a/OPENING.md:41). So no repository hook was due at a fresh start. "None" at start is what the configuration predicts; it does not show whether SessionStart fires in a routine session at start, resume or compaction. That part of D18 and U2 is not observed here; W-C01-27 decides on it.
- **What the runs do show** (for W-C01-37 and W-C01-27): the PreToolUse hook, which is the guard, ran on the runs' tool calls. Its decision log exists in each session, and it allowed or denied calls without passing any to a user ("0 passed to the user", R1a/OPENING.md:9; R1b/OPENING.md:9).
- A hook that fires without output would not be seen by the session.

## R1b's start: a Run now press

- **How it is known.** From two things outside the session:
  - Batu's comment on issue #6 at 2026-10-11T09:13:31Z, from the account `batuhanozgun`: "Bastım. Çalışmaya başladı. Yeni oturum açtı." ("I pressed it. It started working. It opened a new session.") (`plan/decisions/D-021.md`, section "Answer"; L-201).
  - S, 09:13:03Z, which matches no schedule time; the schedule is daily at 08:07Z (L-195).
- **How the session saw it.** Its stamp reads "Fire reason as the session sees it: scheduled; the turn opens with the scheduler's notice that it was started automatically by a schedule (an automated firing of a configured prompt)." and "Text arrived with the start: no" (R1b/STAMP.md:9-10). Both lines are word for word as in R1a's stamp (R1a/STAMP.md:9-10). So the session cannot tell a Run now press from the schedule, and the fire-reason field does not tell them apart. CHK-C01-043 condition C3 asks this file to name the start as Run now "from its stamp's fire reason and its 'text arrived' field". The fire reason reads "scheduled", so the naming rests on Batu's word and on S. The "text arrived" field agrees with a press made with no text.
- **Whether it changes row 1: no.** Before the press, CHK-C01-043 findings 1 to 3 judged that row 1 needs no scheduled second run, no other day and no gap, and that a run started then would take R1b with every rule met. The records add three things:
  - (a) That a Run now session is the same as a scheduled one is documented (below). It has now been seen once, by self-observation: R1b's opening matches R1a's on every field both record (environment, tools and servers, agent types, skills, plugins, hooks, model statements, mode, effort). The two files differ only in times, session IDs, boot ID, guard counts, denials, the `main` commit named, and R1b's uncounted checkouts.
  - (b) R1b took step R1b, from R1a's head, as `CONTROL.md` 2.3 and 2.5 say.
  - (c) R1b followed R1a by 65 minutes, not a day. The hand-over crossed a session boundary onto a fresh machine (Point 2), which is what row 1 tests; it did not cross a day.
- **Still open:** DevOS's working sessions will be started by schedule. The documentation says the two kinds of start are the same, and one run has now shown it; that is not proof.

## What the record cannot show

- **Only this synthetic work.** The durations are those of this synthetic work. Each session ended because its step was done: R1a by design after two items, R1b at the end of the queue and its row 4 part. Neither ended at a limit. The runs show that a routine session runs at least 6 min 38 s without a sign of a pause or a limit. They do not show the longest a session can run, or how long one runs on real work. Plan K-7's "How long a cloud session can run while processing a queue **[Awaiting verification: C01]**" (plan line 392) is not settled by row 1.
- **The pause is indirect.** A changed boot ID would show a rebuilt machine; a gap is only consistent with a pause (`CONTROL.md` 3.4 item 2). Neither session sat idle for more than about 1.5 minutes. That is below the "few minutes" after which the documentation says an idle machine pauses (below), so no pause was to be expected. The runs do not show what happens to a session that waits or works for a long time.
- **Times not covered.** The first boot ID was taken 64 s after S in R1a and 99 s after S in R1b. Nothing after the closing record's push is recorded.
- **Self-timed.** The durations and boot IDs are the sessions' own records, and the commit dates come from the same clocks. Nothing outside the sessions timed them. R1b's first `OPENING.md` (`ac7afaf`, committed 09:15:05Z) carried estimated times, later than its own commit date; R1b corrected them to measured times with a shell `sed -i` (`44af4bc`; its own note on rule 1.1). Row 1's durations do not rest on those lines; git's commit dates corroborate them.
- **Claude Code version: could not check.** (a) Cause: a run has no `get_session` tool, and the `claude` command line was denied (#22, rule B7; R1b/OPENING.md:20), so both runs record the version `not visible`. (b) What stands in for it: the working session's `get_session` reading, 2.1.296, taken in the same environment `devos-kurulum` at about 06:03Z (EV-C01-004) and at 08:53Z (L-202); it is not the runs' own version. (c) So this row's result is tied to the run date, 2026-10-11, and to `devos-kurulum`, not to a version (plan Section 8 item 9). (d) The Result's "no part is could not check" covers the row's parts, not this envelope field.
- **Hand-over or queue file.** The item the hand-over names, Q3, is also the first open item in `QUEUE.md`, so "took the named item" cannot show that the hand-over was needed. What shows that R1b read and used the hand-over is R1b/CONTINUITY.md:9-15: the done items with their commits, and R1a's three open questions.
- **Small sample.** One pair of runs, with one queue of four trivial items.
- **Start route.** R1b's start route rests on Batu's word and on S; the session cannot see it.
- **Hand-over fields.** The hand-over is shown sufficient for this queue, where the procedure is in the control file. Plan 6.5 item 11 also lists "the expected sub-result" and "the return point". `CONTROL.md` step R1a item 4 does not ask for them, and R1a's hand-over does not carry them as such; here, its "Next item" and "Next responsibility" serve as the return point. Row 1 names no field list.

## Facts taken from the documentation (PC-21 item 9)

- An idle cloud session's machine pauses after a few minutes with its files saved, and can later be reclaimed. Guaranteed by platform (documented in https://code.claude.com/docs/en/cloud-environments, "Time limits", read 2026-10-10; ROUTINE_DESIGN.md F11); not independently tested.
- Each repository is cloned at the start of every run, from its default branch. Guaranteed by platform (documented in https://code.claude.com/docs/en/routines, "Repositories and branch permissions", read 2026-10-10; ROUTINE_DESIGN.md F5); not independently tested. Both runs recorded a fresh, shallow starting checkout at the `main` of their start (R1a/STAMP.md:11; R1b/STAMP.md:11, 13; EV-C01-005).
- A run starts "When the routine's schedule or Run now starts a run", and "Each run creates a new session". Guaranteed by platform (documented in https://code.claude.com/docs/en/routines, read 2026-10-11; CHK-C01-043 finding 1); not independently tested.
- Qualifiers:
  - Per environment, only the variables, secrets and network setting are separate.
  - The GitHub identity and the account's connectors are shared across the account.
  - An environment's variables are readable inside its own sessions.
  - The channel to the model's own service stays open whatever the network setting.
  - Routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).
  - Neither page showed a last-updated date.

## Result

Row 1's success condition is met, part by part:

| Part | Result | Where |
|---|---|---|
| A cloud session started by the routine runs more than one item from the queue | met (R1a: Q1 and Q2) | Point 1 |
| How long it runs | met, for this work: R1a 5 min 2 s, R1b 6 min 38 s | Point 2 |
| Whether the sandbox is paused | met, indirectly: no sign of a pause in either run | Point 2 |
| The next session continues correctly through a structured hand-over (two runs in a row; the second takes the item the hand-over names; no done item redone) | met | Points 1 and 3 |
| Hook events at start, resume or compaction (the item's own record, not the row's) | recorded: none at start; no resume or compaction occurred | Point 4 |

No part of the row is "could not check" (the envelope's Claude Code version is, above), and the fail path does not apply. The limits above stand with the result; in particular, the longest duration of a session is not measured. Under N-063, SessionStart at a resume or a compaction stays unobserved; that is for W-C01-27.

## Plan 6.4's starting budget (a recommendation; the executor decides, through plan Section 14)

**Recommendation:** keep the starting figures unchanged (working 3, audit 3, exam 1, reserve up to 8, within 15 a day).

**Reason.** Plan 6.4 changes the figures "according to the session-duration measurement in C01". Its reserve adds working sessions "if sessions stay short". These two sessions did not stay short in that sense: each ended because its work was done, with no pause, no compaction and no limit. Nor do they show that sessions run long enough to need fewer runs. A measurement of 5 to 7 minutes on four trivial items bears on neither direction, so it gives no reason for a change.

**Recorded for N-063 D01 (W-C01-27):** the fixed part of each run before its first item took 3 min 47 s and 2 min 49 s, against a few seconds per item. That is this control file's opening, not DevOS's.

**What could change the figures:**
- row 5's real daily limit (W-C01-12);
- the length of real working sessions, which row 1 did not measure and which plan K-7 still marks "[Awaiting verification: C01]". If it is not observed in C01, the executor decides where it is observed.
