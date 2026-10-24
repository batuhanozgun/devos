# U05-B — Source and execution ledger

**Date:** 2026-09-17. **Unchanged pin:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Pinned root](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). FULL means source through EOF, not all dependencies/platforms or a passing test. IDs continue S108.

| ID | Path | Git blob | Actual coverage |
|---|---|---|---|
| S109 | scripts/hooks/skill-run-tracker.js | eef54b859b735d5b76e045dd4147e43ec19e00b0 | FULL; automatic producer, outcome and identifier policy; not executed |
| S110 | scripts/lib/skill-improvement/observations.js | 1544c4b9fa899b159abe285dd2a7137e14a87041 | FULL; caller-supplied observation schema and project JSONL; not executed |
| S111 | scripts/lib/skill-improvement/health.js | 8aba59861e9bfc4c1e4263f103808c7999632663 | FULL; also original transitive dependency executed in E04 |
| S112 | scripts/lib/skill-improvement/amendify.js | c95f0e91481b4a20d13107923f502258e7375391 | FULL; executed E04, including single-failure/threshold contrast |
| S113 | scripts/lib/skill-improvement/evaluate.js | f45023d549b0fc5ad0ac96ac1fef3eb5306bd5d9 | FULL; executed E04, including real rejection controls and evidential counterexamples |
| S114 | scripts/lib/skill-evolution/tracker.js | 0ea0ba1ccf862ace62f8a4ba708e6de9a7f142d5 | FULL; JSONL/state-store, normalization/retention; not executed |
| S115 | scripts/session-inspect.js | e166c8efe2667a19231aec9068ae0f77890291bd | FULL 1–220 reaching EOF; reread of earlier S60 caller, not independent evidence; no CLI execution |
| S116 | scripts/lib/skill-evolution directory | six entries at pin | FULL direct metadata content; duplicate response metadata truncated, first listing complete; dashboard/index bodies not read |
| S117 | scripts/skills-health.js | 4cea9ec503e27fc37041b48f8a75a918ebaceac3 | FULL 1–240 reaching EOF; report/dashboard selection; not executed |
| S118 | scripts/lib/skill-evolution/health.js | 309f160943cf27bc8ca95a88486400ad20bfb19d | FULL; rolling report/version/label semantics; not executed |
| S119 | scripts/lib/skill-evolution/versioning.js | 6aa7a932d09bb01996894ee0cbff40c299e7bd87 | FULL; snapshots/logs/rollback; not executed |
| S120 | tests/lib/skill-improvement.test.js | ea80a25fd80a1f0c6c185c7671bd37177788c52d | FULL 1–240 reaching EOF; TEST SOURCE INSPECTED, NOT RUN |
| S121 | scripts/lib/skill-evolution/provenance.js | 1062514a39059819ec1971d3be8b8751a6f077c7 | FULL; path roots/classification and optional provenance functions; not executed |
| S122 | scripts/hooks/run-with-flags.js | 9f6de372212d5c3ba20502b5e05711431f1a0053 | FULL 1–230 and 231–400 reaching EOF; real run-export invocation; not executed |

## Claim binding and source selection

- Distinct telemetry/observation contracts: S109→S114→S117/S118 versus S110→S111/S112/S113→S115. No assumed schema adapter.
- Invocation outcome rather than task quality: S109/S114 and W12/W13. Retained S99 selected failure registration and S106 dispatcher connect to S122/S109. Missing standalone main is not a broken route when the wrapper invokes run.
- Two meanings of health: S111 versus S118. Constant failure/no-data non-declining examples are source inferences, not E04 observations.
- Proposal semantics and rationale: S112/S111 plus E04 C00/C08; no source skill inspection or automatic patch application in S115.
- Evaluator gates/limits: S113 plus E04 C00–C07. S120 supplies prior test intent but not evidence that tests passed.
- Actual change/provenance boundaries: S119/S121; no quality-gate dependency in these public paths. Current version label is not a content digest.

S116's discovered but unread dashboard.js blob `7049707bd495cb61033d8a8ada89bf19434b2483` and index.js blob `baed650cc0534bd3cfa5991910e126e52faff87a` remain frontier items. Tests/lib/skill-evolution.test.js and tests/scripts/session-inspect.test.js were found by search, not read or run. Common utils were only selectively read in S105; no complete utility audit is implied. P1 remains partial.

Searches for appendSkillObservation, buildSkillEvaluationScaffold, skills:amendify and rollbackTo/createVersion used default ref `dd6ee538aee0f548d4a6b520118f875431fd749e` for discovery only. All load-bearing bodies were fetched at the pin. Search absence is not exhaustive pinned absence; no new upstream snapshot is adopted.

## External primary checks, not a repin

W12: [Claude Code hooks reference](https://code.claude.com/docs/en/hooks), selected event table and PostToolUse section, observed 2026-09-17. It distinguishes successful tool invocation from task/turn lifecycle. W13: [Claude Code skills reference](https://code.claude.com/docs/en/skills), selected control/invocation/lifecycle paragraphs: regular skill content enters context when invoked. These are current host contracts, not a realized pinned installation. They revisit the sources behind W10; do not count as independent corroboration. Unofficial mirrors and unrelated news returned by search were not used.

## E04 execution and oracle boundaries

[PLAN/runner/output/summary](u05-b-evaluation-probe/README.md): one Linux/Node v22.16.0 run at 2026-09-17T20:44:57.296Z; 9/9 predeclared expectations matched, exit 0, captured probe stderr empty. S111/S112/S113 were reconstituted from connector text after raw-network DNS failure and byte-verified against Git blobs before/after. No target logic changes, target doubles, dependency installs or model calls. The run exercises evaluation/proposal and transitive health only. It does not exercise the observation writer/reader, hook tracker, full caller CLI, dashboard, filesystem versioning or native host.

Positive/tie/regression/min-count/selector controls coexist with duplicate-ID/unmatched-task/mixed-amendment/single-failure cases. Inputs have stipulated outcomes; no external task oracle was run. Original raw stdout, all fixtures/results and source digests are preserved in deterministic gzip, with an exact decompressed hash and readable summary. Compression was an artifact-transport choice after the run, not a criterion change or rerun. E01–E03 remain unchanged historical experiments; E04 does not promote U04/U05-A source-only findings into runtime evidence.

## Canonical recovery and continuity

Fresh AGENT and needed remaining protocols were recovered. Same-conversation full R01–R05 remain available; newly recovered R06–R09 and current STATE, complete METHOD/MR07/META/QUESTIONS supplement retained full WHY/PLAN/INDEX/Note07/U05-A ledger/receipt. Compare prior closure `234364690e22ac5d757be8fe6056dddec31c1cb5` to publication parent `8bdcce7af6228cbad7eae03d5c5e01074e65289b` showed only concurrent Superpowers and its catalog update; ECC/control unchanged. This is not an independent cold-start trial.

The latest user agreement defers joint whole-study evaluation until completion, not research-quality checks; it is recorded in current STATE/PLAN/round. No Foundation, upstream, installation or control mutation is authorized by the association with Information. Publication identities/checks belong in PUBLICATION-U05-B when actual.
