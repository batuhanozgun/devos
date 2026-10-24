# U03 / K — Fixed exploratory specification

2026-09-10. Question: how do claimed run identity and transaction placement affect a durable Kanban completion? This specification was written after source reading and before the recorded run. No success criterion may be changed to fit a result.

## Boundary

Execute selected complete control-flow/SQL definitions manually transcribed from pinned `kanban_db.py` and `kanban_db_connect.py`. Comments/docstrings may be omitted. This is NOT execution of the full original modules; full-parent byte/AST fidelity has NOT been verified. Fixed selection hashes bind this local artifact only. Temporary on-disk SQLite is real, with separate connections, WAL and BEGIN IMMEDIATE. Schema is an explicit DDL projection, not the actual initialization/migration stack. `get_task`, TTL/default claimant, dangling-run check, profile/delegated-child guard, file-length guard, artifact helpers, hooks, recovery lane and post-commit fan-out/cleanup are explicit fixture bindings. No real worker, provider, dispatcher process, service, network or OS signal is run. File and network/process access are bounded.

## Expected discriminators

K01 normal: actual selected claim opens one run; matching completion persists done + ended/completed run + completed event, clears active pointer; duplicate completion returns False without another completed event. Reopen a DB connection for readback.
K02 contested claim: two threads with independent SQLite connections released by a barrier attempt the same ready task. Exactly one claim returns a task, one returns None; exactly one run and claimed event. Threads are not HERMES workers and this is not multiprocess/distributed-lock verification.
K03 stale completion: actual selected manual reclaim (synthetic no-process termination) closes run A, selected claim opens B. Completion with expected A returns False and preserves B byte-for-field; completion B succeeds. One completed event only.
K04 dependencies: an unfinished parent prevents selected claim and demotes manually-ready child to todo. A parent reopened after successful claim prevents completion and leaves its run active. Parent mutation is a fixture SQL edit; the transition consumers are real selections.
K05 in-transaction failure: a fixture artifact-staging callback raises after task UPDATE. The original transaction wrapper rolls back task update; run remains open; no completion event. Removing the injected callback permits matching retry.
K06 post-commit failure: fixture recompute_ready raises after task/run/completion-event COMMIT. Caller sees exception but new connection sees done/closed/event. Retrying completion is False. This is a deliberately injected callback failure, not a claim of production incidence.
K07 optional guard boundary: passing expected_run_id=None deliberately exercises the operator-style path. With a live run it can complete without proving an expected ID at this low-level API. Not an exploit or evidence the tool handler omits the ID in a normal spawned worker.
K08 nested transaction: invoking selected complete under an outer transaction is rejected; no completion is committed. The separate allow_nested=True transaction path remains subordinate to outer rollback.

## Negative controls

Mutant omitting only the expected-run-ID SQL predicate must cause the K03 oracle to detect wrongful stale acceptance. Separate mutant replacing transaction rollback by COMMIT must make K05 detect a committed task change on a reported failure. Mutants never overwrite selected originals. Changed local selection bytes must be rejected by the actual pre-exec integrity guard. These controls do not prove full coverage, parent fidelity or independent replication.

Record exceptions and all outcomes, Python/SQLite version, identities, timestamp and fixture limits in RESULT.json. Keep original raw result unmodified. No previous suite rerun. No semantic work-quality or whole-product PASS claim.
