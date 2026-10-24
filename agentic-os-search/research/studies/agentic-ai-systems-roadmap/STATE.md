# Agentic AI Systems Roadmap — STATE

**Updated:** 2026-09-12  
**Status:** discussion-open / seed registered  
**Current authorised activity:** preserve and discuss the roadmap as a candidate research trigger; identify plausible research gaps or tensions against current Foundation and studies  
**Not authorised by this state:** automatic deep-research campaign, Foundation mutation, architecture choice, implementation, framework adoption

## What is complete

This package has been created as a separate candidate study.

Completed in the seed turn:

- the user-supplied roadmap visual was preserved as a repository image copy;
- the original attachment identity and SHA-256 were recorded;
- the visible boxes, bullets, layer legend and main arrow structure were transcribed in `SOURCE-VISUAL.md`;
- the source's authority boundary was made explicit: the infographic is a research prompt, not a validated taxonomy;
- a first comparative pass against current SOUL Foundation state and selected relevant studies was recorded in `INITIAL-ASSESSMENT.md`;
- candidate follow-up research seams were identified without opening separate study packages yet.

## Current interpretation boundary

The visual is useful primarily as a **coverage and systems-engineering prompt**. It must not be read as proof that SOUL is missing a top-level Foundation ground or that its five layers should become architecture.

The strongest current signal is not any single box. It is the possibility that the existing candidate-study library contains many pieces of an operational agent system — retrieval, memory, orchestration, runtime, verification, controls and production feedback — while some **cross-cutting operational research questions remain fragmented rather than independently studied**.

That remains a candidate interpretation, not an accepted Foundation conclusion.

## Candidate follow-up seams

These are discussion/research candidates, not activated packages:

1. **Agentic-system evaluation + observability + operational control loop**  
   How task success, offline evals, runtime traces, drift/failure signals, auditability and feedback become evidence that can change agent/system standing and future behavior.

2. **Model/runtime policy + production integration**  
   How model routing, context budgets, latency/cost trade-offs, retries/fallbacks, deterministic wrappers, structured outputs and validation should be governed as one execution-policy surface.

3. **Agentic deployment + resilience as operating reality**  
   How async execution, persistent workers, serverless/container trade-offs, quotas, scaling, retries and degraded modes change what the agent system can actually guarantee.

4. **Cross-cutting controls versus layered roadmaps**  
   Whether governance, observability, verification and authority can legitimately be placed “after” agent architecture, or whether they are orthogonal relations/controls that must bind every layer.

## Existing coverage that should not be mistaken for gaps

The package should re-enter existing studies before launching duplicate research:

- retrieval / knowledge strategy → `ai-knowledge-strategies`;
- context / memory / harness → `context-memory-harness-engineering`;
- multi-agent coordination → `multi-agent-patterns`;
- operational SDLC controls / telemetry / governance → `anthropic-ai-native-sdlc-playbook`;
- implemented runtime / qualification / verification / recovery loops → `gstack`.

A future research question should therefore begin by asking whether it is **actually missing**, merely fragmented, or already adequately covered under different terminology.

## Open questions

- What is the authoritative original publication source and date for the infographic?
- Are the arrows intended as learning order, implementation dependency, causal dependency or only visual flow?
- Which candidate seam above survives a deeper overlap check against existing studies?
- Does evaluation infrastructure deserve a standalone focused-topic study, or is it better researched as part of a wider operational-control loop?
- Does model/runtime policy deserve its own study, or is `context-memory-harness-engineering` already the correct parent research surface?
- When later architecture work is authorised, should evaluation/observability/governance be modeled as components, relations, controls, standing/evidence mechanisms or some combination?

## Next logical work

Continue free-form discussion with the user using `INITIAL-ASSESSMENT.md` as the starting point. When a concrete high-value research question emerges, first perform an overlap/reuse check against `research/studies/CATALOG.md` and the selected package `META.md` files, then decide whether a new focused study is warranted.

## Next authorised work

User-led discussion and bounded clarification around this roadmap study. No separate deep-research branch is automatically activated by this seed.

## Fresh-session recovery

Start with:

`META.md → STATE.md → INITIAL-ASSESSMENT.md → SOURCE-VISUAL.md`

Then use the related-study links in `META.md` selectively. Current Foundation authority remains in `research/soul-foundations/STATE.md`.
