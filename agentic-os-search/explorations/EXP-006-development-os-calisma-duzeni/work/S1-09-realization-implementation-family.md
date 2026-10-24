# S1-09 — F2 Gerçekleştirme / Uygulama ailesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Statü:** Aday family consolidation; nihai DevOS rol düzeni değildir.

## Ne yaptık?

F2'nin gerçekten ayrı bir başarı yönü olup olmadığı sınandı.

Önceki adı **Teknik Gerçekleştirme / Üretim** idi. B1–B9 taraması bu adın biraz dar olduğunu gösterdi.

Aday yeni ad:

> **F2 — Gerçekleştirme / Uygulama**

Çünkü çıktı yalnız kod olmak zorunda değildir. Ayar, adapter, hook, şablon, rol dosyası, schema, procedure, integration veya başka çalıştırılabilir/uygulanabilir artifact olabilir.

## Sonuç

**F2 ayrı bir rol ailesi olarak ayakta kalıyor.**

Ortak başarı yönü:

> Verilmiş tasarım, gereksinim ve sınırları gerçek, kullanılabilir ve sınanabilir bir sistem artefaktına veya mekanizmasına dönüştürmek.

F1 ile farkı:
- F1: ne kurulmalı / nasıl olmalı?
- F2: bunu gerçekten üret / uyarlayıp çalışabilir hâle getir.

F3 ile farkı:
- F2: mekanizmayı veya capability'yi üretir/değiştirir.
- F3: mevcut capability'yi belirli Work içinde kurar, işletir, koordine eder ve current tutar.

F5 ile farkı:
- F2 kendi yerel testini yapabilir.
- F5 bağımsız veya claim-appropriate assurance hükmünü taşır.

## B1–B9 coverage

B1–B9 içindeki mekanik sorumluluklar F2 için doğal specialization yüzeyi oluşturuyor:

| Kaynak | F2'nin gerçekleştirme nesnesi |
|---|---|
| B1 / M1 | davranış/enforcement mekanikleri |
| B2 / M2 | persistence / retrieval / exposure mekanikleri |
| B3 | actor creation/binding, role activation ve credential/runtime bağları |
| B4 / M3 | Work identity / transition / claim / dispatch mekanikleri |
| B5 / M4–M5 | runtime, workspace, isolation, tool binding, effect/readback/observability |
| B6 / M6 | exact binding, standing check, guarded-transition mekanikleri |
| B7 / M7 | Working Configuration binding / activation / lifecycle |
| B8 / M8 | continuity / handoff / stale-writer / recovery substrate |
| B9 / M9 | evaluation harness / evidence capture / test isolation |

Bu tablo M1–M9'u dokuz ayrı yazılım modülü veya dokuz ayrı geliştirici yapmaz.

## Neden F1'in alt görevi değil?

F1 tasarım çıktısı üretir. F2'nin başarı hükmü tasarımın varlığı değil, **gerçek artefaktın oluşmasıdır**.

Aynı aktör iki görevi taşıyabilir. Fakat iki sorumluluk ayrı kalmalıdır çünkü:
- iyi tasarım uygulanmamış olabilir;
- implementasyon tasarımdan sapabilir;
- implementasyon sırasında tasarımın uygulanamaz olduğu ortaya çıkabilir;
- üretici işi bitirme baskısıyla gereği sessizce daraltabilir.

Bu yüzden F2, F1'in görünmez “ve sonra uygula” eki olmamalıdır.

## Neden F3'ün alt görevi değil?

R14 veya R20 gibi F3 rollerinin amacı mevcut sistemi hazır/aktif/current tutmak veya kurulumu koordine etmektir.

Örneğin:
- mevcut adapter'ı bağlamak → F3 olabilir;
- adapter'ın kendisini geliştirmek → F2;
- mevcut configuration'ı activate etmek → F3;
- activation mechanism'ını geliştirmek → F2.

Bu sınır her durumda kod satırıyla belirlenmez. Küçük bir configuration edit'i F3 operasyonu olabilir; yeni reusable davranış/mechanism yaratıyorsa F2'ye kayar.

## Aynı aktör F1 + F2 taşıyabilir mi?

Evet.

Özellikle dar ve geri alınabilir işte, yeterli uzmanlığa sahip aynı aktör:
- çözümü tasarlayabilir;
- uygulayabilir;
- kendi geliştirme testlerini yapabilir.

Bu durumda iki ayrı fiziksel ajan gerekmez.

Ama şu ayrımlar görünür kalmalıdır:
- hangi karar tasarım kararıydı;
- hangi değişiklik implementasyondu;
- nerede tasarımdan sapıldı;
- hangi test producer self-check;
- hangi hüküm bağımsız assurance.

## Araştırma karşı-kontrolü

**Superpowers:** agreement/design ile implementation worker ve review farklı katkılar olarak tutulur. Implementer gerçekten değişikliği üretir, test eder ve raporlar; DONE kabul değildir.

**gstack:** self-development düzlemi failure → source change → generation/install → eval → release zincirini ayrı gösterir. Tarihsel ilerlemede prose'dan reusable helper/runtime rule ve E2E mekaniklerine geçiş görülür.

**Harness Engineering:** model-external runtime, context/memory plumbing, controls, orchestration ve observability yalnız talimat değildir; gerçek operating mechanisms gerektirir.

Bu kaynaklar F2'nin evrensel tek aile olduğunu kanıtlamaz. Fakat tasarım ile gerçek mechanism realization arasındaki ayrımın birden fazla örnekte yük taşıdığını gösterir.

## S1 sonucu

- **S1-09-A1:** F2 bağımsız başarı yönü taşıyan aday rol ailesidir.
- **S1-09-A2:** Adı “Teknik Gerçekleştirme / Üretim” yerine daha geniş **Gerçekleştirme / Uygulama** olarak ele alınmalıdır.
- **S1-09-A3:** Mevcut R1–R25 içinde F2'yi birincil başarı yönü olarak taşıyan aday yoktur; bu gerçek coverage açığıdır.
- **S1-09-A4:** Bu coverage açığı yeni fiziksel aktör zorunluluğu değildir. F1 veya F3 actor'ları açık F2 görevlendirmesiyle ve uygun competence/tools/authority ile taşıyabilir.
- **S1-09-A5:** F2 specialization'ları büyük ölçüde M1–M9 realization alanlarına göre oluşabilir; bu henüz kalıcı specialization taxonomy'si değildir.

## Sonraki adım

Sıradaki aile **F3 İşletim / Stewardship / Koordinasyon**.

Soru:

> R5, R11, R14, R20, R21 ve R25 gerçekten aynı “mevcut sistemi/işi doğru durumda işletme” başarı yönünün specialization'ları mı; ayrıca R4 F1'e taşındıktan sonra Information lifecycle operation tarafında sahipsiz bir sorumluluk kaldı mı?

F3 açılırken özellikle “işletmek” ile “koordine etmek” aynı family içinde kalabiliyor mu sınanacaktır.
