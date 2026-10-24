# Records / Persistent Information — Findings Map

**Document role:** CURRENT_L1  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Status:** topic-level orientation/routing; not evidence.

Use this after `KEY.md` when L0 is not enough but reading the whole vertical would be wasteful.

Each section states the problem, current bounded result, and current L3 route.

## 1. What is the persistent thing?

**Problem:** file, record, version, representation, copy, derived output and aggregate are easy to collapse into one storage object.

**Current result:** keep broader resource identity, contextual record role, version, representation/copy, derivation and aggregation distinct when the protected use can tell them apart. Unqualified `artifact` is not the foundational super-category.

**L3:** `synthesis/current/OBJECT-IDENTITY.md`

## 2. What must survive with persistent information?

**Problem:** bytes can survive while identity, interpretation, context, relations or future use fail.

**Current result:** no universal object-local metadata envelope. Preserve a purpose-relative logical closure of load-bearing information/dependencies. Required knowledge can be embedded, linked, inherited, relational or reconstructable if its binding/survivability is protected.

**L3:** `synthesis/current/PRESERVATION-CLOSURE.md`

## 3. How does information change through time?

**Problem:** generic `update`, one status and one timestamp erase materially different meanings.

**Current result:** revision, migration, derivation, supersession, correction, retraction/removal, transfer and destruction can have different effects. Distinguish effective/applicable time from system-known/recorded time when both matter. Preserve only the history/standing needed for the protected use.

**L3:** `synthesis/current/CHANGE-TIME-STANDING.md`

## 4. How should persistent information be organised and found?

**Problem:** one hierarchy and one generic search contract mix context, description and access.

**Current result:** context/provenance organisation, descriptive/knowledge organisation and access organisation can diverge or legitimately coincide. Retrieval guarantees differ for exact, semantic, exhaustive, current, historical, provenance and aggregate questions. Hit/miss meaning depends on binding, coverage, freshness/as-of and matching behavior.

**L3:** `synthesis/current/ORGANISATION-RETRIEVAL.md`

## 5. Do all resources need the same Records requirements?

**Problem:** turning every discovered distinction into a universal checklist over-specifies some resources and under-specifies others.

**Current result:** derive a dated/recurrent requirement profile from exact scope, protected use, retrieval need, horizon, material risks, applicable baseline obligations, transformations, dependencies and user/knowledge assumptions. `UNKNOWN` is not `NOT REQUIRED`.

**L3:** `synthesis/current/REQUIREMENT-DERIVATION.md`

## 6. Which storage/history/search mechanism is right?

**Problem:** labels such as `temporal`, `versioned`, `graph`, `immutable` or `searchable` invite false guarantees.

**Current result:** mechanism families are partial semantic lenses, not mutually exclusive product classes or hard technology ceilings. Derive requirements first, then inspect the actual configured guarantees. Hybrid/multi-role composition is common but not universally required.

**L3:** `synthesis/current/MECHANISM-LANDSCAPE.md`

## 7. When should persistence end or custody change?

**Problem:** `keep forever` and `delete after N years` are inadequate universal rules.

**Current result:** retention/disposition can require exact scope, applicable rule/version, eligibility trigger, condition, holds/constraints, final action, execution evidence and allowed residual history. Eligibility, permission and execution are distinct; transfer, removal and destruction are distinct.

**L3:** `synthesis/current/RETENTION-DISPOSITION.md`

## 8. How can Records designs fail?

**Problem:** positive feature lists hide predictable semantic failure surfaces.

**Current result:** important families include loss/unreadability, dependency failure, identity drift, silent overwrite, time confusion, provenance/context loss, trust overclaim, stale/partial retrieval, rights/access failure, over/under-retention and storage-first modelling.

**L3:** `synthesis/current/FAILURE-SURFACES.md`

## 9. Why did the vertical stop?

**Problem:** foundational research can expand indefinitely.

**Current result:** a dedicated omission review found retention/disposition as the only clear missing first-order Records dimension at this foundation level; it was then researched. Remaining candidates currently classify as refinements, profile-specific decisions, implementation assurance or matters outside this vertical.

**L3:** `synthesis/current/COMPLETENESS.md`

## 10. What remains unresolved?

Use `OPEN-QUESTIONS.md` for bounded residual uncertainty and `DEFERRED-RELATIONS.md` for relations intentionally not solved by Records alone.

## When to use L2 instead of one L3 topic

If the question combines several sections above, read `synthesis/RECORDS-VERTICAL-SYNTHESIS.md` before selecting focused L3 files.

## When to descend below L3

- Need to challenge the result? → L4A countercheck + exact historical pass blob.
- Need claim/source provenance? → L4B pass/topic source ledger.
- Need exact/load-bearing evidence? → L5 primary source.

`INDEX.md` gives exact routes. `DOCUMENT-STATUS.md` protects against direct-search stale files. `CURRENT-REVISION.md` binds current surfaces to exact blobs.

This map is intentionally selective. Its job is to decide where to descend, not to eliminate the need to descend.