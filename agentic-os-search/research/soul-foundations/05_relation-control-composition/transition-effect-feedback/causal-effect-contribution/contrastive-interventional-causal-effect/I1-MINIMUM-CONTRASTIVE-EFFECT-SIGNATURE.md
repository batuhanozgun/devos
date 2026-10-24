# Contrastive / Interventional Causal Effect — I1 Minimum Contrastive-Effect Signature

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Determine the minimum semantics required for a decision-critical contrastive causal-effect claim without selecting one causal ontology, potential-outcome notation, structural causal model or estimator.

## 2. The protected object is a contrast, not an observed outcome

A causal effect asks how an outcome differs across alternatives.

Foundation-safe abstract form:

```text
Outcome under regime/state/action/exposure X
VERSUS
Outcome under regime/state/action/exposure X'
for target T in context C over horizon H
```

Therefore:

```text
Y observed after X
!= effect of X
```

unless a comparator/contrast semantics is also established.

## 3. Exact outcome/explanand is mandatory

A statement such as:

```text
Control C is effective
```

is under-specified.

Possible causal outcomes include:
- lower incident probability;
- lower severity conditional on incident;
- shorter duration;
- lower expected loss;
- lower false-positive rate;
- higher task success;
- lower latency;
- increased compliance;
- displacement to another failure mode.

One intervention can improve one outcome and worsen another.

Minimum requirement:

> **Name the outcome/property/distribution whose causal contrast is claimed.**

## 4. Comparator is constitutive, not optional decoration

The same focal intervention can have different effects relative to different comparators.

Example:

```text
C vs no control
C vs weaker control
C vs alternative control D
C at level 10 vs C at level 5
```

These are not the same causal-effect claim.

Therefore:

```text
intervention identity alone
!= causal effect identity
```

The **contrast pair/regimes** are constitutive of what effect means.

## 5. Target unit/population/system is constitutive

An effect can refer to:
- one unit under modeled alternatives;
- a defined population of tasks/people/services;
- a subgroup;
- a network/system;
- one Environment/version regime;
- a distribution of outcomes across repeated opportunities.

Thus:

```text
effect in population P
!= effect in subgroup S
!= effect for individual i
!= effect in target system T
```

by identity.

The target bearer/scope is part of the claim, not merely metadata.

## 6. Context / Environment / version can be constitutive

Causal effects can vary with:
- workload/task mix;
- model/provider/version;
- human/agent population;
- runtime environment;
- geography/jurisdiction;
- policy/control regime;
- time period;
- baseline prevalence/risk;
- interacting services/Actors;
- hardware/software versions.

Therefore a stable effect claim may need an applicability frame:

```text
source context C1
!= target context C2 by identity
```

Context does not always change the effect, but the claim must not silently assume invariance when context is materially effect-modifying.

## 7. Time horizon matters

The same intervention can have:
- immediate benefit;
- delayed harm;
- transient effect;
- adaptation/decay;
- cumulative effect.

Thus:

```text
effect at 1 minute
!= effect at 1 day
!= effect over 1 year
```

where horizon is decision-critical.

## 8. Intervention/exposure must be semantically exact enough

One label can hide multiple causal versions.

`human review` can mean:
- mandatory blocking review by a qualified owner;
- non-blocking comment;
- rubber-stamp approval;
- review of intent only;
- review of exact diff/version;
- review after deployment.

`guardrail enabled` can vary by:
- host;
- path coverage;
- policy version;
- model version;
- failure behavior;
- bypass surface.

Therefore:

```text
same treatment/intervention label
!= same causal intervention by identity
```

Minimum requirement:

> Preserve exact intervention/exposure/regime semantics to the degree needed so materially different versions are not silently pooled.

## 9. Static values are not the only possible interventions

An intervention/regime may be:
- one-time state assignment;
- repeated action;
- dynamic policy conditioned on current state;
- sequence/timing rule;
- stochastic routing policy;
- resource allocation regime;
- removal/addition of a Control;
- change in exposure/environment.

Foundation must not force every causal contrast into `A = 0` versus `A = 1`.

A regime can itself be a rule over time/context.

## 10. Literal manipulability is not a universal requirement

Some meaningful causal questions concern exposures/states that are not directly manipulable as one atomic action.

The safe boundary is not:

```text
not directly manipulable
→ not causal
```

but:

> Is the alternative state/regime sufficiently well-defined that the causal contrast has stable meaning, rather than silently combining many incompatible ways of changing the exposure?

If no coherent alternative can be specified, the effect claim may be ill-defined even if association is measurable.

## 11. Effect quantity / scale is often constitutive when magnitude matters

Possible effect summaries include:
- difference in probability/risk;
- ratio/relative risk;
- odds ratio;
- difference in mean outcome;
- quantile/distribution shift;
- time-to-event change;
- severity reduction;
- probability of crossing a threshold.

These can rank or communicate effects differently.

Foundation need not choose one metric, but when a magnitude is claimed:

```text
causal effect magnitude
is relative to an outcome/effect scale
```

Do not treat `effect size` as scale-free.

## 12. Individual and aggregate effects are distinct claims

An average causal effect can be positive while:
- some units benefit more;
- some are unaffected;
- some are harmed.

Therefore:

```text
average/population causal effect
!= causal effect for every member
!= causal effect for a specific individual
```

This is not merely uncertainty. It can reflect genuine effect heterogeneity.

## 13. Interference can change the treatment object itself

If one unit's treatment affects another unit's outcome, then outcome for unit `i` may depend on more than `i`'s own intervention.

Agentic examples:
- one agent's guardrail changes which work reaches other agents;
- shared memory/policy changes all agents' behavior;
- one service rate limit changes load on another service;
- one team receives a control that shifts risky work elsewhere.

Then the relevant contrast may need:

```text
intervention configuration / exposure mapping across connected units
```

rather than one independent unit-level treatment.

Foundation implication:

> Preserve interference/spillover when it changes the meaning of the causal contrast; do not assume independent units universally.

## 14. Causal truth, identification and estimation are different layers

A causal effect can be meaningful while current evidence cannot identify it.

Preserve:

```text
causal effect defined
!= identifiable from available evidence
!= estimated
!= estimate unbiased/correct
!= estimate sufficiently precise
!= evidence sufficient for decision
```

Examples of identification/evidence threats:
- confounding;
- selection;
- poor measurement;
- no/poor support for one comparator in a target subgroup;
- interference not modeled;
- intervention versions pooled;
- loss to follow-up / missing observation;
- model misspecification.

These threats matter, but they should not be collapsed into the object-level causal effect.

## 15. Identification assumptions must remain decision-visible when load-bearing

An estimate can require assumptions such as:
- exchangeability/no relevant unmeasured confounding;
- positivity/overlap/support;
- consistency/intervention-version alignment;
- no or modeled interference;
- correct selection/measurement relationships;
- stability/transport assumptions.

Foundation does not mandate this vocabulary universally.

It does require:

> When a causal conclusion depends materially on an assumption that the evidence does not directly establish, that assumption must remain visible rather than silently converted into fact.

## 16. Minimum contrastive-effect signature

Strongest current abstraction:

```text
Contrastive causal-effect claim
├─ exact causal question / outcome Y
│  └─ outcome semantics + relevant horizon
├─ target bearer/scope
│  └─ unit / population / system / subgroup
├─ focal regime X
├─ comparator regime X'
├─ exact intervention/exposure/regime semantics
│  └─ versions / timing / intensity / policy rule where material
├─ applicability frame
│  └─ Environment / population / version / time / context
├─ exposure configuration / interference semantics where material
├─ effect summary/scale where magnitude is claimed
├─ heterogeneity/conditioning semantics where material
├─ object-level causal claim
├─ identification assumptions/threats kept explicit where load-bearing
├─ evidence/estimate kept separate from causal truth
└─ generalization/transport boundary kept explicit where material
```

## 17. What is deliberately not in the universal core

Not every effect claim requires:
- randomization;
- one numeric effect measure;
- one potential-outcomes notation;
- one structural causal graph;
- literal human manipulability;
- zero interference;
- one homogeneous population;
- transport beyond the studied context;
- one estimator.

Those are methods/assumptions/profiles, not universal ontology commitments.

## 18. I1 conclusion

The active region has a coherent minimum signature.

The most important structural result so far is:

```text
causal effect identity
= not merely cause/exposure identity
= contrast + outcome + target + applicability frame
  (+ intervention/exposure configuration where material)
```

I2 must now attack the most common hidden-collapse: treating an intended/assigned intervention label as if it were the exact realized causal regime.
