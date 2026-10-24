# U02-A / Note10 — Durable state, replay and qualified continuation

**Date:** 2026-09-13. **Standing:** source-grounded responsibility analysis and bounded cross-responsibility synthesis. Video responsibility 6; not the full U04 synthesis, a SOUL schema or an adoption decision. Read with [Note08](08-INSTRUCTIONS-AND-WORKING-CONTEXT.md), [Note09](09-TOOL-REQUESTS-AND-EXECUTION-BOUNDARIES.md) and [SOURCES](../evidence/2026-09-13-u02a-responsibilities/SOURCES.md). All cases explicitly called analytical are reasoning examples, not executed tests.

## 1. Responsibility 6 — Durable State

### Native claim and exact representation limit

At approximately 14:36–16:13 the author places plans, checkpoints, artifacts, memory and other progress outside the active prompt. The research example includes saved source mapping and assessment material. The author does not claim that storing these objects automatically schedules work or resolves handoffs; that motivates the next orchestration chapter. [V01 frames 920/950; V02]

One small transcription boundary was observed: the embedded caption at 15:20 includes confidence table, whereas V02's corresponding text is less complete. This is evidence of a difference between two representations, not a claim that we listened to and definitively transcribed the audio. The video and audio file identities were reverified; full audio alignment remains open.

### Concrete persistence mechanisms

LangGraph's current documentation distinguishes thread-scoped checkpoints from cross-thread application stores. Its RAM-only checkpointer example does not survive process restart. This makes the selected storage backend material to a persistence claim. [D07]

The checkpointer guide distinguishes complete super-step snapshots from pending writes of successful tasks, documents replay after a prior checkpoint, and offers durability modes with different write timing. We read these sections, not every backend implementation. These are more specific mechanisms than a generic label such as memory. [D13]

The Functional API guide says resumption re-enters the entrypoint and restores completed task results. A task that started but did not complete can run again; its guidance therefore separately calls for idempotent side effects. Resume is not simply continuation from an exact Python line. [D08]

### Mechanism and ownership

A producer creates state; a persistence component serializes and stores it under an identity; a later invocation selects and restores it; the runtime determines which work is replayed, skipped or run again. External systems retain their own state throughout this process. Restoring the agent's record does not automatically restore those external systems or the actor's current permissions.

The saved objects can serve several different purposes:

| Stored object | Useful future role | What storage alone does not establish |
|---|---|---|
| Progress checkpoint | Recover work position and completed results | External effects agree with the checkpoint |
| Source/evidence record | Reopen the basis of a conclusion | It remains current or appropriate for a new use |
| Learned note or lesson | Guide similar future work | Its generalization is valid or authorized as a rule |
| Action/result receipt | Reconcile an attempted operation | The target has not changed since observation |
| Conversation summary | Reconstruct a usable working view | All decisive constraints and unknowns survived |

This is a purpose distinction for analysis, not a mandatory storage design. One record can serve several purposes if its semantics remain clear. A file called memory does not settle which purpose it actually fulfills.

### Positive use and tradeoff

Durable progress can avoid expensive repetition, support long work and allow a different session or actor to recover context. Keeping source links and outcome records supports later review. Separate shared knowledge can help multiple tasks reuse lessons without copying their entire histories.

Persisting every intermediate value has costs in storage, privacy, retrieval and maintenance. Persisting only a short summary can lose decisive evidence. The appropriate granularity depends on replay cost, recoverability and the consequences of ambiguity. Stronger write durability addresses loss of recorded state, not every semantic or external-effect failure.

## 2. A checkpoint and an external effect do not form an automatic transaction

**Analytical case S1: effect before receipt.** Suppose a worker publishes a package through an external service, then the process stops before saving the returned receipt. Its checkpoint still says publication is pending. Replaying that step can repeat an already completed effect. Conversely, writing an intended action into state before dispatch does not prove the publication happened.

The key uncertainty is not simply success or failure; it is whether the effect occurred and can be reconciled. The Functional API documentation explicitly keeps incomplete-task re-execution and idempotency separate from checkpointed completed results. It supports this bounded distinction, not a claim that LangGraph itself provides or fails to provide a particular transaction across arbitrary services. [D08]

Possible resolutions include a stable operation identity understood by the service, a postcondition query, or human escalation where duplication cannot be ruled out. These are alternative mechanisms to study under real service semantics. No release, email or remote mutation was performed here, and no SOUL transaction protocol is being adopted.

**Falsifier for an overbroad claim:** a durable record can exist while external state is uncertain. To justify safe continuation, evidence must connect the relevant record to the actual effect boundary. A successful serialization test would not discriminate this case.

## 3. Historical replay and present authorization are different needs

**Analytical case S2: old permission, new effect.** A workflow stores that a reviewer approved an operation. During a pause the approval is revoked, the target changes, or the permitted scope narrows. Replaying the same historical decision can correctly reproduce what was approved then without establishing what is permitted now.

This exposes a tension rather than a ready-made fix. Replaying prior results can preserve a coherent computation. Revalidating present conditions can change which next effect is permissible. A design must distinguish reconstructing the old decision from authorizing a new external action. Simply caching every check or re-running everything can both be wrong in different ways.

This is our reasoning implication, not an observed defect or claimed built-in authorization feature of LangGraph. A later implementation must identify which facts are historical inputs, which conditions must be fresh, and which external effects have already happened. Existing user grants and current project authority are not replaced by a checkpoint.

**Analytical case S3: wrong continuation identity.** Loading a well-formed checkpoint for a different task or thread can recover valid bytes but the wrong work. Identity, scope and actor ownership are therefore part of continuation, not only persistence syntax. No such misbinding was executed in U02-A.

## 4. A bounded working model across responsibilities 1–6

The chapter sequence can be read as increasing operational responsibility, but it is not a one-way data pipeline. Retrieval already uses tools and environments. Context compaction can write durable notes; restored state supplies future context. Action results become sources for later reasoning. Actual work forms cycles.

Our provisional synthesis is:

**A useful continuation needs the current work and constraints, appropriately selected evidence, an admitted operation in the right environment, and a recoverable account of what happened and what remains uncertain.**

This is a set of conditions to examine, not a completeness theorem, new Foundation ground or six-service architecture. The next four video responsibilities can expose additional control and coordination requirements. The current result must not be closed as the whole operating model.

### One normal path, not six isolated summaries

**Analytical development example:** an authorized worker must repair a failing repository test without deploying. Applicable instructions constrain the work. The actual failing output and relevant revision are delivered; deeper files are read when needed. Context reduction retains the no-deploy boundary and unresolved diagnosis. A tool request targets the intended workspace. The environment supplies the required dependencies and enforces the applicable access boundary. The worker records the changed revision, test scope, result and remaining duty so the next session can continue appropriately.

No individual step proves the whole example successful. A passing test on an old revision, a write in another workspace or a summary that drops the deployment restriction would break different relationships. Equally, not all of these distinctions require separate infrastructure; a simple workflow may carry them in a small set of reliable artifacts.

### A negative path that tests the composition

**Analytical interruption example:** a worker requests an external update; an acknowledgment is lost; its summary compresses 'effect unknown' into 'failed'; a later worker reads that summary and retries. Instructions, context, a valid tool interface, an executor and durable storage can all be present. The problem is the changed meaning between effect uncertainty, persisted representation and next action.

This counterexample challenges a feature-count interpretation of the video. It does not refute the usefulness of any chapter. It shows why interactions need inquiry at the same time as individual mechanisms.

## 5. What this adds beyond U01 and the older knowledge studies

U01-A/B showed concrete consumer/identity/coverage/fidelity failures and useful safeguards in two research implementations. U02-A now places such cases in a broader responsibility model, alongside primary loading, context, protocol and persistence mechanisms. It does not generalize Meta-Harness defects to unrelated systems.

The older context–memory–harness package already warns against conflating persistence, memory and current context. We do not claim that distinction as new. The contribution here is the move from those boundaries to specific producer–consumer questions: which version was loaded, which evidence is eligible, which request was admitted, which executor acted, which effect was observed, and what later continuation may legitimately reuse.

This is also a more precise candidate meaning for consuming our research library. A source might become a context-selection criterion, a test case, a reason to reject a mechanism, or a prerequisite question. Not every document becomes executable policy, and background understanding remains a legitimate form of reuse.

## 6. Provisional SOUL and Development OS pressure, not architecture

For SOUL, forming a work-specific system may require choosing not just components but the conditions under which information and capabilities are activated. The sources suggest useful questions about loading scope, evidence fidelity, effect boundaries and continuation. They do not establish a universal optimum or settle SOUL's architecture.

For Development OS, potential reuse is narrower: preserve a task's exact artifact/constraint/evidence relationships across a research-to-development handoff and a later continuation. Current DevOS implementation state was not audited or changed; its separate ownership and authority remain intact. The formal project-facing synthesis is still U06.

The strongest current hypothesis is that dependable composition depends on preserving the qualifications needed by the next consumer, not maximizing the number of harness features. Counter-hypotheses remain: model limitations, bad objectives, irrelevant sources, excessive control overhead and simple workflows that do not need these mechanisms.

## 7. Bounded closure and next question

Responsibilities 1–6 now have native source anchors, primary mechanisms, positive use conditions, ownership, adverse cases and explicit evidence limits. This closes U02-A as a source-grounded responsibility study, not empirical verification of all implementations or full mastery of the entire video/paper corpus.

No new application/agent runtime, provider request, checkpoint-recovery test, model-context experiment or independent review was executed. New execution was limited to local media hashing and selected frame extraction; analytical cases are not passed tests. Earlier U01 evidence and every unresolved runtime/historical/audio limitation remain separate. [Review and limits](../evidence/2026-09-13-u02a-responsibilities/REVIEW-AND-LIMITS.md)

**Next U02-B:** when several workers, retries, procedures and validators participate, who owns the work and accepts each transition, how do observations reach that owner, and how does the separate evolution loop decide that a change is justified? Reopen video passages 16:13 onward and choose primary sources for these specific questions. Do not presume a single scheduler, a mandatory multi-agent design, or automatic acceptance of an optimizer winner.
