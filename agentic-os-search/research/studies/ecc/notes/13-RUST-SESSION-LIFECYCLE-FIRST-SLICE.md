# Note13 — Rust session lifecycle: first source slice

**2026-09-18 · U09-A / Q04g1 · SOURCE CHECKPOINT, unit PARTIAL.**

Target: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Source ledger S185–S196](../evidence/U09-A-SOURCES.md) owns exact paths, Git blobs and read ranges. [ROUND-U09-A / MR14](../ROUND-U09-A.md) owns the method decision; [STATE](../STATE.md) owns current work/publication. No target execution, new experiment or independently verified result is claimed. This is an ECC-native explanation, not adopted SOUL/Development OS architecture.

## 1. Question and present answer

Q04g1 asks how a command and stored session become a running, stopped or resumed process, what survives interruption, and which observation justifies a transition.

The selected source already shows a real multi-stage mechanism: CLI dispatch, configuration, stored Pending session, optional worktree queue, an ECC runner, harness child, database writer, output capture and daemon checks. These stages do not have the same success predicate. A returned identifier does not certify a ready harness; a timer heartbeat does not certify useful progress; process exit success does not certify the requested work; an ECC resume does not itself establish restored model conversation; startup reconciliation is not automatic relaunch.

This first slice explains those distinctions and two important failure routes. It does **not** close all store lookup/output/board, worktree helper, observer, cancellation and concurrency dependencies. U09-A's return condition remains open, rather than being lowered to match this checkpoint. The README's alpha declaration is context, not evidence that the entire runtime works or fails.

## 2. Command → record → runner: what “started” currently means

**Observed source, S186/S187/S190/S191/S195.** Main loads configuration and opens a StateStore before dispatch. Start resolves the worktree policy, optional source-session grouping and agent/profile inputs, then calls manager creation. Manager resolves the current directory, profile precedence and requested harness and builds a session record with Pending, no pid, initial timestamps, task/grouping and working directory. It inserts the row and separately persists a selected profile.

The queue helper has two materially different returns. With requested worktree capacity unavailable, it stores a pending worktree request and returns the session id **without starting a runner**. Otherwise it creates a runner stderr log and spawns the current ECC executable with hidden run-session arguments: session id, task, agent and working directory. It verifies that this runner exposes a pid, but neither stores that wrapper pid in the session nor waits for a harness-readiness acknowledgment. Main then prints the session-started message.

Thus the UI wording covers both queued work and successful runner-spawn admission. It cannot be read as one universal Running/readiness result. This is not merely a wording issue: different observations happen in different processes and at different times.

There is also a useful positive mechanism. The ordinary CLI runner explicitly detaches on Unix through setsid and uses detached/new-process-group creation flags on Windows. Its stderr is directed into a session-specific file, instead of disappearing with the initiating command's normal output. This is source support for a deliberate caller-lifetime boundary, **not** a live demonstration of survival under every shell/OS interruption.

## 3. Runner → harness → observable lifecycle

**Observed source, S186/S187/S188/S196, with selected S190/S191.** The hidden RunSession arm calls run_session. That function looks up the session and skips it unless the returned state is Pending. It chooses a program, fetches the stored profile and constructs either a built-in harness command or a configured runner command.

capture_command_output creates a dedicated database-writer thread, spawns the harness with piped stdout/stderr, obtains its pid, then awaits three database operations in order: pid, Running state and heartbeat. Only after these operations does it spawn heartbeat and stream-capture tasks. It awaits process exit, stops its heartbeat task, awaits both stream tasks, then clears pid and writes Completed for successful exit or Failed otherwise. On an inner error it attempts pid clearing and Failed as best-effort cleanup.

The database writer's oneshot acknowledgment is a real distinction: senders do not equate sending a message with successful completion of the called store method. capture_stream awaits append_output_line before adding a line to the local output buffer/broadcast. However, the actual append SQL/retention and downstream UI reload are not yet closed in this slice. The acknowledgment must not be promoted to permanent archive completeness, cross-process consumer receipt or semantic acceptance.

S196 is explicitly a process-local Arc/Mutex ring buffer and broadcast channel. Its default retained buffer capacity is 1,000 lines; broadcast-send errors are ignored. A separately launched wrapper constructs its own default output store. This cannot by itself explain what a separate dashboard process sees; persistence and dashboard reload need their own consumer trace. Stored output, local buffer contents and displayed output remain three separate evidence surfaces.

Two inspected runtime tests address local shell output persistence/broadcast and heartbeat updates for a quiet process. Two output tests address ring truncation and in-process broadcast. **None ran in this research turn.** Their existence does not prove real host compatibility, cross-process delivery, task success or failure recovery.

## 4. Heartbeat and terminal state are observations, not task acceptance

**Observed source, S188/S187/S190/S191.** Runtime heartbeat is produced by a periodic task while waiting, including for a process that emits no output. The selected store code also refreshes heartbeat timestamps during several state/pid mutations. Consequently a recent timestamp is not a unique signal of model reasoning, tool progress or achieved work.

Likewise Completed here is derived from a successful child exit after stream tasks return; no goal-specific acceptance test appears in this runtime function. A nonzero exit can produce Failed in the row while capture_command_output still returns Ok(ExitStatus), which run_session does not separately convert into an error. Failure of the work and failure of the wrapper's own execution are therefore not identical signals.

There is an actual transition guard: update_state reads the current state, calls can_transition_to and then writes. In particular Stopped does not normally transition to Completed/Failed through that guard. This is important counterevidence against casually declaring that any late runtime finalizer must overwrite a stop.

The combined update_state_and_pid path, used by resume and daemon recovery, does not call the same validator. This supports deliberate reset/reconciliation transitions but means the transition table is not the sole authority for every mutation. Furthermore the reviewed guard is a read/check followed by an id-based update, not visibly an expected-state compare-and-swap in that function. Full schema and concurrency behavior remain to be checked before a global race/fencing judgment.

## 5. Stop is both a process action and, by default, resource cleanup

**Observed source, S186/S187/S190/S193.** CLI Stop calls stop_session, which selects cleanup_worktree=true. stop_session_recorded first acts on a stored pid when present, then separately clears pid and writes Stopped. It subsequently attempts worktree removal and clears attached-worktree columns.

The Unix helper sends SIGTERM, sleeps 1,200 ms and sends SIGKILL to the recorded numeric pid. ESRCH is accepted as success. It does not wait for the runner to supply an exit receipt or establish that every descendant is gone. The Windows path instead calls taskkill with /T /F. These are source-level differences, not demonstrated equivalent guarantees.

The selected worktree remove body tries git worktree remove --force and branch -D, with warning/filesystem-fallback behavior. Some unsuccessful cleanup paths return Ok after warnings. Therefore neither “stop succeeded” nor “remove returned Ok” should be interpreted as proof that all processes are terminated, all resources are absent, or useful work was preserved.

A separate manager path used by budget/conflict pausing passes cleanup=false. The same eventual Stopped label can therefore be reached with materially different resource-retention consequences. This distinction needs to survive higher-level comparisons; a single generic “pause/resume support” feature label would conceal it.

**Conditional continuity concern, not reproduced:** build_session_record uses the worktree path as working_dir when attached. The stop path passes the existing session.working_dir to clear_worktree_to_dir after removal. That store method writes the supplied path, not a recovered base checkout. A subsequent resume reuses working_dir, while runner-log creation may recreate directories below it. This can make path existence different from preserved Git/worktree identity. The actual base-checkout/cache/cleanup helper chain and a discriminating local case remain required before claiming a demonstrated data-loss or invalid-resume incident.

## 6. Resume preserves an ECC identity; it does not establish full continuation

**Observed source, S186/S187/S190/S195.** resume_session_with_program rejects Completed and Running. Other returned states are reset to Pending with no pid through update_state_and_pid. Attached shared-dependency synchronization is best effort. It then starts a fresh ECC wrapper using the existing task, id, agent type and working directory.

The built-in command-construction branches use ordinary execution commands, task input and an ECC-derived label/environment; no explicit native transcript-resume operation appears in these reviewed branches. The source therefore supports “relaunch under the existing ECC session identity,” not a universal “restore the model's previous reasoning/context.” A configured runner can supply different base arguments or behavior, and a host may independently load context. Neither possibility should be excluded without following that consumer.

Profile values are partly persisted, whereas main reloads configuration and the wrapper is spawned again. Config::load merges defaults, global files and the nearest directory containing project configuration. Thus preserving the row id does not freeze the entire command configuration. Reproducibility of a resume requires a narrower claim than identity reuse; config revision, native conversation identity and retained work are not automatically interchangeable.

**Decisive source-directed failure contrast:** the reset to Pending/None precedes runner resolution/spawn. If a later runner operation returns an error, resume propagates it without compensating back to Failed in this function. Startup reconciliation below skips Pending, and ordinary heartbeat enforcement also skips Pending. For a non-worktree queued resume failure, the reviewed routes therefore do not by themselves supply automatic repair. This is a conditional code-path explanation, not an executed failure or a claim that no other surface anywhere can intervene.

## 7. Daemon restart: reconciliation is not resumption

**Observed source, S189/S187/S190.** Daemon startup calls resume_crashed_sessions, but its implementation only inspects Running rows. It retains those whose stored pid is considered alive and marks the others Failed with no pid. It launches no replacement process in this function. The name must not be substituted for the behavior.

On Unix the probe uses kill(pid,0) and treats success or EPERM as alive. It establishes numeric-pid existence/access behavior, not that the pid still identifies the original work attempt or a ready harness. The non-Unix implementation returns false. Under that compiled branch, a stored Running row is therefore selected for failure marking at startup even though this helper has not established actual process death. This is a pinned implementation limit; no Windows incident was run or observed here. The two inspected startup tests inject always-dead/always-live closures, so they do not validate the platform probe.

Recurring check_sessions calls heartbeat enforcement on Running/Stale rows. With auto-termination disabled, overdue Running becomes Stale. With auto-termination enabled, the function discards the terminate_pid result before writing Failed/None and recording the auto-terminated outcome. The classification is therefore not a termination receipt. Configuration defaults disable that automatic termination branch; its existence is not a claim that every default deployment kills overdue workers.

**Execution-topology seam:** ordinary Start uses an external detached ECC wrapper. Delayed worktree activation instead spawns run_session as a Tokio task inside its activating process; the daemon is one actual caller. A common session state does not imply a common supervisor lifetime. Exact child cancellation, output finalization and post-daemon-interruption ownership on this path remain open.

## 8. What is established, and what still needs discrimination

The established result is the implementation's ordering and predicates: queued versus spawned admission; acknowledged store calls versus consumer receipt; timer freshness versus progress; child exit versus goal acceptance; cleanup stop versus retaining pause; same-id relaunch versus native-context restoration; and startup classification versus actual relaunch. These distinctions came from Rust's own boundaries, not from imposing Plan Canvas's protocol on it.

The following are deliberately **not closed**: full direct lookup and output persistence/retention; board refresh and TUI observation; complete worktree/base-checkout/dependency-cache helpers; Pending/Idle/Stale resume admission under concurrent runners; stop-before-pid and post-spawn database-error cleanup; platform process identity/termination; concurrent guard behavior; and actual native conversation restoration. No observed duplicate process, orphan, data-loss incident, working host integration or successful recovery is claimed.

A useful next discriminator is a bounded non-model runner fixture that separates row, wrapper pid, harness pid, working-tree identity and output receipt across normal start, failed resume-spawn and stop/resume. But first recover the relevant pinned source/test/helper closure. A fixture is warranted only for a remaining decision, not to manufacture a new experiment count or replace historical E06.

## 9. Research use and continuation

ECC offers concrete strengths worth retaining in later comparison: an explicit record/process boundary, profile-aware command construction, a detached normal runner, acknowledged database operations, bounded local output, an explicit transition validator and startup reconciliation. Its limits are not summarized as “ECC is broken”; they identify which layer supplied which guarantee and which return values cannot carry stronger meaning.

For later Foundation/SOUL/Development OS discussion, this is a reuse question: how should a system preserve the difference between stored work, a particular execution attempt, its environment, the evidence of its progress and the authority to resume or discard it? No new ontology, architecture or implementation is adopted here. The present study continues to collect and challenge examples before joint evaluation.

Next U09-A work must start from this note and the ledger, not reread the giant files indiscriminately: finish the unresolved store/worktree/observer chain, inspect targeted lifecycle tests, then reassess the original return condition. The Node control-pane family remains Q04g2, not accidentally completed by a Rust trace. U08-A remains published; historical E06 stays excluded and both E05 histories remain separate.
