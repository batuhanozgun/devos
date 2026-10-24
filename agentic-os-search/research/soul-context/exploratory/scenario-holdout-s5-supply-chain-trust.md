# SOUL Research Holdout S5 — external dependency / supply-chain trust

**Status:** external holdout complete; validation-axis revision proposed
**Date:** 2026-08-30

## Why this holdout was justified

S1–S4 are materially different domains, but they mostly assume work inside one organisation or under a broadly shared objective/command structure.

A remaining frame risk was explicit:

> What changes when a working system depends on external actors, products or services that are outside its direct authority, only partially observable, and potentially unreliable or adversarial?

S5 was therefore opened to test a specific blind spot, not to increase holdout count.

## Sources

Authoritative/current NIST sources inspected 2026-08-30:

- NIST SP 800-161 Rev. 1 update landing page — Cybersecurity Supply Chain Risk Management Practices for Systems and Organizations:
  `https://csrc.nist.gov/pubs/sp/800/161/r1/upd1/final`
- NIST SP 1326 — Cybersecurity Supply Chain Risk Management: Due Diligence Assessment Quick-Start Guide, July 2026:
  `https://csrc.nist.gov/pubs/sp/1326/final`
- NIST release note for SP 1326, July 8 2026:
  `https://www.nist.gov/news-events/news/2026/07/nist-releases-finalized-c-scrm-due-diligence-assessment-quick-start-guide`

These are domain guidance / property evidence. They do not prove any SOUL mechanism or causal effectiveness in agentic systems.

# Properties observed before mapping

1. A system/organisation can depend on products/services supplied by actors outside its direct authority.
2. Visibility into how acquired technology is developed, integrated and deployed can be incomplete.
3. Supply-chain inputs can be malicious, counterfeit, vulnerable or produced under poor practices.
4. Risk can propagate through multiple supply-chain tiers and dependencies not directly controlled by the acquirer.
5. Due diligence is required **before** acquisition decisions and may apply to existing systems/suppliers as conditions change.
6. Supplier assessment can require provenance, resilience, ownership/control/influence, foundational practices and supply-chain-tier information.
7. Limited resources require bounded investigative rigor rather than perfect knowledge of every dependency.
8. The organisation must make decisions under a trust/control asymmetry: it can choose suppliers/controls but cannot directly govern every external actor or upstream process.

# D1–D11 mapping

- acquisition/decision objective and constraints → **D1**
- whether supplier-facing assessment capability is needed → **D2**
- incomplete external information, multi-tier dependency state and freshness → **D3**
- internal acquisition/risk-acceptance authority versus external actors outside authority → **D4**
- provenance, due-diligence evidence, supplier assurance → **D5**
- malicious/vulnerable/counterfeit dependency hazards and resilience → **D6**
- lessons / supplier-control evolution → **D7** where durable system change is relevant
- reconstructable assessment/decision trace → **D8**
- what is inside SOUL/task system versus external supplier/environment → **D9**
- whether more due diligence or another supplier/action is the correct next work → **D10**
- ongoing supplier/dependency lifecycle and reassessment after changing conditions → **D11**

# Does S5 force D12?

**Not yet.**

A tempting dimension would be `trust / external dependency / counterparty management`.

That would duplicate several already-distinct protected properties:

- information/visibility → D3,
- authority/control boundary → D4/D9,
- evidence/provenance/assurance → D5,
- hazard/resilience → D6,
- work selection and reassessment → D10/D11.

The problem is real, but its effect is primarily to **change the conditions under which multiple dimensions must be validated**, not to create one new runtime/property bucket.

# V1–V3 insufficiency test

## Why V1 is insufficient

V1 asks whether the map survives materially different domains. But two tasks in the **same domain** can differ materially in whether critical dependencies are trusted/internal versus external/adversarial.

Domain diversity does not guarantee trust-boundary diversity.

## Why V2 is insufficient

V2 scales rigor with risk/materiality/uncertainty/value of information.

High risk does not capture the structural problem that the relevant actor/artifact is **outside system authority** and may have different incentives or malicious behaviour.

## Why V3 is insufficient

V3 protects source/view fidelity and omission awareness.

A perfectly faithful representation of supplier-provided information can still be deceptive, incomplete by construction or unable to reveal upstream dependencies. Source fidelity is not counterparty trustworthiness.

# Proposed V4

## V4 — External dependency / trust / adversarial counterparty exposure

**Validation question:**

> Do the protected properties and research conclusions still hold when critical actors, tools, services, data or artefacts are outside the system's direct authority, only partially observable, and potentially unreliable, strategically misaligned or adversarial?

### V4 should test

- internal authority versus external control limits,
- provenance and assurance under asymmetric information,
- dependency/tier visibility and unknown upstream risk,
- malicious or strategically distorted inputs,
- resilience to supplier/provider failure or change,
- contract/interface assumptions that the system cannot enforce directly,
- whether human owner is silently turned into external-party trust oracle,
- whether task-specific system composition assumes cooperative components.

### V4 is not

- a `security module`,
- a supplier-management architecture,
- a requirement that every task use adversarial controls,
- proof that all external actors are untrusted,
- a replacement for D4, D5, D6 or D9.

It is a cross-cutting challenge condition.

# Negative boundary

A dependency being external does not automatically make it a V4-critical case.

V4 matters when externality changes a material assumption about:

- authority/control,
- trustworthiness,
- observability/provenance,
- resilience,
- incentive/alignment,
- or dependency continuity.

A low-risk public reference source, for example, may still be governed mainly by D3/D5/V3 rather than requiring a full adversarial-counterparty analysis.

# Effect on current taxonomy

Provisional revised set remains **D1–D11**.

Validation axes become provisionally:

- V1 — domain transfer / scenario diversity
- V2 — risk / materiality / proportionality / value of information
- V3 — source/view fidelity / omission awareness
- **V4 — external dependency / trust / adversarial counterparty exposure**

# What S5 establishes

- the four previous holdouts did share a cooperative/internal-control bias;
- external dependency/trust asymmetry is materially different from domain diversity, risk scaling and source/view fidelity;
- D1–D11 can still represent the protected properties without a new dimension after explicit mapping;
- the validation-axis set required revision: V1–V3 was insufficient.

# What S5 does NOT prove

- V4 completeness,
- need for a dedicated security/trust subsystem,
- that every external actor is adversarial,
- a supplier/market/negotiation architecture,
- that NIST C-SCRM mechanisms should be copied into SOUL,
- that D1–D11 are complete.

# Next implication

S5 changed the validation framework, so indiscriminate additional holdouts are not justified now.

The next higher-value work is consolidation:

1. update `research-dimension-map.md` to D1–D11 + V1–V4;
2. update `prearchitecture-research-scope.md` for revised D6 and split D10/D11;
3. derive bounded research packages per dimension;
4. use V1–V4 as challenge axes against each package rather than continually adding domains by count.
