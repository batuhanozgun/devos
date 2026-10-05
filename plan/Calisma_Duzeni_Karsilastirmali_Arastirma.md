# DevOS working order: comparative research

*Translation note: English translation of the Turkish original at devos commit 3de3a17 (W-C00-06, plan C00 step 0). Since the fidelity review passed, this English text is binding (plan 0.6 item 1).*

**Date:** 29 September 2026 · **Question:** Does the "team in the office, checker apart" working order (A1 version 2) rest on a sound foundation, or is it a made-up structure? Compared with known approaches, where does it agree, where does it diverge, and what needs to be corrected?

**Method:** Anthropic's own publications and product documents, independent practitioner and research sources, and the studies in the `agentic-os-search` library (multi-agent-patterns, gastown, beads, hermes-agent, ecc, harness-engineering-and-evolution) were examined. Priority was given to sources being current and primary. Secondary sources were marked as such.

---

## 1. Short verdict

The core of the working order is not made up. It is an application of the pattern that is the most verified today, in the industry and at Anthropic: **one coordinator + narrowly scoped workers + an evaluator separate from production + persistent state kept outside the session + structured hand-over between sessions.** The same pattern appears, independently, in Anthropic's harness for long-running application development, in Claude Code Projects, in Cognition's multi-agent setups that "actually work", and in Gas Town.

But the research showed that the working order **needs to be corrected in six places** (Section 4). The most important of these: parallel subagents should only read, research and review; a product should always have a single writer.

---

## 2. Approaches compared

| Approach | Essence | Relation to the DevOS working order |
|---|---|---|
| **Anthropic, "Building effective agents"** (December 2024) | Five patterns: chaining, routing, parallelisation, coordinator-worker, producer-evaluator. "Start simple; add complexity only if it demonstrably improves the result." | The working session is coordinator-worker; the audit environment is producer-evaluator. **Warning:** 18 roles and many record families must be justified against the "start simple" principle |
| **Anthropic, multi-agent research system** (June 2025) | A main agent + parallel subagents do markedly better than a single agent at broad research, but spend roughly 15 times as many tokens. Subagents should be given a detailed task description (purpose, output format, sources, limits); results should be written to a persistent place so that there is no "game of telephone" degradation | Directly suitable for the research role (DR16). **Missing:** a standard for subagent task descriptions |
| **Anthropic, harness for long-running agents** (November 2025) | An initialiser agent sets up the environment and the work list; the following sessions each advance one piece at a time, leave things in a clean state, and hand over through a progress file and commits | Matches DevOS's session loop and closing discipline one to one |
| **Anthropic, harness design in long-running application development** (March 2026) | Planner + producer + separate evaluator. Resetting the context and continuing with a structured hand-over document can give better results than relying on compaction within a single session. **Principle:** "Every part of the harness carries an assumption about something the model cannot do on its own; these assumptions must be tested, because they may be wrong and they go stale as the model improves." With a new model, some parts were removed and the harness was simplified | The producer-evaluator split is consistent. **Two lessons:** (1) rely not on a very long single session but on chunked work + structured hand-over; (2) the assumption each mechanism rests on should be written down and regularly tested with "is it still needed?". This is the frame blindness mechanism itself |
| **Claude Code dynamic workflows** (May 2026) | Claude writes a management script for the task, runs a large number of parallel subagents, and verifies each finding independently; progress is recorded, and interrupted work resumes where it left off. Consumes markedly more usage than a normal session | A candidate in-session tool for large scanning jobs (library audit, broad research). Whether it works in a cloud session should be tested in C01 |
| **Claude Code Projects** (September 2026) | Coordinator conversation + worker sessions + shared project memory | The productised form of the same pattern. Because it uses a single environment, it does not itself provide separation of authority; in DevOS, separation of authority is already provided by keys held outside the environment |
| **Cognition, "Don't Build Multi-Agents"** (2025) and its **update** (April 2026) | Agents writing in parallel make implicit decisions unaware of one another, and the product becomes inconsistent. The update: the patterns that work are setups **in which several agents contribute intelligence but writing is done through a single channel**; "a single main loop carries the state; subagents are narrowly scoped and stateless" | **The most important source of corrections.** In DevOS, parallel subagents should not write; every product should have a single writer |
| **MAST: why multi-agent systems fail** (NeurIPS 2025) | 14 failure types over 7 frameworks and thousands of traces, in three classes: specification problems (~42%), inter-agent misalignment (~37%), lack of verification (~21%). The gain of multi-agent systems over a single agent is often small; most failures come from design, not from the model | DevOS's mechanisms should answer these three classes (Section 3). Roles should earn their existence with evidence |
| **Loop engineering** (named in June 2026) | The four parts of a loop: trigger, goal, verifier, stopping rules. The one that produces and the one that checks are separate; every loop has an upper limit, a budget and "no progress" detection. **In open-ended work the bottleneck is not the model but the verifier** | Trigger (routine), state (database) and verifier (audit) exist. **Missing:** a per-loop budget, upper limit and no-progress detection. The verifier bottleneck is the same thing as the plan's open problem U-2 |
| **Graph engineering** (mid-2026) | Building the workflow as an explicit state machine: nodes, transitions, shared state, checkpoints, pauses for human approval. "The coordinator plans, assigns and merges; it does not do every job itself." "Only work items independent of one another should run in parallel" | DevOS is a hybrid working order: audit and authority transitions are a deterministic state machine in the database; the thinking work inside the nodes is left to the agent. This distinction should be kept deliberately |
| **Gas Town** (library study) | Actor identity and the running session have separate lifetimes; the work record and management are separate layers; merging is done by a separate queue role (Refinery); watcher roles (Witness, Deacon) check liveness; dispatching work depends on environment capacity | Confirms the "role ≠ session" decision. Merging in a single queue and capacity-aware dispatch suit DevOS |
| **Hermes Agent** (library study) | A scheduled job is a chain: definition → specific run → attempt → rebuilding of the context → execution → delivery. The success of each link does not prove the others; "trigger count ≠ agent run ≠ delivered report" | Confirms the separation of records for routine runs (intent, session and result kept separate) |
| **ECC** (library study) | Not a single controller; a chosen combination of method, installation, execution and record parts. Some transitions are code, some are instructions the agent interprets | Installing ECC is not setting up a working system. The selective comparison in C00 is the right approach. The parts for two independent reviewers, for the producer-evaluator loop and for the loop design audit are candidates |
| **The DevOS attempt in the old `soul` repository** (August 2026) | Roles: designer/producer, researcher, verifier, counter-reviewer, integrator, human owner. "The verifier does not repair in the same action"; verification is bound to the exact target and version; a session has a single primary responsibility | Consistent. The "verifier does not repair" rule should be written explicitly into the audit environment |

---

## 3. MAST failure classes and their counterparts in DevOS

| Class | Typical failure | Counterpart in DevOS | Still open |
|---|---|---|---|
| **Specification problems** | The task or the role specified wrongly; not following the role; repeating steps; not knowing the termination condition | Role contracts, the purpose chain and the stopping rule in the work record, the hidden exam | A per-loop upper limit and no-progress detection are missing |
| **Inter-agent misalignment** | Loss of context; not passing information on; ignoring the other agent's contribution; mismatch between reasoning and action; drifting from the task | Contribution and use records, the shared state database, the purpose audit | The single-writer rule for the implicit decisions of parallel writers (Cognition) is missing |
| **Lack of verification** | Ending early; incomplete or wrong verification | A separate audit environment, negative and positive controls, the hidden exam | No strong verifier for open-ended work (U-2) |

And one class that MAST does not measure: **silent failure.** Situations in which no check turns red, yet the system keeps its owner working in the wrong direction for weeks. Against this, regular sample audits and purpose audits are needed.

---

## 4. Corrections that came out of the research

1. **Single-writer rule.** In the working session, parallel subagents only read, research, analyse and review. Only one writer writes to a product (code, document, design) at a time. Products that are truly independent of one another may be written in parallel, but the shared decisions must first have been written down explicitly. Merging is done in a single queue. (Cognition 2025–2026; graph engineering; Gas Town Refinery)
2. **Not a long session, but chunked work and structured hand-over.** A working session splits the work into pieces; each piece passes to a subagent with a clean context, or to the next session, with a structured hand-over record. The context compaction of a long session is not relied on. (Anthropic, March 2026 and November 2025)
3. **Standard for subagent task descriptions.** Every subagent task carries: the purpose and the decision it is tied to, the expected output format, the sources and tools to be used, the limits (what it will not do), the effort budget, and the place where the result is to be written. (Anthropic, June 2025)
4. **Loop controls.** Every work loop has an upper limit, a budget and "no progress" detection; when triggered, the work stops and is recorded. (Loop engineering)
5. **Mechanism assumption inventory.** Every DevOS mechanism writes down which thing it compensates for that the model cannot do on its own. These assumptions are tested regularly and whenever the model changes; a mechanism that has become unnecessary is removed. This is part of the mechanism against frame blindness. (Anthropic, March 2026)
6. **Failure classification and silent failure audit.** Every event is also labelled according to the MAST classes; in addition, regular samples are taken from work that looks green and are audited.

In addition: **dynamic workflows** will be tried in C01 for large scanning jobs; the **"the verifier does not repair in the same action"** rule will be added to the audit environment.

---

## 5. Where the sources contradict one another, and DevOS's stance

- **Anthropic** says that multi-agent work clearly pays off in broad research; **Cognition** says that parallel writing is fragile. The two do not contradict each other; they speak of different kinds of work: reading and research parallelise, writing does not. DevOS adopts this distinction as a rule.
- **Loop engineering** puts the single loop first, **graph engineering** the explicit flow diagram. DevOS separates the two into layers: authority and audit transitions are an explicit state machine (the database); the thinking work is an agent loop.

---

## 6. Still open

- **Verifier bottleneck:** In open-ended work such as research and design there is no strong, automatic verifier. All the sources see this as the hardest problem. In DevOS, independent audit, hidden exams, the second model family and Batu's assessment in the fields where he is an expert narrow this gap but do not close it (U-2).
- **Number of roles and records:** 18 roles and many record families must each be justified against the "start simple" principle. Roles are activated as the need arises; the initial scope of the record families will be questioned separately in the independent counter-design in C00.
