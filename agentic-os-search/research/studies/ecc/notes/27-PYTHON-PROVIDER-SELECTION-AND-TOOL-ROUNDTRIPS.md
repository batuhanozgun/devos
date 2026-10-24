# Note27 — Python provider selection and tool round trips

**2026-09-20 · U12-C / Q02c · bounded source answer plus E09.** ECC8321021c54d670126ce3b2969d5deb880b4b0c2a remains the target. [Exact source ledger](../evidence/U12-C-SOURCES.md), [one local experiment](../evidence/u12-c-python-flow-probe/README.md), [MR28](../ROUND-U12-C.md), [STATE](../STATE.md). All20 Python files in src/llm were read. Only original types/executor modules were executed with a scripted provider; no installed SDK/API, real model, credential or production system was exercised.

## 1. Native purpose and actual composition

The separate Python package declares itself llm-abstraction0.1.0 and exposes llm-select. It supplies common input/output/message/tool types, provider adapters, optional prompt/template helpers, a callable registry/executor and a ReAct-style loop. These are executable mechanisms, not merely procedure documents. Their co-location with Rust ECC2, Node tools and host plugins does not establish one integrated runtime.

The actual entry paths differ. llm-select, python -m llm and the exported gui helper invoke an interactive selector. That selector writes provider/model preferences and prints shell exports; it never calls generate. Library callers can construct a provider and LLMInput and invoke generate directly. ReActAgent is a separate public helper that repeatedly invokes a supplied provider and executes returned registered tools. Thus the useful path is caller-owned composition, not a selector that automatically starts a managed agent.

The package imports its provider set eagerly, including the Anthropic/OpenAI SDK-backed adapters. A local-model choice does not by itself avoid those import prerequisites. The wheel declaration identifies src/llm; build metadata is not a performed wheel/import test. Source handles: C-PACKAGE/EXPORT/MAIN/SELECTOR/PROVIDERS/EXECUTOR.

## 2. A saved provider/model pair is only partially consumed

The selector's default menu lists three providers and fixed model names. It writes both LLM_PROVIDER and LLM_MODEL into .llm.env in the current directory. With persist=True it also modifies this Python process's environment; printed export commands are a separate shell instruction, not proof that another process adopted the values. No endpoint, credentials, live catalogue or model readiness is checked by printing Ready to use.

Provider resolution has a concrete precedence: explicit argument, nonempty LLM_PROVIDER environment value, saved .llm.env provider, then claude. Environment/saved provider names are normalized; invalid types raise rather than silently becoming a different provider. This is a useful selection mechanism. The registry supports six provider variants even though the default selector menu exposes only three.

However, the saved model is not forwarded by get_provider. Each generate method uses LLMInput.model or its own default. Provider-specific environment names can affect some defaults; LLM_MODEL is not the consumed variable in these bodies.

A bounded example is therefore: save openai/gpt-4o, call get_provider(), then generate an input whose model is None. Provided construction and the call can proceed, the adapter builds a request for gpt-4o-mini, not the saved gpt-4o. The provider selection is honored while the other half of the pair is not automatically applied. Supplying input.model explicitly is the normal counterexample. No request was sent in this study; this is the actual source selection path, not a measured wrong-model incident.

T-RESOLVER includes a saved file with LLM_MODEL, but asserts the selected provider class, not the subsequent request model. That test is useful for precedence and does not close model propagation. Sources: C-SELECTOR/RESOLVER and all provider bodies, T-RESOLVER.

## 3. Common fields do not promise equivalent provider behavior

The adapters perform real provider requests and normalize parts of the responses, but not every common field has an effective downstream implementation.

| Path | Actual request/result behavior | Important boundary |
|---|---|---|
| OpenAI | Synchronous chat completions; common messages, explicit/default model, temperature, optional max_tokens and native tool definitions; response text/tool calls/usage/finish reason | Ignores input.stream and metadata; malformed nonempty tool-argument JSON raises during decoding |
| Claude | Extracts system messages into a separate cached text block; sends native tool definitions; model-name branch sets adaptive thinking; decodes text/tool_use and usage | Non-system conversation history still uses the generic serializer; translating definitions and responses does not translate follow-up history |
| Ollama | urllib POST to configured /api/chat, timeout60, stream=False; model and messages, temperature option when nondefault | Does not send input.tools or max_tokens; configuration validation checks only nonempty base URL, not a running service |
| Astraflow global/CN | Separate environment/endpoint defaults around OpenAI-compatible chat requests; optional tools/limits | Malformed tool arguments become a raw wrapper; nonobject JSON becomes a value wrapper. Preserving a response is not validating it against the tool schema |
| Atlas | Similar chat path with provider-specific defaults and a512-token minimum | A requested max_tokens below512 is raised to512. The adapter's reasoning-budget rationale does not make the user's smaller upper bound effective |

These are pinned implementation choices, not statements about the latest services or all their capabilities. For example, max_tokens=64 is normalized upward by the Atlas adapter; no real token consumption or cost was measured. Likewise Ollama not sending tools here does not prove that every Ollama version lacks tool support.

The common stream field is not implemented as streaming by these generate bodies, and ReAct's reconstructed input drops stream/metadata. LLMInput.to_dict can merge metadata into a representation, but adapters manually build their actual parameters; that helper is not automatically the network request. Static ModelInfo records and inherited supports_tools/supports_vision methods are also different surfaces: they are not queried as admission gates by this loop and are not a discovered remote catalogue.

PromptBuilder and the named-template registry are callable, optional helpers. System text/tool descriptions and input validation have real implementations. But the provider and ReAct bodies do not automatically call them; user_template/tool_format fields in the builder are not additional effective transformations merely because they are stored. A caller can use those helpers explicitly. Sources: C-TYPES/INTERFACE/PROMPT/TEMPLATES/EXECUTOR and provider rows.

## 4. One-shot tool definitions can be right while the next request is wrong

The most consequential cross-provider boundary is the return journey after a tool runs.

ReActAgent appends an assistant Message containing ToolCall objects, followed by role=tool Messages containing result text and call IDs. Message.to_dict converts an assistant call into id plus function.name and function.arguments, but omits type:function and leaves arguments as a Python dictionary.

The OpenAI-compatible adapters pass that serialization directly as request messages. The versioned OpenAI v1.30.0 input type requires type:function and JSON-string arguments; the current official Chat Completions guide uses the same representation. E09 case8 observes the real local serializer's output and compares these two fields with a narrow checker. The original shape fails that checker; an explicitly corrected fixture passes. It is not a real SDK/API rejection test, and no exact HTTP failure was observed.

Claude's counterpart is a different conversion, not just JSON encoding. The documented Messages API places tool_use blocks in assistant content and tool_result blocks with tool_use_id in user content. ECC's Claude adapter correctly translates tool definitions and parses tool_use responses, but then sends the generic assistant.tool_calls and role=tool history unchanged. The next-call representation therefore does not satisfy that documented native history contract. This is source plus dated primary documentation, not a live Anthropic test.

T-PROVIDER verifies first-request tool definitions with fake SDK clients; those clients accept arbitrary keyword dictionaries. It does not submit the ReAct follow-up to a real provider or check its native content structure. This explains how a locally useful definition test can leave the return path untested. Provider output normalization, request history encoding and actual remote acceptance are three distinct responsibilities. Sources: C-TYPES/EXECUTOR/OPENAI/CLAUDE/ASTRAFLOW/ATLAS, X-OPENAI-TOOL, W-OPENAI/W-CLAUDE, T-PROVIDER, E09. The positive one-shot translation and local tool round trip remain real; the finding is not that all generation is impossible.

## 5. What authorizes a local tool call in this helper?

ToolRegistry binds a name to a callable and stores its definition. ToolExecutor looks up the name and invokes func(**arguments). It does not compare the call against the tools advertised in that particular LLMInput and does not validate arguments against the stored JSON schema. It does reject an unknown name without executing it, and catches callable exceptions into ToolResult.is_error=True.

E09 separates these controls. A scripted provider named a registered tool while input.tools was empty: the callable appended7. An unknown-name control produced an error without an effect. A schema-declared integer passed as a string reached a Python callable that accepted it, whereas a missing required Python argument produced an invocation error. These observations show where the actual acceptance checks occur; they do not show that a real model routinely requests unadvertised tools or that a deployed system has an exploitable authorization boundary. A caller that treats registry membership as its entire trusted capability set may deliberately accept this contract. Request-specific authority or schema admission would be additional guarantees, not inferred from the advertised schema.

The executor is synchronous. Even though ReAct.run is async, it calls synchronous provider.generate and ordinary callables. No await-aware tool scheduling, provider concurrency, sandbox or general runtime authorization layer is established by the async function label. These stronger properties were not tested.

## 6. The loop can stop after producing an effect without returning its result

The local normal path works: case2 executes an advertised registered tool, appends its result/ID to the next provider input, and returns the scripted final response. This positive control matters; the experiment is not built only from failing cases.

Two continuation boundaries then become visible:

**Iteration exhaustion.** Every iteration first calls the provider and can execute all returned tools. The limit is checked by ending the for-loop, not by preventing effects on the last iteration. In case5, max_iterations=1 allowed record to append7, then returned only Max iterations reached with stop_reason=max_iterations. The returned object carried neither the tool result, history nor accumulated usage. This does not mean the effect was undone. The helper's local history is not a returned durable continuation checkpoint.

**A later provider failure.** In case6, a tool effect occurred and the second scripted provider call raised. The exception propagated while the in-memory effect remained. Running again from the original input repeated the effect. That demonstrates fresh retry rather than exactly-once continuation in these conditions. It does not measure any SDK's internal HTTP retry behavior or prove production duplicate transactions; the experiment's only effects were list appends.

A no-tool response is also returned without evaluating its stop_reason as task acceptance. Case1 returns a scripted length stop reason, not only clean stop. Conversely, tool errors are not wholly suppressed: case7 retains diagnostic text and the call ID in history. What is lost in that conversion is the structural ToolResult.is_error field. The distinction is structural error state versus textual error information, not information versus total silence.

Thus provider-loop count, number of tool effects, useful task completion and recoverable execution state are not one measure. The code offers a simple composable loop, not the complete persistent control guarantees previously studied in other ECC families. Sources: C-EXECUTOR/TYPES, E09 cases1–7.

## 7. Configuration, dependency and error checks have narrower meanings

Cloud validate_config methods mainly test a key's truthiness; Ollama tests a base URL. The actual generate/ReAct paths do not automatically invoke these checks, and a true result would not prove successful authentication, reachability or model availability. Static list_models likewise does not call a service.

There is a concrete declared-version mismatch. pyproject allows openai>=1.30.0, while the OpenAI-backed constructors pass _enforce_credentials=False. The complete OpenAI constructor signature at official tagv1.30.0, resolved to e2214ce7243c027c4e04e39b5a11986d5e361e37, has no such parameter or catch-all kwargs. With that allowed SDK version and otherwise successful import, construction cannot accept this call. This is a source-level counterexample to the declared lower bound, not a claim that all newer SDK versions fail or that an installation was attempted. Constructor errors are outside the adapters' generate try/except blocks.

Generation errors are classified mainly by searching exception text for401/authentication,429/rate_limit or context plus length. Ollama also maps text containing connection to AuthenticationError. An error category is therefore the adapter's classification, not proof of a specific remote cause. Unmatched errors propagate and recognized wrappers preserve their cause. No provider-switch fallback, durable retry state or rollback is implemented in these finite bodies. SDK-internal retries remain a separate dependency behavior; this study makes no zero-total-retries claim.

Sources: C-PACKAGE/INTERFACE/RESOLVER and all providers, X-OPENAI-CLIENT. Names/model limits in static source were not upgraded to current product facts.

## 8. Evidence, counterexamples and completion

E09 is one preregistered local run containing eight controlled cases, using exact original types/executor bytes and a scripted provider. All comparisons matched the predeclared predictions. It is neither the upstream suite nor an installed-package test; bypassing package initialization deliberately leaves SDK import/construction outside the experiment. Positive normal flow, unknown-name rejection, Python invocation errors and a corrected shape fixture accompany the countercases. No result was discarded or criterion changed. A mistaken encoded upload was fixed by exact Git blob equality; it did not alter or rerun the experiment.

The three upstream test files were inspected, not run. Indexed search returned a newer executor test file with additional content; the fixed-pin file was fetched instead. Newer indexed tests were not credited to the old snapshot. Full finite subtree reading supports local caller/field findings; search does not prove there are no external consumers anywhere in ECC or in user integrations.

U12-C's original source criterion is met: package/selector, explicit library consumer, provider variants, actual request/response, tool execution/history, error and continuation behavior are connected. Stronger package/SDK/API compatibility, live multi-turn acceptance, current model catalogue, effective budgets/streaming, async/cancellation, schema/authority isolation, durable/idempotent recovery and accepted task outcomes remain open. The caller may supply additional controls; none are assumed absent from all possible applications.

Reusable distinctions: saved pair versus consumed selection; common field versus implemented option; definition translation versus whole-conversation translation; registered capability versus request-specific authority; schema declaration versus executable admission; reached iteration limit versus effect-free stop; error result versus error-preserving history; retry from original input versus continuing a known attempt; declared dependency range versus compatible constructor. These are candidate research contributions, not adopted SOUL/Development OS architecture or Foundation taxonomy.

The refreshed U07-A family map supports next U13-A: release qualification and candidate/artifact/approval binding through the actual gate, packaging helpers and workflow consumers. This follows an existing unclosed responsibility rather than turning provider investigation into a live benchmarking campaign. Release/scanner/observability, other native variants, synthesis/CORE and final omission checks still prevent whole-study closure.
