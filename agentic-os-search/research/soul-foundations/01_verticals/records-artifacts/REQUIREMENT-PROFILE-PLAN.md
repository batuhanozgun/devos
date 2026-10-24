# Records Requirement Profile / Derivation — Research Plan

**Status:** active approved research plan  
**Date opened:** 2026-09-01

## Direction re-check

Five prior bounded Records passes now establish:

1. recordhood and persistent-information object boundaries;
2. resource/version/representation/derivation/aggregation distinctions;
3. minimum preservation closure rather than a universal metadata bundle;
4. change/status/temporal reconstructability semantics;
5. organisation/derived-view/retrieval semantics.

The next question is not `which database/search architecture implements these?` and not `how do we turn every finding into mandatory requirements?`.

The higher-information question is:

> **Given a specified persistent-information resource and intended future use, how can we derive the smallest defensible set of Records-side obligations that must hold — and distinguish them from obligations that are conditional, inherited, reconstructable, useful-but-optional, or outside Records?**

## Refined purpose

Develop and adversarially test an **architecture-neutral requirement-derivation method** for Records / persistent information.

The method should derive obligations from context rather than start from a universal checklist.

It should identify, when applicable, requirements concerning:

- identity / exact binding;
- interpretability / representation information;
- provenance / context;
- temporal / version / standing reconstructability;
- integrity / continuity assurance;
- relations / aggregation / derivation;
- rights / use constraints as record-side information;
- organisation / descriptive and access views;
- retrieval sufficiency and coverage/freshness semantics;
- retention/disposition information at the Records boundary;
- transfer / portability / external-dependency survivability;
- significant properties and preservation objectives under transformation.

These are candidate obligation families, not a mandatory universal set.

## Primary derivation inputs to test

Candidate context variables exposed by prior research and external standards:

1. **resource class / identity granularity**;
2. **intended business/future use and protected capability**;
3. **required retrieval/reconstruction questions**;
4. **retention horizon / expected environmental change**;
5. **value / consequence / risk**;
6. **legal, security, privacy, rights or policy constraints**;
7. **expected transformations / migrations / transfers**;
8. **target user/community and assumed knowledge base**;
9. **change/currentness/history characteristics**;
10. **dependency/aggregation structure**.

The pass must test whether these are independent inputs, whether some should merge, and whether material inputs are missing.

## Questions

1. Is a static `profile` the right abstraction, or should the result be a recurrent appraisal/requirements contract that changes with context?
2. Which context variables actually change Records obligations in independent source domains?
3. How should each candidate obligation be classified: baseline, conditional, inherited/external, reconstructable, optional, or out-of-scope?
4. What is the minimum evidence needed to justify including or excluding an obligation?
5. How should requirement strength vary by risk/value/horizon/use without turning into arbitrary scoring?
6. How should retrieval contracts from Pass 5 feed requirements rather than implementation choices?
7. How should transformation/significant-property requirements alter identity/history/preservation obligations?
8. What acceptance/falsification tests can verify that a derived profile is sufficient for the stated use?
9. What changes in context should trigger re-appraisal/re-derivation?
10. Can the method avoid importing Work/Actors/authority decisions while still preserving Records-side facts about responsibilities, rights, retention or designation when required?

## Counter-frames / falsifiers

Actively challenge:

- every prior Records finding should become a requirement;
- one profile can be permanent once created;
- risk can be reduced to one numeric score;
- retention horizon is the dominant scaling variable;
- `mandatory` means object-local metadata field;
- business need alone is sufficient and legal/societal/archival needs are secondary;
- long-term preservation models should govern short-lived operational records;
- retrieval requirements can be inferred from storage/metadata richness;
- all high-value records need the same controls;
- requirement derivation can ignore changing technology, users and knowledge bases;
- the profile itself should decide Actor authority or implementation topology.

## Scope exclusions

Do not select or design:

- database / graph / vector / filesystem / Git / object-store architecture;
- search engine, embedding, ranking or retrieval implementation;
- metadata serialization/schema;
- SOUL memory architecture;
- Work or Actor ontology;
- permission/approval workflow;
- retention authority or legal-hold workflow;
- Development System or SOUL product architecture.

## Evidence lenses

- ISO 15489 records-requirement identification;
- ISO/TR 21946 appraisal, context and risk;
- NARA Universal ERM Requirements and transfer metadata requirements;
- National Archives of Australia fit-for-purpose, minimum metadata and risk/value system-assessment guidance;
- OAIS 3rd Edition Preservation Objectives, Designated Community and Preservation Planning;
- CCSDS IPELTU 653.0-M-1 information preparation over project phases;
- PREMIS implementation/conformance and semantic-unit applicability;
- prior Pass 1–5 Records syntheses and failure modes.

## Operational return condition

Return to the user when:

1. the candidate derivation inputs have been tested across independent authoritative lenses;
2. a bounded architecture-neutral derivation method exists;
3. the method distinguishes requirement purpose from storage/metadata implementation;
4. obligation inclusion/exclusion rules are explicit enough to falsify with scenarios;
5. at least several materially different resource/use/horizon/risk scenarios have been run through the method;
6. a serious adverse pass tests overfitting, checklist inflation, risk-score simplification, archival overreach and architecture drift;
7. recurrence / re-appraisal triggers are explicit;
8. outputs and source trace are persisted;
9. the next Records direction is re-derived from the result rather than inherited from the pre-pass queue.

Meeting this condition does not complete the Records vertical.