# Control / Constraint — K7 Adversarial Closure

**Status:** COMPLETE / BOUNDED CHILD CLOSURE  
**Date:** 2026-09-05  
**Verification class:** same-model adversarial review; NOT independent replication

## 1. Target under attack

Provisional K6 result:

```text
Control / Constraint
    ← BOUNDED LEAF
    ← one cross-ground governing-control semantic core
    ← no immediate child promoted
    ← optional/non-collapsed layers
    ← overlapping profiles/dimensions
```

Protected claim:

> A Control / Constraint composition concerns the governing semantics that apply to an exact candidate action, transition, flow, choice or continuation under an applicable governing basis/objective, including authority, decision, enforcement, coverage and monitoring only where they are semantically material.

The result fails if this protected question collapses into accepted ground/sibling semantics, becomes a residual `miscellaneous governance` bucket, or requires stable immediate children that K6 wrongly suppressed.

---

## 2. Attack A — Control is just Actors authority/permission/obligation

### Attack

The most obviously normative control semantics already live under Actors. A separate Control region duplicates them.

### Test

Actors can answer:
- who holds authority;
- who is permitted/obligated;
- delegation/representation scope;
- responsibility/accountability positions.

But identical Actor standings can coexist with different controls over an action:
- same Actor may be authorized for operation O1 but not O2;
- same authority bearer may issue a rule that is out of scope for target T;
- same authorization may be enforced in one Environment and unenforced in another;
- physical interlock control can exist without a per-cycle Actor authority question.

Control adds the governing relation among:
- exact action/transition/effect;
- applicable basis/objective;
- modality;
- scope/currentness;
- optional decision/enforcement/coverage.

### Result

**Attack rejected.**

Actor standing remains a load-bearing input, not a replacement.

---

## 3. Attack B — Control is just Composite Standing

### Attack

`authorized`, `blocked`, `gate satisfied`, `compliant` can all be modeled as standings. No separate Control problem is needed.

### Test

Consider two systems with the same current standing:

```text
request = DENIED
```

System A:
- valid applicable rule;
- legitimate decision authority;
- deny-overrides semantics;
- enforcement point blocks all relevant paths.

System B:
- stale/misapplied rule;
- wrong decision authority;
- one local path blocked while alternate path remains open.

The same local `denied` status does not encode the same governing semantics or control adequacy.

Standing answers what qualification/result holds. Control answers what governs and how that result/constraint relates to actual behavior.

### Result

**Attack rejected.**

---

## 4. Attack C — Control is just Environment enforcement/constraint

### Attack

A real control only matters when something physically/technically constrains behavior. Therefore Control reduces to realized Environment condition.

### Test

Counterexamples:

```text
policy legitimately prohibits X
runtime is misconfigured and still allows X
```

The governing control exists while enforcement fails.

Conversely:

```text
runtime cannot reach X
```

may reflect accidental outage, missing dependency or arbitrary physical limitation with no governing objective.

Also advisory/procedural institutional controls can be real controls without deterministic mechanical enforcement.

### Result

**Attack rejected.**

Environment owns realized mechanism/path condition; Control owns its governing meaning and relation to the protected action/effect.

---

## 5. Attack D — Control is just Work gates/reviews/approvals

### Attack

Approval, review and gate behavior are simply Work states/processes.

### Test

```text
review Work completed
!= criterion satisfied
!= valid approving authority
!= governing go/no-go decision
!= progression enforcement
```

A review can occur and produce evidence without granting permission. An approval activity can be performed by an unauthorized Actor. A gate decision can be valid even if a mechanical enforcement bug later allows contrary progression.

### Result

**Attack rejected.**

---

## 6. Attack E — Control is just Information policy/configuration

### Attack

Rules, policies, permissions and configurations are information; control is just applying them.

### Test

Strong counterexamples:

```text
instruction says do not use tool X
!= runtime blocks tool X
```

and:

```text
configuration says deny network path
!= indirect shell/service/agent path cannot reach effect
```

Policy/configuration can be stale, forged, out-of-scope, overridden, unenforced or bypassed.

### Result

**Attack rejected.**

---

## 7. Attack F — the region is incoherent because authority, decision and enforcement are not universal

### Attack

If no single layer besides the abstract word `governing` is mandatory, Control may be an empty umbrella.

### Test

Across access control, project governance, machine safety, quantitative limits and agentic permissions, one failure question recurs:

> **What candidate behavior/effect is being governed, relative to what basis/objective and applicability frame, with what governing mode?**

Removing this question causes recurring failures:
- arbitrary Environment limitation misclassified as prohibition;
- policy text misclassified as effective control;
- approval Work misclassified as permission;
- local path denial misclassified as end-to-end protection;
- obligation misclassified as capability;
- one standing label detached from governing scope.

Optional layers vary because control regimes realize the common governing semantics differently.

### Result

**Attack rejected.**

The protected governing question is coherent enough to define the region even though authority/decision/enforcement are conditional layers.

---

## 8. Attack G — Basis / Decision / Enforcement / Monitoring must be children

### Attack

The distinction is so important that failing to promote these as children loses structure.

### Test

Child promotion fails because:
- a fixed interlock has no separate per-event decision service;
- an institutional rule may have no hard enforcement;
- monitoring is optional and often external observation;
- one regime spans all layers;
- local semantics of each layer route strongly into Information, Actors, Work, Environment or Standing;
- `Monitoring` does not itself govern behavior unless monitoring is required/interventional.

The distinction is necessary as a semantic checklist, not as disjoint populations.

### Result

**Attack rejected. No child promoted.**

---

## 9. Attack H — Preventive / Detective / Corrective should be children

### Attack

This is a mature cross-domain control taxonomy.

### Test

The categories are relative to an event/effect chain:
- shutdown can be preventive relative to catastrophic failure and mitigating relative to an already-present fault;
- one sensor/controller can detect and prevent;
- correction/remediation often becomes Work + Transition after violation;
- normative governance controls do not necessarily fit hazard-chain placement.

### Result

**Attack rejected as universal Foundation hierarchy.**

Retain as Transition-sensitive profile.

---

## 10. Attack I — Permission / Prohibition / Obligation should be children

### Attack

Deontic categories have distinct formal semantics.

### Test

They remain distinct but do not cover:
- quantitative limits;
- isolation;
- concurrence;
- gate conditions;
- revocation;
- escalation;
- physical interlocks/invariants.

Moreover current deontic results frequently belong to Actor/Composite Standing.

### Result

**Attack rejected as child hierarchy.**

---

## 11. Attack J — alternate-path closure is architecture detail only

### Attack

Foundation should state `deny` and leave network/tool/service topology to implementation.

### Test

If the protected control claim is:

> Actor A cannot cause effect E without approval,

then these worlds differ semantically:

```text
World 1:
A → privileged tool blocked
no other material route to E

World 2:
A → privileged tool blocked
A → Actor B → privileged tool → E remains reachable
```

Calling both `control satisfied` loses the protected governing claim itself, not merely implementation detail.

The exact path enumeration method is architecture-specific; the **need to distinguish local enforcement scope from governed-effect scope** is not.

### Result

**Attack rejected.**

---

## 12. Attack K — Control Coverage / Effective Power deserves its own child or fifth composition region

### Attack

End-to-end effect closure seems qualitatively different from ordinary policy/gate semantics.

### Test

Coverage asks:

> Does this control govern the protected effect across the relevant reachable routes?

It depends on:
- Binding topology/delegation;
- Actors/Environment/Work capability/path facts;
- Standing for reachability/actionability/coverage;
- Control for governed objective and enforcement scope;
- Transition for actual effect realization.

No independent semantic kind remains once these are separated.

### Result

**Attack rejected. Coverage remains a high-value Control profile.**

---

## 13. Attack L — non-normative physical controls make the label too broad

### Attack

Machine guards and institutional policies are too different to share one region.

### Test

Both instantiate:
- exact governed behavior/effect;
- governing basis/objective/invariant;
- modality/constraint on behavior;
- applicability conditions;
- optional enforcement realization.

They differ in authority, decision and representation mechanisms—not in the protected governing question.

A physical wall with no protected control relation remains mere Environment condition; a guard/interlock intentionally tied to unsafe transition prevention is a control case.

### Result

**Attack rejected.**

---

## 14. Attack M — Monitoring / Compliance deserves a child

### Attack

Control is incomplete without assurance that it operates and behavior complies.

### Test

Monitoring can be:
- absent while behavior complies;
- present while behavior violates elsewhere;
- correct for one enforcement point while bypass occurs elsewhere.

Compliance/effectiveness are derived evaluations over:
- applicable control;
- actual behavior/effect;
- evidence/monitoring;
- sometimes causal contribution.

Thus monitoring/assurance is important but not the same first-order governing question.

### Result

**Attack rejected as child.**

Residual control-assurance questions are preserved for Standing + Transition composition later.

---

## 15. Attack N — precedence/default/combining semantics are policy-engine leakage

### Attack

Deny-overrides, permit-overrides and indeterminate cases are XACML-specific implementation details.

### Test

The project does not require those algorithms. The general failure survives without XACML:
- two applicable rules conflict;
- an exception competes with a general prohibition;
- no rule applies;
- required facts are unavailable;
- a regime chooses conservative, permissive or escalatory default.

If those semantics change the governing decision, omitting them changes the control meaning.

### Result

**Attack rejected at semantic level; implementation algorithm remains unconstrained.**

---

## 16. Attack O — currentness/revocation belongs entirely to Transition

### Attack

Control should be timeless; policy changes and revocation propagation are Transition concerns.

### Test

A present-tense claim such as:

```text
operation O is currently prohibited
session S is currently revoked
waiver W currently applies
```

requires effective time/version/current applicability.

Control therefore owns **current validity/applicability dependencies**.

Transition owns:
- event/change sequence;
- propagation delay/history;
- how enforcement points learned the change;
- causal effects of the change.

### Result

**Attack rejected with boundary preserved.**

---

## 17. Attack P — bounded leaf reflects insufficient depth

### Attack

No children may simply mean research stopped too soon.

### Test

K0–K5 explicitly tested:
- ground/sibling collapses;
- authority-first and enforcement-first definitions;
- policy/decision/enforcement/monitoring layers;
- deontic modes;
- gates/waivers/delegation;
- separation of duties / dual authorization;
- fail-open/fail-closed/default semantics;
- revocation/currentness;
- alternate path / transitive effect power;
- preventive/detective/mitigating taxonomies;
- advisory/procedural/mechanical realization;
- access-control and state-machine reductions;
- control-loop reduction;
- fifth-ground/fifth-region hypotheses;
- authoritative holdouts from cybersecurity, NASA governance, machine safety, aviation safety and agentic SDLC.

Late pressure produced more profiles/mechanisms, not a stable new protected question.

### Result

**Attack rejected. Bounded-leaf closure is evidence-based at current depth.**

---

## 18. Attack Q — `Control / Constraint` is too broad a label

### Attack

`Control` can mean feedback control, management control, access control or organizational authority; `Constraint` can mean any limitation. The label invites misrouting.

### Test

The ambiguity is real.

The stable canonical gloss must therefore be explicit:

> **Cross-ground governing semantics over candidate behavior/transitions under an applicable basis/objective; arbitrary limitation alone is not sufficient.**

Potential future label:
- `Governing Control / Constraint`;
- `Behavioral Governance / Constraint`.

But changing labels now could create continuity churn without structural gain.

### Result

**Attack partially succeeds as naming/documentation risk, not structural falsifier.**

Retain label with explicit gloss and reopen/rename if later work repeatedly confuses arbitrary Environment constraints or feedback dynamics with this region.

---

## 19. Attack R — Norms / Governance is actually a fifth Foundation ground

### Attack

The breadth of policies, requirements, authority and waivers suggests `Norms/Governance` has independent ontological status.

### Test

Every hard case still requires decomposition across:
- Information — represented rules/decisions/evidence;
- Actors — authority/obligation/delegation;
- Work — governed/approval/review action;
- Environment — mechanism/path/condition;
- Binding — exact applicability;
- Standing — current qualification/result;
- Control — governing composition.

No stable independent state/bearer/process locus remains for a fifth ground.

### Result

**Attack rejected. No adequacy reopen.**

---

## 20. Attack S — Control should merge with Transition / Effect / Feedback

### Attack

Controls only matter by shaping transitions; perhaps Control and Transition are one dynamics region.

### Test

Two systems can have the same current governing rule/control while no transition occurs. Conversely, identical transitions can occur under:
- permitted control;
- prohibited-but-unenforced control;
- no applicable control;
- accidental Environment constraint release.

Control asks what governs what may/should/can proceed under the regime.

Transition asks what actually changed, propagated or effected over time and with what causal/feedback semantics.

### Result

**Attack rejected. Sibling boundary survives.**

---

## 21. Attack T — Control cannot be evaluated without causation, so K7 is premature

### Attack

`control effective` means the control caused a desired prevention/mitigation. Without causal analysis, Control is incomplete.

### Test

Distinguish:

```text
control semantics / applicability / enforcement coverage
```

from:

```text
control effectiveness in producing/preventing an outcome
```

The latter can require causal/counterfactual reasoning and belongs partly to Standing + deferred Transition/Effect.

The Control region can be bounded without solving causal effectiveness, provided it does not claim that enforcement implies outcome causation.

### Result

**Attack rejected as closure blocker.**

Causal effectiveness is preserved as a deferred cross-child question.

---

## 22. Final adversarial judgment

### Child coherence

**SURVIVES.**

### Immediate-child split

**NO stable child survives.**

### Upstream reopen

**NO.**

### Final bounded result

```text
Control / Constraint
    ← BOUNDED LEAF
    ← cross-ground governing semantics
    ← no immediate child promoted
    ← one reusable semantic core
    ← optional/non-collapsed authority/decision/enforcement/coverage/monitoring layers
    ← overlapping profiles/dimensions
```

---

## 23. Final semantic core

```text
Control / Constraint core
├─ protected governing question
├─ exact governed focus / protected effect
├─ governing basis / objective / invariant
├─ governing mode / effect
├─ applicability frame
│  ├─ exact bindings / scope / context
│  └─ effective time / version / state where material
├─ precedence / conflict / exception / default semantics where material
└─ current validity dependencies
```

Associated when material:

```text
authority / legitimacy

evaluation / decision / gate

enforcement / intervention

coverage / alternate-path / bypass

monitoring / observation

compliance / effectiveness assessment [primarily Standing/evidence-facing]
```

---

## 24. Strongest non-collapse rules

```text
arbitrary limitation
!= Control automatically

policy text
!= legitimate/current/applicable governing basis
!= authority
!= decision
!= enforcement
!= compliance

Actor authority
!= technical capability
!= effective effect power

review Work
!= gate result
!= authorized progression

decision
!= enforcement

enforcement-point success
!= end-to-end control-objective success

governed-effect scope
!= enforcement-point scope

direct path blocked
!= protected effect controlled

monitoring evidence
!= actual behavior by identity

actual compliance
!= control effectiveness

obligation
!= actionability

waiver record
!= valid/applicable waiver

control currentness
!= transition/change history
```

---

## 25. Verification boundary

K7 is **same-model adversarial review**, not independent replication.

Authoritative/candidate pressure includes:
- NIST SP 800-162 ABAC;
- NIST SP 800-207 Zero Trust Architecture;
- NIST SP 800-53 Rev. 5.1;
- OASIS XACML 3.0;
- NASA Technical Authority and systems-engineering decision-gate material;
- OSHA machine guarding/interlock material;
- FAA Safety Risk Management guidance;
- Anthropic AI-native SDLC/security material;
- project multi-agent and context/harness studies.

No source publishes or validates this exact project synthesis. User acceptance may close sequencing but does not change verification independence.

---

## 26. Sequencing re-evaluation

After K7, `Transition / Effect / Feedback` is the strongest next composition child if Control is user-accepted.

Reason is substantive, not merely list order:
- Binding now gives exact anchors/relations;
- Standing gives current multi-ground qualifications;
- Control gives current governing/constraint semantics;
- unresolved questions now concentrate on actual change, propagation, effect, causation and feedback over time.

Examples:
- policy revocation → decision/enforcement propagation;
- Work action → intended versus realized Environment effect;
- bypass → actual prohibited effect;
- observation → diagnosis Work → Actor decision → changed control → new behavior;
- control failure → incident → correction → persistent learned change;
- sequence versus causal contribution.

Do **not** activate Transition automatically.

---

## 27. Closure recommendation

Return Control / Constraint for user evaluation as a bounded leaf.

If accepted, separately activate `Transition / Effect / Feedback` only on user authorization.

Do not proceed to architecture, ontology/data-model/schema design or implementation.