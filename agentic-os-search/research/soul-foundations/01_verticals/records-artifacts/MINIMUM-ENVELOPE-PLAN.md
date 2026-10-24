# Records / Persistent Information — Minimum Envelope Research Pass

**Status:** completed at return condition  
**Date opened:** 2026-09-01  
**Date closed:** 2026-09-01

## Direction re-check

This pass remains inside the Records / persistent-information vertical. Its purpose is not to design SOUL memory, choose a database, define a universal metadata schema, or optimise retrieval technology.

The previous object-boundaries pass established enough separation among higher-level information-resource identity, record role/status, version/revision, representation/instantiation, derivation, and aggregation to ask a deeper Records question without treating files as the natural unit.

The highest-information unresolved question is therefore not `which storage mechanism?` but `what must survive?`.

## Refined purpose

Determine which **preservation/information obligations** must accompany or remain recoverably linked to a persistent information resource so that it can later be identified, interpreted, contextualised, traced, placed in time/status, assessed for integrity/currentness, related to other resources, and retrieved/reconstructed appropriately.

Do **not** assume there is one universal minimum metadata bundle.

The pass will instead distinguish:

1. candidate obligation/property families that recur across materially different disciplines;
2. obligations that are invariant in purpose but variable in representation/strength;
3. obligations that are conditional on resource class, use/risk, or retention horizon;
4. information that must be intrinsic to the payload/object from information that may safely remain externally linked in registries, provenance graphs, catalogues, preservation systems, or other context structures;
5. information that is merely useful/discovery-enhancing rather than necessary for a stated preservation/reuse objective.

## Core questions

1. What must remain knowable for **identity** continuity?
2. What must remain knowable for **interpretability / representation** continuity?
3. What context/provenance must remain recoverable to understand origin, derivation, occurrence/activity relation, and transformation history?
4. Which **temporal** and **status/change** facts must remain distinguishable?
5. What integrity/fixity/authenticity evidence is required, and what does it not prove?
6. Which relations/aggregation structures must remain recoverable rather than being treated as optional organisation?
7. What discovery/index information is actually preservation-critical versus reconstructable or convenience-only?
8. Which obligations differ by persistent-resource class and by retention/use horizon?
9. Must the required information travel inside the object, or is recoverable external linkage sufficient? Under what failure conditions does externalisation become unsafe?
10. Is `minimum envelope` itself the wrong abstraction — should the result instead be a set of preservation obligations with class/horizon-specific profiles?

## Research lenses

- records metadata / recordkeeping metadata standards and guidance;
- digital preservation / OAIS / PREMIS;
- archival description and contextual relations / ICA RiC;
- provenance / W3C PROV;
- persistent identification and versioning / DataCite and related identifier practice;
- data stewardship / FAIR, especially findability, accessibility, interoperability and reuse requirements;
- metadata interoperability / Dublin Core or similar minimal descriptive vocabularies where useful;
- temporal/version/configuration models where they clarify change history;
- authoritative public-sector records guidance where it exposes practical minima or lifecycle distinctions.

These are evidence lenses, not candidate SOUL components.

## Counter-frames / falsifiers

Actively challenge at least these assumptions:

- every candidate property must be stored on every object;
- `more metadata` is always safer;
- one minimum profile can serve session-scale and archival-scale use equally well;
- persistent identifiers alone preserve identity;
- fixity alone preserves authenticity/trust;
- provenance alone preserves meaning;
- descriptive/search metadata is always part of the preservation envelope;
- externally linked metadata is always sufficient if a pointer exists;
- metadata schemas are the natural unit of the problem rather than preservation obligations and failure consequences;
- current/authoritative status can be inferred later from version history without explicit status evidence.

## Scope exclusions

Do not select or design:

- SQL/NoSQL/graph/vector database architecture;
- filesystem/Git/object-store implementation;
- embedding/search/ranking algorithms;
- concrete SOUL metadata schema or memory architecture;
- Work or Actors models;
- permissions/authority implementation;
- orchestration;
- SOUL Development System or product architecture.

Cross-vertical relations may be recorded but are deferred.

## Evidence discipline

For each candidate obligation/property:

- identify source/domain support;
- state the failure it prevents or capability it preserves;
- distinguish direct source observation from cross-source synthesis;
- test removal: can the stated future use still succeed if this information is absent?
- test substitution: can another property or external relation provide the same obligation?
- test horizon/class sensitivity;
- record conflicts and limits.

## Operational return condition

Return to the user only when all are satisfied sufficiently for the current research purpose:

1. the main candidate obligation/property families have been tested across multiple independent lenses;
2. a distinction exists between **invariant obligation**, **conditional obligation**, and **useful but non-minimum metadata**;
3. intrinsic payload information versus externally linked/contextual information has been analysed with failure cases;
4. class/risk/retention-horizon sensitivity has been tested rather than assumed;
5. at least one serious omission/adverse-evidence pass has challenged the resulting model;
6. `minimum envelope` has either survived as a useful abstraction or been replaced by a better evidence-supported frame;
7. the result is expressed as a bounded conceptual model, not a concrete storage/schema architecture;
8. source trace, synthesis, counterexamples, and unresolved questions are persisted in the repository;
9. the next internal Records research direction can be re-derived from the result rather than inherited from the pre-pass plan.

Meeting this condition does not complete the Records vertical.

## Close note

The return condition was met. The pass replaced the physical/object-local `minimum envelope` assumption with a parameterised **minimum preservation closure** model. See `synthesis/MINIMUM-ENVELOPE.md` and its adversarial counter-check for the bounded result.