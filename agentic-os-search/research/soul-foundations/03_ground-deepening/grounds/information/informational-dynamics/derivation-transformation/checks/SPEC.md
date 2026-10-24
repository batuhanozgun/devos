# Derivation Checks — Pre-execution Specification

**Date:** 2026-09-12  
**Role:** fixed finite counterexamples, not production or taxonomy validation  
**Timing:** written after targeted source reconnaissance and before the first execution of the new check script.

## Claim and scope

Fourteen named cases challenge unqualified equivalences used in transformation judgments. The implementation uses Python's standard library, exact finite model enumeration and an actual in-memory SQLite connection. SQL data, worlds, contracts and expected answers are synthetic. SQLite execution is real; no live SOUL, LLM, retrieval system, human decision or deployed data pipeline is exercised.

## Cases and expected discrimination

| ID | Case | Required relationship |
|---|---|---|
| C01 | faithful false premise | faithful copying and subject-matter truth differ |
| C02 | entailment versus purpose | p follows from p-and-q but drops the q needed by a declared question; fibre and decoder tests agree on all 16 Boolean questions over four worlds |
| C03 | accidental correctness | p-or-q does not entail p even when p happens to be true in the realized world |
| C04 | re-expression and composition | exact temperature recoding preserves the declared quantity; correct seconds-to-milliseconds conversion followed by a seconds consumer changes the intended end result |
| C05 | conditional versus unconditional | p-implies-q plus p licenses q; dropping p from the declared assumptions does not |
| C06 | SQL missingness/denominator | AVG(2,4,NULL)=3 over two observed values; zero-imputation or three-row denominator answers a different question |
| C07 | SQL join multiplicity | two distinct tasks costing 10 each total 20; a join with three log rows totals 30; SUM(DISTINCT cost)=10 is not a generic repair |
| C08 | joint and alternative support | (a AND b) OR c differs from a flat source list; loss of one route need not remove the other |
| C09 | negative dependency | inserting a blocking row changes NOT EXISTS output without modifying the positive task row |
| C10 | correlated copies | mean of two identical ±1 sources has variance 1; mean of independent equiprobable ±1 sources has variance 1/2 |
| C11 | revision alternatives | revising p-and-q under not-both with maximal old-literal preservation has two tied results; neither disjunct is skeptical certainty |
| C12 | withdrawal is not negation | after dropping q while retaining p, both q and not-q remain possible |
| C13 | temporal conjunction | individually true facts from nonoverlapping source intervals do not establish their simultaneous conjunction |
| C14 | proposed versus installed revision | computing a proposed maintained state does not mutate the current state before an explicit application step |

## Negative controls

Reject these seven specified substitutions against the corresponding oracle: infer p from p-or-q; treat an entailed partial summary as sufficient for every declared question; replace NULL with measured zero; fix every duplicate join with DISTINCT(value); interpret removal of any one support as total invalidation; ignore absent-row dependencies; treat copied evidence as independent. Rejection only measures sensitivity to these faults on these fixtures.

## Oracle and boundaries

Predicates, source worlds and purpose contracts are chosen by the same author as the analysis. C02 compares a fibre criterion to exhaustive decoder enumeration; C06/C07/C09 execute native SQLite and compare exact fixture expectations. These are distinct calculation paths, not independent research. No score or threshold is tuned to certify the research tree. Any test failure or change to this specification must be disclosed rather than silently excluded. Stable re-execution and hashes concern reproducibility of these files only.
