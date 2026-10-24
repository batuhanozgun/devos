# Cross-Ground Causal Effect / Contribution — E2 Causal-Role / Depth Discrimination

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Test whether recurring causal roles/depths form stable immediate children or remain overlapping analytical roles within one causal-effect region.

Candidate recurring roles:
- trigger;
- proximate/direct cause;
- enabling/contributing condition;
- prevention failure;
- detection/containment failure;
- systemic/framing cause;
- necessary/sufficient/contributing cause;
- omission/failure-to-prevent;
- mitigating/preventive contributor.

## 2. Trigger is not a safe child

A trigger answers roughly:

> What event initiated or exposed the causal sequence?

Example:

```text
traffic spike
→ latent capacity defect becomes visible
→ service outage
```

The traffic spike may be a true causal contributor, but removing only the trigger may leave the failure class intact under the next spike.

Therefore:

```text
trigger != complete causal explanation
```

But `Trigger` is not a stable child because:
- some effects have no discrete trigger;
- gradual processes can produce effects without one initiating event;
- one factor can be both trigger and enabling condition depending on temporal resolution;
- trigger status is explanandum/scale-relative.

## 3. Proximate/direct cause is real but depth-relative

A proximate cause identifies a relatively direct mechanism near the effect.

Examples:
- component fractured → load path failed;
- malformed input → parser crashed;
- wrong medication administered → patient harmed.

These can be fully true causal claims.

But `proximate` is relational to causal depth and chosen effect boundary:

```text
proximate relative to effect E1
may be intermediate relative to broader effect E2
```

NASA and FAA material both pressure investigators not to stop automatically at the proximate cause when recurrence prevention requires deeper factors.

Therefore `Proximate Cause` is an analysis role, not a universal child population.

## 4. Contributing/enabling conditions are distinct from direct mechanism

A condition can matter causally without directly producing the effect.

Examples:
- insufficient staffing made monitoring failure more likely;
- missing version pin allowed incompatible dependency drift;
- high ambient temperature amplified a hardware fault;
- permissive network access made an alternate path available.

Key non-collapse:

```text
enabling / contributing condition
!= direct mechanism
```

But contribution can be:
- necessary in the episode;
- one member of a jointly sufficient set;
- probability-increasing rather than deterministic;
- severity-amplifying rather than occurrence-producing.

Thus a generic `contributor` relation can still be too coarse, but the family overlaps strongly with necessary/sufficient/probabilistic roles.

## 5. Prevention failure is a causal role, not the Control itself

Suppose a control should have prevented an event:

```text
unsafe action
→ preventive control should block
→ control absent / ineffective / bypassed
→ harmful effect occurs
```

The causal question is:

> Did the absence/failure of the barrier materially permit the realized effect?

This is distinct from:
- what the Control policy required;
- whether a legitimate authority established it;
- whether it was implemented;
- whether someone violated an obligation.

Therefore:

```text
prevention failure causal contribution
!= Control semantics
!= compliance standing
!= responsibility
```

The same missing barrier can be:
- an enabling condition;
- a prevention failure;
- a systemic design condition.

So `Prevention Failure` is not disjoint enough to be a stable child.

## 6. Detection/containment failure answers a different causal question

The dual-question test from the causal-depth protocol matters:

1. Why did the initiating adverse event occur?
2. Why did it progress far enough to create this broader effect?

Example:

```text
bug introduced
→ unit test misses
→ review misses
→ production monitor misses
→ user harm
```

For explanandum `bug introduced`, later detection failures are not causes.

For explanandum `user harm`, they can be causal contributors to progression/severity.

Therefore causal role depends on **which exact effect is being explained**.

This is strong evidence against promoting `Detection Failure` as a universal sibling child.

## 7. Systemic/framing cause is not a metaphysically deeper kind

Systemic explanations can include:
- architecture choice;
- incentive structure;
- organizational resource decision;
- recurrent assumption;
- governance framing;
- capability gap;
- interaction among subsystems.

WHO and MIT systems-safety pressure show why stopping at individual error is often inadequate.

But `systemic` is:
- boundary-relative;
- scale-relative;
- intervention-relative;
- often composed of several causal contributors.

A condition can be systemic for one inquiry and proximate for another higher-level inquiry.

Therefore:

```text
systemic cause
!= universal top/deepest cause class
```

It is a causal-depth/profile notion.

## 8. Necessary and sufficient are orthogonal causal properties, not depth layers

Causal logic can distinguish:
- necessary cause;
- sufficient cause;
- necessary component of a sufficient set;
- independently sufficient causes;
- contributing but neither necessary nor sufficient factor.

These properties cut across proximate/systemic/prevention roles.

Example:

```text
A and B together sufficient for E
A not sufficient alone
B not sufficient alone
```

or overdetermination:

```text
A sufficient for E
B independently sufficient for E
A and B both occur
```

A simple but-for test can fail to classify either A or B as necessary even though both are genuine causal candidates in the actual episode.

Therefore:

```text
but-for necessity
!= universal definition of causal contribution
```

## 9. Multiple causes are not an exception case

NTSB material explicitly allows multiple causes/contributing factors without requiring one primary cause. WHO patient-safety material likewise emphasizes multiple interrelated contributors.

Foundation requirement:

```text
one realized effect
→ may have several causal contributors
```

The model must permit:
- joint causation;
- interacting contributors;
- redundant/sufficient contributors;
- mitigating and aggravating contributors;
- causal chains and networks.

Do not force:

```text
root_cause = one value
```

## 10. Omission / failure-to-prevent needs causal qualification

An omission claim has a special risk:

```text
X did not happen
→ therefore absence caused E
```

This is too easy to overgenerate because infinitely many absent events can be imagined.

A decision-useful omission/failure-to-prevent claim generally needs some combination of:
- relevant expected/preventive function;
- feasible alternative action/state;
- mechanism showing how presence would have changed the trajectory;
- counterfactual/intervention support;
- established causal role in the system.

Yet causal relevance must remain separate from normative obligation:

```text
barrier absent and causally relevant
!= Actor had duty to install/activate barrier
```

This keeps Causal Effect separate from Actors/Control.

## 11. Mitigation/prevention can itself be causal

Causal analysis is not only about harmful contributors.

A factor can:
- prevent an effect;
- reduce its probability;
- reduce severity;
- delay progression;
- contain propagation.

Thus causal role vocabulary should permit negative/reducing effects where material.

This becomes important for control effectiveness:

```text
control causally reduced risk/severity
```

is a causal-effect claim even when the adverse event still occurred.

## 12. Why the role taxonomy does not become children

Tested split:

```text
Direct / Proximate Cause
Contributing / Enabling Condition
Prevention Failure
Detection / Containment Failure
Systemic / Framing Cause
```

Rejected as immediate children because:
1. roles overlap on the same contributor;
2. role changes with the exact effect/explanandum;
3. depth changes with chosen boundary/scale;
4. some domains lack prevention/detection control structures;
5. necessary/sufficient/probabilistic properties cut across all roles;
6. a causal chain can move one contributor through several roles at different resolutions.

They remain a **causal-analysis role set/checklist**, not sibling populations.

## 13. Strong causal-depth grammar

A useful bounded depth analysis can ask:

```text
Exact effect E
├─ immediate/direct mechanism(s)
├─ enabling/contributing conditions
├─ prevention/barrier failures where relevant
├─ detection/containment failures where relevant
└─ deeper systemic/framing conditions where they materially change intervention/recurrence analysis
```

This is not a mandatory hierarchy and not every branch must exist.

## 14. Stop rule

Causal analysis should stop when one further level no longer materially changes:
- what intervention would be chosen;
- recurrence-risk estimate;
- prevention/detection control design;
- responsibility boundary;
- or decision outcome.

This prevents both shallow proximate-cause closure and infinite `why` regress.

## 15. E2 conclusion

The recurring roles are decision-critical but do **not** form stable immediate children.

The strongest current view is:

> Causal Effect / Contribution is one coherent region with overlapping causal-role and depth profiles centered on an exact realized effect.

E3 must now attack the harder epistemic question: what kinds of evidence can justify these causal claims, when counterfactual reasoning is necessary, and how competing explanations/overdetermination should be preserved.