# Hermes Agent — Açık sorular

**2026-09-11 / v0.16.** Q01–Q39 korunur; değişmeyen ayrıntılar [v0.15 exact kayıt](https://github.com/batuhanozgun/agentic-os-search/blob/13e00420d27547998475ac3d1bcd0d4a492f2229/research/studies/hermes-agent/OPEN-QUESTIONS.md) ve onun v0.14 bağlantılarındadır. Bu dosya önceki soruları sessizce kapatmaz. [U04 SOURCES](evidence/2026-09-11-multiturn/SOURCES.md), [STATE](STATE.md).

| ID | Current disposition |
|---|---|
| Q12 | Üç provisional native açıklama katmanı oluştu. Genel recursive kapsam ve bütün sistem açık. |
| Q34/Q35 | U03 task/run/claim/receipt üzerine actual quiet CLI→goal-loop→own-run status bağı ve selected SQLite-reader testleri eklendi. Gerçek physical cancellation ve full caller identity hâlâ açık. |
| Q36 | U04 G08/G09 controller block sonucu ile DB acceptance ayrımını açar; process exit/first response ayrı. Actual recovery/notification/whole transaction teslimi açık. |
| Q37 | PARTIAL BOUNDED ADVANCE: Kanban goal-mode, session goal/loop/heartbeat kayıt/tetik/stop farkları kaynakla açıklandı. Actual UI/process/profile/restart closure değildir. Aynı WAIT veya done semantiği peşinen aktarılmayacak. |
| Q38/Q39 | U03/K ve U04 Kanban manuel seçkilerinin full-parent fidelity'si açık. Optional run guard ile normal worker-ID aktarımı ayrı; güçlü security hükmü yok. |
| Q40 | FIRST NEXT: actual SessionDB get_meta/set_meta success/failure sözleşmesi manager save/load ve parent→child migration'a nasıl taşınıyor? H09 full heartbeat/reduced-adapter fault actual DB/compaction integration değildir. |
| Q41 | Host restart/session rotation sonrası heartbeat watch, loop route ve in-flight awaiting_response nasıl recover edilir? Kalıcı ayar varlığı yeniden admission garantisi değildir. |
| Q42 | Judge sürerken ownership değişiminde hangi actual AIAgent/OS kontrolleri ek turu veya etkisini durdurur? G10 yalnız selected-call ordering ve harmless callback gösterir. |
| Q43 | Controller'ın block outcome'ı kabul edilmediğinde gerçek dispatcher hangi kayıt/sinyalle retry veya reconciliation yapar? G08/G09 actual DB block implementation testi değildir. |
| Q44 | Session GoalGate'in HEAD+porcelain fingerprint'i aynı dirty-path içindeki içerik değişikliğinde başarısız sonucu ne zaman tekrar kullanır? SOURCE QUESTION ONLY, bu tur executable gate testi yok. |
| Q45 | `/loop` marker/count/until sonlanmaları, statü metni ve kullanıcının kabul koşulu nasıl eşleştiriliyor? Kaynakta ayrı nedenler var; actual model/UX semantik doğrulaması yok. |

Q07/Q22 ordinary compaction→API-message source bağı korunur; final wire/timing/allvariants açık. Q26/Q29 full-original/full-worker NOT RUN. Review/skill/ledger/sync, scanner/profiles, provider/backend/delegation ve kalite soruları kapanmadı.

U04 SPEC önce yazıldı; G01–G12/H01–H09 yeni koşu, 3 negatif kontrol. Tam upstream byte eşleşmesi yalnız heartbeat.py'de; diğerleri manuel seçim. Gerçek temporary SQLite ile fixture schema/adapter aynı şey değildir. Readback, source fidelity, independent replication ve semantic quality farklı kanıt düzeyleridir.
