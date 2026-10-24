# U09-A3 — Execution-attempt ownership source ledger

**2026-09-18 · Q04g1b.** Target remains [affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). This extends [U09-A](U09-A-SOURCES.md) and [U09-A2](U09-A2-SOURCES.md); their source and experiment identities are not replaced. Analytical result: [Note15](../notes/15-EXECUTION-ATTEMPT-OWNERSHIP-AND-REVOCATION.md). Method record: [MR16](../ROUND-U09-A3.md). STATE owns current work/publication.

SOURCE OBSERVATION, versioned dependency contract and conditional source-derived schedules are distinguished. **No new experiment, Rust build, target test, process signal, host/model/provider or E08.** E07 remains its original source-derived SQL/Git run; it was not repeated or promoted into Rust evidence. E06 remains excluded.

## Exact additional source coverage

All ECC rows below use the unchanged target pin. SELECTED is inclusive source-file line coverage, not a whole-file read or closure of every incidental helper. Retained prior full/selected bodies in the same conversation remain available; new reads are not independent corroboration.

| ID | Object | Git identity | Reading in this continuation |
|---|---|---|---|
| S155 re-entry | ecc2 direct tree | a5cd9ce731bc2d405fb2191f075ad19dbaed128a | Complete direct metadata, truncated:false; resolves Cargo.lock and other entries, not descendant behavior |
| S187 re-entry | ecc2/src/session/manager.rs | 515235760adb242fe3b4bd1e8481c8b78aee5cc4 | SELECTED 1510–1590, 2320–2570, 3510–3640. Resume body; complete run_session and delayed activation; complete stop/kill helpers. Prior complete resume signature/callers, builders and detached runner are retained in U09-A ledger |
| S188 re-entry | ecc2/src/session/runtime.rs | 165b32e188644582738c50993669e023521ed0b2 | 1–255: entire production body, including writer, capture, error cleanup and stream tasks; test-module opening only newly read. Prior FULL body and its two inspected, NOT RUN tests retain their scope |
| S190 continued/re-entry | ecc2/src/session/store.rs | f71bb3640991f9d471e2ab98dad54dff4d346721 | SELECTED 205–900, 1270–1475. Joins prior 1–250/850–1740 to complete init_schema, session-column migration and called schema-helper coverage; reopens state/pid/reset/queue writes. Not the whole store or all evaluation/graph behavior |
| S191 re-entry | ecc2/src/session/mod.rs | 902ea1f9604d8b7274ee01c40bc3a2b014655233 | 320–410: complete state enum, formatting, transition and parsing implementations |
| S199 continued | ecc2/src/tui/dashboard.rs | c98b4e2c2fea791538f3eeb3e56922b6f67dffc5 | SELECTED 2870–3340. Complete stop_selected/resume_selected/cleanup_selected_worktree, relevant merge/prune/delete entries and refresh; incidental adjacent functions. No whole-dashboard or test coverage |
| S201 | ecc2/Cargo.lock | ab4d168cc80acfda87595572883bef04f0290194 | SELECTED 2270–2680. Exact Tokio 1.53.1 package/version/checksum entry and incidental neighbors. Not full lock audit or proof of a built binary |

S186 main dispatch, S189 daemon, S193 worktree, S195 config, S196 output and S198 TUI app retain their original recorded coverage. They provide the already-read actual caller, constructor, restart and observer paths; they were not silently promoted to whole-file reads. The new schema coverage does not mean every function in store.rs was examined. In particular evaluation immutability is a separate table contract, not session ownership.

## Exact external dependency binding — not a new study

S201 resolves `tokio = 1.53.1`, registry checksum `202caea871b69668250d242070849eb495be178ed697a3e98aebce5bc81a0bed`. S200 previously established Cargo.toml's Tokio 1/full requirement. The connected GitHub tag lookup below pins relevant upstream source rather than relying on a moving latest manual.

Dependency repository: `tokio-rs/tokio`; source commit **75fef53d0a8590c2d1dbb63672aa7b7d1ef51155**.

| ID | Object | Git identity | Actual scope |
|---|---|---|---|
| S202 | refs/tags/tokio-1.53.1 | commit 75fef53d0a8590c2d1dbb63672aa7b7d1ef51155 | Complete GitHub ref response, object type commit |
| S203 | tokio/src/process/mod.rs | fb233cb4eb2af27a347565f5382c8836837e7c3f | SELECTED 197–335, 835–900, 935–980, 1090–1165. Default-drop contract, Command construction/spawn/build_child, From<StdCommand>, ChildDropGuard and its Drop/Future implementations |
| S204 | tokio/src/runtime/task/join.rs | dfe0fad7005d051f82c6e98803c25ffaa8905350 | SELECTED 1–78. Versioned JoinHandle contract: dropping detaches; awaiting observes completion. Not a full scheduler-internals audit |
| S205 | tokio/src/runtime/runtime.rs | 6a1d2e45ee2b35ce88adf00e1aaa2c4f47a8f9a0 | SELECTED 1–115. Versioned runtime shutdown/yield/drop and bound-I/O contract; not the full executor implementation |

Pinned dependency sources: [process](https://github.com/tokio-rs/tokio/blob/75fef53d0a8590c2d1dbb63672aa7b7d1ef51155/tokio/src/process/mod.rs), [task handle](https://github.com/tokio-rs/tokio/blob/75fef53d0a8590c2d1dbb63672aa7b7d1ef51155/tokio/src/runtime/task/join.rs), [runtime](https://github.com/tokio-rs/tokio/blob/75fef53d0a8590c2d1dbb63672aa7b7d1ef51155/tokio/src/runtime/runtime.rs).

This binds the declared version to a retrieved version-tag source. **The published registry crate was not downloaded and checksum-matched to this Git tree, and no locked ECC binary was built or inspected.** Claims concern the inspected source and declared dependency contract, not an installed environment. Operating-system, custom runner and native harness outcomes remain qualified.

## Claim-to-source bindings

- **Normal owner and observation tasks:** S186 → S187 detached runner or delayed activation → S188 child/writer/heartbeat/streams → S190 persistence → S199/S198 observer. A native Child handle, stored pid and durable session id have different roles.
- **Admission and stale attempts:** S187 run_session tests Pending without reserving it. Resume rejects Completed/Running, resets other states and spawns again. S190 reset/pid/state/output/heartbeat and actual session/output/queue schema use session identity; the reviewed writes have no expected attempt/generation predicate. S191's real sequential guard remains positive counterevidence against unconditional late-state overwrite claims.
- **Stop window:** S187 stop uses the fetched pid, then separate pid/state writes. S188 can spawn before its pid/Running writes. S203 binds default Child drop behavior. The stop-before-read control differs from stop-after-read-before-pid. These are explicit conditional schedules, not executed races.
- **Post-spawn error:** S188 inner error releases child ownership before best-effort row cleanup outside the inner await. Only the missing-pipe branches explicitly kill/wait there. The second writer open and later operations can fail after an earlier manager open; an initial manager-open failure instead prevents launch.
- **Cancellation versus error:** S188 cleanup after await is not an async destructor. S203 default child Drop, S204 detached task handles and S205 runtime shutdown are distinct contracts. The source does not supply automatic equivalence among task cancellation, process exit and persisted failure.
- **Delayed activation:** S187 production callback discards the task join handle and returns Ok before run_session's outcome is known; the outer helper dequeues on that Ok. S189 and S199/S198 are actual daemon/TUI callers. Git creation and the initial Pending check are real barriers, so no blanket two-activator/two-worker assertion is made.
- **Replacement finalizer:** S187 permitted same-id resume can leave an old live worker while starting a new one. S188 old writer clears pid and proposes terminal state; S190/S191 accept by current session state, not attempt identity. The described old-A/new-B schedule does not require racing within update_state's read/check/write.
- **Restart:** retained S189 running-pid reconciliation and heartbeat checks classify existing rows; they neither recover child handles nor replay/reattach capture tasks. This is not a universal claim about external supervisors or every ECC component.

## Tests, external checks and exclusions

Prior inspected runtime tests cover quiet-process heartbeat and shell output/broadcast; daemon startup tests inject liveness closures; manager activation/resume tests use launch closures/fake runners. Those remain useful limited contracts, not newly executed or complete ownership tests. This turn does not claim an exhaustive test inventory or that no other ownership tests exist.

Primary web checks used Tokio's [Child](https://docs.rs/tokio/latest/tokio/process/struct.Child.html), [JoinHandle](https://docs.rs/tokio/latest/tokio/task/struct.JoinHandle.html) and [versioned Runtime](https://docs.rs/tokio/1.53.1/tokio/runtime/struct.Runtime.html) pages, observed 2026-09-18; selected cancellation/drop/wait/shutdown descriptions only. Latest pages displayed 1.53.1. Several direct versioned-page opens failed; exact connected GitHub source S202–S205 supplied the stable binding. Unrelated mirrors were not evidence. No full manual reading is claimed.

One auxiliary raw target retrieval failed at DNS. Connected reads and the initial readable MR16 publication succeeded. No full target checkout, original Rust execution, dependency installation or new local fixture was produced. Source-derived schedules in Note15 are not mislabeled E08 outcomes. Administrative file/hash/readback work is publication checking, not behavior evidence.

## Scope disposition

The joined source explains the bounded ownership question, including useful controls and their actual failure/restart limits. Stronger claims about observed process survival, host conformance, parallel-operator behavior, PID reuse, full termination, native conversation restoration or repaired implementation require separate evidence. They must remain open even if the bounded U09-A source inquiry closes. Node Q04g2 remains a distinct following family, not completed by the TUI trace.
