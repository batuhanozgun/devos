# Cross-Ground Transition / Propagation — P2 Realization / Propagation / Temporal-State Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Test whether request/commit/realization/propagation/effectiveness/observation form a universal lifecycle or stable child hierarchy, and clarify the semantic unit of a propagation claim.

## 2. No universal lifecycle

The following labels recur but belong to different semantic owners and are not universally instantiated:

```text
requested / intended
admitted / authorized
committed / issued
initiated
realized
propagated
observed
recorded
accepted
```

Possible ownership pressure:
- request/intention → Information / Actors / Work;
- admission/authorization → Work / Actors / Control;
- `commit`/issue → domain-specific Work/Information/Control event;
- realization → actual ground-local or cross-ground Transition;
- observation/record → Information Dynamics/State;
- accepted → Standing / Actors / Control depending exact meaning.

Therefore a universal stage model would mix grounds and composition regions.

## 3. Realization is the transition anchor

The child asks about **actual realized difference/unfolding**, not merely the request or representation of change.

```text
request exists
!= realization exists

command succeeded
!= target reality changed as intended
```

In cross-ground cases, realization is judged at exact affected anchors/scopes rather than inferred from initiating Work success.

## 4. Propagation is often an episode, not one giant transition

Important correction:

A chain such as:

```text
policy representation changes
→ endpoint policy state changes
→ request decision changes
→ enforcement behavior changes
→ Environment effect changes
→ telemetry changes
```

should not automatically be represented conceptually as one transition.

A safer semantic view is:

```text
Transition instance A
  --typed dependency/propagation relation-->
Transition instance B
  --typed relation-->
Transition instance C
...
```

with an optional higher-level **propagation episode** grouping them for one protected question.

This preserves:
- exact transition identity;
- different effective times;
- different failure points;
- different ground ownership of local changes;
- non-uniform edge semantics.

No event-sourcing or graph architecture is implied.

## 5. Propagation does not mean identical state copying

Propagation can mean that one realized change makes another change relevant/required/possible/effective through typed dependencies.

Examples:
- policy update → enforcement behavior update;
- authority revocation → eligibility/authorization re-evaluation;
- Information update → different Work selection;
- Work execution → Environment effect;
- Environment change → prior evidence/standing becomes stale;
- control change → different future action path.

Therefore:

```text
propagation != replication
```

and:

```text
source state == endpoint state
```

is not a universal success criterion.

## 6. Expected scope versus realized scope

A propagation question can require two distinct sets/frames:

- **expected/intended/applicable propagation scope** — where the change is supposed/eligible to matter;
- **realized propagation scope** — where relevant change actually became effective.

These are not identical.

The first can depend on Binding/Control/Work/criteria; the second is Transition-owned realized outcome.

```text
intended scope != realized scope
```

## 7. `Fully propagated` is usually a Standing, not a transition primitive

A claim such as:

> all required enforcement points now use policy v2

is a qualification over:
- the applicable scope;
- exact transition/endpoint states;
- current time/reference;
- possibly evidence/assessment.

Therefore it often has the form:

```text
realized transition facts
+ applicable scope criterion
→ propagation/convergence standing
```

This is primarily Composite Standing over Transition facts.

Transition owns the realized per-scope changes; Standing owns whether a completeness/convergence criterion currently holds.

Thus:

```text
propagation episode exists
!= fully propagated standing holds
```

## 8. `Effective` is overloaded

`Effective` can mean materially different things:
- legally/institutionally in force;
- technically applied at one endpoint;
- behaviorally governing a request;
- causally producing intended result;
- visible/recognized by observers.

Foundation must not use one undifferentiated `effective` state.

When material, bind the exact meaning:

```text
effective-for-what / where / whom / which operation / which time?
```

Causal effectiveness belongs to sibling Causal Effect/Contribution, not this child by identity.

## 9. Occurrence, effectiveness and observation can diverge

A transition can:
- occur before observation;
- be recorded after occurrence;
- become institutionally effective at a future date;
- become technically effective at different endpoints at different times;
- be observed out of order;
- be transient and disappear before observation.

Therefore no single `transition_time` is universally sufficient.

## 10. Propagation path versus causal path

A propagation/dependency sequence is not automatically a causal proof.

```text
A transition precedes B transition
B is bound/dependent on A
!= A proved to have caused B
```

Transition / Propagation can establish realized sequence/scope/dependency facts while causal attribution remains deferred to the sibling Causal Effect/Contribution child.

## 11. Invalidation is pressure, not automatic state mutation

If a dependency changes:

```text
transition fact: dependency D changed at scope/time S
```

then downstream effects may include:
- assessment stale;
- standing false;
- standing unchanged;
- standing unknown pending re-evaluation;
- control applicability changed;
- no material consequence.

Transition should not decide these by identity.

## 12. Child-candidate test

### Candidate A — Realization

Rejected provisionally as separate child.

Without realized change there is no Transition/Propagation question at all; realization is the semantic core, not an independent sibling population.

### Candidate B — Propagation

Rejected provisionally as separate child.

Cross-ground transition is already defined by how realized changes span/affect ground boundaries. Propagation is the central cross-ground shape, not a separable peer to realization.

### Candidate C — Convergence

Rejected provisionally as child because convergence/full propagation is primarily a scope-relative Standing over realized transition facts and can be absent as an objective.

### Candidate D — Temporal state

Rejected provisionally as child because time/order/effective intervals cross all transition cases and do not define a separate protected population.

## 13. P2 provisional result

The child remains coherent as one region.

Current model:

```text
exact local/cross-ground transition instances
+ typed Binding/dependency relations
+ realized scope/time
→ propagation episode semantics

propagation facts + scope/criterion
→ possible Composite Standing such as converged / fully propagated
```

Proceed to P3 to test partiality, failed transitions, rollback/compensation/reconciliation and invalidation pressure, which remain the strongest possible reasons for an internal split.
