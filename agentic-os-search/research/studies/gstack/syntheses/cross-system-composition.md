# gstack — Cross-System Composition

## Scope

This synthesis is the second research layer over the eleven bounded gstack-native subsystem syntheses.

Pinned target:

`garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
Version: `1.79.0`

It asks:

> how do gstack's subsystems compose into one operating system; what objects cross subsystem boundaries; how are work, authority, evidence, standing and runtime state transformed; and where does the system strengthen or lose qualification as work proceeds?

This remains **gstack-native**. It deliberately does not yet classify the model under SOUL Foundation's Information / Work / Actors / Environment grounds.

---

## 1. Executive conclusion

The most faithful current system model is:

> **gstack is an artifact-mediated, qualification-driven work operating system composed from multiple bounded state machines, evidence producers, authority gates and runtime adapters.**

It is **not** one strict global lifecycle and it is **not** merely a bag of skills.

A simplified end-to-end view is:

```text
user intent
   ↓
discovery / premise challenge
   ↓
approved direction artifact
   ↓
plan + reviews + decisions
   ↓
spec / issue / work admission
   ↓
branch / worktree / implementation
   ↓
review + tests + browser evidence + plan audit
   ↓
delivery qualification
   ↓
PR + merge authority + authoritative merge state
   ↓
deploy evidence + live observation
   ↓
canary / rollback decision
   ↓
retro / learnings / memory
   ↓
candidate future work
```

Running beside this work path are four other planes:

```text
AUTHORITY PLANE
user decisions → delegation → tool/runtime capability → one-way doors → release authority

EVIDENCE PLANE
source → tests → runtime observations → reports → aggregates → current/stale standings

ENVIRONMENT/RUNTIME PLANE
repo/worktree → host → process/filesystem → browser/network → external systems → production

SELF-DEVELOPMENT PLANE
templates/runtime → generation → install → update/migration → eval → release → stronger future controls
```

The system works because these planes are repeatedly joined at **qualification boundaries**.

---

# 2. The primary composition unit is not a skill; it is a qualified transition

A named skill is an important packaging unit, but the deeper reusable pattern is:

```text
current object/state
        ↓
collect relevant evidence
        ↓
interpret / validate / challenge
        ↓
assign or recompute standing
        ↓
check authority
        ↓
allow / deny / defer / ask / degrade / repair
        ↓
produce next object/state + durable evidence
```

Examples:

### Discovery

```text
idea
→ premise evidence + alternatives
→ user selection
→ APPROVED design decision
```

### Work admission

```text
approved direction / plan
→ code-grounded specification
→ sink/privacy/quality controls
→ issue + archive + optional execution handoff
```

### Delivery

```text
implemented diff
→ tests + coverage + plan completion + source review + browser/runtime evidence
→ delivery standing
→ PR/release artifact
```

### Production

```text
qualified PR
→ one-way merge authority
→ authoritative merge readback
→ deploy completion
→ live-health observation
→ canary/rollback decision
```

### Self-development

```text
authored source
→ generated behavior
→ installed materialization
→ runtime execution
→ verification
→ version/release
```

Thus the recurring system primitive is not “run workflow X.” It is closer to:

> **change state only after the relevant object has enough qualified evidence and the transition has the required authority.**

The important qualifier is “enough”: thresholds, failure polarity and override rights vary by object and risk.

---

# 3. gstack is a federation of partial state machines, not one global state machine

The repository contains many local state machines:

- design `DRAFT → APPROVED`;
- review `CURRENT / STALE / UNKNOWN`;
- plan item `DONE / PARTIAL / NOT DONE / CHANGED / UNVERIFIABLE`;
- test shard `passed / failed / timed-out / never-started / skipped-by-diff / passed-empty`;
- browser refs current/stale;
- cache `warm / cold-refreshed / stale-fallback / missing`;
- version `FRESH / ALREADY_BUMPED / DRIFT_STALE_PKG / DRIFT_UNEXPECTED`;
- PR merged/queued/open;
- deploy pending/success/failure;
- Canary baseline/observation/report;
- migration step journal/done;
- host registered/generated/installable/runtime-capable/validated.

There is no universal shared enum and no single coordinator that owns them all.

Instead, composition happens when one subsystem **discovers and interprets another subsystem's artifact or standing**.

For example:

```text
plan artifact
  created upstream
        ↓
ship discovers it
        ↓
ship reinterprets it as a delivery-control object
        ↓
NOT DONE becomes a release interruption
```

The plan did not globally “enter SHIP_GATE state.” A later consumer promoted its meaning.

This gives gstack flexibility, but creates a central dependency:

> **cross-system correctness depends on artifact discovery, representation fidelity and consumer interpretation.**

---

# 4. The work path is artifact-mediated

Conversation alone does not carry the whole system.

Important durable handoff objects include:

- approved design docs;
- plans and plan-review reports;
- decision logs;
- filed issues/spec archives;
- git branch/worktree/diff state;
- review logs and fingerprints;
- QA reports/screenshots;
- plan-completion classifications;
- child-agent JSON results;
- security reports;
- context checkpoints;
- learnings;
- GBrain pages/cache;
- deploy configuration;
- deploy/canary reports;
- retrospectives;
- eval result files/manifests;
- VERSION/CHANGELOG;
- generated host skill trees;
- migration journals/markers.

These artifacts carry more than content. Depending on the artifact, they may carry:

```text
provenance
scope
freshness
confidence
approval
completion status
authority evidence
runtime identity
consumer hints
```

A durable artifact becomes operationally important when a downstream consumer both **finds it** and **recognizes its standing semantics**.

Therefore:

```text
artifact exists
≠ artifact is active control
```

The consumer is part of the artifact's effective meaning.

---

# 5. Information crosses subsystems in three broad roles

Without yet applying Foundation taxonomy, gstack-native information flow can be separated into three roles.

## 5.1 Descriptive state

Represents something believed about the world or work:

- repository source/diff;
- current behavior;
- browser snapshot;
- test result;
- production health;
- checkpoint;
- deployment state.

## 5.2 Normative/control state

Represents what should constrain later work:

- approved design;
- plan scope/out-of-scope;
- one-way decision classification;
- host capability/suppression config;
- security policy;
- deploy configuration;
- migration/version contract.

## 5.3 Qualification state

Represents how strongly some other information/action should be trusted or admitted:

- DRAFT/APPROVED;
- current/stale;
- confidence/status;
- DONE/UNVERIFIABLE;
- passed/skipped/timed-out;
- warm/stale-fallback;
- runtime supported/unsupported;
- merge/deploy/healthy standings.

This third role is especially important. gstack frequently carries **information about information** — whether an artifact is current, verified, partial, trusted, approved or merely advisory.

Many of the study's most important negative findings occur when this qualification metadata is lost while payload content survives.

---

# 6. Qualification metadata is a first-class system dependency

The strongest recurring cross-system failure class is:

```text
source representation:
  payload + qualification

          ↓ derived view / handoff

consumer representation:
  payload survives
  qualification weakens or disappears
```

Observed examples include:

### GBrain

```text
cache layer:
content + STALE-FALLBACK
        ↓
planning resolver suppresses stderr
        ↓
planner receives content without stale label
```

### Eval artifacts

```text
_partial eval result + explicit partial role
        ↓
eval-list / eval-summary
        ↓
can appear as ordinary run/history input
```

while baseline and flake tooling correctly preserve the distinction.

### Repository update

```text
checkout HEAD advanced
+ setup/materialization failed
        ↓
session-update completion markers/logging
        ↓
can still represent UPDATED
```

### Production rollback

```text
revert commit pushed
        ↓
REVERTED
```

without mandatory proof that the reverted version has deployed and production is healthy again.

### Host adaptation

```text
Claude runtime hook contract
        ↓
external-host generation
        ↓
Safety Advisory prose
```

where the concept survives but enforcement strength changes.

These are not one implementation bug. They are a recurring **representation-boundary risk class**.

---

# 7. Current standing repeatedly outranks ceremony provenance

A major strength of gstack is that it often cares more about whether a qualification is **currently satisfied** than whether a specific historical workflow ran.

Examples:

- ship requires an engineering-review standing but can produce a fresh pre-landing review itself;
- a diff review can remain current after rebase if the working-tree fingerprint still matches;
- browser refs are invalidated by page/frame changes regardless of when the snapshot was made;
- deploy config must be re-confirmed after fingerprint-changing source changes;
- eval baseline excludes partial/current-run files regardless of apparent timestamp recency;
- generated skills are re-derived from canonical sources rather than trusted because they were generated once;
- a running browser daemon can be stale even when on-disk binaries are current.

A reusable principle emerges:

> **ceremony history is useful provenance; control should depend on current standing of the relevant object.**

The repository does not achieve this everywhere, but it applies the idea widely.

---

# 8. Authority forms a separate plane from capability and evidence

One of the most important system-level separations is:

```text
can act
≠ may act
≠ action is justified
≠ action succeeded
```

Different mechanisms carry these meanings.

## 8.1 Human decision authority

Examples:

- selecting a design direction;
- accepting scope expansion/reduction;
- resolving plan findings;
- authorizing destructive commands;
- approving merge;
- approving rollback;
- resolving one-way questions.

One-way-door logic prevents convenience preferences from silently erasing these decisions.

## 8.2 Delegated agent authority

Parent workflows can give child agents bounded tasks and expected result schemas. Authority varies:

- review specialist → report findings;
- design variant agent → produce candidate;
- doc-sync spawned workflow → mutate docs within explicit scope;
- pair-agent scoped token → operate permitted browser resources.

A child result does not automatically gain parent authority merely by returning it; parents parse/validate/reconcile results.

## 8.3 Runtime capability

Examples:

- Bash/Edit/Write tool access;
- careful/freeze hook interception;
- browser token scopes;
- tab ownership;
- CDP allowlist;
- URL/filesystem restrictions;
- host-native tool availability.

## 8.4 Evidence justification

A model may have authority and capability but still lack evidence to justify the action.

For example, a user can explicitly override an incomplete plan gate, but that does not make the missing plan item “verified.” It changes the transition authority, not the evidence standing.

This is a crucial distinction:

> **override changes permission to proceed; it does not retroactively improve evidence.**

---

# 9. Security is distributed across the system, not centralized in one subsystem

Cross-system security control appears in several layers:

```text
input/content trust
→ prompt-injection envelopes / learning filters / trust policy

action authority
→ careful/freeze/guard / browser scopes / CDP deny-default

decision authority
→ one-way doors / explicit user approvals

egress/sink controls
→ redaction at issue/archive/PR/memory boundaries

detective assurance
→ review/security specialists / CSO

runtime exposure
→ local/tunnel listener split / tokens / domain scopes

release authority
→ merge/rollback confirmation
```

No single security report or mode proves all of these layers.

The distributed model is appropriate because different threats live at different boundaries. The risk is that “security” can be overgeneralized from the strongest host/path to weaker ones.

For example, Claude hook enforcement may become external-host prose. Therefore security standing is partly **environment-/host-dependent**.

---

# 10. The runtime/environment plane determines whether abstract contracts have effect

Many gstack policies are only real to the extent that the environment can implement them.

Relevant runtime surfaces include:

- repository/worktree and git identity;
- host model/tool semantics;
- filesystem paths/ownership;
- process groups/locks/timeouts;
- browser daemon/tabs/session state;
- network and tunnel exposure;
- GitHub/GitLab/provider APIs;
- CI runner environment;
- production URL/service state;
- local GBrain availability/trust;
- operating-system differences.

The same authored rule can therefore have multiple realized strengths:

```text
contract
→ deterministic runtime enforcement

or

contract
→ host-native equivalent

or

contract
→ inline parent emulation

or

contract
→ advisory prose

or

contract
→ suppressed / unsupported
```

Host portability is consequently not a presentation problem. It is a **semantic realization problem**.

---

# 11. Evidence is heterogeneous and should not be flattened

The system deliberately mixes multiple evidence families because they answer different questions.

```text
source inspection
→ structural/correctness reasoning

deterministic tests
→ executable invariant evidence

real-agent E2E
→ workflow behavior evidence

browser observation
→ user-visible runtime evidence

LLM judge
→ calibrated semantic-quality oracle

cross-model review
→ diversity/challenge signal

production probe
→ live external-state evidence

historical retro / learning
→ longitudinal experience
```

Each has different:

- scope;
- freshness;
- common causes;
- falsifiability;
- independence;
- failure modes.

The testing/eval subsystem is notable because it increasingly stores not just `pass/fail`, but whether work was selected, actually executed, skipped, retried, timed out, partial or comparable to a real baseline.

This leads to a system-level rule:

> **evidence quality depends on preserving execution and oracle provenance, not merely the final verdict string.**

---

# 12. Aggregation is a control operation

Several important parent workflows do not merely collect child evidence. They transform it before it can affect decisions.

Examples:

### Review Army

```text
specialist JSON
→ parse
→ fingerprint
→ deduplicate
→ retain stronger duplicate
→ confidence filtering
→ optional red-team challenge
→ parent findings
```

### CSO

```text
candidate findings
→ hard false-positive filters
→ source-line revalidation
→ fresh verifier
→ confidence/status classification
→ report
```

### Ship

```text
tests
+ coverage
+ plan completion
+ review
+ QA
+ adversarial challenge
→ release qualification / remediation decisions
```

### Paid eval CI

```text
selection
→ manifest
→ shards
→ strict output classification
→ slice reconciliation
→ failure/timeout/never-started distinction
→ CI consequence
```

Aggregation therefore changes standing. It is itself part of the control plane, not formatting after the “real” analysis.

---

# 13. Failure polarity follows expected cost and recoverability

There is no system-wide rule that all uncertainty should fail closed.

Instead, failure polarity depends on what is at stake.

## Often fail toward blocking or human review

- dangerous Bash that cannot be classified → ask;
- high-risk known destructive operations → deny/ask;
- plan `NOT DONE` → interrupt ship;
- missing report slice under promised full execution → fail;
- source-quote failure for strong CSO claim → downgrade/suppress;
- malformed touchfile-map diff → run more tests, not fewer;
- destructive upgrade reset with user state → explicit authority.

## Often fail toward availability/degradation

- optional Codex unavailable → continue with reduced diversity;
- GBrain unavailable → stale/local fallback;
- some deploy platform checks unavailable → warning/degraded evidence;
- session-start updater failure → do not block interactive session;
- version queue allocator unavailable → merge gate warns/fails open.

The problem is not heterogeneous polarity itself. The problem arises when **degradation is not preserved in downstream standing**.

This is why GBrain stale-label loss and update-check offline `UP_TO_DATE` are more significant than the fact that they fail open.

---

# 14. gstack has several nested feedback loops

The system is adaptive because it contains feedback at multiple timescales.

## 14.1 Immediate corrective loop

```text
observe defect
→ fix
→ retest / rereview
→ repeat until qualified or stopped
```

Seen in QA, review, investigate and ship.

## 14.2 Delivery loop

```text
merge
→ deploy
→ observe
→ canary
→ rollback decision if needed
```

The forward loop is stronger than rollback closure at the pinned revision.

## 14.3 Learning loop

```text
work / failure / decision
→ checkpoint / learning / retro
→ qualified prior context
→ later planning/review
```

This loop is advisory unless a downstream consumer promotes the artifact into control.

## 14.4 Verification-maintenance loop

```text
new failure class
→ regression test / new oracle / routing fix
→ future CI standing
```

## 14.5 Repository self-development loop

```text
workflow/runtime failure
→ source fix
→ reusable helper/resolver/runtime rule
→ generated host artifacts
→ setup/update/release
→ real usage
→ new failure evidence
```

This meta-loop is one reason gstack resembles an operating system rather than a static methodology document.

---

# 15. Feedback is not automatically work

A recurring boundary prevents the feedback system from becoming an uncontrolled backlog generator.

Examples:

- Retro recommendations are not automatically admitted tasks.
- Learnings are advisory evidence, not obligations.
- Outside-model suggestions remain informational until accepted.
- Security findings can be tentative/advisory rather than mandatory remediation.
- Production observations can become recommendations rather than immediate mutation.

Thus:

```text
new information
≠ new work
≠ actor obligation
```

A separate admission/authority transition is required.

This preserves user sovereignty and keeps observation from silently mutating scope.

---

# 16. The self-development plane mirrors the product-work plane

A striking cross-system symmetry appears between how gstack develops user software and how it develops itself.

## Product work

```text
intent
→ plan
→ implement
→ verify
→ qualify
→ deliver
→ observe
→ learn
```

## gstack self-development

```text
failure/request
→ repository plan/change
→ template/runtime implementation
→ regenerate/build
→ free/E2E/eval verification
→ version/CHANGELOG qualification
→ merge/update users
→ observe recurrence/community failure
→ strengthen controls
```

The same concepts recur:

- current versus stale evidence;
- durable artifacts;
- human authority on irreversible changes;
- partial failure handling;
- runtime/environment dependence;
- verification topology;
- feedback into future work.

This makes self-development a **recursive application of the system's own operating principles**, although implementation quality is uneven.

---

# 17. The system has a control plane and an effect plane

A useful architecture view is:

```text
CONTROL PLANE
─────────────
routing
workflow contracts
decision/authority rules
standing/freshness logic
review/eval aggregation
host capability negotiation
security interposition
version/release rules

EFFECT PLANE
────────────
file edits
git commits/branches/worktrees
browser interaction
network/API calls
issue/PR creation
merge/deploy/rollback
persistent memory writes
installation/migrations
```

Evidence links them:

```text
EFFECT
→ observation / record
→ CONTROL interpretation
→ next authorized EFFECT
```

The system becomes dangerous when the control plane assumes an effect occurred because a command was issued, rather than reading back authoritative state. gstack explicitly avoids this in some important places (merge readback) and still collapses it in others (rollback closure; some update/materialization markers).

---

# 18. A third plane is needed: the evidence/representation plane

A two-plane model is still incomplete because many failures are not unauthorized effects but **incorrect representations of effects**.

Therefore the stronger model is:

```text
                 CONTROL PLANE
           authority / admission / policy
                    ▲       │
                    │       ▼
EVIDENCE / REPRESENTATION ←→ EFFECT PLANE
source, artifacts,            code, tools,
status, observations          browser, deploy,
freshness, provenance         external effects
```

Examples:

- merge command (effect attempt) → GitHub PR state (evidence) → continuation decision (control);
- browser action → fresh snapshot/screenshot (evidence) → QA fix decision;
- test process → strict output/execution census → release confidence;
- remote version fetch → freshness representation → update prompt;
- user approval → decision log → later work authority.

This triangle is a more faithful system model than workflow arrows alone.

---

# 19. Cross-system seam catalogue

The most important seams are where control responsibility changes hands.

## Seam A — conversation → durable design

Risk: model recommendation mistaken for user decision.  
Control: alternatives + explicit approval + approved artifact.

## Seam B — design/plan → admitted executable work

Risk: ambiguity transferred to implementer.  
Control: spec/code evidence/scope/completion criteria/sink gates.

## Seam C — plan → ship

Risk: planned commitment becomes dead context.  
Control: discovery + plan completion audit + user resolution.

## Seam D — implementation → runtime observation

Risk: source reasoning mistaken for behavior.  
Control: browser QA / executable tests.

## Seam E — child agent → parent

Risk: incomplete/background/stale/untrusted child result.  
Control: foreground semantics, schema, timeout, parse/reconcile, partial-failure policy.

## Seam F — policy → runtime effect

Risk: prose says “do not” but runtime permits it.  
Control strength depends on hooks/tokens/host capability; may degrade.

## Seam G — verification process → green standing

Risk: skipped/partial/truncated/retried run reads as pass.  
Control: selection census, strict output, manifest reconciliation, partial/final distinction, flake record.

## Seam H — merge/deploy command → external state

Risk: command result mistaken for authoritative state.  
Control: remote readback / deploy wait / live probe.

## Seam I — rollback command → restored production

Risk: effect initiated mistaken for target condition.  
Current weakness: mandatory restoration proof missing.

## Seam J — historical information → current reasoning

Risk: stale checkpoint/learning/cache trusted as current.  
Control varies; GBrain stale label currently lost at planning boundary.

## Seam K — canonical source → generated/install/runtime representation

Risk: generated docs, local overlays or installed assets drift from source.  
Control: generation freshness, out-dir render, setup tests; still host/materialization gaps.

## Seam L — version/release identity → user installation

Risk: VERSION label mistaken for immutable release snapshot.  
Current design upgrades main HEAD; tag-pinned semantics remain open.

---

# 20. What makes gstack coherent despite decentralization

The system has no single universal state store or workflow engine, yet several conventions provide coherence:

1. **Durable artifacts with recognizable schemas/locations.**
2. **Repeated use of explicit statuses/standings.**
3. **Freshness/invalidation rules tied to the represented object.**
4. **Explicit user authority at scope/irreversible boundaries.**
5. **Parent-child result contracts and aggregation.**
6. **Runtime enforcement where host/tool APIs permit it.**
7. **Fallback/degradation policies where availability matters.**
8. **Tests/evals that increasingly verify not only output but execution truth.**
9. **Generation/setup machinery that propagates shared rules across skills/hosts.**
10. **Self-development that turns recurring failures into reusable controls.**

The operating-system character comes from this composition more than from any individual skill.

---

# 21. What prevents gstack from being a fully formal operating system

The architecture is disciplined but not globally typed/formalized.

Important limits:

- many standings exist only in local text/file schemas rather than one shared type system;
- artifact discovery can be heuristic;
- consumer behavior can flatten qualification metadata;
- some gates are prompt contracts rather than deterministic runtime enforcement;
- host capability differences alter control strength;
- test coverage strength is heterogeneous;
- user override semantics vary by gate;
- external-state attribution can be incomplete;
- the same semantic term (`gate`, `current`, `supported`, `reverted`, `read-only`) can name materially different mechanics in different subsystems.

Therefore “qualification-driven” describes a strong recurring architecture pattern, not a formally unified kernel.

A more exact phrase is:

> **a federation of qualification mechanisms with shared design conventions and increasingly centralized infrastructure for generation, evidence, authority and release control.**

---

# 22. Core native mechanism set

After cross-system composition, the native mechanism set can be reduced to the following without yet using Foundation vocabulary.

## M1 — Admission

Convert ambiguous candidate activity into authorized, bounded work.

## M2 — Representation / handoff

Turn transient reasoning/results into durable artifacts usable by later subsystems.

## M3 — Qualification

Attach/recompute confidence, completion, freshness, validity or readiness standing.

## M4 — Authority

Determine who/what may decide or cause a transition.

## M5 — Capability / effect boundary

Constrain what tools/runtimes/agents can actually do.

## M6 — Verification / observation

Produce evidence through source reasoning, tests, browser/runtime probes, judges and external readback.

## M7 — Aggregation

Combine heterogeneous evidence and child results into a decision-ready standing.

## M8 — Transition

Perform effects such as edit, commit, issue, merge, deploy, rollback, install or migration.

## M9 — Freshness / invalidation

Determine when prior artifact/evidence no longer applies to current state.

## M10 — Continuity

Preserve recoverable work/state across sessions, branches, processes and upgrades.

## M11 — Feedback

Convert observed outcomes/failures into learning or candidate future work.

## M12 — Adaptation / self-development

Modify the operating system's own contracts/runtime/tests when recurring failure reveals a weak boundary.

These are **native mechanism abstractions**, not Foundation categories.

---

# 23. Cross-system conclusion

The earlier working phrase “qualification-driven work system” survives the second layer, but it can now be sharpened:

> **gstack is an artifact-mediated, qualification-driven software-development operating system whose control plane repeatedly turns heterogeneous evidence and authority into bounded state transitions across repositories, agents, runtime tools, hosts and production surfaces.**

Its characteristic strengths are:

- explicit separation of several intermediate standings;
- recomputation of current evidence rather than blind ceremony reliance;
- human authority at many high-impact transitions;
- durable handoff artifacts;
- heterogeneous evidence sources;
- runtime enforcement where possible;
- strong liveness and false-green hardening;
- feedback into repository self-development.

Its characteristic weaknesses are not random either. They concentrate at **cross-system representation seams** where:

- a degraded/partial/stale state loses its qualifier;
- an attempted transition is represented as completed target state;
- host/runtime capability weakens an authored contract;
- historical artifact existence is mistaken for current truth;
- test existence/green status is mistaken for real execution;
- release/version identity is stronger in representation than in immutable materialization.

This seam model should be retained in the next phase.

---

# 24. Readiness for four-ground projection

The gstack-native model is now sufficiently stable to begin the Foundation comparison/projection layer.

The projection must not ask only four isolated questions. It should preserve at least two views:

```text
A. What does gstack do in:
   Information
   Work
   Actors
   Environment?

B. How do cross-cutting native mechanisms bind those grounds into an operating system?
   admission
   qualification
   authority
   evidence
   transition
   freshness
   continuity
   feedback
   self-development
```

The four grounds should therefore be **projection axes over the stabilized native model**, not replacements for the native model.

---

## Protected cautions for the next phase

1. Do not force each native mechanism into exactly one ground; several are relational/compositional by construction.
2. Do not infer Foundation architecture merely because gstack implements a useful mechanism.
3. Keep implemented mechanism, candidate lesson and Foundation adoption separate.
4. Preserve negative/counterexample evidence; projection should include where gstack loses qualification, not only its successful patterns.
5. Keep host/runtime dependence explicit.
6. Do not treat user authority, agent capability and evidence confidence as one property.
7. Do not treat durable representation as current truth without its freshness/standing semantics.
8. Do not turn the cross-system synthesis into a feature inventory; the purpose is mechanism and relation.
