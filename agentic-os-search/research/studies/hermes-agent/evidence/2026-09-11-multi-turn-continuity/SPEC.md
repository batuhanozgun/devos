# U04 — Multi-turn continuation diagnostic specification

2026-09-11. Written after pinned source inspection and before this slice's executions. Primary NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a. Question: what do the Kanban continuation loop and a session heartbeat actually consume, stop, or acknowledge?

## Boundaries

Kanban: execute the complete manually copied run_kanban_goal_loop function, with source-derived templates/status constants and deterministic callbacks. Selection hashes bind local bytes, not full-parent byte/AST equivalence. No model, worker process, dispatcher, actual Kanban DB, auxiliary provider, OS cancellation, account or service.

Heartbeat: attempt to materialize the full heartbeat.py and verify its Git blob identity against connector-returned d3f440d9ed2035505b0bdfbe7d6d57dec926317f before importing. If identity does not match, do not call it full-original execution. Its surrounding goals DB accessor will be replaced by an explicit temporary SQLite state_meta adapter; config/bootstrap/profile/gateway/CLI polling will not execute.

No previous Hermes suite will be rerun. Test histories and verdicts are synthetic; they test decision consumption, not semantic work quality. Reading an upstream test does not mean running it.

## Fixed discriminators

G01: already terminal done/blocked/review/changes_requested returns the corresponding outcome without judging or running another turn.
G02: continue, then judge done, then worker terminal: continuation and finalize nudge are distinct; only subsequent task status yields completed_by_worker.
G03: max_turns=1 consumes the first response's unit, blocks on exhaustion and invokes no additional turn.
G04: a block callback returning False or raising may leave external state running while the loop returns blocked_budget; record outcome separately from the callback effect.
G05: superseded at the status boundary stops before another judge or turn.
G06: ownership changes during a judge call returning continue; the loop can invoke one subsequent callback before the next status read notices superseded. This is a controlled callback interleaving, not actual stale external work or an end-to-end security exploit.
G07: wait verdict is converted to continue, with no parking barrier in this Kanban helper.
G08: parse/transport failure flags accompanying continue do not supply separate early-pause counters to this helper; finite turn budget remains the backstop.
G09: judge done twice without worker terminal transition gives one finalize nudge and then a block attempt.
G10: status-reader failure or run callback exception yields stopped; no invented successful completion.

H01: full module normal set/load/due: missed intervals coalesce to one fire, not a replay backlog; reload observes the persisted anchor/count.
H02: pause prevents fire; resume reanchors; clear removes the active view.
H03: abandon rewinds an unstarted fire when persisted identity still matches, but a later persisted pause wins.
H04: injected set_meta failure can leave live state advanced while a freshly loaded manager sees the old stored anchor/count. The adapter injects the failure; this is not a measured production failure rate.
H05: two managers loaded before the first fire are not a cross-manager atomic-claim mechanism; record each call and durable result separately. Driver-level serialisation remains outside the test.

## Negative controls and verdict

The fixed G05 oracle must reject a mutant which allows superseded status through the initial guard. The G09 oracle must reject removal of the repeated-finalization guard. A one-byte-changed full heartbeat file must be rejected by the source-identity loader. Mutants remain separate; source originals are not rewritten. These controls are not independent replication or full coverage.

Keep stdout/stderr, timestamps, input hashes, expected versus observed states and fixture descriptions. Report an unexpected result rather than weakening a criterion. Failures due to test setup must remain visible with any correction documented and re-executed. A Git blob alone is not publication: final main ref and artifact readback remain required.
