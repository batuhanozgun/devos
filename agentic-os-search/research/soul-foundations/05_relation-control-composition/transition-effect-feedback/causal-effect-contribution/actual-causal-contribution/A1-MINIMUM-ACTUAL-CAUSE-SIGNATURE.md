# Actual Causal Contribution / Episode Causation — A1 Minimum Actual-Cause Signature

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Find the minimum semantic structure needed to state an actual-episode causal claim without importing one causal formalism.

## 2. Exact explanandum is mandatory

Actual causation is always relative to an effect/outcome being explained.

These can be different explananda inside one incident:

```text
initial fault occurrence
!= service outage
!= outage duration
!= user harm
!= recovery delay
```

A factor can cause/contribute to one and not another.

Therefore the claim must preserve the exact realized effect identity and relevant scope/time/boundary inherited from Transition / Propagation.

## 3. Contributor must be episode-specific

Distinguish:

```text
cause type X can cause failures
!= instance x actually contributed in episode e
```

An actual-cause claim must bind to the actual event/state/action/condition/absence/control instance or episode-relevant standing under examination.

A general hazard mechanism is not enough.

## 4. Minimum reusable grammar

Current strongest grammar:

```text
Actual causal claim
├─ exact episode / inquiry boundary
├─ exact realized explanandum / effect
├─ actual candidate contributor instance(s)
├─ causal contribution semantics where material
│  ├─ producing / triggering
│  ├─ enabling / conditioning
│  ├─ amplifying / progression
│  ├─ preventing / mitigating
│  └─ failure-to-prevent / detect / contain
├─ joint / interaction / causal-set semantics where material
├─ causal path / mechanism / dependency semantics where material
├─ relevant context / scope / time
├─ causal contrast / contingency semantics where material
├─ evidence basis kept separate from the relation
├─ competing explanations / unresolved contributors where material
├─ calibrated confidence / epistemic status
└─ decision-relevant causal depth / stopping boundary
```

Not every field is mandatory in every domain. The invariant is preservation of whatever distinctions change the truth or decision value of the causal claim.

## 5. Why independent pairwise edges can lose meaning

Consider:

```text
A AND B → E
```

where neither A nor B alone is sufficient in the relevant episode configuration.

Flattening to:

```text
A caused E
B caused E
```

may falsely imply independent causal sufficiency.

A safer semantic possibility is:

```text
causal configuration {A, B}
→ jointly contributed to E
```

with individual member roles retained where justified.

This does not mandate a hypergraph or database representation. It is a semantic warning:

```text
joint/set causal contribution
!= collection of independent cause claims
```

## 6. Redundant/overdetermining causes create a different set problem

Pattern:

```text
A sufficient for E
B independently sufficient for E
A and B both occur
```

Naive but-for tests can say neither is necessary.

Yet the actual episode may contain two independently sufficient causal routes.

Foundation must therefore permit:
- alternative sufficient sets;
- redundant contributors;
- preempted or partially preempted routes where material;
- uncertainty over which route completed the effect.

Do not force one scalar `root_cause`.

## 7. Causal polarity/role is not one universal enum

A contributor can:
- promote occurrence;
- enable another mechanism;
- increase severity;
- delay recovery;
- prevent/mitigate an outcome;
- fail to prevent/contain progression.

These roles answer different episode questions but overlap and depend on the explanandum.

They are typed semantics/profiles, not current immediate children.

## 8. Actuality and causal relevance must both hold

For ordinary positive contributors:

```text
candidate actually occurred/held
+
causally relevant to exact effect
```

For omissions, the “actual” fact is an absence/non-occurrence, but relevance still needs qualification.

Thus:

```text
actual presence/absence in episode
!= causal relevance by identity
```

## 9. Causal contrast is load-bearing but not always explicit

Actual-cause reasoning often asks some form of:

> How would this episode trajectory differ under a relevant alternative involving X?

But Foundation should not require one formal counterfactual syntax.

Mechanistic reconstruction, physical constraints, removal/fault injection, barrier analysis or other domain evidence can realize the contrast.

Rule:

```text
causal contrast concept
!= mandatory one counterfactual formalism
```

## 10. Mechanism/path semantics are conditional requirements

A causal path can be decision-critical when:
- several routes could connect X to E;
- one route was blocked/preempted;
- a barrier failure matters only on a particular path;
- intervention must target a specific mechanism.

But a complete mechanistic model is not universal.

Therefore:

```text
plausible mechanism
!= actual mechanism operated
```

and mechanism is preserved when it distinguishes the claim.

## 11. Evidence is not the causal relation

Keep four layers separate:

```text
actual causal relation
!= represented/asserted causal relation
!= evidence supporting causal relation
!= evidence-sufficiency Standing
```

A log or investigation report can be wrong, incomplete or stale relative to the exact episode/effect.

## 12. Causal depth is query-relative

A factor can be:
- proximate for one explanandum;
- intermediate for a broader explanandum;
- systemic for a narrower inquiry boundary.

Depth is therefore relative to:
- exact effect;
- chosen system/inquiry boundary;
- intervention question.

No absolute `root depth` is promoted.

## 13. Frame-blindness extension

Causal completeness has a target-universe problem similar to Propagation completeness:

```text
all observed/logged contributors analyzed
!= all materially possible contributors considered
!= causal explanation complete
```

Sources/telemetry can systematically omit:
- uninstrumented paths;
- failed observations;
- hidden environment conditions;
- omitted Actor/tool interactions;
- selection-produced absences.

This is an Information/Selection pressure on causal epistemics, not evidence that causal truth belongs to Information.

## 14. Rejected universal fields

Not universally required:
- one root cause;
- but-for necessity;
- independent causal sufficiency;
- one causal mechanism model;
- one counterfactual syntax;
- one numeric contribution weight;
- one confidence scale;
- one depth hierarchy.

## 15. A1 conclusion

The reusable unit is better described as an **effect-centered actual causal episode structure** than as a list of `causedBy` edges.

Strongest new structural insight:

> Actual causal contribution can be irreducibly configuration/set-relative. Preserving contributor identity without preserving the relevant joint/alternative causal configuration can change the claim's meaning.

Proceed to A2 to attack multiple causation, omission and causal depth directly.
