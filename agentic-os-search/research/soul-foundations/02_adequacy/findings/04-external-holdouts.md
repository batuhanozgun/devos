# Finding 04 — External / Cross-Lineage Holdout Challenge

**Status:** current cross-lineage challenge  
**Purpose:** test the four-foundation mapping against traditions that did not arise from SOUL / KEEL / OS Architect and that organize the problem differently.

## Methodological rule

These frameworks answer different questions. Their vocabularies are **not** imported as SOUL ontology.

They are used as holdouts:

> If materially different traditions repeatedly require a distinction that the current four scopes erase or can represent only by stretching a label, that is evidence against four-area sufficiency.

Conversely, similar decompositions provide convergence evidence, not proof.

---

## H1 — Work System Theory (WST)

### Source

Steven Alter's Work System Theory / Work System Framework.

Representative sources:
- Steven Alter, 2014, *Notes on work system concepts* — `https://stsroundtable.com/wp-content/uploads/Alter-2014-Notes-on-work-system-concepts1.pdf`
- Steven Alter, 2013, *Using Work System Theory to Link Managerial and Technical Perspectives on BPM* — `https://repository.usfca.edu/at/36/`

### Holdout structure

WST's central internal work-system elements are:
- processes and activities;
- participants;
- information;
- technologies.

It also treats customers and products/services as partly inside/outside and environment, infrastructure and strategies as largely contextual/external but directly influential.

### Relevance to current four

There is strong non-project-lineage convergence:
- processes/activities ↔ Work-like problem;
- participants ↔ Actors-like problem;
- information ↔ information/Records-like problem;
- technologies ↔ technical-support-like problem.

But the match is **not exact**:
- WST uses `information` broadly, not only persistent records;
- it separately represents environment/infrastructure/strategies and outputs/customers.

### Judgment

**Supports the usefulness of a four-part work-system core, but weakens the claim that the current four researched scopes are exhaustive.**

The most important mismatch is `information > persistent Records`; external environment/context also remains outside the core.

---

## H2 — W3C PROV

### Source

W3C PROV Data Model / PROV namespace:
- `https://www.w3.org/ns/prov/`
- `https://www.w3.org/TR/prov-dm/`

### Holdout structure

PROV uses domain-agnostic structures around:
- Entity;
- Activity;
- Agent;
- typed relations such as usage, generation, association, attribution and delegation.

PROV's `Entity` can be physical, digital, conceptual or otherwise; it is not restricted to records or persistent information.

### Relevance

PROV independently supports a recurring separation resembling:
- things/information-bearing or affected entities;
- activities;
- agents;
- relations among them.

It also strongly supports the need for **typed relation structure** rather than self-contained entity/property bundles.

### Challenge

The current Records vertical is intentionally narrower than PROV Entity. A car, building, mountain, patient or other domain thing can be a PROV Entity without being a Record.

### Judgment

**Supports Records/Work/Actors-like separation and relation centrality, but exposes the danger of treating persistent Records as a universal stand-in for all things acted upon or described.**

---

## H3 — Cognitive Work Analysis (CWA) / Work Domain Analysis (WDA)

### Sources

- National Academies, *Human-System Integration in the System Development Process*, CWA analytic tools — `https://www.nationalacademies.org/read/11893/chapter/9`
- CWA overview / work-domain literature summarized in peer-reviewed and handbook sources.

### Holdout structure

WDA analyzes the **work domain** — the purposive/physical constraints within which activity occurs — independently of the specific tasks or individuals that later act in it.

Control-task analysis then asks what needs to be done in that domain, separately from who performs it or what exact strategy is used.

### Relevance

This is a direct independent counterexample to `all relevant reality can be represented as Work + Actors`.

A domain can constrain possible action before a task or actor assignment is chosen.

Examples include:
- physical plant state;
- clinical/patient domain;
- ship/navigation constraints;
- organizational or socially constructed work domains.

### Judgment

**Strong support for a distinct Work Domain / Operating World problem region.**

It does not prove the exact label or architecture representation, but it directly supports P13's non-reducibility.

---

## H4 — Agent–environment / POMDP tradition

### Sources

- OpenAI Spinning Up RL introduction — `https://spinningup.openai.com/en/latest/spinningup/rl_intro.html`
- standard POMDP literature, e.g. Monahan (1982), *State of the Art—A Survey of Partially Observable Markov Decision Processes*.

### Holdout structure

The classical agent–environment interface distinguishes:
- environment/world state;
- agent action;
- observation of state, which may be partial;
- environment transition, including change caused by action and change occurring independently.

### Relevance

This directly supports three non-collapse rules:

> world state ≠ observation  
> observation ≠ agent belief/model  
> action/Work ≠ world transition itself

Technical tools/runtime are not what `environment` means in this tradition; the environment is the world with which the agent interacts.

### Judgment

**Strong support for P13 and for the P6 representation gap.**

A general-purpose agent architecture that cannot distinguish actual external state from observations/representations is structurally incomplete for partially observable or dynamically changing domains.

---

## H5 — STAMP / STPA system-safety control structure

### Sources

- STAMP Institute overview — `https://home.stamp-institute.com/about-stamp/`
- peer-reviewed STAMP/STPA reviews and MIT course/tutorial material.

### Holdout structure

STAMP control structures distinguish:
- controller;
- controlled process;
- control action;
- feedback;
- the controller's process model / belief about the controlled process.

Safety failures can arise because the process model does not match the controlled process's true state even when the controller behaves consistently with its model.

### Relevance

This supports:
- Actor/controller distinctions;
- Work/control-action distinctions;
- actual process/world state distinct from the model/representation of it;
- typed feedback/control relations as load-bearing structure.

### Judgment

**Strong evidence that relation/control structure is first-order modelling machinery, while the controlled process/world and its representation remain distinct relata.**

This argues for a relation/control fabric but does not by itself make `Control` a peer foundation category.

---

## H6 — Activity Theory

### Sources

Representative open descriptions of Engeström-style activity systems, including peer-reviewed implementations and institutional summaries.

Core nodes commonly include:
- subject;
- object of activity;
- tools/mediating artefacts;
- community;
- rules;
- division of labour;
- outcome.

### Relevance

Possible mapping:
- subject/community ↔ Actor-like concerns;
- activity/outcome ↔ Work-like concerns;
- tools ↔ technical/support or representation mechanisms;
- division of labour/rules ↔ relations, authority and constraints.

But the **object of activity** is important: it is what activity is directed toward / transforms and is not identical to the activity itself.

### Judgment

**Again supports the need to represent the subject matter/object/domain of work separately from the Work process.**

Rules and division of labour are important but map plausibly to cross-cutting normative/coordination relations rather than forcing a separate peer region.

---

## H7 — NASA systems engineering

### Sources

NASA Systems Engineering Handbook:
- `https://www.nasa.gov/reference/systems-engineering-handbook/`
- `https://www.nasa.gov/reference/2-0-fundamentals-of-systems-engineering/`

### Holdout signal

NASA treats systems as interacting elements — hardware, software, facilities, personnel, processes and procedures — organized to meet needs, and explicitly emphasizes stakeholder expectations, relationships among elements and intended use environment.

### Relevance

This tradition does **not** provide a matching four-way ontology. Its value as a holdout is different:
- system value is attributed significantly to relationships among elements;
- stakeholders/needs and intended-use environment remain explicit;
- verification and validation are distinct lifecycle questions.

### Judgment

**Supports relation-centric composition and environment/domain awareness, but does not independently settle the peer-region count.**

---

## H8 — Modern LLM-agent surveys

### Sources

- Wang et al., *A Survey on Large Language Model based Autonomous Agents* (Frontiers of Computer Science / arXiv 2308.11432).
- Recent lifecycle-oriented surveys distinguish perception, capability/tool use, memory, planning/action and evolution.

### Holdout signal

The literature commonly separates:
- perception/environment input;
- memory;
- planning/reasoning;
- action/tool use;
- sometimes profile/role and evolution.

### Relevance

Module taxonomies are not first-principles foundations and should not be copied.

However, the recurrence of **perception** as separate from persistent memory is important for P6, and explicit interaction with dynamic environments supports P13.

### Judgment

**Moderate support for an information/perception distinction broader than Records and for environment/world interaction as a general agent problem.**

---

# Cross-holdout synthesis

## What converges with the four current regions

Across unrelated traditions, recurring distinctions resemble:
- activity/process/work;
- participants/agents/roles;
- information/representation;
- tools/technology/infrastructure/support;
- typed relations/coordination/control.

This makes the current four verticals look **substantively grounded rather than arbitrary**.

## What repeatedly exceeds the current scopes

Two pressures recur across materially different traditions:

### A. Domain / operating-world reality

CWA/WDA, agent–environment models, Activity Theory's object of activity and STAMP's controlled process all preserve a problem region for the world/domain/process being acted upon or reasoned about.

This region is not naturally identical to:
- persistent Records about it;
- Work performed on/around it;
- Actors acting in it;
- technical support used to perform the Work.

### B. Information / representation beyond persistence

WST uses broad information, CWA uses knowledge/information states, POMDPs distinguish observation from hidden state, STAMP distinguishes process model from controlled process, and modern agents distinguish perception/context from persistent memory.

The current Records vertical deliberately studies persistent information; it does not yet cover all representation, observation, belief or transient-context semantics.

## Relation/control result

W3C PROV, STAMP, WST and Activity Theory all make **relations** central.

The external challenge so far supports:

> a relation/control fabric is structurally necessary, but `Relation` or `Control` is not demonstrated as a fifth peer problem region of the same kind as the relata it connects.

Authority, dependency, provenance, participation, access, observation, feedback, verification, acceptance and transition are candidate typed relation/control families.

---

# External holdout verdict

The four current foundation regions remain:
- independently useful;
- separable;
- strongly productive;
- supported by several cross-lineage convergences.

But the **four-current-scopes-as-complete-top-level-ground hypothesis does not survive external challenge unchanged.**

At minimum:

1. **Operating World / Work Domain / Domain Reality** must be explicitly represented as a candidate additional first-order problem region or as a demonstrated non-lossy expansion of another top-level ground.
2. **Information / Representation beyond persistent Records** requires an explicit resolution: broaden/rename the Records ground, add another region, or show that transient observations/beliefs/context are safely covered by relational state in other grounds.
3. A **typed relation/control fabric** appears mandatory for composition even if it is not a peer foundation.

These are research findings, not architecture decisions.
