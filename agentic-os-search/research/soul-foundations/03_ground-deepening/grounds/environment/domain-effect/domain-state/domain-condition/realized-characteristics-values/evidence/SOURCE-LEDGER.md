# Realized Characteristics — Source / View Ledger

**Status:** BOUNDED PASS SOURCE LEDGER  
**Date:** 2026-09-04

## Exact pre-pass binding

Frozen plan:
`../REALIZED-CHARACTERISTICS-VALUES-RESEARCH-PLAN.md` @ `71d6c9d10d3984bf2c8abf9d8b2d60dddfae6837`.

The plan preserves the exact parent/root SHAs used before substantive search. Do not replace those historical bindings with post-pass current surfaces.

## Source-handling rule

External sources are challenge/discrimination evidence, not taxonomy authorities.

Do not equate:
- property vocabulary with project hierarchy;
- measured/estimated/modelled result with actual characteristic by identity;
- data shape with semantic child structure;
- specified capability/criterion with realized current condition;
- source agreement with independent validation of the project decomposition.

## External source ledger

### E01 — BIPM/JCGM VIM 1.1 Quantity

- URL: `https://jcgm.bipm.org/vim/en/1.1.html`
- Source: International Vocabulary of Metrology (VIM3).
- Use: a quantity is a property with magnitude expressible as number plus reference; vector/tensor quantities are also covered.
- Discriminates: F4, F10.

### E02 — BIPM/JCGM VIM 1.19 Quantity value

- URL: `https://jcgm.bipm.org/vim/en/1.19.html`
- Use: quantity value is number + reference expressing magnitude; multiple presentations and vector/tensor components are possible.
- Discriminates: F1, F2, F10.
- Limit: this vocabulary concerns metrological expression; it does not imply that a stored number is the actual characteristic by identity.

### E03 — BIPM/JCGM VIM 1.30 Nominal property

- URL: `https://jcgm.bipm.org/vim/en/1.30.html`
- Use: properties without magnitude can still have values expressed in words/codes/other means; quantitative versus nominal is therefore a legitimate property-form distinction without automatically creating separate recovery programs.
- Discriminates: F4, F10.

### E04 — BIPM/JCGM VIM 2.3 Measurand

- URL: `https://jcgm.bipm.org/vim/en/2.3.html`
- Use: measurand is the quantity intended to be measured; measurement can perturb the phenomenon so the measured quantity may differ from the intended measurand.
- Discriminates: F15.

### E05 — BIPM/JCGM VIM 2.9 / 2.10 / 2.11 Measurement result, measured value, true value

- URLs:
  - `https://jcgm.bipm.org/vim/en/2.9.html`
  - `https://jcgm.bipm.org/vim/en/2.10.html`
  - `https://jcgm.bipm.org/vim/en/2.11.html`
- Use: measurement result attributes values to a measurand and includes relevant information/uncertainty; measured values are estimates; VIM also distinguishes the theoretical notion of true quantity value.
- Discriminates: F2, F15, F16.

### E06 — W3C/OGC Semantic Sensor Network Ontology — 2023 Edition

- URL: `https://www.w3.org/TR/vocab-ssn-2023/`
- Status encountered: 2025 W3C/OGC publication surface for the 2023 Edition.
- Use:
  - Property = identifiable quality of a Feature of Interest that can be observed/acted upon;
  - Observation = act that estimates/calculates a value of a property;
  - observation result is an information item and may be number, quantity, category, image, vector, array, geometry, etc.;
  - observed property spans quantitative, categorical/nominal and complex/structured forms;
  - proxy samples can mediate access to an ultimate feature of interest.
- Discriminates: F4, F9, F10, F15, F16.

### E07 — SEBoK State glossary v2.14

- URL: `https://sebokwiki.org/wiki/State_(glossary)`
- Version: SEBoK 2.14, released 18 May 2026.
- Use: one state definition is values of key qualities/properties at a time; separately, state can be used for current/future potential/health.
- Discriminates: F1, F3, F18, F20.

### E08 — SEBoK Attribute glossary v2.14

- URL: `https://sebokwiki.org/wiki/Attribute_(glossary)`
- Use: attribute is an inherent property/characteristic distinguishable quantitatively or qualitatively; discussion notes assigned characteristics and multiple standards usages.
- Discriminates: F1, F3, F4, F5.

### E09 — SEBoK Operational Mode glossary v2.14

- URL: `https://sebokwiki.org/wiki/Operational_Mode_(glossary)`
- Use: operational mode is an operational situation/configuration characterized by active functions and is treated as state-like.
- Discriminates: F6, F14.
- Limit: external 'configuration' wording does not override project Structure/Condition boundary; protected question controls routing.

### E10 — SEBoK Emergent Property glossary v2.14

- URL: `https://sebokwiki.org/wiki/Emergent_Property_(glossary)`
- Use: system-level property meaningful at higher organizational level. Shows whole/emergent characteristics can be real without forcing a separate universal child; bearer/scope can change.
- Discriminates: F8.

### E11 — SEBoK System Capability / Availability / Reliability v2.14

- URLs:
  - `https://sebokwiki.org/wiki/System_Capability_(glossary)`
  - `https://sebokwiki.org/wiki/Availability_(glossary)`
  - `https://sebokwiki.org/wiki/Reliability_(glossary)`
- Use:
  - capability = ability under specified conditions;
  - availability = probability operational at a point/time and can be instantaneous/averaged/asymptotic;
  - reliability = probability of function without failure over a specified period under stated conditions.
- Discriminates: F11 and current-condition versus disposition/time-model boundary.

### E12 — IUPAC Gold Book 2025 — kind-of-property

- URL: `https://goldbook.iupac.org/terms/view/K03392/plain`
- Use: kind-of-property includes qualitatively distinguishable attributes and kinds of quantity; examples include nominal, ordinal and quantitative values.
- Discriminates: F4.

### E13 — IUPAC Gold Book 2025 — intensive / extensive quantity

- URLs:
  - `https://goldbook.iupac.org/terms/view/I03074/plain`
  - `https://goldbook.iupac.org/terms/view/E02281/plain`
- Use: intensive and extensive are real physical quantity distinctions, but they are domain/form-specific and do not recur as a universal first-order recovery split.
- Discriminates: F7.

### E14 — Stanford Encyclopedia — Intrinsic vs Extrinsic Properties

- URL: `https://plato.stanford.edu/archives/sum2023/entries/intrinsic-extrinsic/`
- Use: the intuitive intrinsic/extrinsic distinction conflates several related distinctions and is resistant to a single clean analysis; relational/non-relational is not identical to intrinsic/extrinsic.
- Discriminates: F5.
- Weight: philosophy counterframe, not project taxonomy authority.

### E15 — OGC GeoSPARQL 1.1

- URL: `https://docs.ogc.org/is/22-047r1/22-047r1.html`
- Use: distinguishes topological spatial relation families from quantitative spatial computations/functions such as distance, and binds quantitative geometry values to reference systems/units.
- Discriminates: F10, F12, F15.

### E16 — NASA Hardware and Equipment / NASA-STD-3001 Volume 2 web reference

- URL: `https://www.nasa.gov/reference/9-0-hardware-and-equipment-vol-2/`
- Current standard context: NASA-STD-3001 Volume 2 Revision F, July 2026.
- Use: maintenance information includes functional-state data such as power, temperature, pressure and standby; condition monitoring triggers later maintenance decisions.
- Discriminates: F6, F17, F18.

### E17 — NIST Asset Condition Management

- URL: `https://www.nist.gov/publications/asset-condition-management-framework-smart-health-ready-manufacturing-systems`
- Use: distinguishes real-time condition awareness from diagnostics and current/future state-of-health assessment.
- Discriminates: F18 and underlying-characteristic versus health-assessment boundary.

### E18 — Kubernetes Node Pressure / Node Status

- URLs:
  - `https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/`
  - `https://kubernetes.io/docs/reference/node/node-status/`
- Use: raw/current signals such as `memory.available` are evaluated against thresholds to produce pressure conditions; API fields are representation surfaces, not reality by identity.
- Discriminates: F15, F17, F18.

### E19 — U.S. EPA Ecological Condition

- URL: `https://www.epa.gov/report-environment/ecological-condition`
- Last updated: 22 July 2026.
- Use: ecological condition spans physical/chemical attributes, biological balance and processes. Acts as a counterframe requiring project Structure/Dynamics boundaries while confirming whole-system and attribute-level condition questions.
- Discriminates: F8, F19.

### E20 — U.S. SEC Market Structure Data

- URL: `https://www.sec.gov/data-research/market-structure-data`
- Current data page includes June 2026 metrics.
- Use: market analysis employs spreads, depth, volatility, turnover and distributions at multiple aggregation levels. Supports market holdout while warning that windowed volatility/distributions may summarize Dynamics rather than be primitive snapshot characteristics.
- Discriminates: F8, F10, F14, F19.

## Cross-source synthesis rule

The strongest cross-source pattern is:

```text
actual bearer/relation/whole
    has or instantiates a materially relevant current characteristic

observation / measurement / model / report
    provides evidence or an attributed/estimated representation of it
```

and:

```text
current characteristic
+ applicable criterion
→ possible criterion-relative standing
```

No external source independently validates the exact project hierarchy.