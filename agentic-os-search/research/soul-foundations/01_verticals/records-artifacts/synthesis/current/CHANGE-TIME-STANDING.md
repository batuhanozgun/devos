# Records — Current Change / Time / Standing Result

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Integrates:** legacy `CHANGE-STATUS-TEMPORAL-SEMANTICS.md` and `CHANGE-STATUS-TEMPORAL-COUNTERCHECK.md`.

## Current bounded result

A generic `update`, one universal status and one universal timestamp are not sufficient semantics for changing persistent information.

Different changes can have different effects on identity, standing, history and availability:

- creation / capture;
- revision/version creation;
- representation migration;
- semantic derivation;
- supersession;
- correction;
- retraction / reliance withdrawal;
- access removal;
- transfer/custody change;
- destruction/disposition.

These are working semantic families, not a mandatory enum.

## Standing is multidimensional

When the protected use requires the distinctions, keep separate:

- version/lineage;
- role/context-scoped currentness or designation;
- reliance/editorial standing;
- availability/presence;
- preservation/custody history.

A simple profile can merge dimensions that cannot vary independently for that use. The research does not require several status fields merely because several dimensions exist conceptually.

## Time

The strongest reusable distinction is:

- **effective/applicable time** — when a state/relation/standing applies in the governed domain;
- **system-known/recorded time** — when the managing system learned/recorded/asserted it.

Creation, correction, migration, retraction, destruction and similar dates are normally typed event times rather than universal top-level time axes.

## Current and historical reconstruction

Preserve enough typed change facts, identity/lineage relations, standing assertions, temporal semantics and provenance bindings to reconstruct the views required by the profile.

That does not require event sourcing, temporal tables, append-only storage or preservation of every intermediate state.

## Counter-check corrections retained

- the status dimensions are conditional semantic questions, not mandatory stored fields;
- source-domain labels such as publishing correction/retraction terms must not be universalized beyond their semantic effect;
- `current/latest` can be role-, branch-, context- or effective-interval scoped and is not universally `max(timestamp)`;
- timestamp ordering can still be sufficient in a domain that explicitly defines currentness that way;
- snapshots can be sufficient where transition meaning is irrelevant;
- event history can be insufficient where event semantics, binding, effective time or currentness rules are missing;
- `invalidation` is source-namespace sensitive and must not be silently equated with scholarly retraction;
- future scheduled standing is a legitimate effective-time case.

## Terminology guardrail

The earlier phrases `current truth` and `historical truth` are retired.

Records can preserve current/historical **standing, state and what the system knew/recorded**. Correct preservation does not establish whether an underlying proposition is factually true.

## Audit / evidence route

Use `../../INDEX.md` for the exact L4A adversarial/history route, L4B source-ledger route and L5 primary-source route for this topic.