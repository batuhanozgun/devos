# Actual Causal Contribution / Episode Causation — A3 Evidence / Competing Explanations / Confidence

**Status:** COMPLETE  
**Date:** 2026-09-06

## 1. Objective

Determine what evidential discipline actual-episode causation needs, specifically distinct from general/interventional causal-effect estimation.

## 2. Factual reconstruction is prerequisite evidence, not causal proof

Investigations often reconstruct:
- actual events;
- state changes;
- actions;
- timing;
- configurations;
- control/barrier states;
- observations/logs/physical traces.

This is essential.

But:

```text
high-confidence timeline
!= high-confidence causal explanation
```

Several causal structures can produce the same observed sequence.

## 3. Provenance/trace evidence answers different questions

A trace can strongly establish:

```text
Actor/tool X invoked operation O
operation O preceded transition T
artifact A was derived from B
```

It does not by identity establish:

```text
X caused protected effect E
```

The causal path can include:
- irrelevant intermediate actions;
- common causes;
- preempted routes;
- redundant routes;
- missing/hidden environment conditions.

Therefore:

```text
provenance / sequence
!= actual causation
```

## 4. Direct physical/digital mechanism evidence

Mechanism evidence is especially strong when it demonstrates that the exact episode states connected through a known causal path.

Examples:
- fracture surface + load path;
- crash branch + exact malformed input;
- access path + exact credential/permission state;
- hazardous energy transfer + absent barrier.

But distinguish:

```text
mechanism can produce E
!= mechanism actually produced E in episode e
```

Actual-operation evidence is stronger than mere mechanism plausibility.

## 5. Reproduction / fault injection / removal

Reproducing the effect under the episode conditions can strongly discriminate mechanisms.

Useful questions:
- Does reintroducing X reproduce E?
- Does removing X prevent E under otherwise relevantly similar conditions?
- Does changing only the candidate path alter the effect?

Yet:

```text
reproduction proves capability/plausibility
!= exact historical causation automatically
```

Differences in hidden state, timing, workload, environment or interactions can remain.

The closer the reproduction matches decision-critical episode conditions and traces, the stronger the actual-cause pressure.

## 6. Intervention/removal evidence can be episode-relevant without becoming the sibling child

A post-incident removal/intervention can test an episode hypothesis.

Example:

```text
remove suspected configuration defect
→ exact failure no longer reproduces
```

This can support actual causation.

But estimating how that intervention changes outcomes across a population/context is the sibling `Contrastive / Interventional Causal Effect` problem.

Thus:

```text
intervention as evidence for episode cause
!= general intervention-effect research
```

## 7. Barrier/control analysis

For prevention/detection/containment claims, evidence should discriminate:
- whether the barrier/control was applicable;
- its actual episode state;
- whether the harmful causal path reached it;
- whether correct operation would have changed the trajectory;
- whether another route would still have produced the effect.

Therefore:

```text
barrier defective
!= barrier defect caused E
```

Actual path relevance matters.

## 8. Competing explanations must be preserved

A causal explanation can fit all current evidence while another explanation also fits.

Example:

```text
H1: config drift caused timeout
H2: network degradation caused timeout
H3: interaction of both caused timeout
```

If observations cannot discriminate them, Foundation-safe result is not forced selection.

Possible result:

```text
actual cause unresolved among {H1, H2, H3}
```

with discriminating tests/evidence requests retained.

## 9. Evidence should be judged by discriminating power

Supporting evidence is not enough if it is also expected under competing explanations.

Stronger evidence:
- is unlikely under serious alternatives;
- directly observes the proposed path;
- reproduces/removes the effect under relevant conditions;
- detects evidence predicted only by one mechanism;
- rules out alternative sufficient routes.

Thus the key question is:

> What does this evidence discriminate, not merely what story can cite it?

## 10. Counterfactual reasoning remains useful but non-universal

Actual-cause analysis often asks:

```text
If X were absent/different in this episode-relevant contingency,
would E or its severity/timing differ?
```

But overdetermination/preemption can defeat naive but-for tests.

Counterfactual reasoning must therefore be sensitive to:
- relevant contingency;
- alternative sufficient routes;
- preemption;
- joint causal sets;
- exact explanandum.

No one formal counterfactual model is mandated.

## 11. Negative evidence requires observation-coverage discipline

Absence of an expected log/trace can discriminate a mechanism only if the observation process was capable of seeing it.

```text
no trace observed
!= event/path absent
```

when instrumentation/selection/retention is incomplete.

This creates a causal frame-blindness guardrail:

```text
all observed evidence explained
!= all material causal paths observed
!= causal model complete
```

## 12. Missing evidence can itself be caused by the incident/system

Incident conditions can disable telemetry, corrupt records or select which evidence survives.

Therefore evidence missingness may be causally informative, but it can also create bias.

Do not treat:

```text
missing record
```

as simple neutral absence.

Information Selection/Exposure and Environment failure can shape the investigation evidence surface.

## 13. Confidence is claim-specific

Possible qualitative outcomes include:
- actual causal contribution strongly established;
- best-supported/probable causal contribution;
- plausible contributor;
- causal role established only as part of a joint set;
- competing explanations unresolved;
- insufficient evidence.

No universal labels or numeric confidence metric are required.

Key non-collapse:

```text
confidence in contributor presence
!= confidence in its causal role
!= confidence that causal model is complete
```

## 14. Completeness is itself difficult

Even if every proposed cause is well supported, the explanation can still be incomplete.

```text
all identified contributors supported
!= all material contributors identified
```

Completeness depends on causal search/frame coverage and may legitimately remain unknown.

This parallels the earlier propagation guardrail:

```text
all known targets updated
!= all material targets known
```

## 15. Evidence sufficiency routes to Standing

Actual causation owns:
- exact causal claim;
- causal structure;
- evidence relevant to distinguishing it;
- alternatives/uncertainty.

Composite Standing can answer:

```text
causal explanation sufficiently supported for corrective action?
investigation sufficiently complete for closure criterion C?
```

Do not collapse those into causal truth.

## 16. No universal evidence ladder

Rejected:

```text
physical evidence > reproduction > logs > expert judgment
```

as a universal hierarchy.

Claim-method fit and discriminating power matter more.

A direct deterministic trace can dominate in one domain; a controlled reproduction can dominate another; a multi-source investigative reconstruction can be best available in a third.

## 17. A3 conclusion

Actual-cause epistemics can remain bounded without becoming general epistemology if centered on:

```text
exact episode effect
+ candidate actual causal structure
+ evidence that discriminates competing structures
+ observation/frame coverage awareness
+ calibrated unresolved alternatives
```

Strongest new guardrail:

```text
causal story supported by evidence
!= serious alternatives discriminated
!= causal explanation complete
```

Proceed to A4 rival internal decompositions.
