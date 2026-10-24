# U00 / Note01 — two native maps, not one assumed architecture

**Date:** 2026-09-12. **Standing:** initial source reconstruction. Source identities and read limits: [ledger](../SOURCE-LEDGER.md). This note does not establish runtime behaviour of the named products.

## 1. Video-native account

V01/V02 starts by qualifying the component vocabulary as not fully standardised. At approximately 03:25–03:42 it distinguishes a model, its acting loop/runtime and the wider system around that loop. The following map preserves the author's chapter structure. Start times are approximate speech anchors, not a claim that every frame changes exactly then.

| Author's component | Speech anchor; inspected frame | Native concern, paraphrased | Research boundary to test |
|---|---|---|---|
| 1. Instructions | 04:16; 04:40 | Rules, constraints and behavioural guidance | Text can guide a model without mechanically enforcing an effect boundary. |
| 2. Context Delivery | 06:17; 06:40 | Bring relevant work/source information to the model | Delivery does not establish source eligibility, freshness or successful use. |
| 3. Context Management | 08:24; 08:50 | Select, retrieve, rank and compact the working context | Preserving meaning and relevant omissions needs evidence, not only a token budget. |
| 4. Tool Interface | 10:48; 11:15 | Turn proposed action into structured tool requests | Schema validity does not imply authority or correct execution. |
| 5. Execution Environment | 12:32; 13:25 | Run actions within actual host/capability constraints | A sandbox label is not a verified containment property. |
| 6. Durable State | 14:36; 15:20 | Preserve progress and artifacts beyond the active prompt | Existence of state does not ensure correct recovery, selection or work ownership. |
| 7. Orchestration | 16:13; 16:50 | Control sequencing, lifecycle, retries and handoffs | Written workflow, dispatched work and actual external effect can diverge. |
| 8. Subagents | 18:11; 18:40 | Delegate bounded jobs/contexts and integrate results | More workers may introduce authority, coordination and evidence-fidelity failures. |
| 9. Skills & Procedures | 20:30; 20:50 | Reusable know-how loaded for recurring work | Following a procedure is not evidence that the intended outcome occurred. |
| 10. Verification & Observability | 22:19; 23:00 | Check results and record the path that produced them | Checking whether something passed and diagnosing why are different functions. |

The tenth component combines verification and observability in the author's presentation. They are not two separately numbered primitives. The final evolution diagram, inspected at 25:25 and 26:45, is a separate loop rather than an eleventh numbered component.

### The evolution claim

Around 25:14–26:22 the video proposes turning recurring failures into changes: a retrieval rule, stronger tool schema, permission gate, test, memory or reusable procedure. The final practical question is broader than whether the model was capable: where did the surrounding system fail?

This is a useful diagnostic prompt, not evidence of monotonic improvement. We must retain the possibilities that the diagnosis is wrong, the objective/source is wrong, the added rule harms other work, or the right change is to remove machinery. The video itself does not establish an independently tested completeness theorem for its component map.

### Native map versus our concerns

Do not silently replace these ten chapters with the Foundation tree. Instead ask which behaviours cross their boundaries. For example, a tool request can involve source trust, actor authority, work admission, host capability, effect observation and persistent receipts. One rectangular tool-interface box cannot by itself settle those relationships.

## 2. Paper-native account

P01 §§1–3 defines a different object: an outer search over executable harness code around a fixed base model. The harness can govern storage, retrieval, context construction and control flow. The proposer is a coding agent with queryable access to prior candidate code, scores and execution traces.

The method's basic relation is:

`task/interface + baseline candidates → inspect prior experience → propose code → validate/evaluate → retain code/results/traces → propose again → select a candidate`.

This is not weight training, not just editing one system prompt, and not necessarily online self-modification by the deployed worker. The optimiser, the candidate program and the system that accepts a deployment are distinct roles even when one implementation combines some of them.

P01's filesystem access is selective. Large stored feedback histories are not a requirement to put all records into one model context. A CLI or directory structure can expose material for targeted inspection. Whether the actually selected material is faithful and causally useful remains a separate question.

### Three experimental objects, three different boundaries

**Online classification (§4.1, B.1):** harness policies operate over growing labelled-example memory. The paper describes alternatives including a two-call draft/challenge procedure and a one-call label-primer/coverage/contrastive-context policy. The latter, not the draft-verification variant, supplies the strongest main-table result. A verification-labelled design is not automatically the best design.

**Math retrieval (§4.2, B.2, C.2–C.3):** code searches retrieval policy over a prepared problem/solution corpus. The discovered policy routes by lexical cues to different sparse-retrieval, deduplication and reranking behaviours. It is not a universal proof-verification system. The corpus construction, routing, downstream reasoning model and grading each need separate scrutiny.

**Agentic coding (§4.3, A, B.3):** search starts from existing coding harnesses. The described selected change gathers an environment snapshot before the first model call while inheriting substantial tool/completion machinery. Do not attribute the whole inherited agent architecture to the new optimisation. The code-search benchmark is reused for final evaluation; this is an explicit, material scope limit.

## 3. What the paper adds to the video's last loop

The video supplies an engineering proposition: use evidence of failure to change the system. The paper gives one concrete candidate-generation/search procedure and reports experiments. It does not automatically validate the video's whole component taxonomy, all deployment claims or every type of organisational learning.

Conversely, the video keeps operational concerns visible that a reward-optimisation account can leave implicit: rights to act, host boundaries, durable work, human handoffs and actual completion evidence. A future combined model should retain both views and their mismatch.

## 4. First reverse challenge

Try three counterexamples before treating the apparent bridge as established:

- A candidate scores better by exploiting the evaluation setup. It may be a successful search result but an unacceptable operating change.
- An incident is caused by a stale authoritative source. Adding subagents or more context may reproduce the error more efficiently.
- A new model makes a previously helpful wrapper costly or harmful. Adaptation may require simplification rather than another layer.

These are our research counterexamples, not experiments executed by the sources or this study. They set the burden of proof for the next units. The initial validity audit is [Note02](02-INITIAL-VALIDITY-AUDIT.md).
