# gstack — Cross-Ground Mechanism Synthesis

## Status

**Target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Version:** `1.79.0`  
**Layer:** post-four-ground mechanism reduction  
**Foundation mutation:** NONE

This document reduces the completed native, cross-system and four-ground gstack research into the smallest set of recurring **cross-ground operating mechanisms** that explain how the system actually works.

It does not ask which subsystem owns a feature. It asks:

> what recurring semantic operation connects Information, Work, Actors and Environment strongly enough that removing the connection would make the operating system model materially incomplete?

The result remains candidate-study evidence. Foundation labels are used as comparison anchors only where already accepted.

---

# 1. Central reduction: the Qualified Transition Loop

The strongest recurring gstack mechanism can be reduced to one loop:

```text
1. BIND THE SITUATION
   identify exact work / actor / information / environment anchors
   + role / scope / time / version / operation

          ↓

2. FORM / SELECT EVIDENCE
   inspect source / runtime / user input / external state
   + retrieve the relevant prior artifacts

          ↓

3. COMPUTE / RECOMPUTE STANDING
   current? complete? ready? verified? applicable? supported?
   + retain uncertainty / stale / partial / unknown distinctions

          ↓

4. RESOLVE AUTHORITY + CONTROL
   who may decide?
   what effect is governed?
   what enforcement path / override / exception applies?

          ↓

5. EXECUTE A BOUNDED EFFECT
   edit / issue / commit / spawn / merge / deploy / rollback / install / migrate

          ↓

6. READ BACK REALIZED STATE
   do not infer target state from the attempted command alone

          ↓

7. INVALIDATE / TRANSFORM REPRESENTATIONS
   stale refs, review fingerprints, plans, cache, generated output,
   deployment state, running process state, etc.

          ↓

8. CONTINUE / RECOVER / ADAPT
   next work, repair, fallback, rollback, learning, stronger future control

          └───────────────────────────────┐
                                          │
                         repeat on new current state
```

This is not one implemented function or centralized engine. It is a recurring semantic pattern distributed across gstack.

A concise name is:

> **Qualified Transition Loop**

---

# 2. Why this loop is cross-ground

No single accepted Foundation ground can faithfully own the whole loop.

### Information contributes

- representations;
- evidence;
- provenance;
- freshness;
- derivation;
- selection/exposure.

### Work contributes

- candidate pursuit;
- admission;
- execution;
- dependency/coordination;
- evaluation;
- recovery/continuation.

### Actors contributes

- participation;
- delegation;
- authority;
- obligation/permission;
- attribution/responsibility positions.

### Environment contributes

- actual source/runtime/resource condition;
- work conditions;
- host/tool/process/network availability;
- external system and production reality.

The operating transition is only meaningful when the relevant cross-ground relations are preserved.

---

# 3. Mechanism M1 — Situation Binding

## Native question

> What exact thing is this operation about, which parties/resources/artifacts are involved, and in what semantic positions/scope/time/version?

Examples:

- which plan item is being verified by which implementation evidence;
- which user/agent has which browser token over which tab/domain/commands;
- which review finding refers to which diff/source lines;
- which deployment is believed to correspond to which merge SHA;
- which child agent is performing which bounded delegated task;
- which generated host artifact comes from which template/resolver/model/host configuration.

Without this mechanism gstack would collapse into generic links and filenames.

### Foundation comparison

This strongly instantiates accepted **Relational Binding** semantics:

```text
exact anchors
+ typed semantic positions
+ applicability frame
+ relation identity
```

### Failure mode

Weak or missing binding creates false inference.

Examples:

```text
healthy URL
!= proof intended merge SHA is live
```

or:

```text
report exists near PR
!= report verifies that PR
```

---

# 4. Mechanism M2 — Evidence Formation and Lineage

## Native question

> What observation/result was actually formed, from what source/effect, through which oracle/method, and what does it legitimately support?

Evidence sources include:

- repository/source inspection;
- deterministic tests;
- real-agent E2E;
- browser/runtime observation;
- LLM judges;
- cross-model challenge;
- external API/readback;
- production probes;
- user decisions;
- historical operational records.

The mechanism includes lineage, not just payload.

```text
source/effect
→ observation
→ representation
→ provenance/oracle metadata
→ consumer
```

### Foundation comparison

Primarily uses accepted Information Formation/Acquisition and Binding; evidential sufficiency may later participate in Composite Standing.

### Failure mode

```text
test exists
!= test actually executed
```

or:

```text
command returned success
!= external target condition observed
```

---

# 5. Mechanism M3 — Standing Computation / Requalification

## Native question

> Given the current qualified facts, what status meaning legitimately holds now?

Examples:

- plan item DONE / PARTIAL / NOT DONE / UNVERIFIABLE;
- review CURRENT / STALE / UNKNOWN;
- cache warm / stale-fallback / missing;
- test passed / timed-out / never-started / passed-empty;
- version FRESH / ALREADY_BUMPED / DRIFT;
- host registered/generated/installable/runtime-capable/validated;
- delivery ready/not-ready;
- production healthy under criterion;
- finding tentative/reportable.

The important pattern is **recomputation**.

A historical ceremony does not automatically preserve current standing.

### Foundation comparison

- ground-local criterion standing remains Environment where appropriate;
- truly cross-ground qualifications can map to accepted **Composite Standing / Qualification**.

### Strongest cross-ground example

`ship readiness` may constitutively combine:

```text
Work state
+ Information/evidence
+ Actor authority/recognition
+ Environment conditions
```

### Failure mode

Payload survives while qualifier disappears:

```text
stale GBrain content
→ planner sees content without stale standing
```

---

# 6. Mechanism M4 — Authority Resolution

## Native question

> Who is entitled to decide or authorize this transition, and what authority has or has not been delegated?

Examples:

- user chooses design direction;
- user accepts scope change;
- user resolves one-way destructive question;
- parent delegates bounded review work to child;
- user authorizes merge/rollback;
- pair-agent receives scoped browser capability;
- child doc-sync may edit docs but not own release/version decisions.

A central invariant is:

```text
technical effect power
!= legitimate authority
```

### Foundation comparison

Primarily Actors / Agency–Participation–Authority, linked through Binding and Control.

### Failure mode

A technically capable agent silently converts suggestion or preference into authority it does not possess.

---

# 7. Mechanism M5 — Control Resolution

## Native question

> What exact effect/behavior is governed, under what basis/objective, and with what enforcement/override/coverage semantics?

Examples:

- careful Bash interposition;
- freeze Edit/Write boundary;
- one-way question enforcement;
- scoped browser permissions;
- CDP deny-default;
- redaction before sinks;
- plan-completion ship gate;
- version collision CI gate;
- merge/rollback approval.

### Foundation comparison

Strongly maps to accepted **Control / Constraint**.

### Critical distinction

```text
control objective
!= enforcement point
```

Examples:

```text
freeze blocks Edit/Write
but Bash can mutate files
```

and:

```text
Claude hook mechanically enforces
external host may receive only Safety Advisory prose
```

Therefore local mechanism success does not establish end-to-end protected-effect control.

---

# 8. Mechanism M6 — Bounded Effect Execution

## Native question

> What actual effect is attempted, through which route and within which scope?

Effect families include:

- file mutation;
- git/worktree mutation;
- issue/PR mutation;
- child-agent spawn;
- browser interaction;
- memory/brain write;
- merge;
- deploy;
- revert;
- install/update;
- migration;
- process/daemon stop/start.

A key gstack property is that effect routes differ by environment/host.

### Foundation comparison

Effect execution touches Work, Actor participation, Environment actuality and accepted Transition / Effect / Feedback composition.

### Failure mode

Attempted effect is recorded as though the target state necessarily resulted.

---

# 9. Mechanism M7 — Authoritative Readback / Realization Check

## Native question

> What actually became real after the attempted effect?

This mechanism is one of gstack's strongest recurring correctness controls.

Examples:

### Merge

After uncertain/non-zero merge mutation, read authoritative PR state instead of retrying blindly.

### Deployment

Wait for deployment completion, then separately probe live service behavior.

### Browser

After interaction/navigation, take fresh snapshot/evidence rather than trusting old refs.

### QA

Fix → re-observe user-visible behavior.

### Tests

Read execution census/output, not child process exit alone.

### Upgrade

Ideal semantics require setup/materialization readback beyond source checkout advancement; the current session updater is weaker here.

### Foundation comparison

This mechanism strongly pressures the pending Transition / Propagation distinction:

```text
requested / issued / committed change
!= realized change
!= observed realization
```

It does not validate the pending Foundation leaf; it supplies a dense implementation case.

---

# 10. Mechanism M8 — Freshness / Invalidation

## Native question

> Which prior representation, relation or standing no longer applies because the represented object/context changed?

Examples:

- browser refs invalidated by navigation/frame changes;
- review freshness tied to working-tree fingerprint;
- plan hashes change;
- cache TTL/invalidation;
- checkpoint branch/time mismatch;
- generated skills become stale when source/resolver changes;
- deploy config fingerprint changes;
- daemon becomes stale relative to binary;
- test baseline cannot be current run partial;
- host behavior changes because external CLI semantics changed.

This is not one Foundation child by itself. It appears as a validity/currentness dimension across Information, Binding, Standing, Control and Transition.

### Failure mode

Stale state remains visible without stale qualification.

This is the study's strongest representation-seam failure family.

---

# 11. Mechanism M9 — Aggregation / Reconciliation

## Native question

> How do multiple observations, child results, findings or partial outcomes become a decision-ready representation without losing important disagreement or failure state?

Examples:

### Review Army

```text
specialists
→ parse
→ fingerprint
→ dedupe
→ confidence selection
→ red-team challenge
```

### CSO

```text
candidate finding
→ FP filters
→ source validation
→ fresh verifier
→ confidence/status
```

### Ship

```text
tests + plan + review + QA + adversarial evidence
→ delivery standing / remediation
```

### Eval CI

```text
manifest + shard results
→ reconcile missing/failed/timed-out/never-started
→ CI verdict
```

Aggregation is **control-relevant transformation**, not formatting.

### Foundation comparison

Primarily Information Derivation/Transformation plus Standing/Control where the aggregate changes qualification or progression.

### Failure mode

Missing/failed evidence disappears into a positive aggregate.

---

# 12. Mechanism M10 — Continuity / Recovery

## Native question

> How does work remain recoverable and semantically coherent across interruptions, branches, processes, failures, upgrades and changing runtime state?

Examples:

- context checkpoints;
- decision/design artifacts;
- branch/worktree persistence;
- child timeout/fallback;
- process-group cleanup;
- updater lock/heartbeat;
- user-local previous render preservation;
- migration journals;
- review/eval historical artifacts;
- rollback/recovery work;
- daemon state reconciliation.

Continuity is cross-ground because it preserves:

- Work state;
- informational handoff;
- Actor/delegation context;
- Environment/runtime state or recoverability.

### Failure mode

A continuation mechanism restores payload but not validity context — e.g. stale checkpoint trusted as current source truth.

---

# 13. Mechanism M11 — Feedback / Candidate Adaptation

## Native question

> Does an observed result return to influence later decisions/work, and does that influence become persistent system change?

Candidate loops include:

- QA finding → fix → reverify;
- production observation → rollback/continue;
- retro → learning → later planning;
- flake history → test repair/promotion;
- repeated bug → helper/control/test/CI hardening.

This mechanism is strongly present in gstack-native terms.

### Foundation comparison boundary

Foundation `Cross-Ground Feedback / Adaptation` is discovered but inactive. Therefore this study does **not** claim the gstack mechanism maps to an accepted Foundation child grammar.

It is candidate pressure for future research only.

### Important non-collapse

```text
feedback/recommendation exists
!= new Work admitted
!= Actor obligation created
```

---

# 14. Mechanism M12 — Recursive Self-Qualification

## Native question

> How does the operating system itself prove that its generated, installed and released control machinery still realizes the intended semantics?

Loop:

```text
repository source
→ generation
→ install/materialization
→ runtime execution
→ tests/evals
→ version/release
→ user operation
→ failure evidence
→ stronger repository control
```

This is not a separate Foundation ground. It is recursion: gstack applies many of the same mechanisms to its own machinery.

Examples:

- generator freshness;
- host compilation checks;
- install asset completeness;
- user-render atomic swap;
- update/migration handling;
- version-state CLI;
- queue-aware version gate;
- false-green eval hardening;
- v1.79 dispatch recurrence scanner/E2E.

### Core lesson

> A work operating system that cannot qualify its own control/evidence/runtime propagation eventually becomes a stale representation of itself.

---

# 15. The minimal mechanism architecture

The twelve mechanisms can be compressed further into six operating phases plus two continuous concerns.

```text
A. SITUATE
   M1 Binding

B. KNOW
   M2 Evidence formation
   M9 Aggregation

C. QUALIFY
   M3 Standing computation

D. GOVERN
   M4 Authority
   M5 Control

E. ACT
   M6 Effect execution

F. VERIFY REALITY
   M7 Readback / realization

CONTINUOUS CONCERNS
   M8 Freshness / invalidation
   M10 Continuity / recovery

LEARNING / EVOLUTION
   M11 Feedback
   M12 Recursive self-qualification
```

This produces the compact operational loop:

```text
SITUATE
   ↓
KNOW
   ↓
QUALIFY
   ↓
GOVERN
   ↓
ACT
   ↓
VERIFY REALITY
   ↓
refresh / recover / learn
   └──────────────→ SITUATE again
```

---

# 16. Why `QUALIFY` is central but not sufficient

The earlier research phrase “qualification-driven work system” remains correct, but qualification alone cannot explain the system.

A standing such as “ready” is operationally useless unless:

- it is about correctly bound anchors;
- evidence is current and legitimate;
- the correct Actor has authority;
- control semantics govern the intended effect;
- the environment can realize the action;
- the transition is later read back.

Therefore the more complete kernel is:

> **qualified, authorized, evidence-grounded transition with realized-state readback.**

This is the smallest formulation that survives the major gstack counterexamples.

---

# 17. Counterexamples as mechanism tests

The mechanism model is useful because each major negative finding locates a broken link rather than becoming an isolated bug list.

## GBrain stale fallback

Break:

```text
M8 freshness qualifier
→ lost before M3 standing / consumer use
```

## Partial eval in summary/list

Break:

```text
M2 evidence role + M8 partial/final validity
→ lost in M9 aggregation/view
```

## Freeze versus Bash

Break:

```text
M5 enforcement-point coverage
!= protected M6 filesystem effect scope
```

## External-host safety prose

Break:

```text
M5 control strength
→ downgraded by Environment realization
```

## `REVERTED` without production restoration

Break:

```text
M6 rollback effect attempted/completed
→ M7 target-state readback incomplete
→ M3 final standing too strong
```

## Session update setup failure

Break:

```text
M6 source checkout effect succeeds
→ materialization effect fails
→ M3/M2 completion representation can still advance
```

## All-skip green eval

Break:

```text
M2 evidence was never formed
→ old aggregation interpreted process success as verification
```

## v1.79 stranded parent

Break:

```text
M1/M10 parent-child dependency required synchronous completion
→ runtime Environment changed dispatch semantics
→ liveness/continuity contract became false
```

The repair hardened M5/M10 and test evidence around the relationship.

---

# 18. Foundation correspondence table

This table is comparison only, not taxonomy adoption.

| gstack mechanism | Strongest accepted Foundation anchors | Notes |
|---|---|---|
| Situation Binding | Relational Binding + four grounds | exact anchors/roles/scope/time |
| Evidence Formation | Information Formation + Binding | evidence remains target-relative |
| Standing Computation | Environment local standing or Composite Standing | route by constitutive meaning, not label |
| Authority Resolution | Actors + Binding/Control | authority != effect power |
| Control Resolution | Control / Constraint | objective != enforcement point |
| Effect Execution | Work + Actors + Environment + Transition parent | realized effect must be distinguished from command |
| Readback / Realization | Information + Transition parent | observation != transition itself |
| Freshness / Invalidation | Information/Binding/Standing/Control/Transition dimensions | cross-cutting validity concern |
| Aggregation | Information Transformation + Standing/Control | changes decision-facing standing |
| Continuity / Recovery | Work + Information + Actors + Environment | not one-ground reducible |
| Feedback | candidate pressure for inactive Feedback/Adaptation | no accepted child mapping yet |
| Recursive Self-Qualification | recursive application of all above | system operates on itself |

---

# 19. What should survive gstack implementation churn

Many individual gstack details are likely to change:

- skill names;
- hosts;
- model versions;
- CLI commands;
- file paths;
- exact E2E architecture;
- review personas;
- browser internals.

The durable study value is more likely to be:

1. qualification metadata is first-class;
2. current standing outranks ceremony history;
3. artifact meaning depends on typed consumer relation;
4. authority and effect power are separate;
5. control-objective coverage must include alternate effect paths;
6. attempted transition and realized target condition are separate;
7. evidence must preserve execution/oracle provenance;
8. freshness invalidation is object-relative;
9. aggregation can create or destroy epistemic validity;
10. feedback does not automatically become work;
11. runtime environment determines control strength;
12. the OS must recursively qualify its own propagation and release state.

These are the mechanism-level findings that should be retained for later SOUL/Development OS discussion.

---

# 20. Mechanism synthesis conclusion

The smallest source-recoverable gstack model is no longer an inventory of eleven subsystems.

It is:

```text
SITUATE exact cross-ground anchors
        ↓
FORM + SELECT evidence
        ↓
QUALIFY current standing
        ↓
RESOLVE authority + control
        ↓
EXECUTE bounded effect
        ↓
READ BACK realized state
        ↓
INVALIDATE stale representations
        ↓
CONTINUE / RECOVER / LEARN
```

with recursive self-application to gstack's own generated/install/release machinery.

A compact statement is:

> **gstack operationalizes software work as repeated qualified transitions: each important transition is situated through typed relations, grounded in evidence, assigned a current standing, governed by authority/control, executed against real operating conditions, and ideally closed by readback of what actually became true.**

Its strongest recurring defects occur when one of those qualifiers or readback steps is flattened at a subsystem boundary.

This is the most compact mechanism layer yet. The next artifact can therefore be a core model rather than another research synthesis.
