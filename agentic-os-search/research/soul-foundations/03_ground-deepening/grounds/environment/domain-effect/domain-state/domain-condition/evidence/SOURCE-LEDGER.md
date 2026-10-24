# Domain Condition — Source / View Ledger

**Status:** BOUNDED PASS SOURCE LEDGER  
**Date:** 2026-09-03

## Exact pre-pass canonical binding

| Role | Path | Bound Git blob SHA |
|---|---|---|
| Parent state | `../../STATE.md` | `8265fa962e8e1f2bbe9499a41f67caf845b0d91d` |
| Parent current surfaces | `../../CURRENT-SURFACES.md` | `8ece496f1602ab8505390c07d131a9d2aa6f0558` |
| Parent key | `../../KEY.md` | `159d121ec2fcef865043e0cfb165af385874155e` |
| Frozen Condition plan | `../../DOMAIN-CONDITION-RESEARCH-PLAN.md` | `17708a8592c7e3607846a71bc6f8174955d3fd5d` |
| Accepted Structure freshness | `../../domain-structure/CURRENT-SURFACES.md` | `8bd8d0b1e7e26f10d007d4e2c3702f0787d25619` |
| Parent Condition finding | `../../findings/04-condition-status-child.md` | `faddd2e642d92f980d92792c75d25c8e85826b27` |
| Parent cross-cut finding | `../../findings/05-identity-constraints-granularity-crosscut.md` | `22bbfeaab395ff4b14d013de66ccd48a7334e75e` |
| Parent reality/representation finding | `../../findings/06-actual-vs-represented-state-boundary.md` | `196c6499091fe26117f51df873434f876e3b7dd5` |
| Parent holdouts | `../../findings/07-cross-domain-holdouts.md` | `5f074cbb4cd62c6ea7a52eec4c176d571c8f6dca` |
| Historical parent synthesis | `../../synthesis/DOMAIN-STATE-SYNTHESIS.md` | `2fb261ec3a4522f8482421674d4c12e9c584eb9b` |
| Parent open questions | `../../OPEN-QUESTIONS.md` | `554a54fb344348b1bfb32502cd165f754c14235f` |
| Parent deferred relations | `../../DEFERRED-RELATIONS.md` | `6b331ef678a46fb9aaeb20a0d9cab68073d4143e` |

These SHAs preserve the exact parent view that existed when the Condition pass began. Later current-facing continuity updates must not be substituted retroactively into this pre-pass binding.

## Source-handling rule

External sources were used as **challenge/discrimination evidence**, not taxonomy authorities.

Do not treat:
- vocabulary overlap as hierarchy validation;
- reported/measured/estimated status as actual Condition by identity;
- normative thresholds/specifications as realized Condition by identity;
- search/retrieval absence as proof of conceptual absence;
- same-model audit as independent verification.

## External source ledger

### E01 — SEBoK State glossary

- Source: Systems Engineering Body of Knowledge, v2.14, released 18 May 2026.
- URL: `https://sebokwiki.org/wiki/State_(glossary)`
- Source type: current professional body-of-knowledge glossary.
- Load-bearing use: presents two distinct state usages — values of qualities/properties at a time, and current/future potential or health.
- Discriminates: F1, F2, F16.
- Limit: vocabulary convergence does not prove the project split.

### E02 — SEBoK Operational Mode glossary / logical architecture discussion

- URLs:
  - `https://sebokwiki.org/wiki/Operational_Mode_(glossary)`
  - `https://sebokwiki.org/wiki/Logical_Architecture`
- Version: SEBoK v2.14.
- Use: mode is a current operational situation/configuration characterized by active functions; transitions between modes are modeled separately.
- Discriminates: F3, F8.

### E03 — NASA-STD-3001 Volume 2 current web reference

- Source: NASA, `10.0 Crew Interfaces` current web reference.
- URL: `https://www.nasa.gov/reference/10-0-crew-interfaces-vol-2/`
- Use: automation status provision separately requires system state, future state/mode, system health and configuration information. This operational separation challenges a one-dimensional Condition leaf without dictating project labels.
- Discriminates: F2, F3, F4, F8, F16.

### E04 — NASA Hardware and Equipment current web reference

- Source: NASA, `9.0 Hardware and Equipment`.
- URL: `https://www.nasa.gov/reference/9-0-hardware-and-equipment-vol-2/`
- Use: condition monitoring drives maintenance triggers; required maintenance information includes functional-state data such as power, temperature, pressure and standby.
- Discriminates: F2, F3, F7.

### E05 — NIST Asset Condition Management

- Source: NIST publication page, Diaz-Elsayed et al., 2020.
- URL: `https://www.nist.gov/publications/asset-condition-management-framework-smart-health-ready-manufacturing-systems`
- Use: ACM combines real-time condition awareness, diagnostics and current/future state-of-health assessment. Supports separation between underlying condition information and health assessment/standing, while warning that health is often inferred/aggregated.
- Discriminates: F2, F4, F5, F7, F11.
- PDF note: the associated NIST paper was separately inspected with PDF screenshots during the pass; its use does not change the source's publication date.

### E06 — ISO 29821:2026 machine condition monitoring

- Source: ISO 29821:2026, Edition 2, published April 2026.
- URL: `https://www.iso.org/standard/88266.html`
- Use: explicitly separates ultrasonic inspection/measurement/monitoring from severity assessment criteria, interpretation and reporting.
- Discriminates: F2, F4, F11.

### E07 — ISO 13379-1:2025 condition monitoring and diagnostics

- Source: ISO 13379-1:2025, current standard; accessible official/standards-body summaries.
- Reference URL: `https://www.iso.org/` (standard 13379-1:2025); current public summaries state applicability to machine systems whose state can be described by measuring/observing operational parameters and responses.
- Use: condition monitoring/diagnostics are an epistemic/diagnostic process over operational parameters; not all diagnostic or health output is actual condition by identity.
- Discriminates: F4, F11.

### E08 — ISO 9000 quality vocabulary

- Source: ISO Online Browsing Platform, ISO 9000 vocabulary.
- URL: `https://www.iso.org/obp/ui?_escaped_fragment_=iso%3Astd%3Aiso%3A9000%3Aed-5%3Av1%3Aen`
- Use: `quality` is defined through the degree to which inherent characteristics fulfil requirements. This is discriminating evidence that criterion-relative evaluation is semantically different from bare characteristics/values.
- Discriminates: F2, F4, F9.

### E09 — Kubernetes Pod Conditions

- Source: Kubernetes current documentation, 2026.
- URL: `https://kubernetes.io/docs/concepts/workloads/pods/pod-condition/`
- Use: a Pod can be `Running` while not `Ready`; conditions track multiple independent aspects/checkpoints. The status structure carries probe/transition timestamps and observed generation.
- Discriminates: F2, F3, F11.
- Limit: Kubernetes API `status` is a representation surface and is not treated as actual reality by identity.

### E10 — Kubernetes Controllers / Kubelet Sync Loop

- URLs:
  - `https://kubernetes.io/docs/concepts/architecture/controller/`
  - `https://kubernetes.io/docs/reference/node/kubelet-sync-loop/`
- Use: desired versus current state are separated; kubelet periodically reconciles against actual running-container state and API status can lag instant node reality.
- Discriminates: F11 and actual-versus-represented boundary.

### E11 — EPA Ecological Condition

- Source: U.S. EPA Report on the Environment, last updated 22 July 2026.
- URL: `https://www.epa.gov/report-environment/ecological-condition`
- Use: ecological `condition` is a deliberately broad domain term covering physical/chemical/biological characteristics plus processes/interactions. It acts as a counterframe: project research must preserve Structure/Dynamics boundaries rather than copying an external umbrella taxonomy.
- Discriminates: F12, F13, F14.

### E12 — SEC market-structure / market-quality material

- Sources:
  - `https://www.sec.gov/featured-topics/market-structure-analytics/research-analysis-market-structure`
  - `https://www.sec.gov/data-research/market-structure-data`
- Use: SEC research distinguishes market structure questions and uses metrics such as spreads, depth, volatility and turnover to characterize market quality/conditions. Provides a non-maintenance holdout for descriptive market characteristics versus evaluative quality standing.
- Discriminates: F2, F12, F14.

### E13 — South Carolina Secretary of State business-entity FAQ

- Source: South Carolina Secretary of State.
- URL: `https://sos.sc.gov/faqs-about-business-entities`
- Use: Certificate of Existence is described as stating that an entity exists and is in good standing. Supports rule/authority-relative institutional standing as a genuine domain-role concept while preserving the certificate/standing distinction.
- Discriminates: F2, F10, F11, F12.

### E14 — Stanford Encyclopedia: Intrinsic vs. Extrinsic Properties

- Source: Stanford Encyclopedia of Philosophy, `Intrinsic vs. Extrinsic Properties` (archived 2023 edition; substantive treatment notes multiple competing notions).
- URL: `https://plato.stanford.edu/archives/sum2023/entries/intrinsic-extrinsic/`
- Use: challenges intrinsic/extrinsic or relational/non-relational as a clean universal project decomposition; the intuitive distinction conflates multiple related distinctions.
- Discriminates: F6.
- Limit: philosophy counterframe, not project taxonomy authority.

### E15 — SEBoK capability / availability / reliability

- URLs:
  - `https://sebokwiki.org/wiki/System_Capability_(glossary)`
  - `https://sebokwiki.org/wiki/Availability_(glossary)`
  - `https://sebokwiki.org/wiki/Reliability_(glossary)`
- Version: SEBoK v2.14.
- Use:
  - capability is ability to execute action/achieve effect under specified conditions;
  - availability is probabilistic and may be instantaneous, interval-averaged or asymptotic;
  - reliability is probability of performing a function without failure over a specified period under stated conditions.
- Discriminates: F7 and the current-Condition versus Dynamics/model boundary.

### E16 — Microsoft Azure Well-Architected health modeling (supporting operational counterframe)

- URL: `https://learn.microsoft.com/en-us/azure/well-architected/design-guides/health-modeling`
- Use: explicitly describes health modeling as interpreting monitoring data plus business/domain context into health states, and health states as derived from health signals.
- Discriminates: F4, F5, F11.
- Weight: supporting industry practice, lower authority than NIST/ISO for the project finding.

## Cross-source synthesis rule

The bounded result depends on convergence **across materially different source lineages and holdouts**, not on any one source using the same words as the project.

The strongest source-level pattern is:

```text
current characteristics / operational facts
+ relevant criterion / rule / expected function
→ possible criterion-relative standing
```

while preserving:

```text
actual facts / actual standing
≠ measurement / model / report / status field / certificate by identity
```

No external source independently validates the exact project hierarchy.
