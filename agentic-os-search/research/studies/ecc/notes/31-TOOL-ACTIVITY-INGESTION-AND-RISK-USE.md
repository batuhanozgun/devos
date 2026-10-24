# Note31 — Tool activity, ingestion and risk use

**2026-09-21 · U14-B / Q08b · bounded source answer.** Fixed ECC target8321021c54d670126ce3b2969d5deb880b4b0c2a. [Exact sources](../evidence/U14-B-SOURCES.md), [MR32](../ROUND-U14-B.md), [STATE](../STATE.md). No target hook/test/import, Rust build, live host/model, installation or E10 was executed. Countercases are source-derived, not witnessed incidents. Current official host documentation is a dated contract comparator, not the identity of an installed runtime.

## 1. A real signal chain, with different responsibilities

Unlike the local prerequisite rubric in Note30, this family actually contains an event writer, persistent input, importer and operator consumer:

`PostToolUse → synchronous dispatcher and hook profile → session-activity-tracker → metrics/tool-usage.jsonl → StateStore::sync_tool_activity_metrics → tool_log → TUI timeline/query`.

The dispatcher invokes the tracker for all tool names under standard/strict profiles. Global enable, individual disabled IDs, profile selection and dry-run are actual conditions. Its minimal-profile metric bridge is another producer, not the same tracker. The selected PostToolUseFailure group does not register this tracker; that is not an absence claim about every ECC failure observer.

Normal Rust harness setup exports ECC_SESSION_ID and CLAUDE_SESSION_ID, giving this writer a concrete way to correlate an ECC-created worker with an existing session row. The writer appends a local JSONL record, and the Rust TUI invokes the importer when its observed file signature changes. Stored tool entries are then queried for the timeline. These are implemented connections, not just similarly named features. The actual importer lives in StateStore, rather than in manager as the earlier handoff loosely described.

There are two distinct downstream uses. Tool logs provide reviewable summaries, parameters, duration fields and risk scores. Separately, typed file activity feeds conflict resolution, which can record an incident, stop a selected session and send a conflict message. A useful feedback path therefore exists, but its decision is not the risk module's SuggestedAction. Sources: T-HOOKS/T-DISPATCH/T-FLAGS/T-CAPTURE, R-MANAGER/R-STORE/R-TUI/R-RISK.

## 2. Native event identity and the recorded row are not identical

The tracker requires a tool_name plus a session identifier from ECC_SESSION_ID, falling back to CLAUDE_SESSION_ID. It does not use the JSON session_id field. A nonempty environment hook-event name other than PostToolUse is rejected; an absent event-name environment variable does not by itself reject the row.

The current Claude hook reference describes a successful-tool payload with tool_response, session_id, tool_use_id and optional duration_ms. The pinned tracker consumes tool_output, generates its own time/random ID and sets duration_ms to zero. The followed dispatcher forwards raw input without translating these fields.

Consequently, when a documented native payload reaches this exact route with a valid environment session ID but without an additional tool_output field, an event can still be recorded while its output_summary is empty. An available native duration is not preserved; zero here is a placeholder, not a measured instantaneous tool call. When environment IDs are absent, a JSON session_id alone does not save the row. These are interface-conditioned source results; no installed Claude invocation was tested. Normal ECC launch explicitly supplies the environment IDs, so it would be wrong to claim that ordinary ECC worker capture necessarily lacks correlation. A different adapter could also supply the tracker's expected schema.

A fresh random ID on each invocation makes distinct captured rows addressable. It does not identify a repeated delivery of the same underlying tool call: a repeated hook invocation can receive a different local ID even when native tool_use_id is unchanged. Conversely, rereading the same already-written row preserves its ID and can be deduplicated. Capture identity and storage replay identity are different scopes.

The tests exercise real subprocess/file paths but construct tool_output and environment-ID fixtures. Their nonempty-ID assertion does not compare repeated deliveries. They therefore validate useful local behavior without validating the complete native event contract. Sources: T-CAPTURE, T-DISPATCH, R-MANAGER shared environment, T-TEST; D-CLAUDE.

## 3. The same filename does not guarantee a shared data source

T-CAPTURE writes below getClaudeDir(), which now delegates to the cross-harness agent-data-home resolver. That resolver considers explicit ECC_AGENT_DATA_HOME, an allowed project configuration and host-sensitive defaults. The historical comment naming ~/.claude is not the complete current path-selection contract.

Rust Config::tool_activity_metrics_path derives its path from the parent directory of db_path, then appends metrics/tool-usage.jsonl. The actual shared harness environment function exports session/project identifiers but does not pass this DB-derived metrics path to the writer.

Matching configurations can produce a functioning shared file. Moving only the database, or selecting a different agent data root without the corresponding reader alignment, can instead make the writer append to A while the importer looks for B. If B is absent, the importer returns successfully without changing metrics. No file content corruption is needed for this particular non-observation path. It is conditional on the selected locations; not every installation is mismatched.

The project-path resolver has restrictions and calls a trusted-root helper. This inquiry follows its selection role rather than certifying that helper's entire security behavior. Explicit scope configuration is useful, but correlation labels and common basenames are not a substitute for producer/consumer path correspondence. Sources: T-UTIL/T-HOME, R-CFG, R-MANAGER, R-STORE.

## 4. Stored history and current-file counters follow different rules

The importer rereads the JSONL file from the beginning. It skips empty lines, malformed or type-invalid rows, and rows missing required identifiers. A per-pass set keeps the first occurrence of each event ID. It inserts valid rows using INSERT OR IGNORE into a table with a unique hook_event_id, providing a real duplicate-row guard across rereads.

After scanning, it replaces each session's tool_calls and files_changed metrics using aggregates from the currently readable file. It does not recompute those counters from the accumulated tool_log table. Every session is updated, including sessions not represented by any accepted current-file row.

| Input condition | Counter effect | Historical log effect |
|---|---|---|
| File absent | Return without recomputing counters | Existing log unchanged |
| File present and empty, or every row skipped | All session tool/file counters can become zero | Existing log is not deleted |
| File rotated/replaced with a shorter valid set | Counters reflect that current set | Previously stored records can remain |
| Same unchanged event rows replayed | Per-pass distinct rows are counted again as the current total | Unique hook IDs prevent duplicate log insertion |

Thus disappearing counters need not mean historical activity never happened, and retained counters after a missing file do not prove capture is current. The file's existence state changes semantics. No rotation or read-error experiment was run here.

files_changed counts unique nonempty file_paths from accepted rows, including paths supplied to a Read tool. It is not a count of verified modified files, committed changes or accepted deliverables. Typed file events can separately represent read/create/modify/move/delete/touch. The distinction matters because consumers use different representations for different decisions.

An ignored duplicate insert does not stop subsequent per-pass aggregation and file-event projection. If an existing ID is rewritten with different content, the stored log can retain its first version while counters and further projections use the newly read row. This is a conditional mutability boundary, not evidence that normal capture rewrites IDs. Graph helper internals are not fully closed by observing the call.

The direct Rust record_tool_call path also differs: it inserts a log without a hook-event identity and increments the counter. A later JSONL aggregate replacement can change that counter independently of those direct log entries. One common tool_calls field does not imply one universal measurement producer. Sources: R-STORE importer/schema/direct log/query, R-MANAGER record/query.

## 5. Deleting a session can obstruct later imports

A particularly material lifecycle counterpart joins otherwise reasonable operations. The store enables foreign-key enforcement, and each tool_log row must reference an existing session. A successful delete_session removes that session's log rows and then the session, but does not remove the historical JSONL row.

On a later full-file scan, that old row is no longer a duplicate in tool_log. Reinserting it now refers to an absent session. SQLite's documented IGNORE policy does not suppress a foreign-key violation. The propagated error can abort import at that line, before later sessions' events and before the final counter-replacement loop.

The conditions are explicit: deletion must succeed, the event must remain in the selected JSONL, the session must still be absent, and import must reach that row. An unknown session event from another producer or database can reach the same missing-parent condition. This is not a claim that every session deletion succeeds or that every duplicate necessarily causes an error.

There is no enclosing transaction around the whole import. Earlier row insertions and projections may already exist when a later line fails. Consequently the returned error is neither a guarantee of no effect nor a complete import. Keeping referential integrity is a real protection; leaving stale source records and treating one unknown parent as a whole-pass error creates the continuation issue. Sources: R-STORE open/schema/importer/delete_session; D-SQLITE.

### Attempted import versus successfully consumed file

The TUI compares a metrics-file signature with its cached signature. When different, it stores the new signature first and then attempts ingestion. Errors are logged, but the cached signature is not restored. If the source signature remains unchanged, subsequent ticks need not retry the failed import, even if a transient database failure or missing-parent condition has been repaired only in the database.

A source change, a suitable TUI restart or another explicit importer caller can change that situation; the finding is not permanent unrecoverability. The exact signature helper implementation and every possible recheck trigger were not audited. The observed ordering alone distinguishes 'this file was attempted' from 'this file was successfully consumed'.

The TUI also continues to heartbeat, budget and conflict enforcement after caught metric-import failures. Those controls can therefore inspect old or partially updated stored state. The CLI helper instead propagates import failure before its later heartbeat/budget calls. Different callers do not provide the same recovery or freshness policy merely because they share the importer. Sources: R-TUI sync_runtime_metrics/sync_from_store, R-CLI sync_runtime_session_metrics.

## 6. Risk classification is not pre-action authorization

ToolCallEvent::compute_risk adds fixed, explicit contributions from tool type and literal input-summary patterns for sensitive surfaces, broad effects and difficult-to-reverse operations. It bounds the score and computes a suggested allow/review/confirmation/block action. This is interpretable heuristic classification, not a calibrated probability of harm.

The importer supplies the sanitized and truncated input_summary, not the full command, parameter JSON, output or independently verified effect. For Bash this is a bounded command summary; for file tools it often emphasizes paths. Relevant material beyond the retained prefix can be absent from scoring, while an indicative word can appear without the described effect. Redaction/truncation protects some data and controls size, but also changes the risk classifier's evidence.

Only the resulting score is persisted by this import; reasons and SuggestedAction are not used to admit or prevent the already reported tool call. The observed PostToolUse path is after execution under the documented host contract. A test asserting SuggestedAction::Block validates classification output, not a prevented operation. No general absence of ECC's separate pre-action guards is inferred.

The separate file-conflict controller is a stronger actual effect consumer: for relevant active sessions it takes recent typed activity, groups exact path strings, excludes reads, chooses a configured strategy, records an incident and stops a selected session without worktree cleanup. It then writes decision/message records. Its Merge strategy queues manual review; LastWriteWins selects which session remains active rather than proving a merged file outcome. None of these decisions is driven by the numerical risk suggestion.

This establishes a useful connected but heterogeneous system: retrospective risk review and file-activity-based control coexist. Their classification, identity, time window, stopping and accepted-result guarantees remain different. Sources: R-RISK, R-STORE, R-MANAGER conflict functions, R-TUI; D-CLAUDE.

## 7. Sanitation of one representation does not sanitize later enrichment

The writer implements actual selected-secret redaction and length/depth limits for summaries and parameter JSON. Input-derived edit/write previews pass through related sanitizers. Those are useful controls, not empty labels.

For tracked files, however, enrichment can replace these previews with selected raw lines from git diff. The retained patch lines and derived before/after summary are not passed through the same redaction before the final event is appended. If a tracked working-tree diff contains sensitive text in those retained lines, that text can enter the log despite sanitized input fields. The importer persists the event previews without adding that sanitation step. No real secret was accessed or logged by this research.

The Git comparison also describes the working tree relative to the index, not necessarily only this one tool call. Prior uncommitted modifications can contribute to the preview. It can correctly distinguish modifying a tracked file from creating a new one, while still not proving causal attribution of every displayed line to the event. Tests use genuine temporary Git repositories for tracked Write/Delete/nested-path behavior; their separate redaction case uses input summaries/params rather than a sensitive Git-diff fixture. Sources: T-CAPTURE, T-TEST, R-STORE.

## 8. The timeline is a real consumer, not a complete execution archive

ToolLogger/query_tool_logs preserve structured records and paginated queries. The TUI timeline requests the latest128 tool entries per selected session, then applies timestamp parsing and visible filters. That code actually renders tool name, duration and input summary; the recorded placeholders and omissions therefore have downstream meaning.

Import preserves a nonempty timestamp without validation, while this timeline omits entries whose timestamp cannot be parsed. The direct logger uses its own current time. File-event queries have another malformed-time fallback. Stored presence, visible presence and a correct event clock remain separate. Query failures become an empty tool list in this timeline branch; no end-to-end completeness verdict is produced.

The existence of an operator view does not prove an agent consumed the information or that a task was accepted. Nevertheless, the source path now shows more than a disconnected counter: capture, persistent import, actual query and a separate control consumer are identified, with where information is dropped or reinterpreted made explicit. Sources: R-STORE/R-RISK/R-TUI.

## 9. Standing, method and next responsibility

Full reads cover tracker, dispatcher, flag selector, agent-data resolver, tracker test and risk module including its tests. Store/manager/config/TUI/main/helper reads are explicitly selected in the ledger. Tests were inspected, not run; no E10 or live host/model was used. The source/contract contrasts answer the original bounded question without a simulated production incident. No general safety, complete capture, privacy certification or false-result rate is established.

The method's useful contribution is joining lifecycle and representation boundaries: normal environment correlation constrains a missing-ID critique; unique row IDs do not prove native-event idempotence; referential integrity can coexist with stalled replay; attempted-file caching differs from successful consumption; and real conflict control prevents calling all telemetry passive. Navigation overhead and failed optional source-byte acquisition are recorded rather than treated as research evidence.

Q08b is source-complete; Q08b2 retains installed host/schema/path conformance, complete capture/privacy, repeated-native-event identity, transaction/retry/concurrency and measured risk/latency/effectiveness. Full graph projection and every other observer remain outside this bounded closure. Original experiments and stronger prior questions are unchanged; this is candidate reuse, not adopted SOUL/Development OS architecture.

Next selected after verified publication: **U14-C / Q08c — usage/cost/context evidence and resource-control consumers**. Begin with cost-tracker.js, ecc-metrics-bridge.js and ecc-context-monitor.js, then their actual import/enforcement and warning consumers. The bodies of those producers have not been read here. Whole native synthesis/CORE, remaining material variants and final omission/project evaluation remain open.
