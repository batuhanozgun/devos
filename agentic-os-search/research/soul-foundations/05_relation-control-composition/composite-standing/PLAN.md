# Composite Standing / Qualification — Research Plan

**Status:** active child-pass plan  
**Date:** 2026-09-05

## Objective

Research Foundation semantics for **multi-anchor standings / qualifications** that arise only when several ground facts, bindings, criteria and reference conditions are evaluated together.

The aim is not to create a universal status enum or state machine. The aim is to discover:

- what makes a standing semantically complete and decision-usable;
- which inputs/anchors are essential;
- when a standing is current, stale, unknown, partial or invalid;
- which recurring standing families are truly distinct;
- where Composite Standing ends and Binding, Control or Transition begins.

## Core constraints

### 1. Standing != recorded label

For every candidate standing ask:
- what exactly is being qualified?
- relative to which criterion/threshold/use/reference frame?
- what evidence or facts support the evaluation?
- what target/version/state/time does it concern?
- who/what supplies authority or evaluation mandate when that matters?
- what Environment conditions or Work method/path are prerequisites?
- what is the result domain: boolean, ordinal, scalar, categorical, interval, uncertain, unknown?
- what changes would invalidate the result?

### 2. Binding is prerequisite, not conclusion

Correct bindings identify the relevant anchors. They do not by themselves establish that a composite standing holds.

### 3. Standing != Control

`authorized`, `eligible`, `compliant`, `ready` or `accepted` may influence or constrain action, but this pass studies the **standing/evaluation semantics**. Rules, permissions, obligations, gates and enforcement belong to Control when the protected question is what transition is allowed/required/blocked.

### 4. Standing != Transition

A standing can change because inputs/conditions change, but this pass does not own the event/causal propagation history. It studies what must be true for the standing to hold at a reference point.

### 5. No architecture / ontology leakage

Do not infer:
- status columns;
- workflow states;
- rule engines;
- decision tables;
- scoring services;
- graph/materialized-view design;
- caching/invalidation implementation.

Formal standards may pressure semantics but cannot define the project taxonomy by representation choice.

## S0 — Canonical / evidence recovery

Recover:
- accepted Binding bounded-leaf result/signature;
- parent C3 multi-ground hard cases and residual questions;
- relevant ground deferred relation/open-question surfaces;
- candidate-study catalog and selected META surfaces only when decision-relevant;
- exact current manifests.

Output:
- evidence inventory;
- live standing hypotheses;
- explicit boundary/upstream falsifiers.

## S1 — Standing object / minimum semantic signature

Attack the idea that a standing is adequately specified by `subject + status`.

Candidate dimensions:
- qualified subject/target/claim/action/Work/Actor/condition;
- standing meaning / protected evaluation question;
- criterion / requirement / threshold / norm / intended use;
- exact target/version/state/reference frame;
- evidence/facts/bindings used;
- evaluator/source/authority/forum when semantically material;
- method/procedure/model used to evaluate when material;
- effective/reference time and validity/currentness;
- uncertainty/confidence/coverage/partiality;
- result domain and decision threshold;
- lineage of evaluation/standing assertion where needed for source-view fidelity.

Classify dimensions as:
- universal core;
- conditional standing-family dimensions;
- neighbouring Binding/Control/Transition semantics.

## S2 — Standing-family discovery across hard cases

Required families/cases:

1. **Readiness / Support / Actionability**
   - Work ready/supported/blocked;
   - Actor actionable now;
   - technically possible vs authorized vs reachable effect power.

2. **Verification / Validation / Acceptance / Conformance**
   - verified against requirement;
   - validated / fit for intended use;
   - accepted by authorized party;
   - compliant/conforming relative to explicit criterion.

3. **Goal / Outcome / Satisfaction / Attainment**
   - sought/desired condition;
   - realized Environment condition;
   - criterion satisfaction;
   - authorized acceptance distinct from attainment.

4. **Epistemic / Evidential Sufficiency**
   - evidence sufficient for claim/decision;
   - source authoritative/reliable enough for use;
   - current/relevant enough for purpose.

5. **Eligibility / Applicability / Authorization Standing**
   - eligible under criteria;
   - applicable to scope/time/population;
   - authorized for operation/context as an evaluated standing, while control semantics remain separate.

6. **Risk / Priority / Fitness** only if they expose materially distinct standing semantics rather than evaluation specialization.

For each identify:
- exact semantic question;
- required anchors;
- failure modes;
- result domain;
- boundary with Binding/Control/Transition;
- whether it deserves child status or remains profile/specialization.

## S3 — Evaluation logic / truth-value / uncertainty / invalidation audit

Hard problems:
- boolean vs graded/thresholded standing;
- `false` vs `unknown` vs `not evaluated` vs `not applicable`;
- partial satisfaction / coverage;
- conflicting evidence;
- uncertainty/confidence;
- criterion ambiguity/change;
- target/version drift;
- source/evidence freshness;
- authority/role change;
- Environment condition drift;
- evaluation-method/version change;
- stale materialized/recorded standing after underlying facts change.

Required non-collapse:

```text
standing false
!= standing unknown
!= standing not evaluated
!= standing not applicable

record says standing X
!= standing X currently holds
```

Determine whether invalidation/currentness is a universal standing property or only a transition concern.

## S4 — Rival internal decompositions / child discovery pressure

Test serious alternatives:
- one bounded Standing leaf with shared signature + profiles;
- Readiness/Actionability vs Assurance/Acceptance vs Epistemic Sufficiency vs Goal Attainment;
- descriptive/epistemic vs normative/institutional standings;
- feasibility vs assurance vs acceptance;
- intrinsic vs relational vs composite standing;
- binary vs graded/uncertain standings;
- criterion-relative vs authority-relative vs use-relative children;
- family-first split based on Verification/Actionability/Goal/Eligibility.

Compare on:
- protected-question clarity;
- failure-mode distinctness;
- cross-domain stability;
- false disjointness;
- overlap;
- residual bucket size;
- boundary preservation;
- architecture neutrality.

## S5 — Authoritative external / candidate-study holdouts

Use materially different authoritative traditions to attack live hypotheses.

Likely holdouts:
- NASA systems engineering verification vs validation;
- NIST ABAC authorization decision inputs/attributes/environment conditions;
- NIST AI RMF or related risk/measurement material if graded/context-relative standing becomes load-bearing;
- metrology/VIM for result, uncertainty, measurement result and criterion-relative interpretation;
- ISO/NIST conformance/compliance material only if current and authoritative enough to distinguish conformity from acceptance;
- medical diagnostic/test or evidence-grading traditions only if they expose a genuinely different standing structure.

Candidate studies:
- Anthropic AI-native SDLC — gates, verification evidence, environment-specific autonomy, evaluation of configuration;
- multi-agent patterns — verifier/critic/acceptance role separation;
- context-memory-harness — context sufficiency/currentness and persistence-vs-use distinctions;
- ai-knowledge-strategies — evidence/retrieval sufficiency and source-universe pressure where material.

External traditions pressure the model; they do not become the taxonomy.

## S6 — Synthesis / immediate-child decision

Determine whether Composite Standing is:

### Outcome A — bounded leaf
No stable child split; preserve one semantic signature plus standing-family profiles.

### Outcome B — bounded parent with stable children
Promote only families with distinct protected questions, failure modes and cross-domain stability.

### Outcome C — boundary correction
Revise Standing boundary relative to Binding/Control/Transition.

### Outcome D — upstream falsifier
Reopen minimum affected Binding/parent/ground adequacy research.

## S7 — Adversarial closure

Attack the result by trying to show:
- standing is only a relation/predicate and does not need a research region;
- all standings can be localized as ground-local attributes;
- result domains/uncertainty are implementation detail;
- unknown/not-evaluated/not-applicable distinctions are unnecessary;
- invalidation/currentness belongs wholly to Transition;
- `verified`, `authorized`, `accepted`, `ready`, `sufficient` are too domain-specific for shared semantics;
- one proposed child is actually a Control problem;
- one proposed child is only an Information standing;
- one important family was omitted;
- a better internal decomposition exists;
- the result smuggles rule-engine/status-model architecture.

Verification must distinguish same-model adversarial review from independent replication.

## Closure boundary

Return Composite Standing / Qualification for user evaluation before activating any grandchild or another composition child.