# Relation / Control / Composition — C5 External / Candidate Holdouts

**Status:** COMPLETE  
**Date:** 2026-09-05

## 1. Purpose

Challenge the current four-region composition hypothesis with materially different external traditions and current candidate studies.

Current hypothesis:

```text
Cross-Ground Composition
├─ Relational Binding
├─ Composite Standing / Qualification
├─ Control / Constraint
└─ Transition / Effect / Feedback
```

Sources are holdouts/falsifiers, not Foundation taxonomy authority.

---

## 2. W3C PROV — specific relations across entity / activity / agent

### Inspected authoritative tradition

W3C PROV-DM / PROV Constraints:
- https://www.w3.org/TR/prov-dm/
- https://www.w3.org/TR/prov-constraints/

Relevant semantics include:
- entity / activity / agent distinctions;
- generation and usage;
- derivation;
- attribution;
- association;
- delegation / acted-on-behalf-of;
- generic influence with more specific relation specializations.

### Pressure on current frame

**Relational Binding:** strongly supported. PROV does not rely on one generic `related-to`; it gives materially different relations among different anchor kinds.

**Transition / Effect:** generation, usage, invalidation, derivation and communication carry event/transition semantics rather than static endpoint labels alone.

**Composite Standing:** attribution can depend on a generated entity, activity and agent association; provenance queries/constraints may infer relations from a composition of facts rather than one intrinsic property.

**Control:** PROV delegation mentions authority/responsibility in an activity context, but PROV is not a general control framework. It therefore pressures the distinction rather than defining it.

### Falsifier result

PROV does **not** support flattening composition to a single generic relation. It also does not force `Provenance` to become a peer parent region: provenance uses binding and transition structures and intersects Actor responsibility.

**Current result: supports the four-region frame; no fifth region forced.**

---

## 3. NIST SP 800-162 ABAC — multi-anchor authorization

### Inspected authoritative source

NIST SP 800-162, Guide to Attribute Based Access Control (ABAC):
- https://csrc.nist.gov/pubs/sp/800/162/upd2/final

NIST defines authorization for operations through evaluation of attributes associated with:
- subject;
- object;
- requested operation;
- in some cases environment conditions;
- against policy/rules/relationships describing allowable operations.

### Pressure on current frame

This is a strong independent example of a standing/control decision that is **not intrinsic to the Actor/subject**.

The authorization result depends on a constellation of anchors and policy context.

Mapping pressure:
- subject/standing → Actors;
- target/object and realized conditions can cross Environment/Information depending the domain object being controlled;
- operation → Work/action-transition context;
- policy/rules → represented Information plus legitimate authority provenance;
- environment conditions → Environment;
- authorization outcome → Composite Standing / Control.

### Falsifier result

A simple `Actor has permission P` property model is insufficient for context-sensitive authorization.

ABAC strongly supports keeping:
- **Composite Standing** — authorization result relative to request/context/policy;
- **Control / Constraint** — the decision semantics governing allowed operations;
- **Relational Binding** — subject/object/operation/environment/policy anchors.

ABAC does not by itself establish actual runtime enforcement or observed compliance, so those remain separate control/effect questions rather than being inferred from the authorization decision.

**Current result: strong support; no fifth Authority/Policy ground forced.**

---

## 4. NASA Systems Engineering — verification vs validation

### Inspected authoritative sources

NASA Systems Engineering Handbook web surfaces:
- Product Verification: https://www.nasa.gov/reference/5-3-product-verification/
- Product Validation: https://www.nasa.gov/reference/5-4-product-validation/
- Fundamentals / distinction: https://www.nasa.gov/reference/2-0-fundamentals-of-systems-engineering/

NASA distinguishes:
- verification: proof/compliance against specified requirements;
- validation: whether the realized product fulfills intended use and stakeholder expectations in intended environment.

NASA also treats verification/validation as processes with plans, inputs, activities, results/reports and enabling products.

### Pressure on current frame

This is a high-value multi-ground holdout.

**Relational Binding:**
- target/product ↔ requirement/expectation;
- verification/validation activity ↔ target;
- result/evidence ↔ criterion;
- stakeholder/operator ↔ expectation/use.

**Composite Standing:**
- verified-against-requirements;
- validated-for-intended-use/environment;
- these standings are not interchangeable.

**Control / Constraint:**
- baselined requirements/expectations, approved plans, readiness and acceptance criteria govern the activity and resulting claims.

**Transition / Effect:**
- verification/validation Work is performed;
- evidence/results are generated;
- anomalies trigger resolution Work;
- resulting standing can gate delivery/integration.

### Falsifier result

NASA independently rejects the idea that `done`, `verified`, `validated` and `accepted/ready-to-transition` can safely be one Work status.

It also shows why Assurance is not necessarily a fifth ground: the semantics are compositional across Work, Information, Environment and Actors/stakeholders.

**Current result: strong support for all four regions.**

---

## 5. Anthropic AI-native SDLC candidate study — layered control and transitive effect power

### Recovered candidate source

`research/studies/anthropic-ai-native-sdlc-playbook/META.md`

Strong reusable pressures:
- advisory context/instructions vs harder enforcement surfaces;
- environment/risk-tiered autonomy;
- transitive/effective authority through reachable agents/tools;
- versioned artifact/gate chains;
- incident → diagnosis → new Work → evaluated change loop;
- telemetry over tool/permission/subagent events.

### Pressure on current frame

**Relational Binding:** agent/tool/subagent/artifact/gate topology.

**Composite Standing:** directly allowed, indirectly effect-capable, verified, deployment-ready, evaluated configuration.

**Control:** instruction vs hook/settings/permission/sandbox/network/identity/human gate.

**Transition/Feedback:** production event → evidence → diagnosis Work → configuration/code change → eval → deployment.

### Falsifier result

The source strongly falsifies any model where:

```text
no direct permission => no reachable effect
```

and any model where policy/instruction/enforcement are one semantic layer.

It reinforces the four-region frame rather than introducing a new `Agent Control` ground.

---

## 6. Multi-agent patterns candidate study — topology vs authority/verification semantics

### Recovered candidate source

`research/studies/multi-agent-patterns/META.md`

Relevant pressure:
- hierarchy/delegation;
- dependency/concurrency;
- generator/reviewer/verifier/integrator separation;
- merge/integration;
- human governance.

### Pressure on current frame

A topology label (`manager`, `worker`, `critic`) does not establish:
- authority;
- competence;
- verification independence;
- accountability;
- integration authority.

This requires:
- Binding relations for participation/delegation/dependency;
- Composite Standings for readiness/verification/authority-relative claims;
- Controls for who may decide/merge/accept;
- Transitions for handoff/merge/review/repair loops.

### Falsifier result

Orchestration pattern names are not sufficient composition semantics.

**Current result: supports the frame and protects against architecture leakage.**

---

## 7. Context / Memory / Harness Engineering candidate study

### Recovered candidate source

`research/studies/context-memory-harness-engineering/META.md`

Relevant pressure:
- context formation vs persistence vs runtime/control;
- model-visible information vs actual tool/runtime capability;
- orchestration/permissions/verification/stop/recovery.

### Pressure on current frame

This study reinforces:

```text
information visible to model
!= persistent information exists
!= runtime capability available
!= action authorized
!= control mechanically enforced
```

The distinction spans all four composition regions rather than defining a Context/Memory/Harness Foundation stack.

---

## 8. Cross-holdout conclusion

Three materially different authoritative traditions plus three candidate studies converge on the same structural pressure:

1. **Specific bindings matter.** Generic relation/influence is insufficient for load-bearing semantics.
2. **Composite standings matter.** Authorization, verification, validation, actionability and similar statuses depend on multiple anchors/criteria.
3. **Control semantics matter.** Normative/decision rules and realized enforcement cannot be silently collapsed.
4. **Transition/effect semantics matter.** Generation, validation activity, environment effects, feedback and adaptation require temporal/change analysis.

No holdout forced:
- a fifth top-level Foundation ground;
- a fifth immediate composition region;
- a flat pairwise taxonomy;
- a control-loop or provenance-only parent model.

## 9. C5 judgment

The current four-region composition hypothesis receives materially independent support at the level needed for parent research.

Verification limit:
- the exact four-region synthesis is project-specific;
- no external source validates this exact decomposition;
- candidate studies are not independent Foundation evidence;
- final parent closure still requires C6 synthesis and C7 same-model adversarial attack.

Proceed to C6.