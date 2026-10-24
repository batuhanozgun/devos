# Environment Finding 04 — Realized State, Dynamics and Observability

**Status:** current Environment-ground finding

## Central result

Environment analysis must distinguish **actual realized conditions** from every specification, observation or model of those conditions.

This distinction generalizes across both first-order roles.

```text
actual Environment state/conditions
        ≠ specified/assumed operating envelope
        ≠ observed/measured state
        ≠ inferred/modelled state
        ≠ persistent Record about state
```

The latter four are representation questions even when they are indispensable for reasoning about Environment.

## Evidence convergence

### Technical Work Environment

The completed TWE pass independently required separation of:
- declared/intended state;
- discovered/observed state;
- actual realized state.

It also found profile/manifest optional for environment existence.

### Operating-world research

The archived pass independently required:
- world/process state;
- observation/measurement;
- belief/model;
- Record
as separable when material.

### Operational Design Domain

ISO 34503 defines an ODD as specified conditions under which an automated driving system is designed to function. This is an operating-envelope specification. The actual road/weather/traffic state can satisfy, violate or be uncertain relative to that specification.

Therefore:

> **specified Environment ≠ realized Environment**

is a domain-general rule, not a software-only configuration distinction.

## Environment is dynamic

A static snapshot is insufficient whenever load-bearing conditions can change during Work.

Relevant change forms include:
- exogenous state transitions;
- disturbances and shocks;
- resource/capacity changes;
- support degradation/recovery;
- movement and spatial change;
- other systems' actions;
- institutional/regulatory state changes;
- Work-caused effects;
- delayed effects and path dependence.

The same focal Work can encounter materially different feasibility/outcome conditions without changing its own intended lifecycle description.

## History/path dependence

Current state may be insufficient to explain present possibilities when prior environmental transitions leave persistent physical, technical, institutional or resource effects.

Examples:
- prior overload creates thermal degradation;
- earlier contamination affects a specimen;
- previous market transaction changes liquidity;
- earlier configuration/provisioning changes current support state;
- prior physical damage changes safe action possibilities.

This does not make Environment a Record/history store. It means environmental dynamics can have stateful consequences; representations of that history belong elsewhere.

## Observability is bounded and purpose-relative

No requirement exists to model or observe the whole world.

A load-bearing Environment analysis asks:
- which actual conditions can affect the protected Work/outcome;
- which are observable, inferable or controllable;
- what latency/noise/coverage limitations exist;
- which conditions remain hidden or only statistically characterized;
- which assumptions are being used in place of observation.

POMDP/control traditions reinforce true-state versus observation/model separation. Health checks and telemetry in TWE provide the same failure pattern at technical-support scale.

## Failure surfaces

Environment-specific failures include:
- omitted load-bearing condition;
- stale or wrong assumed operating envelope;
- hidden state change;
- unmodelled disturbance/dynamic;
- observation latency/noise/coverage gap;
- mistaking observed/declared health for actual condition;
- treating a represented constraint as proof that the realized condition is satisfied.

## Result

**Realized state + dynamics + imperfect observability** is a parent-level Environment semantic, not merely a property of Operating World or TWE.

Representation of Environment is cross-ground; Environment itself is the realized condition/process side of that distinction.