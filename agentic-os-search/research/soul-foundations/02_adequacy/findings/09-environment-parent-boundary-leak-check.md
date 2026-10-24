# Adequacy Finding 09 — Environment Parent Boundary-Leak / Adversarial Check

**Status:** current adversarial refinement finding  
**Date:** 2026-09-02  
**Target:** the candidate four-broad-ground model produced by Finding 08

## Candidate under attack

```text
Environment / Operating Reality
    ├─ Operating World / Work Domain
    └─ Work-Support Environment
         └─ Technical Work Environment
Information / Representation
Work
Actors

+ typed relations / control / transitions
```

The main failure risk is that `Environment` becomes a residual bucket for everything that influences Work.

## Adversarial criterion

The parent survives only if apparently environmental cases can be handled **without stealing the first-order semantics** of Work, Actors or Information.

---

## 1. Other people / organizations

Case:
- a regulator, customer, supplier, colleague, adversary or external organization changes what is possible.

Naive Environment collapse:
- call them environmental elements and stop there.

Why that fails:
- identity, role, authority, obligation, delegation, representation, responsibility and accountability remain Actor semantics.

Current mapping:
- their current action/state may be part of the focal Work's operating conditions;
- the bearer and normative/agency semantics remain in Actors;
- dependency/authority/effect relations connect the grounds.

Verdict:
- **parent survives** if multi-ground participation is allowed;
- **parent fails** if Environment is treated as an exclusive object class.

---

## 2. Policies, laws, standards and rules

Case:
- a regulation changes and makes an action prohibited or mandatory.

Naive Environment collapse:
- `law = environmental constraint`.

Why insufficient:
- the actual regulatory regime and institutional state can be an operating-world condition;
- the text/version/interpretation of the rule is Information/Representation;
- who has authority to issue/enforce/waive it is Actors/control;
- compliance work is Work.

Verdict:
- no new peer ground is required;
- Environment may carry the **situated condition role**, not all semantics of the rule.

---

## 3. Physical workplace conditions

Cases:
- lighting, temperature, noise, workspace layout, access to a lab or physical location.

SEIPS/HFE traditions often treat physical environment as a distinct work-system component.

Current mapping:
- these are natural members of the broad Environment ground;
- whether they are `target/domain` or `support` depends on the Work.

Example:
- temperature is a target variable in climate-control Work;
- the same temperature is a support/safety condition for an office Work episode.

Verdict:
- supports role-relative branches rather than intrinsic taxonomy.

---

## 4. Tools and technologies

SEIPS and Activity Theory explicitly preserve tools/technologies as distinct from tasks and people; Activity Theory also separates the **object** being transformed from **mediating tools**.

This is a strong analogue for the proposed internal split:

- object/domain role → Operating World / Work Domain;
- mediation/support role → Work-Support Environment;
- actor/subject → Actors;
- activity/task → Work.

But neither framework says `object` and `tool` must be one ontology family.

Current implication:
- grouping them under one top environmental **problem ground** is defensible only as a higher-level analytical compression;
- lower-level object-vs-tool/support distinctions remain mandatory.

Verdict:
- supports one parent plus explicit branches, not one undifferentiated environment object type.

---

## 5. Information and Records used as tools

Case:
- a manual, database, repository, checklist or model enables Work.

Naive Environment collapse:
- treat it only as a support resource.

Why insufficient:
- meaning, identity, provenance, currentness, uncertainty and persistence remain Information/Records semantics.

Current mapping:
- the same representation can occupy a support-resource role in Environment and an information-object role in Information.

Verdict:
- multi-ground role participation is required;
- no evidence that Information should collapse into Environment.

---

## 6. Organization and coordination

SEIPS separates organization from physical/internal/external environment; Work System Theory distinguishes strategies/environment/infrastructure from core processes, participants, information and technologies.

This is an important falsification attempt against `Environment = all surrounding conditions`.

Current mapping:
- organizational structure contains Actor positions/authority and Work coordination semantics;
- organizational facts/policies can be represented in Information;
- only their realized situational effects/constraints need an environmental role when relevant.

Verdict:
- broad Environment cannot own `organization` as a whole;
- exclusion rule remains viable.

---

## 7. Work itself

Case:
- one Work stream creates constraints for another.

Naive Environment collapse:
- the other Work is part of my environment.

Why insufficient:
- candidate/commitment/execution/dependency/closure/recovery semantics remain Work semantics.

Current mapping:
- another Work's effects/current outputs can become an operating condition for focal Work;
- the other Work remains Work.

Verdict:
- relation crossing is enough; Environment does not absorb Work.

---

## 8. The technical support system becomes the target

Case:
- maintain or debug the CI system, GitHub integration, test cluster or development environment itself.

Result:
- the same technical system switches from `support environment` role to `target/domain` role for that Work;
- it may still provide some support capabilities during self-maintenance.

This is a decisive counterexample to intrinsic branch membership.

Verdict:
- branches are **role-relative analytical projections**.

---

## 9. Nested system-of-interest test

Systems engineering treats a system element as potentially a system-of-interest under a different analysis. Enabling systems also have their own life cycles.

Therefore:
- today's support environment can become tomorrow's system-of-interest/work domain;
- today's external system can be internal under a wider system boundary;
- environment membership is not permanent object identity.

Verdict:
- supports the candidate ground as boundary-relative analysis, not taxonomy.

---

## 10. Parent-definition stress test

### Too broad — reject

> Environment is everything that affects Work.

Fails: swallows Actors, Work, Information and relation/control.

### Too external — reject

> Environment is everything outside the controlled system.

Fails: support environments/enabling systems may be intentionally coupled to Work while not being in the product operational environment; also irrelevant external facts become members.

### Too technical — reject

> Environment is the tools/infrastructure used to work.

Fails: loses actual domain/world state.

### Current minimum viable parent

> **Environment is the boundary-relative realized situational substrate in which focal Work is situated: the actual domain/conditions it must understand, accommodate or affect, plus the support conditions/capabilities/interfaces on which its execution materially depends.**

Important exclusions:
- it does not own Actor agency/authority semantics;
- it does not own Work lifecycle semantics;
- it does not own representation/knowledge/Record semantics;
- relevance/context is a relation/selection question, not identical to environment existence.

This definition is still a working research formulation.

---

## 11. Does the parent add analytical value or only visual symmetry?

A parent is justified only if it changes research behavior usefully.

The candidate parent produces a recurrent two-sided question for any Work:

1. **Target/operating side:** what actual state/domain/conditions are being reasoned about or affected?
2. **Support side:** what realized capabilities/resources/interfaces/conditions make the Work possible or constrained?

Then separately ask:
- what is known/represented about either side? → Information;
- what activity/commitment/lifecycle is occurring? → Work;
- who/what participates with capability/authority/responsibility? → Actors.

This gives the parent a productive decomposition rule rather than mere naming symmetry.

---

## 12. Cross-lineage challenge result

### SEIPS

SEIPS 2.0 separates person(s), tasks, tools/technologies, organization, internal environment and external environment. This does **not** directly validate the candidate parent; it demonstrates that lower distinctions matter and interact.

The candidate survives because it preserves those semantics through distinct grounds/branches rather than claiming one Environment object bucket.

### Activity Theory

Separates subject, object and mediating tools, plus rules/community/division of labour.

This independently supports the difference between target/object and support/mediation while preserving actor/work/social relations elsewhere.

### Systems engineering

Distinguishes operational environment from enabling systems but analyzes both relative to a selected system/lifecycle context.

This is the strongest support for **sibling roles under a wider level**, and strongest rejection of `Technical Work Environment ⊂ product operational environment`.

### Cognitive Work Analysis

Supports a work-domain/environmental constraint stratum separate from activity/organizational/worker analyses.

This supports one higher environmental problem level without collapsing Work or Actors.

---

## 13. Adversarial verdict

No tested boundary case currently forces the five-peer model back into preference.

The four-broad-ground candidate survives provided that:

1. grounds are treated as analytical problem lenses, not mutually exclusive object categories;
2. Environment retains explicit target/domain versus support branches;
3. the parent is boundary-relative and Work-relevant, not `everything external`;
4. Actor, Work and Information semantics remain authoritative even when their concrete relata also play an environmental role.

The remaining concern is **terminology**, not the current structural result: `Environment` is overloaded, and `Context` is even more dangerous. A later naming pass may choose a more precise label such as `Operating Reality`, `Situated Conditions`, or another term after the semantics are stable.
