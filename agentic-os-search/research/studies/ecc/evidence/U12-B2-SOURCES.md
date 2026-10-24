# U12-B2 — Package, installation, loader and tool sources

**2026-09-19 · Q02b2 · SOURCE INQUIRY.** ECC remains [8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). Host comparator remains OpenCode v1.4.3 / [877be7e8e04142cd8fbebcb5e6c4b9617bf28cce](https://github.com/anomalyco/opencode/tree/877be7e8e04142cd8fbebcb5e6c4b9617bf28cce), associated with the nested lock's version label, not proved registry or installed identity. [Note26](../notes/26-OPENCODE-INSTALLATION-LOADING-AND-TOOL-RESULTS.md), [MR27](../ROUND-U12-B2.md), [STATE](../STATE.md). No target execution/build/test/install/npm pack, model/provider or E09.

## Fresh ECC coverage at the fixed pin

FULL is through EOF of the named source, not its dependency closure. SELECTED is only the stated material. All bodies came from connected GitHub; no downloaded checkout was obtained.

| Handle | Path / Git blob | Reading |
|---|---|---|
| B2-ROOT | package.json /87487a914c0fd739ea62107e7bf9e56b127207a5 | FULL1–205/206–435/436–620 through EOF. Root files/bin/prepack/dependencies; no root main/exports in this pinned manifest |
| B2-CONFIG | .opencode/opencode.json /2933339c6ca4132b2e8c4b05c1b01c66cdfb3b42 | Fresh101–330/331–600 through EOF, combined with B1's retained1–100: complete config. Relative plugin, instructions, skills paths, agents, commands and permission |
| B2-IGNORE | .opencode/.npmignore /d286b7c163e1458990a898f971d74cd836b2b9fa | FULL; node_modules and bun.lock exclusions, not a performed package test |
| B2-MODULES | manifests/install-modules.json /884c7d39d867dd882ba097bcaab9dd2696ed1a5e | SELECTED1–250. Complete first rules/agents/commands/hooks-runtime/platform-configs entries; .opencode belongs to platform-configs. Later catalog not full |
| B2-MANIFEST | scripts/lib/install-manifests.js /bb16cc93c89bbda4c2c4f493baeab6188d6985eb | SELECTED1–135/460–770 through EOF; imports and complete resolveInstallPlan. Explicit module selection, adapter scaffold and ordered selected modules. Other manifest parsing/default helpers not newly audited |
| B2-REGISTRY | scripts/lib/install-targets/registry.js /8dd7cf848810c1512dff72fdae4841563dea5d58 | FULL; validation/exemption, root/state resolution and actual adapter.planOperations caller |
| B2-PATH | scripts/lib/opencode-paths.js /0a5ef3f3df5bb66fd320fda824b2c8fb9516beb5 | FULL; explicit OPENCODE_CONFIG_DIR, XDG_CONFIG_HOME, home fallback |
| B2-REQUEST | scripts/lib/install/request.js /f99f5aba1e1fe2b8bd6dfa0c499f22cacdefbf08 | FULL1–220 through EOF; CLI flags, normalization, consent, explicit hooks-runtime plus no-hooks refusal |
| B2-RUNTIME | scripts/lib/install/runtime.js /eabb930b26a8f85f26768de2d65036cc7f1c7b46 | FULL; actual manifest/legacy branch and withHookConsent wrapping |
| B2-CLI | scripts/install-apply.js /1435d2ff665b0595f490afd211fc0295b40d0842 | FULL1–250 through EOF; normalized request → plan → preview/apply → install-state projection and result/error output |
| B2-PLAN | scripts/lib/install/plan.js /1400557c79566f059b89b4b065c13d80f5d473e4 | FULL1–230/225–520 through EOF; recursive materialization, copy-file selection, last-copy-wins dedup and state preview |
| B2-APPLY | scripts/lib/install/apply.js /fbab1293bb8dcdebb1df4a23556f06419bd290ec | FULL1–245/246–515/510–830 through EOF. Consent gate, guarded operations, copy/JSON/Markdown branches, digest/checkpoint writes and post-write migration cleanup. Generic ownership/Claude migration dependencies retain their separate prior coverage; not a fresh exhaustive audit of every helper |
| B2-CONSENT | scripts/lib/install/hook-consent.js /883c121d70ab6aae6858e45db977f3afd8a518bf | FULL1–300 through EOF. Classifier/strip/record/assert. OpenCode plugin paths under platform-configs do not match this classifier |
| B2-MIGRATION | scripts/lib/install/opencode-legacy-migration.js /baf3472f135491e4d2d421f6b5e3ba68ecd560ec | FULL1–270/270–520 through EOF. Legacy location, current/legacy state validation, digests, quarantine identity and cleanup/result. Same-root counterpart is conditional source analysis |
| B2-SAFETY | scripts/lib/path-safety.js /95a64138fb2154cebf1340fcdbe150cd18a13279 | FULL1–260 through EOF. Realpath/containment checks; confinement does not distinguish canonical from legacy role when roots coincide |

Retained full B1 bodies: .opencode/package.json94e8e3f; tsconfigc6b4325; index.tsfa6cadc; plugins/index.tsc1e17a1; plugins/ecc-hooks.ts22b1132; changed-files1150ca7; store df22f81; home adapterd25fdf7 and helpersf69d75e. [B1 ledger](U12-B1-SOURCES.md) carries full identities and actual ranges. These remain direct same-conversation dependencies, not independent evidence. Source8321021 and the separately observed indexed07756cee root header are not merged.

## Finite tool-subtree coverage

The direct tools tree06b559c5625a5235c32a7248553a6eb3872f71ab was fully read with truncated:false. It has the eight tool sources plus index.ts; this does not claim all OpenCode commands/prompts/instructions or their efficacy are read. Combined with B1, all these tool bodies and the plugin implementation/store are now read at the stated pin; no generated-byte equivalence is asserted.

| Handle | .opencode/tools/ file / blob | Actual scope and producer |
|---|---|---|
| B2-TOOLINDEX | index.ts /9bd9994793b93d9a873a426e25fa29e053a9da61 | FULL; named re-exports of all eight tools |
| B2-DEPS | dependency-analyzer.ts /449cebb67a56b92a925830d9f85bd2824f186af9 | FULL; manifest inventory/default-zero summary, output cap, labels/recommendations; no actual advisory/outdated/unused/fix analysis |
| B2-RUN | run-tests.ts /aa8ce520d47e005c3ec031ac2f7a14f305388bb5 | FULL; package/framework detection and returned command, not test execution |
| B2-COVERAGE | check-coverage.ts /46f11cd82000f6b15ea8c27180f6dd04dea0a75e | FULL; report selection/parsing/threshold; no new test, revision or freshness verification |
| B2-SECURITY | security-audit.ts /59b76d9ea170ac73bd3b12dc22325f1fa7174087 | FULL1–310 through EOF; actual bounded regex file scans; dependency command remains pending; ignored individual-file read errors |
| B2-FORMAT | format-code.ts /5c2d96d542a7660637326541ec5714a2f2930340 | FULL; explicitly documented command recommendation rather than formatting effect |
| B2-LINT | lint-check.ts /88b4a7435c8b1949cd469083271f21792db4bc9c | FULL; detected/default linter and command recommendation, not lint/fix execution |
| B2-GIT | git-summary.ts /b902f8e65b291496feb553f0ee9101ba08c27b49 | FULL; real git argv calls, depth/ref checks, failures→empty text→status clean ambiguity |

Changed-files and its store retain the full B1 producer/consumer analysis. Static imports of the main plugin reach changed-files and dependency-analyzer. The local tool barrel has a different import/registration surface; a missing unrelated barrel dependency and a lazy optional-store failure must not be conflated.

## Versioned host consumer coverage

All rows below are at877be7e, not current main.

| Handle | Host path / blob | Actual reading |
|---|---|---|
| H2-LOADER | packages/opencode/src/plugin/loader.ts /634fe6aad0e7a33eceee5a9217cd2bbfee762c9d | FULL1–250 through EOF; resolve/load/error stages, optional local retry only when wait callback supplied |
| H2-SHARED | packages/opencode/src/plugin/shared.ts /6cda49786bc9c00ee8e08281bf76c046a8797109 | FULL1–270/271–490 through EOF; local/npm target, package/server main/index selection, compatibility, v1 detection and identity |
| H2-CONFIG | packages/opencode/src/config/config.ts /ff79b739fe1092d57d1d7e29da3ba43cd7afc08e | SELECTED1–275/280–470/1140–1285/1280–1585. Complete installDependencies, loadPlugin, resolvePluginSpec, deduplicatePluginOrigins, loadConfig/loadFile/loadGlobal and instance config assembly/track/dependency wait. Unrelated schema and later update APIs not full |
| H2-PATHS | packages/opencode/src/config/paths.ts /82ccf3945fcd558a053cc3ca8bacef2683effa0c | FULL; discovered roots, project config and file/env substitutions |

H1-DISPATCH814e7870a44e1f0c2ef8f5e3fe98f600ddfeca59 remains fully read in B1. It deduplicates equivalent exports within one module, not functions across separately loaded origins; applyPlugin pushes each resulting hook record. H1-TOOLS800c45ced0c03d82ebb5a57945cd5e0258c98f52 retains B1's selected complete local-file/plugin registration and execute-return consumer. H1 SDK/shell/compaction identities and bounds are unchanged.

## Joined claims and discriminators

- CLI/request/runtime → manifest/module → adapter/plan → apply: .opencode is platform-configs; native-root children retain relative locations. With applicable operations actually written, source plugins, tools, generated dist and opencode.json coexist. No OpenCode JSON dist-retargeting occurs in this followed path. Markdown rewriting is a different branch. Nested/file package entry selects dist via main; reference ./plugins and local scans select plugin sources, subject to actual module/dependency resolution.
- Pinned root package.json includes .opencode and a prepack build, but no main/exports binding to its compiled entry. The host resolver does not recursively adopt the nested package manifest. A directory/default importer and actual published artifact remain separate; no universal npm failure or latest-release verdict is asserted. Indexed07756cee has a distinct explicit-root-entry header already documented in B1.
- no-hooks parses to declined; runtime strips operations through isHookRuntimeOperation. A platform-configs operation for .opencode/plugins/ecc-hooks.ts does not match. It can remain discoverable after a declined decision; actual loaded after-hooks still depend on host/import/profile. Explicit hooks-runtime plus no-hooks is rejected, and correctly classified hooks are removed. This is a scope mismatch, not absence of all consent controls.
- Config resolves relative specs against the config file and scans direct plugin files. plugins/index.ts and plugins/ecc-hooks.ts yield different file URLs; dedup uses those URLs. If both imports initialize, the same factory can register twice. Aliased exports within one module are deduplicated; that positive guard does not deduplicate separate origins. Extra after-hook invocation is conditional source behavior, not observed doubled work.
- Same-root migration: explicit config root HOME/.opencode, matching homeDir, successful application/digest/state write and stable regular managed copies. Post-apply cleanup derives HOME/.opencode as legacy too and can read the newly written canonical state as legacy. Managed files whose current/recorded/source hashes match are eligible for removal, including newly installed untransformed executable/config files. No canonical-versus-legacy root-inequality guard appears in the complete helper. Path containment accepts these in-root files. Modified/unverifiable files remain protected, so this is not a claim that every file or arbitrary user content is deleted. Depending on retained paths, cleanup can complete or warn while outer apply still returns applied:true. No destructive fixture ran.
- Tool outputs are producer-specific: inventory defaults are not a vulnerability scan; prepared test/lint/format commands are not performed actions; report threshold is not fresh coverage; successful Git-empty and failed Git-empty collapse at the status field. Security-audit offers a genuine bounded scan and explicitly pending dependency command, rather than inheriting dependency-analyzer's behavior.

## External check and evidence limits

[Official OpenCode plugin documentation](https://dev.opencode.ai/docs/plugins/) was searched/read on2026-09-19 for local versus npm loading, dependency installation and multiple origins. Moving v2 results were visible but not used to overwrite the versioned comparator. [npm package entry documentation](https://docs.npmjs.com/cli/v7/configuring-npm/package-json/) was returned as a general entry/bin distinction; no npm-version or installed-resolution inference relies on it. Actual load-bearing behavior uses the pinned host bodies above.

No upstream or adapted test ran. B1's complete build/hook test definitions remain relevant to producer-only entry/callback oracles, not new evidence of B2 cleanup/consent/dedup correctness. No new test coverage or CI pass/fail is inferred. Root/nested builds, tarballs, Node/Bun version and extension fallback, source-to-registry identity, concrete installed policy, module cache, shared state, crash/concurrency and real outcomes remain Q02b3. Generic ownership/repair and wider host/provider families are not silently closed.

The decisive extra countercase came from the final actual cleanup consumer, not from assuming a safe-copy or successful install-state write completes the lifecycle. Source conditions were not promoted to measured incidents. One raw-byte acquisition failed DNS; connected source access worked. Administrative publication operations are not ECC experiments.

B1+B2 now supply the original bounded source-distribution-to-consumer explanation; final publication standing belongs to STATE/receipt. After closure, next selected source work is U12-C/Q02c, the separate Python llm-select/provider layer (pyproject.toml and src/llm). This is existing research sequencing, not adoption or a live model campaign.
