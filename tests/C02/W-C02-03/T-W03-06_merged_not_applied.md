# T-W03-06 · A migration merged into `main` but not applied is detected, and the work it stops does not go on

**Synthetic test data** (plan Section 8 item 13):
- Part B's fixtures are made up inside a rolled-back transaction: versions `2999…`, names `w03_fixture_*`, slugs `w03-fixture-*`.
- Part A's live fixture migrations are synthetic and labelled (README, "Fixtures").

**Serves.**
- W-C02-03 point 6, quoted: "✘ A migration merged into `main` but not applied is made in at least two forms: the apply fails or is stopped after the merge; it reaches one project and not the other; and, if C02 deploys a function, a deployed version differs from `main`'s. In each form, `deployment_drift` run by the migration job and by the checks of the next pull request names the difference, and the work the design says it stops is observed not to go on. … Positive control: with everything applied, the result is "no difference" and the work goes on. Break: with the comparison's rule removed (it answers "no difference" without comparing, or skips a project or the function versions), the test of each form turns red."
- C02's Acceptance line "✘ A migration merged into `main` but not applied is detected by the comparison of 6.2 (PC-16)."
- The stop on other kinds of result in `devos` is T-W03-DEC's.

## Interface

`devos_api.deployment_drift(expected jsonb) returns jsonb`. The test assumes this; Appendix B places the function in `devos_api`, and EV-C02-004 Y-11 has the first migration create it.

- **The result** has:
  - `status`: `no_difference`, `differences` or `could_not_check`;
  - `complete`: a boolean, true only with `no_difference` or `differences`;
  - `differences`: a list, each item with a `kind` and with `version` (or `slug` for the function kinds); the kinds are `on_main_not_applied`, `applied_not_on_main`, `name_differs`, `function_missing`, `function_extra` and `function_differs`;
  - optionally `compared`, the counts.
- **`expected`** has the form `{commit, migrations: [{version, name}], functions: [{slug, sha256}]}` (M14).
- **`devos_private.function_deployment`** has columns `slug` and `source_sha256`. Other required columns are filled with synthetic values by type.
- If the build's names differ, the test designer revises the SQL before its first run.
- **The runner of `supabase/migrations/tests/`** (P10) runs each file as written: its `begin` and `rollback` are not stripped, and it is never committed. It runs with errors stopping the file (`psql -v ON_ERROR_STOP=1`, or a client that does the same). It counts a file as passed only when the file's own PASS notice (`W03_DRIFT_DETECTS PASS`, `W03_DRIFT_COULD_NOT_CHECK PASS`) appears. Without errors stopping the file, psql can end with exit code 0 after an error, and a file that never reached its verdict would look green. `test_workflow_order.py` checks the runner's text statically (T-W03-14): the `dbtests` step's run body, or the class-high file a one-line run names, must set psql's `ON_ERROR_STOP` true and must look for a `PASS` notice. That static check shows the text is written; only the job's log shows it acts. The SQL holds no psql meta-command, so a client that does not interpret them runs it unchanged (EV-C02-001 section 10, "`psql` and meta-commands").
- These SQL files gate the `devos` apply from the first push. They run in step (8), and step (8) is part of `go`. If the build's function does not match the interface above, they fail or give "could not check", and `devos` is held until the revision. That is the intended fail-closed behaviour, not a defect.
- **The run report** (EV-C02-001 section 5, "Every run writes a report") gives, per project, the comparison's result, its differences by kind and version, the versions recorded as applied, and the skip reason of the `devos` apply. EV-C02-001 section 12 item 2 leaves its form to the build. This test reads the report as the build fixes it.

## Part A · The live forms (no executable file; observed from runs)

Each form is planted by a synthetic fixture merged through the merge gate (class high, fresh-context verdict, after W-C02-19 is accepted). The fixtures are designed in EV-C02-001 section 10 (point 6 and point 14's observation); P2 was settled offline and P11 decided before they were written (T-W03-14, "P2, settled offline", and its fixture list).

| Form | Planted by | What must be observed (raw, each with its source) |
|---|---|---|
| (i) the apply fails or is stopped after the merge | T-W03-14's failing fixture `w03_fixture_fail` (H2), which fails in both projects (P11: no property tells them apart) | **The run record:**<br>• `devos-test`'s apply step failed;<br>• its comparison step ran and the report names the fixture's version `on_main_not_applied` in `devos-test`;<br>• `devos`'s comparison before its apply names it `on_main_not_applied` in `devos`;<br>• `devos`'s `dryrun` and `apply` were skipped, with the report's reason (`go` not `yes`);<br>• `devos-test`'s database tests did not run.<br>**The next pull request's check** (H3's, which removes H2's file) names the version `on_main_not_applied` for both projects in its state (its own run record).<br>**`devos`'s history**, read by the builder's read-only connection, lacks the version. |
| (ii) it reaches one project and not the other | T-W03-14's second example, `w03_fixture_name_differs` (H4): it applies in `devos-test`, where its comparison then gives a difference (`name_differs` for T-W03-05's version), and it does not reach `devos` | **The run record:**<br>• `devos-test`'s report names the planted difference (`name_differs` `20261012231841`) and lists H4's version applied;<br>• `go` is not `yes`;<br>• `devos`'s comparison names H4 `on_main_not_applied`;<br>• `devos` was not applied.<br>**The next pull request's check** (H5's) names the difference in `devos-test` and the unapplied version in `devos`.<br>**`devos`'s history**, read through the read-only connection, lacks H4's version; **`devos-test`'s report** shows it applied. |
| (iii) a deployed function differs from `main`'s | Only if C02 deploys a function (N-230) | Otherwise the record states "form (iii) not reached in C02", names the stage that adds the first Edge Function, and points to part B (S06 to S09), which shows the comparison of function versions in the database. |
| (iv) a stopped run, if one happens | a run of `migrate.yml` cancelled, failed before the apply, or a project paused | The same observations as (i) for whatever was left unapplied. Not planted. Recorded if it happens, otherwise "not observed". |

**What each form stops, observed not to go on** (M16, section 4):
- the `devos` apply (its steps skipped, with the report's reason);
- `devos-test`'s database tests (skipped after a comparison that is not clean);
- a pull request that changes a merged migration file not shown unapplied in both projects. One live example: a pull request that edits the text of T-W03-05's applied fixture (`supabase/migrations/20261012231841_w03_fixture_apply.sql`), made by the executor after H1's run. Its check is red, and it is closed unmerged, never merged. The other cases are T-W03-DEC's `pr_decide`;
- a result read from a project that relies on its holding `main`'s migrations, which is counted "could not check". Every read of the planted state itself records the comparison's result beside it, with its commit (M16).

**Positive control (live):**
- the run of T-W03-05 (everything applied: "no difference" in both projects; `devos` applied; database tests ran);
- a pull request that only adds a file, whose check passes and states the records' state;
- the run after each repair, which shows both projects back to "no difference".

**The pull-request checks' direct call.** If, through point 1 (c) and PC-41, the checks call `deployment_drift` through `devos_ci` only later, that part is shown at the first pull request whose checks run it. The record names the item (W-C02-12, or the item that stores the key). Until then the checks read the run report (M15). The `pr_decide` cases of T-W03-DEC cover that period.

**Repair.** Each form ends with the repair the design names: removing or fixing a fixture that failed everywhere (allowed by M16, since it is unapplied in both projects), or the restoring fixture of T-W03-14's second example. The run after the repair shows "no difference" in both projects. The record states what each fixture left in each project.

## Part B · `deployment_drift` names each kind of difference (`supabase/migrations/tests/w03_drift_detects.sql`)

The file runs inside one transaction that is rolled back. Only sequence values outlast the rollback: a planted row in a table with an identity or serial column (`devos_private.function_deployment`, if the build gives it one) advances that sequence, because a sequence's next value is never rolled back. No row, table, column or function is left changed (shown on PostgreSQL 16.15 with a scratch stub whose record has an identity column: its sequence went from unset to 2, and both records held the same rows before and after). Inside the transaction, it replaces the history's rows and the function record's rows with a synthetic fixture: two applied migrations and one deployed function. It then calls the function with planted `expected` sets:

- **S01** (everything recorded): `no_difference`, complete.
- **S02, S03**: one and two versions on `main`, not applied (forms (i) and (ii) as the database sees them).
- **S04**: applied and not on `main`.
- **S05**: name differs.
- **S06**: function differs (form (iii)).
- **S07**: function on `main`, not deployed.
- **S08**: function deployed, not on `main`.
- **S09**: a migration and a function at once.
- **S10** (no function on `main` and none recorded, C02's state): `no_difference`.

Each difference case must list exactly the planted differences. `no_difference` must come with `complete = true`, and `could_not_check` never with it.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-06. When a migration merged into `main` is not applied in a project, `deployment_drift`, run by the migration job and by the checks of the next pull request, names it. The work M16 stops does not go on until both projects are back to "no difference". |
| **Failure class rule** | A difference between `main` and a project's records is not named, or is named and the work goes on anyway. Examples of this family: the comparison answers "no difference" without comparing; it skips a project, the history or the function record; it names a different kind; the caller drops it; the stop ignores it. |
| **Examples** | Live: (i) apply failed or stopped; (ii) one project and not the other; (iii) a function differs, if reached, and otherwise part B's S06 to S09; (iv) a stopped run if one happens.<br>In the database: S02 to S09, five kinds and a mixture. |
| **Negative control** | Each example is named with its kind and its version or slug. In the live forms, the `devos` apply, the database tests and a change to an applied migration are observed not to go on. |
| **Positive control** | S01 and S10 give `no_difference`, so the function does not report differences that are not there. Live: T-W03-05's run gives "no difference" in both projects and the work goes on; a pull request that only adds a file passes. |
| **Break attempt** | All on a throwaway PostgreSQL built from `supabase/migrations/` by W-C02-07's break harness (plan Section 8 item 3; PC-42), connected as a login named `postgres`, with `w03.throwaway = 'yes'`. The patches in `breaks/` rename the build's own function and wrap it, so they hold none of its logic:<br>• **B1** answers "no difference" without comparing: S02 to S09 must turn red;<br>• **B2** skips the function versions: S06 to S09 must turn red, and so must C07 of T-W03-07;<br>• **B3** skips the history: S02 to S05 and S09 must turn red.<br>Without a patch, the same run must be green, which is the harness's positive control.<br>"Skips a project" is a break of the caller, not of the function. Each of these must turn red:<br>• a `pr_decide` copy that reads one project (T-W03-DEC, P08);<br>• in `test_workflow_order.py` (T-W03-14), a workflow copy whose `devos` job has no comparison step of its own (`compare`) before `decide`, a copy with that step after `decide`, a copy whose `decide` takes `DRIFT_RESULT` from `needs.devos-test.outputs` (the other project's result), and a copy whose `decide` takes `FM_READS` from there. The test checks that `decide`'s `DRIFT_CALL` and `DRIFT_RESULT` come from `steps.compare.outputs` in job `devos` and never from `needs.*`, and that its `FM_READS` comes from steps of job `devos` before it;<br>• D24 of T-W03-DEC: a call that was not made gives "could not check".<br>The static test shows the wiring is written. That `devos`'s comparison really reads `devos` is shown live, by the report's own `devos` comparison line in forms (i) and (ii).<br>The live forms are not repeated with broken code: that would mean merging a broken comparison into `main`. Their break is at these component levels, and the record says so.<br>The test designer's self-check on PostgreSQL 16.15 with a scratch stub (not delivered; the projects run 17.6) gave B1 8 bad and 12 bad, B2 4 bad and 1 bad, B3 5 bad, and the unpatched run PASS in both files. The SQL also caught a NULL-handling defect in the stub.<br>**Each patch stops itself when its guard refuses** (CHK-C02-017 C1). The guard's two checks and the patch (`execute` of the rename and of the replacement) are one `do` statement, so a refusal applies nothing, whatever the client does after an error. A second test designer re-ran this with another scratch stub on PostgreSQL 16.15, without `ON_ERROR_STOP`, and with `-1` plus `ON_ERROR_ROLLBACK=on`. For each of B1 to B4, with the setting unset, and with it set while a `supabase_admin` role existed: refused; no `deployment_drift_w03_orig`; the function's source unchanged; `deployment_drift(null)` still "could not check". With the setting set and no such role, each patch applied, and the same cases as above turned red. The earlier patches, run the same way, were applied after the refusal. |
| **Stage and environment** | C02.<br>• Part B in `devos-test`: by the job's test step (8), as `postgres`, after a clean comparison, on every push (EV-C02-001 M09, M25; how it runs is P10).<br>• Part B with breaks: on the throwaway database (W-C02-07's harness; N-244 (2): that database lacks Supabase's roles, so the harness supplies a `postgres` login and the history table's stand-in is made by the test when `w03.throwaway = 'yes'`).<br>• Part A: GitHub's run record of `migrate.yml` and `migration-checks.yml`; `devos` through the builder's read-only connection; `devos-test` through the job's own lines.<br>Probes relied on:<br>• P1 (the history table and its writer);<br>• P2 (a failed file leaves neither objects nor a row; a missing row below the latest holds the tool, a name that differs does not): settled offline before the fixtures were written (T-W03-14), and observed live by forms (i) and (ii);<br>• P10 (how the job runs the SQL);<br>• P11 (decided: no per-project property, so the failing fixture fails in both);<br>• P4 (queued runs) for (iv). |
| **Independence level** | Written by the test designer (fresh-context subagent, declared). Part B is run by the job (its own output) and was run by the build producer on the throwaway database. Part A: the executor merges each fixture's change, opens and closes the pull requests, reads the run records and job logs (saved unedited), and makes the `devos` reads through the read-only connection; a prober (fresh-context subagent, declared) analyses the saved records and logs. All are assessed by the fresh-context checker of point 13 from the raw outputs, not from the executor's or the prober's account. All share the model lineage and EV-C02-001. |
| **Evidence layer** | Structural: the database function's results and the CI's mechanism, observed live. Not semantic: whether a migration's effect is right is W-C02-07's and W-C02-08's concern. |
| **Evidence envelope** | As in the README. Specifics:<br>• `observations_ref`: per form, the run ID, job IDs, the steps' conclusions and times, the report lines, the next pull request's number and its check run, and the read-only query with its UTC time;<br>• part B: the job's log lines for the file, or the harness's output with the patch name;<br>• every read of a planted state records `deployment_drift`'s result beside it, with its commit. |

## Could not check

These are recorded as such, never as passed:
- a form not reached (form (iii) in C02; form (iv) if no stopped run happens);
- part B, when the function or a record is absent (the file then raises COULD NOT CHECK);
- the break run, when W-C02-07's throwaway harness is not ready;
- `devos-test`'s state, when the job's own read did not run.

## Depends on R1 to R6

- R1 and R2 (P13's timing and scope) do not touch this test.
- R3 (O2): a change of `expected`'s or the result's form changes part B's interface. The test designer revises the SQL before the change's first result, keeping the old form's cases until `devos` holds the new function.
- R4, R5 and R6 do not touch it.
