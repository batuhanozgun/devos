# Contrastive / Interventional Causal Effect — Integrated Synthesis

**Status:** BOUNDED LEAF SYNTHESIS / USER EVALUATION PENDING  
**Date:** 2026-09-06

## 1. Executive result

Dedicated I0→I7 research supports:

```text
Contrastive / Interventional Causal Effect
    ← BOUNDED LEAF
    ← no immediate child promoted
    ← one target-specific causal-contrast grammar
```

Protected question:

> For a defined target, how would outcome/effect Y differ under exact regime/state/action/exposure X versus comparator X', under the relevant context/time/version, and with what limits on causal identification and generalization?

## 2. Why this is distinct from Actual Causation

Accepted Actual Causation asks:

> Which actual contributors caused/contributed to this exact realized episode/effect?

Contrastive Effect asks:

> How would outcomes differ under alternative regimes?

Therefore:

```text
Did X cause this observed Y?
!=
How would Y differ under X versus X'?
```

A factor can be an actual cause in one episode without having a large general effect across target scope. A mechanism can have a strong general effect without being the actual cause of one observed episode.

## 3. Causal effect is inherently contrastive

Observing an outcome after intervention X does not define the effect of X.

The causal object needs a comparator/reference regime.

```text
outcome under X
!= effect of X
```

Effect identity changes when comparator changes.

```text
X vs no intervention
!= X vs weaker intervention
!= X vs alternative intervention D
```

## 4. Exact outcome and target are constitutive

`X works` is not a well-formed causal-effect claim.

Causal effect depends on:
- which outcome/property;
- which target unit/population/system;
- which time horizon;
- which context/version/environment.

The same intervention can reduce incident probability but increase latency/cost, or reduce occurrence while leaving severity unchanged.

## 5. Stable causal-contrast grammar

```text
Contrastive causal-effect claim
├─ exact outcome Y
│  └─ relevant time horizon
├─ exact target bearer/scope
│  └─ unit / subgroup / population / system
├─ focal regime X
├─ comparator regime X'
├─ exact intervention/exposure/regime identity
│  ├─ version / intensity / timing / duration where material
│  └─ static / dynamic / policy regime where material
├─ target applicability frame
│  └─ Environment / population / version / time / context
├─ realized intervention/exposure semantics where material
│  └─ assignment / delivery / traversal / adherence / fidelity
├─ interference / exposure configuration where material
├─ effect aggregation / scale where magnitude is claimed
├─ heterogeneity / conditioning where material
├─ object-level causal-effect claim
├─ identification assumptions/threats visible when load-bearing
├─ evidence/estimate/uncertainty kept separate from causal truth
└─ source→target generalization boundary where material
```

This is a semantic grammar, not an ontology/schema prescription.

## 6. Intervention labels can hide different treatments

Same intervention name can mask differences in:
- version;
- intensity;
- timing;
- duration;
- target/eligibility rule;
- enforcement strength;
- host/runtime behavior;
- co-interventions;
- override/fallback behavior.

Therefore:

```text
same intervention label
!= same causal regime by identity
```

## 7. Intended/assigned intervention is not realized exposure

```text
planned/intended
!= assigned/offered
!= materialized/available
!= actually received/traversed
!= sustained with required fidelity
```

Each can support a legitimate causal question, but they answer different questions.

This is especially important in agentic systems where a policy/configuration can exist in source while one host/path/version fails to realize it.

## 8. Comparator ambiguity is equally dangerous

`baseline`, `usual process`, `no control`, `old model` can be heterogeneous regimes.

If comparator semantics drift, the effect claim drifts even when focal intervention remains unchanged.

## 9. Bundled interventions need causal qualification

Suppose one release changes:
- model;
- prompt;
- guardrail;
- routing;
- telemetry.

The bundle can have a causal effect.

But:

```text
bundle effect
!= component effect
```

unless evidence separates component contributions/effects.

## 10. Causal truth is not the estimator

A target effect can be defined even when current evidence cannot identify it.

Preserve:

```text
causal target defined
!= identifiable from current evidence
!= estimated
!= estimate correct/unbiased
!= estimate precise/stable
!= evidence sufficient for decision
```

This is one of the strongest Foundation boundaries from this pass.

## 11. Confounding and selection

Observed treatment-outcome differences can reflect:
- common causes/confounding;
- selection;
- measurement/information bias;
- support gaps;
- chance;
- model assumptions.

Thus:

```text
association / adjusted association
!= causal effect automatically
```

These are causal-identification/evidence threats rather than new causal-effect children.

## 12. Positivity/support

If a relevant target subgroup never receives comparator X', the causal contrast may still be conceptually meaningful while current evidence cannot empirically identify it there.

Thus:

```text
well-defined target effect
!= empirical support for both alternatives
```

Extrapolation can add assumptions; it does not create observed support.

## 13. Effect heterogeneity

Average effect can conceal genuinely different effects across:
- task types;
- Actors;
- risk strata;
- environments;
- versions;
- time periods;
- network positions.

Therefore:

```text
average causal effect
!= effect for every member
!= individual causal effect
```

Heterogeneity is a target/conditioning dimension, not a separate child.

## 14. Interference and spillover

One unit/Actor's intervention can change another's outcome.

Agentic/system examples:
- shared policy/memory;
- delegation;
- load shifting;
- reviewer learning;
- shared-resource constraints;
- one control displacing risky work to another path.

Where this matters, intervention may need to be represented as a system/assignment configuration.

```text
no observed spillover
!= no interference
```

Interference changes treatment/target semantics but does not create a new protected causal question.

## 15. Transportability/generalization

A causal effect established in source scope `S` does not automatically apply in target `T`.

```text
source/local effect
!= target effect by identity
```

Target effect remains a Contrastive Causal Effect:

```text
Effect of X vs X' on Y in target T
```

Transport/generalization asks whether evidence from source `S` supports that target claim under relevant invariance/effect-modifier/support/intervention-equivalence assumptions.

Current decision:

> **Transportability/Generalization remains a major profile and strongest reopen trigger, not an immediate child.**

Fresh dedicated external literature could not be retrieved during this pass, so this conclusion is deliberately bounded.

## 16. Direct / indirect / mediated / spillover effects

These can require distinct contrasts and assumptions, but remain more specific causal-path or exposure contrasts within the same protected question.

No universal child split.

## 17. Static / dynamic / policy regimes

An intervention can be a rule over time/context rather than one fixed value.

Example:

```text
if risk > threshold:
    require human approval
else:
    permit automated action
```

The causal treatment can be the whole policy regime.

No requirement to reduce all interventions to binary state variables.

## 18. Non-manipulable exposures

Literal manipulability is not universal.

A causal contrast can concern a state/exposure not directly settable by one atomic action if the alternative is sufficiently well-defined.

But vague exposures that bundle many incompatible ways of changing the world can make a causal effect ill-defined.

## 19. Control causal effectiveness

Accepted composition remains sufficient:

```text
Control
→ governing semantics

Contrastive Causal Effect
→ how target outcome/risk changes under Control C vs comparator C'

Composite Standing
→ whether effect magnitude/evidence meets effectiveness/acceptance criterion
```

Preserve:

```text
Control present
!= implemented
!= enforced
!= complied with
!= causally effective
!= effective enough for target criterion
```

## 20. Agentic-software example

Claim:

```text
"permanent eval E reduced recurrence"
```

needs at least enough resolution on:
- failure/outcome definition;
- target task/agent/environment population;
- E version and enforcement semantics;
- comparator regime;
- actual execution/fidelity;
- model/prompt/routing co-changes;
- spillover/interference;
- time horizon;
- eval/staging→production transport;
- confounding/selection/reporting changes.

Without those, the sentence may be operationally suggestive but not a bounded causal-effect claim.

## 21. Why no child hierarchy survives

Rejected child candidates:
- Intervention Definition / Identification / Generalization;
- Individual / Population / System;
- Direct / Indirect / Mediated / Spillover;
- Manipulable / Non-Manipulable;
- Efficacy / Effectiveness / Implementation;
- Local / Transported;
- Evidence-method families;
- Control Effectiveness;
- Benefit / Harm;
- Static / Dynamic / Adaptive;
- Identified / Partially Identified / Unidentified.

They are target, regime, path, evidence, aggregation or applicability dimensions of the same protected causal question.

## 22. Parent/upstream status

No reopen is required for:
- accepted Actual Causation leaf;
- accepted Causal Effect / Contribution parent;
- Transition / Effect / Feedback parent;
- Control / Standing boundaries;
- four-ground adequacy.

If accepted, the causal parent becomes bounded with both immediate children researched:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation       ← accepted leaf
└─ Contrastive / Interventional Causal Effect            ← bounded leaf
```

## 23. Feedback / Adaptation dependency

With both causal children bounded, Feedback/Adaptation can later distinguish:

```text
feedback occurred
!= adaptation occurred
!= adaptation causally improved target outcomes
```

The third statement requires contrastive causal-effect semantics rather than simple before/after observation.

## 24. External/candidate pressure and limitation

Used:
- source-grounded parent Dawid/Musio effects-of-causes vs causes-of-effects distinction;
- source-grounded parent CDC association/confounding pressure;
- source-grounded parent NIST control-effectiveness pressure;
- Anthropic candidate configuration/eval/incident-loop pressure;
- gstack candidate version/runtime/fidelity/readback pressure.

Fresh public-web retrieval failed technically in this child pass.

Therefore no fresh dedicated ICH/target-trial/transportability/interference literature review or independent second-researcher/model replication is claimed.

## 25. Final result

```text
Contrastive / Interventional Causal Effect
    ← BOUNDED LEAF
    ← no immediate child promoted
```

## 26. Next sequencing recommendation

If the user accepts this result:

> **Cross-Ground Feedback / Adaptation**

is the strongest next substantive Foundation research.

No next child is active.
