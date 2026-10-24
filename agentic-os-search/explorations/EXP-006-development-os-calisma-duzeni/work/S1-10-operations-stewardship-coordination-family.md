# S1-10 — F3 İşletim / Stewardship / Koordinasyon ailesi

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Statü:** Aday family consolidation; nihai DevOS rol düzeni değildir.

## Ne yaptık?

R5, R11, R14, R20, R21 ve R25'in gerçekten aynı başarı yönünde olup olmadığı sınandı.

Ayrıca R4'ün F1'e taşınmasından sonra Information lifecycle'ın fiilî işletiminde coverage açığı olup olmadığı kontrol edildi.

## Sonuç

**F3 tek bir İşletim / Stewardship / Koordinasyon ailesi olarak ayakta kalıyor.**

Ortak başarı yönü:

> Tasarlanmış ve kullanılabilir hâle getirilmiş bir Work/system/capability'yi current koşullarda doğru durumda tutmak; gerekli operational geçişleri, handoff'ları ve koordinasyonu yürütmek.

Farklar işlettikleri nesnededir.

| Eski aday | F3 uzmanlığı |
|---|---|
| R5 | context/retrieval operations |
| R11 | Work admission/flow/coordination |
| R14 | Environment operations/readiness |
| R20 | Working Configuration assembly/activation/reconfiguration coordination |
| R21 | continuity/re-entry operations |
| R25 | evaluation campaign operations |

## “İşletmek” ile “koordine etmek” neden aynı familyada?

Koordinasyon burada ayrı bir amaç değil, operasyonun çok-parçalı biçimidir.

Örnek:
- R11 Work'lerin dependency/handoff akışını koordine eder.
- R20 bir Working Configuration'ın capability sahipleri üzerinden kurulmasını/aktif kalmasını koordine eder.
- R25 test campaign'inin run/evidence akışını koordine eder.

Üçünde de başarı yönü, yeni sistemi tasarlamak değil **mevcut operational nesneyi doğru durumda yürütmektir**.

Bu yüzden şimdilik ayrı “Coordinator” familyası açılmadı.

## F2 sınırı

F3 mevcut capability'yi kullanır, bağlar, aktive eder, current tutar.

Yeni reusable mechanism veya capability gerekiyorsa ilgili üretim işi F2'ye gider.

Örnek:
- hazır adapter'ı bağlamak → F3;
- adapter'ı geliştirmek → F2;
- mevcut configuration'ı activate etmek → F3;
- activation mechanism'ını değiştirmek → F2.

Küçük ayar değişikliği her zaman F2 değildir. Sınır, değişikliğin yeni reusable capability/mechanism üretip üretmediğine ve tasarlanmış operational state'i mi yoksa mekanizmanın kendisini mi değiştirdiğine göre değerlendirilir.

## Information lifecycle coverage açığı

S1-08'de R4'ün ana familyası F1'e taşındı.

R4:
- source-of-truth/lifecycle kurallarını tasarlıyor;
- update/supersede/retention/forgetting davranışının requirement'ını üretiyor.

R5 ise:
- belirli Work/Actor için context'i buluyor/seçiyor/kuruyor.

Ama şu fiilî operasyonlar açık bir AI specialization olarak görünmüyor:

- canonical bilgiyi yazma/update etme;
- supersede etme;
- archive/restore/retention uygulama;
- lifecycle kayıt/index/currentness bakımını yürütme;
- çelişki veya pending update'i doğru state'e taşıma.

Bu nedenle F3 içinde yeni aday specialization açığı:

> **Information Lifecycle Operations**

Bu mutlaka ayrı fiziksel agent değildir.

Deterministik update/archive/index işleri mekanik sistem M2 tarafından yürütülebilir. Yorum/otorite/provenance kararı gereken vakalarda F3 Information Operations görevlendirmesi gerekir.

## Araştırma karşı-kontrolü

**Hermes:** source baseline, local modification, maintenance authority, archive, ledger, rollback ve list/index/view/use zincirini ayrı operational durumlar olarak gösteriyor. Bu, Information lifecycle'ın yalnız design veya retrieval olmadığını gösteren bounded mechanism evidence'tır.

**Memory Engineering:** memory'yi write → manage → read loop olarak ele alıyor; update, contradiction, forgetting ve provenance lifecycle'ın aktif operasyonlarıdır. Bu study mimari karar vermez.

**Superpowers:** controller cross-task meaning, handoff ve unresolved iş akışını taşır; koordinasyon yalnız scheduler değildir.

**Work-management corpus:** authority, assignment, claim, liveness ve integration authority; ayrıca planning, execution ve closure standing'leri ayrıdır. Bu F3 operasyonlarını F1/F4/F5 ile collapse etmemek için design pressure sağlar.

Bu kaynaklar F3 familyasını kanıtlamaz; familya içindeki operational ayrımların gerçek örneklerde yük taşıdığını gösterir.

## F3 family contract adayı

Bir F3 görevlendirmesinde en az şunlar açık olmalı:

1. Hangi operational nesne/Work/configuration işletiliyor?
2. Current state ve authoritative record nedir?
3. Hangi geçişler meşru ve hangi koşullara bağlı?
4. Hangi dependencies/capacity/readiness bilgisi gerekir?
5. Hangi değişiklik F3 operasyonudur; hangisi F1 redesign veya F2 implementation açmalıdır?
6. Handoff/re-entry sonucu kime gider?
7. Stale/partial/unknown state nasıl görünür kalır?
8. F3 kendi operasyon başarısını F5 assurance yerine koyamaz.

## S1 sonucu

- **S1-10-A1:** R5/R11/R14/R20/R21/R25 tek F3 familyasının specialization'ları olarak modellenebilir.
- **S1-10-A2:** Coordination ayrı familya açmayı gerektirmedi; çok-parçalı operasyon biçimi olarak F3 içinde kalıyor.
- **S1-10-A3:** R4 F1'e taşındığında Information lifecycle operation gerçekten açıkta kalıyor.
- **S1-10-A4:** F3 içinde **Information Lifecycle Operations** adında yeni specialization ihtiyacı var.
- **S1-10-A5:** Bu specialization'ın bir kısmı mekanik M2 tarafından taşınabilir; yorum/yetki/provenance gerektiren kısmı AI görevlendirmesi olabilir.

## Sonraki adım

Sıradaki familya **F4 Yönetişim / Kontrol**.

Soru:

> R9 Actor Governance ile R17 Cross-Ground Control gerçekten aynı başarı yönünün iki specialization'ı mı; yoksa authority/governance ile operational control/enforcement ayrı familyalar mı olmalı?

F4'te insan müşterinin **yetki** çekirdeği ile AI governance rolünün sınırı özellikle kontrol edilecektir.
