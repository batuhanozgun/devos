---
id: EV-C02-014
item: W-C02-09
kind: build
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (section 1, M09-01; the executor names the agent at filing); section 3 (M09-02) by two further producers, fresh-context subagents of the same session: agent `aa147172b0a972415` (the build, 3.1 to 3.6) and agent `ade5e8c818705b326` (route A's self-check, the copy of w07_idc_real_path.py, 3.7 and 3.8; named by the executor at filing, L-357); section 4 (M09-03) by agent `aae34814c3026b1e9`, a further producer of the same session (named at filing, L-361), its changes for CHK-C02-086 by agent `a0304cd560855cc00` (named at filing, L-362); section 5 (M09-04) by agent `a681fe739bd00cad2` (named at filing, L-366); section 6 (M09-05) by agent `ad37a946776298dc5` (named at filing, L-369); section 7 (M09-06) by agent `aba07f336ee1706f3` (named at filing, L-372); section 8 (M09-07) by agent `a4e5fa9f374a2f629` (named at filing, L-374); section 9 (M09-08) by agent `af74f765a56f55dce` (named at filing, L-379; an earlier producer, `a74cae4d07776f980`, was lost at a container restart before it reported, and its draft was taken as a hint only); section 10 (the rule corrections) by agent `ad4819f8b4eb214ac` (named at filing, L-387); section 11 (M09-09) by agent `a7dafa37998b2a2b5` (named at filing, L-391); section 12 (M09-10) by agent `a6545fc03ef4f6f5b` (named at filing, L-394); section 13 (M09-11) by agent `a530269303b8ab1a3` (named at filing, L-397); section 14 (M09-12 and the test copies) by agent `a328dd0e2f1fce94a` (named at filing, L-400); section 15 (the transfer corrections and the two test copies) by a further producer of the same session, agent `a827992e8d76a6697` (named at filing, L-411)"
main_at: 1cdbb4e99cc5306e4dadf1e431ebbade7b03b68f
date: 2026-10-17
claim: "W-C02-09's build record. Section 1: M09-01, the identity chain's first part, as versioned SQL, its test copy and the client tools/devos_rpc.py; section 3: M09-02, the private helpers, token_role_class()'s six-class literal and route A's TEMPORARY revoke with its self-check, as versioned SQL, and the copy of w07_idc_real_path.py (written at main db6d6be); section 4: M09-03, the seven functions of Mission, need and decision (EV-C02-013 2.2), as versioned SQL, with EV-C02-013's corrections 15 and 16 (written at main 9638f1d, revised on branch claude/c02-w09-m0903 at c3cd1ed for CHK-C02-086); section 5: M09-04, the six functions of Work and effort policy (EV-C02-013 2.3), as versioned SQL, with EV-C02-013 section 17 (written at main d032a84); section 6: M09-05, the five functions of readiness and claim (EV-C02-013 2.4), as versioned SQL, with EV-C02-013 section 18 (written at main 4f01115); section 7: M09-06, the four functions of Relation (EV-C02-013 2.5), as versioned SQL, with EV-C02-013 section 19 (written on M09-05's head c8449e4); section 8: M09-07, the seven functions of knowledge, product and review (EV-C02-013 2.6), as versioned SQL, with EV-C02-013 section 20 (written on M09-06's head 69d3632); section 9: M09-08, the four functions of the external effect (EV-C02-013 2.7), as versioned SQL, with EV-C02-013 section 21 (N-279 (17)'s correction and M09-08's departures, written on M09-07's head 32fbb4e); section 10: the rule corrections, one migration carrying N-288's `ALIAS FOR $n` replacements and EV-C02-017's four build changes (EV-C02-013 sections 22 and 23, written at main 1daa352); section 11: M09-09, the six functions of exam, backup and the other reads (EV-C02-013 2.8), as versioned SQL, with EV-C02-013 section 24 (written on the rule corrections' head 3a7baa6); section 12: M09-10, the six transfer-run and event functions (EV-C02-013 3.2), as versioned SQL, with EV-C02-013 section 25 (written on M09-09's head 21847e7); section 13: M09-11, the six transfer-record functions (EV-C02-013 3.2), as versioned SQL, with EV-C02-013 section 26 (written on M09-10's head 9066ccf); section 14: M09-12, the two transfer-copy functions (EV-C02-013 3.2), as versioned SQL, with EV-C02-013 section 27 (written on M09-11's head 7fc7537), and the copies of section 11 under supabase/migrations/tests/; offline runs on PostgreSQL 16.15 are supporting evidence, not counted results; section 2 records M09-01's apply to both projects; the applies of M09-02 to M09-04 are recorded in plan/ledger/C02-log.md (L-360, L-364, L-368, M09-05's in L-372, M09-06's in L-374, M09-07's in L-377, M09-08's in L-383, the rule corrections' in L-391, M09-09's in L-393, M09-10's in L-397, M09-11's in L-400), and nothing is applied by section 14; each section is judged by a fresh checker of the same session (verdicts named in the log), not independently tested (corrected 2026-10-19, L-371, CHK-C02-091 C1)"
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

*[Dated line, 2026-10-19, L-373; CHK-C02-092 C3: the test revision this record calls unmerged (#367) is merged at the head that verdict (i) judged (`69d3632`). There, by CHK-C02-092's run: `DM11-pos-supersede` is `ok` and DM11 is FAIL (5 bad of 8: DM11-a to -e, W-C02-10's answer gate); F06 is FAIL (1 bad, 9 could not check, of 64): `F06-role-token` bad, `relate`'s and `retract_relation`'s event and repeat cases `could_not_check` from N-291's cause. The F06, DM11 and other numbers above for the files #367 changed were taken on `c8449e4`'s test bytes.]*

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

*[Dated line, 2026-10-19, L-373; CHK-C02-092 C3: the test revision this record calls unmerged (#367) is merged at the head that verdict (i) judged (`69d3632`). There, by CHK-C02-092's run: `DM11-pos-supersede` is `ok` and DM11 is FAIL (5 bad of 8: DM11-a to -e, W-C02-10's answer gate); F06 is FAIL (1 bad, 9 could not check, of 64): `F06-role-token` bad, `relate`'s and `retract_relation`'s event and repeat cases `could_not_check` from N-291's cause. The F06, DM11 and other numbers above for the files #367 changed were taken on `c8449e4`'s test bytes.]*

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
   - **The walks' direction for every type** (7.2 item 3). For `supports`, `challenges` and `part_of`, the record affected may be the `to_ref`. As built, a walk from a supporting source misses what it supports. A per-type direction needs a source: C04's relation search design, or a decision with a checker. Before the walks are used for impact analysis beyond `derived_from` and `depends_on`. *[Dated line, 2026-10-19, L-373; CHK-C02-092 C1: one source does bear on it. Appendix B 3.4's third rule (`plan/Ek_B_Veri_Modeli.md`, line 149: when a supporting source goes stale, what it supports falls back into re-evaluation) points, for `supports`, to `from_ref` changed and `to_ref` affected, the opposite of what is built; as built, a walk from a supporting source returns no record and `complete: true` (CHK-C02-092 finding 4). The decision is N-292's.]*
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

## 8. M09-07: knowledge, product and review

The producer's record of `supabase/migrations/20261019030001_w09_knowledge_product_review.sql` (M09-07). It was written on branch `claude/c02-w09-m0907` at `69d3632d4e7fb1de6c50db437d3459f1d24824a8`: `main` `5b96842` with M09-01 to M09-05, plus M09-06 (`20261019010001_w09_relations.sql`) from its pull request #369, under review. M09-07 builds on M09-06 and does not change it. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at that commit, with EV13's correction section 20 added by the same producer. M09-07 means the file above, and M09-07:n a line of it. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 20 first.** EV13 gained "20. Correction, 2026-10-19 (M09-07)", with marks *[C-M07]* in the seven rows of 2.6. It states the forms 8.2 lists, takes the sources' side against 2.6's wording in one place (8.2 item 2), and names the refusals sources require that 2.6's rows do not (8.2 items 3 and 6). M09-07's checker judges it.
- **The note items that bind M09-07's commit, checked on the branch before the SQL** (`plan/work/C02.md`):
  - **Binding M09-07's commit: none open and unmet.**
  - N-279 (10), first part: whether `register_artifact`'s `work_revision` is required, "before the first commit of the migration that builds the function". **Met.** EV13 R2-1 decided it (required; absent: `could_not_check`; the tie in the event's payload), CHK-C02-081 judged it, and M09-07 builds it (M09-07:556-559, :662-666). R1-7 (`criterion` written to `criterion_ref`), which N-279 (10) puts to the joint verdict, is judged and built (M09-07:928-931).
  - N-288 (parameters named through the function's name). It binds M09-07's form, not its commit. **Met:** every body reads its parameters through `ALIAS FOR $n` (M09-07:54, :290-292, :494-495, :699, :969, :1104-1105, :1408). Self-check `TX-alias`.
  - This record's 3.5 item 4 and 6.6 item 4, for this producer. "Call `check_claim`, then `ready_value(work, assignment_id)` at an effect" is **met** (M09-07:597, :622; `TX-claim-before-readiness`). "A claim's token is never put into an effect's event or refusal row" is **met** (`RA-event`, `RA-rows-hold-no-token`; break b12). "`ALIAS FOR $n` if a merged patch renames the function" is **met** (above).
  - N-281, with its L-369 annotation: no real-path `claim` until it is met. M09-07 makes no claim and returns no token; `register_artifact` takes one as a parameter, as `heartbeat` does (6.6 item 5's residual). Its runs are offline.
  - N-279 (19): Group B's files (5B, 6TK, N04, N08) are audited for the `env_token` counting fault before each file's first result. That is not a commit of M09-07; 5B and N04 run here in place, which is not a result.
  - N-279 (1), (2), (3), (17), (18), (21), N-280, N-282, N-283 (6), N-284, N-286, N-287, N-289, N-290, N-292: their deadlines are C03's work list, W-C02-14's first run, M09-08, M09-12, W-C02-10's sampling call, the first `.py` copy, the first migration adding a role class, a test file's first result or copy, verdict (ii), M09-09, each break's first run and the pull requests that copy F05, F08 or 5C. None falls at M09-07's commit. N-285 (1), N-290 (1) and N-291 bear on tests that call M09-07's functions; 8.4 says what they mean here.
- **Appendix B principle 3** binds `record_finding` and `register_artifact`, which write revision 1 of a record (no reason: there is no earlier revision), and the references every function here reads: an effect names its work item's revision (R2-1), a review its target's and each basis entry's (8.2 item 4), and `accept` compares them with the current revisions (8.2 item 6). `review_finding`, `record_verdict` and `accept` write state or records without revisions.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0907` at `69d3632`, clean before this work. The runs were made with M09-07, EV13's section 20 and the raw files uncommitted (O, `56_git_hashes.txt`). Bytes run: M09-07 `9677e7b3794eca13e4c059f27218fd10a9f74c9c132260643b419825621983d7`; the self-check `…/scratchpad/m0907_run/fn_check.sql` `7975085a01edf8647df355772698f32024b1bba82b2be4a9438d0dc392e49cde`; the break maker `…/scratchpad/m0907_run/brk.py` `60722b878b2f7000c5664988d9f5fe57ebae9b0490bb95605b9c4c21bae8bd62` (the other drivers' hashes are in file 56). EV13 with its section 20, as run and as written here: `c44c57ba20f68cea2c958db9e2841bb23fac27f307797c06fd8ff7c61159046b`. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 7: one throwaway PostgreSQL 16.15 cluster per run, unix socket only (in `…/scratchpad/m7s`, short enough for the 107-byte socket limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, `13_stop.txt` and `54_breaks_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: M09-02's `setup.sql`, a byte-identical copy (`fa2a9cfa…9783`). The break runs copy each fresh database from one of two template databases (`t18`, the eighteen migrations before M09-07; `t19`, all nineteen), so no break leaves anything for the next. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `69d3632`; EV13 with Revisions 1 and 2, its corrections 15 to 19, and its section 20 (for M09-07's checker) |
| Input | The nineteen migrations (the branch's eighteen and M09-07); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `tests/C02/W-C02-07/job/` and T-W14-FN's, and T-W07-CONC's program `job/w07_conc_claim_and_cycle.py`, run in place; the producer's self-check; twenty-five break copies of M09-07 made outside the repository (`…/scratchpad/m0907_brk/`, by `brk.py`); thirteen merged break patches of `tests/C02/W-C02-07/breaks/` applied in place on the throwaway cluster (8.5, runs 40 to 52) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m07_offline_01_init_setup.txt` to `…_56_git_hashes.txt`, written directly by `…/scratchpad/m0907_run/rerun.sh` (01 to 13), `brk.sh` (14 to 54) and `final.sh` (55, 56). Every file but `56` passed through `scrub.py`, M09-05's filter, which reads the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time and replaces each claim-format and each environment-format string with a fixed label. Each file ends `claim-format strings replaced 0; environment-format strings replaced 0` (55 of 55). File 55 scans files 01 to 54 again with the same finders: `54 files; claim-format 0; environment-format 0`. Files 12 and 54 scan the cluster's server log: `438 lines; claim-format 0; environment-format 0` and `1068 lines; claim-format 0; environment-format 0`. File 56 holds hashes and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09) and the break copies (15 to 39) are the producer's own; the merged break patches (40 to 52) and the merged program (10) are the test designers' |

### 8.1 What was built, object by object

All in M09-07, in this order: the seven functions of EV13 2.6, and their grants. No table, type or `devos_private` function is added. M09-01 to M09-06 are not changed. Their helpers are called: `caller_role_class`, `write_event`, `reject`, `scope_within`, `check_claim` and `ready_value`.

**The form every function has** is M09-03's to M09-06's (4.1, 5.1, 6.1, 7.1):
- the derivation first;
- the read block with steps (b) to (f). A decided refusal goes through `v_code`, `v_reason` and `P0D01`. Any other error is `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`;
- for the six state-changing functions, the write block, where an error is `write_failed`, but `P0D02`; `read_review` has none;
- one per-call row by `reject` after a refusal;
- fixed reasons.

O (`08_catalog.txt`): each of the seven has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, ACL `{postgres=X/postgres,anon=X/postgres}`.

**Parameters.** The names are those of EV13 2.6 and README 8.1, so named calls bind: `record_finding(p)`, `review_finding(finding_id, revision, status)`, `register_artifact(claim_token, p)`, `open_review(p)`, `record_verdict(p)`, `accept(verdict_ref, accepted_use)`, `read_review(review_id)`. The bodies read them through `ALIAS FOR $n` (N-288). Merged patches that rename one of these functions and wrap it: B-N09-1, B-N25-1, B-N04-3, B-N17-1, B-5C-1, B-F05-1, B-F08-1 to -4, B-6RG-1, B-N01-2, B-N29-1, B-5D-4, B-FGFIND-1 and -2, B-6ST-2 and -3. Under B-N09-1 and B-N25-1 the renamed bodies kept working (runs 44, 45).

**References these functions read** (EV13 20 (4), (6)). A review's target and basis entries, and a verdict's criterion when it is a uuid, are looked up in the fourteen families of M09-06's `relate` by one `union all` (M09-07:848-862, :1256-1270), with the revision rule of M09-06 (revisioned families need an existing revision; the others take none). None of the seven names the exam table (`TX-no-exam-table`; file 56: `M09-07 lines naming the exam table: 0`), so T-W07-N08's finder takes in none of them, and an exam record is, for every class, a record these functions cannot find (`OR-target-exam-as-none`).

**The role lists against the merged widening patches.** B-5B-1, B-5B-3 and B-N04-1 widen a role list by rewriting every quoted `'devos_denetim'` in the function's text. `accept` and `read_review` name the audit class a second time, for the reviewer check and the sample rule, so there it is written in two pieces (`'devos_' || 'denetim'`, M09-07:1199, :1449), and the patches widen the gate alone (`TX-one-quoted-audit-class`; run 42: B-N04-1 turns exactly `N04-k2` and `5B-R07-accept-kur` red).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.record_finding(p jsonb)` (M09-07:46) | Roles `devos_calisma`, `devos_kurulum`. The form of 20 (1): six required strings; `not_recorded` in `counter_evidence_searched` (M09-07:123) or `changeable`: `invalid_field`; each span an object with a boolean `primary` and, when dated, a `read_at` date. Writes the Finding (`candidate`, `private_derived` by default), its revision 1 and `finding_recorded` (revision 1, the record's fields, keys without a value left out). Answer `{"status": "ok", "id", "revision": 1}` | 2.6's row with C-M07 (20 (1)); B 3.8, principles 10 and 12; DM-12, DM-25, DM-26; EV-C02-005 S4 |
| `devos_api.review_finding(finding_id uuid, revision integer, status text)` (M09-07:282) | Role `devos_denetim`. Order of 20 (2): `missing_field`; `invalid_field` for a status but `reviewed`, `accepted_for_use`, `stale`; the Finding `for update` (M09-07:352), `not_found`; `stale_revision` (M09-07:369); the exact repeat; `not_recorded`: `invalid_field` (M09-07:384); N09 for `accepted_for_use` of a changeable finding: no primary span (M09-07:426) or an undated one (M09-07:431), `invalid_field`; a partial span `could_not_check`. Writes the status and `finding_reviewed` (`status`, `previous_status`, `revision`). Refusal rows carry `finding_id` and the revision sent (only when it is at least 1). Answer `{"status": "ok", "id"}` | 2.6's row with C-M07 (20 (2)); B 3.8; DM-26; Appendix C N09; EV-C02-008 1.2 |
| `devos_api.register_artifact(claim_token text, p jsonb)` (M09-07:486) | Roles `devos_calisma`, `devos_kurulum`. Form, then `check_claim(token, work_ref, class, false)` (M09-07:597): every claim code of 2.4; `work_revision` naming none: `could_not_check`, earlier: `stale_revision` (M09-07:616); `ready_value(work, own claim)` (M09-07:622): `not_ready` (M09-07:628) or `could_not_check`; `scope_outside` (M09-07:641). Writes the Artifact, its revision 1 and `artifact_registered` with `{work_ref, work_revision, assignment_id, generation}`. Refusal rows carry `work_ref` and `work_revision`. Answer `{"status": "ok", "id", "revision": 1}` | 2.6's row with R2-1 and C-M07 (20 (3)); B 3.5, 3.10, principles 3, 4, 8; Appendix C F05, F08 (a), (c), (w); EV3 4.3 (S8 line 2) |
| `devos_api.open_review(p jsonb)` (M09-07:691) | Role `devos_denetim`. `kind` `sample`: `kind_not_allowed` (M09-07:759), before any other key; the form; a non-empty `basis_refs` of `{ref, revision}` (empty: `missing_field`, M09-07:818); the target and each basis entry a record with its revision (`could_not_check`); a revisioned target at its current revision, its row `for share` (M09-07:889-901), else `stale_revision` (M09-07:909). Writes the Review (`criterion` to `criterion_ref`; `reviewer_role_class` the token's; `reviewer_declared_session` as declared) and `review_opened`. Answer `{"status": "ok", "id"}` | 2.6's row with R1-7 and C-M07 (20 (4)); B 3.11 and section 4's Review row; EV-C02-008 2.2 condition 2 |
| `devos_api.record_verdict(p jsonb)` (M09-07:961) | Role `devos_denetim`. `review_ref` and `result` required; `result` one of four; the three lists arrays, default `[]`; the Review `for share` (M09-07:1044), `not_found`. Writes the Verdict and `verdict_recorded`. Answer `{"status": "ok", "id"}` | 2.6's row with C-M07 (20 (5)); B 3.11 |
| `devos_api.accept(verdict_ref uuid, accepted_use text)` (M09-07:1096) | Role `devos_denetim`. Order of 20 (6): `missing_field`; the Verdict, `not_found`; `verdict_failed` (M09-07:1178); the Review: reviewer class NULL `could_not_check` (M09-07:1194), not the audit class `verdict_missing` (M09-07:1199-1200); the use (M09-07:1211); the target (its family with a scope, M09-07:1284; its row `for update`, M09-07:1289-1301), the basis entries and the criterion, each stale at an earlier revision (M09-07:1328, `invalid_field`) or partial (`could_not_check`); the exact repeat (M09-07:1341). Writes the Acceptance (`current_evidence` the verdict), `accepted`, and on a Work target `acceptance_set` (M09-07:1374). Refusal rows carry `verdict_ref`. Answer `{"status": "ok", "id"}` | 2.6's row with C-M07 (20 (6)); B section 2, 3.11; Appendix C N25, N04; EV3 4.2; EV-C02-005 section 12 |
| `devos_api.read_review(review_id uuid)` (M09-07:1400) | All six classes, as a literal. `missing_field`; `not_found`; a Review without its kind `could_not_check`; a `sample` for a class but the audit one: `not_found`, the same reason text (M09-07:1449). Answer `{"status": "ok", "review", "verdicts"}`. Comment `devos:read …` | 2.6's row with C-M07 (20 (7)); section 4's row R12; EV-C02-008 1.4, 5.2 (a); DM-36 |
| Grants (M09-07:1476-1506) | `revoke all … from public` and from the four API roles where they exist, on all seven; `grant execute … to anon` on all seven; no type, no private function | 1 item 13; T-W08-PRIV's constraint |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the thirty-one `devos_api` functions.
- **Types.** No `devos_private` type has PUBLIC USAGE.
- **The literals**, as the break patches read them: `record_finding` and `register_artifact` hold `array['devos_calisma', 'devos_kurulum']`; `review_finding`, `open_review`, `record_verdict` and `accept` hold `array['devos_denetim']`; `read_review` the six.
- **The unqualified-name scan.** No hit in M09-07's seven functions; its four hits are section 3.1's.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** `affected_entities`, `deployment_drift`, `explain_paths`, `read_decision`, `read_review`, `ready_works`, `token_role_class` carry it.

### 8.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. No merged test is changed. EV13 section 20 (C-M07) states items 1 to 7 in the record itself.
1. **`record_finding`'s forms** (EV13 20 (1)): `not_recorded` refused in `counter_evidence_searched` too (B 3.8; 3.2's `transfer_finding` row), `changeable` a JSON string, each span an object with a boolean `primary` and, when dated, a `read_at` date (DM-26 (a)). An empty `counter_evidence_searched` is accepted: it is W-C02-10's format gate (`RF-counter-empty-left-to-the-gate`).
2. **`review_finding`'s N09 reads the spans' markers and dates, not `fresh_until`** (EV13 20 (2)). 2.6's row says "no `fresh_until` or no primary span". B 3.8 and DM-26 (b) read the spans, and T-W07-N09's N09-pos is accepted with no `fresh_until`. This takes the sources' side; under 2.6's wording N09's positive control would be refused. "Every primary span dated" is the stricter of two readings (`RV-N09-two-primary-one-undated`: `invalid_field`). No transition order between the three statuses is built (B 3.8 gives none).
3. **`register_artifact` re-checks readiness at the effect** (EV13 20 (3)): `ready_value` with the caller's own claim, after the claim and the revision. F08 (a) and 3.5 item 4 ask it; 2.6's row does not name it. It also refuses an effect under a paused Mission (`RA-mission-paused`: `not_ready`).
4. **`open_review`'s references** (EV13 20 (4)):
   - The target and each basis entry are records with the revision they need (`could_not_check` otherwise, R1-2).
   - A revisioned target must be named at its current revision, else `stale_revision` (chosen; a review judges the current revision, as an effect does).
   - `basis_refs` entries are `{ref, revision}` (B 3.11). An empty basis is `missing_field` (B section 4). Earlier basis revisions are accepted; `accept` judges them.
5. **`record_verdict`'s lists are arrays** (EV13 20 (5)): the table's checks require it, so a string `limits` is `invalid_field`.
6. **`accept`** (EV13 20 (6)):
   - **The audit verdict.** A Review whose `reviewer_role_class` is not `devos_denetim` is `verdict_missing`; NULL is `could_not_check`. Sources: B section 2, B 3.11, EV3 4.2, EV-C02-005 section 12, T-W07-N04's N04-T2.
   - **Staleness in full.** The use, the target's revision, every basis entry's revision and a record criterion's version; each stale one is `invalid_field` (B 3.11; N25). A non-record criterion is a residual (8.6).
   - **The target** must be of a family with a scope (Work, Mission, Finding, Artifact, Relation); another is `invalid_field` (`AC-decision-target`).
   - **The exact repeat** comes after every check.
   - **The Acceptance's fields** are chosen: `current_evidence` `["<verdict id>"]`, `owner_authority` NULL, `scope` the target's, `target_revision` the Review's.
7. **`read_review` withholds every `sample`** from every class but the audit one (EV13 20 (7)): C02's schema cannot yet tell a complete block, so a complete block's sample is delayed, never an open one shown. M09-06 did not withhold samples in `relate` and the walks (7.2 item 7); `read_review` returns the Review itself, which EV13 2.6's row names.
8. **Forms the record leaves open (chosen):**
   - Answers as 8.1.
   - Refusal rows: `review_finding` names the finding and revision, `register_artifact` the work item and revision, `open_review` the target, `record_verdict` the review, `accept` the verdict, `read_review` the review; `record_finding` none.
   - Events: `finding_recorded` and `artifact_registered` at revision 1; `finding_reviewed` at the current revision; `review_opened`, `verdict_recorded` and `accepted` without a revision (no revisions in their families); `acceptance_set` on the Work at its current revision.
   - Locks: `review_finding` the Finding `for update`; `register_artifact` through `check_claim` (`for share`); `open_review` the target's identity row `for share`; `record_verdict` the Review `for share`; `accept` the target's row `for update`.

Not departures, for the checker:
- `register_artifact` checks no Rule O: ownership was checked when the claim was taken (`claim`, 18 (2)), and the claim check binds the effect to that claim's class and work item.
- No function compares declared sessions (B 3.11's "the reviewing session cannot be the session that produced"): a declared session carries no authority (B principle 8). C03's audit environment or W-C02-10 carries that rule.
- DM-41's trigger, the sample's own rules and the format gates are W-C02-10's.

### 8.3 How W-C02-09's points are served by M09-07

- **Point 1.** A versioned file later than `20261019010001`, plain SQL, no `psql` meta-command, no backslash (O, `56_git_hashes.txt`: `backslashes in M09-07: 0`). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject`, on every refusal (`{"rejected": 1}` deltas);
  - F06's list: `read_review` carries the read marker; the other six are state-changing (`F06-list | ok | 31 devos_api functions (7 marked devos:read)`);
  - the claim expiry computed: `register_artifact` refuses a lapsed claim through `check_claim` (`RA-lapsed`: `claim_expired`).
  - Offline, `deployment_drift` reports `no_difference`, 19 of 19 (runs 04 and 11).
- **Point 2.** Thirty-one of the 55 `devos_api` functions now exist (seven here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (8.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the seven refuses a call with no token before any other check (`F06-refused:*` and `F06-read-refused:read_review` `ok`; the self-check's `*-no-token`; DM19B's `DM19B-accept-*`, `PASS (12/12)`). Each refuses a class not on its list with one per-call row: 5B rows R06, R07, R12 (`read_review`) and R25, every cell `ok`.
  - Fifth bullet. A declared role name changes nothing (`RF-pos-cal` sends `role_class` `devos_denetim` and `origin` `owner`: the event carries `devos_calisma` and `call`; `OR-pos` sends `reviewer_role_class` `devos_calisma`: the Review carries `devos_denetim`). A declared session is written as declared (`RF-event`, `RA-event`, `OR-row`).
- **Point 4** (the effects' claim refusals, now on an effect):
  - with another work item's claim: `RA-claim-of-another-item`, `RA-work-ref-names-nothing` (`claim_unknown`);
  - with no claim token: `RA-no-claim-token`, `RA-empty-claim-token` (`claim_missing`); an unknown one: `RA-unknown-claim-token`;
  - released, expired or revoked: `RA-released`, `RA-cancelled-item` (`claim_not_active`), `RA-lapsed` (`claim_expired`), `RA-revoked`;
  - an earlier generation: `RA-earlier-generation` (`claim_generation`); an earlier epoch: `RA-earlier-epoch` (`claim_epoch`);
  - S8 line 2: `RA-claim-class`, `RA-kur-claim-under-cal` (`claim_class`).
  - T-W07-CONC's `CONC-late` (a late effect racing `revoke_claim` and a new hard dependency) `ok`, in the merged program's `PASS (8/8)` (run 10).
  - T-W07-N17 and T-W07-5C do not reach their cases (8.4).
- **Point 5.**
  - Each state-changing function writes its event in the same transaction, with the token's class (`RF-event`, `RV-state`, `RA-event`, `OR-event`, `VD-row`, `AC-events`: this transaction, the token's class, `call`). F06's `F06-event:record_finding` and `F06-event:review_finding` `ok`.
  - An exact repeat writes nothing: `RV-repeat`, `AC-repeat` (`ok repeat`, `{}`); `F06-repeat:review_finding` `ok`.
  - A failure planted mid-transaction leaves no half state and no orphan event: `RF-write-failed`, `RF-write-event-failed`, `RV-write-failed`, `RA-write-failed`, `RA-write-event-failed`, `OR-write-failed`, `VD-write-failed`, `AC-write-failed`, `AC-write-work-failed` (only the refusal row is added); `*-write-P0D02`: `could_not_check` with its reason.
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass:
  - references: `RA-no-work-revision`, `-work-revision-null`, `-revision-beyond`; `OR-target-random`, `-exam-record`, `-no-revision`, `-revision-beyond`, `-need-with-revision`, `OR-basis-random`, `-no-revision`, `-exam-record`; `AC-target-names-nothing`, `-basis-empty`, `-basis-bare-string`, `-criterion-names-nothing`;
  - partial records: `RV-span-partial`, `-span-date-unreadable`; `AC-no-reviewer`; `RA-readiness-unknown`;
  - unreadable tables: `RV-unreadable`, `RA-claims-unreadable`, `-epoch-missing`, `-revisions-unreadable`, `OR-targets-unreadable`, `VD-reviews-unreadable`, `AC-reviews-unreadable`, `RR-unreadable`.
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the seven, run in place (runs 06, 07, 10):
    - **T-W07-N09 `PASS (5/5)`**, its C02 part whole;
    - **T-W07-DM19B `PASS (12/12)`**;
    - **T-W07-CONC `PASS (8/8)`**, its program run in place for the first time (`CONC-claim`, `-cyc2`, `-cyc4`, `-late`, `-err`, `-overlap`, `-pos`, `-tokens`): both of Concurrency's claims, with the connections and repetitions W-C02-07 wrote;
    - **T-W07-ROC runs for the first time**: 81 of 83 `ok`, `FAIL (1 bad, 1 could not check, of 83)` (8.4);
    - 5B: the cells of R06, R07, R12 and R25 `ok`; `COULD NOT CHECK (7 of 187 could not be checked)` for rows whose functions are not built; none `bad`;
    - F06: the seven's refused and read cases `ok`, `record_finding`'s and `review_finding`'s event cases and `review_finding`'s repeat `ok`; in all `FAIL (1 bad, 16 could not check, of 82)` (8.4);
    - N25 `FAIL (1 bad, 0 could not check, of 5)`, DM19 `FAIL (1 bad, 0 could not check, of 5)`, N04 `COULD NOT CHECK (5 of 19 could not be checked)` (8.4);
    - DM07, DM34, 6TK, K05, IDC, 5A and DM02 pass again.
  - Their copies are a later pull request's (R:247; EV13 section 11).

### 8.4 What M09-07 does not yet serve

- **Merged tests that cannot pass on a correct build** (EV13 20 (8)), for the test designer:
  - **T-W07-N25** (W9 point 8's N25): its fixture Review has no `reviewer_role_class` and a `target_ref` that names no record (`job/w07_n25_verdict_staleness.sql:280-283`). So `N25-pos` is `could_not_check` and `bad`, and `N25-a` to `-d` pass for the wrong reason: they are refused before the staleness checks. The rules they test are shown by the self-check (`AC-N25-a` to `-d`, `AC-N25-pos`) and by breaks b19 and b20.
  - **B-N25-1** writes an Acceptance with `scope` `w07_break SYNTHETIC`, which `acceptance_scope_check` refuses (run 45: `raised 23514 … acceptance_scope_check`), so it cannot be shown on the merged schema.
  - **T-W07-DM19**'s `DM19-pos` has the same fixture, and an empty basis (`job/w07_dm19_rejected_attempt_survives.sql:344-346`): `bad`.
  - **T-W07-F06**: the `accept` recipe (the same fixture), the `open_review` recipe (no `independence_level`, an empty `basis_refs`, `:459-460`), the `record_verdict` recipe (`limits` a string, `:555-556`) and the `register_artifact` fixture claim (a planted Mission with no creation event, N-285 (1)) are `could_not_check`. `F06-role-token` is `bad`, M09-06's (7.4).
  - **T-W07-N04**: `N04-p3` and `N04-p4` call `record_verdict` and `accept` with neutral arguments (no `result`; no verdict), `could_not_check`. Part T needs the ledger transfer's functions.
  - **B-N04-3** reads `devos_private.verdict.role_class`, which does not exist. Under it `N04-b1`, `-b2`, `-e2` and `-k2` raise 42703 and turn red, not `N04-T2` (run 43).
  - **T-W07-N17** stops at its `-pre` line: its `devos_kurulum` claim on W3 is refused `not_owner`, since W3 lies under the test Mission, not the installation's (M09-05's `claim`, EV13 18 (2)). Until W3 lies under the installation's Mission (hook `installation_mission`), N17, and so B-N17-1 and B-5C-1, cannot run.
  - **T-W07-ROC**:
    - `ROC-o-retract_relation-kur-transferred` is `bad`, M09-06's reading (7.4).
    - `ROC-x-o-event-unreadable` is `could_not_check`: its call helper issues the token after `event` is revoked from the owner, so `issue_env_token` cannot write its event (the test's own fault). So B-ROC-3 cannot turn that case red (run 50).
    - B-ROC-1 and B-ROC-2 turn every `cancel_work` case red (runs 48, 49): N-288's fault in M09-04, as CHK-C02-091 finding 9 found.
- **The staged files that call these functions but need a later function stop at their `-pre` line** (run 06): 5C, 6RG, 6ST, F01, F05, F07, F08 and N29 need `prepare_operation`; N08 (exam records) `record_eval_run`; 5D, FGFIND, N01, N02, N03, N28 (sample exemption), T31 and DM47 W-C02-10's tables; T-W14-FN the ledger transfer's group. So W9 point 8's F01, F05, F07, F08, N17 and 5C, and the merged breaks B-N17-1, B-5C-1, B-F05-1, B-F08-1 to -4, B-6RG-1 (with N-290 (1)'s fault in five of them), B-N01-2, B-5D-4, B-FGFIND-1 to -3, B-6ST-2, -3 and B-N29-1, are "could not check", not counted.
- **The merged breaks run here** (runs 40 to 52, each on a fresh copy of `t19`; run 53 is their unpatched control):
  - B-5B-1: `5B-R07-record_verdict-cal`, `N04-a1`, `-a2`, `-c1`, `-c2` red. `N04-e1-record_verdict`, in its red list, does not exist: `record_verdict` has no session argument.
  - B-5B-3: `5B-R25-review_finding-cal` red.
  - B-N04-1: `N04-k2`, `5B-R07-accept-kur` red.
  - B-N09-1: `N09-a` to `-d` red.
  - B-DM19-1: `DM19-a`, `-c`, `-d` red.
  - B-DM19B-1: the ten burst cases red.
  - B-ROC-2: its five named cases red, beside the `cancel_work` cases above.
  - B-ROC-3: its named cases red but `ROC-x-o-event-unreadable`.
  - B-CONC-2: `CONC-cyc2`, `-cyc4` red.
  - Not shown: B-CONC-1 (`CONC` stays `PASS (8/8)`: the `(work_ref, generation)` constraint, N-287 (2)); B-N04-3 and B-N25-1 (above).
- **W-C02-10's** DM-41 trigger: T-W07-N28's `N28-a`, `-b` stay `bad` (run 06); `open_review` exists now, so those cases reach the trigger W-C02-10 builds.

### 8.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0907` at `69d3632`, with M09-07, EV13's section 20 and the raw files untracked. The main run started 2026-10-19T01:18:29Z and ended 01:18:48Z, on one cluster (`…/scratchpad/m0907_run/rerun.sh`). The break runs started 01:18:48Z and ended 01:20:02Z, on a second cluster (`…/scratchpad/m0907_run/brk.sh`).
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `setup.sql` and `catalog.sql` are `…/m0906_run/`'s, changed only in their paths (the clone `prd10`, the cluster under `…/m0907_run/pg`, the socket in `…/scratchpad/m7s`) and one printed word; `setup.sql` is byte-identical. `fn_check.sql` keeps M09-06's harness (`m_call`, `m_case`, `m_rec`) with M09-07's counted tables, claim tokens bound from transaction-local settings, and M09-07's cases. `brk.py`, `brk.sh`, `final.sh` follow M09-06's forms; `brk.sh` copies each database from a template.
- **Trial runs.** Trial runs came before, none of them filed: the self-check alone three times (`…/m0907_run/trialfn.sh`), the main run once (`…/m0907_run/trial1`) and the break runs once (`…/m0907_run/trial2`).
  - The first self-check trial stopped on an ambiguous variable in the harness.
  - The second had 33 red cases. Thirty-one were the harness's: its claim helper stored the claim's id under the work item's key. One was a check that read a refusal row its own undone subtransaction had removed.
  - One was a fault in M09-07, found by `RV-revision-zero`: `review_finding`'s refusal row wrote a `target_revision` of 0, which `rejected_attempt`'s check refuses, so the call raised 23514. M09-07 now names the revision only when it is at least 1.
  - The third trial went green. The filed break runs give the same summary as the trial's, line for line (compared after the run).

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the eighteen migrations before M09-07, each `[exit 0]` with its history row (36 `[exit 0]` lines).
- **03, M09-07:** `CREATE FUNCTION` ×7, `COMMENT`, `REVOKE` ×7, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 11:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 19, "migrations_expected": 19`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result):
  - `W07_N09_FINDING_GATE PASS (5/5)`, `W07_DM19B_BURST_COUNT PASS (12/12)`;
  - `W07_ROC_OWNERSHIP_AND_CLAIM_CLASS FAIL (1 bad, 1 could not check, of 83)`: `ROC-o-retract_relation-kur-transferred | bad | … not_owner`, `ROC-x-o-event-unreadable | could_not_check | … test_cnc` (8.4);
  - `W07_N25_VERDICT_STALENESS FAIL (1 bad, …, of 5)`: `N25-pos | bad | returned {"reason": "review: its reviewer's role class is missing (partial)" …}`; `W07_DM19_REJECTED_ATTEMPT_SURVIVES FAIL (1 bad, …, of 5)`: `DM19-pos | bad` (the same reason);
  - `W07_F06_STATE_CHANGE_EVENT FAIL (1 bad, 16 could not check, of 82)`, with `31 devos_api functions (7 marked devos:read)`; `F06-event:record_finding | ok`, `F06-event:review_finding | ok`, `F06-repeat:review_finding | ok | exact repeat …`, `F06-read-accepted:read_review | ok`; `F06-event:accept`, `:open_review`, `:record_verdict`, `:register_artifact` `could_not_check` (8.4);
  - `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (7 of 187 could not be checked)`, none `bad`, for example `5B-R07-accept-kur | ok | x cell: … code role_class_not_permitted` and `5B-R25-review_finding-den | ok | v cell: … code invalid_field`;
  - `W07_N04_SELF_APPROVAL COULD NOT CHECK (5 of 19 could not be checked)`, none `bad`;
  - `W07_DM07_HEARTBEAT PASS (8/8)`, `W07_DM34_MISSION_SCOPE PASS (10/10)`, `W07_6TK_TOKEN_REASONS PASS (32/32)`, `W07_K05_MANY_PATHS PASS (6/6)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`;
  - as before M09-07: `W07_F04_AFFECTED_RECORDS COULD NOT CHECK (1 of 22 …)`, `W07_REL_RELATION_STATUS FAIL (2 bad, …)`, `W07_5A_POSITIVE_CONTROL FAIL (1 bad, …)` (7.4), `W07_DM11_ANSWER_REVISION FAIL (5 bad, …)` and `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, …)` (W-C02-10's);
  - every other file `COULD NOT CHECK` on its `-pre` line (8.4); run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 8.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 M09-07; one transaction rolled back): `M0907_FUNCTIONS PASS (266/266)`.
  - The cases: 43 for `record_finding`, 37 for `review_finding`, 60 for `register_artifact`, 41 for `open_review`, 18 for `record_verdict`, 33 for `accept`, 28 for `read_review` and 6 for the text.
  - Each compares the answer's code and the change of eleven tables; the state cases read the rows after.
  - Among them: `RV-N09-a-undated` to `-d-date-on-secondary` and `-two-primary-one-undated`: `invalid_field`; `RV-N09-pos-dated-primary`: `ok`; `RA-not-ready-new-dependency`: `not_ready`, `RA-ready-dependency-resolved`: `ok`; `RA-stale-revision`: `stale_revision`, `RA-current-after-revision`: `ok`; `OR-kind-sample`: `kind_not_allowed`; `OR-target-exam-as-none`; `AC-transfer-copy`: `verdict_missing`; `AC-N25-a` to `-d`, `AC-target-revised`: `invalid_field`; `AC-N25-pos`: `ok`, `{"acceptance": 1, "event": 2}`; `AC-repeat`: `ok repeat`, `{}`; `RR-sample-<class>-as-none` for the five classes, `RR-sample-devos_denetim`: `ok`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, `artifact_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `review`.
- **10, T-W07-CONC's program, run in place** (input: the break harness's form, four keys with null values; its synthetic fixtures committed on the throwaway cluster): `fixtures: one owner-planted Decision of class batu with its revision, one Mission and 160 work items …`, the eight cases `ok`, `W07_CONC_CLAIM_AND_CYCLE PASS (8/8)`, `[conc exit 0]`.
- **12:** the server log, `438 lines; claim-format 0; environment-format 0`. **13:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **14:** the break cluster's setup, the templates `t18` and `t19` (`[template … exit 0]`), and `brk.py`: 25 `made (one replacement in devos_api.<fn>)`.
- **15 to 39, the break copies**, each in a fresh database copied from `t18` (`[apply exit 0]`), then the self-check and the staged files that call the function broken:
  - **b01**, `counter_evidence_searched` `not_recorded` admitted: `FAIL (1 of 266)`, red `RF-counter-not_recorded`.
  - **b02**, `changeable` `not_recorded` admitted: red `RF-changeable-not_recorded`.
  - **b03**, no primary span accepted: red `RV-N09-b-secondary-only`, `-c-no-span`, `RV-N09-status-kept`; merged **`N09-b`, `N09-c` `bad`**.
  - **b04**, an undated primary span accepted: red `RV-N09-a-undated`, `-d-date-on-secondary`, `-two-primary-one-undated`, `RV-N09-status-kept`; merged **`N09-a`, `N09-d` `bad`**.
  - **b05**, `not_recorded` moves: red `RV-not_recorded-changeable`, `-counter`.
  - **b06**, `review_finding`'s `stale_revision` removed: red `RV-stale`, `RV-revision-beyond` and three others.
  - **b07**, an absent `work_revision` read as the current one: red `RA-no-work-revision`, `-work-revision-null`, `-no-work-revision-reason`.
  - **b08**, `register_artifact`'s `stale_revision` removed: red `RA-stale-revision`, `-stale-after-revision`.
  - **b09**, the readiness re-check removed: red `RA-not-ready-new-dependency`, `-readiness-unknown`, `-mission-paused`, `TX-claim-before-readiness`.
  - **b10**, the scope check removed: red `RA-scope-outside`, `-scope-prefix-not-label`.
  - **b11**, the claim of any work item admitted: red `RA-claim-of-another-item`, `-work-ref-names-nothing`.
  - **b12**, the claim token put into `artifact_registered`: red `RA-event` (no staged file is run under this break, so that no output can print an event's payload).
  - **b13**, `kind_not_allowed` removed: red `OR-kind-sample`, `-kind-sample-bad-target`.
  - **b14**, a stale target admitted: red `OR-target-stale`.
  - **b15**, the reference check removed: red `OR-target-random`, `-exam-record`, `-exam-as-none`, `-no-revision`, `-revision-beyond`, `-need-with-revision`, `OR-basis-random`, `-no-revision`, `-exam-record`.
  - **b16**, an empty basis admitted: red `OR-basis-empty`.
  - **b17**, `record_verdict`'s result check removed: red `VD-result-form`.
  - **b18**, a failed verdict accepted: red `AC-fail`, `AC-indeterminate` and two others.
  - **b19**, another use accepted: red `AC-N25-c-other-use`, `AC-same-verdict-other-use` and two others.
  - **b20**, a stale verdict accepted: red `AC-N25-a-first-basis-revised`, `-d-second-basis-revised`, `-b-criterion-revised`, `AC-target-revised`.
  - **b21**, the transfer's copy accepted as an audit verdict: red `AC-transfer-copy`.
  - **b22**, `accept`'s repeat removed: red `AC-repeat`.
  - **b23**, the Work's acceptance not set: red `AC-state`, `AC-events`, `AC-basis-without-revisions` and two others.
  - **b24**, samples not withheld: red the ten `RR-sample-<class>` and `-as-none` cases.
  - **b25**, verdicts dropped from `read_review`: red the seven `RR-*-answer` cases.
  - So each check turns red when its rule is removed. N09 caught b03 and b04; the self-check alone caught the other twenty-three, because the merged files that would test them do not reach those rules on a correct build (8.4).
- **40 to 52, merged break patches**, each in a fresh database copied from `t19` (`[patch exit 0]`): as 8.4 lists.
  - **40, B-5B-1:** `W07_5B_AUTHORIZATION_MATRIX FAIL (1 bad, …)`, `W07_N04_SELF_APPROVAL FAIL (4 bad, 5 could not check, of 19)`.
  - **41, B-5B-3:** `5B-R25-review_finding-cal | bad`.
  - **42, B-N04-1:** `N04-k2 | bad`, `5B-R07-accept-kur | bad`.
  - **43, B-N04-3:** `N04-b1`, `-b2`, `-e2`, `-k2` `bad`, each `err 42703 column v.role_class does not exist`.
  - **44, B-N09-1:** `W07_N09_FINDING_GATE FAIL (4 bad, 0 could not check, of 5)`.
  - **45, B-N25-1:** `N25-pos | bad | raised 23514 … acceptance_scope_check`; `N25-a` to `-d` stay `ok`.
  - **46, B-DM19-1:** `DM19-a`, `-c`, `-d` `bad` (and `DM19-pos`, as unpatched).
  - **47, B-DM19B-1:** `W07_DM19B_BURST_COUNT FAIL (10 bad, 0 could not check, of 12)`.
  - **48, B-ROC-1:** `FAIL (13 bad, 1 could not check, of 83)`, the twelve `cancel_work` cases and M09-06's case. **49, B-ROC-2:** `FAIL (16 bad, 3 could not check, of 83)`. **50, B-ROC-3:** `FAIL (9 bad, 1 could not check, of 83)`.
  - **51, B-CONC-1:** `W07_CONC_CLAIM_AND_CYCLE PASS (8/8)`. **52, B-CONC-2:** `FAIL (2 bad, 0 could not check, of 8)`, `CONC-cyc2`, `CONC-cyc4`.
- **53, the unpatched control** of the same files on a fresh copy of `t19`: as run 06 and run 10 (N09 and DM19B `PASS`, N25 and DM19 one `bad` each, ROC `FAIL (1 bad, 1 could not check, of 83)`, CONC `PASS (8/8)`).
- **54:** the server log, `1068 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **55:** files 01 to 54 scanned with the finders of `scan_patterns.json`: `54 files; claim-format 0; environment-format 0`.
- **56:** the hashes in the envelope; `backslashes in M09-07: 0`; `M09-07 lines naming the exam table: 0`; `M09-07 strings found by either token finder: m0907 scan: 1 files; claim-format 0; environment-format 0`; `M09-07 lines holding either marker whole: 0`; `git status --porcelain`: EV13 modified, M09-07 and the raw files 01 to 56 untracked, before this section was written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 8.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-N25 and T-W07-DM19: a fixture Review with `reviewer_role_class` `devos_denetim`, a target that names a record at its revision, and (DM19) a basis. Until then `N25-pos` and `DM19-pos` cannot pass, and `N25-a` to `-d` pass for the wrong reason. B-N25-1 needs an Acceptance whose `scope` the table admits.
   - T-W07-F06's `accept`, `open_review` and `record_verdict` recipes (8.4), and its claim-bearing fixtures (N-285 (1)).
   - T-W07-N04's `N04-p3` and `N04-p4` arguments; B-N04-3's `verdict.role_class`.
   - T-W07-N17's W3 under the installation's Mission.
   - T-W07-ROC's `ROC-x-o-event-unreadable`: the token issued before the revoke.
2. **For the executor** (reported, not done):
   - **A criterion that is not a DevOS record** (a document path) is not compared by `accept`, so its staleness rests on the audit environment (EV13 20 (6)). If C03's reviews name their criteria by path, a change of the criterion goes unseen by the database: a record form for criteria (an Artifact at its commit) or a stated residual, before C03's audit work uses `accept`.
   - **A `sample` Review's verdict cannot be accepted** until W-C02-10 gives the taking a form that sets its reviewer fields (EV13 20 (6); EV-C02-008 2.2).
   - **No transition order for a Finding's status** (8.2 item 2): B 3.8 gives none; `review_finding` can move `accepted_for_use` back to `reviewed`.
   - **N-288's fix for `cancel_work`** is due before ROC's first result. ROC now runs, and B-ROC-1 and B-ROC-2 show the fault on every `cancel_work` case (runs 48, 49).
3. **For the checker of verdict (i):**
   - EV13 section 20 with its *[C-M07]* marks;
   - 8.2's departures, chiefly 2, 3, 4 and 6;
   - the self-check and the break copies, which are the producer's own.
4. **For the producers of M09-08, M09-12 and W-C02-10:**
   - `prepare_operation` and `record_attempt` call `check_claim`, then `ready_value` with the caller's own claim, as `register_artifact` does (M09-07:597, :622).
   - `transfer_review` and `transfer_acceptance` (M09-12) keep the transfer's copies `devos_kurulum`'s, so that `accept` refuses them as no audit verdict (8.1).
   - W-C02-10 replaces `read_review` with the sample block's state (EV-C02-008 5.2 (d)), and gives the sample's taking its form.
5. **Residuals:**
   - The claim token travels as `register_artifact`'s first parameter, as 6.6 item 5 says for `heartbeat` and `release`.
   - `open_review` and `accept` look a record up in fourteen tables per reference (one `union all`). That is a cost at C02's sizes.
   - An unreadable table among the fourteen makes every `open_review` and every `accept` `could_not_check` (`OR-targets-unreadable`, `AC-reviews-unreadable`). That fails closed.

## 9. M09-08: external effect

The producer's record of `supabase/migrations/20261019050001_w09_external_effect.sql` (M09-08). It was written on branch `claude/c02-w09-m0908` at `32fbb4e5613b279384e0a8ca3c283dd9385ba8f0`: `main` `6fd25a2` with M09-01 to M09-06, plus M09-07 (`20261019030001_w09_knowledge_product_review.sql`) from its pull request #370, which has since merged (`0cf5946`), with `32fbb4e` its head. M09-08 builds on M09-07 and does not change it. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **A restart.** An earlier producer of the same task was lost when the container restarted, before it reported. It left an uncommitted start of EV13 section 21, an untracked draft of M09-08, its drivers and a stopped cluster. This producer deleted the cluster's data directory unread, took the draft and the section as a hint, read every line it kept against the sources, and ran every test below itself on fresh clusters. Nothing here is from the earlier producer's runs. One change was made to the draft's SQL (9.2 item 10); the rest was kept after reading.
- **Citations.** Lines cited as EV13:n and B:n are at `32fbb4e`, with EV13's section 21 added. M09-08 means the file above, and M09-08:n a line of it. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 21 first.** EV13 gained "21. Correction, 2026-10-19 (N-279 (17); M09-08)". Its part 1, marked *[C-17]*, is N-279 (17)'s correction: an effect class the table does not hold is `could_not_check`, and the code `effect_class_unknown` is withdrawn. Its marks are in section 1 item 14, 2.7's `prepare_operation` row, section 12 and section 14. Its part 2, marked *[C-M08]* in the four rows of 2.7, states the forms 9.2 lists. M09-08's checker judges both parts.
- **The note items that bind M09-08's commit, checked on the branch before the SQL was kept** (`plan/work/C02.md`):
  - **N-279 (17)**, "the record is corrected before M09-08". **Met** by EV13 21 part 1, and built (M09-08:313-316; `PO-class-unknown`, `PO-class-row-deleted`; T-W07-6RG's 6RG-c1 `ok`). It is for M09-08's checker to judge.
  - **N-279 (10)**, first part: `prepare_operation`'s `work_revision`, "before the first commit of the migration that builds the function". **Met.** EV13 R2-1 decided it, CHK-C02-081 judged it, and M09-08 builds it (absent: M09-08:195-198; naming none or an earlier one: M09-08:331-340).
  - **N-279 (12)**: `prepare_operation`'s `target_ref` and the form of F08's inputs, before the first commit of the migration that builds the function. **Met.** EV13 R2-3 and R2-4 decided them; M09-08 builds the target (M09-08:361-416) and the inputs (M09-08:487-501). F05-pos3, -b, -d and F08-pos5, -d are `ok` (run 06).
  - **N-288** (parameters named through the function's name) binds M09-08's form. **Met:** every body reads its parameters through `ALIAS FOR $n` (M09-08:72-73, :599-600, :899, :1088). Self-check `TX-alias`.
  - **This record's 3.5 item 4, 6.6 item 4 and 8.6 item 4**, for this producer. "Call `check_claim`, then `ready_value(work, assignment_id)` at an effect" is **met** in both functions that take a claim (M09-08:253, :350; :670, :784; `TX-claim-before-readiness`; breaks b13, b26). "A claim's token is never put into an effect's event or refusal row" is **met** (`PO-event`, `RT-event`, `PO-rows-hold-no-token`; break b23). "Map a helper's NULL to `could_not_check` with the caller's `v_check`" is **met** (`PO-readiness-unknown`, `RO-mission-event-missing`).
  - **N-281** (no real-path `claim` until it is met). M09-08 makes no claim and returns no token. `prepare_operation` and `record_attempt` take one as a parameter, as `register_artifact` does (8.6 item 5's residual). Its runs are offline.
  - **N-290 (1)**: B-F08-1 to -4, B-5C-1 and B-F05-1 are revised before each break's first run and before the pull request that copies F05, F08 or 5C. That is not a commit of M09-08. They were run here in place, which is not a first run in N-290's sense (W-C02-13's); 9.4 says what they showed.
  - **N-285 (1), N-291 and N-293** (planted Missions without a creation event): reported here as they reach M09-08's functions (9.4); Rule O is not bent for them.
  - **N-279 (1)**, a writer of `execution`, and the open writer of the work item's `effect` axis (9.6), are C03's work list and the executor's, not M09-08's commit.
  - **N-279 (18), (19), (21), N-282, N-283 (6), N-284, N-286, N-287, N-289, N-292**: their deadlines are M09-12, each Group B file's first result or copy, W-C02-10's sampling call, the first migration adding a role class, a test file's first result, verdict (ii) and M09-09. None falls at M09-08's commit.
- **Appendix B principle 3** binds `prepare_operation`: it writes no revision of a record (an Operation has none), and every reference it reads carries the revision it means: the work item's (R2-1), the target record's (R2-3) and each read-set entry's (R2-4). `record_attempt` compares those stored revisions with the current ones. `record_observation` appends; `operation_state` reads.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0908` at `32fbb4e`, with EV13's uncommitted start of section 21 and the untracked draft left by the earlier producer. The runs were made with M09-08, EV13's section 21 and the raw files uncommitted (O, `71_git_hashes.txt`). Bytes run: M09-08 `80bdb639280843826adc20c29d87ca5df5bfcc2f0affd6e2aeecf45ca8d1fccc`; the self-check `…/scratchpad/m0908_run/fn_check.sql` `3951f0ac2e72cbd61c05096392b79b5bd37f40dd696aec0f6fe54f09ec7af2b7`; the break maker `…/scratchpad/m0908_run/brk.py` `8af1e30969558bf1ef25f872f64a3684ea4ef077c29151e59b1640bda0a16803` (the other drivers' hashes are in file 71). EV13 with its section 21, as written here: `f54fb0e4028a15f9030a8e56e38ccfc6334e797de6bbb63239583cb60cd9cb3f`. EV13's last change (one phrase of 21 (10), labelling an SQLSTATE as inference) came after the database runs, which do not read it; files 70 and 71 were written after it. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 8: one throwaway PostgreSQL 16.15 cluster per run, unix socket only (in `…/scratchpad/m8s`, short enough for the 107-byte socket limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, `14_stop.txt` and `69_breaks_stop.txt`: `[cluster directory deleted: yes]`). Stand-ins: M09-02's `setup.sql`, a byte-identical copy (`fa2a9cfa…9783`). The break runs copy each fresh database from one of two template databases (`t19`, the nineteen migrations before M09-08; `t20`, all twenty), so no break leaves anything for the next. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `32fbb4e`; EV13 with Revisions 1 and 2, its corrections 15 to 20, and its section 21 (for M09-08's checker) |
| Input | The twenty migrations (the branch's nineteen and M09-08); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `tests/C02/W-C02-07/job/` and T-W14-FN's, and T-W07-CONC's program `job/w07_conc_claim_and_cycle.py`, run in place; T-W07-F01's staged file once more after the global authority epoch is set to 2; the producer's self-check; thirty-seven break copies of M09-08 made outside the repository (`…/scratchpad/m0908_brk/`, by `brk.py`; deleted after the run, since `brk.py` makes them again byte for byte from M09-08: the SHA-256 over the 37 files' hashes was `e0dc2ef9…12d5` both times); fourteen merged break patches of `tests/C02/W-C02-07/breaks/` applied in place on the throwaway cluster, and B-F01-6 once more at epoch 2 (9.5, runs 53 to 67) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m08_offline_01_init_setup.txt` to `…_71_git_hashes.txt`, written directly by `…/scratchpad/m0908_run/rerun.sh` (01 to 14), `brk.sh` (15 to 69) and `final.sh` (70, 71). Every file but `71` passed through `scrub.py`, M09-05's filter, which reads the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time and replaces each claim-format and each environment-format string with a fixed label. Each such file ends `claim-format strings replaced 0; environment-format strings replaced 0` (70 of 70). File 70 scans files 01 to 69 again with the same finders: `69 files; claim-format 0; environment-format 0`. Files 13 and 69 scan the cluster's server log: `368 lines; claim-format 0; environment-format 0` and `497 lines; claim-format 0; environment-format 0`. File 71 holds hashes and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09) and the break copies (16 to 52) are the producer's own; the merged break patches (53 to 67) and the merged program (10) are the test designers' |

### 9.1 What was built, object by object

All in M09-08, in this order: the four functions of EV13 2.7, a comment, and their grants. No table, type or `devos_private` function is added. M09-01 to M09-07 are not changed. Their helpers are called: `caller_role_class`, `write_event`, `reject`, `scope_within`, `check_claim`, `ready_value` and `is_installation_mission`.

**The form every function has** is M09-03's to M09-07's (4.1 to 8.1):
- the derivation first;
- the read block with steps (b) to (f). A decided refusal goes through `v_code`, `v_reason` and `P0D01`. Any other error is `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`;
- for the three state-changing functions, the write block, where an error is `write_failed`, but `P0D02`; `operation_state` has none;
- one per-call row by `reject` after a refusal;
- fixed reasons.

O (`08_catalog.txt`): each of the four has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, ACL `{postgres=X/postgres,anon=X/postgres}`.

**Parameters.** The names are those of EV13 2.7 and README 8.1, so named calls bind: `prepare_operation(claim_token, p)`, `record_attempt(claim_token, operation_id)`, `record_observation(p)`, `operation_state(operation_id)` (`PO-named-call`, `RT-named-call`, `RO-named-call`, `OS-no-observation`). The bodies read them through `ALIAS FOR $n` (N-288). Merged patches that rename one of these functions and wrap it: B-F01-1 to -6, B-F05-1, B-F07-1, B-6RG-1, B-5C-1, B-N29-2 and B-6ST-4. Under B-F01-1 to -5 and B-6RG-1 the renamed bodies kept working (runs 53 to 57, 61).

**References these functions read** (EV13 21 (7)). `prepare_operation`'s target and each read-set entry are looked up in the fourteen families of M09-06's `relate` by one `union all` (M09-08:366-381, :426-441), with the revision rule of M09-07. A target must be a Work or an Artifact; an entry must name a revision of one of the five revisioned families. `record_attempt` re-reads the stored entries in those five (M09-08:819-832). None of the four names the exam table (`TX-no-exam-table`; file 71: `M09-08 lines naming the exam table: 0`). So T-W07-N08's finder takes in none of them, and an exam record is, for every class, a record they cannot find (`PO-target-exam-record`, `PO-entry-exam-record`).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.prepare_operation(claim_token text, p jsonb)` (M09-08:64) | Roles `devos_calisma`, `devos_kurulum`. Order of 21 (2): the form (M09-08:152-249; `work_revision`, `target_revision` or an entry's revision absent: `could_not_check`); `check_claim(token, work_ref, class, false)` (M09-08:253): every claim code of 2.4; the key (M09-08:271-306): the same full intent is the exact repeat, `ok` with `"repeat": true` and the stored status (M09-08:300), another intent `conflict` (M09-08:302), a partial record `could_not_check`; the effect class (M09-08:310-327): no row, a NULL in the row, or an element it cannot fill, `could_not_check`; `work_revision` (M09-08:330-346): none `could_not_check`, earlier `stale_revision`; `ready_value(work, own claim)` (M09-08:350): `not_ready` or `could_not_check`; the target (M09-08:363-416): another family `invalid_field`, none `could_not_check`, earlier `stale_revision`, out of scope `scope_outside`; each entry (M09-08:420-483), the same three codes; `inputs` and `expected_base` (M09-08:487-506): `read_set_short`. Writes the Operation (`prepared`, attempts 0; the claim's Assignment, generation and epoch from the server) with its read set of 21 (6) (M09-08:510-534), and `operation_prepared` (M09-08:559), whose payload holds the intent, the class's `irreversible`, the tie and the read set. Refusal rows carry `work_ref` and `work_revision`. Answer `{"status": "ok", "id", "operation_status"}` | 2.7's row with R2-1, R2-3, R2-4, C-17 and C-M08 (21 (1) to (7)); section 6's F08 row; B 3.12, principles 3, 4, 8, 9; Appendix C F01, F05, F08; DM-28, DM-37 |
| `devos_api.record_attempt(claim_token text, operation_id uuid)` (M09-08:591) | Roles `devos_calisma`, `devos_kurulum`. Order of 21 (8): `missing_field`; the Operation (`not_found`, M09-08:660); `check_claim` with its work item (M09-08:670); the Operation `for update` (M09-08:690); the stored read set's form; `read_set_changed` for another claim or generation (M09-08:724, :759), another epoch (M09-08:735, :764), another work revision (M09-08:777), other hard dependencies (M09-08:805), and a target, input or agent entry at another revision (M09-08:837); `ready_value(work, own claim)` (M09-08:784): `not_ready` or `could_not_check`. Writes `attempts` + 1 and `prepared` to `attempted` (M09-08:857-861), and `operation_attempted` (M09-08:862). Refusal rows carry the Operation. Answer `{"status": "ok", "id", "attempts", "operation_status"}` | 2.7's row with C-M08 (21 (8)); section 6's F08 row; B 3.5, 3.12, principle 9; Appendix C F08 (a), (b), (c), (w) |
| `devos_api.record_observation(p jsonb)` (M09-08:891) | Roles `devos_calisma`, `devos_kurulum`. The form of 21 (9); the Operation `for update` (M09-08:992), `not_found`; ownership (M09-08:1003-1028): `devos_kurulum` only under the installation's Mission, `devos_calisma` only outside it, else `not_owner`; a Mission that cannot be told, `could_not_check`. Writes the Observation and `observation_recorded` (M09-08:1043-1049); from `prepared` or `attempted`, the status `observed` and `operation_status_set` (M09-08:1051-1057). Refusal rows carry the Operation. Answer `{"status": "ok", "id", "operation_status"}` | 2.7's row with C-M08 (21 (9)); B 3.12, principle 5; Appendix C F07; EV-C02-003 4.1 |
| `devos_api.operation_state(operation_id uuid)` (M09-08:1080) | The four classes of EV-C02-008 1.7.2, as a literal. `missing_field`; `not_found` (M09-08:1124); an Operation without its status, or an observation without its effect or time, `could_not_check`. `ever_applied` any `applied`; `current_effect` the latest by `observed_at`, `unknown` when the latest disagree (M09-08:1143). Answer `{"status": "ok", "operation_status", "ever_applied", "current_effect"}`. Comment `devos:read …` (M09-08:1160) | 2.7's row with C-M08 (21 (1), (9)); EV-C02-008 1.7.2; Appendix C F07; DM-36 |
| Grants (M09-08:1167-1189) | `revoke all … from public` and from the four API roles where they exist, on all four; `grant execute … to anon` on all four; no type, no private function | 1 item 13; T-W08-PRIV's constraint |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the thirty-five `devos_api` functions.
- **Types.** No `devos_private` type has PUBLIC USAGE.
- **The literals**, as the break patches read them: `prepare_operation`, `record_attempt` and `record_observation` hold `array['devos_calisma', 'devos_kurulum']`; `operation_state` holds `array['devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum']` (`TX-literals`).
- **The unqualified-name scan.** No hit in M09-08's four functions; its four hits are section 3.1's.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** `affected_entities`, `deployment_drift`, `explain_paths`, `operation_state`, `read_decision`, `read_review`, `ready_works`, `token_role_class` carry it.

### 9.2 Departures from EV-C02-013, and forms it left open

Each is stated; none is silent. No merged test is changed. EV13 section 21 states items 1 to 9 in the record itself.
1. **The withdrawn code** (EV13 21 part 1, N-279 (17)): an effect class with no row is `could_not_check`, with the reason `effect_class: names no class of the effect-class table`; the code `effect_class_unknown` is in no function (`TX-no-withdrawn-code`; file 71: `M09-08 lines naming the withdrawn code: 0`).
2. **The answers' key `operation_status`** (EV13 21 (1)). 2.7's rows and EV-C02-008 1.7.2 say `status`, which section 1 item 1 gives to `ok` or `refused`. README 8.1 and T-W07-F01 already read `operation_status`.
3. **`prepare_operation`'s order** (EV13 21 (2)): the claim, then the key, before the effect class and the revisions, so that a late retry of an operation already prepared is answered from its record (R2-9; B:259).
4. **Readiness at the prepare** (EV13 21 (2); a refusal 2.7's row does not name): `ready_value` with the caller's own claim, as `register_artifact` does (8.2 item 3). It refuses an operation on a work item with an unmet hard dependency or under a paused Mission (`PO-not-ready-new-dependency`, `PO-mission-paused`: `not_ready`).
5. **The whole intent** (EV13 21 (3)): F01's class rule with the target record; the namespace is part of the key; the caller's other read-set entries are not, so a same-key call with another read set is the exact repeat (`PO-repeat-other-read-set`), and its entries are checked at the effect.
6. **The effect class's elements** (EV13 21 (5)): an element name outside the six, or a NULL element, is `could_not_check` (`PO-class-element-unknown`, `-element-null`); the class's `irreversible` goes into the event (`PO-class-irreversible-event`), and a declared one is not read (`PO-class-declared-irreversible-ignored`).
7. **The read set's stored form** (EV13 21 (6)): `work`, `hard_dependencies`, `claim` and `authority_epoch` for every class; `expected_base`, `target`, `inputs` and `agent` from the call. A caller's `{element, ...}` entry is read for `ref` and `revision` only (`PO-entry-with-element-key`: `ok`; `PO-entry-element-form`: `invalid_field`).
8. **`record_attempt`'s re-check** (EV13 21 (8)): every stored element; `expected_base` not re-checked; no status refuses an attempt.
9. **`record_observation`'s ownership** (EV13 21 (9); a refusal 2.7's row does not name): EV-C02-003 4.1's "the installation's own records", read by Rule O (`RO-kur-on-working-op`, `RO-cal-on-installation-op`: `not_owner`; `RO-pos-kur`: `ok`). The work item's axes are not touched (`RO-work-axes-untouched`). `operation_state` answers a disagreeing tie `unknown` (`OS-tie-disagreeing`).
10. **One change to the earlier producer's draft.** `record_attempt` ordered the stored hard-dependency entries by their text and the current ones by uuid before comparing them (M09-08:797-804). Text order of a uuid depends on the database's collation. Both are now ordered by uuid. No answer changed on this cluster's `C.UTF-8`.
11. **Forms the record leaves open (chosen):**
   - Answers as 9.1.
   - Refusal rows: `prepare_operation` names the work item and the revision sent; the other three name the Operation.
   - Events: `operation_prepared`, `operation_attempted`, `operation_status_set` on aggregate `operation`, `observation_recorded` on aggregate `observation`, none with a revision.
   - Locks: `prepare_operation` through `check_claim` (`for share`) and the key's record `for share` (M09-08:278); `record_attempt` through `check_claim`, then the Operation `for update`; `record_observation` the Operation `for update`.
   - `target_revision` without `target_ref`: `invalid_field`. `observed_at` absent: the transaction's time.

Not departures, for the checker:
- Neither effect checks Rule O: ownership was checked when the claim was taken (`claim`, 18 (2)), and the claim check binds the effect to that claim's class and work item. `record_observation` takes no claim, hence item 9.
- The impact-class refusals (an irreversible class or a high-impact target path under a `routine` work item, B:137) are W-C02-10's, as 2.3 and 2.6 leave them; N29's operation cases stop at their `-pre` line.

### 9.3 How W-C02-09's points are served by M09-08

- **Point 1.** A versioned file later than `20261019030001`, plain SQL, no `psql` meta-command, no backslash (O, `71_git_hashes.txt`: `backslashes in M09-08: 0`). Decisions followed, with the object:
  - F08's read set by operation type (DM-37): the server's table read in `prepare_operation` (M09-08:310-327), its mandatory elements enforced (`PO-input-left-out`, `PO-base-mandatory-absent`: `read_set_short`), the elements the server fills stored (`PO-read-set`, `PO-hard-dependency-stored`), and every element re-checked by `record_attempt`;
  - the rejected-attempt record's per-call form: `reject`, on every refusal (`{"rejected": 1}` deltas);
  - F06's list: `operation_state` carries the read marker; the other three are state-changing (`F06-list | ok | 35 devos_api functions (8 marked devos:read)`);
  - the claim expiry computed: both effects refuse a lapsed claim through `check_claim` (`PO-lapsed`, `RT-lapsed`: `claim_expired`).
  - Offline, `deployment_drift` reports `no_difference`, 20 of 20 (runs 04 and 12).
- **Point 2.** Thirty-five of the 55 `devos_api` functions now exist (four here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (9.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the four refuses a call with no token before any other check (`F06-refused:prepare_operation`, `:record_attempt`, `:record_observation`, `F06-read-refused:operation_state` `ok`; the self-check's `*-no-token`). Each refuses a class not on its list with one per-call row: 5B rows R06 and R26, every cell of the four `ok`.
  - Fifth bullet. A declared role name, generation or epoch changes nothing (`PO-pos-cal` sends `role_class` `devos_kurulum`, `origin` `owner`, `generation` 7 and `authority_epoch` 99: the record and the event carry `devos_calisma`, `call`, generation 1 and the global epoch). A declared session is written as declared (`PO-event`, `RO-events`).
- **Point 4** (the effects' claim refusals, now on both effects):
  - with another work item's claim: `PO-claim-of-another-item`, `PO-work-ref-names-nothing`, `RT-claim-of-another-item` (`claim_unknown`);
  - with no claim token: `PO-no-claim-token`, `PO-empty-claim-token`, `RT-no-claim-token` (`claim_missing`); an unknown one: `PO-unknown-claim-token`;
  - released, expired or revoked: `RT-released-claim`, `PO-revoked`, `RT-revoked`, `PO-cancelled-item`, `RT-cancelled-item` (`claim_not_active`), `PO-lapsed`, `RT-lapsed` (`claim_expired`);
  - an earlier generation: `PO-earlier-generation` (`claim_generation`); an operation prepared under an earlier claim of its work item: `RT-prepared-under-earlier-claim` (`read_set_changed`); an earlier epoch: `PO-earlier-epoch`, `RT-earlier-epoch` (`claim_epoch`);
  - S8 line 2: `PO-claim-class`, `RT-claim-class`, `PO-kur-claim-under-cal` (`claim_class`).
  - T-W07-5C `PASS (8/8)` and T-W07-F08 `PASS (17/17)` (run 06). T-W07-N17 does not reach its cases (9.4).
- **Point 5.**
  - Each state-changing function writes its event in the same transaction, with the token's class (`PO-event`, `RT-event`, `RO-events`: this transaction, the token's class, `call`).
  - An exact repeat writes nothing: `PO-repeat`, `-repeat-late`, `-repeat-real-state` (`ok repeat`, `{}`). `record_attempt` has none by 2.7's row (`RT-second-counts`: attempts 2).
  - A failure planted mid-transaction leaves no half state and no orphan event: `PO-write-failed`, `-write-event-failed`, `RT-write-failed`, `-write-event-failed`, `RO-write-failed`, `-write-status-failed` (only the refusal row is added; `RT-nothing-half-written`); `*-write-P0D02`: `could_not_check` with its reason. Two writes of one new key: the second is `write_failed` by the table's unique key, never a second record (`PO-key-taken-in-write`).
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass:
  - references: `PO-no-work-revision`, `-work-revision-null`, `-revision-beyond`, `-target-without-revision`, `-target-names-nothing`, `-target-exam-record`, `-target-revision-beyond`, `-entry-no-revision`, `-entry-names-nothing`, `-entry-exam-record`, `-entry-need-with-revision`, `-entry-revision-beyond`; `RT-stored-entry-names-nothing`;
  - the effect class (C-17): `PO-class-unknown`, `-row-deleted`, `-irreversible-null`, `-read-set-null`, `-element-unknown`, `-element-null`, `-unreadable`; T-W07-6RG's 6RG-c1 to -c3 `ok`;
  - partial records: `PO-repeat-partial-record`, `PO-inputs-partial`, `PO-readiness-unknown`, `RT-stored-read-set-partial`, `RT-readiness-unknown`, `RO-mission-event-missing`, `RO-mission-link-missing`, `OS-observation-partial`, `OS-status-partial`;
  - unreadable tables: `PO-claims-unreadable`, `-operations-unreadable`, `-revisions-unreadable`, `-relations-unreadable`, `-entries-unreadable`, `RT-operations-unreadable`, `-relations-unreadable`, `-entries-unreadable`, `RO-operations-unreadable`, `-events-unreadable`, `OS-observations-unreadable`.
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the four, run in place (runs 06, 10, 11):
    - **T-W07-F05 `PASS (7/7)`**, F05-pos3, -b, -d through `prepare_operation`;
    - **T-W07-F07 `PASS (7/7)`**, its C02 part whole;
    - **T-W07-F08 `PASS (17/17)`**, F08-b, -pos3, -pos5 and -d through `prepare_operation` and `record_attempt`;
    - **T-W07-6RG `PASS (27/27)`**, s0 to s3 and c1 to c3 through `prepare_operation`;
    - **T-W07-5C `PASS (8/8)`**;
    - **T-W07-F01 `COULD NOT CHECK (1 of 13)`** on the fresh cluster (F01-g's plant, 9.4); **`PASS (13/13)`** after the global epoch is set to 2 (run 11);
    - **T-W07-CONC `PASS (8/8)`** (run 10);
    - 5B: the cells of R06 and R26 for the four `ok`; `COULD NOT CHECK (6 of 210 could not be checked)` for rows whose functions are not built; none `bad`;
    - F06: the four's refused cases `ok`; their event and read-accepted cases `could_not_check`; in all `FAIL (1 bad, 20 could not check, of 90)` (9.4);
    - N09, DM19B, DM07, DM34, 6TK, K05, IDC, 5A and DM02 pass again; N25, DM19, ROC, REL, 5A's positive control, DM11, N28 (verifier) and F04 as before M09-08 (8.4);
    - every other file `COULD NOT CHECK` on its `-pre` line; run 07 is T-W14-FN's `FN-pre`.
  - Their copies are a later pull request's (R:247; EV13 section 11).

### 9.4 What M09-08 does not yet serve

- **Merged tests that cannot pass on a correct build, or not on every database** (EV13 21 (10)), for the test designer:
  - **T-W07-F01's F01-g** (W9 point 8's F01). It plants its stored `authority_epoch` one lower than the claim's. On a fresh database, where the global epoch is 1, that breaks the operation table's check `authority_epoch >= 1` (run 06: `F01-g | could_not_check | … violates check constraint "operation_authority_epoch_check"`). So F01 is COULD NOT CHECK there. With the epoch at 2, F01 passes 13/13 (run 11), and B-F01-6 turns F01-g red (run 67). In `devos-test` the outcome depends on the epoch that project has reached; a revision that plants the epoch, or a plant one higher, would fix the case.
  - **T-W07-F06**'s four recipes for these functions (`F06-event:prepare_operation`, `:record_attempt`, `:record_observation`, `F06-read-accepted:operation_state`) are `could_not_check`: their fixture claim is refused, because the planted Mission has no creation event ("ownership: whether the work item lies under the installation's Mission is missing or partial"). That is N-285 (1)'s, N-291's and N-293's cause, now in four more cases; Rule O is not bent for it.
  - **B-F07-1** (F07's only break) writes a text into the enum column `observed_effect`. PostgreSQL refuses the statement (run 60: `column "observed_effect" is of type devos_private.observed_effect but expression is of type text`), so every wrapped call raises and F07 is `COULD NOT CHECK (7 of 7)`. It is B-F04-7's fault class (N-291). F07's rules are shown by the self-check and by breaks b34 to b36.
  - **B-F05-1, B-5C-1 and B-F08-1 to -4** (N-290 (1)), now observed. Under B-F05-1, F05 stops at its `-pre` line (`fixture artifact b refused`, run 59). Under B-5C-1, 5C passes 8/8 (run 62). Under B-F08-1 to -4, F08 passes 17/17 each (runs 63 to 66). F05-d's and F05-b's rules are shown by breaks b16 and b19; F08's by b20, b25 to b28.
  - **T-W07-N17** stops at its `-pre` line: its `devos_kurulum` claim on W3 is refused (N-293 (4)). So W9 point 8's N17, with point 4's N-136 cases, and B-N17-1 cannot run.
- **W-C02-10's.** T-W07-N29 and T-W07-6ST stop at their `-pre` lines, on W-C02-10's tables, so their operation cases and B-N29-2 and B-6ST-4 are not run.
- **The merged breaks run here** (runs 53 to 67, each on a fresh copy of `t20`; run 68 is their unpatched control):
  - B-F01-1: `F01-a`, `-d2` red. B-F01-2: `F01-c` red. B-F01-3: `F01-d1`, `-d2`, `-d3` red. B-F01-4: `F01-t1` red. B-F01-5: `F01-t2` red. B-F01-6: not shown at epoch 1 (`F01-g` `could_not_check`, run 58); `F01-g` red at epoch 2 (run 67).
  - B-6RG-1: `FAIL (19 bad, …, of 27)`, exactly its red list, `6RG-c1` to `-c3` and `-s1` to `-s3` among them.
  - Not shown: B-F07-1, B-F05-1, B-5C-1, B-F08-1 to -4 (above).
- So W9 point 8's F01 counts only on a database whose epoch is above 1, and N17 not at all, until the test designer's revisions.

### 9.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0908` at `32fbb4e`, with M09-08, EV13's section 21 and the raw files uncommitted. The main run started 2026-10-19T02:14:46Z and ended 02:15:07Z, on one cluster (`…/scratchpad/m0908_run/rerun.sh`). The break runs started 02:15:07Z and ended 02:16:02Z, on a second cluster (`…/scratchpad/m0908_run/brk.sh`).
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `setup.sql` and `catalog.sql` are `…/m0907_run/`'s, changed only in their paths (the clone `prd12`, the cluster under `…/m0908_run/pg`, the socket in `…/scratchpad/m8s`) and a few printed words; `setup.sql` and `catalog.sql` are byte-identical. `fn_check.sql` keeps M09-07's harness (`m_call`, `m_case`, `m_rec`) with M09-08's counted tables and cases. `brk.py`, `brk.sh`, `rerun.sh` and `final.sh` follow M09-07's forms; `brk.py` allows more than one replacement per break, and `brk.sh` copies each database from a template.
- **Trial runs.** Trial runs came before, none of them filed:
  - every staged file once on the draft, before 9.2 item 10's change (the same summaries as run 06);
  - the self-check twice. The first, after the self-check's own faults found on reading it were fixed (three cases read a refusal row written inside an undone plant; one tie call used a class ownership refuses; one plant would have made readiness unknown), went green, 251 of 251. One case, `RT-entries-unreadable`, reached `could_not_check` through the readiness helper instead of the entry check it names: PostgreSQL checks privileges on every table a query names, so `ready_value` failed on the revoked `decision_revision` first. Its plant now revokes `artifact_revision`, which only the entry check reads, and a second case checks the reason. The second trial gave 252 of 252;
  - the main run once (`…/m0908_run/trial1`) and the break runs once (`…/m0908_run/trial2`).
  - The filed runs give the same summary lines as the trials (compared after the run). Two lines more in run 60, B-F07-1's demonstration, added after the trial to show its error.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the nineteen migrations before M09-08, each `[exit 0]` with its history row (38 `[exit 0]` lines).
- **03, M09-08:** `CREATE FUNCTION` ×4, `COMMENT`, `REVOKE` ×4, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 12:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 20, "migrations_expected": 20`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (95/95)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result):
  - `W07_F05_SCOPE_BOTH_SIDES PASS (7/7)`, `W07_F07_OBSERVATION_HISTORY PASS (7/7)`, `W07_F08_RECHECK_AT_EFFECT PASS (17/17)`, `W07_6RG_RULE_GATE_COULD_NOT_CHECK PASS (27/27)`, `W07_5C_OTHER_SESSION_FAKE_ID PASS (8/8)`;
  - `W07_F01_WHOLE_INTENT COULD NOT CHECK (1 of 13 could not be checked)`: `F01-g | could_not_check | different authority epoch: could not plant the earlier epoch: new row for relation "operation" violates check constraint …`; the other twelve `ok` (`F01-pos1`, `-pos2`, `-a`, `-b`, `-c`, `-d1`, `-d2`, `-d3`, `-e`, `-f`, `-t1`, `-t2` as wanted);
  - `W07_F06_STATE_CHANGE_EVENT FAIL (1 bad, 20 could not check, of 90)`, with `35 devos_api functions (8 marked devos:read)`; `F06-refused:prepare_operation`, `:record_attempt`, `:record_observation`, `F06-read-refused:operation_state` `ok`; their event and read-accepted cases `could_not_check` (9.4); `F06-role-token | bad`, M09-06's (7.4);
  - `W07_5B_AUTHORIZATION_MATRIX COULD NOT CHECK (6 of 210 could not be checked)`, none `bad`, for example `5B-R06-prepare_operation-den | ok | x cell: … code role_class_not_permitted`, `5B-R06-record_attempt-cal | ok | v cell: … code not_found` and `5B-R26-operation_state-sin | ok | v cell: … code not_found`;
  - `W07_N09_FINDING_GATE PASS (5/5)`, `W07_DM19B_BURST_COUNT PASS (12/12)`, `W07_DM07_HEARTBEAT PASS (8/8)`, `W07_DM34_MISSION_SCOPE PASS (10/10)`, `W07_6TK_TOKEN_REASONS PASS (32/32)`, `W07_K05_MANY_PATHS PASS (6/6)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`;
  - as before M09-08: `W07_ROC_OWNERSHIP_AND_CLAIM_CLASS FAIL (1 bad, 1 could not check, of 83)`, `W07_N25_VERDICT_STALENESS FAIL (1 bad, …, of 5)`, `W07_DM19_REJECTED_ATTEMPT_SURVIVES FAIL (1 bad, …, of 5)`, `W07_N04_SELF_APPROVAL COULD NOT CHECK (5 of 19 …)`, `W07_F04_AFFECTED_RECORDS COULD NOT CHECK (1 of 22 …)`, `W07_REL_RELATION_STATUS FAIL (2 bad, …)`, `W07_5A_POSITIVE_CONTROL FAIL (1 bad, …)`, `W07_DM11_ANSWER_REVISION FAIL (5 bad, …)` and `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, …)` (8.4);
  - every other file `COULD NOT CHECK` on its `-pre` line (N17, N29, 6ST, N01, N02, N03, N08 and the rest; 9.4); run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 9.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 M09-08; one transaction rolled back): `M0908_FUNCTIONS PASS (252/252)`.
  - The cases: 140 for `prepare_operation`, 48 for `record_attempt`, 39 for `record_observation`, 18 for `operation_state`, 1 for the delete path and 6 for the text.
  - Each compares the answer's code and the change of eight tables; the state cases read the rows after.
  - Among them: `PO-conflict-target`, `-base`, `-base-absent`, `-payload`, `-class`, `-target-ref`, `-no-target-ref`, `-epoch`, `-work-revision`, `-work-item`, `-generation`: `conflict`; `PO-repeat`, `-repeat-late`, `-repeat-real-state`: `ok repeat`, `{}`; `PO-class-unknown`: `could_not_check`, "effect_class: names no class of the effect-class table"; `PO-input-left-out`: `read_set_short`; `RT-work-revised`, `-entry-revised`, `-target-revised`, `-new-dependency-resolved`, `-dependency-retracted`, `-epoch-moved`, `-prepared-under-earlier-claim`: `read_set_changed`; `RO-earlier-row-unchanged`; `OS-applied-then-unknown`, `-out-of-order`, `-tie-disagreeing`; `DK-no-delete-path`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, `operation_rows_holding_a_token_format_string 0`, `observation_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `operation`.
- **10, T-W07-CONC's program, run in place** (input: the break harness's form, four keys with null values; its synthetic fixtures committed on the throwaway cluster): the eight cases `ok`, `W07_CONC_CLAIM_AND_CYCLE PASS (8/8)`, `[conc exit 0]`. It calls no function of M09-08; it is run so that M09-08's apply is seen not to change it.
- **11, T-W07-F01 once more** after `update devos_private.global_authority_epoch set epoch = 2` (committed on the throwaway cluster): `epoch 2`; `F01-g | ok | different authority epoch: refused: conflict`; `W07_F01_WHOLE_INTENT PASS (13/13)`.
- **13:** the server log, `368 lines; claim-format 0; environment-format 0`. **14:** `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **15:** the break cluster's setup, the templates `t19` and `t20` (`[template … exit 0]`), and `brk.py`: 37 `made (… in devos_api.<fn>)`.
- **16 to 52, the break copies**, each in a fresh database copied from `t19` (`[apply exit 0]`), then the self-check and the staged files that call the function broken. Each break turned the self-check red (`M0908_FUNCTIONS FAIL (n of 252 not as wanted)`); the red cases named, and the merged cases that turned `bad`:
  - **b01**, an unknown class admitted with an empty read set: red `PO-class-unknown`, `-unknown-reason`, `-row-deleted` (the operation's foreign key makes the write fail, `write_failed`); merged **`6RG-c1` `bad`**.
  - **b02**, an unknown class answered with the old code: red `PO-class-unknown`, `-row-deleted`, `TX-no-withdrawn-code`; merged **`6RG-c1` `bad`** ("answered refused (effect_class_unknown)"), the case N-279 (17) names.
  - **b03**, a partial class row admitted: red `PO-class-irreversible-null`; merged **`6RG-c3` `bad`**.
  - **b04**, the target not compared: red `PO-conflict-target`; merged **`F01-a`, `F01-d2` `bad`**.
  - **b05**, the claim and generation not compared: red `PO-conflict-generation`; merged **`F01-c` `bad`**.
  - **b06**, the epoch not compared: red `PO-conflict-epoch`. **b07**, the work revision not compared: red `PO-conflict-work-revision`. **b08**, the target record not compared: red `PO-conflict-target-ref`, `-no-target-ref`. **b09**, the repeat without the real state: red `PO-repeat-real-state-answer`.
  - **b10**, the claim of any work item admitted: red `PO-claim-of-another-item`, `-work-ref-names-nothing`, `-claim-checked-before-repeat`.
  - **b11**, an absent `work_revision` read as the current one: red `PO-no-work-revision`, `-no-work-revision-reason`, `-work-revision-null`. **b12**, `stale_revision` removed: red `PO-stale-revision`. **b13**, the readiness re-check removed: red `PO-not-ready-new-dependency`, `-readiness-unknown`, `-mission-paused`, `TX-claim-before-readiness`.
  - **b14**, the target's family unchecked: red `PO-target-decision`, `-target-need`. **b15**, a stale target admitted: red `PO-target-stale`, and three later target cases that meet the record the break let it write under the same key. **b16**, the target's scope check removed: red `PO-target-scope-outside`, `-scope-prefix-not-label`, `-work-outside`; merged **`F05-d` `bad`**.
  - **b17**, the entries' reference check removed: red the nine `PO-entry-*` reference and later cases; merged **`6RG-s1` `bad`**. **b18**, a stale entry admitted: red `PO-entry-stale-work`, `-stale-decision`, `PO-input-stale`, and the cases after them under the same key. **b19**, the entries' scope check removed: red `PO-entry-artifact-outside`, `-finding-outside`, `-work-outside`; merged **`F05-b` `bad`**.
  - **b20**, an input may be left out: red `PO-input-left-out`, `-inputs-none-named` and two later; merged **`F08-d` `bad`**. **b21**, `expected_base` may be left out: red `PO-base-mandatory-absent`, `-null`. **b22**, the hard dependencies not stored: red `PO-hard-dependency-stored`, `RT-dependency-retracted`, `RT-with-hard-dependency` and two later. **b23**, the claim token put into `operation_prepared`: red `PO-event` (no staged file is run under this break, so that no output can print an event's payload).
  - **b24**, `record_attempt` admits the claim of any work item: red `RT-claim-of-another-item`. **b25**, the work revision re-check removed: red `RT-work-revised`. **b26**, the readiness re-check removed: red `RT-new-dependency-unresolved`, `-readiness-unknown`, `-mission-paused`, `TX-claim-before-readiness`. **b27**, the dependency comparison removed: red `RT-new-dependency-resolved`, `-dependency-retracted`, `-dependency-target-moved`. **b28**, the entries' re-check removed: red `RT-entry-revised`, `-entry-work-revised`, `-target-revised`; merged **`F08-b` `bad`**. **b29**, the claim prepared under not compared: red `RT-prepared-under-earlier-claim` and one later. **b30**, the epoch prepared in not compared: red `RT-epoch-moved`. **b31**, the status not moved: red `RT-answer`, `-row`, `-event`, `-second-answer` and one later.
  - **b32**, `record_observation`'s ownership removed: red `RO-kur-on-working-op`, `-cal-on-installation-op` and three later. **b33**, its status not moved: red `RO-pos-applied`, `-answer`, `-events` and six more. **b34**, `observed_at` ignored: red `RO-row`, `OS-out-of-order`; merged **`F07-b2`, `F07-c2` `bad`**.
  - **b35**, `ever_applied` from the latest only: red `OS-applied-then-unknown`, `-out-of-order`; merged **`F07-a2`, `-b2`, `-c2` `bad`**. **b36**, a tie answered by chance: red `OS-tie-disagreeing`. **b37**, a partial observation admitted: red `OS-observation-partial`.
  - So each check turns red when its rule is removed. The merged files caught twelve of the thirty-seven (b01 to b05, b16, b17, b19, b20, b28, b34, b35); the self-check caught all thirty-seven, among them every one the merged files do not reach (9.4). `F06-role-token | bad` under b32 to b34 is M09-06's case, `bad` without any break (run 06). Some red cases after the first one are knock-on effects: a call the break wrongly admits writes a record that later cases with the same key meet.
- **53 to 67, merged break patches**, each in a fresh database copied from `t20` (`[patch exit 0]`), as 9.4 lists:
  - **53, B-F01-1:** `W07_F01_WHOLE_INTENT FAIL (2 bad, 1 could not check, of 13)`, `F01-a`, `-d2`. **54, B-F01-2:** `FAIL (1 bad, …)`, `F01-c`. **55, B-F01-3:** `FAIL (3 bad, …)`, `F01-d1`, `-d2`, `-d3` (`function bodies deleting operation rows: 1`). **56, B-F01-4:** `F01-t1 | bad`. **57, B-F01-5:** `F01-t2 | bad`. **58, B-F01-6:** `COULD NOT CHECK (1 of 13 …)`, F01-g's plant.
  - **59, B-F05-1:** `F05-pre | could_not_check | fixture: … fixture artifact b refused`.
  - **60, B-F07-1:** the wrapper's statement in its own form, on no row: `ERROR: column "observed_effect" is of type devos_private.observed_effect but expression is of type text`; `observed_effect is of type devos_private.observed_effect`; `W07_F07_OBSERVATION_HISTORY COULD NOT CHECK (7 of 7 could not be checked)`.
  - **61, B-6RG-1:** `W07_6RG_RULE_GATE_COULD_NOT_CHECK FAIL (19 bad, 0 could not check, of 27)`.
  - **62, B-5C-1:** `W07_5C_OTHER_SESSION_FAKE_ID PASS (8/8)`; N17 `-pre`. **63 to 66, B-F08-1 to -4:** `W07_F08_RECHECK_AT_EFFECT PASS (17/17)` each.
  - **67, B-F01-6 with the global epoch set to 2 first:** `F01-g | bad | different authority epoch: accepted, wanted refused`; `FAIL (1 bad, 0 could not check, of 13)`.
- **68, the unpatched control** of the same files on a fresh copy of `t20`: F01 `COULD NOT CHECK (1 of 13 …)`, F05, F07, 6RG, 5C, F08 `PASS`, N17 `-pre`; and F01 on a fresh copy at epoch 2: `PASS (13/13)`.
- **69:** the server log, `497 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **70:** files 01 to 69 scanned with the finders of `scan_patterns.json`: `69 files; claim-format 0; environment-format 0`.
- **71:** the hashes in the envelope; `backslashes in M09-08: 0`; `M09-08 lines naming the exam table: 0`; `M09-08 lines naming the withdrawn code: 0`; `M09-08 strings found by either token finder: m0908 scan: 1 files; claim-format 0; environment-format 0`; `M09-08 lines holding either marker whole: 0`; `git status --porcelain`: EV13 modified, M09-08 and the raw files untracked, before this section was written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 9.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-F01's F01-g: a plant that holds whatever the project's epoch is (9.4). Until then F01 counts only where the epoch is above 1.
   - T-W07-F06's four recipes for these functions: fixture Missions with a creation event (N-285 (1), N-291, N-293).
   - B-F07-1: a cast to `devos_private.observed_effect` in its update. B-F05-1, B-5C-1 and B-F08-1 to -4: N-290 (1).
   - T-W07-F07's interface line for `operation_state`'s answer (`{status, …}`): the Operation's status is `operation_status` (EV13 21 (1)). No case reads it.
   - T-W07-N17's W3 under the installation's Mission (N-293 (4)), so that point 4's N-136 cases run on the effects.
2. **For the executor** (reported, not done):
   - **No writer of the work item's `effect` axis.** B 3.3 gives Work an `effect` field (`none`, `prepared`, `observed`, `unknown`), and B principle 5 keeps it apart from the other axes. No row of EV13 2.7, and no function of B section 4, sets it, so it stays `none` (`RO-work-axes-untouched`). Whether `prepare_operation` and `record_observation` set it, with an event on the work item, needs a source: a dated correction of EV13 2.7 with a checker, and a migration through the migration path, before any reader of the axis (C03's audit work, C08's release).
   - **No status refuses an attempt or an observation.** B 3.12 gives `conflicted` and `abandoned` no writer and no transitions. Once a stage writes them, `record_attempt` should refuse an attempt on such an Operation; until then nothing can reach them.
   - **`expected_base` is stored, not re-checked** (EV13 21 (8)): C03's effect channels compare the external base when they make the effect.
3. **For the checker of verdict (i):**
   - EV13 section 21, with its *[C-17]* and *[C-M08]* marks;
   - 9.2's departures, chiefly 1, 3, 4, 5 and 9;
   - the self-check and the break copies, which are the producer's own.
4. **For the producers of M09-09 to M09-12 and W-C02-10:**
   - an effect's claim check is `check_claim`, then `ready_value` with the caller's own claim (M09-08:253, :350);
   - W-C02-10's impact-class rule for an irreversible class reads the class's `irreversible` from the table, as M09-08 does (M09-08:311), never from the agent.
5. **Residuals:**
   - The claim token travels as the first parameter of both effects, as 8.6 item 5 says for `register_artifact`.
   - Two concurrent first calls of one new key: the second is `write_failed` by the table's unique key (`PO-key-taken-in-write`), not the repeat answer. Nothing is let through; its retry gets the record.
   - `prepare_operation` looks a reference up in fourteen tables (one `union all`) per entry; a cost at C02's sizes. An unreadable table among them makes every prepare that names a target or an entry `could_not_check`; that fails closed.

## 10. The rule corrections

The producer's record of `supabase/migrations/20261019080001_w09_rule_corrections.sql` (M09-RC), the corrective migration of EV13 section 22 (7). It was written on branch `claude/c02-w09-m0908b` at `main` `1daa3521e28ba2f811b97888fd41d69472ffde6e`, where M09-01 to M09-08 are merged and applied and EV13 section 22 is merged. It replaces twelve functions of M09-02 to M09-07 and adds one private function; it changes no table and no type. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at `1daa352`, with EV13's section 23 added. M09-RC:n is a line of the file above at the bytes the envelope names; M09-0n:n a line of that merged migration. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 23 first.** EV13 gained "23. Correction, 2026-10-19 (the corrective migration)", which states every form section 22 leaves open as M09-RC builds it, with marks *[C-RC]* in 22 (1), 22 (3) twice, 22 (4) and 22 (7). The corrective migration's checker judges it.
- **What binds this file** (`plan/work/C02.md`; EV-C02-017 section 9):
  - **N-288** (before ROC's first result): `cancel_work`, `mark_stale` and `reopen_for_review` read their parameters through `ALIAS FOR $n`. **Met** in the file; shown by B-ROC-1 and B-ROC-2, which on M09-08's head turn every `cancel_work` case of ROC red and on this build turn red exactly their ROC entries (10.5, runs 41 and 42).
  - **N-284 C, N-289 B, N-292 B, N-296 (3) B** (before verdict (ii)): built as EV13 22 (1), (3), (4) and (5) state them, with section 23's forms. N-286 A needs no migration (22 (2)).
  - **N-299** (CHK-C02-095): (1) CONC's revision is on pull request #375 (not merged at `1daa352`); both CONC programs were run, and 10.4 says which result the build gives under each. (2) The re-runs: every merged test file and break under `tests/C02/W-C02-07/` whose text calls a replaced function, 57 files, with their results on this build and on M09-08's head (10.5), and the live-claim search at this head (10.3). (3) Met by EV13 section 22. The annotation's point, `revoke_claim` as built, is kept (EV13 23 (7); self-check `RK-earlier-epoch`).
  - **New test cases for these decisions** are the test designer's (EV-C02-017 section 9 item 6), written elsewhere. None is written or run here. The producer's own self-check (run 10) is not one of them.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0908b` at `1daa352`, clean before this work. The runs were made with M09-RC, EV13's section 23 and the raw files uncommitted (O, `65_git_hashes.txt`). Bytes run: M09-RC `b42002c37b4de47b3df994fb966d145498b1e438c4d29a432aeec0028e921adb`, made by `…/scratchpad/mcorr_run/build.py` (`dd10b4b8…62da9`) from the merged migrations' own text and `…/mcorr_run/parts.sql`; the self-check `…/mcorr_run/fn_check.sql` `7b9a132e…1fb3`; the break maker `…/mcorr_run/brk.py` `47933f3c…9635`; the other drivers' hashes are in file 65. EV13's section 23 was written while the runs were made; the database runs do not read it. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 9: one throwaway PostgreSQL 16.15 cluster per script, unix socket only (in `…/scratchpad/mcs`, under the 107-byte limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, files 13 and 62: `[cluster directory deleted: yes]`). Stand-ins: `…/scratchpad/m0903_run/setup.sql`, byte for byte (`m0908_run`'s copy, compared). The comparison and break runs copy each fresh database from one of two templates: `t20`, the twenty migrations of `main` (M09-08's head), and `t21`, `t20` with M09-RC. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `1daa352`; EV13 with its sections 1 to 22, and section 23 (for the corrective migration's checker); EV-C02-017 section 9; CHK-C02-095's conditions |
| Input | The twenty-one migrations (`main`'s twenty and M09-RC); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `job/` and T-W14-FN's, run in place; the 57 files of the list (10.5) on both templates; T-W07-CONC's program as merged and as revised on pull request #375 (`c45f2fce9efd1e114c883ca05330c8906d44f1f6`, read with `git show`, copied with the merged `w07_f01_whole_intent.sql` it reads to `…/mcorr_run/conc_rev/`; that copy's F01 file is byte-identical to `main`'s); the producer's self-check; eighteen break copies of M09-RC made outside the repository (`…/scratchpad/mcorr_brk/`, by `brk.py`, deleted after the run) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_mc_offline_01_init_setup.txt` to `…_66_function_diff.txt`, written directly by `…/mcorr_run/rerun.sh` (01 to 13), `brk.sh` (14 to 62) and `final.sh` (63 to 65); file 66 is `build.py`'s per-function difference. Every file but 65 passed through `scrub.py` (M09-08's filter, reading the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time) and ends `claim-format strings replaced 0; environment-format strings replaced 0`. File 64 scans every other mc raw file again with the same finders: no string of either format. Files 13 and 62 scan the clusters' server logs: no string of either format. File 65 holds hashes and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 10) and the break copies (44 to 61) are the producer's own; the merged files and break patches (15, 16, 21 to 43) and the CONC programs (17 to 20) are the test designers' |

### 10.1 What was built, object by object

All in M09-RC, in this order: `claim_live`, the twelve replaced functions, the two walks' comments, the grants. Each replaced function is its merged text with only the changes its comment names (file 66 gives each difference; besides `create or replace`, from 5 changed lines in `relate` to 46 in `revise_work`, most of them the `ALIAS` renaming). The form of every function is M09-03's to M09-08's (4.1 to 9.1), unchanged. O (`08_catalog.txt`): each of the thirteen has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`; `anon` holds EXECUTE on the eleven of `devos_api` only.

| Object | What changes | Follows (EV13 unless named) |
|---|---|---|
| `devos_private.claim_live(claim_status, claim_lease, claim_epoch)` (M09-RC:39) | New, owner only. True when active, lease later than `now()` and the claim's epoch equal to the global epoch read with a plain read; false when not active, lease run out or another epoch; NULL when status NULL, an active claim's lease NULL, or the epoch cannot be judged | 22 (3); 23 (2); B:23, B:377, B 3.5; DM-06 |
| `devos_private.ready_value(uuid, uuid)` (M09-RC:77) | Its live-claim condition through `claim_live` (live: false; NULL: unknown); parameters through aliases | 22 (3); 23 (2), (5); B principle 6 |
| `devos_api.revise_mission(jsonb)` (M09-RC:201) | N-284 C at the `mission_authority` step (M09-RC:434-466): the Decision named not an owner authority of any revision of this Mission; its `answered_at` not earlier than the current revision's `created_at`, equal passing; NULL `could_not_check`; `p` through an alias | 22 (1); 23 (1), (5); B:106, B:305, B:307 |
| `devos_api.revise_work(jsonb)` (M09-RC:520) | Rule C's count through `claim_live`; the partial reason names the epoch; `p` through an alias | 22 (3); 23 (2), (5) |
| `devos_api.mark_stale(uuid, text)`, `reopen_for_review(uuid, text)` (M09-RC:928, :1215) | Parameters through `ALIAS FOR $n` only | N-288; 22 (7) |
| `devos_api.cancel_work(uuid, text)` (M09-RC:1062) | Parameters through `ALIAS FOR $n`, and Rule C through `claim_live` | N-288; 22 (3), (7) |
| `devos_api.claim(uuid, text)` (M09-RC:1358) | The epoch `for share` after the claims are locked and before the live count (M09-RC:1462-1474); partial, live and lapsed sets through `claim_live` (M09-RC:1476-1487); every lapsed claim (lease or epoch) marked `expired` by id, `claim_expired` naming `authority_epoch` and `global_authority_epoch` (M09-RC:1525-1534) | 22 (3); 23 (3); DM-01, DM-06, DM-31; B:472 |
| `devos_api.relate(jsonb)`, `retract_relation(uuid, text)` (M09-RC:1569, :1971) | Rule C's count through `claim_live`; the partial reason names the epoch | 22 (3); 23 (2) |
| `devos_api.affected_entities(uuid, jsonb)`, `explain_paths(uuid, uuid, jsonb)` (M09-RC:2166, :2364) | The edge per type in every walk query; a NULL-type relation not walked and the result not complete; comments `devos:read` written again | 22 (4); 23 (4); B:149, B:226, C:164 |
| `devos_api.review_finding(uuid, integer, text)` (M09-RC:2644) | A `withdrawn` Finding refused `invalid_field` after its status is read (M09-RC:2724) | 22 (5); EV-C02-008 section 4 item 2 |
| Grants (M09-RC:2839-2892) | `revoke all … from public` and from the four API roles on all thirteen; `grant execute … to anon` on the eleven of `devos_api` | 1 item 13; T-W08-PRIV (`W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, one function more than M09-08's 95) |

O (`08_catalog.txt`): the role literals are the merged ones (also self-check `TX-literal-*`); the unqualified-name scan finds no hit in the thirteen but its four known false hits of section 3.1's form (`check_claim`'s and `is_installation_mission`'s parameters, `ready_value`'s `is distinct from p_own`, `reject_counted`'s `update … set`); no function holds `execute`; the read marker on the same eight functions as after M09-08.

### 10.2 Departures from EV-C02-013, and forms it left open

Each is stated in EV13 section 23; none is silent. No merged test is changed.
1. **`revise_mission`'s two conditions are judged only on the widening path** (23 (1)); a `created_at` NULL is `could_not_check`.
2. **The predicate reads the global epoch itself**, plain, only for an active claim whose lease runs; any other epoch is not live; its NULL cases (23 (2)).
3. **Two answers change on a planted missing epoch** (23 (2)): with an active claim whose lease runs, Rule C answers `could_not_check` where it answered `other_class_claim`, and readiness is unknown where it was false. Rule C's partial reason now names the epoch (four places).
4. **`claim`'s read block lists the claims to mark; the write block marks them by id**; the payload names both epochs (23 (3)).
5. **A NULL-type relation counts when either end is in the level walked** (23 (4)); the NULL-validity test runs on the new edges.
6. **`ALIAS FOR $n` in every function of the file**, `revise_mission`, `revise_work` and `ready_value` included (23 (5)).
7. **The file's form** (23 (6)); **what is not changed**, `revoke_claim` among it (23 (7)).

### 10.3 The live-claim search at this head (CHK-C02-095 C2)

- **The catalogue** (O, `09_live_claim_search.txt`): every function of `devos_api` and `devos_private` whose current source names `lease_expires_at` or reads `devos_private.assignment`, sixteen. Six call `claim_live` and keep no lease comparison of their own: `ready_value` (`bool_or` over the claims), `claim`, `revise_work`, `cancel_work`, `relate`, `retract_relation` (counts over the claims). None of the sixteen holds `lease_expires_at > now()` or `<= now()`. The other ten are not counts of a live claim:
  - `check_claim` judges the claim presented (its one `bool_or` is over NULL generations) and refuses an earlier epoch `claim_epoch`; `heartbeat` and `release` reach claims only through it;
  - `revoke_claim` judges one named claim (as built, EV13 23 (7));
  - `admit_work`, `accept`, `open_review`, `prepare_operation`, `affected_entities` and `explain_paths` name the table only to look a reference up by id among the families.
- **The text** (O, `63_text_search.txt`): every line of a top-level migration naming `lease_expires_at`, and the files reading `devos_private.assignment`. Its live counts at `1daa352` are the six of EV13 22 (3) (M09-02:356-361, M09-04:539, :969, M09-05:229, M09-06:363, :606), each replaced here; M09-07 and M09-08 add none (they name the table, never the column); M09-RC names the column only in the calls of `claim_live` and in `claim`'s marked, inserted, logged and returned fields (M09-RC:1528-1561). The other lines of the search are the column's definition, `check_claim`'s and `revoke_claim`'s reads of one claim, `heartbeat`'s extension, M09-05's superseded expiry marking (M09-05:281) and comments.
- **What follows.** No unconverted count of a live claim remains at this head (self-check `TX-predicate-in-six`). `register_artifact`, `prepare_operation`, `record_attempt` and `ready_works` reach readiness through `ready_value` and follow it unchanged.

### 10.4 How the build serves the decisions, and which CONC result it gives

- **N-284 C** (self-check, run 10): a widening naming the current owner authority, an earlier one, or a purpose change on the current one: `mission_authority` with 22 (1)'s first reason (`RM-widen-current-authority`, `-earlier-authority`, `RM-purpose-current-authority`); answered an hour before the current revision: `mission_authority`, 22 (1)'s second reason; `answered_at` NULL: `could_not_check`, `owner_authority: answered_at missing`; equal times and an answer after: `ok`, a new revision and one event; a narrowing naming the current owner authority and a status-only call: `ok`.
- **N-289 B**: before the epoch moves, a live claim keeps `already_claimed`, readiness false and `other_class_claim` in all four Rule C functions; after it moves (`update … set epoch = epoch + 1`, a plant): `ready_value` true, `ready_works` lists the items, `claim` answers `ok` with generation 2, the earlier claim is `expired` and its `claim_expired` (origin `rule`) names epochs 1 and 2; the four Rule C calls answer `ok`; a claim of the current epoch still gives `other_class_claim` and `already_claimed`; the old token's `heartbeat` is `claim_epoch`; a lease run out in the current epoch is still marked `expired`; the epoch's row deleted: `claim` `could_not_check` (`epoch: the global authority epoch is missing`) and Rule C `could_not_check` with the new reason; the table renamed: `could_not_check`.
- **N-292 B**: from a supporting or challenging source the walk lists what it supports or challenges, and not the reverse; `part_of` both ways, siblings included; `derived_from` as built; `explain_paths` gives `[[y, x]]` for `y supports x` and `[]` back; a planted NULL-type relation is not walked and makes `complete` false from either end, and in `explain_paths`.
- **N-296 (3) B**: a `withdrawn` Finding to each of the three statuses: `invalid_field`, 22 (5)'s reason, one refusal row each, the status unchanged; a `candidate` control `ok`.
- **N-288**: the three bodies, and `revise_mission` and `revise_work`, answer `ok` when renamed and called under the new name (`AL-*-renamed`); the reason parameter reaches the event.
- **T-W07-CONC, the two programs** (runs 17 to 20, each on a fresh copy):

| Program | M09-08's head (`t20`) | With M09-RC (`t21`) |
|---|---|---|
| merged (workers revoke their tokens as their transactions commit) | `PASS (8/8)` | `FAIL (1 bad, 0 could not check, of 8)`, bad `CONC-claim` |
| revised, pull request #375 (tokens revoked after every connection of the run has ended) | `PASS (8/8)` | `PASS (8/8)` |

  So the build gives the merged CONC the failure CHK-C02-095 3.3 foresaw: a later loser counts the winner's claim, whose epoch the winner's own revocation has just ended, as lapsed and claims too (EV13 22 (6)). Under the revision the build gives one claim per run. B-CONC-1 stays red on this build under the revised program (`CONC-claim`, exactly its red list), and B-CONC-2 turns exactly `CONC-cyc2` and `CONC-cyc4` red there (run 24).

### 10.5 Every merged file and break that calls a replaced function, on this build and on M09-08's head

**The list** (N-299 (2); CHK-C02-095 C2): a text search of `job/` and `breaks/` at `1daa352` for each replaced function's name as `devos_api.<name>`, `'<name>'` or `"<name>"`: 34 job files and 23 break patches (for `claim` alone 27 job files and 3 patches, CHK-C02-095's 30). A wider search for the bare names adds only files that name them in comments or in other words (checked one by one: B-5C-1, B-6RG-2, B-DM07-1, B-DM34-1, B-F01-2, B-F01-6, B-F08-1 to -4, B-N08-5, B-N17-1, `w07_dm19b_burst_over_http.py`). `ready_value` is private and named by no test.

**The job files** (runs 15 and 16, each file on a fresh copy of each template; run 06 runs every staged file once more on the main cluster, with the same summaries; run 11 F01 at epoch 2):

| File | M09-08's head | With M09-RC |
|---|---|---|
| `w07_5a_no_direct_writes.sql` | PASS (168/168) | same |
| `w07_5a_positive_control.sql` | PASS (1/1) | same |
| `w07_5b_authorization_matrix.sql` | COULD NOT CHECK (6 of 210; rows of functions not yet built) | same |
| `w07_5c_other_session_fake_id.sql` | PASS (8/8) | same |
| `w07_5d_format_gates_empty.sql`, `w07_6st_settings_could_not_check.sql`, `w07_dm47_path_table.sql`, `w07_fgfind_finding_gate.sql`, `w07_n01_need_justification.sql`, `w07_n02_decision_alternatives.sql`, `w07_n03_effort_policy.sql`, `w07_n08_exam_fact.sql`, `w07_n08_exam_records.sql`, `w07_n28_sample_exemption.sql`, `w07_n29_impact_class.sql`, `w07_t31_planted_rate.sql` | COULD NOT CHECK (1 of 1: their `-pre` line, W-C02-10's tables or M09-09's `record_eval_run`) | same |
| `w07_6rg_rule_gate_could_not_check.sql` | PASS (27/27) | same |
| `w07_dm07_heartbeat.sql` | PASS (8/8) | same |
| `w07_dm11_answer_revision.sql` | FAIL (5 bad of 8: DM11-a to -e, W-C02-10's answer gate) | same |
| `w07_dm19_rejected_attempt_survives.sql` | PASS (5/5) | same |
| `w07_dm34_mission_scope.sql` | PASS (10/10) | same |
| `w07_f01_whole_intent.sql` | COULD NOT CHECK (1 of 13: F01-g at epoch 1, N-297 (1)); PASS (13/13) at epoch 2 (run 11) | same |
| `w07_f04_affected_records.sql` | PASS (22/22) | same |
| `w07_f05_scope_both_sides.sql` | PASS (7/7) | same |
| `w07_f06_state_change_event.sql` | PASS (92/92) | **COULD NOT CHECK (2 of 92)**: `F06-event:revise_mission` and `F06-repeat:revise_mission` |
| `w07_f07_observation_history.sql` | PASS (7/7) | same |
| `w07_f08_recheck_at_effect.sql` | PASS (17/17) | same |
| `w07_k05_many_paths.sql` | PASS (6/6) | same |
| `w07_n04_self_approval.sql` | COULD NOT CHECK (3 of 19: the transfer functions, M09-10 to M09-12) | same |
| `w07_n09_finding_gate.sql` | PASS (5/5) | same |
| `w07_n17_claim_token.sql` | PASS (13/13) | same |
| `w07_rel_relation_status.sql` | PASS (4/4) | same |
| `w07_roc_ownership_and_claim_class.sql` | PASS (84/84) | same |
| `w07_conc_claim_and_cycle.py` | PASS (8/8) | **FAIL**, bad `CONC-claim` (10.4) |

**The break patches** (runs 21 to 43, each on a fresh copy of each template; "exact" means the bad set equals its header's expect-red list):

| Patch | With M09-RC | M09-08's head |
|---|---|---|
| B-5B-3 | exact (`5B-R25-review_finding-cal`) | exact |
| B-6RG-1 | exact (19) | exact |
| B-CONC-1 | merged CONC exact (`CONC-claim`); revised CONC exact | both exact |
| B-CONC-2 | merged CONC `CONC-claim`, `-cyc2`, `-cyc4` (one extra: `CONC-claim`, the merged program's own epoch change); revised CONC exact (`CONC-cyc2`, `-cyc4`) | both exact |
| B-F04-1, -2, -3, -6, -7, -8, -9 | exact (2, 3, 4, 2, 3, 1, 1) | exact |
| B-F04-4, -5 | `F04-e-exam` red; their N08 entries not shown (N08 stops at its `-pre` line) | the same |
| B-F06-1 | exact (`F06-event:relate`, `F06-role-token`); 4 could not check (the two `revise_mission` cases besides the patch's own two) | exact; 2 could not check |
| B-K05-1 | exact (`K05-rows`) | exact |
| B-N08-4, B-N29-3, B-N29-5 | not shown: N08 and N29 stop at their `-pre` lines | the same |
| B-N09-1 | exact (4) | exact |
| B-REL-1 | exact (`REL-a`, `REL-b`) | exact |
| B-ROC-1 | ROC's two entries exact (`ROC-leak-cancel_work`, `ROC-o-cancel_work-cal-exam`); the N08 entries not shown (`-pre`) | **12 bad**: every `cancel_work` case of ROC, N-288's fault |
| B-ROC-2 | exact (5) | **15 bad**: the five and every `cancel_work` case, N-288's fault |
| B-ROC-3 | exact (9) | exact |

**Which results change, and why.**
- **F06's `revise_mission` cases** become `could_not_check`: its Decision `d2` is planted without `answered_at` (`job/w07_f06_state_change_event.sql:495`), and N-284 C makes a NULL `answered_at` on a widening `could_not_check`, as EV13 22 (1) foresaw ("F06's `revise_mission` recipe sets `answered_at` on its Decision `d2`"). Under break k11 (the order-of-answers checks removed) F06 is `PASS (92/92)` again (run 54), which places the cause. The test designer's fixture change (22 (1)) is due; no expected outcome changes.
- **The merged CONC** fails `CONC-claim`, by its own epoch changes during the race (10.4); its revision on #375 passes. That is N-299 (1)'s condition, which comes before this migration's verdict (i).
- **B-ROC-1 and B-ROC-2** now show their break, which M09-08's head could not (N-288).
- **B-CONC-2 under the merged CONC** has one entry beyond its red list, for the reason above; under the revised program it is exact.
- No other result of the 57 files changes.

### 10.6 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0908b` at `1daa352`, with M09-RC, EV13's section 23 and the raw files uncommitted. The main run (`…/mcorr_run/rerun.sh`) ran from 2026-10-19T03:16:25Z to 03:16:38Z on one cluster; the comparison and break runs (`brk.sh`) from 03:16:38Z to 03:20:53Z on a second cluster; then `final.sh` wrote files 63 to 65. EV13's bytes in file 65 are its bytes as filed.
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `catalog.sql` and `setup.sql` are `…/m0908_run/`'s, changed only in their paths (the cluster under `…/mcorr_run/pg`, the socket in `…/scratchpad/mcs`) and their label word. `fn_check.sql` keeps M09-08's harness (`m_call`, `m_case`, `m_rec`, `m_work`, `m_claim`) with this migration's counted tables and cases. `judge.py` reads a test's output and prints its summary, its bad and could-not-check case IDs and, given a red list, whether the bad set equals it. `search.sql` is 10.3's catalogue query. `build.py` makes M09-RC and file 66.
- **Trial runs.** Before the filed runs, the self-check once (117 of 117 after its first fixture order, which left one work item with a hard dependency before its claim, was fixed), the main run once (`…/mcorr_run/trial1`) and the comparison and break runs once (`…/mcorr_run/trial2`), none filed. After `trial2` began, one comment of `claim` was reworded, since its words "from a" tripped the catalogue's unqualified-name scan; no statement changed, and the filed runs use the reworded bytes. The filed runs give the same summary lines as the trials.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the twenty migrations of `main`, each `[exit 0]` with its history row. **03, M09-RC:** `CREATE FUNCTION` ×13, `COMMENT` ×2, `REVOKE` ×13, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 12:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 21, "migrations_expected": 21`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result): the summaries of 10.5's "With M09-RC" column, and besides the list `W07_6TK_TOKEN_REASONS PASS (32/32)`, `W07_DM19B_BURST_COUNT PASS (12/12)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W07_N25_VERDICT_STALENESS PASS (5/5)`, `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad, 0 could not check, of 3)` (as before M09-RC, 8.4), `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`; run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 10.1's listing. **09, the live-claim search:** 10.3.
- **10, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC W-C02-09 mcorr; one transaction rolled back): `MCORR_FUNCTIONS PASS (117/117)`: 14 for `revise_mission`, 8 for `review_finding`, 8 for N-288, 36 for N-289 (`claim`, readiness, the four Rule C functions, the epoch's row, the old token, `revoke_claim` as built), 34 for the walks, 17 for the text (`TX-alias`, the eleven literals, the read marker, `claim_live` owner only, the predicate in the six, `claim`'s order, `revoke_claim` unchanged). Each compares the answer's code and the change of seven tables, and the state cases read rows after. Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt` and `event`.
- **11, T-W07-F01 once more** after the global epoch is set to 2: `W07_F01_WHOLE_INTENT PASS (13/13)`.
- **13:** the server log, no string of either format; `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **14:** the second cluster's setup, the templates `t20` and `t21` (`[template … exit 0]`), and `brk.py`: 18 `made k…`.
- **15 and 16:** the 33 SQL files of the list on copies of `t20` and of `t21` (10.5). **17 to 20:** CONC (10.4).
- **21 to 43, the merged break patches** (10.5), each `[patch exit 0]`.
- **44 to 61, the break copies of M09-RC**, each on a fresh copy of `t20` with the copy applied in place of M09-RC (`[apply exit 0]`), then the self-check and the staged files named for it. Each turned the self-check red; the cases named are the first ones each break reaches, and later ones are knock-on effects (a call the break wrongly admits writes a record that later cases on the same Mission meet):
  - **k01**, `claim_live` ignores the epoch: red `RV-ready-after`, `RW-after-lists`, `CL-after` and its three state cases, the four `RC-*-after`.
  - **k02**, `claim`'s live count without the predicate: red `CL-after` and its state cases, `TX-predicate-in-six`, `TX-claim-epoch-before-count`. **k03**, `claim` marks only a lapsed lease: red `CL-after` and its state cases (the new Assignment meets `assignment_one_active_claim`, `write_failed`). **k04**, the payload without the epochs: red `CL-after-event`.
  - **k05**, `ready_value` without the predicate: red `RV-ready-after`, `RW-after-lists`, `CL-after` and its state cases, `TX-predicate-in-six`.
  - **k06 to k09**, one Rule C count each without the predicate: red `RC-revise_work-after`, `RC-cancel_work-after`, `RC-relate-after`, `RC-retract_relation-after` respectively, and `TX-predicate-in-six`.
  - **k10**, a widening on the Mission's own decision admitted: red `RM-widen-current-authority`, `-earlier-authority`, `RM-purpose-current-authority` and knock-on cases. **k11**, the order of answers removed: red `RM-widen-answered-before`, `-answered-null` and their reasons, and knock-on cases; F06 `PASS (92/92)`. **k12**, an equal time refused: red `RM-widen-answered-equal` only.
  - **k13**, `supports` as built: red the four supports cases. **k14**, `part_of` one way: red `W-part_of-from-part-lists`, `W-paths-part_of-up-one`. **k15**, a NULL type counted complete: red the three NULL-type cases.
  - **k16**, a withdrawn Finding admitted: red the six `RF-withdrawn-*` cases and `RF-withdrawn-unchanged`.
  - **k17**, `mark_stale` naming a parameter through its function's name: red `AL-mark_stale-renamed`, `TX-alias`.
  - **k18**, an unjudgeable epoch counted live: red `EP-missing-rule-c` and its reason.
  - So each rule built turns its self-check cases red when removed. The merged files run with them (DM07, F08, 6RG, N17, ROC, F06, N29, F04, K05, N09) stay as without the break: **no merged test reaches any of the five decisions**, which are new rules whose tests the test designer is writing (EV-C02-017 section 9 item 6). Until those merge, the decisions rest on the producer's self-check alone.
- **62:** the server log, no string of either format; `[cluster directory deleted: yes]`.
- **63:** the text search (10.3). **64:** every other mc raw file scanned with the finders of `scan_patterns.json`: no string of either format. **65:** the hashes in the envelope; `backslashes in the corrective migration: 0`; no `psql` meta-command line; no string either finder finds; no line holding either marker whole; `git status --porcelain`: EV13 and this record modified, M09-RC and the raw files untracked; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty. **66:** the per-function difference.

### 10.7 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done):
   - The new cases and breaks of EV-C02-017 section 9 item 6 (N29 and F06's `d2` with `answered_at`; F08 or DM07; F04; N09 or its own specification). No merged case reaches the five decisions yet (10.6, runs 44 to 61).
   - T-W07-CONC's revision on #375 (N-299 (1)) is due before this migration's verdict (i): the merged program fails `CONC-claim` on this build.
   - F06's `d2` gets `answered_at` (EV13 22 (1)); until then `F06-event:revise_mission` and `F06-repeat:revise_mission` are `could_not_check` here.
2. **For the executor** (reported, not done):
   - EV13 23 (2)'s consequence: with a live-looking claim and the epoch's row missing, Rule C and readiness now refuse or give unknown where they counted the claim live. No merged case plants that; it fails closed.
   - `revoke_claim` stays as built (N-299's annotation); this migration does not touch it.
   - The merged migrations' comments above `ready_value`, `claim`, the four Rule C functions and the two walks still describe the rules before this file. A migration file is not edited after it is applied; this file's comments state what each function now does.
3. **For the checker of verdict (i):** EV13 section 23 with its *[C-RC]* marks; 10.2's departures, chiefly 2, 3 and 5; the self-check and break copies, which are the producer's own; that the six counts and the claim's order are as 10.3 and 23 (3) state.
4. **Residuals:**
   - The two clocks of N-284 C (EV13 22 (1)), compared as recorded.
   - Before C06 no Mission can be widened in the database (EV13 22 (1), accepted consequence).
   - A claim ended by an epoch change reads as a failure under B 3.26's FrameReview signal until that signal reads the payload's two epochs (EV13 22 (3)).

## 11. M09-09: exam, backup and reads

The producer's record of `supabase/migrations/20261019100001_w09_exam_backup_reads.sql` (M09-09). It was written on branch `claude/c02-w09-m0909` at `3a7baa69c8ba64472e56f1bd8d948d17b5c59e59`: `main` `45db7a3` with M09-01 to M09-08 merged and applied, plus the rule corrections (`20261019080001_w09_rule_corrections.sql`, section 10) from pull request #377, under review. M09-09 builds on both and changes neither. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at `3a7baa6`, with EV13's section 24 added. M09-09 means the file above, and M09-09:n a line of it at the bytes the envelope names. `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 24 first.** EV13 gained "24. Correction, 2026-10-19 (M09-09)", which states the forms 11.2 lists, with marks *[C-M09]* in the six rows of 2.8. M09-09's checker judges it.
- **The note items that bind M09-09, checked on the branch before the SQL was kept** (`plan/work/C02.md`):
  - **N-286** (deadline: before M09-09's first commit): `open_decision` on T-W07-N08's exempt list. **Met** on `main`: EV-C02-008 5.1's dated list item and the N08 revision (L-384) are merged; part A's notice lists the ten exempt functions that name EvalRun's table, `open_decision` among them, and part X's four `N08-x-open_decision-*` cases are `ok` (run 06), B-N08-6 turning exactly `N08-x-open_decision-cal` red (run 19).
  - **N-300 (2)**, for this producer: B-ROC-1's N08 entries, B-N08-3 and B-N08-4 on the real `record_eval_run`. Answered in 11.4: B-ROC-1 now shows its whole list; B-N08-3 and B-N08-4 still cannot be shown, by faults in the two patches.
  - **N-288** (parameters not named through the function's name): **met**, every body with parameters reads them through `ALIAS FOR $n` (self-check `TX-alias`).
  - **EV-C02-013 22 (3)** (every count of a live claim through `devos_private.claim_live`): M09-09 counts no live claim. Its one read of claims, `record_eval_run`'s second layer, judges the status `active` as recorded (EV13 24 (3)) and holds no lease comparison (file 52: `its lines naming claim_live: 1`, a comment).
  - **This record's 9.6 item 4** ("an effect's claim check is `check_claim`, then `ready_value`"; no claim token in an event or refusal row): M09-09 has no effect that takes a claim, and none of its six functions names a claim token (`TX-no-claim-token`; file 52: `its lines naming a claim token: 0`).
  - **N-285 (1), N-291, N-293** (planted Missions without a creation event): none reaches M09-09's functions, which read no Mission. N08 part A's `N08-wp2` plants its work item under such a Mission and is `ok`: `record_eval_run` is not under Rule O (EV-C02-008 1.7.1's list).
  - **N-279 (19)** (Group B's files, N08 among them, audited for the `env_token` counting fault before their first result): N08's files are W-C02-10's copies (R:248); not audited here.
- **Appendix B principle 3** binds `record_eval_run`: the run's reference to its work item carries the revision it means (`work_revision`), and the revision must exist. EvalRun has no revisions of its own.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0909` at `3a7baa6`, clean before this work. The runs were made with M09-09, EV13's section 24 and the raw files uncommitted (O, `52_git_hashes.txt`). Bytes run: M09-09 `16ba60a59546f7607904371ccf9e9ef0cca81becd2f3800fef843c6b8129fc71`; the self-check `…/scratchpad/m0909_run/fn_check.sql` `8648be2792a46cd5fc468cca8abb148d4e2289f8a48cd3c220c3e4a5994e79d1`; the break maker `…/m0909_run/brk.py` `1a716a6320dec3ad6e8af449bc5792f7e25df8bb7e4c5eecb71ac3f8354f3ff2`; the other drivers' hashes are in file 52. EV13 with its section 24 as run: `398d1d5c0dea2d81001d84073bd3776dbfcd364b05110545e79d984387784c08` (the database runs do not read it). A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 10: one throwaway PostgreSQL 16.15 cluster per script, unix socket only (in `…/scratchpad/m9s`, under the 107-byte limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, files 11 and 50: `[cluster directory deleted: yes]`). Stand-ins: `…/scratchpad/m0903_run/setup.sql`, byte for byte (`fa2a9cfa…9783`, the hash section 9 names). The break runs copy each fresh database from one of two templates: `t21`, the twenty-one migrations before M09-09, and `t22`, `t21` with M09-09. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `3a7baa6`; EV13 with its sections 1 to 23, and section 24 (for M09-09's checker) |
| Input | The twenty-two migrations (`main`'s twenty, the rule corrections, M09-09); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `job/` and T-W14-FN's, run in place; the producer's self-check; twenty-one break copies of M09-09 made outside the repository (`…/scratchpad/m0909_brk/`, by `brk.py`, deleted after the run); fourteen merged break patches of `tests/C02/W-C02-07/breaks/` applied in place on the throwaway cluster, and one scratch adaptation of B-N08-1 (`…/m0909_run/adapted/`, the producer's, not the merged patch) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m09_offline_01_init_setup.txt` to `…_52_git_hashes.txt`, written directly by `…/m0909_run/rerun.sh` (01 to 11), `brk.sh` (12 to 50) and `final.sh` (51, 52). Every file but 52 passed through `scrub.py` (section 10's filter, reading the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time) and ends `claim-format strings replaced 0; environment-format strings replaced 0` (51 of 51). File 51 scans files 01 to 50 again with the same finders: `50 files; claim-format 0; environment-format 0`. Files 11 and 50 scan the clusters' server logs: `256 lines; claim-format 0; environment-format 0` and `640 lines; claim-format 0; environment-format 0`. File 52 holds hashes, counts and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09), the break copies (29 to 49) and the adapted B-N08-1 (28) are the producer's own; the merged files and break patches (06, 07, 13 to 27) are the test designers' |

### 11.1 What was built, object by object

All in M09-09, in this order: the six functions of EV13 2.8, the four reads' comments, the grants. No table, type or `devos_private` function is added; M09-01 to M09-08 and the rule corrections are not changed. Their helpers are called: `caller_role_class`, `write_event` and `reject`. The form of every function is M09-03's to M09-08's (4.1 to 9.1): the derivation first; the read block with steps (b) to (f), a decided refusal through `v_code`, `v_reason` and `P0D01`, any other error `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`; for the two state-changing functions the write block, where an error is `write_failed`, but `P0D02`; one per-call row by `reject` after a refusal; fixed reasons. O (`08_catalog.txt`): each of the six has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, EXECUTE for `anon` only (also `TX-definer`).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.record_eval_run(p jsonb)` (M09-09:43) | Role `devos_sinav`. The form of 24 (1) (`work_revision` absent: `could_not_check`, M09-09:127-130); the work item `for share` (M09-09:168; none: `could_not_check`); the revision named (none: `could_not_check`; an earlier one accepted); the work item's claims (M09-09:183-196): a claim of the caller's class whose status is `active`, `invalid_field`; a claim without its status or role class, `could_not_check`. Writes the EvalRun (M09-09:211) and `eval_run_recorded` on aggregate `eval_run`, payload `{}` (M09-09:215); nothing on the Work. Answer `{"status": "ok", "id"}`; refusal rows name no target | 2.8's row with C-M09 (24 (1) to (3)); B 3.15; EV-C02-008 5.1 (c) bounds 2 and 3; DM-24; README 8.1 |
| `devos_api.read_eval_run(eval_run_id uuid)` (M09-09:236) | Role `devos_sinav`. `missing_field`; `not_found` (M09-09:280); answer `{"status": "ok", "eval_run": {the ten fields}}`; refusal rows name the id. Comment `devos:read …` | 2.8's row with C-M09 (24 (7)); EV-C02-008 1.4 (R10r); B 3.15; DM-36 |
| `devos_api.mark_exported(p jsonb)` (M09-09:309) | Role `devos_backup`. The form of 24 (4) (`from_id` greater than `to_id`: `invalid_field`, M09-09:385); the rows of the range not yet marked listed and locked `for update` (M09-09:390-405), a counted RejectedAttempt row only after its hour (M09-09:404); none to mark: no write, `id` null, `"repeat": true` when every row of a non-empty range is marked (M09-09:416-421); else the rows marked by id (M09-09:427, :429) and one `exported` event on aggregate `export`, payload `{table, from_id, to_id, marked}` (M09-09:433). Answer `{"status": "ok", "id", "marked"}` | 2.8's row with C-M09 (24 (4)); B 3.13 (B:266, B:270); B section 2's `devos_backup` row; EV-C02-008 5.2 |
| `devos_api.read_rejected_attempts(since timestamptz)` (M09-09:456) | Role `devos_denetim`. `missing_field`; rows created at or after `since`, or counted rows whose hour ends after it (M09-09:501-503), the twelve fields, ordered by id. Answer `{"status": "ok", "rows"}`. Comment `devos:read …` | 2.8's row with C-M09 (24 (5)); EV-C02-008 1.4 (R15); B:270; README 8.1 |
| `devos_api.authority_epoch()` (M09-09:523) | The six classes, as a literal. The epoch read without a lock (M09-09:556); missing or NULL: `could_not_check`. Answer `{"status": "ok", "epoch"}`. Comment `devos:read …` | 2.8's row with C-M09 (24 (7)); EV-C02-008 1.4 (R12); B principle 9 |
| `devos_api.fingerprint_matches(hashes text[])` (M09-09:586) | Role `devos_ci`. `missing_field`; empty, or an element NULL or empty, `invalid_field` (M09-09:621-629); one entry per distinct hash and origin (M09-09:631-635), never `source_ref`; the store absent `could_not_check`. Answer `{"status": "ok", "matches"}`. Comment `devos:read …` | 2.8's row with C-M09 (24 (6)); EV-C02-008 1.4 (R13); B 3.23; Appendix C N06 |
| Grants (M09-09:650-682) | `revoke all … from public` and from the four API roles where they exist, on all six; `grant execute … to anon` on all six; no type, no private function | 1 item 13; T-W08-PRIV (`W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, unchanged) |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the forty-one `devos_api` functions.
- **The literals**, as the break patches read them: `record_eval_run` and `read_eval_run` `array['devos_sinav']`, `mark_exported` `array['devos_backup']`, `read_rejected_attempts` `array['devos_denetim']`, `fingerprint_matches` `array['devos_ci']`, `authority_epoch` the six (`TX-literals`).
- **The unqualified-name scan**: no hit in M09-09's six; its four hits are section 3.1's known false ones.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker**: twelve functions, the eight of section 9 and `authority_epoch`, `fingerprint_matches`, `read_eval_run`, `read_rejected_attempts` (also `TX-read-marker`; F06: `41 devos_api functions (12 marked devos:read)`).
- **The exam table.** Of the six, only `record_eval_run` and `read_eval_run` name `devos_private.eval_run` (`TX-exam-table`; file 52: `its lines naming the exam table (devos_private.eval_run): 2`).

### 11.2 Departures from EV-C02-013, and forms it left open

Each is stated in EV13 section 24; none is silent. No merged test is changed.
1. **`record_eval_run` accepts an earlier revision of its work item** (24 (1)): the run names the revision the exam task was opened as (B 3.15; EV-C02-008 1.7.1), so `stale_revision` does not apply. A `work_ref` or revision that names nothing is `could_not_check` (a reference, item 14 with R1-2), not `not_found`.
2. **Its event holds no EvalRun field** (24 (2)): payload `{}`, against section 1 item 10's "the change", so that the exam link stays in EvalRun alone (B 3.15) and no exam record reaches the export before C09 designs it (EV-C02-008 5.1 (d)). Break k06 shows that no merged test would see a payload that held the link.
3. **The second layer judges the status `active`, not a live claim** (24 (3)): the stricter of two readings, outside section 22 (3)'s predicate because it counts the trace of a fault, not a live claim. Break k04 (the live reading) turns `N08-s4-run` red, since the merged test plants its claim with the lease `now()`.
4. **`mark_exported`'s open forms** (24 (4)): integers of at least 1; a marked row keeps its time; a no-row call writes no event and answers `id` JSON null, `"repeat": true` only for a non-empty range wholly marked.
5. **`read_rejected_attempts`' selection** (24 (5)): counted rows whose hour ends after `since` are included; no row limit.
6. **`fingerprint_matches`' element rule and distinct entries** (24 (6)); the store absent is `could_not_check` (N06).
7. **The two other reads' answers** (24 (7)).
8. **EvalRun's readers** (24 (8)): `read_eval_run` names the table in its own text, so T-W07-N08's finder finds it as a reader beyond `record_eval_run` and the ten exempt functions and holds it to the role refusal, which it meets. A private helper that would hide it from the finder was weighed and not chosen.

Not departures, for the checker:
- No function of M09-09 checks Rule O: `record_eval_run` is not among the functions EV-C02-008 1.7.1 binds, and the four reads have no ownership limit after the gate (EV-C02-008 1.4).
- `record_eval_run` reads EvalRun's table only to write it; it never reads an EvalRun for its answer.

### 11.3 How W-C02-09's points are served by M09-09

- **Point 1.** A versioned file later than `20261019080001`, plain SQL, no `psql` meta-command, no backslash (O, `52_git_hashes.txt`: `backslashes in M09-09: 0`). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject` on every refusal, read functions included (`{"rejected": 1}` deltas in the self-check);
  - F06's list: the four reads carry the read marker, the other two are state-changing (`F06-list | ok | 41 devos_api functions (12 marked devos:read)`);
  - `mark_exported`'s one event per call (B:266; DM-31): `ME-pos-event`, `F06-event:mark_exported` `ok`.
  - Offline, `deployment_drift` reports `no_difference`, 22 of 22 (runs 04 and 10).
- **Point 2.** Forty-one of the 55 `devos_api` functions now exist (six here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (11.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the six refuses a call with no token before any other check (`F06-refused:record_eval_run`, `:mark_exported`, `F06-read-refused:read_eval_run`, `:read_rejected_attempts`, `:authority_epoch`, `:fingerprint_matches` `ok`; the self-check's `*-no-token`). Each refuses a class not on its list with one per-call row: 5B rows R10, R10r, R12, R13, R15 and R17, all thirty-six cells `ok`; N08's `N08-w-*` and `N08-r-read_eval_run-*` `ok`.
  - Fifth bullet. A declared role name and origin change nothing: `RE-pos` sends `role_class` `devos_kurulum` and `origin` `owner`, and the event carries `devos_sinav` and `call`; a declared session is written as declared (`RE-pos-event`, `ME-pos-event`).
- **Point 5.**
  - Each state-changing function writes its event in the same transaction with the token's class (`RE-pos-event`, `ME-pos-event`; `F06-event:record_eval_run`, `:mark_exported` `ok`).
  - An exact repeat writes nothing: `ME-repeat` (`ok repeat`, `{}`), `F06-repeat:mark_exported` `ok`. `record_eval_run` has none (a creating call; `RE-repeat-is-a-new-run`).
  - A failure planted mid-transaction leaves no half state and no orphan event: `RE-write-failed`, `RE-write-event-failed`, `ME-write-failed` (only the refusal row is added); `RE-write-P0D02`, `ME-write-P0D02`: `could_not_check` with the fixed reason.
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass: `RE-work_revision-missing`, `RE-work-names-nothing`, `RE-revision-beyond`, `RE-claim-partial`, `RE-claims-unreadable`, `RE-work-unreadable`, `RV-unreadable`, `ME-unreadable`, `RR-unreadable`, `AE-missing`, `AE-unreadable`, `FM-store-absent`.
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the six, run in place (run 06):
    - **T-W07-N08 part X `PASS (61/61)`** (`w07_n08_exam_fact.sql`), N08-s3, the five N08-s4 cases, the EXF pairs and the forty N08-x cases;
    - **T-W07-N08 part A `FAIL (1 bad, 0 could not check, of 14)`** (`w07_n08_exam_records.sql`): every case `ok` but `N08-rp-read_eval_run`, which cannot pass on a build that follows 2.8 (11.4);
    - **T-W07-5B `COULD NOT CHECK (1 of 241 could not be checked)`**: `5B-row-R19` only (the transfer functions, M09-10 to M09-12); none `bad`;
    - **T-W07-F06 `COULD NOT CHECK (2 of 105 could not be checked)`**: the two `revise_mission` cases of section 10.5 (its `d2` without `answered_at`); every case of the six `ok`;
    - **T-W07-6TK `PASS (32/32)`** (its second-function list holds `record_eval_run` and `mark_exported`, after `revoke_claim`, which it takes first);
    - every other file as on the rule corrections' head (10.5's "With M09-RC" column; T-W07-DM19B's SQL part `PASS (12/12)`; its part B, which reads `read_rejected_attempts` over the Data API, needs sitting A's endpoint and is not run offline); run 07 is T-W14-FN's `FN-pre`.
  - Their copies are a later pull request's (R:247; EV13 section 11: T-W07-N08 part X "may copy" if every case passes on this build, R:248).

### 11.4 What M09-09 does not yet serve

- **Merged tests that cannot pass on a correct build** (EV13 24 (9)), for the test designer:
  - **T-W07-N08 part A's `N08-rp-read_eval_run`**: the finder calls `read_eval_run` with a random uuid and wants acceptance; 2.8 answers an id that names no EvalRun `not_found` (run 06: `code not_found; … ra {"read_eval_run|not_found|devos_sinav": 1}`). Under break k08 (an unknown id answered `ok`) part A is `PASS (14/14)` (run 36), which places the cause in the case. So part A is FAIL here, and W9 point 8's N08 does not count until the case is revised.
  - **B-N08-1** refuses to apply on the build (run 14: `w07 break not applied: no role list naming devos_sinav found in a devos_api function reading the exam records`): it selects `eval_runs`, the stand-in's name. The producer's adaptation (run 28) turns `N08-r-read_eval_run-devos_calisma` red, with part A's standing `N08-rp-read_eval_run`.
  - **N-300 (2)'s answer**, on the real `record_eval_run`:
    - **B-ROC-1** now shows its whole list: ROC `FAIL (2 bad …, of 84)`, `ROC-leak-cancel_work`, `ROC-o-cancel_work-cal-exam`, and part X `FAIL (2 bad …, of 61)`, `EXF-pair-cancel_work`, `N08-x-cancel_work-cal` (run 20): the four are exactly its expect-red list. It needs no revision.
    - **B-N08-3** still cannot be shown: its wrapper writes `p->>'work_ref'`, a text, into `event.aggregate_id`, a uuid (run 16: `column "aggregate_id" is of type uuid but expression is of type text 42804`), so every accepted run raises and part X is `COULD NOT CHECK (2 of 8 …)`, `EXF-pair-fixtures` and `N08-s3`. A cast (`::uuid`) in its insert is the fix's likely form (**Inf**).
    - **B-N08-4** still cannot be shown: its wrapper's Assignment omits the NOT NULL `work_revision`, `generation`, `authority_epoch` and `lease_expires_at` (run 17: `null value in column "work_revision" of relation "assignment" violates not-null constraint 23502`), so `EXF-pair-sin-claim`, `N08-s4-claim-unlinked`, `-working` and `-code` are `could_not_check`.
  - The other merged patches run (11.5, runs 15, 18, 19, 21 to 27) each turn exactly their list red, across the files their headers name, but B-5B-1, whose list names `N04-e1-record_verdict`, no case of N04 on this build (section 8.5); part A's standing `N08-rp-read_eval_run` stays red beside B-N08-2's.
- **Rules no merged test reaches**, resting on the producer's self-check alone (the break copies the merged files run with stay green): the event's empty payload (k06), the earlier revision accepted (k05 is its neighbour, the revision named unchecked), `mark_exported`'s counted rows of the current hour (k09), its `from_id` greater than `to_id` (k12), `read_rejected_attempts`' selection (k15, k16), `authority_epoch`'s missing row (k17), `fingerprint_matches`' `source_ref`, empty array and absent store (k18 to k20), and `record_eval_run`'s partial claim (k21). `read_rejected_attempts` over the Data API is T-W07-DM19B part B's, after sitting A.
- **W9 point 8's N08** counts only once `N08-rp-read_eval_run` is revised; its part X passes here.

### 11.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0909` at `3a7baa6`, with M09-09, EV13's section 24 and the raw files uncommitted. The main run (`…/m0909_run/rerun.sh`) ran from 2026-10-19T03:48:19Z to 03:48:32Z on one cluster; the comparison and break runs (`brk.sh`) from 03:48:32Z to 03:49:18Z on a second cluster; then `final.sh` wrote files 51 and 52.
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py` and `catalog.sql` are `…/mcorr_run/`'s, changed only in their paths (the clone `prd13`, the cluster under `…/m0909_run/pg`, the socket in `…/scratchpad/m9s`) and their label word; `setup.sql` is `…/m0903_run/setup.sql`, byte for byte. `judge.py` is section 10's, which also prints each bad or could-not-check case's line, cut to 300 characters. `fn_check.sql` is `fn_head.sql` (section 10's harness: `m_call`, `m_code`, `m_case`, `m_rec`, `m_work`) and `fn_cases.sql` (this migration's counted tables, fixtures and cases). `brk.py`, `brk.sh`, `rerun.sh` and `final.sh` follow section 10's forms.
- **Trial runs.** Before the filed runs, one trial of the migrations with the self-check and N08's two files, then the main run once (`…/m0909_run/trial1`) and the break runs twice (`trial2`, `trial3`; the second after `judge.py` gained its detail lines), none filed. The self-check gave 153 of 153 at its first run. The filed runs give the same summary and bad-case lines as the trials (compared after the run).

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the twenty-one migrations before M09-09, each `[exit 0]` with its history row (42 `[exit 0]` lines). **03, M09-09:** `CREATE FUNCTION` ×6, `COMMENT` ×4, `REVOKE` ×6, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 22, "migrations_expected": 22`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result): 11.3's point 8, and `W07_N08_EXAM_RECORDS FAIL (1 bad, 0 could not check, of 14)` with the notice `exempt by name (EV-C02-008 5.1), naming devos_private.eval_run: affected_entities, cancel_work, explain_paths, mark_stale, open_decision, relate, reopen_for_review, retract_relation, revise_work, set_effort_policy` and `1 devos_api functions other than record_eval_run read devos_private.eval_run`; `W07_N08_EXAM_FACT PASS (61/61)`, among them `N08-s3 | ok`, `N08-s4-run | ok | … refused [invalid_field work_ref: a claim of the exam environment's class is active on the work …`, `EXF-pair-state | ok`; besides, as on the rule corrections' head: `W07_DM11_ANSWER_REVISION FAIL (5 bad …)`, `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad …)`, `W07_F01_WHOLE_INTENT COULD NOT CHECK (1 of 13 …)` (F01-g at epoch 1), `W07_N04_SELF_APPROVAL COULD NOT CHECK (3 of 19 …)`, the files of W-C02-10's tables on their `-pre` line; run 07 is T-W14-FN's `FN-pre`.
- **08, the catalogue:** 11.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC m0909; one transaction rolled back): `M0909_FUNCTIONS PASS (153/153)`.
  - The cases: 53 for `record_eval_run`, 14 for `read_eval_run`, 29 for `mark_exported`, 16 for `read_rejected_attempts`, 18 for `authority_epoch`, 17 for `fingerprint_matches` and 6 for the text.
  - Each compares the answer's code and the change of nine counts (EvalRun, Work, its revisions, Assignment, LeakFingerprint, events, events marked, refusals, refusals marked); the state cases read the rows after.
  - Among them: `RE-pos-row`, `RE-pos-event`, `RE-no-work-write`; `RE-sin-claim-active`, `-lapsed`, `-lease-now`, `-earlier-epoch`: `invalid_field`; `RE-sin-claim-released`, `RE-cal-claim-active`: `ok`; `RV-pos-fields`, `RV-not-found-row`; `ME-pos-rows`, `ME-repeat` (`ok repeat`, `{}`), `ME-keeps-first-time-row`, `ME-ra-rows`, `ME-ra-only-current-hour`; `RR-pos-rows`, `RR-counted-hour-rows`, `RR-fields-only`; `AE-moved-epoch`; `FM-pos-matches`, `FM-no-source-ref`; `TX-literals`, `TX-alias`, `TX-read-marker`, `TX-exam-table`, `TX-no-claim-token`, `TX-definer`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, `eval_run_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `eval_run`.
- **11:** the server log, `256 lines; claim-format 0; environment-format 0`; `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **12:** the break cluster's setup, the templates `t21` and `t22` (`[template … exit 0]`), and `brk.py`: `21 break copies made`.
- **13, the control** on fresh copies of `t22`: N08 part A `FAIL (1 bad …, of 14)` (`N08-rp-read_eval_run`), part X `PASS (61/61)`, 5B `COULD NOT CHECK (1 of 241 …)`, F06 `COULD NOT CHECK (2 of 105 …)`, ROC `PASS (84/84)`, F04 `PASS (22/22)`, N04 `COULD NOT CHECK (3 of 19 …)`, 6TK `PASS (32/32)`.
- **14 to 27, the merged break patches**, each on a fresh copy of `t22` (`[patch exit 0]` but 14), with the files their headers name; "exactly" means the bad set over those files equals the header's list:
  - **14, B-N08-1:** `[patch exit 3]`, not applied (11.4).
  - **15, B-N08-2:** `N08-w-devos_ci` and `5B-R10-record_eval_run-ci` red, exactly its list, beside part A's standing `N08-rp-read_eval_run`.
  - **16, B-N08-3:** part X `COULD NOT CHECK (2 of 8 …)` (11.4). **17, B-N08-4:** part X `COULD NOT CHECK (4 of 61 …)` (11.4).
  - **18, B-N08-5:** `N08-s4-run` red, exactly. **19, B-N08-6:** `N08-x-open_decision-cal` red, exactly.
  - **20, B-ROC-1:** `ROC-leak-cancel_work`, `ROC-o-cancel_work-cal-exam`, `EXF-pair-cancel_work`, `N08-x-cancel_work-cal` red, exactly.
  - **21, B-F04-4** and **22, B-F04-5:** `F04-e-exam` and the eight N08 cases of each list red, exactly.
  - **23, B-EXF-1:** `EXF-pair-ready_works` red, exactly.
  - **24, B-5B-1:** `5B-R07-record_verdict-cal`, `N04-a1`, `-a2`, `-c1`, `-c2` red; its list's `N04-e1-record_verdict` is no case of N04 on this build, as section 8.5 found (`record_verdict` has no session argument). **25, B-5B-2:** `5B-R05-revoke_claim-cal`, `6TK-ka1` red, exactly. **26, B-5B-3:** `5B-R25-review_finding-cal` red, exactly.
  - **27, B-F06-1:** `F06-event:relate`, `F06-role-token` red, exactly; 4 could not check (the two `revise_mission` cases and `retract_relation`'s two, whose fixture the patch's `relate` makes), as on section 10's runs.
- **28, the adapted B-N08-1** (the producer's): `[patch exit 0]`; `N08-r-read_eval_run-devos_calisma` red, with `N08-rp-read_eval_run`.
- **29 to 49, the break copies**, each in a fresh database copied from `t21` with the copy applied in M09-09's place (`[apply exit 0]`), then the self-check and the staged files named for it. Each turned the self-check red (`M0909_FUNCTIONS FAIL (n of 153 not as wanted)`); the red cases named, and the merged cases that turned `bad`:
  - **k01**, `record_eval_run` admits `devos_calisma`: red `RE-gate-devos_calisma`, `TX-literals`; merged **`N08-w-devos_calisma`, `N08-w2-devos_calisma`, `5B-R10-record_eval_run-cal` `bad`**.
  - **k02**, an event on the Work: red `RE-pos` and six more by their event delta, and `RE-no-work-write`; merged **`N08-s3`, `EXF-pair-state` `bad`**.
  - **k03**, the second layer removed: red the five `RE-sin-claim-*` cases; merged **`N08-s4-run` `bad`**. **k04**, the second layer through `claim_live`: red `RE-sin-claim-lapsed`, `-lease-now`, `-earlier-epoch`; merged **`N08-s4-run` `bad`** (24 (3)).
  - **k05**, the revision named unchecked: red `RE-revision-beyond` (the write fails, `write_failed`). **k06**, the event payload holds the link: red `RE-pos-event`; part X and F06 stay as without the break.
  - **k07**, `read_eval_run` admits `devos_calisma`: red `RV-gate-devos_calisma`, `TX-literals`; merged **`N08-r-read_eval_run-devos_calisma`, `5B-R10r-read_eval_run-cal` `bad`**. **k08**, an unknown id answered `ok`: red `RV-not-found`, `RV-not-found-row`; part A **`PASS (14/14)`** (11.4).
  - **k09**, a counted row of the current hour marked: red `ME-ra`, `ME-ra-rows`, `ME-ra-only-current-hour`. **k10**, an event with no row marked: red `ME-repeat`, `ME-empty-range`, `ME-ra-only-current-hour`; merged **`F06-repeat:mark_exported` `bad`**. **k11**, marked rows marked again: red `ME-repeat`, `ME-keeps-first-time-row`; merged **`F06-repeat:mark_exported` `bad`**. **k12**, `from_id` greater than `to_id` admitted: red `ME-from-after-to` and its reason. **k13**, `mark_exported` admits `devos_denetim`: red `ME-gate-devos_denetim`, `TX-literals` and five knock-on cases (the admitted call marks the rows later cases use); merged **`5B-R17-mark_exported-den` `bad`**.
  - **k14**, `read_rejected_attempts` admits `devos_calisma`: red `RR-gate-devos_calisma`, `TX-literals`; merged **`5B-R15-read_rejected_attempts-cal` `bad`**. **k15**, a counted row of an open hour dropped: red `RR-counted-hour-rows`. **k16**, `since` ignored: red `RR-pos-rows`, `RR-counted-hour-rows`.
  - **k17**, the epoch's missing row answered: red `AE-missing` and its reason.
  - **k18**, `source_ref` returned: red `FM-pos-matches`, `FM-no-source-ref`. **k19**, an empty array admitted: red `FM-empty`. **k20**, the store absent answered clean: red `FM-store-absent` and its reason.
  - **k21**, a partial claim read as clean: red `RE-claim-partial` and its reason.
  - So each rule built turns its self-check cases red when removed. The merged files caught nine of the twenty-one (k01 to k04, k07, k10, k11, k13, k14); the self-check caught all twenty-one.
- **50:** the server log, `640 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **51:** files 01 to 50 scanned with the finders of `scan_patterns.json`: `50 files; claim-format 0; environment-format 0`.
- **52:** the hashes in the envelope; `backslashes in M09-09: 0`; `psql meta-command lines in it: 0`; `its strings found by either token finder: … claim-format 0; environment-format 0`; `its lines holding either marker whole: 0`; `its lines naming the exam table (devos_private.eval_run): 2`; `git status --porcelain`: EV13 modified, M09-09 and the raw files untracked, before this section was written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 11.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-N08 part A's `N08-rp-read_eval_run`: a reader whose parameter names an exam record needs an EvalRun's id, not a random uuid (11.4; EV13 24 (9)). Until then part A cannot PASS on a build that follows 2.8.
   - B-N08-1's selection names the stand-in's `eval_runs`; B-N08-3's insert lacks a cast to `uuid`; B-N08-4's Assignment lacks four NOT NULL columns (11.4).
   - Cases and breaks for the rules no merged test reaches (11.4), among them `mark_exported`'s counted-hour rule (B:270) and `fingerprint_matches` with the store absent (N06, C03's).
2. **For the executor** (reported, not done):
   - **This task's instruction** read "T-W07-N08's finder must find no reader beyond `record_eval_run` and the ten exempt functions". `read_eval_run`, 2.8's R10r reader, names the table, so the finder finds it; it meets the finder's role rule. The build follows 2.8 and B 3.15 rather than hide the reader (EV13 24 (8)); whether the instruction meant otherwise is the executor's to say.
   - **The `eval_run_recorded` payload** (EV13 24 (2)) is a reading of B 3.15 that C09's export design may revisit (EV-C02-008 5.1 (d); N-176).
   - **T-W07-N08 part X's copy**: EV13 section 11 lets W-C02-09 copy it "if every case passes on this build" (R:248); it passes here offline (61/61). Part A does not, so the test as a whole is not PASS until 1's revision.
3. **For the checker of verdict (i):** EV13 section 24 with its *[C-M09]* marks; 11.2's departures, chiefly 2, 3 and 8; the self-check and break copies, which are the producer's own.
4. **Residuals:**
   - `read_rejected_attempts` returns every row since a time, with no limit (EV13 24 (5)).
   - `mark_exported` marks by id range; an event row that commits later inside a range already marked waits for a later call (EV13 24 (4)).
   - `authority_epoch` reads without a lock: an increment committed after the read is seen by the next call.

## 12. M09-10: transfer runs and events

The producer's record of `supabase/migrations/20261019120001_w09_transfer_runs_events.sql` (M09-10). It was written on branch `claude/c02-w09-m0910` at `21847e76fae7dfce104fa9e78b1f4758917fc1c7`: `main` `6ec7a53` with M09-01 to M09-08 and the rule corrections merged and applied, plus M09-09 (`20261019100001_w09_exam_backup_reads.sql`, section 11) from pull request #379, under review. M09-10 builds on both and changes neither. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at `21847e7`, with EV13's section 25 added. M09-10 means the file above, and M09-10:n a line of it at the bytes the envelope names. FN is `tests/C02/W-C02-14/T-W14-FN_transfer_functions.md`, FNJ its job file; `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 25 first.** EV13 gained "25. Correction, 2026-10-19 (M09-10)", which states the forms 12.2 lists, with marks *[C-M10]* in 3.1's bullets "The run", "Closing" and "Order" and in the six rows of 3.2. M09-10's checker judges it.
- **The note items that bind M09-10, checked on the branch before the SQL was kept** (`plan/work/C02.md`; W9 point 10):
  - **N-277 (3)** (W9 point 10, last bullet but one: the commit that merges T-W14-FN is an ancestor of the first commit that builds an S5 function): **met.** FNJ was added in `f40f135`, an ancestor of `21847e7`, and its revision of 2026-10-18 (`04da0de`, the 109 cases) is too; no migration at `21847e7` creates any of the fourteen (file 52's git state; a `git grep` of `supabase/migrations/` at HEAD), so M09-10's commit is the first.
  - **N-279 (13)** (T-W14-FN's FN-T and FN-I cases for the ten, and `mission_authority`, `run_not_open` and `cycle`): merged in `04da0de`; the file run here holds 109 cases.
  - **N-288** (parameters not named through the function's name): **met**, every body reads `p` through `ALIAS FOR $1` (self-check `TX-alias`).
  - **EV-C02-013 22 (3)** (every live-claim count through `devos_private.claim_live`) and **this record's 9.6 item 4** (an effect's claim through `check_claim`; no claim token in an event or a refusal row): none of the six takes a claim, counts one or names a claim token (`TX-no-claim`; file 52: `its lines naming claim_live, check_claim or assignment: 0`, `its lines naming a claim token: 0`).
  - **N-285 (1), N-291, N-293** (planted Missions without a creation event): only `record_ledger_entry` reads a Mission (Rule O's `kur` clause), and there such a Mission is `could_not_check` (`LE-mission-no-event`); Rule O is not bent. No merged recipe reaches it so: T-W14-FN's and F06's stage Works are transferred under the installation's Mission (FNJ `w14_prep`; F06's late fill `stage`). `transfer_event` reads no Mission, so FNJ's planted Works (`w14_work`, under a Mission with no event) are accepted as its aggregates.
  - **N-279 (18), (21)** (`transfer_acceptance`'s target, the sampling call of the transfer's records): M09-11's and M09-12's functions, not this file's.
- **Appendix B principle 3** binds `transfer_artifact`: the Artifact is written at revision 1 and its mark names it at revision 1 (EV-C02-005 3.3: every transferred record is revision 1). The events of `transfer_event`, `record_ledger_entry` and `record_handover` carry the aggregate's revision where the call names one or the record has a current one.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0910` at `21847e7`, clean before this work. The runs were made with M09-10, EV13's section 25 and the raw files uncommitted (O, `52_git_hashes.txt`). Bytes run: M09-10 `5f82540c7f3586c3f393931170769bf57b6c8758dc2a9db89bd263ee4dbe788a`; the self-check `…/scratchpad/m0910_run/fn_check.sql` `ebec3e815be734000d279c4351afabc662446dd7f3d8c656e2e321f83308e639`; the break maker `…/m0910_run/brk.py` `80b97080cff6ac15fb6344c311ad303aa7da51255243a662da77fee556c8f675`; the other drivers' hashes are in file 52. EV13 with its section 25 as run: `919a9a203591b65ed7ce20b7aa781dca8e5bdba7141c43f8bffc42990ebf88e5` (the database runs do not read it). A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 11: one throwaway PostgreSQL 16.15 cluster per script, unix socket only (in `…/scratchpad/m10s`, under the 107-byte limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, files 11 and 50: `[cluster directory deleted: yes]`). Stand-ins: `…/scratchpad/m0903_run/setup.sql`, byte for byte (`fa2a9cfa…9783`). The break runs copy each fresh database from one of two templates: `t22`, the twenty-two migrations before M09-10, and `t23`, `t22` with M09-10. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `21847e7`; EV13 with its sections 1 to 24, and section 25 (for M09-10's checker) |
| Input | The twenty-three migrations (`main`'s twenty, the rule corrections, M09-09, M09-10); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `job/` and T-W14-FN's, run in place; the producer's self-check; twenty-nine break copies of M09-10 made outside the repository (`…/scratchpad/m0910_brk/`, by `brk.py`, deleted after the run); the six merged break patches of `tests/C02/W-C02-14/breaks/` B-FN-1 to B-FN-6, applied in place on the throwaway cluster |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m10_offline_01_init_setup.txt` to `…_52_git_hashes.txt`, written directly by `…/m0910_run/rerun.sh` (01 to 11), `brk.sh` (12 to 50) and `final.sh` (51, 52). Every file but 52 passed through `scrub.py` (section 10's filter, reading the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time) and ends `claim-format strings replaced 0; environment-format strings replaced 0` (51 of 51). File 51 scans files 01 to 50 again with the same finders: `50 files; claim-format 0; environment-format 0`. Files 11 and 50 scan the clusters' server logs: `228 lines; claim-format 0; environment-format 0` and `724 lines; claim-format 0; environment-format 0`. File 52 holds hashes, counts and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09) and the break copies (21 to 49) are the producer's own; the merged files and break patches (06, 07, 13 to 20) are the test designers' |

### 12.1 What was built, object by object

All in M09-10, in this order: six of the fourteen functions of EV13 section 3 (section 10's row M09-10), then the grants. No table, type, comment or `devos_private` function is added; M09-01 to M09-09 and the rule corrections are not changed. Their helpers are called: `caller_role_class`, `write_event`, `reject` and `is_installation_mission`. The form of every function is M09-03's to M09-09's (4.1 to 11.1): the derivation first; the read block with steps (b) to (f), a decided refusal through `v_code`, `v_reason` and `P0D01`, any other error `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`; the write block, where an error is `write_failed`, but `P0D02`; one per-call row by `reject` after a refusal; fixed reasons. O (`08_catalog.txt`): each of the six is `devos_api.<name>(p jsonb)` returning `jsonb`, with `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, EXECUTE for `anon` only (also `TX-definer`, `TX-signature`).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.begin_transfer_run(p jsonb)` (M09-10:57) | The form of 25 (2); the closing rule (M09-10:170-176, `handed_over`); the run's advisory lock (M09-10:180); a begun run of the same `run_id`: the same input commit, manifest, counts and mode is the exact repeat, else `conflict` (M09-10:191-203); a run event without its phase `could_not_check`. Writes one `transfer_run` event, phase `begun`, on a new aggregate `transfer_run`, payload the six keys. Answer `{"status": "ok", "id"}` | 3.2's row with C-M10 (25 (1), (2)); README 8.1; EV-C02-005 3.2, S1; B 3.13 |
| `devos_api.end_transfer_run(p jsonb)` (M09-10:242) | The form of 25 (3); the closing rule (M09-10:323-329); the run's advisory lock (M09-10:333); never begun `run_not_open` (M09-10:347-350); completed with the same counts the exact repeat, with other counts `run_not_open` (M09-10:351-358, R2-9). Writes one `transfer_run` event, phase `completed`, on the run's aggregate. Answer `{"status": "ok", "id"}`, the run's aggregate | 3.2's row with R2-9 and C-M10 (25 (1), (3)) |
| `devos_api.record_handover(p jsonb)` (M09-10:400) | The form of 25 (4); the closing rule (M09-10:477-483: one hand-over, and its second call is `handed_over`); a begun run (none: `reference_missing`, M09-10:495-498); the installation's Mission (none: `reference_missing`; two, or one that cannot be told: `could_not_check`, M09-10:501-537). Writes `ledger_handed_over` on the Mission at its current revision, payload the four keys; S1's index is the backstop. Answer `{"status": "ok", "id"}`, the Mission | 3.2's row with R1-8, R2-9 and C-M10 (25 (4)); section 4 (the hook `installation_mission`); EV-C02-005 3.4, S1 |
| `devos_api.transfer_event(p jsonb)` (M09-10:581) | The form of 25 (5) and (8); the closing rule (M09-10:801-807); the key (M09-10:809-827: the exact repeat, `conflict`); the open run (M09-10:830-846, `run_not_open`); the aggregate, locked for share (M09-10:848-872: no record of the kind's family, or no such revision, `reference_missing`); for `ledger_state_row` the installation's Mission (M09-10:873-886). Writes the typed event and, on the same aggregate, its `transferred` mark naming it by `event_id`. Answer `{"status": "ok", "id"}`, the typed event's id | 3.1 and 3.2's row with C-M10 (25 (1), (5), (8)); EV-C02-005 2.3, 2.5, 3.1; B 3.13 |
| `devos_api.record_ledger_entry(p jsonb)` (M09-10:936) | The form of 25 (6); the stage's Work for share (none: `could_not_check`); its current revision and Mission; Rule O's `kur` clause (M09-10:1062-1073: `not_owner`, or `could_not_check`); the entry ID's advisory lock and key (M09-10:1076-1087: the same Work and payload is the exact repeat, else `conflict`). Not closed by the hand-over. Writes one `ledger_entry` event on the Work at its current revision, no mark. Answer `{"status": "ok", "id"}`, the event's id | 3.2's row with C-M10 (25 (6)); EV-C02-008 1.7.1 (Rule O), 2.3's "What Rule O reads"; EV-C02-005 2.5, S1 |
| `devos_api.transfer_artifact(p jsonb)` (M09-10:1129) | The form of 25 (7) and (8) (`scope` `installation`, M09-10:1277-1281); the closing rule after the form (M09-10:1305-1313: after the hand-over only a `git_tree` or a check's verdict file, else `handed_over`); the key (M09-10:1315-1337); the run (M09-10:1339-1367: after the hand-over a `run_id` present `run_not_open`; before it an open run). Writes the Artifact, its revision 1 and its mark (after the hand-over `"run_id": null`, `"after_handover": true`). Answer `{"status": "ok", "id", "revision": 1}` | 3.1 and 3.2's row with R1-8 and C-M10 (25 (1), (7), (8)); EV-C02-005 1.2 row 19, 2.4, 12; B 3.10 |
| Grants (M09-10:1413-1444) | `revoke all … from public` and from the four API roles where they exist, on all six; `grant execute … to anon` on all six; no type, no private function | 1 item 13; T-W08-PRIV (`W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, unchanged) |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the forty-seven `devos_api` functions.
- **The literals**, as the break patches read them: all six hold `array['devos_kurulum']::devos_private.role_class[]` (`TX-literals`).
- **The unqualified-name scan**: no hit in M09-10's six; its four hits are section 3.1's known false ones.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker**: twelve functions, as in section 11; none of the six carries it (`TX-not-read`; F06: all six are state-changing).
- **No exam table, no claim**: none of the six names `eval_run`, `assignment`, `check_claim`, `claim_live` or a claim token (`TX-no-claim`; file 52).

### 12.2 Departures from EV-C02-013, and forms it left open

Each is stated in EV13 section 25; none is silent. No merged test is changed.
1. **The common order** (25 (1)): the closing rule before the exact repeat, so a closed function refuses even an exact repeat after the hand-over (B:397, as R2-9 reads it for `record_handover`); the exact repeat before the run, so a repeat that names a completed run is `ok` (section 1 item 10).
2. **`begin_transfer_run`'s repeat** (25 (2)), the stricter reading: the same input commit, manifest, counts and mode, not the manifest alone; and the run's key read under an advisory lock on the `run_id` (key 9002), which `end_transfer_run` also takes.
3. **`end_transfer_run`** (25 (3)): the answer's `id` is the run's aggregate.
4. **`record_handover`** (25 (4)): a begun run, completed or not; the installation's Mission found as `is_installation_mission` reads it; the event at the Mission's current revision.
5. **`transfer_event`** (25 (5)): the kind's family; `aggregate_revision` checked (a Need's `invalid_field`, a missing one `reference_missing`); `entry_date` a date; `ledger_state_row` on the installation's Mission only.
6. **`record_ledger_entry`** (25 (6)): a `stage_work_id` that names no Work is `could_not_check`, not `reference_missing` (a new entry, not a copy; 16 (2)); the repeat, the stricter reading, is the same Work and payload across every `ledger_entry` event of the entry ID.
7. **`transfer_artifact`** (25 (7)): a refusal 3.2's row does not name, `scope` other than `installation` (`invalid_field`; EV-C02-005 1.2 row 19); `commit` 40 characters; before the hand-over no `run_id` is `run_not_open`.
8. **Common forms** (25 (8)): `transfer_source`'s six fields validated and stored as six; `declared` and `source_fields` objects, into the mark only, verbatim.

Not departures, for the checker:
- `transfer_event`, `transfer_artifact`, `begin_transfer_run`, `end_transfer_run` and `record_handover` check no ownership: EV-C02-008 1.7.1's Rule O lists none of the transfer's functions, and 3.2's rows name ownership only for `record_ledger_entry` (25 (9) states the residual for `transfer_event`).
- The three functions of 3.1's "Sampling" are M09-11's; none of these six samples.

### 12.3 How W-C02-09's points are served by M09-10

- **Point 1.** A versioned file later than `20261019100001`, plain SQL, no `psql` meta-command, no backslash (O, `52_git_hashes.txt`: `backslashes in M09-10: 0`, `psql meta-command lines in it: 0`). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject` on every refusal (`{"rejected": 1}` deltas in the self-check), and the counted form for a call with no token (`G-<fn>-no-token`; FN-G-<fn>'s counted row +1);
  - F06's list: all six are state-changing, none carries the read marker (`F06-list`, file 06);
  - S1's event types and S2's key as W-C02-08 built them: the `transferred` mark meets `event_transferred_transfer_source`, and S2's index is the backstop of the key.
  - Offline, `deployment_drift` reports `no_difference`, 23 of 23 (runs 04 and 10).
- **Point 2.** Forty-seven of the 55 `devos_api` functions now exist (six here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (12.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the six refuses a call with no token before any other check (`G-<fn>-no-token`; FN-G-<fn> `ok`, the counted row +1), and each refuses a class not on its list with one per-call row (`G-<fn>-<class>`; 5B row R19, all thirty-six cells of the six `ok`; FN-G-<fn> `ok`).
  - Fifth bullet. A declared role name and origin change nothing: `BR-pos` sends `role_class` `devos_denetim` and `origin` `owner`, `TE-pos` `origin` `owner`, `TA-pos` `role_class` `devos_denetim`, and their events carry `devos_kurulum` and `call`; a declared session is written as declared (`BR-pos-event`, `TE-pos-event`, `LE-pos-event`, `HO-pos-event`).
- **Point 5.**
  - Each function writes its events in the same transaction with the token's class (`BR-pos-event`, `ER-pos-event`, `HO-pos-event`, `TE-pos-event`, `TE-pos-mark`, `LE-pos-event`, `TA-pos-mark`; FN-T-ev-end_transfer_run, -transfer_event, -transfer_artifact `ok`).
  - An exact repeat writes nothing and answers the existing id: `BR-repeat`, `ER-repeat`, `TE-repeat`, `LE-repeat`, `TA-repeat`, `TA-after-repeat` (`ok repeat`, `{}`); FN-I-same-end_transfer_run, -transfer_event, -transfer_artifact `ok`. `record_handover`'s second call is refused `handed_over` (`HO-second-call`, R2-9).
  - A failure planted mid-transaction leaves no half state and no orphan event: `BR-write-failed`, `ER-write-failed`, `HO-write-failed`, `TE-write-failed`, `TE-write-mark-failed`, `LE-write-failed`, `TA-write-failed`, `TA-write-mark-failed` (only the refusal row is added); `BR-write-P0D02`, `TA-write-P0D02`: `could_not_check` with the fixed reason; FN-T-half-ev-end_transfer_run, -transfer_event, -transfer_artifact `ok`.
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass: `BR-run-partial`, `BR-events-unreadable`, `ER-run-partial`, `HO-two-installations`, `HO-mission-revisions-unreadable`, `TE-state-row-mission-untold`, `TE-state-row-two-installations`, `TE-works-unreadable`, `LE-stage-names-nothing`, `LE-mission-no-event`, `LE-events-unreadable`.
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the six, run in place (runs 06, 07; compared with `t22` in runs 13 and 14):
    - **T-W07-5B `PASS (276/276)`** (`COULD NOT CHECK (1 of 241 …)` on `t22`, its row R19 unjudged): the thirty-six cells of R19's six functions are now judged, each `ok`;
    - **T-W07-F06 `COULD NOT CHECK (6 of 117 could not be checked)`** (`PASS (105/105)` on `t22`): the six functions' `F06-refused` cases `ok`; their `F06-event` cases `could_not_check`, "no recipe: its fixture could not be made: … D-010's Decision (transfer_mission's prerequisite) was not transferred" (12.4);
    - **T-W14-FN `FAIL (1 bad, 77 could not check, of 109)`** (`COULD NOT CHECK (1 of 1 …)`, FN-pre, on `t22`): `FN-M-cat` `bad`, since eight of the fourteen are not built yet; thirty-one cases `ok`, among them every FN-G and FN-G-pos case of the six, FN-C-begin_transfer_run, -end_transfer_run, -transfer_event, FN-O-transfer_artifact-other, and FN-T-ev, FN-T-half-ev, FN-I-same and FN-I-other of `end_transfer_run`, `transfer_event` and `transfer_artifact`; the rest `could_not_check` on the functions of M09-11 and M09-12 (12.4);
    - T-W07-N02 and T-W07-N04 as on `t22` (`COULD NOT CHECK`: they need `transfer_decision` or `transfer_review` first); T-W07-6TK `PASS (32/32)` as on `t22`;
    - every other file as file 06 shows; none of them calls the six.
  - Their copies are a later pull request's (R:247; EV13 section 11: T-W14-FN's copy is made "after its recipe revision", and it passes only with M09-12).
- **Point 10.** Six of the fourteen exist, each as point 2 asks (FN-M-cat's detail names the eight missing). The second bullet's parts reached by the six: each refuses every class but `devos_kurulum` and a call with no token, with the attempt recorded (FN-G); after a planted hand-over `begin_transfer_run`, `end_transfer_run` and `transfer_event` refuse (FN-C), `transfer_artifact` refuses a file that is not a verdict file (FN-O-transfer_artifact-other) and writes a verdict file and a tree (`TA-after-verdict-file`, `TA-after-tree`), and `record_ledger_entry` still writes (`LE-after-handover`, `CL-ledger-entry`; FN-O-record_ledger_entry waits for M09-11); with one write planted to fail nothing stays (FN-T-half-ev); an exact repeat writes nothing, and another hash is refused with its row (FN-I). W-C02-08's S1 to S4 still pass T-W14-SCH (`PASS (38/38)`, run 05). T-W14-FN cannot pass before M09-12, so point 10 is not met by this file alone.

### 12.4 What M09-10 does not yet serve

- **Merged tests that cannot pass at this head on a correct build** (EV13 25 (10)), none for a fault of the build:
  - **T-W14-FN**: FN-M-cat needs all fourteen; every case that needs the installation's Mission waits for `transfer_decision` and `transfer_mission` (M09-11): FN-T-ev, FN-T-half-ev, FN-I-same and FN-I-other of `record_handover` and `record_ledger_entry`, FN-C-record_handover, FN-O (the four in one block) and FN-A. Three cases are `ok` for the wrong reason while their functions are absent: FN-T-half-ev-transfer_review, FN-T-half-rec-transfer_review and FN-T-half-ev-transfer_decision read a raised call ("function … does not exist") as "not accepted". For the test designer: a raised answer could make those cases `could_not_check`, as FN-G's do.
  - **T-W07-F06** goes from `PASS (105/105)` on `t22` to `COULD NOT CHECK (6 of 117)` here, since its fourteen transfer recipes are made in one fixture block that begins with `transfer_decision`. It passes again only when M09-11 exists, if the rest of that block holds. So F06 counts at M09-09's head and not at this one; the order of the merges decides when F06's result can be taken.
- **The merged breaks** (runs 15 to 20, each on a fresh copy of `t23`):
  - **B-FN-2** (`begin_transfer_run` does not see the hand-over): `[patch exit 0]`; `FN-C-begin_transfer_run` red, its whole expect-red list, beside the standing `FN-M-cat`. It is shown on the real `begin_transfer_run`.
  - **B-FN-1, B-FN-3 to B-FN-6** wrap `transfer_review`, `transfer_decision` and `transfer_acceptance`, which M09-11 and M09-12 build: `[patch exit 3]` each, not applied; their red lists stay unshown here.
- **Rules no merged test reaches**, resting on the producer's self-check alone (their break copies leave every merged case as without the break): `begin_transfer_run`'s conflict and repeat (b03, b04), `end_transfer_run`'s never-begun run (b07), all of `record_handover`'s (b08 to b10, whose merged cases wait for M09-11), `transfer_event`'s open run, aggregate, kind and `ledger_state_row` rules (b13 to b15, b17), all of `record_ledger_entry`'s (b18 to b20), and `transfer_artifact`'s path anchor, run after the hand-over, open run, mark and scope (b22 to b24, b26, b27).

### 12.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0910` at `21847e7`, with M09-10, EV13's section 25 and the raw files uncommitted. The main run (`…/m0910_run/rerun.sh`) ran from 2026-10-19T04:22:28Z to 04:22:43Z on one cluster; the comparison and break runs (`brk.sh`) from 04:22:43Z to 04:23:20Z on a second cluster; then `final.sh` wrote files 51 and 52.
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `judge.py`, `catalog.sql` and `fn_head.sql` are `…/m0909_run/`'s, changed only in their paths (the clone `prd14`, the cluster under `…/m0910_run/pg`, the socket in `…/scratchpad/m10s`) and their label words; `setup.sql` is `…/m0903_run/setup.sql`, byte for byte. `fn_check.sql` is `fn_head.sql` (section 10's harness: `m_call`, `m_code`, `m_case`, `m_rec`, `m_work`) and `fn_cases.sql` (this migration's counted tables, fixtures and cases). `brk.py`, `brk.sh`, `rerun.sh` and `final.sh` follow section 11's forms; `brk.sh`'s comparison runs each named file on `t22` and on `t23`, and its patch step reads the test path a T-W14-FN patch names.
- **Trial runs.** Before the filed runs: the migration applied once, which failed on its first form (an `IF` whose condition held a `CASE … THEN`, which PL/pgSQL ends at the first `THEN`; the `CASE` was put in parentheses, M09-10:469); then T-W14-FN once, the self-check once (`220/220` at its first run), the main run once (`…/m0910_run/trial1`) and the break runs once (`trial2`), none filed. The filed runs give the same summary and bad-case lines as the trials (compared after the run).

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the twenty-two migrations before M09-10, each `[exit 0]` with its history row (44 `[exit 0]` lines). **03, M09-10:** `CREATE FUNCTION` ×6, `REVOKE` ×6, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 23, "migrations_expected": 23`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result): 12.3's point 8; besides, `W07_F04_AFFECTED_RECORDS PASS (32/32)`, `W07_ROC_OWNERSHIP_AND_CLAIM_CLASS PASS (84/84)`, `W07_N08_EXAM_FACT PASS (61/61)`, `W07_N08_EXAM_RECORDS FAIL (1 bad, 0 could not check, of 14)` (section 11.4's `N08-rp-read_eval_run`), `W07_DM11_ANSWER_REVISION FAIL (5 bad …)`, `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad …)`, the files of W-C02-10's tables on their `-pre` line; run 07 is `W14_FN_TRANSFER_FUNCTIONS FAIL (1 bad, 77 could not check, of 109)`, `FN-M-cat | bad | absent, not security definer, or without a fixed search_path: transfer_mission, transfer_work, transfer_relation, transfer_decision, transfer_review, transfer_acceptance, transfer_need, transfer_finding`.
- **08, the catalogue:** 12.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC m0910; one transaction rolled back): `M0910_FUNCTIONS PASS (220/220)`.
  - The cases: 54 for the gate (six functions, five classes, no token, and three neutral calls each), 28 for `begin_transfer_run`, 14 for `end_transfer_run`, 15 for `record_handover`, 40 for `transfer_event`, 21 for `record_ledger_entry`, 36 for `transfer_artifact`, 6 after the accepted hand-over (`CL-*`) and 6 for the text.
  - Each compares the answer's code and the change of nine counts (events, refusals, Artifact and its revisions, Work and its revisions, Mission and its revisions, Need); the state cases read the rows after. A plant runs with its call in a subtransaction that is undone, and the delta is measured after the plant.
  - Among them: `BR-repeat`, `BR-conflict-manifest`, `-mode`, `-counts`, `BR-completed-run-resumed`; `ER-repeat`, `ER-other-counts`; `HO-no-installation`, `HO-two-installations`, `HO-completed-run`, `HO-second-call`; `TE-agg-revision-beyond`, `TE-need-revision`, `TE-state-row-other-mission`, `TE-ledger-entry-payload`, `TE-repeat-completed-run`; `LE-other-mission`, `LE-conflict-stage`, `LE-conflict-transferred-entry`, `LE-after-handover`; `TA-scope-other`, `TA-no-run`, `TA-after-verdict-file`, `TA-after-tree`, `TA-after-other-file`, `TA-after-verdict-path-prefix`, `TA-after-with-run`, `TA-after-repeat`, `TA-after-mark`; `CL-begin`, `CL-end`, `CL-event`, `CL-event-repeat`, `CL-ledger-entry`, `CL-artifact-verdict`; `TX-literals`, `TX-signature`, `TX-alias`, `TX-not-read`, `TX-no-claim`, `TX-definer`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `artifact`.
- **11:** the server log, `228 lines; claim-format 0; environment-format 0`; `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **12:** the break cluster's setup, the templates `t22` and `t23` (`[template … exit 0]`), and `brk.py`: `29 break copies made`.
- **13 and 14, the comparison** of T-W14-FN, 5B, F06, N02, N04 and 6TK on fresh copies of `t22` and `t23`: 12.3's point 8.
- **15 to 20, the merged break patches** B-FN-2, then B-FN-1 and B-FN-3 to B-FN-6, each on a fresh copy of `t23`: 12.4.
- **21 to 49, the break copies**, each in a fresh database copied from `t22` with the copy applied in M09-10's place (`[apply exit 0]`), then the self-check and T-W14-FN (and 5B for b01). Each turned the self-check red (`M0910_FUNCTIONS FAIL (n of 220 not as wanted)`); the red cases named, and the merged cases that turned `bad` besides the standing `FN-M-cat`:
  - **b01**, `begin_transfer_run` admits `devos_calisma`: red `G-begin_transfer_run-devos_calisma`, `TX-literals`; merged **`FN-G-begin_transfer_run`, `5B-R19-begin_transfer_run-cal` `bad`**.
  - **b02**, `begin_transfer_run` does not see the hand-over: red `BR-after-handover`, `CL-begin` and `BR-events-unreadable-reason` (the check that now reads the events first is `run`); merged **`FN-C-begin_transfer_run` `bad`**. **b03**, its conflict removed: red `BR-conflict-manifest`, `-mode`, `-counts`. **b04**, its repeat writes again: red `BR-repeat`, `-repeat-id`, `BR-completed-run-resumed`.
  - **b05**, `end_transfer_run` does not see the hand-over: red `ER-after-handover`, `CL-end`; merged **`FN-C-end_transfer_run` `bad`**. **b06**, its repeat judged after `run_not_open`: red `ER-repeat`, `-repeat-id`; merged **`FN-I-same-end_transfer_run` `bad`**. **b07**, a never-begun run unchecked: red `ER-never-begun` (the write fails, `write_failed`).
  - **b08**, `record_handover` does not see the hand-over: red `HO-after-handover`, `HO-second-call` (S1's index then makes it `write_failed`). **b09**, its run unchecked: red `HO-run-never-begun` and nine knock-on cases (the admitted call writes the one hand-over, which later cases meet). **b10**, a missing installation Mission unchecked: red `HO-no-installation` (`could_not_check` in its place).
  - **b11**, `transfer_event` does not see the hand-over: red `TE-after-handover`, `CL-event`, `CL-event-repeat`; merged **`FN-C-transfer_event` `bad`**. **b12**, its conflict removed: red `TE-conflict`; merged **`FN-I-other-transfer_event` `bad`**. **b13**, its run unchecked: red `TE-run-never-begun`, `-run-completed` and seven knock-on cases (the admitted call writes the source's mark, which later cases with the same key meet). **b14**, its aggregate unchecked: red `TE-agg-names-nothing`, `-agg-a-need-as-work`, `-agg-revision-beyond` and four knock-on. **b15**, a type that differs from the kind admitted: red `TE-type-mismatch` and nine knock-on. **b16**, the mark without `event_id`: red `TE-pos-mark`, `TE-repeat`, `-repeat-id`, `-repeat-completed-run`, `TE-conflict`; merged **`FN-T-ev-transfer_event`, `FN-I-same-transfer_event`, `FN-I-other-transfer_event` `bad`**. **b17**, `ledger_state_row` on any Mission: red `TE-state-row-other-mission`, `-mission-untold`, `-two-installations`.
  - **b18**, `record_ledger_entry`'s Rule O removed: red `LE-other-mission`, its reason, `LE-mission-no-event` and one knock-on. **b19**, its conflict removed: red `LE-conflict-text`, `-stage`, `-transferred-entry`. **b20**, it writes a mark too: red `LE-pos`, `LE-after-handover`, `CL-ledger-entry`.
  - **b21**, `transfer_artifact` writes any file after the hand-over: red `TA-after-other-file`, `TA-after-verdict-path-prefix`; merged **`FN-O-transfer_artifact-other` `bad`**. **b22**, the verdict path unanchored: red `TA-after-verdict-path-prefix`. **b23**, a `run_id` admitted after the hand-over: red `TA-after-with-run`. **b24**, the open run unchecked: red `TA-run-never-begun`, `-run-completed` and four knock-on. **b25**, its conflict removed: red `TA-conflict`; merged **`FN-I-other-transfer_artifact` `bad`**. **b26**, the mark not marked after the hand-over: red `TA-after-mark`. **b27**, any scope admitted: red `TA-scope-other` and seven knock-on. **b28**, its repeat writes again: red `TA-repeat`, `-repeat-id`, `-repeat-completed-run`, `TA-after-repeat` (S2's index makes the write `write_failed`); merged **`FN-I-same-transfer_artifact` `bad`**.
  - **b29**, `transfer_event`'s repeat writes again: red `TE-repeat`, `-repeat-id`, `-repeat-completed-run`; merged **`FN-I-same-transfer_event` `bad`**.
  - So each rule built turns its self-check cases red when removed. The merged files caught eleven of the twenty-nine (b01, b02, b05, b06, b11, b12, b16, b21, b25, b28, b29); the self-check caught all twenty-nine. Knock-on red cases follow a call the break wrongly admits outside an undone block.
- **50:** the server log, `724 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **51:** files 01 to 50 scanned with the finders of `scan_patterns.json`: `50 files; claim-format 0; environment-format 0`.
- **52:** the hashes in the envelope; `backslashes in M09-10: 0`; `psql meta-command lines in it: 0`; `its strings found by either token finder: … claim-format 0; environment-format 0`; `its lines holding either marker whole: 0`; `its lines naming the exam table (eval_run): 0`; `its lines naming claim_live, check_claim or assignment: 0`; `its lines naming a claim token: 0`; `git status --porcelain`: EV13 modified, M09-10 and the raw files untracked, before this section was written; `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 12.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W14-FN's three FN-T-half cases of `transfer_review` and `transfer_decision`, `ok` while their functions do not exist (12.4): a raised call read as `could_not_check`.
   - T-W07-F06's fourteen transfer recipes in one fixture block: until M09-11, the six's `F06-event` cases cannot be formed, and F06 cannot PASS at this head (12.4).
   - Cases for the rules no merged test reaches (12.4), among them `record_ledger_entry`'s Rule O and `transfer_artifact`'s run after the hand-over.
2. **For the executor** (reported, not done): EV13 25 (9)'s residuals: the closing rule under concurrency (no lock between a closed function's check and a concurrent `record_handover`), the input commits not compared with the run's, and `transfer_event`'s aggregate not checked as an installation record. Each would need a source and a dated correction of EV13 before a migration builds it.
3. **For the checker of verdict (i):** EV13 section 25 with its *[C-M10]* marks; 12.2's departures, chiefly 1, 2, 6 and 7; the self-check and the break copies, which are the producer's own.
4. **For the producers of M09-11 and M09-12:** the closing check before the exact repeat, and the repeat before the run (EV13 25 (1)); `transfer_source` validated as 25 (8) states; the installation's Mission found as `record_handover` finds it (M09-10:501-537); T-W14-FN's `could_not_check` cases of the six's `record_handover` and `record_ledger_entry` become judged once `transfer_decision` and `transfer_mission` exist.
5. **Residuals:**
   - The run's state and the entry ID are read from `devos_private.event` with no index for them (EV13 25 (9)).
   - Two concurrent first calls of one new transferred key: the second is `write_failed` by S2's index, not the repeat answer; its retry gets the repeat.

## 13. M09-11: transfer records

The producer's record of `supabase/migrations/20261019140001_w09_transfer_records.sql` (M09-11). It was written on branch `claude/c02-w09-m0911` at `9066ccfc33f31bd5bf088a73422b92c846f112a0`: `main` `cec8182` with M09-01 to M09-09 and the rule corrections merged and applied, plus M09-10 (`20261019120001_w09_transfer_runs_events.sql`, section 12) from pull request #381, under review. M09-11 builds on both and changes neither. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at `9066ccf`, with EV13's section 26 added. M09-11 means the file above, and M09-11:n a line of it at the bytes the envelope names. FN is `tests/C02/W-C02-14/T-W14-FN_transfer_functions.md`, FNJ its job file; `job/` is `tests/C02/W-C02-07/job/`.
- **EV13 section 26 first.** EV13 gained "26. Correction, 2026-10-19 (M09-11)", which states the forms 13.2 lists. Its marks *[C-M11]* stand in 2.2's `open_mission` row, 2.3's `admit_work` row, 3.1's bullets "The `transferred` event" and "Order", and the six rows of 3.2. M09-11's checker judges it.
- **The note items that bind M09-11, checked on the branch before the SQL was kept** (`plan/work/C02.md`; W9 point 10):
  - **N-277 (3)** (git order): met. FNJ's merge (`f40f135`) and its revision of 2026-10-18 (`04da0de`) are ancestors of `9066ccf`; M09-10's first commit is earlier still (section 12).
  - **N-288** (parameters not named through the function's name): met. Every body reads `p` through `ALIAS FOR $1` (`TX-alias`).
  - **EV13 22 (3)** (every live-claim count through `devos_private.claim_live`) and **this record's 9.6 item 4** (no claim token in an event or a refusal row): none of the six takes a claim, counts one or names a claim token (`TX-no-claim`; file 57: `its lines naming claim_live or check_claim: 0`, `its lines naming a claim token: 0`). `devos_private.assignment` is named on three lines, in the family lookup of a relation end or a work element (as `relate` reads an end), never to count a claim.
  - **EV13 22 (1)** (N-284 C rests on `mission_revision.created_at` being the database's time and on `answered_at` being written only by `transfer_decision`, as recorded): met.
    - `transfer_mission` names no time column. A `created_at` key in the call is not read (`TM-pos-row`; file 57: `its lines naming created_at outside comment lines: 0`).
    - `transfer_decision` writes `answered_at` from the call's value, cast as a time, and never from the clock (`TD-pos-row`; `TX-answered-at`; file 57: answered_at outside comments only in `transfer_decision`).
    - Breaks b14 and b05 write them from the call and from the clock, and turn those cases red (13.5).
  - **N-302 (1)**: `FN-T-half-ev-transfer_decision` now runs on the real `transfer_decision`, and is `ok` for the right reason. **N-302 (2)**: F06's fixture block now forms all its recipes (13.4).
  - **N-285 (1), N-291, N-293** (planted Missions without a creation event): `transfer_work` and `transfer_need` read the Mission they name. There, a Mission whose creation event cannot be read is `could_not_check` (`TW-mission-no-event`, `TN-mission-no-event`), and Rule O is not bent. No merged recipe reaches it so. FN and F06 make the installation's Mission with `transfer_decision` (D-010) and `transfer_mission`, and N02 plants it with its `transferred` event. `transfer_relation` reads no Mission, so FNJ's planted Works (`w14_work`, under a Mission with no event) are accepted as its ends.
  - **N-279 (21)** (the sampling call of the transfer's records): not made. EV13 3.1's "Sampling" has the four call nothing until W-C02-10 builds the function.
- **Appendix B principle 3** binds the four families with revisions. The Mission, the Work, the Decision and the Finding are written at revision 1, and each mark names its record at revision 1 (EV-C02-005 3.3). The Relation, the Need and the EffortPolicy have no revisions, and their marks carry none.

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0911` at `9066ccf`, clean before this work. The runs were made with M09-11, EV13's section 26 and the raw files uncommitted (O, `57_git_hashes.txt`). Bytes run: M09-11 `5d21dd01976fe2bce4e710a29a0f35a773f79835d3a8f4b20df00dfc27ec6b55`; the self-check `…/scratchpad/m0911_run/fn_check.sql` `0edb44cd528b8f8413b2653344de1f364e5a92304ae726c8aa0c00ed657bbc3e`; the break maker `…/m0911_run/brk.py` `a07e703c85cbfe49cbbd03511e43047b13dc20971946b5f1edc3bb0dcb61def8`; the other drivers' hashes are in file 57. EV13 with its section 26 as run: `f6b1e9a27da391e2dea09fbc4c3f652ea3669a111fe9e32298a8239efb67a30f` (the database runs do not read it). A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 12: one throwaway PostgreSQL 16.15 cluster per script, unix socket only (in `…/scratchpad/m11s`, under the 107-byte limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, files 11 and 55: `[cluster directory deleted: yes]`). Stand-ins: `…/scratchpad/m0903_run/setup.sql`, byte for byte (`fa2a9cfa…9783`). The break runs copy each fresh database from one of two templates: `t23`, the twenty-three migrations before M09-11, and `t24`, `t23` with M09-11. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `9066ccf`; EV13 with its sections 1 to 25, and section 26 (for M09-11's checker) |
| Input | The twenty-four migrations (`main`'s twenty, the rule corrections, M09-09, M09-10, M09-11); the eight SQL files of `supabase/migrations/tests/`; every staged SQL file of `job/` and T-W14-FN's, run in place; the producer's self-check; thirty-four break copies of M09-11 made outside the repository (`…/scratchpad/m0911_brk/`, by `brk.py`, deleted after the run); the six merged break patches of `tests/C02/W-C02-14/breaks/` B-FN-1 to B-FN-6, applied in place on the throwaway cluster |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m11_offline_01_init_setup.txt` to `…_57_git_hashes.txt`, written directly by `…/m0911_run/rerun.sh` (01 to 11), `brk.sh` (12 to 55) and `final.sh` (56, 57). Every file but 57 passed through `scrub.py` (section 10's filter, reading the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time) and ends `claim-format strings replaced 0; environment-format strings replaced 0` (56 of 56). File 56 scans files 01 to 55 again with the same finders: `55 files; claim-format 0; environment-format 0`. Files 11 and 55 scan the clusters' server logs: `228 lines; claim-format 0; environment-format 0` and `798 lines; claim-format 0; environment-format 0`. File 57 holds hashes, counts and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 09) and the break copies (21 to 54) are the producer's own; the merged files and break patches (06, 07, 13 to 20) are the test designers' |

### 13.1 What was built, object by object

All in M09-11, in this order: six of the fourteen functions of EV13 section 3 (section 10's row M09-11), then the grants. No table, type, comment or `devos_private` function is added. M09-01 to M09-10 and the rule corrections are not changed. Their helpers are called: `caller_role_class`, `write_event`, `reject`, `scope_within`, `hard_dependency_cycle` and `is_installation_mission`. The form of every function is M09-10's (12.1): the derivation first; the read block with steps (b) to (f); a decided refusal through `v_code`, `v_reason` and `P0D01`; any other error `could_not_check`, `<v_check>: its input could not be read (SQLSTATE <code>)`; the write block, where an error is `write_failed`, but `P0D02`; one per-call row by `reject` after a refusal; fixed reasons. O (`08_catalog.txt`): each of the six is `devos_api.<name>(p jsonb)` returning `jsonb`, with `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, and EXECUTE for `anon` only (also `TX-definer`, `TX-signature`).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.transfer_mission(p jsonb)` (M09-11:56) | The form of 26 (2) (`scope` `installation`, M09-11:190; `owner_authority_revision` absent `could_not_check`); the closing rule; the key; the open run; one Mission under advisory lock 9004 (M09-11:291-306: a transferred Mission exists, `conflict`); the owner authority in 2.2's order (a Decision not yet written `reference_missing`, M09-11:313; `mission_authority` for class, status and revision); D-010 (M09-11:336-349). Writes the Mission, its revision 1 and its one `transferred` mark; no time from the call. Answer `{"status": "ok", "id", "revision": 1}` | 3.2's row with R1-9, R2-7, C-20 and C-M11 (26 (1), (2)); EV-C02-005 1.2 row 1, 2.1; B 3.1, B:397; DM-23 |
| `devos_api.transfer_work(p jsonb)` (M09-11:407) | The form of 26 (3) (`scope` `installation`, `impact_class` `high`, M09-11:571-581; `effort_policy.level` `high`, M09-11:634); the closing rule; the key (a policy mark without the Work's `could_not_check`, M09-11:701); the open run; the installation's Mission (M09-11:724-743); its revision (M09-11:744-765: not written `reference_missing`, earlier `stale_revision`, the scope within it or `scope_outside`); the elements of `input_refs` and `target_refs` (M09-11:767-816). Writes the Work, its EffortPolicy, its revision 1 and two marks (M09-11:852-856). Answer `{"status": "ok", "id", "revision": 1, "effort_policy_id"}` | 3.2's row with R2-4 and C-M11 (26 (1), (3)); B 3.3, 3.18; EV-C02-005 1.2 rows 2, 3, 5, 1.4, 2.1 |
| `devos_api.transfer_relation(p jsonb)` (M09-11:884) | `relate`'s form (19 (1)) with R2-5's group keys, `validity`, `scope` `installation` (M09-11:1061), an Event end `invalid_field` (M09-11:1023), `relation_rule` (M09-11:1131); the closing rule; the key; the open run; for a hard `depends_on` the cycle helper and its lock first (M09-11:1184-1187); the ends (M09-11:1189-1265); the group; B 3.4's exact repeat under another key, `conflict` (M09-11:1293-1297); the cycle (M09-11:1300-1311). Writes the Relation and its one mark. Answer `{"status": "ok", "id"}` | 3.2's row with R2-5 and C-M11 (26 (1), (4)); B 3.4; EV-C02-005 3.3; DM-01 |
| `devos_api.transfer_decision(p jsonb)` (M09-11:1372) | The form of 26 (5) (`routine` `invalid_field`, M09-11:1501; `answered_at` a time, M09-11:1533-1543); `open_exploration` with the form (M09-11:1560-1568); `answered_revision` 1 for `answered`, `accepted`, `declined` or a sent `answered_at` (M09-11:1570-1572); `lacks` (M09-11:1574-1582); the closing rule; the key; the open run. Writes the Decision (answer fields and `answered_at` as sent), its revision 1 and its one mark with `lacks`. Answer `{"status": "ok", "id", "revision": 1}` | 3.2's row with R2-7, 22 (1) and C-M11 (26 (1), (5)); README 8.1; B 3.17, B:308; EV-C02-005 2.2, 2.6; DM-11 |
| `devos_api.transfer_need(p jsonb)` (M09-11:1694) | The form of 26 (6) (`status` `open` or `resolved`, M09-11:1824); the closing rule; the key; the open run; the installation's Mission (M09-11:1896-1915). Writes the Need (`origin` empty) and its one mark. Answer `{"status": "ok", "id"}` | 3.2's row with C-M11 (26 (1), (6)); B 3.2; EV-C02-005 2.3 |
| `devos_api.transfer_finding(p jsonb)` (M09-11:1965) | `record_finding`'s forms (20 (1)) with `not_recorded` admitted, `privacy_class` `public` and `status` `candidate` only (M09-11:2118-2127); `lacks` (M09-11:2200-2207); the closing rule; the key; the open run. Writes the Finding, its revision 1 and its one mark. Answer `{"status": "ok", "id", "revision": 1}` | 3.2's row with C-M11 (26 (1), (7)); B 3.8; EV-C02-005 1.2 row 15, S4 |
| Grants (M09-11:2304-2335) | `revoke all … from public` and from the four API roles where they exist, on all six; `grant execute … to anon` on all six; no type, no private function | 1 item 13; T-W08-PRIV (`W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, unchanged) |

O (`08_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the fifty-three `devos_api` functions.
- **The literals.** All fifty-three `devos_api` functions hold their role-list literal, and all six of M09-11 hold `array['devos_kurulum']::devos_private.role_class[]` (`TX-literals`).
- **The unqualified-name scan.** No hit in M09-11's six. Its four hits are section 3.1's known false ones.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** Twelve functions carry it, as in section 12; none of the six does (`TX-not-read`; F06: all six are state-changing).
- **Types.** No `devos_private` type has PUBLIC USAGE.

### 13.2 Departures from EV-C02-013, and forms it left open

Each is stated in EV13 section 26; none is silent. No merged test is changed.
1. **`reference_missing` for a record a copy names that is not yet written** (26 (1)). This covers `transfer_mission`'s Decision, `transfer_work`'s and `transfer_need`'s Mission, `transfer_work`'s Mission revision and elements, and `transfer_relation`'s ends. 2.2 (C-20) and 2.3 (R2-4) say `could_not_check` for `transfer_mission` and `transfer_work`. 3.1's "Order" and EV-C02-005 3.2 are taken: an order error is the transfer tool's to mend in a later phase. Both are refusals.
2. **The mark is the record's only event** (26 (1)). No family event is written beside the `transferred` mark.
3. **`transfer_mission`** (26 (2)):
   - `scope` must be `installation`.
   - The one-Mission check runs under advisory lock 9004. This is a lock no source names. Without it, two concurrent first calls of different source IDs could both write a Mission, since S2's index holds one key only.
   - D-010's creation event, missing or of NULL type, is `could_not_check`.
4. **`transfer_work`** (26 (3)):
   - `scope` `installation`; `effort_policy.level` `high` only.
   - The Mission revision must be the current one, and the scope must lie within it: `admit_work`'s family rules.
   - The Mission's status is not judged.
   - The revision's `effort_policy_ref` stays NULL. The policy is tied by its `work_ref`.
   - The policy's mark carries the Work's `transfer_source` with kind `effort_policy`.
5. **`transfer_relation`** (26 (4)):
   - `scope` `installation`.
   - A revision sent for a record without revisions is `invalid_field`.
   - No Rule O or Rule C.
   - **B 3.4's exact repeat under another key is `conflict`**. This one is chosen over two other forms: writing a second record, or answering an unmarked `ok`. It is the reason F06 cannot pass at this head (13.4).
6. **`transfer_decision`** (26 (5)):
   - `answered_revision` 1 also for `declined`, and whenever `answered_at` is sent. EV-C02-005 2.6 and DM-11 are taken, beyond R2-7's `answered` and `accepted`.
   - `open_exploration` is decided with the form.
   - `lacks` lists B 3.17's empty fields and `answer`.
7. **`transfer_need`** (26 (6)): the Mission's status is not judged; `origin` is not read.
8. **`transfer_finding`** (26 (7)):
   - `scope` is not limited to `installation`.
   - `agent_addressed` is not read.
   - `lacks` lists the `not_recorded` gate fields and the empty optional fields.

Not departures, for the checker:
- The four sampled functions call nothing, as EV13 3.1's "Sampling" says.
- The closing rule's place before the exact repeat is M09-10's (25 (1)), here for all six (`CL-*-repeat`).

### 13.3 How W-C02-09's points are served by M09-11

- **Point 1.** A versioned file later than `20261019120001`, plain SQL, no `psql` meta-command, no backslash (O, `57_git_hashes.txt`: `backslashes in M09-11: 0`, `psql meta-command lines in it: 0`). Offline, `deployment_drift` reports `no_difference`, 24 of 24 (runs 04 and 10). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject` on every refusal (`{"rejected": 1}` deltas in the self-check), and the counted form for a call with no token (`G-<fn>-no-token`; FN-G-<fn>'s counted row +1);
  - F06's list: all six are state-changing, none carries the read marker (`TX-not-read`, file 06);
  - S1's and S2's forms as W-C02-08 built them: every mark meets `event_transferred_transfer_source`, and S2's index is the backstop of the key (`TD-repeat`, `TW-repeat`, and the others).
- **Point 2.** Fifty-three of the 55 `devos_api` functions now exist (six here). Each has definer rights, the fixed `search_path` and every DevOS name qualified (13.1's scan).
- **Point 3.**
  - Fourth bullet. Each of the six refuses a call with no token before any other check (`G-<fn>-no-token`; FN-G-<fn> `ok`). Each refuses a class not on its list, with one per-call row (`G-<fn>-<class>`; 5B row R19, all thirty-six cells of the six `ok`; FN-G-<fn> `ok`).
  - Fifth bullet. A declared role name and origin change nothing: `TD-pos` sends `role_class` `devos_denetim` and `origin` `owner`, and its mark carries `devos_kurulum` and `call`. A declared session is written as declared (`TD-pos-mark`, `TR-pos-mark`).
- **Point 5.**
  - Each function writes its record and its mark in the same transaction, with the token's class (`TD-pos-mark`, `TM-pos-mark`, `TW-pos-marks`, `TR-pos-mark`, `TN-pos-mark`, `TF-pos-lacks`). FN-T-ev of all six is `ok`.
  - An exact repeat writes nothing and answers the existing id (`TD-repeat`, `TM-repeat`, `TW-repeat`, `TR-repeat`, `TN-repeat`, `TF-repeat`: `ok repeat`, `{}`). FN-I-same of all six and FN-I-same-decision are `ok`.
  - A failure planted mid-transaction leaves no half state and no orphan event, only the refusal row (`TD-write-failed`, `TM-write-failed`, `TW-write-failed`, `TW-write-mark-failed`, `TR-write-failed`, `TN-write-failed`, `TF-write-failed`). `TD-write-P0D02` and `TF-write-P0D02` give `could_not_check` with the fixed reason. FN-T-half-ev of all six is `ok`.
- **Point 6.** `transfer_relation` refuses `model_extracted` with `observation` (`TR-relation-rule`); the table's check is its backstop (break b25 gives `write_failed`).
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass: `TD-events-unreadable`, `TM-authority-rev-missing`, `TM-authority-no-event`, `TM-authority-answered-revision-null`, `TM-decisions-unreadable`, `TW-mission-revision-missing`, `TW-mission-no-event`, `TW-policy-mark-alone`, `TR-to-revision-missing`, `TR-relations-unreadable`, `TN-mission-no-event`.
- **Point 8.**
  - W-C02-08's four copies, W-C02-03's three and the IDC copy pass again (run 05).
  - The staged files whose cases call the six, run in place (runs 06, 07; compared with `t23` in runs 13 and 14):
    - **T-W07-5B `PASS (312/312)`** (`PASS (276/276)` on `t23`): the thirty-six cells of R19's six functions are now judged, each `ok`;
    - **T-W07-F06 `COULD NOT CHECK (2 of 141 could not be checked)`** (`COULD NOT CHECK (6 of 117)` on `t23`): its fixture block now forms all fourteen recipes, and the six functions' `F06-refused`, `F06-event` and `F06-repeat` cases are `ok`, but for `F06-event:transfer_relation` and `F06-repeat:transfer_relation` (13.4);
    - **T-W14-FN `FAIL (1 bad, 16 could not check, of 109)`** (`FAIL (1 bad, 77 could not check, of 109)` on `t23`): `FN-M-cat` `bad`, since `transfer_review` and `transfer_acceptance` are not built yet. Ninety-two cases are `ok`: every case of the twelve built functions, FN-MA-*, FN-RN-pos, -never and -completed, FN-CY-*, and FN-O-transfer_artifact and FN-O-record_ledger_entry, which needed the installation's Mission. The sixteen `could_not_check` cases each need `transfer_review` or `transfer_acceptance`;
    - T-W07-N02 and T-W07-N04 as on `t23`: N02 stops at its `-pre` line (`devos_private.sample_stream`), and N04's part T needs `transfer_review`;
    - every other file as on `t23` (file 06); none of them calls the six.
  - Their copies are a later pull request's (R:247; EV13 section 11: T-W14-FN's passes only with M09-12).
- **Point 10.** Twelve of the fourteen exist, each as point 2 asks; FN-M-cat's detail names the two missing.
  - The second bullet's parts reached by the twelve:
    - each refuses every class but `devos_kurulum` and a call with no token, with the attempt recorded (FN-G);
    - after a planted hand-over, the ten closed ones refuse (FN-C, all ten `ok`);
    - `transfer_artifact` and `record_ledger_entry` still write (FN-O-transfer_artifact, FN-O-record_ledger_entry `ok`);
    - with one write planted to fail, nothing stays (FN-T-half-ev);
    - an exact repeat writes nothing, and another hash is refused with its row (FN-I).
  - W-C02-08's S1 to S4 still pass T-W14-SCH (`PASS (38/38)`, run 05).
  - T-W14-FN cannot pass before M09-12, so point 10 is not met by this file alone.

### 13.4 What M09-11 does not yet serve

- **Merged tests that cannot pass at this head on a correct build** (EV13 26 (9)):
  - **T-W07-F06** (`COULD NOT CHECK (2 of 141)`).
    - **The cause.** Its `transfer_relation` recipe (`job/w07_f06_state_change_event.sql:760-763`) names the ends, type, revisions and `hard` of its `relate` recipe (`:482-483`). F06 accepts the `relate` call earlier in the same transaction, so 26 (4)'s B 3.4 rule refuses the transfer `conflict`.
    - **The test designer's part.** The recipe needs ends of its own.
    - **Shown.** With that rule removed (break b23), F06 is `PASS (141/141)` (file 43). So the two cases depend on that departure alone, and the checker judges the rule before the recipe changes.
    - F06 passed at M09-09's head (section 12.4). M09-10 left it `COULD NOT CHECK (6 of 117)`, and M09-11 leaves it `COULD NOT CHECK (2 of 141)`.
  - **T-W14-FN**: FN-M-cat needs all fourteen, and its sixteen `could_not_check` cases need M09-12's two functions.
  - **T-W07-N02**'s `transfer_decision` cases are not reached while N02 stops at its `-pre` line (W-C02-10's `sample_stream`).
- **The merged breaks** (runs 15 to 20, each on a fresh copy of `t24`):
  - **B-FN-3** (`transfer_decision` does not see the hand-over): `[patch exit 0]`; `FN-C-transfer_decision` red, its whole expect-red list, beside the standing `FN-M-cat`. It is shown on the real `transfer_decision` (file 15).
  - **B-FN-2** shows as in section 12 (file 17).
  - **B-FN-1, B-FN-4, B-FN-5 and B-FN-6** wrap `transfer_review` and `transfer_acceptance`, which M09-12 builds: `[patch exit 3]` each, not applied, and their red lists stay unshown here (files 16, 18 to 20).
- **Rules no merged test reaches**, resting on the producer's self-check alone. Their break copies leave every merged case as it is without the break:
  - `transfer_decision`: `routine` (b03), `open_exploration` (b04, since N02 does not run), `answered_at` as recorded (b05), `answered_revision` for `accepted` and `declined` (b06);
  - `transfer_mission`: one Mission (b12), no time from the call (b14);
  - `transfer_work`: every Mission and element rule (b15 to b18, b20);
  - `transfer_relation`: B 3.4's repeat (b23, whose only merged effect is F06's two cases, toward their passing), the ends (b24), `relation_rule` (b25);
  - `transfer_need`: the Mission and status rules (b27, b28);
  - `transfer_finding`: `privacy_class` and `status` (b31, b32).

### 13.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0911` at `9066ccf`, with M09-11, EV13's section 26 and the raw files uncommitted. The main run (`…/m0911_run/rerun.sh`) ran from 2026-10-19T04:58:24Z to 04:58:39Z on one cluster. The comparison and break runs (`brk.sh`) ran from 04:59:09Z to 05:00:14Z on a second cluster. Then `final.sh` wrote files 56 and 57.
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `judge.py` and `catalog.sql` are `…/m0910_run/`'s, changed only in their paths (the clone `prd15`, the cluster under `…/m0911_run/pg`, the socket in `…/scratchpad/m11s`) and their label words. `setup.sql` is `…/m0903_run/setup.sql`, byte for byte.
  - `fn_check.sql` is `fn_head.sql` (M09-10's harness, with `m_ids.v` nullable, so that a break refusing a fixture call turns cases red rather than stopping the run) and `fn_cases.sql` (this migration's counted tables, fixtures and cases).
  - `brk.py`, `brk.sh`, `rerun.sh` and `final.sh` follow section 12's forms. `brk.py` makes each edit inside one function's text only.
- **Trial runs.** Before the filed runs (`…/m0911_run/trialrun.sh`, none filed):
  - the migration applied once and T-W14-FN run once (`FAIL (1 bad, 16 could not check, of 109)` at its first run);
  - every staged file once, and the self-check once (`256/256` at its first run, its rows then read directly);
  - the break runs once (`…/m0911_run/trialA`). There, b12 stopped the self-check: a fixture id was NULL under the break. The harness's id table was then made nullable.
  - The one-Mission advisory lock was added to M09-11 after the trials and before the filed runs.
  - The filed runs give the same summary and bad-case lines as the trials (compared after the run), with b12 now red (34 cases).

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the twenty-three migrations before M09-11, each `[exit 0]` with its history row (46 `[exit 0]` lines). **03, M09-11:** `CREATE FUNCTION` ×6, `REVOKE` ×6, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 10:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 24, "migrations_expected": 24`, `"complete": true`.
- **05, the eight SQL copies:** `W03_DRIFT_COULD_NOT_CHECK PASS (13/13)`, `W03_DRIFT_DETECTS PASS (10/10)`, `W03_FIXTURE_APPLY_READ PASS (12/12 …)`, `W07_5A_NO_DIRECT_WRITES PASS (168/168)`, `W07_DM02_REVISION_APPEND_ONLY PASS (21/21)`, `W07_IDC_IDENTITY_CHAIN PASS (43/43)`, `W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`, each `database test …: passed`.
- **06 and 07, every staged SQL file run in place** (not copies; a self-check, never a result):
  - 13.3's point 8;
  - besides, `W07_F04_AFFECTED_RECORDS PASS (32/32)`, `W07_ROC_OWNERSHIP_AND_CLAIM_CLASS PASS (84/84)`, `W07_N08_EXAM_FACT PASS (61/61)`, `W07_N08_EXAM_RECORDS FAIL (1 bad, 0 could not check, of 14)` (section 11.4's `N08-rp-read_eval_run`), `W07_DM11_ANSWER_REVISION FAIL (5 bad …)`, `W07_N28_VERIFIER_DOES_NOT_REPAIR FAIL (2 bad …)`, and the files of W-C02-10's tables on their `-pre` line, each as at section 12's head;
  - run 07 is `W14_FN_TRANSFER_FUNCTIONS FAIL (1 bad, 16 could not check, of 109)`, `FN-M-cat | bad | absent, not security definer, or without a fixed search_path: transfer_review, transfer_acceptance`.
- **08, the catalogue:** 13.1's listing.
- **09, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC m0911; one transaction rolled back): `M0911_FUNCTIONS PASS (256/256)`.
  - **The cases by group:**
    - 54 for the gate: six functions, five classes, no token, and three neutral calls each;
    - 43 for `transfer_decision`, 31 for `transfer_mission`, 37 for `transfer_work`, 30 for `transfer_relation`, 19 for `transfer_need` and 27 for `transfer_finding`;
    - 7 after the accepted hand-over (`CL-*`), and 8 for the text (`TX-*`).
  - **How they judge.** Each case compares the answer's code and the change of thirteen counts: events, refusals, and the Mission, Work, EffortPolicy, Relation, Decision, Need and Finding tables with their revisions. The state cases read the rows after. A plant runs with its call in a subtransaction that is undone, and the delta is measured after the plant.
  - **Cases among them.**
    - `transfer_decision`: `TD-pos-row` (`answered_at` as sent, `answered_revision` 1, `answer` empty), `TD-pos-lacks`, `TD-declined-revision`, `TD-accepted-revision`, `TD-superseded-revision`, `TD-open-revision`, `TD-open-exploration`, -`accepted`, -`reason`, -`options`, -`open`.
    - `transfer_mission`: `TM-authority-unwritten`, `-high-impact`, `-open`, `-revision-2`, `-not-d010`, `-opened`, `-no-event`, `-answered-revision-null`, `TM-second-mission`, `TM-second-source`, `TM-pos-row` (the database's `created_at`; a `created_at` key not read), `TM-pos-installation`.
    - `transfer_work`: `TW-mission-not-installation`, `-no-event`, `-revision-unwritten`, `-revision-stale`, `TW-scope-outside`, `TW-input-unwritten`, `-a-need`, `-revision-unwritten`, `TW-policy-mark-alone`, `TW-pos-policy`, `TW-pos-marks`.
    - `transfer_relation`: `TR-end-event`, `-object`, `TR-from-unwritten`, `TR-to-revision-missing`, `-unwritten`, `TR-need-with-revision`, `TR-same-relation-other-key`, `TR-group-mode-alone-row`, `TR-dep-pos`, `TR-cycle`, `TR-cycle-soft`, `TR-need-end`.
    - `transfer_need`, `transfer_finding`: `TN-mission-not-installation`, `TN-resolved`, `TF-pos-lacks`, `TF-pos2-lacks`, `TF-write-P0D02-reason`.
    - After the hand-over and in the text: `CL-*-repeat` (an exact repeat after the hand-over is `handed_over`), `TX-literals`, `TX-signature`, `TX-alias`, `TX-not-read`, `TX-no-claim`, `TX-no-created-at`, `TX-answered-at`, `TX-definer`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `rejected_attempt`, `event` and `decision`.
- **11:** the server log, `228 lines; claim-format 0; environment-format 0`; `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **12:** the break cluster's setup, the templates `t23` and `t24` (`[template … exit 0]`), and `brk.py`: `34 break copies made`.
- **13 and 14, the comparison** of T-W14-FN, 5B, F06, N02 and N04 on fresh copies of `t23` and `t24`: 13.3's point 8.
- **15 to 20, the merged break patches** B-FN-3, then B-FN-1, -2 and -4 to -6, each on a fresh copy of `t24`: 13.4.
- **21 to 54, the break copies**, each in a fresh database copied from `t23` with the copy applied in M09-11's place (`[apply exit 0]`). Then the self-check and T-W14-FN ran, and 5B for b01 and F06 for b23. Each turned the self-check red (`M0911_FUNCTIONS FAIL (n of 256 not as wanted)`). Below, the red cases named, and the merged cases that turned `bad` besides the standing `FN-M-cat`:
  - **b01**, `transfer_decision` admits `devos_calisma`: red `G-transfer_decision-devos_calisma`, `TX-literals`; merged **`FN-G-transfer_decision`, `5B-R19-transfer_decision-cal` `bad`**. **b02**, it does not see the hand-over: red `TD-after-handover`, `CL-decision-repeat`, `TD-events-unreadable-reason`; merged **`FN-C-transfer_decision` `bad`**.
  - **b03**, `routine` admitted: red `TD-routine` and seven knock-on cases. The admitted call writes the source's key, which later cases meet. **b04**, `open_exploration` removed: red `TD-open-exploration`, `-accepted` and seven knock-on. **b05**, `answered_at` from the clock: red `TD-pos-row`, `TD-superseded-revision`, `TX-answered-at`, `TD-answered-at-bad` and seven knock-on. **b06**, `answered_revision` only for `answered`: red `TD-declined-revision`, `TD-accepted-revision`.
  - **b07**, `transfer_decision`'s conflict removed: red `TD-conflict`; merged **`FN-I-other-decision` `bad`**. **b08**, its repeat writes again: red `TD-repeat`, `-repeat-id`, `-repeat-completed-run`; merged **`FN-I-same-decision` `bad`**.
  - **b09**, `transfer_mission`'s class and status unchecked: red `TM-authority-open`; merged **`FN-MA-class`, `FN-MA-status` `bad`**. The D-010 rule still refuses the high-impact Decision of `TM-authority-high-impact`. **b10**, D-010 unchecked: red `TM-authority-not-d010`, `-opened`, `-no-event` and eight knock-on. The admitted call writes the installation's Mission. Merged **`FN-MA-source` `bad`**. **b11**, the answered revision unchecked: red `TM-authority-revision-2` and eleven knock-on; merged **`FN-MA-revision` `bad`**.
  - **b12**, a second transferred Mission admitted: red `TM-second-mission`, `TM-second-source` and thirty-two knock-on. Two installation Missions make every later Mission check `could_not_check`. **b13**, `transfer_mission` does not see the hand-over: red `TM-after-handover`, `CL-mission-repeat`; merged **`FN-C-transfer_mission` `bad`**. **b14**, `created_at` written from the call: red `TM-pos-row`, `TX-no-created-at`.
  - **b15**, `transfer_work` on any Mission: red `TW-mission-not-installation`. **b16**, `routine` admitted: red `TW-routine` and sixteen knock-on. **b17**, an earlier Mission revision admitted: red `TW-mission-revision-stale`. **b18**, the scope unchecked: red `TW-scope-outside`. **b19**, the policy's mark not written: red `TW-pos-marks`, `TW-repeat`, `-repeat-id`; merged **`FN-T-ev-transfer_work`, `FN-I-same-transfer_work`, `FN-I-other-transfer_work` `bad`**. **b20**, an element's family unchecked: red `TW-input-a-need`. **b21**, `transfer_work` does not see the hand-over: red `TW-after-handover`, `CL-work-repeat`; merged **`FN-C-transfer_work` `bad`**.
  - **b22**, `transfer_relation`'s cycle admitted: red `TR-cycle`, `TR-cycle-soft` (knock-on); merged **`FN-CY-cycle` `bad`**. **b23**, B 3.4's repeat removed: red `TR-same-relation-other-key`. T-W07-F06 then gives `PASS (141/141)` (13.4). **b24**, the ends unchecked: red `TR-from-unwritten`, `TR-to-revision-missing`, `-unwritten`, `TR-need-with-revision` and five knock-on. **b25**, `relation_rule` removed: red `TR-relation-rule` (the table's check makes it `write_failed`). **b26**, `transfer_relation` does not see the hand-over: red `TR-after-handover`, `CL-relation-repeat`; merged **`FN-C-transfer_relation` `bad`**.
  - **b27**, `transfer_need` on any Mission: red `TN-mission-not-installation`, `TN-mission-no-event` and three knock-on. **b28**, any status: red `TN-status-investigating` and eight knock-on. **b29**, the Need written without its mark: red `TN-pos-mark`, `TN-repeat`, `-repeat-id`, `TN-conflict`; merged **`FN-T-ev-transfer_need`, `FN-T-half-ev-transfer_need`, `FN-I-same-transfer_need`, `FN-I-other-transfer_need` `bad`**. **b30**, `transfer_need` does not see the hand-over: red `TN-after-handover`, `CL-need-new`; merged **`FN-C-transfer_need` `bad`**.
  - **b31**, `transfer_finding` admits any privacy class: red `TF-privacy-private` and six knock-on. **b32**, any status: red `TF-status-reviewed` and six knock-on. **b33**, its run unchecked: red `TF-run-never-begun`, `-run-completed` and four knock-on; merged **`FN-RN-never`, `FN-RN-completed` `bad`**. **b34**, `transfer_finding` does not see the hand-over: red `TF-after-handover`, `CL-finding-new`; merged **`FN-C-transfer_finding` `bad`**.
  - So each rule built turns its self-check cases red when removed. The merged files caught nineteen of the thirty-four (b01, b02, b07 to b11, b13, b19, b21, b22, b26, b29, b30, b33, b34, and b23's change of F06 toward a pass); the self-check caught all thirty-four. Knock-on red cases follow a call the break wrongly admits outside an undone block.
- **55:** the server log, `798 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **56:** files 01 to 55 scanned with the finders of `scan_patterns.json`: `55 files; claim-format 0; environment-format 0`.
- **57:**
  - the hashes in the envelope;
  - the text counts: `backslashes in M09-11: 0`; `psql meta-command lines in it: 0`; `its strings found by either token finder: … claim-format 0; environment-format 0`; `its lines holding either marker whole: 0`; `its lines naming the exam table (eval_run): 0`; `its lines naming claim_live or check_claim: 0`; `its lines naming a claim token: 0`; three lines naming `devos_private.assignment` (the family lookup); `its lines naming created_at outside comment lines: 0`; answered_at outside comments in `transfer_decision` only;
  - `git status --porcelain`: EV13 modified, M09-11 and the raw files untracked, before this section was written;
  - `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty.

### 13.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-F06's `transfer_relation` recipe (`job/w07_f06_state_change_event.sql:760-763`) needs ends other than its `relate` recipe's (`:482-483`), once the checker has judged EV13 26 (4)'s B 3.4 rule (13.4). Until then F06 cannot PASS at this head.
   - Cases for the rules no merged test reaches (13.4): `transfer_work`'s Mission, revision, scope and element rules; `transfer_need`'s Mission; `transfer_finding`'s `privacy_class` and `status`; `transfer_decision`'s `routine`, `answered_at` as recorded and `answered_revision` for `declined`; `transfer_mission`'s one-Mission rule; `transfer_relation`'s ends, `relation_rule` and B 3.4's repeat.
   - T-W07-N02's `transfer_decision` cases wait for W-C02-10's `sample_stream`.
2. **For the executor** (reported, not done): EV13 26 (8)'s residuals.
   - `transfer_relation` checks no ownership of its ends, as `transfer_event` checks none of its aggregate (N-302 (5)).
   - `transfer_work` binds a transfer to the Mission's current revision.
   - 25 (9)'s closing rule under concurrency and the input commits not compared with the run hold for these six too.
3. **For the checker of verdict (i):**
   - EV13 section 26 with its *[C-M11]* marks;
   - 13.2's departures, chiefly 1 (`reference_missing` against C-20 and R2-4's wording), 3 (the advisory lock, a mechanism no source names), 5 (B 3.4's `conflict`, which F06 meets) and 6 (`answered_revision` beyond R2-7);
   - the self-check and the break copies, which are the producer's own.
4. **For the producer of M09-12:**
   - FN's sixteen `could_not_check` cases and B-FN-1, -4, -5 and -6 become judged once `transfer_review` and `transfer_acceptance` exist;
   - the installation's Mission is found as `record_handover` and `transfer_work` find it, and its `owner_authority` is D-010's by construction (R1-9);
   - a Decision target transferred by `transfer_decision` has a `transferred` creation event of class `devos_kurulum` (R2-2's opener rule).

**Revised for CHK-C02-104 C1 (2026-10-19).** CHK-C02-104 judged the branch at `7fc7537` PASS-WITH-CONDITIONS. Its C1: `transfer_decision` cast `answered_at` with `::timestamptz`, so PostgreSQL's special inputs were accepted (its probe's `TD10`, `now`, and `TD11`, `infinity`). A further producer, a fresh-context subagent of the same session (the executor names the agent), worked in a scratch clone of the branch at `7fc7537`, uncommitted. It changed only `transfer_decision`'s handling of `answered_at` (M09-11:1533-1553; 13 lines added and 3 removed); nothing else in the file is changed. It is not a verdict.
- **The form** (EV13 26 (5), the line marked *[C-M11, CHK-C02-104 C1]*). The string is matched with a regular expression before any cast. A date `YYYY-MM-DD` is read as 00:00 UTC. A date-time is `YYYY-MM-DD`, then `T` or a space, then `HH:MM`, an optional `:SS` with an optional fraction of 1 to 6 digits, then `Z` or `±HH`, `±HHMM` or `±HH:MM`. The value cast must be finite. Anything else is `invalid_field`, with the fixed reason "answered_at: not a finite date (YYYY-MM-DD, read as 00:00 UTC) or date-time with Z or an offset".
- **The offset rule.** A date-time without an offset is refused, so no stored value depends on the calling session's `TimeZone`. All 26 recorded `answered_at` values in `plan/decisions/` carry `Z` and match (file 72). The merged tests send `to_jsonb(now())`, which carries an offset.
- **The bytes.** M09-11 is now `1bf9d8148bf4d848db8089570657816c24efe5feb9a5e99b9aa0a747412ada75` (it was `5d21dd01976fe2bce4e710a29a0f35a773f79835d3a8f4b20df00dfc27ec6b55`). M09-11:n cited above names a line at the old bytes. Every line from the old 1544 on is now 10 lines later.
- **The drivers.** The self-check is `…/scratchpad/m0911fix_run/fn_check.sql` (`73c5059ea63c1d153fd80a2ea7fab81682564f8585664e4141978485b3371bdf`). It is `…/m0911_run/fn_check.sql` with 31 cases added in its `transfer_decision` group; nothing else in it changed. `run.sh` is `…/m0911_run/run.sh` with its paths only changed: the cluster is under `…/m0911fix_run/pg`, the socket in `…/scratchpad/m11f`. `drive.py`, `judge.py`, `scrub.py`, `scan.py`, `catalog.sql` and `fn_head.sql` are `…/m0911_run/`'s, byte for byte, and `setup.sql` is `…/m0903_run/setup.sql`, byte for byte. `rerun.sh`, `cases_new.sh` and `final.sh` are new, in `…/m0911_run/`'s forms. `m0911_old.sql` is `git show 7fc7537:` of M09-11. The hashes are in file 72.
- **Raw evidence.** `evidence/C02/raw/EV-C02-014_m11_offline_58_fix_init_setup.txt` to `…_72_fix_git_hashes.txt`, labelled **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one**. Every file but 72 went through `scrub.py` and ends `claim-format strings replaced 0; environment-format strings replaced 0`. File 72 holds hashes, counts and git output only.

The runs:
- **58 to 68, the new bytes**, from 2026-10-19T05:25:21Z to 05:25:37Z on one cluster, deleted after.
  - **Migrations and drift.** The twenty-four migrations apply, each `[exit 0]`. `deployment_drift` gives `no_difference`, 24 of 24, `complete: true` (61 and 67).
  - **The eight SQL copies** pass as in 13.5: 13/13, 10/10, 12/12, 168/168, 21/21, 43/43, 96/96 and 38/38 (62).
  - **The staged files** (63 and 64): T-W14-FN is `FAIL (1 bad, 16 could not check, of 109)` (`FN-M-cat`), F06 is `COULD NOT CHECK (2 of 141)` (`F06-event:transfer_relation`, `F06-repeat:transfer_relation`), and 5B is `PASS (312/312)`.
- **69, the old bytes** (`7fc7537`'s M09-11) in M09-11's place on a second cluster, deleted after. Every staged file's summary line on the old bytes equals file 63's and 64's. F06, 5B and T-W14-FN are also the same case by case (70 against 69). So the change moves no merged test. Three summaries differ from 13.5's file 06 (6RG 32/32, DM19B 14/14, N08 records 17/17). Those differ because file 06 ran at `9066ccf`, before #380's test revisions (CHK-C02-104 finding 10 (b)), not because of this change.
- **66, the self-check:** `M0911_FUNCTIONS PASS (287/287)` (it was 256/256).
  - **The refusals.** Twenty-three strings, each under its own source ID, are each `invalid_field` with a delta of exactly one refusal row and nothing written: `now`, `today`, `tomorrow`, `yesterday`, `infinity`, `-infinity`, `epoch`, `NOW`, ` now`, `Infinity`, `allballs`, `today 10:00Z`, `2026-10-05 allballs`, `2026-10-05T17:50Z now`, the empty string, `2026-10-05T17:50:00`, `2026-10-05 17:50`, `20261005T175000Z`, `J2461319`, `10/05/2026`, `2026-13-01T00:00Z`, `2026-10-05T17:50:00.1234567Z` and `0000-01-01`.
  - **The reason.** All 23 carry the fixed reason (`TD-answered-at-special-reason`). Afterwards no transferred Decision holds an answer time (`-none`).
  - **Under `TimeZone` Asia/Kolkata:** `2026-10-07` is stored as `2026-10-07T00:00:00Z`, `2026-10-07T17:50+03:00` as `14:50Z`, and `2026-10-11 09:13:31.5Z` as sent.
  - **Cases that still pass.** `TD-pos-row` (`2026-10-05T17:50:00Z`, written as sent), `TD-superseded-revision` (`+00:00`), `TD-answered-at-bad` (now with the new reason) and `TX-answered-at`.
- **69, the same self-check on the old bytes:** `FAIL (21 of 287 not as wanted)`, which shows the new cases would catch the defect.
  - **Accepted and written there:** 18 of the 23 strings, the seven special inputs among them.
  - **Already refused there:** `allballs`, `2026-10-05T17:50Z now`, the empty string, `2026-13-01T00:00Z` and `0000-01-01`.
  - **Also red there:** the reason and `-none` cases, and `TD-answered-at-date-row`, because the old cast read the bare date as midnight in Asia/Kolkata.
- **71:** files 01 to 70 scanned with the finders of `scan_patterns.json`. **72:** the hashes and text counts (backslashes 0, either marker whole 0, `answered_at` outside comments only in `transfer_decision`), the 26 ledger values against the two expressions read from the file, and `git status`. The diff touches M09-11, EV13 and this file only, plus the new raw files; there is no diff under `tests/`, `tools/`, `plan/`, `.github/` or `.claude/`.
- **Not done here.**
  - Breaks b01 to b34 were not rerun: `brk.py` edits the old text. The old bytes' run (69) serves as the break of this rule.
  - `isfinite` cannot refuse on its own, since the expressions admit finite values only, and no case separates it.
  - C2 (N-303's annotation) is not this producer's.
  - Nothing was applied to either project.

## 14. M09-12: transfer copies, and the test copies

The producer's record of `supabase/migrations/20261019160001_w09_transfer_copies.sql` (M09-12), W-C02-09's twelfth and last migration, and of the copies of section 11's staged files into `supabase/migrations/tests/`. It was written on branch `claude/c02-w09-m0912` at `7fc7537f8a3ab8a675bb4811c914027e12d3f08e`: `main` `9399614` with M09-01 to M09-10 and the rule corrections merged and applied, plus M09-11 (`20261019140001_w09_transfer_records.sql`, section 13) from pull request #382, under review. M09-12 builds on both and changes neither. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** Lines cited as EV13:n and B:n are at `7fc7537`, with EV13's section 27 added. M09-12 means the file above, and M09-12:n a line of it at the bytes the envelope names. FN is `tests/C02/W-C02-14/T-W14-FN_transfer_functions.md`, FNJ its job file; `job/` is `tests/C02/W-C02-07/job/`; R is `tests/C02/W-C02-07/README.md`.
- **EV13 section 27 first.** EV13 gained "27. Correction, 2026-10-19 (M09-12)", which states the forms 14.2 lists. Its marks *[C-M12]* stand in 3.1's bullet "The `transferred` event", the two rows of 3.2 and section 12's last item. M09-12's checker judges it.
- **The note items that bind M09-12, checked on the branch before the SQL was kept** (`plan/work/C02.md`; W9 point 10):
  - **N-277 (3)** (git order): met. FNJ's merge (`f40f135`) and its revision (`04da0de`) are ancestors of `7fc7537`, and so of M09-12's first commit.
  - **N-288**: met. Both bodies read `p` through `ALIAS FOR $1` (`TX-alias`).
  - **EV13 22 (3)** and **9.6 item 4**: neither function takes a claim, counts one or names a claim token or the exam table (`TX-no-claim`; file 59).
  - **EV13 22 (1)**: neither writes `created_at` or `answered_at` (file 59: `answered_at` on no line outside comments; `created_at` on one, an `order by` of the repeat's Verdict lookup).
  - **N-279 (18)** and **EV13 section 12's last item** (the Review copy's target against the Acceptance's): no rule, with the reason in EV13 27 (7).
  - **N-302 (1)**: `FN-T-half-ev-transfer_review` and `FN-T-half-rec-transfer_review` now run on the real `transfer_review` and pass for the right reason: under B-FN-5 both turn red (file 22).
  - **N-285 (1), N-291, N-293** (planted Missions without a creation event): `transfer_acceptance` reads Rule O for a Work target. There a Mission whose creation event cannot be read is `could_not_check` (`TA-work-mission-no-event`), and Rule O is not bent. No merged recipe reaches it so: FN and F06 make the target Work with `transfer_work` under the installation's Mission, and N02's targets are Decisions. `transfer_review` reads no Mission, so FN's planted Works (`w14_work()`, FNJ:222) are accepted as its targets.
  - **README 5.1 (c)** ("a file is copied only when it can pass"): each copy was run and passed on this build before it was copied (14.4).
- **Appendix B principle 3.** Neither family has revisions. The Review copy names its target's revision when one is sent; the Acceptance stores its target's current revision (EV13 27 (9)).

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m0912` at `7fc7537`, clean before this work. The runs were made with M09-12, the copies, EV13's section 27 and the raw files uncommitted (O, `59_git_hashes.txt`). Bytes run: M09-12 `a0ef20464a2143a75f64adf7eab3351aa7909e472e64f1ba78e5e5601e4269ab`; the self-check `…/scratchpad/m0912_run/fn_check.sql` `46b976bf3cc1e658d77719b52b6581f00a4dbe1174b5886f95d6b47a4ec07bd1`; the break maker `…/m0912_run/brk.py` `d07500954c7eefc6a097af3547515ef3f3dac7d2f9067125c523643c67e2c212`; the other drivers' hashes, and each copy's against its staged file, are in file 59. EV13 with its section 27 as run: `a721cdadd4ee329a87055dc64d392e819b73d4b6acf00f5d34258ad411264870` (the database runs do not read it). A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 13: one throwaway PostgreSQL 16.15 cluster per script, unix socket only (in `/var/tmp/m12pg`, under the 107-byte limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, files 14 and 57: `[cluster directory deleted: yes]`). Stand-ins: `…/scratchpad/m0903_run/setup.sql`, byte for byte (`fa2a9cfa…9783`). The break runs copy each fresh database from one of two templates: `t24`, the twenty-four migrations before M09-12, and `t25`, `t24` with M09-12. The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `7fc7537`; EV13 with its sections 1 to 26, and section 27 (for M09-12's checker) |
| Input | The twenty-five migrations; the folder `supabase/migrations/tests/` with the eight SQL copies before this work and the twenty-two copies made here (twenty-one SQL files and one program); every staged SQL file of `job/` and T-W14-FN's, run in place; the producer's self-check; twenty-nine break copies of M09-12 made outside the repository (`…/scratchpad/m0912_brk/`, by `brk.py`, deleted after the run); ten merged break patches applied in place on the throwaway cluster: B-FN-1 to B-FN-6, B-N04-1 to B-N04-3 and B-N01-2 |
| Raw evidence | `evidence/C02/raw/EV-C02-014_m12_offline_01_init_setup.txt` to `…_59_git_hashes.txt`, written directly by `…/m0912_run/rerun.sh` (01 to 14), `brk.sh` (15 to 57) and `final.sh` (58, 59). Every file but 59 passed through `scrub.py` (section 10's filter, reading the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time) and ends `claim-format strings replaced 0; environment-format strings replaced 0` (58 of 58). File 58 scans files 01 to 57 again with the same finders. Files 14 and 57 scan the clusters' server logs: `186 lines; claim-format 0; environment-format 0` and `540 lines; claim-format 0; environment-format 0`. File 59 holds hashes, counts and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (run 08) and the break copies (28 to 56) are the producer's own; the merged files and break patches (05, 06, 09 to 12, 16 to 27) are the test designers' |

### 14.1 What was built, object by object

Both in M09-12, in this order: the last two of the fourteen functions of EV13 section 3 (section 10's row M09-12), then the grants. No table, type, comment or `devos_private` function is added. M09-01 to M09-11 and the rule corrections are not changed. Their helpers are called: `caller_role_class`, `write_event`, `reject` and `is_installation_mission`. The form of each function is M09-10's and M09-11's (12.1, 13.1). O (`07_catalog.txt`): each is `devos_api.<name>(p jsonb)` returning `jsonb`, with `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, and EXECUTE for `anon` only (also `TX-definer`, `TX-signature`).

| Object | What it does | Follows (EV13 unless named) |
|---|---|---|
| `devos_api.transfer_review(p jsonb)` (M09-12:60) | The form of 27 (2): `kind` first (`sample` `kind_not_allowed`, M09-12:138); `transfer_source` of kind `verdict`; `basis_refs` a non-empty array kept as sent; `independence_level` `fresh_context_subagent` only (M09-12:252); the `verdict` object. Not closed by the hand-over. The key; the run (after the hand-over no `run_id`); `target_ref` and `target_revision`, each a record or revision written (M09-12:359-404: `reference_missing`). Writes the Review copy, its Verdict and the Review's one `transferred` mark, naming the Verdict (M09-12:421-443). Answer `{"status": "ok", "id", "verdict_id"}` | 3.2's row with C-M12 (27 (1), (2), (9)); README 8.1; B 3.11's copy rule; EV-C02-005 2.4; EV-C02-008 2.2 condition 2 |
| `devos_api.transfer_acceptance(p jsonb)` (M09-12:481) | The form of 27 (3): `accepted_use` `installation_acceptance`, `scope` `installation`, `current_evidence` naming the Review copy (M09-12:686). The key; the run. The Review copy (M09-12:766-808: `verdict_missing`, `could_not_check`, `verdict_failed` for `fail` and `indeterminate`, the use); `current_evidence`'s entries and the ledger entry a conditional verdict needs (M09-12:810-860); the installation's Mission and its owner authority (M09-12:862-891); the target (M09-12:893-1000: its family, its row locked, its revision, Rule O or the Decision's opener, the Decision's status and `open_exploration`). Writes the Acceptance, its mark, and the target's state with `acceptance_set` (M09-12:1015-1047). Answer `{"status": "ok", "id"}` | 3.2's row with R1-9, R1-10, R2-2 and C-M12 (27 (1), (3) to (9)); README 8.1; B 3.11, 3.17; EV-C02-005 2.4 |
| Grants (M09-12:1061-1082) | `revoke all … from public` and from the four API roles where they exist, on both; `grant execute … to anon` on both; no type, no private function | 1 item 13; T-W08-PRIV (`W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, unchanged) |

O (`07_catalog.txt`):
- **EXECUTE.** No one but the owner holds it on a function of either schema, except `anon`, on the fifty-five `devos_api` functions (55 rows).
- **The literals.** All fifty-five `devos_api` functions hold their role-list literal, and both of M09-12 hold `array['devos_kurulum']::devos_private.role_class[]` (`TX-literals`).
- **The unqualified-name scan.** No hit in M09-12's two. Its four hits are section 3.1's known false ones.
- **Dynamic SQL.** No function of either schema holds `execute`.
- **The read marker.** Twelve functions carry it, as in sections 12 and 13; neither of the two does (`TX-not-read`; F06: both are state-changing).
- **Types.** No `devos_private` type has PUBLIC USAGE.

### 14.2 Departures from EV-C02-013, and forms it left open

Each is stated in EV13 section 27; none is silent. No merged test is changed.
1. **`transfer_review`** (27 (2)):
   - `independence_level` must be `fresh_context_subagent` (B 3.11's copy rule; any of the six was weighed).
   - `basis_refs` entries are kept as sent, not resolved as records, unlike `open_review`'s (20 (4)), since a copy's basis is a tree and a file path and the merged recipes send strings.
   - `target_revision` needs `target_ref`, must name a revision written, and is `invalid_field` for a family without revisions.
   - The mark also names the Verdict (`verdict_id`), and `lacks` names `target_ref` when none is sent.
2. **`transfer_acceptance`'s refusals that 3.2's row does not name** (27 (3), (4), (6)):
   - `accepted_use` other than `installation_acceptance`, and a Review copy whose `use` differs from it: `invalid_field` (B 3.11's use rule).
   - `current_evidence` that does not name the Review copy: `invalid_field` (B 3.11: the Acceptance "names that verdict").
   - An entry naming nothing written: `reference_missing` (3.1, "Order").
   - An `indeterminate` verdict: `verdict_failed`, as `fail` (B 3.11).
   - A Review whose creation event is another than `transferred`: `verdict_missing`; one with no creation event, or a copy with no Verdict: `could_not_check`.
   - `target_revision` earlier than the target's current revision: `stale_revision`.
   - A Decision's first event of a type other than `decision_opened` or `transferred`: `could_not_check`.
3. **The Acceptance's `target_revision`** is the target's current revision, read under its lock, when the call sends none (27 (9)).
4. **No rule compares the Review copy's target with the Acceptance's** (27 (7); N-279 (18)).
5. **`lacks`** of an Acceptance names `ledger_entry` when no `ledger_entry` event is named (27 (8); EV-C02-005 2.4).

Not departures, for the checker:
- Neither function is closed by the hand-over (3.1, "Closing"); the run rule after it is 3.1's with R1-8, as `transfer_artifact` builds it (25 (7)).
- The mark as the record's only creation event is 26 (1)'s rule, here for the two.

### 14.3 How W-C02-09's points are served by M09-12

- **Point 1.** A versioned file later than `20261019140001`, plain SQL, no `psql` meta-command, no backslash (O, file 59). Offline, `deployment_drift` reports `no_difference`, 25 of 25 (runs 04 and 13). Decisions followed, with the object:
  - the rejected-attempt record's per-call form: `reject` on every refusal (`{"rejected": 1}` deltas in the self-check), and the counted form for a call with no token (`G-<fn>-no-token`; FN-G-<fn>'s counted row +1);
  - F06's list: both are state-changing, neither carries the read marker (`TX-not-read`; F06's `F06-event` and `F06-repeat` of both `ok`);
  - S1's and S2's forms: every mark meets `event_transferred_transfer_source`, and S2's index is the backstop of the key (`TV-repeat`, `TA-repeat`).
- **Point 2.** All 55 `devos_api` functions of EV13 section 2 now exist (`TX-api-count`; file 07, 55 rows), each with definer rights, the fixed `search_path` and every DevOS name qualified (14.1's scan). The record's list and the catalogue's agree.
- **Point 3.**
  - Fourth bullet. Each of the two refuses a call with no token before any other check (`G-<fn>-no-token`; FN-G-<fn> `ok`), and a class not on its list, with one per-call row (`G-<fn>-<class>`; 5B row R19, all twelve cells of the two `ok`; FN-G-<fn> `ok`).
  - Fifth bullet. A declared role name and origin change nothing: `TV-pos` sends `role_class`, `reviewer_role_class` `devos_denetim` and `origin` `owner`, and the copy carries `devos_kurulum` and `call` (`TV-pos-row`, `TV-pos-mark`; FN-R-declared `ok`); `TA-pos` sends an `owner_authority`, and the Acceptance carries D-010's (`TA-pos-row`).
- **Point 5.**
  - Each writes its records and its mark in the same transaction, with the token's class (`TV-pos-mark`, `TA-pos-mark`, `TA-pos-state`, `TA-decision-pos-state`; FN-T-ev-transfer_review `ok`).
  - An exact repeat writes nothing and answers the existing id (`TV-repeat`, `TA-repeat`: `ok repeat`, `{}`; FN-I-same `ok`; F06-repeat of both `ok`).
  - A failure planted mid-transaction leaves no half state and no orphan event, only the refusal row (`TV-write-failed`, `TV-write-mark-failed`, `TA-write-failed`, `TA-write-mark-failed`, `TA-write-state-failed`, `TA-write-state-event-failed`; FN-T-half-ev and -rec of `transfer_review` `ok`). `TV-write-P0D02` gives `could_not_check` with the fixed reason.
- **Point 7.** Missing, unreadable and partial input gives `could_not_check` with its reason, never a pass: `TV-events-unreadable`, `TA-events-unreadable`, `TA-review-no-event`, `TA-two-missions`, `TA-work-mission-no-event`, `TA-decision-no-event`.
- **Point 8.** W-C02-08's four copies, W-C02-03's three and the IDC copy pass again with the new copies beside them (runs 09 and 11). The copies this pull request makes, with each run, are in 14.4.
- **Point 10.** All fourteen exist, each as point 2 asks (`TX-fourteen`; FN-M-cat `ok`).
  - **T-W14-FN `PASS (109/109)`** (run 06, in place; runs 09 and 11, as the copy; `FAIL (1 bad, 16 could not check, of 109)` on `t24`, run 16). Each of the fourteen refuses every class but `devos_kurulum` and a call with no token, with the attempt recorded (FN-G); after a planted hand-over the ten closed ones refuse (FN-C) and `transfer_review`, `transfer_acceptance`, `transfer_artifact` (for a verdict file) and `record_ledger_entry` still write (FN-O); with one write planted to fail nothing stays (FN-T-half); an exact repeat writes nothing and another hash is refused with its row (FN-I); `transfer_acceptance` refuses a Review copy that is missing, failed, or conditional with no `ledger_entry` event, and an accepted call sets its target accepted in the same transaction (FN-A).
  - Its six breaks each turn exactly their red lists (files 18 to 23; 14.5).
  - W-C02-08's S1 to S4 still pass T-W14-SCH (`PASS (38/38)`, runs 09 and 11).
  - The copy `supabase/migrations/tests/w14_fn_transfer_functions.sql` is FNJ byte for byte (file 59); the migration job runs it in `devos-test`, whose run is the counted one.

### 14.4 The test copies (section 11's table), and what M09-12 does not yet serve

Each row of EV13 section 11 whose "Copy by W-C02-09" says yes, with its condition, and README 5.1 (c)'s one later row. "Copied" means copied byte for byte into `supabase/migrations/tests/` under its staged name, after it passed on this build; file 59 gives each copy's SHA-256 beside its staged file's, equal for all twenty-two, and the staged file's last commit on the branch. Every staged file is unchanged on this branch (file 59: `git diff --stat HEAD -- tests/` empty). Runs: 05 and 06 in place on a fresh database; 09 as the copy, the folder run as the job's `dbtests` step runs it, on a fresh database; 10 and 12 the folder's program as the job's `dbprograms` step runs it (only `PATH`, `HOME`, `LANG` and libpq's settings in its environment, N-255's four keys on standard input, `timeout 600`); 11 the folder's SQL files again on the state run 10 committed (CONC's fixtures, and the global epoch raised by its revocations, 313 before the run as F08-e-ready's detail reads it; the run's own `select` of the epoch failed, its `psql` given no socket, and is not used). [Correction, 2026-10-19, L-402, CHK-C02-107 finding 6: runs 10 and 12 did not run the program as the job's `dbprograms` step does in one respect: no tokens step ran before them; see the CONC row and the dated paragraph after this table.]

| Test | Staged file | Section 11's condition | Result on this build | Copied | Cause, if not |
|---|---|---|---|---|---|
| T-W07-IDC part A | `w07_idc_identity_chain.sql` | with M09-01 | `PASS (43/43)` (05, 09, 11) | already copied (M09-01) | — |
| T-W07-IDC part B | `w07_idc_real_path.py` | after sitting A | not run offline (needs `devos-test`'s Data API) | already copied (M09-02's pull request) | — |
| T-W07-5A positive control | `w07_5a_positive_control.sql` | yes | `PASS (1/1)` (05, 09, 11) | yes | — |
| T-W07-5A part B | `w07_5a_exposed_schema.py` | after sitting A | not run: a Data API program, which no offline run can serve | no | Cannot be shown passing before it is copied: it needs `devos-test`'s Data API (README 5.1 (b)). A copy that failed would set `go` to `no`. For the executor: a run in `devos-test`, or a decision to copy it on the IDC part B precedent |
| T-W07-5C | `w07_5c_other_session_fake_id.sql` | after D-1 | `PASS (8/8)` | yes | — |
| T-W07-6RG | `w07_6rg_rule_gate_could_not_check.sql` | after D-1 | `PASS (32/32)` | yes | — |
| T-W07-6TK part A | `w07_6tk_token_reasons.sql` | yes | `PASS (32/32)` | yes | — |
| T-W07-6TK part B | `w07_6tk_http_reasons.py` | after sitting A | not run (Data API) | no | As 5A part B |
| T-W07-DM07 | `w07_dm07_heartbeat.sql` | after D-1 | `PASS (8/8)` | yes | — |
| T-W07-DM19 | `w07_dm19_rejected_attempt_survives.sql` | yes | `PASS (5/5)` | yes | — |
| T-W07-DM19B | `w07_dm19b_burst_count.sql` | yes | `PASS (14/14)` | yes | — |
| T-W07-DM19B part B | `w07_dm19b_burst_over_http.py` | after sitting A | not run (Data API) | no | As 5A part B |
| T-W07-DM34 | `w07_dm34_mission_scope.sql` | after D-1 | `PASS (10/10)` | yes | — |
| T-W07-F01 | `w07_f01_whole_intent.sql` | after D-1 | `PASS (13/13)`, at epoch 1 (05, 09) and above 313 (11) | yes | — (CONC reads its helpers from this file's copy beside it) |
| T-W07-F04 | `w07_f04_affected_records.sql` | once `installation_mission` is filled | `PASS (32/32)` | yes | — |
| T-W07-F05 | `w07_f05_scope_both_sides.sql` | after D-1 | `PASS (7/7)` | yes | — |
| T-W07-F06 | `w07_f06_state_change_event.sql` | once G20's recipes and D-1, D-2 are in | `COULD NOT CHECK (2 of 147)`: `F06-event:transfer_relation`, `F06-repeat:transfer_relation` (05; on `t24` `2 of 141`, run 16) | **no** | A test fault for the test designer, N-303 (1): its `transfer_relation` recipe (`job/w07_f06_state_change_event.sql:760-763`) names the ends of its `relate` recipe (`:482-483`), accepted earlier in the same transaction, so EV13 26 (4)'s B 3.4 rule answers `conflict` (with that rule removed, 141/141 at M09-11, 13.4). Every case of M09-12's two functions is `ok` |
| T-W07-F07 | `w07_f07_observation_history.sql` | after D-1 | `PASS (7/7)` | yes | — |
| T-W07-F08 | `w07_f08_recheck_at_effect.sql` | after D-1 | `PASS (29/29)` | yes | — |
| T-W07-K05 | `w07_k05_many_paths.sql` | yes | `PASS (6/6)` | yes | — |
| T-W07-N09 | `w07_n09_finding_gate.sql` | yes | `PASS (11/11)` | yes | — |
| T-W07-N17 | `w07_n17_claim_token.sql` | after D-1 | `PASS (13/13)` | yes | — |
| T-W07-N25 | `w07_n25_verdict_staleness.sql` | yes | `PASS (5/5)` | yes | — |
| T-W07-REL | `w07_rel_relation_status.sql` | yes | `PASS (4/4)` | yes | — |
| T-W07-CONC | `w07_conc_claim_and_cycle.py` | yes | `W07_CONC_CLAIM_AND_CYCLE PASS (8/8)` as the copy, twice (10, 12), exit 0, `synthetic tokens of this run left unrevoked: 0`; runs 10 and 12 issued no tokens before it, so they did not model the job's tokens step | **no** (copied, then removed [Correction, 2026-10-19, L-401, CHK-C02-106 C1]) | CHK-C02-106 finding 3: as the job runs it, right after the tokens step's six unrevoked tokens, `CONC-tokens` counts them (every unrevoked token issued within 5 seconds of its start, not only its own) and answers `could_not_check`, so `dbprograms` fails and `go` is `no`; with a 6-second delay it passes, so the result depends on timing. A test fault: the test designer revises `CONC-tokens` to count only the tokens the program issued itself, and the copy follows in N-304's later pull request |
| T-W07-N08 exam fact (may copy) | `w07_n08_exam_fact.sql` | if every case passes (R:248) | `PASS (61/61)` | yes | — |
| T-W07-5B, N01–N04, N08 records, N28, N29, ROC, T31, 5D, 6ST, DM11, DM47, FGFIND | (W-C02-10's copies) | no | run in place (05): 5B `PASS (324/324)`, N04 `PASS (19/19)` (part T now on the real functions), N08 records `PASS (17/17)`, ROC `PASS (84/84)`; DM11 `FAIL (5 bad)` and N28's verifier file `FAIL (2 bad)` (W-C02-10's rules, as in section 13); the others stop at their `-pre` lines | no | W-C02-10's (R:248) |
| T-W14-FN | `tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql` | after its recipe revision | `PASS (109/109)` (06, 09, 11) | yes | — |
| W-C02-08's and W-C02-03's tests | the copies already there | already copied | all `PASS` (09, 11) | already copied | — |
| T-W07-N29 widening (README 5.1 (c)'s table, not section 11's: "the corrective migration's pull request copies it"; not copied then) | `w07_n29_mission_widening.sql` | README's row | `PASS (8/8)` | yes | — (named here because its row is W-C02-09's and it was not made with the rule corrections) |

So twenty-two copies are made: twenty-one SQL files and the CONC program. The folder then holds thirty-one files (twenty-nine SQL files, two programs) and every SQL file passes as the job runs it, on a fresh database (09) and on the state a first program run leaves (11), and CONC passes on both states (10, 12). No file in the folder holds a backslash (file 59).

[Correction, 2026-10-19, L-401, CHK-C02-106 C1] The CONC copy is removed from this pull request (route (a) of CHK-C02-106 C1; its row above). So twenty-one copies are made, all SQL files, and the folder holds thirty files (twenty-nine SQL files and one program, `w07_idc_real_path.py`). File 59 lists twenty-two hashes because it was written before the removal; the twenty-one SQL copies are unchanged. "CONC passes on both states (10, 12)" above is not a result as the job runs it: runs 10 and 12 issued no tokens before CONC (CHK-C02-106 finding 3). The twenty-nine SQL files passing on a fresh database and after a CONC run stand (CHK-C02-106 finding 4 repeated them after the job's token issues).

What M09-12 does not yet serve:
- **T-W07-F06** cannot pass at this head on a correct build (row above); W9 point 8 names it, so point 8 is not met until the test designer revises the recipe and the file is copied.
- **The three Data API programs** are not copied (rows above). Their claims of W9 point 3's third bullet rest, until copied, on `w07_idc_real_path.py`.
- **T-W07-N02** and **T-W07-N28** stop at their `-pre` lines (W-C02-10's `sample_stream`), so their transfer cases (`N02-oe-transfer-accept`, `-pos`, `S-neg-open-transfer`) are not reached; **B-N01-2** is not shown (N01 the same).
- **Rules no merged test reaches**, resting on the producer's self-check alone (their break copies leave every merged case as it is; 14.5): `transfer_review`'s `sample` refusal (b02; N28 reaches it once it runs), the run before the hand-over (b05), the target's references (b07), `independence_level` (b08) and the non-empty basis (b11); `transfer_acceptance`'s copy that is not one (b13), the Mission rule (b16), Rule O for a Work (b17), the Decision's opener, status and `open_exploration` (b18 to b20; N02 reaches the last two once it runs), the Review copy named in `current_evidence` (b22), the use (b23), the owner authority (b24), the run (b25), the key's `conflict` (b26), `target_revision` (b27), the entries (b28) and a Decision set accepted (b29; N02 the same).

### 14.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m0912` at `7fc7537`, with M09-12, the copies, EV13's section 27 and the raw files uncommitted. The main run (`…/m0912_run/rerun.sh`) ran from 2026-10-19T05:27:27Z to 05:28:59Z on one cluster. The comparison and break runs (`brk.sh`) ran from 05:29:26Z to 05:30:32Z on a second cluster. Then `final.sh` wrote files 58 and 59.
- **The drivers.** `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `judge.py` and `catalog.sql` are `…/m0911_run/`'s, changed only in their paths (the clone `prd16`, the cluster under `…/m0912_run/pg`, the socket in `/var/tmp/m12pg`) and their label words. `setup.sql` is `…/m0903_run/setup.sql`, byte for byte.
  - `fn_check.sql` is `fn_head.sql` (M09-11's harness) and `fn_cases.sql` (this migration's counted tables, fixtures and cases).
  - `brk.py`, `brk.sh`, `rerun.sh` and `final.sh` follow section 13's forms; `rerun.sh` also runs the folder's program as the job's `dbprograms` step does. `brk.py` makes each edit inside one function's text only.
- **Trial runs.** Before the filed runs (`…/m0912_run/trial.sh` to `trial5.sh`, none filed): the migrations and T-W14-FN once (`PASS (109/109)` at its first run); every staged file once; CONC once and the candidate copies again on the state it committed; the self-check (`119/119` once one of its own text checks, `TX-no-claim`, was narrowed to a written `created_at`: it had counted the repeat's `order by`). The filed runs give the same summary lines as the trials.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`.
- **02:** the twenty-four migrations before M09-12, each `[exit 0]` with its history row (48 `[exit 0]` lines). **03, M09-12:** `CREATE FUNCTION` ×2, `REVOKE` ×2, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 13:** `deployment_drift` as the migration login: `"status": "no_difference"`, `"migrations_applied": 25, "migrations_expected": 25`, `"complete": true`.
- **05 and 06, every staged SQL file run in place** (not copies; a self-check, never a result): 14.4's rows, and `W14_FN_TRANSFER_FUNCTIONS PASS (109/109)` (06).
- **07, the catalogue:** 14.1's listing.
- **08, the producer's self-check** (`fn_check.sql`; synthetic owner-level fixtures and calls as `anon`, labelled SYNTHETIC m0912; one transaction rolled back): `M0912_FUNCTIONS PASS (119/119)`.
  - **The cases by group:** 12 for the gate (two functions, five classes and no token); 43 for `transfer_review` (`TV-*`); 56 for `transfer_acceptance` (`TA-*`); 8 for the text (`TX-*`).
  - **How they judge.** Each case compares the answer's code and the change of sixteen counts: events, refusals, and the Review, Verdict, Acceptance, Mission, Work, EffortPolicy, Relation, Decision, Need and Finding tables with their revisions. The state cases read the rows after. A plant runs with its call in a subtransaction that is undone, and the delta is measured after the plant.
  - **Cases among them.** `TV-kind-sample` (`kind_not_allowed` with no other key sent), `TV-level-other`, `TV-basis-empty`, `TV-trev-alone`, `-unwritten`, `-norevs`, `TV-target-unwritten`, `TV-after-handover` and `-run`, `TV-pos-row`, `-verdict`, `-mark`, `TV-no-target-lacks`; `TA-no-mission`, `TA-review-unwritten`, `-not-copy`, `-no-event`, `TA-fail`, `TA-indeterminate`, `TA-cond`, `TA-cond-other-event`, `TA-review-use`, `TA-ce-no-review`, `-unwritten`, `-event-unwritten`, `TA-two-missions`, `TA-target-finding`, `TA-trev-stale`, `TA-work-not-installation`, `-mission-no-event`, `TA-decision-cal`, `-no-event`, `-open`, `-open-exploration`, `-pos-state`, `-accepted`, `TA-work-already-accepted`, `TA-cond-pos-mark`, `TA-write-state-failed`, `TA-after-handover`; `TX-literals`, `TX-signature`, `TX-alias`, `TX-not-read`, `TX-no-claim`, `TX-definer`, `TX-fourteen`, `TX-api-count`.
  - Then `events_holding_a_token_format_string 0`, `rejected_rows_holding_a_token_format_string 0`, and after the rollback 0 rows in `review`.
- **09 to 12, the job's folder with the copies:** 14.4.
- **14:** the server log, `186 lines; claim-format 0; environment-format 0`; `[pg_ctl stop exit 0]`, `[cluster directory deleted: yes]`.
- **15:** the break cluster's setup, the templates `t24` and `t25` (`[template … exit 0]`), and `brk.py`: `29 break copies made`.
- **16 and 17, the comparison** of T-W14-FN, 5B, F06, N02, N04 and N28's exemption file on fresh copies of `t24` and `t25`: T-W14-FN `FAIL (1 bad, 16 could not check, of 109)` → `PASS (109/109)`; 5B `PASS (312/312)` → `PASS (324/324)`; F06 `COULD NOT CHECK (2 of 141)` → `(2 of 147)`, the same two cases; N04 `COULD NOT CHECK (3 of 19)` (`N04-T1`, `-T2`, `-T2-pos`) → `PASS (19/19)`; N02 and N28 on their `-pre` lines on both.
- **18 to 27, the merged break patches**, each on a fresh copy of `t25`, each `[patch exit 0]`:
  - **B-FN-1** red exactly `FN-G-transfer_review`; **B-FN-2** exactly `FN-C-begin_transfer_run`; **B-FN-3** exactly `FN-C-transfer_decision`; **B-FN-4** exactly `FN-I-other-review`; **B-FN-5** exactly `FN-T-half-ev-transfer_review`, `FN-T-half-rec-transfer_review`; **B-FN-6** exactly `FN-A-fail`. So the six are shown on the real build for the first time for B-FN-1, -4, -5 and -6.
  - **B-N04-1** red `N04-k2` in N04 and `5B-R07-accept-kur` in 5B: together exactly its list (the judge compares each file with the whole list, so each line reads "not as expect-red" for the other file's case). **B-N04-2** exactly `N04-T1`; **B-N04-3** exactly `N04-T2`: part T's breaks are shown on the real `transfer_review` (N-293, N-294's "shown on stubs only").
  - **B-N01-2** not shown: N01 stops at its `-pre` line (W-C02-10's).
- **28 to 56, the break copies**, each in a fresh database copied from `t24` with the copy applied in M09-12's place (`[apply exit 0]`). Then the self-check, T-W14-FN and N04 ran, and 5B for b01 and b12. Each turned the self-check red (`M0912_FUNCTIONS FAIL (n of 119 not as wanted)`), its own case among the red. Knock-on red cases follow a call the break wrongly admits, which writes a key later cases meet. Merged cases that turned `bad`:
  - **b01** (`transfer_review` admits `devos_calisma`): **`FN-G-transfer_review`, `5B-R19-transfer_review-cal`**. **b03** (its conflict removed): **`FN-I-other-review`**. **b04** (its repeat writes again): **`FN-I-same`**. **b06** (a `run_id` admitted after the hand-over): **`FN-RN-after-handover`**. **b09** (`reviewer_role_class` from the call): **`FN-R-declared`**. **b10** (its mark not written): **ten FN cases** (`FN-T-ev-transfer_review`, `FN-T-half-ev-transfer_review`, `FN-I-same`, `FN-I-other-review`, `FN-O-transfer_review`, `FN-O-transfer_acceptance` and the four FN-A that need a copy) and one `could_not_check`.
  - **b12** (`transfer_acceptance` admits `devos_calisma`): **`FN-G-transfer_acceptance`, `5B-R19-transfer_acceptance-cal`**. **b14** (`fail` accepted): **`FN-A-fail`**. **b15** (the conditions unchecked): **`FN-A-cond`**. **b21** (the Work's state not set): **`FN-A-pos`, `FN-A-cond-pos`**.
  - The other nineteen (b02, b05, b07, b08, b11, b13, b16 to b20, b22 to b29) turn no merged case red: 14.4's last bullet.
  - So each rule built turns its self-check cases red when removed. The merged files caught ten of the twenty-nine; the self-check caught all twenty-nine.
- **57:** the server log, `540 lines; claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **58:** files 01 to 57 scanned with the finders of `scan_patterns.json`.
- **59:**
  - the hashes in the envelope, and each copy's SHA-256 beside its staged file's;
  - the text counts of M09-12 and the copies (backslashes, meta-command lines, token finders, markers, the exam table, claim names, `created_at`, `answered_at`);
  - `git status --porcelain`: EV13 and this record modified; M09-12, the twenty-two copies and the raw files untracked;
  - `git diff --stat HEAD -- tests/ supabase/migrations/tests/ .github/ tools/ plan/ .claude/`: empty (the copies are new files).

### 14.6 Open, and for whom

1. **For the test designer, under ledger rule 3** (reported, not done: no test file is changed here):
   - T-W07-F06's `transfer_relation` recipe (N-303 (1)); until then F06 is not copied and W9 point 8's F06 is not met.
   - Cases, with breaks, for 14.4's rules no merged test reaches, chiefly `transfer_acceptance`'s Review-copy, Mission, ownership and key rules and `transfer_review`'s `independence_level`, and an FN-I case for `transfer_acceptance` (FN's "Not covered" (2)).
   - T-W07-N02's and T-W07-N28's transfer cases wait for W-C02-10's `sample_stream`.
2. **For the executor** (reported, not done):
   - The three Data API programs of 14.4 (5A part B, 6TK part B, DM19B part B) can be shown passing only in `devos-test`: whether to copy them on IDC part B's precedent, or after a run, is the executor's.
   - The CONC copy runs in `devos-test` at every job run (every push to `main` and every six hours, R 5.1 (c)), commits its labelled fixtures there each time and raises the global epoch by its revocations; README 5.1 (b) allows it. It claims through direct connections (`sql-set-role`), not over the Data API, so N-281's ban on real-path claims is not reached; the executor confirms that reading. [Correction, 2026-10-19, L-401, CHK-C02-106 C1] The copy is removed from this pull request and follows in N-304's later one, after the test designer's revision of `CONC-tokens`; CHK-C02-106 finding 7 judged the reading of N-281 sound.
   - `w07_n29_mission_widening.sql` is copied here, though README 5.1 (c) gave it to the corrective migration's pull request.
   - EV13 27 (10)'s residuals.
3. **For the checker of verdict (i):**
   - EV13 section 27 with its *[C-M12]* marks;
   - 14.2's departures, chiefly 1 (`independence_level`; the basis kept as sent), 2 (the refusals 3.2's row does not name) and 4 (no target comparison);
   - the copy table of 14.4, and the hashes in file 59;
   - the self-check and the break copies, which are the producer's own.

## 15. The transfer corrections, and the two test copies

The producer's record of `supabase/migrations/20261019180001_w09_transfer_corrections.sql` (M09-TC), the corrective migration of EV-C02-018 section 16 (decision 12, with L-407's dated line), holding decisions 2, 5, 6, 7 and 8 in the forms EV13 section 28 (*[C-TC]*) states, and of the two copies decision 12's dated line names. It was written on branch `claude/c02-w09-m09tc` at `main` `7cb9972e2742ce17d0aa2d8f94f2ba21f4bdbcad` (pull request #387, test round 2, merged), where M09-01 to M09-12 and the rule corrections are merged and applied, and EV13 section 28, CHK-C02-110 and CHK-C02-111 are merged. The producer is a fresh-context subagent of the same session; the executor names the agent at filing. It is not a verdict.
- **Citations.** EV13:n, B:n and FN:n are lines at `7cb9972`. M09-TC:n is a line of the file above at the bytes the envelope names; M09-08:n, M09-10:n, M09-11:n and M09-12:n are lines of those merged migrations. FN is `tests/C02/W-C02-14/T-W14-FN_transfer_functions.md`, FNJ its job file; `job/` is `tests/C02/W-C02-07/job/`; LOCKS is `job/w07_locks_key_and_handover_locks.py`.
- **Independence from the tests' authors.** M09-TC was generated from the merged migrations' own function texts and section 28 by the producer's `build.py`. The test designers' labelled stand-ins (`…/scratchpad/round2TCB2_run/`, `…/round2TCA_run/standin/`) and their reports were not read. Where M09-TC's text equals a stand-in fragment a merged break patches, it is because section 28 words it so (the lock statements) or by the same plain reading (B-FN-66's and -67's `if v_agg_type in ('work', 'need') then`); 15.6 lists the breaks whose fragments it does not share.
- **What binds this file, checked before the SQL was kept** (`plan/work/C02.md`; EV-C02-018 16):
  - **N-306 (1)** (the lock order per function): M09-TC takes the locks in EV13 28 (2)'s table, 9004 and 9001 after the key read as built (self-check `TX-9007-transfer_mission`, `TX-9007-transfer_relation`; 15.1).
  - **N-307 (1)**: the history name is `w09_transfer_corrections` (the file's name after its version; T-W14-FN's sixth block opens on it, runs 06 and 09); the lock statements are worded as 28 (3) to (5) word them (B-LOCKS-1 to -4 apply, run 44; self-check `TX-9005-*`, `TX-9006`, `TX-9007-*`); the fragments of B-FN-64 to -121 and -124 to -130: 15.6.
  - **EV13 28 (10)**, the fragment rule: every fragment of B-FN-8 to -15 and -17 to -41 occurs exactly once in its function's new text, as in its merged text (`fragcheck.py`, 37 fragments; shown by the harness, runs 40 and 41).
  - **N-306 (2)** and **EV13 28 (12)**: every merged staged file that calls one of the fourteen, found again by a search at this head, run on `main`'s build and on this one, case by case (15.5, run 15).
  - **Decision 12's dated line**: only the two copies shown passing offline on the final build are made (15.4).

**Evidence envelope (plan Section 8 item 9).**

| Field | Value |
|---|---|
| Source commit | Branch `claude/c02-w09-m09tc` at `7cb9972`, clean before this work. The runs were made with M09-TC, the two copies, this section and the raw files uncommitted (O, `51_git_hashes.txt`). Bytes run: M09-TC `766c08d9c32cdd0611982a32a44e845af28f0ae8f397f0c48459a0060837f319`, made by `…/scratchpad/mtc_run/build.py` from the merged migrations' own text; its per-function difference `…/mtc_run/fn_diff.txt`; the self-check `…/mtc_run/fn_check.sql`, the break maker `…/mtc_run/brk.py` and every other driver with their hashes in file 51. A committed file with other bytes is not what was run |
| Deployment configuration | Offline only, as sections 1 and 3 to 14: one throwaway PostgreSQL 16.15 cluster per script, unix socket only (in `/var/tmp/mtcpg`, under the 107-byte limit), in a user namespace (`unshare -U --map-user=1000 --map-group=1000`), deleted after the run (O, files 12 and 30: `[cluster directory deleted: yes]`); the merged harness's own clusters for files 40 to 44 (abstract sockets, TCP off, removed by the harness). Stand-ins: `…/scratchpad/m0903_run/setup.sql`, byte for byte (file 51). The comparison and break runs copy each fresh database from `t25` (`main`'s twenty-five migrations) or `t26` (`t25` with M09-TC). The projects run PostgreSQL 17 with Supabase's role set; no project was reached, no connector used, no network call made |
| Criterion version | W9's acceptance block at `7cb9972`; EV13 sections 1 to 28 (28 for this migration's checker); EV-C02-018 section 16 with its dated line; CHK-C02-110 C1 and C2; N-306 and N-307 |
| Input | The twenty-six migrations; the folder `supabase/migrations/tests/` with its twenty-nine earlier files and the two copies (one new, one refreshed); every staged SQL file of `job/` and FNJ, run in place; LOCKS, run as the harness runs a database program; the 30 merged staged SQL callers of the fourteen on both templates (file 15); the merged breaks B-FN-1 to -130, B-LOCKS-1 to -5 and B-F06-1, -2 through the merged harness on this build; the producer's self-check; fourteen break copies of M09-TC made outside the repository (`…/scratchpad/mtc_brk/`, by `brk.py`, deleted after the run) |
| Raw evidence | `evidence/C02/raw/EV-C02-014_tc_offline_01_init_setup.txt` to `…_51_git_hashes.txt` (01 to 30, 40 to 44, 50, 51), written directly by `…/mtc_run/rerun.sh` (01 to 12), `brk.sh` (13 to 30), `harness_all.sh` with `brkh.sh` (40 to 44) and `final.sh` (50, 51). Every file but 51 passed through `scrub.py` (section 10's filter, reading the two finder patterns of `tests/C02/W-C02-07/shared/scan_patterns.json` at run time) and ends `claim-format strings replaced 0; environment-format strings replaced 0`. File 50 scans every other tc file with the same finders. Files 12 and 30 scan the clusters' server logs. File 51 holds hashes, counts and git output only. Every file's first line is the label below |
| Labels of every run | **offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one** |
| Independence level | The producer; not a verdict. The self-check (08) and the break copies (16 to 29) are the producer's own; the merged tests, the harness and the break patches (05, 06, 09, 10, 15, 40 to 44) are the test designers'. The build is independent of the tests' authors only in that its text was not drawn from their stand-ins or reports; it shares section 28 with them |

### 15.1 What was built, object by object

All in M09-TC, in this order: the fourteen functions, each with a one-line comment naming its changes; the two indexes with their comments; the grants. Each function is its merged text with only the lines added that its comment names: `fn_diff.txt` (file 51 gives its hash) holds each function's difference, and every hunk adds lines, none removes one but the `create function` line, which becomes `create or replace function` (321 lines added in all). Signatures, parameter names, the `ALIAS FOR $n` form, the role literals, `security definer`, the `search_path` and every other check, code, reason, read, write and event are the merged ones (self-check `CAT-*`, `CAT-literal-*`; run 14: of all 69 `devos_api` and `devos_private` functions, exactly the fourteen differ between `main`'s build and this one, and `record_ledger_entry` is not among them).

| Function (M09-TC line) | Added | Follows (EV13 unless named) |
|---|---|---|
| `prepare_operation` (:30) | `perform pg_catalog.pg_advisory_xact_lock(9006, pg_catalog.hashtext(v_ns \|\| ':' \|\| v_ikey));`, the first statement after `v_check := 'idempotency'`, before the key read | 28 (2), (3); decision 2; B:257 |
| `begin_transfer_run`, `end_transfer_run` (:547, :728) | `perform pg_catalog.pg_advisory_xact_lock_shared(9005, 0);` after `v_check := 'handover'`, before the hand-over read; 9002 kept where it is | 28 (2), (4); decision 5 |
| `record_handover` (:878) | `perform pg_catalog.pg_advisory_xact_lock(9005, 0);` after `v_check := 'handover'`; after the run check and before the installation's Mission, the run's input commit (the first begun event's `input_commit` by id): missing, `could_not_check` (`run: the begun event of the run lacks its input commit (partial)`); another than `input_commit`, `invalid_field` (`input_commit: not the run's input commit (EV-C02-005 3.2)`) | 28 (4), (6); decisions 5, 6 |
| `transfer_event` (:1064) | 9005 shared; `perform pg_catalog.pg_advisory_xact_lock(9007, pg_catalog.hashtext(v_kind \|\| ':' \|\| v_sid));` after `v_check := 'key'`, before the key read; the input commit after `run_not_open` (`transfer_source: input_commit is not the run's input commit (EV-C02-005 3.2)`); ownership (`v_check := 'rule_o'`) after the aggregate and its revision are found and before the `ledger_state_row` check: a Work's current revision missing, its Mission missing, a Need's Mission missing, or `is_installation_mission` NULL, `could_not_check`; false, `not_owner` (`aggregate_id: not a record of the installation's Mission (B section 2; R2-2's reading)`); a Mission's event judged as built | 28 (2), (4) to (7); decisions 2, 5, 6, 7 |
| `transfer_artifact`, `transfer_decision`, `transfer_finding`, `transfer_review`, `transfer_acceptance` (:1475, :3182, :3809, :4167, :4583) | 9005 shared; 9007 on the function's kind (`'artifact'`, `'decision'`, `'finding'`, `'verdict'`, `'acceptance'`) and the source ID; the input commit after `run_not_open` (in the three with a hand-over branch, only before the hand-over) | 28 (2), (4) to (6) |
| `transfer_mission` (:1778) | 9005 shared; 9007 on `'mission'`; the input commit; both before 9004, which stays after the key read | 28 (2), (4) to (6); N-306 (1) |
| `transfer_work`, `transfer_need` (:2133, :3527) | 9005 shared; 9007 on `'work'` (covering the policy mark, 28 (5)) and `'need'`; the input commit | 28 (2), (4) to (6) |
| `transfer_relation` (:2615) | 9005 shared; 9007 on `'relation'`; the input commit, before the cycle read and its 9001; ownership after the ends loop (both ends found, `from_ref` locked) and before the group, `from_ref` then `to_ref`: a Work, Need or Mission end as `transfer_event`'s, the reasons naming the end; a Decision end by its first event on aggregate `decision`: missing, NULL type or class, or a type other than `decision_opened` or `transferred`, `could_not_check`; a class other than `devos_kurulum`, `not_owner`; other families not judged | 28 (2), (4) to (6), (8); decision 7; N-306 (1) |
| Indexes (:5184, :5187) | `event_transfer_run_idx` on `(payload ->> 'run_id')` where `event_type = 'transfer_run'`; `event_ledger_entry_idx` on `(payload ->> 'entry_id')` where `event_type = 'ledger_entry'`; neither unique; each with a `comment on index` citing EV-C02-018 section 8 | 28 (9); decision 8 |
| Grants (:5191 on) | `revoke all … from public` and from the four API roles where they exist, on all fourteen; `grant execute … to anon` on all fourteen | 1 item 13; T-W08-PRIV (`W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, unchanged) |

O (`07_catalog.txt`, `08_selfcheck.txt`): each of the fourteen has `definer t`, `search_path=pg_catalog, pg_temp`, VOLATILE, owner `postgres`, and EXECUTE for `anon` only; no type or `devos_private` function is added. Lock statements in the file (file 51): 9005 shared 12, 9005 exclusive 1, 9006 1, 9007 10, and the three merged ones carried in the replaced texts (9002 in `begin_transfer_run` and `end_transfer_run`, 9004 in `transfer_mission`); 9001 stays in `hard_dependency_cycle`, which is not replaced. `record_ledger_entry` is named outside comments only in the entry index's comment text.

### 15.2 Departures from EV-C02-013, and forms it left open

No departure from section 28 in substance: every rule, code and place is 28 (3) to (9)'s. Forms the section leaves open, as built (for the checker):
1. **The input commit is read by its own query** after `run_not_open`, the first begun event by id (28 (6)), not with the phase counts as EV-C02-018 6 (e) sketched; the phase-count query is unchanged, so no fragment of it repeats.
2. **The reason texts** 28 does not give in full: a Need's missing Mission is `ownership: the need's Mission is missing` (`transfer_event`) and `<end>: the need's Mission is missing` (`transfer_relation`); in `transfer_relation` every reason of 28 (7) names the end (`from_ref: …`, `to_ref: …`), as 28 (8) says. The tests judge codes only (FN:18).
3. **A relation end's family** is told for ownership by an ordered test of Work, Need, Mission and Decision, after the ends loop (whose union query is unchanged); a uuid in two families would be judged by the first (**Inf**: the ids are random uuids, so this does not arise).
4. **A Work end's Mission** is its current revision's, as in `record_ledger_entry` and 28 (7), not the revision the relation names.
5. **Comments.** Besides each function's one-line comment, the input-commit and ownership blocks each carry a short comment citing 28; no comment holds a lock statement's text, so B-LOCKS-1 to -4's patterns count only the statements.

### 15.3 How the decisions and W-C02-09's points are served

- **Decision 2** (9006, 9007): a second first use of one new key waits and answers the exact repeat of one record, for `prepare_operation` and `transfer_artifact` (LOCKS `LOCKS-po-repeat`, `LOCKS-tr-repeat`, 5 runs each, seen waiting at `advisory:9006` and `advisory:9007`; run 10); each lock is in its function's text (FN-LK-9006, FN-LK-9007-<fn>).
- **Decision 5** (9005): every closed call made while a hand-over is uncommitted waits for it and then answers `handed_over`, and a hand-over waits for an uncommitted closed call (LOCKS `LOCKS-ho-fwd:<f>` for the ten, `LOCKS-ho-rev` 5 runs, `LOCKS-ho-cut`); FN-LK-9005-<fn> for the thirteen.
- **Decision 6**: each of the eleven refuses another input commit with `invalid_field` and a begun event without one with `could_not_check`, and an exact repeat is not compared (FN-IC-<fn>, FN-IC-cnc-<fn>, FN-IC-repeat).
- **Decision 7**: FN-OW-ev-* and FN-OW-rel-* (21 cases), each ✘ case against its accepted pair; F06's moved recipes accepted (`F06-event` and `F06-repeat` of both functions `ok`).
- **Decision 8**: FN-IX-run and FN-IX-entry; the self-check's `IX-*` (each index's definition, not unique, its comment; usable for a parameter under a generic plan with sequential scans off, `IX-plan-*`).
- **Point 1.** A versioned file later than `20261019160001`, plain SQL, no backslash, no `psql` meta-command (file 51). Offline, `deployment_drift` reports `no_difference`, `"migrations_applied": 26, "migrations_expected": 26` (runs 04 and 11).
- **Point 2.** The fourteen keep definer rights, the fixed `search_path` and their qualified names; the catalogue's list is unchanged in number (69 functions in `devos_api` and `devos_private` before and after, run 14).
- **Point 8.** Every SQL file of the folder passes as the job's `dbtests` step runs it, on a fresh copy of the build and again on a used database (run 09, 30 of 30 each time: the twenty-nine SQL files there before this work, T-W14-FN's now refreshed, and F06's new copy). T-W07-LOCKS is staged in `job/` and not copied: it is listed under point 8's "listed with that item and not counted", naming W-C02-13 (N-307 (2), (4); CHK-C02-111 finding 7).
- **Point 10.** T-W14-FN `PASS (265/265)` in place (run 06) and as the copy (run 09, twice); on `main`'s build `COULD NOT CHECK (70 of 265)`, exactly the sixth block's 70 cases, every other case `ok` on both (run 15).

### 15.4 The two copies (decision 12's dated line)

| Test | Staged file (last commit) | Result on this build | Copied |
|---|---|---|---|
| T-W07-F06 | `job/w07_f06_state_change_event.sql` (`8a35886`) | `PASS (149/149)` (05 in place; 09 as the copy, twice; 15 on fresh copies) | yes, new: `supabase/migrations/tests/w07_f06_state_change_event.sql`, byte for byte (file 51: SHA-256 `827e8726…0091c` both) |
| T-W14-FN | `tests/C02/W-C02-14/job/w14_fn_transfer_functions.sql` (`8a35886`) | `PASS (265/265)` (06; 09 twice; 15) | yes, refreshed: the 1,256-line copy replaced by the 2,976-line staged file, byte for byte (file 51: `86b321b0…44e6` both) |
| T-W07-CONC, the three Data API programs | — | not run here | no: decision 12's dated line puts them in a later pull request, after this migration is applied to both projects |
| T-W07-LOCKS | `job/w07_locks_key_and_handover_locks.py` | `PASS (17/17)` three times (10), each on its own marked copy | no: it commits the one hand-over and an effect class, so it runs on a throwaway database only; its counted result is W-C02-13's PostgreSQL 17 run (N-307 (2)) |

The folder then holds 31 files (30 SQL files and `w07_idc_real_path.py`); no file in it holds a backslash (file 51). Per point 10's copy rule, the void 109-case result and the revised file's first result are the executor's to state in W-C02-09's record (N-307 (5)); the revised file's first counted result is the job's run of this copy.

### 15.5 The offline runs, with their raw lines

**offline, PostgreSQL 16.x, counts: no: the migration job's run in `devos-test` (17) is the counted one.**
- **When and where.** On branch `claude/c02-w09-m09tc` at `7cb9972`, with M09-TC, the two copies, this section and the raw files uncommitted. The harness batches (`harness_all.sh`, files 40 to 44) ran from 10:13:00Z to 10:23:12Z, four batches side by side and then the LOCKS and F06 batch alone; the comparison and break runs (`brk.sh`, 13 to 30) from about 10:24Z to 10:26:34Z; the main run (`rerun.sh`, 01 to 12) last, after one self-check case was narrowed (below); then `final.sh` wrote 50 and 51.
- **The drivers** are under `…/scratchpad/mtc_run/`. `run.sh`, `drive.py`, `scrub.py`, `scan.py`, `judge.py` and `catalog.sql` are `m0912_run`'s, changed only in their paths (the clone `prd18`, the cluster under `mtc_run/pg`, the socket in `/var/tmp/mtcpg`), their label words, and `run.sh`'s database (`MTC_DB`, default `postgres`). `setup.sql` is `m0903_run/setup.sql` byte for byte (file 51). New: `build.py`, `fn_check.sql`, `brk.py`, `brk.sh`, `brkh.sh`, `sumh.py`, `harness_all.sh`, `cmpcases.py`, `search.py`, `fragcheck.py`, `final.sh`.
- **Trial runs** (not filed): the 26 migrations, T-W14-FN, F06 and LOCKS once (`PASS (265/265)`, `PASS (149/149)`, `PASS (17/17)` at their first run), and two patches through the harness.
- **The self-check corrected after a filed run.** The first filed run 08 gave `MTC_FUNCTIONS FAIL (1 of 93)`: `TX-no-owner-transfer_acceptance` looked for `v_own`, which the merged `transfer_acceptance`'s variable `v_owner` also holds. The case was narrowed to `v_own_fam` and files 01 to 12 were made again; the narrowed case is a criterion changed after its result, so it is labelled as such, and it is the producer's own text check only. Files 13 to 30 ran with the narrowed file.

The runs:
- **01:** `[initdb exit 0]`, `PostgreSQL 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1) …`, `[setup exit 0]`, `postgres|f`. **02:** the twenty-five migrations, each `[exit 0]` with its history row. **03:** M09-TC, `CREATE FUNCTION` ×14, `CREATE INDEX` ×2, `COMMENT` ×2, `REVOKE` ×14, `DO`, `[exit 0]`; history row `[exit 0]`.
- **04 and 11:** `deployment_drift`: `"status": "no_difference"`, `"migrations_applied": 26, "migrations_expected": 26`, `"complete": true`.
- **05 and 06, every staged SQL file in place** (a self-check, never a result): every file that passes at `main` passes; F06 `PASS (149/149)`, 5B `PASS (324/324)`, N04 `PASS (19/19)`, ROC `PASS (94/94)`, T-W14-FN `PASS (265/265)`; W-C02-10's files as at `main` (DM11 `FAIL (5 bad)`, N28's verifier file `FAIL (2 bad)`, the others COULD NOT CHECK at their `-pre` lines); 15 compares them case by case.
- **07:** the catalogue (15.1). **08:** the self-check, `MTC_FUNCTIONS PASS (93/93)`: `TX-*` (each lock statement once, in its place and order; each input-commit comparison and each ownership block in its place; none where 28 puts none; `record_ledger_entry` without them), `CAT-*` (definer, `search_path`, owner, volatility, `ALIAS FOR`, EXECUTE for `anon` only, the role literal), `IX-*`.
- **09:** the folder as the job runs it, on a fresh copy of the build and on the used database: 30 of 30 `passed` each time, among them `W14_FN_TRANSFER_FUNCTIONS PASS (265/265)`, `W07_F06_STATE_CHANGE_EVENT PASS (149/149)`, `W08_PRIV_TYPES_FUNCTIONS PASS (96/96)`, `W14_SCH_TRANSFER_SCHEMA PASS (38/38)`.
- **10:** T-W07-LOCKS three times, each on its own fresh marked copy: `W07_LOCKS_KEY_AND_HANDOVER_LOCKS PASS (17/17)` ×3, exit 0; `LOCKS-tokens`: `tokens of this run left unrevoked: 0`.
- **12:** the server log, `claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **13:** the break cluster, templates `t25` and `t26`, `14 break copies made`. **14:** every `devos_api` and `devos_private` function on `t25` and `t26`: 69 each; exactly the fourteen differ (md5 of `pg_get_functiondef`), ACLs equal; then the search at this head (`search.py`): 44 files name one of the fourteen outside comments, the set of EV13 28 (12) with `w07_locks_key_and_handover_locks.py` added (staged in round 2).
- **15, the comparison** (N-306 (2)): the 26 staged SQL callers of `job/`, T-W14-FN and the three harness scenarios (30 files; LOCKS, which the search also finds, is run in 10 and 44; the copies under `supabase/migrations/tests/` are byte-equal to staged files run here), each on fresh copies of `t25` and `t26`, case by case. No case differs in any file but T-W14-FN, where exactly the sixth block's 70 cases go from `could_not_check` to `ok` (`COULD NOT CHECK (70 of 265)` → `PASS (265/265)`). The scenarios are COULD NOT CHECK on both (W-C02-10's `sample_stream`). The copied callers (F01, F05, F07, F08, 5C, 6RG, DM07, DM34, N08, N17, N29 widening, F06, T-W14-FN) are in it, and so are the not-copied ones verdict (i) must run (N28, 5B, ROC, N02, N04 and the others of 28 (12)).
- **16 to 29, the producer's break copies** (`brk.py`, fixed before any ran), each applied in place of M09-TC on a fresh copy of `t25` with its history row; the self-check, T-W14-FN, and for k01 to k04 LOCKS on a marked copy. Every copy turned T-W14-FN red; merged cases that turned `bad`:
  - k01 (9006 removed): FN-LK-9006-prepare_operation; LOCKS-po-repeat (5 of 5 runs `write_failed`). k02 (9005 shared removed in `transfer_event`): FN-LK-9005-transfer_event; LOCKS-ho-fwd:transfer_event. k03 (`record_handover`'s 9005 made shared): FN-LK-9005-record_handover; LOCKS FAIL (12 bad: ho-rev, ho-cut and the ten ho-fwd). k04 (9007 removed in `transfer_artifact`): FN-LK-9007-transfer_artifact; LOCKS-tr-repeat.
  - k05 (input commit not compared in `transfer_need`): FN-IC-transfer_need. k06 (`transfer_review`'s partial case removed): FN-IC-cnc-transfer_review. k07 (`record_handover`'s comparison removed): FN-IC-record_handover. k14 (`transfer_mission`'s comparison removed): FN-IC-transfer_mission.
  - k08 (`not_owner` removed in `transfer_event`): FN-OW-ev-work-other, -need-other. k09 (a Need's event unjudged): FN-OW-ev-need-other, -need-cnc. k10 (a Decision end unjudged): FN-OW-rel-dec-owner, -dec-cnc. k11 (a Mission end unjudged): FN-OW-rel-mission-other, -mission-cnc. k12 (`to_ref` unjudged): 8 FN-OW-rel cases (to, need, mission and dec, each -other or -owner and -cnc).
  - k13 (the run index not made): FN-IX-run; the self-check's `IX-plan-run` and the index row.
  - The text-only self-check catches the lock and comparison copies (k01 to k05, k07, k13, k14); the ownership copies and k06 change no text it reads, and the merged cases catch all fourteen.
- **30:** the server log, `claim-format 0; environment-format 0`; `[cluster directory deleted: yes]`.
- **40 to 44, the merged breaks through the merged harness** (`tests/C02/W-C02-07/harness/run_breaks.py`, unchanged, `--repo` the clone and its 26 migrations, PostgreSQL 16.15, so `counts: no` on every line). Each shown break: positive control PASS, red equal to its `expect-red` list, restore PASS.
  - B-FN-1 to -33: `HARNESS PASS (33/33 breaks shown)` (40), so B-FN-8 to -15 and -17 to -33 apply to the new text (28 (10)).
  - B-FN-34 to -66: 31 shown, B-FN-64 and -65 not (41), so B-FN-34 to -41 apply too; B-FN-66 shown here and -67 in 42 (their fragment is M09-TC's text too).
  - B-FN-67 to -98: 2 shown (B-FN-67, -98), 30 not (42). B-FN-99 to -130: 25 shown, 7 not (43): B-FN-99 to -123 shown (the lock patches, worded as 28 words them, and the two index drops).
  - B-LOCKS-1 to -5 and B-F06-1, -2: `HARNESS PASS (7/7 breaks shown)` (44).
  - So 98 of the 137 are shown on the real build; the 39 not shown are 15.6's.
- **50:** files 01 to 44 scanned again with the finders: no string of either format. **51:** hashes (the migration, `fn_diff.txt`, every driver), each copy's SHA-256 beside its staged file's, the text counts, `git status --porcelain` and `git diff --stat HEAD` of `tests/`, `.github/`, `tools/`, `plan/` and `.claude/` (empty).

### 15.6 The merged breaks that do not apply to M09-TC (N-307 (1), for the test designer)

Each is "not shown" at the patch step, with its controls passing (files 41 to 43). No test or break is changed here (N-307 (1): the test designer revises each, and the migration's checker shows it again).
- **Fragment found 0 times (38):** B-FN-64, -65 (`transfer_event`'s ownership), B-FN-68 to -75 (`transfer_relation`'s ownership and Decision clause), B-FN-76 to -97 (the input-commit comparison and its partial case, in each of the eleven), B-FN-124, -125 (`transfer_event`), B-FN-126 to -129 (`transfer_relation`). Their fragments are the stand-in's text (its `v_tcb_*` names and its wording); M09-TC writes the same rules in other words (15.1; `fn_diff.txt`).
- **Fragment found, patched text does not compile (1):** B-FN-130 (`transfer_decision`, "the input commit compared before the key"): its fragment is the 9007 statement, which M09-TC shares, but its replacement declares nothing and uses the stand-in's variable `v_tcb_ic`, so the patched function fails at `create or replace` and the patch applies nothing.
- **Where the rules these 39 were meant to show stand meanwhile:** the sixth block's cases turn red when the rules are removed from M09-TC itself (the producer's copies k05 to k12 and k14, 15.5), which covers the rule kinds of B-FN-64 to -97 and -124 to -129 in some of the functions, not each function's text; B-FN-130's kind (the comparison moved ahead of the key) has no producer copy.

*[Dated line, 2026-10-19, L-411: the 39 breaks of this list are revised to M09-TC's text by test designer `a275d821337114cfa` (fragment and replacement only; no `expect-red` list, case, outcome or judging rule changed; B-FN-70 to -72 now remove the family line of M09-TC's `v_own_fam := case` instead of the stand-in's list); T-W14-FN `PASS (265/265)` unpatched and `HARNESS PASS` 130 of 130 on the real build (`…/scratchpad/brk39_run/out/`), every fragment found exactly once in the live function text.]*

### 15.7 Open, and for whom

1. **For the test designer** (reported, not done): revise B-FN-64, -65, -68 to -97 and -124 to -130 to M09-TC's text (15.6) before the migration's verdict (i) relies on them; the not-applied list is in files 41 to 43.
2. **For the checker of verdict (i):** EV13 section 28 against 15.1 and `fn_diff.txt`; 15.2's forms; the comparison of file 15 (N-306 (2)) and the run of LOCKS on the real migration (N-307 (4)); the 98 shown breaks and the 39 not shown; the copies' hashes in file 51. The self-check and the break copies k01 to k14 are the producer's own; the merged tests, breaks and harness are the test designers'.
3. **For the executor:** N-307 (4) and (5) in W-C02-09's records (LOCKS listed under point 8's "listed with that item and not counted", naming W-C02-13; the 109-case run void for the revised T-W14-FN); the later pull request of CONC and the three Data API programs (decision 12's dated line); EV13 28 (13)'s residuals, unchanged by this build.
4. **Limits.** PostgreSQL 16.15 only; no project, connector or network was used; the counted results are the job's in `devos-test` (17) and W-C02-13's harness run on 17.

*[Dated line, 2026-10-19, L-411, the executor, N-307 (4) and (5): (4) T-W07-LOCKS (`tests/C02/W-C02-07/job/w07_locks_key_and_handover_locks.py`) is listed under W-C02-09 point 8's "a test that needs a later item's part is listed with that item and not counted": it is not copied into `supabase/migrations/tests/` (it would commit an effect class and the one hand-over event in `devos-test`), and its counted result is the harness's PostgreSQL 17 run in W-C02-13; a copy check reads it as listed, not missing. Its offline runs here (file 10) are self-checks. (5) For the revised T-W14-FN (265 cases, two revisions after its first result), the job's run 39209315850 of the 109-case copy is void as its result: the revised file's first result is the job's run of the refreshed copy that this pull request makes (README section 8; W-C02-09 point 10).]*

## 16. The applies and `devos`'s catalogue, for verdict (ii) (the executor, 2026-10-19, L-417)

Not a build section: the record of what verdict (ii) judges for point 1's `devos` part (W-C02-09 "Who judges" (ii)).

- **The job runs** (raw `evidence/C02/raw/EV-C02-014_v2_job_runs.md`, tabulated by a read-only helper through the GitHub tools at about 13:15Z to 13:22Z): 40 `push` runs of `migrate` on `main` from 2026-10-17T22:00Z (run numbers 59 to 103). The `devos` apply step ran and succeeded in 14 of them (60, 74, 76, 78, 80, 81, 82, 85, 90, 91, 93, 95, 96, 101), each after a successful `devos-test` job in the same run; in the other 26 the decide step applied nothing. One run had a failed step: 102 (39244595442, #389), its test programs step (CONC's runner crash, L-415), so `go` was `no`; its `devos` job decided and applied nothing (nothing was pending). The `devos` job runs and decides even after `go` = no, by design (`migrate.yml`'s decide step refuses an apply unless `go` is yes).
- **The last run** 103 (39257765661, push of `545a943`, #390): `devos-test` apply, `deployment_drift` and the SQL tests success; the test programs step success (13:10:36Z to 13:13:41Z; every program exit 0: CONC, 5A, 6TK and DM19B parts B and IDC part B); the six tokens revoked; `devos` nothing pending. So CONC's job result, after its fix, is a pass. The test and program steps together took about 4 minutes, under decision 11's 10-minute trigger (EV-C02-018 16).
- **`devos`'s record and catalogue** (raw `evidence/C02/raw/EV-C02-014_v2_devos_catalog.txt`, read by the executor through the read-only connector at about 13:20Z): 26 migrations recorded, versions and names equal to `supabase/migrations/`'s 26 files at `545a943`; 69 functions in `devos_api` (55) and `devos_private` (14), each with its identity arguments, security definer (all but `devos_private.refuse_change`), `search_path=pg_catalog, pg_temp`, owner `postgres`, ACL (`anon` EXECUTE on every `devos_api` function and on no `devos_private` one) and `md5(prosrc)`, for verdict (ii) to compare with the build.
- **Left to verdict (ii)'s time:** N-279 (8)'s second count of "permission denied to create temporary tables" in `devos`'s logs, about 24 h after M09-02's apply (the self check-in at 2026-10-19T21:35Z); the first count (L-410) found nothing beyond its control.

