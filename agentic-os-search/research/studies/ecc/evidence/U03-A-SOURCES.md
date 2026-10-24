# U03-A — Source, execution and discovery ledger

**Date:** 2026-09-17. **Pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. IDs continue [U02-A](U02-A-SOURCES.md). [Primary source root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Every listed body was fetched from that pin; FULL means through EOF, not dependency or runtime closure.

| ID | Pinned path/object | Blob identity | Coverage / role |
|---|---|---|---|
| S56 | `scripts/sessions-cli.js` | `173e68d4c29549085ed5eaefff7bab2b14cddb3f` | FULL, 1–260 reaches EOF; SQLite query/print, no session dispatch |
| S57 | `scripts/work-items.js` | `6c9d01aa3a3d4e7da60e0071f3e21eb1e6dd9e50` | FULL, 1–260 + 261–560 reaches EOF; CLI upsert/close/claim and limited GitHub import |
| S58 | `scripts/lib/state-store/queries.js` | `0225f476182ab68c77285d1e2f398637b7c20bbc` | FULL, 1–280, 281–580, 581–920, 921–1100 reaches EOF; normalization, SQL writes/joins, activity and attention summaries |
| S59 | `scripts/lib/control-pane/work-item-mutations.js` | `c82a26196432b1cc0a95aee023354fe285c9bbdd` | FULL; also LOCAL EXECUTION in E02 using exact 3588-byte source and a store double |
| S60 | `scripts/session-inspect.js` | `e166c8efe2667a19231aec9068ae0f77890291bd` | FULL; adapter inspection and optional output write; imported skill-loop bodies NOT READ |
| S61 | `scripts/lib/session-adapters/registry.js` | `bac7434f0560e162deba968a79fcf249b350e259` | FULL; four adapter routes and dependency injection; imported adapter bodies not all read |
| S62 | `scripts/lib/session-adapters/dmux-tmux.js` | `40bd38991423bd2c5458a3a35403c9b6839aedfe` | FULL; collector→normalizer→default persistence. Raw collector body remains OPEN |
| S63 | `scripts/lib/session-adapters/canonical-session.js` | `0ef73efd0d131274a541e8016e43e35db06c4878` | FULL, 1–300, 301–620, 621–800 reaches EOF; schema, state/health mappings, writer selection and fallback history |
| S64 | `scripts/lib/state-store/schema.js` | `915e0481d3ff8d810573ef0f9f6bae8cb3151e76` | FULL; actual AJV schema loader/validator |
| S65 | `scripts/status.js` | `7f6404a12a278a22cd258f68c2437b0007924185` | FULL, 1–320 + 321–620 reaches EOF; query/readback, installation warning reconciliation and optional exit signal |
| S66 | `schemas/state-store.schema.json` | `70b0e9dc4727020cdbef190c804b5b3c4f09c015` | FULL; flat session contract, nonempty work-status string, nullable links |
| S67 | `tests/lib/session-adapters.test.js` | `40f5aa1f1571819827b49789945ea5eb34423326` | FULL TEST SOURCE, 1–260, 261–500, 501–800, 801–1100 reaches EOF; injected collectors/writers, fallback history, validation/error paths. NOT RUN |
| S68 | tests direct Git tree | `2e4ba12d4f37a6faaad81657c6fa0c2e2b33fb05` | FULL direct-child JSON listing through its closing bracket and truncated:false; duplicated tool metadata was truncated. No recursive/body coverage implied |
| S69 | `scripts/lib/state-store/migrations.js` | `7716c992589341e4db89a403139a2fd7db040894` | FULL; session/work/decision/skill table identities and FK relationships, migration transaction |

S53 (`state-store/index.js`, blob `49b6204d635330401ede6fd734c72f9588466f78`) was fully read in U02-A and remains available in this conversation. Its factory exports, foreign-key enabling and returned query API were compared with S63's writer-candidate contract. This is retained source evidence, not a new independent read or a working database test.

## Separate current external contract checks

- **W03:** [GitHub CLI gh pr list](https://cli.github.com/manual/gh_pr_list), observed 2026-09-17 through web search; selected `--limit` and list semantics. The flag is a maximum number fetched.
- **W04:** [GitHub CLI gh issue list](https://cli.github.com/manual/gh_issue_list), same date/selected scope. Same provider, not independent replication. Neither source proves an installed gh version or actual response completeness.

These moving manuals are not part of the pinned ECC corpus. No remote command was executed by the study.

## New local evidence

[E02 README](u03-a-work-item-probe/README.md), [plan](u03-a-work-item-probe/PROBE-PLAN.json), [runner](u03-a-work-item-probe/run-probe.js), [raw results](u03-a-work-item-probe/RESULTS.json). Source bytes were materialized from the connector response and matched the original Git blob before execution. All six pre-execution source-informed criteria matched: baseline assignment; blocked pickup; explicit reassignment; done refusal with zero writes; reopening by lane move; priority scope limited to the returned 100 rows.

This is LOCAL EXECUTION of S59 with an in-memory store double. No SQLite, real work board, network, provider CLI, agent, credentials, user configuration or concurrency test. Synthetic blockedBy metadata is not a newly discovered ECC schema contract. Criteria matches are not product safety passes. U01-A E01 was not rerun.

## Claim and dependency coverage

- Local work production/claim/query/status: S57–S59, S64–S66, S69; E02 exercises only S59.
- Limited-list closure and import overwriting local owner/status: S57 + S58; W03/W04 qualify the external list bound. SOURCE-DERIVED, NOT EXECUTED.
- Default session recording versus SQLite reader: S60–S63 + retained S53 + S56/S58/S66; S67 tests inspected only. No global absence of other ingestion routes inferred.
- Stored activity/readiness versus actual control: S58/S65; exact collector and launcher remain next-unit work.

## Discovery, freshness and operational limits

Connector searches run on the default branch and returned paths at `bb1c58a35065f3c15995489826b8837d71643304`, a different ref from the research pin. Results served only to discover paths. All load-bearing bodies were re-fetched at the original pin; current-main behavior and the intervening diff were NOT revalidated, and no repin occurred. Search misses, including upsertSession callers, are not repository-wide absence evidence.

The previous five-file state-store subtree now has all five bodies read across U02-A/U03-A (index/projection earlier, queries/schema/migrations now). This is one bounded directory milestone, not full ECC coverage or SQL runtime verification. The new tests direct listing exposes child trees: ci `43a0a2b9179b38630233b9e2dd62c60de4b30d19`; commands `a1572c8693f50db049ee33f23f8ae5822fff0089`; docker `938cc86fe97754b3512a7efb03cb59d6d85ed8cc`; docs `35ff5eb1d45b0191581643c75216dfea279305cb`; fixtures `d636a2156aca629ab97f8dd18ba89c9eaa21c05d`; hooks `384bf7418008a8b044dc3c58a441998f89094943`; integration `c8d8b756a0b5fb4a9b7c7dfd0a31e4bbb03585f7`; lib `3373da6c63b9bffdbd3d028a1687f0f0ecc586f3`; pi `f25bd4bbfe14bffe95e1a914e62850246b1e4014`; scripts `abf1d2172c32519c8c7cb8c0b8d8f748aabb9929`; skills `adf8588f8bf2097bb10506dd8c96695bc9fd24eb`. Their recursive contents are not marked read. Existing root frontier and Rust/native-workflow distinctions remain open.

Discovered next paths: `scripts/orchestrate-worktrees.js` appears in S67 fixtures; `scripts/lib/orchestration-session.js` is S62's actual import; `scripts/orchestration-status.js` and `scripts/lib/control-pane/server.js` were search-discovered, not body-read. GitHub coordination/epic surfaces and other adapters remain separate research obligations.

Auxiliary direct raw GitHub retrieval failed at DNS; connector reads worked. Offline Node v22.16.0 execution succeeded. Only the exact helper was materialized locally; there is no complete ECC checkout. Source acquisition, full reading, test inspection, local execution and live integration remain distinct.

Project input main was `2e6455b0967235ae59bc0d36182fbc8b7762c5e6`, unchanged since U02-A. Same-conversation canonical controls and full prior entry/note/source reads were retained; current WHY/INDEX/META and MR03 were recovered directly. The user's qualitative progress check did not close P1 or authorize a different phase. Actual publication belongs in PUBLICATION.
