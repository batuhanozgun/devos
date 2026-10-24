# Environment — Current Surfaces / Version Binding

**Vertical revision:** `environment-foundation-2026-09-01-r1`  
**Status:** freshness manifest for the bounded result awaiting user evaluation  
**Branch:** `main`

Use these paths as the preferred current surfaces for this revision. If a decision is load-bearing and repository state may have changed, re-fetch the path rather than relying on this manifest alone.

| Role | Path | Blob SHA |
|---|---|---|
| L0 current orientation | `KEY.md` | `bb6a9673f4d09a438f8acee6ad95daa1432da06b` |
| L1 topic router | `FINDINGS-MAP.md` | `923ca23e88cb0f740abde9be76bbe13ba8f2b9ea` |
| L2 integrated synthesis | `synthesis/ENVIRONMENT-VERTICAL-SYNTHESIS.md` | `be4824f2e1ff9d439b11a3dd3c9241b2a5c02467` |
| L4A completeness/audit | `synthesis/COMPLETENESS-OMISSION-CHECK.md` | `94b8ecc848fd9904afc86273ae2beb66d2458325` |
| L4B source ledger | `evidence/SOURCE-LEDGER.md` | `6591a8fe5e08dd2e6c1fbe276b1f61d694b298bd` |
| Environment-local residuals | `OPEN-QUESTIONS.md` | `eac2b1784921501827d312902dae43c5d268dded` |
| Cross-vertical deferrals | `DEFERRED-RELATIONS.md` | `8c8f98b46a5aabc82357235a8c4ec9db53c36b3b` |
| Research frame history | `FRAME-EVOLUTION.md` | `93b74b7647c46e534aa1d372f360d513d48e84bf` |
| Current status/authorization | `STATE.md` | `a5416087baceb066b27642b11b2549b8a70c684d` |
| Retrieval router | `INDEX.md` | `46186975ecd133b4ef2857a7318063cebba6fbf0` |

## Current versus historical

Current result surfaces are the entries above plus current `findings/*.md`.

`ORIENTATION.md` is the initial deliberately weak framing and is historical for result retrieval. Do not promote it over the current synthesis because an old search hit matches a query.

## Freshness rule

A blob SHA proves exact content identity only for that file revision. It does not prove the surrounding repository state is still semantically current.

For fresh-session continuation:
1. start at parent `../../STATE.md`;
2. read this vertical's `STATE.md` / `INDEX.md` as routed;
3. re-fetch any load-bearing current surface when freshness matters;
4. route exact claims through source ledger and primary/authoritative source.