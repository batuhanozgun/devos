# U11 — Çalıştırılmamış ayırıcı kontroller

**2026-09-12 / NOT RUN.** U11-A/B kaynak araştırmasıdır. Aşağıdaki kontroller ne yapıldı ne de PASS aldı. Full ürün/model/credential/backend çalıştırması mevcut görev kapsamı değildir. Güvenli runtime/bağımlılık erişimi ve uygun yeni yetki kurulmadan bunlar otomatik başlatılmaz. [Araştırma](BACKEND-OWNERSHIP.md), [kaynak](BACKEND-SOURCES.md), [STATE](../../STATE.md).

| Soru | Ayırıcı kontrol ve gerçek ölçüm yüzeyi | Ne kapanmış sayılmaz? |
|---|---|---|
| Q55 declared model/system/history→native | Benzersiz sentinellerle ordinary ve native girişleri; fresh/reused/reconstructed agent ayrımı. Gerçek thread/start, turn/start, native effective model/config ve ilk model isteği ayrı kaydedilmeli; yalnız kwargs fake'i whole model doğrulaması değildir. | User_message içinde gömülü bağlam, native proje/config bilgisi veya eşleşen default, explicit aktarım alanlarıyla karıştırılmamalı. |
| Q55 native thread ile mirror | Aynı kaynak olaylarının native thread, projected messages ve kalıcı HERMES DB görünümleri; compaction sonrası ve process restart sonrası yeniden kabul. Restore/cache çağırıcılarının gerçek native thread eşlemesi izlenmeli. | Projector format testi veya DB'de mesaj varlığı native context restorasyonu değildir. |
| Q56 terminal makbuzu | Assistant item tamamlanmışken turn/completed gecikmesi/yokluğu; deadline sonucu, native thread activity ve sonraki turn kabulü birlikte ölçülmeli. | Kaynak branch'i, gerçek halen çalışan subprocess veya yanlış final cevap gözlemi değildir. |
| Q56 persistence makbuzu | Gerçek projection flush False/exception koşulu; returned completed/agent_persisted, gateway tüketicisi ve DB readback/sonraki resume karşılaştırılmalı. | Log uyarısı kaybın boyutunu göstermez; alanın sabit True olması tek başına ampirik data-loss kanıtı değildir. |
| Q56 control ve cleanup | Interrupt çağrısı, RPC cevabı, gerçek tool cessation, daemon/child lifetime, hard close ve yeniden giriş ayrı gözlenmeli. Soft cache eviction ve hard close farklı test kollarıdır. | İptal isteği, terminate çağrısı veya parent process exit bütün dış etkilerin bittiğini kanıtlamaz. |
| Q53 fallback/recovery residual | Ordinary fallback sırasında model/provider/api_mode/pool/headers/compressor/prompt alanları; geçiş ortası hata ve sonraki primary restore. Native hata/retire yolu ayrı koşul. | Mutator gövdesi transaction/rollback garantisi değildir; eski snapshot restore gövdesinin yerine geçmez. |
| Q54 araç/delegation sınırı | Gerçek tool registration/policy→dispatch→child parent-context→completion re-entry/cancel. Native MCP listesi ve aynı araçların ordinary parent-bound çağrıları ayrı karşılaştırılmalı. | Genel handle_function_call varlığı aynı per-agent yetki veya etkili policy anlamına gelmez. |

Yeni test tasarlanırsa oracle/başarı ölçütü sonuçtan önce sabitlenmeli; source identity, input, gerçek gözlem, output ve çevre bağımlılıkları birlikte saklanmalı. Negative control yalnız kendi ölçtüğü yanlışı dışlar. Tam source/import closure yokken kopya karar mantığını fake içinde çalıştırıp bunu gerçek HERMES davranışı sayma.

U04–U10'un Q40/Q42/Q47/Q48/Q50, Q49/Q51/Q52 ve diğer quality/fidelity/whole-worker borçları bu listeyle kapatılmaz. A/B kaynak okuması yeni bağımsız replication değildir. Bounded source açıklamasını bütün fault uzayını tüketmeye dönüştürmeden geniş araştırmaya geçilebilir.
