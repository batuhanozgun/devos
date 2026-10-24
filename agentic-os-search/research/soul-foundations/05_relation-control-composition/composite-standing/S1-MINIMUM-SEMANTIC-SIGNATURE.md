# Composite Standing / Qualification — S1 Minimum Semantic Signature

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Question under test

Is a composite standing adequately specified by something like:

```text
subject + status
```

or even:

```text
subject + criterion + status
```

Current answer: **no** for decision-critical cross-ground standings.

## 2. First boundary — ground-local versus cross-ground

S0 exposed an accepted Environment leaf that already handles criterion-relative current standing of a Domain Condition bearer.

Therefore the standing child must preserve:

```text
ground-local criterion-relative standing
!=
cross-ground composite standing
```

### Ground-local

If the protected truth question belongs to one accepted ground and other-ground representations merely provide access/evidence, do not move it here.

Example:

```text
actual memory condition
+ applicable pressure threshold
→ MemoryPressure Environment standing
```

The fact that the threshold is documented in Information does not by itself make this a cross-ground composition.

### Cross-ground

Use Composite Standing when the **truth/evaluation semantics themselves** require several ground-local facts/bindings.

Example:

```text
Actor capability
+ Environment access
+ specific Work action/path
→ actionable-now?
```

No one input can own the result without hiding prerequisites.

## 3. Two semantic layers must remain distinguishable

The strongest S1 correction is:

```text
standing constitution / truth conditions
!=
standing evaluation / epistemic access
```

### 3.1 Constitutive / truth basis

What makes the standing hold in the relevant frame?

Possible ingredients:
- accepted-ground facts/states;
- exact Relational Binding instances;
- criteria/requirements/thresholds/intended use;
- constitutive rules/regimes;
- authorized acts where a domain standing is institutionally constituted by such acts;
- reference conditions/time.

### 3.2 Evaluation / access basis

How is the standing known, estimated, assessed, certified, scored or decided?

Possible ingredients:
- observations/measurements;
- evidence set;
- test/verification Work;
- model or inference method;
- decision rule;
- assessor/verifier/adjudicator;
- confidence/uncertainty;
- certificate/report/verdict.

These can disagree with the constitutive standing.

JCGM conformity assessment is a decisive counterexample: an item truly conforms or not, while a decision based on uncertain measurement can falsely accept or falsely reject it.

## 4. Institutional/constitutive complication

The `truth basis != evaluation basis` distinction is not the claim that every standing is metaphysically independent of Actors/rules.

Some institutional standings are **constituted** by valid authoritative acts/regimes.

Examples may include:
- license suspended/revoked;
- authorized/unauthorized under a valid delegation regime;
- formally accepted where authorized acceptance itself changes institutional standing.

In such cases:

```text
authorized constitutive act
can be part of what makes the standing hold
```

while:

```text
record/certificate saying the act occurred
!= the act/standing by identity
```

Therefore `actual` means the standing that obtains under the domain's constitutive semantics, not `purely physical independent reality`.

## 5. Strongest current composite-standing signature

The current reusable semantic signature is:

```text
Composite Standing instance
├─ standing meaning / protected qualification question
├─ qualified focus
│  ├─ exact subject/target/claim/action/Work/Actor/condition
│  └─ exact Binding instances needed to identify the focus
├─ qualification frame
│  ├─ criterion / requirement / threshold / norm / intended use
│  ├─ scope / operation / population / jurisdiction / reference frame
│  └─ effective/reference time and target/version where material
├─ constitutive basis
│  └─ cross-ground facts/bindings/rules/acts needed for the standing to hold
├─ result semantics
│  ├─ result domain / category / degree where material
│  └─ applicability / unknown / indeterminate semantics where material
├─ evaluation/access basis [conditional]
│  ├─ evidence / measurement / observations
│  ├─ method / model / decision rule
│  ├─ evaluator/verifier/adjudicator and authority/independence where material
│  └─ uncertainty / confidence / coverage
└─ validity dependencies
   └─ changes that would make the prior result stale, inapplicable or require re-evaluation
```

This is a research grammar, not a schema.

## 6. Universal core versus conditional dimensions

### 6.1 Strong universal core

Across current hard cases, these are load-bearing:

1. **standing meaning / exact question**
2. **qualified focus / exact target**
3. **qualification frame**
4. **constitutive basis**
5. **result semantics**

Without these, a label such as `ready`, `verified`, `authorized`, `sufficient` or `accepted` is under-specified.

### 6.2 Conditional but frequently load-bearing

- evidence;
- evaluator;
- method/procedure/model;
- uncertainty/confidence;
- authorized forum;
- intended-use Environment;
- independence requirements;
- explicit decision threshold.

Do not require these universally merely because assurance-heavy domains need them.

### 6.3 Time/currentness

Time is not a mandatory timestamp field on every standing.

It becomes standing-semantic when changing the reference/effective time can change whether the standing holds.

Examples:
- access is actionable now but not after credential expiry;
- evidence verified version v7 but v8 is now target;
- source is current enough for a decision at t1 but stale at t2;
- readiness depends on present Environment conditions.

The transition history of how this changed remains outside Standing.

## 7. Result semantics are not universally boolean

Current evidence rejects a universal boolean result model.

Potential standing result domains include:
- binary;
- categorical;
- ordinal;
- graded/severity;
- scalar/score plus threshold;
- probability/distribution-derived conformance;
- interval/bounds;
- partially satisfied/coverage-based;
- `unknown` / `indeterminate`;
- `not evaluated`;
- `not applicable`.

The *specific representation* is domain-specific, but the Foundation must not erase distinctions that change decisions.

## 8. Why `unknown`, `not evaluated`, `not applicable` matter

These states answer different semantic questions:

```text
false
= evidence/basis supports that the standing does not hold

unknown / indeterminate
= currently available basis does not justify true or false

not evaluated
= required evaluation has not been performed or completed

not applicable
= qualification frame/criterion does not apply to this focus
```

These distinctions may collapse in some domains, but Foundation research cannot assume they are interchangeable.

## 9. Standing versus assertion/record

Required separation:

```text
standing holds
!= evaluator concluded it holds
!= authorized body recognized it
!= Information record says it holds
```

Sometimes recognition is constitutive; sometimes it is merely evidential. The domain's standing semantics decide which.

Therefore one generic `status=approved` field cannot safely carry all four meanings.

## 10. Standing versus Binding

Binding answers:

> Which exact anchors are connected and in what semantic positions?

Standing answers:

> Given the relevant bindings/facts and qualification frame, what qualification obtains?

Correct bindings are necessary inputs in many cases but not sufficient.

Example:

```text
Evidence E is about Target T
Criterion C applies to T
Verifier V performed Work W
```

still does not establish:

```text
T is verified against C
```

without the evaluation/result semantics.

## 11. Standing versus Control

A standing may be an input to Control, but does not itself answer what transition is permitted/required/blocked.

```text
Actor is authorized-for-operation O   ← standing question when evaluating current authority applicability
policy requires authorization         ← control/normative rule
runtime blocks unauthorized request   ← enforcement/control
```

This boundary is fragile and must be attacked later.

## 12. Standing versus Transition

Standing asks what holds at the relevant reference point.

Transition asks:
- what changed;
- what event caused/triggered it;
- how the standing was invalidated/recomputed;
- what downstream changes propagated.

A standing must preserve its validity dependencies/currentness, but not own the change history.

## 13. Falsifier results after S1

### F1 — Environment duplication
**Partially rejected.** The parent label was too broad if interpreted universally; the corrected cross-ground boundary survives.

### F2 — Binding-predicate collapse
**Rejected provisionally.** Binding identifies anchors; qualification requires criterion/frame/result semantics and may require evaluation logic.

### F3 — ground-localization
**Rejected for hard cases.** Actionability, verification/validation/acceptance and evidence sufficiency lose prerequisites if projected to one ground.

### F4 — Control theft
**Still live.** Authorization/eligibility/compliance require careful standing-vs-control separation.

### F5 — Transition theft
**Rejected provisionally.** Reference-time validity is standing-semantic; change propagation/history remains Transition.

### F6 — result-domain triviality
**Rejected provisionally.** JCGM uncertainty and NASA readiness already show non-boolean decision-relevant structure.

### F7 — true-vs-evaluated collapse
**Rejected.** Existing Environment/JCGM evidence strongly separates underlying standing from assessment/decision; institutional constitution requires a more nuanced version rather than collapse.

### F8 — family split
**Still live.** S2 must test.

### F9 — missing Binding distinction
**No missing distinction yet.** Exact target/frame/instance grammar is sufficient so far.

### F10 — upstream adequacy failure
**No evidence.**

## 14. S1 judgment

A coherent Composite Standing object survives, but only after a boundary correction:

> **Composite Standing / Qualification is the cross-ground problem of establishing what multi-anchor qualification obtains under an explicit frame, not a universal standing bucket.**

Proceed to S2 standing-family discovery.