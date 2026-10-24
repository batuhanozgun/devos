# 24 — Kalıcı iş ile planlanmış çalıştırmayı ayırmak

**2026-09-12 / U09 / PROVISIONAL SOURCE STUDY.** [STATE](../STATE.md), [RESEARCH](../evidence/2026-09-12-cron-occurrence-admission/RESEARCH.md), [SOURCES](../evidence/2026-09-12-cron-occurrence-admission/SOURCES.md), [NOT RUN](../evidence/2026-09-12-cron-occurrence-admission/CHECKS-NOT-RUN.md), [PUBLICATION](../evidence/2026-09-12-cron-occurrence-admission/PUBLICATION.md). Primary c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a; latest ürün hükmü değildir.

## Native modele eklenen

Chronos dış kaydı job_id:fire_at ile tekilleştirmeyi talep ediyor. Dönüşte dashboard yalnız job_id JSON'u forward ediyor; gateway de claim_fire'a yalnız bu ID'yi geçiriyor. Active fire_claim, kalıcı job kimliği, planlanmış occurrence ve execution audit kimliği eşdeğer değil.

Gerçek claim işlevi terminal/pause/live-owner/fence kontrolleri uygular. Generic loader/_with_job ve runnable yardımcıları zaman kapısı eklemiyor. Normal mark_job_run eski fire_claim'i temizleyip recurring işi gelecek next_run_at ile scheduled bırakabilir. Bu durumda geçerli ama eski occurrence'a ait bir çağrının yeni claim alabilmesi kaynakla açıklanıyor. **T0–T4 koşullu kaynak izi, çalıştırılmış duplicate deneyi değildir.** Dış NAS dedup'u, live/terminal/paused retleri ve sonraki gerçek worker davranışı ayrıca sınırdır.

Wire belgesinin “iş tamamlandıktan sonra da eski fire claim/time advance nedeniyle düşer” genellemesi, incelenen agent kabul koduyla desteklenmiyor. Built-in due-scan'de zaman karşılaştırması var; bunu external direct-claim yoluna taşımak yanlış. Explicit rearm_oneshot aynı job ID'sinde zamanı/bütçeyi yeniler ve canlı claim üzerine yazmayı reddeder; eski callback'in nesil eşlemesi ayrı soru.

## Makbuz ve kanıt sınırı

Split provider'da 202 claim dönüşünü bekler; legacy provider'da aynı 202 henüz background fire_due devrini bildirir. 200 duplicate etiketi None'a dönüşen farklı ret nedenlerini kapsayabilir. Hosted 200 gateway_stopped ise yürütme başarısı değil, operator-stop nedeniyle retry'ın kesilmesidir. HTTP kabul, ajan completion ve teslim aynı olay değildir.

Upstream webhook testlerinin kaynakları incelendi; mocked provider ile handler sırası/ret/adapter aktarımı sınanıyor, gerçek occurrence store doğrulaması değil. U09'da yeni HERMES/test/NAS/network koşusu yapılmadı. Yeni default-branch occurrence sembolleri yalnız freshness pointer'ıdır; pin yükseltilmedi, güncel fix iddiası yok.

Q47 bounded source açıklaması ilerledi; gerçek late-callback/clock/process/store deneyleri NOT RUN'da. **Sıradaki geniş birim Q49:** scheduled snapshot hangi run_job/betik/ajan/model/oturum/geçmiş yoluna dönüşüyor? Eski U04–U08, üç merkezi synthesis ve Q40/Q42/Q48/Q50 dahil açık doğrulamalar korunur. Yeni CORE, Foundation düğümü veya adoption kararı değildir.
