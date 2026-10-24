# Control / Constraint — K0 Canonical / Evidence Recovery

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Recover only current accepted inputs and freeze falsifiers before defining Control.

This pass does not assume the parent label is correct. `Control / Constraint` must survive collapse into accepted grounds, Binding, Standing or deferred Transition.

## 2. Canonical starting state

Accepted upstream:

```text
Environment / Operating Reality                 ← accepted
Information / Representation                    ← accepted
Work                                             ← accepted
Actors / Agency–Participation–Authority          ← accepted
post-deepening four-ground adequacy              ← accepted
Cross-Ground Composition parent                  ← accepted
Relational Binding                               ← accepted bounded leaf
Composite Standing / Qualification               ← accepted bounded leaf
Control / Constraint                             ← active child under test
Transition / Effect / Feedback                   ← deferred/inactive
```

## 3. Inherited semantic boundaries

### 3.1 From Actors

Critical deferred distinction:

```text
Actor authority / permission / obligation
!= Environment technical enforcement
!= reachable effect power
!= Work admission / requiredness
!= Information saying authority exists
```

Highest-priority deferred problem:

```text
reachable effect power != legitimate authority
```

Actors also preserved:
- direct versus delegated authority;
- represented principal;
- credential possession versus legitimate authority;
- human involvement versus actual authorization;
- performer versus requester/decider/authorizer/accountable party.

### 3.2 From Work

```text
approval/review/gate Work occurred
!= transition legitimately permitted

Work requiredness
!= Actor obligation

Work acceptance state
!= authority to accept
```

Work provides candidate actions/transitions/pursuits and gate/review activities; it does not by itself establish normative or enforcement semantics.

### 3.3 From Environment

```text
resource/tool/path unavailable
!= normatively prohibited

sandbox/firewall/interlock blocks path
!= legitimate policy exists

credential/network/tool path available
!= authorized
```

Realized mechanisms/conditions are Environment facts. A mechanism can enforce a control, but existence of the condition is not identical to the control's normative/decision semantics.

### 3.4 From Information

```text
policy/rule/configuration/instruction exists as Information
!= policy is current/applicable/authoritative
!= legitimate authority exists
!= behavior is actually constrained
```

### 3.5 From Relational Binding

Control must rely on exact binding semantics for:
- governed subject/Actor;
- object/resource/target;
- operation/action/transition;
- authority/delegation relation;
- policy/criterion applicability;
- scope/time/environment conditions;
- enforcement path/tool/channel.

But Binding alone answers only what is connected, not what behavior is governed.

### 3.6 From Composite Standing

Standing can express current results such as:
- authorized for operation O;
- gate satisfied;
- compliant/noncompliant;
- approval valid;
- exception applicable.

Control must preserve what **makes** those results governing or actionable:
- rule/norm;
- authority;
- decision semantics;
- enforcement/intervention;
- path/bypass coverage.

Standing residuals explicitly defer authorization/decision-rule boundaries to this pass.

## 4. Parent hard-case recovery

Parent composition research supplied:

```text
policy text
!= legitimate authority
!= authorization/decision outcome
!= actual technical enforcement
!= observed compliant behavior
```

and the transitive-authority case:

```text
Actor A lacks direct privileged route
A can invoke Actor B
B can invoke privileged tool
→ effect may be reachable

reachable effect power
!= legitimate delegated authority
```

These are mandatory Control hard cases.

## 5. Candidate-study recovery

### Anthropic AI-native SDLC

Reusable control pressure:
- `CLAUDE.md`/instructions/skills are advisory context, not hard enforcement by identity;
- hooks/settings/permissions/sandbox/identity/network/tool restrictions provide progressively harder control surfaces;
- autonomy is action/environment/risk-specific;
- a reported agent-to-agent transitive-authority attempt was stopped by a human review gate;
- monitoring covers permission/tool/hook/subagent events;
- configuration itself needs regression evaluation.

This is a falsifier, not a Foundation taxonomy source.

### Multi-agent patterns

Reusable pressure:
- hierarchy/manager label != authority;
- critic/verifier label != independence/valid verification;
- delegation and control topology matter;
- hidden human orchestration can carry actual control not represented in nominal agent graph.

### Context / Memory / Harness Engineering

Reusable pressure:

```text
documented instruction
!= deterministic runtime enforcement
```

and permissions/orchestration/verification may reside in harness/runtime rather than working context.

## 6. Authoritative external pressure recovered for later K5

Observed/recovered 2026-09-05; details deferred to K5.

### NIST SP 800-162 — ABAC

Authorization is evaluated over:
- subject attributes;
- object attributes;
- requested operation;
- Environment conditions where material;
- policies/rules/relationships.

Useful pressure: authorization is request/context-specific, not a timeless Actor property.

### NIST SP 800-207 — Zero Trust Architecture

Useful logical distinction:
- policy engine makes grant/deny/revoke decision;
- policy administrator executes the decision and configures paths;
- policy enforcement point enables/monitors/terminates communication;
- external state/policy/identity/log sources feed decisions.

This is strong independent pressure for `policy/evidence → decision → enforcement → monitoring` non-collapse, while remaining one architecture-specific model.

### NIST SP 800-53 Rev. 5.1

Useful holdouts:
- AC-3 access enforcement: enforce approved authorizations;
- AC-3(2) dual authorization;
- AC-5 separation of duties;
- AC-6 least privilege;
- discussion of indirect privilege escalation through software/processes;
- monitoring/revocation controls.

Useful pressure: control adequacy can depend on role separation, path/privilege scope and ongoing revocation, not one permit bit.

### OASIS XACML 3.0

Useful holdout:
- Permit / Deny / Indeterminate / NotApplicable are distinct decision outcomes;
- combining algorithms such as deny-overrides, permit-overrides, deny-unless-permit and permit-unless-deny embody different conflict/default semantics.

Useful pressure:

```text
same applicable policies
+ different combining/default semantics
→ different control decision
```

### NASA Technical Authority / Systems Engineering

Useful pressure:
- formal delegated Technical Authority is separate from programmatic responsibility;
- changes/waivers require appropriate authority;
- independent checks and balances matter;
- decision body and decision criteria should be explicit;
- technical reviews can support but are not identical to management go/no-go decisions.

### OSHA machine guarding / interlocks

Useful pressure:
- a physical/interlocked guard can mechanically prevent operation/access;
- an interlock may stop power or prevent starting when unsafe configuration exists;
- controls can be physically realized and bypass/tamper resistance matters.

This provides a non-software counterexample to treating Control as policy/decision only.

### FAA Safety Risk Management

Useful pressure:
- preventive controls can block hazard propagation;
- mitigating controls can reduce consequence after an event;
- ineffective controls can explain adverse outcomes.

This will test whether preventive/mitigating/corrective style taxonomies deserve Foundation child status or remain profiles.

## 7. Frozen falsifiers entering K1

### H1 — Actors collapse

`Control = authority/permission/obligation` and therefore adds no region beyond Actors.

### H2 — Standing collapse

`Control = current authorization/eligibility/compliance standing` and therefore adds no region beyond Composite Standing.

### H3 — Environment collapse

Hard control is only realized technical/physical constraint, so Control is Environment state/condition.

### H4 — Work collapse

Control is merely approval/gate/review Work or Work admission rules.

### H5 — Information collapse

Control is policy/rule/configuration Information plus ordinary execution.

### H6 — Transition collapse

Control has no independent present semantics; it is simply transition preconditions/triggers and effect history.

### H7 — Layer-child hypothesis

Stable immediate children exist:

```text
Normative / Policy Control
Decision / Authorization Control
Enforcement / Intervention Control
Monitoring / Compliance Control
```

### H8 — Mode-child hypothesis

Stable children exist by control mode:

```text
Preventive
Detective
Corrective / Mitigating
```

### H9 — Deontic-child hypothesis

Permission / Prohibition / Obligation are stable peer children.

### H10 — Alternate-path fifth-region hypothesis

`Effective Power / Path Closure / Attack Surface` cannot be represented as Binding + Standing + Control and requires a fifth composition region.

### H11 — Architecture-detail objection

Path/bypass/enforcement semantics are implementation details and should not appear at Foundation depth.

### H12 — Fifth-ground / parent failure

Norms/Governance/Control becomes an independent fifth Foundation ground or parent decomposition fails.

## 8. Mandatory failure cases entering K1

```text
policy says DENY, runtime allows
runtime blocks, legitimate policy absent
request authorized, Actor technically incapable
Actor obligated, action technically impossible
approval exists, approver lacks authority
gate satisfied, approval/authorization absent
direct path denied, indirect Actor/tool path reaches effect
human approves, but human lacks relevant mandate/expertise
policy permits, stale enforcement still denies
policy revokes, existing session/path remains open
behavior complies, but monitoring is absent
monitoring reports compliance, actual behavior violates
waiver/exception applies, generic prohibition still shown
producer self-approves despite separation-of-duties requirement
```

## 9. K0 judgment

A genuine residual problem remains after Binding and Standing:

> how rules, authority, modalities, decisions, mechanisms and coverage jointly **govern** candidate behavior/transitions.

This is enough to continue the Control child without presuming its final structure.

Proceed to K1.