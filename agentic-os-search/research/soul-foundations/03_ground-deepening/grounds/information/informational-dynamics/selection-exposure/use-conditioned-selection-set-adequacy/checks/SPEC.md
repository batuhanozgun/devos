# Use-conditioned selection — pre-execution specification

**Date:** 2026-09-15. Written after targeted primary reading and before the first execution of adequacy_checks.py.
**Scope:** six finite checks; deterministic policies unless otherwise stated; exact rational arithmetic. No live model, search service, permission system or human study.

## Fixed cases

| ID | Construction and expected outcome |
|---|---|
| K01 | Four states, two actions, all 256 binary loss tables and all 15 partitions of the states. For every one of 3840 combinations, a nonempty intersection of statewise optimal-action sets in every view cell must agree with existence of an optimal deterministic view-only policy found by separate policy enumeration. Zero disagreement. Additional two-state/three-action tie case: losses (0,0,1) and (1,0,0) share optimal action 1, although their optimal-action sets differ. |
| K02 | States 0,1,2,3 and view floor(state/2). For binary target state>=2, cellwise minimax regret is zero despite two states per cell. Changing the target to parity, with identical view and zero-one loss, yields cellwise minimax regret 1; the full state view gives zero. A view can preserve a particular decision without identifying everything and fail a later use. |
| K03 | Two states with probabilities 99/100 and 1/100. Action A losses (0,10), action B losses (2,0); full-state minimum zero. Expected losses are 1/10 and 99/50: expectation prefers A. Worst-case regrets are 10 and 2: deterministic minimax prefers B, meets tolerance 2 and cannot meet tolerance 1 without more information. No randomization or universal risk preference is assumed. |
| K04 | Independent fair bits X,Y and target XOR. Optimal expected correct-guess utility is 1/2 without observations, 1/2 after either one bit, and 1 after both. With cost 1/10 per observed bit, net values are 1/2 for stopping, 2/5 for either singleton and 4/5 for the pair. A rule that only considers one further read stops, although the pair improves net utility by 3/10. |
| K05 | Hay et al. (2012), Example 4: independent utilities U1 in {-3/2,3/2} and U2 in {1/4,7/4}, each equiprobable; U3=lambda known; each exact observation costs 1/5 and can be done at most once. Solve the resulting finite continuation problem, including optional second observation. At lambda=0, values (stop, observe1, observe2) are (1,21/20,81/80): observe1 wins. At lambda=1 they are (1,91/80,6/5): observe2 wins. The source supplies the model and qualitative inversion; these two exact rational points are our precomputed expectations, not values digitized from its figure. |
| K06 | Three fair bits s,x,y; target x when s=0, y when s=1. Each existing exact bit report costs one budget unit. All seven fixed subsets of size at most two fail exact target identification across the eight worlds. The policy 'read s, then its indicated bit' identifies the target in every world with two reads. Reading all three is a sufficient fixed set. No adequate fixed bundle does not imply no adequate adaptive policy under the same per-path budget. |

## Oracle and source boundary

K01 independently enumerates deterministic policies rather than using the intersection calculation as its own expected answer. Both share the declared finite loss tables, and the implementation/interpretation remain same-author. K02/K03 use explicitly supplied losses and regret tolerance; they do not choose the right real-world utility function or certify a true state model.

K04's XOR information-complementarity structure comes from Krause and Guestrin, Near-optimal Nonmyopic Value of Information in Graphical Models, section 3.2, Example 1, arXiv:1207.1394. The decision-utility and cost extension here is ours. That PDF page was visually inspected. K05 uses Hay, Russell, Tolpin and Shimony, Selecting Computations: Theory and Applications, arXiv:1207.5879, section 3, Example 4 and Figure 1; the figure was visually inspected, not numerically transcribed. Neither case replicates the whole paper or its experiments. K06 is our declared construction, not a simulated real agent or empirical claim about adaptive retrieval.

Sources: https://arxiv.org/pdf/1207.1394 and https://arxiv.org/pdf/1207.5879 . Broader interactive-retrieval source pressure is recorded separately and is not an oracle for these six formal cases.

## Failure sensitivity and reporting

Reject six same-fixture false rules: identical optimal-action sets are necessary; adequacy transfers unchanged to every new target; minimum expected loss certifies a worst-case tolerance; zero single-read gain implies zero useful combination; the preferred information item is independent of other action alternatives; and fixed-bundle infeasibility proves adaptive-policy infeasibility.

Write all case/control failures into RESULT.json and exit nonzero on any failure. Keep the first run, its environment and input identities. Repeat the unchanged program for byte stability; do not revise expectations silently after observing results. A runtime change can change environment fields without altering mathematics. The 3840 checks are finite enumeration inside one case, not 3840 independently sampled experiments.

## Non-claims and remaining research

No test establishes natural-language sufficiency, the correctness of an actual belief/utility model, complete corpus coverage, actual consumer use, independent scientific validation or a correct child/leaf hierarchy. Explanation/provenance obligations can exceed action-only sufficiency. K06 uses a fixed known target and adaptive choice of existing reports; it does not test discovery of an unknown information need. U4 still owes structural and non-decision-use comparison. Original parent and predecessor check suites are not rerun or modified by this specification.
