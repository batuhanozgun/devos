# U01B2 — Onay/replay ve geri alma kanıtının canonical girişi

**Yayın tarihi:** 2026-09-08. **Statü:** RECOVERED DELIVERY / BOUNDED TWO-MODULE COMPONENT EVIDENCE. Araştırma tamamlanması veya yeni deney değildir.

## Tam araştırma ve ham kanıt

[Tam U01B2 araştırma notu](../evidence/2026-09-08-u01b2/06-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md) ZIP'teki özgün metin olarak korunur. [Deney düzeni](../evidence/2026-09-08-u01b2/README.md), [ölçütler](../evidence/2026-09-08-u01b2/SPEC.md), [kod](../evidence/2026-09-08-u01b2/probe.py), [ham sonuç](../evidence/2026-09-08-u01b2/RESULT.json), [kaynak kimlikleri](../evidence/2026-09-08-u01b2/SOURCES.json), [yayın uzlaştırması](../evidence/2026-09-08-u01b2/PUBLICATION.md).

Koşu UTC `2026-09-08T15:48:02.995262+00:00`, Python 3.13.5/Linux; iki exact arşiv modülü, sentetik bağımlılıklar ve 12 tanılayıcı senaryo. G01 içinde 10 gate varyantı vardır. Yayın turunda deney yeniden çalıştırılmadı. Bütün gözlem beklentilerinin sağlanması ürün conformance PASS'i değildir.

Dar bulgular: default-name girişinin batch'in sakladığı payload içinde tek başına korunmaması; aynı pending kaydının canlı dosya değişince farklı önizlem üretmesi; normal hata/istisna/snapshot başarısızlığı ayrımı; kontrollü araya-giren yazının snapshot rollback'inde korunmaması. Explicit-name ve snapshot-failure kontrolleri de korunur. Gerçek replay/production locking/worker erişilebilirliği bu deneyle doğrulanmadı.

## Mevcut çalışmayla birlikte nasıl okunmalı?

Bu teslim `a218acfc...` görünümü altında hazırlanmıştı. Yayın tabanı `29ab9b816843bab6f9e5f5b5815590fbac2b1713` artık [06 caller](06-CALLER-DISPATCH-AND-CONTEXT-TRANSFER.md), [07 memory](07-MEMORY-STORE-AND-PENDING-REPLAY.md) ve ayrı yedi senaryolu transport kanıtını içeriyor. Bunların hiçbiri U01B2 tarafından ezilmez veya yeniden yapılmış sayılmaz.

Özgün notun `06` adı bu dizinde kullanılmaz; bu giriş `08` olarak eklenir. Teslimdeki 'caller okunamadı', 'plan v0.5', 'v0.6 henüz yayımlanmadı' ve 'UNPUBLISHED' ifadeleri o eski çalışma diliminin tarihsel durumudur; current STATE değildir. Özgün not başındaki önerilen göreli kanıt rotası yerine yukarıdaki bağlantılar kullanılır. U01B2'nin yerel D01 kimliği transport kaynak defterinin D01'i değildir.

## Güncel devam sınırı

[STATE](../STATE.md) ve v0.6 [planın](../RESEARCH-PLAN.md) ilk işi korunur: actual ordinary executor + actual whitelist tüketicisi + zararsız handler ile worker sınırını birlikte doğrulamak. Sonraki pending/UI ve skill transaction çalışmalarında U01B2'nin iki somut ayrımı ayrıca kullanılır: gerçek default_name üretim/staging/replay rotası; rollback sırasında başka yazarları dışlayan kontrol. Yayın tamamlanması bu açık soruları kapatmaz veya Foundation/architecture/adoption yetkisi vermez.
