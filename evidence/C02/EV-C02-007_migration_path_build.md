---
id: EV-C02-007
item: W-C02-03
kind: build
title: "The migration path's build: the migration workflow, the pull-request checks, the deciding steps, the first migration and the listing of point 10 (W-C02-03, points 5 to 14)"
date: 2026-10-12
main_at: 6807099
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (same session; declared, Ek A 5.3)"
sources:
  - "evidence/C02/EV-C02-001_migration_path.md (every section; M01 to M32, O1 to O3, sections 4, 5, 6, 10, 12), plan/decisions/PC-41.md, evidence/C02/EV-C02-004_reconciliation_decisions.md (Y-01 to Y-12), EV-C02-002 section 13 A2, EV-C02-003 sections 1.6, 5.3 and 6.3, at main 4da5ef2"
  - "tests/C02/W-C02-03/ (README, the eight specifications, test_decision_steps.py, test_workflow_order.py, breaks/B1 to B4) and supabase/migrations/tests/w03_*.sql, at main 4da5ef2; evidence/C02/checks/CHK-C02-017.md and CHK-C02-020.md"
  - "Pins, read 2026-10-12 18:35Z to 18:49Z through the agent proxy: `git ls-remote https://github.com/actions/checkout` and a fetch of tag v6.1.0; https://registry.npmjs.org/supabase (dist-tags.latest 2.120.0, published 2026-10-06T16:40:30Z); https://github.com/supabase/cli/releases/download/v2.120.0/checksums.txt and .../supabase_linux_amd64.tar.gz (the GitHub release page and API were refused by the proxy, 403)"
  - "P13: the Supabase command-line tool's own source at tag v2.120.0 (commit 753520fa7202ed5f8b25883a4c0aa7e5e9ad1fc4, a shallow clone of https://github.com/supabase/cli read 2026-10-12 about 18:40Z), files apps/cli/src/command-internal/db-push-core.ts, migration-apply.ts, migration-history.ts and apps/cli/src/commands/db/push/push.command.ts; read as data, not run"
  - "Local runs on a throwaway PostgreSQL 16.15 cluster (port 54403, scratch directory outside the clone, stopped and deleted after), 2026-10-12 18:46Z to 19:05Z"
  - "Revision of 2026-10-12 (section 9), at the branch head ffe6111 (main 11feac5 merged in), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): tests/C02/W-C02-03/T-W03-DEC_decision_steps.md and test_decision_steps.py as changed after P13 (PR #296); plan/work/C02.md notes N-255 (with 'The key's source, decided', L-295) and N-257, and 'Batu's steps' row 1a; EV-C02-003 sections 1.1, 4.1 and 6.3; local runs on a second throwaway PostgreSQL 16.15 cluster (port 54417, data directory under the postgres user's home, outside the clone, stopped and deleted after)"
  - "Revision of 2026-10-12 (section 10), at the branch head 762640d (main 9537194, PR #298, merged in), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): the four checker lenses' results at 762640d (acceptance, security, mechanical, changes since the earlier verdicts); local runs on a third throwaway PostgreSQL 16.15 cluster (port 54461, data directory under the postgres user's home, outside the clone, stopped and deleted after)"
  - "Revision of 2026-10-12 (section 11), at the branch head d4eb7c6 (main 9537194), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): the security lens's F5, F6, F8 and F11 at 762640d; the researcher's findings of 2026-10-12 on the pooler's chain, the root certificate, the tool's connection code and GitHub's concurrency; the Supabase Root 2021 CA fetched 2026-10-12T20:43:16Z from https://supabase-downloads.s3-ap-southeast-1.amazonaws.com/prod/ssl/prod-ca-2021.crt; the tool's release v2.120.0 fetched 2026-10-12T20:43:30Z; local runs on a fourth throwaway PostgreSQL 16.15 cluster with TLS (port 54473, data directory under the postgres user's home, outside the clone, stopped and deleted after)"
  - "Revision of 2026-10-12 (section 12), at the branch head 1903b77 (main a091ea3 merged in at 5cad061), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): CHK-C02-029 (FAIL, conditions 1 to 4, F-2, F-3) and CHK-C02-035 (FAIL, C1 to C5) at 5cad061; GitHub's workflow parser @actions/workflow-parser 0.3.61 (npm, integrity sha512-NBjJrbww…IfKdg==, installed 2026-10-12T21:37:26Z with scripts disabled) and actionlint 1.7.12 (release asset actionlint_1.7.12_linux_amd64.tar.gz, SHA-256 8aca8db96f1b94770f1b0d72b6dddcb1ebb8123cb3712530b08cc387b349a3d8 as in the release's checksums file, fetched 2026-10-12T21:41:20Z), both run offline; local runs only, no database cluster"
  - "Revision of 2026-10-12 (section 15), at main d33c8e9 (branch claude/c02-w03-live-h1), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): the executor's decisions C1 and C3 for the live campaign's first class-high change (the researcher's plan of 2026-10-12, parts 2 and 4, a hint); section 13; tests/C02/W-C02-03/T-W03-08 and T-W03-09 at d33c8e9; @actions/workflow-parser 0.3.61 (integrity as in section 12) installed 2026-10-12T23:19:53Z with scripts disabled, run offline; local runs only, no database, no GitHub"
  - "Revision of 2026-10-12 (sections 15.6 to 15.11, part 2 of H1), at the branch head 3c80bf1, by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): the executor's three decisions for part 2 (a hint); GitHub's documentation pages cited in 15.6, read 2026-10-12 23:35Z to 23:39Z; @actions/workflow-parser 0.3.61 as in 15.4; local runs against a stand-in GitHub API on 127.0.0.1 only, no database, nothing against GitHub's API"
  - "Revision of 2026-10-13 (section 15.12, part 3 of H1), at the branch head 5201bd9, by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): the executor's three decisions for part 3 on part 2's open items 2, 3 and 7 (a hint); main's first-parent history at d33c8e9, read with local git (the rate of pushes in 15.12.2); @actions/workflow-parser 0.3.61 as in 15.4; local runs against part 2's stand-in API on 127.0.0.1 only, no database, nothing against GitHub"
  - "Revision H1-prime of 2026-10-13 (section 15's opening and 15.13 to 15.16; the renumbering of section 14 to 15), at main 6807099 (branch claude/c02-w03-h1p, head 376a123), by a fresh-context producer subagent of the same working session (declared, Ek A 5.3): plan/decisions/FR-07.md and evidence/C02/raw/FR-07_*.md; CHK-C02-043, -044 and -045; the executor's five facts for H1-prime (a hint; section 15.14); tests/C02/W-C02-03/ at 376a123; the image digest of postgres:17 from Docker Hub's registry (registry-1.docker.io) and the docker-library repo-info page for postgres:17, read 2026-10-13T01:42Z; @actions/workflow-parser 0.3.61 as in 15.4; local runs, hints only, on a throwaway PostgreSQL 16.15 cluster under /var/tmp (stopped and deleted after) and against a stand-in GitHub API on 127.0.0.1; nothing against devos, devos-test or GitHub's API"
claim: "A build, checked offline only. The offline tests pass at this build. Nothing ran against devos or devos-test, and no workflow ran on GitHub (until 2026-10-12, when GitHub ran `migration-checks.yml` on pull request #304, section 12.9, and `migrate.yml`'s first push run reached the pooler with each project's user and no password, section 13): every behaviour of GitHub, of the pooler and of the projects is still documented, inferred or read in source, until the first runs after Batu's step 1. Section 6 lists what stays live-only."
---

# EV-C02-007 · The migration path's build (W-C02-03)

**What this is.** The build of the accepted design `evidence/C02/EV-C02-001_migration_path.md` (with PC-41), made so that it passes W-C02-03's offline tests now and can pass the live tests after its merge. **Labels:** [obs] observed here, with the output named; [doc] documented and not independently tested; [src] read in the pinned tool's source; [inf] inference; [cnc] could not check; [choice] a choice the design left to the build. Nothing here was run against `devos` or `devos-test` (until `migrate.yml`'s first push run, section 13, whose pooler step reached each project's pooler with no password and stopped).

## 1. Files, and what each meets

| File | Class | What it meets |
|---|---|---|
| `.github/workflows/migrate.yml` | high | EV-C02-001 section 5's shape: on `push` to `main` and on a 6-hourly `schedule` only (M04); jobs `devos-test` (environment `migrate-devos-test`) then `devos` (environment `migrate-devos`, `needs: devos-test`, runs in every case), each with steps (1) to (8) of section 5; scheduled jobs `check-devos-test` and `check-devos` (head, presence, connect, comparison, point 9's search); the head check (M05); concurrency (M06); the stop (M07, M16); the working directory (M08, Y-09); the database tests and the test programs (M09, M25, Y-05); the first-migration exception's three reads in one snapshot (section 5; R6; CHK-C02-017 F7 item 2); the listing of point 10 with its printed exclusion list; the report lines (section 5, "Every run writes a report"; M15); pins (M20, P12); the secret only in the `env` of the steps that connect, its percent-encoded form masked (M21); no shell tracing, no tool debug output. (2026-10-12, section 11: every connection authenticates the server, `sslmode=verify-full` against the pinned Supabase Root 2021 CA, with two negative controls before the credential is used; the tool gets the password only as `PGPASSWORD`; the concurrency group is renamed) |
| `.github/workflows/migration-checks.yml` | high | The pull-request checks: M22's static check (`workflow_check`), the inputs of M15 (`pr_inputs`), M16's rule (`pr_decide`), and W-C02-03's two offline tests (`w03_tests`, the environment T-W03-DEC names). No secret, no environment. (2026-10-12, section 11: M22 also refuses any `sslmode` but `verify-full` and any root file but the pinned one, section 11.2; `pr_inputs` and `pr_decide` changed for F8, section 11.7). (2026-10-12, section 12: at `d4eb7c6` this file held five and at `ccd92f2` six `${{` sequences inside `workflow_check`'s body (count corrected 2026-10-12, CHK-C02-038 F-10), so GitHub's parser refuses it there and none of its checks would have run on a pull request; it now holds none, and the parser reads both files with 0 errors. `pr_inputs` reads the changed files NUL-separated) |
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
| The comparison step takes its connection parts from its `env` (T-W03-07 c2) | `compare` uses libpq's `PGHOST`, `PGPORT`, `PGUSER`, `PGDATABASE`, `PGSSLMODE`, `PGPASSWORD` and `W03_TIMEOUT` from its env; nothing is hard-coded in its body. (2026-10-12, section 11.2: and `PGSSLROOTCERT`; `PGSSLMODE` is now `verify-full`; the body is unchanged) |
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
| The pooler host (P3) | Each job's `POOLER_HOST` is empty. The `pooler` step, which holds no credential, then tries the shared pooler hosts of every AWS region (`aws-0-` and `aws-1-<region>.pooler.supabase.com`) with the user `postgres.<ref>` and no password, takes the host that asks for a password rather than answering "Tenant or user not found", prints it, and stops the job before any step receives the secret *(observed 2026-10-12, section 13: the secret still reaches the environment of step `tokens_revoke`, which runs in every case and, with no tokens file, connects nowhere)* *(2026-10-12, section 15.1: still so after a yes; when the head check is not yes, `tokens_revoke` no longer runs)* | The design records the host in the workflow (M19: "found at the build … and records it in the workflow"); the build has no route to either project. So recording it is one class-high change after the first run. Which error text each pooler gives is [inf], observed at that run |
| Concurrency | `group: migrate`, `cancel-in-progress: false`, `queue: max`, at workflow level. (2026-10-12, section 11.6: the group is now named `devos-migrate.yml-migrate-devos-test-migrate-devos`; the rest is kept; the residual of a repository-wide group is stated there) | M06 as written; P4 tests it |
| Schedule | `41 */6 * * *` | M04 and M17's 6 hours; a minute off the hour |
| The command-line tool's configuration | Written by the workflow: `project_id`, `[db.migrations] enabled = true`, `[db.seed] enabled = false`. The tool runs `db push --db-url <url> [--dry-run] --yes` with `--workdir` on the built directory; no `--include-all`, `--include-seed` or `--include-roles`; telemetry off (`DO_NOT_TRACK`, `SUPABASE_TELEMETRY_DISABLED` [src]). (2026-10-12, section 11.3: the URL holds no password, and the tool reads it from `PGPASSWORD`; the URL carries `sslmode=verify-full` and the pinned root file) | M08, Y-09. The flags are read in the pinned source [src: push.command.ts]; that they work against a hosted project is P1 |
| The test programs (`supabase/migrations/tests/*.py`; the executor's decision, EV-C02-003 section 6.3) | **Replaced on 2026-10-12 by N-255's interface: section 9.2; the build's first form follows, as it was.** Three steps after `dbtests`: `tokens` (holds the credential) issues one synthetic token per DevOS role class with `devos_private.issue_env_token(role_class)` (B:46's signature), masks each, and writes them to a 0600 file under the runner's temporary directory; `dbprograms` (no credential in its env) runs each program with `env -i`, giving it only `PATH`, `HOME`, `LANG`, `DEVOS_DATA_API_URL` (`https://<ref>.supabase.co`) and `DEVOS_TEST_TOKENS_FILE`, and maps its exit code (0 pass, 1 fail, 3 could not check); `tokens_revoke` (always) revokes each with `devos_private.revoke_env_token(<token>)` and deletes the file. With no program, each says "none" and passes. `go` needs all three | The tokens never appear in a step's `env`, a log or a record; the programs never hold the database password. Two parts are not settled: section 7 |
| The search of point 9 | In each scheduled job, a `shell: python` step holding that job's own value and its own token (`contents: read`, `issues: read`, `actions: read`): a mirror clone of `devos` (every branch, tag and pull-request ref), counted separately in the objects of the current trees and in every other object (history); issue #6's title, body and comments, and a fixture issue if `W03_FIXTURE_ISSUE` names one, read with the same code; the logs of the 100 latest earlier runs of `migrate.yml` *(corrected 2026-10-13, sections 15.8 and 15.12: the logs of every earlier run the run list gives, up to 4 pages of 100 runs, the searching run included, a longer list being "could not check"; in each run's archive the credential is counted in every file and the plant once per run)*. It prints counts per place and per form (plain, percent-encoded) and fails the job if the credential is found. The plant of the positive control is decoded from `W03_PLANT_B64`, empty now *(2026-10-12, section 15.2: while it is set, step `plant` of `check-devos-test` prints it once in every scheduled run)* | T-W03-09; the plant and its tag are made at planting time, so setting them is a class-high change then, made by whoever plants |
| The comparison's client-side timeout | `timeout 120` around psql (`W03_TIMEOUT` overrides it); exit 124 gives `call = timeout` | Section 4's caller rule; T-W03-07 c2 |
| `function_deployment`'s columns | `slug` (key), `version`, `ezbr_sha256`, `source_sha256`, `commit_sha`, `run_id`, `deployed_at` | M12's list; one row per deployed function |

## 4. Pins (M20, P12)

- **The command-line tool:** Supabase CLI v2.120.0 (npm `latest`, published 2026-10-06T16:40:30Z), asset `supabase_linux_amd64.tar.gz` from `https://github.com/supabase/cli/releases/download/v2.120.0/`. Its published SHA-256 in the release's `checksums.txt` (entry `supabase_2.120.0_linux_amd64.tar.gz`) is `7074584113aa00495beeac661c41fb09f1ddd0a483cd7333894b0d080086dc6e`, and the downloaded asset's own SHA-256 is the same [obs, 2026-10-12 18:3xZ]. The workflow downloads the asset by that URL and stops on a mismatch before any step receives the credential. (Corrected 2026-10-12, section 10.8: on a mismatch the tool is not extracted and no step that runs it runs; `compare` still runs and holds the credential.) The tarball holds `supabase` (an x86-64 executable, 112 MB) and `supabase-go`; in v2.120.0, `db push` is implemented in TypeScript (`apps/cli`) [src]. Neither binary was run here.
- **`actions/checkout`:** tag v6.1.0 is commit `d23441a48e516b6c34aea4fa41551a30e30af803` of `actions/checkout` itself (a lightweight tag in that repository's refs; its `action.yml` runs on `node24`) [obs: `git ls-remote` and a fetch of the tag, 2026-10-12T18:49Z]. Both workflows use it with `persist-credentials: false`.
- **Not pinned by DevOS:** the runner image's `psql`, `git`, `python3`, `curl`, `timeout` (EV-C02-001 M20's residual); `migration-checks.yml` and the M22 step rely on the image's PyYAML and fail closed without it.
- **The server's root certificate** (added 2026-10-12, section 11.1): the Supabase Root 2021 CA, kept in the workflow and pinned by the SHA-256 of its DER, `807025ad50d4ed219d2c9c7d299c004f824eb00cf7f65afef607d07b72e6cafa`; valid to 2031-04-26. The runner's `openssl`, used only to make control (a)'s run-time root, is not pinned either.

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
| 8 ✘ other branch | Only `migrate.yml` names the environments, on `push` to `main` and `schedule`; M22 refuses anything else; the head check ends a run at a commit that is not `main`'s head before the secret *(true of every step from 2026-10-12, section 15.1; until then `tokens_revoke` received the secret in every case, section 13)* | The branch runs (a) to (f) |
| 9 ✘ session reads it | The search step, with counts only; its positive control needs the plants | The search, the plants, the break copies |
| 10 ✔ probe schema absent | The listing step in each push job, with its printed exclusion list and the control without it (`auth.users` present: yes or no) | The listings of both projects, before the first apply; `devos` also by the builder's read-only connection; T-W03-10's planted (d) and (e) and its widened-list break (section 10.8) |
| 11 | Nothing here | N-099 T-65's line on `plan/work/C09.md`, with the live evidence |
| 12 | Tests merged before this build (CHK-C02-017, CHK-C02-020); the job prints names, versions, counts and statuses only (**limited 2026-10-12, section 10.8:** the report line does; other lines print outputs verbatim) | Each result's envelope and raw output |
| 13 | Class high: the two workflows and the migration need a fresh-context verdict at the head that adds them | That verdict, and the item's |
| 14 order | `test_workflow_order.py` PASS with its 17 copies red (it reads the workflow) | The failing fixture, the second example, the positive control's step times |

## 7. Open, for the executor

1. **P13's result triggers EV-C02-001 section 5's rule** before the first migration merges: decide, by a change to that record judged as any change to it, whether the first-migration exception also takes a history table that holds no version (function absent, listing clean, one snapshot). If it does, T-W03-DEC's E05 and its added cases change first (T-W03-DEC, "Depends on"), then `decide`. **Done 2026-10-12** (section 9.1).
2. **The pooler hosts (P3) are not in the workflow.** *(Done 2026-10-12: found by run 38315433827 and recorded, section 13.)* The first push run finds them without the credential and stops; a class-high change records them, and the next run connects. This adds one class-high merge before the first apply. The alternative, using the host found in the same run, departs from M19's "records it in the workflow" and was not taken.
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
| A program runs with an empty environment and only what it needs; with `# w07-needs-database: yes` among its first ten lines it also gets the step's connection settings in libpq's variables, never on its command line | Each program's environment is built from nothing (the effect of `env -i`): `PATH=/usr/bin:/bin`, `HOME` (a new empty directory for each program) and `LANG=C.UTF-8`. A program whose first ten lines hold that exact line (whitespace stripped) also gets `PGHOST`, `PGPORT`, `PGUSER`, `PGDATABASE`, `PGPASSWORD` and `PGSSLMODE`, the last so that it connects with `require`, as the step does. (2026-10-12, section 11.2: it also gets `PGSSLROOTCERT`, and the mode is `verify-full`, so it authenticates the server as the step does.) The environment is handed to the process directly, not as `NAME=VALUE` arguments of the `env` command, so the password is in no process's arguments. Since a program may need it, `dbprograms` now holds the migration credential in its own `env`; the build's first form kept it out of that step |
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
- **What the apply rule matches (dated 2026-10-12, CHK-C02-035 C4).** In a workflow that names an environment, a step counts as an apply only if its id is `apply` or `dryrun`, or its run text holds the tool's `db push` or `db reset`, `migration up` or `migration repair`, or a `psql` line holding ` -f ` with `migrations` after it on the same line. Nothing else is seen. Two forms pass it in a scheduled job [obs, section 12.5]: a loop `for f in supabase/migrations/*.sql; do psql ... -f "$f"; done` (its `-f` names a variable, and `migrations` comes before `psql`), and `psql ... --file=supabase/migrations/...`. The rule is a second layer behind the class-high review of every workflow change, which the merge gate requires for `.github/workflows/` (`tools/merge_gate.py`); it is not extended form by form [the executor's choice, CHK-C02-035 C4's second option].

**Where these results came from (dated 2026-10-12, CHK-C02-029 condition 3).** Every M22 result in this section and in 11.8 came from the body as extracted (read with PyYAML) and run outside GitHub. At `d4eb7c6` that body held five `${{` sequences and at `ccd92f2` six (count corrected 2026-10-12, CHK-C02-038 F-10), which GitHub evaluates before the program receives the body; GitHub's parser refuses the file at both commits (section 12.1), so on GitHub none of `migration-checks.yml`'s checks would have run on any pull request. Section 12.3 re-runs M22 on the body as GitHub hands it to the runner.

**Self-check.** (2026-10-12, section 11.2: now 31 copies, with server authentication's 13; one copy below adjusted.) Before judging the files, the step makes 18 wrong copies of the files at the pull request's head. Each copy changes one place, and each must fail on its own rule and only on it. A control must pass: `migration-checks.yml` with `workflow_dispatch`, since it names no environment. The new copies are:
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
  - **Residual:** if the tool re-serialises the connection string with another encoding of its user part, that form is not masked. Whether v2.120.0 prints its `--db-url` was not read: could not check. (2026-10-12, section 11.3: this no longer arises; the tool's URL holds no password.)
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
  - **Not changed:** `pr_decide` prints versions taken from the run report, decoded from its JSON, in the pull-request check's log. That job holds no secret. `pr_inputs` still keeps the last report line per project. Both are outside this revision's list. (2026-10-12, section 11.7: both changed.)
- **Security F9.** The checksum line now reads "checksum MISMATCH; the tool is not extracted, and no step that runs it runs", and section 4 has a dated correction. `compare` still runs and holds the credential.
- **Security F10.** EV-C02-001's M21 sentence is corrected by a dated line (see 10.8, acceptance F4, for the residual).
- **Security F12.** The search step's git processes get only `PATH`, `HOME`, `LANG` and `GIT_TERMINAL_PROMPT=0`. None of them needs the credential or the token, since the repository is public; the GitHub API calls stay in the step's own process. [obs] A git wrapper logged the names of 12 git processes. They held no `SUPABASE_DB_PASSWORD` and no `GH_TOKEN`; besides the four given, only `PWD`, `SHLVL` and `_`, which the wrapper's own bash sets.

### 10.9 Pending, not made here

**Made 2026-10-12: section 11** (F5 in 11.1 to 11.5, F6's first half in 11.3, F11 in 11.6). The list below is kept as it was.

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

## 11. Revision for server authentication, the tool's password and the concurrency group (2026-10-12)

Made at the branch head `d4eb7c6` (`main` `9537194` merged in, unchanged) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only, like the rest of this record. It meets the three findings section 10.9 left pending: the security lens's F5 (no connection authenticates the server), F6's first half (the password in the command-line tool's `--db-url`) and F11 (the concurrency group is repository-wide), plus F8's other half (11.7). The design is the executor's; the facts it rests on are the researcher's findings of 2026-10-12, read as a view and checked here where a result depends on them. Files changed: `.github/workflows/migrate.yml`, `.github/workflows/migration-checks.yml`, this record, and dated lines in `evidence/C02/EV-C02-001_migration_path.md`. No test under `tests/` or `supabase/migrations/tests/` changed. Repeated step bodies were changed by a script outside the repository that asserts the number of copies of each; 11.8 shows them identical. Nothing ran against `devos`, `devos-test` or GitHub. The network was used only to fetch the root certificate and the pinned tool's release.

### 11.1 The pinned root certificate (F5)

**The certificate.** The Supabase Root 2021 CA: subject and issuer `C=US, ST=Delware, L=New Castle, O=Supabase Inc, CN=Supabase Root 2021 CA` (self-signed), serial `6CBC4CA1DEB63F692D0A2024C67289C2D13D54F6`, valid 2021-04-28T10:56:53Z to **2031-04-26T10:56:53Z**, basic constraints `CA:TRUE` (critical), key usage Certificate Sign and CRL Sign [obs: `openssl x509 -noout -subject -issuer -dates -serial -ext …`, OpenSSL 3.0.13].

**Its source.**
- Fetched 2026-10-12T20:43:16Z from `https://supabase-downloads.s3-ap-southeast-1.amazonaws.com/prod/ssl/prod-ca-2021.crt`: HTTP 200, 1367 bytes, `Last-Modified: Wed, 28 Apr 2021 11:07:30 GMT` [obs]. The URL is the one the researcher names. Supabase's pages say to download the "server root certificate" `prod-ca-2021.crt` from the dashboard's database settings [doc, the researcher's reading of 2026-10-12, through a summarising fetch]; that the dashboard's button uses this URL is not verified [cnc].
- The SHA-256 of its DER, computed here with `openssl x509 -outform DER | sha256sum`, is `807025ad50d4ed219d2c9c7d299c004f824eb00cf7f65afef607d07b72e6cafa` [obs]. It matches the fingerprint in the task.
- The fetched PEM is byte-identical (`cmp`) to the copy the command-line tool ships at tag v2.120.0 (commit `753520fa`, `apps/cli-go/internal/gen/types/templates/prod-ca-2021.crt`, in the researcher's clone) [obs]. These are two copies from one publisher, not two independent authorities.
- That the pooler's chain ends at this root is a community report (supabase/supabase#50862, the researcher's reading) [doc, not confirmed by Supabase]. It is not observed here: the pooler is not reachable from this environment. The first live run's controls show it (11.5).
- Not pinned: `prod-ca-2025.crt`, which the tool also ships, with the same subject name and another key. The researcher infers it is another product's root [inf]. If the first run's positive control fails with "certificate verify failed", that root is the first thing to check, and adding it is a class-high change [choice: narrower trust].

**In the workflow** [choice where marked].
- `W03_ROOT_CA_PEM` (the PEM) and `W03_ROOT_CA_SHA256` (the pin) are workflow-level `env`, beside `CLI_SHA256`.
- Each job's `env` sets `PGSSLMODE: verify-full` and `PGSSLROOTCERT: /tmp/w03-supabase-root-2021-ca.crt`. The path is a literal [choice]: a job's `env` cannot use the `runner` context [doc, from memory, not re-read here], and a literal lets the job's `env` and M22's rule (11.2) fix the same file. A hosted runner is a new machine for each job [doc, from memory].
- Step `rootca` (four identical copies, before `pooler`, holding no secret) removes any file at that path, then writes it only if the PEM holds exactly one certificate whose DER has the pinned SHA-256. It writes the file from that DER, so the file holds nothing else, and reads it back. On a missing PEM, a second certificate, a mismatch or a bad read-back it prints "server root certificate: could not check (…)", leaves no file, and fails. Every later step that depends on success is then skipped, and with no root file neither libpq nor the tool connects under verify-full (11.5, [obs]).
- **Expiry.** After 2031-04-26 every connection fails verification, so every comparison is "could not check" and nothing applies. The pin must be replaced before then by a class-high change. No step warns ahead of the date (11.9).

### 11.2 verify-full on every connection (F5)

**Every connection the jobs make**, with its settings [obs: the file; M22's rule below]:
- `pooler` (psql to each candidate host, no credential), `tls` (psql, no credential), `connect`, `listing`, `compare` (five copies), `dbtests`, `tokens` and `tokens_revoke` (psql child processes that inherit the step's environment): libpq with the job's `PGSSLMODE=verify-full` and `PGSSLROOTCERT`. No step sets either.
- `dbprograms`: a program that declares the database now also gets `PGSSLROOTCERT`, beside `PGSSLMODE` [obs: the synthetic program's environment names in 11.5].
- `dryrun` and `apply`: the tool gets `--db-url postgresql://<user>@<host>:<port>/<database>?sslmode=verify-full&sslrootcert=/tmp/w03-supabase-root-2021-ca.crt`, and the same two settings in its environment, which it also reads [src: `db-config.parse.ts` 505 to 517; obs: CK2 and CK3 in 11.4].
- `search` connects to no database.
- `compare`'s `if:` (the four `compare` steps; `compare_after` runs only after an apply) now also needs `steps.tls.outputs.controls == 'pass'`. `test_workflow_order.py` still finds `!cancelled()` in it (11.8).

**M22's rule** (`workflow_check`, the same step, before its pass line) [choice: the sibling-step option was not needed]. In a job that names an environment, or whose `env` at any level sets one of libpq's connection variables (`PGHOST`, `PGHOSTADDR`, `PGPASSWORD`, `PGSSLMODE`, `PGSSLROOTCERT`, `PGSERVICE`, `PGSERVICEFILE`):
- every step's effective `PGSSLMODE` (workflow, job and step `env`) must be `verify-full`, and its effective `PGSSLROOTCERT` the pinned file;
- any `sslmode` its run text sets (`sslmode=…`, `PGSSLMODE=…`, a `"sslmode": …` key) must be `verify-full`;
- a root file its run text names other than the pinned one is allowed only in a step whose `env` names no secret. That is control (a)'s run-time root in step `tls`; a copy that gives `tls` the secret is refused;
- its run text removes neither `PGSSLMODE` nor `PGSSLROOTCERT` from the environment (`unset`, `env -u`, `--unset`, `.pop(…)`, `del …[…]`), since libpq's default (`prefer`) would then apply, and the downgrade run in 11.5 shows that `prefer` does not check the name;
- no libpq service is set (`PGSERVICE`, `PGSERVICEFILE` or `service=`), since a service file can set `sslmode` or the root file over the environment [inf: libpq's order of defaults, not re-read here].

A job that neither names an environment nor sets a libpq variable is not judged. It holds no migration credential: there is no repository secret (M02).

**Its wrong copies.** Thirteen copies were added to the self-check's eighteen, each failing on its own rule: `devos-test` with `sslmode` `require`; `devos` without `PGSSLMODE` (libpq's default, `prefer`); `check-devos-test` with `verify-ca`; `devos`'s `compare` overriding `sslmode`; `check-devos` without a root file; `devos-test` with `system`; `devos`'s dry-run URL with `require`; `devos-test`'s `connect` setting `PGSSLMODE` in its run text; `devos`'s `connect` removing `PGSSLMODE` with `env -u`; `devos-test`'s apply URL naming another root file; `devos`'s `tls` holding the secret beside its run-time root; a libpq service file; and a workflow naming no environment that sets libpq's variables with `require`. One existing copy was adjusted, not loosened: "a second workflow naming `migrate-devos`" now gives its job the pinned settings, so that it still fails only on "only migrate.yml may", its own rule. Before the adjustment it also broke the new rule, and the self-check reported it as not failing on its own rule alone.

**Limits.** The rule reads the files' text. A value built at run time (for example `"ssl" + "mode"`) is not seen. A test program under `supabase/migrations/tests/` may connect however its own text says. For both, the class-high review is the layer. On files that already break the new rule, the copy that adds a step to `check-devos-test` also reports the new rule for the added step, so the self-check counts it as not shown; the verdict there is FAIL in any case.

**Its reach (dated 2026-10-12, CHK-C02-035 C3).** The rule catches only the literal forms listed above: an effective `PGSSLMODE` or `PGSSLROOTCERT` in a step's `env` (workflow, job and step); `sslmode=`, `PGSSLMODE=` or a `"sslmode":` key in run text set to anything but `verify-full`; another root file named in the run text of a step that holds a secret; `unset` with that variable as its first name, `env -u`, `--unset`, `.pop(` or `del …[` of either variable; and a libpq service. Ordinary literal forms that are not on that list pass it. Each of these five passes in a job that names an environment [obs, section 12.5]:
- (a) `unset PGAPPNAME PGSSLMODE` (another name before `PGSSLMODE`);
- (b) `env -i PATH=... PGHOST=... PGPASSWORD=... psql`, which runs psql with no `PGSSLMODE`;
- (c) `dbprograms`' `DB_VARS` without `PGSSLMODE` and `PGSSLROOTCERT`;
- (d) `os.environ["PGSSLMODE"] = "disable"` in a Python body;
- (e) a libpq URI `...?sslmode=verify-full&ssl=true`, where the later `ssl=true` downgrades the mode (CHK-C02-035 F3 observed psql 16.15 connect that way without the root file).

Step `tls`'s run-time controls (11.5) test only the job-level settings, in that step's own environment, so they do not see a change made in another step. The rule is therefore a second layer behind the class-high review of every workflow change, which the merge gate requires for `.github/workflows/`; it is not extended form by form [the executor's choice, CHK-C02-035 C3's option (ii)]. The earlier sentence here, that a value built at run time is the rule's limit, understated it.

### 11.3 The password only through the environment (F6, first half)

- `dryrun` and `apply` now hold the secret as `PGPASSWORD` in their `env`, in place of `SUPABASE_DB_PASSWORD`. The URL they build holds no password. The tool reads `PGPASSWORD` when the URL has none [src: `db-config.parse.ts` 248 to 268; obs: CPw in 11.4, where with no password anywhere it fails with "client password must be a string"].
- **Shown.** A thread read every process's `/proc/<pid>/cmdline` every 3 ms while each case ran, and searched it for the synthetic password, plain and percent-encoded. No command line held it, in any case of 11.4 or 11.5 [obs]. Sensitivity control: with the build's earlier form (the password percent-encoded in `--db-url`, case COld), the same monitor found it in the tool's command line [obs].
- The tool's process tree during `db push` held only `supabase`, with no `supabase-go` or `psql` child [obs], so no child receives the password in its arguments.
- Unchanged: `presence` and `search` hold `SUPABASE_DB_PASSWORD` in their `env`. The first masks its percent-encoded form, and the second counts matches in its own process. Neither passes it as an argument. The tokens stay out of command lines (`\getenv`, section 10.8).
- Section 10.8's residual, a connection string re-serialised by the tool in another encoding, no longer arises: no URL holds the password. The percent-encoded mask is kept; it costs nothing.

### 11.4 Offline evidence: libpq and the tool against a chain like the pooler's

**The harness** (scratch directory outside the clone; stopped and deleted at the end):
- A throwaway PostgreSQL 16.15 cluster on 127.0.0.1, TLS on, sending a leaf and its intermediate. Login by `scram-sha-256` as a synthetic role `postgres.qwertyuiopasdfghjklz`, with a synthetic password. psql 16.15 with OpenSSL 3.0.13, the versions the runner image lists [doc, the researcher's reading of the runner-images readme].
- **A chain made here to mimic the reported one.** A self-signed root with `CA:TRUE` and key usage Certificate Sign and CRL Sign, as the real root has; an intermediate with `CA:TRUE` and **no key usage extension**; a wildcard leaf `*.pooler.w03.test`. `openssl verify` accepts the chain, while `openssl verify -x509_strict` gives "error 92 at 1 depth lookup: CA cert does not include key usage extension" [obs]. That is the failure #50862 reports for the real chain, so the mimic carries the property in question. The leaf's other extensions (key usage, extended key usage `serverAuth`) are a guess: the real leaf's were not seen [cnc].
- **The tool.** Supabase CLI v2.120.0, downloaded 2026-10-12T20:43:30Z from the URL in the workflow. Its SHA-256 is `7074584113aa…dc6e`, the workflow's pin [obs]. Its `supabase` binary is Bun v1.4.2, with BoringSSL vendored, and links no `libssl` (`ldd`) [obs], so the runner runs the same TLS code [inf].
- The tool cannot take `hostaddr` [src: `db-config.parse.ts` 718 to 719]. Its cases ran in a private mount namespace (`unshare -m`) whose `/etc/hosts` maps the synthetic names to 127.0.0.1. The system's `/etc/hosts` was not changed.

| Case | psql (libpq 16.15, OpenSSL 3.0.13) | The tool (v2.120.0, `db push --dry-run`) |
|---|---|---|
| verify-full, the right root, a name the leaf covers | connects; `select 1` gives `1` (P1) | connects: "Would push these migrations" (CP); the apply itself also applied the fixture (CA) |
| verify-full, a root made at run time | refused: "SSL error: certificate verify failed" (Na) | refused: "tls error (unable to get local issuer certificate)" (CNa) |
| verify-full, the right root, a name the leaf does not cover | refused: `server certificate for "*.pooler.w03.test" does not match host name "w03-name-mismatch.invalid"` (Nb, by `hostaddr`) | refused: "Hostname/IP does not match certificate's altnames" for `other.example.w03.test` (CNb) and `localhost` (CNb2) |
| `pooler.w03.test` and `a.b.pooler.w03.test` (the wildcard covers one label) | refused, name mismatch (Nb2, Nb3) | not run |
| the root file missing | refused before the handshake: "root certificate file … does not exist" (Nc) | refused: "failed to read sslrootcert …: ENOENT" (CNc) |
| the root file holds the intermediate only | refused: "certificate verify failed" (Nd) | refused: "unable to get issuer certificate" (CNd) |
| `sslrootcert=system` | refused: "certificate verify failed" (K3) | not run |
| **control:** `require`, no root file, a wrong name (the build's setting until now) | **connects** (K1) | **connects** (CK1) |
| `verify-ca`, the right root, a wrong name | **connects** (K2): only verify-full checks the name | not run |
| verify-full through the environment only (a bare URL) | (the same as above) | the right root connects (CK2); a run-time root is refused (CK3) |

**The key question.** Both libpq 16.15 (OpenSSL 3.0.13) and the tool (Bun's BoringSSL) accept, under verify-full, a chain whose intermediate has no key usage extension [obs, on the mimic]. So the design's "cannot work as written" case did not arise. On the real chain this is [cnc] until the first run's positive control and dry run.

**The password was never sent to a server it did not authenticate.** The server's log holds no "password authentication failed" for the refused cases. Their handshakes end there as "could not accept SSL connection: tlsv1 alert unknown ca" or "EOF detected" [obs].

### 11.5 The first-run controls in each job

**Step `tls`** (four identical copies, after `pooler` and before `presence`, so before any step that holds the credential connects). It holds no secret: `PGPASSWORD` is removed and psql runs with `-w`, so a control that wrongly connects reaches at most the server's password request. Each control keeps the job's own `PGSSLMODE` and root file but for the one part it changes:
- (a) a root made at run time (`openssl req -x509`, P-256) in place of the pinned one. It must be refused with "certificate verify failed".
- (b) the host name `w03-name-mismatch.invalid` at the pooler's own IPv4 address (`hostaddr`). It must be refused with "does not match host name".

Each prints one line, `server authentication, negative control (a|b), …: pass (refused: …)` or `FAIL (…)`, with psql's message escaped and no secret. If either is not refused for its reason, the step prints "server authentication: could not check: server authentication not shown", removes the root file, writes `controls=fail` and fails. The apply then does not run (implicit `success()`), `compare` is skipped by its `if:`, and with no root file nothing can connect. **Corrected 2026-10-12 (CHK-C02-035 C5): that last clause is false.** Removing the root file stops a connection only under `verify-full` or `verify-ca`. Under `require`, `prefer` or an unset mode, the modes the controls detect, psql connects without the file and does not verify the server (CHK-C02-035 F5, observed on PostgreSQL 16.15). What keeps later steps from connecting is each step's implicit `success()` (`presence`, `connect`, `listing`, `dryrun`, `apply`; `dbtests` and `tokens` hang on `compare`, `compare_after` on an apply that ran; `tokens_revoke` connects only to revoke tokens that `tokens` wrote, and otherwise prints "none to revoke"; `search` connects to no database), `compare`'s `steps.tls.outputs.controls == 'pass'` term, and the tool's own URL, which carries `sslmode=verify-full` and refuses a missing root file.

**The positive control is `connect`** (four copies): verify-full with the pinned root and the credential, `select 1`. It prints `server authentication, positive control (…): pass` or `FAIL`; on a failure also "server authentication: could not check: server authentication not shown; the apply does not run", and it fails. The line "connection: succeeded/failed" that Batu's step text names is kept.

**Run here [obs].** The job's own step bodies, read from the clone and run in job order as `bash --noprofile --norc -eo pipefail`, against the harness of 11.4. Each step got its `env` from the YAML with its expressions filled in. A private namespace gave `/tmp` as a private tmpfs, so the job's own root path was used unchanged. The only overrides were the pooler host, port, user and database, and in the scenarios the PEM and the pin.

| Scenario | What the steps did |
|---|---|
| Positive: the synthetic root and its pin | `rootca` wrote the file ("matches the pin"); `tls`: (a) pass, (b) pass, `controls=pass`; `connect` "connection: succeeded" and the positive control's pass; `listing` 2 objects; `dryrun` pending `["20261012999902"]`; `apply` exit 0; `compare` connected (`call=not_called`, no function in the harness); `dbprograms`: the declaring program's environment held `PGSSLMODE` and `PGSSLROOTCERT`, and its own psql connected under verify-full |
| The pin does not match the PEM | `rootca`: "could not check: the SHA-256 of its DER is …, not the pin 807025ad…"; no file. Run anyway to show the backstop: `connect` refused ("root certificate file … does not exist"), and the dry run refused ("failed to read sslrootcert") |
| The PEM holds two certificates | `rootca`: "could not check (the PEM does not hold exactly one certificate)"; no file; `connect` and the dry run refused as above |
| The real Supabase root against the synthetic server | `rootca` wrote it ("807025ad… matches the pin"); `tls`: (a) pass, (b) FAIL ("certificate verify failed", not the name); the root file was removed; `connect` refused. A server that does not chain to the pinned root stops the job |
| A downgrade: the job's `PGSSLMODE` set to `require` | `tls`: (a) pass (libpq verifies the chain when a root file exists), (b) FAIL: it reached "fe_sendauth: no password supplied", so the name was not checked; `controls=fail`; the file was removed |
| A downgrade: no `PGSSLMODE` in the job (libpq's `prefer`) | the same as `require`: (a) pass, (b) FAIL; `controls=fail` |

The monitor of 11.3 found the password in no command line in any scenario. At the pull request, M22 refuses both downgrades before any run (11.2).

**Live only.**
- Whether the pooler presents the reported chain, and whether control (b) gets the same certificate when it sends a wrong name as SNI. If the pooler refused an unknown SNI, (b) would fail for another reason, and the job would stop with that reason in its line [inf].
- The libpq version actually linked on the runner [cnc].
- The tool is not put through the negative controls in the live run [choice]. The same binary, with its TLS statically linked, was shown here to refuse both cases, and its first connection, the dry run, is its positive control.

### 11.6 The concurrency group (F11)

**The change.** The workflow-level group is now `devos-migrate.yml-migrate-devos-test-migrate-devos`: it names this workflow file and the two environments it serves. `cancel-in-progress: false` and `queue: max` are kept. It stays one group at workflow level [choice]: M06's reasons hold (one `db push` at a time, and no scheduled comparison during an apply), and per-job groups would let one run's `devos-test` overlap another run's `devos`.

**Residual.**
- Groups are repository-wide and shared across workflows [doc, the researcher's reading of GitHub's workflow syntax and concurrency pages, 2026-10-12, through a summarising fetch]. A unique name only stops accidental collisions.
- A workflow on any branch that names this group can hold it, which delays a pending migrate run. With the default queue it can cancel the pending run. With `cancel-in-progress: true` it can cancel a running one, apply included [doc, same reading; the last is the researcher's inference].
- Who can push such a workflow: anyone who can push a branch with a workflow file to `devos`, that is, Batu as the owner, and a session or App whose GitHub credential may write workflow files (P8, not yet settled; the guard allows GitHub writes on `devos`, N-257). Whether a fork's pull-request run shares the group namespace is not documented [cnc]; such runs from first-time contributors wait for approval [doc, from memory].
- Holding or cancelling the group can delay an apply, or stop it part-way. It cannot change what an apply applies. A run applies only `main`'s files at `main`'s head (M05, M08). Each migration file runs in its own batch [src, section 5, P13], so a stop between files leaves the earlier ones applied. The next run's comparison sees what was applied, and the next push run applies the rest.
- M22 does not look for the group name in other workflows. A branch run needs no pull request, so M22 would not see it anyway.

### 11.7 Security F8's other half

- **`pr_decide`** now escapes control characters in what it prints and writes: the differences' kinds and versions, the report's commit, and the paths in its verdict. [obs] With a report holding the version `2026⏎::add-mask::forged`, the base commit's body printed two log lines (the second a bare workflow command) and wrote three output lines. The clone's body printed `on_main_not_applied 2026\n::add-mask::forged` on one line and wrote two output lines. `test_decision_steps.py` passes unchanged (11.8).
- **`pr_inputs`** reads a project only from its own job (`devos-test` or `check-devos-test`; `devos` or `check-devos`), and only if that job's log holds exactly one report line, for that project, at the run's commit. Otherwise the project is left out, which `pr_decide` reads as "could not check", and a line says why. Exactly one is right because the `report` step prints one line per job, and every other line a job prints from data is escaped, except the test programs' own output in `devos-test`. A second line therefore means a forged or broken log; it never replaces the first.
- [obs] Both bodies ran against a stub of the REST API on 127.0.0.1, in a scratch git repository; nothing reached GitHub.

| Logs | Base commit | Clone |
|---|---|---|
| One line per job, for its own project | both projects read | both read |
| `devos`'s log also holds a forged `devos-test` line ("no difference") | `devos-test` read as "no difference": the forged line replaced the real "differences" | "job devos: 2 report lines, not exactly one …; devos is not read (could not check)"; `devos-test` read from its own job, "differences" |
| `devos-test`'s log holds two `devos-test` lines (a test program printed one) | the later, forged line read | "job devos-test: 2 report lines …; devos-test is not read (could not check)" |

### 11.8 Outputs of the checks run for this revision

The final lines, verbatim, from the clone's working tree:
- `python3 -I tests/C02/W-C02-03/test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0. `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`, exit 0.
- `python3 -I tests/C02/W-C02-03/test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies red ("the copy fails, as it must"), `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0. `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`, exit 0.
- **M22** (its own body, run on the clone): 31 lines "fails on its own rule, as it must" (18 earlier copies, 13 new), `workflow check: self-check control: migration-checks.yml on workflow_dispatch (it names no environment): passes, as it must`, `workflow check: pass`, exit 0. **Dated 2026-10-12 (CHK-C02-029 condition 3):** this result, and the next line's, came from the body as extracted and run outside GitHub; GitHub would have refused the file at `d4eb7c6` and at `ccd92f2`, so on GitHub M22 would not have run at all (section 10.5's dated line; section 12).
- **M22 on wrong copies written to disk** (the real check, not its self-check), each `workflow check: FAIL`, exit 1: the base commit's own `migrate.yml` (`sslmode 'require', not verify-full` and `root file None, not the pinned one …` for every step); one job back on `require`; the dry-run and apply URLs on `require` ("its run text sets sslmode 'require'"); the root file set to `system`; `connect` with `PGSSLMODE=prefer` in its run text; `connect` with `env -u PGSSLMODE` ("its run text removes PGSSLMODE from the environment"); a workflow naming no environment whose job sets `PGHOST` and `PGSSLMODE: require`. The clone as it is: `workflow check: pass`, exit 0.
- **The repeated bodies** (section 10.10's method: SHA-256 of `run` + "|" + `shell`, first 12 hex digits). Every repeated id is identical across its copies:
  - new: `rootca` ×4 `277fdf1bf7a4`, `tls` ×4 `4054ed494664`;
  - changed: `connect` ×4 `2cf8fbc28d78`, `dryrun` ×2 `117defd57d50`, `apply` ×2 `1dcb025e4aee`, `dbprograms` ×1 `3fb2926de0d8`;
  - unchanged since 10.10: `compare` ×5 `1260def3e0a4`, `head` `8da1cee258f9`, `workdir` `39a09b6a79ce`, `pooler` `3886dddb628d`, `presence` `81c784e3f1f1`, `report` `ae92c5b56744`, `cli` `9a997b75cce6`, `listing` `b1b058f32c88`, `search` `af60920e3ead`, `decide` `e4e381332519`.
- **The SQL tests** were not re-run: `compare`'s body and the migration are unchanged (`1260def3e0a4`, as in 10.10), and so are the tests.
- `python3 -I tools/credential_value_scan.py --repo . --dir .github --dir supabase --dir evidence/C02`: repository 8621 objects, `.github` 2 files, `supabase` 3, `evidence/C02` 54; each value searched "0 … hold it"; `CREDENTIAL_VALUE_SCAN DONE`, exit 0. It was run before this line was written and again after. The synthetic password of 11.4 is in no file of the clone (`git grep` and `grep -r` over `.github`, `evidence` and `supabase`: no match).
- `python3 -B tools/records.py render --check`: `DISCIPLINES OK: 138 of 138 log entries from L-159 on carry the nine answers`, `RENDER OK`, exit 0. `bash tools/check_service_names.sh`: `SERVICE_NAMES CLEAN (pattern derived from 3cd686a; 12 terms)`, exit 0. Both were run again after this record's last edit.

### 11.9 What is still open

1. **Live only:** the pooler's real chain and its acceptance by the runner's libpq (the positive control) and by the tool (the dry run); control (b)'s behaviour with a wrong SNI; the runner's libpq version (11.5).
2. **The root expires on 2031-04-26.** Replacing the pin before then is a class-high change; nothing reminds anyone. A dated note is proposed to the executor.
3. **`prod-ca-2025.crt`** is not pinned (11.1).
4. **The concurrency residual** (11.6) stays. Only who may push workflow files bounds it.
5. **M22's rule reads text** (11.2, "Limits").
6. **Guard denial #20600, rule G0.** A shell form that ran psql through `env "$@"` was refused as unreadable. The same cases were written as a Python script with explicit environments (`psql_cases.py`); the denied form was not pursued.

## 12. Revision after CHK-C02-029 and CHK-C02-035 (2026-10-12)

Made at the branch head `1903b77` (the two verdicts filed; `main` `a091ea3` merged in at `5cad061`, touching none of the build's files) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only. Its inputs are CHK-C02-029 (FAIL: conditions 1 to 4; F-2, F-3) and CHK-C02-035 (FAIL: C1 to C5), both at `5cad061`. Files changed: `.github/workflows/migration-checks.yml` (`workflow_check`'s literals, `pr_inputs`' diff), `.github/workflows/migrate.yml` (step `pooler`, four identical copies), this record (this section; dated lines in sections 1, 10.5, 11.2, 11.5 and 11.8; `main_at`; a source line), and two dated lines of `evidence/C02/EV-C02-001_migration_path.md` (:125, :213). No test, SQL file or plan file changed. Nothing ran against `devos`, `devos-test` or GitHub; the network was used only to fetch the two parsers below. The scripts named here are in the producer's scratch directory, outside the repository.

### 12.1 The cause, as a class (CHK-C02-029 conditions 1 to 3; CHK-C02-035 C1)

**The cause.** GitHub reads every `${{ … }}` in a `run:` value as an expression and evaluates it before the runner receives the body. `workflow_check`'s Python body held six such sequences inside string literals: one from fix 2 (`d4eb7c6`) at :74, four self-check `if:` values at :263 to :269, and from `ccd92f2` the self-check value at :303. **Why it was missed:** every M22 run, the producers' and the lenses', executed the body as PyYAML extracts it, outside GitHub. No check read the files with GitHub's own parser, and `test_decision_steps.py` refuses `${{` only in `decide` and `pr_decide`.

**The change.** The body defines `OPEN = "$" + "{{"` (`migration-checks.yml`:54), with a comment that names the rule without the sequence. The six literals are built from it: :78 `c.startswith(OPEN)`, and :267, :269, :271, :273 and :307 `OPEN + " … }}"`. Nothing else in the body changed (a `diff` of the old and new bodies shows only those lines and the four added ones).
- [obs] Each new literal evaluates at run time to exactly the old text: 6 of 6 equal, in order (`literals_equal.py`). Among them are `${{ github.event_name == 'push' || github.event_name == 'schedule' }}` and `${{ secrets.SUPABASE_DB_PASSWORD }}`.
- [obs] Break: a copy with `OPEN = "$" + "[["` gives `workflow check: could not check`, exit 3, because `devos-test`'s and `devos`'s `if:` are no longer read as the push event alone. (A copy with `"$" + "{"` still passes, since `push_alone` slices a fixed three characters; so that copy is not a break.)

**(a) The scan** (`scan_expr.py`, PyYAML, every `run:` value in both files) [obs]:
```
.github/workflows/migrate.yml: 53 run: values; with '${{': 0
.github/workflows/migration-checks.yml: 4 run: values; with '${{': 0
TOTAL run: values holding '${{': 0
```
At `5cad061` the same scan finds `migration-checks.yml`'s six lines, and no line of `migrate.yml`.

**(b) GitHub's workflow parser** [obs]. `@actions/workflow-parser` 0.3.61 from npm, integrity `sha512-NBjJrbwwrEN3LSN0NAISLpCWQLcPSBjmAIkLXHgjGX8Yql4PiD33ifSAvr9sIMU9uIs8wZiGUnvo9yPIMIfKdg==`, which is the registry's `dist.integrity`. It was installed with `npm install --ignore-scripts --save-exact` in a directory of its own, and it pulls in `@actions/expressions` 0.3.61, `yaml` 2.9.1 and `cronstrue` 2.59.0. It is the TypeScript parser of GitHub's `actions/languageservices`. The command was `node --import register.mjs wp_check.mjs validate .github/workflows/migrate.yml .github/workflows/migration-checks.yml`; it calls `parseWorkflow`, then `convertWorkflowTemplate`, and prints every error. `register.mjs` gives the package's own schema import the JSON attribute that Node 22 requires. Raw output at this revision:
```
.github/workflows/migrate.yml: 0 errors (parseWorkflow 0, convertWorkflowTemplate 0)
.github/workflows/migration-checks.yml: 0 errors (parseWorkflow 0, convertWorkflowTemplate 0)
```
Control, the same command on `migration-checks.yml` as it was at each commit:
- `eddab74` and `762640d`: 0 errors.
- `d4eb7c6`, `ccd92f2` and `5cad061`, each:
```
(Line: 31, Col: 14): Unexpected symbol: '"'. Located at position 1 within expression: ") and c.endswith("
(Line: 31, Col: 14): Unrecognized function: 'cancelled'
```

**actionlint** 1.7.12: the release asset `actionlint_1.7.12_linux_amd64.tar.gz`, SHA-256 `8aca8db96f1b94770f1b0d72b6dddcb1ebb8123cb3712530b08cc387b349a3d8`, equal to the entry in the release's `actionlint_1.7.12_checksums.txt` (`sha256sum --check`: OK). Both files come from the same release, so they are one source. Command: `actionlint -no-color -shellcheck= -pyflakes= .github/workflows/migrate.yml .github/workflows/migration-checks.yml` (no shellcheck or pyflakes is installed here). Raw output at this revision, exit 1:
```
.github/workflows/migrate.yml:25:3: unexpected key "queue" for "concurrency" section. expected one of "cancel-in-progress", "group" [syntax-check]
   |
25 |   queue: max
   |   ^~~~~~
```
- GitHub's own parser accepts `queue`: its schema defines `concurrency-queue` with the allowed values `single` and `max`, and its converter reads it [src: `workflow-v1.0.min.json`, `model/converter/concurrency.js`]. So this report is actionlint's schema lagging, not a defect of the file.
- With that one message ignored (`-ignore 'unexpected key "queue" for "concurrency" section'`), exit 0.
- Before the change, actionlint also reported `migration-checks.yml:31:2937: got unexpected character '"' while lexing expression …`.

**(c) M22 on the body as GitHub hands it to the runner** [obs].
- `wp_check.mjs runs` writes each step's `run:` value from the parser's converted template. A literal token is written as it is. An expression token is evaluated in a `pull_request` context with no secret.
- All 57 `run:` values of the two files are literal tokens, so GitHub hands each to the runner verbatim, with nothing to substitute. All 57 are byte-identical to PyYAML's (`cmp_handed.py`), and `workflow_check`'s body hashes the same both ways (SHA-256 `07cd69b4680f9713…`).
- M22's body as handed, run with `python3 -I` from the clone's root, exit 0. Its output: 31 lines "workflow check: self-check: …: fails on its own rule, as it must", then
```
workflow check: self-check control: migration-checks.yml on workflow_dispatch (it names no environment): passes, as it must
workflow check: workflows naming an environment: .github/workflows/migrate.yml
workflow check: pass
```
- The extracted body gives the identical output (`cmp`).
- The harness's substitution path, shown on a copy whose `w03_tests` line holds `${{ github.event_name }}` and `${{ secrets.SUPABASE_DB_PASSWORD }}`: that token is an expression, and the handed text holds `event pull_request, secret []`; only that line differs.
- The package builds a multi-line value's `format(…)` from the indented YAML source (`template-reader.js` 340 to 343), so the harness strips the common indentation before writing.
- A copy that keeps the four evaluable old literals, and fixes only :74 and :269, parses with 0 errors. But its body becomes one `format(…)` expression of 21994 characters, and `@actions/expressions` refuses any expression over 21000 (`MAX_EXPRESSION_LENGTH`) [src]. On GitHub that step would then fail [inf: the runner's own limit was not read]. CHK-C02-035's simulation, which assumed the expression evaluated, gave "could not check". Neither is a pass.

**The dated lines.** Section 1 (row 2), section 10.5 and section 11.8 now say that their M22 results came from the extracted body, and that GitHub would have refused the file at `d4eb7c6` and `ccd92f2`.

### 12.2 Other constructs GitHub treats differently from a local run (asked of this revision)

| Construct | Found | What it means |
|---|---|---|
| `${{` in a `run:` value, a heredoc included | none in either file (12.1 (a)) | Each body runs as written |
| `if:` | 57 in `migrate.yml`, 3 in `migration-checks.yml`. Each is one whole `${{ … }}` expression (`yaml_cmp.py`), so none is a format string with text around it, which GitHub reads as always true | GitHub evaluates them; the parser accepts each, and status functions are allowed there only. Control: a made-up `if: ${{ a }} && ${{ b }}` is flagged |
| `env:` and job `outputs:` with expressions | `migrate.yml` 111 and 1; `migration-checks.yml` 4 | GitHub evaluates them. The parser checks their syntax and the contexts allowed at each level (0 errors). Their values are live only; the local runs filled them in (11.5) |
| `name:`, `concurrency.group` | no expression | Read as written |
| YAML anchors, aliases, merge keys, tags | none | — |
| YAML 1.1 (PyYAML, used by M22 and the tests) against YAML 1.2 (`yaml` 2.9.1, used by GitHub's parser) | 0 differences in either file, apart from the `on` key, which PyYAML reads as `True` and M22 handles (`yaml_cmp.py`) | M22 and the tests see the files as GitHub does. Control: a made-up file with `yes`, `0755` and `1:20` gives 3 differences |
| `shell: python` | `workflow_check`, `pr_inputs`, `pr_decide`; `decide` in `migrate.yml` | GitHub runs `python {0}` [doc, from memory, not re-read; observed 2026-10-12 in run 38313767819, `shell: /usr/bin/python {0}`, with PyYAML present, section 12.9]; the local runs used `python3` 3.13 with PyYAML 6.0.1. Whether the runner's `python` has PyYAML is live only. Without it M22 prints "could not check" and exits 3 |
| `queue: max` | `migrate.yml`:25 | GitHub's parser accepts it; actionlint 1.7.12 does not know it (12.1 (b)) |
| A future `${{` added to `workflow_check`'s body | — | Its `format(…)` would exceed 21000 characters, so it would fail rather than be substituted quietly (12.1 (c)) |
| `migrate.yml` on a pull request | not started by `pull_request` | GitHub's own server does not read it at the pull request. Its 0 errors are the TypeScript parser's, until a push reads it |

### 12.3 Quoted file names (CHK-C02-035 C2)

**The change** (`migration-checks.yml`:379 to :401, :463).
- `pr_inputs` runs `git diff -z --name-status -M HEAD^1 HEAD`, splits its bytes on NUL and decodes them with `surrogateescape`. With `-z`, git gives every path verbatim and never quotes one.
- Each entry must be one of the status letters `A C D M R T`, followed by its path (two paths for `R` and `C`), none empty. Anything else is "could not be read (git diff's output does not parse)".
- **A second fail-open, found here:** a diff that failed left `changed` as `[]`, which `pr_decide` read as "no merged migration is changed, removed or renamed", a pass. Now a failed or unparsable diff writes `changed` empty, which `pr_decide` reads as "the list of changed files could not be read (could not check)", a fail.
- `pr_decide` is unchanged (`89b2b4fc25cc`).

**[obs] The cases** (`c2_cases.py`). `pr_inputs`' and `pr_decide`'s own bodies ran in a scratch git repository against a stub of the REST API on 127.0.0.1. The stub's run report shows every version applied in both projects ("no difference") unless the case says otherwise.

| Case | Without `-z` git prints | This revision | Old body (`5cad061`) |
|---|---|---|---|
| **C2's case:** `20261012000000_café.sql` modified, applied in both | `M	"supabase/migrations/20261012000000_caf\303\251.sql"` | **fail**: "a merged migration is changed, removed or renamed and the records do not show it unapplied in both projects: supabase/migrations/20261012000000_café.sql" | pass |
| a name holding a tab, a quote and a backslash, modified | `M	"supabase/migrations/20261012000002_a\tb\"c\\d.sql"` | fail | pass |
| the café file removed | quoted | fail | pass |
| the café file renamed | quoted old path | fail | pass |
| control: a plain-named file modified | unquoted | fail | fail |
| positive control: `20261012000003_thé.sql` added | quoted | pass | pass |
| positive control: the café file modified, shown unapplied in both (`on_main_not_applied`) | quoted | pass | pass |
| `git diff` fails (no parent commit) | — | fail: "could not be read (git diff failed)" | pass |

Final line, this revision: `C2 CASES PASS (8/8)`. Old body: `C2 CASES FAIL (3/8)`. A permanent case in `test_decision_steps.py` is the test designer's (12.8).

### 12.4 The pooler step's answers (CHK-C02-029 F-2)

**The change** (`migrate.yml`, step `pooler`, four identical copies, `817ff6d76f8e`).
- The loop also records each candidate's host, exit code and psql message, NUL-separated, in a file under the runner's temporary directory.
- A Python heredoc then prints each distinct answer once, with how many candidates gave it and the first that did. The host and its address are replaced, and control characters are escaped. The step holds no secret, as before.
- What it finds and its exit 1 are unchanged.

[obs] `pooler_case.py` ran the step's body, read from `migrate.yml`, under `bash --noprofile --norc -eo pipefail`. The environment was verify-full with a synthetic trusted root, and a minimal PostgreSQL-protocol TLS stub answered on loopback addresses. Its output:
```
pooler host (P3): not recorded in the workflow; looking for it without the credential
pooler host (P3): 1 candidate(s) answered, the first w03-no-such-name.invalid: exit 2: psql: error: could not translate host name "<host>" to address: Name or service not known
pooler host (P3): 1 candidate(s) answered, the first 127.0.0.6: exit 2: psql: error: connection to server at "<host>", port 37315 failed: Connection refused Is the server running on that host and accepting TCP/IP connections?
pooler host (P3): 1 candidate(s) answered, the first 127.0.0.2: exit 2: psql: error: connection to server at "<host>", port 37315 failed: FATAL: Tenant or user not found
pooler host (P3): 2 candidate(s) answered, the first 127.0.0.3: exit 2: psql: error: connection to server at "<host>", port 37315 failed: SSL error: certificate verify failed
pooler host (P3): 1 candidate(s) answered, the first 127.0.0.8: exit 2: psql: error: connection to server at "<host>", port 37315 failed: FATAL: forged\x1b[31m ::error::forged line
pooler host (P3): 1 candidate(s) answered, the first 127.0.0.4: exit 2: psql: error: connection to server at "<host>", port 37315 failed: fe_sendauth: no password supplied
pooler host (P3): found 127.0.0.4; it is not used until it is recorded in the workflow (EV-C02-001 M19)
```
The step exited 1, with `host=` empty. So a first run that finds none can tell a chain that does not verify against the pinned root from no region matching. A server message holding an escape character and a newline before `::error::` printed on one prefixed line, escaped. The stub's GSS request was refused, and `PGGSSENCMODE=disable` was set; the runner sets neither.

### 12.5 M22's reach: the forms that pass its TLS and apply rules (CHK-C02-035 C3, C4)

[obs] `m22_reach.py` made disk copies of the clone's two files, each with one edit, and ran M22's handed body in each copy:

| Copy | Result |
|---|---|
| C3 (a): `connect` runs `unset PGAPPNAME PGSSLMODE` first | `workflow check: pass`, exit 0 |
| C3 (b): `connect`'s psql under `env -i PATH=… PGHOST=… PGPASSWORD=…`, no `PGSSLMODE` | pass, 0 |
| C3 (c): `dbprograms`' `DB_VARS` without `PGSSLMODE` and `PGSSLROOTCERT` | pass, 0 |
| C3 (d): `tokens`' Python sets `os.environ["PGSSLMODE"] = "disable"` | pass, 0 |
| C3 (e): the listing's psql given `postgresql://h/postgres?sslmode=verify-full&ssl=true` | pass, 0 |
| control: `connect` runs `unset PGSSLMODE` | FAIL, 1: "its run text removes PGSSLMODE from the environment" |
| C4: a step in `check-devos-test` holding `PGPASSWORD`: `for f in supabase/migrations/*.sql; do psql … -f "$f"; done` | pass, 0 |
| C4: the same step, `psql -X -v ON_ERROR_STOP=1 --file=supabase/migrations/x.sql` | pass, 0 |
| control: the same step, `psql … -f supabase/migrations/x.sql` | FAIL, 1: "step 'x' applies, outside the push jobs" |

The rules are kept as they are. Sections 11.2 ("Its reach") and 10.5 ("What the apply rule matches") and EV-C02-001:125 now state what each matches, name these forms as passing it, and name the class-high review as the layer in front of it [the executor's choice: option (ii) for C3, the records option for C4].

### 12.6 The record's lines (CHK-C02-035 C5; CHK-C02-029 F-3)

- **11.5** (C5): "with no root file nothing can connect" is marked false where it stands, with what stops later steps instead: each step's implicit `success()`, `compare`'s `controls == 'pass'` term, and the tool's URL with `sslmode=verify-full`. [obs, this revision] After `tls` in each of the four jobs, every step that holds the secret has an `if:` with no status function, except four:
- `compare` needs `controls == 'pass'`;
- `compare_after` (job `devos`) needs an `apply` that was not skipped;
- `tokens_revoke` (`always()`, job `devos-test`) connects only if `tokens`' file exists, and otherwise prints "none to revoke" *(2026-10-12, section 15.1: its condition is now `always()` and the head check's yes)* *(corrected 2026-10-13, section 15.9: its condition is now `always()`, the head check's yes and `steps.tokens.outcome != 'skipped'`, so it runs, and holds the secret, only when `tokens` ran)*;
- `search` (the scheduled jobs) connects to no database (11.2).
- **`main_at`** (F-3) is now `a091ea3`, the `main` merged at `5cad061`. That merge touched none of the build's files (`git diff ccd92f2 5cad061` over `.github`, `supabase`, EV-C02-001, this record, `tests/C02/W-C02-03` and `W-C02-03.md`: empty).
- **EV-C02-001:213** (F-3): the sentence "Its password part is that masked percent-encoded value" is marked stale from `ccd92f2`, since no connection string holds the password.
- **Left, not this producer's:** CHK-C02-029 F-4, the "Depends on" text of `tests/C02/W-C02-03/T-W03-DEC_decision_steps.md`. The test designer corrects it.

### 12.7 Outputs of the checks run for this revision

The final lines, verbatim, from the clone's working tree:
- `python3 -I tests/C02/W-C02-03/test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0. `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`, exit 0.
- `python3 -I tests/C02/W-C02-03/test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies red, `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0. `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`, exit 0.
- **M22**, extracted and as handed: identical outputs. Each has 31 lines "fails on its own rule, as it must", the control "passes, as it must", and `workflow check: pass`, exit 0 (12.1 (c)).
- **The repeated bodies** (SHA-256 of `run` + "|" + `shell`, 12 hex digits). Every repeated id is identical across its copies:
  - changed: `pooler` ×4 `817ff6d76f8e`;
  - unchanged since 11.8: `compare` ×5 `1260def3e0a4`, `head` `8da1cee258f9`, `workdir` `39a09b6a79ce`, `rootca` `277fdf1bf7a4`, `tls` `4054ed494664`, `presence` `81c784e3f1f1`, `connect` `2cf8fbc28d78`, `report` `ae92c5b56744` (×4 each), `cli` `9a997b75cce6`, `listing` `b1b058f32c88`, `dryrun` `117defd57d50`, `apply` `1dcb025e4aee`, `search` `af60920e3ead` (×2 each), `decide` `e4e381332519`, `dbprograms` `3fb2926de0d8`.
  - `migration-checks.yml`: `workflow_check` `a7268e7a127e` (was `22ce6eefcb29`), `pr_inputs` `1a4c390ad8ed` (was `1f9e7111a78a`), `pr_decide` `89b2b4fc25cc` and `w03_tests` `68490ed29189` unchanged.
- **The SQL tests** were not re-run: no SQL file changed, and `compare` is unchanged (`1260def3e0a4`), as are the tests.
- `credential_value_scan.py`, `records.py render --check` and `check_service_names.sh`: their final lines are in the producer's report to the executor, run after this record's last edit.

### 12.8 What only GitHub's own run shows, and what stays open

1. **The pull request's own `migration-checks` run** is the platform's reading; everything above is offline. The executor reads that run's log. It must show four things. The workflow loads and its job starts. `workflow_check` prints the 31 lines, the control and `workflow check: pass`; this also shows that the runner's `python` has PyYAML. `pr_inputs` and `pr_decide` run. `migrate.yml` is not on `main`, so `pr_inputs` prints "run report: none …" or, if the API answers 404 for the unknown workflow, "run report: could not be read (HTTPError)" [inf]; either way both projects read "could not check". Since this pull request only adds `20261012184638_deployment_drift.sql` (status `A`), the verdict is "pass: no merged migration is changed, removed or renamed". `w03_tests` passes. If that log cannot be read, the result is "could not check", never a pass (CHK-C02-035 C1).
2. **This head needs a fresh-context checker's verdict** (CHK-C02-029 condition 4): `migration-checks.yml` and `migrate.yml` are class high.
3. **No repeatable check holds the class.** Nothing in the repository refuses a `${{` in a `run:` value or runs GitHub's parser; this revision's scan and parser runs are one-off. Adding a rule to M22 or a case to the tests is not asked of this revision. It is the executor's or the test designer's to decide.
4. **The C2 case as a test.** 12.3's cases are the producer's runs. A case in `test_decision_steps.py`, or a test of `pr_inputs`, is the test designer's.
5. **CHK-C02-029 F-4** stays with the test designer (12.6).
6. **Section 11.9's items** stand.

### 12.9 GitHub's own run on the pull request (added 2026-10-12, CHK-C02-038 F-10)

GitHub ran `migration-checks.yml` on pull request #304 at its head `786025782c71938807387ef955012462616ee2c6`: run 38313767819, job 115025415496 ("migration checks (M15, M16, M22)"), 2026-10-12T21:56:56Z to 21:57:05Z, conclusion success. The runner checked out `0a7e0fe`, GitHub's merge of `7860257` into `76d0454`. The log, read by the executor through GitHub's job-log tool and kept unedited outside the repository (1036 lines), shows each thing 12.8 item 1 asked: the workflow loads and its job starts; `shell: /usr/bin/python {0}` with PyYAML present; `workflow_check` prints 31 lines "fails on its own rule, as it must", the control "passes, as it must", and `workflow check: pass` (these 34 lines are byte-identical to the local run, CHK-C02-038 F-3); `pr_inputs` prints "run report: could not be read (HTTPError)" and `pr_decide` reads both projects "could not check" and gives "pr check: pass: no merged migration is changed, removed or renamed"; `w03_tests` gives `W03_DECISION_TEST PASS (69/69)` and `W03_ORDER_TEST PASS`. CHK-C02-038 (PASS, no conditions) judged the head with this log. What stays live-only is section 6's list, 11.9's items, the pooler hosts (item 2 of the list under section 1's "What stays open"), and GitHub's server reading `migrate.yml`, which happens first at the push that merges it.

## 13. The first push run, and the pooler hosts recorded (2026-10-12)

**Run 38315433827** (`migrate.yml`, event `push`, commit `9798946bd471ea7013915fb98540ed2a20693f72`, the merge of pull request #304; 2026-10-12T22:13:47Z). GitHub's server read `migrate.yml` and started it, so the file loads there too (section 12.2's last row). Both jobs that connect ran as designed for a workflow with no pooler host recorded: the head check answered yes; the command-line tool v2.120.0 was installed with its checksum matching; the expected list read one migration on `main` (`20261012184638`); the pinned root's DER hash matched the pin and the file was written; then the pooler step looked for the host without the credential and stopped the job (exit 1), so nothing after it connected and no step used the secret (`credential_present` "none"): the secret reached only the environment of step `tokens_revoke`, which runs in every case (devos-test job log, `PGPASSWORD: ***`), printed "synthetic tokens: none to revoke" and connected nowhere *(corrected 2026-10-12, CHK-C02-039 C1 (c))*, and each job's report says "could not check" with no apply (`devos-test`: `go` no; `devos`: `apply` no, its decide step giving "the three reads are not usable (FM_READS is absent)"). The two comparison-only jobs were skipped (they run on the schedule). The job logs were read through GitHub's job-log tool (jobs 115030812999 and 115030886777) and kept unedited outside the repository; the tool returns a log's tail, and the `devos` job's saved log starts mid-checkout, so its head-check line is not in it (its report shows `head` yes) *(added 2026-10-12, CHK-C02-039 F-12)*.

**What the pooler step found.** For both projects, the first candidate, `aws-0-us-east-1.pooler.supabase.com`, answered: `psql` under `sslmode=verify-full` with the pinned root reached the server's password request and stopped there ("fe_sendauth: no password supplied"). Under `verify-full`, libpq completes the TLS handshake, with the chain and the host name verified, before it sends anything the server answers with a password request: section 11.4 observed a run-time root, a name mismatch and a missing root each refused at the handshake, with no password request reaching the server. So a password request means the pooler's chain verified against the pinned Supabase Root 2021 CA. That the pooler holds this project's tenant is weaker: each project stopped at the first of the 34 candidates, so no real pooler was seen answering "Tenant or user not found", and the reading rests on [Inf] that the pooler looks up the tenant before it asks for a password *(added 2026-10-12, CHK-C02-039 C1 (b))*. Whether the tenant is the right one shows only at the next run, which connects with the password: a wrong host gives "could not check" at `connect`, and nothing applies.

**The record** (M19's "records it in the workflow"): `POOLER_HOST` is set to `aws-0-us-east-1.pooler.supabase.com` in the four jobs that name each project (`devos-test`, `devos`, and the two comparison-only jobs). This is the one class-high merge before the first apply that section 7's "Open, for the executor" item 2 foresaw. The next push run, the one this change's merge starts, tries what only it can show: step `tls`'s negative controls (a) and (b) against the real pooler for the first time (control (b) sends the name `w03-name-mismatch.invalid` at the pooler's address, and how the pooler's front end meets an unknown name is unobserved), then the positive control (`connect`) with the password, which shows whether the tenant is right, then the listing, the dry run and the apply. Any of them can stop that run, and each stop is "could not check" with no apply *(corrected 2026-10-12, CHK-C02-039 C1 (a); the first version said "The next push run ... connects")*.

## 15. Revision H1-prime: `tokens_revoke` only after the head check's yes, the plant's print step, and the plants made last (H1 2026-10-12; H1-prime 2026-10-13)

**Numbering.** This section was section 14 on the first H1 branch (`claude/c02-w03-live-h1`, head `1fa178d`). On `main`, section 14 is H0's (the run report, pull request #310), which was 14.14 on that branch. Records made before H1-prime (CHK-C02-043, -044 and -045, FR-07 and its inputs, the ledger) cite this section as 14: their 14.1 to 14.12 are 15.1 to 15.12 here, and their 14.13 is rewritten as 15.13. The comments of `migrate.yml` that name "EV-C02-007 section 14", "section 14.6" and "section 14.12" (lines 64, 2617, 2620, 2755, 3353 and 3356) mean this section, 15.6 and 15.12; they are left as they are, because this build changes only `W03_FIXTURE_ISSUE` in `migrate.yml` and the search body's text is part of its hash.

**H1-prime** (FR-07, "The order that follows"). It keeps H1's workflow parts 1 to 3 (15.1 to 15.12, cherry-picked unchanged) and its test revisions, and adds, by FR-07 item 2's sequence: `W03_FIXTURE_ISSUE` set to `308` with `W03_PLANT_B64` still empty; 15.13 (the plants, made last by the executor, named by their tag only); 15.14 (the facts the executor fixed for this revision); 15.15 (the rehearsal, a workflow that is never merged and is kept outside this repository until the executor places it on its own branch); 15.16 (the outputs of the checks). Made at `main` `6807099` (branch `claude/c02-w03-h1p`, head `376a123`) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3). The test designer revises T-W03-09 after reading this build; the plants come last.

**H1, as first made (2026-10-12).** Made at `main` `d33c8e9` (branch `claude/c02-w03-live-h1`) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only. Its inputs are the executor's two decisions for the first class-high change of the live campaign (C1 and C3 of the researcher's plan of 2026-10-12, parts 2 and 4, a hint), section 13, T-W03-08 (line 26, attempt (e)) and T-W03-09 (plant p4, "exactly one"). Files changed: `.github/workflows/migrate.yml` and this record (this section; dated pointers in sections 3, 6 and 12.6; `main_at`; a source line). `migration-checks.yml`, the tests, the SQL files and every other step body are unchanged. Nothing ran against `devos`, `devos-test` or GitHub; the network was used only to install the parser (15.4). The scripts named here are in the producer's scratch directory, outside the repository.

### 15.1 `tokens_revoke` only after a yes from the head check (C1)

**The change** (`migrate.yml`:884 to :888, job `devos-test`, the only job with the step): `if: ${{ always() && steps.head.outputs.head == 'yes' }}`, was `${{ always() }}`, with a two-line comment and a name that says so. The body is unchanged (`8117e8de0831`). `always()` stays because tokens are issued only by `tokens`, which runs only after a yes (its condition reads `dbtests`' outcome); after a yes, `tokens_revoke` still runs whatever fails or is cancelled later. `go` reads `REVOKED` only when the head check said yes; otherwise `go` is the head state, as before. After a yes, the step still receives the secret in every case, including when no token was issued: in section 13's run the head check said yes, the pooler step stopped the job, and the step printed "none to revoke" and connected nowhere. That stays so. A narrower condition, also requiring `steps.tokens.outcome != 'skipped'`, is not the executor's decision and was not made (15.5 item 5). *(2026-10-12: made on the executor's decision, section 15.9; after a yes the step now gets the secret only when `tokens` ran.)*

**What holds a secret.** A step whose `env` names `secrets.*` or `github.token`, and `checkout`, whose `token` input defaults to `github.token` [doc recalled from `actions/checkout`'s `action.yml`, not re-read here]. Per job: `devos-test` `checkout presence connect listing dryrun apply compare dbtests tokens dbprograms tokens_revoke`; `devos` `checkout presence connect listing compare dryrun apply compare_after`; `check-devos-test` and `check-devos` `checkout presence connect compare search`. No workflow or job `env` holds one. Each of these steps has the term `steps.head.outputs.head == 'yes'` in its condition (with `&&`, no `||`), or a condition on a step that has it: `dbtests` on `compare`'s output; `tokens` and `dbprograms` on `dbtests`' outcome; `compare_after` on `apply`'s outcome. A skipped step has no outputs and the outcome `skipped`.

**[obs] The gate as GitHub decides it** (`gate_sim.mjs`). Each step's condition is taken from GitHub's own converter (`@actions/workflow-parser` 0.3.61, which adds the implicit `success() && (…)`) and evaluated by `@actions/expressions`' own `Evaluator`, with `success()`, `failure()`, `cancelled()` and `always()` as the runner defines them for steps. The steps are walked in order. Every step that runs is branched into success and failure, and every output a later condition reads is given, for a step that ran, the value that condition asks for. Scenarios, in each of the four jobs: the head check's output `superseded`, `unknown` or none; the head step succeeding or failing; no cancellation, a cancellation at the start, or one before any later step; `W03_PLANT_B64` set or empty. Result: 144 scenarios, and in none does a step that holds a secret run on any path (`GATE: no step that holds a secret runs unless the head check answered yes`, exit 0).
- Break: the same program on `migrate.yml` at `d33c8e9` gives `GATE: FAIL (36)`, every one `tokens_revoke`, in all 36 scenarios of `devos-test`. A copy with the head term removed from `search` gives `GATE: FAIL (48)`, every one `search`.
- Positive control: with a yes and every step succeeding, every step listed above runs. With a yes, every outcome of every step and a cancellation before any step: 1812 paths; `tokens` ran in 112, and `tokens_revoke` ran after it in all 112 (64 in which `dbprograms` also ran, 48 with a failure or a cancellation between them).

**[obs] The bodies, run** (`mini_run.mjs`). The same walk, with the bodies of `tokens`, `tokens_revoke` and `go` run as GitHub's `shell: bash` runs them (`bash --noprofile --norc -e -o pipefail FILE`). Their `env` comes from the workflow, the job and the step, with the expressions evaluated and the secret a stand-in. A stand-in `psql` first on `PATH` connects nowhere and records each call with whether `PGPASSWORD` reached it; the other steps are stand-ins with given outcomes. The runner's own head step was not run (its body is unchanged, `8da1cee258f9`, and section 13 observed it).

| Scenario (`devos-test`) | `tokens_revoke` | stand-in `psql` calls | `go` line |
|---|---|---|---|
| head `superseded`, a tokens file already in `RUNNER_TEMP` | skipped | 0 | `devos-test go=superseded (… revocation=skipped)` |
| head `unknown`, the same file | skipped | 0 | `devos-test go=unknown (…)` |
| head `yes`; `tokens` issued 6 + 1, the revoked token revoked; `dbprograms` failed | ran: "already revoked before the programs", then 6 lines "revoked" | 14, each `PGPASSWORD present: yes; PGSSLMODE verify-full` | `go=no (… programs=failure revocation=success)` |
| head `yes`; cancelled before `dbprograms` | ran, the same 7 lines | 14 | `go=no (… programs=skipped revocation=success)` |
| break: the first row on `d33c8e9`'s file | **ran**, the secret in its env | 1, `PGPASSWORD present: yes` | `go=superseded (… revocation=success)` |

**Not a repeatable check.** M22 does not read step conditions, and the two runs above are one-off. A rule asking for the head term directly in every secret-holding step would conflict with T-W03-14's rule that `dbtests`' condition is the clean comparison "alone". So a repeatable form would reason over the dependencies, as `gate_sim.mjs` does. Whether to add one is the executor's or the test designer's to decide (as 12.8 item 3).

### 15.2 The plant's print step (C3; T-W03-09 p4)

**The step** (`migrate.yml`:2711 to :2740): `plant`, the last step of `check-devos-test` and of no other job, `if: ${{ always() && env.W03_PLANT_B64 != '' }}`, `shell: bash` with a `python3 -I` heredoc, no `env` of its own, so no secret (15.1's list). It decodes `W03_PLANT_B64` strictly (base64 with `validate=True`, then ASCII). The value must match `w03-fixture/plant\+value@([0-9]{8}T[0-9]{4}Z)=x` in full, and the tag must be a real UTC time (`%Y%m%dT%H%MZ`). If so, it prints exactly one line, `synthetic plant (T-W03-09 p4; made up for that test, not a credential): <value>`. Anything else gives `synthetic plant (T-W03-09 p4): could not check: … nothing of it is printed` and exit 1. Being last, its failure changes no other step. Body hash `b049a11f5998`. `W03_PLANT_B64` and `W03_FIXTURE_ISSUE` are still `""`; line 64 gained a comment only, and the header (lines 4 to 6) names the step.
- Its text holds no whole plant: the form is a regular expression, and the refusal names the tag only as `YYYYMMDDTHHMMZ`. So neither the workflow file nor the script that a log header echoes can match a planted value. M22's rules pass on it (15.4); it holds no `db push`, `sslmode` or service text.

**[obs] Its body, run** under `bash --noprofile --norc -e -o pipefail` with only `PATH`, `LANG` and `W03_PLANT_B64`:

| `W03_PLANT_B64` decodes to | Exit | Lines printed | Plain plant in them |
|---|---|---|---|
| `w03-fixture/plant+value@20000101T0000Z=x` (a stand-in; its tag is a time no plant will have, so this record can never count as a plant in the current trees) | 0 | 1, the labelled line | 1 |
| its percent-encoded form; tag `20001301T0000Z`; tag `2000-01-01T00:00Z`; the plant then a newline and `x`; the plant then ` extra`; a tag in Arabic-Indic digits; text that is not base64; the empty string; `Sup3r-s3cret!` | 1 each | 1, the "could not check" line | 0 |

In its job (`mini_run.mjs`): with the head check `superseded` and the variable set, it runs and prints the line once; with a yes and the variable empty, as on `main`, it is skipped; with a yes, `search` failed and the variable set, it runs and prints once. In each case it holds no secret.

**Why this job** [choice]. The alternative weighed was the push job `devos-test`. There, the merge that sets `W03_PLANT_B64` prints the line in its own push run, the next scheduled run can count 1 (0 to 6 hours later), and a failed search can be repeated at the next slot. But every push to `main` before the search completes adds a print, so every merge, the campaign's fixtures included, would wait for that whole window. And the step would sit in the job that applies migrations. In `check-devos-test`, merges do not change the count, and the push jobs change only by 15.1's condition. The cost is one more slot of the schedule and no repeat at the same tag (15.3). If the shorter wait matters more, moving the step is a class-high change.

### 15.3 How the printed line meets the search's count

[src: the search's body, `migrate.yml`:2520 and :2613 to :2633, and its copy in `check-devos`, :3226 and :3319 to :3339]. The search lists the 100 latest runs of `migrate.yml` and drops its own run by ID. In every remaining run's log archive it counts the needle in every file. A run whose archive cannot be read (for example one still queued or in progress) becomes a gap, and the logs place is then "could not check". Let S1, S2, … be the scheduled runs, in order, whose commit holds `W03_PLANT_B64` set and whose `check-devos-test` starts. A scheduled run created before the setting merge keeps its older commit, even if it starts later. Let f be the number of files in one run's archive that hold a printed line.
- **The same run.** Each of S1, S2, … prints the line once, in `check-devos-test`. Neither job's search in that run counts it, because both drop their own run. So the run that searches may also print without changing its own count.
- **Earlier runs.** The search of Sk counts (k − 1) × f in "logs of migrate.yml's earlier runs", plain form, and 0 in the percent form. Push runs never print, because `check-devos-test` runs on the schedule only. So merges do not change the count.
- **The search run is therefore S2.** S1 prints; its own logs place counts 0 and reads "could not check" (S1 is not the search run). S2 counts 1 per job if f = 1. The other plants (p1, p2, p3, p5) must exist before S2 starts.
- **Later runs.** S3 would count 2, S4 3, and so on, while the variable stays set. So the change that empties `W03_PLANT_B64` (class high) merges after S2's search and before S3 starts. After it, the plant is no longer a needle. A later round has a new tag, which these lines never match. If S2 cannot serve (its head check not yes, a run in progress while it reads the logs, an archive not read), S3 counts 2, and the round is made again with a new tag and a new `W03_PLANT_B64`. S1's and S2's lines stay in their logs until the executor deletes those logs or GitHub's retention does [doc recalled, not read]. Do not re-run S1 or S2: which attempt's logs the archive endpoint returns was not read. *(2026-10-12, section 15.6: the retention, 90 days by default, and the archive of a partially re-run run, which holds only the re-run jobs, are now read in GitHub's documentation.)*
- **Other places.** While the variable is set, GitHub's log header lists every step's environment, the base64 value included. Base64 holds neither `@` nor `%`, so it matches neither form. The same is true of the workflow file in the current trees. A copy of S1's or S2's raw log committed to any branch before S2's search would add to the repository places, so raw logs enter the repository only after that search.
- **f [cnc].** It was not read here whether the archive holds each job's log once, or also each step's log in a file of its own. The search counts every file. If both, one printed line counts 2, and no single print can meet T-W03-09's "exactly one". The executor can settle f before planting, read-only, by listing the file names of one existing run's archive (for example run 38315433827). If f = 2, the criterion is the test designer's to settle before S2, fixed before the result is seen. *(2026-10-12, section 15.7: the search now counts each run's log once, so f = 1 whether the archive holds top-level job files, files in folders, or both; the documentation read does not state the layout.)*
- **The run window** [src, :2616 to :2631]. The search reads one page of 100 runs, its own included. But it counts as "earlier runs" GitHub's `total_count` of all runs of `migrate.yml`, less its own run. So once the workflow has more than 100 runs, `read < total` in every search, the logs place is a gap ("logs: N earlier runs not read"), and T-W03-09's logs place can only read "could not check". Every push to `main` and every scheduled run adds one. So S2 must come while `migrate.yml` has at most 100 runs, S2 included [inf from the source; GitHub's `total_count` semantics recalled, not re-read]. That limit is the search's own; it is not changed here (15.5 item 6). *(2026-10-12, section 15.8: the search now reads every page of the run list up to 4 pages of 100, so S2 must come while `migrate.yml` has at most 400 runs, S2 included.)*
- **Time** (plan 6.12 item 1). With the schedule `41 */6 * * *`, S2 starts 6 to 12 hours after the setting merge, plus GitHub's delay of scheduled runs; the source is this workflow, as merged. Merges are free in that window except in the minutes around S2's start and its search (a push before its head check supersedes it; a run in progress while it reads the logs leaves a gap). Those minutes are needed by any search run.

### 15.4 Outputs of the checks run for this revision

From the clone's working tree:
- **GitHub's workflow parser**, `@actions/workflow-parser` 0.3.61, installed 2026-10-12T23:19:53Z with `npm install --ignore-scripts --save-exact` in a directory of its own. Its integrity `sha512-NBjJrbww…IfKdg==` is section 12's; it pulls in `@actions/expressions` 0.3.61, `yaml` 2.9.1 and `cronstrue` 2.59.0. Section 12's `wp_check.mjs validate`: `migrate.yml: 0 errors (parseWorkflow 0, convertWorkflowTemplate 0)` and the same for `migration-checks.yml`, exit 0. Controls, one token changed each: `envx.W03_PLANT_B64` in the plant's condition gives `(Line: 2713, Col: 13): Unrecognized named-value: 'envx'`; `alway()` in `tokens_revoke`'s gives `(Line: 888, Col: 13): Unrecognized function: 'alway'`; exit 1.
- **As handed to the runner** (`wp_check.mjs runs`, `cmp_handed.py`): every `run:` value is a literal token, 54 in `migrate.yml` and 4 in `migration-checks.yml`, each byte-identical to PyYAML's.
- **`${{` in a `run:` value**: `migrate.yml: 54 run: values; with '${{': 0`; `migration-checks.yml: 4 run: values; with '${{': 0`.
- **M22**, `workflow_check`'s handed body run with `python3 -I` from the clone's root: 31 lines "fails on its own rule, as it must", then `workflow check: self-check control: … passes, as it must`, `workflow check: workflows naming an environment: .github/workflows/migrate.yml`, `workflow check: pass`, exit 0. The extracted body gives an identical output (`cmp`). M22 needed no new rule or copy (15.1, "Not a repeatable check").
- `python3 -I tests/C02/W-C02-03/test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0. `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`, exit 0.
- `python3 -I tests/C02/W-C02-03/test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies "the copy fails, as it must", `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0. `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`, exit 0.
- **The repeated bodies** (SHA-256 of `run` + "|" + `shell`, 12 hex digits): identical to 12.7's, every repeated id identical across its copies (`head`, `workdir`, `rootca`, `pooler`, `tls`, `presence`, `connect`, `compare`, `report` ×4; `cli`, `listing`, `dryrun`, `apply`, `search` ×2). `tokens_revoke` `8117e8de0831` is unchanged. One new body: `plant` `b049a11f5998` (×1). `migration-checks.yml`'s four are unchanged.
- `records.py render --check`, `check_service_names.sh` and `git status --short`: their final lines are in the producer's report to the executor, run after this record's last edit.

### 15.5 What only a live run shows, and what stays open

1. **The gate on GitHub.** A push run whose head check is not yes must show `tokens_revoke` skipped, and no `PGPASSWORD: ***` or `SUPABASE_DB_PASSWORD: ***` line in any step's environment listing in its `devos-test` and `devos` logs. T-W03-08 (e) shows this only on a run started at or after this change's merge: a re-run uses the workflow file of the run's own commit [doc recalled, not re-read; the researcher's C1]. At an older run, `tokens_revoke` still receives the secret, as in section 13.
2. **The plant.** It must show S1's line once in `check-devos-test`'s log, and S2's count per job and place: f, and whether S2 can serve.
3. **The class** of a secret-holding step outside the head gate has no repeatable check (15.1).
4. **T-W03-09's "removed after it" for p4.** Emptying the variable stops new lines; the lines already in S1's and S2's logs stay, unless the executor deletes those logs.
5. **After a yes, `tokens_revoke` holds the secret even when `tokens` never ran** (15.1). Adding `&& steps.tokens.outcome != 'skipped'` would narrow that. `tokens` runs only after `dbtests` succeeded, and a `tokens` stopped by a cancellation has an outcome other than `skipped` [doc recalled, not re-read]. This is the executor's to decide; it was not made here. *(2026-10-12: made, section 15.9.)*
6. **The search's run window** (15.3): beyond 100 runs of `migrate.yml`, its logs place is "could not check" in every run. That bounds when T-W03-09 can be observed. Changing it (paging, or counting only the runs listed) is a change of the search step, class high, and outside this revision. *(2026-10-12: changed to every page up to 400 runs, section 15.8; the new limit is 15.11 item 3.)*

### 15.6 Part 2 of H1, and what GitHub's documentation says about the log archive (2026-10-12)

Made on the same branch at `3c80bf1` (part 1) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only, on the executor's three decisions (a hint): count each run's log once (15.7), read every page of the run list with a bound (15.8), and run `tokens_revoke` only when `tokens` ran (15.9). They answer 15.3's f and run window and 15.5's items 5 and 6. Files changed: `.github/workflows/migrate.yml` (the two `search` copies, identically, and `tokens_revoke`'s condition, comment and name) and this section (15.6 to 15.11, and dated notes in 15.1, 15.3 and 15.5). `migration-checks.yml`, the tests, the SQL files and every other step body are unchanged. Line numbers in 15.1 to 15.5 are those of `3c80bf1`. From this revision, `tokens_revoke` is at :884 to :923, the two `search` copies at :2503 to :2693 and :3232 to :3422 (their logs part at :2614 to :2657 and :3343 to :3386), and `plant` at :2735 to :2764. Nothing ran against `devos`, `devos-test` or GitHub's API; the network was used only to read GitHub's documentation, below. The scripts named here are in the producer's scratch directory, outside the repository.

**GitHub's documentation** [doc; read 2026-10-12, 23:35Z to 23:39Z, through docs.github.com's article endpoint, which returns a page's text]:
- https://docs.github.com/en/rest/actions/workflow-runs, "Download workflow run logs" (`GET /repos/{owner}/{repo}/actions/runs/{run_id}/logs`): "Gets a redirect URL to download an archive of log files for a workflow run. This link expires after 1 minute." Status 302. "Download workflow run attempt logs" (`…/attempts/{attempt_number}/logs`) gives "an archive of log files for a specific workflow run attempt".
- https://docs.github.com/en/actions/how-tos/monitor-workflows/use-workflow-run-logs, "Downloading logs": "When you download the log archive for a workflow that was partially re-run, the archive only includes the jobs that were re-run. To get a complete set of logs for jobs that were run from a workflow, you must download the log archives for the previous run attempts that ran the other jobs."
- **The layout [cnc].** None of these pages says which files the archive holds or how they are named, and a search of docs.github.com (queries "log archive", "download log archive zip", "logs zip step") found no page that does. GitHub's changelog search returned its latest entries rather than matches, so the changelog was not read. That an archive holds each job's whole log as a top-level file and each step's log in a folder per job stays recalled, not documented in what was read. The change in 15.7 is built not to depend on it.
- For 15.8: https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api: "The rate limit for `GITHUB_TOKEN` is 1,000 requests per hour per repository." https://docs.github.com/en/rest/using-the-rest-api/using-pagination-in-the-rest-api: "For most endpoints, the maximum value of `per_page` is `100`." The REST page's "List workflow runs for a workflow": `per_page` "(max 100)", `page` "Default: `1`", and `total_count` a required integer of the response.
- For 15.9: https://docs.github.com/en/actions/reference/workflows-and-actions/contexts, `steps.<step_id>.outcome`: "Possible values are `success`, `failure`, `cancelled`, or `skipped`."
- For 15.3 and 15.11: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository: "By default, checks, workflow runs, commit statuses, and the artifacts and log files generated by workflows are retained for 90 days before they are automatically deleted." Its note: "Starting October 1, 2026, these policies will apply to checks, workflow runs, and commit statuses in addition to artifacts and logs." For a public repository the period can be set "anywhere between 1 day or 90 days".

### 15.7 Each run's log counted once (decision 1)

**The change** (`search`, logs part, both copies identically). The archive's names, less folder entries (`ZipInfo.is_dir()`), are split into top-level names (no "/") and names in folders. The top-level files are counted when there is at least one; the files in folders only when there is none. Each run read prints one line: `logs: run <id>: counted its top-level files (<n> top-level, <m> in folders)`, or `files in folders`, or `archive, which holds no file`. The line carries the run's ID and two counts, never a name or content. [src]

**[obs] Run against a stand-in API** (`search_run.py`). The body is taken as GitHub's parser hands it to the runner (`check-devos-test`'s copy; the two copies are byte-identical) and run with `python3`, as `shell: python` runs it. Its environment: `PATH`, `HOME`, `LANG`, the `GITHUB_*` variables, a stand-in token, a made-up stand-in credential, `W03_PLANT_B64` (the stand-in plant of 15.2, tag `20000101T0000Z`) and `W03_FIXTURE_ISSUE` 7. No proxy is set. The API is a local server on 127.0.0.1, and the mirror clone goes to a local stand-in repository (p1 in its tree, p2 in its history) through a `git` wrapper that rewrites `https://github.com/`. The server serves issue #6, the fixture issue #7 (p3 plain, p5 percent-encoded), the run list in pages, and each run's archive through a 302 to a separate download URL, as GitHub does. Each archive has two jobs (`check-devos-test`, `check-devos`), each with its step logs and a header listing `W03_PLANT_B64` in base64; a planted run prints the plant once, in `check-devos-test`'s plant step. Each case's expected result was written in its scenario file before it ran.

| Case | Archive | New body: logs place, plant plain / percent | Per-run lines | Old body (`3c80bf1`) |
|---|---|---|---|---|
| L1 | each job's log top-level only | 1 / 0 | 3 × top-level files (2, 0) | 1 |
| L2 | top-level files, and step files in folders with their folder entries | 1 / 0 | 3 × top-level files (2, 11) | **2** |
| L3 | step files in folders only | 1 / 0 | 3 × files in folders (0, 11) | 1 |
| C1 | as L2; the stand-in credential printed once | credential 1 / 1, `FOUND (2 matches)`, exit 1 | as L2 | credential 2 / 2, `FOUND (4 matches)` |
| M1 | mixed: `check-devos-test` in folders only, `check-devos` top-level only | **0** / 0; logs "could not check (the plant was not found …)" | 3 × top-level files (1, 6) | 1 |

In L1 to L3 all five places are backed (`search: none found by that method in: repository: history; repository: current trees; issue #6; issue #7; logs of migrate.yml's earlier runs`); in C1 the search stops with FOUND, as it must. The stand-in credential has no character that percent-encoding changes, so its two forms are the same bytes and each counts 1. The expectation written before C1 ran ("FOUND (1 matches)") overlooked that: it was wrong about the sum over the two forms, not about the count per form. No download request carried the token (0 with an Authorization header, in every case).

**The residual (M1).** If an archive holds some jobs only as top-level files and others only in folders, the folder-only jobs are not counted. For the plant this fails safe: the logs place reads "could not check". A credential printed only in such a job would not be counted. The per-run line shows such an archive (here 1 top-level file for a run of two jobs). Pairing each top-level file with its job's folder by name would close it, but it rests on GitHub's naming, which was not read; it was not made (15.11 item 2). *(2026-10-13, section 15.12: closed for the credential, which is now counted in every file of each archive; for the plant the rule and its fail-safe residual are kept.)*

### 15.8 Every page of the run list (decision 2)

**The change** (same part, both copies). Pages of 100 (`per_page=100&page=N`) are read until a page holds fewer than 100 runs, or the run IDs seen reach `total_count` (the largest any page gave), up to `LOG_PAGES = 4` pages. Runs are de-duplicated by ID: a run created while the list is read pushes the later pages down by one, so an entry can come twice. If the 4th page is full and more remain, the gap "logs: the run list is longer than 4 pages of 100; the runs past them were not read" makes the logs place "could not check". The comparison of the runs read with `total_count` less the searching run is kept, so a listed run that cannot be read, or a run never seen, is still a gap. [src]

**The bound [choice]** is 4 pages: 400 runs, the searching run included. Both scheduled jobs search in the same run, each with up to 4 list pages, 399 archive requests and 4 issue requests: about 814 requests in all, under the documented 1,000 an hour per repository for `GITHUB_TOKEN` (15.6), with room for the pull-request checks' few. The download from the redirect target is not a REST request [inf]. If the limit is reached anyway, a request fails, that run is "not read", and the place reads "could not check" [src]. That 399 downloads fit in a job's 30 minutes is [inf], not measured on GitHub. A higher bound raises both risks; a lower one brings 15.11 item 3 sooner.

**[obs] Run against the stand-in**, as in 15.7, with L2's layout:

| Case | Runs listed | New body | Old body |
|---|---|---|---|
| P1 | 250 earlier runs and this one (3 pages); the plant in earlier run 230, on page 3 | pages 1, 2, 3; `logs: 250 of 250 earlier runs of migrate.yml read`; plant 1; no logs gap; all five places backed | `logs: 99 of 250 …`; plant 0; logs "could not check" |
| P2 | 450 earlier runs (5 pages); the plant on page 2 | pages 1 to 4 only; `399 of 450 …`; the gaps "longer than 4 pages of 100" and "51 earlier runs not read"; plant 1; logs "could not check" | not run |
| P3 | 399 earlier runs, 400 with this one (exactly 4 full pages); the plant in the last | pages 1 to 4; `399 of 399 …`; no bound gap; plant 1 | not run |
| P4 | 250 earlier runs; a run created after page 1 is served, so page 2 repeats earlier run 98, which printed the plant | pages 1, 2, 3; plant 1 (the repeated entry read once); `250 of 251 …`; gap "1 earlier runs not read" (the new run was never listed) | not run |

With a logs gap, the final lines list the logs place both among "none found by that method in" and in "0 matches, but could not check" (P2, P4). That wording is the search's as before; it is not changed here (15.11 item 4).

### 15.9 `tokens_revoke` only when `tokens` ran (decision 3)

**The change** (`migrate.yml`:884 to :889): `if: ${{ always() && steps.head.outputs.head == 'yes' && steps.tokens.outcome != 'skipped' }}`, with the comment and the name saying so. The body is unchanged (`8117e8de0831`). A step's outcome is `success`, `failure`, `cancelled` or `skipped` (15.6), so the step now runs after `tokens` succeeded, failed or was cancelled, and not when `tokens` never ran and so issued no token. `go` is unchanged in every case: `go=yes` needs `REVOKED` = `success` and `PROGRAMS` = `success`, and `dbprograms` runs only after `tokens` succeeded. So `revocation=skipped` after a yes comes only with a `go` that is already `no`. [src]

**[obs] The gate as GitHub decides it** (`gate_sim2.mjs`: 15.1's program with one addition, that with a late cancellation a step that runs can also end `cancelled`, and the job is cancelled from then on):
- Head check not yes, the four jobs: 144 scenarios; no step that holds a secret runs on any path (`GATE: no step that holds a secret runs unless the head check answered yes`, exit 0). 15.1's program, unchanged, gives the same, exit 0.
- Head check yes, `devos-test`, every outcome of every step and a cancellation before or during any step: 1168 paths. `tokens` succeeded in 104, failed in 52 and was cancelled in 8; `tokens_revoke` ran in all 104, 52 and 8. `tokens` was skipped in 1004; `tokens_revoke` ran in none (`REVOKE: tokens_revoke runs after every outcome of tokens but skipped, and never when tokens was skipped`, exit 0).
- Break: part 1's file (`3c80bf1`) gives `REVOKE: FAIL (1)`: with `tokens` skipped, `tokens_revoke` ran in 2076 of 2080 paths (the other 4 are a cancellation before the head step). `main`'s file (`d33c8e9`) still gives `GATE: FAIL (36)`.
- The parser rejects a copy with `stepz.tokens.outcome` in the new condition: `(Line: 889, Col: 13): Unrecognized named-value: 'stepz'`, exit 1.

**[obs] The bodies, run** (`mini_run2.mjs`: 15.1's program, with a stand-in `psql` that can fail at a given issue, and a scenario that can end a step `cancelled` after its body ran):

| Scenario (`devos-test`) | `tokens` | `tokens_revoke` | Stand-in `psql` calls | `go` line |
|---|---|---|---|---|
| head `superseded`, a tokens file in `RUNNER_TEMP` | skipped | skipped | 0 | `go=superseded (… revocation=skipped)` |
| head yes, `dbtests` failed | skipped | **skipped** | 0 | `go=no (… tests=failure programs=skipped revocation=skipped)` |
| head yes, `dbprograms` failed | success, 6 + 1 issued | ran, 6 revoked | 14 | `go=no (… programs=failure revocation=success)` |
| head yes, cancelled before `dbprograms` | success, 6 + 1 issued | ran, 6 revoked | 14 | `go=no (… programs=skipped revocation=success)` |
| head yes, the 4th issue fails | **failure**, 5 + 1 issued | ran, 5 revoked | 13 | `go=no (… programs=skipped revocation=success)` |
| head yes, cancelled as `tokens` ends | **cancelled**, 6 + 1 issued | ran, 6 revoked | 14 | `go=no (… programs=skipped revocation=success)` |
| break: the second row on `3c80bf1`'s file | skipped | **ran**, the secret in its env; "none to revoke" | 0 | `go=no (… revocation=success)` |

Every stand-in `psql` call had `PGPASSWORD` and `verify-full`. No tokens file was left where tokens had been issued.

### 15.10 Outputs of the checks run for this revision

From the clone's working tree, after this revision's last edit of `migrate.yml`:
- **GitHub's parser** (`@actions/workflow-parser` 0.3.61, 15.4's install): `migrate.yml: 0 errors (parseWorkflow 0, convertWorkflowTemplate 0)` and the same for `migration-checks.yml`, exit 0.
- **As handed**: every `run:` value is a literal, 54 and 4, each byte-identical to PyYAML's (`0 differ; 0 missing`), exit 0. No `${{` in any `run:` value (54 and 4).
- **M22**, `workflow_check`'s handed body: 31 lines "fails on its own rule, as it must", the control "passes, as it must", `workflow check: pass`, exit 0. Its output is identical to 15.4's.
- `test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0; `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`, exit 0. `test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies "the copy fails, as it must", `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0; `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`, exit 0.
- **The repeated bodies**: identical to 15.4's, except `search` ×2, identical to each other, now `7868d6f60c93` (was `af60920e3ead`). `tokens_revoke` `8117e8de0831` and `plant` `b049a11f5998` are unchanged, as are `migration-checks.yml`'s four.
- `records.py render --check`, `check_service_names.sh` and `git status --short`: their final lines are in the producer's report to the executor, run after this record's last edit.

### 15.11 What only a live run shows, and what stays open

1. **The archive's real layout.** S1's and S2's per-run lines show which kind of files the search counted in each earlier run, and how many of each. A run of two jobs should read 2 top-level files, or 0 top-level files and some in folders. Any other count is a reason to read that run's archive before trusting S2's count.
2. **The mixed case** (15.7, M1) stays possible in principle. It fails safe for the plant, not for the credential. Closing it (pairing a job's top-level file with its folder) is a change of the search, class high, and the executor's to decide. *(2026-10-13: decided and made, section 15.12.1: the credential is counted in every file, so it no longer misses a folder-only job; the plant keeps this rule, which fails safe.)*
3. **The new run window.** The logs place reads "could not check" once `migrate.yml` has more than 400 runs. Runs are now deleted after 90 days by default (15.6). With 4 scheduled runs a day, 360 runs fall within 90 days, so the bound is passed once more than about 40 push runs also fall within those 90 days. With several pushes a day during the installation, that is a matter of weeks [inf from the schedule and the documented retention]. From then on, every search's logs place is "could not check" until older runs are deleted. T-W03-09's S2 is unaffected if it comes before. A lasting answer (deleting the logs of runs already searched, a window starting at the last clean search, or one job reading the logs with a higher bound) is the executor's to decide. *(2026-10-13: sized in section 15.12.2: at the present rate the bound is passed on about 2026-10-19; not fixed, carried by the executor's note.)*
4. **The final lines' wording.** With a logs gap, the logs place is listed both under "none found by that method in" and under "could not check" (P2, P4). "Could not check" governs. A reader of S2's log should be told so, or the wording changed (class high).
5. **Re-run attempts.** The search reads `/actions/runs/{id}/logs`. For a partially re-run run, the documentation says the downloaded archive holds only the re-run jobs (15.6) [doc, said of the download in the web interface; that the endpoint does the same is inf]. A credential printed in an earlier attempt of such a run is then not searched. This is a coverage limit of the logs place, outside these decisions.
6. **The rate limit and the time** of 15.8 show only on GitHub.
7. 15.5's items 1 to 4 stand; its items 5 and 6 are met by 15.9 and 15.8.

### 15.12 Part 3 of H1: the credential counted in every file, the 400-run window sized, the stale lines (2026-10-13)

Made on the same branch at `5201bd9` (part 2) by a fresh-context producer subagent of the same working session (declared, Ek A 5.3), offline only, on the executor's three decisions on part 2's open items (a hint): a counting rule per needle (15.12.1); the 400-run window kept as a residual with its size, carried by a note (15.12.2); the stale lines of sections 3 and 12.6 corrected and a `sources` line added (15.12.3). Files changed: `.github/workflows/migrate.yml` (the two `search` copies, identically) and this record (this section; dated marks in sections 3, 12.6, 15.7 and 15.11; two `sources` lines, one for part 2 and one for this part). `migration-checks.yml`, the tests, the SQL files and every other step body are unchanged. Line numbers in 15.6 to 15.11 are those of `5201bd9`. From this revision the two `search` copies are at :2503 to :2700 and :3239 to :3436, their logs part at :2615 to :2664 and :3351 to :3400. Nothing ran against `devos`, `devos-test` or GitHub, and the network was not used. The scripts named here are in the producer's scratch directory, outside the repository.

#### 15.12.1 A counting rule per needle (decision 1)

**The change** (`search`, both copies identically) [src]. `count` takes an optional needle name and then counts that needle only; every other call counts both, as before. In the logs part, each entry of a run's archive that is not a folder entry is read once, by its entry rather than its name, so two entries with one name are both read.
- **The credential** is counted in every file. Its result must be "none found", so a match anywhere must be found. A line counted twice only raises a count that is already not 0.
- **The plant** keeps 15.7's rule: the top-level files when the archive has any, the files in folders only when it has none. Its result must be exactly 1 per planted place.
- The plant's files are always among the credential's, so where the plant is found, the credential's reading covered the same files and more [inf from the source].
- Each run read prints one line: `logs: run <id>: the credential counted in all its files, the plant in its top-level files (<n> top-level, <m> in folders)`, or `… the plant in its files in folders (…)`, or `… the plant in its archive, which holds no file (…)`. It carries the run's ID and two counts, never a name or content.
- With both layouts in an archive, a credential printed once counts 2 per form. The number in `FOUND (<n> matches)` therefore counts matches in files, not lines printed.

**[obs] Run against part 2's stand-in API** (`search_run3.py`). It is 15.7's `search_run.py` with three additions: a layout `mixed_rev`, the job that prints the credential as a scenario setting, and the new per-run line. The body is `check-devos-test`'s copy as GitHub's parser hands it over; the two copies are byte-identical. The break control is part 2's body, handed over from `5201bd9`'s file. Each case's expected result, for both bodies, was written in its scenario file before it ran, and every result matched it. The counts are those of the logs place, plain / percent; the stand-in credential's two forms are the same bytes (15.7).

| Case | Archive (two jobs) | New body | Part 2's body (`5201bd9`) |
|---|---|---|---|
| L1, L2, L3 | top-level only; both; folders only. The plant printed once | plant 1 / 0, credential 0 / 0, all five places backed, exit 0. Per-run lines (2, 0), (2, 11), (0, 11) | not re-run (15.7: the same plant counts) |
| C1 | both. The credential printed once, in `check-devos` | credential 2 / 2, `FOUND (4 matches)`, exit 1; plant 1 / 0 | credential 1 / 1, `FOUND (2 matches)`, exit 1 |
| M1 | mixed: `check-devos-test` in folders only, `check-devos` top-level only. The plant in `check-devos-test` | plant 0 / 0, logs "could not check"; credential 0 / 0; exit 0. Per-run lines (1, 6) | the same |
| M2 | as M1. The credential printed once in `check-devos-test`, the folder-only job | **credential 1 / 1, `FOUND (2 matches)`, exit 1**; plant 0 / 0, logs "could not check" | credential 0 / 0, plant 0 / 0, logs "could not check", exit 0 |
| M3 | mixed the other way: `check-devos-test` top-level only, `check-devos` in folders only. The credential printed once in `check-devos`, the folder-only job | **credential 1 / 1, `FOUND (2 matches)`, exit 1**; plant 1 / 0. Per-run lines (1, 5) | credential 0 / 0, plant 1 / 0, the logs place listed under `none found by that method in`, exit 0: **a false "none found"** |
| M4 | as M3, no credential printed | plant 1 / 0, credential 0 / 0, all five places backed, exit 0 | the same |
| P1 | 250 earlier runs, both layouts. The plant on page 3 | pages 1, 2, 3; `250 of 250 …`; plant 1 / 0; no logs gap; all five places backed | not re-run (15.8) |

No download request carried the token (0 with an Authorization header, in every case). M3 is the hole part 2 left open. A credential printed in a job whose log is only in folders was not counted when the archive's other job was top-level, while the plant, printed in the top-level job, backed the place. M2 is the same hole, where the plant's 0 had at least made the place "could not check".

**What stays.** When the plant's job is the folder-only one in a mixed archive, the plant still counts 0 and the logs place reads "could not check" (M1, M2). That fails safe and is kept, as decided. S1's and S2's per-run lines still show the real layout (15.11 item 1).

#### 15.12.2 The 400-run window, sized (decision 2; a residual, not fixed here)

[inf from `main`'s history, the workflow and 15.6's documentation; nothing read on GitHub]
- **The bound.** The search reads at most 400 runs, its own included (15.8).
- **The runs.** `migrate.yml` runs once per push to `main` (`on: push: branches: [main]`, no path filter) and four times a day on the schedule (00:41, 06:41, 12:41 and 18:41 UTC). Its first run was at 2026-10-12T22:13Z (section 13). So no run is old enough for the 90-day retention (15.6) before 2027-01-10, and until then every run counts. By `d33c8e9` (2026-10-12T22:55Z) it had 3 push runs (`9798946`, `74a8aab`, `d33c8e9`) and no scheduled run; the first slot after the merge is 2026-10-13T00:41Z.
- **The rate.** `main`'s first-parent history at `d33c8e9` (local `git log`) gives 53 pushes in the 24 hours to 2026-10-12T22:55Z, 105 in 48 hours, 145 in 7 days, and 303 since the first commit on 2026-09-29. Every commit in the three shorter windows is a pull-request merge, so one push each.
- **The date** (`window3.py`, which adds the pushes evenly and the scheduled runs at their slots). At the last 24 hours' rate the 401st run comes at about 2026-10-19T22:28Z. At the last 48 hours' rate it comes at about 2026-10-20T00:04Z. Either way the first scheduled search whose run list holds more than 400 runs is the one at 2026-10-20T00:41Z, and the last that can still serve is the one at 2026-10-19T18:41Z. At the 7-day rate (20.7 pushes a day) the 401st run would come at about 2026-10-29. The date to plan by is the earliest: **2026-10-19**.
- **From then on**, every scheduled search reads the logs place "could not check" (the gap "logs: the run list is longer than 4 pages of 100 …"). Retention does not end it. More than 400 runs fall within 90 days at any rate above 40 pushes in 90 days (360 scheduled runs plus 40), so near the present rate the state lasts. T-W03-09's S2 must come before that date.
- **Carried by a note.** The executor writes the note and owns it; its deadline is before 2026-10-19. The lasting answers named in 15.11 item 3 stay the executor's to decide.

#### 15.12.3 The record's lines (decision 3)

- Section 3, "The search of point 9": "the logs of the 100 latest earlier runs" is marked corrected (15.8, 15.12).
- 12.6: `tokens_revoke`'s condition is marked corrected to 15.9's.
- `sources`: one line for part 2 (15.6 to 15.11) and one for this part.
- Dated notes in 15.7 (its residual) and in 15.11 items 2 and 3.

#### 15.12.4 Outputs of the checks run for this revision

From the clone's working tree, after this revision's last edit of `migrate.yml`:
- **GitHub's parser** (15.4's install): `migrate.yml: 0 errors (parseWorkflow 0, convertWorkflowTemplate 0)` and the same for `migration-checks.yml`, exit 0.
- **As handed**: 54 and 4 `run:` values, each a literal, each byte-identical to PyYAML's (`0 differ; 0 missing`), exit 0. No `${{` in any `run:` value (54 and 4).
- **M22**, `workflow_check`'s handed body: 31 lines "fails on its own rule, as it must", the control "passes, as it must", `workflow check: pass`, exit 0. Its output is identical to 15.10's.
- `test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0; `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`, exit 0. `test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies "the copy fails, as it must", `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0; `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`, exit 0.
- **The repeated bodies**: identical to 15.10's, except `search` ×2, identical to each other, now `2ef72520eefd` (was `7868d6f60c93`).
- `records.py render --check`, `check_service_names.sh` and `git status --short`: their final lines are in the producer's report to the executor, run after this record's last edit.

#### 15.12.5 What stays open

1. 15.11's items 1, 4, 5 and 6 stand. Item 2 is met for the credential (15.12.1). Item 3 is sized, and the executor's note carries it (15.12.2).
2. The number in `FOUND (<n> matches)` counts matches in files, not lines printed (15.12.1).

### 15.13 The plants (made last, by the executor)

Rewritten for H1-prime from what was 14.13 on the first H1 branch. That text spelled the plant then in force, and its tag, `20261012T2338Z`, is retired (CHK-C02-045 F-2 and C2; FR-07 item 3). Until the executor records it here, this round's tag is called "the H1-prime tag". This record never holds a plant's value, in either form; it names the tag only.

**Why the plants are made last and never held as text.** The first H1 record held the plain value. Pull-request refs keep every blob that was pushed (`refs/pull/309/head`), so no later commit could withdraw that copy. T-W03-09's exact counts then made the tag fail: the search would count the record's copy in the current trees and in history, and once that copy was on `main` it would stand in for p1, so the control would fail open (CHK-C02-045 F-2). Hence FR-07 item 3. For each round the executor makes a new tag, and the plants from it, at the point of use, after this revision's other parts are judged ready. The value goes only into its planted places (below). It goes into no other file (scratch files included), commit message, pull-request text, verdict or record. Before each push, the executor runs the search's own counting code over the local clone and prints counts only. On GitHub, the rehearsal (15.15) counts the plants before the verdict.

**The places, by kind** (T-W03-09 as revised; the executor records the identifiers here once they exist):

| Plant | Kind of place | Form | The search's place | Expected count (plain / percent) |
|---|---|---|---|---|
| p1 | a file in the current tree of a fixture branch's tip | plain | `repository: current trees` | 1 / 0 |
| p2, holding p5 | a file that one commit on that branch adds and a later commit removes, so only history holds it; its content differs from p1's | percent-encoded (p5) | `repository: history` | 0 / 1 |
| p3 | one comment, labelled synthetic, on the fixture issue #308 (`W03_FIXTURE_ISSUE`); the issue's older comment holds only the retired plant | plain | `issue #308`, which also backs `issue #6` (read by the same code, 0 / 0) | 1 / 0 |
| p4 | the line that step `plant` of `check-devos-test` prints in every scheduled run whose commit holds `W03_PLANT_B64` set (15.2, 15.3): S1 prints it, S2 searches | plain, once per run | `logs of migrate.yml's earlier runs` | in the rehearsal 0 / 0 (no run has printed it); at S2, 1 / 0 in each of its two searching jobs (15.14 fact 2) |

`W03_PLANT_B64`, the plant's base64, is not a planted place: the search matches neither base64 nor the workflow's text (15.3, "Other places"). The executor sets it last, with the plants; in this build it is `""`. No pull request is opened from the fixture branch, and no commit message holds the plant (T-W03-09).

**What the executor records here, once made:** the H1-prime tag; the fixture branch, the commits of p1 and of p2's addition and removal, and p3's comment ID; the local count's lines with their UTC time (CHK-C02-045 C2: current trees 1 / 0, history 0 / 1, the fixture issue 1 / 0, issue #6 0); the rehearsal run's ID and its count lines (15.15); then S1's and S2's run IDs. After S2's search, T-W03-09 governs: the issue is closed, the next class-high change empties `W03_PLANT_B64` and `W03_FIXTURE_ISSUE`, and the branch is removed by whoever can remove it.

### 15.14 The facts fixed for this revision

The executor fixed these in this build's task (FR-07 item 2), before any part was written. The test designer's revision of T-W03-09 and H1-prime's checker compare against them. This build changes none of them.

1. **The plant step stays in `check-devos-test`**, the scheduled comparison job. The reason in 15.2, "Why this job", holds: merges stay free.
2. **S1 prints; S2 searches.** S1 is the first scheduled run of `migrate.yml` after H1-prime merges with `W03_PLANT_B64` set, and it prints the plant once. S2, the second, runs the search that counts it. The logs place's expected count is one per job: each of S2's two searching jobs counts 1, the one line S1 printed. That line is read from S1's log archive by the search's own rule (the top-level files, or the files in folders if there are none; 15.7, 15.12.1). S1's own logs place reads "could not check" by design, since no earlier run holds the plant.
3. **CHK-C02-045 C1's windows.** From H1-prime's merge to the end of S2's search, neither `W03_PLANT_B64` nor the plant step changes. From S2's creation to the end of its search, nothing merges into `main`. In that whole window, no run of `migrate.yml` is re-run. T-W03-08 (e) comes after S2's search.
4. **The baseline, as it stands.** No scheduled run of `migrate.yml` has yet been created. The executor read GitHub's run list, filtered by the event `schedule`, at 00:47Z, 01:15Z and 01:24Z on 2026-10-13, and it gave a total of 0 each time. This build did not read it again: the guard refuses the command-line client, rule B7. **The rule that decides it** (FR-07 item 2; CHK-C02-045 C4 as FR-07 reads it): a scheduled run of `migrate.yml` may complete before the test designer's task goes out, at a head before H1-prime, with both of its comparison jobs passing the head check and running the search, and with its two job logs saved unedited. If so, the revised T-W03-09 names that run as its baseline. If not, the revised test drops the baseline under C4's own exception, giving its reason: the rehearsal shows the code on GitHub, and S1 shows P7. A run superseded at its head check is not a baseline. Either way, H1-prime does not merge while a scheduled run of `migrate.yml` is queued or in progress, and its merge time follows FR-07 item 5.
5. **The plant.** A new tag replaces the retired `20261012T2338Z`. The executor makes the value and its places last (15.13). The value goes into no file but its planted places, and into no commit message, pull-request text or record. In this build `W03_PLANT_B64` stays `""`, and records name the tag only. `W03_FIXTURE_ISSUE` is set to `"308"`: the fixture issue, whose old comment holds only the retired plant.

### 15.15 The rehearsal

FR-07 item 1 says that, before any verdict, code that needs no secret runs on GitHub. This build makes the rehearsal workflow `w03-rehearsal.yml` outside this repository, in the producer's scratch directory. The executor places it under `.github/workflows/` on a branch of its own, `claude/w03-rehearsal`, based on H1-prime's final head once the plants exist, and pushes that branch. The workflow is never merged. No pull request is needed, and none should be opened from that branch: M22 (`migration-checks.yml`, which runs only on pull requests into `main`) refuses the fixture job's `PGSSLMODE: disable`, and rightly, since a local run of M22's own body over a tree holding the file gave `workflow check: FAIL` with that reason alone. The rehearsal is exploratory and is never T-W03-09's result. Its log is read against the numbers below before the verdict, by the executor and by H1-prime's checker. If the rehearsal and the live search later disagree, FR-07 reopens.

**Its form.** `name: w03-rehearsal`; `on: push` limited to `claude/w03-rehearsal`; top-level `permissions: {}`. It has no `environment` and no secret, and no `run:` value holds an expression: values reach the steps through `env`. `actions/checkout` is pinned to the commit `migrate.yml` pins (`d23441a48e516b6c34aea4fa41551a30e30af803`, v6.1.0), with `persist-credentials: false`. It has two jobs, and each has one step that runs a step of `migrate.yml`:
- **The run step** (the same text in both jobs) reads `.github/workflows/migrate.yml` at the commit with PyYAML, which is present on the runner (12.9). It finds the step by job and step id and checks three things: there is exactly one such step, its shell is `python` or `bash`, and its body holds no expression. It prints the SHA-256 of `run|shell`, the hash 15.4 lists among "the repeated bodies". Then it writes the body to a file and runs it as GitHub's shell does: `python FILE` with the runner's own interpreter, or `bash --noprofile --norc -eo pipefail FILE`. The body's environment is the job's, plus each workflow-level and job-level `env` entry of `migrate.yml` whose name the body names. From the step's own `env`, an entry that names a secret is withheld; an entry holding any other expression takes this job's value if this job sets one. The step prints names, the hash and the body's own lines, never a value. The extracted variables reach only the body's process, so no step header of the rehearsal lists `W03_PLANT_B64`.
- **search** (`contents: read`, `actions: read`, `issues: read`) runs `check-devos-test`'s `search` (hash `2ef72520eefd` at this build). From `migrate.yml` it takes `W03_PLANT_B64` and `W03_FIXTURE_ISSUE` (no job-level entry is named). `GH_TOKEN` is this job's `github.token`, the same expression `migrate.yml` uses. `SUPABASE_DB_PASSWORD` is withheld. So the body runs unchanged with no credential. Its credential line reads `search: could not check (credential present: no)`, the job does not fail for it, and the plant is counted in every place by the code S2 will run.
- **fixture** (`contents: read`) uses a service container `postgres@sha256:2d2b8998d31037bf721cfdf764d76ba74171b4fab3431b7f72c27c56ddbdf9e3`. That is the image index of `postgres:17` as Docker Hub's registry served it at 2026-10-13T01:42Z: its `Docker-Content-Digest` equals the SHA-256 of the body served. The docker-library repo-info page for `postgres:17` gives the same digest and `PG_VERSION=17.11-1.pgdg13+2`. The registry refused the image's configuration with 429, its unauthenticated pull limit, so the minor version rests on that page and on the stub's server line. The server uses trust authentication on `localhost` (no password exists) and is health-checked with `pg_isready`. Step `stub` prints the server's and the client's versions. It then creates, as CHK-C02-044 F4 did, the roles `anon`, `authenticated` and `service_role` (nologin), `auth.users(id uuid primary key)` and `supabase_migrations.schema_migrations(version text primary key, statements text[], name text)`. Step `migrations` applies every file of `supabase/migrations/` in name order: at this head, `20261012184638_deployment_drift.sql`, then `20261012231841_w03_fixture_apply.sql`. Each file goes in with `psql -X -v ON_ERROR_STOP=1 -1`, in one transaction with its history row. The row's version and name come from the file name, and `statements` is left null, since no test reads it. The run step then runs `devos-test`'s `dbtests` (`shell: bash`, hash `08eedf39e196`), unchanged. Its `PGHOST` (an expression in `migrate.yml`) takes this job's `localhost`, and `PGPASSWORD` is withheld. libpq's other settings come from this job (port 5432, user `postgres`, `sslmode=disable`), not from `devos-test`.

**What its log must show.** These were written before it runs. The first four rows are CHK-C02-045 C2's numbers. The logs place is 0 because no run has printed the new plant:

| The search's place | plain | percent |
|---|---|---|
| `repository: current trees` | 1 | 0 |
| `repository: history` | 0 | 1 |
| `issue #308` (the fixture issue) | 1 | 0 |
| `issue #6` | 0 | 0 |
| `logs of migrate.yml's earlier runs` | 0 | 0 |

The search job's log should also show:
- `rehearsal: … job check-devos-test, step search: shell python, 190 lines, SHA-256 of run|shell 2ef72520eefd`. Placing the plants must not change the body. Another hash means the code rehearsed is not this build's.
- `env W03_PLANT_B64: … (set)` and `env W03_FIXTURE_ISSUE: … (set)`.
- `repository: <n> refs, <m> objects read`: the refs fetched.
- For each earlier run of `migrate.yml`, its layout line, `logs: run <id>: the credential counted in all its files, the plant in its … (<t> top-level, <f> in folders)`. This is the first look on GitHub at 15.11 item 1. A run of two jobs should show 2 top-level files, or 0 top-level files and some in folders; any other count is read before the verdict (CHK-C02-045 F-7 (c): "(0 top-level, 0 in folders)" counts as not read).
- The paging line, `logs: <k> of <k> earlier runs of migrate.yml read`, with no logs gap. A run of `migrate.yml` in progress while the logs are read leaves a gap, and the rehearsal is then pushed again later.
- `search: could not check: logs of migrate.yml's earlier runs (the plant was not found in logs of migrate.yml's earlier runs)`. This is expected.
- `search: could not check (credential present: no)`, then `rehearsal: step search: exit 0`.

A plant count other than the table's is read before the verdict. Above 1 means a stray copy, which reopens FR-07. A 0 means a missing plant or a place not read.

The fixture job's log should show:
- the server line `PostgreSQL 17.11 …`;
- `migrations applied: 2`;
- each file's PASS line on PostgreSQL 17, each followed by `database test <file>: passed`: `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)` and `W03_FIXTURE_APPLY_READ PASS (12/12 fields as the fixture file; positive control 2/2; breaks 2/2)`. The counts are each file's own cases, as on PostgreSQL 16.15 below;
- then `rehearsal: step dbtests: exit 0`.

**What it does not show.** These are stated gaps, not passes:
- **The credential and P7.** There is no secret here, so the credential's counts are S2's to show. The token is a push job's `github.token` with `check-devos-test`'s three permissions. That the scheduled job's token reads the same refs and archives is [inf], to be seen at S2. The mirror clone is anonymous in both.
- **p4.** The logs place is 0 by design. S1 and S2 show p4.
- **The fixture is not Supabase.** It runs on PostgreSQL 17.11 from Docker Hub, while the projects run Supabase's 17.6 build (CHK-C02-045 F-7 (a)). It has none of Supabase's event triggers or extensions, and none of its roles beyond the stub. The stub, the migrations and the tests run as a superuser, which Supabase's `postgres` is not. The migrations go in with `psql -1`, not the command-line tool's `db push`, whose run is H1-prime's push run (T-W03-05). There is no pooler and no TLS. The runner's `psql` is the image's client, and the stub prints its version.

**Hints run in this build.** These are not evidence: FR-07 item 1 says no model of GitHub written from belief is evidence.
- **[obs, PostgreSQL 16.15, a hint] The fixture job's steps** were read from the file and run as GitHub's shells run them (`run_job.py`) against a throwaway cluster under `/var/tmp`, stopped and deleted after. `stub` passed. `migrations applied: 2`. The three PASS lines above appeared, each with `passed`, and `rehearsal: step dbtests: exit 0`. **Break:** the same steps on a fresh cluster with the fixture migration left out gave `W03_FIXTURE_APPLY_READ FAIL (11 of 12 fields differ from the fixture file: …)`, `database test w03_fixture_apply_read.sql: not passed (psql exit 3)` and `rehearsal: step dbtests: exit 1`. The stub cannot run twice in one cluster, because roles belong to the cluster; the service container is always new.
- **[obs, stand-ins, a hint] The search job's run step** was run the same way against a stand-in GitHub API on 127.0.0.1 and a stand-in repository reached through a `git` wrapper (`hint_search.py`). The stand-in plant was 15.2's tag `20000101T0000Z`, which no round has. It was put only into the stand-in repository, the stand-in issue #308 and a scratch copy of `migrate.yml`, as base64. The stand-in served three earlier runs, each with both layouts, and none printed the plant. The output: the hash line `2ef72520eefd`, the two variables `(set)`, `SUPABASE_DB_PASSWORD` withheld and `GH_TOKEN` this job's; `repository: 2 refs, 10 objects read`; three layout lines `(2 top-level, 22 in folders)`; `logs: 3 of 3 earlier runs of migrate.yml read`; the plant at trees 1 / 0, history 0 / 1, issue #6 0 / 0, issue #308 1 / 0 and logs 0 / 0; the logs place's "could not check" line; `search: could not check (credential present: no)`; exit 0. No download request carried the token. The expected lines were written before the run, and every one matched except the stand-in's own folder count: I expected 11, but the stand-in holds 11 step files in each of two jobs, 22 in all.

### 15.16 Outputs of the checks run for this build

These were run from the clone's working tree after this build's last edit of `migrate.yml` and of the rehearsal file:
- **GitHub's parser** (15.4's install, `wp_check.mjs validate`): `migrate.yml`, `migration-checks.yml` and `w03-rehearsal.yml` each gave `0 errors (parseWorkflow 0, convertWorkflowTemplate 0)`, exit 0. The control, a copy of the rehearsal with `githubx.token`, gave `(Line: 39, Col: 21): Unrecognized named-value: 'githubx'`, exit 1.
- **As handed** (`wp_check.mjs runs`, `cmp_handed.py`): `migrate.yml` has 54 `run:` values and `w03-rehearsal.yml` has 4, each a literal and each byte-identical to PyYAML's (`0 differ; 0 missing`). No `run:` value of either holds an expression (a YAML scan of each step's `run:`; H0's `test_workflow_guards.py` is not on this branch). Every `uses:` in both files is pinned to a 40-hex commit. In the rehearsal no job names an environment, and the text `secrets.` appears twice: both are the string the run step tests a value against, and neither is a reference.
- **M22** (`workflow_check`'s handed body, from the clone's root): 31 lines "fails on its own rule, as it must", the control "passes, as it must", `workflow check: workflows naming an environment: .github/workflows/migrate.yml`, `workflow check: pass`, exit 0. Over a scratch tree that also holds the rehearsal file, it gave `FAIL` for the fixture job's `sslmode 'disable'` and root file only (15.15).
- `test_decision_steps.py`: `W03_DECISION_TEST PASS (69/69)`, exit 0; `--self-check`: `W03_DECISION_SELF_CHECK PASS (7/7)`. `test_workflow_order.py`: `ok   .github/workflows/migrate.yml: order and stop present as written`, its 17 copies "the copy fails, as it must", and `W03_ORDER_TEST PASS (.github/workflows/migrate.yml)`, exit 0; `--self-check`: `W03_ORDER_TEST PASS (synthetic skeleton)`.
- **Bodies**: `search` `2ef72520eefd` in both copies, `plant` `b049a11f5998` and `dbtests` `08eedf39e196`, all unchanged; `migrate.yml` differs from `376a123` in `W03_FIXTURE_ISSUE` only.
- `records.py render --check`, `check_service_names.sh` and `git status --short`: their final lines are in the producer's report to the executor, run after this record's last edit.

