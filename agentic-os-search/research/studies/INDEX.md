# Candidate Studies — INDEX

## Role

Retrieval router for `research/studies/**`.

This library contains reusable **candidate research**, not Foundation authority or architecture decisions.

Start with `CATALOG.md` when the question is “what prior research might matter here?” Then descend only into selected packages.

## Library semantics

Candidate studies are classified by research object:

- `focused-topic` — concept/problem/mechanism/method/pattern/technical area;
- `external-target` — one defined external repository/article/product/service/standard/dataset/provider/catalogue or other artefact;
- `hybrid` — both roles are materially present.

A study can use external sources without being an `external-target` study.

## Separate term-extraction and shared-reference programme

The programme restarted on 2026-09-19 is reached through [`concepts/INDEX.md`](../../concepts/INDEX.md), whose full cold-start route recovers current STATE, purpose, source user request, draft method and plan. Former concepts decisions and method are not a continuation point.

Its first phase fully reads each studies research package in its own context and extracts term/jargon uses into a separate concepts area for that research. Only after all scoped extraction is complete are the outputs read together for a distinct shared-reference assessment. A seed term does not authorise early cross-study normalisation or accepted local definitions. Two conversation-only method pilots and their evaluations precede durable serial extraction; preparation is not evidence that those pilots have occurred. Current authorisation and actual progress belong to concepts/STATE.md.

Technical/mechanism studies remain in this library. Their source-native terminology, earlier research commentary and the new extractor's interpretations must remain distinguishable. Concepts does not relocate or rewrite source research, duplicate studies in this catalogue, change package completion or grant Foundation/architecture authority. A common-use decision cannot change what a source originally meant.

## Migration note

On 2026-09-04 the existing candidate packages were moved from direct `research/<package>/` paths into `research/studies/<package>/` while their substantive research blobs were preserved by SHA where no content change was required.

Current canonical package locations are the paths under this library and the package `META.md` / `STATE.md` / `INDEX.md` surfaces.

Some chronological rationale or deep-dive documents created before the migration may still contain **historical pre-migration path literals**. Do not treat those literals as current routing authority. Resolve the named package through this `INDEX.md`, `CATALOG.md`, or its current `META.md`.

On 2026-09-16 the first Carbon Layer video's entire `harness-engineering-and-evolution` dossier moved to `the-carbon-layer/videos/mQfTdNVCOB0-harness-engineering/`. The old sibling contains only migration pointers, not another study. Collection STATE owns channel sequencing; local video STATE owns that video's progress. See [migration record](the-carbon-layer/MIGRATION-2026-09-16.md).

## Retrieval flow

```text
CATALOG.md
  ↓ select plausible studies
package/META.md
  ↓ confirm relevance / status / revalidation need
package/STATE.md or INDEX.md when present
  ↓
relevant finding / synthesis / assessment / evidence
  ↓
authoritative current external source when decision-critical
```

Do not load every study merely because the library exists. The explicitly authorised concepts extraction is a different work mode: full coverage is accumulated across research packages and turns, not replaced by this selective-reuse flow or loaded wholesale every turn.

## Current routes

| Need | Read first | Then if needed |
|---|---|---|
| Scan all known candidate studies | `CATALOG.md` | selected package `META.md` |
| Understand package creation/metadata rules | `PACKAGE-CONTRACT.md` | root `../INDEX.md` |
| Work management / project control methodology across classical PM, workflow/case, dependency-graph, spec/artifact, agent-native and ERP systems — bounded complete | `work-management-project-control/META.md` | `STATE.md` → `10-CLOSURE-EVALUATION.md` → relevant completed target package only |
| OpenProject classical project/work-package control | `openproject/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| Flowable durable process/case/decision execution | `flowable/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| Beads dependency graph / ready frontier / claims / liveness | `beads/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| OpenSpec artifact dependency / living-plan control | `openspec/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| GitHub Spec Kit spec-driven decomposition / convergence | `spec-kit/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| Leantime strategy-to-execution alignment | `leantime/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| Gas Town multi-agent orchestration / recovery / integration | `gastown/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| ERPNext project links to time/cost/billing/material/accounting evidence | `erpnext/META.md` | `FINDINGS.md` → `SOURCE-LEDGER.md` |
| The Carbon Layer video collection and video selection | `the-carbon-layer/META.md` | collection STATE → VIDEO-CATALOG → selected video's local STATE/INDEX |
| Visual/practitioner roadmap as a discussion-driven research-gap trigger for agentic systems | `agentic-ai-systems-roadmap/META.md` | `STATE.md` → `INITIAL-ASSESSMENT.md` → `SOURCE-VISUAL.md` / image → related studies |
| Knowledge access / representation / adaptation mechanisms | `ai-knowledge-strategies/META.md` | `STATE.md` → `INDEX.md` / mechanism files |
| Anthropic AI-native SDLC / agent-native software operating model | `anthropic-ai-native-sdlc-playbook/META.md` | `STATE.md` → `INDEX.md` → playbook research / source ledger / SOUL-DevOS assessment / falsifiers |
| Agent memory provider / persistence substrate boundary — planned | `agent-memory-providers/META.md` | paired MongoDB talk + Memorizz seed corpus; detailed research not started |
| Cross-agent persistent memory implementation — planned | `agentmemory/META.md` | persistent multi-agent memory, retrieval/lifecycle and MCP/adapter surface; detailed research not started |
| Claude Code multi-account/session switching — planned | `claude-swap/META.md` | credential/session isolation, usage-aware switching and parallel-session behavior; detailed research not started |
| Cross-agent coding-session continuation/handoff — planned | `cli-continues/META.md` | native-session discovery/parsing plus structured cross-tool handoff; detailed research not started |
| Context / memory / harness engineering | `context-memory-harness-engineering/META.md` | `STATE.md` → `INDEX.md` / cross-layer synthesis |
| Harness composition/evolution — first Carbon Layer video and complementary Meta-Harness research | `the-carbon-layer/videos/mQfTdNVCOB0-harness-engineering/META.md` | local STATE → INDEX → source/evidence/plan; same dossier, historical alias `harness-engineering-and-evolution` |
| ECC portable assets, Work/runtime, memory and authority boundaries — active partial | `ecc/META.md` | package `STATE.md` → `INDEX.md` → relevant bounded note/source ledger; exact execution and open integration limits remain package-local |
| gstack implemented agentic software factory / qualification-control-runtime case | `gstack/META.md` | `CORE.md` → `INDEX.md` → relevant synthesis / revalidation / source ledger |
| Hermes Agent runtime and learning mechanisms — active, partial research | `hermes-agent/META.md` | `STATE.md` → `INDEX.md` → plan / source ledger / bounded mechanism notes |
| Superpowers portable development skills and host-conditioned workflow — active, partial research | `superpowers/META.md` | `STATE.md` → `METHOD.md` / `PLAN.md` → `SOURCE-LEDGER.md` / bounded mechanism notes |
| Ponytail minimal-implementation / reuse-first coding discipline — planned | `ponytail/META.md` | decision ladder, portable skill/plugin delivery and first-party benchmarks; detailed research not started |
| Multi-agent coordination / control patterns | `multi-agent-patterns/META.md` | assessment / conversation synthesis |
| Hands-On LLM repository as evidence/reference corpus | `hands-on-large-language-models/META.md` | repository research → SOUL/DevOS assessment |
| Public/free API discovery catalogue | `public-apis/META.md` | `RESEARCH.md` → current upstream repository/docs |

## Foundation interaction

Candidate studies may be relevant while Foundation work deepens, but Foundation research controls when and how they are used.

Use studies as applicable for:

- evidence or counterexample;
- falsifier / pressure test;
- concrete mechanism knowledge;
- external capability landscape;
- implementation/reference examples;
- benchmark/test-case ideas.

Do not infer from a relevance tag that a study belongs inside a Foundation node.

The `work-management-project-control` study is a bounded comparative corpus, not a new Foundation taxonomy. Its external-target packages preserve incompatible native semantics rather than normalizing them into one universal task model.

The `anthropic-ai-native-sdlc-playbook` and `gstack` studies are both broad across Work, Actors, Information and Environment because their external targets concern end-to-end software operating models. That breadth is a retrieval property, **not** a reason to use either study as a Foundation taxonomy.

`gstack` is especially useful as an implemented pressure test for artifact handoffs, qualification/standing, authority vs capability, runtime/environment dependence, verification routing, production transitions and self-development. Its primary corpus is pinned and its closure revalidation only extends through the current-main commit recorded in its `META.md`; later current-state reuse requires another freshness check.

The `agentic-ai-systems-roadmap` study is different: it is deliberately a **discussion/gap-discovery seed**. Its infographic is not accepted evidence or taxonomy. Its strongest current reuse value is to ask whether evaluation/observability/operational-control, model/runtime execution policy or deployment/resilience questions are genuinely missing, merely fragmented across existing packages, or later-phase concerns that should not yet become research programs.

## Design / architecture interaction

When SOUL or Development OS design/architecture/implementation is later authorised:

1. recover current project/Foundation state first;
2. use `CATALOG.md` to find candidate prior research;
3. inspect selected `META.md` files;
4. recover detailed findings;
5. revalidate current external facts where needed;
6. make the design decision under the then-current authorization and evidence.

Completion of a study never authorizes adoption.

## Current package list

- `agent-memory-providers/`
- `agentic-ai-systems-roadmap/`
- `agentmemory/`
- `ai-knowledge-strategies/`
- `ai-memory/`
- `anthropic-ai-native-sdlc-playbook/`
- `beads/`
- `claude-swap/`
- `cli-continues/`
- `context-memory-harness-engineering/`
- `context-mode/`
- `deepseek-harness/`
- `ecc/`
- `erpnext/`
- `flowable/`
- `gastown/`
- `gstack/`
- `hands-on-large-language-models/`
- `hermes-agent/`
- `i-have-adhd/`
- `leantime/`
- `llm-wiki/`
- `mattpocock-skills/`
- `multi-agent-patterns/`
- `openproject/`
- `openspec/`
- `openviking/`
- `ponytail/`
- `public-apis/`
- `recursive-prerequisite-discovery/`
- `spec-kit/`
- `superpowers/`
- `the-carbon-layer/` — includes `videos/mQfTdNVCOB0-harness-engineering/`; the retired sibling is navigation only.
- `work-management-project-control/`

The library is expected to grow substantially. `CATALOG.md` should remain a compact discovery surface rather than a second synthesis corpus.
