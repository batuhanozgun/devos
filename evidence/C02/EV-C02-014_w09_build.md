---
id: EV-C02-014
item: W-C02-09
kind: build
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (section 1, M09-01; the executor names the agent at filing); section 3 (M09-02) by two further producers, fresh-context subagents of the same session: agent `aa147172b0a972415` (the build, 3.1 to 3.6) and agent `ade5e8c818705b326` (route A's self-check, the copy of w07_idc_real_path.py, 3.7 and 3.8; named by the executor at filing, L-357); section 4 (M09-03) by agent `aae34814c3026b1e9`, a further producer of the same session (named at filing, L-361), its changes for CHK-C02-086 by agent `a0304cd560855cc00` (named at filing, L-362); section 5 (M09-04) by agent `a681fe739bd00cad2` (named at filing, L-366); section 6 (M09-05) by agent `ad37a946776298dc5` (named at filing, L-369)"
main_at: 1cdbb4e99cc5306e4dadf1e431ebbade7b03b68f
date: 2026-10-17
claim: "W-C02-09's build record. Section 1: M09-01, the identity chain's first part, as versioned SQL, its test copy and the client tools/devos_rpc.py; section 3: M09-02, the private helpers, token_role_class()'s six-class literal and route A's TEMPORARY revoke with its self-check, as versioned SQL, and the copy of w07_idc_real_path.py (written at main db6d6be); section 4: M09-03, the seven functions of Mission, need and decision (EV-C02-013 2.2), as versioned SQL, with EV-C02-013's corrections 15 and 16 (written at main 9638f1d, revised on branch claude/c02-w09-m0903 at c3cd1ed for CHK-C02-086); section 5: M09-04, the six functions of Work and effort policy (EV-C02-013 2.3), as versioned SQL, with EV-C02-013 section 17 (written at main d032a84); section 6: M09-05, the five functions of readiness and claim (EV-C02-013 2.4), as versioned SQL, with EV-C02-013 section 18 (written at main 4f01115); offline runs on PostgreSQL 16.15 are supporting evidence, not counted results; section 2 records M09-01's apply to both projects; the applies of M09-02 to M09-04 are recorded in plan/ledger/C02-log.md (L-360, L-364, L-368), and nothing is applied by section 6; each section is judged by a fresh checker of the same session (verdicts named in the log), not independently tested (corrected 2026-10-19, L-371, CHK-C02-091 C1)"
---

# EV-C02-014 · W-C02-09's build

**What this is.** The producers' record of W-C02-09's build, one section per migration of EV-C02-013 section 10's split. Section 1 is M09-01, the identity chain's first part, which merges and is applied alone; then N-221 steps 3 to 6 follow, and nothing of M09-02 to M09-12 is committed before step 6 (EV-C02-013 section 10; `plan/work/C02.md` N-221). It is not a verdict. A checker judges M09-01's pull request at its head, verdict (i), class high (W-C02-09 "Who judges").

**Labels.** **O** observed in this record's offline runs (raw file named, section 1.6); **Doc** read in the source named, at `main_at`; **Inf** inference. EV13 = `evidence/C02/EV-C02-013_w09_interface.md` (with Revision 1, section 13); EV3 = EV-C02-003; EV2 = EV-C02-002; B = `plan/Ek_B_Veri_Modeli.md`; W9 = `plan/work/W-C02-09.md`; R = `tests/C02/W-C02-07/README.md`; M09-01 = `supabase/migrations/20261017230001_w09_identity_chain_first_part.sql`.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `1cdbb4e99cc5306e4dadf1e431ebbade7b03b68f` (PR #351, EV13 Revision 1's tests and CHK-C02-077), clean before this work; branch `claude/c02-w09-m01`. The runs were made on that tree with the three new files uncommitted. The bytes run are fixed by their SHA-256 (O, `13_git_hashes.txt`): M09-01 `273034669fe46bfa78932b5e819551ad7c0bd9bfce0df0944b0cc682185f1052`; the copy `14380e57b5dfdd55b56d4f2ae565f7c59a81115948dff71a2fe9e2f5d8960a38`; `tools/devos_rpc.py` `30c8cf431d32df6c7e93b62e3b9e5f2e475c706b23c1068b16ff1da4dcbbe102`. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only: one throwaway PostgreSQL 16.15 cluster (`PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)`), unix socket only, started in a user namespace (`unshare -U`), deleted after the run. Labelled stand-ins for Supabase (`…/scratchpad/prd10_run/setup.sql`, W-C02-08's stand-ins of `…/scratchpad/prd08c_run/setup.sql` plus the schema `extensions`): `anon`, `authenticated`, `service_role`, `authenticator` (a login granted the three), `auth.users`, `supabase_migrations.schema_migrations`, and the schema `extensions` that Supabase installs extensions into. `postgres` is not a superuser, owns the database and applies every migration, one `psql --single-transaction` per file with its history row; the bootstrap superuser `prd10_super` made only the stand-ins and, in run 07, switched `session_user` to `authenticator` as the Data API's login does. The projects run PostgreSQL 17 and apply with `supabase db push`: these runs observe neither project. No project was reached; no connector was used; no network call was made |
| Criterion version | W9's acceptance block at `main_at` (point 3's second bullet as reworded by the test designer, L-340); EV13 at `main_at` (Revision 1), judged by CHK-C02-076 and CHK-C02-077, with N-279's conditions |
| Input | The thirteen migrations (`main`'s twelve and M09-01); the eight files of `supabase/migrations/tests/` (W-C02-03's three, W-C02-08's four copies, and the copy made here) |
| Raw evidence | `…/scratchpad/prd10_raw/` (`01_init.txt` to `13_git_hashes.txt`), for the executor to file verbatim, as EV-C02-012's were; every file but `13_git_hashes.txt` passed through a filter that removes and counts strings of either DevOS token format, and each reports 0 |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict |

## 1. M09-01: the identity chain's first part

### 1.1 What was built, object by object

All in M09-01, in this order. Every function: `security definer`, owner `postgres` (the migration login), `set search_path = pg_catalog, pg_temp`, every DevOS relation, type and function it names schema-qualified (EV13 1 item 12). O (`06_catalog.txt`): all eight have `definer t` and `search_path=pg_catalog, pg_temp`; all are VOLATILE but `token_hash` (IMMUTABLE).

| Object | What it does | Follows |
|---|---|---|
| `create extension if not exists pgcrypto with schema extensions` | The cryptographic random source. Does nothing where pgcrypto already exists (Supabase installs it in `extensions` by default **[Inf]**; `devos-test`'s first run shows it) | EV13 2.1, section 10 row M09-01, section 12; EV3 1.3 |
| `devos_private.token_hash(token text) returns text` | `select encode(sha256(convert_to(token, 'UTF8')), 'hex')`: SHA-256 of the whole token, built-in `sha256`, lower-case hex. IMMUTABLE, STRICT, SQL | EV13 10 ("the hash rule"); EV3 1.7; M1's `env_tokens.token_hash` check |
| `devos_private.write_event(p_aggregate_type text, p_aggregate_id uuid, p_aggregate_revision integer, p_event_type text, p_payload jsonb, p_role_class text, p_origin devos_private.event_origin, p_declared_session_id text default null) returns bigint` | The one private writer of `devos_private.event`; returns the event's id. Payload `{}` when null | EV13 1 item 10; B 3.13; DM-31 |
| `devos_private.reject_counted(p_function_name text, p_reason_code text) returns void` | The counted-row writer: `insert … (function_name, 'none', reason_code, <the UTC hour>, 1) on conflict (function_name, reason_code, counted_hour) where counted_hour is not null do update set count = count + 1` (the unique index `rejected_attempt_counted_key`). No input content | EV13 1 item 9; DM-19; B:270 |
| `devos_private.caller_role_class(function_name text) returns devos_private.role_class` | The derivation. Reads only the key `x-devos-env-token` of `current_setting('request.headers', true)`; codes in order `header_unreadable` (unset, empty, not JSON, not an object), `missing` (no key, or JSON null), `empty` (the empty string or only whitespace), `malformed` (not a string, or not `^` + marker + `[A-Za-z0-9_-]{43}$`), `unknown`, `revoked`; `could_not_check` when `env_tokens` cannot be read (its own block; reason `env_tokens: its input could not be read (SQLSTATE <code>)`) or its row is partial. The revocation test is `t.revoked_at is null`. Verified: returns the class (a scalar). Otherwise: writes the counted row, sets the transaction-local settings `devos.reason_code` and `devos.reason` (fixed text), returns null. The value and its hash are cleared from its variables after use, and never returned, raised or logged | EV13 1 items 6 (a), 8, 9; 2.1; 10 ("Forms the merged break patches read"); EV3 1.6, 14, 15; `shared/token_format.md` sections 3 and 4 |
| `devos_private.issue_env_token(role_class text) returns text` | Owner only. Token = the environment marker of `shared/token_format.md` section 1 (spelled in two pieces in the SQL text, section 1.2 item 6) + `translate(rtrim(encode(extensions.gen_random_bytes(32), 'base64'), '='), '+/', '-_')` (43 URL-safe characters). Stores `token_hash` only; writes `env_token_issued` on `env_token` (the new row's id), payload `{role_class}`, `role_class` `owner`, `origin` `owner`; returns the token once | EV13 2.1; B:46-47, B 3.27; EV3 1.3, 6.3 |
| `devos_private.revoke_env_token(token_id uuid) returns jsonb` | Owner only. Locks the `env_tokens` row `for update`; unknown id: `{"status":"refused","reason_code":"not_found","reason"}`; already revoked: `{"status":"ok","id","epoch","repeat":true}`, nothing written; otherwise sets `revoked_at`, then (last, DM-01's order) locks the epoch row `for update` and increments it, writes `env_token_revoked` payload `{role_class, epoch}`, `owner`/`owner`, and returns `{"status":"ok","id","epoch"}` | EV13 2.1; B:46, principle 9; EV3 1.4; DM-01; R:393 |
| `devos_api.token_role_class() returns jsonb` | The derivation; verified: `{"status":"ok","role_class"}`; otherwise `{"status":"refused","reason_code","reason"}` from the two settings. VOLATILE; comment `devos:read …` | EV13 2.1 ("all six"; "Token codes only (B:387)"), 1 items 1 and 11; R:436-447 |
| `devos_api.deployment_drift(expected jsonb) returns jsonb` (replaced, `create or replace`) | (1) `session_user` `postgres`, the migration login, admitted first, unchanged; every other caller passes the derivation (refused with its token code), and a class not in the literal `array['devos_ci']::devos_private.role_class[]` is refused `role_class_not_permitted` with one per-call RejectedAttempt row (`role_class` the caller's, fixed `reason`). (2) **VOLATILE** (was STABLE). (3) **Both records read in one statement**: one `select` whose two scalar subqueries aggregate `supabase_migrations.schema_migrations` (`jsonb_object_agg(version, coalesce(name, ''))` and whether any version is NULL) and `devos_private.function_deployment` (`jsonb_object_agg(slug, source_sha256)` and whether any row is incomplete) into two variables, inside the existing exception block; the loops and the comparison read only those. Its other text, its answers to the migration login and its `could_not_check` reasons are as before. Comment `devos:read …` | EV13 2.1 with R1-5; EV3 1.6, 4.1 (row `deployment_drift`), 5.3; DM-36 (a) |
| Grants | `revoke all … from public`, then from `anon`, `authenticated`, `authenticator`, `service_role` where they exist, on all eight functions; `grant execute` on `devos_api.token_role_class()` and `devos_api.deployment_drift(jsonb)` to `anon`; nothing granted on a `devos_private` function. No type is added | EV13 1 item 13; T-W08-PRIV's constraint (N-278 (7)); B section 2 (only the project owner issues and revokes; every `devos_api` function checks the token itself); R:441 |

O (`06_catalog.txt`, part 2): the only EXECUTE held by anyone but the owner on a `devos_api` or `devos_private` function is `anon` on `deployment_drift` and `token_role_class`. Part 3: `pgcrypto | 1.3 | extensions`. Part 4: no `devos_private` type with PUBLIC USAGE. Part 5 (the scan of the eight functions' source for an unqualified relation after FROM, JOIN, INTO, UPDATE or TABLE): one hit, `devos_private.reject_counted | update | set`, which is `on conflict … do update set`, not a relation; no relation is unqualified. The scan is a regular expression over `prosrc`, not a parser: a relation named in dynamic SQL would not be seen, and none of the eight builds dynamic SQL.

**Supporting readings (Doc, local copies, read 2026-10-17).** The single-snapshot reasoning: PostgreSQL 17, "36.7 Function Volatility Categories" (the page saved under `…/scratchpad/pgdocs/xfunc-volatility.txt` on 2026-10-12): "STABLE and IMMUTABLE functions use a snapshot established as of the start of the calling query, whereas VOLATILE functions obtain a fresh snapshot at the start of each query they execute" (EV13 R1-5's [Inf] now cited). The `search_path`: PostgreSQL 16's `CREATE FUNCTION` manual page (`/usr/share/postgresql/16/man/man7/CREATE_FUNCTION.7.gz`), "Writing SECURITY DEFINER Functions Safely": the temporary schema "is searched first by default, and is normally writable by anyone. A secure arrangement can be obtained by forcing the temporary schema to be searched last" (EV13 1 item 12's [Inf]). The block handler: PostgreSQL 17, "41.6 Control Structures" (saved under `…/scratchpad/pgdocs/`, 2026-10-12): "The special condition name OTHERS matches every error type except QUERY_CANCELED and ASSERT_FAILURE" (EV13 1 item 7's [Inf]; for M09-01 it bears on `caller_role_class`'s block: a cancelled call ends with an error and rolls back whole, leaving no counted row).

### 1.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent.

1. **`deployment_drift`'s per-call refusal row is written inline.** EV13 2.1 makes `deployment_drift` refuse a class other than `devos_ci` in M09-01, and 1 item 9 has that refusal write one per-call RejectedAttempt row; but section 10 puts the per-call writer `devos_private.reject` in M09-02. M09-01 keeps section 10's object list and writes that one row with an `insert` in `deployment_drift`'s own text. Alternative: move `reject` into M09-01, a change of the split. M09-02 may replace the insert with `reject`; W-C02-03's three copies then run again (EV13 11).
2. **`token_role_class()` has no role-list literal.** EV13 2.1 gives it all six classes and "Token codes only (B:387)"; 1 item 6 (b) asks each function for its list. Built as 2.1 says: any verified class is answered, so a class added to `devos_private.role_class` later (`devos_ingest`, C04) would be answered with its own class. If a checker reads 1 item 6 (b) as binding here, the literal list of six with a per-call refusal is added.
3. **The counted hour is written `date_trunc('hour', now() at time zone 'UTC') at time zone 'UTC'`**, the UTC hour as a `timestamptz`. EV13 1 item 9 writes `date_trunc('hour', now() at time zone 'UTC')`, a timestamp without time zone, which a `timestamptz` column reads in the session's time zone: a different instant, and in a zone with a part-hour offset a value that `rejected_attempt_form` refuses (its check reads the hour at UTC). Same meaning, exact form.
4. **The refusal's reason travels with its code.** EV13 2.1 (`caller_role_class`'s row, "chosen") has the caller read the reason code from a transaction-local setting. Built with two: `devos.reason_code` and `devos.reason` (the fixed text), so each caller returns the derivation's own reason text. O (`07_tokencheck.txt`): the settings survive the return of a function that has its own `SET search_path` clause (PostgreSQL restores only the variables in the clause **[Inf: from its behaviour here]**).
5. **`revoke_env_token` raises if the epoch row is missing or its update writes no row** (`P0001`, "nothing revoked"): EV13 does not say. Reason: a revocation must never stand without its epoch change (B principle 9; F08 (c)); the owner sees an error and the whole call rolls back. It does not fire under break B-IDC-2 (whose trigger returns the old row, so the update writes a row with the old epoch and IDC-r1 turns red as the break expects). A checker may judge this a rule the record does not ask for; removing it changes no test outcome on this build.
6. **The marker in two pieces.** `issue_env_token` and `caller_role_class` spell the environment marker as two concatenated literals, because only `shared/token_format.md` and the scan's pattern file may hold it literally (R section 6, R:346; R:443), as `w07_idc_real_path.py` does with `ENV_TOKEN_EXACT_PARTS`. The resulting strings are the format of `shared/token_format.md` (O: IDC-f1 `ok`).
7. **Names and signatures EV13 left open (chosen):** `token_hash(token text)`; `write_event`'s eight parameters; the counted-row writer's name `reject_counted(text, text)`.
8. **`revoke_env_token`'s `not_found` writes no RejectedAttempt row.** The function is owner-only, not a `devos_api` function, and the table has no role class for the owner (`rejected_attempt.role_class`'s check, M2).
9. **One `could_not_check` reason can differ in a double fault.** With a NULL history version *and* an unreadable function record, the old function answered "the history holds a row without a version" (it read the history first, alone); the replacement reads both in one statement and answers "a record could not be read: <SQLSTATE>". Both are `could_not_check`; no test plants both.
10. **The client sets no token header** (section 1.7): EV13 section 4 ("no header set by it (the proxy adds it)") and EV3 1.1 and 1.6. The task message said the client reads "its token and keys only from the environment"; it reads no token at all, and its key only from `DEVOS_PUBLISHABLE_KEY`, because EV3 1.1 puts no DevOS credential in any environment variable.

Not departures, for the checker: `deployment_drift`'s migration-login branch is unchanged (`session_user` `postgres`), so a SQL test that runs as `anon` with `session_user` `postgres` takes that branch (IDC-e1 sees its answer). Its token branch is reached only over the Data API (`IDC-dd-*` in part B, after sitting A; N-244 (2)) and here offline, by changing `session_user` (section 1.6, run 07).

### 1.3 How W-C02-09 points 1 to 5 and 7 are served by M09-01's part

- **Point 1.** M09-01 is a versioned file under `supabase/migrations/`, later than `20261014190402`, plain SQL with no `psql` meta-command and no backslash; it creates every object of section 1.1, and nothing creates them another way. Decisions followed, with the object and what shows it: the token's path (header `x-devos-env-token` from `request.headers`): `caller_role_class`, IDC-d-*; the rejected-attempt record, counted for unverified calls: `reject_counted`, IDC-r2 and run 07; the role class of the events the database makes itself (`owner`/`owner`): `issue_env_token`, `revoke_env_token`, IDC-i-* and IDC-r1; F06's read marker (`devos:read`, VOLATILE): both `devos_api` functions, run 06. Offline, `deployment_drift` reported `no_difference` after the apply (O, `04_drift.txt` and `08_drift_after.txt`: `"migrations_applied": 13, "migrations_expected": 13`). The `devos-test`-first apply and the tests passing there before `devos` are the migration job's, after the merge.
- **Point 2.** Two of the 55 `devos_api` functions (`token_role_class`, `deployment_drift` replaced); each with definer rights and the fixed `search_path`, every DevOS name qualified (run 06 part 5). The ✘ look "no application role may create objects in a schema on that path" is **not** met by M09-01: `pg_temp` (CHK-C02-076 C5; N-279 (8); section 1.8).
- **Point 3.** First bullet: `issue_env_token` shows the token once and stores only its hash; looked for by value right after issuing (IDC-v1; run 07: no table, event or rejected-attempt row holds a value, and no function answer or error text did; the server log held no token-format string). Second bullet: both owner-only functions are refused (42501) as every application role and with every class's token (IDC-n-*), and have EXECUTE for no one but the owner (IDC-n-acl, PRIV-facl); no migration file calls either (IDC-file1 `ok`, run 11). Third bullet: a valid token of class X gives X, simulated in SQL (IDC-d-*, labelled `transport sql-set-role` by the test); the real path is part B's (section 1.4). Fourth bullet: no token, empty, malformed, unknown, revoked, and a class other than the function requires are each refused before any other check and recorded (run 07 for both functions; IDC-r2); that the record survives a refused transaction is T-W07-DM19's (section 1.4). Fifth bullet: no declared role or session ID is read by any M09-01 function (none takes one). Sixth bullet: `revoke_env_token` increments the epoch and the revoked token is then refused, another class's is not (IDC-r1 to -r3); "a claim taken in the earlier epoch produces no effect" needs claims (section 1.4).
- **Point 4.** Only its hash rule, which `token_hash` holds for both kinds of token; the claim token itself is M09-05's.
- **Point 5.** The two owner-only functions write their event in the same transaction with `role_class` `owner` and `origin` `owner`; an exact repeat of a revocation writes nothing and raises nothing (run 07: two revocation calls, one `env_token_revoked` event). The two `devos_api` functions write no event (reads; IDC-d-* `events []`).
- **Point 7.** The token header absent, empty, unreadable or not an object is refused with its code, never let through; `env_tokens` unreadable or partial gives `could_not_check`, counted (built; its cases are T-W07-6TK's `6TK-h1` to `-h4`, section 1.4); `deployment_drift`'s records unreadable still give `could_not_check` (W-C02-03's `C10` to `C13`, `PASS (13/13)`).

### 1.4 What M09-01 does not yet serve

- Every other `devos_api` function (53 of 55), the claim token, the private helpers, the transfer functions: M09-02 to M09-12, after N-221 step 6.
- Point 2's catalogue look on `pg_temp` (TEMPORARY on the database): N-279 (8), the executor's route (section 1.8).
- Point 3's real path per class (`IDC-h-*`, `IDC-dd-*`) and `IDC-file1` in `devos-test`: `w07_idc_real_path.py`, copied after sitting A, when `DEVOS_TEST_PUBLISHABLE_KEY` is stored (R:231, R:245). Until then part B gives COULD NOT CHECK (offline run 11: `IDC-http could_not_check`, `apikey is null`).
- Point 3's survival of the record across a refused transaction (T-W07-DM19), the token codes case by case and the derivation's unreadable input (T-W07-6TK parts A and B), the burst count (T-W07-DM19B): their copies are W-C02-09's later pull request (R:247). M09-01's derivation is built for them; they are not run here.
- Point 3's "a claim taken in the earlier epoch produces no effect" (F08 (c)) and point 4: need `claim` and the effects.
- `devos_kurulum` through its network secret in `devos` (N-221 step 5, with `tools/devos_rpc.py`), the log check's parts 1 and 2 (N-221 steps 3 and 6), and sitting A (step 4): the executor and Batu.
- Points 6, 8 (beyond this copy), 9 and 10: later migrations.
- The breaks that rewrite M09-01's text (B-6TK-1, B-6TK-2, B-IDC-1 to -3, B-N17-1): W-C02-13's harness; not run here.

### 1.5 The copy

`supabase/migrations/tests/w07_idc_identity_chain.sql`, copied byte for byte from `tests/C02/W-C02-07/job/w07_idc_identity_chain.sql` (R:231, R:245; W9 point 8). The name is the staged file's own; `migrate.yml`'s test step runs each regular file of `supabase/migrations/tests/` named `[a-z0-9_]+.sql`, in name order, with no backslash in it, and passes it on exit 0 with its `NOTICE: <NAME> PASS (` line (`migrate.yml:708-751`), the form the existing copies have. It is the only copy M09-01's pull request adds (R:231: "no file that the first part does not complete"). O (`13_git_hashes.txt`):

| File | SHA-256 |
|---|---|
| The copy, `supabase/migrations/tests/w07_idc_identity_chain.sql` | `14380e57b5dfdd55b56d4f2ae565f7c59a81115948dff71a2fe9e2f5d8960a38` |
| The staged file at `main` `1cdbb4e` | `14380e57b5dfdd55b56d4f2ae565f7c59a81115948dff71a2fe9e2f5d8960a38` |
| The staged file at its last change, `3e814829e0a04c0552231a7a8ffdb189f148b009` | `14380e57b5dfdd55b56d4f2ae565f7c59a81115948dff71a2fe9e2f5d8960a38` |
| The staged file at W-C02-07's merge, `68070993cebf76a2433256b6180c7dfc80889501` (PR #313) | `14380e57b5dfdd55b56d4f2ae565f7c59a81115948dff71a2fe9e2f5d8960a38` |

`cmp`: identical. `git diff --stat 1cdbb4e -- tests/ supabase/migrations/tests/`: empty (no tracked test file changed).

### 1.6 The offline run, with its raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.** Started 2026-10-17T23:08:42Z, ended 23:08:44Z, one cluster (`…/scratchpad/prd10_run/rerun.sh`); an earlier run of the same sequence stopped in run 07 on a fault of the check script itself (an ambiguous alias), was discarded, and the whole sequence was run again on a new cluster.

- **01, 02** (`01_init.txt`, `02_start_setup.txt`): `[initdb exit 0]`; `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`; `[setup exit 0]`; `postgres|f` (not a superuser).
- **03, the apply** (`03_apply.txt`): the thirteen files, each `[exit 0]` with its history row `[exit 0]`; M09-01's lines: `CREATE EXTENSION`, eight `CREATE FUNCTION`, two `COMMENT`, eight `REVOKE`, `DO`, `[exit 0]`; `[drive apply exit 0]`.
- **04, `deployment_drift` as the migration login** (`04_drift.txt`), `expected` built as `migrate.yml` builds it (13 migrations, `functions: []`, commit `1cdbb4e`):
  `{"commit": "1cdbb4e99cc5306e4dadf1e431ebbade7b03b68f", "status": "no_difference", "compared": {"functions_expected": 0, "functions_recorded": 0, "migrations_applied": 13, "migrations_expected": 13}, "complete": true, "differences": []}`
- **05, every file under `supabase/migrations/tests/`, as the job's test step runs them** (`05_dbtests.txt`; `psql -X -v ON_ERROR_STOP=1 -f <file>`, name order, as `postgres`):
  - `w03_drift_could_not_check.sql: psql:supabase/migrations/tests/w03_drift_could_not_check.sql:230: NOTICE:  W03_DRIFT_COULD_NOT_CHECK PASS (13/13)` / `database test w03_drift_could_not_check.sql: passed`
  - `w03_drift_detects.sql: psql:supabase/migrations/tests/w03_drift_detects.sql:223: NOTICE:  W03_DRIFT_DETECTS PASS (10/10)` / `database test w03_drift_detects.sql: passed`
  - `w03_fixture_apply_read.sql: psql:supabase/migrations/tests/w03_fixture_apply_read.sql:178: NOTICE:  W03_FIXTURE_APPLY_READ PASS (12/12 fields as the fixture file; positive control 2/2; breaks 2/2)` / `database test w03_fixture_apply_read.sql: passed`
  - `w07_5a_no_direct_writes.sql: psql:supabase/migrations/tests/w07_5a_no_direct_writes.sql:383: NOTICE:  W07_5A_NO_DIRECT_WRITES PASS (168/168)` / `database test w07_5a_no_direct_writes.sql: passed`
  - `w07_dm02_revision_append_only.sql: psql:supabase/migrations/tests/w07_dm02_revision_append_only.sql:363: NOTICE:  W07_DM02_REVISION_APPEND_ONLY PASS (21/21)` / `database test w07_dm02_revision_append_only.sql: passed`
  - `w07_idc_identity_chain.sql: psql:supabase/migrations/tests/w07_idc_identity_chain.sql:485: NOTICE:  W07_IDC_IDENTITY_CHAIN PASS (43/43)` / `database test w07_idc_identity_chain.sql: passed`
  - `w08_priv_types_functions.sql: psql:supabase/migrations/tests/w08_priv_types_functions.sql:301: NOTICE:  W08_PRIV_TYPES_FUNCTIONS PASS (89/89)` / `database test w08_priv_types_functions.sql: passed`
  - `w14_sch_transfer_schema.sql: psql:supabase/migrations/tests/w14_sch_transfer_schema.sql:498: NOTICE:  W14_SCH_TRANSFER_SCHEMA PASS (38/38)` / `database test w14_sch_transfer_schema.sql: passed`

  W-C02-03's three copies pass again with the replaced `deployment_drift` (EV13 R1-5; CHK-C02-076 C7). The IDC copy's 43 rows are all `ok`, among them `IDC-r2 | ok | the revoked working token: code revoked; err - ; ra {"token_role_class|revoked|none": 1}; events []; changed []; echo false; as anon (session_user postgres)`, `IDC-v1 | ok | tables holding a token value: none; not searched (not readable as owner): auth.users` (the stand-in, owned by the bootstrap superuser), `IDC-n-acl | ok | issue/revoke functions with EXECUTE for PUBLIC (or the default ACL) or an application role: 0 (wanted 0)`. T-W08-PRIV's rows for the six new private functions are `ok` (`PRIV-facl:caller_role_class(text) | ok | owner postgres; ACL {postgres=X/postgres}; grantees other than the owner: none`, and the same for `issue_env_token(text)`, `reject_counted(text,text)`, `revoke_env_token(uuid)`, `token_hash(text)`, `write_event(text,uuid,integer,text,jsonb,text,event_origin,text)`), and `PRIV-fexec:<role>` reads "asked on all 7 function(s) of devos_private; true on: none" for `anon`, `authenticated`, `authenticator`, `public`, `service_role`.
- **06, the catalogue** (`06_catalog.txt`): section 1.1's listing.
- **07, W9 point 3 by value, and `deployment_drift`'s token branch** (`07_tokencheck.txt`; `…/scratchpad/prd10_run/tokencheck.sql`, one transaction, rolled back; the six tokens issued as owner at run time and held only in transaction-local settings, never printed or stored). As owner: `revoke_answer` `{"id": "…", "epoch": 2, "status": "ok"}`; `revoke_again_answer` `{"id": "…", "epoch": 2, "repeat": true, "status": "ok"}`; `revoke_unknown_id_answer` `{"reason": "no environment token row has this id", "status": "refused", "reason_code": "not_found"}`. As `session_user` `authenticator`, `current_user` `anon`:
  - `devos_ci`: `deployment_drift(null)` → `{"reason": "expected is missing or not an object", "status": "could_not_check", "complete": false, "differences": []}` (passed the gate); `token_role_class()` → `{"status": "ok", "role_class": "devos_ci"}`
  - `devos_denetim`: `deployment_drift` → `{"reason": "deployment_drift admits only the role class devos_ci", "status": "refused", "reason_code": "role_class_not_permitted"}`; `token_role_class()` → `{"status": "ok", "role_class": "devos_denetim"}`
  - `devos_kurulum`: `deployment_drift` → `role_class_not_permitted`, as above
  - the revoked working token: both → `{"reason": "the environment token is revoked", "status": "refused", "reason_code": "revoked"}`
  - a token cut by one character: both → `malformed`; one with its last character changed: both → `unknown`; `"   "`: `token_role_class()` → `empty`; `{}`: `deployment_drift` → `missing`; `not json`: `token_role_class()` → `header_unreadable`

  Then as owner: `prd10 value search: 29 tables searched; tables holding a token value: none; not readable: auth.users`; `events_holding_a_value 0`; `rejected_holding_a_value 0`; `env_rows_holding_a_value 0`; `env_rows_holding_its_hash_rule 6`. RejectedAttempt: eleven rows, nine counted under `none` with `count` 1 (`deployment_drift` `malformed`, `missing`, `revoked`, `unknown`; `token_role_class` `empty`, `header_unreadable`, `malformed`, `revoked`, `unknown`) and two per-call rows (`deployment_drift | devos_denetim | role_class_not_permitted` and `… | devos_kurulum | …`, reason "deployment_drift admits only the role class devos_ci"). Events: six `env_token_issued` (payload `{"role_class": …}`) and one `env_token_revoked` (`{"epoch": 2, "role_class": "devos_calisma"}`), all `owner`/`owner`. After the rollback: `env_tokens`, `rejected_attempt` and `event` hold 0 rows. `[psql exit 0]`.
- **08** (`08_drift_after.txt`): `deployment_drift` again, `no_difference`, 13 of 13.
- **09, the server log** (`09_server_log_scan.txt`): `prd10 log scan: …/prd10_pg/log: 4 lines; token-format strings: 0`.
- **10** (`10_stop.txt`): `[pg_ctl stop exit 0]`; the cluster's directory was then deleted.
- **11, IDC-file1** (`11_idc_file_look.txt`; the staged `w07_idc_real_path.py` run on a scratch copy of the tree's thirteen migrations, input `{"endpoint": null, "apikey": null, "tokens": {}, "revoked_token": null}`, so no request was made): `IDC-file1	ok	13 migration files; statements that call issue_env_token or revoke_env_token: none`; `IDC-http	could_not_check	apikey is null: …`; `W07_IDC_REAL_PATH COULD NOT CHECK (1 of 2 could not be checked)`; `[exit 3]`.
- **12, the client** (`12_client_selfcheck.txt`; no key set, so no request): `[py_compile exit 0]`; `devos_rpc: could not call devos_api.token_role_class: DEVOS_PUBLISHABLE_KEY is not set` `[no key: exit 3]`; `[bad name: exit 2]`; `[array input: exit 2]`; with a synthetic claim-format string made at run time in an answer: `printed line holds the synthetic claim token: False | withheld marker present: True`.
- Every raw file but `13_git_hashes.txt` (hashes and git output only) ends `prd10 scrub (<file>): 0 token-format strings removed`.

### 1.7 The client, `tools/devos_rpc.py`

As EV13 section 4 and EV3 1.1 and 1.6 design it: one Data API remote procedure call, `POST https://zyqgltzfzkdvrmvxlamz.supabase.co/rest/v1/rpc/<function>` (the live project `devos` only, EV3's fixed names; no session calls `devos-test`, EV3 1.5), with `apikey` from `DEVOS_PUBLISHABLE_KEY` (EV3 section 7) and `Content-Profile` / `Accept-Profile` `devos_api` (as `w07_idc_real_path.py` sends them). It sets no `x-devos-env-token`: the proxy adds it from the environment's network secret. The function's named arguments come on standard input as a JSON object (so a claim token passed to `heartbeat` is never on a command line). It prints the answer as one JSON line; a `claim_token` in an answer is withheld from the printed line and any token-format string is removed from printed text, while `call()` returns the whole answer to a Python caller. It never prints a header or the key and writes no file. Exit 0 `ok`, 1 refused, 2 usage, 3 could not call. N-221 step 5: `python3 -I tools/devos_rpc.py token_role_class < /dev/null`, expecting `{"role_class": "devos_kurulum", "status": "ok"}`. It was not run against any project. Its stdlib-only, `argparse`-free form follows `tools/`' small single-purpose scripts; W-C02-20 lets sessions use it (EV13 4) and decides whether the guard allows it.

### 1.8 Open, and for whom

- **D-9 / N-279 (8), the executor's route, before verdict (i).** Route A puts `revoke temporary on database … from public` (and the four roles) into M09-01 itself (EV13 5 D-9), with what must be observed first in `devos-test`. M09-01 does not hold it: section 10's row does not list it, and the route is not chosen. If Route A is chosen, M09-01 is revised before its merge; if Route B, point 2's look is changed through the acceptance-change route with a checker.
- **`migrate.yml`'s token steps call `devos_private.revoke_env_token(:'tok')` with the token's value** (`migrate.yml:812` and `:915`; their comment at `:901-903` says W-C02-09 fixes the signature and the step changes with it). EV13 2.1 and R:393 fix the argument as the row's id, `uuid`. Those steps run only when a `*.py` file is under `supabase/migrations/tests/` (none now, none in this pull request). Once one is copied (after sitting A), the call fails with SQLSTATE 22P02, and PostgreSQL's error text for a bad `uuid` input quotes the input, so the token's value would reach psql's captured error and, under default logging, `devos-test`'s Postgres log **[Inf: PostgreSQL's usual message form, not run here]**. For the executor (class high), before the first program copy: revoke by id (the job can find each id as the one row its issue added, as IDC's `w07_issue` does, or have the issue step return the id).
- **Supabase's `extensions` schema and pgcrypto there** (EV13 12): `devos-test`'s first run shows them; if pgcrypto sits in another schema there, `issue_env_token` fails and IDC gives COULD NOT CHECK, which holds `go` at `no`.
- **The breaks of M09-01's text** (B-6TK-1, B-6TK-2, B-IDC-1 to -3, B-N17-1): W-C02-13. The forms they rewrite are in M09-01 (`t.revoked_at is null` in `caller_role_class`; the scalar return; the hash rule in `token_hash`).
- **Section 1.2 items 2 and 5**, for the checker's judgment.

*Filed 2026-10-17 by the executor (L-342):* written by the producer, agent `a167a0843565bed6c`. Its offline raw outputs (01 to 13) are filed verbatim as `evidence/C02/raw/EV-C02-014_m01_offline_*.txt`.

*Added 2026-10-17 (L-343; CHK-C02-078 C1):* section 1.8's "If Route A is chosen, M09-01 is revised before its merge" no longer holds. The executor chose Route A for the pull request that adds M09-02 (N-279 (8), L-342), and moves CHK-C02-076 C5's deadline there, subject to the verdict CHK-C02-079 (N-279 (8), L-343). M09-01 holds no TEMPORARY revoke, and point 2's catalogue look is not met by M09-01 (section 1, point 2).

## 2. M09-01 applied to both projects (run 39080179634; filed 2026-10-17, L-345)

The merge of #352 (`7a6f3eaa516da3823013c1e83a3e0a46868fc096`, 23:44:40Z) started the migration job's run 39080179634. Raw: `evidence/C02/raw/EV-C02-014_m01_apply_run39080179634_devos-test_job117535365247.log`, `…_devos_job117535428449.log`, and the job list with `devos`'s catalogue in `evidence/C02/raw/EV-C02-014_m01_apply_devos_catalog_20261017T2348Z.md`.

- **`devos-test`** (job 117535365247, 23:44:44Z to 23:45:01Z): `cli: Applying migration 20261017230001_w09_identity_chain_first_part.sql...`; `comparison in devos-test: result=no_difference call=ok`; the eight copies passed: `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (89/89)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`; `devos-test go=yes (head=yes apply=success comparison=no_difference tests=success programs=success revocation=success)`. This is the counted run on the projects' PostgreSQL (17), as section 1's offline runs were not.
- **`devos`** (job 117535428449, 23:45:05Z to 23:45:23Z): before its apply `comparison in devos: result=differences`, `on_main_not_applied 20261017230001`; `decide: apply=yes result_kind=differences exception=not_taken; only migrations on main, not applied: 1`; `cli: Applying migration 20261017230001_w09_identity_chain_first_part.sql...`; after it `comparison in devos: result=no_difference call=ok`.
- **`devos`'s catalogue** (read-only connector, about 23:48Z): the two `devos_api` and seven `devos_private` functions (six new ones and `refuse_change`), each definer-rights but `refuse_change`, each with `search_path=pg_catalog, pg_temp`; the two `devos_api` functions' ACL `{postgres=X/postgres,anon=X/postgres}`, every `devos_private` function's `{postgres=X/postgres}`; 13 migrations applied, the last `20261017230001`; pgcrypto in `extensions`; 0 rows in `env_tokens`.
- **Not shown here:** point 2's catalogue look (N-279 (8), M09-02's pull request); the real path (N-221 step 5, after sitting A and W-C02-20's change 2); the verdict (ii) of these applies, which W-C02-09's "Who judges" (ii) gives with the item's later applies.

## 3. M09-02: the private helpers, the six-class literal and Route A

The producer's record of `supabase/migrations/20261018203001_w09_private_helpers.sql` (M09-02), written at `main` `db6d6bea49c3990e2a197ec853af7d8471f483cb` on branch `claude/c02-w09-m0902`. It is not a verdict. Lines cited as EV13:n, B:n are at that commit. M09-02 = the file above. A second producer, fresh-context subagent of the same session (the executor names the agent at filing), added Route A's self-check to M09-02, the copy of `w07_idc_real_path.py`, and sections 3.7 and 3.8 for EV13 R1-12, and brought 3.1 to 3.5 in line with them.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | `main` `db6d6be`, clean before this work; the runs were made with M09-02 uncommitted. Bytes run in runs 18 to 39 (O, `40_git_hashes.txt`): M09-02 `080333bad93831a74952b800119903efe6cb1d26f7019cd46fa2b15bd8de91c1`, the text with Route A's self-check (3.7); the program copy `supabase/migrations/tests/w07_idc_real_path.py` `093b7c3a1d0cda5402793885ed2e4f131dd150a1c357573232d236aaac13f66a`; the IDC copy `14380e57…a38` (unchanged, equal to its staged file). Runs 01 to 17 were made on the earlier text of M09-02, `a5e7860ac5691d7ccde31cc5e79651f76b7fc925a38644876b0fed74ce97fa9b` (O, `17_git_hashes.txt`), which differs from the current one only in Route A's block and the file's header comment; every step of 01 to 17 that touches M09-02 was run again on the current bytes in 18 to 39 (3.8). A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as section 1's: one throwaway PostgreSQL 16.15 cluster, unix socket only, in a user namespace (`unshare -U`), deleted after the run (O, `15_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: section 1's (`…/scratchpad/m0902_run/setup.sql`, lines 1 to 22 unchanged), plus five of Supabase's service roles by their platform names (`supabase_auth_admin`, `supabase_storage_admin`, `supabase_etl_admin`, `supabase_read_only_user`, `dashboard_user`; none a superuser, none a role the four API roles belong to) and the database ACL set to the one the executor read on `devos` on 2026-10-18 (O, `04_temporary_before.txt`: `{=Tc/postgres,postgres=CTc/postgres,supabase_etl_admin=C/postgres,supabase_storage_admin=C/postgres,dashboard_user=CTc/postgres}`). The projects run PostgreSQL 17 with Supabase's own role set, which these runs do not have; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `db6d6be`; EV13 with Revisions 1 and 2 (judged by CHK-C02-076, -077 and -081); N-279 (8) with its annotations L-342 to L-344 |
| Input | The fourteen migrations (`main`'s thirteen and M09-02); the eight SQL files of `supabase/migrations/tests/` and, from run 18 on, the program copy `w07_idc_real_path.py`; three staged files of `tests/C02/W-C02-07/job/` run in place; in runs 22 to 26, M09-02 and three break copies of it made outside the repository |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m02_offline_01_init.txt` to `…_17_git_hashes.txt` (the first producer) and `…_18_init_setup.txt` to `…_40_git_hashes.txt` (the second); every file but `17` and `40` passed through section 1's filter, and each ends `0 token-format strings removed` |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producers; not a verdict. The helper checks of runs 11 and 34 and the breaks of runs 22 to 26 are the producers' own (sections 3.6 and 3.8) |

### 3.1 What was built, object by object

All in M09-02, in this order. Every function: `security definer`, owner `postgres`, `set search_path = pg_catalog, pg_temp`, every DevOS relation, type and function it names schema-qualified (EV13 1 item 12). O (`10_catalog.txt`): all fifteen functions of the two schemas carry `search_path=pg_catalog, pg_temp`, and all but W-C02-08's trigger function `refuse_change` are definer-rights; the new ones are VOLATILE but `scope_within` (IMMUTABLE).

| Object | What it does | Follows (EV13) |
|---|---|---|
| The inner-block SQLSTATEs | Stated in the file's header as the contract the later `devos_api` functions follow: `P0D01` for a refusal a read-block check decides (the check first sets `v_code`, `v_reason`); `P0D02` for a write-path check that cannot read its input (fixed reason as its message), mapped to `could_not_check` by the write block; any other error `could_not_check` in the read block, `write_failed` in the write block. No helper raises or catches either code: each returns its decision and lets an error in reading its input reach the caller's read block | 1 item 7 with R1-1 (EV13:46-54); 10 row M09-02 (EV13:300) |
| `devos_private.reject(p_function_name text, p_role_class devos_private.role_class, p_reason_code text, p_reason text, p_declared_session_id text default null, p_target_ref uuid default null, p_target_revision integer default null) returns jsonb` | Writes one per-call RejectedAttempt row (role class, code, fixed reason, declared session, `target_ref`, and `target_revision` only beside a `target_ref`); returns `{"status": "refused", "reason_code", "reason"}` and no other key. A failed write raises, so the call ends with an error and rolls back whole. NULL reason: the fixed text "the function gave no reason" | 1 items 7 (after the blocks) and 9; DM-19; B:270 |
| `devos_private.scope_within(p_scope text, p_container text) returns boolean` | `p_scope = p_container or left(p_scope, length(p_container) + 1) = p_container || '.'`: equal, or under it label by label; STRICT (NULL in, NULL out); IMMUTABLE SQL | DM-34 (a); B principle 4 (B:18); 2.3 `admit_work`, 2.6, 2.7 |
| `devos_private.check_claim(p_claim_token text, p_work_id uuid, p_role_class devos_private.role_class, p_for_update boolean default false) returns jsonb` | The claim check of an effect, in 2.4's order: `claim_missing` (NULL or whitespace token), `claim_unknown` (hash names no Assignment, or one of another work item, same reason text), `claim_not_active`, `claim_expired` (`lease_expires_at <= now()`), `claim_generation` (below the work item's newest), `claim_epoch` (not the global epoch), `claim_class` (not the caller's). Locks in DM-01's order: the work item's row, the claim, then the global epoch's row `for share`; the work item and the claim `for share`, or `for update` when `p_for_update`. Missing or NULL input it needs (the work row, the claim, its status, lease, generation, either epoch, a role class): `could_not_check` with the input named. A cancelled work item: `claim_not_active`. `p_work_id` NULL skips the work-item match (for `heartbeat`, `release`). Answer: `{"status": "ok", "assignment_id", "work_id", "work_revision", "generation", "authority_epoch", "lease_expires_at"}` or a refusal in the answer form, which the caller turns into `v_code`/`v_reason` and `P0D01`. The token's hash is computed by `devos_private.token_hash` and cleared after use | 2.4 (EV13:112); 2.3 `cancel_work` (EV13:104); 1 item 7 (ii); DM-01, DM-06; B 3.5 (B:160); 10 "Forms" (name contains `claim`, EV13:317) |
| `devos_private.hard_dependency_cycle(p_from uuid, p_to uuid) returns boolean` | First `pg_catalog.pg_advisory_xact_lock(9001, 1)`, the one queue of every hard-dependency write; then a recursive walk from `p_to` over `depends_on` relations that are hard and not retracted: true when it reaches `p_from` (or `p_from = p_to`), false when not, NULL when the walk reaches an edge with NULL `type`, `hard`, `validity` or `to_ref` and no definite path exists | 2.5 `cycle`; DM-01 (EV2:106); B 3.4 (B:147); 10 "Forms" (name contains `cycle`, EV13:317) |
| `devos_private.is_installation_mission(p_mission_id uuid) returns boolean` | Reads `devos_private.event` only. The Mission's creation event is its first event (lowest id) on aggregate `mission`: `transferred` gives true, another type false; no event, a NULL type, or another Mission whose creation event is `transferred` (or of NULL type) gives NULL | 2.3 "The installation's Mission", R2-6 (EV13:97); 4 hook (EV13:207); 1 item 7 (ii) |
| `devos_private.ready_value(p_work_id uuid, p_own_claim uuid default null) returns boolean` | Three-valued readiness: execution `planned`/`ready`/`waiting`; the Mission (through the current revision's `mission_revision`) `active`; no active claim with `lease_expires_at > now()` other than `p_own_claim`; every group of current hard `depends_on` relations true (ALL / ANY under B principle 6; a relation without `group_id` is a group of one). Member: a Work true when `acceptance` is `accepted`, a Need when `resolved`, a Decision when `answered` or `accepted`; false in another state; unknown when in none of the three families, when the named revision does not exist or a revisioned target is named without one, or when a state field it is judged on is NULL. Joined three-valued; NULL for a missing work item or Mission, an active claim with a NULL lease, a claim with a NULL status, a relation with NULL `type`, `hard` or `validity`, a `group_id` without `group_mode`, or a group with two modes | 2.4 with R2-5 (EV13:110); B principle 6 (B:20); B 3.5 (B:158); DM-06; W9 point 7 |
| `devos_api.token_role_class()` (replaced, `create or replace`) | As M09-01's, plus step 1 item 6 (b): a verified class not in `array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup']::devos_private.role_class[]` is refused `role_class_not_permitted` through `devos_private.reject`. Same signature, VOLATILE, comment `devos:read …`. No read or write block: it has no check after (b) | 2.1 with R2-8 (EV13:80); 1 items 6, 9, 11; B:48 |
| Grants | `revoke all … from public`, then from the four API roles where they exist, on all seven functions; `grant execute` on `token_role_class()` to `anon` again; nothing granted on a `devos_private` function; no type added | 1 item 13 (EV13:62); 10, T-W08-PRIV's constraint |
| Route A (one `do` block, last) | (1) `grant temporary on database <current> to <role>` for every role of `pg_roles` that is not a superuser, not a predefined `pg_` role, not one of the four API roles, not a role one of them is a member of (`pg_has_role(…, 'MEMBER')`), not the database owner, and holds no TEMPORARY entry of its own; (2) `revoke temporary on database <current> from public`; (3) the same from each of `anon`, `authenticated`, `authenticator`, `service_role` that exists; (4) the self-check (3.7): it raises, failing the whole migration, unless `postgres` has TEMPORARY, PUBLIC and each of the four have none, and every role that had TEMPORARY when the block began (read before step (1)), other than the four and the `pg_` roles, still has it. The database name is `current_database()`, put in with `format('%I')`, since GRANT and REVOKE take a name, not an expression. CONNECT is untouched | 5 D-9 with R1-12 (EV13:230); N-279 (8), L-342 to L-344; CHK-C02-079 finding 1.5; W9 point 2 |

O (`10_catalog.txt`): EXECUTE held by anyone but the owner on a function of either schema: `anon` on `deployment_drift` and `token_role_class` only. No `devos_private` type with PUBLIC USAGE. The literal as the catalogue holds it: `array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup']::devos_private.role_class[]`. The scan of every function's source for an unqualified relation after FROM, JOIN, INTO, UPDATE or TABLE gives four hits: `check_claim | from | p_work_id`, `is_installation_mission | from | p_mission_id` and `ready_value | from | p_own_claim`, each the `is distinct from <parameter>` comparison, not a relation, and M09-01's `reject_counted | update | set` (`on conflict … do update set`). No relation is unqualified. As in section 1.1, the scan is a regular expression, and no M09-02 helper builds dynamic SQL (only the Route A block does, over role and database names). Locks in the text the break patches read: `check_claim` holds five `for share`/`for update` clauses and no advisory lock; `hard_dependency_cycle` one `pg_advisory_xact_lock(` and no row lock.

### 3.2 Route A: the decision on granting TEMPORARY back, its reason and its residual

**What the facts allow.** The executor read on `devos` (2026-10-18) that `postgres` owns the database and holds TEMPORARY by its own entry (`postgres=CTc/postgres`), and that PUBLIC's TEMPORARY was granted by `postgres` (`=Tc/postgres`). So the migration login can revoke it, and keeps TEMPORARY when PUBLIC loses it. Route A can be made by the migration login. O (runs 04 to 06): on the stand-in with that ACL, the apply ran as `postgres` (not a superuser) with `[exit 0]`, and `postgres_own_temporary_entry` is `t` before and after.

**Decided: grant TEMPORARY back, explicitly, to every role that had it only through PUBLIC, but the four API roles** (and the roles left out in 3.1). Alternatives weighed:
1. *No grant back* (a static revoke only). Every Supabase service role without its own entry (on `devos`, all but `postgres` and `dashboard_user`; `supabase_storage_admin` and `supabase_etl_admin` hold CREATE only) loses TEMPORARY. DevOS gains nothing from that: point 2's ✘ look is about application roles (W-C02-08 point 4: the roles a publishable key, an environment token or a job credential reaches), and a temporary object lives only in the session that made it. The cost is unknown and partly unobservable. Whether a service creates temporary objects can show at any time, for example in a service's own migrations at a platform upgrade (Supabase Auth runs as `supabase_auth_admin`, Storage as `supabase_storage_admin` **[Inf: from the roles' names and general knowledge of the platform, not read]**), which `devos-test`'s first apply does not exercise. Not chosen.
2. *A fixed list of service roles.* It stays static, but the list would rest on memory: neither project's role list was read (the executor read the ACL and the four roles' memberships only), `devos-test` was not read at all, and the set changes with platform versions. A role missed loses TEMPORARY; a role named that does not exist would have to be skipped by a lookup in any case. Not chosen.
3. *Chosen: the grant reads `pg_roles` at apply time.* This is the reason dynamic SQL over `pg_roles` is needed: it is the only form that restores, on each project as it stands, exactly the privilege PUBLIC gave, with no guess about the platform's roles. It is shown, not assumed. O: the list of every role's `has_database_privilege(…, 'TEMPORARY')` before and after (runs 04 and 06, compared line by line) differs only in `anon`, `authenticated`, `authenticator`, `service_role` (t to f) and PostgreSQL's fourteen predefined `pg_` roles (t to f). Every service stand-in keeps TEMPORARY, and creates a temporary table after the apply. The predefined roles are left out on purpose. None can log in, and each of their members other than the four gets an entry of its own, so no login role's effective privilege changes but the four's. Granting to them would give TEMPORARY to any future member, such as an API role made a member of `pg_read_all_data`.

**Residual.**
- A role created after the apply (a new Supabase service at a platform upgrade) gets no TEMPORARY, where before it had it through PUBLIC. If such a service needs temporary objects it fails. The remedy is a migration granting TEMPORARY to that role by name, never to PUBLIC.
- A platform operation that resets the database's ACL could give PUBLIC TEMPORARY again. Point 2's look holds only as of its last reading. The look (below) has to be repeated when the item's verdicts are given, and after a platform upgrade. For the executor: whether a recurring check carries it (for example C03's audit).
- The platform's guard on its reserved roles (Supabase's `supautils` extension) might refuse a GRANT or REVOKE naming one of its roles **[Inf: not read; how `supautils` treats object grants to reserved roles is not known here]**. The failure is safe. `devos-test`'s apply then fails, and the migration job applies nothing to `devos`. The executor then chooses between alternative 1 and route B.
- The stand-ins have five service roles; Supabase has more, and some (`supabase_admin`) are superusers. The run shows the rule on the stand-ins, not on the platform's set.

**What `devos-test`'s first apply must show before `devos` (R1-12; CHK-C02-079 finding 1.5), and how the catalogue look is shown.** (a) `postgres` keeps TEMPORARY by an entry of its own, not through PUBLIC. (b) PUBLIC and each of the four have none. (c) The Data API, the dashboard and Supabase's other services still work. The catalogue look of W9 point 2, the same statements as run 04/06's `temp_look.sql`:
- `select d.datacl::text from pg_database d where d.datname = current_database();`: PUBLIC's entry is `=c/postgres` (no `T`); none of `anon`, `authenticated`, `authenticator`, `service_role` has an entry with `T`; `postgres=CTc/postgres` is there;
- `select r, has_database_privilege(r, current_database(), 'TEMPORARY') from unnest(array['public', 'anon', 'authenticated', 'authenticator', 'service_role', 'postgres']) r;`: false for the first five, true for `postgres`;
- the entries from `aclexplode(datacl)` with their grantor, showing which service roles the grant-back named.

On `devos` the read-only connection can run these after the apply. In `devos-test`, before `devos`: (a) and (b) are checked inside the apply by M09-02's self-check, (c) by the self-check for Supabase's services, by the program copy's run for the Data API, and by a reading for the dashboard (3.7).

### 3.3 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. Where the record and a merged test pull apart, the side taken is the test's (none is changed).
1. **The SQLSTATEs are a contract in the file's text, not an object.** Section 10 puts them in M09-02's row. No catalogue object holds an SQLSTATE, and none of M09-02's helpers raises one: a helper cannot set its caller's `v_code` and `v_reason`, which item 7 (i) says the check sets before `P0D01`, so each helper returns its decision and the caller raises. Run 11 part B shows the pattern working with these helpers (3.6).
2. **`check_claim` refuses a cancelled work item `claim_not_active`.** 2.4's list of the claim check has no such step. 2.3's `cancel_work` row says the late effect of a claim that stays active "is refused by the claim check (section 2.4)", so the check reads the work item's `execution`, which it locks anyway. The code is chosen; item 14 has none closer.
3. **`check_claim`'s signature, answer and lock modes are chosen.** `p_work_id` NULL serves `heartbeat` and `release`, which take only the claim token. `p_for_update` takes the work item and the claim `for update` for a function that changes the claim (DM-01 has `release` lock the work item for update), so that function need not upgrade a share lock. Missing or NULL inputs give `could_not_check` (item 7 (ii)), as 6RG-e1, -e3 and -l4 expect at an effect.
4. **`ready_value` takes `p_own_claim`.** F08 (a) re-checks the work item's hard dependencies at the effect (F08-a, -pos2), where the caller's own active claim would otherwise make the item "not ready". The effect calls `ready_value(work, its verified claim)` after `check_claim`, so the other conditions (Mission active, execution) are re-checked at the effect too. Whether M09-07 and M09-08 call it so is theirs.
5. **What makes a readiness member unknown.** 2.4 says "unknown when the target is missing or unreadable". Chosen: a Work member's `execution` and `acceptance` are both read, and a NULL in either is unknown. That is 6RG-g1, which plants the member's `execution` NULL and expects "not listed", while the member's truth rests on `acceptance` only (no C02 function writes `finished`, 2.4). A target in none of the three families, a Need named with a revision (a Need has none) and a group with two modes are unknown too, the side that is never ready.
6. **Readiness counts current hard dependencies; the cycle check counts every one that is not retracted.** 2.4 names "current". For B 3.4's "In hard dependencies a cycle is rejected" a stale hard dependency is still one, and refusing the closing edge is the side that keeps the graph acyclic if it becomes current. A checker may judge this stricter than needed.
7. **`is_installation_mission` answers NULL when two Missions' creation events are `transferred`.** 2.3 says "the one Mission". A second can only be planted (`transfer_mission` refuses it, 3.2), and NULL is then `could_not_check`, never a wrong owner.
8. **`hard_dependency_cycle`'s advisory key `(9001, 1)` is chosen**, in the two-key space, which no one-key lock (for example `record_ledger_entry`'s lock on an entry ID, 3.2) can collide with. The lock is taken in the helper. A caller calls it before locking the work item's row (DM-01's order); `relate` and `transfer_relation` (M09-06, M09-11) must do so.
9. **`reject`'s signature and its two small rules are chosen**: a NULL reason becomes fixed text, and `target_revision` is kept only beside a `target_ref` (the RejectedAttempt record names "`target_ref` (+`target_revision`)").
10. **A seventh role class cannot be refused in the answer form.** `rejected_attempt.role_class` and `event.role_class` are CHECKs listing the six classes (and `none`, `owner`), so `reject`'s row for a seventh class violates the check: the call raises SQLSTATE 23514 and gives no answer, which is a refusal (nothing is let through) but not 2.1's returned one (O, run 12 (a)). With the check widened, it is refused `role_class_not_permitted` with one per-call row (run 12 (b)). A migration that adds a class (`devos_ingest`, C04) widens those two checks; this file does not.
11. **Route A is one `do` block with dynamic SQL**, where the task asked for a static migration unless dynamic SQL is shown to be needed. 3.2 gives the reason for the grant over `pg_roles`. The database's name is put in with `format('%I')` because GRANT and REVOKE take a name, not `current_database()`. The revoke from the four is guarded by their existence, as every earlier DevOS migration guards them.
12. **`deployment_drift`'s inline refusal row (section 1.2 item 1) is kept.** Replacing it with `reject` is outside M09-02's row; W-C02-03's three copies passed again here regardless (run 08).
13. **Names and files.** The version is `20261018203001`. This record's file is `EV-C02-014_w09_build.md`; the task message named it `…_w09_build_record.md`.
14. **Route A checks its own effect inside the migration.** EV13 D-9 asks the record to show the catalogue look and asks for what must be observed first in `devos-test`; it does not ask the migration to raise. The executor chose this route for R1-12 (3.5 item 1, option (i)); 3.7 gives its conditions. The look of 3.2 is still the record's, in `devos` after its apply.
15. **Condition (c) is stricter than the grant-back's exclusions.** The grant-back leaves out every role one of the four API roles is a member of (3.1), and (c) leaves out only the four and the `pg_` roles. So in a project where such a role exists, is not a superuser and had TEMPORARY, the self-check raises naming it, and `devos-test`'s apply fails. That is the safe side, and the executor then decides. On the stand-ins no such role exists. In `devos`, the executor read the four roles' memberships (3.2, alternative 2), and the stand-ins were set up from that reading with none; `devos-test` was not read.
16. **What "has TEMPORARY" means in each condition.** (a), (b) for the four, and (c) use `has_database_privilege`, the effective privilege, so a role that gets it by inheritance counts (break B2) and a superuser always passes. (b) for PUBLIC reads the ACL's PUBLIC entry, using `acldefault` when the database has no ACL, as well as `has_database_privilege('public', …)`. A `revoke` that revokes nothing, for example one whose grant was made by another grantor, only raises a warning in PostgreSQL. (b) turns that case into a failure (break B1). `has_database_privilege` does not count a `set role` route through a membership without inheritance (CHK-C02-084 case X2), so (b) does not catch an API role that can switch to a role holding TEMPORARY; none exists on `devos` by the executor's reading, and `devos-test`'s memberships were not read: a residual. *[Correction, 2026-10-18, L-358; CHK-C02-084 C2]*

### 3.4 How W-C02-09's points are served by M09-02, and what is not yet served

- **Point 1.** A versioned file later than `20261017230001`, plain SQL, no `psql` meta-command, no backslash (O: none in the file). Decisions followed, with the object: the rejected-attempt record's per-call form (`reject`; run 11 J1 to J4, B2 to B5); the claim expiry computed, not a job (`check_claim`'s `lease_expires_at <= now()`, `ready_value`'s lapsed claim counted as none; C9, R4); F08's re-check inputs (`check_claim`, `ready_value` with `p_own_claim`; C1 to C19, R3, R31). Offline, `deployment_drift` reports `no_difference` with 14 of 14 after the apply (runs 07 and 13).
- **Point 2.** Definer rights and the fixed `search_path` on the seven functions, every DevOS name qualified (3.1's scan). **The ✘ look on `pg_temp` is met on the stand-in** (3.2; runs 04 to 06): after the apply, PUBLIC's entry is `=c/postgres`; `has_database_privilege` gives TEMPORARY false for `public`, `anon`, `authenticated`, `authenticator` and `service_role`, true for `postgres`; and a new session as each of the four is refused `ERROR:  permission denied to create temporary tables in database "postgres"` (`[exit 1]`), while `postgres` and the service stand-ins create one. Before the apply all of them could (`[exit 0]`). In the projects, it is shown in `devos-test` by M09-02's self-check, which fails the apply there when the look does not hold, so `devos` is not applied (3.7). In `devos` it is shown by the look of 3.2 after its apply. Run 29 repeats run 06 on the current bytes, with the same output.
- **Point 3, third bullet** ("at least one call per role class goes through the real path"): the copy `supabase/migrations/tests/w07_idc_real_path.py` (T-W07-IDC part B; R:247) runs in `devos-test` after this apply: `IDC-h-<class>` for each of the six classes, `IDC-h-missing`, and `IDC-dd-<class>`, over the Data API (3.7). Its result is the job's first run's; offline it can only give COULD NOT CHECK (run 37: no key, so no request).
- **Point 3, fourth bullet** ("one of a class other than the operation requires … refused … and recorded"): `token_role_class()` now refuses a class not on its literal, with its per-call row (run 12 (b), again run 35). The look of the literal itself is run 10, again run 33.
- **Point 4.** The claim check's parts (another work item's claim, no claim token, released, expired or revoked claims, an earlier generation, an earlier epoch, another class) exist in `check_claim` (C2 to C17). No effect uses it yet.
- **Point 7.** Missing, unreadable and partial input: each helper gives NULL or `could_not_check` for missing or partial input, never a pass, and raises for unreadable input so that the caller's read block answers `could_not_check` (C10, C12, C14 to C16, C18, R5, R6, R9 to R11, R23, R27 to R30, Y5, Y9, I3 to I5, I7). "A readiness group with an unknown member is not ready": R12, R15.
- **Point 8.** `w07_idc_identity_chain.sql` runs again with this apply, `PASS (43/43)`. W-C02-08's four copies pass again (T-W08-PRIV now `PASS (95/95)`, six rows more for the new functions), and so do W-C02-03's three.

**Not yet served by M09-02.** Every `devos_api` function that calls these helpers (M09-03 to M09-12), so no merged test runs them through the interface yet. The tests that will exercise them: T-W07-6RG (g, l, e cases), F08, N17, 5C, DM07, CONC, ROC, F04, F05 and DM34. The breaks that rewrite this text (B-CONC-1 and -2 on `check_claim` and `hard_dependency_cycle`; B-6RG-2 on `ready_works`) are W-C02-13's. The real path per class has its copy here, but its result is the migration job's first run with it (3.7). Point 2's look in `devos` after its apply (3.2). Point 2's ✘ for the other 53 functions: they follow item 12, and each later record shows its scan.

### 3.5 Open, and for whom

1. **R1-12 in `devos-test` before `devos`: closed in the text by option (i), the executor's route; shown only by the migration job's first run.** The migration checks its own effect, the program copy runs over the Data API, and the dashboard is read (3.7). What is left:
   - The first run of the job's steps `tokens`, `dbprograms` and `tokens_revoke` with a program present.
   - `devos-test`'s exposure of `devos_api` and its stored key, neither observed yet.
   - The dashboard's table editor, a residual whose first observation is Batu's next use of the dashboard.

   Each is in 3.7, for the executor.
2. **For the checker of verdict (i):** 3.3's departures, chiefly 2, 5, 6, 11 and 14 to 16; 3.2's decision; 3.7's self-check and the copy's hash against its staged file.
3. **For the author of the migration that adds a role class (C04, `devos_ingest`):** widen `rejected_attempt.role_class`'s and `event.role_class`'s checks (3.3 item 10), and put the class on the literal of each function that admits it.
4. **For the producers of M09-05 to M09-08, M09-06 and M09-11:** call `check_claim` then `ready_value(work, assignment_id)` at an effect; call `hard_dependency_cycle` before locking the work item's row; map a helper's NULL to `could_not_check` with the caller's `v_check`.
5. **Residuals of Route A** (3.2), for the executor: roles created later, a platform reset of the ACL, the platform's guard on its reserved roles.
6. **Not caught** (as section 1.1 cited it): PL/pgSQL's `others` does not match a query cancellation or an assertion failure, so such a call rolls back whole and leaves no RejectedAttempt row.

### 3.6 The offline run, with its raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.** Started 2026-10-18T20:38:28Z, ended 20:38:32Z, one cluster (`…/scratchpad/m0902_run/rerun.sh`). An earlier run of the same sequence (20:36:55Z) was discarded and the whole sequence run again on a new cluster. That run found a fault in the check script itself: its cases J2 and J3 read a RejectedAttempt row in the same statement that wrote it, which that statement's snapshot cannot see (J2 `BAD`, J3 a false pass). The write was moved into the case's plant, a separate statement. M09-02 did not change between the two runs.

- **01, 02:** `[initdb exit 0]`; `[setup exit 0]`; `postgres|f`.
- **03, the thirteen migrations before M09-02:** each `[exit 0]` with its history row; `[drive apply exit 0]`.
- **04, TEMPORARY before:** the ACL as on `devos` (envelope); `public`, `anon`, `authenticated`, `authenticator`, `service_role`, `postgres` all `temporary t`; `postgres_own_temporary_entry t`; a temporary table created as `postgres` and as each of the four and the service stand-ins (`[… exit 0]`).
- **05, the apply:** `CREATE FUNCTION` ×7, `COMMENT`, `REVOKE` ×7, `DO`, `DO`, `[exit 0]`; history row `[exit 0]`.
- **06, TEMPORARY after:** `{=c/postgres,postgres=CTc/postgres,supabase_etl_admin=CT/postgres,supabase_storage_admin=CT/postgres,dashboard_user=CTc/postgres,supabase_auth_admin=T/postgres,supabase_read_only_user=T/postgres}`; `public f`, `anon f`, `authenticated f`, `authenticator f`, `service_role f`, `postgres t`; CONNECT `t` for all; `postgres_own_temporary_entry t`. As each of the four: `ERROR:  permission denied to create temporary tables in database "postgres"`, `[anon exit 1]`, `[authenticated exit 1]`, `[authenticator exit 1]`, `[service_role exit 1]`; as `postgres` and each service stand-in: `temporary table created`, `[… exit 0]`.
- **07 and 13, `deployment_drift` as the migration login:** `{"commit": "db6d6bea49c3990e2a197ec853af7d8471f483cb", "status": "no_difference", "compared": {"functions_expected": 0, "functions_recorded": 0, "migrations_applied": 14, "migrations_expected": 14}, "complete": true, "differences": []}`.
- **08, every file under `supabase/migrations/tests/`, as the job's test step runs them:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 fields as the fixture file; positive control 2/2; breaks 2/2)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`. T-W08-PRIV's rows for the new functions, for example `PRIV-facl:check_claim(text,uuid,role_class,boolean) | ok | owner postgres; ACL {postgres=X/postgres}; grantees other than the owner: none`, and `PRIV-fexec:anon | ok | … asked on all 13 function(s) of devos_private; true on: none` (the same for `authenticated`, `authenticator`, `public`, `service_role`). No case `bad`.
- **09, the merged staged files whose function they call now exists, run in place (not copies; a self-check, never a result):** `W07_6TK_TOKEN_REASONS COULD NOT CHECK (7 of 32 could not be checked)` (25 `ok`; the seven: "no devos_api function that refuses devos_calisma exists yet"); `W07_DM19B_BURST_COUNT COULD NOT CHECK (6 of 12 could not be checked)` (6 `ok`; the six: "interface: devos_api.accept: 0 definitions"); `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (21 of 27 could not be checked)` (the six `5B-R01-token_role_class-<class>` cells `ok`, the other rows' functions not built). No case `bad`. Their copies are a later pull request's (R:247).
- **10, the catalogue:** 3.1's listing.
- **11, the producer's self-check of the helpers** (`helpers_check.sql`; synthetic owner-level fixtures labelled SYNTHETIC W-C02-09 M09-02, one transaction rolled back; each plant undone with its case): `M0902_HELPERS PASS (81/81)`, then `rejected_rows_after_rollback 0`, `events_after_rollback 0`. Its cases: S1 to S5 (`scope_within`), J1 to J4 (`reject`; J4 `error 23502` for a NULL class), C1 to C19 (`check_claim`, each code and each missing input; C16 `error 42P01` for the epoch table renamed), R1 to R31 (`ready_value`; R9 `NULL` for 6RG-g1's input, R10 for -g2's, R5 for -l5's, R29 `error 42P01` for -g3's), Y1 to Y9 and Y8b (`hard_dependency_cycle`; Y8 and Y8b: the advisory lock `(9001, 1)` held after the call, also when taken inside an inner block that ended normally), I1 to I7 (`is_installation_mission`; I6 `true` with `devos_private.mission` unreadable to the owner, so it is not read). Part B, the inner-block pattern written as a later `devos_api` function would write it: `B1 ok | events +1 | rejected +0`; `B2 refused | claim_unknown | … | events +0 | rejected +1` (the decided code kept across the read block's rollback); `B3 refused | could_not_check | readiness: its input could not be read (SQLSTATE 22012)`; `B4 refused | write_failed | the write failed (SQLSTATE 23502) | events +0 | rejected +1` (the block's event undone); `B5 refused | could_not_check | sample: its input could not be read | events +0 | rejected +1` (`P0D02`).
- **12, `token_role_class()`'s literal** (`tokencheck.sql`; tokens issued at run time as owner, held in transaction-local settings, never printed; calls as `anon` with the header set in SQL): part 1, each of the six `{"status": "ok", "role_class": "<class>"}`, `rejected_rows_after_part1 0`. Part 2, with a seventh synthetic value `devos_w09_synthetic` added to `devos_private.role_class` in this cluster only: (a) `the call raised SQLSTATE 23514 and gave no answer`; (b) with `rejected_attempt`'s check widened in the transaction, `{"reason": "token_role_class admits only the six role classes of Appendix B section 2", "status": "refused", "reason_code": "role_class_not_permitted"}` and one row `token_role_class | devos_w09_synthetic | role_class_not_permitted | … | per_call t`; (c) the break, the literal widened in the function's own text as B-5B-1 to -3 widen a role list: `{"status": "ok", "role_class": "devos_w09_synthetic"}, rejected rows added 0`. So the check turns red without the literal. After the rollback, 0 rows in `rejected_attempt` and `env_tokens`. The derivation itself returns the seventh class (`derivation_gives devos_w09_synthetic`); only the literal refuses it.
- **14, the server log:** `54 lines; token-format strings: 0`.
- **15:** `[pg_ctl stop exit 0]`; `[cluster directory deleted: yes]`.
- **16, IDC-file1** (the staged `w07_idc_real_path.py` on a scratch copy of the fourteen migrations, null input, no request): `IDC-file1	ok	14 migration files; statements that call issue_env_token or revoke_env_token: none`; `W07_IDC_REAL_PATH COULD NOT CHECK (1 of 2 could not be checked)` (`apikey is null`); `[exit 3]`.
- **17:** the hashes in the envelope; `git status --porcelain`: `?? supabase/migrations/20261018203001_w09_private_helpers.sql` (the run's moment, before this record and the raw files were written); `git diff --stat HEAD -- tests/ supabase/migrations/tests/`: empty.

### 3.7 R1-12: what `devos-test` shows before `devos`, and how

**The gate it rests on (Doc, `migrate.yml` at `db6d6be`).** In the `devos-test` job, the order is:
1. the apply (step `apply`, :500-519);
2. the comparison (:520);
3. the SQL tests (`dbtests`, :698-752);
4. the synthetic tokens (`tokens`, :753-827);
5. the programs (`dbprograms`, :828-890);
6. their revocation (`tokens_revoke`, :891-943).

`go` is `yes` only when the apply, a `no_difference` comparison, the tests, the programs and the revocation all succeeded (:958-959). The `devos` job applies only on that `go` (section 2). So anything that fails one of these steps in `devos-test` keeps M09-02 out of `devos`.

| R1-12 | What shows it in `devos-test` before `devos` | Offline (3.8) |
|---|---|---|
| (a) `postgres` keeps TEMPORARY through ownership or its own grant, not through PUBLIC | The self-check: `has_database_privilege('postgres', <db>, 'TEMPORARY')` is true after the revokes. PUBLIC has none (the next row), so `postgres`'s TEMPORARY is its own or inherited from a role that holds its own grant; either passes (a) *[Correction, 2026-10-18, L-358; CHK-C02-084 C2]* | run 28 passes; B5 (`postgres` revoked too) raises `(a) postgres has no TEMPORARY on the database` |
| (b) the catalogue look: PUBLIC's effect, and each of `anon`, `authenticated`, `authenticator`, `service_role` without TEMPORARY | The self-check. For PUBLIC: no TEMPORARY entry in the database's ACL (its default ACL when it has none), and `has_database_privilege('public', …)` false. For each of the four that exists: `has_database_privilege` false, counting inheritance and superuser status. It does not count a `set role` route through a membership without inheritance (`authenticator` has `rolinherit` false; CHK-C02-084 case X2): on `devos` no such route to a role holding TEMPORARY exists, by the executor's reading of the four roles' memberships; `devos-test`'s were not read, so this stays a residual *[Correction, 2026-10-18, L-358; CHK-C02-084 C2]* | run 28 passes and run 29 shows the look; B1 (a grant by another grantor, which `postgres`'s revoke does not remove) raises naming `anon`; B2 (inherited from a role with its own grant) raises naming `authenticated`; B4 (PUBLIC's revoke removed) raises `(b) PUBLIC still has TEMPORARY` |
| (c) Supabase's other services | The self-check. Every role that had TEMPORARY when the block began (read in the same block, before the first grant), other than the four and the `pg_` roles, still has it. Route A changes no other privilege, so no service loses anything **[Inf: a service that worked before is unaffected by a privilege it keeps; the self-check does not run a service]** | B3 (the grant-back removed) raises `(c) … lost it: supabase_auth_admin, supabase_etl_admin, supabase_read_only_user, supabase_storage_admin` |
| (c) the Data API | The program copy's run in step `dbprograms`, after M09-02 is applied there. It makes these `POST /rest/v1/rpc/…` calls, which run as `anon`, the role a publishable-key request reaches, through `authenticator`'s login, now that neither has TEMPORARY: `IDC-h-<class>` (`token_role_class`) for the six classes; `IDC-h-missing`; `IDC-dd-<class>` (`deployment_drift`). It also shows sitting A's `devos-test` settings: `devos_api` exposed, and `DEVOS_TEST_PUBLISHABLE_KEY` stored | run 37: the job's own step code over the copy, with no key: `COULD NOT CHECK`, exit 3, step exit 1, no request made |
| (c) the dashboard | A reading, below; the rest is a residual | — |

**The self-check** (M09-02:507-577, the end of Route A's one `do` block).
- **Where it sits.** At the start of the block, before the first grant, it reads into `v_before` every role that has TEMPORARY, other than the four and the `pg_` roles. The grant-back and the revokes follow unchanged. Then it checks (a), (b) and (c) in that order.
- **What it raises.** It raises P0001 (PL/pgSQL's default code for `raise exception`) with a message that names the failed condition and, for (b) and (c), the roles: `route A self-check failed: (a) postgres has no TEMPORARY on the database`, `… (b) PUBLIC still has TEMPORARY on the database`, `… (b) API roles that still have TEMPORARY on the database: <roles>`, `… (c) roles that had TEMPORARY on the database before route A and lost it: <roles>`.
- **The form.** Plain SQL, no backslash (O, `40_git_hashes.txt`: `backslashes in M09-02: 0`), in the `do` form that M09-01 and the earlier migrations already apply through `db push` (section 2).
- **Why the "before" set is read in the same block.** A set read in a statement before the block would be read in the same migration, but outside the block whose effect it judges. A set read inside the block cannot be changed between its reading and the change.
- **How a raise keeps `devos` from being applied.** The command-line tool runs each migration file in its own batch **[src: EV-C02-007 P13, :97]**. The raise makes `db push` fail, so step `apply` fails and `go` is `no`, whatever the comparison says. Whether the batch is one transaction was not read here **[Inf: general knowledge of the tool, that a migration file runs in a transaction; offline, `psql --single-transaction` stands in for it]**. Offline, after each of B1 to B5 the database's ACL is as before, M09-02's six private functions are absent and it has no history row (runs 22 to 26), and run 27's look equals run 20's. If the batch is not one transaction, the `do` block is still one statement, so its grants and revokes roll back with its error. The functions created before it would then stay, with no history row. The comparison would list M09-02 "on `main`, not applied", `go` would stay `no`, and the next run would fail at the first `create function`: a repair for the executor (EV-C02-001 section 4, "Repair paths").
- **Cases it catches that the earlier text did not.** PostgreSQL only warns when a `revoke` revokes nothing (B1's form). The grant-back could leave out a role that matters (departure 15). In a project where `postgres` is the owner but holds no entry of its own in a non-default ACL, the grant-back leaves out the owner, so `postgres` would lose TEMPORARY with PUBLIC. That is (a), shown only by `devos-test`'s apply, since `devos-test`'s ACL was never read.

**The copy.** `supabase/migrations/tests/w07_idc_real_path.py`, copied byte for byte from `tests/C02/W-C02-07/job/w07_idc_real_path.py` (R:197, R:222, R:247). O (`40_git_hashes.txt`):

| File | SHA-256 |
|---|---|
| The copy | `093b7c3a1d0cda5402793885ed2e4f131dd150a1c357573232d236aaac13f66a` |
| The staged file in the working tree, and at `main` `db6d6be` | `093b7c3a1d0cda5402793885ed2e4f131dd150a1c357573232d236aaac13f66a` |
| The staged file at its last change, `3e81482` | `093b7c3a1d0cda5402793885ed2e4f131dd150a1c357573232d236aaac13f66a` |
| The staged file at W-C02-07's merge, `68070993cebf76a2433256b6180c7dfc80889501` | `093b7c3a1d0cda5402793885ed2e4f131dd150a1c357573232d236aaac13f66a` |

`cmp`: identical. `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

- **Preconditions, checked before copying.**
  - *The sources' condition, "after sitting A, once the publishable key is stored"* (R:231, R:245, R:247; EV13 section 11 row "T-W07-IDC part B" and section 9 (iii); section 1.4 above). Sitting A is done: Batu's "A Tamam" on #6, comment `6254334810`, 2026-10-18T19:45:57Z (`plan/ledger/C02-log.md` L-355). The key was reported stored by Batu on 2026-10-17 ("yaptım.", L-340). That is his report, not observed. L-355 also lists `devos-test`'s exposure of `devos_api` as not yet observed, to be shown by "the migration job's next `devos-test` run with a `.py` program": this copy's run.
  - *N-280's fix.* It is merged at `6544c55`, an ancestor of `db6d6be` (`git merge-base --is-ancestor`: yes). Steps `tokens` and `tokens_revoke` now revoke by the `env_tokens` row whose `token_hash` is the token's hash. The hash reaches psql only through its environment (`\getenv`), never the token (:772-803, :909-933). Section 1.8's second open item is therefore met.
  - *The build serves it.* M09-02's literal admits all six classes (run 35, part 1: six `ok`), and `deployment_drift` is M09-01's (section 1.1). IDC-file1 is `ok` on the fourteen migrations (run 37).
- **How step `dbprograms` runs it.**
  - *Step `tokens` first* (only after `dbtests` succeeded). As owner, it issues one synthetic token per class of `W03_TOKEN_CLASSES` (the six) and one more `devos_kurulum` token, revoked before the programs run. Each value is masked in the log and kept in a 0600 file under the runner's temporary directory.
  - *Step `dbprograms`* (only after `dbtests` and `tokens` succeeded) gives the program one JSON object on standard input: `endpoint`, `apikey`, `tokens`, `revoked_token`.
    - `endpoint` is derived from `PGUSER` `postgres.cqbzxexxwrrbrlszoseg`, so `https://cqbzxexxwrrbrlszoseg.supabase.co`; run 37 shows the derivation.
    - `apikey` is the environment secret `DEVOS_TEST_PUBLISHABLE_KEY` of `migrate-devos-test`, or null when it is not set.
    - The program runs as `timeout 600 python3 -I <copy>`, with an environment holding only `PATH`, `HOME` and `LANG`, because the program declares no database.
    - Exit 0 is pass, 3 is could not check, anything else is fail; any exit but 0 fails the step, and `go` is then `no`.
  - *Step `tokens_revoke`* then runs in every case once `tokens` ran.
- **What it prints, read line by line.** It prints no token, hash or key.
  - *Its output.* Its first line is fixed. Each case line holds the case's id, its outcome and a detail made only of an HTTP status, a role class name, a reason code, a PostgREST error code, or the name of a missing input (`case`, :57-59; `http_cases`, :166-205; `api_lacks`, :259-270).
  - *The tokens and the key.* The tokens are held in memory. Each is sent only as the `x-devos-env-token` header, and the key only as `apikey` (:124, :128-129). No header is printed.
  - *Errors.* An exception's text is replaced by its type name, after `scrub` removes any token (:145-149, :285).
  - *Hashes.* It computes none.
  - *The step's own line* gives the program count, the endpoint (a public name, EV-C02-003 "Names this design fixes"), "set" or "not set" for the key, and the class names (:868-869).
  - *Offline.* Run 37's output holds 0 token-format strings.
- **What could make its first run fail for a reason other than the build.** Each of these holds `go` at `no`, so `devos` is not applied, and the job's log names the cause:
  1. `devos_api` is not exposed in `devos-test`. PostgREST then answers with a `PGRST` code, the cases are COULD NOT CHECK, and the program exits 3.
  2. The key is not stored: `apikey` is null and the program exits 3. If a wrong key is stored, the gateway's refusal is a non-200 answer without a `PGRST` code **[Inf: its answer form, not read]**, so the cases are `bad` and the program exits 1.
  3. Steps `tokens`, `dbprograms` and `tokens_revoke` have never run on GitHub with a program present. N-280's fix was shown offline only (EV-C02-016). `\getenv` needs psql 15 or later; an earlier job of this repository on GitHub's runner used psql 16.15 (EV-C02-007:1168).
  4. A transport failure or a 30-second timeout from the runner to the Data API: COULD NOT CHECK.
  5. The self-check itself raises in `devos-test`. That is the build's check doing its work, but it stops `devos` until the executor decides (departure 15; the cases above).
- **What the copy does not show.** It makes function calls only, the only kind the Data API makes for DevOS. Table reads, GraphQL, Auth, Storage and Realtime run as their own service roles, and only (c)'s privilege check covers them.

**The dashboard, read from the repository.**
- **Its SQL editor.** In sitting A, Batu ran `select devos_private.issue_env_token('devos_kurulum');` in `devos`'s SQL Editor (EV-C02-003, steps 13 and 14, :919-920). The token it gave works (N-221 step 5, L-355). On `devos`, that function's EXECUTE is held by `postgres` alone (`{postgres=X/postgres}`, section 2's catalogue reading), and `postgres` is not a superuser (`evidence/C02/raw/W-C02-03_devos_observation_20261012T1518Z.md`: `"role":"postgres","super":false`). **[Inf, from these observations:]** the SQL editor ran that statement as `postgres`, as a role holding `postgres`'s privileges, or as a superuser. In each case it keeps TEMPORARY after Route A:
  - `postgres` by its own entry, which is condition (a);
  - a role holding `postgres`'s privileges by inheriting them, and in any case by condition (c);
  - a superuser always.

  This was observed on `devos`, not `devos-test`. That the two projects run the same dashboard is **[Inf]**.
- **The table editor and the rest of the dashboard.** No source in the repository says which role they use. No copy of the research library was readable here without the network. **[Inf: general knowledge, not read:]** the table editor goes through the same query path as the SQL editor. Whatever role it uses, condition (c) shows that it keeps TEMPORARY unless it is one of the four API roles or a `pg_` role. A query the SQL editor runs as `anon` or `authenticated` (**[Inf: general knowledge, not read]**: it offers such a choice) can no longer create a temporary table, which is Route A's intent.
- **So the dashboard is a residual.** The first observation that it still works after M09-02 is Batu's next use of it. `devos-test`'s dashboard is used by no one, and `devos`'s is used after `devos`'s apply. Nothing here asks him to look.

### 3.8 The second offline run, with its raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **The run.** Started 2026-10-18T20:53:30Z and ended 20:53:34Z, on one throwaway PostgreSQL 16.15 cluster, in a user namespace (`…/scratchpad/m0902b_run/rerun.sh`).
- **What it reused, unchanged.** The first producer's `run.sh`, `drive.py`, `setup.sql`, `temp_look.sql`, `catalog.sql`, `helpers_check.sql`, `tokencheck.sql`, `scrub.py` and `logscan.py` (`…/scratchpad/m0902_run/`). The stand-ins are 3.6's, with the ACL read on `devos`.
- **The breaks.** The synthetic stand-ins of B1 and B2 (`w09_brk_grantor`, `w09_brk_holder`) were made by the bootstrap superuser before the apply and removed after it. The break copies of B3 to B5 were each made by one exact replacement that must match once (`…/scratchpad/m0902b_run/brk.py`). They are kept in `…/scratchpad/m0902b_brk/`, outside the repository.
- **An earlier run.** A first run of the same sequence, without runs 32 to 36, ended 20:52:07Z with the same outcomes. It was replaced by this one, so that every step of 01 to 17 that touches M09-02 is on the current bytes; its raw files were deleted.

- **18, 19:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`; the thirteen earlier migrations, `[drive apply exit 0]`.
- **20, TEMPORARY before:** as run 04.
- **21:** `b3_grant_back_removed.sql: made (one replacement)`, and the same for `b4_public_revoke_removed.sql` and `b5_postgres_revoked.sql`.
- **22, B1** (M09-02 unchanged):
  - *The stand-in.* `anon` holds `anon=T/w09_brk_grantor`.
  - *The apply.* `ERROR:  route A self-check failed: (b) API roles that still have TEMPORARY on the database: anon`, `[apply exit 3]`.
  - *After it.* The ACL is unchanged; `public`, `anon`, `authenticated`, `authenticator`, `service_role` and `postgres` all have TEMPORARY `t`; `m0902_private_functions_present 0`; `m0902_history_rows 0`.
- **23, B2** (M09-02 unchanged; `authenticated` granted a role holding `w09_brk_holder=T/postgres`, with inherit):
  - *The apply.* `… (b) API roles that still have TEMPORARY on the database: authenticated`, `[apply exit 3]`.
  - *After it.* Functions 0, history rows 0.
- **24, B3:** `… (c) roles that had TEMPORARY on the database before route A and lost it: supabase_auth_admin, supabase_etl_admin, supabase_read_only_user, supabase_storage_admin`, `[apply exit 3]`; after it, the ACL is as before, functions 0, history rows 0.
- **25, B4:** `… (b) PUBLIC still has TEMPORARY on the database`, `[apply exit 3]`; after it, the same.
- **26, B5:** `… (a) postgres has no TEMPORARY on the database`, `[apply exit 3]`; after it, the same.
- **27:** the catalogue look before M09-02 again, identical to run 20's (compared with `diff`).
- **28, M09-02 as written:** `CREATE FUNCTION` ×7, `COMMENT`, `REVOKE` ×7, `DO`, `DO`, `[exit 0]`; history row `[exit 0]`.
- **29, TEMPORARY after:** identical to run 06 but for its label line (compared with `diff`):
  - the ACL is `{=c/postgres,postgres=CTc/postgres,supabase_etl_admin=CT/postgres,supabase_storage_admin=CT/postgres,dashboard_user=CTc/postgres,supabase_auth_admin=T/postgres,supabase_read_only_user=T/postgres}`;
  - TEMPORARY is `f` for `public` and the four, `t` for `postgres`;
  - each of the four is refused a temporary table with `permission denied to create temporary tables`, while `postgres` and the service stand-ins create one.
- **30, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`; no case `bad`. The runner skips the `.py` copy, as `dbtests` does.
- **31 and 36, the comparison:** `no_difference`, `migrations_applied` 14 of 14.
- **32, 33, 34, 35:** as runs 09, 10, 11 and 12, on the current bytes:
  - 32: `W07_6TK_TOKEN_REASONS COULD NOT CHECK (7 of 32 …)`, `W07_DM19B_BURST_COUNT COULD NOT CHECK (6 of 12 …)`, `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (21 of 27 …)`, no case `bad`;
  - 34: `M0902_HELPERS PASS (81/81)`;
  - 35: the six classes `ok`; part 2 (a) `SQLSTATE 23514`, (b) `role_class_not_permitted` with one per-call row, (c) the break answered `ok`; 0 rows after the rollback.
- **37, step `dbprograms`.** The step's Python was taken verbatim from `migrate.yml` and run over the clone (`…/scratchpad/m0902b_run/progs.py`). Its input was built as step `tokens` leaves it, with labelled synthetic placeholders that have no token format and no key set:
  - `test programs: 1; endpoint https://cqbzxexxwrrbrlszoseg.supabase.co; publishable key not set (null); tokens for [the six classes] and one revoked token`;
  - `IDC-file1	ok	14 migration files; statements that call issue_env_token or revoke_env_token: none`;
  - `IDC-http	could_not_check	apikey is null: …`;
  - `W07_IDC_REAL_PATH COULD NOT CHECK (1 of 2 could not be checked)`;
  - `test program w07_idc_real_path.py: could not check`, `[step dbprograms exit 1]`.

  So with no key, `go` would be `no`. No request was made.
- **38:** the server log, `385 lines; token-format strings: 0`.
- **39:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **40:** the hashes above; `backslashes in M09-02: 0`; `git status --porcelain` at that moment: M09-02 and the copy untracked, the record modified, raw files 01 to 17 present (18 to 40 were filed after).
- Every raw file from 18 to 39 ends `0 token-format strings removed`.

## 4. M09-03: Mission, need and decision

The producer's record of `supabase/migrations/20261018214501_w09_mission_need_decision.sql` (M09-03), written at `main` `9638f1d3d8c28aadbea4b23925325ef516ae5a3c` on branch `claude/c02-w09-m0903`. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n, B:n and FNJ:n are at that commit, with EV13's correction section 15 added by the same producer before the SQL (see below). M09-03 means the file above, and M09-03:n a line of it. FNJ is `tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql`; `job/` is `tests/C02/W-C02-07/job/`.
- **N-279 (20) first.** Before any SQL, EV13 gained "15. Correction, 2026-10-18 (N-279 (20))", with marks *[C-20]* in section 1 item 14 (twice) and in 2.2's `open_mission` row (CHK-C02-081 C1). It makes two statements:
  - (a) An `owner_authority_revision` naming a revision the Decision does not have is `mission_authority`, as FN-MA-revision expects. FN-MA-revision stands.
  - (b) Item 14's statement of which codes the merged tests compare is updated: T-W14-FN compares `conflict`, `run_not_open`, `mission_authority`, `cycle` and `handed_over`, and break B-FN-5 reads `write_failed`.
- **The checker.** M09-03's checker judges that correction.
- **Revised for CHK-C02-086 (2026-10-18).** CHK-C02-086 judged the branch at `c3cd1ed`: PASS-WITH-CONDITIONS. A further producer, a fresh-context subagent of the same session (the executor names the agent at filing), met these conditions on the branch:
  - C1 (a): `revise_mission` now refuses `missing_field` for a call that writes a new revision without a `reason` (4.1, 4.2 item 1).
  - C1 (c): the offline run was repeated on the new bytes, runs 22 to 38 (4.5).
  - C2: EV13 gained "16. Correction, 2026-10-18 (CHK-C02-086 C2)", with marks *[C-086]* in 2.2.
  - C3: the restatement of 4.2 item 3.
  - Left to the executor: C1 (b) and C4, and C3's note. Lines M09-03:n below are at the new bytes.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | `main` `9638f1d`, clean before this work; the runs were made with M09-03 untracked and EV13 modified (O, `21_git_hashes.txt`). Bytes run: M09-03 `b0b476b8969a55ae7627675c678af957db0007021fda71855fdd8c7c89b187e3`; EV13 with its section 15 `0e1081e73feb970e86c983200e43d887d8cffac1249ada427a584c0eecf470f8`. **Superseded for M09-03 by the rerun:** branch `claude/c02-w09-m0903` at `c3cd1ed`, with M09-03 and EV13 modified (O, `38_git_hashes.txt`). Bytes run in runs 22 to 37: M09-03 `264895106ebc5fd29dfd7ea9456cd2a83c9c951928a8def8350924d8f38e9556`. EV13 with its section 16: `047984de52e66a79317fcdbd6676c1f93a90fba0c7ed904b855f430320fa0972`. Runs 01 to 21 observed the first bytes, and they hold for those bytes only. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3: one throwaway PostgreSQL 16.15 cluster per run, unix socket only, in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, `12_stop.txt` and `20_breaks_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: M09-02's `setup.sql` unchanged (`…/scratchpad/m0903_run/setup.sql`, a copy of `…/scratchpad/m0902_run/setup.sql`), with the ACL read on `devos`. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `9638f1d`; EV13 with Revisions 1 and 2 (judged by CHK-C02-076, -077 and -081) and its section 15 (for M09-03's checker); N-279 (20) |
| Input | The fifteen migrations (`main`'s fourteen and M09-03); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `tests/C02/W-C02-07/job/` and T-W14-FN's, run in place; the producer's self-check `…/scratchpad/m0903_run/fn_check.sql`; six break copies of M09-03 made outside the repository (`…/scratchpad/m0903_brk/`, by `…/scratchpad/m0903_run/brk.py`). In the rerun, the same inputs, with the self-check updated for C1 (a) (`…/scratchpad/m0903b_run/fn_check.sql`) and two break copies of the new bytes (`…/scratchpad/m0903b_brk/`, by `…/scratchpad/m0903b_run/brk.py`) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m03_offline_01_init_setup.txt` to `…_21_git_hashes.txt` (the first bytes), and `…_22_init_setup.txt` to `…_38_git_hashes.txt` (the rerun, made by `…/scratchpad/m0903b_run/rerun.sh` and `brk.sh`, which write the files directly). Every file but `21` and `38` passed through section 1's filter, and each ends `0 token-format strings removed`. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-checks (runs 09 and 30) and the break runs (14 to 19, 35 and 36) are the producers' own |

### 4.1 What was built, object by object

All in M09-03, in this order: the seven functions of EV13 2.2, and their grants. No table, type or `devos_private` function is added. M09-01 and M09-02 are not changed; their helpers are called: `caller_role_class`, `write_event`, `reject`, `scope_within` and `is_installation_mission`.

**The form every function has** (EV13 1 items 6, 7, 9, 10 with R1-1):
- **Path and privileges.** `security definer`, owner `postgres`, `set search_path = pg_catalog, pg_temp`, and every DevOS relation, type and function schema-qualified (EV13 1 item 12). O (`08_catalog.txt`): each of the seven has `definer t`, the fixed path and VOLATILE.
- **(a) The derivation first.** A token that is not verified is answered with its token code, counted by the derivation.
- **The read block**, steps (b) to (f):
  - (b) the role list, a quoted literal of the function's own text (B:48; O, part 3 of `08_catalog.txt`);
  - (c) the input's form;
  - (d) ownership, `open_decision` only;
  - (f) the family's rules.
  - A refusal a check decides sets `v_code`, `v_reason` and raises `P0D01`. Any other error is `could_not_check`, "`<v_check>`: its input could not be read (SQLSTATE `<code>`)".
- **The write block**, step (g): the writes and their events through `devos_private.write_event`, with the token's class and origin `call`. An error there is `write_failed`, but `P0D02`, which is `could_not_check` with its fixed message.
- **After a refusal**, outside both blocks: one per-call row by `devos_private.reject`, and the answer `{"status", "reason_code", "reason"}`.
- **Reasons** are fixed text and an SQLSTATE only.
- **Keys and declared fields.** Keys a function does not read are ignored (item 4). `declared_session_id` goes to the events and the refusal rows only (item 5).
- **The exact repeat** answers `ok` with the existing id and `"repeat": true`, and writes nothing.

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.open_mission(p jsonb)` (M09-03:38) | `devos_kurulum` only. Required: `purpose`, `scope` (a dotted path of lower-case labels, else `invalid_field`), `acceptance`, `owner_authority`. `owner_authority_revision`: absent or JSON null `could_not_check`; not a JSON integer of at least 1 `invalid_field`. `constraints` an array, default `[]`. The owner authority, read `for share`, in R2-7's order: no such Decision `could_not_check`; class not `batu`, or status neither `answered` nor `accepted`, `mission_authority`; `answered_revision` NULL `could_not_check`; `answered_revision` other than `owner_authority_revision`, a revision the Decision does not have included, `mission_authority`. Writes the Mission (`active`), its revision 1, and `mission_opened` (revision 1). The revision named is kept in that event's payload, since no column holds it. No exact repeat. Answer `id`, `revision` 1 | 2.2's row with R2-7 and C-20 (section 15 (a)); B 3.1 (B:106); DM-23 (a), DM-11 (a); 1 items 3, 4, 7 (ii), 14 |
| `devos_api.revise_mission(p jsonb)` (M09-03:196) | `devos_kurulum` only. Required `id`, `base_revision`. Optional `purpose`, `scope`, `acceptance`, `constraints`, `owner_authority` with `owner_authority_revision`, `status` (`active`, `paused`, `closed`). `reason` is required on a call that writes a new revision (departure 1, C-086). The checks, in order: (1) the Mission, `for update` (`not_found` when absent), and its current revision (`could_not_check` when missing). (2) A closed Mission is terminal: any change is `mission_closed`, and a call that changes nothing is the exact repeat. (2a) A call whose content differs from the current revision's, so that it would write a new revision, without a string `reason`: `missing_field` (M09-03:373-381). A status-only call needs none. (3) `owner_authority`, when sent, is checked as in `open_mission`, on every such call. (4) The exact repeat, before `stale_revision`. (5) `stale_revision`. (6) A scope that does not lie within the current one (`scope_within`), or a changed purpose, needs a Decision named in the call, else `mission_authority` (departure 3). Content gives a new revision and `mission_revised`; status gives `mission_status_set`; both may come in one call. Answer `id`, `revision` | 2.2's row with R1-4, R2-7, R2-9, C-20 and C-086; 1 items 6 and 10; DM-02; B principle 3 (B:17); B 3.1 |
| `devos_api.record_need(p jsonb)` (M09-03:493) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. Required `mission_ref` (a uuid), `condition`, `why_needed`. Optional: `origin` (`goal`, `method`, `useful`); `status` (`open`, the default, or `investigating`); B 3.2's other fields, stored as sent. The Mission, `for share`: absent or unreadable `could_not_check` (departure 2); status NULL `could_not_check`; not `active` `mission_not_active`. An empty `why_needed` is accepted: N01's gate is W-C02-10's. Writes the Need and `need_recorded`. Answer `id` | 2.2's row; B 3.2; W9 point 7; 1 item 14 with R1-2 |
| `devos_api.resolve_need(need_id uuid, reason text)` (M09-03:639) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. `need_id` NULL `missing_field`. The Need, `for update`: absent `not_found`; `resolved` the exact repeat; `dropped` or `superseded` `invalid_field`. Writes `status` `resolved` and `need_resolved` (payload `reason`, `previous_status`). Refusal rows carry `target_ref` = `need_id`. Answer `id` | 2.2's row; README 8.1's form (R:407) |
| `devos_api.open_decision(p jsonb)` (M09-03:737) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. Required `class` (`routine`, `high_impact`, `batu`) and `question`. `status` `draft` (the default) or `open`, else `invalid_field`. `alternatives_state` must be one of its three values. B 3.17's other fields are stored as sent in revision 1. With `work_ref` (R1-6), Rule O is checked first. It reads only `work`, `work_revision` (the current revision), `mission_revision` and, through `is_installation_mission`, the Mission's events, or `eval_run` for `devos_sinav`; never `devos_private.mission` (2.3 with R2-6). Its answers: `devos_kurulum` only under the installation's Mission; `devos_calisma` only outside it; `devos_sinav` only on a work item its exam link names; otherwise `not_owner`, the reason naming the rule. A Work, revision or Mission that cannot be read is `could_not_check`. Then in one transaction: the Decision, its revision 1, `decision_opened` (payload holds `work_ref`), and one Relation `about` from the work item (its current revision) to the Decision (revision 1), soft, `recorded`, `observation`, the work item's scope, with `relation_created`. Rule C is not checked: the relation is not hard (EV-C02-008 1.7.1). Answer `id`, `revision` 1, and `relation_id` when tied | 2.2's row with R1-6; B 3.17; EV-C02-008 1.7.1; 2.3 "What Rule O reads" |
| `devos_api.link_prior_decisions(p jsonb)` (M09-03:948) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. Required `decision_id`, `prior_ids` (an array of at least one uuid), `scope`. The decision is read `for update`, so that two calls serialize; absent `not_found`; without a revision `could_not_check`. Each prior: absent `could_not_check` (departure 4); without a revision `could_not_check`; the decision itself `invalid_field`. For each prior not already linked by a current `about` from this decision: one Relation (`about`, decision to prior at their current revisions, soft, `recorded`, `inference`, the scope sent) and `relation_created`. A prior named twice counts once. Answer `ids` (one per prior, existing or new), and `"repeat": true` when none is new | 2.2's row; B 3.4 (B:148), 3.17; DM-33, DM-34 |
| `devos_api.read_decision(decision_id uuid)` (M09-03:1125) | All six classes, as a literal. Reads `devos_private.decision_current`: absent `not_found`; a Decision without a revision `could_not_check`. Answer `decision`, the current revision and state. VOLATILE, comment `devos:read …`, no write block | 2.2's row; section 4's R12 row; 1 item 11; DM-36 |
| Grants (M09-03:1191-1221) | `revoke all … from public` and from the four API roles where they exist, on all seven; `grant execute … to anon` on all seven; no type, no private function | 1 item 13; T-W08-PRIV's constraint |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the nine `devos_api` functions.
- **Types.** No `devos_private` type has PUBLIC USAGE.
- **The literals**, as the break patches read them (B-5B-*, B-N04-*, B-N08-*):
  - `open_mission` and `revise_mission`: `array['devos_kurulum']`;
  - `record_need`, `resolve_need`, `open_decision` and `link_prior_decisions`: `array['devos_calisma', 'devos_sinav', 'devos_kurulum']`;
  - `read_decision`: all six.
- **The unqualified-name scan.** It finds no hit in M09-03's seven functions; its four hits are section 3.1's (M09-02's three comparisons with a parameter, and M09-01's `on conflict … do update set`).
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** `deployment_drift`, `read_decision` and `token_role_class` carry it.

### 4.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. No merged test is changed. Where the record and a merged test pull apart, the side taken is stated with the item. EV13 section 16 (C-086) now states items 1 to 4 in the record itself.
1. **`revise_mission`'s `reason` is required on a call that writes a new revision** (restated for CHK-C02-086 C1; EV13 16 (1)).
   - **The rule.** A call whose `purpose`, `scope`, `acceptance`, `constraints` or `owner_authority` differs from the current revision's would write a new revision. Without a `reason` that is a JSON string (absent or JSON null), it is refused `missing_field`, reason `reason: missing (a call that writes a new revision needs one)` (M09-03:373-381). A non-string `reason` stays `invalid_field`. A call that changes the status alone writes no revision and needs no `reason`; nor does the exact repeat. An empty string is accepted (chosen; no rule reads the text).
   - **The order.** The check runs after the closed-Mission check and before the owner-authority check, the repeat, `stale_revision` and the widening rule. It is a form check (EV13 1 item 6 (c)) that needs the current revision. So a call that is both stale, or both an unauthorised widening, and without a `reason` is `missing_field` (`RM-reason-before-stale`, `RM-reason-before-authority`).
   - **The source.** B principle 3 (B:17): an update "produces a new revision and a reason"; EV13 2.2 stars `reason`. The first bytes made it optional to fit F06's recipe. CHK-C02-086 C1 found that this settled a disagreement between a test and the source in the test's favour, which the build does not do.
   - **What follows for F06.** Its `revise_mission` recipe sends no `reason` (`job/w07_f06_state_change_event.sql:450-453`), while its `revise_work` recipe sends one (`:421`). So `F06-event:revise_mission` and `F06-repeat:revise_mission` fail on this build: F06 gives them `could_not_check` (its rule for a refused recipe, `:416`), and F06 cannot PASS. That holds until the test designer adds `reason` to that recipe (C1 (b), which the executor carries). Observed in run 27; the self-check's `RM-f06-recipe-with-reason` and `RM-f06-repeat` show that the recipe with a `reason` is accepted and repeats `ok`.
   - A `reason` sent is stored in the new revision and in the events. Nothing reads it for a rule.
2. **`record_need` answers a Mission that does not exist `could_not_check`, not 2.2's `reference_missing`.** W9 point 7 says a referenced record that is missing gives "could not check". So does EV13 item 14 with R1-2: a reference that names no record is missing input. No merged test compares either code. EV13 16 (2) states it, with a mark *[C-086]* on 2.2's row.
3. **A widening or a changed purpose in `revise_mission` needs `owner_authority` in the call** (restated for CHK-C02-086 C3; EV13 16 (3)).
   - **The rule.** 2.2 says "`mission_authority` as `open_mission`", and does not say whether the Mission's stored owner authority may serve. Chosen: no. A widening or a changed purpose is accepted only when the call names a Decision that passes `open_mission`'s check, else `mission_authority` (M09-03:427-433). Narrowing, pausing, resuming and closing need none.
   - **What it does not do.** The rule does not stop a `devos_kurulum` call from widening the Mission on the decision that opened it. A call that names the Mission's current `owner_authority` again, with its answered revision, is accepted: CHK-C02-086's case K-RM-widen-same-authority (ok, revision 3), and the self-check's `RM-widen-batu` (run 30; `RM-widen-batu-is-current-authority` confirms that the Decision named is the current one). So B 3.1's "widened only by a decision that belongs to Batu" (B:106) is met only in form. The caller must name a valid Decision of Batu's, but not one given for this widening. This is the same gap R1-4 names for reopening (EV13 2.2's `revise_mission` row: no source gives a rule that tells a decision given for the change from the one the Mission already rests on).
   - **Who decides.** Whether a widening must name a Decision other than the one the Mission rests on is carried by a note the executor writes (CHK-C02-086 C3). The build is not changed for it.
4. **`link_prior_decisions`: a prior that names no Decision is `could_not_check`; `decision_id` naming none is `not_found`.** 2.2's row says `not_found` for any id. Under R1-2, `not_found` is the id parameter the call acts on, and a reference it reads is missing input. EV13 16 (4) states it. Also chosen here:
   - the relations' revisions are the two Decisions' current ones;
   - a prior named twice counts once;
   - a prior already linked by a current `about` from this decision gets no new relation, whatever its method or revisions.
5. **A closed Mission's exact repeat.** R1-4 says "the exact repeat (`status` `closed` again: no event, `ok`)". Built: a call on a closed Mission that changes nothing is the repeat, whether it sends `status` `closed` or no status. Any change is `mission_closed`, also with a valid Decision of Batu's.
6. **`owner_authority` is checked before the repeat in `revise_mission`.** R2-9 puts the repeat check before any check "that the first call's own write would now fail". The owner-authority check is not one, so it runs first, on every call that sends `owner_authority` (R1-4, DM-23 (a)). An identical call that names a Decision no longer valid is then `mission_authority`, not a repeat.
7. **Forms the record leaves open (chosen):**
   - `p` NULL is `missing_field`; `p` not an object `invalid_field`.
   - An optional key holding JSON null counts as absent.
   - A revision must be a JSON number of at least 1.
   - A uuid must be in its canonical text form (36 characters).
   - `open_decision`'s answer adds `relation_id`; `link_prior_decisions` answers `ids`.
   - Event payloads hold the fields written (`mission_opened` and `mission_revised` add `owner_authority_revision`; `need_resolved` `reason` and `previous_status`).
   - A call that changes both content and status writes two events, `mission_revised` then `mission_status_set`, the second on the new revision.
   - `open_decision`'s relation has origin `call`, as the call asks for it (item 10 gives `rule` to a record the database makes of its own accord).
   - Rule O for `devos_sinav` reads `eval_run` by `work_ref`, whatever its `work_revision`.
   - Creating calls name no `target_ref` in their refusal rows.
   - `resolve_need`'s `reason` may be NULL.
8. **Locks (chosen, DM-01 does not name these families).**
   - The owner authority's Decision `for share`, in `open_mission` and `revise_mission`.
   - The Mission `for update` in `revise_mission`, `for share` in `record_need`.
   - The Need `for update`.
   - The work item `for share` in `open_decision`.
   - The decision `for update` and each prior `for share` in `link_prior_decisions`.
   - None of the seven takes a claim or the epoch.
9. **The role check runs inside the read block**, as item 7 places step (b). M09-02's `token_role_class()` has no block, since it has no check after (b). A role refusal is the same answer either way.

Not departures, for the checker:
- `open_mission` ignores a `status` key (Group C's `pg_temp.w07_mission` sends `"status": "active"`, `job/w07_n29_impact_class.sql:363-365`).
- `record_need` accepts an empty `why_needed`, which is W-C02-10's gate (2.2's row).
- `open_decision` accepts a `batu` Decision opened by `devos_calisma`, and `routine` on a high-impact item (B:307): the class rules are W-C02-10's.

### 4.3 How W-C02-09's points are served by M09-03

- **Point 1.** A versioned file later than `20261018203001`, plain SQL, no `psql` meta-command, no backslash (O, `21_git_hashes.txt`: `backslashes in M09-03: 0`). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject`, on every refusal, read functions included (runs 09 and 30: `"rejected": 1` deltas; `OM-reject-row`);
  - F06's list: `read_decision` carries the marker and is VOLATILE; the six others are state-changing (runs 08 and 29, part 7);
  - the events: all `origin` `call`, the token's class (`OM-pos-event`);
  - the test Mission's base: `open_mission` with `devos_kurulum` (DM-23 (b)).
  - Offline, `deployment_drift` reports `no_difference`, 15 of 15 (runs 04, 10, 25 and 31).
- **Point 2.** Nine of the 55 `devos_api` functions now exist (seven here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (4.1's scan). M09-02's TEMPORARY revoke is unchanged.
- **Point 3.**
  - Fourth bullet. Each of the seven refuses a call with no token before any other check, counted (F06-refused:<fn>, F06-read-refused:read_decision; `6TK-*-b` on `open_mission`, the function 6TK now finds). Each refuses a class not on its list, with one per-call row (5B rows R02, R03, R12: their 42 cells `ok`; `6TK-ka1`).
  - Fifth bullet. A declared session ID changes nothing: it is written and not read (`OM-pos-event`), and a declared role name is a key no function reads.
- **Point 5.**
  - Each state-changing function writes its event in the same transaction, with the token's class, never a declared one (F06-event:<fn> for the six; `OM-pos-event`: `this_tx t`).
  - An exact repeat writes no event and raises no error (F06-repeat:resolve_need, -link_prior_decisions, each `status ok`; `RM-repeat-before-stale`, `RM-closed-repeat`, `RM-f06-repeat`, `RS-repeat`, `LP-repeat`). On the new bytes, F06-repeat:revise_mission is `could_not_check` until its recipe sends `reason` (4.2 item 1).
  - A failure planted mid-transaction leaves no half state and no orphan event (`OM-write-failed` on `mission_revision`, `OM-write-event-failed` on `event`: only the refusal row is added).
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass:
  - `OM-decision-absent`, `-answered-revision-null`, `-revision-absent`, `-revision-json-null`, `-read-unreadable` (42P01), `-read-revoked` (42501), `-write-P0D02`;
  - `RM-mission-revision-unreadable`, `RM-authority-revision-absent`;
  - `RN-mission-absent`;
  - `OD-work-absent`, `-work-mission-unreadable`, `-work-events-unreadable`, `-work-mission-link-null`;
  - `LP-prior-absent`, `-prior-without-revision`;
  - `RD-no-revision`, `RD-unreadable`.
- **Point 8.**
  - W-C02-08's four copies and W-C02-03's three pass again, and so does the IDC copy (runs 05 and 26).
  - The staged files whose cases call the seven, run in place (run 27, new bytes):
    - F06: every case for the seven is `ok` but `F06-event:revise_mission` and `F06-repeat:revise_mission`, which are `could_not_check` until the recipe sends `reason` (4.2 item 1). On the first bytes (run 06), those two were `ok` too.
    - 5B: rows R02, R03 and R12 are `ok`.
    - 6TK: `PASS (32/32)`.
  - Their copies are a later pull request's (R:247; EV13 section 11).
- **DM-23 (a)'s class part** (C:146, N29's Mission case): `OM-class-high_impact`, `-class-routine` and `-status-open` are refused `mission_authority`. N29 itself cannot run yet (4.4).

### 4.4 What M09-03 does not yet serve

- **The staged files that call these functions but need a later one** (run 06's `-pre` lines):
  - Group A's nine fixture files (5C, 6RG, DM07, DM34, F01, F05, F07, F08, N17) need `admit_work`. Their fixture Mission, `pg_temp.w07_fixture_mission`, is the call `OM-pos` makes, with the same payload.
  - Group C's files (N01, N02, N03, N08, N28, N29, ROC, T31, 5D, 6ST, DM11, DM47, FGFIND) need `admit_work`, `set_effort_policy`, `open_review`, `relate`, `record_finding` or W-C02-10's tables.
  - T-W14-FN needs the transfer's functions.
  - So N29's Mission cases, N02's `open_decision` cases, N01's `record_need` cases and ROC are not run through the merged files. Each is "could not check", not counted.
- **F06's cases outside M09-03.** `F06-read-accepted:read_decision` has no recipe in the test (its own `could_not_check`). `F06-orphan-a`, `-b` and `F06-role-token` need `relate` (M09-06).
- **F06's `revise_mission` cases, until its recipe is revised** (CHK-C02-086 C1 (b)): `F06-event:revise_mission` and `F06-repeat:revise_mission` are `could_not_check` on the new bytes (4.2 item 1). Until then, no merged test shows `revise_mission`'s event or its exact repeat. The self-check alone shows them, and it alone catches break b3 (4.5, run 36).
- **The test Mission in `devos`.** DM-23 needs D-010's Decision entered by the transfer's path first (`transfer_decision`, M09-11).
- **Rule O through ROC.** Rule O in `open_decision` is shown only on the self-check's stand-ins. ROC tests the work functions and the relations (M09-04, M09-06).
- **DM-11 (a)'s two database rules** (the equality when an answer is recorded; no revision after an answer). They are not 2.2's functions: no function here answers or revises a Decision. T-W07-DM11 is W-C02-10's copy (R:248).
- **The breaks that rewrite these functions** (B-N29-4, B-N29-5, B-N01-3, B-N01-5, B-N02-1, B-N02-2, B-5D-1, B-5D-2, B-6ST-1): W-C02-13's. They wrap the functions by name and signature, which M09-03 keeps (`open_mission(jsonb)`, `revise_mission(jsonb)`, `record_need(jsonb)`, `open_decision(jsonb)`).

### 4.5 The offline runs, with their raw lines

Runs 01 to 21 observed M09-03's first bytes (`b0b476b8…`, the envelope). Runs 22 to 38, after them, observed the new bytes (CHK-C02-086 C1).

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.** The main run started 2026-10-18T21:54:03Z and ended 21:54:08Z, on one cluster (`…/scratchpad/m0903_run/rerun.sh`). The break runs started 21:55:33Z and ended 21:55:39Z, on a second cluster (`…/scratchpad/m0903_run/brk.sh`).

- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the fourteen migrations before M09-03, each `[exit 0]` with its history row; `[drive apply exit 0]`.
- **03, M09-03:** `CREATE FUNCTION` ×7, `COMMENT`, `REVOKE` ×7, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference", "compared": {"functions_expected": 0, "functions_recorded": 0, "migrations_applied": 15, "migrations_expected": 15}, "complete": true, "differences": []`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 fields as the fixture file; positive control 2/2; breaks 2/2)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result). The ones whose cases call M09-03's functions:
  - `W07_F06_STATE_CHANGE_EVENT COULD NOT CHECK (4 of 27 could not be checked)`, none `bad`. Its lines for the seven, for example `F06-event:open_mission | ok | returned {"id": …, "status": "ok", "revision": 1}; tables changed: ["mission", "mission_revision"]; new events [{"origin": "call", "this_tx": true, "role_class": "devos_kurulum"}]`, `F06-repeat:revise_mission | ok | exact repeat: returned {…, "repeat": true, "status": "ok", "revision": 2}; tables changed: []; new events 0 (wanted status ok, none, 0)`. The four: `F06-orphan-a`, `-b`, `F06-role-token` (`devos_api.relate: 0 definitions`) and `F06-read-accepted:read_decision` (`no recipe for a call with its required arguments`).
  - `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (18 of 66 could not be checked)`, none `bad`. The 48 cells of R01, R02, R03 and R12's `read_decision` are `ok`, for example `5B-R03-open_mission-cal | ok | x cell: … code role_class_not_permitted; err - ; ra {"open_mission|role_class_not_permitted|devos_calisma": 1}; events []; changed []` and `5B-R12-read_decision-bak | ok | v cell: … code not_found`. The 18 are rows whose functions are not built.
  - `W07_6TK_TOKEN_REASONS PASS (32/32)`. M09-02's run had 7 of 32 "could not check"; with `open_mission` present, `6TK-*-b` and `6TK-ka1` run: `6TK-ka1 | ok | a verified working token on open_mission: a role refusal under devos_calisma, not a token code; code role_class_not_permitted`.
- **06 and 07, the other staged files:**
  - `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`.
  - `W07_DM19B_BURST_COUNT COULD NOT CHECK (6 of 12 …)`, needing `accept`.
  - `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, 0 could not check, of 3)`: `N28-a | bad | first write written; second write written`. That file plants a Review and a revision at owner level and tests DM-41's trigger, which is W-C02-10's (it serves W-C02-10 point 5, its header). It calls no M09-03 function; it fails on any build until W-C02-10.
  - Every other file `COULD NOT CHECK` on its `-pre` line, as in 4.4, and T-W14-FN `FN-pre | could_not_check | no function of the ledger transfer's group exists`.
- **08, the catalogue:** 4.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 M09-03; one transaction rolled back): `M0903_FUNCTIONS PASS (125/125)`. The cases: 35 for `open_mission`, 27 for `revise_mission`, 11 for `record_need`, 6 for `resolve_need`, 22 for `open_decision`, 12 for `link_prior_decisions` and 12 for `read_decision`. Each compares the answer's code and the change of eight tables. Among them:
  - `OM-revision-beyond (C-20)`: `mission_authority`, `{"rejected": 1}`. `OM-revision-earlier`: `mission_authority`. `OM-revision-answered-of-two`: `ok`. `OM-answered-revision-null`: `could_not_check`.
  - `OM-read-unreadable (42P01)`: `owner_authority: its input could not be read (SQLSTATE 42P01)`. `OM-write-failed`: `the write failed (SQLSTATE P0001)`, `{"rejected": 1}`. `OM-write-P0D02`: `synthetic write-path check: its input could not be read`.
  - `RM-repeat-before-stale`: `ok repeat`, `{}`. `RM-widen-high_impact`: `mission_authority`. `RM-closed-reopen`: `mission_closed`. `RM-f06-recipe`: `ok`, then `RM-f06-repeat`: `ok repeat`.
  - `OD-work-relation`: one `about` relation from the work item (revision 1) to the decision (revision 1), the work item's scope. `OD-work-kurulum-outside`: `not_owner`. `OD-work-calisma-exam-task`: `ok`.
  - `LP-ids`: 2 for three priors with one named twice. `RD-answer`: the decision's id, revision 1, status `open`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `mission`.
- **11:** the server log, `508 lines; token-format strings: 0`.
- **12:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **13 to 20, the breaks.** Each is one exact replacement in a copy of M09-03 outside the repository (`brk.py`: `made`). Each copy was applied in place of M09-03, the self-check and the staged F06, 5B and 6TK were run, and its functions were dropped:
  - **b1**, the answered-revision comparison of `open_mission` removed: `OM-revision-beyond (C-20)` and `OM-revision-earlier` answer `ok`, `M0903_FUNCTIONS FAIL (2 of 125 …)`.
  - **b2**, `open_mission`'s literal widened to `devos_calisma`: `5B-R03-open_mission-cal | bad`, `W07_5B_AUTHORIZATION_MATRIX FAIL (1 bad, …)`; `6TK-ka1 | bad`, `W07_6TK_TOKEN_REASONS FAIL (1 bad, …)`; self-check `OM-role-devos_calisma` and `OM-reject-row` red.
  - **b3**, `revise_mission`'s repeat check removed: `F06-repeat:revise_mission | bad | exact repeat: returned {… "reason_code": "stale_revision"}`, `W07_F06_STATE_CHANGE_EVENT FAIL (1 bad, …)`; self-check `RM-repeat-before-stale`, `RM-f06-repeat` red.
  - **b4**, `record_need`'s event write removed: `F06-event:record_need | bad | … new events []`, F06 `FAIL`; self-check four `RN-*` red.
  - **b5**, a closed Mission not terminal: self-check `RM-closed-reopen`, `-closed-reopen-with-batu`, `-closed-content` and `RN-mission-closed` red.
  - **b6**, Rule O's `devos_kurulum` clause removed in `open_decision`: self-check `OD-work-kurulum-outside` red.
  - So each check here turns red when its rule is removed. F06, 5B and 6TK caught b2 to b4; only the self-check caught b1, b5 and b6, because no merged test runs those rules yet (4.4).
  - 20: `186 lines; token-format strings: 0`, `[cluster directory deleted: yes]`.
- **21:** the hashes in the envelope; `git status --porcelain`: `M evidence/C02/EV-C02-013_w09_interface.md`, `?? supabase/migrations/20261018214501_w09_mission_need_decision.sql` (before this section and the raw files were written); `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

**The rerun on the new bytes (CHK-C02-086 C1 (c)), runs 22 to 38.**
- **The label.** **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0903` at `c3cd1ed`, with M09-03 modified. The main run started 2026-10-18T22:23:20Z and ended 22:23:25Z, on one cluster (`…/scratchpad/m0903b_run/rerun.sh`). The break runs started 22:23:25Z and ended 22:23:28Z, on a second cluster (`…/scratchpad/m0903b_run/brk.sh`).
- **The drivers.** Those of runs 01 to 21: `run.sh` with its cluster under `…/m0903b_run/pg` and its socket in `…/scratchpad/m3bs`, since the longer path exceeds the 107-byte socket limit. `drive.py`, `setup.sql`, `scrub.py`, `logscan.py` and `catalog.sql` are unchanged from `…/m0903_run/`.
- **A trial run.** A run of the same drivers just before, writing to `…/scratchpad/m0903b_raw/`, gave the same counts. It is not filed.

The runs:
- **22:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **23:** the fourteen migrations before M09-03, each `[exit 0]` with its history row (28 `[exit 0]` lines).
- **24, M09-03's new bytes:** `CREATE FUNCTION` ×7, `COMMENT`, `REVOKE` ×7, `DO`, `[exit 0]`; history row `[exit 0]`.
- **25 and 31:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 15, "migrations_expected": 15`, `"complete": true`.
- **26, the eight SQL copies:** all pass, with the counts of run 05: `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`.
- **27 and 28, the staged files run in place.** With uuids masked, run 27 differs from run 06 in three lines only:
  - `F06-event:revise_mission | could_not_check | the recipe's call was not accepted, so no state change could be observed: returned {"reason": "reason: missing (a call that writes a new revision needs one)", "status": "refused", "reason_code": "missing_field"}`;
  - `F06-repeat:revise_mission | could_not_check | no accepted call to repeat`;
  - `W07_F06_STATE_CHANGE_EVENT COULD NOT CHECK (6 of 27 could not be checked)`, none `bad`.

  Everything else is as in run 06: `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (18 of 66 …)`, none `bad`; `W07_6TK_TOKEN_REASONS PASS (32/32)`; `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, …)`, which is W-C02-10's, as in run 06; every other file `COULD NOT CHECK` on its `-pre` line. Run 28 is T-W14-FN's `-pre` line, as in run 07.
- **29, the catalogue:** identical to run 08 but for its scrub line (`diff`). So `revise_mission` is still definer, VOLATILE, with the fixed path and `array['devos_kurulum']`, EXECUTE to `anon` only.
- **30, the self-check updated for C1 (a)** (`…/m0903b_run/fn_check.sql`): `M0903_FUNCTIONS PASS (135/135)`. That is run 09's 125 cases with these changes in the `revise_mission` block:
  - The calls that are to write a revision now send `reason`.
  - New cases:
    - `RM-narrow-reason-stored`: the reason is stored in the new revision;
    - `RM-reason-absent` and `RM-reason-json-null`: `missing_field`, with `RM-reason-absent-names-field`, whose reason begins `reason: `;
    - `RM-reason-number`: `invalid_field`;
    - `RM-reason-before-stale`, `RM-reason-before-authority` and `RM-reason-content-and-status`: `missing_field`, nothing written, the status unchanged;
    - `RM-widen-batu-is-current-authority`;
    - `RM-f06-recipe-with-reason`: `ok`.
  - Changed: `RM-f06-recipe`, F06's recipe as merged, is now `missing_field`, `{"rejected": 1}`. `RM-f06-repeat` repeats the recipe with `reason`: `ok repeat`.
  - Without a `reason`, as before: `RM-pause`, `RM-resume` and `RM-close` (status only) are `ok`, and `RM-repeat-before-stale` is `ok repeat`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `mission`.
- **32:** the server log, `508 lines; token-format strings: 0`. **33:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **34 to 37, the breaks** (`brk.py`: both `made (first of 1 occurrence(s) replaced)`). Each copy was applied in place of M09-03, the self-check and the staged F06, 5B and 6TK were run, and its functions were dropped (`[drop exit 0]`):
  - **b7, C1 (a)'s refusal removed** (`if coalesce(jsonb_typeof(p -> 'reason'), 'null') <> 'string' then` becomes `if false then`): `M0903_FUNCTIONS FAIL (10 of 135 not as wanted)`. Red are `RM-reason-absent` (`ok`, a new revision written), `-names-field`, `-json-null`, `-before-stale`, `-before-authority`, `-content-and-status` and `RM-f06-recipe` (`ok`). Three cases after them are red too, because those writes moved the Mission's revision on: `RM-widen-no-authority`, `RM-widen-batu` and `RM-f06-recipe-with-reason`. **F06 does not catch b7.** Its two `revise_mission` cases turn `ok` and F06 goes back to `COULD NOT CHECK (4 of 27 …)`: as merged, F06 prefers the build without the refusal until its recipe sends `reason`. 5B and 6TK are unchanged.
  - **b3, `revise_mission`'s repeat check removed** (run 16's break, on the new bytes): `M0903_FUNCTIONS FAIL (2 of 135 …)`, red `RM-repeat-before-stale` and `RM-f06-repeat` (`stale_revision`). **F06 no longer catches b3**, which it did in run 16: its `revise_mission` recipe is refused, so `F06-repeat:revise_mission` is `could_not_check`, `COULD NOT CHECK (6 of 27 …)`. It catches b3 again once its recipe sends `reason`. Until then only the self-check catches b3 (4.4).
  - **37:** `60 lines; token-format strings: 0`, `[cluster directory deleted: yes]`.
- **38:** the hashes in the envelope. `git status --porcelain`: M09-03 and EV13 modified, the sixteen new raw files 22 to 37 untracked, before this section and file 38 were written. `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 4.6 Open, and for whom

1. **For the test designer, under ledger rule 3, before the first result of T-W07-N29** (reported, not done: no test file is changed here). Two merged cases cannot pass on a build that follows EV13 2.2:
   - `N29-mis-widen-high_impact` reads `devos_private.mission.scope` (`job/w07_n29_impact_class.sql:566-567`). That table has no `scope` column (migration 20261014170203 lines 59-63; the scope is in `mission_revision`). So `pg_temp.w07_rec` gets NULL and records `bad` on any build. The case's call also sends no `base_revision`, so it is refused `missing_field`, not for the rule it means to test.
   - `N29-pos-mis-widen-batu` sends no `base_revision` (`:568-569`), which 2.2 requires, so it is refused `missing_field` where it wants `accepted`.
   - Both need `base_revision` (the Mission's current revision) and a read of the scope through `devos_private.mission_current` or `mission_revision`.
2. **For the executor** (reported, not done):
   - Departures 1 to 4 are now stated in EV13 section 16 (CHK-C02-086 C2).
   - CHK-C02-086 C1 (b): a note asking the test designer to add `reason` to F06's `revise_mission` recipe (`job/w07_f06_state_change_event.sql:450-453`), under ledger rule 3, before the pull request that copies that file into `supabase/migrations/tests/`. Until then F06 cannot PASS, and it catches neither b3 nor b7 (4.5, runs 35 and 36).
   - CHK-C02-086 C3: a note, with an owner and a deadline, asking who decides whether a widening must name a Decision other than the one the Mission already rests on (4.2 item 3).
   - CHK-C02-086 C4: F06's missing `read_decision` recipe and `work_revision`'s append-only trigger for B-N29-4, carried to the test designer.
3. **For W-C02-10 and the test designer:** break B-N29-4 updates `devos_private.work.impact_class` (`tests/C02/W-C02-07/breaks/B-N29-4_routine_decision_on_high_item.sql`). That column is `work_revision`'s (migration 20261014170203 line 151), so the patch fails with SQLSTATE 42703 and the break would be "not shown". Found while reading, not run here.
4. **For the checker of verdict (i):**
   - EV13 section 15 (N-279 (20)) and section 16 with its *[C-086]* marks (CHK-C02-086 C2);
   - C1 (a)'s refusal and its place in `revise_mission`'s order (4.2 item 1), and the rerun on the new bytes (runs 22 to 38);
   - 4.2's departures, chiefly 1, 3, 5 and 6;
   - that FN-MA-revision's expected `mission_authority` is what `open_mission`'s and `revise_mission`'s order gives, while `transfer_mission` itself is M09-11's;
   - the self-check and the break runs, which are the producer's own.
5. **For the producers of M09-04 and M09-06:**
   - Rule O in `open_decision` is written inline (M09-03 adds no helper). The same reads serve `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review`, `relate` and `retract_relation`. A shared helper, if they make one, should not change `open_decision`'s answers.
   - T-W07-N29's `N29-dec-routine-on-high` (W-C02-10's rule) reads the relation `open_decision` writes, from the work item to the decision.

## 5. M09-04: Work and effort policy

The producer's record of `supabase/migrations/20261018230001_w09_work_effort.sql` (M09-04), written on branch `claude/c02-w09-m0904` at `main` `d032a8475b19e11a1cf9971852f4abb36883d0fd`, where M09-01 to M09-03 are merged. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at that commit, with EV13's correction section 17 added by the same producer. M09-04 means the file above, and M09-04:n a line of it. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 17 first.** EV13 gained "17. Correction, 2026-10-18 (M09-04)", with marks *[C-M04]* in 2.3's paragraph "What Rule O reads" and in the rows `admit_work`, `revise_work`, `mark_stale` and `set_effort_policy`. It states the forms 5.2 lists. M09-04's checker judges it.
- **The note items that bind M09-04, checked on `main` before the SQL** (`plan/work/C02.md`):
  - N-279 (15), CHK-C02-077 K1: "before any result of T-W07-ROC and before the first commit of the migrations that build `revise_work` and `retract_relation`". **Met.** EV13 R2-6 chose option (a); the test designer moved `ROC-x-o-mission-unreadable`'s revoke to `devos_private.mission_revision` (`job/w07_roc_ownership_and_claim_class.sql:894`, commit `04da0de`), and CHK-C02-081 judged that revision sound (L-347).
  - N-279 (12): the form of `input_refs` elements, "before the first commit of the migration that builds the function concerned" (`admit_work`). **Met.** EV13 R2-4 fixed `{ref, revision}`; F08's fixture `wd` sends it (`job/w07_f08_recheck_at_effect.sql:330-331`, commit `04da0de`).
  - N-279 (16): Group A's and F06's fixture Decisions carry `answered_revision` 1. **Met** (before M09-03); Group A's fixture Missions are opened through `open_mission` here, and DM34 runs through them.
  - N-279 (10): its three rules concern `register_artifact`, `prepare_operation` and `transfer_acceptance` (M09-07, M09-08, M09-12). Not M09-04's.
  - N-279 (1), (17), (19), (21), N-282, N-283 and N-284: their deadlines are C03's work list, M09-08, each Group B file's first result or copy, W-C02-10's sampling call, the first migration adding a role class, N29's or F06's first result or copy, and verdict (ii). None falls at M09-04's commit. N-283 (1) to (5) bear on tests that call M09-04's functions (N29, F06); 5.4 says what they mean here.
- **Appendix B principle 3** (B:17) binds `revise_work`, the one function here that writes a new revision of an existing record: 5.2 item 1.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | `main` `d032a84`, clean before this work; the runs were made with M09-04 and the raw files untracked (O, `26_git_hashes.txt`). Bytes run: M09-04 `165ea69997401d944ecd73a598dd3627caf841ffaa88ab91578f792a89eb01d5`; the self-check `…/scratchpad/m0904_run/fn_check.sql` `5bd5c6d9f1b3baf7d0fc4d14222522adbc11e98ee5d6c6d053455991cdaf15a4`; the break maker `…/scratchpad/m0904_run/brk.py` `805f1e7231df9b010a0e81fea18c4139e8e273627c8d21f45963c4e6c58354eb`. EV13 with its section 17, at this record's writing (after the runs): `0d335e5c3b12d0f6365074df85447c7adde7986f8abfd33d805ce097e8e1a8ff`. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1, 3 and 4: one throwaway PostgreSQL 16.15 cluster per run, unix socket only (in `…/scratchpad/m4s`, a path short enough for the 107-byte socket limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, `12_stop.txt` and `25_breaks_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: M09-02's `setup.sql` unchanged (`…/scratchpad/m0903_run/setup.sql`), with the ACL read on `devos`. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `d032a84`; EV13 with Revisions 1 and 2, its corrections 15 and 16, and its section 17 (for M09-04's checker) |
| Input | The sixteen migrations (`main`'s fifteen and M09-04); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `tests/C02/W-C02-07/job/` and T-W14-FN's, run in place; the producer's self-check; eleven break copies of M09-04 made outside the repository (`…/scratchpad/m0904_brk/`, by `brk.py`) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m04_offline_01_init_setup.txt` to `…_26_git_hashes.txt`, written directly by `…/scratchpad/m0904_run/rerun.sh` (01 to 12) and `brk.sh` (13 to 25). Every file but `26` passed through section 1's filter, and each ends `0 token-format strings removed`. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09) and the break runs (14 to 24) are the producer's own |

### 5.1 What was built, object by object

All in M09-04, in this order: the six functions of EV13 2.3, and their grants. No table, type or `devos_private` function is added. M09-01 to M09-03 are not changed; M09-01's and M09-02's helpers are called: `caller_role_class`, `write_event`, `reject`, `scope_within` and `is_installation_mission`.

**The form every function has** is M09-03's (4.1): the derivation first; the read block with steps (b) to (f), a decided refusal by `v_code`, `v_reason` and `P0D01`, any other error `could_not_check` with `<v_check>: its input could not be read (SQLSTATE <code>)`; the write block, `write_failed` but `P0D02`; one per-call row by `reject` after a refusal; fixed reasons; keys a function does not read ignored; the exact repeat `ok` with `"repeat": true`. O (`08_catalog.txt`): each of the six has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, ACL `{postgres=X/postgres,anon=X/postgres}`.

**Rule O and Rule C** (EV-C02-008 1.7.1; EV13 2.3, "What Rule O reads", with C-M04) are written inline in each function that checks them, as `open_decision` writes Rule O (4.6 item 5). Rule O reads the work item's current `work_revision` row (its `mission_revision_id`), the `mission_revision` row it names (its `mission_id`), that Mission's events through `is_installation_mission`, and for `devos_sinav` the exam link; never `devos_private.mission`. Rule C reads `devos_private.assignment`. The reasons name the rule, never the item's opener.

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.admit_work(p jsonb)` (M09-04:45) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. Required `mission_ref` (uuid), `scope` (a dotted path, else `invalid_field`), `purpose`, `impact_class` (`routine` or `high`); `mission_revision` absent or JSON null `could_not_check`, not an integer of at least 1 `invalid_field`. Optional `consumer`, `return_to`, `stop_rule`, `acceptance_ref`, `effort_policy_ref` (uuid), and the arrays `input_refs`, `target_refs`, `method_refs`, `mandatory_needs` (default `[]`); each element of `input_refs` and `target_refs` `{"ref": <uuid>, "revision": <integer>}`, else `invalid_field`. Then: the Mission `for share` (absent or status NULL: `could_not_check`); its revisions (none: `could_not_check`; the revision named absent: `could_not_check`; an earlier one: `stale_revision`, M09-04:199-202); not `active`: `mission_not_active`; `scope_within` false: `scope_outside` (M09-04:213-216), NULL `could_not_check`; each element (a Work, Artifact, Finding or Decision with that revision; another family `invalid_field`; no record, no such revision or no revision sent `could_not_check`); `effort_policy_ref` (no record or status NULL `could_not_check`; retired `invalid_field`). Writes the Work (its axes at their defaults), revision 1 tied to the Mission revision named, and `work_admitted` (revision 1; payload the fields). No exact repeat. Answer `id`, `revision` 1 | 2.3's row with R2-4 and C-M04 (17 (3)); B 3.3, principle 4; DM-34; 1 items 3, 4, 7 (ii), 14 |
| `devos_api.revise_work(p jsonb)` (M09-04:327) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. Required `id`, `base_revision`; optional every revision field of `admit_work` but `mission_ref`, and `reason`. Order: the form; the work item `for update` (`not_found` when absent); its current revision (missing: `could_not_check`); Rule O; Rule C; a `mission_revision` sent that names no revision of the Mission: `could_not_check`; the exact repeat (every field as the current revision's: `ok`, `"repeat": true`, M09-04:579-589); no string `reason`: `missing_field` (M09-04:593-597); `base_revision` not current: `stale_revision`; a `mission_revision` sent that is not the Mission's current: `stale_revision`; the elements sent and `effort_policy_ref`, as in `admit_work`; the new scope not within the tied Mission revision's: `scope_outside`. Writes revision n+1 with the reason, and `work_revised` (payload the fields, `base_revision`, `reason`). Refusal rows carry `target_ref` `id` and `target_revision` `base_revision`. Answer `id`, `revision` | 2.3's row with R2-4, R2-9 and C-M04 (17 (1), (4), (5)); B principle 3 (B:17); DM-02; EV-C02-008 1.7.1 |
| `devos_api.mark_stale(work_id uuid, reason text)` (M09-04:736) | `devos_calisma`, `devos_sinav`, `devos_kurulum`. `work_id` NULL `missing_field`; the work item `for update` (`not_found`); its qualification and current revision (missing: `could_not_check`); Rule O, not Rule C; already `stale`: the exact repeat. Writes `qualification` `stale` and `work_marked_stale` on the current revision (payload `qualification`, `previous_qualification`, `reason`). Refusal rows carry `target_ref` `work_id`. Answer `id` | 2.3's row with C-M04 (17 (1), (5)); B 3.3 (B:134); EV-C02-008 1.7.1 |
| `devos_api.cancel_work(work_id uuid, reason text)` (M09-04:871) | As `mark_stale`, with Rule C after Rule O (M09-04:966-979); already `cancelled`: the exact repeat. Writes `execution` `cancelled` and `work_cancelled` (payload `execution`, `previous_execution`, `reason`). A claim of the caller's own class stays active; `check_claim` then refuses its effects `claim_not_active` (3.3 item 2) | 2.3's row; B 3.3 (B:136); EV-C02-008 1.7.1 |
| `devos_api.reopen_for_review(work_id uuid, reason text)` (M09-04:1024) | `devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum`. As `mark_stale`; Rule O for every class but `devos_denetim`, which reads no Mission (any work item); not Rule C; already `needs_review`: the exact repeat. Writes `qualification` `needs_review` and `work_reopened_for_review`; `execution` and `acceptance` are not changed | 2.3's row with C-M04 (17 (5)); B 3.3 (B:135); EV-C02-008 1.7.1 |
| `devos_api.set_effort_policy(p jsonb)` (M09-04:1174) | `devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum` at the gate. The kind: `retire_id`, `work_ref` (an item's policy) or `work_class` (a standing one). An item's policy: the work item `for update` (absent: `could_not_check`); `standing_policy_ref` (absent `could_not_check`; an item's policy or a retired one `invalid_field`); below the floor (`high`, or the standing policy's level) it is a reduction: `devos_denetim` only (`not_owner`), with a string `reduction_reason` (`missing_field`, M09-04:1380-1384), `approved_by_role_class` `devos_denetim`; at or above it, `devos_denetim` is refused `not_owner` and the others pass Rule O; then the exact repeat against the item's active policy. Writes: the item's earlier active policies `retired` (each `effort_policy_retired`, origin `rule`, M09-04:1462-1468), the new policy and `effort_policy_set`. A standing policy: `devos_denetim` only, else `not_owner`. `retire_id`: `devos_denetim` only (`not_owner`, M09-04:1304-1308, before the policy is read); absent `not_found`; an item's policy `invalid_field`; already retired the exact repeat; writes `retired` and `effort_policy_retired`. Answer `id` | 2.3's row with C-M04 (17 (2)); EV-C02-008 1.7.4; B 3.18 (B:312, B:314); P:763 |
| Grants (M09-04:1497-1528) | `revoke all … from public` and from the four API roles where they exist, on all six; `grant execute … to anon` on all six; no type, no private function | 1 item 13; T-W08-PRIV's constraint |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the fifteen `devos_api` functions.
- **Types.** No `devos_private` type has PUBLIC USAGE.
- **The literals**, as the break patches read them: `admit_work`, `revise_work`, `mark_stale` and `cancel_work`: `array['devos_calisma', 'devos_sinav', 'devos_kurulum']`; `reopen_for_review` and `set_effort_policy`: `array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']`.
- **The unqualified-name scan.** No hit in M09-04's six functions; its four hits are section 3.1's.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** Still `deployment_drift`, `read_decision` and `token_role_class`: the six are state-changing (F06's list).
- **The exam table's name.** It occurs in the text of `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` and `set_effort_policy` (Rule O's `devos_sinav` clause), all five on T-W07-N08's list of functions exempt by name (`job/w07_n08_exam_records.sql:283-286`), and not in `admit_work`'s, which is not on it (5.2 item 4).

### 5.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. No merged test is changed. Where the record and a merged test pull apart, the record's side is built and the test's form is reported (5.6). EV13 section 17 (C-M04) states items 1 to 7 in the record itself.
1. **`revise_work`'s `reason`** (EV13 17 (1)). Required on every call that writes a new revision, `missing_field` without a string; the exact repeat needs none. 2.3's row stars it, and B principle 3 (B:17) asks for it: not a departure, but its place in the order is chosen. It is after Rule O, Rule C and the repeat, and before `stale_revision`. So a stale call without a reason is `missing_field` (`RW-reason-before-stale`).
2. **The state functions' `reason` may be NULL** (EV13 17 (1)): `mark_stale`, `cancel_work` and `reopen_for_review` write no revision (DM-09), as M09-03's `resolve_need`.
3. **`set_effort_policy`** (EV13 17 (2)):
   - **The levels.** `high`, `medium` and `low`, ordered so, are chosen from T-W07-N03's interface; B names none but `high`.
   - **The kind.** It is told by the level against the floor, never by the steps.
   - **Retiring.** `retire_id` retires only a standing policy, and an already retired one is the exact repeat.
   - **References.** A `standing_policy_ref` that names an item's policy is `invalid_field`.
   - **Writes.** The earlier item policy is retired with origin `rule` (EV13 1 item 10: a record the database changes by rule inside the call). The work item's revision and its `effort_policy_ref` are not touched.
   - **Locks.** The work item's row is locked `for update`, so that two calls for one item do not both find no active policy and write two.
4. **`admit_work`** (EV13 17 (3)):
   - **The Mission's revision.** `mission_revision` absent is `could_not_check`, not item 4's `missing_field`, for R2-1's and C-20's reason (a reference without its revision).
   - **Other families.** An element naming another family is `invalid_field` only for the nine families it looks up.
   - **Exam records.** An EvalRun id is `could_not_check` for every class. `admit_work`'s text must not name the exam table: T-W07-N08's records part requires every `devos_api` function whose text names it, but its nine exempt by name, to refuse the four classes that may not read exam records (`job/w07_n08_exam_records.sql:381-393`), and `admit_work` admits `devos_calisma` and `devos_kurulum`. Reading EvalRun for `devos_sinav` alone would tell `sin` an `invalid_field` that the others get as `could_not_check`, which no source asks for.
   - **No Rule O.** `admit_work` checks no Rule O: EV-C02-008 1.7.1 lists the functions that do, and it is not among them.
5. **`revise_work`'s other forms** (EV13 17 (4)):
   - **The Mission's revision.** `mission_revision` moves the tie, only to the Mission's current revision. The scope is checked against the tied revision's scope.
   - **Keys.** `mission_ref` is not read.
   - **Clearing a field.** A key absent or JSON null keeps the current value, so an optional text field or `effort_policy_ref` cannot be cleared by a revision (a residual, 5.6).
   - **Elements.** The elements of `input_refs` and `target_refs` are checked only when sent.
6. **Rule O and Rule C** (EV13 17 (5)):
   - **No creation event.** A Mission with no creation event is `could_not_check`.
   - **`devos_denetim`.** It reads no Mission in `reopen_for_review`.
   - **Lapsed claims.** Rule C counts only claims whose lease has not run out. A claim without its status, lease or role class is `could_not_check`.
   - **Locks.** Rule C takes no lock on `assignment`: the five functions lock the work item `for update`, and `claim` locks it `for update` (EV13 2.4), so a claim and one of these calls serialize on that row. If M09-05's `claim` takes a weaker lock, Rule C can race; 5.6 carries it to that producer.
7. **Rule O and Rule C come before the exact repeat**, as M09-03's departure 6 puts `owner_authority` before it: neither is a check "that the first call's own write would now fail" (R2-9). So an identical `cancel_work` by a class Rule O refuses is `not_owner`, not a repeat.
8. **Forms the record leaves open (chosen):**
   - `p` NULL is `missing_field`; `p` not an object `invalid_field`; an optional key holding JSON null counts as absent; a revision is a JSON number of at least 1; a uuid is in its canonical 36-character form.
   - Answers: `admit_work` and `revise_work` `id`, `revision`; the others `id`.
   - The state events are written on the work item's current revision; EffortPolicy has no revision, so its events have `aggregate_revision` NULL.
   - Refusal rows: `revise_work` names `id` and `base_revision`; the state functions `work_id`; `set_effort_policy` `retire_id` when sent; the creating calls none.
   - `declared_session_id` is read from `p` only; the three `(work_id, reason)` functions have no `p`.
   - `cancel_work` cancels a work item in any execution state but `cancelled`; no source refuses a finished one.
   - Locks: the Mission `for share` in `admit_work`; the work item `for update` in the five others; a cited standing policy and an `effort_policy_ref` `for share`; a policy to retire `for update`.

Not departures, for the checker:
- `admit_work` ignores a `status` or a role name sent in `p` (`AW-undeclared-keys-ignored`).
- `set_effort_policy` ignores F06's `work_revision` and N03's `status` keys (`SP-f06-form-keys-ignored`): EffortPolicy's `work_ref` has no revision (B 3.18; EV13 1 item 3).
- An empty `expert_assessment_ref` is accepted here; it is W-C02-10's gate (`SP-expert-empty`).
- The steps are not compared with the standing policy's: also W-C02-10's.

### 5.3 How W-C02-09's points are served by M09-04

- **Point 1.** A versioned file later than `20261018214501`, plain SQL, no `psql` meta-command, no backslash (O, `26_git_hashes.txt`: `backslashes in M09-04: 0`). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject`, on every refusal (run 09's `{"rejected": 1}` deltas; `AW-reject-row`);
  - F06's list: none of the six carries the read marker (run 08, part 7; `F06-list | ok | 15 devos_api functions (3 marked devos:read)`);
  - the events: origin `call`, the token's class (`AW-pos-event`, `RW-narrow-event`, `MS-pos-event`), and `rule` for a policy retired by a new one (`SP-second-retires-first-state`);
  - Rules O and C as EV-C02-008 1.7.1 decides them; `set_effort_policy`'s three kinds as 1.7.4 decides them.
  - Offline, `deployment_drift` reports `no_difference`, 16 of 16 (runs 04 and 10).
- **Point 2.** Fifteen of the 55 `devos_api` functions now exist (six here), each with definer rights, the fixed `search_path` and every DevOS name qualified (5.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the six refuses a call with no token before any other check (`F06-refused:<fn>`, all six `ok`; `AW-no-token`, `SP-no-token`). Each refuses a class not on its list with one per-call row: 5B rows R02 (`admit_work`), R08g, R23 and R24, their 36 cells `ok`; the self-check's `*-role-*` cases.
  - Fifth bullet. A declared role or approval changes nothing: `AW-undeclared-keys-ignored`, `SP-reduction-calisma-declared-approval` (`not_owner`).
- **Point 5.**
  - Each state-changing function writes its event in the same transaction, with the token's class (`F06-event:admit_work | ok`, `new events [{"origin": "call", "this_tx": true, "role_class": "devos_calisma"}]`; the self-check's event cases).
  - An exact repeat writes no event and raises no error (`RW-repeat-before-stale`, `MS-repeat`, `CW-repeat`, `RR-repeat`, `SP-repeat`, `SP-retire-repeat`, each `ok repeat`, `{}`).
  - A failure planted mid-transaction leaves no half state and no orphan event (`AW-write-failed` on `work_revision`, `AW-write-event-failed` on `event`, `RW-write-failed`, `SP-write-failed`: only the refusal row is added).
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass:
  - `AW-mission-absent`, `-mission-revision-absent`, `-json-null`, `-beyond`, `-ref-no-revision`, `-ref-random`, `-ref-revision-999`, `-policy-absent`, `-read-unreadable` (42501), `-write-P0D02`;
  - `RW-input-random`, `-mission-revision-beyond`, `-o-mission-no-event`, `-o-mission-unreadable` (42501), `-o-mission-link-null`, `-c-partial`, `-c-unreadable` (42501), `-c-missing` (42P01);
  - `MS-o-mission-no-event`, `CW-c-partial`, `SP-o-mission-no-event`, `SP-work-absent`, `SP-standing-ref-absent`, `SP-policy-unreadable` (42501).
  - These are the forms T-W07-ROC's nine `ROC-x-*` cases plant, on the self-check's stand-ins; ROC itself does not run yet (5.4).
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the six, run in place (run 06):
    - **T-W07-DM34 `PASS (10/10)`**: `admit_work` and `revise_work` through Group A's fixtures, the first merged file to pass whole on these functions;
    - 5B: the 36 cells of R02's `admit_work`, R08g, R23 and R24 `ok`, `COULD NOT CHECK (15 of 99 …)` for rows whose functions are not built, none `bad`;
    - 6TK `PASS (32/32)`;
    - F06: `F06-event:admit_work` and the six `F06-refused:<fn>` `ok`; ten cases of the five others `could_not_check` (5.4); `COULD NOT CHECK (16 of 44 …)`, none `bad`.
  - Their copies are a later pull request's (R:247; EV13 section 11).

### 5.4 What M09-04 does not yet serve

- **T-W07-F06's ten cases for `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` and `set_effort_policy`** (`F06-event:<fn>` and `F06-repeat:<fn>`): `could_not_check`, `rule_o: whether the work item lies under the installation's Mission is missing or partial`. F06 plants these work items with `pg_temp.w07_plant`, whose Missions have no event (`job/w07_f06_state_change_event.sql:185-230`, `:470-512`). By EV13 1 item 7 (ii) and 17 (5), Rule O cannot read such a Mission. And `revise_work`'s recipe (`:420-421`) is an exact repeat (EV13 17 (5)). Until the test designer revises them, no merged test shows these five functions' events or repeats; the self-check alone does. F06's other `could_not_check` cases are not M09-04's: `revise_mission`'s two (N-283 (4)), `read_decision`'s recipe (N-283 (5)), and three that need `relate`.
- **The staged files that call these functions but need a later function stop at their `-pre` line** (run 06):
  - Group A but DM34 (5C, 6RG, DM07, F01, F05, F07, F08, N17) need `claim`.
  - Group C (N01, N02, N03, N08, N28, N29, ROC, T31, 5D, 6ST, DM11, DM47, FGFIND) need `relate`, `record_finding`, `open_review`, `claim` or W-C02-10's tables.
  - So T-W07-ROC (Rules O and C through the merged file) and T-W07-N03 (`set_effort_policy`'s kinds) do not run. Each is "could not check", not counted.
- **The test designer's unmerged revision of `w07_set_status`** (branch `claude/c02-w07-n283-tests`; it writes text into `decision.answer`, `jsonb`). It changes nothing observable here: every Group C file stops at its `-pre` line on a missing function first. Which of their cases that helper's fault would stop cannot be seen until those functions exist.
- **T-W07-N03's forms** (EV13 17 (2)): its retirement form `{id, status}` and `N03-pos-over-with-approval`'s missing `reduction_reason` cannot pass on this build once N03 runs.
- **The breaks that rewrite these functions** (B-ROC-1, -2, -3, B-N03-1 to -7, B-DM34-1, B-5D-3, B-5D-5) are W-C02-13's. They wrap the functions by name and signature, which M09-04 keeps.
  - B-DM34-1 reads `devos_private.mission.scope`, a column that does not exist (the scope is in `mission_revision`), and `mission_ref` as an object (D-1's old form; `tests/C02/W-C02-07/breaks/B-DM34-1_admit_scope_check_removed.sql`). So its wrapper gets NULL and passes every call through unchanged, and DM34-n1 to -n6 stay green: the break is "not shown" on any build. Read, not run. *[Dated line, 2026-10-18, L-367; CHK-C02-089 C2 (a): the mechanism above is wrong. Applied, the wrapper raises 42703 ("column scope does not exist") and DM34 ends COULD NOT CHECK, 10 of 10; the conclusion, "not shown", stands (N-285 item (3)).]*
  - *[Dated line, 2026-10-18, L-367; CHK-C02-089 C1: also unable to pass on a correct M09-04, and missed above and in 5.6 item 1: T-W07-F05 (c) (`job/w07_f05_scope_both_sides.sql`, line 309 with 363 to 367) and T-W07-F08 (b) and (w) (`job/w07_f08_recheck_at_effect.sql`, lines 323, 326, 377 to 378 and 451 to 452) revise a work item by sending only the scope it already has, plus a reason, which EV-C02-013 2.3 and R2-9 answer as an exact repeat (`ok`, repeat true, no new revision): F05-c is `could_not_check`, F08-b and F08-w `bad`, and F08-pos3 is refused once `claim` and `prepare_operation` exist. Carried as N-285 item (4).]*
  - B-5D-5 assumes N03's `{id, …}` form.
- **The test Mission and the installation's Mission in `devos`** (the transfer's functions, M09-11); Rule O's `kur` clause is shown on the self-check's stand-in only.

### 5.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0904` at `d032a84`, with M09-04 untracked. The main run started 2026-10-18T23:00:31Z and ended 23:00:35Z, on one cluster (`…/scratchpad/m0904_run/rerun.sh`). The break runs started 23:01:27Z and ended 23:01:42Z, on a second cluster (`…/scratchpad/m0904_run/brk.sh`).
- **The drivers.** `run.sh` and `drive.py` are `…/m0903b_run/run.sh` and `…/m0903_run/drive.py`, changed only in their paths (the clone `prd10`, the cluster under `…/m0904_run/pg`, the socket in `…/scratchpad/m4s`). `drive.py`'s line "M09-02 uncommitted" in run 04 is its old wording; the bytes run are the envelope's. `setup.sql`, `scrub.py`, `logscan.py` and `catalog.sql` are `…/m0903_run/`'s, unchanged.
- **Trial runs.** Two trial runs of the same drivers just before (`…/m0904_run/trial.sh`, `trial2.sh`) gave the same counts. They are not filed.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 …`, `[setup exit 0]`, `postgres|f`.
- **02:** the fifteen migrations before M09-04, each `[exit 0]` with its history row (30 `[exit 0]` lines).
- **03, M09-04:** `CREATE FUNCTION` ×6, `REVOKE` ×6, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 16, "migrations_expected": 16`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result):
  - `W07_DM34_MISSION_SCOPE PASS (10/10)`, for example `DM34-n1 | ok | a sibling scope: refused: scope_outside`, `DM34-n7 | ok | revise_work widening beyond the Mission: refused: scope_outside`, `DM34-pos3 | ok | revise_work within the Mission: accepted`.
  - `W07_F06_STATE_CHANGE_EVENT COULD NOT CHECK (16 of 44 could not be checked)`, none `bad`: `F06-event:admit_work | ok | … tables changed: ["work", "work_revision"]; new events [{"origin": "call", "this_tx": true, "role_class": "devos_calisma"}]`; `F06-event:cancel_work | could_not_check | the recipe's call was not accepted … "reason": "rule_o: whether the work item lies under the installation's Mission is missing or partial"`, and the same for the four others.
  - `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (15 of 99 could not be checked)`, none `bad`; for example `5B-R23-revise_work-den | ok | x cell: … code role_class_not_permitted`, `5B-R24-reopen_for_review-den | ok | v cell: … code not_found`. The 15 are the rows R04 to R07, R10, R10r, R13, R15, R17, R19 to R22, R25 and R26, whose functions are not built.
  - `W07_6TK_TOKEN_REASONS PASS (32/32)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`.
  - `W07_DM19B_BURST_COUNT COULD NOT CHECK (6 of 12 …)`, needing `accept`; `W07_N04_SELF_APPROVAL COULD NOT CHECK (4 of 4 …)`.
  - `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, …)`: W-C02-10's, as in section 4.5's runs 06 and 27; it calls no M09-04 function.
  - Every other file `COULD NOT CHECK` on its `-pre` line (5.4); run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 5.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 M09-04; one transaction rolled back): `M0904_FUNCTIONS PASS (175/175)`. The cases: 45 for `admit_work`, 40 for `revise_work`, 12 for `mark_stale`, 13 for `cancel_work`, 10 for `reopen_for_review` and 55 for `set_effort_policy`. Each compares the answer's code and the change of nine tables, and the state cases read the row after. Among them:
  - `AW-mission-revision-stale`: `stale_revision`; `AW-mission-revision-beyond`: `could_not_check`; `AW-ref-object-id-form`: `invalid_field`; `AW-ref-other-family` (a Need): `invalid_field`; `AW-ref-no-revision`: `could_not_check`.
  - `RW-repeat-before-stale`: `ok repeat`, `{}`; `RW-reason-before-stale`: `missing_field`; `RW-mission-revision-current-tie`: the new revision tied to the Mission's revision 3.
  - `RW-o-calisma-inside`, `-kurulum-outside`, `-sinav-no-link`: `not_owner`; `RW-o-kurulum-inside`, `-sinav-link`, `-calisma-exam-task`: `ok`.
  - `RW-c-other-class`: `other_class_claim`; `-own-class` and `-lapsed`: `ok`; `MS-c-not-checked` and `RR-c-not-checked`: `ok`; `CW-c-same-class`: `ok`, and the claim stays active.
  - `RR-denetim-reads-no-mission`: `ok` with `mission_revision` revoked from the owner.
  - `SP-reduction-calisma`, `-kurulum`, `-sinav`, `SP-denetim-default`, `SP-standing-calisma`, `SP-retire-calisma`: `not_owner`; `SP-reduction-denetim`: `ok`, `approved_by_role_class` `devos_denetim`; `SP-over-level-denetim`: `ok`; `SP-cite-retired`: `invalid_field`; `SP-retire-n03-form`: `missing_field`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `work`.
- **11:** the server log, `494 lines; token-format strings: 0`. **12:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **13 to 25, the breaks** (`brk.py`: each `made (one replacement in devos_api.<fn>)`, the replacement found after that function's `create` line). Each copy was applied in place of M09-04 (`[apply exit 0]`), the self-check and the staged DM34, F06, 5B and 6TK were run, and its six functions were dropped (`[drop exit 0]`):
  - **k01**, `admit_work`'s scope check removed: self-check `FAIL (3 of 175 …)`, red `AW-scope-sibling`, `-string-prefix`, `-wider`; **DM34 `FAIL (3 bad, …)`**, `DM34-n1` to `-n3` `bad`. DM34's n4 to n6 stay green, since the form check refuses a malformed scope before the containment.
  - **k02**, `admit_work`'s `stale_revision` removed: red `AW-mission-revision-stale`. No merged test catches it.
  - **k03**, `admit_work`'s literal widened to `devos_denetim`: red `AW-role-devos_denetim`, `AW-reject-row`; **5B `FAIL (1 bad, …)`**, `5B-R02-admit_work-den | bad`.
  - **k04**, `revise_work`'s repeat check removed: red `RW-repeat-before-stale` (`missing_field`) and `RW-f06-recipe-is-repeat` (a new revision written).
  - **k05**, `revise_work`'s `reason` not required: `FAIL (7 of 175 …)`, red `RW-reason-absent`, `-names-field`, `-json-null`, `-before-stale`, and three after them whose base revision the accepted call moved on.
  - **k06**, Rule C removed in `revise_work`: red `RW-c-other-class`.
  - **k07**, Rule O's `devos_kurulum` clause removed in `cancel_work`: red `CW-o-kurulum-outside`.
  - **k08**, `mark_stale` reading a Mission without a creation event as not the installation's: red `MS-o-mission-no-event`. **F06 prefers this break:** its two `mark_stale` cases turn `ok` and F06 goes to `COULD NOT CHECK (14 of 44 …)`, because its fixtures plant exactly such Missions (5.4).
  - **k09**, the reduction's approval removed in `set_effort_policy`: `FAIL (6 of 175 …)`, red `SP-reduction-calisma`, `-kurulum`, `-sinav`, the declared-approval case, and two after them.
  - **k10**, retiring by any class: red `SP-retire-calisma`, `-sinav`, `SP-retire-refused-keeps-active`, `SP-retire-denetim`.
  - **k11**, the item's earlier policy not retired: red `SP-second-retires-first`, its state case, and the three later writes that retire one.
  - So each check turns red when its rule is removed. DM34 caught k01 and 5B caught k03. The self-check alone caught the other nine, because no merged test runs those rules yet (5.4).
  - 25: `326 lines; token-format strings: 0`, `[cluster directory deleted: yes]`.
- **26:** the hashes in the envelope; `backslashes in M09-04: 0`; `git status --porcelain`: M09-04 and the raw files 01 to 26 untracked, before EV13 section 17 and this section were written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 5.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-F06's planted work items for `revise_work`, `mark_stale`, `cancel_work`, `reopen_for_review` and `set_effort_policy` (`job/w07_f06_state_change_event.sql:420-421`, `:470-512`) sit under Missions with no creation event, so Rule O answers `could_not_check`. They need a Mission whose creation event is not `transferred` (one opened with `open_mission`, or a planted `mission_opened` event). Until then F06 cannot pass W-C02-09 point 8 for these five, and it prefers break k08.
   - F06's `revise_work` recipe changes no field (`:420-421`). It needs a changed field, for example another scope under the planted one, or `purpose`.
   - T-W07-N03's retirement form `{"id": …, "status": "retired"}` (`job/w07_n03_effort_policy.sql:566-567`, `:575`, `:645-646`) and its interface line "a revision is a call with the policy's id"; EV13 2.3 builds `retire_id`. B-5D-5 assumes the same form.
   - `N03-pos-over-with-approval` (`:564-565`) is a reduction with no `reduction_reason`, which P:763 and EV13 2.3 require.
   - B-DM34-1 reads `devos_private.mission.scope` and `mission_ref` as an object, so it is "not shown" on any build (5.4).
2. **For the executor** (reported, not done):
   - T-W07-N08's records part (`job/w07_n08_exam_records.sql:381-393`) will require every `devos_api` function whose text names the exam table, but its nine exempt by name, to refuse `devos_calisma`, `devos_denetim`, `devos_kurulum` and `devos_ci` by role. M09-03's `open_decision` names it (Rule O's `devos_sinav` clause, M09-03:859) and is not exempt. So `N08-r-open_decision-<class>` will be `bad` once `record_eval_run` exists (M09-09). Either N08's list gains `open_decision`, or EV-C02-008 5.1's list is reread. Found while reading; not run here, since N08 stops at its `-pre` line.
3. **For the checker of verdict (i):**
   - EV13 section 17 with its *[C-M04]* marks;
   - 5.2's departures, chiefly 3, 4, 6 and 7;
   - the self-check and the break runs, which are the producer's own.
4. **For the producers of M09-05 and M09-06:**
   - `claim` must lock the work item `for update` (EV13 2.4): Rule C's freedom from races here rests on it (5.2 item 6).
   - `relate` and `retract_relation` check Rule O and Rule C with the same reads, written inline as here. Rule O's `devos_sinav` clause puts the exam table's name in their text, and both are on N08's exempt list.
5. **Residuals:**
   - A revision cannot clear an optional text field or `effort_policy_ref` (5.2 item 5).
   - `effort_policy_ref` may name another work item's policy. No source refuses it, and none is built.
   - That an item belongs to a standing policy's class is declared and falls to the sample review (B 3.18), which is W-C02-10's.

## 6. M09-05: readiness and claim

The producer's record of `supabase/migrations/20261018235501_w09_claims.sql` (M09-05), written on branch `claude/c02-w09-m0905` at `main` `4f011151c46d9837d085a4b5198f9c6780458ab9`, where M09-01 to M09-04 are merged. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at that commit, with EV13's correction section 18 added by the same producer. M09-05 means the file above, and M09-05:n a line of it. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 18 first.** EV13 gained "18. Correction, 2026-10-18 (M09-05)", with marks *[C-M05]* in 2.4's paragraph "Ready" and in the rows `ready_works`, `claim` and `revoke_claim`. It states the forms 6.2 lists. M09-05's checker judges it.
- **The note items that bind M09-05, checked on `main` before the SQL** (`plan/work/C02.md`):
  - **Binding M09-05's commit: none open.**
  - N-279 (12), its `group_mode` part: a hard `depends_on` without `group_id` is a group of one in readiness. Its deadline is the first commit of the migration that builds the function concerned. **Met:** EV13 R2-5 decided it, and M09-02's `ready_value` builds it (section 3.1). M09-05 calls `ready_value` unchanged.
  - N-279 (10), (15), (17), (18), (20), (21): their functions are M09-04, M09-06, M09-07, M09-08, M09-12 and W-C02-10's, not M09-05's.
  - N-279 (19): Group B's files (5B, 6TK, N04, N08) are audited for the `env_token` counting fault before each file's first result, and at the latest in the pull request that copies it. That is not a commit of M09-05. 5B and 6TK run here in place, which is not a result.
  - N-279 (1): no function sets `execution` `finished`; it may be met by a stated form of `release`. Its deadline is C03's work list. `release` here sets only the claim's status, as EV13 2.4 says.
  - **N-281** (the guard repeats a denied call's text, which can carry a claim-format string). Its deadline is "before the first call that returns a claim token to a session (W-C02-09's `claim`, M09-05, used over the real path)". That is the first real-path use, not M09-05's commit. It is **not met on `main`**: the note is open and no change of `.claude/hooks/` after it is merged. M09-05's merge makes that call possible once sitting A has exposed `devos_api`. So the executor holds the first real-path `claim` until N-281 is met.
  - N-280: before a `.py` file is copied. N-282: before a seventh role class. N-283 (6), (7), N-284, N-285, N-286: before a test file's first result or copy, before verdict (ii), or before M09-09. None falls at M09-05's commit.
  - Notes for M09-05's producer in this record:
    - Section 3.5 item 4: an effect calls `check_claim`, then `ready_value(work, assignment_id)`. M09-05 has no effect. Its `heartbeat` and `release` call `check_claim` with the work item and the claim `for update`.
    - Section 5.6 item 4: `claim` locks the work item `for update`. **Met** (M09-05:187).
- **Appendix B principle 3** binds no function here: none writes a revision.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | `main` `4f01115`, clean before this work. The runs were made with M09-05 and the raw files untracked (O, `34_git_hashes.txt`). Bytes run: M09-05 `90c3b7ed0a25ac60de3420143a8acd49fe3df2364e22c7e6b8a2e5014f4008dd`; the self-check `…/scratchpad/m0905_run/fn_check.sql` `1d2086806b724c8ecd13f6becfe7bf679b96d70a16b1f5171aabd5bde0931d31`; the break maker `…/scratchpad/m0905_run/brk.py` `14ec534e216cdebefc21eeabf08a5277825723e203a5f2a7b59b341ec249a5dd` (the other drivers' hashes are in file 34). EV13 with its section 18, at this record's writing (after the runs): `5d57bc3df56a41d8b14882811a67cc1689bce5af8fc12f43fb24dcdc88355dfb`. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1, 3, 4 and 5: one throwaway PostgreSQL 16.15 cluster per run, unix socket only (in `…/scratchpad/m5s`, short enough for the 107-byte socket limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, `12_stop.txt` and `32_breaks_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: M09-02's `setup.sql` unchanged (`…/scratchpad/m0903_run/setup.sql`). The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `4f01115`; EV13 with Revisions 1 and 2, its corrections 15 to 17, and its section 18 (for M09-05's checker) |
| Input | The seventeen migrations (`main`'s sixteen and M09-05); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `tests/C02/W-C02-07/job/` and T-W14-FN's, run in place; the producer's self-check; fourteen break copies of M09-05 made outside the repository (`…/scratchpad/m0905_brk/`, by `brk.py`); three merged break patches of `tests/C02/W-C02-07/breaks/` applied in place on the throwaway cluster (B-DM07-1, B-5B-2, B-CONC-1); a concurrency probe of the producer's own (`conc.sh`, `coord.sql`, `worker.sql`, `conc_setup.sql`) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m05_offline_01_init_setup.txt` to `…_34_git_hashes.txt`, written directly by `…/scratchpad/m0905_run/rerun.sh` (01 to 12), `brk.sh` (13 to 32) and `final.sh` (33, 34). Every file but `34` passed through `scrub.py`. That filter reads the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time and replaces each claim-format and each environment-format string with a fixed label of its own. Each file ends `claim-format strings replaced 0; environment-format strings replaced 0` (33 of 33). File 33 scans files 01 to 32 again with the same finders: `32 files; claim-format 0; environment-format 0`. Files 11 and 32 scan the cluster's server log: `480 lines; claim-format 0; environment-format 0`. File 34 holds hashes and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09), the break copies (14 to 27) and the concurrency probe (30, 31) are the producer's own; the three merged break patches (28, 29, 31) are the test designer's |

### 6.1 What was built, object by object

All in M09-05, in this order: the five functions of EV13 2.4, and their grants. No table, type or `devos_private` function is added. M09-01 to M09-04 are not changed. Their helpers are called: `caller_role_class`, `token_hash`, `write_event`, `reject`, `check_claim`, `ready_value` and `is_installation_mission`.

**The form every function has** is M09-03's and M09-04's (4.1, 5.1):
- the derivation first;
- the read block with steps (b) to (f). A decided refusal goes through `v_code`, `v_reason` and `P0D01`. Any other error is `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`;
- the write block, where an error is `write_failed`, but `P0D02`;
- one per-call row by `reject` after a refusal;
- fixed reasons.

O (`08_catalog.txt`): each of the five has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, ACL `{postgres=X/postgres,anon=X/postgres}`.

**Parameters.** The names are those of EV13 2.4 and README 8.1, so named calls bind (`claim(work_id, declared_session_id)`, `heartbeat(claim_token)`, `release(claim_token)`, `revoke_claim(assignment_id, reason)`). The bodies read them through `ALIAS FOR $n` (M09-05:133-134, :334, :413, :496-497), never as `<function>.<parameter>`. Reason: six merged break patches rename one of these functions and wrap it (B-DM07-1, B-N08-4, B-N17-1, B-6RG-1, B-6RG-2, B-EXF-1). A body that names its parameter through the function's name stops resolving it once the function is renamed: SQLSTATE 42P01, so every call would answer `could_not_check`. That was observed on a first form of this file under B-DM07-1, then fixed. It is a trial run, not filed; 6.5 gives the filed run.

**The claim token** (W9 point 4; EV3 1.7; `shared/token_format.md` section 2).
- **Where it is made.** In `claim`'s write block (M09-05:290-292): the claim marker, written in two pieces as M09-01 writes the environment marker, and `translate(rtrim(encode(extensions.gen_random_bytes(32), 'base64'), '='), '+/', '-_')`, 43 URL-safe characters of 32 random bytes. This is the environment token's generator.
- **Where it is hashed.** At once, by `devos_private.token_hash` (the one hash rule of both kinds, `encode(sha256(convert_to(…, 'UTF8')), 'hex')`). Only the hash goes into `assignment.claim_token_hash`.
- **What returns it.** Only `claim`'s answer (M09-05:313). The variables holding the token and the hash are cleared after use (`v_hash` at once, `v_token` after the answer is built, or on a refusal).
- **Who reads it back.** `heartbeat` and `release` take it as their parameter and hand it to `check_claim`, which hashes it. No function returns it. No event payload, refusal row, reason, error or notice holds the token or its hash.

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.ready_works()` (M09-05:50) | Roles: `devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum`. `devos_sinav`: `{"status": "ok", "works": []}`, read from nothing (M09-05:80). Otherwise the work items for which `ready_value` is true and whose Mission is the installation's for `devos_kurulum`, or not the installation's for the others (M09-05:95). A Mission with no creation event: not listed. Rows `{id, work_id, revision, scope, purpose, impact_class}` of the current revision, in creation order. An unreadable input: `could_not_check`. Comment `devos:read …`, VOLATILE, no write block | 2.4's row with C-M05 (18 (1)); EV-C02-008 1.2 and 5.1 (c) bound 3; B 3.3 (B:132); B principle 6; DM-06, DM-36 |
| `devos_api.claim(work_id uuid, declared_session_id text default null)` (M09-05:125) | Roles: the four. Order: `missing_field`; `exam_subject` for `devos_sinav` (M09-05:180); the work item `for update` (M09-05:187), `not_found`; its current revision; ownership (`not_owner`, or `could_not_check` without a creation event); the claims `for update` (M09-05:226), partial `could_not_check`, live `already_claimed` (M09-05:238); readiness, `not_ready` (M09-05:251) or `could_not_check`; the epoch `for share` (M09-05:257). Writes: lapsed claims `expired` with `claim_expired` (origin `rule`, M09-05:283); the Assignment (next generation, current revision, global epoch, lease now() + 30 minutes, the caller's class, the declared session, the hash); `claimed` (M09-05:298). Answer `id`, `assignment_id`, `claim_token`, `generation`, `lease_expires_at`. Refusal rows carry `target_ref` `work_id` and the declared session | 2.4's row with C-M05 (18 (2)); B 3.5 (B:150-160), principle 8; DM-01, DM-06, DM-07, DM-31; EV-C02-008 1.2, 5.1 (c) bound 3; EV3 1.7, 4.3 |
| `devos_api.heartbeat(claim_token text)` (M09-05:326) | Roles: the four. `check_claim(token, NULL, class, true)` (the work item and the claim `for update`): `claim_missing`, `claim_unknown`, `claim_not_active` (also a cancelled work item), `claim_expired`, `claim_generation`, `claim_epoch`, `claim_class`, or `could_not_check`. Writes the lease now() + 30 minutes, `last_heartbeat_at` now(), and `heartbeat`. Answer `id`, `lease_expires_at` | 2.4's row; B 3.5; DM-07; EV3 4.3 (S8 line 2) |
| `devos_api.release(claim_token text)` (M09-05:405) | As `heartbeat`'s check. Writes the status `released` and `released`. A second call: `claim_not_active`, nothing written. Answer `id` | 2.4's row; B 3.5; DM-01 (release locks the work item); EV13 1 item 10 |
| `devos_api.revoke_claim(assignment_id uuid, reason text)` (M09-05:488) | Role: `devos_denetim` only, the literal `array['devos_denetim']::devos_private.role_class[]`. `assignment_id` or `reason` NULL: `missing_field` (M09-05:529). The claim (`not_found`); its work item `for update` (M09-05:545), then the claim `for update` (M09-05:551); partial: `could_not_check`; `revoked`: the exact repeat; released or expired, or active with its lease run out (M09-05:569): `claim_not_active`. Writes the status `revoked` and `claim_revoked` (payload with the reason). Refusal rows carry `target_ref` `assignment_id`. Answer `id` | 2.4's row with C-M05 (18 (3)); B 3.5 (B:157); DM-29, DM-01, DM-06 |
| Grants (M09-05:611-636) | `revoke all … from public` and from the four API roles where they exist, on all five; `grant execute … to anon` on all five; no type, no private function | 1 item 13; T-W08-PRIV's constraint |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the twenty `devos_api` functions.
- **Types.** No `devos_private` type has PUBLIC USAGE.
- **The literals**, as the break patches read them: `ready_works`, `claim`, `heartbeat` and `release` hold `array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']`; `revoke_claim` holds `array['devos_denetim']`, the form B-5B-2 widens.
- **The unqualified-name scan.** No hit in M09-05's five functions; its four hits are section 3.1's.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** `deployment_drift`, `read_decision`, `ready_works` and `token_role_class` carry it.
- **The exam table's name.** It occurs in none of the five, so T-W07-N08's finder needs no exemption for them (EV-C02-008 5.1, "Not on the list"; self-check `TX-no-exam-table`; file 34: `M09-05 lines naming the exam table: 0`).

### 6.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. No merged test is changed. EV13 section 18 (C-M05) states items 1 to 4 in the record itself.
1. **`ready_works`' rows carry `id` beside `work_id`** (EV13 18 (1)). 2.4 names `work_id`, and T-W07-6RG and B-6RG-2 read and write `id`. Both keys hold the same uuid, as `claim`'s `id` and `assignment_id` do. Also chosen:
   - an item whose Mission has no creation event is not listed;
   - the rows are in creation order;
   - an unknown readiness leaves the item off the list rather than answering `could_not_check`, which is kept for an input that cannot be read.
2. **`claim`'s order** (EV13 18 (2)):
   - `exam_subject` comes before any read or lock, so `devos_sinav` gets one code on every id. EV-C02-008 5.1 (c) bound 3; N08-s4 wants one code on three kinds of item.
   - Partial claims come before `already_claimed`: 6RG-l1 and -l3 want `could_not_check`.
   - `already_claimed` comes before readiness.
   - Unknown readiness is `could_not_check`, not `not_ready`: item 7 (ii), and 3.5 item 4.
   - A Mission without a creation event is `could_not_check`, as Rule O reads it (EV13 17 (5)).
3. **`revoke_claim`** (EV13 18 (3)):
   - `reason` is required (B 3.5, "with its reason"; DM-29 (a)). An empty string is accepted.
   - An active claim whose lease has run out is `claim_not_active` (DM-06 (a)).
   - The work item is locked before the claim (DM-01).
   - The claim's epoch is not checked, so a claim of an earlier epoch can be revoked.
   - The form check (`missing_field`) comes before the exact repeat. So an already revoked claim named without a reason is `missing_field`, not the repeat. A repeat that sends its reason again is the repeat.
4. **A claim of an earlier epoch holds its work item** (EV13 18 (4); stated, not changed). After an epoch change, the claim produces no effect, cannot be extended or released, and still makes its work item `already_claimed` until it lapses (at most 30 minutes) or `devos_denetim` revokes it. M09-02's `ready_value` counts it as live, and M09-05 does not change M09-02. Self-check: `HB-epoch`, `RL-epoch`, `CL-earlier-epoch-still-holds`, `RC-earlier-epoch`, `CL-new-epoch`.
5. **The events** (EV13 1 item 10; DM-31):
   - Five events, all on aggregate `assignment` with `aggregate_revision` NULL, since an Assignment has no revisions: `claimed`, `claim_expired` (origin `rule`, the caller's class), `heartbeat`, `released` and `claim_revoked`.
   - Payloads: the work item, the generation, the lease, the epoch or the status as each writes them, and `claim_revoked`'s reason. Never the token or its hash.
   - `declared_session_id` goes to `claim`'s events and refusal rows. The other four take no declared session (no `p`).
6. **Parameters read through `ALIAS FOR $n`** (6.1), so that the merged patches that rename these functions leave the renamed body working. This is not a departure from EV13; it is stated because M09-04 does otherwise (6.6 item 2).
7. **Forms the record leaves open (chosen):**
   - Answers: `claim` as 6.1; `heartbeat` `id` and `lease_expires_at`; `release` and `revoke_claim` `id`; `ready_works` `works`.
   - Refusal rows: `claim` names `work_id`; `revoke_claim` `assignment_id`; `heartbeat` and `release` none, since a refused claim check names no claim.
   - Reasons: `already_claimed`'s reason names no class (CHK-C02-025 F7, as T-W07-ROC:94 cites it).
   - Locks: `claim` takes the work item and the claims `for update`, and the epoch `for share`. `heartbeat` and `release` take them through `check_claim` with `p_for_update`. `revoke_claim` takes the work item and the claim `for update`. `ready_works` takes no lock.
   - The lease: `now()` + 30 minutes, the transaction's time, as `check_claim` compares it.

Not departures, for the checker:
- `claim` checks no registration (EV3 4.4; section 6's row "Registration before C04"; W9 point 4's S8 line 3 is C04's).
- `heartbeat` and `release` refuse a claim on a cancelled work item `claim_not_active`. That is `check_claim`'s rule (3.3 item 2), not M09-05's.
- `release` does not change the work item's `execution` (N-279 (1)).

### 6.3 How W-C02-09's points are served by M09-05

- **Point 1.** A versioned file later than `20261018230001`, plain SQL, no `psql` meta-command, no backslash (O, `34_git_hashes.txt`: `backslashes in M09-05: 0`). Decisions followed, with the object:
  - the claim expiry computed, no job: `claim`, `ready_works` and `check_claim` compare the lease with `now()`, and `claim` marks a lapsed claim `expired` (`CL-lapsed`, `-marked-expired`, `-event`; `RW-cal-lists-ready`);
  - single-claim revocation: `revoke_claim`, `devos_denetim` only (`RC-*`; 5B row R05);
  - S8 line 2: `heartbeat` and `release` refuse another class (`HB-class-*`, `RL-class-kurulum`);
  - registration before C04: not built (6.2);
  - the rejected-attempt record's per-call form (`{"rejected": 1}` deltas);
  - the events the database makes itself: `claim_expired`, origin `rule`, the caller's class;
  - F06's list: `ready_works` carries the read marker; the other four are state-changing (`F06-list | ok | 20 devos_api functions (4 marked devos:read)`);
  - concurrency: DM-01's lock order (6.1; the probe, 6.5).
  - Offline, `deployment_drift` reports `no_difference`, 17 of 17 (runs 04 and 10).
- **Point 2.** Twenty of the 55 `devos_api` functions now exist (five here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (6.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the five refuses a call with no token before any other check (`F06-refused:<fn>`, all four state-changing ones `ok`; `F06-read-refused:ready_works` `ok`; `*-no-token`). Each refuses a class not on its list with one per-call row: 5B rows R04 (`claim`, `heartbeat`, `release`), R05 (`revoke_claim`) and R20 (`ready_works`), their 30 cells `ok`; 6TK's `6TK-ka1` now runs on `revoke_claim`, `ok`.
  - Fifth bullet. A declared session changes nothing: it is written as declared (`CL-row`, `CL-event`) and read by no check.
  - Sixth bullet. A claim taken in an earlier epoch produces no effect: `HB-epoch`, `RL-epoch` (`claim_epoch`); T-W07-DM07's `DM07-epoch` `ok`. The effects' own refusal is M09-07's and M09-08's.
- **Point 4.**
  - "`claim(work_id)` returns the claim token to that call only, and the database keeps only its hash (looked for by value)":
    - `CL-token-form`: the shape, checked at run time, never printed.
    - `CL-hash-only`: the stored hash is the whole token's SHA-256.
    - `CL-token-in-no-table`: no table of any schema holds the token's value; `auth.users`, not readable as owner, is named apart (`CL-tables-not-searched`).
    - `CL-hash-in-no-other-table`.
    - `CL-event`: no token or hash in the payload.
    - `TK-values`: ten claim tokens, each in no table, its hash only in `assignment`, neither in an event, a refusal row or an answer's reason.
    - `HB-extended` and `RL-state`: no token in the other answers.
    - The token-format counts of events and refusal rows are 0.
    - Break b07 (the token put into `claimed`'s payload) turns `CL-token-in-no-table` and `TK-values` red.
  - The effects' refusals (another session's claim, no claim token, a fake session ID, released, expired or revoked, earlier generation or epoch) need an effect (M09-07, M09-08). Here they are shown on `heartbeat` and `release` only: `HB-null`, `-empty`, `-unknown`, `-released`, `-revoked`, `-oldgen`, `-lapsed`, `-epoch`, `-class-*`; `RL-*`; T-W07-DM07 `PASS (8/8)`.
  - S8 line 2: `HB-class-denetim`, `HB-class-sinav`, `RL-class-kurulum` (`claim_class`); `DM07-class` `ok`.
  - Expiry: a claim past its lease produces no effect (`HB-lapsed`, `RL-lapsed`: `claim_expired`; `DM07-lapsed` `ok`), and its work item can be claimed again (`CL-lapsed`: generation 2, the old claim `expired`).
  - The lease (30 minutes): `CL-row`, `HB-extended`, `DM07-len` and `DM07-pos` `ok`. Its parameters are EV13 section 7's; M09-05 adds none but the epoch case of 6.2 item 4.
- **Point 5.**
  - Each state-changing function writes its event in the same transaction, with the token's class (`CL-event`: `this transaction`; `HB-event`, `RL-state`, `RC-state`).
  - An exact repeat writes nothing: `RC-repeat` (`ok repeat`, `{}`). A second `claim` is `already_claimed`, and a second `release` `claim_not_active` (EV13 1 item 10).
  - A failure planted mid-transaction leaves no half state and no orphan event: `CL-write-failed` on `assignment`, `CL-write-event-failed` on `event`, `HB-write-failed`, `RC-write-failed`. In each, only the refusal row is added.
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass:
  - `CL-no-creation-event`, `-partial-lease`, `-partial-generation`, `-lease-unreadable` (42703), `-relation-unreadable` (42P01), `-assignment-unreadable` (42501), `-epoch-missing`, `-dependency-unknown`, `-write-P0D02`;
  - `HB-assignment-unreadable` (42501); `RC-partial-lease`;
  - `RW-relation-unreadable`, `RW-events-unreadable`;
  - `RW-lease-null`: a claim whose lease is NULL leaves its item off the list.
  - These are the forms 6RG-e4, -g3, -l1 to -l3 and -l5 plant; 6RG itself does not run yet (6.4).
  - "A readiness group with an unknown member is not ready": `CL-dependency-unknown` and `RW-cal-not-listed` (W_depU).
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the five, run in place (run 06):
    - **T-W07-DM07 `PASS (8/8)`**, the first merged file to pass whole on these functions;
    - 5B: the 30 cells of R04, R05 and R20 `ok`; `COULD NOT CHECK (12 of 126 …)` for rows whose functions are not built; none `bad`;
    - 6TK `PASS (32/32)`;
    - DM34 `PASS (10/10)` again;
    - F06: `F06-refused:claim`, `-heartbeat`, `-release`, `-revoke_claim`, `F06-read-accepted:ready_works` and `F06-read-refused:ready_works` `ok`. Five cases of the four state-changing functions are `could_not_check` (6.4). In all, `COULD NOT CHECK (18 of 55 …)`, none `bad`.
  - Their copies are a later pull request's (R:247; EV13 section 11).

### 6.4 What M09-05 does not yet serve

- **T-W07-F06's cases for `claim`, `heartbeat`, `release` and `revoke_claim`.** These are `F06-event:claim`, `-heartbeat`, `-release`, `-revoke_claim` and `F06-repeat:claim`: `could_not_check`.
  - `claim`'s recipe, and the fixture claim of F06's claim-bearing loop (`job/w07_f06_state_change_event.sql`, the loop over `heartbeat`, `release`, `revoke_claim`, `register_artifact`, `prepare_operation`, `record_attempt`, `record_observation`, `operation_state`), plant their work items with `pg_temp.w07_plant`. Those Missions have no creation event.
  - So `claim` answers `ownership: whether the work item lies under the installation's Mission is missing or partial`, and every fixture of that loop fails: "no recipe: its fixture could not be made".
  - This is N-285 item (1)'s cause, reaching M09-05 (EV13 18 (5)). The same loop will keep M09-07's and M09-08's F06 cases `could_not_check` until the test designer revises it.
- **The staged files that call these functions but need a later function stop at their `-pre` line** (run 06):
  - T-W07-N17 needs `register_artifact`.
  - T-W07-5C needs `register_artifact` and `prepare_operation`.
  - T-W07-6RG needs `relate`, `register_artifact` and `prepare_operation`.
  - T-W07-F01, F05, F07 and F08 need `prepare_operation`, `register_artifact`, `relate`, `record_attempt` or `record_observation`.
  - T-W07-ROC and T-W07-N08 (exam fact) need `relate`, `record_eval_run` and others.
  - Group C's files need `relate`, `record_finding`, `open_review` or W-C02-10's tables.
  - T-W07-CONC (`job/w07_conc_claim_and_cycle.py`) was not run. Its own check of required functions lists `relate` and `register_artifact` (its line 90), so it gives COULD NOT CHECK. 6.5's probe repeats its CONC-claim form on `claim` alone.
  - So W9 point 4's effect refusals, N17, 5C, CONC and F08 (c) are "could not check", not counted.
- **The merged breaks of these functions** (W-C02-13's):
  - **B-N08-4, B-EXF-1, B-6RG-1, B-6RG-2 and B-N17-1** cannot be shown until their tests run.
  - **B-DM07-1** was applied here (6.5, run 28): three of its four red cases turn red. The fourth, `DM07-oldgen`, raises 22P02, because the patch writes the status `w07_set_aside`, which `devos_private.assignment_status` does not hold. **B-5C-1** writes the same value. So both patches cannot show that case on any build of the merged schema. This is for the test designer (EV13 18 (5)).
  - **B-CONC-1** was applied with the probe (run 31). It does not turn the probe's CONC-claim form red: the unique constraint on (`work_ref`, `generation`), which the patch leaves, still allows one Assignment. So the break is "not shown" on this schema, for the test designer.
  - **B-5B-2** turns its two named cases red (run 29).

### 6.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0905` at `4f01115`, with M09-05 untracked. The main run started 2026-10-18T23:50:02Z and ended 23:50:07Z, on one cluster (`…/scratchpad/m0905_run/rerun.sh`). The break runs started 23:50:55Z and ended 23:51:41Z, on a second cluster (`…/scratchpad/m0905_run/brk.sh`).
- **A discarded run.** A first run of `brk.sh` on the same bytes stopped in its break maker, because b05's anchor still named the text before the `ALIAS` change (`b05_claim_lapsed_not_expired: NOT MADE`). Its files 13 to 22, 33 and 34 were deleted, and `brk.sh` and `final.sh` were run again. The main run's files 01 to 12 are of the same bytes and were kept.
- **The drivers.** `run.sh` and `drive.py` are `…/m0904_run/`'s, changed only in their paths (the clone `prd12`, the cluster under `…/m0905_run/pg`, the socket in `…/scratchpad/m5s`) and one printed word. `setup.sql` and `catalog.sql` are `…/m0903_run/`'s, unchanged. `scrub.py` and `scan.py` are new. They read the two finder patterns from `tests/C02/W-C02-07/shared/scan_patterns.json` at run time, so no driver holds a marker. The scrub replaces each claim-format string with `[claim-format string replaced]` and each environment-format string with a label of its own, and counts each format.
- **Trial runs.** Two trial runs of the same drivers into `…/m0905_run/trial1` and `trial2`, and a diagnosis of B-DM07-1 (`dm07probe.sh`), came before. They are not filed. The first trial's self-check had three red cases, all from `auth.users`, the stand-in the owner cannot read, being counted as "holding". It was fixed by naming such tables apart (`CL-tables-not-searched`). The diagnosis showed the rename fault of 6.1. Both changes came before the filed run.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the sixteen migrations before M09-05, each `[exit 0]` with its history row (32 `[exit 0]` lines).
- **03, M09-05:** `CREATE FUNCTION`, `COMMENT`, `CREATE FUNCTION` ×4, `REVOKE` ×5, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 17, "migrations_expected": 17`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result):
  - `W07_DM07_HEARTBEAT PASS (8/8)`;
  - `W07_6TK_TOKEN_REASONS PASS (32/32)`, with `6TK-ka1 | ok | a verified working token on revoke_claim: a role refusal under devos_calisma, not a token code; code role_class_not_permitted`;
  - `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (12 of 126 could not be checked)`, none `bad`, for example `5B-R04-claim-sin | ok | v cell: … code exam_subject` and `5B-R05-revoke_claim-cal | ok | x cell: … code role_class_not_permitted`;
  - `W07_F06_STATE_CHANGE_EVENT COULD NOT CHECK (18 of 55 could not be checked)`, none `bad`; `F06-list | ok | 20 devos_api functions (4 marked devos:read) …`; `F06-event:claim | could_not_check | the recipe's call was not accepted … "ownership: whether the work item lies under the installation's Mission is missing or partial"`;
  - `W07_DM34_MISSION_SCOPE PASS (10/10)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`;
  - `W07_DM19B_BURST_COUNT COULD NOT CHECK (6 of 12 …)`, `W07_N04_SELF_APPROVAL COULD NOT CHECK (4 of 4 …)`;
  - `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, …)`: W-C02-10's, as in sections 4.5 and 5.5; it calls no M09-05 function;
  - every other file `COULD NOT CHECK` on its `-pre` line (6.4); run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 6.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 M09-05; one transaction rolled back): `M0905_FUNCTIONS PASS (116/116)`.
  - The cases: 17 for `ready_works`, 52 for `claim`, 18 for `heartbeat`, 8 for `release`, 17 for `revoke_claim` and 4 for the token and the text.
  - Each compares the answer's code and the change of six tables; the state cases read the row after.
  - Among them: `CL-sin-random-id`: `exam_subject`. `CL-calisma-inside`, `-denetim-inside`, `-kurulum-outside`: `not_owner`. `CL-partial-generation`: `could_not_check`. `CL-lapsed`: `ok`, `{"event": 2, "assignment": 1}`. `HB-unknown`: `claim_unknown`. `RC-null-reason`: `missing_field`. `RC-lapsed`: `claim_not_active`. `RC-repeat`: `ok repeat`, `{}`. `CL-earlier-epoch-still-holds`: `already_claimed`. `CL-new-epoch-value`: true.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `assignment`.
- **11:** the server log, `480 lines; claim-format 0; environment-format 0`. **12:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **13 to 27, the break copies** (`brk.py`: 14 `made (one replacement in devos_api.<fn>)`). Each copy was applied in place of M09-05 (`[apply exit 0]`). Then the self-check and the staged DM07, F06, 5B and 6TK were run, and its five functions were dropped (`[drop exit 0]`):
  - **b01**, `already_claimed` removed: red `CL-again`, `-again-other-class`, `-again-reason-names-no-class`, `CL-earlier-epoch-still-holds` (`not_ready`).
  - **b02**, `exam_subject` removed: red `CL-sin`, `-sin-random-id`, `-sin-installation`, and two after them.
  - **b03**, `devos_kurulum`'s ownership clause removed: red `CL-kurulum-outside` and two after it.
  - **b04**, `not_ready` removed: red `CL-cancelled`, `-finished`, `-mission-closed`, `-dependency-false`.
  - **b05**, a lapsed claim not marked expired: red `CL-lapsed` (the insert hits `assignment_one_active_claim`: `write_failed`), `-marked-expired`, `-event`, `TK-values`.
  - **b06**, the partial-claims check removed: red `CL-partial-generation`.
  - **b07**, the token put into `claimed`'s payload: red `CL-token-in-no-table`, `TK-values`.
  - **b08**, unknown readiness let through: red `CL-dependency-unknown`.
  - **b09**, `heartbeat`'s extension removed: red `HB-extended`, `HB-write-failed`; **DM07 `FAIL (1 bad, …)`**, `DM07-pos | bad | … lease not extended to 30 minutes`.
  - **b10**, `release`'s status not written: red `RL-state`, `RL-again`, `HB-released`, `CL-after-release`, and four after them; **DM07 `FAIL (1 bad, 1 could not check, …)`**, `DM07-released | bad`.
  - **b11**, `revoke_claim`'s literal widened to `devos_calisma` (B-5B-2's form): red `RC-role-calisma`, `TX-revoke-literal`, and five after them; **5B `FAIL (1 bad, …)`**, `5B-R05-revoke_claim-cal | bad`; **6TK `FAIL (1 bad, …)`**, `6TK-ka1 | bad`.
  - **b12**, a lapsed claim revoked: red `RC-lapsed`.
  - **b13**, `ready_works` listing for `devos_sinav`: red `RW-sin-empty`.
  - **b14**, `ready_works`' ownership filter removed: red `RW-cal-not-listed`, `RW-kur-only-installation`, `RW-den-as-cal`, `RW-events-unreadable`.
  - So each check turns red when its rule is removed. DM07 caught b09 and b10; 5B and 6TK caught b11. The self-check alone caught the other eleven, because no merged test runs those rules yet (6.4).
- **28 and 29, merged break patches on M09-05 itself** (`[M09-05 apply exit 0]`, `[patch exit 0]`, M09-05 dropped after each):
  - **B-DM07-1:** `W07_DM07_HEARTBEAT FAIL (3 bad, 1 could not check, of 8)`: `DM07-lapsed`, `-released`, `-revoked` `bad`; `DM07-oldgen | could_not_check | … raised 22P02 invalid input value for enum devos_private.assignment_status: "w07_set_aside"` (6.4); `DM07-epoch`, `-class` green, as the patch expects.
  - **B-5B-2:** `5B-R05-revoke_claim-cal | bad`, `W07_5B_AUTHORIZATION_MATRIX FAIL (1 bad, …)`; `6TK-ka1 | bad`, `W07_6TK_TOKEN_REASONS FAIL (1 bad, …)`, the patch's two named cases.
- **30 and 31, the concurrency probe.** 20 runs. In each, 8 connections each issue a synthetic `devos_calisma` token inside their transaction, wait at one advisory-lock barrier, and call `claim` on one fresh work item. Each prints only its answer's status and code.
  - **30, unpatched:** in every run `8 connections waiting; answers: 1 ok ;7 refused already_claimed; …; 1 assignments, 1 active` (20 of 20).
  - **31, with B-CONC-1:** `claim text holds for update: false`; `unique indexes left on assignment: … assignment_work_ref_generation_key`. In every run, `1 ok`, the others `write_failed`, `not_ready` or `already_claimed`, and `1 assignments, 1 active` (20 of 20; `write_failed` in 20 runs).
  - So the lock serializes the claims, and without it the generation's unique constraint still keeps one claim (6.4).
- **32:** the server log, `480 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **33:** files 01 to 32 scanned with the finders of `scan_patterns.json`: `32 files; claim-format 0; environment-format 0`.
- **34:** the hashes in the envelope; `backslashes in M09-05: 0`; `M09-05 lines naming the exam table: 0`; `M09-05 strings found by either token finder: … claim-format 0; environment-format 0`; `M09-05 lines holding either marker whole: 0`; `git status --porcelain`: M09-05 and the raw files 01 to 34 untracked, before EV13 section 18 and this section were written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 6.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-F06's planted work items for `claim` and its claim-bearing loop sit under Missions with no creation event (6.4; N-285 item (1)'s cause). Until they get one, F06 cannot pass W9 point 8 for `claim`, `heartbeat`, `release` and `revoke_claim`, and later for the effects.
   - B-DM07-1 and B-5C-1 write the status `w07_set_aside`, which `assignment_status` does not hold, so `DM07-oldgen` (and the cases of B-5C-1 that set a claim aside) raise 22P02 under the patch.
   - B-CONC-1 leaves the unique constraint on (`work_ref`, `generation`), so CONC-claim cannot turn red on the merged schema (run 31).
2. **For the executor** (reported, not done):
   - **M09-04's state functions name their parameters through the function's name** (`cancel_work.work_id`, `mark_stale.work_id`, `reopen_for_review.work_id`: ten places in `20261018230001_w09_work_effort.sql`, for example line 789).
     - B-ROC-1 and B-ROC-2 rename `cancel_work` (`tests/C02/W-C02-07/breaks/B-ROC-1_rule_o_reads_exam_link.sql:21`, `B-ROC-2_rule_c_removed.sql:43`).
     - So under those patches the renamed body cannot resolve `cancel_work.work_id` (42P01, as observed for `heartbeat` in 6.1), and ROC's `cancel_work` cases become `could_not_check`, not the patches' red cases **[Inf: the mechanism observed on M09-05's first form; not run on M09-04]**.
     - The fix is M09-04's (a migration through the migration path), or the patches'.
   - **N-281** must be met before the first real-path `claim` (the note's own deadline; 6 above).
   - **A claim of an earlier epoch holds its work item for up to 30 minutes** (6.2 item 4). Whether readiness should leave such a claim out is a change of 2.4 and of M09-02's `ready_value`.
3. **For the checker of verdict (i):**
   - EV13 section 18 with its *[C-M05]* marks;
   - 6.2's departures, chiefly 1 to 4;
   - the token's path in 6.1 and point 4's look by value (6.3);
   - the self-check, the break copies and the probe, which are the producer's own.
4. **For the producers of M09-07 and M09-08:**
   - `check_claim` with the effect's work item, then `ready_value(work, assignment_id)` (3.5 item 4).
   - A claim's token is never put into an effect's event or refusal row.
   - The parameters are read through `ALIAS FOR $n` if a merged patch renames the function (B-5C-1, B-6RG-1, B-N17-1, B-F08-2, B-F08-3 rename `register_artifact` and `prepare_operation`).
5. **Residuals:**
   - The claim token travels as a parameter of `heartbeat` and `release` (EV3 1.7). A direct SQL caller's statement text could carry it into a server log with statement logging on. Over the Data API it is in the request body. `devos`'s log settings are not read here (as N-280's annotation leaves `log_statement` for its first program run).
   - `ready_works` calls `is_installation_mission` once per work item, which reads every Mission's events. It is a cost, not a rule, at C02's sizes.

## 7. M09-06: Relation

The producer's record of `supabase/migrations/20261019010001_w09_relations.sql` (M09-06). It was written on branch `claude/c02-w09-m0906` at `c8449e41e32d0f76a5037158f6bc3c4e0dc7406f`: `main` `4f01115` with M09-01 to M09-04, plus M09-05 (`20261018235501_w09_claims.sql`) from its pull request, under review. M09-06 builds on M09-05 and does not change it. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at that commit, with EV13's correction section 19 added by the same producer. M09-06 means the file above, and M09-06:n a line of it. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 19 first.** EV13 gained "19. Correction, 2026-10-19 (M09-06)", with marks *[C-M06]* in 2.5's rows `relate`, `retract_relation`, `affected_entities` and `explain_paths`. It states the forms 7.2 lists, and takes the stricter side in one reading (7.2 item 2). M09-06's checker judges it.
- **The note items that bind M09-06's commit, checked on the branch before the SQL** (`plan/work/C02.md`):
  - **Binding M09-06's commit: none open and unmet.**
  - N-279 (15), CHK-C02-077 K1: "before the first commit of the migrations that build `revise_work` and `retract_relation`". **Met.** EV13 R2-6 took option (a). The test designer moved `ROC-x-o-mission-unreadable`'s revoke to `devos_private.mission_revision` (`job/w07_roc_ownership_and_claim_class.sql`, `pg_temp.roc_x_access`; CHK-C02-089 finding 5 read it there). CHK-C02-081 judged it.
  - N-279 (12), its `group_mode` part (6RG, F08 and CONC send `group_mode` without `group_id`): "before the first commit of the migration that builds the function concerned". **Met.** EV13 R2-5 decided it: `group_mode` alone makes a group of its own. "No test changes" (EV13:126). M09-06 builds it (7.1).
  - N-279 (10), the rules Revision 1 added: R1-2 (a `relate` end that names no record is `could_not_check`) and R1-3 (`exam_record` for `devos_sinav`). **Met.** CHK-C02-077 and CHK-C02-081 judged them.
  - N-279 (5), CHK-C02-076 C2 (`relate`'s refusal, with its code, for a `devos_sinav` call whose end is an EvalRun). **Met** by R1-3, before the test designer's revision merged.
  - N-288 (parameters named through the function's name). It binds M09-06's form, not its commit. **Met:** every body reads its parameters through `ALIAS FOR $n` (7.1).
  - EV-C02-014 3.5 item 4 and 5.6 item 4, for this producer. "Call `hard_dependency_cycle` before locking the work item's row; map a helper's NULL to `could_not_check`" is **met** (M09-06:236 before :300; M09-06:409-415). "`relate` and `retract_relation` check Rule O and Rule C with the same reads, written inline" is **met** (7.1).
  - N-279 (2): Relation ends that are Events, for `transfer_relation` (M09-11), before W-C02-14's first run. Not M09-06's: `relate`'s ends are uuids, and an Event's bigint id is no uuid (`invalid_field`).
  - N-281, its L-369 annotation: no real-path `claim` until it is met. M09-06 makes no claim and returns no token. Its runs are offline.
  - N-279 (1), (17), (18), (19), (21), N-280, N-282, N-283 (6) and (7), N-284 to N-287 and N-289: their deadlines are C03's work list, M09-08, M09-12, each Group B file's first result or copy, W-C02-10's sampling call, the first `.py` copy, the first migration adding a role class, a test file's first result or copy, verdict (ii), and M09-09. None falls at M09-06's commit. N-283 (7) and N-285 (1) bear on tests that call M09-06's functions; 7.4 says what they mean here.
- **Appendix B principle 3** binds no function here. Relation has no revisions; `retract_relation` sets state (7.2 item 2).

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0906` at `c8449e4`, clean before this work. The runs were made with M09-06, EV13's section 19 and the raw files uncommitted (O, `49_git_hashes.txt`). Bytes run: M09-06 `f13b7f00df8e32ffe939851dbb60f2c22bfb0ad690c2e1933690e58c335dd0c3`; the self-check `…/scratchpad/m0906_run/fn_check.sql` `37919c13b2a5eca115c22f1b77ad407e2f72509ebf45400e3f8377cd40836dbb`; the break maker `…/scratchpad/m0906_run/brk.py` `03d88d11578258baa350ad98b40d11d539cd75632851a0c9203d69e79d60df3e` (the other drivers' hashes are in file 49). EV13 with its section 19, at this record's writing: `464e9ae3519a2525dbb62b00760bf20178381e3e6e71ed39509933b9c5f09606`. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 6: one throwaway PostgreSQL 16.15 cluster per run, unix socket only (in `…/scratchpad/m6s`, short enough for the 107-byte socket limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, `12_stop.txt` and `47_breaks_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: M09-02's `setup.sql`, a byte-identical copy (`fa2a9cfa…9783`). The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `c8449e4`; EV13 with Revisions 1 and 2, its corrections 15 to 18, and its section 19 (for M09-06's checker) |
| Input | The eighteen migrations (the branch's seventeen and M09-06); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `tests/C02/W-C02-07/job/` and T-W14-FN's, run in place; the producer's self-check; twenty break copies of M09-06 made outside the repository (`…/scratchpad/m0906_brk/`, by `brk.py`); eleven merged break patches of `tests/C02/W-C02-07/breaks/` applied in place on the throwaway cluster (B-REL-1, B-F04-1 to B-F04-9, B-K05-1), and B-CONC-2 with a concurrency probe of the producer's own (`conc.sh`, `coord.sql`, `worker.sql`, `conc_setup.sql`) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m06_offline_01_init_setup.txt` to `…_49_git_hashes.txt`, written directly by `…/scratchpad/m0906_run/rerun.sh` (01 to 12), `brk.sh` (13 to 47) and `final.sh` (48, 49). Every file but `49` passed through `scrub.py`, M09-05's filter, which reads the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time and replaces each claim-format and each environment-format string with a fixed label. Each file ends `claim-format strings replaced 0; environment-format strings replaced 0` (48 of 48). File 48 scans files 01 to 47 again with the same finders: `47 files; claim-format 0; environment-format 0`. Files 11 and 47 scan the cluster's server log: `466 lines; claim-format 0; environment-format 0` and `1278 lines; claim-format 0; environment-format 0`. File 49 holds hashes and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09), the break copies (14 to 33) and the concurrency probe (45, 46) are the producer's own; the merged break patches (34 to 44, 46) are the test designer's |

### 7.1 What was built, object by object

All in M09-06, in this order: the four functions of EV13 2.5, and their grants. No table, type or `devos_private` function is added. M09-01 to M09-05 are not changed. Their helpers are called: `caller_role_class`, `write_event`, `reject`, `hard_dependency_cycle` and `is_installation_mission`.

**The form every function has** is M09-03's to M09-05's (4.1, 5.1, 6.1):
- the derivation first;
- the read block with steps (b) to (f). A decided refusal goes through `v_code`, `v_reason` and `P0D01`. Any other error is `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`;
- for `relate` and `retract_relation`, the write block, where an error is `write_failed`, but `P0D02`; the two walks are reads and have none;
- one per-call row by `reject` after a refusal;
- fixed reasons.

O (`08_catalog.txt`): each of the four has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, ACL `{postgres=X/postgres,anon=X/postgres}`.

**Parameters.** The names are those of EV13 2.5 and README 8.1, so named calls bind: `relate(p)`, `retract_relation(relation_id, reason)`, `affected_entities(root, limits)`, `explain_paths(root, target, limits)`. The bodies read them through `ALIAS FOR $n` (M09-06:74, :482-483, :676-677, :864-866), never as `<function>.<parameter>` (N-288). Fourteen merged patches rename one of these functions and wrap it (B-F04-1 to B-F04-9, B-K05-1, B-N29-3, B-ROC-2, B-ROC-3, B-6RG-1), and B-REL-1 copies `relate` under a new name. Self-check `TX-alias` shows no body names a parameter so.

**Rule O and Rule C** (EV-C02-008 1.7.1; EV13 2.3, "What Rule O reads") are written inline in `relate` and `retract_relation`, with M09-04's reads and reasons:
- Rule O reads the work item's current `work_revision` row, the `mission_revision` it names, that Mission's events through `is_installation_mission`, and for `devos_sinav` the exam link. It never reads `devos_private.mission`.
- Rule C reads `devos_private.assignment`.
- The reasons name the rule, never the item's opener or the claimant's class (`RL-c-reason-names-no-class`).

**Relation ends and the walks' records** (EV13 19 (1), (3)). Fourteen families are looked up by one `union all` over their tables: Work, Mission, Decision, Finding and Artifact (with revisions), and Need, Relation, EffortPolicy, Assignment, Review, Verdict, Acceptance, Operation and Observation. EvalRun is read only when the caller's class is `devos_sinav`: M09-06:264-272 in `relate`, and the same branch in the root, target and walk checks. So for every other class the answer does not depend on the exam table, even when it cannot be read (`AE-eval-unreadable-cal`: `ok`, with `eval_run` revoked from the owner).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.relate(p jsonb)` (M09-06:66) | Roles `devos_calisma`, `devos_sinav`, `devos_kurulum`. The form, then `relation_rule` (M09-06:224-229). For a hard `depends_on`, `hard_dependency_cycle` (M09-06:236), whose advisory lock comes before any row lock. The ends: `from_ref` (its row `for update`, M09-06:300-313), then `to_ref`; `exam_record` for `devos_sinav` (M09-06:268); otherwise `could_not_check`, `<end>: the record could not be read`, the same text for a missing record, a missing or partial revision, or an exam record. Rule O when `from_ref` is a work item; Rule C when the relation is hard (M09-06:358-374). The group (M09-06:378-390). The exact repeat (M09-06:392-406). The cycle: `cycle` (M09-06:417) or `could_not_check`. Writes the Relation (`group_id` its own id when `group_mode` comes alone, M09-06:438-440) and `relation_created` (origin `call`, `aggregate_revision` NULL). Answer `{"status": "ok", "id"}` | 2.5's row with R1-2, R1-3, R2-5 and C-M06 (19 (1)); B 3.4; W9 point 6; DM-01; EV-C02-008 1.2, 1.7.1, 5.1 (b) |
| `devos_api.retract_relation(relation_id uuid, reason text)` (M09-06:474) | Roles as `relate`. `relation_id` NULL: `missing_field`. The relation (`not_found`); its work item `for update` (M09-06:534), then the relation `for update` (M09-06:537). Rule O: the creation event (none, or its type NULL: `could_not_check`, M09-06:545-556); transferred: `devos_kurulum` only (M09-06:558); then the work-item clauses when `from_ref` is a work item. Rule C for a hard relation from a work item. Already retracted: the exact repeat. Writes `validity` `retracted` and `relation_retracted` (payload `validity`, `previous_validity`, `reason`). Refusal rows carry `target_ref` `relation_id`. Answer `{"status": "ok", "id"}` | 2.5's row with C-M06 (19 (2)); EV-C02-008 1.7.1; section 4's row on Rule O for relations |
| `devos_api.affected_entities(root uuid, limits jsonb)` (M09-06:668) | Roles `devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_kurulum`. `limits` `max_depth` (5) and `max_records` (500). The root a record the caller may see, else `could_not_check`, `root: the record could not be read`. Breadth first along the edges of 19 (3): each record once (`distinct on`, M09-06:814-817), with the first path to it; `complete` false at a record limit (M09-06:818), at `max_depth` with an unwalked edge left, or when a record was hidden or missing or an edge partial. Answer `{"status": "ok", "records": [{"ref", "path"}], "complete"}`. Comment `devos:read …` | 2.5's row with C-M06 (19 (3)); B section 4 (Relation); Appendix C F04, K05; DM-35 as EV-C02-008 5.1 narrows it; DM-36 |
| `devos_api.explain_paths(root uuid, target uuid, limits jsonb)` (M09-06:856) | Roles as `affected_entities`. `limits` `max_depth` (5) and `max_paths` (20). Root and target checked as the root above; equal: `invalid_field`. The region within `max_depth`, breadth first, then a depth-first search through the records that can reach the target, for simple paths, stopping after `max_paths` + 1 paths or 20000 steps (M09-06:875). `complete` false as 19 (4) lists, among them any edge out of the last level (M09-06:993) and a path cut at `max_depth` (M09-06:1079). Answer `{"status": "ok", "paths": [[root, …, target]], "complete"}`. Comment `devos:read …` | 2.5's row with C-M06 (19 (4)); Appendix C F04 ("separate and bounded") |
| Grants (M09-06:1114-1140) | `revoke all … from public` and from the four API roles where they exist, on all four; `grant execute … to anon` on all four; no type, no private function | 1 item 13; T-W08-PRIV's constraint |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the twenty-four `devos_api` functions.
- **Types.** No `devos_private` type has PUBLIC USAGE.
- **The literals**, as the break patches read them: `relate` and `retract_relation` hold `array['devos_calisma', 'devos_sinav', 'devos_kurulum']`; `affected_entities` and `explain_paths` hold `array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']`.
- **The unqualified-name scan.** No hit in M09-06's four functions; its four hits are section 3.1's.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** `affected_entities`, `deployment_drift`, `explain_paths`, `read_decision`, `ready_works`, `token_role_class` carry it.
- **The exam table's name.** It occurs in all four functions' text (the `devos_sinav` branches above), and all four are on T-W07-N08's list of functions exempt by name (`job/w07_n08_exam_records.sql:284-286`; EV-C02-008 5.1, "The exemption list"). Self-check `TX-exam-table`.

### 7.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. No merged test is changed. EV13 section 19 (C-M06) states items 1 to 6 in the record itself.
1. **`relate`'s order and forms** (EV13 19 (1)):
   - `relation_rule` comes with the form, since it reads nothing; the table's CHECK is its backstop in the write block (break k01: `write_failed` then).
   - The cycle helper runs before the ends, for DM-01's lock order. Its answer is used last, after the repeat.
   - The fourteen families; a revision sent for a record without revisions is a revision it does not have; an earlier revision of a Work is accepted.
   - Only the `from_ref` row is locked (`for update`), never the `to_ref`'s, so that `A -> B` and `B -> A` cannot deadlock.
   - `hard` with a type other than `depends_on` is accepted: Rule C applies, the cycle check does not.
   - The exact repeat is 2.5's key among `current` relations: a call that differs only in `scope`, `method` or `epistemic_status` gets the existing relation (`RL-repeat-key-only`).
   - The refusal row names no target; the declared session goes to the event and the row.
2. **`retract_relation` on a transferred relation from a work item: both clauses** (EV13 19 (2)). `devos_kurulum` retracts it only when the work item lies under the installation's Mission (`RT-transferred-kur-ordinary-item`: `not_owner`; `RT-transferred-kur-inst` and `-decision`: `ok`). This is the stricter of two readings of EV-C02-008 1.7.1. T-W07-ROC reads the other (7.4). Also chosen:
   - `reason` may be NULL (`RT-reason-null`);
   - the creation event is the relation's first event, and none or a NULL type is `could_not_check`;
   - the work item is locked before the relation;
   - no advisory lock: retracting cannot close a cycle.
3. **The walks' edge, for every type** (EV13 19 (3)): `to_ref` changed, `from_ref` affected. It is T-W07-F04's reading of `derived_from`, taken for every type. `stale` relations are walked; `retracted` ones are not; a NULL `validity` makes the result not complete (`AE-validity`, `AE-partial-edge`). The residual for `supports`, `challenges` and `part_of` is in 7.6.
4. **`affected_entities`' forms:** `records` `{ref, path}` with the first breadth-first path; the root never listed; `complete` as 19 (3) says.
5. **`explain_paths`' forms** (EV13 19 (4)):
   - A target equal to the root is `invalid_field`.
   - The step bound, 20000, is chosen; at it, `complete` is false.
   - An edge out of the last level at `max_depth`, to a record seen or not, makes `complete` false. This was found by the self-check's `EP-cut` in a trial run and fixed before the filed run: a path can return into the region and still be longer than `max_depth`.
6. **The limits:** each a JSON integer of at least 1 (up to nine digits), else `invalid_field`; JSON null or absent is the default; `explain_paths`' `max_depth` default 5, as 2.5's "As above".
7. **Open samples are not withheld here.** EV-C02-008 5.2 (d) gives that to W-C02-10, with the sampling: C02's schema has no block state yet. Until then a `sample` Review is a record like any other for `relate` and the walks. This is not a departure, but it is stated because 2.5's row names it.

Not departures, for the checker:
- `relate` checks no Rule O when `from_ref` is not a work item (EV13 section 4: "`relate` checks nothing more for them"; `RL-o-from-decision-kur`: `ok`).
- `relate` checks no scope containment between the relation and its ends: 2.5 names none.
- The ledger-transfer form of a Relation (`transfer_relation`) is M09-11's.

### 7.3 How W-C02-09's points are served by M09-06

- **Point 1.** A versioned file later than `20261018235501`, plain SQL, no `psql` meta-command, no backslash (O, `49_git_hashes.txt`: `backslashes in M09-06: 0`). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject`, on every refusal (`{"rejected": 1}` deltas);
  - F06's list: the two walks carry the read marker; `relate` and `retract_relation` are state-changing (`24 devos_api functions (6 marked devos:read)`, `F06-list | ok`);
  - concurrency: DM-01's lock order, the dependency queue first (7.1; the probe, 7.5).
  - Offline, `deployment_drift` reports `no_difference`, 18 of 18 (runs 04 and 10).
- **Point 2.** Twenty-four of the 55 `devos_api` functions now exist (four here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (7.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the four refuses a call with no token before any other check (`F06-refused:relate`, `-retract_relation`, `F06-read-refused:affected_entities`, `-explain_paths`, `ok`; the self-check's `*-no-token`). Each refuses a class not on its list with one per-call row: 5B rows R21 and R22, their 24 cells `ok`; the self-check's `*-role-*` cases.
  - Fifth bullet. A declared role name changes nothing (`RL-declared-role-ignored`: `not_owner`); a declared session is written as declared (`RL-pos-event`).
- **Point 5.**
  - Each state-changing function writes its event in the same transaction, with the token's class (`RL-pos-event`: `relation_created`, `devos_calisma`, `call`, this transaction; `RT-pos-state`).
  - An exact repeat writes no event and raises no error (`RL-repeat`, `RL-repeat-key-only`, `RL-group-own-repeat`, `RT-repeat`: `ok repeat`, `{}`).
  - A failure planted mid-transaction leaves no half state and no orphan event (`RL-write-failed` on `relation`, `RL-write-event-failed` on `event`, `RT-write-failed`: only the refusal row is added; `RL-write-P0D02`: `could_not_check` with its reason).
- **Point 6.** `relate` with `model_extracted` and `observation` is refused `relation_rule`, on both of its branches (`RL-rule-about`, `RL-rule-hard`; T-W07-REL's `REL-a`, `REL-b` `ok`); with `model_extracted` and `inference` it is accepted (`RL-pos-model-inference`, the row read after). T-W07-REL's own positives cannot pass on its fixtures (7.4).
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass:
  - `relate`: `RL-end-from-random`, `-to-random`, `-to-revision-999`, `-to-no-revision`, `-need-with-revision`, `-env-token-row`; `RL-o-no-event`, `-mission-revision-unreadable` (42501), `-events-unreadable` (42501); `RL-c-partial`, `-unreadable` (42501); `RL-cycle-partial`; `RL-read-unreadable` (42P01), the form 6RG-r4 plants;
  - `retract_relation`: `RT-no-creation-event`, `-creation-event-partial`, `-event-unreadable` (42501), the forms T-W07-ROC's `ROC-x-o-event-*` plant;
  - the walks: `AE-root-random`, `AE-unreadable` (42P01), `EP-target-random`, `EP-unreadable`; T-W07-F04's F04-m1, -m2, -u1 and -u2 `ok`.
  - At a limit, the walks return `complete` false and never "nothing else is affected": F04-d1, -d2, -a-bounded `ok`; `AE-depth`, `AE-records`, `EP-bounded`, `EP-depth`, `EP-cut`.
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the four, run in place (run 06):
    - **T-W07-K05 `PASS (6/6)`**, the first merged file to pass whole on these functions;
    - **T-W07-F04 `COULD NOT CHECK (1 of 22 …)`**: 21 cases `ok`, and `F04-m4-cal` `could_not_check` at its control (7.4);
    - T-W07-REL `FAIL (2 bad, …)`: `REL-a` and `REL-b` `ok`, `REL-pos` and `-pos2` `bad` (7.4);
    - T-W07-5A's positive control `FAIL (1 bad, …)` (7.4);
    - F06: the four functions' refused and read cases `ok`; `F06-role-token` `bad`, and `relate`'s and `retract_relation`'s event and repeat cases `could_not_check` (7.4); in all `FAIL (1 bad, 19 could not check, of 65)`;
    - 5B: the 24 cells of R21 and R22 `ok`; `COULD NOT CHECK (10 of 148 could not be checked)` for rows whose functions are not built; none `bad`;
    - DM07, DM34, 6TK, IDC, 5A and DM02 pass again.
  - Their copies are a later pull request's (R:247; EV13 section 11).

### 7.4 What M09-06 does not yet serve

- **Merged tests whose fixtures cannot reach `relate` on a correct build** (EV13 19 (5)). Each plants its work items with `pg_temp.w07_plant`, whose Missions have no creation event. So Rule O answers `could_not_check` (EV13 17 (5)), as N-285 item (1) found for M09-04's functions:
  - **T-W07-REL** (W9 point 6's test): `REL-pos` and `REL-pos2` are `bad`. So the merged break B-REL-1 cannot be shown either: under it `REL-a` and `REL-b` stay `ok`, refused by Rule O before its wrapper's flip matters (run 34).
  - **T-W07-5A's positive control** (`job/w07_5a_positive_control.sql`, assigned to W-C02-09 by EV13 section 11): `5A-pos` is `bad`.
  - **T-W07-F04**: `F04-m4-cal` is `could_not_check`, since its control `relate` between two planted items is refused. So B-F04-8, whose only red case is `F04-m4-cal`, cannot be shown (run 42).
  - **T-W07-F06**: `F06-event:relate` and `F06-repeat:relate` are `could_not_check`. `F06-role-token` is `bad`; its `devos_kurulum` call also needs a work item under the installation's Mission. `F06-orphan-a` and `-b` pass for the wrong reason: Rule O refuses before the planted failure is reached. `retract_relation`'s recipe plants a relation with no creation event: `could_not_check`. The test designer's unmerged revision of F06 (branch `claude/c02-w07-n285-tests`, read only, not run) leaves these recipes as they are.
  - **The merged files prefer a break.** Break k09 reads a Mission with no creation event as not the installation's. Under it, T-W07-F04 goes to `PASS (22/22)` and T-W07-REL to `PASS (4/4)` (run 22), as F06 preferred M09-04's k08 (5.5). That is the cause of the cases above, shown from the other side.
- **T-W07-ROC's `ROC-o-retract_relation-kur-transferred`.** The hook `transferred_relation` plants the relation from `w_cal`, an ordinary work item, and wants `devos_kurulum` accepted. Under 7.2 item 2 that is `not_owner`. ROC does not run yet: it needs `register_artifact`.
- **T-W07-DM11.** It now runs, since `relate` exists. `DM11-a` to `-e` are `bad`: they test W-C02-10's answer gate (B 3.17, DM-11; DM11 is W-C02-10's copy, EV13 section 11), not M09-06. `DM11-pos-supersede` sends no `scope` and is refused `missing_field` (N-283 item (7); revised on the unmerged branch).
- **The staged files that call these functions but need a later function stop at their `-pre` line** (run 06):
  - T-W07-6RG (its r0 to r4 are `relate`'s) needs `register_artifact` and `prepare_operation`;
  - T-W07-ROC, T-W07-N08 (exam fact and records), T-W07-N29 and Group C's other files need `register_artifact`, `record_eval_run`, `record_finding`, `open_review` or W-C02-10's tables;
  - T-W07-DM19 needs `accept`;
  - T-W07-CONC (`job/w07_conc_claim_and_cycle.py`) was not run: its own check of required functions lists `register_artifact` (its line 90), so it gives COULD NOT CHECK. 7.5's probe repeats its CONC-cyc2 and CONC-cyc4 forms on `relate` alone.
  - So W9 point 8's Concurrency (both claims), F08's new hard dependency (F08 (a)) and 6RG's reference cases are "could not check", not counted.
- **The merged breaks of these functions** (W-C02-13's):
  - Shown here (runs 35 to 40, 43, 44): B-F04-1 (`F04-a-rows`, `-b-rows`), B-F04-2 (`-c-flag`, `-d1`, `-d2`), B-F04-3 (`-m1`, `-m2`, `-u1`, `-u2`), B-F04-4 and B-F04-5 (`-e-exam`), B-F04-6 (`-m3`, `-m4-paths`), B-F04-9 (`-c-sin`), B-K05-1 (`K05-rows`): each turns exactly its named cases red. B-CONC-2, on the probe (run 46).
  - **B-F04-7** cannot be shown as merged. Its wrapper inserts `p->>'type'` and `p->>'method'`, text, into enum columns, which PostgreSQL refuses (SQLSTATE 42804). So `F04-m4-sin` and `-kur` become `could_not_check` (run 41). Its header says "the prober adapts it to the build's before the run".
  - B-REL-1 and B-F04-8: above.
  - B-6RG-1, B-ROC-2, B-ROC-3, B-N29-3: their tests do not run yet.

### 7.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0906` at `c8449e4`, with M09-06, EV13's section 19 and the raw files untracked. The main run started 2026-10-19T00:38:41Z and ended 2026-10-19T00:38:48Z, on one cluster (`…/scratchpad/m0906_run/rerun.sh`). The break runs started 2026-10-19T00:38:48Z and ended 2026-10-19T00:42:07Z, on a second cluster (`…/scratchpad/m0906_run/brk.sh`).
- **The drivers.** `run.sh`, `drive.py`, `scrub.py` and `scan.py` are `…/m0905_run/`'s, changed only in their paths (the clone `prd09`, the cluster under `…/m0906_run/pg`, the socket in `…/scratchpad/m6s`) and one printed word. `setup.sql` and `catalog.sql` are copies of `…/m0903_run/`'s, unchanged. `fn_check.sql` keeps M09-05's harness (`m_call`, `m_case`, `m_rec`) with M09-06's counted tables and cases. `brk.py`, `brk.sh`, `final.sh` and the probe follow M09-05's forms.
- **Trial runs.** Trial runs came before, none of them filed: the main run's steps once (`…/m0906_run/trial1`), the self-check alone three times (`…/m0906_run/trialfn.sh`), and the break runs once (`…/m0906_run/trial2`). The second self-check trial, the first with the cases `EP-cut`, `EP-uncut` and `EP-simple`, had one red case, `EP-cut`, which found 7.2 item 5's fault in `explain_paths`. M09-06 was fixed and the third trial went green. The break trial ran on the fixed bytes. Before it, break k11 was reworded so that it models its fault, a missing creation event read as "not transferred"; its first form still answered `could_not_check` through the partial-type check.
- **A discarded filed set.** A first set of files 01 to 49 was made on bytes whose catalogue scan (run 08, part 5) had two false hits in `relate`: "from another", in a reason text, and "update too", in a comment. Both phrases were reworded (no logic changed), those files were deleted, and every run was made again. The files filed here are the second set, of the envelope's bytes.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the seventeen migrations before M09-06, each `[exit 0]` with its history row (34 `[exit 0]` lines).
- **03, M09-06:** `CREATE FUNCTION` ×3, `COMMENT`, `CREATE FUNCTION`, `COMMENT`, `REVOKE` ×4, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 18, "migrations_expected": 18`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result):
  - `W07_K05_MANY_PATHS PASS (6/6)`;
  - `W07_F04_AFFECTED_RECORDS COULD NOT CHECK (1 of 22 could not be checked)`, for example `F04-a-rows | ok | 54 rows for a graph of 55 records (unique: t; …)`, `F04-a-bounded | ok | … {"n": 3, "ok": true, "complete": false}`, `F04-m4-sin | ok`, `F04-m4-kur | ok`, `F04-m4-cal | could_not_check | control: relate between two records Rule O gives devos_calisma was not accepted …` (7.4);
  - `W07_REL_RELATION_STATUS FAIL (2 bad, 0 could not check, of 4)`: `REL-a | ok | … relation_rule`, `REL-b | ok`, `REL-pos | bad | returned {… "rule_o: whether the work item lies under the installation's Mission is missing or partial" …}`, `REL-pos2 | bad` (7.4);
  - `W07_5A_POSITIVE_CONTROL FAIL (1 bad, 0 could not check, of 1)` (7.4);
  - `W07_F06_STATE_CHANGE_EVENT FAIL (1 bad, 19 could not check, of 65)`, with `24 devos_api functions (6 marked devos:read)`; `F06-role-token | bad` (7.4);
  - `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (10 of 148 could not be checked)`, none `bad`, for example `5B-R21-relate-den | ok | x cell: … code role_class_not_permitted`;
  - `W07_DM11_ANSWER_REVISION FAIL (6 bad, 0 could not check, of 8)`: W-C02-10's answer gate and N-283 (7) (7.4);
  - `W07_DM07_HEARTBEAT PASS (8/8)`, `W07_DM34_MISSION_SCOPE PASS (10/10)`, `W07_6TK_TOKEN_REASONS PASS (32/32)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`;
  - `W07_DM19B_BURST_COUNT COULD NOT CHECK (6 of 12 could not be checked)`, `W07_N04_SELF_APPROVAL COULD NOT CHECK (4 of 4 could not be checked)`;
  - `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, 0 could not check, of 3)`: W-C02-10's, as in sections 4.5 to 6.5; it calls no M09-06 function;
  - every other file `COULD NOT CHECK` on its `-pre` line (7.4); run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 7.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 M09-06; one transaction rolled back): `M0906_FUNCTIONS PASS (193/193)`.
  - The cases: 93 for `relate`, 29 for `retract_relation`, 38 for `affected_entities`, 28 for `explain_paths` and 5 for the text.
  - Each compares the answer's code and the change of seven tables; the state cases read the row after.
  - Among them: `RL-exam-cal-to-as-none` and `-from-as-none` (an exam record end answered for `devos_calisma` with the very reason of a missing record); `RL-exam-sin-to`: `exam_record`; `RL-o-cal-exam`: `ok`; `RL-c-other-class`: `other_class_claim`, `RL-c-own-class` and `-lapsed`: `ok`; `RL-group-own-row`: `group_id` its own id; `RL-group-id-other-from`: `invalid_field`; `RL-cycle-two` and `-three`: `cycle`; `RL-cycle-lock`: the advisory lock (9001, 1) held; `RT-transferred-kur-ordinary-item`: `not_owner`; `AE-hidden-cal-flag` (the exam record's id nowhere, `complete` false), `AE-hidden-sin-found`; `AE-diamond-cycle-records`; `EP-diamond-paths`; `EP-cut-flag`; `EP-simple-path`; `TX-cycle-before-row-lock`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `relation`.
- **11:** the server log, `466 lines; claim-format 0; environment-format 0`. **12:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **13 to 33, the break copies** (`brk.py`: 20 `made (one replacement in devos_api.<fn>)`). Each copy was applied in place of M09-06 (`[apply exit 0]`). Then the self-check and the staged F04, K05, REL, F06 and 5B were run, and its four functions were dropped (`[drop exit 0]`):
  - **k01**, relate relation rule removed: `M0906_FUNCTIONS FAIL (2 of 193 not as wanted)`, red `RL-rule-about`, `RL-rule-hard`.
  - **k02**, relate cycle refusal removed: `M0906_FUNCTIONS FAIL (3 of 193 not as wanted)`, red `RL-cycle-self`, `RL-cycle-two`, `RL-cycle-three`.
  - **k03**, relate exam end read for every class: `M0906_FUNCTIONS FAIL (5 of 193 not as wanted)`, red `RL-exam-cal-to`, `RL-exam-cal-to-as-none`, `RL-exam-cal-from`, `RL-exam-cal-from-as-none`, `RL-exam-kur-to`; merged: `F04-m4-kur` `bad`.
  - **k04**, relate end check removed: `M0906_FUNCTIONS FAIL (13 of 193 not as wanted)`, red `RL-end-from-random`, `RL-end-to-random`, `RL-end-to-revision-999`, `RL-end-same-text-revision`, `RL-end-to-no-revision`, `RL-end-same-text-partial`, `RL-end-need-with-revision`, `RL-end-env-token-row`, `RL-exam-cal-to`, `RL-exam-cal-to-as-none`, `RL-exam-cal-from`, `RL-exam-cal-from-as-none`, `RL-exam-kur-to`; merged: `F04-m4-kur` `bad`.
  - **k05**, relate rule o kurulum removed: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `RL-o-kur-ord`.
  - **k06**, relate rule c removed: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `RL-c-other-class`.
  - **k07**, relate repeat removed: `M0906_FUNCTIONS FAIL (3 of 193 not as wanted)`, red `RL-repeat`, `RL-repeat-key-only`, `RL-group-own-repeat`.
  - **k08**, relate group check removed: `M0906_FUNCTIONS FAIL (3 of 193 not as wanted)`, red `RL-group-id-other-from`, `RL-group-id-other-mode`, `RL-group-readiness`.
  - **k09**, relate no event mission as ordinary: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `RL-o-no-event`; **the merged files prefer this break:** `W07_F04_AFFECTED_RECORDS PASS (22/22)`, `W07_REL_RELATION_STATUS PASS (4/4)` (7.4).
  - **k10**, retract transferred clause removed: `M0906_FUNCTIONS FAIL (3 of 193 not as wanted)`, red `RT-transferred-cal`, `RT-transferred-sin`, `RT-transferred-kur-decision`.
  - **k11**, retract missing creation event passes: `M0906_FUNCTIONS FAIL (2 of 193 not as wanted)`, red `RT-no-creation-event`, `RT-creation-event-partial`.
  - **k12**, retract rule c removed: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `RT-c-other-class`.
  - **k13**, retract rule o calisma removed: `M0906_FUNCTIONS FAIL (2 of 193 not as wanted)`, red `RT-o-cal-inst`, `RT-o-kur-inst`.
  - **k14**, affected no deduplication: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `AE-diamond-cycle-records`; merged: `F04-a-rows` `bad`, `K05-rows` `bad`.
  - **k15**, affected always complete: `M0906_FUNCTIONS FAIL (6 of 193 not as wanted)`, red `AE-depth-flag`, `AE-records-flag`, `AE-hidden-cal-flag`, `AE-hidden-den-flag`, `AE-validity-records`, `AE-partial-edge-flag`; merged: `F04-c-flag` `bad`, `F04-d1` `bad`, `F04-d2` `bad`.
  - **k16**, affected exam records shown to every class: `M0906_FUNCTIONS FAIL (3 of 193 not as wanted)`, red `AE-hidden-cal-flag`, `AE-hidden-den-flag`, `AE-eval-unreadable-cal`; merged: `F04-c-flag` `bad`, `F04-c-noleak` `bad`.
  - **k17**, affected missing root answered empty: `M0906_FUNCTIONS FAIL (3 of 193 not as wanted)`, red `AE-root-random`, `AE-root-exam-cal`, `AE-root-exam-as-none`; merged: `F04-m1` `bad`.
  - **k18**, explain max paths not enforced: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `EP-bounded-flag`; merged: `F04-a-bounded` `bad`, `F04-a-paths` `bad`, `K05-paths` `bad`.
  - **k19**, explain cut not flagged: `M0906_FUNCTIONS FAIL (2 of 193 not as wanted)`, red `EP-depth-flag`, `EP-cut-flag`.
  - **k20**, explain paths not simple: `M0906_FUNCTIONS FAIL (1 of 193 not as wanted)`, red `EP-simple-path`.
  - So each check turns red when its rule is removed. F04 caught k03 and k04 (through `F04-m4-kur`) and k14 to k18; K05 caught k14 and k18. The self-check alone caught the other thirteen, because no merged test runs those rules yet, or runs them only on fixtures Rule O refuses first (7.4).
- **34 to 44, merged break patches on M09-06 itself** (`[M09-06 apply exit 0]`, `[patch exit 0]`, M09-06 dropped after each): as 7.4 lists.
  - **34, B-REL-1:** `W07_REL_RELATION_STATUS FAIL (2 bad, 0 could not check, of 4)`; `REL-pos` `bad`, `REL-pos2` `bad`.
  - **35, B-F04-1:** `W07_F04_AFFECTED_RECORDS FAIL (2 bad, 1 could not check, of 22)`; `F04-a-rows` `bad`, `F04-b-rows` `bad`, `F04-m4-cal` `could_not_check`.
  - **36, B-F04-2:** `W07_F04_AFFECTED_RECORDS FAIL (3 bad, 1 could not check, of 22)`; `F04-c-flag` `bad`, `F04-d1` `bad`, `F04-d2` `bad`, `F04-m4-cal` `could_not_check`.
  - **37, B-F04-3:** `W07_F04_AFFECTED_RECORDS FAIL (4 bad, 1 could not check, of 22)`; `F04-m1` `bad`, `F04-m2` `bad`, `F04-m4-cal` `could_not_check`, `F04-u1` `bad`, `F04-u2` `bad`.
  - **38, B-F04-4:** `W07_F04_AFFECTED_RECORDS FAIL (1 bad, 1 could not check, of 22)`; `F04-e-exam` `bad`, `F04-m4-cal` `could_not_check`.
  - **39, B-F04-5:** `W07_F04_AFFECTED_RECORDS FAIL (1 bad, 1 could not check, of 22)`; `F04-e-exam` `bad`, `F04-m4-cal` `could_not_check`.
  - **40, B-F04-6:** `W07_F04_AFFECTED_RECORDS FAIL (2 bad, 1 could not check, of 22)`; `F04-m3` `bad`, `F04-m4-cal` `could_not_check`, `F04-m4-paths` `bad`.
  - **41, B-F04-7:** `W07_F04_AFFECTED_RECORDS COULD NOT CHECK (3 of 22 could not be checked)`; `F04-m4-cal` `could_not_check`, `F04-m4-kur` `could_not_check`, `F04-m4-sin` `could_not_check`.
  - **42, B-F04-8:** `W07_F04_AFFECTED_RECORDS COULD NOT CHECK (1 of 22 could not be checked)`; `F04-m4-cal` `could_not_check`.
  - **43, B-F04-9:** `W07_F04_AFFECTED_RECORDS FAIL (1 bad, 1 could not check, of 22)`; `F04-c-sin` `bad`, `F04-m4-cal` `could_not_check`.
  - **44, B-K05-1:** `W07_K05_MANY_PATHS FAIL (1 bad, 0 could not check, of 6)`; `K05-rows` `bad`.
- **45 and 46, the concurrency probe.** 20 runs of 2 connections adding `a -> b` and `b -> a` (hard `depends_on`) at once, then 20 runs of 4 connections closing a cycle of four. Each connection issues a synthetic `devos_calisma` token inside its transaction, waits at one advisory-lock barrier, and calls `relate` once. Each prints only its answer's status and code.
  - **45, unpatched:** two at once: `2 connections waiting; answers: 1 ok ;1 refused cycle; other lines: 0; hard edges among them: 1` (20 of 20); four at once: `4 connections waiting; answers: 3 ok ;1 refused cycle; other lines: 0; hard edges among them: 3` (20 of 20).
  - **46, with B-CONC-2:** `hard_dependency_cycle holds the exclusive advisory lock: false`, `relate holds for update: false`; two at once: `2 connections waiting; answers: 2 ok ; other lines: 0; hard edges among them: 2` (20 of 20); four at once: `4 connections waiting; answers: 4 ok ; other lines: 0; hard edges among them: 4` (20 of 20).
  - So the dependency queue serializes the cycle checks, and without it two or four concurrent writes close a cycle.
- **47:** the server log, `1278 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **48:** files 01 to 47 scanned with the finders of `scan_patterns.json`: `47 files; claim-format 0; environment-format 0`.
- **49:** the hashes in the envelope; `backslashes in M09-06: 0`; `M09-06 lines naming the exam table: 9`; `M09-06 strings found by either token finder: m0906 scan: 1 files; claim-format 0; environment-format 0`; `M09-06 lines holding either marker whole: 0`; `git status --porcelain`: M09-06, EV13 and the raw files 01 to 49, before this section was written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 7.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-REL, T-W07-5A's positive control, T-W07-F04's `F04-m4-cal`, T-W07-F06's `relate` and `retract_relation` recipes and `F06-role-token`, and T-W07-DM19's `DM19-b` and `-c` plant their work items under Missions with no creation event (7.4). They need a Mission opened with `open_mission`, or a planted `mission_opened` event, and `F06-role-token` a work item under the installation's Mission. F06's `retract_relation` recipe needs a relation made by `relate`, or a planted creation event. This is N-285 item (1)'s cause, in files that note does not name. Until then REL cannot pass W9 point 6's test, and B-REL-1 and B-F04-8 cannot be shown.
   - T-W07-ROC's hook `transferred_relation` plants from `w_cal`; under EV13 19 (2) `ROC-o-retract_relation-kur-transferred` needs a relation from `w_inst`, or from a record that is not a work item.
   - B-F04-7 writes text into enum columns (42804), so it cannot be shown as merged (7.4).
2. **For the executor** (reported, not done):
   - **The walks' direction for every type** (7.2 item 3). For `supports`, `challenges` and `part_of`, the record affected may be the `to_ref`. As built, a walk from a supporting source misses what it supports. A per-type direction needs a source: C04's relation search design, or a decision with a checker. Before the walks are used for impact analysis beyond `derived_from` and `depends_on`.
   - **EV13 19 (2)'s stricter reading** of Rule O on transferred relations, for M09-06's checker to judge against ROC's expectation.
3. **For the checker of verdict (i):**
   - EV13 section 19 with its *[C-M06]* marks;
   - 7.2's departures, chiefly 1, 2, 3 and 5;
   - the self-check, the break copies and the probe, which are the producer's own.
4. **For the producers of M09-08 and M09-11:**
   - `transfer_relation` (M09-11) applies `relate`'s family rules (EV13 3.2; EV-C02-008 5.2 (b)) and must call `hard_dependency_cycle` before any row lock, as `relate` does.
   - F08's re-check at the effect reads hard dependencies through `ready_value` (3.5 item 4). A hard `depends_on` that `relate` adds after a claim serializes with the effect on the work item's row (M09-06:300).
5. **Residuals:**
   - The walks look a record up in fourteen tables per level (one `union all`), and `explain_paths` keeps its region in memory. That is a cost, not a rule, at C02's sizes; C04's measurement (T-W07-K05's "Not covered") sizes it.
   - An unreadable table among the fourteen makes every `relate`, and every walk, `could_not_check` (`RL-c-unreadable` reports `from_ref`'s check). That fails closed.
