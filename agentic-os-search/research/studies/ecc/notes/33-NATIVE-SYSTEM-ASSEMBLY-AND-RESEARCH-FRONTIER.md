# Note33 — ECC's native working system and the remaining research frontier

**2026-09-21 · U15-A / Q01a3 · PROVISIONAL SOURCE SYNTHESIS.** Fixed ECC target: `8321021c54d670126ce3b2969d5deb880b4b0c2a`. Research input: `352c89e029edcd990e341f4498f3da1e2274727b`. [Reading/evidence ledger](../evidence/U15-A-SOURCES.md), [family reconciliation](../inventory/U15-A-COVERAGE-RECONCILIATION.md), [MR34](../ROUND-U15-A.md), [STATE](../STATE.md).

This is an assembly of the original mechanism findings, not a fresh execution of their sources, an independent replication, final CORE or adopted SOUL architecture. Notes01–30 were reread in full this unit; Notes31–32 retain their complete immediately preceding same-conversation readings at unchanged identities. Original notes and their ledgers own the detailed conditions. New selected upstream readings locate remaining responsibilities; metadata is not implementation coverage. No target test, model, installation, live service or E10 was run.

## 1. Working answer: selectively connected operating mechanisms, not one uniform controller

The accumulated evidence supports the following provisional account:

**ECC supplies reusable operating guidance and deployable host adaptations, together with several implemented work, execution, knowledge, review and control mechanisms. Some of these mechanisms are genuinely connected, but they do not share one universal task, session, authority, measurement or acceptance contract.**

This account rejects two inadequate extremes. ECC is not merely a directory of prompts: there are actual installers, subprocess supervisors, persistent stores, feedback queues, evaluators, callback implementations and release gates. Nor does one repository or one ECC label establish a single autonomous operating system that accepts a request, qualifies every action, completes the work, verifies the outcome and improves itself under one coherent authority. The evidence instead shows specific operating arrangements with specific handoffs. [N01] [N02] [N12] [N15] [N17] [N27] [N28]

The unifying elements are shared source assets, command/configuration conventions, distribution tooling and selected explicit adapters. They are useful forms of reuse, but weaker than universal runtime integration. The question for any particular deployment is which entry, installed assets, controller, store, host and human procedure are actually selected. The same source package can support different combinations without activating every mechanism at once. [N01] [N02] [N24] [N26]

The grouping below is explanatory and overlapping. It is not a new repository taxonomy, a definition of agent/harness, or a proposed set of SOUL components.

## 2. Responsibility map

| Responsibility | Concrete ECC mechanisms and useful work | Connection and scope that must remain visible |
|---|---|---|
| Supply methods and specialist behavior | Agents, commands, skills, rules and contextual instructions; a representative research/plan/implement/review/commit procedure | Much of sequencing and human sign-off is interpreted by the host agent. Native review executes a narrower review segment, not the whole procedure. [N01] [N19] |
| Make selected assets available to a host | Native plugin setup, manifest-driven managed-home installation, legacy synchronization, generated OpenCode entry and profile-aware command construction | Repository content, copied files, discovered plugin, callback registration and effective permission are different states; native/managed/legacy callers have different ownership rules. [N02] [N03] [N24] [N25] [N26] |
| Represent and route work | Work cards, normalized session snapshots, remote requests, schedules, handoff inboxes and multi-session templates | A changed card is not a process start. Shared admission helpers do not make recurrence, remote routing, backlog consumption and template ordering one scheduler contract. [N04] [N20] [N21] [N22] [N23] |
| Execute and supervise selected work | tmux/worktree/Codex wrapper path; separate Rust session/runner/child path; Python provider/tool loop for library callers | These are distinct execution arrangements. Rust has real state/output/heartbeat control, but session identity is not exclusive attempt ownership or native conversation restoration. Python is caller-owned composition, not an automatic branch of the Rust controller. [N05] [N13] [N14] [N15] [N27] |
| Exchange review and qualify a result | Plan Canvas local artifact feedback; native review/verifier aggregation; outer plan/commit sign-off | Feedback transport and reviewer verdicts are real, but their path/revision/actor/receipt contracts differ. Script APPROVE is not automatically human commit consent. [N12] [N19] |
| Preserve and reintroduce information | File Memory Vault via CLI/MCP; observation/instinct generation and SessionStart injection; separate ECC2/Node knowledge views | Stored recall material, a selected behavioral instruction and an accepted current fact are not interchangeable. Full graph/connector-to-use semantics remain partly unexplained. [N06] [N07] [N16] |
| Evaluate and modify reusable behavior | Skill outcome helpers, mutation/versioning helpers, Rust recorded-evidence candidate registry, Node capsule/replay/receipt utilities | There are multiple evaluation objects and consumers. A recommendation, active registry pointer or verified capsule is not automatically a deployed beneficial behavior change. [N08] [N17] [N18] |
| Observe and influence running work | Tool-event capture and SQLite import, TUI timeline, file-conflict control, resource estimates, context warnings and budget stopping | Some controls actually stop sessions; other outputs advise the model or operator. Capture, aggregation, field freshness and effect acknowledgement remain path-specific. [N14] [N31] [N32] |
| Protect selected actions and maintain ECC itself | Configuration guard, fact-forcing gate, optional governance emission, scanner/CI checks, package qualification and release | Local prevention, an audit label, document readiness and same-archive release integrity protect different objects. ECC's own release pipeline is not automatically every user's application delivery pipeline. [N09] [N10] [N11] [N28] [N29] [N30] |

## 3. Actual connections and the places where another actor still has work to do

A useful system account must show edges, not just boxes. These examples distinguish implemented connections from procedures or unestablished connections.

| Relationship | Standing in the examined source | Interpretation |
|---|---|---|
| Managed installation → copy/transform → ownership record | Implemented, with caller-specific checks | Source can become managed files with recorded identities. That record does not independently certify host loading. [N02] [N03] [N26] |
| Rust session → runner/child → SQLite output → TUI | Implemented | Explains real cross-process observation. Bounded output retention and observation failures still constrain what is visible. [N13] [N14] |
| TUI → queued-session activation and budget/conflict checks | Implemented, effectful | The operator surface is also a controller; its interaction/lifetime matters. It is not merely a window over a daemon. [N14] [N15] [N31] |
| Remote request → selected session/handoff → stored routing outcome | Implemented | A persistent routing result exists. Per-request completed-output acknowledgement is not supplied by that result alone. [N21] |
| Plan Canvas feedback → awaiting CLI → agent's next action | Queue/transport implemented; interpretation/action procedural | The channel can deliver usable feedback without being an authenticated, immutable-revision approval transaction. [N12] |
| Instinct files → selected SessionStart context | Implemented selection/injection | A path into later behavior exists. Appropriate scope, truth, applicability and benefit require more than selection. [N07] |
| Governance stderr event → state.db event row | Not established in the traced producer/consumer paths | Both ends exist, but their similarly named fields are not the missing ingestion bridge. No repository-wide absence of custom collectors is claimed. [N11] |
| Rust active candidate → built-in worker configuration | Not connected in the examined launcher; registry-only purpose is explicit | Promotion has a real transactional registry meaning, not automatic rollout. That narrower design is not itself a failed promise. [N17] |
| Cumulative cost row → JS latest snapshot / Rust sum → warnings or stop | Implemented, but consumers disagree on accounting semantics | A connection can exist and still transform the wrong quantity. This is different from no connection. [N32] |
| Tested ECC archive → publish input → registry integrity | Implemented identity checks in the release workflows | A strong artifact-specific connection; it neither authenticates every separate document approval nor governs arbitrary user deliverables. [N28] |
| Worktree outcome → merge/rebase queue → integration result | Real caller/controller located; full qualification/effect/recovery chain still open | It must not be omitted merely because process start/stop is already explained. New selected source confirms this is not a hypothetical future feature. See section8. |

Three different failure descriptions follow. A connection can be absent from the examined route; present but translate a field incorrectly; or present and correctly implement a narrower responsibility than an observer assumes. These require different conclusions. Treating all three as 'ECC is broken' loses the useful mechanisms and the actual location of uncertainty. Conversely, treating all three as integrated because code exists overstates the result.

## 4. The system has several decision owners and several kinds of state

The outer host agent often selects a procedure, retrieves context, invokes a command and interprets a returned result. The host runtime supplies actual tools, permission semantics, event contracts and plugin loading. A local ECC controller can launch processes, route messages or apply a stored-usage stopping predicate. A user or maintainer owns the human sign-offs described by the relevant procedure. These roles can cooperate, but one does not become the other through a label. [N12] [N15] [N19] [N24]

Persistence is similarly plural. The Node work/snapshot store, Rust process registry, Plan Canvas JSON queue, file Vault, instinct artifacts, metric JSONL/shared bridge and evaluation capsules have different schemas, writers, retention and meanings. The Node control pane can read both Node and Rust stores without unifying their identities. A selected database in that pane need not be the database selected by its separate Rust subprocess. [N04] [N06] [N07] [N12] [N16] [N18] [N31] [N32]

This is not a claim that multiple stores are inherently bad or that a single database would solve the problems. The load-bearing question is whether a transition preserves the intended object and its valid standing. A card claim, a process PID, a Canvas session key and a metric session label answer different questions. The implementation can intentionally use several stores; its guarantees must be evaluated at their actual joins.

Local protections are also not uniformly weak. The candidate registry conditionally updates the expected active baseline inside a transaction, while ordinary session-attempt writes lack that ownership condition. Capsule append reloads its current chain under a cooperative lock, while the metrics bridge protects file replacement but not the whole concurrent read-modify-write. These positive contrasts prohibit a whole-system 'no transactions/no concurrency controls' generalization. [N15] [N17] [N18] [N32]

## 5. A task journey, without inventing a universal pipeline

Consider a user asking for a software change. The following is an analytical assembly of available routes, not a claim that one default command automatically performs all of them.

**Preparation and review.** A host can follow the interpreted planning procedure and optionally open an artifact in Plan Canvas. Canvas supplies a real feedback channel; the host remains responsible for interpreting feedback and carrying the appropriate decision into its work. Its path-based session does not freeze the reviewed bytes. [N12] [N19]

**Work representation and execution.** A work card may be useful bookkeeping. To make a process, the selected caller must take an execution route, such as the tmux worker path or Rust admission. A Rust template can prepare several sessions; remote intake and schedules offer other entry points. These routes do not automatically inherit one another's capacity, priority or completion rules. A template reviewer can be admitted before its planner completes because ordered admission is not a predecessor-result dependency. [N04] [N05] [N20] [N21] [N23]

**Observation and intervention.** A selected runtime captures output and liveness; hooks can record tool activity; matched paths/identities permit ingestion. TUI and other connected consumers can inspect those records and some can stop work. This is an actual feedback capability, but heartbeat, risk, cost and completion each inherit a particular measurement definition. No single healthy label replaces all of them. [N13] [N14] [N31] [N32]

**Review, acceptance and integration.** The native reviewer can return structured blockers and uncertainty; the outer procedure retains human gates. A successful process exit is not that review, and review is not automatically the same as a branch being safely integrated. The source contains a merge/rebase controller, but its qualification-to-Git-effect chain has not yet been assembled by this research. This is the next material gap, not evidence that ECC has no delivery mechanism. [N15] [N19]; new selected manager/daemon source in the ledger.

**Reuse after the task.** A Vault entry can be recalled and an instinct can be injected later. Skill evaluation can recommend a change, while another API changes a file or pointer. Those activities need their own source, scope and admission; successful completion of this task does not automatically prove a generally useful learned policy. [N06] [N07] [N08] [N17] [N18]

The task journey therefore depends on explicit composition by selected software and actors. The study must explain those dependencies rather than draw one uninterrupted arrow through every available feature.

## 6. ECC's maintenance process and the user's work are different objects

The release workflows qualify and publish the ECC package. The operator-readiness dashboard also contains ECC-specific historical launch requirements. They are not generic proof that a user's requested feature has been reviewed, merged, deployed and accepted. [N28] [N30]

Likewise, a Rust harness-configuration candidate, a skill proposal, a reviewed code diff, a captured tool event and a package tarball are different evaluation objects. A strong hash binding for the tarball does not strengthen a weakly bound human verdict about another artifact. A valid receipt over records of refused execution does not turn that refusal into a successful candidate trial. [N08] [N17] [N18] [N19] [N28]

This distinction changes the whole-system interpretation. ECC contains machinery for operating development work and machinery for developing/distributing ECC itself. Shared vocabulary such as ready, approve, promote, rollback or completed must retain its object and consumer. This is local source interpretation, not a new concepts-program definition or a Foundation taxonomy.

## 7. What the accumulated work now explains, and what it does not

The old U07-A map predates the completed Canvas, Rust lifecycle, Node bridge, evaluation, native review, scheduling/intake/backlog/templates, profile/OpenCode/Python and release/scanner/observability inquiries. It is no longer correct to treat all those families as unstarted. The [reconciliation](../inventory/U15-A-COVERAGE-RECONCILIATION.md) records each original family's new standing without rewriting the historical map.

At the same time, a bounded source answer is not exhaustive descendant coverage. Three obligations must remain separate:

1. **Explained source mechanism:** its actual producer, transformation, consumer and material countercase are understood at a stated scope. Do not repeat it only because no live deployment was run.
2. **Genuine source gap:** a different implemented responsibility or a load-bearing caller/helper still lacks a joined explanation. Merge/integration and portions of knowledge projection are examples. Do not hide them under 'runtime limitations'.
3. **Stronger empirical claim:** installed compatibility, race frequency, privacy completeness, model obedience, calibrated risk or accepted real-world outcomes. These require different evidence and are not automatically mandatory experiments for this bounded source study.

Existing tests and local experiments retain their original classes. E02's store double is not SQL concurrency evidence; E07's SQL/Git fixture is not Rust lifecycle execution; E08 is adapted review with stipulated responses; E09 is original Python modules with a scripted provider. E06 remains excluded and the two E05 histories remain distinct. Combining these findings supplies explanatory breadth, not independent replication, a pooled success rate or production certification.

## 8. Remaining source sequence selected by consequence, not novelty

**Next selected: U15-B / Q04i — worktree delivery and merge qualification.** Fresh selected source shows daemon.run calling an auto-merge wrapper, that wrapper honoring `auto_merge_ready_worktrees`, and `merge_ready_worktrees(..., true)` entering `process_merge_queue`. The queue calls readiness construction, actual merge/rebase helpers and returns blocked/failure information. The existence of this configured effect path is established; the correctness and full conditions of those helpers are not.

Start with `ecc2/src/session/daemon.rs` auto-merge/prune callers, `session/manager.rs` `build_merge_queue`, `merge_session_worktree`, `rebase_session_worktree`, `process_merge_queue`, and the corresponding `worktree/mod.rs`, store and CLI/TUI consumers. Trace candidate branch and base identity → readiness/review/queue rule → Git effect → persistent outcome/cleanup → retry and changed-base behavior. Determine what 'ready to merge' actually means; do not assume it is either semantic task acceptance or merely exit success. Return with a useful joined explanation and one material changed/failed/partial case. No real repository merge is authorized.

After that, the revisable sequence is: knowledge/graph/connector-to-use; remaining install repair/removal and host/procedure variants; configuration scorecard and optional external-interface roles; then reverse inventory and broad-document challenge, synthesis revision and final project-facing evaluation. These are bounded obligation groups, not a promise of one turn per group or blanket demand to read every helper. The reconciliation identifies entry points and the question each group could change.

Optional external products are not automatically new research campaigns. ECC's adapter contract can be explained up to the external responsibility boundary; a claimed installed guarantee would need separately scoped service evidence. Similarly, repeated/generated assets need authoritative-source and consequential-variant checks, not automatic dismissal as duplicates or exhaustive semantic evaluation of every copied skill.

## 9. Why this is progress without premature closure

The research now has a usable working model: methods and distribution make selected capabilities available; several callers represent and route work; different runtimes execute it; feedback, observation and evaluation mechanisms influence different subsequent decisions. Actual links and remaining actor responsibilities are visible. It is no longer necessary to infer a system from a list of isolated defects.

The model remains provisional because genuine source gaps and the reverse-inventory challenge could change it. New evidence should revise particular relationships, not force them into this grouping. The next unit is chosen because it completes a consequential part of the user's-work journey, not because another helper happened to be nearby.

U15-A meets its assembly/reconciliation return criterion. It does not close Q01a2, final CORE, all material variants or whole-study acceptance. The candidate value for later SOUL/Development OS work is a source-grounded set of working mechanisms and composition tests, not a decision to copy ECC or a claim that a better SOUL has already been designed.

[N01]: 01-SURFACES-AND-CODEX-CACHE.md
[N02]: 02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md
[N03]: 03-OWNERSHIP-CHECKPOINTS-AND-PROJECTION.md
[N04]: 04-WORK-SESSION-RECORDS-AND-CONTROL.md
[N05]: 05-EXECUTION-HANDOFF-AND-RECOVERY.md
[N06]: 06-MEMORY-SCOPE-RECALL-AND-AUTHORITY.md
[N07]: 07-OBSERVATION-INSTINCTS-AND-BEHAVIORAL-CONTEXT.md
[N08]: 08-SKILL-OUTCOMES-EVALUATION-AND-CHANGE.md
[N09]: 09-CONFIGURATION-PROTECTION-AND-ENFORCEMENT.md
[N10]: 10-FACT-FORCING-STATE-AND-DECISION-COMPOSITION.md
[N11]: 11-GOVERNANCE-EVENTS-PERSISTENCE-AND-DECISION.md
[N12]: 12-PLAN-CANVAS-FEEDBACK-AND-CONTINUATION.md
[N13]: 13-RUST-SESSION-LIFECYCLE-FIRST-SLICE.md
[N14]: 14-STORE-OBSERVER-AND-WORKTREE-CONTINUITY.md
[N15]: 15-EXECUTION-ATTEMPT-OWNERSHIP-AND-REVOCATION.md
[N16]: 16-NODE-OPERATOR-BRIDGE-AND-TARGET-BINDING.md
[N17]: 17-RUST-EVALUATION-REGISTRY-AND-USE.md
[N18]: 18-OFFLINE-CAPSULES-REPLAY-AND-RECEIPT-SCOPE.md
[N19]: 19-NATIVE-REVIEW-CALLER-AND-DECISION-BOUNDARIES.md
[N20]: 20-SCHEDULED-WORK-ADMISSION-AND-RETRY.md
[N21]: 21-REMOTE-INTAKE-DISPATCH-AND-RESULT-BOUNDARIES.md
[N22]: 22-BACKLOG-COORDINATION-AND-CONSUMPTION.md
[N23]: 23-TEMPLATE-RESOLUTION-AND-LAUNCH-COMPOSITION.md
[N24]: 24-EXECUTION-PROFILES-AND-HARNESS-CONSUMERS.md
[N25]: 25-OPENCODE-CALLBACK-CONTRACTS-AND-GENERATED-ENTRY.md
[N26]: 26-OPENCODE-INSTALLATION-LOADING-AND-TOOL-RESULTS.md
[N27]: 27-PYTHON-PROVIDER-SELECTION-AND-TOOL-ROUNDTRIPS.md
[N28]: 28-RELEASE-QUALIFICATION-AND-ARTIFACT-BINDING.md
[N29]: 29-SUPPLY-CHAIN-SCAN-COVERAGE-AND-ADVISORY-FRESHNESS.md
[N30]: 30-READINESS-PREDICATES-AND-OPERATOR-PROJECTIONS.md
[N31]: 31-TOOL-ACTIVITY-INGESTION-AND-RISK-USE.md
[N32]: 32-USAGE-COST-CONTEXT-AND-RESOURCE-CONTROL.md
