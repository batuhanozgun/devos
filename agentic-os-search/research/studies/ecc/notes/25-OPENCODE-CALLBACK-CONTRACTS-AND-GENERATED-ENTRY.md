# Note25 — OpenCode generated entry and callback contracts

**2026-09-19 · U12-B1 / Q02b1 · bounded SOURCE CHECKPOINT.** ECC target remains affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a. [Exact sources](../evidence/U12-B1-SOURCES.md), [MR26](../ROUND-U12-B.md), [STATE](../STATE.md). U12-B is PARTIAL; its original end-to-end distribution criterion is not yet closed. No build/test, installed host, provider/model or E09 was run.

## 1. What is being connected

The OpenCode adaptation is executable TypeScript, not only copied guidance. Its nested package points main/exports at generated dist files. The compiler configuration includes the entry, plugins and tools and emits NodeNext JavaScript and declarations. The top-level nested entry deliberately exports only the plugin function so a loader inspecting module exports does not mistake tool definitions for plugin functions. These are real source-level packaging choices. They are not evidence that a particular published package was built, selected or loaded.

The README and entry comments explicitly separate enabling the plugin from installing the wider command/agent/instruction catalog. The returned plugin registers two tools, changed-files and dependency-analyzer. Other listed tools and procedural assets may be available through separate local files/configuration; listing them in a README or compaction string does not itself register them. Only changed-files is traced to its implementation here.

Two build contexts are already distinct. The root prepack script invokes scripts/build-opencode.js, which resolves root TypeScript. The nested package has its own build/prepublishOnly scripts and lockfile. The root manifest declares plugin1.18.25/TypeScript6.0.3, whereas the nested lock records plugin/SDK1.4.3 and TypeScript5.9.3. The declarations must not be merged into a fictional single tested environment. Sources: B1-BUILD/PACKAGE/TSC/LOCK/ENTRY/ROOT/README.

## 2. A callback can run successfully without delivering its result

The principal comparison is between the complete pinned ECC plugin and **OpenCode v1.4.3**, tag resolved to877be7e8e04142cd8fbebcb5e6c4b9617bf28cce. That host version was selected because it matches the nested lock's version label. No claim is made that its source has been matched to downloaded registry bytes, a current latest host or an installed binary.

The host's actual trigger loop calls each handler with `(input, output)`, awaits the call, ignores its returned replacement value and returns the original output object. Its SDK types express Promise<void> for these handlers. Consequently, a plugin must mutate the supplied output fields to affect that route.

| Boundary | ECC's pinned handler | Versioned host consumer | Bounded consequence |
|---|---|---|---|
| shell.env | Constructs and returns an environment map | Supplies `{env:{}}`; Bash shellEnv merges the resulting `extra.env` | ECC's returned variables do not enter that output through this handler |
| experimental.session.compacting | Returns `{context: string, compaction_prompt: string}` | Supplies `{context:[], prompt:undefined}` and forms its prompt from those mutable fields | This returned ECC context/prompt does not alter the host compaction input |
| permission.ask | Returns `{approved, reason}` | The declared hook output is mutable `{status:'ask'|'deny'|'allow'}`; generic trigger does not replace it | Returning approved is not an applied host permission decision through that trigger |

This is more than an argument from naming or current documentation: the dispatcher and real shell/compaction consumers were read. Official documentation independently describes the same mutable-output interface, but is not an execution witness.

The result has important limits. The host still has its default environment, default compaction behavior, other plugins and native policy. Failure to inject an ECC-specific preservation block does not prove that the entire conversation context is lost. A returned approval being ignored is not a permission bypass. The current permission engine and every permission call site are not audited; the permission observation is a contract mismatch conditional on that hook being invoked through the inspected trigger. No actual model behavior was measured. Sources: B1-HOOKS, H1-TYPES/DISPATCH/SHELL/COMPACT, W-B1-DOC.

## 3. Event names are not automatically hook registration keys

The host bus dispatcher invokes `hook.event({event})`. The documented pattern then branches on `event.type`, for example session.idle. ECC instead places file.edited, session.created, session.idle, session.deleted, file.watcher.updated and todo.updated functions directly in its returned object. The complete plugin and its barrel contain no event bridge.

Under the inspected host route, those top-level names are not bus subscriptions. Thus having a function named session.idle is not enough to execute the console-log audit or clear its edited-file set at that event. A custom compatibility wrapper could translate them, but none is supplied by the followed nested entry. Whether a different installed distribution adds such a wrapper belongs to distribution/host validation, not an assumed absence across all environments.

Not every hook is disconnected. tool.execute.after is a genuine hook key and receives input.args under the SDK contract. ECC's post-edit/write tracking and strict TypeScript-check branch can therefore receive the fields they inspect. This normal path prevents a blanket conclusion that the plugin cannot do useful work. Its local hook-profile and disabled-hook predicates are real, although a predicate on an uncalled handler cannot make that handler active. Sources: B1-HOOKS/BARREL, H1-TYPES/DISPATCH.

## 4. Before and after have different input shapes

The SDK declares tool.execute.before with tool/session/call identifiers in input and arguments in output.args. ECC's before handler accepts one ToolInput and reads input.args. Its local ToolInput makes that field optional, so missing arguments ordinarily skip branches rather than report a contract error.

One material consequence concerns new-file classification. The before handler tries to remember whether a write target already exists. A contract-conforming before call does not put its arguments where that handler reads them, so it does not create the pending classification. The after handler does receive input.args. Without a matching pending entry, it records a write as modified. Thus a new file can be tracked yet classified as modified under this source combination. This is a conditional source result, not a performed filesystem experiment.

The same input-position mismatch affects before-call reminders. Separately, comments saying a documentation branch blocks creation are stronger than its body, which only logs a warning. Even a correctly delivered warning is not an enforced denial. Actual formatter/test commands, arbitrary Bash semantics and every permission path remain outside this checkpoint.

## 5. The test oracle bypasses the failing connection

The inspected hook tests are not mere text searches. They build the plugin, import the generated JavaScript, create temporary project markers and exercise controlled calls. Missing-store tests rename the generated helper directory and check that initialization and selected handlers remain callable. Those are meaningful test designs for the properties they actually inspect.

However, their shell test does `env = await hooks['shell.env']()` and asserts fields on the returned map. Permission tests directly assert the returned approved field. Session tests call hooks['session.created'] or hooks['session.deleted'] themselves. The build test checks named properties exist in the returned object and imports an explicit dist file. None of those assertions routes an event through the actual host bus or checks mutation of the host's supplied output object.

A locally correct returned object can therefore satisfy those expectations while contributing nothing through the versioned host trigger. Compilation does not close the gap either: ECC annotates its plugin factory as Promise<Record<string,unknown>>, rather than the SDK Plugin/Promise<Hooks> contract. Strict TypeScript checks within that broad declared shape are not a host-interface conformance test.

These are **inspected test definitions**, not claims that a particular suite ran green. No target compiler or test was executed by this study. A new same-shaped fake dispatcher would not establish installed-host behavior and was not added as a quota. The source comparison identifies which interface an eventual discriminating test must exercise. Sources: B1-HOOKTEST/BUILDTEST/Hooks, H1-DISPATCH/TYPES.

## 6. A useful, differently connected path: changed-files

The plugin's tool map has a real downstream consumer. The versioned host ToolRegistry takes definitions from each plugin's tool object and wraps their execute method. Unlike the lifecycle trigger, this wrapper uses the tool's returned string as output, potentially with truncation. The changed-files return value is therefore not lost for the same reason as the environment map.

The concrete path is post-tool callback → recordChange → module-local map → changed-files execute → filtered paths/tree/JSON → tool result. It can report edits recorded through the working after-hook path. It does not independently query Git or verify that every relevant write was observed.

The store is a module-local Map plus one worktreeRoot. initStore changes the root but does not clear the map; recordChange overwrites a path's last type; there is no persistence or session-key partition. The tool receives context but does not use it to isolate the query. Therefore 'No files changed in this session' means the tracked map is empty, not a proven complete scan of a session's changes. Multiple plugin instances sharing the same module can share that state; actual host instance/module isolation was not tested. Cleanup invoked directly by a unit test does not establish that the host's session-deleted bus route reaches it.

There is a real resilience improvement. Plugin initialization imports the optional store lazily and catches failure; its diagnostic even contains a synchronous/async logging guard, and later store calls use optional access. The changed-files tool also uses a lazy import, raises a specific invocation-time error and clears its local promise on rejection to permit another attempt. Thus a missing optional store need not invalidate the entire plugin module at evaluation time. This does not guarantee in-process repair, module-loader cache recovery, every other dependency or successful tracking afterward. Sources: B1-HOOKS/TOOL/STORE, H1-TOOLS.

## 7. Build readiness is not payload or callback validity

The root build script removes the old dist directory before locating TypeScript. If compiler resolution fails, the earlier dist has already been removed. A failed rebuild is therefore not automatically preservation of the last working generated payload. Compiler failure midway is also not handled as a staged atomic swap. These are source orderings; no broken build was run.

The OpenCode home adapter checks that dist/index.js is a file and dist/plugins and dist/tools are directories. It treats missing/wrong-type conditions differently from genuine filesystem faults and returns an actionable build error. That is useful preparation validation. But the three checks do not walk transitive imports or certify freshness, byte identity, event registration or the mutable-output contract. An empty helper directory can have the expected directory type without containing its required module.

The actual caller-to-materializer path is **not closed here**. The generic adapter helper selects native-root sync-root-children, while install-executor delegates to install/plan and install/apply. The reference config points at ./plugins; the nested package exports point at dist. Root package resolution is another route. Those routes must be traced before asserting that a build or package test establishes the actual installed plugin. Source: B1-ADAPTER/HELPERS/EXECUTOR/CONFIG/PACKAGE.

A search-index revision exposed a further reason not to collapse source identities: its root package header explicitly has main/exports pointing to .opencode/dist/index.js. That header was fetched at07756cee15788a54506031462794ad645719b028. It is a narrow separate revision observation, not a repin or evidence that any released package matches either snapshot. The current checkpoint makes no complete root-manifest absence claim or current-release failure claim.

## 8. Disposition, reuse and next responsibility

Q02b1 has a source-grounded answer about the generated entry, callback registration/output and one useful tool path, including failure and test-oracle counterparts. **The broader Q02b/U12-B remains PARTIAL.** Treating the untraced distribution and installer path as merely 'stronger live validation' would prematurely close the original question. PLAN0.27 splits that concrete source responsibility into U12-B2/Q02b2, not a new study or architecture phase.

Next: complete the root/nested package entry routes; install/plan and install/apply projection/config rewriting; OpenCode path and loader resolution; materialized transitive imports and meaningful remaining tool differences. Only then reassess the original source-to-distribution-to-active-consumer return condition. Q02b3 separately retains actual builds/tarballs, registry-source correspondence, loader caching, platforms, multi-project state, host behavior and efficacy.

Reuse distinctions: generated bytes versus a loadable entry; loadable entry versus subscribed callback; callback result versus consumed output; published interface versus producer-only oracle; locally typed shape versus SDK contract; tracked map versus complete per-session history; optional-feature degradation versus global startup failure. These are candidate research contributions, not adopted SOUL/Development OS design or Foundation taxonomy. Earlier findings and E06/E08/E07/E05 identities remain unchanged.
