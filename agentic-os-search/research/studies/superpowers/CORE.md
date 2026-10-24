# Superpowers — CORE

**Date:** 2026-09-18. **Standing:** bounded research result, ready for owner evaluation; not adoption or a product certificate. [STATE](STATE.md) owns current work and publication. [CLOSURE-AUDIT](CLOSURE-AUDIT.md) records the final challenge and residuals.

**Primary:** `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest context 6.3.0. A direct main-ref check on 2026-09-18 returned that same commit. This qualifies the source snapshot, not installed hosts, every release channel or future main. The separate evaluation lab and historical assessor retain their own pins in [S01](syntheses/S01-skill-evolution-and-evaluation.md).

This is deliberately condensed. It does not replace the six syntheses, eleven mechanism notes, original experiments or pinned sources. [INDEX](INDEX.md) supplies downward routes; [SOURCE-LEDGER-U08C](SOURCE-LEDGER-U08C.md) identifies the final reads and their limits.

## 1. One-sentence model

**Superpowers is a portable software-development methodology expressed through skill and role contracts, interpreted by host-provided agents and tools, supported by concrete adapters, file/Git helpers and an optional visual runtime, with a separate process for developing, evaluating and distributing the method itself.** [S05](syntheses/S05-native-system-model.md)

It is more than prompts, but not a self-sufficient autonomous runtime. Its important behavior is distributed among instructions, executable helpers, host capabilities, agent judgment and human decisions. These sources of control have different guarantees.

## 2. The work is not one universal pipeline

The build-entry contract scales preparation:

| Route | Source-defined purpose and preparation | Boundary |
|---|---|---|
| Spike | Approve a feasibility probe, investigate and report a recommendation. | Probe code remains throwaway; keeping it is a new request. |
| Bounded | Clarify a narrow change to an existing flow, present a short design in chat and obtain approval. | No separate written spec or implementation plan; planned SDD properties are not automatically inherited. |
| Architectural | Develop alternatives and design, write/review the spec, obtain human approval and prepare a detailed plan. | The longest preparation route is not required for every request. |

Diagnosis and review can enter through their own relevant skills. A plan can be executed through SDD or the alternate execution route, subject to available capabilities and the relevant contract. Independent-domain parallel dispatch is a separate procedure; SDD normally serializes implementation workers and permits batching small same-shape edits. [S03](syntheses/S03-intent-planning-and-context-handoff.md); [S04](syntheses/S04-execution-verification-and-delivery.md)

A useful, non-universal development path is:

`appropriate working agreement → applicable task/context → production → review and coverage resolution → correction or explicit disposition → qualified completion → human integration choice → actual integration and surviving records`.

Each arrow is a handoff to investigate, not a demonstrated automatic state transition.

## 3. Coordination includes preserving meaning

In SDD, the controller reads spec/plan, selects binding context and interfaces, records review endpoints, routes worker results, resolves what a task-local reviewer cannot verify, records rulings and carries residuals forward. It is not merely a scheduler. [S03 §3](syntheses/S03-intent-planning-and-context-handoff.md)

A task extractor can correctly copy a section without supplying the plan's globals. The controller must provide the additional context. Narrow contexts can avoid repeated history, but make selection consequential. A worker and reviewer can share the same omission when they share an incomplete brief. This is an explanatory dependency, not a measured universal failure or cost advantage.

| Responsibility | Main source-defined role | Do not infer |
|---|---|---|
| Agree on intended work and major external effects | Human, with route-specific proposals | An implementation request grants every later effect. |
| Preserve cross-task meaning and adjudicate ordinary SDD conflicts | Controller, using spec and recorded rulings | Assigned authority guarantees a correct ruling. |
| Implement, test and report | Task implementer | DONE means accepted. |
| Assess the task | One task reviewer, giving spec and quality verdicts | Two verdicts mean two independent reviewers or independent test reruns. |
| Check changed fixes and overall branch | Scoped re-review and final review roles | A local diff establishes complete system coverage. |

Role restrictions are also scoped. SDD explicitly forbids workers and reviewers from spawning further subagents. The separately inspected parallel-dispatch skill does not contain the same express prohibition. Do not turn a local contract into a system-wide enforced topology. [CLOSURE-AUDIT §3](CLOSURE-AUDIT.md)

## 4. Useful discipline without a single green state

The source contributes substantive positive mechanisms: testable task boundaries, consumes/produces interfaces, file-backed briefs and reports, reviewer skepticism toward implementer rationales, explicit unverified requirements, hypothesis-led diagnosis, changed-response escalation, bounded correction, recorded disagreement and merged-result retesting. [S03](syntheses/S03-intent-planning-and-context-handoff.md); [S04](syntheses/S04-execution-verification-and-delivery.md)

Their interpretation requires several distinctions:

- **Test chronology, test validity and current applicability:** writing a test first, catching the intended defect and testing the present object are separate claims.
- **Production, review and disposition:** task completion can mean clean review or recorded parked findings. Reaching a correction cap does not prove that a remaining defect is false.
- **Evidence scope:** the helper packages the supplied BASE–HEAD range; the caller must bind that range to the real task. Committed diff and tested working copy need not be identical.
- **Integration and retention:** branch success does not establish merged-state success. Merge, push, cleanup, decision disclosure and archival can have different outcomes.

The prior local experiments illustrate narrow boundaries; they are not an overall reliability score. Positive controls and unmet stronger criteria remain together in their original records. In particular, ignored SDD scratch is intentionally ephemeral: retaining code or avoiding force-removal does not necessarily preserve every detailed report. [S04 §§5–7](syntheses/S04-execution-verification-and-delivery.md)

## 5. Availability and continuity depend on the consumer

Shared skill content reaches different hosts through different mechanisms: native discovery, hooks, included files and in-process adapters. Tool mappings can change work organization rather than merely rename a function. The optional visual companion supports dialogue; a click, selected UI state and approval of a design are not interchangeable. [S02](syntheses/S02-availability-runtime-and-distribution.md)

`source selected ≠ package assembled ≠ files installed ≠ session activated ≠ relevant content loaded ≠ procedure followed ≠ useful outcome`.

Similarly, procedure reloading and current-work recovery are different. SDD has real recovery artifacts, but plan basename, full path, revision and accepted completion have different identities. A reconnect can restore reachability without restoring a previous question. Archive and sync channels can incorporate different metadata and working-copy inputs, so a release label or source permalink alone may not identify the whole artifact.

These distinctions locate reuse conditions; they do not declare every fallback or helper defective.

## 6. The method-change loop is separate

Superpowers' authoring method begins with the failure and appropriate intervention layer, not an automatic demand for more instructions. A prohibition, positive recipe, required field, conditional, mechanical check or no new skill can be appropriate for different problems. [S01](syntheses/S01-skill-evolution-and-evaluation.md)

The separate evaluation path can define stock/treatment arms, collect interaction and output evidence, run scoped deterministic checks, obtain criterion judgments and retain pass/fail/indeterminate. The inspected assessor enforces report structure and prior source exposure; publication binds result bytes and run identity. Those are real code-level controls.

However, report acceptance is not sound judgment, counted use is not task benefit, and a repaired measuring instrument is not an improved coding agent. Public reports include semantic counterexamples and uncalibrated-grader limits; private underlying runs were not independently authenticated by this study. No general causal Superpowers advantage was established.

The two loops meet when work observations inform method changes and an admitted revision reaches later work. No universal automatic self-improvement service is demonstrated.

## 7. Authority and rule composition remain conditional

The target gives user instructions priority over skills and the spec priority over the plan. It does not supply a fully specified universal resolver for every overlap. Three material boundaries remain explicit:

| Residual | Unresolved scope |
|---|---|
| Q13 | Brainstorming's scope upgrade/reapproval versus SDD's recorded decisions and continued execution. |
| Q20 | Generic/reviewer human-decision wording versus specialized controller adjudication. |
| Q24 | Literal current-message verification versus reuse of existing same-code test evidence. |

Actor, phase and claim differences can explain part of these tensions. Plausible reconciliation is not an implemented precedence rule. The final source challenge also preserves all four SDD stop classes, rather than the release summary's narrower shorthand. [S05 §6](syntheses/S05-native-system-model.md); [CLOSURE-AUDIT](CLOSURE-AUDIT.md)

## 8. What this contributes to SOUL / Development OS

The strongest contribution is a mechanism-and-countercase corpus, not a Superpowers-shaped architecture. [S06](syntheses/S06-project-facing-contribution-and-comparison.md)

For Development OS, the SDLC mechanisms are relatively direct references. For SOUL's broader working-system formation goal, their value is conditional: applicable guidance, sufficient actor context, legitimate decisions, qualified completion, actual recovery and controlled method evolution.

Foundation sharpens three particularly useful questions: were all necessary pursuits discovered rather than only selected tasks completed; does the designated consumer have a common adequate and available informational basis; and what actual authority, condition and effect underlie a recorded success? Compact context with established side information can suffice—copying the entire research corpus is not prescribed.

The selected gstack, Hermes and Flowable comparisons distinguish downstream delivery qualification, procedure-library lifecycle and durable engine-owned transitions. They are recorded-scope comparisons, not rankings, compatibility tests or recommendations to integrate those products.

## 9. Closure and later reuse

The bounded explanatory study is complete for this corpus and purpose, with owner evaluation pending. Closure does not eliminate Q01–Q47, certify live hosts or authorize installation, experiments, upstream changes or architecture adoption. [METHOD §9](METHOD.md); [CLOSURE-AUDIT](CLOSURE-AUDIT.md)

For a later concrete question: start at [STATE](STATE.md), use this CORE to orient, select [S01–S06 through INDEX](INDEX.md), then recover the actual mechanism/source and its evidence class. Revalidate changed technical inputs and target authority before stronger use. Reopen a named material omission or invalidated claim, not the entire study merely because more files exist.

**Durable result:** Superpowers makes development work more explicitly organized through scoped agreements, context handoffs, role contracts, review/disposition and method evolution. Its guarantees depend on which actor, source, evidence, host and decision actually meet at each handoff—not on the number of skills or the strength of their wording alone.
