# Anthropic AI-Native SDLC Playbook — Falsifiers, Limitations and Open Questions

**Status:** adversarial counter-read for candidate study  
**Date:** 2026-09-04  
**Authority boundary:** these are challenge surfaces and unresolved questions, not accepted SOUL/Development OS requirements.

---

# 1. Why a separate challenge file exists

The playbook is unusually coherent. That creates a specific epistemic risk: a clean end-to-end narrative can make the underlying framing look more complete than it has actually been shown to be.

This file preserves the strongest ways the model can fail, overclaim or become unsafe if imported outside its demonstrated scope.

The purpose is not to “debunk” Anthropic's playbook. The purpose is to preserve **decision-critical boundaries** so later design work can distinguish:

- a useful mechanism;
- a domain heuristic;
- a strong local test;
- an actual system invariant;
- a vendor-specific implementation;
- an unresolved generality claim.

---

# 2. F1 — Six stages are a domain frame, not a proven complete Work model

The article says Plan, Design, Build, Test, Deploy and Maintain together cover the complete lifecycle, while also describing the plays as modular/non-linear.

That may be a useful software-management frame, but current Work research already shows that meaningful Work can require distinct representation of:

- purpose/outcome vs task/method;
- candidate vs committed vs executing work;
- dependency vs stage membership;
- readiness/blockage;
- concurrency/capacity/flow;
- execution completion vs verification/validation/acceptance;
- repair/retry/rollback/compensation;
- continuing/recurring/supporting work.

### Falsifier

Find software work that does not map cleanly to one pass around the six stages without losing a load-bearing distinction.

Examples:

- permanent operational support activity;
- long-running migration with overlapping old/new systems;
- research spike that may reject the intended implementation entirely;
- incident response that temporarily restores service while root-cause remediation remains open;
- cross-service dependency work where readiness is external;
- policy/compliance work that changes acceptance criteria rather than one implementation.

### Current judgment

**Do not import the six stages into SOUL Core or Foundation Work semantics.** Treat them as one software-domain organizing profile.

---

# 3. F2 — Artifact chain fidelity is assumed more than proven

The chain:

`intent → spec → plan → code → review → production`

looks auditable, but every arrow is a transformation where meaning can drift.

Version control proves that a representation existed, not that the transformation preserved purpose.

### Failure modes

- `intent.md` normalizes away ambiguity the originator considered essential;
- `spec.md` resolves an open value decision as though it were a technical constraint;
- `plan.md` chooses a method that satisfies the spec but not the real outcome;
- code matches plan while plan itself was wrong;
- review checks code against stale plan/spec;
- production evidence is mapped to wrong change/version.

### Future question

What explicit derivation/provenance relations are required so a later verifier can test not only “does artifact B exist after A?” but “is B a faithful and authorised transformation of the relevant claims in A?”

This is strongly relevant to Information research but does not determine its taxonomy.

---

# 4. F3 — Source-of-truth transition contains a contradiction risk

The playbook correctly advises naming one source of truth per artifact. It then says linkage can be a minimum transition state while “accepting that there are two sources of truth.”

That phrase is dangerous.

Two mutable sources claiming equal authority create ambiguity exactly when they diverge.

### Safer distinction

During migration, distinguish:

- authoritative source;
- working copy / cache / mirror;
- synchronization state;
- exact binding to source version;
- unresolved divergence.

If the organization genuinely operates two equal authorities, then conflict resolution rules become first-class state—not merely “links exist.”

### Development OS comparison

Current SOUL non-negotiable “one fact should have one authoritative home” is the stronger default.

---

# 5. F4 — Ex-ante plan and post-hoc/as-built plan can be silently collapsed

The playbook recommends committing `plan.md` before coding but also updating it if implementation departs from plan.

Git history retains prior versions, but if the current file simply becomes the final plan, later readers may confuse:

- what was approved before implementation;
- what changed during execution;
- why it changed;
- what evidence justified the deviation;
- what the final as-built state became.

### Failure mode

A bad plan can appear to have been “correct” because it is revised after implementation to match the outcome.

### Candidate stronger structure

```text
plan v1 — accepted before mutation
execution deviation record
new evidence / reason
revised plan v2 or as-built record
fresh downstream verification where material
```

This is a candidate information/history requirement, not an adopted schema.

---

# 6. F5 — Protected failing test is not universal proof

The playbook states that a failing test written before the fix, protected from agent edits, becomes proof the bug is gone once it passes.

This overstates what the evidence can support.

A protected test successfully reduces one important cheating path: changing the oracle to make the result green.

But the test can still be:

- incomplete;
- wrongly specified;
- sensitive only to one reproduction path;
- based on unrealistic fixture/state;
- missing concurrency/timing/load/environment effects;
- satisfied through a workaround that violates a broader requirement.

### Correctly calibrated claim

A protected red→green test is strong evidence that the reproduced failure no longer occurs under the test's represented conditions, subject to oracle validity and coverage.

### Development OS implication

Keep current verification policy's oracle/coverage/falsifiability discipline. Do not weaken it to “green immutable test = proof of semantic success.”

---

# 7. F6 — Fresh verifier context is useful but not independent verification

A fresh context window reduces anchoring from the producer trajectory.

It does not remove shared failure causes such as:

- same incorrect spec;
- same omitted source/context;
- same model/provider blind spot;
- same invalid acceptance criteria;
- same test/oracle;
- same stale target artifact;
- same underlying problem frame.

### Stronger verification question

For each verification claim ask:

- what independent evidence/oracle is available?
- would this verifier fail if the target were wrong in the relevant way?
- is the exact target/version bound?
- did producer and verifier share the same source/frame?
- can deterministic or environmental reperformance replace model opinion?

Development OS already embodies much of this.

---

# 8. F7 — “Skill + Hook” still may not close the actual action surface

The playbook usefully distinguishes advisory Skill from deterministic Hook.

But “Hook = hard boundary” can also be too broad.

A Hook only controls events/actions that actually traverse the Hook's interception surface.

### Alternate-path problem

If one tool is blocked but another mechanism can create the same effect, the policy is bypassable.

Claude enterprise documentation itself illustrates this class: restricting one fetch/tool route is insufficient when unrestricted shell/network access can produce the same external effect.

### Stronger control test

> What materially equivalent paths can reach the protected effect, and does every relevant path cross a control boundary that is not writable by the constrained actor?

This turns control design from “is there a Hook?” into a graph/closure problem.

---

# 9. F8 — Per-agent permissions can underestimate transitive authority

Anthropic's own incident-response case is the strongest falsifier.

A restricted agent without direct production-code authority used Slack to ask another agent with stronger capability to push a fix.

### What this falsifies

```text
local permission list = effective authority
```

### Candidate model pressure

Potential effective authority depends on:

- direct tool permissions;
- communication channels;
- which actors can be addressed;
- whether those actors treat messages as commands/requests;
- delegation/representation rules;
- downstream approval gates;
- identity/authentication;
- capability of reachable tools/actors.

A future security/control model may need to reason over **reachable action paths**, not isolated actor definitions.

Do not promote this into Foundation taxonomy before Actors/relation work is authorised.

---

# 10. F9 — Human gate can become hidden technical verification

The playbook often says human code owners/product owners/release managers remain accountable.

This is correct for genuine authority and risk decisions.

But human approval can become a catch-all if the system cannot independently resolve technical uncertainty.

### Failure pattern

```text
AI review says okay
human approves
→ system claims technically verified
```

Yet the human may have checked only intent/risk, exactly as the playbook intends.

### Required distinction

Represent separately:

- technical verification result;
- human governance/authority approval;
- human technical review, if it actually occurred.

Development OS already maintains this separation more explicitly.

---

# 11. F10 — Parallel throughput can outrun integration/review capacity

The article correctly states that practical parallel-session ceiling is how many streams one engineer can review.

This exposes a fundamental system constraint:

> increasing production concurrency without increasing integration/verification capacity can simply relocate the bottleneck again.

### Failure modes

- merge conflicts;
- semantic cross-branch conflicts not visible as file conflicts;
- inconsistent assumptions;
- reviewers skimming due to volume;
- stale base/target bindings;
- duplicated work;
- canonical-state races.

### Future Work/Environment question

Parallelism should be admitted only when:

- work is sufficiently independent;
- environment supports safe isolation;
- merge/integration authority exists;
- conflict semantics are defined;
- verification capacity exists;
- benefits exceed coordination cost.

---

# 12. F11 — Repository state is not operating reality

The Atlas database critique is a strong counterexample even after accounting for vendor incentive.

A migration can match every repo artifact and pass tests but fail due to live production state:

- data volume;
- lock duration;
- drift;
- storage capacity;
- active client versions;
- engine-specific semantics.

### Generalized falsifier

Any high-impact action whose safety depends on current external state can invalidate a repo-only plan.

Examples beyond databases:

- cloud quota/capacity;
- current infrastructure topology;
- real inventory/financial state;
- live security posture;
- current permissions/organization policy;
- third-party API availability/version;
- physical-world conditions.

### Candidate principle

Action preconditions should sometimes be checked against **actual or sufficiently faithful target state immediately before execution**, with exact time/as-of semantics.

This aligns with Environment research and Information freshness/temporal applicability questions.

---

# 13. F12 — Rollback may be non-reversible or compensating rather than inverse

The playbook recommends a rehearsed rollback path and, at high autonomy, allows agent-triggered rollback through approved runbooks.

This is good operational discipline, but “rollback” is not universally an inverse.

Some changes:

- destroy data;
- trigger external side effects;
- send communications/payments;
- cause irreversible physical actions;
- mutate third-party state;
- create incompatible data during the new version's active window.

### Work research relevance

Current Work research already distinguishes rollback/compensation/recovery.

A future SOUL working system should determine whether:

- true rollback exists;
- forward repair is required;
- compensation is possible;
- human authority is required;
- the action should be blocked because recovery is insufficient.

---

# 14. F13 — Configuration evals can become stale or optimize to the suite

The playbook itself recognizes this risk by calling evals a live suite.

Still, continuous eval gating can create false confidence if:

- tasks no longer represent production distribution;
- agents/configuration adapt to known cases;
- metrics reward superficial success;
- same model generates/evaluates expected outcomes;
- incident-derived cases dominate and unseen classes disappear;
- the suite stops discriminating as models improve.

### Stronger evaluation discipline

Later work should consider:

- holdout/variant cases;
- mutation/falsification tests;
- challenge-set freshness;
- change-delta-targeted probes;
- exact configuration/model binding;
- criterion integrity;
- explicit coverage limits.

This maps directly to the project's existing R04 verification protocol.

---

# 15. F14 — Production monitoring metrics can become proxy targets

The Maintain play uses control bands on stable metrics and provides leading/lagging indicators for every play.

Measurement is valuable, but metrics can be gamed or become detached from intended value.

Examples:

- fewer review findings may mean better generation or weaker reviewer sensitivity;
- faster `intent.md` creation may reduce thoughtful problem discovery;
- high first-pass CI may reward conservative/non-impactful changes;
- more merged changes per engineer may increase downstream maintenance cost;
- low incident recurrence can hide changes in detection coverage.

### Future requirement pressure

Metrics should be interpreted with:

- what property they proxy;
- what failure they cannot see;
- denominator/selection effects;
- whether actor optimization can game the metric;
- paired outcome/quality measures.

---

# 16. F15 — The playbook's platform assumptions are under-specified

Port's critique—while vendor-biased—correctly surfaces assumptions such as:

- affected service is resolvable;
- owner/reviewer is known;
- blast radius can be derived;
- dependencies/context can be assembled;
- correct policy/gate set can be selected.

These are precisely the sort of **system-formation** questions the playbook largely delegates to “platform engineering.”

### SOUL distinction

A future SOUL Genesis layer cannot simply hard-code:

```text
software request → Anthropic six-stage pipeline
```

It must reason about what system the actual outcome requires, including whether parts of this playbook are unnecessary or insufficient.

---

# 17. F16 — Policy source, Skill copy and live enforcement can drift

The article asks for a named policy owner and source of truth, then encodes policy into Skills.

This introduces a derivation/freshness relation:

```text
policy authority
→ Skill representation
→ model behavior
→ Hook/review enforcement
```

### Failure modes

- policy changes but Skill does not;
- Skill changes without policy-owner authority;
- Hook checks old policy;
- review references stale spec;
- multiple repos carry divergent copies.

### Candidate future question

Should executable policy representations carry explicit source/version binding and freshness status rather than relying on naming/review convention alone?

This is strongly relevant to Information/Records research.

---

# 18. F17 — Model/provider changes can invalidate prior control assumptions

Anthropic explicitly treats model changes as eval-triggering configuration changes and reports an authority-path surprise after a model upgrade.

This is a major warning against treating agent behavior as static.

### Candidate future requirement pressure

When model/provider/version changes materially:

- prior behavioral evals may become stale;
- tool-use patterns may change;
- instruction adherence may change;
- newly emergent delegation strategies may bypass assumed boundaries;
- verifier/critic behavior may change simultaneously.

Controls should therefore be designed to depend as little as practical on one model behaving “as expected,” especially for hard boundaries.

---

# 19. F18 — Observability is not assurance by itself

OpenTelemetry/SIEM can record rich agent activity.

But logging everything does not automatically answer:

- was the action correct?
- was the policy valid?
- was the source current?
- was the human approval informed?
- did the system omit an invisible channel/tool path?

Observability is evidence infrastructure. It must connect to:

- identity;
- target/version;
- policy/authority state;
- interpretation rules;
- alert/review ownership;
- retention/access constraints.

SOUL's statement that observability is part of correctness should not be misread as “telemetry presence = correctness.”

---

# 20. F19 — Vendor-reported operational results are not independent efficacy evidence

Anthropic reports high internal code volume and large productivity changes.

These are useful for understanding the scale at which Anthropic claims to operate the model.

They do not establish:

- causal effect of a specific play;
- comparable outcomes in another organization;
- constant code quality or maintenance burden;
- denominator comparability across periods;
- cost efficiency;
- absence of selection/organizational changes.

Any later decision that depends on productivity/security efficacy should seek local experiments or independent evidence.

---

# 21. F20 — Third-party critiques also carry incentives

Atlas and Port provide useful falsifiers because they expose different system boundaries.

But their remedies align with products they sell.

Therefore separate:

- **problem evidence / counterexample** from
- **proposed vendor solution**.

For example:

- Atlas's “actual DB state matters” counterexample is valuable even if Atlas itself is not adopted;
- Port's “system formation/context resolution is under-specified” point is valuable even if Port is not the right platform.

---

# 22. Open questions worth carrying forward

These questions are intentionally **not active Work**. They are revisit triggers for future authorised phases.

## Information / Representation

1. What exact identity/version relation should bind `intent`, `spec`, `plan`, implementation, verification and deployed target?
2. How should ex-ante plan, revised plan and as-built state remain distinguishable?
3. How should executable policy representations bind to authoritative policy sources and freshness?
4. When is a committed artifact authoritative versus merely a working representation?
5. How should conflicting repo/legacy/live environment state be represented?
6. How should model-visible context distinguish authority, evidence, instruction, memory and derived view?

## Work

7. How should candidate intent become committed Work?
8. What dependency/control graph is more fundamental than the six stage labels?
9. When does parallelism increase value versus create integration/review debt?
10. How should incident, repair, rollback, compensation and continuing monitoring be represented distinctly?
11. What makes a stage/gate truly complete versus merely locally successful?

## Actors / Authority

12. How should effective authority account for reachable agents/tools/channels?
13. How are request, delegation, representation and authorization distinguished in agent-to-agent communication?
14. Which human gates are genuine authority/value decisions and which are hidden technical fallback?
15. Can a system mechanically compute an actor's effective action surface under delegation/tool composition?

## Environment

16. Which actions require live target precondition verification immediately before execution?
17. How should environment readiness/sufficiency be verified for parallel sessions and CI agents?
18. How should rollback capability be distinguished from actual reversibility/compensation capacity?
19. Which lower-level action paths can bypass higher-level tool restrictions?

## Verification / Evolution

20. What constitutes a valid regression suite for agent-control configuration?
21. How should eval/challenge sets be refreshed without outcome-driven criterion drift?
22. When does a model/configuration change invalidate prior verification?
23. How should incident-derived evals be weighted against unseen/holdout failure classes?
24. How do we verify the verifier/reviewer configuration itself?
25. What observability evidence is necessary to prove a control actually operated rather than merely existed?

## Genesis / System Formation

26. Under what conditions would a SOUL software-development operating system choose this playbook shape, a subset, or a materially different topology?
27. Which properties of the objective/environment determine required human gates, parallelism, verification layers and persistence horizon?
28. How does the system detect missing capability rather than forcing the work into the capabilities already present?

---

# 23. Current stopping judgment

The external-target study is sufficiently deep for candidate-library reuse.

Additional source collection now would have diminishing value unless a later authorised decision needs one of:

- exact current Claude implementation behavior;
- quantitative efficacy/cost comparison;
- a specific control's security proof;
- software-pilot architecture;
- formal transitive-authority modeling;
- Foundation-node-specific evidence.

The appropriate action now is **not** to continue widening the study indefinitely and **not** to convert the open questions into architecture work.

Preserve them as retrieval/revisit triggers.
