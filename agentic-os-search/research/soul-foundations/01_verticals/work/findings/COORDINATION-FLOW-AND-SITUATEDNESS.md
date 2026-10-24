# Work — Coordination, Flow and Situatedness

**Status:** substantive findings; current interpretation is consolidated in the vertical synthesis

## Question

What becomes invisible if Work is modeled only as isolated items following planned steps?

## 1. Prescribed work and actual work are not the same analytical object

Hollnagel and Clay-Williams distinguish Work-as-Imagined (how work is thought or expected to be done) from Work-as-Done (the direct experience of actual work). They explicitly warn against assuming that closing the gap simply means forcing actual work to comply with the imagined form [S07].

This is compatible with the broader situated-action critique associated with Suchman: plans are not complete causal scripts for situated conduct [S16].

### Finding

A Work foundation must preserve a distinction between at least:

- intended/prescribed/planned work;
- work actually enacted in context.

Deviation is therefore not semantically equivalent to failure. It may indicate adaptation, hidden constraints, local optimisation, missing information, or actual noncompliance; evidence is required to distinguish these explanations.

## 2. Imperative process order is one control regime, not the universal form of Work

Declarative process research argues that imperative process models can over-specify dynamic work because they prescribe how work must proceed. The proposed declarative alternative specifies what must hold without prescribing one exact route [S03].

OMG CMMN addresses cases whose activities can occur in unpredictable order in response to evolving situations and uses an event-centered case-management approach [S01].

### Finding

At least three materially different control regimes must remain distinguishable:

1. **imperative / procedural:** a sequence or allowed control-flow structure is prescribed;
2. **declarative / constraint-based:** obligations, prohibitions or temporal conditions constrain many possible paths;
3. **event/situation-driven adaptive:** available or appropriate next work emerges in response to evolving state/events.

Real work may combine these regimes. No evidence supports collapsing them into one universal workflow grammar at this stage.

## 3. Dependencies create Work that is not reducible to item-local state

Malone and Crowston frame coordination as managing dependencies among activities [S05]. Their analysis distinguishes, among others:

- shared-resource dependencies;
- producer/consumer relations and prerequisites;
- simultaneity/synchronisation constraints;
- task/subtask dependencies.

### Finding

`Blocked`, `ready`, `urgent`, `safe to start` or `complete enough for downstream use` cannot always be inferred from one item's local status. They may be relational properties of a dependency network.

A foundation that stores dependencies only as decorative links while defining semantics item-locally would miss a central part of the Work problem.

## 4. Coordination is itself work

Schmidt and Bannon argue that support for cooperative work must account for `articulation work`: the work required to make distributed cooperative activity fit together in real conditions [S09]. Coordination theory similarly treats resource allocation, notification, sequencing, tracking, scheduling, synchronisation and goal decomposition as processes required to manage dependencies [S05].

### Finding

The distinction between `real work` and `administrative overhead` is analytically unsafe. Some work exists precisely to make other work mutually compatible or executable.

This includes, depending on domain:

- sequencing and handoff preparation;
- dependency tracking;
- synchronisation;
- resource contention management;
- clarification and renegotiation;
- recovery and re-coordination after change.

A future model that omits this work can report apparent task efficiency while hiding the work that makes the system function.

## 5. Concurrency and partial order are first-order, not edge cases

HTN task networks may be partially ordered [S04]. Coordination theory treats simultaneity and synchronisation as explicit dependency classes [S05]. CMMN allows activity order to emerge from sentries/events rather than a predeclared linear sequence [S01][S02].

### Finding

Linear checklist semantics are not a neutral default. Work may require:

- independent concurrent branches;
- partial rather than total ordering;
- synchronization points;
- waiting for an event or prerequisite;
- dynamic choice of the next admissible action.

## 6. Interruptions and resumptions alter the work, not only its timestamp

Research on interruptions and task transitions finds that interruptions, multitasking and switching need to be understood in relation to a system of goals and can affect cognitive, emotional and performance outcomes [S17]. Empirical workflow research also observes changeover costs when collaborative interruptions preempt individual tasks [S18].

CMMN's lifecycle separately represents suspension and resumption rather than treating them as mere elapsed time [S02].

### Finding

`Paused` is not necessarily equivalent to `inactive`. Interruption can create:

- resumption/context-reconstruction work;
- changed priorities or state;
- loss of assumptions that held before suspension;
- additional coordination costs.

Therefore elapsed duration alone is not a sufficient temporal account of Work.

## 7. Flow is a system property

Little's queueing result relates the mean number of units in a stable system, their arrival/throughput rate and mean time in system: under its assumptions, L = λW [S10].

The theorem does not prescribe WIP limits or management policy. Its relevance here is narrower: **system-level Work behavior has quantitative relations that are not properties of any one item.**

### Finding

A foundation concerned only with item completion can be blind to:

- accumulation of work in process;
- waiting versus processing time;
- congestion;
- throughput/cycle-time tradeoffs;
- capacity contention.

Work therefore has both item-level and population/flow-level observables.

## 8. Local optimisation can conflict with system outcomes

Combining coordination and flow evidence yields an important inference:

- an item can make local progress while consuming a bottleneck resource needed elsewhere;
- many individually `active` items can increase waiting and congestion;
- completing an upstream activity can create downstream overload rather than system progress.

This is a cross-source inference, not a direct theorem from a single source [S05][S10].

### Finding

`Progress` is not necessarily monotonic or scalar at system level. More started work, more locally completed subtasks, or higher utilisation does not by itself prove better end-to-end Work performance.

## 9. Plan change can be normal adaptation

CMMN's evolving-situation framing [S01], progressive elaboration in project planning [S15], and Work-as-Done research [S07] converge on a common point: legitimate work often changes its route or detail as information improves.

### Finding

A Work foundation needs to distinguish at least conceptually among:

- execution against an unchanged plan;
- plan elaboration as uncertainty resolves;
- adaptive replanning due to changed conditions;
- uncontrolled drift from intended outcomes/constraints.

Treating all four as one generic `change` would erase the reason the change occurred and whether it is evidence of healthy adaptation or failure.

## 10. Failure modes exposed by this lens

If future modeling prematurely assumes isolated task items and fixed paths, likely failure classes include:

- **plan/execution conflation:** actual adaptation appears as noncompliance or disappears entirely;
- **over-specification:** dynamic work becomes brittle because one route is encoded as mandatory;
- **coordination invisibility:** dependency-management effort is unrepresented;
- **relational-state loss:** readiness/blockage/synchronisation are forced into item-local booleans;
- **concurrency collapse:** partial orders are serialized artificially;
- **flow blindness:** local completion metrics hide congestion and waiting;
- **interruption blindness:** suspension/resumption context and changeover work disappear;
- **local-optimum trap:** item utilisation/progress is mistaken for system progress.

## Deferred cross-vertical questions

- Who may resolve, waive or redefine a dependency is an authority/Actors question.
- Which persistent traces prove actual versus imagined work is a Records relation.
- Cross-vertical representation of context changes is intentionally not solved here.
