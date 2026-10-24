# Note14 — Stored sessions, operator observation and worktree continuity

**2026-09-18 · U09-A continuation / U09-A2 bounded slice.** U09-A/Q04g1 remains IN PROGRESS. This note extends [Note13](13-RUST-SESSION-LIFECYCLE-FIRST-SLICE.md); it does not replace the first slice or complete all Rust controller research. [Exact source and test ledger](../evidence/U09-A2-SOURCES.md), [E07](../evidence/u09-a2-sql-git-probe/README.md), [MR15](../ROUND-U09-A2.md). Pin: `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.

Evidence classes: SOURCE OBSERVATION; bounded INFERENCE; inspected-but-unexecuted target tests; one source-derived SQLite/Git fixture. E07 is not a compiled ECC, Tokio, provider or native-host experiment. Historical E06 stays excluded. STATE owns publication/current work.

## 1. Question and result

How do a stored session and its output become an operator-visible state, and what is actually retained when execution stops and later resumes?

The missing consumer path is now concrete. A worker appends output to SQLite; the dashboard polls that database, updates its own cache and renders selected lines. The separate process-local broadcast is not required to explain cross-process visibility. The retained database output is a bounded tail, not an unlimited transcript. The board is a derived projection with heuristic percentages, not an independent acceptance oracle.

The operator surface also participates in execution: its tick can start queued worktree sessions and its refresh path invokes heartbeat, budget and conflict controls. Treating it as a passive monitor would miss a real controller and its lifetime.

Resource continuation is a separate responsibility. A stored working-directory path can survive cleanup while its Git worktree and uncommitted contents do not. Recreating a directory for a runner log does not reconstruct that worktree. E07 reproduces this distinction at the command level, while actual ECC process ownership, cancellation and full stop/resume remain open.

## 2. Session selection: identity is not an unambiguous address by default

S190 get_session calls list_sessions and returns the first row whose id equals or starts with the supplied string. list_sessions orders by updated_at descending; get_latest_session takes the first row. The lookup does not reject multiple prefix matches. An empty string also satisfies starts_with for every row. This does not mean the ordinary generated full eight-character identifiers are always ambiguous; it identifies the weaker short-address contract.

For example, with two ids sharing `ab`, an operator's `ab` can select a different row after one session receives a later updated_at. The output append path updates that timestamp, so selection can change without changing either id. This is a source-derived counterexample, not an observed wrong-session action. Callers that use a selected complete id avoid that particular ambiguity; Stop and Resume resolve a Session and subsequently use its complete id. No authenticated-actor or universally exact-address property follows from convenient aliases.

## 3. Persistence, method acknowledgment and display are three different stages

The complete append sequence is:

`INSERT session_output → DELETE older rows beyond 1,000 → UPDATE session timestamps → return Ok → runtime publishes locally`.

get_output_lines selects the newest requested rows by insertion id and returns that subset in ascending order. The database and S196 local ring use the same OUTPUT_BUFFER_LIMIT=1000. There is genuine recoverability across reopening, but only of the retained tail on this path. Other host transcripts may exist; this note does not claim that these rows are ECC's only possible historical information.

E07/C01 appended 1,002 labelled rows using the inspected SQL semantics and reopened the file: 1,000 remained, from line-0003 through line-1002 in order. This confirms the SQL-level tail behavior, not bundled-rusqlite conformance or power-loss durability.

The runtime's writer acknowledgment from Note13 is useful: it waits for the store method, rather than merely enqueuing a message. However, that method comprises several statements without its own enclosing transaction. E07/C02 deliberately made pruning fail after insertion. Reopening the autocommit database still found the new row; the explicit-transaction rollback counter-control did not. The injected trigger is a fixture, not an upstream trigger or observed production failure. Its purpose is to distinguish partial side effects from a claimed all-or-nothing method.

The same conceptual boundary exists in selected session mutations: an UPDATE or INSERT occurs before refresh_session_board_meta. A later projection error can therefore coexist with an already-applied primary write. A failed acknowledgment does not necessarily mean that nothing happened. Conversely, success still means neither that a dashboard read the row nor that a person accepted the work.

## 4. The board is a derived operational view, not measured project completion

S190 derives board lanes from session state: Pending→Inbox, Running→In Progress, Idle→Review, Stale/Failed→Blocked, Completed→Done and Stopped→Stopped. Task text heuristics supply scope/issue labels; shared task, scope or branch names supply board conflict signals. These signals are not automatically Git merge conflicts, task ownership or reviewed decisions.

Progress values are assigned by predicates: Pending 10; Running 25, 45 or 60 depending on worktree/tool/file signals; Idle 85; Stale 55; Completed 100; Failed 65; Stopped 0. The values summarize a state heuristic rather than count satisfied task requirements. A change from 65 to 0 on stopping a failed session does not establish that accomplished work vanished. Likewise the Completed→100 projection inherits the process-exit meaning from the runtime; it adds no goal-specific verification.

refresh_session_board_meta writes a derived snapshot for all sessions. Movement annotations compare against the previous snapshot; unchanged refreshes need not retain an earlier movement annotation. That is not an append-only event-history contract. The projection can be operationally useful without satisfying those stronger meanings.

A related distinction survives from Note13. update_state checks the transition table, whereas update_state_and_pid is a separate reset path. The guarded method itself reads a state and later writes by id, rather than binding its UPDATE to the exact state it checked. E07/C03 used two SQLite connections with a prescribed interleaving: an id-only update based on an earlier Pending read overwrote a later Stopped state; an expected-state counter-control updated zero rows. This is a SQL-level falsifier of treating an earlier check as an atomic admission. It is not an observed ECC race or a rate estimate. The ordinary sequential transition guard remains a real protection; this finding does not erase it.

## 5. Cross-process observation works through polling, with distinct failure views

The actual route is S188 writer → S190 output table/read → S199 sync_output_cache → visible_output_lines_for_session/visible_output_lines → render_output → S198 terminal drawing. The dashboard's own default output store is a separate instance. tick drains its local broadcast receiver without using event content and then refreshes from SQLite. A separate CLI worker's local broadcast therefore need not reach this dashboard for output to be visible.

Each successful cache read replaces the local lines with the database tail. Output filter/time predicates and scrolling select the rendered view. On a per-session output-read error, sync_output_cache logs a warning and leaves the prior cache for that still-listed session. On a session-list error, sync_from_store substitutes an empty session vector; cache retention can then remove entries and the renderer can show the no-sessions view. In these examined paths, read failure, stale retained output and actual empty state can lead to different but deceptively ordinary-looking displays. No claim is made about every UI warning surface or an observed user mistake.

State-change notification handling also depends on the observer's snapshots. Dashboard construction initializes last_session_states from current rows. Later comparisons, not a durable replay cursor, trigger the selected completion/failure notification path. A completion that happened before opening the dashboard is not thereby replayed as a newly observed transition by that code. The retained row is still available. Notification delivery services and complete summary heuristics were not audited or executed.

The normal loop polls keyboard events with a 250 ms timeout, but this is not a guaranteed refresh period. Input, completion-popup and some command-mode branches continue before tick. Long operations can also delay it. Thus its maintenance and observation cadence is coupled to interaction; this is source control flow, not a measured latency claim.

## 6. The observer is also an effectful controller

S199 tick calls activate_pending_worktree_sessions before loading state. sync_from_store invokes sync_runtime_metrics, which calls heartbeat, budget and conflict enforcement. Those can change session state and, in applicable branches, request process termination. Opening and interacting with the TUI therefore supplies more than a passive read surface.

This resolves one earlier missing caller: both daemon and dashboard can activate pending worktree sessions. Their activation helper spawns run_session as a task in the activating process, unlike the ordinary CLI's detached ECC wrapper. A shared session row does not make their supervisor lifetimes identical. Quit paths in S198 leave the loop; stronger child-lifetime consequences require the actual dependency and ownership path, not only the existence of a Tokio task.

Primary Tokio documentation says that default Child-handle drop does not itself kill a process. Cargo.toml declares Tokio 1, but this continuation did not recover an exact built lock/runtime or run child cancellation. That check is a reason to investigate post-spawn errors and supervisor exit, not proof that an orphan occurred in ECC.

## 7. Worktree continuation: retained path, retained resources and retained work

The newly read base_checkout_path examines Git's worktree list, preferring a different checkout of the recorded base branch and otherwise falling back to a different checkout. The path is discovered from current Git state; it is not an immutable environment identity. The helper is used for cleanup and dependency synchronization, not as an automatic correction to the session's stored working_dir.

Dependency sharing is concrete rather than just a cache label. The code recognizes node_modules, target and .venv strategies, fingerprints selected manifest/lock contents, and may create directory symlinks. A fingerprint mismatch can remove an existing symlink and create an independent directory. These checks avoid some incompatible reuse. They do not establish immutable cache contents or isolation between writers merely because worktrees have different roots. E07 did not test shared-cache mutation.

The successful default Stop cleanup path removes the worktree with force, deletes its branch, then clears attached-worktree metadata while supplying the previous working_dir. For an attached session that directory was the worktree path. Resume later uses the stored path; preparing its runner log can create directories beneath it. Neither that directory creation nor the preserved session id reinstates Git registration or uncommitted contents.

E07/C04 used an isolated repository with two controlled worktrees. After the reviewed cleanup commands, one path was absent. Creating only its runner-log directories made the path exist again, but Git no longer listed it, git rev-parse returned 128, and its uncommitted marker was absent. The retained no-cleanup control remained a registered worktree with its marker. This is actual command-semantic evidence supporting the conditional source explanation. It is not a live ECC stop/resume, a test of every cleanup-failure branch or proof of permanent loss of committed Git objects. A path nested under another repository could resolve to that other repository instead; path existence alone remains insufficient in either case.

## 8. What the target tests establish at their inspected scope

The stop test checks recorded Stopped/None and whether a worktree path remains with cleanup enabled or disabled. It uses a direct helper, not the whole detached-runner production path. The queued-activation test injects a closure that writes launch arguments; it explicitly expects the row to remain Pending. The resume test substitutes a fake executable and checks requeue/argv. These are useful targeted contracts, not proof of a ready harness, restored model conversation, full process-tree termination or successful continuation after cleanup.

All those target tests were inspected, not run. Only E07's schema-subset SQL/Git fixture executed. Its plan preceded execution; raw outcomes and runner hashes are retained. The transaction and expected-state controls are discriminators, not adopted patches. The same assistant wrote and evaluated the fixture; independent research verification and general efficacy are not claimed.

## 9. Disposition and next exact question

This slice closes the previously missing lookup/output/board/TUI consumer explanation and materially advances worktree resource continuity. It preserves positive mechanisms: durable bounded output, explicit refresh, an operator surface that actually coordinates, state validation, configurable cleanup, dependency compatibility checks and source tests for chosen contracts.

The original U09-A lifecycle return condition remains open at execution-attempt ownership. Next: trace who owns and can revoke a particular launched child across stop-before-pid, post-spawn database error, delayed-activation cancellation and Pending/Idle/Stale resume. Re-enter S188 capture_command_output and S187 run_session/activation/resume with S189 startup and S190 state writes; inspect the relevant schema and exact dependency contract before asserting fencing, child cleanup or absence. A new fixture is justified only for a remaining discriminator; do not rerun E07 merely to regain context.

Q04g2 Node operator stays separate. Remaining native workflow, evaluation, release, observability and final omission work still belongs to the broader plan. Candidate reuse for SOUL/Development OS is the distinction between retained record, execution attempt, resource identity, derived view and accepted work—not a new ontology or adopted implementation. Joint whole-study evaluation remains after completed research.
