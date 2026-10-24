# Cross-Ground Feedback / Adaptation — F3 Delay / Staleness / Stability / Frame Audit

**Status:** COMPLETE  
**Date:** 2026-09-11

## Objective

Pressure-test feedback/adaptation semantics under delayed, stale, unstable, partial or misleading feedback without importing full control theory.

## 1. Feedback timing is semantically load-bearing

A returned signal can describe a state that is no longer current when consumed.

```text
outcome occurred at t1
observation formed at t2
consumer receives at t3
acts at t4
```

If the target changed materially between t1 and t4, a real feedback path can still exist while the feedback is stale for the action.

Thus:

```text
feedback occurred
!= feedback was timely/current enough
```

Currentness remains Standing-facing; the feedback relation remains true.

## 2. Delay can transform behavior without creating a new semantic region

Delayed feedback can cause:
- late correction;
- overshoot;
- oscillation;
- duplicated response;
- stale rollback;
- acting on already-resolved incidents.

These are consequences/effect profiles of the feedback loop, not a separate immediate child.

## 3. Negative versus positive feedback is effect behavior, not a universal taxonomy

A returned signal can damp deviation or amplify it.

Examples:
- error signal reduces deviation;
- popularity metric drives more exposure, which drives more popularity;
- alerting load increases operator load, which creates more failures/alerts.

The sign/behavior of the loop depends on the selected variable/objective and system dynamics.

Do not infer:

```text
feedback exists → stabilizing feedback
```

## 4. Feedback-loop existence does not establish stability

NASA adaptive-control material is a strong pressure case: adaptation/feedback mechanisms can require explicit stability/convergence analysis.

Foundation rule:

```text
feedback/adaptation occurred
!= stable
!= convergent
!= safe
```

Stability/safety are criterion-relative standings/effects, not children of Feedback by identity.

## 5. Proxy feedback can optimize the wrong thing

A system may successfully adapt to a measured proxy while degrading the intended outcome.

Examples:
- fewer reported incidents because reporting fell;
- faster task completion with lower semantic quality;
- fewer review findings because reviewer sensitivity degraded;
- agent optimizes eval suite rather than target behavior.

Thus:

```text
measured feedback objective improved
!= intended target outcome improved
```

Contrastive causal-effect and Standing semantics are required for benefit claims.

## 6. Local feedback can worsen wider-system outcomes

A local controller/actor/team can improve its own metric by shifting cost/risk elsewhere.

Examples:
- load shedding moves failure to another service;
- stricter local guardrail pushes risky work through another path;
- team reduces its incidents by transferring difficult cases;
- adaptive routing creates congestion elsewhere.

Therefore target/boundary identity matters:

```text
local loop objective improved
!= global/system objective improved
```

This is not a new child; it is a Binding/target/frame requirement plus causal-effect evaluation.

## 7. Frame blindness applies to feedback

A loop can only react to what enters its observation/exposure frame.

```text
all observed signals handled
!= all material outcomes observed
```

Missing sensors, hidden action paths, selective reporting, survivorship, dropped telemetry or excluded stakeholders can make the feedback loop systematically blind.

This mirrors accepted Transition and Actual-Causation frame guardrails.

## 8. Adaptation can entrench a bad frame

Persistent adaptation based on biased/partial feedback can make the system more confidently wrong.

Examples:
- optimize toward incomplete eval distribution;
- reinforce policy based on only reported incidents;
- learn from successful tasks while silent failures are absent;
- permanently route away from cases that expose weakness.

Thus:

```text
adaptation persisted
!= adaptation learned the right thing
```

## 9. Recursive adaptation remains adaptation

A system can change:
- ordinary action policy;
- the evaluator/feedback-selection process;
- the adaptation mechanism itself;
- criteria for which lessons become permanent.

This is recursive/self-modifying adaptation, but the protected question remains:

> Did prior feedback/history durably alter future response behavior?

No separate `Meta-Learning` child is forced at current depth.

## 10. Reversion and forgetting

A system can adapt and later lose the change through:
- rollback;
- model/version replacement;
- config regeneration;
- memory expiry;
- human turnover;
- later conflicting adaptation.

Therefore persistence is time-scoped:

```text
adaptation existed at t2
!= adaptation still holds at t3
```

Current adaptation standing must not be inferred from historical change alone.

## 11. Adaptation benefit requires causation, not chronology

```text
adaptation occurred
then outcomes improved
!= adaptation caused improvement
```

The accepted Contrastive Causal Effect child owns the causal comparison. Feedback/Adaptation owns whether the returned history changed future behavior.

## F3 conclusion

Delay, instability, proxy gaming, hidden outcomes, local/global divergence and recursive self-change are high-value dimensions/reopen pressures. None forces a third protected question.

The provisional two-child split survives:
- returned causal influence;
- persistent future-response change.