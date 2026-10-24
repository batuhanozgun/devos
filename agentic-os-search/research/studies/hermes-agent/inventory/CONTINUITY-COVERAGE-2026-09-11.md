# U04 — Devamlılık kapsamı ve sonraki consumer sınırı

2026-09-11. [U02 F01–F12 map](CORE-COVERAGE-2026-09-10.md) tarihsel kapsam kaydıdır; onun 'kanban ilk sonraki' satırı current authority değildir. Current [STATE](../STATE.md)/[v0.16 plan](../RESEARCH-PLAN.md). Bu dosya U03/U04 etkisini ekler; bütün upstream recursive envanteri veya tamamlanma oranı değildir.

| Alan | Artık açıklanabilen | Açık consumer/kanıt |
|---|---|---|
| F10 kalıcı task | U03 task/dependency/claim/run/terminal; U04 actual quiet goal caller | Actual worker process, watchdog/cancel, artifact/notification, full K/G parent fidelity |
| F10 tur-üstü devam/tekrar | GoalManager vs Kanban helper; loop ticks/stop/cadence; heartbeat state/watch | Actual cron/scheduler, host registration after restart, in-flight recovery |
| F03 session/history/lease | U02 context/session; U04 facade admission history substitution | FIRST NEXT actual turn_facade_lease/SessionDB consumer; history freshness and rotation/restore |
| F01/F02 turn/context | Per-turn budget/ID, passed-history copy and admission boundary | Real next-request history/payload; all engine/provider/UI variants |
| F08 ownership/delegation | G05 early superseded stop, G06 callback interleaving; own-run status source | Actual lower admission/cancel/side-effect fence; no production race test |
| F09/F11 gateway/CLI | Driver methods, user input priority, FIFO continuation, loop scan vs heartbeat watch | Complete host entry/adapter ack/profile topology; no whole driver test |
| F04 learning | Earlier syntheses/01–02 remain; continuation creates future memory/use conditions | Skill ledger/sync/curator/reuse and actual future-task quality still open |
| F05/F06/F07/F12 | No implied closure from continuity reading | Provider/secret, tool/plugin/full-worker, environment/backend/native, install/update/eval |

## Araştırma birimi yeniden ayarı

Kanban durable board state, session goal progress and time-based loop/heartbeat kendi native ayrımlarıyla ele alındı. Bunları yalnız cron başlığına veya tek task ontology'sine sıkıştırmak açıklamayı bozar. Ayrım kaynaklara dayalı provisional çalışma lensidir; Foundation taxonomisi değiştirilmedi.

Yeni source-model synthesis/03 ve G/H evidence, önceki küçük onay/SQLite testlerinin tekrarı değildir. Tam S05 execution yalnız H bölümünü güçlendirir; S01/S02/S06 veya eski K/E selected kaynaklarının sadakati ve bütün runtime otomatik doğrulanmaz.

## Sonraki bounded birim

`devam isteği → actual session lease/history seçimi → kaydedilmiş durum → rotation/restart sonrası route/driver/queue` zinciri. S10 `admit_durable_turn_lease` ilk giriş; kaynak429 engeli yeni turda yeniden kontrol edilir. Normal yol + bir interruption/rotation/restart yolunda hangi kaydın hangi canlı çalışmaya dönüştüğü açıklanmalı. Exact history/receipt gerekir; sadece aynı session ID, saved JSON, boolean outcome veya test adedi yeterli değildir.

Bu birimini seçme gerekçesi mevcut açıklama boşluğudur: tekrar niyeti ile gerçek yeniden çalışabilme arasında kaldık. Aynı G/H fakes'i çoğaltmak bunu kapatmaz. Tüm güvenlik borçlarını önce bitirmek genel sistemi daraltır; nihai SOUL/four-area sentezi ise geniş backend/scheduler/delegation boşlukları varken erken olur. Bounded source/consumer açıklamasından sonra broad-map yeniden önceliklendirilir.
