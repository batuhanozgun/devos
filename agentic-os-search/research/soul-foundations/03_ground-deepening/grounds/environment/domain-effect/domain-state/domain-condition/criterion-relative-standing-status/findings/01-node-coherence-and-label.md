# Finding 01 — Node coherence and label

**Status:** supported bounded finding  
**Node:** `Criterion-Relative Standing / Status`

## Question

Does the promoted node remain coherent at its own depth, and is the inherited paired label the strongest retrieval label?

## Result

The node remains coherent, but the preferred label is:

> **Criterion-Relative Standing**

rather than `Criterion-Relative Standing / Status`.

## Why the node is coherent

Across materially different domains, a recurrent recovery question survives:

> Given an applicable criterion/regime and the materially relevant current facts, what standing currently obtains for the bearer or whole relative to that criterion?

Examples include:
- healthy / degraded / failed relative to functional expectations;
- ready / not-ready relative to readiness gates/checkpoints;
- conforming / nonconforming relative to specified requirements;
- compliant / non-compliant relative to statutory/regulatory criteria;
- good-standing / not-good-standing under an institutional/legal regime;
- well/adequately/under-capitalized under regulatory capital criteria;
- good/fair/poor ecological condition under a defined assessment framework.

The vocabulary varies, but the protected outcome remains criterion-relative current standing rather than the bare current characteristic or the evidence artifact.

## Why `Status` is dropped

`Status` is materially overloaded across domains:
- it can mean a broad lifecycle/current-state label;
- it often names an API/report/database representation surface;
- it can mean an institutional/legal status;
- it can be used as a synonym for standing.

This overload weakens it as a co-primary semantic label. `Standing` more clearly signals a current result relative to a criterion/regime without implying that a database `status` field or status report is the reality-side fact by identity.

The project can still use domain-native `status` vocabulary where appropriate.

## Why `Criterion-Relative` stays

Dropping `Criterion-Relative` would blur the sibling distinction:

```text
memory.available = 500 MiB            → Realized Characteristics
MemoryPressure relative to threshold  → Criterion-Relative Standing

capital ratio = x                      → Realized Characteristics
well-capitalized under defined rules   → Criterion-Relative Standing
```

The criterion/regime is not incidental; it is part of what makes the standing the standing it is.

## External challenge pattern

- ISO 19011:2026 / ISO 9000:2026 define conformity as fulfilment of a requirement and nonconformity as non-fulfilment; statutory/regulatory audit criteria yield compliance/non-compliance findings.
- Kubernetes distinguishes lifecycle phase/current signals from readiness/pressure conditions evaluated against checkpoints or thresholds.
- Official corporate/licensing sources distinguish current status/standing from documents or online views reporting that status.

These traditions do not validate the project hierarchy, but they challenge a label that treats `Status` as a stable universal semantic category.

## Falsifier impact

- F1: **rejected** — paired inherited label is not optimal.
- F2: **supported** — drop/demote `Status` from the primary label.
- F3: **supported** — criterion relativity is essential to the protected question.

## Bounded conclusion

```text
Criterion-Relative Standing / Status
→ Criterion-Relative Standing
```

Leaf-versus-split remains determined by later findings.