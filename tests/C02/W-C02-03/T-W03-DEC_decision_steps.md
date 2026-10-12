# T-W03-DEC · The deciding steps: the `devos` apply, the first-migration exception, the pull-request check

Synthetic test data (plan Section 8 item 13): every input is made up in `test_decision_steps.py`. The versions are `2999…`, the names `w03_fixture_*`, the hashes are repeated hex digits, and the commits are `a3…` and `b4…`. No credential is involved.

**Serves.**
- W-C02-03 point 6, its stop on a result of another kind in `devos`'s comparison before the apply, "shown by a test of the step that decides the apply, fed each kind of result, with a break" (EV-C02-001 section 10, point 6).
- The first-migration exception's test (EV-C02-001 section 5 and section 10 point 6; CHK-C02-011 C9 (iii)), as section 5 states it after its change on P13: an empty history table is taken too (the executor's decision of 2026-10-12; see "Depends on").
- Point 6's "the checks of the next pull request … name the difference".
- Point 7's "where it guards a merge or a write it blocks it", for the `devos` apply and for a pull request under M16.
- Point 14's stop, at the step that decides it.
- O3, the dry-run cross-check, only if the build adopts it.

## Interface the build must expose

This is fixed by this test. The design fixes the rules, not these names. If the build differs, the test designer revises the test before its first run (README, "Interfaces").

**1. Where the code lives, and that the test runs it.**
- Each deciding step is a step of a workflow on `main`, with a fixed `id`:
  - `decide` in job `devos` of `.github/workflows/migrate.yml`;
  - `crosscheck` in the same job, only if O3 is adopted, placed between `dryrun` and `apply`;
  - `pr_decide` in any job of `.github/workflows/migration-checks.yml`.
- Its code is one of two things:
  - (a) its own `run` body with `shell: python`, holding no `${{ }}` expression;
  - (b) a `run` of one line, `python3 [-I] <path>`, with `<path>` on a class-high path of `tools/merge_gate.py`.
- The test reads that code from the workflow and runs it. That is "the step's own decision code, the code the workflow runs" (EV-C02-001 section 10, point 6), not a copy of its logic.
- Form (a) keeps "what runs with the credential" within EV-C02-001 section 2's bound 2 as written (`migrate.yml` only). Form (b) under `tools/` adds a class-high file to that bound, and the design record should then name it.
- Running `shell: python` with GitHub's `python {0}` is GitHub's documented step-shell behaviour as recalled here. It was not read in this task; the build confirms it from the workflow-syntax page with its date.

**2. Inputs reach the step only through its `env:` mapping.** The step holds no secret: no `secrets.` in its `env` (M21). The test checks this.
- **`decide`:**
  - `GO`: the value is an expression on `needs.devos-test.outputs.go`.
  - `FM_READS`: JSON with these fields:
    - `complete` (bool);
    - `snapshot`: `"one_statement"` or `"repeatable_read_transaction"`, the two forms CHK-C02-013 R6 allows;
    - `function_exists` (bool);
    - `history_table_exists` (bool);
    - `history_rows` (int or null): the history table's row count, read in the same snapshot. When `history_table_exists` is true, a null or missing `history_rows` is a partial read (E22, E23). When it is false, every case gives null; a build may give 0 there;
    - `listing`: a list of the objects outside Supabase's own, as `"<class> <name>"`.

    These are the three reads, taken in every run before the call.
  - `DRIFT_CALL`: `ok`, `error`, `timeout` or `not_called`.
  - `DRIFT_RESULT`: the raw text `deployment_drift` returned. The test assumes this form (T-W03-06, "Interface"):
    - `status`: one of `no_difference`, `differences`, `could_not_check`;
    - `complete` (bool);
    - `differences`: a list, each item with a `kind` and with `version` (or `slug` for the function kinds); the kinds are `on_main_not_applied`, `applied_not_on_main`, `name_differs`, `function_missing`, `function_extra` and `function_differs`.
  - `EXPECTED`: M14's `expected`, `{commit, migrations: [{version, name}], functions: [{slug, sha256}]}`.
- **`crosscheck`:** `PENDING` and `DRY_RUN`, each a JSON list of versions.
- **`pr_decide`:**
  - `CHANGED`: a JSON list of `{path, status: A|M|D|R, old_path?}`;
  - `RUN_REPORT`: the parsed report of the latest completed `migrate.yml` run, or empty when there is none or it cannot be read. Its form is `{commit, completed, projects: {"devos-test": {result, applied_versions, differences}, "devos": {...}}}`;
  - `MAIN_HEAD`: the head commit of `main`.

**3. Outputs go to `$GITHUB_OUTPUT`.**
- **`decide`:**
  - `apply`: `yes` or `no`;
  - `result_kind`: `no_difference`, `differences` or `could_not_check`, the three outcomes counted apart;
  - `exception`: `taken` or `not_taken`;
  - `reason`: one line;
  - optionally `pending`, a JSON list.
- The step's stdout carries the report line (EV-C02-001 section 5: "taken" with the three reads' results, or "not taken" with the state that kept it from being taken; as changed after P13, the "taken" line names which of the two table states it saw). The test checks it in this form:
  - `first-migration exception: taken`, and on the same line the three reads' results, each written `<field>=<value>` or `"<field>": <value>` (case-insensitive), with the same field names as the "not taken" check reads. They name the table state it saw:
    - no table (E01 to E03): `function_exists=false`, `history_table_exists=false`, `listing=[]`;
    - an empty table (E05, E20, E21): `function_exists=false`, `history_table_exists=true`, `history_rows=0`, `listing=[]`.

    A line without its state's fields fails those cases. So does a line that gives the other state's table values, for example `history_table_exists=false` for E05.
  - `first-migration exception: not taken`, and on the same line the name of the input or read field that shows the state that kept it from being taken (case-insensitive). With the function present (every D case), any of `function_exists`, `history_table_exists` or `listing`. E04: `history_table_exists` or `history_rows`. E06, E06b and E07: `function_exists` or `history_table_exists`. E08, E09, E17 and E24: `listing`. E10: `complete`. E11 and E12: `snapshot`. E13 and E14: `FM_READS`. E15: `function_exists`. E16: `history_table_exists`. E18: `DRIFT_CALL` or `DRIFT_RESULT`. E19: `EXPECTED`. E22 and E23: `history_rows`.
  - The "not taken" check reads the field's name, not its value. So a line that names every field passes it; a line naming a state that is not the case (for example `function_exists` for E08) fails. The "taken" check reads names and values, and a line that gives both table states' values passes it; that is not a case. A scratch reference written from section 5 passed every `decide` case. Two of its mutants were red: one printing the bare line (44 of 44 `decide` cases) and one always naming `function_exists` (E04, E05, E08 to E14 and E16 to E19). For the change after P13 (2026-10-12) a new scratch reference, written from the executor's wording, passed every case (72 of 72, 49 of them `decide`), and the same two mutants were red on 49 of 49 `decide` cases and on E04, E08 to E14, E16 to E19 and E22 to E24. A third, whose "taken" line always gives `history_table_exists=false`, was red on E05, E20 and E21.
- **`crosscheck`:** `apply` and `reason`.
- **`pr_decide`:**
  - `verdict`: `pass` or `fail`;
  - `state`: one line that names each project's result and its differences' versions.

**4. Wiring.** The test checks these on the workflow when it exists:
- `decide`'s `GO` comes from `needs.devos-test.outputs.go`;
- the step's `env` names every input;
- the step's `env` names no secret.

Where `decide`'s inputs come from is checked by `test_workflow_order.py` (T-W03-14): `DRIFT_CALL` and `DRIFT_RESULT` from job `devos`'s own comparison step `compare` before `decide`, never from `needs.*`, and `FM_READS` from steps of job `devos` before `decide`. So are the `dryrun` and `apply` steps' `if:` conditions.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-DEC. The code the workflows run decides the `devos` apply, and a pull request's check, as M07, M16 and section 5's first-migration exception state. `devos` is applied only when `devos-test`'s `go` is `yes` and either (a) `deployment_drift` in `devos` gave a complete, well-formed result listing only migrations "on `main`, not applied", or (b) the three reads, complete and in one snapshot, show the function absent, the history table absent or present and holding no row, and nothing in the listing outside Supabase's own (the never-pushed state, or the empty table a failed first apply leaves, P13). A pull request that changes, removes or renames a merged migration file is red unless the run report shows that version unapplied in both projects. Everything else is "skip" or "pass", with the reason or the state written. |
| **Failure class rule** | A deciding step lets work go on that its input does not license. Examples of this family: it applies on a result that is not "pending only", on a result it could not read, or without `devos-test`'s `go`. It takes the first-migration exception in any state but those two (no table or an empty one, with the function absent and a clean listing, in one snapshot), for example a history table that holds a row or whose row count it did not read. It passes a change to a merged migration that the records do not show unapplied in both projects. It reports a state other than the one it acted on. |
| **Examples** | (`decide`, function present)<br>• D06 applies on "applied and not on `main`" (the design's named break).<br>• D07 to D11: name differs; each function kind; a mix.<br>• D12: an unknown kind.<br>• D13 to D24 apply on "could not check" or on unusable input: an error, a timeout, an empty or malformed result, no completeness flag or a false one, an inconsistent status, a missing status, no call made.<br>• D02 to D04: `go` not `yes`.<br><br>(first-migration exception)<br>• E04: the history table holding a row without the function.<br>• E06 and E06b: the function without the table.<br>• E08 and E09: an object in the listing. E24: an object in the listing beside an empty table.<br>• E09 to E17: a failed or partial read. Each of these shows it: incomplete, not one snapshot, an unknown snapshot form, the reads absent, not JSON, one read missing, the listing failed.<br>• E22 and E23: the history table present and its row count not read (null, or the field missing), a partial read.<br>• E18: the reads and the call contradict each other.<br>• E19: `expected` malformed.<br><br>(`pr_decide`)<br>• P04 and P05: a changed migration applied in both, or in one.<br>• P07 to P10, P15, P16: a changed migration under "could not check": no report, a report lacking `devos`, a report at another commit, a run not completed, a report not JSON, one project "could not check".<br>• P11 and P12: deleted, renamed. |
| **Negative control** | Every example above must give `apply = no` (`decide`) or `verdict = fail` (`pr_decide`), with the expected `result_kind` and the expected `exception`, and with the report line. Cases whose input is unusable must give `result_kind = could_not_check`, counted apart from `no_difference` and `differences`. |
| **Positive control** | `decide`:<br>• D01: pending only with `go = yes` gives `apply = yes`.<br>• D05: no difference gives `apply = no` with `result_kind = no_difference`. The design says "no difference" leaves nothing to apply.<br>• E01 and E02: the never-pushed state gives `apply = yes` with `exception = taken`, in each of R6's two forms (one statement, and a read-only REPEATABLE READ transaction).<br>• E03: the same state with `go = no` gives `exception = taken` and `apply = no`.<br>• E05 and E20: the empty history table (function absent, table present with no row, clean listing, one snapshot) gives `apply = yes` with `exception = taken`, in each of R6's two forms, and the report line names the empty table (`history_table_exists=true`, `history_rows=0`). E05 expected "could not check" until the change after P13 (see "Depends on").<br>• E21: the same state with `go = no` gives `exception = taken` and `apply = no`.<br><br>`pr_decide`:<br>• P01 to P03: only adding migrations passes, whatever the records say, and the state names "could not check" (P02) or the difference (P03).<br>• P06: changing a file shown unapplied in both passes. That is the forward repair of a migration that failed everywhere.<br>• P13: a change to a database test is not a migration change.<br>• P14: an unrelated change passes and names the difference. |
| **Break attempt** | Two parts.<br>(i) The runner makes copies of the build's own step code, each with one rule removed, and runs `test_decision_steps.py --impl decide=<copy>` (or `pr_decide=`, `crosscheck=`) on each. Each copy must give FAIL on the named case.<br>The required copies:<br>• applies on "applied and not on `main`" (D06);<br>• takes the exception without the table check (E04);<br>• takes a history table that holds a row without the function, the row check removed (E04; E22 and E23 as well where the copy no longer reads the row count at all). A copy that removes only the "row count read" check (it treats a null or missing count as empty) turns E22 and E23 red;<br>• takes the exception beside an empty table without the listing check (E24), where the code checks the listing apart for that state;<br>• without the function check (E06b; E06 as well where no other guard refuses a call made while the reads say "no function");<br>• without the listing check (E08);<br>• ignores `go` (D02);<br>• treats a missing completeness flag as complete (D19);<br>• a `pr_decide` that passes on "could not check" (P07 to P10, P15);<br>• a `pr_decide` that reads one project only (P08).<br>Each copy's diff against the step's code is kept with the result. A copy counts as a break only if it removes the rule wherever the code enforces it. If the code enforces a rule twice, both places are removed, and the record says so.<br>Under `--impl` the final line reads `W03_DECISION_TEST (break-copy run) …` and names the files run instead of the workflow's code, so a break-copy run's line is never filed as the build's result (CHK-C02-017 Rf1). Only a run without `--impl` gives `W03_DECISION_TEST PASS`.<br>(ii) `--self-check` shows, before the build, that wrong-by-construction programs turn the test red, with the final line naming the break-copy run: always apply, never apply, crash, a `pr_decide` that always passes or always fails, and a `crosscheck` that always says yes. It also shows that a repository without the workflow gives COULD NOT CHECK. The test designer also ran four targeted mutants of a scratch reference that is not delivered. The results are in this test's report: each was red on its own case, and the reference passed every case.<br>For the change after P13 (2026-10-12) the test designer wrote a new scratch reference from the executor's wording (not delivered). It passed 72 of 72. Its targeted mutants gave: the old rule (any history table refused) red on E05 and E20 to E24; taking a table that holds a row (row check removed) red on E04, E22 and E23; a null or missing row count taken as empty red on E22 and E23; the listing check skipped beside a table red on E24; the "taken" line always giving `history_table_exists=false` red on E05, E20 and E21. |
| **Stage and environment** | C02, at the build's head, before the workflow's class-high verdict (point 13). Run anywhere with Python 3 and PyYAML, with no credential and no network: the builder's sandbox, the checker's sandbox, and the pull-request checks. The decision is pure. Its inputs come from the steps that hold the credential, and those steps are observed live in T-W03-06, T-W03-07 and T-W03-14. Probes relied on: none for the decision itself. For its inputs: P1 and P2 (what the history records), P13 (E05 and E20 to E24: what a failed first apply leaves; settled by the builder from the pinned tool's source, as the C02 ledger records), and R6's form (`snapshot`). |
| **Independence level** | Written by the test designer (fresh-context subagent of the working session, declared; Ek A 5.3). Run by the build producer, and again by the fresh-context checker of point 13. The checker makes, or at least reviews, the break copies' diffs. All share the model lineage and the design record. The checker did not write the step's code. |
| **Evidence layer** | Structural, a check of the deciding code's behaviour on planted input. It does not show that the live steps feed it true inputs. That is T-W03-06, T-W03-07 and T-W03-14. It also does not show that the read step's three reads are really one snapshot. That is part D below. |
| **Evidence envelope** | As in the README. Specifics:<br>• `inputs_ref`: this file's case IDs at `criterion_version`;<br>• `observations_ref`: the harness's full output;<br>• `deployment_config_ref`: `migrate.yml`'s and `migration-checks.yml`'s blob SHAs;<br>• for the breaks, the diff of each copy. |

## Part D · The read step's one snapshot (R6)

This part is a specification only. It needs the build's read SQL.

CHK-C02-013 R6 lets the build either confirm that one statement gives one snapshot, or take the three reads in one read-only REPEATABLE READ transaction. `decide` accepts both forms (E01, E02). Whichever form the build takes, it shows the following:

- **The query.** The three reads are plain `select`s on `pg_proc`, `pg_namespace`, `pg_class` and `pg_roles` (or views on them), and, when the history table is present, its row count from the table itself, taken in that one statement or transaction. Name lookups such as `to_regclass` and `to_regprocedure` read through the system caches. Those may see the latest committed catalog state rather than the statement's or the transaction's snapshot. This is an inference from PostgreSQL's catalog-snapshot behaviour. It was not read in this task, and the build reads it or shows it by the probe below. OBS query 2 (EV-C02-001's example) uses `to_regclass`.
- **Probe, on a throwaway database.**
  1. Session A opens the read in the build's form.
  2. Session B then creates a function named `deployment_drift` in a schema `devos_api`, and the table `supabase_migrations.schema_migrations` with one row, and commits.
  3. Session A finishes its reads.
  4. The three reads, the row count included, must agree with the state at A's snapshot: none of B's objects, or else all of them (the function, the table and its row).

  A form that reports the function from after B and the table from before B fails. The result, with the PostgreSQL version, is the build's record. The projects run 17.6 (`devos` observed; `devos-test` not observed), so the probe's database is of that major version.
- **Could not check.** If the probe cannot be run, the read step's snapshot claim is "could not check", and the exception rests on the reads' agreement in the live run only. The record says so.

## Depends on, and what may change it

- **R6** (one snapshot): either form is accepted by the cases. Part D is what tests the form.
- **P13 and the widening of the exception** (an empty history table without the function). **Changed on 2026-10-12, before that change's first result:**
  - Until then E05 expected "could not check", as the design stood, and this item said what would change if a change to EV-C02-001 widened the exception after P13.
  - Why it changed. P13 is settled: the builder read the pinned command-line tool's source, and the C02 ledger records it (W-C02-03's build entry). The tool creates the history table in its own transaction before the first migration file, and a dry run does not create it. So a first file that fails leaves the history table empty and without the function. EV-C02-001 section 5's residual then asks for a change to that record, deciding whether the exception also takes a table that holds no version. The executor decided that it does. The record's change, written after this test is merged, is to say:

    > When `deployment_drift` does not exist in `devos`, the exception is taken only if all three reads complete in one read-only snapshot and show: the function absent; the history table absent, or present and holding no row; and nothing in the listing outside Supabase's own. Every other state is "could not check" and skips the apply: the history table holding a row without the function; the function present without the table; an object in the listing; a failed or partial read (any of the three failing, cut or incomplete, or not taken in one snapshot). The report line for "taken" names which of the two table states it saw.
  - What changed here, to that wording:
    - E05 is now a positive control (`taken`, `apply = yes`).
    - E20 is the same state in R6's other form, and E21 is that state with `go = no`.
    - E22 and E23 are the table present with its row count not read, a partial read.
    - E24 is an object in the listing beside an empty table.
    - The "taken" report line names the table state it saw (Interface item 3).
    - The break list has the copy that takes a table holding a row (E04 red; E22 and E23 too where the row count is no longer read).
    - Part D's probe counts the row.
    - No other case's expectation changed.
  - The test follows the executor's wording, not the record's text: the record's change comes after this test. If the merged change says anything else, the test designer revises this test before that change's first result.
  - The listing counts `supabase_migrations` as Supabase's own, so E05 and E20 feed a clean listing. T-W03-10's exclusion list already counts it.
- **R3 (O2's interface rule)**: a change of `deployment_drift`'s result form or of `expected`'s form changes the inputs here. The cases then get the old and the new form side by side until `devos` holds the new function.
- **O3**: the `crosscheck` cases (X01 to X07) run only if a step `crosscheck` exists. If O3 is not adopted, the output says "not applicable", which is neither pass nor fail.
- **R1, R2, R4, R5**: none touches this test.

## What it does not cover, and why

- Whether the live `devos` job feeds `decide` true inputs, and whether its skip is observed in the run record. That is T-W03-06 and T-W03-14.
- `deployment_drift`'s own answers. That is T-W03-06 and T-W03-07, part B.
- The pull-request check's direct call through `devos_ci`. That comes later (M15) and needs new cases then.
- Function states that a later change treats as pending (M12). Until that change, D08 to D10 expect a skip. The change that first deploys a function revises them.
- A read that says the history table is absent yet gives a row count above 0. The wording of the change after P13 does not say whether that is a partial read or an absent table, so no case expects either. If the build's read can produce it, the executor decides, and the test designer adds the case.
- Whether an empty history table in `devos` really comes from a failed first apply. `decide` sees the three reads only. A table emptied out of band, with the function and DevOS's objects gone, takes the exception too, and the run report shows it ("taken", with the empty table). A later "taken" is investigated under EV-C02-001 section 4, "Repair paths". That section names the removed table only, and the record's change brings it in line.
