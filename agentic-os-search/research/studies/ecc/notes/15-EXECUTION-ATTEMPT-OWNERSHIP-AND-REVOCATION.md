# Note15 — Execution-attempt ownership and revocation

**2026-09-18 · U09-A3 / Q04g1b · bounded source inquiry.** Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact evidence and reading scope](../evidence/U09-A3-SOURCES.md), [MR16](../ROUND-U09-A3.md). This extends [Note13](13-RUST-SESSION-LIFECYCLE-FIRST-SLICE.md) and [Note14](14-STORE-OBSERVER-AND-WORKTREE-CONTINUITY.md), not their evidence classes. STATE owns publication/current work.

**No new execution or experiment:** the schedules below are conditional source-derived counterexamples, not E08, observed ECC races, production incidents or independent verification. E07 remains its earlier SQL/Git fixture; historical E06 is excluded. Tokio source is separately pinned to the version declared by ECC's lock, not certified as an installed binary.

## 1. Question and bounded answer

Who owns a particular launched child and its observation tasks? What revokes it, and what stops an obsolete attempt from changing the state of a newer attempt under the same session id?

The examined Rust route has real process supervision, persistence and operator controls, but those controls primarily address a **session**, not a uniquely identified execution attempt. The running capture function owns a child handle and separately spawned observation tasks. SQLite retains a session id, one numeric pid, state, output and timestamps. Stop operates on the fetched pid; resume can reset the same row and launch a new wrapper. The reviewed writes do not carry an attempt generation or reject an old writer because a later attempt has taken over.

This conclusion now rests on actual command/caller, runtime, schema/writer and versioned dependency paths. It is narrower than saying all ECC execution is unsafe or no other component can provide stronger controls. It also does not deny the useful protections already present: non-Pending launch refusal, sequential state-transition validation, process signals, normal-runner detachment, acknowledged database operations and restart reconciliation.

The important distinction is not only whether a state transition is legal. It is **whose execution that transition describes**. A legal Running→Completed transition may still be stale when it comes from a previous attempt.

## 2. Ownership map: two launch topologies, several lifetimes

| Surface | Ordinary CLI start/resume | Delayed worktree activation | What its identity establishes |
|---|---|---|---|
| Initiator | CLI command creates/reuses the row and spawns an ECC wrapper | Daemon or TUI activates a stored worktree request | An initiating caller, not accepted task completion |
| ECC execution owner | Separate wrapper, deliberately detached from the initiating shell/session | Tokio task in the activating process; its JoinHandle is discarded | Different supervisor lifetimes despite the same row shape |
| Harness child | capture_command_output owns Child while its future is alive | The same capture function inside the activating runtime | A process handle for that invocation, not durable ownership after restart |
| Durable state | Session id, state, one pid, working directory, profile and output | Same store surfaces | Recoverable session information, not a stored capture-task handle or attempt lease |
| Observation | Dedicated DB-writer thread, heartbeat and two stream tasks | Same structure within the activating process | Several tasks can outlive or fail separately from one another |
| Operator view | TUI polls the database | TUI can also be the activating controller | A derived view and effectful controller, not a universal supervisor |

Sources: S186–S190, S195–S199; exact retained/new coverage in the ledger. The ordinary wrapper's pid is checked after spawn but is not stored as the session pid; the harness child supplies the later pid write. Both daemon and dashboard delayed-activation callers are real, not inferred from similarly named files.

A global claim that closing the dashboard always kills, or always preserves, every ECC worker would ignore these different topologies. The relevant question is which process owns the capture future for this launch.

## 3. What the exact dependency contributes

S201 Cargo.lock resolves Tokio 1.53.1. Its tag resolves to `tokio-rs/tokio@75fef53d0a8590c2d1dbb63672aa7b7d1ef51155` (S202). The selected tagged process implementation sets Command.kill_on_drop to false by default, copies it into ChildDropGuard and invokes kill from that guard's destructor only when the flag is true (S203).

The complete ECC command builders examined in Note13 do not enable that option. Their configuration can change the executable, arguments and environment, but the reviewed Rust builder path still has the default handle-drop policy. This does not constrain an external program from implementing its own lifecycle controls.

Three cases must remain distinct:

- **Dropping a Child handle:** not an implicit kill under this default contract. Closing pipes, a harness's own behavior, OS signals or an external supervisor may nevertheless cause termination; survival was not observed here.
- **Dropping a JoinHandle:** detaches the Tokio task rather than aborting it; the task can continue while its runtime is alive (S204).
- **Shutting down the runtime:** spawned asynchronous tasks are not guaranteed to finish and are dropped after yielding; bound I/O ceases to function (S205). This is not the same event as merely discarding a handle.

The dependency result is version-bound source/contract evidence. The registry crate was not downloaded and matched to the lock checksum, nor was a locked ECC build inspected. It closes the source-level ambiguity about default cancellation behavior without fabricating a host experiment.

## 4. Admission: a Pending check is useful, but not an attempt claim

S187 run_session opens the store, resolves the session, and returns without launching unless the observed state is Pending. Only afterward does it build the command and call capture_command_output. That is a genuine guard: a worker that observes Stopped at this point does not launch through this function.

However, the check does not reserve the row or install an owner before child creation. S188 spawns first, then asynchronously records pid and Running. S190's session schema and invoked writers do not supply an expected-attempt predicate. Two independently admitted callers can therefore both read Pending before either records Running. The transition validator even permits Running→Running. In that conditional schedule, the code does not itself distinguish the resulting writers merely because each passed its earlier state check.

This is not a claim that every concurrent activation starts two children. A worktree already attached, a nonempty pid or a non-Pending state can stop the queue path, and Git worktree/branch creation has its own failure barriers. Those controls must not be erased to manufacture a simpler counterexample. The narrower point is that the run_session admission itself is not a durable exclusive claim across all same-id callers.

## 5. Stop-before-pid: the temporal position of the guard matters

Compare two source-derived schedules, with successful store operations and no other intervening writer:

**Control:** Stop writes Stopped before run_session reads the row. The initial Pending check refuses launch.

**Counterpath:** run_session first reads Pending. Before the harness pid is recorded, Stop reads pid=None and writes Stopped. The worker then spawns a child, records its pid and tries to write Running. The sequential transition guard rejects Stopped→Running. The runtime exits its inner future with an error and attempts to clear pid and write Failed. If Stopped is still current, that Failed transition is rejected too.

The state guard thus does useful work; it is incorrect to say the worker necessarily overwrites Stopped. But the side effect has already crossed a different boundary: the child was spawned before the refused transition. The general post-spawn error branch does not kill that child. Under S203's default policy, dropping the handle is not an explicit revocation. This leaves a source-level gap between refusing a state transition and undoing the already-issued process action.

No orphan or continued harmful action was reproduced. A particular harness may exit when its pipes close or for another reason. The bounded finding is that this path does not establish termination as the consequence of refusing Running.

When a pid is available, Stop sends signals to the stored numeric pid, then changes the record. On Unix it uses SIGTERM, a fixed pause and SIGKILL; Windows uses taskkill /T /F. Neither the stored pid nor the return from this helper is an attempt-specific acknowledgment from the wrapper. PID reuse and full process-tree behavior remain separate, unexecuted platform questions.

## 6. Post-spawn failure and cancellation are not one cleanup path

The manager's initial store-open or program-selection error can prevent launch. The narrower failure window begins after that earlier admission succeeds: capture starts a separate DB-writer thread, spawns the child, and only then awaits the writer's pid/state/heartbeat operations. The second connection or a later operation can fail even though the manager's earlier store access succeeded.

On an inner error, the Child has left scope before the outer best-effort record cleanup executes. That cleanup has only the writer: update_pid(None), then update_state(Failed). It has no child handle with which to kill/wait. The missing-stdout/missing-stderr branches do explicitly kill and wait, so cleanup is not absent everywhere; it is selective and does not cover every later question-mark return.

The record cleanup is also not an asynchronous destructor. If the containing future is cancelled while waiting, code after its inner await is not guaranteed to run as though the operation had returned Err. Runtime shutdown therefore cannot be equated with the ordinary error branch or with a persisted Failed record.

Database acknowledgment has a further boundary. After a message was sent, abandoning its oneshot reply receiver does not reverse the writer's operation: run_db_writer applies the method before attempting to send the acknowledgment, and ignores failure to send that reply. A revoked waiter is not automatically a revoked write. This is source ordering, not an observed post-cancellation write count.

## 7. Observation tasks can fail independently of the child

Normal completion has a sensible sequence: wait for child exit, stop and await the heartbeat task, await both stream tasks, clear pid and record a terminal state. That sequence is stronger than treating spawn as completion.

The failure paths do not have the same ordering. A stream task can stop on a database append error, but its result is not inspected by capture until after child.wait returns. During a continuing child's execution, the separate heartbeat task can still successfully update timestamps even though one output stream is no longer being captured. A fresh heartbeat is therefore not a health certificate for the whole observation path.

If child.wait errors after the observation tasks were spawned, the normal heartbeat abort is bypassed. Dropped task handles do not by themselves abort those tasks while the hosting runtime remains alive. If the stdout join reports an error, the later stderr join is skipped; the heartbeat was already stopped in that branch. These are different failure windows, not a blanket statement that every error leaks every task.

No live wait error, writer error, output stall or surviving task was executed here. The purpose of the trace is to identify which owners and outcomes are actually coupled, and which are only joined on the normal path.

## 8. Same-id resume: a sequentially legal stale finalizer

S187 resume rejects Completed and Running. It does not similarly reject Pending, Idle or Stale; it resets the resolved row to Pending/pid=None and launches a fresh wrapper. It does not first terminate an old pid in those accepted states. S199 resume_selected simply invokes that manager method using the selected complete id; it adds no attempt or liveness gate.

Stale is especially material because the default overdue-heartbeat policy can mark a session stale without terminating its process. The following is consequently a source-grounded conditional schedule, not an assumption that Stale necessarily means dead:

1. Old attempt A is still alive while its row is Stale.
2. Resume resets that row and starts B under the same id.
3. B records pid_B and Running.
4. A finishes later. Its existing writer clears the row's pid and requests Completed or Failed.
5. The current row is Running, so the state transition can be valid even though the result came from A.

This is not merely Note14/E07's read-check-write interleaving. The finalizer can be stale even if each of its operations runs sequentially and checks the current state correctly. An expected-state-only check would not necessarily distinguish A from B when both concern a Running session. That observation is a boundary on the claim, not an adopted patch design.

The positive control remains: if the row stays Stopped and is not reset, the ordinary terminal-state guard rejects that late Completed/Failed transition. But pid updates, output appends and heartbeat writes do not use that same state-transition predicate. One protected field does not revoke every effect of an obsolete writer.

The source therefore supports session identity reuse, not exclusive handover of a uniquely identified execution attempt. Native context restoration, useful-work preservation and authorization for external effects remain different questions.

## 9. Delayed activation and restart do not recover ownership automatically

The production delayed-activation callback schedules run_session, discards its JoinHandle and returns Ok. The surrounding helper can then dequeue the request and include the session in its started list before the task's actual outcome is available. The inspected target test's injected callback and expected Pending row are consistent with that limited contract, not evidence of a ready worker.

Errors before capture, such as program selection after the row was admitted, are logged by the spawned closure. They do not use capture's record-cleanup branch. A Pending row with an attached worktree and no remaining queue request is therefore a possible source outcome, not an automatically retried work item. Initial daemon reconciliation and ordinary heartbeat enforcement do not select Pending for their recovery actions.

The TUI and daemon are actual activators. For a TUI-owned activation, quitting its application can shut down the runtime hosting capture; for the ordinary detached wrapper route, quitting that unrelated TUI does not itself dispose of the wrapper's capture future. No external process monitor is demonstrated by the shared database row.

Daemon startup reconciliation inspects Running rows and numeric-pid liveness. It can classify a missing process as Failed or keep an apparently live one Running, but does not recover the original Child handle or reattach output/heartbeat tasks. A surviving process and a recovered supervisor are therefore separate states. Its platform limits and optional overdue-session termination remain as recorded in Note13; no Windows or shutdown incident was run.

## 10. Bounded closure and retained obligations

The original U09-A source return condition was a coherent command-to-session/process lifecycle and an important restart/failure contrast, with exact sources and open dependencies. Across the three notes, that source condition is now met:

| Obligation | Actual result |
|---|---|
| Normal command, configuration, record, worktree/queue and launch | Note13; actual CLI, manager and runtime, not README alone |
| Stored output and operator consumer | Note14; SQLite retention, cache/render route and effectful TUI |
| Stop/resume and resource continuity | Notes13–14; retaining pause versus cleanup and bounded E07 command semantics |
| Attempt ownership, error/cancellation, stale writer and restart counterpart | This note; actual schema/writers, two activators, version-bound Tokio source and conditional schedules |
| Evidence limits and countercases | Real guards and benign uses preserved; source schedules, lower-level E07 and unexecuted host claims kept distinct |

U09-A may close as a **bounded source study**, not as certified process safety, correct native resumption, an exhaustive Rust-controller audit or completion of ECC. The question is answered by explaining the actual guarantees and missing bindings, not by requiring the target to satisfy every stronger guarantee.

Keep a separate open residual for runtime/OS/host and competing-operator validation, registry-crate/build correspondence, custom supervisors, native-context restoration and any proposed corrective implementation. Reopen before relying on those stronger claims. No source-derived counterexample is silently upgraded into an empirically observed failure, and no remediation is adopted.

The next selected family is Q04g2 / U09-B: the Node control-pane's actual data/action relationship to Rust and other stores. Its own server/state/actions/message consumers must be read before calling it one unified controller. Broader evaluation, workflows/hosts, release/observability, native syntheses and final omission checks remain open. Joint whole-study evaluation with Batu still follows completed ECC research.
