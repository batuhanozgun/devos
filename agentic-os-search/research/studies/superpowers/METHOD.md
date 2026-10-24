# Superpowers Study — Method v0.1

## Purpose and precedent

Use a **semantic synthesis pyramid with source-level evidence provenance**, adapted from [gstack/METHOD.md](../gstack/METHOD.md), read in full on 2026-09-17 (blob `dc003b3f74115667a05787a847eadb10876784c8`). Preserve the method's strengths without importing its subsystem taxonomy, core model or conclusions.

The user authorised detailed research, not installation or adoption. The useful result is an inspectable explanation of Superpowers and its limits, not a large folder of summaries or a prematurely proposed Development OS.

## 1. Bind the corpus

Primary target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`.

Record paths, source blob identities when available, read coverage and observation dates in SOURCE-LEDGER. Directory listing, download, search hit, full reading, static reasoning, local execution and real-host execution are separate statuses.

HEAD checks are revalidation evidence. Do not repin silently or mix revisions. For a changed dependency, identify the affected mechanism and selectively reopen its evidence. An external evaluation repository is a separately pinned dependency, not automatically part of this corpus.

## 2. Use mechanisms, not file quotas

A natural unit is a question plus the source surfaces needed to answer it:

```text
trigger / user situation
  → entry and discovery mechanism
  → skill contract / decision rule
  → host tool or helper implementation
  → artifact / state / next handoff
  → tests, observations and failure paths
```

For example, understanding brainstorming is not merely summarising its SKILL.md. It includes its three-path classification, approval semantics, permitted artifacts, planning handoff and, where relevant, the optional visual runtime. Supporting files may be needed before a mechanism can close.

No rule such as ten files per summary applies. Units may split, merge or reopen as actual dependencies become visible.

## 3. Construct the system in its own terms first

### A. Orientation

Bind the version; map root/source families; distinguish shared skill bodies, host adapters, helper runtime, tests, generated/distribution surfaces and historical material. The first-round inventory is intentionally shallow outside the selected mechanism; do not report recursive repository coverage.

### B. Mechanism expansion

Read the complete load-bearing files for the bounded question. Record inputs, outputs, actors, decisions, gates, state, environment assumptions, failure/recovery paths and evidence. A long contextual document can be read selectively when its remaining content does not carry the current claim; mark the exact range PARTIAL and reopen before broader conclusions.

### C. Subsystem synthesis

Combine sufficiently covered mechanisms into native subsystem explanations. Preserve unresolved contradictions and counterexamples. One source can contribute to several mechanisms. A synthesis cannot upgrade the evidence class of its inputs.

### D. Cross-system synthesis

Follow real seams: request → classification → approval; spec → plan → task; delegation → reviewer context → disposition; implementation → verification → delivery; failure → investigation → resumed work; skill change → evaluation → distribution. Include branches, loops and missing transitions rather than assuming a single linear pipeline.

### E. Project-facing projection

Only after the native model is stable enough, recover the then-current Foundation/project state and ask what the study contributes to Information, Work, Actors and Environment, together with cross-boundary relations. These are comparison views, not source buckets or mandatory taxonomy membership.

At this stage selectively recover relevant gstack/Hermes/other study findings; revalidate external facts when comparing current systems. Comparing a procedure pack to an entire runtime without adjusting scope is invalid.

### F. Core and closure challenge

Produce CORE only when lower syntheses support it. Reverse-check the model against the source catalogue and previously less salient families. Reopen sources when an omitted mechanism changes the explanation. A same-assistant adversarial pass is not independent replication.

## 4. Keep evidence provenance as a graph

```text
pinned sources → mechanism notes → subsystem syntheses → cross-system model → CORE
        ↖──────── source IDs, caveats and reopen links ──────────────────────↙
```

The output hierarchy is for reading; the evidence graph is many-to-many. Summaries remain derived views. A future session must be able to recover the source and the limitation behind a compact conclusion.

## 5. Distinguish the claims being tested

For each relevant mechanism separate:

1. **Target claim:** what the authors say happens.
2. **Instruction contract:** what the skill tells an agent to do.
3. **Implementation observation:** what code/configuration actually contains.
4. **Local execution observation:** what happened under a specified fixture and environment.
5. **Host/model behavior:** whether the host loaded it and an agent selected/followed it.
6. **Effectiveness:** whether it improved the intended development outcome under relevant conditions.

In particular:

`installed ≠ discoverable ≠ in context ≠ selected ≠ followed ≠ effective`.

Likewise, a skill's HARD-GATE wording is not by itself a deterministic enforcement point. A hook successfully emitting JSON is not proof that a host consumed it, and a reviewer role is not proof of independent verification.

Use OBSERVATION, INFERENCE, HYPOTHESIS, TARGET CLAIM and NEGATIVE EVIDENCE LIMIT where material. Label probes source-informed/exploratory when their hypotheses were formed after source inspection.

## 6. Verification proportional to the question

Before a consequential claim, identify the observable and a plausible falsifier. Inspect upstream tests for what they actually assert, including empty/invalid inputs, bypasses, scope and stale verdicts. A green assertion about strings or shape cannot establish model behavior or quality.

A narrow safe local probe is appropriate when it materially separates explanations. Record source identity, fixture, environment, command, criterion, outcome and untested boundaries. Use negative controls or mutations where they genuinely test the oracle. Do not count a failed readiness challenge as successful product validation merely because the test runner recorded it correctly.

Do not turn this source study into an unlimited product-testing campaign. Real host/model evaluations, paid calls, credentials, installation, project mutations and upstream reporting require separate practical capability and authorization checks. Lack of those tests limits claims; it does not prevent bounded source findings.

## 7. Challenge explanations, not just correctness

For important mechanisms ask:

- Is the observed result caused by Superpowers, by the host, by model compliance, or by the fixture?
- Does a claimed control prevent an action, detect it later, merely request restraint, or only expose information?
- What happens when a file, capability, approval or prior artifact is missing?
- Can execution continue with stale or semantically invalid context?
- Does a fallback preserve the user's objective or only keep the process running?
- Could another decomposition explain the evidence better?

Do not manufacture defects by judging the target against an unannounced ideal architecture. Study-defined safety/readiness criteria must be identified as such. Report a local weakness at the layer observed, not automatically as a production incident.

## 8. Every research round leaves a usable handoff

Update source coverage, notes, open questions and PLAN as evidence changes. STATE carries completed/current/next work, authority and cold-start. META carries classification/reuse semantics; the library CATALOG remains derived.

A round should return a bounded substantive result plus recoverable continuation, not merely a plan. Do not create empty future syntheses or announce whole-study completion from one unit. Method changes require a short rationale in PLAN/STATE rather than silently changing the success condition.

## 9. Bounded completion

Closure requires adequate coverage of all load-bearing families; traceable syntheses; an explicit native cross-system explanation; qualified project-facing relevance; recorded unresolved boundaries; and an omission/distortion challenge with no known decision-critical missing family for the study purpose.

It does not require reading every historical issue, executing every possible host, proving universal model obedience or eliminating every upstream defect. Unexecuted behavior and unresolved gaps must remain visible. Study completion never grants adoption authority.
