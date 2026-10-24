# Concepts — Çalışma yöntemi

Sürüm: v0.3-working, 2026-09-19. Statü: iki konuşma içi pilot ve B2/B4 değerlendirmelerinden sonra seri çıkarım için seçilmiş, yeni bulgularla değişebilir başlangıç yöntemi. Evrensel yeterlilik veya bağımsız doğrulama iddiası değildir. Amaç CHARTER.md, kaynak talep ORIGIN.md, güncel aşama/yetki STATE.md, yürütme sırası PLAN.md içindedir. Bu proje yöntemidir; agent-control kaynağı AGENT.md ve tetiklenen protokollerdir.

## 1. Çalışmanın birimi ve kapsamı

İlk aşamanın birimi, bir terimin belirli bir araştırmada belirli bağlamdaki kullanımıdır. Sözcük tek başına kavram kimliği değildir. Önceden hazırlanmış terim listesi, ürün sınıflandırması veya evrensel katman şeması başlangıç filtresi yapılmaz. Kullanıcının su/agent/ürün/arayüz örnekleri bu korpusa başlangıç girdisi değildir.

Kaynak araştırmalar research/studies/ altında yerinde kalır. Koleksiyon ve alt çalışmalarının ilişkisi korunur; aynı dosya veya türetilmiş sentezler bağımsız destekler gibi sayılmaz. Taşınma işaretçisi ayrı araştırma değildir. Bununla birlikte her mevcut dosya kapsam envanterinde hesabı verilerek ele alınır; kaynak taşınma notu da bağlam bakımından okunur.

Yeni bir araştırmaya girerken:

1. Güncel main kimliğini ve ilgili dosya ağacını kaydet. CATALOG keşif içindir; gerçek dosya envanterinin yerine geçmez.
2. Paket META/STATE/INDEX üzerinden amaç, kaynak sınırı, araştırma tamamlanma durumu ve gerekli okuma yolunu geri kazan.
3. Araştırma kapsamındaki bütün dosyaların listesini oluştur; iç içe dosyalar, kanıtlar, kaynak kayıtları, yöntem/ilerleme dosyaları ve ekleri gözden kaçırma.
4. Dosyaları tam oku; önceki araştırmanın kavramlarını yeni pakete varsayılan anlam olarak taşıma. Kaynak-native dil ile önceki araştırma yazarının açıklama dili ayrıca ayrılır.

İndeks okumak tam paket okuması değildir. Baytların indirilmesi, araç çıktısının getirilmesi veya anahtar sözcük araması da tam okuma değildir. Araç çıktısı kesilmişse eksik aralıklar tamamlanır. Görsel/işitsel/binary eklerde erişilebilen temsil ve sınır açık tutulur; yalnız transkript erişimi tam ses incelemesi sayılmaz. Okunamayan materyal sessizce atılmaz veya tamamlandı işaretlenmez.

## 2. İki ayrı iz: okuma ve yorum

B4'te kararlaştırılan kalıcı çıkarım düzeni:

- concepts/studies/<kaynak-araştırma-yolu>/READING.md: dosya/sürüm envanteri, okuma aralıkları, eksikler, kaynak tarafından kapsam kontrolü ve devam noktası.
- Aynı alanda TERMS.md: bağlamlı kullanım kayıtları, kaynak-içi ilişki görünümü ve maddi yorum değişiklikleri.

Bu dizinler B5/B6 sırasında gerektikçe oluşturulur; B4 kararı dosyaların zaten mevcut olduğu anlamına gelmez. Büyük dosyalar kaynak/kullanım kimlikleri korunarak bölünebilir; tek dev dosya veya gereksiz dosya çoğaltma zorunlu değildir. Pilotların özgün terim çıktıları sohbet içinde kalır; kalıcılaştırma ayrıca §8'deki aktarım kontrolünden geçer.

Okuma kaydı en az kaynak repo/ref, dosya yolu, mümkünse blob SHA, gerçekten görülen aralık/temsil ve son tam okuma durumunu taşır. Tek dosya kısmen okunmuşsa son satır/bölüm nettir. Gözden geçirilmiş ile tam okunmuş ayrıdır. Dosya envanterinde bulunmak, içeriğinin okunmuş olması değildir.

Yorum kaydı ise aşağıdaki ayrımları taşır. Kolon adları esnektir; anlamların kaybolması esnek değildir.

| Kayıt ihtiyacı | Anlamı |
|---|---|
| Kullanım kimliği ve özgün ifade | Yazım, kısaltma ve adlandırma korunur. Kimlik bir kullanım kaydını adresler; kabul edilmiş kavram kimliği değildir. |
| Kaynak noktası | Repo/ref + dosya + bölüm/satır; kısa alıntı veya kaynak bağlantılı bağlam. Haricî asıl kaynak biliniyorsa ayrı bağlanır. |
| Söyleyen/katman | İncelenen yapının kendi belgesi, aktarılan dış kaynak, önceki araştırma yorumu veya yeni çıkarım yorumu. Bir araştırmadaki cümle otomatik olarak ürünün kendi tanımı değildir. |
| Bu bağlamda karşılık | Ne anlatıldığı; biliniyorsa kapsam ve komşu kullanımlarla ilişki. Kaynağın tanımıyla assistant açıklaması ayrı tutulur. |
| Kanıt ve belirsizlik statüsü | Açık kaynak ifadesi / bağlamdan yorum / çözülememiş. Tanım varlığı, tanımın evrensel doğruluğu değildir. Kaynağın olgusal doğruluğu bu etiketle sertifikalanmaz. |
| Önceki kayıtla ilişki | Aynı kullanımın ek kaynak noktası, ayrı anlam, aday benzerlik veya çelişki. Eş anlamlılık erken kabul edilmez. |
| Maddi değişiklik | Önceki yorum, yeni yorum, kısa gerekçe/dayanak ve etkilenen kayıtlar. Sessiz yeniden yazma yapılmaz. |

Bu iz bir ham düşünce günlüğü değildir. Denetlenebilir gözlem, sonuç, önemli alternatif, belirsizlik ve kısa gerekçe yeterlidir. Her küçük cümle için kayıt yükü üretmeden karar bakımından önemli anlam değişiklikleri korunur.

## 3. Okurken çıkarım yapmak

Kaynakta adı verilen teknik yapılar, roller, işlevler, süreçler, durumlar ve ilişkiler terim/jargon adayı olabilir; bunlar zorunlu kategori listesi değildir. Yalnız kullanıcı örnekleri veya yaygın AI sözcükleri aranmaz. Yeni ad üretmeden, karşılaşılan kullanım çıkarılır. Adlandırılmamış bir ayrım görülürse adsız gözlem olarak not edilebilir; birinci aşamada yeni evrensel kavram ilan edilmez.

Kayıt okuma sırasında yapılır. Her şeyi sonradan hafızadan çıkarmak veya yeni bir terim nedeniyle bütün paketi genel kavram araştırmasına çevirmek bu yöntemin dışındadır.

Aynı ifade farklı bağlamlarda farklı şeyleri anlatıyorsa kullanımlar ayrı tutulur. Aynı kullanımı tekrarlayan pasajlar kaynak noktaları eklenerek ilişkilendirilebilir. Aynı yazım, aynı anlam kanıtı değildir; farklı yazım da farklı kavram kanıtı değildir. Çeviri/kısaltma birleştirmeleri gerekçesiz yapılmaz.

Kaynakta açık tanım yoksa sırf tamamlamak için dışarıdan tanım eklenmez. Dış kaynağa dönmek, mevcut kullanımın kritik anlamını geri kazanmak için sınırlı bir kaynak okuması olabilir; genel tanım araştırması veya kaynak yapının canlı davranış testi olmaz. Daha büyük ihtiyaç açık soru olarak korunur.

Araştırmalar arasındaki olası eşleşme sonraki değerlendirme için işaretlenebilir, ancak bütün çıkarımlar bitmeden ortak tanım, global taksonomi veya yerel kabul kararı üretilmez.

## 4. Her turda çalışma belleğini geri kazanma

Tur başında güncel STATE, mevcut araştırmanın okuma/yorum kayıtları ve gerekli kaynak derinliği geri kazanılır. Yeni oturumda INDEX'in tam cold-start yolu izlenir. Eski sohbette hatırlanıyor olması kayıt veya kaynak okumaya eşdeğer değildir.

İki neden görünür tutulur: kullanıcı anlam seçimlerini okuma anında denetleyemiyor; ortak sözcükler aynı anlamı ve teknik doğruluğu garanti etmiyor. O turdaki önemli yorum/eksik/değişim varsa somut olarak açıklanır. Hatırlatma bir kontrol sonucu değildir.

Sonraki okuma önceki yorumu değiştirirse:

1. Yeni kaynak noktasıyla fark belirlenir.
2. Eski kaydın hangi kapsamda değiştiği kısa gerekçeyle işaretlenir.
3. Ona dayanan ilgili kayıtlar kontrol edilir; yanlış yorumun yayılımı bırakılmaz.
4. Etki henüz kontrol edilmediyse açık iş olarak taşınır; tüm düzeltme bitmiş sayılmaz.

Turu kapatmadan gerçekten okunan kapsam, üretilen/değişen kayıtlar, açık eksikler ve tam devam noktası görünür hale getirilir. Operasyonel sınır, kaydı ve handoff'u kaybetme gerekçesi değildir; bunun için pay bırakılır.

## 5. Tamamlanma ve değişen korpus

Bir araştırmanın terim çıkarımının tamamlanması şu koşullara bağlıdır: envanterdeki her dosyanın durumu açıklanmış; ilgili içerik tam okunmuş; kullanım kayıtları kaynaklarına bağlanmış; maddi yorum değişikliklerinin etkisi kontrol edilmiş; okunamayan kapsam açıkça çözülmüş olmalıdır. Terimin anlamının çözülememesi doğru kaydedilmişse bu, kaynağın okunmadığı anlamına gelmez.

Kaynak araştırmasının kendisi planlı veya kısmi olabilir. Mevcut dosyalarından çıkarım yapmak, o yapının tamamını bilmek değildir. Kaynak araştırmasının STATE'i ile concepts çıkarım durumu ayrı tutulur. İlgili tüm araştırma materyali okunur; henüz yapılmamış araştırma varsayılarak doldurulmaz.

Tamamlanma iddiasından önce envanter yeniden kontrol edilir. Eklenmiş/değişmiş dosyalar delta listesine alınır; eski kayıtlar yeni sürüme sessizce yükseltilmez. Sürüm kapsamı kullanıcı açısından maddi biçimde değişiyorsa aşama/kapsam kararı görünür kılınır. Okunamayan dosya veya bekleyen araştırma kapsamı yüzünden bilinmeyen şey, sıfır terim veya eksiksiz yapı bilgisi sayılmaz.

Bütün araştırmalar için ikinci aşama giriş kontrolü: kapsam sürümü açık; tüm paket/alt paketler hesaba katılmış; maddi yeni/değişmiş içerik işlenmiş; engeller kapatılmış veya açıkça yetkilendirilmiş kapsam kararıyla sınırlandırılmış; tüm çıkarım kayıtları okunabilir. Yalnız dosya sayısı veya terim sayısı başarı ölçütü değildir.

## 6. Yöntemi sınamak ve ikinci aşama

İki pilot, gösterim değil yöntem sınamasıdır. Kaynak tarafına geri dönüp çıktıdan bağımsız seçilmiş bölümlerde atlanmış kullanım, yanlış atıf, anlam birleştirme ve yorum değişimi kaybı aranır. Aynı assistant'ın ikinci okuması bağımsız doğrulama diye sunulmaz. Pilot sonrası değişmiş yöntem, aynı pilot tarafından geriye dönük doğrulanmış sayılmaz; ikinci pilot yeni bir sınama sağlar, evrensel yeterlilik kanıtı değil.

İkinci aşamada bütün çıkarımlar tam okunur; hangi anlamların ayrılacağı, hangi adların kullanılacağı ve nerede ortak kapsam kurulabileceği değerlendirilir. Örnek, karşı örnek, kapsam dışı durum, komşu kavram ve bağlama bağlı kullanım sınanır. Basitleştirme önemli ayrımları gizleyemez. Kullanıcıya gerekli somut ayrımlar açıklanır; onayı teknik uzman testi sayılmaz. Öneri, sınanmış açıklama, yerel kabul ve hâlâ açık durum ayrı kaydedilir.

İkinci aşamanın ayrıntılı kayıt şeması ilk aşama çıktıları oluşmadan dondurulmaz. Kaynak anlamı hiçbir yerel kabul nedeniyle değiştirilmez; mimari ve uygulama kararı ayrıca yetki/kanıt gerektirir.

## 7. İlk pilotun B2 değerlendirmesi — v0.2 açıklıkları

Bu bölüm ilk pilotun P1-T1/P1-T2/P1-T3 konuşma çıktıları ve kaynak taraflı kontrolünden doğmuştur. Sonradan açıklığa kavuşturulan kayıt yöntemi aynı veride bağımsız doğrulanmış sayılmaz. İlk pilotun kapanışı §5'in önceki koşulları ve kaynakla sınırlı çıkarım amacı üzerinden verilir; bu ek eksikleri gizleyen yeni bir başarı eşiği değildir.

### Kullanım ile ilişki düzenini birlikte korumak

Terim dökümü, araştırmanın kendi ayrımlarını ve ilişkilerini görünmez bırakmamalı. Kaynağın ortaya koyduğu ilişki düzeni kısa bir eşlik eden görünümde, kullanım kayıtlarına ve kaynak noktalarına bağlı tutulur. Bir konu araştırmasının ilişki çerçevesi zorunlu ürün mimarisi değildir; bir ürün araştırması da önceki pilotun şemasına zorlanmaz. Bu görünüm ayrı kalıcı dosya zorunluluğu veya erken araştırmalar-arası sentez yaratmaz.

### Kaynak rolü, açıklama statüsü ve niteleyiciler

Söyleyen/katman ile açıklamanın kesinliği ayrı izlenir. Önceki pilotun A/R gibi birleşik gösterimleri, dış kaynağa atfedilen kısım ile araştırma yazarının genişletmesini ayırmayı gerektirebilir. Yeni açıklama çıkarıcının bağlamsal yorumuyken doğrudan kaynak tanımı gibi yazılmaz. Kaynak yalnız ad sayıyorsa bu da kaydedilebilir; ayrıntılı tanım yokluğu görünür kalır.

Aynı satırda birkaç ad göstermek onların eş anlamlı olduğuna karar vermek değildir. Ayrı işlem veya farklı anlam oldukları kayboluyorsa satır/kullanım ayrılır. Faaliyet, tasarlanan nesne, tekil kayıt ve daha geniş düzen arasında aynı etiketin kullanımı özellikle korunur. Kaynaktaki olasılık, koşul, amaç ve doğrulanmış sonuç ayrımları özetlemede kaybolmaz; bir tasarımın amaçladığı güvenilirlik gözlenmiş başarı gibi sunulmaz.

### Kaynak taraflı kapsam kontrolü ve durma sınırı

Tam okumadan sonra kaynak bölüm, tablo, liste, örnek ve kaynak kayıtlarından döküme geri gidilir. Her ilgili bölümün karşılığı; mevcut kullanım, yeni/ayrılan kullanım, aynı kullanımın tekrarı, yalnız adı geçen kullanım veya açıklayıcı kaynak/örnek metadatası olarak hesabı verilir. Bu bir doğal-dil sözcüklerinin tamamına tanım üretme veya her örnek değerini bağımsız kavramlaştırma işi değildir. Ayrı kayıt gerekmeyen örnek değerleri ve kaynak adları, taşıdıkları teknik ayrım kaybolmadan bağlamında korunur. Bulunan maddi aktarım hataları ve eksikler kapanmadan sonraki pakete geçilmez.

Bir sonraki okuma yalnız terim hakkındaki genel bilgiyi artıracak, mevcut araştırmadaki kullanımın aktarımını değiştirmeyecekse ilk aşamaya eklenmez. Kaynağın tanımlamadığı/belirsiz bıraktığı kullanımı bu statüsüyle kaydetmek geçerli sonuçtur; bunu sırf belirsizlik var diye derin araştırma borcuna çevirme. Aynı biçimde kaynakta açıkça açıklanan bir şeyi atlamayı bu ilkeyle mazur gösterme.

Kapanış, incelenen dosya/sürüm kapsamında bağlamlı aktarımın yeterliliği hükmüdür; sektörün bütün kavramlarının çözümü veya hatasız/evrensel eksiksizlik sertifikası değildir. Sonradan somut atlama veya anlam bozulması bulunursa ilgili kayıt yeniden açılır; soyut biçimde daha fazlası olabilir diye bütün paketi sürekli açık tutma.

### Denemeler arasında taşınacak sınama

İkinci pilot v0.2-draft'ı farklı araştırma düzeninde sınadı. Özellikle atıf–yorum ayrımı, aynı adın farklı kullanımı, kaynak-içi ilişki görünümü, dosya kapsamı ve kapanış sınırı incelendi. İlk pilotun iyi görünen çıktısı ikinci pilotun başarı kanıtı değildir. Gerçek yeni-oturum deneyi ve bağımsız aktör incelemesi yapılmış sayılmaz. B4'ün sonucu aşağıdadır; pilot içeriklerinin özgün taşıyıcısı hâlâ konuşmadır.

## 8. İkinci pilotun B4 değerlendirmesi — v0.3 ve kalıcı kayıt kararı

Dayanak: Superpowers araştırma paketinin 75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847 sürümündeki 52 dosyasının P2-T1–T4 okumaları ve P2-T5 kaynak taraflı kapsam kontrolü. Yeni upstream araştırması veya ürün deneyi yapılmadı. Not, kaynak kaydı, betik, sonuç ve sentez aynı kanıt zincirinin bağımlı yüzeyleri olarak karşılaştırıldı. Ana amaç, iki aşama sırası ve §5/§7 kapanış ölçütü değişmedi.

### Gözlenen ihtiyaçlar ve sınırlı düzenleme

1. **Kaynak rolü ile ifadenin niteliği ayrı okunmalı.** Bir araştırmada ürün talimatı, kod gözlemi, yerel deney, kamuya açık geçmiş rapor, başka study'den aktarım ve araştırmacı sentezi birlikte bulunabiliyor. Kayıtta kimin/hangi sistemin kullanımı olduğu ile bunun tanım, talimat, gözlem, rapor veya yorum oluşu ayrı belirtilir. İki bilgi tablo kolonu veya kısa açıklama olabilir; her satır için ağır bir sınıflandırma sistemi zorunlu değildir. Araştırmanın ilgili dosya/bölümünü göstermek, atfedilen dış kaynağı bu tur yeniden okuduğumuz anlamına gelmez.
2. **Birlikte gösterilen farklı kullanımlar ayrı adreslenebilir olmalı.** Hook ile event registration, task ile step veya farklı clean durumları karşılaştırma için aynı tabloda durabilir. Farklı nesne/işlem olduklarında ayrı alt kimlik veya ayrı kayıt alırlar. Ortak satır, eş anlamlılık kararı değildir. Eski pilot kimlikleri silinmez; alt kayıtlar ve değişikliğin kapsamı onlara bağlanır. Kimlik sayısı kavram sayısı değildir.
3. **Etiket nitelediği nesne ve koşulla taşınmalı.** Mandatory, read-only, complete, PASS, accepted, clean, digest ve benzeri ifadelerde ilgili aktör/rota/nesne/sürüm/ölçüt veya kaynak sınırı korunur. Bunların hepsi için evrensel alan şeması dayatılmaz. Örneğin bootstrap istisnası bütün davranış kurallarından muafiyet; SDD'nin no-child talimatı bütün agent sistemlerinin özelliği değildir.
4. **Adlandırılmış fakat açıklanmamış içerik de hesabı verilmiş sonuçtur.** Teknik olay/alan adı, yöntem adı, ürün/bağımlılık adı ve sadece örnek değeri birbirinden ayrılır. Kaynakta bağımsız genel tanım yoksa o eksiklik açık kalır; kaynakta verilmiş yerel anlam ise atlanmaz. Kontrol, bütün doğal dil sözcüklerine tanım yazmaya veya her bağımlılığı yeniden araştırmaya dönüşmez.

Bu düzenlemeler, pilotun kaynakla karşılaştırmasında oluşan yöntem geliştirme sonucudur. V0.3'ün bütün gelecek korpuslarda bağımsız olarak doğrulandığı veya yeni oturumlarda drift'i engellediği iddiası yoktur. Başka bir yöntem pilotunu otomatik başlatmak yerine B5/B6'da uygulanır; somut sorun çıkarsa gerekçeli revizyon yapılır.

### Kalıcı düzen ve pilot aktarımı

B5'te concepts/SCOPE.md oluşturularak research/studies'in gerçek paket/dosya kapsamı, koleksiyon/alt çalışma/taşınma ilişkileri ve sürüm değişimleri kaydedilir. Bu dosya B4 sırasında henüz oluşturulmuş değildir. Global STATE, etkin paket ve sıradaki işi taşır; bütün terim veya her turun okuma günlüğünü ikinci kez kopyalamaz.

Her araştırmanın READING.md dosyası kaynak kapsamını, TERMS.md dosyası bağlamlı kullanımları ve kısa ilişki görünümünü taşır. Kalıcı kayıt en az kullanım kimliği, özgün ifade, kaynak noktası, kaynak rolü/ifade niteliği, bağlamdaki karşılık-sınır ve önceki kayıtla ilişkisini görünür kılar. Madde veya tablo biçimi, kaynak malzemesine göre seçilebilir. Yalnız adı geçenler ayrı bir bölümde korunabilir. Kaynak/alan kodları başta açıklanır; kapalı bir jargon listesi dayatılmaz.

Pilotlar baştan yapılacak yeni araştırma sayılmaz. B6'da kalıcılaştırılırken görünür P1-T1–T3 ve P2-T1–T5 çıktıları kaynak sürümleri ve düzeltmeleriyle birlikte kontrol edilir. Özgün yanıt erişilemiyorsa STATE özetinden terim uydurulmaz; gereken kullanım sabit kaynaktan yeniden çıkarılır ve bu yeniden üretim açıkça belirtilir. Kaynak değişmişse delta ayrı işlenir. Pilot kapanışı, kalıcı dosyanın zaten yazıldığı veya seri çıkarımın tamamlandığı anlamına gelmez.

ORIGIN ve SETUP-REVIEW hazırlık döneminin kaynak/tarihsel kayıtlarıdır. CHARTER amaçtır. METHOD yöntem, PLAN sıra, STATE güncel durumdur. Kaynak araştırmaların kendi kontrol/ilerleme dosyaları inceleme malzemesi olarak kalır; genel araştırma veya mimari yetkisi üretmez.
