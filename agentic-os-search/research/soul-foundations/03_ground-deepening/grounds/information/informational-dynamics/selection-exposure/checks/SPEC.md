# Selection / Exposure — Pre-execution check specification

**Date:** 2026-09-14. Written after targeted primary reading, before first test execution.
**Scope:** seven finite researcher-designed cases; local standard-library calculations and JSON file round-trips only. No remote service, LLM or real concurrency.

## Cases and fixed expected outcomes

| ID | Construction and expected outcome |
|---|---|
| E01 | Source universe {a,b,c}, index {a,b}, target c. Indexed search is empty although c exists; full exact search returns c. A full exact search for z is empty and z is absent. Neither every miss nor no miss can justify absence universally. |
| E02 | Three relevant items: a/b cover test, c covers risk. Scores 0.90/0.85/0.60; a-b similarity 0.95, other pair similarities 0.10. Two-item relevance ranking returns a,b and misses risk although item precision is 1. The P2 MMR rule at weight 1/2, starting with a, returns a,c. This is invented finite arithmetic, not source experimental replication or a general guarantee for MMR. |
| E03 | Items a and c cost one unit each and jointly cover test/risk. Budget 1 admits no sufficient subset; budget 2 has exactly {a,c}. If c is forbidden to the recipient, budget 2 still has no eligible sufficient subset. Best available is not automatically adequate; access constraints are not bypassed. |
| E04 | v1='mode=SAFE; allow=NO', v2='NOTE; mode=SAFE; allow=NO'. Selector [5,9) yields SAFE on v1 and ' mod' on v2. A version-bound lookup recovers SAFE. A quote 'SAFE' in 'SAFE|SAFE' has two matches, not a unique first hit. ASCII only; not W3C Unicode/parser conformance. |
| E05 | Schema s1 at time1/version1; schema s2 at time3/version2; report r1 at time4 requires schema1. Independent newest-item choice gives incompatible s2+r1. Joint compatibility yields only s1+r1. No shared-clock, source-truth or distributed snapshot guarantee follows. |
| E06 | Cross selection a,c (adequate) versus a,b (inadequate) with recipient JSON carrying exact chosen content versus locators only. After actual file serialization and readback, the two predicates (selection adequate, exact chosen content exposed to worker) realize all four Boolean pairs. Host/locator presence is not content exposure; exact exposure alone can faithfully deliver the wrong set. No model consumption or network delivery is claimed. |
| E07 | Unit cost for a,b,c. Context a,c fits budget2 and covers test/risk. Adding relevant duplicate b before c, then retaining only the first two, produces a,b and loses risk. Coverage of the planned untruncated bundle is not coverage of the actual bounded consumer input. This is not an empirical attention effect. |

## Checks, controls and reporting

For E02 use the P2 section-2 scoring rule with exact rational arithmetic. Similarity scores, first-item selection and tie ordering are explicitly ours. Use full subset enumeration in E03 and full compatible-pair enumeration in E05; do not treat a heuristic's output as its own oracle. E06 observes parsed local JSON, not only the producer's intent.

Seven same-fixture false-rule controls must be rejected: index miss proves source absence; precision1 establishes set adequacy; best effort resolves infeasibility; offsets or first quote match establish identity; newest members form a coherent view; chosen IDs establish content exposure; and enlarging the planned bundle cannot harm bounded exposed coverage. These are not seven independent experiments or a broad code-mutation campaign.

The script must preserve case/control failures in RESULT.json and exit nonzero if any case/control fails. Preserve the first run; do not silently change expectations after seeing it. Repeat unchanged for byte stability. Record Python, SPEC/script identities and actual execution scope. A different runtime may change environment fields without changing observations.

## Non-claims

No example decides the leaf/child hierarchy. No natural-language relevance oracle, calibrated retrieval metric, real permission enforcement, HTTP/W3C conformance, live model/context test, real concurrent/distributed system, independently selected sample or independent reviewer validation is supplied. An analytical counterexample is not evidence that a particular deployed product has this defect.
