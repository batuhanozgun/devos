# S1-02 — Aktör özellikleri, rolün başarı yönü ve aktöre göre uyarlama

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst çalışma:** [S1](S1-role-responsibility-consolidation.md) · [S1-01](S1-01-production-review-correction.md)
**Tarih:** 25 Eylül 2026.
**Statü:** Kullanıcı itirazını değerlendiren sınırlı kaynak incelemesi ve aday açıklama. Nihai rol düzeni, kullanıcı kabulü veya davranış deneyi değildir.
**Güncel görev:** S1-01'in ilk üç ayrımını aktörün özellikleri ve çatışan başarı yönleri açısından yeniden değerlendirmek; G1 geliştirme sorumluluğu açıklığını anlatmak; önce mevcut Keel araştırmasına, sonra ilgili asıl dosyalara bakmak.

## 1. Kullanıcı neyi ekledi?

Aşağıdakiler kullanıcı mesajının anlam özeti; kelimesi kelimesine aktarım değildir:

- İnsan ile bir dil modelinin rol üstlenmesi aynı koşullarda gerçekleşmez. Dil modelinin bağlamı, girdileri ve çıktısını yönlendiren ifadeler önemlidir.
- Bir rolün akıl yürütmesi çatışan motivasyonlarla iki yöne çekilmemelidir. Rol ailesi oluşturulabilir; bu, aynı çalışma anında birbirine ters başarı yönlerini birleştirme gerekçesi değildir.
- Rolün işletilme biçimi aktör türüne göre uyarlanmalıdır. Aktör özelliklerini önce tanımlamak ile rol belirlendikten sonra uyarlamak arasındaki sıra açıktır.
- S1-01/G1'de tam olarak hangi geliştirme sorumluluğunun açık kaldığı anlaşılmamıştır; açıklama istenmiştir.
- Keel, önce araştırma deposundaki kayıt üzerinden ve ardından asıl kaynakta incelenmek üzere önerilmiştir.

Bunlar bütün ayrıntıları kabul edilmiş mimari kurallar veya deneysel olarak kanıtlanmış model yasaları değildir. Yeni mesaj, daha önce önerilmiş geniş G1 ayrıştırmasının otomatik sürdürülmesini değil bu soruların cevaplanmasını önceler.

## 2. Keel'de bulunan somut karşılık

Önce [Keel okuma defteri](../../../research/soul-context/repos/keel/README.md) tam okundu. Bu kayıt studies altında değil, tarihsel proje bağlamı içinde bulunuyor; yeni bir studies paketi oluşturulmadı.

Bağlı GitHub erişiminde Keel main başı `669c5445cf34dcf15ed4f4d435b5f3657077550a` olarak alındı. Aşağıdaki asıl dosyalar bu değişmez sürümden incelendi:

- **G2:** Rolün yokluğunda hangi işin sahipsiz kalacağı, araç profili, rolün işinin hangi hata eğilimini tetikleyebileceği ve komşu rolden ayrımı birlikte soruluyor. Genel aktör eğiliminden role özgü kontrol çıkarma yönü açık.
- **Sözleşme kalıbı:** Motivasyon, yazma yetkisi, ek okumalar, iş akışı, bekleme/devretme, olumsuz sınırlar ve gerektiğinde uyanma tetiği ayrı alanlar. Motivasyon tek başına rolün bütün tanımı değil.
- **Rol açılış kalıbı:** Rol sözleşmesi, güncel rol durumu ve pano üzerinden bağlamın yeniden kurulması tarif ediliyor. İnsan tarafından çağrılan bu yol, bütün olası otonom işletimin açıklaması değildir.
- **Doğrulayıcı dosyası:** Araç bildirimi yalnız Read/Grep/Glob. Dosya gerçeğini sınamakla uygulamayı çalıştırarak sınamak ayrılmış; doğrulanamayanı olumlu saymama ve kendi yaptığı işe karne vermeme yükümlülükleri var.
- **Defo modeli:** Ortak hata eğilimlerinden gözlenebilir iz ve kontrol ihtiyacı çıkarılıyor. Ancak bütün kusurları tek anlık onay itkisiyle açıklayan kök model, bu okumayla bilimsel olarak doğrulanmış olmaz.

**Aktarım:** Rol adı ve motivasyon metni, bilgiye erişim ve gerçek eylem sınırlarıyla birlikte düşünülmeli.
**Sınır:** Kaynakta araç listesi veya kontrol tarifi bulunması, burada çalışan ortamın ya da kontrol etkinliğinin sınandığı anlamına gelmez. Betikler, testler veya canlı modeller çalıştırılmadı; Keel kurulmadı. Keel'in sabit kadro, insan onayı, rol açma ve kurulum kuralları EXP-006'ya alınmadı.

## 3. Tek motivasyon ifadesini hangi sınırla kullanıyoruz?

**Aday ilke:** Bir etkin rol görevlendirmesinin başarı yönü açık ve kendi içinde tutarlı olmalı; çatışan hedeflerin nasıl çözüleceği belirsiz bırakılmamalı.

Bu, tek görev, tek ölçüt veya tek bilgi alanı demek değildir. Gereksinime uygunluk ile hata dayanıklılığını incelemek aynı doğruluk sorusunun parçaları olabilir. Buna karşılık tarafsız yeterlik hükmü vermek ile ne pahasına olursa olsun teslimatı kapatmak, aynı sonuca farklı teşviklerle yaklaşabilir.

İnceleyicinin amacı mutlaka hata bulmak veya mutlaka onaylamak değil, kanıtın desteklediği hükmü vermektir. Kusur uydurmak da doğru kusuru örtmek de başarısızlıktır.

Kullanıcının iki motivasyonun verimi azaltacağı hipotezi ciddiye alınır; fakat her model ve işte iki ölçütün birlikte verimsiz olduğu sonucu çıkarılmaz. İncelenen kaynaklar böyle evrensel bir yasa göstermiyor.

## 4. Aktör, aile, rol ve etkin görevlendirme

[Foundation aktör bulgusu](../../../research/soul-foundations/01_verticals/actors/findings/IDENTITY-ROLE-PARTICIPATION.md), kalıcı aktör, atanmış rol ve belirli olayda etkin rol ayrımını koruyor. Bu, motivasyonun model üzerindeki etkisinin deneysel kanıtı değildir; analiz düzeylerini ayırmaya yarar.

Tek ve zorunlu bir aktör > aile > rol ağacı kabul edilmedi. Geçici çalışma ayrımı:

- **Aktör özellikleri:** Rolü taşıyan tarafın kabiliyetleri, sınırları ve çalışma koşulları.
- **Rol ailesi:** Benzer sorumlulukları karşılaştırmak ve yeniden kullanmak için sınıflandırma.
- **Rol:** Amaç, sorumluluk, yetki, çıktı ve sınama beklentisi.
- **Etkin görevlendirme:** Belirli aktörün, belirli işte hangi rolle, hangi bağlam ve araç koşullarıyla çalıştığı.

Bir ailede olmak, aynı çağrıda etkin olmak değildir. Aynı temel model farklı görevlendirmelerde kullanılabilir; farklı çağrı veya rol adı da kendiliğinden bağımsız kanıt üretmez.

**Uyarlama sırası adayı:** Önce aktör sınıfının karar açısından önemli koşullarını kabaca belirle; işten rol sorumluluğunu çıkar; sonra somut model/oturum/araç düzeniyle eşleştirip sınama ihtiyacını belirle. Bütün modellerin eksiksiz envanterini çıkarmadan rol çalışmasına devam edilebilir.

Burada kullanıcının uyarlama önerisi model ağırlıklarını yeniden eğitme kararı olarak yorumlanmadı. Bağlam, yönerge, örnek, araç sınırı, tetik ve devir koşullarını uyarlamak da ayrı seçeneklerdir. Aktör yetersizse rolün kalite veya yetki sınırı sessizce gevşetilmez.

## 5. S1-01 sonuçlarına etkisi

| Önceki aday | Bu değerlendirmeyle koşulu |
|---|---|
| A1: ortak inceleme ailesi | Aile korunabilir; etkin rolün tutarlı başarı yönü, yeterliği, erişimi ve kanıt ihtiyacı ayrıca gösterilir. Altı başlık tek çağrıda zorunlu birleştirilmez. |
| A2: üretim ve düzeltme aynı ailede | Aynı ürünü gereksinime uygun hâle getirme yönünde birlikte düşünülebilir. Düzelticinin yaptığı değişiklik için bağımsız kabul makamı olduğu varsayılmaz. |
| A3: teşhis, karar ve uygulama ayrımı | Amaç ayrımı, aktörün bağlam ve yetki ayrımıyla birlikte ele alınır. Aynı modelin farklı görevlendirmeleri olasıdır; tek uzman veya belirli ajan sayısı ilan edilmez. |
| A4: yeni sürüm ve bütünleştirme | Rol geçişi de sürüm ve kanıt bağı kadar görünür olmalı; eski inceleme hükmü düzeltmeyle otomatik taşınmaz. |

## 6. G1'in sade açıklaması

Takılınan konu bellek mekanizmasının şu anda nasıl kodlanacağı değil, **bu kodu üretme işini DevOS içinde kimin taşıdığıdır**.

Örnek:

1. SOUL'un hangi bilgiyi koruması gerektiğini belirlemek: gereksinim/tasarım.
2. Gerekli saklama, erişim, sürüm ve izin davranışını sağlayan kodu veya bağlantıyı geliştirmek: üretim/uyarlama.
3. Ortaya çıkan şeyi ilgili ortamda kurup bağlamak: kurulum/bütünleştirme.
4. Gerçek davranışın gereksinimi karşıladığını sınamak: doğrulama.

S1-01, özellikle ikinci işin diğerlerine göre daha örtük kaldığını saptadı. Hazır araç kullanılacaksa yazılacak kod azalabilir; yine de seçme, uyarlama ve bağlantıyı gerçekleştirme sorumluluğu ortadan kalkmaz. Bu işler tek yeterli rolce veya farklı rollerce taşınabilir. G1, zorunlu yeni bir R26 gerektirmiyor; aktarım zincirinin sorumluluğunu açıklaştırma ihtiyacıdır.

## 7. Dış bilgi kontrolünün sınırı

- Anthropic, *Effective context engineering for AI agents* (29 Eylül 2025): yönergenin yanında araç tanımı, dış bilgi ve konuşma geçmişinin de modelin çalışma bağlamı olduğunu açıklıyor. Bu, yalnız kritik sözcük seçimine indirgememek için kullanıldı; tek motivasyon yasasının kanıtı değil. https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- Zheng ve diğerleri, EMNLP 2024 rol kişilikleri çalışması: yayın sayfasındaki özet okundu. İncelenen olgusal sorularda yalnız kişilik/rol eklemek genel performans artışı sağlamıyor. Sonuç uzun soluklu DevOS rol tasarımının bütünü hakkında genellenmedi; makalenin tamamı veya deney kodu bu tur incelenmedi. https://aclanthology.org/2024.findings-emnlp.888/

Bu iki dış kaynak ayrı araştırma programına dönüştürülmedi; yalnız bu yorumun kapsamını sınırlayan girdilerdir.

## 8. Okuma izi ve dönüş

| Kaynak | Kapsam / blob |
|---|---|
| Keel araştırma defteri | Tam; `03fd666c8bd76c530d360f621204a82ec23dd094`. |
| Keel README | Tam, default main; `a221d174f7422a32dbd369e8516d8b7aa31b3a92`. |
| Keel GENESIS | Tam; `a04b80607915644ea56524d2fa87c6177f34949d`. |
| Keel G2 | Tam; `89ff8a748b78e769ae277e5ef47108ccaa1fe2ea`. |
| Keel SOZLESME_KALIBI | İlk çıktı sonlara doğru kesildi; 100–260 aralığı ile EOF tamamlandı; `f37a3d0a3f609b18beae923ceb4a9d791515abb3`. |
| Keel DEFO_MODELI | Tam; `e9bddf5e04e13d90dbb6014eb432fba18357f6ac`. |
| Keel ROL_SKILL_KALIBI | Tam; `92d04fef17838cfce3bcbc1c6d1951b821f1e230`. |
| Keel dogrulayici | Tam; `6027a3045cc820eb4f87fa18c6750ff9dc0dca5f`. |
| Foundation IDENTITY-ROLE-PARTICIPATION | Tam; `0b3e47ca2a9b0db2798b604e905629acc7b8263d`. |

Keel'de doğrudan motivasyon araması sonuç vermedi; yokluk çıkarılmadı, araştırma defterinin asıl dosya rotaları kullanıldı. Asıl Keel dosyaları README dışındaki okumalar için yukarıdaki main commit'ine sabitlendi. Kontrol protokolleri araştırma kanıtı olarak kullanılmadı.

**Dönüş:** Bu açıklamayı kullanıcıyla değerlendir. G1'in geniş sorumluluk eşlemesi henüz yapılmadı. S1'in devamında rol birleştirme/ayırma gerekçesine başarı yönü uyumu ve somut aktöre göre işletilme koşulları da eklenir; nihai aile sayısı, ajan sayısı, eğitim, kurulum veya mimari seçimi yapılmaz.
