# gstack — Observed Structure and Research Decomposition

## Role

This file is the **orientation inventory** used to discover and route the gstack corpus. It is not the final architecture model and it is not a directory→subsystem mapping.

Primary pinned target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

The study is now boundedly complete. For current conclusions use:

1. `../CORE.md` — compact result;
2. `../INDEX.md` — retrieval router;
3. `../CLOSURE-AUDIT.md` — adversarial omission/distortion audit;
4. `../syntheses/cross-system-composition.md` — whole native system;
5. relevant subsystem synthesis;
6. `../SOURCE-LEDGER.md` — source/read provenance;
7. `../revalidation/2026-09-06-v1.80.0.md` — current-main delta through v1.80.

This inventory remains useful for explaining how the source corpus was decomposed without treating repository layout as ontology.

---

## High-level observed system

The completed source pass supports this broad decomposition:

```text
                      gstack
                        │
        ┌───────────────┼────────────────┐
        │               │                │
  behavior/policy   workflow/work     runtime/effects
        │               │                │
        └──────────┬────┴───────┬────────┘
                   │            │
            durable state    verification /
             & artifacts      eval / audit
                   │            │
                   └──────┬─────┘
                          │
                 ship / deploy /
               production feedback
                          │
                          ▼
               learning / self-change
                          │
                          ▼
              generation / setup /
                upgrade / release
```

The final cross-system synthesis sharpens this further: gstack is better modeled as a **federation of partial state machines connected through artifacts, standings, authority/control relations and runtime effects** than as one central workflow engine.

Specialist product/runtime verticals can span several semantic subsystem clusters. The iOS physical-device family is the clearest example and is explicitly retained below.

---

## 1. Governing policy / behavior-contract layer

Important source families include:

- `ETHOS.md`;
- `AGENTS.md`;
- `CLAUDE.md`;
- `DESIGN.md`;
- `SKILL.md.tmpl` sources;
- `scripts/resolvers/**`;
- host/model configuration and overlays.

Shared behavioral rules can exist at several strengths:

```text
doctrine / prose
→ generated workflow contract
→ structural invariant
→ runtime enforcement
→ behavioral test / CI consequence
```

Do not infer enforcement strength from the presence of policy text alone.

---

## 2. Workflow / work-system layer

The corpus contains workflow-shaped skills spanning:

### Discovery / planning / design

- `office-hours`;
- CEO / engineering / design / DevEx plan review;
- design consultation;
- `autoplan`;
- `spec`.

### Review / investigation / quality

- `review`;
- `investigate`;
- `qa` / `qa-only`;
- design / DevEx review;
- `cso`.

### Coordination

- `pair-agent`;
- Codex/outside-model surfaces;
- review-army / specialist dispatch;
- worktree/parallel planning surfaces.

### Delivery / production / feedback

- `ship`;
- `land-and-deploy`;
- `canary`;
- `document-release`;
- `retro`;
- `learn`;
- context / GBrain surfaces.

### Measurement / qualification / utility verticals

- `health`;
- `benchmark` / `benchmark-models`;
- `scrape` / `skillify`;
- `document-generate`;
- `make-pdf`;
- `diagram`;
- `design-html`;
- setup/report convenience surfaces.

These are source/workflow families, not Foundation categories and not one-to-one with final semantic subsystem clusters.

---

## 3. Shared composition / generation layer

Canonical generated behavior is assembled from actual source surfaces including:

- root and per-skill `SKILL.md.tmpl` files;
- `scripts/gen-skill-docs.ts`;
- `scripts/resolvers/index.ts`;
- `scripts/resolvers/sections.ts`;
- `scripts/resolvers/composition.ts`;
- host configurations under `hosts/**`;
- model overlays;
- carved sections / manifests.

Important source-view rule:

```text
generated SKILL.md
!= canonical authoring source
```

Generated output is an executable/inspectable view whose semantics depend on template, resolver, host/model and composition inputs.

---

## 4. Browser execution runtime

The browser subsystem is material software, not prompt-only tooling:

```text
agent / browser CLI
        ↓
long-lived Bun daemon/server
        ↓
BrowserManager + TabSession
        ↓
Playwright / Chromium / CDP
```

Relevant controls include:

- persistent tabs/profile/session state;
- scoped tokens and tab/domain/capability restrictions;
- URL/path/CDP boundaries;
- reference invalidation;
- audit/activity evidence;
- optional tunnel exposure;
- session persistence/restore.

The stateful runtime makes freshness and ownership part of browser-evidence validity.

The browser subsystem is the most deeply researched general interactive runtime in the first layer, but it is **not the only execution environment in the repository**.

---

## 5. Specialized iOS physical-device runtime vertical

Pinned `AGENTS.md` exposes a separate iOS family:

- `ios-qa`;
- `ios-fix`;
- `ios-design-review`;
- `ios-clean`;
- `ios-sync`;
- `gstack-ios-qa-daemon`;
- `gstack-ios-qa-mint`;
- `gstack-ios-qa-regen`.

Its source/runtime topology is materially distinct from Chromium:

```text
agent
  ↓
Mac gstack-ios-qa daemon
  ↓ USB CoreDevice tunnel
embedded Debug-only StateServer
  ↓
real iPhone app state / UI

optional remote agent
  ↓ Tailscale identity + capability token
Mac daemon
```

Load-bearing mechanisms include:

- Swift-source inspection and typed accessor generation;
- Debug-only bridge installation;
- physical device build/deploy/relaunch;
- boot-token rotation;
- observe/interact/mutate/restore capability tiers;
- allowlist/identity/session-token control;
- per-device/session locking;
- screenshot/elements/state readback;
- state-snapshot-driven fix/reverify loops;
- schema/accessor freshness;
- sync/regeneration against upstream templates;
- structural Release-build exclusion;
- no-device gate tests plus optional real-device periodic evidence.

This vertical was explicitly challenged during `../CLOSURE-AUDIT.md` because it was weakly visible in the original eleven subsystem names.

Audit judgment:

> **material specialist runtime vertical, but not a twelfth first-order semantic subsystem.**

Its operating semantics decompose without residue into existing runtime/security/evidence, QA/investigation, authority/control, generation/freshness, testing/eval and Environment mechanisms. Removing iOS would remove a major capability/example, not a primitive step from the final operating loop.

This distinction is important:

```text
semantic subsystem cluster
!= product/runtime vertical
```

---

## 6. Guarded-action / security controls

Actual pinned paths include:

- `careful/SKILL.md.tmpl` + `careful/bin/check-careful.sh`;
- `freeze/SKILL.md.tmpl` + `freeze/bin/check-freeze.sh`;
- `guard/SKILL.md.tmpl`;
- `unfreeze/SKILL.md.tmpl`;
- one-way-door registry and Claude question-preference hook;
- `cso` detective/advisory security workflow.

The study distinguishes:

```text
preventive runtime interposition
!= human decision authority
!= detective security evidence
```

and:

```text
enforcement-point scope
!= protected-effect scope
```

The iOS capability-token/allowlist runtime is another concrete control realization over a different protected resource.

Current-main note: v1.80 repairs a pinned `/freeze` state-root fail-open defect; see the revalidation file. The broader Edit/Write-only boundary and host-portability limits remain.

---

## 7. Durable information / continuity layer

Observed durable/state surfaces include:

- design and specification artifacts;
- review and decision logs;
- context checkpoints;
- local learnings;
- GBrain/cache/policy data;
- browser daemon/session state;
- iOS device/session/schema/snapshot artifacts;
- git/repository state;
- test/eval artifacts;
- security reports;
- deploy/canary/retro histories;
- generation/install/update/release state.

A central final finding is that these representations carry different provenance/freshness/authority semantics; there is no one generic “memory” standing.

---

## 8. Test / eval / compliance layer

The completed synthesis found a first-class verification pipeline including:

- free/static tests;
- Windows-specific execution;
- real-agent E2E;
- Codex/Gemini external-runtime E2E;
- LLM-as-judge evals;
- coverage/touchfile/tier routing;
- paid planner/shard/reconciler infrastructure;
- strict execution census;
- partial/finalized eval artifacts;
- baseline/compare/summary/flake tooling;
- compliance/audit/slop scans.

The iOS family makes Environment-dependence especially explicit:

- no-device paths can run in ordinary gate contexts;
- physical-device paths require a connected/paired iPhone and CoreDevice;
- full install/interaction additionally requires signing/deploy opt-in.

Protected conclusion:

```text
test exists
!= selected
!= executed
!= intended runtime exercised
!= oracle valid
!= finalized result
!= independent verification
```

The testing/eval cluster is synthesized in `../syntheses/testing-eval-routing-compliance-flake-lifecycle.md`.

---

## 9. Host / model portability layer

The pinned repository has a typed host-generation system plus heterogeneous setup/runtime standing.

Key distinction:

```text
registered
< generated
< structurally valid
< installable
< runtime-capable
< behaviorally exercised
< failure-path exercised
< independently validated
```

Host and model are separate axes. Generation/adaptation can preserve, rewrite, suppress, inline, weaken or leave behavior unsupported.

Remote iOS interaction further demonstrates that an agent host/model can be separated from the machine physically owning the protected device capability.

---

## 10. Delivery / production feedback layer

The source exposes distinct operational standings across:

```text
qualified PR
→ merge authority
→ authoritative merged state
→ deployment evidence
→ live verification
→ optional longitudinal canary
→ rollback/recovery action
→ retrospective / later learning
```

The study explicitly preserves:

```text
merge command != merged state
deploy completed != service healthy
revert pushed != production restored
```

---

## 11. Repository self-development / release layer

The repository develops and qualifies itself through:

- source templates/resolvers/runtime code;
- generation;
- setup/materialization;
- user-local render/relink;
- tests/evals;
- update detection;
- manual/background upgrade;
- migrations;
- version/changelog/release gates;
- operational feedback and repeated-failure hardening.

This forms a recursive loop in which failure classes increasingly become reusable helpers, runtime controls, structural pins and behavioral/environment tests.

`skillify` is a related application-level example: successful exploratory browser Work can be converted into a tested deterministic reusable browser skill after provenance filtering and user approval.

v1.80 adds further examples around setup capability degradation, installer ownership/provenance and test-environment fidelity.

---

## Final semantic research clusters

The source/product verticals converge into eleven bounded **semantic** native subsystem syntheses:

1. planning / specification / work admission;
2. review / QA / delivery qualification;
3. browser runtime / security / evidence;
4. investigation / causal control;
5. memory / learnings / context / GBrain;
6. multi-agent / cross-model coordination;
7. guarded action / security review;
8. host adapters / portability fidelity;
9. deploy / Canary / production / retrospective feedback;
10. testing / eval / routing / compliance / flake lifecycle;
11. repository self-development / generation / upgrade / release.

These are not an exhaustive skill catalogue. Specialist verticals can span them.

Chronology/evolution was used horizontally to pressure-test these mechanisms rather than promoted as a twelfth sibling.

The adversarial closure audit tested the strongest omitted verticals—especially iOS live-device runtime, scrape→skillify and measurement/output utilities—and found no missing first-order operating-system mechanism. See `../CLOSURE-AUDIT.md`.

---

## Documented vs observed structure warning

Repository documentation is useful evidence about intended architecture but does not override the observed pinned tree or runtime source.

An early example in this study was `docs/PROJECT_STRUCTURE.md` describing a `skill/SKILL.md.tmpl` path while the pinned tree had root `SKILL.md.tmpl`.

Therefore:

```text
repository self-description
!= observed source topology by identity
```

Current docs may later repair such drift; historical mismatch remains evidence about source/view fidelity at the pinned snapshot.

---

## Closure note

This inventory's discovery questions are closed by the durable synthesis package and adversarial closure audit. Do **not** continue researching a cluster or specialist vertical merely because it appears here.

Current continuation authority lives in `../STATE.md`. At study closure there is **no active gstack research Work**. Current-main behavior beyond the recorded v1.80 checkpoint requires freshness revalidation rather than automatic continuation.
