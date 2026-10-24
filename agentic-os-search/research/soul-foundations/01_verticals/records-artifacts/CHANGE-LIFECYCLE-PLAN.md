# Records / Persistent Information — Change, Status, and Temporal Semantics Pass

**Status:** active approved/re-anchored research plan  
**Date opened:** 2026-09-01

## Direction re-check

The first three Records passes established:

1. record/resource identity is not equivalent to file/storage identity;
2. resource, version/revision, representation/instance, derivation, and aggregation must not be collapsed;
3. durable future use depends on a parameterised preservation closure, not a universal object-local metadata bundle;
4. temporal/version/status closure becomes load-bearing whenever information evolves;
5. retention/disposition is a neighbouring Records problem and actor/policy authority remains cross-vertical.

Therefore the highest-information next question remains change/status/time, but the scope is refined to avoid drifting into temporal-database architecture or full retention governance.

## Purpose

Determine which **semantic distinctions about change through time** must be preserved so a persistent information resource can support both:

- its present/current standing, and
- reconstructable historical states, identities, provenance, and status transitions.

The pass asks what different kinds of change *mean* for a record/resource. It does not choose how a future system stores them.

## Core question

> Which change events, status distinctions, identity effects, and time dimensions must remain distinguishable across creation/capture, revision, representation migration, semantic derivation, supersession, correction, retraction/invalidation, and terminal disposition history so that current and historical meaning can coexist without generic `update` destroying information?

## Scope

### A. Change-kind semantics

Compare and counter-test at least:

- creation / capture / registration;
- content revision / versioning;
- representation migration / re-instantiation;
- semantic derivation;
- supersession / replacement;
- correction / erratum;
- retraction / invalidation / withdrawal;
- archival/preservation transformation events;
- disposition/destruction history only at the record-side semantic boundary.

### B. Status semantics

Test whether distinctions such as the following produce materially different reconstruction/use outcomes:

- draft;
- current;
- authoritative/current-of-record;
- historical;
- superseded;
- corrected;
- retracted/invalidated;
- withdrawn;
- archived/preserved;
- disposed/destroyed.

Do not retain terms merely because a source uses them; merge or split only when the distinction changes identity, reconstruction, interpretation, authority signal, or lifecycle meaning.

### C. Temporal semantics

Compare time dimensions including:

- occurrence/event time;
- observation time;
- creation/capture/registration time;
- valid/effective time;
- transaction/recording/system-known time;
- version/modification time;
- publication/release time;
- supersession/correction/retraction time;
- disposition/destruction time.

The goal is not a universal timestamp list. The goal is to identify which semantic differences are load-bearing under which resource/use conditions.

### D. Identity and provenance continuity

Test how each change kind affects:

- higher-level resource identity;
- version/revision identity;
- representation/instance identity;
- derived-resource identity;
- provenance/history links;
- currentness/authority status;
- historical reconstructability.

Use the previous significant-property / Preservation Objective result when transformation identity is ambiguous.

### E. Current + historical coexistence

Research what information must survive so the system can answer both:

- `What is current/valid/authoritative now?`
- `What existed/was believed/published/valid/known at time T?`

without overwriting one with the other.

## Deliberate exclusions

Do not select/design:

- event sourcing, temporal-table, append-only, immutable-object, or bitemporal storage architecture;
- database schema, event schema, status enum, serialization, Git/object-store model;
- SOUL memory or state architecture;
- Work workflow/state-machine semantics;
- Actor identity, approval, delegation, or permission model;
- who is authorised to correct/retract/supersede/destroy;
- retention schedule policy or legal disposition decision logic;
- retrieval/index implementation.

Technical systems may be used only as counterexamples showing semantic distinctions.

## Disposition boundary

Disposition is included only to answer the Records-side question:

> When payload/content is expired, deleted, or destroyed, what identity/status/history facts may still need to remain reconstructable?

The authority, policy, timing decision, legal hold, and execution workflow are deferred to later Work/Actors/policy synthesis.

## Evidence lenses

- records management / archival standards and guidance;
- scholarly version-of-record / correction / retraction standards;
- provenance models (especially revision/derivation semantics);
- temporal database theory (valid vs transaction/system time as semantic evidence, not architecture prescription);
- preservation-event models (PREMIS/OAIS);
- persistent-identifier/version practices;
- public-sector retention/disposition guidance only for record-side status/history semantics;
- technical history/state systems as falsifying examples where useful.

## Counter-frames / falsifiers

Actively challenge:

- every change should create a new version;
- every new file/representation is a new version;
- correction is just revision;
- supersession and retraction are equivalent;
- current/authoritative status can always be inferred from latest timestamp;
- one time axis is sufficient;
- event history alone preserves semantic meaning;
- immutable history automatically preserves truth/authenticity;
- deletion must erase all identity/history;
- archival/status vocabulary generalises unchanged to operational resources;
- bitemporal/event-sourcing terminology is the natural ontology of Records.

## Operational return condition

Return to the user only when:

1. main change kinds have been compared across multiple independent disciplines;
2. status distinctions have been reduced to those with materially different Records-side semantics rather than copied as vocabulary;
3. load-bearing time dimensions have been identified conditionally, with examples showing when two times diverge;
4. identity/provenance effects of revision, migration, derivation, supersession, correction, and retraction are explicit;
5. current-state and historical-state reconstruction requirements are explicit;
6. disposition's record-side semantic boundary is separated from policy/authority/workflow;
7. at least one adversarial pass has searched for collapsed or over-separated distinctions and architecture contamination;
8. source trace and bounded synthesis are persisted in the repository;
9. the next internal Records direction can be re-derived from the result rather than inherited from this plan;
10. no storage architecture, SOUL schema, Work model, Actors model, or authority system has been selected.

Meeting this condition does not complete the Records vertical.