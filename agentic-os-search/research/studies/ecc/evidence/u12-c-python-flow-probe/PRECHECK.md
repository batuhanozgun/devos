# E09 — Python loop and message boundary precheck

**2026-09-20 · preregistration BEFORE target execution.** Parent inquiry U12-C/MR28. This is a deterministic local source-level experiment, not an installed SDK/host, network/model, authorization penetration or performance test.

## Object and source identity

Use unchanged ECC8321021 source bytes for src/llm/core/types.py (Git blob84eb7cf8ca0bc024a282ff03661cf7247b244efa) and src/llm/tools/executor.py (e4a859b344338a479b43b42f0ac3c8f5b3b9444e). Check Git blob hashes before loading. Import these modules with minimal package containers rather than llm/__init__.py, so SDK/provider imports and credentials are not involved. This intentionally does NOT test normal package importability or any provider adapter.

The real ReActAgent and ToolExecutor bodies run against a scripted synchronous provider returning controlled LLMOutput objects. Tool effects are only appends to an in-memory list. Capture deep-copied request snapshots at call time, returned values and exceptions. No filesystem tool, shell, network, installation, user-home mutation or real model call.

## Predetermined discriminators

1. No-tool response returns the scripted content/stop reason without executing a tool.
2. A known advertised tool runs and its result/id is visible in the second scripted provider input; the second no-tool response completes the loop. This is the useful positive control.
3. A registered tool omitted from input.tools is nevertheless callable if the scripted provider names it; compare with an unknown/unregistered name, which must not execute and should become an error result. This measures executor binding, NOT the likelihood of a real model emitting the call or a production authorization bypass.
4. A JSON-schema integer argument supplied as a string to a callable accepting that value reaches the callable; compare a missing required Python argument, which should produce an error result. Distinguish schema admission from Python invocation failure.
5. With max_iterations=1 and a tool-call response, the tool effect occurs but the returned synthetic max_iterations output contains neither that result nor an execution transcript. Compare scenario2's second-call consumption.
6. If the next scripted provider call raises, prior in-memory effects remain and the exception propagates; no automatic retry/rollback is inferred. Re-running from the original input can repeat the effect; capture actual counts.
7. A tool exception sets ToolResult.is_error=True directly; its history projection retains diagnostic text/id but has no structural is_error field. Do not claim all error information disappears.
8. Serialize the actual second-turn assistant/tool messages. Compare the OpenAI tool-call shape with the documented required type:function and JSON-string arguments using an explicit narrow checker, plus a corrected positive fixture. This is a serializer/contract check, NOT a real SDK/API rejection test. Anthropic's user/tool_result and assistant/tool_use contract is assessed separately from source/docs, not simulated as an API.

## Criteria and limits

Every case records raw inputs, outputs/effects and the relevant narrow boolean comparisons. An unexpected outcome falsifies the corresponding source prediction and must be retained; do not alter the criterion to make it pass. Both positive and negative/control observations must survive publication. A single script run with multiple cases is ONE experiment run, not independent repetitions or success-rate evidence.

Environment/version, script/source hashes, actual command, stdout/stderr/exit status and all results will be captured. If source hash recovery fails, do not run a modified reconstruction as original ECC. Preparing files/hash checks is administrative; target behavior begins only at the recorded probe command. No prior E06/E08/E07/E05 evidence changes. No experiment result is claimed in this precheck.
