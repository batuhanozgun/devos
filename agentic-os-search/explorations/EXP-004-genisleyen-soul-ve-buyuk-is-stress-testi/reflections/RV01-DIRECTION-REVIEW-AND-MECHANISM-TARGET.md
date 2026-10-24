# EXP-004 / RV01 — Yön değerlendirmesi ve mekanizma sentezine dönüş

**Tarih:** 2026-09-21. **Statü:** Kullanıcının drift itirazına dayalı amaç/çıktı değerlendirmesi; assistant'ın kaynak-bağlı hükmü ve önerilen somutlaştırma yönü. Yeni DQ05/T16, bağımsız değerlendirme, tamamlanmış SOUL taslağı, mimari kabulü veya uygulama değildir.
**Başlangıç main:** `49029c8ed9027745850627a529290e079c1f09a4`.

## 1. Güncel kullanıcı yönü ve kapsam

Kullanıcı, testlerin «ne yapılmalı / neye dikkat edilmeli» düzeyinde kalmaya başladığını; kurgusal SOUL'da nasıl vücut bulacaklarının geride kaldığını söyledi. Bu teşhisi otomatik doğrulatmak istemedi; gerekli derinleşme ve drift olasılıklarının birlikte değerlendirilmesini, protokollerin yeniden yüklenmesini istedi.

Bu oturumdaki mesajdan doğrudan alıntı:

> EXP-004 çalışması, taslakda olsa bir yapı çıkarabilir, bazı şeylerin adını koyabilir şekilde tamamlanmalı, bir şeylerin adı konmuş olmalı, bir şeyler ortaya çıkmış olmalı.

Hook örneği, kod veya belirli bir ürün/API seçimi talebi değil; gerektiğinde mekanizmanın adını ve işleyişini konuşabilecek somutluk düzeyini açıklıyor. Bu alıntı korunmuş U001–U016 / S001–S015 arşivini genişletmez. Kaynak mesaj ile aşağıdaki değerlendirme ayrı tutulur.

**Güncel sonuç hedefi:** EXP-004 sonunda adlandırılmış parçaları, ilişkileri ve senaryolarda işleyen mekanizma adayları bulunan bir SOUL çalışma sistemi taslağı ortaya çıkmalı. Bunun tamamlanması, taslağın doğru/nihai mimari olarak kabulü veya yazılımın kurulması değildir. Concepts'te ortak terim kabulü beklemek, yerel çalışma adlarıyla taslak kurmayı engellemez.

## 2. Başlangıç kaydı neyi destekliyor?

[U001](../sources/conversation/USER-MESSAGES.md#u001), repository birikimini kullanarak SOUL'un oluşturacağı yapıyı düşünmeyi ister; agent, rol, iş, plan ve memory başlangıç örnekleridir. U002 büyük işi sınama koşulu yapar. Kullanıcının o sırada isimlerin kesinleşmesini beklememesi, somut işleyen taslağın süresiz ertelenmesi değildir.

Özgün [S004](../sources/conversation/assistant/S004.md), çalışma sistemi modelini sınayan beş aşamalı kavramsal yöntemi ve `represented / mechanism missing / model ambiguity / candidate primitive` ayrımlarını önerir. Özgün [S005](../sources/conversation/assistant/S005.md), konuşma içi kavramsal çalışma ile sonraki prototip/gerçek sistem denemelerini ayırırken olası çıktı olarak Mission, Work Graph, Actor Registry, Information System, Environment Registry, Binding Graph, Standing Engine, Control Model ve Transition Log adlarını verir. Bunlar o metindeki aday örneklerdir, benimsenmiş mimari değildir.

Bu nedenle mekanizmaya bağlanan taslak beklentisi yalnız bugünkü yeni bir ürün talebi değildir; başlangıç hedefiyle uyumludur. Bugünkü mesaj ayrıca çıktı ve kapanış ölçütünü daha açık hale getirir.

## 3. İki açıklamanın birlikte değerlendirilmesi

### Gerekli derinleşme açıklamasının güçlü yanı

T1–T15 ile DQ01–DQ04, sıradan bir agent+task+memory çiziminin kaybedeceği ayrımları ortaya çıkardı. Run ile Work, kanıt ile kabul, kaynak metin ile özet, rol etiketi ile gerçek yetkinlik, yerel değişiklik ile amaç yorumu ve yöntem aktarımı arasındaki farklar bir taslağı maddi biçimde değiştirebilir.

Örneğin T14'ün kaynak okuma ve bilgi aktarımı sorunu, Context Builder'ın sadece bölüm özeti toplamasına karşı dayanak verir. DQ03, değişiklik yönetiminin yalnız dosya sürümü değil kararın dayanağı ve tüketicileriyle ilgilenmesini gerektirir. DQ04, yöntem kütüphanesinden bulunan öğenin otomatik etkin talimat olmamasını ve yöntemin seçim koşullarını görünür kılar. Bunlar sonradan kullanılabilecek somut tasarım girdileridir; çalışmaların tümünün boşa veya konu dışı olduğu hükmünü desteklemez.

### Drift açıklamasının güçlü yanı

SY01 sorumluluk–temsil–mekanizma–kapasite ayrımını doğru biçimde açtı, fakat devam eden DQ zincirinde bu sorumlulukları taşıyan ortak SOUL düzeni ayrıntılanmadı. Her tur yeni bir dikkat/kanıt koşulu ve sonraki dar soru üretti. Kaynaklarda mekanizma örnekleri okundu; fakat bunların SOUL'daki taşıyıcısı, tetikleyicisi, girdi/çıktısı, yetkisi ve durum geçişi birlikte kurulmadı.

DQ01–DQ04'te aday işleyiş parçaları bulunur; «hiç mekanizma düşünülmedi» de fazla güçlüdür. Eksik olan, bu parçaların kümülatif ve sınanabilir bir çalışma sistemi taslağında birleştirilmesidir. DQ04 sonundaki yöntem çatışması sorusu ilgilidir; fakat birleşmiş taslağın önüne otomatik yeni tur olarak konmasının şu anda daha yüksek değeri gösterilmiş değildir.

### Hüküm

**İçerik tümüyle yanlış yöne gitmedi; çıktı düzeyinde ve çalışma sıralamasında drift oluştu.** Derinleşmenin faydası, somutlaştırmanın ertelenmesini tek başına haklı çıkarmaz. Şimdi aynı DQ zincirine otomatik devam etmek yerine biriken sonuçları mekanizma sentezine taşımak daha iyi destekleniyor.

Kullanıcının «hiç somut isim çıkmadı» ifadesi literal olarak doğru değildir: [CONSOLIDATION §§6,10–12](../artifacts/CONSOLIDATION.md), actionable frontier, Run/Execution Attempt, Qualification Case ve re-entry context gibi adları korur. Bunlar önceki konuşmanın türetilmiş kayıtlarıdır. Ancak adların bulunması, kullanıcının istediği bütünleşmiş taslağın tamamlandığını göstermez. Sorun yalnız sunumda birkaç İngilizce terimin eksik olması değildir.

Bu hüküm aynı assistant'ın geriye dönük kaynak karşılaştırmasıdır, bağımsız denetim değildir. Bağlam dolması veya modelin iç eğilimleri tek kök neden olarak doğrulanmadı. Gözlenen çalışma kusuru: alt-soruların bitişi, ana taslağa dönüş ve kapanış teslimatıyla bağlanmadı. Kullanıcının önceki «devam» yönleri ilgili turları yetkilendirdi; daha üst amacı ortadan kaldırmadı.

## 4. Sınırın yanlış genişletilmesi

Kabul edilmiş mimari/implementasyon üretmemek ile geçici mekanizma ve yapı adayı konuşmamak aynı şey değildir. Çıktılarda ilk sınır, pratikte ikincisini gereğinden fazla erteledi.

AGENT ve R01–R09 bu tur güncel main'den tam yeniden okundu; hiçbir kontrol dosyası değiştirilmedi. Protokoller burada davranış değerlendirmesi içindir, SOUL araştırma kanıtı değildir. Özellikle amaçla alt-hedefi, taslakla kabulü ve güven iddiasıyla mekanizma tarifini ayırmak gerekiyordu. Protokol yüklenmiş olması doğru uygulandığını kanıtlamaz; sorun daha çok protokol yazma yetkisi yaratmaz.

## 5. İstenen somutluk düzeyini gösteren ilk yapı iskeleti

Aşağıdaki adlar **bu değerlendirmede önerilen yerel taslak adlarıdır**. Bazıları önceki adayları yeniden kullanır, bazıları sorumlulukları bir araya getiren yeni çalışma adlarıdır. Concepts'in ortak tanımları, araştırmaların özgün terminolojisi veya kabul edilmiş yazılım bileşenleri olarak sunulmaz. Sekiz ayrı servis/ajan zorunluluğu yoktur; başlangıçta tek yürütücü bazı rolleri birleştirebilir.

| Aday parça | Tür ve somut işleyiş adayı | Dayanak ve açık yük |
|---|---|---|
| **Mission Contract / Work Model — Amaç ve iş modeli** | Sürümlü çalışma kaydı; kullanıcı amacı, SOUL yorumu, kabul şartları, ihtiyaçlar, Work ve karar dayanaklarını ayırır. Yeni öneri eski yetkili amacı kendiliğinden değiştirmez. | T1–T2, DQ03. Anlamsal ilişkilerin keşfi yalnız veri yapısıyla çözülmez. |
| **Work Coordinator — İş koordinatörü** | Yeni talep, Work sonucu, kaynak değişimi veya yeniden girişte mevcut durumu okur; hazır işleri ve sınırlı keşif işlerini seçer, atar, bekletir ya da yeniden açar. Açık keşfin ana karara dönüşünü takip eder. | T2/T7/T11, DQ01–DQ03. Öncelik ve ihtiyaç keşfi için muhakeme gerekir; kuyruğun varlığı yeterlik değildir. |
| **Actor/Capability Registry + Binder — Aktör/yetkinlik kaydı ve bağlama** | Rol taleplerini gerçek aktör, yöntem, araç erişimi ve kullanım-bağlı yetkinlik dayanağıyla eşler; mevcut aktör kullanımı, araç sağlama veya izinli insan katkısını seçenek yapar. | T3/T5, DQ01/DQ02. Rol etiketi uzmanlık üretmez; gerçek erişim/yetki doğrulanır. |
| **Domain Workbench — Alan üretim ve inceleme düzeni** | Roman için yazma, kaynak boyunca okuma ve editoryal karşılaştırma; soru bankası için alan araştırması, soru üretimi ve uygun kontrol Work'lerini gerçek aktör ve araçlara verir. Çıktı, kaynak gözlemi ve değerlendirme ayrı üretilir. | T12–T15/SY01. Taslak yalnız yönetim ve kontrol düzeneği olamaz; alan üretim kapasitesi açıkça yer alır. |
| **Context Builder — Bağlam kurucu** | Work sorusu, aktör ve inceleme amacı için kaynak/sürüm/statüye bağlı bir Context Package kurar; özeti yeterli bulmadığında özgün parçaları getirir. Paket, fiilen sunulan bilgi izini taşır. | T4/T8/T14, DQ02. Okuma izi anlama kanıtı değildir; gerekli ilişkiyi seçme yükü kalır. |
| **Run Controller / Qualification Gate — Yürütme denetimi ve kabul kapısı** | Work'ü Run denemesiyle bağlar. Tanımlı etki sınırlarında yetkiyi, gereken güncel Qualification Case'i ve hedef sürümü denetler; işlem sonucunu gerçek etkiyle uzlaştırır. Anlamsal hükmü uygun inceleme Work'ü ve yetkili karar sağlar. | T5/T6/T9/T10. Gate mekanik bağları korur, kendi başına doğruluk/edebî kalite oracle'ı değildir. |
| **Change & Recovery Manager — Değişim ve yeniden giriş yönetimi** | Kaynak/yöntem/karar değiştiğinde bilinen destek bağlarını inceler, etki incelemesi açar, eski hükmün kullanımını sınırlar; kesintide canonical kayıt ve gerçek etkiyi uzlaştırıp yeniden görevlendirir. | T7/T13, DQ03. Bilinen bağ grafı keşfedilmemiş bütün etkileri bulmuş sayılmaz. |
| **Method Library + Selector — Yöntem kütüphanesi ve seçimi** | Kaynak-bağlı dersleri ve aday yöntemleri kapsam/koşuluyla saklar; mevcut Work'e uygun yöntem seçimi bir öneri/karar üretir. Ortak davranışı değiştirme ayrı Change Proposal'dır. | T8, DQ02/DQ04. Retrieve edilmek aktif kural olmak değildir; yöntem birleşimi burada hedefli sınanabilir. |

Kayıt adları ile çalışan düzen ayrıdır: Mission Contract, Work, Run, Qualification Case, Context Package ve Change Proposal birer aday temsil; bunları okuyan/yazan koordinasyon, üretim, değerlendirme ve yürütme mekanizmaları ayrıca tarif edilir. Foundation ground'ları birebir servis yapılmaz. Baz SOUL ile işe özgü genişleme aynı süren düzenin farklı konfigürasyonları olabilir; ayrı deployment katmanları seçilmedi.

## 6. T08 artık mekanizma dilinde nasıl anlatılabilir?

Aşağıdaki yürüyüş, bu turun kurgusal mekanizma örneğidir; gerçek hook/API veya çalıştırılmış test değildir. `before_work_start` gibi adlar hosttan bağımsız açıklayıcı taslak etiketleridir.

1. Araştırmacı bir kapsam önerisi üretir. Artefaktın sürümü ve `henüz kabul edilmedi` durumu canonical kayıtta durur; kısa özetteki «kapsam belirlendi» cümlesi kabul otoritesi olmaz.
2. Soru üretimi Work'ünün başlama koşulu bu vakada kabul edilmiş kapsam gerektirir. Work Coordinator aktörü seçer; Context Builder kullanılacak kaynak ve durum referanslarını Context Package'a bağlar.
3. Run Controller'ın `before_work_start` kontrol noktası Qualification Gate'i çağırır. Kapı, bu Work için gerekli kabulün doğru artefakt/sürüm/kullanıma bağlı ve geçerli yetkiyle verilmiş olup olmadığını denetler.
4. Kabul yoksa ilgili üretim Work'ü başlamaz. Koordinatör, yetki içinde kapsam değerlendirmesi Work'ü açabilir. Aynı aday kaynağı inceleme amacıyla kullanmak serbest olabilir; bütün araştırma ve üretim otomatik durmaz.
5. Alan incelemesi kanıt üretir; yetkili karar kabul/ret/açık sonucunu kaydeder. Koşullar sağlanırsa asıl Work yeni Run ile başlar. Kayıt yazılması ile gerçek araç etkisi yine ayrı gözlenir.
6. Kaynak veya ilgili kabul şartı değişirse bir değişiklik olayı ilgili standing'i yeniden incelemeye taşır. Sadece hook adı bulunması yetmez: olayın kaynağı, gerekli kontrolün atlanamadığı sınır ve devam eden Run'ların geçişi taslakta açık olur.

**Hook'un işi, doğru noktada doğru kontrolü çağırmaktır; anlamsal problemi yoktan çözmek değildir.** Kanıtı kimin hangi kaynakla değerlendirdiği, kayda kimin yazabildiği ve kapının hangi etkileri gerçekten denetlediği belirtilmelidir. Kayıt sahte veya anlamsal olarak hatalıysa yalnız alan varlığına bakmak yetmez. T10'un yeni/doğrudan/dolaylı etki yolları bu mekanizmanın coverage sınamasına taşınır.

Bu örnek, «kabul durumunu korumalıyız» cümlesini tetikleyici, taşıyıcı, girdi, karar ve durum geçişine bağlar. Kod yazmadan da mekanizma düzeyinde tartışma yapılabileceğini gösterir; tam SOUL taslağını veya gate'in gerçek etkinliğini tamamlamaz.

## 7. Kapanışa yönelik önerilen çalışma

**DQ05 yöntem çatışması turu varsayılan sonraki iş olmaktan çıkarıldı.** Konu silinmedi; Method Library/Selector ve Change Manager'ın birleşim sorusu olarak taslağa taşınacak. Yeni araştırma ancak isimli bir mekanizma kararındaki açık nedeniyle açılır.

Önerilen sonraki teslimat: **MS01 — SOUL Çalışma Sistemi Taslağı v0.1.** Bu isim bir planlanan artefakt etiketidir; dosya bu tur oluşturulmadı ve çalışma tamamlandı sayılmaz.

MS01'in yeterli kapanışı şu üç çıktıyı birlikte gerektirir:

- adlandırılmış kayıtlar ve çalışan parçalar; her önemli parçanın sorumluluğu, gerçek taşıyıcı adayı, girdi/çıktı, tetiklenme noktası, yetkisi, durum etkisi ve hata yolu;
- soru bankası ve romanın aynı taslak üzerinde talep → keşif → katılım/bağlam → üretim → değerlendirme/kabul → değişim/kesinti → devam/teslim akışlarının kurgusal yürüyüşü;
- T1–T15 ve DQ01–DQ04'ün taslaktaki karşılığını gösteren kapsama tablosu; açıklanan, kısmen açıklanan ve açık kalan mekanizma/kapasite boşlukları, önemli alternatifler ve ilerideki deney ihtiyacı.

Her bulguya yeni modül veya her role ayrı ajan atamak zorunlu değildir. Bir kayıt birden fazla ihtiyacı taşıyabilir; bir çalışma parçası birden fazla mekanizmayla karşılanabilir. İki senaryonun yürüyüşü keşfedilmemiş her durumun sınandığı iddiası olmayacak.

Kapanış için tüm bilişsel yetenekleri önceden çözmek veya runtime kanıtı toplamak gerekmez; kalan belirsizlik isimli parçaya ve sınanabilir iddiaya bağlanır. Buna karşılık bütün zor yükleri adı konmuş «akıllı koordinatör halleder» kutusuna bırakmak yeterli taslak değildir. Genel prosedür, alan bilgisi, model muhakemesi, deterministik kontrol ve insan katkısının hangi işi taşıdığı açıklanır.

Bu tur current yetki: yön değerlendirmesini yapmak ve doğru statüyle korumak. Kullanıcının taslakla tamamlama hedefi kayda geçti; yukarıdaki belirli sekizli kurgu ve MS01 düzeni assistant önerisidir, kullanıcı tarafından kabul edilmiş mimari değildir. Gerçek ürün/roman/soru-bankası üretimi, kod, agent-control, Foundation, studies ve concepts değişikliği yoktur.

## 8. Okuma ve kanıt sınırı

Güncel main ref'i değişmemiş bulundu. AGENT ve R01–R09 güncel main'den tam yeniden yüklendi; uzun kontrol dosyalarında kırpılan kısımlar örtüşen okumalarla tamamlandı. Protokoller araştırma delili değildir.

Bu tur EXP-004 STATE/INDEX, USER-MESSAGES, özgün S004/S005 ve türetilmiş CONSOLIDATION tam okundu. STATE 1–40/41–111/104–165/155–EOF; INDEX 1–53/54–160 ve 119–EOF örtüşmeleriyle tamamlandı. S004 1–210/211–EOF; S005 1–180/EOF; CONSOLIDATION 1–160/161–EOF. Kaynak mesaj kesiminin geri kalanı yeniden tam okunmuş sayılmaz.

SY01 ve DQ01–DQ04 aynı konuşmadaki önceki tam okumalardan ve güncel STATE/INDEX bağlarından kullanıldı; içerikleri yeni ref'te değiştirilmedi. Önceki Foundation/studies ve özgün gstack/Hermes/OpenSpec okumaları ilgili önceki notların gerçek tam/seçici sınırlarıyla korundu; bu tur yeni dış mekanizma araştırması veya ürün güncellik taraması yapılmadı. Kullanıcı açıklama ve yön değerlendirmesi istiyor; yeni literatür kampanyası açılmadı.

Yardımcı yerel raw indirme DNS hatasıyla sonuçlandı; GitHub canonical erişimi sürdü. Yerel otomatik test veya byte-hash doğrulaması iddia edilmez.

## 9. Süreklilik

Dar değişiklik RV01, paket STATE ve INDEX'tir. T1–T15, SC02, SY01, DQ01–DQ04, kaynak konuşmalar/manifest, onarım kayıtları, Foundation, studies, concepts, önceki EXP'ler ve agent-control korunur. Kaynak kesimi 31 mesaj/16 dosya, kümülatif kaynak adresi 126 ve T testi sayısı değişmez.

STATE/INDEX yeni oturumu otomatik DQ05'e değil bu yön değerlendirmesine ve taslak sentezi hedefine götürmelidir. Bu not yayınlanmamış commit'i veya yapılmamış readback'i başarılı saymaz. Teknik yayın kontrolü, taslağın yeterliği veya bağımsız drift teşhisi değildir.
