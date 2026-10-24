# U02-B — Sources, identity and actual reading coverage

**Observed:** 2026-09-15. **Input main:** `2a5bfe9109b9d36295d7665e0495af263e88c73c`. **Question:** how video responsibilities 7–10 coordinate work and evidence, and how the separate evolution loop supports a justified change. This ledger extends the earlier records; it does not replace their historical source or execution identities.

## 1. Newly supplied representations

**V03 — user-uploaded audiovisual MP4**, same named video ID `mQfTdNVCOB0`. File: `Harness Engineering Masterclass： Technical Deep Dive on how to build Agentic Systems [mQfTdNVCOB0].mp4`; 338112717 bytes; SHA-256 `edc60507f6144b32ff9888a4a046e08cd9a0230d98c11f49a36107b95dcbd087`. Probe: AV1 video, 3840×2160, 24 fps, 1685.750 seconds; Opus audio, 1685.774 seconds; container 1685.774 seconds.

This is not byte-identical to the older video-only V01 MP4. Its combined audiovisual packaging differs from the old separate MP4/WebM. Filename, source ID and inspected visual content support the source association; no elementary-stream identity comparison was performed. Preserve [the original manifest](../MEDIA-MANIFEST.json) unchanged.

**V04 — user-supplied English SRT**, file `Harness Engineering Masterclass： Technical Deep Dive on how to build Agentic Systems [mQfTdNVCOB0].en.srt`; 51258 bytes; SHA-256 `30fe50be927fba0ebd8e4843739756a186eccf8dcb01cf92308b1b1dbc18db3c`. All 714 cues were read, including recovery of the portion elided in the initial tool output. First cue starts 00:00:00,000; final music cue ends 00:28:02,114. Overlapping cue timing is present. No claim is made that this is a verified native YouTube track, manually corrected transcript or independently aligned audio.

V02 remains the earlier third-party transcript. V04 is a new representation, not a retroactive correction or replacement of V02. No full text-to-text comparison against V02 was performed.

Thirteen V03 frames were extracted at seconds 920, 990, 1060, 1120, 1190, 1250, 1310, 1370, 1445, 1500, 1560, 1605 and 1640, scaled to width 1440 and inspected on four contact sheets. Frame 1640 was also reopened individually. Selected timestamps overlap older units; these are not thirteen independent confirmations of prior samples. Exact identities: [MEDIA-READING](MEDIA-READING.json).

| Native region | V04 cue route | V03 samples this unit |
|---|---|---|
| Durable-state transition into orchestration | 391–409; approximately 15:32–16:17 | 15:20 boundary sample |
| 7 Orchestration | 409–457; approximately 16:13–18:14 | 16:30, 17:40 |
| 8 Subagents | 458–518; approximately 18:11–20:33 | 18:40, 19:50 |
| 9 Skills and procedures | 519–567; approximately 20:30–22:24 | 20:50, 21:50 |
| 10 Verification and observability | 568–643; approximately 22:21–25:17 | 22:50, 24:05, 25:00 |
| Separate evolution loop | 644–673; approximately 25:14–26:26 | 26:00, 26:45 |
| Final composition and diagnostic matrix | 674–714; approximately 26:23–28:02 | 27:20 |

Cue intervals overlap chapter boundaries; they are retrieval anchors, not exact audio segmentation. Full subtitle reading and selected visual checks are distinct from continuous video viewing or full audio listening. No audio transcription or full audio/subtitle alignment was performed.

## 2. Material representation limits

At 15:20 the embedded caption includes confidence table; V04's nearby cues 385–386 still have a less complete table phrase. Supplying the new SRT therefore does not close the old discrepancy. Audio wording is unresolved.

Product-name errors and a locally anomalous verification phrase around cue 609 remain in V04. They are not silently repaired into exact quotations. The companion article supplies an explicit hook-documentation link, which is a separate source route, not proof of the disputed spoken spelling. Peripheral institutional and product examples were not newly verified merely because they occur in the subtitles.

At 27:20 the diagnostic slide uses a categorical model-versus-layer slogan. V04 cues 694–695 use a qualified formulation, and cues 91–102 acknowledge model capability differences. Note12 preserves the contrast rather than attributing an unqualified model-exclusion thesis to the whole video.

The sampled video gives evolution a separate ratchet diagram. D22 organizes evolution together with verification/observability. Both are author-source observations, not independent corroboration or permission to silently rewrite the video's organization.

## 3. Selected primary documentation and companion text

D14–D22 were observed on 2026-09-15. They are current web views, not immutable code pins or claims about the video's historical product versions. Listed coverage is what was inspected, not a full audit of each linked implementation. Parsed line numbers are reading receipts for this observation; named sections and URLs are the durable recovery routes.

| ID | Source | Actual reading extent / role |
|---|---|---|
| D14 | https://openai.github.io/openai-agents-python/multi_agent/ | Substantive orchestration guide, approximately lines 183–230: model/code orchestration, manager and handoff patterns. No SDK execution. |
| D15 | https://openai.github.io/openai-agents-python/handoffs/ | Creating/customizing handoffs, Handoff inputs and Input filters, approximately 189–286; rechecked argument/history distinctions. No transitive source-code audit. |
| D16 | https://code.claude.com/docs/en/hooks | Selected event/decision sections: PreToolUse around 1690–1729, PostToolUse 1859–1932, Stop/SubagentStop/StopFailure 2398–2488 and asynchronous hooks 3427–3525. Not the full approximately 3630-line page or every event/matcher/platform. |
| D17 | https://agentskills.io/specification | Selected directory/SKILL.md, allowed-tools, optional resources, progressive disclosure and validation sections, approximately 25–55, 193–267 and 290–297. Format/support contract, not skill efficacy. |
| D18 | https://code.claude.com/docs/en/sub-agents | Selected skills/preload section around 556–571 and context isolation/fork distinction around 948–975. Not every built-in worker or lifecycle implementation. |
| D19 | https://openai.github.io/openai-agents-python/tracing/ | Selected tracing/spans, export and sensitive-data sections, approximately 199–264 and 315–323. No trace was sent or live agent inspected. |
| D20 | https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents | Definitions of transcript/outcome, selected grader discussion, and task/isolated-environment/grader/trace guidance around 25–37, 56–120 and 230–270; selected concluding layered-evaluation discussion. Not a new benchmark or full audit of linked studies. |
| D21 | https://sre.google/sre-book/postmortem-culture/ | Core incident-learning philosophy and review/publication discussion, approximately 59–103, with surrounding trigger/cost context. Historical engineering account, not verified present-day organizational practice. |
| D22 | https://www.thecarbonlayer.com/harness-engineering/ | Selected companion text for chapter organization, source links and the architecture-source caveat, around 24–29 and 40–73. Not exact video transcription; linked community architecture sketches were not used as official implementation evidence. |

Documentation examples were read, not executed. Source clauses and observed defaults require revalidation for a specific client/configuration before adoption. Search results served discovery only; unrelated results are not evidence.

## 4. Canonical recovery and nonduplication

Current AGENT was freshly fetched and unchanged. All nine active protocols had been fully read in this conversation; their current rules were applied. They are control, not substantive research evidence.

The research/library routers and package contract, harness STATE/INDEX/METHOD/PLAN/META/original ledger, and channel STATE/INDEX/route were available as full canonical reads in this conversation. Current main still pointed to the collection setup commit at recovery. The remaining channel META/METHOD/VIDEO-CATALOG/SOURCE-MAP were fully fetched. Note01, Notes08–10, U02-A SOURCES/REVIEW and the original media manifest were fully recovered for this unit.

No other study's substantive findings were newly compared. The older HERMES examples in the video remain source claims, not a fresh HERMES implementation audit. Framework/artifact/Harbor pins and paper v1 remain unchanged; no U01 probe or historical experiment was rerun. Current Foundation/DevOS assessment is deferred to U06, not silently inferred from old context.

## 5. Execution, storage and recovery

Actual local execution was file measurement/hashing, ffprobe inspection, SRT parsing and frame extraction. Analytical cases in Notes11–12 and the review are not application tests. No new agent/model, hook, handoff, skill runner, evaluator, remote service or sandbox behavior was executed. No paid provider request, installation or external media upload occurred.

Original MP4/SRT and extracted images are local conversation assets, not repository-persisted media. This ledger and MEDIA-READING preserve identities and anchors, not the missing bytes in a later session. Recover by source ID/user upload when exact media is needed; do not treat a historical /mnt/data path as a durable source. No wholesale third-party transcript or video archive is claimed.
