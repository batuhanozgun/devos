# Multi-Agent Design Patterns — Conversation Synthesis

**Status:** conversation-derived technical note  
**Date:** 2026-09-03  
**Scope:** This document records and systematizes the discussion that followed the shared “Multi-Agent Design Patterns — A Cost-Value Breakdown” image. It is intentionally separate from `research/soul-foundations/**`. It is **not** a foundation research finding, SOUL architecture decision, Development OS decision, or claim that the image is an authoritative taxonomy.

## Why this note exists

The discussion began from a practical question rather than a research program: what do the six patterns in the image actually mean, how do they map to concrete agent systems such as Codex and Claude Code, and which distinctions in the image are useful versus misleading?

The user explicitly asked that the image **not** be turned into a new research topic and that the sections be discussed one by one rather than explained all at once. The Instagram caption supplied with the image was treated as **context from the account that posted it, not as evidence or an authoritative frame**. Its broad claim—roughly, that architecture should match the problem rather than maximize complexity—was evaluated on its merits instead of being adopted because the account asserted it.

The most important correction that emerged is that the six boxes are **not six peer alternatives at the same abstraction level**. Some describe execution order, some describe authority/coordination, some describe review or human governance, and Composite describes composition of the others.

A more accurate reading is therefore:

| Image label | Better understood as |
|---|---|
| Sequential | execution/dependency ordering |
| Parallel | concurrent execution structure |
| Hierarchical | authority/delegation/coordination structure |
| Generator–Critic | production–challenge/review relationship |
| Human-in-the-Loop | human authority/control insertion |
| Composite | composition of multiple structures above |

This distinction matters because a real system can be hierarchical **and** parallel **and** sequential in different places, then invoke a critic and a human approval gate before completion.

---

# 1. Sequential

## Core idea

Sequential execution means that later work depends on earlier work and therefore proceeds in an ordered chain:

```text
Task 1 → Task 2 → Task 3 → Output
```

The useful question is not “is the system multi-agent?” but:

> Does the next step materially require the result of the previous step?

For example:

```text
understand problem
→ construct solution
→ test solution
→ report result
```

This can be performed by one agent or several agents. Therefore Sequential is not inherently a multi-agent pattern; it is an **execution-order pattern**.

## Important correction to the image

The image associates Sequential with “deterministic workflows.” That wording is too broad. A sequential LLM workflow can still be nondeterministic. What may be deterministic is the **ordering constraint**, not necessarily the outputs produced at each step.

## Main benefit

Sequential execution is appropriate when work has real causal or informational dependencies. It prevents a downstream step from running before the required upstream state exists.

## Main cost/risk

The most important risk is not merely latency. It is **error propagation**.

If Task 1 establishes a wrong frame, Tasks 2 and 3 may execute perfectly inside that wrong frame. Later competence does not repair an upstream premise automatically.

Thus a sequential chain needs attention to transition quality:

- what exact output is passed forward;
- whether downstream work knows its provenance and confidence;
- whether a bad upstream result can be challenged before it becomes inherited state.

---

# 2. Parallel

## Core idea

Parallel execution means that two or more pieces of work can proceed without waiting for one another:

```text
                 ┌─ Agent A ─┐
Task ────────────┼─ Agent B ─┼── Merge
                 └─ Agent C ─┘
```

The obvious use is reducing elapsed time when tasks are sufficiently independent.

## Two materially different uses of parallelism

The discussion separated two cases that the image compresses into one.

### A. Parallel decomposition

Different agents solve different subproblems:

```text
Agent A → technical constraints
Agent B → user requirements
Agent C → risks
```

The primary benefit is coverage and/or speed.

### B. Parallel redundancy / ensemble

Several agents independently attack the **same** question and their outputs are compared.

The objective may be:

- alternative hypotheses;
- broader search space;
- disagreement detection;
- reduced dependence on one reasoning path.

This mode may cost more and may not reduce latency. Its value is epistemic only if the outputs are meaningfully independent enough to expose different failure modes.

## The Merge problem

The conversation identified `Merge` as one of the most under-explained boxes in the image.

Running three agents is easy compared with answering:

> What does the system do when their outputs disagree, overlap, contradict one another, or were produced from different assumptions?

A majority vote is not automatically valid:

```text
A → X
B → Y
C → X
```

`X` does not become correct merely because two agents chose it. A, B, and C may share the same model family, framing, sources, or hidden assumption.

Therefore:

> agent count ≠ epistemic independence

A credible merge policy may need to consider:

- evidence quality;
- source independence;
- shared assumptions;
- confidence and uncertainty;
- exact task scope;
- version/state consistency;
- authority to resolve conflict.

## Parallelism in Codex: the conversation’s mental model

A practical confusion arose from the idea that “one session has one agent.” Two common forms were distinguished.

### One parent thread/session with subagents

```text
User
  ↓
Parent agent
  ├─ Subagent A
  ├─ Subagent B
  └─ Subagent C
  ↓
aggregate / continue
```

The user interacts mainly with one parent work surface while the parent delegates work internally.

### Multiple independent threads

```text
Thread 1 → Agent A
Thread 2 → Agent B
Thread 3 → Agent C
```

Here the user or a higher orchestration layer manages multiple work conversations.

Both can produce concurrency, but the coordination burden differs. In the first, the parent system performs more orchestration; in the second, the user or another external layer may do more of it.

## Thread versus session

The discussion used **thread** to mean a distinct task/conversation work line with its own context. “Session” is a broader and sometimes product-dependent term. The important operational point was that a user-visible conversation boundary and an agent-execution boundary need not be identical.

---

# 3. Hierarchical

## Core idea

Hierarchical organization answers a different question from Sequential/Parallel:

> Who delegates to whom, who coordinates whom, and where does responsibility sit?

A basic structure is:

```text
                  Manager Agent
                /      |      \
               /       |       \
      Research     Analysis    Data     Report
       Agent        Agent      Agent     Agent
```

The manager’s main job is not necessarily to perform all detailed work. It may:

- decompose the objective;
- choose or create subroles;
- assign work;
- monitor dependencies;
- receive outputs;
- decide when another step is needed;
- integrate or route results.

## Hierarchical is not the opposite of Parallel

A hierarchical system may execute subagents sequentially:

```text
Manager
  ↓
Agent A
  ↓
Agent B
  ↓
Agent C
```

or in parallel:

```text
              ┌─ Agent A
Manager ──────┼─ Agent B
              └─ Agent C
```

It can also contain multiple levels:

```text
Manager
 ├── Research Lead
 │    ├── Researcher A
 │    └── Researcher B
 └── Development Lead
      ├── Coder A
      └── Tester A
```

Thus hierarchy is primarily an **authority/delegation/coordination topology**, whereas Sequential and Parallel describe execution relationships.

## Depth

The pattern itself has no universal theoretical depth limit. Product implementations may impose limits, defaults, concurrency caps, or recursion controls.

The conversation specifically researched Codex and Claude Code because the user asked how many nested agent levels these products can support.

### Time-sensitive product notes discussed on 2026-09-03

These are **implementation observations, not stable pattern properties**, and should be rechecked before use:

- **Claude Code:** the conversation reported a default subagent spawn depth of three levels beneath the main Claude execution, configurable through `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`, and a default concurrent subagent limit of 20.
- **Codex:** current source inspection showed a legacy/V1 `max_depth` control with default agent depth `1`, while the V2 configuration explicitly marks that V1 depth setting as ignored. V2 exposed concurrency control (including a default of 4 concurrent threads per session in the inspected source). Recursive trees deeper than the old V1 default had also been observed/reported, but those observations were not treated as a guaranteed supported depth contract.

The lasting conceptual conclusion is therefore **not** “Claude supports N and Codex supports M.” It is:

> technical ability to nest agents is separate from whether additional hierarchy is justified.

Any implementation relying on specific nesting depths, environment variables, feature flags, or concurrency defaults should re-check current first-party product documentation/code at implementation time.

## Main value

Hierarchy becomes useful when one unit of cognition cannot simultaneously do all of the following well:

- retain the global objective;
- decompose the problem;
- execute specialized work;
- coordinate dependencies;
- evaluate progress;
- integrate results.

Role specialization and delegation can lower that burden.

## Main failure modes

Hierarchy creates a new class of failures even if every worker is individually competent:

- manager decomposes the problem incorrectly;
- manager assigns the wrong role;
- authority is delegated too broadly;
- a submanager recursively expands the organization without control;
- local work succeeds while the global objective drifts;
- manager incorrectly integrates valid but incompatible outputs;
- intermediate summaries lose information needed downstream.

The central lesson is:

> good workers do not guarantee good management.

---

# 4. Generator–Critic

## Core idea

One role produces an artefact; another role challenges or reviews it:

```text
Generator → Output → Critic
    ↑                 │
    └──── revise ─────┘
```

Example:

```text
Generator:
“I implemented the change.”

Critic:
“There is a race condition and the edge-case test is missing.”

Generator:
“Repairing.”
```

The objective is normally quality and error detection rather than raw speed.

## Critic is not automatically verification

The key correction was:

> two agent roles do not automatically create independent verification.

Generator and Critic may share:

- the same wrong specification;
- the same framing;
- the same sources;
- the same model family;
- the same hidden assumption;
- the same inadequate acceptance criteria.

A critic can therefore approve a well-executed answer to the wrong problem.

## Possible implementations

The conversation separated several degrees of separation:

1. **Self-critique** — the same agent generates and then critiques its own work.
2. **Separate agent/context, same model family** — a distinct execution reviews the result.
3. **Different model/system** — for example, one system generates and another system reviews.
4. **External/deterministic verifier where possible** — tests, schemas, direct calculations, execution evidence, exact-source inspection, etc.

Moving down this list can increase independence potential, but no option is automatically trustworthy. Different models can still share the same wrong specification.

## Claude Code ↔ Codex example

The discussion used a concrete cross-system example:

```text
Claude Code → generate/implement
Codex       → review/challenge
```

or the reverse:

```text
Codex       → generate/implement
Claude Code → review/challenge
```

The important realization was that one product does not magically become the other product’s native subagent. A **cross-system orchestration bridge** is required.

A simplified external sequence can be:

```text
Orchestrator
  ↓
run Claude Code
  ↓ wait for process completion
run Codex
  ↓
collect review
```

and the direction can be reversed.

The bridge may be a shell script, Python program, CI workflow, service, or another orchestration layer.

### Programmatic sequencing discussed

The conversation identified non-interactive/programmatic CLI execution as a simple basis for such orchestration: Codex can be invoked through non-interactive `codex exec`, and Claude Code can be used in a print/programmatic mode such as `claude -p`. An external process can wait for the first command to exit before launching the second.

That means both directions are possible in principle:

```text
Claude Code finishes → Codex starts
```

and:

```text
Codex finishes → Claude Code starts
```

as well as longer loops such as:

```text
Claude → Codex review → Claude repair → Codex re-check
```

The orchestrator—not the products “sensing” one another—is what establishes the completion signal and sequencing.

## Why an external orchestrator can be preferable

If Generator itself decides what the Critic should see, how the task is framed, and when review is sufficient, the Generator’s mistakes can contaminate the review path.

A stronger design can give the Critic:

- the original requirement;
- exact artefact/diff/commit;
- independent acceptance criteria;
- direct access to relevant evidence;
- explicit instruction to inspect rather than merely agree with the producer’s explanation.

The deeper principle is:

> Critic value depends on which error classes the critic can actually detect.

A critic loop that cannot falsify the relevant failures may add token cost, latency, and false confidence rather than quality.

---

# 5. Human-in-the-Loop

## Core idea

The agentic system performs work until a defined point where human judgement, authority, or approval becomes necessary:

```text
Agent work
  ↓
Human review / judgement / approval
  ↓
continue / revise / reject
```

Example:

```text
Agent prepares deployment
  ↓
Human approves production release
  ↓
Deployment proceeds
```

## Two different reasons to involve a human

The discussion separated two roles that are often collapsed.

### A. Authority / governance

The human must decide because the choice belongs to human values, responsibility, legal/organizational authority, irreversible risk, or explicit approval boundaries.

### B. Verification / additional error detection

The human actually inspects the work and may detect errors the automated path could miss.

These are not the same.

A human who clicks `Approve` without inspecting technical evidence may satisfy an authority gate while adding little technical verification value.

## Main value

Human-in-the-Loop is valuable where delegation should stop before:

- irreversible or high-impact actions;
- value-laden decisions;
- financial commitments;
- production changes;
- external communications with material consequences;
- policy or legal authority boundaries.

## Main risk

A badly designed system can make the human a hidden orchestrator, search engine, or rubber-stamp verifier. Human involvement should have a clear reason and an explicit decision surface.

---

# 6. Composite

## Core idea

Composite is not simply a sixth independent pattern. It is the deliberate **composition** of several coordination/control structures.

The image shows a chain like:

```text
Input
→ Router
→ Sequential
→ Parallel
→ Hierarchical
→ Generator–Critic
→ Human Loop
→ Output
```

but a realistic Composite system does **not** need to execute every pattern in that order.

A more realistic structure is conditional:

```text
                     ┌→ simple work → direct agent path
                     │
Input → Router ──────┼→ decomposable work → parallel path
                     │
                     ├→ large coordinated work → hierarchical path
                     │
                     └→ high-risk action → human approval path
```

Different parts of one job may then combine these structures.

## Input

Input is whatever enters the system as work:

- user request;
- GitHub issue;
- API event;
- document;
- incident;
- scheduled trigger;
- structured work definition.

## Router

The Router answers:

> Which work path should this input take?

Example:

```text
README typo
→ direct/simple path

complex bug investigation
→ parallel analysis

large refactor
→ hierarchy + parallel work

production database deletion
→ human approval gate
```

Router and Manager are not identical:

- **Router:** which path is appropriate?
- **Manager:** how should work be decomposed and coordinated inside that path?

One component could play both roles, but the questions are conceptually different.

## Orchestration

Orchestration is the coordination machinery that makes the whole system actually run:

```text
Did A finish?
→ start B and C
→ wait for both
→ retry C if it failed
→ send outputs to integrator
→ invoke critic
→ if risk gate reached, request human approval
```

It includes such concerns as:

- sequencing;
- concurrency;
- dependency management;
- retries;
- timeouts;
- state transfer;
- role/task assignment;
- cancellation;
- aggregation/merge;
- error routing;
- approval gates.

## Why Composite is expensive

The cost is not only LLM tokens. Complexity appears in the control system itself:

- more agent executions;
- more state transitions;
- more handoffs;
- more contexts;
- more integration points;
- more failure modes;
- more infrastructure;
- more observability requirements;
- more recovery logic.

## Main danger: premature complexity

A one-line README fix does not need a router, manager, research team, critic team, and human governance chain.

Composite is valuable when the **problem structure** requires composition. It is harmful when complexity is added because a multi-agent system looks sophisticated.

The governing principle derived in the discussion was:

> add only the coordination/control complexity that the work actually requires.

---

# 7. Cross-cutting vocabulary established in the discussion

## Agent

An executing reasoning/working role. It may be backed by the same model as another agent or by a different model/system.

## Subagent

An agent execution spawned/delegated by another agent or orchestration layer. “Subagent” describes relationship/placement, not necessarily a weaker model.

## Thread

A distinct work/conversation line with its own context. Product terminology varies, but it is useful to distinguish a thread from the agent that executes inside it.

## Manager

A role that decomposes, delegates, coordinates, and integrates work.

## Router

A role/mechanism that selects which path or handling strategy an input should enter.

## Orchestrator

The control layer that sequences and coordinates multiple executions, dependencies, state transitions, retries, merges, and gates.

## Merge

The process of reconciling multiple outputs into a usable next state. Merge is a substantive reasoning/control problem, not merely concatenating text.

## Concurrency / Parallelism

Multiple work executions overlap in time. Exact implementation may be truly parallel or concurrent depending on infrastructure; the operational distinction is that one independent task need not wait for another.

## Independence

A property of error pathways, evidence, assumptions, sources, models, or evaluation methods—not simply a count of agents.

## Verification

A process that tries to establish whether a claim/artefact satisfies a relevant criterion. A second agent’s agreement alone is not sufficient to claim independent verification.

---

# 8. The strongest conceptual conclusions from the conversation

## 8.1 The image mixes abstraction levels

The six boxes should not be interpreted as:

> pick exactly one of six architectures.

A better model is:

- work dependency structure;
- concurrency structure;
- authority/delegation structure;
- verification/challenge structure;
- human governance structure;
- composition/routing structure.

These dimensions can coexist.

## 8.2 More agents are not automatically better

Additional agents can increase:

- coverage;
- speed;
- specialization;
- alternative reasoning paths;

but also increase:

- cost;
- coordination burden;
- state inconsistency;
- correlated errors;
- merge ambiguity;
- false confidence.

## 8.3 Multi-agent organization does not create epistemic independence by itself

Three agents using the same assumptions can be three copies of the same error.

Independence must be designed at the level of:

- evidence;
- framing;
- method;
- model/tool path;
- acceptance criterion;
- test/oracle.

## 8.4 Manager quality is a first-order system problem

Hierarchy adds leverage but also gives the coordinating layer the power to create systemic failure through bad decomposition, delegation, integration, or recursion.

## 8.5 Human involvement must have a reason

Human review is not inherently proof, and automation is not inherently autonomy. Human gates are strongest when they correspond to actual judgement/authority/risk boundaries.

## 8.6 Composite should be minimal, not maximal

The goal is not to use all available patterns. The goal is to form the least complex working structure that still handles the dependencies, uncertainty, authority, verification, and risk of the job.

---

# 9. What this conversation did not evaluate

The original image also contains a lower “2026 Production Stack” section describing **MCP** as a tool-connectivity layer and **A2A** as an agent-coordination layer. The conversation had not yet substantively examined those boxes when this note was requested.

Therefore this file intentionally does **not** invent a conclusion about MCP, A2A, their relationship, their maturity, or whether that lower section of the image is accurate.

Exact current product limits for Codex or Claude Code—nesting depth, concurrency, feature flags, CLI behavior, model defaults—are implementation details that can change. The product-specific observations above are retained because they were explicitly discussed and researched in this conversation, but they should not be treated as durable architecture constraints.

---

# 10. Overall judgement on the image

The image is useful as a **conversation starter** because it exposes several recurring forms of agent coordination and their cost/quality trade-offs.

Its main conceptual weakness is that it presents heterogeneous dimensions as six comparable design alternatives. Read literally, that can encourage the wrong question: “Which one of these six architectures should I choose?”

A stronger question is:

> What dependency, concurrency, authority, review, human-governance, and routing relationships does this particular work require, and what is the minimum composition that satisfies them?

That reframing preserves what is useful in the image while avoiding the implication that a multi-agent system is defined by selecting one box.