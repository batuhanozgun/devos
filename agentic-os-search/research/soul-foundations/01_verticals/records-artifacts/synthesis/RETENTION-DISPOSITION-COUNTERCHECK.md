# Records Retention / Appraisal / Disposition — Adversarial Counter-Check

**Status:** adversarial supplement to `RETENTION-DISPOSITION-SEMANTICS.md`  
**Date:** 2026-09-01  
**Scope:** challenge retention/disposition abstractions; not legal advice or independent verification.

## Purpose

The main synthesis treats retention/disposition as a first-order Records semantic dimension. This file tests whether it:

- overfits U.S. federal scheduling terminology;
- reifies a linear lifecycle;
- assumes `permanent/temporary` is a universal ontology;
- overstates destruction across copies/backups;
- retains too much destruction metadata;
- mishandles flexible retention/holds;
- drifts into authority/workflow/security implementation.

---

# C1 — Are `temporary` and `permanent` universal record types?

## Challenge

NARA uses these as legally meaningful final-disposition categories. Other organizations/jurisdictions can use different labels and archival models.

## Revision

Do not promote the terms as universal ontology.

The general Records distinction is:

- **eventual termination/destruction disposition**;
- **continued preservation / custody-transfer disposition**;
- other governed outcomes where a domain defines them.

`temporary` / `permanent` remain source-domain labels and strong counterexamples to `retention duration alone`.

The important anti-collapse rule survives:

> a final preservation/custody outcome is not merely `retention_years = very large`.

---

# C2 — Does disposition imply a single linear lifecycle endpoint?

## Challenge

Records continuum and digital reuse contexts show records can continue to be described/reused after archival transfer. Transfer does not make the resource ontologically `finished`.

## Revision

`Final disposition` is final **relative to the governing custody/schedule process**, not the end of all record existence/use.

Transfer can start a new preservation/custody context with its own management/reuse lifecycle.

Therefore the synthesis should be read as a transition model, not universal `create → use → dispose → end` ontology.

---

# C3 — Is `cutoff` universal terminology?

## Challenge

NARA uses `cutoff` precisely, but other systems may model start conditions differently.

## Revision

Use the general term:

> **eligibility trigger / retention-clock start condition**

`cutoff` is a source-domain implementation/records-management term for that concept.

The semantic distinction — trigger vs elapsed period vs execution — remains load-bearing.

---

# C4 — Must destruction remove every copy everywhere?

## Challenge

NAA cloud guidance says contracts should ensure all copies under retention/disposal requirements are destroyed. NARA backup guidance also shows backups may have distinct record status/disposition rules.

## Revision

The correct rule is scope-bound:

> **Every recoverable representation/copy inside the destruction obligation's defined scope must meet the terminal outcome, unless a separately governed record/representation or required residual history is explicitly excluded.**

Do not infer identical retention policy from byte identity alone.

A separately scheduled backup, archival transfer copy, litigation-hold copy or destruction-control record may have a different obligation.

---

# C5 — Is a surviving index entry a destruction violation?

## Challenge

An index entry may contain only identifier/tombstone metadata, or it may contain enough source text to reconstruct sensitive content.

## Revision

Evaluate derived views by **recoverability and their own record/profile status**, not by name.

After payload destruction:

- a pointer/tombstone may legitimately survive;
- a full-text cache may defeat destruction intent;
- a derived summary may be an independently retained record;
- a search index may need removal/rebuild if it preserves in-scope recoverable content.

The requirement profile must state the intended terminal recoverability outcome.

---

# C6 — Should destruction evidence always be retained?

## Challenge

Destruction metadata can itself contain sensitive identifiers/context and may create indefinite privacy risk.

## Revision

No universal perpetual tombstone rule.

Destruction/disposition evidence is a separate record/resource subject to its own appraisal and retention profile.

A profile can require:

- durable destruction proof;
- minimal anonymous/aggregate proof;
- time-limited proof;
- no residual item-level identity

when justified by applicable accountability/privacy requirements.

---

# C7 — Does a hold/freeze merely add time to retention?

## Challenge

A hold can be indefinite/condition-based and may be applied after the normal eligibility date or before it. Simply extending `retain_until` loses the reason/scope/condition and can be wrong when the hold is lifted.

## Revision

Model hold/freeze as an **independent disposition-eligibility constraint/override** with:

- scope;
- effective state/time;
- source/rationale reference;
- lift/end condition/event when known.

The underlying schedule remains separately identifiable.

---

# C8 — Can flexible retention be represented as min/max dates alone?

## Challenge

Earlier destruction or extended retention may depend on business need, rights/accountability, privacy or other conditions.

## Revision

Min/max dates alone are insufficient when discretionary conditions matter.

A flexible rule may require:

- floor/ceiling if defined;
- eligibility condition;
- excluded high-risk cases;
- decision/rationale record where required;
- governing authority reference.

Who makes the decision remains outside Records.

---

# C9 — Does `eligible` imply permission/authorization?

## Challenge

Even if trigger/period conditions are satisfied, an applicable hold, superseding schedule, authorization requirement or other constraint may block execution.

## Revision

Separate:

- **rule-based due/eligibility**;
- **current execution permissibility/constraint state**;
- **actual execution**.

The Records vertical can preserve these states/facts without defining the Actor who grants permission.

---

# C10 — Is retention schedule identity enough for historical compliance reconstruction?

## Challenge

A rule can be amended, superseded, narrowed, frozen or reappraised. A schedule ID without version/applicability and target binding can be ambiguous.

## Revision

Where historical reconstruction matters, preserve:

- exact authority/rule version;
- applicability/effective scope;
- target population binding;
- supersession/amendment relation;
- actual rule used for execution.

This extends Pass 4's historical-standing logic to policy/rule resources.

---

# C11 — Is `keep everything forever` always bad?

## Challenge

Some archival/preservation contexts explicitly require indefinite/permanent retention and may accept storage/search costs.

## Revision

The claim is not `long retention is bad`.

The bounded rule is:

> **Indefinite/permanent retention must be an explicit justified requirement/outcome, not the accidental default produced by absence of appraisal/disposition.**

For archival profiles, keep-forever can be exactly correct.

---

# C12 — Does this pass solve deletion technology?

## Challenge

Irrecoverable deletion from SSDs, cloud replicas, backups, content-addressed stores or encrypted systems is technically difficult and provider/configuration dependent.

## Revision

This pass specifies **observable terminal semantics** only.

Implementation assurance must later verify whether mechanisms actually satisfy:

- scoped irrecoverability;
- secure deletion;
- replica/backup expiry;
- cryptographic erasure where permitted;
- residual metadata constraints.

No deletion algorithm/provider behavior is selected here.

---

# C13 — Did the pass drift into authority/legal interpretation?

## Check

Source systems contain legal authority rules, but the synthesis only retains Records-side facts:

- governing rule/mandate;
- applicability;
- trigger/condition;
- hold/override;
- execution record.

It does not determine who should approve schedules, issue holds or authorize destruction in SOUL.

**Verdict:** boundary preserved.

---

# Final adversarial verdict

Retention/disposition remains a genuine first-order Records dimension with these constraints:

1. source terms (`temporary`, `permanent`, `cutoff`) are not universal ontology;
2. disposition is a governed transition relative to custody/schedule context, not end of all record existence;
3. trigger, condition, eligibility/permissibility and execution are separate;
4. destruction is scope-bound across recoverable representations, not blind `all copies`;
5. residual disposition evidence has its own profile/retention;
6. holds/freezes are eligibility overrides, not record currentness/truth changes;
7. flexible retention needs explicit conditions beyond dates where material;
8. rule identity/version/applicability matters for historical reconstruction;
9. indefinite retention can be correct when explicitly required;
10. physical deletion assurance and authority/workflow remain outside this semantic pass.

No counterexample requires reopening the pass as an architecture problem. Retention/appraisal/disposition is now sufficiently covered for the current foundational Records purpose.