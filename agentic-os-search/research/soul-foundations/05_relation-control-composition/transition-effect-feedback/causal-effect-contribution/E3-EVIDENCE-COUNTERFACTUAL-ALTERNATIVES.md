# Cross-Ground Causal Effect / Contribution — E3 Evidence / Counterfactual / Competing-Explanation Audit

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Determine what evidential discipline a Foundation-level causal claim requires without creating one universal causal-inference algorithm or evidence hierarchy.

The pass tests:
- temporal evidence;
- association/statistical evidence;
- mechanism evidence;
- intervention/experiment evidence;
- counterfactual reasoning;
- investigative elimination;
- competing explanations;
- confounding/selection;
- multiple sufficient causes/overdetermination;
- causal confidence.

## 2. Temporal precedence is usually necessary but never sufficient by itself

For many ordinary causal claims:

```text
cause precedes effect
```

is a basic eligibility constraint.

But accepted Transition/Propagation already established that event ordering can be complicated by delayed observation and distributed timing.

More importantly:

```text
A before B
!= A caused B
```

A may precede B because:
- both share a common cause;
- A is merely correlated with the real cause;
- A is a marker/record;
- B was already determined by an earlier process;
- the apparent ordering is observation-order rather than occurrence-order.

Temporal evidence therefore filters candidates; it does not establish causal effect alone.

## 3. Association is evidence pressure, not causal identity

CDC explicitly preserves the distinction:

```text
statistical association
!= cause-and-effect association
```

Observed association can arise from:
- chance;
- selection bias;
- information/measurement bias;
- confounding;
- analysis/investigator error;
- or a real causal effect.

This generalizes beyond epidemiology.

Agent/system example:

```text
incidents lower after new guardrail
```

can be explained by:
- guardrail causal effect;
- lower workload;
- different task mix;
- newer model release;
- unrelated infrastructure change;
- reporting change;
- regression to mean;
- random fluctuation.

Therefore before/after improvement does not prove intervention effectiveness.

## 4. Mechanism evidence can be strong but is not self-sufficient in every case

Mechanistic evidence answers:

> Through what process could contributor X change effect Y?

Examples:
- thermal expansion physically jams a component;
- permission check blocks the only reachable write path;
- malformed input takes a parser into a crashing branch;
- missing barrier allows hazardous energy transfer.

Mechanism can be especially strong when:
- physical constraints are well understood;
- the mechanism is observed/reproduced;
- competing routes are excluded;
- changing/removing the contributor predictably changes the effect.

But:

```text
plausible mechanism
!= mechanism actually operated in this episode
```

and:

```text
mechanism exists
!= contributor materially changed population-level outcome under all contexts
```

Thus mechanism is one evidential mode, not a universal proof token.

## 5. Intervention/experiment evidence directly pressures causal effect

Intervention evidence asks what changes when the candidate contributor/exposure is deliberately altered while relevant alternatives are controlled or randomized.

This is particularly strong for claims such as:

```text
changing X changes distribution/probability/value of Y
```

Randomization can reduce confounding in population causal-effect questions.

Yet Foundation must retain limits:
- intervention may target a proxy rather than the true causal variable;
- treatment implementation may differ from intended intervention;
- effects can be context/population-specific;
- interference/spillover can invalidate simple unit assumptions;
- actual-episode causation may remain different from average effect.

Therefore:

```text
experimental average effect
!= complete explanation of one realized episode
```

and:

```text
one successful intervention
!= universal causal invariance across contexts
```

## 6. Counterfactual contrast is central but not one universal syntax

A causal effect asks, explicitly or implicitly:

> What would differ if the candidate contributor/action/state were changed while the relevant comparison were otherwise appropriately defined?

This contrast is essential in many cases because simple co-occurrence cannot tell us whether the contributor made a difference.

However, Foundation must avoid two mistakes.

### Mistake A — require explicit formal counterfactual model everywhere

Some engineering/physical actual-cause cases can be strongly resolved by mechanism, intervention/removal and direct constraints without writing a formal potential-outcomes model.

### Mistake B — treat counterfactual contrast as unnecessary whenever a plausible story exists

Observational, policy and omission claims often cannot be separated from confounding or baseline differences without asking what the relevant alternative trajectory would have been.

Foundation rule:

> Preserve the **causal contrast** conceptually; allow domains to realize it through counterfactual, interventionist, mechanistic or investigative methods appropriate to the claim.

## 7. But-for tests are useful and incomplete

A common actual-cause test asks:

```text
If X had not occurred, would E still have occurred?
```

If `no`, X has strong causal relevance under that contrast.

But overdetermination breaks naive necessity.

Example:

```text
A independently sufficient for E
B independently sufficient for E
A and B both occur
```

Then:
- remove A → B still produces E;
- remove B → A still produces E.

Naive but-for reasoning might classify neither as causal even though both are genuine sufficient contributors.

Therefore:

```text
but-for necessity
!= universal causal criterion
```

Causal analysis must permit redundant/overdetermining contributors and causal sets.

## 8. Multiple sufficient sets and interaction must remain representable

Another pattern:

```text
(A AND B) OR (C AND D) → E
```

A may be:
- necessary within one sufficient set;
- not necessary globally;
- causally relevant only in interaction with B.

Foundation implication:

> A contributor's causal role can be **set-/interaction-relative**.

Do not require every contributor to have an independent scalar effect.

This is important for complex system failures where:
- one software defect;
- one Environment condition;
- one missing Control;
- and one Actor action
may jointly produce an effect none could produce alone.

## 9. Confounding and selection are alternative causal structures, not mere noise

CDC's epidemiologic discipline generalizes to causal analysis:

```text
X associated with Y
```

may be explained by a third factor Z that affects both.

Likewise, selection into observed data can create spurious relationships.

System examples:
- only failed tasks generate detailed logs, distorting apparent cause frequencies;
- high-risk tasks receive both stricter controls and more incidents, making controls appear harmful;
- expert operators handle harder cases, making expertise appear correlated with worse outcomes.

Thus evidence interpretation must ask whether the observation process itself changes the apparent causal relation.

This connects Information Selection/Exposure to causal epistemics without moving causal truth into Information.

## 10. Investigative elimination is a legitimate causal-evidence mode

NASA/FAA/NTSB practices pressure a different evidential form from population inference:
- reconstruct exact event/condition sequence;
- inspect physical/digital evidence;
- identify plausible factors;
- test consistency with evidence;
- eliminate unsupported causes;
- reconstruct barriers/controls;
- seek causes linked to actionable recurrence prevention.

This can produce strong actual-episode causal conclusions even when no randomized experiment is possible.

But investigative elimination must avoid:
- hindsight bias;
- stopping at the first plausible factor;
- assuming missing evidence means absence;
- confusing recorded sequence with cause;
- forcing one root cause.

## 11. Causal confidence must track discriminating power

A causal claim should be stronger only when evidence rules out serious alternatives or directly demonstrates the causal contrast/mechanism.

Possible qualitative states:
- established/strongly supported in the relevant scope;
- probable / best-supported explanation;
- contributing factor with moderate support;
- plausible hypothesis;
- unresolved competing explanations;
- insufficient evidence.

No universal labels are mandated.

Key rule:

```text
confidence in factual timeline
!= confidence in causal explanation
```

A timeline can be certain while causation remains unresolved.

## 12. Evidence sufficiency remains Standing-facing

Causal Effect owns:
- causal claim structure;
- candidate contributors;
- causal roles/depth;
- evidence and alternatives relevant to causation.

Composite Standing owns a criterion-relative conclusion such as:

```text
causal evidence sufficient for corrective action?
control causally effective enough for risk target?
causal explanation verified to required confidence?
```

This preserves:

```text
actual causal relation
!= causal evidence
!= sufficient causal evidence Standing
!= authorized decision based on that Standing
```

## 13. No universal evidence ladder survives

Candidate ladder:

```text
randomized experiment > mechanism > observational association > expert judgment
```

Rejected as universal because evidence relevance depends on causal question:
- physical mechanism evidence may decisively explain a component fracture;
- randomized trial may estimate population effect but say little about one specific accident;
- observational natural experiments can be highly discriminating;
- expert theory can be strong or weak depending on domain maturity;
- direct fault injection may outperform generic statistical evidence for one software mechanism.

Foundation needs **claim-method fit**, not one evidence ranking.

## 14. E3 conclusion

The strongest Foundation-safe causal evidence discipline is:

```text
exact effect
+ explicit/implicit causal contrast
+ domain-appropriate discriminating evidence
+ competing explanations/confounding preserved
+ confidence proportional to exclusion/discrimination power
```

Counterfactual reasoning is conceptually important but not one mandatory formal representation. Mechanism, intervention, statistical inference and investigative elimination are complementary traditions rather than universal hierarchy levels.

Proceed to E4 to test whether the child should split by causal depth, causal role, causal method, omission/positive causation or effectiveness/attribution.