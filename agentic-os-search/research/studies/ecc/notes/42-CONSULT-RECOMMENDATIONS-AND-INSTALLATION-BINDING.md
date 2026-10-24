# Note42 — Consult recommendations and installation binding

**2026-09-23 · U18-C / G5 / Q02f / MR43 · BOUNDED SOURCE ANSWER.** Fixed ECC `8321021c54d670126ce3b2969d5deb880b4b0c2a`. [Exact sources](../evidence/U18-C-SOURCES.md), [round](../ROUND-U18-C.md), [STATE](../STATE.md). Source observations, inspected test definitions and explicit conditional inference. No target execution, installation, E11, model/provider trial or user-configuration mutation.

## 1. The useful mechanism is catalog discovery, not requirements discovery

The public `ecc consult` command dispatches to `scripts/consult.js`; the package's `ecc-universal` binary maps to that dispatcher. Consult reads ECC's own install catalog, matches a supplied query, returns ranked components and related profiles, and prints commands for preview and installation. It does not call a model, inspect the host project's code, ask follow-up questions, install anything or validate a completed user outcome. Its useful responsibility is making existing selectable assets discoverable from familiar words. It is not merely a manually written recommendation, but neither is the larger needs-analysis problem implemented by this command. [CONSULT, CLI, PACKAGE]

The source chain is:

`query + target → local manifests/skill-directory catalog → lexical ranking → command strings → caller invokes plan/install → normalized configuration + dependency/adapter resolution → materialized operations → guarded application/state`.

These arrows have different owners. Consult supplies a report and suggested next steps. A human or host agent chooses whether and where to run them. The installer, not the recommendation score, owns dependency resolution, destinations and file mutation. No persisted consultation or accepted-plan token connects all these stages. [CONSULT, PLAN-CLI, APPLY-CLI, REQUEST, RUNTIME, PLAN, APPLY]

## 2. What the query and score actually mean

Consult lowercases text, normalizes `.js`, removes characters outside its ASCII token alphabet, filters a small English stop-word set and applies suffix expansion. It scores exact tokens, some substring matches and hand-authored preferences. The first query token receives different weight; a component whose suffix matches it gets an additional preference. Capability-family components and specific security/MLE contexts receive other bonuses. Ties are ordered by family and ID. Query deduplication, positive-score filtering, CLI target validation, a bounded result limit and explicit match reasons are useful deterministic controls. [CONSULT]

The search corpus uses IDs, descriptions, module names and aliases, not the complete skill/agent bodies or observed capability results. The score is a matching heuristic, not confidence, installability, cost, quality or measured need satisfaction. Match reasons identify exact/fuzzy token matches but do not itemize every preference bonus. The CLI's empty-token query error is distinct from a nonempty query with no positive component match, which produces a normal report and browsing/refinement suggestions. Profiles can still be present in that report. [CONSULT]

There is no negation, exclusion or prerequisite interpretation in this query path. Mentioning a capability in a negative sentence does not become `--without`; the named word can still contribute a positive match. This is a source-level limitation of the matcher, not an observed misunderstanding rate. Token normalization also does not establish multilingual semantic search. Neither limitation makes the tool useless as catalog search; it prevents treating free-form input as an accepted requirements specification.

The actual tests use subprocesses and the real checked-out catalog. They specify security/MLE ranking, avoidance of generic-review-to-MLE confusion, a Next.js/React query from another working directory, target/limit filtering and selected argument errors. The MLE negative cases are meaningful counter-tests rather than only happy paths. They do not independently establish that the catalog fits a project's actual needs. [T-CONSULT]

## 3. Catalog membership and target compatibility have narrower meanings than installation

`loadInstallManifests` reads the module/profile manifests and optionally the component manifest relative to the ECC source/package location. It also synthesizes `skill:<directory>` components from directories under `skills`. A synthetic module created by this path gets all declared supported target IDs, no dependencies and a generated description. Directory discovery is not a complete SKILL.md interpretation or host-conformance test. Existing explicit components are not replaced by that synthesis. [MANIFESTS]

For ordinary components, `listInstallComponents({target})` intersects the declared targets of the component's directly named, found modules. It does not resolve their dependencies or invoke the target adapter's `supportsModule`/validation/operation path. Missing module records are filtered out at this discovery stage, whereas later resolution rejects unknown requested/dependency IDs. Profiles are ranked from `listInstallProfiles()` without corresponding target filtering; the requested target is nevertheless written into every profile command. Profile module counts are direct declarations, not an expanded install closure. [MANIFESTS, CONSULT]

The downstream resolver is materially stronger. It validates requested targets and IDs, expands component selections, applies exclusions, detects dependency cycles, rejects dependencies excluded by selection, checks target support and adapter support, then creates a scaffold operation plan. An unsupported dependency causes the requesting root module to be skipped, rather than being silently installed despite its prerequisite. The report retains selected/skipped/excluded distinctions. These are useful refusal and explanation mechanisms, not proof that every recommendation was installable before reaching them. [MANIFESTS, REGISTRY]

### Concrete counter-reading: Next.js can be recommended for Codex and then skipped

The pinned component `framework:nextjs` maps to `framework-language`. That module lists Codex among its targets, so the catalog's direct-module target check admits it. A `nextjs` query supplies exact/alias matching and the suffix preference; this is a genuine recommendation candidate under the inspected matcher. [COMPONENTS, MODULES, CONSULT, MANIFESTS]

But `framework-language` requires `rules-core`, `agents-core`, `commands-core` and `platform-configs`. The same pinned manifest does not list Codex in `rules-core`'s targets. `resolveInstallPlan` therefore returns false for that required dependency and records the requesting framework module as skipped. `commands-core` also lacks Codex, but the first dependency already discriminates the case. This counterexample does not require a changed catalog, malformed request or live host failure. [MODULES, MANIFESTS]

The generated command includes a baseline profile, so other eligible modules can remain selected while the specifically recommended framework module is absent. The installer can report that absence; there is no consult-specific predicate requiring the selected recommendation to survive resolution before the remaining plan proceeds. A positive match and a successful source-level planning path must not be interpreted as delivery of that recommended capability. This is a conditional source prediction, not an executed installation or an observed user loss. Actual apply success still depends on its own controls and environment.

## 4. Distinct recommendation names can select the same broad material

Next.js, React, Python and several other language/framework component IDs all map to the same `framework-language` module. Its paths contain a broad collection of framework/language skills, not only the skill named in a particular query. The component descriptions explicitly acknowledge that shared mapping. Multiple matching IDs therefore need not mean multiple disjoint packages or separate installed capabilities. A component command also includes the `minimal` profile, whose declared baseline contains rules, agents, commands, platform configuration and quality-workflow support. The word minimal is an upstream profile name, not this study's recommendation to minimize the user's system. [COMPONENTS, MODULES, PROFILES, CONSULT]

Exclusion follows module identity as well. Excluding `framework:react` removes the same framework module selected by `framework:nextjs`; it is not a semantic subtraction of only React material. This behavior follows the actual expansion/excluded-module map. It can be deliberate catalog granularity, but a consumer must not assume component labels are independently composable units. [MANIFESTS, COMPONENTS]

Consult does not read the caller's `ecc-install.json`. Both generated command consumers can discover it in their current directory and validate it. Normalization gives explicit CLI profile/target priority, while unioning configured and CLI module/include/exclude selections. For example, a schema-valid config with `version:1` and `exclude:["framework:react"]` can remove the framework module from the later Next.js selection. The config is not considered when the earlier recommendation is produced. This is a transparent downstream preference mechanism, not proof of a harmful override; its absence from the recommendation input is the consequential boundary. [CONFIG, CONFIG-SCHEMA, REQUEST, PLAN-CLI, APPLY-CLI]

## 5. Three different things are called a plan or preview

| Entry | What it actually constructs/consumes |
|---|---|
| Consult's `planCommand` | Text naming a new invocation; no target plan is computed by consult |
| `ecc plan` / install-plan.js | Normalized selection passed to `resolveInstallPlan`; scaffold-level modules and adapter operations |
| `ecc install --dry-run` | Runtime manifest plan, source-to-file materialization and `previewInstallPlan`, including current migration/ownership/settings checks and hook-consent warning |
| `ecc install` | A newly constructed runtime plan passed to consent checking and actual application; it does not ingest the preceding plan report as an immutable approved artifact |

The standalone plan command explicitly warns that its operations are scaffold-level rather than a byte-for-byte legacy copy plan. The runtime plan further expands directories, handles selected configuration operations, excludes generated/cache material, deduplicates copy destinations and captures source/package/manifest information in its state preview. This is meaningful downstream elaboration, not mere renaming of the consult output. [PLAN-CLI, PLAN, APPLY-CLI, APPLY]

### Concrete destination difference even at the same source pin

The standalone plan CLI passes profile/modules/components/target to `resolveInstallPlan`, but not `projectRoot` or `homeDir`. The resolver defaults projectRoot to the ECC repository/package root. By contrast, the install CLI explicitly passes `process.cwd()` as projectRoot and its selected home. The Cursor adapter is project-scoped with `.cursor` root segments; the common helper resolves that base from projectRoot. [PLAN-CLI, MANIFESTS, APPLY-CLI, CURSOR, TARGET-HELPERS]

For a caller in project P running ECC from a distinct location R, the suggested Cursor preview therefore describes R/.cursor while the actual install plan targets P/.cursor. This is a source-derived example, not an executed write. The explicit scaffold caveat limits the preview's claim, but does not make those two destination identities equal. The actual dry-run entry follows the install runtime's project-root path and is a closer operation preview; it still is not an immutable approval bound to a later run.

## 6. Recommendation does not supply consent, and refusal remains real

Consult's generated install strings do not add hook consent. Several related profiles, including `security`, explicitly contain `hooks-runtime`. The normal install runtime attaches a separate hook decision; `applyInstallPlan` invokes `assertHookConsentReady` before its apply body. If the resulting operations would materialize hooks and consent is not enabled, it raises with a capability disclosure and explicit enable/decline choices. The dry-run path warns instead of asserting successful authorization. [CONSULT, PROFILES, RUNTIME, HOOKS, APPLY]

This protects an important boundary: finding or selecting a profile is not consent to its automatic behavior. A suggested profile command may therefore stop and require a further choice. That is not a failed safety mechanism merely because the recommendation is not one-step executable. Conversely, the recommendation report is not evidence that the consent boundary was reached or that every host/operation variant is covered.

The application layer also prepares ownership/migration state, rechecks operations around writes, handles settings and copy/merge transformations, records actual content digests and publishes install state. Conditional bridge-state recovery and later migration warnings exist. Earlier installation/maintenance findings retain their detailed scopes; this unit rereads the actual application consumer, not every underlying guard or migration dependency. No universal rollback, crash/race safety or preservation guarantee is inferred from those call sites. Installed material is still not demonstrated host loading, selection, obedience or useful behavior. [APPLY, APPLY-CLI]

## 7. The recommendation is not version-bound to its later consumer

Consult emits a schema version, query, target, timestamp and ranked results, but no catalog digest, ECC commit/package version, resolved target root or frozen action plan. Its suggested strings use `npx ecc-universal` without a version. The pinned package declares version2.2.1 and the expected binary mapping, but this does not bind a future npx invocation to that same package. [CONSULT, PACKAGE]

The official npm npx contract permits local packages and remote/cache acquisition; an unqualified package name can match the version in the local project. Therefore executing the recommendation elsewhere or later requires a separate source/environment identity check. No actual registry, cache, package download or version mismatch was observed here. The narrower issue is missing binding, not a prediction that every command fetches the newest release. [NPM-NPX]

## 8. Evidence limits, native-system contribution and return

The exact ledger records full implementation, public consumers, plan/materialization/apply helpers, selected concrete catalog data and the complete consult test file. Tests were inspected, not executed. They assert returned command text and direct target labels but do not execute those strings, resolve the selected recommendation's entire dependency closure or compare preview/apply destinations from an external project. The no-ML-for-generic-review tests remain valuable within their own ranking scope. Existing install validators or tests elsewhere are not presumed absent; they do not make these consult assertions a joined consumer test. [T-CONSULT]

No E11 or other behavioral probe was opened. A raw-source acquisition attempt failed DNS and obtained no file; it was neither target execution nor an installation failure. All substantive source readings remained available through connected GitHub. The counterexamples above are code-path deductions, not measured frequency, observed harm or production certification.

Note42 adds an actual catalog-selection → caller-command → stronger installer relationship to Note33. The constructive finding is not simply that labels are weak: catalog search, target filtering, explicit explanations, dependency refusal, configuration precedence, detailed dry-run, consent and guarded application are real different controls. The consequential gap is that their objects and inputs are not automatically identical. Source discovery, resolved installation and useful capability must keep their separate evidence.

Q02f1 carries this bounded source answer. Q02f2 preserves stronger package/catalog/environment binding, complete recommendation-to-resolution validation, host/caller and multilingual/semantic adequacy, immutable preview/approval, all adapter/guard variants, operational recovery and accepted outcomes. Final CORE, reverse inventory and whole-study evaluation remain open.

Next selected G5 responsibility is U18-D/Q02g: the optional Itô command bridge's executable identity, caller authority, command/environment handoff and external-effect boundary. Only scripts/ito.js lines1–70 were read to qualify the next lead; its claims about a separately installed credential-bearing CLI and distinct commands are not verified implementation findings yet. Start with that complete script, ito-environment and actual referenced validators/tests. No login, credentials, RFQ, provisioning, node qualification or external service invocation is authorized. Other Nasiko/claw/MCP and alternate-dashboard roles remain in the existing frontier. U18-D has not started.
