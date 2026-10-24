# Context / Memory / Harness Engineering — INDEX

## Role

Current retrieval router for `research/context-memory-harness-engineering/**`.

For current package status, handoff and authorization read `STATE.md` first. This router does not independently authorize architecture or implementation work.

---

## Current routes

| Need | Read first | Then if needed |
|---|---|---|
| Current status / handoff | `STATE.md` | relevant research file |
| Why this package exists / terminology caveats | `00-WHY-THIS-RESEARCH.md` | component deep-dives |
| Context Engineering | `01-CONTEXT-ENGINEERING.md` | its source ledger / related AI Knowledge Strategies files |
| Agent memory / “Memory Engineering” | `02-AGENT-MEMORY-ENGINEERING.md` | its source ledger / related RAG/KG/FT/CAG/LC files |
| Harness Engineering | `03-HARNESS-ENGINEERING.md` | its source ledger / runtime/tool/verification sources |
| Context–Memory–Harness relation | `04-CROSS-LAYER-SYNTHESIS.md` | component deep-dives |
| Mapping to RAG / KG / Fine-Tuning / CAG / Long Context | `04-CROSS-LAYER-SYNTHESIS.md` | `../ai-knowledge-strategies/STATE.md` → relevant mechanism file |
| Original mechanism research | `../ai-knowledge-strategies/STATE.md` | `../ai-knowledge-strategies/INDEX.md` |
| Architecture implication | `STATE.md` + `04-CROSS-LAYER-SYNTHESIS.md` | **do not infer architecture authority; obtain explicit later authorization and required project context** |

---

## Shortest current result

```text
Context Engineering
= current model-visible working-set formation and maintenance

Agent Memory Engineering
= cross-time write/manage/read/update/forget lifecycle
  (“Memory Engineering” is an emerging practical label; agent memory is the established research object)

Harness Engineering
= model-external runtime/control environment that operationalizes agent loop,
  tools/interfaces, context/memory plumbing, authority, orchestration,
  verification, observability and continuity
```

These are useful engineering/failure-surface distinctions, **not three proven equal mandatory SOUL architecture layers**.

Key cross-package correction:

```text
RAG             → external evidence / memory-read mechanism feeding context
Knowledge Graph → relation-centric representation / memory-substrate candidate
Fine-Tuning     → adjacent model-adaptation layer
CAG             → repeated-context reuse / efficiency mechanism
Long Context    → whole-package working-context capability
```

---

## Authority and scope guardrail

This package is research evidence/synthesis only.

It does **not** authorize:

- SOUL architecture selection,
- Development OS implementation changes,
- SOUL Foundations hierarchy changes,
- ontology/data-model construction,
- agent-control (`AGENT.md` / `agent/**`) mutation,
- a mandatory Context / Memory / Harness three-layer stack.

Current return condition is user evaluation of the bounded research result.

---

## Source recovery rule

Each deep-research file contains its own source ledger. For load-bearing external claims, recover the cited primary/academic source rather than treating this package synthesis as the source-of-truth for the external claim.

For mechanism-level details, route into `research/ai-knowledge-strategies/` rather than re-deriving RAG / KG / Fine-Tuning / CAG / Long Context from this package summary.