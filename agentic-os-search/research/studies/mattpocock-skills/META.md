# Matt Pocock Skills — Study Metadata

## Identity and status

- **Study ID:** `mattpocock-skills`
- **Title:** Matt Pocock Skills — Composable Engineering Disciplines and Human-Owned Orchestration
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package is a durable candidate-registration surface only; no detailed study, methodology, pinned source corpus, findings, synthesis, efficacy evaluation or adoption work has begun.
- **Research object:** `mattpocock/skills` as a repository of composable agent skills and an engineering-work model built around invocation authority, domain language, persistent work artifacts, multi-session decision planning, verification and retrospective environment improvement.
- **Canonical external target:** https://github.com/mattpocock/skills
- **Observed default branch during preliminary qualification:** `main`
- **Discovery / qualification date:** 2026-09-17
- **Observed upstream snapshot during qualification:** `959a8e9f1edc3adbe2f7e3054bb6fbefa6696260` / package version `1.2.3`. This is a qualification observation, not the pinned corpus of a completed or active study.
- **Pinned research ref:** none. Revalidate upstream and deliberately choose a research snapshot when detailed research is authorised.
- **Freshness risk:** medium/high; skills, invocation rules, workflow design and in-progress mechanisms are actively evolving.

## Why this candidate is registered

A preliminary repository qualification on 2026-09-17 found enough distinct potential value to preserve the target for later research, while deliberately stopping before a research campaign began.

The strongest **qualification signals, not research findings**, were:

- an explicit split between **user-invoked** orchestration skills and **model-invoked** reusable disciplines, with human-owned invocation boundaries;
- a rule that user-invoked skills cannot silently chain into other user-owned workflows, while they may delegate to model-invoked disciplines;
- project-level domain-language artifacts (`CONTEXT.md`, optional context maps and ADRs) used as persistent shared vocabulary rather than general-purpose specs;
- issue-tracker-backed work state and multi-session planning through `wayfinder`, including destination, decision tickets, blocking relationships, frontier and deliberately unresolved “fog of war”;
- spec → issue/ticket → implementation → TDD/debugging → code-review flows expressed as composable procedures rather than one monolithic process owner;
- verification separation such as Standards vs Spec review axes delegated to separate subagents;
- repository-specific setup that adapts portable skills to the local issue tracker, domain-doc layout and agent instruction surface;
- an in-progress retrospective mechanism that turns repeated agent failures into navigation improvements, information access, reviewer guidance or deterministic checks, preferring mechanical enforcement over prompt rules when possible.

These observations justify later investigation; they do not establish that the skills are reliably invoked, faithfully followed, improve engineering outcomes, generalise across models/hosts or should be adopted.

## Candidate primary question / purpose

If this study is later authorised, investigate whether and how a development operating model can be composed from small reusable agent disciplines while preserving human-owned orchestration, durable work state, domain language, staged verification and environment evolution; then test where those procedures depend on model/host behaviour rather than enforceable runtime mechanisms.

A central SOUL / Development OS comparison question is whether large agentic work should be governed by one central workflow/harness or by a smaller set of composable disciplines connected through explicit authority, persistent artifacts and progressively discovered work structure.

This framing is provisional and must be revisited when research begins rather than treated as a fixed methodology or conclusion.

## Potential Foundation relevance — provisional retrieval hints

- **Information:** potentially strong for domain vocabulary, context compression through canonical language, ADR boundaries, specs/issue artifacts and source-of-truth separation.
- **Work:** potentially strong for spec/ticket/implementation/review transitions, multi-session work, decision frontiers, progressive decomposition and return-to-work continuity.
- **Actors:** potentially strong for human-owned orchestration, model-invoked disciplines, reviewer/implementer separation, HITL vs AFK work and subagent role boundaries.
- **Environment:** conditional/strong where repo-local configuration, issue trackers, deterministic checks, tool/information access and retrospective environment improvement matter.
- **Relations / control:** potentially strong for invocation authority, blocking/dependency relations, review separation, work claiming and procedural composition.

These are retrieval hints only. They do not assign Foundation taxonomy membership or imply a preferred architecture.

## Potential SOUL relevance

Possible future value includes:

- pressure-testing human-owned workflow selection versus model-autonomous procedure selection;
- studying whether canonical domain language can reduce ambiguity and model-visible context without collapsing important distinctions;
- comparing progressive work discovery/frontier models with fixed upfront decomposition;
- examining persistent external work-state as an alternative or complement to conversational state;
- studying how repeated failures can evolve the environment, information access, reviewer rules or deterministic controls;
- testing the boundary between portable procedural knowledge and runtime-enforced behaviour.

No SOUL architecture decision is authorised or implied by this registration.

## Potential Development OS relevance

Possible future value includes:

- composable engineering workflows rather than one monolithic software-development process;
- issue-tracker-backed multi-session decision/work state;
- domain vocabulary and ADR discipline as agent-facing information surfaces;
- spec → implementation → review lifecycle examples;
- review-axis separation and subagent context isolation;
- explicit authority over which workflows humans versus models may initiate;
- retrospective-driven conversion of recurring failures into better navigation, information access or deterministic guardrails.

No Development OS design or implementation decision is authorised or implied by this registration.

## Reuse modes

If researched later, the study may become useful as:

- implementation/practice reference;
- workflow and authority design pressure;
- comparison target for Superpowers, gstack and other agentic SDLC systems;
- counterexample/falsifier for centralized workflow assumptions;
- candidate mechanism source for multi-session planning, domain context, review or environment evolution;
- evaluation/test-case source for skill invocation, adherence and effect.

None of these roles currently constitutes a finding or adoption.

## Likely revisit triggers

Revisit this candidate when:

- asking which discovered studies remain unresearched;
- comparing portable agent-skill systems or workflow composition models;
- studying human/model authority over workflow initiation;
- designing or evaluating multi-session planning and progressive work discovery;
- examining domain vocabulary, ADRs or persistent work artifacts as agent context;
- comparing instruction-based procedures with deterministic enforcement;
- studying retrospective/self-improving development environments;
- comparing Superpowers, gstack or future Development OS workflow models.

## Epistemic and authority boundary

- **No detailed research has been performed.**
- The 2026-09-17 inspection was a preliminary qualification/triage, not a bounded external-target study.
- No source ledger, complete skill-topology coverage, invocation campaign, live host/model evaluation, engineering-outcome benchmark, independent verification or closure audit exists for this package.
- Preliminary observations must not be cited as established study findings without re-entering the authoritative external source.
- Skill prose describes intended procedures; existence, installation or apparent clarity does not establish reliable invocation, adherence, efficacy or portability.
- Repository claims about better code, lower token use or workflow quality require later evidence if they become load-bearing.
- This candidate does not define Foundation truth, SOUL architecture, Development OS architecture, dependency selection or implementation policy.

## Freshness / research-start requirement

Before detailed research begins:

1. re-check the current upstream repository, default branch and skill inventory;
2. choose and record a pinned source commit/ref;
3. establish an explicit research method that separates procedure text, host invocation semantics, observable execution and engineering efficacy;
4. recover and compare relevant existing studies selectively, especially `superpowers`, `gstack`, `recursive-prerequisite-discovery` and Development-OS-adjacent sources;
5. keep preliminary qualification observations separate from later source-grounded findings.

Current operational or adoption claims require fresh host/model validation even after a future bounded source study is completed.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, `INDEX.md`, source ledger or findings package yet because research has not started.

## Related studies

Potential comparators to recover selectively when research actually begins:

- `../superpowers/` — portable development procedures, skill discovery/invocation and host-conditioned behaviour;
- `../gstack/` — implemented agentic software factory and work/qualification/control system;
- `../recursive-prerequisite-discovery/` — discovery-driven work and actionable-frontier reasoning;
- `../multi-agent-patterns/` — coordination, authority and verification topology;
- `../context-memory-harness-engineering/` — context, persistence and harness/control boundaries.

These relations are discovery hints, not corroboration or evidence.