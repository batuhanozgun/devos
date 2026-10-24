# Taslak 01 — Roman analojisi / ikinci yazım

- Durum: Batu, önceki gövdenin üslubunu çok iyi bulduğunu ve biraz daha rahat kullanılabileceğini belirtti. Bu tur ilk dört paragraf aynen korundu; çözümden araştırmaya geçişi somutlaştıran kapanış ve doğrudan kaynak bağlantısı eklendi. Kapanış revizyonunun değerlendirmesi ve nihai yayın onayı bekleniyor.
- Kaynak analoji: [Roman analojisi](../01-roman-analojisi-kullanici-talebinden-yasayan-is-tanimina.md)
- Kaynak konuşma: [EXP-001 U004–U006](../../../../explorations/EXP-001-soul-calisma-modeli/sources/conversation/USER-MESSAGES.md#u004).
- Doğrudan yazar referansı: [LLM Düşünmez — Batu'nun yazdığı makale](../../articles/2026-09-11-llm-dusunmez-zaxzf.md). Özellikle bilmediği alanda AI kullanma beklentisi, örneği açma biçimi ve cümle/paragraf akışı. Makaledeki teknik iddialar bu üslup çalışmasıyla doğrulanmış sayılmaz.
- Önceki taslak: [01-roman-analojisi.md](01-roman-analojisi.md). Bu dosyanın önceki gövdesi de Git geçmişinde korunur; yeni sürüm için farklı dosya açılmadı.
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md). Assistant'ın rehber için ürettiği örnekler, Batu'nun özgün yazıları yerine üslup kanıtı sayılmadı.
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 2765 — boşluklar, satır sonları ve gövdedeki kaynak URL'si dahil; dosyanın son satır sonu hariç.
- Üst sınır: 2800

## Araştırma dayanağı — post gövdesine dahil değil

[Work-management çapraz sentezi](../../../../research/studies/work-management-project-control/08-CROSS-UNIT-SYNTHESIS.md), Beads'ın dependency/ready-frontier, OpenSpec'in living-plan ve Flowable'ın olay/koşul temelli yürütme mekanizmalarını birbirinden ayırır. [Flowable bulguları §5, §10–11](../../../../research/studies/flowable/FINDINGS.md), olayla etkinleşme/sonlandırma ile çalışan işin yeniden planlanmasının yalnız plan belgesini değiştirmek olmadığını gösteren kaynak-bazlı karşılaştırmadır. Bu ürünlerin birlikte seçildiği veya görev gerekçesindeki anlamsal değişimi kendiliğinden keşfettikleri ileri sürülmez.

DevOS'a hazırlanan tarihsel [P2-01 rol sözleşmelerinde](../../../../explorations/EXP-006-development-os-calisma-duzeni/work/P2-01-named-role-contracts.md) DR07 bilgi değişimi ve etkilenen tüketicileri, DR14 etki/invalidation kapsamını, DR01 plan revizyonunu, DR06 yürütme durumunun uzlaştırılmasını, DR08 yeni bağlamı taşır. Bunlar aday tasarım kayıtlarıdır; güncel kurulum kadrosu veya çalışan sistem kanıtı değildir. [SOUL ve DevOS raporu §22.4, §22.6, §22.8, §22.10](../../../../archives/devos-pre-claude-2026-09-29/soul-and-devos/SOUL_ve_DevOS.md), Loop/Context/Graph/Workflow Engineering ve Orchestration ilişkisini ayrıca açıklar.

**3 Ekim 2026 — kapanış için güncel dış kaynak kontrolü.** [Flowable Open Source — CMMN 1.1, “Exit criterion (exit sentry)”](https://www.flowable.com/open-source/docs/cmmn/ch06-cmmn), plan öğelerinin yaşam döngüsü olayları ve koşullarla sonlandırılmasını açıklar. Aynı sayfanın “Sentry evaluation” bölümü, ilgili durum/veri değişiklikleri üzerine kuralların yeniden değerlendirilmesini anlatır. Bu bağlantı yalnız editoryal notta bırakılmadı; okurun araştırmaya devam edebilmesi için post gövdesine de alındı. Flowable burada seçilmiş DevOS bağımlılığı değil, belirli bir mekanizma için incelenebilir uygulama örneğidir.

[NASA — Requirements Management §6.2](https://www.nasa.gov/reference/6-2-requirements-management/) bu tur yeniden okundu: gereksinim/dayanak izlenebilirliği, değişiklik etkisinin değerlendirilmesi, yetkili değişiklik ve ilgili taraflara iletim için dış dayanak sağlar. Posttaki dependency tracking, yalnız görev sırası değil, görevin dayandığı koşul ve gerekçe ilişkisini izleme ihtiyacını ifade eder; bu kullanım NASA'nın traceability yaklaşımıyla birlikte okunmalıdır. [Lewis ve diğerleri — Retrieval-Augmented Generation](https://arxiv.org/abs/2005.11401) önceki revizyondan korunan karşılaştırma kaynağıdır; bu tur tekrar doğrulanmadı ve post ayrı bir RAG tartışması açmaz.

**Sınır:** CMMN, kendisine tanımlanmış olay/koşulları işler; yayıncı bilgisinin iş açısından anlamını kendiliğinden keşfetmesi iddia edilmez. Bir plan öğesinin sonlanması, bağımsız bir agent sürecinin otomatik olarak durduğu anlamına da gelmez; kararın o çalışana uygulanması ayrıca bağlanmalıdır. Görev gerekçesinin değerlendirilmesi, yetkili plan değişikliği ve yürütmeye uygulanması ayrıdır. Bu tur yalnız kaynak kontrolü ve yazı revizyonu yapıldı; Flowable kurulmadı, örnek yürütülmedi. Tek ürünle tamamlanmış çözüm, SOUL'a özgü kanıtlanmış buluş veya üretimde sınanmış entegrasyon iddiası yoktur. Roman/yayıncı durumu varsayımsal örnektir.

---

Ben yapay zekâya sadece nasıl yapılacağını bildiğim işleri daha hızlı yaptırmak istemiyorum. Bilmediğim bir işi de ele alabilsin istiyorum ama o zaman karşısına koyacağım talebin eksik olacağını da kabul etmem lazım. Bilmediğim şeyi eksiksiz tarif etmem zaten nasıl mümkün olacak?

Mesela roman yazmak istiyorum desem, aklımda konu var, karakterler var, hikâyenin nerede başlayıp nerede biteceği var ama kitabın bir dükkânda rafa nasıl girdiğini bilmiyorum. Ben hâlâ romanı yazma derdindeyim, sistem de sadece yazmaya odaklanırsa sonunda elimde güzel bir Word dosyası olur. Sonra? Kitabı kim basacak, kim dağıtacak, kim okuyacak? Bunları baştan söylemedim diye ihtiyacım ortadan kalkmadı. Tabii kendim için yazıyorsam da durup dururken yayıncı aramasın; neyi istediğimizi birlikte ortaya çıkarmamız gerekiyor.

Burada “tamam, önce bütün işi tanımlayalım sonra başlayalım” demek kolay ama o da başka bir yere takılıyor. Dağıtımcıyı bulmadan ilk bölümü yazamayacak mıyız? Romanın konusu netse yazabiliriz, dağıtım konusu da bir kenarda durur. İnsan olarak bunu yapabiliyorum; bir yandan yazarken bir yandan da “bunu nasıl yayımlatacağım acaba?” diye düşünüyorum. Agent'lardan oluşan bir ekipte bu bağlantıyı nasıl kuracağız?

Bir agent romanı yazsın, biri yayıncıları incelesin, başka biri de dağıtımcıları araştırsın. Sonra yayıncıları inceleyen, seçtiğimiz yayıncının dağıtımı da yaptığını öğrensin. (Her yayıncı böyle çalışıyor demiyorum, örneğimizde öyle olsun.) O zaman dağıtımcı arayanın işi kalmadı. Ama ona kim söyleyecek? Bulgu dosyaya yazıldı diye diğer agent'ın işi bırakmasını sağlayan bir şey yoksa araştırmaya devam eder, belki de çok güzel bir rapor getirir. Ben de okuyup “eline sağlık ama buna artık gerek kalmadı” derim.

Oysa başta o işi vermek yanlış değildi; öğrendiğimiz şey işi gereksiz hale getirdi. Bu yüzden görevin yanına neden var olduğunu da koymak gerekiyor: “Dağıtım henüz çözülmediği için dağıtımcı ara.” Yeni bilgi gelince bu gerekçeyi yeniden değerlendir, gerekiyorsa planı değiştir. İsimlerini de vereyim: dependency tracking, change impact analysis ve replanning.

Somut bir yerden bakmak için Flowable'ın CMMN dokümanındaki “Exit criterion (exit sentry)” bölümünü açabilirsiniz. Bir işi hangi olay ve koşulun sonlandıracağını tanımlıyor. Bizde karşılığı, yayıncının dağıtımı üstlendiği doğrulanıp kabul edilince dağıtımcı arama görevini sonlandırmak olabilir.

Tabii Flowable kurunca agent kendiliğinden “bu işe gerek kalmadı” demiyor. O değerlendirmeyi yapan tarafı, plan değişikliğini ve dışarıda çalışan agent'ın gerçekten durmasını birbirine bağlamak gerekiyor. Benim aradığım da bu; yoksa dağıtımcı aramayı bırakmasını söylemek için yine benim araya girmem gerekecek.

https://www.flowable.com/open-source/docs/cmmn/ch06-cmmn
