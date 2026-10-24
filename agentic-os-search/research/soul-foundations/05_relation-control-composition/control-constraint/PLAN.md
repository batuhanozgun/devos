# Control / Constraint — Research Plan

**Status:** COMPLETED RESEARCH PLAN  
**Date:** 2026-09-05  
**Parent:** accepted Cross-Ground Composition

## 1. Research question

Determine whether `Control / Constraint` is a coherent and sufficiently bounded cross-ground composition region, what minimum semantics it must preserve, whether stable immediate children exist, and where its boundaries lie against Relational Binding, Composite Standing, ground-local Actors/Environment/Work/Information semantics and deferred Transition/Effect/Feedback.

## 2. Protected semantic distinction

The pass was required to explain, without collapse, cases where all of the following diverge:

```text
norm / policy / instruction exists
legitimate authority exists
Actor is permitted / prohibited / obligated
request satisfies authorization criteria
approval / denial decision occurs
technical mechanism allows / blocks
alternate path remains / is closed
behavior complies / violates
monitoring detects / misses
recovery / escalation occurs
```

A useful result had to say which distinctions are universal and which are optional/domain-specific.

## 3. Mandatory boundary checks

### 3.1 Binding boundary
Binding says exactly which anchors/roles/scope/time are connected. Control must not merely rename policy/authority/delegation bindings.

### 3.2 Standing boundary
Standing can say `authorized`, `eligible`, `compliant`, `approval-valid`, `gate-satisfied`, etc. Control must preserve the rule/authority/decision/enforcement semantics that produce or consume such standings without absorbing all qualification.

### 3.3 Actors boundary
Actor-local permission/authority/obligation/delegation remains Actors semantics where the protected question is the bearer/standing itself. Control is cross-ground only where those standings govern Work/Environment/Information transitions or decisions.

### 3.4 Environment boundary
A firewall, sandbox, missing credential, unavailable tool or physical interlock may be realized Environment condition. Control must distinguish `mechanically impossible/blocked` from `normatively prohibited` and determine when realized enforcement is a control-semantic layer rather than only a condition fact.

### 3.5 Work boundary
Approval/review/gate/check Work remains Work. Control must distinguish `approval Work occurred` from `transition was legitimately authorized/blocked/required`.

### 3.6 Information boundary
Policy/rule/configuration/decision records are representations. Control truth must not be equated with text/configuration/report presence.

### 3.7 Transition boundary
Control governs/conditions transitions. Transition child will later study what changed, propagated or caused what. This pass may preserve control-state/current applicability and path closure but must not take over event-history/causal dynamics.

## 4. Candidate semantic structure tested

Initial falsifiable hypothesis:

```text
Control episode / regime
├─ governed focus
├─ normative / policy basis
├─ authority / competence-to-govern basis
├─ control modality
├─ evaluation / decision / gate semantics
├─ enforcement / intervention semantics
├─ path / coverage / bypass semantics
├─ monitoring / compliance semantics
└─ validity/currentness dependencies
```

K1 corrected this by showing that authority/decision/enforcement/monitoring are not universally mandatory. The final result retains one smaller core plus optional non-collapsed layers.

## 5. Completed passes

```text
K0 canonical/current evidence recovery              ← complete
K1 protected question + minimum control signature   ← complete
K2 control-layer discrimination                     ← complete
K3 modality / gate / authority / path / bypass      ← complete
K4 family discovery + rival decompositions          ← complete
K5 authoritative external + candidate holdouts      ← complete
K6 synthesis / immediate-child decision             ← complete
K7 adversarial closure                              ← complete
```

## 6. Required hard cases covered

The pass tested, among others:
- policy says no, runtime permits;
- runtime blocks without legitimate policy;
- direct path denied, delegated/alternate path achieves effect;
- approval recorded but approver lacks authority;
- Actor permitted but not capable/actionable;
- Actor obligated but technically unable;
- gate criterion satisfied while authorization absent;
- decision permits while enforcement is stale/misconfigured;
- compliant behavior without monitoring evidence;
- monitoring says compliant while actual behavior violates;
- emergency override/waiver;
- separation-of-duties/self-approval failure;
- advisory AI instruction versus deterministic control;
- sandbox/tool control with indirect agent/tool/network path.

## 7. Closure outcome

The stop rule was met.

Late pressure mainly generated:
- more domain control labels;
- mechanism-specific taxonomies;
- overlapping profiles;
- implementation forms;
- Transition/causal residuals.

No stable immediate-child protected question survived.

Current bounded judgment:

```text
Control / Constraint
    ← BOUNDED LEAF / USER EVALUATION PENDING
    ← one governing-control semantic core
    ← optional/non-collapsed associated layers
    ← no immediate child promoted
```

See `KEY.md`, `synthesis/CONTROL-CONSTRAINT-SYNTHESIS.md` and `K7-ADVERSARIAL-CLOSURE.md`.

## 8. Verification boundary

K7 is same-model adversarial review, not independent verification. External standards discriminate specific claims but do not validate the project decomposition by authority.

User acceptance may close sequencing only; it does not change verification independence.

## 9. Non-goals preserved

No design was performed for:
- policy engine;
- RBAC/ABAC schema;
- authorization service;
- workflow gate implementation;
- sandbox/runtime architecture;
- event bus;
- SOUL/Development OS component architecture;
- ontology or database schema.