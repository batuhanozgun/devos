# Records / Artifacts — Object Boundaries Research Pass

**Status:** authorised and executed  
**Authorisation:** user approved the purpose, scope, exclusions, and return condition in ChatGPT before substantive execution of this pass on 2026-09-01.  
**Epistemic note:** this file was persisted during execution, so the repository timestamp is not a pre-registration timestamp; the criteria below reproduce the pre-execution authorised scope and were not changed to fit the results.

## Purpose

Determine the conceptual object boundaries inside the Records vertical before investigating storage or architecture mechanisms.

The pass asks:

> Among persistent information-bearing things, which distinctions are genuinely load-bearing; when does something count as a record; is `artifact` a necessary broader category; and how do identity, version, representation, copying, derivation, and change affect object boundaries?

This is a problem-model pass, not a SOUL data-model design.

## Central questions

1. **Recordhood boundary** — when does an information-bearing thing become a record, and is recordhood intrinsic, contextual, functional, evidential, or some combination?
2. **Natural object model** — which distinctions among information resource/object, document, record, artifact, representation/instantiation, copy, version/revision, aggregation, and derived view have independent semantics?
3. **Artifact boundary** — should `artifact` be retained, redefined, split, or discarded as a foundational Records category?
4. **Identity and change** — when do copy, migration, format conversion, revision, correction, retraction, summarisation, or aggregation preserve identity versus create a new object?

## Method

Compare multiple independent conceptual traditions rather than selecting one by familiarity:

- archival science / records management;
- ICA Records in Contexts;
- diplomatics / InterPARES;
- record theory (`persistent representation` frame);
- web resource/representation architecture;
- W3C provenance/version relations;
- persistent identifier/version practices;
- scholarly version/correction/retraction practice;
- software/systems-engineering uses of `artifact` as a counter-frame.

Use source-specific terminology as evidence, not as an automatic SOUL taxonomy.

## Explicit counter-tests

- same bits / same file path / same format does not necessarily mean same record;
- different copies or formats may still instantiate the same higher-level record;
- a copy may gain distinct record status because of use/context;
- a revision may preserve a higher-level identity while requiring a distinct version entity;
- a derived view may be either a representation or a new derived information object depending on transformation semantics;
- `artifact` may be too polysemous to function as a stable super-category;
- recordhood may be neither purely intrinsic nor purely assigned by policy.

## Out of scope

- filesystem/database/vector/graph/Git selection;
- metadata schema implementation;
- retrieval ranking/embedding mechanisms;
- SOUL memory architecture;
- Work or Actors modelling;
- authority enforcement mechanisms;
- Development System or SOUL product architecture.

Cross-vertical dependencies may be recorded only as deferred relations.

## Return condition

Return to the user when:

1. major competing recordhood models have been compared;
2. load-bearing candidate object distinctions have been tested with counterexamples;
3. `artifact` has a bounded retain/redefine/split/discard verdict;
4. identity and change semantics are explicit enough to explain copy, representation, version, correction, derivation, and aggregation cases;
5. adverse evidence and unresolved ambiguity are explicit;
6. the source trace and synthesis are persisted;
7. remaining uncertainty is concrete enough to define the next internal Records research pass.

Meeting this condition does not complete the Records vertical.