# T-W07-5A · No application role can read or write the tables directly; the same change through devos_api succeeds

Synthetic test data (plan Section 8 item 13): the direct attempts carry no data of their own (`DEFAULT VALUES`, or a column set to itself), and each is undone. The positive control relates two work items made up inside the rolled-back transaction, with one synthetic `devos_calisma` token. Part B's HTTP probes name tables and read no rows.

**Serves.** The negative cases serve W-C02-08 points 4 and 6. The positive control (5A-pos) serves W-C02-09 point 8, as W-C02-08 point 4 says ("The positive control ... runs with W-C02-09"). Plan C02 Acceptance: "✘ No role can write directly to the tables". W-C02-07 point 5 (a). Appendix B principle 1: "Writing directly to the tables in the `devos_private` schema is closed to all application roles (access rules + revoking privileges)".
**Command.** Part A, in `devos-test`: the migration job's test step runs `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_5a_no_direct_writes.sql` as `postgres`, and passes only on the notice `W07_5A_NO_DIRECT_WRITES PASS`. Statement timeout 300 s. Part B: the job's runner, inside its `devos-test` step, runs `python3 -I supabase/migrations/tests/w07_5a_exposed_schema.py` with `endpoint`, `publishable_key` and `tokens.devos_calisma` (never printed). It exits 0, 1 or 3, an interface on W-C02-03's job (the executor's decision 3). Break: `python3 -I tests/C02/W-C02-07/harness/run_breaks.py --patch tests/C02/W-C02-07/breaks/B-5A-1_anon_inserts_event.sql --pg-bin <PostgreSQL 17 bin>`.
**Time added to W-C02-13's run.** None.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds.
- The tables: every `devos_private` table, read from the catalogue at run time.
- The roles: `anon` and `authenticated` (the publishable key's), `authenticator` (the Data API's login, which the key reaches), and every role named for a role class that exists (`devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum`, `devos_ci`, `devos_backup`, `devos_ingest`). With the token design (EV-C02-003 §1.1), role classes are values, not database roles, so normally only the first three exist.
- Reads granted by name: none. EV-C02-003 grants none: every read goes through a `devos_api` function (§4.1; searched for "SELECT", "granted by name" and "direct read", with no hit). A grant added later is listed in the file's `w07_granted_reads()` with its reason.
- The positive control: `devos_api.relate`, as T-W07-REL states it.

## Cases
- **5A-w:<role>:<table>**: INSERT (`DEFAULT VALUES`), UPDATE (a column set to itself), DELETE and TRUNCATE are each refused for lack of privilege (SQLSTATE 42501), each tried as the role in a subtransaction that is then undone. Any other outcome is `bad`: a success, or another error, which means the privilege check passed.
- **5A-r:<role>:<table>**: a direct SELECT is refused (42501), unless the table is in the granted-reads list.
- **5A-snap**: row counts and content hashes of every table are unchanged across all attempts (W-C02-08 point 4). The hashes are compared, never printed, and `env_tokens` is counted only.
- **5A-cat-api**: no table, view, materialized view, sequence or foreign table in `devos_api`, so no updatable view reaches a private table.
- **5A-cat-priv**: no privilege for PUBLIC or an application role on the `devos_private` schema, its relations or their columns.
- **5A-cat-default**: no default privilege, global or in `devos_private`, that would give PUBLIC or an application role a privilege on a table or sequence a later migration adds.
- **5A-cat-grantees**: no grantee on a `devos_private` relation other than its owner, `postgres`, `service_role` or `supabase_admin`.
- **5A-cat-exposed-db**: where the Data API's exposed schemas are stored in the database (`pgrst.db_schemas`), `devos_private` is not among them.
- **5A-B-exposed:<table>** (part B, where that setting is not readable in the database): `GET /rest/v1/<table>` with `Accept-Profile: devos_private` is refused with PostgREST's `PGRST106` (schema not exposed). **5A-B-pos**: `devos_api` is exposed, and `token_role_class` answers the working token.
- **5A-pos** (positive control): `devos_api.relate`, as `anon` with the working token, adds one relation row. A direct INSERT of the same kind of row (5A-w:anon:relation) is refused; the two differ in the path only.
- **5A-roles** records the roles tried and those outside the line. **5A-pre** is `could_not_check` when `devos_private`, its tables, `anon` or `authenticated` is absent.

**Outside the line, with the reason** (W-C02-08 "Not covered" (e); W-C02-07 point 5 (a)):
- The migration credential's role (`postgres`, plan 6.2) and the project owner: their writes are held by other conditions. The migration credential is readable only by runs on `main` (W-C02-03), and every migration is a reviewed high-impact change.
- `service_role` and Supabase's own roles: held by 6.3 and K-9 item 3 (the secret key is in no agent environment).

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | T-W07-5A. No database role that a publishable key, an environment token or a job credential reaches can insert, update, delete, truncate or select a `devos_private` table directly, now or for a table a later migration adds. The catalogue grants nothing that would allow it. The same change through its `devos_api` function succeeds. |
| **Failure class rule** | **[Designer's addition: R2 section 5 (b) row, no Appendix C entry]** A way around the single write path: a table privilege, a column privilege, schema usage, a default privilege, an updatable view or a sequence in `devos_api`, an exposed private schema. |
| **Examples** | **[Designer's addition]** The original, the Acceptance line's own case: `anon` writing a table (5A-w:anon:*). Other manifestations: the other roles (5A-w:authenticated:*, 5A-w:authenticator:*), direct reads (5A-r:*), and the catalogue's routes (5A-cat-*, 5A-B-exposed:*). |
| **Negative control** | Every 5A-w and 5A-r case refused with 42501; 5A-snap unchanged; the catalogue cases empty. |
| **Positive control** | 5A-pos and 5A-B-pos. |
| **Break attempt** | **B-5A-1** (`breaks/B-5A-1_anon_inserts_event.sql`) removes one revocation: `anon` gets USAGE on `devos_private`, INSERT on `devos_private.event` and USAGE on that table's sequences. Must turn red: **5A-w:anon:event, 5A-cat-grantees, 5A-cat-priv**. |
| **Stage and environment** | C02. Part A: `devos-test`, the migration job's test step, as `postgres` with `set local role` (README 5.1 (a)). Part B: `devos-test`'s Data API (`data-api-synthetic`). The break runs on the throwaway database. In `devos`, the same rule is shown only through `deployment_drift`'s comparison (W-C02-08 "Not covered" (d)). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group B; agent ID in W-C02-07's "Record", point 1). Run by the migration job, by W-C02-08's producer (negatives) and W-C02-09's (5A-pos) at their heads, and by W-C02-13's prober with the break. Assessed by a fresh-context checker that wrote none of the tests, from the raw output. Shared: model lineage, the design records and Appendices B and C. |
| **Evidence layer** | Structural (privileges and the catalogue) and, in part B, the Data API's behaviour. It does not show that row-level security policies, if any, are right (the test requires privilege refusals, not policies), nor anything about superuser roles. |
| **Evidence envelope** | README 4's fields. Values fixed before the run: the role list rule, the five operations, the expected SQLSTATE 42501, the empty granted-reads list, `PGRST106`, and the break's red cases. The tables are read at run time and listed by the run's case IDs. |

## Could not check
- Part A gives COULD NOT CHECK when `devos_private` has no table or `anon`/`authenticated` is absent (5A-pre). A role that `postgres` cannot act as gives `could_not_check` for its cases. Before the build exists the test gives COULD NOT CHECK.
- Part B gives exit 3 without its variables, or when the Data API cannot be reached.

## Self-check (not a result; README 10)
2026-10-12, through the harness on PostgreSQL 16.15 in the session's container (not the projects' 17, so every line says counts: no), run as an unprivileged user in a user namespace. (1) With no migrations, the file gives COULD NOT CHECK and the break is could not check. (2) With a scratch stub of the interface above (outside the repository, not delivered), the unpatched run passes; B-5A-1 turns red exactly 5A-w:anon:event, 5A-cat-grantees, 5A-cat-priv, with the file ending in FAIL; the restore passes. Part B's program, run without its variables, ends COULD NOT CHECK with exit 3. The stub is the test designer's reading of the design, not the build: a pass on it is no evidence about the build. Three faults in the test's own helpers were found and fixed this way before any result existed: the planter on a table whose columns all have defaults, the reading of a ref list, and the refusal test on a result without an ok key.

## Not covered
- The superuser roles and the migration role (above).
- Supabase Storage and Realtime: they never set `request.headers` (EV-C02-003 §15); their access to `devos_private` is the same privileges as here.
- `devos`: part A runs in `devos-test` only.
