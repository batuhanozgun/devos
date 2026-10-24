# U05 — Lease/history/recovery kapsam eklemesi

2026-09-11; plan v0.18. [STATE](../STATE.md) current authority; [U04 coverage](CONTINUITY-COVERAGE-2026-09-11.md) ve [U02 map](CORE-COVERAGE-2026-09-10.md) tarihsel girdiler olarak korunur. Bu dosya tam recursive envanter veya tamamlanma yüzdesi değildir. [U05 kaynak](../evidence/2026-09-11-session-lease-recovery/SOURCES.md)/[inceleme](../evidence/2026-09-11-session-lease-recovery/RESEARCH.md). Aşağıdaki konu etiketleri yeni F-family numarası veya Foundation sınıflaması atamaz; mevcut F01–F12 haritası kendi kaynağından okunur.

| Alan / soru | U05 ilerleme | Hâlâ açık |
|---|---|---|
| Q40 admission-history | Actual turn_facade_lease FULL; immediate/waited/new-session ayrımı; facade→quiet caller→prolog list-copy; ayrı tip recovery. | Actual DB resume/projection, exact next-consumer/wire; runtime path/variant testi. |
| Q43 ownership | Root-key claim/refresh/release, TTL/dead-PID reclaim ve interrupt/liveness kaynakları. | Transcript guard'ın devamı 429; process cancellation ve external-effect fence; Kanban run ownership ile birleşim. |
| Q41 rotation | Actual child publication transaction; afterward best-effort manager calls; loop helper→real set_meta→separate transactions. | Goal/heartbeat alt yol, same DB/profile, actual fault/receipt/recovery; geçmiş B fixture kapsamı değişmez. |
| Q42 restart | GatewayGoals FULL; loop scan/route ve restored awaiting_response; heartbeat in-memory watch; goal FIFO girişleri. | Actual startup watcher registration, command/adapter/FIFO admission, heartbeat rotation rebind, process restart/crash timeline. |
| Bağlam / Q40 | Quiet no-wait/no-rotation boundary'nin koşullu history propagation sorusu daraldı. | Final provider payload ve bütün engine/hostlar. |
| Semantic completion / Q44–Q45 | Loop state-machine source yeniden görüldü; marker/count/judge/budget farklı kalır. | Judge quality/revision/oracle ve kullanıcı kabulü ölçülmedi. |
| Geniş F01–F12 kapsamı | Önceki haritalar korunur; bu ekleme bütün haritayı yeniden üretmez. | Provider/backend/delegation, actual cron/scheduler, diğer UI/install/eval; learning/ledger/sync/reuse quality. |

## Yöntemsel durma ve yeniden yön verme

Bu tur eski yayınları yeniden açmadı, source-only U05 ekledi. Önceki facade429 artık engel değildir; son engel messages consumer devamıdır. Gateway startup yalnız keşif pointer'ıdır, okunmuş/çalıştırılmış sayılmaz. Current sıralama not20/STATE'te; eski coverage'daki 'ilk sonraki' satırları bu eklemenin yerine authority değildir.

Sonraki bounded birim gerçek selector/guard ve kabul makbuzuyla pending work recovery'yi ayırmalı. Yeterli local kaynak kurulursa dar actual-DB test yapılabilir; reduced adapter ile olmayan bütünlüğü üretmek yoktur. Bu kenar açıklanınca geniş F01–F12 haritasına dönülür; sonsuz bir lease/fault alt araştırması veya erken SOUL mimarisi yapılmaz.
