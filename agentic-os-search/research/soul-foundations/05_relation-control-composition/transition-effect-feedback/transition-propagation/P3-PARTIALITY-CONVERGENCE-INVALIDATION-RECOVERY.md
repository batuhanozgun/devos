# Cross-Ground Transition / Propagation — P3 Partiality / Convergence / Invalidation / Recovery Audit

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Test whether partiality/convergence, invalidation, rollback/compensation or reconciliation require immediate children, and preserve Work/Standing/Control boundaries.

## 2. Partiality has several meanings

`Partial transition` is not one universal state.

It may mean:
- only part of the applicable scope changed;
- one target changed incompletely;
- continuous transition has progressed but not reached a criterion;
- some downstream dependents updated while others did not;
- transition occurred but some intended side effects did not;
- rollback/recovery restored only part of prior conditions;
- evidence covers only part of actual realization.

Therefore partiality requires exact semantics rather than one boolean.

## 3. Realized scope versus completeness criterion

Transition owns facts such as:

```text
endpoint A changed
endpoint B did not
endpoint C changed then reverted
```

Whether this is `complete`, `acceptable`, `converged` or `failed` depends on a criterion/scope and is generally Standing-facing.

```text
partial realized scope
+ applicable completeness criterion
→ completeness/convergence Standing
```

## 4. Convergence is not universally required

A common distributed-system assumption is that all relevant copies should converge to one state.

This is not universal because:
- scopes may intentionally receive different configurations;
- institutional changes may apply to different populations at different dates;
- physical systems may settle into heterogeneous states;
- Work/Actor roles can change asymmetrically by design;
- derived standings need not materialize identically everywhere.

Therefore:

```text
same final state everywhere
!= universal propagation success criterion
```

The more general question is:

> Did every applicable target/scope realize the transition semantics required for it?

That again produces a Standing over transition facts rather than a universal convergence child.

## 5. Persistent divergence can be correct or erroneous

Divergence is not failure by identity.

It can be:
- intentional scope difference;
- temporary propagation delay;
- stale/failed application;
- conflicting update;
- superseded update;
- partitioned or unreachable target;
- local exception/waiver;
- observation/evidence mismatch.

Transition records realized divergence and its scope/time; Control/Standing determine whether it is acceptable/applicable.

## 6. Invalidation boundary

A transition can invalidate the **basis for reuse** of a previous assessment or control decision without directly setting its object-level truth value.

Examples:
- exact target version changed;
- criterion changed;
- authority scope changed;
- Environment precondition changed;
- policy version changed;
- evidence source changed.

Required distinction:

```text
validity dependency changed
→ previous result may no longer be reusable as current evidence/assessment
!= underlying standing necessarily false
```

Thus:
- Transition owns `dependency changed when/where`;
- Standing owns resulting qualification/currentness;
- Control owns resulting governing applicability/decision semantics;
- Information owns records/evidence about those changes.

No independent Invalidation child is forced.

## 7. Supersession and conflicting transitions

Several changes can compete over the same focus.

Foundation must permit:
- later update supersedes earlier update;
- updates apply to different scopes;
- concurrent changes conflict;
- one target applies A then B while another sees B only;
- a later observation describes an earlier state;
- a transition is cancelled before some scopes realize it.

Precedence/conflict rules belong to Control/Binding where normative/semantic ordering is defined; Transition owns which changes actually realized and in what scope/order.

## 8. Retry is Work; retry success is Transition

```text
retry attempted
!= target changed
```

Retry/re-execution is Work.

Each successful/failed attempt can cause or fail to cause new realized transition facts.

A retry policy is Control.

A claim that the system is now restored/converged is Standing over current facts.

## 9. Rollback is not time reversal

A rollback is usually:
- Work intended to restore some prior property/state;
- followed by one or more new realized transitions.

It need not erase:
- history/audit records;
- external messages/actions;
- Actor knowledge/standing changes;
- downstream Environment effects;
- irreversible physical/institutional effects;
- independently propagated copies.

Therefore:

```text
rollback Work succeeded locally
!= prior cross-ground reality restored
```

and:

```text
value restored
!= transition history erased
```

Whether restoration is sufficient is criterion-relative Standing.

## 10. Compensation is not rollback

Compensation introduces a new action/effect intended to offset, neutralize or make acceptable a prior effect.

Examples:
- refund after charge rather than erasing charge history;
- corrective Work after irreversible production action;
- counteracting physical process;
- institutional remedy after an already-effective decision.

Thus:

```text
compensation
!= literal reversal
```

Conceptually:

```text
original transition episode
+ compensating Work
→ compensating transition episode
→ new current state/standing
```

No separate Compensation child is required at current depth.

## 11. Reconciliation is Work; reconciled reality is a result/Standing

Reconciliation can include:
- compare intended/current states;
- detect divergence;
- select repair actions;
- retry/update targets;
- verify current result.

These are Work/Information/Control activities.

Transition owns the realized changes produced by reconciliation.

Standing owns whether the applicable consistency/restoration criterion now holds.

```text
reconciliation ran
!= reconciled
```

## 12. Residual effects matter

A transition can be partly reversed while leaving decision-critical residues.

Potential residuals:
- durable Information/Records;
- external side effects;
- changed Actor knowledge/authority/responsibility;
- changed Work commitments/history;
- changed Environment resources/conditions;
- consumed quota/time/cost;
- downstream transitions already propagated.

Therefore restoration claims must bind to exact criteria and scope.

## 13. Candidate-child test

### Partiality / Convergence
Not promoted. It is a transition dimension plus Standing over applicable scope/criteria.

### Invalidation
Not promoted. It is a downstream consequence of dependency transitions whose current qualification belongs to Standing/Control.

### Recovery / Rollback / Compensation
Not promoted. Recovery activity is Work; realized recovery/compensation consists of further transition episodes; restoration/acceptability is Standing.

### Reconciliation
Not promoted. Reconciliation is Work/control/evidence around transition facts; successful convergence/restoration is not established by running it.

## 14. P3 result

The strongest internal-split pressures currently fail.

The child appears to require one semantic region with cross-cutting profiles/dimensions:
- partiality;
- propagation scope;
- convergence/divergence;
- persistence/reversibility;
- supersession/conflict;
- rollback/compensation;
- invalidation/currentness pressure.

Proceed to P4 to compare this bounded-leaf hypothesis against rival decompositions and the possibility that `Propagation / Convergence` deserves a separate child after all.
