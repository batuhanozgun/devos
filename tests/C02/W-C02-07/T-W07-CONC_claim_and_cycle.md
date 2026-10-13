# T-W07-CONC · One claim of many concurrent connections; no cycle from hard dependencies added at once

Synthetic test data (plan Section 8 item 13): one Mission under scope `synthetic.w07.conc.r<run id>`, its work items, relations and artifacts `w07_fixture/conc_*`, and session ids `w07_fixture_session_*` are made up and labelled SYNTHETIC W-C02-07. In `devos-test` they are committed, because other connections must see them, and they stay (append-only families). The run prints their number and scope. Every connection issues its own synthetic token inside the database and revokes it before it ends.

**Serves.** W-C02-09 point 8 ("Concurrency (both of its claims, with the connections and repetitions W-C02-07 wrote)"); W-C02-13 point 4; C02 Acceptance's first line; Appendix C "Concurrency"; EV-C02-002 DM-01's confirming test (its four parts and the "failure frequency" of B:442) and DM-06's (the race of a lapsed or revoked claimant's late effect).
**Command.** Staged in `tests/C02/W-C02-07/job/` (phase C5; README 5.1 (c)): W-C02-09 copies each of its files byte for byte into `supabase/migrations/tests/` once the file can pass, and the job runs that copy, under the path named below; the harness runs the staged file. `python3 -I supabase/migrations/tests/w07_conc_claim_and_cycle.py < <the job's JSON object>` from the repository root, run by the migration job's `devos-test` step. Its input is N-255's one JSON object with exactly the keys `endpoint`, `apikey`, `tokens` and `revoked_token`; it uses none of them (it issues its own tokens, README 5.1 (b)), but another form gives COULD NOT CHECK. Its second line declares `# w07-needs-database: yes`, so the job runs it with the step's own libpq connection environment for `devos-test` as `postgres`, never under `env -i` (N-255). On the harness: the same four keys with null values, and the throwaway database's socket as its only libpq environment, with the patches `breaks/B-CONC-1` and `-2` applied one at a time; the program tells that database apart by its setting `w07.throwaway`. **Interface on W-C02-03's job (executor's decision 3; N-255):** the job's `devos-test` step runs this program after the SQL files (it sits under `supabase/migrations/tests/`, class high), passes the libpq environment because of the declaration, and reads exit 0 / 1 / 3. The input form names no target, so that the program never runs in `devos` rests on the job running its programs in the `devos-test` step only (W-C02-03's build). Until it does, the result is COULD NOT CHECK, and Concurrency has no result.
**Time added to W-C02-13's run.** About one minute per run of the program (observed: 54 s on the scratch stub with PostgreSQL 16.15; source: the designer's self-check, 2026-10-12). No schedule or limit is waited on. Each barrier waits at most 60 s, so the worst case is about 70 minutes, if every barrier times out.
**Interface assumed.** README section 8.1 (the assumed interface, version 1, phase C) holds for this test; where anything here differs from it, section 8.1 holds. The Group A common interface v1 as `T-W07-F01` states it: `issue_env_token`, `revoke_env_token`, the fixture functions, `devos_api.claim(uuid, text)`, `devos_api.relate(jsonb)`, `devos_api.revoke_claim(uuid, text)`, `devos_api.register_artifact(text, jsonb)`, the return form `{status, reason_code}`. Also owner reads of `devos_private.assignment (work_ref, status)`, `devos_private.relation (from_ref, to_ref, hard)` and `devos_private.env_tokens (issued_at, revoked_at)`. The program takes its helper functions from `supabase/migrations/tests/w07_f01_whole_intent.sql`, so the two cannot drift.


**Phase C, the executor's decision (Group A's open 2).** The runner may commit labelled synthetic fixtures in `devos-test`, among them an owner-planted synthetic Decision of class `batu`, and lists them in its output; EV-C02-002 DM-23 forbids them only in `devos`. It runs as `supabase/migrations/tests/w07_conc_claim_and_cycle.py` with the job's one JSON input (target `devos-test`) and the step's own libpq environment (README 5.1 (b); N-255).


**Phase C self-check (never a result).** On Group A's scratch stub with `revoke_env_token` by row ID (README section 8.1), PostgreSQL 16.15: unpatched PASS (8/8) in 23 s, `CONC-tokens` 0 unrevoked; with `B-CONC-2` the red cases were exactly `CONC-cyc2` and `CONC-cyc4` and the run ended in FAIL, in 24 s. B-CONC-2's break is thus shown as a self-check on 16.15; it counts only when the harness shows it on PostgreSQL 17.

## Cases (numbers fixed before any run)
| Case | What | Expected |
|---|---|---|
| CONC-claim | 20 runs; in each, 8 connections claim one fresh work item, released together from one barrier | in every run exactly one `ok`, the others `refused`, and exactly one Assignment for the work item |
| CONC-pos | the same runs | at least one claim succeeds in every run (no deadlock, not everyone refused) |
| CONC-overlap | the same runs | every run shows all 8 connections waiting at the barrier, and at least two transactions overlapping in time (server clock); otherwise "could not check" |
| CONC-cyc2 | 20 runs; two connections add A→B and B→A (hard) at once | exactly one accepted; fewer than 2 hard edges between them |
| CONC-cyc4 | 20 runs; four connections add A→B, B→C, C→D and D→A at once | exactly three accepted; fewer than 4 hard edges (no cycle of four) |
| CONC-late | 10 runs; a claimant's effect, `revoke_claim` (audit token) and a new hard dependency on the same work item, released together | no accepted effect that began after a committed revocation or dependency; every connection answered |
| CONC-err | every run | no raised error at all; deadlocks (40P01), serialization failures (40001), lock timeouts (55P03) and cancels (57014) counted by SQLSTATE: the failure frequency DM-01 names |
| CONC-tokens | after the runs | no synthetic token of this run left unrevoked |

## Form C0
| Field | Content |
|---|---|
| **ID and claim** | `T-W07-CONC`: "Of several connections that request the same work item at the same time, only one claims it; when two opposing hard dependencies are added at the same time, no cycle forms" (Appendix C), with one claim always succeeding. |
| **Failure class rule** | Any interleaving of concurrent transactions that lets the database hold a state that no serial order of the same calls would allow: two active claims of one work item, a cycle of hard dependencies, or an effect of a claim already revoked or blocked. Also any interleaving that makes every caller fail (deadlock, mass refusal). **[Designer's addition: Appendix C gives Concurrency no class rule (R2 section 5 (c)).]** |
| **Examples** | The original claim, several connections claiming one work item (CONC-claim). Other manifestations: two opposing edges (CONC-cyc2); a cycle of four closed by two pairs of edges that share no end, which locking the edge's two ends would miss (CONC-cyc4, EV-C02-002 DM-01 (b)); a late effect racing a revocation and a new dependency (CONC-late). **[Designer's addition: no examples in Appendix C.]** |
| **Negative control** | A second claim, a cycle, or a late effect accepted after the revocation committed is `bad`, in any run. **[Designer's addition: Appendix C gives no explicit negative.]** |
| **Positive control** | Appendix C: "One claim always succeeds (the system does not deadlock and reject everyone)": CONC-pos. CONC-cyc4's three accepted edges show the check refuses only the closing one. |
| **Break attempt** | **[Designer's addition: Appendix C gives no break.]** (1) `breaks/B-CONC-1_claim_lock_and_index_removed.sql` removes claim's row lock and the partial unique index of one active claim. It re-creates the build's claim functions from their own source without `for update`. CONC-claim must turn red in at least one of the 20 runs (W-C02-13 point 4). (2) `breaks/B-CONC-2_dependency_queue_removed.sql` removes the one queue for hard-dependency writes (exclusive advisory lock made shared) and the relation path's row locks. CONC-cyc2 and CONC-cyc4 must turn red. Both are run by the harness against the throwaway database with this program. Designer's self-check, never a result, on PostgreSQL 16.15 against a scratch stub: unpatched PASS (8/8); B-CONC-1 turned exactly CONC-claim red (8 claims in a run). The self-check of B-CONC-2 did not finish within its 140-second limit and is **not shown**. |
| **Stage and environment** | C02. `devos-test`, through the migration job's step: several direct connections, transport `sql-set-role` (role `anon`, header simulated). The throwaway PostgreSQL 17 database for the breaks. Never `devos`. GROUPS.md and README list Concurrency under the Data API path (README 5.1 (b)). The program uses direct connections instead, because the claim under test is the database's locking, and an HTTP client would have to hold the synthetic token in memory and send it in a header while revoking it by value in a statement. The Data API's own connection pooling is not tested ("Not covered"). The migration job runs a file of this test only once W-C02-09 has copied it (README 5.1 (c); phase C5). |
| **Independence level** | Written by the test designer (fresh-context `test-designer` subagent; agent ID in W-C02-07's Record). Run by the migration job, by W-C02-09's producer at its head, and by W-C02-13's prober with both breaks. Assessed by a fresh-context checker that wrote no test. Shared: model lineage and the design records. |
| **Evidence layer** | Behavioural, of the database under concurrent load, and structural (the final rows). It does not show behaviour at load levels above 8 connections, or through PostgREST's pool. Timing-dependent faults that 20 runs do not hit are not shown either. |
| **Evidence envelope** | README section 4. Fixed before the run: 8 connections; 20, 20, 20 and 10 runs; the expected outcomes above; PASS at 8/8; the breaks' red cases. `transport`: `sql-set-role` (several connections) or `throwaway`. Observation: the job's run and step, or the harness output with the patch name; the program's output lists the fixtures it left. Raw evidence `W07-CONC-<run_at>`. |

## Clause table
| Clause of Appendix C "Concurrency" (verbatim) | Case ID(s) | Or: moved to |
|---|---|---|
| "Claim: Of several connections that request the same work item at the same time, only one claims it" | CONC-claim, CONC-overlap | — |
| "when two opposing hard dependencies are added at the same time, no cycle forms" | CONC-cyc2, CONC-cyc4 | — |
| "Method: Many concurrent connections on real PostgreSQL; repeated runs" | 8 connections; 20, 20, 20 and 10 runs; CONC-overlap | — |
| "Positive: One claim always succeeds (the system does not deadlock and reject everyone)" | CONC-pos, CONC-err | — |

## Format gate
Not a format-gate test.

## Could not check
The program exits 3 (COULD NOT CHECK):
- when there is no input on standard input, or its keys are not exactly N-255's four;
- when no database connection settings (libpq environment) are given, or `psql` is not on the path;
- when the database says `w07.throwaway` is `yes` while a role `supabase_admin` exists;
- when a needed function is absent;
- when the fixtures cannot be written;
- when overlap is not shown in a run, or a token is left unrevoked;
- when the program itself fails.

Self-check: run without a connection, it printed `T-W07-CONC COULD NOT CHECK (...)` and exited 3.

## Not covered
- The Data API's pooling and HTTP concurrency.
- More than 8 connections.
- Expiry racing a new claim with real time passing (planted elsewhere: T-W07-F08, T-W07-DM07).
- `devos`.
