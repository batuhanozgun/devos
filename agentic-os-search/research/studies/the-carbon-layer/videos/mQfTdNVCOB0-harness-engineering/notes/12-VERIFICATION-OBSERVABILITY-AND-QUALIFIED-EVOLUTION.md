# U02-B / Note12 — Verification, observability and qualified evolution

**Date:** 2026-09-15. **Standing:** bounded source-grounded analysis and interaction example. Covers responsibility 10, the separate evolution loop and the final diagnostic slide. Not the campaign's U04 synthesis or U06 project assessment. [SOURCES](../evidence/2026-09-15-u02b-coordination/SOURCES.md) binds V03/V04 and D19–D22; [Note11](11-ORCHESTRATION-DELEGATION-AND-PROCEDURES.md) covers responsibilities 7–9.

## 1. Responsibility 10 — Verification and observability

### Preserve the author's two questions

At approximately 22:21–25:14, the author asks for evidence beyond a confident final response: tests, builds, screenshots or primary sources appropriate to the work. The next question is what happened along the way: selected context, calls, outputs, changes, approvals, latency and cost. The author already distinguishes checking a result from understanding a failure. [V04 cues 568–643; V03 frames 1370/1445/1500]

Anthropic's evaluation account separates transcripts from actual environmental outcomes. Its selected guidance discusses isolated evaluation environments, balanced cases, valid alternative solutions, grader calibration and transcript inspection. It supports checking the property of interest, not assuming every fixed sequence of tool calls is the desired outcome. [D20]

The SDK tracing guide describes instrumented spans for model calls, tools and handoffs. Collection can be disabled, sensitive payloads can be excluded and export is batched. A trace therefore has a configured observation boundary; it is not necessarily a complete immediately available record. [D19]

### Three distinct contributions

**Verification** asks whether specified evidence supports a particular claim about a particular result. A test passing is informative about what that test checked, on the artifact and conditions actually used. It is not automatically evidence about a later revision, every requirement or permission to publish.

**Observability** makes relevant events and dependencies inspectable. More logs can reveal the point at which a workflow diverged, but log volume does not establish correctness. Missing data can reflect selection, privacy settings or delayed export rather than absence of an event. Recorded model messages are not complete access to internal reasoning.

**Diagnosis** explains why the failure arose and what intervention could change it. A trace can support competing explanations. Finding an incorrect tool result does not yet determine whether the cause was a wrong target, stale source, missing permission, executor failure or faulty interpretation.

These are our distinctions within the source's paired tenth responsibility, not three new mandatory services. A small workflow may implement them with a test result, a concise event record and human investigation.

### Positive and adverse paths

A useful verifier has a clear target, criterion, evidence and failure signal. A useful trace retains the events necessary to resolve an important uncertainty at proportionate privacy and maintenance cost. A useful diagnosis considers an alternative that would change the proposed fix.

**Analytical case V1:** a worker runs the right tests, but on revision C0 while the proposed patch is C1. The test may be valid, and the report truthful, yet acceptance of C1 is unsupported. The corrective question is which artifact was tested, not how confident the final response sounds.

**Analytical case V2:** a result is correct through a legitimate alternative route, but a grader demands one incidental tool sequence. The grader can produce a false failure. Conversely, a successful answer reached through an unauthorized operation must not pass merely because its outcome matches. Outcome criteria and essential process constraints need distinct justification.

**Analytical case V3:** no trace payload is visible, so the reviewer concludes that no tool ran. Before that absence claim, inspect instrumentation, filtering and export conditions. This is not a claim that tracing is useless; it identifies what the trace can legitimately establish.

## 2. The separate loop — Harness evolution

### What the video proposes

At approximately 25:14–26:26, repeated failures feed changes to retrieval rules, schemas, permission gates, tests, memory or reusable procedures. The diagrams at 26:00 and 26:45 label a separate ratchet loop. The source's proposal is to change the working system so that a lesson need not be relearned on every run. Its examples and hoped-for compounding benefit are not empirical proof of monotone improvement. [V04 cues 644–673; V03 frames 1560/1605]

Google's SRE postmortem chapter grounds the author's incident-learning analogy: documented incidents, contributing causes, preventive actions and reviewed follow-up. It also acknowledges the cost of the process and deliberate trigger selection. This is an established engineering practice being connected to agent systems, not a new invention of this study. [D21]

### From an observation to an accepted change

Our provisional change path is:

`observed failure → competing explanations → discriminating evidence → candidate intervention → evaluation under stated conditions → authorized acceptance or rejection → later observation`.

This is an analytical model, not an implemented SOUL workflow. The observer, diagnostician, proposer, evaluator and acceptance owner can be different actors. Their roles should not be silently collapsed merely because one agent can perform several of them.

A diagnosis that implicates missing information may justify changing delivery rather than the model. A faulty grader may require repairing evaluation rather than the agent. Excessive machinery may justify removal, and an isolated low-impact anomaly may not justify a permanent rule. The no-change and simpler alternatives remain live options.

Replaying the motivating incident can show that a candidate addresses that instance. It does not alone establish transfer or absence of regressions. A change selected using the same cases and a post-hoc-adjusted criterion needs additional evidence before a stronger claim. A winning candidate is still separate from permission to modify the working system.

### A source-native caution from the final slide

The 27:20 diagnostic matrix maps symptoms to missing primitives and suggested fixes. Its slogan is more categorical than the surrounding subtitles, which say not to ask only about model quality; the opening also acknowledges model failures. We preserve both representations rather than replacing the source with either a model-only or harness-only explanation. [V03 frame 1640; V04 cues 95–102 and final passage 674–714]

Treat the rows as diagnostic leads, not one-to-one causal rules. For example, forgotten progress could reflect absent storage, a wrong checkpoint, an omitted retrieval or poor use of correctly delivered state. Those alternatives require different interventions. Persisting another file does not necessarily fix them.

The companion article also groups evolution with verification and observability as faces of a proof layer, whereas the sampled video labels its tenth primitive Verification & Observability and gives evolution a separate diagram. This organizational difference is retained, not reconciled into an invented exact taxonomy. The article and video share provenance and are not independent confirmation. [D22; V03]

## 3. One complete interaction example

**Synthetic analysis, not a executed workflow.** An owner is authorized to repair a failing repository test, without deployment. The owner assigns bounded source review and test investigation, supplying the relevant revision, constraints and evidence expectations. Workers receive or retrieve the appropriate procedure. Their returns identify the examined artifact, findings, coverage and uncertainties.

The owner integrates the reports against the actual proposed patch. A verifier checks that patch under the stated criterion. A relevant event record allows another session to see what was attempted and where evidence is missing. Acceptance of the repair and authorization of a later release remain separate. A concise durable handoff records unresolved work and its owner instead of merely saying that all agents finished.

**Adverse branch:** one report concerns C0, the patch is C1, and the shared procedure does not require the distinction. Both workers can be diligent while the integrated conclusion is invalid. Adding a third worker with the same procedure need not help. The owner should first recover the identities, preserve the unresolved verdict, and request the missing check or escalate; not silently accept or blindly replay an uncertain external action.

**Learning branch:** investigation may support adding an artifact-binding check at acceptance. That is a candidate intervention, not a universal answer. Evaluate whether it detects the mismatch while allowing legitimate workflows; consider its overhead and other failure paths; retain the authority to reject it. Only then can accepted experience become a maintained procedure or control.

The example connects instructions/context, actual tools/environment and durable progress from U02-A to coordination, procedures, evidence and change from U02-B. Its coherence is not independent runtime verification.

## 4. What this unit establishes

All ten video responsibilities and the separate evolution loop now have bounded source-grounded treatment across Notes08–12. U02-B contributes operational conditions and discriminating cases; it does not establish a universal architecture, full audiovisual fidelity, live efficacy or the correctness of every named product claim.

For later SOUL/Development OS work, the candidate lesson is to preserve the conditions needed by the next consumer: who owns the work, what reached the worker, what the result refers to, what was actually checked and who may accept the next change. This is a reuse hypothesis, not the dedicated current-project projection; U06 remains open.

U03's experimental/comparator audit, U04's full synthesis, any justified U05 probes, U06 and U07/CORE remain governed by [the plan](../RESEARCH-PLAN.md). Previous unrun tests and historical, causal, cost and media uncertainties are not closed by these documents. [Review and limits](../evidence/2026-09-15-u02b-coordination/REVIEW-AND-LIMITS.md)
