# T-W07-T31 · Planted filled-but-meaningless records are caught at the rate written before the run

Synthetic test data (plan Section 8 item 13): the 80 planted records (20 needs, 20 `high_impact` decisions, 20 effort policies, 20 findings), the complete records used to align the streams, and the fixtures are made up, labelled `SYNTHETIC W-C02-07` or `w07_fixture`, and rolled back; nothing planted is kept. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 points 3 ("✘ T-31: planted filled-but-meaningless records, in a number W-C02-07 wrote before the run, reach that queue at the set share, within the tolerance W-C02-07 wrote before the run") and 7 ("T-31's rate test"); W-C02-13 point 5. W-C02-07 point 4. N-074 T-31's C02 part: CHK-C00-022 F12 (c), "Add planted filled-but-meaningless records … to be caught at a rate written in advance". Design: EV-C02-002 DM-08 (one in every block of 10 per stream, at a hidden random position drawn when the block opens), DM-30 (Finding is a stream).
**Command.** Part A: `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_t31_planted_rate.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below. Part B (phase C4b): `tests/C02/W-C02-07/harness/scenarios/t31_open_block.sql`, a scenario that commits in several transactions, run only by the harness on its throwaway database, with `breaks/B-N01-4_open_sample_not_withheld.sql`, which names it (statement timeout 180 s). The test is PASS only when both parts are.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit (about 120 calls in one transaction).
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8): `devos_api.record_need`, `open_decision`, `set_effort_policy`, `record_finding`, `admit_work`, `open_mission` (jsonb in, jsonb out; acceptance carries `id`); calls run as `anon` with the header `x-devos-env-token` from `devos_private.issue_env_token(text)`; `devos_private.sample_stream` (`stream`, `block_size`, `block_seen`, `block_position`) with streams `need`, `decision`, `effort_policy`, `finding`; sample reviews in `devos_private.review` (`kind = sample`, naming the target's `id`, one field holding `devos_denetim`); fixtures: a Mission opened with the `devos_kurulum` token on a `batu` decision answered at owner level.


**Phase C4a (EV-C02-008 section 2, merged and accepted; PC-46).** As T-W07-5D: the design now states that the database's own sample Reviews are not review records for DM-41's trigger (EV-C02-008 2.2), in place of the earlier assumption; `T-W07-N28` part A2 tests it.

**Phase C4b (EV-C02-008 section 5.2, N-263, decided and accepted; PC-47 places 2 and 3).** T-31's planted numbers, rate (2 in 20 per stream) and tolerance (0) are unchanged: part A counts samples as the owner. The test gains `T31-unseen-<stream>` (part B): in each of the four streams, inside a block of planted records, the open sample and a Verdict on it are unseen by the working token, as `T-W07-N01` part B's N01-unseen-<class> shows (the same steps and sub-checks, in a copy of the same scenario code, README section 7). Part B is a harness scenario for the reason `T-W07-N01` states (EV-C02-002 DM-41 (a): the Verdict cannot share its target's transaction). Open dependency: N-264's frame review of the hidden position (TABLES G23) may change DM-08's draw; the cases are then revised before any result.

## Written before any run (W-C02-07 point 4)
- **How many are planted:** 80: in each of the four format-gated streams of C02 (Need; Decision of class `high_impact` at `open`; EffortPolicy; Finding), two complete blocks of 10, every record filled but meaningless, the two kinds by turns (kind 1: a placeholder such as `-`, `x` or `n/a`; kind 2: a circular or unrelated text, or a declared `changeable = false` on a time-bound claim).
- **The share it runs with:** one in every block of 10, W-C02-04's recorded share (EV-C02-002 DM-08), read from the database and checked (`T31-share-*`). The run does not change it.
- **The rate at which they must be caught:** 2 of 20 per stream, 8 of 80 overall, one in every complete block: rate 0.1.
- **Tolerance:** 0 records. **Reason for both:** DM-08 samples exactly one record per complete block at a position drawn when the block opens; the run starts each stream at a block boundary and plants only complete blocks in which every record is planted, so whichever position is drawn, exactly one planted record per block is sampled. A random draw per record would need a tolerance; this design does not (DM-08 (b)).
- "Caught" here means: reaches the audit environment's queue as a `Review` of kind `sample` (W-C02-10 point 3). Whether the audit environment then recognises it as meaningless is C03's and later (W-C02-10 "Not covered" (a)).

## Cases
- `T31-share-need`, `-decision`, `-effort_policy`, `-finding`: the stream's `block_size` is 10.
- `T31-need`, `T31-decision`, `T31-effort_policy`, `T31-finding`: aligned to a block boundary with complete records, then 2 blocks of 10 planted records: every one accepted; exactly one sample review queued for `devos_denetim` per block; the stream ends at a boundary.
- `T31-total`: the four streams each caught 2 of 20: 8 of 80, rate 0.1, tolerance 0.
- Part B (phase C4b; `harness/scenarios/t31_open_block.sql`): `T31-unseen-need`, `-decision`, `-effort_policy`, `-finding`. In each stream, written with the working token (EffortPolicy: kind (a), each record on a work item of its own), planted records of T-31's two kinds by turns until the database draws one with the block still open; then the reads, a Verdict on the sample with the audit token in a later transaction, the reads again, `relate` with the sample's and the Verdict's ids as an end, and the walks, each judged as `T-W07-N01`'s N01-unseen-cal judges them (unchanged by the Verdict, holding none of their ids, the same as for an undrawn record or for an id that names no record).

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-T31`: planted filled-but-meaningless records reach the audit environment's sample queue at the share written before the run, with no tolerance. |
| **Failure class rule** | **[Designer's addition: T-31 names the condition, not a class.]** Any way a format-gated record passes the database's gate and is never seen by the audit environment's sample at the recorded share: no sample, a sample of another share, a sample a writer can avoid, a stream that a busy family crowds out. |
| **Examples** | Original finding (CHK-C00-022 F12 (c)): "no acceptance condition shows that sampling catches anything" (`T31-need` etc. fail when no sample is made). Another manifestation: a share other than the recorded one (`T31-share-*`). |
| **Negative control** | The planted records are the wrong input: each must be accepted by the database (format gates do not judge content) and one per block must land in the audit queue. A run in which a block's planted records produce no sample, or two, is `bad`. |
| **Positive control** | Every planted record is accepted (the gate does not refuse filled fields); the complete records that align each stream are accepted too. |
| **Break attempt** | **[Designer's addition.]** (1) `breaks/B-T31-1_sample_skipped.sql` (every Review of kind `sample` dropped): red `T31-need`, `T31-decision`, `T31-effort_policy`, `T31-finding`, `T31-total`. (2) `breaks/B-T31-2_share_changed.sql` (the four streams' block set to 20): red `T31-share-need`, `-decision`, `-effort_policy`, `-finding`. (3) Phase C4b, EV-C02-008 5.2's table ("B-N01-4's patch, applied to T-31 as well"): `breaks/B-N01-4_open_sample_not_withheld.sql` (the withholding removed) names part B too; red `T31-unseen-need`, `-decision`, `-effort_policy`, `-finding`. |
| **Stage and environment** | C02. Part A: `devos-test` (migration job step) and the throwaway database; synthetic tokens (`sql-set-role`). Part B: the throwaway database only (a scenario that commits), so its claims rest on that transport alone. |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. It does not show that the audit environment recognises a meaningless record, nor that one in ten is enough (W-C02-10 "Not covered" (f): the share is W-C02-04's decision). |
| **Evidence envelope** | README section 4. Fixed before the run: the numbers above (80 planted, block 10, 8 caught, tolerance 0); part B's four streams, the working token, at most six blocks tried per stream, and B-N01-4's red cases. Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

## Clause table (W-C02-07 point 4; T-31's sources)
| Clause | Case ID(s) | Or: moved to |
|---|---|---|
| F12 (c): "planted filled-but-meaningless records … to be caught at a rate written in advance" | `T31-need`, `T31-decision`, `T31-effort_policy`, `T31-finding`, `T31-total` | — |
| "the sample share it runs with (as W-C02-04 sets it)" | `T31-share-*` | — |
| "the rate at which they must be caught, with its tolerance and the reason for both" | this file's "Written before any run" | — |
| F12 (c): "green-but-wrong completed work", with the silent-failure sampling | — | C10 (PC-08; W-C02-07 point 4) |
| T-31's other parts that name C02: criterion 12 | — | C10 (PC-08) |
| T-31's other parts that name C02: criterion 14 | — | C06 (PC-08) |
| CHK-C00-035 item 3, the open-exploration rule | — | `T-W07-N02` (`N02-oe-*`) |
| (not T-31; EV-C02-008 5.2's table, phase C4b) T31-unseen-<stream>: the open sample unseen in each of T-31's streams | `T31-unseen-need`, `-decision`, `-effort_policy`, `-finding` (part B) | — |

## Format gate (point 4)
Every planted record is a "filled but meaningless" example: the database must accept it, and one per block lands in sample review.

## Could not check
COULD NOT CHECK when an object is absent (`T31-pre`), a fixture cannot be made, or a stream cannot be read or aligned to a block boundary (that stream's case). Part B: a stream's case when its open block cannot be planted (for example a stream left at a block of 1 by a scenario run earlier in the same database, as `T-W07-N28` part B2 leaves the decision stream; the harness runs a patch's files on fresh clusters, and no patch names both), a read or call is not answered in interface v1's form, or the walk fixtures cannot be made; part B runs only under the harness, and the test is not PASS before it has.

## Self-check (not a result; README 10)

Phase C4b, 2026-10-12, PostgreSQL 16.15, on a scratch stub of README 8.1 and EV-C02-008 sections 1, 2 and 5 (outside the repository, not delivered; the test designer's reading of the design, not the build): part A PASS (9/9); part B, run as the harness runs a scenario on the stub, PASS (4/4); B-N01-4 turned exactly its named cases red in both of its files; B-T31-1 and B-T31-2 still turned exactly theirs. On an empty database: COULD NOT CHECK.

## Not covered
The audit environment's judgement of the sampled records (C03 onward); the routine-labelled streams' rate (`T-W07-N29`; their unseen cases are `T-W07-N01`'s N01-unseen-routine-*); a bias of the hidden position between kinds within a block (all records of a block are planted here; the mechanism is stated in W-C02-10 point 3's record); `devos`. Phase C4b, the residuals of EV-C02-008 5.2 (e) that no test here reaches, each with its owner and deadline there:
- **The audit class writes in the EffortPolicy stream** (5.2 (e), first item): `devos_denetim` writes reductions and standing policies and reads every sample at once, so for its own EffortPolicy records the position is not hidden from their writer. T-31's EffortPolicy stream is written with the working token here. Owner: the executor; deadline: C03's design of the audit environment's sessions.
- **Timing** (5.2 (e), second item): a drawing call does one more insert and event, which a writer timing its calls might detect. Not measured here; W-C02-10's record states it, and C06 reads it again (N-214 item 3).
- **The builder's read-only connection** (5.2 (e); CHK-C02-028 C3): it reads outside `devos_api` and is no role class, so it can read open samples, their Verdicts and events, the streams' block state, and values that change with withheld records (the events' growing `id`, sequence values, statistics counters; CHK-C02-037 condition 1). No test here reaches it. W-C02-10's showing for point 3 states it and the candidate taken, before the builder's first sample-stream write in `devos`.
- **The export to `devos-backup`** (5.2 (e); CHK-C02-032 condition 1; CHK-C02-037 F9 (3)): `devos_backup`'s read for the export is not withheld, and an hourly export made while a block is open can copy its sample, any Verdict on it, their events and its block state to `devos-backup`, which sessions are treated as able to reach (P:726). No `devos_backup` credential exists outside a test transaction until C09 (EV-C02-003:382), so no test here can reach it. Owner: the executor; deadline: C09's start, before the backup's first export (N-176 on `plan/work/C09.md`).
