# T-W07-F07 · Observations are appended, and past, current and accepted stay separate questions (C02 part)

Synthetic test data (plan Section 8 item 13): the Mission `synthetic.w07.f07`, its work item, three operations (`w07_fixture_key_f07_1` to `_3`) and six observations whose sources begin "w07_fixture synthetic" are made up and labelled SYNTHETIC W-C02-07. (c)'s "pull request merged" and "main reverted" are synthetic observations, not GitHub.

**Serves.** W-C02-09 point 8 ("F07 (its C02 part)"); C02 Acceptance's first line; Appendix C F07; B 3.12 ("Observations are appended, not deleted; a later 'unknown' does not erase an earlier 'applied'").
**Command.** `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_f07_observation_history.sql`, run by the migration job's `devos-test` step as `postgres` (README 5.1 (a)); on the throwaway database by the harness with `breaks/B-F07-1`.
**Time added to W-C02-13's run.** None. Observation times are given as data (`observed_at` two hours and one hour ago); nothing waits.
**Interface assumed.** The Group A common interface v1, as `T-W07-F01` states it (the return form, refusals returned, the token, fixture, claim and `prepare_operation` forms, the planted effect class). Also:
- `devos_api.record_observation(observation jsonb)` with `{operation_ref, source, observed_at, observed_effect}` (`applied` / `not_applied` / `unknown`), called with the working token (B:36, "external-effect intents and their observations"), with no claim token → `{status, id}`.
- `devos_api.operation_state(operation uuid)`, a read function marked `devos:read` (EV-C02-002 DM-36) → `{status, ever_applied boolean, current_effect text}`. B section 4 names no such read. It is the form this test assumes for "the current-state question", and W-C02-09 must provide it or the test designer revises the test to the build's read before the first result (README section 8).
- Owner reads of `devos_private.observation` (B 3.12's columns, `id`) and of `devos_private.work.acceptance` (the acceptance axis, B 3.3).

## Cases
| Case | Sequence on one operation | Expected |
|---|---|---|
| F07-a1 | applied (−2 h), then unknown (−1 h) | both rows present; the first row unchanged, column for column |
| F07-a2 | the same | `operation_state`: `ever_applied` true, `current_effect` `unknown` |
| F07-b1 | not_applied (−1 h) recorded first, then applied (−2 h) recorded second (out of order) | both rows; the first row unchanged |
| F07-b2 | the same | `ever_applied` true, `current_effect` `not_applied` (latest by observation time, not by arrival) |
| F07-c1 | synthetic sequence: "pull request merged" applied (−2 h), then "main reverted" not_applied (−1 h) | both rows; the first unchanged |
| F07-c2 | the same | `ever_applied` true, `current_effect` `not_applied` |
| F07-c3 | the same | the work item's acceptance axis is unchanged by the observations |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-F07`: no observation removes or changes earlier evidence, and the database answers "applied in the past", "current now" and "accepted" separately. **[Designer's addition: no claim line in the F entries (R2 section 5 (c)); drawn from the class rule.]** |
| **Failure class rule** | Appendix C F07: "Observations are appended, not deleted; a later observation does not remove earlier evidence; 'applied in the past', 'current now' and 'accepted' are separate questions." A member is any write that updates or deletes an observation, and any answer that merges two of the three questions. |
| **Examples** | The original finding, "applied → unknown → not applied" losing the earlier "applied": F07-a1/a2. Other manifestations: arrival order taken for time order (F07-b1/b2); an effect seen and then undone (F07-c1/c2/c3). |
| **Negative control** | In each sequence the earlier row must still be there and identical (`F07-a1`, `-b1`, `-c1`); a missing or changed row is `bad`. "Applied in the past" must stay true after a later unknown or not_applied (`-a2`, `-b2`, `-c2`). |
| **Positive control** | The current-state answer is right in each sequence (`F07-a2` unknown; `-b2`, `-c2` not_applied) and acceptance is untouched (`F07-c3`). A build that refused every observation fails, because the fixtures' observations must be accepted before any case can be `ok`. |
| **Break attempt** | (1) Removed: append-only observations ("updates allowed on the observation table"). (2) Path: `breaks/B-F07-1_observations_overwritten.sql` on the throwaway database. It disables the table's user triggers and wraps `record_observation` so that it overwrites every earlier observation of the operation with the new one. (3) F07-a1, -a2, -b1, -b2, -c1 and -c2 must turn red. Appendix C asks at least (a). Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (7/7); patched, exactly those six were red. |
| **Stage and environment** | C02 (this part). `devos-test`, in the migration job's step, with synthetic tokens. The throwaway PostgreSQL 17 database for the break. Never `devos`. F07 against real GitHub is C08's (Appendix C F07 "Stage: C02 and C08"). |
| **Independence level** | As README section 10. Written by the test designer (fresh-context `test-designer` subagent; agent ID in the Record). Run by the job, by W-C02-09's producer, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Structural. It does not show that an observation is true of the world (C08's real GitHub; C03's effect channels), nor the Data API path. |
| **Evidence envelope** | README section 4. Fixed before the run: the outcomes above; PASS at 7/7; the break's six red cases. `transport`: `sql-set-role` or `throwaway`. Raw evidence `W07-F07-<run_at>`. |

## Clause table
| Clause of Appendix C F07 (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "Class rule: Observations are appended, not deleted; a later observation does not remove earlier evidence; 'applied in the past', 'current now' and 'accepted' are separate questions" | F07-a1, -b1, -c1 (append); -a2, -b2, -c2 (past and current); -c3 (accepted) | — |
| "(a) applied, then unknown" | F07-a1, F07-a2 | — |
| "(b) observations arriving out of order" | F07-b1, F07-b2 | — |
| "(c) the PR merged, then `main` was reverted" | F07-c1, -c2, -c3, as a synthetic sequence | The run against real GitHub: C08 (Appendix C F07's stage; W-C02-07 point 2) |
| "Negative: In no case is past 'applied' evidence lost" | F07-a1, -b1, -c1, -a2, -b2, -c2 | — |
| "Positive: The current-state question gives the right answer" | F07-a2, -b2, -c2 | — |
| "Break: When updates are allowed on the observation table, (a) must fail" | B-F07-1 (F07-a1, -a2 among six) | — |

## Format gate
Not a format-gate test.

## Could not check
COULD NOT CHECK before the build, when a fixture or an observation cannot be recorded, or when `operation_state` is absent or raises (the -a2, -b2 and -c2 cases), never PASS.

## Not covered
- Real GitHub (C08).
- Who may record an observation beyond the working token: `devos_ci`'s "writing observations" is narrowed by EV-C02-003 §5.2 and is the matrix's (T-W07-5B).
- Direct writes to the observation table: T-W07-5A.
