# Domain Condition Finding 05 — Cross-Domain Holdouts

**Status:** ACTIVE-PASS HOLDOUT FINDING  
**Date:** 2026-09-03

## Purpose

Challenge the two-child Condition candidate across materially different domains rather than treating systems/maintenance vocabulary as universal.

Candidate under attack:

```text
Domain Condition
    ├─ Realized Characteristics / Values
    └─ Criterion-Relative Standing / Status
```

## H1 — Deployed software/service system

### Realized Characteristics / Values
- current CPU/memory/load/latency values;
- current operating mode/phase when it simply describes the regime that obtains;
- runtime quantities and qualitative conditions.

### Criterion-Relative Standing / Status
- Ready / Not Ready;
- healthy / degraded / unhealthy;
- whether a service satisfies a declared readiness/quality expectation.

Kubernetes is discriminating because a Pod may be `Running` but not `Ready`, and Pod conditions track multiple independently meaningful checkpoints. This supports mode/phase and criterion-relative readiness as different current questions.

Boundary: API `status` remains a report/representation and can lag node reality; it is not actual condition by identity.

**Result:** split survives.

## H2 — Physical machine / manufacturing asset

### Realized Characteristics / Values
- vibration, temperature, pressure, wear, torque, position;
- current operating regime.

### Criterion-Relative Standing / Status
- healthy / degraded / failed;
- anomaly severity relative to assessment criteria;
- operability/readiness relative to a defined function.

NIST ACM and ISO machine-condition standards explicitly connect physical/operational parameters to diagnostics, health assessment and severity criteria rather than treating them as one undifferentiated fact.

**Result:** split survives strongly.

## H3 — Infrastructure / process system

### Realized Characteristics / Values
- flow, pressure, level, voltage, loading and other current process variables;
- current mode/regime.

### Criterion-Relative Standing / Status
- within/outside safe operating envelope;
- alarm/severity standing when the criterion is materially part of the domain decision;
- current readiness/operability.

The criterion/limit itself is not the same thing as the realized standing.

**Result:** split survives.

## H4 — Ecological system

EPA's current `Ecological Condition` vocabulary intentionally bundles physical, chemical and biological characteristics with processes/interactions. The project cannot adopt that taxonomy wholesale because Dynamics and Structure are already protected siblings.

For the Condition-only snapshot:

### Realized Characteristics / Values
- pH, contaminant concentration, nutrient level;
- population/biological characteristics where treated as current condition rather than structural membership;
- current qualitative physical/chemical condition.

### Criterion-Relative Standing / Status
- whether condition is healthy/degraded or meets a conservation/water-quality criterion when such a standing is materially defined.

**Result:** split survives, while EPA also warns that external uses of `condition` can span several project branches.

## H5 — Market / financial domain

### Realized Characteristics / Values
- current price, spread, depth, volatility, turnover and other market-condition metrics.

### Criterion-Relative Standing / Status
- market-quality characterization such as improved/deteriorated/illiquid relative to an analysis criterion or benchmark.

SEC market-structure research repeatedly treats spread/depth/volatility as measures used to characterize market quality. This gives a non-maintenance example of condition facts versus evaluative standing.

**Result:** split survives.

## H6 — Organization / institution

### Realized Characteristics / Values
Not every institutional case requires a rich characteristic branch, but current non-structural facts can still obtain at the selected institutional scope.

### Criterion-Relative Standing / Status
- valid / invalid;
- registered / unregistered;
- in good standing / not in good standing;
- compliant / non-compliant where the rule-relative standing is a real institutional fact.

South Carolina's Secretary of State describes a Certificate of Existence as stating that an entity exists and is in good standing. The certificate is a representation/evidence surface; the standing itself is defined within the institutional rule system.

Boundary: Actor identity/authority and the rule text remain outside this child by identity.

**Result:** criterion-relative standing survives outside technical health monitoring.

## H7 — Scientific specimen / experimental target

### Realized Characteristics / Values
- current chemical concentration, temperature, mass, phase, morphology, viability-related physical/biological variables.

### Criterion-Relative Standing / Status
- acceptable/unacceptable for a protocol;
- viable/non-viable or within/outside a defined quality criterion when such standing is part of the domain question.

Measurement results remain representations of these facts, not the facts by identity.

**Result:** split survives.

## H8 — Hybrid cyber-physical / digital-twin target

### Realized Characteristics / Values
- physical operating parameters and modes of the counterpart.

### Criterion-Relative Standing / Status
- current readiness/health/quality class under a defined operational criterion.

Virtual state estimates, digital-twin parameters and health-model outputs are representations/inferences; actual counterpart condition and true criterion-relative standing remain distinguishable from them.

**Result:** split survives and reinforces the Information boundary.

## H9 — Same fact switching Domain Condition and Work Condition roles

A current condition such as `network latency high`, `machine temperature elevated` or `license invalid` can be:
- Domain Condition when the focal Work targets/studies that reality;
- Work Condition when it materially shapes whether another focal Work can proceed;
- both analytical roles when both questions matter.

Role switching does not require a new intrinsic object type or Condition child.

**Result:** Work-Conditions boundary survives.

## Holdout judgment

Across software, physical assets, infrastructure/process, ecology, markets, institutions, scientific targets and hybrid systems:
- both candidate questions recur;
- no third Condition-local first-order question recurs;
- whole/constituent, datatype, domain type, observability and causality behave as dimensions/boundaries rather than children.

The cross-domain evidence is bounded and does not prove universal completeness, but it materially weakens the leaf and alternative third-child rivals.
