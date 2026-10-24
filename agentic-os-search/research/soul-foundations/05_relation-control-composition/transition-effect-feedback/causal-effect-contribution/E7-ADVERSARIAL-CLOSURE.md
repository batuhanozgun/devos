# Cross-Ground Causal Effect / Contribution — E7 Adversarial Closure

**Status:** COMPLETE / BOUNDED PARENT CLOSURE WITH TWO CHILDREN  
**Date:** 2026-09-06

## 1. Objective

Attack the E6 two-child promotion hard enough to determine whether:
- the split is artificial;
- one child reduces safely to the other;
- a third child is missing;
- Causation should move to parent-sibling level;
- or the whole causal region collapses into Transition/Binding/Standing/Control/Actors.

E6 provisional structure:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation
└─ General / Interventional Causal Effect
```

## 2. Attack — “This is just one causal question with different datasets”

### Challenge

Both children have causes, effects, evidence and counterfactuals. Why not one bounded leaf?

### Result

The distinction changes the **proposition being answered**, not only the data.

```text
Did X contribute to this realized E?
```

and:

```text
How would changing X alter Y under alternative X' across scope S?
```

can receive different answers from the same evidence base.

A strong average causal effect does not establish actual causation in one episode; a strong episode reconstruction does not identify a general effect under alternative interventions.

**Attack fails.**

## 3. Attack — “Actual causation reduces to general causal effect + episode facts”

### Challenge

If the general causal model is known, perhaps episode causation is merely applying it to facts.

### Counterpressure

Actual-cause questions introduce:
- realized contributor occurrence;
- actual causal path/set;
- overdetermination/redundancy;
- episode-specific context;
- probability of causation / actual-cause ambiguity;
- token-level mechanism and reconstruction.

Even with a known general effect:

```text
X increases Y probability
```

does not identify whether X caused this exact Y.

Independent causality literature explicitly treats effects-of-causes and causes-of-effects as distinct problem areas.

**Attack fails.**

## 4. Attack — “General causal effect reduces to many actual-cause cases”

### Challenge

Collect enough incidents and count causes.

### Counterpressure

Incident collection can be selected by outcome, severity, logging or investigation policy. Counts lack a counterfactual comparison by default.

General effect requires questions such as:
- what is the alternative exposure/intervention?;
- what comparison group/trajectory is valid?;
- what confounding/selection operates?;
- how heterogeneous is effect by context?;
- what would happen under a changed intervention distribution?

Thus:

```text
many actual-cause narratives
!= identified causal effect
```

**Attack fails.**

## 5. Attack — “The split is epidemiology/statistics-specific”

### Challenge

Maybe effects-of-causes versus causes-of-effects is imported from statistical causality and does not belong in general Foundation research.

### Cross-domain counterexamples

#### Engineering incident

```text
Why did this turbine fail?
```

Actual episode causation.

```text
Does changing maintenance interval reduce failure probability?
```

Contrastive/interventional causal effect.

#### Software

```text
Did config X cause this outage?
```

Actual episode causation.

```text
Does guardrail G reduce outage incidence across deployments?
```

Contrastive/interventional effect.

#### Governance/control

```text
Did missing approval gate contribute to this harmful deployment?
```

Actual episode causation.

```text
Does mandatory approval reduce harmful-deployment risk overall?
```

Contrastive/interventional effect.

The distinction is not statistics-specific.

**Attack fails.**

## 6. Attack — “Actual causation is just provenance / attribution”

### Challenge

Perhaps causal episode analysis is already Binding/Information provenance.

### Counterpressure

Provenance can establish:

```text
artifact B derived from artifact A
Actor X produced record R
```

without proving:

```text
A made the harmful effect occur
X's action materially changed the outcome
```

Causation asks difference-making/mechanism/contribution, not merely source/lineage.

**Attack fails.**

## 7. Attack — “General effect is just Composite Standing”

### Challenge

Perhaps `control effective` or `treatment beneficial` is simply a qualification.

### Counterpressure

Standing can own:

```text
evidence sufficient to conclude control effectiveness under criterion C
```

but the underlying causal proposition remains:

```text
control changes outcome/risk relative to alternative
```

The causal relation can hold even before it is known/accepted, and evidence can falsely support it.

**Attack fails.**

## 8. Attack — “Systemic causation should be a third child”

### Challenge

Systems-safety traditions give systemic causation major independent importance.

### Counterpressure

`systemic` changes with analysis boundary and decision depth.

A systemic factor can participate in:
- one actual incident explanation;
- a general causal-effect hypothesis across operations.

It has no independent protected question once the actual-vs-contrastive causal question is fixed.

**Attack fails.**

## 9. Attack — “Omission / failure-to-prevent should be a third child”

### Challenge

Negative causation has special logic.

### Counterpressure

Omission claims indeed require stronger relevance constraints, but they can occur in both promoted children:

```text
Actual:
Did absent barrier B contribute to this incident?

Contrastive:
Would adding barrier B reduce incident risk?
```

Omission therefore cuts across the split.

**Attack fails.**

## 10. Attack — “Control effectiveness should be a third child”

### Challenge

Control effectiveness is operationally important enough to stand alone.

### Counterpressure

It is a composition profile:

```text
Control semantics
+ Actual Causation OR Contrastive Causal Effect
+ evidence
+ criterion
→ effectiveness Standing
```

Its importance does not create a unique causal protected question.

**Attack fails.**

## 11. Attack — “Responsibility/accountability is inseparable from actual causation”

### Challenge

Actual incident analysis often exists to assign responsibility.

### Counterpressure

Causal contribution can belong to:
- weather;
- hardware;
- organizational process;
- software;
- an innocent Actor action;
- a missing barrier;
- an unauthorized Actor;
- an authorized Actor.

Responsibility additionally requires normative/authority/duty/forum standards.

Thus:

```text
causal contribution
!= responsibility/accountability
```

**Attack fails.**

## 12. Attack — “Causal confidence belongs only to Information/Standing”

### Challenge

Why keep alternatives/confounding inside causal research?

### Counterpressure

Causal alternatives are not generic uncertainty. They determine which **intervention would work**.

Example:

```text
outage caused by config defect
vs
outage caused by dependency capacity
```

Both may fit the observed timeline but imply different corrective Work.

Causal child therefore must preserve alternative causal explanations and discriminating evidence, while Standing owns whether evidence meets a sufficiency criterion.

**Attack fails.**

## 13. Attack — “Causation should become a fifth Cross-Ground Composition sibling”

### Challenge

If Causation now has two children, perhaps it is peer to Binding/Standing/Control/Transition rather than nested under Transition.

### Counterpressure

Both children are effect-centered:

```text
Actual Causation
→ explain an exact realized transition/effect

Contrastive Causal Effect
→ compare outcome/effect under alternative causes/actions
```

Without effect/outcome/change semantics, the causal question is incomplete.

The Transition / Effect / Feedback parent remains the natural composition owner.

No independent holdout produced a causal protected question that survives removal of effect/change semantics.

**Attack fails.**

## 14. Naming attack — “General / Interventional” is too narrow or misleading

### Challenge

`General` can be confused with population-only effects. `Interventional` can imply only actually manipulable causes or randomized interventions.

### Correction

Rename the second child to:

> **Contrastive / Interventional Causal Effect**

Protected meaning:

> How would outcome/effect Y differ under a defined alternative state/action/exposure/intervention X versus X', for the relevant unit/population/context?

`Interventional` remains a strong common form, but `Contrastive` keeps the Foundation concept broader than literal manipulability or one statistical formalism.

This is a naming refinement, not a structural change.

## 15. Final promoted structure

```text
Cross-Ground Causal Effect / Contribution
    ← BOUNDEDLY COMPLETE AS PARENT REGION
    ← NOT A LEAF
    ← TWO IMMEDIATE DIAGNOSTIC CHILDREN

├─ Actual Causal Contribution / Episode Causation
└─ Contrastive / Interventional Causal Effect
```

No immediate child is active.

## 16. Cross-cutting profiles/dimensions — not children

Across both children:
- proximate/direct role;
- enabling/contributing condition;
- prevention failure;
- detection/containment failure;
- systemic/framing depth;
- necessary/sufficient/contributing properties;
- omission/failure-to-prevent;
- mechanism;
- counterfactual/intervention evidence;
- statistical evidence;
- confounding/selection;
- causal confidence;
- effect heterogeneity;
- causal depth / stopping criterion.

## 17. Verification limit

E7 is same-model adversarial review.

Authoritative cross-domain and scholarly sources strongly pressure the distinctions, but:
- no external source publishes this exact project hierarchy;
- no independent second researcher/model has replicated the synthesis;
- child names are Foundation working labels, not adopted external terminology.

## 18. Sequencing recommendation

If user evaluation accepts the parent result:

> **Actual Causal Contribution / Episode Causation** should be researched first.

Reason:
- exact realized effect/transition is already accepted upstream;
- R06 causal-depth concerns concentrate there;
- actual-cause analysis bounds prevention/detection/systemic roles before later contrastive-effect estimation;
- Feedback/Adaptation can later benefit from both actual incident causation and intervention-effect evidence.

Do not pre-fix the full remaining order after Actual Causation closure.

## 19. E7 final judgment

The two-child promotion survives adversarial closure.

No upstream parent/four-ground reopen is justified.