> **29 Eylül 2026 — araştırma yönlendirmesi ile kurulum yönünün ayrımı.** Bu dosya araştırma kütüphanesinin etkin yönlendiricisidir; Foundation, studies ve concepts'in kendi araştırma statüleri korunur. Aşağıdaki eski ChatGPT↔Codex devirleri, eski DevOS hedefleri ve `soul-production` atıfları tarihsel bağlamdır; bugünkü kurulum yetkisi değildir.
>
> DevOS'un kurulum ve çalışma ortamı Claude Code cloud; tek geçerli kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1), yeni ürün deposu [soul-system](https://github.com/batuhanozgun/soul-system)'dir. [D030](../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri) statü geçişini taşır. Claude Code ve DevOS bu depoyu yalnız okur. Araştırmanın kendi STATE kayıtları DevOS'un canlı durumu değildir; eski hedefe talimat gönderme veya kurulum başlatma rotası olarak kullanılmaz. [Depo bakımı](../REPOSITORY-TRANSITION.md) araştırma ve kurulumdan ayrı iştir.

---

# Research — Root Index

## Role

Canonical root router for `research/**`.

This file defines the **research-library classes and retrieval routes** used by the project. It is project-work state, not agent-control. Current work authorization remains in the relevant `STATE.md` surfaces.

## Research classes

### 1. `soul-context/` — bounded project-context reconstruction and current cross-project continuity

Purpose:

- recover why SOUL Research exists;
- preserve source-grounded historical/current context from predecessor/current repositories;
- preserve bounded current cross-project transition context when SOUL Research, Development OS and Production responsibilities materially change;
- keep that context independent of chat memory.

This is **not** the candidate studies library, not Foundation research, not architecture authority, not Development OS current-state authority and not project-wide research methodology.

Start with:

`research/soul-context/INDEX.md`

### 2. `soul-foundations/` — foundational problem-ground research

Purpose:

- develop the first-principles research ground from which later SOUL / Development OS structure can be reasoned;
- preserve the current Foundation hierarchy, bounded findings, node-level research state and authorization.

This is the project's highest-value structural research line. Candidate studies may later inform, falsify, pressure-test or supply mechanisms/evidence to relevant Foundation work, but they do not override Foundation research or become Foundation nodes automatically.

Start with:

`research/soul-foundations/STATE.md`

then:

`research/soul-foundations/INDEX.md`

### 3. `studies/` — candidate research library

Purpose:

- preserve focused-topic, external-target and hybrid studies that may later be useful while deepening Foundation work or designing/building SOUL and Development OS;
- support selective retrieval across a library expected to grow to many hundreds of studies;
- prevent useful research from disappearing after its immediate conversation or question ends.

Start with:

`research/studies/INDEX.md`

For cross-study discovery:

`research/studies/CATALOG.md`

For creation/maintenance rules:

`research/studies/PACKAGE-CONTRACT.md`

## Default placement rule

A new durable research package belongs under `research/studies/<slug>/` when it is neither:

- bounded SOUL project-context reconstruction/current transition context (`soul-context`), nor
- current first-principles Foundation research (`soul-foundations`).

The separately owner-authorised programme restarted on 2026-09-19 lives under [`concepts/`](../concepts/INDEX.md). It first extracts term/jargon uses through full reading of each studies research package in its own context; only after all scoped extraction is complete does it read the outputs together for a shared-reference assessment. It is not an ordinary new study, a continuation of the former concepts method or authority to move existing studies. Current phase and preparation/pilot boundaries live in `concepts/STATE.md`.

Do not classify a study as "external" merely because it uses external sources. Classification is based on the **research object**:

- `focused-topic` — concept/problem/mechanism/method/pattern/technical area;
- `external-target` — one defined external repository/article/product/service/standard/dataset/provider/catalogue or other artefact;
- `hybrid` — both roles are materially present.

## Retrieval routes

| Need | Read first | Then if needed |
|---|---|---|
| Why this project exists / predecessor context | `soul-context/INDEX.md` | relevant evidence / source ledger |
| Current SOUL Development OS context, repo topology, ChatGPT↔Codex handoff or research→development boundary | `soul-context/INDEX.md` | `soul-context/STATE.md` → named current exact contract (brief/review) → actual target-repository state only when relevant; recover dispatch, authority and handoff responsibility from STATE, not historical bootstrap notes |
| Current Foundation status / authorization | `soul-foundations/STATE.md` | `soul-foundations/INDEX.md` → active node package |
| Find prior candidate research relevant to a problem | `studies/CATALOG.md` | relevant package `META.md` → `STATE.md` / `INDEX.md` / findings |
| Understand candidate-library semantics | `studies/INDEX.md` | `studies/PACKAGE-CONTRACT.md` |
| Create a new focused/external/hybrid study | `studies/PACKAGE-CONTRACT.md` | create package `META.md` and update `CATALOG.md` |
| Architecture/design/implementation wants prior research | current project/Foundation state first | `studies/CATALOG.md` → selected studies only |
| Restarted term extraction or later shared-reference work | [`concepts/INDEX.md`](../concepts/INDEX.md) | full cold-start route → `concepts/STATE.md` and purpose/source/method/plan → authorised phase; no inherited definitions or early cross-study normalisation |

## Authority boundaries

- `soul-context` explains project context and bounded cross-project transition state; it does not define the final system or replace the current state of the Development OS repository named in `soul-context/STATE.md` or of `soul-production`. Do not inherit an earlier target's mandate or readiness after a repository change.
- `soul-foundations` is the active foundational research authority for the ground/hierarchy it studies; it is not automatically architecture.
- `studies` contains candidate research inputs. A study can be technically strong and still have **no authority** to mutate Foundation, architecture, ontology, implementation or agent-control.
- Study relevance to Foundation areas is a retrieval relation, not taxonomy membership.
- Current design/implementation authorization must be recovered from the relevant current project state; study completion never grants it.
- Cross-project continuity notes must reference target-repository truth rather than becoming duplicate current-state authorities once the target repository has a reliable canonical state surface.

## Growth model

The candidate library is intentionally designed for large scale.

Do not require a future session to read every study. Use progressive retrieval:

`CATALOG → selected META → package STATE/INDEX → relevant finding → authoritative/current external source when decision-critical`.

A catalog miss is not proof that no relevant study exists; search package names/content when the decision is material and catalog coverage may be stale.

This selective-reuse default does not replace the explicitly authorised full-corpus reading in the concepts extraction programme. That work is deliberately sequenced across packages and turns, with file-level coverage and source/version tracking; it does not require blindly loading the entire library into every session.

## Current candidate studies

The authoritative classification/reuse metadata lives in each package `META.md`. The current short discovery list lives in:

`research/studies/CATALOG.md`

## Epistemic rule

Preserve these distinctions:

- Foundation finding;
- candidate-study finding;
- external-source observation;
- cross-study inference;
- current operational/context note;
- reuse hypothesis;
- candidate design/architecture decision;
- accepted design/architecture decision;
- implementation state.

Do not collapse them because they appear under the same `research/` root.

## Related library outside research

[explorations/INDEX.md](../explorations/INDEX.md) is the separately authorised **Düşünce ve Model Denemeleri** library at repository root. It preserves conceptual dialogues, synthetic demonstrations, draft models and learning/evolution traces; it is not a fourth research class or agent-control layer. Start at [its catalog](../explorations/CATALOG.md) for selective reuse. The first entry is [EXP-001](../explorations/EXP-001-soul-calisma-modeli/INDEX.md). A recorded hypothesis, repeated idea or model in this library is not thereby a Foundation finding, independently verified result or adopted architecture. Relevant future research can link to an exploration without importing its conclusions as axioms.

[concepts/INDEX.md](../concepts/INDEX.md) is the separately authorised **Araştırma Bazında Terim Çıkarımı ve Ortak Referans** programme. Its new purpose and two interpretation/shared-understanding risks are preserved in `concepts/CHARTER.md`, with source user messages in `concepts/ORIGIN.md`. The extraction phase preserves source use, prior research commentary and new interpretation separately; later local-reference acceptance does not rewrite those sources. This programme is not another Foundation ground, architecture authority or agent-control layer. Do not create duplicate study packages or catalogue rows solely for it. Former concepts decisions are not current entry points; preparation and method pilots are not completed extraction or accepted definitions.
