# U12-C — Python selection, provider and tool-loop sources

**2026-09-20 · Q02c / MR28.** Fixed ECC [8321021c54d670126ce3b2969d5deb880b4b0c2a](https://github.com/affaan-m/ECC/tree/8321021c54d670126ce3b2969d5deb880b4b0c2a). [Note27](../notes/27-PYTHON-PROVIDER-SELECTION-AND-TOOL-ROUNDTRIPS.md), [round](../ROUND-U12-C.md), [E09](u12-c-python-flow-probe/README.md), [STATE](../STATE.md). Source findings, inspected upstream tests, versioned SDK contracts and one isolated experiment are distinct evidence classes. No installed provider/SDK, network/model call or whole-ECC efficacy result.

## Finite package coverage

The recursive src/llm tree90a2fad1ca232d5c049d8b9f9a4ee9ffe8aca17c has20 Python files. Its first returned JSON content was complete with truncated:false; a duplicated structuredContent rendering was display-truncated. All20 named Python bodies below were read through EOF via connected GitHub. FULL refers to the file, not every dependency or the whole repository. The two original modules used by E09 were additionally copied locally and hash-matched before execution; no repository checkout was acquired.

| Handle | Path / Git blob at ECC pin | Actual scope |
|---|---|---|
| C-PACKAGE | pyproject.toml /2e924826f6e60defe47ad9eb35accafd23bf6806 | FULL; llm-abstraction0.1.0, Python>=3.11, wheel src/llm, llm-select entry, openai>=1.30.0 and anthropic>=0.120.2 declarations |
| C-EXPORT | src/llm/__init__.py /f1bacc1feb7c515e13c96eb3c2364f7b9345991b | FULL; public imports, provider SDK dependency through imports, gui selector |
| C-MAIN | src/llm/__main__.py /370f7ed35bb4c3653d137c1c8fdd5df22688b486 | FULL; invokes selector only |
| C-CLI-INIT | src/llm/cli/__init__.py /e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 | FULL, empty |
| C-SELECTOR | src/llm/cli/selector.py /3430bb2d560d856b0dd60fa37c509765b80dde11 | FULL; static menus, validation/cancel, cwd .llm.env, local process environment and printed exports, no generate |
| C-CORE-INIT | src/llm/core/__init__.py /a6fe6cc1626227632323fe609225fd0b7306e6f0 | FULL, module docstring |
| C-INTERFACE | src/llm/core/interface.py /ea1d91147cf120e8da87775caa6307afc60f6a58 | FULL; abstract synchronous generate/config/model methods, default capability methods, error classes |
| C-TYPES | src/llm/core/types.py /84eb7cf8ca0bc024a282ff03661cf7247b244efa | FULL; input/output, message/tool serializers, usage/stop/error representation. Original body executed in E09 |
| C-PROMPT-INIT | src/llm/prompt/__init__.py /7302eb19ecf585c1050d04dcb664e6e79707e7b3 | FULL; exports helpers and template registry |
| C-PROMPT | src/llm/prompt/builder.py /57ffd84ef964f17be9724d2012739396c02bd9c8 | FULL; optional system/tool-text composition and provider defaults; user_template/tool_format stored but not effective transformations in build |
| C-TEMPLATES | src/llm/prompt/templates/__init__.py /bfd6897e711105e6743d0d0def69639cd7546867 | FULL; validated in-memory named-template registry; not an automatic provider invocation |
| C-PROVIDERS | src/llm/providers/__init__.py /d3536a29fef580fa807316762dad4a13cd287850 | FULL; six exported provider variants and resolver |
| C-RESOLVER | src/llm/providers/resolver.py /4156e4fb713fd3390a1dd880cd424c26e6a4ff1d | FULL; explicit/env/saved/default provider precedence; selected class; registration; saved LLM_MODEL not applied |
| C-OPENAI | src/llm/providers/openai.py /0bf84a33d4cbf1f7e7a307b3a07d7523441e59fd | FULL; constructor, actual chat request/response, JSON arguments, usage and string-based error classification |
| C-CLAUDE | src/llm/providers/claude.py /20b45aedcb8c15c6819157f4ace44deae9bd9933 | FULL; system/cache/model branch, tool definition and response translation, generic non-system history projection |
| C-OLLAMA | src/llm/providers/ollama.py /2f83338d0fad3fbca96e7d414b8968b7d4e71614 | FULL; urllib request/timeout/nonstream payload; tools/max_tokens omitted; response parsing/config truthiness |
| C-ASTRAFLOW | src/llm/providers/astraflow.py /1f7cceab9e6c675e2163c58f4be5413e66d0a282 | FULL; global/CN endpoint and environment variants, OpenAI-compatible request, tolerant argument parser |
| C-ATLAS | src/llm/providers/atlas.py /b266bb61441109c4a53fbb1549b34c056c61e35c | FULL; provider-specific defaults, minimum512 request tokens, tolerant parser and errors |
| C-CONSTANT | src/llm/providers/constants.py /092cac3ac292c73134b964bf803c2b4b8d5f8d8b | FULL; empty/filtered response diagnostic constant |
| C-TOOLS-INIT | src/llm/tools/__init__.py /1c59d750802762d17440d488a249b1fe54de0080 | FULL; exports ReActAgent/ToolExecutor/ToolRegistry |
| C-EXECUTOR | src/llm/tools/executor.py /e4a859b344338a479b43b42f0ac3c8f5b3b9444e | FULL; registered callable invocation, exception result, ReAct loop/history/last-iteration behavior. Original body executed in E09 |

Pinned [selector](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/src/llm/cli/selector.py), [resolver](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/src/llm/providers/resolver.py), [types](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/src/llm/core/types.py), [executor](https://github.com/affaan-m/ECC/blob/8321021c54d670126ce3b2969d5deb880b4b0c2a/src/llm/tools/executor.py). The path/blob table identifies the rest unambiguously at the same commit.

## Upstream tests inspected, NOT RUN

| Handle | Path / blob | Actual scope |
|---|---|---|
| T-RESOLVER | tests/test_resolver.py /c2a65787f866faad517fe9b0737ff219c31891aa | FULL; provider class and precedence. A saved LLM_MODEL appears in a fixture but model application is not asserted |
| T-EXECUTOR | tests/test_executor.py /749c4d1b43d1eeb4c9fa7250c55179e29fc6ad79 | FULL; direct registry/executor success, unknown tool and batch. No ReActAgent test in this pinned file; not a whole-suite absence assertion |
| T-PROVIDER | tests/test_provider_tools.py /4c9c76f92836b68e17a6763672d50cfca7ede1a2 | FULL1–240 through EOF; fake SDK clients record first-call params and return SimpleNamespace. Tool-definition serialization, empty-choice/message and missing-usage checks. Not real API or second-turn history acceptance |

## Primary external contracts

**X-OPENAI-CLIENT:** openai/openai-python tagv1.30.0 resolved through connected GitHub to e2214ce7243c027c4e04e39b5a11986d5e361e37. `src/openai/_client.py` blob8f3060c6f6f9ced6a51817fd7f8e10db47f6f705, SELECTED1–154: complete synchronous OpenAI constructor signature/body. It does not accept _enforce_credentials and has no catch-all constructor kwargs. This version satisfies ECC's declared openai>=1.30.0 bound but not that constructor call. Source-derived compatibility counterexample, NOT an installed-version experiment or claim that all current SDKs fail.

**X-OPENAI-TOOL:** same commit, `src/openai/types/chat/chat_completion_message_tool_call_param.py` blobf616c363d01cac5f419766bd4610f3e9a5c5e9fb, FULL. Required type=function and JSON-string function.arguments. [Exact type](https://github.com/openai/openai-python/blob/e2214ce7243c027c4e04e39b5a11986d5e361e37/src/openai/types/chat/chat_completion_message_tool_call_param.py), [constructor](https://github.com/openai/openai-python/blob/e2214ce7243c027c4e04e39b5a11986d5e361e37/src/openai/_client.py).

**W-OPENAI:** [official function-calling guide](https://developers.openai.com/api/docs/guides/function-calling), viewed2026-09-20; selected Chat Completions tool-call and follow-up examples, NOT Responses API shapes. Supports the versioned input-contract distinction, not observed remote rejection.

**W-CLAUDE:** [official tool-call handling](https://platform.claude.com/docs/en/agents-and-tools/tool-use/handle-tool-calls), viewed2026-09-20; selected assistant tool_use/user tool_result blocks, tool_use_id and error representation. Unlike the generic role=tool projection, these are native content blocks. This dated API contract is not a specific installed Anthropic SDK/remote response witness.

Unfamiliar Astraflow/UModelVerse names were searched; no load-bearing current service availability, model catalogue or commercial claim is inferred. Names/endpoints in this study are the pinned adapter's declarations. Actual provider model availability, limits, pricing and credentials were not checked or used.

## Joined findings and evidence classes

C-SELECTOR writes both provider/model, but C-RESOLVER reads only provider; actual adapters select input.model or their own defaults/environment. Normal explicit model input works as a source path. A saved OpenAI gpt-4o selection does not automatically change its gpt-4o-mini default. No live model request was made.

C-TYPES and C-EXECUTOR produce generic assistant/tool history; C-OPENAI/Astraflow/Atlas pass it through. X-OPENAI-TOOL exposes the missing type and dictionary-vs-string boundary; C-CLAUDE has a different missing native history conversion despite genuine definition/response conversion. E09 observes actual local serialization and uses a narrow shape checker, not a simulated API verdict.

C-EXECUTOR runs registered callables without comparing the advertised tool list or validating schema, then projects errors/results. Last-iteration effects and propagation after a later provider error are source orderings directly discriminated by E09's in-memory cases. Registered-not-advertised, schema mismatch and fresh retry are controlled reachability observations, not real-model frequency or production exploits. Normal round-trip, unknown-name rejection and exception-as-result remain positive controls.

Provider parameters differ: Atlas may raise requested max_tokens to512; Ollama does not send tools/max_tokens and forces nonstream; other adapters also do not forward stream or metadata. Optional prompt/template APIs are not automatically invoked by generate/ReAct. Static model/config booleans are not remote readiness. Local exception string classification does not prove SDK-wide retry behavior; SDK internal retries remain separate.

## E09 identity and preservation

[PRECHECK](u12-c-python-flow-probe/PRECHECK.md) commit97ab9354 precedes the single recorded run. [README](u12-c-python-flow-probe/README.md) contains all eight observations, source hashes, exact environment/command and lossless [encoded bundle](u12-c-python-flow-probe/E09.zip.b64). Probe SHA2560808157f0756bf039f0bfcd7d783dbcbdf13b4017ccd780e74a6b0c6f9cd0744; raw result SHA256d7900dddbca2e682644b3693a22e8b9a447d494509f8fe94f8217451934be285. All recorded predictions matched; no criterion changed or target run discarded. E09 intentionally bypasses package imports and real adapters, so it does not validate SDK compatibility, credentials or wire acceptance.

The encoded first upload was mistyped, not a failed target execution; correction and remote/local Git blob equality02441842546271f10050f0f5d4257235b972f113 are documented. No earlier experiment or source note was overwritten. E06 remains excluded; E08, E04/E07 and both E05 histories remain separate.

## Discovery, limits and next work

Default-branch searches for ReActAgent, LLM_MODEL and get_provider returned indexed934195f955cf0da847d59fcd6f68856bce112d8b. The indexed executor test has material not present in the pinned file; it was NOT silently imported as old test coverage. Search hits only located files, and misses are not whole-repository absence proof. All substantive ECC bodies above were fetched at8321021. No global caller/integration absence follows from search.

The bounded Python-family criterion is answered; actual SDK/installed packages, remote multi-turn acceptance, model/credential/catalog fidelity, effective budgets/streaming, async behavior, durable/idempotent recovery and accepted task outcomes remain open. The U07-A family map was refreshed in full (blobd43b08b69740f800803a9465954269b2c97d0606) to select the next existing obligation: U13-A release qualification, exact candidate/artifact and approval/report consumption. Its scripts/release-approval-gate.js, scripts/preview-pack-smoke.js and actual .github workflow callers are discovery entries, not newly read or executed sources. No release/adoption is authorized by this research.
