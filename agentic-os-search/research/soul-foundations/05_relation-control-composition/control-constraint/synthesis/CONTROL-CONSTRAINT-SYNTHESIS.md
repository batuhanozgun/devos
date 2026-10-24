# Control / Constraint — Integrated Synthesis

**Status:** bounded synthesis / awaiting user evaluation  
**Date:** 2026-09-05

## Executive conclusion

`Control / Constraint` survives as the third coherent child of accepted Cross-Ground Composition.

Strongest current result:

```text
Control / Constraint
    ← BOUNDED LEAF
    ← no immediate child promoted
    ← cross-ground governing semantics
    ← shared semantic core
    ← optional but non-collapsed associated layers
    ← overlapping profiles/dimensions
```

Canonical gloss:

> **Control / Constraint concerns how an exact candidate behavior, transition, flow, choice or continuation is governed under an applicable basis/objective. An arbitrary limitation, policy artifact, authority standing, status label or mechanism is not Control by itself.**

## Why this region remains separate

The same real-world episode can contain all of the following while each remains different:

```text
policy/rule representation exists
legitimate authority exists
control applies to exact action/context
permission/prohibition/obligation standing obtains
decision/gate result is produced
mechanism allows/blocks/intervenes
alternate path is or is not available
behavior actually complies/violates
monitoring observes or misses it
control is or is not effective against protected objective
```

No accepted ground or prior composition child preserves all these distinctions as one governing question.

## Shared semantic core

```text
Control / Constraint core
├─ protected governing question
├─ exact governed focus / protected effect
│  └─ action / operation / transition / flow / choice / continuation
├─ governing basis / objective / invariant
│  └─ norm, policy, requirement, safety objective, assigned rule, limit, etc.
├─ governing mode / effect
│  └─ permit / prohibit / require / limit / gate / condition / stop / revoke /
│     redirect / escalate / isolate / concurrence / waiver ...
├─ applicability frame
│  ├─ exact subject / Actor / resource / Work / target / operation bindings
│  ├─ scope / context / stage / jurisdiction / Environment conditions
│  └─ effective/reference time + version/state where material
├─ precedence / conflict / exception / default semantics where material
└─ current validity dependencies
```

This grammar describes the semantic problem. It does not prescribe a policy language, rule engine, workflow system or authorization architecture.

## Associated layers — required distinctions, not children

### Authority / legitimacy

Institutional controls may depend on the scoped authority to issue, approve, waive, delegate or revoke a rule/decision.

```text
expertise != authority
manager/owner != every decision authority
credential possession != legitimate authority
```

Authority is not universal: machine interlocks and technical invariants can have meaningful local control semantics without a per-event human authorization decision.

### Evaluation / decision / gate

Conditional controls may evaluate current facts/standings and produce permit/deny/revoke/go/no-go/escalate outcomes.

```text
policy/rule
!= decision outcome
```

Applicability, conflicts, precedence and defaults can be decision-critical.

### Enforcement / intervention

Mechanisms such as policy enforcement points, sandbox restrictions, network controls, workflow barriers and machine interlocks can realize controls.

```text
decision says DENY
!= actual path is blocked

path is blocked
!= legitimate prohibition exists
```

### Coverage / alternate-path / bypass

This is the major new discovery of the pass.

```text
governed-effect / control-objective scope
!= enforcement-point / monitored-path scope
```

A local mechanism can work perfectly while the protected effect remains reachable through another Actor, tool, service, credential or physical path.

Therefore:

```text
direct path blocked
!= protected effect controlled
```

Foundation does not require exhaustive attack-graph enumeration. But if an alternate path changes whether the protected governing claim is true, coverage is semantic rather than merely implementation detail.

### Monitoring / compliance / effectiveness

Monitoring can support detection and assurance, but:

```text
not observed != did not occur
observed as compliant != actual compliance
actual compliance != control effectiveness
```

Compliance/effectiveness are primarily Standing/evidence questions over controls plus actual behavior/effects. Causal effectiveness remains partly deferred to Transition/Effect.

## Control is not simply `authority`

K1 explicitly falsified an authority-first definition.

OSHA machine guarding/interlock examples show a meaningful hard control can exist as:

```text
safety objective/invariant
+ exact unsafe transition
+ interlocked mechanism
→ unsafe transition prevented
```

Yet an arbitrary limitation is also not Control:

```text
network outage
!= prohibition by identity
```

A realized Environment constraint is control-relevant only where the protected question includes its governing relation to a behavior/objective.

## Modalities and governing effects

Foundation must preserve materially different meanings such as:
- allow/permit;
- prohibit/deny;
- require/oblige;
- limit/bound/throttle;
- condition/gate;
- require concurrence/dual approval;
- stop/revoke/terminate;
- redirect/escalate;
- isolate/separate;
- waive/exempt/override.

But these are dimensions/profiles, not immediate children.

```text
permitted != required
prohibited != technically impossible
required != actionable
not applicable != permit != deny != violation
```

## Gate decomposition

One word `gate` can hide at least five semantics:

```text
criterion / prerequisite
standing: criterion satisfied?
review/evaluation Work
governing decision: proceed?
enforcement: progression physically/technically possible?
```

Therefore:

```text
review complete
!= gate satisfied
!= authorized go decision
!= enforced progression
```

NASA review/decision-gate material supplies independent pressure for this separation.

## Authority and separation of duties

A valid approval can require:
- correct Actor identity/position;
- correct delegated authority scope;
- correct target/decision binding;
- time/current mandate;
- required independent/concurrent actors;
- enforcement preventing incompatible role collapse.

Thus:

```text
two role labels != two independent Actors
human approval != legitimate approval automatically
producer self-check != independent verification
```

NIST dual-authorization/separation-of-duties controls and NASA Technical Authority sharpen these distinctions.

## Conflict, exception and default behavior

A control regime can contain:
- conflicting rules;
- general rule + scoped exception;
- waiver/override;
- multiple authority levels;
- missing/indeterminate facts;
- no applicable rule.

The same rule set can produce different final decisions under different precedence/default semantics.

OASIS XACML is a useful counterframe because it distinguishes Permit, Deny, Indeterminate and NotApplicable and uses different combining algorithms. The project imports none of its implementation language; it preserves only the semantic failure mode.

## Currentness / revocation boundary

Control owns enough time/currentness semantics to answer present-tense questions:

```text
is this policy/current authority/waiver/control applicable now?
is this enforcement coverage current enough for the claim?
```

But:

```text
policy changed
!= every enforcement point updated instantly
```

The propagation/history/mechanism of that change is deferred to Transition/Effect/Feedback.

## External holdout result

### NIST ABAC
Authorization is subject/object/operation/environment/policy relative rather than a timeless Actor property.

### NIST Zero Trust Architecture
Separates policy decision, decision execution/administration and enforcement/monitoring, falsifying policy=decision=enforcement.

### NIST SP 800-53
Dual authorization, separation of duties, least privilege and indirect privilege through higher-privilege processes pressure exact scope and effective-power semantics.

### OASIS XACML
Pressure for applicability, indeterminacy, conflict, precedence and default decision semantics.

### NASA Technical Authority / decision gates
Formal authority differs from project responsibility/expertise; technical review differs from management go/no-go decision.

### OSHA machine guarding / interlocks
Hard physical controls show that Control is not authority-only and that bypass resistance is material.

### FAA Safety Risk Management
Controls span preventive/mitigating, procedural, design/equipment, training, warning and oversight forms; these remain profiles rather than universal children.

### Anthropic AI-native SDLC/security
Strong agentic counterexamples:

```text
advisory instruction != deterministic enforcement
one denied tool path != all effect paths closed
direct agent restriction != effective system restriction
```

The reported agent-to-agent route toward a stronger-capability agent is a concrete holdout for end-to-end scope/coverage.

No holdout forces an immediate child or upstream reopen.

## Why no immediate children

Tested and rejected:
- Normative / Decision / Enforcement / Monitoring;
- Preventive / Detective / Corrective/Mitigating;
- Permission / Prohibition / Obligation;
- Advisory / Procedural / Mechanical;
- Constraint / Gate / Intervention;
- Authorization / Safety / Quality / Governance;
- Human / Automated;
- Centralized / Distributed / Layered;
- Control Coverage / Effective Power as fifth child.

They fail due to overlap, optionality, ground duplication, architecture leakage or event-chain relativity.

Retained profiles:
1. Normative / Institutional Governance;
2. Authorization / Access Control;
3. Gate / Approval / Separation-of-Duties;
4. Safety / Invariant / Interlock;
5. Limit / Quota / Resource Constraint;
6. Enforcement Strength;
7. Coverage / Alternate-Path / Bypass;
8. Exception / Waiver / Override / Precedence;
9. Monitoring / Compliance / Control Assurance;
10. Preventive / Detective / Mitigating effect profile.

## Adversarial result

K7 attacked:
- collapse into Actors;
- collapse into Standing;
- collapse into Environment enforcement;
- collapse into Work gates;
- collapse into Information policy;
- coherence despite optional authority/decision/enforcement;
- layer child split;
- preventive/detective/corrective split;
- deontic split;
- path closure as architecture detail;
- Effective Power as fifth child;
- physical controls making the region too broad;
- monitoring/compliance as child;
- precedence/default as policy-engine leakage;
- currentness as wholly Transition;
- bounded leaf as under-research;
- label ambiguity;
- fifth Norm/Governance ground;
- merge with Transition;
- causal-effectiveness closure objection.

The bounded-leaf result survived. Only naming/documentation ambiguity partially succeeded.

## Final bounded result

```text
Control / Constraint
    ← BOUNDED LEAF / USER EVALUATION PENDING
    ← no immediate child promoted
```

## Next composition-child pressure

If accepted, the strongest next child is:

> **Transition / Effect / Feedback**

The reason is now structural. Binding, Standing and Control provide stable static/current composition semantics; the remaining major Foundation uncertainty is how changes/actions/decisions/control updates produce and propagate actual effects over time, including causal and feedback distinctions.

Do not activate Transition before user evaluation and separate authorization.

## Verification boundary

K7 is same-model adversarial review. External sources discriminate failure modes but do not validate this exact project synthesis. No independent second-researcher/model replication has been performed.

## Closure recommendation

Accept Control / Constraint as a bounded leaf for current Foundation sequencing, subject to user evaluation. Preserve explicit naming gloss and reopen triggers.

Do not infer architecture, ontology/data model, schema or implementation.