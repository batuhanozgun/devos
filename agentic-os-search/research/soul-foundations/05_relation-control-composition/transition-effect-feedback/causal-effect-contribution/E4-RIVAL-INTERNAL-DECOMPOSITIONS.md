# Cross-Ground Causal Effect / Contribution — E4 Rival Internal Decompositions

**Status:** COMPLETE / ONE STRONG RIVAL SURVIVES TO EXTERNAL HOLDOUT  
**Date:** 2026-09-06

## 1. Objective

Attack the provisional one-region / bounded-leaf hypothesis using competing internal decompositions.

Tested candidates:
1. Proximate / Contributing / Control-Failure / Systemic;
2. Positive Causation / Omission-Failure-to-Prevent;
3. Mechanistic / Interventionist-Counterfactual / Statistical;
4. Cause / Prevention / Detection;
5. Effectiveness / Root Cause / Attribution;
6. **Actual Episode Causation / General-Interventional Causal Effect**;
7. one bounded causal grammar with all of the above as profiles.

## 2. Rival A — Proximate / Contributing / Control-Failure / Systemic

```text
Causal Effect
├─ Proximate Cause
├─ Contributing Conditions
├─ Prevention/Detection Failure
└─ Systemic Cause
```

### Why attractive

This matches many incident/root-cause workflows and the project's R06 causal-depth protocol.

### Why it fails as child hierarchy

- roles overlap;
- the same factor changes role with explanandum/boundary;
- `systemic` is scale/depth-relative;
- prevention/detection requires a control/barrier framing not present in all domains;
- necessary/sufficient/probability-amplifying properties cut across roles.

**Disposition:** useful causal-role checklist, not immediate children.

## 3. Rival B — Positive Causation / Omission or Failure-to-Prevent

```text
Causal Effect
├─ Positive / Production Causation
└─ Omission / Failure-to-Prevent
```

### Why attractive

Omission claims have special semantics and overgeneration risk.

### Why it fails as universal split

- prevention failures are often simultaneously enabling conditions;
- “absence” becomes causally meaningful only relative to system function/contrast;
- the same causal model can include both production and prevention paths;
- normative duty/obligation must remain outside causal identity;
- many domains do not need omission analysis.

**Disposition:** retained profile/claim type, not child.

## 4. Rival C — Mechanistic / Counterfactual-Interventionist / Statistical

```text
Causal Effect
├─ Mechanistic Causation
├─ Counterfactual / Interventionist Causation
└─ Statistical / Epidemiologic Causation
```

### Why attractive

These traditions use different methods and evidence.

### Why it fails

They are **methods/evidence frames**, not disjoint protected questions.

One causal claim can legitimately use all three:
- mechanism explains pathway;
- intervention demonstrates manipulability;
- statistical analysis estimates magnitude/confounding-adjusted effect.

A hierarchy by method would make methodological pluralism look like different causal phenomena.

**Disposition:** reject as children.

## 5. Rival D — Cause / Prevention / Detection

Rejected because:
- prevention and detection failures can be causes/contributors to a broader effect;
- categories depend on which stage/effect is selected;
- they duplicate Control profile language;
- no stable partition survives.

## 6. Rival E — Effectiveness / Root Cause / Attribution

Rejected because:
- control effectiveness is a Causal Effect + Standing profile;
- root cause is a depth/adequacy claim, not a separate population;
- attribution can be causal or merely provenance/responsibility and belongs partly to Binding/Actors.

## 7. Rival F — Actual Episode Causation / General-Interventional Causal Effect

This is the **strongest surviving rival**.

Provisional structure:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation
└─ General / Interventional Causal Effect
```

These labels are provisional; the protected questions matter more than names.

### Child candidate 1 — Actual Causal Contribution / Episode Causation

Protected question:

> In this exact realized episode/effect, which actual events, conditions, omissions, controls or actions were causal contributors to what occurred?

Typical failure family:
- chronology mistaken for actual cause;
- hindsight narrative;
- first trigger treated as full explanation;
- one root forced despite joint/redundant contributors;
- prevention/detection/systemic contributors omitted;
- causal contribution confused with blame/responsibility.

Typical evidence:
- event/condition reconstruction;
- mechanism;
- physical/digital traces;
- fault reproduction;
- barrier analysis;
- actual-cause counterfactuals;
- elimination of alternatives;
- domain theory.

Corrective/recovery work when uncertain:
- deeper incident investigation;
- reproduce/fault-inject;
- inspect additional evidence;
- test alternative mechanisms;
- revise causal graph/explanation;
- redesign prevention/detection based on causal layer.

### Child candidate 2 — General / Interventional Causal Effect

Protected question:

> Across a specified population/context/unit set, how would changing an exposure/action/control X change an outcome Y relative to a defined alternative/baseline?

Typical failure family:
- association/correlation mistaken for causal effect;
- confounding/selection/information bias;
- wrong causal contrast;
- intervention differs from intended treatment;
- average effect applied to wrong individual/context;
- transport/external-validity error;
- interference/spillover ignored;
- before/after trend treated as effectiveness proof.

Typical evidence:
- randomized intervention;
- controlled experiment/fault injection;
- natural experiment;
- quasi-experiment;
- observational causal inference;
- confounding adjustment;
- repeated comparative evidence;
- mechanism/transportability support.

Corrective/recovery work when uncertain:
- improve study/experiment design;
- define causal contrast;
- collect comparison/covariate data;
- address confounding/selection;
- test intervention fidelity;
- bound transportability/context.

## 8. Why this split is structurally different from method-based splits

The two candidates ask **different protected questions**, even if they use overlapping methods.

Example:

```text
Drug D reduces mortality on average in population P
```

is a general causal-effect claim.

It does not by itself establish:

```text
Drug D caused this particular patient's recovery
```

Likewise:

```text
Configuration defect X caused this outage
```

is an actual-episode claim.

It does not automatically establish:

```text
removing X reduces outage rate across all deployments/populations by amount Y
```

Thus:

```text
general causal effect
!= actual episode causation
```

## 9. Distinct semantic anchors

### Actual episode causation emphasizes
- exact realized episode/effect;
- actual contributor occurrence;
- actual causal path/set;
- episode-specific context;
- overdetermination/joint contribution;
- causal depth for recurrence/intervention.

### General/interventional causal effect emphasizes
- treatment/exposure/action definition;
- alternative/baseline intervention;
- unit/population/context;
- outcome definition;
- effect magnitude/distribution where relevant;
- confounding/selection/transport assumptions.

There is overlap, but removal tests change meaning materially.

## 10. Can one safely reduce to the other?

### Reduce actual causation to general effect?

No.

A factor can have a positive average causal effect yet not have caused one specific episode, and episode-level overdetermination/actual context can matter.

### Reduce general effect to many actual causes?

No.

A collection of episode narratives does not by itself identify the counterfactual population effect because selection/confounding/comparison design may be missing.

Thus the two questions are not merely different evidence levels for one identical proposition.

## 11. Is the split universal enough?

Current pressure says **possibly yes**, but E5 must decide.

Cross-domain recurrence:
- accident/mishap investigation → actual causation;
- epidemiology/policy/control evaluation → general causal effect;
- software incident → actual causation;
- regression experiment/eval → general intervention effect;
- safety barrier failure in one event → actual causation;
- safety control risk reduction across operations → general effect.

The two can co-occur in one program but remain diagnostically distinct.

## 12. What remains cross-cutting if promoted

Across both candidates:
- exact effect/outcome;
- causal contrast;
- mechanism/evidence;
- alternatives/confounding;
- confidence;
- causal role/depth;
- context/time;
- multi-cause interaction.

These do not become third children.

## 13. E4 provisional judgment

Most rival splits fail.

One split remains serious enough that bounded-leaf closure is **not justified yet**:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation       ← candidate
└─ General / Interventional Causal Effect                ← candidate
```

E5 must pressure this split using independent traditions rather than confirming it from internal reasoning alone.