# Note35 — Connector imports, graph recall and recipient selection

**2026-09-22 · U15-C1 / Q05d1 · BOUNDED SOURCE ANSWER.** Fixed ECC target `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact ledger](../evidence/U15-C1-SOURCES.md), [MR36](../ROUND-U15-C.md), [STATE](../STATE.md). This is original-source reading, inspected test definitions and conditional inference, not a Rust/SQLite run, retrieval benchmark, installed-system validation or E10. U15-C's broader G2 responsibility remains open for the distinct Node recall/proximity consumer.

## 1. A real information-to-action connection

The Rust graph is not merely a dashboard decoration. A configured local connector imports records into SQLite; explicit graph commands query them; the assignment controller separately reads session-associated entities to help select an existing delegate:

`file/configuration → connector parser → entity upsert + observation → session-filtered records → lexical match → delegate choice → task-handoff message`.

A useful ordinary case is an imported note describing auth/callback work, associated with one eligible idle delegate. Its matching terms can favor that delegate over another clear idle delegate. This is a source-supported conditional operation, not an observed model using the note successfully. Actual assignment still checks direct-team membership, harness compatibility, lifecycle state and handoff backlog. It does not dispatch to every matching entity in the database. Sources: C-SYNC, S-GRAPH, M-USE, M-MATCH.

Two different consumers must remain distinct. `graph recall` ranks information for a caller. Assignment ranks eligible delegates using a smaller entity-only matching function. The handoff contains the task and ordinary routing context, not a package of the matched source passages. Information can therefore affect who receives work without that function supplying the information itself to the worker. Prior Note22 retains the recipient-consumption boundary; no universal absence of other host retrieval is inferred.

## 2. What the connector accepts and preserves

The dispatcher supports JSONL file/directory, Markdown file/directory and dotenv-file connectors. Configuration selects path and optional session/type defaults. An unknown connector, missing required path, invalid configured default session or propagated filesystem/store error fails the command. Directory paths are collected and sorted; recursion is selected explicitly. `--all` passes the limit separately to each connector and stops if one throws, rather than making a single global import transaction. Sources: C-SYNC/C-PARSE/C-CLI.

JSONL counts nonempty attempted records, including malformed or rejected records. A malformed line, missing effective type, empty name/summary or unresolved record-level session increments `skipped_records` and returns normally for that record. A configured default-session resolution failure instead propagates. Record-specific session/type fields can override defaults; an explicitly blank type can prevent fallback after trimming. These are input/import rules, not fact validation.

Accepted records first upsert an entity, then add a Normal, unpinned observation. Counters increase only after both return successfully. Repeated upserts are counted as operations, not newly created unique entities or independently corroborated facts. The body has no transaction spanning the file, both writes and the final checkpoint.

Markdown is a bounded structural projection, not semantic extraction. A heading and path/slug identify a section; its first nonempty body line supplies the short summary, while a longer bounded body and source line/path go into observation details. Headings and summaries are limited to160 characters and bodies to4000; truncation is by characters. The scanner does not model Markdown fences or full frontmatter semantics. These bounds make useful local notes manageable but do not preserve the entire source or its meaning automatically. C-TYPES/C-PARSE/C-TEXT.

The dotenv parser can exclude keys and suppress values; recognized secret-like key names are redacted, and copying other values requires `include_safe_values`. This is a key-name heuristic, not proof that every permitted value is non-sensitive. No real environment file or secret was read. Current provider availability or credentials are not verified by a record saying a key is configured.

## 3. Checkpoint means an import shortcut, not a resumable or validity-complete cursor

`connector_source_signature` uses file length and modification time. The checkpoint key is connector name plus displayed source path, and its stored value is that signature. It does not bind file content, resolved session, parser/configuration version or record-validity dependencies. S-CHECK/C-PARSE.

The checkpoint is written after a normal return only when `records_read < limit`. This avoids marking a limit-truncated file complete, a useful control. However, the next invocation opens the source from the beginning; no line offset or last imported record is saved.

**Conditional prefix case:** a fixed source has more nonempty records than the unchanged positive limit. Each invocation processes the same prefix and omits its tail. Directory traversal can similarly revisit an early large file and exhaust the budget before later files. At exactly the limit, even a completely consumed file is not checkpointed. A larger sufficient limit or a changed invocation can finish; this is not unavoidable starvation under all usage. No repeated-import execution was performed.

**Conditional skipped-record case:** a small file has a record referring to session A while A is absent. The record is skipped; because the file contains fewer records than the limit, its signature can still be checkpointed. Later making A available does not change the file signature, so another otherwise identical call can skip the whole file instead of reconsidering the record. Changing defaults or parser settings without changing the same name/path/signature has the analogous dependency problem. A `latest` default can resolve to another session while unchanged-file skipping still prevents rebinding. The report retains skipped counts on the first attempt; they are not a durable pending-record queue.

The status command counts checkpoint rows and reports their last write time. That is real operational history, not evidence that every source still exists, every record was accepted or the information remains true. Missing/removed records are not retracted by this connector loop; a vanished directory entry is simply not revisited, and prior graph/checkpoint rows can remain. Source-signature preservation and record validity are different conditions.

## 4. Shared entity identity can change the session seen by a consumer

`context_graph_entity_key` combines lowercased type and name with the trimmed path. Session, connector, project and source revision are not separate key components. Global deduplication can be intentional and useful for a shared object. But the entity carries one optional `session_id`, and conflict-update replaces it whenever the incoming session is non-null. Nonempty summary is replaced, metadata is replaced wholesale, and `updated_at` advances. The returned entity retains its identity. S-KEY/S-GRAPH/S-SCHEMA.

**Conditional reassociation:** A imports a file entity with a given type/name/path; B later imports the same key. The row can now belong to B for `list_context_entities(Some(B), ...)`, while A's filtered list no longer contains it. Old observations remain linked to the entity and may retain A in their own session field. Recall filters on the entity's session and gathers observations by entity, not by the observation's session. Shared records and per-session attribution therefore have different semantics.

This matters beyond a display: M-MATCH uses the filtered entity list for delegate selection. Under otherwise equal eligibility, a subsequent write can change the routing hint. Matching labels or imported descriptions do not certify demonstrated expertise. Relative paths shared across different projects can also share the same key; distinct paths or distinct names/types avoid that particular collision. No cross-tenant exploit, actual misrouting or model failure was executed. The session filter must not be misrepresented as an authenticated access-control boundary.

Schema foreign keys use `ON DELETE SET NULL` for graph session references. Removing a session need not erase its graph information; all-session lookup and session-scoped lookup can then have different visibility. That can be useful historical retention, but neither lifecycle nor current truth follows from mere persistence.

## 5. Recall and assignment look at different information

`recall_context_entities` first selects recent entities, with a candidate count of `clamp(limit * 12, 24, 512)`, then performs lexical matching and scoring. It does not first search the entire corpus for matching text. Matched fields include type/name/path/summary/metadata and the summaries of the latest four observations. Full observation `details` are not searched. S-GRAPH/S-RANK.

Consequences must be read with the bounds: an older relevant entity outside that candidate window is not considered. Information present only in a Markdown section's stored body can be absent from recall because the body is in details, not the short summary. An old pinned observation can remain stored while its text falls outside the four-summary matching window. Separate `graph observations` output sorts pinned observations first, so this is not a claim that the data cannot be read by any interface.

The score adds matched-term count, bounded relation/observation counts, maximum observation priority, a pinned bonus and entity recency. Relation types, direction, contradictory support and authority are not interpreted by that formula. A relation labeled supports and one labeled contradicts both contribute to a count. This is a relevance heuristic, not a truth or expertise score. A reimport can refresh entity time without new external evidence; automatic history backfill is a separate producer and is not fully audited in this unit.

Assignment's M-MATCH is narrower still: at most48 recent entities per eligible session; name/summary/path/metadata only; no observation text, graph traversal, priority or pinned bonus. Its tokenization differs from recall, including treatment of `/`. The returned match count ranks clear idle delegates; at capacity it ranks active delegates before checking the selected delegate's backlog. A high-match busy candidate can cause deferral even when a lower-match active candidate has an empty handoff queue. That conditional capacity policy is not a benchmark result.

Entity-read errors become an empty match list in this selector. Missing matching knowledge and unavailable graph data thus become the same score, although other team/store errors can still fail the operation. The actual handoff only explains ordinary reuse/spawn status, not an immutable source-linked rationale for the knowledge match. These distinctions prevent borrowing the richer recall scorer's guarantees for assignment.

## 6. Preserving an old pinned observation can break a new append's return

Observation compaction is a real retention mechanism. It groups duplicates by `(entity_id, observation_type, summary)`, prefers pinned rows, then newer time/id, and keeps12 unpinned observations per entity on the ordinary append path. Details and observation session are not in the duplicate key. Positive tests inspect bounded history, explicit pin/unpin and preservation of a distinct pinned note. S-OBS/S-COMPACT/S-TEST.

A consequential composition case follows from the append's exact order:

`insert new observation → save new row id → compact → query that new id`.

If an older pinned observation has the same entity/type/summary, a new unpinned connector observation loses the duplicate comparison and is deleted. The final query still requests the deleted new id rather than the retained one. `query_row` treats no returned row as an error; primary rusqlite documentation confirms that contract. This is a source-derived failure path, not a run of the Rust method. S-OBS/S-COMPACT; D-SQLITE/D-RUSQLITE.

The earlier entity upsert can already have changed attribution/summary/time. That effect is not rolled back when the append returns an error; the connector exits before writing its checkpoint or incrementing the successful-record counters. Earlier file imports can also remain. Retrying the same source can reach the same pinned duplicate again. Protecting the pinned row is not itself wrong; the mismatch is between compaction's surviving identity and the append caller's assumed identity. The inspected pin-preservation test uses different summaries and does not exercise this combined same-summary path; no claim is made about every upstream test.

## 7. Vault, Rust graph and Node view are not one memory contract

Note06's Vault preserves a structured Markdown memory document, scope, active/unreviewed status and diagnostics, with separate search/direct-read behavior. This connector accepts generic files and emits graph entities/observations under its own rules. The mere fact that both can read Markdown does not transfer Vault's status, target, integrity or governed-review guarantees into the graph. Configuring a generic Markdown connector over such files is not evidence of a lossless Vault adapter. No repository-wide absence of an explicit alternative bridge is claimed.

Note16 also establishes that the Node page scores its own imported snapshot, while a separate shortcut calls Rust recall. U15-C1 has now explained the Rust consumer, not thereby the Node algorithm or proximity engine. The latter is a genuine source responsibility, not just an unrun compatibility test. It is selected as U15-C2/Q05d2 before leaving G2. Detailed visualization, automatic history-projection variants and installed-model uptake remain materiality-based re-entry, not blanket certification.

## 8. Evidence, system contribution and standing

Core source reads cover the actual connector/CLI, graph schema/writers/checkpoints/compaction/recall, entity-key/scoring helpers and assignment/helper/handoff chain. Representative store test bodies cover same-session upsert/filter, observations, automatic retention, relevance ordering, pins and checkpoint summaries. Tests were inspected, not run; this unit did not recover every connector/assignment test, execute a model, ingest user data or create E10. Exact complete/partial and incidental ranges are in the ledger.

This adds an implemented knowledge-to-routing edge to Note33: a stored representation really can affect an assignment. It also shows why import completion, shared identity, retention, retrieval inclusion, routing and eventual model uptake are separate. It does not establish an accepted-current-knowledge engine or a complete semantic memory system, nor prescribe SOUL components.

Q05d1 has this bounded Rust source answer. Q05d remains PARTIAL until the separately selected Node consumer slice is assessed; Q05d3 and earlier Q05b/c preserve stronger identity/validity/privacy/concurrency/runtime/efficacy questions. Publication is governed by STATE, not by this file's existence. Original evidence and E06 exclusion remain unchanged.
