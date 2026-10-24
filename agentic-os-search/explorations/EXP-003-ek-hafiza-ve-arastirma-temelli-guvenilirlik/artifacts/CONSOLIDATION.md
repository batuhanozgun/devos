# EXP-003 — Ek hafıza ve araştırma temelli güvenilirlik

**18 Eylül 2026. Türetilmiş konsolidasyon.** Kaynak diyalog [U001–U011 / S001–S010](../sources/conversation/INDEX.md); bu metin onların yerine geçmez. Aşağıdaki bütünlük, arşivleme sırasında assistant tarafından kurulmuştur. Yeni kullanıcı onayı, araştırma sonucu veya uygulanmış mimari değildir. Sayısal kazanım ve kaynak doğrulama düzeltmeleri [QUALIFICATIONS](../reflections/QUALIFICATIONS.md) içindedir.

## 1. Konuşmanın başlangıcı ile sonunda beliren amacı

Batu U001'de konuyu baştan exploration diye sınıflandırmadı. Eğitim bilgisi, bağlam ve ek hafıza için yalnız bu konuşmaya ait adlar seçti. U002'de uzmanlık iddiasında bulunmadığını; ne bildiğini, neyi doğru sandığını ve neyi bilmediğini karşılıklı sorgulamayla anlamak istediğini açıkça söyledi. Bu, bir tezi doğrulatma isteği değil, düşünceyi örneklerle sınama niyetidir.

U011'de daha uzun vadeli amaç görünür oldu: araştırmalardaki yapıları yalnız kopyalamadan, açıklarını karşılaştırıp yeniden düşünerek ve Foundation'ın ayrımlarını kullanarak agent'lar için daha sağlam, sürdürülebilir bir ek hafıza düzeni kurabilmek. Kullanıcı bunun için daha çok iş olduğunu aynı mesajda belirtir. Dolayısıyla 'kurduk' sözcüğü, ulaşılmak istenen gelecekteki cümlenin parçasıdır; gerçekleşmiş başarı raporu değildir.

## 2. Üç bilgi kaynağını karıştırmama

Yerel kullanımda eğitim bilgisi modelin eğitimden taşıdığı bilgidir. Bağlam, ilgili yanıtı oluştururken erişilebilir girdidir. Ek hafıza, eğitim bilgisinin dışında sürdürülen ve gerektiğinde yeniden kullanılabilen bilgi ile onun yaşamını yöneten düzenin tartışma adıdır. Sonraki turlarda odak, salt depolanan içerikten o içeriğin oluşturulması, bulunması, yorumlanması ve değiştirilmesi mekanizmasına kaydı.

Bu kullanım evrensel sözlük veya concepts kabulü değildir. Dosyalar ilk somutlaştırma aracıdır; bütün ek hafızanın Markdown olacağı kararlaştırılmadı. Parametre değişimi bu konuşmanın ana nesnesi değildir. Bir bilginin güncel kullanıcı mesajından veya mevcut bağlamdan edinilebilmesi, kalıcı dosyaya yalnız gelecekte tekrar kullanım için ihtiyaç duyulabilmesi ayrıca korunmalıdır. [U001–U002; S001–S002; Q06]

## 3. Yaratmak, okumak, düzenlemek: işlemi mekanizmadan ayırmak

Kullanıcının üçlüsü, bir bilgi yüzeyi üzerinde yapılacak işlemlerin geniş kümeleri olarak önerildi. Silme, bölme veya yeniden sınıflandırma, geniş 'düzenleme' altında; kopyalama ise okumayla yeni bir taşıyıcı oluşturmanın bileşimi olarak düşünülebilir.

Assistant S002'de policy/control ve ihtiyaç gerekçelerini aynı tartışma seviyesine taşıdı. U003 bunun erken olduğunu ve işlem ailesi ile bu işlemleri bir amaç için yöneten mekanizmanın ayrılması gerektiğini belirtti. S003 bu düzeltmeyi kabul etti. Policy bir kayıt olarak yaratılıp okunabilir; policy'nin yönetsel rolü ise dördüncü dosya işlemi değildir.

Buradan evrensel olarak tam üç primitive bulunduğu veya minimalitenin kanıtlandığı sonucu çıkmaz. İşlem kümesini çok geniş tanımlamak kapsayıcılığı kolaylaştırır; bunun açıklayıcılık değeri ayrıca sınanmalıdır. Kazanım, isim sayısı değil, işlem–amaç–mekanizma seviyelerinin karıştırılmamasıdır. [U002–U003; S002–S003; Q07]

## 4. T=0 / T=1 / T=2: neyi değiştirdik?

U004'ün `bilgi.md` örneğinde başlangıç metni topun yuvarlak, sahanın yeşil olduğunu söyler. T=1'de kırmızı forma cümlesi eklenir. T=2'de kırmızı yerine mavi yazılır. Örnek, gerçek dosya sistemi uygulaması olarak değil, seviyeleri görünür kılmak için kurulmuştur.

Dosya kimliği, taşınan metin ve metnin ifade ettiği iddialar aynı analiz birimi değildir. T=1 dosya açısından düzenleme, önceki iddialar açısından koruma, eklenen ifade açısından yeni kayıt olabilir. Bu, 'yoktan yeni gerçek yarattık' anlamına gelmez. T=2'deki değişiklik de tek başına eski bilginin yanlış olduğunu göstermez: dünya değişmiş, eski kayıt düzeltilmiş, farklı bir forma kastedilmiş veya iki kaynak ayrışmış olabilir. Kaydetme anları olayın geçerlilik zamanlarını otomatik belirlemez.

Önemli soru artık yalnız 'create mi revise mı?' değil, 'hangi nesne, hangi kimlik ve hangi anlam bakımından değişti?' olur. Aynı işlem bir dosyayı değiştirirken yeni bir iddia kaydı, yeni bir sürüm veya yeni bir erişim kaydı oluşturabilir. [U004; S004; Q08]

## 5. Bilginin varlığı da bilgidir; varlık kullanım değildir

U005'te kullanıcılar → Batu → karakter/iş/eğitim örneğiyle iki katmanı ayırır: bilginin ayrıntısına sahip olmak ve o ayrıntının bulunduğunu bilip uygun zamanda ona gidebilmek. İlk yönlendirme dosyası, bütün ayrıntıyı içermeden sonraki okuma kararına yardımcı olabilir. Bu, bir insanın belleğinin bilimsel modeli değil, seçici geri çağırma örneğidir.

Bu yüzden kayıt, indeks, kaynak yolu, erişim yetkisi, çalışan okuma aracı, mevcut bağlam ve fiilî kullanım birbirinin yerine geçmez. Aynı kaynak yeni bir oturumda yeniden görünür hale geldiğinde depodaki dosya yeniden yaratılmış değildir; tüketiciye göre yeni bir görünüm/erişim oluşmuş olabilir. Kalıcı bilgi kümesi ile belirli çağrının görünür kümesi ayrılmalıdır.

Katman, kategori ve bağlantılar aday düzenleme yollarıdır. Tek bir ağacın anlam, kaynak, tarih, yetki ve erişim ilişkilerinin tamamını temsil etmesi zorunlu değildir. Bunun alternatifi de otomatik olarak grafik veritabanı değildir. [U005; S005–S006]

## 6. Foundation ne kattı?

U006'nın yönüyle konuşma kendi sezgilerinin dışındaki mevcut araştırmaya döndü. Information/State, bilgi temsilinin konusu, kapsamı, biçimi, kimliği ve niteliğini ayırır. Dynamics, oluşum, türetim/revizyon ve seçme/sunma sorularını; Records ise gelecekte kullanılabilir kalmak için korunması gereken bağımlılıkları görünür kılar. Bunlar create/read/revise'nin rakip işlem listeleri değil, aynı işleme yöneltilen farklı anlam ve güvence sorularıdır.

Konuşmada özellikle şu ayrımlar kullanıldı: yeni kayıt ile yeni bağımsız kanıt; aynı byte ile aynı anlam/iddia; dosya düzenlemesi ile bilgi revizyonu; kaynak bulunması ile kullanım için yeterli bilgi; bir tüketiciye erişim ile başka oturuma erişim; mevcut cevabı koruma ile gelecekte doğru güncellenebilme.

Work kullanım amacını ve bakım işini; Actors sorumluluk ve yetkiyi; Environment gerçek erişim ve çalışma koşullarını; Composition ise ilişki, kontrol ve değişimin gerçekleşmesini sorgulamayı sağlar. Hiçbiri burada zorunlu servis, agent, metadata alanı veya mimari katmana çevrilmedi. Kaynak yolları [RESEARCH-REFERENCES](../sources/RESEARCH-REFERENCES.md) içindedir. [U006–U007; S006]

## 7. Sağlamlık: değişmeme değil, gerekli ayrımları kaybetmeme

U005'in 'hiç bozulmamalı, hiç yıpranmamalı' hedefi, değişimin yasaklanması değil, kullanım değeri ve bütünlüğün korunması isteği olarak okunur. Kullanıcı her dosyanın her değişimde değiştirilmesini istemediğini açıkça söyler. S006 bunu yeni bir kullanıcı düzeltmesiymiş gibi sunmamalıydı.

Bu amaç için sorulabilecek soru şudur: bu değişiklikten hangi kaynaklar, özetler, indeksler, erişim yolları veya devam eden karar dayanakları maddi olarak etkilenir? Etkinin eksiksiz bilindiği varsayılamaz. Bağımlılık kaydı da eksik veya eski olabilir. 'Bozulma sessiz olamaz' ifadesi de sağlanmış garanti değildir; tespit kapsamı ve belirsizlikleri olan aday güvence hedefidir.

Eski kayıt tarihsel soruya doğru cevap verebilir. Sorun her eskilik değil, kaydın yeni kullanımda yanlış statüyle uygulanmasıdır. Uygun saklama, saklanan iddiayı doğru yapmaz. [U005; S005–S006; Q09]

## 8. Karpathy ilk örnek oldu; zorunlu temel seçilmedi

U007–U008, Foundation ayrımlarıyla Karpathy notuna bakma yönünü verdi. S008, ham kaynaklar, LLM tarafından sürdürülen wiki, yönergeler, indeks ve günlük üzerinden ingest/query/lint anlatısını tartıştı. Kaynak–türev, işlem geçmişi–anlam değişimi, indeks–kaynak, tekrar eden ifade–bağımsız kanıt ayrımlarıyla sorular üretildi.

Ancak arşivleme sırasında yeniden okunan `llm-wiki/META.md`, ayrıntılı araştırmanın başlamadığını ve Gist revision pin'inin bulunmadığını gösterir. Görünür diyalogda S008'in iddiasını karşılayan tam Gist okuma/revision kaydı yoktur. Bu nedenle S008 bir sürüm-sabit dış hedef denetimi değil, doğrulanması gereken konuşma değerlendirmesi olarak korunur. Bir fikir notunda tarif edilmeyen özellik, her uygulamada bulunmayan özellik veya gerçekleşmiş hata demek değildir.

Karpathy'yi baz alma, U009'da varsayımsal karşılaştırma olarak geçer. Nihai temel seçimi değildir. Sonraki araştırma bu temeli değiştirebilir, sadeleştirebilir veya tamamen başka seçenek gösterebilir. [U007–U009; S007–S009; Q03–Q04]

## 9. Studies'in katkısı ve marjinal araştırma değeri

U010, daha çok kaynak toplamayı kendi başına amaç yapmamak için marjinal faydayı sorgular. S010, gstack/ECC/Hermes'teki kayıt–görünüm–oturum sınırlarını, açık çalışma durumları ile aday hafıza yaklaşımlarını konuya taşıdı. Fakat META başlık taraması, paket tam okuması, kaynak kodu incelemesi, yerel mekanik deney ve gerçek ajan karşılaştırması aynı kanıt seviyesi değildir. Aynı araştırmanın üst sentezi ve alt paketleri bağımsız katkı olarak toplanmamalıdır.

'100→180→240–345' eğrisi ve +20/+30 beklentileri için tanımlı ölçü, karşılaştırılabilir baz veya deney yoktur. Bunlar daha sağlam yapı kuracağımıza güven dayanağı değildir ve bu arşivleme değerlendirmesinde geri çekilir. Doyumun gerçekleştiği de ölçülmüş değildir.

Bunun yerine sonraki araştırmanın değeri, mevcut karar veya belirsizlik üzerinde neyi değiştirdiğiyle incelenebilir: yeni seçenek, geçersiz varsayım, farklı hata yolu, daha iyi kanıt, gereksiz bileşeni eleme veya entegrasyon sınırı. Değer eklemeli olmak zorunda değildir; iki çalışma birlikte anlam kazanabilir. 'Üç benzer çalışma sonra dur' önerisi kabul edilmiş kural değildir. [U009–U010; S009–S010; Q01–Q02]

## 10. Son hedef ve bugün bulunduğumuz yer

Kullanıcının hedefi başka ürünlerden daha çok dosya veya özellik üretmek değil, araştırmayı sürdürülebilir bir çalışma kapasitesine dönüştürmektir. Bilinen açıkları kendi yapımızda tekrar etmemek, anlamın ve kullanılabilirliğin değişim boyunca korunması ve bu birikimin agent kullanımına gerçekten yansıması hedeflenir. Bu amaç EXP-001'in uzmanlık sürekliliği ve EXP-002'nin erişimden fazlasını taşıyan ortak entelektüel taban düşüncesini somut bir bilgi yaşamı sorusuna indirir.

Assistant'ın arşivleme sırasındaki sınanabilir yeniden ifadesi şudur: belirlenmiş kullanım, tüketici, süre, bütçe ve risk koşullarında; seçilmiş karşılaştırma örneklerinin maddi açıklarını hedefleyen; olumlu ve olumsuz örneklerle sınanan; kalan bilinmezlerini ve yeni entegrasyon risklerini açık tutan bir aday yapı geliştirmek. Bu, U011'in yerine geçen yeni kullanıcı kararı değildir; başarı iddiasının ileride nasıl daraltılabileceğine ilişkin öneridir.

Bugün böyle bir yapı kurulmadı. Karşılaştırmalı üstünlük, evrensel en iyilik, sıfır hata veya araştırma doyumu kanıtlanmadı. Bu konuşmanın gerçek çıktısı, hedefin belirginleşmesi ve araştırmayı nasıl kullanıp hangi anlam kayıplarından kaçınacağımızı tartışabileceğimiz bir zemin oluşmasıdır. Arşivleme bu zemini devredilebilir kılar; sonraki araştırma, tasarım, uygulama ve doğrulama ayrı çalışma kararlarıdır. [U011]
