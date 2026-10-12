# T-W03-14 · The test project first, and the stop before `devos`

**Synthetic test data** (plan Section 8 item 13). The fixture migrations are synthetic and labelled (README, "Fixtures"):
- `w03_fixture_fail_test_only`: fails in `devos-test` only, if P11 finds a property that tells the projects apart; otherwise it fails in both.
- `w03_fixture_drop_row`: removes the history row of T-W03-05's fixture.
- `w03_fixture_restore_row`: inserts that row again if absent.

`test_workflow_order.py`'s skeleton is a synthetic workflow that is only read, never run. Its steps run `true`, except the `dbtests` runner text, which names psql and a `PASS` check so that the runner checks have something to read.

**Serves.** W-C02-03 point 14's observation. Point 14 is quoted in the item file; its observation reads: "✘ A synthetic failing migration, labelled as a fixture and merged through the merge gate, reaches `devos-test` and never `devos` … Second example of the class: the apply succeeds in `devos-test`, but the comparison there gives a difference, or "could not check" … and `devos` is not reached … Positive control: point 5's migration reaches both projects in the stated order … Break: with the stop removed from a copy of the workflow …, the test that shows the order turns red; if that test reads the workflow rather than running it, the record says so, and the live run above stays the observation of the order."

It also serves EV-C02-001 section 6 (d) and section 10, "Point 14's observation". The order is the one EV-C02-001 chose (M07): `devos-test` (apply, compare, tests), then `devos` (compare, decide, dry run, apply). No other order is chosen, so no alternative observation is needed.

## Observations (live)

| # | Fixture or case | What must be observed (raw) |
|---|---|---|
| 1 | `w03_fixture_fail_test_only` merged through the gate | **GitHub's record of the push run:**<br>• `devos-test`'s apply step concluded failure, and its compare step ran;<br>• the `devos` job ran, `decide` gave `apply = no` with reason `go`, and `dryrun` and `apply` concluded skipped and never started.<br>**`devos`'s record of applied migrations**, read by the builder's read-only connection, lacks the fixture's version, and `devos`'s comparison in the run names it `on_main_not_applied`.<br>If P11 found no per-project property, the fixture fails in both projects. The record then says the stop rests on GitHub's record of the run, since `devos` lacking it would also follow from a second failure. |
| 2a | `w03_fixture_drop_row` (applies in `devos-test`; its comparison there then gives a difference) | `devos-test`'s apply concluded success and its compare reports a difference (T-W03-05's version `on_main_not_applied`); `go` is not `yes`; `devos`'s `dryrun` and `apply` were skipped; `devos`'s history lacks `w03_fixture_drop_row`. P2 settles, before this fixture is written, how the command-line tool treats the missing row. |
| 2b | "could not check" in `devos-test` | Made only if it happens or can be made without a cost or a step of Batu's: `devos-test` unreachable (paused), or its read cut. `devos-test`'s comparison reports "could not check"; `go` is not `yes`; `devos` is not applied. If not made, the record says "2b not observed". T-W03-07 part C (c2) and T-W03-DEC (D14, D15) carry the class. |
| P | positive control: T-W03-05's run | The `devos` job's apply starts after every step of the `devos-test` job ends, by the step times. The merge record of T-W03-05's pull request shows three things in order: the gate's `class high:` line naming the file under `supabase/migrations/`, the covering verdict file committed before the merge commit, and the merge commit before both applies (by run start time). |
| R | the repairs | After 1, a pull request removes or fixes `w03_fixture_fail_test_only`. It is allowed by M16 because the file is unapplied in both projects, and is judged as any migration. After 2a, `w03_fixture_restore_row` is merged. The run after each shows "no difference" in both projects. The record states what each fixture left in each project. |

These runs may also be T-W03-06's forms (i) and (ii).

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-14. A migration reaches `devos` only after the same run's `devos-test` apply, comparison and tests succeeded, and only through a merge into `main` through the gate. On a failure, a difference or a "could not check" in `devos-test`, `devos` is not applied in that run. |
| **Failure class rule** | `devos` receives a migration that `devos-test` has not accepted in the same run. Examples of this family: `devos` is applied after `devos-test`'s apply failed; after its comparison found a difference or could not check; after its tests failed; at the same time as `devos-test`; or by a job or route other than the push run's `devos` job. |
| **Examples** | 1 (apply failed); 2a (difference after a successful apply); 2b (could not check), if made. |
| **Negative control** | In 1, 2a and 2b, `devos`'s `dryrun` and `apply` are skipped, with the reason in the report, and `devos`'s history lacks the version. |
| **Positive control** | P: in T-W03-05's run, both projects get the migration, in order, after the gate's class-high verdict. |
| **Break attempt** | `test_workflow_order.py` READS `.github/workflows/migrate.yml` and does not run it; this record says so, and the live runs above stay the observation of the order. It checks the order and stop as EV-C02-001 section 5 states them. It then makes copies of the build's own workflow in memory, each with one part removed, and each copy must fail, on the rule it removes (the test prints which problem the copy raised; a copy that fails only for another reason is BAD):<br>• `devos` without `needs: devos-test` (both at once);<br>• `apply` running after any decide result;<br>• `dryrun` without the decide gate;<br>• `GO` forced to `yes`;<br>• `apply` before `decide`;<br>• `compare` skipped after a failed apply;<br>• `dbtests` without the clean-comparison condition;<br>• `dbtests`' condition inverted (it runs on a comparison that is not clean);<br>• `dbtests`' runner without errors stopping the file (`ON_ERROR_STOP` removed);<br>• `dbtests`' runner not looking for the PASS notice;<br>• `go` ignoring `dbtests`;<br>• `devos` skipped when `devos-test` fails (its comparison and report would be lost);<br>• another job applying to `devos`;<br>• `devos` without its own comparison step (`compare`);<br>• `devos`'s comparison after `decide`;<br>• `decide`'s `DRIFT_RESULT` taken from `needs.devos-test.outputs` (it would decide `devos` on the other project's result: "skips a project");<br>• `decide`'s `FM_READS` taken from `needs.devos-test.outputs` (the first-migration exception would read the other project).<br>`--self-check` runs the same on a synthetic skeleton, which passes, with all seventeen copies red. When the runner is a class-high file that a one-line run names, the two runner copies change that file's text in memory. The deciding step's code itself is T-W03-DEC's. |
| **Stage and environment** | C02, after the workflow and the first migration merge.<br>• Live: GitHub's run record of `migrate.yml`; `devos` through the builder's read-only connection; `devos-test` through the job's own lines; the merge gate's output and the verdict file in git.<br>• The static test: anywhere with Python 3 and PyYAML.<br>• Probes relied on: P2 (a failed file leaves nothing; the missing-row behaviour); P11 (a per-project property); P1; P4 (queued runs). |
| **Independence level** | Written by the test designer. The fixtures and live observations are the build producer's. The static test is run by the build producer and again by the checker. Assessed by the fresh-context checker of point 13 from the raw records. Shared: model lineage, design record. |
| **Evidence layer** | Structural, observed live, with a static check of the workflow's text. The static check shows the conditions are written. Only the live runs show they act. |
| **Evidence envelope** | As in the README.<br>• `observations_ref`: per run, the run ID, job IDs, and each step's conclusion and start and end times; the merge gate's output lines and the verdict file's path and commit; the read-only queries with UTC times.<br>• For the static test: its full output and `migrate.yml`'s blob SHA. |

## Could not check

- 2b if not made.
- 1's "never `devos`" shown only by the run record, if P11 finds no property. The record says the stop rests on the run record.
- The static test before `migrate.yml` exists (it prints COULD NOT CHECK), or when a break cannot be applied to the build's workflow. The latter is "could not check" for that break, never a pass.

## Interface

`test_workflow_order.py` expects:
- jobs `devos-test` and `devos`, with environments `migrate-devos-test` and `migrate-devos`;
- step ids `apply`, `compare` and `dbtests` in `devos-test`, and its job output `go`;
- `dbtests`' `if:` written as `steps.compare.outputs.<name> == 'no_difference'` (either operand order), possibly with `!cancelled()` or `always()` and `&&`, never negated and never with `||`;
- `dbtests`' runner text, in its `run` body or in the class-high file that a one-line `run` names (`bash`, `sh` or `python3 [-I]` followed by the path, or the path alone): psql with `ON_ERROR_STOP` set true (`-v ON_ERROR_STOP=1`, `--set ON_ERROR_STOP=on` or the like, and never set false), and a check for the files' `PASS` notice outside comments. This shows the text is written, not that it acts; a runner that prints `PASS` without looking for it would pass here and is caught only in the job's log. If the build uses a client other than psql, the test designer revises this check before its first run;
- step ids `compare`, `decide`, `dryrun` and `apply` in `devos`, in that order, and `crosscheck` if O3 is adopted. `compare` is `devos`'s own comparison, section 5's step (5);
- `decide`'s `env`: `GO` from `needs.devos-test.outputs.go`; `DRIFT_CALL` and `DRIFT_RESULT` from `steps.compare.outputs.*` only (no other step, no `needs.*`); `FM_READS` from the outputs of steps of job `devos` before `decide` (no `needs.*`);
- the conditions written with `always()` or `!cancelled()`, and `steps.decide.outputs.apply == 'yes'`.

If the build uses other ids, the test designer revises the test before its first run.

## Depends on R1 to R6

- R1 and R2 (P13): P13 is settled. A failed first apply to `devos` leaves the history table empty and without the function. The executor decided on 2026-10-12 that the exception takes that state (T-W03-DEC "Depends on", E05 and E20), so the next run applies again on `go = yes`. A history table holding a row without the function still holds every later `devos` apply (T-W03-DEC E04). That is a stop, which this test would see as "not applied". Neither changes this test.
- R3 (O2): a change of `deployment_drift`'s interface could make `devos`'s comparison "could not check" and hold `devos`. That is a stop, not a test change.
- R4, R5 and R6 do not touch this test.
