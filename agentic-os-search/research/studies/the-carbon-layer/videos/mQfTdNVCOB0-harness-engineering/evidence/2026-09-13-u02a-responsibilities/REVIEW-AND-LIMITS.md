# U02-A — Coverage review, rivals and unverified effects

**Date:** 2026-09-13. **Method:** same-researcher source comparison and analytical counterexamples. This is not a test suite, independent review, runtime PASS or formal completeness proof. No new application behavior was executed.

## Coverage of the bounded question

| Video responsibility | Native source preserved | Primary mechanism | Positive condition | Adverse/discriminating case |
|---|---|---|---|---|
| 1 Instructions | V02 04:16–06:17; two chapter frames | D01/D10 client-specific loading | Stable conventions and explicit constraints | I1 loading-root/name mismatch; I2 untrusted evidence mistaken for instructions |
| 2 Context Delivery | V02 06:17–08:24; two frames | D04 resources; D05 host incorporation | Relevant bounded evidence reaches the request | C1 unresolved link; C2 retrieval miss mistaken for absence |
| 3 Context Management | V02 08:24–10:48; two frames | D02 selection/compaction; D11 computational caching | Sufficient, usable context at sustainable cost | M1 lost prohibition; M2 historical observation incorrectly treated as rereadable |
| 4 Tool Interface | V02 10:48–12:32; two frames | D03 request/result/error contract | Unambiguous operation and interpretable result | T1 ambiguous external effect; T2 structurally valid wrong target |
| 5 Execution Environment | V02 12:32–14:36; two frames | D06 executor-scoped sandbox; D09 historical account | Needed capabilities within applicable boundaries | E1 local versus remote executor; E2 executable presence versus readiness |
| 6 Durable State | V02 14:36–16:13; two frames | D07/D13 persistence; D08 replay | Recoverable progress without needless recomputation | S1 effect/receipt gap; S2 stale approval; S3 wrong continuation identity |

Each responsibility has ownership, inputs/outputs, positive use, tradeoff and a limit in Notes08–10. The six categories are the author's explanatory organization, not our completeness certificate. Orchestration and later responsibilities remain open in U02-B.

## Rival accounts explicitly retained

**Rival A — A sufficiently capable model makes all this unnecessary.** Some work can be performed with a small prompt and few tools; unnecessary harness complexity should be removed. But a model's quality does not by itself establish that an external effect occurred or a persisted record names the correct task. These are separate conditions, not evidence that a fixed component stack is required.

**Rival B — Always provide everything, so retrieval omissions disappear.** A small exact source package can indeed be a good choice. A large/unbounded source space and volatile material present different costs. D02 explicitly retains retrieval tradeoffs. D12's abstract is not used to claim every modern long-context model fails in the same way.

**Rival C — Stronger schemas and sandboxing solve tool reliability.** They address real error classes, but structurally valid wrong targets and uncertain postconditions remain meaningful counterexamples. That observation does not demonstrate that any particular deployed service lacks additional protection.

**Rival D — Durable state guarantees safe continuation.** A RAM-only backend, lost effect acknowledgment and stale permission are different countercases. D08's incomplete-task caveat prevents interpreting a convenient task wrapper as an automatic exactly-once transaction. No crash/recovery behavior was tested here.

**Rival E — Six isolated layers make the architecture clear.** The sources show responsibilities that interact in cycles: retrieval uses tools, tools reveal environment, context writes notes and restored state changes context. Clarity of a diagram is not proof of independent deployment boundaries.

**Rival F — Every limitation we identify is novel.** The video and the older study already state several broad cautions. Our claimed delta is operational grounding, ownership and discriminating transfer cases. We do not rebrand the author's own qualifications as new research results.

## Source-view challenges

The original media were reidentified rather than assuming session filenames proved identity. Twelve chosen frames were inspected, six overlapping the old sample. The limited embedded-caption discrepancy at 15:20 illustrates why a derivative transcript is not an exact speech oracle. Audio alignment, upload date and all detailed product-name claims remain unverified.

Current documentation paths changed: Codex's AGENTS.md guide redirected; LangGraph's old durable-execution route redirected to a persistence landing page with a separate checkpointer guide. The actual current routes were followed rather than reconstructing the old content from memory. Documentation behavior is not source-code or installed-runtime behavior.

MCP normative language was not upgraded: required server responsibilities and recommended client behavior do not constitute a conformance test. Optional resource notifications do not promise universal freshness. D12 is an abstract-only historical orientation. No specification, practitioner article or source count supplies an independent experiment.

## Highest-value unresolved observations

- The actual client/request-visible instruction and context set for a chosen task, including nested guidance, overrides and compaction.
- A workload-conditioned comparison of exact/eager/JIT/hybrid delivery with omission, latency and wrong-source controls.
- Constraint and uncertainty retention after compaction; do not use topic similarity alone as the oracle.
- Target/authority/effect binding for one actual service under a lost acknowledgment, using its real reconciliation or idempotency semantics.
- Actual sandbox and permission coverage for each executor, including approved fallback paths; no cross-tool guarantee from a single label.
- Checkpoint/backend/replay behavior with a deliberately interrupted side effect and an independently observed external state.
- How newly issued effects revalidate current authority without falsifying the historical computation being reconstructed.

These are future probe questions, not seven implemented tests or seven obligations that must all be completed before U02-B. Choose them when a stronger claim or design decision makes them load-bearing. Prior U01-A unrun P01–P07 and U01-B's full-parent-source/runtime/historical limits remain unchanged.

## Closure judgment

U02-A is complete as a bounded source-grounded responsibility analysis. The author/source/interpretation separation is explicit, both beneficial mechanisms and rival conditions are retained, and the next inquiry is identifiable. Whole campaign completion, universal architecture adequacy, live benefit, statistical significance, independent replication and adoption are not established.

The new durable research is Notes08–10 plus SOURCES and this review. MEDIA-READING identifies local source checks; it is not a comprehensive media transcription. Current STATE/PLAN must carry U02-B as next work and preserve all earlier evidence qualifications. A prepared Git tree is not publication; main advancement and readback must be checked separately.
