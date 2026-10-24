# 23 — Gerçek cron göndericisi, durum bildirimi ve iptal sınırı

**2026-09-12 / U08 / PROVISIONAL.** Yerel araştırma kaydı; güncel yayın [PUBLICATION](../evidence/2026-09-12-cron-drain-receipts/PUBLICATION.md)'dan okunur. [STATE](../STATE.md), [RESEARCH](../evidence/2026-09-12-cron-drain-receipts/RESEARCH.md), [SOURCES](../evidence/2026-09-12-cron-drain-receipts/SOURCES.md), [RESULT](../evidence/2026-09-12-cron-drain-receipts/RESULT.json). Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; current-version veya bütün host hükmü değildir.

## Native açıklamaya eklenen

U07'de ayrılan job/trigger/attempt/delivery zinciri, gerçek gateway tüketicisine bağlandı. Başarılı gateway startup'ından sonra açılan bağımsız housekeeping thread'i, ilgili profile scope ve adapter haritasıyla scheduler.drain_delivery_queue çağırır. Queue dosyası yoksa wrapper DB yaratmaz; varsa gerçek queue callback'i aynı _deliver_result'a gider. Bu source bağlantısı, bütün startup veya profile/transport yürütmesinin doğrulaması değildir.

Job'un son çalışma özeti, latest execution ve teslim kuyruğu farklı kayıtlardır. Gerçek list_jobs yalnız son execution'ı job'a bağlar; incelenen cron CLI yolu deliveries'i ayrıca okumaz. U07'deki pending+None deferral, başarılı hesaplama koşulunda _record_run_outcome→last_status=ok→CLI ok görünümüne kaynakla bağlanır. Bu, bütün UI'nın 'teslim edildi' dediği veya mesajın kesin kaybolduğu anlamına gelmez. Geç queue sonucu ile eski job özetini uzlaştıran bütün yazarlar taranmadı.

## İptal sonucu bir taşıma makbuzu değildir

Pinned _live_send_text, timeout sonrası cancel=True değerini hiç başlamamış gönderim; False değerini sürmekte olan/teslim varsayılacak gönderim gibi kullanıyor. Çağırdığı tam native async_utils.py, yalnız run_coroutine_threadsafe Future'ını döndürüyor; bu nesnenin durumu transport etkisiyle aynı değil.

**B02:** gerçek bridge + ikinci thread'de gerçek asyncio; coroutine önce yerel dosyaya yazıp fsync etti. İptalden önce dosya okundu; gerçek TimeoutError'dan sonra cancel=True döndü. İptal gözlendi, önceki dosya etkisi kaldı. **B03:** timeout ile cancel arasına terminal RuntimeError yerleştirildi; cancel=False döndü, çıktı dosyası yoktu. **B01:** normal receipt/dosya eşleşmesi kontrolü.

B02 yanlış 'True→hiç başlamadı' ayrımını; B03 yanlış 'False→başarılı/in-flight sayılabilir' güvenini sınırlar. Non-relay standalone fallback'in duplicate etki yaratabileceği veya hatanın delivery sanılabileceği **koşullu source çıkarımıdır**. Gerçek ağda duplicate veya actual enclosing scheduler/gateway çalıştırılmadı. Relay fallback'i ayrıca kapatıyor; platform idempotency/telafi araştırması açık.

Aynı caller'ın delivery varsayımı seed/mirror çağrısına da ulaşabilir; actual DB seed sonucu bu tur sınanmadı. Queue'nun bir claim'i, callback içindeki birden çok taşıma denemesini exactly-once yapmaz.

## Kanıt ve devam

Tam native bridge Git blob `2bc558fad21eeec736c0283cb7df86304349f222`; üç B vakası tek recorded run. N00 kimlik, N01/N02 observation-validator negatif kontrolleridir; source mutant veya bağımsız replication değildir. Test dosyası S07 sadece source-inspected, NOT RUN. Gerçek network/SessionDB/full-host/model koşusu yok.

Q48 source consumer bağlantısı ilerledi; Q46 status/receipt ayrımı somutlaştı; yeni Q50 cancellation/transport-phase sınırını saklar. İlk yeni geniş birim Q47 occurrence/late callback/claim/rearm; sonra Q49 run_job/context. Q48/Q50 entegrasyon deneyi, Q40/Q42 ve bütün eski doğrulama borçları kapanmadı. Aynı dar diagnostic'i çoğaltmak geniş sistemi açıklamak yerine geçmez.
