# Transition / Effect / Feedback — T2 Change / Effect / Causation / Feedback Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Core test

Can the following be collapsed without losing decision-critical meaning?

```text
occurrence / transition
realized effect
causal contribution
observation
feedback
adaptation / evolution
```

Result: **no**.

## 2. Occurrence / transition versus realized effect

A transition claim answers:

> What actually changed/unfolded, where, when and at what scope?

An effect claim adds a relation to an influencing action/event/process:

> What change or consequence resulted from this influence/intervention?

However not every observed later condition may safely be called an effect of the earlier event.

Required distinction:

```text
post-state differs from pre-state
!= earlier event caused the difference
```

Therefore realized transition is logically prior to causal-effect attribution.

## 3. Trigger versus cause

A trigger may initiate an episode without being a sufficient or deepest cause.

Example structure:

```text
trigger event
+ enabling conditions
+ missing prevention control
→ proximate failure
+ missing detection/containment
→ larger realized consequence
```

Required non-collapse:

```text
trigger != sufficient cause
proximate cause != complete causal explanation
```

This directly follows the project causal-depth protocol: a correct proximate cause may be insufficient if deeper enabling/prevention/detection/systemic conditions materially change recurrence risk or intervention choice.

## 4. Causal contribution does not require one root cause

A robust causal region must permit:
- direct/proximate causes;
- enabling/contributing conditions;
- necessary conditions;
- sufficient combinations;
- prevention failures;
- detection/containment failures;
- systemic/framing causes;
- multiple interacting causes;
- uncertain/competing causal explanations.

Foundation must not require one scalar `root_cause` field.

Strong rule:

```text
one identified cause
!= complete causal model
```

## 5. Temporal order versus causal order

Lamport's distributed-systems result supplies a decisive holdout:
- physical/wall-clock total order may be unavailable or observer-dependent;
- logical total order can be constructed;
- causal `happened-before` is a partial order.

Therefore:

```text
timestamp order
!= causal order
```

CDC epidemiology supplies an independent domain holdout:
- temporal precedence is necessary for many causal claims;
- association/statistical significance/temporality alone is not sufficient for causal inference.

Therefore:

```text
A before B
!= A caused B
```

## 6. Observation versus feedback

Observation produces or exposes Information about an occurrence/state.

Feedback requires that information or effect return into the system in a way that influences subsequent Work, Control, Actor behavior, Environment interaction or informational selection/derivation.

```text
observation
→ Information exists
```

is not yet:

```text
observation
→ interpreted/evaluated
→ later behavior/control/work changes
```

Hence:

```text
observation != feedback
```

## 7. Feedback versus response

A one-off response can consume observation without changing the system's future response structure.

Example:

```text
alert
→ operator manually restarts service
```

This can be feedback in the broad closed-loop sense for that episode, but it is not automatically adaptation/evolution.

Required distinction:

```text
feedback-informed response
!= persistent adaptation
```

## 8. Adaptation / evolution threshold

The strongest current cross-domain criterion is behavioral persistence:

> Did the returned information/effect cause a durable change to the system's future response policy, control, capability, procedure, model, configuration, Work formation or operating structure such that materially similar future situations are handled differently?

Possible examples:
- incident becomes permanent regression eval;
- control threshold/rule is revised and deployed;
- operating procedure is changed;
- model/system is retrained or self-updates;
- new deterministic guard is admitted;
- repeated failure causes architecture/capability change.

Negative examples:
- log written;
- dashboard updated;
- one alert acknowledged;
- one manual workaround executed;
- report produced but not consumed;
- lesson documented but no later behavior changes.

Therefore:

```text
lesson recorded != learned system
feedback available != feedback consumed
response occurred != adaptation
adaptation occurred != beneficial adaptation
```

## 9. Feedback can exist without learning

A classic closed-loop controller continuously feeds measurements into action while its control law remains unchanged.

Therefore:

```text
feedback loop != learning/adaptation
```

This prevents `Feedback / Adaptation` from collapsing into `Evolution only`.

The region must preserve at least:
- return-path closure;
- response influence;
- optional persistent response-rule/system change.

## 10. Candidate protected questions

### A. Realized Transition / Propagation

> What actually changed/unfolded, at which anchors/scopes/times, and how did that change propagate or fail to propagate across ground boundaries?

Distinct failure classes:
- record says change but no actual change;
- intended update only partially propagated;
- stale node/standing/control remains active;
- wrong time/reference alignment;
- transient versus persistent result confused.

### B. Causal Effect / Contribution

> Which event/action/condition/intervention caused, enabled, contributed to, prevented, amplified or failed to prevent/detect the realized effect, with what causal confidence/depth?

Distinct failure classes:
- sequence mistaken for causation;
- trigger mistaken for root/systemic cause;
- omitted contributing condition;
- post hoc attribution;
- control-effectiveness claim unsupported.

### C. Feedback / Adaptation

> Did observations/results/effects return into future system behavior, and did they merely influence one response or persistently change the response-generating system?

Distinct failure classes:
- telemetry mistaken for feedback;
- report not consumed;
- one-off repair called learning;
- adaptation asserted with no persistent change;
- changed system has no evidence of improved outcome.

## 11. Structural judgment after T2

All three candidate regions survive as **distinct diagnostic protected questions**.

They are allowed to overlap in one episode; they are not intended as mutually exclusive event populations.

Current strongest hypothesis:

```text
Transition / Effect / Feedback
├─ Realized Transition / Propagation
├─ Causal Effect / Contribution
└─ Feedback / Adaptation
```

T3 must test whether temporal/propagation semantics support this split or expose a fourth child.
