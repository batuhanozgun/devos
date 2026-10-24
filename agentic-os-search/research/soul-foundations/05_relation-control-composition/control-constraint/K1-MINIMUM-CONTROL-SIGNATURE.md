# Control / Constraint — K1 Protected Question + Minimum Control Signature

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Find the minimum cross-domain semantics required to distinguish a genuine control/constraint claim from:
- arbitrary Environment limitation;
- Actor authority standing;
- Information policy text;
- Work gate/review activity;
- Composite Standing result;
- transition history.

## 2. First correction — `authority` is not universally mandatory

The initial plan over-weighted institutional authorization.

Counterexamples:
- a machine interlock that prevents operation with a guard open;
- a rate/limit constraint designed to preserve safe operation;
- a fail-safe mechanism that blocks the next cycle after a fault;
- an automatic resource quota or invariant-enforcing mechanism.

These can have meaningful control semantics even where the protected question is not `who has legitimate authority?`.

Therefore:

> **Authority is mandatory where the control's governing force is institutional/normative/delegated, but not a universal field of every control.**

Likewise, a control can be meaningful without a separate runtime decision episode or monitoring layer.

## 3. What distinguishes a control from an arbitrary condition?

An Environment fact such as:

```text
network unavailable
```

constrains what can happen but is not automatically a `Control`.

A control question requires a governing semantics such as:

```text
this action/transition/flow is intentionally or normatively
permitted / prohibited / required / limited / gated / redirected / stopped
relative to basis B under applicability frame F
```

Physical mechanism alone is therefore insufficient:

```text
wall exists
!= wall is a control for transition T
```

The wall/interlock becomes control-relevant when its relation to the governed behavior and control objective/invariant is part of the protected question.

This prevents `Control / Constraint` from absorbing all Environment constraints.

## 4. Provisional universal control core

The strongest current minimal grammar is:

```text
Control semantic core
├─ control meaning / protected governing question
├─ governed focus
│  └─ exact action / operation / transition / flow / choice / continuation
├─ governing basis / objective / constraint
│  └─ norm, policy, requirement, invariant, safety/risk objective, assigned rule, etc.
├─ control mode / governing effect
│  └─ permit / prohibit / require / limit / gate / condition / redirect / stop / escalate ...
├─ applicability frame
│  ├─ exact subject/Actor/resource/Work/target bindings where material
│  ├─ scope / operation / stage / jurisdiction / environment conditions
│  └─ effective/reference time + version/state where material
└─ validity / precedence / exception dependencies where material
```

This is a semantic grammar, not a policy-engine schema.

## 5. Optional but non-collapsible associated layers

### 5.1 Authority / legitimacy layer

Needed when governing force depends on who may issue, approve, waive, delegate or revoke the control:

```text
authority bearer / principal / delegation
+ scope / jurisdiction / mandate
→ legitimate governing basis or decision competence
```

Do not assume:

```text
policy author != automatically legitimate authority
human approver != automatically authorized approver
credential holder != authority bearer
```

### 5.2 Evaluation / decision layer

Needed when a conditional control requires evaluating current facts/standings:

```text
request / candidate transition
+ applicable rule/control basis
+ current attributes / standings / conditions
+ conflict/default/decision semantics
→ permit / deny / require / gate outcome
```

The decision is not the policy by identity.

### 5.3 Enforcement / intervention layer

Needed when the control is mechanically realized:

```text
control decision / condition
→ mechanism constrains or enables actual path/transition
```

Examples:
- PEP/network gateway;
- sandbox/tool allowlist;
- machine guard/interlock;
- physical key/lock;
- workflow gate with actual transition authority.

Required distinction:

```text
decision says DENY
!= mechanism actually prevents transition
```

### 5.4 Coverage / path layer

Needed when the protected effect can be achieved through multiple routes:

```text
local path P1 controlled
!= effect E controlled
```

Coverage may require considering:
- alternate tools;
- delegated actors;
- service-to-service routes;
- indirect privilege/effect paths;
- physical bypasses/tamper paths.

This is not always relevant, but when bypass changes the control claim it is semantic rather than merely implementation detail.

### 5.5 Monitoring / compliance layer

Needed when the question concerns observed adherence or control performance:

```text
behavior/event evidence
+ applicable control
→ compliance/violation assessment
```

But:

```text
monitoring exists
!= behavior complies

behavior complies
!= monitoring proves it
```

Compliance standing belongs partly Composite Standing; monitoring traces are Information; observation Work remains Work. Control owns the governing requirement and, where relevant, monitoring obligation/control semantics.

## 6. Control mode is broader than legal/deontic vocabulary

Permission / prohibition / obligation are important, but insufficient as universal modes.

Cross-domain cases require at least compatibility with:
- permit/allow;
- prohibit/deny;
- require/oblige;
- limit/bound/throttle;
- gate/condition-on;
- stop/revoke/terminate;
- redirect/escalate;
- require concurrence/dual approval;
- require isolation/separation;
- permit under exception/waiver.

These are not yet children. They describe the **governing effect** on candidate behavior.

## 7. Applicability is logically prior to violation

Control existence does not imply applicability to every case.

```text
control/policy exists
!= applies to this exact actor/action/object/context/time
```

Therefore:

```text
not applicable
!= permitted
!= prohibited
!= compliant
!= violation
```

This reuses the accepted Binding + Standing distinction rather than creating a new result model.

## 8. Conflict / precedence / exception pressure

Real control regimes can contain multiple simultaneously relevant rules.

Examples:
- general deny + emergency exception;
- organizational allow + mandatory higher-level prohibition;
- policy A permits while policy B denies;
- waiver temporarily suspends one requirement;
- dual-authorization rule adds an additional condition.

The semantic result depends not merely on presence of rules but on their:
- applicability;
- precedence;
- combining/default semantics;
- exception/waiver validity.

OASIS XACML provides an external counterframe in which the same child policy decisions can yield different final outcomes under different combining algorithms. The project does not adopt XACML, but the failure mode is general.

## 9. Hard-case discrimination

### Case A — policy denies, runtime allows

Recovered semantics:
- applicable normative control: deny;
- decision may be deny;
- enforcement ineffective/absent;
- action remains technically reachable;
- behavior may violate.

No one layer can replace the others.

### Case B — runtime blocks with no legitimate policy

Recovered semantics:
- Environment/enforcement path is blocked;
- no evidence yet of legitimate normative prohibition;
- action may be technically impossible but institutionally permitted.

### Case C — approval exists, approver lacks authority

Recovered semantics:
- approval Work/record exists;
- authority binding/standing fails;
- control decision may be invalid;
- downstream transition should not be treated as legitimately authorized.

### Case D — Actor obligated but technically unable

Recovered semantics:
- normative requirement exists;
- Actor obligation standing exists;
- Environment/actionability fails;
- control does not imply capability.

### Case E — direct path denied, indirect path works

Recovered semantics:
- local enforcement works on P1;
- effect remains reachable through P2;
- whether this is control failure depends on the protected control objective/scope;
- reachability still does not establish legitimate authority.

### Case F — guard open → machine cannot cycle

Recovered semantics:
- safety/invariant basis;
- governed machine cycle;
- gate condition;
- hard enforcement/interlock;
- no separate institutional permission decision is required for the local control semantics.

This is the key counterexample to authority-first definitions.

## 10. Boundary tests after K1

### H1 Actors collapse
Rejected provisionally. Authority is one optional/constitutive layer in some controls; control also governs Work/Environment transitions and can exist in non-authority safety cases.

### H2 Standing collapse
Rejected provisionally. A standing may report `authorized/compliant/gate-satisfied`; it does not encode governing basis, enforcement or path coverage.

### H3 Environment collapse
Rejected provisionally. Hard enforcement is Environment-realized, but control semantics include governed focus/basis/mode/applicability. Arbitrary inability is not automatically control.

### H4 Work collapse
Rejected provisionally. Gate/review Work can instantiate control activity but occurrence of Work does not establish valid governing result.

### H5 Information collapse
Rejected. Policy/configuration is representational surface, not control truth/effectiveness by identity.

### H6 Transition collapse
Rejected provisionally. A control can currently govern what may happen even before any transition occurs.

## 11. K1 judgment

`Control / Constraint` survives as a coherent protected question with one provisional semantic core and several associated layers.

The main correction is:

> **Do not define Control as authority or enforcement alone. Define it around the governing relation between an exact candidate behavior/transition and an applicable governing basis, with authority, decision, enforcement, coverage and monitoring represented separately when they are semantically material.**

K2 must now test whether these associated layers are genuinely distinct and whether any deserve child status.