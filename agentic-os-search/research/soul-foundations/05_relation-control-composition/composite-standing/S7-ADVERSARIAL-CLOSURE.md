# Composite Standing / Qualification — S7 Adversarial Closure

**Status:** COMPLETE / BOUNDED CHILD CLOSURE  
**Date:** 2026-09-05  
**Verification class:** same-model adversarial review; NOT independent replication

## 1. Target under attack

Provisional S6 result:

```text
Composite Standing / Qualification
    ← BOUNDED LEAF
    ← cross-ground qualification only
    ← no immediate child promoted
    ← shared semantic grammar + overlapping profiles
```

Protected claim:

> A Composite Standing is a qualification whose constitutive or defining semantics irreducibly depend on multiple accepted Foundation grounds or their exact bindings; cross-ground evidence/access alone is insufficient to route a standing here.

---

## 2. Attack A — this duplicates Environment `Criterion-Relative Standing`

### Attack

Environment already has a fully researched standing leaf. The new child may simply repeat it at another level.

### Test

Environment asks:

> What true current standing obtains for a Domain bearer under the applicable criterion/regime?

Composite Standing asks a stricter cross-ground question:

> What qualification is defined by the joint semantics of multiple grounds/bindings such that projection to one ground loses prerequisites?

Counterexamples:

```text
Domain object conforms to threshold C
→ can remain Environment Criterion-Relative Standing
```

versus:

```text
Actor capability
+ Environment access
+ Work action/path
→ actionable for this Work now?
```

or:

```text
exact target/version
+ requirement
+ verification Work/evidence
→ verified against that requirement?
```

The distinction survives only if cross-ground **constitution/definition** is required, not merely cross-ground evidence.

### Result

**Attack rejected with boundary condition.**

If future work routes a ground-local standing here merely because its evidence is cross-ground, the child should be reopened.

---

## 3. Attack B — cross-ground constitution versus evidence is too subjective

### Attack

How can one know whether another ground is constitutive rather than merely evidential? The boundary may be arbitrary.

### Test

Use counterfactual semantic removal:

> If the other-ground anchor were removed from the standing's definition while preserving all knowledge/access to the ground-local bearer, would the meaning of the standing change?

Examples:

### Pure conformity

If a physical item either satisfies a specification or does not, removing the measurement Work/evidence does not change what `conforming` means; it changes only our ability to know it.

### Verification

Removing the exact requirement/target and verification relation changes what `verified against C` means. Those anchors are definitional.

### Actionability

Removing the Work action/path changes the question; `Actor capable` is not equivalent to `Actor actionable for W now`.

### Result

The distinction is not perfectly mechanical, but the counterfactual semantic-removal test is usable and materially better than vocabulary routing.

**Attack rejected.**

---

## 4. Attack C — standing is just an n-ary Binding predicate

### Attack

Write:

```text
Verified(Target, Criterion, Evidence, Verifier, Time)
```

and Binding already covers it.

### Test

That syntax still hides:
- criterion-evaluation logic;
- result domain;
- false vs unknown/indeterminate;
- uncertainty/coverage;
- decision-rule semantics;
- currentness/validity dependencies;
- distinction between object standing and assessment/decision.

Binding gives the exact anchors and roles; it does not tell us what qualification follows.

### Result

**Attack rejected.**

---

## 5. Attack D — all useful standings can be localized as attributes/status fields

### Attack

Operationally, one can store `verified=true`, `ready=true`, `authorized=true`; a separate region is unnecessary.

### Test

The same status label may be true under one target/version/use/context and false under another.

Localization loses prerequisites:

```text
verified(Target v7, Requirement set R1)
```

cannot safely become:

```text
Target.verified = true
```

if v8/R2 later becomes current.

Likewise `Actor.authorized=true` loses object/operation/environment/policy scope.

### Result

Storage convenience does not establish semantic locality.

**Attack rejected.**

---

## 6. Attack E — three semantic layers should be immediate children

Candidate:

```text
Constitutive Standing
Epistemic Assessment
Decision / Recognition
```

### Test

JCGM strongly proves the layers are distinct, but hierarchy still fails:
- many standings have no explicit evaluation/recognition episode;
- assessment can be Information/Work access rather than another standing kind;
- an authorized decision can be constitutive in institutional cases;
- one episode can contain all layers;
- Decision/Recognition quickly overlaps Control.

### Result

The distinction is mandatory, but the child split remains false-disjoint.

**Attack rejected.**

---

## 7. Attack F — `false / unknown / not evaluated / not applicable / stale` is over-modeling

### Attack

A simple boolean plus missing value is enough; the extra distinctions belong to implementation.

### Test

These states drive different decisions:
- false may justify remediation/rejection;
- unknown may justify evidence acquisition/escalation;
- not evaluated may schedule required Work;
- not applicable should suppress the criterion entirely;
- stale means prior evidence/result cannot justify a current claim without proving the standing false.

Collapsing them creates distinct failure modes:
- treating absence of evidence as negative evidence;
- treating wrong-scope criteria as failed criteria;
- treating stale assessment as known false.

### Result

Exact labels are implementation-specific, but semantic distinction is Foundation-level where decision-critical.

**Attack rejected.**

---

## 8. Attack G — uncertainty/result domains are only data-model concerns

### Attack

Boolean Foundation semantics can be used; probability/ordinal/score handling can be left to implementation.

### Test

External counterexamples:
- JCGM conformity probability and decision risk;
- NASA nine-level TRL maturity;
- NIST AI RMF context-specific metrics and uncertainty.

A boolean-only model would erase actual decision semantics.

### Result

Foundation need not prescribe representation, but must preserve non-boolean possibility.

**Attack rejected.**

---

## 9. Attack H — invalidation/currentness belongs wholly to Transition

### Attack

Standing should be timeless; all change/currentness belongs to Transition.

### Test

A present claim such as `verified`, `actionable`, `authorized`, or `evidence sufficient` is incomplete if its reference target/time/context is omitted when those can change the answer.

Standing must therefore preserve:
- reference/effective time when material;
- validity dependencies;
- whether the prior assessment remains applicable/current.

Transition owns:
- which change occurred;
- causal/trigger sequence;
- propagation/recomputation mechanics.

### Result

**Attack rejected.**

---

## 10. Attack I — authorization/eligibility belongs entirely to Control

### Attack

Anything about permission is access control, not standing.

### Test

Separate questions:

```text
Does this exact request satisfy current authorization criteria?
→ current evaluated authorization standing
```

```text
What policy/authority/rule governs it?
What is permitted/required/blocked?
How is the decision enforced or bypass prevented?
→ Control
```

NIST ABAC makes both questions material.

### Result

Standing/Control boundary survives, with high interaction.

**Attack rejected.**

---

## 11. Attack J — verification/validation belongs entirely to Work

### Attack

Verification and validation are activities; therefore Work owns them.

### Test

Work indeed owns the verification/validation activity.

But:

```text
verification Work occurred
!= target is verified against requirement C
```

and:

```text
validation Work occurred
!= target is validated for intended use U in Environment E
```

The resulting qualification depends on target/criterion/evidence/use anchors.

### Result

**Attack rejected.** Work activity and composite standing remain distinct.

---

## 12. Attack K — evidence sufficiency belongs entirely to Information

### Attack

Evidence quality/sufficiency is an epistemic Information property.

### Test

Information may have local provenance/reliability/currentness standing, but:

```text
Evidence Set E sufficient for Claim C / Decision D / Work use U
```

is target/use-relative. Change C/D/U while holding E constant and the result can change.

### Result

Use-relative sufficiency remains a legitimate Composite Standing profile.

**Attack rejected.**

---

## 13. Attack L — family profiles should be children after all

Candidates:
- readiness/actionability;
- assurance/V&V/acceptance;
- epistemic sufficiency;
- authorization/eligibility;
- outcome attainment.

### Test

Cross-domain holdouts show vocabulary is not a stable routing rule:
- NASA TRL `readiness` can be ground-local Environment standing;
- pure conformance can be ground-local while verification is composite;
- `acceptance` can be institutional recognition/control-adjacent;
- `deployable` combines readiness, validation, risk tolerance and authorization.

### Result

Profiles remain overlapping and boundary-sensitive.

**No child promoted.**

---

## 14. Attack M — bounded leaf is only conservatism / insufficient depth

### Attack

Failure to promote children may reflect under-research rather than real overlap.

### Test

S0–S5 explicitly tested:
- six major standing families;
- layer splits;
- descriptive/normative splits;
- feasibility/assurance/legitimacy/suitability splits;
- criterion-source splits;
- result-domain splits;
- collapse into Binding, Environment, Control and Transition;
- external traditions from NASA, JCGM/BIPM, NIST ABAC, NASA TRL and NIST AI RMF;
- current candidate-study holdouts.

Late search produced more profile examples and evaluation dimensions, not a stable new first-order protected question.

### Result

Bounded-leaf closure is evidence-based at current Foundation depth.

**Attack rejected.**

---

## 15. Attack N — label `Composite Standing / Qualification` is too confusing

### Attack

Because Environment already has `Criterion-Relative Standing`, users/agents may misroute every standing into this child.

### Test

The word `Composite` plus a canonical cross-ground gloss can preserve the distinction, but the risk is real.

Possible alternative:

> `Cross-Ground Qualification / Composite Standing`

### Result

**Attack partially succeeds as a documentation/naming risk, not a structural falsifier.**

Current recommendation:
- retain accepted child label for continuity;
- always define it as **cross-ground composite qualification**;
- reopen/rename if later work repeatedly misroutes ground-local standing here.

---

## 16. Attack O — this implies a rule engine / status object architecture

### Attack

Criteria, results, uncertainty and invalidation look like a decision engine or materialized status model.

### Test

The research requires no representation mechanism.

A standing may later be:
- computed on demand;
- asserted by authority;
- inferred;
- explicitly persisted;
- represented as a relation/object/property;
- evaluated procedurally by humans;
- partly constituted institutionally.

### Result

No architecture/ontology commitment is necessary.

**Attack rejected.**

---

## 17. Attack P — a fifth Foundation ground or composition region reappears

### Attack

Norms/criteria/evaluation may require a new Ground or a fifth composition child.

### Test

All load-bearing examples remain expressible using:
- accepted ground-local semantics;
- Relational Binding;
- Composite Standing;
- deferred Control;
- deferred Transition.

No stable independent locus remains after removing cross-ground composition.

### Result

**No upstream adequacy/parent reopen.**

---

## 18. Attack Q — Control is not necessarily next

### Attack

Perhaps Transition should be researched before Control because currentness/invalidation is now prominent.

### Test

Standing closure leaves two large frontiers:
- how standings change/propagate → Transition;
- what rules/authority/decisions/enforcement consume/constitute standings → Control.

Dependency/value comparison:
- Standing already provides current validity dependency semantics sufficient to defer change mechanics;
- many unresolved authorization/acceptance/actionability cases cannot be cleanly analyzed further without policy/authority/gate/enforcement distinctions;
- Control can use accepted Binding + Standing outputs directly;
- Transition will later benefit from knowing what controlled transition semantics exist.

### Result

**Control / Constraint remains the strongest current next-child candidate**, but this is sequencing, not structural necessity. Re-select again after Control closure.

---

## 19. Final adversarial judgment

### Child coherence

**SURVIVES.**

### Immediate-child split

**NO stable child survives.**

### Final bounded result

```text
Composite Standing / Qualification
    ← BOUNDED LEAF
    ← cross-ground qualification only
    ← no immediate child promoted
    ← shared semantic core
    ← optional epistemic/decision layers kept distinct
    ← overlapping standing profiles
```

### Canonical routing rule

> A standing belongs here only when multiple accepted-ground semantics are part of what the qualification **means or what constitutes it**. Cross-ground evidence, reporting or assessment access alone does not make a ground-local standing Composite.

## 20. Final semantic core

```text
Composite Standing core
├─ standing meaning / protected question
├─ exact qualified focus + Binding instances
├─ qualification frame
│  ├─ criterion / requirement / threshold / norm / intended use
│  ├─ scope / operation / population / jurisdiction / reference frame
│  └─ time/version/state where material
├─ constitutive cross-ground basis
├─ object-level result semantics
└─ validity dependencies/currentness
```

Associated but non-collapsed layers:

```text
epistemic assessment
├─ evidence / measurement / observation
├─ method/model/decision rule
├─ evaluator/verifier/adjudicator
└─ uncertainty/confidence/coverage

recognition / decision [when present]
├─ authorized Actor/forum/regime
└─ accept/reject/approve/certify/recognize outcome
```

## 21. Strongest non-collapse rules

```text
ground-local standing
!= cross-ground Composite Standing

cross-ground evidence/access
!= proof standing is composite

standing holds
!= assessment supports it
!= decision recognizes it
!= record says it holds

criterion
!= decision rule

false
!= unknown
!= not evaluated
!= not applicable
!= stale

verified
!= validated
!= accepted

capable
!= actionable
!= authorized
!= technically reachable

standing currentness
!= transition/history
```

## 22. Verification boundary

S7 is **same-model adversarial review**.

External sources used as falsifiers include:
- NASA Product Verification / Product Validation;
- BIPM/JCGM 106 conformity assessment and VIM;
- NIST SP 800-162 ABAC;
- NASA Technology Readiness Levels;
- NIST AI RMF / AI measurement material;
- selected project candidate studies.

No external source publishes or validates this exact bounded-leaf synthesis. No independent second-researcher/model replication has been performed.

User acceptance may close sequencing but does not change verification independence.

## 23. Closure recommendation

Return Composite Standing / Qualification for user evaluation.

If accepted:
- activate **Control / Constraint** as the strongest current next child only after a separate transition/authorization;
- do not auto-activate Transition/Effect/Feedback;
- re-select remaining child order after Control closure.

Do not proceed to architecture, ontology/data model, schema design or implementation.