# Hermes Agent — STATE

**Durum:** ACTIVE PARTIAL RESEARCH / U04 MULTI-TURN CONTINUATION AND REACTIVATION BOUNDARIES  
**Son araştırma:** 2026-09-11.  
**Primary:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0; current-release doğrulaması değil.  
**Plan:** [v0.16](RESEARCH-PLAN.md). **Bütün HERMES araştırması tamamlandı mı? HAYIR.**

## Amaç ve yetki

Önce HERMES-native mekanizma/sistem modeli, sonra Information–Work–Actors–Environment ve SOUL/Development OS değerlendirmesi. Kullanıcı v0.15 sonrası önerilen Kanban çok turlu devam/durma ve goal/loop/heartbeat karşılaştırmasını onaylayıp araştırma devamını yetkilendirdi. U04 yeni kaynak araştırması ve yeni sınırlı deneydir; önceki U03 publication recovery'sinin tekrarı değildir.

Yalnız `research/studies/hermes-agent/**` ve CATALOG'daki HERMES satırı değişebilir. Bütün ürün kurulumu, gerçek model/provider/credential kullanımı, upstream/diğer repo/control/Foundation/architecture/adoption değişikliği yok. Codex başka repo kullanır; main hareketleri ona atfedilmez. Yanıtlar arasında otomatik çalışma veya uygulama izinlerini değiştirme yapılmaz.

## U04'te ne ilerledi?

[18](notes/18-MULTITURN-CONTINUATION-AND-REACTIVATION.md) → [RESEARCH](evidence/2026-09-11-multiturn/RESEARCH.md), [SOURCES](evidence/2026-09-11-multiturn/SOURCES.md), [SPEC](evidence/2026-09-11-multiturn/evidence/SPEC.md), [RESULT](evidence/2026-09-11-multiturn/evidence/RESULT.json).

Kanban'ın quiet CLI ilk tur→goal-loop→own-run status→finalize/block/stop bağı kaynakla açıldı. Judge done doğrudan task completion değildir. Review/changes/superseded, önceki run'ın devamını durdurabilir. Kanban WAIT'i continue sayar; oturum GoalManager ise bekleme bariyeri ve ayrı değerlendirme-hata sayaçları kullanır.

Session `/goal`, `/loop`, `/heartbeat` ayrı state_meta anahtarları, tetikleyiciler ve durma anlamları taşır. Loop marker/until/requested-count/config-budget kapanışları aynı değildir. Heartbeat manager anlamsal done kararı vermez; Kanban claim heartbeat'i farklı etkidir. Gateway heartbeat watch bellektedir; loop için persisted scan yolu vardır. Bütün restart/profile/adapter yolları kapanmış değildir.

21 durum: G01–G12 Kanban seçkileri/SQLite okuyucu bağlantısı; H01–H09 tam heartbeat modülü/kontrollü clock ve azaltılmış DB adapter. 3 negatif kontrol. Kaynak kimliği bozulan heartbeat çalıştırılmadan reddedildi. Bunlar ürün testi toplamı, başarı yüzdesi veya bağımsız doğrulama değildir.

Öne çıkan sınırlar: G08/G09 block sonucu DB kabulünü garanti etmez. G10 judge sırasında sahiplik değişince seçili loop bir ek harmless tur başlatıp sonraki kontrolde durdu; successor kaydı korundu. H09 child-save hatasında heartbeat migration True dönebildi, child yokken parent cleared oldu. Normal finalize, handoff, superseded, heartbeat coalescing/reload/abandon ve başarılı migration karşı kontrolleri de kayıtlıdır.

[Üçüncü provisional sentez](synthesis/03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md) kalıcı tanım, yeniden çalışma kararı, host admission, run acceptance ve yeniden etkinleştirmeyi ayırır. Nihai CORE/dört-alan/adoption değildir.

## Kanıt sınırı ve korunan geçmiş

**Yalnız heartbeat.py tam upstream byte kimliği doğrulanmış modüldür** (`d3f440d9ed2035505b0bdfbe7d6d57dec926317f`). Kanban loop ve goal_run_status manuel seçkiler; full-parent byte/AST fidelity NOT VERIFIED. Task writer'lar, judge/model turn, get_task, clock ve MetaDB fixture'dır. Gerçek geçici SQLite ve yeni bağlantıyla readback vardır; actual SessionDB/init, worker/process/OS iptali, gerçek judge veya adapter delivery yoktur.

01–17 notları, synthesis/01–02 ve eski evidence değişmeden korunur. [V0.15 STATE](https://github.com/batuhanozgun/agentic-os-search/blob/13e00420d27547998475ac3d1bcd0d4a492f2229/research/studies/hermes-agent/STATE.md) U03 recovery ve eski K sınırlarını taşır. U04 K/A/SA/AP/M4 veya başka eski suite'i yeniden çalıştırmadı. Q07/Q22 last-wire/timing, Q26/Q29 full-worker/original ve U03 full-parent borçları açık kalır.

## İlk sonraki sorumluluk

**Gerçek SessionDB/state_meta kayıt sözleşmesi, session aktarımı ve host yeniden etkinleştirmesi.** Hedef, normal manager write→durable read→parent/child migration→fresh session→watch/queue admission yolunu ve bir hata/yarım kalmış tick karşı yolunu actual consumers üzerinden açıklamaktır. H09'un azaltılmış adaptörünü tekrar kullanıp actual SessionDB doğrulandı denmeyecek. Gerekli source okunamazsa kapsam açık bırakılacak.

Bu adım, genel oturum sürekliliğini kalıcı iş yönetimine bağlar; bütün task ailesini güvenlik denetimine çevirmek veya aynı dar testleri çoğaltmak değildir. Sonrasında scheduler/cron, provider/backend/delegation, skill ledger/sync ve diğer UI/install/eval aileleri [kapsam](evidence/2026-09-11-multiturn/COVERAGE.md) ışığında yeniden seçilir. Her normal sohbet bir Kanban task'ı değildir.

## Cold start ve publication

Bootstrap → research root/studies catalog → META/STATE/INDEX → METHOD/plan → **18/U04 RESEARCH/SOURCES/SPEC/RESULT + synthesis/03**. U02 genel tur modeli ve U03 task/run/transaction açıklaması bağımlılık kaynaklarıdır. Full reproduction girdileri U04 paketindedir; eski chat ZIP'lerine ihtiyaç duyulmaz.

U04 hazırlanırken main 13e0042'den e335438'e ilerledi; karşılaştırmada yalnız Foundation değişiklikleri vardı. Yeni commit güncel main üzerine kurulmalı, diğer yollar korunmalı, ref non-force ilerletilmeli ve içerik geri okunmalıdır. Yerel teslim/paket veya Git nesnesi tek başına publication değildir; başarı gerçek ref/content receipt gerektirir. Erişim/araç görünürlüğü hataları tarihsel gözlemdir, kalıcı yetki yokluğu diye varsayılmaz.
