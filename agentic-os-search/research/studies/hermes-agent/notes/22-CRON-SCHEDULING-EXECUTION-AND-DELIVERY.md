# 22 — Cron: planlanan iş, deneme ve teslim

> Bu metindeki unpublished durumu ilk U07 teslim anını kaydeder. İlerideki gerçek yayın hükmü ilgili PUBLICATION makbuzu ve güncel canonical STATE üzerinden okunur; raw deney kimlikleri bundan etkilenmez.
**2026-09-11 / U07 / PROVISIONAL; UNPUBLISHED DELIVERY.** [STATE](../STATE.md), [RESEARCH](../evidence/2026-09-11-cron-scheduling-delivery/RESEARCH.md), [SOURCES](../evidence/2026-09-11-cron-scheduling-delivery/SOURCES.md), [RESULT](../evidence/2026-09-11-cron-scheduling-delivery/RESULT.json), [PUBLICATION](../evidence/2026-09-11-cron-scheduling-delivery/PUBLICATION.md). Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; current release değil. Bu candidate dosyanın yerel varlığı main yayını değildir.

## U06'dan geçiş

U06/v0.19 yayını zaten tamamlanmıştı. Startup wrapper'ının o anda görülen carrier task'ını beklediği yeniden okundu; alt gateway/run.py isteği 429 aldı. Actual startup preclaim/drain/agent admission ve actual-DB quiet history açık bırakıldı. Kayıtlı erteleme kuralıyla F10 cron/scheduler→run→delivery ailesine geçildi; dar borç, başka bir testle kapatılmış gösterilmedi.

## Native modelde yeni ayrım

**Kaydedilmiş job ≠ kurulmuş trigger ≠ claimed execution ≠ tamamlanmış hesaplama ≠ teslim edilmiş çıktı.** Job kaydı ile provider registration ayrı başarısız olabilir. Built-in ticker recurring next-run'ı iş başlamadan ilerletir; finite one-shot `repeat.completed` sayacını yan etkiden önce tüketebilir. Bu yüzden sayaç, ticker success veya run-body True dönüşü kullanıcı işinin başarı ölçütü değildir.

Execution ledger, exact process/deneme kimliğini saklayan audit kaydıdır; interrupted→unknown geçişi otomatik retry kuyruğu değildir. External worker, durable ownership almadan ready acknowledgement yayımlamaz; belirsiz ack yüzünden ikinci in-process işe dönülmez. Gerçek OS/cgroup/process doğrulaması yapılmadı. Jobs genel kilidinin degraded-mode davranışı ile per-job fire fence'in fail-closed davranışı ayrıdır; tüm araç etkileri için global exactly-once güvencesi çıkarılmaz.

## Yeni bounded gerçek-SQLite bulgusu

Tam `cron/delivery_queue.py` 13.837 byte, Git blob `689fd620d6193003bbd168a0e62770a0d0306ac6` eşleşti. D01–D06, native queue SQL/transaction ve geçici gerçek SQLite ile koşuldu; transport ve alt çevre dikişleri sentetik. **D01: hata yok/None dönüşü, hâlâ pending payload'la birlikte gerçekleşti.** D03: claimed kayıt timeout'ta unknown oldu; geç finish onu delivered yapamadı. D06: bir callback sonrası gerçek SQLite trigger yazıyı ABORT etti; recovery ikinci gönderim yerine unknown yazdı. D02/D04 same-ID ve tombstone idempotency, D05 işlenen sayısı/teslim başarısı ayrımını açtı.

N00 kimlik ve N01/N02 mutant kontrolleri dar oracles'ı sınadı. İlk metadata/audit hatası attempt-00'da korundu; o girişim vaka başlamadan durdu. Bu altı durum ürün skoru veya bağımsız replication değildir; actual SessionDB/gateway/network/process restart yapılmadı. D01 sıfır callback alanı setup açıklamasıdır, ayrı transport sensor'ü değildir.

## Üst katmana koşullu etkisi

`_deliver_result` queue'dan None'ı hata yok olarak geçirir. `_classify_delivery_outcome`, non-local/configured/should-deliver koşullarında bunu delivered sınıfına çevirebilir; pending queue row'u yeniden okumaz. **Çalıştırılmış queue sonucu + kaynakla bağlanmış üst-katman çıkarımı** ayrı tutulur; enclosing scheduler/monitoring/gerçek UI bu tur koşulmadı. Kaydı geleceğe bırakmak teslimin gerçekleştiği anlamına gelmez; bu, mesajın kesin kaybolduğu anlamına da gelmez.

Ayrıca adapter bare success, gerçek message ID olmadan UNVERIFIED kabul edilebilir. Default external misfire backstop 600s beklerken one-shot grace 120s olduğundan o backstop'un default one-shot catch-up aralığı boştur; normal fire/built-in/force yollarının yokluğu veya ürün bug hükmü değildir.

## Sonraki sınır

İlk sonraki cron consumer: actual gateway delivery drainer/profile/transport ve queued/delivered/finished kayıtlarının dış tüketicileri; ardından occurrence kimliği, late callback ve rearm. Actual run_job/script/agent/provider bağlamı da açıktır. Q40/Q42 ertelenmiş validation, eski Q07/Q22/Q26/Q29/Q38 borçları korunur. Üç merkezi provisional synthesis ve notes01–21 değişmez; bu not dördüncü completed model, final CORE, Foundation projection veya adoption değildir.
