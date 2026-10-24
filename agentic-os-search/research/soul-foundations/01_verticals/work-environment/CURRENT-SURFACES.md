# Technical Work Environment — CURRENT SURFACES

**Status:** canonical Technical Work Environment local freshness/version binding for the evaluated bounded result  
**Date:** 2026-09-02  
**Branch:** `main`

## Purpose

Use this file to prevent an older intermediate surface, historical orientation or moved evidence path from being mistaken for the preferred current bounded result.

This manifest binds **vertical-local surfaces only**. Parent project authorization and next responsibility are intentionally not SHA-bound here; read `../../STATE.md` and `../../INDEX.md` for those.

If a listed current path's blob differs from the bound SHA, treat this manifest as stale until the affected retrieval chain is rechecked.

## Preferred current conclusion surfaces

| Layer / role | Path | Bound Git blob SHA |
|---|---|---|
| Stable overview | `README.md` | `7655680c9a9dcfd09f01eae28cce0ee37d95c8c4` |
| Vertical state | `STATE.md` | `abe8e66b5090e9b4494834fa6454fa7f9f85505e` |
| Vertical router | `INDEX.md` | `ae82da1749f64fd6562eaf7b767034c21c0bb31e` |
| L0 shortest result | `KEY.md` | `61a74d38d7bfe2ee3c8458041726ce3637d096ac` |
| L1 findings map | `FINDINGS-MAP.md` | `c7175a5c8a4189b6bee0e1da155f13330b399654` |
| L2 integrated synthesis | `synthesis/WORK-ENVIRONMENT-VERTICAL-SYNTHESIS.md` | `39da9399d6328a71904e24fdab7e718dcceb43eb` |
| L3 boundary / identity | `findings/01-boundary-and-identity.md` | `6f9d8ef15650de6b9277ac600801c0182626fdaa` |
| L3 configuration / state / reproducibility | `findings/02-configuration-state-reproducibility.md` | `8a7e1af3b6d1f8e7f4fc14cf7ce1f577c48b0866` |
| L3 capabilities / constraints / interfaces / resources | `findings/03-capabilities-constraints-interfaces-resources.md` | `3e0870da164c33c78a52a145f6bf51280e4fa4b3` |
| L3 composition / sharedness / lifecycle | `findings/04-composition-sharedness-lifecycle.md` | `0340517cc8d377c6251ca4880fef30430311a080` |
| L3 failure / health / observability | `findings/05-failure-health-observability.md` | `822f026217fef5e77390960e20806c8492f45c2c` |
| L3 counterframes / terminology | `findings/06-counterframes-and-terminology.md` | `02e61f283451b646781ff4b080c9c808c08fee2c` |
| L3 purpose / control / portability | `findings/07-purpose-control-portability.md` | `ed986675d4a361fccbbf59fe5a671c05993bd8e4` |
| L3 declared / discovered / dynamic | `findings/08-declared-discovered-dynamic.md` | `d2358705cbbe4f7a52c02d0d8f7fe1133ce4eda1` |
| Environment-local residuals | `OPEN-QUESTIONS.md` | `63d3fec35a3cf48dfbc961c4784cac4c93be07b0` |
| Cross-foundation deferrals | `DEFERRED-RELATIONS.md` | `cf1fdc7b701dfd5bdf3ac97604766a6afe3527da` |

## Audit / completion surface

| Role | Path | Bound Git blob SHA |
|---|---|---|
| Same-model adversarial completion/omission audit | `synthesis/COMPLETENESS-OMISSION-CHECK.md` | `32704b9f6bee000d3f624c1306f3efd0795b30bd` |
| Historical initial orientation | `orientation/RESEARCH-ORIENTATION.md` | `9c3ec805dbaeee9e7a0921053f59cd7c4fa95cbd` |

The completion audit records the research-stop challenge and may contain point-in-time evaluation language; it does not override current `STATE.md`, `KEY.md` or the synthesis. The orientation file is historical research-start context only.

## Evidence trace surfaces

Integrated router:

| Role | Path | Bound Git blob SHA |
|---|---|---|
| Integrated source router | `evidence/SOURCE-LEDGER.md` | `80d5051e7511d50e206a4e91cdf06b9598dbaf01` |

Topic/source ledgers:

| Topic | Path | Bound Git blob SHA |
|---|---|---|
| Orientation / rival frames | `evidence/sources/ORIENTATION-SOURCES.md` | `c0c3495e76e486b64746f56226034db9ae1265b0` |
| Boundary / identity | `evidence/sources/BOUNDARY-IDENTITY-SOURCES.md` | `ebd52a212008a8a579a32830b507931aef5c578d` |
| Configuration / state / reproducibility | `evidence/sources/CONFIGURATION-STATE-SOURCES.md` | `8194028209eb8545415b5f8cb037e03c25643745` |
| Capabilities / constraints / interfaces | `evidence/sources/CAPABILITY-CONSTRAINT-SOURCES.md` | `f25910b3c9ff43ab38497740275d36d33456fecb` |
| Composition / sharedness / lifecycle | `evidence/sources/COMPOSITION-LIFECYCLE-SOURCES.md` | `f7ec36ce8706521193e36af885ec30decb94bda7` |
| Failure / health / observability | `evidence/sources/FAILURE-HEALTH-SOURCES.md` | `7df70e517c78661ff20b5166f52c4285620fa0ed` |
| Counterframes / terminology | `evidence/sources/COUNTERFRAME-TERMINOLOGY-SOURCES.md` | `b53fdd15113d817cce0efc93e9a62cc900013906` |
| Purpose / control / portability | `evidence/sources/PURPOSE-CONTROL-PORTABILITY-SOURCES.md` | `e78e373e13d056739991d63f6aa87efb37889a13` |
| Declared / discovered / dynamic | `evidence/sources/DECLARED-DISCOVERED-DYNAMIC-SOURCES.md` | `225fbafa725ccc2f8be8ccaab15f2c35484f710f` |
| Final omission/falsifier probes | `evidence/sources/OMISSION-PROBE-SOURCES.md` | `9a5777877d7c38e261f6fa30f6c51c36f1985cd6` |

These ledgers are derived evidence-recovery aids, not primary evidence. For exact/load-bearing claims, recover the primary/authoritative source named by the relevant ledger.

## Current-result rule

For the present bounded result, prefer:

`STATE → KEY/FINDINGS-MAP → integrated synthesis → topic finding → audit/source recovery`

The strongest current correction is that an explicit environment profile/manifest is optional, not a prerequisite for environment existence.

The superseded broad operating-world corpus is historical and is not evidence for this Technical Work Environment result.

## Parent authority rule

Current parent purpose, authorization and next responsibility live in:
- `../../STATE.md`
- `../../INDEX.md`

## Update rule

A material edit to any preferred current surface must be followed by:

1. re-fetching the edited path from `main`;
2. replacing its bound blob SHA here;
3. checking `KEY.md`, `FINDINGS-MAP.md`, `INDEX.md` and `STATE.md` for status/routing drift;
4. if a load-bearing conclusion changed, checking the synthesis, relevant finding and source ledger together;
5. if bounded-completion status changed, re-running the completion judgment rather than leaving an old audit verdict in place.
