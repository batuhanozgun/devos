# W7 — Adversarial Closure and Executed Evidence

**Date:** 2026-09-12  
**Status:** bounded dedicated result for user evaluation.  
**Verification:** same-model review and author-specified finite checks, not independent replication.

## 1. Strong challenges

| Challenge | Resolution / limit |
|---|---|
| Correct conditional proof establishes real target truth | C01 leaves a missing premise; target applicability is a separate condition. |
| Classical entailment always supplies usable factual support | C02 preserves vacuous entailment from an inconsistent basis while rejecting that factual upgrade. |
| A missing proof is a proof of the opposite | C03's unfinished one-round search succeeds with a larger bound. |
| Strong likelihood is high posterior | C04 gives 9/10 likelihood with 1/12 posterior under the specified base rate. |
| Repeated source reports establish independent evidence | C05 distinguishes the same event from conditionally independent events. |
| Perfect prediction identifies an intervention effect | C06 supplies observationally identical models with effects 1 and 0. |
| Losing support proves the opposite | C07 leaves both truth values open; an alternative route can still support the claim. |
| A reasoning cycle is self-supporting evidence | C08's unseeded rules establish nothing under their stated semantics. |
| A selected successful test inherits the single-test guarantee | C09's exact family probability differs. Valid selection-aware methods are not excluded. |
| Overall calibrated confidence applies to any subgroup | C10 separates the population and subgroup conditions. |
| Individually strong claims give an equally strong conjunction | C11 has identical marginals and different joint probabilities. |
| High posterior selects or authorizes the action | C12 changes action under different costs with unchanged evidence; authority is untested. |
| Every useful inference must be deductive | Rejected; explicit tentative, probabilistic and defeasible claims can be appropriate under their actual contracts. |
| Any imaginable exception defeats support | Rejected; a material defeater itself requires relevant support, not mere possibility. |
| A valid offered proof must describe the producer's actual route | Rejected; production fidelity and epistemic validity are separate, as S6 pressures. |
| A broad checklist or prior leaf outcome settles the hierarchy | Rejected. W4 retains serious rival regimes and makes the organizational cost/reopen conditions explicit. |

## 2. What actually ran

The local PLAN was written before fresh external reconnaissance. `checks/SPEC.md` was written afterward and before the first execution. Python 3.13.5 executed the new `checks/warrant_checks.py`. The first run passed all twelve specified cases and discriminated all eight false rules. No case was excluded, no expectation or specification was changed after that result. A repeat execution produced byte-identical RESULT.json.

| Case | Observed relationship |
|---|---|
| C01 | q follows with p; conditional alone has countermodel p=false,q=false |
| C02 | zero compatible classical models; both q and not-q vacuously entailed; no factual warrant claimed |
| C03 | one round gives a,b; two give a,b,c |
| C04 | posterior 1/12; changed prior gives 9/10; exact 90/(90+990) count agrees |
| C05 | duplicate posterior 1/12; conditionally independent pair 9/20 |
| C06 | identical observed pairs; direct effect 1, confounded-model effect 0 |
| C07 | support -> unsettled after undercut; alternative support restores supported status; contrary input differs |
| C08 | unseeded cycle derives neither; seeded cycle derives both |
| C09 | 29,679 crossings among 160,000 exact outcomes, matching 1-(19/20)^4 |
| C10 | population 4/5; subgroups 1 and 3/5 |
| C11 | marginals each 9/10; joint probabilities 7/10,9/10,729/1000 |
| C12 | same posterior 4/5; different explicit costs choose act versus wait |

Eight rejected false-rule substitutions concern a missing premise, failed search as negation, reversed conditional probability, repeated reports as independence, observational prediction as causal identification, undercutting as negation, per-test as family probability, and aggregate as subgroup calibration. These are controls on the same fixtures, not independent experiments or a production mutation-testing campaign.

## 3. Oracle and generalization limits

Truth tables, models, distributions, subgroup membership, costs and interpretations were supplied by the same author. Countermodel witnesses, exact counting and the Bayes count cross-check offer distinct calculation paths, not an independent researcher. C07 is a tiny stipulated default relation, not Pollock's full semantics. The Horn example is not a complete theorem prover. The causal example does not discover a real causal graph or estimate a real intervention.

No source retriever, LLM, deployed agent, human experiment, sensor, empirical dataset, production model, live inference service or actual knowledge-revision system was tested. No benchmark success rate, empirical calibration estimate, real-world causal effect or universal semantic oracle follows. Seven independently authored primary documents constrain component claims at unequal reading depths; they do not independently validate this exact synthesis.

## 4. Bounded closure

The qualified claim-support object survives source/transfer/revision and causal/Standing/Control boundary challenges. The strongest strict-versus-defeasible split remains plausible but does not currently force a new immediate child under the explicit regime-sensitive routes. The proposed leaf and W6 refinements are ready for evaluation. This is a revisable research organization, not a complete solution to epistemology.

Unknown model adequacy, missing alternatives, source dependence, real defeater credibility, opaque actual input use and distribution transfer remain explicit conditions. They are not all silently solved by definitions, nor all treated as active mandatory empirical work for an unspecified SOUL deployment.

## 5. Publication is separate

Completion of this file does not establish main publication. Re-expression acceptance and Warrant's pending status must agree across current routes, raw earlier evidence must remain unchanged, remaining Revision/Selection must stay visible, exact manifests must bind the intended bytes, and a non-forced main update must be read back. File identity and user acceptance do not validate semantic truth or live benefit.
