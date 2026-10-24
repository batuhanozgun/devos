# Domain Condition Finding 03 — Health, Mode, Capability and Constraint Boundaries

**Status:** ACTIVE-PASS FINDING  
**Date:** 2026-09-03

## Purpose

Test whether common Condition vocabulary deserves additional immediate children or breaks the two-child candidate.

Candidate under attack:

```text
Domain Condition
    ├─ Realized Characteristics / Values
    └─ Criterion-Relative Standing / Status
```

## Health

`Health` is not promoted as a universal third child and is not assigned mechanically to one child by word alone.

Two roles recur:

1. **underlying realized condition** — wear, damage, degradation level or another actual characteristic can belong to `Realized Characteristics / Values`;
2. **health standing/classification** — healthy/degraded/failed relative to operational expectations or health criteria belongs to `Criterion-Relative Standing / Status` when it is a true current standing.

NIST asset-condition management explicitly distinguishes condition awareness, diagnostics and estimates/assessment of health. ISO condition-monitoring standards likewise distinguish measurement/monitoring from assessment criteria and interpretation. This makes `health` a poor primitive child label: the word can name either the condition being assessed or the criterion-relative result of that assessment.

## Operating mode / lifecycle status

Current mode is normally a form of realized characteristic/value when it answers:

> Which operating regime currently obtains?

Examples:
- Manual;
- Test;
- Running;
- Paused.

NASA treats mode/state and system health as separately needed operational information. SEBoK defines operational mode as an operational situation/configuration characterized by active functions.

The **transition** between modes belongs to Dynamics. A historical condition for entering a mode may also require Dynamics evidence. This does not turn the current mode itself into a Dynamics child.

Mode therefore does not become a separate universal Condition child.

## Capability, capacity and availability

These terms are role-sensitive and cannot be collapsed into one Condition child.

- A current capacity or load value can be `Realized Characteristics / Values`.
- Current readiness/operability to perform a defined function can be `Criterion-Relative Standing / Status` when it is a current fact relative to a functional criterion.
- SEBoK defines system capability as ability to execute a course of action or achieve an effect under specified conditions; this is a disposition/ability relation, not automatically a bare snapshot value.
- SEBoK availability is explicitly probabilistic and can be instantaneous, interval-averaged or asymptotic.
- Reliability is explicitly a probability over a specified period and operating conditions.

Thus generic capability/availability/reliability concepts can span Condition, Dynamics, model/Information and Work-Condition roles depending on the protected question.

**No dedicated universal Condition child is justified.**

## Constraints, requirements and compliance

Keep separate:

```text
criterion / rule / requirement / threshold
≠ current satisfaction / violation / compliance standing
```

The rule/criterion can govern admissibility and may be represented in Information. The current fact that a selected domain object satisfies, violates or is in compliance with it can belong to `Criterion-Relative Standing / Status`.

ISO quality vocabulary makes this relation especially explicit: quality is defined through the degree to which inherent characteristics fulfil requirements.

This result absorbs the parent cross-cut finding without promoting `Constraints / Compliance` as a third child.

## Causal diagnosis / prognosis

Keep separate:

```text
current condition / standing
≠ why it obtained
≠ what it will become
```

Diagnostics may explain current condition. Prognostics estimate future condition. Neither is a current Condition child by identity.

## Judgment

The common vocabulary above does not produce a stable third child. It instead clarifies the two-child semantic split and the boundaries to Dynamics, Information, Work Conditions and later causal/relation reasoning.
