# Transition / Effect / Feedback — FINDINGS MAP

**Status:** bounded parent result / awaiting user evaluation  
**Date:** 2026-09-05

## Fast routes

| Question | Read |
|---|---|
| Shortest result / child map | `KEY.md` |
| Why the region exists / falsifiers | `T0-EVIDENCE-RECOVERY.md` |
| Minimum transition/effect grammar | `T1-MINIMUM-TRANSITION-EFFECT-SIGNATURE.md` |
| Why transition, causation and feedback differ | `T2-CHANGE-EFFECT-CAUSATION-FEEDBACK-DISCRIMINATION.md` |
| Time, propagation, revocation, invalidation | `T3-TEMPORAL-PROPAGATION-INVALIDATION.md` |
| Why three children beat rivals | `T4-RIVAL-INTERNAL-DECOMPOSITIONS.md` |
| External/candidate holdouts | `T5-EXTERNAL-CANDIDATE-HOLDOUTS.md` |
| Child-promotion synthesis | `T6-SYNTHESIS-CHILD-DECISION.md` |
| Final adversarial attack | `T7-ADVERSARIAL-CLOSURE.md` |
| Integrated result | `synthesis/TRANSITION-EFFECT-FEEDBACK-SYNTHESIS.md` |
| Residual/reopen triggers | `OPEN-QUESTIONS.md` |
| Exact freshness binding | `CURRENT-SURFACES.md` |

## Finding map

### F1 — Cross-ground routing boundary
Ground-local Domain/Information/Work/Actor dynamics remain in their accepted grounds. Cross-ground Transition applies only when removing other-ground anchors changes the protected temporal/effect question.

### F2 — Transition is not causal explanation

```text
state changed != known cause
A before B != A caused B
```

### F3 — Event representation is not event identity

```text
record/log/trace != actual occurrence by identity
```

### F4 — Time is multi-role where material

```text
occurrence != effective != observation/receipt != later reference time
```

Distributed systems may lack one intrinsic total order.

### F5 — Propagation can be partial/delayed
Central update/revocation/commit does not prove effective change at every dependent/enforcement point.

### F6 — Causal depth is multi-layered
Trigger, proximate cause, contributing condition, prevention failure, detection failure and systemic cause may all matter; one `root cause` is not universally sufficient.

### F7 — Observation is not feedback
Monitoring/reporting only becomes feedback when a return path influences later behavior/control/work/etc.

### F8 — Feedback is not adaptation
Fixed-loop response can use feedback without learning. Persistent adaptation requires durable change in future response-generating structure/behavior.

### F9 — Three immediate children survive

```text
Cross-Ground Transition / Propagation
Cross-Ground Causal Effect / Contribution
Cross-Ground Feedback / Adaptation
```

### F10 — No fourth child survives
Temporal alignment, observation, recovery, evolution, provenance, intended/realized/observed and control effectiveness remain dimensions/profiles or sibling/ground compositions.

## External pressure map

- W3C PROV → events/order/influence separation.
- Lamport → partial causal order versus total ordering.
- OpenTelemetry → occurrence versus observation timestamps.
- AWS/Google IAM → delayed/partial propagation of access changes.
- NASA/FAA/CDC → event sequence versus causal/root-cause analysis.
- NIST/FAA/WHO → monitoring/reporting versus feedback/continuous improvement.
- Anthropic candidate study → incident-to-permanent-eval/config/control adaptation loop.

## Current structural verdict

```text
Transition / Effect / Feedback
    ← boundedly complete as parent
    ← not leaf
    ← three immediate diagnostic children promoted
    ← user evaluation pending
```
