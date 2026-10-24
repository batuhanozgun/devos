# U01-D2 — Worker izin sınırı: seçili işlev entegrasyonunun canonical girişi

**Araştırma tarihi:** 2026-09-08. **Yayın tarihi:** 2026-09-09. **Statü:** RECOVERED SOURCE-SELECTED FUNCTION INTEGRATION; tam sistem doğrulaması değil. Birincil pin `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` korunur.

## Araştırma ve kanıt

[Tam araştırma](../evidence/2026-09-08-worker-policy/RESEARCH.md), [E01–E07 kaynak/derinlik defteri](../evidence/2026-09-08-worker-policy/SOURCES.md), [deney sınırları](../evidence/2026-09-08-worker-policy/README.md), [14 ana durum](../evidence/2026-09-08-worker-policy/RESULT.json), [5 ayrı ad-doğrulama durumu](../evidence/2026-09-08-worker-policy/VALIDATION-RESULT.json), [gerçek pre-import kimlik reddi](../evidence/2026-09-08-worker-policy/IDENTITY-CHECK.json). [Yayın ve tarihsel metin uzlaştırması](../evidence/2026-09-08-worker-policy/PUBLICATION.md), [aktarım bütünlüğü](../evidence/2026-09-08-worker-policy/TRANSFER-CHECK.json).

Bu dilim 06'nın sentetik policy denetçili transport kanıtını ilerletir: pool/context ve ek deneyde name-validator tam modülleri kimlik doğrulamasıyla; gerçek executor ve whitelist tüketicisinin elle aktarılmış seçili tanımlarıyla birleştirildi. Relay/middleware/lifecycle/guardrail/ajan/profil/approval çevresi açık taklitlerdir. Büyük executor/plugins dosyalarının tam bağımlılıklarıyla yürütülmesi veya gerçek review kurulumu değildir.

Dar sonuçlar: parent'ta ret üreten whitelist worker tüketicisinde bulunmadı; worker'a açık deneysel binding ret davranışını geri getirdi. Bağımsız scope/guardrail/lifecycle ret yolları çalışmayı engellemeyi sürdürdü. Geniş sentetik geçerli-ad kümesinin kabulü dar review yetkisini sağlamadı; ad kümesinden çıkarma ve kesilmiş JSON erken ret üretti. `dispatched=True`, policy öncesi callback kabulünü işaretleyebildi; gerçek etki oracle'ı handler sayısıydı. İkinci middleware callback girişi reddedildi, marker bir kez çalıştı. Bu sonuçlar üretimde evrensel bypass, gerçekleşmiş olay, olay oranı veya öğrenme kalitesi hükmü değildir.

## Açık kalan ilk iş

1. E01/E02 tam pinned dosyalarını doğru blob kimlikleriyle yerelde elde et; mevcut `verify_excerpts.py` ile seçili tanım eşitliğini sına. **Bu AST kontrolü henüz çalıştırılmadı.** Eşitlik, yalnız seçki sadakatidir; tam davranış entegrasyonu değildir.
2. Gerçek review/fork kurulumu → `valid_tool_names` oluşumu → ordinary executor/middleware → worker policy tüketicisi bağını, zararsız handler'a ulaşmayı ve olası ek kontrolü birlikte izleyerek doğrula. Tam ithal modüllerle yürütülen parçalar ile taklitler ayrı kaydedilmeli; kurulum/provider/credential yetkisi genişletilmemeli.
3. Bağımlılık kapanışı kurulamazsa hangi halka ve iddianın açık kaldığını kaydet. Aynı seçili fixture'ı çoğaltıp bu boşluğu kapanmış sayma. Sınır yeterince açıklandığında pending UI/profile/store, bellek M01/M02, ledger/backup/restore/sync, skill/cache ve curator batch/report/cron sırasına dön.

Güncel yetki, sıra ve durma ölçütü [STATE](../STATE.md), [plan v0.7](../RESEARCH-PLAN.md) ve [METHOD](../METHOD.md)'dadır. Bu yayın yeni teknik deney değildir; önceki 01–08 notları ve tüm eski kanıtlar değişmeden kalır. Özgün teslimin NOT PUBLISHED/NOT APPLIED ve v0.6 ifadeleri tarihsel metindir; yeni oturum bunları current state olarak kullanmamalıdır.
