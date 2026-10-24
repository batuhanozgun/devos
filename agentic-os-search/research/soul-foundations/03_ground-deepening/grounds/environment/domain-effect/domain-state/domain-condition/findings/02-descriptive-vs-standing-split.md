# Domain Condition Finding 02 — Realized Characteristics versus Criterion-Relative Standing

**Status:** ACTIVE-PASS FINDING  
**Date:** 2026-09-03

## Question

Does deeper Condition research expose a stable immediate-child split, or should `Domain Condition` close as a leaf?

## Finding

**A two-child semantic split survives the current adversarial pass.**

Strongest current immediate hierarchy:

```text
Domain Condition
    ├─ Realized Characteristics / Values
    └─ Criterion-Relative Standing / Status
```

The distinction is not scalar-versus-enum, raw-versus-derived, physical-versus-social or measurement-versus-label. It is a difference in the protected question.

## Child 1 — Realized Characteristics / Values

Primary question:

> **What materially relevant characteristics, quantities, qualitative values, modes or relational conditions actually obtain at the selected scope and time, before asking whether they satisfy a separate criterion?**

Examples when material:
- temperature, pressure, concentration, load, price, depth, spread;
- wear/damage level or other realized physical condition;
- current operating mode such as manual/test/running/paused when it simply describes what mode obtains;
- current chemical/biological characteristic;
- a relational condition such as a current distance or exposure level when the protected question is the value/condition itself.

This child is semantic, not a database `attribute` bucket. A value can be categorical, quantitative, qualitative or relational.

## Child 2 — Criterion-Relative Standing / Status

Primary question:

> **Relative to a materially relevant functional, normative, regulatory or domain criterion, what standing currently obtains for the selected constituent or whole?**

Examples when material:
- healthy / degraded / failed;
- ready / not ready;
- acceptable / unacceptable;
- compliant / non-compliant;
- valid / invalid;
- in good standing / not in good standing;
- quality or severity class relative to requirements/thresholds.

The criterion itself is not automatically a Domain Condition fact. A rule, requirement, threshold, expected range or health model may live in Information or another later relation/control surface. What belongs here is the **realized criterion-relative standing**, when such a standing is materially part of the domain reality.

## Why this is not just raw data versus interpretation

The split must survive the actual-versus-representation boundary.

A current characteristic can be hidden and inferred; it is still a reality-side Condition fact if it actually obtains.

Likewise, a criterion-relative standing can be real even if every report about it is wrong. A corporation can actually be in or out of good standing under the applicable institutional rules; a certificate is evidence/representation, not the standing by identity.

Conversely, a software `Ready=True` field or a health score is not automatically the realized standing merely because a system reports it.

Thus:

```text
child 1 ≠ measured/raw data
child 2 ≠ dashboard/assessment output
```

The distinction is between two kinds of reality question, not between source data and computed information.

## Independent-failure test

The split survives because the two questions can fail independently.

### Characteristics right, standing wrong

The underlying condition facts may be correctly known while the wrong threshold, rule, functional expectation or applicability criterion produces the wrong standing.

Examples:
- temperature/load facts are correct but a health threshold is wrong;
- filing facts are correct but the wrong legal rule is applied to standing;
- market metrics are correct but an evaluative quality classification uses an inappropriate criterion.

### Standing right, characteristics incomplete/wrong

A standing can be correctly established without a complete or correct description of every underlying condition characteristic.

Examples:
- a system is correctly known to meet a readiness criterion while some non-load-bearing telemetry is wrong;
- an authority can establish current legal standing without a downstream reasoner possessing every underlying institutional fact;
- an asset can be correctly classified as degraded while the exact magnitude of one contributing parameter is still uncertain.

These are materially different recovery paths: reconstructing current characteristics is not the same task as establishing which criterion applies and whether the realized condition satisfies it.

## Cross-lineage discrimination

The distinction is not sourced from one taxonomy:
- SEBoK v2.14 separately presents state as values of qualities/properties and as current/future potential or health;
- NASA human-system requirements separately call for system state/mode information and system health;
- ISO condition-monitoring standards distinguish measurement/monitoring from severity assessment criteria and interpretation;
- ISO quality vocabulary defines quality through fulfillment of requirements rather than as a bare characteristic;
- NIST asset-condition work treats health awareness/assessment as using condition information for diagnostics and health-state knowledge;
- software readiness/health systems commonly combine condition signals with readiness or health criteria;
- institutional good standing is explicitly rule/authority-relative.

No source defines the project hierarchy. Their value is that materially different operational traditions repeatedly require both questions.

## Child-promotion judgment

Both children have:
- distinct first-order questions;
- independent failure modes;
- different recovery/evidence dependencies;
- recurring cross-domain examples;
- material consequences for later SOUL reasoning if collapsed.

**Provisional promotion: PASS**, subject to cross-domain holdouts and final omission/rival audit.
