# Domain State Finding 04 — Domain Condition / Status

**Status:** active-node child candidate finding  
**Date:** 2026-09-02

## Question

Do realized properties/qualities/current standings form a distinct first-order State problem from Structure/Composition?

## Current finding

**Yes, `Domain Condition / Status` currently passes the child-promotion test.**

Primary question:

> **What materially relevant properties, values, qualities, health, status or standing actually hold for the selected constituents/domain whole at the selected scope/time?**

## What belongs here when material

- current property/value;
- operating/health condition;
- capacity/level/quantity in its Domain role;
- current mode/status;
- current physical/chemical/biological condition;
- current social/institutional standing in its Domain role;
- realized qualitative/quantitative condition of the whole or a constituent.

This is not the observed/report value by identity and is not the desired/allowed state.

## Distinct failure surface

Condition/status error can occur while structure is correct:
- the right deployed services and dependencies exist, but one service is unhealthy or has the wrong realized runtime value;
- the correct machine/components are installed but wear, vibration, temperature or health is degraded;
- the correct ecological constituents/relations are in scope but chemical/biological condition is materially different;
- the institutional structure is unchanged while a license, standing, validity or other realized institutional status has changed.

Thus correct structure does not establish correct condition.

## Why properties/status are not split further at this level

Candidates such as:
- intrinsic properties;
- relational properties;
- health/status;
- quantitative values;
- institutional standing
were tested as possible separate children.

Current evidence does not justify universal promotion:
- the exact property families are strongly domain-specific;
- a status can be intrinsic, relational or institutionally constituted depending on domain;
- their common first-order problem is whether the **realized condition that currently holds** is characterized correctly;
- splitting by property type would turn the project tree into a domain ontology/taxonomy.

## External discrimination

SEBoK's current state glossary emphasizes values of qualities/properties at a time. NIST asset-condition work treats current health/condition awareness as a distinct operational problem. These do not define the project hierarchy but support the recurrence of a current-condition problem separate from system composition.

## Reality / representation boundary

Keep separate:

```text
actual condition/status
≠ measured/observed value
≠ reported/cached status
≠ desired/spec state
≠ historical Record
```

Current Kubernetes documentation provides a strong digital counterexample: API-visible status can lag instant runtime reality. Digital-twin literature likewise distinguishes the physical/real counterpart from virtual state/parameter representations.

## Child-promotion judgment

Current basis:
- distinct first-order question;
- distinct failure modes from Structure/Composition;
- repeated cross-domain condition/health/status concerns;
- material later reasoning consequence if current condition is omitted.

**Provisional promotion: PASS**, subject to final omission/rival audit.
