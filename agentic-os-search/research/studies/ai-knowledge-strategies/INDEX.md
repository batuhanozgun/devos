# AI Knowledge Strategies — INDEX

## Role

Current retrieval router for `research/ai-knowledge-strategies/**`.

Read `STATE.md` first for current package status, handoff and relationship to later research. `00-WHY-THIS-RESEARCH.md` is the original rationale surface and contains initiation-time package-status metadata that is no longer current.

---

## Current routes

| Need | Read first | Then if needed |
|---|---|---|
| Current package status / handoff | `STATE.md` | relevant mechanism file |
| Original rationale / why the five mechanisms were researched | `00-WHY-THIS-RESEARCH.md` | `STATE.md` for current status |
| RAG / external evidence access | `01-RAG.md` | source ledger in same file |
| Knowledge Graph / relation-centric representation | `02-KNOWLEDGE-GRAPH.md` | source ledger in same file |
| Fine-Tuning / parametric adaptation | `03-FINE-TUNING.md` | source ledger in same file |
| CAG / repeated stable context reuse | `04-CAG.md` | source ledger in same file |
| Long Context / whole-package working context | `05-LONG-CONTEXT.md` | source ledger in same file |
| Package-level mechanism summary | `STATE.md` | files 1–5 |
| Context Engineering / agent memory / Harness Engineering | `../context-memory-harness-engineering/STATE.md` | `../context-memory-harness-engineering/INDEX.md` |
| Mapping of these five mechanisms to Context / Memory / Harness | `../context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md` | relevant deep-dive on either side |
| Architecture implication | `STATE.md` + sibling `STATE.md` | **do not infer architecture authority; recover current project/Foundation state and explicit user authorization first** |

---

## Shortest current result

```text
RAG              → external evidence access
Knowledge Graph  → relation-centric representation
Fine-Tuning      → parametric behavior/capability adaptation
CAG              → repeated stable context reuse
Long Context     → whole-package working context
```

These are **not five equal, mutually exclusive architecture options**.

Later research also established that Context Engineering, agent memory systems / “Memory Engineering”, and Harness Engineering should **not** be appended as three more peer mechanisms. They are broader/overlapping engineering problem domains on another classification axis.

---

## Current-state correction

`00-WHY-THIS-RESEARCH.md` was written before files 1–5 existed and still says they were not yet researched. Treat that specific package-status line as a historical initiation snapshot.

Current authority for package status is `STATE.md`.

The chronological `Next planned file` / `stop here` handoffs inside deep-dive files are historical evidence of the sequence in which the package was researched; they are not current authorization.

---

## Guardrail

This package provides technical research and decision boundaries only.

It does not authorize:

- a particular SOUL technology stack,
- RAG/vector database implementation,
- graph ontology/database implementation,
- fine-tuning core governance,
- CAG/cache architecture,
- full-repository Long Context loading,
- Context / Memory / Harness architecture,
- SOUL Foundations mutation,
- agent-control mutation.

For current project authorization, use the appropriate current canonical project/Foundations state rather than inferring authority from a research file.