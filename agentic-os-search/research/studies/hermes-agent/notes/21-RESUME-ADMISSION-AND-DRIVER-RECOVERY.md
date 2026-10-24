# 21 — Devam kabulü, geçmiş ve yeniden çalışan sürücü

**2026-09-11 / U06 / PROVISIONAL.** [STATE](../STATE.md), [araştırma](../evidence/2026-09-11-resume-admission/RESEARCH.md), [kaynaklar](../evidence/2026-09-11-resume-admission/SOURCES.md), [yeni sınırlı koşu](../evidence/2026-09-11-resume-admission/RESULT.json). Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. U04-A/B, U05 ve üç merkezi synthesis korunur.

## Yeni bağlantı

U05'in actual messages selector/guard source engeli açıldı. Devamın önünde tek kapı yok: routing→resolved SID, process-local gateway lease, durable compression-root lease, model-history projection, active-turn marker, driver dispatch ve external delivery farklı geçişlerdir. Gateway lease bütün süreçleri kapsamaz; DB lease Kanban task-run yetkisi veya bütün tool effect fence'i değildir.

Actual DB guard, sağlanan holder'ı transaction içinde kontrol eder; aynı sahip henüz değiştirilmediyse süresini yenileyebilir, successor varsa eski yazıyı reddeder. Agent flush holder'ı geçirir. Holder/reject flag olmadan bütün writer'ların bu gate'ten geçtiği varsayılmaz. Closed-parent write recovery doğru tip'e yazıyı yönlendirebilir; bu, model history'sini onaran genel reload değildir.

Normal gateway önce kendi lease'ini alır, active-turn marker'ı yazar, sonra history yükler; unreadable history [] yapılmaz. Model bağlamı ile kullanıcıya gösterilen lineage geçmişi ayrı projection'lardır. Cached same-session agent'ın canlı geçmişi bazı koşullarda DB görünümünün yerine seçilebilir. Bunlar quiet Kanban caller'ın no-wait/no-rotation history-propagation açığını otomatik kapatmaz; gerçek next-request ölçümü açık.

## Restart ve driver

Startup active marker→resume_pending→freshness/owner/route→internal event yolunu kurar. Hesaplanmış ama teslim edilmemiş cevap için ayrı obligation/redelivery yolu vardır; yeniden hesaplama gereğiyle karıştırılmaz. Actual loop watcher startup bağı görüldü. Uygun post-turn hook, restored awaiting_response tick'ini tamamlayabilir; salt due zamanının geçmesi yine yetmez. Primary heartbeat handler'da **status watch kurmaz; set/resume kurar**.

Adapter handle_message hızlı döner; kendi background task'ı ve olası drain zinciri başka sınırdır. Startup ilk görünen task'ı da bekler; bu telafiyi atlamıyoruz. Fakat preclaim/busy sentinel→drain→actual agent admission ve post-delivery callback'in gerçek teslimle ilişkisi bütün host üstünde sınanmadı. Bir finally callback'i yalnız adına bakılarak successful delivery receipt sayılmaz.

## Yürütülen ile açık olan

Tam orijinal `gateway/turn_lease.py` (blob `1f65614e66e748ec61573aced3fa48b57ee20281`) gerçek asyncio ile **L01–L07**: same-session serialization, timeout, rotation alias, conflicting rebind, token identity, waiter cancellation/eviction ve ayrı registry sınırları. Beklentiler karşılandı; N00 source identity, N01/N02 mutation kontrolleri ilgili hatayı ayırdı. Tek araştırmacı/tek kayıtlı koşu; ürün skoru veya independent replication değil.

Actual SessionDB/history, full startup/adapter restart, migration fault/profile, model semantiği, external effect/teslim ve eski full-parent fidelity açık. Yeni source bug hükmü bütün ürüne yayılmaz. Default-branch'te görülen daha yeni heartbeat restore kodu yalnız freshness uyarısıdır; primary pin yükseltilmedi.

İlk dar devam: startup carrier/preclaim→drain→actual admission/receipt ve uygun actual-DB quiet history trace'i. Bu kenar için sonu belirsiz fault taraması değil bounded normal+karşı yol gerekir; ardından geniş F10 cron/scheduler→run→delivery araştırması öne alınır. [Kapsam](../inventory/RESUME-ADMISSION-COVERAGE-2026-09-11.md), [PLAN](../RESEARCH-PLAN.md).
