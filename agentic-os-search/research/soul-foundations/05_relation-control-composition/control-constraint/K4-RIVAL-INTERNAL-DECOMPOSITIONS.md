# Control / Constraint — K4 Family Discovery + Rival Internal Decompositions

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Attack the leading hypothesis:

```text
Control / Constraint
← coherent composition region
← one shared governing grammar
← multiple associated layers/profiles
← no immediate child yet justified
```

The goal is not to preserve this result. Promote children if a rival decomposition provides cleaner protected questions with recurrent low-overlap failure families.

## 2. Rival A — Normative / Decision / Enforcement / Monitoring children

Candidate:

```text
Control / Constraint
├─ Normative / Policy Control
├─ Decision / Gate Control
├─ Enforcement / Intervention Control
└─ Monitoring / Compliance Control
```

### Strength

This is the most intuitive decomposition after K2.

It captures genuine non-collapse:

```text
rule != decision != enforcement != observation
```

### Failure

The nodes are not stable peer populations:
- many controls have no separate decision episode;
- a fixed physical barrier/interlock combines rule/objective + enforcement continuously;
- authority is load-bearing for some normative controls but absent from others;
- monitoring is optional and often an Information/Work/Environment observation surface rather than governing control;
- compliance is mostly Standing/assessment;
- one policy regime routinely spans all four layers;
- separating them as children would encourage local silos rather than cross-ground composition.

### Judgment

**Reject as child hierarchy; retain as mandatory semantic-layer checklist.**

## 3. Rival B — Preventive / Detective / Corrective / Mitigating

Candidate inspired by safety/security practice:

```text
Preventive
Detective
Corrective / Mitigating
```

### Strength

FAA safety material distinguishes preventive controls that block hazard propagation from mitigating controls that reduce consequence after an event. Security practice likewise commonly distinguishes preventive/detective/corrective controls.

### Failure

This split classifies **position/effect in an event-risk sequence**, not one universal governing question.

Examples:
- an interlock is preventive;
- a monitor is detective;
- recovery Work is corrective;
- a shutdown can be preventive relative to a worse event and mitigating relative to an already-started hazard;
- one mechanism can both detect and prevent;
- `corrective` often denotes Work/Transition after failure rather than the control semantics themselves.

### Judgment

**Reject as immediate children. Retain as lifecycle/effect profiles relevant later to Transition.**

## 4. Rival C — Permission / Prohibition / Obligation

Candidate deontic split:

```text
Permission
Prohibition
Obligation
```

### Strength

These are irreducible in many normative domains.

### Failure

Control semantics also require:
- limits/quotas;
- gates/conditions;
- isolation;
- dual concurrence;
- revocation;
- escalation;
- physical/safety constraints not naturally expressed as bearer obligations.

Furthermore the current result for one Actor/action is often a Standing rather than a Control child.

### Judgment

**Reject as universal child hierarchy; retain as major modality profile.**

## 5. Rival D — Authorization / Safety / Quality / Compliance / Governance

Candidate domain-purpose families.

### Failure

These mix criterion/objective domains with control semantics.

The same grammar appears in:
- access authorization;
- safety interlocks;
- project waiver gates;
- quality approval;
- data-use restrictions.

`Safety`, `Quality`, `Security`, `Compliance` primarily change:
- governing basis;
- authority regime;
- evidence threshold;
- risk/default semantics;
- mechanism choice.

They do not change the protected control question enough to become universal children.

### Judgment

**Reject. Domain profiles only.**

## 6. Rival E — Advisory / Procedural / Deterministic hard-control hierarchy

Candidate:

```text
Advisory
Procedural / human-governed
Mechanically enforced
```

### Strength

Anthropic candidate evidence strongly distinguishes contextual instructions from hooks/settings/permissions/sandbox/network enforcement.

This distinction matters because:

```text
agent instructed not to do X
!= agent mechanically unable to do X
```

### Failure as hierarchy

- procedural controls can be strongly enforced institutionally but not mechanically;
- a policy can have both advisory and hard-enforcement realization;
- enforcement strength is not one ordinal scalar across mechanisms;
- hard technical enforcement can be bypassable at system level;
- an advisory control may still be legitimate and decision-critical.

### Judgment

**Reject as children. Retain as enforcement/realization-strength dimension.**

## 7. Rival F — Constraint / Gate / Intervention

Candidate:

```text
Constraint    — continuously bounds behavior
Gate          — permits/blocks transition at condition
Intervention  — actively changes/stops behavior
```

### Strength

Looks mechanism-neutral and cross-domain.

### Failure

- a gate is a conditional constraint;
- an interlock is both constraint and intervention;
- revocation can be a decision, gate change and intervention;
- throttling continuously intervenes and constrains;
- the split tracks operation shape rather than distinct semantic failure families.

### Judgment

**Reject as children; retain as governing-effect/mode profiles.**

## 8. Rival G — Human / Automated controls

### Failure

This is Actor/mechanism realization, not Control semantics.

```text
human gate
!= legitimate gate

automated gate
!= deterministic correctness
```

The same rule/authority/decision/enforcement distinctions apply to both.

**Reject.**

## 9. Rival H — Centralized / Distributed / Layered control

### Failure

This is architecture/topology.

Foundation must preserve that:
- multiple enforcement points may exist;
- delegation paths matter;
- control scope may span systems;
- conflicts/precedence may occur.

But centralized/distributed decomposition is implementation-specific.

**Reject.**

## 10. Rival I — Reduce Control to access-control semantics

Candidate:

```text
subject + object + operation + policy → permit/deny
```

### What it explains well

- request-specific authorization;
- policy applicability;
- current attributes/environment conditions;
- permit/deny decisions;
- enforcement point interaction.

### What it loses

- obligations/required Work;
- safety interlocks/invariants where no access request exists;
- quantitative limits/quotas/throttling;
- project decision gates/waivers;
- dual concurrence beyond simple access;
- process/workflow constraints;
- escalation/stop/redirect semantics.

### Judgment

**Reject as parent reduction. Access control is a strong profile/counterframe.**

## 11. Rival J — Reduce Control to state-machine guards

Candidate:

```text
state + event + guard → allowed transition
```

### Strength

Captures conditional transitions elegantly.

### What it loses

- legitimate authority to define/waive guard;
- distinction between represented rule and actual institutional rule;
- monitoring/compliance;
- alternate path/effect closure across multiple actors/tools;
- obligation semantics where required action may not occur;
- advisory controls with no deterministic transition guard.

### Judgment

**Reject as Foundation reduction. Useful later formalism only if architecture warrants.**

## 12. Rival K — Reduce Control to feedback/control-loop theory

Candidate:

```text
reference/setpoint
→ observe state
→ compute error
→ controller action
→ plant response
→ feedback
```

### Strength

Powerful for automatic regulation and later Transition/Feedback research.

### Failure

- does not naturally preserve institutional authority/waiver/delegation;
- `policy text`, legal obligation, approval competence and separation of duties become awkward controller artifacts;
- a fixed guard can control without a feedback loop;
- advisory governance can exist without automatic actuation.

### Judgment

**Reject as Control parent reduction. Strong holdout for later Transition/Feedback.**

## 13. Rival L — Norms / Governance should be a fifth Ground

### Attack

The repeated importance of policy, authority and governance may mean the original four-ground adequacy missed a fifth `Norms/Governance` ground.

### Test

Every candidate governing case still decomposes into:
- Information: represented rule/policy/decision/evidence;
- Actors: authority, obligation, delegation, accountability;
- Work: governed action/approval/review/decision activity;
- Environment: realized mechanism/path/resource/effect conditions;
- Binding: exact applicability relations;
- Standing: current qualification/authorization/compliance;
- Control: governing composition across these anchors.

After removing this cross-ground composition, no stable independent bearer/state/process locus remains for `Governance`.

### Judgment

**Reject fifth-ground hypothesis.**

## 14. Rival M — Effective Power / Path Closure should be a fifth composition child

### Attack

Alternate-path closure and transitive effect power might be too distinct for Control.

### Test

Protected question remains control-relative:

> Does the applicable control constrain the governed effect across the relevant reachable paths?

Supporting semantics come from:
- Binding: route/delegation/topology;
- Actors/Environment/Work: capability and path reality;
- Standing: reachable/effective/coverage qualification;
- Control: governed objective, scope and enforcement coverage;
- Transition: actual effect if/when it occurs.

No independent fifth semantic kind remains.

### Judgment

**Reject as fifth composition child; retain Control Coverage / Bypass as a high-value profile.**

## 15. Candidate retained profiles / dimensions

Not children:

1. **Normative / Institutional Governance**
2. **Authorization / Access Control**
3. **Gate / Approval / Separation-of-Duties**
4. **Safety / Invariant / Interlock**
5. **Limit / Quota / Resource Constraint**
6. **Enforcement Strength — advisory/procedural/mechanical**
7. **Coverage / Alternate-Path / Bypass**
8. **Exception / Waiver / Override / Precedence**
9. **Monitoring / Compliance / Control Assurance**
10. **Preventive / Detective / Mitigating effect profile**

They overlap heavily and share the same control grammar.

## 16. K4 provisional structural judgment

No tested decomposition clears all promotion criteria.

Current leading result entering K5:

```text
Control / Constraint
    ← coherent cross-ground composition region
    ← likely BOUNDED LEAF
    ← shared governing-control grammar
    ← mandatory non-collapse among basis / authority / decision / enforcement / observation
    ← overlapping profiles/dimensions
```

This conclusion now needs hostile external/candidate holdouts rather than more internal refinement.