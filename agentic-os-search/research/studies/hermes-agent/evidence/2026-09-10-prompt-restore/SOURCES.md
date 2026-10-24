# U01-M4 — source and execution boundaries

Date: 2026-09-10. Research checkpoint: `batuhanozgun/agentic-os-search@a14c8152a918a3379b4a0d6d67af9f7aece2f70e`. Primary upstream: `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.

## New pinned source observations

| ID | Source / parent Git blob | Read and use |
|---|---|---|
| M4-S01 | `agent/conversation_loop.py`, `2e88c103275d756cfe8cb0e092b309f5f4406cb2` | Selected source ranges 500–780 and 755–900. Complete `_bot_chat_prompt_stale`, `_persist_system_prompt`, `_restore_or_build_system_prompt`, `_stored_prompt_matches_runtime` bodies manually transcribed to `selected/conversation_prompt.py` and executed. Parent whole-file bytes NOT materialized or verified locally. |
| M4-S02 | `agent/system_prompt.py`, `9bd52f03fc7568990f2bf157dc1301f9c81adbbb` | Selected source request 430–750, recovered through EOF. `_memory_parts`, `build_system_prompt_parts`, `build_system_prompt`, `invalidate_system_prompt`, `reconstruct_static_prefix` inspected. Only `_memory_parts` and `invalidate_system_prompt` transcribed to `selected/memory_prompt.py` and executed. Full parent NOT executed/materialized. Initial displayed tail truncation was recovered from the already stored tool response. |
| M4-S03 | Same conversation_loop parent | Stored response selectively reopened at `run_conversation` and its phase sequence. Source calls `build_turn_context(... restore_or_build_system_prompt=_restore_or_build_system_prompt ...)`, transfers context into `_LoopState`, then dispatches `prepare_iteration`, `assemble_api_request`, preflight and retry phases. An opt-in codex_app_server path delegates before the ordinary loop. This is SOURCE TRACE, not execution; imported phase bodies and actual request contents remain open. |

Pinned links: [conversation loop](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/conversation_loop.py), [system prompt](https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/agent/system_prompt.py).

The selection files contain complete chosen definitions but are NOT upstream modules. Manual transcription was reviewed against the returned source. Their fixed SHA-256 values bind the local experiment only; they do not establish byte fidelity to the full parent or independent source recovery. The experiment's explicit scope must survive later reuse.

## Exact reused full modules and setup

All paths below are under canonical sibling `../2026-09-09-memory-pending/`. The probe defaults to that sibling and accepts `--m2-root`. It verifies the reused setup script before import, then that script verifies each upstream module before import. Its old N01–N12 cases are NOT invoked.

| Reused artifact | Git blob |
|---|---|
| `probe.py` — setup/helpers only | `874b1f5c7314464b5ea011bc4e4adfaf124a1fb0` |
| `upstream/memory_tool_store.py` | `457594444311af31c837dcdd74cd1c55f2b47b3c` |
| `upstream/memory_tool.py` | `8028ffd88a91b1625e1f1cebe500c37c6e6842a7` |
| `upstream/write_approval_commands.py` | `150b72dfd17696ab7a64f97057b7405128f5b352` |
| `upstream/write_approval.py` | `f1e99b46e934595c002c2bc659143fcbc1f9fe8d` |
| `upstream/skill_provenance.py` | `3df9cf143045644310fa7d27a65666c8c23caf95` |
| `upstream/LICENSE` | `75410e73319c72cd3e991a501c5455eb78f38375` |

The archived M2 ZIP was locally recovered; this is not a fresh upstream retrieval. Actual modules perform real temporary-file memory/pending operations and Linux file locking. Configuration, home resolver, scanner, registry/approval callback and atomic-write helper remain the existing M2 substitutes. Sharing that fixture preserves common-mode risks; this is not independent corroboration.

## New synthetic surroundings

Synthetic `DB` is an in-memory session-row object, NOT SQLite. The agent is a namespace and its prompt builder deliberately renders only the built-in memory block plus runtime identity. Runtime cwd, capability responses, lifecycle/credits/tool-prefix functions and plugin/static-prefix restoration observers are substitutes. No external memory manager is supplied. Network creation is blocked during the cases. No credential, account, provider, whole application, actual CLI/gateway, compression, turn_context or request assembly is run.

The actual `_memory_parts` selection consumes the real MemoryStore frozen formatter. The selected restore function chooses between the synthetic row and reduced builder. V04's invalidate→restore and build→persist sequences are harness compositions, not evidence of actual compression order. V08's capability decision is controlled by a fake probe, not a test of real Bot Chat detection.

## Access and coverage

This turn obtained the selected loop and system-prompt sources. `system_prompt.py` first returned 429/fail-fast:network, then succeeded. `turn_context.py` 640–875 returned the same 429 twice; `turn_request_assembly.py` returned it once. A later system_prompt 715–820 request also returned 429. Repeated upstream requests were then stopped. The already returned system-prompt tail and conversation-loop callsite were recovered through stored-response reads without another origin fetch.

Direct local source materialization failed with DNS; web opening the pinned source returned cache miss. These access failures do not establish absent upstream mechanisms. The old response URI used for a prior source was unreadable. No alternative credential/permission or endpoint was used to evade a restriction. Current upstream release/HEAD is not revalidated.

The final ordinary-loop request assembly, gateway cache lifetime, compression/keep-prompt caller composition and alternative runtimes remain unexecuted and incompletely inspected. Historical M3 source trace supports the cached-prompt branch but is not a new M4 execution result. Source selection, local identity, limited execution and product correctness are four different claims.
