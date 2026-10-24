# Composite Standing / Qualification — S3 Evaluation Logic / Uncertainty / Invalidation Audit

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Test whether Composite Standing remains coherent once uncertainty, non-boolean results, evaluation/decision layers and changing inputs are treated as first-class rather than implementation detail.

## 2. Three layers that must not collapse

S3 strengthens a three-layer distinction.

### Layer A — standing / qualification proposition

What standing actually obtains under the constitutive semantics and qualification frame?

Examples:
- item conforms to requirement C;
- Actor is currently actionable for Work transition T;
- target is fit for intended use U;
- evidence set is sufficient for decision D;
- request is authorized under regime R.

### Layer B — epistemic assessment of the standing

What does available evidence/method support about Layer A?

Possible outputs:
- high/low probability;
- confidence/uncertainty interval;
- sufficient/insufficient coverage;
- supported/unsupported/indeterminate;
- model score or measured value;
- assessment result with known limitations.

### Layer C — decision / recognition / institutional outcome

What decision or recognized standing follows under a decision rule/authority/regime?

Examples:
- accept/reject;
- approve/deny;
- certify/not certify;
- authorize/deny;
- declare ready/not ready;
- recognized as complete/accepted.

Required rule:

```text
Layer A standing
!= Layer B epistemic assessment
!= Layer C decision/recognition
!= recorded Information representation of any layer
```

These layers can coincide in simple cases, but Foundation cannot assume identity.

## 3. JCGM conformity case — decisive uncertainty pressure

JCGM 106 distinguishes:
- actual conformity/nonconformity of an item relative to specification;
- measurement result and uncertainty/state of knowledge;
- conformance probability;
- acceptance/rejection decision produced under a decision rule;
- consumer/producer risks including false acceptance/rejection.

This gives a clean counterexample to:

```text
measured value within threshold
→ therefore certainly conforms
→ therefore accept decision
```

Guard bands can deliberately make the acceptance interval narrower or wider than the specification/tolerance interval to control decision risk.

Therefore:

```text
conforming standing
!= probability of conformity
!= acceptance decision
```

This supports the three-layer distinction without creating three universal standing children.

## 4. Result domains — Foundation-level semantic requirement

The project must not assume all standings are booleans.

### 4.1 Binary
Examples:
- criterion satisfied / not satisfied under deterministic known facts;
- authorization true/false under a simple complete rule set.

### 4.2 Categorical / ordinal
NASA Technology Readiness Levels are an explicit nine-level maturity scale. The assigned level depends on what was demonstrated and under which conditions.

This is standing-like maturity/readiness, not a boolean.

### 4.3 Graded / scalar / thresholded
Risk, fitness, confidence, quality or performance may be represented by scores/levels and then evaluated against thresholds.

The score and the thresholded qualification must remain distinct.

### 4.4 Probabilistic / uncertain
JCGM conformity probability is an explicit example.

The probability is a statement about knowledge/evaluation, not necessarily the object's object-level standing.

### 4.5 Partial / coverage-based
Examples:
- requirement set partially verified;
- evidence covers some claims/versions/populations but not all;
- source universe partially retrieved.

Do not flatten partiality into `true` merely because some criteria are satisfied.

## 5. `false`, `unknown`, `not evaluated`, `not applicable` are distinct

### False
The qualification frame applies and the available/constitutive basis supports that the standing does not hold.

### Unknown / indeterminate
The frame applies, but current basis is insufficient/conflicting/uncertain to establish true or false.

### Not evaluated
The standing may be meaningful/applicable, but the required evaluation has not been performed or completed.

### Not applicable
The criterion/use/regime does not apply to the exact focus/reference frame.

### Stale / expired evaluation
A prior assessment existed but current dependencies have changed enough that it can no longer justify a present-tense claim.

Required non-collapse:

```text
false
!= unknown
!= not evaluated
!= not applicable
!= stale
```

The exact labels are implementation/domain-specific, but these semantic distinctions can change actions and therefore cannot be assumed away.

## 6. `unknown` is not necessarily an object-level standing

A nuance is required.

`Unknown` often qualifies **our epistemic relation to a standing**, not the object itself.

Therefore the grammar should not blindly put `unknown` in the same object-value set as `conforming/nonconforming`.

Stronger model:

```text
object-level result domain
+
epistemic/evaluation state
+
decision/recognition outcome [when present]
```

This preserves simple implementations while keeping meanings distinct.

## 7. Applicability is prior to evaluation

A standing cannot be meaningfully evaluated before determining whether its criterion/frame applies to the focus.

Examples:
- a regulation outside its jurisdiction;
- a test result for the wrong target version;
- a readiness criterion for a different mission phase;
- a source-authority rule for a different subject matter;
- a permission policy for a different operation/environment.

Therefore:

```text
criterion identified
!= criterion applies
```

Applicability may itself be a local or composite standing, but conceptually it gates interpretation of the target standing.

## 8. Criteria and decision rules are not the same thing

S3 finds a strong distinction:

### Criterion / requirement
Defines what qualification means or what target range/condition is desired/required.

### Decision rule
Defines how uncertain/mediated evidence is converted into an assessment or decision.

JCGM guard-band examples show that the same specification can produce different accept/reject boundaries depending on decision rule and risk allocation.

Thus:

```text
criterion C
+ same evidence
+ decision rule R1
→ accept

criterion C
+ same evidence
+ decision rule R2
→ reject/indeterminate
```

The object-level criterion-relative standing need not have changed.

Decision-rule semantics sit at the Standing/Control boundary:
- when asking what evaluation outcome follows → Standing/qualification;
- when asking which rule must govern a transition and who may set/bypass it → Control.

## 9. Currentness and invalidation

A composite standing is only safely reusable while its load-bearing dependencies remain valid for the claimed reference frame.

Potential invalidators include:
- target/version/state change;
- criterion/requirement/policy version change;
- scope/jurisdiction/use change;
- evidence invalidation/correction/retraction;
- evidence/source freshness decay where time-sensitive;
- Environment condition change;
- Actor role/authority/delegation change;
- Work method/path or requested operation change;
- evaluation model/procedure change where the standing is explicitly method-relative;
- new contradictory evidence;
- expired waiver/exception/credential.

## 10. Dependency change does not always imply standing change

Avoid an invalidation overcorrection.

A dependency change can yield at least three outcomes:

```text
A) standing definitely changes
B) standing may or may not change → requires re-evaluation
C) standing provably remains unchanged
```

Therefore Foundation should preserve **validity dependency / re-evaluation requirement** rather than assume every input change flips the result.

This is important for later implementation caching/invalidation, but does not choose an implementation strategy now.

## 11. Current standing versus evaluation freshness

Required separation:

```text
standing currently holds
!= latest evaluation is current enough to establish it
```

Example:
- system may still be safe, but last safety assessment is too stale for current deployment decision;
- evidence may still be factually correct, but no longer cover the current target version;
- Actor may still be authorized, but cached authorization result has expired.

A stale assessment is not proof that the underlying standing is false.

## 12. NIST AI RMF — context and measurement pressure

NIST AI RMF reinforces:
- measurements/evaluations are context-sensitive;
- methods/metrics have limitations and uncertainty;
- validity/reliability should be evaluated in deployment-relevant conditions;
- generalizability beyond development conditions should be documented;
- risk-tolerance judgments affect whether deployment should proceed.

This pressure supports:

```text
measured performance
!= valid-for-this-use standing
!= acceptable-risk/deploy decision
```

and strengthens reference/use-frame plus uncertainty as conditional standing dimensions.

## 13. NASA readiness pressure

NASA TRLs show:
- readiness/maturity may be ordinal;
- the level is based on what has been demonstrated;
- demonstration conditions matter (`laboratory`, `relevant environment`, `operational environment`);
- the same technology can therefore have a different justified maturity standing as evidence/conditions change.

This supports the shared standing signature rather than a special boolean readiness branch.

## 14. Does evaluation-method identity belong in standing semantics?

Conditional answer.

### Method is semantic when:
- the standing definition explicitly depends on a recognized evaluation procedure;
- different valid methods can yield materially different result semantics;
- independence/coverage/calibration requirements are part of what `verified`, `certified`, or `sufficient` means.

### Method is not semantic when:
- it is merely one implementation/access mechanism for recovering an underlying standing that is defined independently.

Therefore method/procedure remains a conditional dimension, not universal core.

## 15. Does authority belong in standing semantics?

Conditional answer.

### Authority may be constitutive
- formal acceptance;
- license/adjudication standing;
- authorization under a governance regime.

### Authority may be merely evidential/recognition
- an expert reports a physical condition;
- a reviewer opines that evidence is sufficient.

Actor identity/authority must therefore be role-specific and cannot be universally required.

## 16. Does invalidation belong wholly to Transition?

No.

Standing needs to know **what its current claim depends on** and whether its evaluation remains applicable/current.

Transition owns:
- the event/change history;
- propagation process;
- causal/trigger sequence;
- recomputation/invalidation mechanics.

Standing owns:
- reference time/frame;
- validity dependency semantics;
- whether a previous result is still justified for the current claim.

This boundary survives S3.

## 17. Child-pressure result after S3

The strongest alternative split suggested by S3 is not family-based but layer-based:

```text
Constitutive Standing
Epistemic Assessment
Decision / Recognition
```

However this does **not** currently justify immediate children because:
- many standings do not instantiate all three layers;
- assessment is often Information/Work-mediated access rather than a different standing kind;
- decision/recognition often overlaps Control/Actors;
- the same shared signature is still needed across layers;
- making layers children would encourage false disjointness in institutional cases where decision is constitutive.

Retain them as semantic layers/dimensions for now.

## 18. Falsifier update

### F4 — Control theft
Still live but weakened: current standing/eligibility result is distinguishable from rule/enforcement semantics.

### F5 — Transition theft
Rejected: current validity dependencies are standing-semantic; change mechanics/history remain Transition.

### F6 — result-domain triviality
Rejected strongly.

### F7 — true-vs-evaluated collapse
Rejected strongly; refine to three-layer distinction.

### F8 — family split
Weakened further; family overlap persists.

### F9 — missing Binding distinction
No missing Binding primitive identified.

### F10 — upstream adequacy failure
No evidence.

## 19. S3 judgment

The bounded-leaf hypothesis strengthens.

Composite Standing appears to have:
- one shared cross-ground qualification signature;
- several overlapping profiles;
- three semantic layers that must remain distinguishable;
- non-boolean and uncertainty-aware result semantics;
- explicit applicability/currentness dependencies.

Proceed to S4 rival internal decompositions and child-discovery pressure.