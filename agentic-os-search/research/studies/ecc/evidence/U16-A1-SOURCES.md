# U16-A1 — Managed maintenance source ledger

**2026-09-22 · Q03c1 / MR38.** Fixed ECC source `8321021c54d670126ce3b2969d5deb880b4b0c2a`; research input `836d8e71f075b8395e59f2e72ec48a6d1d151ec5`. [Note37](../notes/37-MANAGED-MAINTENANCE-OWNERSHIP-AND-PREVIEW.md), [round](../ROUND-U16-A.md), [STATE](../STATE.md).

SOURCE OBSERVATION, inspected test definitions and explicitly conditional INFERENCE. No target execution, installation, repair/removal, Git/Node probe, live host/service/model, user-data access or E10. FULL means the body was read through EOF, not that all imports, platforms or effects were tested. Source line ranges below are inclusive requested ranges; overlong final requests ended at actual EOF.

## 1. Pinned application and test bodies

| Handle | Path relative to ECC | Blob | Actual read |
|---|---|---|---|
| LIFE / S51 re-entry | scripts/lib/install-lifecycle.js | ec9cb1d801a3e638a9befaca1ece7427b47b881e | FULL:1–240,241–500,501–780,781–1080,1081–1380,1381–1690,1691–2010,2011–2330,2331–2660/EOF. Previously only1–480; now discovery/doctor/repair/removal consumers are included |
| CLI | scripts/ecc.js | 6c2aee1a5826475bfd05552a1bc485b35295bf9a | FULL1–290,291–440/EOF; command map, global dry-run environment, argument routing and direct-child signal handling |
| DOCTOR | scripts/doctor.js | 7b0cd04afb060f7251258ccfffc1a46d4135eb0d | FULL; actual report/exit consumer |
| REPAIR | scripts/repair.js | 3494f1adebd3d1c43921140a38b33fb430f9ac42 | FULL; local flag, lifecycle call, separate projection and result/exit |
| UNINSTALL | scripts/uninstall.js | 0a7f412315e4ffa17f3d9586d0b2ccaca9fb7bd1 | FULL; global/local dry-run, ordinary/legacy routing and partial exit |
| UPDATE | scripts/auto-update.js | 3612dab882e413f97c58591ec6ebf546df69a3dd | FULL1–300,301–520/EOF; source inference/validation, fetch/pull, replay and per-target result |
| INSTALL-CLI / S28 | scripts/install-apply.js | 1435d2ff665b0595f490afd211fc0295b40d0842 | FULL1–290/EOF; actual normal/guided entry, normalized request, preview/apply and projection output |
| APPLY / S44 | scripts/lib/install/apply.js | fbab1293bb8dcdebb1df4a23556f06419bd290ec | FULL1–270,271–570,571–800/EOF; general guard, written-destination checkpoint and post-write effects |
| GUARD / S45 | scripts/lib/install/ownership-guard.js | 962c62e8835f0550ccdca05e499a16391f436491 | FULL; previous ownership, skipped paths, late files and preserved unwritten digests |
| MIGRATION / S52 | scripts/lib/install/claude-skill-migration.js | adc9170b3032ab6115b1e1531ef2c6684b1c7a4f | FULL; non-Claude union and special Claude flat-skill protection |
| PLAN / S38 | scripts/lib/install/plan.js | 1400557c79566f059b89b4b065c13d80f5d473e4 | FULL; concrete copy metadata, JSON/hook materialization and source/state preview |
| RUNTIME / S32 | scripts/lib/install/runtime.js | eabb930b26a8f85f26768de2d65036cc7f1c7b46 | FULL; normalized request dispatch |
| EXECUTOR / S36 re-entry | scripts/lib/install-executor.js | 72eac5e8a9868ac1632121977c1281c026afe50b | SELECTED1–75: import of manifest plan and lazy apply/preview delegation. Not full legacy implementation |
| REGISTRY / S39 | scripts/lib/install-targets/registry.js | 8dd7cf848810c1512dff72fdae4841563dea5d58 | FULL; target discovery, validation and adapter-root derivation |
| CURSOR | scripts/lib/install-targets/cursor-project.js | 81e71aefd0b2cf25efc7394dce2cc5983fa8028d | FULL; actual rules/copy path and distinct JSON/config branches |
| HELPERS / S41 | scripts/lib/install-targets/helpers.js | f69d75e86bab0276eee66359366096d1c38f2441 | FULL1–280,281–620/EOF; concrete flattening/root/scaffold functions |
| MODULES / S26 | manifests/install-modules.json | 884c7d39d867dd882ba097bcaab9dd2696ed1a5e | SELECTED1–120; complete rules-core/agents-core/commands-core/hooks-runtime records; platform-configs beginning incidental |
| T-LIFE | tests/lib/install-lifecycle.test.js | 1eed5071b6aed317d1a1da5e5f3d02b01b8562b9 | SELECTED1–280,281–620,621–960,961–1085. Fixture helpers and complete selected discovery/doctor/preview/no-op/source-label/Claude migration tests; final missing-copy test only begins. Not full suite; NOT RUN |
| T-GUARD / S48 | tests/scripts/ownership-guard.test.js | 4c16afd2e8a405764fc4dd5b8951574d73f99af4 | FULL; ordinary installation ownership, failed-reinstall digest preservation, public uninstall dry-run positions. NOT RUN |

Immutable entry: [lifecycle](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/scripts/lib/install-lifecycle.js). All listed paths use that same fixed repository/ref; no search result silently changes it. The search for install-lifecycle returned newer default-branch bf70150e paths, used only to discover actual callers/test paths before pinned reads. Its clipped broad results are not a complete repository inventory.

## 2. Load-bearing chains and discriminators

**Common maintenance:** CLI → DOCTOR/REPAIR/UNINSTALL → LIFE discovery at REGISTRY adapter-derived roots → read valid recorded state → inspect actual operation → mutation and refreshed state → public report/exit and separate projection. UPDATE discovers the same managed family, then advances a selected checkout and calls INSTALL-CLI/APPLY. Native provider registration and explicit legacy sync are distinct, not implied by this common route.

**Previously unowned copy:** normal APPLY→GUARD excludes existing unrecorded F from ownership; LIFE repair regenerates an all-copy nonlegacy request through RUNTIME/PLAN, then MIGRATION's non-Claude union reintroduces F without GUARD. No-digest comparison can find identical bytes; final refresh still records F as managed. UNINSTALL's digest-matching branch can then remove it. Distinct bytes may instead be overwritten. CURSOR/HELPERS/MODULES and T-GUARD give a real copy-only request family; the analysis remains conditional on that request resolving the path and on normal safe I/O. No real lost file was observed.

**Changed baseline before repair:** LIFE writes migration.bridgeState through writeRefreshedInstallState before target repairs, hashing current readable destinations. A managed local edit can become the saved digest before a subsequent repair failure. Later digest-based removal can treat those unchanged edited bytes as installed. Contrast APPLY's successful-write set and GUARD preserveUnwrittenFiles; T-GUARD explicitly tests the latter writer, not LIFE. This is a conditional sequence, not a rerun of that test.

**Preview propagation:** CLI sets environment for a leading --dry-run and removes that prefix from child argv. REPAIR/UPDATE inspect only their local parsed option; UNINSTALL explicitly consumes both environment and argv. Thus prefix repair can mutate, and prefix auto-update can execute Git fetch/pull, while suffix repair and either-position uninstall take their preview branches. No command was executed. T-GUARD's direct CLI test is only uninstall; T-LIFE's repair preview sets the function option directly.

**Currentness:** LIFE chooses saved-digest comparison for copies and regenerates only module-selection comparisons in doctor; copy-only versus any-noncopy/legacy repair changes plan selection. The no-op source-label preservation test is genuine counterevidence to a universal latest-version-stamping claim. UPDATE's fast-forward source movement/reinstall is distinct from doctor and from Note28's exact release archive.

**Result semantics:** LIFE per-record catch can omit earlier repaired/removed effects from returned path arrays. Partial uninstall retains original state, not an outstanding-removal-only cursor. UPDATE's nested command helper has a different signal predicate from CLI; D-NODE supplies the narrow status-null contract. Actual model/host availability and desired-state acceptance are not inferred from these result labels.

## 3. Test-oracle and unexamined dependency boundaries

T-GUARD uses real temporary files and per-adapter plans but narrows its first ownership case to a selected copy operation, exempts OpenCode build validation, and injects write-boundary failures for ordinary apply. It tests failed reinstall retaining the old digest, then actual helper uninstall of that fixture in the test definition. It does not call general repair between preservation and removal. The public preview case varies flag position only for uninstall. No test ran during this research.

T-LIFE selected bodies test discovery/error categories, content/subset checks, direct repair dryRun, old source metadata retained by no-op repair and special Claude skill/root protection. The fixtures often construct operations/legacy mode directly; managedOperation can hash an existing fixture at creation. These tests do not establish provenance of all real initial installs. Later tests, full CLI update cases and every platform were not inspected. Reading actual filesystem assertions is not an executed pass or a universal safety claim.

LIFE's shared configuration branches were read at their callers: merge/template/backup handling and specialized hook calls are visible. Full `claude-settings.js`, payload filtering/ownership producers, hook-consent variants and the separate `codex-legacy-sync` implementation are not newly closed. They are U16-A2/Q03c2 material source work, not hidden runtime caveats. Previously bounded OpenCode legacy cleanup and initial projection are retained through their original notes; no full external host audit follows.

## 4. Narrow external contracts and acquisition

D-GIT: [official git-pull](https://git-scm.com/docs/git-pull), DESCRIPTION/fast-forward/current-branch/upstream passages checked2026-09-22. Supports the scope of pull --ff-only, not actual source trust or a performed update.

D-NODE: [official child_process](https://nodejs.org/api/child_process.html), spawnSync result status/signal/error contract checked2026-09-22. Signal termination can report null status; this is not installed Node-version verification or an observed signaled ECC child. No claim about all platform failures follows.

A container raw-source request failed DNS; no original source checkout was acquired locally and no reconstructed snippet executed. An empty local acquisition directory is not evidence. Connected GitHub source reads were sufficient. No PDF/audio/image or private endpoint was used.

## 5. Recovery, method and publication

Input main836d8e71 compared identical. Fresh AGENT unchanged; previously full same-conversation canonical protocols remained applicable. Fresh STATE09a00ade, WHY1c9fc08 and full METHOD7a6537b4 (tail98–160 recovered) aligned with available same-conversation INDEX/META/PLAN0.38/QUESTIONS/MR37/Note36/ledger/receipt.

Notes02/03/26/28 were fully reread as786514f0/06077976/46576b4c/124c1bdb; U01-B/U02-A ledgers as271b53c9/9ddb1fa9. Those research records recover prior scope, not independent behavior evidence. MR38 opening456b36a6 and activation54d1af65 preceded the new source work. Initial activation STATE blobaa67c0e126f3fc9c179b5da060dacbd458ceca21. Note37 was created atec2b1b2c3707bc1cf7295bf9fa09df340ced17ca; its and this ledger's readbacks are subsequent correspondence steps.

A1 closes the coherent common maintenance/public-command slice; parent G3 remains partial for materially distinct shared-configuration and legacy consumers. Q03b and stronger Q03c3 preserve guided retry, actual authority, installed identity, concurrency, abrupt failure, durability and outcomes. No previous note/experiment, E06 exclusion, exploration status or SOUL architecture was changed. Current publication and sequencing belong to subsequently checked STATE/PLAN, not this file's existence alone.
