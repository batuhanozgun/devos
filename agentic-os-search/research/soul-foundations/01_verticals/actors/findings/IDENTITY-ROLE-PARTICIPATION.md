# Actors Finding — Identity, Role, Context and Participation

**Status:** current topic finding  
**Scope:** Actors-local distinctions; not a SOUL data-model decision

## Current finding

A persistent bearer, a role/office, and participation in a concrete episode are distinct analytical facts.

The research does not support treating any one of them as a universal replacement for the others.

## Distinctions to preserve

### 1. Persistent bearer ≠ role

A person, organization, software system or other identifiable bearer can persist while role assignments change. Conversely, a role can persist while its occupant changes.

NIST RBAC makes this separation explicit through distinct user–role and permission–role relations rather than attaching all permissions directly to the user.

### 2. Assigned role ≠ active role in the current context

NIST RBAC sessions activate only a subset of roles assigned to a user. Dynamic separation-of-duty constraints can make two otherwise authorized roles mutually unavailable in the same session or transaction.

Therefore `has role`, `may activate role`, and `is acting in role now` are not interchangeable.

### 3. Bearer ≠ event participant position

W3C PROV represents an agent separately from its association with an activity and allows a role to qualify that association. One bearer can participate in different activities under different roles, while one activity can involve several agents.

The episode-specific relation carries information that cannot safely be recovered from persistent identity alone.

### 4. Identity/continuity is still useful

The non-Actor-centred event/participation frame explains episode semantics better than an entity-only model, but it does not eliminate the need for continuity across episodes. Standing role, membership, authority, competence, obligations and organizational identity can exist before any single activity occurs.

The strongest current account therefore keeps persistent bearers and event participation as separate anchors.

## Decision-critical implication

The initial assumption that `Actor identity` can serve as the container for role, authority and participation is rejected.

A later SOUL synthesis must be able to distinguish at least:

- who/what persists across time;
- which role/office/position is held;
- which role/position is active in a context;
- which episode is under discussion;
- how the bearer participates in that episode.

This is a semantic requirement, not a prescribed schema.

## Evidence used

### NIST Role Based Access Control

Inspected view:
- NIST CSRC RBAC project FAQ, current web view.
- Core RBAC definitions for user-role assignment, permission-role assignment and session role activation.
- Static and dynamic separation-of-duty descriptions.

Source:
- https://csrc.nist.gov/Projects/role-based-access-control/faqs

Supports:
- user/identity, role, permission and active-session role are distinct;
- authority can depend on context and constraints rather than a static user property.

Does not establish:
- a universal social ontology of persons or organizations;
- moral/legal responsibility semantics.

### W3C PROV-DM

Inspected view:
- W3C Recommendation, 30 April 2013.
- Sections 5.3.1 Agent and 5.3.3 Association.

Source:
- https://www.w3.org/TR/prov-dm/

Supports:
- agent identity can be distinct from activity association;
- association may be qualified by a role;
- one provenance model gains expressiveness by keeping these relations explicit.

Does not establish:
- that PROV's `Agent` is the correct SOUL primitive;
- that all Actor-region semantics are provenance semantics.

## Residual uncertainty

- Whether office/position needs to be represented independently from role in a later synthesis remains open.
- The precise continuity rules for organizations, collectives and software systems are domain-sensitive and not resolved here.
