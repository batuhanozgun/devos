# T-W07-IDC · The identity chain's first part works as designed, and no token value is kept anywhere

Synthetic test data (plan Section 8 item 13): every token is a synthetic token issued at run time by the function under test (part A, inside the rolled-back transaction) or by the migration job's `devos-test` step for this run (part B), held only in memory and discarded or revoked. Inputs read `w07_fixture SYNTHETIC W-C02-07`. No file holds a token or an example of one (README section 6; `shared/token_format.md`).

**Serves.** W-C02-09 point 3, all six bullets (the environment token), with the parts the first part needs first (EV-C02-003 §3.3 item 1: "W-C02-07 writes the tests of the identity chain's first part: `env_tokens`, the global authority epoch's row, Event with its `origin` …, `issue_env_token`, `revoke_env_token`, the derivation, `token_role_class()` and RejectedAttempt"). Design decisions relied on: Appendix B 3.27 and section 2 as PC-43 places 6 and 7 write them; EV-C02-003 §1.3 to §1.6, §6.3, §14, §15; EV-C02-002 DM-01, DM-19, DM-31, DM-36, A1 items 1 to 4; EV-C02-004 X-01, X-03, X-04, X-07, X-15, Y-05.
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): each of its files is copied byte for byte into `supabase/migrations/tests/` once it can pass, and the job runs that copy, under the path named below; the harness runs the staged file. Part A's file is copied by the pull request that merges the identity chain's first part, and is the test N-221 step 2 runs; part B's program is copied by W-C02-09 once the publishable key is stored (README 5.1 (c) bullet (c); CHK-C02-046 C3).

- Part A (SQL): `psql -X -v ON_ERROR_STOP=1 -f supabase/migrations/tests/w07_idc_identity_chain.sql` against `devos-test`, run by the migration job's test step as `postgres` (README 5.1 (a)); on the throwaway database, by the harness (README 5.2).
- Part B (Data API and file look): `python3 -I supabase/migrations/tests/w07_idc_real_path.py < <JSON from the job>`. The job must run this program in its `devos-test` step (the executor's decision 3), with the job's one JSON object on standard input, with exactly the keys `endpoint`, `apikey` (a string, or `null` while the key is not stored), `tokens` and `revoked_token` (N-255, "The key's source, decided"); it declares no need of the database, so the job runs it under `env -i`. With `apikey` null it exits 3 with that reason. It uses the endpoint, the key and one synthetic token per role class; the job revokes the tokens after it.

**Time added to W-C02-13's run.** None: it waits on no schedule or limit. Part A runs in seconds on a small database; its timeout is 120 s.
**Interface assumed** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. (README section 8; revised before the first result if the build differs):
- `devos_private.issue_env_token(role_class)`: one argument, taking a role class's name as a literal; returns the token as text; adds one `env_tokens` row and one Event with `origin = owner` and `role_class = owner` (EV-C02-002 A1 item 4; DM-31).
- `devos_private.revoke_env_token(<the env_tokens row's id>)`: revokes that one row and adds one to the global authority epoch, with its owner event. If the build revokes by another key, case `IDC-r1` gives COULD NOT CHECK and the call is revised.
- Tables: `devos_private.env_tokens` (B 3.27's name), with exactly `id`, `role_class`, `token_hash`, `issued_at`, `revoked_at`; the epoch's table `devos_private.global_authority_epoch` with column `epoch`; Event in `devos_private.event` with `id`, `role_class` and `origin`; RejectedAttempt in `devos_private.rejected_attempt` with DM-19's fields. The names other than `env_tokens` are assumptions, held in one place: `pg_temp.w07_cfg` in the SQL file.
- `devos_private.caller_role_class(text)` exists (EV-C02-003 §1.6). `devos_api.token_role_class()` returns the role class as a JSON string or an object with `role_class`. A refusal is returned, not raised: a JSON object with `status = 'refused'` (or `refused = true`) and `reason_code` (DM-19 (a): "on a refusal it rolls that block back, writes the record and returns the refusal").
- A Data API request with the publishable key runs as `anon`, and every `devos_api` function is executable by it (EV-C02-003 §1.1). The token header is `x-devos-env-token` (§1.1).
- For part B: the Data API exposes `devos_api` (EV-C02-004 Y-06), and the tokens have the exact format of `shared/token_format.md`.

## Cases

Part A, `w07_idc_identity_chain.sql`:
- **Structure.**
  - `IDC-s1`: `env_tokens` has exactly B 3.27's five columns, with no `authority_epoch` (PC-43 place 7) and no column for a token.
  - `IDC-s2`: the epoch table holds one row (DM-01).
  - `IDC-s3`: Event has `role_class` and `origin` (DM-31).
  - `IDC-s4`: RejectedAttempt has `function_name`, `role_class`, `reason_code`, `counted_hour` and `count`, and no column named for a token, a header or a presented value (EV-C02-003 §14).
- **Issue.** `IDC-i-<class>`, one per role class: the owner issues a token. It is returned once, one `env_tokens` row of that class is added and not revoked, and one Event with `origin = owner` and `role_class = owner` is added.
- **Format.** `IDC-f1`: the six tokens share one prefix ending in `_`, of at most 16 characters, that names no role class, followed by 43 URL-safe characters. The literal marker is checked in part B, since only `shared/token_format.md` and the pattern file may write it.
- **Looked for by value.** `IDC-v1`, right after issuing: no table in any schema holds any of the six values. It looks at `t::text` for every table the owner can read, with the tokens passed as a parameter. Every table of `devos_private`, `devos_api` and `public` must be read; Supabase's own tables the owner cannot read are listed.
- **The derivation.** `IDC-d-<class>`: `token_role_class()`, called as `anon` with that class's token in the header, answers that class. It records no refusal, writes no event and changes no table.
- **No echo.** `IDC-e1`: no `devos_api` function, called with neutral arguments and the working token, puts a presented value in its result or error. Neither does `token_role_class()` called with a cut token. Values found are replaced before anything is stored, and flagged.
- **Owner only.**
  - `IDC-n-issue-as-<role>` and `IDC-n-revoke-as-<role>`: as every application role that exists (`anon`, `authenticated`, `service_role`, `authenticator`, `devos_ingest`, and a database role named for a role class if the build creates one), both functions are refused with SQLSTATE 42501.
  - `IDC-n-issue-token-<class>` and `IDC-n-revoke-token-<class>`: the same with each class's token in the header.
  - `IDC-n-acl`: neither function has EXECUTE for PUBLIC (a null ACL counts as PUBLIC) or for an application role.
- **Revocation.**
  - `IDC-r1`: revoking the working token as owner adds exactly 1 to the epoch, sets `revoked_at`, and adds one owner event.
  - `IDC-r2`: the revoked token is then refused with `revoked`, counted once under `none`.
  - `IDC-r3`: the audit token still answers `devos_denetim`, since the epoch ends claims, not other tokens (EV-C02-004 X-03).

Part B, `supabase/migrations/tests/w07_idc_real_path.py`:
- `IDC-file1`: no statement in a file under `supabase/migrations/` (its `tests/` excluded) calls `issue_env_token` or `revoke_env_token`. A function's definition and grants are allowed (W-C02-09 point 3: "no file under `supabase/migrations/` calls `issue_env_token`"). The look splits statements outside quotes, dollar quotes and comments.
- `IDC-fmt-<class>`: each job-issued token fully matches the environment token's exact format. The program holds that pattern itself (`ENV_TOKEN_EXACT_PARTS`, the marker split so that only the two shared files hold it literally), so a class-normal file cannot change this class-high check (phase C3; C1's open 5). T-W07-7SCAN's `7SCAN-pf5` checks that the embedded copy equals `shared/scan_patterns.json`'s `env_token_exact`, with its break `B-7SCAN-3`.
- `IDC-h-<class>`: the real path, one call per role class. `POST /rest/v1/rpc/token_role_class` with the token in `x-devos-env-token` answers that class with HTTP 200.
- `IDC-h-missing`: the same call without the header is refused with `missing`, HTTP 200.
- `IDC-dd-<class>`: `deployment_drift` over the Data API. The HTTP caller is never the migration login, so the derivation applies. `devos_ci` passes the role gate, and each other class gets a role refusal (EV-C02-003 §4.1, row `deployment_drift`). These are `T-W07-5B`'s cells for that row, which SQL cannot reach (N-244 item (2)).

## Form C0

| Field | Content |
|---|---|
| **ID and claim** | T-W07-IDC. **[Designer's addition: no Appendix C entry; EV-C02-003 §3.3 item 1 and W-C02-09 point 3 ask for it.]** The identity chain's first part does what its design says. A token is shown once and kept nowhere in the database but as its hash's row. Each class's token derives that class over the simulated header and the real path. The owner alone issues and revokes. A revocation adds one to the epoch and ends that token only. |
| **Failure class rule** | Any way a token, or the authority to make or end one, escapes its one designed place. A token's value is kept or echoed. A token derives no class, or a wrong one. A role other than the project owner, or a token, can issue or revoke. A revocation fails to end the token, or ends the others. The epoch does not move. A migration calls the issuer. |
| **Examples** | (1) The original need (W-C02-09 point 3; B 3.27): the value is kept in a table, `IDC-v1`, or echoed in a result or error, `IDC-e1`. (2) Another manifestation: the issuer granted to an API role (`IDC-n-*`, `IDC-n-acl`). (3) The epoch unchanged at a revocation (`IDC-r1`). (4) A revoked token still verified (`IDC-r2`). (5) A migration that issues a token (`IDC-file1`). (6) A token derived as another class (`IDC-d-*`, `IDC-h-*`). |
| **Negative control** | Refused: `IDC-n-*` (SQLSTATE 42501 for each role and token, nothing changed), `IDC-r2` (`revoked`, counted once under `none`, no event, no change), `IDC-h-missing`, and the five `IDC-dd-*` refusals. Looked for and absent: `IDC-v1`, `IDC-e1`, `IDC-file1`. |
| **Positive control** | `IDC-i-*` (the owner issues), `IDC-d-*` and `IDC-h-*` (each token gives its class), `IDC-r1` (the owner revokes), `IDC-r3` (another token still works), and `IDC-dd-devos_ci`. Each differs from its negative in one thing: the owner against an application role; a live token against a revoked one; a header against none. |
| **Break attempt** | Each patch is applied by the harness on the throwaway database (README 5.2). The red cases are fixed here, before any run.<br>**B-IDC-1** (`breaks/B-IDC-1_issue_granted_to_anon.sql`). Removed: B:46's privilege rule; EXECUTE on `issue_env_token`, and USAGE on `devos_private`, are granted to `anon`. Red: `IDC-n-acl`, `IDC-n-issue-as-anon` and `IDC-n-issue-token-<class>` for all six classes.<br>**B-IDC-2** (`breaks/B-IDC-2_revoke_keeps_epoch.sql`). Removed: the epoch increment; a trigger cancels updates of the epoch's table. Red: `IDC-r1`.<br>**B-IDC-3** (`breaks/B-IDC-3_token_kept_in_a_table.sql`). Removed: "kept in no table"; the issuer is wrapped and the wrapper also stores the token. Red: `IDC-v1`.<br>Two breaks of `T-W07-6TK` also turn `IDC-r2` red: **B-6TK-1** (revoked tokens verified) and **B-6TK-2** (token refusals not counted).<br>Part B's real path has no throwaway equivalent (the harness has no Data API). Its rule is the derivation's, broken by B-6TK-1 and B-6TK-2 in part A. `IDC-file1`'s look is shown sensitive by its planted file (Self-check). |
| **Stage and environment** | C02.<br>Part A: `devos-test` (the job's test step after a merge, as `postgres`, before `devos` is applied; EV-C02-004 Y-01, Y-05) and the throwaway database. Part B: `devos-test`'s Data API, from the same step.<br>No real environment token is used: each environment's real token is `T-W07-RT`'s, in `devos`. The design facts it relies on are EV-C02-003 §1.1, §1.6 and §6.3. Not observed: probe P10 (as which role the job runs) and that the job passes standard input to this program (W-C02-03's build). The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer, a fresh-context subagent of type `test-designer` (W-C02-07 phase B, Group D); its agent ID is in W-C02-07's "Record". Run by the migration job in `devos-test`, by W-C02-09's producer at its head, and by W-C02-13's prober with the breaks. Judged by a fresh-context checker that wrote none of the tests, from the raw outputs. Shared: model lineage, and the design records EV-C02-002, -003 and -004 with this directory's README. |
| **Evidence layer** | Structural and behavioural for the database: refusals, records, privileges, catalogue. It does not show that a session cannot read its token (EV-C02-003 §3.2), that the Data API keeps the header out of `devos`'s logs (§14, the executor's log check), or anything in `devos`. Part A's header is simulated, and says so (`transport sql-set-role`; W-C02-09 point 3). Part B shows the real header path in `devos-test` only. |
| **Evidence envelope** | README section 4.<br>Fixed before the run: every case's outcome is `ok`. Counts: part A has 43 cases where four application roles exist (4 structure, 6 issue, 1 format, 1 value search, 6 derivation, 1 echo, 8 role privilege cases, 12 token privilege cases, 1 ACL, 3 revocation); part B has 1 + 6 + 6 + 1 + 6 = 20. Each break's red cases are as in the row above.<br>`transport`: part A `sql-set-role` (in `devos-test`) or `throwaway`; part B `data-api-synthetic`.<br>`observations_ref`: the job's run URL, run ID, and the step and file name. `raw_evidence_ref`: the runner's unedited output under `evidence/C02/raw/`, after README section 4's two hygiene checks. |

## Clause table

Not an Appendix C test, so it has no clause table (point 2 applies to Appendix C tests). W-C02-09 point 3's bullets map as follows:

| Bullet | Case IDs |
|---|---|
| shown once, only its hash | `IDC-i-*`, `IDC-s1` |
| looked for by value | `IDC-v1`, `IDC-e1` |
| issue and revoke refused | `IDC-n-*` |
| no migration calls it | `IDC-file1` |
| the real path per class | `IDC-h-*` |
| refusals per reason code | `T-W07-6TK` |
| declared names change nothing | `T-W07-N04` (`N04-c*`, `N04-e*`) |
| revocation | `IDC-r1` to `IDC-r3` |

The claim of the earlier epoch belongs to `T-W07-F08` (c), Group A.

## Format gate

Not a format-gate test.

## Could not check

The whole test gives COULD NOT CHECK when an object of the interface is absent (`IDC-pre`, as before the build), or when fewer than six tokens can be issued (`IDC-tokens`). Individual cases give it as follows:
- `IDC-v1`, when a table of `devos_private`, `devos_api` or `public` cannot be read;
- `IDC-r1`, when the revocation cannot be called;
- part B, while the job gives it no input (`IDC-http`), or when the Data API answers with its own `PGRST` error rather than the function's;
- `IDC-file1`, when `supabase/migrations/` holds no file to look at.

## Self-check (not a result)

On 2026-10-12 the test designer ran part A on PostgreSQL 16.15 in the session container.
- Without the build, it gave COULD NOT CHECK.
- Against a scratch stub of the interface above (outside the repository, not delivered), it gave PASS (43/43).
- With B-IDC-1, B-IDC-2 and B-IDC-3 each applied to a fresh copy, the cases turned red were exactly each patch's `expect-red` list.
- A patch run without `w07.throwaway = 'yes'` was refused.

Part B gave COULD NOT CHECK (exit 3) without input. Its file look was tried on a scratch tree: a definition and a two-line grant passed, and a `DO` block calling `revoke_env_token` was found. None of these is a result: the projects run 17.6, and the stub is not the build (README 5.2).

## Not covered

- `devos`, and each environment's real token (`T-W07-RT`; W-C02-12).
- Logs: W-C02-09 point 3's "no log the item can read" is the executor's count-only log check (EV-C02-003 §14; the executor's decision 2), not a test here.
- That the stored hash is SHA-256 of the whole token (EV-C02-003 §1.7). README section 6 forbids a test to compare a token's hash, so the hash rule is read in W-C02-09's function text by its checker. The value search and the derivation show only that the value is not stored and that a stored form verifies it.
- The random source's strength (`shared/token_format.md` section 8).
- The claim of an earlier epoch producing no effect (F08 (c), `T-W07-F08`).
- Notices: a value put into a notice cannot be caught inside PL/pgSQL. The job's raw output is scanned by README section 4's checks.
