---
id: EV-C02-007
item: W-C02-03
kind: build
title: "The migration path's build: the migration workflow, the pull-request checks, the deciding steps, the first migration and the listing of point 10 (W-C02-03, points 5 to 14)"
date: 2026-10-12
main_at: 9537194
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (same session; declared, Ek A 5.3)"
sources:
  - "evidence/C02/EV-C02-001_migration_path.md (every section; M01 to M32, O1 to O3, sections 4, 5, 6, 10, 12), plan/decisions/PC-41.md, evidence/C02/EV-C02-004_reconciliation_decisions.md (Y-01 to Y-12), EV-C02-002 section 13 A2, EV-C02-003 sections 1.6, 5.3 and 6.3, at main 4da5ef2"
  - "tests/C02/W-C02-03/ (README, the eight specifications, test_decision_steps.py, test_workflow_order.py, breaks/B1 to B4) and supabase/migrations/tests/w03_*.sql, at main 4da5ef2; evidence/C02/checks/CHK-C02-017.md and CHK-C02-020.md"
  - "Pins, read 2026-10-12 18:35Z to 18:49Z through the agent proxy: `git ls-remote https://github.com/actions/checkout` and a fetch of tag v6.1.0; https://registry.npmjs.org/supabase (dist-tags.latest 2.120.0, published 2026-10-06T16:40:30Z); https://github.com/supabase/cli/releases/download/v2.120.0/checksums.txt and .../supabase_linux_amd64.tar.gz (the GitHub release page and API were refused by the proxy, 403)"
  - "P13: the Supabase command-line tool's own source at tag v2.120.0 (commit 753520fa7202ed5f8b25883a4c0aa7e5e9ad1fc4, a shallow clone of https://github.com/supabase/cli read 2026-10-12 about 18:40Z), files apps/cli/src/command-internal/db-push-core.ts, migration-apply.ts, migration-history.ts and apps/cli/src/commands/db/push/push.command.ts; read as data, not run"
  - "Local runs on a throwaway PostgreSQL 16.15 cluster (port 54403, scratch directory outside the clone, stopped and deleted after), 2026-10-12 18:46Z to 19:05Z"
  - "Revision of 2026-10-12 (section 9), at the branch head ffe6111 (main 11feac5 merged in), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): tests/C02/W-C02-03/T-W03-DEC_decision_steps.md and test_decision_steps.py as changed after P13 (PR #296); plan/work/C02.md notes N-255 (with 'The key's source, decided', L-295) and N-257, and 'Batu's steps' row 1a; EV-C02-003 sections 1.1, 4.1 and 6.3; local runs on a second throwaway PostgreSQL 16.15 cluster (port 54417, data directory under the postgres user's home, outside the clone, stopped and deleted after)"
  - "Revision of 2026-10-12 (section 10), at the branch head 762640d (main 9537194, PR #298, merged in), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): the four checker lenses' results at 762640d (acceptance, security, mechanical, changes since the earlier verdicts); local runs on a third throwaway PostgreSQL 16.15 cluster (port 54461, data directory under the postgres user's home, outside the clone, stopped and deleted after)"
claim: "A build, checked offline only. The offline tests pass at this build. Nothing ran against devos or devos-test, and no workflow ran on GitHub: every behaviour of GitHub, of the pooler and of the projects is still documented, inferred or read in source, until the first runs after Batu's step 1. Section 6 lists what stays live-only."
---

# EV-C02-007 · The migration path's build (W-C02-03)

**What this is.** The build of the accepted design `evidence/C02/EV-C02-001_migration_path.md` (with PC-41), made so that it passes W-C02-03's offline tests now and can pass the live tests after its merge. **Labels:** [obs] observed here, with the output named; [doc] documented and not independently tested; [src] read in the pinned tool's source; [inf] inference; [cnc] could not check; [choice] a choice the design left to the build. Nothing here was run against `devos` or `devos-test`.

## 1. Files, and what each meets

| File | Class | What it meets |
|---|---|---|
| `.github/workflows/migrate.yml` | high | EV-C02-001 section 5's shape: on `push` to `main` and on a 6-hourly `schedule` only (M04); jobs `devos-test` (environment `migrate-devos-test`) then `devos` (environment `migrate-devos`, `needs: devos-test`, runs in every case), each with steps (1) to (8) of section 5; scheduled jobs `check-devos-test` and `check-devos` (head, presence, connect, comparison, point 9's search); the head check (M05); concurrency (M06); the stop (M07, M16); the working directory (M08, Y-09); the database tests and the test programs (M09, M25, Y-05); the first-migration exception's three reads in one snapshot (section 5; R6; CHK-C02-017 F7 item 2); the listing of point 10 with its printed exclusion list; the report lines (section 5, "Every run writes a report"; M15); pins (M20, P12); the secret only in the `env` of the steps that connect, its percent-encoded form masked (M21); no shell tracing, no tool debug output |
| `.github/workflows/migration-checks.yml` | high | The pull-request checks: M22's static check (`workflow_check`), the inputs of M15 (`pr_inputs`), M16's rule (`pr_decide`), and W-C02-03's two offline tests (`w03_tests`, the environment T-W03-DEC names). No secret, no environment |
| `supabase/migrations/20261012184638_deployment_drift.sql` | high | Y-11: `devos_private` and `devos_api` if absent; `devos_private.function_deployment`, created empty (M12); `devos_api.deployment_drift(jsonb) returns jsonb` with its three outcomes, completeness flag and counts (B:387 as PC-41 words it); "could not check" for missing, malformed, unreadable or partial input (plan Section 8 item 14); the `session_user = postgres` branch before the token check a later migration adds (M13; PC-41 place 8), every other caller refused until then (EV-C02-001 section 10, "Two further points"); EXECUTE removed from `PUBLIC` and from Supabase's API roles where they exist. Nothing of W-C02-08's schema, no grant to a DevOS role class, no `issue_env_token` or `revoke_env_token` (M24). A real UTC timestamp version (CHK-C02-017 F7 item 4) |
| `evidence/C02/EV-C02-007_migration_path_build.md` | normal | This record |
| `evidence/C02/EV-C02-001_migration_path.md` (line 220; and, in the revision of section 9, the first-migration exception after P13) | normal | Its example of one snapshot cited OBS query 2, whose `to_regclass` reads the latest committed catalog, not the statement's snapshot; the line now says so, labelled "corrected after CHK-C02-017 F7 item 2". The revision (section 9.1) changes the exception wherever the record states it, each place dated, with a dated line in its section 15 |

No file under `tools/` was added: both deciding steps are form (a) (section 3). The step bodies that several jobs share (the head check, the pooler step, presence, connect, the working directory, the comparison, the listing, the dry run, the apply, the report, the search) were written once and inserted byte-identical in each job by a generator kept outside the repository; a reader checks the identity by comparing the step bodies of the same id across jobs.

## 2. The interfaces the tests impose, and how they are met

| Interface (source) | How the build meets it |
|---|---|
| `decide` in job `devos` of `migrate.yml`; `pr_decide` in `migration-checks.yml` (T-W03-DEC item 1) | Both are steps with those ids |
| Form (a) or (b) (T-W03-DEC item 1) | Form (a): `shell: python` bodies with no `${{ }}`; their inputs come only through `env` |
| `decide`'s env: `GO` from `needs.devos-test.outputs.go`, `FM_READS`, `DRIFT_CALL`, `DRIFT_RESULT`, `EXPECTED`; no secret (T-W03-DEC item 2) | As stated; `FM_READS`, `DRIFT_CALL` and `DRIFT_RESULT` come from `steps.compare.outputs.*` of job `devos`, `EXPECTED` from `steps.workdir.outputs.expected`; no `secrets.` in its env |
| `FM_READS`'s fields `complete`, `snapshot`, `function_exists`, `history_table_exists`, `history_rows`, `listing` (T-W03-DEC item 2) | Written by `compare` from one read-only REPEATABLE READ transaction; `snapshot` is `repeatable_read_transaction`; `history_rows` is the count read from the table itself in that transaction when the table exists, null otherwise, and counts only if the table counted is the one the snapshot saw (revised, section 9.1) |
| Outputs `apply`, `result_kind`, `exception`, `reason`, optional `pending` (T-W03-DEC item 3) | As stated, to `$GITHUB_OUTPUT` |
| The report line: "first-migration exception: taken" with the three reads' results naming the table state it saw (`function_exists=false`, `history_table_exists=false`, `listing=[]`; or `function_exists=false`, `history_table_exists=true`, `history_rows=0`, `listing=[]`); "not taken" naming the field that kept it from being taken (T-W03-DEC item 3, as changed after P13; CHK-C02-020 R3) | Each line names the field that decided it (`FM_READS`, `function_exists`, `history_table_exists`/`history_rows`, `listing`, `complete`, `snapshot`, `EXPECTED`, `DRIFT_CALL`); the "taken" line also says "table state: …" in words (revised, section 9.1) |
| `pr_decide`'s env `CHANGED`, `RUN_REPORT`, `MAIN_HEAD`; outputs `verdict`, `state` (T-W03-DEC items 2, 3) | As stated; `state` writes "could not check" in words |
| `devos-test` steps `apply`, `compare`, `dbtests` in that order; `compare` runs after a failed apply; `dbtests`' `if` is `steps.compare.outputs.result == 'no_difference'` alone; output `go` depends on all three (T-W03-14 lines 50 to 56) | As stated; `compare`'s `if` holds `!cancelled()`; `go`'s step reads the apply's outcome, the comparison's result, the tests' outcome, the test programs' outcome and the tokens' revocation |
| `dbtests`' runner: psql with `ON_ERROR_STOP=1`, a check for the files' `PASS` notice (T-W03-14 line 53; T-W03-06 "Interface") | `psql -X -v ON_ERROR_STOP=1 -f <file>`; a file passes only on exit 0 and a `NOTICE: <NAME> PASS (` line. Files run as written (their `begin` and `rollback` kept) |
| `devos` steps `compare`, `decide`, `dryrun`, `apply` in that order; `dryrun` and `apply` gated on `steps.decide.outputs.apply == 'yes'` (T-W03-14) | As stated, each gate also `&& steps.head.outputs.head == 'yes'` (no `||`) |
| `deployment_drift(expected jsonb) returns jsonb`; `status`, `complete`, `differences` with `kind` and `version` or `slug`; `function_deployment` with `slug` and `source_sha256` (T-W03-06 "Interface") | As stated; the result also carries `commit` and `compared` (the four counts), and for "could not check" a `reason` |
| The comparison step takes its connection parts from its `env` (T-W03-07 c2) | `compare` uses libpq's `PGHOST`, `PGPORT`, `PGUSER`, `PGDATABASE`, `PGSSLMODE`, `PGPASSWORD` and `W03_TIMEOUT` from its env; nothing is hard-coded in its body |
| The listing's exclusion list kept as data in the workflow and printed with the output (T-W03-10) | Workflow-level `W03_EXCLUDED_SCHEMAS`, `W03_SCHEMA_ENTRY_ONLY`, `W03_EXCLUDED_ROLES`, printed by step (4) |
| No psql meta-command in a test file (T-W03-06; EV-C02-001 section 10) | `dbtests` refuses, before running it, any file that holds a backslash; every psql meta-command begins with one |

**CHK-C02-020 R1's laundering route: closed in the workflow.** `devos`'s `compare` reads `devos` itself, over its own connection in its own job, and neither it nor any step that `decide`'s `FM_READS`, `DRIFT_CALL` or `DRIFT_RESULT` names takes a `needs.` value in its `env` or `run`; the only `needs.` value in job `devos` is `decide`'s `GO`. `test_workflow_order.py` does not check this text (R1), so it rests on this workflow and on the live report's own `devos` comparison line.

## 3. The choices the design left to the build

| Choice | Made | Reason |
|---|---|---|
| Step ids | `head`, `checkout`, `cli`, `workdir`, `pooler`, `presence`, `connect`, `listing`, `dryrun`, `apply`, `compare`, `dbtests`, `tokens`, `dbprograms`, `tokens_revoke`, `go`, `report`; in `devos` also `decide` and `compare_after`; scheduled jobs add `search` | The tests' interface fixes `compare`, `decide`, `dryrun`, `apply`, `dbtests`, `go`; the rest name section 5's steps |
| Interface form | (a) for `decide` and `pr_decide` | Keeps EV-C02-001 section 2's bound 2 as written (`migrate.yml` and the files copied from `supabase/migrations/`); a file under `tools/` would add a class-high file to that bound and to point 9's layers (T-W03-DEC item 1; CHK-C02-017 F7 item 6) |
| The snapshot form (R6) | Both: the three reads are one statement of plain `select`s on `pg_proc`, `pg_namespace`, `pg_class`, `pg_depend`, `pg_extension` and `pg_roles`, inside one read-only REPEATABLE READ transaction that also reads the history and calls `deployment_drift`. No `to_regclass` or `to_regprocedure` decides anything. `deployment_drift` itself is `STABLE`, so its two record reads share the calling statement's snapshot | CHK-C02-017 F7 item 2 (name lookups read the latest catalog) and item 7 (a VOLATILE function takes a new snapshot per query). The listing prints a function's arguments through `pg_get_function_identity_arguments`, a cache read used for its display only, never for what is listed |
| The schema exclusion list (point 10; CHK-C02-017 F7 item 3) | Excluded with their contents, as Supabase's own: `auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations` (OBS query 2's schemas, plus the history table's schema, which T-W03-10 names). Excluded as an entry only: `public`, "there before C02", the default schema every project is created with, so before the first migration the listing is empty (T-W03-10); its tables, views and functions are still listed. Roles: OBS query 2's list, plus every `pg_*` role. Objects that belong to an extension (a `pg_depend` row of type `e`) are listed as `extension <name>`, not dropped | T-W03-10; a listing that names `public` would keep the first-migration exception from being taken in a project where `public` is empty |
| O3's cross-check | Not adopted: no `crosscheck` step | The test designer gave no reason to adopt it, and the stop already rests on `deployment_drift`'s own list; `test_decision_steps.py` then reports `crosscheck` as "not applicable". If adopted later, it is a class-high change with its cases X01 to X07 already written |
| The run report's form and where the checks read it (section 12 item 2) | Each job prints one line `W03REPORT {json}` (project, event, run, commit, head, presence, connection, listing count, result, differences, applied versions, and for `devos` the decision, its reason and the exception; for `devos-test` its `go`) in its log and its summary. `pr_inputs` reads the latest completed run of `migrate.yml` at `main`'s head through the REST API with its own token (`actions: read`): the run list, the run's jobs, each job's log; only lines of that fixed form are parsed | No artifact action is added (M20: `actions/checkout` is the only action) |
| `expected` and `supabase/functions/` | `expected.functions` is `[]`; if `supabase/functions/` exists at all, `expected` is left empty, so every comparison gives "could not check" until the change that adds the first Edge Function (N-230) adds its part | The task's and Y-09's "nothing under `supabase/` but `migrations/`"; failing closed keeps a function on `main` from reading as "no difference" |
| A top-level file in `supabase/migrations/` that is not `<version>_<name>.sql`, or a symbolic link | `expected` is left empty ("could not check") | The tool skips such files [src: `MIGRATE_FILE_PATTERN`], so `main` and the record would disagree silently |
| The pooler host (P3) | Each job's `POOLER_HOST` is empty. The `pooler` step, which holds no credential, then tries the shared pooler hosts of every AWS region (`aws-0-` and `aws-1-<region>.pooler.supabase.com`) with the user `postgres.<ref>` and no password, takes the host that asks for a password rather than answering "Tenant or user not found", prints it, and stops the job before any step receives the secret | The design records the host in the workflow (M19: "found at the build … and records it in the workflow"); the build has no route to either project. So recording it is one class-high change after the first run. Which error text each pooler gives is [inf], observed at that run |
| Concurrency | `group: migrate`, `cancel-in-progress: false`, `queue: max`, at workflow level | M06 as written; P4 tests it |
| Schedule | `41 */6 * * *` | M04 and M17's 6 hours; a minute off the hour |
| The command-line tool's configuration | Written by the workflow: `project_id`, `[db.migrations] enabled = true`, `[db.seed] enabled = false`. The tool runs `db push --db-url <url> [--dry-run] --yes` with `--workdir` on the built directory; no `--include-all`, `--include-seed` or `--include-roles`; telemetry off (`DO_NOT_TRACK`, `SUPABASE_TELEMETRY_DISABLED` [src]) | M08, Y-09. The flags are read in the pinned source [src: push.command.ts]; that they work against a hosted project is P1 |
| The test programs (`supabase/migrations/tests/*.py`; the executor's decision, EV-C02-003 section 6.3) | **Replaced on 2026-10-12 by N-255's interface: section 9.2; the build's first form follows, as it was.** Three steps after `dbtests`: `tokens` (holds the credential) issues one synthetic token per DevOS role class with `devos_private.issue_env_token(role_class)` (B:46's signature), masks each, and writes them to a 0600 file under the runner's temporary directory; `dbprograms` (no credential in its env) runs each program with `env -i`, giving it only `PATH`, `HOME`, `LANG`, `DEVOS_DATA_API_URL` (`https://<ref>.supabase.co`) and `DEVOS_TEST_TOKENS_FILE`, and maps its exit code (0 pass, 1 fail, 3 could not check); `tokens_revoke` (always) revokes each with `devos_private.revoke_env_token(<token>)` and deletes the file. With no program, each says "none" and passes. `go` needs all three | The tokens never appear in a step's `env`, a log or a record; the programs never hold the database password. Two parts are not settled: section 7 |
| The search of point 9 | In each scheduled job, a `shell: python` step holding that job's own value and its own token (`contents: read`, `issues: read`, `actions: read`): a mirror clone of `devos` (every branch, tag and pull-request ref), counted separately in the objects of the current trees and in every other object (history); issue #6's title, body and comments, and a fixture issue if `W03_FIXTURE_ISSUE` names one, read with the same code; the logs of the 100 latest earlier runs of `migrate.yml`. It prints counts per place and per form (plain, percent-encoded) and fails the job if the credential is found. The plant of the positive control is decoded from `W03_PLANT_B64`, empty now | T-W03-09; the plant and its tag are made at planting time, so setting them is a class-high change then, made by whoever plants |
| The comparison's client-side timeout | `timeout 120` around psql (`W03_TIMEOUT` overrides it); exit 124 gives `call = timeout` | Section 4's caller rule; T-W03-07 c2 |
| `function_deployment`'s columns | `slug` (key), `version`, `ezbr_sha256`, `source_sha256`, `commit_sha`, `run_id`, `deployed_at` | M12's list; one row per deployed function |

## 4. Pins (M20, P12)

- **The command-line tool:** Supabase CLI v2.120.0 (npm `latest`, published 2026-10-06T16:40:30Z), asset `supabase_linux_amd64.tar.gz` from `https://github.com/supabase/cli/releases/download/v2.120.0/`. Its published SHA-256 in the release's `checksums.txt` (entry `supabase_2.120.0_linux_amd64.tar.gz`) is `7074584113aa00495beeac661c41fb09f1ddd0a483cd7333894b0d080086dc6e`, and the downloaded asset's own SHA-256 is the same [obs, 2026-10-12 18:3xZ]. The workflow downloads the asset by that URL and stops on a mismatch before any step receives the credential. (Corrected 2026-10-12, section 10.8: on a mismatch the tool is not extracted and no step that runs it runs; `compare` still runs and holds the credential.) The tarball holds `supabase` (an x86-64 executable, 112 MB) and `supabase-go`; in v2.120.0, `db push` is implemented in TypeScript (`apps/cli`) [src]. Neither binary was run here.
- **`actions/checkout`:** tag v6.1.0 is commit `d23441a48e516b6c34aea4fa41551a30e30af803` of `actions/checkout` itself (a lightweight tag in that repository's refs; its `action.yml` runs on `node24`) [obs: `git ls-remote` and a fetch of the tag, 2026-10-12T18:49Z]. Both workflows use it with `persist-credentials: false`.
- **Not pinned by DevOS:** the runner image's `psql`, `git`, `python3`, `curl`, `timeout` (EV-C02-001 M20's residual); `migration-checks.yml` and the M22 step rely on the image's PyYAML and fail closed without it.

## 5. The probes

| Probe | State at this build |
|---|---|
| P12 | Settled: the checksum and the checkout commit, section 4 |
| P13 | **Settled by reading the pinned source, and its result triggers the design's own rule.** [src v2.120.0] `applyMigrations` calls `createMigrationTable` once, before the first file, as its own `BEGIN … COMMIT` (migration-history.ts lines 101 to 114; migration-apply.ts lines 649 to 670), and only when something is pending; each file then runs in its own batch. A dry run never calls it: `db push --dry-run` lists the remote history, which reads a missing table as empty (`isUndefinedTableError`), prints "Would push these migrations" and returns (db-push-core.ts lines 210 to 220). So the dry run does not create the table, but a first file that fails after it leaves the table, empty, without the function. EV-C02-001 section 5's residual says that in this case "before the first migration merges a change to this record … decides whether the exception also takes a table that holds no version". That change is the executor's (section 7). The build follows the record as it stands: E05 (an empty table without the function) is "could not check". **Acted on 2026-10-12:** the executor decided that the exception takes the empty table; the test changed first (PR #296), then EV-C02-001 and `decide` (section 9.1) |
| R6 / T-W03-DEC part D | Observed on PostgreSQL 16.15 [obs]: session A opened a read-only REPEATABLE READ transaction and took its snapshot; session B then created `devos_api.deployment_drift(jsonb)` and `supabase_migrations.schema_migrations` and committed; A's reads statement, the text taken from `migrate.yml` (job `devos`, step `compare`), gave `function_exists false, history_table_exists false, listing []`, while `to_regclass` in the same transaction already saw B's table. The same statement after both sessions saw all four objects. The projects run 17.6 (`devos` observed; `devos-test` not); this probe ran on 16. **2026-10-12, section 10.2:** on 17, could not check; observed on 16.15 only, as support |
| P1, P2, P3, P4, P6, P7, P9, P10, P11 | Settled by the first runs (point 5's push run; point 14's fixtures; two queued runs; point 8's re-runs; the first scheduled run; 8 days of schedule; W-C02-08's first test run; the fixture design). P10 is in part already a build fact: the job runs the SQL tests as `postgres` with psql, files run as written |
| P5 | When `devos_api` is exposed (M26) |
| P8 | A reading through the GitHub API or by Batu (EV-C02-001 section 10) |

## 6. Acceptance points 5 to 14: what the build does, and what stays live-only

| Point | The build | Live only |
|---|---|---|
| 5 ✔ apply | The push run applies to `devos-test`, compares, tests, then `devos` compares, decides, applies, compares again; each step prints its result | The first push run after Batu's step 1 and after the pooler hosts are recorded; point 5's fixture, its reads in each project (`devos-test`'s read: a database-test file that comes with the fixture, section 10.3) |
| 6 ✘ merged, not applied | `deployment_drift` names the five kinds (S01 to S10 pass; B1 to B3 red, section 8); `decide` and `pr_decide` stop on them (T-W03-DEC) | Forms (i) and (ii) by point 14's fixtures; the next pull request's check; form (iii) is not reached in C02 |
| 7 ✘ could not check | The function (C01 to C13 pass; B4 red), the caller (`compare`'s call states; D13 to D24, E09 to E17) and the guarded work (`apply = no`; `verdict = fail`). The client-side timeout gave `call = timeout` against a test copy that sleeps [obs] | c1 and c3 from runs |
| 8 ✘ other branch | Only `migrate.yml` names the environments, on `push` to `main` and `schedule`; M22 refuses anything else; the head check ends a run at a commit that is not `main`'s head before the secret | The branch runs (a) to (f) |
| 9 ✘ session reads it | The search step, with counts only; its positive control needs the plants | The search, the plants, the break copies |
| 10 ✔ probe schema absent | The listing step in each push job, with its printed exclusion list and the control without it (`auth.users` present: yes or no) | The listings of both projects, before the first apply; `devos` also by the builder's read-only connection; T-W03-10's planted (d) and (e) and its widened-list break (section 10.8) |
| 11 | Nothing here | N-099 T-65's line on `plan/work/C09.md`, with the live evidence |
| 12 | Tests merged before this build (CHK-C02-017, CHK-C02-020); the job prints names, versions, counts and statuses only (**limited 2026-10-12, section 10.8:** the report line does; other lines print outputs verbatim) | Each result's envelope and raw output |
| 13 | Class high: the two workflows and the migration need a fresh-context verdict at the head that adds them | That verdict, and the item's |
| 14 order | `test_workflow_order.py` PASS with its 17 copies red (it reads the workflow) | The failing fixture, the second example, the positive control's step times |

## 7. Open, for the executor

1. **P13's result triggers EV-C02-001 section 5's rule** before the first migration merges: decide, by a change to that record judged as any change to it, whether the first-migration exception also takes a history table that holds no version (function absent, listing clean, one snapshot). If it does, T-W03-DEC's E05 and its added cases change first (T-W03-DEC, "Depends on"), then `decide`. **Done 2026-10-12** (section 9.1).
2. **The pooler hosts (P3) are not in the workflow.** The first push run finds them without the credential and stops; a class-high change records them, and the next run connects. This adds one class-high merge before the first apply. The alternative, using the host found in the same run, departs from M19's "records it in the workflow" and was not taken.
3. **The test programs' publishable key.** A Data API call needs the project's publishable key in the `apikey` header (EV-C02-003 section 1.1). The job does not hold it, and a key is never written in the repository. So a program that calls the Data API gets no key and can only report "could not check" until the executor decides where it comes from (for example a second secret in `migrate-devos-test`, a step of Batu's). **Decided** (N-255, "The key's source, decided", L-295): the environment secret `DEVOS_TEST_PUBLISHABLE_KEY` of `migrate-devos-test`, stored by Batu in sitting A ("Batu's steps" row 1a); the runner passes it as `apikey` (section 9.2).
4. **`revoke_env_token`'s argument is assumed** to be the token. W-C02-09 fixes the signature; if it differs, `tokens_revoke` fails, `go` is not `yes`, and the step is changed with W-C02-09. The token functions were run only against stubs here [obs].
5. **The first migration and the workflow.** The workflow merges only after Batu's step 1 (M29); the first migration only after W-C02-19 is accepted (the item's text). Either can come first. With the workflow alone on `main`, a push run applies nothing, `devos-test`'s comparison is "could not check" (no function), `go` is not `yes`, and `devos`'s exception reads find nothing to apply. With the migration on `main` first and no workflow, nothing applies it.
6. **Y-09's test** (EV-C02-001 section 10) still has no C0 test of its own (README, "What this directory does not cover"); the job prints what it needs: the working directory's file list before and after the tool, and the dry-run list.
7. **`test_workflow_order.py` and CHK-C02-020 R1:** the closure in section 2 is in the workflow's text, not checked by a test.

## 8. Outputs of the checks run for this build

At the build commit `eddab74`, as they were; the outputs at the revision are in section 9.4.

- `python3 -I tests/C02/W-C02-03/test_decision_steps.py`: `W03_DECISION_TEST PASS (62/62)`, exit 0 (`crosscheck` "n/a"). `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`.
- `python3 -I tests/C02/W-C02-03/test_workflow_order.py`: `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, every one of the 17 copies red on its own rule. `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`.
- PostgreSQL 16.15, the migration applied with `ON_ERROR_STOP`; both SQL tests with `w03.throwaway = 'yes'`: `W03_DRIFT_DETECTS PASS (10/10)`, `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`. Break patches, each on a fresh database built from the migration, no `supabase_admin` role: B1 red S02 to S09 and C02 to C13; B2 red S06 to S09 and C07; B3 red S02 to S05 and S09 (the other file 13/13); B4 red C02 to C13 (the other file 10/10). These are exactly the cases T-W03-06 and T-W03-07 name.
- The workflow's own step bodies, read from `migrate.yml` and run against that database: never-pushed state, the reads `function_exists=false history_table_exists=false listing=[]` and `decide` "taken", `apply=yes`, `pending=["20261012184638"]`; the function without the history table, "could not check" (42P01); with a history row, "no difference" and `apply=no`; a pending version, `apply=yes`, `pending` that version; `expected` empty, `call=error`; a sleeping copy with a 3-second timeout, `call=timeout`; the listing and its control; the database-test runner, both files passed; with a synthetic program and stub token functions, seven tokens issued, the program saw the endpoint and seven tokens and no `PGPASSWORD`, seven revoked.
- M22's check on the build's workflows: pass; on seven wrong copies (a `workflow_dispatch` event, a tag pin, an apply step or a psql apply in a scheduled job, a workflow call, a push path filter, a second workflow naming `migrate-devos`): each fails.

## 9. Revision after P13 and N-255 (2026-10-12)

Made at the branch head `ffe6111` (`main` `11feac5` merged in) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only, like the rest of this record. Files changed: `.github/workflows/migrate.yml`, `evidence/C02/EV-C02-001_migration_path.md` and this record. No test was changed. The workflow was edited in place, not regenerated: the generator section 1 names is kept outside the repository and was not available to this revision. Each edit to a repeated body was made in every copy at once, and section 9.4 shows the copies identical.

### 9.1 P13: the first-migration exception takes an empty history table

**The decision.** The executor's, with the test changed first (T-W03-DEC, "Depends on"; PR #296, `11feac5`): when `deployment_drift` does not exist in `devos`, the exception is taken only if the three reads complete in one read-only snapshot and show the function absent; the history table absent, or present and holding no row; and nothing in the listing outside Supabase's own. Every other state is "could not check". The executor added one rule the test lists as not covered: a read whose fields disagree (the table absent with a row count given) is "could not check". EV-C02-001 is changed at every place that stated the old rule (M07, M16, the caller rule, "Repair paths", section 5, point 6, P13's row), each marked with the date and the reason. A dated line in its section 15 records how this narrows CHK-C02-011's C9 (iii), and why it stays within plan line 631, Section 8 item 14 and section 4's rule.

**`decide` (job `devos`, one copy).**
- *Its reads check.* `history_rows` must be present: a missing field is a missing read. It must be null or a count (an integer, not a boolean, not negative). With `history_table_exists` true, a null count is a partial read. With it false, any count, 0 included, is a disagreeing read. Each of these gives "could not check", and the line names `history_rows`.
- *Without the function:* a table holding a row is "not taken" (`history_table_exists=true, history_rows=N`). Then an object in the listing is "not taken" (`listing`). Then `EXPECTED` is checked. Otherwise the exception is taken.
- *The "taken" line* gives `function_exists=false`, then `history_table_exists=false` or `history_table_exists=true, history_rows=0`, then `listing=[]`, the snapshot form and `complete=true`, and says "table state: …" in words. The `reason` output names the same state.
- *The choice on a 0* [choice]. A 0 given for an absent table counts as "given", the executor's word. T-W03-DEC's interface allows a build to give 0 there, but this build's comparison gives null, so the stricter rule refuses nothing the build produces.

**`compare` (five identical copies: `devos-test`, `devos`, `compare_after`, `check-devos-test`, `check-devos`).** The count was already read from the table itself, inside the same read-only REPEATABLE READ transaction. Added [choice]:
- The first statement also reads the table's oid from `pg_class`, in the snapshot.
- The count statement compares it with `'supabase_migrations.schema_migrations'::regclass`. PostgreSQL resolves that cast after the statement's FROM clause has locked the relation [inf: from the parse order, not read here; probe D3 shows the effect].
- The count counts only if the two oids are equal. Otherwise, or if the count is missing, the reads are not complete and `history_rows` is null.
- Reason: the count statement finds the table by name in the latest catalog (CHK-C02-017 F7 item 2). So a table dropped and re-created between the two statements would be counted in place of the snapshot's table. Probe D3 (section 9.4) shows the build's previous body reading that state as "present, 0 rows, complete", which the widened rule takes. The new body gives "not complete".

**Residual [obs, probe D4].** `TRUNCATE` is not MVCC-safe. A table holding a row that is truncated between the reads statement and the count is counted as 0 in the snapshot, so the exception can be taken. That is the state after the truncation, and a read made after it gives the same answer. It is the out-of-band "emptied" case that EV-C02-001's "Repair paths" already sends to the executor.

### 9.2 The test programs' interface (N-255)

| N-255 (and the task's wording) | How the runner meets it |
|---|---|
| Programs `supabase/migrations/tests/*.py`, in name order, after the SQL database tests, in `devos-test` only | Step `dbprograms` of job `devos-test`, after `dbtests` and `tokens`, if both succeeded. It runs `sorted(glob("supabase/migrations/tests/*.py"))`, so the order is by code point, independent of the locale. No other job has the step |
| Before them, as owner, the synthetic tokens the run needs, one per role class the tests use, and one more revoked for the "revoked token" | Step `tokens` (it holds the migration credential, `postgres`). It calls `devos_private.issue_env_token(role_class)` for each class in `W03_TOKEN_CLASSES`. That list is now the six columns of EV-C02-003 section 4.1: `devos_kurulum devos_calisma devos_denetim devos_sinav devos_ci devos_backup`. The build's `devos_ingest` is dropped, since that class arrives in C04 and has no column there, and its row is tried from C04 (section 4.1, "Tests, in every direction"). The step then issues one more token of the first class and revokes it with `revoke_env_token` before any program runs. The step fails if any issue or that revocation fails, and the programs then do not run |
| After them, in every case, every token issued is revoked; no token is printed | Step `tokens_revoke`, `if: always()` (formerly only when `tokens` had run). It revokes every class token, and the revoked token again only if its first revocation did not succeed, then deletes the file. `tokens` rewrites its 0600 file (under the runner's temporary directory) after every issue, so a failure or a cancellation part-way leaves every recorded token there to revoke. Each token is masked (`::add-mask::`) before anything else is printed, and no line prints one. `go` now needs `tokens_revoke` = `success` (it was "not failure") |
| One JSON object on standard input: `{"endpoint", "apikey", "tokens": {class: token}, "revoked_token"}` | As stated, the same object for every program; nothing else is passed in arguments or files |
| `apikey`: the publishable key from `DEVOS_TEST_PUBLISHABLE_KEY` of `migrate-devos-test`, masked like a secret; `null` if not set | The step's `env` takes `secrets.DEVOS_TEST_PUBLISHABLE_KEY`, so GitHub masks it as a secret value [doc, as M21 relies on; not re-read here]. The step prints only "set" or "not set (null)". An empty value gives `null` |
| The endpoint without the management API: derived from what the job holds | From the job's connection settings: `PGUSER` is `postgres.<project ref>` (EV-C02-001 M19, the pooler's user form). If it matches `postgres.` followed by 20 lower-case letters (the form of both projects' refs), the endpoint is `https://<project ref>.supabase.co`, the project's URL (EV-C02-003, "Names this design fixes", gives that host for each project). The Data API's paths (`/rest/v1/…`) are below it. Otherwise it is `null`, and a program that needs it reports "could not check". This keeps the build's first value (`DEVOS_DATA_API_URL`) |
| A program runs with an empty environment and only what it needs; with `# w07-needs-database: yes` among its first ten lines it also gets the step's connection settings in libpq's variables, never on its command line | Each program's environment is built from nothing (the effect of `env -i`): `PATH=/usr/bin:/bin`, `HOME` (a new empty directory for each program) and `LANG=C.UTF-8`. A program whose first ten lines hold that exact line (whitespace stripped) also gets `PGHOST`, `PGPORT`, `PGUSER`, `PGDATABASE`, `PGPASSWORD` and `PGSSLMODE`, the last so that it connects with `require`, as the step does. The environment is handed to the process directly, not as `NAME=VALUE` arguments of the `env` command, so the password is in no process's arguments. Since a program may need it, `dbprograms` now holds the migration credential in its own `env`; the build's first form kept it out of that step |
| Exit 0 pass, 1 fail, 3 could not check, anything else fail; one report line per program with its name and result only | `test program <file name>: pass`, `fail` or `could not check`. A timeout (`timeout 600`, exit 124) or a program that cannot start counts as fail. The step succeeds only if every program passed, so "could not check" also keeps `go` from `yes`. The programs' own output goes to the log, where the masks apply. That they print no token, key or header is their own rule (N-255 (2)), reviewed with them as class-high files |

**Why the default is no database access.**
- The step holds `devos-test`'s migration credential, which is owner-level. A program that only calls the Data API needs none of it.
- Without the credential in its environment, such a program cannot reach the database directly, so a Data API test cannot quietly pass by a path that bypasses the identity chain it is meant to test.
- The program also cannot use the credential, or print it from its own environment, by mistake.
- A program that does need the database says so in a line of its own text. That file is class high, so the need is reviewed with the program.

**Limits.**
- The programs run as the same operating-system user as the step. A program written to find the password could read it from its parent's environment through `/proc` [inf; observed by the security lens, section 10.8]. The default therefore guards against accident, not against a hostile program; the boundary against that is the class-high review of every file under `supabase/migrations/tests/`.
- A token whose `issue_env_token` call committed, in a step cancelled before the file was rewritten (one call's window), is not in the file and is not revoked [inf].
- `always()` running after a cancellation is GitHub's documented behaviour, which the build already relied on [doc, not re-read here].

### 9.3 N-257: manual starts, the branch rule, and a session's own branch workflow

- **Manual starts: none.** [obs: the two files at this head] `migrate.yml` starts only on `push` to `main` and on `schedule`. `migration-checks.yml` starts only on `pull_request` to `main`. No workflow in the repository lists `workflow_dispatch`, `repository_dispatch` or `workflow_call`, so neither accepts a manual start on any ref. Re-runs cannot be turned off: a re-run keeps its run's commit and ref, and M05's head check ends a run whose commit is not `main`'s head before any step receives the secret (EV-C02-001 section 3).
- **The migration credential is bound to `main` by each environment's deployment-branch rule.** Each environment, `migrate-devos-test` and `migrate-devos`, is set to "Selected branches and tags" = `main` only, with the administrators' bypass off (EV-C02-001 M03 and section 3). These are Batu's step 1 as asked (EV-C02-001 section 9, steps 7 and 31 and their bypass steps). The rule is matched against the run's `GITHUB_REF` [doc R6b 1], and an environment's secrets reach only jobs admitted to it [doc R5 G2]. That the rule refuses other refs is observed only at point 8. `migrate.yml` merges only after Batu has made the step (M29).
- **A session's own branch workflow.** A session can push a branch carrying its own workflow file. Whether its GitHub credential may push workflow files is P8; the guard allows GitHub writes on `devos` (N-257). That run's `GITHUB_REF` is the branch: a push, a `workflow_dispatch` the branch's copy lists, or a re-run of such a run. For a pull request it is `refs/pull/N/merge`. Neither is `main`, so the rule refuses the job either environment, and with it either environment's secret [doc R6b 1, R5 G3; observed at point 8].
- **What M22 does and does not do.** M22 runs in the pull-request checks and refuses any workflow that names the environments with an event other than `push` to `main` or `schedule`, any workflow other than `migrate.yml` that names them, and any `push` filter other than `main` [obs, section 9.4]. It does not stop a branch run, which needs no pull request, and it is not what keeps the secret from one: the branch rule is. A workflow that names no environment may list `workflow_dispatch`, and M22 passes it (the control in section 9.4). Such a workflow receives no environment secret, and the design keeps no repository secret (M02).
- **P3, unchanged.** The pooler hosts are found by the first push run and then recorded by a class-high change (section 3; section 7 item 2).

### 9.4 Outputs of the checks run for this revision

- `python3 -I tests/C02/W-C02-03/test_decision_steps.py`: `W03_DECISION_TEST PASS (67/67)`, exit 0. E05, E20 and E21 are `taken` with the empty table, and E22, E23 and E24 are "could not check". The build's 62 cases grew with the test's change; `crosscheck` is "n/a". `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`.
- `python3 -I tests/C02/W-C02-03/test_workflow_order.py`: `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`. `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`.
- **Break copies of `decide` for the changed rules.** These are the producer's own copies, not the checker's; each run gives a "(break-copy run) FAIL" line unless noted. Each removes its rule wherever the code enforces it:
  - the old rule (any table refused): red on E05, E20 and E21;
  - a table holding a row taken (the row check removed): red on E04;
  - a null or missing count taken as empty (three checks removed, the row test made null-tolerant): red on E22 and E23;
  - the listing check removed: red on E08, E09 and E24;
  - a "taken" line always giving `history_table_exists=false`: red on E05, E20 and E21;
  - the disagreement rule removed: PASS. The test has no case for that rule. Run directly with the unchanged step, a table read as absent with `history_rows` 0 or 3 gives `apply=no`, `result_kind=could_not_check`, `exception=not_taken`, and the line names `history_rows`.
- **The repeated bodies** (a comparison of each step id's `run` and `shell` across jobs): every repeated id is identical. `compare` ×5 is `f85406edecc6`; `head`, `checkout`, `workdir`, `pooler`, `presence`, `connect` and `report` ×4; `cli`, `listing`, `dryrun`, `apply` and `search` ×2.
- **PostgreSQL 16.15, throwaway cluster** (no `supabase_admin` role; `w03.throwaway = 'yes'`; each run on a fresh database built from the migration):
  - without a patch: `W03_DRIFT_DETECTS PASS (10/10)` and `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`;
  - B1: red S02 to S09 and C02 to C13;
  - B2: red S06 to S09 and C07;
  - B3: red S02 to S05 and S09, the other file 13/13;
  - B4: red C02 to C13, the other file 10/10.
- **One-snapshot probes (T-W03-DEC part D, with the row count).** Each ran the `compare` step's own SQL and Python, read from `migrate.yml`. Session B committed between session A's reads statement and A's row count, and each probe used a fresh database. Each line gives A's reads, then a read made after B:
  - D1 (part D: B adds the function, the table and a row): `function_exists=False history_table_exists=False history_rows=None listing=0 complete=True`, none of B's objects; after B, `True True 1`, listing 2.
  - D2 (an empty table; B adds a row and the function): `False True 0`, complete, so the count is the snapshot's; after B, `True True 1`.
  - D3 (a table holding a row; B drops it and re-creates it empty): `complete=False`, `history_rows=None`. The build's previous body (`ffe6111`) gave `True 0 complete=True` here. After B: `False True 0`, complete.
  - D4 (a table holding a row; B truncates it): `False True 0`, complete. This is the residual of section 9.1.
- **The program runner, run locally.** The bodies of `tokens`, `dbprograms` and `tokens_revoke`, read from `migrate.yml`, ran with bash against a throwaway database. It held stub `issue_env_token` and `revoke_env_token` functions and a login named `postgres.cqbzxexxwrrbrlszoseg`, with a made-up `PGPASSWORD` and publishable key. Two stub programs sat in a scratch directory outside the clone: `a_needs_db.py`, which declares the database and exits 1, and `b_api_only.py`, which exits 0.
  - `tokens` exit 0: six issued, and "revoked token (devos_kurulum): issued and revoked".
  - `a_needs_db.py` saw the environment names `HOME LANG PATH PGDATABASE PGHOST PGPASSWORD PGPORT PGSSLMODE PGUSER`, the stdin keys `apikey endpoint revoked_token tokens`, the endpoint `https://cqbzxexxwrrbrlszoseg.supabase.co`, the key "set" and six classes. Over the database: "6 of 6 given tokens live; revoked token revoked: true". It then gave `test program a_needs_db.py: fail`.
  - `b_api_only.py` saw the environment names `HOME LANG PATH`, with `PGPASSWORD` absent, and the same input. It gave `test program b_api_only.py: pass`.
  - `dbprograms` exit 1. `tokens_revoke` exit 0: "already revoked before the programs", and six "revoked".
  - The database after: "7 issued, 7 revoked". `::add-mask::` lines: 7. Token, password or key values in any other line: 0. No token file left.
  - With the key unset and `PGUSER` not of the pooler form: the endpoint is `null (not derivable)`, the key `not set (null)`, and the programs received `null` for both.
  - With `issue_env_token` refusing `devos_ci`: `tokens` exit 1, `dbprograms` not run (its `if`), `tokens_revoke` revoked all five issued and the revoked token was already revoked ("6 issued, 6 revoked"). Nothing secret was printed.
- **M22's check** (its own step body from `migration-checks.yml`): the workflows as built pass. Each wrong copy fails on its own rule:
  - `migrate.yml` with `workflow_dispatch`, or with `pull_request` ("event …; a workflow naming an environment starts only on push and schedule");
  - with a push path filter, or with a `claude/**` push branch ("push must be on branch main only");
  - with `actions/checkout` pinned by tag;
  - an apply step in a scheduled job;
  - a second workflow naming `migrate-devos` on push to `main`, and a branch workflow naming `migrate-devos-test` with `workflow_dispatch` ("only migrate.yml may");
  - a job calling a reusable workflow.

  Control: `migration-checks.yml` with `workflow_dispatch` added passes, since it names no environment.
- `python3 -I tools/credential_value_scan.py` with `--dir` set to the clone's `.github`, `supabase` and `evidence/C02`, run from the working tree. It searched for two values, the messaging token and the session ingress token file's content; the others named were "not a candidate" or "no value". Result: `.github` 2 files read, `supabase` 3 files, `evidence/C02` 54 files, and for each value "0 files hold it"; `CREDENTIAL_VALUE_SCAN DONE`, exit 0. It was run before this line was written and again after.

### 9.5 What is still open

1. **Closed 2026-10-12 by `8e74473` (section 10.1).** **EV-C02-001's "one secret".** M03 and its "Names" say that each environment holds one secret, `SUPABASE_DB_PASSWORD`, and so does Batu's step text, "each with one secret". With N-255's decision (L-295), `migrate-devos-test` also holds `DEVOS_TEST_PUBLISHABLE_KEY`. That is a record change for the executor, outside this revision's list. The step text of "Batu's steps" row 1a is the executor's.
2. **The endpoint's form.** The runner gives `https://<ref>.supabase.co`, and the Data API's paths are below it. W-C02-07's phase C aligns its programs to this, or the executor changes it here.
3. **Closed 2026-10-12 by PR #298, E25 and E26 (section 10.1).** **The disagreement rule has no test case.** T-W03-DEC, "What it does not cover", leaves it to the test designer to add one once the executor has decided, and it now is decided. Until then it rests on section 9.4's direct run.
4. **The new `compare` guard and the runner.** Both are this producer's choices, shown on PostgreSQL 16 only. The projects run 17.6 (`devos`), and the runner's behaviour on GitHub is live-only (first runs after Batu's step 1 and sitting A).
5. **Section 7's items 2 and 4 to 7 stand.** These are P3, `revoke_env_token`'s assumed argument, the order of the first merges, Y-09's test and R1's closure.

## 10. Revision after the four checker lenses at `762640d` (2026-10-12)

Made at the branch head `762640d` (`main` `9537194`, PR #298, merged in) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only, like the rest of this record. Its inputs are the four lenses' results at that head: acceptance, security, mechanical, and the changes since the earlier verdicts. Each finding is named below by lens and ID. Files changed: `.github/workflows/migrate.yml`, `.github/workflows/migration-checks.yml`, `evidence/C02/EV-C02-001_migration_path.md` (two dated lines) and this record. No test under `tests/C02/W-C02-03/` or `supabase/migrations/tests/` was changed. A script outside the repository replaced each repeated step body in every copy at once, asserting the number of copies; section 10.10 shows the copies identical.

### 10.1 The records at the head (acceptance F1; changes F2; mechanical M9)

- **The head's result.** `test_decision_steps.py` gives `W03_DECISION_TEST PASS (69/69)`, E25 and E26 included [obs, section 10.10].
- **Break copies.** A copy of `decide` without the disagreement rule gives `FAIL (2 bad, 0 could not check, of 69)`, red on E25 and E26. A copy that refuses only a count above 0 gives `FAIL (1 bad …)`, red on E26.
- **The git order.** The rule's code came first, in `b0f3ab1` (19:39:16Z), and its test after, in `7d7730b` (19:51:45Z, PR #298). Section 9.4's `67/67` and its direct run of the rule were made before that test existed, so they do not count for E25 and E26 (README, "A test is never changed after a result…"; Ek G G8 item 3). The result that counts is the run at the head, after the test: this section's.
- **Section 9.5.** Item 1 is closed by `8e74473`, in which EV-C02-001's M03 and "Names" add `DEVOS_TEST_PUBLISHABLE_KEY`, dated. Item 3 is closed by PR #298.
- **`main_at`** is now `9537194`, the `main` merged into the head. EV-C02-001's line on the disagreement rule (point 6) gets a dated note saying that E25 and E26 now test it.

### 10.2 T-W03-DEC part D (acceptance F3)

- **The label.** Part D could not be checked on PostgreSQL 17, since no 17 cluster is available here; the projects run 17.6 (`devos` observed). It was observed on 16.15 only, as supporting evidence: section 5's R6 row, section 9.4's D1 to D4, and section 10.7's probe.
- **The consequence.** By T-W03-DEC's own rule (its line 109), the read step's snapshot claim on the projects is "could not check". The first-migration exception rests on the reads' agreement in the live run only.

### 10.3 Point 5's read in `devos-test` (acceptance F2)

- **The route: a database-test file.** It comes with point 5's fixture, as `supabase/migrations/tests/<name>.sql`, a class-high file judged with the fixture. It:
  - holds no psql meta-command, and runs in its own `begin … rollback`;
  - reads, from `pg_catalog`, the definition T-W03-05 item 2 names: columns, types, the primary key, the default, the comment and the view's definition;
  - reads the history row with the fixture's version and name;
  - raises each value as a `NOTICE`;
  - compares each field with the file's text and raises an error on a difference (T-W03-05's negative control);
  - ends with its `NOTICE: <NAME> PASS (` line.
- **The workflow needs nothing more.** `dbtests` already does all of this:
  - It runs in job `devos-test` after the apply and a clean comparison.
  - It prints every line of each file's psql output, `NOTICE`s included. Each line carries the file's name, with control characters escaped. This makes the lines the job's own read, labelled by job, step and file.
  - The file passes only on exit 0 and its PASS notice, so a read that finds a difference fails the step, and `go` is not `yes`.
  - It accepts any name of the fixed form (section 10.4), so the fixture's arrival is a class-high change to `supabase/migrations/tests/` only, not to the workflow.
- **Shown [obs, PostgreSQL 16.15].** A scratch file `w03_fixture_apply_read.sql` (not in the repository) read `devos_private.function_deployment`'s columns and raised them as `NOTICE`s. `dbtests` printed `w03_fixture_apply_read.sql: psql:…: NOTICE:  W03_FIXTURE_READ column slug: text` and the six other column lines, then the file's PASS notice and `database test w03_fixture_apply_read.sql: passed`.
- **If the read is not made.** If the comparison is not clean, `dbtests` does not run, and `devos-test`'s part of T-W03-05 is "could not check" ("A project not reached").

### 10.4 The SQL test runner (security F1)

`dbtests` is now a Python program run as `python3 -I -`:
- It takes every name in `supabase/migrations/tests/` ending in `.sql` (any case), in name order.
- It runs a file only if it is a regular file, not a link, whose name matches `[a-z0-9_]+\.sql`. Any other name gives "database test <name, escaped>: could not check (…); not run", and the step fails.
- It refuses a file holding a backslash by searching the file's bytes. Nothing interprets the name.
- It passes the path to psql as an argument, as `psql -X -v ON_ERROR_STOP=1 -f <path>`, and prints psql's output itself, line by line, with the name before each line.
- No file name, path or content reaches a `sed` program, a shell or another interpreter.

[obs] It ran on a scratch directory holding six files:
- `a_fail.sql` (`select 1/0`): `not passed (psql exit 3)`;
- `b_ok.sql`: `passed`;
- `c_backslash.sql` (`\! echo INJECTED`): `refused, it holds a backslash`;
- `|e;#.sql`, whose content would have made the old `sed` program run commands: "could not check …; not run", and no line `INJECTED` appeared;
- `Upper.SQL` and a name holding a newline: "could not check", the newline printed as `\n`.

The step exited 1. `test_workflow_order.py` still reads `ON_ERROR_STOP=1` and the PASS check in this body, and its two runner break copies are still red (section 10.10).

### 10.5 M22 (security F2, F3; mechanical M6, M7)

`workflow_check` now checks the following.

**In every workflow file:**
- no job-level `uses:`, a call of a reusable workflow, wherever it appears;
- every action pinned by full commit SHA. This is EV-C02-001 section 3's "Reusable workflows" row as written; the earlier build checked both only in files that name an environment.

**In a workflow that names an environment:**
- each job's `runs-on:` must be the exact label `ubuntu-24.04`, the label M20 names; a list or `self-hosted` is refused;
- `container:` and `services:` are refused;
- a job holding an apply step must be `devos-test` or `devos`, and its `if:` must admit the `push` event alone. The check reads `if:` as a conjunction (`&&`) of exactly one `github.event_name == 'push'` and only the status terms `!cancelled()`, `always()` and `success()`. Any other form is "could not check" and the check fails: an `||`, another event such as `schedule`, a negated or `!=` event test, a function such as `contains(…)`. A job holding an apply step with no `if:` admits every event and fails.

**Self-check.** Before judging the files, the step makes 18 wrong copies of the files at the pull request's head. Each copy changes one place, and each must fail on its own rule and only on it. A control must pass: `migration-checks.yml` with `workflow_dispatch`, since it names no environment. The new copies are:
- `devos-test` on `push || schedule`;
- `devos-test` on a negated event test;
- `devos-test` on any event but `schedule`;
- `devos` on `schedule`;
- `devos-test` with no `if:`;
- a workflow naming no environment that calls a reusable workflow;
- a workflow naming no environment that uses an action by tag;
- `devos-test` in a container;
- `devos` with services;
- `devos-test` on `self-hosted`;
- `check-devos` on a list of labels.

The seven kinds the earlier build reported are kept. A rule the files at the head already break is reported as "not shown" rather than as a self-check failure.

**Exit codes.** 0 pass, 1 fail, 3 could not check.

[obs] The step's own body ran on the clone, and on wrong copies written to disk:
- The clone: 18 "fails on its own rule, as it must" lines, the control passing, then `workflow check: pass`, exit 0.
- Disk copies (exit 1 for a fail, 3 for could not check):

  | Copy | Result |
  |---|---|
  | push or schedule | could not check, 3 |
  | a reusable-workflow caller with no environment | FAIL, 1 |
  | container | FAIL, 1 |
  | `self-hosted` | FAIL, 1 |
  | services | FAIL, 1 |
  | `contains(github.event_name, 'push')` | could not check, 3 |

- **Found and fixed by the self-check:** a list in `runs-on:` made the first draft raise `TypeError`. Any exception in the check is now "could not check".

### 10.6 Shell semantics (security F4; mechanical M10)

**Explicit shells.** Every `run:` step now names its shell. A bash body has `shell: bash`, which GitHub runs as `bash --noprofile --norc -eo pipefail {0}` [doc, from memory, not re-read here]. A Python body keeps `shell: python`.

**Each body is written to hold under that `-e`:**
- A command whose exit code the step reads is written `cmd && rc=0 || rc=$?`, or inside `if`. This covers psql in listing and compare, the tool in dryrun and apply, and the tests in `w03_tests`.
- A Python program that decides the step's result is followed by `|| exit $?`, or `&& rc=0 || rc=$?` where `tokens_revoke` must still delete its file.
- A step of several commands sets an `ERR` trap. It prints "<step>: could not check (a command of this step failed, line N)", so no `-e` exit is silent. This covers the CLI install, the working directory, the listing, the dry run, the apply and the comparison.
- `cli` now checks the download and the extraction with `if`. `presence` prints "could not check" and stops if the mask cannot be made.

**Found here [obs].** Under `-e` and `pipefail`, the dry run's version extraction (`grep … | sed … | sort -u | python3`) ended the step when the tool's output named no file, that is, on a dry run with nothing pending. It is now one Python read that gives `[]`.

[obs] Each changed body ran under `bash --noprofile --norc -eo pipefail`, with a command that fails:

| Step | Failure | Result |
|---|---|---|
| `cli` | the download fails | "could not check (the download failed) …", exit 1 |
| `cli` | the checksum does not match | "checksum MISMATCH; the tool is not extracted, and no step that runs it runs", exit 1 |
| `workdir` | an unwritable temporary directory | "expected: could not check (a command of this step failed, line 5)" |
| `presence` | `python3` fails | "credential present: could not check …", exit 1 |
| listing | the database unreachable | both psql errors printed, "listing: could not check (the read did not complete)", the control line, `count=` written, exit 1 |
| compare | the database unreachable | "result=could_not_check call=not_called", every output written, exit 0 |
| compare | `W03_TIMEOUT=0.01` | "call=timeout" |
| dryrun | a stub tool exits 2 | its output printed with `\x1b` escaped and the `\r` piece on its own `cli: ` line, the pending versions, "dry run: exit 2", exit 2 |
| dryrun | the stub prints no file name | `pending=[]`, exit 0 |
| apply | the stub exits 1 | its output, the working directory's list, "apply: exit 1" |
| dbtests | as in section 10.4 | as there |
| `w03_tests` | a decision test that exits 1 | both tests ran, then "W-C02-03 tests: decision steps exit 1, workflow order exit 0", exit 1 |

The token steps ran too, with the results in section 10.8.

### 10.7 The one-snapshot guard: a lock (changes F1)

**The change.** `compare` (five identical copies) now reads whether the history table exists first, in its own statement. Then, inside the read-only REPEATABLE READ transaction and before any `select`, it takes `lock table supabase_migrations.schema_migrations in access share mode`. PostgreSQL takes a REPEATABLE READ transaction's snapshot at its first `select`, not at `LOCK` [doc, the LOCK page, from memory; observed in the probe below: a row B inserted after A's `LOCK` and before A's reads is counted by A].

**What the lock does.** `ACCESS SHARE` conflicts only with `ACCESS EXCLUSIVE`, the lock that `TRUNCATE`, a table-rewriting `ALTER TABLE`, `DROP` and `VACUUM FULL` take. None of them can run on the table between the reads and the count, and one that committed before the lock is in the snapshot.

**The guards that stay or are added:**
- The oid comparison stays, so a schema renamed and a table re-created under the old name between the two statements still gives "not complete" [inf; not probed].
- A table that did not exist at the first read, so was not locked, but is present in the snapshot, makes the reads "not complete" (`W03LOCKED`).
- A lock already held by another session makes `compare` wait up to its client-side timeout, then `call=timeout`: "could not check".

**Probe [obs, PostgreSQL 16.15].** Session A is `compare`'s own body under `bash -eo pipefail`, with session B injected by psql's `\!` after A's reads statement. B ran with `lock_timeout = 2s`. The table held one row and the function was absent.

| Case | Old body (`762640d`) | New body |
|---|---|---|
| no change | | `history_rows=1`, complete |
| table-rewriting `ALTER TABLE … ADD COLUMN … DEFAULT clock_timestamp()` | B committed; A `history_rows=0`, complete (the residual the lens found; the table still held 1 row) | B "canceling statement due to lock timeout"; A `history_rows=1`, complete |
| `TRUNCATE` | B committed; A 0, complete (the old D4) | B timed out; A 1, complete |
| drop and re-create empty (D3) | | B timed out; A 1, complete |
| `VACUUM FULL` | | B timed out; A 1, complete |
| `DELETE`, an MVCC-safe control | | B committed; A 1, the snapshot's count |
| B inserts a row after A's `LOCK`, before A's reads | | B committed; A `history_rows=2`, complete: the snapshot is taken after the lock |
| the table and its row created by B after the first read | | `history_table_exists=true`, `history_rows=null`, `complete=false` |
| D1, part D: B adds the function, the table and a row after A's snapshot | | `False False None`, complete |
| D2: an empty table; B adds a row and the function after A's snapshot | | `False True 0`, complete |
| never pushed | | `False False None`, complete |

**What remains.** The schema-rename route rests on the oid comparison, not probed. Everything here is on 16.15 only (section 10.2). The section 9.1 residual ("`TRUNCATE` is not MVCC-safe …") is closed by the lock, and so is the rewrite race the lens found.

### 10.8 Refinements

- **Acceptance F4 (point 12's hygiene).** Section 6 row 12's claim is limited to what the files do.
  - The `W03REPORT` line holds names, versions, counts and statuses only (JSON, ASCII).
  - Other lines print outputs verbatim:
    - the command-line tool's output (dryrun, apply), with control characters escaped;
    - psql's error text (connect as it was; listing and compare escaped);
    - each database test's full output, escaped;
    - the test programs' own output, unprocessed.
  - For these, the hygiene layer is GitHub's masks. They cover the raw secret (GitHub's own) and the percent-encoded form (`presence`). They cover each synthetic token (`tokens`) and the publishable key, a secret value.
  - **Residual:** if the tool re-serialises the connection string with another encoding of its user part, that form is not masked. Whether v2.120.0 prints its `--db-url` was not read: could not check.
- **Acceptance F5 (the search's "none found").** "none found by that method" is printed only for places backed by a found plant. Every other place gets "search: could not check: <place> (the plant was not found in …)", and so do the percent-encoded form not found anywhere and every place when no plant is configured. Issue #6 is backed by the fixture issue, read with the same code (T-W03-09 p3).
  - [obs] A local repository held the plant in its current tree (plain form) and only in its history (percent form), with the API unreachable. The step printed "none found by that method in: repository: history; repository: current trees". It printed "could not check" for issue #6, the fixture issue and the logs, and its last line reads "0 matches, but could not check …".
  - With no plant: every place "could not check", and no "none found".
  - Not run here: a configured plant missing from a place that was read (a guard denial, section 10.10).
- **Acceptance F6.** Job `devos`'s report now carries `APPLY: ${{ steps.apply.outcome }}`, as `apply_step`. So "apply: yes" with a skipped or failed apply reads as such.
- **Acceptance F7 (point 10).** Two parts of T-W03-10 remain: its planted sensitivity check (positive control (ii): a schema, its table, a view, a function, a role, and a table in `public`) and its widened-list break.
  - Each runs either in `devos-test`, inside a rolled-back database-test file (section 10.3's route), or on a throwaway database labelled with its PostgreSQL version.
  - Neither has run as this record's evidence. The acceptance lens's run on 16.15 is a checker's.
- **Security F6, second half.** No synthetic token is on any process's command line now. `tokens` and `tokens_revoke` pass each token to psql in its environment (`W03_TOKEN`), and the step's own SQL reads it with `\getenv`. psql 15 or later is needed; the runner's psql version is [doc, from memory] 16. An older psql fails `\getenv` under `ON_ERROR_STOP`, so the step fails and `go` is not `yes`.
  - [obs] A psql wrapper logged every command line: 14 lines, holding 0 of the 7 tokens.
  - `tokens` issued six and revoked the seventh.
  - `dbprograms`: one program "pass", one "could not check", exit 1.
  - With one revocation refused, `tokens_revoke` printed "NOT revoked" for it and "revoked" for five, exited 1, and deleted the token file.
- **Security F7 (section 9.2's limits).** The no-database default is not a boundary against a program that reads its parent's environment:
  - The `/proc` route is observed: the security lens's undeclared program read `PGPASSWORD` from its grandparent [obs, that lens].
  - Hosted runners give passwordless `sudo`, so code in a job can read the job's secrets from the runner's own process [doc, from memory, per that lens; not re-read].
  - A program can leave a process behind past `timeout 600` that reads a later step's environment; `tokens_revoke` holds `PGPASSWORD` [inf].
  - **Why the review is the boundary.** Everything in the job runs as the same operating-system user, with the step's environment within reach, so no setting inside the job separates a hostile program from the credential. The boundary is the class-high review: every file under `supabase/migrations/tests/` and both workflows merge only with a fresh-context verdict (`tools/merge_gate.py`). The per-step `env` and the declaration line guard against accident only.
- **Security F8.** Names and versions read from the database are printed with control characters escaped: the listing's items, the comparison's differences, psql's error lines, the database tests' output and the tool's output.
  - [obs] A schema named `w03 evil⏎::add-mask::forged` printed as `listing: schema w03 evil\n::add-mask::forged`, one line.
  - `decide` and `report` already print JSON (ASCII).
  - **Not changed:** `pr_decide` prints versions taken from the run report, decoded from its JSON, in the pull-request check's log. That job holds no secret. `pr_inputs` still keeps the last report line per project. Both are outside this revision's list.
- **Security F9.** The checksum line now reads "checksum MISMATCH; the tool is not extracted, and no step that runs it runs", and section 4 has a dated correction. `compare` still runs and holds the credential.
- **Security F10.** EV-C02-001's M21 sentence is corrected by a dated line (see 10.8, acceptance F4, for the residual).
- **Security F12.** The search step's git processes get only `PATH`, `HOME`, `LANG` and `GIT_TERMINAL_PROMPT=0`. None of them needs the credential or the token, since the repository is public; the GitHub API calls stay in the step's own process. [obs] A git wrapper logged the names of 12 git processes. They held no `SUPABASE_DB_PASSWORD` and no `GH_TOKEN`; besides the four given, only `PWD`, `SHLVL` and `_`, which the wrapper's own bash sets.

### 10.9 Pending, not made here

A researcher is gathering the facts, and a later change makes these; the code's parts are as they were:
- **Security F5:** the server is not authenticated. `sslmode=require`, against `verify-full` with a pinned root certificate.
- **Security F6, first half:** the password, percent-encoded, sits in the command-line tool's `--db-url` argument during dryrun and apply.
- **Security F11:** concurrency groups are shared across branches. A branch workflow naming group `migrate` with `cancel-in-progress: true` could cancel a running apply.

### 10.10 Outputs of the checks run for this revision

- `python3 -I tests/C02/W-C02-03/test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0. `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`, exit 0. Break copies: section 10.1.
- `python3 -I tests/C02/W-C02-03/test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies red, `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0. `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`, exit 0.
- **The repeated bodies.** A comparison of each step id's `run` and `shell` across jobs found every repeated id identical:
  - `compare` ×5 (`compare_after` included) `1260def3e0a4`;
  - ×4: `head` `8da1cee258f9`, `workdir` `39a09b6a79ce`, `pooler` `3886dddb628d`, `presence` `81c784e3f1f1`, `connect` `bf7ddd9af758`, `report` `ae92c5b56744`;
  - ×2: `cli` `9a997b75cce6`, `listing` `b1b058f32c88`, `dryrun` `cbeb38000a88`, `apply` `2b3808cf965b`, `search` `af60920e3ead`.

  `decide` (`e4e381332519`) and `pr_decide` are unchanged.
- **PostgreSQL 16.15, a throwaway cluster.** No `supabase_admin` role, `w03.throwaway = 'yes'`, each run on a fresh database built from the migration:
  - without a patch: `W03_DRIFT_DETECTS PASS (10/10)` and `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`;
  - B1: `FAIL (8 bad …)` and `FAIL (12 bad …)`;
  - B2: 4 and 1 bad;
  - B3: 5 bad, the other file 13/13;
  - B4: the first file 10/10, the other 12 bad.

  The migration and the tests are unchanged since section 9.4, whose named red cases these counts match.
- **Step bodies, M22, the probe:** sections 10.4 to 10.8.
- **`python3 -I tools/credential_value_scan.py`**, run from the working tree with `--dir` set to the clone's `.github`, `supabase` and `evidence/C02`:
  - `.github` 2 files read, `supabase` 3, `evidence/C02` 54;
  - each value searched: "0 files hold it";
  - `CREDENTIAL_VALUE_SCAN DONE`, exit 0.

  It was run before this line was written and again after.
- From the clone: `python3 -B tools/records.py render --check` gave `RENDER OK`, and `bash tools/check_service_names.sh` gave `SERVICE_NAMES CLEAN`, each exit 0.
- **Guard denial #20260, rule B11.** A further run of the search step, with a plant configured but absent, was refused: an assignment of `HOME` on a command that would run git. It was not pursued another way, so that path is not shown (10.8, acceptance F5).
