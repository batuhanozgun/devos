# SOUL’un Çalışma Anlayışı
## Talep, Work, Information, aktörler ve uzmanlık sürekliliği

**Konuşma temelli kavramsal konsolidasyon — v0.1**  
**Tarih:** 10 Eylül 2026  
**Statü:** Değerlendirme metni. Kabul edilmiş SOUL mimarisi, uygulanmış ajan sistemi veya doğrulanmış çalışma yöntemi değildir.

---

## Belgenin kapsamı ve nasıl okunacağı

Bu metin, küçük bir form ve rapor uygulamasının SOUL içinde nasıl işletilebileceği sorusuyla başlayan konuşmayı, kendi başına okunabilen bir bütünlüğe dönüştürür. Konuşmanın konusu zamanla uygulamanın adımlarından, o adımları keşfeden, yürüten, değiştiren ve sürdüren çalışma sistemine ilerlemiştir. Burada korunmak istenen yalnızca son cümleler değil; bu ilerleyişin ortaya çıkardığı ayrımlar, somut örnekler, düzeltilen kabuller ve açık kalan tasarım sorularıdır.

Metnin doğrudan kaynağı bu oturumdaki kullanıcı–assistant konuşması ve kullanıcının C ile Work’ün birlikte ilerlemesini gösteren çizimidir. Önceki proje oturumlarının tamamının okunduğu veya bu belgeye aktarıldığı iddia edilmez. Repository araştırmaları, konuşmada kullanılan kavramsal dayanaklardır; bu konuşmanın yerine geçen kaynaklar değildir. İlgili araştırma dosyaları belgenin sonunda **K01–K10** olarak tanımlanmıştır.

Metinde üç epistemik düzey ayrılır. Araştırma dayanakları, ilgili repository çalışmalarında korunmuş ayrımlardır. Konuşmanın çalışma ilkeleri, bu ayrımlardan ve örnekler üzerinden yürütülen değerlendirmeden doğan tasarım yönelimleridir. Demo ise bu yönelimleri görünür kılan sentetik bir uygulamadır. Bir düzeydeki makullük, diğer düzeyde uygulama başarısının kanıtı sayılmaz.

Demodaki ajanlar ayrı ayrı çalıştırılmamıştır. Dosyalar konuşmada hayali olarak adlandırılmış, uygulama yazılmamış, gerçek kullanıcı verisi toplanmamış ve gerçek bir SOUL çalışma döngüsü kurulmamıştır. Bu belge ve onun PDF sürümü gerçek çıktılardır; içlerinde anlatılan proje dosyaları ise hâlâ simülasyonun parçalarıdır. Bu konsolidasyon repository’ye işlenmiş değildir ve Foundation araştırmalarının kabul durumunu değiştirmez.

Belgenin ana tezi şudur: **SOUL’da işi yapmak, kullanıcının ilk ifadesini görev listesine çevirmekten ibaret değildir. Kullanıcı niyetinin, gerçek koşulların, uzmanlık sorumluluklarının ve çalışma sırasında edinilen bilginin birlikte işlenmesiyle, yapılabilir ve amaca bağlı bir çalışma durumunun sürekli kurulması gerekir.** Bu tezin içeriği aşağıdaki bölümlerde geliştirilir; henüz tek bir mimari çözüm seçilmiş değildir.

## 1. Başlangıç sorusunun arkasındaki asıl soru

Başlangıç örneği basittir: Kullanıcılardan ad, e-posta adresi ve spor öncesinde yaptıkları üç ısınma hareketi alınacak; toplanan seçimlerden uygulamanın ikinci sayfasında bir rapor gösterilecektir. Sonraki açıklamayla raporun amacı belirginleşmiştir: Başka insanlar, katılımcıların hangi hareketleri daha sık seçtiğini görebilecektir.

Bu uygulama konuşmanın gerçek hedefi değildir. Uygulama, SOUL’un çalışma anlayışını somut bir nesne üzerinde incelemek için seçilmiştir. Asıl soru, araştırma bulgularının ve SOUL’a ilişkin tanımların bir LLM’de nasıl bir yönelim oluşturacağıdır. Model bu girdilerle karşılaştığında hangi işi önce ele alacak, neyi açık soru sayacak, neyi kaydedecek, hangi bilgiye dayanarak ilerleyecek ve yeni bir bulgu karşısında işi nasıl değiştirecektir?

İlk yanıtlarda doğrudan ortak iş kaydı, talep kimliği ve görev düzeni önerilmesi, bu asıl sorunun bir katmanını atlamıştır. Kullanıcı yalnızca bir iş kartının nasıl görüneceğini değil, o kartı üretmeyi ve o sırayla çalışmayı anlamlı bulan düzenin nereden geldiğini anlamak istemiştir. Bu düzeltme, konuşmanın odağını **çıktı olarak plan**dan **planı ve devam eden çalışmayı üreten sistem**e taşımıştır.

Bu nedenle çalışma modeli, hazır bir SOUL ürününü sınamak amacıyla ele alınmamıştır. Amaç, “SOUL böyle olmak zorunda” sonucuna hemen ulaşmak da değildir. Konuşma; araştırma, akıl yürütme ve küçük bir demo aracılığıyla ortak bir kavramsal bağlam oluşturmaya çalışmıştır. Gösterilen davranışların hangi girdilerden beslendiği ve görünürde basit bir akışın arkasında hangi sorumlulukların bulunduğu açığa çıkarılmıştır.

## 2. LLM açısından girdi, yönelim ve çıktı

### 2.1. Token benzetmesinin taşıdığı ve taşımadığı anlam

“Hava bugün çok…” ifadesinden sonra “güzel” gibi bir devamın üretilebilmesi, bağlamın üretimi yönlendirmesini düşünmek için kullanılmıştır. SOUL örneğinde de kullanıcı talebi, araştırma bilgileri, çalışma talimatları, mevcut proje durumu ve önceki sonuçlar modelin o andaki girdileri arasındadır.

Ancak bu benzetme, belirli bir dosyanın belirli bir kelimeyi veya kararı zorunlu olarak ürettiği anlamına gelmez. Modelin eğitimle edinilmiş bilgi ve becerileri ile o anda görünür olan bağlam birlikte rol oynar. Araştırmayı okumak, modeli yeniden eğitmekle aynı şey değildir. Araştırma, mevcut çağrının veya çalışmanın hangi bilgilere dayanarak yürütüleceğini etkiler. Parametrik kapasite, çalışma bağlamı ve dışarıda tutulan bellek arasındaki ayrım, ilgili araştırma paketinde de korunmaktadır. [K05, K06]

Konuşmada gösterilebilen şey, modelin içindeki ayrıntılı hesaplamanın dökümü değildir. Gösterilebilen şey; hangi girdilerin verildiği, hangi sorumluluğun tanımlandığı, hangi karar veya çıktının üretildiği ve bu çıktının sonraki çalışmayı nasıl etkilediğidir. Demo bu anlamda bir girdi–çıktı ve çalışma kaydı gösterimidir; token düzeyinde nedensel etki ölçümü değildir.

### 2.2. Araştırma bulgusu ile işletim kuralı arasındaki geçiş

Bir araştırma şu ayrımı ortaya koyabilir: Talebin bulunması, işin üstlenilmiş olması ve yürütmeye başlanması aynı değildir. Bu bulgu, tek başına yeni bir talebin hangi dosyaya hangi sırayla yazılacağını belirlemez.

Bu bulgudan hareketle bir işletim tercihi kurulabilir: Yeni talebi kaydet; fakat üstlenme kararı verilmediyse yürütülüyormuş gibi gösterme. Somut bir durumda da “talep geldi, henüz üstlenme kararı yok” bilgisi bulunabilir. Modelin sonraki çıktısı, bu üç ayrı içeriğin birlikte kullanılmasından doğar: araştırma ayrımı, benimsenmiş çalışma kuralı ve anlık durum.

Bu geçiş bilinçli olmalıdır. Araştırma, korunması gereken ayrımı ve bazı hata ihtimallerini açıklar. İşletim kuralı, bu sistemde nasıl davranılacağını belirler. Proje durumu, kuralın üzerinde uygulanacağı somut bilgiyi taşır. Araştırmanın bütününü doğrudan talimata çevirmek de, araştırmadan türetilmiş bir tercihi araştırmanın zorunlu sonucu gibi sunmak da doğru değildir. [K01, K05]

### 2.3. Metin üretimi ile gerçek iş sonucu arasındaki sınır

Modelin “görev oluşturuldu” yazması, görevin ortak depoda oluştuğunu göstermez. “Dosya güncellendi” demesi, ilgili değişikliğin gerçekten kaydedildiği veya sonraki aktöre görünür olduğu anlamına gelmez. Üretilen kararın araçlarla uygulanması, sonucun gözlenmesi ve ilgili çalışma durumuna taşınması ayrı koşullardır.

SOUL için düşünülen döngü bu nedenle tek bir büyük istem değildir. Her adımda ilgili bağlamın kurulması, modelin bir karar veya çıktı üretmesi, gerekli gerçek işlemin gerçekleştirilmesi ve sonucun bir sonraki adıma geri beslenmesi söz konusudur. Bu halkalardan yalnızca metin üretimini göstermek, işletimin tamamını göstermiş olmaz. [K05, K07]

## 3. A, B ve C: Söylenen talep ile çalışılabilir problem arasındaki mesafe

### 3.1. Üç ayrı şey

Konuşmada geliştirilen notasyon, kullanıcı talebinin üç farklı yönünü ayırır:

**A**, kullanıcının ifade ettiği taleptir. Kısa, eksik, gündelik dilde veya çözüm biçimiyle anlatılmış olabilir.

**B**, kullanıcının zihnindeki istek ve problem modelidir. Kullanıcı B’nin bütün ayrıntılarını söylememiş olabilir. Bazı ayrıntıları önemsiz sayabilir, aktarılması gerektiğini düşünmeyebilir veya henüz kendisi de bilmeyebilir.

**C**, keşif ve çalışma ilerledikçe oluşan mevcut problem, sonuç ve kapsam anlayışıdır. Kullanıcının amacıyla, gerçek koşullarla ve öğrenilenlerle birlikte üzerinde çalışılabilecek hale getirilmiş bir tanımdır.

Buradaki ihtiyaç, kullanıcıların her durumda bilgisiz olduğu varsayımına dayanmaz. Bilgili bir kullanıcı da eksik ifade kullanabilir. SOUL’un dayanıklı olması gereken durum, **ifade edilen talebin gerekli bütün çalışma bilgisini taşımadığı durumdur**.

### 3.2. C, kullanıcının zihninde saklı duran tek doğru cevap değildir

A’dan C’ye gitmek, B’yi eksiksiz tahmin etmek veya kullanıcının gizli niyetini okumak değildir. Kullanıcının kendisi de gerekli teknik, operasyonel veya mesleki ayrımları başlangıçta bilmiyor olabilir. C; amaç, kullanıcı tercihleri, koşullar, araştırma, deney ve alınan kararlarla birlikte oluşur.

Başlangıçta tek bir C bulunması gerekmez. Aynı A, birden fazla makul amaç veya gerçekleştirme biçimiyle uyumlu olabilir. SOUL’un işi, bütün alternatifleri sonsuza kadar çoğaltmak değil, aralarındaki farkın yapılacak işi maddi biçimde değiştirip değiştirmediğini belirlemektir.

Kullanıcının zihinsel modelini anlamak bu süreçte yararlıdır, fakat her zaman ara hedef olarak tamamlanması gereken bir aşama değildir. Bazı durumlarda doğrudan “Bu sonuç neyi sağlayacak?” sorusuyla amaç netleşebilir. Bazı durumlarda teknik bir araştırma, kullanıcının aklına gelmemiş bir koşulu görünür kılar.

### 3.3. Eksik bilgiye verilecek tek karşılık kullanıcıya soru sormak değildir

Eksik bilgi; mevcut kayıttan bulunabilecek bilgi, dış kaynaktan araştırılabilecek olgu, teknik seçenekler arasında verilmesi gereken karar, kullanıcının tercihine veya yetkisine bağlı seçim ya da ancak denemeyle öğrenilebilecek durum olabilir.

Bu ayrımlar yapılmadan bütün bilinmeyenleri kullanıcıya sormak, keşif sorumluluğunu tekrar kullanıcıya yükler. Buna karşılık kullanıcıya ait bir tercihi veya yetkiyi teknik araştırmayla çözülmüş gibi göstermek de sınır ihlalidir.

SOUL’dan beklenen, hangi eksikliğin hangi bilgi edinme veya karar yoluyla giderileceğini ayırt etmesidir. Sorunun gerekli olduğunu keşfetmekle cevabını kullanıcı adına vermek birbirinden ayrılmalıdır. Önkoşul keşfi değerlendirmesinin önemli katkısı, bu sorumluluğu yalnız önceden tanımlanmış görevleri yapmaktan ayırmasıdır. [K08]

## 4. Sonuçtan düşünmek, kapsamı sınırsız büyütmek değildir

### 4.1. “Bittiğinde ortada ne olacak?” sorusu

İşe başlamadan önce yalnızca bir cümlelik görev adı üretmek yeterli olmayabilir. “Bu iş bittiğinde ne vardır?” sorusu, ekranların ayrıntısını veya verinin hangi tabloda tutulacağını sormaktan farklıdır. Kim hangi ihtiyacını karşılayabilecek, hangi koşullarda kullanabilecek ve teslim sorumluluğu nerede bitecektir?

Bu yaklaşım, işi baştan bütün ayrıntılarıyla kesin olarak bilmeyi gerektirmez. Başlangıçtaki hedef, işin büyüklüğünü değiştiren ayrımları bulmaktır. Gösterilebilir bir prototip ile gerçek kullanıma hazır uygulama; yalnız teslim ile teslimden sonra işletme sorumluluğu; kişisel kullanım ile başkalarına hizmet veren sistem aynı kapsam değildir.

Work araştırması, istenen sonucu yapılan eylemden ve seçilmiş yöntemden ayırır. Bir görev açıklaması, üst amacın yerine geçmez. Seçilmiş alt işlerin tamamlanması da amacın gerçekleştiğini tek başına kanıtlamaz. [K01, K09]

### 4.2. Roman örneğinin açtığı alan

“Roman yazmak istiyorum” ifadesi, yalnızca bir metin üretme isteği olabilir. Tamamlanmış bir elyazması, basılabilir bir kitap, yayımlanmış eser, okurlara ulaşan roman, gelir elde etme veya yazar olarak kariyer oluşturma isteği de olabilir.

Amaç okura ulaşmak olduğunda editoryal hazırlık, yayıncılık, baskı ve basım, dağıtım, raflarda bulunma, fiyatlama, sponsorluk, reklam, PR anlaşmaları veya sosyal medya gibi konular ilgili hale gelebilir. Fakat bu listenin uzunluğu, hepsinin her roman için zorunlu olduğunun kanıtı değildir. Kullanıcı gerçekten yalnızca kişisel bir metin istiyorsa kapsam o yönde kalabilir.

Bu örneğin ilkesi, “küçük talebi mümkün olduğunca büyük bir projeye dönüştür” değildir. İlke, **kullanıcının söylediği eylemin arkasındaki amaç için gerekli gerçek çalışma sınırını keşfet** biçimindedir.

### 4.3. Gereklilik ile yöntemi ayırmak

“Veri tabanı lazım” ifadesi, henüz seçilmemiş bir çözümün gereklilik gibi sunulması olabilir. Daha temel ihtiyaç, toplanan bilgilerin rapor üretileceği zaman kullanılabilir olmasıdır. Bunun hangi saklama düzeniyle sağlanacağı ayrıca kararlaştırılır.

Roman için de okurun esere erişebilmesi bir koşuldur; yayınevi, doğrudan dijital yayın veya başka bir yayın yolu bunun aday yöntemleridir. Hedefin gereğiyle yalnızca seçilmiş yolun gereği ayrı tutulmalıdır. Bir yöntem seçildiğinde yeni önkoşullar doğabilir; yöntem terk edildiğinde bunların bir bölümü gereksiz hale gelebilir. [K08]

Bu ayrım, sonucun kapsamını korurken uygulama yolunun değişebilmesini sağlar. Kullanıcının amacını düşünmek, onu belirli bir teknolojiye veya ticari yönteme erken bağlamak değildir.

## 5. C’nin gelişimi ve Work ile birlikte ilerlemesi

### 5.1. Anlama ve yürütme arasında tek bir küresel kapı yoktur

Konuşmanın ilk aşamalarında “önce talebi anlayalım, sonra yürütmeye geçelim” biçiminde doğrusal bir model ortaya çıkmıştır. Kullanıcının çizimi bu modelin yetersizliğini göstermiştir. Çizimde A’dan farklı C adaylarına, oradan mevcut bir çalışma anlayışına geçilir; iş ilerlerken C yeniden değişir. C, işleri etkiler; işin sonuçları da C’yi etkiler.

Bu nedenle bütün proje için bir kez “C tamamlandı, artık düşünme bitti” denmez. Bazı konular başlangıçta yeterince açıkken başka konular çalışma sırasında çözülür. Bazı kararlar bilerek sonraya bırakılabilir; fakat unutulmuş veya yok sayılmış olmamalıdır. Anlamaya yönelik faaliyetin her an aynı yoğunlukta sürmesi de gerekmez. Zamanla azalabilir, bir dönemde gerekmeyebilir veya yeni bir amaç ya da bulgu nedeniyle yeniden açılabilir. Korunan ilke C’nin durmadan değiştirilmesi değil, gerektiğinde yeniden değerlendirilebilmesidir.

Anlamaya yönelik çalışma da Work’tür. Araştırma, yorumlama, alternatif değerlendirme, belirsizlik azaltma ve karar hazırlama, yalnızca üretim öncesi boş zaman değildir. Çizimdeki “Work başladı” noktası, bazı üretim işlerinin başlatılabildiği bir anı temsil eder; öncesinde hiç Work bulunmadığını göstermez. A’nın gelmesi ise kendiliğinden teslim taahhüdü veya fiilî yürütme yaratmaz. [K01, K02]

### 5.2. Aynı amaç altında farklı işler farklı olgunlukta olabilir

Romanın ilk taslağı üzerinde çalışmak için dağıtım yolunun bütün ayrıntılarını bilmek gerekmeyebilir. Yayın yoluna ilişkin açık konu aklın bir köşesinde tutulabilir ve uygun noktada ele alınabilir. Buna karşılık yüksek adetli baskı anlaşması yapmak aynı belirsizlik altında erken olabilir.

Burada “roman metni ile dağıtım hiçbir koşulda ilişkili değildir” biçiminde evrensel bir bağımsızlık iddiası kurulmaz. Konuşmanın taşıdığı nokta daha sınırlıdır: Belirli bir işin yapılabilirliği, projenin başka bir boyutundaki her karara bağlı olmak zorunda değildir. Hangi ilişkinin gerçekten gerekli olduğu iş bazında değerlendirilir.

İlk adım ilerlerken C değişebilir. Bu değişiklik ilk adımı koruyabilir, kısmen uyarlamayı gerektirebilir veya yeniden yapmayı gerektirebilir. Baştan başlama yalnızca olası karşılıklardan biridir; her değişimde bütün önceki işi silmek gerekmez.

### 5.3. Yayınevi örneğinde ne kaybolur, ne korunur?

Yazar başlangıçta dağıtım şirketi aramayı gerekli iş olarak görebilir. Yayın yollarını araştırınca seçilen yayınevinin dağıtımı da üstleneceği anlaşılabilir. Bu durumda “dağıtım şirketi bul” işi ortadan kalkabilir veya yazardan başka bir sorumluya geçebilir. “Uygun yayınevi bul” daha erken ve merkezi bir iş haline gelebilir.

Fakat amaç okura ulaşmaksa erişim koşulu kaybolmaz. Değişen şey, bu koşulu kimin ve hangi yolla sağlayacağıdır. “Görev listemizden çıktı” ile “artık hedef için gerekli değil” birbirine karıştırılmamalıdır. İşin kapsamı, sorumluluk dağılımı ve bağımlılık düzeni birlikte değişmiş olabilir.

### 5.4. C’nin zenginliği ile belirsizliğin azalması aynı eksen değildir

Konuşmada A ve C arasındaki mesafenin zamanla azaldığı, iş gerçekliğe dönüştükçe C’nin daha kararlı hale geldiği sezgisi geliştirilmiştir. Bu sezgi yararlıdır; fakat A > C, A ≈ C veya A = C gibi ifadeler ölçülmüş büyüklük ilişkileri değildir.

A bir kullanıcı ifadesi, C ise ondan ve başka bilgilerden türetilmiş çalışma anlayışıdır. C zamanla daha kısa olmak yerine daha zengin hale gelebilir. Azalan şey, belirli kararlar etrafındaki belirsizlik veya hâlâ açık tutulan seçeneklerin alanı olabilir.

Bu azalma da zorunlu olarak tek yönlü değildir. Yeni bir bulgu, önceki kararlılığı bozabilir; sahte kesinlik giderildiğinde görünür belirsizlik artabilir. Önemli olan C’yi sürekli daha kesin göstermek değil, mevcut gerçekliği ve açık ihtimalleri daha doğru temsil etmektir.

İşin sonunda da başarı, A ile C’nin metinsel olarak eşitlenmesi değildir. En son yetkilendirilmiş amacın hangi ölçüde gerçekleştiği, bunun nasıl bilindiği ve hangi sorumlulukların hâlâ açık olduğu değerlendirilir. Kaynak talep korunur; güncel anlayış onun yerine geçmişe dönük olarak yazılmaz.

## 6. Bir Work ne zaman başlanabilir hale gelir?

### 6.1. Kararın nesnesi bütün proje değil, sınırlandırılmış iştir

“C yeterince tamam mı?” sorusunun yerini şu soru alır: **Mevcut bilgi, belirsizlik ve koşullarla bu belirli işi başlatmak uygun mu?**

Bir işin amacı belli olabilir, gerekli girdileri bulunabilir ve projenin açık kalan diğer kararları o işin sonucunu maddi biçimde değiştirmeyebilir. Böyle bir iş, bütün proje tanımlanmadan başlayabilir. Başka bir iş aynı anda hazır olmayabilir.

Başlanabilirlik yalnızca bilgi miktarı değildir. Mevcut kapasite, erişim, önkoşullar, yetki ve sorumluluk sınırı da önemlidir. Work araştırması başlanabilirlik ve kabulü, bunların bağlı olduğu gerçek ortam koşullarından ve aktör yetkisinden ayırır. [K02, K04]

### 6.2. Başlama değerlendirmesinde kullanılan bilgiler

Bu konuşmadan türeyen değerlendirme soruları bir zorunlu kontrol formu değil, kararın dayanaklarını görünür kılan bir çerçevedir:

| Değerlendirme konusu | Açığa çıkarılması gereken bilgi |
|---|---|
| Amaç ve çıktı | Bu iş neyi sağlayacak; hangi sonuç üretildiğinde mevcut görevi yerine getirmiş olacak? |
| Girdiler ve bağımlılıklar | Gereken kaynaklar, önceki sonuçlar ve koşullar mevcut mu? |
| Belirsizliğin etkisi | Hangi açık mesele bu işin yöntemini, değerini veya sonucunu değiştirebilir? |
| Değişme bedeli | C değişirse yapılan iş korunur mu, uyarlanır mı, yeniden mi yapılır; dış etkiler geri alınabilir mi? |
| Fiilî yapılabilirlik | Gerekli araç, erişim, kapasite ve çalışma ortamı gerçekten kullanılabilir mi? |
| Sorumluluk ve yetki | İşi kim üstlenebilir, hangi kararları verebilir, hangi sınırda durmalıdır? |
| Sonucun kullanımı | Çıktı nerede ve hangi koşullarda kullanılacak; üretildiği ve uygun olduğu nasıl ayrılacak? |

Belirsizliğin varlığı tek başına durma gerekçesi değildir. Aynı şekilde bir şeyler biliniyor olması bütün planı yürütme gerekçesi değildir. Belirsizliğin hangi kararı etkilediği belirlenmelidir.

### 6.3. İlk adımın hiç değişmeyeceğinin garantisi aranmaz

Kullanıcının “ilk adımın değişmeyeceği kadar bir C’ye sahip olmak” sezgisi, belirsizliğe karşı dayanıklı iş bulmaya yöneltmiştir. Bunun mutlak biçimi gereksiz bir kesinlik eşiğine dönüşebilir. Daha doğru hedef, makul değişiklikler altında işin değerini ve değişme maliyetini değerlendirmektir.

Romanın ilk bölümünün taslağı geri düzenlenebilir ve aynı zamanda yeni bilgi üretebilir. Elli bin kitap bastırmak ise farklı bir dış etki ve yeniden çalışma bedeli taşır. Beklemenin bedeli de olabilir. Uygun karar, yalnızca “yanlış çıkabilir mi?” değil, “yanlış çıkarsa ne olur; şimdi başlamak ve beklemek hangi sonuçları doğurur?” sorularıyla verilir.

Bazen işi küçülterek başlanabilir bir bölüm bulunur. “Bütün form sistemini tamamla” yerine “nihai katılım politikasına bağlı olmayan giriş kurallarını taslaklaştır” denebilir. Bu, kalite standardını düşürmek değil; geçerli sınırı doğru seçmektir.

### 6.4. Başlanabilirlik, seçilme ve yürütme ayrı durumlardır

Yapılabilir bir işin hemen seçilmesi gerekmez. Öncelik, diğer işler, bağımlılıklar ve kapasite nedeniyle ertelenebilir. Seçilmiş iş için gerekli yetki bulunmayabilir. Yetkilendirilmiş iş de henüz başlamamış olabilir.

Bu nedenle aday iş, değerlendirmeye uygun iş, seçilmiş veya yürütmeye kabul edilmiş iş ve fiilen yürüyen iş ayrımları korunur. İşin bulunması, aktöre otomatik yükümlülük atamaz; görev kartında “başladı” yazılması da fiilî yürütmenin kanıtı değildir. [K01, K02, K04]

## 7. Work ve Information’ın karşılıklı ilişkisi

### 7.1. Information yalnızca girdi, Work yalnızca çıktı değildir

Kullanıcı talebi, kaynak, plan, iş kartı, test beklentisi, araç sonucu, karar ve ilerleme kaydı Information olarak ele alınabilir. C, Information’ın tamamı değil; mevcut çalışma anlayışını taşıyan bir bölümüdür. Work ise amaçlı uğraşın seçilmesi, düzenlenmesi, yürütülmesi, değerlendirilmesi ve zaman içinde değiştirilmesiyle ilgilidir.

İş kartı Work’ün kendisi değildir. Gerçek bir işin yapılmasıyla o iş hakkında ne yazıldığı farklıdır. Aynı biçimde bir koşulun gerçekten sağlanması, sağlandığına dair iddia ve bu iddiayı destekleyen kanıt ayrı tutulmalıdır. [K02, K03]

### 7.2. Bilgi oluşumu, dönüşümü ve görünürlüğü

Information araştırması, bilginin oluşmasını veya edinilmesini; mevcut bilgiden yeni temsil türetilmesini; mevcut bilginin belirli bir kullanıcıya veya işe görünür hale gelmesini ayırır. Bir kaynak doğru olabilir ve ondan türetilen kayıt doğru olabilir; buna rağmen işi yapan aktöre yanlış sürüm gösterilirse çalışma yine yanlış yönlenebilir. [K03]

A’nın kaydedilmesi, A’dan C türetilmesi ve güncel C’nin ilgili aktöre gösterilmesi bu nedenle aynı işlem değildir. Bunların her biri farklı bir hata ihtimali taşır. Kalıcılık, bulunabilirlik, görünür bağlam ve fiilî kullanım birbirinin yerine geçmez.

### 7.3. Değişiklik, bağımlılıklara göre ele alınmalıdır

“Bu görev C₂’ye bağlı” demek bazen yetersizdir. Bir çıktının hangi kısmının hangi varsayıma, karara veya koşula bağlı olduğunu bilmek gerekebilir. Tekrar katılım politikası değiştiğinde, bütün form alanları geçersiz hale gelmeyebilir; raporda hangi yanıtların sayılacağı etkilenebilir.

C değiştiğinde otomatik olarak bütün işler yeniden başlatılmaz. Etkilenen sonuçların geçerliliği yeniden değerlendirilir. Bazı işler korunur, bazıları uyarlanır, bazıları artık gereksizleşir, bazıları yeniden açılır. Üretimin tamamlanmış olması ile çıktının belirli bir kullanım için geçerli olması farklı eksenlerdir.

Bu düzen, planı sabit bir yapılacaklar listesi olmaktan çıkarır. Plan, mevcut bilgiye ve alınmış kararlara göre düzenlenen çalışma görünümüdür. Bununla birlikte her yeniden değerlendirme geçmiş taahhütleri veya sorumlulukları kendiliğinden silmez; değişikliklerin yetki ve gerekçesi korunmalıdır.

### 7.4. Döngünün faili vardır

“Information Work’ü değiştirir; Work Information üretir” ifadesi yararlı bir kısaltmadır. Fakat dosyalar veya kavramsal bacaklar kendiliğinden karar vermez. Aktörler mevcut bilgileri yorumlar, işleri üstlenir, araçlarla eylem gerçekleştirir, sonuçları gözler ve bilgi durumunu günceller. Çalıştırma ortamı da bu işlemlerin mümkün ve görünür olmasında rol oynar.

Dolayısıyla konuşmanın çift yönlü modeli, kendi kendine hareket eden iki klasör değil; aktörler ve ortam aracılığıyla işletilen bir ilişkiler düzenidir.

## 8. Uygulama demosu: Modelin somut bir çalışma üzerinde işletilmesi

### 8.1. Demonun talebi ve sınırı

Demo şu kullanıcı talebiyle başlatılmıştır:

> “Kullanıcılardan, ad, email ve spor yapmadan önce insanların kaslarını ısındırmak için yaptığı üç hareket seçtikleri ve tüm seçimlerin dashboard’da gösterildiği, böylece diğer spor yapmak isteyen insanlara çoğunluğun hangi hareketi yaptığını gösteren bir rapor ekranı olan uygulama yapmanı istiyorum.”

Bu aşamada raporun tek kişinin kendi yanıtını değil, toplanan seçimleri göstereceği artık açıktır. Önceki belirsizlik tekrar kullanıcıya sorulmamıştır. Demo; koordinatör, üretici ve gözden geçiren rollerinin tek bir assistant tarafından canlandırılmasıyla yürütülmüştür. Bu rollerin ayrı model çağrıları, ayrı ajanlar veya bağımsız doğrulayıcılar olduğu ileri sürülmemiştir.

Görünür hale getirilen şey, bir yazılımın çalışması değil, sınırlı işlerin seçilmesi, bilgi üretilmesi ve yeni bilgi karşısında işlerin değiştirilmesidir. Aşağıdaki hesaplar sentetik örneklerdir; form, sunucu, veri tabanı ve test altyapısı kurulmamıştır.

### 8.2. A₀ ve C₀: İlk çalışma anlayışı

Özgün talep `talep.md` içinde A₀ olarak korunmuştur. `anlayis.md` içine ilk yorum, C₀ olarak yerleştirilmiştir:

> İnsanlar adlarını, e-posta adreslerini ve yaptıkları üç ısınma hareketini bildirecek. Başkaları, bu bildirimlerin bir araya getirilmesiyle hangi hareketlerin daha sık seçildiğini görebilecek.

Hareket seçeneklerinin içeriği, tekrar katılımın anlamı, platform, barındırma ve gerçek kullanıma açılma koşulları açık bırakılmıştır. Kullanıcının kişisel bilgileri toplama talebi korunmuş; ancak ad ve e-posta adreslerinin herkese açık raporda gösterilmesi talep edilmiş sayılmamıştır.

Ayrıca bir kapsam önerisi kaydedilmiştir: Uygulama, insanların bildirdikleri tercihleri gösterecektir; bu hareketlerin sağlık açısından üstünlüğünü değerlendiren bir sistem olduğu varsayılmayacaktır. Bu, bir sağlık araştırmasının sonucu değil, raporun neyi iddia ettiğini sınırlayan taslak ürün çerçevesidir.

C₀, her ayrıntısı çözülmüş gereksinim belgesi değildir. Bilinenlerle açık kararları ayıran ilk çalışma anlayışıdır.

### 8.3. W-01: Raporun neyi sayacağını belirlemek

İlk aday iş, “arayüzü yap” veya “veri tabanı seç” değildir. **W-01 — Raporun neyi sayacağını ve hangi ifadeleri destekleyebileceğini örneklerle belirle** işi seçilmiştir.

Bu işin girdileri A₀ ve C₀’dır. Beklenen çıktısı, sayım birimi, örnek sonuçlar ve çözülemeyen ayrımlardır. Platform, barındırma sağlayıcısı, gerçek kişisel veriler ve hareketlerin nihai isimleri bu iş için gerekli değildir. İşin sınırı, ürünün bütün kararlarını vermemektir.

Başlama gerekçesi de sınırlıdır: Gerekli girdiler vardır; gerçek veri kullanılmayacaktır; çıktı farklı teknoloji seçeneklerinde kullanılabilir; hatalı bir öneriyi düzeltmenin bedeli düşüktür. Böylece bütün projenin değil, W-01’in başlanabilir olduğu kabul edilmiştir.

Gerçek hareket adları seçilmeden H1–H5 kodlarıyla şu örnek oluşturulmuştur. Örnek kurulurken dört yanıtın dört farklı kişiye ait olduğu bilinçli olarak varsayılmıştır; gerçek sistemin bunu nasıl bileceği henüz çözülmemiştir.

| Yanıtlayan | Seçimleri |
|---|---|
| K1 | H1, H2, H3 |
| K2 | H1, H2, H4 |
| K3 | H1, H3, H4 |
| K4 | H2, H4, H5 |

H1 üç yanıtta geçmektedir. Toplam on iki hareket seçimi vardır. Buna göre iki farklı oran doğar: **3/12 = %25**, bütün seçimlerin ne kadarının H1 olduğunu söyler. **3/4 = %75**, yanıtlayanların ne kadarının H1’i seçtiğini söyler. İki hesap da aritmetik olarak doğrudur; farklı soruları cevaplar.

Kullanıcı insanlara ilişkin bir karşılaştırma istediği için ikinci tür oran ana gösterge adayı olarak seçilmiştir. Örnekte H1, H2 ve H4 %75; H3 %50; H5 %25 oranındadır. Her yanıtlayan üç hareket seçebildiği için bu oranların toplamının %100 olması gerekmez. Ayrıca en sık seçilen hareket, mutlaka yarıdan fazlanın seçtiği hareket değildir. Başka bir veri kümesinde en yüksek oran %40 olabilir.

Bu bilgiler `ciktilar/rapor-kurallari.md` dosyasının taslak içeriği olmuştur. C₁ şöyle belirginleşmiştir: Rapor, hareketleri yalnız sıralamayacak; kaç yanıt bulunduğunu, oranların ne anlama geldiğini ve hangi yanıt kümesine dayandığını gösterecektir. “En sık seçilen” ile “çoğunluğun seçtiği” karıştırılmayacaktır.

### 8.4. D-02 ve C₂: Aynı kişi tekrar gönderirse ne olur?

Gözden geçiren rolü, hesapları tekrar etmek yerine bir karşı örnek eklemiştir: K1 aynı yanıtı ikinci kez gönderirse ne olur?

İlk yanıt ikinci kez sayıldığında beş kayıt oluşur. H3 üç kayıtta görünür. Önce 2/4 = %50 olan oran, 3/5 = %60 olur. Yeni bir insan katılmamıştır; fakat kayıtlardan hesaplanan sonuç artık yarıdan fazlaya işaret eder.

Buradaki sorun aritmetik hata değildir. Eksik koşul, hangi kayıtların birlikte ve hangi anlamda sayılacağıdır. `kararlar.md` içine D-02 bulgusu konmuştur: Gönderim sayısı ile kişi sayısı aynı kabul edilemez. Tekrar gönderim, yeni katılım mı, önceki yanıtın güncellenmesi mi, yoksa yanlışlıkla tekrarlanan aynı işlem mi sayılacaktır?

Bu bulgu C₂’yi oluşturmuştur: İnsanların tercihlerine ilişkin rapor üretmek için yanıtların kabul ve sayılma kuralı tanımlanmalıdır. Her form gönderimi kendiliğinden yeni bir insanın tercihi değildir.

Bundan doğan yeni iş **W-03 — Tekrar gönderim ve sayılacak yanıt politikası için seçenekleri değerlendir** olmuştur. Kullanıcı başlangıçta bu işi açıkça istememiştir. İş, istenen raporun anlamını korumak için gerekli bir karar alanı olarak keşfedilmiştir.

Hemen üyelik sistemi kurulmamış veya e-posta doğrulama yöntemi seçilmemiştir. Bir e-posta adresinin bulunması, ayrı kayıtların ayrı insanlara ait olduğunu tek başına göstermez. Sorunun fark edilmesiyle çözüm yolunun seçilmesi ayrı kalmıştır.

W-01 de bütünüyle başarısız sayılmamıştır. Sayım örneği ve oran açıklaması korunmuştur; kişi bazlı yorumunun geçerliliği, W-03’te çözülecek kabul politikasına bağlanmıştır. İşin üretilmiş kısmıyla belirli kullanım koşullarının açık kalması birlikte temsil edilmiştir.

### 8.5. W-02: Açık bir karar varken başka işi ilerletmek

C₂’de çözülmemiş bir mesele vardır; fakat bütün çalışma durdurulmamıştır. **W-02 — Formdan alınacak yanıtın ilk giriş kurallarını tanımla** işi başlatılmıştır.

İlk taslakta ad, e-posta ve üç hareket seçimi alınacağı korunmuştur. “Üç hareket”, üç farklı seçenek olarak yorumlanmış; bu yorum kullanıcı tarafından ayrıca onaylanmış karar değil, taslak olarak işaretlenmiştir. Hareketlerin ortak kimliklerle temsil edilmesi önerilmiştir. Böylece aynı hareketin farklı yazılışlarının ayrı hareketler gibi sayılması önlenebilecektir.

Bu kuralların yanında formun alan koşullarını karşılamasıyla raporda sayılabilir olması ayrılmıştır:

| Örnek girdi | Taslak değerlendirme |
|---|---|
| H1, H2, H3 | Üç farklı seçim koşulunu karşılar. |
| H1, H2 | Üç seçim koşulunu karşılamaz. |
| H1, H1, H2 | Üç farklı seçim koşulunu karşılamaz. |
| Aynı kişinin tekrar H1, H2, H3 göndermesi | Alanlar uygun olabilir; rapora nasıl alınacağı ayrıca belirlenmelidir. |

Bu örnekler çalışan yazılımın test sonuçları değildir; gelecekte kullanılabilecek beklenen davranış taslaklarıdır. `ciktilar/yanit-kurallari.md` içinde tutulmuştur.

Burada bağlam aktarımı görünür hale getirilmiştir. W-02’yi yapan role yalnız özgün talep değil, C₂ ve D-02 de gösterilmiştir. Alanlar ve üç farklı seçim kuralı korunacak; gönderimin raporda sayılması veya önceki yanıtı değiştirmesi henüz kesinleştirilmeyecektir.

Bu aktarım demoda anlatıcı tarafından yapılmıştır. Gerçek bir SOUL’un değişikliği fark ederek doğru aktörün bağlamına kendiliğinden taşıdığı gösterilmemiştir. Bu eksik işletim halkası, konuşmanın sonraki bölümünde dosyalar ve harness tartışmasını doğurmuştur.

### 8.6. W-04: Sıfır yanıt ve ilk gerçek kullanım

**W-04 — Henüz yanıt yokken ve ilk yanıtlar geldiğinde raporun ne söyleyeceğini belirle** işi, teknoloji seçimi beklenmeden ele alınmıştır.

Hiç yanıt yokken “en popüler hareket” gösterilemez. Bütün oranları %0 yazmak, “kimse bu seçeneği seçmedi” ile “henüz veri yok” durumlarını karıştırabilir. İlk kural, sonuç oluşmadığını açıkça belirtmektir. Yanıt geldiğinde sayılan yanıt adedi ve o küme içindeki dağılım gösterilecektir. Sentetik demo verileri, gerçek kullanıcı tercihleri gibi sunulmayacaktır.

Raporda sayılacak veri kümesi belli olsa bile, bu kümeden bütün spor yapan insanlara ilişkin sonuç çıkarıldığı varsayılmamıştır. Çıktının kapsamı “bu uygulamaya gelen ve sayılma koşullarını karşılayan yanıtlar içinde” olarak sınırlandırılmıştır. Bu ayrım burada örneklem hakkında yeni bir ampirik araştırma değil, kanıtın taşıdığı iddiayı aşmama kuralının uygulamasıdır.

C₃ bu bilgilerle oluşmuştur: Ürün, belirlenmiş sayılma koşullarını karşılayan bildirimlerin seçim dağılımını gösterecek; veri yokluğu, yanıt sayısı ve sonuçların hangi katılıma dayandığı açık kalacaktır.

Bu iş bir başka koşulu da görünür hale getirmiştir. Kodun yazılmasıyla gerçek topluluk bilgisinin oluşması aynı değildir. Gerçek yanıtların gelmesi gerekir. Bundan **ilk gerçek katılımın nasıl sağlanacağını ve bunun kimin sorumluluğunda olduğunu netleştirme** işi aday olarak doğmuştur.

Bu aday iş, reklam kampanyası satın alma yetkisi veya katılımcı bulma taahhüdü olarak kabul edilmemiştir. İlk demo için gerekli olmayabilir; gerçek insanların tercihlerini gösteren kullanıma geçiş için ise açık bırakılmaması gereken bir sorumluluktur.

### 8.7. Demonun durduğu çalışma durumu

| İş | Demo sonundaki durum | Açık sınır |
|---|---|---|
| W-01 — Raporun anlamı ve hesap örnekleri | Taslak çıktı üretildi. | Kişi bazlı yorum, kabul politikasına bağlı. |
| W-02 — Form girdisi kuralları | İlk taslak üretildi. | Tekrar gönderimin etkisi ve bazı ürün yorumları kesinleşmedi. |
| W-03 — Tekrar gönderim politikası | Seçenek incelemesine başlanabilir. | Kullanıcı adına nihai politika seçilmedi. |
| W-04 — Boş ve ilk veri durumları | Taslak çıktı üretildi. | Gerçek kullanım veya yazılım testi yapılmadı. |
| Hareket seçeneklerini hazırlama | Araştırma ve taslak çalışmasına uygun aday. | Gerçek hareket listesi belirlenmedi. |
| Teknoloji ve barındırma kararı | Aday iş. | Kullanım ve teslimat koşulları yeterince belirlenmedi. |
| İlk gerçek katılım | İhtiyaç olarak görünür. | Sorumluluk üstlenilmedi; yürütme yetkisi verilmedi. |

Demo W-03’ün seçenek incelemesine başlanabileceği noktada durmuştur. Projenin tamamının bloke olduğu söylenmemiştir. C de tamamlanmış ilan edilmemiştir. Üretilmiş taslaklar, geçerlilik koşulları ve gerekçeli sonraki işler birlikte bırakılmıştır.

### 8.8. Demonun gösterdiği ile göstermediği

Demo, aynı belirsizliğin bir iş için önemsiz, başka bir iş için belirleyici olabileceğini somutlaştırmıştır. Yeni bir C sürümü bütün işleri bozmak yerine belirli iddiaları etkilemiştir. Kullanıcı tarafından söylenmemiş bir karar ihtiyacı, üst amacın korunması için keşfedilmiştir. Dosyaya bilgi yazmak ile onu doğru aktöre ulaştırmak arasındaki fark görünür hale gelmiştir.

Buna karşılık demo; bağımsız ajan koordinasyonunu, otomatik bağlam güncellemesini, oturumlar arası gerçek devamı, yetki denetimini veya uygulamanın çalışmasını doğrulamamıştır. İçinde doğru hesap bulunması, bütün SOUL modelinin doğru olduğunu göstermez. Değeri, tamamlanmış bir ürünün başarı kanıtı olmaktan değil, üzerinde konuşulan çalışma ilişkilerini inceleyebileceğimiz hale getirmesinden gelir.

## 9. Demoda görünür olan proje dosyaları

İlk demoda adı konan dosyalar altıdır. Bunların hepsi, uygulama hakkında bilinenleri, kararları, iş durumunu veya üretilen çıktıları taşır. Konuşmanın ilk aşamasında “İş-001” gibi ortak bir takip kimliği de önerilmiştir. Bunun amacı, farklı aktörlerin aynı talep üzerinde çalıştığını belirginleştirmektir; sabit bir kayıt şeması veya her iş için tek evrensel analiz birimi seçmek değildir. Work ve Information ayrımı da zorunlu iki ayrı dosya veya iki ayrı veri tabanı anlamına gelmez.

| Hayali dosya | İçeriği ve rolü |
|---|---|
| `talep.md` | A₀; kullanıcı ifadesi, sonradan türetilen yorumla değiştirilmeden korunur. |
| `anlayis.md` | C₀, C₁, C₂ ve C₃; mevcut anlayış, bilinenler, çıkarımlar, öneriler ve açık noktalar. |
| `kararlar.md` | Bulgular, öneriler, kararlar ve değişiklik gerekçeleri; örneğin D-02. |
| `isler.md` | W-01–W-04 ile diğer aday işler; durumlar, bağımlılıklar ve sonraki sorumluluklar. |
| `ciktilar/rapor-kurallari.md` | Sayım, oranlar, örnekler, boş veri durumu ve iddia sınırları. |
| `ciktilar/yanit-kurallari.md` | Form alanları, üç farklı seçim yorumu ve girdi uygunluğu kuralları. |

C sürümleri ayrı fiziksel dosyalar olarak gösterilmemiştir. W kimlikleri de ayrı görev dosyaları değil, `isler.md` içinde temsil edilen işler olarak kullanılmıştır. Sentetik örnekler için bağımsız bir test dosyası tanımlanmamıştır.

`kararlar.md` adı, içindeki her şeyin alınmış karar olduğu anlamına gelmemelidir. Demoda bu dosyada bulgu ve öneriler de bulunmuştur. Kalıcı bir yapıda bunların statülerini ayırmak gerekir; dosya adı tek başına epistemik ayrım sağlamaz.

Bu dosyalar “bu projede ne biliyoruz, ne yaptık, hangi durumdayız?” sorusuna cevap verir. “Bu bilgilerle nasıl bir çalışma düzeni işletmeliyiz?” sorusunun cevabı ise demoda henüz aynı açıklıkta paketlenmemiştir.

## 10. Demoda adlandırılmamış olan çalışma bilgisi

### 10.1. Dosyaları üreten ve kullanan yaklaşım nereden geliyordu?

Demodaki işleyiş yalnız altı proje dosyasından doğmamıştır. Konuşma boyunca oluşturulan bağlam, araştırma ayrımları, assistant’ın genel yetenekleri, yürürlükteki çalışma talimatları ve mevcut araç ortamı da kullanılmıştır. Ayrıca anlatıcı, bazı devir ve güncelleme işlemlerini kendi açıklamasıyla gerçekleştirmiştir.

SOUL başka bir bilgisayarda kurulduğunda bu konuşmayı kendiliğinden taşıyor kabul edilemez. Bu nedenle taşınabilir olan yalnızca projenin kayıtları değil, kayıtları üretme ve kullanma sorumlulukları da olmalıdır. Konuşmanın dosya envanteri çalışması bu eksikliği görünür kılmıştır.

### 10.2. Genel işletim bilgisi için hayali adlar

Aşağıdaki dosyalar, ilk demoda varmış gibi gösterilmemiştir. Sonraki konuşmada, ilgili sorumluluklara görünür ad vermek için önerilmiştir. Her sorumluluğun ayrı dosyaya, ayrı ajan çağrısına veya zorunlu sıraya dönüşmesi gerektiği kararlaştırılmamıştır.

| Aday dosya | Taşıyabileceği sorumluluk |
|---|---|
| `SOUL.md` | Giriş noktası; kurallar, proje durumu ve kaynak kütüphanesinin nasıl bulunacağı ve ayrılacağı. |
| `isletim/talebi-anlama.md` | A’yı çözümlenmiş problem saymamak; amaç, yöntem, kullanıcı bilgisi ve çıkarımı ayırmak. |
| `isletim/ise-baslama.md` | İş bazında girdiler, belirsizlik etkisi, önkoşullar, değişme bedeli ve başlama sınırları. |
| `isletim/bilgi-ve-karar-kaydi.md` | Kaynak, gözlem, çıkarım, varsayım, öneri ve kararın statüsünü korumak. |
| `isletim/degisim-ve-yeniden-planlama.md` | Yeni bilginin etkilediği iş ve çıktıları bulmak; koruma, uyarlama ve yeniden açmayı ayırmak. |
| `isletim/inceleme-ve-kapanis.md` | Çıktıyı ilgili iddiaya karşı incelemek; üretim, uygunluk ve gerçek sonuç ayrımını korumak. |
| `isletim/baglam-ve-devam.md` | Güncel bağlamı seçmek, değişiklikleri ilgili işe taşımak ve kesilmiş çalışmayı devralmak. |
| `sozlesmeler/kayit-anlamlari.md` | Kayıt alanlarının yalnız biçimini değil anlamını; örneğin “bitti” ile “kullanıma uygun” ayrımını tanımlamak. |

Bir iş kaydı şablonuna “durum, bağımlılık, sonraki adım” alanlarını koymak bu anlamları kendiliğinden oluşturmaz. Alanların ekip içinde aynı şekilde yorumlanması gerekir. Bu nedenle şablon, kayıt semantiği ve işletim kuralı ayrı ihtiyaçlardır.

### 10.3. İşletim kuralı ile konu bilgisi

“Nasıl çalışmalısın?” ile “çalışırken hangi bilgiden yararlanabilirsin?” aynı değildir. Tekrar gönderim sorununu bulmak için genel sorgulama disipliniyle birlikte kayıt, kişi, oran ve örneklem hakkında konu bilgisi kullanılmıştır.

| Aday dosya | Bilgi rolü |
|---|---|
| `bilgi/temel-ayrimlar.md` | Amaç–yöntem, bilgi–gerçek durum, önkoşul–çözüm, üretim–doğrulama gibi araştırma dayanakları. |
| `bilgi/alanlar/veri-toplama-ve-raporlama.md` | Sayım birimi, payda, tekrar kayıt, eksik veri ve sonuçların yorumu gibi alan bilgileri. |
| `bilgi/KAYNAKLAR.md` | Bilginin kaynağı, sürümü, kapsamı, geçerlilik sınırı ve yeniden başvuru ihtiyacı. |

Alan bilgisinin bütününün kurulum anında SOUL içinde bulunması gerektiği söylenmemiştir. Bazı bilgi paketleri iş sırasında edinilebilir. Bazı yetenekler modelin mevcut kapasitesinde bulunabilir. Kaynaklar veya uzmanlık mekanizmaları gerektiğinde devreye girebilir. Esas koşul, gerekli bilginin elde edilmesi ve doğru statüyle kullanılabilmesidir.

Bir araştırma kaynağının bulunması, içeriğini otomatik olarak bağlayıcı talimat yapmaz. Bulguyu, ondan çıkarılan tasarım tercihinden ve o tercihin sistem içinde kabul edilmesinden ayırmak gerekir. [K05, K08]

### 10.4. Projeye özgü çerçeve ve çağrı bağlamı

Genel SOUL bilgisiyle proje kayıtları arasında, bu iş için geçerli sınırları taşıyan bilgi de gerekir. Demoda bu sınırlar kullanıcının mesajından alınmıştır: Gerçek dosya yazılmayacak, gerçek veri toplanmayacak, uygulama yayımlanmayacak; sentetik örneklerle çalışma modeli incelenecektir.

Bu tür bilgi için `proje/calisma-cercevesi.md` adı önerilmiştir. Bu dosya, uygulamanın özelliklerini değil, mevcut çalışmanın yetki ve teslimat sınırlarını taşır.

`calismalar/W-02/baglam-kaydi.md` ise bir işin hangi sürüm ve bulgularla yürütüldüğünü göstermek için düşünülmüştür. Örneğin C₂, D-02, korunacak seçim kuralları ve kesinleştirilmeyecek tekrar gönderim kararı. Bu bilginin ayrı dosyada mı, iş kaydında mı tutulacağı kararlaştırılmamıştır.

### 10.5. Çalıştırma karşılığı

Bir kural “yeni bilgi ilgili işe aktarılmalıdır” diyebilir. Bir kayıt “W-02, C₂ ile çalışıyor” diyebilir. Fakat bağlamı gerçekten getiren, model çağrısını başlatan, araç sonucunu alan ve güncellemeyi kaydeden işletim de bulunmalıdır.

Bu ihtiyacı görünür kılmak için `calistirma/ayarlar.yaml` ve `calistirma/yurutucu.*` gibi adlar kullanılmıştır. Bunlar seçilmiş teknoloji veya yazılacak kesin dosyalar değildir. Sorumlulukların bir bölümü mevcut ajan ortamınca sağlanabilir; bir bölümü SOUL’un kendi mekanizmalarıyla kurulabilir.

Çalıştırma düzeninin açıklaması Information’dır; gerçekleşen çalıştırma açıklamanın kendisi değildir. Kuralların doğru yazılmasıyla gerekli bütün eylem yollarında gerçekten işlemesi arasındaki sınır korunmalıdır. [K05, K07]

### 10.6. Araştırma deposuna gelecekte başvurma fikri

Konuşmada SOUL’un farklı bilgisayarlarda kurulup başka projelerde kullanılırken araştırma deposuna başvurabilmesi de gündeme gelmiştir. Bu, olası bir kaynak erişim yolu olarak korunmuştur; zorunlu çevrimiçi bağımlılık veya benimsenmiş mimari değildir.

Yerel çalışma kurallarının hangi sürüm ve kabul durumuna dayandığıyla, uzaktaki araştırmanın güncel bulguları ayrı tutulmalıdır. Araştırma değişti diye yerel davranışın sessizce değişmesi kabul edilmiş bir ilke değildir. Erişim, sürüm bağlama, güven, güncellik ve çevrimdışı devam gibi koşullar bu fikir uygulanacaksa ayrıca ele alınacaktır.

## 11. Dosyalar aktörlerin kullandığı ve ürettiği bilgilerdir

Kullanıcının “bunlar aktörlerin kullanacağı dosyalar” düzeltmesi, envanteri başka bir açıdan birleştirmiştir. Proje bilgisi ile işletim bilgisi birbirinden kopuk iki depo değil, aktörün çalışma sırasında farklı amaçlarla kullandığı bilgi türleridir.

Bir aktör; çalışma ilkelerini, alan bilgisini, güncel proje durumunu ve kendisine verilen sorumluluğu birlikte kullanarak işi yürütür. Bunun sonucunda yeni bir çıktı, gözlem, öneri veya karar kaydı oluşur. “Dosyalar Information’dır” ile “aktörler bunları kullanır” birbirinin alternatifi değildir. İlki temsilin niteliğini, ikincisi aktörün bu temsil ile kurduğu ilişkiyi anlatır.

W-03’ü üstlenen aktörün yalnızca “tekrar gönderim politikasını incele” görev adını alması yeterli görülmemiştir. Aktörün nasıl çalışacağına ilişkin ilkeleri; özgün amacı ve güncel durumu; hangi sonucu üretmesi beklendiğini ve hangi kararı veremeyeceğini bilmesi gerekir. Bu bilgilerin bir kısmı ortak, bir kısmı işe özgüdür.

Bu muhakeme disiplini yalnızca ana koordinatörün kullanacağı bilgi olarak düşünülmemiştir. Her aktör kendi sorumluluk alanında eksik önkoşul keşfedebilir, verilen işin yanlış kurulduğunu fark edebilir veya C’nin değişmesini önerebilir. Yeni bilginin tek kaynağı koordinatör olmak zorunda değildir.

Ancak öneri üretmekle ortak çalışma durumunu değiştirme yetkisi aynı değildir. Rol adı, fiilî kapasite, yetki, araç erişimi ve sorumluluk birbirinden ayrılmalıdır. Bir dosyada aktörün yetkili olduğu yazması da gerçek yetkiyi veya mekanik uygulanmasını tek başına kanıtlamaz. [K04]

Bu noktada tasarım sorusu değişmiştir: Önce “hangi dosyalar olmalı?” değil, **“bir aktör belirli bir işi üstlendiğinde hangi bilgi, çalışma standardı, kapasite ve sorumluluk sınırıyla hareket etmeli?”** sorusu sorulmalıdır. Dosyalar, bu ilişkinin taşınabilir karşılıklarından biridir.

## 12. Harness ve üretimin etrafındaki çalışma düzeni

### 12.1. Küçük ürünün çevresinde görünür hale gelen büyük problem

Demo, form kodunu üretmekten daha geniş bir düzeni görünür hale getirmiştir. Güncel bilginin korunması, farklı oturumlarda çalışmanın devralınması, açık kararların unutulmaması, yeni bulgunun ilgili işe ulaşması ve kullanıcının sürekli koordinatörlük yapmak zorunda kalmaması, tek bir üretim eyleminden farklı sorumluluklardır.

Kullanıcının “ortam işten daha büyük görünüyor” gözlemi, daha sonra açıkladığı üzere büyüklükten yakınma değildir. Kodlamayı önemsiz görme de değildir. Kodlama, gerekli bağlam ve kararlar kurulduğunda görece daha tanımlı ve öngörülebilir bir faaliyet olarak düşünülmüştür. Buna karşılık ajanların işi hakkıyla yapmasını sağlayan profesyonel düzenin kapsamı daha görünür hale gelmiştir.

Bu düzeltme önemlidir. Gözlemi hemen maliyet kaygısı gibi yorumlayıp daha az dosya ve daha az mekanizma önermeye yönelmek, kullanıcının asıl farkındalığını kaçırır. Önce gerekli kapasitenin ne olduğu anlaşılmalıdır; sadeleştirme bunun yerine geçmemelidir.

### 12.2. Harness’in bu konuşmadaki karşılığı

Repository’deki Harness araştırması, kavramı model dışı işletim ve kontrol sorumlulukları üzerinden ele alır: ajan döngüsü, araç arayüzleri, bağlam ve bellek yönetimi, yetki sınırları, koordinasyon, doğrulama, gözlemlenebilirlik ve çalışma sürekliliği. Bu kullanımda harness yalnız bir system prompt, ajanlar arası görev dağıtımı veya dosya kümesi değildir. [K07]

Bir çalışma kaydının sonraki oturumda bulunması, aracın hatasının anlaşılır biçimde geri dönmesi, işlemin durdurulması, sonucun gözlenmesi ve belirli sınırların gerçekten korunması harness tarafındaki sorumluluklar olabilir. Hangi parçayı mevcut ajan ortamının, hangisini SOUL’un sağlayacağı konuşmada kararlaştırılmamıştır.

Harness, muhakemeyi yok eden bir mekanizma olarak düşünülmemelidir. Bazı koşullar mekanik olarak korunabilir; bazı kararlar yorum gerektirir. Eski sürüm üzerine yazmayı fark etmek araç seviyesinde ele alınabilir. Yeni bilginin kullanıcının amacını değiştirip değiştirmediği ise yalnızca bir dosya kilidiyle cevaplanamaz.

### 12.3. Ürün keşfi, işletim yükü ve üretim işi farklıdır

Demodaki bütün faaliyeti ajan yönetim masrafı saymak da yanlış olur. “Kişi mi, gönderim mi sayıyoruz?” sorusu ürünün doğru tanımlanmasıyla ilgilidir. Bu kararı ilgili aktöre ulaştırmak ve ertesi gün de korumak çalışma sürekliliğiyle ilgilidir. Seçilmiş kurala göre formu, hesaplamayı ve ekranı oluşturmak ise üretim işidir.

Bu ayrım, görünürdeki büyüklüğün hangi kısmının ürünün kendi problemi, hangi kısmının uzmanlık değerlendirmesi, hangi kısmının tekrar kullanılabilir işletim kapasitesi olduğunu anlamayı sağlar. Kodun yazılmasının kolay görünmesi, doğru ürünün kendiliğinden belli olduğu anlamına gelmez.

### 12.4. Ortak kapasite ile projeye özgü faaliyet

SOUL’un genel çalışma kabiliyetleriyle tek projenin faaliyeti farklı büyüklüklerdir. Güncel durumu bulma, değişiklikleri taşıma veya sorumluluk sınırlarını koruma düzeni her uygulamada yeniden icat edilmek zorunda değildir. Bunlar ortak kapasite olarak kurulabilir; her proje gerekli kısmını kullanır.

Bununla birlikte bir kere kurulmuş kapasitenin bakım veya kullanım maliyetinin sıfır olduğu varsayılmaz. Bağlam yükleme, kontrol, koordinasyon ve kayıt güncelleme sürer. Harness araştırması da ek mekanizmanın yeni hata yüzeyleri ve maliyetler yaratabileceğini, model ve görev koşulları değiştikçe yeniden değerlendirilmesi gerektiğini belirtir. [K07]

Konuşmanın son düzeltmesine göre buradaki tasarım amacı, gerekli profesyonel kapasiteyi baştan küçük görmek değildir. Amaç, bu kapasiteyi kurduktan sonra hangi katılım ve mekanizmaların gerektiğini yetkin biçimde seçmektir. Sorumlulukları ayrı adlandırmak, hepsini ayrı dosya, ayrı ajan veya her adımda zorunlu tekrar haline getirmek anlamına gelmez.

### 12.5. Bozulmadan devam etmek, hiç değişmemek değildir

Çalışma düzeninin korunması, ilk planın değişmeden uygulanması olarak anlaşılmamalıdır. C değişebilir, yöntem terk edilebilir, işler yeniden sıralanabilir, bir çıktının kullanım koşulu daralabilir ve çalışma durdurulabilir.

Korunacak şey; değişim sırasında amacın, bilginin kaynağının, mevcut gerçekliğin, yapılmış işin anlamının ve sorumlulukların kaybolmamasıdır. Sabitlik hedefi planın biçimine değil, bu ayrımların yönetilebilir kalmasına ilişkindir.

## 13. İşin boyutundan bağımsız profesyonel standart

### 13.1. Konuşmanın belirleyici düzeltmesi

Kullanıcı, tek katlı ev, gökdelen ve köpek kulübesi örnekleriyle işin büyüklüğü ile çalışma disiplininin farklı eksenler olduğunu anlatmıştır. Temelin fiziksel boyutu değişebilir; fakat gerekliliğini doğru değerlendirme, uzmanlık gerektiren kararı yetkinlikle verme ve işi hakkıyla yapma sorumluluğuna verilen önem değişmemelidir.

Bu örnekler gerçek yapılara ilişkin mesleki yetki veya teknik tasarım kuralı önermek için kullanılmamıştır. Tesisat, mimar veya usta ifadeleri, konuşmada uzmanlık fonksiyonunun sahipsiz bırakılmaması ilkesini anlatan analojilerdir.

Çıkan ilke şudur: **İşin küçük olması, gerekli uzmanlık değerlendirmesini atlama gerekçesi değildir. Değerlendirmenin sonucunda yapılacak iş küçük çıkabilir.**

### 13.2. Sade ürün ile düşük mesleki standart aynı değildir

Bir butonun yalnız işlevini yerine getirmesi yeterli bulunabilir. Başka bir fazda aynı buton için animasyon, görsel incelik veya daha kapsamlı kullanıcı deneyimi hedeflenebilir. Bu ürün kapsamının değişmesidir.

Buna karşılık butonun çalıştığını kontrol etmeden çalışıyor diye bildirmek, bir varsayımı karar gibi kaydetmek veya kaynakları yanlış temsil etmek ürünün küçük olmasıyla açıklanamaz. Ürün daha sade olabilir; mesleki dürüstlük, sorumluluk ve sorgulama standardı aynı kalmalıdır.

Konuşmadaki “hep en üst düzey” ifadesi, her küçük işte bütün uzmanların aynı süre çalışması veya sonsuz araştırma yapılması şeklinde yorumlanmamalıdır. İfade, gerekli kalite değerlendirmesini ciddiye alma, sınırları dürüstçe tanıma ve işin boyutunu özensizlik iznine dönüştürmeme ilkesini taşır. Gerekli derinlik ve katılım, bu standarda uygun değerlendirme sonucunda belirlenir.

Başarısızlık kaygısı veya işi hakkıyla yapamama korkusu gibi insan örnekleri de ajanlardan duygusal deneyim beklenmesi anlamına gelmez. SOUL açısından karşılığı, ilgili riskleri göz ardı etmeyen, eksikliği görünür kılan ve yeterlilik iddiasını kanıtıyla sınırlayan davranış disiplinidir.

### 13.3. Uzmanlığın gerekliliğine ilişkin karar da uzmanlık gerektirebilir

“Bu küçük işte uzmana gerek yok” kararı, işin alanını yeterince anlamayan bir yöneticinin yalnız boyuta bakarak vereceği muafiyet olmamalıdır. Gerekli uzmanlık değerlendirmesinin bir sahibi olmalıdır. Uzman değerlendirmesi, katılımın sınırlı kalabileceğini veya ek çalışmanın gerekmeyeceğini gösterebilir.

Köpek kulübesi örneğinin taşıdığı anlam budur. Çok sınırlı bir değerlendirme bile köpeğin boyutu ile kapı açıklığı arasındaki ilişkiyi görünür kılabilir. Burada değer, büyük bir tasarım dosyası üretmekten değil, ilgili bakışın devreye girmesinden gelir.

Bunu her konu için ayrı, sabit isimli bir ajan açma zorunluluğuna çevirmek de doğru değildir. Korunacak şey, gerekli fonksiyonun yetkin biçimde yerine getirilmesidir. Rolü hangi aktörün veya hangi çalışma düzeninin üstleneceği ayrıca belirlenir.

### 13.4. Alet çantası örneği

Usta yalnız bir çivi çakacak diye bütün hazırlık ve mesleki birikiminden vazgeçmez. Alet çantası hazırdır; somut işte gereken araç kullanılır. SOUL açısından bu, bütün kaynakların her çağrıya yüklenmesi anlamına gelmez. Gerekli kaynak ve araçların bulunabilir, erişilebilir ve kullanılabilir olması anlamına gelir.

Seçicilik ile yetersizlik karıştırılmamalıdır. İlgisiz bilgiyi o çağrıya almamak profesyonel standardı düşürmez. Ancak iş küçük göründüğü için gerekli bilginin veya uzmanlık değerlendirmesinin hiç sunulmaması farklıdır.

Bu nedenle ölçeklendirme, çalışma kültürünün alternatifi değildir. **Ölçeklendirme, o kültürün ürettiği mesleki bir karar olmalıdır.**

## 14. Uzmanlığı çağırmak, bir rol etiketi vermekten fazlasıdır

### 14.1. İnsan uzman örneğinden çıkan ihtiyaç

Mimar çağrıldığında yalnızca “mimar” adlı bir kişi veya rol çağrılmış olmaz. Eğitim, mesleki yöntemler, önceki deneyimler, kaynaklar, çalışma defterleri, araçlar ve sorumluluk anlayışı da işe katılır. Kullanıcının büyüklük olarak fark ettiği şey, SOUL’da bu bütünün neyle karşılanacağıdır.

Bir LLM çağrısına “uzmansın” demek, bu kapasiteyi kendiliğinden yaratmaz. Rol etiketi, yetkinlik, yetki, sorumluluk ve gerçek araç erişimi ayrı tutulmalıdır. Ajanın doğru metin üretmesiyle ilgili işi hakkıyla üstlenmeye hazır olması da aynı değildir. [K04]

### 14.2. Her çağrıda yeniden öğrenilen şey nedir?

Konuşmada ajanların kalıcı hafızası olmadığı için bir uzmanın bütün eğitim ve deneyiminin her seferinde yeniden öğrenilmesi gerektiği düşüncesi ortaya çıkmıştır. Teknik düzeltme şudur: Yeni oturum açılması, modelin eğitimle kazandığı genel kapasitenin sıfırlanması değildir. Çalışma bağlamının yeniden kurulması ile yeniden eğitim farklıdır. [K05, K06]

Asıl süreklilik sorunu; kurumun çalışma ilkeleri, bu projede öğrenilenler, alınmış kararların gerekçeleri, açık kalan sorular, geçmiş deneyimlerin geçerliliği ve aktörün o andaki sorumluluğudur. Bunların yeni çağrıya kendiliğinden taşındığı varsayılamaz.

Bu nedenle hedef, “uzmanı her seferinde baştan eğitmek” değil, **uzmanlığın bu işe yetkin ve güncel biçimde katılmasını sağlayan bağlamı yeniden kurmak** olarak tanımlanmıştır.

### 14.3. Birbirinden ayrılması gereken dört taşıyıcı

| Unsur | SOUL açısından anlamı |
|---|---|
| Genel mesleki kapasite | Modelin mevcut bilgi ve becerileri; gerektiğinde başvurulabilecek uzmanlık kaynakları ve araçlar. |
| Çalışma kültürü ve sorumluluk | Standart, görev alanı, sorgulama yükümlülüğü, yetki ve durma sınırları. |
| Birikmiş deneyim | Önceki olaylar, sonuçlar, hatalar, işe yarayan yöntemler ve bunların geçerli olduğu koşullar. |
| Güncel iş durumu | A, mevcut C, kararlar, açık sorular, üretilen çıktılar ve sıradaki sorumluluk. |

Bunları tek bir dev isteme dönüştürmek zorunlu değildir. Ama gerekli olan parçaların seçilip görünür hale gelmesi gerekir. Alet çantasının hazır olmasıyla bütün aletlerin aynı anda elde tutulması arasındaki ayrım burada da geçerlidir.

### 14.4. Birikim, kaydedilmiş her iddianın doğru sayılması değildir

Bir ajanın önceki işte yazdığı yorum, kalıcı belleğe girdi diye doğrulanmış mesleki bilgi olmaz. Gözlem, çıkarım, geçici çözüm, kabul edilmiş karar ve doğrulanmış sonuç ayrı tutulmalıdır. Geçerli bir deneyim daha sonra koşullar değiştiği için uygulanamaz hale gelebilir.

Bellek araştırması bu nedenle yalnız saklama ve geri çağırmayı değil; doğrulama, birleştirme, güncelleme, çelişki yönetimi, geçerlilik ve gerektiğinde unutmayı da ele alır. Kalıcılık doğruluk değildir; geri çağrılan bilginin görünür hale gelmesi de fiilen doğru kullanıldığını kanıtlamaz. [K06]

SOUL’un deneyim kazanması, hatalı genellemeleri tekrar tekrar kullanması şeklinde kurulamaz. Birikimin değeri, neden ve hangi koşullarda kullanılabileceğinin korunmasına bağlıdır.

## 15. Uzmanlık sürekliliği ve aktörün işe hazır olması

### 15.1. Sorumluluk, tek bir görev kartından uzun yaşayabilir

Önceki demo ağırlıklı olarak “iş bulunur, aktöre verilir, aktör yapar” biçiminde görünmüştür. Uzman örneği bunun öncesindeki sorumluluğu açmıştır: Hangi işlerin gerekli olduğunu anlamak için de uzmanlık gerekir.

Koordinatörün bütün gerekli işleri önceden doğru keşfedip sonra uzmanlara dağıtması beklenirse, uzmanlığın önemli bölümü zaten koordinatöre yüklenmiş olur. Diğer aktörler yalnız önceden tanımlanmış görevlerin uygulayıcıları haline gelir.

SOUL için geliştirilen düşünce farklıdır: Uzmanlık rolü, kendisine verilen işi yapmakla birlikte sorumlu olduğu açıdan girişimi değerlendirmeli; eksik gereksinimi, yanlış kurulmuş işi veya gereksiz işi görünür kılabilmelidir. Actors araştırması da süregelen sorumluluğun belirli bir anda aktif Work bulunmadan devam edebileceğini ayırır. [K04]

Bu, sürekli çalışan bir ajan zorunluluğu değildir. İlgili uzmanlık sorumluluğunun görev kartı yokken sahipsiz kalmaması demektir. Rolün ne zaman çağrılacağı ve bu çağrının nasıl tetikleneceği henüz çözülmemiş tasarım konularıdır.

### 15.2. Raporlama sorumluluğuna yeniden bakmak

SOUL’da “veri ve rapor doğruluğu” sorumluluğu bulunduğunu düşünelim. Bu sorumluluğun ilkesi, sayısal ifadelerin toplanan verinin desteklediği anlamı taşımasını gözetmektir.

Küçük form uygulamasında bu değerlendirme kişi–gönderim, seçim payı–katılımcı oranı ve veri yokluğu–sıfır sonuç ayrımlarını gündeme getirebilir. Ardından “şu aşamada ileri model gerekmiyor; sayım birimi ve tekrar gönderim kuralı çözülmeli” sonucuna varabilir.

Sadeleşme böylece uzmanlık incelemesinden önce verilmiş bir muafiyet değil, incelemenin sonucu olur. Bu ilk değerlendirme bütün geleceği bilmek zorunda değildir; kendi kapsamı ve açık bıraktığı koşullarla kayda geçer.

Birkaç gün sonra tekrar katılım kuralı değişirse, yeni çağrılan aktör yalnızca rol adını değil; önceki değerlendirmenin dayanağını, açık koşullarını ve değişikliği de görmelidir. Oturum değişebilir, fakat aynı sorumluluk güncel bilgilerle yeniden üstlenilir.

### 15.3. İşin hazır olması ile aktörün hazır olması

Konuşmanın sonunda iki ayrı soru birlikte görünür hale gelmiştir:

**Bu belirli iş, mevcut bilgi ve koşullarla başlanabilir mi?**

**Bu işi üstlenecek aktör, gereken kapasiteye, güncel bağlama, araçlara, sorumluluk anlayışına ve yetki sınırına gerçekten sahip mi?**

İşin tanımı iyi kurulmuş olabilir; fakat aktör gerekli kaynağa erişemeyebilir. Aktör yetkin olabilir; fakat gerekli ortam hazır olmayabilir. Araç teknik olarak kullanılabilir olabilir; fakat o eylem için yetki bulunmayabilir. Bunlar tek bir “hazır” etiketine indirgenmemelidir. [K02, K04]

Rolü üstlenmeye hazır olmanın nasıl sınanacağı, hangi bilgilerin zorunlu olarak yeniden kurulacağı ve hangi bağımlılıkların değiştiğinde hazırlık hükmünü etkileyebileceği açık tasarım sorularıdır. Bu konuşma bunları cevaplamış değil, çalışma modelinin gerekli soruları haline getirmiştir.

### 15.4. Hesap verilebilirlik ve sınırlar

Sorumluluğun adı olması, hatanın ortadan kalkacağı garantisi değildir. Kullanıcının uzman örneğinde vurguladığı nokta, ilgili fonksiyonun bilinçli olarak üstlenilmesi ve sorun çıktığında muhatabının belli olmasıdır.

SOUL’da operasyonel rol veya ajan sorumluluğu tanımlamak, modelin kendiliğinden hukuki ya da kurumsal hesap verebilir kişi haline geldiği anlamına gelmez. Gerçek yetkilendirme ve hesap verebilirlik ilişkileri ayrıca belirlenmelidir. Araştırmanın aktör, rol, yetki, teknik etki gücü ve atıf ayrımları bu sınırı korur. [K04]

## 16. Ortaya çıkan bütün: İşe uygun profesyonel çalışma kapasitesi

Konuşmanın başında soru, küçük bir talebin Work ve Information içinde nasıl ele alınacağıydı. Ulaşılan çerçevede bu iki alanın kendi kendine işlemediği, aktörlerin uzmanlık ve sorumluluk ilişkileri içinde bilgi kullanarak işi yürüttüğü, ortamın da bu kapasiteyi fiilen kullanılabilir kıldığı görülmektedir.

**Information**, talebi, çalışma anlayışını, kaynakları, yöntemleri, kuralları, sonuçları ve deneyimi taşır. **Work**, amaçlı uğraşın seçilmesi, düzenlenmesi, yürütülmesi ve değişimini ele alır. **Actors**, kimlerin hangi kapasite ve sorumlulukla katıldığını, hangi kararları verebildiğini ve eylemlerin nasıl atfedildiğini ele alır. **Environment**, erişimlerin, araçların, kaynakların ve gerçekleşen koşulların fiilî tarafını taşır. Bunlar bu belgede dört zorunlu klasör veya dört yazılım servisi değildir; araştırmadan kullanılan farklı inceleme alanlarıdır. [K02, K03, K04, K10]

Harness, bu ilişkilerin çalıştırma, bağlam, araç, kontrol ve süreklilik boyutlarının önemli bölümünü işletir. Ancak mesleki standardın veya konu uzmanlığının bütününü yalnızca çalışma döngüsü kurarak sağlamış sayılmaz. Doğru kaynak, yeterli kapasite, doğru sorumluluk ve gerçek ortam koşulları ayrıca gerekir.

Bu bütün içinde SOUL’dan beklenen yalnızca “bir sonraki görevi üretmesi” değildir. Talebi anlamaya çalışırken gerekli işi keşfetmesi; bunu yapabilmek için hangi uzmanlığın gerektiğini de değerlendirmesi; ilgili aktörün çalışma bağlamını kurması; ortaya çıkan sonuçları uygun statüyle koruması; yeni bilgiyle ilgili işleri ve hükümleri yeniden değerlendirmesi beklenir.

Burada kendini çoğaltan sonsuz bir meta-sistem tasarımı yapılmamaktadır. Her yeni ihtiyacı yeni ajan, yeni dosya veya yeni kontrol katmanı kurmaya çevirmek gerekmez. Başlangıçta gerçekten mevcut olan kapasite ve kaynaklardan hareket edilir; eksik olan koşul gerekçelendirilir. Fakat bu sınırlılık, küçük iş adına gerekli uzmanlık fonksiyonunu atlamanın gerekçesi de olamaz. [K08]

Konuşmanın üç ana ilkesi birlikte okunmalıdır: **İşin boyutundan bağımsız mesleki standart; o standarda göre belirlenen çalışma ve uzmanlık kapsamı; oturumların ötesinde korunan bilgi ve sorumluluk sürekliliği.** Bu ilkelerden biri diğerinin yerine geçmez. Sadece yüksek standart yazmak işletim yaratmaz; sadece işletim kurmak uzmanlık yaratmaz; sadece deneyim depolamak güncel ve doğru kullanım sağlamaz.

## 17. Henüz kararlaştırılmamış konular

Bu konsolidasyon, konuşmanın ortaya çıkardığı yönelimi korur; onu bitmiş tasarım gibi sunmaz. Aşağıdaki konular sonraki çalışma alanlarıdır, otomatik olarak başlatılmış görevler değildir.

### 17.1. C’nin temsil biçimi ve değişiklikleri

C’nin tek belge, birbiriyle bağlı kayıtlar veya başka bir temsil olup olmayacağı seçilmemiştir. Bir C sürümü değiştiğinde hangi iddia ve çıktının etkilendiğinin nasıl bulunacağı da kurulmamıştır. Geçmiş sürümü korumak, güncel görünümü belirlemek ve kısmi geçerliliği göstermek ayrı gereksinimler olarak görünürdür.

### 17.2. Uzmanlık gereksiniminin keşfi

Hangi durumda hangi uzmanlığın çağrılacağı, bu ilk ayrımı kimin yapacağı ve uzmanlık boşluklarının nasıl fark edileceği açık kalmıştır. İlke, gerekli fonksiyonun boyuta dayalı muafiyetle sahipsiz bırakılmamasıdır. Bunun somut karar mekanizması ayrıca çalışılmalıdır.

### 17.3. Aktörün hazırlığı ve kapasite seçimi

Rol adıyla yeterliliği eşitlemeden aktörün işe hazır olduğuna nasıl karar verileceği; hangi model, kaynak ve araçların gerektiği; hangi değişikliklerde bu hükmün yenileneceği belirlenmemiştir. Bu yalnız daha uzun prompt yazma sorunu olarak görülmemelidir.

### 17.4. Öneriden ortak duruma geçiş

Bir aktörün bulgusunun ne zaman yalnız öneri, ne zaman kabul edilmiş karar ve ne zaman yürürlüğe giren çalışma değişikliği sayılacağı açıklığa kavuşturulmalıdır. Ortak kayıtların kim tarafından, hangi kontrol ve yetkiyle güncelleneceği demoda gösterilmemiştir.

### 17.5. Bağlamın gerçek dolaşımı

Güncel kaynağın bulunması, seçilmesi, ilgili çağrıya aktarılması ve gerçekten kullanılması farklı koşullardır. Demodaki anlatıcı aktarımı, bağımsız SOUL’da çalışacak bir mekanizma yerine geçmez. Devir, kesinti, eski sürüm ve eşzamanlı değişiklikler gerçek işletim tasarımına aittir.

### 17.6. Birikimin mesleki bilgiye dönüşmesi

Deneyimlerin nasıl doğrulanacağı, genelleneceği, sınırlanacağı, güncelleneceği ve gerektiğinde terk edileceği açık bir konudur. Geçmişte başarılı görünen bir uygulama, başka bir iş için otomatik kural olamaz. Dış araştırma kütüphanesiyle yerel çalışma standardının ilişkisi de burada önemlidir.

### 17.7. Profesyonel standardın somut karşılığı

İşe gösterilen ciddiyetin hangi gözlenebilir davranış ve sonuçlarla temsil edileceği belirlenmelidir. Çok belge üretmek, çok ajan çağırmak veya çok kontrol yapmak tek başına yüksek standart göstergesi değildir. Aynı şekilde az mekanizma kullanmak da kendiliğinden olgunluk kanıtı değildir. İlgili gerekliliklerin karşılanıp karşılanmadığına bakmak gerekir.

### 17.8. Demodan gerçek çalışma modeline geçiş

Bu konuşma fikir üretme ve ortak bağlam oluşturma aşamasıdır. Gerçek uygulamaya geçildiğinde bağlam devri, izin sınırları, sonuç doğrulama, çalışma kesintileri ve yeniden başlama gibi davranışların gerçekten işlediğine dair kanıt gerekecektir. Bu gereklilik, bugünkü konuşmayı hazır bir ürün sınavına çevirmemelidir; kavramsal demoyla işletim doğrulamasının sınırını korur.

## 18. Konsolide çalışma tezi

SOUL’u yalnızca kullanıcı talebini görev listesine çeviren veya kod üreten bir ajan olarak düşünmek, konuşmanın ulaştığı kapsamı karşılamamaktadır. Talep, henüz bütün amacı ve gerekli koşulları taşımayabilir. Bu eksikliğin giderilmesi de işin parçasıdır; kullanıcıdan tüm keşfi önceden yapması beklenmez.

Mevcut çalışma anlayışı C, eylemden önce bitirilmesi gereken donmuş bir tanım değildir. Bilgi edinme ve üretim işleri birlikte ilerleyebilir. Başlama kararı, belirli bir işin belirli koşullar altındaki uygunluğu üzerinden verilir. İşin sonuçları C’yi, değişen C de ilgili işleri yeniden şekillendirir. Bu dönüşümün kaynağı, gerekçesi ve etkisi korunmalıdır.

Bunu yapanlar, dosyalar veya kendi kendine çalışan kavramlar değil; sorumluluk üstlenen aktörlerdir. Aktörün yalnızca bir role çağrılması yeterli değildir. Gerekli mesleki kapasite, çalışma standardı, güncel bağlam, birikim, araçlar ve yetki sınırlarıyla işe katılması gerekir. Bazı sorumluluklar, aktif bir görev veya tek bir oturum bulunmasa da devam eder.

Bu nedenle SOUL’un kurulması, her proje için çok sayıda kural üretmekten ibaret değildir. **İşin boyutundan bağımsız bir profesyonel çalışma kültürünün; işe göre belirlenen uzmanlık katılımıyla, güncel bilgiyle ve gerçek işletim kapasitesiyle buluşmasını sağlamaktır.** Küçük ürün, küçük kapsamda aynı standardı taşıyabilir. Büyük ürün daha fazla çalışma gerektirebilir; standardın ciddiyeti bununla birlikte açılıp kapanmaz.

Bu tez, üzerinde çalışılabilecek bir tasarım yönelimidir. Hangi mimarinin bunu gerçekleştireceği, nasıl temsil edileceği ve hangi koşullarda güvenilir biçimde çalışacağı henüz seçilmiş veya doğrulanmış değildir.

## Ek A. Konuşmada değişen kabuller ve korunan düzeltmeler

Bu tablo ana metnin yerine geçen bir özet değildir. Sonraki okumada eski bir ifadenin bağlamından koparılıp son görüş gibi kullanılmasını önlemek için değişim izini korur.

| Başlangıçtaki ifade veya yönelim | Konuşmada yapılan düzeltme |
|---|---|
| Örnek uygulama için iş kartı ve görev düzeni kurmak yeterli cevap olabilir. | Asıl soru, araştırma ve çalışma bağlamının LLM’de nasıl bir yönelim doğurduğudur; kart bu düzenin çıktılarından biridir. |
| A, doğrudan yapılacak Work olarak alınabilir. | A kaynak taleptir. Amacı, kapsamı ve gerekli işleri keşfetmek de Work olabilir; A otomatik teslim taahhüdü değildir. |
| A’dan C’ye gitmek, gizli bir doğru tanımı bulmaktır. | C, kullanıcı amacı ve öğrenilenlerle birlikte gelişen mevcut anlayıştır; birden fazla makul yorumla başlanabilir. |
| Talebin arkasındaki bütün olası işleri eklemek, daha eksiksiz çözüm üretir. | Genişlik amaç tarafından gerekçelendirilmelidir. Roman talebi her durumda yayıncılık, dağıtım ve reklam işi değildir. |
| C yeterince tamamlandıktan sonra anlama biter ve yürütme başlar. | Küresel bir kapanış yoktur. Keşif ve üretim işleri, kendi koşullarına göre birlikte ilerler. |
| İlk adımın değişmeyeceğinden emin olmak gerekir. | Mutlak garanti yerine makul değişiklikler, işin dayanıklılığı, yeniden çalışma ve dış etki bedeli değerlendirilir. |
| Dağıtım işinin yazarın listesinden çıkması, gerekliliğin ortadan kalkmasıdır. | Okura erişim koşulu korunabilir; yöntem ve sorumlu değişmiş olabilir. |
| İş ilerledikçe A ile C ölçülebilir biçimde eşitlenir. | Bilgi zenginliği, belirsizlik ve gerçekleşmiş sonuç ayrı eksenlerdir. C’nin kararlılığı da zorunlu olarak tek yönlü artmaz. |
| Demo akışı, bağımsız işleyen SOUL mekanizmasını gösterir. | Bazı bağlam ve devir işlemleri anlatıcı tarafından yapılmıştır; gerçek işletim doğrulanmamıştır. |
| Altı proje dosyası çalışma düzeninin tamamını taşır. | Muhakeme sorumlulukları, kayıt semantiği, alan bilgisi, çağrı bağlamı ve çalıştırma düzeni de gereklidir. |
| Bu dosyalar yalnız Information’ın iç düzenidir. | Aktörlerin kullandığı ve ürettiği bilgilerdir; kullanım, sorumluluk ve yetki ilişkileri ayrıca önemlidir. |
| Ortamın büyük görünmesi, önce hafifletmeye yönelmeyi gerektirir. | Kullanıcı büyüklükten yakınmamıştır; profesyonel kapasitenin kapsamını fark etmiştir. Sadeleştirme, yeterli değerlendirmeden sonra gelir. |
| Küçük işte daha düşük çalışma standardı yeterlidir. | Ürün kapsamı değişebilir; mesleki dürüstlük, sorgulama ve sorumluluk standardı küçülmez. |
| Uzman, önceden eksiksiz tanımlanmış işi yapan kişidir. | Hangi işlerin gerekli olduğunu keşfetmek de uzmanlık sorumluluğunun parçasıdır. |
| Ajan her çağrıda bütün mesleki eğitimini yeniden öğrenir. | Modelin genel kapasitesiyle işe özgü bağlamın ve dış birikimin yeniden kurulması farklıdır. |
| Bir uzman rolünü çağırmak, uzmanlığı işe katmaya yeter. | Kapasite, güncel bilgi, araçlar, sorumluluk ve yetkiyle gerçekten hazır hale gelmesi gerekir. |
| Work hazırsa yürütme başlayabilir. | İşin hazırlanmış olmasıyla onu üstlenen aktörün ve ortamın hazır olması ayrı değerlendirmelerdir. |

## Ek B. Kullanıcının çiziminin metindeki karşılığı

Özgün çizim, bu konuşmada paylaşılan yatay defter görüntüsüdür. Sol tarafta kısmen görülen A’dan C₁, C₂ ve C₃ gibi adaylara, bunların ardından C₄’e geçilir. Üst çizgide C’nin sonraki durumları, alt çizgide “Work başladı” ve W₁–W₄ adımları gösterilir. İş adımlarından üstteki anlayış çizgisine çıkan oklar, çalışma ilerlerken C’nin yeniden ele alınmasını görünür kılar.

Kullanıcının açıklaması çizimin önemli tamamlayıcısıdır: Değişiklik yalnız Work’ten C’ye doğru değildir. C değişerek yapılacak işi değiştirebilir; işin içinde veya sonunda öğrenilenler de C’yi değiştirebilir. Bütün C’nin tamamlanması beklenmeden, mevcut anlayış altında uygun bir adım başlatılabilir.

Çizimde ilk kez “Work başladı” yazan nokta, ana metinde bütün Work’ün ontolojik başlangıcı olarak alınmamıştır. C’nin oluşması için yapılan keşif de iş olabilir. Çizim, daha çok belirli üretim işlerinin başlayabildiği noktayı anlatan sezgisel model olarak korunmuştur.

C alt indisleri konuşmanın farklı yerlerinde hem alternatif anlayışları hem ardışık sürümleri göstermek için kullanılmıştır. Bunlar tek bir küresel numaralandırma değildir. Demo kendi içinde C₀–C₃ ilerleyişini kullanır; bu numaralar çizimdeki C₄–C₆’nın gerçek kayıt kimlikleri olarak yorumlanmamalıdır.

Özgün görüntü PDF sürümünde bu bölümde yer alır. Markdown sürümünde çizimin anlamı yukarıdaki açıklamayla taşınmaktadır.

<!-- ORIGINAL_USER_SKETCH -->

## Ek C. Konuşma kapsamının bölüm karşılıkları

Bu eşleme, konsolidasyonun farklı konuşma katkılarını nerede taşıdığını denetlemek için hazırlanmıştır. Sözcüğü sözcüğüne transkript değildir; her tekrar ayrı yeniden basılmamıştır. Ayrı anlam taşıyan konu, örnek, düzeltme ve açık sınırların karşılıkları gösterilir.

| Konuşma katkısı | Bu metindeki karşılık |
|---|---|
| Küçük form/rapor uygulamasının SOUL’da nasıl işletileceği; araştırmaya dayanma ve küçük adımlarla derinleşme isteği | Kapsam, Bölüm 1 ve 8. |
| Uygulamanın değil, LLM’in araştırma ve SOUL girdileriyle oluşturduğu çalışma yöneliminin odakta olması; token benzetmesi | Bölüm 1 ve 2. |
| İş adımlarından önce ortaya çıkacak sonucu ve işin büyüklüğünü anlama; ihtiyaç ile teknoloji kararını ayırma | Bölüm 4 ve 6. |
| Kullanıcının söylediği A, zihnindeki B ve keşifle oluşan C; konuşmanın hazır ürün testi olmadığı vurgusu | Kapsam, Bölüm 3 ve 8.8. |
| Romanın yazılmasından sonraki hayatı; amaç ve gerçek iş sınırı; gereksiz genişleme tehlikesi | Bölüm 4 ve 5. |
| Çizim; anlama/yürütme ayrımının sürekli mekanizmaya dönüşmesi; yayınevi/dağıtım örneği; C’nin zamanla kararlılığı | Bölüm 5, 6, 7 ve Ek B. |
| Gerçek yazma ve bağımsız ajan çalıştırma olmadan somut demo; C ve W değişiklikleri | Bölüm 8’in bütünü. |
| Demodaki altı dosya ile eksik işletim/alan bilgisi; bağımsız SOUL ortamı; araştırma deposuna ileride başvurma fikri | Bölüm 9 ve 10. |
| Dosyaların aktörlerin kullandığı materyaller olarak anlaşılması | Bölüm 11. |
| Üretimin etrafındaki düzenin büyüklüğü; harness sorusu; kodlamanın görece öngörülebilirliği | Bölüm 12. |
| Büyüklükten yakınmama düzeltmesi; ev/gökdelen/kulübe; uzman değerlendirmesi; sade ürün–sabit disiplin; alet çantası | Bölüm 13 ve 14. |
| Mimarın birikimi ile ajan bağlamı; mesleki kapasitenin ve sorumluluğun oturumlar ötesinde sürdürülmesi | Bölüm 14 ve 15. |
| İşin hazır olmasıyla aktörün hazır olması ayrımı; bir sonraki kavramsal yön | Bölüm 15–17. |
| Diyaloğu daraltmadan bütünlüklü metne dönüştürme isteği | Belgenin tamamı; değişim izi ve kapsam eşlemesi için Ek A–C. |

## Ek D. Araştırma dayanakları ve kaynak sınırları

Ana kaynak bu konuşmadır. Aşağıdaki repository dosyaları, konuşma boyunca kullanılan araştırma ayrımlarının geri bulunması içindir. İlgili bulguların burada kullanılması, bu konuşmada önerilen dosya düzeninin veya SOUL çalışma modelinin araştırma tarafından doğrulanmış olduğu anlamına gelmez.

**Repository:** `batuhanozgun/agentic-os-search`  
**Bu konsolidasyon sırasında gözlenen main HEAD:** `634ab66f195130d551d58dfc062639e0feec23fa`

Aşağıda verilen blob kimlikleri, konuşmada erişilen dosya içeriklerini tanımlar. Kaynakların tarihsel başlıklarında “değerlendirme bekleniyor” gibi ifadeler bulunabilir; güncel kabul ve yetki durumu ilgili STATE yüzeyleriyle değerlendirilmiştir. Bu belge, kaynakların güncel durumunun ikinci otoritatif kopyası değildir.

### K01 — Work bütünleşik sentezi

**Dosya:** `research/soul-foundations/01_verticals/work/synthesis/WORK-VERTICAL-SYNTHESIS.md`  
**İçerik kimliği:** `58fb887139fa84adf6eb522569c593e320b51684`

Amaç–eylem–yöntem; aday iş–kabul–yürütme; plan–gerçekleşen çalışma; bağımlılık, koordinasyon, değişen iş tanımı; üretim, doğrulama ve kabul ayrımlarının dayanağıdır. Evrensel bir görev ağacı, veri modeli veya iş akışı önermediği sınırı korunur.

### K02 — Work ground denetim sentezi

**Dosya:** `research/soul-foundations/03_ground-deepening/grounds/work/synthesis/WORK-GROUND-AUDIT-SYNTHESIS.md`  
**İçerik kimliği:** `5967c60b7650c0493cfb21813ff894b678a54138`

Gerçek Work ile onun temsili; başlanabilirlik ile ortam koşulları; Work kabulü ile aktör yetkisi; keşif ve meta-work ayrımlarında kullanılmıştır. Çalışmanın bağımsız ikinci araştırmacı/model doğrulaması bulunmadığı sınırı korunur.

### K03 — Informational Dynamics bütünleşik sentezi

**Dosya:** `research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/synthesis/INFORMATIONAL-DYNAMICS-SYNTHESIS.md`  
**İçerik kimliği:** `1c3f3f3c12c7f859c63d79e9d65ef0ae91154a93`

Formation/Acquisition, Derivation/Transformation ve Selection/Exposure ayrımları; kaynak doğruluğu ile tüketiciye doğru sürümün görünmesi arasındaki fark; değişim ve izlenebilirlik soruları için kullanılmıştır. Bu üç bölge zorunlu üç yazılım modülü gibi yorumlanmamıştır.

### K04 — Actors ground denetim sentezi

**Dosya:** `research/soul-foundations/03_ground-deepening/grounds/actors/synthesis/ACTORS-GROUND-AUDIT-SYNTHESIS.md`  
**İçerik kimliği:** `28ae2efed0bc19255e2df678b30480450c60e572`

Rol, yeterlilik, yetki, teknik etki gücü, sorumluluk ve atıf; sürekli sorumluluk ile mevcut iş epizodu; aktör kapasitesi ile ortamın fiilî yapılabilirliği ayrımlarının dayanağıdır. Rol adı veya hiyerarşi konumunun uzmanlık ve yetki yaratmadığı sınırı korunur.

### K05 — Context/Memory/Harness çapraz sentezi

**Dosya:** `research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md`  
**İçerik kimliği:** `293ca01ac04952417d9d56b3c79c5f195dd6da35`

Parametrik kapasite, çalışma bağlamı ve dış bellek; kalıcılık, geri çağırma ve görünür kullanım; bilgi mekanizmasıyla sistem sorumluluğunun ayrılması; talimat ile gerçek işletim sınırları için kullanılmıştır. Context/Memory/Harness zorunlu ve eş düzey üç mimari katman olarak benimsenmemiştir.

### K06 — Agent Memory araştırması

**Dosya:** `research/studies/context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md`  
**İçerik kimliği:** `6203b06fe56cad61354e9093d0b404a1ee3592c7`

Belleğin yalnız depolama olmadığı; deneyim adayının yazılması, statüsünün korunması, birleştirilmesi, güncellenmesi, geri çağrılması ve gerektiğinde unutulması konularında kullanılmıştır. Konuşmada yararlanılan bölümler, oturumlar arası uzmanlık sürekliliği düşüncesinin dayanağıdır; bir SOUL bellek altyapısının test edildiği iddiası yoktur.

### K07 — Harness Engineering araştırması

**Dosya:** `research/studies/context-memory-harness-engineering/03-HARNESS-ENGINEERING.md`  
**İçerik kimliği:** `53f3cbcfbc934155553c9ae6c4ff931126b00876`

Ajan döngüsü, araçlar, bağlam, bellek, koordinasyon, izinler, doğrulama, gözlemlenebilirlik ve süreklilik; mekanik denetim ile muhakeme; göreve ve modele göre değişen işletim gereklilikleri için kullanılmıştır. Kaynaklarda aktarılan mühendislik deneyimleri, evrensel performans garantisi olarak taşınmamıştır.

### K08 — Özyinelemeli Önkoşul Keşfi değerlendirmesi

**Dosya:** `research/studies/recursive-prerequisite-discovery/ASSESSMENT.md`  
**İçerik kimliği:** `ffd95e71c6f49192d3cdf6ffc2a4d13b1b7a10d0`

İhtiyaç, koşul, yöntem, karar ve eylem; hedef gereği ile yöntem gereği; sınırlı başlanabilir iş; bitmemiş keşif ve dönüş noktası ayrımlarında kullanılmıştır. Bu değerlendirme, dayandığı özgün eklerin tam kopyası değildir. Yöntemin gerçek ajan performansına etkisinin doğrulanmamış olduğu ve mekanik kayıt testlerinin muhakeme doğrulaması olmadığı sınırları korunur.

### K09 — Work çerçeveleri ve analiz birimleri

**Dosya:** `research/soul-foundations/01_verticals/work/findings/WORK-FRAMES-AND-UNITS.md`  
**İçerik kimliği:** `592fccfb1633c37425890a883f52cf8606258f45`

Tek ve değişmez görev ayrıştırmasının yeterli olmadığı; iş tanımının öğrenmeyle gelişebileceği; araştırma ve anlamlandırmanın gerçek Work olduğu; geçici ve devam eden iş ayrımları için kullanılmıştır. Bütünleşik yorumda K01’in güncel sentez rolü korunur.

### K10 — Foundation güncel durum yüzeyi

**Dosya:** `research/soul-foundations/STATE.md`  
**İçerik kimliği:** `049ec467cd4eccaf814249982b74525dcd3d8abb`

Dört ground araştırmasının kabul edilmiş sınırlı sonuçlarıyla, henüz yetkilendirilmemiş mimari ve uygulama işlerini ayırmak için okunmuştur. Bu bir araştırma kanıtı değil, proje durum ve yetki kaynağıdır. Konuşma konsolidasyonu yeni bir Foundation dalı veya uygulanmış SOUL mimarisi ilan etmez.

### Bu sürümün kapanış kaydı

Bu sürümün çıktısı, konuşmadaki çalışma modelinin okunabilir bir metne dönüştürülmesidir. Yeni bir SOUL uygulaması, ajan sistemi, protokol veya repository dosya düzeni kurulmamıştır. Varsayımsal dosya adları ve roller kavramsal örnek olarak kalır. Gelecekte repository’ye kaydedilecekse konuşma konsolidasyonu ve aday tasarım girdisi statüsü korunmalı; ana araştırmaların veya kabul edilmiş mimarinin yerine geçirilmemelidir.
