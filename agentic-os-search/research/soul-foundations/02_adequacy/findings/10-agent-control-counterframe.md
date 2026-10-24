# Adequacy Finding 10 — Agent / Control Counterframe Against Environment Merge

**Status:** current focused counterframe  
**Date:** 2026-09-02

## Purpose

Test the strongest objection to the four-broad-ground candidate:

> Agent and control traditions often distinguish the environment/controlled process from sensors, actuators, controllers and other technical mechanisms. Does that make Technical Work Environment too different from Operating World to share one top-level ground?

## Evidence

### Rational-agent / PEAS tradition

Common agent formulations separate:
- environment/world;
- sensors/percepts;
- actuators/actions;
- agent decision machinery;
- performance measure.

Berkeley CS188, Poole & Mackworth and AIMA-derived teaching material all preserve an agent ↔ environment interaction boundary rather than treating sensing/acting mechanisms as the environment itself.

### POMDP tradition

Separates:
- hidden environment/world state;
- actions;
- observations;
- transition and observation models.

### STAMP/control tradition

Separates:
- controller;
- controlled process;
- control action;
- feedback;
- controller process model;
- in many formulations, sensors/actuators.

The actual controlled process/environment state is not identical to the technical means by which it is sensed or acted upon.

## What this falsifies

Reject:

> `technical tool / sensor / actuator / controller = Environment object`.

Also reject:

> `Technical Work Environment is simply the same thing as the external domain world`.

These distinctions are load-bearing at implementation/control-model levels.

## Why the top-level merge still survives

The project grounds are **not architecture-component classes**.

Technical Work Environment research already rejected `tool list = environment` and instead studied the realized support context in which capabilities/resources/interfaces are effectively available under constraints and current state.

That support context can include technical mechanisms that, in a lower architecture view, are:
- inside an agent/working system;
- external enabling systems;
- shared infrastructure;
- remote services;
- sensors/actuators/interfaces;
- or the target of Work itself.

Therefore the common parent should not assert common component identity.

It asserts a higher problem:

> **what actual situated domain/support conditions and surfaces shape the feasible interaction space of focal Work?**

At that level:
- the target/world side supplies the state/effect space;
- the support side supplies effective means/capabilities/interfaces/constraints;
- lower models may place their concrete elements on different sides of an agent/system boundary.

## Important consequence for naming

This counterframe weakens the literal interpretation of the parent label `Environment`.

If the word is read in the narrow agent sense (`everything outside the agent`), the merge is false.

If used as a project shorthand for a broader **situated operating/support conditions problem ground**, the merge remains viable.

Therefore:

- semantics are stronger than the current label;
- do not encode an ontology rule `tool is an Environment`;
- do not infer architecture boundaries from the research hierarchy.

## Verdict

Agent/control traditions require a **branch and component-boundary distinction**, but do not require five peer research grounds.

They strengthen the current formulation:

```text
Environment-like top problem ground
    ├─ actual target/domain state and dynamics
    └─ effective work-support conditions/capabilities/interfaces
```

while requiring that sensing/action/support mechanisms remain separately modelable at deeper levels.
