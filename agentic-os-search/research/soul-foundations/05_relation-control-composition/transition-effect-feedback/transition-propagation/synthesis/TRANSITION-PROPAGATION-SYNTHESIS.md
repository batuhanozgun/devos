# Cross-Ground Transition / Propagation — Integrated Synthesis

**Status:** bounded synthesis / awaiting user evaluation  
**Date:** 2026-09-06

## Executive result

`Cross-Ground Transition / Propagation` is a coherent, load-bearing composition region and closes as a **bounded leaf** at current Foundation depth.

```text
Cross-Ground Transition / Propagation
    ← BOUNDED LEAF
    ← no immediate child promoted
```

It answers:

> **What exact change actually became real/effective across accepted-ground boundaries, for which anchors/scopes/times, through which applicable dependencies, and how fully did it propagate or fail to propagate?**

It does **not** answer by identity:
- what change was requested/planned;
- whether a policy/control was valid;
- whether a standing criterion is satisfied;
- why the effect occurred;
- whether an observation caused learning/adaptation;
- whether an event record is true.

## 1. Boundary with ground-local dynamics

Environment already owns Domain Dynamics. Information owns Informational Dynamics. Work owns pursuit/execution evolution. Actors owns participation/authority/delegation changes within its semantic region.

Therefore:

```text
ground-local dynamics
!= cross-ground Transition / Propagation
```

Use this child only when other-ground anchors/relations are constitutive of the protected change/propagation question.

Semantic-removal test:

> If other-ground anchors/relations were removed while preserving the local bearer/process, would the protected change question retain the same meaning?

If yes, keep the case ground-local. If no, cross-ground composition is load-bearing.

## 2. No universal transition lifecycle

A software-shaped sequence such as:

```text
requested → committed → realized → propagated → observed
```

is not Foundation-universal.

Different domains may have:
- no request;
- no authoritative commit;
- gradual/continuous change;
- multiple origins;
- staged legal/institutional effectiveness;
- local effects at different times;
- observations arriving later/out of order.

What is universal is weaker and more semantic:

```text
change intended/defined/approved/recorded
!= change actually realized
!= change effective for every applicable scope
!= realization observed/verified
```

## 3. Stable semantic core

A decision-critical cross-ground transition claim should preserve, when material:

1. **Exact changed focus** — exact target/version/scope/bearer and Binding instance.
2. **Transition/change identity** — what semantic fact became different.
3. **Reference/baseline or trajectory frame** — enough to state the material realized change without assuming discrete before/after points.
4. **Realized scope** — where/for whom/for which target/context the change became effective.
5. **Temporal/reference semantics** — occurrence/effective/reference/order distinctions when they change the conclusion.
6. **Propagation/dependency semantics** — which applicable dependent scopes actually changed, remained stale, diverged or were superseded.
7. **Partiality/persistence/reversibility semantics** — when material.
8. **Validity-dependency consequences** — enough identity to trigger correct Standing/Control re-evaluation routing.
9. **Observation/evidence separation** — records and observations are not the actual transition by identity.

This is a semantic grammar, not a schema.

## 4. Propagation is not replication

A major correction is:

```text
propagation != data replication
```

A cross-ground transition can propagate through:
- policy/control distribution;
- dependency re-evaluation;
- authority or role changes;
- Work initiation/selection;
- Environment effects;
- Information exposure;
- institutional effective-date semantics;
- derived standing changes;
- physical or organizational effects.

The specific relation meaning comes from Binding and local-ground semantics.

## 5. Propagation episode versus one giant event

A higher-level change can contain several semantically different transition instances:

```text
policy changes
→ enforcement point changes
→ request-decision behavior changes
→ Environment action/effect changes
→ telemetry/Information changes
```

Flattening these into one event loses:
- transition identity;
- local ground ownership;
- different effective times;
- partial failure points;
- distinct evidence;
- path-specific semantics.

Better conceptual structure:

```text
Transition A
  --typed relation-->
Transition B
  --typed relation-->
Transition C
```

with an optional propagation episode grouping them for one protected question.

No graph/event implementation is implied.

## 6. Applicable scope versus realized scope

A central distinction:

```text
applicable / intended propagation scope
!= realized propagation scope
```

Examples:
- a policy applies to ten enforcement points but only eight updated;
- a rule is published but not yet effective for the relevant population;
- an authority revocation is active centrally while old sessions remain usable;
- a Work change is complete in repository state but Environment state has not changed;
- an Information update is available at source but not exposed to all relevant consumers.

Transition owns realized changes. The criterion for `complete`, `fully propagated`, `converged`, `restored` or `acceptable` is Standing-facing.

## 7. Convergence is not a universal child

Convergence can be crucial in distributed systems but is not universally desired.

Correct propagation can intentionally produce heterogeneous target states.

Therefore the general question is not:

> Are all states identical?

but:

> Did every applicable scope realize the transition semantics required for it?

A claim such as `fully propagated` usually has the form:

```text
realized transition facts
+ applicable-scope criterion
+ reference time
→ Composite Standing
```

No separate Convergence child is justified.

## 8. Time is plural when material

Potentially distinct times include:
- request/decision time;
- occurrence time;
- local effective time;
- remote effective time;
- observation/receipt time;
- record creation time;
- reference/evaluation time.

No domain must instantiate all of these.

Required rule:

```text
occurrence time
!= observation time
!= effective time everywhere
```

A single global clock or total ordering is not a Foundation requirement.

## 9. Partiality and divergence

Partiality can mean different things:
- partial applicable scope;
- partial progress along a trajectory;
- partial side-effect realization;
- partial rollback/restoration;
- partial evidence coverage.

Divergence can be:
- intended;
- temporary propagation lag;
- stale/failed update;
- conflicting/superseded change;
- scoped exception;
- observation mismatch.

Thus:

```text
divergence != failure by identity
```

Correctness requires the applicable criterion.

## 10. Invalidation and currentness

Transition owns the fact that a validity dependency changed and when/where it became effective.

It does not directly decide the downstream Standing/Control consequence.

```text
validity dependency changed
→ previous result may require re-evaluation
!= object-level Standing automatically false
```

Possible downstream results include:
- stale assessment;
- unchanged standing;
- false standing;
- unknown pending evaluation;
- criterion not applicable;
- changed control applicability.

This preserves Standing/Control boundaries.

## 11. Retry, rollback, compensation and reconciliation

### Retry
Retry is Work. Successful realized result is Transition.

```text
retry attempted != target changed
```

### Rollback
Rollback is Work intended to restore some prior property/state; its actual result is a new transition episode.

```text
rollback != time reversal
value restored != history/effects erased
```

### Compensation
Compensation offsets or makes acceptable a prior effect; it is not literal reversal.

```text
original transition
+ compensating Work
→ compensating transition
→ new current state/standing
```

### Reconciliation
Reconciliation is Work that detects/repairs divergence. Running it does not prove reconciled reality.

```text
reconciliation ran != reconciled
```

Restoration/convergence/acceptability is Standing-facing.

## 12. Residual side effects

A local rollback can leave:
- durable records;
- external messages/actions;
- changed Actor knowledge/authority/responsibility;
- changed Work history/commitments;
- irreversible Environment effects;
- resource/time/cost consumption;
- downstream transitions already propagated.

Therefore `restored` requires exact criterion and scope.

## 13. Observation/evidence boundary

OpenTelemetry independently pressures the distinction between occurrence time and observed time.

Foundation-level rule:

```text
transition record != actual transition
observation received != event newly occurred
```

Unknown/missing observation cannot prove missing change.

## 14. External holdout synthesis

### AWS IAM
Changes can take time to become visible across endpoints; propagation should be verified before relying on it.

### Google Cloud IAM
Access-change propagation time depends on the path/mechanism and recent revocations can remain effective temporarily.

### NASA Configuration Management
Approved changes are followed by incorporation and verification of implementation; status accounting tracks change from initiation to implementation.

### Federal Register institutional rule example
Publication, effective date and implementation/compliance timing can be distinct.

### OpenTelemetry
Occurrence and observation timestamps are distinct.

### W3C PROV
Generation/invalidation/activity semantics pressure exact event/entity lifetime identity without requiring a universal transition lifecycle.

Together these holdouts show that the shared grammar is not reducible to distributed state replication.

## 15. Frame-blindness consequence

A subtle but important result:

```text
all known targets updated
!= all materially applicable targets known
!= full propagation established
```

A system can correctly verify every target in its current frame and still miss a relevant path, consumer, session, enforcement point, Actor population or scope.

Therefore completeness claims require both:
- realized transition evidence;
- adequate applicable-scope discovery.

If scope coverage is not established, the correct result may be `unknown/not fully evaluated`.

## 16. Boundary with Causal Effect / Contribution

Transition can state:
- A changed;
- B later changed;
- a dependency/path connects them;
- both changes realized at given scopes/times.

It cannot by identity conclude:

```text
A caused B
```

Causal attribution remains the next sibling problem.

## 17. Boundary with Feedback / Adaptation

Transition can establish the forward change/result and later return-path transitions.

Feedback asks whether those results were consumed to alter later behavior/system structure; adaptation asks whether the response-generating system changed persistently.

## 18. Immediate-child decision

No tested split survives:
- Realization / Propagation / Convergence;
- Transition Identity / Scope / Recovery;
- Requested / Realized / Observed;
- Atomic / Partial / Compensated;
- Forward / Reconciliation;
- Local / Cross-Ground / Systemic;
- Source / Dependency / Target;
- Transition / Invalidation;
- Materialized / Derived;
- Discrete / Continuous.

Result:

```text
Cross-Ground Transition / Propagation
    ← BOUNDED LEAF
```

## 19. Verification boundary

This synthesis is supported by:
- accepted repository research;
- targeted authoritative external holdouts;
- same-model adversarial P7 review.

It is not independently replicated by a second researcher/model and no external source publishes this exact Foundation result.

## 20. Next sequencing recommendation

If the user accepts this leaf result:

> **Cross-Ground Causal Effect / Contribution** is the strongest next Transition-parent child.

Reason: the realized effect identity and propagation semantics it requires are now available; causal correctness also provides useful prior structure before later Feedback/Adaptation effectiveness and learning claims.

This recommendation does not activate the child.
