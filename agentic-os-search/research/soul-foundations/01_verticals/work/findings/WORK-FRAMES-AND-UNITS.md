# Work — Frames and Units of Analysis

**Status:** substantive findings; current interpretation is consolidated in the vertical synthesis

## Question

What kinds of entities or units must a Work foundation be able to reason about before choosing a representation?

The research does not ask which unit SOUL should implement. It asks which distinctions disappear if Work is prematurely reduced to a single unit such as `task` or `work item`.

## 1. A task is not the same thing as its purpose

Across planning and activity-theoretic sources, a recurring distinction appears between:

- a desired state, object, purpose, goal or outcome;
- an action/task undertaken in relation to it;
- a method or network of actions through which it may be pursued.

HTN planning makes this explicit: its task language includes both task symbols and goal-like `achieve[...]` expressions; a method maps a task to a possible task network rather than treating the task and its realisation as identical [S04].

Activity theory makes a different but compatible distinction. It distinguishes relatively short-lived goal-directed actions from durable, object-oriented activity systems; individual actions become intelligible in the context of the larger activity [S08].

### Finding

`What is sought` and `what is done` are distinct analytical dimensions. A Work model that identifies the task description with the objective/outcome loses alternative means, changing methods and ongoing purposes.

## 2. Work can be hierarchical without having one canonical decomposition

HTN planning distinguishes:

- abstract tasks;
- primitive executable operators;
- task networks;
- methods that provide possible refinements of a task.

A task network may be partially ordered, not merely a list [S04].

### Finding

Decomposition is not only parent/child grouping. It can express **alternative refinements**, partial ordering and constraints. A future foundation should therefore not assume that a work item has one fixed checklist whose completion exhausts the parent meaning.

This does not establish HTN as the correct model for SOUL; it establishes that flat decomposition is insufficient as a general account of Work.

## 3. The relevant unit can be a network, case, activity system or flow rather than an item

Different disciplines place explanatory weight at different levels:

- HTN planning: task network and methods [S04].
- CMMN: a case with plan items, events, milestones, criteria and discretionary activity [S01][S02].
- activity theory: a durable collective activity system rather than a discrete action as the prime unit [S08].
- coordination theory: dependencies among activities and the processes that manage them [S05].
- queueing theory: system-level number-in-system, rate and time-in-system relations [S10].

### Finding

There is no evidence basis for selecting the atomic task as the universal explanatory unit. Item-level, network-level, case-level, activity-system-level and flow-level views explain different failure modes.

The safest foundation conclusion is therefore **plural units / projections**, not a prematurely unified primitive.

## 4. A single case identity is not always neutral

Traditional process mining commonly starts from events carrying a case identifier, activity name and timestamp. Object-centric process mining shows that real event data may contain multiple plausible identifiers; one event may relate to multiple cases, and flattening data to a traditional single-case log forces choices that create disconnected views and loss of overview [S06].

### Finding

A `work instance` boundary may be an analytical projection rather than an intrinsic fact. A single action/event can participate in several meaningful work contexts.

This is especially important because premature single-case identity can make downstream dependencies or shared progress invisible.

## 5. Temporary work and ongoing activity are different regimes

PMI defines a project as a temporary endeavor for a unique product, service or result [S13]. PMI material contrasts this with operations as ongoing endeavors producing repetitive outputs [S14]. Independently, activity theory distinguishes short-lived goal-directed actions from durable object-oriented activity systems [S08].

### Finding

Universal `start → execute → complete` semantics would misclassify ongoing work. Foundations need to tolerate at least two temporal regimes:

- **bounded work:** expected to terminate after an intended result or closure condition;
- **continuing work:** maintained, operated, monitored or repeatedly enacted without one natural final completion event.

This distinction is about the Work problem, not about an implementation type hierarchy.

## 6. Work definitions can evolve while work is underway

Two evidence lines challenge a frozen work definition:

- CMMN explicitly targets activities occurring in unpredictable order in response to evolving situations, including less structured knowledge work [S01].
- PMI scheduling guidance defines progressive elaboration as continuously improving and detailing a plan as more specific information and estimates become available [S15].

### Finding

Some work is not merely `known work waiting to execute`. Discovery can change the plan, decomposition, estimates or even the concrete set of required actions while preserving a broader purpose.

A foundation that treats every plan mutation as exceptional scope drift would therefore confuse **learning-driven elaboration** with uncontrolled change.

## 7. Work can include decision, investigation and sensemaking rather than only transformation

The CMMN framing includes event- and knowledge-driven case work where the next activity may depend on evolving circumstances [S01]. Activity-theoretic and situated-work perspectives also make the local interpretation of circumstances part of how actions arise [S07][S08].

### Finding

Not all Work is best described as a deterministic transformation from input to output. Some Work changes the **epistemic state** of the situation: it investigates, evaluates, decides, diagnoses or discovers what should happen next.

This does not move the research into Records; it only establishes that the Work problem includes work whose immediate product is reduced uncertainty or a changed decision state.

## 8. Emergent structural picture

The evidence supports keeping the following distinctions available without declaring them ontology primitives:

- purpose / object / outcome;
- bounded task or action;
- abstract task versus executable action;
- method / alternative refinement;
- task network / process / case;
- durable activity / ongoing operation;
- system-level flow;
- event/action participation in multiple work contexts;
- planned definition versus progressively elaborated definition.

The important result is not the list itself. It is the failure of any one member—especially `task`—to subsume the others without material information loss.

## Deferred cross-vertical questions

These are recorded but not solved here:

- How should persistent descriptions/evidence of these Work views relate to Records?
- How should responsibility, authority or capability relate to the multiple Work units? This belongs to Actors/cross-vertical synthesis.
- Whether some `object` or `outcome` concepts are better treated outside Work cannot be decided inside the isolated vertical.
