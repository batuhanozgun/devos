# U07 — Cron kapsamı ve açık consumer'lar

> Bu metindeki unpublished durumu ilk U07 teslim anını kaydeder. İlerideki gerçek yayın hükmü ilgili PUBLICATION makbuzu ve güncel canonical STATE üzerinden okunur; raw deney kimlikleri bundan etkilenmez.
2026-09-11 / candidate plan v0.20 / NOT PUBLISHED. [STATE](../STATE.md), [U07 RESEARCH](../evidence/2026-09-11-cron-scheduling-delivery/RESEARCH.md), [U07 SOURCES](../evidence/2026-09-11-cron-scheduling-delivery/SOURCES.md). [U06 map](RESUME-ADMISSION-COVERAGE-2026-09-11.md), [U05](LEASE-RECOVERY-COVERAGE-2026-09-11.md), [U04](CONTINUITY-COVERAGE-2026-09-11.md) ve [U02 F01–F12](CORE-COVERAGE-2026-09-10.md) korunur. Bu recursive census veya tamamlanma yüzdesi değildir.

| Alan | U07'nin gerçekten eklediği | Açık kalan |
|---|---|---|
| F10 job/trigger | Save/register partial failure; provider WHEN/common run ayrımı; recurring preadvance ve finite one-shot preclaim | Full create/parser/store load-save, callback occurrence/due/rearm; actual scheduler lifecycle |
| F10 execution | Native ledger full read; claimed/running/adopt/terminal/unknown; external worker ack source | Executions DB çalıştırılmadı; foreign PID/start-time, OS/cgroup, crash settlement |
| F03/F08 ownership | Jobs lock degradation vs per-job fail-closed fence; per-acquisition token; terminal owner check | Full writer coverage, arbitrary tool effects, cross-process/file-system variants |
| F09/F10 delivery | Exact full queue + temp SQLite D01–D06; tombstones, pending vs unknown, SQL fault; None→delivered conditional source chain | Actual gateway drainer/profile/transport; enclosing scheduler/status/UI trace; network uncertainty |
| F09 continuation | Source target-prep mirror/seed ayrımı görüldü | Full conversational continuation after delivery, thread/source ownership |
| Q40/Q42 earlier frontier | Startup wrapper selected re-read; new gateway/run.py source429 | Actual preclaim/carrier/drain/agent receipt, actual SessionDB/quiet next-history NOT RUN; explicit deferred debt |
| F01/F02/F04/F05/F06/F07/F11/F12 | Mevcut haritalar korunur | Actual run_job/agent context; provider/backend/delegation; skill-ledger/sync/quality; UI/install/eval |

## Kanıt ayrımları

S06 full byte identity yalnız queue modülüne aittir. S03 executions FULL READ, NOT EXECUTED. S02/S04/S05/S07 selected; native full-parent materyalizasyonu veya bütün bağımlılıklar yok. D01 gerçek return+DB snapshot'tır; üst classifier bağlantısı koşullu source inference. D06 gerçek SQLite-trigger write fault, actual filesystem/SessionDB/OS failure değildir. Altı vaka + üç negative control, eski U04/U06 skorlarına eklenmez. İlk pre-case metadata hatası saklandı.

## İlk sonraki

Actual gateway `drain_delivery_queue` caller'ını pinned ref'ten bul ve queued/delivered/finished consumer'larıyla bağla; default-branch pointer'ı current veya pinned doğrulama sanma. Sonra exact scheduled occurrence/late callback/claim/rearm ve shared `run_job` içindeki script/agent/preflight sınırı. Normal+deferred/uncertain yollar için kabul edilmiş iş ile teslim makbuzunu ayır. Sonsuz aynı-queue fault matrisi yerine açıklanamayan consumer'a git; Foundation veya mimariye geçme.

Q40/Q42 ertelemesi yüzünden broad F10 durdurulmadı; bu erteleme kapanış değildir. Önceki source429'ların hepsi yeniden genellenmez: U06 messages engeli açılmıştı, bu tur gateway/run.py aralığı reddedildi. Yerel publication paketi canonical main'in yerine geçmez.
