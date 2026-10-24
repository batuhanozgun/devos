# SOUL ve DevOS
## Doğru işi bulabilen, iyi düşünebilen ve çalışmasını sürdürebilen bir sistemin tasarımı

**Kavramsal ve mühendislik sentezi · 28 Eylül 2026**

Bu metin, SOUL'un ne olmasının amaçlandığını; onu geliştirecek DevOS'un hangi nitelikleri taşıması gerektiğini; düşünme, araştırma, iş yönetimi ve teknik işletimin nasıl birlikte ele alınabileceğini açıklıyor. Yerleşmiş kullanıcı yönünü, kayıtlardaki araştırma sonuçlarını, bu çalışmanın önerilerini ve henüz kanıtlanmamış yeterlikleri birbirine karıştırmadan ilerliyor.

**Okuma ve kanıt sınırı.** Keel, Oyun2, Foundation, Studies, ECC, Hermes, EXP-001–006, RPD ve çalışma protokollerinin kaynaklarına girdim; ana sentezleri, ilgili ayrıntı kayıtlarını, protokolleri ve eriştiğim özgün konuşma kesimlerini kullandım. Ancak bütün depoların her dosyasını, bütün araştırma yapraklarını, bütün eski konuşmaların tüm yanıtlarını ve atıf yapılan her harici kaynağı eksiksiz okuduğumu söyleyemem. Özellikle P5'in tam teslim arşivi yerine repodaki ayrıntılı devir kaydına eriştim. Kaynak kapsamını ve bu sınırların sonuçlarını metnin sonundaki okuma notunda ayrıca belirttim. Bu çalışma yeni bir canlı ajan deneyi, bağımsız kod denetimi veya kurulmuş sistemin kabul testi değildir.

Metindeki **[K…]** işaretleri proje kayıtlarına, **[D…]** işaretleri dış birincil kaynaklara gider. Örnek senaryolar, açıkça tarihsel olay olarak belirtilmedikçe, tasarımın ne yapması gerektiğini görünür kılan kurgusal örneklerdir.

# I. Amaç ve temel ayrımlar

## 1. Mesele daha çok iş yapan bir yapay zekâ değil

SOUL için biriken konuşmaların merkezinde, yalnız daha fazla araç çağıran veya daha uzun süre çalışan bir ajan bulunmuyor. Asıl istek, verilen cümlenin arkasındaki işi anlayabilen; o işin yapılabilmesi için neyin eksik olduğunu keşfedebilen; gerekli uzmanlığı, bilgiyi ve çalışma koşullarını kurabilen; bunları amaçtan kopmadan birlikte işletebilen bir yapı. Bu yapı, kullanıcıya iyi açıklamalar yapmakla yetinmemeli; açıklamalarının iş seçimine, kararlara ve gerçekleşen sonuçlara karşılığı olmalı. [K01, K02, K03]

Bu ayrım önemlidir. Bir sistem önündeki kuyruğu kusursuz işletebilir ama kuyruk yanlış işlerden oluşabilir. Çok ayrıntılı bir planı takip edebilir ama plan kullanıcının gerçek ihtiyacına ulaşmıyor olabilir. Yüzlerce test geçebilir ama testler kullanışlı bir ürünün ortaya çıkıp çıkmadığını sınamıyor olabilir. Çok sayıda dosya saklayabilir ama karar verirken yanlış dosyayı kullanabilir. Dolayısıyla SOUL'un başarısını hareket, üretim miktarı, ajan sayısı veya prosedüre uyum üzerinden tanımlamak yeterli değildir.

Bunun tersi de geçerlidir. Tek bir konuşmada çok iyi düşünen bir modelin, uzun bir işi güvenilir biçimde yönetebildiği sonucu çıkmaz. O modelin ne düşündüğünü dış dünyada neyin takip ettiği; kararın hangi sürümünün geçerli kaldığı; bir sonraki aktörün neyi gördüğü; kesinti sonrasında neyin yeniden kurulacağı; yanlış bir eylemin nerede engelleneceği ayrıca çözülmelidir. İyi muhakeme ile güvenilir işletim birbirinin alternatifi değil, birbirini tamamlayan iki yükümlülüktür. [K04, K05]

Bu yüzden SOUL'u yalnız bir “agent framework”, yalnız bir bellek sistemi veya yalnız bir orkestrasyon motoru olarak düşünmek dar kalır. SOUL'un vaadi, bunlardan gerektiği kadarını kullanarak **amaca uygun bir çalışma düzeni oluşturmak ve bu düzenin yeterliğini zaman içinde korumaktır**. Bu vaadin bugün tamamlanmış bir ürünle yerine getirildiği söylenemez; burada tarif edilen, geliştirilmesi gereken hedef yapıdır.

## 2. SOUL'un çalışma tanımı

Bu birikimden çıkardığım çalışma tanımı şudur:

> **SOUL, yetkilendirilmiş bir amacı gerçekleştirmek için gereken işi, bilgiyi, aktörleri ve çalışma koşullarını keşfeden; bunları amaca uygun bir çalışma sistemi halinde birleştiren; oluşan sistemi yürütme, değerlendirme, değişim ve süreklilik boyunca yöneten, gerektiğinde kendi çalışma kapasitesini kontrollü biçimde uyarlayan bir yapıdır.**

Tanımdaki “keşfetmek”, kullanıcıdan eksiksiz bir teknik şartname istememeyi ifade eder. “Yetkilendirilmiş”, daha iyi bir sonuç hayal edebildiği için kapsamı veya harcamayı kendi başına sınırsız büyütemeyeceğini belirtir. “Birleştirmek”, iyi parçaların yan yana bulunmasını yeterli saymaz. “Yönetmek”, yalnız iş dağıtmak değil, işin anlamını, durumunu, dayanaklarını ve sonuçlarını birlikte korumaktır. “Uyarlamak” ise her hatada kendini serbestçe yeniden yazmak değil, değişiklik ihtiyacını gerekçelendirmek, sınamak ve uygun yetkiyle devreye almaktır. [K02, K03, K06]

SOUL'daki “SOUL” adı, bilinç, kişilik, duygu veya metafizik bir öz iddiası değildir. Bu çalışma için anlamı, belli bir modelin tekil yanıtından daha kalıcı bir çalışma niteliğini temsil etmesidir. O nitelik, model değişse veya bir oturum sona erse bile yeniden kurulabilen ortak çalışma standardında, bilgi düzeninde, karar geçmişinde ve işletim ilişkilerinde taşınmalıdır.

SOUL'un genel amaçlı olması, her işi aynı yöntemle yapması anlamına gelmez. Roman, soru bankası, yazılım, araştırma ve operasyon işi aynı doğruluk ölçütlerine sahip değildir. Genellik, her alana tek bir süreç dayatmaktan değil; hangi alanda hangi çalışma biçiminin gerektiğini keşfedebilmekten gelir. Ortak kalan şey düşünme disiplini ve sistem kurma kapasitesidir; alan uzmanlığı, araçlar, değerlendirme yöntemleri ve işin somut örgütlenmesi değişebilir. [K01, K02, K07]

Bir başka sınır da şudur: SOUL, dünyadaki her gerekli yetkinliğin kendisinde mevcut olduğunu varsaymamalıdır. Bazen araştırma yapmak, bazen yeni bir araç bağlamak, bazen insan uzman görüşü almak, bazen de mevcut koşullarda yeterli güvenle ilerlenemediğini söylemek gerekir. Yetersizliği fark etmek bir başarısızlık değildir; onu gizleyip yeterlik iddia etmek başarısızlıktır. Bununla birlikte “uzman gerekir” diyerek bütün düşünme ve koordinasyon yükünü kullanıcıya geri bırakmak da hedeflenen davranış değildir.

## 3. Baz SOUL ve bir işle genişlemiş SOUL

SOUL'u, önce bir ekip kurup sonra o ekipten kopan bir kurucu gibi düşünmek eksik kalıyor. EXP-004'teki önemli düzeltme, SOUL'un yapılan işe göre hem yeni işlevler kazanması hem mevcut işlevlerinin kapsamını genişletmesidir. Yeni bir ajan eklendiğinde yalnız bir isim daha oluşmaz: o ajanın kullandığı bilgiler, yazdığı çıktılar, kullandığı yetkiler, katıldığı kararlar ve kesinti sonrasındaki devamı da çalışma düzeninin kapsamına girer. [K03]

**Baz SOUL**, henüz belirli bir kullanıcı projesi almamış halde, bu genişlemeyi güvenilir biçimde başlatabilecek çekirdeği taşımalıdır. Bu çekirdekte amaç ve yetkiyi anlama, mevcut kapasiteyi tanıma, araştırmaya yönelme, iş ve bilgi durumunu koruma, aktörleri işe hazırlama, sonuçları sınama ve çalışma koşullarını değiştirme yetenekleri bulunmalıdır. Bunların tek bir ajan, birkaç rol veya belirli bir yazılım paketiyle gerçekleştirilmesi ayrı bir tasarım kararıdır.

**İşle genişlemiş SOUL** ise bu ortak temelin üzerine projeye özgü uzmanlık, yöntem, bilgi, araç ve sorumluluk ilişkileri ekler. Bir roman işi karakter sürekliliği, anlatı düzeni ve okuma deneyimi değerlendirmesi gerektirebilir. Bir soru bankası işi konu kapsamı, pedagojik uygunluk ve bağımsız çözüm doğrulaması gerektirebilir. Bir yazılım işi dağıtım ortamı, güvenlik kontrolleri ve gerçek kullanıcı akışları gerektirebilir. Aynı çekirdek, bu farklılıkları silmeden taşımalıdır.

Genişlemek her zaman daha fazla ajan veya daha karmaşık altyapı demek değildir. Bazen mevcut role daha uygun bağlam vermek yeterlidir. Bazen aynı rolün başka bir modelle çalışması gerekir. Bazen iki işi ayırmak, bazen gereksiz bir ara adımı kaldırmak, bazen de yeni bir uzmanlık çağırmak gerekir. Büyüme kadar küçülme, birleştirme ve emekliye ayırma da uyarlamanın parçasıdır.

Bu nedenle “SOUL ne kadar büyük olacak?” sorusundan önce “hangi koşulda hangi kapasiteyi neden devreye alacak?” sorusu gelir. Bir iş bittikten sonra bütün proje ajanlarını açık tutmak gerekli olmayabilir; buna karşılık kararların, hakların, kaynakların, önemli deneyimlerin ve yeniden kullanım yollarının uygun sürelerle korunması gerekebilir. Aktörün çalışma ömrü ile bilgisinin yaşam ömrü aynı değildir.

## 4. DevOS neden ayrı bir yapı olmalı?

DevOS, SOUL'u geliştirmek için kurulacak somut çalışma sistemidir. SOUL çeşitli kullanıcı amaçları için çalışma düzenleri kurmayı hedeflerken, DevOS'un ilk ve belirli amacı SOUL'u ortaya çıkarmaktır. Bu ayrım, SOUL'u yalnız kullanıcı ile tek bir asistanın uzun sohbetlerine dayanarak geliştirmeye çalışmanın sınırlarından doğuyor. Araştırma, tasarım, uygulama, değerlendirme ve sürekliliğin kendisinin de örgütlenmesi gerekiyor. [K02, K08]

DevOS bu anlamda yalnız “SOUL kodlarının bulunduğu repo” değildir. Repo, önemli bir bilgi ve üretim yüzeyi olabilir; fakat hangi işin neden yapılacağı, kimin hangi yetkiyle katkı vereceği, bilginin nasıl bulunacağı, itirazın nasıl karşılık bulacağı ve çalışmanın nasıl yeniden başlayacağı repo adından çıkmaz. Bunlar DevOS'un çalışma düzeninin parçalarıdır.

Burada bir başlangıç problemi vardır: İyi bir DevOS kurmak için iyi çalışan bir sisteme ihtiyacımız varsa, sonsuz biçimde bir önceki sistemi kurmak mı gerekir? Hayır. Gerekli olan, genel SOUL yeteneğinin tamamını önceden üretmek değil; DevOS'un başlangıç işlerini güvenilir biçimde yürütecek **sınırlı fakat gerçek bir başlangıç yeterliği** oluşturmaktır. Bu başlangıç; açık amaç, sınırlandırılmış yetki, kullanılabilir kaynaklar, birkaç gerekli sorumluluk, kalıcı iş durumu ve uygun değerlendirme yollarını içerebilir. Yeterliğinin hangi işler için geçerli olduğu açık olmalıdır. [K04, K06]

Böyle bir başlangıç, “küçük bir demo yaptık, artık DevOS var” demek değildir. Başlangıç yeterliği, gerçek bir işin keşfinden sonucunun değerlendirilmesine kadar çalışan bir yolu taşımalıdır. İşin kapsamı dar olabilir; temel sorumluluklar maket olmamalıdır. Örneğin oturum kesildiğinde kullanıcı bütün durumu yeniden anlatmak zorunda kalıyorsa, süreklilik henüz sistem tarafından taşınmıyordur.

DevOS'un başarısı yalnız SOUL hakkında iyi belgeler üretmesi değildir. O belgelerin doğru gereksinimlere, değerlendirilebilir tasarımlara, uygulanmış yeteneklere ve gösterilmiş sonuçlara dönüşebilmesidir. Bir başka deyişle DevOS, SOUL'un fikrini anlatan bir kurul değil; o fikri gerçek bir sisteme dönüştürmek için gereken işi kendisi keşfedip yürütebilen bir geliştirme düzeni olmalıdır.

## 5. DevOS'un ilk işini kim bulmalı?

EXP-006'daki en önemli yönlerden biri, SOUL'u geliştirmek için ilk ve sonraki gerçek işlerin, kurulacak ekibin çalışmasıyla ortaya çıkmasıdır. Kullanıcıdan veya bu metni yazan asistandan hazır bir SOUL backlog'u beklemek, DevOS'un üstlenmesi gereken keşif sorumluluğunu daha baştan dışarıda bırakır. [K08]

Bu, amaçsız bir ekibin boş bir alana bırakılması anlamına gelmez. Ekibe SOUL'un amacı, geçmiş dersler, araştırma birikimi, mevcut kısıtlar, açık sorular ve hangi kararların kime ait olduğu verilir. Ekip bunları kullanarak mevcut durum ile hedef arasındaki boşlukları ortaya koyar. Sonra hangi boşluğun önce araştırılması, hangisinin tasarlanması, hangisinin sınanması gerektiğine gerekçeli biçimde karar verir.

Hazır iş seçimi ile iş keşfi birbirinden ayrılmalıdır. Bir kuyrukta “hazır” olarak işaretlenmiş maddelerden birini almak operasyonel bir seçimdir. O kuyruğa hangi maddelerin gireceğini, aralarındaki bağımlılıkların doğru olup olmadığını ve en önemli eksikliğin listede bulunup bulunmadığını değerlendirmek başka bir sorumluluktur. İkisi de gereklidir; biri diğerini ortadan kaldırmaz.

Bu nedenle DevOS'ta işi keşfetme sorumluluğu yalnız “planlayıcı ajan” adında bir kutuya kapatılmamalıdır. Araştırmacı bilgi açığı, doğrulayıcı kanıt açığı, geliştirici uygulanabilirlik sorunu, bilgi sorumlusu güncellik sorunu, ortam sorumlusu gerçek erişim eksikliği keşfedebilir. Bunların her biri yeni iş doğurabilir. Planlama sorumluluğu, bu dağınık keşifleri ortak amaç ve öncelik düzeninde birleştirmektir.

Burada yazılacak herhangi bir inşa sırası da dikkatle adlandırılmalıdır. DevOS'un temel erişimini ve devam yolunu sınamak için örnek bir başlangıç işi tasarlamak, SOUL'un ürün backlog'unu tek başına seçmekle aynı değildir. İlki çalışma düzeninin yeterliğini sınar; ikincisi ürün geliştirme işini fiilen devralır. Bu metin ilk türden değerlendirme önerileri içerir; ikinci türden bir yetki kullanmaz.

## 6. Foundation: dört kutu değil, birlikte düşünme zemini

Foundation'ın WORK, INFORMATION, ACTORS ve ENVIRONMENT ayrımı, mimariyi dört zorunlu modüle bölme emri değildir. Bu dört alan, bir çalışma olayını farklı yönleriyle inceleyebilmek için kurulmuş düşünme zeminleridir. İlişkileri ve bileşik durumları ele alan araştırma da, bu alanların yalnız ayrı ayrı doğru olmasının yeterli olmadığını gösterir. [K07, K09]

WORK açısından soru, hangi amacın hangi işlerle izleneceği ve işin zaman içinde nasıl değişeceğidir. INFORMATION açısından soru, hangi bilginin neyi temsil ettiği, ne kadar desteklendiği, hangi kullanıma yeterli olduğu ve kime nasıl ulaştığıdır. ACTORS açısından soru, kimlerin hangi yetkinlik, sorumluluk, hak ve yetkiyle yer aldığıdır. ENVIRONMENT açısından ise hem işin gerçekleştiği alanın gerçek koşulları hem çalışmayı mümkün kılan araçlar ve sınırlar önemlidir.

Bir matematik soru bankası düşünüldüğünde yalnız soruların konu dağılımını ve cevaplarını incelemek yeterli değildir. Soruları üreten ekibin konuya nasıl hâkim olacağı, pedagojik kararları nasıl vereceği, kaynaklara nasıl ulaşacağı, hatayı nasıl yakalayacağı ve bütün kitabı nasıl birleştireceği de aynı hedefin koşullarıdır. Foundation'ın yeterlik tartışmasındaki düzeltme tam olarak bu üretim sistemi boyutunu görünür kılar. [K10]

Alanlar arasındaki ilişkiler, dekoratif bağlantı okları değildir. “Bu rol bu işe atanmış” ifadesi gerçek çalışma yeterliği sağlamaz. “Bu kaynak sistemde var” ifadesi o rolün kaynağa ulaşabildiğini göstermez. “Bu işlem onaylandı” ifadesi bütün etki yollarının kontrol edildiğini kanıtlamaz. “İş tamamlandı” kaydı, amaçlanan sonucun dünyada gerçekleştiğini tek başına göstermez. [K09]

Özellikle korunması gereken bir sonuç şudur: Bir yerde yeterli bilgi, başka bir yerde erişilebilir bilgi bulunması, gerçek aktörün yeterli ve erişilebilir bilgiyle çalıştığını göstermez. Yeterlik ile erişimin aynı tüketici, kullanım, zaman ve kaynak görünümünde birleşmesi gerekir. Üstelik bunun sağlanması da bilginin gerçekten yorumlandığını ve kullanıldığını kendiliğinden kanıtlamaz. [K11]

Foundation'ın DevOS'a katkısı, hazır bir teknoloji yığını seçmekten önce doğru soruları sormayı ve yanlış eşitlemeleri önlemeyi sağlamasıdır. Araştırma ağacının belli bir amaç için yeterli bulunması, her alanın bütün olasılıklarının tüketildiği veya uygulama mimarisinin doğrulandığı anlamına gelmez. Mimari karar için gerçek iş koşulları ve hedef ortamda elde edilmiş kanıt gerekir.

# II. Ortak entelektüel taban

## 7. “İyi düşünen ajan” hangi davranışları göstermeli?

SOUL ve DevOS için ortak entelektüel taban, bütün ajanların aynı uzmanlığa sahip olması değildir. Güvenlik inceleyicisiyle romancı aynı bilgiye ihtiyaç duymaz. Fakat ikisinin de amaç ile yöntemi ayırabilmesi, bir iddianın dayanağını sorgulayabilmesi, bilmediği şeyi fark edebilmesi ve yerel işini bütün içinde değerlendirebilmesi gerekir. EXP-002'deki ortak genel yetenekler düşüncesi ve EXP-006'nın B1 açılımı, uzmanlaşma sırasında kaybolmaması gereken bu tabanı tarif eder. [K02, K12]

### 7.1. Talebi değil, talebin işaret ettiği işi anlamak

Kullanıcının söylediği cümle, kullanıcı zihnindeki niyet ve yeterli bir iş tanımı aynı şey değildir. EXP-001'de A, B ve C ile konuşulan ayrımın değeri buradadır. Kullanıcı bütün ayrıntıları bilmeyebilir, bildiklerini yazmayabilir veya bir varsayımın sonuçlarını öngörmemiş olabilir. Ajanın görevi bu boşlukları fark etmek, önemli olanları araştırmak ve gerektiği yerde gerçek tercih sahibine dönmektir. [K01]

Bu davranış, kullanıcının talebini kendi hayalindeki daha büyük projeye çevirmek değildir. “Roman yaz” talebinden her zaman yayıncılık şirketi kurma, dağıtım ağı oluşturma veya ticari marka geliştirme işi çıkmaz. Bunlar belirli amaçlar altında gerekli olabilecek olasılıklardır. İyi düşünme, olasılıkları görünür kılarken kapsamı izinsiz büyütmemektir. Eksik gereksinimi keşfetmek ile yeni bir amaç icat etmek arasındaki çizgi açık kalmalıdır.

### 7.2. Soruyu doğru düzeyde kurmak

Bir ajan yalnız “hangi veritabanını kullanmalıyız?” sorusuna iyi cevap vermemelidir. Önce kalıcı veriye neden ihtiyaç olduğunu, neyin korunacağını, kimlerin okuyup yazacağını, hangi değişikliklerin birbiriyle uyumlu olması gerektiğini anlamalıdır. Sorun yanlış düzeyde kurulmuşsa doğru teknoloji seçimi bile yanlış bir sistemi optimize edebilir.

Benzer biçimde, “ajan araştırmıyor” gözlemi doğrudan “yeni araştırma ajanı ekleyelim” sonucuna gitmemelidir. Eksiklik; araştırma ihtiyacının fark edilmemesi, kaynağın bilinmemesi, erişimin olmaması, bağlamın yetersizliği, rol amacının yanlış kurulması veya araştırma sonucunun karar sürecine dönememesi olabilir. Bu nedenler farklı müdahaleler gerektirir. B1 ve EXP-005 kayıtlarının birlikte desteklediği önemli davranış, çözümün adını kök neden yerine koymamaktır. [K12, K13]

### 7.3. Bütünü görürken yerel sorumluluğu korumak

İyi bir uzman, yalnız kendisine verilen satırı tamamlamaya çalışmaz; o satırın hangi üst amaca hizmet ettiğini bilir. Fakat bu geniş görüş, bütün kararları kendi başına alma yetkisi yaratmaz. Bir veri uzmanı ürünün yanlış ölçütle değerlendirildiğini fark edebilir; bunu gerekçeli bir katkı olarak yükseltir. Ürün amacını sessizce değiştirmez.

Bu davranışı “dar görev, geniş görüş” diye ifade etmek yararlı. Dar görev, aktörün o çalışma anındaki başarı yönünü ve sorumluluğunu belirler. Geniş görüş, önemli bir yan etkiyi veya başka alandaki eksiği fark edebilmesini sağlar. Ajanları çok dar bağlamlara kapatmak bütünsel farkındalığı yok edebilir; herkese bütün tarihi vermek de odağı dağıtabilir. Tasarım, bu iki sorunu birlikte çözmelidir.

### 7.4. Kanıt, çıkarım, varsayım ve tercih arasındaki sınırı korumak

Bir kaynağın söylediği şey, bizim o kaynaktan çıkardığımız yorum ve sonunda verdiğimiz karar ayrı nesnelerdir. “Bu araç böyle çalıştığını söylüyor” ile “bu davranışı gerçek ortamda gözlemledik” aynı kanıt değildir. “Kullanıcı bu seçeneği tercih ediyor” ile “bu seçenek teknik olarak daha iyi” aynı hüküm değildir.

Ajan, belirsizliği yalnız genel bir uyarı cümlesiyle değil, kararı etkileyen yerde göstermelidir. Hangi varsayım değişirse karar değişir? Hangi kaynağın güncelliği kritik? Bir testin başarısı hangi iddiayı destekliyor, hangisini desteklemiyor? Bu açıklık kararı zayıflatmaz; kararın hangi koşullarda kullanılabileceğini anlaşılır kılar. [K05]

### 7.5. Kendi bilgisinin sınırını ve mevcut bilginin varlığını fark etmek

Ajanın bütün araştırmayı sürekli bağlamında tutması gerekmiyor. Ancak ilgili bir araştırmanın var olabileceğini, hangi tür soruda ona dönmesi gerektiğini ve kendi eğitim bilgisinin ne zaman yetersiz kaldığını fark etmesi gerekiyor. Bu, yalnız iyi bir arama motoru kurmakla çözülemez. Aramaya yönelme davranışı ile arama altyapısı ayrı ama bağlı sorumluluklardır. [K12, K14]

Burada iki tür bilgi gereklidir: konunun kendisi hakkındaki bilgi ve bilgiye nasıl ulaşılacağı hakkındaki bilgi. Bir aktör “bellek konusunda çeşitli alternatifler var” bilgisini taşıyabilir; karar kritikleştiğinde hangi araştırma kaydına, hangi karşılaştırmaya ve hangi gerçek uygulama kanıtına gideceğini de bulabilmelidir. Bilgi kütüphanesinin değeri, bu ikinci yetenek olmadan büyük ölçüde pasif kalır.

### 7.6. Yeni açıklamalar ve alternatifler üretebilmek

Düşünme kalitesi yalnız kurallara uymak değildir. Bir açıklamanın dışında kalan durumu görebilmek, başka bir problem çerçevesi önerebilmek, iki araştırma arasında yeni bir ilişki kurabilmek ve mevcut tasarımı daha basit bir yolla karşılayabilmek de gerekir. DevOS yalnız hataları engelleyen bir makine olursa, SOUL için gereken yaratıcı ve üretken muhakemeyi kuramamış olur.

Bu üretkenlik de sınanmalıdır. Yeni fikir sayısı başarı ölçütü değildir. Bir fikrin hangi sorunu çözdüğü, hangi koşullarda çalışacağı, neyi bozabileceği ve nasıl değerlendirileceği açıklanabilmelidir. Ajanın yaratıcılığı, sınırsız altyapı üretimi veya sürekli yeni kavram icadı şeklinde değil, işe yarayan seçenek alanını genişletmek şeklinde görünmelidir.

### 7.7. Fikrini değiştirmek ve değiştirmemek için doğru gerekçeyi kullanmak

Kullanıcının itirazı, önemli bir sinyaldir; otomatik doğruluk hükmü değildir. Aynı şekilde asistanın önceki tasarımı, emek verilmiş olduğu için korunacak bir değer değildir. Yeni kanıt eski kararı zayıflatıyorsa değişiklik gerekir. Kullanıcı aynı tercihi başka bir isimle söyledi diye teknik hüküm değişiyorsa, kararın dayanağı sorgulanmalıdır. [K05]

Bunun sağlıklı biçimi ne kullanıcıyı sürekli onaylamak ne de bağımsız görünmek için sürekli itiraz etmektir. Kararın hangi bölümünün tercih, hangi bölümünün olgu, hangi bölümünün çıkarım olduğunu ayırmaktır. Ajan gerektiğinde “bu kısmına katılıyorum, fakat şu sonuç buradan çıkmıyor” diyebilmelidir. Bu davranış hem SOUL'un kullanıcıyla ilişkisi hem DevOS içindeki meslektaş değerlendirmesi için gereklidir.

### 7.8. Ne zaman yeterince düşünüldüğünü tartabilmek

Her belirsizliği kapatmadan işe başlamak tehlikeli olabilir; bütün belirsizlikleri kapatmayı beklemek de işi hiç başlatmayabilir. İyi düşünme, mevcut karar için hangi belirsizliklerin önemli olduğunu ayırır. Geri alınabilir bir deneme için gereken hazırlıkla geri alınması zor bir dış eylem için gereken hazırlık aynı değildir.

Bu nedenle yüksek standart, her küçük işte en uzun düşünme sürecini çalıştırmak değildir. Yüksek standart; hangi derinliğin gerekli olduğuna sorumlu biçimde karar vermek, önemli bir koşulu atlamamak ve inceleme maliyetini gerekçelendirebilmektir. EXP-001'deki küçük yapı ile büyük yapı benzetmesinin sağlam tarafı, emeğin ölçeklenmesine rağmen profesyonel sorumluluğun ortadan kalkmamasıdır. [K01]

## 8. Ortak taban bir sıfat değil, aktarım ve yeterlik problemi

Bir rol dosyasına “derin düşün, bağımsız ol, iyi araştır” yazmak başlangıç malzemesi olabilir; bunları sağlayan bir sistemin kurulmuş olduğu anlamına gelmez. DevOS'un çözmesi gereken iş, davranış beklentisini gerçek aktör davranışına aktarabilmektir. B1'in açık bıraktığı temel mühendislik sorusu budur. [K12]

Bu aktarımın taşıyıcıları, göreve göre farklılaşabilir: ortak çalışma protokolleri, rol sözleşmeleri, yöntem paketleri, seçilmiş örnekler, kaynak rotaları, araç arayüzleri, geri bildirim ve uygun model seçimi. Bazı davranışlar talimatla desteklenebilir; bazıları bağımsız değerlendirme gerektirir; bazı kritik eylemler ise modelin iyi niyetine bırakılmadan teknik olarak sınırlandırılmalıdır. Aynı yöntem her beklenti için yeterli değildir.

Yeni bir rol oluşturulduğunda yalnız unvanı değil, nasıl çalışacağı da belirlenmelidir. Hangi ortak standardı taşıyor? Hangi alan bilgisine dayanıyor? Bilgi eksikliği hissettiğinde ne yapıyor? Hangi kaynaklara gerçekten erişebiliyor? Başka bir uzmana hangi tür katkı talebi gönderebiliyor? Sonucu hangi koşullarda yeterli sayabiliyor? Bu soruların cevabı, aktörün fiilî çalışma konfigürasyonunu oluşturur.

Buna bir **yeterlik profili** eşlik etmesini öneriyorum. Bu, ajana tek bir zekâ puanı vermek değildir. Profil; iş türü, kullanılan model ve konfigürasyon, gereken bilgi ve araçlar, denenmiş koşullar, bilinen sınırlar, değerlendirme yöntemi ve yeniden sınama tetiklerini taşır. “Araştırmada iyi” yerine “bu tür kaynak karşılaştırmalarında, bu erişim koşullarında, şu kapsamlı ölçütlerle yeterli bulundu” denebilmelidir.

Model, rol metni, araç seti veya bağlam kurma yöntemi değiştiğinde eski yeterlik sonucu otomatik taşınmamalıdır. Her değişiklik bütün testleri yeniden koşmayı gerektirmeyebilir; fakat hangi iddiaların dayanağının değiştiği değerlendirilmelidir. Bir role daha fazla araç vermek kabiliyeti artırabilir ama hata alanını da büyütebilir. Bir bağlamı kısaltmak maliyeti düşürebilir ama kritik bilgi kaybına yol açabilir.

Ajanın kendi değerlendirmesi yararlı bir gözlem olabilir; yeterlik belgesi yerine geçmez. “Protokolleri okudum” ifadesi ile söylenmemiş önemli bir ihtiyacı fark etmek arasında fark vardır. “Araştırma yaptım” ile kaynakların kararın yönünü haklı biçimde etkilemesi arasında da fark vardır. DevOS, bu farkları gözleyebilecek ve başarısızlığın nedenini doğru katmana taşıyabilecek değerlendirme düzeni kurmalıdır.

## 9. RPD: yapılacak işin koşullarını keşfetmek

Burada RPD ile kastedilen, kayıtlardaki **Recursive Prerequisite Discovery**, yani **Özyinelemeli Önkoşul Keşfi** yaklaşımıdır. Bu, evrensel olarak doğrulanmış bir algoritma veya kurulmuş bir ürün olarak değil, proje içinde geliştirilmiş bir keşif ve süreklilik yaklaşımı olarak ele alınmalıdır. Kavramsal temel, beceri metni, süreklilik tasarımı ve değerlendirme planı birlikte okununca asıl değerinin “önce biraz daha plan yap” demekten daha derin olduğu görülüyor. [K04]

RPD'nin temel sorusu şudur: **Bir işi şimdi, bu aktörle, bu koşullarda yapabilmek için hangi şartlar gerçekten sağlanmış olmalı?** Bu şartlardan biri eksikse, eksikliğin giderilmesi de iş olabilir. Fakat her eksiklik yeni bir engel değildir; bazıları başka yöntem seçildiğinde ortadan kalkabilir, bazıları daha sonra ele alınabilir, bazıları mevcut kararı etkilemez.

Örneğin uzun bir rapor hazırlanacak olsun. “Raporu yaz” bir iştir. Konuyu anlamak, kaynaklara erişmek, güncel kanıtı ayırmak, hedef okura uygun anlatımı seçmek ve iddiaları doğrulamak bu işin koşulları olabilir. Kaynağa erişilemiyorsa yalnız “erişim yok” notu düşmek yeterli olmayabilir: başka bir yetkili kaynak, farklı bir erişim yöntemi veya kapsamı doğru sınırlama seçeneği araştırılabilir. Bu araştırmanın kendisi de bir alt iş olur ve sonucu üst karara geri dönmelidir.

### 9.1. İhtiyaç, yöntem, koşul, karar ve eylem aynı şey değildir

“Kalıcı duruma ihtiyacımız var” bir ihtiyaçtır. “PostgreSQL kullanalım” bir yöntem adayıdır. “Çalışan veritabanına yetkili erişim var” bir koşuldur. “Bu ihtiyacı bu yöntemle karşılamayı seçtik” bir karardır. “Kaydı yazdık” bir eylemdir. Bunları tek bir yapılacaklar satırında eritmek, yöntemi ihtiyaç sanmaya ve eylemi sonuç sanmaya yol açabilir.

RPD'nin güçlü kullanımı, bir hedef için birden fazla yöntem olabileceğini korur. Bir yöntemin tüm gerekli koşulları birlikte sağlanmalıdır; ama aynı hedef başka bir yöntemle de karşılanabilir. Dolayısıyla düşünme yapısı yalnız alt alta bağımlılıklar değil, gerektiğinde **AND/OR ve koşullu seçenekler** içerir. Bir yöntem pahalı veya imkânsız olduğunda bütün hedefin imkânsız olduğu sonucu çıkmaz.

### 9.2. Önkoşullar aktöre ve zamana bağlıdır

Bir kaynağın depoda bulunması, görevi yapacak aktörün onu okuyabildiğini göstermez. Bir aracın kurulu olması, doğru kimlikle ve doğru işlem yetkisiyle kullanılabildiğini göstermez. Dün geçerli bir karar, bugün değişen veri veya yetki altında geçerli olmayabilir. Bu yüzden “hazır” olma, işin kalıcı bir etiketi değil, mevcut koşullar altında değerlendirilen bir durumdur.

Ayrıca ortak koşulların birlikte karşılanabilmesi gerekir. İki iş ayrı ayrı aynı sınırlı kaynağa dayanarak hazır görünse bile birlikte yürütülemeyebilir. İki kaynaktan türetilen kararlar ayrı ayrı makul olup aynı sürüm veya kapsamda uyuşmayabilir. RPD, bu birleşim sorunlarını yalnız bir bağımlılık grafiğinin çizilmiş olmasına dayanarak çözülmüş saymamalıdır. [K04, K11]

### 9.3. Geriye doğru keşif ile ileriye doğru sınama birlikte çalışmalı

Hedeften geriye doğru giderek gereken koşulları çıkarmak yararlıdır. Fakat yalnız bu yolla bulunan plan, başlangıçtaki yanlış varsayımları koruyabilir. İleriye doğru örnek yürütme, küçük deney, prototip veya gerçek erişim sınaması, planın pratikte neyle karşılaştığını gösterir. İki bakış birbirini beslemelidir.

Yine de ikisinin aynı ajan ve aynı yanlış kabulle yapılması bağımsız doğrulama değildir. “Geriye doğru düşündüm, sonra ileriye doğru da düşündüm” demek, aynı fikrin iki kez ifade edilmesi olabilir. Özellikle kritik kararlarda dış kaynak, farklı yöntem, gerçek ortam veya bağımsız değerlendirme gerekir. [K04, K05]

### 9.4. Keşif sonsuz bir hazırlık kuyusuna dönüşmemeli

RPD'nin durma ölçütü, bütün evrenin önkoşullarını bulmak değildir. Mevcut hedef ve karar için yeterli hazırlığa ulaşmak, kalan belirsizlikleri görünür tutmak ve anlamlı bir sonraki adımı seçmektir. Bazı sorular araştırmayla, bazıları eylemin kendisiyle cevaplanır. Bu nedenle keşif ve yürütme birbirini sürekli günceller.

Bir alt araştırmanın sonucunun hangi üst kararı değiştirebileceği belli değilse, o araştırma amaçtan kopabilir. Her alt iş için “hangi soruyu kapatıyor, hangi seçimi etkiliyor, hangi işe geri dönüyor?” bağı kurulmalıdır. Sonuç bazen yeni bir koşul, bazen yöntem değişikliği, bazen de artık ek araştırmaya gerek olmadığı yönünde gerekçeli bir hüküm olur.

RPD, işe başlanabilirlik ile tamamlanmışlığı da ayırmalıdır. Alt işler bitince üst iş otomatik bitmez; çoğu zaman yalnız yapılabilir hale gelir. Benzer biçimde hazır iş kalmaması, hedefe ulaşıldığını göstermez. Bekleme, kaynak yetersizliği, yanlış bağımlılık, unutulmuş iş veya bozuk koordinasyon da aynı görüntüyü üretebilir. [K04, K15]

## 10. Çalışma protokollerinin DevOS'taki karşılığı

Repodaki dokuz protokolü, SOUL'a aynen kopyalanacak kutsal bir metin dizisi olarak görmüyorum. Bunlar çalışma davranışına ilişkin güçlü birikimlerdir; DevOS bunların koruduğu ayrımları, hangi koşullarda işe yaradıklarını ve gerçek davranışa nasıl aktarılacaklarını incelemelidir. Kuralların varlığı ile uygulandıkları an arasındaki boşluk, geçmiş kayıtların tekrar tekrar gösterdiği bir sorundur. [K05, K13]

**R01 — Karar-kritik varsayımlar.** Her belirsizliği aynı ağırlıkta ele almak yerine, sonucu değiştirebilecek varsayımlar bulunmalı. Seçenekler yalnız mevcut tasarımın varyantlarıyla sınırlanmamalı. “Bu çözümü bugün sıfırdan seçer miydik?” sorusu, geçmiş emeğin kararı gereksiz yere koruyup korumadığını sınamalı.

**R02 — Kullanıcıdan bağımsız muhakeme.** Kullanıcının amacı ve değer tercihi belirleyici olabilir; teknik iddia bu nedenle doğru sayılmaz. Ajanın kendi önceki fikrine bağlılığı da teknik kanıt değildir. Ters yöndeki teşviklerde aynı kanıt standardı korunabilmeli.

**R03 — Amaç, yöntem ve uçtan uca yeterlik.** Yöntemde ilerlemek amaçta ilerlemekle karıştırılmamalı. Kaynağın üretilmesi, saklanması, erişilmesi ve gerçekten kullanılması aynı zincirin ayrı halkalarıdır. Yerel bir başarı üst hedefin yerine geçmemeli.

**R04 — Doğrulama bağımsızlığı.** Değerlendiricinin hata yakalama kapasitesi, kullanılan ölçütün yeterliği, ortak hata kaynakları, kapsam ve kanıtın güncelliği birlikte düşünülmeli. Bir başka ajan çağırmak veya aynı testleri tekrar çalıştırmak otomatik bağımsızlık değildir.

**R05 — Kaynak ve görünüm sadakati.** Kaynağın depoda bulunması, tamamının okunması ve eldeki özetin amaca yeterli olması farklı iddialardır. Kesilmiş araç çıktısı tam okuma sayılamaz. Bir özet kaynak metne dönüş yolu taşımalı; yorum, özgün ifade gibi sunulmamalı.

**R06 — Nedensel derinlik.** Belirti, yakın neden, katkıda bulunan koşul ve sistemik sorun ayrılmalı. “Neden oldu?” kadar “neden engellenmedi veya fark edilmedi?” sorusu da sorulmalı. Fakat daha derin bir açıklamanın kararı değiştirmediği yerde sonsuz kök neden araması yapılmamalı.

**R07 — Çalışma sürekliliği.** Amaç, mevcut iş, açık sorular, kararlar, kaynaklar ve sonraki sorumluluk oturumun içinde kalmamalı. Devralma, geçmiş sohbeti yeniden anlatmak değil, geçerli çalışma durumunu yeniden kurabilmek olmalı.

**R08 — Kanonik işe giriş.** Aktör çalışmaya başlamadan gerçekten hangi işe, hangi güncel kaynağa ve hangi yetkiye bağlı olduğunu anlamalı. Eski bir giriş dosyasının veya önceki oturumun yönü, güncel işi sessizce değiştirmemeli.

**R09 — Araştırma kütüphanesinin kullanımı.** Araştırma yalnız referans listesi doldurmak için kullanılmamalı. İlgili bilgi, seçenekleri, yöntemi, kararı veya değerlendirmeyi etkileyebilmeli. Bir örneğin incelenmiş olması, onun benimsenmiş mimari olduğu anlamına gelmemeli.

Bu protokoller için önerdiğim tasarım ilkesi, **davranış beklentisi → uygulanacağı durum → taşıyıcı mekanizma → gözlenebilir sonuç → sınama** bağlantısıdır. Örneğin kaynak sadakati için iyi niyetli bir talimatın yanında kesilmiş okuma tespiti, sürüm bağı ve kaynağa dönüş yolu bulunabilir. Yetki sınırı için yalnız protokol değil, gerçek araç ve kimlik kontrolü gerekir. Bağımsız muhakeme için ise mekanik bir kontrolün tek başına yeterli olamayacağı kabul edilmeli; uygun karşılaştırmalı değerlendirmeler geliştirilmelidir.

## 11. İyi araştırma: kaynak toplamak değil, karar alanını geliştirmek

DevOS'un araştırması iki farklı düzeyde yürür: SOUL hakkında bilgi üretmek ve SOUL'u geliştiren ekibin kendi çalışma yöntemini iyileştirmek. Her iki düzeyde de iyi araştırma, çok sayıda bağlantı bulmaktan daha fazlasını gerektirir. Araştırma sorusu, incelenen nesne, iddia edilen davranış, gerçek kullanım yolu ve çıkarılabilecek sonucun sınırı görünür olmalıdır. ECC ve Hermes çalışmalarının ayrıntılı kayıtları bu ayrım için özellikle değerlidir. [K16, K17]

Bir dış sistemi incelerken önce sistemin kendi mantığını anlamak gerekir. Onu daha ilk anda Foundation başlıklarına zorlamak, örneğin gerçekten yeni olan davranışını kaybettirebilir. Yerel açıklama oluşturulduktan sonra Foundation ile hangi soruların açıldığı, hangi eksikliklerin görünür olduğu ve hangi mekanizmaların başka koşullara taşınabileceği incelenebilir.

Araştırmacı, ürünün README iddiası ile kaynak kodda görünen yolu ayırmalıdır. Kaynak kodda bir yolun bulunması ile o yolun kullanılan dağıtımda etkin olması da ayrıdır. Yerel bir yardımcı fonksiyonun sınanması ile gerçek sağlayıcı, kimlik, ağ ve kullanıcı akışı altında çalışması da ayrıdır. Bu ayrımlar, dış örneğin değerini küçültmez; hangi bilginin güvenle yeniden kullanılabileceğini belirler.

İyi araştırma karşı örnek arar. Seçilen açıklamanın işlemediği bir yol var mı? Başka bir alt sistem aynı kelimeyi farklı anlamda mı kullanıyor? Başarılı görünen sonuç başka bir nedenle ortaya çıkmış olabilir mi? Bir yöntem, ölçülmeyen kullanıcı emeğini dışarıda bıraktığı için ucuz veya otonom mu görünüyor? Araştırmacının görevi kendi ilk açıklamasını savunmak değil, açıklamasını bu baskıya dayanıklı hale getirmektir.

Araştırma sonucu da yeniden kullanılabilir olmalıdır. Kaynak kimliği, gözlenen kapsam, çıkarım, sınırlama ve hangi tasarım sorusuna yaradığı birlikte saklanmalıdır. “Bu repo iyi” veya “bu yöntemi kullanalım” düzeyindeki kayıtlar, sonraki ekip için yetersizdir. İyi kayıt, başka bir aktörün gerektiğinde özgün kanıta inebilmesini ve aynı hükmü farklı koşullara körlemesine taşımamasını sağlar.

Son olarak araştırmanın durma gerekçesi olmalıdır. Aynı ayrımı destekleyen onuncu örnek, ilk örnek kadar değerli olmayabilir. Ama sonucun dayandığı kritik bir boşluk varsa, yüzlerce yüzeysel kaynak o boşluğu kapatmaz. DevOS, yeni araştırmanın karar kalitesine beklenen katkısını tartabilmeli; bilgi biriktirmeyi amaçla karıştırmamalıdır. [K05]

## 12. İyi karar: seçenek, dayanak, yetki ve yeniden açılabilirlik

Bir kararın iyi görünmesi, iyi karar süreciyle verildiğini kanıtlamaz; iyi süreç de sonucu kesin olarak garanti etmez. DevOS'un koruması gereken şey, kararın o anda mevcut bilgi, belirsizlik, amaç ve yetki altında gerekçelendirilebilir olmasıdır. Sonradan farklı sonuç çıkması, önceki kararın mutlaka kötü olduğu anlamına gelmez. Buna karşılık tesadüfen iyi sonuç alınması da zayıf gerekçeyi sağlamlaştırmaz.

Karar kaydı yalnız seçilen seçeneği değil, kararı taşıyan esas gerekçeyi korumalıdır. Hangi soruya cevap veriliyor? Hangi anlamlı alternatifler değerlendirildi? Hangi kısıtlar belirleyici oldu? Hangi belirsizlikler kaldı? Karar kimin yetkisinde? Hangi değişiklikte yeniden açılması gerekir? Bu içerik, her küçük seçim için uzun bir tören anlamına gelmez; kararın etkisiyle orantılı bir gerekçe izi anlamına gelir. [K05]

DevOS'ta teknik uyuşmazlıkların tamamı kullanıcıya taşınmamalıdır. Yetkilendirilmiş alan sorumlusu gerekçeli tasarım tercihi yapabilir. Fakat olgusal bir karşı kanıt, “çoğunluk böyle istedi” veya “takvim sıkıştı” diye yok sayılmamalıdır. İnceleyicinin kanıt hükmü ile karar sahibinin risk kabulü ayrı kalmalıdır. Açık bir kusuru kabul ederek ilerlemek, kusurun bulunmadığını iddia etmek değildir. [K18]

Karar değiştirmenin de düzgün bir yolu olmalıdır. Eski kararın neden geçerli olduğu, neyin değiştiği ve hangi bağlı işlerin etkilenebileceği korunmalıdır. Fikir değişikliğini yalnız dosyanın son sürümünü değiştirerek ifade etmek, gerekçeyi ve etkiyi kaybettirir. Öte yandan her yeni bilgi bütün geçmiş kararları iptal etmez; alternatif dayanakla geçerli kalan kararlar korunabilir.

Bu düzenin yaratacağı esas nitelik, “hep doğru karar veren ajan” iddiası değil, **kararlarının sınırlarını bilen, karşı kanıta açık, gerektiğinde düzelebilen ve düzeltmeyi çalışmanın geri kalanına taşıyabilen ekip** olmalıdır.

# III. Bu niteliği taşıyacak çalışma sistemi

## 13. Aktörler: unvanlardan önce sorumluluk ve yeterlik

DevOS'un organizasyonu, popüler ajan unvanlarını sıralayarak kurulamaz. Önce SOUL'u geliştirmek için hangi sorumlulukların taşınması gerektiği bulunmalıdır. Sonra bu sorumlulukların hangilerinin aynı çalışma rolünde birlikte yürütülebileceği, hangilerinin amaç çatışması veya bağımsızlık ihtiyacı nedeniyle ayrılması gerektiği değerlendirilmelidir. EXP-006'nın işi ve sorumluluğu önceleyen yönü bu nedenle önemlidir. [K08]

Sorumluluk alanları arasında iş keşfi ve planlama, araştırma, alan tasarımı, sistem bütünlüğü, uygulama, sınama tasarımı, sınama yürütümü, sonuç incelemesi, bilgi bakımı, bağlam kurma, rol ve katılım yönetimi, ortam işletimi, yetki kontrolü, koordinasyon, teşhis ve yöntem geliştirme bulunabilir. Bu liste sabit ajan sayısı değildir. Bazı sorumluluklar birleştirilebilir, bazıları işin büyüklüğüne göre ayrılabilir; kimi mekanik işler için bir LLM rolü hiç gerekmeyebilir.

### 13.1. Tek ve çelişkisiz başarı yönü

EXP-002'deki “tek motivasyon” tartışmasının korunması gereken sonucu, bir aktörün belirli bir çalışma rolündeki terminal amacının belirsiz veya çelişkili olmamasıdır. Aynı temel model farklı zamanlarda farklı rolleri üstlenebilir. Ancak o anda ürün oluşturmak mı, ürün iddiasını bağımsız olarak sınamak mı, yoksa uyuşmazlığın nedenini teşhis etmek mi için çalıştığı açık olmalıdır. [K02]

Bu, geliştiricinin kendi kodunu test etmesini yasaklamak değildir. Kendi işini kontrol etmek iyi üretimin parçasıdır. Fakat üreticinin kendi testleri, özellikle yüksek etkili iddialarda, bağımsız kabul değerlendirmesinin yerine otomatik geçmez. Aynı şekilde doğrulayıcının amacı sonsuza kadar hata arayıp işi durdurmak değildir; kapsamı belirli bir iddianın yeterli kanıtla desteklenip desteklenmediğini dürüstçe belirlemektir.

Tek başarı yönü, tek işlem veya tek fonksiyon demek de değildir. Bir araştırmacı kaynak bulabilir, karşılaştırabilir, deney tasarlayabilir ve bulgularını yazabilir; bunların hepsi aynı araştırma amacına hizmet edebilir. Buna karşılık kendi iddiasının haklı çıkmasını istemek ile o iddianın yanlışlığını aramak aynı rol içinde gerilim yaratabilir. Ayrım fonksiyon sayısından çok başarı baskısındadır.

### 13.2. Rol, aktör, model ve çalıştırma

Rol, beklenen sorumluluk ve davranış sözleşmesidir. Aktör, belirli koşullarda bu rolü üstlenen taşıyıcıdır. Model, onun muhakeme kapasitesine katkı veren bileşenlerden biridir. Çalıştırma ise belli bir hedef, bağlam, araç ve yetki altında gerçekleşen somut denemedir. Bunların adları aynı olabilir; kimlikleri ve ömürleri aynı değildir. [K19, K17]

Bir rolün dosyasını oluşturmak, aktörün gerçekten hazır olduğu anlamına gelmez. Kullanılan modelin yeterliği, gerekli kaynakların görünürlüğü, araçların fiilî erişimi, yetki kapsamı ve çıktıların nereye döneceği birlikte kurulmalıdır. Aktörün “atanmış” görünmesi de çalıştığını veya hâlâ canlı olduğunu göstermez.

### 13.3. İnsan kullanıcının yeri

Kullanıcı amaç, değer tercihleri, yetki, bütçe ve kabul konularında belirleyici olabilir. Bu, her teknik açığın kullanıcı tarafından keşfedilmesini veya her ajan geçişinin kullanıcı tarafından başlatılmasını gerektirmez. DevOS'un hedefi, kullanıcıyı görünmez proje yöneticisi, kaynak hatırlatıcısı, mesaj taşıyıcısı ve durum uzlaştırıcısı olmaktan çıkarmaktır. [K08, K13]

İnsan uzman kullanılması gereken yerde de aynı ayrım korunmalıdır. Uzman gereksinimini bulmak, uygun soruyu hazırlamak, görüşü çalışma durumuna bağlamak ve sonuçlarını değerlendirmek sistemin işi olmaya devam eder. İnsan katılımı, koordinasyon sorumluluğunu belirsizce dışarı atmanın bahanesi olmamalıdır.

## 14. Ürün geliştirme ile çalışma düzenini işletmek

DevOS içinde iki farklı hedef nesnesi bulunur. Birincisi SOUL'u geliştirmektir. İkincisi SOUL'u geliştiren ekibin kendi çalışma düzenini kullanılabilir, güncel ve sürdürülebilir tutmaktır. EXP-006'nın G ve Y ayrımı bu farkı korur. SOUL'un bellek yeteneğini geliştirmek ürün işidir; o yeteneği geliştiren ekibin kendi araştırma kayıtlarını düzenli tutmak ise DevOS'un işletim işidir. Her iki tarafta da iş, bilgi, aktör ve ortam ilişkileri bulunur. [K18]

Bu ayrım iki kapalı departman veya iki ayrı repository zorunluluğu doğurmaz. Aynı uzmanlık iki hedefte de kullanılabilir. Ancak hedef nesne, yetki ve başarı ölçütü karışmamalıdır. Çalışma alanını düzenleyen kişi, bir tasarım kararının anlamını klasör temizliği gerekçesiyle değiştirmemelidir. Ürün tasarımcısı da “ben içeriği yazdım, bulunabilirliği başkasının işi” diyerek sahipsiz çıktılar bırakmamalıdır.

İçerik sahibi ne söylendiğinden, hangi gerekçeyle söylendiğinden ve hangi hükmün savunulduğundan sorumludur. Bilgi bakımı tarafı ise bu içeriğin nerede bulunduğunu, hangi statüde olduğunu, hangi kaynağa dayandığını, nasıl yeniden bulunacağını ve eski sürümlerle nasıl ayrıldığını korur. Bu iki sorumluluk birlikte çalışır; biri diğerinin yerine geçmez.

Koordinasyon da iki açıdan düşünülmelidir. Ürün koordinasyonu, katkıların hedefe nasıl birleştiğini, öncelikleri ve iş bağımlılıklarını izler. İşletim koordinasyonu, gerçek aktörlerin etkinleşmesini, erişimi, kapasiteyi, beklemeyi, bakım ve devamı yönetir. Bir operasyon sorunu ürün önceliğini etkileyebilir; fakat işletim tarafı teknik kolaylık için ürün hedefini sessizce daraltmamalıdır.

Çalışma düzeninin bakımı dekorasyon değildir. Eski bir dosyanın hâlâ güncel giriş noktası olarak görünmesi, doğru kararı yanlış yönde etkileyebilir. Buna karşılık estetik bir adlandırma sorunu bütün işi durdurmak zorunda değildir. Bakımın önceliği, gerçek bilgi kaybı, yanlış yetki, kaybolmuş devam veya yanlış karar riskiyle ilişkilendirilmelidir.

## 15. Gerçek işbirliği: mesaj göndermekten katkıyı kullanmaya

Çok ajanlı bir yapıda işbirliği, aktörlerin sırayla rapor vermesinden daha fazlasıdır. Bir aktör ihtiyaç duyduğu katkıyı başka bir aktörden isteyebilmeli; istek uygun role ve doğru bağlama ulaşmalı; yanıt yeterlik ve belirsizlikleriyle dönmeli; talep sahibi bu yanıtı kullanmalı, gerekçeli reddetmeli veya ek çalışma istemelidir. EXP-006'daki talep–yanıt alışverişi beklentisi, son adıma kadar uzanır. [K08, K18]

Bir araştırmacının raporunun üretilmiş olması, tasarımın bu raporu kullandığını göstermez. Mesajın teslim edilmiş olması da tasarımcının ilgili bilgiyi gördüğünü veya anlamını doğru kurduğunu göstermez. Bu nedenle kritik katkıların bir **dönüş ve kullanım bağı** olmasını öneriyorum: hangi soru için istendiği, hangi sürüme ilişkin olduğu, kimin yanıtı beklediği ve yanıtın hangi karara veya işe döneceği görünür olmalıdır.

Bu bağ, her mesaj için büyük bir form doldurmak anlamına gelmez. Basit bir dosya düzeltmesi kısa bir kayıtla taşınabilir. Bir mimari itiraz ise hedef iddiayı, dayanağı, kapsamı ve beklenen karşılığı açıkça taşımalıdır. İletişim yükü, katkının yanlış anlaşılması veya kaybolması halinde doğacak etkiyle orantılı olmalıdır.

İtirazların da yaşam döngüsü bulunmalıdır. Bir itiraz karşılandığında, gerekçeli olarak reddedildiğinde, öncülü geri çekildiğinde veya açık kapsamıyla ertelendiğinde karşılık bulur. Dosyanın adını değiştirmek, yeni bir taslak yayımlamak veya başka bir ajan çağırmak itirazı kendiliğinden kapatmaz. İddia devam ediyorsa itirazın ilişkisi de korunmalıdır. [K18]

Burada sonsuz veto riski vardır. Her aktörün her işi durdurabildiği bir yapı, doğru görünen fakat ilerleyemeyen bir sisteme dönüşebilir. Bu yüzden durdurma yetkisi, hedef iddia ve etki alanıyla sınırlandırılmalıdır. Karar-kritik kanıt açığı ilgili kabulü durdurabilir; ilgisiz işler ilerleyebilir. Tercih uyuşmazlığını çözmek ile yanlış olguyu olumlu hükme çevirmek birbirinden ayrılmalıdır.

İşbirliğinin başka bir sınırı ortak kör noktalardır. Aynı modelin benzer bağlamlarla verdiği çok sayıda görüş, bağımsız gözlem sayısını artırmayabilir. Farklı rol isimleri fikir çeşitliliğini garanti etmez. Bazen gerçek alan kaynağı, bağımsız hesap, farklı değerlendirme yöntemi, gerçek kullanım deneyi veya farklı bilgi koşullarındaki bir inceleme, bir ajan daha eklemekten daha değerli olabilir. [K05]

## 16. İş yönetimi: yaşayan bir iş ağı

SOUL ve DevOS'un iş düzeni, yalnız yapılacaklar listesi olmamalıdır. İş; amaçlara, araştırma sorularına, kararlara, kaynaklara, üretim çıktılarına ve değerlendirmelere bağlı bir ağ olarak ele alınmalıdır. Ağın tamamının baştan bilinmesi gerekmez. Yeni bilgi geldikçe işler eklenir, bölünür, birleştirilir, sırası değişir, iptal edilir veya yeniden açılır. Yaşayan plan fikri, EXP-001'den sonraki iş yönetimi araştırmalarına kadar süreklidir. [K01, K15, K20]

Bir işin kimliği, onu çalıştıran oturumdan bağımsız olmalıdır. Aynı iş farklı oturumlarda, farklı aktörlerle ve birden fazla denemeyle sürdürülebilir. Çalıştırma başarısız olsa bile araştırmanın bazı çıktıları geçerli kalabilir. Oturum başarıyla kapanmış olsa bile işin kabul koşulu açık kalabilir. Bu yüzden iş, çalıştırma, oturum, mesaj, çıktı ve karar tek bir “durum” alanında eritilmemelidir.

“Bitti” kelimesi de birkaç farklı iddiayı gizleyebilir. Çıktı üretildi mi? Teknik sınama geçti mi? İddia yeterli kanıtla desteklendi mi? Yetkili kullanım için kabul edildi mi? Gerçek hedefte yayımlandı mı? Kullanıcı ihtiyacını karşıladı mı? Bu soruların bazıları belirli işlerde birleşebilir; her zaman birleşmeleri varsayılmamalıdır.

### 16.1. İlişki türleri anlam taşımalı

Bir işin başka bir işten keşfedilmiş olması, onu otomatik olarak engellediği anlamına gelmez. Bir belgeye atıf yapılması, o belgenin tüm içeriğinin kararı taşıdığı anlamına gelmez. Üst–alt iş ilişkisi, yürütme sırası ile aynı değildir. Beads araştırmasının keşif kökeni, engelleme, hazır oluş ve canlı sahiplik ayrımları bu konuda somut örnekler sağlar. [K15]

İş ağındaki ilişkiler bu nedenle gerektiği kadar türlenmelidir: önkoşul, alternatif yöntem, araştırma kökeni, kullanılan kanıt, üretilen çıktı, doğrulanan iddia, yerini alma, beklenen yanıt veya etkilenen karar gibi. Ancak sırf ayrım yapılabiliyor diye bütün olası ilişki türlerini baştan inşa etmek de gereksiz olabilir. İlişki modeli, gerçek karar ve kontrol ihtiyacını karşılamalıdır.

### 16.2. Hazır olmak, açık olmak ve öncelikli olmak farklıdır

Açık bir iş, gerekli kaynak veya yetki bulunmadığı için yapılamıyor olabilir. Hazır bir iş, başka bir kritik işin yanında düşük öncelikli olabilir. Öncelikli bir iş ise önce bir araştırma veya ortam hazırlığı gerektirebilir. İş seçimi, bu boyutları birlikte tartmalıdır.

Ajanlar aynı işi almak için yarıştığında, “işi seçtim” ile “bu işin yetkili yürütücüsü oldum” arasında teknik bir sahiplenme mekanizması gerekir. Uzun süredir çalışmayan bir aktörün sahiplik kaydı da sonsuza kadar işi kilitlememelidir. Fakat sahiplik süresinin dolması, eski aktörün dış dünyada hiç etki yapmadığı anlamına gelmez. Operasyonel canlılık ile dış etki durumu ayrı takip edilmelidir. [K15]

### 16.3. Geri dönmek yalnız kutucuğu yeniden açmak değildir

Yeni bir bilgi önceki kararı geçersiz kıldığında, o karara bağlı hazır oluş ve değerlendirme sonuçları da etkilenebilir. Bir işi yeniden açmak, yalnız kendi durumunu değiştirmekten daha geniş sonuç doğurabilir. Hangi etkilerin gerçekten gerçekleştiği ve hangilerinin yalnız planlandığı ayrılmalıdır.

Flowable araştırmasındaki süreç, vaka ve karar ayrımı burada yararlıdır. Bazı işler belirli akışlarla yürür; bazıları olay ve koşullarla etkinleşen vaka çalışmasıdır. Devam eden bir işin planını değiştirmek, yalnız diyagramı düzenlemek değil, mevcut çalışma durumunu yeni tasarıma nasıl taşıyacağını belirlemektir. Yeniden deneme, askıya alma, iptal, yeniden planlama ve telafi aynı işlem değildir. [K21]

## 17. Bilgi ve ek hafıza: saklamak için değil, kullanmak için

EXP-003'ün merkezindeki düşünce, ek hafızanın değerinin dosyaların kalıcı olmasından değil, gerektiğinde doğru biçimde kullanılmasından geldiğidir. Eğitimle gelen bilgi, mevcut bağlam ve dışarıda yönetilen bilgi birbirinden ayrılmalıdır. Dosya oluşturmak, dosyanın içindeki bilgiyi değiştirmek ve o bilgiyi gelecekteki bir karara taşıyan mekanizmayı işletmek aynı şey değildir. [K14]

DevOS'un bilgi düzeni hem kaynakları hem üretilmiş yorumları taşımalıdır. Ancak özgün kaynak, çıkarım, karar, hipotez, gözlem, yöntem ve yetkili talimat aynı statüde tutulmamalıdır. Bir kaynak bir iddiayı aktarıyor olabilir; bu onun doğru olduğunu göstermez. Bir karar bir koşulda kabul edilmiş olabilir; bu onun her yeni işte geçerli olduğunu göstermez.

### 17.1. Bilgi yaşam döngüsü

Bir bilgi nesnesi için gerektiği ölçüde şu ilişkiler korunmalıdır: nereden geldiği, neyi temsil ettiği, hangi zaman ve kapsam için geçerli olduğu, hangi kanıtla desteklendiği, kimin hangi kullanımı için yeterli bulunduğu ve hangi değişiklikte yeniden değerlendirileceği. Bu, her dosyaya dev bir metadata formu koyma emri değil; karar-kritik anlamın kaybolmamasını sağlayacak yaşam döngüsü tasarımıdır.

Yeni bilgi önceki bilgiyle çelişiyorsa eski metnin üstüne sessizce yazmak yeterli olmayabilir. Gerçek bir düzeltme mi var, farklı zamanlardan söz mü ediliyor, farklı kapsamlar mı karşılaştırılıyor, yoksa yorum farkı mı var? Çelişki çözülemiyorsa belirsizlik korunmalıdır. Sistem, belirsizliği ortadan kaldırmış görünmek için bir seçeneği rastgele “güncel gerçek” yapmamalıdır.

Bilginin güncellenmesi, ondan türeyen görünümleri ve kararları da ilgilendirir. Bir kaynak değiştiğinde her dosyanın değişmesi gerekmez. Fakat hangi kararların o kaynağa maddi biçimde dayandığı araştırılmalıdır. Grafikte bir bağımlılık kaydı bulunmaması, gerçek bir bağımlılığın olmadığına kesin kanıt değildir. Semantik etki değerlendirmesi bu nedenle bütünüyle mekanik bir bağlantı taramasına indirgenemez. [K11, K18]

### 17.2. Özetler kaynak yerine geçmemeli

Özetler, uzun çalışmalarda yeniden giriş için çok yararlıdır. Fakat bir özetin bugünkü soruya cevap vermesi, gelecekteki farklı bir soruya veya bilgi güncellemesine de yeterli olacağını göstermez. Foundation'ın yeniden ifade ve sürdürülmüş bilgi ayrımları, “aynı cevabı üretiyor” ile “gelecekte aynı biçimde güncellenebilir” arasındaki farkı korur. [K11]

Bu nedenle özetin amacı, koruduğu kapsam, kaynak ilişkisi ve eksilttiği önemli ayrıntılar gerektiğinde anlaşılabilir olmalıdır. Kritik bir hüküm için özgün kaynağa dönüş mümkün kalmalıdır. Bütün tarihi her seferinde bağlama yüklemek çözüm olmadığı gibi, her şeyi kısa bir devir notuna sıkıştırmak da genel çözüm değildir.

### 17.3. Bir dersin kaydı ile öğrenilmesi farklıdır

Bir başarısızlıktan sonra yazılan ders, bilgi deposunda durabilir ama bir sonraki benzer işte kullanılmayabilir. Hatta kullanılsa bile doğru bağlama uygulanmamış olabilir. “Dersler dosyamız var” ifadesi bu yüzden öğrenme iddiasını taşımaz. Dersin ilgili fırsatta seçilmesi, karara veya davranışa uygun biçimde etki etmesi ve bu etkinin gerektiğinde korunması gerekir. [K09, K17]

Tersi de mümkündür: Modelin ağırlıkları değişmeden, dışarıdaki yöntem veya bilgi taşıyıcısı değiştiği için sistemin gelecek davranışı değişebilir. Bu durumda öğrenmenin taşıyıcısı yalnız model değil, model ile dış bilgi ve kullanım yolu arasındaki bütün ilişkidir. Bunu modelin kendi içinde yeni bilgi öğrendiği şeklinde sunmamak gerekir.

### 17.4. Kalıcılık, mahremiyet ve unutma

Her şeyin sonsuza kadar saklanması iyi hafıza demek değildir. Kaynak hakkı, erişim yetkisi, kişisel veri, saklama süresi, yanlış bilginin düzeltilmesi ve gerektiğinde silinmesi düşünülmelidir. Bir bilgiyi ana kayıttan silmek; türetilmiş özet, indeks, yedek veya başka projeye aktarılmış yöntem içinde kalan izleri kendiliğinden çözmeyebilir.

SOUL'un projeler arasında birikim taşıması da bu sınırı gerektirir. Bir projede öğrenilen genel yöntem başka projeye yararlı olabilir; proje sahibine ait içerik veya özel bilgi otomatik ortak hafızaya dönüşmemelidir. Yeniden kullanımın teknik olarak mümkün olması, meşru olduğu anlamına gelmez.

## 18. Bağlam: doğru bilgi doğru aktörde, doğru anda

Bağlam yönetimi, modelin o anda fiilen gördüğü çalışma malzemesini kurma işidir. Ek hafıza zaman içindeki bilgi yaşamını taşırken, bağlam belirli bir düşünme ve eylem anının görünümüdür. Harness ise bağlamı, araçları, izinleri ve döngüyü işleten daha geniş yürütme düzenini kapsayabilir. Bunları üç kapalı, eş düzey kutu gibi düşünmek yerine sorumluluk ve hata yüzeyleri olarak ayırmak daha açıklayıcıdır. [K22]

Anthropic'in context engineering açıklaması da yalnız sistem promptunu değil, araç sonuçları, geçmiş ve mevcut girdiler dahil modelin kullandığı malzemenin seçimini ele alır. Belge, ihtiyaca göre kaynağa gitme, bağlam sıkıştırma ve kalıcı notlar gibi farklı yolları tartışır; en kısa bağlamı değil, görev için yeterli ve yüksek bilgi değerli bağlamı hedefler. Bu, SOUL için belirli bir ürün seçimi değil, ilgili bir mühendislik karşılaştırmasıdır. [D01]

Bir aktöre verilecek görünümde ortak çalışma standardı, o anki rol, yetkili hedef, ilgili iş ve kararlar, gerekli kaynak sürümleri, açık belirsizlikler ve çıktının döneceği yer bulunmalıdır. Bunların tamamı her zaman uzun metin olarak verilmek zorunda değildir. Bir kısmı güvenilir başvuru ve getirme yollarıyla taşınabilir. Fakat “gerekirse okur” varsayımı, aktörün o kaynağın varlığını ve önemini fark edebildiği gösterilmeden yeterli değildir.

Bağlamı kuran tarafın da her alanın uzmanı olduğu varsayılmamalıdır. Uzman, hangi bilginin yeterli olduğuna katkı verir; bağlam sistemi bu bilginin doğru sürümünü ve tüketici yolunu korur. İnceleyici, üreticinin kendi özetine hapsedilmemelidir. Gerektiğinde özgün ürüne ve kanıta erişebilmelidir.

Roman gibi işlerde bağlamın sırası ve bilgi sızıntısı da önemlidir. Sonu bilen bir değerlendiricinin, ilk kez okuyan kişinin deneyimini kendiliğinden temsil ettiği söylenemez. “Sonu unut” talimatı gerçek bilgi izolasyonu değildir. İlk okuma deneyimi iddiası için, değerlendiricinin gerçekten hangi metni hangi sırada gördüğü önem kazanır. EXP-004'ün okuma geçişi ve bütün ürün tartışmaları bu ihtiyacı açar. [K06]

Bağlam kurma başarısını yalnız token miktarı veya doğru dosyanın listede görünmesiyle ölçmemek gerekir. Asıl soru, aktörün iş için gereken ayrımları kurabilmesi ve önemli bilgi eksikliği nedeniyle yanlış hükme varmamasıdır. Az bağlam da çok bağlam da yanlış olabilir; doğru miktar, kullanımın gerektirdiği yeterlik üzerinden değerlendirilmelidir.

## 19. Süreklilik: açık sohbetten bağımsız bir devam yolu

SOUL ve DevOS'un sürekliliği, ana sohbetin açık kalmasına bağlanmamalıdır. Sohbet, insanın sistemi izlediği ve yönlendirdiği bir yüzey olabilir. Fakat işin kimliği, geçerli kararlar, beklenen katkılar, çalıştırmalar ve yeniden başlama koşulları yalnız o konuşmanın bağlamında yaşıyorsa, sistemin sürekliliği kırılgandır. Hermes ve RPD kayıtları, kalıcı iş durumu ile işi yeniden harekete geçiren mekanizmayı ayırır. [K04, K17]

Bir veritabanına “bekliyor” yazmak kendi başına devam sağlamaz. Hangi olayın, zamanın veya koşulun bu işi yeniden değerlendireceği; bunu hangi yetkili yürütücünün yapacağı; yeniden girişte neyi okuyacağı ve hangi sınırlar içinde ilerleyebileceği belirlenmelidir. Dolayısıyla kalıcı kayıt, devam kararı ve gerçek çalıştırma yolu üç ayrı gereksinimdir.

Dayanıklı yürütme yaklaşımları burada kullanılabilecek mühendislik ailesidir. Örneğin Temporal'ın belgeleri, bir yürütmenin kaydedilmiş olay geçmişi üzerinden yeniden kurulmasını ve uygun yerden sürmesini açıklar. Böyle bir mekanizma yürütme sürekliliği sağlar; hangi işin yapılmasının doğru olduğunu veya bir LLM sonucunun yeterli olduğunu kendi başına belirlemez. [D02]

### 19.1. Kesinti sonrası üç ayrı soru

Bir kesintiden sonra önce mevcut gerçek durum anlaşılmalıdır. İşlemin dış dünyada gerçekleşip gerçekleşmediği, hangi kaydın kalıcı olduğu ve hangi aktörün artık yetkili olduğu belirsiz olabilir. Ardından amaç, plan ve açık kararlar yeniden kurulmalıdır. Son olarak hangi işin şimdi yapılabileceği yeniden değerlendirilmelidir.

Bu yüzden bir devir kaydı yalnız “sıradaki adım” olmamalıdır. Hedef, temel sürümler, yapılan ve yapılmayan işler, açık itirazlar, beklenen yanıtlar, sahiplik, belirsiz dış etkiler ve devam sınırı korunmalıdır. Bütün sohbet dökümü de bunun yerine otomatik geçmez; çok bilgi bulunması, doğru çalışma durumunun kolayca geri kazanılabildiğini göstermez. [K18]

Eski bir aktör geç yanıt döndüğünde, çıktısı yararlı olabilir ama artık geçerli durumu değiştirmeye yetkili olmayabilir. Çıktıyı kanıt veya taslak olarak korumak ile güncel karara uygulamak ayrılmalıdır. Yeni aktörün görevi de her şeyi yeniden üretmek değil, mevcut güvenilir birikimi uygun biçimde devralmaktır.

### 19.2. Sonucu bilinmeyen etki

Bir dış işlem zaman aşımına uğradığında “olmadı” sonucu çıkarılamaz. Yayın, bildirim veya kaynak oluşturma işlemi gerçekleşmiş ama yanıt kaybolmuş olabilir. Körlemesine yeniden denemek, tekrarlı etki üretebilir. AWS'nin idempotent API tasarımı açıklaması, tekrar denemelerde niyet kimliğinin ve aynı isteğin güvenli biçimde tanınmasının önemini gösterir. [D03]

SOUL için önerim, gerektiğinde **sonucu bilinmeyen etki** durumunu açıkça taşımasıdır. Bu durum, başarısızlık veya başarı gibi davranmamalıdır. Sistem gerçek hedefteki durumu uzlaştırmalı; ancak bundan sonra yeniden deneme, devam veya insan müdahalesi gereğini belirlemelidir. Yerel işlem kaydı, başka bir hizmette tam olarak bir kez etki gerçekleştiğinin genel garantisi değildir.

Bir sahiplik süresinin dolması veya eski aktörün yazma hakkının engellenmesi de geçmiş dış etkileri geri almaz. Yeniden deneme, geri alma, telafi ve gerçek durum uzlaştırması ayrı mekanizmalardır. Bunların aynı “recovery” kelimesi altında belirsiz bırakılmaması gerekir.

### 19.3. Devam etmek ile sonsuza kadar çalışmak

Kullanıcının her rutin geçişi başlatmaması hedefi, sınırsız kaynak tüketimi veya hiçbir zaman durmayan ajanlar anlamına gelmez. Bütçe, yetki, kapasite, dış bekleme ve amaç tamamlanması meşru durma nedenleridir. Fakat durmanın nedeni açık olmalıdır. “Gerekli insan kararı bekleniyor” ile “sistem kendi sıradaki işini başlatamıyor” aynı durum değildir.

DevOS'un iyi işletimi, bu farkları kullanıcıya anlaşılır biçimde göstermelidir. Kullanıcı, sistemin canlı mı, duraklamış mı, bir katkıyı mı bekliyor, yoksa hatalı bir döngüye mi girmiş olduğunu sürekli kendisi teşhis etmek zorunda kalmamalıdır.

## 20. Yetki, kontrol ve güvenlik: kabiliyetin sınırı

SOUL'un daha fazla iş yapabilmesi, daha fazla kontrolsüz yetki verilmesi gerektiği anlamına gelmez. Bir rolün bir işi yapması bekleniyor olabilir; ama teknik erişimi olmayabilir. Teknik erişimi olabilir; ama o eylem için meşru yetkisi olmayabilir. Başka bir ajan üzerinden eylem yaptırabiliyor olabilir; fakat bu dolaylı yol yetki sınırını ortadan kaldırmaz. Foundation'ın aktör ve kontrol araştırmaları bu ayrımları korur. [K09, K19]

Yetki, yalnız “bu ajan yazabilir” gibi genel bir sıfat olarak değil, hangi hedefte, hangi nesneye, hangi işlemle, hangi koşullarda etki edebileceği üzerinden düşünülmelidir. Bir taslak üretme izni ile onu güncel kaynak yapma izni aynı değildir. İnceleme yapma izni ile yayımlama izni aynı değildir. Teknik testin geçmesi, kullanıcı adına yeni bir harcama veya kapsam değişikliği yetkisi yaratmaz.

OWASP'ın excessive agency yaklaşımı, araç işlevlerinin, izinlerin ve otonominin gereksiz genişliğini ayrı risk kaynakları olarak ele alır. SOUL açısından bunun karşılığı, önemli sınırların yalnız modele söylenen kurallara bırakılmamasıdır. Uygun yerde dar araç yüzeyi, kapsamlı kimlik, erişim ayrımı ve eylem kapıları gerekir. [D04]

### 20.1. Kaynak içerik talimat değildir

Araştırılan bir web sayfası, bir dosya veya başka bir ajanın mesajı, yalnız içerdiği cümleler nedeniyle yönetici yetkisi kazanamaz. Bir kaynaktaki talimatın modele görünmesi, onun uygulanması gerektiği anlamına gelmez. Bu sınır özellikle araştırma, bellek ve çok ajanlı iletişim yollarında korunmalıdır.

Aynı risk iç kaynaklarda da vardır. Geçmiş bir denemede verilmiş “devam et” talimatı, bugünkü işi yeniden başlatma yetkisi değildir. Arşivdeki bir rol tanımı güncel rol sözleşmesi gibi yüklenmemelidir. Bu nedenle güvenlik, yalnız dışarıdan kötü niyetli metne karşı savunma değil, tarihsel veya yanlış kapsamlı talimatın güncel yetki gibi kullanılmasını önleme işidir.

### 20.2. Mantıksal tek otorite, tek her şeyi bilen ajan değildir

Güncel bir kaydın hangi sürümünün yetkili olduğu belirli olmalıdır. Fakat bundan bütün muhakemenin tek bir merkezi ajana verilmesi sonucu çıkmaz. Çok sayıda uzman paralel katkı üretebilir; güncel değişikliklerin kabul ve yayın yolu ise tutarlı bir sözleşmeyle işletilebilir.

Önerdiğim ayrım, **muhakemenin dağıtılması, geçerli durum değişikliklerinin ise açık kurallarla birleştirilmesidir**. Tek yetkili kayıt, tek fiziksel makine veya tek yazıcı süreç zorunluluğu değildir. Önemli olan, eşzamanlı veya gecikmiş iki değişikliğin aynı güncel nesneyi sessizce çelişkili hale getirmemesidir.

Kritik işlemlerde aktörün okuduğu temel sürüm, kullandığı yetki ve değiştirmek istediği nesne birlikte kontrol edilmelidir. Bir çıktı doğru olabilir ama eski bir temele dayanıyor olabilir. Bir onay gerçek olabilir ama artık geçerli olmayan bir sürüme ilişkin olabilir. Bu yüzden doğruluk, güncellik ve yetki ayrı ayrı korunmalıdır. [K04, K18]

### 20.3. Kontrolün kapsamı gerçek etki yollarını izlemeli

Bir araç çağrısını engellemek, aynı etkinin başka bir araç veya başka aktör üzerinden yapılamadığını kanıtlamaz. Bir yayın yolunu korumak, bütün bypass yollarını korumak değildir. Bu nedenle kontrollerin yeterliği, yalnız kontrolün varlığıyla değil, korunmak istenen etkiye giden gerçek yollarla değerlendirilmelidir.

Bu yaklaşım aşırı kontrol üretmek için kullanılmamalıdır. Taslak araştırma ile geri alınması zor dış yayın aynı yoğunlukta kapılara ihtiyaç duymaz. Ama basit görünen bir yolun kritik etkiye ulaşabildiği yerde, güvenlik değerlendirmesi yüzeydeki işlem adına değil gerçek sonuca bakmalıdır.

## 21. Öğrenme ve Academy: hatayı yamamaktan yetkinliği geliştirmeye

SOUL Academy keşif notunun güçlü katkısı, bir hatayı düzeltmek ile o hatayı doğuran yetkinlik eksikliğini gidermeyi ayırmasıdır. Bir yanlış karar için yeni bir yasak eklemek, bir sonraki farklı örnekte doğru karar verebilen bir aktör oluşturmayabilir. Bu nedenle SOUL'un gelişimi yalnız kontrol listelerinin uzaması şeklinde tasarlanmamalıdır. Academy'nin kendisi ise henüz kabul edilmiş bir ürün bileşeni değil, araştırılmaya değer bir öneridir. [K23]

Örneğin bir ajan yanlış kaynak kullanmış olsun. Düzeltme, doğru kaynağı o dosyaya eklemek olabilir. Daha genel müdahale ise kaynak otoritesi, güncellik ve kullanım uygunluğu ayrımını aktörün çalışma standardına taşımak olabilir. Ancak başarısızlığın nedeni gerçekte erişim eksikliği ise, modele daha uzun bir kaynak değerlendirme talimatı vermek doğru müdahale değildir.

Bu nedenle öğrenme döngüsünün ilk işi teşhistir. Sorun temel model kapasitesinde mi, eksik alan bilgisinde mi, bağlam seçiminde mi, rol amacında mı, iletişimde mi, araçta mı, yetkide mi, yoksa değerlendirme ölçütünde mi? Düzeltme, doğru katmana yönlendirilmelidir. Bir olaydan tek ve evrensel bir kural çıkarmak aceleci genelleme olabilir. [K12, K23]

### 21.1. Deneyimden taşınabilir yönteme

Bir deneyimin yeniden kullanılabilir hale gelmesi için yalnız “şunu yapma” notu yetmez. Hangi koşulda sorun ortaya çıktı? Hangi mekanizma hatayı üretti veya mümkün kıldı? Önerilen müdahale neyi değiştirdi? Hangi koşullarda yararlı, hangi koşullarda gereksiz veya zararlı? Mevcut daha iyi bir yöntem var mı? Bu sorular, yerel deneyimi taşınabilir bir yetkinlik önerisine dönüştürür.

Yöntem paketleri, rol davranışları ve araç değişiklikleri bu birikimin farklı taşıyıcıları olabilir. Her gelişme fine-tuning gerektirmez. Her sorun prompt ile çözülmez. Her ders yeni bir ajan doğurmaz. Gelişmenin biçimi, teşhis edilen soruna ve ölçülen etkiye göre seçilmelidir.

### 21.2. Önerme, değerlendirme ve benimseme ayrı kalmalı

Bir yöntem geliştiren aktör, kendi yöntemini bütün sisteme otomatik dağıtmamalıdır. Önerinin belirli görevlerde yararı, yan etkileri, uyumluluğu ve geri alınabilirliği değerlendirilmelidir. Yerel bir işte işe yarayan davranış bütün projelere aktarılmadan önce ayrıca gerekçelendirilmelidir.

Academy benzeri bir yapı bu nedenle yöntem ve yetkinlik geliştirme sorumluluğu taşıyabilir; her SOUL örneğinin yerel yetki ve kabul düzenini ortadan kaldırmamalıdır. Bir yöntemin küresel kütüphanede bulunması, her aktörün onu kullanmaya mecbur olduğu anlamına gelmez. Hermes ve ECC araştırmalarının gösterdiği gibi, kayıt, dağıtım, seçilme, yüklenme ve fayda farklı aşamalardır. [K16, K17, K23]

### 21.3. Kendisini değiştiren sistemin sınaması

SOUL kendi yöntemlerini değiştirebiliyorsa, değişikliği değerlendiren mekanizmanın da ne kadar bağımsız olduğu sorulmalıdır. Aynı aktör hem yeni davranışı üretip hem değerlendirme ölçütünü değiştirip hem başarı ilan ediyorsa, öğrenme döngüsü kendini doğrulayan bir düzene dönüşebilir.

Bu yüzden değişiklik nesnesi, test ölçütü, kullanılan veri, değerlendirme ve kabul yetkisi izlenebilir olmalıdır. Testlerin yalnız yeni davranışa göre kolaylaştırılması başarı sayılmamalıdır. Eski yararlı davranışların korunması, farklı koşullara aktarım ve beklenmeyen yan etkiler ayrıca incelenmelidir. Öğrenme hedefi, daha çok kural veya daha yüksek öz değerlendirme puanı değil, gerçek işte daha iyi ve daha güvenilir davranış olmalıdır.

# IV. Mühendislik yaklaşımları ve mimari seçenekler

## 22. Hangi engineering yaklaşımlarına ihtiyaç duyulabilir?

Aşağıdaki adlar aynı sınıflandırma düzeyinde değildir. Bazıları yerleşik mühendislik disiplinleri, bazıları mimari kalıplar, bazıları planlama veya sınama yöntemleri, bazıları da ajan sistemlerindeki sorumluluk alanlarını adlandırmak için kullanılan terimlerdir. Özellikle “Loop Engineering” veya “Reasoning Engineering” gibi ifadeleri, tek ve evrensel bir standardın adı olarak değil, hangi tasarım işinden söz ettiğimizi belirten çalışma adları olarak kullanıyorum.

Buradaki amaç, SOUL'a mümkün olan bütün teknolojileri eklemek değil; ihtiyaç ortaya çıktığında hangi yöntem ailesinin neyi çözebileceğini bilmek. Her yaklaşım için benimseme kararı, gerçek iş koşulları ve gösterilmiş fayda üzerinden verilmelidir. [K22]

### 22.1. Systems Engineering ve Requirements Engineering

Sistem mühendisliği, parçaları ayrı ayrı geliştirmekten önce hedef, paydaş beklentileri, gereksinimler, tasarım, gerçekleştirme ve işletim arasındaki bütünlüğü kurmak için yararlı bir çerçevedir. Gereksinim mühendisliği, söylenmiş talebi ve keşfedilmiş ihtiyaçları açık, izlenebilir ve değerlendirilebilir yükümlülüklere dönüştürmeye katkı verir.

NASA'nın sistem tasarımı açıklaması, paydaş beklentileri, teknik gereksinimler, mantıksal ayrıştırma ve tasarım çözümleri arasında yinelemeli ve özyinelemeli ilişki kurar. SOUL için alınabilecek ders, gereksinimin tek seferde yazılıp kapanan bir belge olmadığı; kullanım, tasarım ve uygulanabilirlikle birlikte olgunlaşması gerektiğidir. Bu karşılaştırma NASA süreçlerinin bütünüyle kopyalanmasını gerektirmez. [D05]

**Goal-Oriented Requirements Engineering** ve **Concept of Operations — ConOps** da düşünülmesi gereken yaklaşımlardır. Birincisi gereksinimi hangi amaca hizmet ettiğiyle ilişkilendirmeye, ikincisi sistemin gerçek kullanımda nasıl çalışacağının açıklanmasına yardımcı olabilir. SOUL için “ajanlarımız var” tanımı yerine, belirli bir talebin karşılanması sırasında neyin nasıl gerçekleşeceğini açıklamak gerekir.

### 22.2. Decision Engineering, RPD ve hiyerarşik planlama

Karar mühendisliği başlığı altında seçenek oluşturma, karar-kritik varsayım analizi, kanıt değeri, etki ve geri alınabilirlik düşünülmelidir. RPD ise bu çalışmada ihtiyaçların ve önkoşulların keşfi için bir aday yöntemdir; bütün karar problemlerini çözen tek bir motor değildir.

**Hierarchical Task Network — HTN Planning**, bilinen yöntemler ve önkoşullar üzerinden soyut işleri alt işlere ayıran bir planlama ailesidir. Maryland Üniversitesi'nin SHOP açıklaması bu yaklaşımı görev ayrıştırmasıyla anlatır. RPD ile karşılaştırmak yararlıdır; fakat RPD'deki eksik yöntem, eksik bilgi ve yeni ihtiyaç keşfi, önceden tanımlanmış yöntem kümesi üzerinde plan üretmekle aynı problem değildir. [D11]

**Rolling-Wave Planning**, **Work Breakdown Structure — WBS**, bağımlılık ve kaynak planlama gibi yaklaşımlar, yakın işleri ayrıntılandırırken uzak işleri uygun soyutlukta tutmaya yardımcı olabilir. Bu yöntemlerin kullanımı, keşif sırasında planın değişebileceğini ve iş hiyerarşisinin yürütme sırası olmadığını korumalıdır. [K01, K15]

### 22.3. Agent Engineering ve Agent Architecture

Bu başlık, aktörün model, rol, bağlam, araç, yetki ve değerlendirme ilişkisini tasarlama işidir. “Hangi model?” sorusu burada yalnız bir parçadır. Aktörün hangi başarı yönüyle çalıştığı, nasıl katkı istediği, hangi çıktıyı yeterli saydığı ve ne zaman durduğu da mimarinin parçasıdır.

SOUL için gerekli tercih, her işi tek ajana vermek ile her işi ayrı ajanlara bölmek arasında soyut bir ideoloji olmamalıdır. Bağlam ihtiyacı, uzmanlık, gerçek bağımsızlık gereği, hata etkisi ve koordinasyon maliyeti hangi ayrımın yararlı olduğunu belirlemelidir. DevOS'un rol profilleri bu kararların test edilebilir başlangıçları olabilir; sabit ve değişmez kadro değildir. [K08, K12]

### 22.4. Loop Engineering

Ajanın gözlem, değerlendirme, seçim, eylem ve geri bildirim döngüsü tasarlanmalıdır. Döngü, model yanıtı alıp araç çağırmayı tekrar etmekten ibaret değildir. Hangi yeni bilginin planı değiştireceği, hangi hatanın yeniden deneneceği, hangi durumda araştırmaya dönüleceği ve hangi koşulda durulacağı önemlidir.

Tek bir ajan döngüsü ile uzun süreli işin dayanıklı yürütmesi karıştırılmamalıdır. Bir döngü oturum içinde iyi çalışabilir; oturum sona erdiğinde bütün durum kaybolabilir. Aynı şekilde dayanıklı yürütme motoru işi tekrar başlatabilir; ajan aynı yanlış düşünme yoluna tekrar girebilir. İki sorunun ayrı tasarlanması gerekir. [K17]

### 22.5. Harness Engineering

Harness; modelin gerçek bir çalışma düzeni içinde araçları, bağlamı, izinleri, kontrolleri, gözlemleri ve geri dönüş yollarını kullanmasını sağlayan çevredir. Sadece prompt değildir; yalnız alt ajan topolojisi de değildir. Gerçek etkilerin hangi yollardan gerçekleştiği ve hangi sınamaların nerede zorlandığı bu alana girer. [K22]

OpenAI'nin harness engineering deneyiminde, kısa bir giriş haritası, yapılandırılmış repo bilgisi, ajanların okuyabildiği çalışma ortamı ve mekanik olarak denetlenebilen kurallar öne çıkar. SOUL açısından bu yararlı bir karşılaştırmadır; ancak böyle bir düzenin varlığı iş keşfi ve bütünsel karar sorumluluğunu otomatik çözmez. [D06]

### 22.6. Context Engineering

Bu alan, belirli bir aktörün belirli bir iş için göreceği çalışma malzemesini kurar. Kaynak seçimi, yetkili sürüm, bilgi sırası, bağlam bütçesi, özetin yeterliği, gerektiğinde özgün kaynağa iniş ve bilgi izolasyonu bu sorumluluğa girer.

Başarı, yalnız daha az token kullanmak değildir. Kritik bilginin eksilmemesi, yanlış veya eski bilginin gereksiz ağırlık kazanmaması ve aktörün önemli kaynaklara yönelmesi gerekir. Aynı bilgi paketinin üretici, doğrulayıcı ve kullanıcıya dönük anlatıcı için farklı görünümleri gerekebilir. [K22, K06]

### 22.7. Memory Engineering ve Knowledge Engineering

Memory Engineering, zaman içinde neyin korunacağını, nasıl bulunacağını, nasıl güncelleneceğini ve ne zaman kullanılacağını ele alır. Knowledge Engineering ise anlam, kavram, iddia, ilişki, dayanak ve temsil sorunlarında yararlı bir çalışma çerçevesidir. Bu iki alan bir veritabanı kurmakla tamamlanmaz.

SOUL için kaynak, yorum, karar, yöntem ve deneyim ayrımları; zamansal geçerlilik; çelişki yönetimi; unutma ve erişim; öğrenilmiş yöntemin kullanım yolu birlikte tasarlanmalıdır. Kütüphanedeki kayıt sayısı veya arama isabeti, karar kalitesine katkının yerine geçmez. [K14, K22]

### 22.8. Graph Engineering

İş, karar, kaynak, aktör, çıktı ve yetki ilişkileri grafik yapılarla temsil edilebilir. Burada tasarlanacak şey yalnız düğüm ve kenar depolamak değildir. İlişkilerin anlamı, yönü, kapsamı, sürümü, türetilmiş olup olmadığı ve hangi hesaplamayı etkilediği önemlidir.

Grafik temsil, grafik veritabanı zorunluluğu değildir. İlişkiler ilişkisel tablolarla veya başka yapılarda da yönetilebilir. Ayrıca bir kenarın bulunması, içerdiği nedensel veya epistemik ilişkinin doğru olduğunu garanti etmez. Grafik, doğru bilgi ve iyi muhakemenin yerine değil, onları işletmek için kullanılmalıdır. [K15, K22]

### 22.9. Tool Engineering, API Design ve Agent–Computer Interface

Ajanın araçlarla kurduğu arayüzün anlamı açık olmalıdır. İşlem hangi nesneyi değiştiriyor, hangi yetkiyi gerektiriyor, başarısızlık ne anlama geliyor, sonuç nereden okunuyor, tekrar çağrı güvenli mi? Araç açıklamaları ve şemaları, modelin doğru eylemi seçmesine yardımcı olmalı; belirsiz veya çok geniş yüzeyler hata riskini artırmamalıdır.

**Typed commands**, açık giriş–çıkış sözleşmeleri, doğrulanmış nesne kimlikleri ve anlamlı hata sınıfları bu alanda değerlendirilebilir. Şemanın geçmesi, eylemin yetkili veya sonucunun doğru olduğu anlamına gelmez. Şema yalnız bir sınama katmanıdır. [K08, K16]

### 22.10. Workflow Engineering, Orchestration ve Durable Execution

Bu alanlar işlerin etkinleşmesini, beklemesini, tamamlanmasını ve gerektiğinde yeniden yürütülmesini düzenler. **BPMN**, **CMMN** ve **DMN** sırasıyla süreç, vaka ve karar mantığını ayrı biçimlerde ele almak için karşılaştırılabilecek yaklaşımlardır. Hepsinin aynı projede zorunlu olması gerekmez. [K21]

SOUL'un keşif ağıyla birlikte, bazı tekrar eden alt işler daha belirli akışlarla işletilebilir. Örneğin izin kontrolü, değerlendirme koşusu ve yayın doğrulaması gibi yollar açık sözleşmeler taşıyabilir. Ancak bir iş akışı motorunun bulunması, işe dair muhakeme boşluklarını kendiliğinden kapatmaz.

### 22.11. Distributed Systems Engineering ve Transactional State

Birden fazla aktör ve hizmet devreye girdiğinde eşzamanlılık, geç gelen yanıt, tekrarlı işlem, kısmi başarı ve yeniden başlatma sorunları ortaya çıkar. **Optimistic Concurrency Control**, **Compare-and-Swap**, transaction, lease, heartbeat ve fencing gibi yaklaşımlar belirli yanlış güncellemeleri önlemek için değerlendirilebilir. [K04, K15]

**Transactional Outbox**, **idempotency keys**, **event journal**, gerektiğinde **Event Sourcing** ve **CQRS** gibi kalıplar da adaydır. Ancak her projede hepsini kurmak gerekmez. Olay geçmişini saklamak ile güncel iş anlamını doğru hesaplamak farklıdır. Bir veritabanı izolasyon düzeyi de LLM'nin kararının doğruluğunu garanti etmez; hangi eşzamanlı değişikliklere karşı hangi davranışı sağladığı kendi kapsamıyla anlaşılmalıdır. [D03, D07]

### 22.12. Domain-Driven Design ve Ports and Adapters

**Domain-Driven Design — DDD** yönelimi, iş, karar, kanıt, yetki ve çalıştırma gibi alan kavramlarının sağlayıcıya özgü nesneler altında kaybolmamasına yardımcı bir tasarım adayıdır. SOUL işi, belirli bir ürünün session kimliğiyle eş anlamlı hale getirilmemelidir.

**Hexagonal Architecture / Ports and Adapters**, uygulama anlamını kullanıcı arayüzü, veri deposu ve dış hizmetlere ait teknik ayrıntılardan ayırmaya çalışır. Cockburn'ün özgün açıklamasındaki bu ayrım, SOUL'un farklı sağlayıcılara taşınabilirliğini tasarlamak için yararlıdır. Fakat arayüz tanımlamak, farklı sağlayıcılarda eşdeğer davranışın gösterildiği anlamına gelmez; gerçek bağlama ve yeterlik sınamaları gerekir. [D12]

### 22.13. Security Engineering ve Policy-as-Code

Yetki, kimlik, erişim kapsamı, kaynak güveni ve önemli dış etkiler mühendislik konusu olmalıdır. **Least Privilege**, **Capability-Based Security**, **separation of duties**, uygun yerde **RBAC/ABAC** ve **Policy-as-Code** bu ihtiyaçlar için değerlendirilebilecek yaklaşım aileleridir.

Bir politikanın kod olarak yazılması da tek başına kapsamlı koruma demek değildir. Politikanın gerçek etki yolunda uygulanması, başka yollarla aşılmaması ve güncel yetkiyle bağlı olması gerekir. Daha çok insan onayı istemek de her zaman daha iyi güvenlik veya daha iyi otonomi değildir; onay, gerçekten insanın kararına ait eşiklerde kullanılmalıdır. [K09, K19, D04]

### 22.14. Verification and Validation, Eval-Driven Development

**Verification**, tanımlanan gereksinimlerin karşılanıp karşılanmadığını; **validation**, sistemin amaçlanan kullanımda ihtiyacı karşılayıp karşılamadığını ele alır. NASA'nın ürün gerçekleştirme açıklaması bu farkı açıkça korur. SOUL için kodun doğru çalışmasıyla doğru çalışma sisteminin kurulması aynı soru değildir. [D08]

**Eval-Driven Development**, beklenen ajan davranışını geliştirme sürecinin başından itibaren değerlendirilebilir hale getirmek için kullanılabilir. **TDD**, entegrasyon sınamaları, **property-based testing**, **metamorphic testing**, **mutation testing** ve **fault injection** farklı hata sınıflarını araştırmak için aday yöntemlerdir. Hypothesis'in açıklaması, özellik tabanlı testlerin tekil örneklerin yanında geniş girdi sınıflarını ve dönüşüm özelliklerini sınayabileceğini gösterir. Hiçbiri tek başına bütünsel düşünme kalitesinin ölçüsü değildir. [D09, D13]

### 22.15. Formal Methods ve Model Checking

Kritik durum geçişleri için **state-machine modeling**, **invariant checking**, **model checking** ve gerektiğinde **TLA+** gibi biçimsel yöntemler değerlendirilebilir. Örneğin eski bir sahipliğin güncel durumu değiştirip değiştiremeyeceği veya belirli koşullarda sistemin kilitlenip kilitlenmeyeceği, sınırlandırılmış bir model üzerinde incelenebilir. [D14]

Buradaki sınır açıktır: Biçimsel model, tanımlanmış özellikleri ve varsayımları altında kanıt veya karşı örnek üretir. Doğru roman yazmayı, gerçek ihtiyaçların tamamını keşfetmeyi veya araştırma sentezinin bütün anlamını otomatik doğrulamaz. Modelin gerçek sisteme uygunluğu ayrıca gerekçelendirilmelidir.

### 22.16. Observability Engineering ve Site Reliability Engineering

**Observability**, **distributed tracing**, ölçümler, olay kayıtları ve işletim hedefleri, sistemin ne yaptığını ve neden ilerleyemediğini görünür kılmak için gereklidir. OpenTelemetry, iz, ölçüm ve log gibi sinyallerin toplanması ve ilişkilendirilmesi için kullanılabilecek bir çerçevedir. Bu, SOUL için zorunlu ürün seçimi değil, ilgili bir uygulama seçeneğidir. [D10]

SOUL'a özgü gözlenebilirlik, teknik gecikme ve hata sayısıyla sınırlanmamalıdır. İşin neden seçildiği, hangi kaynağın kararı taşıdığı, hangi itirazın açık olduğu, hangi dış etkinin belirsiz kaldığı ve kullanıcının nerede kurtarma emeği harcadığı da izlenebilmelidir. Gizli iç muhakemenin dökümü yerine; karar gerekçeleri, gözlemler, araç sonuçları, sürümler ve değerlendirmelerden oluşan denetlenebilir bir çalışma izi yeterli ve daha uygun bir hedef olmalıdır.

### 22.17. Configuration, Release ve Learning Engineering

Rol talimatı, ortak protokol, yöntem paketi, araç sürümü ve model bağlaması da ürün kodu kadar davranışı değiştirebilir. Bunların sürümü, dağıtımı, gerçek etkinleşmesi ve geri alınması yönetilmelidir. Bir paket hazırlanmış olması, gerçek aktörün o paketi kullandığını göstermez. [K16, K17]

Bu alanda yapılandırma yönetimi, yeniden üretilebilir paketler, kaynak ve çıktı kimliği, uyumluluk sınamaları, kontrollü dağıtım ve regresyon testleri kullanılabilir. Öğrenme mühendisliği diye adlandırdığım sorumluluk ise deneyimden davranış değişikliğine giden yolu tasarlamaktır. Terimin adı değil, değişikliğin gerçek davranış ve sonuç üzerindeki etkisinin gösterilmesi önemlidir.

## 23. RAG, Knowledge Graph, Long Context, CAG ve Fine-Tuning nasıl konumlanmalı?

Studies'deki önemli düzeltmelerden biri, bu mekanizmaları context, memory ve harness ile aynı düzeyde seçenekler gibi sunmamaktır. Mühendislik sorumluluğu önce gelir; mekanizma o sorumluluğu karşılamak için seçilir. “RAG kullanacak mıyız?” sorusundan önce, hangi bilgiye hangi anda ve hangi güven düzeyinde erişilmesi gerektiği anlaşılmalıdır. [K22]

**Retrieval-Augmented Generation — RAG**, dış kanıt veya bilgiyi getirme ve modelin kullanımına sunma yollarından biridir. Vektör veritabanıyla eş anlamlı değildir. Bilginin nasıl yazılacağını, çelişki halinde ne yapılacağını, ne zaman eski sayılacağını veya kimlerin yazmaya yetkili olduğunu tek başına çözmez.

**Knowledge Graph**, ilişkileri açık biçimde temsil etmek için yararlı olabilir. İş–karar–kaynak bağı, zamansal ilişki veya değişiklik etkisi gibi sorularda değer sağlayabilir. Ancak otomatik çıkarılmış bir kenar, doğrulanmış gerçek gibi sunulmamalıdır. Grafik sorgusunun başarılı olması da sorulan iş için yeterli bilginin döndüğü anlamına gelmez.

**Long Context**, daha büyük bir çalışma paketini birlikte görebilmeyi sağlar. Fakat bağlam kapasitesi, o bağlamın etkili kullanıldığına veya farklı oturumlar arasında korunduğuna eşit değildir. Bazı işlerde bütün paketin görünürlüğü önemli olabilir; bazılarında seçici erişim daha uygun olabilir. Seçim gerçek iş ve değerlendirme üzerinden yapılmalıdır.

**Cache-Augmented Generation — CAG**, kararlı bağlamın tekrar kullanım maliyetini azaltma gibi amaçlarla değerlendirilebilir. Hesaplama önbelleği, semantik ve yetkili hafıza ile aynı şey değildir. Kaynak, model, izin veya sürüm değiştiğinde önbelleğin geçerliliği ayrıca düşünülmelidir.

**Fine-Tuning**, model davranışını veya belirli yeteneklerini uyarlamak için ayrı bir mekanizma ailesidir. Güncel proje gerçeklerini, kaynak otoritesini veya kolayca geri çekilmesi gereken kararları model ağırlıklarında yönetmenin yerine otomatik konmamalıdır. Rol, bağlam ve araç tasarımının yeterli olup olmadığı incelenmeden fine-tuning'e geçmek de gereksiz olabilir.

Bu mekanizmaların birlikte kullanılması mümkündür. Ancak bileşim, daha çok teknoloji eklemek olduğu için değil, belirli bir bilgi ve çalışma ihtiyacını daha iyi karşıladığı gösterildiği için seçilmelidir. SOUL'un genel amaçlılığı, tek bir evrensel yığın yerine koşula göre uygun konfigürasyonu seçme ve değerlendirme kapasitesinde aranmalıdır.

## 24. Teknik mimari nasıl düşünülmeli?

Bu metnin önerisi, ürün anlamı ile çalıştırma ayrıntılarını ayıran; kalıcı iş ve bilgi durumunu koruyan; gerçek etkileri yetkili yollarla gerçekleştiren; aktör katkılarını açık sözleşmelerle birleştiren bir mimari yönelimdir. Bunun baştan büyük bir mikroservis ağı olması gerekmez. Bir modüler uygulama, gerekli sınırlar ve gerçek kontrollerle yeterli bir başlangıç olabilir. Fiziksel dağıtım, ihtiyaç ve yeterlik kanıtı gerektirir.

Mantıksal olarak amaç ve iş alanı, bilgi ve kanıt alanı, aktör konfigürasyonu, çalıştırma ve koordinasyon, yetki ve etki yönetimi, değerlendirme ve öğrenme sorumlulukları ayrılabilir. Bu ayrım altı zorunlu sunucu, altı veritabanı veya altı kalıcı ajan kararı değildir. Sorumlulukların anlaşılır olması ile fiziksel bileşen sayısı farklı tasarım eksenleridir.

Güncel P5 kaydı, typed application/control plane, PostgreSQL üzerinde canlı durum, özel içerik deposu, ayrı korunan yayın yolu, geri yüklenen veritabanından bağımsız yetki fence'i ve Codex harness adapter'ı içeren bir referans yönelim tarif ediyor. Bunu mevcut bir teknik şartname olarak dikkate almak gerekir; tüm ayrıntıları kabul edilmiş, kurulmuş veya hedef ortamda doğrulanmış mimari gibi sunmak yanlış olur. [K08]

Codex'in DevOS için seçilmiş olması ile SOUL'un sağlayıcıdan bağımsız çalışma hedefi de ayrı kalmalıdır. Taşınabilirlik, yalnız sağlayıcı adını bir ayara taşımak değildir. Oturum ömrü, araç erişimi, alt ajan davranışı, bilgi izolasyonu, kimlik, izin, kesinti ve geri dönüş sözleşmeleri farklı sağlayıcılarda sınanmalıdır. Ortak arayüz bu çalışmayı kolaylaştırabilir; yerine geçmez.

Veri deposu seçimi de aynı disiplinle yapılmalıdır. Dosya tabanlı bir düzen belirli koşullarda yeterli olabilir; eşzamanlı çalışma, transaction ve ilişkisel sorgu ihtiyaçları başka bir altyapıyı gerektirebilir. Bir ürünün araştırma listesinde bulunması onu seçilmiş yapmaz. P5 kaydında da Supabase'in seçilmediği açıkça belirtilmiştir. [K08]

Sonuç olarak teknik mimari, yukarıdaki entelektüel ve operasyonel sorumlulukların taşıyıcısıdır. Mimariyi önce seçip SOUL'un amacını ona uydurmak yerine, hangi sözleşmenin hangi mekanizma ile karşılandığı gösterilmelidir. Bir bileşen çıkarıldığında hangi somut yetenek kayboluyor sorusuna cevap verilemiyorsa, o bileşenin gerekliliği yeniden değerlendirilmelidir.

# V. Yeterlik, örnekler ve açık araştırma gündemi

## 25. SOUL ve DevOS gerçekten nasıl değerlendirilmeli?

Değerlendirme, metindeki iyi özelliklerin var sayılması değil, bu özelliklerin hangi koşullarda gösterildiğinin araştırılmasıdır. “İyi düşünüyor”, “öğreniyor” veya “otonom” gibi geniş sıfatlar tek bir test sonucuyla kazanılmamalıdır. Test nesnesi; model, rol, ortak protokol, bağlam, araçlar, erişim, ortam ve kullanılan yöntemlerin birlikte oluşturduğu gerçek konfigürasyon olmalıdır. [K05, K12]

Anthropic'in ajan değerlendirmesi açıklaması, model ile harness'in birlikte değerlendirilmesini ve ajanın söylediği sonuç ile ortamda gerçekleşen sonucun ayrılmasını vurgular. Kod, model ve insan değerlendirmelerinin farklı yönleri sınayabildiğini; değerlendirme düzeninin de hatalı olabileceğini belirtir. Bu, DevOS için hazır bir ölçüt seti değil, değerlendirme tasarımında yararlı bir dış karşılaştırmadır. [D09]

### 25.1. Yapısal doğruluk ile davranışsal yeterlik

Şema kontrolü, paket bütünlüğü, doğru dosya yolu, geçerli sürüm bağı ve erişim kontrolü önemlidir. Bunlar yanlış veya eksik yapılandırmayı yakalayabilir. Fakat ajanın doğru işi keşfettiğini, alanı iyi anladığını veya uygun karar verdiğini göstermez.

Davranışsal değerlendirme ise aktörü gerçekçi bir görevle karşılaştırmalıdır. Söylenmemiş ama amaç için gerekli bir koşulu fark ediyor mu? İlgili araştırmaya kendiliğinden gidiyor mu? Kaynak çelişkisini ayırabiliyor mu? Gereksiz bir yöntemden vazgeçebiliyor mu? Yanlış bir varsayımın kararı taşıdığını fark ediyor mu? Sonuçta yaptığı düzeltme, üst işi uygun biçimde değiştiriyor mu? [K04, K12]

Bu soruları sınamak için üreticinin kendi hazırladığı örnek yeterli olmayabilir. Örneğin içinde açıkça “önce önkoşulları keşfet” yazan bir test, ajanın ipucusuz ihtiyaç keşfini sınırlı ölçüde sınar. Bununla birlikte test, görevde veya ortamda hiçbir dayanağı olmayan gizli bir beklentiyi keşfetmedi diye ajanı haksız yere başarısız saymamalıdır. Gerekli ihtiyaç ile değerlendiricinin kişisel çözüm tercihi ayrılmalıdır.

### 25.2. Karşıt yöndeki hatalar birlikte ölçülmeli

Yalnız eksik önkoşul bulmayı ödüllendirmek, gereksiz işler üreten bir sistemi teşvik edebilir. Yalnız az araç çağrısını ödüllendirmek, gerekli araştırmadan kaçınmaya yol açabilir. Yalnız hızlı tamamlamayı ödüllendirmek, erken kapanışı teşvik edebilir. Yalnız hiçbir hata yapmamayı ödüllendirmek de sistemin hiçbir iş yapmamasına neden olabilir.

Bu nedenle eksik ihtiyaç kadar sahte ihtiyaç, erken kapanış kadar gereksiz erteleme, yetersiz araştırma kadar amaçsız araştırma, yetkisiz hareket kadar gerekçesiz insan bağımlılığı da incelenmelidir. Ölçütler birlikte okunmalıdır; tek bir başarı yüzdesi bu gerilimleri gizleyebilir. RPD değerlendirme planının değerli yönlerinden biri, bu çift taraflı hata sınıflarını görünür tutmasıdır. [K04]

### 25.3. Bağımsızlık ve yanlış sonucu yakalama kapasitesi

Bir doğrulayıcının adı veya salt okunur olması, epistemik bağımsızlığı garanti etmez. Aynı kaynağın iki özeti bağımsız kanıt değildir. Aynı modelin üretici anlatısına yaslanan incelemesi, üreticinin hatasını paylaşabilir. Farklı model kullanmak da her ortak hata nedenini ortadan kaldırmaz. [K05]

Değerlendirme mekanizması bilinen yanlış durumlarla karşılaştırılmalıdır. Yanlış hedef sürümü, eksik kaynak, bozuk sonuç, başarısız dış etki veya hatalı kabul koşulu bilerek verildiğinde sistem bunları fark ediyor mu? Bilinen kötü örnekleri geçiren bir ölçütün, iyi örnekleri de geçirmesi güven sağlamaz.

Üstelik kriterin kendisi korunmalıdır. Test edilen sistem, başarısızlığından sonra başarı ölçütünü kendisine uyacak biçimde sessizce değiştirememelidir. Kriter hatalıysa değiştirilebilir; ama bu, ürünün gelişmesinden ayrı bir değerlendirme düzeltmesi olarak kaydedilmelidir.

### 25.4. Gerçek bileşim sınamaları

Tek tek bileşenlerin sınanması gerekli fakat yetersizdir. Araştırma talebi doğru aktöre gidiyor, ancak yanıt üst işe dönmüyorsa işbirliği eksiktir. Veritabanı kurtarılıyor, ancak eski aktör hâlâ dış yayın yapabiliyorsa recovery eksiktir. Yeni rol metni dağıtılıyor, ancak açık oturum eski metni kullanıyorsa değişiklik etkinleşmemiştir.

Bu nedenle bütün geçişi izleyen sınamalar gerekir: ihtiyaç keşfi, katkı talebi, gerçek erişim, üretim, değerlendirme, güncel duruma alma, dış etki, geri okuma ve devam. Her senaryo bütün katmanları çalıştırmak zorunda değildir; fakat sistemin önemli bileşim iddiaları yalnız yerel testlerden türetilmemelidir. [K16, K17, K18]

### 25.5. Sonuç kalitesi ve gerçek kullanıcı yükü

SOUL'un ürettiği sonuç, hedef alanda değerlendirilmelidir. Soru bankasında cevap doğruluğu kadar konu ve beceri dağılımı, belirsiz soru ifadesi ve bütünün uygunluğu önemlidir. Romanda olay tutarlılığı kadar anlatı etkisi ve okuma deneyimi önemlidir. Yazılımda testlerin geçmesi kadar gerçek kullanım akışının çalışması ve amaçlanan değerin oluşması önemlidir.

Bunların yanında kullanıcının harcadığı gizli emek ölçülmelidir. Kullanıcı kaç kez unutulan amacı hatırlattı? Hangi kaynakların var olduğunu söyledi? Ajanlar arasında kaç mesaj taşıdı? Yanlış tamamlanma iddiasını kaç kez fark etti? Erişim veya devam sorunlarını ne kadar kendisi teşhis etti? Bu emek dışarıda bırakılırsa, sistem olduğundan daha otonom ve daha ucuz görünür. [K13, K24]

Teknik ve bilişsel ölçümler birlikte tutulmalıdır: doğru sonuç, kritik hata, gereksiz iş, gecikme, kaynak tüketimi, tekrar çalışma, kullanıcının kurtarma müdahalesi, kesinti sonrası geri kazanım ve farklı koşullara aktarım. Ölçüm ayrıntısı kullanımın riskine uygun seçilmeli; bütün işlere aynı puan cetveli dayatılmamalıdır.

### 25.6. Karşılaştırma ve nedensel iddia

“Bu mekanizma performansı artırdı” demek için, yalnız mekanizma eklendikten sonra iyi bir sonuç görmek yeterli değildir. Model, araç, kaynak erişimi, görev zorluğu ve bütçe de değişmiş olabilir. Uygun karşılaştırmada bunlar mümkün olduğunca eşleştirilmelidir. Daha basit bir planlama düzeni veya aynı kaynaklara sahip daha az katmanlı bir çalışma, karşılaştırma adayı olabilir.

Tek bir koşudan evrensel sonuç çıkarılmamalıdır. Birden fazla deneme, farklı görevler, başka aktör örnekleri ve değişen koşullar gerekebilir. Bütünlük sınamaları ve mekanizma çıkarma denemeleri, hangi parçanın gerçekten katkı verdiğini anlamaya yardımcı olabilir. Buna rağmen kapsam dışındaki işlere genelleme sınırı açık tutulmalıdır.

Buradaki hedef, araştırma birikimimizin başka örneklerden “kesinlikle daha iyi” olduğunu ilan etmek değildir. Hedef, daha güçlü bir yapı kurma iddiasını anlamlı karşılaştırmalarla sınayabilecek düzeye getirmektir. Araştırma zenginliği önemli bir avantaj adayıdır; ölçülmüş üstünlüğün yerine geçmez.

## 26. Üç örnekte SOUL nasıl çalışmalı?

Aşağıdaki üç örnek birer uygulama planı değil, tasarlanan sistemin hangi ayrımları koruması gerektiğini gösteren kurgusal yürüyüşlerdir. Bunları çalıştırılmış deney veya kanıt olarak sunmuyorum.

### 26.1. Matematik soru bankası

Kullanıcı belirli bir sınıf düzeyi için soru bankası istiyor. Zayıf yaklaşım, konu başlıkları açıp çok sayıda soru üretmektir. Daha güçlü yaklaşım, soru bankasının hangi kullanım için istendiğini, hedef kazanımları, kapsam ve zorluk beklentisini, çıktı biçimini ve kabul ölçütlerini yeterince anlamaktır. Eksik değer tercihleri kullanıcıya sorulur; teknik ve pedagojik araştırma ihtiyacını sistem keşfeder.

SOUL yalnız ürünün gereksinimlerini değil, üretim sisteminin ihtiyaçlarını da çıkarır. Hangi alan bilgisi gerekiyor? Soruları kim üretecek, kim bağımsız çözecek, dil ve pedagojik uygunluk nasıl değerlendirilecek? Kaynaklara hangi aktör erişecek? Çelişen bir kazanım eşlemesi nasıl çözülecek? Bir sorunun değiştirilmesi cevap anahtarını ve kitabın dağılımını nasıl etkileyecek? Foundation tartışmasındaki temel düzeltme bu ikinci katmandır. [K10]

İşler küçük parçalara ayrılabilir; fakat bütün kitap gözetimi kaybolmaz. Her sorunun doğru olması, kitabın dengeli veya hedefe uygun olduğu anlamına gelmez. Bir soru örneğinin çok iyi çıkması da bütün üretim sisteminin yeterli olduğunu kanıtlamaz. SOUL, örnek yeterliği ile seri üretim ve bütün ürün yeterliğini ayrı değerlendirmelidir.

Yeni bir konu eklendiğinde yalnız yeni soru yazarı çağrılmaz. Kaynak, çözüm yöntemi, değerlendirme kapsamı, kayıt ilişkileri ve teslim edilen bütünün sürümü de güncellenir. Genişleme böylece yalnız kadro büyümesi değil, çalışma ilişkilerinin genişlemesi olur.

### 26.2. Roman

Kullanıcının bir tema, birkaç karakter ve yön duygusu verdiğini düşünelim. SOUL hemen bölümleri paylaştırmak yerine anlatı amacını, kapsamı, tonu ve kullanıcının yaratıcı tercih sınırlarını anlamaya çalışır. Bunun tamamı tek seferde dondurulmak zorunda değildir; roman geliştikçe bazı seçimler değişebilir.

Karakterin dünyadaki gerçek durumu, karakterin bildiği şey, anlatıcının sunduğu şey, yazarın tasarladığı şey ve metinde fiilen gerçekleşen şey ayrılmalıdır. Planlanan sahne yazılmış sahne değildir. Tek tek başarılı bölümler, güçlü bir bütün değildir. Son sürüm klasöründeki dosyaların yan yana bulunması da tutarlı bir teslim edilen eser oluşturmaz. EXP-004'ün tasarım tabanı, teslim tabanı ve bütün ürün birleşimi ayrımları bu konuda önemlidir. [K06]

Bu nedenle belirli bir değerlendirmeye sunulan bütünün kimliği korunmalıdır. Hangi bölümlerin hangi sürümleri birlikte okundu? İnceleyici metni hangi sırada gördü? Önceden hangi olayları biliyordu? Hangi eleştiri olgusal tutarsızlığa, hangisi anlatı tercihine ilişkin? Bu sorular, yaratıcı işi mekanik bir doğru–yanlış testine indirgemeden kaliteyi tartışmayı sağlar.

İyi bir editör rolü her sapmayı hata saymamalıdır. Yazım sırasında planı aşan daha iyi bir çözüm doğabilir. O zaman yalnız metin plana uydurulmaz; planın veya ilgili kararın değişmesi de değerlendirilebilir. Ancak anlamlı değişiklik, bağlı sahneler, karakter ilişkileri ve okuma deneyimi üzerinde etkisiyle birlikte ele alınmalıdır.

### 26.3. Küçük bir yazılım veya basit bir form

Küçük bir işte SOUL'un dev bir ekip kurması gerekmeyebilir. Fakat küçük iş, ihtiyaç ve kabul ölçütünün düşünülmemesi demek değildir. Verinin kaybolmaması, kullanıcı akışının anlaşılması, gereksiz bilginin istenmemesi veya gerçek teslim biçiminin belirlenmesi gibi koşullar hâlâ önemli olabilir.

SOUL mevcut yetenekleriyle yeterli işi yapabiliyorsa daha küçük bir konfigürasyon seçebilir. Bir üretici ve kapsamına uygun bir değerlendirme yolu yeterli olabilir; bazı mekanik kontroller otomatik çalışabilir. Yeni altyapı, ek ajan veya karmaşık bellek sistemi ancak ihtiyaç gerektiriyorsa eklenir.

Buradaki profesyonellik, küçük bir forma büyük kurum töreni uygulamak değildir. Hangi yükümlülüklerin gerekli olduğunu anlayıp hiçbirini iş küçük diye görünmez kılmamaktır. Aynı ilke DevOS'un kendi kuruluşu için de geçerlidir: yüksek kalite ile az bileşen çelişmez; yeterliği gösterilmemiş bir küçültmeyle yüksek kalite çelişir. [K01]

## 27. Geçmiş örneklerden ne korunmalı, ne taşınmamalı?

### 27.1. Keel: disiplinli işletim tek başına doğru iş değildir

Keel kayıtlarında rol sözleşmeleri, kurulum aşamaları, denetim kapıları, durum takibi, mekanik kontroller ve dış inceleme çabası önemli bir birikim oluşturuyor. Bunlar plansız bir sohbetten daha güçlü bir çalışma düzeni kurma çabasının gerçek parçalarıdır. Ancak tarihsel değerlendirmeler, amaç seçimi, derslerin ihtiyaç anında kullanımı ve kullanıcıya kalan gizli koordinasyon yükünün ayrıca ele alınması gerektiğini gösteriyor. [K25]

Buradan çıkarılacak ders “bütün kontrol mekanizmaları gereksizdi” değildir. Doğru ders, kontrollerin hangi sorunu çözdüğünü ve hangi sorunu çözmediğini ayırmaktır. Mekanik olarak geçerli bir çalışma, epistemik olarak zayıf olabilir. İyi bir devir formatı, sonraki aktörün doğru problemi kurmasını garanti etmez. Bir hasım inceleme rolü, önceden belirlenmiş merceklerin dışındaki temel eksikliği mutlaka bulmaz.

Keel'den SOUL'a taşınabilecek şey belirli klasör ve unvanların zorunluluğu değil; niyetin, rolün, durumun ve kontrollerin açıklaştırılmasıyla elde edilen derslerdir. Taşınmaması gereken şey, çok sayıda kontrolün otomatik olarak yüksek düşünme kalitesini gösterdiği varsayımıdır.

### 27.2. Oyun2: yerel kapanışlarla gerçek çalışma durumu ayrılabilir

Oyun2'nin doğrudan okunan vizyon, kutu, pano ve bilinmeyenler kayıtları, görevlerin yerel tamamlanmasıyla insanın gördüğü genel durumun her zaman aynı noktayı göstermeyebildiğini ortaya koyuyor. Ayrıca araştırma rolünün varlığıyla gerçek araç ve erişim yolunun kullanılabilirliği arasında boşluk bulunabileceği kayıtlarda görünür. [K26]

Bu örneğin SOUL açısından önemi, tek tek rollere bakmakla yetinmemektir. Rollerin birlikte nasıl ilerlediği, koordinatörün hangi işlemi ne zaman yapabildiği ve durumun kullanıcıya nasıl sunulduğu da sınanmalıdır. Bir adımın bağımlılığını kaldırmak, bütün geçiş mantığının doğru hale geldiğini tek başına göstermez.

Oyun2'nin ürün hedefi, alan bilgisi ve kullanıcı tercihleri kendi bağlamına aittir; SOUL'a doğrudan ürün gereksinimi olarak taşınmamalıdır. Yeniden kullanılacak olan, farklı bir işte de ortaya çıkabilecek erişim, yerel–bütünsel durum, rol bağlamı ve koordinasyon ayrımlarıdır.

### 27.3. ECC: dağıtım, etkinleşme ve gerçek etki

ECC araştırmasının önemli katkısı, yeteneklerin yalnız depoda veya katalogda bulunmasıyla yetinmemesidir. Kurulum biçimi, host, yapılandırma, seçilen çalışma yolu, gerçek aktör ve tüketici arasındaki bağlantılar incelenir. Kayıt, onay, süreç sonu, görev yeterliği, yayın ve kullanım farklı iddialar olarak korunur. [K16]

SOUL açısından özellikle yöntem ve kontrol dağıtımı önemlidir. Bir skill'in paketlenmesi, aktörün onu seçtiğini göstermez. Seçilmesi, bütün gerekli içeriğin bağlama girdiğini göstermez. Kullanılması da yararlı olduğunu göstermez. Bu zincirde hangi halkaların gerçekten gösterildiği açıklanmalıdır.

ECC'nin incelenmiş bütün mekanizmalarını DevOS'a eklemek doğru sonuç değildir. Araştırma, hangi mekanizmanın hangi bağlamda katkı verebileceğini ve hangi sınırı açık bıraktığını anlamak için kullanılmalıdır. Bir skor kartının veya doğrulama aracının bulunması, SOUL'un hedef kalitesini onun ölçtüğü anlamına gelmez.

### 27.4. Hermes: işin, oturumun ve hafızanın ayrı yaşamları

Hermes araştırması; task, run, claim, session, turn ve zamanlanmış yürütme gibi nesnelerin farklı ömürler taşıdığını ayrıntılandırıyor. Kalıcı iş kaydı, devam kararı ve gerçek tetikleyici birbirinin yerine geçmiyor. Aynı şekilde beceri kütüphanesinin listelenmesi, yüklenmesi, güncellenmesi ve kullanılmasının farklı koşulları var. [K17]

SOUL için bu bulgular, uzun çalışma ve öğrenme iddialarını somutlaştırır. Bir oturumun kapanması işi kapatmayabilir. Bir zamanlayıcının tetiklenmesi sonucun gerçekleştiğini göstermez. Bir değişiklik diske yazılmış ama açık aktöre yansımamış olabilir. Bir mesaj alınmış ama anlamlı biçimde işlenmemiş olabilir.

Hermes araştırmasının kendisinin de açık sınırı korunmalıdır: güncel kayıtlarda çalışma kısmi ve geçici sentezlerle sürüyor; değerlendirme ve görev kalitesi gibi bazı sorular açık. Bu araştırmayı tamamlanmış bir bütün ürün yeterlik belgesi gibi kullanmak, araştırmanın kendi disiplinine aykırı olur.

### 27.5. Diğer Studies örnekleri: mekanizma kütüphanesi, alışveriş listesi değil

Beads, hazır iş ve sahiplik gibi çalışma koordinasyonu ayrımlarını; Flowable, yürütme durumunu gerçekten ilerleten süreç ve vaka motorlarını; OpenSpec, değişiklik niyeti ile güncel şartnameyi ve yaşayan planlama çıktılarını ayrı tutmayı somutlaştırır. Aynı “hazır” veya “tamamlandı” kelimesi bu sistemlerde farklı iddiaları taşıyabilir. [K15, K20, K21]

Superpowers araştırması, yöntemlerin rol ve skill sözleşmeleri, araçlar ve host davranışı üzerinden nasıl birleştiğini gösterir. gstack araştırması da iş, kanıt, yetki, gerçek etki ve geri okuma ilişkilerinin farklı alt sistemlere dağıldığı bir örnek sunar. Bunlar yalnız prompt koleksiyonları diye küçümsenmemeli; tam ve evrensel otonom çalışma motorları diye de genellenmemelidir. [K27, K28]

Studies birikiminin DevOS'a katkısı, “şu araçların hepsini kullanalım” sonucu değildir. Aynı ihtiyacı karşılayan alternatifleri, farklı hata yüzeylerini ve bileşim sorunlarını incelemeye yarayan bir araştırma kütüphanesidir. Henüz yalnız araştırılacaklar listesine alınmış bir repo da incelenmiş örnek gibi anlatılmamalıdır.

### 27.6. Exploration kayıtları: kavramların çalışma davranışına inmesi

EXP-001, talebin arkasındaki işin keşfini, profesyonel standardı ve yaşayan planı; EXP-002, ortak entelektüel tabanı ve rol amaçlarını; EXP-003, ek hafızanın kullanım ve değişim yaşamını öne çıkarır. EXP-004, genişleyen SOUL'u uzun iş ve bütün ürün üzerinden zorlar. EXP-005, ihtiyacı keşfetmeden çözüme atlama ve kullanıcıya kalan çalışma yükü için ders niteliğindedir. EXP-006 ise SOUL'u geliştirecek gerçek ekibin iş, bilgi ve devam düzenini somutlaştırmaya yönelir. [K01, K02, K03, K13, K14, K18]

Bu kayıtlar tek bir doğrusal başarı öyküsü değildir. İptaller, düzeltmeler, geri çekilmiş iddialar ve açık kalmış sorular içerir. Değerleri de buradadır: yalnız varılan cümleleri değil, yanlış yöne gitmenin nasıl gerçekleştiğini ve hangi ayrımın sonradan gerekli bulunduğunu taşırlar. DevOS bu geçmişi ezberlenecek bir hikâye olarak değil, ihtiyaç anında kullanılacak çalışma bilgisi olarak değerlendirmelidir.

## 28. Bugün ne var, ne henüz gösterilmedi?

28 Eylül 2026 tarihli EXP-006 P5 kaydı, Codex için inşa ve kurulum rehberi ile kaynak paketinin hazır olduğunu, fakat gerçek inşanın başlamadığını söylüyor. Kayıtta 13 inşa aşaması, 18 rol profili, 6 ortak protokol, 7 yöntem/skill metni, 30 mantıksal veri ailesi, 33 uygulama komutu ve 67 hedef senaryosu tarif ediliyor. Bu sayılar paket kapsamıdır; çalışan ekibin veya doğrulanmış yeteneklerin sayısı değildir. [K08]

Aynı kayıt, 50 adlandırılmış yerel paket-aracı testinin geçtiğini bildiriyor. Buna karşılık 67 hedef senaryosunun tamamı NOT_RUN durumunda. Gerçek Codex bağlama, veritabanı erişim ve eşzamanlılık, korunan uzak yayın, yetki fence'i, restore, gerçek uzun ürün ve bilişsel yeterlik gibi hedef koşularının çalıştırılmadığı açıkça belirtiliyor. Bu çalışmada o testleri bağımsız olarak yeniden koşturmadım. [K08]

Dolayısıyla mevcut durumu “DevOS kuruldu” veya “ajanların düşünme kalitesi doğrulandı” diye anlatmak doğru değildir. Daha doğru ifade, önemli tasarım ve inşa hazırlıklarının bulunduğu, fakat işletim ve bilişsel yeterlik iddialarının gerçek hedefte gösterilmesi gerektiğidir. Paket doğrulaması ile hedef sistem doğrulaması ayrı tutulmalıdır.

P5'in tam ZIP, Markdown ve PDF tesliminin bütünü bu okuma sırasında açılmadı; ayrıntılı repo devir kaydı üzerinden mevcut konumu değerlendirdim. Bu yüzden burada P5'in bütün maddeleri hakkında tam uygunluk hükmü vermiyorum. Özellikle önceki eleştirilerde gündeme gelen rutin geçiş bağımlılığı gibi bir sorunun çözüldüğü, yalnız yeni bir rehberin hazır olmasından çıkarılamaz.

Ayrıca bazı eski kök girişlerin güncel EXP-006 durumundan geri kalması, yeni oturumların tarihsel yönleri güncel iş gibi almaması gerektiğini gösteriyor. Bu çalışma eski denemeleri yeniden başlatma veya current olmayan yapıları benimseme yetkisi kullanmıyor. SOUL'u geliştirmek için ilk gerçek ürün backlog'unu da seçmiyor.

## 29. Henüz çözülmemiş, fakat tasarımın dışında bırakılamayacak sorular

Bu bölüm bir eksik listesi çıkarıp çalışmayı durdurmak için değil, hangi konularda gerçek araştırma ve sınama gerektiğini açık tutmak için var. Soruların bazılarına iyi başlangıçlar bulunuyor; hiçbiri yalnız doğru adı vermekle çözülmüş sayılmamalı.

### 29.1. Sistem bilmediği ihtiyacı nasıl fark edecek?

RPD, keşfi sistematikleştirebilir; fakat mevcut kavram dünyasının dışındaki bir ihtiyacı fark etme problemi tamamen ortadan kalkmaz. Alan araştırması, farklı örnekler, karşıt açıklamalar, gerçek kullanım ve dış değerlendirme bu yüzden önemlidir. DevOS'un tek bir soru listesine kapanmaması gerekir.

Araştırılması gereken şey, hangi keşif merceklerinin hangi iş türlerinde yararlı olduğu ve ne zaman yeni bir merceğe ihtiyaç duyulduğudur. “Bütün önkoşulları bulduk” iddiası yerine, hangi kapsamda hangi eksikliklerin arandığını ve neyin açık kaldığını gösterebilen bir keşif yeterliği kurulmalıdır. Keşfin sona ermesi, belirsizliğin yok olması değil, mevcut karar için yeterli dayanağın oluşması anlamına gelebilir.

### 29.2. Başlangıç ekibinin entelektüel yeterliğini kim kuracak?

DevOS'un kendi yeterliğini geliştirmesi beklenebilir; fakat ilk çalışma biçiminin hiç dayanağı olmadan kendini doğrulaması dairesel olur. Başlangıçta kullanılacak ortak protokoller, bilinen iyi örnekler, gerçek kaynak erişimi ve sınırlandırılmış değerlendirme görevleri bir ilk dayanak oluşturabilir. Bu dayanağın hangi işler için yeterli olduğu açık olmalıdır.

Açık soru, başlangıç ekibinin hangi yeterlikleri kurulmadan görev alamayacağı ve hangi yeterlikleri çalışma sırasında kontrollü olarak geliştirebileceğidir. Bütün SOUL'u önceden istemek sonsuz hazırlık yaratır; hiçbir nitelik aramamak da aynı sorunları yeniden üretir. İki uç arasında, kapsamı açık ve sınanmış bir başlangıç seviyesi gerekir.

### 29.3. Ortak kör noktalar nasıl azaltılacak?

Daha fazla ajan, daha fazla bağımsız bilgi anlamına gelmez. Aynı model ailesi, benzer eğitim etkileri, ortak kaynak seçimi veya aynı yanlış başarı ölçütü sonuçları aynı yönde bozabilir. Farklı modeller bile aynı yüzeysel kaynaklara dayanabilir.

Bu nedenle bağımsızlık çok boyutlu tasarlanmalıdır: kaynak, yöntem, bilgi görünümü, amaç baskısı, ortam ve değerlendirme yolu. Hangi işte hangi bağımsızlığın maddi olarak gerekli olduğu ve maliyetinin nasıl karşılanacağı araştırılmalıdır. Bağımsızlık bir unvan veya üretici markası değil, belirli ortak hata yollarının azaltılmasıdır. [K05]

### 29.4. Yüksek standart ile iş yükü nasıl dengelenecek?

Her olasılığı araştıran, her çıktıyı çok sayıda ajana inceleten ve her hareketi büyük bir kayıt törenine dönüştüren sistem, kaliteli görünürken işe yararlılığını kaybedebilir. Bunun tersine yalnız hız için kritik koşulları atlamak da kabul edilemez.

DevOS, süreç maliyetini de bir tasarım değişkeni olarak izlemelidir. Hangi kontrol hangi riski azaltıyor? Aynı güven daha az koordinasyonla elde edilebilir mi? Yeni katman ürün işinden daha fazla zaman mı tüketiyor? Bir yöntem düşük riskli işlerde azaltılabilir mi? Bu sorular, “azla yetinmek” değil, gerekli emeği doğru yere yöneltmektir. [K24]

### 29.5. Yöntemler bir araya geldiğinde ne olacak?

Tek tek makul yöntemler birlikte çatışabilir. Bir yöntem sık sık kullanıcı onayı isterken başka biri rutin geçişlerde otonom devam bekleyebilir. Bir yöntem bütün bağlamı paylaşmayı önerirken bağımsız inceleme belirli bilgi izolasyonu gerektirebilir. Bir yöntem hızlı taslak üretimini, başka biri erken kilitlemeyi teşvik edebilir.

SOUL yalnız yöntem seçmeyi değil, yöntemlerin birlikte çalışabilirliğini de değerlendirmelidir. Hangi kuralın hangi bağlamda geçerli olduğu, çatışmanın kim tarafından çözüleceği ve bir bileşimin gerçekten sınanıp sınanmadığı açık kalmalıdır. Skill sayısı, yöntem bileşiminin olgunluğu değildir. [K06, K27]

### 29.6. Anlamsal değişiklik etkisi nasıl belirlenecek?

Bir metin değişikliğinin hangi kararı etkilediği her zaman dosya bağımlılığından çıkmaz. Küçük bir kelime değişikliği yetki kapsamını değiştirebilir; büyük bir biçimsel düzenleme anlamı değiştirmeyebilir. Bağımlılık grafiği, okunan sürümler ve alan sahibi değerlendirmesi birlikte kullanılabilir.

Buradaki açık denge, gereksiz yeniden doğrulama ile eski doğrulamayı yanlış kullanma arasındadır. Her değişiklikte bütün sistemi sınamak pahalıdır; yalnız açıkça kaydedilmiş kenarlara güvenmek eksik kalabilir. SOUL'un etki değerlendirmesi, kendi belirsizliğini de ifade edebilmelidir.

### 29.7. Yaratıcı veya açık uçlu işlerde iyi sonuç nasıl tanınacak?

Roman, araştırma veya strateji gibi işlerde tek bir doğru cevap bulunmayabilir. Bu, değerlendirme yapılamayacağı anlamına gelmez; fakat ölçütün niteliğini değiştirir. Tutarlılık, amaca uygunluk, özgünlük, açıklık, alan bilgisi ve kullanıcı tercihi farklı değerlendirme boyutları olabilir.

Sistem, ölçebildiği kolay özellikleri asıl kalite yerine koymamalıdır. Kelime sayısı, kaynak sayısı veya bölüm sayısı nihai kaliteyi temsil etmeyebilir. Bir değerlendirme kurulu da ortak beğenisini nesnel gerçek gibi sunmamalıdır. Meşru yorum farklılıklarını koruyan, somut kusurları ayıran ve kullanıcı değerlerine bağlı kalan bir değerlendirme düzeni gerekir.

### 29.8. Kendini geliştirme ne zaman güvenilir sayılacak?

Bir değişiklik birkaç örneği iyileştirip başka işleri bozabilir. Sık görülen görevlerde yararlı olan bir kural, nadir ama önemli bir durumda zararlı olabilir. Önceden görülen testleri öğrenmek de genel yetkinlik artışıyla karışabilir.

Yöntem geliştirme bu nedenle yeni örnekler, farklı bağlamlar, geriye dönük yeterlik, görevler arası aktarım ve başarısızlık teşhisiyle birlikte değerlendirilmelidir. Birikim taşıyan sistemin davranışının ne zaman değiştiği ve hangi sürüme geri dönülebileceği bilinmelidir. Öğrenme, yalnız yeni metin üretmek veya kullanım sayısını artırmak değildir. [K23]

### 29.9. Mahrem bilgi ile ortak öğrenme nasıl ayrılacak?

Bir projedeki hata başka projelere değerli ders sağlayabilir. Fakat bu ders çıkarılırken özel içerik, kurum bilgisi, kullanıcı tercihleri veya yetkili bağlam sızabilir. Ham olayın ortak kütüphaneye atılması yerine, taşınabilir yöntemin hangi ayrıntılara gerçekten ihtiyaç duyduğu değerlendirilmelidir.

Genelleştirme de dikkat ister. Özel bağlamı tamamen çıkarmak, dersin geçerlilik koşulunu yok edebilir. SOUL'un öğrenme ve paylaşım düzeni, hem gereksiz veri taşımamayı hem anlamlı sınırı korumayı başarmalıdır. Bu, yalnız erişim kontrolü değil, bilgi tasarımı problemidir.

### 29.10. Sağlayıcı bağımsızlığı hangi düzeyde isteniyor?

Aynı rol metninin iki üründe açılması mı, aynı araç sözleşmelerinin kullanılabilmesi mi, yoksa aynı kalite ve güvenlik hedeflerinin iki ortamda gösterilmesi mi? Bunlar farklı taşınabilirlik iddialarıdır. DevOS'un Codex üzerinde kurulması, SOUL'un bu ayrımları belirlemesini gereksiz kılmaz.

Araştırma ve sınamalar, ortak alan sözleşmesini hangi sağlayıcı özelliklerinin taşıyabildiğini ortaya koymalıdır. Eksik bir sağlayıcı yeteneği bazen bir adapter, bazen ayrı çalışma ortamı, bazen farklı görev dağılımı gerektirebilir. Taşınabilirliğin kapsamı kanıtlandığı kadar ilan edilmelidir.

### 29.11. Güvenli biçimde durabilen sistem nasıl ilerleyebilir kalacak?

Hata halinde hiçbir şey yapmamak güvenlik sağlayabilir; fakat her belirsizlikte durmak faydayı yok edebilir. SOUL, önemli dış etkileri sınırlarken araştırma, taslak, alternatif üretme veya etkilenmeyen işleri sürdürme imkânlarını değerlendirebilmelidir.

Bu, güvenlik kurallarını aşmak değildir. Durmanın kapsamını doğru belirlemektir. Bir yayının yetkisi eksik diye tüm düşünme faaliyetinin durması gerekmeyebilir. Bir kaynak şüpheliyse ondan türeyen hüküm bekletilirken diğer doğrulanmış işler ilerleyebilir. Güvenlik ve ilerleyebilirlik birlikte tasarlanmalıdır.

### 29.12. DevOS kendi amacını süreç üretimine nasıl kaptırmayacak?

DevOS'un amacı kendisini sürekli daha ayrıntılı tanımlamak değil, SOUL'u geliştirmektir. Elbette çalışma düzeninin geliştirilmesi gerçek iştir. Fakat kendi kayıtlarının, kurullarının ve yöntemlerinin büyümesi ürün gelişiminin yerine geçmemelidir.

Bu nedenle düzen geliştirme işlerinin ürün amacına bağlantısı görünür olmalıdır. Hangi darboğazı gideriyor? Hangi güven veya yetenek açığını kapatıyor? Uygulanması hangi gerçek işin ilerlemesini sağlayacak? Aynı inceleme DevOS'un bu metinden çıkaracağı yeni işlere de uygulanmalıdır. Bu raporun kapsamlı olması, içindeki her fikrin otomatik inşa yükümlülüğü olduğu anlamına gelmez.

## 30. DevOS nasıl olgunlaştırılmalı?

Burada önerdiğim yön, baştan bütün SOUL'u tasarlayıp sonra bir defada uygulamak değil; ciddi ve bütünlüklü yeterlik dilimleri üzerinden ilerlemektir. Bir dilim, yalnız çalışan bir ekran veya boş bir iş tablosu değil, belirli bir hedef için ihtiyaç keşfinden gerçek sonucun değerlendirilmesine kadar anlamlı bir yolu taşımalıdır.

İlk olgunlaştırma sorusu, ekibin mevcut kaynak ve yetki altında doğru bir araştırma veya tasarım işini keşfedip gerekçelendirebilmesidir. Seçilecek SOUL işi ekip tarafından bulunmalıdır. Değerlendirme düzeni ise bu keşfin rastlantısal, kullanıcı tarafından fark ettirilmiş veya yalnız biçimsel olmadığını incelemelidir. Bu, sistemin bilişsel amacını inşanın en sonuna ertelememek için gereklidir.

Bununla birlikte gerçek erişim, kalıcı kayıt ve yeniden giriş gibi işletim koşulları erkenden sınanmalıdır. Sonradan “asıl ortamda bu rol o araca ulaşamıyormuş” denmesi, doğru düşünme davranışını da ölçmeyi zorlaştırır. Bu nedenle bilişsel ve operasyonel yeterlik paralel biçimde olgunlaşmalıdır; biri tamamen bitene kadar diğeri beklememelidir.

Sonraki olgunlaştırma, katkıların birleşmesi ve kesinti altında sürmesi üzerinedir. Bir aktör araştırma ister, başka aktör yanıt verir, alan sahibi kararı günceller, bağımsız inceleme sınırlı bir hüküm üretir ve ilgili iş yeni durumdan devam eder. Araya kaynak değişikliği, gecikmiş yanıt veya oturum kesintisi girdiğinde süreç doğru biçimde yeniden kurulabilmelidir.

Daha sonra aynı düzenin farklı iş türlerinde neyi koruduğu ve neyi değiştirdiği incelenebilir. Yazılım dışındaki örnekler özellikle değerlidir; çünkü yazılım testlerinin sağladığı kolay doğrulama araçlarının arkasında gizlenen bütünlük ve yargı sorunlarını görünür kılar. Roman veya soru bankası örneklerinin değeri, SOUL'u bütün alanlarda kanıtlamak değil, mevcut tasarımın dar varsayımlarını zorlamaktır.

Olgunlaştırmanın her aşamasında kabul iddiası sınırlandırılmalıdır. “Bu konfigürasyon şu senaryoda devamı korudu” denebilir. Buradan “SOUL her uzun işi güvenilir biçimde yapar” sonucu çıkarılmaz. Aynı şekilde belirli bir başarısızlık bütün yaklaşımın değersiz olduğunu kanıtlamaz; hangi sorumluluğun, mekanizmanın veya varsayımın yeniden ele alınacağını göstermelidir.

En sonunda DevOS, SOUL'u geliştiren gerçek bir çalışma sistemi olarak kendi başarısını ürün ilerlemesi üzerinden de sınamalıdır. Araştırma bilgisi kullanılabilir tasarıma, tasarım çalışan yeteneğe, yetenek uygun değerlendirmeye ve değerlendirme sonraki doğru işe dönüşüyor mu? Bu dönüşüm gerçekleşmiyorsa, yalnız belge veya kontrol sayısındaki artış gelişim sayılmamalıdır.

## 31. Sonuç: kurulması gereken şey nasıl bir nitelik?

SOUL için aranan nitelik, tek bir modelin olağanüstü bir cevabında değil, birbirini taşıyan bir çalışma bütününde bulunuyor. Amaç yeterince anlaşılacak; yapılacak iş keşfedilecek; gerekli bilgi bulunacak ve kullanılacak; uygun aktörler hazırlanacak; kararlar gerekçelendirilecek; gerçek etkiler yetki altında gerçekleştirilecek; sonuçlar doğru kapsamda değerlendirilecek; değişim ve kesinti çalışmanın anlamını kaybettirmeyecek.

DevOS, bu niteliği SOUL hakkında anlatan bir yapı değil, SOUL'u geliştirirken bunun gerekli kısmını fiilen gerçekleştiren yapı olmalıdır. Kullanıcı her önemli eksikliği kendisi fark ediyor, kaynakları hatırlatıyor, rolleri sıraya koyuyor ve çalışma durumunu yeniden kuruyorsa, bu sorumluluk henüz DevOS tarafından üstlenilmemiş demektir.

Bunun çözümü yalnız daha fazla ajan, daha büyük bağlam, daha ayrıntılı protokol veya daha güçlü veritabanı değildir. Bunlardan her biri gerekli olabilir; fakat değerleri ortak amaç altında doğru ilişkilerle birleşmelerinden gelir. İyi çalışan teknik omurga, iyi muhakemeyi taşımalıdır. İyi muhakeme de kayıt, gerçek eylem ve doğrulama yoluna bağlanmalıdır.

**SOUL'un hedefi, doğru tanımlanmış işleri iyi yapan bir otomasyon olmakla sınırlı değildir. Hangi işin gerektiğini anlayabilen, o iş için gerekli çalışma sistemini kurabilen ve sistemin yeterliğini kullanım boyunca koruyabilen bir yapı olmaktır. DevOS'un görevi, bu hedefi varsaymak veya ilan etmek değil, araştırarak, tasarlayarak, uygulayarak ve sınayarak gerçek hale getirmektir.**

# Ekler

## Ek A. Okuma kapsamı ve sonuçların nasıl kullanılacağı

Bu metni hazırlarken güncel proje deposu, Library kayıtları ve sınırlı sayıda dış birincil kaynak birlikte kullanıldı. Depodaki güncel iş kayıtları, tarihsel değerlendirmelerden ayrı ele alındı. Aynı dosyanın veya başlığın farklı dönemlerde farklı statüler taşıyabildiği yerlerde yeni iş kaydı tercih edildi; geçmiş ifade sessizce güncel kabul haline getirilmedi.

**Tam veya ana gövdesi tamamlanmış okumalar:** Dokuz çalışma protokolü; RPD'nin kavramsal temel, süreklilik, skill ve değerlendirme belgeleri; SOUL Academy keşif notu; Foundation'ın iş ve aktör sentezleri, bütünleşme ve yeterlik/yeniden kullanım metinleri; context–memory–harness çapraz sentezi; ECC CORE; Hermes'in dört geçici sentezi ve skill kütüphanesi yaşam döngüsü notu; Beads bulguları; Superpowers bütün-sistem modeli; EXP-001, EXP-002, EXP-003 ve EXP-004'ün belirtilen kullanıcı mesajları kayıtları; EXP-004 çalışma sistemi taslağı; EXP-006 ortak entelektüel taban açılımı. Bu ifade, bu kaynakların atıf verdiği bütün alt kaynakların da yeniden okunduğu anlamına gelmez.

**Seçici veya kısmi ayrıntı okumaları:** Keel'in tarihsel araştırma kayıtları ve aktif durum analizinin büyük bölümü; Oyun2'nin vizyon, proje kutusu, pano ve bilinmeyenler dosyaları; ECC metodoloji kaydı; OpenSpec ve Flowable bulguları; gstack CORE; EXP-005 dersler kaydı; EXP-006'nın iş–bilgi tartışması, güncel durum, karar, devir ve P5 hazırlık kayıtları. Bu kaynaklardan yalnız görülen kapsamı destekleyen sonuçlar taşındı.

**Tam okuma iddiası bulunmayan alanlar:** Keel ve Oyun2'nin bütün kod ve olay geçmişi; Foundation'ın her yaprak araştırması ve bütün dış literatürü; Studies altındaki her araştırmanın bütün kanıt dosyaları; Hermes'in bütün notları ve deney ham çıktıları; Exploration konuşmalarındaki bütün asistan yanıtları ve bütün ekler; P5'in tam teslim arşivi. İlgili sınırlamalar, bu alanların hiçbirinin araştırılmadığı anlamına gelmez; bu metnin tüm arşivin eksiksiz denetimi olarak kullanılmaması gerektiği anlamına gelir.

**Bu çalışma sırasında yapılmayanlar:** Canlı DevOS veya SOUL kurulumu, ajan yeterlik koşusu, bağımsız deney tekrarı, provider bağlama testi, repository değişikliği ve mimari kararların kullanıcı adına kabulü. Kaynaklarda bildirilen test sayıları, bu çalışmanın kendi deney sonucu olarak sunulmadı.

Bu metnin doğru kullanımı, SOUL ve DevOS için kapsamlı bir düşünme ve tasarım zemini sağlamasıdır. Bir uygulanabilirlik hükmü, maliyet kararı veya gerçek kabul için ilgili kaynağın güncel ve tam görünümüne, hedef ortamın sınanmasına ve gerekli yetkiye yeniden gidilmelidir.

## Ek B. Proje kaynakları

### K01 — EXP-001: SOUL çalışma modeli

`explorations/EXP-001-soul-calisma-modeli/sources/conversation/USER-MESSAGES.md`. Talep–niyet–iş tanımı ayrımı; yaşayan plan; küçük işte profesyonel standart. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-001-soul-calisma-modeli/sources/conversation/USER-MESSAGES.md)

### K02 — EXP-002: Baz yapı ve entelektüel taban

`explorations/EXP-002-soul-baz-yapi-ve-entelektuel-taban/sources/conversation/USER-MESSAGES.md`. Ortak zihinsel standart, rol amacı, model/rol ayrımı ve DevOS ihtiyacı. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-002-soul-baz-yapi-ve-entelektuel-taban/sources/conversation/USER-MESSAGES.md)

### K03 — EXP-004: Genişleyen SOUL konuşması

`explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/sources/conversation/USER-MESSAGES.md`. Özellikle U010 ve U016: ayrılıp giden kurucu yerine dikey ve yatay genişleyen çalışma sistemi. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/sources/conversation/USER-MESSAGES.md)

### K04 — RPD belge ailesi

Library: `ozyinelemeli_onkosul_kesfi_kavramsal_temel(1).md` ve `RPD_Sureklilik_Tasarimi_v0_1.md`; bunlarla birlikte okunan RPD skill, değerlendirme ve tasarım inceleme kayıtları. Kavramsal temel 550, süreklilik belgesi 392 kaynak satırı. Bu belgeler proje içi yöntem ve tasarım önerileridir; hedefte genel bilişsel fayda kanıtı olarak kullanılmadı. Library belgelerinin bu raporda yeni bir halka açık kopyası yayımlanmadı.

### K05 — Çalışma protokolleri

`AGENT.md` ve `agent/protocols/` altındaki dokuz belge: `decision-critical-assumptions.md`, `user-independent-reasoning.md`, `goal-method-end-to-end-validation.md`, `verification-independence.md`, `source-view-fidelity.md`, `causal-depth-root-cause-validation.md`, `work-system-continuity.md`, `canonical-work-preflight.md`, `candidate-research-library.md`. [Protokol dizinini aç](https://github.com/batuhanozgun/agentic-os-search/tree/main/agent/protocols)

### K06 — EXP-004: Çalışma sistemi taslağı ve mekanizma bağı

`artifacts/MS01-SOUL-WORKING-SYSTEM-DRAFT.md` ve ilgili `MS01-RESEARCH-TO-MECHANISM-MAP.md` kesitleri. Kavramsal tasarım ve senaryo yürüyüşü; canlı sistem doğrulaması değil. [Taslağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/artifacts/MS01-SOUL-WORKING-SYSTEM-DRAFT.md)

### K07 — Foundation güncel yapı ve yeterlik değerlendirmesi

`research/soul-foundations/STATE.md`, `INDEX.md`, `08_foundation-sufficiency-reuse-review/SYNTHESIS.md` ve `REUSE.md`; iş alanının `WORK-GROUND-AUDIT-SYNTHESIS.md` sentezi. Araştırma zemini ve yeniden kullanım sınırları. [Foundation girişini aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/soul-foundations/INDEX.md)

### K08 — EXP-006 güncel yön ve P5 kaydı

`STATE.md`, `WORK.md`, `DECISIONS.md`, `HANDOFF.md` ve `work/P5-01-codex-build-installation-package.md`. 28 Eylül 2026 durumu; D012, D014, D027–D029 yönleri; paket hazırlığı ve NOT_RUN hedef koşuları ayrımı. [P5 kaydını aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-006-development-os-calisma-duzeni/work/P5-01-codex-build-installation-package.md)

### K09 — Foundation: alanlar arası bütünleşme

`research/soul-foundations/06_integration-frontier-review/B1-PARENT-INTEGRATION.md`. Binding, standing, control, propagation, causation, feedback ve adaptation ayrımları. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/soul-foundations/06_integration-frontier-review/B1-PARENT-INTEGRATION.md)

### K10 — Foundation: üretim sistemini de incelemek

`research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md`. Matematik soru bankası tartışmasında ürünün yanında onu üretecek çalışma düzeninin de ele alınması. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md)

### K11 — Foundation: yeterlik, erişim ve tüketici

`research/soul-foundations/07_selection-dynamics-integration-review/SYNTHESIS.md`. Aynı kullanım için yeterli ve erişilebilir ortak görünüm; aktöre göre bilgi; yeniden ifade, zaman ve güncelleme sınırları. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/soul-foundations/07_selection-dynamics-integration-review/SYNTHESIS.md)

### K12 — EXP-006: B1 ortak entelektüel taban

`work/B1-common-intellectual-baseline.md`. Ortak tabanın tanımı, gerçek davranışa aktarılması, ipucusuz ihtiyaç keşfi, teşhis ve kontrollü değişiklik. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-006-development-os-calisma-duzeni/work/B1-common-intellectual-baseline.md)

### K13 — EXP-005: İhtiyaç keşfi ve çalışma disiplini dersleri

`reflections/LESSONS-AND-OPEN-QUESTIONS.md`. Erken çözüm seçimi, gerçek erişim, kullanıcıya kalan çalışma yükü, kanıt ve yayın sınırları. Tarihsel değerlendirme; bütün konuşmanın bağımsız yeniden denetimi değil. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-005-ihtiyac-kesfi-ve-calisma-disiplini/reflections/LESSONS-AND-OPEN-QUESTIONS.md)

### K14 — EXP-003: Ek hafıza

`explorations/EXP-003-ek-hafiza-ve-arastirma-temelli-guvenilirlik/sources/conversation/USER-MESSAGES.md`. Saklama, güncelleme, bilgi tabanı ve ihtiyaç anında kullanım. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-003-ek-hafiza-ve-arastirma-temelli-guvenilirlik/sources/conversation/USER-MESSAGES.md)

### K15 — Beads araştırması

`research/studies/beads/FINDINGS.md`. 17 Eylül 2026'da sabitlenmiş kaynak incelemesi; hazır oluş, keşif kökeni, claim, lease ve yeniden açılma. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/beads/FINDINGS.md)

### K16 — ECC araştırması

`research/studies/ecc/CORE.md`, `METHOD-CASE.md` ve araştırma giriş kaydı. CORE, U20-A kapsamında aday bütün açıklamasıdır; tüm hedef yeterliği veya SOUL benimsemesi değildir. [CORE'u aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/ecc/CORE.md)

### K17 — Hermes araştırması

`research/studies/hermes-agent/synthesis/` altındaki 01–04 geçici sentezler; `notes/30-SKILL-LIBRARY-LIFECYCLE.md`; güncel `INDEX.md`. Kaynak davranışı, oturum/iş/çalıştırma, zamanlanmış iş ve yöntem yaşamı. [Araştırma girişini aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/hermes-agent/INDEX.md)

### K18 — EXP-006: İş ve bilgi düzeni

`work/P3-01-work-information-discussion.md`. G/Y ayrımı, içerik ve bilgi bakımı, talep–yanıt–kullanım, itiraz, eşzamanlı değişiklik ve kesinti yürüyüşü. İlgili kesitler kullanıldı; senaryo masa başı tasarımdır. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/explorations/EXP-006-development-os-calisma-duzeni/work/P3-01-work-information-discussion.md)

### K19 — Foundation aktör alanı

`research/soul-foundations/03_ground-deepening/grounds/actors/synthesis/ACTORS-GROUND-AUDIT-SYNTHESIS.md`. Rol, yetkinlik, erişim, yetki, sorumluluk ve aktör ilişkileri. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/soul-foundations/03_ground-deepening/grounds/actors/synthesis/ACTORS-GROUND-AUDIT-SYNTHESIS.md)

### K20 — OpenSpec araştırması

`research/studies/openspec/FINDINGS.md`, özellikle değişiklik paketi, yaşayan plan, çıktı varlığı ile yeterlik ayrımı. Bulguların ilgili ilk bölümleri kullanıldı. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/openspec/FINDINGS.md)

### K21 — Flowable araştırması

`research/studies/flowable/FINDINGS.md`, özellikle BPMN/CMMN/DMN, kalıcı bekleme, gerçek yürütme, in-flight migration ve geri dönüş türleri. Bulguların ilgili ilk bölümleri kullanıldı. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/flowable/FINDINGS.md)

### K22 — Context, Memory ve Harness Engineering

`research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md`. Üç sorumluluk alanı ile RAG, grafik, long context, CAG ve fine-tuning gibi mekanizmaların ayrılması. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/context-memory-harness-engineering/04-CROSS-LAYER-SYNTHESIS.md)

### K23 — SOUL Academy keşif notu

Library: `SOUL_ACADEMY_EXPLORATORY_CONCEPT_NOTE.md`, 1244 kaynak satırı. Hata düzeltme ile yetkinlik geliştirme; yöntem üretme, sınama, yerel kabul, mahremiyet ve aktarım. Kabul edilmiş mimari bileşen değildir.

### K24 — Önceki planlama deneyimine ilişkin tamamlayıcı not

Library: `eski_proje_planlama_acisindan_gozlemler.md`. Loopinance deneyimine ilişkin ikincil gözlem metni. Oyun2 ile eşitlenmedi; kullanıcıya kalan uzmanlık ve süreç yükü, plan–uygulama ilişkisi için tamamlayıcı kaynak olarak kullanıldı.

### K25 — Keel tarihsel bağlamı ve aktif durum analizi

`research/soul-context/repos/keel/README.md`, `research/soul-context/evidence/CONTEXT-SYNTHESIS.md` ve Library'deki `07_KEEL_ACTIVE_STATE_ANALYSIS.md`. Keel hakkındaki kayıt ve analizlerdir; bu rapor Keel'in bütün kodunu yeniden çalıştırmış değildir. [Keel araştırma kaydını aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/soul-context/repos/keel/README.md)

### K26 — Oyun2 birincil kayıtları

`batuhanozgun/oyun2` deposunda `02_kanon/VIZYON.md`, `01_kutular/KT-001-proje-plani/KUTU.md`, `BILINMEYENLER.md` ve `00_pano/PANO.md`. Okunan ref: `d91cf2244e763e9224c8003e4de32c901b29a882`. [Sabit kaynak ağacını aç](https://github.com/batuhanozgun/oyun2/tree/d91cf2244e763e9224c8003e4de32c901b29a882)

### K27 — Superpowers bütün-sistem açıklaması

`research/studies/superpowers/syntheses/S05-native-system-model.md`. 18 Eylül 2026 tarihli, ilgili araştırma geçişindeki geçici bütün açıklaması; kaynak sözleşmeleri ile gerçek çalışma ve benimseme ayrımı. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/superpowers/syntheses/S05-native-system-model.md)

### K28 — gstack üst düzey sentezi

`research/studies/gstack/CORE.md` dosyasının ilgili ilk bölümleri. Alt sistemlere dağılmış iş, kanıt, yetki, etki ve geri okuma modeli; bütün ham kanıtların yerine geçmez. [Kaynağı aç](https://github.com/batuhanozgun/agentic-os-search/blob/main/research/studies/gstack/CORE.md)

## Ek C. Dış birincil kaynaklar

Bu kaynaklar kavram ve yöntemleri karşılaştırmak için kullanıldı. SOUL veya DevOS'un bu kaynaklardaki ürünleri kullanmış olduğu ya da aynı sonuçları elde ettiği iddia edilmiyor. Erişim tarihi 28 Eylül 2026'dır; canlı belge adreslerinin içeriği daha sonra değişebilir.

### D01 — Anthropic: Effective context engineering for AI agents

29 Eylül 2025 tarihli mühendislik yazısı. Bağlam seçimi, ihtiyaç anında erişim, sıkıştırma ve kalıcı notlar. [Kaynağı aç](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

### D02 — Temporal: Workflow Execution

Dayanıklı yürütme, olay geçmişi ve replay açıklaması. [Kaynağı aç](https://docs.temporal.io/workflow-execution)

### D03 — AWS Builders' Library: Making retries safe with idempotent APIs

Tekrar deneme, belirsiz etki, istek kimliği ve idempotent işlem sözleşmeleri. [Kaynağı aç](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/)

### D04 — OWASP: LLM06:2025 Excessive Agency

Araç işlevi, izin ve otonomi kapsamının gereksiz genişliği; sınırlandırma yaklaşımları. [Kaynağı aç](https://genai.owasp.org/llmrisk/llm062025-excessive-agency/)

### D05 — NASA Systems Engineering Handbook: 4.0 System Design Processes

Paydaş beklentileri, gereksinimler, mantıksal ayrıştırma, tasarım ve yinelemeli/özyinelemeli geliştirme. [Kaynağı aç](https://www.nasa.gov/reference/4-0-system-design-processes/)

### D06 — OpenAI: Harness engineering

11 Şubat 2026 tarihli, ajan odaklı geliştirme ortamına ilişkin deneyim yazısı. Repo bilgisinin haritalanması ve çalışma ortamının tasarımı. [Kaynağı aç](https://openai.com/index/harness-engineering/)

### D07 — PostgreSQL: Transaction Isolation

Eşzamanlı işlemler ve izolasyon davranışlarının resmî açıklaması. Okuma anında current dokümantasyonu PostgreSQL 18'e yönleniyordu. [Kaynağı aç](https://www.postgresql.org/docs/current/transaction-iso.html)

### D08 — NASA Systems Engineering Handbook: 5.0 Product Realization

Verification, validation, bütün ürün ve gerçek kullanım koşulları ayrımı. [Kaynağı aç](https://www.nasa.gov/reference/5-0-product-realization/)

### D09 — Anthropic: Demystifying evals for AI agents

9 Ocak 2026 tarihli mühendislik yazısı. Ajan ile harness'in birlikte değerlendirilmesi, sonuç, grader ve değerlendirme düzeninin sınırları. [Kaynağı aç](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

### D10 — OpenTelemetry: Signals

İzler, ölçümler ve log gibi telemetri sinyallerinin açıklaması. [Kaynağı aç](https://opentelemetry.io/docs/concepts/signals/)

### D11 — University of Maryland: SHOP Project Description

HTN planning ve yöntemlerle görev ayrıştırmasının araştırmacı açıklaması. Tarihsel yöntem kaynağı; güncel ürün sürümü önerisi olarak kullanılmadı. [Kaynağı aç](https://www.cs.umd.edu/projects/shop/description.html)

### D12 — Alistair Cockburn: Hexagonal architecture

Ports and Adapters yaklaşımının özgün açıklaması. [Kaynağı aç](https://alistair.cockburn.us/hexagonal-architecture)

### D13 — Hypothesis: Introduction

Özellik tabanlı sınama ve örnek özellik aileleri için resmî dokümantasyon. [Kaynağı aç](https://hypothesis.readthedocs.io/en/latest/tutorial/introduction.html)

### D14 — Leslie Lamport: TLA+

TLA+ ve sistemleri belirtme/doğrulama yaklaşımına ilişkin birincil giriş kaynağı. [Kaynağı aç](https://lamport.azurewebsites.net/tla/tla.html)
