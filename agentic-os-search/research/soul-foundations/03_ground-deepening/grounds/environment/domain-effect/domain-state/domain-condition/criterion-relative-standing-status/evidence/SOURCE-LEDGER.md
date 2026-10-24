# Criterion-Relative Standing — Source / View Ledger

**Status:** BOUNDED PASS SOURCE LEDGER  
**Date:** 2026-09-04

## Exact pre-pass binding

Frozen plan:
`../CRITERION-RELATIVE-STANDING-STATUS-RESEARCH-PLAN.md` @ `4aba6a1bc268a3b372a76c460d3cd978f3171765`.

The plan preserves exact root/parent/sibling SHAs used before substantive research. Do not replace those historical bindings with post-pass current surfaces.

## Source-handling rule

External sources are challenge/discrimination evidence, not taxonomy authorities.

Do not equate:
- a domain's `status` vocabulary with the project node label;
- a criterion/requirement with the standing relative to it;
- an assessment result with true standing by identity;
- a certificate/report/API field with standing by identity;
- authority with the institutional standing produced or recognized under that authority;
- source agreement with independent validation of the project hierarchy.

## External source ledger

### E01 — ISO/IEC 17007:2026 — conformity assessment vocabulary/principles

- URL: `https://www.iso.org/standard/89832.html`
- Source: ISO/IEC 17007:2026, published February 2026.
- Use: conformity assessment concerns demonstration that specified requirements are fulfilled; normative documents may include standards and regulations.
- Discriminates: F3, F4, F12, F16, F17.

### E02 — ISO/IEC 17020:2026 — inspection bodies

- URL: `https://www.iso.org/standard/81725.html`
- Source: ISO/IEC 17020:2026, published March 2026; corrected June 2026.
- Use: inspection examines items/processes/services and determines conformity against requirements from standards, regulations, contracts or internal specifications.
- Discriminates: F4, F6, F12, F14.

### E03 — ISO 19011:2026 — auditing management systems

- URL: `https://www.iso.org/obp/ui/#iso:std:iso:19011:ed-4:v1:en`
- Source: ISO 19011:2026 current Online Browsing Platform vocabulary.
- Load-bearing use:
  - audit evidence is evaluated against audit criteria;
  - findings indicate conformity or nonconformity;
  - where audit criteria are statutory/regulatory requirements, the finding is termed compliance or non-compliance;
  - conformity = fulfilment of a requirement; nonconformity = non-fulfilment.
- Discriminates: F3, F4, F5, F12, F13, F16.
- Interpretation: regulatory provenance changes criterion semantics/label without by itself proving a separate standing child.

### E04 — ISO 9000:2026 — quality-management vocabulary

- URL: `https://www.iso.org/standard/88464.html`
- Source: ISO 9000:2026 current vocabulary surface.
- Use: quality is framed through characteristics and fulfilment of requirements; challenges `quality` as a self-evident separate standing child.
- Discriminates: F6, F12, F16.

### E05 — NIST — Assessment of Conformity, Decision Rules and Risk Analysis

- URL: `https://www.nist.gov/publications/assessment-conformity-decision-rules-and-risk-analysis`
- Source: NIST conformity/measurement decision-rule material.
- Load-bearing use:
  - distinguishes conformance zone (characteristics that actually conform) from acceptance zone (measurement results accepted under a decision rule);
  - measurement uncertainty can create false acceptance or false rejection.
- Discriminates: F11, F12, F14, F15, F16, F17.
- Strong anti-collapse result: true standing/conformity is not identical to an evidence-based acceptance decision.

### E06 — ISO 10576-1:2022 — conformity with specified requirements

- URL: `https://www.iso.org/standard/70018.html`
- Use: conformity checking uses measurement/test results and explicitly addresses measurement uncertainty.
- Discriminates: F11, F14, F15.

### E07 — Kubernetes — Pod Conditions

- URL: `https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-conditions`
- Source: current Kubernetes documentation.
- Use:
  - `Running` does not imply `Ready`;
  - readiness depends on conditions/gates/checkpoints;
  - condition/status fields are operational representation surfaces.
- Discriminates: F3, F4, F8, F14, F19.
- Boundary: API representation is not treated as reality by identity.

### E08 — Kubernetes — Node-pressure eviction / node conditions

- URL: `https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/`
- Use:
  - current signals such as `memory.available` are compared with configured thresholds;
  - threshold satisfaction maps to pressure conditions such as `MemoryPressure`.
- Discriminates: F3, F8, F12, F16, F19.
- Key sibling example:
  `memory.available = x` → Realized Characteristics;
  `MemoryPressure` relative to threshold → Criterion-Relative Standing.

### E09 — NASA-STD-3001 Volume 2 — Crew Interfaces

- URL: `https://www.nasa.gov/reference/10-0-crew-interfaces-vol-2/`
- Current NASA web reference for Volume 2 requirements.
- Use: automation status provision separately includes system state/readiness, future state/mode, system health and configuration information.
- Discriminates: F4, F8, F19.
- Limit: operational separation is a counterframe, not validation of the exact project hierarchy.

### E10 — NIST Asset Condition Management

- URL: `https://www.nist.gov/publications/asset-condition-management-framework-smart-health-ready-manufacturing-systems`
- Use: distinguishes real-time condition awareness, diagnostics and current/future state-of-health assessment.
- Discriminates: F4, F8, F10, F14, F16.

### E11 — California Secretary of State — Business Entity Records / Certificates

- URL: `https://www.sos.ca.gov/business-programs/business-entities/information-requests`
- Use:
  - business-entity data includes current status/standing;
  - a Certificate of Status certifies current status such as active/good standing, suspended, dissolved or cancelled.
- Discriminates: F5, F11, F13, F14, F20.
- Strong boundary: current legal/institutional standing is distinct from the certificate that certifies it.

### E12 — Delaware Division of Corporations — Online Status

- URL: `https://icis.corp.delaware.gov/ecorp/entitysearch/namesearch.aspx`
- Associated Delaware guidance distinguishes online current status from an official Certificate of Good Standing.
- Use: institutional status/certificate anti-collapse.
- Discriminates: F5, F11, F14, F20.

### E13 — Delaware Division of Corporations — standing/compliance status guidance

- URL: `https://corp.delaware.gov/`
- Use: specific non-compliance statuses affect eligibility for a Good Standing Certificate and require corrective actions before return to good standing.
- Discriminates: F5, F12, F13, F20.

### E14 — South Carolina Secretary of State — business entity FAQ

- URL: `https://sos.sc.gov/faqs-about-business-entities`
- Use: Certificate of Existence states that an entity exists and is in good standing.
- Discriminates: F5, F11, F14.

### E15 — Medical Board of California — license status definitions

- URL: `https://www.mbc.ca.gov/License-Verification/License-Status.aspx`
- Use: current/delinquent/canceled/revoked/suspended/probation and related licensing statuses illustrate authority-sensitive institutional standing; status can determine present ability to practice.
- Discriminates: F5, F13, F20.

### E16 — Stanford Encyclopedia of Philosophy — Social Institutions

- URL: `https://plato.stanford.edu/entries/social-institutions/`
- Current entry revised 2025.
- Use: adversarial counterframe for institutions, rules, roles and authority; supports taking rule/authority-dependent institutional facts seriously without treating philosophy as project taxonomy authority.
- Discriminates: F5, F13, F20.
- Weight: conceptual counterframe only.

### E17 — FDIC — Prompt Corrective Action / capital categories

- URL: `https://www.fdic.gov/resources/supervision-and-examinations/examination-policies-manual/section2-1.pdf` and current FDIC supervisory guidance pages.
- Use: banking categories such as well capitalized, adequately capitalized, undercapitalized, significantly undercapitalized and critically undercapitalized are defined relative to regulatory capital thresholds.
- Discriminates: F4, F7, F9, F12.
- PDF note: no PDF text is used as sole load-bearing evidence in the final project finding; web-visible FDIC guidance/snippets were used for discrimination.

### E18 — U.S. EPA — National Coastal Condition Assessment

- URL: `https://www.epa.gov/national-aquatic-resource-surveys/ncca`
- Use: environmental condition is expressed in graded categories such as good/fair/poor for indicators and can be aggregated across sites/regions.
- Discriminates: F7, F9, F21.

### E19 — ISO/IEC 17029:2019 — validation and verification bodies

- URL: `https://www.iso.org/standard/29352.html`
- Standard remains current/confirmed through 2025.
- Use: validation/verification can name conformity-assessment processes over claims/information, providing a counterexample to placing every `valid/verified` label in Domain Condition.
- Discriminates: F6, F10, F14, F21.

### E20 — SEBoK v2.14 — System Capability

- URL: `https://sebokwiki.org/wiki/System_Capability_(glossary)`
- Version: SEBoK v2.14, released 18 May 2026.
- Use: capability = ability to execute action/achieve effect under specified conditions.
- Discriminates: F8.

### E21 — SEBoK v2.14 — Availability

- URL: `https://sebokwiki.org/wiki/Availability_(glossary)`
- Use: availability is probabilistic and may be instantaneous, interval-averaged or asymptotic.
- Discriminates: F8, F19.

### E22 — SEBoK v2.14 — Reliability

- URL: `https://sebokwiki.org/wiki/Reliability_(glossary)`
- Use: reliability is probability of intended function without failure over a specified period under stated conditions.
- Discriminates: F8, F19.

## Cross-source synthesis rule

The strongest cross-source pattern is:

```text
current facts / characteristics
+ applicable criterion / expected function / constitutive regime
+ correct binding / scope
→ possible true current standing
```

while preserving:

```text
true standing
≠ criterion by identity
≠ assessment/acceptance decision by identity
≠ score/report/API field/certificate by identity
≠ authority role by identity
```

No external source independently validates the exact project hierarchy.