# gstack — Multi-Agent / Cross-Model Coordination

**Study target:** `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`  
**Target package version:** 1.79.0  
**Study status:** BOUNDED SUBSYSTEM SYNTHESIS  
**Foundation status:** candidate-study evidence only; no Foundation mutation

## Question

How does gstack distribute work, context, authority and verification across multiple agents/models while controlling handoff, liveness, partial failure, isolation, shared-state contamination and result aggregation?

The important correction is that **“multi-agent” is not one mechanism in gstack**. The pinned system uses several materially different coordination forms:

```text
A. fresh-context specialization
B. parallel fan-out
C. spawned workflow delegation
D. cross-model challenge
E. remote capability pairing
F. optional worktree-parallel implementation planning
```

They differ in purpose, resource isolation, authority, failure semantics and epistemic value. Treating them as one generic “agent team” would erase the important control structure.

---

## Executive synthesis

gstack uses additional agents/models mainly for four reasons:

1. **context separation** — give a reviewer or specialist a fresh context window so it does not inherit the parent’s entire reasoning path;
2. **specialization / search-space expansion** — ask several bounded roles to inspect or generate different things, often in parallel;
3. **workflow delegation** — hand a complete sub-workflow to a child and consume a machine-readable result;
4. **model diversity** — ask Codex for an outside-model read distinct from a same-family Claude subagent.

The strongest coordination pattern is not “spawn more agents.” It is:

```text
parent work state
   ↓
dispatch eligibility / role selection
   ↓
context deliberately included or withheld
   ↓
authority + resource scope
   ↓
execution semantics
   ├─ foreground sequential
   ├─ foreground parallel fan-out
   └─ remote paired capability
   ↓
child result contract
   ↓
validation / normalization / dedupe / consensus
   ↓
partial-failure policy / timeout / cancellation
   ↓
parent continuation + durable evidence
```

The v1.79 stranded-run regression shows why this matters. Parent/child coordination failed when a **load-bearing execution semantic remained implicit**: Claude Code changed Agent calls to background-by-default, while parent workflows still assumed synchronous completion. The repository repaired the proximate failure with explicit `run_in_background: false`, added structural scanning and selected behavioral E2Es, and added bounded recovery to critical ship dispatches. But the deeper recurrence class is not fully eliminated at runtime: a proposed PreToolUse enforcement hook remains TODO, non-Claude host dispatch fidelity remains incomplete, and not every foreground subagent site has the same explicit cancellation/reconciliation protocol.

A second important result is epistemic: gstack itself distinguishes **fresh-context independence** from **outside-model diversity**. Same-family Claude subagents are repeatedly described as fresh-context but *not* an outside model. Codex is separately used for outside-model challenge, and nested Codex is suppressed when already running inside Codex because same-model self-review would add cost without the intended diversity. This is a materially better model than equating “another agent” with independent verification.

---

# 1. Coordination modes

## 1.1 Fresh-context specialization

### Mechanism

Several review flows dispatch a Claude subagent with a clean/fresh context and a role-specific prompt.

Examples include:

- Review Army specialists;
- Claude adversarial review;
- CSO per-finding verification;
- Autoplan CEO/design/eng/DX secondary voices.

The intended benefit is **contextual separation**. The child does not inherit the whole parent conversation/review path and therefore may notice different issues.

Autoplan makes this especially explicit. Its Claude subagent prompts say the subagent has **not seen prior review**. In later phases, prior-phase findings are deliberately withheld from the Claude subagent while Codex may receive them. That creates two different epistemic roles:

```text
Claude subagent
→ fresh-context / less-anchored read

Codex voice
→ outside-model + integrated challenge, often informed by prior findings
```

### Important qualification

Fresh context is not the same as independent verification.

The child may still share:

- the same model family;
- the same repository and diff;
- the same role/checklist framing;
- the same parent-selected hypothesis/finding;
- the same orchestration and output schema.

Therefore:

```text
new context window
≠ independent model
≠ independent oracle
≠ independent evidence source
```

The gstack source itself acknowledges part of this distinction. Its fallback language repeatedly says a Claude subagent is fresh context but the **same model family, not an outside model**.

**Status:** strong authored-contract observation + selected behavioral support.

---

## 1.2 Parallel specialist fan-out

### Review Army

Review Army selects specialists from diff/stack signals and historical hit-rate gating. For a sufficiently large diff, Testing and Maintainability are always-on; Security, Performance, Data Migration, API Contract, Design and Simplification are conditional.

Selected specialists are dispatched as **multiple Agent calls in one parent message**. Each call is foreground (`run_in_background: false`) but calls in one message run concurrently. This is a key distinction:

```text
foreground relative to parent continuation
+
parallel relative to sibling agents
```

The parent waits for the fan-out as a set, then merges results.

Each specialist receives:

- checklist;
- stack context;
- same diff command;
- optional prior domain learnings;
- a strict JSON-lines finding schema.

The parent then:

1. parses valid JSON findings;
2. fingerprints them;
3. deduplicates overlapping findings;
4. keeps the highest-confidence duplicate;
5. tags duplicate agreement as `MULTI-SPECIALIST CONFIRMED`;
6. applies confidence-display gates;
7. optionally sends the merged result to a Red Team child looking for what the first specialists missed.

### Failure semantics

Specialists are explicitly additive:

```text
one specialist fails/times out
→ retain successful specialist results
→ continue parent review
```

This is different from a child whose output is required to construct the next state.

### Epistemic limit

`MULTI-SPECIALIST CONFIRMED` is a useful workflow heuristic, but it is not a statistical independence guarantee. Same-family agents using the same diff and related checklists can produce correlated errors. The `+1` confidence boost is therefore a product heuristic, not a calibrated probability update.

**Status:** strong authored/composed-contract observation; actual parallel-production topology has weaker behavioral coverage than the prose/structural contract.

---

## 1.3 Parallel generative fan-out

`/design-shotgun` uses the same parent→N-Agent shape for a different purpose.

It launches N Agent subagents in a single message, each foreground to parent continuation but concurrent with siblings. Each agent owns its own variant generation, quality check, verification and retry, and the parent later builds a comparison board.

This is not primarily verification. It is **search-space expansion**:

```text
one design problem
→ multiple intentionally different candidate directions
→ comparison
→ user selection / iteration
```

The same multi-agent primitive therefore serves two different system functions:

```text
Review Army     → epistemic coverage / specialist challenge
Design Shotgun  → generative diversity / option production
```

More agents in the second case should not be interpreted as stronger truth confidence.

Dedicated production-topology behavioral coverage for `/design-shotgun` was not found in the inspected test surface at the pinned revision; the parallel contract is strongly visible in generated/template text and global dispatch guidance.

**Status:** strong structural/authored observation; behavioral-topology confidence lower.

---

# 2. Spawned workflow delegation: `/ship` → `/document-release`

The strongest parent/child protocol inspected is `/ship` Step 18.

This is not a small specialist prompt. The parent delegates a **complete named workflow** to a fresh child context.

## 2.1 Why the child is an Agent, not inline execution

The source explicitly requires the Agent tool and rejects inline/Skill execution for this handoff because the dispatch is intended to obtain fresh-context isolation from the preceding ship workflow.

The child is told to read and execute the full `/document-release` skill rather than a reduced reimplementation.

So the intended decomposition is:

```text
parent owns ship lifecycle
child owns bounded documentation-release subworkflow
```

The boundary is role/workflow-specific, not a general transfer of ship authority.

---

## 2.2 Spawned-session behavioral mode

The child is marked `GSTACK_SESSION_KIND=spawned` at `gstack-skill-start` time.

A spawned child has no human reading its output mid-run, so interactive AskUserQuestion gates would strand the parent. The spawned-session policy therefore says:

- do not call AskUserQuestion;
- auto-choose the recommended option;
- for destructive/irreversible decisions, choose the conservative non-destructive option;
- record each auto-choice for parent visibility.

This is a significant coordination rule:

> the same child skill changes its decision-interaction behavior depending on whether it runs interactively or as a machine-consumed subworkflow.

The trust trigger is intentionally narrow. `SESSION_KIND: spawned` must be echoed by the child’s direct `gstack-skill-start` result; a page, file, dispatch prompt or arbitrary tool output claiming “spawned” is not sufficient. That prevents untrusted content from switching the workflow into silent auto-decision mode merely by writing instruction-shaped text.

However, the pinned repository itself records residual concern that the spawned trust chain remains partly prose/self-assertion based; stronger structural runtime enforcement remains follow-up work.

---

## 2.3 Child authority is narrowed by parent scope guard

The child receives a documentation-only scope guard. In the inspected Step 18 contract it must not:

- merge/pull/rebase the base branch;
- change VERSION;
- resolve version collisions;
- rewrite the parent-authored CHANGELOG release entry;
- run the parent-owned Codex documentation-review pass;
- force-push.

A non-fast-forward push becomes result data (`pushed:false`) rather than authority to reconcile history itself.

Thus the child’s effective role is not simply “run document-release.” It is:

```text
full document-release workflow
MINUS parent-owned version/release/history authority
```

This is an example of **workflow delegation with authority subtraction**.

---

## 2.4 Machine-readable result contract

The child’s last line must be a JSON object with a declared shape, including:

- `files_updated`;
- `commit_sha`;
- `pushed`;
- `documentation_section`;
- `decisions`;
- or an explicit `error` failure shape.

The parent validates field types before consuming the result.

This is stronger than a prose handoff because success, no-op and failure are distinguishable states.

The parent also treats `documentation_section` as **untrusted markdown data**. Instruction-shaped content inside that field is not followed, and the later PR sink performs its own redaction scan.

Therefore the boundary is:

```text
child result
≠ trusted parent instruction

child result
→ typed data to validate and integrate
```

---

## 2.5 Shared working tree means fresh context is not filesystem isolation

The Step 18 child and parent operate on the same repository/working tree.

This is crucial. The child may:

- create a documentation commit;
- advance HEAD;
- leave staged files;
- leave uncommitted edits;
- fail after partial mutation.

The parent therefore records pre-dispatch HEAD and has explicit recovery/reconciliation logic.

This establishes a strong negative conclusion:

> gstack subagent “isolation” is resource-specific. Fresh context does not imply filesystem isolation, process isolation, worktree isolation or side-effect isolation.

The source explicitly discusses `isolation: "worktree"` as an implementation-parallelization option in planning, but it is not the universal default for the inspected review/ship Agent dispatches.

---

# 3. Liveness: v1.79 stranded-parent regression

The pinned target commit is itself a high-value causal record.

## 3.1 Outcome

A parent `/ship` workflow could strand indefinitely waiting for a subagent result, especially a machine-consumed LAST-line JSON result.

## 3.2 Proximate cause

Claude Code v2.1.198 changed Agent-tool subagents to **background by default**.

Several synchronous gstack dispatch sites still relied on the earlier/default foreground behavior and omitted:

```text
run_in_background: false
```

The child could therefore launch asynchronously while the parent continued into a state that expected a blocking result.

## 3.3 Contributing condition

The parent/child API contract was synchronous in meaning but not explicit in the Agent invocation.

For Step 18:

```text
parent continuation requires child's final JSON
+
dispatch does not explicitly require foreground completion
→ orchestration contradiction
```

## 3.4 Prevention failure

This was the third recurrence of the class (`#497 → #2440 → Step 18`).

The deeper prevention failure was therefore not merely one forgotten flag. Synchronous dispatch semantics were not represented as a centrally enforced interface invariant across every carrier.

The repository had semantic/prose assumptions about foreground execution, but no universal runtime mechanism forcing those semantics at all gstack Agent call sites.

## 3.5 Detection failure

Prior coverage did not make the whole class loud enough.

The v1.79 change adds:

- a shared foreground-dispatch note;
- a hand-maintained generated-carrier pin set;
- a structural scanner that finds Agent-dispatch imperatives lacking the foreground flag;
- selected behavioral E2E assertions that inspect captured tool-call arguments rather than merely searching prompt text.

The fact that the bug recurred three times is evidence that phrase- or site-specific regression pins were insufficient as the sole prevention mechanism.

## 3.6 Systemic/framing cause

The strongest bounded systemic explanation is:

> a load-bearing synchronization property was treated as default/prose behavior rather than a first-class dispatch-interface property.

That framing made an upstream runtime-default change capable of invalidating downstream workflow liveness.

## 3.7 Fix layers

v1.79 adds several layers:

```text
explicit foreground flag
+
shared explanatory constant/guidance
+
generated carrier pins
+
structural scanner
+
selected behavioral Agent-call E2Es
+
critical-path deadline/recovery logic
```

For ship’s critical dispatches, parent recovery also includes bounded waiting, cancellation attempt and state reconciliation.

## 3.8 Residual recurrence risk

The recurrence class is reduced, not proven eliminated.

At the pinned revision:

- a proposed Claude-host PreToolUse hook that forces/verifies foreground semantics is still TODO;
- not every Agent site has Step 18-level deadline/cancellation/reconciliation logic;
- host-portable subagent dispatch semantics remain incomplete;
- actual child-call compliance still partly relies on generated behavioral instruction plus host/model tool semantics.

Accordingly, “v1.79 fixed the class permanently” would be too strong.

**Status:** strong causal reconstruction from pinned commit + source + tests.

---

# 4. Parent-side failure containment

Step 18 is unusually explicit about a dangerous case: a child is slow, backgrounded unexpectedly or partially mutates shared state.

## 4.1 Bounded wait

If the supposedly foreground Agent call returns launch metadata/task id rather than final output, parent does not immediately launch a duplicate.

It performs a bounded number of status checks across an approximately ten-minute wall-clock window.

Why no duplicate?

```text
child A may still be writing docs
+
child B starts same work
→ racing commits / working-tree corruption
```

## 4.2 Cancellation before parent continuation

If deadline expires, parent first tries to stop the background child.

If it cannot stop the child, the parent does **not** race it. It waits one additional bounded window and then pauses rather than allow concurrent mutation of the shared working tree.

This is an important failure-polarity rule:

> missing documentation is recoverable; uncontrolled concurrent mutation is not treated as an acceptable degradation.

## 4.3 Reconciliation after partial mutation

Parent compares HEAD to pre-dispatch HEAD.

If the child committed before dying:

- inspect each new commit;
- ensure the sequence is docs-only;
- if any new commit touches parent-owned release files, push none of the sequence;
- never force-push;
- surface foreign/local state.

If staged/uncommitted doc edits remain:

- do not silently commit them;
- unstage if necessary;
- never discard the content;
- tell the user/manual follow-up path.

This is a stronger coordination pattern than retry-from-scratch because it recognizes that a failed child may have **realized partial effects**.

---

# 5. Cross-model coordination: Codex

## 5.1 Outside-model role

`/codex` and embedded Codex review passes are intended to provide a different model’s read rather than merely another context window.

The system has explicit availability/health modes before relying on Codex:

```text
disabled
under_codex
not_installed
not_authed
broken_install
model_unusable
ready
```

This avoids flattening “Codex did not run” into “Codex found nothing.”

Timeout paths similarly label the pass as **missing coverage**, not a clean bill.

## 5.2 Under-Codex nesting guard

When a gstack workflow is already running under a Codex host, nested Codex review is normally suppressed.

The source rationale is direct: nesting would be the same model reviewing itself at multiplied token cost. The repository records an observed case of a nested review consuming about 15M tokens.

The detection uses live Codex environment markers such as `CODEX_THREAD_ID` / `CODEX_SANDBOX`; a force override exists.

This is a valuable epistemic distinction:

```text
another process invocation of same model
≠ outside-model diversity
```

## 5.3 Cross-model consensus is still not independent verification

Even when Claude + Codex both run, they share important dependencies:

- same repository/diff;
- same user/system objective;
- often related prompts and categorization;
- same parent orchestration and result selection;
- no external ground-truth oracle merely by virtue of agreement.

Cross-model agreement can increase practical confidence and identify disagreement, but R04-style verification independence is not automatically established.

The system’s own wording often respects this limit more than its marketing language: same-family fallback is explicitly labelled as such, missing voice is `N/A` rather than “confirmed,” and timeout/unavailable states remain visible.

---

# 6. Autoplan dual voices: deliberately asymmetric context

Autoplan is a particularly useful example because it does not simply ask two models the same question.

For CEO/design/eng/DX phases:

1. Claude subagent is run first in foreground with fresh context;
2. Codex is then run through CLI/Bash;
3. consensus/disagreement is synthesized into a table;
4. a missing voice is not counted as confirmation;
5. a critical finding from one voice can still survive even without agreement.

### Context asymmetry

The Claude child is explicitly told it has not seen prior review.

For later phases, Codex may receive summaries of previous phase findings while Claude deliberately does not.

This creates two intentionally different functions:

```text
Claude child
→ de-anchor / independently rediscover

Codex
→ challenge with additional accumulated context
```

This is stronger than accidental duplication because the context boundary itself is part of the method.

### Degradation matrix

If Codex is unavailable, the workflow continues with the Claude subagent and tags the loss of model diversity (`[single-model]`, `[subagent-only]`, etc.).

If both outside voices fail, it falls back to the primary reviewer rather than pretending dual confirmation occurred.

The periodic Autoplan dual-voice E2E checks actual Agent-tool dispatch evidence and actual Codex CLI invocation/unavailability markers, but intentionally does not require full four-phase completion because complete Phase 1 itself can exceed the test’s ten-minute capture budget.

**Status:** strong authored/composed behavior + scenario-bounded periodic behavioral evidence.

---

# 7. CSO verification children: reasoning separation

CSO uses a different subagent pattern.

For each candidate security finding, the workflow asks a fresh child to verify it. Critically, the verifier receives the **finding itself plus false-positive rules**, but not the initial scanner’s full reasoning chain.

This deliberately reduces anchoring:

```text
initial scanner reasoning
      X withheld
candidate finding
      ↓
fresh verifier
      ↓
VERIFIED / UNVERIFIED / TENTATIVE standing
```

This is meaningful verification architecture, but still bounded:

- the finding selected by the parent frames the verifier’s task;
- the model family may still be the same;
- both read the same codebase;
- the verifier is not a wholly independent external assessor.

The CSO E2E surface provides better behavioral evidence for actual child verification than Review Army’s E2Es: the diff-mode test notes that the live agent finds the planted issue, spawns the verification child and writes the report. Other CSO tests intentionally disable Agent delegation for small/scoped fixtures, so coverage remains scenario-specific.

---

# 8. Remote capability pairing is another multi-agent form

`/pair-agent` is materially different from parent-child workflow delegation.

It gives another agent controlled access to the browser runtime.

The capability is mediated through:

- one-time setup key / scoped session token;
- local versus tunnel listener surface;
- scopes and optional domain restrictions;
- token expiry/rate limits;
- tab ownership policy;
- revocation.

Remote pair/tunnel agents default to **own-only tab policy** and can create/drive their own tabs but cannot operate arbitrary other-owned tabs.

This is resource-level multi-agent isolation:

```text
browser tab authority
→ strongly scoped for pair-agent
```

It must not be generalized to repository filesystem state or to local shared browser clients. Local skill browser clients can use a shared tab policy, and ordinary Agent subagents inspected in ship/review are not automatically worktree-isolated.

Thus “agent isolation” has to name the resource:

```text
context isolation
browser-tab isolation
filesystem/worktree isolation
process isolation
memory isolation
model separation
```

They are different properties.

---

# 9. Optional worktree parallelism exists, but is not the default coordination substrate

The plan-eng-review source explicitly analyzes whether implementation work can be split across independent workstreams using Claude Code Agent with `isolation: "worktree"` or parallel workspaces.

This indicates gstack recognizes a stronger isolation form for **implementation parallelization**.

However, the inspected operational review/ship/delegation contracts overwhelmingly depend on fresh contexts over a shared repository rather than universally passing `isolation:"worktree"`.

Therefore:

> worktree isolation is an available/planned execution strategy for independent workstreams, not the universal semantics of gstack subagents.

This distinction matters because Step 18’s recovery logic would be unnecessary if every child had a private worktree with no parent-visible mutations.

---

# 10. Host portability limit

The pinned system does not yet provide one uniform subagent abstraction across every advertised host.

`hosts/define-host.ts` has tool-name rewrites for exec-style runtimes, including a textual rewrite from “use the Agent tool” to `sessions_spawn`, and suppresses several cross-model resolvers on hosts that cannot/should not run them.

But the pinned TODO surface records a concrete defect:

- Codex-host `ship` rendering can still include Step 18 instructions requiring Claude’s Agent tool and `run_in_background` semantics;
- Codex does not have that Agent-tool interface;
- current host rewrites key on specific literal wording and can miss dispatch openers;
- a dedicated audit is required to decide per host whether to rewrite to native delegation, inline the operation, or skip it.

This is not merely future feature work; it is a current portability/fidelity limitation at the pinned revision.

Accordingly:

```text
Claude-host multi-agent contract
≠ automatically portable gstack-wide multi-agent contract
```

A dedicated host-portability synthesis should later determine the full blast radius.

---

# 11. Verification coverage of the multi-agent subsystem

## 11.1 Stronger evidence

### v1.79 structural guard

`test/run-in-background-guidance.test.ts`:

- pins the foreground contract across a declared set of generated carriers;
- scans generated skills for Agent-dispatch language lacking explicit foreground guidance;
- pins recovery/scope text for critical ship paths;
- prevents return of old/inverted guidance.

This is strong structural regression coverage.

### Ship doc-sync dispatch E2E

`test/skill-e2e-ship-docsync.test.ts` drives a real agent through the live ship tail and asserts from captured **tool calls** that:

- `/document-release` was actually dispatched;
- dispatch preceded PR creation;
- the actual Agent/Task call carried `run_in_background: false`.

This avoids a common false-positive class where test prompts themselves contain the string under assertion.

### Spawned doc-sync E2E

`test/skill-e2e-docsync-spawned.test.ts` exercises the child with a real spawned-session preamble and a decision gate that actually fires. It verifies that the child does not prose-stop, records the auto-decision and ends in the parseable JSON contract without mutating VERSION.

### Under-Codex detection tests

`test/codex-under-codex-detection.test.ts` executes the shell preflight logic for environment detection and pins generated consumers.

### Autoplan dual-voice periodic E2E

The periodic test looks for actual Agent and Codex command execution/unavailability signals rather than mere name mentions.

### CSO diff E2E

The live CSO diff scenario behaviorally reaches a verification subagent in at least the recorded/tested path.

---

## 11.2 Weaker or misleading-at-first-glance evidence

### Review Army E2Es

Several files named as Review Army E2Es explicitly tell the model **not to launch subagents**. They instead read a specialist checklist and apply it inline.

Those tests are useful for:

- checklist quality;
- planted-finding detection;
- output schema;
- quality-score behavior;
- plan-completion reasoning.

They do **not** prove:

- parallel Agent dispatch;
- fresh-context separation;
- sibling liveness;
- actual parent aggregation of child tool results;
- real partial-child-failure behavior.

Therefore the core Review Army multi-agent topology has stronger structural than behavioral coverage.

### Design Shotgun

The inspected source strongly specifies parallel Agent fan-out, but a dedicated matching production-topology behavioral E2E was not found in the current targeted search.

### Global 24-carrier foreground contract

The generated-carrier list/scanner is useful, but it is still a source-level structural guarantee. It does not mean all 24 sites have a live E2E that proves the model actually emits the required Agent argument.

---

# 12. Failure-polarity matrix

Multi-agent continuation is context-sensitive rather than globally fail-open or fail-closed.

| Situation | Parent behavior | Interpretation |
|---|---|---|
| one Review Army specialist fails | continue with successful specialists | additive evidence channel |
| Claude adversarial child fails | continue review | quality enhancement missing |
| Codex unavailable | use same-family fresh-context fallback, label degraded | model diversity missing, not whole workflow failure |
| Codex timeout | explicitly mark missing coverage | timeout is not clean result |
| spawned docs child returns valid no-op | continue | qualified no-change outcome |
| spawned docs child returns explicit error | continue ship without docs section | recoverable subworkflow failure |
| docs child silently backgrounded | bounded status checks; no duplicate child | protect liveness + shared-state integrity |
| docs child cannot be stopped and still mutates | bounded extra wait, then stop parent | concurrent mutation worse than delayed ship |
| child leaves partial docs commit | reconcile and vet before push | failure may have realized effects |
| nested Codex under Codex host | skip unless forced | same-model duplication not desired diversity |

This matrix is one of the strongest signs that gstack treats agents as components with different **work criticality and effect authority**, not interchangeable assistants.

---

# 13. Cross-subsystem implications

## 13.1 Context is an explicit coordination resource

The memory synthesis showed that prior information is selected/qualified before reuse. Multi-agent orchestration adds another dimension: sometimes the system deliberately **withholds** prior information to preserve a fresh read.

So context management is not merely retrieval:

```text
context can be loaded
context can be scoped
context can be withheld
context can be independently recomputed
```

## 13.2 Authority and capability are separate from role assignment

Calling a child “documentation agent,” “security verifier,” or “review specialist” does not by itself define what it can actually mutate.

Step 18 explicitly narrows child behavior because the Agent still shares a powerful working environment.

Pair-agent separately uses scoped tokens because browser capability needs a runtime enforcement boundary.

This reinforces a general distinction already visible elsewhere in gstack:

```text
assigned role
≠ legitimate authority
≠ technical capability
≠ realized effect
```

## 13.3 Handoff artifacts can be control protocols

The Step 18 JSON is not merely documentation. It is a machine-consumed protocol that controls parent continuation.

Likewise:

- specialist JSON lines drive merge/confidence logic;
- Autoplan consensus tables drive later decisions;
- CSO verification standings change report qualification.

Information is therefore often part of work-control flow, not passive recordkeeping.

## 13.4 Liveness is a first-class work-system property

The v1.79 regression demonstrates that a workflow may be logically correct yet operationally fail because parent/child completion semantics are wrong.

Work-system correctness therefore includes:

- who waits for whom;
- what completion looks like;
- how long parent waits;
- what happens on partial child effect;
- how cancellation is handled;
- whether duplicate work is safe;
- how parent recovers shared state.

---

# 14. Bounded findings

### M1 — gstack has multiple multi-agent modes, not one agent-team abstraction

**Status:** strong synthesis conclusion.

Fresh-context specialization, parallel review, parallel generation, spawned workflow delegation, outside-model challenge and remote browser pairing have different semantics.

### M2 — fresh-context independence is distinct from model independence

**Status:** strong source observation.

gstack explicitly labels Claude subagents as same-model-family and Codex as the outside-model path. Fresh context reduces some anchoring but does not establish independent verification.

### M3 — parent liveness requires explicit child-completion semantics

**Status:** strong causal conclusion.

v1.79 demonstrates that implicit foreground assumptions can strand parent workflows when host runtime defaults change.

### M4 — the v1.79 bug was a recurrence class, not an isolated forgotten flag

**Status:** strong causal-depth conclusion.

The third recurrence points to a prevention/design failure: synchronous dispatch semantics were not structurally represented/enforced everywhere. Structural scanning and selected E2Es improve detection; runtime enforcement remains incomplete.

### M5 — machine-readable child result contracts materially strengthen delegation

**Status:** strong subsystem conclusion.

Step 18 distinguishes success/no-op/failure, validates types, separates untrusted child markdown from parent instructions and provides explicit parent processing.

### M6 — fresh context does not imply side-effect isolation

**Status:** strong corrective finding.

Ship/document-release shares the working tree, and parent recovery explicitly handles child commits/staging. Browser pair-agent has separate tab isolation; worktree isolation is optional rather than universal.

### M7 — partial failure semantics are work-criticality specific

**Status:** strong synthesis conclusion.

Additive specialists may fail without blocking, while a still-mutating shared-state child can stop parent continuation. Missing evidence is labelled differently from failed mandatory work.

### M8 — multi-agent aggregation is itself a control layer

**Status:** strong source observation.

Findings are parsed, fingerprinted, deduplicated, confidence-gated and synthesized; missing voices are tracked. Child output does not simply flow verbatim into parent authority.

### M9 — multi-specialist/cross-model agreement is useful but can be correlated

**Status:** verification qualification.

Agreement does not automatically satisfy independence because shared object, framing, orchestration and sometimes model family remain common causes.

### M10 — multi-agent host portability is incomplete at the pinned revision

**Status:** direct known-gap observation.

Codex-host ship can receive Claude-specific Agent-tool instructions that it cannot execute; repository TODO calls for a complete host dispatch audit.

### M11 — behavioral coverage of coordination topology is heterogeneous

**Status:** direct coverage conclusion.

Ship docs handoff and spawned gates have strong behavioral evidence; Autoplan has periodic dual-voice liveness evidence; CSO has selected live verifier use. Review Army’s core parallel topology and Design Shotgun are much more structurally than behaviorally established.

### M12 — generative fan-out and verification fan-out must not be conflated

**Status:** strong synthesis conclusion.

Design variants expand the option space; specialist/verifier agents challenge claims or implementation. Agent count has different epistemic meaning in each mode.

---

# 15. Verification status

## Strongly supported

- explicit foreground-dispatch requirement after Claude Code v2.1.198;
- v1.79 recurrence context and structural repair;
- captured Step 18 Agent call with `run_in_background:false` in gate E2E;
- spawned child gate adaptation and JSON result contract in dedicated E2E;
- same-family versus outside-model distinction;
- under-Codex nesting detection behavior;
- Review Army selection/aggregation contract;
- Step 18 shared-state recovery contract;
- pair-agent own-only browser-tab boundary from prior runtime analysis/tests.

## Bounded / weaker

- all generated Agent carriers executing correct foreground behavior in live production;
- actual parallel Review Army tool topology across many specialists;
- Design Shotgun parallel topology in live E2E;
- universal subagent timeout/cancellation semantics outside selected ship/document-review sites;
- semantic independence/calibration of cross-model consensus;
- cross-host multi-agent fidelity.

## Not established

- external independent replication of the orchestration subsystem;
- proof that same-family fresh-context subagents provide statistically independent judgments;
- universal filesystem/worktree isolation;
- universal runtime enforcement of synchronous Agent dispatch contracts;
- universal host-neutral delegation semantics.

---

# 16. Source re-entry map

Load-bearing sources for this synthesis include:

- pinned v1.79 commit `0d1bd5616c0ef096bb7ccee336f63c60ee408618` — recurrence/fix rationale;
- `scripts/resolvers/constants.ts` — foreground dispatch + Codex preflight semantics;
- `test/run-in-background-guidance.test.ts` — global structural regression guard;
- `ship/sections/pr-body.md` — spawned docs workflow handoff/recovery;
- `document-release/SKILL.md` — spawned-session decision semantics;
- `test/skill-e2e-ship-docsync.test.ts` — actual dispatch/foreground behavioral pin;
- `test/skill-e2e-docsync-spawned.test.ts` — child gate + JSON contract behavioral pin;
- `review/sections/review-army.md` — parallel specialist selection/aggregation;
- `test/skill-e2e-review-army.test.ts` — review logic tests and topology limitation;
- `ship/sections/adversarial.md` — same-family adversarial + Codex cross-model challenge;
- `autoplan/sections/{ceo,design,dx,eng}-phase.md` — dual-voice/context asymmetry;
- `test/skill-e2e-autoplan-dual-voice.test.ts` — periodic execution/liveness evidence;
- `codex/SKILL.md` + `test/codex-under-codex-detection.test.ts` — same-model nesting guard;
- `cso/SKILL.md` + `test/skill-e2e-cso.test.ts` — fresh verifier pattern + selected behavioral evidence;
- `design-shotgun/SKILL.md` — parallel generative fan-out;
- `pair-agent/SKILL.md` + browser runtime/tests — remote agent capability isolation;
- `hosts/define-host.ts`, `hosts/codex.ts`, pinned `TODOS.md` — host portability limitation;
- `plan-eng-review/sections/review-sections.md` — optional worktree implementation parallelization.

---

# 17. Implication for the ongoing gstack study

The first six subsystem syntheses now support a more precise version of the working system model:

```text
Planning/spec
→ qualifies intent before admission

Review/ship
→ qualifies implementation before delivery

Browser/runtime
→ qualifies capability/effect/evidence at execution boundaries

Investigate
→ qualifies causal explanation before corrective mutation

Memory/context
→ qualifies prior informational state before reuse

Multi-agent coordination
→ qualifies delegation itself:
   who gets context,
   who gets authority,
   what completion means,
   how outputs are validated,
   and whether failure may safely degrade or must stop parent continuation
```

The v1.79 regression is especially useful because it shows a failure of qualification at the coordination boundary: **the child’s required completion standing existed conceptually but was not encoded strongly enough in the dispatch interface**.

That is a meaningful pressure test of the broader “qualification-driven work system” hypothesis rather than merely another successful pattern.

The next native subsystem should therefore examine a different control plane rather than deepen Agent mechanics immediately: **guarded-action / CSO security-review mechanisms beyond the browser/freeze controls already synthesized**. The host-portability defect discovered here should remain protected and be revisited in the dedicated host-adapter subsystem rather than resolved prematurely inside this study layer.
