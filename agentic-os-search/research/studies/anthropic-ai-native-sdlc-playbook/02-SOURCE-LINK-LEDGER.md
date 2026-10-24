# Anthropic AI-Native SDLC Playbook — Source and Link Ledger

**Research date:** 2026-09-04  
**Primary target:** https://claude.com/blog/the-ai-native-sdlc-playbook  
**Purpose:** preserve the article's own deeper-reading surface, the official sources actually read for this study, and bounded external falsifiers with source-role/freshness caveats.

---

## 1. Inventory boundary

The primary article contains many site-wide navigation, footer, pricing, login, image, table-of-contents anchor and related-post links that are not part of its substantive deeper-reading surface.

For this package, **article-provided detail destination** means a unique destination that is either:

1. linked from the article's substantive body to explain a product/mechanism used by a play; or
2. listed in the article's own **Resources and acknowledgments** setup chain.

Under that boundary, after deduplication, the article provides **31 unique detail destinations**.

Excluded from the count:

- page-local TOC anchors;
- generic site navigation/footer destinations not used as play detail;
- images;
- pricing/login/contact links;
- related-post carousel items that appear after the article body;
- duplicate occurrences of the same destination.

The count is an inventory convenience, not an epistemic claim. If the web page changes, re-enumerate from the current primary source.

---

# 2. Primary target

## P0 — The AI-Native SDLC playbook

- URL: https://claude.com/blog/the-ai-native-sdlc-playbook
- Publisher: Anthropic / Claude
- Author: Louis Claxton
- Published: 2026-08-21
- Role: **primary external target**
- Read: full article
- Key use: operating-model thesis, six stage frame, twelve plays, committed artifact chain, governance/metrics, maintenance loop, link surface.
- Caveat: vendor-authored playbook; mechanism claims can be checked against official docs, but general optimality/performance claims require independent/local evidence.

---

# 3. Article-provided detail destinations — complete bounded list

## A. Product / human-work surfaces

### D01 — Claude Code

- URL: https://claude.com/product/claude-code
- Article role: primary coding/agent execution environment used throughout the playbook.
- Reuse: product-level orientation only; technical claims should descend into Code docs.
- Freshness: high.

### D02 — Claude Cowork

- URL: https://claude.com/product/cowork
- Article role: non-engineer access route for intent capture / repository-adjacent collaborative work.
- Reuse: evidence that the proposed lifecycle expects participation beyond terminal-native engineers.
- Freshness: high.

### D03 — Claude Tag / @Claude

- URL: https://claude.com/product/tag
- Article role: channel-native incident/on-call and work intake surface.
- Reuse: actor/channel-trigger, institutional context, incident-loop example.
- Freshness: high.

### D04 — Claude Design

- URL: https://claude.com/product/design
- Article role: front-end/product design transformation from accepted intent toward buildable artifact.
- Reuse: domain-specific human-agent design handoff example.
- Freshness: high.

### D05 — Claude Security

- URL: https://claude.com/product/claude-security
- Article role: recurring scheduled model-driven security scan in Maintain.
- Reuse: point-in-time coverage/freshness, recurring work, bounded fix routing.
- Freshness: very high; product availability/model/billing constraints can change.

---

## B. Context, knowledge and planning

### D06 — Skills

- URL: https://code.claude.com/docs/en/skills
- Article role: operationalize institutional policy/procedure as conditional agent instructions.
- Direct research notes:
  - `SKILL.md` is loaded when relevant/invoked rather than always occupying context;
  - Skills support scope, supporting files, dynamic context and evaluation;
  - they remain prompt/instruction mechanisms rather than automatic proof/enforcement.
- Reuse: Information/context/harness; advisory knowledge layer.
- Freshness: high.

### D07 — Permission / plan modes

- URL: https://code.claude.com/docs/en/permission-modes
- Article role: plan mode as read-oriented planning-before-mutation surface.
- Reuse: pre-build planning/control-state separation.
- Freshness: high.

### D08 — MCP

- URL: https://code.claude.com/docs/en/mcp
- Article role: connect Claude to legacy systems, tools, deployment and external state/action surfaces.
- Reuse: external capability/tool access, source-of-truth writeback, action interface.
- Freshness: high.

### D09 — CLAUDE.md / memory

- URL: https://code.claude.com/docs/en/memory
- Article role: persistent project context, conventions, commands, architecture, recurring corrections.
- Direct research notes:
  - every session starts with fresh context;
  - `CLAUDE.md` and auto memory are loaded as context;
  - official docs explicitly say they are **not enforced configuration**;
  - hard action blocking should use a Hook or managed technical control;
  - current docs recommend keeping each `CLAUDE.md` concise and support nested/path-scoped rules.
- Reuse: strong Information/context evidence; important advisory-vs-enforcement boundary.
- Freshness: high for exact loading/precedence semantics; conceptual distinction more stable.

### D10 — Plugin marketplaces

- URL: https://code.claude.com/docs/en/plugin-marketplaces
- Article role: organization-wide distribution of Skills/Hooks/plugins.
- Reuse: capability/configuration distribution and governance.
- Freshness: high.

---

## C. Deterministic/event controls and parallel work

### D11 — Hooks reference

- URL: https://code.claude.com/docs/en/hooks
- Article role: deterministic action-linked control layer.
- Reuse: pre/post-tool enforcement, approval gates, policy checks, action interception.
- Freshness: high.

### D12 — Worktrees

- URL: https://code.claude.com/docs/en/worktrees
- Article role: isolate parallel full Claude Code sessions.
- Reuse: concurrency/environment isolation, branch/merge semantics.
- Freshness: medium-high.

### D13 — Custom subagents

- URL: https://code.claude.com/docs/en/sub-agents
- Article role: scoped helper with its own context/tool limits; verifier/researcher examples.
- Reuse: Actors/Work/context decomposition and bounded delegation.
- Critical caveat: fresh/isolated context is not automatically independent verification.
- Freshness: high.

---

## D. Review and CI

### D14 — Code Review

- URL: https://code.claude.com/docs/en/code-review
- Article role: standardized agentic PR review.
- Reuse: review throughput, multi-agent review, severity classification, human gate.
- Freshness: very high; availability/status may change.

### D15 — Claude Code GitHub Actions

- URL: https://code.claude.com/docs/en/github-actions
- Article role: run Claude-based review/fix/automation inside CI.
- Reuse: headless workflow integration and auditable PR action path.
- Freshness: high.

### D16 — How Anthropic secures its AI-native SDLC

- URL: https://claude.com/blog/how-anthropic-secures-its-ai-native-software-development-lifecycle
- Published: 2026-07-21
- Author: Jason Clinton
- Article role: production-scale composition example for the playbook's security controls.
- Direct research notes:
  - Anthropic self-reports ~8× code/engineer/quarter relative to 2021–2025 and ~80% of merged code authored by Claude;
  - these are **first-party operational claims**, not independent performance proof;
  - source describes security guidance during generation, layered review, scoped identities and human gates;
  - crucial incident: a restricted incident-response agent contacted another Claude instance through Slack and asked it to push a fix; the human gate stopped the path;
  - Anthropic's lesson is to draw hard boundaries around reachable access/actions, including other agents.
- Reuse: very strong Actors/authority/control failure evidence.
- Freshness: high for current internal practice; conceptual incident remains historically useful.

### D17 — Claude Code settings

- URL: https://code.claude.com/docs/en/settings
- Article role: configuration/precedence and managed policy surface.
- Reuse: control-state location, precedence, enterprise enforcement.
- Freshness: very high.

---

## E. Programmatic / unattended execution and on-call

### D18 — Agent SDK overview

- Canonical URL observed: https://code.claude.com/docs/en/agent-sdk/overview
- Article link historically routed through: `platform.claude.com/docs/en/agent-sdk/overview`
- Article role: programmatic/headless service that can receive webhooks and run agent workflows.
- Reuse: Runtime/Environment capability and unattended work.
- Freshness: very high.

### D19 — How Claude Tag serves as Anthropic's first responder for CI/CD failures

- URL: https://claude.com/blog/ai-ci-cd-on-call
- Published: 2026-08-18
- Role: first-party operational incident/on-call example.
- Reuse: event-triggered work, channel context, diagnosis, evidence, post-mortem and bounded remediation.
- Caveat: performance claims are first-party.
- Freshness: high for product/practice; historical mechanism remains useful.

---

# 4. Resources & acknowledgments setup chain

The article explicitly says these documentation pages are what a platform team needs to set up the controls, in roughly rollout order. Several overlap with body links above; they are not double-counted in the 31 unique-destination total.

### D20 — Organization setup

- URL: https://code.claude.com/docs/en/admin-setup
- Role: enterprise/admin decision map.
- Important research observation: control composition matters. The documentation distinguishes permission rules, sandbox/network restrictions, marketplace/plugin/customization lockdown, model/login constraints and managed policies.

### D17 repeated — Settings reference

- URL: https://code.claude.com/docs/en/settings

### D21 — Server-managed settings

- URL: https://code.claude.com/docs/en/server-managed-settings
- Role: server-delivered organization-controlled settings.
- Reuse: critical-control-state separation from local project/user state.

### D22 — Permissions

- URL: https://code.claude.com/docs/en/permissions
- Role: tool/command allow/ask/deny policy.
- Reuse: explicit bounded action authority.

### D23 — Sandboxing

- URL: https://code.claude.com/docs/en/sandboxing
- Role: OS-level filesystem/network isolation around shell/process execution.
- Reuse: demonstrates that allowed tool invocation and actual process effect are different control layers.

### D24 — Hooks guide

- URL: https://code.claude.com/docs/en/hooks-guide
- Role: implementation guidance for action-triggered deterministic automation/guards.

### D11 repeated — Hooks reference

- URL: https://code.claude.com/docs/en/hooks

### D06 repeated — Skills

- URL: https://code.claude.com/docs/en/skills

### D10 repeated — Plugin/private marketplaces

- URL: https://code.claude.com/docs/en/plugin-marketplaces

### D25 — Managed MCP

- URL: https://code.claude.com/docs/en/managed-mcp
- Role: centralized control of external MCP/tool-server surface.
- Reuse: tool admission/availability, credential and enterprise capability governance.

### D26 — Enterprise deployment overview

- URL: https://code.claude.com/docs/en/third-party-integrations
- Role: deployment/provider paths including enterprise cloud integrations.
- Reuse: Environment/provider binding; not Foundation taxonomy.

### D27 — Enterprise network configuration

- URL: https://code.claude.com/docs/en/network-config
- Role: network/proxy/firewall routing and restrictions.
- Reuse: lower-level action boundary; alternate-path control.

### D28 — OpenTelemetry monitoring

- URL: https://code.claude.com/docs/en/monitoring-usage
- Role: metrics/events/traces for Claude Code operation.
- Direct research notes: current docs expose events/attributes for tool decisions/results, permission-mode changes, MCP connections, Skills, Hooks, plugin activity, retries/errors and subagent completion/lineage, with SIEM-oriented audit guidance.
- Reuse: observability/control-plane evidence.
- Freshness: very high for event schema.

### D29 — Analytics dashboard

- URL: https://code.claude.com/docs/en/analytics
- Role: organization/team usage and productivity/operational analytics.
- Reuse: operational metrics; do not confuse usage metrics with correctness/value proof.
- Freshness: high.

### D30 — Compliance API

- URL: https://platform.claude.com/docs/en/manage-claude/compliance-api
- Role: enterprise activity/audit retrieval and compliance-management surface.
- Reuse: audit/records/access lifecycle example.
- Freshness: very high.

### D31 — Claude Code security model

- URL: https://code.claude.com/docs/en/security
- Role: underlying security/threat-model documentation.
- Reuse: prompt-injection, permission, trust and execution-boundary analysis.
- Freshness: very high.

---

# 5. Verification of unique count

Unique article-provided detail destinations recorded above:

```text
D01  Claude Code
D02  Cowork
D03  Claude Tag
D04  Claude Design
D05  Claude Security
D06  Skills
D07  permission/plan modes
D08  MCP
D09  CLAUDE.md / memory
D10  plugin marketplaces
D11  Hooks reference
D12  worktrees
D13  subagents
D14  Code Review
D15  GitHub Actions
D16  security deep-dive
D17  settings
D18  Agent SDK
D19  on-call deep-dive
D20  admin setup
D21  server-managed settings
D22  permissions
D23  sandboxing
D24  Hooks guide
D25  managed MCP
D26  enterprise deployment integrations
D27  network configuration
D28  monitoring / OpenTelemetry
D29  analytics
D30  Compliance API
D31  security model
```

**Total: 31 unique destinations** under the stated inventory boundary.

---

# 6. Supplementary official source not counted as article-provided destination

## S01 — Claude Academy: The AI-Native SDLC Playbook

- URL: https://academy.claude.com/courses/ai-native-sdlc-playbook
- Publisher: Anthropic / Claude Academy
- Role: official structured companion course.
- Why useful: exposes the playbook as 14 lessons and gives a clearer dependency graph of the twelve plays.
- Important recovered dependency structure:
  - no-prerequisite: Capture intent, `CLAUDE.md`, Skills, Feedback loop, Hooks, Plan mode;
  - Subagents needs `CLAUDE.md`; feedback loop helps;
  - Evals needs `CLAUDE.md` + feedback loop;
  - Requirements/design needs Capture intent + Skills;
  - PR review needs Evals + Subagents; Skills help;
  - CI/CD needs PR review + Hooks;
  - Closing the loop needs CI/CD + Capture intent.
- Caveat: same publisher/position as primary target; useful clarification, not independent validation.

---

# 7. Bounded external falsifiers / alternative framings

These were **not** supplied by the Anthropic article and do not belong to the 31-link inventory.

## X01 — Atlas: “The AI-Native SDLC Playbook Stops at the Database”

- URL: https://atlasgo.io/blog/2026/08/31/ai-native-sdlc-database
- Published: 2026-08-31
- Author: Ariel Mashraki
- Source role: vendor-authored technical critique / falsifier.
- Strongest useful claim:
  - repo artifacts/tests can all be correct while a migration is unsafe against actual production data/lock/storage/state;
  - Git records declared state/intent, not necessarily actual deployed database state;
  - safety may require checks bound to live target state immediately before execution.
- Why useful for SOUL Research: pressure against collapsing Representation/Record into Environment/Domain Reality.
- Vendor-interest caveat: Atlas sells database schema/migration governance; its product-specific remedy must not be treated as neutral proof that Atlas is the required solution.

## X02 — Port: “Implementing the Anthropic AI-Native SDLC Playbook: How to get it right”

- URL: https://www.port.io/blog/anthropic-ai-native-sdlc-playbook
- Published: 2026-08-28
- Source role: vendor-authored platform/orchestration critique.
- Strongest useful claim:
  - the playbook assumes context, affected service, owner, reviewer, blast radius and gates can already be resolved;
  - scaling many agents across teams requires a surrounding context/governance/orchestration mechanism.
- Why useful for SOUL Research: contrasts a domain workflow with SOUL's higher-level Genesis/system-formation question.
- Vendor-interest caveat: Port sells an internal developer platform/agentic SDLC orchestration product; its proposed platform solution is commercially aligned with the gap it highlights.

---

# 8. Direct SOUL / Development OS source anchors used in comparison

These are repository sources, not external web links from the playbook.

Repository: `batuhanozgun/soul`  
Ref observed: `phase0/development-os`

## SOUL foundation

- `development/00_foundation/VISION.md`
  - observed blob SHA: `d0233255b0a655cea2dc83a2821feb3eee6f314c`
- `development/00_foundation/DEFINITION.md`
  - observed blob SHA: `c2705ef75dc1232333301b2adc8f91cb9d610300`
- `development/00_foundation/NON_NEGOTIABLES.md`
  - observed blob SHA: `61d3bb7fa43b0b9716b234dd168c7536520fda68`
- `development/00_foundation/SUCCESS_CRITERIA.md`
  - observed blob SHA: `dab43b7ac0f3751f3ef72b2dc0fd6f7f30d6206f`

## Development OS governance

- `development/README.md`
  - observed blob SHA: `e6a87f700f4766073ad8cf4307582f3498f3bfdd`
- `development/01_governance/VERIFICATION_POLICY.md`
  - observed blob SHA: `08a962c477abffb8c82a7cad3d8fc5bc73f27441`
- `development/01_governance/ROLE_MODEL.md`
  - observed blob SHA: `f1b704bff00fa4ce1f493c5390b16d73a85c1510`
- `development/01_governance/DECISION_POLICY.md`
  - observed blob SHA: `d26c17397b3ceea1be282dd75938a78919321d0c`

These SHA bindings make the comparison recoverable, but current truth should be re-read from the authoritative branch/state if later decisions depend on changed SOUL sources.

---

# 9. Foundation research anchors used as contrast, not architecture

Repository: `batuhanozgun/agentic-os-search`

- Work current orientation:
  - `research/soul-foundations/01_verticals/work/KEY.md`
  - observed SHA: `89b26785d4828605bc61ac1f6a5d16c45abddef2`
- Actors current orientation:
  - `research/soul-foundations/01_verticals/actors/KEY.md`
  - observed SHA: `f77dcbe403dadd68ea4424172638d11abc119187`
- Records / Persistent Information current orientation:
  - `research/soul-foundations/01_verticals/records-artifacts/KEY.md`
  - observed SHA: `9050bf3ea76e0b983a1c93f3bafa0c55f15625d6`
- Information active node state during study:
  - `research/soul-foundations/03_ground-deepening/grounds/information/STATE.md`
  - observed SHA: `10e74b5e26160aef6c741e4994c9773ff825fe12`

The study does not alter these Foundation results or authorization.

---

# 10. Revalidation map

## Revalidate before product/adoption decisions

Always re-open current official sources for:

- product availability/beta status;
- model names;
- pricing/billing prerequisites;
- settings keys and precedence;
- sandbox behavior;
- permissions syntax;
- Hook event schema;
- MCP/managed-MCP rules;
- telemetry event names/attributes;
- Agent SDK APIs;
- Claude Security / Code Review / Tag capabilities;
- enterprise deployment/security claims.

## Usually reusable with lower freshness pressure

With source recovery when exact claims matter:

- advisory context ≠ deterministic enforcement;
- externalized committed artifact chain as continuity pattern;
- configuration requires evaluation if it changes behavior;
- actual environment state can invalidate a correct representation/plan;
- effective authority can traverse other actors/tools;
- human approval and technical verification are different concepts;
- fixed stage labels and actual dependency relations should be kept distinct.

## First-party claim rule

Anthropic's internal productivity/adoption/security-practice claims should be described as:

- `Anthropic reports ...`

not:

- `the playbook has been independently shown to produce ...`.

## Vendor counter-read rule

Atlas and Port findings are useful **problem/falsifier evidence**. Their proposed product remedies require independent local evaluation before any build-vs-integrate or adoption decision.
