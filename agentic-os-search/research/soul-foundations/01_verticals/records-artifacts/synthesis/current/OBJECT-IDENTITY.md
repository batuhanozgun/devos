# Records — Current Object / Identity Result

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Integrates:** legacy `OBJECT-BOUNDARIES.md`, `ARTIFACT-COUNTERCHECK.md`, and relevant foundational findings.

## Current bounded result

Persistent information should not be modelled by assuming that file, record, version, copy, representation, derived output and aggregate are the same thing.

Keep these distinctions separate when the protected use can tell them apart:

- a broader persistent information/resource identity;
- record role/status in a context;
- version or revision identity;
- representation / instantiation / copy;
- derived resource;
- aggregate / set / contextual grouping.

This is not a mandatory class hierarchy.

## Recordhood

`Record` is narrower than `anything persisted`.

The strongest current frame is contextual and representational: an information-bearing representation can have record status because it persists/recoverably represents something and is retained/used in a context for reference, evidence, accountability, memory or information purposes.

Persistence alone is insufficient. A byte-identical copy can have different record status because use/context differs.

## Identity across change

A new file does not automatically mean a new record or version. A new representation can still express the same higher-level resource/version. A semantic derivation normally warrants its own identity and provenance. Aggregation/order can itself carry meaning that item-level identity does not.

No universal file-operation rule decides whether a transformation is:

- same representation;
- new representation;
- new version;
- new resource/record;
- semantic derivation.

That threshold is profile/domain dependent on protected function, significant properties and semantic effect.

## `Artifact`

Unqualified `artifact` is not retained as the foundational super-category. Across domains it can mean a physical object, software work product, evidence, research output or even an unintended technical by-product.

Use `artifact` only when its source/domain meaning is explicit.

## Guardrails

- same bits ≠ same record role;
- resource identity ≠ version identity;
- version identity ≠ representation/copy identity;
- migration ≠ necessarily revision;
- derivation ≠ necessarily revision;
- aggregate membership/order can be information-bearing;
- authenticity/integrity ≠ factual correctness.

## Audit / evidence route

Use `../../INDEX.md` for the exact L4A adversarial/history route, L4B source-ledger route and L5 primary-source route for this topic.