# 25 — Zamanlanmış işi çalıştırmak ve bilgisini yeniden kurmak

**2026-09-12 / U10 / PROVISIONAL.** [STATE](../STATE.md), [RESEARCH](../evidence/2026-09-12-cron-execution-context/RESEARCH.md), [SOURCES](../evidence/2026-09-12-cron-execution-context/SOURCES.md), [SPEC/RESULT](../evidence/2026-09-12-cron-execution-context/RESULT.json), [PUBLICATION](../evidence/2026-09-12-cron-execution-context/PUBLICATION.md). Pin c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a; current-product hükmü değil.

## Native açıklamaya eklenen

Accepted snapshot → dispatch/running gate → profile secret/terminal scope → run_job → script/no_agent/monitor/wake gate → prompt/config/runtime/tools → yeni cron agent/session → worker sonucu → output/teslim/terminal kayıtları bağlandı. Model açmayan başarılı sessiz bir tur ile model çalışıp kullanıcı işini bitiren tur aynı değildir. no_agent script hatası doğrudan başarısız sonuç verirken agent pre-run script hatası modele veri olarak taşınabilir.

Cron origin'i gönderici yetkisi gibi taşımıyor. Tool task ID, session ID, execution audit ve fire owner farklı ömür/kimliklerdir. Config/preflight/drift/fallback ayrı kapılardır. Configured agent workdir'i, workdir argümanı geçirilmeyen pre-run script'e otomatik uygulanmıyor; no_agent/monitor yolları workdir geçiriyor. Bu cwd farkı kaynak düzeyindedir; gerçek subprocess koşusu değil.

Süreklilik tek transcript değildir: context_from/self, iş not defteri, yerleşik/harici bellek, prefill ve SOUL/proje context ayrı taşıyıcılardır. Actual worker önceki conversation_history listesini geçirmiyor; init memory yükleme yoluna bağlı. skip_background_review bellek kullanımını kapatmaz. Store init timeout'u da sonraki lazy recall'ı evrensel olarak kapatmaz.

## Gerçek yeni dar koşu

Tam orijinal scheduler_prompt.py (blob 91d673649d6dca8ba3120d10671a8966e67a01ce, 16.049 byte), gerçek dosya/mtime/read ile yalnız _inject_context_from üzerinde çalıştırıldı. C01 yeni rapor; C02 yeni no_change belgesinin eski raporu gölgelemesi; C03 boş en yeni dosyada geri düşmeme; C04 ilk 8.000 karakterde Response'un dışarıda kalması; C05 yeni hata belgesinin seçimi; C06 missing predecessor'da beklememe. Dosyalar ve tüm seçilmiş metinler ham arşivde. Sentetik root/import seams seçim mantığını üretmedi.

Altı vaka beklentiyi karşıladı; N00 source kimliği, N01 sıra ve N02 kesim source mutant'ları ilgili yanlışta ret verdi. İlk probe parse hatası case başlamadan durdu; düzeltme yalnız son print sözdizimi, eski probe/log korunur. Bir başarılı koşu; gerçek scheduler/model/SQLite/worker/network/semantic quality değil. Source caller output'u SILENT filtresinden önce kaydeder; bununla diagnostic sonucu bağlanır ama enclosing flow çalıştırılmış sayılmaz.

## Modelin anlamı ve devam

Monitor yeni gözlemi agent başarı/tesliminden önce checkpoint eder. Gözlenmiş değişiklik ile başarıyla ele alınmış değişiklik ayrıdır; monitor fault deneyi yapılmadı. Max-iteration summary, job status ve session end_reason da kullanıcı kabulünün eşdeğeri değildir.

Yeni [synthesis04](../synthesis/04-SCHEDULED-WORK-AND-CONTEXT-PROVISIONAL.md), U07–U10'u tek geçici scheduled-work açıklamasında toplar. Eski üç sentezi veya açık doğrulamaları silmez; final CORE değildir. Q49 kaynak olarak ilerledi; Q51 selector/wire ve Q52 monitor-consumption kalitesi açık. İlk yeni geniş kaynak Q53 provider/runtime/backend sahipliğidir; eski Q40/Q42/Q47/Q48/Q50 ve tüm fidelity/quality borçları korunur.
