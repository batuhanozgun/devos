# U01-M2 — source, reading and execution ledger

Research date 2026-09-09. Primary upstream pin remains `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. M2 IDs are local and do not renumber H/S/W/D/E or prior scenario IDs. Control files are not research evidence.

## Full modules used in the new run

Canonical source route: `https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/<path>`.

| ID | Path | Git blob | Reading / execution scope |
|---|---|---|---|
| M2-S01 | tools/memory_tool_store.py | 457594444311af31c837dcdd74cd1c55f2b47b3c | FULL 1–417; complete exact module executed; utils writer/threat scanner substituted. Previously D16 static, now a new bounded run. |
| M2-S02 | tools/memory_tool.py | 8028ffd88a91b1625e1f1cebe500c37c6e6842a7 | FULL 1–350; exact module executed; synthetic home/config/registry. Previously D15. |
| M2-S03 | hermes_cli/write_approval_commands.py | 150b72dfd17696ab7a64f97057b7405128f5b352 | FULL 1–160; exact shared command executed with fixture-supplied store. Not actual CLI/gateway caller. Previously H08/S05/D17. |
| M2-S04 | tools/write_approval.py | f1e99b46e934595c002c2bc659143fcbc1f9fe8d | FULL exact archived module reused from published U01B2; gate/pending exercised. Synthetic config/home/callback, real pending fixture files. Not a new upstream version. |
| M2-S05 | tools/skill_provenance.py | 3df9cf143045644310fa7d27a65666c8c23caf95 | FULL 1–26; exact ContextVar implementation executed. Record origin and current writer origin separately observed. |
| M2-S06 | LICENSE | 75410e73319c72cd3e991a501c5455eb78f38375 | FULL MIT license; original retained. Not executable. |

S01/S02/S03/S05 were captured from pinned GitHub content and all exact bytes were checked against Git blob identity before execution; S04/S06 came from the already-published archive and passed the same identity check. Local SHA-256 and sizes are in SOURCE-IDENTITY. No approximate reconstruction was admitted into the run.

## Selected source-only continuation of the review question

| ID | Path | Git blob | Actual depth / boundary |
|---|---|---|---|
| M2-R01 | agent/background_review.py | 0e8e76ae235450f3e896a86951409cf82b7cca1e | SELECTED: reads 1–400, 751–1150; 401–650 response truncated and not counted as a full interval. Load-bearing functions: _fork_init_kwargs, build_cache_parity_fork, _review_tool_whitelist, _run_review_fork, _run_review_in_thread. No execution. |
| M2-R02 | run_agent.py | 37b25fd21425f5592f00a0d351abd31743419111 | SELECTED 1–200, 205–300, 300–450. AIAgent.__init__ forwarding into agent.agent_init.init_agent. No whole-file or constructor execution. |
| M2-R03 | agent/agent_init.py | 562dfcc32866840ab9c84244595927239b790bd7 | SELECTED 1–180 and 800–1400 (overlapping tool calls). _load_tools derives valid_tool_names from tool definitions; _init_memory creates/loads store according to flags and skip_memory semantics. Entire init orchestration and later changes not closed. No execution. |
| M2-R04 | agent/tool_executor.py | 799199c10f9930da77c01da2324373614b27cb78 | SELECTED 230–410 bridge/scope and ToolCallRef; full fetch response truncated. No new execution or local full-original AST check. Previous D04/E01 scope preserved. |
| M2-R05 | hermes_cli/cli_commands_mixin.py | 7061fdcc564214ac3236d0e6d54c19e9c2b9702e | SELECTED 1–160 imports/helpers only. This did NOT reach the actual pending caller and does NOT close UI/store binding. |

GitHub default-branch searches for `valid_tool_names`, `valid_tool_names agent_init` and `handle_pending_subcommand` returned navigation at `9e0dc4319ae2d59c60f5226b5c0af58d17755bfa`. Those excerpts were not merged into pinned findings. They identify `gateway/slash_commands.py` and `hermes_cli/cli_commands_mixin.py` as next navigation candidates. Their relevant callsites must be verified at the primary pin; a search hit is not a pinned caller read or current-HEAD revalidation.

## Unfinished fidelity gate and bounded change of sequence

The intended first task was to provide full exact local originals of E01 tool_executor and E02 plugins to the existing `verify_excerpts.py`. This was NOT completed. GitHub content reads worked, but no full verified local originals of those two large files were produced. Direct raw-file download attempts failed (local DNS / web cache miss); these failures do not mean the pinned sources are unavailable, or that a future authorized capture cannot work. The existing AST verifier was NOT RUN, and no extraction-equivalence verdict was produced.

Instead of claiming that gap closed or multiplying prior selected-worker fixtures, this turn used v0.7 §4's bounded continuation option: preserve the worker question and investigate the already-authorized memory/store/pending family with new complete-source modules. This is an explicit prioritization within the existing research scope, not a successful completion of D2-FIDELITY. The actual UI identity/profile/store bindings also remain open.

## Run and oracle

RESULT records the UTC start/end, environment, harness/SPEC hashes, source identities, N01–N12 observations, file-byte/live/snapshot readback and event traces. The harmless scanner is deterministic but synthetic. The writer fault occurs before target mutation; it cannot establish every filesystem-failure disposition. The identity negative control calls the real hash-check function, rejects altered content and performs no import of that altered copy.

One exploratory run, same researcher, after code inspection; criteria were written before the run. No holdout, independent researcher, full HERMES suite, real UI or future-task quality evaluation is claimed.
