# Actors — Completeness / Omission Check

**Status:** bounded-completion adversarial self-review  
**Date:** 2026-09-01  
**Verification class:** **same-model adversarial self-review; NOT independent verification**

## Purpose

Test whether the current Actors synthesis is stopping because the research plan feels complete, or because additional targeted searches are increasingly failing to produce new first-order distinctions.

The test is deliberately hostile to the synthesis: look for phenomena that the current multi-anchor account would erase, misclassify or force into the wrong relation family.

## 1. Pre-check criterion

A new result counts as a **new first-order Actors distinction** only if it would materially change the semantic separation required by later work, rather than merely:

- add a synonym;
- refine a threshold;
- add a domain-specific rule;
- provide another example of an existing distinction;
- strengthen an already established source chain.

A finding can still be important without being first-order.

## 2. Challenge sequence and result

### Probe A — persistent Actor/entity adequacy

Challenge:
- Can one persistent Actor identity safely carry current role, permission, authority, delegation, responsibility and action attribution?

Evidence families:
- W3C PROV;
- NIST RBAC/ABAC;
- RFC 8693;
- agency law.

Result:
- **falsified as sufficient.**
- Opened first-order distinction among bearer, role/context, participation, authorization and attribution.

Impact:
- material frame change.

### Probe B — role/position as replacement primitive

Challenge:
- If identity is insufficient, can role/position replace Actor as the basic unit?

Result:
- **no.** Role explains institutional standing/permission but not all event participation, causal contribution, representation, software participation or responsibility.

Impact:
- mapped to multi-anchor frame; no single replacement primitive.

### Probe C — action-event/participation as non-Actor-centred replacement

Challenge:
- Can events plus typed participation relations explain the region without persistent Actors?

Early result:
- strong explanatory gain for performer/decider/authorizer/principal separation.

Adversarial omission probe:
- intentional omission, refraining, failure to act and responsibility for non-action.

Result:
- **literal event-centred frame falsified as complete.**
- meaningful agency/responsibility can concern non-occurrence against an available/expected-action background.

Impact:
- **new first-order distinction found late enough to reopen the frame.**
- Frame revised to situations/episodes + possible/expected conduct + typed action/decision/omission relations.

### Probe D — delegation as one relation

Challenge:
- Does one generic `acts-as/delegated-to` edge preserve the semantics?

Evidence:
- RFC 8693 delegation vs impersonation;
- subject/current actor/prospective actor/history;
- W3C PROV delegation;
- agency law actual/apparent authority and lifecycle.

Result:
- **no.** Scope, represented principal, actor identity, impersonation semantics, history and authority perspective can diverge.

Impact:
- maps to existing representation/authority/attribution family after initial discovery.

### Probe E — authority as intrinsic or unary

Challenge:
- Is authority simply a property of one Actor?

Evidence:
- ABAC policy/context evaluation;
- RBAC role activation;
- static/dynamic separation of duty and two-person rule;
- apparent authority/third-party reliance.

Result:
- **no.** Authority can be contextual, relational, perspective-sensitive and combinatorial.

Impact:
- refinement within existing normative relation family; no new family after authorization distinction was established.

### Probe F — responsibility/accountability collapse

Challenge:
- Can `responsible` safely cover causal contribution, duty, blame and answerability?

Evidence:
- SEP moral responsibility;
- epistemic/control condition literature;
- Bovens accountability relation;
- collective responsibility.

Result:
- **no.** Causal responsibility, obligation, moral responsibility and accountability are not interchangeable.

Impact:
- first-order typed-attribution/responsibility family established; later searches on knowledge/control refined conditions but did not open a new family.

### Probe G — collective = organization = group Actor

Challenge:
- Can plurality be represented by one group Actor, or can all group-level behavior be reduced to members?

Evidence:
- Christian List aggregate/common/corporate attitudes;
- SEP shared agency;
- SEP collective responsibility.

Result:
- both shortcuts fail.
- Mere aggregation, shared/joint action and organized corporate/group agency are distinct.

Impact:
- important refinement inside collective family. Later shared-agency probe did not create an unrelated new first-order family, but prevented `shared action = corporate agent` collapse.

### Probe H — non-human Actor yes/no

Challenge:
- Is there one stable answer to whether software/AI is an Actor?

Evidence:
- W3C SoftwareAgent;
- UNCITRAL automated action attribution;
- joint cognitive systems literature;
- computational Actor terminology as non-load-bearing semantic-overload example.

Result:
- **no context-free yes/no answer preserves all semantics.** Operational, provenance, legal and moral agency are different questions.

Impact:
- maps to existing bearer/participation/attribution distinction.

### Probe I — trust, fiduciary duty, competence, consent/control

Challenge:
- Do these open distinct new Actor foundations?

Evidence:
- NIST trust relation glossary;
- agency/fiduciary law;
- ISO competence definition;
- agency assent/control requirements.

Result:
- trust mapped to relation/policy/authority;
- fiduciary duty mapped to obligation/representation/responsibility;
- competence mapped to capability/skill distinct from authority;
- consent/control mapped to formation/conditions of representation relation.

Impact:
- **no new first-order family.** These refine existing distinctions.

### Probe J — affected party / beneficiary / rights holder

Challenge:
- Does the region need semantically relevant parties who are not performers or decision-makers?

Result:
- yes, in some relations; this further weakens `Actor = active doer`.
- however, current evidence did not show a distinct new agency/authority/attribution family. These are participation/stake positions whose owning vertical is a later synthesis question.

Impact:
- recorded as Actors-local open boundary and deferred cross-vertical relation, not promoted to a new primitive.

## 3. Search for omitted framing families

The targeted adversarial search intentionally crossed:

- provenance and activity association;
- access control and role activation;
- delegation/impersonation;
- agency law and apparent authority;
- legal capacity vs decision skill;
- responsibility/accountability;
- omission/non-action;
- shared/joint agency;
- corporate/group agency;
- collective responsibility;
- automated action attribution;
- joint human-machine systems;
- trust/fiduciary/competence terminology.

The later probes increasingly mapped to the existing dimensions rather than requiring a new top-level family.

## 4. What could still falsify the bounded result

Reopen Actors substantive research if later evidence shows a phenomenon that cannot be represented without collapsing something materially important, for example:

- a recurring agency relation not expressible through bearer/position/context/participation/normative/attribution/collective structure;
- a domain where the current action/omission distinction misses another first-order mode of agency;
- evidence that one supposedly distinct normative relation is in fact universally reducible without loss;
- a cross-vertical synthesis showing that a major current Actors distinction belongs entirely elsewhere and the present decomposition is misleading;
- a new non-human or institutional case that materially changes the operational-vs-normative attribution separation.

## 5. Remaining uncertainty profile

Remaining uncertainty is concentrated in:

- threshold questions;
- vocabulary choices;
- domain-specific legal/organizational semantics;
- identity continuity rules;
- competence details;
- omission representation;
- responsibility-regime selection;
- non-human moral/legal agency;
- cross-vertical ownership of affected/beneficiary and Work/Records relations.

These are recorded in `OPEN-QUESTIONS.md` and `DEFERRED-RELATIONS.md`.

They do not currently constitute an unidentified first-order Actors family.

## 6. Source-strength check

Load-bearing conclusions have recoverable paths to authoritative/primary or strong scholarly sources in `evidence/SOURCE-LEDGER.md`.

Known limitations are explicit:
- UNCITRAL direct PDF re-open failed with 403; official exposed text only is used;
- Bovens 2007 full publisher text was not directly inspected; only the actor–forum formulation visible through scholarly publication surfaces is used;
- joint cognitive systems claims are limited to inspected abstracts/accessed text;
- computational Actor Model is non-load-bearing because the original 1973 source was not recovered.

No completion claim depends on silently upgrading one of these limited views into a broader source claim.

## 7. Verification-validity statement

This document is **not independent verification**.

It is the same model deliberately searching for omissions and counterexamples after producing the synthesis. It increases confidence only to the extent that:

- the challenge questions differ materially from the original starting frame;
- some probes actually produced red results and forced frame revision, especially the omission finding;
- later probes were able in principle to open new families rather than being defined to map to the synthesis;
- source chains are externally recoverable.

It still shares decomposition choices, interpretation and synthesis errors with the main research pass.

## 8. Bounded-completion judgment

**PASS for the current SOUL Foundations purpose, with user evaluation pending.**

Rationale:

- multiple strong rival frames were tested;
- an explicit non-Actor-centred frame was seriously evaluated and materially revised by a falsifier;
- new first-order distinctions discovered during research were integrated rather than ignored;
- later targeted probes increasingly mapped to existing dimensions;
- load-bearing claims have source/view recovery paths;
- strong findings and residual uncertainty are separated;
- Actors-local and cross-vertical questions are separated;
- the marginal value of more broad literature search for discovering new first-order distinctions is now materially lower than the value of later synthesis/use-context testing.

This is **bounded sufficiency**, not proof of completeness and not user acceptance.
