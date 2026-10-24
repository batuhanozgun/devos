# U16-A2 — Shared configuration and legacy source ledger

**2026-09-22 · Q03c2 / MR39.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`; research input `05e049da9af0fff6dcc4073042c9e99fe9f9e427`. [Note38](../notes/38-SHARED-CONFIGURATION-OWNERSHIP-AND-LEGACY-RECOVERY.md), [round](../ROUND-U16-A2.md), [STATE](../STATE.md).

Evidence: original SOURCE OBSERVATION, TEST SOURCE INSPECTED, and explicit conditional INFERENCE. No target test/build/installer/update/repair/removal, live host/model/service, user-data or credential access, new E10 or reconstructed-code execution. FULL means reading through EOF, not executing or verifying every dependency/platform.

## Newly read fixed-pin bodies

All paths below resolve under [the exact ECC pin](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). End ranges are requested inclusive ranges; oversized final requests terminate at actual EOF.

| Handle | ECC-relative path | Git blob | Actual coverage and role |
|---|---|---|---|
| SETTINGS | scripts/lib/install/claude-settings.js | dba4a4a75739fea4eae5d82a0657b979af63e367 | FULL1–260,261–550,551–860/EOF; desired/historical validation, root binding, event+ID comparison, shared-file snapshot writer and removal |
| LOCK | scripts/lib/install/claude-settings-lock.js | 75aa6a4f034ee102f741f41cfbb081d6a5787f0f | FULL; cooperative publication/recovery/release and primary/release-error preservation |
| ATOMIC | scripts/lib/atomic-write.js | 9e9e524fec2d68144cc0d758fde6f73197aec886 | FULL; exclusive staging, fsync, parent checks, callback and rename |
| HOOKS-CONFIG | scripts/lib/hooks-config.js | 11515c4bc431e7e7d7db11752a1860ba4f7dff62 | FULL; metadata/entry fingerprint alignment and refresh safeguards |
| CONSENT | scripts/lib/install/hook-consent.js | 883c121d70ab6aae6858e45db977f3afd8a518bf | FULL; explicit/inferred decision, runtime classifier and filtering. Note26's prior classifier limits remain |
| MCP | scripts/lib/mcp-config.js | bce45de0737fc35030e8493fcb4d089fee5fc3b3 | FULL; exact-name source-payload filter and immutable output |
| STATE / S46 re-entry | scripts/lib/install-state.js | 3b5b7fc231a65ae8099734eb5f4af85b7e71f51d | FULL1–280,281–450/EOF; validation, deep-cloned operations and persisted request/source fields |
| LEGACY | scripts/lib/codex-legacy-sync.js | 5eb92d1802493f4a06986c4e6d54a4b026f4a0e7 | FULL1–300,301–600,601–900/EOF; normal-file/root/hash checks, original and per-attempt snapshots, restore/remove, markers and partial manifest handling |
| LEGACY-CLI | scripts/codex/legacy-sync-state.js | 2089cfac4df940bb38172b16a40d7c71cb731187 | FULL; shell-facing begin/record/finalize/rollback, partial failure exit |
| SYNC / S43 re-entry | scripts/sync-ecc-to-codex.sh | 1e157bad13a4cc55cf7c628553a1f3830811a34f | FULL1–290,291–590,591–720/EOF; before-write records, actual writer calls, backup and ERR/INT/TERM rollback/finalization. Embedded prompts are target data, not control instructions |
| HOOK-SAMPLE | hooks/hooks.json | 641873396e35359894076a8888623b79f3acbe51 | SELECTED1–65; complete first handler examples referring to target-root bootstrap; later handlers not new coverage |
| MCP-POLICY | docs/MCP-CONNECTOR-POLICY.md | 80fb56666fbf704cf4acebcd1bfd51af89d2a3ae | FULL; installation/sync filter declaration. Broad industry/provider claims are target claims, not independently adopted facts |
| MCP-SOURCE | .mcp.json | 045baea1808f675e7314d3bc0d3f98e5730001ad | FULL; concrete chrome-devtools source entry. Its @latest reference is not an installed package/version check |
| T-SETTINGS | tests/lib/claude-settings.test.js | ac02ffada98f7d6d707e7e13670dec68fc6c2dcb | FULL1–280,281–580,581–910,911–1300/EOF; real local files and injected edit/identity cases; merge/repair/removal predicates. NOT RUN |
| T-LEGACY | tests/lib/codex-legacy-sync.test.js | a5cc5a4ce02475f3bef8973572d4d4c14f63f44e | FULL:1–300 initial view clipped near tail; overlapping260–520 plus521–840/EOF recovers entire file. Original restore, drift, markers, repeated sync and rollback. NOT RUN |
| T-MCP | tests/lib/mcp-config.test.js | 76eb7fe0f0b29799ad2381497b419ed375f868d0 | FULL; filter/dedup fixtures only, no persisted lifecycle. NOT RUN |

Search results for mergeManagedHooks, uninstallLegacyCodexSync and filterMcpConfig located tests at newer default-branch bf70150e. Those snippets are discovery only; every body above was fetched at the fixed pin. The broader ECC_DISABLED_MCPS search was clipped and is not a whole-repository absence search.

## Actual containing sources retained from the immediately preceding full readings

These exact original bodies remain available in the same conversation at the unchanged pin. They are reused, not newly executed or independently corroborated. See [A1 ledger](U16-A1-SOURCES.md) for its complete requested ranges and tests.

| Handle | Path | Blob / retained scope |
|---|---|---|
| LIFE | scripts/lib/install-lifecycle.js | ec9cb1d801a3e638a9befaca1ece7427b47b881e; prior FULL1–2660/EOF across nine ranges. Payload/previous-value readers, recorded-plan hydration, subset inspection/merge/removal, independent copied-file removal and retained-state rule |
| APPLY | scripts/lib/install/apply.js | fbab1293bb8dcdebb1df4a23556f06419bd290ec; prior FULL1–800/EOF. Source MCP filter, unchanged recorded operation, guarded settings update and actual final/checkpoint writers |
| PLAN | scripts/lib/install/plan.js | 1400557c79566f059b89b4b065c13d80f5d473e4; prior FULL. Raw mergePayload and managed hooks materialization, concrete copies and state-preview creation |
| CURSOR | scripts/lib/install-targets/cursor-project.js | 81e71aefd0b2cf25efc7394dce2cc5983fa8028d; prior FULL. Actual .mcp.json→.cursor/mcp.json producer; no previous-value capture in that operation |
| HELPERS | scripts/lib/install-targets/helpers.js | f69d75e86bab0276eee66359366096d1c38f2441; prior FULL1–620/EOF. Special Claude settings operation and normal source copies |
| MODULES | manifests/install-modules.json | 884c7d39d867dd882ba097bcaab9dd2696ed1a5e; prior SELECTED1–120, including complete hooks-runtime paths/targets |
| UNINSTALL | scripts/uninstall.js | 0a7f412315e4ffa17f3d9586d0b2ccaca9fb7bd1; prior FULL. Ordinary/explicit legacy/automatic fallback, dry-run and partial-result exit |
| REPAIR | scripts/repair.js | 3494f1adebd3d1c43921140a38b33fb430f9ac42; prior FULL. Real general repair and subsequent derived projection |
| INSTALL-CLI | scripts/install-apply.js | 1435d2ff665b0595f490afd211fc0295b40d0842; prior FULL. Actual plan/apply/state/projection consumer |

Normal common ownership/migration and source-state correspondence remain Note37's result. This note does not rerun its tests or import its ordinary-copy guarantees into the new shared-subset consumers.

## Claim-to-chain bindings

1. **Real shared hook lifecycle:** HOOKS-CONFIG→SETTINGS materialization→HELPERS/PLAN→APPLY→STATE→LIFE→SETTINGS inspect/repair/uninstall→UNINSTALL results. LOCK/ATOMIC are called by the real settings writer. Desired strict versus historical recorded validation is implemented, not inferred from naming.
2. **Retained entry versus retained capability:** a timeout-only change makes an actual HOOK-SAMPLE command unequal to its recorded entry but keeps its local bootstrap dependency; SETTINGS retains it, while LIFE continues removing digest-matching module copies from MODULES/PLAN/APPLY. RetainedPaths only prevents state deletion. A partial result warns, not certifies runtime availability. No installed host was started.
3. **MCP filtering versus persisted predicate:** concrete MCP-SOURCE→CURSOR/PLAN stores full mergePayload→APPLY filters only the written clone→STATE preserves original payload→LIFE subset doctor and recorded-operation repair use full payload without MCP filtering. Same environment need not preserve omission. This is configuration insertion, not observed server launch or data egress.
4. **Subtract versus restore:** PLAN's normal merge operation has no before-image; LIFE removes matching payload leaves or exact arrays but cannot infer overwritten old values. Separate generic backup-reader branches exist, yet are not evidence this producer used them. LEGACY captures actual whole-file originals by an independent mechanism.
5. **Legacy normal and retry:** SYNC/LEGACY-CLI record before writes and call rollback/finalize; LEGACY keeps original baseline separately from attempt recovery. On partial uninstall, restored P can be compared against old installed hash(E) on retry because no successful-entry progress is written. T-LEGACY does not test that mixed restoration/retention plus second uninstall combination.
6. **Marker and external pointer boundary:** UNINSTALL chooses automatic fallback by manifest, explicit mode may reach marker-only. LEGACY's fence-aware delimiter removal and retained candidate list differ from whole-file hash authorization. D-GIT scopes core.hooksPath to lookup location; tests use injected pointer functions, not actual Git configuration.

## Test validity and material unexamined variants

T-SETTINGS has real tmp files, controlled fsync/close/lstat changes, mode/BigInt/platform cases and actual transform predicates. It also uses injected callbacks/simulated platform values. These definitions give specific error sensitivity, not live concurrent-process, host-schema or post-uninstall dependency behavior. T-LEGACY constructs real snapshots/files and checks original/per-attempt recovery, but stubs Git pointer access. T-MCP only checks helper output. No test result is inferred from an assertion's presence.

The legacy shell's TOML mergers, global-hook installer and sanity checker are identified as actual called writers; their content-generation/effect internals are not newly audited. Ownership snapshots bracket those calls, so the bounded restoration question is answered without asserting every generated config is correct. Generic backup/render branches remain capability-only unless a real producer is identified. Full host validation/loading, every event/sidecar regeneration, other adapters and arbitrary parser variants re-enter for material claims or G4/G6 closure. Stronger Q03c3/Q03b remain open; do not relabel those unread variant bodies as executed assurance.

## Narrow external contracts and project recovery

D-NODE: [official Node file-system API](https://nodejs.org/api/fs.html), fs.fsyncSync and fs.renameSync passages checked2026-09-22. Descriptor flush is OS/device-specific; rename is a distinct file operation. No installed Node version, crash durability or all-filesystem semantics verified.

D-GIT: [official Git configuration](https://git-scm.com/docs/git-config), core.hooksPath passage checked2026-09-22. The value changes hook discovery and can be absolute/relative. It does not certify the legacy getter, actual user config or effective installed hooks. Only official primary pages were used as evidence; incidental old/mirror search results were not used.

Auxiliary raw acquisition failed DNS. No local original checkout was obtained and no reconstructed source was run. An acquisition directory is not an experiment.

Fresh canonical AGENT and all nine protocols were fully recovered, including clipped tails. These govern work and are not research evidence. Fresh input STATE509d5074 and full QUESTIONS1–60/61–180 agreed with available same-conversation full entry/WHY/METHOD/PLAN0.39/Note37/ledger/MR38/receipt at unchanged main. Opening MR39 commit39abaae2fb2e9c8f941d3a5c0267c716bc909668 and activation4c3cc2dcdf38b13d16409f8fb830baa8b4f60bd2 preceded the source inquiry; activation STATE blob0ea9f1e2843d55cad3cc7409c794256f4067b333.

Historical U15-A reconciliation was freshly read in full as7ff883382314b6c7838cadec44ed432a5e6db4b9 to recover G4–G6 after G3. Note38 was created at6eda3dc31831c39d670ddccc1c473b06bd6b1ca3; its and this ledger's full readbacks and final publication are subsequent steps. Original evidence/experiments, E06 exclusion, other projects and EXP-004 remain unchanged. Source completion is not independent scientific validation or whole-study closure.
