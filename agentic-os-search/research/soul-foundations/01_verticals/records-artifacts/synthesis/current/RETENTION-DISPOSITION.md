# Records — Current Retention / Disposition Result

**Document role:** CURRENT_TOPIC_SYNTHESIS  
**Vertical revision:** `records-foundation-2026-09-01-r2`  
**Integrates:** legacy `RETENTION-DISPOSITION-SEMANTICS.md` and `RETENTION-DISPOSITION-COUNTERCHECK.md`.

## Current bounded result

Correct persistence includes knowing when continued persistence should end or custody should change.

Retention/disposition is not adequately represented by `created_at + retention_years → delete`.

A governed disposition context can require:

- exact record/population scope;
- applicable rule/authority identity, version and scope;
- eligibility trigger / retention-clock start condition;
- duration or other retention/transfer condition;
- hold/freeze/extension/override state;
- intended final action;
- actual execution/outcome evidence;
- permitted/required residual identity or history.

## Critical distinctions

Keep separate when relevant:

- appraisal/value ≠ retention duration;
- trigger/due date ≠ execution;
- rule-based eligibility ≠ current permission to execute under holds/constraints;
- transfer/custody change ≠ destruction;
- removal/hide ≠ irreversible destruction;
- primary deletion ≠ complete destruction when in-scope recoverable copies remain;
- source record retention ≠ automatically identical retention for copies/backups/indexes;
- disposition rule identity ≠ timeless constant;
- payload destruction ≠ automatic destruction of every record about the destruction.

## Counter-check corrections retained

Source-domain terms such as `temporary`, `permanent` and `cutoff` are not universal ontology.

The general abstraction is:

> governing disposition outcome + applicability + eligibility trigger/condition + suspension/constraint + execution/outcome.

`Final disposition` is final relative to the governing custody/schedule process, not necessarily the end of all future record existence or use. Transfer can begin another preservation/custody context.

A destruction obligation is scope-bound: all recoverable representations/copies inside the defined destruction scope must meet the terminal outcome unless a separately governed resource or permitted residual history is explicitly excluded.

Residual destruction/disposition evidence is a separate resource with its own appraisal and retention profile; there is no universal perpetual tombstone requirement.

Holds/freeze are independent eligibility constraints, not merely added time and not changes to factual correctness/current standing.

Indefinite/permanent retention can be correct when explicitly justified; `keep everything forever` is rejected only as an accidental default.

## Terminal outcome

Where destruction is required, specify an observable outcome such as:

> in-scope payload is no longer recoverable while only the explicitly allowed residual evidence remains.

How a concrete system proves this is implementation assurance.

## Audit / evidence route

Use `../../INDEX.md` for the exact L4A adversarial/history route, L4B source-ledger route and L5 primary-source route for this topic.