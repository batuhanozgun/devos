# U09-A2 — Store, observer and worktree continuation sources

**2026-09-18.** Unchanged pin: [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). This extends [the first ledger](U09-A-SOURCES.md), not its FULL claims. [Note14](../notes/14-STORE-OBSERVER-AND-WORKTREE-CONTINUITY.md) is the analytical product; [MR15](../ROUND-U09-A2.md) records method/outcome. STATE owns publication and current work.

## Exact additional coverage

Ranges below are inclusive source-file lines delivered by the connected GitHub reader. SELECTED includes incidental material and partially entered adjacent functions; it does not mean every function in the range or every dependency is closed. Complete named chains are specified below. No tree listing is a body read.

| ID | Path | Git blob/tree | Additional reading in this continuation |
|---|---|---|---|
| S190 continued | ecc2/src/session/store.rs | f71bb3640991f9d471e2ab98dad54dff4d346721 | SELECTED 2450–2730, 2850–3190, 3915–4230, 4420–5160; lookup/latest, board refresh and derivation, output append/read/retention, selected message/activity consumers; other store families and full schema not reread |
| S187 continued | ecc2/src/session/manager.rs | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | SELECTED 3850–4180, 4600–4900, 5350–6210; includes status formatting and selected test bodies. Earlier complete creation/runner/stop/resume/activation functions remain in S187's first-pass ledger |
| S193 continued | ecc2/src/worktree/mod.rs | aea51b4ddc52a7c331f045a2905ca52a772db930 | SELECTED 1050–1460, 1530–1810; complete base_checkout_path, dependency strategy/fingerprint/link helpers and selected branch-prefix tests; no full worktree module or branch-validation implementation claim |
| S197 | ecc2/src/tui recursive tree | 4e3581d8063c8bbb907e950e05cfb8374de17cf4 | FULL metadata, truncated:false: app/dashboard/mod/widgets. Descendants are not all read |
| S198 | ecc2/src/tui/app.rs | 46f3cffb268b3a7df639abf03103331c3f5cc8c2 | FULL through EOF; event loop, early-continue modes, tick and keyboard action dispatch |
| S199 | ecc2/src/tui/dashboard.rs | c98b4e2c2fea791538f3eeb3e56922b6f67dffc5 | SELECTED 1–280, 330–655, 790–1180, 3820–4790, 4940–5350; construction, render_output, tick, metrics enforcement, store/cache sync, selected notification and output-selection functions. Whole 541,173-byte file NOT FULL; filter implementations, broad renderer/actions/tests remain partial/unread |
| S200 | ecc2/Cargo.toml | 1995913c78282b08ccc7b4940b22e522c6e9cb41 | FULL; tokio version requirement 1/full and rusqlite 0.40/bundled. Not Cargo.lock resolution, installed version or a build |

S188 runtime, S189 daemon, S191 session types, S195 configuration and S196 output are retained at their unchanged first-pass identities and actual prior coverage. They are not new independent evidence. Full same-conversation first-pass source remains the basis for runner admission, mutations, stop/resume and startup reconciliation; re-entry into a ledger alone does not establish those behaviors.

## Complete relevant producer–consumer chains

**Lookup:** S187 resolve_session → S190 get_session/get_latest_session → list_sessions. Latest means first updated-descending row; prefix lookup returns the first id-equal OR starts-with match. Relevant stop/resume callers normalize to the returned session.id. No uniqueness rejection for an ambiguous prefix is present in this function; an empty prefix also matches. This is not an observed mistaken operator action.

**Output:** S188 capture_stream/acknowledged DbWriter → S190 append_output_line (INSERT; prune newest 1,000; timestamp UPDATE) → get_output_lines (newest subset, then ascending insertion order) → S199 sync_output_cache → visible_output_lines_for_session/visible_output_lines → render_output → S198 terminal loop. S196's process-local ring/broadcast is not the cross-process transport. Selected filter predicates are delegated; no full semantic filter audit is claimed.

**Board:** S190 refresh_session_board_meta → derive_board_meta_map/derive_board_scope/derive_board_conflict_signals/derive_board_progress_percent/derive_board_status_detail/annotate_board_motion → table upsert → S199 sync_board_meta. These explain state-derived lanes/heuristic percentages and recorded projection, not verified project completion, Git conflict or an event-history model. Handoff activity parsing calls comms::parse, whose full implementation is not researched in this slice; no authenticated delegation claim depends on it.

**Observer with effects:** S198 tick placement → S199 tick → S187 activate_pending_worktree_sessions; S199 sync_from_store → sync_runtime_metrics → heartbeat/budget/conflict enforcement. The dashboard can affect execution while refreshing. Construction initializes last-session-state snapshots; later state changes drive notification handling. No remote notification was sent or live TUI run.

**Worktree:** prior S187 creation/stop/resume and S193 remove entries → newly read base_checkout_path and dependency-link helpers. Base lookup prefers a different checkout of the recorded base branch and otherwise a different-checkout fallback. Matching manifests permit dependency-directory symlinks; mismatch can detach a link. These are resource reuse mechanisms, not proof of immutable or isolated environments. Stop's stored-path reuse and log-directory recreation are joined only to the bounded C04 command-semantic evidence below.

## Target test source inspected, NOT RUN

S187 includes complete tests for stop with and without cleanup; queueing at the worktree limit; activation using an injected launch closure; stored default profile; selected global/profile budget pause cases; failed-session requeue; cleanup metadata; and the stopped-only prune case. The retention test entered near the end of 5990–6210 is PARTIAL. Earlier runtime/output and startup-liveness tests retain their original inspected-only status.

The activation closure writes a launch record and returns Ok while the expected session remains Pending. The resume test substitutes a fake runner and checks argv/log plus Pending/None. The stop test uses the direct create_session_in_dir helper rather than the production detached queue wrapper and does not independently assert full process-tree termination. S193's configured-prefix and invalid-prefix tests are fully inspected; later diff tests are incidental. No claim that every lifecycle test or test-helper body was audited.

## E07 — distinct local evidence

[Pre-execution plan](u09-a2-sql-git-probe/PROBE-PLAN.md), [executed runner](u09-a2-sql-git-probe/run_probe.py), [actual structured results](u09-a2-sql-git-probe/RESULTS.json), [interpretation and correspondence](u09-a2-sql-git-probe/README.md).

One local Linux run used Python 3.13.5, SQLite 3.46.1 and Git 2.47.3. It executed source-derived statement/command semantics in a schema subset and isolated temporary repository. C01 observed the last-1,000 tail; C02 an inserted row survived an injected later prune error under autocommit but not the explicit-transaction rollback control; C03 an id-only stale write overwrote Stopped while the expected-state control did not; C04 a recreated log directory was not the removed worktree, unlike the preserved control.

These are not original Rust function executions, the bundled SQLite version, a Tokio scheduler test, an installed ECC stop/resume, a production incident or independent validation. Trigger injection and explicit transaction/CAS variants are fixture controls, not asserted upstream mechanisms. No parameters were changed after results. No new E06 was created or reconstructed.

## Separate primary dependency checks

- **W-U09A2-SQL:** [SQLite transaction contract](https://www.sqlite.org/lang_transaction.html), selected implicit-versus-explicit transaction section, observed 2026-09-18. Statement completion can commit an implicit transaction; this does not make a multi-statement Rust method atomic.
- **W-U09A2-TOKIO:** [Tokio process Command](https://docs.rs/tokio/latest/tokio/process/struct.Command.html) and [Child](https://docs.rs/tokio/latest/tokio/process/struct.Child.html), selected drop/cancellation, kill_on_drop and wait contracts, observed 2026-09-18. Default handle drop is not process termination. These moving primary docs inform a residual; exact Cargo.lock/runtime conformance and actual child survival were not verified. No Rust process was run.

A raw-source download failed at DNS; connected reads remained available. No full local target checkout exists. No PDF/image was analyzed. Git/SQL fixture files were temporary and removed after execution; the readable runner and output were retained and their Git hashes checked against published files. No user home/config/cache, external provider, upstream or unrelated research changed.

## Remaining source obligation

U09-A's original return criterion is still open at execution-attempt ownership: post-spawn DB errors, stop-before-pid, delayed activation cancellation, resumed Pending/Idle/Stale admission and competing writers. Current full-schema/attempt-fencing, exact dependency and supervisor contracts must be inspected before stronger guarantees. Selected lookup/output/board/TUI and worktree resource questions now have a usable answer; do not re-open them merely because broader runtime claims remain untested. Q04g2 Node operator remains separate.
