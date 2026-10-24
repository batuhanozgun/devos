# EXP-001 — Eser envanteri ve sürüm sınırları

**Altı özgün eser/ek ve 26 çıkarılmış kaynak dosyası repository'dedir.** Yükleme commit'i: `a3987312bbfbb8aa0fbf4ea6fd8a1113d467f415`. Özgün paketle Git içerik kimliği eşitliği doğrulandı. Güncel [STATE](../STATE.md), [SOURCE-MANIFEST](../SOURCE-MANIFEST.json) ve [doğrulama kaydı](../checks/PAYLOAD-VERIFICATION.md).

## Konsolidasyon v0.1

- [Düzenlenebilir Markdown](consolidation-v0.1/SOUL_Calisma_Anlayisi_Konsolidasyon_v0_1.md) — 87.606 byte.
- [PDF](consolidation-v0.1/SOUL_Calisma_Anlayisi_Konsolidasyon_v0_1.pdf) — 651.941 byte; ilk arşivlemede 35 sayfa sayıldı.

İçerik: 18 ana bölüm, Ek A değişen kabuller, Ek B özgün çizim, Ek C konu kapsamı ve Ek D kaynaklar. U001–U011 boyunca gelişen içerik U012 isteğiyle diyalogdan bütünlüklü metne çevrilmiştir. Platform transcript'i değildir. Yaşayan katmanlı planın Atlas sonrası tartışmasını içerdiği varsayılmaz.

İlgili kaynak teslim: [S012](../sources/conversation/assistant/S012.md).

## Mekanizma Atlası v0.1

- [Etkileşimli HTML](mechanism-atlas-v0.1/SOUL_Mekanizma_Atlasi_v0_1.html) — 490.297 byte.
- [PDF](mechanism-atlas-v0.1/SOUL_Mekanizma_Atlasi_v0_1.pdf) — 1.332.083 byte; ilk arşivlemede 51 sayfa sayıldı.
- [Özgün kaynak ZIP'i](mechanism-atlas-v0.1/SOUL_Mekanizma_Atlasi_v0_1_Kaynaklar.zip) — 756.782 byte; 26 ZIP üyesi.
- [İncelenebilir kaynakların açıklaması](mechanism-atlas-v0.1/source/README.md), [ortak model](mechanism-atlas-v0.1/source/model.json), [kaynak bütünlük listesi](mechanism-atlas-v0.1/source/MANIFEST.sha256).

HTML'nin GitHub dosya görünümü bir canlı SOUL hizmeti değildir; etkileşimli belge indirildikten sonra tarayıcıda açılır. Arşivleme işi site yayını/deployment kurmadı.

Ortak modelin önceki arşivleme turundaki sayımı: 22 işlem, 11 bilgi nesnesi, 8 overview grubu, toplam 41 node; 71 ilişki; 7 görünüm; 10 demo adımı; 12 açık mekanizma; 21 hayali dosya kaydı. Bunlar kapsam sayımıdır, çalışma etkinliği kanıtı değildir.

26 ZIP üyesi: README, DOGRULAMA.json, MANIFEST.sha256, HTML/PDF, app.js, build_atlas.py, template.html, style.css, model.json, render_and_test.py, dayanak altındaki konsolidasyon Markdown'ı ve actor/change/execution/information/intake/overview/readiness için 7 DOT + 7 SVG. `source/`, özgün ZIP'in göreli yol ve byte kimliği korunmuş açılımıdır; başka bir canonical model sürümü değildir.

İlgili kaynaklar: [U013–U015](../sources/conversation/USER-MESSAGES.md#u013), [S013](../sources/conversation/assistant/S013.md), [S014](../sources/conversation/assistant/S014.md), [S015](../sources/conversation/assistant/S015.md).

## Özgün çizim

[Özgün PNG](../sources/original-sketch.png) — 602.469 byte. U006'da C adayları, C4 ve Work adımları boyunca değişen C/W ilişkisi çizilmiştir. Yeniden çizim veya OCR ürünü değil, özgün PNG korunur. Metinsel bağlam: [U006](../sources/conversation/USER-MESSAGES.md#u006).

## Sonraki tartışmanın yeri

[U016–U017](../sources/conversation/USER-MESSAGES.md#u016) ve [S016](../sources/conversation/assistant/S016.md)/[S017](../sources/conversation/assistant/S017.md), Atlas v0.1'in yaşayan proje planı bakımından kısmi kaldığını tespit eder. Bu bilgi v0.1 dosyalarının içine sonradan eklenmemiştir. [LEARNINGS L13–L14](../reflections/LEARNINGS.md) ve [OPEN-QUESTIONS O01–O02](../reflections/OPEN-QUESTIONS.md) üzerinden bulunur.

## Özgünlük ve doğrulama

Özgünler değiştirilmedi. Hash'ler SOURCE-MANIFEST'tedir. Önceki DOGRULAMA.json'un 24 arayüz kontrolü bu kapanışta yeniden çalıştırılmadı. Yeni kontrol, 32 dosyanın repository yol ve Git içerik-kimliğini doğruladı; tüm binary dosyaların ayrı indirme/SHA-256 denetimi yapıldığı iddia edilmez. Arşivleme yeni SOUL runtime/agent doğrulaması değildir.
