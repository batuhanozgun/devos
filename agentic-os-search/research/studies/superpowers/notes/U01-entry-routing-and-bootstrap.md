# U01 — Entry Routing and Bootstrap: First Bounded Investigation

Date: 2026-09-17. Target: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest version 6.3.0.

Status: U01-A source/local-script investigation complete within the scope below; **U01 as a whole remains PARTIAL**. Brainstorming findings are an early U02 input, not a completed intent-to-implementation investigation.

Source IDs resolve through [SOURCE-LEDGER.md](../SOURCE-LEDGER.md). Method: [METHOD.md](../METHOD.md).

## 1. Question and inspected surface

What happens between making Superpowers available to a host and an agent actually following its development procedures? The first slice inspects the bootstrap contract, shell-hook registration/emission, Codex manifest contrast, first-party hook test assertions, and the actual brainstorming entry rules.

Fully read target files: README (same conversation, pinned blob identity confirmed), using-superpowers SKILL, hooks/hooks.json, hooks/session-start, Codex plugin manifest, the hook test script and brainstorming SKILL. Root and skill-directory trees were read non-recursively. The porting guide was read only through line 310; remaining adapters, wrapper and tool mappings are open.

## 2. F01 — Superpowers selects a procedure; it is not one universal linear pipeline

**OBSERVATION — S10.** Brainstorming distinguishes three paths:

| Path | Intended output and artifact contract |
|---|---|
| Spike | Answer a feasibility question; present the proposed probe and obtain approval; report findings; any constructed code remains throwaway. No design/spec file. |
| Bounded | Modify an existing, readable flow in the repository; clarify, present a short design in chat, obtain approval, then implement. No written spec or implementation-plan document. |
| Architectural | New project/subsystem or material structural/interface change; alternatives and sectioned design; written spec; inline self-review; user review; transition to writing-plans. |

The contract treats approval as invariant while scaling ceremony. Newly discovered complexity upgrades the path; it does not allow a mid-task downgrade. Familiarity with an application type is explicitly not enough to make a new project bounded.

**INFERENCE.** The earlier README-level sketch, “design → written plan → implementation,” is a useful introductory simplification but not an accurate universal execution model. Artifact obligations depend on request classification and can change when complexity is discovered.

**BOUNDARY.** These are instructions. This round did not observe a live agent correctly classifying tasks, waiting for approval, or honoring the throwaway-code boundary. Supporting planning/worktree and companion files remain open for U02/U07.

## 3. F02 — Mandatory skill language has scope and precedence

**OBSERVATION — S04.** The bootstrap tells the main agent to invoke relevant/requested skills before answering or acting, prioritises process skills, and provides a table of rationalisations against skipping them. But it also explicitly exempts a subagent dispatched for a specific task from this bootstrap skill and gives user instructions precedence over skill instructions.

**INFERENCE.** “Mandatory workflow” here is a scoped procedural contract, not an unconditional claim that every actor always executes the same gate. Task-scoped subagents and user overrides belong in the actual system model.

**OPEN.** How the controller supplies task context, applicable rules and review obligations to an exempt subagent requires the execution/delegation sources. The exemption alone neither establishes nor disproves safe delegation.

## 4. F03 — Shared skill content does not imply shared delivery machinery

**OBSERVATION — S05/S06.** The Claude-oriented configuration registers a synchronous Bash wrapper for SessionStart, with matcher `startup|clear|compact`. The selected hook reads using-superpowers, wraps it in context text, escapes it for JSON and chooses one output shape:

- Cursor environment present: top-level `additional_context`.
- Claude environment present without Copilot flag: nested `hookSpecificOutput.additionalContext` with SessionStart event name.
- Otherwise: top-level `additionalContext`.

The code gives Cursor precedence when environment markers coexist. These are script branches, not observations that each host actually invokes or consumes the result.

**OBSERVATION — S07/S08.** The Codex manifest declares `skills: ./skills/` and `hooks: {}`. The inspected porting-guide section explains this as suppression of hook auto-discovery in favor of native skill surfacing. Thus the shell-hook explanation must not be copied wholesale onto Codex.

**TARGET CLAIM — S08.** The guide describes shared skill bodies, host-specific tool mapping and bootstrap delivery as distinct integration responsibilities. It also requires real-session acceptance evidence for a supported port. This round has not supplied that acceptance evidence.

**INFERENCE.** The relevant chain is:

```text
installed source → discovery/delivery → model-visible instructions
→ applicable skill selection → host-native action → observed outcome
```

Evidence at an early link does not establish later links. The guide's general full-bootstrap language and its native-discovery clarification must be resolved against actual selected host sources before a cross-host model closes. The remaining guide and implementations are not silently assumed to agree.

## 5. F04 — Local transport behavior was checked at an exact source identity

The GitHub-fetched `hooks/session-start` was materialised locally. Its Git blob hash was recomputed before execution:

`93a6bc2c6b7269c704378cb6a61fce6aea7ff631`, 2,274 bytes — exact match.

Runner: [U01-hook-probes.py](../evidence/U01-hook-probes.py). Actual output: [U01-hook-probes-results.json](../evidence/U01-hook-probes-results.json).

Reproduction, after separately obtaining the pinned source file:

```bash
python3 evidence/U01-hook-probes.py /path/to/pinned/hooks/session-start
```

The runner rejects a different source blob and writes only temporary fixtures. The synthetic skill contains a unique marker, quote, backslash, newline, tab, carriage return and Unicode text. No plugin is installed, and no host/model or network API is invoked.

| Probe | Actual result | What it supports |
|---|---|---|
| Claude-shaped environment | PASS | Correct unique nested envelope and decoded fixture content. |
| Cursor + Claude markers | PASS | Cursor branch precedence, no duplicate context field, fixture fidelity. |
| Copilot + Claude markers | PASS | Top-level SDK-style envelope, fixture fidelity. |
| No recognised host marker | PASS | Default SDK-style envelope, fixture fidelity. |
| Deliberately wrong event name supplied to validator | Rejected as expected | Narrow negative control: the validator distinguishes a wrong event from correct output. |

Environment: Linux, Python 3.13.5, GNU Bash 5.2.37. Bash command substitution strips terminal newlines; fidelity is checked against the fixture without trailing newlines, not claimed as a byte-exact transport of the whole input file.

**Verification boundary:** this is actual execution of one pinned script in synthetic conditions. It is not a host startup test, a Windows wrapper test, an upstream-suite run, an independent reviewer result, or an evaluation of skill obedience/development quality. The negative control checks only its specified error class.

## 6. F05 — A successful output envelope is weaker than usable bootstrap readiness

Two additional challenges were defined before executing the runner, after inspecting the source. They are **source-informed exploratory challenges**, not a preregistered independent experiment.

The study-defined health criterion was: a missing or empty usable bootstrap must not be represented by a successful script exit. This is our diagnostic criterion, not a claim that upstream explicitly promises fail-closed behavior.

| Condition | Exit | JSON/nonempty envelope | Actual bootstrap | Health criterion |
|---|---:|---|---|---|
| Missing skill file | 0 | Valid and nonempty | Absent; error marker included | FAIL |
| Empty skill file | 0 | Valid and nonempty | Absent; no error marker | FAIL |

**OBSERVATION — S06 + local evidence.** The read operation catches `cat` failure with an explanatory echo, then builds a wrapper regardless. The script ends with exit 0. An empty file also leaves a nonempty wrapper. Thus valid JSON and a nonempty context field are compatible with no useful bootstrap body.

**CAUSAL INTERPRETATION.** At the observed layer, the read failure is converted into content rather than propagated as failure; the outer wrapper supplies apparent nonemptiness. The script does not use bootstrap validity to decide its final exit status. This explains the local result without attributing it to a model or host.

**BOUNDARY.** This is not a claim that Superpowers generally fails, that a normal installation produces missing files, or that a real host has no other checks. Error-tolerant startup may be an intentional availability choice. Its operational consequences and possible mitigation belong to a later investigation; no fix or upstream issue was created.

## 7. F06 — The inspected first-party test oracle has a narrower scope than behavior assurance

**OBSERVATION — S09.** The hook test source checks shell registration, output shape, event name, nonempty context, wrapper dispatch and omission of obsolete warning strings. Its current invocation cases pass an empty expected-content argument. The file contains no explicit missing/empty-bootstrap case.

This is a claim about this fully inspected file, not about every upstream test. The upstream test suite was **not executed**.

**INFERENCE.** The inspected assertions are useful transport/registration checks but do not establish correct skill selection, semantic bootstrap health or downstream model compliance. Another test may cover these elsewhere; the repository-wide evaluation surface is still open.

The study's failed health challenges are therefore retained as separate evidence rather than hidden inside an “all tests passed” summary.

## 8. Provisional relevance, not adoption

The initial value for later SOUL / Development OS thinking is the separation of four questions:

1. Is the right procedure available and presented?
2. Is it selected for the actual request and actor?
3. Is its rule enforced, requested, or checked after the action?
4. Does the resulting behavior achieve the goal under the real environment?

Superpowers supplies concrete sources for examining those questions. This round does not establish a final system architecture, a superiority comparison, or a reason to replace current agent-control rules.

## 9. Open questions and continuation

| ID | Unresolved question | Next evidence |
|---|---|---|
| Q01 | What does each materially distinct adapter actually load, and when? | Remaining porting guide; wrapper; selected native/in-process/instructions-file implementations and tests. |
| Q02 | How do discovery, description visibility and full-body invocation differ, particularly on the native-discovery path? | Tool references, manifest/adapter source, separately qualified host evidence when necessary. |
| Q03 | What survives or is re-injected after compaction/restart? | Actual adapter event handling; matcher text alone is insufficient. |
| Q04 | What behavioral obligations reach an exempt task-scoped subagent? | SDD/execution/parallel dispatch skills and implementer/reviewer templates. |
| Q05 | How do classifications and approvals bind to spec/plan/worktree artifacts and later changes? | Planning, worktree and execution sources. |
| Q06 | Are semantic bootstrap health and model behavior evaluated elsewhere? | Remaining tests/evals/CI; separately pin any external evaluation repository. |
| Q07 | What is the optional visual companion's runtime, authority and network surface? | Companion guide and implementation; not inferred from README telemetry prose. |
| Q08 | Which source regions would a prompt-only account omit? | Progressive subtree inventory and reverse-catalogue closure audit. |

Next: U01-B, then U02. Preserve the completed local slice, the full brainstorming read and all unexecuted boundaries. Do not restart from the introductory README summary.
