# Cross-Ground Transition / Propagation — P1 Minimum Transition Signature

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Derive the minimum semantic content required to make a cross-ground transition/propagation claim decision-safe, while rejecting software/distributed-system lifecycle stages that are not universal.

## 2. First correction — `commit` is not universal

A tempting lifecycle is:

```text
requested → committed → realized → propagated → observed
```

This is useful in many software/institutional systems but cannot be universal because:
- physical/environmental changes may be emergent and unrequested;
- social/institutional changes may become effective through several distinct legal/organizational acts;
- Work can produce gradual rather than discrete effects;
- Information visibility can change without a source `commit` event;
- some transitions have no single authoritative source.

Therefore these are **possible transition roles/stages**, not Foundation-required states.

## 3. Minimum stable semantic core

The strongest current minimum is:

```text
Cross-Ground Transition / Propagation
├─ exact changed / affected focus
│  └─ exact Binding instances / semantic roles where needed
├─ change / transition identity
│  └─ what semantic property/relation/standing/control participation changed?
├─ reference/baseline or trajectory frame
│  └─ enough to distinguish persistence from material change
├─ realized transition semantics
│  └─ what actually became different / unfolded?
├─ realized scope
│  └─ where / for whom / for which target/version/context did it become effective?
├─ temporal/reference frame where material
│  └─ occurrence/effective/reference intervals or order relations as needed
├─ propagation/dependency semantics where material
│  └─ which dependent scopes were expected/eligible to change and which actually did?
├─ partiality/persistence/reversibility semantics where material
└─ observation/evidence kept separate from occurrence
```

Not every case requires every optional branch.

## 4. Exact changed focus

A transition claim must bind to the exact thing whose change is asserted.

Examples:
- exact policy version;
- exact Actor authority scope;
- exact Work pursuit/state;
- exact Environment condition;
- exact Information representation/view;
- exact cross-ground Standing basis.

Required inheritance from Binding:

```text
resource X changed
!= every version/scope/reference of X changed
```

## 5. Change identity

`Something changed` is insufficient.

The semantics must distinguish what kind of fact became different, for example:
- a representation was replaced;
- an authority relation became effective/expired;
- a Work pursuit was admitted/suspended/completed;
- an Environment capability became available/unavailable;
- a Control basis or enforcement realization changed;
- a Composite Standing's constitutive basis changed.

This is semantic identity, not an ontology class requirement.

## 6. Reference/baseline versus trajectory

A discrete `before/after` pair is not universal.

Some transitions are:
- abrupt;
- continuous;
- progressive;
- oscillatory;
- intermittent;
- regime changes;
- gradual convergence/divergence.

Foundation requirement is therefore weaker:

> preserve enough reference/trajectory semantics to say what material change is being claimed.

```text
state difference
!= known transition path
```

A before/after difference may establish that values differ without establishing how the transition unfolded.

## 7. Realized scope

This is a major load-bearing element.

A change can be true at one scope and false at another:

```text
policy source updated
endpoint A updated
endpoint B stale
old session still effective
new request path uses new policy
```

Therefore:

```text
local realization
!= global / governed-effect realization
```

Scope can be:
- target/version;
- Actor population;
- endpoint/service/resource;
- geographical/organizational region;
- Work subset;
- Information consumer/view;
- control path;
- temporal interval.

No fixed scope ontology is selected.

## 8. Propagation semantics

Propagation is not limited to copied state.

A cross-ground change may propagate through:
- replication/distribution;
- dependency re-evaluation;
- trigger/work initiation;
- authority/delegation change;
- control decision/enforcement update;
- information exposure;
- physical influence;
- institutional effect;
- derived Standing re-evaluation.

Therefore:

```text
propagation != data replication
```

and:

```text
A changed
B depends on A
!= B necessarily changed already
```

Binding owns dependency meaning; Transition owns realized change along/through that dependency over time.

## 9. Time is conditional but decision-critical

No one timestamp is universal.

When material, preserve distinctions such as:
- occurrence time/interval;
- local effective time;
- remote effective time;
- observation/receipt time;
- record time;
- reference/evaluation time;
- ordering without synchronized clocks.

Required rule:

```text
occurred at t1
!= observed at t1
!= effective everywhere at t1
```

## 10. Initiation/intention/commitment are optional profiles

Useful questions may include:
- was the change requested?
- authorized/admitted?
- committed/issued?
- initiated?
- intended to affect what scope?

But these cannot define Transition itself.

```text
unrequested change can still be a real transition
uncommitted/emergent change can still be a real transition
```

## 11. Observation/evidence is not realization

Information can assert a transition that:
- did not occur;
- occurred only partially;
- occurred at another time/scope;
- was later reversed;
- was inferred from stale evidence.

Therefore:

```text
transition record
!= actual transition
observation received
!= transition newly occurred
```

## 12. Intended versus realized effect

Intention/target can be decision-critical but is not required for every transition.

```text
intended change
!= realized change
```

Whether a realized change achieved an intended outcome is Standing/evaluation-facing; why it occurred is Causal Effect-facing.

## 13. Currentness and validity dependencies

A transition can change the basis on which previous conclusions were computed.

But:

```text
dependency changed
→ previous assessment may become stale
!= object-level standing necessarily false
```

Transition must preserve which dependency changed, scope/time of effectiveness, and enough identity for downstream Standing/Control re-evaluation.

## 14. P1 provisional result

No stable child split is yet forced.

The common semantic core is stronger than a lifecycle taxonomy:

```text
exact focus
+ change identity
+ reference/trajectory
+ realized scope
+ temporal frame where material
+ propagation/dependency semantics where material
+ observation separation
```

Proceed to P2 to test whether realization, propagation and temporal-state semantics are distinct child candidates or tightly coupled dimensions of one region.
