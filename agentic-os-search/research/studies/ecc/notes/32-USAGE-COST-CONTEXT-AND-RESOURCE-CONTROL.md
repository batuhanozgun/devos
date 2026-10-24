# Note32 — Usage, cost, context and resource control

**2026-09-21 · U14-C / Q08c · bounded source answer.** Fixed ECC target 8321021c54d670126ce3b2969d5deb880b4b0c2a. [Exact sources and scopes](../evidence/U14-C-SOURCES.md), [MR33](../ROUND-U14-C.md), [STATE](../STATE.md). No target script/test/import, Rust build, live model/host, billed-spend query, installation or E10 was executed. Examples are source-derived counterparts, not operational incidents.

## 1. Native purpose and three connected but different paths

The resource family does more than describe a future capability. It contains actual transcript parsing, per-session records, a small shared metric file, user-facing rendering, model-facing warnings and a distinct Rust stopping controller. They are not one interchangeable budget service.

| Path | Producer → consumer | What it can establish at source scope |
|---|---|---|
| Estimated usage/cost | Stop → transcript/cost-cache → costs.jsonl → JavaScript metrics bridge → statusline/context monitor | A compact estimate and informational warning path |
| Context occupancy | Native statusline input → existing session bridge → context monitor → PostToolUse additionalContext | A reported context percentage can become model-facing advice |
| Rust resource control | Selected costs.jsonl → StateStore import → session metrics → TUI/CLI budget enforcement → recorded stop | Stored usage can affect actual process-control decisions |

The Stop registration calls run-with-flags under minimal/standard/strict profiles and is asynchronous. The cost script has no exported run function, so the wrapper's legacy subprocess path passes raw stdin and inherited environment. The PostToolUse dispatcher runs metrics bridge before context monitor, with independently selectable hooks. Statusline is separately configured; the provided JSON is a setup template, not proof of installed activation.

This separation is useful: a local estimate can support awareness without authorizing interruption, while a separate controller can enforce an explicit threshold. The research question is whether the meaning, identity, age and completeness of the metric survive those connections. Sources: C-REGISTER/C-RUNNER/C-WRITER/C-BRIDGE/C-MONITOR/C-STATUS/C-EXAMPLE and retained dispatcher/TUI bodies.

## 2. A cumulative row is correctly consumed in JavaScript and added again in Rust

The cost writer reads the available transcript, groups assistant usage by message.id, keeps the last usage for each ID and sums distinct messages. This is a real guard against counting one response repeatedly merely because its content occupies multiple transcript lines. Older entries without IDs retain per-line counting through synthetic keys.

Each Stop invocation then appends the whole current session total. The rows are cumulative snapshots, not newly incurred deltas. The JavaScript bridge explicitly honors this: it scans the complete file and keeps the last matching session row. Its test supplies cumulative rows and asserts that summing them would be incorrect. It also tests that a session's latest row is still found after other sessions push it beyond the former tail window.

The Rust importer uses another rule. It groups matching rows by session_id, adds every row's input/output tokens and estimated cost, and writes the resulting sum into sessions. It neither selects the last cumulative snapshot nor converts successive snapshots into deltas.

A minimal source-derived example:

| Available cumulative rows for S | JavaScript bridge | Rust imported value |
|---|---:|---:|
| cost3, then cost7 | 7 | 10 |
| token10, then token20 | 20 | 30 |

With a configured global cost limit10, zero other stored cost, a matching session identity/data file and an eligible active session, the Rust hard-budget predicate can become true although the latest represented cumulative estimate is7. This is not just a display difference: the enforcer calls the worktree-preserving stop path for selected Pending/Running/Idle sessions. Actual termination remains subject to the lifecycle limits established earlier; no early-stop incident was executed here.

Important countercases: one row produces no cumulative-overlap inflation; a separately implemented producer emitting genuine deltas would fit this SUM importer; and the JavaScript bridge already implements the cumulative contract correctly. Rereading the unchanged file does not keep adding the sum onto the prior database value: Rust recomputes and replaces it. The duplication comes from overlapping rows within the file, not from the number of import calls.

The broken connection is therefore specific: one producer's snapshot contract reaches a consumer that treats rows as independent increments. A local fix or test in one consumer does not make all consumers equivalent. Sources: C-WRITER/C-BRIDGE/C-STORE/C-ENFORCER; T-COST/T-BRIDGE.

## 3. Resource identity and budget scope are independent conditions

Cost writer, JavaScript bridge and context monitor choose sanitized JSON session_id before ECC_SESSION_ID and CLAUDE_SESSION_ID. Note31's tool-activity writer instead chooses the environment identity. If a native payload's session ID differs from the ECC registry ID, tool activity can be stored under the ECC label while cost goes under the native label.

Normal Rust setup does export environment IDs; that remains useful. But the built-in Claude command adds --name, while --session-id in the preceding wrapper belongs to ECC's own run-session command. The inspected cost importer performs an exact UPDATE WHERE id and does not translate identities. A row naming an absent session affects zero rows without a missing-session error. This contrasts with the foreign-key insertion failure in Note31's tool-log importer; do not copy that failure policy across mechanisms.

The writer's path is also selected through agent-data-home, while Rust derives metrics/costs.jsonl from the database directory. Matching IDs and paths form a working countercase; the files or labels can diverge under other settings. No installed host ID or path mismatch was measured.

Budget scope has another meaning. The enforcer sums metrics from every stored session, including terminal sessions, before selecting active sessions to pause. It is not automatically a daily allowance, a single-project allowance or an active-run-only counter. Removing a stored session can change that sum. Its token quantity is input_tokens plus output_tokens; the writer's cache-write/cache-read fields are not included by this importer. That is a concrete measurement definition, not a claim that all consumers should count every token category identically.

The global token/USD and active profile token checks are real. Profile max_budget_usd is not independently checked here; Note24 retains its separate native-flag versus advisory-text paths. Source control availability is not measured provider billing or a guaranteed no-overshoot quota. Sources: C-WRITER/C-BRIDGE/C-MONITOR/C-SHARED/C-STORE/C-ENFORCER, retained Config/data-home/shared-environment functions, Note24.

## 4. No usable measurement can become a new zero rather than an unknown

If the transcript is missing, unreadable or contains no accepted usage entries, and no accepted harness-cost cache is available, the writer can append a row with zero tokens/cost and model unknown. The timestamp records the new write. There is no separate completeness or availability field distinguishing this from observed zero usage.

C-BRIDGE correctly selects the last cumulative row, so this newer zero can replace an older positive total in its bridge. Missing/read-failed costs.jsonl also returns numeric zeros. The code does retain useful diagnostics: malformed lines are skipped, non-ENOENT read failures produce a breadcrumb, and repeated identical diagnostic conditions are deduplicated. Missing input before the first Stop is a legitimate quiet case. The weakness is not the absence of every error signal, but the consumer-visible number's failure to retain the distinction.

Rust behaves differently again. It skips malformed/type-invalid lines and updates only sessions represented by valid rows. Missing, empty or entirely skipped cost input therefore leaves previously stored values unchanged; it does not reset every session as the tool-activity importer does. A shorter file can lower totals for sessions still represented while leaving another session's old total untouched. Adding a valid zero row to an already populated cumulative file does not erase Rust's earlier summed rows.

The timing is also bounded. The configured writer runs at Stop, not at every token request. PostToolUse bridge reads may therefore see the preceding completed-turn estimate during an ongoing tool loop. Even if an external statusline updates a harness-cost cache, the bridge does not read that cache directly; the cost writer must consume it first. Current official hook documentation also allows transcript writes to lag the current conversation. These are reasons not to equate a fresh hook/bridge timestamp with current spend, not measurements of actual lag or loss.

TUI cost refresh retains the previously studied signature-before-success ordering and caught-error continuation; the CLI helper propagates import errors before its later checks. The same importer need not provide the same retry or freshness guarantee under every caller. Sources: C-WRITER/C-BRIDGE/C-STORE, retained TUI/CLI bodies; W-HOOKS.

## 5. The fallback estimate loses per-message model attribution

Transcript parsing keeps usage per message but retains only the last known model for the aggregate. The writer applies that model's rate table to all accumulated input/output/cache categories. In a transcript containing two differently priced models, this can differ from pricing each message under its own model. A single-model session with appropriate rates is an important normal case.

The source includes model matching rules and cache categories, including tests distinguishing some near-miss and legacy names. Those are meaningful implementation controls, not a current tariff audit. Model names, dated fixture IDs and numerical rate-table entries are pinned program data here; they do not establish that a model is currently offered or that the user's invoice uses those prices. Unknown names default to a rate family rather than producing an explicit unpriced state.

An optional harness-cost cache supplies a second estimate. Finite, nonnegative cost and timestamp/age checks reject several malformed or stale inputs; values more than300 seconds old or from the future are rejected. When accepted, this cost replaces the transcript estimate but token totals still come from the transcript. The stored row does not identify which source won or bind their accounting periods.

The built-in statusline does not write the advertised harness-cost cache or use native cost.total_cost_usd for its metric display; it reads bridge cost and writes context percentage. The cache contract is explicitly opt-in for another configured writer. Its tests manually create cache files, which demonstrates selection behavior rather than deployment of such a writer.

A further qualification comes from the official statusline contract: native total_cost_usd is itself a client-side estimate and may differ from billing. Source comments describing it as billed truth are therefore stronger than the documented field. A better estimate or preferred source is not automatically an invoice oracle. No billed amount, provider price validity, resumed-process behavior or external cache authority was tested. Sources: C-WRITER/C-STATUS/C-EXAMPLE; T-COST; W-STATUS.

## 6. Context freshness follows a shared activity clock, not the context observation

The statusline receives native remaining_percentage and can write it to an already existing bridge. It does not create that bridge, attach a context-observed-at timestamp, update last_timestamp or clear a previous value when the new native field is null/absent.

Metrics bridge reads the same object, increments its tool counter and updates last_timestamp on every tool, preserving context_remaining_pct. Context monitor decides that context is stale only when the shared last_timestamp is older than60 seconds.

This permits two different source-derived counterparts:

- An old remaining20 value persists without a new statusline sample. A later metrics-bridge call updates last_timestamp but leaves20 intact. Monitor now evaluates that old percentage as fresh. Existing warning dedup can suppress another emission; the finding concerns eligibility as current evidence, not a promise of repeated warnings.
- If metrics-bridge updates are disabled but statusline still writes a fresh percentage, last_timestamp can remain old. Monitor can discard the fresh context value as stale. This is conditional on that independently selectable configuration.

The normal case also exists: a recent bridge update and recent statusline sample represent the same current session adequately. The problem is the lack of per-field observation age, not that caching is intrinsically wrong.

The statusline's displayed bar has a separate denominator. It subtracts a fixed16.5-percentage-point buffer and renders adjusted used capacity, whereas monitor thresholds use raw remaining percentage. At raw remaining16.5, the adjusted bar can show100% used. That is not a proof that the native context window has no capacity. The constant is an ECC display convention here, not a verified current host compaction threshold.

Context occupancy says nothing by itself about whether the retained context contains the right knowledge or supports successful work. Sources: C-STATUS/C-BRIDGE/C-MONITOR; W-STATUS.

## 7. Atomic replacement protects file shape, not concurrent aggregate updates

Shared bridge writes use a unique PID/random temporary file and rename retry. This avoids two writers using the same temporary filename and preserves a useful replacement boundary. The code does not lock the whole read-modify-write sequence or condition replacement on the version read.

For example, metrics bridge and statusline can both read snapshot A. Metrics writes A with an incremented counter and newer cost. Statusline later writes its old A with a new context percentage, replacing those newer fields. The resulting JSON can be complete and readable while containing a lost update. Two concurrent tool hooks can similarly overwrite an increment. These are conditional interleavings, not executed concurrency or filesystem tests.

Whole-object integrity, logical update preservation and crash durability are distinct properties. Other controls, serialized execution or a sufficiently separated invocation sequence may avoid the interleaving; none is presumed universally absent. Sources: C-SHARED/C-BRIDGE/C-STATUS.

## 8. Actual warning output is not acknowledged delivery or a spending reservation

Monitor evaluates context pressure, estimated cost, modified-path scope and repeated tool fingerprints. Useful safeguards include skipping absent context, an explicit cost-warning toggle, severity ordering, top-two selection, tier-based dedup and re-emission on escalation. The bridge's Write/Edit/MultiEdit path counter is bounded and differs from Note31's broader touched-path count. Full command/change fingerprints avoid specific prefix/path collisions; a five-entry repeated-call window still measures repetition, not whether repetition is inappropriate or unproductive.

The output uses the host's additionalContext form and the real dispatcher can merge compatible contexts. Cost messages explicitly say they are informational, not an instruction to stop. The script does not reserve spending, terminate a process, save a handoff or verify a model's response to the advice. Its context message asks for a user decision; that is target guidance, not our research control layer.

Warning-state persistence occurs before the output is returned to the outer caller. A later output delivery failure can therefore leave the same tier suppressed on retry, subject to condition change or reset. Conversely, persistence failure is caught and may prevent the warning from being returned. Record-of-emission preparation and acknowledged receipt are not the same operation. No host delivery failure or model obedience result was observed.

These warnings and Rust stopping legitimately have different purposes. The defect is not that an informational notice fails to act like a hard gate; the important questions are whether its evidence is valid and whether a separate hard gate consumes the same metric contract. Sources: C-MONITOR/C-BRIDGE/C-SHARED, retained dispatcher; C-ENFORCER.

## 9. Evidence standing and return to the whole-system question

Six implementation/helper files and three test files were fully read, alongside the statusline setup example and selected registration/Rust bodies. Tests were not run. The tests exercise real local file/subprocess paths, message dedup, rate matching, cache choice, last cumulative row, diagnostic suppression and warning tiers. They do not bridge the writer to the Rust importer, validate real billed spend, execute the complete context-refresh sequence, or establish concurrent preservation merely by testing individual functions. Unread test families are not declared absent.

The bounded Q08c criterion is met through a concrete cumulative producer and two different consumers, actual stopping, and meaningful missingness/identity/estimation/freshness counterparts. A simulated live-provider run is unnecessary for these source conclusions. Q08c2 retains installed schema/cadence/path/identity, model/rate/cache provenance, observation ordering, concurrency/durability, warning uptake, effective stopping/overshoot and accepted outcomes.

The useful reusable mechanisms are message-level dedup, a consumer explicitly honoring cumulative totals, diagnostic breadcrumbs without repeated flooding, independent warning controls, selected severity/tier handling, unique-temp replacement, native context sampling and actual stored-budget enforcement. Their limitations are contract and lifecycle composition, not proof that all resource control is ineffective.

With the originally selected readiness, tool-activity and usage/context source slices now answered, the next selected work is U15-A/Q01a3: return to the existing family map and assemble the native working-system picture. Reconcile original notes and source coverage with unresolved families, identify genuine source gaps separately from stronger empirical claims, and produce a provisional responsibility/relationship map and justified remaining sequence. Do not keep opening another helper merely because one exists; do not declare whole-study closure from note count. Original evidence must be reopened when synthesis needs its conditions.

This is research consolidation within the authorized ECC inquiry, not SOUL/Development OS architecture, final CORE, exhaustive recursive coverage or whole-study acceptance. Those obligations remain visible in PLAN/QUESTIONS.
