# Contrastive / Interventional Causal Effect — I3 Confounding / Selection / Interference / Heterogeneity Audit

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Test whether confounding, selection, interference, heterogeneity and transportability are:
- constitutive parts of contrastive causal-effect semantics;
- identification/evidence threats;
- generalization boundaries;
- or stable immediate children.

## 2. Confounding is a causal-structure threat to identification, not the causal effect itself

Observed difference:

```text
E[Y | X] - E[Y | X']
```

can differ from the causal contrast because another factor affects both exposure/intervention and outcome.

Agentic example:

```text
high-risk tasks
→ more likely to receive stronger guardrail
→ more likely to fail anyway
```

Naive observation can make the guardrail appear harmful.

Therefore:

```text
observed conditional difference
!= causal effect by identity
```

Confounding belongs in the causal evidence/identification discipline because it specifies a serious alternative causal structure.

It does not create a new protected causal question.

## 3. “Adjusted” does not automatically mean causally identified

Adjustment can fail when:
- important common causes are unmeasured;
- the adjustment set omits relevant structure;
- variables are measured poorly;
- adjustment conditions on consequences/colliders;
- model assumptions are wrong;
- relevant support/overlap is absent.

Foundation-safe rule:

```text
statistically adjusted estimate
!= causal effect automatically
```

The assumptions connecting evidence to the causal claim must remain visible when decision-critical.

## 4. Selection can change the apparent causal relation

Selection into:
- the sample;
- logging/telemetry;
- analysis;
- treatment eligibility;
- follow-up;
- incident reporting;
- benchmark/eval suite
can distort observed effects.

Agentic examples:
- only failures receive deep traces;
- only risky tasks are sent to a verifier;
- successful tasks are sampled less often;
- tasks that time out disappear from quality analysis;
- benchmark cases are curated after known failures.

Thus:

```text
observed sample effect
!= target-population causal effect by identity
```

Selection is partly Information Selection/Exposure pressure, but the way selection changes causal identification remains causal-evidence structure.

## 5. Positivity / overlap / support is a separate identification condition

Suppose a subgroup/context never receives comparator `X'`.

The causal contrast may still be conceptually defined:

```text
Y under X vs Y under X'
```

but current evidence may provide no empirical support for one side of the contrast in that target scope.

Therefore:

```text
causal effect well-defined
!= causal effect empirically identified from current support
```

Strong extrapolation may still estimate it, but that adds model assumptions rather than magically creating observed support.

This is important for agentic evaluations where:
- dangerous actions are always gated;
- old model versions disappear;
- high-risk production cases cannot ethically be run without controls;
- some host/runtime combinations never receive both variants.

## 6. Heterogeneity is causal truth variation, not merely estimation noise

Effects can genuinely differ by:
- Actor/task type;
- baseline risk;
- Environment;
- model version;
- intervention version;
- workload;
- time;
- network position;
- co-controls.

Therefore:

```text
average effect = +5
```

can coexist with:

```text
subgroup A = +20
subgroup B = 0
subgroup C = -10
```

The average is not wrong; it answers a different aggregate question.

Foundation implication:

> Effect heterogeneity is a target/conditioning/applicability dimension of the causal claim, not a reason to assume one universal homogeneous effect.

## 7. Average-to-individual inference is unsafe

Even a precise average effect does not establish:
- benefit for each unit;
- effect for one exact individual/agent/task;
- causal explanation for a realized episode.

Preserve:

```text
population/average causal effect
!= individual causal effect
!= actual episode causal contribution
```

Decision rules can legitimately use group/population effects, but that is a separate decision/Standing problem and must not rewrite the causal claim.

## 8. Interference/spillover attacks the independent-unit assumption

If intervention on unit `j` can affect outcome of unit `i`, then:

```text
Y_i depends only on X_i
```

is false.

Agentic/system examples:
- one agent's policy changes tasks delegated to another;
- a rate limiter on one service shifts load to another;
- human reviewers learn from treated cases and alter untreated cases;
- shared memory or global configuration changes all agents;
- one team's guardrail displaces risky work into another route;
- one rollout changes network congestion or shared-resource availability.

Then the causal contrast may need to specify:
- treatment vector/configuration;
- neighborhood exposure;
- assignment policy;
- saturation/coverage level;
- system-level regime.

## 9. Interference does not yet justify a separate child

Protected question remains:

> How would outcome differ under regime/configuration X versus X'?

Interference changes **what the regime must specify** and which units/outcomes form the target.

It creates characteristic failure modes, but they are failures of under-specified treatment/target structure rather than a distinct causal question.

Provisional verdict:

```text
Interference / Spillover
→ high-value causal-contrast profile/dimension
→ not immediate child
```

## 10. Direct/indirect/spillover effects are nested contrast profiles

When one unit's intervention affects another or a mediator carries effect, one can ask:
- direct effect;
- indirect/mediated effect;
- spillover effect;
- total/system effect.

These require different contrasts and sometimes stronger assumptions.

But they still ask:

```text
How would outcome differ under defined alternative regimes?
```

No independent protected question appears yet.

## 11. Transportability/generalization is the strongest child candidate

Distinct question form:

> Evidence/causal effect was established in source context/population `S`. What causal effect should we expect in target context/population `T`?

This looks different from simply estimating one local effect.

Potential failure modes:
- effect modifiers have different distribution;
- mechanism changes;
- intervention version/fidelity differs;
- outcome measurement differs;
- baseline risk changes;
- co-interventions differ;
- selection into source study differs;
- support is missing in target subgroups.

Therefore transportability is genuinely load-bearing.

## 12. But transportability can be represented as a target-specific causal claim + evidence bridge

Suppose the target question is:

```text
Effect of X vs X' on Y in target population/context T
```

That is already a Contrastive / Interventional Causal Effect claim with `T` in its applicability frame.

Using source evidence `S` to answer it requires additional assumptions/evidence about:
- invariance;
- effect modifiers;
- selection;
- support;
- intervention equivalence.

Thus:

```text
causal effect in target T
```

is the same kind of object-level causal claim,
while:

```text
can evidence from S identify/support the effect in T?
```

is a **generalization/transport evidence-validity problem**.

This weakens the case for a separate immediate child.

## 13. Transportability is not automatic from mechanistic plausibility

```text
mechanism exists in S and T
```

does not guarantee equal effect magnitude because:
- competing pathways differ;
- exposure distributions differ;
- baseline risks differ;
- treatment versions/fidelity differ;
- system interactions differ.

Likewise:

```text
same model name / same policy label
!= same causal context
```

## 14. Internal validity and external validity must not collapse

A study/eval can estimate a causal effect well **for its study scope** while still being weak evidence for another target.

Preserve:

```text
causal effect identified in source scope
!= effect identified in target scope
```

This is particularly important for:
- benchmark→production transfer;
- staging→production;
- model version updates;
- one organization→another;
- one workload distribution→another;
- one host/runtime→another.

## 15. Environment/version drift creates transport invalidation

A previously supported causal-effect claim may become stale for a new target when:
- model/provider changes;
- intervention implementation changes;
- runtime/tool semantics change;
- user population changes;
- task distribution changes;
- adjacent Controls change;
- underlying system architecture changes.

The historical effect is not retroactively false; its **applicability to the new target** is no longer established.

This interfaces with Standing/currentness and Transition without turning transportability into historical transition semantics.

## 16. Causal effect vs policy effect

When interference and dynamic treatment rules are strong, the most stable target may be a **system policy/regime effect** rather than independent unit effects.

Example:

```text
route 100% high-risk tasks to verifier
vs
route only 20%
```

Outcomes can include:
- task failures;
- queue latency;
- reviewer overload;
- spillover to unreviewed tasks;
- total system risk.

Foundation must allow the causal contrast to operate at the system/regime level.

## 17. Measurement and causal heterogeneity must remain separate

Observed effect differences across groups may arise from:
- genuine causal heterogeneity;
- measurement differences;
- selection differences;
- confounding;
- random uncertainty.

Therefore:

```text
observed subgroup difference
!= effect modification automatically
```

This reinforces the causal-truth/evidence separation.

## 18. Current structural verdicts

### Confounding
Identification/evidence threat; not child.

### Selection
Identification/generalization threat; not child.

### Positivity/support
Identification/support condition; not child.

### Heterogeneity
Target/applicability dimension; not child.

### Interference/spillover
Regime/target-structure dimension; not child.

### Transportability/generalization
Strongest child candidate, but current evidence favors:

```text
target-specific causal-effect claim
+ source→target evidence/invariance bridge
```

rather than a separate first-order child.

This remains open for I4/I5 adversarial testing.

## 19. I3 conclusion

No tested identification/generalization issue has yet broken the coherence of one Contrastive / Interventional Causal Effect child.

The child is increasingly characterized by:

```text
causal effect claim
= exact target-specific contrast

identification/estimation/generalization
= ways evidence can or cannot support that claim
```

I4 must now test rival internal decompositions explicitly, with Transportability/Generalization as the strongest candidate split.
