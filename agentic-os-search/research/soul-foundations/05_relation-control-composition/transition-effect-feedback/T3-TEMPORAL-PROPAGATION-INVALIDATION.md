# Transition / Effect / Feedback — T3 Temporal Alignment / Propagation / Invalidation Audit

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Objective

Test whether time/propagation/currentness needs a fourth immediate child, or whether it is a cross-cutting dimension primarily owned by Realized Transition / Propagation and consumed by Standing/Control.

## 2. No universal single transition time

Decision-critical systems can require separate times:

```text
change requested / commanded time
change committed time
occurrence time
local effective time
remote effective time
observation / receipt time
record creation time
assessment/reference time
```

Not every domain instantiates all of these.

Therefore time is a **semantic dimension**, not a universal child population.

## 3. Occurrence versus observation

OpenTelemetry event semantics explicitly distinguish event Timestamp (when the event occurred) from ObservedTimestamp (when it was observed/received).

Foundation pressure:

```text
occurred at t1
!= observed at t1
```

Consequences:
- delayed telemetry must not move the event itself forward in time;
- a late record can legitimately describe an earlier event;
- missing observation does not prove missing event;
- observation order can differ from occurrence order.

## 4. Distributed ordering

Lamport shows that distributed systems need not have one intrinsic total event order; causal `happened-before` is a partial order, while a total order may be constructed for coordination.

Foundation pressure:

```text
total ordered log
!= unique physical chronology
!= causal proof
```

Do not require one global clock model at Foundation level.

## 5. Propagation is a realized transition problem

A change at source does not imply simultaneous change at all dependents.

Potential states:

```text
issued
committed at source
queued / propagating
applied at endpoint A
not yet applied at endpoint B
superseded / failed at endpoint C
observed as applied
```

These are not implementation-mandated enums; they demonstrate that transition scope can be partial.

## 6. IAM revocation/change holdout

AWS IAM and Google Cloud IAM both document eventual propagation of access changes.

Material failure mode:

```text
role revoked centrally
!= role unusable everywhere immediately
```

AWS even accounts for propagation delay when revoking active sessions; Google documents that recently revoked access can temporarily remain usable and that nested/group changes can propagate differently.

Therefore:

```text
control change accepted/committed
!= control effective across governed-effect scope
```

This directly connects accepted Control semantics to Transition/Propagation.

## 7. Propagation completeness versus control completeness

Accepted Control discovered:

```text
governed-effect scope != enforcement-point scope
```

T3 adds temporal form:

```text
all intended enforcement points known
!= all points updated now
```

End-to-end control may therefore fail because of:
- alternate path;
- stale policy copy;
- stale credential/session;
- propagation lag;
- failed update;
- conflicting/superseding update;
- wrong dependency/version targeting.

The first is primarily Control coverage; the latter set are Transition/Propagation failures.

## 8. Standing invalidation semantics

Composite Standing already owns current qualification and validity dependencies.

Transition owns the change that pressures reuse.

Required distinction:

```text
dependency changed
→ prior standing may need re-evaluation
!= prior standing automatically false
```

Possible effects of a dependency change:
- standing remains true but prior assessment is stale;
- standing becomes false;
- criterion no longer applies;
- standing becomes unknown pending evaluation;
- one scope/version remains valid while another is invalidated.

Therefore Transition must communicate **what dependency changed and when/where it became effective**, while Standing determines the resulting current qualification.

## 9. Control invalidation semantics

Likewise:

```text
policy revised
!= old enforcement instantly gone
!= new control globally effective
```

Control owns governing semantics; Transition owns rollout/revocation/effectiveness propagation history.

## 10. Partial / failed / compensating transition

Foundation must permit:
- all-or-nothing transition;
- partial success;
- retry;
- compensation;
- rollback;
- recovery;
- eventual convergence;
- permanent divergence;
- transient state;
- side effects that survive rollback.

But these are transition patterns/dimensions, not universal children.

Work may own the retry/rollback/repair activities; Environment/Information own their local resulting states; Transition owns the cross-ground propagation/effect relation.

## 11. Propagation graph semantics

A chain such as:

```text
policy change
→ distribution
→ endpoint update
→ request decision
→ enforcement
→ environment effect
→ telemetry
```

must not imply every arrow has the same semantics.

Possible arrow meanings:
- ordering;
- data/control dependency;
- enabling condition;
- trigger;
- causal influence;
- representation/reporting;
- synchronization/propagation.

Relational Binding owns exact connection meaning; Transition consumes it temporally.

## 12. Does Time/Propagation require a fourth child?

Candidate:

```text
Temporal Alignment / Propagation
```

Rejected as a separate immediate child because:
- propagation is itself a form of realized transition across anchors;
- temporal alignment is required across all three candidate regions;
- causal analysis also needs temporal precedence/order;
- feedback loops also depend on delay/latency/staleness;
- no separate protected question remains once `Realized Transition / Propagation` owns actual change spread.

## 13. Updated structural hypothesis

T3 strengthens:

```text
Transition / Effect / Feedback
├─ Realized Transition / Propagation
├─ Causal Effect / Contribution
└─ Feedback / Adaptation
```

Cross-cutting dimensions:
- occurrence/effective/observation/reference time;
- delay/latency;
- version/scope;
- partiality/convergence;
- uncertainty/evidence.

T4 must now attack this three-child decomposition against rivals and boundary collapse.
