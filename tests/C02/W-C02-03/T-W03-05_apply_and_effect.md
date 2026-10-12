# T-W03-05 · A migration merged into `main` is applied to both projects, and its effect is seen

Synthetic test data (plan Section 8 item 13): the fixture migration `<UTC timestamp>_w03_fixture_apply.sql` is made up for this test. It carries the README's first-line label and creates only synthetic objects.

**Serves.** W-C02-03 point 5, and C02's Acceptance line "✔ A migration merged into `main` is applied by the CI job, and its effect is seen in the database." Point 5 is quoted in full in the item file. This test also serves EV-C02-001 section 10, "Point 5".

## The fixture

- **What it is.** One migration file at the top level of `supabase/migrations/`, merged through the merge gate with a fresh-context class-high verdict, after W-C02-19 is accepted. It may merge with, or after, the first migration (W-C02-08's, which creates `deployment_drift`). It cannot come before it: `deployment_drift` must exist to report "no difference" after the apply.
- **What it creates.** Objects whose definition can be read from the catalog and compared with the file: a schema `w03_fixture` with one table `w03_fixture.apply_check (id int primary key, note text not null default 'synthetic')` and one comment on that table. A second, differently named object (a view `w03_fixture.apply_check_view`) gives the second example below.
- **What it touches.** Nothing outside its schema. It does not call `issue_env_token` or `revoke_env_token` (M24).
- **Its end.** It stays on `main`. Migrations are append-only, and M16 blocks a change once it is applied. Its schema is accounted for in point 10's listing as made by this migration, and it is removed later by a forward migration if the executor decides to.

## What is observed (raw, each labelled with its source)

1. **GitHub's run record of the push run at the merge commit**
   - The `devos-test` job: steps apply, compare and database tests, each concluded success; the step times; the line "credential present: yes".
   - Then the `devos` job: decide gives `apply = yes`, then the dry run lists the fixture's version, then apply concludes success, then the comparison after the apply runs.
   - The `devos` job's apply starts after the `devos-test` job ends (also T-W03-14's positive control).
2. **In `devos-test`, by the job's own read after the apply** (labelled the job's own). The definition of `w03_fixture.apply_check` from `pg_catalog` (columns, types, the primary key, the default, the comment), the view's definition, and the row of `supabase_migrations.schema_migrations` with the fixture's version and name.
3. **In `devos`, by the builder's read-only connection** (EV-C00-002 item 8). The same queries, with their UTC time. That connection reaches `devos` only; it is never used as evidence for `devos-test`.
4. **`deployment_drift`'s result after each apply, from the run report.** "no difference", complete, at the merge commit, for each project.
5. **Each merge's versions appear as applied in a run's report.** If the merge's run ended "superseded", the head's run lists them.

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W03-05. A migration merged into `main` through the gate is applied by the CI job to `devos-test` and then to `devos`. In each project its objects exist with the file's definitions, its version and name are in the record of applied migrations, and `deployment_drift` reports "no difference" at that commit. |
| **Failure class rule** | A merged migration is reported applied but is not applied, or not exactly so. Examples of this family: the job reports success but an object is missing or differs from the file; the history row is missing or has another name; one project lacks it; the comparison after the apply is not "no difference"; the effect is read from a source that is not that project. |
| **Examples** | (a) The table's definition (columns, key, default, comment) in each project. (b) The view's definition in each project. (c) The history row in each project. (d) The comparison result after each apply. |
| **Negative control** | Each read compares the catalog's definition with the file's text, field by field; it is not a check that a name exists. Any difference, a missing row, or a comparison other than "no difference" fails the test. A read from the wrong project fails it too: the `devos` read must come from the read-only connection and the `devos-test` read from the job, each labelled with its source. |
| **Positive control** | The same queries in each project show an object known to exist there that the fixture did not make: `auth.users`, and after the first migration `devos_private.function_deployment`. This shows that the query reads that project's catalog and is not silent for another reason. |
| **Break attempt** | The test is sensitive to each example as follows.<br>• The definition comparison is run once against a planted variant of the expected definition (the default changed to `'w03_other'`), and must fail.<br>• The history read is run once with the fixture's version changed to `29990101000009`, and must find no row.<br>• The comparison part is T-W03-06's (B1 to B3).<br>• A copy of the workflow whose `devos` job lacks its apply step, or applies before `devos-test`, fails T-W03-14's static test.<br>The live run itself is not repeated with a broken workflow. |
| **Stage and environment** | C02, at the first push run that applies the fixture.<br>• Where: GitHub's run record; `devos-test` through the job's own read (the only reader that reaches it, M25); `devos` through the builder's read-only connection.<br>• Probes relied on: P1 (`db push --db-url` writes `supabase_migrations.schema_migrations`), P3 (pooler hosts), P4 (if a run is superseded), P12 (the tool's checksum) and P7 (if a scheduled run is used to re-read). |
| **Independence level** | Written by the test designer (fresh-context subagent, declared). The fixture is written by the build producer and judged by the class-high verdict. The observations are made by the build producer. They are assessed by the fresh-context checker of point 13 from the raw outputs, not from the producer's account. Shared: model lineage, design record. |
| **Evidence layer** | Structural, observed live on the platform: the CI's mechanism and the database catalog. The migration's meaning is not in scope. |
| **Evidence envelope** | As in the README.<br>• `target_commit`: the merge commit, equal to the run's `head_sha`.<br>• `observations_ref`: the run ID, the job IDs, each step's conclusion and start and end times, the job's own lines, the read-only queries with UTC times.<br>• The record states what the fixture left in each project. |

## Could not check

- A project not reached: `devos-test` if the job's read did not run, or `devos` if the connection fails. That project's part is "could not check", never "applied".
- A run that did not start.
- P1 failing before its fallback is chosen.

## Depends on R1 to R6

- R1 and R2 (P13) do not touch it.
- R6: if the fixture merges with the first migration, the `devos` job takes the first-migration exception in that run. Its report line ("taken", with the three reads) is recorded with this test's raw output. T-W03-DEC tests the decision itself.
- R3, R4 and R5 do not touch it.
