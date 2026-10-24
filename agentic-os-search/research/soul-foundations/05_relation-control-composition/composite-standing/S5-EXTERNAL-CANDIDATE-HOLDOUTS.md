# Composite Standing / Qualification — S5 Authoritative External + Candidate-Study Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Use materially different authoritative traditions and current project candidate studies to attack the leading Composite Standing hypothesis:

```text
cross-ground qualification problem
+ shared semantic signature
+ no immediate child split
```

External sources are falsifiers/counterframes. They do not define the project taxonomy.

## 2. Holdout A — NASA Product Verification

Authoritative source:
- https://www.nasa.gov/reference/5-3-product-verification/
- observed 2026-09-05.

### External structure

NASA Product Verification distinguishes:
- exact product/configuration baseline;
- specified requirements baseline;
- acceptance criteria for each requirement;
- verification plan/procedures/method;
- enabling products/environment;
- recorded objective evidence/results;
- pass/fail declarations and discrepancies;
- a resulting `verified product` standing.

NASA explicitly distinguishes verification from qualification, acceptance and certification.

### Pressure on project model

A bare label:

```text
verified = true
```

is semantically incomplete without at least the target/version and requirement/criterion frame. In assurance-heavy use, evidence/method are also load-bearing.

This strongly supports:
- exact focus/target;
- criterion/reference frame;
- evaluation/access basis;
- result semantics;
- validity dependency on configuration/version.

### Does it force a Verification child?

No. NASA's own material immediately differentiates verification from validation and acceptance by **different qualification questions/reference frames**, while sharing much of the same test/analysis/inspection/demonstration machinery.

This is stronger evidence for one standing grammar plus profiles than for one universal Assurance child.

---

## 3. Holdout B — NASA Product Validation

Authoritative source:
- https://www.nasa.gov/reference/5-4-product-validation/
- observed 2026-09-05.

### External structure

NASA validation asks whether the product fulfills intended use and stakeholder expectations in the intended operational environment.

Inputs/conditions include:
- end product;
- stakeholder expectations / ConOps / measures;
- intended environment;
- users/operators and other resources;
- validation method/procedure;
- evidence/results;
- versions of expectation set, target and tools/equipment.

### Pressure

This directly attacks any model that treats `validated` as a local product attribute.

The meaning depends on:

```text
exact target
+ intended use / stakeholder expectation
+ intended Environment
+ evaluation Work/evidence
(+ user/operator context where material)
→ validation standing
```

### Verification != validation

NASA states verification is requirements/specification-facing while validation is intended-use/stakeholder/environment-facing.

The methods can overlap while the qualification frame changes.

This supports:

```text
same method/evidence family
+ different qualification frame
→ different standing meaning
```

and therefore weakens family-first taxonomy based only on process vocabulary.

---

## 4. Holdout C — JCGM 106 Conformity Assessment

Authoritative sources:
- https://www.bipm.org/en/doi/10.59161/jcgm106-2012
- https://www.bipm.org/documents/20126/2071204/JCGM_106_2012_E.pdf/
- observed 2026-09-05.

### External structure

JCGM 106 explicitly treats:
- an item/entity/object/system;
- specified requirements/tolerance intervals;
- measurement results and uncertainty;
- probability that the true measurand value lies in the conformity region;
- acceptance intervals/decision rules;
- false acceptance and false rejection risk;
- guard bands chosen to control those risks.

### Decisive non-collapse

The source provides perhaps the strongest external support for:

```text
actual conformity standing
!= state of knowledge / conformance probability
!= accept/reject decision under a decision rule
```

An item is either conforming or not under the specification, while uncertainty means the evaluator may only assign a probability; a decision rule can then accept/reject with non-zero error risk.

### Implication

This strongly supports the S3 three-layer distinction:
- object/constitutive standing;
- epistemic assessment;
- decision/recognition outcome.

It also supports `unknown/uncertain` as epistemic rather than necessarily part of the object's value domain.

### Does it force separate children for Conformance/Assessment/Decision?

No. Those are semantic layers within one problem episode and cross immediately into Information/Work/Control when separated as child populations.

---

## 5. Holdout D — VIM measurement result / uncertainty

Authoritative sources:
- https://jcgm.bipm.org/vim/en/2.9.html — measurement result;
- https://jcgm.bipm.org/vim/en/2.26.html — measurement uncertainty;
- https://jcgm.bipm.org/vim/en/2.3.html — measurand;
- observed 2026-09-05.

### Pressure

VIM defines a measurement result as a set of values attributed to a measurand together with other relevant information, and notes that measurement results generally include measurement uncertainty.

This falsifies a naive standing pattern such as:

```text
measurement value
→ criterion comparison
→ certain boolean status
```

Measurement/result Information can itself be uncertainty-bearing and only indirectly support a standing claim.

This reinforces:
- exact target/measurand identity;
- evaluation uncertainty;
- evidence/result != object standing.

---

## 6. Holdout E — NIST SP 800-162 ABAC

Authoritative sources:
- https://csrc.nist.gov/pubs/sp/800/162/upd2/final
- https://www.nist.gov/publications/guide-attribute-based-access-control-abac-definition-and-considerations
- observed 2026-09-05.

### External structure

ABAC authorization is determined by evaluating attributes associated with:
- subject;
- object;
- requested operation;
- sometimes Environment conditions;

against policies/rules/relationships describing allowable operations.

Environment conditions can include dynamic factors such as time/location/threat level.

### Pressure

A bare Actor property:

```text
Actor.authorized = true
```

is not a faithful representation of request-specific authorization semantics.

The evaluation is inherently multi-anchor and context/operation-relative.

### Standing vs Control boundary

ABAC is deliberately an access-control tradition, so it is a good hostile case.

Useful distinction remains:

```text
request is authorized under current attributes/policy  ← evaluated standing/result
policy/rule defines allowable behavior                 ← Control
mechanism grants/denies/enforces access                ← Control/realized enforcement
```

The same source therefore supports Composite Standing **and** prevents it from absorbing Control.

### Child pressure

It does not justify an Authorization child because the exact same standing grammar applies and authorization is tightly coupled to Control sibling semantics.

---

## 7. Holdout F — NASA Technology Readiness Levels

Authoritative sources:
- https://www.nasa.gov/directorates/somd/space-communications-navigation-program/technology-readiness-levels/
- NASA Systems Engineering Handbook appendix material;
- observed 2026-09-05.

### External structure

NASA uses a nine-level maturity/readiness scale. Levels refer to what has been studied, proven, tested or demonstrated and under what environments/conditions.

Examples include laboratory, relevant environment, operational environment and flight-proven states.

### Why this is a **negative** holdout

The vocabulary `readiness` might tempt a family-first Composite Standing child.

But a technology's current maturity/readiness level can be modeled as **ground-local criterion-relative Domain Condition standing** when the protected question is simply its technology maturity under the TRL regime.

Evidence/demonstration Work may be how the standing is established, but does not automatically make the standing cross-ground.

### Implication

```text
standing-family word
!= composition routing rule
```

Routing must depend on the protected truth/evaluation question and whether several ground semantics are constitutive, not on labels such as `ready` or `validated`.

This strongly supports the S0 boundary correction.

---

## 8. Holdout G — NIST AI RMF 1.0 / AIRC

Authoritative sources:
- https://airc.nist.gov/airmf-resources/airmf/5-sec-core/
- https://airc.nist.gov/airmf-resources/airmf/3-sec-characteristics/
- https://www.nist.gov/ai-measurement-and-evaluation
- observed 2026-09-05.

### External pressure

NIST AI RMF emphasizes:
- context-specific measurement/evaluation;
- uncertainty and limitations of metrics;
- testing in/relative to deployment contexts;
- validity/reliability and generalizability limitations;
- safety/risk standing relative to risk tolerance;
- using measurement outcomes to support management decisions.

### Non-collapse

This supports distinctions such as:

```text
performance metric/result
!= valid/reliable for deployment context
!= residual risk within tolerance
!= deployment should proceed
```

The same system can score well on one metric while failing a use/context/risk qualification.

### Child pressure

Again, one shared standing grammar survives better than `risk`, `validity`, `fitness` children because context, intended use, tolerance and decision authority vary across these standing words.

---

## 9. Candidate-study holdout H — Anthropic AI-native SDLC

Package:
- `../../../studies/anthropic-ai-native-sdlc-playbook/`

Reusable pressure:
- artifact existence/commitment != semantic correctness;
- passing tests != complete evidence for real operating-state safety;
- repo truth != production reality;
- autonomy/permission should be environment- and action-specific;
- agent configuration itself requires regression evaluation;
- human review gate can block an indirect/transitive authority path.

### Standing implications

```text
artifact exists
!= intent/spec satisfied

checks passed
!= validated in real target state

agent has tool capability
!= authorized/actionable for production operation
```

No new standing family is forced.

---

## 10. Candidate-study holdout I — Multi-Agent Patterns

Package:
- `../../../studies/multi-agent-patterns/`

Pressure:
- manager/worker/critic/verifier labels do not by themselves establish competence, authority or independence;
- producer self-check != fresh/independent verification;
- role topology != institutional accountability.

Standing implication:

```text
role label = verifier
!= verification standing is valid
```

Exact role binding, criterion, evidence and independence requirements may be prerequisites.

No child split forced.

---

## 11. Candidate-study holdout J — Context / Memory / Harness Engineering

Package:
- `../../../studies/context-memory-harness-engineering/`

Pressure:

```text
memory persisted
!= memory selected into context
!= context current enough
!= context sufficient for Work
```

`context sufficient for current Work` is a clean cross-ground epistemic/use-relative standing, while persistence/availability remain Information/Environment-local facts.

This strongly supports the cross-ground boundary.

---

## 12. Candidate-study holdout K — AI Knowledge Strategies

Package:
- `../../../studies/ai-knowledge-strategies/`

Pressure:
- retrieval mechanism success != complete/appropriate source universe;
- retrieved information != evidence sufficient for target claim/decision;
- long context/RAG/graph/fine-tuning mechanisms do not determine evidential standing by themselves.

This is a direct counterexample to frame blindness:

```text
working context contains evidence
!= evidence universe was adequate
!= decision is sufficiently supported
```

Again, one standing grammar survives.

## 13. External holdout synthesis

### 13.1 Shared signature survives

Across metrology, systems engineering, access authorization, readiness/maturity and AI risk measurement, the recurring structure is:

```text
exact focus
+ qualification frame/criterion/use
+ constitutive facts/bindings
+ result semantics
(+ evaluation evidence/method/uncertainty)
(+ authority/recognition where constitutive/material)
+ current validity dependencies
```

### 13.2 No standing family becomes a stable child

- `readiness` can be ground-local or cross-ground;
- `verification` and `validation` differ mainly by qualification frame/target/use anchors;
- `authorization` is a standing/control boundary case;
- `risk/fitness` is context/tolerance-relative;
- `conformance` separates object truth, knowledge and decision.

Vocabulary therefore cannot drive the hierarchy.

### 13.3 Three semantic layers survive

Strongly supported:

```text
constitutive/object standing
!= epistemic assessment
!= decision/recognition
!= representation/report
```

But the layers still do not behave as stable sibling children.

### 13.4 Cross-ground boundary survives

NASA TRL is especially valuable because it demonstrates the negative case: a familiar standing family can remain ground-local. Multi-anchor semantics, not the word `standing/readiness/status`, determine whether Composite Standing applies.

## 14. Falsifier results after S5

### F1 — Environment duplication
Rejected with boundary correction intact.

### F2 — Binding-predicate collapse
Rejected by V&V, JCGM and ABAC evaluation semantics.

### F3 — ground-localization
Rejected for genuine multi-anchor cases; NASA TRL shows localization still works when appropriate.

### F4 — Control theft
Rejected as total collapse; ABAC confirms both regions are needed.

### F5 — Transition theft
No new pressure; currentness remains standing-semantic, change mechanics deferred.

### F6 — result-domain triviality
Rejected strongly by TRL ordinal scale and JCGM uncertainty/probability.

### F7 — true/evaluated/decision collapse
Rejected decisively by JCGM and NASA V&V.

### F8 — family split
No family survives external holdouts as a low-overlap universal child.

### F9 — missing Binding distinction
No missing accepted Binding distinction exposed.

### F10 — upstream adequacy failure
No evidence.

## 15. S5 judgment

Authoritative/candidate holdouts **strengthen the bounded-leaf hypothesis** and sharpen the routing rule:

> **Composite Standing is identified by irreducible multi-ground qualification semantics, not by standing vocabulary.**

Proceed to S6 synthesis / immediate-child decision.