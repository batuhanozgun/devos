# Revision checks — specification before first execution

**Date:** 2026-09-13. **Timing:** after source reconnaissance; before first execution of revision_checks.py. The initial research PLAN was already published before that reconnaissance.

## Scope and oracle

Twelve checks probe explicit revision distinctions. Eleven are author-designed finite or in-memory database cases. C12 re-performs Example 5/Figure 1 on printed p.322 of Schwind, Konieczny and Pino Perez (KR 2022), using the authors' independently published expected results and definitions of natural and lexicographic revision. This is reproduction of one mathematical example, not replication of the paper's general representation theorems or an independent review of this Foundation tree.

All inputs are synthetic. Native SQLite queries really execute; no SOUL/LLM, remote service, actual HTTP server, human learning or production database is tested. General semantic interpretation remains the same author's responsibility.

| ID | Expected discriminating result |
|---|---|
| C01 | Two states with the same current preferred world but different rankings over other worlds revise differently under the same lexicographic operator and same next input. Current belief equality is not revision-behavior equality. |
| C02 | Removing the directly asserted q leaves q derivable from a. Eliminating all q support requires removing that route as well under fixed rules. Source withdrawal is not proposition negation. |
| C03 | After a seed is removed, recomputed least Horn closure is empty, while using old consequences as new seeds preserves a/b circular support. |
| C04 | From initial worlds {01,10}, learning a about that same state leaves {10}; setting a true while retaining b gives {10,11}. Initial exclusivity is not declared an invariant. Adding that invariant would reject 11. |
| C05 | Under not-both, two one-literal repairs tie; explicit weights select different repairs. Input constraint does not itself select a priority. |
| C06 | Actual SQLite bitemporal fixture answers ready for valid=15/known=15, blocked for valid=15/known=25, and retains the earlier assertion row. Not a claim about world truth. |
| C07 | A future-effective version received most recently is not the current applicable version at time15; it becomes applicable at35. |
| C08 | Actual SQLite version-conditioned write rejects a stale proposal after an intervening correction; an unconditional write overwrites it. Sequential interleaving, not real concurrency. |
| C09 | The focal representation can retain its version while another required policy changes. Focal-version-only check passes; a check of both declared prerequisites rejects. |
| C10 | Replaying a delta twice counts twice without deduplication; a stable event identity counts it once, while assigning the same absolute value is already idempotent. No exactly-once distributed guarantee. |
| C11 | Separate compatible assumption contexts can support opposing conclusions; their unconditional union is inconsistent and is not a justified consensus. |
| C12 | Published Figure1 initial order yields current p&q. Natural and lexicographic revision by p iff not-q both yield p&not-q; subsequent q yields {110,111} versus {011}. |

## Negative controls

Eight specified false rules must be rejected: current belief equality determines all next revisions (C01); deletion of a direct assertion removes all support (C02); seedless cycles are grounded (C03); learning a equals setting a (C04); a minimal-change directive uniquely selects a repair (C05); arrival-latest always gives applicable-current (C07); a checked focal version validates every prerequisite (C09); a well-formed replay is always idempotent (C10).

No expectation may be silently revised after observing the run. Write a result for failures as well as successes. Re-run the unchanged script to test byte stability, not to claim independent confirmation. Neither green tests nor a matching published example establish the final leaf/split decision.
