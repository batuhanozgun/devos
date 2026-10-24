# Candidate Studies — Package Contract

## Purpose

Define the minimum durable semantics for packages under `research/studies/**` so a future session can classify, discover, reuse and revalidate research without depending on conversation memory.

This contract governs package shape and metadata only. It does not make candidate studies authoritative for SOUL Foundations, architecture or implementation.

## Separately authorised concepts programme

The programme restarted on 2026-09-19 lives under [`concepts/`](../../concepts/INDEX.md). Its own [STATE](../../concepts/STATE.md) preserves current authority and phase; [CHARTER](../../concepts/CHARTER.md), [METHOD](../../concepts/METHOD.md) and [PLAN](../../concepts/PLAN.md) preserve purpose, provisional method and sequencing. First, every scoped studies research package is fully read and its term/jargon uses extracted in its own context. Only after all extraction is complete are the outputs read together for shared-reference assessment. The former concepts method is not a continuation point; preparation and conversation-only method pilots do not imply completed extraction or accepted meanings.

Its research-specific extraction records are not duplicate candidate-study packages: this contract does not require a second META, CATALOG row or copy under studies solely for that programme. This exception does not relocate existing studies or reclassify an ordinary focused-topic study merely because it concerns a concept. Source research remains in its existing package; source use, prior research commentary and new interpretation stay distinguishable. Common-use acceptance is not study validation, Foundation adoption or architecture authority.

## Required package surface

Every durable candidate study must contain:

`META.md`

`META.md` is the package-local canonical surface for:

- study classification;
- research object;
- reuse relevance;
- cross-phase retrieval hints;
- revalidation expectations;
- package entrypoints.

A package may additionally contain:

- `STATE.md` — current/completion/work state;
- `INDEX.md` — package retrieval router;
- `00-WHY-THIS-RESEARCH.md` or equivalent rationale;
- research findings / synthesis / source ledgers / assessments / evidence files;
- history material when useful.

If `STATE.md` exists, it remains authoritative for package work/completion state. `META.md` must not silently redefine current work authority.

## Study types

Classify by **research object**, not by whether sources are external.

### `focused-topic`

The object is a topic/problem/mechanism/method/pattern/technical field or decision space.

Examples:

- RAG / Knowledge Graph / Fine-Tuning / CAG / Long Context;
- Context / Memory / Harness Engineering;
- multi-agent coordination patterns.

### `external-target`

The object is one specifically identified external artefact or provider surface.

Examples:

- a named GitHub repository;
- one article/playbook;
- a product/service/provider;
- a standard;
- a dataset;
- an API/resource catalogue.

### `hybrid`

A named external target is investigated and the work also deliberately expands into a bounded broader topic/mechanism question such that both roles materially matter.

Do not use `hybrid` just because a focused study cites many external sources.

## Minimum `META.md` fields

Use prose or a compact table/YAML-like block, but preserve these semantics:

- **Study ID / title**
- **Study type** — `focused-topic`, `external-target`, `hybrid`, or explicitly unresolved
- **Status** — planned / active / bounded-complete / evaluation-pending / paused / rejected / superseded / adopted-as-input / other explicit state
- **Research object**
- **Primary question / purpose**
- **Potential Foundation relevance** — one or more areas with strength/conditions when known
- **Potential SOUL relevance**
- **Potential Development OS relevance**
- **Reuse modes** — evidence/reference, falsifier, design pressure, capability discovery, implementation-learning, benchmark/test-case, candidate mechanism, negative option, etc.
- **Likely revisit triggers / stages**
- **Epistemic / authority boundary**
- **Freshness / revalidation requirement**
- **Package entrypoint(s)**
- **Related studies** when materially useful

For `external-target` / `hybrid`, also record when known:

- canonical external target URL/identifier;
- branch/tag/version/ref/commit observed;
- observation/research date;
- target-specific freshness risks.

Do not invent missing fields. Mark them unknown/unresolved when material.

## Foundation relevance semantics

Foundation relevance is deliberately **many-to-many and provisional**.

Allowed style:

- `Information — strong candidate input for retrieval/representation questions`
- `Environment — possible when external capability availability is relevant`
- `Actors — strong for delegation/coordination patterns`

Forbidden interpretation:

- “this study belongs under that Foundation node”;
- “this proves the Foundation tree should contain this mechanism”;
- “this package authorizes Foundation mutation”.

The relevance field exists to help future retrieval, not to pre-build ontology.

## Catalog rule

`research/studies/CATALOG.md` is a **derived discovery index**.

When package classification, status or reuse relevance materially changes:

1. update package `META.md` first;
2. update the corresponding catalog row/summary;
3. preserve package `STATE.md` authority if it exists.

The catalog should remain short enough to scan even when the library reaches hundreds of packages. Put detailed findings in the package, not the catalog.

## Package naming

Use stable lower-kebab-case slugs where practical:

`research/studies/<study-slug>/`

Do not encode transient status or Foundation membership into the folder name.

Good:

- `public-apis`
- `ai-knowledge-strategies`
- `context-memory-harness-engineering`

Avoid:

- `information-rag-final`
- `approved-api-tools`
- `environment-only-public-apis`

because future relevance/status may change.

## External-target research minimum

A durable external-target package should normally include enough evidence to answer:

1. What exactly was inspected?
2. At what ref/version/date?
3. What does the target actually provide?
4. What are its strongest plausible reuse modes?
5. What should **not** be inferred from the research?
6. What current facts must be revalidated before adoption/use?

A link plus a two-line opinion is not sufficient when the study is expected to inform later decisions.

## Focused-topic research minimum

A focused-topic package should normally make recoverable:

1. why the topic was researched;
2. the bounded question/scope;
3. source/evidence basis;
4. main findings and failure modes;
5. relationship to adjacent studies when material;
6. what decisions the research does not yet authorize;
7. reuse/revisit guidance in `META.md`.

## Revalidation rule

Research age alone does not make a study invalid. Revalidation depends on claim type.

Typically re-check before load-bearing adoption when conclusions depend on:

- current APIs/providers;
- repository HEAD/version;
- pricing/free tier;
- current license/terms;
- security/privacy behavior;
- rapidly changing model/library capabilities;
- current benchmark results;
- current standards/spec versions.

Stable conceptual/history findings may need less freshness work but still require source recovery if exact/contested.

## Migration / rename rule

When moving an existing package:

- preserve substantive research blobs/history rather than rewriting content merely for cosmetic consistency;
- update current routers/metadata and load-bearing path references;
- treat chronological historical path mentions as historical unless they would misroute future work;
- verify no current canonical router points at deleted paths.

## Creation completion test

A new study is durably registered only when:

- package exists under `research/studies/**`;
- `META.md` exists;
- `CATALOG.md` contains a discovery entry;
- detailed research or an explicit bounded status/next step is present;
- future sessions can tell whether current external revalidation is needed.

## Core rule

**Candidate studies are a reusable research library: searchable enough to rediscover, structured enough to interpret, and epistemically bounded enough not to become architecture by accident.**
