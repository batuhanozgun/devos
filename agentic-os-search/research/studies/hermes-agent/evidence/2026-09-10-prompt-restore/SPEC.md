# U01-M4 — memory apply and selected prompt restoration

2026-09-10. Source-informed, exploratory specification fixed before the recorded run. This is NOT full CLI, gateway, compression, prepared-request or provider execution.

## Object and boundary

Use the previously archived five full M2 modules with their exact pinned Git identities. Reuse the existing M2 probe's setup/helpers ONLY, not its N01–N12 cases. Execute manually transcribed complete selected definitions from conversation_loop.py and system_prompt.py. A fixed local hash binds the transcriptions used; it DOES NOT prove full-parent byte fidelity. Source parent identities and retrieved ranges are recorded separately.

Actual file operations, MemoryStore, memory tool, pending gate/replay/common approval, provenance and the selected restore/identity/invalidation/memory-parts bodies are exercised. Agent, reduced prompt builder, session DB, runtime cwd, Bot Chat probe responses, lifecycle/credits/tool-prefix callbacks and restoration observers are synthetic. M2 configuration, scanner and atomic-write helper remain synthetic. No application install, credentials, external service or model call. Block network creation during the run.

Endpoint: selected cached system-prompt text and disk/live/frozen/DB states. No fabricated request assembly. Selected invalidate→restore and explicit build→persist compositions are harness-controlled sequences, not asserted production compression call order.

## Pre-recorded discriminating expectations

V01: after approved replace, disk and live store are new while its frozen view is old; a separately reloaded store is new. With compatible old DB prompt and history, selected restore chooses old prompt without the reduced builder.
V02: empty history, null stored prompt or injected DB-read failure chooses fresh reduced build from a new snapshot. These are recovery alternatives to V01, not claims about actual session creation.
V03: model/provider/cwd/platform mismatch in the stored prompt selects fresh build. Mere memory change does not participate in that compatibility helper.
V04: reload alone does not alter cached prompt. Actual selected invalidation reloads/clears the agent fields but does not edit the synthetic DB; calling restore next can select its old prompt. Explicit reduced build plus selected persist updates DB, and a later compatible restore selects the new text. This is not a compression-defect verdict.
V05: approved removal empties the memory file; a new store formats no memory block, while compatible persisted prompt can retain the deleted marker. A controlled rebuild without that stored prompt removes it.
V06: injected pre-commit writer failure produces failed approval, retains pending and old disk, can leave live store changed; selected invalidation reloads old disk before restoration. The old M2 failure is reused as a new selector integration condition, not claimed as a newly discovered memory bug.
V07: injected DB-read AND DB-write failures can produce fresh cached text while retaining old DB text; with those fake failures removed, a later compatible restore can select old DB text. No actual SQLite durability claim.
V08: a controlled positive capability-stale response enters rebuild; an exception in the synthetic capability probe enters its reuse fallback. Real Bot Chat capability detection is not tested.

## Falsification and identity controls

A mutated full upstream source must be rejected by the reused actual pre-import hash guard. A changed local selection must fail its fixed selection hash before exec. The second check only binds our artifact.

A deliberately altered selected runtime comparator that always returns True must break V03's model-mismatch oracle; one that always returns False must break V01's restore/no-builder oracle. Mutants stay separate from the canonical selection files. Expected states/marker membership are defined independently of the resulting function returns.

Store every case's observations, exceptions and failed expectations; do not discard a failing case or alter thresholds after seeing it. Operational harness fixes require a separate log and fresh rerun. Original result files must not be overwritten. This is same-investigator evidence, not independent corroboration or a product PASS score.
