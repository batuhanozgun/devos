# Domain Condition Finding 04 — Scale, Aggregation and Property-Form Audit

**Status:** ACTIVE-PASS FINDING  
**Date:** 2026-09-03

## Question

Do whole-versus-constituent condition, intrinsic-versus-relational property or quantitative-versus-categorical form require additional universal immediate children?

## Whole versus constituent condition

**No universal child split survives.**

A condition claim always needs a selected bearer/scope:
- a component;
- a subsystem;
- a whole system;
- a population/community/market;
- an institution.

NIST asset-condition work explicitly describes health metrics/knowledge being usable at different asset/system levels. Operational health frameworks likewise aggregate component signals into higher-level health states.

But aggregation is not one universal mechanism:
- a worst critical component may dominate whole-system health;
- redundancy may allow whole health to remain nominal while one constituent is degraded;
- a whole may exhibit emergent condition not reducible to an arithmetic combination of constituent values;
- institutional/market/ecological standing can depend on relations and scope-specific criteria.

Therefore:

```text
constituent condition
vs
whole condition
```

is a **scope/level/aggregation dimension**, not two universal Condition children.

Both immediate candidate children can be asserted at either level:
- a whole or component can have realized characteristics/values;
- a whole or component can have criterion-relative standing/status.

## Intrinsic versus relational condition

**Not promoted.**

The philosophical intrinsic/extrinsic distinction is itself not a single clean primitive. Stanford Encyclopedia's treatment notes that the intuitive distinction conflates several related distinctions and that relational/non-relational is not equivalent to intrinsic/extrinsic.

For project purposes:
- an intrinsic-looking fact such as mass can be a realized characteristic;
- a relational fact such as distance, exposure, price relative to another value or institutional standing can also be a current Condition fact when materially relevant;
- a criterion-relative standing is necessarily relational to some criterion but need not therefore be a separate ontology-style property class.

The protected questions are more stable than property metaphysics.

## Quantitative versus qualitative versus categorical

**Not promoted.**

A single Condition child can be expressed as:
- number: `temperature = 85°C`;
- category: `mode = Manual`;
- qualitative fact: `surface is corroded`;
- Boolean/standing: `compliant = true`;
- ordinal class: `severity = high`.

These are representation/value forms. They do not by themselves change the first-order question or recovery boundary.

## Unknown / absent / not applicable

Do not turn epistemic states into Condition children.

Keep distinct:

```text
actual fact is absent
≠ value not observed
≠ value unknown
≠ field missing
≠ criterion not applicable
≠ outside selected scope
```

The first can be reality-side. The others may depend on Information/reference semantics.

## Judgment

No stable third Condition-local child emerges from scale, aggregation, intrinsic/relational form, datatype/value form or epistemic missingness.

The current two-child candidate remains stronger:

```text
Domain Condition
    ├─ Realized Characteristics / Values
    └─ Criterion-Relative Standing / Status
```
