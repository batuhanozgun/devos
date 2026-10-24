# Claim Warrant — Pre-execution Check Specification

**Date:** 2026-09-12  
**Timing:** written after source reconnaissance, before the first execution of this new script.  
**Scope:** twelve finite, deliberately constructed counterexamples; no production or universal-warrant evaluation.

## Target and oracle

Test the exact relationships below using Python's standard library, finite truth tables, explicit rule sets, exhaustive counting and rational arithmetic. The author supplies the premises, candidate worlds/models, distributions, meanings, costs and expected values. Independent arithmetic paths where available are cross-checks, not independent researchers. No LLM, real actors, sensors, empirical data, production inference engine or deployment is exercised. The proposed research hierarchy is not a test output.

| ID | Required relationship |
|---|---|
| C01 conditional consequence | p and (p implies q) entail q; the conditional alone leaves a countermodel. An actual-world premise assessment is not supplied by the truth table. |
| C02 inconsistent basis | no classical model satisfies p and not-p; classical entailment is vacuous for both q and not-q. Report inconsistency rather than claiming either real-world fact established. |
| C03 incomplete search | one synchronous Horn round from a reaches b but not c; two rounds reach c. A bounded unsuccessful proof attempt is not a proof of negation or semantic non-entailment. |
| C04 probability direction | with prevalence 1/100, sensitivity 9/10 and false-positive probability 1/10, P(H given E)=1/12, not 9/10. Changing only the prior to 1/2 gives 9/10. A 10,000-item exact count agrees with the first result. |
| C05 dependence | two reports of the identical alert retain posterior 1/12; two conditionally independent alerts with the same specified rates yield 9/20. Independence is a supplied condition, not inferred from the report count. |
| C06 causal identification | two binary structural models have identical observed (X,Y) distributions and perfect observational prediction; one has intervention effect 1 and the other 0. No observational-only exact decoder of that effect exists for this two-model class. |
| C07 defeating support | under a declared tiny default rule, adding a sensor-path defeater withdraws that support while leaving both H truth values compatible. A separate support path can retain support. Explicit contrary support is a different input and can produce conflict. Not a general Pollock implementation. |
| C08 circular support | a->b and b->a with no seed derive neither; adding seed a permits both. A cycle does not establish its own premises; seed truth remains a separate question. |
| C09 selected tests | four independent discrete-uniform null p-values on {1/20,...,1} each cross <=1/20 with probability 1/20. Selecting any crossing has probability 1-(19/20)^4 = 29679/160000. Exhaustive 20^4 counting agrees. No data-dependent case exclusion or universal ban on multiple/sequential inference follows. |
| C10 calibration scope | over a uniform ten-case population with reported confidence 4/5 for every prediction, overall accuracy is 4/5 while subgroup accuracies are 1 and 3/5. This is exact in the stipulated finite population, not an empirical calibration estimate. |
| C11 joint claim scope | three claims each have probability 9/10. Explicit joint distributions attain joint success 7/10 and 9/10; independence instead yields 729/1000. Marginals alone do not select one of them. |
| C12 evidence versus action | the same posterior 4/5 yields different optimal actions under two explicit loss tables. Evidence is unchanged; action choice also needs a goal/loss basis, and this example grants no real authority to act. |

## False-rule controls

Demonstrate that eight named unqualified substitutions disagree with the correct fixture result: (1) conditional without its missing premise establishes q; (2) unfinished proof search establishes negation; (3) likelihood is posterior; (4) report duplication implies independence; (5) perfect observational prediction identifies the causal effect; (6) defeated source support establishes not-H; (7) selected-family false-positive probability equals per-test probability; (8) overall calibration guarantees the same subgroup calibration.

These are declared wrong rules on the same fixtures, not eight independent experiments or a production mutation-testing campaign. Do not count rejection merely from a narrative assertion: record the incompatible value or witness. Record any failure and any later change to this specification explicitly. A stable rerun concerns reproducibility of the supplied examples, not semantic or empirical universality.
