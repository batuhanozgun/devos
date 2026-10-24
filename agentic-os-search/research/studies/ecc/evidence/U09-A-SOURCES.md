# U09-A — Rust lifecycle source ledger, first checkpoint

**Date:** 2026-09-18. **Standing:** SOURCE CHECKPOINT / U09-A PARTIAL, not whole-lifecycle closure. **Unchanged target:** [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). [Note13](../notes/13-RUST-SESSION-LIFECYCLE-FIRST-SLICE.md), [MR14](../ROUND-U09-A.md), [STATE](../STATE.md).

SOURCE OBSERVATION, TARGET CLAIM and conditional INFERENCE remain distinct. No target code, upstream test, model/provider, installation or live session ran. No new experiment ID or pass count. Runtime/output/daemon test bodies below were inspected, not executed. Administrative publication is not a target experiment.

## Acquisition and actual coverage

All bodies and trees below came through the connected GitHub tool at the unchanged pin. FULL body means read through EOF; SELECTED means only the exact source ranges listed, including incidental discovery material. Complete functions within SELECTED bodies do not make the whole file FULL. A complete tree is metadata, not its descendants' behavior. Initial attempted full main.rs was display-truncated; it is not additional full-file coverage. Default-branch search served only discovery and was not substituted for pinned evidence. Auxiliary raw/web acquisition did not provide a verified local checkout.

| ID | Object at pin | Git identity | Actual read / limit |
|---|---|---|---|
| S156 re-entry | ecc2/src tree | 6e722551d08805adce0760184f5835e7e4de4ef8 | FULL direct metadata, truncated:false; not new body evidence |
| S10 re-entry | ecc2/README.md | 71aad6da80ba490a3705587aa31a15c36625b9fc | FULL again; alpha and lifecycle/evaluation declarations, not runtime proof |
| S185 | ecc2/src/session recursive tree | 8854fa44b0a6cd146e3fc9ccf00e232095043e97 | FULL bounded metadata, truncated:false; six files |
| S186 | ecc2/src/main.rs | 7c516684c178d050bc36d96d0481f812e9c48c07 | SELECTED 1–200, 850–1100, 1200–1720, 2380–2660, 2830–3130, 3200–3420. Relevant entry/config load and complete Start, Stop, Resume, Daemon and RunSession match arms; many unrelated commands/helpers remain unread |
| S187 | ecc2/src/session/manager.rs | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | SELECTED 1–530, 600–880, 1120–1585, 1650–1900, 2100–3360, 3380–3680. Complete named lifecycle functions below; other functions only incidentally or partially read, substantial remainder unread |
| S188 | ecc2/src/session/runtime.rs | 165b32e188644582738c50993669e023521ed0b2 | FULL 1–220 and 221–460 through EOF, including two test bodies; NOT RUN |
| S189 | ecc2/src/session/daemon.rs | e62ea0ae88d71027b1627d916b3d8e6d32b37cf4 | SELECTED 1–270, 365–640. Complete run/startup reconciliation/check_sessions and platform pid probes; two startup reconciliation tests fully inspected, later dispatch test partial; remainder unread |
| S190 | ecc2/src/session/store.rs | f71bb3640991f9d471e2ab98dad54dff4d346721 | SELECTED 1–250, 850–1740, 1810–2070, 2190–2450. Open/schema beginning, insert/profile/state/pid/worktree/queue operations, heartbeat and list_sessions; full schema, get_session/get_latest_session, output persistence and board-refresh internals NOT closed |
| S191 | ecc2/src/session/mod.rs | 902ea1f9604d8b7274ee01c40bc3a2b014655233 | SELECTED 1–450. Harness detection/selection, Session fields, full state transition and parse implementations; later message/graph definitions and tests unread |
| S192 | ecc2/src/worktree recursive tree | 13691ec8b30847617c82b7e09a7c14e066cdbeb2 | FULL bounded metadata, truncated:false |
| S193 | ecc2/src/worktree/mod.rs | aea51b4ddc52a7c331f045a2905ca52a772db930 | SELECTED 1–250. Complete creation, branch-name and remove entry bodies; base_checkout_path, validation and dependency-cache internals not closed |
| S194 | ecc2/src/config recursive tree | 046fa81139782176ce746d2e8388f4d040db250b | FULL bounded metadata, truncated:false |
| S195 | ecc2/src/config/mod.rs | d48bd9a67ee47a5c0d85f6d079ab40736efe61b9 | SELECTED 1–685. Config/profile/runner shapes, default values, runner lookup, profile-resolution entry/recursion, complete load/path selection/merge implementations. Profile apply and remaining defaults/tests not fully read |
| S196 | ecc2/src/session/output.rs | d7ac8745f114c11a3bd8c679c776110118016ed9 | FULL through EOF, including two NOT RUN tests; process-local ring/broadcast, not cross-process UI delivery |

Pinned source links: [main](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/main.rs), [manager](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/manager.rs), [runtime](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/runtime.rs), [daemon](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/daemon.rs), [store](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/store.rs), [session types](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/mod.rs), [worktree](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/worktree/mod.rs), [config](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/config/mod.rs), [output](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/output.rs).

## Complete selected function chains and their limits

**Entry/creation:** S186 Start → S187 create_session_with_profile_and_grouping / from-source variant → queue_session_in_dir → queue_session_in_dir_with_runner_program → queue_session_with_resolved_profile_and_runner_program → build_session_record / resolve_launch_profile / attached_worktree_count → S190 insert/profile/queue operations. S191 selection and S195 lookup/load are source-bound. Worktree helper closure is partial (S193); profile apply and board projection remain open. This establishes caller intent and ordering, not universal successful admission.

**Runner:** S187 spawn_session_runner_for_program → log creation + Command::spawn, with Unix setsid / Windows detached flags → S186 hidden RunSession arm → S187 run_session → agent_program/build_agent_command or configured variant → S188 capture_command_output. The wrapper's successful spawn returns without a child readiness acknowledgment. Normal CLI runner and daemon queued-worktree activation use different execution topologies. Rust dependency cancellation semantics, actual OS behavior and race reproduction were not verified.

**Output/state:** S188 DbWriter sends acknowledged operations to its dedicated database thread; capture_stream awaits append_output_line before S196 local publication. Selected S190 update_state validates S191 transitions; update_state_and_pid does not call that validator. Their mutations are by session id, and some refresh a board after the SQL statement. Full board helper, output SQL/retention and cross-process TUI refresh remain open; acknowledgment is not promoted to transaction-wide or UI/semantic acceptance.

**Stop:** S186 Stop → S187 stop_session → stop_session_with_options(true) → stop_session_recorded → platform kill helper, separate pid/state writes, optional S193 removal then S190 clear_worktree_to_dir. Unix signal calls are to the recorded pid, with a fixed 1,200 ms gap; Windows uses taskkill /T /F. No wait-for-exit proof is produced by this helper. Worktree removal has warning/fallback paths; Ok alone is not proof of successful preservation or cleanup.

**Resume:** S186 Resume → S187 resume_session_with_program rejects Completed and Running, otherwise writes Pending/None before spawning a fresh wrapper with the existing id/task/agent/working_dir. Failed wrapper launch propagates after that state write; this function has no compensating Failed write. Existing profile is fetched by run_session; built-in argv has no explicit native transcript-resume operation. Configured runners may behave differently. Full exact lookup/consumer closure and process ownership remain pending.

**Daemon/failure counterpart:** S189 startup reconciliation inspects only Running records, probes stored pid and writes Failed/None for non-live results; it does not relaunch. Unix probe treats kill(pid,0) success or EPERM as alive; non-Unix probe returns false. Recurring check_sessions invokes S187 heartbeat enforcement for Running/Stale. Its configured auto-termination branch discards the termination result before attempting Failed/None. These are exact source predicates, not actual deployment incident counts.

## Evidence discipline and handoff

Note13 distinguishes direct predicates from conditional race, configuration, worktree and post-spawn failure concerns. No orphan, duplicate process, lost transcript, successful cleanup or production failure was empirically demonstrated. Tests inspect controlled local shell/DB or fake liveness conditions; they are not a real-host oracle and were not run here. No E07 or E06 replacement is created.

Next: finish direct store lookup/output/board dependencies; recover relevant pinned lifecycle tests; trace queued-worktree activation and cleanup through their real helpers and observers; discriminate stop/resume/race conditions with source or a justified isolated fixture. Do not restart the giant files from line 1 or treat this selected coverage as complete. Only then reassess U09-A's original return condition; Q04g2 Node operator work remains separate.

Historical U08-A closure, excluded E06, both E05 histories and U07 breadth dispositions are unchanged. Current source reading and later publication readbacks are same-assistant checks, not independent corroboration.
