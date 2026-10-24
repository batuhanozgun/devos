# Relation / Control / Composition — C3 Multi-Ground Composite Patterns

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Test composition on cases that cannot be understood faithfully as one pairwise edge.

The question is whether recurring multi-ground semantics support the provisional composition regions or expose a missing region/fifth ground.

---

## 2. Goal / Outcome / Criteria

### Required anchors

- **Work:** pursuit directed toward some intended condition/result;
- **Information:** goal/requirement/specification/criterion representation;
- **Environment:** actual realized target condition and dynamics;
- **Actors:** preference/value/mandate/authority over what counts as desired or acceptable.

### Composition pattern

```text
Actor preference/mandate
→ represented desired condition / criterion
→ Work directed toward that condition
→ Work attempts/produces Environment effect
→ evidence represents resulting condition
→ criterion-relative attainment/acceptance standing
```

### Key distinctions

```text
goal represented != goal authorized/committed
Work completed != desired Environment condition attained
criterion satisfied != authorized acceptance
```

### Structural result

`Goal/Outcome` is not a fifth ground here. The load-bearing semantic is distributed across:
- binding/directedness;
- derived attainment standing;
- authority/control around commitment/acceptance;
- transition/effect from pursuit to realized condition.

The provisional four-region frame explains the case without residual semantic loss.

---

## 3. Verification / Validation / Acceptance

### Required anchors

- **Work:** verification/validation/review activity;
- **Information:** requirement/criterion, exact target/version identity, evidence, result/verdict;
- **Environment:** actual product/system/use environment or target condition when the claim is reality-facing;
- **Actors:** verifier, customer/user/stakeholder, acceptance authority/forum.

### Distinct derived standings

```text
verified against specified requirement
!= validated / fit for intended use
!= accepted by authorized party
```

### Why this is not one relation

A bare `verified-by` edge omits:
- exact target/version;
- criterion;
- evidence;
- verification activity/method;
- result freshness;
- verifier role/independence where required.

A bare `accepted-by` edge omits whether the authorized acceptance is based on verified/validated evidence and whether acceptance changed Work standing.

### Structural result

This case strongly supports:
- Relational Binding — target/evidence/verifier/criterion associations;
- Derived Standing — verified/validated/accepted statuses;
- Control — required gate, authority, independence constraints;
- Transition — performance of verification/validation and resulting standing changes.

No fifth Assurance ground is forced.

---

## 4. Capability / Access / Actionability / Effective Power

### Required anchors

- **Actors:** capability/competence; permission/authority; delegation;
- **Environment:** tool/resource/network/credential/interface availability and actual enforcement substrate;
- **Work:** action/method/path/target transition being considered;
- **Information:** policy/configuration/credential/role representations, current state/telemetry where used;
- reachable Actor/tool/channel topology may span all of the above.

### Distinct standings

```text
technically possible
currently actionable
institutionally authorized
allowed by configured policy
actually enforceable/blocked
reachable indirect effect power
```

These are not synonyms.

### Transitive authority/effect example

```text
Actor A lacks direct write route
A can invoke Actor B
B can invoke privileged tool
actual effect becomes reachable
```

This may establish indirect effect power without establishing legitimate delegated authority.

### Structural result

This is the clearest evidence that **Derived Standing** deserves separate treatment: `actionable`, `authorized`, `reachable effect power` arise from several relations/conditions rather than one local property.

It also strongly supports **Control** because path closure, permissions, delegation and enforcement constrain transitions.

No fifth Capability/Actionability ground is forced.

---

## 5. Governance / Policy / Authority / Enforcement / Compliance

### Required anchors

- **Information:** policy/rule/configuration/decision representation;
- **Actors:** policy owner, authority, obligation, decision/approval standing;
- **Work:** approval/review/control operation and controlled transition;
- **Environment:** runtime/sandbox/network/tool/physical/institutional enforcement conditions and actual behavior.

### Required non-collapse

```text
policy text
!= legitimate authority
!= authorization/decision outcome
!= actual technical enforcement
!= observed compliant behavior
```

### Advisory vs enforceable control

A prose instruction can influence an Actor/agent without mechanically preventing violation. A sandbox/network restriction can block a path without itself establishing the institutionally correct policy.

Therefore control semantics require at least:
- normative/decision layer;
- represented rule/evidence layer;
- realized enforcement layer;
- transition/behavior layer.

### Structural result

Governance/Control is not another ground. It is a strong **composition region** because the control problem is exactly how several ground semantics jointly constrain transitions.

This case is the strongest support for retaining Control/Constraint as an immediate research candidate.

---

## 6. Provenance / Attribution / Responsibility / Accountability

### Required anchors

- **Information:** source, derivation, lineage, evidence record;
- **Work:** performer/contributor/activity that produced or changed something;
- **Actors:** causal/institutional/legal attribution, duty/responsibility, accountability forum;
- **Environment:** actual effect/outcome when responsibility concerns realized consequences.

### Required non-collapse

```text
information provenance
!= causal contribution
!= activity participation
!= institutional/legal attribution
!= responsibility
!= accountability
```

### Example pressure

A software agent may generate an artifact (provenance), under Work assigned by a human/organization, while legal/institutional attribution remains with another bearer and accountability lies with a forum/owner.

### Structural result

Provenance does not require its own parent child. It appears as:
- binding/lineage relations;
- derived attribution/responsibility standings;
- controls/obligations/forums;
- transitions that generated/changed artifacts or effects.

However, provenance/attribution remains a mandatory cross-cutting semantic family in later child research.

---

## 7. Target / Effect / Causation

### Required anchors

- **Work:** intended intervention/pursuit/action;
- **Environment:** actual before/after condition/dynamics;
- **Information:** observation/model/evidence/counterfactual claim;
- **Actors:** causal/institutional attribution and responsibility where relevant.

### Required non-collapse

```text
Work occurred before Environment change
!= Work caused Environment change

intended target
!= realized effect

evidence of effect
!= effect itself
```

### Structural result

Causation remains best treated as a cross-cutting semantic dimension concentrated in Binding + Transition/Effect, with evidential derived standings.

No separate Causation child is forced at parent level.

---

## 8. Feedback / Learning / Evolution

### Recurrent pattern

```text
Environment event/outcome/failure
→ Information observation/evidence/incident record
→ Work diagnosis/evaluation/adaptation
→ Actor decision/authorization
→ changed Work / Information / Actor standing / Environment condition
→ new observation cycle
```

### Important distinctions

- observation is not learning by itself;
- creating a lesson/record is not changing behavior/control;
- changing policy text is not changing enforcement;
- repeated failure is not automatically converted into deterministic control;
- adaptation Work must itself be authorized/verified where needed.

### Structural result

Evolution is a **transition/feedback pattern over the four grounds**, often with control changes and new derived standings.

No fifth Evolution ground is forced.

---

## 9. Risk / Value / Priority

### Required anchors

- **Actors:** values/preferences/tolerances/authority;
- **Information:** estimates, uncertainty, evidence;
- **Environment:** consequences/exposure/constraints;
- **Work:** candidate selection/priority/capacity/opportunity cost.

### Structural result

Risk/value/priority behaves primarily as derived standing/qualification plus decision/control over Work, not as a stable fifth ground.

It remains a later composition specialization unless a domain-specific pass proves otherwise.

---

## 10. Dependency / Coordination / Support

### Required anchors

- **Work:** order, concurrency, dependency, handoff, integration;
- **Environment:** shared resources/capacity/contention/isolation;
- **Actors:** assignment/delegation/authority;
- **Information:** shared state, provenance, exact versions, conflict/merge information.

### Structural result

Coordination is not one Work-local relation when execution spans actors/resources/shared information. It becomes a multi-ground composition pattern built from bindings, controls and transitions.

---

## 11. Cross-case conclusions

### 11.1 Multi-ground composition is irreducible

Hard cases repeatedly require 3–4 ground anchors. Pairwise decomposition alone would hide semantics in edge attributes or silently localize composite standings.

### 11.2 The provisional four-region frame survives all required hard cases

```text
Relational Binding
Derived Standing / Qualification
Control / Constraint
Transition / Effect / Feedback
```

Every required case can be analyzed through a combination of these four regions without a residual fifth composition kind.

### 11.3 Regions are complementary, not exclusive event buckets

The same real episode can simultaneously instantiate:
- bindings;
- a derived standing;
- a control condition;
- a transition/effect.

This overlap is not by itself a taxonomy failure because the regions answer different protected questions.

### 11.4 Evidence/provenance/causation remain cross-cutting

They are too important to omit, but C3 does not show that they require peer child status.

## 12. C3 judgment

The strongest current hypothesis entering C4 is that the parent composition problem may have four stable immediate research regions:

```text
Cross-Ground Composition
├─ Relational Binding
├─ Derived Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

C4 must now attack this against serious rival organizing frames rather than confirm it.