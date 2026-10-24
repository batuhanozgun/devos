# U15-C1 — Connector, graph and actual-use source ledger

**2026-09-22 · Q05d1 / MR36.** Target `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. Research input `13211aa1a8abc78c59ec180aab13682fb27d7513`. [Note35](../notes/35-CONNECTOR-GRAPH-RECALL-AND-RECIPIENT-USE.md), [round](../ROUND-U15-C.md), [STATE](../STATE.md).

Evidence: selected original-source reading, inspected target test definitions, preserved prior study findings, primary API/SQL documentation and conditional inference. No target execution, Rust build, SQLite probe, user-data import, retrieval benchmark, live host/model, installation or E10. Read counts and file names are not completeness or efficacy scores.

## 1. Immutable source identities

| Code | Path at the fixed target | Git blob |
|---|---|---|
| C | `ecc2/src/main.rs` | `7c516684c178d050bc36d96d0481f812e9c48c07` |
| S | `ecc2/src/session/store.rs` | `f71bb3640991f9d471e2ab98dad54dff4d346721` |
| M | `ecc2/src/session/manager.rs` | `515235760adb242fe3b4bd1e8481c8b78aee5cc4` |

Immutable entries: [main](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/main.rs), [store](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/store.rs), [manager](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/ecc2/src/session/manager.rs).

All ranges below are inclusive upstream source lines, not the JSON connector's content line. A selected range may contain incidental functions; it is not a whole-file audit.

## 2. Load-bearing handles and actual reading

| Handle | Source/ranges acquired | Complete relevant bodies / explicit limit |
|---|---|---|
| C-TYPES | C1340–1430, preceded by1220–1340 | JSONL record defaults/fields, Markdown/dotenv section structures and160/4000/160 character limits. Adjacent migration/HTTP structs and bounded-file helper are incidental |
| C-SYNC | C2730–3040,3040–3420 | Session-id resolution; connector dispatcher and all-connectors loop; status report and connector description; JSONL file/directory/reader and Markdown file/directory/path methods. Remote arms and runtime-metrics helper are adjacent context |
| C-PARSE | C3410–3830 | Complete dotenv import continuation, import_memory_connector_record, path collection/sorting/recursion and source signature; dotenv/Markdown parser and section projection. Overlap with preceding range recovers the full dotenv sync body |
| C-TEXT | C3820–3955 | Heading slug, character truncation, dotenv assignment/value/filter/secret-key helpers. Adjacent message-building code is not a new messaging audit |
| C-CLI | C2340–2670 | Complete graph entity/list/observation/pin/compact/connector/recall/show/sync consumers. Structured output actually calls Rust methods; subsequent OTEL/stop/resume/messages/schedule material is incidental |
| S-SCHEMA | S1–360 | Store open with foreign keys, graph entity/relation/observation/checkpoint schema and retention constant12. Other schema and daemon-activity helpers are context, not a new full migration audit |
| S-GRAPH | S2990–3390 | Full entity upsert/list, recall and entity-detail queries. History-backfill wrapper is visible but its projection callees are not fully followed here |
| S-OBS | S3380–3590 | Complete add_context_observation continuation, pin update, public compact wrapper, session-observation wrapper and observation listing. Insertion→compaction→new-id lookup is read as one chain |
| S-CHECK | S3380–3590 | Full unchanged-source predicate, checkpoint upsert and summary reader; actual key/signature semantics, not an imagined cursor |
| S-COMPACT | S3580–3740, signature/opening in preceding range | Complete duplicate and overflow deletion, retained-count return; relation upsert also read. Final list-relations tail is not part of the closure claim |
| S-KEY / S-RANK | S4970–5310 | Complete row maps, recall tokenization/matching/score and context_graph_entity_key. Adjacent remote/file/harness helpers incidental |
| M-MATCH | M2630–2955 | Complete direct_delegate_sessions, selection key, graph match score/terms, tokenization; send_task_handoff completed by2940–3370. Creation/profile/merge-priority and pressure helpers are incidental |
| M-USE | M1450–1745,740–1150 | Complete assignment implementation including clear-idle/capacity/active/fallback branches; public assignment wrapper and actual inbox/backlog callers. Selected earlier lifecycle and later cleanup material not requalified |
| S-TEST | S6200–6620 and6600–7060, qualified below | Complete representative upsert/filter, add/list observation, automatic retention, recall ranking, distinct pinned preservation, pin toggle and checkpoint-summary test bodies were visible. No tests executed |

The actual receiver that turns knowledge into a consequential choice is M-USE→M-MATCH→S-GRAPH, followed by the handoff writer. C-CLI separately consumes the richer recall algorithm. No full TUI/Node/host-context closure is inferred from those paths.

## 3. Test-definition scope and uncovered counterparts

`upsert_and_filter_context_graph_entities` tests repeated same-session upsert and filters, not cross-session attribution. `add_and_list_context_observations` tests ordinary persistence. `add_context_observation_auto_compacts_entity_history` describes fourteen distinct additions retaining twelve. `recall_context_entities_ranks_matching_entities` uses a small candidate set and checks lexical, relation and pinned/priority ordering. It does not cover a relevant entity excluded by the recency preselection window or a match only in observation details.

`compact_context_graph_preserves_pinned_observations` uses distinct pinned and unpinned summaries, then checks retention. It does not combine an old pinned row with a new unpinned duplicate and the append's post-compaction new-id query. Pin/unpin tests cover the ordinary update path. `connector_checkpoint_summary_reports_synced_sources_and_timestamp` inserts checkpoints directly, rather than performing a bounded connector import or proving source validity.

The6200–6620 display clipped inside `compact_context_graph_prunes_duplicate_and_overflow_observations`;6600–7060 recovered its assertions but not the entire missing middle. That test is PARTIAL, not fully read. The latter display clipped near the final relation-detail test tail; that body is not credited as full coverage. Complete named tests above were visible through their returns. These are temporary-SQLite test definitions, not observed passing runs. No claim that every connector/assignment test or full suite was searched.

## 4. Incidental acquisition and failed access

Locating symbols in large files caused additional reads: M1–400,1150–1450,2940–3370 and3430–3810 include existing scheduling, profile, runtime, conflict and preview material; the preview function is only an opening fragment. S4550–4970,5500–5900,7350–7760 and8020–8480/EOF contain board, lifecycle, output, messages and harness-evaluation code/tests. Some responses clipped; these are not completed new-family audits. S9800–10030 and8500–8890 were empty out-of-range results, not empty source files.

Separate searches for graph_context_match_score and context_graph_entity_key returned index revision `bf70150eb2df8070024e5bdf08e4aa08959e2735`; they were discovery only. A combined query returned no hits and was not treated as absence. Every load-bearing body was subsequently fetched at8321021; no silent repin.

Auxiliary raw-source acquisition was unsuccessful: local urllib failed DNS, raw web access returned a cache miss, and download attempts were rejected. No original source file was acquired locally and no reconstructed source was executed. GitHub connector access remained sufficient for the source inquiry. Locating cost is recorded rather than counted as explanatory progress.

## 5. Narrow primary dependency contracts

Checked on2026-09-22, including a repeated focused check while preparing publication:

| Handle | Primary source | What it supports |
|---|---|---|
| D-SQLITE | [SQLite window functions](https://www.sqlite.org/windowfunctions.html), row_number/PARTITION BY/ORDER BY | The duplicate partition and ordering determine which row receives the retained rank; not a live SQLite execution |
| D-RUSQLITE | [rusqlite Connection](https://docs.rs/rusqlite/latest/rusqlite/struct.Connection.html#method.query_row), query_row contract | A no-row result is Err(QueryReturnedNoRows), unlike an explicitly optional query |

These are dated API/SQL-contract comparisons, not proof of the registry crate, built binary or an installed runtime. No dependency upgrade, package install, credentials or external model request occurred.

## 6. Claim-to-source and positive counterpart map

| Result | Load-bearing chain | Countercontrol / scope |
|---|---|---|
| Graph information affects delegate selection | C-SYNC→S-GRAPH→M-MATCH→M-USE | Actual team/harness/state/backlog eligibility; selection is not model uptake or certified expertise |
| Bounded import is not offset-based continuation | C-SYNC/C-PARSE→S-CHECK | Avoids checkpointing a limit-filled prefix; a sufficient larger limit can finish |
| Skipped dependency can be cached as unchanged | C-PARSE→S-CHECK | First report retains skipped count; configured-default failure differs from record-level skip |
| Global entity identity can move session-filtered association | S-KEY→S-GRAPH→M-MATCH | Shared identity can be deliberate; distinct keys avoid collision; not an ACL or live misrouting result |
| Retention, retrieval inclusion and ranking differ | S-GRAPH/S-RANK/S-OBS/S-COMPACT | Explicit observation listing can still retrieve retained pins; no universal data-inaccessibility claim |
| Pinned duplicate survives while append asks for deleted id | C-PARSE→S-OBS→S-COMPACT→D-RUSQLITE | Ordinary distinct or winning-new additions differ; error after earlier entity effect is not an atomic rollback |
| Vault and Node do not inherit this whole contract | Original Note06/Note16 plus C-CLI | Separate source responsibilities preserved; no global absence of custom adapters |

## 7. Prior recovery, split and standing

WHY was freshly read as1c9fc08bdc990dd5151c2590a58d7173aa91e26f; METHOD as7a6537b4a3d953c05c3671895a718ab41fd973ff with99–140/EOF tail recovery. Note06 was fully reread asfc1928ad7f13e650653ce1e8c078b293e437ca34; Note16 fully reread ascf8ee46f972057af3e1573caf870293a6d06a6d6. Those original notes remain source-grounded prior findings, not independent corroboration or a new execution. Current entries/Note33/34/coverage retain their recorded same-conversation reading at the unchanged input. Control loading is recorded in MR36 and is not ECC evidence.

U15-C1/Q05d1 answers the bounded Rust source-to-record-to-recall/recipient question. Existing G2 also names the distinct Node snapshot/recall/proximity consumer. It remains genuinely unread at the required joined depth, so U15-C is PARTIAL and U15-C2/Q05d2 is next. Start at Note16's exact ledger, `scripts/lib/control-pane/state.js`, `scripts/lib/agent-proximity/` and the actual caller/consumer; do not rerun Rust merely because its runtime guarantees remain open.

Q05d3 and original Q05b/c retain installed/config/source identity, valid/current knowledge, privacy, concurrency/durability, actual context exposure/uptake and effectiveness. Automatic history-projection, full parser variants, detailed TUI and other consumers require materiality-based re-entry before stronger claims, not blanket completion. E06 exclusion and all prior experiments/corrections remain unchanged.

Note35 was created at7be07aee6835e992750d5d0f347d9ed1940d43ab and fully read back in1–55/56–150 through EOF as08042362f4352d5440d5d5abd6881464ef0aba6d. This ledger precedes its own readback and final entry/receipt/STATE alignment. Publication claims require those actual subsequent checks.
