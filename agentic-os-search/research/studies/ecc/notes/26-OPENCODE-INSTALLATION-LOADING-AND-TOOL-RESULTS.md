# Note26 — OpenCode installation, loading and tool results

**2026-09-19 · U12-B2 / Q02b2 · bounded source answer.** ECC target8321021c54d670126ce3b2969d5deb880b4b0c2a; versioned OpenCode comparator877be7e8e04142cd8fbebcb5e6c4b9617bf28cce/v1.4.3. [Exact sources](../evidence/U12-B2-SOURCES.md), [MR27](../ROUND-U12-B2.md), [STATE](../STATE.md). Read with [Note25](25-OPENCODE-CALLBACK-CONTRACTS-AND-GENERATED-ENTRY.md), which supplies callback/output contracts. No compiler, package, installation, live host/model or experiment was executed. Conditional examples below are source-derived, not observed incidents.

## 1. The original missing link is now explicit

OpenCode adaptation has several different materialization and loading routes, not one universal installed artifact:

| Route | Actual selection and responsibility |
|---|---|
| Nested package or explicit local package directory | .opencode/package.json declares dist/index.js as main. The host's package-entry resolver can select it. The generated root entry re-exports only the plugin function; wider commands/agents/instructions still require their own config/files |
| Repository reference config | .opencode/opencode.json points to ./plugins. The host resolves that relative to the config file, then finds the directory index. This is a source-plugin route, not automatic selection of dist/index.js |
| Managed OpenCode home install | The platform-configs module contains .opencode. The adapter maps its children to the chosen config root. The planner materializes recursive copy-file operations; applicable source plugins/tools, config and generated dist keep their relative locations. The copied ./plugins reference remains a source-plugin route |
| Bare root npm package | The pinned root manifest declares the installer binaries, includes .opencode and invokes build:opencode before packing, but has no main/exports binding to that nested compiled entry. The host resolver does not recursively adopt the nested manifest. Package contents and package-name entry selection are distinct |

The root manifest was fully recovered, so its missing explicit entry is no longer a truncated-view inference. However, no particular published tarball, default directory importer or installed package was tested. The separately observed07756cee revision does declare a root compiled entry; that observation is not a repin, release proof or a current compatibility guarantee.

The normal source chain is now CLI/request → normalized manifest request → module selection → adapter/root → concrete copy operations → actual apply → host config/path resolution → plugin registration/tool execution. This closes the original missing source-distribution responsibility without claiming every deployment works. Sources: B2-ROOT/CONFIG/MODULES/REQUEST/RUNTIME/CLI/REGISTRY/PLAN/APPLY, B1 package/entry, H2-SHARED/CONFIG/PATHS.

## 2. What installation validates, changes and does not bind

The configured target is chosen in this order: OPENCODE_CONFIG_DIR, XDG_CONFIG_HOME/opencode, then the selected home's .config/opencode. The home adapter's build precheck really is called by the registry before operation planning. It verifies one compiled entry file and two directories and rejects missing/wrong-type payloads, unless the caller explicitly exempts the relevant validation code. It does not inspect the complete import graph or callback compatibility.

Materialization recursively preserves relative paths, excluding specified runtime/generated state and ignored cache directories. When generic and OpenCode-specific copies target one destination, the last copy is retained. This avoids recording a superseded generic copy as the installed owner. Actual apply performs path/symlink checks, ordinary copy or explicit transforms, then records content digests. These are useful correspondence and ownership controls; the broader concurrency/ownership helper guarantees are not newly certified here.

The followed apply path does not rewrite OpenCode JSON to point ./plugins at ./dist/plugins. Markdown relative-link rewriting is a separate branch, and preserving prompt/command files preserves the locations used by their file references. The host itself resolves those file references relative to the config source. Therefore an existing dist file is neither proof that this route uses it nor a guarantee that every source import will resolve under a particular Node/Bun version.

The host has its own dependency step: for writable config directories it can update package.json to add @opencode-ai/plugin at the host version and run dependency installation. The nested lock's plugin1.4.3, root development dependency1.18.25 and a later host-resolved dependency are not one frozen tested environment. A successful ECC copy/digest does not freeze what the host later installs or edits. Sources: B2-PATH/REGISTRY/PLAN/APPLY, B1 adapter/TSC/lock, H2-CONFIG/PATHS.

## 3. Declining hooks does not remove every automatic OpenCode callback

This is a complete producer-to-selector-to-loader counterpart, not an argument based only on the flag's name.

parseInstallArgs maps --no-hooks to noHooks; normalization resolves it to hookConsent=declined. The request runtime calls withHookConsent, whose strip function removes operations classified as hook runtime. That classifier recognizes hooks-runtime module ownership, certain hooks/ paths, Cursor hook paths and Claude settings operations. It does not recognize .opencode/plugins or .opencode/dist plugin copies belonging to platform-configs.

Consequently, a selection retaining platform-configs can retain the OpenCode plugin while recording the declined decision. This can be constructed with an explicit platform-configs selection, without relying on an uncertain default-profile composition. The compiled-payload precheck and ordinary ownership/path checks still apply. If installation, dependencies and source loading succeed, the host can register its callbacks. The actual tool.execute.after path identified in Note25 can still track edits and, under the strict plugin profile, request a TypeScript check.

Positive controls remain: correctly classified hook operations are removed; explicit hooks-runtime combined with --no-hooks is rejected; loaded plugin profile and disabled-hook settings control their covered callbacks. The finding is narrower: the consent classifier's materialization scope does not cover every automatic behavior present in another module. Declined is a recorded decision under that classifier, not evidence that no automatic plugin code can load. No live consent bypass or unauthorized effect was executed. Sources: B2-REQUEST/RUNTIME/CONSENT/MODULES/PLAN/APPLY, H2-CONFIG and Note25's actual after-hook.

## 4. A valid local entry can register the same implementation twice

The versioned host scans direct .ts/.js files under plugin/plugins directories and also resolves configured plugin paths. The source directory contains both plugins/index.ts and plugins/ecc-hooks.ts. The former re-exports the latter's factory.

Config deduplication keys local origins by their file URLs. It can merge the explicit ./plugins directory entry after resolution with the same index.ts discovered by scanning. It does not merge index.ts and ecc-hooks.ts, because those are different URLs. The plugin application code's Set removes duplicate exports within each module, not the same function arriving from different modules.

Thus, when both modules resolve and initialize, the same factory can contribute two hook records. A real after-hook can then be invoked more than once, for example the strict post-edit TypeScript check. This is conditional on loading and the callback's own predicates; it is not measured duplicate execution or a claim that every installation loads two copies. Nested-package-only loading is a meaningful contrast: its default-only entry does not by itself ask the host to scan its internal source directory.

The tool registry also has separate local-file and plugin-map sources. Direct tool files and the tools/index.ts named exports can create different tool identifiers. These registration paths explain why a README inventory, a package export, a local file and a particular callable ID should not be treated as the same object. Sources: H2-CONFIG/SHARED, H1-DISPATCH/TOOLS, B1 barrel/hooks, B2-TOOLINDEX.

## 5. Legacy cleanup can target the newly installed canonical files

The actual cleanup helper exposed a consequential failure condition not visible from copying or build checks alone.

Normal migration is careful in several respects. It validates recorded root/target identity; only managed copy-file records with usable hashes are candidates. It compares the existing file against both its recorded digest and the current source, verifies regular-file identity, confines paths, and uses a quarantine/restore path around deletion. Modified or unverifiable managed content is retained rather than blindly removed. Cleanup is called only after the new install's state has been written.

But the legacy location is always derived as HOME/.opencode, while the supported explicit configuration root can also be HOME/.opencode. The complete helper has no check that the canonical and legacy roots differ.

The conditional chain is:

`explicit canonical root = HOME/.opencode → successful file/digest/state writes → cleanup derives the same legacy root → newly written state passes both identity checks → matching managed copies become removal candidates`.

For an unchanged regular plugin/config file copied byte-for-byte from its source, the newly stored digest and current source digest match, so the intended safety checks can permit removal of that newly installed file. Path confinement does not prevent this: the file is inside the permitted root. The problem is the role assigned to the root, not an escape from it.

This does not show deletion of every file or arbitrary user data. Rewritten Markdown or other changed/unverifiable content can be retained. If no retained records remain, cleanup may also remove the same state file; otherwise it can return a warning. The outer apply path can still return applied:true after either successful cleanup or nonfatal cleanup warnings. The source criterion therefore cannot equate applied:true plus an earlier state write with continued availability of the newly installed payload.

Assumptions are explicit: a matching homeDir, the explicit same-root selection, successful prior validation/copy/state writes, stable regular files and matching managed digests. No destructive test, filesystem migration or user-home mutation ran. The disjoint default .config/opencode versus .opencode layout is the normal counterexample; that layout does not create this root identity collision. Sources: B2-PATH/APPLY/MIGRATION/SAFETY.

## 6. Tools with similar names produce materially different evidence

All eight direct custom-tool bodies are now read across B1/B2. Their outputs are not one common task-success contract:

| Tool | What its implementation does | What the result does not establish |
|---|---|---|
| changed-files | Reads the tracked module-local map and renders paths/tree/JSON | Complete or durable per-session/Git history; Note25 retains its actual consumer and missing-store limits |
| dependency-analyzer | Reads dependency/dev/peer entries from package.json, returns an inventory and heuristic recommendations | Actual latest-version, vulnerability or unused-dependency analysis; fix and depth are not implemented effects |
| run-tests | Detects package/framework hints and returns a suggested command | A test process, passing tests or produced coverage |
| format-code / lint-check | Detects or defaults a tool and returns a command; these command-generation roles are explicitly documented | Formatting/linting/fixes actually performed, or installed executable availability |
| check-coverage | Reads the first usable selected report, parses a summary and compares its line percentage with the supplied threshold | Fresh tests or a report bound to the current revision; unfamiliar valid JSON can yield the parser's empty result rather than a new measurement |
| git-summary | Actually runs Git using separated arguments, with bounded depth/ref validation | That status=clean always means a successful status query; the helper turns command errors into empty text and the caller substitutes clean |
| security-audit | Performs bounded file/regex scans for secrets and code patterns; returns a dependency command marked pending | A dependency advisory scan having run, or full security coverage; ignored individual-file read errors can leave no findings |

The strongest misleading-success contrast is dependency-analyzer. Its constructed entries start with outdated=false, no vulnerability analysis populates security, and unused is fixed at zero. A successfully parsed manifest can therefore yield success:true with zero vulnerable/outdated/unused counts and a no-critical-issues recommendation without those checks occurring. analysisType and fixMode in the returned object do not change this evidence class. The dependency list is capped at50 while the summary counts the whole parsed inventory; that is also a presentation boundary, not50 checked packages.

Security-audit is a useful counterexample: it really reads selected files and searches patterns, and explicitly labels its unexecuted dependency command pending. Its own limits remain: selected paths/extensions, syntactic patterns and swallowed individual-file read failures. It is neither equivalent to the inventory helper nor a certified external scanner. Likewise git-summary demonstrates that some tools do execute a process, preventing a blanket all-tools-are-prose conclusion.

No tool was executed in this study. No vulnerability/advisory oracle, current repository cleanliness, coverage percentage or real test result was measured. Sources: B2-DEPS/RUN/FORMAT/LINT/COVERAGE/GIT/SECURITY, B1 changed-files and H1-TOOLS.

## 7. Failure, continuation and verification standing

The root builder removes dist before compiler lookup; a failed rebuild is not an atomic preservation/swap of the previous output. Because source and compiled routes differ, that fact alone is not proof that every active plugin route stops. The home precheck is useful but coarse. Missing optional tracking is deliberately degraded in B1; missing required imports, incompatible entry metadata, dependency installation failures and callback-contract mismatches are different failures.

The versioned loader distinguishes install, entry, compatibility and module-load errors. Its optional local retry requires a supplied wait callback; the B1 server caller does not supply that optional retry hook. This is not a universal in-process repair promise. Host-managed reload/cache/platform behavior remains empirical/version-specific.

B1's upstream tests build/import explicit generated files and directly call callbacks. They are useful for those local properties but do not establish bare-root package resolution, same-root migration safety, completeness of consent filtering or de-duplication across actual discovered modules. They were not run or newly expanded here. No same-shaped mock was added merely to produce another experiment count.

The additional source was necessary to close U12-B's original criterion, not a shift into fixing ECC. Actual effect and metadata ownership were followed through post-apply cleanup, which changed the explanation: preserving file identity can coexist with deleting the wrong lifecycle role. The note records that reasoning result, not an authorized remediation design.

## 8. Disposition and reuse

B1+B2 meet the bounded source question: authored/generated assets, distinct root/nested/local/managed routes, actual installer/config/loader, callbacks/tools and meaningful failure/continuation behavior are now connected. Q02b3 retains actual builds/tarballs/registry identity, exact host/Node/Bun/platform compatibility, extension/module-cache behavior, concurrent projects, crash/retry/durability, active policy/capture and accepted outcomes. Broader installer ownership/repair, other host adapters and the whole ECC study remain open at their own scopes.

Reusable distinctions are declared package versus resolved entry; generated payload versus selected runtime; recorded consent versus classifier coverage; export identity versus module-origin identity; trusted-root confinement versus canonical/legacy role separation; successful write versus surviving deployment; inventory/command/report/scan versus verified outcome. These are candidate research contributions, not Foundation taxonomy or adopted SOUL/Development OS architecture.

After verified publication, U12-C/Q02c is the next selected inquiry: Python llm-select/provider composition from pyproject.toml and src/llm CLI/core/providers. Trace actual selection, request normalization, provider call and response/error consumer without credentials or model execution. Native syntheses/CORE, remaining procedures/hosts, release/scanner/observability and final omissions remain later work.
