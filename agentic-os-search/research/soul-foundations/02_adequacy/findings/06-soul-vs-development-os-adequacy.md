# Finding 06 — SOUL vs Development OS Adequacy

**Status:** current comparative finding  
**Question:** Do the original four grounds have different adequacy depending on whether the target is Development OS or general-purpose SOUL?

## Short answer

Yes, the pressure differs — but the distinction is **degree, not a clean pass/fail split**.

The original four are much closer to sufficient for Development OS because its current subject matter is largely software/repository/technical work. However, even Development OS exposes two level mismatches:

1. the **system/product being developed** is not identical to the development Work, its Records or the technical support setting;
2. current context, observations, assumptions, models and reasoning state are broader than persistent Records.

For general-purpose SOUL, both mismatches become unavoidable and materially larger.

---

# A. Development OS

## What the Development OS is controlling

First-party SOUL evidence says Development OS exists so long-running SOUL development can continue across fresh sessions with:
- authoritative project state;
- bounded work packages;
- role/authority separation;
- evidence and independent verification;
- decision/change governance;
- controlled reasoning discipline;
- handoff and continuity;
- development artefacts explicitly separated from the eventual reusable `system/` product.

This naturally exercises the original four:

### Records / persistent information
Repository state, decisions, work definitions, evidence, verification results, history and handoffs must persist and remain reconstructable.

### Work
Development requires selection, framing, research, design, build, verification, review, integration, recovery and next-work routing.

### Actors
Designer/builder, researcher, verifier, reviewer, integrator and owner have different authority/responsibility positions.

### Technical Work Environment
Git, repository hosting, model sessions, tools, CI/hooks/test environments and other technical means must actually be available and correctly wired.

## Why the original four appear especially strong here

The domain being worked upon — a software/agentic system — is heavily represented through persistent artefacts and technical realizations.

Consequently, many domain facts can be observed through:
- source/configuration Records;
- test/evidence Records;
- repository state;
- realized technical environments.

This makes the missing Operating World less visible than in robotics, clinical or physical operations.

## Gap 1 — the product/system under development is still distinct

WP-000 explicitly separates temporary development artefacts/governance from the eventual reusable `system/` product.

That separation is not merely directory hygiene. It exposes an analytical difference among:
- the development process;
- representations/evidence about the product;
- the technical environment used to develop/test it;
- the product/system and its actual behavior/properties.

A source file, test report or architecture document is a representation of the product, not automatically the product's actual behavior.

A test environment is a support/realization context, not automatically the subject system's true deployed behavior.

Therefore a product/system-under-development can occupy the **Work Domain / Operating World role** even in software development.

## Gap 2 — selective context and reasoning state exceed persistent Records

Development OS requires fresh sessions to receive bounded role-relevant context without hiding canonical truth.

WP-021 also treats selective context as a design concern. SOUL non-negotiables explicitly distinguish state, memory, context and knowledge.

Some of these may be derived ephemerally from persistent Records. Their **source** can be Records while the assembled context/information state is not identical to the source corpus.

Thus a broader Representation / Information State ground is useful even for Development OS.

## Development OS verdict

### Original four unchanged

**NEAR-ADEQUATE / PRACTICALLY STRONG, BUT NOT CLEANLY COMPLETE AS TOP-LEVEL ANALYTICAL GROUNDS.**

They cover almost all experienced first-order development failure families, but they rely on implicit treatment of:
- the product/system-under-development as if it were exhausted by artefacts/environment;
- transient representation/context as if it were exhausted by Records.

### Corrected five-ground hypothesis

```text
Operating World / Work Domain
Information / Representation State  -> Records as persistent branch
Work
Actors
Technical Work Environment
+ typed relation/control fabric
```

**Strong natural fit for Development OS.**

Here `Operating World / Work Domain` includes the system/product/problem domain being developed, inspected or changed — not only a physical external world.

---

# B. General-purpose SOUL

## General-purpose requirement

SOUL's stated goal is not software-development automation. It should take an intended outcome and establish the task-specific controlled working system needed to pursue it across domains such as research, decision support, design, operations or yet-unavailable capabilities.

Therefore SOUL cannot assume:
- the relevant world is fully represented in a repository;
- observations are complete or correct;
- Work only changes digital artefacts;
- technical support resources are the same thing as the subject domain;
- important context is always persistent before the task begins.

## Why Operating World becomes mandatory

General-purpose scenarios frequently involve actual states/processes that:
- change independently of the working system;
- may be only partially observed;
- constrain feasible action;
- are affected by Work;
- must be distinguished from records/reports about them.

Examples:
- patient condition;
- market/customer/legal state;
- physical equipment/process state;
- robot surroundings;
- scientific specimen/phenomenon;
- external service/business process whose state is the subject rather than merely a tool.

Without a domain/world ground, SOUL risks evaluating outcome success from its own records rather than from the state of affairs those records purport to represent.

## Why broader Representation / Information State becomes mandatory

General-purpose SOUL must operate under partial, stale, conflicting, uncertain or inferred information.

It therefore needs first-order questions around:
- observation versus reality;
- belief/model/claim versus observation;
- source/provenance and confidence;
- context selection;
- uncertainty/unknowns;
- derived interpretation;
- what should later persist as a Record.

These are not optional storage details. They affect action selection and verification before persistence decisions are even made.

## SOUL verdict

### Original four unchanged

**INSUFFICIENT AS AN EXHAUSTIVE TOP-LEVEL ANALYTICAL DECOMPOSITION.**

This is now supported by both:
- internal boundary gaps;
- independent cross-lineage traditions/scenarios.

### Corrected five-ground hypothesis

**CURRENTLY STRONGEST CANDIDATE, not yet final.**

It preserves the four independently researched problem families by moving Records to the persistence branch of a broader information/representation ground and adding the distinct domain/world ground.

---

# C. What remains shared between Development OS and SOUL

Both require a composition fabric with typed relations such as:
- Actor performs/decides/authorizes/owns/represents;
- Work uses/produces/changes/observes/evaluates;
- representation describes/is-derived-from/supports/challenges;
- Work targets/affects/depends-on domain/world state;
- Actor/Work uses Technical Work Environment capability/resource/interface;
- evidence verifies/validates/accepts a Work result or claim;
- control permits/blocks/triggers/transitions;
- failure generates recovery/reframe/new Work;
- learning changes future representation, Work, authority or environment capability.

The fabric is not a sixth peer ground merely because every system requires relations.

---

# D. Important consequence for the user's original intuition

The original intuition — `these four may be the top categories we deepen under` — was **substantively productive but too strong as stated**.

Current evidence supports a refined version:

> The four independent researches discovered four genuine load-bearing problem grounds, but one (`Records`) appears to be a deep branch of a broader information/representation ground, and a distinct Work Domain / Operating World ground is missing if the target is a general-purpose controlled working system.

Therefore the next research tree should not yet be opened simply as four fixed top-level categories.

The corrected top-level hypothesis must survive a final omission/adversarial challenge first.
