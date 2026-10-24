# Cross-Ground Transition / Propagation — FINDINGS MAP

**Status:** current bounded result router  
**Date:** 2026-09-06

## Fast retrieval

| Question | Read first | Then |
|---|---|---|
| What is the result? | `KEY.md` | synthesis → P7 |
| Why is this cross-ground rather than Domain Dynamics? | P0 → P1 | P7 §6 |
| What is the minimum semantic signature? | P1 | synthesis |
| Why no universal request/commit/realize/observe lifecycle? | P1 → P2 | P5 |
| What exactly is propagation? | P2 | P6 |
| Why isn't convergence a child? | P2 → P4 | P7 §3 |
| How are partiality/divergence handled? | P3 | P6 |
| How are rollback/compensation/reconciliation separated? | P3 | P7 §5 |
| How is invalidation routed? | P3 | P7 §4 |
| What did external holdouts show? | P5 | synthesis |
| Why bounded leaf? | P6 | P7 |
| What would reopen it? | `OPEN-QUESTIONS.md` | targeted pass |

## Core findings

### F1 — Realization cannot be inferred from change intent/approval/record

```text
requested / approved / committed / recorded
!= realized
```

Source: P1, P2, P5, P7.

### F2 — Cross-ground propagation is broader than replicated state

Propagation can occur through typed dependencies among Information, Work, Actors, Control, Standing and Environment changes.

```text
propagation != data replication
```

Source: P1, P2, P5.

### F3 — Propagation can be a multi-transition episode

Do not flatten a path of semantically distinct local transitions into one event merely because they belong to one higher-level change episode.

Source: P2, P6.

### F4 — Applicable scope and realized scope must be separable

```text
intended/applicable scope != realized propagation scope
```

Source: P2, P3, P5.

### F5 — `Fully propagated / converged` is usually Standing-facing

Transition supplies realized facts; a scope/criterion determines whether completeness/convergence currently holds.

Source: P2, P3, P4, P7.

### F6 — Time is plural when material

Occurrence, effective, observation, record and reference times can diverge. No single global clock model is required.

Source: P1, P2, P5.

### F7 — Partiality is multi-dimensional

Partial scope, partial trajectory, partial side-effect realization and partial evidence are different failure modes.

Source: P3.

### F8 — Recovery attempts are not successful restoration by identity

```text
retry Work != successful result
rollback != time reversal
compensation != reversal
reconciliation ran != reconciled
```

Source: P3, P7.

### F9 — Dependency change pressures re-evaluation but does not set Standing truth

```text
validity dependency changed
→ previous result may be stale / require re-evaluation
!= object-level Standing automatically false
```

Source: P1, P2, P3, P7.

### F10 — Observation is not occurrence

```text
change realized != change observed/recorded
```

External pressure: OpenTelemetry; internal boundary: Information source/view discipline.

Source: P1, P5.

### F11 — Propagation path is not causal proof

Typed dependency/order/propagation relations can establish a realized episode without proving why the effect occurred.

Source: P2, P7.

### F12 — Frame blindness applies to propagation completeness

```text
all known targets updated
!= all materially applicable targets known
!= full propagation established
```

Source: P7.

## Immediate-child decision

No tested child split survives:
- Realization / Propagation / Convergence;
- Change Identity / Scope / Recovery;
- Requested / Realized / Observed;
- Atomic / Partial / Compensated;
- Forward / Reconciliation;
- Transition / Invalidation;
- Materialized / Derived;
- State Jump / Continuous Trajectory.

Decision:

```text
Cross-Ground Transition / Propagation
    ← BOUNDED LEAF
```

## Next frontier

If accepted, re-selected next sibling:

> `Cross-Ground Causal Effect / Contribution`

Rationale and adversarial comparison: P6 §12 and P7 §15.
