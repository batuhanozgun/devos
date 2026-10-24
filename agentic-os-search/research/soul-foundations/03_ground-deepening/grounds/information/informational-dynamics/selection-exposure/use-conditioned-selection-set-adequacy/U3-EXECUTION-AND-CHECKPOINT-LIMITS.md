# U3 — Executed checks and checkpoint limits

**Date:** 2026-09-15
**Result:** six cases passed; six same-fixture false-rule controls rejected.
**Research checkpoint:** U0–U3 recorded; U4 structural/non-decision comparison remains unfinished.

## Timing and actual execution

The specification was committed at `7f5beeba20893f1bf9f5fd0a898464f4b8bb9ce4` before the first run. Its canonical content was fetched, and the copied local bytes matched the returned Git blob before execution. Python 3.13.5 / standard library executed the first script with exit code zero. The original RESULT and stdout log were retained. An unchanged second run also exited zero and produced byte-identical JSON. No expected outcome, fixture, loss, source model or code logic was changed after observing results; no failed scientific run was discarded.

The source and result were published at `e99848157cfc639b87bc2f6db06271ef96658eb6` and `a18c97403a0fed3e0d7f94caa4d2fed4544546c4`. A separate GitHub checks-tree read at the result commit matched all three local identities and byte sizes.

| Artifact | Bytes | Git blob SHA | SHA256 |
|---|---:|---|---|
| SPEC.md | 5794 | `9f820d188f528d4da1942b69299f2b8e00322656` | `68449d6552497e372142a8e31723e9ece3e5610787c9ab9e1214cffcff5a750d` |
| adequacy_checks.py | 9375 | `c238f5182a9ac8f04a356b40e8f69d61a9d1e5bc` | `c023ba8dc030d0f880e14d86aaddb770f3060406c456cb04eb0ac3eb3798a53e` |
| RESULT.json | 4630 | `2ad19e0075ad34d11c37b62d06941e0bbdf44ad3` | `53362c1325acf0c6845ad7151361e720ce3ece80fa436a67d66b00771f0eac1b` |

First and repeat stdout both reported six cases, six controls, all_passed=true and the RESULT SHA256 above. Runtime metadata is included in the output; another Python version can change bytes without changing the mathematical observations.

## Observed distinctions

K01: all 3840 finite comparisons agreed between the common-optimal-action condition and separate deterministic-policy enumeration. Different optimal-action sets can share one action; complete equality is not necessary.

K02: the same coarse view has regret zero for its first target and one for the second; the full view resolves the second target. K03: expectation selects A while deterministic worst-case tolerance selects B, with a tighter tolerance infeasible without information.

K04: two individually non-improving observations jointly improve net utility by 3/10 under the stated cost. K05: the source-model's preferred first observation changes from 1 to 2 when the outside alternative changes from zero to one; exact values match SPEC. K06: all seven budget-two fixed bundles fail, while all eight paths of the two-read adaptive policy succeed.

## Verification strength and limits

The six false rules are evaluated on the same fixtures as the positive cases, not six new experiments or broad mutation testing. K01 uses a second computation of its predicate, but shares the loss tables, partition interpretation and author. Exhaustive enumeration is restricted to the declared finite domains; 3840 comparisons are not independently sampled real tasks. Expected losses, action sets, probabilities, interpretation and costs are stipulated, not empirically calibrated.

K04 reconstructs a published complementarity structure with an original payoff/cost extension. K05 uses a published model and qualitative inversion, but its two exact point values and recursive implementation are our reconstruction, not a full-paper replication. K06 uses already-existing exact reports and a known fixed target; it does not evaluate discovery of an unknown need or source creation. No live SOUL/LLM, production retrieval, real access service, human evaluation, independent researcher/model replication or full source-proof verification occurred.

Original parent Selection and predecessor check suites were not rerun or modified. U2's elementary finite criterion and analytical implications are not evidence that a real archive is complete or true. Same-author repeatability and Git identity are useful bounded checks, not oracles for the hierarchy.

## Exact continuation

U4 must compare the live structures against explanation, exploratory need formation and evidence checking, and decide whether adaptive selection is a mode or a separate first-order problem. U5 synthesis/node decision and U6 research closure have not been completed. No leaf, descendant or new parent refinement is submitted as a final result here. Preserve the published U1–U3 work and begin from those open questions rather than rerunning the cases for volume.
