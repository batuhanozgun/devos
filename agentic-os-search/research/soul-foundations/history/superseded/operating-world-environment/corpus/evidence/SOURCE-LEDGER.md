# Environment — Source Ledger

**Status:** active evidence-recovery surface  
**Date opened:** 2026-09-01  
**Rule:** source observations below are evidence inputs, not accepted Environment findings or architecture.

## Source roles

### E01 — NASA Systems Engineering Handbook, System Design Processes

- Source: NASA, `SEH 4.0 System Design Processes`
- URL: https://www.nasa.gov/reference/4-0-system-design-processes/
- Type: authoritative systems-engineering guidance
- Signal: system design identifies external/enabling systems, interfaces and anticipated operating uses relative to a system boundary.
- Discriminates: boundary-relative external-world frame vs intrinsic Environment object type.
- Does not prove: one universal Environment ontology or a fourth architecture module.

### E02 — SEBoK, Engineered System Context

- Source: Guide to the Systems Engineering Body of Knowledge, `Engineered System Context`
- URL: https://sebokwiki.org/wiki/Engineered_System_Context
- Type: systems-engineering body-of-knowledge synthesis
- Signal: context defines a system-of-interest and important relationships to systems with which it works; narrower/wider analysis boundaries can change what is external.
- Discriminates: system-of-interest-relative context/boundary from fixed categorisation.
- Does not prove: that all external entities form one first-order family.

### E03 — Anind K. Dey, Understanding and Using Context

- Source: Dey, A. K. (2001), `Understanding and Using Context`
- URL: https://sites.cc.gatech.edu/fce/ctk/pubs/PeTe5-1.pdf
- Type: highly cited HCI/context-aware-computing paper
- Signal: context is situational information relevant to an entity/interaction rather than everything outside a system.
- Discriminates: context-as-relevant-situational-information from environment-as-total surroundings.
- Does not prove: that relevance is exhaustively a stable attribute set.

### E04 — Paul Dourish, What We Talk About When We Talk About Context

- Source: Dourish, P. (2004), `What We Talk About When We Talk About Context`
- URL: https://www.dourish.com/publications/2004/PUC2004-context.pdf
- Type: peer-reviewed HCI/context theory paper; author-hosted copy
- Signal: challenges representational context as a stable pre-specified container and advances interactional/context-emergence framing.
- Discriminates: fixed context data from relevance achieved in activity/interaction.
- Does not prove: that contextual facts cannot be represented.

### E05 — J. J. Gibson, affordances

- Source: Gibson, J. J. (1979), affordances chapter/excerpt from `The Ecological Approach to Visual Perception`
- URL: https://cs.brown.edu/courses/cs137/2017/readings/Gibson-AFF.pdf
- Type: foundational ecological-psychology primary text excerpt
- Signal: affordances concern what environment offers/provides relative to an organism.
- Discriminates: action possibility from Actor-intrinsic capability alone.
- Does not prove: how digital/institutional affordances should be represented or owned.

### E06 — Sutton & Barto, Reinforcement Learning: An Introduction

- Source: Sutton, R. S. & Barto, A. G., `Reinforcement Learning: An Introduction`, 2nd ed.
- URL: https://incompleteideas.net/book/the-book-2nd.html
- Type: canonical reinforcement-learning textbook
- Signal: learning agent/environment are separated through an explicit interaction interface of actions, sensed information, transitions and rewards.
- Discriminates: external transition dynamics from Actor-only models.
- Does not prove: an ontologically coherent Environment class; the boundary is abstraction-dependent.

### E07 — Open Container Initiative Runtime Specification

- Source: OCI Runtime Specification / configuration
- URLs:
  - https://github.com/opencontainers/runtime-spec/blob/main/config.md
  - https://specs.opencontainers.org/runtime-spec/config-linux/
- Type: current technical specification
- Signal: execution conditions include process configuration, mounts, namespaces, isolation and resource limitations; behavior/feasibility can depend on substrate conditions outside application logic.
- Discriminates: Work/application description from execution substrate.
- Does not prove: that runtime is a separate foundation region from physical/social/domain environment.

### E08 — Kubernetes Pods

- Source: Kubernetes documentation, `Pods`
- URL: https://kubernetes.io/docs/concepts/workloads/pods/
- Type: current official platform documentation
- Signal: workloads execute within platform-managed networking/storage/runtime conditions whose availability can change execution possibilities.
- Discriminates: Work unit from supporting execution resources/conditions.
- Does not prove: foundation-level ontology.

### E09 — W3C Web of Things Thing Description

- Source: W3C, `Web of Things (WoT) Thing Description 1.1`
- URL: https://www.w3.org/TR/wot-thing-description11/
- Type: W3C Recommendation
- Signal: `InteractionAffordance` metadata exposes possible interaction choices to consumers as Properties, Actions and Events.
- Discriminates: external interface/action surface from consumer capability alone.
- Does not prove: Gibsonian affordance theory or a universal Environment schema.

### E10 — Star, The Ethnography of Infrastructure

- Source: Star, S. L. (1999), `The Ethnography of Infrastructure`
- URL: https://journals.sagepub.com/doi/10.1177/00027649921955326
- Type: peer-reviewed infrastructure studies paper
- Signal: infrastructure is relational/ecological, embedded in practice and often becomes visible on breakdown; infrastructure status depends on community/activity relation.
- Discriminates: infrastructure-as-intrinsic-object from practice/boundary-dependent role.
- Does not prove: ownership of infrastructure semantics in SOUL.

### E11 — Clark & Chalmers, The Extended Mind

- Source: Clark, A. & Chalmers, D. (1998), `The Extended Mind`
- URL: https://www.jstor.org/stable/3328150
- Type: peer-reviewed philosophy paper
- Signal: provides a strong rival frame in which sufficiently coupled external resources can become constitutive parts of a cognitive system.
- Discriminates: rigid Actor/Environment boundary from coupling-dependent boundary shift.
- Does not prove: that SOUL should adopt extended-mind criteria or classify tools as Actors.

### E12 — Environment Ontology (ENVO)

- Source: Buttigieg et al. (2013), `The environment ontology: contextualising biological and biomedical entities`
- URL: https://pmc.ncbi.nlm.nih.gov/articles/PMC3904460/
- Type: peer-reviewed domain ontology paper
- Signal: environmental systems, features/materials/processes/conditions can be modeled as structured and multi-granular; meaningful annotation also requires relations to the entity of interest.
- Discriminates: environment-as-undifferentiated attribute from structured environmental region plus contextual relations.
- Does not prove: generality beyond ecological/biomedical use or suitability of ENVO classes for SOUL.

### E13 — Greeno, Gibson's affordances

- Source: Greeno, J. G. (1994), `Gibson's affordances`, Psychological Review 101(2), 336–342.
- URL: https://pubmed.ncbi.nlm.nih.gov/8022965/
- DOI: 10.1037/0033-295X.101.2.336
- Type: peer-reviewed theoretical psychology paper
- Signal: interactionist agent–situation framing treats affordance and ability as distinct/complementary; affordances for an agent can be understood as environmental conditions relative to constraints to which the agent is attuned.
- Discriminates: stable Actor ability from situated actionability.
- Does not prove: that `affordance` is a universal system-model primitive.

### E14 — Poole & Mackworth, POMDP formulation

- Source: Poole, D. L. & Mackworth, A. K., `Artificial Intelligence: Foundations of Computational Agents`, 3rd ed., §12.5.5.
- URL: https://www.cs.ubc.ca/~poole/aibook/3e/html/ArtInt3e.Ch12.S5.html
- Type: current university textbook / formal decision-model reference
- Signal: explicitly separates world states `S`, observations `O`, environment transition dynamics and Actor belief state/history.
- Discriminates: actual world state from observation, belief/memory and persistent representation.
- Does not prove: that POMDPs are the required SOUL representation or that all world state is uncertain.

### E15 — Åström & Murray, Feedback Systems

- Source: Åström, K. J. & Murray, R. M., `Feedback Systems: An Introduction for Scientists and Engineers`, Chapter 1.
- URL: https://www.cds.caltech.edu/~murray/books/AM08/pdf/am08-intro_09Aug12.pdf
- Type: control-systems textbook
- Signal: process dynamics, sensors, measured values, noise, external disturbances, control inputs and actuation are distinct parts of a feedback account; external disturbances can alter system behavior independently of controller intent.
- Discriminates: actual process/world dynamics from measurement and controlled Work/action.
- Does not prove: a universal cybernetic architecture for SOUL.

### E16 — NIST SP 800-162, Attribute Based Access Control

- Source: NIST SP 800-162, updated final.
- URL: https://csrc.nist.gov/pubs/sp/800/162/upd2/final
- Type: authoritative access-control guidance
- Signal: authorization may depend on subject, object, operation and environment conditions evaluated against policy/rules/relationships.
- Discriminates: Actor identity/capability from context/environment-dependent permission outcome.
- Does not prove: that authorization belongs to Environment; policy/authority semantics remain Actors/relation concerns.

### E17 — NIST SP 800-190 / container runtime

- Sources:
  - https://csrc.nist.gov/pubs/sp/800/190/final
  - https://csrc.nist.gov/glossary/term/container_runtime
- Type: authoritative technical-security guidance/glossary
- Signal: container runtime is an execution environment coordinating OS components that isolate resources/resource usage; host/runtime components materially condition application execution.
- Discriminates: application/Work logic from execution substrate and resource-access conditions.
- Does not prove: that `runtime` is a distinct first-order foundation family.

### E18 — NASA Systems Engineering Handbook Appendix / Concept of Operations

- Source: NASA, Systems Engineering Handbook Appendix, Concept of Operations material.
- URL: https://www.nasa.gov/reference/system-engineering-handbook-appendix/
- Type: authoritative systems-engineering guidance
- Signal: physical environment includes expected/off-nominal temperature, pressure, radiation, wind and other conditions; support environment and external interfaces are separately described.
- Discriminates: current operating/physical conditions from system capability and Work plan.
- Does not prove: that physical/support/interface conditions must share one data schema.

### E19 — OECD/Eurostat Oslo Manual 2018, external environment

- Source: OECD/Eurostat, `Oslo Manual 2018`, Chapter 7.
- URL: https://www.oecd.org/en/publications/oslo-manual-2018_9789264304604-en/full-report/component-13.html
- Type: international measurement manual / institutional reference
- Signal: a firm's external environment includes customer/competitor/supplier activity, labour markets, legal/regulatory/economic conditions, public infrastructure, social and natural conditions beyond immediate management control; these can act as drivers or barriers.
- Discriminates: Environment candidate beyond purely physical/technical surroundings and tests social/institutional omissions.
- Does not prove: a universal ontology; scope is business innovation measurement.

### E20 — Partially Observable Stochastic Games / POSGGym background

- Source: `POSGGym: a library for decision-theoretic planning and learning in partially observable, multi-agent environments`, Autonomous Agents and Multi-Agent Systems (2025).
- URL: https://link.springer.com/article/10.1007/s10458-025-09716-6
- Type: peer-reviewed multi-agent decision-model paper
- Signal: POSGs preserve multiple Actors, shared environment state, joint actions, transition dynamics and distinct observations.
- Discriminates: `other Actors exist` from `shared world/environment state and dynamics disappear`; environment is not a mutually exclusive entity class.
- Does not prove: POSG semantics are generally required outside decision-theoretic models.

### E21 — Non-stationary reinforcement learning

- Source: Bui et al. (2026), `Q-Learning with Shift-Aware Upper Confidence Bound in Non-Stationary Reinforcement Learning`, AISTATS / PMLR 300.
- URL: https://proceedings.mlr.press/v300/bui26a.html
- Type: peer-reviewed recent ML conference paper
- Signal: transition functions/distributions can change during agent–environment interaction, changing policy performance without requiring an Actor identity or Work-goal change.
- Discriminates: changing environment dynamics from static context or Actor-only explanation.
- Does not prove: that all real-world environmental change is well modeled as MDP transition shift.

## Current cross-source observations

1. **Boundary-relative externality is robust.** NASA/SEBoK, RL/POSG and boundary-shift alternatives all require a system/agent of interest before `environment` membership is determinate.
2. **Context is not synonymous with Environment.** Dey and Dourish show that relevance is situational/activity-dependent; `context` can be a selective or interactional relation to world facts rather than the entire world outside a boundary.
3. **Actionability is relational.** Gibson/Greeno, W3C WoT, NIST ABAC and runtime cases show that capability/authorization/affordance/resource availability can vary independently and combine to determine situated possibility.
4. **Actual world state is not its observation or Record.** POMDP, feedback/control and completed Records findings converge on separating state/dynamics from sensing, belief and persistence.
5. **Technical runtime is a strong Environment instance but not yet a separate first-order family.** OCI/NIST runtime, NASA physical/support environment and OECD social/institutional environment can all be viewed at a higher abstraction as boundary-relative operating conditions/resources/interfaces that affect feasibility/outcomes.
6. **Tools/resources/infrastructure are roles, not safe intrinsic classes.** Infrastructure/extended-system framings show that the same concrete entity can be external resource, mediator, enabling system or internal/constitutive element depending on boundary and coupling.
7. **Environment can contain other Actors' effects without declassifying them as Actors.** POSG evidence shows shared world state/dynamics coexist with multiple explicit agents.
8. **Environment/world dynamics may change independently.** Non-stationary RL and external-disturbance/control evidence prevent treating environment as static context metadata.
9. **The strongest null hypothesis fails only at the problem-region level, not the module level.** Typed relations can avoid a fourth object bucket, but if they need boundary-relative external states/conditions/resources/interfaces as relata, the underlying problem region has been reintroduced rather than eliminated.

## Recovery rule

When a claim becomes load-bearing, recover the primary/authoritative source directly and record the exact supported distinction. Search snippets and this ledger are not sufficient for exact wording, exhaustive absence claims or architecture decisions.