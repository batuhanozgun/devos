# T-W07-T31 · Planted filled-but-meaningless records are caught at the rate written before the run

Synthetic test data (plan Section 8 item 13): the 80 planted records (20 needs, 20 `high_impact` decisions, 20 effort policies, 20 findings), the complete records used to align the streams, and the fixtures are made up, labelled `SYNTHETIC W-C02-07` or `w07_fixture`, and rolled back; nothing planted is kept. Tokens are issued at run time and never written down (README section 6).

**Serves.** W-C02-10 points 3 ("✘ T-31: planted filled-but-meaningless records, in a number W-C02-07 wrote before the run, reach that queue at the set share, within the tolerance W-C02-07 wrote before the run") and 7 ("T-31's rate test"); W-C02-13 point 5. W-C02-07 point 4. N-074 T-31's C02 part: CHK-C00-022 F12 (c), "Add planted filled-but-meaningless records … to be caught at a rate written in advance". Design: EV-C02-002 DM-08 (one in every block of 10 per stream, at a hidden random position drawn when the block opens), DM-30 (Finding is a stream).
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_t31_planted_rate.sql` (the migration job's `devos-test` step, as `postgres`); the break harness with the patches below.
**Time added to W-C02-13's run.** None: it waits on no schedule or limit (about 120 calls in one transaction).
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8): `devos_api.record_need`, `open_decision`, `set_effort_policy`, `record_finding`, `admit_work`, `open_mission` (jsonb in, jsonb out; acceptance carries `id`); calls run as `anon` with the header `x-devos-env-token` from `devos_private.issue_env_token(text)`; `devos_private.sample_stream` (`stream`, `block_size`, `block_seen`, `block_position`) with streams `need`, `decision`, `effort_policy`, `finding`; sample reviews in `devos_private.review` (`kind = sample`, naming the target's `id`, one field holding `devos_denetim`); fixtures: a Mission opened with the `devos_kurulum` token on a `batu` decision answered at owner level.


**Phase C, the executor's decision (DM-41 and sample reviews).** As T-W07-5D: the database's own sample Reviews are assumed exempt from DM-41's trigger, an interface for W-C02-10 (README section 8.1).

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

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-T31`: planted filled-but-meaningless records reach the audit environment's sample queue at the share written before the run, with no tolerance. |
| **Failure class rule** | **[Designer's addition: T-31 names the condition, not a class.]** Any way a format-gated record passes the database's gate and is never seen by the audit environment's sample at the recorded share: no sample, a sample of another share, a sample a writer can avoid, a stream that a busy family crowds out. |
| **Examples** | Original finding (CHK-C00-022 F12 (c)): "no acceptance condition shows that sampling catches anything" (`T31-need` etc. fail when no sample is made). Another manifestation: a share other than the recorded one (`T31-share-*`). |
| **Negative control** | The planted records are the wrong input: each must be accepted by the database (format gates do not judge content) and one per block must land in the audit queue. A run in which a block's planted records produce no sample, or two, is `bad`. |
| **Positive control** | Every planted record is accepted (the gate does not refuse filled fields); the complete records that align each stream are accepted too. |
| **Break attempt** | **[Designer's addition.]** (1) `breaks/B-T31-1_sample_skipped.sql` (every Review of kind `sample` dropped): red `T31-need`, `T31-decision`, `T31-effort_policy`, `T31-finding`, `T31-total`. (2) `breaks/B-T31-2_share_changed.sql` (the four streams' block set to 20): red `T31-share-need`, `-decision`, `-effort_policy`, `-finding`. |
| **Stage and environment** | C02. `devos-test` (migration job step) and the throwaway database; synthetic tokens (`sql-set-role`). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group C); its agent ID and type are in W-C02-07's "Record" (point 1). Run by the migration job, by W-C02-10's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests. Shared: model lineage and the design records (plan Section 8 item 7). |
| **Evidence layer** | Structural. It does not show that the audit environment recognises a meaningless record, nor that one in ten is enough (W-C02-10 "Not covered" (f): the share is W-C02-04's decision). |
| **Evidence envelope** | README section 4. Fixed before the run: the numbers above (80 planted, block 10, 8 caught, tolerance 0). Observation and raw evidence: the job's run and unedited output under `evidence/C02/raw/`, after the hygiene checks; transport `sql-set-role` or `throwaway`. |

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

## Format gate (point 4)
Every planted record is a "filled but meaningless" example: the database must accept it, and one per block lands in sample review.

## Could not check
COULD NOT CHECK when an object is absent (`T31-pre`), a fixture cannot be made, or a stream cannot be read or aligned to a block boundary (that stream's case).

## Not covered
The audit environment's judgement of the sampled records (C03 onward); the routine-labelled streams (`T-W07-N29`); a bias of the hidden position between kinds within a block (all records of a block are planted here; the mechanism is stated in W-C02-10 point 3's record); `devos`.
