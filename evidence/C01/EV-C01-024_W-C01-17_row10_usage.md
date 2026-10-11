# EV-C01-024 · W-C01-17: row 10, usage observation (the working session's readings of 2026-10-11; documentation read 2026-10-11)

**What this is.** The record W-C01-17 asks for: plan C01 row 10, part by part against W-C01-17's acceptance block. It draws on three sources. The first is three `get_session` readings that the working session took on 2026-10-11 (section 1). The second is the per-request usage fields of the same session's transcripts, summed by this record's producer (section 2). The third is the platform's documentation, as a researcher read it on 2026-10-11; its report is filed verbatim as `evidence/C01/EV-C01-024a_W-C01-17_row10_documentation_report.md` (cited "EV-C01-024a"). Each fact below is marked **documented** (with its source and the reading date), **observed** (with the reading or the sum), or **not stated**.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | Written at `main` `fa6d4308cc0c6dd5c4df4db3ed7dba2ae7454192`; EV-C01-024a is filed with it. The readings are of a live session, not of a run at a commit. The transcript sums were computed on 2026-10-11, after 18:15Z, from the transcript files as they stood then |
| Deployment configuration | **Session:** the working session `session_01XyxvJd3RayQk4HCrjurbVH`, a Claude Code cloud session, opened 2026-10-10T20:57Z. Claude Code `2.1.296` (the `version` field of its transcript records). Opus 5.5 at ultracode effort, in Accept edits (D-008). Its environment was not re-read for this record. In-process subagents (the Agent tool) and workflow agents run inside it. **Account:** Max, with extra usage off (criterion 25, plan line 232; Batu's confirmation, EV-C00-002 item 13). Whether it is Max 5x or 20x is not recorded. **Probe sessions:** none. The probe setup was never built (PC-21 note item 1), and the routine's runs record only limit messages, not usage readings (`CONTROL.md` 3.4 item 7; EV-C01-022 section 4) |
| Criterion version | W-C01-17's acceptance block at `fa6d430` (`plan/work/W-C01-17.md`, blob `63c440e06c79929bf2512fd2eaf05bf626802c5e`). The block's text is the same at `3becfca` (2026-10-06), `62f9e46` and `44cef4e` (the re-plan): its checksum is unchanged. It is read with plan C01 row 10 (line 954), the paragraph after the probe setup (line 941), the PC-21 note item 9, and Section 8 items 9 and 14 (lines 838, 843), all at `fa6d430` |
| Input | Three `get_session` calls by the working session, at 17:58Z, 18:06Z and 18:12Z on 2026-10-11, and the work it did around them. For the documentation, the researcher's six questions as its report restates them (EV-C01-024a, Q1 to Q6); its task text is not filed |
| Actual observation | The readings (section 1), with figures as the executor gave them to this record's producer. The per-request usage fields of the session's transcripts, read with `cat` and `grep` and summed with `awk` by this record's producer (section 2). The compaction boundaries' IDs and times in the main transcript. The documentation, as EV-C01-024a records it. The earlier readings in `plan/work/C00.md` and `plan/work/C01.md` (their "Usage" sections) and in L-176, L-178 and L-244 |
| Raw evidence ID | **R0:** `plan/work/C01.md`, Usage table (line 208), and L-244. **R0' and R1:** the executor's readings as given to this producer; they are not in the repository at `fa6d430`. **Transcripts:** the main transcript `/root/.claude/projects/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90.jsonl`; the 70 `subagents/agent-*.jsonl` files beside it, among them `agent-a3e1f376662839820.jsonl`, `agent-ab09006e8ed1043b6.jsonl` and `agent-a0036069bd37ae0c8.jsonl`; and the 102 `.jsonl` files under its two `workflows/` directories. They are local to the session's sandbox and are not filed, because they are conversation transcripts and the repository is public. They cannot be re-read once the sandbox is gone. **Documentation:** EV-C01-024a |
| Independence level | **Readings:** the working session observing itself (D-017 item 2(a)). The figures are the platform's, as the session read them. **Sums:** computed by a fresh-context producer subagent of the same session (the same model family), and not re-run by anyone else. The method in section 2 lets a checker re-run them while the sandbox exists. **Documentation:** read by a researcher subagent of the same session on 2026-10-11; this producer did not re-read it. Each documentation fact is "guaranteed by platform (documented, read 2026-10-11); not independently tested". `get_session` itself is not documented (EV-C01-024a Q1), so each meaning holds only for the matching documented field. A fresh-context checker judges this record (declared, Ek A 5.3; PC-06) |

## How the criterion is read

1. **The parts.** The block lists three parts. This record splits two of them, so that a result is never wider than its evidence:
   - (1a) readings taken before and after a known piece of work;
   - (1b) the effect of that session on the usage allowance;
   - (2a) how the allowance is shared with Batu's own usage, as documented;
   - (2b) that sharing, as observed;
   - (3) what the fields C00's Usage section reads mean, and whether they include in-process subagents, each marked documented, observed or not stated.
2. **"Effect on the usage allowance."** The allowance is the account's five-hour and weekly windows (EV-C01-024a Q4). The effect on it is read as the part of a window the session uses, in the allowance's own terms: a fraction, or a change of state that can be traced to the session. The session's token counts and `cost_usd` are its consumption, not that part. Under the other reading, where consumption counts as the effect, (1b) would be met. The result in section 4 is the same either way, because (2b) is not met.
3. **"Observed."** Observed means seen in a reading, or computed from the session's own records. A documented fact is never counted as observed (plan Section 8 item 14; PC-21 note item 9).

## 1. The readings

All figures are cumulative from the session's opening at 2026-10-10T20:57Z. `cost_usd` is the field as returned; section 3 says what it is.

| Reading | `updated_at` (UTC) | Input | Output | Cache read | Cache write | `cost_usd` | `context_usage` used (`after_boundary`) | `rate_limit_info` |
|---|---|---|---|---|---|---|---|---|
| R0 | 2026-10-11T17:58:47Z | 1,003,752 | 10,610,773 | 1,734,038,791 | 32,454,550 | 731.224386625 | 760,721 of 1,000,000 (`0a8784e6…`) | `seven_day`, `allowed_warning`, resets 1792256400 (2026-10-17T17:00Z), `isUsingOverage` false |
| R0' | 2026-10-11T18:06:26Z | the same as R0 | | | | | the same as R0 | the same as R0 |
| R1 | 2026-10-11T18:12:22Z | 1,007,298 | 10,749,187 | 1,766,847,153 | 32,886,345 | 743.484308025 | 287,017 of 1,000,000 (`27fc8d9b…`) | `five_hour`, `allowed`, resets 1791754200 (2026-10-11T21:30Z), `isUsingOverage` false |
| R1 − R0 | | +3,546 | +138,414 | +32,808,362 | +431,795 | +12.2599214 | | |

## 2. What the figures contain (observed; computed by this producer)

**Method.** Every assistant record in a transcript carries the `usage` of its API request (`input_tokens`, `output_tokens`, `cache_read_input_tokens`, `cache_creation_input_tokens`). One request can span several records with the same `requestId`. For each request, each field is taken as its largest value over those records, and the request is placed at its first record's timestamp. Sums are over requests whose time falls in the stated interval. Only `cat` and `grep` read the files; `awk` did the arithmetic on their output. No message text was read into this record.

### 2.1 When the figures are taken

- **R0 and R0'.**
  - R0's `context_usage` of 760,721 is exactly the input side of the main loop's request at 17:49:10.148Z: 2 input, 758,239 cache read and 2,480 cache write.
  - The main loop's next request came at 17:53:02.309Z, after a pause of 3 min 52 s.
  - R0's `after_boundary` `0a8784e6…` is the compaction boundary written at 15:18:40.993Z.
  - R0' is identical to R0, although by 18:06:26Z the main loop had made 77 more requests and an automatic compaction (17:55:08Z to 17:56:33Z; 784,797 tokens before, 36,424 after; boundary `27fc8d9b…` at 17:56:33.806Z).
- **R1.**
  - R1's 287,017 is exactly the input side of the main loop's request at 18:07:36.713Z: 2 input, 286,220 cache read and 795 cache write.
  - The next request came at 18:12:24.196Z, after a pause of 4 min 47 s. The executor's turn ended at about 18:08Z.
  - R1's `after_boundary` is the 17:56:33.806Z boundary.
- **Result.** R0, R0' and R1 each showed the session's state at the last pause of its main loop, which is where its last finished turn ended. None of them showed the state at the time of the reading.
  - At these three readings the figures did not change inside a turn, and they changed across a turn's end. This holds at two turn ends.
  - A fixed refresh delay cannot explain both: it would have to exceed 13 minutes at R0' and be under 5 minutes at R1.
  - This matches explanation (a) of EV-C01-024a Q3 (per-turn totals).
- **R2 does not fit this** (CHK-C01-097 finding 6; the checker's sums, by section 2's method).
  - R2 was read at 2026-10-11T18:30Z (`plan/work/C01.md`, Usage table): input 1,007,914; output 10,866,011; cache read 1,774,393,722; cache write 33,101,160; `cost_usd` 748.494108825; `five_hour` `allowed`. R2 − R1 is +616 input, +116,824 output, +7,546,569 cache read and +214,815 cache write.
  - No turn ended at about 18:13Z: the main transcript has a tool result at 18:12:24.744Z and the next model response at 18:13:51.331Z in the same turn. That turn ended at about 18:15:15Z (stop-hook summary at 18:15:17.657Z), after a background Agent launch at 18:15:08Z. The next turn began at 18:30:05Z.
  - All transcripts from R1's point to 18:15:17Z hold 30,365 output, 5,494,917 cache read and 137,388 cache write. A snapshot at that turn's end leaves about 85,000 output unexplained.
  - Adding the whole background producer (agent `ad8b7a81656ff9214`, 18:15:09Z to 18:29:48Z: 79,071 output, 5,188,443 cache read, 186,128 cache write) and the researcher in full gives 110,538 output, which fits, but exceeds the cache read by 3,209,032 and the cache write by 123,075.
  - So which point R2's figures reflect is not determined, and when the figures update is not determined beyond what R0, R0' and R1 showed.
- **`updated_at`.** It was the reading's own time at each of R0, R0' and R1, so it does not show when the figures last changed.
- **Correction.** The known work between R0 and R1 is therefore what happened between 17:49:10Z and 18:07:36Z (2.2). It is not the work between 17:58Z and 18:12Z.

### 2.2 The interval between R0 and R1: in-process subagents included

The interval is from after 17:49:10.148Z up to 18:07:36.713Z.

| Source in the interval | Requests | Input | Output | Cache read | Cache write |
|---|---|---|---|---|---|
| Main loop | 82 | 166 | 67,934 | 24,657,913 | 252,270 |
| Checker for CHK-C01-096 (agent `a3e1f376662839820`; 17:49:09Z to 17:59:40Z; its first request falls before the interval) | 53 | 106 | 34,681 | 5,320,580 | 148,907 |
| A second checker subagent (agent `ab09006e8ed1043b6`; its transcript runs from 17:42:34Z to 17:52:11Z, and 58 of its 68 requests fall before the interval; its 10 in the interval run from 17:49:51Z) | 10 | 20 | 16,508 | 1,410,391 | 20,153 |
| Sum | 145 | 292 | 119,123 | 31,388,884 | 421,330 |
| R1 − R0 | | 3,546 | 138,414 | 32,808,362 | 431,795 |
| Remainder | | 3,254 | 19,291 | 1,419,478 | 10,465 |

- **The main loop alone** accounts for 49% of the output delta, 75% of the cache-read delta and 58% of the cache-write delta.
- **With the two checker subagents** it accounts for 86%, 96% and 98%. The figures include in-process subagents: observed.
- **The researcher** (agent `a0036069bd37ae0c8`, 18:07:12Z to 18:11:42Z, 43 requests; 15,056 output, 3,462,150 cache read, 123,085 cache write) was still running when the turn ended.
  - Had it been counted in R1 in full, the cache read would exceed the delta by 2,042,672.
  - Had its five requests before 18:07:36.713Z been counted, the cache write would exceed the delta by 25,030.
  - So R1 appears not to include it.
- **The second checker** (agent `ab09006e8ed1043b6`) was still running at R0's turn end (CHK-C01-097 finding 5).
  - Its transcript starts at 17:42:34Z. Its requests continue at 17:49:00Z and 17:49:05Z, a tool result follows at 17:49:07.723Z and its next response at 17:49:51.274Z, with no end in between. It ended at 17:52:11Z.
  - 58 of its 68 requests fall before the interval: 116 input, 33,135 output, 5,227,379 cache read and 130,172 cache write. In R1 − R0 they would bring the interval's sum to 152,258 output, 36,616,263 cache read and 551,502 cache write, above the delta's 138,414, 32,808,362 and 431,795. So they were counted in R0, while it was still running, or not at all.
  - Whether its 10 requests in the interval were counted in R0 or in R1 could not be determined. If they were counted in R0, the remainder is 3,274 input, 35,799 output, 2,829,869 cache read and 30,618 cache write.
- **A subagent still running at a turn's end.** How it is counted is not determined: the researcher appears not counted at R1, and the second checker appears counted at R0.
- **The remainder** falls in the same interval as the automatic compaction at 17:55:08Z to 17:56:33Z, whose model call has no usage record in the transcript.
  - Its cache read is one to two times the 784,797 tokens compacted.
  - That the remainder is the compaction is an inference, not shown.
  - The documented SDK totals include "internal calls such as compaction" (EV-C01-024a Q2), but that is a matching field only.

### 2.3 The whole session: subagents and workflow agents included

These are the cumulative sums up to R0's point (17:49:10.148Z), set against R0.

| Source | Requests | Input | Output | Cache read | Cache write |
|---|---|---|---|---|---|
| Main loop | 1,631 | 3,424 | 1,665,860 | 773,952,285 | 5,906,913 |
| Main loop, 70 subagent transcripts and 102 workflow-agent transcripts | 9,237 | 18,638 | 8,588,636 | 1,685,028,531 | 31,516,630 |
| R0 | | 1,003,752 | 10,610,773 | 1,734,038,791 | 32,454,550 |
| Remainder | | 985,114 | 2,022,137 | 49,010,260 | 937,920 |

- **The main loop alone** is 16% of R0's output, 45% of its cache read and 18% of its cache write.
- **With every subagent and workflow agent** it is 81%, 97% and 97%. So the cumulative figures include subagents and workflow agents (observed). This agrees with 2.2 by a separate route.
- **The remainder is in no transcript.** It is about 2.0 million output tokens, 49 million cache read and 0.99 million input.
- **What it is: could not determine.** The candidates are the session's compactions (five, at 05:31Z, 08:48Z, 13:42Z, 15:18Z and 17:56Z on 2026-10-11) and other model calls that the transcripts do not log. Four compactions before R0 cannot account for 49 million cache read on their own, even at the size of 2.2's remainder each.

## 3. What C00's fields mean

C00's Usage section reads these fields "[Awaiting verification: C01 #10]". `get_session` itself appears in no documentation (EV-C01-024a Q1): **not stated**. Every "documented" entry below is for the matching field the researcher found, read 2026-10-11.

| Field | Documented (EV-C01-024a, read 2026-10-11) | Observed (this record) |
|---|---|---|
| Token counts: `input_tokens`, `output_tokens`, `cache_read_tokens`, `cache_write_tokens` | Input excludes prompt-cache reads and writes; cache read is "Tokens read from prompt cache" (monitoring-usage); the status line's `cache_write_tokens` is all tokens written to the cache this session (statusline.md:405). SDK `usage` is "main agent loop only"; SDK `modelUsage` and `total_cost_usd` include subagents and compaction (typescript.md:1660-1662) | Cumulative from the session's opening. R0, R0' and R1 showed them as of the end of the session's last finished turn; the later reading R2 does not fit that, so when they update is not otherwise determined (2.1). Carried across a compaction: R1 > R0 across the one at 17:56:33Z, while `context_usage` fell. Include in-process subagents and workflow agents, and a remainder that no transcript holds (2.2, 2.3). They behave like the SDK's session totals, not like its main-loop `usage`. That is an inference from the arithmetic, not a documented identity |
| `cost_usd` | Every matching cost field is an estimate computed locally at list price, "not what your plan bills" (typescript.md:2145; statusline.md:182). For Max and Pro subscribers it "isn't relevant for billing purposes" (costs.md:20) | Rises with the token counts: +12.26 from R0 to R1; 731.22 at R0's point for the session up to then. Not checked against a price list. That no charge arises still rests on extra usage being off (criterion 25; EV-C00-002 item 13), not on this field |
| `context_usage`: `used_tokens`, `max_tokens`, `after_boundary` | Not stated under these names. The closest field, `SDKContextUsage`, is the main loop's estimate of the tokens in use, "not a subagent's" (typescript.md:2055-2057) | `used_tokens` equals the input side (input + cache read + cache write) of the main loop's last request before the turn's end, exactly, at R0 and R1. `after_boundary` is the ID of the main transcript's last compaction boundary. Main loop only |
| `rate_limit_info`: window type, `status`, `resetsAt` | Python SDK `RateLimitInfo`: `allowed_warning` "means approaching the limit"; the types are `five_hour`, `seven_day`, `seven_day_opus`, `seven_day_sonnet` and `overage`; `resets_at` is Unix time; `utilization` is the "Fraction of the rate limit consumed (0.0 to 1.0)". The TypeScript reference lists other fields (typescript.md:5569-5580). The name `rateLimitType` is not documented. What fraction `allowed_warning` marks: not stated | One window at a time: `seven_day` at R0, `five_hour` at R1, with no weekly reset between them. No reading in C00's or C01's Usage tables carries a fraction. The `seven_day` readings read for this record (C00's table, L-176, R0) all name a reset on a Saturday at 17:00Z: 2026-10-10 in session `session_01WKJi23FwAjFtiyD1DbQ2Rs` (C00's table, 2026-10-06T01:32Z) and in L-176 (2026-10-09); 2026-10-17 in this session (R0) |
| `isUsingOverage` | Not documented. The closest field is `overage_status` | `false` at every reading in C00's and C01's Usage tables, and at R0' and R1 |
| `updated_at` | Not stated | The reading's own time at R0, R0' and R1 (2.1) |
| Do the figures include in-process subagents? | Not stated for `get_session`. The matching fields disagree (Q2: SDK `usage` excludes them; `modelUsage` and `total_cost_usd` include them; the `/usage` cache statistics are "the main conversation only") | **Yes**, for in-process subagents and workflow agents (2.2, 2.3). How a subagent still running at a turn's end is counted is not determined: the researcher appears not counted at R1, and the second checker appears counted at R0 (2.2) |

## 4. The parts

| Part | Result | Basis |
|---|---|---|
| (1a) Readings before and after a known piece of work | **Met** (observed) | R0 shows the state at 17:49:10Z and R1 at 18:07:36Z. The work between them is known from the transcripts: the main loop's 82 requests, an automatic compaction, the CHK-C01-096 checker and a second checker (2.1, 2.2) |
| (1b) That session's effect on the usage allowance | **Could not check** | The readings show the session's consumption: +138,414 output and +32,808,362 cache read, and +12.26 `cost_usd`, a list-price estimate. They also show one window's state, with no fraction: R0 shows `seven_day` and R1 shows `five_hour`, so no change of state can be traced to the work. The fraction used is documented as shown to the account owner (Settings > Usage, `/usage`, the status line) and to SDK hosts, not in any documented cloud-session tool (EV-C01-024a Q5) |
| (2a) How the allowance is shared with Batu's own usage | **Met as documentation** (documented, read 2026-10-11) | One allowance for Claude and Claude Code, "all activity in both tools" (help 11145838, modified 2026-10-08). It covers claude.ai, Claude Code and Claude Desktop (help 11647753, modified 2026-10-08), and routine runs "the same way interactive sessions do" (routines.md:378). The windows are five-hour and weekly (11647753); the weekly reset is "a fixed time each week that is assigned to your account" (help 11049741, modified 2026-10-07); usage counts against both at once (errors.md:712). Subagents and workflows draw on the same limits, and ultracode reaches a limit sooner (sub-agents.md:11; workflows.md:156, 436). Separate from it: the hourly routine start limits, the API credits included with Max, and a separate weekly limit for Fable. The readings fit the documented fixed weekly reset (section 3, `rate_limit_info`) |
| (2b) That sharing, as observed | **Could not check** | No reading separates the session's share from Batu's own use. His use in any interval is not recorded, and the documented account page shows the account's bars, not a split by surface or session |
| (3) The fields and subagent inclusion | **Met** | Each field is marked in section 3. Subagent inclusion is observed (2.2, 2.3) |

## 5. Observations on the usage windows

- **(a) When the figures change.** At R0, R0' and R1 the figures did not change inside one turn and changed across a turn's end, and a reading inside a turn showed the previous turn's end, so a before-and-after pair needed a turn's end between its readings (2.1). The later reading R2 does not fit that, so when the figures update is not otherwise determined (2.1).
- **(b) One window at a time.** `rate_limit_info` showed `seven_day` `allowed_warning` at R0 and `five_hour` `allowed` at R1. No weekly reset fell between them; the weekly window resets at a fixed time (2a), next at 2026-10-17T17:00Z. So a reading that shows `five_hour` `allowed` does not show the weekly window's state, and the window shown is not always the one at warning. Which window a reading shows: not stated.
- **(c) How fast the weekly warning came.**
  - The weekly window's `resetsAt` was 2026-10-10T17:00Z in L-176's reading, and one week later in R0. R0 is at `allowed_warning`, at most 24 h 58 min after that reset.
  - The reading at 15:22Z that day showed `five_hour` (EV-C01-022 section 3), which by (b) does not show the weekly state. So when within those 25 hours the warning began is not known.
  - The week before, the window was at `allowed_warning` by 2026-10-06T01:32Z (C00's table), at most about 56.5 hours after that window began (2026-10-03T17:00Z, one week before its reset).
  - This session's `cost_usd` up to R0's point is 731.22, a list-price estimate, from its opening about 4 hours after the reset. The account's other use in the window, Batu's included, is not known.
  - These are data points for an estimate, not a capacity figure. The documentation gives no capacity in any unit (EV-C01-024a Q6).

## 6. Result

- **The success condition is not met as a whole.** It counts as met "only when every part of it is observed and recorded". Parts (1b) and (2b) could not be checked, and that holds under either reading of "effect" (How the criterion is read, point 2).
- **The two parts are handled as failed parts, not moved to a later stage.** No stage of the plan gives a cloud session a surface that shows the fraction of the allowance used. DevOS's sessions are cloud sessions that routines start (plan 6.4), and the documented surfaces are the account owner's page, the CLI's `/usage` and status line, and SDK hosts (EV-C01-024a Q5). Batu's own usage page exists now, but his own use moves the same bars. Whether to ask him for such a reading is weighed in PC-36, alternative (B).
- **Fail path: "Capacity is worked out by estimate; the uncertainty is recorded".** It is applied by `plan/decisions/PC-36.md` (status `proposed`), to the plan places that rest on a usage observation: K-7 item 9, the first item of 6.4, U-5 with a note under Section 10.2, C11 task 3, and Appendix G's G7 row and G9 item 3a.
- **No part of it is a decision of Batu's.** None of those places carries a [Batu kararı] label. D-002 (his standing usage policy) and criterion 25 are cited, not changed, and no budget figure changes. So no decision record for Batu follows from it.
- **C00's reading is answered here.** Its "[Awaiting verification: C01 #10]" reading is answered by section 3, and a dated line under C00's Usage section points here.

## 7. Limits of this record

- **The transcripts.** They are not filed, and they can be re-read only while the session's sandbox exists. The sums were computed once, by one producer. Taking each field's largest value per request is this producer's rule; a request whose records disagree in another way would be miscounted.
- **R0' and R1.** Their figures come from the executor; this producer took no reading. R0, R1 and R2 are in `plan/work/C01.md`'s Usage table; R0' is recorded here and in L-245.
- **One interval.** The turn-end pattern rests on R0, R0' and R1 (two turn ends), and R2 does not fit it, so when the figures update is not determined (2.1). Subagent inclusion rests on one interval and on the cumulative totals. How a subagent still running at a turn's end is counted is not determined: the researcher appears not counted at R1, and the second checker appears counted at R0 (2.2).
- **The documentation.** It was read by the researcher, not by this producer. It documents matching fields, not `get_session`.
- **`cost_usd`.** It was not checked against a price list, and the remainder of 2.3 is not explained.
