# Flowable — SOURCE LEDGER

Research ref: `flowable/flowable-engine@42aa81de65ce48572577c1826ba5d16135347aff` (`main`)  
Observed: 2026-09-17  
Latest observed release: `flowable-8.0.0` (2026-02-27)

## Load-bearing surfaces inspected

| Surface | Role in U02 |
|---|---|
| `README.md` | Flowable as BPMN/CMMN/DMN engine; human/system orchestration; Apache-2.0 |
| `docs/docusaurus/docs/bpmn/ch07a-BPMN-Introduction.md` | process definition/instance, sequence flow, user-task wait state, candidate/claim/assignee, persistence across restart |
| `docs/docusaurus/docs/bpmn/ch07b-BPMN-Constructs.md` search excerpts | event-based wait states, cancellation/compensation constructs and BPMN control vocabulary |
| `docs/docusaurus/docs/bpmn/ch08-ProcessInstanceMigration.md` | validation and mapping of in-flight process instances to new process definitions |
| `docs/docusaurus/docs/bpmn/ch17-Advanced.md` search excerpts | timer/async jobs persisted by async executor |
| `docs/docusaurus/docs/cmmn/ch06-cmmn.md` | case/plan-model/plan-item concepts, sentries, human/process/case tasks, stages and milestones |
| `modules/flowable-cmmn-api/.../PlanItemInstanceState.java` | exact plan-item lifecycle states and engine intermediary states |
| CMMN `ManualActivationRule` source/tests | manual activation yields enabled state instead of automatic active state |
| CMMN Required/Repetition source/tests | completion obligations and repeat-wait state |
| CMMN schema | plan item control vocabulary and presence of planning-table/discretionary constructs; runtime semantics not assumed |
| `docs/docusaurus/docs/dmn/ch06-DMN-Introduction.md` | repeatable decision tables and BPMN Decision Task integration |
| job/retry/dead-letter source/search surfaces | durable executable failure/retry mechanics |
| current main HEAD commit | current CMMN CaseTask/ProcessTask inheritance change; freshness signal |
| Flowable 8.0.0 release notes | process/case migration improvements and current released line |

## Evidence class

Source/documentation-bounded engine study. No Flowable server was installed or exercised and no process/case model was run by this research project.

## Revalidation triggers

Re-enter current source/release before relying on:

- CMMN discretionary/planning-table behavior;
- process/case migration coverage;
- retry/dead-letter defaults;
- cluster/distributed job behavior;
- exact BPMN/CMMN/DMN standard-version support;
- current Java/Spring compatibility;
- production security/performance claims.
