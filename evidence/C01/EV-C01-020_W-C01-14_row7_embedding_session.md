# EV-C01-020 · W-C01-14: row 7, embedding model, the session part (P1, 2026-10-11)

**What this is.** The record W-C01-14 asks for: plan C01 row 7, taken from P1, a run of the C01 routine, point by point against W-C01-14's acceptance block. The session part was observed; the Actions part is moved to C04. Run records are cited as `<file>:<line>` under `evidence/C01/routine/runs/P1-20261011T1337Z/P1/`. That copy was made on 2026-10-11 from branch `claude/probe-c01-p1-20261011T1337Z` at head `7fd90cae1c3cd8b3a27b4d85ebe681d369a34662`. It follows the layout of the R1a and R1b copies: the files under `c01-run/` on the branch, kept unchanged. Each of the five files was compared with `cmp` against `git show 7fd90ca:c01-run/P1/<file>` and is byte-identical. The branch holds nothing else.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | P1 read `main` `63e166c5d5407b440565a0bc7aacc887566ac66c`, with `CONTROL.md` version 6, blob `bedb4886da70c190b3a2b01fdf0e48cf19d9dfc3` (STAMP.md:11-12). Its branch starts there: the stamp commit `86bbe52` has `63e166c` as its parent. This record is written at `main` `aeb5fd0`. There, `CONTROL.md` is at version 7, which changes only how P1 items 1 and 3 handle a denied call. P1 met no denial (CLOSING.md:33-35), so its steps ran the same under either version (L-209, L-210; CHK-C01-064, "Met") |
| Deployment configuration | **Routine:** `devos-c01-rutin` (ROUTINE_DESIGN.md section 1). The run's records do not name the routine; the session saw "an automated firing of a configured prompt by a schedule" (STAMP.md:9). **Environment:** `devos-kurulum`, from `DEVOS_ENVIRONMENT` read by name: `match` (OPENING.md:8). **Repositories:** the starting checkout's remote is `batuhanozgun/devos`, with 0 other git checkouts (OPENING.md:9). **Connectors:** none. The MCP servers are the platform's own: `github` (54 tools, deferred), `claude-code-remote` (3 tools) and `ccd_session` (2 tools, arrived after the first call), with no `other-server-*` (OPENING.md:20-24). **Claude Code version:** `2.1.296`, from the `"version"` field of the session's own transcript records (OPENING.md:16). P1 is the first run of the routine to record its own version; R1a and R1b recorded `not visible`. **Session:** `cse_01GQQk4KpfZiMmWS4bP5Mf3R` (STAMP.md:5). **Model:** not written by the run, because one of its session's instructions forbids model identifiers in pushed artifacts (OPENING.md:12). The routine's configured model is the one D-008 sets, Opus 5.5 (ROUTINE_DESIGN.md section 1); that is configuration, not the run's observation. **Mode and effort:** permission mode auto, effort `xhigh` as the guard counts it, ultracode not shown (OPENING.md:13-15). **Machine:** 4 CPUs, 16093 MB of memory, no GPU device; Python 3.11 with torch 2.14.1+cpu and sentence-transformers 6.1.0 (ROW7.md:11-13). **Hooks:** the repository's hooks as at `63e166c` (OPENING.md:40-44), with the guard live (OPENING.md:7). **Start:** Batu's one Run now press (D-022 (a); his comment 6109603950 on issue #6 at 13:37:20Z). S is 13:37:51Z, which matches no schedule time; the schedule is 08:07Z. The session saw the start as "scheduled" (STAMP.md:9) |
| Criterion version | W-C01-14's acceptance block at `main` `aeb5fd0` (`plan/work/W-C01-14.md`, blob `95bd7e64765db9a0a494807ec250a0fb560ccb5e`, the same blob at `63e166c`). The block's text is unchanged since `3becfca` (2026-10-06): its checksum is the same at `3becfca`, `44cef4e` and `3a652ac`. It is read with plan C01 row 7 (plan line 950), the paragraph after the probe setup (line 940), the PC-21 note item 1 (lines 963-964), Section 8 items 9, 13 and 14 (lines 837, 841, 842) and C04 task 0 (line 1018). The time limit is in `evidence/C01/routine/ROUTINE_DESIGN.md` section 7, "Row 7" (line 107 at `aeb5fd0`, line 105 at `63e166c`, same text), fixed at `f8a1531` (Item 2) |
| Input | The stored prompt (ROUTINE_DESIGN.md section 3) and `CONTROL.md` version 6, step P1 (lines 110-117), with its section 6.4 (lines 156-176): two candidates, each pinned to a revision, and twelve synthetic sentences, TR1 to TR6 in Turkish and EN1 to EN6 in English, made into three parallel pairs and three unrelated pairs. No text arrived with the start (STAMP.md:10) |
| Actual observation | P1's own records, as copied. Also a direct read of git by the producer: the branch's commits, their order, dates and trailers; the history of the time limit (`git log -S`, `git blame`, `git merge-base --is-ancestor`); and a comparison of `embed.py`'s sentences with `CONTROL.md` 6.4, which match in all 12 of 12 |
| Raw evidence ID | Branch `claude/probe-c01-p1-20261011T1337Z`, head `7fd90cae1c3cd8b3a27b4d85ebe681d369a34662`. Its commits: `86bbe52` stamp, `b7a5c14` opening, `87a71dd` install record and script, `ea3b638` M1, `8375090` M2, `a35c352` closing record, `7fd90ca` closing record with its `Result:` line moved to the start of a line. The copies are under `evidence/C01/routine/runs/P1-20261011T1337Z/P1/` (blobs `c377e41` STAMP.md, `4d66582` OPENING.md, `ad8f06f` ROW7.md, `79919f8` CLOSING.md, `f64ca64` embed.py, the same as on the branch) |
| Independence level | What P1 records of its own session is self-observation (D-017 item 2(a); the same session's own test, Section 8 item 7), dated 2026-10-11: its times, the machine, the versions, the printed values and its own `fits`. Nothing outside the session timed the commands, and the commit dates come from the same session's clock. The producer is a fresh-context producer subagent of the executor's working session. It read the branch, the design's history and the script from git, and recomputed the arithmetic below. A fresh-context checker judges this record (declared, Ek A 5.3) |

## How the criterion is read

- **Which note governs.** PC-21's note governs where it and the row differ (plan line 963). Its item 1 reduces P2 to "one ordinary routine in the installation environment `devos-kurulum`". Row 7's "probe: the session part in P2" therefore reads as a run of the routine `devos-c01-rutin`. Item 2 lists rows 1, 4, 5 and 13, not row 7. Item 1 still applies, because it changes P2 itself. ROUTINE_DESIGN.md section 11 disposes of it the same way: "W-C01-14: names P2 and 'the time limit W-C01-03 fixed'; read as this routine, the candidates and the 600-second limit fixed in section 7."
- **Two meanings of P1.** "P1" in this record is the routine's step P1 (`CONTROL.md` table 4, "Row 7, session part (W-C01-14)"). It is not the plan's probe-setup item P1 (two probe environments), which PC-21 item 1 does not build.
- **"The time limit W-C01-03 fixed before the run."** W-C01-03 is cancelled: "Replaced by W-C01-32" (`plan/work/W-C01-03.md`, section "Cancelled"; `plan/work/W-C01-32.md`: "Replaces W-C01-03 under PC-21 item 1"). The phrase therefore reads as the limit W-C01-32's design fixed (Item 2).
- **"The candidate multilingual model" of plan 5.4.** The design fixed two candidates ("Candidates, fixed here", ROUTINE_DESIGN.md line 107). This record treats each of them.
- **The disposition.** This reading is the disposition that W-C01-14's re-plan flag asks for when the item starts; the executor records it.

## Item 1. Each candidate, named with its revision, loads and embeds the synthetic Turkish and English sample in a probe session

Met.

- **The session.** P1 is a session started by the routine. Its gates passed (OPENING.md:28): environment `match`, the only repository `batuhanozgun/devos`, no `other-server-*`.
- **The candidates and their revisions.** Both match `CONTROL.md` 6.4, "each pinned to the revision read on 2026-10-10":
  - M1: `intfloat/multilingual-e5-small` at `614241f622f53c4eeff9890bdc4f31cfecc418b3` (ROW7.md:29).
  - M2: `BAAI/bge-m3` at `5617a9f61b028005a4858fdac845db406aefb181` (ROW7.md:41).
- **How each was run.** `embed.py` takes the model ID and the revision as arguments. It calls `SentenceTransformer(model_id, revision=revision, device="cpu")` and encodes the twelve sentences with `normalize_embeddings=True`, with no model-specific prefix (embed.py:31-46; ROW7.md:17).
- **Loaded.** Each command exited 0 and did not move to the background (ROW7.md:31, 43). Each printed its download-and-load seconds: 18.9 s for M1 and 33.2 s for M2 (ROW7.md:32, 44).
- **Embedded the sample.** Each printed its embedding seconds (M1 0.05 s, M2 4.41 s) and a vector dimension (M1 384, M2 1024). Each also printed six cosine similarities computed from the vectors (ROW7.md:33-37, 45-49). `embed.py` prints these lines last, after all the work (embed.py:52-61), so their presence shows that each script ran to its end.
- **The sample is synthetic and labelled so (plan Section 8 item 13).**
  - `CONTROL.md` puts it under "## 6. Synthetic inputs (made up for this test; plan Section 8 item 13)" (version 6, line 129). Its version paragraph says "Every input in section 6 is synthetic: made up for this test, with no personal or business data and nothing from any other repository" (line 3).
  - `embed.py` carries the label as its first line, and its docstring calls the sentences "the twelve synthetic sentences" (embed.py:1-3).
  - Every P1 record begins with "C01 routine record (W-C01-32); inputs synthetic (plan Section 8 item 13)." (rule 1.7).
  - The twelve sentences in `embed.py` are those of `CONTROL.md` 6.4, word for word, 12 of 12 (checked for this record).
- **Download.** Both models were fetched from the model hub inside the command. Each printed a warning that the requests are unauthenticated, and "No token was set or asked for" (ROW7.md:38, 50).

## Item 2. The time it took, against the time limit fixed before the run

Met.

**The limit, verbatim** (ROUTINE_DESIGN.md section 7, "Row 7", line 107):

> The time limit, fixed here before any run: each candidate is downloaded, loaded and run on the synthetic Turkish and English sample within one foreground command of at most 600 seconds, the longest the session waits for a foreground command (F11); a longer step would rely on a background process, which plan 6.3 says no work does. Success: a candidate does all of it within the limit, recorded with its revision and times. Failure: it does not fit, or cannot be downloaded or loaded. […] The installation time is recorded apart and not counted.

`CONTROL.md` version 6, P1 item 3 (line 116) applies it as follows: `fits` means "the command finished within 600 seconds"; `does not fit` means "it timed out, was moved to the background, or failed".

**Fixed before the run, and when:**

- **The commit.** The paragraph was written by W-C01-32, the item that replaces W-C01-03, in commit `f8a1531b688ee4a0dcbb59e64007f917e7c4f25a`, committed 2026-10-10T22:59:58Z ("C01: W-C01-32 routine design, …"). PR #202 merged it into `main` at `aeb94f8` (2026-10-10T23:18:10Z).
- **Checked and unchanged.** CHK-C01-025 judged the design at `f8a1531`; its finding 14 asks only for a change of wording, and says "The fixed limit itself stays valid". CHK-C01-028 then judged the revisions at `2c43ce1`, and W-C01-32 is accepted. `git blame` gives line 107 to `f8a1531`. The paragraph is the same at `f8a1531`, at `63e166c` (which P1 read) and at `aeb5fd0`.
- **In `CONTROL.md`.** The same 600 seconds was in P1 item 3 from version 1 (`f8a1531`). Version 4 (`3a652ac`, merged at `9bd17a3`) kept the value and set the tool's timeout to 600 000 ms to match it (ROUTINE_DESIGN.md line 109).
- **Before P1.** `f8a1531` is an ancestor of `63e166c`, the commit P1 read and branched from (`git merge-base --is-ancestor`), so git's commit graph orders the limit before the run without relying on any clock. By the clocks, the merge came 14 h 19 min 41 s before P1's S (13:37:51Z). It also came before any run of the routine: R1a's S is 2026-10-11T08:08:23Z.

**Measured, against the limit** (ROW7.md:31-33, 43-45; the session's own clock):

| Candidate | Whole command | Download and load | Embedding of 12 sentences | Limit | Under the limit by | Share of the limit | Run's result |
|---|---|---|---|---|---|---|---|
| M1 `intfloat/multilingual-e5-small` | 21 s (13:42:14Z to 13:42:35Z) | 18.9 s | 0.05 s | 600 s | 579 s | 3.5 % | `fits` |
| M2 `BAAI/bge-m3` | 43 s (13:42:57Z to 13:43:40Z) | 33.2 s | 4.41 s | 600 s | 557 s | 7.2 % | `fits` |

- **Margin.** The limit is 28.6 times M1's command and 14.0 times M2's.
- **The 2-minute default.** Both commands also finished within the 2-minute default after which a command moves to the background (F11), and neither moved (ROW7.md:31, 43).
- **The install.** It took 64 s, from 13:40:16Z to 13:41:20Z (ROW7.md:10). It is not counted, as the design says. As arithmetic only: adding it to each command would give 85 s and 107 s.
- **What "download and load" includes.** `embed.py` starts that clock before it imports sentence-transformers (embed.py:36-40), so the import is in it too. The limit applies to the whole command, which includes everything.
- **Commit order.** The commit dates agree with the order of the work: M1's record (`ea3b638`) at 13:42:45Z, 10 s after its command ended, and M2's (`8375090`) at 13:44:36Z. The dates come from the same clock as the times above.

## Item 3. The Actions part is recorded as moved to C04, before the ingestion jobs are built, citing C04 task 0

Moved.

- **The row moves it.** Plan C01 row 7 (line 950): "the Actions part moves to C04, where the job and its key exist, and is observed before the ingestion jobs are built, C04 task 0".
- **C04 task 0** (plan line 1018): "**Moved from C01** (rows 7 and 15; W-C00-10, T-15): before the ingestion jobs are built, the candidate model's run in the Actions job within its time limit (C01 #7) and the library transfer job's read-only access with no content in its records (C01 #15) are observed, with the job in `devos-backup` and the read-only key (Section 12 item 2). A failed row changes the plan (Section 14) before task 1."
- **The stage, and the work its fail path comes before.** The part moves to C04 and is observed in task 0. Its fail path ("The model is made smaller or ingestion is made less frequent; the effect on quality is measured and goes to a decision") applies before task 1, the ingestion jobs. This follows the plan's rule for a moved row (line 940): "A row whose components cannot be stood in for moves to the stage where they exist, and its fail path applies before the work that depends on it." The design says the same: "The Actions part is not here: row 7 moves it to C04 task 0" (ROUTINE_DESIGN.md line 107).
- **The note.** `plan/work/C04.md` carried no note naming W-C01-14. N-179 is added there with this record. It also says that the 600-second limit came from the session's foreground-command bound (F11), so it is not the job's limit, and that task 0 states the job's limit before the job runs.

## What the evidence does not show, and the inferences made

These are kept apart from the observations above.

1. **Assumption: the pinned revision was the one loaded.** The run printed the revision it was given, not one resolved from the hub (embed.py:52-53). It is assumed that sentence-transformers 6.1.0 passes `revision` to the hub download, so the loaded files are those of the pinned commit. If it did not, the files would be the hub's current ones for that model ID. "Runs and fits" would still hold for the model ID, but the link to the pinned revision rests on this assumption.
2. **No model-specific prefix (P1's own D1, CLOSING.md:41).** The sentences were embedded as written; P1 says the e5 model has a recommended prefix. This bears on M1's similarity values. It does not bear on loading, embedding or time. Inference: a prefix adds a few tokens to each sentence; M1's embedding took 0.05 s inside a 21 s command, so even a many-fold rise would leave it far under 600 s. It does not affect the success condition. The prefix is part of the vector binding that T-69 records (N-094 on `plan/work/C04.md`: "the preprocessing with prefixes and normalisation"), and C04 task 3 chooses the model by measurement.
3. **One run per candidate (P1's own D4, CLOSING.md:44).** The spread of timings between runs is not observed, and most of each command was the download (18.9 s of 21 s; 33.2 s of 43 s), which depends on the network path. The success condition is met by the run observed. That a repeat would also fit is an inference from the margins of 28.6 and 14.0 times, not an observation. Assumption: run-to-run variation stays well below those factors. This limits the claim to the one run; it does not affect the condition as written.
4. **Filtered output (P1's own D5, CLOSING.md:45).** The output was shown through a filter of progress-bar lines and `tail -30`, so a warning line could have been dropped. Every value `embed.py` prints is present in ROW7.md. Inference: if the command was a pipe without `pipefail`, the "exit 0" may be the filter's status rather than Python's. The exact command line is not recorded. Even so, the last lines `embed.py` prints are present, and it prints them only after loading and embedding (Item 1). It does not affect the success condition.
5. **The times are the session's own.** No outside clock timed the commands, and the commit dates come from the same clock (D-017 item 2(a)).
6. **One machine.** It had 4 CPUs and no GPU (ROW7.md:12-13). The design notes that on a machine with a GPU the CPU time measured is the slower case (ROUTINE_DESIGN.md line 109). A smaller machine is not covered, and neither is the Actions runner, which belongs to C04 task 0.
7. **One download each, unauthenticated.** R1a and R1b each ran on a freshly booted machine (EV-C01-007, point 2), so a later session that uses the model may have to download it again. Only one download per candidate was observed.
8. **Peak memory** was 1012 MB for M1 and 3009 MB for M2, of the 16093 MB the machine showed (ROW7.md:35, 47). The row sets no memory limit; the values are recorded only.
9. **Denials.** The session ran in auto mode, where the permission classifier reviews calls (ROUTINE_DESIGN.md line 79). P1 recorded no denial by the guard or by any other gate (CLOSING.md:33-35). Its install used the CPU index command with no fallback (ROW7.md:7). So CHK-C01-055 C1 and CHK-C01-064 C1 have nothing to judge, as L-210 records.

**Effect on the success condition.** None of P1's D1, D4 and D5 caveats changes whether the candidate model "runs in the session … and fits within the time limit". D4 limits the claim to the one run observed.

## Similarity values (recorded, not judged)

Row 7 asks for no quality judgement, and none is made here. The values are as P1 printed them, with the sentences embedded as written (ROW7.md:36-37, 48-49):

| Pair | M1 `multilingual-e5-small` | M2 `bge-m3` |
|---|---|---|
| TR1–EN1 (parallel) | 0.8860 | 0.8235 |
| TR2–EN2 (parallel) | 0.9182 | 0.9499 |
| TR3–EN3 (parallel) | 0.8993 | 0.8991 |
| TR4–EN4 (unrelated) | 0.7727 | 0.4824 |
| TR5–EN5 (unrelated) | 0.7192 | 0.4399 |
| TR6–EN6 (unrelated) | 0.7585 | 0.4736 |

The model choice and its quality measurement belong to C04 task 3, with task 2's search benchmark. The prefix belongs to the binding T-69 records (N-094). So no note asks for a quality judgement elsewhere.

## What P1 noticed about itself that bears on other rows (pointers, not judgements)

- **The fire reason "scheduled" for a Run now press.** P1's stamp reads "scheduled" (STAMP.md:9). Batu's press is known from his comment at 13:37:20Z (D-022) and from S, 13:37:51Z, which matches no schedule time. This is the same as R1b (CHK-C01-043; ROUTINE_DESIGN.md line 89; EV-C01-007, "R1b's start"). It is already covered there, so no new note.
- **Attribution lines that name a model.** The session's instructions ask for them in commit messages, while another of its instructions forbids model identifiers in pushed artifacts (CLOSING.md:51; OPENING.md:12). All seven commits on the branch carry a `Co-Authored-By` trailer that names a model, and a `Claude-Session` trailer (read from git). No open note covers this. N-180 is added on `plan/work/C05.md`, where `CLAUDE.md` and the role packages are placed.
- **`ccd_session` tools arriving after the first call.** P1 lists `ccd_session` (spawn_task, dismiss_task), "available after the run's first call, not with the start" (OPENING.md:23). R1a and R1b listed only `claude-code-remote` and `github` (their OPENING.md:24). For row 2 (W-C01-34, accepted), P1 names the server as the platform's own and counts no `other-server-*`, so its gate passed. The fact bears on the tool listing that S9's bridge rests on (N-136 on `plan/work/C02.md`; N-137 on `plan/work/C03.md`). No open note covers it. N-181 is added on `plan/work/C02.md`.
- **Seen from git by the producer, not noted by P1: the closing record was pushed twice.** The first push, `a35c352` at 13:45:04Z, had "9. Result: done" inside the numbered item, which rule 2.2's `^Result:` test does not match. The run moved the line to the start of a line in `7fd90ca` at 13:45:35Z. CLOSING.md item 4 lists five pushes and leaves out its own two. The executor's count at 13:45:58Z printed 1 (L-210). This bears on rule 2.2 for later runs and is covered by CHK-C01-053 C3 and CHK-C01-054 C3 (the count after each step). No new note.
- **The Claude Code version.** P1 read 2.1.296 from its own transcript (OPENING.md:16), the value N-111 and N-148 take as the baseline from the working session. This is a pointer only.
- **Plan 5.4's status label.** Plan 5.4 (line 535) labels "Whether the model can be downloaded to the session machine" as **[Awaiting verification: C01]**. For these two candidates, in a routine session on 2026-10-11, it was observed (Item 1). "The Actions time limits" in the same sentence is C04 task 0's. Any change of the label is the executor's, through plan Section 14.

## Facts taken from the documentation (PC-21 item 9)

- A foreground command waits 2 minutes by default and up to 10 minutes on request, and then moves to the background. Guaranteed by platform (documented in https://code.claude.com/docs/en/cloud-environments, "Time limits", read 2026-10-10; ROUTINE_DESIGN.md F11); not independently tested. CHK-C01-025 finding 14 adds that the page says these timeouts can be raised with `BASH_DEFAULT_TIMEOUT_MS` and `BASH_MAX_TIMEOUT_MS`; P1 used the 600 000 ms timeout the tool offered (ROW7.md:8, 27).
- Qualifiers:
  - Per environment, only the variables, secrets and network setting are separate.
  - The GitHub identity and the account's connectors are shared across the account.
  - An environment's variables are readable inside its own sessions.
  - The channel to the model's own service stays open whatever the network setting.
  - Routines are a research preview, so these readings are repeated when the platform changes (plan 0.3 item 12).
  - The page showed no last-updated date.

## Result

Row 7's C01 part is met, and its Actions part is recorded as moved:

| Part of the success condition | Result | Where |
|---|---|---|
| The candidate multilingual model runs in the session: both candidates, named with their revisions, loaded and embedded the synthetic Turkish and English sample in a run of the routine | met | Item 1 |
| … and fits within the time limit, fixed before the run at 600 s per command (`f8a1531`) | met: M1 21 s, M2 43 s | Item 2 |
| … runs in the Actions job and fits within its time limit | moved to C04 task 0, observed before task 1 (the ingestion jobs); N-179 | Item 3 |

No part is "could not check". The fail path does not apply to the C01 part. The moved part's fail path applies at C04, before task 1. The limits above stand with the result: one run per candidate, on one machine, timed by the session itself.
