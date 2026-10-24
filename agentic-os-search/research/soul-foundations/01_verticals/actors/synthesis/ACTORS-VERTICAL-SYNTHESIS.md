# Actors — Vertical Synthesis

**Status:** current consolidated research result; bounded foundation synthesis  
**Date:** 2026-09-01  
**Scope:** independent Actors foundation research only

## Executive result

The research does **not** support `Actor` as a single self-sufficient primitive whose identity carries role, capability, authority, responsibility and accountability as a coherent bundle.

It also does not support replacing Actor entities with one other universal primitive such as `role` or `action event`.

The strongest current explanation is **relational and multi-anchor**. The problem region becomes intelligible only when several different things are allowed to vary independently:

- persistent bearers/identities;
- roles, offices, membership and standing positions;
- context and time;
- situations/episodes, including meaningful non-action;
- participation and decision positions;
- operational capability/competence;
- permission, authority/power and obligation;
- representation, delegation, impersonation and on-behalf-of relations;
- causal/provenance/legal/institutional attribution;
- responsibility and accountability relations;
- shared/joint action and organized corporate/group agency;
- operational non-human participation versus legal/moral/personhood attribution.

`Actors` may remain a useful retrieval label for this problem region, but the research weakens any interpretation of it as a final ontological category.

---

## 1. What changed from the starting frame

### Starting intuition

The starting label suggested things that act, decide, exercise authority/capability, bear responsibility/accountability, represent/delegate or act collectively.

The main risk was to turn that list into a taxonomy of Actor properties.

### Evidence-driven revision

The evidence repeatedly separated the apparent bundle:

- W3C PROV separates agent identity from activity association/role, attribution and delegation.
- NIST RBAC separates user, role, permission and active session role.
- NIST ABAC makes authorization depend on policy, attributes, operation and environment.
- RFC 8693 separates subject, current actor, prospective authorized actor, delegation history and impersonation.
- agency law separates principal, agent, actual/apparent authority, on-behalf-of relation, control and third-party reliance.
- responsibility literature separates causal contribution, obligation, moral responsibility and accountability.
- collective-agency literature separates aggregation, shared/joint activity and organized corporate agency.
- automated-contract law separates an automated system carrying out an action from the person to whom the action is legally attributed.

The result is not `a better list of Actor types`; it is a rejection of the assumption that one Actor-centred unit can safely carry these semantics by default.

---

## 2. Rival frames and current verdict

### F1 — Persistent Actor entity

**Kept:** persistent identity/continuity is necessary for many questions across time.

**Rejected as sufficient:** identity does not determine current role, permission, participation, delegation, responsibility or attribution.

**Verdict:** useful anchor, not sufficient primitive.

### F2 — Role/position as primary

**Kept:** institutional roles can persist independently of occupants and mediate authority/permission.

**Rejected as sufficient:** causal contribution, episode participation, software agency, representation and responsibility can diverge from role occupancy.

**Verdict:** first-order relation/position, not universal replacement.

### F3 — Action-event/participation as primary — explicit non-Actor-centred alternative

**Kept:** strongly explains why performer, decider, authorizer, principal and accountable party can differ in one episode.

**Rejected in literal event-only form:** standing authority/identity exists outside events; omission/refraining can be agency- or responsibility-relevant without a positive action event.

**Revised alternative:** situation/episode + available/expected conduct + typed participation/decision/omission relations.

**Verdict:** strongest corrective to entity-centred modelling, but still requires other anchors.

### F4 — Institutional attribution / principal-agent frame

**Kept:** explains on-behalf-of action, authority, representation and why operational production can differ from institutional/legal attribution.

**Rejected as complete:** does not exhaust competence, informal cooperation, causal contribution or joint cognitive/system performance.

**Verdict:** indispensable first-order relation family, not whole region.

### F5 — Authorization/control frame

**Kept:** exposes context, policy, role activation, constraints and delegation chain.

**Rejected as complete:** permission/authority does not establish duty, competence, intention, causal responsibility or accountability.

**Verdict:** one first-order dimension.

### F6 — Collective/distributed frame

**Kept:** shared/joint activity and organized corporate agency can exceed simple aggregation; joint human-machine system can be a useful operational analysis unit.

**Rejected as universal:** not every plurality is a group agent; system-level operation does not settle legal/moral/accountability attribution.

**Verdict:** conditional analysis level, not consequence of plurality.

---

## 3. First-order distinctions the later work must not lose

### D1 — Bearer identity vs role/position vs contextual participation

A persistent bearer can hold multiple roles over time and can participate differently in each episode. A role can survive occupant change. An assigned role can be inactive in a session.

Preserve the ability to distinguish:
- who/what persists;
- what standing position is held;
- what position is active now;
- how the bearer participates in the present situation.

Confidence: **strong**.

### D2 — Capability/competence vs permission/authority vs obligation

`Can`, `is skilled/competent`, `may`, `has power/authority`, and `must/ought` are not synonyms.

Authorization may depend on policy, context, operation and relationships; competence is a different kind of capacity; legal capacity/standing is another again.

Confidence: **strong on non-collapse; moderate on universal vocabulary**.

### D3 — Performer vs initiator/requester/decider/authorizer/principal/representative

One episode can distribute these positions across several bearers. Execution alone does not identify who decided, authorized or is represented.

Confidence: **strong**.

### D4 — Own-behalf action vs representation/delegation/impersonation

Acting for oneself is distinct from acting on behalf of a principal. Delegation and impersonation are distinct in RFC 8693; legal agency distinguishes principal, representative and authority.

Delegation can have scope, history, activation and temporal lifecycle. Responsibility can remain with a principal after delegation.

Confidence: **strong on non-collapse; domain-specific on exact legal/technical semantics**.

### D5 — Actual authority vs apparent/third-party-facing authority

Actual authority and apparent authority can diverge. Actual authority may end while apparent authority persists until notice.

This proves authority can be perspective- and time-sensitive, not just an internal grant.

Confidence: **strong as legal counterexample; not generalized as universal doctrine**.

### D6 — Positive action vs decision/refraining/omission

Agency and responsibility can concern deliberate non-action or failure to perform expected/available conduct. An event-only model can erase meaningful omission.

Confidence: **strong that event-only is insufficient; ontology of omissions remains open**.

### D7 — Causal/provenance/legal attribution vs responsibility vs accountability

Causing an outcome does not by itself establish moral responsibility. Responsibility may also mean a forward-looking duty. Accountability can be an actor–forum process rather than an intrinsic property.

Preserve typed attribution and the relevant normative regime.

Confidence: **strong on non-collapse; specific responsibility regimes remain contextual**.

### D8 — Mere aggregation vs shared/joint agency vs corporate/group agency

Several people behaving similarly are not necessarily acting together. Shared action can exist without positing a separate enduring group agent. Corporate agency can arise through organizational structures/decision procedures and need not equal member-majority attitudes.

Confidence: **strong on the need for distinctions; contested on exact thresholds**.

### D9 — Operational non-human participation vs legal/moral/personhood attribution

Software or automated systems can operationally act, be provenance agents or form part of a joint system without thereby becoming the legal or moral bearer of the action.

A global `is Actor` flag would collapse semantic layers.

Confidence: **strong on non-collapse; open on domain-specific agency/personhood thresholds**.

### D10 — Context and time are first-order qualifiers

Role activation, authority, delegation, apparent authority, capability, organizational membership and responsibility conditions can change over time or vary by situation.

The foundation cannot safely model them as timeless Actor properties.

Confidence: **strong**.

---

## 4. Current multi-anchor explanation

The research currently needs no single foundational Actor object. A later synthesis should instead be able to reason over at least these conceptual anchors when relevant:

1. **bearers** — persistent persons, organizations, systems or other identity-bearing units;
2. **positions** — roles/offices/memberships/standing relations;
3. **situations/episodes** — the concrete context in which action, decision, commitment or non-action matters;
4. **possible/expected conduct** — where capability, duty or omission is relevant;
5. **participation relations** — performer, initiator, requester, decider, authorizer, representative, recipient, beneficiary, affected party, etc.;
6. **normative relations** — permission, authority/power, obligation/duty, representation/delegation, legal/institutional standing;
7. **attribution relations** — causal, provenance, legal/institutional and responsibility/accountability forms;
8. **collective organization** — the structures and shared commitments/decision procedures that distinguish aggregation, shared action and corporate agency;
9. **temporal/context qualifiers** — scope, activation, expiry, revocation, notice, environment and other conditions.

This is intentionally **not** a proposed schema. It is the minimum semantic separation that current evidence says later work should not destroy.

---

## 5. What the `Actors` label now means

`Actors` remains acceptable as a practical repository/research label only with a warning:

> it names a problem region around bearers, participation, agency, authority, representation and attribution; it does not mean the research found a natural universal class of `Actor entities`.

A later synthesis may rename, split or dissolve the vertical without contradicting this result.

---

## 6. Strong results vs unresolved questions

### Strong enough for current foundation purpose

- identity, role and episode participation must be separable;
- capability/competence, permission/authority and obligation must not collapse;
- performer/decider/authorizer/principal/representative can differ;
- own-behalf, delegation and impersonation are distinct;
- attribution and responsibility/accountability require typed semantics;
- context/time can change authority/role/delegation state;
- event-only analysis misses meaningful omissions;
- shared action, corporate agency and aggregation are different;
- non-human operational agency does not settle legal/moral/personhood attribution.

### Still uncertain / context-sensitive

- exact universal vocabulary for role/office/position;
- competence taxonomy;
- boundary between permission, authority, power and mandate across domains;
- thresholds for shared or corporate agency;
- ontology/representation of omission;
- organization/software identity continuity rules;
- responsibility regimes needed by future SOUL uses;
- non-human moral/legal agency thresholds.

These are preserved in `OPEN-QUESTIONS.md`.

---

## 7. Cross-vertical boundary

Actors research exposed relations to Work and Records but did not solve them.

Examples:
- who can decide/approve/commit to Work;
- how omission relates to expected Work;
- what Records prove historical authority/delegation/identity;
- how organizational decisions map to Work realization;
- how automated Work separates performer from principal/accountable party.

These are recorded in `DEFERRED-RELATIONS.md` and require independent recovery of the relevant vertical evidence in any later authorized synthesis.

---

## 8. Why research can stop at bounded completion

The research did not stop because a fixed topic list was exhausted.

It progressed through rival frames and targeted counter-search:

1. entity-centred frame was challenged by provenance, access-control, delegation and agency-law evidence;
2. role-centred and authorization-centred alternatives were tested and found useful but incomplete;
3. explicit non-Actor event/participation frame initially appeared strongest;
4. omission research produced a genuine new first-order falsifier, forcing that frame to widen beyond positive events;
5. collective research separated shared/joint action from corporate/group agency;
6. later probes into trust, fiduciary duty, competence, separation of duty, apparent authority and additional collective cases predominantly mapped to established dimensions rather than creating new first-order families.

The marginal information value for discovering **new first-order Actors dimensions** has therefore declined. Additional literature remains abundant, but it is increasingly likely to refine thresholds, vocabulary or domain-specific rules rather than alter the current foundation separation.

The associated completion/omission judgment is documented separately and is explicitly a **same-model adversarial self-review, not independent verification**.

---

## 9. Evidence recovery

Topic findings:
- `findings/IDENTITY-ROLE-PARTICIPATION.md`
- `findings/CAPABILITY-AUTHORITY-OBLIGATION.md`
- `findings/REPRESENTATION-DELEGATION-ATTRIBUTION.md`
- `findings/ACTION-OMISSION-DECISION.md`
- `findings/RESPONSIBILITY-ACCOUNTABILITY.md`
- `findings/COLLECTIVE-INSTITUTIONAL-AGENCY.md`
- `findings/NONHUMAN-DISTRIBUTED-AGENCY.md`

Frame history:
- `FRAME-EVOLUTION.md`

Source/view recovery:
- `evidence/SOURCE-LEDGER.md`

Residuals:
- `OPEN-QUESTIONS.md`
- `DEFERRED-RELATIONS.md`

Completion challenge:
- `synthesis/COMPLETENESS-OMISSION-CHECK.md`

The short retrieval surfaces and freshness manifest are maintained separately so later readers can descend only as far as the decision requires.
