# Control / Constraint — K3 Modality / Gate / Authority / Path / Bypass Audit

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Stress the Control hypothesis with cases where:
- several governing modalities coexist;
- control depends on authority/delegation;
- approval/gate semantics span Work and Standing;
- local enforcement can be bypassed through alternate paths;
- exceptions/default behavior change outcomes.

## 2. Control modality map

The following governing effects recur across domains:

```text
allow / permit
prohibit / deny
require / oblige
limit / bound / throttle
condition / gate
require concurrence / dual authorization
stop / revoke / terminate
redirect / escalate
isolate / separate
waive / exempt / override
```

### Result

No single binary `allowed` dimension is sufficient.

However, these modes are not clean populations:
- `gate` often implements conditional permission;
- `revoke` changes a prior permission;
- `dual authorization` is a condition on permission;
- `limit` can combine permission and quantitative constraint;
- `escalate` can be the required next action after an indeterminate decision;
- waiver modifies applicability/precedence of another control.

Therefore mode vocabulary is a **dimension/profile**, not a child hierarchy.

## 3. Permission, prohibition and obligation remain non-collapsible

```text
permitted(X)
!= required(X)

not permitted(X)
!= necessarily obligated(not-X)

prohibited(X)
!= technically impossible(X)

required(X)
!= actionable(X)
```

Example:
- an Actor can be obligated to produce a safety report while the required information source is unavailable;
- an action can be technically possible but prohibited;
- an action can be permitted but unnecessary.

This preserves deontic semantics without making deontic logic the universal Control taxonomy.

## 4. Gates — four different things routinely collapse

A `gate` can refer to:

1. **criterion / prerequisite** — what must hold;
2. **standing** — whether the prerequisite currently holds;
3. **decision/control** — whether progression is permitted;
4. **enforcement** — whether progression can actually occur.

It may also involve **review/approval Work** that evaluates the standing.

Therefore:

```text
review completed
!= gate criterion satisfied
!= authorized go decision
!= transition mechanically enabled
```

### NASA decision-gate pressure

NASA systems-engineering material distinguishes technical reviews that support management decision gates from the management go/no-go decision itself. The decision body/authority and decision criteria are explicit concerns.

Foundation implication:

> A review is Work; readiness evidence/standing can support a gate; the governing go/no-go semantics belong to Control; the later phase transition belongs to Transition.

No `Gate` child is forced.

## 5. Authority / delegation / waiver

### 5.1 Authority is scoped and typed

```text
Actor is authoritative in role R
!= authority for control C / decision D / waiver W
```

Control use of authority requires exact bindings for:
- governed domain/scope;
- type of decision;
- requirement/control owner;
- delegation chain;
- effective time;
- exception/waiver competence.

### 5.2 Expertise != authority

```text
expert / verifier / reviewer
!= authorization authority
```

NASA Technical Authority provides an independent institutional counterexample: program responsibility and delegated technical authority are separated, and working-level expertise does not by itself confer formal Technical Authority.

### 5.3 Approval artifact != valid approval

```text
approval record exists
+ wrong/out-of-scope Actor
→ approval may be informationally real but control-invalid
```

This depends on:
- Binding: who approved what;
- Actors: authority standing;
- Standing: approval validity;
- Control: approval/gate semantics.

### 5.4 Waiver / exception

A waiver can change control applicability without erasing the underlying rule.

```text
general requirement exists
+ valid scoped waiver
→ requirement may not govern this exact case during waiver scope/time
```

Required distinction:

```text
waiver exists as document
!= valid waiver
!= waiver applies here
!= original rule deleted
```

No separate Exception child is forced.

## 6. Separation of duties and independent approval

### External pressure

NIST SP 800-53 AC-5 distinguishes duties that require separation and access authorizations supporting that separation. AC-3(2) provides dual-authorization pressure.

### Foundation reconstruction

A separation-of-duties control can require:
- at least two distinct Actor positions;
- prohibited overlap of roles/bearers;
- exact Work/decision scopes;
- valid authority of each participant;
- enforcement that prevents one bearer from satisfying incompatible positions;
- evidence/monitoring if compliance must be demonstrated.

Critical rules:

```text
two role labels
!= two independent Actors

producer and verifier names differ
!= independence automatically established

human approval present
!= separation-of-duties satisfied
```

This is a **Control profile using Binding + Actors + Work + Standing**, not a stable child.

## 7. The key discovery — governed-effect scope != enforcement-point scope

Suppose the protected control objective is:

> Actor A must not cause production-write effect E without approval.

Local enforcement:

```text
A ─X→ privileged tool P
```

may correctly block the direct route.

But an alternate path may exist:

```text
A → Actor B → privileged tool P → E
```

or:

```text
A → service S1 → service S2 → E
```

or a physical/manual bypass.

Therefore:

```text
one guarded path is blocked
!= governed effect is controlled
```

### 7.1 Two scopes must be preserved

**Control-objective scope**
- what action/effect/flow must be governed;
- which actors/principals/resources are in scope;
- what indirect action counts as causing/achieving the protected effect.

**Enforcement-point scope**
- which concrete path/operation/channel the mechanism can observe/block/allow.

A mismatch can yield control failure even when the enforcement mechanism itself behaves exactly as configured.

### 7.2 Path closure is conditional, not universally exhaustive

Control adequacy does not require enumerating every theoretically possible path in every domain.

The relevant path universe depends on:
- protected objective;
- reachable environment topology;
- delegation/orchestration semantics;
- threat/failure model;
- allowed intermediaries;
- decision-critical risk.

Therefore `path closure` is not a universal implementation prescription.

But when an alternate path materially changes whether the control objective holds, **coverage is Foundation-semantic**.

## 8. Effective power versus authority

The agentic case exposes four separate questions:

```text
1. Is direct operation permitted?
2. Is direct operation technically reachable?
3. Is the protected effect reachable indirectly?
4. Is the indirect effect legitimately authorized/delegated?
```

Possible state:

```text
direct permission = deny
direct technical path = blocked
indirect effect path = reachable
legitimate delegation = absent
```

Hence:

```text
effective effect power
!= legitimate authority
!= local authorization result
```

`Effective Power` does not become a fifth composition region because it can be analyzed through:
- Binding/reachability relations;
- Actor/Environment/Work state;
- Composite Standing for reachability/actionability;
- Control scope/coverage;
- later Transition for actual realized effect.

H10 is rejected provisionally.

## 9. Fail-open / fail-closed / indeterminate defaults

Conditional control may face:
- missing attributes;
- unreachable decision service;
- conflicting rules;
- evaluation error;
- stale state;
- timeout.

Different regimes can choose:
- deny unless explicit permit;
- permit unless explicit deny;
- preserve indeterminate and escalate;
- require human/manual resolution;
- maintain current session temporarily;
- terminate/revoke.

OASIS XACML demonstrates that default/combining semantics can materially change final permit/deny outcomes even with the same component decisions.

Foundation result:

> **Conflict/default semantics are part of the governing decision semantics when they change outcomes.**

No universal `fail-closed` rule is inferred; safety, availability and mission domains can have different justified defaults.

## 10. Revocation and ongoing authorization

A permission can be revoked while:
- an existing session remains open;
- cached credentials remain usable;
- enforcement has not received the update;
- indirect routes remain available.

Therefore:

```text
authority/policy changed
!= effective control changed everywhere immediately
```

Current Control semantics must preserve:
- effective policy/decision time;
- revocation applicability;
- whether enforcement is current enough for the claim.

But the event propagation/history of revocation remains deferred to Transition.

## 11. Monitoring and bypass

A monitor attached to enforcement point P can faithfully report:

```text
no prohibited events crossed P
```

while the protected effect occurred through P2.

Thus:

```text
monitor says local control complied
!= end-to-end control objective satisfied
```

This further supports control-objective scope versus observation/enforcement scope.

## 12. Hard-case outcomes

### Policy says no, runtime allows
Normative control survives; enforcement fails.

### Runtime blocks, no legitimate policy
Technical constraint exists; normative control claim not established.

### Direct path denied, alternate path succeeds
Local enforcement success; end-to-end control coverage potentially fails.

### Human gate present, human lacks authority
Workflow topology exists; legitimate gate decision fails.

### Actor required but unable
Obligation/control remains; actionability fails.

### Emergency waiver valid
Generic control still exists; applicability is modified for scoped case.

### Producer self-approves under separation rule
Review/approval Work may occur; control condition fails.

## 13. K3 structural judgment

The strongest additional semantic requirement is:

```text
control-objective / governed-effect scope
!= enforcement-point / monitored-path scope
```

and therefore:

> Control must be able to reason about **coverage and bypass relative to the protected governing objective**, not merely local permit/deny mechanisms.

This does not force a new child or fifth composition region.

K4 must now test serious internal decompositions and rival taxonomies rather than promote the discovered layers by intuition.