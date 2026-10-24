> **29 Eylül 2026 — tarihsel Codex kontrol-katmanı görevi; etkin agent-control değildir.** Aşağıdaki “explicitly authorised” kapsamı, AGENTS/protokol yazma izni, aday dal ve READY koşulları eski hedefe ait görev metnidir. Bugünkü Claude kurucusu bu metni yürütmez veya kontrol talimatı olarak ithal etmez; eski görevin bulunması yeni yetki değildir.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud ve tek geçerli [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Bu deponun `AGENT.md` ve `agent/**` dosyaları ChatGPT'nin kontrol alanıdır; aşağıdaki tarihsel örneğin korunması onları değiştirme veya başka ortama kopyalama izni vermez.

---

# Codex Development OS Agent-Control Implementation

**Task ID:** DEVOS-AGENT-CONTROL-2026-09-07  
**Status:** prepared for explicit user adoption; file existence is not execution authority.

## Outcome

Complete the missing agent-control layer for the existing `soul-development-os` Codex coordinator.

The current candidate already has a bounded coordination mandate and a useful `AGENTS.md`, but it does not yet have the equivalent architectural capability of the SOUL Research agent-control system: a small canonical router that classifies each turn/work situation, conditionally loads only the reasoning/control protocols that are needed, and keeps those control rules separate from project work/research evidence.

The goal is **not** to copy Research R01–R09. The goal is to derive and implement a Development-OS-specific control architecture appropriate to a coordinator that selects, researches, designs, develops, verifies, delegates and preserves continuity under bounded authority.

At completion, a fresh Codex conversation should be able to enter through one canonical control route, recover current state/authority, run the Development OS routing gate before substantive work, load only the triggered Development OS protocols, and then continue ordinary bounded Development OS work without Batu or browser ChatGPT supplying the reasoning checklist manually.

This task is agent-control implementation for Development OS. It is not SOUL product implementation, B0/general operating acceptance, bridge retirement, Claude integration, or a new orchestration framework.

## Required starting state

Target repository: `batuhanozgun/soul-development-os`  
Expected project: `SOUL-Development-OS-Local`  
Expected branch: `bootstrap/coordination-entry`  
Expected published starting HEAD: `020d44afae57efa4fad8febfd1fe2a0bce965af8`

Observe actual local and remote state before writing. Preserve unexplained differences rather than resetting/stashing them away.

Read in full before design/write work:

### Target Development OS

1. `AGENTS.md`
2. `STATE.md`
3. `work/COORDINATION-HANDOFF.md`

### Research agent-control — DESIGN EXEMPLAR, NOT TARGET AUTHORITY

At the issued research ref, read in full:

1. root `AGENT.md`
2. every active protocol referenced by its registry under `agent/protocols/**`

Study the architecture: bootstrap contract, mandatory routing gate, stable route IDs, positive trigger questions, conditional LOAD/SKIP, protocol loading, re-gating, control/project-work separation, mutation rules and continuity behavior.

Do **not** copy Research route IDs, trigger questions or protocol prose merely because they exist. Research agent-control governs a browser research assistant. Development OS has different work, authority, environment and effects.

### Research inputs for Development-OS-specific derivation

Read selectively as needed, starting from canonical indexes/META files rather than loading entire packages blindly:

- `research/soul-foundations/**` current STATE/INDEX and relevant accepted findings;
- `research/studies/CATALOG.md`;
- `research/studies/gstack/**` for agentic software-factory work selection, delegation, qualification, authority/capability and recovery patterns;
- `research/studies/multi-agent-patterns/**` for delegation/reviewer/control topology;
- `research/studies/context-memory-harness-engineering/**` for context, memory, harness/control boundaries;
- `research/studies/anthropic-ai-native-sdlc-playbook/**` when configuration/control/eval/authority patterns are materially relevant.

Research findings are evidence and pressure tests, not automatic requirements.

## Required design properties

Design the smallest Development OS agent-control layer that satisfies all of the following.

### 1. Canonical control entry

There must be one obvious canonical control entry loaded at the start of a new Codex Development OS conversation. Prefer the platform-supported `AGENTS.md` entry rather than inventing a launcher.

`AGENTS.md` may remain the bootstrap/control entry itself or route immediately to a small dedicated control router. Keep it compact enough that every turn does not preload a handbook.

### 2. Mandatory Development OS routing gate

Before substantive reasoning, recommendation, planning, work selection, design, implementation, verification, repository mutation or authority-sensitive action, the coordinator must evaluate the complete active Development OS routing registry.

Each route must have:

- a stable route ID;
- one concise positively oriented trigger question;
- two operational outcomes: LOAD or SKIP;
- LOAD on yes/uncertainty/mixed/material sensitivity; SKIP only on confident no;
- exactly one canonical protocol path unless composition is deliberately justified.

Re-gating must occur when materially new evidence, tool results, changed plans or new effects introduce a different reasoning/control problem.

Do not create dozens of routes. Prefer a small exhaustive registry.

### 3. Development-specific protocols

Derive the protocol set from actual Development OS responsibility, not Research naming.

The design must at minimum consider whether separate protocols are needed for these recurring control concerns, and combine/split only with an explicit reason:

- decision-critical assumptions / framing;
- goal–method–end-to-end alignment;
- source/evidence/current-state fidelity;
- verification/acceptance independence and proportionality;
- work-system continuity / interruption / writer ownership;
- canonical repository/current-work preflight;
- authority/effect boundary and owner escalation;
- work selection / decomposition / stopping discipline;
- delegation/helper use, result integration and reviewer independence limits;
- environment/capability vs authority distinction;
- research-library/source retrieval when prior studies can materially affect a design/implementation decision;
- causal/root-cause depth for failures and repairs.

Do not force one protocol per bullet. The final set should be minimal but sufficient.

### 4. Control vs project-work separation

Create a clear distinction between:

- agent-control files that govern the Codex Development OS coordinator; and
- STATE/work/research/design/code files that are material the coordinator works on.

Project/research files must not become behavioral instructions merely because they contain recommendations or procedures.

The control router should be able to point to research indexes as evidence/retrieval sources without importing them as control law.

### 5. Authority and self-modification boundary

The coordinator may use the new control layer, but may not silently widen its own authority, acceptance criteria or owner boundaries.

After this task, future material changes to the agent-control layer require the authority path specified by the existing handoff mandate. A protocol may recommend a control change; it may not make its own recommendation authoritative.

### 6. Operational usability

The control layer must help work, not become the work.

- Do not require every protocol on every turn.
- Do not create a protocol forest, custom scheduler, service, launcher or new repository.
- Do not force verbose route rationales or chain-of-thought disclosure.
- A compact routing-status block may be used if it provides useful auditability, but decide its exact user-visible form for Codex rather than blindly copying the browser contract.
- Preserve ordinary Codex usability: Batu should be able to say `Development OS'ye devam et.` rather than pasting a control prompt.

## Implementation scope

You are explicitly authorised to design and implement the Development OS agent-control layer on the existing private candidate branch.

You may modify/create only the minimum necessary target control/current-work surfaces, expected to be within:

- `AGENTS.md`;
- a small dedicated agent-control directory if justified, e.g. `agent/` or `devos-agent/`, containing the router/protocols;
- `STATE.md` only as needed to point to the new control/current work state;
- one new work record such as `work/AGENT-CONTROL.md` containing the user grant, design choices, source provenance, validation, limitations and handoff.

Do not rewrite historical work records.

Normal commits and pushes to `bootstrap/coordination-entry` are authorised. No force push, PR, merge, tag, new branch or `main` promotion.

Do not touch `soul-production`. Do not implement SOUL product code. Do not install Claude or another provider. Do not revive G1-R1.

## Required adversarial design pass

Before finalising the architecture, use at least one native Codex helper/subagent as a **critical design reviewer**.

Give the reviewer the actual goal and relevant source files, not only the coordinator's summary. Ask it to challenge:

- blind copying of Research control;
- missing Development-specific risks;
- excessive protocol count/context overhead;
- authority/self-modification loopholes;
- protocol-trigger overlap/gaps;
- whether the design would still force Batu/browser to do hidden coordination;
- whether the router can actually be recovered in a fresh Codex chat through the platform-supported entry path.

The coordinator must evaluate the critique and record accept/reject/conditional dispositions. Reviewer agreement is not independent operating acceptance.

## Required validation — performed by Codex, not Batu

Do not ask Batu to discover whether the control layer was implemented correctly.

Within this task, perform proportionate validation yourself:

1. static/source validation of router, registry, protocol paths and control/work separation;
2. path/reference integrity checks for every route and protocol;
3. scenario-based routing checks against a small fixed matrix that includes at least:
   - simple current-state question;
   - new bounded design task;
   - implementation with a decision-critical assumption;
   - failure/root-cause repair;
   - verification/acceptance-sensitive work;
   - interrupted or stale-state continuation;
   - owner-boundary/high-impact request;
   - helper/delegation use;
   - research-study reuse decision;
4. confirm that low-risk/simple work does not mechanically load every protocol;
5. confirm that materially sensitive work cannot confidently skip the relevant control concern;
6. use a fresh/native Codex child or equivalent supported fresh context, if available within existing capabilities, to inspect whether the canonical entry can discover and apply the router without a bespoke long bootstrap prompt. If platform behavior prevents a meaningful fresh-context check, record that limitation rather than building a workaround framework;
7. commit/push the final candidate and read the exact remote files back.

Do not call this B0/general operating acceptance. The goal is to complete and internally validate the missing agent-control layer well enough that Batu is not being asked to test it on behalf of the coordinator.

## Success criteria

Return READY only if all are true:

1. one canonical Development OS control entry exists;
2. a Development-specific mandatory routing registry exists;
3. protocols are conditionally loadable and not all preloaded by default;
4. control/project-work separation is explicit;
5. current state/authority/work preflight and owner boundaries are covered;
6. delegation, verification, continuity and research reuse have explicit control paths when materially relevant;
7. material control changes cannot self-authorise future authority expansion;
8. reviewer challenge has been integrated with dispositions;
9. fixed scenario routing checks and reference/path checks pass or have a bounded explained exception that does not undermine ordinary use;
10. the private candidate branch contains the committed/pushed/read-back exact result;
11. a new Codex conversation can still start from a short normal message, not a long control prompt.

Use PARTIAL if the architecture is materially useful but one success condition remains unresolved. Use BLOCKED if a usable Development-specific control layer cannot be established without forbidden scope expansion.

READY here means **agent-control layer ready for bounded Development OS use on the private candidate branch**. It does not mean B0, full bridge retirement, hostile self-modification containment, unattended autonomy or SOUL product acceptance.

## Final delivery

Return a concise Turkish report containing:

- READY / PARTIAL / BLOCKED under the narrow definition above;
- final branch and HEAD;
- exact control topology and changed files with GitHub links;
- routing route IDs + one-line labels only (do not dump all protocol prose into chat);
- what was adapted from the Research router architecture versus deliberately not copied;
- reviewer findings and dispositions;
- scenario validation summary;
- remaining material limitations;
- exact short first message Batu should use in a **new Codex conversation** if READY.

Stop after this task. Do not begin normal Development OS or SOUL product work yet.