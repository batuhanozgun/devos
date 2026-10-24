# Note20 — Scheduled-work admission, timing and retry

**2026-09-19 · U11-B / Q04e1 · bounded source answer.** Fixed target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Source ledger](../evidence/U11-B-SOURCES.md), [MR21](../ROUND-U11-B.md), [STATE](../STATE.md). No new target execution, test, live schedule, model/provider or E09. Conditional source scenarios below are not observed production incidents.

## 1. What the scheduled-work mechanism does

The Rust scheduler stores recurring launch instructions, selects due rows and feeds them into the existing session admission path. After that path returns a session id, it computes another due time and records the dispatch timestamp. It is not a scheduler that waits for accepted task results before recording an occurrence as handled.

The implemented chain is:

`CLI add → stored schedule → daemon or CLI run-due → due-row snapshot → session/worktree admission → next-time calculation → schedule update → returned outcome`.

The existing lifecycle then determines whether that Pending session obtains a worktree, starts a runner, runs a harness and eventually changes state. Notes13–15 remain the scoped source explanation for that later lifecycle; their stronger runtime claims are not resolved here.

The central distinction is between a recurring instruction, a particular due occurrence, a session record, a spawned wrapper and a completed/accepted task. The examined path does not give all five the same persistent identity. Sources: U11B-C/M/S/D.

## 2. Creation validates a future time, not a frozen execution environment

The Add command selects the explicit agent or configured default, resolves the worktree preference and sends grouping/profile inputs to create_scheduled_task. Manager captures the caller's current working directory, normalizes labels, canonicalizes the agent and validates an explicitly named profile. It calculates a future occurrence before inserting the row. An invalid expression or one that has no future date at creation is rejected rather than silently inserted by this normal caller.

The stored row contains the cron expression, task text, agent, optional profile name, directory, project/task group, worktree flag and timing fields. It does not store a resolved profile snapshot. At dispatch, resolve_launch_profile resolves the saved name again, or uses the dispatcher's default profile when the schedule has no explicit name. The resulting session profile is then persisted separately for that session.

Thus the same stored schedule can use different effective settings when a later invocation loads changed configuration. Conversely, a daemon receives its Config once and retains it across its loop; changing a config file does not establish immediate reload in that already-running process. A saved path is also not an immutable repository revision or guaranteed available environment. These are configuration/lifecycle semantics, not automatic defects: named reusable profiles can be intentional. What is not established is frozen execution equivalence merely from schedule identity. Sources: U11B-C/M/S.

## 3. Due time, polling time and catch-up policy

The parser accepts five, six or seven fields. Five-field input receives a zero seconds field; parsing and next occurrence use UTC. There is no per-schedule local timezone field in the examined schema.

run_due_schedules_with_runner_program captures one now value, selects all its due rows up to the limit, and uses that same value for every row's last_run_at and next-occurrence calculation. Due selection is ordered by next_run_at and then id. The next time is calculated after the pass's now, not after the old next_run_at and not after task completion.

For example, if several recurring times elapsed while no dispatcher ran, the code launches once for that selected schedule and seeks a future time after the present pass. It does not enumerate one launch for each missed time. This is a coalescing consequence of the source ordering, not evidence that the author promised catch-up and failed to implement it. If the pass itself takes long enough, its calculated next time can already be past by the time it is stored.

The daemon awaits session checks, scheduled dispatch, remote dispatch, backlog coordination, worktree merge/prune and pending-worktree activation, then sleeps for heartbeat_interval_secs. That interval is a pause after the cycle, not a bound on how promptly every cron occurrence starts. CLI run-due provides a separate explicit dispatch entry. Source: U11B-D/M/C; cron dependency scope in W-U11B-CRON.

## 4. Batch size is not a global concurrency reservation

The daemon supplies cfg.max_parallel_sessions as the due-query limit. The CLI instead has its own per-pass limit, default10, explicitly described as maximum due schedules to dispatch in one pass. The due SQL uses LIMIT; it does not subtract already-live sessions.

The followed queue/build chain likewise does not compare the number of current Pending/Running sessions with max_parallel_sessions before admitting a scheduled occurrence. Nor does it check that the same schedule's previous session has finished. A batch bound and a global simultaneous-work bound are therefore different guarantees. This finding is confined to the actual scheduled-admission chain, not every other ECC controller. For example, other template/delegation paths have their own capacity logic; their existence does not insert a missing predicate into this path.

There is a distinct worktree control. If a worktree was requested and attached-worktree capacity is exhausted, the system can insert a Pending session, enqueue its worktree request and return Ok(session_id). No runner has started on that branch. With capacity, it creates the worktree and starts a wrapper; wrapper admission checks that spawn returned a PID, without waiting for the harness to become ready.

Consequently, a schedule can advance while its admitted work is still waiting for an environment. Repeated occurrences can also create additional Pending records while an earlier one remains queued. The queue is a real retention mechanism, but its presence is not per-schedule non-overlap, exactly-once firing or proof that work ran. Sources: U11B-D/C/M/S.

## 5. Launch and schedule advancement are separate effects

The key ordering is explicit:

1. Read the due schedule snapshot.
2. Queue/create the session and, on the immediate branch, spawn its wrapper.
3. Calculate the next occurrence from the captured pass time.
4. Update last_run_at and next_run_at by schedule id.
5. Add the schedule/session association to the returned outcome vector.

The session insertion, profile/queue persistence, OS spawn and schedule update are not one transaction in this caller. record_scheduled_task_run updates by id only, without an expected old due time, owner token or claim state. It also ignores the number of affected rows.

This produces distinct conditional cases:

| Boundary | Source-grounded consequence |
|---|---|
| Queue admission fails before returning an id | The schedule is not advanced; depending on the failure point, session/worktree side effects may already exist |
| Queue returns, then next-time calculation or schedule update fails | Work may be admitted or a wrapper spawned while the schedule remains due; a later pass can create another session |
| Schedule advancement succeeds, then the harness fails later | The due row has already moved on; that later failure is not converted here into an occurrence-specific retry |
| Earlier rows succeed, a later row fails | Earlier effects remain, but the function returns Err rather than its accumulated partial outcome vector |

The causal issue is not merely that an exception can occur. Admission can have effects before the durable record that would stop the old due row from being selected again, and the schema/caller do not bind those effects to an occurrence-specific idempotent claim. A SQLite connection or busy timeout does not itself join the separate selection, launch and acknowledgement steps. These are source-level boundaries, not measured duplicate rates. Sources: U11B-M/S/C/D.

## 6. Finite schedules expose a failure without a database outage

Creation's future-time validation is useful, but it does not settle what happens after the final permitted occurrence. The parser accepts the seven-field form that can restrict the year. The declared cron dependency is0.17.0; its inspected iterator can return no next date after the allowed dates are exhausted. ECC converts that absence into an error.

Consider a finite schedule registered while its final occurrence is still in the future, then selected after that occurrence has become due. If session admission succeeds, the dispatcher has already created/queued work before it discovers that no later occurrence exists. The error exits before record_scheduled_task_run, leaving the schedule's old next_run_at intact. A later pass can select that same row again and repeat admission, unless another condition or an operator prevents it.

This is a conditional, source-derived finite-schedule example, not an executed Rust test. It does not depend on pretending the clock, database or model failed. It follows from requiring another future time after admitting the current work, with no separate exhausted/completed-schedule transition on this path. A row may remain due even while its apparent intended final work was already admitted.

The same question arises after long downtime that carries a previously valid finite schedule beyond its final date. We do not infer exact subsecond, DST or registry-crate behavior beyond the inspected contract. Source: U11B-M/DEP1/DEP2 and W-U11B-CRON.

## 7. Batch failure, competing dispatch and removal

Every queue, next-time and schedule-update operation in the loop uses error propagation. The first failing row stops later rows in that pass. Since due rows are ordered and no per-schedule failure state/backoff is written here, a persistently failing earliest row can keep being selected first and prevent later due schedules from being reached. The daemon does continue other categories of work after logging this pass failure; this is not a claim that the entire daemon stops.

One daemon's loop is sequential, but it is not the only caller: an operator can invoke CLI run-due, and the inspected CLI/daemon entry does not acquire a schedule-dispatch singleton or row claim. If two dispatchers read the same due snapshot before advancement, both can queue separate session ids. The later by-id updates do not reject stale ownership. This is a valid conditional interleaving of the read/effect/write calls, not a concurrently executed incident.

Removal has a similar boundary. Deleting a schedule before a fresh due query excludes it from that query. It does not revoke an already-read snapshot or stop an already-created session. If removal occurs after selection, the dispatcher can still queue the cached task; its subsequent update can affect zero rows yet return Ok. A returned outcome can therefore refer to a schedule that was removed in the interval. This does not mean ordinary removal is ineffective; its guarantee is future row selection, not cancellation of admitted work. Sources: U11B-C/M/S/D.

## 8. What the operator can actually recover

ScheduledRunOutcome contains both schedule_id and session_id, plus task, expression and next time. The CLI prints that vector only when the whole call succeeds. The daemon's wrapper logs its length on success. The examined persistent schedule table records last/next timestamps but not the generated session association, occurrence status, failure reason or accepted result.

The session itself remains available through the existing session records and output system. However, similar task text or grouping labels are not a unique durable occurrence-to-session relation. External logs or a custom caller could retain the returned association; no repository-wide absence of such consumers is claimed. In the built-in path, the label last_run_at should be read as the pass timestamp recorded after admission, not as completed work, actual start time or validated output.

A batch error can also hide already-returnable successes from the ordinary structured response even though their records/effects remain. That is a partial-effect reporting boundary, distinct from rollback. Sources: U11B-C/M/S/D.

## 9. Tests and strength of the answer

The fully inspected scheduling test uses a temporary Git repository and StateStore, inserts a due recurring schedule directly, supplies a fake runner to the real internal dispatch function, then checks one outcome, grouping, last_run_at presence, a later next_run_at and task text in a runner log. This meaningfully targets the normal admission/update chain. It is not a model-quality oracle or proof of real harness readiness, and it does not cover the finite-exhaustion, concurrent-dispatch, batch-starvation or deletion interleavings above.

We inspected that test; we did not execute it. Relevant worktree queue tests were also inspected at their recorded scopes, not rerun. No E09, new fixture, Rust build, process signal, provider/model, installation or live recurring task was created. The whole tests tree, schema migrations, timestamp mapper and all custom controllers were not exhaustively audited.

The original source return condition is met: actual creation, timing, due selection, admission, advancement and operator outcome are explained, with normal controls and material failure/continuation counterparts. Stronger claims remain separate rather than keeping an answered source question open indefinitely. METHOD0.1 remains; PLAN0.22 records the next family. Sources: U11B-T and the complete ledger.

## 10. Reuse, reopening and continuation

Useful candidate distinctions are recurring instruction versus occurrence identity; scheduled time versus dispatch time; admitted work versus live/accepted work; batch limit versus concurrent capacity; queued environment versus started process; next-time calculation versus terminal schedule handling; durable last-run timestamp versus durable result provenance; future removal versus revocation; pass error versus rollback.

Q04e1a has this bounded source answer. Q04e1b keeps exact runtime timing, malformed/migrated records, filesystem/configuration/binary correspondence, multi-dispatch safety, terminal handling, cancellation, backoff/fairness, durable occurrence linkage and actual result acceptance open. These are evidence obligations, not adopted remedies. Findings should be reopened for changed caller/SQL/timing/profile/runner behavior or stronger runtime claims.

After publication, next selected work is U11-C: remote-request intake, routing and result semantics. Follow the actual CLI/server producer, authentication and target binding, persistent request status, targeted assignment versus new-session admission and failure/retry consumer. Entry: main RemoteCommands and run_remote_dispatch_server, manager run_remote_dispatch_requests and store request methods. Do not treat their incidental exposure in this turn as completed research or start a live endpoint. Broader delegation/host/provider/release/audit/observability, native syntheses and final omission work remain. No architecture, adoption or upstream patch follows from this note.
