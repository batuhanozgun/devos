# U04 — Fixed pre-run diagnostic specification

Written 2026-09-11 after source inspection, before executing probe.py. Exploratory
mechanism discrimination; NOT a whole-product certification. Do not relax these
expectations after observing results. All model/judge responses are fixtures.

## Source and environment boundary

The complete `source/heartbeat.py` was materialized from the canonical pinned file;
its Git blob SHA MUST equal `d3f440d9ed2035505b0bdfbe7d6d57dec926317f` before execution.
Its clock and `_get_session_db` are replaced. Persistence adapter uses real temporary
SQLite key/value rows, NOT Hermes SessionDB/init/profiles/locks or a real gateway.

Kanban goal-loop and `goal_run_status` are explicit manual source selections from
pinned `goals.py` / `kanban_db.py`. Full-parent byte/AST fidelity is NOT verified.
They are joined through a real SQLite-backed task-status reader; task creation,
completion, ownership transfer and block writes are clearly labelled fixture SQL,
not tests of actual complete_task/claim_task. No process, network, credentials,
real goal judge, user-account operation or live external side effect is allowed.

## Discriminators

G01 existing completion: own run completed -> no judge and no extra turn.
G02 review handoff: old run review_requested with successor running -> review exit;
no old-run judge or extra turn. G03 reclaimed old run with successor running ->
superseded, no judge/turn. G04 judge done -> one finalize prompt; fixture completion
then observed on next status read. G05 two done verdicts without completion ->
one finalize turn then block. G06 wait -> continuation (not parking), bounded by
turn budget. G07 repeated parse-failure tuple -> no session-GoalManager 3-failure
threshold; stop at chosen 5-turn budget. G08 block callback returns False -> loop
still reports blocked_unachievable while database remains running. G09 callback
raises -> same local outcome with logged error and running database. G10 ownership
changes during judge -> exactly one extra harmless turn before next status check
returns superseded; successor must remain running. G11 status reader raises ->
stopped without judge/turn. G12 run_turn raises -> stopped with no completed receipt.

H01 first heartbeat not immediate, due at interval. H02 missed intervals coalesce
to one prompt; immediate second poll does not fire. H03 fresh manager restores
count/last-fire from temporary database. H04 pause blocks fire, resume reanchors.
H05 abandoned unstarted fire is rolled back and is due again. H06 intervening
persisted pause defeats abandon (newer state preserved). H07 injected set_meta
failure leaves live manager active while a fresh manager has no persisted record.
H08 normal migration copies child and clears parent; H09 selective child-write
failure lets helper return True and clear parent despite child absence. These are
controlled adapters/failures, NOT observed real SessionDB or production failures.

Negative controls: edited full-heartbeat bytes must fail actual pre-exec identity
check; removing selected run-identity branch must violate G03's zero-extra-turn
oracle; replacing Kanban wait conversion with early return must violate G06's
continuation-count oracle. Keep source originals and mutant outputs separate.

Record every observed result, assertions, raw callback trace, environment and input
hashes. Exceptions/assertion failures must remain in RESULT.json. No prior suite
is rerun or counted as independent corroboration. Local hashes for selections bind
local artifacts only. No semantic task-quality or final-delivery claims.
