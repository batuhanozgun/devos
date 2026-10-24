# U11-B — Scheduled-work admission / MR21

**2026-09-19 · bounded Q04e1 source answer.** METHOD0.1 retained; PLAN0.21 →0.22. STATE owns actual publication closure and next activation. No new experiment/E09 or live recurring task.

## Takeover and authority

Batu continued ECC research after U11-A. Fresh AGENT matched aea3dd845e0f0bbcfb34465edb23782e99f95c80. Full same-conversation protocols remained applicable; R01's last section and R02 were recovered again. Fresh STATE matched c1aa2dae1a45159fb45589219e828ca5d2d96db3; unchanged package/Note19/U11-A ledger/MR20/receipt/E08 readings were retained. Comparison from ab3da7f3113f7303664c17f091923c97bc84016c showed only two independent concepts/STATE changes. Input main: e34c9f7fe42ef62aa4372901a469aa9bacdf09ee.

U11-A was COMPLETE/PUBLISHED, not a repair task. Target stayed affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a. Source research and ECC-local continuity were authorized; upstream changes, live schedules, provider/model, installation and SOUL architecture were not. Opening MR21 reached main in eb2a776388f4c672f462ec5968f88e84b58d01fb; STATE activation in091309c21b1e2ec10b6c8c7df6c9a02ef7521e9b.

## Original criterion and actual result

The criterion was persisted schedule/timing/directory/profile → due selection → admitted session/runner → schedule advancement and operator outcome, with an important failure/restart/competing-dispatch counterpart. It was not replaced with an experiment quota or an all-orchestration target.

The daemon led to the exact manager loop, schedule SQL, CLI enum/dispatcher, cron normalization/iterator call and the existing queue/profile/worktree/runner path. The ordinary scheduling test and relevant queue tests were inspected. Cargo.lock fixed cron0.17.0; version-labelled primary dependency source was consulted, not a built binary. [Sources](evidence/U11-B-SOURCES.md) retain exact scopes.

[Note20](notes/20-SCHEDULED-WORK-ADMISSION-AND-RETRY.md) explains a recurring admission producer, not completion-aware task scheduling. A Pending worktree request can count as dispatched; wrapper PID is not readiness. The daemon's max_parallel_sessions becomes a due-query batch limit in this path, without subtracting live work or checking prior occurrences. The current profile name is resolved at dispatch rather than frozen at schedule creation.

One pass captures UTC now and computes the next occurrence after that time. Missed occurrences are not individually replayed; loop work plus sleep does not guarantee exact firing cadence. Admission precedes next-time calculation and the by-id schedule update. An error can leave admitted work while the old row remains due. Finite schedules make the boundary concrete without a fabricated DB fault: after the final permitted occurrence, successful queueing can precede a no-future error. First-error batch propagation can block later due rows and discard the partial response vector without rolling back previous effects.

The selected rows are snapshots, not exclusive claims. Competing callers can act on the same due row; removal after selection does not revoke the snapshot, and the later update ignores zero affected rows. The returned vector links schedule/session, but the examined persistent schedule path saves timestamps rather than occurrence/result provenance. These are conditional source results, not observed production races or incident rates.

Positive creation/profile/future-time checks, ordered/limited reads, worktree queue retention, successful advancement, future-selection deletion and surfaced daemon errors remain explicit. Missing stronger guarantees were not used to dismiss the mechanism's useful bounded purpose.

## Evidence decision and method consequence

A broad 'does scheduling work?' question would conflate due time, accepted request, live process and completed task. Tracing the actual last_run_at writer and its returned outcome separated those objects. The finite-exhaustion counterexample follows from admitted input plus the ordinary no-next-date branch; it does not require manufacturing an environmental failure.

Alternatives were another SQL fixture, a Rust build/live scheduling campaign, or closure of exact source ordering/caller/dependency boundaries. Source closure answered the authorized question without repeating E07-style storage evidence or creating a recurring effect. No new fixture was necessary. Stronger runtime timing, multi-dispatch, terminal handling, cancellation, fairness, malformed/migrated records, actual provenance/acceptance and binary correspondence remain Q04e1b.

The inspected normal test uses a real temporary store/repository and a fake executable, checks one result and timestamp advancement, but does not establish accepted task output or the new failure cases. It was NOT RUN. Its usefulness and its narrower oracle are both retained. Test-source inspection is not E09 or independent empirical corroboration.

The result meets the original source criterion; METHOD0.1 remains. PLAN0.22 moves next to remote intake/routing, a separate request authority/state boundary, not repeated scheduling. Broader delegate/team/template control, host/provider, release/audit/observability and final native synthesis/omission work remain.

## Operational cost and unresolved retrieval problem

The intended narrow source trace still incurred substantial monolithic-file location cost. Several guessed ranges returned unrelated template, graph, merge, profile, coordination or test code. One broad test request and another large range were display-truncated. Response search located the scheduling test but did not provide source coordinates; a later targeted range recovered the complete test. The ledger records all ranges and does not convert incidental exposure into completed families or a full read.

This was not solved by stating a progressive-retrieval intention. Exact handoff coordinates now prevent repetition for this particular question, but there is no measured general retrieval-efficiency improvement. A local search for reusable cached catalogue/manager files found none. An auxiliary raw download failed DNS; connected GitHub acquisition continued. Several explicit-version docs routes and the cron query-helper URL failed, while a version-labelled latest page worked. Crate bytes and installed binary were not verified; no exact subsecond/DST claim depends on unavailable helpers.

No target code/test, SQL probe, OS process, recurring job, server, provider/model, installation, user-home/config/cache mutation or upstream patch ran. E08 was not rerun and E06 remains excluded; prior experiment identities and correction histories are preserved.

## Publication and next responsibility

Ledger commit becd7b1f0564a47d3d187e08863b39f4ce2cff62; Note20 commit18287f3ba8d97fd329853f7c5a2080d5e7cdec69. Full readbacks at18287f3 gave ledger blob c9f6a215be774677cc542fe5208abfddb3934141 and note blob e68ea0b092977a3095f6bb9ff03565805fe3ae73 (1–85/86–200 through EOF). PLAN/QUESTIONS/META/INDEX were updated. Final entry/catalogue/receipt/STATE checks are subsequent actions, recorded only when actually completed.

Next selected U11-C/Q04e2 is remote request intake, authentication/target binding, persistence, targeted versus top-level routing and result/failure/retry consumers. Start at main RemoteCommands and run_remote_dispatch_server, manager run_remote_dispatch_requests, store request methods. Incidental exposure is not completion; no live endpoint should be started. U11-C is NOT STARTED until STATE activation after publication.

Writes remain ECC-local plus only the necessary ECC catalogue row. Prior notes/evidence, other studies, agent-control and concurrent concepts are protected. No branch/PR, force update, user upload or merge task. Same-assistant readback/hash/diff checks establish correspondence, not independent research validity. Whole-study joint evaluation follows completed ECC research.
