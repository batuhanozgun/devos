---
id: EV-C02-016
item: N-280
kind: build
produced_by: "producer, fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH (the executor names the agent at filing)"
main_at: 1d981adfb2e1417ade746d89dd78f6a2de175d49
date: 2026-10-18
claim: "N-280's fix of .github/workflows/migrate.yml: both synthetic-token revocations revoke the env_tokens row the token's hash names, the token never reaching psql; a revocation counts only on status ok; a failed revocation keeps the state file and fails the step. Offline runs on PostgreSQL 16.15 are supporting evidence, counts: no; not independently tested; nothing run in a project"
---

# EV-C02-016 · N-280: the migration job revokes synthetic tokens by their hash's row

**What this is.** The producer's record of N-280's fix (`plan/work/C02.md` N-280 and its L-343 annotation; CHK-C02-078 finding 6.2). It is not a verdict; N-280 asks for its own checker verdict, class high. Only `.github/workflows/migrate.yml` changes. The step that uses it runs only when a `.py` file is under `supabase/migrations/tests/`; there is none at `main_at`.

**Labels.** **O** observed in this record's offline runs (raw file named, section 3); **Doc** read in the source named, at `main_at`; **Inf** inference. M09-01 = `supabase/migrations/20261017230001_w09_identity_chain_first_part.sql`; EV13 = `evidence/C02/EV-C02-013_w09_interface.md`.

## 1. The fault, read at the source

- **Doc.** At `main_at`, step `tokens` (line 812) and step `tokens_revoke` (line 915) call `devos_private.revoke_env_token(:'tok')`, with `tok` the token, put into the SQL text by psql's `\getenv` and `:'tok'`. M09-01 line 206 gives `revoke_env_token(token_id uuid)`. The cast fails, and PostgreSQL's error quotes its input: the token goes into the server log (the statement, the error and its `STATEMENT:` line) and psql's standard error (O, run 5 below: 12 token values in the server log, 4 in psql's standard error, for 3 tokens).
- **Doc.** At line 921, `rm -f "$f"` removes the state file whatever the revocation's result.
- **Doc, a second cause N-280 does not name.** `revoke_env_token` answers a refusal (`status refused`, `reason_code not_found`) as a normal result, not an error (M09-01 lines 222 to 225). Both steps took psql's exit 0 as "revoked", so with the signature fixed, a call naming no row would still have been reported revoked (O, run 3: psql exit 0, status `no_row`).

## 2. The change, line by line

Line numbers are the new file's; the old file's are in brackets.

| Lines | Change |
|---|---|
| 772 to 780 [772 to 777] | Step `tokens`' header comment: revocation by `revoke_env_token(token_id uuid)` on the `env_tokens` row whose `token_hash` is the token's hash, computed by `token_hash`'s rule (EV13 section 10); the token never reaches psql; the hash reaches it only through psql's environment; revoked means status `ok`; neither token nor hash is printed. `import` adds `hashlib` and `re`. |
| 798 to 803 [new] | `revoke(token)`: Python computes `hashlib.sha256(token.encode("utf-8")).hexdigest()`, the same value as M09-01's `encode(sha256(convert_to(token, 'UTF8')), 'hex')` (lower-case hexadecimal of the SHA-256 of the UTF-8 bytes), and passes it to psql as `W03_TOKEN_HASH`. The SQL is `\getenv h W03_TOKEN_HASH` then `select coalesce((select devos_private.revoke_env_token(t.id) from devos_private.env_tokens t where t.token_hash = :'h')->>'status', 'no_row');` (`token_hash` is unique, so the subquery gives at most one row). The output is read as a status only if it is 1 to 32 characters of `[a-z_]`, otherwise `unreadable`. Revoked = psql exit 0 and status `ok`. |
| 821 to 825 [812 to 817] | The revoked token is revoked through `revoke(token)`; `revoked_before_programs` is set from its result; the line printed on failure gives psql's exit code and the status, nothing else. |
| 909 to 914 [901 to 905] | Step `tokens_revoke`'s comment: the same rule, the old "argument form is assumed here" sentence dropped (M09-01 fixed the signature); `import` adds `hashlib` and `re`. |
| 923 to 933 [914 to 918] | The same SQL and hash as lines 798 to 803 (the step is a separate program, so the fragment is repeated, as the file already repeats its psql call); `done` = exit 0 and status `ok`; a failure line gives the exit code and the status. |
| 935 to 943 [921] | `rm -f "$f"` only when the program exited 0; otherwise the file is kept, one line says so, and the step exits with the program's code (it fails). A comment states that the file is kept for this job only. |

Unchanged: the steps' `if:` conditions, their `env:`, the state file's shape and path, step `dbprograms`, and step `go`, which already sets `go=no` unless `tokens_revoke`'s outcome is `success` (lines 944 to 965). The fail-closed rule therefore holds by `go`'s existing condition: a failed revocation fails `tokens_revoke`, and `go` is `no` (O, run 3).

## 3. The runs (offline, PostgreSQL 16.15, counts: no)

**Harness** (scratchpad, not committed). A throwaway cluster in a user namespace (`unshare -U`), Unix socket only, `log_statement=all`; the role stand-ins of `prd08c_run/setup.sql` plus the schema `extensions` (as prd10's, for M09-01's pgcrypto); `postgres` a non-superuser applies the thirteen migrations, each followed by its history row. A driver reads the bodies of steps `tokens`, `tokens_revoke` and `go` from the workflow with PyYAML and runs each as GitHub's `bash --noprofile --norc -eo pipefail`, with `PGUSER=postgres` (the owner), `W03_TOKEN_CLASSES="devos_kurulum devos_ci"` (two class tokens, plus the revoked token step `tokens` always adds), and a placeholder `.py` under `supabase/migrations/tests/` so that `tokens` issues. Every psql call goes through a recording stand-in that runs the real psql and keeps its arguments, input, output, error and exit code. `go` is fed `PROGRAMS=skipped` when `tokens` failed, as `dbprograms`' `if:` would give. The scan's token-format patterns are `env_token_find` and `claim_token_find` of `tests/C02/W-C02-07/shared/scan_patterns.json`, read at run time; the scan also counts each issued token's exact value and its hash. The cluster, its log, the recordings and the state files were removed after the run (`06_stop.txt`: `[cluster directory removed: yes]`). Every raw file holds 0 token-format strings and 0 strings of 64 hexadecimal characters (scan after the run).

Files: `prd12_run/driver.py` (SHA-256 `78bf68f34e22b182…`), `prd12_run/rerun.sh`, `prd12_run/bin/psql`, `prd12_run/setup.sql`; raw output in `prd12_raw/`. The workflow run is the new file, SHA-256 `bf06e4c50351e11d…`; the control is `main_at`'s, `b986a6763ecacdf7…`. Scan triples are (token values, token-format strings, token hashes).

**Run 1, cluster** (`01_cluster.txt`). Raw last lines:
```
[setup exit 0]
migrations applied: 13
postgres|f
```

**Run 2, new file, both revocations succeed** (`02_new_ok.txt`). Three tokens issued; the revoked token revoked by step `tokens`; the other two by `tokens_revoke`; rows 3 revoked, epoch 1 to 4, three `env_token_revoked` events. Raw last lines:
```
tokens_revoke exit 0; state file removed
after tokens_revoke: 0 3 rows, 3 revoked, 0 live; epoch 4; events issued 3, revoked 3
  go| devos-test go=yes (head=yes apply=success comparison=no_difference tests=success programs=success revocation=success)
  server log (8 lines, log_statement all): (0, 0, 3)
  psql input, 6 calls (arguments and standard input): (0, 0, 0)
  psql output (standard output and standard error): (3, 3, 0)
    of which 3 issue_env_token calls: standard output (3, 3, 0), standard error (0, 0, 0), exit codes [0]
    of which 3 revoke_env_token calls: standard output (0, 0, 0), standard error (0, 0, 0), exit codes [0]
  steps' output other than ::add-mask:: lines: (0, 0, 0)
[driver exit 0]
```
The three token values in psql's output are `issue_env_token`'s answers, which is how the step receives each token (captured, masked, never printed; unchanged by this fix). The revoke calls' input, output and error hold none. The server log holds no token and no token-format string, and holds each revoked token's hash once: under `log_statement=all` the statement is logged after psql has put `:'h'` in (`02_new_ok.txt` shows the logged statements with the hash replaced by `[64-hex]`).

**Run 3, a failed revocation** (`03_new_delete_row.txt`). After `tokens`, the superuser deletes the `devos_ci` token's row; `tokens_revoke` then finds no row. Raw last lines:
```
  tokens_revoke| synthetic token for devos_ci: NOT revoked (psql exit 0, status no_row)
  tokens_revoke| synthetic tokens: not every token was revoked; the state file is kept and this step fails
tokens_revoke exit 1; state file kept
after tokens_revoke: 0 5 rows, 5 revoked, 0 live; epoch 6; events issued 6, revoked 5
  go| devos-test go=no (head=yes apply=success comparison=no_difference tests=success programs=success revocation=failure)
  server log (9 lines, log_statement all): (0, 0, 3)
  psql output (standard output and standard error): (3, 3, 0)
    of which 3 revoke_env_token calls: standard output (0, 0, 0), standard error (0, 0, 0), exit codes [0]
  steps' output other than ::add-mask:: lines: (0, 0, 0)
[driver exit 0]
```
psql exits 0 for the failed call: only the status check catches it (section 1, second cause).

**Run 4, a failed revocation in step `tokens`** (`04_new_fail_first.txt`). The psql stand-in refuses every revoke call during `tokens` (exit 2, fault injection); `tokens_revoke` runs normally. Raw last lines:
```
  tokens| revoked token (devos_kurulum): issued and NOT revoked (psql exit 2, status unreadable)
tokens_revoke exit 0; state file removed
after tokens_revoke: 0 8 rows, 8 revoked, 0 live; epoch 9; events issued 9, revoked 8
  go| devos-test go=no (head=yes apply=success comparison=no_difference tests=success programs=skipped revocation=success)
  server log (8 lines, log_statement all): (0, 0, 3)
    of which 4 revoke_env_token calls: standard output (0, 0, 0), standard error (0, 0, 0), exit codes [0, 2]
  steps' output other than ::add-mask:: lines: (0, 0, 0)
[driver exit 0]
```
`tokens` fails and records `revoked_before_programs` false; `tokens_revoke` revokes the revoked token again with the others ("synthetic token for the revoked token: revoked").

**Run 5, control: `main_at`'s file** (`05_old_1d981ad_control.txt`), the same driver and scan, to show that they turn red on the fault. Raw last lines:
```
tokens_revoke exit 1; state file removed
after tokens_revoke: 0 11 rows, 8 revoked, 3 live; epoch 9; events issued 12, revoked 8
  go| devos-test go=no (head=yes apply=success comparison=no_difference tests=success programs=skipped revocation=failure)
  server log (17 lines, log_statement all): (12, 12, 0)
  psql output (standard output and standard error): (7, 7, 0)
    of which 4 revoke_env_token calls: standard output (0, 0, 0), standard error (4, 4, 0), exit codes [3]
  steps' output other than ::add-mask:: lines: (0, 0, 0)
[driver exit 0]
```
The logged lines (token replaced) are `select devos_private.revoke_env_token('[token-format string]');`, then `ERROR:  invalid input syntax for type uuid: "[token-format string]"` and its `STATEMENT:` line, four times: CHK-C02-078 finding 6.2's observation, reproduced. Three tokens stay live and the state file is removed.

**Run 6, the repository's checks that read `migrate.yml`** (`tests/C02/W-C02-03/`; the first two are those `migration-checks.yml` step `w03_tests` runs; no `tools/test_*.py` reads `migrate.yml`). Raw last lines:
```
$ python3 -I -B tests/C02/W-C02-03/test_decision_steps.py    exit 0
W03_DECISION_TEST PASS (69/69)
$ python3 -I -B tests/C02/W-C02-03/test_workflow_order.py    exit 0
W03_ORDER_TEST PASS (.github/workflows/migrate.yml)
$ python3 -I -B tests/C02/W-C02-03/test_workflow_guards.py   exit 0
W03_RUN_EXPR_TEST PASS (no run: value holds an expression opener: 57 values in 2 files; 4 planted copies red, 1 control passes)
W03_PR_INPUTS_TEST PASS (21/21 cases; breaks: 6 shown, 0 not shown, of 6)
```
None of them reads the token steps' bodies; they show that the change breaks no order, decision or guard rule, not that the revocation works.

## 4. What is left for the job's first real run

1. **The state file does not outlive the job (a premise of the task, corrected).** `RUNNER_TEMP` "is emptied at the beginning and end of each job" (GitHub's contexts reference, `runner.temp`, read in a scratch copy, Doc), and the job runs on a hosted `ubuntu-24.04` runner. A kept file therefore lets no later run retry (Inf); what the fix gives is the step's failure, hence `go=no`, and a state file that is not removed while tokens in it may still be live (it holds for the rest of the job only). After a failed revocation, the remaining synthetic tokens stay live in `devos-test` until the owner revokes them; the job's log names each one's role class ("NOT revoked"), not its row. How they are then revoked (by hand from the owner's session, or a job-level rule) is the executor's decision, outside this fix.
2. **The hash in `devos-test`'s Postgres log.** With statement logging on, each revoke statement is logged with the token's hash (run 2). The hash does not authenticate (the verification hashes the token it is given, M09-01 line 133), and `env_tokens` already stores it; but whether `devos-test` logs statements (its `log_statement`) was not read here, and a scan of that log with `scan_patterns.json`'s `long_hex` pattern would find these. The first real run's checker reads it.
3. **Observed in the first run** of the commit that copies the first `.py` file: step `tokens` prints "issued and revoked" for the revoked token; `tokens_revoke` prints "revoked" for every class and does not print "state file is kept"; `go=yes`; and, read as owner or through the read-only connector, `devos-test`'s `env_tokens` has no unrevoked row from that run and the epoch rose by one per token. The runner's psql must support `\getenv` (psql 15 or later), which the file already relied on.
4. **Not shown offline:** the pooler connection and TLS, GitHub's `::add-mask::` handling, and cancellation during `tokens_revoke` itself.

*Filed 2026-10-18 by the executor (L-352):* written by the producer, agent `ae51f46cb41a0d2e3`.
