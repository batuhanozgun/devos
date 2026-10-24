# Work Management / Project Control — Study Metadata

## Identity and status

- **Study ID:** `work-management-project-control`
- **Title:** Work Management / Project Control — Representation, Decomposition, Flow and Recovery
- **Study type:** `focused-topic`
- **Status:** **BOUNDED-COMPLETE / REVIEW-READY**. U00–U10 are complete. Eight materially different work-control families are source-bounded; no further repository is automatically active.
- **Research object:** methodologies and implemented mechanisms for representing, decomposing, sequencing, assigning, progressing, blocking, reopening, replanning, verifying and recovering substantial work, independent of whether the actor is a human, an AI agent or a mixed team.
- **Research period:** 2026-09-17

## Primary question / purpose

How should a system represent and control large work when the path from intent to completion is not necessarily linear, fully known up front, or executed by one actor?

The study compares different work-management traditions and implemented systems rather than choosing a product. It asks how they model:

- work identity and decomposition;
- dependency and readiness;
- state and transition;
- ownership / claim / lease / role;
- uncertainty and progressive discovery;
- replanning, reopening, backtracking and compensation;
- scheduling, milestones, resources and constraints;
- verification / acceptance / definition of done;
- history, decisions, provenance and recovery;
- coordination across humans and agents;
- project / program / portfolio structure;
- operational/economic evidence about work.

## Source-bounded mechanism families

1. **OpenProject** — classical project / schedule / workflow control;
2. **Flowable** — durable BPMN process, CMMN case and DMN decision execution;
3. **Beads** — dependency-DAG / actionable-frontier / claim-liveness control;
4. **OpenSpec** — artifact dependency / living-plan / apply-readiness control;
5. **GitHub Spec Kit** — spec-driven decomposition / implement→converge work loop;
6. **Leantime** — strategy → goal → milestone → delivery alignment;
7. **Gas Town** — multi-agent orchestration, liveness, completion convergence and integration;
8. **ERPNext** — enterprise transaction attribution and derived project time/cost/billing/material/accounting standing.

The corpus does not imply that these families should be combined into one universal architecture.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** very strong candidate input for work identity, decomposition, readiness, state transitions, prerequisite/dependency structure, execution flow, verification, recovery and operational/financial standing.
- **Actors:** strong where assignment, claim, role, delegation, coordination, authority, liveness and human/agent participation affect work state.
- **Information:** strong where plans, issues, decisions, dependencies, schedules, evidence, transactions and current standing must remain durable and recoverable.
- **Environment:** strong/conditional where calendars, capacity, resources, workflow engines, runtime sessions or ERP transactions constrain or evidence work.
- **Relations / control:** very strong pressure surface for blocker/enabler edges, hierarchy versus DAG, state-machine transitions, admission/readiness, compensation/reopen, acceptance, attribution and portfolio composition.

These are discovery hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

Possible future value includes:

- giving SOUL a broader vocabulary for reasoning about work than task lists alone;
- distinguishing decomposition from prerequisite discovery and readiness from priority;
- modelling unknown or not-yet-specifiable work without forcing premature tasks;
- choosing task/project/case/process/graph representations by work condition rather than one universal workflow;
- coordinating humans and agents over one durable work substrate;
- recovering current/next work after session, actor or environment changes;
- treating replanning, reversal and verification as first-class work transitions rather than exceptions;
- distinguishing planned delivery from realized operational/economic evidence.

No SOUL work architecture is authorised or implied by this study.

## Potential Development OS relevance

Possible future value includes:

- persistent multi-session work state;
- project / issue / decision / dependency representations;
- progressive planning and actionable-frontier computation;
- work admission, ownership, blockers, review and completion gates;
- large-project decomposition across sessions and agents;
- recovery / reopen / rollback / compensation patterns;
- schedule, milestone, resource and portfolio concepts where development work needs them;
- comparison of repository-native, issue-tracker, BPM/case-management and agent-native work systems;
- adapters from work/project state into enterprise time/cost/billing/material systems without duplicating their authority.

No Development OS design or implementation decision is authorised or implied by this study.

## Reuse modes

- methodology reference;
- implemented mechanism catalogue;
- cross-system falsifier / counterexample;
- candidate work-state and control primitives;
- test/fixture source for large-work reasoning;
- design pressure for SOUL / Development OS when later authorised;
- negative-option evidence where a work model fails outside its native conditions.

## Likely revisit triggers

- Work Foundation deepening;
- Development OS work/project/task subsystem design;
- SOUL reasoning about large jobs or long-lived projects;
- agent task graphs, project trackers, workflow engines or case-management questions;
- dependency/frontier/replanning/recovery design;
- human-agent shared work-state design;
- portfolio/resource/schedule questions;
- enterprise time/cost/billing/material/accounting integration questions.

## Epistemic / authority boundary

This is candidate research, not Foundation authority and not an architecture decision. A repository's feature or terminology is evidence about that system, not proof that its ontology should be adopted. Product documentation and implementation are preferred over marketing claims; first-party benchmarks remain first-party until independently checked. Similar words across systems (task, issue, case, workflow, dependency, milestone, done, project) must not be assumed semantically equivalent.

The study does **not** establish one best methodology, product superiority, empirical productivity gains, agent reasoning efficacy or a final SOUL / Development OS work ontology.

## Freshness / revalidation

Each external-target package records its pinned research ref. Revalidate current upstream before any load-bearing reuse, especially fast-moving agent-native repositories and ERP/product behavior. Stable conceptual distinctions may be reused, but exact current semantics, APIs, licensing and features require fresh checks.

## Package entrypoints

1. `STATE.md` — authoritative completion/re-entry state
2. `METHOD.md` — comparison dimensions and evidence discipline
3. `10-CLOSURE-EVALUATION.md` — bounded program conclusion and reuse protocol
4. `08-CROSS-UNIT-SYNTHESIS.md` — first-wave mechanism synthesis
5. `09-ERPNEXT-GAP-CLOSURE.md` — enterprise integration gap closure
6. `PLAN.md` — completed sequence and future re-entry rule
7. `INDEX.md` — retrieval router

## Related studies

- `../openproject/`
- `../flowable/`
- `../beads/`
- `../openspec/`
- `../spec-kit/`
- `../leantime/`
- `../gastown/`
- `../erpnext/`
- `../recursive-prerequisite-discovery/`
- `../mattpocock-skills/`
- `../gstack/`
- `../superpowers/`
- `../multi-agent-patterns/`
- `../anthropic-ai-native-sdlc-playbook/`
- `../context-memory-harness-engineering/`
