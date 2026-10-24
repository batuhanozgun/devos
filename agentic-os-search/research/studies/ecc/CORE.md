# ECC — Native working system

**2026-09-25 · U20-A / Q01–Q01a3 · SOURCE-SYNTHESIS CANDIDATE v0.1.**

**Research target:** `affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a`.
**Original research input:** `batuhanozgun/agentic-os-search@42e4fd3f2bc100fe1ff99da44019d5ffd2303b6b`.

[STATE](STATE.md) owns current work and checked publication. [U20-A evidence and claim map](evidence/U20-A-SOURCES.md) identifies the actual original-note recovery; [MR58](ROUND-U20-A.md) records the method and return criterion. This synthesis does not replace the original notes or their primary-source ledgers. It is a bounded explanation of the studied source, not an installed-system audit, current-product recommendation, final joint assessment or adopted SOUL/Development OS architecture.

## 1. The central answer

**ECC combines reusable operating procedures and host-specific deployment with several implemented work, execution, information, review and control arrangements. Selected arrangements are genuinely connected; one uniform end-to-end controller is not established across them.**

Calling it only a prompt library misses real capabilities: file-operation planning, ownership-aware installation, process launch and supervision, persistent queues and records, review communication, context injection, Git integration, evaluation utilities and release qualification. Calling it one autonomous system that uniformly discovers requirements, authorizes actions, completes a task, verifies the outcome and improves itself goes beyond the traced connections. The operational unit is the **selected combination of entry point, installed assets, host, controller, store and responsible actor**, not the repository name alone. [N02] [N05] [N12] [N15] [N17] [N28] [N34]

Shared files, conventions, selectors and adapters make these combinations reusable. They do not automatically align every participant's task identity, configuration, permissions, evidence or completion meaning. Some transitions are code; others are procedures interpreted by a capable agent or an operator; others cross into separately supplied products. The distinction is about responsibility, not a claim that prose is ineffective or that multiple stores are inherently defective.

This revises the earlier [provisional assembly][N33]. Its formerly unresolved delivery, knowledge-consumption, maintenance, guidance and interface relationships now have bounded accounts in Notes34–56. The result is a more concrete composition model, not the old assembly followed by a catalogue of defects. The selected omission review permits this synthesis while explicitly retaining unviewed media, unexamined variants and stronger empirical limits. [N56]

## 2. What ECC supplies, and what must be supplied around it

| Supplied responsibility | Representative working mechanism | Remaining participant or condition |
|---|---|---|
| Methods and specialist guidance | Skills, commands, rules, agents and staged planning/review procedures | A selected host/agent must discover, interpret and follow them; the relevant human owns the procedure's sign-offs |
| Availability and maintenance | Native plugin reconciliation, manifest-driven installation, shared-settings management, legacy synchronization | The chosen distribution and host must load the intended payload; ownership and recovery differ by route |
| Work representation and intake | Local cards, schedules, remote requests, task-handoff messages, templates | A record is not itself an allocated process or accepted task; the particular dispatcher must run |
| Execution and supervision | Worktree/tmux helper, Rust ECC2 session runtime, separate Python provider/tool loop | Executable, environment and caller selection determine authority and lifetime; these are not interchangeable runtimes |
| Information and reuse | File Vault, observations/instincts, session summaries, graph recall, transcript replay | Scope, evidence standing, actual recipient and final context consumption remain distinct |
| Feedback, observation and qualification | Plan Canvas, native review segment, tool/cost metrics, evaluators, local guards and release workflow | Each control measures or governs a particular object; its result must reach the correct next consumer |

These are overlapping explanatory responsibilities, not a new ECC taxonomy or a proposed SOUL component tree. The same file or actor can participate in several. [N02–N56 through the claim map](evidence/U20-A-SOURCES.md)

A deployment may use only portable guidance. Another may add registered hooks and memory. Another may run ECC2 workers and its operator interface. Optional adapters do not become active merely because their source is shipped. Consequently, the question “does ECC support X?” needs a route and a meaning of support: present, installable, discovered, selected, executed or effective.

## 3. From source assets to active capability

### 3.1 Discovery is not requirements engineering

`ecc consult` is a real catalogue matcher. It ranks supplied query words against component descriptions, IDs and aliases and emits suggested plan/install commands. It does not inspect a user's code, elicit missing requirements or measure whether a chosen capability solves the problem. The next actor chooses whether and where to execute those commands. [N42]

The installer then performs additional work: normalize the request and configuration, expand components into modules, check dependencies and target support, invoke an adapter and materialize concrete operations. A component name is not necessarily one independently selectable leaf; several names can select the same broad module. A recommendation can pass the direct target filter yet be skipped when the installer checks an unsupported dependency. That is a useful downstream refusal, not proof the recommendation already guaranteed delivery. [N02] [N42]

### 3.2 Installation has several authorities and representations

For Codex, native plugin reconciliation, managed-home materialization and the legacy sync script are distinct paths. Native installed/enabled registration is not a full dependency or hook-trust check. Managed installation owns selected operations and records installed content. Legacy synchronization has a separate whole-file baseline and rollback history. Using the same host name does not merge those contracts. [N02] [N03] [N38] [N48] [N52]

Managed materialization can rewrite links, transform Markdown, merge JSON and update selected hook entries. Installed bytes therefore need not equal source bytes. Real protections include target/path checks, preservation of unowned destinations, installed-content records, explicit hook-consent decisions and caught-failure checkpoints. Guided Kimi additionally checks operation identity and current content before trusting a recorded destination. The common copy guard's policy is not identical: already-managed files remain updateable, while even byte-identical pre-existing unowned files can be left unclaimed. [N03]

A checkpoint can contain pending recovery scope as well as completed writes. An `installedAt` field or a valid schema is not evidence that every requested operation happened. A database projection of that record is yet another object; file health and host uptake require other consumers. A multi-harness setup can honestly report partial application without supplying one global rollback transaction. [N02] [N03]

### 3.3 The host remains an active part of the system

The deployment-to-use boundary is concrete, not merely theoretical:

- OpenCode has package-entry, source-plugin and managed-config loading routes. A compiled file can be present while a configuration selects the source plugin. Host dependency resolution and callback registration add conditions beyond ECC's copy checks. A hook-consent classifier that removes named hook operations does not necessarily remove automatic callbacks in another retained plugin module. [N26]
- Pi's qualified source path actually consumes ECC's modified system prompt. Cached engineering rules are reintroduced, while pending session-hook context is consumed once before an ordinary agent run. A later user prompt is not automatically given the same original context. Explicit reload offers a real freshness path. [N50]
- Cursor's examined normal installation places shared scripts under `.cursor/scripts`, while its wrapper looks under the project-root `scripts`. Even when a compatible child is reachable, the wrapper does not carry its additional context into the documented Cursor output field. Data-root selection can still work independently. [N51]
- Kiro's short optimizer definitions are preserved prebuilt copies. Historical evidence supports an older aligned body remaining while the primary definition developed, not demonstrated loss by a current converter. Reinstalling missing-only files and editing a sibling Markdown file do not guarantee that an inline JSON prompt was updated or selected. [N53]

These comparisons establish materially different paths, not a failure rate or all-host verdict. Portability is a collection of specific translations and dependencies, not a property proved by shared names.

## 4. How a user's software task can move through ECC

The following journey is an **analytical composition of available routes**, not a claim that one default command automatically performs all stages.

**Understand and plan.** The authored PRD procedure asks for problem evidence, intended outcomes, assumptions and exclusions. The plan command normally works inline; artifact mode links a selected milestone to a plan. It requires separate user confirmation before implementation. Writing a plan and marking a milestone in-progress can therefore precede permission to code. A retained file enables continuity, but a later actor must still recover unfinished work rather than blindly select another pending milestone. [N39]

**Obtain feedback.** Plan Canvas opens a file, stores feedback and supplies it to a waiting CLI or a Stop-hook continuation message. This is a genuine communication channel. Its identity follows an artifact path, not immutable reviewed bytes; draining a queue precedes consumer acknowledgment. An actor must retain what was reviewed, what the feedback means and whether subsequent changes require another review. The channel does not independently implement those engineering decisions. [N12]

**Choose execution.** A local work card can represent assignment and status. Claiming it does not launch an agent. An operator can instead choose the worktree/tmux helper, Rust session admission, a scheduled or remote request, or caller-owned Python composition. These entry points have different policies and must be connected deliberately to the intended work. [N04] [N05] [N15] [N20] [N21] [N27]

**Implement and observe.** A capable host may follow TDD's task-to-test, meaningful RED, same-target GREEN and evidence-retention instructions. A selected runtime can separately capture output, heartbeat and tool activity; connected controls can pause work. Neither written TDD guidance nor a running process is a task-quality certificate. Observation must identify the actual input, executing attempt and relevant revision. [N39] [N15] [N31] [N32]

**Review and decide.** The native review pilot executes a narrower review/verifier segment, with meaningful blocking treatment for missing reviewers and uncertain verifier results. The outer workflow retains human plan and commit decisions. A script-level `APPROVE` is not authenticated user consent or proof that every required review dimension was selected. Finding aggregation must also preserve the evidence carrying the finding. [N19]

**Integrate and retain.** Rust supplies real merge/rebase and cleanup paths. Mechanical merge readiness is not synonymous with semantic acceptance: a clean, mergeable stopped or failed session can be eligible under the examined policy. Later pruning has its own predicates. A skipped merge or failed rebase that preserved a worktree does not by itself prevent a separately selected force-cleanup path from removing it. Those stage relationships matter more than a generic completed label. [N34]

**Learn or hand off.** The actor can save unreviewed context, produce a session summary, allow eligible instincts into later context, or propose a skill change. Those operations preserve or influence future work in different ways. They do not automatically turn this task's output into accepted general knowledge or a proven improvement. [N06] [N07] [N08]

The actual connective work is distributed among software and actors. A synthesis that removes the actor-owned steps would invent automation; one that ignores the real software would understate ECC.

## 5. Work records, dispatchers and runtime ownership

### 5.1 Several work objects coexist

Local work items are mutable cards. Imported authorship and local assignment can share a field without sharing authority. The default session-snapshot recorder and the SQLite session reader do not become connected merely because both are described as state storage. Note04 identifies their actual fallback/reader seam. Its earlier E02 probe exercised one unchanged pickup helper with an in-memory store double, not a multi-agent execution scheduler. [N04]

A schedule stores recurring launch instructions. A due pass admits a session and advances timing without waiting for accepted output. A worktree-capacity queue can retain a Pending session before a runner starts. The scheduler's batch limit is not the template launcher's separate session-capacity check; neither should inherit the other's guarantee. [N20] [N23]

Remote intake persists a pending request and returns an acceptance response. Dispatch is a separate CLI or daemon responsibility. A specified lead can route to a delegate rather than execute the task itself. The stored result identifies routing/admission, not a unique accepted outcome for that request. [N21]

Backlog coordination moves unread handoffs. Under its optional automatic mode, routing success can mark an old message read while creating a new unread handoff. That is not acknowledgment by the executing model. Saturation deferral usefully retains work, but forwarding, execution and further delegation need distinct meanings. Templates similarly resolve and admit several sessions; ordered admission is not completion-dependent workflow sequencing. [N22] [N23]

### 5.2 Execution is real, but its owners differ

The worktree helper provisions Git worktrees and tmux panes, materializes coordination artifacts and submits launcher commands. A selected dirty/untracked overlay can contribute input beyond the base commit. Submission success is not worker readiness. Setup rollback removes resources created by that attempt; replacing an older run is not the same as restoring it. Earlier E03 used the original wrapper/collector with a fake provider and showed that process completion can coexist with a report of failed task verification. [N05]

Rust ECC2 adds actual child supervision, output persistence, heartbeat, stop/resume and reconciliation. Ordinary CLI launches use a detached wrapper; delayed activation can be owned by a daemon or TUI runtime. Closing an unrelated display and shutting down the runtime owning capture are different events. The durable row mainly identifies a session, not an exclusive generation of a running attempt. A late finalizer from an old attempt can be sequentially legal against a newer Running row with the same session ID. State-transition validity and writer ownership are separate. These are conditional source schedules, not reproduced races. [N15]

The Python package supplies a separate provider abstraction, tool registry and ReAct loop for library callers. Saving a provider preference does not itself run the loop; a registered callable, advertised tool definition and request-specific permission are different surfaces. Its earlier E09 was local scripted-provider evidence, not a live service trial. It is not an automatically embedded branch of the Rust controller. [N27]

### 5.3 A common profile is not common enforcement

Some profile fields become native host arguments; others become text inside the task. Claude's mapped permission options, Codex's fixed command recipe and advisory fallback fields, and a custom configured runner have different effects. A custom runner replaces the built-in recipe rather than necessarily inheriting it. Even a native allow-tools option may concern preapproval rather than removal of all other tools. The source explains translation; installed policy composition remains conditional. [N24]

## 6. Information: storage, recipient choice and active context

**The Vault** is a file-first context-transfer mechanism. New records are active and unreviewed, including records classified as fact or decision. Create-only writes, structured metadata, constrained scopes, recipient filtering and incomplete-ID-lookup refusal are useful controls. Governed acceptance remains outside the Vault's own tools. CLI, JSON and MCP views do not preserve exactly the same diagnostics or historical-status presentation. Saving a handoff does not claim work or resume a process. [N06]

**The learning path** captures selected observations and can optionally ask a model to write procedural instincts. Selected instinct actions can then enter SessionStart context without prior global promotion or skill generation. This is a real information-to-behavior route, not merely a future promise. Its evidence is nevertheless sampled and compressed; a first action line can survive while its trigger, evidence and identity do not. Stored confidence and repeated project labels are not independent demonstrations of usefulness. [N07]

**Graph and recall paths** have actual consumers. Rust connector-derived knowledge and session-related recall can affect eligible delegate selection and a subsequent handoff. Choosing a recipient using recalled information does not mean every matched passage is delivered as that recipient's prompt. Node knowledge recall, code-proximity analysis and the operational message sender are separate algorithms and interfaces. A displayed advisory or declared lease is not automatically an acquired lock or an instruction the recipient consumed. [N35] [N36] [N16]

**Transcript replay** is another arrangement. NanoClaw joins selected skill text and a named Markdown conversation to successive Claude subprocesses. It does not restore all previous model, skill, directory or native-session state merely by reopening that name. Transcript branching is not a Git worktree or permission boundary; recent-record compaction is not semantic preservation of unresolved objectives. [N45]

These mechanisms should not be collapsed into one memory database or one trust ladder. The relevant questions are: who wrote the record; which scope and version it represents; what is eligible for recall; what the final consumer receives; and which decision that content can influence. Different stores may be appropriate. The research identifies concrete joins and mismatches rather than prescribing storage consolidation.

## 7. Observation, evaluation and authority are different control loops

### 7.1 Observation can affect action without being complete

The tool-activity path joins a registered hook, a JSONL producer, an importer, stored tool logs and a TUI timeline. A separate typed-file-activity consumer can record conflicts and stop selected sessions. The numerical risk suggestion itself is retrospective classification, not the pre-action authorization of the already reported call. Correlated labels, correct data paths and successful ingestion remain conditions. [N31]

Usage/cost reporting also has real control consumers. JavaScript's bridge selects the latest cumulative cost row; Rust's importer sums those rows. Thus the same valid producer can feed inconsistent quantities into different views, including a stopping predicate. Global/profile limits are not all the same budget, and a recent shared timestamp does not automatically make every cached field current. This is an example of an **existing connection that changes meaning**, not a missing connection. [N32] [N24]

The Node operator pane combines observations, selected card writes and allowlisted Rust command shortcuts. Its chosen display database is not automatically passed to those subprocesses. In contrast, the separate desktop and browser component dashboards mainly explore source definitions; they do not become live agent controllers through the shared dashboard name. [N16] [N46] [N47]

### 7.2 Evaluation has several legitimate objects

| Evaluation surface | What it actually evaluates or records | What does not follow automatically |
|---|---|---|
| Harness scorecard | Declared file/configuration predicates, weighted checks and suggested actions | Task quality, observed latency, lower cost or a successful optimizer run [N40] |
| Skill-improvement helper | Supplied observation counts and baseline/amended success rates | Comparable independent trials, version-bound causal improvement or applied changes [N08] |
| Rust candidate registry | Candidate identity, supplied paired scores, current baseline, transactional promotion/health records | Live measurement, deployment into built-in workers or effective adaptation [N17] |
| Node capsules/replay/receipts | Structured records, integrity/checkpoints, saved tool responses and requested witness checks | Complete truthful history, restored external effects or candidate execution; the unsupported candidate gate deliberately refuses [N18] |
| Evaluator/RAG prototype | Committed example records and selected regression assertions | New candidate judgment, recalculated scores, real security approval or verified hosted integration [N55] |
| Native review | Selected reviewer findings, aggregation, verifier outputs and incomplete/blocking disposition | Full task acceptance, independent oracle quality or human consent [N19] |

The Rust registry's transaction and the capsule's error-sensitive checks are substantial positive mechanisms. Their narrower contracts should not be dismissed because they do not implement autonomous learning. Conversely, a stored winner, a receipt or a higher score does not provide an unexamined bridge to active behavior. An actual model trial needs its own input, criteria, provenance, measurement and subsequent-use evidence.

### 7.3 Authority is not a label carried by a record

ECC contains real pre-action refusals. The configuration guard blocks selected existing configuration names, while GateGuard enforces a first-touch pause and requests investigation. The latter releases a repeated key based on its saved encounter marker, not a checked investigation response. Cooperative reasoning may benefit; verified investigation is a stronger claim. Structured decisions must also survive intermediate output combiners before the host can enforce them. [N09] [N10]

Optional governance capture classifies and emits events; the inspected database/status path has a separate writer contract. An `approval_requested` label is not an authenticated request awaiting a human, and a resolved database row does not by itself prove an authorized resolution. Plan Canvas, native review and procedure-level human sign-off have their own meanings. No universal approval service is established by their shared terminology. [N11] [N12] [N19]

## 8. Maintenance, external boundaries and ECC's own release

Maintenance preserves different objects. Claude shared-settings management uses event/ID/content checks, cooperative locking, snapshot rechecks and staged replacement. Legacy Codex retains pre-ECC files and per-attempt recovery. General JSON subtraction does not reconstruct an overwritten prior value unless a producer actually supplied the relevant snapshot. Preserving a changed hook entry can still leave it referring to a runtime dependency another uninstall operation removes. [N37] [N38]

Recovery therefore needs a named meaning: retain useful records, restore a prior file, retry pending work, revoke an old process, or undo an external effect. One successful local restoration does not imply all of them. Source recommendations such as manual archive/truncate commands are separate actor-executed paths and do not inherit the managed installer's controls. [N05] [N15] [N34] [N38] [N54]

Optional integrations also differ. AURA supplies a caller-owned reputation return/refusal gate; identity authentication and action authorization remain additional responsibilities. Itô delegates through a restricted local-client process bridge; its path and environment checks are not client provenance or operating-system isolation. Nasiko supplies pinned-artifact acquisition, integrity checks, local qualification and maintenance, not a running governed control plane. These are concrete ECC-side capabilities with explicit outside boundaries. [N41] [N43] [N44]

ECC's own release pipeline is a particularly strong artifact-specific connection: one archive is packed, checked, passed to lifecycle jobs and then used as the publishing input with digest comparisons. That protects tested-byte correspondence. It is not the same as the local owner-document gate, nor does it automatically deliver every user's application. Moving a public distribution pointer, changing an installed copy and obtaining user acceptance are different effects. [N28]

Progress synchronization likewise combines operator duties with local import/reporting commands. A roadmap statement can describe local code, a historical milestone or another product. The reporting consumer's marker checks do not themselves perform live external reconciliation. Date, target and evidence must remain attached to a status. [N30] [N56]

## 9. The relationships that matter most

The revised model distinguishes four kinds of connection:

| Kind | Concrete example | Correct interpretation |
|---|---|---|
| Implemented and useful within a narrow contract | Pi context result reaches the qualified host consumer; release archive is carried into publication | Real integration, with explicit lifetime/version or artifact scope [N50] [N28] |
| Implemented but transformed or inconsistently selected | Cumulative costs are summed as increments; observed and commanded stores can differ | Inspect the transformation and target binding, not merely whether an API call exists [N32] [N16] |
| Intentionally actor-mediated | Plan confirmation, Canvas feedback interpretation, TDD evidence judgment and PR decision | A capable actor and human authority are part of the operating arrangement, not absent software to imagine [N39] [N12] [N19] |
| Not established on the traced route | Captured governance log to database ingestion; promoted Rust candidate to built-in worker configuration | Do not invent the edge; a custom or future consumer would require separate evidence [N11] [N17] |

This prevents both blanket praise and blanket defect attribution. It also identifies why another well-tested component may not solve a composition problem: the test may protect a different object, the consumer may use another representation, or an actor may own the transition.

## 10. What this synthesis establishes and leaves open

The source account now supports a coherent explanation of the selected working arrangements and their consequential relationships. It includes positive mechanisms, actor responsibilities and counterconditions. G6's finite disposition is the scope justification, not a certificate that every repository file was semantically audited. [N56]

No new target code, test, host, model, installation or live service was executed in U20-A. Earlier local experiments remain separate: store doubles, fake/scripted providers, adapted workflow behavior, unchanged-helper tests and the recovered Gemini converter campaign have different scopes. E06 remains excluded; the two E05 histories are not pooled; E10 is one recovered campaign, not a second experiment. No combined pass rate, independent replication or production-safety verdict is derived from their accumulation. The exact evidence routes remain in [INDEX](INDEX.md) and the original notes.

The following are not established here: universal host/domain/translation parity; complete visual/video coverage; current hosted-product or provider state; every dependency's installed identity; authenticated organization-wide approval; crash/concurrency guarantees beyond inspected predicates; complete observation; independent task-quality measurement; or autonomous beneficial self-improvement. These limits do not invalidate a narrower source synthesis.

Reopen a claim when a newly identified caller, installed route, changed source, data schema or substantive counterexample changes its dependency chain. Recover an unviewed source before using its unique content. For a current deployment decision, revalidate the relevant upstream and host/runtime rather than treating this historical pin as current certification.

**U20-A's deliverable is this source-traceable native synthesis candidate, not whole-study acceptance.** The next distinct responsibility is to assess the research-method case against its actual history and observed costs/corrections, then prepare the separately bounded project-facing and user evaluation under current authorization. That later work must not turn candidate mechanisms into Foundation truth or adopted architecture merely because this document is called CORE.

## Original evidence links

[N02]: notes/02-INSTALLATION-CHANNELS-AND-MATERIALIZATION.md
[N03]: notes/03-OWNERSHIP-CHECKPOINTS-AND-PROJECTION.md
[N04]: notes/04-WORK-SESSION-RECORDS-AND-CONTROL.md
[N05]: notes/05-EXECUTION-HANDOFF-AND-RECOVERY.md
[N06]: notes/06-MEMORY-SCOPE-RECALL-AND-AUTHORITY.md
[N07]: notes/07-OBSERVATION-INSTINCTS-AND-BEHAVIORAL-CONTEXT.md
[N08]: notes/08-SKILL-OUTCOMES-EVALUATION-AND-CHANGE.md
[N09]: notes/09-CONFIGURATION-PROTECTION-AND-ENFORCEMENT.md
[N10]: notes/10-FACT-FORCING-STATE-AND-DECISION-COMPOSITION.md
[N11]: notes/11-GOVERNANCE-EVENTS-PERSISTENCE-AND-DECISION.md
[N12]: notes/12-PLAN-CANVAS-FEEDBACK-AND-CONTINUATION.md
[N15]: notes/15-EXECUTION-ATTEMPT-OWNERSHIP-AND-REVOCATION.md
[N16]: notes/16-NODE-OPERATOR-BRIDGE-AND-TARGET-BINDING.md
[N17]: notes/17-RUST-EVALUATION-REGISTRY-AND-USE.md
[N18]: notes/18-OFFLINE-CAPSULES-REPLAY-AND-RECEIPT-SCOPE.md
[N19]: notes/19-NATIVE-REVIEW-CALLER-AND-DECISION-BOUNDARIES.md
[N20]: notes/20-SCHEDULED-WORK-ADMISSION-AND-RETRY.md
[N21]: notes/21-REMOTE-INTAKE-DISPATCH-AND-RESULT-BOUNDARIES.md
[N22]: notes/22-BACKLOG-COORDINATION-AND-CONSUMPTION.md
[N23]: notes/23-TEMPLATE-RESOLUTION-AND-LAUNCH-COMPOSITION.md
[N24]: notes/24-EXECUTION-PROFILES-AND-HARNESS-CONSUMERS.md
[N26]: notes/26-OPENCODE-INSTALLATION-LOADING-AND-TOOL-RESULTS.md
[N27]: notes/27-PYTHON-PROVIDER-SELECTION-AND-TOOL-ROUNDTRIPS.md
[N28]: notes/28-RELEASE-QUALIFICATION-AND-ARTIFACT-BINDING.md
[N30]: notes/30-READINESS-PREDICATES-AND-OPERATOR-PROJECTIONS.md
[N31]: notes/31-TOOL-ACTIVITY-INGESTION-AND-RISK-USE.md
[N32]: notes/32-USAGE-COST-CONTEXT-AND-RESOURCE-CONTROL.md
[N33]: notes/33-NATIVE-SYSTEM-ASSEMBLY-AND-RESEARCH-FRONTIER.md
[N34]: notes/34-WORKTREE-INTEGRATION-AND-RETENTION-BOUNDARIES.md
[N35]: notes/35-CONNECTOR-GRAPH-RECALL-AND-RECIPIENT-USE.md
[N36]: notes/36-NODE-RECALL-PROXIMITY-AND-ADVISORY-CONSUMERS.md
[N37]: notes/37-MANAGED-MAINTENANCE-OWNERSHIP-AND-PREVIEW.md
[N38]: notes/38-SHARED-CONFIGURATION-OWNERSHIP-AND-LEGACY-RECOVERY.md
[N39]: notes/39-GUIDANCE-ADAPTATION-AND-PROCEDURAL-HANDOFFS.md
[N40]: notes/40-HARNESS-SCORECARD-AND-OPTIMIZATION-CONSUMERS.md
[N41]: notes/41-AURA-REPUTATION-GATE-AND-CALLER-BOUNDARIES.md
[N42]: notes/42-CONSULT-RECOMMENDATIONS-AND-INSTALLATION-BINDING.md
[N43]: notes/43-ITO-CLI-BRIDGE-AUTHORITY-AND-EFFECT-BOUNDARIES.md
[N44]: notes/44-NASIKO-ARTIFACT-IDENTITY-AND-LIFECYCLE-RECOVERY.md
[N45]: notes/45-NANOCLAW-CONTEXT-REPLAY-AND-SESSION-CONTINUITY.md
[N46]: notes/46-DESKTOP-DASHBOARD-DISCOVERY-AND-ACTION-BOUNDARIES.md
[N47]: notes/47-BROWSER-DASHBOARD-EXPOSURE-AND-CONSUMER-BOUNDARIES.md
[N48]: notes/48-MCP-RESPONSIBILITY-RECONCILIATION-AND-CODEX-SYNC.md
[N50]: notes/50-PI-HOOK-CONTEXT-AND-HOST-CONSUMPTION.md
[N51]: notes/51-CURSOR-DEPLOYMENT-DATA-ROOT-AND-CONTEXT-HANDOFF.md
[N52]: notes/52-CODEX-BASELINE-GENERATION-AND-GIT-VALIDATION.md
[N53]: notes/53-KIRO-SNAPSHOT-LINEAGE-AND-SELECTED-AUTHORITY.md
[N54]: notes/54-DOCUMENT-CLAIMS-ADAPTATION-AND-RECOVERY.md
[N55]: notes/55-EVALUATOR-FIXTURES-ORACLES-AND-PROMOTION-CLAIMS.md
[N56]: notes/56-REMAINING-SOURCE-DISPOSITION-AND-SYNTHESIS-ENTRY.md
