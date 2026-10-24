# Actual Causal Contribution / Episode Causation — A2 Multiple Causation / Omission / Depth Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Attack the hardest episode-causation collapses:
- one-root-cause forcing;
- universal but-for necessity;
- joint/overdetermined/preempted causation;
- omission/failure-to-prevent overgeneration;
- proximate versus systemic depth;
- Control/Actors leakage.

## 2. Conjunctive/joint causation

Pattern:

```text
A AND B → E
```

Neither A nor B alone is sufficient, but together they form a sufficient actual configuration.

Examples:
- defect + exact environment condition;
- unsafe action + missing guard;
- incompatible version + permissive rollout path;
- initiating fault + containment failure.

Foundation requirement:

> Preserve the causal configuration/set and member roles when the effect depends on their interaction.

Do not silently convert joint causation into independent sufficiency.

## 3. Alternative sufficient sets / overdetermination

Pattern:

```text
(A) OR (B) → E
A and B both actually occur
```

Removing either alone may leave E unchanged.

Therefore naive but-for reasoning can fail to classify actual contributors under redundant sufficient routes.

Required discipline:
- preserve alternative causal routes/sets where material;
- do not infer non-causation solely from failed individual necessity;
- distinguish route completion from mere route availability;
- permit uncertainty where evidence cannot determine which route actually dominated/completed first.

## 4. Preemption

A stronger episode pattern:

```text
A begins/finishes causal path to E
B could independently cause E
B's route is preempted before producing the relevant effect
```

This pressures a distinction between:
- actual causal contribution;
- merely sufficient potential route;
- causal background/counterfactual backup.

Thus:

```text
could have caused E
!= actually caused/contributed to E
```

This is another reason general causal capability/effect cannot replace episode causation.

## 5. Causal chains and mediation

Pattern:

```text
A → B → C → E
```

Depending on the explanandum and inquiry depth:
- C may be proximate;
- B intermediate;
- A deeper/systemic;
- several may all be actual contributors.

But Foundation should not assume simple transitivity:

```text
A causes B
B causes E
→ A caused E
```

may require additional path/contrast justification, especially under intervention, preemption, blocking or changed boundary semantics.

Causal-chain reachability is not automatically an equal-strength direct cause claim.

## 6. Severity/progression causation

A contributor need not cause the initial adverse event to cause the broader harm.

Example:

```text
fault occurs
→ detection misses
→ containment misses
→ outage spreads
→ prolonged user harm
```

For explanandum `fault occurred`:
- detection failure may be irrelevant.

For explanandum `user harm/prolonged outage`:
- detection/containment failure can be a genuine actual contributor.

Therefore:

```text
cause of occurrence
!= cause of progression/severity/duration
```

This is an explanandum distinction, not a new child.

## 7. Omission / failure-to-prevent — why absence alone is insufficient

Naive rule:

```text
X absent
→ absence caused E
```

is unusable because infinitely many absent things can be imagined.

A decision-useful omission/failure-to-prevent claim normally needs enough of the following to discriminate relevance:
- an exact absent/non-occurring state/action/barrier in the episode;
- a relevant preventive/detective/containment function or causal contrast;
- feasible/relevant alternative presence/action;
- a mechanism/path by which presence would have changed trajectory;
- evidence from design, intervention/removal, reproduction, barrier analysis or domain constraints;
- scope/time alignment with the exact effect.

No single element is declared universal, but **mere imaginable absence is never sufficient**.

## 8. Omission causality remains separate from obligation

Even when:

```text
barrier absent
+
barrier absence causally enabled E
```

we cannot infer:

```text
Actor had duty to provide barrier
Actor was negligent
Actor is accountable
```

Those require Actors/Control/normative semantics.

Therefore:

```text
omission causally relevant
!= omission normatively wrongful
```

## 9. Prevention failure versus Control defect

A Control can be defective without causing the protected outcome in one episode.

Example:
- redundant barrier A defective;
- barrier B successfully prevents hazard;
- no harmful effect occurs.

Conversely, a missing/failed barrier can be causally important to a broader harm when successful operation would have changed the trajectory.

Thus:

```text
Control defect
!= actual causal contributor by identity
```

The causal question is path/effect-specific.

## 10. Detection/containment failure is explanandum-relative

The dual-question protocol is retained:

1. Why did the initiating event happen?
2. Why was it not prevented/detected/contained before the protected effect?

Both can be valid causal inquiries, but they may explain different effects.

Do not flatten them into one root-cause chain unless the inquiry boundary explicitly includes both.

## 11. Systemic/framing conditions can be actual causes

An organizational, architectural, policy, incentive, capability or recurrent-assumption condition can be causally relevant if it actually shaped the episode trajectory.

But label alone is insufficient:

```text
systemic issue exists
!= systemic issue caused this episode
```

Actual episode analysis still needs a causal link to the exact effect through mechanism, constraints, decision path, control structure, changed exposure or other discriminating evidence.

## 12. Systemic is depth/boundary-relative

A factor may be systemic relative to one subsystem and proximate relative to a higher-level organizational outcome.

Therefore:

```text
systemic
!= metaphysically deepest
!= automatically most important
```

Its value depends on whether going to that level changes intervention/recurrence/control/decision.

## 13. Multiple causal roles can attach to one contributor

One condition can simultaneously be:
- enabling;
- prevention failure;
- systemic;
- one member of a sufficient causal set.

Another can be:
- proximate mechanism;
- trigger;
- severity amplifier.

This overlap is strong evidence against role-based immediate children.

## 14. Positive and preventive/mitigating contribution share the same episode grammar

Actual causation includes not only harmful/promoting contributors.

Question:

> Did factor M actually prevent, mitigate, delay or contain this exact effect?

uses the same core requirements:
- exact explanandum;
- actual contributor;
- causal relevance/path/contrast;
- evidence;
- alternatives.

Thus `Mitigation/Prevention` does not require a separate child.

## 15. Depth stopping rule

Continue from proximate toward deeper factors only while another layer materially changes:
- corrective action/intervention;
- recurrence-risk understanding;
- prevention/detection design;
- scope of investigation;
- responsibility boundary;
- decision outcome.

Stop when deeper explanation no longer changes these materially or becomes untestable/metaphysical for the task.

## 16. Provisional child-split result

The following remain important profiles but do not yet justify children:

```text
Direct / Proximate
Enabling / Contributing
Prevention Failure
Detection / Containment Failure
Systemic / Framing
Positive / Omission
Promoting / Mitigating
Necessary / Sufficient / INUS-like
Individual / Joint / Redundant
```

Reasons:
- overlap;
- explanandum dependence;
- depth/boundary dependence;
- cross-cutting causal-set properties;
- some domains lack particular control/barrier structures.

## 17. A2 conclusion

Actual episode causation needs **configuration-sensitive, explanandum-relative, multi-cause semantics**.

Strongest non-collapse additions:

```text
could-have-caused != actually-caused
cause of occurrence != cause of progression/severity
Control defect != actual causal contribution
systemic issue exists != systemic issue caused this episode
joint causal set != independent cause edges
```

Proceed to A3 evidence, competing explanations and confidence.
