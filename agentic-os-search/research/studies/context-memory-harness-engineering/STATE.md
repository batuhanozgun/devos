# Context / Memory / Harness Engineering — STATE

**Status:** bounded research package COMPLETE; user evaluation pending  
**Date:** 2026-09-03  
**Architecture status:** **NO ARCHITECTURE DECISION / NO IMPLEMENTATION DECISION**  
**Foundation-tree effect:** none  
**Current authorised substantive activity inside this package:** research requested by user has been executed through cross-layer synthesis; return result for user evaluation  
**Next logical work:** architecture-facing decision synthesis / local benchmark design could follow later  
**Next authorised work:** none beyond reporting/evaluation unless user explicitly requests another phase

---

## 1. Completed package

- `00-WHY-THIS-RESEARCH.md` — rationale, terminology confidence and package boundary
- `01-CONTEXT-ENGINEERING.md` — inference-time working-set formation
- `02-AGENT-MEMORY-ENGINEERING.md` — cross-time memory lifecycle
- `03-HARNESS-ENGINEERING.md` — model-external runtime/control substrate
- `04-CROSS-LAYER-SYNTHESIS.md` — integration with RAG / KG / Fine-Tuning / CAG / Long Context
- `INDEX.md` — retrieval router

All substantive research files above are complete for the current bounded question.

---

## 2. Current bounded research result — not architecture

Current bounded synthesis:

```text
Context Engineering
= current model-visible working-set formation and maintenance

Agent Memory Engineering
= cross-time write/manage/read/update/forget lifecycle
  (“Memory Engineering” is an emerging practical label; agent memory is the established research object)

Harness Engineering
= model-external runtime/control environment that operationalizes agent loop,
  tools/interfaces, context/memory plumbing, permissions, orchestration,
  verification, observability and work continuity
```

These are **not three clean, equal, independent architecture layers**.

- memory read becomes context;
- harness can contain/operate context and memory management;
- Context Engineering itself may employ retrieval, persisted notes, compaction and subagents.

Therefore the triad is most useful as **engineering problem / failure-surface decomposition**, not as a mandatory SOUL stack.

---

## 3. Relation to AI Knowledge Strategies

Canonical related package:

`research/studies/ai-knowledge-strategies/`

Current relation:

```text
RAG              → external evidence / memory read mechanism feeding context
Knowledge Graph  → relation-centric representation / persistent-memory substrate candidate
Fine-Tuning      → adjacent model adaptation layer; not external context/memory
CAG              → repeated-context reuse / runtime efficiency mechanism
Long Context     → whole-package current working-context capability

Context Engineering → decides current model-visible working set
Memory Engineering  → governs persistent/evolving state lifecycle
Harness Engineering → operates and constrains the end-to-end agent system
```

The original five mechanisms remain valid research objects. The new package **reframes rather than replaces** their findings.

---

## 4. Key findings

1. Context / Memory / Harness and RAG / KG / FT / CAG / Long Context do not belong to one classification axis.
2. Context Engineering is broader than Prompt Engineering and narrower/different from full agent runtime design.
3. Agent memory is storage + lifecycle + governance; retrieval alone is insufficient.
4. Persistent memory does not acquire source authority merely by being remembered.
5. Cache/KV reuse is not semantic memory.
6. Long Context is not cross-session memory and does not remove context engineering.
7. Fine-Tuning should remain in the model-adaptation layer rather than being forced into the triad.
8. Harness Engineering is broader than multi-agent orchestration; tools, environment legibility, verification, observability and persistent work state are load-bearing surfaces.
9. Harness components encode model-capability assumptions and can become stale after model upgrades.
10. Repository-local system-of-record + short map + progressive disclosure has independent support in current agent-first engineering practice.
11. Development OS already touches all three problem domains but repository-level control representation must be distinguished from deterministic runtime enforcement.
12. SOUL architecture work, when authorised later, should examine task-conditioned selection across model + memory + context + harness rather than infer a fixed universal stack from this research.

---

## 5. Current project-specific implications

### SOUL

Strong research implication:

> Future system formation may need to choose/configure model capability, persistence/memory, context strategy, tools/authority, verification and orchestration according to Work/Environment conditions.

This is **not yet an architecture decision** because actual workload distribution, benchmark evidence, costs, risk thresholds and other foundation results are not resolved here.

### Development OS

Current repository surfaces map naturally to the new lenses:

- progressive canonical retrieval → Context Engineering
- repository persistent state / handoff → persistence-memory problem
- routing protocols / authority / verification / continuity → harness-like controls

But:

> repo instructions being correct and readable does not prove every required runtime path mechanically enforces them.

This remains an explicit open boundary.

---

## 6. Verification status

This package used:

- primary OpenAI and Anthropic engineering sources,
- peer-reviewed agent-memory / ACI literature,
- current 2026 surveys/preprints with caveats,
- full existing `ai-knowledge-strategies` research package.

It did **not** execute:

- local SOUL/Dev OS context benchmark,
- memory write/read/update benchmark,
- harness component ablation,
- runtime guardrail coverage test,
- security/privacy test,
- cost/latency experiment,
- independent reproduction of vendor engineering results.

Therefore findings are research synthesis, not implementation verification.

---

## 7. Open decision-critical questions before architecture

- actual SOUL Work classes and risk/cost profiles,
- need/value of persistent learned memory by Work type,
- current vs full-context vs RAG/hybrid local quality,
- relation-heavy workload frequency for KG value,
- model/adaptor capability boundaries,
- deterministic runtime enforcement capabilities,
- memory privacy/retention/deletion requirements,
- verification oracle design,
- harness ablation under current/future models,
- tool/ACI quality benchmarks.

---

## 8. Current handoff

**Return condition reached:** the requested topic has been researched to a bounded synthesis and positioned in the repository.  
**User evaluation pending.**  
Do not automatically begin SOUL architecture, Development OS implementation, Foundation hierarchy mutation, agent-control mutation or local benchmark engineering merely because this research completed.
