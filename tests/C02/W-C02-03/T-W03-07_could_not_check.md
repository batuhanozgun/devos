# T-W03-07 · Missing, unreadable and partial input give "could not check", counted apart and blocking

Synthetic test data (plan Section 8 item 13): part A's inputs are made up in `test_decision_steps.py`. Part B's fixtures are made up inside a rolled-back transaction (versions `2999…`, names `w03_fixture_*`). Part C plants nothing in `devos`.

**Serves.** W-C02-03 point 7: "✘ With the expected set missing, with the database's record unreadable, and with a partial read (for example the connection lost mid-comparison), `deployment_drift` gives "could not check", never "no difference". That result is counted apart from clean and from fail, and where it guards a merge or a write it blocks it (B:387; plan Section 8 item 14)." It also serves EV-C02-001 section 4, "The caller treats an error, a timeout, a cut connection, a missing or malformed result, or an unset flag as "could not check"", and section 10, point 7.

## Parts

**Part A · The caller's half** (executable: `test_decision_steps.py`, T-W03-DEC's interface). Each of these gives `apply = no` and `result_kind = could_not_check`, never `no_difference`:
- D13: the result is "could not check".
- D14: the call raised an error.
- D15: the call timed out or the connection was cut.
- D16 to D18: the result is empty, not JSON, or not an object.
- D19, D20: the completeness flag is absent or false.
- D21 to D23: the status and the list disagree, or the status is absent.
- D24: no call was made.
- E09 to E17: the three reads incomplete, not in one snapshot, absent or partial.
- E22, E23: the history table present and its row count not read (null, or the field missing).

Blocking where it guards a merge: `pr_decide` gives `fail` for a pull request changing a merged migration when the report is absent (P07), lacks a project (P08), is at another commit (P09), is not completed (P10), is not JSON (P15), or has one project "could not check" (P16). For a pull request that only adds migrations, "could not check" is shown in the state and does not block (P02), as M16 decides.

**Part B · The function's half** (executable: `supabase/migrations/tests/w03_drift_could_not_check.sql`). Each case gives `could_not_check`, or raises (which the caller counts as could not check, part A D14), and never `no_difference`:
- `expected` missing: C02 (null), C03 (an empty object), C04 (not an object).
- `expected` malformed: C05 (migrations not a list), C06 (a migration without its version), C07 (functions absent), C08 (commit absent). For C09 (the same version twice), any answer but `no_difference` is accepted.
- The history table unreadable: C10, renamed inside a subtransaction that is then rolled back.
- The function record unreadable: C11.
- Each record partly unreadable, a column renamed: C12, C13.

Positive control C01: a well-formed `expected` with readable records gives `no_difference`, so the function does not answer "could not check" to everything.

**Part C · The live partial read** (specification; the build makes it):
- (c1) T-W03-14's "could not check" variant: `devos-test` unreachable, or its read cut. The run record shows `devos-test`'s comparison "could not check", `go` not `yes`, and the `devos` apply skipped with that reason.
- (c2) The comparison step's own client, the step that calls `deployment_drift` and produces `DRIFT_CALL` and `DRIFT_RESULT`, is run against the throwaway database by the break harness. There a test copy of the function sleeps longer than the step's client-side timeout (EV-C02-001 section 10, point 7: "a delay planted in a test copy"). The step must report `DRIFT_CALL = timeout` (or `error`) and no partial result. This needs the comparison step to take its connection parts from its `env:`. If the build hard-codes them, (c2) is "could not check" and the record says so.
- (c3) Counted apart. In the run report, each project's comparison result is one of three values. Over the item's runs, the record counts no-difference, difference and could-not-check results separately, with each run's ID, and none of the could-not-check results is counted as clean.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-07. Missing, unreadable or partial input to the comparison, in the function or at its caller, gives "could not check", never "no difference". That result is kept apart from the other two, and it blocks the `devos` apply and a pull request that changes a merged migration. |
| **Failure class rule** | A comparison that did not run in full is taken as clean, or as an ordinary difference that lets work go on, or is dropped from the count. Examples of this family: the function returns "no difference" on bad input; it returns a partial list as complete; it raises and the caller reads the silence as clean; the caller drops the completeness flag; the pull-request check passes a change to an applied migration without a readable report. |
| **Examples** | Missing: B C02 to C04; A D16, E13; `pr_decide` P07.<br>Malformed: B C05 to C09; A D17, D18, D21 to D23, E14, E19; P15.<br>Unreadable: B C10, C11; A D14.<br>Partial: B C12, C13; A D15, D19, D20, E09 to E12, E15 to E17, E22, E23; P08 to P10, P16; C c1, c2. |
| **Negative control** | Every example gives "could not check" (or, in part B, raises), and the guarded work is blocked: `apply = no` or `verdict = fail`. |
| **Positive control** | B C01 (`no_difference` on well-formed input); A D01, D05, E01, E02; `pr_decide` P01, P02 (adding migrations under "could not check" is shown, not blocked, as M16 decides), P06, P13, P14; live, T-W03-05's run. |
| **Break attempt** | **B4** (`breaks/B4_could_not_check_as_clean.sql`, throwaway database only) turns "could not check", an error or a null result into "no difference". C02 to C13 must turn red.<br>**B2** turns C07 red as well.<br>**Part A's breaks** (T-W03-DEC): a copy of `decide` that treats a missing completeness flag as complete (D19), and a copy of `pr_decide` that passes on "could not check" (P07 to P10, P15).<br>The self-check on PostgreSQL 16.15 with a scratch stub (not delivered) gave B4 12 bad of 13 and the unpatched run 13 of 13. |
| **Stage and environment** | C02.<br>• Part A: anywhere with Python 3 and PyYAML, no credential.<br>• Part B: in `devos-test` by the job's test step as `postgres` (P10), and with B4 on W-C02-07's throwaway database (plan Section 8 item 3), with `w03.throwaway = 'yes'`.<br>• Part C: GitHub's run record (c1, c3) and the throwaway database (c2).<br>Probes relied on: P1 (the history table), P10, and P4 for the queue (a run behind another reads a settled state). |
| **Independence level** | As T-W03-06: written by the test designer, run by the build producer and the job, assessed by the fresh-context checker of point 13 from raw outputs; shared model lineage and design record. |
| **Evidence layer** | Structural (function and caller behaviour on planted input; the CI's stop observed live). |
| **Evidence envelope** | As in the README. `observations_ref` for c1: the run ID and the report line of `devos-test`'s comparison and of the `devos` skip reason. For c3: the list of run IDs with each project's result. |

## Could not check

- Part B without the function or a record (the file raises COULD NOT CHECK).
- A case whose unreadable state could not be planted (not the owner of the table, for example). That case is "could not check", not "ok".
- c2 if the comparison step's connection is not configurable.
- c1 if no "could not check" variant was made.

## Depends on R1 to R6

R6 bears on E11 and E12 only, which accept both of its forms and refuse anything else. P13's widening (the executor's decision of 2026-10-12; T-W03-DEC "Depends on") made T-W03-DEC's E05 a positive control and added E20 to E24 there; E22 and E23, the history table present with its row count not read, are partial reads of this test's class. R1 to R5 do not touch this test.
