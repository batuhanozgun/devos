# Source Ledger — Records Vertical Completeness / Omission Review

**Pass:** vertical completeness / omission review  
**Access date:** 2026-09-01  
**Status:** source ledger; not synthesis

## Purpose

Test whether major Records problem classes remain missing after the foundational/object/preservation/change/retrieval/profile/mechanism/retention passes.

This ledger focuses on omission candidates rather than re-documenting all prior source corpora.

---

## 1. Retention/appraisal/disposition — confirmed first-order omission

Primary source trail:
- `retention-disposition.md`
- NARA scheduling/appraisal/disposition guidance
- NAA compliant destruction and freeze/retention guidance
- ISO/TR 21946 appraisal

Finding:
- appraisal, retention triggers, disposition class/outcome, holds, execution and residual history form a distinct Records semantic dimension not reducible to preservation or deletion mechanisms.

Action:
- dedicated focused pass completed.

---

## 2. Durability / replication / disaster recovery

### Library of Congress — Use of Approved Inventory Systems

Source:
- https://www.loc.gov/programs/digital-collections-management/inventory-and-custody/use-of-approved-inventory-systems/

Observed:
- enduring access to permanent digital collections is supported through multiple managed copies;
- current practice creates at least four copies across at least two independent systems/geographic locations;
- copies support recovery/repair and fixity checking.

### Library of Congress — Data Integrity Management

Source:
- https://www.loc.gov/programs/digital-collections-management/inventory-and-custody/data-integrity-management/

Observed:
- bit-level preservation uses fixity values and recurring integrity reviews;
- integrity check logs are themselves auditable records retained with the collection context.

### ISO 16363:2025

Source:
- https://www.iso.org/standard/87472.html

Observed:
- current international standard defines audit/certification for trustworthiness of digital repositories across the full range of repositories.

Research classification:
- replication, backup, geographic diversity, fixity monitoring, recovery and repository certification are **assurance/control mechanisms** satisfying previously established Records obligations such as durability, integrity, availability/recoverability and preservation closure;
- they do not introduce a new independent resource/record semantic category;
- exact redundancy/RTO/RPO/consistency designs remain profile/implementation specific.

Conclusion:
- no separate first-principles Records semantics pass required now; carry as implementation assurance/mechanism verification.

---

## 3. Confidentiality / security / encryption-key survivability

### Library of Congress — Digital Collections Security

Source:
- https://www.loc.gov/programs/digital-collections-management/inventory-and-custody/digital-collections-security/

Observed:
- collection security controls/monitors/audits access and protects against unauthorized access, change, deletion or removal;
- collection-content security is distinguished from broader enterprise IT infrastructure responsibilities.

### NIST SP 800-57 Part 1 — Key Management

Source:
- NIST key-management recommendation/publication family

Observed:
- cryptographic information/keying material may need availability for as long as protected data must be recoverable;
- backup/archive of relevant keying material may be required;
- loss/obsolescence of keying material/software can make protected information unavailable.

Research classification:
- confidentiality/access constraints are already a Records-side obligation family from minimum preservation closure;
- encryption/key lifecycle is one mechanism by which confidentiality and later recoverability/interpretability are satisfied or broken;
- privacy/security can also activate retention/disposition requirements, but this is captured by Requirement Profile external constraints/risk and the retention pass.

Conclusion:
- no separate foundational Records semantic dimension; later security architecture/assurance is cross-cutting implementation work.

---

## 4. Distributed consistency / divergent replicas / multi-writer concurrency

Evidence base:
- prior change/status/temporal pass;
- mechanism-pattern pass (MVCC, temporal stores, Git branching/refs, derived projections);
- failure inventory: replica illusion, stale view, duplicate source of truth, identity/currentness drift.

Research classification:
- distributed inconsistency can create materially different visible states, but the semantic questions are already represented by:
  - exact resource/version binding;
  - system-known state/time;
  - role-scoped currentness/designation;
  - branching/version lineage;
  - freshness/as-of semantics;
  - requirement-profile acceptance/assurance.
- consensus/conflict-resolution protocol is a mechanism/Work/authority issue, not a new Records primitive.

Conclusion:
- implementation-assurance refinement, not separate first-order Records pass.

---

## 5. Integrity / authenticity / reliability assurance depth

Evidence base:
- foundational InterPARES/ISO/PREMIS/OAIS sources;
- LOC fixity management;
- ISO 16363:2025 repository trustworthiness standard.

Research classification:
- semantic distinctions (fixity/integrity ≠ authenticity ≠ reliability ≠ factual correctness) are already established;
- remaining issue is how much evidence/control is required for a particular profile and whether a repository/control implementation is trustworthy.

Conclusion:
- assurance-calibration / verification problem, not missing first-order semantic dimension.

---

## 6. Neutral umbrella category around `record`

Evidence base:
- object-boundaries pass and artifact counter-check.

Candidates remain:
- persistent information resource;
- information object;
- information content entity;
- information artifact (qualified);
- domain-specific alternatives.

Research classification:
- unresolved nomenclature/upper-ontology choice does not currently alter the load-bearing distinctions among resource, record role/status, version, representation, derivation and aggregation;
- forcing a name now would be premature.

Conclusion:
- conceptual refinement; keep package naming provisional but do not block vertical completion.

---

## 7. Identity / significant-property thresholds under transformation

Evidence base:
- object-boundaries pass;
- minimum preservation closure (Preservation Objectives/significant properties);
- change/status pass (migration vs revision vs derivation);
- requirement-profile scenario tests.

Research classification:
- no universal file-operation threshold exists;
- the defensible rule is profile/domain relative: transformation identity depends on which protected significant properties/functions/relations remain invariant and whether a new assertion/derivation needs independent identity/provenance.

Remaining work:
- a concrete domain/profile must define and verify its threshold.

Conclusion:
- known context-specific decision problem, not missing universal foundational dimension.

---

## 8. Trustworthy repository / audit / certification

Source:
- ISO 16363:2025 — audit and certification of trustworthy digital repositories.

Research classification:
- certification/audit tests the reliability of an implementation/organisation against repository requirements;
- Records research already separates producer self-report from independent verification through project agent-control and requirement acceptance tests.

Conclusion:
- verification/assurance layer; not new Records object semantics.

---

## 9. Truth / knowledge / evidence

Evidence base:
- foundational pass: authenticity/integrity do not prove factual truth;
- deferred-relations file: evidence is relational to a claim/question/decision;
- change pass retired `current truth` terminology.

Research classification:
- factual truth, evidential sufficiency and reasoning correctness cannot be solved by persistence/record semantics alone;
- treating them as Records properties would reintroduce the `memory umbrella` failure.

Conclusion:
- explicitly outside Records; candidate for later cross-vertical evidence/reasoning synthesis.

---

## 10. Physical / non-digital records

Evidence base:
- ISO 15489 is medium/technology independent;
- recordhood/object-boundary sources cover physical/digital instantiations and materiality;
- RiC separates Record Resource and Instantiation.

Research classification:
- physical carriers can change preservation/significant-property/control mechanisms, but the current semantic model already distinguishes resource/content identity, representation/instantiation, materiality-sensitive identity, provenance, retention and access.

Conclusion:
- no separate foundational pass required for current SOUL purpose; concrete physical-record systems would need profile-specific mechanisms.

---

## 11. Scale / cost / performance

Evidence:
- NARA disposal benefits include storage economy and searchability;
- mechanism patterns have different performance/complexity characteristics.

Research classification:
- cost/scale can change feasible controls and appraisal trade-offs, but do not by themselves introduce new Records semantics;
- if a performance limit makes a required retrieval/retention capability impossible, that is an implementation feasibility issue evaluated against the profile.

Conclusion:
- architecture/operations trade-off, not foundational Records dimension.

---

# Omission-review result

Only **retention/appraisal/disposition** exposed a clear missing first-order semantic dimension and therefore received a dedicated focused pass.

The other candidates currently classify as:

- **refinement:** neutral umbrella; identity/significant-property threshold;
- **implementation assurance:** replication/DR/consistency, security/key lifecycle, integrity/trustworthy repository, scale/performance;
- **cross-vertical/outside Records:** authority/workflow, truth/evidence/reasoning;
- **profile-specific mechanism variation:** physical/non-digital carriers.

This classification remains falsifiable if later Work/Actors research exposes a contradiction.