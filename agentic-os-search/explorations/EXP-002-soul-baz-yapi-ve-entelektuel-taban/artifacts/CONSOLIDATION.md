# EXP-002 — SOUL'un baz yapısı ve ortak entelektüel tabanı

**Tür:** Görünür diyalogdan türetilmiş konsolidasyon, v0.1. **Kaynak:** U001–U019 / S001–S018. **Statü:** Kullanıcı tercihleri, birlikte geliştirilmiş çalışma görüşleri ve açık tasarım ihtimalleri. Bu belge nihai ürün tanımı, Foundation sonucu, teknik şartname veya kurulum yetkisi değildir.

[Özgün diyalog](../sources/conversation/INDEX.md) · [EXP-001 devri](../sources/PREDECESSOR-EXP001.md) · [Sonradan yapılan nitelendirmeler](../reflections/QUALIFICATIONS.md)

## 1. Bu konuşmanın ne için yapıldığı

Batu dört soruyla ikinci denemeyi başlattı: ilk denemeyi hatırlamak; assistant'ın SOUL tanımını görmek; bu tanımı somut çalışma kavramlarıyla açmak; araştırma birikiminin bu hayale ne kadar yön verebildiğini değerlendirmek. Konuşmanın basit cümlelerle ve her seferinde bir dal açılarak ilerlemesi istendi. Birden fazla hazır mimari seçeneğini aynı anda tartışmak yerine, tanımın anlamı örneklerle yavaşça geliştirildi.

EXP-001'den gelen zemin, SOUL'un yalnız verilen görevleri yapan bir ajan olmamasıydı. Talebin daha yeterli bir çalışma anlayışına dönüşmesi, uzmanların henüz söylenmemiş işleri keşfetmesi, çalışma standartlarının ve uzmanlığın oturumların ötesinde sürmesi, C/plan/gerçek Work'ün birlikte değişmesi daha önce konuşulmuştu. EXP-002 bu zemini devraldı; onu yeniden doğruladığını iddia etmedi.

**Kaynak:** [U001](../sources/conversation/USER-MESSAGES.md#u001), [S001](../sources/conversation/assistant/S001.md), [önceki denemeden devir](../sources/PREDECESSOR-EXP001.md).

## 2. İlk derinleşme: fonksiyon değil başarı yönü

Batu'nun “bir agent'ın motivasyonu tek olmalı” cümlesi önce genel bir üst görev ve kısıtlar olarak yorumlandı. Yazılımcı/test örneği bu yorumun yetersizliğini gösterdi. Kullanıcının ayırmak istediği şey, aynı aktörün kaç işlem yapabildiği değildi. Üretimin bitmesine doğru ilerleyen yön ile üretilen şeyin kabulünü zorlaştırabilecek kusurları arayan yönün birbirini bozmasıydı.

Bir üretici gereksinimi anlayabilir, kod yazabilir, çalıştırabilir ve hata düzeltebilir. İşlevleri çoktur. Ayrı bir doğrulama rolü ise üreticinin “neredeyse bitti” anlayışına bağlanmadan doğruluğu sorgulayabilmelidir. Bir kusur bulması işi yeniden açsa da bunun için cezalandırılmış bir başarı tanımı taşımamalıdır.

Konuşma sonunda ayrım fiziksel modelin kendisine değil, belirli işte üstlenilen role taşındı: aynı temel model başka çağrılarda farklı roller alabilir; o anda hangi amaç ve yetkiyle çalıştığı belirsiz olmamalıdır. “Tek terminal amaç” bu bağlamda çalışma önerisi olarak kullanıldı. Her işlev için ayrı ajan veya her ajan için ömür boyu değişmez tek rol kararlaştırılmadı.

**Kaynak:** [U002–U004](../sources/conversation/USER-MESSAGES.md#u002), [S002](../sources/conversation/assistant/S002.md), [S003](../sources/conversation/assistant/S003.md), [S004](../sources/conversation/assistant/S004.md). Doğrulama rolünün yalnız ret üretmeye indirgenmemesi ve ayrılığın tek başına bağımsızlık kanıtı olmaması [nitelendirmelerde](../reflections/QUALIFICATIONS.md) ayrıca korunur.

## 3. SOUL'un üzerinde uzlaşılan geçici resmi

Assistant'ın sunduğu kısa çalışma tanımı şuydu:

> SOUL, bir insanın istediği sonucu gerçekleştirebilmek için gereken çalışma sistemini anlayan, gerektiğinde kuran, işleten, gözlemleyen ve değişen koşullara göre yeniden düzenleyen yapıdır.

Batu bu tanımda kendisi açısından sorun görmediğini söyledi. Bu uygunluk, tanımın somut mimari seçimlerini de kabul ettiği anlamına gelmez. Konuşmanın nesnesi yine “SOUL'un ne olabileceği” idi.

Burada SOUL'un akıl yürütmesi iki alana uzanıyor: istenen işi anlamak ve onu gerçekleştirebilecek çalışma düzenini oluşturmak. Çalışma düzeni; gerekli işler, roller, bilgi, araçlar, ortam, yetki, doğrulama ve devam koşullarıyla ilgili olabilir. Sadece “şu ajanlar çalışsın” listesi veya bir plan dosyası olmak zorunda değildir. Kurulumun gerçekleşmesi ve sistemin işlemesi de düşüncenin içindedir.

Bu oluşturma kapasitesine geçici olarak System Formation / Work-System Synthesis dendi. Tek bir servis, yönetici ajan veya sabit modül olduğu kararlaştırılmadı. SOUL'un görevi mümkün olduğunca çok sistem kurmak değil, istenen sonucun gerektirdiği düzeni oluşturmak olarak düşünüldü.

**Kaynak:** [S006](../sources/conversation/assistant/S006.md), [U007](../sources/conversation/USER-MESSAGES.md#u007), [S007](../sources/conversation/assistant/S007.md).

## 4. ABC örneği: kurulan sistem de anlamaya katılır

Batu düşünceyi kullanıcının yaşayacağı bir sahneye indirdi. SOUL'a “ABC istiyorum” denir. SOUL sorular sorar ve ilk çalışma sistemini kurar. Örnekte dört ajan vardır; bunlar sayısal veya teknik gereklilik değildir. İlk ekip problemi daha iyi anlamak için çalışır. Yeni sorumluluklar ve bilgi erişim ihtiyaçları buldukça çalışma sistemi genişletilir veya değiştirilir.

Bilgi büyüdüğünde RAG kurulması, bu değişimi anlatan bir örnekti. Konuşmadaki daha önemli ayrım teknoloji adından önce ihtiyacın görülmesiydi: mevcut bilgi erişim düzeni bu çalışma için yetersiz mi; sorun ne; hangi seçenek bunu giderebilir? RAG adı, otomatik cevap veya bütün bellek sorunlarının çözümü olmadı.

İşi anlamak ile istenen sonucu üretmek aynı şey değildir. Fakat bu, bütün keşif bitmeden hiçbir üretime başlanamaz demek de değildir. Anlamak, kurmak, çalışmak ve yeni bilgiyle düzeni değiştirmek birbirini besleyebilir. Bu nokta EXP-001'deki C ↔ plan ↔ Work anlayışına bağlanır.

Ayrıca SOUL'un kurduğu sistemin her parçası ajan olmak zorunda değildir. Roller, insan katılımı, mevcut ekipler, araçlar ve deterministik süreçler de seçenekler arasında anıldı. Kullanıcının “agent” kelimesini bazen rolü, bazen dosyalardan oluşan rol paketini, bazen çalışabilir birimi anlatmak için kullandığı açıkça kaydedildi.

**Kaynak:** [U008–U010](../sources/conversation/USER-MESSAGES.md#u008), [S008](../sources/conversation/assistant/S008.md), [S009](../sources/conversation/assistant/S009.md), [S010](../sources/conversation/assistant/S010.md).

## 5. Henüz talep yokken baz SOUL

Kullanıcı bu kez hiçbir talep gelmemiş halde SOUL'un nelerden oluşabileceğini sordu. Assistant, gerektiğinde çalışma sistemi oluşturabilecek bir baz yapı hayal etti. Bu taslakta kimlik ve yetki sınırları, kendi runtime/harness'ı, oluşturma muhakemesi, mevcut kapasitelere ilişkin bilgi, rol/aktör kurma kabiliyeti, kalıcı kayıtlar, çalışma alanı hazırlama, doğrulama/gözlem ve devam/kurtarma sorumlulukları yer aldı.

Bu liste dokuz zorunlu servis önermez. Sabit uzmanların ne kadarının hazır bulunacağı açık bırakıldı. Başta bir görev için ayrı RAG sistemi veya belirli sayıda uzman tutmamak, gerektiğinde bunları oluşturabilmekten farklıdır. Öte yandan bazı iç sorumlulukların talep öncesinde hazır bulunması ihtimali de korundu.

Burada “SOUL harness değildir” cümlesinin anlamı netleşti: SOUL'u yalnız harness kavramına indirgememek. SOUL'un kendisinin bir harness kullanmasıyla, kullanıcı işi için başka çalışma düzenlerini oluşturabilmesi çelişmez. İki ayrı fiziksel altyapı zorunluluğu da çıkarılmadı.

**Kaynak:** [U011](../sources/conversation/USER-MESSAGES.md#u011), [S011](../sources/conversation/assistant/S011.md), [S008](../sources/conversation/assistant/S008.md). Küçük çekirdek ve sabit rol sayısı önerilerinin sınırı [QUALIFICATIONS](../reflections/QUALIFICATIONS.md) içindedir.

## 6. İkinci ana derinleşme: birikim yalnız merkezde kalmasın

Batu baz SOUL resmine önemli bir ek yaptı. Yüksek akıl yürütme ve araştırma birikimi yalnız sistemi kuran tarafta kalmamalı; oluşturulan akıl yürüten aktörlerde de bulunmalıydı. İstenen şey sadece aynı güçlü modeli çağırmak değildi.

Araştırmanın repository'de erişilebilir olması bir koşuldur. Aktörün böyle bir bilgi bulunduğunu bilmesi, hangi durumda işe yarayabileceğini fark etmesi ve doğru biçimde kullanmaya yönelmesi başka koşullardır. Memory örneğinde aktörün “RAG kullanabilirsin” talimatını ezberlemesinden ziyade, alternatifleri ve ilgili çalışmaların varlığını bilen bir problem anlayışı isteniyordu.

Assistant bunu çalışma kültürü, kurumsallaşmış bilgi ve entelektüel miras kelimeleriyle açıkladı. Genel model kapasitesi üzerine SOUL'un çalışma birikimi, rolün amacı/yetkisi ve güncel iş bağlamı eklenebileceği düşünüldü. Bazı temel ayrımların başlangıçta kullanılabilir, ayrıntılı kanıtların ise gerektiğinde geri çağrılabilir olması bir seçenek olarak bırakıldı.

Bu anlatım model ağırlıklarının güncellendiğini göstermez. Prompt, dosya, retrieval, beceri paketi, model uyarlaması veya başka bir mekanizmanın seçimi yapılmadı. İstenen davranış ile onu doğuracak mekanizma ayrı kaldı.

**Kaynak:** [U012](../sources/conversation/USER-MESSAGES.md#u012), [S012](../sources/conversation/assistant/S012.md). EXP-001'deki uzmanlık sürekliliği ile bağı [PREDECESSOR](../sources/PREDECESSOR-EXP001.md) içindedir.

## 7. Futbolcu kartı: üç ayrı eksen

Batu sporcu kartı benzetmesiyle düşünceyi geliştirdi. Forvetin ve kalecinin uzmanlık özellikleri farklı olabilir; fakat bazı genel yeteneklerin bütün takımda yüksek olması istenir. Sonra örneği güçlendirdi: yalnız dayanıklılık değil, oyun görüşü, rakibi okuma, takım davranışı ve başka genel kapasiteler de tüm oyuncularda yüksek olsun.

SOUL karşılığı üç ayrı eksen oldu:

| Eksen | Konuşmadaki anlamı |
|---|---|
| Ortak entelektüel taban | Problem ve sistem görüşü, araştırmayı kullanma, kanıt/varsayım ayrımı, belirsizlik ve bağlam farkındalığı, yeni bilgiyle güncelleme, diğer sorumlulukları hesaba katma. |
| Role özgü yeterlilik | Güvenlik analizi, kod üretimi veya başka bir uzmanlıkta işin gerektirdiği kapasite. Her rol aynı uzmanlık profiline sahip olmak zorunda değil. |
| Rolün başarı yönü | Belirli katkının ne için yapıldığı; yetenek puanı değil amaç/sorumluluk yönü. |

Böylece “dar amaçlı ama dar görüşlü olmayan aktör” ifadesine ulaşıldı. Bir verifier test yüzeyinin yetersizliğini veya başka bir uzman ihtiyacını görebilir. Bunu görmesi, kendi yetkisini genişletmesi veya başka işi kendiliğinden üstlenmesi değildir.

Karttaki 9/10 veya 10/10 değerleri ölçüm değildi. “SOUL-native intellectual baseline” da onaylanmış bir benchmark veya uygulama bileşeni olmadı. Hem SOUL içinde hem onun oluşturduğu akıl yürüten roller için arzulanan çalışma standardını adlandırdı.

**Kaynak:** [U013–U014](../sources/conversation/USER-MESSAGES.md#u013), [S013](../sources/conversation/assistant/S013.md), [S014](../sources/conversation/assistant/S014.md).

## 8. Araştırma bu resmi nasıl besliyor?

Dördüncü soruda Foundation, studies ve bu denemelerin farklı rolleri konuşuldu. Foundation çalışma olgularını ve ilişkilerini ayırt etmeye yarayan bir araştırma zemini sağlıyordu. Studies, belirli mekanizmaları, uygulanmış örnekleri ve bozulma biçimlerini görünür kılıyordu. Explorations ise bunları kullanarak bütünsel ama henüz doğrulanmamış bir SOUL resmi kurma alanıydı.

Context/memory/harness, bilgi stratejileri, multi-agent, gstack, Anthropic SDLC, RPD, HERMES ve sandbox çalışmaları çeşitli düşünce girdileri olarak anıldı. Bunların hiçbiri tek başına bugünkü taslağın tamamını doğrulamadı. Özellikle bilgiye erişimden davranış kalitesine geçiş ve tek terminal amaçla rol düzenleme düşüncesinin etkinliği açık kaldı.

Hazırlık seviyesi hakkında verilen “neyi görmeli / neler yapabilmeli / gerçekte nasıl olacak” ayrımı bir değerlendirme merceğiydi. Nicel hazırlık ölçümü veya bütün repository'nin bağımsız audit'i değildi. Batu ayrıca bu bölümden otomatik araştırma yönü çıkarılmamasını açıkça istedi.

**Kaynak:** [S015](../sources/conversation/assistant/S015.md), [S016](../sources/conversation/assistant/S016.md), [U017](../sources/conversation/USER-MESSAGES.md#u017), [S017](../sources/conversation/assistant/S017.md), [araştırma referansları](../sources/RESEARCH-REFERENCES.md).

## 9. Son bağ: Development OS ne için var?

Batu, bu açık soruların yanıtlarının yalnız iki kişinin sohbetinde ortaya çıkmasını beklemediğini söyledi. SOUL'u yaratmak için kalıcı iş, bilgi, aktör ve ortam düzeni gerekir. Development OS bu daha dar amaca yönelik gerçek çalışma sistemi olarak düşünüldü: SOUL'u araştırmak, tasarlamak, geliştirmek ve doğrulamak.

Assistant bunun bir bootstrap ilişkisi olduğunu belirtti. Development OS hem üretim ortamı hem bazı aday fikirlerin gerçek çalışmada değerlendirilebileceği yer olabilir. Kendi yöntemlerini geliştirmesi, kendi üst amacını veya yetki sınırlarını kendiliğinden değiştirmesi demek değildir.

Bu konuşmalar hazırlık olarak konumlandı. İleride EXP-001 ve EXP-002 gibi denemeler topluca okunabilir; bir sonraki konuşmada görüşler yeniden tartılabilir ve ayrı kullanıcı yönüyle Development OS çalışmasına geçilebilir. Bu arşiv o geçişi gerçekleştirmez; mevcut başka repository çalışmalarını da yok saymaz.

**Kaynak:** [U018–U019](../sources/conversation/USER-MESSAGES.md#u018), [S018](../sources/conversation/assistant/S018.md).

## 10. Sonraki konuşmaya kalan resim

SOUL için aday resim: yalnız cevap üreten değil, amaca uygun çalışma düzenini kurabilen ve değiştirebilen bir yapı. Bu yapının kendi çalışma zemini olabilir. Oluşturduğu akıl yürüten aktörler, rolce sınırlı ama entelektüel olarak daraltılmamış olabilir. Araştırma birikimini taşımak kadar, gerektiği yerde kullanabilmek de hedeflenir. Development OS bu hedefe gitmek için daha dar amaçlı gerçek çalışma ortamıdır.

Bu sonuç sabit rol listesi, evrensel agent grafı, bellek teknolojisi seçimi, güvenlik sertifikası veya geliştirmeye hazır mimari değildir. Üçüncü sorudaki bütün terimler tek tek çözümlenmedi; özellikle loop/graph engineering için bağımsız ayrıntılı bölüm yapılmadı. Eksik dallar [OPEN-QUESTIONS](../reflections/OPEN-QUESTIONS.md) içinde açık kalır; görev kuyruğuna dönüştürülmez.
