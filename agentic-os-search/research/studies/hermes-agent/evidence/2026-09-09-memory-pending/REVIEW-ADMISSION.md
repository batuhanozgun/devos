# Review admission — source-only continuation

**Date:** 2026-09-09. **Status:** SELECTED PINNED SOURCE OBSERVATIONS; not executed. Sources M2-R01–R04 in [SOURCES](SOURCES.md).

## Source-backed connections

`background_review._fork_init_kwargs` passes the parent's enabled/disabled toolsets to the fork constructor. `build_cache_parity_fork` calls AIAgent with those arguments and then rebinds built-in memory and write origin; it disables persistence on the fork. The same-model path also copies the cached system prompt. These mechanisms explain why tool-schema parity and dispatch policy were treated separately; they do not prove all live schemas are byte-identical.

`run_agent.AIAgent.__init__` forwards to `agent.agent_init.init_agent`. The inspected `_load_tools` function in agent_init assigns `agent.tools = model_tools.get_tool_definitions(...)` and derives `valid_tool_names` from those definitions. This is a concrete source location for the name set, beyond the earlier synthetic wide-set fixture. The whole initialization sequence, dynamic registrations and all subsequent alterations are not closed by reading this function.

`_review_tool_whitelist` independently derives memory/skill names, adds read_file/search_files and configured extras. `_run_review_fork` installs that whitelist before run_conversation, and clears it in finally. The inspected body does not intersect `valid_tool_names` with this set. Thus the initial name-set and narrower review-policy mechanisms remain distinct at these callsites. This is not a global absence proof: other callsites and actual runtime must still be checked.

`_run_review_in_thread` also installs `_bg_review_auto_deny` for dangerous-command approval. It is a real additional control in source, not a reason to label all policy checks ineffective. Whether a given operation reaches that control is a separate reachability question. The prior pool/helper handles approval callbacks but not arbitrary thread-local state; that earlier evidence retains its original scope.

The executor's tool_call bridge has a separate scope check built from agent toolsets. This further prevents collapsing tool visibility, initial name validation, bridge scope, whitelist, guardrails and approval into a single boolean security verdict.

## Still not established

The full E01/E02 original-file AST comparison, actual complete-module review/AIAgent construction, middleware/plugin dependency closure, all worker/transport paths, and harmless-handler end-to-end observation remain open. No new worker run was performed. In particular, this note does not promote U01-D2's manually selected function experiment into whole-product authorization-bypass evidence.

The new memory/pending experiment is a different family continuation; its complete modules do not supply the missing worker dependency closure. The two results must remain separately retrievable.
