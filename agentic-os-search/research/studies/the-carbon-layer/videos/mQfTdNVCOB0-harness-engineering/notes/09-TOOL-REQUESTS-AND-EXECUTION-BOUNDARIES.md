# U02-A / Note09 — From a tool request to an effect in an environment

**Date:** 2026-09-13. **Standing:** responsibility and boundary analysis using primary specifications/documentation and preserved U01 cases. No new tool-runtime or security experiment. Video responsibilities 4–5; source identities and coverage: [SOURCES](../evidence/2026-09-13-u02a-responsibilities/SOURCES.md). [Note08](08-INSTRUCTIONS-AND-WORKING-CONTEXT.md) explains the context entering this path; [Note10](10-DURABLE-STATE-AND-QUALIFIED-CONTINUATION.md) explains continuation afterward.

## 1. Responsibility 4 — Tool Interface

### Native claim

At approximately 10:48–12:32, the author moves from reasoning to structured requests: a tool name, description and arguments connect a model to capabilities. The chapter then asks what actually happens when a valid request reaches an executor. That question is already in the video. Our contribution is to separate the statuses that the resulting exchange can support. [V01 frames 675/740; V02]

### Primary contract, not an execution guarantee

MCP's 2025-11-25 Tools specification distinguishes input schemas, optional output schemas, server-produced structured results and errors. Tool execution errors can be returned through isError even when protocol exchange succeeds. Tool annotations are untrusted unless their server is trusted. The specification assigns input/access obligations to servers and recommends client confirmation/result checks for relevant operations. These are normative responsibilities, not evidence that every installed server implements them. [D03]

MCP Architecture assigns host, client and server different responsibilities. Its definition of negotiated protocol capabilities should not be confused with authority to cause every business effect a server could technically perform. [D05]

### Mechanism and ownership

The model proposes an operation. The host and tool adapter resolve the target and arguments, determine the applicable permission boundary and dispatch to the actual executor. The executor performs or rejects work. Results must then be interpreted with enough identity and status to support the next decision.

For diagnosis, distinguish:

| Surface | What it can establish | What does not follow automatically |
|---|---|---|
| Tool discovery | A capability is advertised through this interface | It is relevant, currently usable or authorized for this target |
| Structurally valid request | Arguments meet the checked shape | The target, intent, scope and current conditions are correct |
| Dispatch/transport success | A request reached a layer that returned normally | The business operation succeeded or had no partial effects |
| Reported result | The executor supplied a particular account | Every effect occurred, the account is trustworthy, or the goal is satisfied |
| Observed postcondition | A chosen check found the expected state | Unchecked side effects are absent or the change is acceptable |

This table is our analytical decomposition, not an MCP state-machine specification. Some operations can combine several checks; others require separate observations. The needed distinction follows the risk and work semantics, not a mandate for five network round trips.

### Positive use and design tradeoff

A purpose-specific interface can make targets and admissible changes explicit. It can eliminate classes of formatting ambiguity and simplify interpretation. A broad shell interface can be more expressive for unfamiliar development work. Neither is universally superior: a narrow tool may hide relevant diagnostics or make legitimate operations impossible, while a broad one requires more reasoning about consequences and scope.

An output schema is valuable for consumers that require consistent fields. It should not be mistaken for proof of content truth. A returned object with a valid status field can still be stale, refer to another operation or reflect a partial outcome. Business checks and effect observation need their own justifications.

### Counterexample and discriminating evidence

**Analytical case T1, not executed:** a service applies an update but the response is lost. A transport timeout cannot distinguish 'nothing happened' from 'effect occurred, acknowledgment missing'. A blind retry can therefore be a new effect rather than harmless recovery. The discriminating evidence could be a durable operation receipt or target-state reconciliation; the exact mechanism depends on the service.

**Analytical case T2:** two documents share a friendly title, but the mutation targets a stable identifier for the wrong one. Argument types can all be valid. The failure lies in target binding and authorization, not JSON construction. A meaningful review must connect the proposed operation to the intended artifact and current scope.

**Prior observed source case:** the selected Meta-Harness agent inserted an executed placeholder into chat before actual action dispatch, with observations supplied later. U01-B also distinguished agent completion confirmation from the task verifier. Those are concrete examples of why protocol messages, action effects and verdicts cannot be treated as one status. Their mixed-tool path was source-read, not executed. [Note06 §E07](06-TERMINALBENCH-EVIDENCE-BOUNDARIES.md)

### Bound and transfer

The useful responsibility is not merely tool calling; it is preserving the relationship between a proposed operation, its admitted scope and its result. This does not require adopting MCP or a particular tool framework. Primary-source conformance text, implemented checks and actual enforcement remain separate evidence levels.

## 2. Responsibility 5 — Execution Environment

### Native claim and primary example

At 12:32–14:36, the video locates work in filesystems, credentials, processes, networks and isolated environments. It asks where actions run and what boundaries constrain them. It then observes that an environment alone does not provide durable progress. [V01 frames 805/845; V02]

Claude Code documents a Bash sandbox enforced through OS mechanisms for Bash and its children, while built-in file tools use a different permission surface. It separately describes inherited credentials and configurable exceptions. The exact scope is narrower than a blanket 'the entire agent is sandboxed' statement. This is a current documentation observation, not a local containment test. [D06]

The Jan 2026 Codex agent-loop article also describes locally applied sandboxing in a particular agent loop. We did not use that historical engineering account as proof of current installed behavior. Its role is a bounded second implementation perspective. [D09]

### Mechanism and ownership

A runtime provides actual executors and resources. The operator supplies accounts, dependencies, storage and network conditions. Enforcement components restrict reachable effects. The tool adapter decides which executor is used. The observing agent receives only a representation of some of this reality.

At least three dimensions must remain distinguishable:

- **Usability:** can this executor perform this work under the actual dependencies, resource limits and current state?
- **Authority:** may this actor perform this operation on this target now?
- **Containment:** which other effects can this execution path reach or be prevented from reaching?

These are analytical questions, not three proposed SOUL services. A technically usable operation can be unauthorized; an isolated operation can still be wrong for the task; a permitted operation can fail because an actual dependency is missing.

### Positive use and alternatives

A constrained environment can make exploration safer and repeated evaluations more comparable. A bounded environment inventory can reduce repetitive discovery. Narrow permissions can reduce the consequences of a wrong action. These benefits depend on the work fitting the environment: missing network access, unavailable compilers or resource limits can also prevent legitimate work.

The benchmark bootstrap studied in U01-B is a useful preparation mechanism, not a complete capability inventory. A version string shows a limited observation; it does not prove that the tool can perform the required operation with the current permissions and inputs. Task-conditioned prerequisite discovery and a fixed inexpensive snapshot are alternatives worth comparing, not mutually exclusive doctrines. [Note07](07-SELECTED-HARNESS-ENVIRONMENT-BOOTSTRAP.md)

### Counterexample and discriminating evidence

**Analytical case E1, not executed:** local shell actions are constrained, but another tool calls a remote service using separate credentials. A local sandbox conclusion does not transfer across that executor boundary. Identify the actual host/account/action path and its enforcement before treating both tools as equivalent.

**Analytical case E2:** a package manager exists but required dependencies cannot be downloaded. The environment observation was accurate; the stronger capability inference was not established. A bounded prerequisite or readiness check should target the intended operation, not merely the presence of an executable.

**Prior limited execution:** a failed listing was converted into an empty-directory assertion in U01-B's local bootstrap diagnostics. It demonstrates that resilient control flow can preserve availability while losing observation meaning. It does not establish poor performance or unsafe behavior in every real environment. [U01-B CHECKS B05/B08](../evidence/2026-09-12-u01b-terminalbench/CHECKS.md)

### Verification boundary

A sandbox label, configuration document or rule file does not establish runtime enforcement under all fallbacks. Equally, a possible gap does not prove exploitation. A load-bearing safety claim would require testing the actual executor, configured policy, permitted escape/fallback paths and protected effects. U02-A performed none of those host tests and changed no permissions.

## 3. Interface and environment form a cycle, not a clean one-way stack

An agent often learns its environment by calling tools. That produces new context, which changes the next tool request. Persisted state can point to resources no longer available. Permissions can be evaluated at the host and server as well as the operating system. MCP itself spans context exchange and capability invocation.

The video's sequence is therefore useful for explanation but should not force a strict deployment order or a single owner per chapter. The result is a map of coupled responsibilities: maintain the target and scope while crossing from text to actual execution, then preserve the meaning of the returned observation.

## 4. Reuse implications and open work

For SOUL/Development OS, these sources supply questions about tool selection, effect authority, operation identity, prerequisite discovery and observable completion. They do not authorize replacing the existing control system, adopting a vendor or declaring a production boundary safe.

A future probe should be selected by the claim at risk: wrong target, partial effect, stale capability, missing receipt or bypassed enforcement. Adding a generic validator or more logs without identifying that distinction could leave the same failure class intact. This is a research implication, not an upstream repair task.

The next note follows what must persist for a later actor to resume without silently repeating an effect or treating yesterday's authority as today's permission.
