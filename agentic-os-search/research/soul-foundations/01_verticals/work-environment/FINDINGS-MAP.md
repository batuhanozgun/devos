# Technical Work Environment — FINDINGS MAP

**Status:** current bounded vertical map  
**Date:** 2026-09-02

Use this file to choose the shortest deeper route. It is a derived navigation surface, not primary evidence.

| Question | Current finding | Source trace |
|---|---|---|
| What distinguishes environment from tool/platform/infrastructure/workspace/runtime? What carries environment identity? | `findings/01-boundary-and-identity.md` | `sources/BOUNDARY-IDENTITY-SOURCES.md` |
| How do definition, resolved dependencies, live state, hidden dependencies, reproducibility and drift differ? | `findings/02-configuration-state-reproducibility.md` | `sources/CONFIGURATION-STATE-SOURCES.md` |
| What capabilities/resources/interfaces/constraints form the effective support surface? When do remote dependencies belong? | `findings/03-capabilities-constraints-interfaces-resources.md` | `sources/CAPABILITY-CONSTRAINT-SOURCES.md` |
| How can environments be nested/shared/isolated/federated? What lifecycle distinctions matter? | `findings/04-composition-sharedness-lifecycle.md` | `sources/COMPOSITION-LIFECYCLE-SOURCES.md` |
| What counts as environment failure? How do liveness/readiness/availability/capacity/observability differ? | `findings/05-failure-health-observability.md` | `sources/FAILURE-HEALTH-SOURCES.md` |
| Is `Work Environment` the right term? Can Environment be reduced to relations/components? | `findings/06-counterframes-and-terminology.md` | `sources/COUNTERFRAME-TERMINOLOGY-SOURCES.md` |
| What are dev/test/staging/prod roles? What control, mutability and portability distinctions matter? | `findings/07-purpose-control-portability.md` | `sources/PURPOSE-CONTROL-PORTABILITY-SOURCES.md` |
| Must an environment have a manifest/profile? How do declared/discovered/actual and dynamic state differ? | `findings/08-declared-discovered-dynamic.md` | `sources/DECLARED-DISCOVERED-DYNAMIC-SOURCES.md` |
| Why did the research stop expanding? Which late counterexamples were tested? | `synthesis/COMPLETENESS-OMISSION-CHECK.md` | `sources/OMISSION-PROBE-SOURCES.md` |
| What is the integrated result? | `synthesis/WORK-ENVIRONMENT-VERTICAL-SYNTHESIS.md` | topic findings + source ledgers as needed |
| What remains unresolved inside the vertical? | `OPEN-QUESTIONS.md` | relevant finding/ledger |
| What relations were deliberately deferred? | `DEFERRED-RELATIONS.md` | later independent recovery of the other verticals required |

## Current bounded analytical dimensions

1. support boundary and scope;
2. composition and environment identity/equivalence;
3. technical configuration, resolution and realized state;
4. capabilities, services and resources;
5. interfaces and mediation;
6. constraints, isolation and access/resource policy;
7. distribution, nesting, federation and sharedness;
8. substrate/ambient technical dependencies;
9. lifecycle, persistence and retention behavior;
10. current condition: readiness, availability, capacity and degradation;
11. observability/discovery versus actual state;
12. control, mutability and administration surface;
13. purpose/role profile;
14. reproducibility, portability and protected equivalence;
15. dynamic resolution/adaptation over time.

These are analytical dimensions, not ontology classes or schema fields.

## Strongest corrective finding

An explicit environment profile/manifest is **not required** for environment existence. The realized technical support context is primary; profiles are optional descriptive/prescriptive representations.

## Retrieval depth

`L0 KEY → L1 FINDINGS-MAP → L2 vertical synthesis → L3 topic finding → L4A completeness audit or L4B source ledger → L5 primary/authoritative source`

Descend only when a compressed view could lose a decision-critical caveat, source scope or falsifier.
