# I Have ADHD — Study Metadata

## Identity and status

- **Study ID:** `i-have-adhd`
- **Title:** I Have ADHD — Human-Facing Output Policy, Persistence and Evaluation
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. This package is a durable candidate-registration surface only; no detailed study, methodology, pinned source corpus, findings, medical validation, efficacy replication or adoption work has begun.
- **Research object:** `ayghri/i-have-adhd` as an implemented user-facing response-policy skill/plugin: action-oriented output shaping, session-persistent activation, cross-runtime packaging and comparative evaluation of interaction quality.
- **Canonical external target:** https://github.com/ayghri/i-have-adhd
- **Observed default branch during preliminary qualification:** `main`
- **Discovery / qualification date:** 2026-09-17
- **Observed upstream snapshot during qualification:** `b15d0be58f55b33972ba3e39709e0e5208ef30cb` / package version `0.3.0`. This is a qualification observation, not the pinned corpus of a completed or active study.
- **Pinned research ref:** none. Revalidate upstream and deliberately choose a research snapshot when detailed research is authorised.
- **Freshness risk:** medium/high; skill rules, runtime adapters, persistence behavior and evaluation tooling are actively evolving.

## Why this candidate is registered

A preliminary repository qualification on 2026-09-17 found enough distinct potential value to preserve the target for later research, while deliberately stopping before a research campaign began.

The strongest **qualification signals, not research findings**, were:

- an explicit human-facing response policy centered on next-action visibility, bounded steps, state restatement, tangent suppression, concrete progress and escape hatches when task/safety/harness constraints override the style defaults;
- persistent session behavior with explicit user-controlled activation/deactivation and an optional always-on hook;
- packaging/adaptation across multiple coding-agent runtimes rather than a single host;
- a separation between canonical skill behavior, runtime manifests/hooks and repository guidance;
- an evaluation harness that compares baseline and candidate on identical task cases, isolates operator configuration, pins model/runtime settings, records cost/token/length measurements and supports resumable runs;
- blind comparative judging with condition relabelling/permutation and a rubric that weights correctness, autonomy, actionability, safety and concision separately;
- an explicit release gate rather than treating a better average score as sufficient;
- published first-run results that report both improvements and limitations, including a failed release gate, a broken evaluation case, low trial count, same-family judging and a candidate regression hypothesis.

These observations justify later investigation; they do not establish that the interaction rules are medically correct, generally beneficial, reliably followed across hosts, or suitable for SOUL / Development OS adoption.

## Candidate primary question / purpose

If this study is later authorised, investigate how a user-conditioned interaction/output policy is represented, activated, persisted, overridden and transported across agent hosts; how its effects on correctness, autonomy, actionability, safety and concision are evaluated; and what failure modes appear when response-shaping rules pressure the model toward unsupported certainty or conflict with agent-owned work.

A central SOUL-facing comparison question is whether interaction policy should be treated as a configurable runtime surface that can adapt model-visible responses to a user's working needs without conflating presentation preferences with epistemic truth, authority, safety or diagnosis.

This framing is provisional and must be revisited when research begins rather than treated as a fixed methodology or conclusion.

## Potential Foundation relevance — provisional retrieval hints

- **Actors:** potentially strong for human-agent interaction contracts, user-controlled activation, preference/need-conditioned behavior and authority over communication mode.
- **Information:** conditional/strong for model-visible response shaping, state restatement, salience, omission risk and the distinction between retained analysis versus displayed working set.
- **Work:** conditional/strong for next-action formation, progress visibility, step bounding, error reporting and agent-autonomy handoff behavior.
- **Environment:** conditional/strong for cross-runtime skill/plugin packaging, hook-based persistence, host-specific activation semantics and configuration isolation during evaluation.
- **Relations / control:** potentially strong for precedence among user request, skill policy, harness constraints, safety overrides and task-specific output contracts.

These are retrieval hints only. They do not assign Foundation taxonomy membership or imply a preferred architecture.

## Potential SOUL relevance

Possible future value includes:

- treating human-facing interaction policy as an explicit configurable surface rather than an incidental prompt-style choice;
- separating user communication preferences or working needs from factual confidence, reasoning quality, safety and agent authority;
- studying whether mode persistence should be session-local, user-global, task-scoped or explicitly re-confirmed;
- evaluating whether state restatement, visible progress and bounded next actions improve continuity without hiding relevant complexity;
- pressure-testing how task-specific output contracts and harness/system instructions override a reusable interaction policy;
- learning from a concrete evaluation design that measures quality dimensions rather than optimizing brevity alone.

No SOUL architecture, personalization policy or health-related decision is authorised or implied by this registration.

## Potential Development OS relevance

Possible future value includes:

- user-facing communication ergonomics for long-running development work;
- explicit current-state / next-action presentation during multi-step execution;
- cross-host skill/policy activation and persistence behavior;
- interaction-policy escape hatches for destructive actions, ambiguity, debugging spirals and explicit output contracts;
- comparative evaluation of workflow-facing behavior using isolated baseline/candidate runs, blind judging and release gates;
- failure cases where a stylistic instruction accidentally degrades epistemic caution or pushes work back to the user.

No Development OS design or implementation decision is authorised or implied by this registration.

## Reuse modes

If researched later, the study may become useful as:

- interaction-policy implementation reference;
- human-agent interface design pressure / counterexample;
- cross-runtime portability and persistence case;
- evaluation-harness reference;
- failure-mode / falsifier source for response shaping;
- benchmark/test-case source for user-facing agent behavior.

None of these roles currently constitutes a finding or adoption.

## Likely revisit triggers

Revisit this candidate when:

- asking which discovered studies remain unresearched;
- designing human-agent interaction, output or personalization surfaces;
- studying user-specific communication policy without changing epistemic standards;
- comparing skill persistence, activation and cross-host portability;
- designing evals for style/interaction changes that may affect correctness, autonomy or safety;
- investigating long-running work presentation, state restatement or next-action formation;
- comparing `superpowers`, `mattpocock-skills` or other skill systems on instruction efficacy and evaluation.

## Epistemic and authority boundary

- **No detailed research has been performed.**
- The 2026-09-17 inspection was a preliminary qualification/triage, not a bounded external-target study.
- The repository's statements about ADHD-related reading, working memory, time perception, dopamine or other cognitive/clinical mechanisms are **not accepted here as medical or scientific findings**. They are practitioner/design rationales until independently sourced and evaluated.
- The skill must not be treated as diagnostic guidance, evidence that a user has ADHD, or proof that the rules benefit all people with ADHD or people without it.
- The repository's published evaluation is first-party evidence. Its first recorded run used 14 cases × 3 trials, one pinned model family for generation and judging, reported a failed release gate, identified an unpassable case and noted a possible regression mechanism. These limits must be preserved if the results are later reused.
- A better aggregate score does not by itself establish real-world effectiveness, accessibility benefit, cross-model generality or long-session reliability.
- No live replication, cross-model evaluation, runtime portability campaign, user study or medical/accessibility validation has been performed by this research project.
- This candidate does not define Foundation truth, SOUL architecture, Development OS architecture, personalization policy or implementation requirements.

## Freshness / research-start requirement

Before detailed research begins:

1. re-check the current upstream repository, default branch, release/version and runtime support;
2. choose and record a pinned source commit/ref;
3. separate interaction-design mechanisms from medical/scientific claims and source the latter independently if they become material;
4. inspect the canonical skill, persistence/hooks, runtime adapters and evaluation tooling as separate mechanism surfaces;
5. reproduce or independently challenge evaluation claims before using them as efficacy evidence;
6. establish an explicit research method and scope before accumulating findings.

Current adoption or efficacy claims require fresh authoritative-source and, where relevant, independent evidence validation.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package yet because research has not started.

## Related studies

Potential comparators to recover selectively when research actually begins:

- `../superpowers/` — portable skill procedures, host-conditioned delivery/invocation and instruction-to-execution boundaries;
- `../mattpocock-skills/` — composable engineering disciplines, invocation authority and human-owned orchestration;
- `../context-mode/` — model-visible context shaping, continuity and cross-host control;
- `../context-memory-harness-engineering/` — broader context/memory/harness boundary research;
- `../multi-agent-patterns/` — actor/control and verification topology when subagents or reviewers are used in evaluation.

These relations are discovery hints, not corroboration or evidence.