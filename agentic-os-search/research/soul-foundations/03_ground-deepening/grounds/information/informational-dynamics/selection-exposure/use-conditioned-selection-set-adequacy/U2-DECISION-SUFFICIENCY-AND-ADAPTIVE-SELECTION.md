# U2 — Decision sufficiency, complementary evidence and adaptive selection

**Date:** 2026-09-15. **Status:** bounded findings checkpoint; structural judgment unfinished.
**Sources:** P1–P3 in SOURCE-LEDGER. **Execution:** K01–K06, exact specification and limits in U3/checks.

## 1. What does sufficient mean for the present use?

The parent established that relevant individual items can form an inadequate set. The deeper question is what the set must preserve. A view can be sufficient to choose an action, insufficient to explain that action and insufficient to reconstruct the original evidence. These are different use contracts, not interchangeable scores.

Borlund's work-task and situational-relevance framing [P3] supplies independent conceptual pressure against equating the actual use with a query proxy. We do not adopt subjective judgment as factual truth or its historic metrics as a universal oracle. A future SOUL reader may need an exclusion condition, a counterexample or a source-validity limit rather than more documents on the same topic. That is our project-facing application, not an observed runtime result.

## 2. A precise finite criterion for one decision contract

Let Omega be an explicitly supplied finite set of states, A a finite nonempty action set, v:Omega→V the information view, and L(a,w) the declared loss. Take the comparison baseline to be a decision with full state knowledge. Define Opt(w)=argmin over a of L(a,w).

A deterministic policy depending only on v attains that full-state minimum in every modeled state exactly when

```
for every nonempty view cell C:
    intersection of Opt(w), over w in C, is nonempty.
```

Necessity: a policy sees the same v in one cell and must take one action there. That action must be optimal in every state in that cell. Sufficiency: choose an action from each nonempty intersection and assign it to the corresponding view. This is an elementary finite decision-factorization argument, not a novel general information-ordering theorem or a replication of an unread Blackwell paper.

K01 compares this criterion to separate enumeration of every deterministic view-only policy for all 256 binary four-state/two-action loss tables and all 15 partitions. All 3840 comparisons agree. A tie example also shows why identical optimal-action sets are unnecessarily strong: different sets may share one sufficient action.

Exact identification of the world is therefore not required for every use. K02's view leaves two states indistinguishable but preserves its first binary decision. The same view fails after the required decision changes to parity. Adequacy attaches to the declared use, not to the document or summary once and for all.

## 3. Approximation and baseline must be declared

For a deterministic view-only policy, the smallest achievable worst-case regret in a cell is

```
r(C) = min_a max_{w in C} [ L(a,w) - min_b L(b,w) ].
```

Tolerance epsilon can be met throughout the stated domain iff max_C r(C) <= epsilon. This follows by selecting a minimizing action separately in each cell. Expected loss under a prior is a different objective; neither dominates as a universal authorization or risk rule. Randomized policies can change minimax values and are outside this criterion.

K03 makes the distinction explicit: expected loss favors A, while the deterministic worst-case tolerance favors B; a tighter tolerance is infeasible without additional information. The fixture supplies the prior and losses. It does not tell SOUL which policy or probability assignments to use.

There are two further boundaries. First, preserving an action supported by the full available archive differs from matching an omniscient-world optimum. In a real task the archive, state domain and loss model may be incomplete or wrong. Second, an action-only guarantee does not preserve the supporting explanation, authorization or evidence provenance. Those can be separate acceptance requirements. A model-relative adequate view is not a certificate that its propositions are true.

## 4. Useful information has joint and contextual value

The relevant benefit can depend on what is already known and what other information could be read. P1's XOR example refutes a universal diminishing-marginal-gain assumption for information about a target. K04 reconstructs the same complementarity with a decision payoff and explicit read costs. Each bit alone leaves the best guess unchanged; both jointly identify the answer. A one-more-read policy rejects both singletons, although reading both is worthwhile under the stipulated costs.

This does not recommend unlimited lookahead. Computing the best acquisition policy also costs resources, and the conditional model may be unknown. P2's metalevel framing separates the final action's utility from information-gathering costs. K05 narrowly reperforms its Example 4: the preferred report changes when a known outside alternative changes, although the two report distributions and read costs stay fixed. The exact two-point values are in SPEC/RESULT; they are not sampled from its graph or a replication of its experiments.

Consequently a context-free intrinsic score for each research unit can be a useful proxy, but cannot be assumed to express all decision value. A finding that matters only together with an applicability condition must not be discarded solely because it changes no answer alone. Conversely, high novelty or entropy about an unrelated variable need not help the declared decision. The latter is an analytical observation, not a seventh executed case.

In an ideal model where extra information is free, faithfully interpreted and may be ignored, refinement cannot reduce the optimal attainable expected payoff: the old policy remains available. Actual reading has cost, delay, disclosure and capacity constraints. The ideal monotonicity argument is not a claim that adding arbitrary text to an agent context improves its performance.

## 5. A selected bundle is not the only possible unit

K06 is more than another ranking example. No fixed collection of at most two of its three bit reports identifies the target across all eight worlds. A two-read adaptive policy does: first read the selector bit, then the indicated data bit. Its per-path budget matches the unsuccessful fixed bundles. The union of all possible branches still contains three reports; that is not the content consumed on every path.

A claim of infeasibility must therefore say whether it concerns a single fixed bundle, a contingent sequence, or the entire permitted strategy family. The parent's empty feasible-family argument remains correct for its declared family; it must not be generalized to every adaptive policy without checking that larger family.

This is not evidence that every selection should be adaptive. The target and report meanings in K06 are fixed and fully known. It does not discover a new need, create new source information or test actual access. Nor does it prove that all adaptive strategies can be represented by one static ranking. U4 must decide whether this is a mode of the existing child or exposes a first-order inquiry worth separating.

## 6. Present selection and future research reuse

Not selected now does not imply worthless, false or eligible for deletion. A finding may become relevant when an action set, allowed loss, assumption, affected actor, source condition or question changes. Current selection and retaining a recoverable basis for later selection are different duties; Records, Revision and Exposure retain their respective boundaries.

As an analytical SOUL example, a result about a method's limits can rule out a future design only when its failure condition applies. Retrieving only the positive method description loses that potential use. Retrieving the entire archive is not automatically better. The useful unit may need its question, applicability condition, result, counterexample and evidence limit together. This remains a research-use obligation, not a compulsory stored-field schema or architecture choice.

A later reader should also know what the research has not tested. The conditional conclusion and its source route can direct a new question rather than directly determine a decision. No claim is made that every Foundation finding will be used, or that future use can be completely scheduled now.

## 7. What remains open before a node decision

U1's rivals remain live: one qualified need-to-view relation; need/adequacy specification versus constrained view construction; fixed-contract choice versus adaptive inquiry. The new evidence makes explicit policy/horizon and use specification unavoidable but does not decide their hierarchical status.

The decisive next comparison is against explanation, exploratory need formation and evidence checking, not merely another decision-payoff fixture. Can the present relation preserve those uses without replacing them with an artificial action objective? Can an adequate selection criterion itself be questioned without absorbing Work and Warrant? Does adaptive selection expose a new protected outcome or change the admissible method family? U4 must answer those questions before U5 proposes a leaf or children. No Exposure research, new descendant or parent refinement is accepted at this checkpoint.
