# Actors — Frame Evolution

**Status:** HISTORICAL / AUDIT — research-frame evolution; not the current synthesis  
**Started:** 2026-09-01  
**Closed:** 2026-09-01

> This file records materially important framing changes during Actors research. It is retained for audit/path recovery. For the current positive result, read `KEY.md`, `FINDINGS-MAP.md` and `synthesis/ACTORS-VERTICAL-SYNTHESIS.md`.

## Why this file exists

This file records materially important framing changes so later readers can distinguish abandoned or weakened frames from the current result.

## F0 — weak starting label

Starting research label: `Actors`.

Weak intuition: the region concerns things that act, decide, exercise authority/capability, bear responsibility/accountability, represent/delegate, act collectively, or participate as non-human systems.

This was explicitly not treated as a taxonomy or accepted primitive.

## F1 — persistent entity-centred Actor

Initial rival frame: model a persistent Actor entity and attach identity, role, capability, authority, responsibility, accountability and delegation as properties/relations.

### What evidence preserved

Persistent bearers matter for continuity across episodes: people, organizations, software systems and other identifiable entities recur over time. W3C PROV also demonstrates that an agent/entity anchor can be useful in an interoperability model.

### What evidence weakened

The frame becomes misleading if the persistent entity is treated as the sufficient analysis unit:

- W3C PROV separates agent identity from association to an activity, role, attribution and delegation.
- IETF RFC 8693 separates token subject, current actor, authorized prospective actor, delegation history and impersonation semantics.
- NIST ABAC makes authorization an evaluation over subject/object/operation/environment attributes under policy rather than an intrinsic subject property.
- NIST RBAC separates users, roles, permission-role assignment and session-time role activation.
- agency law distinguishes principal, agent, authority, on-behalf-of relation and third-party reliance.

**Current judgment:** persistent entities are useful anchors but an entity-only Actor model loses first-order semantics.

## F2 — role / position centred

Rival frame: make social/organizational role or position primary and derive Actor participation through role occupancy.

### What evidence preserved

Roles can mediate permission and authority independently of user identity. NIST RBAC makes user-role and permission-role relations fundamental and allows only a subset of assigned roles to be active in a session. Roles therefore survive occupant changes and are not identical to people.

### What evidence weakened

Role is not sufficient for all Actor-region phenomena:

- one entity can participate in an episode in a function not reducible to a standing organizational role;
- causal contribution, technical capability, representation, attribution and moral/legal responsibility can diverge from role membership;
- software and distributed human-machine systems can participate operationally without fitting a social office model.

**Current judgment:** role/position is a first-order relation/bearer of institutional semantics, not a universal replacement for Actor.

## F3 — action-event / participation centred

Explicit non-Actor-centred rival: make an action/decision/commitment episode primary and represent participant positions such as performer, initiator, decider, authorizer, principal, representative, beneficiary, recipient or accountable party. `Actor` becomes a derived description of a bearer occupying one or more positions.

### What evidence preserved

This frame strongly explains why:

- performer, subject, principal and authorized actor can differ;
- multiple participants can be attached to one activity with distinct roles;
- the same bearer can have different roles in different episodes;
- delegation can be activity-specific and temporally scoped;
- attribution of an automated output can differ from the system that operationally produced it.

### What evidence weakened

The first weakness was continuity: an episode-only model fragments durable identity, standing authority, organizational structure, continuing duties and latent capability. Some facts exist before any particular episode.

A later omission probe exposed a deeper weakness: **agency and responsibility can concern intentional omissions, failures to act or refraining, which need not be events in the same sense as performed actions.** A model whose primitive is only an observed action event can therefore make normatively significant non-occurrence invisible.

The non-Actor alternative was accordingly widened from `event + participant` to something closer to **situation/episode + available or expected conduct + participation/decision/omission relations**.

**Current judgment:** the action-event frame remains the strongest corrective to naive Actor-entity modelling, but literal event-centrism is rejected. The evidence supports a multi-anchor relational account with situations/episodes broad enough to represent action and meaningful non-action.

## F4 — institutional attribution / principal–agent frame

Rival frame: focus on rules and relationships that make actions or outcomes count as the act of another person, office or organization.

### What evidence preserved

Agency law, W3C delegation, and UNCITRAL automated-contract attribution all show that operational performance and normative/legal attribution can be different facts. Acting `on behalf of` another is relational and normally requires some authority, authorization procedure or attribution rule.

### What evidence weakened

Formal attribution rules do not exhaust causal capacity, competence, informal coordination, distributed cognition or software autonomy.

**Current judgment:** indispensable for representation, delegation and organizational/legal attribution, but not the whole region.

## F5 — authorization / control frame

Rival frame: focus on who may cause which protected operation under what policy, context, role and delegation chain.

### What evidence preserved

NIST ABAC/RBAC and RFC 8693 strongly support context-, relation- and session-sensitive authorization. They also expose separation-of-duty and delegation/impersonation differences.

### What evidence weakened

Authorization models intentionally say little about intention, causal/moral responsibility, accountability fora, collective attitudes or whether a system is an autonomous operational participant.

**Current judgment:** authority/permission is a first-order dimension but cannot stand in for agency, capability, responsibility or accountability.

## F6 — collective / distributed system frame

Rival frame: treat sufficiently organized collectives or coupled human-machine arrangements as the relevant acting/cognitive unit.

### What evidence preserved

Christian List distinguishes aggregate, common and corporate attitudes; only the corporate case commits to group agency, and corporate attitudes need not equal majority attitudes of members. Cognitive Systems Engineering likewise provides cases where system performance is analysed at the joint human-machine level rather than by decomposing components in isolation.

### What evidence weakened

Not every collection is an agent. Group agency depends on organization and decision structure, while legal or accountability attribution may still target particular persons, offices or organizations. A distributed operational unit does not automatically become a legal or morally responsible person.

**Current judgment:** collective and distributed agency are conditional analytical achievements, not consequences of plurality.

## Current frame after omission-driven revision

The research closed on a **relational and multi-anchor** explanation:

1. persistent **bearers** provide continuity;
2. **contexts and time** determine which standing facts are relevant;
3. **situations / episodes** provide a locus for concrete action, decision, commitment and meaningful non-action;
4. **available, expected or required conduct** matters where omission or duty is at issue;
5. distinct **participation relations** record who performed, initiated, decided, authorized, represented, received, benefited, was affected, refrained or failed to act where material;
6. distinct **normative relations** record permission/authority, obligation/duty, representation/delegation and institutional standing;
7. distinct **attribution relations** record causal attribution, provenance/responsibility, legal attribution and accountability;
8. **collective/distributed organization** determines when system- or group-level descriptions are warranted rather than merely aggregated.

This historical frame evolution supports the current synthesis; it does not override it and is not a SOUL data model or ontology decision.
