# Work — Vertical Synthesis

**Status:** current consolidated result  
**Research state:** sufficiently complete for the current foundation purpose; subject to user evaluation  
**Scope:** independent Layer-1 Work foundations research only

## 1. Executive conclusion

The initial narrow framing — `Work = task/work item + lifecycle` — is not sufficient as a foundation-level account of the problem domain.

Across planning, process/case management, coordination/CSCW, activity theory, queueing/flow, systems engineering, project/portfolio management, maintenance, work-design and quality/control traditions, materially different phenomena become invisible when Work is reduced to one bounded item with one local state machine [S01–S25].

The strongest current conclusion is therefore **not a replacement ontology**. It is a set of distinctions that any later synthesis must be able to preserve or deliberately explain away.

A provisional research-level formulation is:

> **The Work problem concerns how possible pursuits toward purposes/outcomes become selected or rejected, structured, committed, enacted, coordinated, monitored/evaluated, adapted, concluded or recovered over time under dependencies, constraints and scarce capacity — at multiple analytical levels, including both bounded and continuing activity.**

This formulation is descriptive and deliberately plural. It does not establish that `Work` is a SOUL primitive, that every listed dimension belongs inside one future component, or that one universal representation should encode them all.

## 2. Purpose, action and method are different analytical dimensions

The evidence does not support identifying `what is sought` with `what is done` or with one chosen realisation path.

HTN planning distinguishes abstract tasks, goal-like achievement expressions, executable operators, task networks and alternative refinement methods [S04]. Activity theory independently distinguishes short-lived goal-directed actions from durable object-oriented activity systems [S08].

### Current conclusion

A later model must not assume that:

- an objective/outcome is identical to a task description;
- one task has one canonical decomposition;
- completing a chosen decomposition logically proves the higher-level purpose was achieved.

Alternative means, changing methods and parent-level outcome criteria remain first-order concerns.

## 3. No single universal Work unit is justified

Different traditions explain relevant phenomena using different units:

- bounded task/action;
- task network or process;
- case with discretionary/event-driven elements;
- durable activity/operation;
- dependency network;
- system-level flow/population;
- event/action participating in several meaningful work contexts [S01][S04–S06][S08][S10].

Object-centric process research is a concrete warning that forcing one case identity can disconnect views and lose relations [S06].

### Current conclusion

The research supports **plural analytical projections**, not task atomism. The right analysis unit may change with the question being asked.

## 4. Work begins before execution

The targeted omission check exposed a first-order pre-execution dimension.

CMMN distinguishes discretionary work that can be planned from plan-item instances actually introduced at runtime [S02]. Kanban distinguishes pre-commitment options from work admitted after a commitment point [S19]. Portfolio management separately treats identification, evaluation, selection, prioritisation, authorization and resource allocation before/different from execution [S20].

### Current conclusion

The Work problem must preserve conceptual distinctions among:

- possible/candidate work;
- applicable/eligible work;
- selected/committed/admitted work;
- work whose execution has actually begun.

Demand is not automatically commitment; backlog is not automatically WIP; rejection, deferral and supersession are not equivalent to execution failure.

Priority is correspondingly contextual and relational: it depends on alternatives, scarcity, urgency, expected value/risk, capacity and changed conditions rather than being safely reducible to one timeless intrinsic number [S19][S20].

## 5. Plan/prescription and actual situated work are not identical

Work-as-Imagined / Work-as-Done research distinguishes prescribed or expected work from actual work in context [S07]. CMMN and progressive-elaboration guidance independently show that work can evolve as situations and information change [S01][S15].

### Current conclusion

A later foundation must distinguish at least:

- unchanged execution against a plan;
- progressive elaboration as uncertainty resolves;
- adaptive replanning after changed conditions;
- uncontrolled drift/noncompliance.

A plan deviation cannot be classified as failure from the deviation alone.

## 6. Control regime is not universally imperative

Imperative workflow is one Work-control regime, not the neutral universal default.

Declarative process research shows that prescribing one route can over-specify dynamic work [S03]. CMMN provides event/situation-driven case semantics [S01][S02]. Workflow-pattern research demonstrates substantial complexity even inside imperative control flow [S22].

### Current conclusion

At least these control forms must remain distinguishable:

- procedural / imperative order;
- declarative / constraint-based admissibility;
- event- or situation-driven adaptive choice.

Real Work can combine them. The evidence does not justify a single universal workflow grammar.

## 7. Dependencies and coordination are first-order Work phenomena

Coordination theory defines coordination around the management of dependencies among activities, including shared resources, producer/consumer relations, prerequisites, simultaneity and task/subtask relations [S05]. CSCW research identifies articulation work required to make distributed cooperative activity fit together [S09].

### Current conclusion

Readiness, blockage, safe-to-start, synchronisation and downstream usability can be relational properties of a Work network rather than item-local fields.

Coordination is itself Work when it is required to make other activity executable or mutually compatible. Sequencing, handoff preparation, resource contention management, clarification, re-coordination and synchronisation cannot safely be dismissed as administrative noise.

Concurrency and partial order are therefore normal structural possibilities, not edge cases [S04][S05][S22].

## 8. Item progress and system flow are different levels of truth

Little's Law establishes a system-level relation among average number in system, throughput/arrival rate and time in system under its assumptions [S10]. Kanban separately makes WIP/capacity/commitment relationships operationally explicit [S19].

### Current conclusion

Work has population/flow-level observables that are not properties of any one item:

- WIP accumulation;
- waiting versus processing;
- congestion;
- throughput and cycle/time-in-system;
- bottleneck/capacity contention.

Consequently, local item progress, high utilisation or more work started does not logically entail better end-to-end system progress.

## 9. Work state is multidimensional, not one scalar lifecycle

CMMN provides an existence proof that availability, enabledness, disabled/non-execution, active execution, suspension, failure, completion and termination can carry different semantics [S02]. Requiredness/applicability are also distinct from execution state.

### Current conclusion

A single `todo → doing → done` variable is foundation-level information loss if it conflates:

- applicability/requiredness;
- availability/readiness;
- activation/admission;
- active execution;
- suspension/interruption;
- failure;
- deliberate non-execution;
- normal completion;
- alternative/abnormal termination.

This does not imply adopting CMMN's state machine. It establishes orthogonal questions that can matter independently.

## 10. Time, effort, waiting and recurrence are not one quantity

PMI scheduling guidance explicitly distinguishes effort/work labor units from duration and warns that duration-based percent complete may not measure actual work effort [S15]. Coordination and process sources add prerequisite waiting, synchronisation and temporal constraints [S02][S04][S05].

### Current conclusion

The Work problem must distinguish when relevant:

- effort/resource work quantity;
- processing duration;
- waiting for prerequisites/events/capacity/decisions;
- wall-clock elapsed/span time;
- timing constraints and synchronisation;
- recurrence/repeated execution.

The same effort can have different durations; time can pass while little or no processing effort occurs; continuing work can consist of repeated episodes without one final completion event.

Support/level-of-effort activity can also be real Work even when it does not directly create the terminal deliverable [S05][S09][S15].

## 11. Execution completion, success, validation and acceptance can diverge

NASA systems-engineering guidance distinguishes verification, validation, acceptance testing and certification/readiness activities [S12]. CMMN separately distinguishes successful completion, failure and termination [S02].

### Current conclusion

At least four questions can differ:

1. Did execution close normally?
2. Does the result conform to specified requirements?
3. Is the result fit for intended use/context?
4. Has the relevant acceptance/readiness gate been passed?

Therefore `done` is often a vector of predicates rather than one fact. Completion of child tasks is evidence, not logical proof, that a parent purpose or outcome has been achieved.

## 12. Failure, termination and recovery have different causal semantics

CMMN distinguishes failure/termination from normal completion [S02]. Saga research shows that long-running work can create partial externally visible effects and may require compensating actions rather than exact rollback [S11]. NASA closed-loop process-assessment guidance independently shows that non-conformance can generate root-cause analysis, corrective action and follow-up verification [S25].

### Current conclusion

The following concepts must not be silently collapsed:

- terminate/cancel;
- rollback;
- compensate;
- reconcile/repair;
- retry/reactivate;
- diagnose/remediate/revalidate.

Failure can be a **generator of new Work**, not merely a terminal status. After partial effects, the world may not be equivalent to the pre-execution state.

## 13. Bounded and continuing Work are different temporal regimes

Project-management material distinguishes temporary project work from ongoing operations [S13][S14]. Activity theory independently provides durable activity systems as a different analytical unit [S08]. Maintenance terminology supplies concrete recurring/condition-triggered examples [S21].

### Current conclusion

Some Work is naturally bounded by an intended result/closure condition. Other Work concerns maintaining conditions, recurrent service, monitoring, standing response or continuing operation.

Continuing Work may have completed episodes while the larger responsibility remains open. Universal terminal `done` semantics would therefore create false closure.

## 14. Feedback loops do not currently require an additional first-order dimension

A final countercheck examined whether closed-loop control/feedback exposed a missing Work family.

ASQ's PDCA model explicitly cycles plan → do → check → act and uses learned results to determine subsequent action [S24]. NASA's closed-loop process assessment links non-conformance observation, causal assessment, corrective action and effectiveness verification [S25].

### Current conclusion

Feedback is important, but its Work semantics are currently expressible through already identified dimensions:

- plan versus actual state;
- monitoring/evaluation;
- adaptive replanning;
- corrective/recovery work;
- continuing/repeated activity.

The countercheck therefore strengthened the relational/dynamic nature of the current frame without exposing a new independent first-order category.

## 15. Main failure classes exposed by the vertical

Premature foundations are especially vulnerable to:

- **task atomism:** treating one item as the universal Work unit;
- **purpose/action conflation:** losing alternative methods or parent-level outcome meaning;
- **demand–commitment conflation:** treating every request as promised/active Work;
- **priority essentialism:** treating ranking as a context-free intrinsic item property;
- **plan/execution conflation:** treating situated adaptation as equivalent to failure;
- **imperative over-specification:** encoding one route as universally mandatory;
- **coordination invisibility:** omitting the Work required to manage dependencies;
- **relational-state loss:** forcing readiness/blockage/synchronisation into local booleans;
- **flow blindness:** optimizing items while hiding congestion or system delay;
- **status collapse:** merging readiness, execution, suspension, failure and closure;
- **effort–duration conflation:** treating resource work, processing time and elapsed time as one quantity;
- **completion leakage:** equating execution closure with verified/validated/accepted outcome;
- **checklist fallacy:** automatically closing parents when children close;
- **cancellation-as-erasure:** losing partial effects and recovery semantics;
- **failure-as-terminal:** erasing diagnosis, repair, compensation or retry Work;
- **support-work erasure:** excluding activity that enables/sustains other Work;
- **false terminality:** forcing ongoing responsibilities into one final `done` state.

These are framing failures, not merely naming/UI defects. Adding more status labels to an otherwise item-local scalar model would not resolve the underlying loss.

## 16. What this research does not establish

This synthesis does **not** establish:

- that `Work` is a final SOUL category;
- that the dimensions above are ontology primitives;
- that one data structure should represent all of them;
- that CMMN, HTN, Kanban, PMI, workflow patterns, activity theory or any other investigated model should be implemented;
- how Work should relate architecturally to Records, Actors, tools or authority;
- who may select, commit, reprioritise, waive, accept, terminate or reactivate Work;
- what persistent evidence proves Work state or outcome;
- a universal metric, lifecycle or control grammar.

Those questions either belong to later synthesis/design or cross the isolated-vertical boundary.

## 17. Deferred cross-vertical questions

Material relationships observed but intentionally not solved include:

- **Records relation:** what persistent descriptions, evidence and traces establish plans, commitments, actual execution, validation, acceptance, failures, compensation or recovery?
- **Actors relation:** who/what has capability, responsibility and authority to select, commit, execute, coordinate, accept, terminate, waive or reprioritise Work?
- **Cross-vertical relation:** where should purposes/outcomes, obligations, resources and externally visible effects live if the starting vertical decomposition is later revised?

These are deferred questions, not evidence that the current three-vertical hypothesis is ontologically correct.

## 18. Evidence and retrieval

Detailed derivation is preserved in:

- `../orientation/RESEARCH-ORIENTATION.md` — historical starting frame and alternative-frame test;
- `../findings/WORK-FRAMES-AND-UNITS.md` — units, purpose/action/method, ongoing work and evolving definition;
- `../findings/INTAKE-SELECTION-COMMITMENT-AND-PRIORITY.md` — candidate/commitment/admission/priority;
- `../findings/COORDINATION-FLOW-AND-SITUATEDNESS.md` — plan/actual, control regimes, dependencies, concurrency, interruptions and flow;
- `../findings/CONTROL-STATE-CLOSURE-AND-RECOVERY.md` — state, time/effort, closure, recovery and continuing work;
- `../evidence/SOURCE-LEDGER.md` — claim-to-source recovery and source-view grades;
- `COMPLETENESS-OMISSION-CHECK.md` — bounded-completion judgment and remaining uncertainty.

The synthesis is the current conclusion. Earlier files preserve the research path and should not override this document if their intermediate framing differs.
