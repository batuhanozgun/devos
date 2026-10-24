# Hermes Agent — Kaynak ve yürütme rotası

**2026-09-13 / U15 / plan v0.28.** Work authority [STATE](STATE.md). Primaryc4a5deeffa959f8ebc891e02c5bcf767aff1dd2a / manifest0.21.0. Kaynak, seçki diagnostic, ürün davranışı, sentez ve publication ayrı statülerdir.

## U15 — Skill library, yeni execution yok

[Note30](notes/30-SKILL-LIBRARY-LIFECYCLE.md)→[A SYNC-AND-LOCAL-STATE](evidence/2026-09-13-skill-library/SYNC-AND-LOCAL-STATE.md)/[SYNC-SOURCES S01–S05](evidence/2026-09-13-skill-library/SYNC-SOURCES.md)→[B ARCHIVE-LEDGER-AND-DISCOVERY](evidence/2026-09-13-skill-library/ARCHIVE-LEDGER-AND-DISCOVERY.md)/[DISCOVERY-SOURCES S04 ekleri/S06–S14](evidence/2026-09-13-skill-library/DISCOVERY-SOURCES.md). [NOT RUN](evidence/2026-09-13-skill-library/CHECKS-NOT-RUN.md), [PUBLICATION](evidence/2026-09-13-skill-library/PUBLICATION.md).

14 primary paths'ın dokuzu full text: S01 skills_sync, S02 bundled_ops, S03 optional, S04 skill_utils (A+B birleşik), S06 skill_usage, S07 skill_ledger, S08 skills_tool, S10 curator_backup, S13 dedup. Beşi selected: S05/S14 upstream test dosyaları, S09 CLI curator, S11 prompt_builder, S12 system_prompt. Exact pinned ref/blob/aralıklar iki defterde. Tam metin full local-byte/AST/dependency closure değildir.

**Yeni HERMES module import, sync/restore/curator, local filesystem diagnostic, model/provider/DB/OS veya upstream suite execution yoktur.** Test source inspected NOT RUN; RESULT/PASS/raw test arşivi yok. V1 second-sync, reset/restore result, backup collision ve sidecar rollback sonuçları koşullu source composition'dır; actual user incident veya task-quality deneyi değil. Current docs/defaultbranch navigation source pin'ini değiştirmedi. Raw download DNS failure kaynak materyalizasyonu sayılmaz.

Başlangıçc76dfd79 U14 yayımlı. Opening2bcdf606afaad1788faf46d9bfd7fc19cee3b733 main/ref/full PLAN/one-path compare→A39bb5929f1962e0ebf1b6c1a3897aff6e963b14f main/ref/full A1–44+45–EOF/sources/STATE→B666038a71b89af7a0dc663bd99aff2c4b30d1045 main/ref/full B1–46+47–EOF/sources/NOTRUN/STATE→scope/next değerlendirmesi. A/B original source metinleri final routing sırasında değişmez. Synthesis01/notes03/04/08 tam tekrar okundu; eski evidence bağımsız yeniden doğrulanmadı. Control dosyaları research corpus'u değildir.

## U14 — Korunan install/update kaynakları

[Note29](notes/29-INSTALLATION-UPDATE-AND-ACTIVATION.md)→[A INSTALL-SOURCES](evidence/2026-09-13-install-update/INSTALL-SOURCES.md)/[B UPDATE-SOURCES](evidence/2026-09-13-install-update/UPDATE-SOURCES.md)→[A](evidence/2026-09-13-install-update/INSTALL-AND-ACTIVATION.md)/[B](evidence/2026-09-13-install-update/UPDATE-AND-RECOVERY.md)/[NOT RUN](evidence/2026-09-13-install-update/CHECKS-NOT-RUN.md)/[PUBLICATION](evidence/2026-09-13-install-update/PUBLICATION.md).

U14 S01–S14, yedi full/yedi selected, source-only; installer/updater/solver/service/DB/model/suite koşusu yoktu. Opening1d65fd3e, A c0d64188, B2ce9310a, finalroutes4ddc90d8, receiptc76dfd79 kendi makbuzunda. U15 essential consumer açıklaması eski install caller dilini daraltır; U14 metinleri yeniden yazılmadı ve test sonucu üretilmedi.

## U13 — Korunan consumer kaynakları ve seçki koşusu

[Note28](notes/28-DELEGATION-COMPLETION-AND-PARENT-REENTRY.md)→[A RESEARCH](evidence/2026-09-13-delegation-reentry/RESEARCH.md)/[SOURCES](evidence/2026-09-13-delegation-reentry/SOURCES.md)→[B DIAGNOSTIC](evidence/2026-09-13-delegation-reentry/DIAGNOSTIC.md)/[SPEC](evidence/2026-09-13-delegation-reentry/SPEC.md)/[MANIFEST](evidence/2026-09-13-delegation-reentry/MANIFEST.json)/[raw](evidence/2026-09-13-delegation-reentry/diagnostic-evidence.tar.xz). [PUBLICATION](evidence/2026-09-13-delegation-reentry/PUBLICATION.md) uzlaştırılmış final makbuzu taşır.

Historical tek manual-selection invocation2026-09-13T04:01:40.644076+00:00–04:01:40.658275+00:00; sekiz seçki/D01–D08 ve N01–N02. Modelworker0/SQL0; full-parent fidelity false. Raw RESULT SHA25620e39d3c07c6d61a2e5e3dea7344baf62af52b6ffd6d9f59911ab1cce93e93f1; probe5d61c37dd003a080896ff72f79f7119d7efb05269f92c4392da5ef9a9708ea3c. Archive9756bytes/11files, SHA2560518ab011705b951db2d5776411be5d2f9080b8d4f09ffa6be9063e45570c7c5, Git798d00149d800ad52fb604a36dca70e1b384e995. Bu tur tekrar decode/hash/run yapılmadı; bunlar korunan eski kanıt kimlikleridir, U15'in yeni sonucu değil.

## Önceki doğrudan kanıt yolları

| Birim | Source/ham kanıta giriş |
|---|---|
| U12 tool/delegation | [A](evidence/2026-09-13-tool-delegation/TOOL-ADMISSION.md)/[A SOURCES](evidence/2026-09-13-tool-delegation/TOOL-SOURCES.md), [B](evidence/2026-09-13-tool-delegation/DELEGATION-LIFECYCLE.md)/[B SOURCES](evidence/2026-09-13-tool-delegation/DELEGATION-SOURCES.md), [NOT RUN](evidence/2026-09-13-tool-delegation/CHECKS-NOT-RUN.md)/[PUBLICATION](evidence/2026-09-13-tool-delegation/PUBLICATION.md); source-only |
| U11 runtime/backend | [A SOURCES](evidence/2026-09-12-runtime-backend/SOURCES.md)/[B SOURCES](evidence/2026-09-12-runtime-backend/BACKEND-SOURCES.md)/[PUBLICATION](evidence/2026-09-12-runtime-backend/PUBLICATION.md); source-only |
| U10 execution/context | [SOURCES](evidence/2026-09-12-cron-execution-context/SOURCES.md)/[SPEC](evidence/2026-09-12-cron-execution-context/SPEC.md)/[RESULT](evidence/2026-09-12-cron-execution-context/RESULT.json)/[MANIFEST](evidence/2026-09-12-cron-execution-context/MANIFEST.json); C01–C06 local-file selector, failed first parse korunur |
| U09 occurrence | [SOURCES](evidence/2026-09-12-cron-occurrence-admission/SOURCES.md)/[RESEARCH](evidence/2026-09-12-cron-occurrence-admission/RESEARCH.md); source-only |
| U08 cancellation/drain | [SOURCES](evidence/2026-09-12-cron-drain-receipts/SOURCES.md)/[RESEARCH](evidence/2026-09-12-cron-drain-receipts/RESEARCH.md)→SPEC/RESULT/MANIFEST/raw; native async/synthetic send |
| U07 cron/queue | [SOURCES](evidence/2026-09-11-cron-scheduling-delivery/SOURCES.md)/[RESEARCH](evidence/2026-09-11-cron-scheduling-delivery/RESEARCH.md)→SPEC/RESULT/MANIFEST/raw; queue/temp SQLite |
| U06 resume | [SOURCES](evidence/2026-09-11-resume-admission/SOURCES.md)/[RESEARCH](evidence/2026-09-11-resume-admission/RESEARCH.md)→SPEC/RESULT/MANIFEST/raw; process-local lease |
| U05 lease/history | [SOURCES](evidence/2026-09-11-session-lease-recovery/SOURCES.md)/[RESEARCH](evidence/2026-09-11-session-lease-recovery/RESEARCH.md); source-only |
| U04-A/B | [A SOURCES](evidence/2026-09-11-multi-turn-continuity/SOURCES.md), [B RECONCILIATION](evidence/2026-09-11-multiturn/RECONCILIATION.md)/[33-file manifest](evidence/2026-09-11-multiturn/DELIVERY-MANIFEST.json); ayrı vaka/raw/probe |
| U03/U02 | [Kanban SOURCES](evidence/2026-09-10-kanban-task/SOURCES.md), [turn SOURCES](evidence/2026-09-10-turn-lifecycle/SOURCES.md) |

[Exact U14 ledger](https://github.com/batuhanozgun/agentic-os-search/blob/c76dfd796996e96824d9860b0735a60a663ed7a0/research/studies/hermes-agent/SOURCE-LEDGER.md)→U13/U12 önceki hash/date/reading/attempt ayrıntıları; [through-v0.9](SOURCE-LEDGER-THROUGH-V0.9.md) erken kayıtlar. Original evidence taşınmadı/değiştirilmedi. U04-B33 original subtree d01c92f7414713300934be3bb4e3d40ac57631b3 korunur.

Q60 yalnız current next soru, yapılmış evaluation finding değil. Q59 local source-advanced; remote governance, actual filesystem/first request/quality ve eski Q40/Q42/Q47–58 residual'ları kapanmaz. Kaynak veya yayın sayısı ürün güveni değildir.
