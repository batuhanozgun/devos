# Records — Current Organisation / Retrieval Result

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Integrates:** legacy `ORGANISATION-RETRIEVAL-SEMANTICS.md` and `ORGANISATION-RETRIEVAL-COUNTERCHECK.md`.

## Current bounded result

`Organisation = one canonical hierarchy` and `retrieval = generic search` are both too simple.

At least three organisation functions can diverge:

- context/provenance-preserving organisation;
- descriptive/knowledge organisation;
- access/retrieval organisation.

They may coexist in one structure when their meanings genuinely coincide. The requirement is not separate stores/components; it is to keep semantic roles distinguishable when collapsing them would lose context, coverage or lineage.

## Derived/access views

Derivation, access role, own recordhood, designated source/recordkeeping role and freshness/coverage are separate dimensions.

A summary, index, query output or access collection can be derived from another resource and still become a persistent record/resource in its own right.

The key Records-side requirement is:

> a view/output must not silently stand for a different resource/version/standing or support stronger claims than its binding, coverage, freshness and retrieval behavior justify.

Who may designate a source for a role is outside this vertical.

## Retrieval is claim-relative

Different retrieval needs include:

- exact known-item lookup;
- structured filtering;
- semantic/topical discovery;
- exhaustive/high-recall retrieval;
- current-standing lookup;
- historical/as-of lookup;
- system-known-as-of lookup;
- provenance/derivation traversal;
- aggregate/case/thread reconstruction.

A single search mechanism may support several of these, but the guarantees are not interchangeable.

## Hit / miss discipline

A hit does not by itself establish exact identity, current standing, authority, completeness, factual truth or evidential sufficiency.

A miss can support a strong absence inference when the target domain is bounded, complete, fresh and the matching method is sufficiently sensitive for the claim. A closed exact-ID registry is materially different from open semantic search.

## Staleness

Staleness is not inherently wrong. A historical snapshot can be intentionally stale and correct for an `as-of` query.

Failure occurs when the view's actual freshness/as-of/coverage semantics do not match the claim made from it.

Current-sensitive retrieval also does not require a round-trip to an original physical object. It requires an assurance path to sufficiently current, correctly bound standing information.

## Guardrail

Plural organisation does not imply graph architecture. Typed relations can be represented through many mechanisms.

## Audit / evidence route

Use `../../INDEX.md` for the exact L4A adversarial/history route, L4B source-ledger route and L5 primary-source route for this topic.