# U12-B1 — Generated entry and callback-contract source ledger

**2026-09-19 · Q02b1 / SOURCE CHECKPOINT.** ECC pin remains [8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). [Note25](../notes/25-OPENCODE-CALLBACK-CONTRACTS-AND-GENERATED-ENTRY.md), [MR26](../ROUND-U12-B.md), [STATE](../STATE.md). U12-B as a whole is PARTIAL: package-name resolution, managed materialization/configuration rewriting and other distribution routes remain U12-B2, not merely untested runtime residuals. No E09, target code/test/build, installed host, model/provider or installation ran.

## ECC sources at the fixed pin

FULL means the named file was read through EOF. SELECTED means only the stated ranges/functions; incidental material does not close its family. All target bodies were acquired through connected GitHub, not a local checkout.

| Handle | Path / Git blob | Actual scope |
|---|---|---|
| B1-BUILD / S169 | scripts/build-opencode.js / 73610cd387316cfd9421ff5b36cf695afa857710 | FULL. Removes dist, resolves root TypeScript, invokes compiler with .opencode/tsconfig |
| B1-PACKAGE | .opencode/package.json / 94e8e3f04247e078703256141d65daf07af27f8a | FULL. Nested package main/exports/files/scripts and dependency declarations |
| B1-TSC | .opencode/tsconfig.json / c6b43257be22a74cff7e4dea67eea5fc9cfe1ae6 | FULL. NodeNext/ES2022, rootDir/outDir, declaration/source maps, included TS sources |
| B1-LOCK | .opencode/package-lock.json / f6c140bdd253f395f7fc9f28a9510205666bcd85 | FULL. Nested plugin/SDK1.4.3, TS5.9.3; not root dependency equivalence or installed tarball proof |
| B1-ENTRY | .opencode/index.ts / fa6cadc58f4be4380bdb5516983039988cd7ea4c | FULL. Default plugin-only re-export; config/assets remain separate |
| B1-BARREL | .opencode/plugins/index.ts / c1e17a1595403080490fcec6820c1485bb6afba9 | FULL. Re-exports hook plugin, not a callback-translation wrapper |
| B1-HOOKS | .opencode/plugins/ecc-hooks.ts / 22b1132f0964bd4ba5c1a4ad1bafa605de99eb6a | FULL1–220/221–430/431–680 through EOF. Initialization, dynamic store, profiles, returned hook map and two registered tools |
| B1-TOOL | .opencode/tools/changed-files.ts / 1150ca7565843063d85623ef91a0ce1446a3c6ab | FULL. Lazy import, failure message/promise reset, schema and execute-to-store/render path |
| B1-STORE | .opencode/plugins/lib/changed-files-store.ts / df22f812f32258ed34136ed9c1c892af3bd6307c | FULL. Module-local map/root, normalization, overwrite, clear, tree and filtered list |
| B1-README | .opencode/README.md / e239c136180318a111e1b0c7ed0e27ec26ed40e2 | FULL. Multiple install modes, explicit plugin-only versus full config distinction; feature claims not execution evidence |
| B1-ROOT | package.json / 87487a914c0fd739ea62107e7bf9e56b127207a5 | SELECTED. Initial whole request display-truncated; header/files prefix observed,430–700 through EOF recovered build:opencode/prepack and root plugin1.18.25/TS6.0.3. Not a full manifest absence audit |
| B1-CONFIG | .opencode/opencode.json / 2933339c6ca4132b2e8c4b05c1b01c66cdfb3b42 | SELECTED1–100. Relative ./plugins reference, instructions/skills and beginning of agent config. Remainder and installed rewrites remain open |
| B1-ADAPTER | scripts/lib/install-targets/opencode-home.js / d25fdf7da76e590b2f58d5cd3faeedfa3b027252 | FULL. Three path/type checks; ENOENT/ENOTDIR distinguished from genuine system errors; native root and path resolver |
| B1-HELPERS | scripts/lib/install-targets/helpers.js / f69d75e86bab0276eee66359366096d1c38f2441 | FULL1–240/241–520 through EOF. Adapter validation dispatch, native-root sync-root-children planning; actual materializer remains separate |
| B1-EXECUTOR | scripts/lib/install-executor.js / 72eac5e8a9868ac1632121977c1281c026afe50b | SELECTED1–230. Imports actual install/plan and install/apply modules; earlier copy helpers and legacy beginning are not complete managed OpenCode closure |
| B1-HOOKTEST | tests/opencode-plugin-hooks.test.js / 0d261ef5c9a6061cceb21ea700339157198ae8ac | FULL1–230/231–520 through EOF. Builds/imports plugin but directly invokes named callbacks and asserts their return objects. Missing-store rename case and file/directory probes present. NOT RUN |
| B1-BUILDTEST | tests/scripts/build-opencode.test.js / 469165883d604a6e6820721a734ba42d466a5526 | FULL through EOF. Compiler/explicit-file import/default export/hook and tool shapes/npm dry-run path assertions. Does not exercise actual host bus/trigger or bare package resolution. NOT RUN |

Pinned [hook implementation](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/.opencode/plugins/ecc-hooks.ts), [build](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/scripts/build-opencode.js), [hook tests](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/tests/opencode-plugin-hooks.test.js), [build tests](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/tests/scripts/build-opencode.test.js).

## Versioned downstream consumer

The official plugin documentation's repository link identifies anomalyco/opencode. Its v1.4.3 tag resolved to **877be7e8e04142cd8fbebcb5e6c4b9617bf28cce**. This version is deliberately tied to the nested ECC lockfile, not declared the latest host or proven identical to registry bytes/a user's installation. The root build declares a different plugin dependency; that distinction remains.

| Handle | Host path / blob at877be7e | Actual scope |
|---|---|---|
| H1-TYPES | packages/plugin/src/index.ts / 1afb55daa76e466317e66dd2e24753777bf4787c | FULL1–250/251–400 through EOF. Plugin returns Hooks; event, before/after, shell.env, compacting and permission output contracts |
| H1-DISPATCH | packages/opencode/src/plugin/index.ts / 814e7870a44e1f0c2ef8f5e3fe98f600ddfeca59 | FULL1–260/261–390 through EOF. Plugin application, config callback, bus event dispatch and trigger. Calls fn(input,output), discards its value, returns supplied output |
| H1-SHELL | packages/opencode/src/tool/bash.ts / 365fda329604b08b98541301173d6791d8425715 | SELECTED100–270/271–510 through EOF. Full shellEnv, execution and BashTool body; parser setup/constants before100 not read. shellEnv merges trigger result.env, not arbitrary hook return |
| H1-COMPACT | packages/opencode/src/session/compaction.ts / 9753271989063bc007524669b3e7e6ad37ce3673 | SELECTED1–240. Actual compacting trigger with context:[], prompt:undefined and construction of prompt from those fields. Remaining model execution/compaction lifecycle not closed |
| H1-TOOLS | packages/opencode/src/tool/registry.ts / 800c45ced0c03d82ebb5a57945cd5e0258c98f52 | SELECTED1–250. Complete fromPlugin wrapper, local-file/plugin tool registration and selected tools mapping. Calls def.execute, unlike lifecycle trigger which ignores returned replacement objects; output may be truncated |

Pinned host [SDK types](https://github.com/anomalyco/opencode/blob/877be7e8e04142cd8fbebcb5e6c4b9617bf28cce/packages/plugin/src/index.ts), [dispatcher](https://github.com/anomalyco/opencode/blob/877be7e8e04142cd8fbebcb5e6c4b9617bf28cce/packages/opencode/src/plugin/index.ts), [Bash](https://github.com/anomalyco/opencode/blob/877be7e8e04142cd8fbebcb5e6c4b9617bf28cce/packages/opencode/src/tool/bash.ts), [compaction](https://github.com/anomalyco/opencode/blob/877be7e8e04142cd8fbebcb5e6c4b9617bf28cce/packages/opencode/src/session/compaction.ts), [tool registry](https://github.com/anomalyco/opencode/blob/877be7e8e04142cd8fbebcb5e6c4b9617bf28cce/packages/opencode/src/tool/registry.ts).

W-B1-DOC: [official plugin documentation](https://opencode.ai/docs/plugins/), viewed2026-09-19, page displays last updated2026-08-09. Selected event example, before-hook output.args, output.env, output.context/output.prompt, plugin-only versus local tool discovery. Dated documentation supports the versioned-source comparison; it is not an independent experiment or a universal compatibility verdict.

## Joined source results

1. B1-HOOKS returns env/context/approved objects; H1-DISPATCH ignores such returned replacements. H1-SHELL and H1-COMPACT actually consume the original output object. Therefore those ECC additions are not delivered through this versioned route, even if plugin initialization and callback invocation succeed. The host retains its normal env/default compaction and other policies; no total loss of memory or permission bypass is implied.
2. The host bus invokes hook.event({event}); ECC puts file.edited/session.created/session.idle/session.deleted/watcher/todo functions directly at the top level and supplies no event bridge. Their names alone do not subscribe them on this route.
3. before receives args in output, while ECC reads input.args. Its write preclassification/reminders therefore do not see a contract-conforming before payload. after does receive input.args, so edit/write post-tracking and strict typecheck can still run. A newly written file without its pending before entry is recorded modified by the after fallback. No live file change was performed.
4. Tool return values have a different real consumer: H1-TOOLS invokes def.execute and uses its returned string. changed-files is genuinely registered by the plugin and can expose the module's tracked map. It is not a Git snapshot, durable per-session ledger or proof that every write was captured; session context is not used to partition that map.
5. Lazy optional-store initialization and lazy tool import preserve a narrow resilience boundary. Startup failure is caught and optional calls are guarded; tool failure clears its local promise before surfacing a specific error. Successful in-process repair, loader cache behavior and every other dependency remain unverified.
6. The root build deletes old dist before finding TypeScript. A missing compiler can leave no prior dist; this is source ordering, not an executed failure. Home validation checks index.js/file plus plugins and tools/directories, not their transitive imports, freshness or host contract. A valid outer shape does not certify complete/working payload.

## Discovery, freshness and limits

The initial .opencode contents response and scripts/lib listing were display-truncated; they were discovery only. The plugins recursive tree429575eda2a05e9052a151d6d4386c9cd28e7c02 and install-targets direct treec93bb68011d914ca215ba54b17dd8d4c73183dbc were fully read with truncated:false. No full .opencode descendants/tool catalog coverage is claimed. A guessed scripts/lib/install-targets.js returned404; the actual directory adapter was then recovered. No raw-download retry, local checkout or tool execution was needed.

Search covers an indexed revision, not the research pin. It revealed package-entry differences, so package.json1–65 was directly checked at indexed revision07756cee15788a54506031462794ad645719b028, blob70a31ff8d2c904199a98205fae5137765a344d8c: it explicitly declares .opencode/dist/index.js main/exports. This is a **separate narrow revision observation**, not a repin, complete change audit, latest-head claim or proof about any released tarball. U12-B2 must compare root/nested/installed identity directly rather than import indexed fixes into the old source explanation.

Tests were read, not run. Their source definitions use real compilation/import steps but controlled clients/shell and direct callback calls. A returned env or approved object can satisfy that oracle without changing the host's output object. TypeScript strict mode does not establish the missing contract: ECC declares Promise<Record<string,unknown>>, not the SDK Plugin return type. No claim is made that an actual upstream CI run passed or failed.

## Remaining responsibility

Q02b1 has a bounded callback/consumer source answer. Q02b2/U12-B2 remains substantive source work: full root and nested manifests/export resolution, install/plan and install/apply OpenCode projection and config rewriting, opencode-paths/actual host config and package loader, materialized imports and selected leaf tools. Q02b3 preserves actual build/tarball/module cache/API/platform/multi-project/host behavior and efficacy. The original U12-B end-to-end return condition is not yet fully met. Prior E06/E08/E07/E05 evidence classes are unchanged; no implementation/adoption follows.
