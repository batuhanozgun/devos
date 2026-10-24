# U01-B / Note07 — The selected agent and its environment-to-context mechanism

**Date:** 2026-09-12. **Object:** `stanford-iris-lab/meta-harness-tbench2-artifact@57fefdb2ff84af3fd81b69d67814acbe69bd0743`, not the optimizer or a current deployed agent. Full `agent.py` and manifest were read. Shared cache/prompt blobs were resolved by identity. [SOURCES](../evidence/2026-09-12-u01b-terminalbench/SOURCES.md) records exact coverage; [CHECKS](../evidence/2026-09-12-u01b-terminalbench/CHECKS.md) records limited excerpt/shell execution.

## 1. What is inherited and what is added

The agent is a Terminus-KIRA-style native-tool implementation extending Harbor's Terminus2. It retains tool schemas, terminal execution, image reading, model-call retries, context-overflow recovery, completion confirmation, usage accounting and trajectory construction. Those are substantial inherited mechanisms; the search did not invent them merely because the final artifact contains them. [A01; T07]

The highlighted addition is `_gather_env_snapshot`, called before the custom loop begins. It collects a compact description of a fixed set of environment properties and appends that text to the initial prompt. This relocates some exploratory work from model-chosen early actions into a deterministic pre-step. The README's claimed turn/performance benefit remains an author result, not our fresh measurement. [A01; earlier C02 README]

This is task-environment preparation around a fixed solver, not online weight training or a deployed agent freely rewriting itself. The optimizer that discovered it is a different program. Its acceptance for a real SOUL workload would be another decision.

## 2. The operating path

In the current reference, `AgentHarness.run` stores the original task then delegates to the parent. The pinned Harbor 0.18.0 parent resets per-run state, constructs Chat/context, reads terminal output, optionally adds MCP/skill information, formats the initial prompt, invokes the overridable agent loop and gathers metrics in `finally`. This confirms a bounded inherited caller path, not full lifecycle or host verification. [T07; H03 selected lines]

The selected artifact's loop first calls the snapshot helper, then checks session liveness and optional proactive summarization before making a model interaction. The snapshot can be appended successfully yet later be replaced by a proactive-summary prompt. Successful construction, attempted insertion and actual first-model-request consumption must therefore remain separate claims. No full agent call or wire request was captured here. [A01]

The main model interaction uses LiteLLM directly with native tools, while Chat is used for history and cumulative metrics. The tool schema permits terminal command batches, completion and image reading. Commands go through a tmux session; image reads use environment execution to collect base64 and a separate multimodal call. Prompt caching marks recent messages for supporting models; this does not establish actual cache hits or semantic memory. [A01; T09]

## 3. Exactly what the snapshot observes

A single compound command emits section markers and collects `pwd`, `ls -la /app/`, selected language/compiler versions, selected package-manager versions and memory information. The inner exec has a 15-second timeout and the async wrapper 20 seconds. Exceptions/no session/empty output return no snapshot, allowing the usual agent path to continue. [A01]

The resulting object is a selected textual view, not a full environment inventory. The working directory may differ from `/app`; a version string does not establish usable permissions, network access, capacity or compatibility for the task. The list is fixed rather than derived from the task's actual prerequisites. This may be a useful low-cost prior in the benchmark environment but requires applicability testing elsewhere.

Listing truncation retains the first 20 rows once the section exceeds 25 rows and labels the remainder as more files. B06 verified the string behavior with 30 synthetic rows. Real `ls -la` rows can include metadata and dot entries, so this is not independently measured file cardinality. Section extraction also treats marker-shaped lines as structure; robustness against unusual names/output is open. [A01; B06]

## 4. Availability fallback is not fidelity preservation

The comment describes sections as guarded, but the actual command chains them with `&&` and a final `|| true`. Failure of the `/app` listing can stop language/package/memory inspection. B08 executed that command with a deliberately failing local `ls` and observed only PWD/LS markers, followed by a zero compound exit status. [A01; B08]

The parser does not check return code and labels an empty LS section as an empty directory. B05 directly tested nonzero-return partial output; B08 linked shell-produced partial output to the same parser. Both produced an affirmative empty-directory representation rather than an unknown/unavailable listing. The demonstrated distinction is not whether an exception crashes the agent, but whether error-tolerant data construction preserves the epistemic status of what was observed.

Normal synthetic sections, no-session fallback and exception fallback behaved as expected in B06. The mechanism is not simply broken. Its positive fail-soft behavior and partial-observation interpretation need to be evaluated separately. Historical prevalence and net task utility remain unknown.

## 5. Action and completion observations

Terminal execution sends command keystrokes plus echo markers, polls pane text and filters marker-bearing lines before limiting output. This provides an early-completion heuristic, not a verified semantic effect receipt for arbitrary interactive programs. No real tmux path was exercised. [A01; T07]

Chat history receives `executed` tool placeholders before action dispatch. The actual observation is provided separately after commands/image work. A structured tool message, an actual execution effect and a verifier's reward cannot be treated as equivalent solely because all are represented as text. The same source also provides a two-step completion prompt—useful reconsideration, not independent assurance. [A01]

Context-overflow handling can summarize prior work or fall back to the original task plus a limited terminal view; it trades continuity against selective loss. Full summarizer internals, correct handoff under interruption and downstream quality were not validated. Prior HERMES/context studies are potential comparison sources, not silently imported evidence here.

## 6. Artifact/release identity and compatibility boundary

The selected artifact's dependency ranges differ from the later reference pins. Its custom loop includes `logging_dir`, calls `_setup_episode_logging`, and records episode markers; the current reference baseline uses a different signature/logging arrangement. It also has time-saved accumulation and different name/version metadata. [A01–A02; T02, T07]

The selected artifact is therefore not demonstrated to equal the present reference plus one additive function. The two were read directly, but a complete historical diff and exact benchmark environment were not recovered. The old README's performance is not a compatibility test against every new version admitted by an open dependency range. Conversely, a possible modern mismatch would not disprove the historical result.

Harbor's pinned parent calls the overridable loop using named `initial_prompt`, `chat` and `original_instruction` arguments. That narrow observation prevents assuming a positional argument shift here; it does not prove all old helper methods exist in the complete dependency chain. No full wheel installation or selected-agent runtime was attempted. [H03]

## 7. Research implications, not adoption

The strongest mechanism candidate is **proactive, bounded environment-to-context preparation**. It can reduce redundant model exploration when the collected view is relevant, timely, correctly interpreted and cheaper than task-specific discovery. It can also inject irrelevant/stale/misleading priors or consume budget before the real need is known. The appropriate test compares task-conditioned, fixed, no-bootstrap and simpler alternatives, with missing-information and changed-environment cases.

SOUL's intended system-formation problem is broader: which prerequisites need discovery, which observations warrant capability claims, which information belongs in the current context, and which effects require explicit authority? This artifact is a useful pressure case, not the answer to that design problem.

Before load-bearing reuse: recover exact compatible dependencies and actual task environment; distinguish raw observation, parsed view and model-visible request; test fallback/partial-output semantics; measure net success, cost and regressions; preserve accepted-change authority. This study did not create such an implementation or grant.
