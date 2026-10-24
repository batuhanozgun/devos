# Realized Characteristics Finding 03 — Mode, Aggregate, Relational and Capability Boundaries

**Status:** bounded finding  
**Date:** 2026-09-04

## Current mode / regime

A current mode can fit `Realized Characteristics` when the protected question is simply which operational mode obtains now.

SEBoK defines operational mode as an operational situation/configuration characterized by active functions and treats it as state-like. The project boundary remains role-based:

```text
mode = Manual now             → Realized Characteristics candidate
transition Auto → Manual      → Domain Dynamics
active-function relation map  → can require Domain Structure if organization is protected
```

No stable recovery program separates mode from other current characteristics across domains.

**F6 rejected; F14 retained as boundary rule.**

## Whole / aggregate / emergent characteristics

SEBoK defines emergent property as meaningful at higher system levels. EPA ecological condition also shows whole-system properties arising from interacting attributes/processes.

The evidence supports **bearer/scope variation**, not a universal child:
- constituent characteristic;
- relation characteristic;
- subsystem characteristic;
- whole/emergent characteristic.

A whole-level property may require different evidence or aggregation semantics, but the first-order question remains what characteristic obtains for the selected bearer/scope.

**F8 rejected as child basis.**

## Relation-valued characteristics versus Relational Organization

The boundary survives:

```text
A is connected to B                   → Relational Organization
shortest distance(A,B) = 8 m          → Realized Characteristics candidate
latency(A,B) = 42 ms                  → Realized Characteristics candidate
relation becomes disconnected         → Dynamics for change; Structure for resulting relation
```

GeoSPARQL independently distinguishes qualitative topological relation families from quantitative spatial computations such as distance. The external standard is not the project taxonomy, but it falsifies the claim that every relation-associated value must be the same semantic problem as relation existence/organization.

**F12 rejected.**

## Structural cardinality versus amount/concentration

Keep the protected question explicit:

```text
10 service instances participate in selected whole
→ Constituent Composition when constituent multiplicity is protected

memory available = 10 GiB
concentration = 10 mmol/L
mass fraction = x
→ Realized Characteristics when current magnitude is protected
```

IUPAC/VIM examples reinforce that concentration/fraction are quantity forms rather than composition membership relations.

**F13 rejected.**

## Capability / capacity / availability / reliability

No universal child emerges.

- a current free-capacity magnitude can be a realized characteristic;
- `capability` in SEBoK is ability to achieve an effect under specified conditions — a disposition/conditional relation, not merely an occurrent scalar;
- availability and reliability are probabilistic and can involve time intervals, repair/failure models and stated conditions;
- capability/readiness may become Criterion-Relative Standing or Work Conditions depending on the protected question.

Therefore the vocabulary is role-sensitive and spans Condition, Dynamics, criteria and Work-relative semantics.

**F11 rejected as a new universal child.**