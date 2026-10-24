# Note51 — Cursor deployment, data-root selection and context handoff

**2026-09-24 · U19-C / G6 / O2 / Q01a2c / MR52 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Sources and exact reading limits](../evidence/U19-C-SOURCES.md), [round](../ROUND-U19-C.md), [STATE](../STATE.md). Source observations, inspected test definitions and conditional deductions; no installation, target execution, live Cursor/model or E11.

## 1. Result: a real location policy, but several distinct deployment and delivery contracts

The shared data-home helper genuinely resolves an explicit environment setting, a constrained project setting and harness-sensitive defaults. Shared session and learned-skill helpers use that result. However, this does not establish that every Cursor installation supplies the environment hook, that a deployed wrapper invokes the copied common script, or that generated context reaches the host.

This unit follows the public request normalizer, actual manifest resolution and materialization, the retained older planner, Cursor wrappers, shared session readers/writer and the documented host output boundary. It refines Note49's observation that a scaffold has a real planner caller: **that caller is not the ordinary public CLI's selected plan**. Existing installation and learning findings remain valid at their original scope; a directory label or helper call must not be promoted to all-route behavior.

The three decisive joins are request-to-planner, installed-path-to-child-path and child-result-to-host-output. They have different failure conditions. Correcting one in an imagined setup would not itself correct the others. Sources: ENTRY, REQUEST, RUNTIME, LEGACY, RESOLVER, CURSOR, HELPERS, PLAN, APPLY, C-ADAPTER, C-START, DATA-HOME, UTILS.

## 2. Normal installation and the retained legacy planner take different routes

ENTRY parses CLI options and uses normalizeInstallRequest before createInstallPlanFromRequest. REQUEST returns manifest for explicit profile/module/component selection and legacy-compat for positional languages. It never returns legacy. RUNTIME retains a separate legacy branch for callers that explicitly supply that mode, but the ordinary normalizer does not select it.

Both the ordinary manifest route and legacy-compat eventually enter createManifestInstallPlan. RESOLVER's Cursor legacy-compat base includes hooks-runtime and platform-configs, among other modules; explicit modules can also select those two. Each has Cursor in its target list and no declared dependencies. RESOLVER validates target/module selection, calls the registered Cursor adapter and returns its operations. This is an actual caller chain, not inferred from exported names. MODULES is read only through the complete relevant entries, not the whole module catalogue.

The retained createLegacyInstallPlan instead calls planCursorLegacyInstall. That builder copies native Cursor assets and then calls addCursorAgentDataScaffoldOperations. It adds the data-home JSON, always-on rule, environment-hook configuration and three named helper/script copies. These are real operations, but they belong to that explicit legacy-plan path. No universal absence of another custom caller is asserted. [ENTRY→REQUEST→RUNTIME→LEGACY/PLAN→RESOLVER→CURSOR]

For the concrete normal selection containing platform-configs and hooks-runtime, CURSOR maps the native .cursor children and the requested shared script trees. It does not call the old scaffold builder. The fixed native .cursor root contains hooks.json, hooks, rules and skills; it does not contain the separate scaffold's data-home JSON or scripts directory. Consequently that selected plan does not automatically install the separate environment-hook scaffold. This does **not** imply that the shared helper always falls back to Claude: Cursor's inherited environment markers provide a distinct positive path described below.

CONSENT is a real pre-effect gate. Native Cursor hooks as well as hooks-runtime operations are recognized; applying a materializing plan requires an enabled decision, while declining filters hook operations. The source counterpart in the next section explicitly stipulates consent, valid sources, a fresh eligible destination and successful materialization. It is not an approval-bypass finding.

## 3. The normal installed script location and the wrapper's lookup location disagree

Let P be a user's project distinct from the ECC source checkout. For the selected normal plan:

| Object | Path established by the actual source |
|---|---|
| Installed Cursor wrapper/adapter | P/.cursor/hooks/session-start.js and P/.cursor/hooks/adapter.js |
| Installed common SessionStart implementation | P/.cursor/scripts/hooks/session-start.js |
| Installed shared helpers | P/.cursor/scripts/lib/... |
| Common implementation sought by the wrapper | P/scripts/hooks/session-start.js |

CURSOR explicitly remaps the .cursor children to the target root. Other module paths use HELPERS' default targetRoot/sourceRelativePath mapping; PLAN expands directory operations into actual copies. APPLY copies these JavaScript files unchanged: its declared Antigravity and Markdown-link transformations do not rewrite this adapter's JavaScript lookup. [MODULES→CURSOR→HELPERS→PLAN→APPLY]

C-ADAPTER computes its root as two parents above __dirname, then appends scripts/hooks/<name>. At P/.cursor/hooks that is P/scripts/hooks, not P/.cursor/scripts/hooks. With no separate common implementation at the former path and a usable Node executable, the configured wrapper reaches a missing child path despite the expected implementation having been materialized elsewhere.

The failure projection is also explicit. runExistingHook captures stdout/stderr, catches child failure, and only forwards status2 as a blocking exit. A missing entry script's ordinary non-2 failure is swallowed; C-START can then emit the original input. This is a conditional source result, not an observed successful installation followed by a failing Cursor session. User-owned-file skips, custom contents, source versions, native host loading and installed Node behavior remain separate conditions.

A useful countercase limits the claim: when the same native wrapper runs from the full ECC checkout, the root scripts/hooks location exists. The lookup convention suits that source layout. A manually supplied compatible root implementation could also change the result. Neither alternative proves the normal installed layout coherent, and neither removes the next input/output mismatch.

## 4. Even a reachable child does not complete the context handoff

C-ADAPTER transforms shell/file fields and a transcript path. It stores Cursor conversation/event/workspace/model information under _cursor, but does not produce the top-level SessionStart event/source envelope expected by S-START. S-START's getSessionStartMode treats this nonempty transformed object as an unrecognized event and skips its prior-session-summary branch. It can still create/prune directories, process instincts and learned-skill summaries and detect the project. Therefore this is not a claim that the child performs no work or can produce no context.

There is an independent output boundary. runExistingHook does not return or forward the child stdout. C-START ignores any child result and writes its original raw input. It does not translate hookSpecificOutput.additionalContext into Cursor's additional_context output. Even when a common implementation is reachable and produces useful context, that produced context is not carried by this wrapper's output route. [C-START→C-ADAPTER→S-START]

The current official Cursor hook documentation describes project-root execution, sessionStart's env/additional_context outputs and availability of env to later hook executions. It also describes the startup callback as asynchronous rather than a blocking admission guarantee. This is a dated host-interface reference, not a pinned installed-host or scheduler test. It does not warrant assuming that every tool, MCP server or model subprocess inherits an output environment setting. [D-CURSOR]

The separate ENV-HOOK does emit Cursor-shaped env and additional_context. Its context describes the chosen storage location; it is not the saved session contents. Producing a correct location message, producing memory context and delivering either to the host are distinct responsibilities.

## 5. What the shared data-root boundary actually protects and preserves

DATA-HOME resolves in this order: explicit ECC_AGENT_DATA_HOME; eligible project .cursor/ecc-agent-data.json; Cursor default when explicitly preferred or CURSOR_VERSION/CURSOR_PROJECT_DIR is present; otherwise Claude default. The project-config branch requires a user-anchored path without parent traversal and delegates allowed-root containment to path-safety for the default Cursor/Claude directories. Explicit environment selection is treated as a trusted override rather than the same restricted workspace input.

UTILS' historically named getClaudeDir is an alias for getAgentDataHome. It does not always mean ~/.claude. Concrete consumers use:

- R/session-data for current session files;
- R/sessions as the legacy search location under the same selected R;
- R/skills/learned for learned-skill discovery.

S-START uses those actual getters to create directories and read eligible session/learned files. S-END uses getSessionsDir to write its session file. Thus a reachable shared reader/writer can select ~/.cursor/ecc from inherited Cursor markers even when the separate environment hook was not installed. The missing scaffold does not establish cross-harness leakage. D-CURSOR documents those markers; installed propagation was not exercised.

Changing R changes the subsequent search/write locations in these paths. The canonical/legacy search pair is not an automatic migration between two different R values. A permitted project config can intentionally select a Claude-data location; the resolver also consults project configuration before its harness default. Default separation, deliberate sharing and actual access isolation are therefore different objects, not three names for one promise.

The boundary is not all ECC memory. OBSERVER independently chooses CLV2_HOMUNCULUS_DIR, XDG_DATA_HOME/ecc-homunculus or ~/.local/share/ecc-homunculus and supplies project/global instinct locations. S-START can combine those instincts with summaries from the selected agent-data root. The original Memory Vault research retains its own scope contract; this unit does not reclassify it or certify every database, alias, metric or third-party tool by one environment variable. [DATA-HOME, UTILS, S-START, S-END, OBSERVER; original Note07 and Note06]

## 6. Retained legacy scaffold: a narrower deployment/dependency counterpart

For an explicitly requested legacy plan into a fresh target, the scaffold builder copies cursor-session-env.js, agent-data-home.js and utils.js. DATA-HOME has a top-level require('./path-safety'), but that helper is not among those three copied dependencies. The original legacy plan does not also copy the full shared scripts/lib tree. With no separately present dependency, importing the installed environment hook fails before its asynchronous fallback handler can run. This is a source-defined dependency gap in that route, not evidence that the normal manifest route lacks path-safety: hooks-runtime copies the shared library tree there.

The old builder also uses a generic merge-json operation for the scaffold hook configuration. APPLY's deepMergeJson recurses over objects but replaces arrays. Consequently its sessionStart array replaces the previously copied native sessionStart array rather than composing both handlers. Other events can remain. This describes selected old-plan semantics, not a claim that the current public installer executes that merge. [LEGACY, SCAFFOLD-HOOK, ENV-HOOK, DATA-HOME, APPLY]

The same distinction explains why a direct helper test from the repository can be useful and still miss an installed dependency gap. Correct function behavior with its source dependencies available is not evidence that a particular packaging path copies those dependencies.

## 7. Session lifecycle, useful records and test limits

C-END calls session-end-marker, the lightweight observer cleanup path already explained in Note50. C-STOP instead calls the rich session-end writer along with other helpers. Their names/descriptions do not make them the same lifecycle event. The same adapter path issue applies to these common-script lookups; do not claim the writer ran merely because a stop callback exists.

S-END reads the supplied transcript path or a Claude environment fallback, extracts bounded task/tool/file information when recognizable, and writes a dated session file with worktree/project metadata. It prefers a transcript UUID for the filename, otherwise the shared session-ID/project fallback. Missing or unusable transcript content can still produce a placeholder record. A file's presence is therefore not proof of recovered conversation content. A configured threshold can invoke an LLM-summary helper; that branch was not executed or newly audited as a provider mechanism. S-START's eligibility checks exclude the explicit placeholder and prefer a matching worktree for historical replay. Those are useful controls even though the Cursor wrapper does not complete their output handoff.

T-DATA was fully inspected, not run. It tests the actual resolver with controlled environment variables, temporary configuration files, valid sharing, invalid/traversal destinations and symlink escapes. The suite supplies real local helper assertions, not original Cursor installation or host-context delivery. Its whole file does not install the normal selected layout and then invoke the installed sessionStart through Cursor. No repository-wide absence of other tests is inferred. Existing installation/guard tests retain the scopes recorded in Notes02–03/37–38. Target-test metadata/search was navigation, not a completed all-suite audit.

## 8. Bounded completion and next responsibility

Q01a2c receives a source answer through the real public selection/materialization path, actual wrapper/child boundaries and concrete root readers/writer. Useful consent, copy ownership, path-selection checks, harness defaults and historical-summary filtering are preserved. The counterparts are conditional code paths, not measured failures, data loss, security certification, model obedience or observed user incidents.

Q01a2c2 retains installed source/package/host/Node correspondence; full native/third-party/cloud/multi-root variants; final input/env uptake; transcript identity and format; configuration changes and cross-root migration; concurrency/crash/recovery; path-safety/runtime authority and useful outcomes. Missing target execution does not erase this joined source answer or require an unlimited live campaign.

**Next selected U19-D / G6 / O2: remaining legacy Codex baseline/generator/validation reconciliation, NOT STARTED.** Start with Note48 and U18-I-SOURCES, the actual sync wrapper and global checker; recover the non-MCP baseline/instruction generators and their true consumers only where they can change the system account. The already explained MCP merger/rollback must not be repeated as a new result. Kiro and other material variants remain qualified obligations rather than an automatic unit per host. O3 broad-document/mirror/example challenge, revised CORE and joint evaluation remain open. No upstream fix or SOUL/Development OS design follows.
