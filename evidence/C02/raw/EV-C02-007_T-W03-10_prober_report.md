# T-W03-10 prober report: W-C02-03 point 10, "probe absence" (raw results, no acceptance verdict)

- Test: tests/C02/W-C02-03/T-W03-10_probe_absence.md and tests/C02/W-C02-03/T-W03-10_devos_listing.sql, both read in full at main 421f6e7ac18cb08cea72536d241fbf2d6728ab38. That SHA is origin/main and the working tree's HEAD. The local branch ref "main" is stale (298fc73), so every read used the SHA, through git show.
- Inputs read:
  - EV-C02-007_T-W03-05_run38363215668_devos-test_job115182093582_redacted.log, sha256 afbec292...93dbd, 2167 lines.
  - EV-C02-007_T-W03-05_run38363215668_devos_job115182202196_redacted.log, sha256 10ec4552...0cbf6, 2056 lines.
  - Both are in /home/user/devos/evidence/C02/raw/. Run 38363215668's commit is 1c0dbcf51ad4079f7f3a67ed7646bac42e6bd6d9 (log line 101, "head check: yes").
  - The executor's connection read: /tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/EV-C02-007_T-W03-10_devos_read_20261014T1512Z.md.
  - plan/key_inventory.md and plan/decisions/PC-21.md at 421f6e7 (copies in prb10).
- Environment: Linux, uid 0. Python 3.13.16 and PyYAML 6.0.1 for the parsing.
  - Throwaway database: PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1), with psql 16.15 at /usr/bin/psql.
  - The projects run PostgreSQL 17.6: the devos-test log, line 1635, says "server: PostgreSQL 17.6". Results on the throwaway are therefore supporting evidence for the projects, not observations of them.
  - Claude Code version: not observed (the guard denied "claude --version", rule B7; see the end). Model, from the environment statement: Opus 5.5 (claude-opus-5-5).
- UTC times:
  - Work started 15:13:25Z.
  - Cluster made 15:17:25Z (initdb), started 15:17:33Z, shut down 15:22:19Z, then removed.
  - Report written about 15:26Z on 2026-10-14.
- Raw outputs: everything is under /tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10 ("prb10" below). The scripts are in prb10/scripts, part 1 outputs in prb10/p1, part 2 in prb10/p2, part 3 in prb10/p3, and the migration files from main in prb10/mig.
- The report file: /tmp/claude-0/-home-user-devos/0cb29c90-d12e-56b6-9751-2217078b0a90/scratchpad/prb10/T-W03-10_prober_report.md

## Disciplines (D1–D9)

D1: yes: The conclusions could rest on my frames, so I stated them in the parts below and limited the claims to match. These are: the user-namespace route and the stand-ins leave the catalog query unchanged; PostgreSQL 16 stands in for 17.6; my reading of "account step" and of its break.
D2: yes: The record header's "derived at d33c8e9 ... the same list" and the executor's counts could pull me toward confirming them. So I recomputed every claim from git revisions and from my own runs, and labelled the counts as the executor's reading.
D3: yes: The deliverable is raw evidence for point 13's checker. I covered parts 1 to 5, added two labelled extra checks, gave no acceptance verdict, and named what the evidence leaves open (part 5).
D4: yes: This is a sensitivity test, so I ran both positive controls, both listing breaks and the account-step break. I checked my own tools too: two errors in my scripts were found, fixed and rerun, and both attempts are recorded.
D5: yes: Several inputs are views of other sources: redacted log copies, the executor's record of the connection read, and counts the executor read from GitHub. I went back to the sources I could reach (each revision by git show, the step script each log echoes) and marked what rests only on a view.
D6: uncertain: A comparison of a log with the step came out False. I traced the cause to my own parser (it counted the group header line twice) before drawing any conclusion, and kept both runs.
D7: yes: I created a database cluster only inside prb10 and removed it at the end, and wrote nothing in the repository. Every command and its output is kept here, so a new session can reconstruct the run.
D8: yes: The work depends on the state of main. I found the local "main" ref stale, used 421f6e7 explicitly, and read the test, the derived file and the inputs in full before running anything.
D9: no

## Part 1. The derived file is current

1.1 Step text at each revision.
- Command: git -C /home/user/devos show REV:.github/workflows/migrate.yml > prb10/... for 421f6e7, d33c8e9, ac6e3cd and 1c0dbcf, then python3 -I scripts/extract_step.py (YAML-parsed, so the text is what the runner receives).
- Exit codes: 0 at every revision.
- Raw output: prb10/p1/m421_*, md33_*, mac6_*, m1c0_* (the run text, the listing.sql heredoc and the lists).
- Result: at all four revisions and in both jobs, step "(4) listing of point 10" (id listing) has the same run text: sha256 1410e6dd41c8f75de9f0badb8034bce3376ce2340c2a2da45c9a6d61aa942ea8, 4268 bytes. Its listing.sql heredoc is sha256 86344fff31930f78e643112d33ebc71bd88eb0a92bbbbd4a0336a83463bddd60, 1813 bytes, 36 lines.
- Revisions: 421f6e7 is main. d33c8e9 is the revision the file's header names. ac6e3cd is the file's own last commit. 1c0dbcf is run 38363215668's commit.

1.2 Diffs.
- Command: diff of the step's run text, d33c8e9 against 421f6e7. Exit 0 (no difference) for job devos-test and for job devos.
- Command: diff of job devos-test against job devos at 421f6e7. Exit 0: job devos's copy is the same text.
- Command: git diff d33c8e9 421f6e7 -- .github/workflows/migrate.yml. It changes 105 lines in hunks at old lines 63 (W03_PLANT_B64), 884, 2534 to 2622 and 3210 to 3298. None falls inside the listing steps, which are lines 387 to 478 (devos-test) and 1302 to 1393 (devos) at 421f6e7.

1.3 The three lists.
- Workflow-level env at 421f6e7, equal to d33c8e9 (diff exit 0):
  - W03_EXCLUDED_SCHEMAS = "auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations"
  - W03_SCHEMA_ENTRY_ONLY = "public"
  - W03_EXCLUDED_ROLES = "postgres authenticator service_role anon authenticated dashboard_user pgbouncer pgsodium_keyholder pgsodium_keyiduser pgsodium_keymaker supabase_admin supabase_auth_admin supabase_functions_admin supabase_read_only_user supabase_realtime_admin supabase_replication_admin supabase_storage_admin supabase_etl_admin supabase_privileged_role"
- Neither job's env nor the listing step's env sets any of the three. The step env holds only PGHOST and PGPASSWORD, so the workflow values are the ones used.

1.4 Bash's own heredoc.
- Command: bash prb10/p1/m421_JOB_heredoc_snippet.sh, which is the step's "cat > ... listing.sql" heredoc taken verbatim, with the target set to a literal path.
- First attempt: exit 1, "No such file or directory". My snippet had a relative path; this was my error, not the workflow's.
- Rerun with an absolute path: exit 0 for both jobs. cmp shows the file bash wrote is byte-identical to the extraction, sha256 86344fff..., in both jobs.

1.5 The derived file against the step.
- prb10/p1/derived_at_421f6e7.sql is from git show at 421f6e7. It equals the working-tree file (cmp exit 0), sha256 d13db82150612ee9c2d4809aa293190896f52b568c67c7412048df98d04d2899.
- Its last commit is ac6e3cd, 2026-10-12T23:37:47Z, a descendant of d33c8e9 (committed 2026-10-12T22:55:22Z). The step text is identical at both.
- Command: python3 -I scripts/derive.py. It applies only the changes the file's header names (exit 0):
  - Removed exactly the four lines: "\set ON_ERROR_STOP on", "begin transaction isolation level repeatable read, read only;", "\echo W03LISTING :w03_listing", and "commit;".
  - Replaced the one " \gset" by ";".
  - Replaced :'ex_schemas' (3 occurrences), :'entry_only' (1) and :'ex_roles' (1) by the three values quoted as literals.
  - Afterwards no backslash and no psql variable remain.
- Output: "mechanical == derived body: True". The derived file is that text plus 10 header comment lines. The result is in prb10/p1/mechanical_derived.sql.

1.6 The step text the saved logs show.
- Command: python3 -I scripts/log_script.py LOG 912 prb10/p1/m421_devos-test_listing_step_run.txt.
- First attempt: "printed == step run text: False". The diff showed my parser had added the "##[group]Run" header line, so the first line appeared twice.
- After the fix (out = []), rerun: "printed lines: 84, run lines: 84, printed == step run text: True" for both logs.
- The lists each log prints (lines 1057 to 1059) are the workflow values in 1.3.

Part 1 result: the step's text and its three lists did not change between d33c8e9 and 421f6e7, job devos's copy is the same text, and the derived file differs from the step's listing.sql only by the changes its header names.

## Part 2. The throwaway database

2.1 Making the cluster.
- Two obstacles:
  - /tmp/claude-0 is mode 0700, owned by root, so the OS user postgres cannot reach prb10. Changing that directory would be a write outside prb10.
  - PostgreSQL refuses to run as root.
- Route taken: initdb and pg_ctl ran as uid 1000 inside a user namespace (unshare --user --map-user=1000 --map-group=1000), which maps only my own uid. The catalog is not affected.
- Commands, with outputs in prb10/p2:
  - initdb -D prb10/pg/data -U postgres --auth=trust -E UTF8 --no-locale: exit 0 (01_initdb.out).
  - pg_ctl start -w with -c listen_addresses='' -c unix_socket_directories=prb10/pg/sock -c port=54716: exit 0 (02_start.out).
- No network listen:
  - The server log shows only "listening on Unix socket .../prb10/pg/sock/.s.PGSQL.54716".
  - "show listen_addresses" is empty (03_version.out).
  - The listen-address line of postmaster.pid is empty.
  - /proc/net/tcp has no entry for port 54716 (0xD5BC), checked both before and while the cluster ran.
- The postgres login works: "select current_user, session_user" gives postgres|postgres (03_version.out).
- Stand-ins (p2/10_standins.sql, exit 0, 10_standins.out):
  - Roles anon, authenticated and service_role (nologin), and authenticator (login, granted the three).
  - Schema auth with table auth.users.
  - Schema supabase_migrations with table schema_migrations, the history table that P1 says the tool creates.
  - The other names on W03_EXCLUDED_ROLES do not exist on the throwaway.

2.2 How the step was run.
- scripts/make_step.py writes prb10/p2/STATE_MODE_step.sh. That script is job devos-test's listing run text from migrate.yml at 421f6e7, unchanged except that the line setting w by mktemp now sets w to a literal directory in prb10.
- In front of it the script exports the three lists (the workflow values), PGHOST (the socket directory), PGPORT=54716, PGUSER=postgres, PGDATABASE=postgres and GITHUB_OUTPUT (a file).
- So the step's own heredoc writes listing.sql, the step's own two psql commands run with the workflow's -v values ("timeout 120 psql -X -q -A -t -v ex_schemas=... -v entry_only=... -v ex_roles=... -f listing.sql", then the control with empty -v values), and the step's own Python prints the result.
- Every as-is and widened run wrote a listing.sql byte-identical to the extraction ("listing.sql written by the step == extraction at 421f6e7: True").
- Differences from the runner: a unix socket (no TLS), no password, PostgreSQL 16.15.
- The derived file: scripts/run_derived.py sends its whole text to psql as one -c query string, as a one-statement connection would. This is psql, not the Supabase connector.
- The evaluator: scripts/evaluate.py reads the step's own W03LISTING lines from its out and control files. Criterion (ii) means all three of "schema w03_fixture_probe", "table w03_fixture_probe.token_hashes" and "role w03_fixture_probe_role" are in the listing.

2.3 Results. The full stdout of each run is in prb10/p2/STATE_MODE.stdout, its evaluation in .eval, and the step's raw psql out, control and err files in prb10/p2/STATE_MODE/. The whole run per state is in p2/S0_run.out to p2/S4_run.out.

- S0, stand-ins only, as-is:
  - Step exit 0, count=0, listing [].
  - Control: "the same query without the exclusion list shows 10 objects; auth.users among them: yes". Its raw line is: W03LISTING ["role anon", "role authenticated", "role authenticator", "role postgres", "role service_role", "schema auth", "schema public", "schema supabase_migrations", "table auth.users", "table supabase_migrations.schema_migrations"].
  - Derived file: [], same list: True.
  - Positive control (i), auth.users shown without the exclusion list: yes.
- Plant (p2/20_plant.sql, exit 0, 20_plant.out):
  - (d) schema w03_fixture_probe with table w03_fixture_probe.token_hashes, plus view w03_fixture_probe.token_hashes_view and function w03_fixture_probe.f(), as the test's synthetic-data line names them.
  - (e) role w03_fixture_probe_role.
- S1, plants present, as-is:
  - Step exit 0, count=5. It printed "listing: function w03_fixture_probe.f()", "listing: role w03_fixture_probe_role", "listing: schema w03_fixture_probe", "listing: table w03_fixture_probe.token_hashes", "listing: view w03_fixture_probe.token_hashes_view".
  - Control: 15 objects, auth.users yes.
  - Derived file: the same five, same list: True.
  - Positive control (ii), (d) and (e) shown: yes, GREEN.
- S1, break 1 (widened):
  - The -v values were extended by w03_fixture_probe and w03_fixture_probe_role. The step's printed exclusion list shows both added names.
  - Step exit 0, count=0, listing [].
  - (d) and (e) shown: no. Criterion (ii) RED.
- S1, break 2 (lists nothing):
  - The same step with ") s" changed to ") s where false" in the heredoc. This is the only change, so its listing.sql differs from the extraction by design.
  - Step exit 0, count=0, listing []. The control also reads "0 objects; auth.users among them: no".
  - Criterion (ii) RED.
- Migrations: 20261012184638_deployment_drift.sql and 20261012231841_w03_fixture_apply.sql, from git show at 421f6e7, applied with "psql -X -v ON_ERROR_STOP=1 --single-transaction -f".
  - Exit 0 for both. The first printed CREATE SCHEMA x2, CREATE TABLE, CREATE FUNCTION, REVOKE, DO; the second printed CREATE SCHEMA, CREATE TABLE, COMMENT, CREATE VIEW, REVOKE x2, DO (p2/30_apply_*.out). Both apply on PostgreSQL 16.15 with the stand-ins.
- S2, migrations with the plants still present, as-is:
  - Step exit 0, count=12. Listed: function devos_api.deployment_drift(expected jsonb), schema devos_api, schema devos_private, table devos_private.function_deployment, schema w03_fixture, table w03_fixture.apply_check, view w03_fixture.apply_check_view, and the five plants.
  - Control: 22, auth.users yes.
  - Derived file: same list, True.
- S3, plants removed (drop schema w03_fixture_probe cascade; drop role w03_fixture_probe_role; exit 0, p2/40_unplant.out), as-is:
  - Step exit 0, count=7: exactly the seven migration objects.
  - Control: 17, auth.users yes.
  - Derived file: same list, True.
  - This list equals, item for item, the devos connection read of 15:12:08Z ("equal: True").
- S4, extra check beyond the task's list (synthetic, p2/50_extra_public.sql, exit 0): a table, a view and a function in public, plus "create extension pgcrypto schema public".
  - Step exit 0, count=11. It lists table public.w03_fixture_probe_public_t, view public.w03_fixture_probe_public_v, function public.w03_fixture_probe_public_f() and "extension pgcrypto". pgcrypto's 36 extension-owned functions (p2/50_pgcrypto_count.out) appear as that one line.
  - Derived file: same list, True.
  - So excluding the public entry did not hide its contents, and extension-owned objects were reported by extension name.
- Same-list check: the derived file and the step's text run with psql gave the same list in S0 (without plants), S1 and S2 (with plants), S3 and S4. True each time.
- End: pg_ctl stop -m fast -w gave exit 0 (p2/90_stop.out), and the server log is kept as p2/91_server.log ("database system is shut down" at 15:22:19Z). rm -rf prb10/pg gave exit 0. "pgrep -x postgres" gives exit 1 (no such process).

2.4 Observation on the breaks. In both breaks the workflow step itself exits 0 and writes count=0 to GITHUB_OUTPUT. So the step does not fail on an empty listing; the red comes from criterion (ii), applied to the step's output. In break 1 the widening is visible in the step's printed exclusion list.

## Part 3. The account table

3.1 What the listings are.
- The listings in the saved logs are the step's printed "listing: ITEM" lines. The raw W03LISTING line appears in the logs only inside the echoed script, because the step's psql writes it to a temporary file.
- scripts/log_listing.py collects the items between the step's header line and "listing: N objects ...". The item count equals the printed count in both logs. Outputs are in prb10/p3/*.json.
- (b) devos-test: run 38363215668, job 115182093582, step (4) at 07:31:52Z.
  - The read came before that run's apply of 20261012231841: log line 1144 reads "dry run: pending versions: [\"20261012231841\"]". So 20261012184638 had been applied earlier, and this listing comes after the first migration, with accounts.
  - Control: 121 objects, auth.users yes.
- (a) devos, job: the same run, job 115182202196, step (4) at 07:32:09Z, before that run's apply of 20261012231841 (line 1539: FM_READS ... "history_rows":1).
  - Control: 121 objects, auth.users yes.
- (a) devos, connection read: the executor's record, read at 2026-10-14 15:12:08.070388+00, after H2 to H5.
- Supabase's own, by the printed list (each log, lines 1057 to 1059, identical in both):
  - "schemas excluded with their contents (Supabase's own): auth extensions graphql graphql_public pgbouncer realtime storage vault supabase_migrations"
  - "schema entries excluded, their contents still listed: public (the default schema every project is created with)"
  - "roles excluded (Supabase's own), besides every pg_* role:" followed by the 19 names in 1.3.
  - Everything in those schemas, and those roles, is accounted as Supabase's own by this list. supabase_migrations counts as Supabase's own after the tool's first push (P1).
- The schema public is not listed (entry-only): it is accounted "there before C02" by the test. No table, view or function in public appears in any of the three project listings.

3.2 Which migration file creates each object. The files on main at 421f6e7 are in prb10/mig.
- 20261012184638_deployment_drift.sql:
  - line 8: create schema if not exists devos_private
  - line 9: create schema if not exists devos_api
  - line 14: create table devos_private.function_deployment
  - line 33: create function devos_api.deployment_drift(expected jsonb)
- 20261012231841_w03_fixture_apply.sql:
  - line 9: create schema w03_fixture
  - line 11: create table w03_fixture.apply_check
  - line 19: create view w03_fixture.apply_check_view
- 20261012232112_w03_fixture_name_differs.sql and 20261012232113_w03_fixture_restore_name.sql create no object. Each is one DO block that updates the name of a row in supabase_migrations.schema_migrations.

3.3 The account table. scripts/account.py with mode "real" looks for each listed object's create statement in the migration files, with comments removed. The name scan is mine, a hint only: object names matched case-insensitively against "probe|token|hash". Outputs are in prb10/p3/*.account.md, exit 0.

(a) devos, job listing of run 38363215668 (4 objects):

| object | migration version | migration name |
|---|---|---|
| function devos_api.deployment_drift(expected jsonb) | 20261012184638 | deployment_drift |
| schema devos_api | 20261012184638 | deployment_drift |
| schema devos_private | 20261012184638 | deployment_drift |
| table devos_private.function_deployment | 20261012184638 | deployment_drift |

(a) devos, connection read 2026-10-14T15:12:08Z (7 objects):

| object | migration version | migration name |
|---|---|---|
| function devos_api.deployment_drift(expected jsonb) | 20261012184638 | deployment_drift |
| schema devos_api | 20261012184638 | deployment_drift |
| schema devos_private | 20261012184638 | deployment_drift |
| schema w03_fixture | 20261012231841 | w03_fixture_apply |
| table devos_private.function_deployment | 20261012184638 | deployment_drift |
| table w03_fixture.apply_check | 20261012231841 | w03_fixture_apply |
| view w03_fixture.apply_check_view | 20261012231841 | w03_fixture_apply |

(b) devos-test, job listing of run 38363215668 (4 objects): the same four rows as (a)'s job listing, all from 20261012184638 deployment_drift.

Plus, for every listing: the schemas and roles on the printed list are Supabase's own by that list, and the schema public is "there before C02".

- Flags: in all three project listings, no object lacks an account ("unaccounted=0"), and the name scan finds no name of the probe's kind ("probe-kind names=[]").
- A note, not a flag: by its migration text, devos_private.function_deployment holds columns source_sha256 and ezbr_sha256. These are hashes of Edge Function sources, and the text says the table is empty until the first Edge Function. It is not a table of token hashes by that text. Its rows are not part of the listing and I did not read them.

3.4 The account step's break, on the throwaway listing output with (d) and (e). The planted objects, known to have no migration, are in p3/planted_no_migration.json.
- S1 (5 objects):
  - Real step: all 5 "NO ACCOUNT", result "RED (an object without an account)"; the break check flagged 5/5.
  - Break copy (mode "any", which accepts every object without a lookup): "GREEN (every object accounted)"; the break check flagged 0/5, "FAIL: the step accepts a planted object with no migration".
- S2 (12 objects):
  - Real step: the 7 migration objects accounted as in 3.2; the 5 plants have NO ACCOUNT, so RED, flagged 5/5.
  - Break copy: GREEN, flagged 0/5, FAIL.
- In both, the name scan flags the plants whichever copy runs, because it does not depend on the account step.
- S4 (extra): "extension pgcrypto" has no migration and no probe-like name.
  - The real step flags it (4/4 of the S4 extras).
  - The break copy accepts it (0/4), and the name scan does not flag it.
  - So on that object only the account step catches the defect.

## Part 4. (c) The tokens' records: DevOS's records, not an observation

- plan/key_inventory.md row 16 (Probe token of devos-probe-a), "State" column: "never created (2026-10-12, W-C01-47 item 5): PC-21 item 1 replaced the probe setup by one ordinary routine, and W-C01-03 and W-C01-05, which would have built devos-probe-a, devos-probe-b and the probe schema, were cancelled (W-C01-31, L-182); so this token was never issued and exists nowhere".
- plan/key_inventory.md row 17 (Probe token of devos-probe-b), "State" column: "never created (2026-10-12, W-C01-47 item 5; as row 16)".
- plan/decisions/PC-21.md, "New text", Place 2, item 1: "Probe setup. No active trial across environments is made. P1 (two probe environments with tokens), P3 (the probe schema) and the probe-only guard rule of "Platform and guard apart" are not built. P2 is reduced to one ordinary routine in the installation environment devos-kurulum, attached to devos only, with every connector removed and no token; [...] A run records only what the session observes about itself, on a claude/probe-c01-… branch, and never a token, a secret or anything derived from one. The routine is removed when C01 ends."
- For the checker, verbatim from the same file: key_inventory.md line 11 (its rule text, outside the table) still reads "The C01 probe tokens stay listed, as existing, until C02's first migration removes them with the probe schema". Rows 16 and 17 say "never created", and the first migration on main contains no statement about a probe schema (3.2).

## Part 5. What could not be checked

- devos-test's listing after T-W03-05's fixture, and at H2 to H5:
  - The only evidence in files is a count: the compare step's "listing=7 objects", devos-test log line 1458, after the apply in run 38363215668.
  - The executor's reading of the later reports, listing_count "7" at runs 38584684190, 38585268400, 38585846651 and 38586438580, is a reading, not a file I saw.
  - Which seven objects devos-test holds now is not observed. That they match devos's seven is an inference.
- devos-test's listing before the first migration (the first push run after Batu's step) is not among these inputs. Both saved listings come after 20261012184638 had been applied (3.1).
- The later runs' own listing lines are on GitHub. I did not read them, having no GitHub tools.
- The redacted log copies were not compared with the unedited logs on GitHub. Only the plant's base64 lines are marked as replaced ("W03_PLANT_B64: <removed in this copy ...>").
- The connection read: I did not make it. I rely on the executor's record: that it ran the file from line 11 with "now() as read_at" added, at 15:12:08Z, against devos.
- The throwaway is PostgreSQL 16.15 with minimal stand-ins, not 17.6 with Supabase's real catalog, roles and extensions. Its results support the claims about the query and the lists; they are not observations of either project. The derived file ran through psql -c, not through the Supabase connector.
- Not checked because not in this task: the latest comparison result each listing records beside it (M16). devos's log shows FM_READS and DRIFT_RESULT next to its listing (lines 1539 and 1541), but I did not assess them.
- Claude Code's version: not observed (guard denial below).

## Guard denials

- #27950, 2026-10-14T15:13:25Z, rule B7 ("no command lines that carry account credentials"). What matched: "'claude' acts with the account's credentials". The call was "claude --version ...". I followed the rule: I did not try to get the version another way and left it unobserved. The other version commands were rerun without it.
- #28032, about 15:25Z, rule G0 ("readable call"). What matched: "an unbalanced backtick substitution". The first attempt to write this report ended with a check of my own that grepped for a single backtick character. Following "What to do instead", I repeated the same write well-formed, with the check done by character code. The report text never contained a backtick.
- In the same window, guard_report.py also lists #27969 (15:15:02Z, rule G0). That call's working directory is scratchpad/cw98: it is another agent's call, not mine.
- Report: python3 -I tools/guard_report.py --session session_01XyxvJd3RayQk4HCrjurbVH --since 2026-10-14T15:13Z gave exit 0, "2 denied, 84 allowed", hash chain intact, last record #28027. That run came before #28032. It is saved as prb10/guard_report_since_1513Z.out.
