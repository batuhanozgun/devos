# Work — Intake, Selection, Commitment and Priority

**Status:** substantive finding produced by the targeted omission check; current interpretation is consolidated in the vertical synthesis

## Question

Does Work begin only when an executable task exists, or is there a materially different pre-execution problem in which possible work is identified, compared, selected, committed and admitted against limited capacity?

The omission check found that this is a first-order distinction rather than a minor lifecycle detail.

## 1. Potential work is not the same as instantiated / committed work

OMG CMMN's planning model distinguishes discretionary plan definitions from the instances actually moved into a case plan at run time. A `DiscretionaryItem` identifies something that *can* be planned; runtime planning occurs when a discretionary item is selected and an instance is moved into the plan. Applicability can itself be conditional [S02].

The official Kanban Guide makes a similar distinction from another tradition. Before a commitment point, ideas, requirements or needs that may have value are treated as `options`; they are vetted against available capacity and urgency, and many may be discarded before service delivery [S19].

### Finding

A Work foundation must be able to distinguish at least conceptually between:

- **possible / candidate work:** something that might warrant action;
- **eligible / applicable work:** a candidate currently admissible for consideration;
- **selected / committed work:** work whose delivery/execution has been deliberately admitted;
- **in-progress work:** execution has actually begun.

These are not merely four labels on one execution lifecycle. The transition from possibility to commitment is a **selection/admission decision** about what work the system will take on at all.

## 2. Commitment changes the semantics of time and capacity

In the Kanban Guide, the commitment point is where the decision is made to begin activities to deliver a work item; before it, work supports the decision whether to deliver the item, and system lead time is measured from commitment [S19].

### Finding

A request can exist for a long period without yet consuming the same kind of delivery commitment as admitted work. Therefore:

- request age is not automatically execution lead time;
- backlog size is not automatically WIP;
- a candidate's existence does not imply an obligation to execute it;
- capacity policy can determine when a candidate crosses into committed Work.

A model that creates every idea/request directly as an active `task` erases this distinction and can make demand appear equivalent to committed load.

## 3. Priority is relational, not an intrinsic scalar property

PMI portfolio-management material treats components as things that can be measured, ranked and prioritized, and describes portfolio management as evaluating, selecting, prioritizing and allocating limited resources. It explicitly notes that components share and compete for organizational resources and that allocation follows priorities and capacity [S20].

The Kanban Guide likewise treats urgency, available capacity and classes of service as system policies affecting which work moves and when [S19].

### Finding

Priority is not safely modeled as a timeless number attached to one work item. It can depend on:

- competing candidates;
- available capacity;
- scarcity/bottleneck conditions;
- urgency or time sensitivity;
- expected value/benefit;
- risk;
- portfolio/system balance;
- policy and changed circumstances.

This makes priority a **comparative and contextual property**. The Work problem includes deciding what *not* to start as much as deciding what to start.

## 4. Selection, authorization and execution should not be collapsed

PMI's portfolio model separates identification/evaluation/selection/prioritization/resource allocation from later execution [S20]. CMMN separately distinguishes discretionary availability for planning from an instantiated plan item [S02].

### Finding

The evidence supports preserving distinct questions:

1. Does a candidate exist?
2. Is it applicable/eligible?
3. Should it be selected relative to alternatives?
4. Has capacity/resources been committed to it?
5. Is it authorized/admitted to execution?
6. Has execution started?

The exact decision process is domain-specific and often touches Actors/authority. The Work-level finding is only that these states/questions are not interchangeable.

## 5. Rejection, deferral and supersession are legitimate Work outcomes before or during execution

Pre-commitment options may be discarded in Kanban [S19]. Portfolio guidance allows selected work to be re-evaluated as priorities, resource constraints or strategic conditions change, including termination/suspension before originally planned completion [S20].

### Finding

`Not done` has several materially different meanings:

- rejected before commitment;
- deferred because capacity/timing is unsuitable;
- superseded because another option now better satisfies the need;
- deprioritized after circumstances changed;
- terminated after commitment;
- failed during execution.

Treating all of these as `cancelled` destroys the reason Work ceased or never began.

## 6. Maintenance and recurring demand do not create a separate new axis

The omission check also examined maintenance. ISO terminology distinguishes preventive maintenance—performed at predetermined intervals or according to prescribed criteria to reduce failure/degradation probability—from corrective maintenance after fault detection to restore function [S21].

### Countercheck result

This is important, but it does **not** require a new top-level Work dimension beyond those already found:

- preventive maintenance maps to continuing/recurring/triggered Work plus temporal/condition criteria;
- corrective maintenance maps to failure-generated recovery/repair Work;
- the retained/restored required function maps to purpose/outcome.

Thus maintenance is a strong test case for the existing framework rather than a missing first-order category.

## 7. Failure modes exposed by this lens

Prematurely treating all possible work as normal task instances creates several failure classes:

- **demand–commitment conflation:** every request appears promised;
- **backlog–WIP conflation:** possible work is counted as active system load;
- **selection blindness:** the decision about what not to do disappears;
- **priority essentialism:** context-dependent ranking becomes a static item attribute;
- **capacity blindness at admission:** work is pushed into execution irrespective of system ability to absorb it;
- **rejection/cancellation collapse:** never-admitted work and terminated committed work look identical;
- **supersession loss:** work stopped because its purpose is better met elsewhere is indistinguishable from failure.

## 8. Effect on the current Work frame

This finding strengthens the emerging conclusion that Work is not adequately captured by a task lifecycle.

The Work problem begins **before execution** and includes the transition from demand/possibility into commitment, as well as comparative selection and admission under scarcity. This should remain an independent analytical dimension in the current synthesis.

## Deferred cross-vertical questions

- Who has authority to select, commit, reject or reprioritize is an Actors/authority question.
- What evidence constitutes a binding commitment, request or rejection may touch Records.
- How a later SOUL model represents these distinctions is intentionally not decided here.
