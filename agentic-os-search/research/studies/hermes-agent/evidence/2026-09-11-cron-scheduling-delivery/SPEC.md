# U07 — Cron delivery queue boundary diagnostic — SPEC (before run)

Date: 2026-09-11. Pinned upstream: NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a.
Subject: the complete, unmodified cron/delivery_queue.py, Git blob 689fd620d6193003bbd168a0e62770a0d0306ac6 (13,837 bytes).

## Scope and oracle

Use the real module's enqueue, claim, wait-timeout, drain, finish, recovery, pruning and SQLite transactions. Use fresh temporary SQLite databases, the actual Python sqlite3 driver and WAL mode. No replacement of these methods or SQL in the ordinary cases. No Hermes product installation, actual SessionDB, GatewayRunner, provider/model, network send, subprocess, cross-process concurrency, process restart, OS crash or real credential use.

Six explicit dependency seams: isolated home path; UTC wall clock; fresh-schema column-existence assertion (not a migration); standard SQLite WAL pragma (not upstream fallback); identity redaction of synthetic error text (not redaction verification); synthetic process start tag with foreign-owner checks forbidden. The transport callback is synthetic; callback invocation is not external delivery. Each case has an independent DB. Timeout=0 selects the actual deadline-expired branch without waiting 300 seconds; this does not verify default-duration timing.

Before any ordinary import, enforce both original Git blob identity and SHA-256. Each case records direct database snapshots and actual return values, not only PASS. Save final database snapshots and stdout/stderr. Expectations below are fixed before execution; failures must be retained, not reclassified away.

## Cases

| ID | Setup/action | Predeclared discriminator |
|---|---|---|
| D01 | enqueue_and_wait(..., timeout=0), no consumer | Return None; actual DB row stays pending with payload; zero transport callbacks. No-error is therefore insufficient to infer delivered. |
| D02 | Actual pending row, then drain with recording callback returning None; re-enqueue same execution with changed payload, drain again | Exactly one callback with original payload; first drain count 1, second 0; terminal delivered and payload redacted; repeated enqueue must not replace or resend. |
| D03 | enqueue; claim_next; deadline-expired enqueue_and_wait; late _finish(error=None) | Claimed row becomes unknown; timeout returns nonempty error; late finish False; row cannot be promoted to delivered; no pending retry. This is a claim-before-send synthetic schedule, not an OS crash. |
| D04 | delivered row; set MAX_TERMINAL_DELIVERIES=0; prune; re-enqueue same execution | Terminal tombstone survives removal of full row; repeat returns delivered; no pending claim/callback. |
| D05 | drain callback raises RuntimeError with synthetic text | drain returns processed count 1 while DB status failed; error stored and payload cleared; next drain count 0. Processed count is not successful delivery count. |
| D06 | SQLite trigger aborts UPDATE to delivered/failed; drain callback returns None; recover_abandoned and drain | First drain raises sqlite3.IntegrityError after one callback; durable row remains delivering and local active marker is cleared; recovery marks unknown without a second callback; later drain 0. Real injected SQLite write fault, not actual filesystem failure or Gateway crash. |

## Negative controls

N00: change one source byte; ordinary loader must reject before import.
N01: explicit mutant changes pending-timeout empty-error return into an error; D01 must fail.
N02: explicit mutant removes delivering-state condition from _finish; D03 must fail on late terminal rewrite.
Mutants are diagnostic inputs only, never upstream modifications. Mutant imports are explicitly labelled, hash logged, and use the same case oracle. No claim of independent replication or global test coverage.

## Interpretation boundary

Only the queue module is executed. Connecting the observed no-error/pending case to scheduler_delivery._deliver_result and scheduler._classify_delivery_outcome is a separately labelled source-level inference; those enclosing modules are not run. SQLite here is the cron queue's own store, not Hermes SessionDB. Previous U04/U05/U06 evidence and open validation debts remain unchanged.
