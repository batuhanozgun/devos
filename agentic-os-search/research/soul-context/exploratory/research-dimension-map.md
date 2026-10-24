# SOUL Research Dimension Map — Stage 3 omission / overlap / counter-frame red team

**Status:** active; taxonomy tightened, not architecture  
**Date:** 2026-08-30

## Purpose

Define a small set of **discriminating research dimensions** that can support SOUL Phase 1–3 without becoming a technology catalogue, KEEL reconstruction or unbounded defect list.

A dimension is retained only if it protects a distinguishable property/failure surface and has meaningfully different evidence/stopping obligations from its neighbours.

## Epistemic classes

- **Foundation constraint / owner-defined property:** current authority; research can find contradiction/impossibility but cannot silently vote it away.
- **Researchable system question:** evidence informs capability necessity, failure classes, alternative layers and design trade-offs.
- **Task-specific capability family:** may be needed for some outcomes but is not automatically a stable-core dimension.
- **Validation axis:** tests several dimensions; should not be mistaken for a component/capability.

## Source basis

Primary SOUL foundation/governance:
- `VISION.md`
- `DEFINITION.md`
- `SUCCESS_CRITERIA.md`
- `NON_NEGOTIABLES.md`
- `ROADMAP.md`
- `ROLE_MODEL.md`
- `DECISION_POLICY.md`
- `EVIDENCE_TEMPLATE.md`
- `REASONING_POLICY.md`

Challenge evidence:
- reconstructed os-architect / KEEL / SOUL failure corpus;
- NASA decision-analysis holdout;
- Cochrane/PRISMA evidence-synthesis holdout;
- NIST/FEMA dynamic-operations holdout.

# Current property dimensions

## D1 — Intended outcome → bounded work definition

**Protected property:** the system pursues the actual intended outcome under explicit assumptions, unknowns, constraints, acceptance conditions and human decision boundaries instead of converting the user's wording/method directly into execution.

**Key research questions:**
- fact gap vs assumption vs constraint vs preference/value vs approval boundary;
- question/request vs task/objective;
- when to ask, infer, research, defer or refuse;
- how to detect framing drift and hidden premise failure.

**Evidence:** requirements/intent elicitation prior art; historical framing failures; ambiguous-premise scenario tests; owner burden versus framing-error reduction.

**Falsifiers:** lighter direct execution performs equally/better on outcome fidelity; clarification increases burden without reducing material errors; proposed universal goal schema fails across domains.

**Phase 1–3 relevance:** direct Phase-1 purpose/input/completion boundary; capability implications in Phase 2; framing/drift failures in Phase 3.

---

## D2 — Task-specific system formation and capability derivation

**Protected property:** SOUL derives the functions/capabilities needed by the outcome instead of relying on a permanently fixed team, toolset or workflow.

**Key research questions:**
- capability versus role/tool/workflow/mechanism;
- function/capability necessity from outcome + failure/control obligations;
- existing vs adapted vs genuinely missing capability;
- when motivation/authority separation is necessary versus coordination overhead;
- burden of proof for durable roles/controls.

**Evidence:** cross-domain functional decomposition; systems-engineering/function-allocation prior art; agent-system comparisons as prior art; ablation/comparator evidence for durable component necessity; historical motivation conflicts.

**Falsifiers:** simpler structure protects same property; capability categories collapse across domains; bundled-treatment improvement is the only support for a permanent component.

**Elasticity guard:** D2 is intentionally able to contain **task-specific capability discovery**, but it may not use that breadth to declare every domain method a stable-core capability. Domain methods such as NASA-style decision analysis remain task-specific unless independent evidence establishes a core invariant.

**Phase 1–3 relevance:** actor/system boundary; central Phase-2 function/capability map; capability failure surfaces in Phase 3.

---

## D3 — Internal/external state, memory, context, knowledge and retrieval

**Protected property:** the system can preserve authoritative truth and supply sufficient, fresh, relevant information to actors without collapsing state/history/context/knowledge/world observations into one undifferentiated prompt/store.

**Key research questions:**
- authority, lifetime, freshness, trust and access classes;
- durable internal/project state versus externally observed world state;
- validity horizon of observations and plan assumptions;
- always-present vs retrieve-on-trigger vs reconstructable vs forensic information;
- omission, stale/conflict detection and unknown-needed evidence;
- source/entity versus multiple representations/reports;
- cold-start sufficiency.

**Evidence:** context/retrieval literature; cold-start tests; stale/conflict/omission scenarios; external-state update scenarios; comparative context-load versus error experiments.

**Falsifiers:** context reduction hides material evidence; retrieval trigger depends on omitted evidence; derived summary becomes authority; stale world observation remains silently valid; fresh actor cannot reconstruct responsibility.

**Phase 1–3 relevance:** minimum conceptual separation for Phase 1; capability families in Phase 2; stale/omitted/conflicted-state signals/controls in Phase 3.

---

## D4 — Authority, bounded agency and human governance

**Protected property:** actors/tools/capabilities operate under explicit bounded authority while human judgement is used for genuine values/approval rather than hidden technical orchestration.

**Key research questions:**
- normative/value/authority choices versus technical/researchable choices;
- least privilege and protected control state;
- circular technical acceptance and self-extension;
- separation-of-duties benefit versus coordination cost;
- escalation without owner-as-scheduler/verifier.

**Evidence:** access-control/separation-of-duties prior art; governance/safety evidence; privilege/authority failure cases; authority-boundary adversarial scenarios.

**Falsifiers:** separation relocates ambiguity; no non-circular acceptance authority exists; controls turn owner into routine orchestrator; constrained actor controls its own constraints.

**Phase 1–3 relevance:** direct Phase-1 autonomy/human governance; authority/control capabilities in Phase 2; authority failure/control ownership in Phase 3.

---

## D5 — Evidence, provenance, verification and completion

**Protected property:** material success/recommendation claims are supported by appropriate evidence and independent enough verification rather than narrative, tool success, producer confidence or correlated agreement.

**Key research questions:**
- claim/evidence classes;
- deterministic verification vs semantic/evaluative judgement vs irreducible uncertainty;
- valid oracle/falsifiability;
- independence and correlated-error risk;
- exact-target/freshness binding;
- analytical provenance `claim → method → inputs → source/version`;
- risk-proportional completion/evidence thresholds.

**Evidence:** V&V/reproducibility/evaluation prior art; mutation/negative tests; analytical provenance cases; reviewer-independence comparisons.

**Falsifiers:** green path never exercises rejection; verifier derives truth from producer rationale; target changed after review; recommendation cannot be reconstructed; agreement shares source/frame error.

**Phase 1–3 relevance:** direct Phase-1 completion semantics; evidence/verification capabilities in Phase 2; oracle/provenance/false-green failures in Phase 3.

---

## D6 — Failure representation, containment, recovery and liveness

**Protected property:** uncertainty and failure are representable states with bounded prevention/detection/containment/recovery/non-completion paths rather than silent drift or forced-success prose.

**Key research questions:**
- domain-neutral agentic failure taxonomy;
- observable signals;
- prevention/detection/containment/recovery/regression allocation;
- proximate versus root causes;
- repair versus reframe/research/redesign;
- deadlock/starvation/oscillation/meta-work and recovery safety.

**Evidence:** predecessor failure corpus; cross-domain incident/fault-tolerance prior art; state-machine counterexamples; failure injection/recovery scenarios.

**Falsifiers:** taxonomy collapses into software bugs; safe fallback loses later truth; stronger controls create unbounded meta-work/deadlock; recovery requires inventing control semantics during the incident.

**Phase 1–3 relevance:** legitimate lifecycle/non-completion in Phase 1; control capabilities in Phase 2; central Phase-3 failure model.

---

## D7 — Learning, controlled evolution and capability admission

**Protected property:** validated lessons/missing capabilities can change the future system through governed evolution without allowing running work to rewrite its own correctness/authority/admission rules.

**Key research questions:**
- when a repeated failure justifies durable control;
- lesson invocation at need time;
- local fix vs class control vs architecture evolution vs foundation reopening;
- missing-capability admission evidence;
- disable/rollback/forward-restoration semantics.

**Evidence:** change/configuration-management and safety-case prior art; adaptation/self-modification literature; historical lesson-transfer failures; prospective capability-admission trials; regression/mutation evidence.

**Falsifiers:** lesson remains prose and repeats; capability self-certifies; historical replay is treated as generalisation; rollback lacks invariants/forward restoration.

**Phase 1–3 relevance:** Evolution concern in Phase 1; missing-capability governance first-class in Phase 2; evolution/admission failures in Phase 3.

---

## D8 — Observability and reconstructability

**Protected property:** an authorised human/fresh actor can determine material system state, actions, authority, evidence, blockers and stop reasons without hidden reasoning or conflicting shadow truth.

**Key research questions:**
- minimum event/state/decision/evidence trace;
- authoritative state versus derived operational view;
- forensic reconstruction;
- observability needed for failure diagnosis, authority audit, verification and resource/cost control;
- avoiding unbounded telemetry/context growth.

**Evidence:** observability/audit/event-sourcing prior art; reconstruction exercises; operator scenarios; stale-view/omission tests.

**Falsifiers:** operator cannot explain stop/authority/evidence; trace cannot reconstruct sequence; telemetry becomes competing source of truth; more telemetry reduces diagnostic reliability.

**Phase 1–3 relevance:** controlled/inspectable lifecycle in Phase 1; observability capabilities in Phase 2; explicit failure signals required by Phase 3.

---

## D9 — Core invariant ↔ task-specific system / system boundary

**Why D9 changed:** Stage-1 called this `Generality, domain transfer and task-specific architecture`. Red-team showed that **domain transfer is primarily a validation axis**, not the same kind of property/capability dimension as D1–D8/D10.

**Protected property:** SOUL has a stable control/core boundary while deriving task-specific working systems; domain assumptions and one pilot's workflow do not silently become universal core semantics.

**Key research questions:**
- what qualifies as an invariant concept/property versus generated task structure;
- what belongs to SOUL, generated operating system, external environment or human authority;
- how to detect domain assumptions leaking into core;
- what should remain extensible rather than invariant;
- which proposed core abstractions become contradictory/meaningless across domains.

**Evidence:** cross-domain comparative task analysis; negative cases; systems-architecture boundary prior art; materially different scenario mapping.

**Falsifiers:** core requires software-specific workflow semantics; invariant has no stable meaning in another domain; task-specific method must be hard-coded for system formation to work; system boundary moves opportunistically to preserve a claim.

**Phase 1–3 relevance:** direct Phase-1 system/non-system boundary; core/task-specific capability allocation in Phase 2; domain-leak failure classes in Phase 3.

---

## D10 — Work selection, decomposition, orchestration and lifecycle

**Protected property:** current objective/state/evidence becomes the correct bounded next work and progresses through execution/handoff/replanning/completion without local completion pressure, static backlog assumptions or hidden orchestration.

**Key research questions:**
- result integration vs substantive next-work selection vs design vs implementation;
- work granularity/decomposition/dependencies;
- risk/uncertainty-proportional reasoning depth;
- repair vs reframe/research/redesign/owner-decision routing;
- purpose-preserving handoff;
- external-state/assumption invalidation → replanning;
- time/resource/budget/concurrency constraints as work-selection inputs;
- oscillation, starvation, infinite investigation and premature closure.

**Evidence:** historical work trajectories; workflow/program-decision prior art; blind replay/holdout trajectories; simpler-routing comparisons; dynamic-operations cases; process/cost/liveness metrics.

**Falsifiers:** planner/gate complexity does not detect failures earlier than a simpler baseline; faithful integration still auto-manufactures repair; handoff loses purpose; routing oscillates; actor silently redesigns; overhead rises without reliability benefit.

**Phase 1–3 relevance:** direct Phase-1 lifecycle; planning/orchestration/handoff functions in Phase 2; routing/liveness/handoff failures in Phase 3.

# Cross-cutting validation axes

## V1 — Domain transfer / scenario diversity

This is the corrected home for the former `domain transfer` part of D9.

**Question:** do D1–D10 properties/capabilities/failures remain meaningful across materially different target families without importing one domain workflow into core?

**Current holdouts:**
- analytical decision support — NASA decision-analysis guidance;
- systematic evidence synthesis — Cochrane/PRISMA;
- dynamic incident/operations — NIST/FEMA.

**Important:** V1 tests the whole map. Passing one `D9` box cannot prove generality.

## V2 — Risk/materiality/proportionality and evidence value

The required depth of research/control should vary with consequence, uncertainty, reversibility and information value.

Relevant evidence:
- NASA: analysis depth and uncertainty reduction are decision/risk dependent and must justify resource/schedule cost;
- SOUL WP-021: more analysis/roles/artefacts are not success metrics;
- current foundation: target is useful bounded autonomy, not maximum process.

V2 prevents `more control` and `more research` from becoming default answers.

## V3 — Source/view fidelity and omission awareness

Research and runtime derived views must not silently become source truth or completeness claims.

This axis cuts across D3/D5/D8 and is directly motivated by:
- duplicate/stale canonical state history;
- Cochrane study-versus-report and search-completeness distinctions;
- F-AR-011 selective-context omission risk;
- canonical source/view control in this research project.

# Overlap red-team — why dimensions remain separate

| Pair | Why not merge |
|---|---|
| D1 vs D10 | D1 asks whether the **right objective/work definition** exists; D10 asks whether the system selects and advances the **right next work** under that definition. Correct objective can still have bad routing; good routing can efficiently pursue wrong objective. |
| D2 vs D10 | D2 concerns which functions/capabilities the task-specific system needs; D10 concerns lifecycle/work transition and execution sequencing. |
| D3 vs D8 | D3 protects information/state truth, freshness and availability; D8 protects visibility/reconstructability. Correct truth may be invisible; visible trace may represent stale/incorrect truth. |
| D4 vs D5 | D4 asks `who may decide/do`; D5 asks `what evidence justifies the claim`. Correct authority can make epistemically bad decisions and vice versa. |
| D5 vs D6 | D5 protects correctness/completion claims; D6 represents and handles failure/uncertainty/liveness. A verifier can correctly detect a failure without recovery semantics. |
| D6 vs D7 | D6 restores/contains current work; D7 changes the future system/capability set. Recovery and evolution have different authority/freshness/rollback risks. |
| D2 vs D9 | D2 derives what capabilities a task-specific system needs; D9 decides what, if anything, belongs to stable core versus generated/task-specific structure. |
| D6 vs D10 | D6 defines failure states/control responses; D10 decides/sequences substantive work. A failure can be accurately represented yet routed to the wrong next work. |

# Roadmap-leak test

No current dimension is retained solely because a later roadmap phase has a matching title.

Independent foundation/history support exists for each:

- D1: Success Criterion 1 + historical question≠task/frame blindness.
- D2: Vision/Definition + Success Criterion 2/12.
- D3: Non-negotiables 1/5/7/12 + observed state/context failures + operations holdout.
- D4: Vision/Definition + non-negotiables 4/6/9/14 + owner-orchestration failures.
- D5: Vision + Success 6–8 + false-green/verifier failures.
- D6: Success 10 + non-negotiable 10/11 + historical recovery/liveness failures.
- D7: Definition Evolution + Success 11/12 + lesson-transfer failures.
- D8: Success 13 + non-negotiable 15 + reconstruction/visibility failures.
- D9: Vision/Definition `general-purpose but not one fixed architecture` + non-negotiable 13 + Success 14.
- D10: Definition Runtime + historical work-loop failure + WP-021 + NASA/FEMA holdouts.

Roadmap therefore organises later architecture work around properties that have independent support; it is not the sole reason the dimensions exist.

# Holdout omission test

## S1 NASA analytical decision support

Properties observed first:
- decision context/intended outcome,
- criteria and preferences,
- alternatives,
- uncertainty/sensitivity,
- decision authority,
- risk-proportional analysis depth,
- value of additional information.

Mapping:
- D1, D4, D5, D10;
- domain-specific alternative-evaluation method belongs under D2 task-specific capability derivation unless later evidence proves a stable-core invariant.

**Stretch flag:** D2 is broad, but this use is intentional and falsifiable through D9/V1; it is not used to declare NASA's process a SOUL core mechanism.

## S2 Cochrane/PRISMA evidence synthesis

Properties observed first:
- explicit review boundary/eligibility,
- source/entity versus multiple reports,
- search coverage and selection trace,
- method-specific stopping,
- freshness/update,
- documented residual uncertainty.

Mapping:
- D1, D3, D5, D8, D10 + V3.

**Stretch flag:** none material. The holdout instead invalidated a universal research-stopping formula.

## S3 NIST/FEMA dynamic operations

Properties observed first:
- changing external conditions,
- situational awareness,
- operational-period validity,
- objectives and resources,
- execute/evaluate/revise,
- containment/recovery,
- continuous lessons/improvement,
- authority/coordination.

Mapping:
- D3, D4, D6, D7, D8, D10.

**Stretch flag resolved by revision:** initial D3 was too internally focused. D3 now explicitly includes external-world observations/freshness; D10 includes assumption-triggered replanning and resource/time constraints.

No separate `environment sensing` dimension is justified yet. If another materially different domain exposes external-state properties not representable without stretching D3/D10, reopen.

# Counter-frame test

A lifecycle/control-plane organisation can explain the same dimensions more compactly:

## Lifecycle functions
- D1 — define intended work
- D2 — form task-specific system
- D10 — select/execute/coordinate work
- D7 — evolve the system

## Cross-cutting control/information properties
- D3 — information/state/context
- D4 — authority/human governance
- D5 — evidence/verification/completion
- D6 — failure/recovery/liveness
- D8 — observability
- D9 — core/task-specific/system boundary

This counter-frame **does not currently reduce the protected-property count**; it is a useful second view, not a competing source of truth. It shows that D1–D10 need not imply ten runtime services or ten agents.

That distinction is important: research dimension ≠ architectural component.

# Current dimension set

1. D1 — Intended outcome → bounded work definition
2. D2 — Task-specific system formation / capability derivation
3. D3 — Internal/external state / memory / context / knowledge / retrieval
4. D4 — Authority / bounded agency / human governance
5. D5 — Evidence / provenance / verification / completion
6. D6 — Failure representation / containment / recovery / liveness
7. D7 — Learning / controlled evolution / capability admission
8. D8 — Observability / reconstructability
9. D9 — Core invariant ↔ task-specific system / system boundary
10. D10 — Work selection / decomposition / orchestration / lifecycle

Cross-cutting:
- V1 domain transfer/scenario diversity,
- V2 risk/materiality/proportionality/value of information,
- V3 source/view fidelity and omission awareness.

# Current validity judgement

The dimension set has changed under every major challenge round so far:

- Stage 1: D1–D9 from foundation.
- Stage 2: historical failure corpus forced D10.
- External holdout: widened D3/D10 and changed stopping logic.
- Stage 3: reclassified domain transfer from D9 into V1; narrowed D9 to a discriminating core/task-specific boundary property; added explicit resource/time inputs to D10.

This is evidence against pure confirmation, but **not proof of completeness**.

# Next gate

Before freezing the question inventory:

1. test whether V1–V3 are sufficient validation axes or another cross-cutting risk is missing;
2. derive the **smallest pre-Phase1/2/3 question set** for each D1–D10 using `prearchitecture-research-scope.md`;
3. attach evidence class + strongest falsifier + stopping condition;
4. ensure no question embeds a mechanism/role/tool answer;
5. adversarially sample omitted domains/questions rather than expanding literature indiscriminately.

If this survives, Phase 8 can move from taxonomy construction to a bounded research-package inventory.