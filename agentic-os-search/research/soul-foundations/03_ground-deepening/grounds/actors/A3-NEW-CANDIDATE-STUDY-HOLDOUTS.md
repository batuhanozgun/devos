# Actors Ground Audit — A3 New Candidate-Study Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Use studies produced after the original Actors vertical as holdouts. They are not allowed to define the Actors taxonomy; their role is to expose cases the old frame might fail to represent.

Holdouts:

- Anthropic AI-Native SDLC Playbook study;
- Multi-Agent Coordination Patterns study;
- Context / Memory / Harness Engineering study where materially relevant.

---

# 2. Anthropic AI-Native SDLC holdout

## 2.1 Role labels across the lifecycle

The study exposes product owner, engineer/producer, reviewer/code owner, policy owner, release manager, service owner, verifier/subagent and automated security/incident agents.

### Attack

Can the old Actors frame distinguish these without making one `agent role` field carry authority, capability, responsibility and participation?

### Result

Yes.

The case reinforces:

- bearer != role;
- role != current episode participation;
- performer != reviewer/verifier/authorizer;
- authority != competence;
- responsibility/accountability can persist outside direct execution.

No new family is required.

---

## 2.2 Subagents and nested delegation

Subagents create nested operational participation and potentially nested delegation.

### Attack

Does recursion require a new hierarchy/manager Actor family?

### Result

No.

The old Actors frame already supports:

- separate bearers/identities;
- role/participation per episode;
- delegation/representation chains;
- authority scope/context;
- attribution/accountability distinct from operational production.

Hierarchy is a topology over these relations, not a first-order Actor kind.

---

## 2.3 Transitive/effective authority incident

The strongest holdout is the study's reported case where an agent without one direct production-write route could contact/use another actor with stronger capability.

### Attack

Does this falsify the prior authority account?

### Result

It falsifies a **local-permission-only** model, but the prior Actors research had already rejected authority as an intrinsic unary property.

The holdout strengthens a distinction:

```text
direct Actor authority
!= reachable technical effect power
!= legitimate delegated authority
```

The effective path depends jointly on:

- A/B Actor relations;
- B's capability/authority;
- invocation/delegation semantics;
- Environment credentials/network/tool access;
- Work/orchestration topology;
- policy/enforcement.

No new Actor-local family survives; later control/composition must evaluate alternate paths.

---

## 2.4 Environment-tiered autonomy

The study argues against one scalar agent autonomy setting: development, CI and production can have different allowed actions and gates.

### Attack

Does `autonomy` require a new Actor dimension?

### Result

No stable new family.

`Autonomy` decomposes into already-separated questions:

- what the bearer can do;
- what it is permitted/authorized to do;
- what Environment makes possible;
- which Work/gate state is current;
- what evidence/approval is present.

The study therefore supports **relational/contextual authority**, not a new scalar Actor property.

---

## 2.5 Advisory instruction vs hard enforcement

Claude configuration distinguishes model-visible guidance (`CLAUDE.md`, Skills, rules/context) from harder Hooks/settings/permissions/sandbox/network/identity controls.

### Attack

Does model-visible policy instruction itself create Actor obligation/authority?

### Result

Not by itself.

The case strongly supports the four-ground separation:

- instruction/policy text = Information representation;
- normative authority/obligation = Actor/control relation;
- mechanical enforcement = Environment/control condition;
- compliance/review activity = Work.

No new Actors family.

---

## 2.6 Human approval gates

Anthropic retains humans at product, code, policy, release and service-owner gates.

### Attack

Does `human` need a privileged foundational Actor subtype?

### Result

No.

The important semantics are authority, judgment role, accountability, risk context and participation—not humanity alone.

Human status may matter in law/governance, but the general Actors frame remains typed-relational rather than human-special.

---

# 3. Multi-Agent Patterns holdout

## 3.1 Hierarchical agents

The study explicitly warns:

```text
hierarchy position
!= authority
!= competence
!= responsibility
!= accountability
```

A submanager may coordinate/decompose while lacking authority to alter acceptance criteria or widen permissions.

### Result

This is a direct **confirmation under a newer use case** of the prior Actors multi-anchor separation.

Hierarchy adds recursion/path pressure but no new first-order Actor family.

---

## 3.2 Generator / critic / verifier / integrator

The study finds that a generic `critic` label collapses materially different functions:

- review/critique;
- verification;
- adversarial challenge;
- integration/acceptance transition.

### Attack

Does this require new Actor kinds?

### Result

No.

These are Work/participation roles whose authority, capability and evidence requirements can differ. The Actors frame already requires role/participation/authority separation.

The holdout reinforces:

> role name does not establish epistemic independence or authority.

---

## 3.3 Parallel agents and epistemic diversity

Multiple agents agreeing does not create independent evidence merely by plurality.

### Actors relevance

- plurality != collective agency;
- multiple model instances != independent verifier role by identity alone;
- independence depends on source/method/tool/context separation and belongs partly to verification/Information design.

No new Actor family.

---

## 3.4 Human-in-the-loop

The study distinguishes legitimate human value/authority gates from hidden human orchestration.

### Actors relevance

- human performer/coordinator != human authorizer/accountable owner;
- technical verification != human approval;
- authority/judgment position must be explicit.

No new family.

---

## 3.5 Composite orchestration

A task-specific system may combine sequential, parallel, hierarchical, verifier and human-gate patterns.

### Attack

Does the resulting `team` or `multi-agent system` become one group Actor by default?

### Result

No.

The prior collective distinction remains load-bearing:

```text
collection of agents
!= coordinated/shared activity
!= organized corporate/group bearer
```

A runtime orchestration topology does not itself prove a new persistent group identity, authority or accountability bearer.

---

# 4. Context / Memory / Harness holdout

## 4.1 Authority information in context

A model may see role/permission information in context, but that does not prove the represented standing is current or authoritative.

Result:

```text
context contains permission/role claim
!= Actor actually has current authority
```

This reinforces Actors ↔ Information separation.

## 4.2 Harness/runtime permissions

Tool permissions, sandboxing, routing and runtime controls determine practical actionability.

Result:

```text
Actor authority/capability
!= harness/runtime affordance/enforcement
```

This reinforces Actors ↔ Environment separation.

## 4.3 Session continuity

An agent/process can be recreated in a new session while Work and persistent representations continue.

This raises identity questions but does not force one answer:

- same model class != same bearer identity;
- same role != same process/session;
- fresh process can occupy a continuing role;
- continuing Work can survive bearer/session replacement.

These are already covered by identity/role/participation continuity distinctions.

---

# 5. Holdout matrix

| Holdout pressure | Existing Actors coverage | New first-order family? |
|---|---|---|
| scoped roles / identities | bearer + role + participation | No |
| subagents / nested delegation | delegation/history + participation | No |
| transitive/effective effect path | authority + delegation + cross-ground actionability | No |
| environment-tiered autonomy | contextual authority/capability + Environment | No |
| advisory vs enforced policy | Actor relation + Information + Environment | No |
| human gates | authority/judgment/participation | No |
| manager hierarchy | role != authority != accountability | No |
| generator/critic/verifier | typed participation roles | No |
| parallel agent plurality | collective/non-human distinctions | No |
| composite agent system | aggregation != shared/corporate agency | No |
| context-visible authority | standing != representation | No |
| runtime permission surface | authority != enforcement/actionability | No |
| fresh-session agent | identity/role/participation continuity | No |

---

# 6. What the newer studies genuinely add

They add important **stress and later composition pressure**, especially:

1. alternate action-path closure: direct denial is insufficient when another Actor/tool path can produce the same effect;
2. effective effect power must be computed over reachable paths without being mislabeled as legitimate authority;
3. autonomy is relational/contextual rather than scalar;
4. role labels do not establish authority, competence, independence or accountability;
5. runtime/harness enforcement and Actor normative standing must be separated;
6. multi-agent topology does not automatically create a collective/corporate agent;
7. high-discretion AI strengthens the need to separate operational participation from institutional/legal responsibility.

These additions are valuable but they do **not** expose a missing Actors-local first-order family.

---

# 7. A3 judgment

The newer candidate studies **fail to falsify** the prior Actors multi-anchor account.

They mostly make its distinctions more operationally urgent.

After A1–A3:

- no live first-order Actors gap remains;
- effective/transitive authority remains a major later relation/control problem, not an Actors child;
- affected/beneficiary/rights-holder positions remain important orientation/stake relations but do not force a new ground;
- high-discretion non-human agents remain analyzable through existing operational-vs-normative separation.

A4 external expansion is therefore conditional. Before opening broad new research, A5 rival/reduction reasoning should determine whether any decision-critical gap hypothesis can be revived. If none survives, additional literature expansion has low expected structural information gain.
