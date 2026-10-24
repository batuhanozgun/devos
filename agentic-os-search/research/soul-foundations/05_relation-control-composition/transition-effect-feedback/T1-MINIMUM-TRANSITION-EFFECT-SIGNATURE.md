# Transition / Effect / Feedback — T1 Minimum Transition / Effect Signature

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Question

What minimum semantics must survive before a cross-ground claim such as `changed`, `took effect`, `caused`, `propagated`, `invalidated`, `fed back` or `adapted` can be decision-safe?

## 2. First correction — there is no one universal `event` object

Candidate cases include:
- discrete event;
- interval/duration process;
- continuous trajectory;
- threshold crossing;
- gradual propagation;
- administrative effective-time change;
- delayed observation;
- institutional decision that creates a standing;
- physical effect;
- informational transformation;
- Work execution/recovery;
- feedback cycle.

Foundation must not require all dynamics to be represented as instantaneous events.

## 3. Minimum cross-ground transition signature

Strongest reusable core:

```text
Cross-ground transition/effect claim
├─ protected change/effect question
├─ exact focus / affected anchors
│  └─ accepted Binding instances and roles where needed
├─ transition/change identity
│  ├─ what aspect is claimed to differ/unfold
│  └─ boundary/resolution at which the change is meaningful
├─ temporal/reference frame
│  ├─ occurrence/interval ordering
│  ├─ effective/reference time where material
│  └─ observation/receipt time kept separate where material
├─ realized-state/effect semantics
│  ├─ before/baseline or prior condition where required
│  └─ after/result/trajectory where required
├─ propagation/dependency scope where material
└─ validity/currentness dependencies
```

This core is about **what changed/unfolded and where/when it became materially effective**.

## 4. Not universally required in the minimum core

The following are load-bearing in some claims but not all transition claims:

### Intention / target

A natural process may have no intended outcome. Therefore `intended effect` is not mandatory.

Where intention exists:

```text
intended / commanded / planned effect
!= realized effect
```

### Actor/authority

Physical or informational transitions may occur without an institutional Actor/authority question. Actor semantics are optional unless attribution/decision/control is material.

### Causal attribution

One can truthfully describe:

```text
state A at t1
state B at t2
```

without knowing why the change occurred.

Therefore:

```text
transition/change claim != causal claim
```

### Observation / evidence

A transition can occur without being observed. A log can report a transition that did not occur.

Therefore:

```text
actual transition != observation/record of transition
```

### Feedback

A transition may be purely forward with no return path into later behavior.

Therefore feedback is not mandatory in the transition core.

## 5. Time distinctions

No universal single time field survives.

Decision-critical cases may distinguish:

```text
occurrence time
!= effective time
!= observation / receipt time
!= record creation time
!= reference time of a later claim
```

Examples:
- a policy is approved at t1 but effective at t2;
- a physical fault occurs at t1 and is observed at t3;
- a distributed revocation is issued at t1 but different enforcement points apply it at different times;
- an event log is written after the event;
- a standing evaluated at t4 may refer to state at t2.

Lamport supplies a stronger distributed warning:

```text
wall-clock / total ordering != causal order
```

The Foundation need not choose a clock model, but it must not collapse these semantics when the difference changes conclusions.

## 6. Realized effect semantics

A transition claim must distinguish at least the possibility of:
- no effect;
- partial effect;
- delayed effect;
- indirect effect;
- transient effect;
- persistent effect;
- compensating/reversed effect;
- unintended side effect;
- effect at one scope but not another.

This is a semantic possibility set, not a required implementation enum.

Strong rules:

```text
Work/action occurred
!= intended effect achieved
!= target state realized
!= effect persisted
!= accepted outcome
```

## 7. Propagation semantics

A cross-ground transition often has more than one step:

```text
Information change
→ decision/Work
→ Control change
→ Environment effect
→ observation
→ new Information
```

But an arrow in such a diagram is only a **candidate influence/transition relation** until its meaning is specified.

Preserve where material:
- source and affected anchor;
- intermediate steps;
- delay;
- partial/failing branches;
- dependency/version scope;
- whether the relation is ordering, enabling, triggering, causal or merely representational.

## 8. Boundary with accepted siblings

### Binding
Binding says which anchors/roles are connected; T1 says what changed/effected over time.

### Standing
Standing says what qualification currently holds; T1 says which change made a prior result stale/invalid/re-evaluable or produced a new basis.

### Control
Control says how behavior/transition is governed; T1 says what actually happened, propagated or took effect.

## 9. Structural implication

T1 weakens a one-leaf hypothesis.

The minimum transition/change core does **not** require:
- causal attribution;
- feedback;
- adaptation/evolution.

Those questions remain optional but decision-critical and generate distinct failure modes.

Entering T2, the strongest candidate is therefore:

```text
Transition / Effect / Feedback
├─ Realized Transition / Propagation
├─ Causal Effect / Contribution
└─ Feedback / Adaptation
```

Still provisional; no child is promoted yet.
