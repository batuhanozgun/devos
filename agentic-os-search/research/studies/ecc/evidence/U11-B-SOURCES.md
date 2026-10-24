# U11-B — Scheduled-work admission source ledger

**2026-09-19 · Q04e1 · SOURCE INQUIRY, no new execution.** Target remains [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). [Note20](../notes/20-SCHEDULED-WORK-ADMISSION-AND-RETRY.md), [MR21](../ROUND-U11-B.md), [STATE](../STATE.md). No Rust build, target test, database probe, process launch, provider/model, live recurring task or E09 occurred.

## Exact sources and coverage

Existing S186/S187/S189/S190 identifiers are retained. Unit-local labels below are retrieval handles, not new independent copies. All ECC bodies were fetched through connected GitHub at the fixed pin. SELECTED ranges include incidental material and do not establish whole-file or whole-family coverage. An inspected test is not an executed test.

| Handle | Path at fixed pin | Git blob | Load-bearing reading |
|---|---|---|---|
| U11B-D / S189 | ecc2/src/session/daemon.rs | e62ea0ae88d71027b1627d916b3d8e6d32b37cf4 | 1–365; complete run, startup reconciliation, check_sessions and maybe_run_due_schedules. Remote/backlog functions also exposed, not their whole research closure |
| U11B-M / S187 | ecc2/src/session/manager.rs | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | Complete run_due_schedules_with_runner_program at118–157; schedule create/list/delete within1–270; public run_due_schedules within440–535; parse_cron_schedule/next_schedule_run_at and run_session within2210–2460; full queue/profile/build/spawn chains across2450–3180; ScheduledRunOutcome within3670–3900 |
| U11B-S / S190 | ecc2/src/session/store.rs | f71bb3640991f9d471e2ab98dad54dff4d346721 | 185–460 schema/open excerpt; 1150–1780 includes full session/profile/queue and scheduled-task insert/list/due/get/delete/advance methods. Scheduled schema and actual SQL, not an exhaustive migration/helper/test audit |
| U11B-C / S186 | ecc2/src/main.rs | 7c516684c178d050bc36d96d0481f812e9c48c07 | Complete ScheduleCommands enum within490–680; Config/load/store entry within1430–1680; full Schedule match within2590–2738; Daemon/RunSession arms within2710–3010 |
| U11B-T / S187 | ecc2/src/session/manager.rs tests | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | Full run_due_schedules_dispatches_due_tasks_and_advances_next_run in5200–5425; build_config within4240–4540; selected worktree-limit test within5420–5700. NOT RUN; fake runner, not full native evaluator |
| U11B-DEP1 | ecc2/Cargo.toml | 1995913c78282b08ccc7b4940b22e522c6e9cb41 | FULL; cron0.17 dependency and Rust package boundary |
| U11B-DEP2 | ecc2/Cargo.lock | ab4d168cc80acfda87595572883bef04f0290194 | SELECTED260–405; cron0.17.0 and declared registry checksum a5dcd6f69605c2956916ce24e8af637b754964c9a83f4662d3a2361654cdba09 |

Pinned entry links: [manager](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/manager.rs), [store](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/store.rs), [main](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/main.rs), [daemon](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/daemon.rs).

### Acquisition accounting beyond the load-bearing excerpts

Manager completed bounded requests were1–270,270–440,440–535,530–880,880–1125,1180–1495,1650–2110,2210–2460,2450–2610,2600–3000,3000–3180,3300–3680,3670–3900,3900–4240,4240–4540,5200–5425 and5420–5700. Much of this was incidental remote/template/backlog/merge/profile/display material encountered while locating functions. These bodies are not automatically additional completed research units. Requests4540–12000 and6000–6420 were display-truncated; only visible excerpts and later recovered specific functions count as read. Response searches located the scheduling test and fake-runner helper; they are not full-body substitutes. The fake-runner helper was only located/partially exposed, not fully audited.

Main completed requests were490–680,850–1040,1200–1430,1430–1680,1840–2130,2280–2540,2590–2738 and2710–3010. Graph, migration, remote and coordination sections were incidental to locating the actual schedule arm. Store ranges above were read, but map_scheduled_task and the complete migration/test corpus were not independently closed in this unit. Valid native-created schedule records are the core input domain; arbitrary malformed/migrated timestamp behavior remains a residual.

No source file was marked FULL merely because a broad response was requested. Exact future entry coordinates are now known: manager118–157 and2210–2800, store1494–1615, main513–562 and2654–2732, scheduling test approximately5320–5370. Use symbols as well as ranges; file revisions can shift them.

## Producer/consumer closure

**Creation:** CLI Add selects agent/worktree settings and passes explicit grouping/profile to manager. Manager captures current directory, normalizes labels, canonicalizes the agent, validates an explicit profile and computes a future cron time before insertion. The row stores the profile name and path, not a frozen profile or environment. Dispatch resolves the name/default using its current Config. An already-running daemon retains the Config supplied to run; new CLI/daemon invocations can load another configuration.

**Timing:** five-field expressions receive a leading zero seconds field; six/seven fields reach cron parsing. Both creation and dispatch use UTC. Due SQL selects next_run_at<=captured now, ordered by next_run_at/id with LIMIT. Manager computes one next occurrence after the dispatch pass's captured time, not after the previously due occurrence. This does not enumerate every missed firing. The daemon awaits multiple passes before sleeping; heartbeat_interval is not an exact schedule latency guarantee.

**Admission:** the due-row query is a read, not a claim. Its limit is a batch bound. The queue chain does not subtract live sessions from max_parallel_sessions or block a new occurrence because the previous one remains active. Worktree capacity is a separate condition: at capacity a Pending session can be stored and queued with Ok(session_id), without launching a child. Otherwise the wrapper spawn checks a PID, not readiness or task acceptance.

**Advance and association:** after queue returns, manager computes next_run_at and updates the schedule by id. Session creation and schedule update are not coupled in this caller by one transaction. The update has no expected-old-due/owner condition and ignores zero affected rows. ScheduledRunOutcome carries schedule_id/session_id only in the returned vector; the examined schedule schema/writer does not persist that association or a per-occurrence outcome/error ledger. No universal absence of external logging/custom consumers is claimed.

**Failure and continuation:** a ? at queue, next-time calculation or schedule update aborts the batch; earlier effects/advances remain, while the caller receives no partial outcome vector. The daemon logs the pass error and continues other passes before retrying later. A persistently failing earliest due row can prevent later due rows from being reached. A finite schedule with no future occurrence can queue work and then error before advancement, leaving the old row due. Competing snapshot readers or deletion after selection introduce separate source-derived duplicate/revocation boundaries. No actual race, outage or production incident was executed.

**Positive scope:** invalid/no-future cron is rejected during normal creation; valid successful advancement moves the row out of the old due set; row deletion prevents subsequent fresh selection; worktree queueing preserves a pending request rather than claiming a created worktree; daemon pass errors are surfaced. These are useful controls, not exactly-once execution or completed-task acceptance.

## Dependency contract

**W-U11B-CRON**, primary library documentation inspected2026-09-19: [Schedule](https://docs.rs/cron/latest/cron/struct.Schedule.html) and [schedule.rs source](https://docs.rs/cron/latest/src/cron/schedule.rs.html), displaying cron0.17.0. Selected source includes next_after35–145, after302–307 and ScheduleIterator434–474: enumeration over allowed times can end without a future date and the iterator returns None. The /latest route was usable while several explicit-version/source URLs failed; this is an observed version-labelled page, not an immutable downloaded crate. Exact registry bytes and installed/built-binary correspondence were not verified. Query-helper access also failed; no subsecond-boundary or daylight-saving guarantee is derived from it. ECC's use of UTC and its own after(...).next() error conversion are directly read from pinned code.

A finite-date counterexample is conditional source reasoning: a schedule registered while it has a future permitted occurrence, then dispatched after its final occurrence, can reach successful queueing before the no-future error. This does not require a database fault. It is not an E09 experiment or evidence of a measured rate.

## Tests, limits and next work

The inspected scheduling test creates a temporary repository/store, directly inserts a due */15 schedule, invokes the internal dispatcher with a fake runner, checks grouping and one returned outcome, last_run_at presence, next_run_at>the old due time and task text in the runner log. It does not test finite exhaustion, successful real-harness readiness, failed later rows, competing dispatchers, cancellation or a persisted per-occurrence result. We did not run it. Test discovery was bounded, not proof that no additional tests exist.

An auxiliary raw-file attempt failed DNS; no verified checkout was obtained. Connected source reads/writes worked. E08 was not rerun; E06 remains excluded; older experiments are not this unit's evidence. Findings concern the pinned scheduler and actual callers, not every ECC, OS scheduler or custom consumer.

The bounded source return condition can close with these actual producer/consumer and failure paths. Stronger runtime, concurrency, cancellation, durable provenance, exact timing and acceptance remain open. Next selected research after publication: U11-C remote-request intake/routing/result semantics, starting from main RemoteCommands/actual server, manager run_remote_dispatch_requests and store request methods. Their incidental exposure here is not completion or permission to create a live endpoint.
