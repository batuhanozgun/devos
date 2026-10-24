# Informational Dynamics / Formation–Transformation — Evidence Inventory

**Status:** N0 evidence recovery complete  
**Date:** 2026-09-05  
**Purpose:** identify canonical/internal and selected candidate evidence that can test Dynamics without importing a taxonomy

## 1. Parent Information evidence

### Parent N2 — first-principles problem inventory

Path: `../N2-FIRST-PRINCIPLES-PROBLEM-INVENTORY.md`

Dynamics-relevant problem families recovered:

- P2 — informational access / acquisition / observation formation;
- P6 — derivation / transformation / lineage;
- P8 — temporal applicability / freshness / change in standing;
- P9 — selection / view / context formation;
- P10 — conflict / consistency / plurality when resolution changes state/standing;
- P11 — accessibility / exposure / communication boundary;
- P12 — persistence / memory / recordhood transition.

Parent-level warning retained: these are problem families, not siblings.

### Parent N3 — State vs Dynamics split

Path: `../N3-IMMEDIATE-CHILD-DISCOVERY.md`

Protected Dynamics question recovered:

> How do informational states become available, get generated, selected, transformed, revised, communicated, invalidated or otherwise change?

The parent assigned primary load to acquisition, derivation/transformation and selection/view formation, while treating revision, correction, retraction, exposure and persistence transitions as dynamic aspects needing deeper classification.

### Parent N4 — boundary cases

Path: `../N4-BOUNDARY-ANTI-COLLAPSE.md`

Reusable boundary cases:

- measurement/acquisition process vs measurement result;
- summary/query/aggregation process vs source and output states;
- context assembly dynamics vs model-visible working state;
- belief update / assertion / derivation vs belief/claim content;
- message encoding/transmission/exposure/receipt vs message content;
- persistent lifecycle operations vs persistent informational state.

### Parent N5/N6 — external convergence and omission audit

Paths:

- `../N5-EXTERNAL-CROSS-DOMAIN-FALSIFIERS.md`
- `../N6-OMISSION-REDUCTION-RIVAL-AUDIT.md`

Reusable structural findings:

- metrology and OGC distinguish process/procedure from result;
- W3C PROV distinguishes entities from activities/generation/use/invalidation/derivation;
- belief revision distinguishes belief states/bases from change operations;
- context formation behaves as selection/projection over information relative to use;
- persistence is a deep specialization crossing State and Dynamics rather than a clean parent peer.

These findings support Dynamics existence but do not establish its internal child map.

## 2. Accepted State sibling evidence

Package: `../informational-state/`

Current bounded result:

> Informational State / Representational Constitution is a bounded leaf at current Foundation depth.

Dynamics must therefore preserve the output-side distinctions the sibling found load-bearing:

- reference / applicability;
- content / interpretation / form / mode;
- identity / granularity / equivalence;
- attribution / perspective / standing / freshness / conflict / visibility.

A Dynamics decomposition is suspect if it cannot explain which of these State-side dimensions a transition preserves, changes, creates, loses or rebinds.

## 3. Records / Persistent Information evidence

### Change / time / standing

Path: `../../../../01_verticals/records-artifacts/synthesis/current/CHANGE-TIME-STANDING.md`

Recovered change families:

- creation/capture;
- revision/version creation;
- representation migration;
- semantic derivation;
- supersession;
- correction;
- retraction/reliance withdrawal;
- access removal;
- transfer/custody change;
- destruction/disposition.

Critical finding: one generic `update` is insufficient because changes can affect identity, standing, history and availability differently.

Guardrail: these are semantic families inside persistence scope, not a universal Dynamics enum.

### Organisation / retrieval

Path: `../../../../01_verticals/records-artifacts/synthesis/current/ORGANISATION-RETRIEVAL.md`

Recovered distinctions:

- source resource vs derived/access view;
- retrieval mode and query contract differ;
- a hit does not establish exact identity/currentness/authority/completeness;
- staleness depends on requested as-of/current semantics;
- retrieval can create a selected view without changing the underlying source state.

## 4. Candidate study evidence — Context / Memory / Harness

Package: `../../../../../studies/context-memory-harness-engineering/`

Key synthesis: `04-CROSS-LAYER-SYNTHESIS.md`

Reusable holdouts:

```text
persistence → information survives
retrieval   → information becomes selected/available
context     → information is model-visible now
```

The package also separates:

- memory write/manage/read lifecycle;
- context formation;
- harness/runtime control.

This is useful because retrieval/context formation can fail while persistent state remains correct, and memory can be correct while context is wrong.

Authority boundary: candidate systems research only; not Foundation hierarchy authority.

## 5. Candidate study evidence — AI Knowledge Strategies / RAG

Package: `../../../../../studies/ai-knowledge-strategies/`

Key file: `01-RAG.md`

Reusable failure chain:

```text
source eligibility
→ ingestion/parsing/versioning
→ segmentation/representation/indexing
→ query formation
→ retrieval
→ filtering/reranking
→ context construction
→ evidence use
→ downstream decision/action
```

Load-bearing Dynamics implications:

- retrieval is not source existence;
- query rewriting/decomposition is itself an informational transformation and can drift;
- chunking/normalization can lose scope/provenance qualifiers;
- index/update/invalidation is distinct from query-time selection;
- iterative retrieval can make later information access depend on earlier formed states.

Authority boundary: mechanism research, not Foundation decomposition.

## 6. Candidate study evidence — Anthropic AI-Native SDLC

Package: `../../../../../studies/anthropic-ai-native-sdlc-playbook/`

Key file: `01-PLAYBOOK-RESEARCH.md`

Useful transformation chain:

```text
source signal / idea / incident
→ intent.md
→ spec.md
→ plan.md
→ diff + tests
→ PR/review findings
→ deployment/production evidence
→ incident
→ new intent
```

Reusable Dynamics pressure:

- committed artifacts carry successive informational states;
- each stage transforms or derives information from prior states;
- a revised plan must not erase the distinction between accepted ex-ante plan and retrospective/as-built state;
- production signal → incident → new work intent is a formation/transformation loop;
- artifact existence/history does not prove semantic fidelity.

Authority boundary: software-domain candidate study; not a universal Information lifecycle.

## 7. Recovered candidate dimensions / relations

The following recur across the evidence but are not accepted children:

- input/output cardinality: one→one, many→one, one→many, many→many;
- origin mode: environment/source observation, Actor assertion, derived computation, copied exposure;
- semantic effect: preserve, add, remove, weaken/strengthen, reinterpret, rebind scope, change standing;
- reversibility / reconstructability;
- determinism / reproducibility;
- lineage/provenance binding;
- temporal effect / effective time / known time;
- visibility/availability effect;
- identity effect: same resource/version vs new state/resource/view;
- use-relative selection pressure;
- authority/permission boundary.

## 8. N0 evidence judgment

The recovered evidence is broad enough to begin Dynamics-specific first-principles work.

It strongly supports three facts without yet proving a child hierarchy:

1. formation/acquisition failures differ from output-state constitution failures;
2. state-to-state derivation/transformation failures are load-bearing;
3. selection/exposure/revision/persistence transitions create meaningful Dynamics failures that cannot be reduced to one generic `update` operation.

The unresolved question for N1–N3 is whether these regions form stable immediate children or are better treated as transition modes/dimensions inside one Dynamics leaf.
