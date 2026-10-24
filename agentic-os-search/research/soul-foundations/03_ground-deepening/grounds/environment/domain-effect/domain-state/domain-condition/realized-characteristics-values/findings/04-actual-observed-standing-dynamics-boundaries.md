# Realized Characteristics Finding 04 — Actual / Observed / Standing / Dynamics Boundaries

**Status:** bounded finding  
**Date:** 2026-09-04

## Actual characteristic versus observation / measurement / model

This is a load-bearing boundary.

BIPM/JCGM distinguishes:
- the measurand (quantity intended to be measured);
- measurement result (values attributed to the measurand + relevant information);
- measured quantity value (an estimate);
- true quantity value as a separate theoretical concept.

W3C/OGC SSN similarly distinguishes:
- Feature of Interest;
- its Property;
- Observation as an act estimating/calculating a property value;
- Result as an information item.

Therefore:

```text
actual characteristic
≠ observation act
≠ measured/estimated/modelled value
≠ report/status field
```

An actual characteristic can be hidden, poorly observed or incorrectly estimated and still be reality-side.

**F15 rejected.**

## Observable versus latent/hidden

Direct accessibility changes the evidence/recovery method, not the first-order kind of condition fact.

SSN explicitly supports proxy samples and observations of properties that are not directly accessed at the ultimate feature of interest. Latent/hidden condition therefore does not form a universal immediate child.

**F9 rejected.**

## Uncertainty / confidence

Measurement uncertainty and confidence/provenance normally qualify the evidence/result/model, not automatically the actual characteristic itself.

There are genuine stochastic/probabilistic domain properties, but they must not be confused with epistemic uncertainty about an unknown current value.

```text
uncertain knowledge of temperature
≠ temperature is intrinsically an uncertainty distribution
```

**F16 rejected as a universal reality-side rule.**

## Criterion versus characteristic versus standing

The sibling boundary survives strongly.

Kubernetes provides a useful operational counterframe:
- signals such as `memory.available` are evaluated against configured eviction thresholds;
- the system then reports conditions such as `MemoryPressure`.

The API representation is not taken as reality by identity, but the mechanics discriminate the questions:

```text
current underlying magnitude
+ applicable threshold/criterion
→ possible criterion-relative standing
```

NASA maintenance material similarly distinguishes functional-state data such as temperature/pressure/power from maintenance decisions, while NIST condition management distinguishes condition awareness from diagnostics/health assessment.

Criteria, thresholds and required ranges are not current realized characteristics merely because they are needed to judge them.

**F17 rejected.**

Criterion-relative health/readiness/compliance must not be collapsed back into this child simply because it may be derived from current characteristics.

**F18 rejected.**

## Dynamics boundary

A current value can encode a rate or accumulated quantity, but the semantic question determines routing:

```text
current speed = 5 m/s       → characteristic candidate
speed changed 3→5 m/s       → Dynamics
current mode = Manual       → characteristic candidate
mode transition history     → Dynamics
windowed volatility         → often a statistic over Dynamics / Information derivation
current spread = x          → characteristic candidate
```

Snapshot access to a derived temporal statistic does not erase its derivational/history semantics.