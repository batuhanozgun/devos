# Contrastive / Interventional Causal Effect — I0 Evidence Recovery

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Recover the accepted causal-parent boundary, accepted Actual Causation result, Control/Standing interfaces, candidate-study pressure and source-grounded external causal-effect conclusions before proposing a child structure.

This pass freezes falsifiers first.

## 2. Accepted parent boundary

Accepted causal parent:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation       ← accepted bounded leaf
└─ Contrastive / Interventional Causal Effect            ← active child
```

Protected distinction:

```text
Did X cause this observed Y?
!=
How would Y differ under X versus X'?
```

Actual Causation is episode-specific and configuration-sensitive. It does not provide a population/context-level effect merely by accumulating episodes.

## 3. Exact outcome/effect prerequisite

Contrastive causal effect is meaningless until the outcome is explicit.

Potential examples that must not be collapsed:
- probability of any incident;
- severity conditional on incident;
- mean recovery time;
- user-visible error rate;
- false-positive rate;
- security/privacy risk;
- task success;
- cost/latency/throughput;
- downstream Actor behavior.

Therefore:

```text
"X works"
!= a well-formed causal-effect claim
```

The same intervention can improve one outcome while worsening another.

## 4. Contrast/comparator prerequisite

A causal effect is contrastive by meaning.

At minimum, the claim must identify or recover:
- focal state/action/exposure/intervention `X`;
- comparator/reference alternative `X'`;
- outcome `Y`;
- relevant unit/population/system/context;
- time horizon/reference frame.

Do not treat:

```text
outcome under X observed
```

as sufficient to define:

```text
effect of X
```

without a relevant alternative.

## 5. Parent evidence discipline inherited from E3/E5

Accepted causal-parent research already established:

```text
association != causation
before/after improvement != intervention effectiveness
plausible mechanism != general causal effect across contexts
experimental average effect != actual cause of one episode
one successful intervention != universal causal invariance
```

CDC source-grounded parent pressure keeps chance, selection bias, information/measurement bias and confounding visible.

NIST source-grounded parent pressure keeps Control effectiveness distinct from Control existence, implementation and compliance.

Dawid/Musio source-grounded parent pressure explicitly supports the high-level split between effects-of-causes and causes-of-effects.

These conclusions are inherited; this child does not pretend to have independently reverified them unless I5 adds fresh retrieval.

## 6. Control boundary

Accepted Control owns governing semantics:

```text
what behavior/effect is governed
+ basis/objective
+ applicability
+ control mode
+ authority/decision/enforcement layers where material
```

Contrastive causal effect asks a different question:

> Does implementing/maintaining/removing/changing Control C change outcome/risk Y relative to comparator C' in the relevant context?

Therefore:

```text
Control implemented correctly
!= Control causally effective

Control complied with
!= Control causally effective
```

## 7. Standing boundary

Contrastive causal truth must remain separate from:
- evidence/estimate;
- uncertainty/confidence;
- evidence sufficiency;
- decision/acceptance.

Preserve:

```text
causal effect exists/holds
!= identifiable from available evidence
!= estimated
!= estimate precise/stable
!= evidence sufficient for target decision
!= authorized decision based on effect
```

The last qualification layers are Standing/decision-facing.

## 8. Information boundary

Observed exposure, outcome and context are representations of actual conditions/actions.

Thus:

```text
record says treatment/exposure X occurred
!= exact realized intervention/exposure X occurred

reported outcome Y
!= actual outcome Y by identity
```

Measurement error, logging omissions and selection/exposure processes can make observed associations misleading without moving causal truth into Information.

## 9. Candidate-study pressure — Anthropic

The Anthropic study supplies a useful causal-effect hard case:

```text
production incident
→ new eval / guardrail / configuration
→ later fewer incidents
```

The safe question is not merely whether the incident count fell.

Decision-critical alternatives include:
- task mix changed;
- model/provider/version changed;
- reporting/detection changed;
- workload changed;
- another infrastructure/control change occurred;
- high-risk tasks were selectively routed;
- the new guardrail altered only one path while other paths remained;
- the intervention was not consistently realized across environments.

Therefore candidate pressure preserves:

```text
intervention followed by improvement
!= intervention caused improvement
```

## 10. Candidate-study pressure — gstack

The gstack study emphasizes:

```text
source/eval/control change
→ actual materialization
→ runtime behavior/effect
→ production readback
→ refresh/recover/learn
```

Its strongest reusable pressure for this child is:
- heterogeneous evidence answers different questions;
- false-green prevention matters;
- source change is not identical to live/runtime propagation;
- production feedback can motivate self-development;
- current system behavior can drift with host/model/runtime/version.

Thus a claim like:

```text
new eval/control improved reliability
```

requires exact intervention realization, comparator, outcome definition and Environment/version scope.

## 11. Frozen falsifiers

The child result must survive all of these.

### F1 — Vague-effect falsifier

```text
"X works" is sufficient causal semantics
```

### F2 — Association falsifier

```text
association / correlation / before-after difference = causal effect
```

### F3 — Intervention-identity falsifier

```text
one intervention label denotes one invariant causal treatment
```

Possible multiple versions, dose/intensity, implementation path and co-interventions must be tested.

### F4 — Assignment/fidelity falsifier

```text
assigned / intended / offered X = realized X
```

### F5 — Average-to-individual falsifier

```text
population average effect = effect for this individual/task/agent
```

### F6 — Local-to-target falsifier

```text
causal effect in source context/population/version = effect in target context/population/version
```

### F7 — No-interference falsifier

```text
one unit/Actor's intervention cannot affect another unit/Actor's outcome unless explicitly modeled
```

### F8 — Confounding-selection falsifier

```text
observed controlled-vs-uncontrolled difference identifies causal effect without assumptions
```

### F9 — Support/positivity falsifier

```text
causal effect is empirically identified in target scope even when relevant alternatives never/rarely occur there
```

### F10 — Effect-scale falsifier

```text
"effect" is scale-free and outcome-metric independent
```

### F11 — Control-effectiveness falsifier

```text
Control present/enforced/complied-with = Control effective
```

### F12 — Episode/general-collapse falsifier

```text
Actual Causation can be safely reused as general/interventional effect without additional contrast/context semantics
```

### F13 — Estimator-truth falsifier

```text
statistical estimate/model output = causal truth
```

### F14 — Manipulability falsifier

```text
only literally manipulable variables can participate in meaningful causal contrasts
```

This must be attacked without allowing undefined exposure contrasts.

### F15 — Transportability-child falsifier

```text
Transportability/generalization necessarily forms a separate immediate child
```

### F16 — Interference-child falsifier

```text
Interference/spillover necessarily forms a separate immediate child
```

### F17 — Mediation-child falsifier

```text
Direct/indirect/mediated effects necessarily form separate immediate children
```

## 12. Provisional pressure map

The active region appears to need at least these semantic dimensions:

```text
exact outcome/effect
+ exact contrast/comparator
+ intervention/exposure definition
+ unit/population/context/time
+ realized intervention/fidelity
+ effect measure/scale where material
+ assumptions/threats to causal identification
+ heterogeneity/interference/transport boundaries where material
+ evidence/uncertainty kept separate from truth
```

No dimension is yet promoted to child status.

## 13. Fresh-web limitation

Fresh public-web retrieval was attempted at I0 and failed technically. Therefore:
- no new independent source verification is claimed at this stage;
- source-grounded external conclusions from accepted parent E5 are reused;
- I5 will retry fresh authoritative retrieval if tooling allows;
- if tooling remains unavailable, the closure must disclose that limitation and avoid pretending that source breadth increased.

## 14. I0 conclusion

The active protected question is coherent and distinct from Actual Causation.

The strongest immediate next task is not to choose an estimator or causal formalism. It is to establish a Foundation-safe **minimum contrastive-effect signature** and determine which parts belong to causal meaning versus identification/evidence/generalization profiles.
