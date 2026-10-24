# Flowable — Study Metadata

## Identity and status

- **Study ID:** `flowable`
- **Title:** Flowable — Durable Process, Case and Decision Control
- **Study type:** `external-target`
- **Status:** **BOUNDED-COMPLETE / FIRST-WAVE WORK-CONTROL SLICE**. U02 of `work-management-project-control` completed as a source-bounded engine/control study; no deployment, load test, business-process adoption or live human-task campaign was performed.
- **Research object:** `flowable/flowable-engine` as an implemented durable work-execution platform spanning BPMN process execution, CMMN case-plan execution and DMN repeatable decision evaluation.
- **Canonical external target:** https://github.com/flowable/flowable-engine
- **Observed default branch:** `main`
- **Pinned research ref:** `42aa81de65ce48572577c1826ba5d16135347aff`
- **Observed latest release:** `flowable-8.0.0` (published 2026-02-27)
- **Research date:** 2026-09-17
- **License observed:** Apache-2.0
- **Freshness risk:** medium/high. Main is active; current HEAD itself changes CMMN CaseTask/ProcessTask variable inheritance, while release and main may differ materially.

## Primary question / purpose

What changes when a work-management system does not merely track work state but **executes** durable process/case transitions, waits for humans/events, runs system activities, evaluates decisions, retries jobs and preserves engine state across restarts?

This unit supplies the first execution-engine contrast to OpenProject's project/work-package control baseline.

## Source-bounded synthesis

Flowable exposes three materially different control formalisms:

- **BPMN process** — a process definition is instantiated and execution follows directed sequence flow through activities, gateways and events. The engine persists process state at wait states such as user tasks and resumes from that state when the relevant event/task completion occurs.
- **CMMN case** — a case definition contains a case plan model made of plan items such as human tasks, process tasks, case tasks, stages and milestones. Plan-item instances have an explicit lifecycle (`available`, `enabled`, `active`, `suspended`, `completed`, `failed`, `terminated`, plus engine-specific intermediary states). Entry/exit sentries and plan-item control rules determine when work becomes available/active, when manual activation is required, whether it is required for completion and whether it may repeat.
- **DMN decision** — repeatable decision logic is modelled independently as decision tables and can be invoked from BPMN; flow and decision logic need not be encoded in the same structure.

Flowable therefore separates at least three questions that task trackers often collapse:

1. **What sequence/event structure drives execution?** — BPMN.
2. **What case work is available, required, manually activated, repeated or ended under changing conditions?** — CMMN.
3. **What decision result follows from explicit inputs/rules?** — DMN.

The engine is durable rather than representational-only: process definitions and runtime wait states are persisted; user tasks may be offered to candidate groups and then claimed by one assignee; timers and async continuations are persisted jobs; runtime state can survive engine crash/restart. Process instances can be migrated to newer definitions with validation and activity mappings. BPMN also has cancellation/compensation constructs, and async/external work has retry/dead-letter mechanics.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** very strong for executable state transition, wait/event semantics, adaptive case-plan control, migration and compensation.
- **Actors:** strong for candidate/assignee human tasks, human/system activity composition and manual activation.
- **Information:** strong/conditional for durable runtime state, variables, history, decision inputs/outputs and migration mappings.
- **Environment:** strong for timers, external workers, async jobs, event sources and engine persistence.
- **Relations / control:** very strong for sequence flow, sentries, lifecycle transitions, required/manual/repetition rules, cancellation, compensation and decision-policy separation.

These are retrieval hints only. They do not assign Foundation taxonomy membership.

## Potential SOUL relevance

- distinguish tracking a work state from being the runtime that causes/guards its transitions;
- choose prescriptive process flow versus condition-driven case management by work shape instead of forcing all work into tasks;
- model “available”, “enabled”, “active” and terminal standings separately when human discretion matters;
- keep repeatable decision policy separable from execution flow;
- make wait/retry/timeout/event/compensation semantics first-class for real-world work;
- support migration/replanning of already-running work without pretending new plans apply automatically.

No SOUL workflow/case/runtime architecture is authorised or implied.

## Potential Development OS relevance

- durable work execution across sessions/restarts;
- human task candidate→claim→assignee semantics;
- event/timer-driven readiness and wake-up;
- case-plan item lifecycle and manual activation;
- retries/dead-letter behavior for executable work;
- process-instance migration for in-flight plan changes;
- compensation/cancellation as distinct from simple “reopen”;
- explicit decision tables as policy components.

No Development OS design or implementation decision is authorised or implied.

## Reuse modes

- workflow/case execution baseline;
- counterexample to tracker-only state models;
- adaptive-case mechanism source;
- reversal/retry/migration pressure test;
- human/system coordination reference;
- comparison target for Beads/OpenSpec/Spec Kit/Gas Town.

## What should not be inferred

- BPMN is not established as the right model for uncertain or exploratory work.
- CMMN support does not prove that every form of emergent project planning is naturally expressible as a case model.
- The repository's CMMN schema contains discretionary-item/planning-table constructs, but this bounded slice did not establish full runtime semantics for discretionary planning; do not use that as a finding without deeper validation.
- Engine persistence/retry features do not establish business-level idempotency or correct compensation for external effects.
- Source reading does not establish production scalability, operator usability or organizational effectiveness.

## Freshness / revalidation

Re-check main/release alignment before load-bearing reuse, especially process/case migration, CMMN control rules, job retry/dead-letter behavior and cross-engine task inheritance.

## Package entrypoints

1. `FINDINGS.md`
2. `SOURCE-LEDGER.md`
3. this `META.md`

## Related studies

- `../work-management-project-control/` — parent comparative program; Flowable is U02
- `../openproject/` — U01 tracker/project-control contrast
- `../multi-agent-patterns/`
- `../recursive-prerequisite-discovery/`
