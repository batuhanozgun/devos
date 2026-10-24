# Claude Swap — Study Metadata

## Identity and status

- **Study ID:** `claude-swap`
- **Title:** Claude Swap — Multi-Account Claude Code Session, Credential and Usage Switching
- **Study type:** `external-target`
- **Status:** **PLANNED / RESEARCH NOT STARTED**. Candidate registration and preliminary intake only; no detailed research, runtime test, credential-security review, terms/policy review or adoption work has begun.
- **Research object:** `realiti4/claude-swap` as a multi-account switcher for Claude Code and its VS Code extension, including account storage/switching, usage-aware automatic switching, parallel per-account sessions and optional history sharing.
- **Canonical external target:** https://github.com/realiti4/claude-swap
- **Observed default branch during intake:** `main`
- **Observed upstream snapshot during intake:** `7187ce83b444c6af7b61ec8ee092623566a2d8fa`
- **Registration / intake date:** 2026-09-20
- **Registration authority:** user requested adding the repository to the studies candidates for later research. This is not authorisation to start detailed research or deploy/use the tool.
- **Pinned research ref:** none. Revalidate upstream and deliberately select a research snapshot when detailed study is authorised.
- **Freshness risk:** high; Claude authentication behavior, credential storage, quota/usage APIs, client behavior and applicable service terms can change rapidly.

## Why this candidate is registered

The upstream README describes account switching, usage tracking, automatic usage-aware switching, per-account parallel sessions and optional chat-history sharing.

These are source-description signals, not validated findings. Security, correctness and service-policy compatibility require independent current validation.

## Candidate primary question / purpose

If later authorised, investigate how account identity, credentials, session history, quota state and concurrent Claude Code processes are represented and transitioned; where isolation is preserved or intentionally shared; and what happens under token refresh/failure.

A separate required line is whether intended usage and automation remain compatible with current provider terms/policies and safe credential-handling practice. Registration is not endorsement of quota circumvention or account-policy bypass.

## Potential Foundation relevance — provisional retrieval hints

- **Environment:** potentially strong for runtime identity, credentials, quotas, local credential stores, concurrency and client integration.
- **Actors:** potentially strong for operator/account identity and authority/isolation boundaries.
- **Work:** conditional relevance for continuity when execution moves between accounts or concurrent sessions.
- **Information:** conditional relevance for chat-history sharing and account-specific state.
- **Relations / control:** conditional relevance for switching transitions, eligibility, token freshness and failure handling.

These are retrieval hints only, not Foundation taxonomy assignments.

## Potential SOUL relevance

Possible future value is as a boundary case for distinguishing actor identity, credential authority, runtime capability, quotas and session continuity. No SOUL identity/authentication architecture is implied.

## Potential Development OS relevance

Possible future value includes environment/account selection, credential/session isolation, capacity-aware execution routing, concurrent-session control and explicit history-sharing boundaries. No adoption decision is implied.

## Reuse modes

Potential later roles include environment/control case study, identity/authority boundary pressure test, credential/session failure-mode source and implementation-learning reference.

## Likely revisit triggers

Revisit when studying actor/account identity, credential authority, quotas/capacity scheduling, environment switching, concurrent agent sessions, session-history isolation or continuity across runtime identities.

## Epistemic and authority boundary

- Detailed research has not started.
- Upstream documentation is not independent evidence of credential safety, policy compliance or runtime correctness.
- No credential/token race test, multi-platform credential-store audit, concurrent-session experiment, service-policy review or security assessment has been performed by this project.
- Provider terms and authentication behavior must be revalidated at research/use time.
- Registration does not establish Foundation truth, SOUL / Development OS architecture or approval to use the tool.

## Freshness / research-start requirement

Before detailed research: re-check current upstream and current Claude Code/provider behavior; pin a commit/ref; recover credential storage and switching mechanisms; review current service terms/policies where load-bearing; and define explicit security/runtime validation boundaries.

## Package entrypoint

- `META.md` — candidate identity, planned status, retrieval value and research-start boundary.

There is intentionally no `STATE.md`, `METHOD.md`, `PLAN.md`, source ledger or findings package because research has not started.
