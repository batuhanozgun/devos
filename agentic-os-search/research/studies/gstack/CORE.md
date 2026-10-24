# gstack Study — CORE

## Role

This is the compact top-layer model of the pinned gstack study.

It is intentionally lossy. It does **not** replace:

- subsystem syntheses;
- `syntheses/cross-system-composition.md`;
- `syntheses/four-ground-projection.md`;
- `syntheses/cross-ground-mechanisms.md`;
- `SOURCE-LEDGER.md`;
- pinned upstream source.

Use this file to recover the study's durable result quickly, then re-enter lower layers for decision-critical claims.

**External target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Version:** `1.79.0`  
**Observed:** 2026-09-05  
**Authority:** candidate external research only; **no Foundation adoption or mutation**

---

# 1. One-sentence model

> **gstack is an artifact-mediated, qualification-driven software-development operating system that repeatedly binds the current situation, forms evidence, computes standing, resolves authority/control, performs a bounded effect, reads back what actually became true, invalidates stale representations, and continues/recover/adapts from the new state.**

---

# 2. The core operating loop

```text
SITUATE
exact actors / work / information / environment anchors
+ roles / scope / time / version
        ↓
KNOW
form, retrieve, transform and aggregate evidence
        ↓
QUALIFY
compute current readiness / completion / validity / support standing
        ↓
GOVERN
resolve authority + control + enforcement/override semantics
        ↓
ACT
perform bounded effect
        ↓
VERIFY REALITY
read back realized state rather than infer it from command/record
        ↓
REFRESH
invalidate stale artifacts/standings
        ↓
CONTINUE / RECOVER / LEARN
        └────────────────────────→ repeat
```

This loop is distributed across skills/runtime/tests/artifacts. It is not one centralized engine.

---

# 3. Why gstack is more than “prompts + tools”

gstack's important behavior is carried by a composed system of:

- workflow contracts;
- durable artifacts;
- explicit user decision gates;
- child-agent delegation/result contracts;
- deterministic helpers/state machines;
- runtime tool interposition;
- browser/process/filesystem/network controls;
- host/model compilation/adaptation;
- test/eval execution and false-green defenses;
- production readback;
- memory/continuity;
- generator/setup/update/migration/release machinery;
- feedback into future repository hardening.

The operating-system character comes from the **relations among these parts**, not from any single skill.

---

# 4. Native first-layer decomposition

The pinned repository was reconstructed through eleven bounded subsystem syntheses:

1. planning / specification / work admission;
2. review / QA / delivery qualification;
3. browser runtime / security / evidence;
4. investigation / causal control;
5. memory / learnings / GBrain;
6. multi-agent / cross-model coordination;
7. guarded action / security review;
8. host adapters / portability fidelity;
9. deploy / Canary / production / retrospective feedback;
10. testing / eval / routing / compliance / flake lifecycle;
11. repository self-development / generation / upgrade / release.

Chronology was sampled horizontally and showed an evolution from rapid capability growth toward repeated-failure hardening and recursive self-consistency.

---

# 5. Cross-system architecture

The eleven subsystems compose as a federation of partial state machines.

```text
WORK / EFFECT PATH
intent → admitted work → implementation → delivery → production → feedback

AUTHORITY / CONTROL PLANE
user decisions → delegation → capabilities → one-way doors → release authority

EVIDENCE / REPRESENTATION PLANE
source → tests → runtime observations → reports → aggregates → standings

RUNTIME / OPERATING PLANE
repo/worktree → host/process/filesystem → browser/network → external systems → production

SELF-DEVELOPMENT PLANE
failure → source change → generation/install → eval → release → stronger controls
```

No single universal controller owns every state transition.

Composition instead occurs through:

- durable artifacts;
- typed/implicit bindings;
- current/stale/partial/verified standings;
- parent/child handoffs;
- control/authority gates;
- actual runtime effects;
- downstream consumers that reinterpret upstream artifacts.

---

# 6. Four-ground projection

## Information / Representation

gstack builds and manipulates representations of:

- intent/design;
- plans/specs/work state;
- source/diff;
- browser/runtime observation;
- test/eval/security results;
- memory/checkpoints/learnings;
- deploy/production state;
- generated/install/release state.

It strongly exercises:

```text
Informational State
Formation / Acquisition
Derivation / Transformation
Selection / Exposure
```

The most important information failure class is:

> **payload survives a representation boundary while freshness/partiality/provenance/standing qualification is lost.**

Examples: GBrain stale fallback, partial eval consumers, update/revert representations.

---

## Work

gstack organizes pursuits through:

- candidate intent;
- admission;
- planning/specification;
- enactment;
- sequencing/parallelism/dependency;
- monitoring/evaluation;
- repair/recovery;
- delivery;
- continuing operational work;
- self-improvement/meta-work.

Its strongest Work discipline is preserving:

```text
Work performed
!= target condition achieved
!= evidence supports success
!= authorized acceptance/progression
```

and:

```text
plan/intended Work
!= actual Work state
```

---

## Actors / Agency–Participation–Authority

gstack distributes participation and decision rights across:

- human user/principal;
- model/agent instances;
- temporary specialist roles;
- parent/child agents;
- outside-model voices;
- operational services/runtimes.

Its strongest Actor distinction is:

```text
participates
!= technically capable
!= authorized
!= entitled to decide
!= accountable by identity
```

Technical effect power is repeatedly constrained or separated from legitimate authority.

---

## Environment / Operating Reality

gstack treats actual operating conditions as part of workflow correctness:

- repository/worktree state;
- files/processes/locks;
- host/model/tool semantics;
- OS/runtime availability;
- browser/session/network state;
- credentials/APIs;
- CI;
- external deployment/production condition.

A workflow instruction can realize as:

```text
mechanical enforcement
host-native equivalent
inline emulation
advisory prose
unsupported behavior
```

depending on actual Environment conditions.

---

# 7. How the four grounds are bound into one system

The compact answer is:

```text
ACTOR
has a role / authority / capability relation
        ↓
WORK
is candidate, admitted, enacted, evaluated or recovered
        ↓
INFORMATION
represents intent, state, evidence, standing and history
        ↓
ENVIRONMENT
is the actual repository/runtime/external reality in which effects occur
        ↓
CROSS-GROUND COMPOSITION
binds anchors, computes qualification, governs transitions,
tracks realization/freshness and feeds results into later decisions
```

The same object may participate in several grounds without becoming one ground's property by identity.

---

# 8. The four most important composition semantics

## 8.1 Binding

Generic connectivity is not enough.

A result must preserve **what exact anchors are related in what roles and under what scope/time/version**.

Examples:

- test result evidences which implementation/change;
- child result belongs to which delegated work;
- browser token authorizes which client/tab/domain/command;
- deployment observation refers to which release identity.

Weak binding produces invalid inference.

---

## 8.2 Qualification

Many gstack decisions depend on current standing:

- current/stale review;
- done/unverifiable plan item;
- passed/timed-out/skipped test;
- warm/stale memory;
- host install/runtime support;
- delivery readiness;
- service health.

Current standing often matters more than historical ceremony.

The strongest cross-ground qualifications — e.g. ship readiness — may depend on Work + Information + Actors + Environment together.

---

## 8.3 Control

Controls govern an exact effect under a basis/objective.

The strongest real-system lesson is:

```text
one enforcement point succeeds
!= protected effect is controlled end-to-end
```

Examples:

- freeze blocks Edit/Write but not every Bash filesystem effect;
- Claude hook enforcement can degrade to prose on another host.

Authority, decision, enforcement, monitoring and compliance are distinct.

---

## 8.4 Transition

The system repeatedly needs:

```text
requested / approved / issued / recorded change
!= realized change
!= full applicable propagation
!= observed/verified realization
```

Strong examples:

- merge command vs authoritative merge state;
- deploy completion vs live health;
- revert push vs production restoration;
- repository HEAD advance vs installed materialization;
- migration eligibility vs completion;
- source change vs generated/install/live-runtime propagation.

This is candidate pressure for current Foundation Transition/Propagation work, not independent validation of it.

---

# 9. The most durable gstack mechanism set

Implementation details may change, but the following mechanisms appear more durable:

1. **Situation binding** — identify exact cross-ground anchors/roles/scope/time.
2. **Evidence formation** — acquire evidence with source/oracle provenance.
3. **Standing computation** — preserve current/partial/stale/unknown distinctions.
4. **Authority resolution** — separate decision rights from capability.
5. **Control resolution** — govern the protected effect, not merely one path.
6. **Effect execution** — perform bounded mutations/actions.
7. **Authoritative readback** — establish what actually became true.
8. **Freshness invalidation** — revoke prior representations when their object changes.
9. **Aggregation/reconciliation** — combine evidence without hiding disagreement/failure.
10. **Continuity/recovery** — preserve recoverable work across interruptions/state changes.
11. **Feedback** — return outcomes to later decisions without auto-creating work/obligation.
12. **Recursive self-qualification** — apply the same discipline to the operating system itself.

The twelve mechanisms reduce to:

```text
SITUATE → KNOW → QUALIFY → GOVERN → ACT → VERIFY REALITY
                   ↑                         │
                   └──── refresh/learn ──────┘
```

---

# 10. Strongest positive design patterns

## P1 — Current standing over ceremony

A required qualification can be recomputed instead of forcing a named historical workflow.

Example: ship can produce the required current engineering review itself.

## P2 — Durable artifact handoff

Important decisions/work/evidence survive context boundaries in structured artifacts.

## P3 — Heterogeneous evidence

Source review, deterministic tests, real-agent E2E, browser observation, LLM judges, cross-model challenge and production probes answer different questions.

## P4 — Human sovereignty on high-impact transitions

Recommendations/delegation do not automatically erase one-way user authority.

## P5 — Runtime enforcement where possible

Hooks/tokens/CDP/path restrictions create real effect boundaries on capable hosts.

## P6 — False-green hardening

The eval system increasingly asks whether verification actually ran, not merely whether a process/job looked green.

## P7 — Liveness as correctness

Foreground/background semantics, timeouts, cancellation, process-group cleanup, locks and deploy waits are treated as correctness issues.

## P8 — Recursive self-development

Repeated failures are converted into stronger reusable mechanisms and tests rather than patched only locally.

---

# 11. Strongest recurring failure patterns

## F1 — Qualification-loss seam

```text
payload + qualifier
→ downstream view
→ payload survives; qualifier disappears
```

Examples:

- stale memory shown without stale label;
- partial eval treated as run;
- setup failure hidden behind update completion representation.

## F2 — Attempted effect mistaken for target condition

Examples:

- revert push → `REVERTED` without proven restoration;
- command success → assumed state unless readback exists.

## F3 — Enforcement-point scope mistaken for control-objective scope

Examples:

- Edit/Write freeze vs Bash filesystem mutations;
- host hook semantics weakening to advisory prose.

## F4 — Support/coverage labels overstate realized execution

Examples:

- registered host ≠ behaviorally validated host;
- test exists/covered ≠ runtime/oracle executed.

## F5 — Historical artifact mistaken for current truth

Examples:

- checkpoint;
- old review;
- deploy/security report;
- generated docs;
- saved deploy config.

---

# 12. Evolution result

The repository's history shows a recurring progression:

```text
prose / local convention
→ real failure
→ named state distinction
→ reusable helper/resolver/runtime rule
→ structural invariant/scanner
→ behavioral/environment E2E
→ CI/release consequence when justified
```

By v1.79, gstack is increasingly improving **the correctness of its own mechanisms for changing, testing and propagating itself**, not only adding product features.

This progression is strong but incomplete; the pinned revision still contains known qualification/transition/control gaps.

---

# 13. What this study should contribute to SOUL later

The durable value is **not** a list of gstack features to copy.

Candidate lessons include:

- treat qualification metadata as first-class;
- model actual state separately from representation/evidence;
- separate Work admission, Actor authority and Environment capability;
- separate authority from technical effect power;
- model control objective separately from enforcement points;
- model attempted transition separately from realized/propagated state;
- make evidence provenance/execution/oracle explicit;
- make freshness object-relative;
- treat aggregation as a potential epistemic/control boundary;
- keep feedback separate from automatic work admission;
- qualify the system's own generated/install/release state recursively.

These are research pressure points, **not adopted SOUL architecture**.

---

# 14. What must NOT be inferred

Do not infer from this study that:

- gstack should become SOUL's architecture;
- gstack's skill taxonomy should become Foundation taxonomy;
- implementation frequency establishes Foundation importance;
- every gstack `ready/current/supported` status is Composite Standing;
- every gate is deterministic Control;
- all gstack hosts are behaviorally equivalent;
- all first-party tests independently verify their claims;
- the pending Foundation Transition/Propagation result is validated by gstack;
- Causal Effect or Feedback/Adaptation Foundation children are already established;
- gstack's current implementation is internally consistent everywhere.

---

# 15. Final compact answer

## What did gstack do in the four grounds?

```text
Information
→ built a qualified representation/evidence/context system

Work
→ built an admission/execution/evaluation/recovery lifecycle

Actors
→ built explicit authority/delegation/participation/capability distinctions

Environment
→ made runtime/resource/external reality part of workflow semantics
```

## How did it bind them?

```text
bind exact situation
→ form current evidence
→ compute standing
→ resolve authority/control
→ execute effect
→ read back realized reality
→ invalidate stale state
→ continue/recover/learn
```

## What is the deepest result?

> **gstack's sophistication comes less from the number of skills than from repeatedly preserving distinctions among representation, work, authority, operating reality, qualification, control and realized transition — and from gradually turning recurring failures of those distinctions into stronger operating mechanisms.**

That is the core study result.
