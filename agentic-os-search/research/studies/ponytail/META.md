# Ponytail — Study Metadata

## Identity and status

- **Study ID:** `ponytail`
- **Title:** Ponytail — Minimal-Implementation, Reuse-First Coding Discipline for AI Agents
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. Candidate registration and preliminary intake only; no detailed methodology, source corpus, benchmark replication, runtime evaluation, safety validation or adoption work has begun.
- **Research object:** `DietrichGebert/ponytail` as a portable skill/plugin that conditions coding agents to avoid unnecessary implementation, reuse existing code, prefer standard-library/native-platform/already-installed capabilities, and only then write the minimum additional code required.
- **Canonical external target:** https://github.com/DietrichGebert/ponytail
- **Observed default branch during intake:** `main`
- **Observed upstream snapshot during intake:** `e3ba2aa6f1e6f0bc4d69eb09c9f0d0a93af56156`
- **Registration / intake date:** 2026-09-20
- **Registration authority:** user requested adding the repository to the studies candidates for later research. This is not authorisation to start detailed research or adopt the skill/plugin.
- **Pinned research ref:** none. Revalidate upstream and deliberately select a research snapshot when detailed study is authorised.
- **Freshness risk:** high; supported agent hosts, plugin/hook behavior, benchmark results, model behavior and installation/runtime contracts may change materially.

## Why this candidate is registered

The upstream README presents Ponytail as a reusable agent discipline distributed across multiple coding-agent hosts. Its core decision ladder asks, before adding code, whether the requested thing needs to exist, already exists in the codebase, is available in the standard library or native platform, or is already provided by an installed dependency; only after those checks does it permit the minimum additional implementation.

The repository also publishes first-party agentic benchmark claims about code volume, token/cost/time effects and safety, plus lifecycle-hook/plugin installation surfaces across multiple hosts.

These are source-description signals for later investigation, not findings verified by this project.

## Candidate primary question / purpose

If later authorised, investigate whether a portable "minimum necessary implementation" discipline can reliably change agent behavior without degrading correctness, maintainability, security, accessibility or task fit; what mechanisms actually cause the behavior change; and how much of the effect depends on prompt/skill text, lifecycle hooks, host integration, model family, repository context and benchmark design.

A central question is whether the reusable value is merely terseness, or a more general decision policy for **need elimination → existing-code reuse → native/platform reuse → dependency reuse → minimal new implementation**.

## Potential Foundation relevance — provisional retrieval hints

- **Work:** potentially very strong for solution selection, unnecessary-work elimination, implementation scope and completion criteria.
- **Information:** potentially strong for reading the existing codebase and discovering already-available mechanisms before acting.
- **Environment:** potentially strong for standard-library/native-platform/dependency capability discovery and host-specific plugin/hook delivery.
- **Actors:** conditional relevance for agent behavior conditioning, invocation and human/agent responsibility boundaries.
- **Relations / control:** potentially strong for ordering constraints in the decision ladder, safety exceptions and host-level activation/enforcement.

These are retrieval hints only, not Foundation taxonomy assignments.

## Potential SOUL relevance

Possible future value includes pressure-testing whether SOUL should reason explicitly about **whether work should exist at all**, whether an existing capability already satisfies it, and whether solution minimality can be treated as a governed decision criterion rather than an aesthetic preference.

No SOUL reasoning policy or architecture is implied.

## Potential Development OS relevance

Possible future value includes implementation-planning heuristics, reuse-first engineering policy, environment/capability discovery before coding, portable skill delivery across coding agents, and benchmark design for evaluating behavioral instructions against real repository work.

No Development OS adoption or coding-policy decision is implied.

## Reuse modes

Potential later roles include:

- agent-behavior / skill-system reference;
- implementation-minimization pressure test;
- reuse/capability-discovery mechanism candidate;
- benchmark/evaluation-method reference;
- failure-mode source for overbuilding versus unsafe underbuilding;
- comparator for `superpowers`, `mattpocock-skills`, `i-have-adhd` and other portable instruction systems.

## Likely revisit triggers

Revisit when studying:

- agent coding discipline and overbuilding;
- reuse-before-build behavior;
- YAGNI/minimal-solution reasoning;
- portable skills/plugins and lifecycle hooks;
- host-independent versus host-conditioned behavior;
- safety-preserving instruction compression/minimization;
- evaluation of agent behavioral interventions.

## Epistemic and authority boundary

- Detailed research has not started.
- Upstream README, examples and benchmark materials are first-party source material, not independent evidence of efficacy, safety or generality.
- Published benchmark numbers have not been reproduced or independently audited by this project.
- No live installation, cross-host comparison, model-family replication, adversarial safety campaign, maintainability review or production adoption test has been performed.
- "Less code" is not assumed to be intrinsically better; correctness, safety, accessibility, maintainability and task sufficiency remain separate questions.
- Registration does not establish Foundation truth, SOUL / Development OS architecture or implementation requirements.

## Freshness / research-start requirement

Before detailed research:

1. re-check current upstream, release and supported-host matrix;
2. pin a source commit/ref;
3. recover the actual skill/plugin/hook implementation rather than relying on README framing;
4. inspect benchmark methodology, tasks, controls, scoring and raw results;
5. separate minimality effects from model/prompt/host confounds;
6. define explicit failure tests for underbuilding, omitted validation, security, accessibility and maintainability;
7. establish a bounded research method before producing findings.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package because research has not started.

## Related studies — discovery hints only

- `../superpowers/META.md` — portable interpreted development methodology and host-conditioned workflow.
- `../mattpocock-skills/META.md` — composable engineering disciplines and orchestration.
- `../i-have-adhd/META.md` — portable user-conditioned behavior policy and evaluation.
- `../gstack/META.md` — implemented agentic software-development workflow and qualification mechanisms.

Recover each selected package's current status and evidence before relying on any relation above.
