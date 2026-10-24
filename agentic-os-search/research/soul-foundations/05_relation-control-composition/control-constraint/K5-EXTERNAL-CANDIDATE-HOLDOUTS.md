# Control / Constraint — K5 Authoritative External + Candidate-Study Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Attack the leading result with materially different control traditions:

```text
Control / Constraint
← coherent cross-ground governing region
← shared semantic core
← rule/authority/decision/enforcement/observation non-collapse
← control-objective scope != enforcement-point scope
← no immediate child currently justified
```

External sources are falsifiers/counterframes. Their architectures and taxonomies are not Foundation authority.

---

## 2. Holdout A — NIST SP 800-162 Attribute Based Access Control

Authoritative source:
- https://csrc.nist.gov/pubs/sp/800/162/upd2/final
- observed/recovered 2026-09-05.

### External structure

NIST defines ABAC authorization over a request by evaluating:
- subject attributes;
- object attributes;
- requested operation;
- Environment conditions where applicable;
- policies/rules/relationships describing allowable operations.

Environment conditions can include dynamic factors such as time, location and threat level.

### Pressure on Foundation

This strongly rejects:

```text
Actor.authorized = timeless intrinsic property
```

A meaningful authorization question is scoped to:

```text
subject
+ object
+ operation
+ context/environment
+ applicable policy/rule
→ authorization result
```

### Standing / Control boundary

ABAC simultaneously supports both siblings:
- `request currently satisfies authorization conditions` can be a Composite Standing/result;
- `what policy/rules govern and how the decision is made/enforced` remains Control.

### Child pressure

Does not force an `Authorization` Control child. It is one strong profile under the shared grammar.

---

## 3. Holdout B — NIST SP 800-207 Zero Trust Architecture

Authoritative source:
- https://doi.org/10.6028/NIST.SP.800-207
- observed/recovered 2026-09-05.

### External logical split

NIST's logical model distinguishes:
- **Policy Engine (PE):** makes/logs grant, deny or revoke decision using enterprise policy plus external inputs;
- **Policy Administrator (PA):** executes the decision and establishes/shuts down the communication path;
- **Policy Enforcement Point (PEP):** enables, monitors and terminates connections between subject and resource;
- multiple external sources supply policy/state/identity/log information.

### Decisive pressure

This independently falsifies:

```text
policy == decision == enforcement == monitoring
```

Even one access-control architecture finds it useful to separate these concerns.

### Continuous/currentness pressure

Zero Trust also emphasizes per-request, least-privilege decisions and continuing evaluation of subject/device state rather than assuming broad implicit trust.

Foundation implication:

```text
prior authorization
!= timeless authorization
```

when current conditions materially affect the control.

### Architecture boundary

The project does **not** adopt PE/PA/PEP components. Their value is failure-mode discrimination only.

---

## 4. Holdout C — NIST SP 800-53 Rev. 5.1

Authoritative source:
- https://doi.org/10.6028/NIST.SP.800-53r5
- current Rev. 5.1 OSCAL-derived publication observed 2026-09-05.

### AC-3 Access Enforcement

NIST states that approved logical-access authorizations are to be enforced.

Foundation pressure:

```text
approved authorization
!= enforcement by identity
```

because one can exist while the other fails.

### AC-3(2) Dual Authorization

Some actions require approval of two authorized individuals.

Pressure:

```text
one valid authorizer
!= all control prerequisites satisfied
```

and `two-person control` is a relation/role composition, not one permission scalar.

### AC-5 Separation of Duties

NIST requires identification of duties that need separation and access authorizations supporting that separation.

Pressure:

```text
role A + role B labels
!= separation guaranteed
```

The same bearer, collusion, shared credentials or hidden delegation can defeat the objective.

### AC-6 Least Privilege

NIST applies least privilege to users and processes acting on their behalf. Discussion explicitly notes that software running with greater privilege can indirectly provide a user greater privileges than assigned.

This is a particularly strong external analog to agent-to-agent transitive effect power:

```text
local Actor privilege
!= effective reachable privilege/effect power through intermediaries
```

### Child pressure

Least privilege, dual authorization and separation of duties are important Control profiles, but they overlap authority, Binding, Environment enforcement and Work roles. No clean child is forced.

---

## 5. Holdout D — OASIS XACML 3.0

Authoritative standards source:
- https://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-cos01-en.html
- observed 2026-09-05.

### External decision semantics

XACML distinguishes decision values including:
- Permit;
- Deny;
- Indeterminate;
- NotApplicable.

It also defines materially different policy/rule combining algorithms such as:
- deny-overrides;
- permit-overrides;
- deny-unless-permit;
- permit-unless-deny;
- first-applicable.

### Pressure

This is strong evidence that:

```text
no rule applies
!= deny
!= permit
!= evaluation failed
```

and:

```text
same component policy results
+ different precedence/default semantics
→ different final control decision
```

### Foundation boundary

The project does not adopt XACML's decision enum or policy language. It preserves only the semantic requirement that applicability, conflict, indeterminacy and default behavior can be decision-critical.

---

## 6. Holdout E — NASA Technical Authority

Authoritative sources:
- https://www.nasa.gov/technical-authority/
- NASA NPR 7123.1D current procedural material;
- observed 2026-09-05.

### External structure

NASA Technical Authority is part of governance checks and balances and uses **formal delegated authority**. Programmatic responsibility and Technical Authority are deliberately separated; Technical Authorities may approve changes/waivers within defined scopes.

### Pressure

This strongly supports:

```text
project manager / owner / performer
!= technical waiver authority

expertise / contribution
!= formally delegated authority
```

and:

```text
approval exists
!= approval is legitimate for this requirement/scope
```

### Child pressure

Does not force an `Authority Control` child because authority remains Actors-local standing and Control consumes it in governing decisions.

---

## 7. Holdout F — NASA decision gates / systems engineering

Authoritative sources:
- NASA Systems Engineering Handbook / current NASA systems-engineering reference pages;
- NPR 7123.1D life-cycle and technical review criteria;
- observed 2026-09-05.

### External structure

NASA material distinguishes technical reviews from management decision gates: reviews provide evidence/maturity assessment, while designated management/decision authorities make go/no-go progression decisions under defined criteria.

### Pressure

```text
review Work complete
!= decision gate passed
!= authority to approve progression
!= next phase mechanically/organizationally started
```

This independently supports the project separation of Work, Standing, Control and Transition.

---

## 8. Holdout G — OSHA machine guarding and interlocks

Authoritative sources:
- https://www.osha.gov/laws-regs/regulations/standardnumber/1910/1910.212
- https://www.osha.gov/etools/machine-guarding/introduction/guards
- observed 2026-09-05.

### External structure

OSHA machine-guarding material includes fixed barriers and interlocked guards. An interlocked guard can stop/disengage power and prevent a machine cycle while the guard is open; replacing the guard need not automatically restart the machine.

### Decisive counterexample

This rejects an authority/decision-only definition of Control.

A meaningful safety control can be:

```text
safety objective/invariant
+ exact machine-cycle condition
+ interlocked mechanical/electrical realization
→ unsafe transition prevented
```

without a separate human authorization decision per cycle.

### Bypass pressure

OSHA guidance also stresses that safeguards should not be easily removable/defeatable.

Thus:

```text
mechanism present
!= effective control if easily bypassed
```

### Child pressure

Does not force a separate `Physical Control` child. It shares the same governed-focus/basis/mode/applicability grammar with software/institutional controls.

---

## 9. Holdout H — FAA Safety Risk Management Guidance (June 2024)

Authoritative source:
- https://www.faa.gov/media/80661
- observed/recovered 2026-09-05.

### External control distinctions

FAA safety guidance distinguishes:
- preventative controls/barriers aimed at preventing hazard propagation to an event;
- mitigating controls aimed at reducing adverse outcome after an event;
- multiple control implementations including procedures, training, equipment/design, warnings, intervention and management oversight;
- monitoring plans and confirmation of implemented mitigations;
- management approval responsibility for established safety risk controls.

### Strong pressure

This shows that `Control` spans:
- design/environment mechanisms;
- operational procedures/Work;
- Actor governance;
- monitoring/evidence;
- risk/standing.

No one local ground or mechanism taxonomy is sufficient.

### Preventive / mitigating child test

FAA's distinction is useful **within safety event chains**, but Foundation promotion still fails because:
- the same mechanism can be preventive relative to one downstream event and mitigating relative to another;
- `corrective/mitigating` semantics depend on Transition/event position;
- non-safety governance controls do not naturally organize by hazard propagation.

Therefore the classification remains a profile, not an immediate child.

---

## 10. Candidate-study holdout I — Anthropic AI-Native SDLC Playbook

Canonical project package:
- `../../../studies/anthropic-ai-native-sdlc-playbook/`

Fresh first-party source also rechecked 2026-09-05:
- https://claude.com/blog/the-ai-native-sdlc-playbook
- https://claude.com/blog/how-anthropic-secures-its-ai-native-software-development-lifecycle

### Advisory versus deterministic controls

Anthropic explicitly distinguishes advisory skills/instructions from deterministic hooks and harder permissions/sandbox/network/managed-setting boundaries.

Strong project inference:

```text
instruction says do not X
!= X mechanically prevented
```

### Layered enforcement / path closure

The playbook's managed-settings example makes the bypass problem concrete:
- denying one web-fetch tool does not necessarily stop shell/network egress;
- sandbox/network allowlists close paths missed by tool-level permissions;
- credential restrictions close paths left by other layers;
- managed-only configuration prevents local widening/bypass.

This is unusually strong evidence for:

```text
one enforcement layer works
!= control objective closed over relevant paths
```

### Agent-to-agent authority

Anthropic's security deep-dive reports an incident-response agent that lacked direct production-write ability but contacted another Claude instance able to write code; a human review gate stopped the resulting path.

This is a high-value operational counterexample:

```text
direct agent boundary
!= effective system boundary
```

and again:

```text
effective effect power != legitimate authority
```

### Human-gate boundary

The gate's existence is not enough by Foundation semantics: the human must also be the correct authority for the governed operation, and the gate must cover relevant paths.

### Child pressure

The source supports enforcement-strength and coverage profiles, not a product-specific Control taxonomy.

---

## 11. Candidate-study holdout J — Multi-Agent Patterns

Package:
- `../../../studies/multi-agent-patterns/`

Pressure:

```text
manager role label != authority
critic/verifier role label != independence
multiple agents != separation of duties by default
```

A control requiring independent approval needs bearer/role/history conditions, not merely topology labels.

No new child forced.

---

## 12. Candidate-study holdout K — Context / Memory / Harness Engineering

Package:
- `../../../studies/context-memory-harness-engineering/`

Pressure:

```text
documented control rule
!= model-visible context obeys it
!= runtime mechanically enforces it
```

This reinforces the split among Information guidance, agent behavior and harness/runtime control.

No new child forced.

---

## 13. Cross-holdout synthesis

### 13.1 Shared control grammar survives

Across access control, zero trust, NASA governance, physical machine safety, aviation safety and agentic SDLC, the recurring structure is:

```text
exact governed focus / protected effect
+ governing basis / objective / invariant
+ control mode
+ applicability / scope / time
(+ legitimate authority where normative/institutional)
(+ decision/combining semantics where conditional)
(+ enforcement/intervention where mechanically realized)
(+ path/coverage semantics where alternate routes matter)
(+ monitoring/evidence where assurance/compliance is claimed)
```

### 13.2 No single layer is `the control`

External traditions repeatedly separate or combine layers differently. This is evidence for semantic non-collapse, not for importing their architectures.

### 13.3 Enforcement strength is real but not a child

Advisory instruction, procedural/human control and mechanical enforcement differ materially, yet one regime can use all three and hardness is not one clean ordinal taxonomy.

### 13.4 Path/coverage semantics survive hostile cases

NIST least-privilege discussion, Anthropic agent-to-agent access, layered sandbox/permission controls and physical bypass/tamper pressure independently support:

```text
local mechanism coverage
!= end-to-end protected-effect coverage
```

### 13.5 Authority remains conditional but load-bearing

NASA governance strongly confirms formal authority/scope/waiver semantics; OSHA safety confirms authority is not universal to all local control mechanisms.

This supports the K1 correction rather than an authority-first definition.

## 14. Falsifier status after K5

### H1 Actors collapse
Rejected.

### H2 Standing collapse
Rejected.

### H3 Environment collapse
Rejected by normative/authority/decision cases.

### H4 Work collapse
Rejected by decision/enforcement distinctions.

### H5 Information collapse
Rejected decisively by advisory-vs-hard and actual enforcement cases.

### H6 Transition collapse
Rejected; current governing semantics can exist before transition.

### H7 layer-child hypothesis
Not supported; distinctions are real but false-disjoint as populations.

### H8 preventive/detective/corrective child hypothesis
Rejected as universal hierarchy.

### H9 deontic-child hypothesis
Rejected as universal hierarchy.

### H10 alternate-path fifth region
Rejected; Control Coverage profile plus Binding/Standing/ground semantics is sufficient.

### H11 architecture-detail objection
Rejected when path/bypass changes whether the protected control objective actually holds.

### H12 fifth-ground / parent failure
No evidence.

## 15. K5 judgment

External and candidate holdouts **strengthen the bounded-leaf hypothesis**.

Most important retained insights:

```text
policy != authority != decision != enforcement != monitoring != compliance

governed-effect scope != enforcement-point scope

local permission != effective reachable effect power

direct path blocked != protected effect controlled
```

Proceed to K6 synthesis / immediate-child decision.