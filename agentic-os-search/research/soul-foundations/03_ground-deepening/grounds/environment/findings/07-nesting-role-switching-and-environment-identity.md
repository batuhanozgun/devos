# Environment Finding 07 — Nesting, Role Switching and Environment Identity

**Status:** current Environment-ground finding

## Central result

Environment membership and branch role are **reference-relative and time-varying**. A stable object taxonomy cannot represent this without distortion.

Systems engineering explicitly supports nested systems and shifting system-of-interest boundaries. The project's own cases show the same concrete system can move among target/domain, execution-condition and internal-system roles across Work.

## Three distinct questions

When reasoning about a concrete thing, keep separate:

1. **Concrete identity** — is this the same person/system/resource/location/etc.?
2. **Environment participation** — is its current state a load-bearing condition for this focal analysis?
3. **Environment role** — does it participate as Domain/Effect reality, Work Condition, or both?

Changing role does not imply changing concrete identity.

## Nested systems

SEBoK treats systems as nested and boundary choices as analytical. A system element may become a system-of-interest at another level.

Implications:
- a subsystem can be internal in one analysis and external/environmental in another;
- an enabling system can become the target of maintenance/development Work;
- a wider system may place previously external elements inside a new controlled boundary;
- Environment analysis must state its focal reference rather than assume one universal boundary.

## Role switching examples

### CI/test platform
- supports product-development Work → Work-Condition/TWE role;
- is being repaired → Domain/Effect role;
- can simultaneously provide limited diagnostic support during its own repair → both roles.

### Hospital equipment
- enables treatment → Work-Condition role;
- equipment itself under maintenance → Domain/Effect role;
- patient physiology remains a different Domain/Effect region for clinical Work.

### Road and weather
- weather/road state constrains autonomous driving execution;
- in road-maintenance or meteorological Work, the same state becomes explicit target/domain reality.

### Organization/facility
- facility access can be a Work Condition;
- facility redesign Work makes layout the target/domain;
- organizational authority remains Actor/control semantics even when organizational state creates an environmental condition.

## Environment identity

The parent ground does not require one universal `Environment instance` identity.

Identity can be meaningful at different analytical levels:
- selected scope/reference frame;
- concrete situational configuration;
- support-context continuity;
- domain-region continuity;
- protected equivalence for a specific use.

The TWE corpus provides deep identity/equivalence semantics for technical support contexts. Those should not be generalized mechanically to every physical/social/domain environment.

For the parent ground, the stronger general rule is:

> **State what environmental scope/configuration is being referred to and which changes matter to the protected analysis.**

## Boundary lifecycle

Boundaries themselves may need revision as coupling, authority or control changes.

Examples:
- service moves from external dependency to internally operated component;
- formerly manual support becomes integrated automation;
- organization acquires a supplier;
- emergency response establishes temporary control over external resources;
- distributed system federation changes which elements are jointly controlled.

This produces a boundary-lifecycle problem, but current evidence does not justify a separate Environment branch. It is a dimension of reference/scoping over time.

## Failure surfaces

- stale boundary after system coupling changes;
- role assumed permanent when Work changes;
- target condition mistaken for support condition or vice versa;
- same concrete element duplicated as if roles implied separate identity;
- lower-level TWE identity rules generalized to all Environment cases;
- widening the boundary until Environment becomes empty or narrowing it until load-bearing conditions disappear.

## Result

Environment should be modeled/researched as **role- and boundary-relative realized conditions**, with explicit support for nesting and role switching.

This strengthens the problem-ground framing and further weakens any interpretation of Environment branches as exclusive entity classes.