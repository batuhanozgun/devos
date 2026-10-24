# Control / Constraint — K2 Control-Layer Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Determine which commonly collapsed `control` meanings are genuinely distinct and where each meaning routes across accepted grounds/siblings.

Candidate layers under attack:

```text
Governing basis / norm / policy
Authority / legitimacy
Deontic/control standing
Decision / gate
Enforcement / intervention
Monitoring / observation
Compliance / effectiveness
```

## 2. Layer A — governing basis / norm / invariant

Protected question:

> What rule, requirement, objective, invariant or constraint defines how the governed focus is to be treated?

Examples:
- access policy;
- safety invariant;
- requirement requiring independent approval;
- least-privilege constraint;
- operational limit;
- mandatory review gate.

### Boundary

Its representation may be Information:

```text
policy document / configuration / rule text
```

but the represented rule is not automatically current, applicable, authoritative or enforced.

Where a governing basis is institutional, its legitimacy may additionally depend on Actors/authority. Where it is a safety/design invariant, authority may be secondary to the protected function/objective.

**Layer survives as a distinct semantic concern.**

## 3. Layer B — authority / legitimacy

Protected question:

> Who/what has standing to establish, interpret, approve, waive, delegate, revoke or adjudicate the governing basis/decision, and within what scope?

Actors remains the local semantic owner of bearer authority/delegation.

Control needs the **use relation**:

```text
authority standing
+ exact governed scope/control function
→ legitimate control source/decision competence?
```

### NASA Technical Authority pressure

NASA explicitly separates:
- program/project responsibility;
- formally delegated Technical Authority;
- approval of changes/waivers;
- independent checks/balances.

A person working on or managing a project is not thereby the authority for every waiver/technical decision.

### Boundary

```text
Actor has authority standing
!= every decision by Actor is within scope

human involved
!= legitimate authority
```

**Layer survives where normative/institutional force is material, but is not universal to every technical/physical control.**

## 4. Layer C — deontic / governing standing

Candidate meanings:
- permitted;
- prohibited;
- required/obligated;
- exempt/waived;
- conditionally allowed.

These are often **standing-like outcomes** relative to an applicable governing basis.

Examples:

```text
Actor A is permitted to execute operation O on resource R now
Work W requires approval before transition T
Actor A is obligated to perform W under mandate M
```

### Routing conclusion

The modality is part of Control semantics, but the **current result** for an exact focus is often a Composite Standing or Actors standing.

Therefore:

```text
control modality
!= current deontic standing by identity
```

**Not a separate Control layer population; it is the governing effect encoded by a control and realized as standing when applied.**

## 5. Layer D — evaluation / decision / gate

Protected question:

> Given current applicable control basis and facts/standings, what governing decision applies to this exact candidate behavior?

Examples:
- permit/deny/revoke;
- approve/reject;
- gate open/closed;
- escalate;
- require additional concurrence;
- exception applies/does not apply.

### NIST ZTA pressure

NIST SP 800-207 separates the policy engine's grant/deny/revoke decision from the policy administrator that executes the decision and the enforcement point that enables/monitors/terminates access.

This does not define the Foundation model, but independently falsifies:

```text
policy == decision == enforcement
```

### XACML pressure

XACML distinguishes:
- Permit;
- Deny;
- Indeterminate;
- NotApplicable;

and makes final outcomes depend on combining/default algorithms.

Foundation implication:

```text
no applicable rule
!= permit
!= deny
!= indeterminate
```

and:

```text
same child decisions
+ different precedence/combining semantics
→ potentially different final decision
```

### Boundary to Standing

A decision outcome such as `request authorized` may be a Composite Standing/result. Control owns the semantics of the governing decision procedure/regime, not every status value by identity.

**Layer survives as distinct, but heavily composes with Standing and Work.**

## 6. Layer E — enforcement / intervention

Protected question:

> What mechanism or realized intervention makes the governed effect effective against actual candidate paths/transitions?

Examples:
- PEP terminates/disallows session;
- sandbox denies tool/system call;
- interlock prevents machine cycle;
- physical guard blocks access;
- deployment gate prevents merge/release transition;
- quota/rate limiter constrains action volume.

### Critical distinctions

```text
deny decision
!= denied path actually blocked

mechanism blocks
!= legitimate prohibition exists

one mechanism blocks one route
!= protected effect is unreachable by all relevant routes
```

### Environment boundary

Mechanism existence/state is Environment. Control adds the relation between mechanism behavior and the governing control objective/focus.

A failed/misconfigured enforcement mechanism is therefore:
- an Environment condition;
- potentially a control-effectiveness failure;
- not proof that the governing rule disappeared.

**Layer survives as distinct and optional; some controls are advisory/organizational and have no direct mechanical enforcement.**

## 7. Layer F — monitoring / observation

Protected question:

> What observation/telemetry/audit activity or mechanism detects relevant behavior/control state?

Examples:
- logs;
- policy decision logs;
- permission events;
- guard/interlock health checks;
- access/session telemetry;
- audit/review evidence.

### Boundary

Monitoring is frequently:
- Information production/exposure;
- Work/observation activity;
- Environment sensor/logging capability.

Control significance arises when monitoring is itself required by the governing regime or used to detect violation/failure.

```text
not observed
!= did not happen

observed as compliant
!= actually compliant
```

**Layer is optional and cross-cutting, not universal control core.**

## 8. Layer G — compliance / violation / effectiveness

Candidate claims:
- behavior complied/violated;
- control operated as intended;
- control prevented prohibited effect;
- control coverage sufficient;
- residual risk acceptable.

These are mostly **standing/evaluation results**, not governing controls themselves.

Required distinctions:

```text
control exists
!= control applicable
!= control correctly configured
!= control enforced
!= behavior complied
!= control effective against objective
```

Control effectiveness can require counterfactual/causal evidence and may therefore pressure deferred Transition/Causation later.

**Not promoted as an internal Control layer population; treated as Standing/assessment over Control + actual behavior/effects.**

## 9. Cross-layer failure matrix

| Case | Governing basis | Authority | Decision | Enforcement | Monitoring | Result |
|---|---|---|---|---|---|---|
| Policy denies, runtime allows | present | may be valid | deny | fails/absent | any | violation reachable |
| Runtime blocks without policy | absent/unknown | none/irrelevant | none | blocks | any | technical block, not normative deny |
| Approval by wrong person | present | invalid/out-of-scope | apparent approve | may enforce | logged | decision legitimacy fails |
| Stale policy engine permits revoked privilege | updated rule | valid | stale/wrong permit | allows | may detect | enforcement follows invalid decision |
| Behavior complies unobserved | present | valid | as applicable | maybe | absent | actual compliance may still hold |
| Monitor says compliant, bypass used | present | valid | deny on guarded path | local enforcement works | incomplete | protected effect still occurs |

No single layer predicts the rest.

## 10. Do these layers form immediate children?

Current answer: **not yet**.

Reasons:
1. several are optional;
2. their local semantics belong to accepted grounds/siblings;
3. one real control episode can instantiate all layers simultaneously;
4. authority may be constitutive in institutional controls but absent from physical controls;
5. decision can be trivial in fixed constraints but complex in policy systems;
6. monitoring/effectiveness are evaluation overlays, not peer governing kinds.

The layers are currently best retained as a **control-semantic stack/checklist**, not a hierarchy.

## 11. Important non-collapse result

The strongest current chain is:

```text
governing basis
→ [authority/legitimacy where material]
→ [current applicability / facts]
→ [decision/gate where conditional]
→ [enforcement/intervention where realized]
→ actual behavior/effect
→ [monitoring/evidence]
→ compliance/effectiveness assessment
```

This arrow notation is explanatory only. It is not a mandatory workflow: controls can omit layers, operate continuously, or have institutional decisions that are constitutive rather than sequential.

## 12. K2 judgment

The commonly collapsed control meanings are genuinely distinct, but they do **not** currently justify separate immediate children.

K3 must now pressure the hardest area left unresolved:

> modality, exceptions, authority/delegation, separation of duties, gates and **alternate-path/bypass closure**.