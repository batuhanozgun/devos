# U02-B / Note11 — Orchestration, delegation and reusable procedures

**Date:** 2026-09-15. **Standing:** source-grounded responsibility analysis, not runtime validation or adopted architecture. Covers video responsibilities 7–9. Continue with [Note12](12-VERIFICATION-OBSERVABILITY-AND-QUALIFIED-EVOLUTION.md). Source IDs, reading extent and media qualifications: [SOURCES](../evidence/2026-09-15-u02b-coordination/SOURCES.md).

## 1. Preserve the source's question

After durable state, the author asks what makes stored work move: who schedules, retries, waits, requests approval and passes work onward? Orchestration answers that lifecycle question; subagents distribute bounded jobs; skills preserve reusable ways of doing them. The author already distinguishes delegation from integration and procedure from proof. These are source positions, not discoveries to claim as ours. [V04 cues 391–567; V03 frames 990–1310]

The following inquiry makes their operating conditions explicit. It does not require a separate service for each chapter or assume that more agents are better.

## 2. Responsibility 7 — Orchestration

### Native account and primary grounding

At approximately 16:13–18:11, orchestration controls progression, hooks, retries, approvals and handoffs. Merely having a saved plan does not initiate its next step. The diagram connects responsibilities rather than establishing a one-way execution pipeline. [V03 frames 990/1060; V04 cues 409–457]

OpenAI's SDK guide permits model-directed, code-directed and mixed orchestration. In its manager pattern, agents used as tools return to a manager that retains the conversation; a handoff instead activates another agent. [D14]

Claude Code's hook documentation makes timing material: PreToolUse can control admission; PostToolUse runs after the operation; Stop and SubagentStop concern normal completion, while StopFailure handles a different exit; asynchronous hooks cannot block the triggering action. These are selected documented contracts, not executed enforcement tests. [D16]

### Mechanism, owner and use conditions

A work owner must distinguish a runnable next step from a step waiting for information, another worker, approval or recovery. A scheduler or model may choose the next activity, but that choice does not by itself establish who remains responsible for the overall objective. A returned worker result can be insufficient even when dispatch and execution finished normally.

This responsibility is useful when work spans waits, retries, several contributors or external decisions. Simple work can use a small explicit sequence instead of a general orchestrator. Model judgment helps when the route is genuinely uncertain; code can enforce known transition conditions. The allocation should follow the problem, not an assumption that all orchestration must be deterministic or model-driven.

**Analytical adverse case O1:** a workflow checks an operation only after it changes a remote target. The check may correctly report a violation but cannot retroactively make that effect inadmissible. The discriminating observation is the check's actual event, timing and protected effect, not the existence of a hook file. This does not prove that any particular deployment is unsafe.

**Analytical adverse case O2:** a worker terminates through an error path, while the system relies only on its normal-stop rule. A reliable continuation needs an account of that exit and a remaining owner. A successful happy-path stop check would not test this case.

**Bounded result:** orchestration is not only selecting the next callable. It must preserve the distinction among waiting, running, failed or uncertain execution, returned work and accepted progress. These are analytical distinctions, not a proposed universal state schema.

## 3. Responsibility 8 — Subagents

### Native account and two non-equivalent transfers

At approximately 18:11–20:30, the author describes splitting bounded work, often with narrower context or tools, then integrating the results. The source explicitly says that not every harness has subagents. It also distinguishes agents-as-tools from handoffs. [V04 cues 458–518; V03 frames 1120/1190]

In the SDK's documented handoff, input_type validates tool-call metadata; it does not replace the receiving agent's conversation input. History is passed unless configured otherwise. The is_enabled check precedes returned arguments; argument-dependent authorization belongs before application effects in on_handoff. Tool input guardrails do not automatically cover handoffs. [D15]

Claude Code documents a different context arrangement for non-fork subagents: they do not inherit the parent's conversation, read files or previously invoked skills. Fork mode is an explicit exception. Configured skills can be preloaded, and later skill discovery is a separate path. [D18]

These are differently configured mechanisms, not a benchmark ranking of products. Neither narrow input nor complete history is universally preferable.

### What has to cross the boundary?

Our inference is that a delegated job needs enough purpose, source identity, constraints and acceptance expectations for its recipient to act correctly. Those may be transmitted explicitly or obtained through an authorized retrieval path. A small payload is helpful only when omitted information is irrelevant or recoverable. Passing everything avoids some omissions but can introduce noise, stale assumptions and inappropriate authority cues.

The return path matters equally: a worker supplies a result and its evidence limits; the integrating owner decides whether it addresses the assigned question. Control of the next conversation turn, ownership of unfinished business work and permission to accept an external effect are separate questions. An SDK's active-agent transition answers only part of that problem.

**Analytical adverse case A1:** a specialist receives a narrow code-review request but not the prohibition on deployment. The context is genuinely smaller, yet a decisive constraint is absent. More specialization would not repair that omission. Inspecting the actual delivered input and tool permissions would discriminate the failure.

**Analytical adverse case A2:** two workers return individually accurate reports about different revisions. Their reports cannot simply be merged into one verdict for the newest artifact. This is a binding/integration problem, not evidence that either worker fabricated its result.

Parallel specialists are plausible when jobs can be bounded and independently inspected. One worker may be better when the context is tightly coupled, integration dominates the cost or delegation would discard essential relationships. No speed, cost or quality improvement was measured here.

## 4. Responsibility 9 — Skills and procedures

### Native account and primary contract

At approximately 20:30–22:21, the author presents reusable know-how: when to use a procedure, required inputs, steps, ordering and preferred tools. PR review and browser work are examples. The source itself warns that following a procedure is not proof that the goal was achieved. [V04 cues 519–567; V03 frames 1250/1310]

The Agent Skills specification defines SKILL.md metadata/instructions with optional scripts, references and assets, and progressive loading. Its allowed-tools field is experimental and support varies by implementation; format validation checks package structure, not successful task performance. [D17]

### Mechanism and ownership

A procedure author maintains reusable guidance. A runtime discovers and supplies it. A worker applies it to a particular job. An evaluator checks the resulting work. A change owner decides whether experience warrants revising the procedure. Combining these roles in one process does not remove their different evidential responsibilities.

The useful gain is shared operational knowledge without repeating the entire lesson in every task. But stored, discoverable, loaded, applicable, followed and effective are not equivalent states. For an important case, examine the actual selected procedure and the recipient's context rather than inferring consumption from directory presence.

**Analytical adverse case P1:** every specialist faithfully applies the same outdated procedure. Consistency has increased, but the error is now correlated. Agreement among these workers is not independent confirmation. A fresh external criterion or a materially different check is needed to distinguish shared correctness from shared error.

**Analytical adverse case P2:** a fixed checklist rejects a legitimate alternative solution because it prescribes an incidental tool order. Procedure conformance then measures a narrower property than the desired outcome. Conversely, outcome success does not excuse violating a non-negotiable action constraint. Which steps are mandatory must be justified by the work's real conditions.

A short task instruction or simple script can be enough for infrequent, stable work. A reusable skill becomes more valuable when recurrence, maintenance and cross-worker use justify its overhead. This research does not adopt a specific skill format or assert that all know-how should become a skill.

## 5. Contribution and next boundary

The source already supplies the three responsibilities. U02-B adds the distinctions needed at their interfaces: lifecycle event versus effect control; delegated conversation versus owned work; advertised context versus actual delivered context; shared procedure versus valid outcome.

The earlier instruction, tool and persistence findings remain bounded by [Note08](08-INSTRUCTIONS-AND-WORKING-CONTEXT.md), [Note09](09-TOOL-REQUESTS-AND-EXECUTION-BOUNDARIES.md) and [Note10](10-DURABLE-STATE-AND-QUALIFIED-CONTINUATION.md). No previous diagnostic was rerun or strengthened here.

A procedure and an integrated response still need evaluation. [Note12](12-VERIFICATION-OBSERVABILITY-AND-QUALIFIED-EVOLUTION.md) follows that handoff through evidence, diagnosis and a possible change. All adverse cases above are analytical, not executed tests.
