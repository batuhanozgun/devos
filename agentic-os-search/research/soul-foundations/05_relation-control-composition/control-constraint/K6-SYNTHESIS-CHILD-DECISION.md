# Control / Constraint — K6 Synthesis / Immediate-Child Decision

**Status:** COMPLETE / PROVISIONAL BOUNDED-LEAF DECISION  
**Date:** 2026-09-05

## 1. Executive synthesis

`Control / Constraint` survives K0–K5 as a coherent cross-ground composition problem.

Its protected question is not:
- what policy text exists;
- who has authority in the abstract;
- whether one request is currently authorized;
- whether one mechanism blocks one path;
- whether a review/gate Work item occurred;
- or what transition actually happened.

It is:

> **What governing semantics apply to an exact candidate action, transition, flow, choice or continuation, under what basis/scope/conditions, and—where material—how authority, decision, enforcement, path coverage and monitoring relate without collapsing into one another?**

Current strongest structural judgment:

```text
Control / Constraint
    ← BOUNDED LEAF at current Foundation depth
    ← no immediate child promoted
    ← one reusable governing-control grammar
    ← optional but non-collapsed associated layers
    ← overlapping control profiles/dimensions
```

K7 must now attack this result.

---

## 2. Final provisional semantic core

```text
Control / Constraint core
├─ control meaning / protected governing question
├─ exact governed focus / protected effect
│  └─ action / operation / transition / flow / choice / continuation
├─ governing basis / objective / invariant
│  └─ norm, policy, requirement, safety objective, assigned rule, limit, etc.
├─ governing mode / effect
│  └─ permit / prohibit / require / limit / gate / condition / stop / revoke /
│     redirect / escalate / isolate / require concurrence / waive ...
├─ applicability frame
│  ├─ exact Actor / Work / resource / target / operation bindings where material
│  ├─ scope / context / stage / jurisdiction / Environment conditions
│  └─ effective/reference time + version/state where material
├─ precedence / conflict / exception / default semantics where material
└─ validity / currentness dependencies
```

This is a research grammar, not a policy-engine or access-control schema.

---

## 3. Associated layers that must remain distinguishable

These layers are **not universal children**. They are loaded when the protected control question requires them.

### 3.1 Authority / legitimacy

```text
Actor authority / delegation / mandate
+ exact scope / decision type / time
→ legitimate competence to issue / approve / waive / revoke?
```

Authority is load-bearing in institutional/normative control, but not a universal requirement of every physical/technical control.

### 3.2 Evaluation / decision / gate

```text
candidate action/transition
+ applicable governing basis
+ current facts/standings
+ precedence/default/combining semantics
→ governing decision
```

Possible outcomes are not universally binary; domains may distinguish indeterminate, not-applicable, escalation or additional-condition outcomes.

### 3.3 Enforcement / intervention

```text
governing decision / invariant / condition
→ mechanism constrains, enables, interrupts or shapes actual reachable behavior
```

Mechanism state remains Environment reality; Control owns the semantic relation to the governing objective.

### 3.4 Coverage / alternate-path / bypass

```text
one enforcement point covers path P
!= protected governing objective covers every material path to effect E
```

Coverage is required when alternate routes materially change whether the control objective holds.

### 3.5 Monitoring / observation

Monitoring may be required by a control regime or needed to detect violation/control failure, but monitoring itself is often Work + Information + Environment capability.

### 3.6 Compliance / effectiveness assessment

Mostly a Composite Standing / evidence problem over:
- applicable control;
- actual behavior/effect;
- enforcement state;
- monitoring/evidence;
- sometimes causal/counterfactual evidence.

It is not the control itself.

---

## 4. Strongest non-collapse rules

```text
policy / rule representation
!= governing basis is legitimate/current/applicable

legitimate authority
!= policy text
!= technical capability
!= reachable effect power

applicable governing basis
!= current permit/deny/require standing

current standing
!= control decision procedure/regime

control decision
!= enforcement

enforcement-point success
!= end-to-end control-objective success

monitoring says compliant
!= actual compliance

actual compliance
!= control effectiveness

review / approval Work occurred
!= valid gate decision
!= authorized progression
!= enforced transition barrier

obligation / requirement
!= actionability / capability

waiver document exists
!= waiver valid
!= waiver applicable

direct path blocked
!= protected effect controlled

technical reachability
!= legitimate permission / authority

effective effect power
!= legitimate authority
```

---

## 5. The most important structural discovery — two control scopes

Control research requires explicit separation between:

### A. Governed-effect / control-objective scope

What the control is supposed to govern:
- exact action/effect/flow;
- relevant Actor/principal set;
- resource/target;
- direct and indirect behavior that counts toward the protected effect;
- scope/risk assumptions.

### B. Enforcement-point / observation scope

What one mechanism can actually:
- observe;
- allow/deny;
- terminate;
- restrict;
- log.

This yields a critical rule:

```text
local control mechanism works as configured
!= end-to-end control objective is satisfied
```

The Anthropic transitive-agent case, NIST least-privilege discussion and physical guard/bypass pressure all support this distinction from materially different directions.

This is Foundation-semantic when bypass changes whether the governing claim is true; it is not merely architecture detail.

---

## 6. Control is not authority-first

K1 corrected the initial hypothesis.

Institutional control can require legitimate authority, but some controls are defined by safety/design invariants and mechanical constraints.

Example:

```text
guard open
→ machine cycle prevented by interlock
```

The local control is meaningful without a separate human authorization decision per cycle.

Therefore:

```text
Control
!= Authority / Governance only
```

but also:

```text
technical/physical constraint
!= Control automatically
```

An arbitrary Environment inability becomes control-relevant only when its relation to a governed behavior and governing objective/invariant is part of the protected question.

---

## 7. Control mode conclusion

Foundation must preserve multiple governing modes, including where material:
- permit / allow;
- prohibit / deny;
- require / oblige;
- limit / bound / throttle;
- condition / gate;
- require concurrence / dual authorization;
- stop / revoke / terminate;
- redirect / escalate;
- isolate / separate;
- waive / exempt / override.

But these are **modes/dimensions**, not child populations.

Required distinctions:

```text
permitted != required
prohibited != technically impossible
required != actionable
not applicable != permitted != denied != compliant
```

---

## 8. Applicability, precedence and exception semantics

A control cannot be safely understood from rule presence alone.

Potentially material factors:
- exact subject/object/action/operation;
- scope/jurisdiction/stage;
- current Environment conditions;
- effective policy/control version;
- precedence among multiple rules;
- exception/waiver validity;
- default behavior when no rule applies or evaluation is indeterminate;
- revocation/currentness.

OASIS XACML is a useful hostile counterframe because different combining/default semantics can produce different final control decisions from the same component policy results.

The project does not adopt XACML's language or decision enum.

---

## 9. Retained profiles / dimensions — not children

1. **Normative / Institutional Governance**
2. **Authorization / Access Control**
3. **Gate / Approval / Separation-of-Duties**
4. **Safety / Invariant / Interlock**
5. **Limit / Quota / Resource Constraint**
6. **Enforcement Strength — advisory / procedural / mechanical**
7. **Coverage / Alternate-Path / Bypass**
8. **Exception / Waiver / Override / Precedence**
9. **Monitoring / Compliance / Control Assurance**
10. **Preventive / Detective / Mitigating effect profile**

All are important. None cleared child-promotion criteria because they overlap heavily, depend on ground-local semantics, or classify mechanism/purpose/event position rather than a stable first-order protected question.

---

## 10. Why the obvious child decompositions fail

### `Normative / Decision / Enforcement / Monitoring`
Mandatory distinctions, but false-disjoint as populations. Controls may omit layers, combine layers or distribute them across grounds.

### `Preventive / Detective / Corrective`
Useful event-chain profile; not universal control ontology and often depends on later Transition semantics.

### `Permission / Prohibition / Obligation`
Important deontic modes but too narrow for gates, limits, isolation, interlocks, revocation and escalation.

### `Advisory / Procedural / Mechanical`
Important enforcement-strength/realization dimension; not a stable hierarchy.

### `Access Control / Safety / Quality / Governance`
Domain/objective families, not universal semantic children.

### `Constraint / Gate / Intervention`
Operational shapes overlap heavily.

---

## 11. External holdout synthesis

### NIST ABAC
Shows authorization is subject/object/operation/context/policy relative, not one intrinsic Actor property.

### NIST Zero Trust
Independently separates decision, administration/execution and enforcement/monitoring concerns.

### NIST SP 800-53
Access enforcement, dual authorization, separation of duties and least privilege pressure role/authority/path scope. The least-privilege discussion of processes indirectly exposing greater privilege is especially relevant to effective/transitive power.

### OASIS XACML
Supports applicability/indeterminacy/conflict/default semantics without forcing its implementation model.

### NASA Technical Authority / decision gates
Separates project responsibility, formal delegated authority, reviews and management decisions.

### OSHA machine guarding/interlocks
Provides the strongest non-institutional hard-control counterexample and bypass-resistance pressure.

### FAA Safety Risk Management
Shows controls can be preventive/mitigating, procedural, design/equipment, warning, training, intervention and oversight mechanisms while sharing one governing purpose structure.

### Anthropic AI-native SDLC
Provides the strongest current agentic holdouts:
- advisory instruction != deterministic enforcement;
- denying one tool path != closing other network/tool/credential paths;
- direct agent restriction != effective system restriction when agent-to-agent route exists;
- human review gate can interrupt an indirect effect path.

No holdout forces an immediate child or upstream reopen.

---

## 12. Parent / upstream impact

### Relational Binding
No missing Binding distinction exposed. Control depends heavily on exact subject/object/action/path/scope/authority bindings.

### Composite Standing
No reopen required. Control confirms the Standing boundary:

```text
request currently authorized / gate satisfied / compliant
→ Standing-like result

what rule/authority/decision/enforcement governs it
→ Control
```

### Four-ground adequacy / composition parent
No fifth Ground or fifth composition region survives.

`Norms/Governance` remains cross-ground composition, not an independent peer ground.

---

## 13. Transition boundary

Control owns current governing/applicability semantics such as:
- current rule/control version;
- current revocation/waiver applicability;
- current enforcement/coverage claim.

But it does **not** own:
- how policy change propagated;
- which event caused enforcement to change;
- actual transition/effect history;
- feedback loops that adapt controls;
- causal contribution of controls to observed outcomes.

Those remain for `Transition / Effect / Feedback`.

---

## 14. Next-child sequencing re-evaluation

If K7 and user evaluation accept this Control result, the strongest next composition child is:

> **Transition / Effect / Feedback**

This is not merely because it is the last unresearched parent child.

Control closure now leaves a coherent set of unresolved questions:
- how policy/authority/standing/enforcement changes propagate;
- how controlled or uncontrolled actions produce actual Environment/Information/Work/Actor changes;
- intended versus realized effect;
- sequence versus causation;
- control failure/bypass → actual effect;
- observation → diagnosis/decision → changed control → new behavior feedback loops;
- revocation/waiver/configuration changes and their propagation/currentness;
- whether preventive/detective/mitigating profiles imply a causal/transition substructure.

Transition can now consume stable Binding + Standing + Control semantics instead of redefining them.

Do not activate Transition before Control user evaluation and a separate substantive authorization.

---

## 15. K6 judgment

Provisional result entering K7:

```text
Control / Constraint
    ← BOUNDED LEAF
    ← no immediate child promoted
    ← shared governing-control semantic core
    ← optional/non-collapsed associated layers
    ← overlapping profiles/dimensions
    ← end-to-end scope/coverage distinction retained
```

Proceed to K7 adversarial closure.