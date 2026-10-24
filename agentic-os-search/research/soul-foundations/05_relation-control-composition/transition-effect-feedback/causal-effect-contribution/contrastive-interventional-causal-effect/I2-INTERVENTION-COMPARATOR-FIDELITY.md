# Contrastive / Interventional Causal Effect — I2 Intervention / Comparator / Fidelity Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Test whether a causal-effect claim can safely treat intervention intent/assignment/name as the realized treatment regime, and determine what comparator/fidelity distinctions are Foundation-load-bearing.

## 2. There are several different causal questions hiding behind “effect of X”

Consider a new guardrail `G`.

Possible questions:

```text
Effect of deciding to require G?
Effect of assigning G to tasks?
Effect of successfully materializing G in runtime?
Effect of tasks actually traversing G?
Effect of G when configured at exact version/policy V?
Effect of sustained G over time?
Effect of G + accompanying model/process changes?
```

These are not one claim.

## 3. Intended intervention != assigned intervention != realized intervention

A useful non-collapse chain:

```text
intervention intended/planned
!= intervention assigned/offered
!= intervention materialized/available
!= intervention actually received/traversed
!= intervention sustained with required fidelity
```

Each can be the causal contrast of a legitimate question.

Example:

```text
policy says all production actions require human review
```

may coexist with:
- one host lacking the hook;
- one alternate path bypassing the gate;
- one model version not invoking the expected tool;
- user override;
- review occurring after mutation rather than before it.

Thus `human-review treatment` is not semantically exact until the relevant realization is specified.

## 4. Assignment effect and received-treatment effect can differ

A policy/assignment can have causal effects even when not perfectly followed.

For example, assigning a review requirement may:
- change developer/agent behavior before review;
- cause some tasks to be abandoned;
- route work elsewhere;
- increase latency;
- trigger alternate tools.

Therefore:

```text
effect of assignment/policy
!= effect of actually receiving/traversing review
```

Foundation must allow both without forcing one as the “real” causal effect.

## 5. Implementation fidelity is not merely a measurement nuisance

If intervention versions differ causally, pooling them changes the estimand/claim.

Examples:

```text
Hook G v1: blocks direct Write only
Hook G v2: blocks direct + shell-equivalent paths
Hook G v3: blocks all known material paths + logs decision
```

Calling all three `G = on` can erase causal differences.

Similarly:
- dosage/intensity;
- enforcement strength;
- timing;
- duration;
- human expertise;
- policy version;
- model/runtime integration;
- environment-specific degradation
can be constitutive treatment versions.

Rule:

> If different realizations can materially change the outcome, intervention-version/fidelity semantics cannot be silently collapsed.

## 6. Fidelity is a cross-ground bridge, not automatically a child

Intervention realization can involve:
- Work — installation/execution;
- Information — configuration/policy representation;
- Environment — actual runtime materialization;
- Actors — participation/adherence/override;
- Binding — exact intervention-target/version association;
- Transition — source/config change becoming effective;
- Standing — whether realization meets a criterion.

Contrastive Causal Effect needs to know **which realized regime is being contrasted**.

But the lifecycle/process of making it real belongs to existing grounds/children.

Therefore provisional rule:

```text
intervention fidelity is causal-effect identity/evidence pressure
!= new composition region by identity
```

## 7. Comparator ambiguity can be as damaging as treatment ambiguity

Labels such as:
- `no control`;
- `usual process`;
- `baseline`;
- `old model`;
- `manual workflow`
can hide heterogeneous alternatives.

Example:

```text
new guardrail vs old process
```

is unstable if the `old process` spans:
- different model versions;
- different operators;
- different workload;
- different network topology;
- different reporting/monitoring.

The comparator is constitutive of the effect claim and must be exact enough for the decision.

## 8. Co-interventions / bundled changes create attribution ambiguity

Suppose one release includes:

```text
new guardrail
+ model upgrade
+ new prompt
+ routing change
+ new telemetry
```

Later failures decline.

The bundle can have a causal effect as a bundle.

But:

```text
bundle effective
!= guardrail alone effective
```

unless evidence/discrimination supports component attribution.

Foundation implication:

> A causal contrast can target a composite intervention, but component-effect claims require additional causal separation rather than semantic decomposition by assertion.

## 9. Contamination / crossover changes the realized comparator

Comparator units may receive parts of the focal intervention through:
- shared policy;
- shared memory;
- human learning;
- shared infrastructure;
- copied configuration;
- agent-to-agent communication;
- routing changes.

Similarly treated units may not receive the focal mechanism.

Thus:

```text
assigned treatment groups
!= realized exposure groups
```

This connects directly to interference/spillover but does not yet promote a child.

## 10. Dynamic interventions require rule identity

Some interventions are policies rather than fixed states.

Example:

```text
if risk score > threshold:
    require human approval
else:
    allow automated execution
```

The intervention is not simply `approval = on`.

The causal object can be the **decision rule/policy regime** including:
- inputs used;
- thresholds;
- timing;
- exception handling;
- action mapping.

Comparing two dynamic regimes can therefore be meaningful even though individual units receive different actions.

## 11. Timing/order can define distinct interventions

Examples:

```text
review before execution
!= review after execution

rate limit before queue admission
!= rate limit after downstream load

patch before model upgrade
!= patch after model upgrade
```

Where timing changes causal pathways, it is part of intervention identity.

## 12. Intercurrent/post-assignment events should not be silently normalized away

After intervention starts, events may occur:
- discontinuation;
- rescue/override;
- fallback;
- migration;
- crossover;
- agent escalation;
- rollback;
- environment failure.

Different questions may legitimately ask:
- effect of the policy including such real-world events;
- effect under sustained adherence;
- effect if rescue/override were prevented;
- effect among a defined response stratum.

Foundation does not need one clinical-trial estimand framework.

It does need to prevent:

```text
post-intervention handling choice
from silently changing the causal question
```

## 13. Efficacy vs real-world effectiveness is a profile, not a child

A mechanism may work under controlled/ideal conditions but differ in actual environments because of:
- fidelity;
- operator behavior;
- resource constraints;
- heterogeneity;
- bypass;
- competing risks/workloads.

This can be expressed as different target contexts/intervention regimes:

```text
effect under ideal controlled C1
!= effect under operational target C2
```

No separate `Efficacy` child is needed unless dedicated research later shows an independent protected question beyond target/context semantics.

## 14. Non-manipulable exposure does not eliminate contrast semantics

Some causal questions concern characteristics/states not directly settable as one action.

Foundation-safe requirement:
- specify the alternative exposure/state/regime;
- clarify what is held fixed/allowed to vary where material;
- avoid bundling incompatible hypothetical changes under one label.

The question may remain meaningful even if no literal intervention can set the exposure atomically.

But if many incompatible ways of changing the exposure have different outcomes, a vague `effect of exposure X` can be ill-defined.

## 15. Agentic-software pressure case

Suppose after an incident the system introduces `permanent eval E` and later sees fewer failures.

Exact causal contrasts could include:

```text
A. policy/configuration includes E vs excludes E
B. E actually runs on every relevant change vs does not
C. E blocks release on failure vs only reports
D. E v2 challenge set vs E v1
E. incident-derived eval suite + new model vs old suite + old model
```

These effects need not be equal.

The Anthropic/gstack candidate pressure therefore supports:

```text
artifact/configuration presence
!= realized intervention exposure
!= causal effect
```

## 16. Provisional intervention grammar

When decision-critical:

```text
Intervention/regime specification
├─ focal policy/state/action/rule
├─ exact version/variant/intensity
├─ timing/duration
├─ target/eligibility/application rule
├─ realized delivery/exposure semantics
├─ adherence/traversal/fidelity where material
├─ co-interventions/bundle boundaries
├─ override/fallback/rescue semantics where material
└─ comparator defined at equivalent semantic resolution
```

Not every field is universally required; omission is safe only when it cannot materially change the causal question.

## 17. I2 conclusion

The active child must preserve the difference between **intended/assigned regime** and **realized causal exposure**.

This distinction is load-bearing but currently does not justify a separate immediate child. It behaves as a treatment/contrast identity and evidence-validity dimension inside one protected causal-effect question.

I3 must now attack whether confounding, selection, interference, heterogeneity and transportability are similarly cross-cutting dimensions or whether one of them forms a genuinely separate causal child.
