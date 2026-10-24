# W2 — Consequence, Probability and Target Identification

**Date:** 2026-09-12  
**Status:** bounded analysis with exact synthetic checks.

## 1. Consistency, consequence and proof search differ

Classical entailment asks whether every model satisfying a basis also satisfies a conclusion. W3C RDF 1.1 provides a specified semantic-entailment tradition, while explicitly distinguishing entailment regimes and application purposes [S1]. Our propositional fixtures are not a claim that simple RDF itself has a negation operator or inconsistent graphs.

In C02 no classical world satisfies p and not-p. The universal test then entails both q and not-q vacuously. The code preserves this definition; it does not repair classical logic by redefining entailment. The operational error would be presenting either as an established real-world fact from that inconsistent basis. A different logic could treat conflict differently, but none is selected here.

C03 is a different failure. One synchronous rule-search round reaches b from a but has not yet reached c; two rounds do. Failure to finish finding a proof is not semantic non-entailment and not a proof of the opposite. A real proof search may be complete for a stated fragment and then legitimately establish a negative result; the budget-limited fixture does not. The type and completeness of the check belong to its claim.

## 2. A likelihood is not a posterior

Bayes' formula combines a likelihood with a prior and alternatives rather than reversing a conditional by label [S3]. C04 supplies an exact synthetic alert population. With P(H)=1/100, P(E|H)=9/10 and P(E|not-H)=1/10, the posterior P(H|E) is 1/12. The independent count calculation uses 90 true alerts and 990 false alerts among 10,000 stipulated items. Changing only the prior to 1/2 changes the posterior to 9/10.

No empirical fault prevalence, detection system or real decision is measured. The example shows what changed in the inferential basis, not which prior SOUL should use. Where a prior or likelihood range is defensible but one point is not, a result across that range can be more faithful to the evidence than false precision. Such a range is conditional on the admitted family; it is not a guarantee that all real uncertainty has been covered.

If the prior is allowed to range from 1/100 to 1/2 with these fixed likelihoods, the posterior ranges from 1/12 to 9/10 because the expression is increasing in the prior. This elementary sensitivity calculation is not a newly discovered theorem or a confidence interval estimated from data.

## 3. Evidence dependence and conclusion dependence

C05 distinguishes receiving the same alert twice from two alerts conditionally independent given H and not-H. The duplicate keeps posterior 1/12. The independently specified pair gives 9/20. Another delivery, agent label or summary does not itself establish the independence condition. Actual separate observations may also share a common error source; the fixture does not estimate that dependence.

C11 addresses a different question: combining different conclusions. Three claims each have marginal probability 9/10. Joint distributions with those same marginals can make all three true with probability 7/10 or 9/10; an independent model gives 729/1000. The exact finite distributions are checked. Strong individual claims do not license an unqualified equally strong conjunction. The result is about defined probabilities, not a formula for combining linguistic confidence words.

## 4. Correct observed prediction is not causal identification

C06 defines two structural models with an equiprobable binary U. Both set X=U. One sets Y=X; the other sets Y=U. Observationally both produce only (0,0) and (1,1), so the same predictor Y=X is perfect in each. Setting X by intervention changes Y in the first model but not the second. Their causal effects are respectively 1 and 0.

Thus the common observational evidence alone does not select the causal effect in this two-model class. It is not a proof that causal learning is impossible: further justified assumptions, interventions or other evidence can change the candidate class. Nor does a single small experiment universally establish one model. Pearl's primary account motivates keeping observational distribution and causal assumptions separate [S4]; the code verifies only the explicitly supplied models.

The accepted causal Foundation result already distinguishes a defined target, identification, estimation and decision sufficiency. We reuse that boundary. This pass neither reopens nor independently verifies the entire causal corpus. Identification is not merely a high prediction score or a narrow numerical confidence interval.

## 5. An explanation's fit is a scoped claim

A hypothesis that reproduces observations may still compete with others. The strongest of a stated set can have less than half of the total probability, and a ranking over a restricted set says nothing by itself about omitted alternatives. Simplicity, prior plausibility and explanatory coverage can legitimately guide a comparison, but those are additional criteria rather than observations magically present in the data.

The useful next inquiry can therefore target the missing distinction: a premise, source reliability, dependence, model applicability, an alternative explanation, or a discriminating observation. More of the same nondiscriminating evidence may not answer it. This does not require collecting new data whenever inference is uncertain; analysis can expose consequences already available or show that the current decision is robust across alternatives.

**Sources:** S1/S3/S4. C01–C06/C11. Formal statements concern declared model classes/distributions and do not establish a real system's assumptions.
