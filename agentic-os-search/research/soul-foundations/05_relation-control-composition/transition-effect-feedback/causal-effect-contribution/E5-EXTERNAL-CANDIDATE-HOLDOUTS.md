# Cross-Ground Causal Effect / Contribution — E5 Authoritative External + Candidate Holdouts

**Status:** COMPLETE / TWO-CHILD SPLIT SURVIVES EXTERNAL HOLDOUT  
**Date:** 2026-09-06

## 1. Objective

Pressure-test the E4 candidate split using independent traditions:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation
└─ General / Interventional Causal Effect
```

The goal is not to find a source that publishes this exact Foundation hierarchy. The test is whether materially different domains repeatedly require the two protected questions to remain distinct and whether any third/fourth child becomes necessary.

## 2. Statistical causality — explicit distinction between two problem areas

A. Philip Dawid and Monica Musio's 2022 Annual Review article explicitly contrasts:
- **effects of causes** — likely effects of interventions;
- **causes of effects** — whether an observed exposure/intervention caused an outcome in an individual case.

Their review treats these as distinct causal problem areas and compares multiple formalisms for each.

This is strong independent pressure because it matches the E4 split at the **question level**, not merely at method level.

Foundation translation:

```text
What would X do to Y?
!=
Did X cause this observed Y?
```

The exact formal claims in that literature are not imported as Foundation requirements, but the distinction itself is load-bearing.

## 3. NASA mishap investigation — episode causation

NASA mishap material is centered on realized incidents/close calls and asks investigators to reconstruct:
- events and conditions;
- timelines;
- cause-and-effect relationships;
- barriers/controls;
- Event and Causal Factor Trees;
- root/proximate/contributing factors.

NASA also states that not every investigation necessarily finds a root cause.

This strongly instantiates **Actual Causal Contribution / Episode Causation**:

> Given this realized mishap, what actual factors contributed to it and what must change to prevent recurrence?

It does not primarily estimate a general population treatment effect.

## 4. NTSB investigation — episode causation with multiple factors

NTSB's investigative process separates fact gathering, sequence reconstruction, causal analysis and probable-cause determination.

Historical NTSB causal guidance explicitly allows several causes/contributing factors and ties their value to actionable prevention of recurrence.

Pressure:

```text
one realized accident
→ can have multiple actionable actual causal contributors
```

Again, this is an episode-causation problem.

## 5. FAA root-cause / causal-factor practice — episode causation plus recurrence relevance

FAA guidance warns that fixing only the proximate cause increases recurrence risk and instructs causal analysis to identify circumstances/factors leading to an anomaly while eliminating unsupported candidates.

This reinforces:
- actual incident explanandum;
- multiple contributors;
- causal-depth stopping by corrective-action relevance.

It does not force one root cause or one depth taxonomy.

## 6. CDC field epidemiology — general causal effect / causal association

CDC material explicitly separates association from causal effect and analyzes whether exposure changes disease/outcome risk across a population.

Relevant pressures:
- measures of association are not causal by identity;
- chance, selection bias, information bias and confounding can produce spurious associations;
- temporality/plausibility/consistency and intervention evidence affect causal confidence;
- causal assessment guides public-health interventions.

This strongly instantiates **General / Interventional Causal Effect**:

> Across a relevant population/context, does changing exposure/action X change outcome Y, and by how much/under what conditions?

This is distinct from asking whether X caused one particular person's outcome.

## 7. NIST control effectiveness — general effect pressure

NIST defines control effectiveness in terms of whether a control **contributes to the reduction of security/privacy risk**.

This is not exhausted by:
- control exists;
- control implemented correctly;
- control was complied with.

Foundation pressure:

```text
control effectiveness
→ requires causal contribution to risk/outcome reduction
```

The natural default is a **general/interventional causal-effect** question:

> Does introducing/maintaining this control reduce relevant risk/outcomes across its governed context?

A specific incident can still create an episode-causation variant:

> Did this exact control prevent or mitigate this exact effect?

Thus the split clarifies two different control-effectiveness questions rather than fragmenting Control itself.

## 8. WHO patient safety — multi-factor episode causation and system-level contributors

WHO states that patient harm commonly involves multiple interrelated factors and emphasizes a systems approach rather than blaming one individual.

This pressures Actual Causal Contribution to preserve:
- human action;
- system/process conditions;
- technological factors;
- organizational conditions;
- external factors;
- multiple contributors.

It also confirms the Actors boundary:

```text
causal factor
!= blame / negligence by identity
```

## 9. MIT CAST/STPA tradition — systemic causality without single-root reduction

MIT's CAST material explicitly warns against oversimplified root-cause framing, hindsight bias and blame-centered models.

CAST is primarily retrospective incident/accident analysis, while STPA is prospective hazard/control analysis.

This combination is useful pressure:
- retrospective actual-cause explanation and prospective causal-risk/control reasoning are related;
- they are not one identical question;
- systems-level causal structure can inform both without becoming a third child.

## 10. General causal effect does not imply actual episode cause

External/statistical literature makes this distinction explicit.

Example:

```text
Control C reduces incident probability from 10% to 4% across population P
```

can be true while, in one observed incident where C was present:
- C may have mitigated severity;
- C may have failed;
- C may have been causally irrelevant;
- another sufficient path may have produced the outcome.

Therefore:

```text
general causal effect
!= actual causal contribution in this episode
```

## 11. Actual episode cause does not imply general effect magnitude

Suppose investigation establishes:

```text
configuration defect X caused outage O in episode e
```

This does not by itself identify:
- how often X causes outages across deployments;
- whether removing X reduces outage risk materially at population scale;
- effect magnitude under different environments;
- whether another failure mode replaces it.

Therefore:

```text
actual episode causation
!= general causal-effect estimate
```

## 12. Candidate-study holdout — Anthropic AI-native SDLC

The project candidate study contains a useful two-question episode:

```text
production incident / control failure
→ investigate why this incident occurred
→ introduce permanent eval/control/configuration change
→ observe future behavior/outcomes
```

This naturally separates:

### Question A — actual episode causation

> What caused/contributed to the specific incident?

### Question B — general/interventional effect

> Does the new eval/control/configuration materially reduce recurrence or change future outcome distribution?

The candidate therefore pressures the split without becoming taxonomy authority.

Critically:

```text
incident followed by guardrail
and later fewer incidents
!= guardrail causal effectiveness automatically established
```

Confounding/task-mix/model/version/reporting changes can remain alternatives.

## 13. gstack candidate decision

`gstack` is currently an active/high-freshness study. Its implemented review/QA/ship/eval/feedback mechanisms could later provide concrete causal-effect examples, but authoritative sources already discriminate the structural hypothesis.

Therefore gstack is **not made load-bearing** in E5.

## 14. Does a third child emerge?

Tested candidates from external pressure:

### Systemic Causation
No. Systemic is depth/boundary-relative and appears inside actual causation and general intervention reasoning.

### Causal Mechanism / Structure
No. Mechanism is explanatory/evidential structure used by both children.

### Control Effectiveness
No. It is a profile that can ask either actual or general causal questions, then produce a Standing.

### Causal Attribution / Responsibility
No. Causal attribution remains inside causal analysis; normative responsibility/accountability remains Actors-facing.

### Causal Evidence / Confidence
No. Cross-cutting epistemic dimension consumed by Standing.

### Prevention / Detection Failure
No. Episode/general causal roles that overlap with Control profiles.

No stable third immediate child survives.

## 15. Does Causation need promotion to a fifth composition sibling?

Current answer: **no**.

Both promoted candidate questions require an effect/outcome/transition target:

```text
actual causation
→ exact realized effect from Transition/Propagation

general causal effect
→ defined outcome transition/standing distribution under alternative interventions
```

Causal Effect therefore remains naturally nested under `Transition / Effect / Feedback` rather than becoming a peer of Binding/Standing/Control/Transition.

No external holdout requires independent causal composition when no effect/change/outcome semantics are present.

## 16. External holdout verdict

The E4 split survives and strengthens:

```text
Cross-Ground Causal Effect / Contribution
├─ Actual Causal Contribution / Episode Causation
└─ General / Interventional Causal Effect
```

The two regions have:
- different protected questions;
- different characteristic failure modes;
- different typical evidence designs;
- different corrective research/Work when uncertain;
- cross-domain recurrence;
- no safe reduction into one another.

No third child or upstream reopen is currently forced.

Proceed to E6 synthesis / promotion decision.