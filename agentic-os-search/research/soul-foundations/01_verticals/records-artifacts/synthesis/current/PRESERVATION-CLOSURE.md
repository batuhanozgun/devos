# Records — Current Preservation Closure Result

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Integrates:** legacy `MINIMUM-ENVELOPE.md` and `MINIMUM-ENVELOPE-COUNTERCHECK.md`.

## Current bounded result

There is no universal metadata package that every persistent resource must physically carry.

The stronger concept is a purpose-relative **preservation closure**:

> preserve the smallest set of information, relationships, interpretive dependencies, controls and reliable bindings required for a stated future use of a stated resource class under a stated horizon/risk context.

The closure is logical, not necessarily physically embedded in the object.

## What can become required

Depending on the profile, obligations can concern:

- exact identity and binding;
- interpretation / representation knowledge;
- origin, provenance and context;
- version/history/standing reconstruction;
- integrity / continuity assurance;
- relations, aggregation and derivation;
- rights/access/use constraints;
- organisation and retrieval sufficiency;
- transfer/dependency survivability;
- preservation objectives / significant properties under transformation.

These are obligation families, not mandatory fields.

## Where the required information may live

It can be:

- embedded;
- externally linked;
- represented through relations/provenance;
- inherited from controlled aggregate/system context;
- supplied by preserved rules;
- deterministically reconstructable from preserved inputs.

External/inherited/reconstructable satisfaction is valid only while exact binding, correct version, availability, interpretability and required transfer/materialisation remain protected.

## Counter-check corrections retained

- longer horizon does **not** automatically mean more metadata; horizon is only one input alongside risk, security, legal/business constraints and transformation/transfer exposure;
- detailed provenance or a known creator is not a universal minimum;
- identity does not universally require a global PID;
- integrity does not universally require a per-object checksum;
- retrieval is often a system-level closure obligation, not an object-local field requirement;
- preservation closure does not establish factual truth, evidential sufficiency, sound reasoning or correct decisions;
- recursive dependency closure stops relative to an explicit future-use/knowledge baseline, not by preserving everything forever;
- retention/disposition is a separate Records dimension, not silently absorbed into preservation closure.

## Guardrail

The natural question is not `which metadata fields must every record have?` but:

> `For this future use, what would become unknowable or unusable if this dependency disappeared?`

## Audit / evidence route

Use `../../INDEX.md` for the exact L4A adversarial/history route, L4B source-ledger route and L5 primary-source route for this topic.