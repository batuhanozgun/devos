# Records Requirement Profile / Derivation — Adversarial Counter-Check

**Status:** adversarial supplement to `REQUIREMENT-PROFILE-DERIVATION.md`  
**Date:** 2026-09-01  
**Scope:** test the derivation method itself; not independent verification.

## Purpose

The main synthesis proposes recurrent, context-bound requirement appraisal and a dated profile/contract. This counter-check tests whether that method:

- over-relativizes mandatory records requirements;
- lets current business needs erase archival/societal/future-user needs;
- enables `minimum` to become control-cutting by convenience;
- creates profile explosion;
- replaces one scalar risk score with an unbounded risk taxonomy;
- treats a one-time acceptance test as ongoing assurance;
- mishandles historical profile applicability;
- drifts into Work/Actors/governance or architecture.

---

# C1 — Does context derivation erase mandatory baseline floors?

## Challenge

If every obligation is derived only from local protected uses, a team could conclude that metadata, disposition, export or integrity requirements are unnecessary even where law/policy/standard already makes them mandatory.

## Counter-evidence

- NARA Universal ERM Requirements are explicitly baseline requirements / a starting point for agencies.
- NAA Minimum Metadata Set has Core properties required for all records in its governed scope, with Additional/Transfer properties activated by other needs.
- NARA permanent/classified transfer rules impose specific metadata independent of a local product team's preference.

## Revision

A requirement profile must begin with:

> **Applicable inherited baseline / mandate floor**

and then derive:

- applicability;
- additional obligations;
- allowed implementation/satisfaction form;
- stronger depth/assurance where context requires it.

`NOT REQUIRED` is only valid when no applicable baseline/mandate requires the obligation.

## Important boundary

This does not create a universal SOUL baseline. Baselines are scope/jurisdiction/domain dependent and must be supplied as evidence-backed external constraints.

---

# C2 — Does `protected use` overfit current business needs?

## Challenge

Current owners may not know future archival, accountability, public, research or societal uses. A narrow business-use framing could systematically under-preserve.

## Counter-evidence

- ISO/TR 21946 includes business needs, legal requirements and societal expectations in records requirements.
- OAIS explicitly defines a future Designated Community and Preservation Objectives rather than assuming only current producer needs.
- IPELTU asks for potential future uses and potential Designated Community/Knowledge Base.

## Revision

`Protected use/outcome` must include all evidenced stakeholder/use classes in scope:

- current operational/business;
- legal/regulatory/accountability;
- contractual/security/privacy;
- archival/public/societal;
- future reuse when explicitly part of preservation objective.

Do not claim to preserve for **all imaginable future uses**. Unknown future value should be handled through explicit appraisal assumptions, not magical future-proofing.

---

# C3 — Can `minimum` become an excuse to remove controls?

## Challenge

A derivation method optimized for smallest defensible requirements can be gamed by narrowing stated use, understating risk, or treating missing evidence as `not required`.

## Existing safeguards

- `UNKNOWN / NEEDS EVIDENCE` is distinct from `NOT REQUIRED`;
- external baseline floors cannot be waived by local convenience;
- each exclusion requires explicit scope/assumption and absence of protected-use/mandate dependency;
- requirement profile carries residual risk and review triggers.

## Revision

Add a disconfirmation rule:

> For every material `NOT REQUIRED` decision, test at least one credible counter-scenario in which the omitted obligation would become required and confirm that the activating condition is genuinely outside the current profile.

This keeps bounded exclusions falsifiable.

---

# C4 — Does the method create profile explosion?

## Challenge

If every record/version/use combination gets a unique profile, the method becomes unmanageable and itself threatens consistency.

## Test

Requirements can often be inherited by a class/population when:

- protected uses are materially the same;
- identity/change structure is the same;
- risk/constraint/horizon assumptions are the same;
- dependency/transfer environment is the same.

Individual exceptions can be overlaid only where a material discriminator changes.

## Revision

Use the **broadest profile scope that does not hide a requirement-changing discriminator**.

Profile hierarchy/inheritance is therefore admissible as a research concept:

`applicable baseline` → `resource-class/profile` → `bounded exception/overlay`

but this does not prescribe configuration architecture.

---

# C5 — Did rejecting one risk score create an unbounded risk model?

## Challenge

The synthesis lists many consequence dimensions. An exhaustive risk taxonomy could become another checklist.

## Revision

Do not require a universal enumerated risk matrix.

A consequence/risk dimension enters the profile only when:

1. a credible failure mode is identified;
2. the consequence changes requirement necessity/depth/assurance;
3. the distinction is not already captured by an external mandate or another input.

The prior dimensions are **prompts**, not mandatory categories.

---

# C6 — Does `satisfaction mode` permit weak external dependencies?

## Challenge

A profile may mark a requirement `satisfied externally` simply because a registry, schema, team wiki or live system currently exists.

## Prior evidence

The minimum-closure pass already found external/inherited satisfaction safe only with binding, version correctness, survivability and transfer/materialisation conditions.

## Revision

The profile must separate:

- **requirement necessity**;
- **claimed satisfaction mode**;
- **dependency assurance**;
- **verification status**.

`External` is not a quality level. An unverified external dependency remains `not yet verified` or `partially satisfied`.

---

# C7 — Does a one-time acceptance test prove ongoing compliance?

## Challenge

A retrieval index, resolver, format registry or access-control environment may pass today and fail later.

## Evidence

- ISO 15489/21946 support recurrent appraisal;
- OAIS monitors changes in technology and Designated Community/Knowledge Base;
- NAA recommends periodic review of systems and risk gaps;
- IPELTU refines information through lifecycle phases.

## Revision

Distinguish:

- **initial sufficiency test** — evidence profile requirements can be met now;
- **ongoing assurance/review trigger** — conditions that require revalidation or re-appraisal.

The Records profile states the need/trigger and evidence state. Scheduling/executing monitoring is Work/governance.

---

# C8 — How is historical profile applicability reconstructed?

## Challenge

If a profile changes over time, later reviewers need to know which requirements/assumptions applied to a record at a historical time.

## Derivation from prior Pass 4

Effective/applicable time and system-known/recorded time can diverge. Generic overwrite of a profile would destroy historical requirement context.

## Revision

A profile/contract must itself have:

- stable identity/version;
- effective/applicability scope/time where relevant;
- derivation/rationale provenance;
- supersession/revision relation;
- historical recoverability when compliance/reconstruction depends on it.

This does **not** imply a particular temporal storage architecture.

---

# C9 — Are behavioural acceptance tests secretly architecture specifications?

## Challenge

Tests such as `retrieve all responsive records as of T` may indirectly force a specific engine or temporal database.

## Counter-model

The same observable result can be achieved through different mechanisms:

- snapshots;
- version stores;
- event/history logs;
- archival packages;
- indexes plus source validation;
- combinations.

## Revision

Acceptance tests should specify **observable Records capability and permitted uncertainty**, not internal mechanism.

For example:

- good: `Given exact identifier/version, recover the bound representation and its standing as of T within the stated corpus.`
- architecture drift: `Use a bitemporal relational table to answer as-of queries.`

---

# C10 — Does the method absorb Work / Actors / authority?

## Challenge

Inputs such as business needs, legal constraints, risk tolerance, retention policy and profile approval come from owners/actors/processes.

## Boundary

Records requirement derivation can preserve as inputs:

- the stated use/constraint;
- source/mandate;
- applicability;
- rationale;
- approval/decision record if supplied;
- requirement consequence.

It must **not** determine from the Records vertical:

- who has legitimate authority to set/waive a requirement;
- approval workflow;
- who executes monitoring/destruction;
- organizational role model.

Those remain deferred.

---

# C11 — Does the method overfit archival standards?

## Challenge

OAIS/IPELTU can make every resource look like a future archive package needing Designated Community, Preservation Objectives and rich Representation Information.

## Counter-evidence

- ISO 16175 separates operational records-management software requirements from dedicated long-term-preservation requirements.
- NAA uses small Core metadata for all records and scales requirements by value/longevity/other needs.
- scenario S1/S2 remain valid with much smaller preservation closure.

## Revision

OAIS/IPELTU inputs activate when the protected use/horizon actually involves independent long-term interpretation/preservation/transfer. They are not universal operational defaults.

---

# C12 — Does a baseline floor itself become universal and stale?

## Challenge

Inherited standards/policies change. A profile can be correct relative to an obsolete baseline.

## Revision

Baseline source must be:

- explicitly identified;
- version/date bound;
- applicability recorded;
- subject to a review trigger when the governing source changes.

A baseline is evidence, not timeless truth.

---

# Final adversarial verdict

The recurrent requirement-profile method survives with the following constraints:

1. begin with applicable **baseline/mandate floors**, not local preferences alone;
2. include evidenced non-current stakeholder/societal/archival uses, but do not claim all imaginable future use;
3. `NOT REQUIRED` must be bounded, justified and counter-scenario tested;
4. use the broadest profile scope that does not hide requirement-changing discriminators;
5. consequence/risk dimensions are prompts activated by material failure effects, not a universal scorecard;
6. necessity, satisfaction location, dependency assurance and verification state remain separate;
7. one-time acceptance does not replace recurrent appraisal/assurance;
8. profile versions/applicability must themselves be historically recoverable where required;
9. behavioural acceptance tests remain mechanism-neutral;
10. authority/approval/workflow remain outside the Records vertical;
11. OAIS/IPELTU apply strongly to long-term/transfer cases, not as universal operational defaults;
12. inherited baselines are versioned/applicability-bound external evidence, not timeless constants.

No counterexample found requires abandoning the method. The main synthesis should be read with these constraints.