# UI01–UI13 — Pinned caller and policy source ledger

**Date:** 2026-09-10. **Research base:** `91af4415c22e05b80484b935383ceeb04a3c5b7b`.
**Upstream:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.
Canonical source URL for each row: `https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/<path>`. Line ranges refer to this pin, not default-branch search results. Source instructions/prompts remain research objects, never assistant control.

| ID | Path | Git blob | This-turn depth |
|---|---|---|---|
| UI01 | hermes_cli/cli_commands_mixin.py | 7061fdcc564214ac3236d0e6d54c19e9c2b9702e | SELECTED: 160–380, 1000–1220, 1600–1910, 2000–2260. Load-bearing memory/skills methods in 1800–1910. 2800–3040 returned empty (navigation beyond EOF), not proof of absent handlers. NOT EXECUTED. |
| UI02 | gateway/slash_commands.py | bc7aaabb668f3067cbe8fa03a84efd67186a2fc6 | SELECTED: 1–590, 600–975 across requests. Load-bearing setter/profile/whoami 200–340 and memory/skills/approvals 810–975; cached/resident helpers 1–200. NOT EXECUTED. |
| UI03 | gateway/run_busy.py | 57e19f825009bf3326dafe3e9a90d74a67cb9846 | SELECTED: 1–240, 430–1030. Tables/busy dispatcher 680–900; actual _check_slash_access 900–1030. NOT EXECUTED. |
| UI04 | gateway/run_inbound.py | 1208221fc56dd161d9a17da33cbfae8d010b0b87 | SELECTED: 1–1085, 1100–1310, 1440–1630, 1700–1970. Load-bearing _hm_admit_event, busy/idle command resolution, hooks, canonical dispatch and _handle_message. NOT EXECUTED; later media helpers are navigation context. |
| UI05 | gateway/run_adapters.py | 3ea22ad640118acdf8a69cd48c590e05a1e360d2 | SELECTED: 1–235, 1000–1220, 1230–1450. Wiring, secondary and primary profile wrappers, authorization-profile stamp. NOT EXECUTED. |
| UI06 | gateway/run.py | d6bfc83ec1271dbd3ee7193ca1b2af794b7844e5 | SELECTED: 1–230, 700–940, 1500–1740, 1800–1980. Load-bearing _profile_runtime_scope/_async_profile_runtime_scope in 1500–1740. Whole route resolver, authorization implementation and config-home helper not recovered in this selection. NOT EXECUTED; setup error paths not tested. |
| UI07 | hermes_constants.py | 353764b6ea5ed60418af0df246d412a949777e86 | SELECTED 1–225: context-local home get/set/reset and fallback precedence. NOT EXECUTED; full file not materialized. |
| UI08 | gateway/slash_access.py | 07204201e411f29f912bb9bba6beec0566acab9d | FULL READ + exact 5666-byte local Git blob verification + EXECUTED A01–A08. Original text transcribed from connector, then complete byte identity verified. Config/source holders synthetic. |
| UI09 | tests/gateway/test_slash_config_writes_routed_profile.py | c1893156f527d06cde26e74172f98654286f3e34 | FULL TEST SOURCE INSPECTED. NOT RUN. Fixture enters prepared profile scope, has synthetic event/no-op cache eviction; not ingress/identity or apply visibility proof. |
| UI10 | tools/write_approval.py | f1e99b46e934595c002c2bc659143fcbc1f9fe8d | Existing exact M2 archive source recovered; selected pending path/record/list/get/discard/origin re-read. NOT EXECUTED this turn. |
| UI11 | tools/memory_tool.py | 8028ffd88a91b1625e1f1cebe500c37c6e6842a7 | Existing exact M2 source, selected get_memory_dir/load_on_disk_store/apply_memory_pending used with prior full source read. NOT EXECUTED this turn. |
| UI12 | tools/memory_tool_store.py | 457594444311af31c837dcdd74cd1c55f2b47b3c | Existing exact M2 source; dynamic _path_for and live/frozen/mutate/reload source context. Prior N tests not rerun. |
| UI13 | hermes_cli/write_approval_commands.py | 150b72dfd17696ab7a64f97057b7405128f5b352 | FULL re-read from exact M2 archive; argument dispatch, supplied store, apply/discard/message order, mode callback. NOT EXECUTED this turn. |

## Discovery-only / navigation

Moving-branch GitHub code search returned ref `cfdbbb6e35010ace89fbe8243ee82fa4de143e10` for memory handlers, profile scopes, slash policy and adapter wiring. All load-bearing source observations above were reopened at primary pin. This is not current HEAD/release revalidation. Search excerpts do not establish source absence.

`gateway/run_turn.py` blob `dc6e59997cb474ea2403d505a7b94bd220de1656`, selected 1–240, 600–850, 1300–1520, was navigation/runtime context, NOT EXECUTED. These ranges do not establish post-approval prompt freshness or the full profile helper. No full-file claim for large modules.

Direct local raw retrieval encountered DNS failure; web raw opens returned cache miss and download did not materialize those large files. GitHub connector source reads continued. These are access-path observations, not upstream defects or proof of no access. This turn's GitHub create_blob for UI08 succeeded with the expected SHA; publication completion must still be verified at the final branch/commit.

## Reused evidence and new execution

M2 ZIP (58383 bytes, SHA-256 `d7d79d0d77099e1f2401174aa34837de4529093b88d1489cc5568fffcfd5fcfd`) was verified against its published identity and recovered locally. No M2 test was rerun. The existing canonical evidence remains under `../2026-09-09-memory-pending/`.

New A01–A08 use only UI08 as an actual imported upstream module. SPEC precedes execution after source inspection. Source identity, probe/spec identities, timestamp, synthetic boundaries and negative controls are in RESULT. This is source-informed exploratory evidence, not an independent investigator or real gateway test. License blob `75410e73319c72cd3e991a501c5455eb78f38375` is preserved. UI IDs do not renumber H/S/W/D/E/J/M2 inventories.
