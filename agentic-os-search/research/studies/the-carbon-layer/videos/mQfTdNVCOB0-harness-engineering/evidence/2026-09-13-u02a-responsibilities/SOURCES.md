# U02-A — Source recovery and reading coverage

**Date:** 2026-09-13. **Input main:** `ead0d6775bd49808afbf496292f526cae1fb20df`. **Object:** video responsibilities 1–6, grounded in selected primary contracts and engineering mechanisms. This is not a source-code audit of every named product. It extends, rather than rewrites, the earlier source ledgers.

## Original and derivative media

**V01:** https://www.youtube.com/watch?v=mQfTdNVCOB0 . Original local video-only MP4 and audio-only WebM were present and rehashed. Both matched the byte counts and SHA-256 values in the unchanged [original manifest](../MEDIA-MANIFEST.json). Exact identities and new sample times: [U02-A media record](MEDIA-READING.json). No media was sent to a transcription service.

Twelve frames were extracted at 280, 340, 400, 480, 530, 580, 675, 740, 805, 845, 920 and 950 seconds, scaled to width 1280 and visually inspected on three contact sheets. They support the six chapter identities and limited visual/caption details. Six timestamps overlap U00's samples; these are not 26 unique frames when the two unit counts are added. Neither set establishes continuous video viewing.

The audio file was reidentified, not listened to end-to-end or newly transcribed. Native YouTube caption recovery still failed through the available direct page access. Embedded captions remain another representation, not automatically an exact audio transcript. At 15:20 the visible caption includes confidence table whereas the derivative text is less complete; this narrows one representation discrepancy without closing full audio fidelity.

**V02:** https://iamtypist.dev/tools/youtube-transcript/mQfTdNVCOB0 . The timestamped derivative transcript was reopened and the approximate 04:16–16:13 passage was read, with opening and adjacent context through about 17:07. It supplies detailed speech structure; V01 supplies selected visual checks. No wholesale transcript or original media is republished here. Direct quotations were avoided except minimal identifying terms.

| Responsibility | Transcript interval | Frames inspected this unit |
|---|---|---|
| Instructions | 04:16–06:17 | 04:40, 05:40 |
| Context Delivery | 06:17–08:24 | 06:40, 08:00 |
| Context Management | 08:24–10:48 | 08:50, 09:40 |
| Tool Interface | 10:48–12:32 | 11:15, 12:20 |
| Execution Environment | 12:32–14:36 | 13:25, 14:05 |
| Durable State | 14:36–16:13 | 15:20, 15:50 |

The author's own warnings about incomplete terminology, passive instructions, excessive context and the limits of stored state are retained as author claims, not rebranded as our novel discoveries. Product names in derivative text were not silently repaired into exact quotations or current product recommendations.

## Primary documentation and bounded research evidence

Observation date for D01–D13 is 2026-09-13. These are individually scoped reads, not thirteen full documents mastered. Except MCP's versioned specification and the dated publication identities, webpage contents are not immutable snapshots. No local byte hash of these web pages is claimed. Parsed-line ranges below describe this tool's observed view; named sections and URLs are the durable re-entry anchors. Documentation snippets are not installed-runtime verification.

| ID | Exact source | Actual material read / role |
|---|---|---|
| D01 | https://code.claude.com/docs/en/memory | Selected introduction, CLAUDE.md versus auto memory, file scope/loading/imports and AGENTS.md distinction; observed lines 57–200 and overlapping loading sections. Not all auto-memory/team-management sections. Grounds client-specific instruction loading and instruction-versus-enforcement. |
| D02 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | Dated 2025-09-29 engineering article. Introduction and selected middle sections on prompt sufficiency, tools, just-in-time/hybrid retrieval, long-horizon compaction and notes; especially lines 35–83. Not a fresh benchmark or exhaustive reading of linked papers. |
| D03 | https://modelcontextprotocol.io/specification/2025-11-25/server/tools | Versioned Tools chapter: interaction model, discovery/calling, tool schema, annotations, structured content/output schema, error and security sections. Observed substantive spans 25–248, 244–464 and 473–504. Full relevant contract chain, not every linked schema/security document. |
| D04 | https://modelcontextprotocol.io/specification/2025-11-25/server/resources | Selected application-driven interaction, capability options, list/read and notification/subscription sections; observed 25–83 and 93–233. URI exposure and incorporation are distinct. Remaining MIME/URI/security details not fully read. |
| D05 | https://modelcontextprotocol.io/specification/2025-11-25/architecture | Substantive text 21–114 read: host/client/server responsibilities, design principles and capability negotiation. Normative/design allocation, not deployment proof. |
| D06 | https://code.claude.com/docs/en/sandboxing | Selected overview, modes/fallback, credential, filesystem, permission-versus-sandbox and explicit Scope sections; observed 62–96, selected 281–317, 447–459, 505–528 and 648–676. Not all configuration/platform details or an OS test. |
| D07 | https://docs.langchain.com/oss/python/langgraph/persistence | Substantive landing text 21–119 read: checkpointer/store distinction and RAM-only restart limitation. The former /durable-execution URL redirected here in this observation. Do not attribute the new separate checkpointer chapter's detailed mechanisms to an obsolete landing-page layout. |
| D08 | https://docs.langchain.com/oss/python/langgraph/functional-api | Selected resume/state/task and Determinism, Idempotency, Common pitfalls sections; observed 276–430 and 436–629. Replay and incomplete-task re-execution are documented separately. Examples were read, not run. No full library/dependency audit. |
| D09 | https://openai.com/index/unrolling-the-codex-agent-loop/ | Dated 2026-01-23 primary engineering account. Read selected loop/prompt construction and tool-specific sandbox description, including 37–74 and 276–338; surrounding first-turn/performance material was available but is not used to claim current implementation details. Linked repository files were not newly audited. |
| D10 | https://developers.openai.com/codex/guides/agents-md → https://learn.chatgpt.com/docs/agent-configuration/agents-md | Current redirected primary guide; guidance discovery 846–853 and selected scope/fallback/verification text through 975 read. Exact loading rules, not a client execution. The redirect is recorded rather than treating the old URL as an immutable page. |
| D11 | https://developers.openai.com/api/docs/guides/prompt-caching | Selected computational-prefix explanation 874–887, rendered-prefix notes, cache/compaction interaction 1773–1781 and relevant preservation text. Pricing/API migration details were surfaced but are not load-bearing here. No current price/model recommendation or cache experiment. |
| D12 | https://aclanthology.org/2024.tacl-1.9/ | Lost in the Middle, TACL 2024. Metadata and abstract, particularly lines 57–60, only. Full paper/PDF and experiments not read in this unit. Limited historical empirical orientation, not a current all-model claim. |
| D13 | https://docs.langchain.com/oss/python/langgraph/checkpointers | Newly followed primary route from D07. Selected thread/super-step/pending-write sections 73–111, Replay/Update state/Durability modes 288–319 and interface overview. Not the full 868-line page or backend implementations. |

Twelve primary documentation/engineering pages plus one research abstract were consulted at these unequal depths, alongside the media representations. Counts are bookkeeping, not confidence scores or completeness percentages. The bibliography in this unit is intentionally bounded to questions exposed by the six responsibilities.

## Mechanism-to-source recovery

| Claim family | Re-enter |
|---|---|
| File exists versus applicable guidance loaded | V02 04:16; D01 loading/AGENTS.md; D10 How Codex discovers guidance |
| Evidence locator versus included content | D04 resources/list and resources/read; D05 Host; Note08 §3 |
| Full/eager versus just-in-time retrieval | D02 Context retrieval and agentic search; Note08 cases C1/C2 |
| Context fit versus retained decision conditions | D02 compaction; D12 abstract limits; Note08 M1/M2 |
| Prompt cache versus semantic compression | D11 Why prompt caching matters / What is the prompt cache / compaction FAQ |
| Tool shape, authority, protocol and effect | D03 Tool Result, Output Schema, Error Handling, Security; Note09 table/cases |
| Actual executor and scope of containment | D06 Scope / permissions versus sandbox; historical D09 shell/MCP distinction |
| Checkpoint/store/backend versus safe resumption | D07; D13 Threads/Pending writes/Durability modes; D08 Determinism/Idempotency |
| Replay versus current action authority | Note10 analytical S1–S3; not a claimed implementation feature |

## Preserved source-code anchors and canonical context

Earlier code pins remain unchanged: Meta-Harness framework `0cbc31e97c9e6d24232d1dc754827c02e1ec415c`; selected artifact `57fefdb2ff84af3fd81b69d67814acbe69bd0743`; selected Harbor tag reading `527d50deb63a5d279e8c20593c18a2cbc7f61f9e`. Paper anchor remains `2603.28052v1`. No repin, new paper-version claim or historical experiment reconstruction occurred.

Within this conversation, the unchanged original METHOD, WHY, SOURCE-LEDGER, Note01/02, STATE and U01 records remained available in their canonical read forms. PLAN v0.3, Note05 and U01-B SOURCES were freshly recovered; current META/INDEX/CATALOG were read before publication work. Note06/07 and U01-B CHECKS retain their already-read limits. Source-oriented reuse of those results is not another run of their diagnostics.

The older context–memory–harness META was reopened after catalog discovery for nonduplication and scope. Its technical deep dives were not freshly read or treated as current provider evidence. No other study's completion or Foundation authorization was changed. Current main at recovery matched the U01-B publication.

All nine triggered agent-control protocols were recovered in full this turn, with truncated responses completed by additional ranges. They govern this researcher and are not evidence for the six responsibilities. Fresh current project/Foundation/DevOS recovery is still required before the later dedicated projection/adoption analysis; this unit made no such adoption decision.

## Execution and access limits

Local media SHA-256 and frame extraction/visual inspection were performed. No new model, application, persistence engine, sandbox, network-effect or retrieval evaluation was run. Local HTTP recovery of documentation failed DNS; web rendering succeeded. This failure is not evidence that the source or feature is absent.

No new RESULT.json or passing application-test count is supplied. All new examples in Note08–10 are analytical cases. [REVIEW-AND-LIMITS](REVIEW-AND-LIMITS.md) records the same-researcher challenge and remaining discriminating observations. Source instructions and examples were not executed merely because they appeared in documentation.
