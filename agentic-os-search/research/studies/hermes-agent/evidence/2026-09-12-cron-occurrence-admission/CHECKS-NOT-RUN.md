# U09 — Gerçekte çalıştırılmamış doğrulamalar

**NO NEW HERMES EXECUTION.** Bu dosya deney planıdır; koşulmuş SPEC/RESULT değildir. [RESEARCH](RESEARCH.md) T0–T4 tablosu kaynak çıkarımıdır.

## 1. Asıl ayırıcı: gerçek claim ve normal kapanış

Tam pinned jobs.py + execution ledger + gerekli gerçek yardımcılarla geçici izole store kur. Bir recurring işin ilk claim'ini edin; normal owner-bound mark_job_run ile bitir; next_run_at gelecekteyken aynı job için eski occurrence callback'ini gerçek handler/provider yolundan geçir. Admission snapshot, owner, execution ID, next time ve HTTP yanıtını bağımsız okuyucu ile kaydet. Karşı yollar: live claim, pause/disabled, terminal once, rearmed once ve henüz gelmemiş tarih. Test fake'i kendi duplicate kararını üretmemeli.

Sırf helper gövdesini kopyalayarak veya claim_fire'a hazırlanmış dict döndürerek sonuç üretmek gerçek store doğrulaması değildir. Claim alınması ile ikinci worker'ın başlaması/bitmesi/yan etkisi ayrı sensörler gerektirir.

## 2. Hosted relay ve tam occurrence aktarımı

Gerçek dashboard forwarder→API adapter→provider zincirinde job_id/fire_at/olası nonce veya generation alanlarının gerçekten taşınmasını izle. NAS server'ın arm replacement, stale relay, retry ve kayıp HTTP acknowledgement politikası ayrıca kanıt ister. Bu tur dış NAS kaynakları/servisi çalıştırılmadı; platform veya credentials kullanımı için ayrıca yetki gerekir. Güvenli yerel transport gerçek dış servis davranışı diye sunulmaz.

## 3. Re-arm, manual ve saat farkları

Aynı job ID'sinde eski terminal once→yeni tarih/bütçe, re-arm ile geç callback yarışı, future-dated claim/clock skew, manual marker ve normal due-scan karşılaştırılır. İş planının kimliği ile row/lock/generation kimlikleri ayrı tutulur. Full jobs lock/file-system/process matrix, timezone/DST ve croniter koşuları yapılmadı.

## 4. HTTP ve test oracle sınırı

Split ve legacy provider kabul makbuzlarını ayrı sınamak gerekir. 200 duplicate'nin missing/paused/fence-loss nedenlerini doğru yansıtıp yansıtmadığı; 202 sonrasında process loss'un claimed audit kaydına etkisi ve background exception görünürlüğü açık. İncelenen upstream testler mocked handler-order testleridir; bütün suite koşulmadı ve bütün suite coverage yokluğu iddia edilmedi.

## Öncelik

Kaynak açıklaması Q47'yi ilerletir, runtime kapanışı yapmaz. İlk yeni geniş araştırma Q49 run_job/script/no_agent/monitor/agent/context'tir. Bu Q47 ölçümleri full-source/bağımlılık ve güvenli koşu imkânı doğduğunda veya güçlü güvenilirlik/adoption hükmü için yük taşıdığında yeniden açılır. Q40/Q42, Q48/Q50 ve eski Q07/Q22/Q26/Q29/Q38 borçları aynen korunur. Bütün hata uzayının bitmesi geniş araştırmanın ön koşulu değildir.
