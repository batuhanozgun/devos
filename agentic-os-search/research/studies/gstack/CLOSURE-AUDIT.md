# gstack Study — Adversarial Closure / Omission Audit

## Role

This is the final omission/distortion pass required by `METHOD.md` before bounded study closure.

Primary target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`

Audit date: 2026-09-06.

This pass works **backward from the pinned repository/product surface into the completed synthesis**, rather than asking whether the existing synthesis looks internally complete.

It tests:

> Is there a material repository/runtime/workflow region that the eleven native subsystem syntheses fail to explain, or has the synthesis distorted a specialist vertical into a missing first-order mechanism?

This is same-model adversarial closure review, **not independent second-researcher/model replication**.

---

## 1. Audit method

The pass used:

1. pinned root/topology and `AGENTS.md` skill catalogue;
2. existing `SOURCE-LEDGER.md` coverage;
3. specialist surfaces that were weakly visible in the first-layer names;
4. targeted source/test reads for the strongest omission candidate;
5. counterfactual promotion test:

> If this specialist vertical were removed, would the final gstack-native mechanism model lose a first-order operating-system mechanism, or only one domain-specific realization/composition of already-modeled mechanisms?

The strongest holdout was the **iOS QA/device family**. Other holdouts were scrape→skillify automation, health/benchmark qualification tools and document/artifact-generation utilities.

---

# 2. Holdout A — iOS QA / device runtime

## Why this was a real omission candidate

Pinned `AGENTS.md` exposes a dedicated iOS family:

- `/ios-qa`;
- `/ios-fix`;
- `/ios-design-review`;
- `/ios-clean`;
- `/ios-sync`;
- `gstack-ios-qa-daemon`;
- `gstack-ios-qa-mint`;
- `gstack-ios-qa-regen`.

This is not a thin wrapper. `ios-qa/SKILL.md.tmpl` defines a separate physical-device execution topology:

```text
agent
  ↓
Mac gstack-ios-qa daemon
  ↓ USB CoreDevice tunnel
embedded StateServer in Debug iOS app
  ↓
real iPhone UI/state

optional:
remote agent
  ↓ Tailscale
Mac daemon
```

The workflow reads Swift source, generates typed accessors, installs a Debug-only bridge, builds/deploys to a physical device, rotates credentials, acquires a device session lock and executes:

```text
screenshot
→ elements
→ typed state snapshot
→ decide
→ acquire session
→ tap/swipe/type/state mutation
→ screenshot/readback
→ verify
```

The tailnet path adds identity validation, allowlisting, short-lived session tokens, capability tiers and audit logging.

This is therefore a material runtime vertical and needed explicit closure treatment.

---

## 2.1 Authority / capability semantics are an instance of the existing control model

The iOS daemon defines ordered capabilities:

```text
observe
< interact
< mutate
< restore
```

Remote session tokens carry:

- identity;
- capability;
- expiry;
- device UDID;
- origin (`self_service` / `owner_granted`).

Endpoint access is classified by minimum capability; tokens are short-lived, revokable and rate-limited.

This does **not** introduce a new first-order mechanism beyond the existing Actors + guarded-action/browser-runtime result. It is another concrete realization of:

```text
technical reach
!= authorized capability

identity
+ scope
+ capability
+ expiry
→ bounded effect authority
```

The difference is Environment and protected resource: a physical iPhone/app state rather than a browser tab/page.

---

## 2.2 Runtime/evidence semantics are a parallel realization of the existing runtime plane

The Mac daemon has:

- single-instance claim;
- loopback full-surface listener;
- optional tailnet listener;
- fail-closed Tailscale probe;
- in-memory rotated token state;
- device tunnel caching/invalidation;
- stale-route recovery;
- audit/attempt logging;
- per-device/session locking.

This is technically distinct from the Chromium daemon, but semantically it instantiates the same already-modeled operating concerns:

```text
runtime capability
+ persistent state
+ identity/authorization
+ resource ownership
+ freshness/invalidation
+ effect execution
+ readback/evidence
+ recovery
```

Therefore it belongs in the **runtime/environment/security evidence family** without requiring a new top-level operating mechanism called “iOS”.

The completed cross-system model deliberately uses a broader runtime/operating plane than the browser subsystem title alone.

---

## 2.3 `/ios-fix` is a domain-specific investigate / repair / reverify loop

`ios-fix/SKILL.md.tmpl` requires:

```text
reproducing state snapshot
→ source/root-cause trace
→ minimal fix
→ rebuild/redeploy
→ restore pre-bug snapshot
→ fresh visual/device verification
→ periodic real-device regression fixture
```

Its Iron Law is “no fix without a reproducing snapshot”; it explicitly imports `/investigate` root-cause discipline and bounds failed attempts before user escalation.

This is strong domain evidence for the existing:

- investigation / causal-control subsystem;
- QA repair/reverification subsystem;
- evidence lineage / freshness model;
- testing/eval standing model.

It does not create a new class of Work transition.

---

## 2.4 `/ios-sync` is generated-artifact freshness / propagation

`ios-sync/SKILL.md.tmpl` distinguishes:

```text
upstream gstack template/version
→ regenerated local DebugBridge package
→ typed accessor output
→ completion/version marker
→ build/device readback
```

The deterministic regenerator caches by source/tool/platform inputs, rejects unsupported source shapes before completion and requires build + device-schema verification after regeneration.

This is an application-facing instance of mechanisms already found in the self-development/generation and transition/freshness research:

```text
source changed
!= generated artifact current
!= build accepted
!= runtime/device realization verified
```

The target is the user's app instrumentation rather than gstack's own installed skill tree, but the mechanism class is not new.

---

## 2.5 `/ios-clean` separates convenience Work from safety-critical control

`ios-clean/SKILL.md.tmpl` explicitly says the cleanup workflow is **not** the safety mechanism.

The safety-critical release boundary is the structural Debug-only package condition plus release-build/CI invariant; `/ios-clean` is a guided, reversible removal workflow.

This reinforces the existing Control result:

```text
cleanup Work
!= safety control by identity

workflow instruction
!= structural enforcement
```

No new first-order mechanism emerges.

---

## 2.6 iOS verification standing is explicitly environment-dependent

`test/skill-e2e-ios.test.ts` distinguishes:

- gate-compatible no-device codegen/daemon/stub paths;
- physical-device behavior requiring device-specific opt-in.

`test/skill-e2e-ios-device.test.ts` is explicit that real device evidence requires:

- connected/paired iPhone;
- Developer Mode;
- CoreDevice availability;
- additional signing/deploy opt-in for full install/launch/interaction smoke.

The canonical coverage matrix routes iOS QA to gate plus periodic real-device/Swift-build tests, while sibling iOS skills mostly retain structural floor coverage.

This is a particularly strong real-system example of the already-completed verification conclusion:

```text
test path exists
!= physical environment available
!= real device exercised
```

Environment is part of verification standing.

---

## iOS verdict

**DO NOT PROMOTE A 12TH FIRST-ORDER SUBSYSTEM.**

Reason:

The iOS family is a large, important **cross-cutting specialized runtime vertical**, but its load-bearing semantics decompose without residue into already-modeled mechanism families:

| iOS mechanism | Existing synthesis family |
|---|---|
| live-device evidence / interaction | runtime/security/evidence + QA |
| device capability tiers / tokens / identity | guarded action + Actors/authority |
| session/device lock + daemon lifecycle | runtime/liveness/control |
| source→typed-accessor generation | generation/freshness/information transformation |
| ios-fix reproducing snapshot → fix → reverify | investigation + QA/recovery |
| ios-sync source/version→generated/runtime readback | generation + transition/freshness |
| ios-clean vs Release structural guard | Work vs Control non-collapse |
| real-device E2E availability | testing/eval + Environment standing |

Counterfactual result:

> Removing the iOS implementation would remove a major **example and capability vertical**, but would not remove a first-order mechanism from the final gstack operating-system model.

The earlier structure inventory was nevertheless distorted by omitting this vertical entirely. That inventory is corrected separately.

---

# 3. Holdout B — scrape → skillify

`AGENTS.md` exposes `/scrape` and `/skillify`; `skillify/SKILL.md.tmpl` makes the important mechanism explicit:

```text
successful exploratory browser flow
→ provenance-bounded extraction of the accepted attempt
→ deterministic script + pure parser
→ captured fixture + test
→ stage in temp location
→ test pass
→ explicit user approval
→ permanent browser skill
```

The skill explicitly refuses to write a half-broken artifact into the live skill catalogue and treats scraped page content as attacker-influenceable input.

This is valuable, but it does not require a new first-order subsystem. It composes:

- browser/runtime evidence;
- Information derivation/transformation;
- generated deterministic capability;
- test/eval qualification;
- user approval authority;
- self-development/feedback-style codification.

Its distinctive value is the **exploration → deterministic reusable automation** transition, which is already representable by the completed mechanism set:

```text
KNOW → QUALIFY → GOVERN → ACT → VERIFY → persist/reuse
```

**Verdict:** cross-subsystem specialization, not missing first-order family.

---

# 4. Holdout C — health / benchmark / benchmark-models

`/health` aggregates existing project checks into a composite code-quality dashboard and trend history while explicitly refusing to fix issues.

`/benchmark` forms runtime performance evidence, stores baselines and compares later measurements under explicit regression thresholds.

`/benchmark-models` is a cross-model comparison surface already covered by model/eval/coordination concerns.

Their common mechanism is:

```text
acquire heterogeneous evidence
→ normalize/score/compare under a criterion
→ persist history
→ expose current/trend standing
→ recommend but do not automatically create Work
```

That is already covered by:

- testing/eval/verification;
- Composite Standing-style qualification pressure;
- browser/runtime evidence where applicable;
- Information aggregation/history;
- feedback without automatic Work admission.

**Verdict:** qualification/measurement specializations, not missing first-order family.

---

# 5. Holdout D — document / PDF / diagram / design-output utilities

The pinned skill catalogue includes output utilities such as:

- `document-generate`;
- `make-pdf`;
- `diagram`;
- `design-html`.

These are important product capabilities but do not create a new gstack operating-system coordination/control family by themselves. At the mechanism level they are bounded Information transformation / artifact-production Work with their own validation/runtime tooling.

Where these outputs become delivery/control inputs, the already-modeled artifact/consumer/qualification rules apply.

**Verdict:** capability/output utilities, not missing first-order system mechanism.

---

# 6. Holdout E — setup/view/convenience surfaces

Other catalogue entries such as:

- `landing-report`;
- `open-gstack-browser`;
- `setup-browser-cookies`;
- `setup-deploy`;
- `context-save` / `restore` helper views;

mainly configure, expose, persist or report already-modeled runtime/work/information state.

They may be operationally important without meriting a new first-order subsystem.

**Verdict:** views/setup/specialized transitions inside existing families.

---

# 7. Distortion checks against the final synthesis

## D1 — “Eleven subsystem syntheses” must not mean “eleven product verticals”

Correct interpretation:

> the eleven are semantic research clusters that together explain the operating mechanisms; specialist product verticals can cross several clusters.

The inventory now states this explicitly.

## D2 — Browser subsystem title must not imply browser is the only execution runtime

The pinned source has at least one major parallel execution environment: iOS physical-device QA.

The whole-system model is already broader:

```text
repo/worktree
→ host/process/filesystem
→ browser/device/network
→ external systems / production
```

Future reuse should read “browser runtime” as one deeply researched runtime subsystem, not the total set of gstack runtime capabilities.

## D3 — CORE's mechanism claims survive the iOS holdout

The iOS family strongly instantiates rather than falsifies:

- situation binding;
- evidence formation;
- standing computation;
- authority resolution;
- control resolution;
- bounded effect execution;
- authoritative readback;
- freshness/invalidation;
- continuity/recovery;
- feedback/regression capture.

No new primitive operating step is required.

## D4 — Specialized capability absence from a subsystem title is not evidence it was read

This audit is required because a high-level synthesis can appear complete while an entire domain vertical remains invisible.

Future candidate-study closure should retain this reverse-catalogue check as a method lesson.

---

# 8. Final adversarial judgment

After reversing from the pinned skill/runtime catalogue and challenging the strongest omitted vertical:

> **No decision-critical missing first-order gstack mechanism survives the closure audit for the study's stated purpose.**

The strongest omission, iOS device QA, is real and material but is best classified as a **specialized cross-cutting runtime vertical** that composes existing mechanism families rather than requiring a twelfth first-order subsystem.

The audit also confirms that scrape→skillify, health/benchmark and artifact-output utilities are meaningful specializations without forcing another first-order operating-system region.

### Closure impact

- bounded study closure remains justified;
- native subsystem count remains **11**;
- the structure inventory required correction to expose iOS explicitly;
- source ledger should treat this audit as final omission evidence;
- no Foundation mutation or architecture adoption follows.

---

## Verification boundary

This is an adversarial same-model closure pass using direct pinned repository sources and tests. It is stronger than a self-consistency assertion because it starts from external product/runtime surfaces that were not explicit in the synthesis list.

It is still **not independent verification** of the study.

Independent second-researcher/model reconstruction could still discover:

- a different first-order grouping;
- omitted private/external runtime evidence;
- a source interaction not surfaced by the public pinned repository;
- a mechanism whose importance is understated by the semantic clustering.

Those are revalidation/reopen conditions, not reasons to keep the current study indefinitely active.
