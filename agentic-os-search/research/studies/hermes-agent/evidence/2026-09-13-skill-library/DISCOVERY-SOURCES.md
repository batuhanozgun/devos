# U15-B — Kaynak ve okuma kapsamı

**2026-09-13 / SOURCE ONLY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [B](ARCHIVE-LEDGER-AND-DISCOVERY.md), [A defteri](SYNC-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md). Native 1-based satırlar; FULL READ yerel byte/AST/dependency closure değildir.

| ID | Primary path / Git blob | Okunan kapsam |
|---|---|---|
| S04-B | `agent/skill_utils.py` / `fe0b06c69f87d391898a7d6ab98d63a58bd9c7dc` | A1–455'e ek456–690,691–930(EOF). A+B artık FULL TEXT. Project trust/quarantine, lookup normalization, owner paths, actual sorted iterator/org gates. |
| S06 | `tools/skill_usage.py` / `48d7edc9d3cc636a5c8762304b870fd0a6d8e20d` | FULL READ1–220,221–440,441–670,671–780(EOF). Eligibility/opt-in, usage locks, counters, suppression, archive/restore and discovery calls. Prior note03 açıklamasıyla karşı okuma, yeni runtime değil. |
| S07 | `tools/skill_ledger.py` / `cbe041ddff3629bdccd6c18aeb69a3abb4d76d52` | FULL READ1–240,241–480(EOF). Capture/blob/append/actor, snapshot completeness fill, rollback guard/write/report. |
| S08 | `tools/skills_tool.py` / `ed7b318df13336abf34acd0ed4b6896f85d8e854` | FULL READ1–220,221–445,446–685,686–760(EOF). Search dirs/cache/list, unique-load collision, readiness/preprocess caller, actual handler/use. Full helper closure değil. |
| S09 | `hermes_cli/curator.py` / `9111e379701fe279655f57e2dc5d09c6b37cbd3c` | SELECTED1–230,231–465,466–650. Actual adopt/archive/restore/purge, single-entry/whole-tree rollback consumer, report/exit. Remaining parser wiring tail okunmadı. |
| S10 | `agent/curator_backup.py` / `3078f6d03b95ee2dc42574afb50bb327e5e0564d` | FULL READ1–220,221–460(EOF). Snapshot/retention/protected target, staging/extract/unstage, excluded subtrees, actual cron skill-link restore caller. |
| S11 | `agent/prompt_builder.py` / `2f3608249845d3f19e78adc60778444d79275eb2` | SELECTED1–200;500–735 navigation request truncation (steering/platform prose, no load-bearing finding);1000–1210,1211–1435. Skills cache/manifest/snapshot, index assembly and visibility. Whole-file FULL değil; old system prompt prose control talimatımız değildir. |
| S12 | `agent/system_prompt.py` / `9bd52f03fc7568990f2bf157dc1301f9c81adbbb` | SELECTED1–235,236–465,600–820(EOF). Actual agent-home/skills builder and full-prompt tier assembly/invalidation;466–599 helpers unread. Gerçek provider request yok. |
| S13 | `tools/skills_tool_dedup.py` / `ef78292741a483c7c7ff274839e4c8e9e5bc2dee` | FULL READ1–230(EOF). Stat fingerprint, task-specific stub, setup-needed exception, reset helper. Compression host callers not revalidated. |
| S14 | `tests/tools/test_skill_ledger.py` / `408b0c7b678e6ef1bb492392651b9a93931fc9e3` | SELECTED1–215. Fixture temp home, actor and patch/delete rollback assertions, external-path/missing-blob refusal. NOT RUN; archive case/tail not completed. |

Primary kök: https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/ . Dosya yolları import/call ve `rollback_entry`, `build_skills_system_prompt` symbol search ile keşfedildi. Mutable default-branch `b6b53c69...` yalnız navigation; her hüküm listedeki exact pin'e bağlandı. A'nın W01 current docs görünümü implementation revalidation değildir.

A39bb5929 actual main/ref/scope ve A1–44/45–EOF, source ledger ve STATE tam geri okunduktan sonra B başladı. Dönen A blobs: research3fe01f852a60e428c99cd4fafb28d73f8a29e3d9; sources6419ba669a1141229b0eff868dbe91cd7c6be4cc; STATE06f85aeb99881ea163eb9d6b168869d6637b759f. A evidence değiştirilmedi.

**Yeni behavioral execution yok.** HERMES modülü, sync/restore/curator, actual filesystem test, SQL/DB, model/provider, user credential/home, network runtime veya upstream suite çalıştırılmadı. RESULT/PASS/raw test archive yok. Source metinleri GitHub connector üzerinden okunur, tam yerel byte kimliği ayrıca hesaplanmadı. Test source assertion'ı başarılı koşu değildir; publication readback independent product validation değildir.

Açık alt sınırlar: curator full LLM/maintenance dispatch önceki source kapsamıyla kalır; skill write hook'larının bütün çağıranları, remote Hub/org sync_client/server approval, actual scanner verdict/config, preprocessing/readiness helper'ları, cache invalidation/first request, chrono jobs DB saving ve OS locks/faults tamamlanmış sayılmaz. Old U04–U14 diagnostic/source evidence untouched; B onların bağımsız tekrarı değildir.
