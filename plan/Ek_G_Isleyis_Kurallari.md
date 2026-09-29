# Ek G — Ayrıntılı işleyiş kuralları

**Sürüm:** 1.0 · **Tarih:** 29 Eylül 2026 · **Statü:** [Öneri]. İlgili aşamalarda uygulanır; kuralların çalıştığı Ek C'deki testlerle gösterilir.

**Kaynak:** P4 v4 raporu §8.4, §9.3, §11.3–11.5, §12, §15, §16, §17, §18.2–18.3, §19; Claude Code cloud, Supabase ve GitHub'a uyarlandı.

---

## G1. Bağlam paketinin bayatlaması ve yenilenmesi

1. **Önbellek anahtarı** yalnız soru metni değildir. Şunları içerir: iş ve kullanım türü, hedef ve kaynak revizyonları, izin görünümü, rol sınıfı ve kapsam, ortak kurallar ile rol ve yöntem sürümleri, arama dizini ve anlam modeli sürümü.
2. **Bayatlatan olaylar:** Anahtardaki herhangi bir öğe değişince paket `stale` olur. Yalnız süreye dayalı bayatlama kullanılmaz; süre, kayda girmemiş değişikliklere karşı ek bir üst sınırdır.
3. **Yeniden derleme sırası:** Önce kullanım türü belirlenir; sonra zorunlu ihtiyaçlar ve izinler; sonra aday kaynaklar (kimlikle doğrudan erişim, kelime ve anlam araması, ilişki komşuları); aday küme önce yetki süzgecinden, seçimden sonra yeterlik incelemesinden geçer. Sonuç yeni bir paket revizyonudur; sessizce değişen bir istem değildir.
4. **Kaynak bulunamazsa** eksik kaydı oluşur. Tamlık gerektiren kabul işi durur; eksiği giderecek keşif başlayabilir.
5. **Bütçe daralırsa** önce tekrar eden ve karar değeri düşük içerik azaltılır. Zorunlu karşı kanıt ve yetki sınırı yer kazanmak için çıkarılmaz. Yetmezse iş bölünür ya da okuma aşamalara ayrılır.
6. **Oturum sıkıştırması ya da yeniden başlama sonrası** geçmiş konuşma en kısa özete indirgenmez; güncel amaç, yetki, açık kararlar, beklenen katkılar, gerçekleşmiş dış etkiler ve kaynak erişim yolu veritabanından yeniden kurulur ve yeni bir paket türetilir. Eski paketin kabul edilmiş olması yeni üstlenme ya da yeni politika için kabul edilmiş olduğu anlamına gelmez.
7. **Görünürlük sınırı:** Claude oturumu kendi sistem talimatını, konuşma geçmişini ve araç sonuçlarını da bağlama katar. Bu yüzden "paket doğruydu" ile "model yalnız bu girdiyi gördü" ayrılır; tam girdi gözlenemiyorsa bağımsızlık iddiası buna göre daraltılır.

## G2. İlişki sorgularının tamlığı

1. **İki ayrı hizmet:** `affected_entities` yetkili bir anlık görüntü üzerinde etkilenen **benzersiz** kayıtları ve her biri için en az bir açıklayıcı yolu döndürür. `explain_paths` yalnız açıkça istendiğinde, yol sayısı ve derinlik sınırıyla çalışır. Günlük bayatlatma akışı yol sayan sorguyu kullanmaz (F04).
2. **Tamlık bayrağı:** Sınıra ulaşan her sonuç `complete = false` taşır. Tam olmayan bir sonuçla "başka etkilenen kayıt yok" ya da "engel yok" denmez. Kısmi olumlu sonuç inceleme başlatabilir; olumsuz hüküm tam sonuç ister.
3. **Sınırlar sorgunun içinde uygulanır.** Dış sorguya yalnız satır sınırı eklemek, alttaki sorgunun büyük bölümünü çalıştırabildiği için yürütme bütçesi sayılmaz.
4. **Yetki:** Kök kaydın varlığı ve erişim yetkisi denetlenir; görülemeyen düğümlerin adları ya da içerikleri sonuçta sızdırılmaz. Görülemeyen bölge tamlığı sınırlıyorsa bu, içerik açıklanmadan belirtilir. Güvenli bir "bilinmiyor" ile yanlış bir "yok" aynı değildir.
5. **Canlı değişim:** Sorgu sonucuyla doğrudan dış etki yapılmaz; etki fonksiyonu güncel koşulları yeniden denetler.
5a. **Devam:** Sınırlı bir sorgunun devamı aynı anlık görüntüye (revizyon, politika, kalan arama sınırı) bağlıdır. Bu arada veri değişirse devam bilgisi geçersiz olur ve sorgu açıkça yeniden başlar; farklı anlık görüntülerden gelen parçalar birleştirilip "tam" denmez.
6. **İlişkilerin dışına bakma:** İlişki kaydı kayıtlı bağları bulur, kayda girmemiş anlam etkisini bulmaz. Büyük ürün değişikliklerinde ilişki sorgusunun yanında etkilenen parçalar ayrıca okunur. Kayıtlı ilişki eksikliği bir bakım bulgusudur, "anlam ilişkisi yok" hükmü değildir.

## G3. Yayın ve kesinti pencereleri

Git'teki değişiklik ile veritabanındaki kayıt tek bir işlem değildir. Her kesinti penceresi ayrı ele alınır:

| Pencere | Durum | Yapılacak |
|---|---|---|
| 1. Niyet kaydından önce | Yetkili işlem kaydı yok; aday içerik olabilir | Aday içerik korunur; yeniden başlanır |
| 2. Niyet kaydından sonra, PR'dan önce | İşlem var, dış etki bilinmiyor | Önce GitHub'da dal ve PR aranır; yoksa devam edilir |
| 3. PR açıldıktan ya da birleşme denendikten sonra, sonuç kaydından önce | **En tehlikeli pencere** | Yeni bir deneme yapılmadan önce GitHub'dan gerçek durum okunur (PR durumu, `main`'in güncel commit'i, birleşme commit'i). Gözlem kaydedilir, sonra karar verilir |
| 4. Sonuç kaydından sonra, tüketiciden önce | Olay ve tüketici tekrarları | Tüketiciler tekrarları aynı kimlikle tanır; ikinci etki üretmez |
| 5. Tüketiciden sonra, kullanıcı tesliminden önce | Teslim bildirimi | Teslim ve kullanım ayrı gözlenir |

**İzin geri çekilme yarışı:** Zorunlu kontroller birleşme anında kendiliğinden yeniden koşmaz; kontrolün geçtiği an ile birleşme arasında veritabanındaki izin ya da dönem değişebilir. Bu yüzden birleştirmeyi tek sıradaki yayın işi yapar ve birleştirmeden hemen önce güncel izni ve dönemi yeniden okur (plan 6.8). Kalan pencere (yeniden okuma ile GitHub'daki birleşme arasındaki süre) ölçülür ve yazılır; sıfırlanamaz, çünkü veritabanı ile GitHub tek bir işlemde değildir.

**Telafi:** Geri alma her zaman gerçek geri alma değildir; yayımlanmış içerik görülmüş olabilir. Telafi yeni bir yetkili işlem olarak kaydedilir; tarihçe silinmez.

**Belirsiz etki:** Güvenli bir gözlem yolu yoksa sistem "oldu" ya da "olmadı" diye tahmin yapmaz; durur, kapsamlı bir toparlanma işi açar ve Batu'yu yalnız gerçekten gerekiyorsa sürece katar.

## G4. Uzun ve bileşik ürünler

1. **Bileşik ürün anlık görüntüsü:** Hangi parçanın hangi revizyonla, hangi sırada, hangi tasarım niyetine göre bir bütün oluşturduğu kaydedilir. Tasarım hali, çalışma hali ve teslim hali ayrıdır; birindeki değişiklik diğerinin gerçekleştiği anlamına gelmez.
2. **İki okuma kipi:** Tasarımı bilen inceleme uygulamanın tasarıma uyup uymadığını; yalnız ürünü okuyan inceleme okurun ürünün kendisinden neyi görebildiğini sınar. Tasarım bilgisinin erken görünmesi, metnin aslında kurmadığı bir bağı incelemecinin zihninde tamamlatabilir; bu yüzden ikinci kipte tasarım gösterilmez. İki hüküm tek puana indirgenmez.
3. **Okuma geçişi kaydı:** Hangi anlık görüntünün, hangi aralıklarının, hangi soruyla okunduğu, açık kalan konular ve durma noktası. Önceki okuma yeni anlık görüntüye sessizce taşınmaz.
4. **İtiraz türleri:** Bir incelemecinin kaygısı doğrudan düzeltme emri değildir. Önce türü belirlenir: olgusal ya da teknik kusur (onarım ister), kaynak yetersizliği (ek kanıt ister), tercih farkı (yetkili karar ister), kapsam çatışması (üst amacı yeniden açabilir).
5. **Karar sürekliliği:** Aynı tercih tartışması yeni bilgi olmadan dönüyorsa önce mevcut karar geri çağrılır. Yeni kaynak ya da değişen hedef ise eski kararı koruma içgüdüsüyle dışlanmaz.
6. **Bütünsel kabul:** Parça testleri ve bağlantı kontrolleri büyük bir ürünün etkisini doğrulamaz. İddia gerektiriyorsa bağımsız okur ya da alan uzmanı değerlendirmesi gerekir; bu yapılamıyorsa iddia sınırlanır.

## G5. Yeniden açma, iptal, yeniden atama ve kilitlenme

1. Bir kararın dayanağı değiştiğinde etkilenen işler **aday inceleme kümesine** alınır; hepsi otomatik yanlış ya da iptal sayılmaz. İnceleme, önceki çıktının hangi kullanımda hâlâ geçerli olduğunu belirler.
2. İptal edilmiş ya da süresi dolmuş üstlenmenin geç sonucu aday kanıt olarak saklanır; güncel ürüne karışmaz.
3. İptal komutunun gönderilmiş olması, dış etki yolunun gerçekten durduğu anlamına gelmez; gözlemle doğrulanır.
4. **Yeniden atamada** önce yetkili sonuç nesnesine, talep bağına ve son gönderim kaydına bakılır: sonuç üretilmişse tüketici incelemesine geçilir; yoksa yeni üstlenme açılır. Aynı araştırma körlemesine tekrarlanmaz.
5. **Döngü ve kilitlenme:** A'nın B'yi, B'nin de A'nın henüz üretmediği kararı beklediği durumda önce bunun gerçek bir bağımlılık döngüsü mü, bilgi talebi mi, hatalı biçimlenmiş talep mi olduğu ayrılır. Nihai karar yerine sınırlı bir taslak ya da açık varsayım istemek döngüyü açabilir; bu değişiklik yetkisiz varsayımı gerçek yapmaz.

## G6. Kurtarma sırası

1. **Eski yolların kapatılması:** Eski projedeki routine'ler durdurulur; eski ortam belirteçleri iptal edilir; yayın işi güncel yetkiyi yeni projeden okuyacak biçimde yeniden bağlanır. Eski sistemin erişilebilir kalması, ortak dış hedeflere (GitHub) etki üretebilmesi anlamına gelmemelidir; kabul testi bunu eski sistem açıkken dener.
2. **Kurtarma envanteri:** Yedeğin kimliği ve şema sürümü, ürünün Git commit'leri, kaynak ve kanıt gövdelerinin listesi, güncel izin ve politika, bekleyen dış etkiler, açık üstlenmeler ve talepler. Envanter tek bir tutarlı anlık görüntüyü garanti etmiyorsa tutarlılık sınırı yazılır ve hangi kayıtların hangi okumayla uzlaştırılacağı belirtilir. Yeniden üretilebilir veri (vektörler, içe alınmış kütüphane) kaynak commit'i ve model sürümünden yeniden üretilir.
3. **Yeniden bağlama:** Ortamlar, routine'ler, CI ve yedek işi yeni projenin adresine ve yeni belirteçlere bağlanır (Batu'nun adımları plan Bölüm 12).
4. **Her aktif iş için üç sonuç:** aynı amaçla yeni üstlenmeyle devam; eldeki aday sonucu yeni kaynak ve yetkiyle inceleme; artık geçerli olmayan işi gerekçeyle iptal.
5. **Kademeli açılma:** Önce yönetim ve gözlem yolları; sonra kaynak ve politika erişimi ile salt okuma görünümleri; sonra düşük etkili keşif ve aday üretimi; en son yayın. Güncel saklama politikası arama ve bağlam hizmeti açılmadan önce yeniden uygulanır.
6. **Başarı ölçütü:** Doğru amaç, kalan işler, geçerli yetki, kaynak ve gerçek dış etki durumunun geri kurulması; eski yetkiyle ve eski sistemden iş yapılamaması; doğru yeni işin ilerleyebilmesi. Her şeyi reddeden sistem güvenli ama yeterli değildir.

## G7. Bozulma halleri

Bozulma normal çalışma gibi raporlanmaz; hangi güvencelerin korunduğu ve hangilerinin askıda olduğu görünür olur.

| Durum | Devam eden | Duran | Görünürlük |
|---|---|---|---|
| Anlam araması kullanılamıyor | Kelime ve ilişki araması, kimlikle doğrudan erişim | Anlam araması gerektiren keşifler eksik kabul edilir | Bağlam paketlerinde "anlam araması yok" notu |
| Supabase'e erişilemiyor | Oturum yalnız kendi yerel çalışmasını aday olarak dala yazıp kapanış notunu bırakmaya çalışır | Üstlenme, durum geçişi, dış etki | Oturum kapanır; bir sonraki zamanlanmış oturum erişim döndüğünde toparlanmayı başlatır |
| Routine sınırı doldu | Açık oturumların işleri | Yeni oturum başlatma | Sınır kaydı ve Batu'ya görünür bekleme |
| Routine GitHub bağlantısı koptu (72 saat sonra routine kendini kapatır) | Diğer routine'ler | O routine'in oturumları | Bağımsız izleme yolu son oturum zamanını denetler ve Batu'ya issue açar; Batu GitHub bağlantısını yeniler ve routine'i yeniden açar |
| GitHub Actions dakikaları bitti | Oturumlar | Yedek ve içe alma işleri | Bağımsız izleme yolu son yedek ve içe alma zamanını denetler; seçenekler bedeliyle Batu'ya |
| Oturum süresi beklenenden kısa | Parçalı iş ve yapılandırılmış devir | — | Kullanım raporu; yedek bütçeden ek çalışma oturumu |
| Sessiz başarısızlık (kontroller yeşil, iş yanlış yönde) | Her şey | — | Haftalık örneklem denetimi; bulunursa sistem incelemesi ve başarısızlık sınıfı kaydı |
| Claude kullanım hakkı doldu | — | Bütün oturumlar | Kayıtlı bekleme; hak yenilenince bir sonraki zamanlanmış oturum devam eder. Bu sınır Batu'nun kendi Claude kullanımıyla paylaşılır; etkisi kullanım raporunda görünür |
| GitHub'a erişilemiyor | Veritabanı üzerindeki keşif ve aday çalışma | Yayın ve PR'lar | Bekleyen işlemler pencere 2 ya da 3'te toparlanır |
| İkinci model kullanılamıyor | Her şey | İkinci görüş | İlgili kararlara "ikinci görüş alınamadı" notu |

## G8. Yöntem birleşimleri ve kendi kurallarını değiştirme

1. Tek başına yararlı iki yöntem birlikte zararlı olabilir. Örneğin biri bağlamı sıkıştırır, diğeri her iddiayı kısa bir güvence cümlesine çevirir; birlikte koşulları ve karşı kanıtı kaybettirirler. Etkin yöntem kümesi ve uygulanma sırası da sınanan bir nesnedir.
2. Yöntem değişince sınav aynı kalıp yalnız eski hatalara duyarlı hale gelmiş olabilir. Sınavlar değişikliğin etkileyebileceği yeni hata sınıflarıyla tazelenir. Daha az bulgu, daha az hata anlamına gelmeyebilir; inceleyicinin körleşmesi ayrıca değerlendirilir.
3. DevOS'un kendi kontrolünü ya da değerlendirme ölçütünü değiştirmesi sıradan bir ürün değişikliği değildir. Geçemediği ölçütü kendi yetkisiyle kolaylaştırıp aynı sonucu yeni ölçütle doğrulanmış sayamaz. Değişiklik meşru olabilir; o durumda eski sonuç keşif niteliğinde kalır ve yeni ölçüt yeni kanıtla sınanır. Kontrol, yetki ve politika değişiklikleri yüksek etkili değişikliktir.

## G9. Kapasite ve iş sınıfları

1. Kapasite tek bir sayıya indirgenmez; keşif gecikmesi, üretim kalitesi, inceleme maliyeti, kaynak erişimi, yayın sırası ve kurtarma yükü birbirini etkiler.
2. İş sınıflarının ayrı kabul profilleri vardır: kısa doğrudan sorgu, derin araştırma, büyük bileşik ürün incelemesi, uzun üretim, yüksek etkili yayın, kurtarma.
3. Öncelik düzeni kurtarmayı her zaman baskın yaparak normal işleri aç bırakmaz.
3a. **Routine bütçesi:** Günde 15 çalışma sınırı plan Bölüm 6.4'teki tabloya göre dağıtılır; oturum süresi ölçümü ve kullanım gözlemi bütçeyi gerekçeyle değiştirir. Bütçe aşılacaksa önce çalışma düzeninin kendisi sorgulanır (plan 6.12); sonra seçenekler Batu'ya gelir.
3b. **Döngü sınırları:** Her iş döngüsünün üst sınırı, emek bütçesi ve "ilerleme yok" tespiti vardır; tetiklenen döngü durur ve kaydedilir.
4. **Ölçülenler:** Mekanik (üstlenme çatışmaları, bayat yeniden taban oranı, talep dönüş gecikmesi, sorgu eksikliği, yayında belirsiz kalma süresi, kurtarma sonrası eski yetkinin reddi) ve iş değeri (maddi eksik keşfi, gereksiz önkoşul oranı, tüketilen araştırma katkısı, bütünsel ürün kusuru, Batu'ya taşınan teknik yük, yöntem aktarımında gerileme). Bunlar tek puanda toplanmaz. Eşikler ölçüm öncesi yazılır.

## G10. İş listesi hijyeni

Kendisiyle meşgul bir düzen büyüyen bir iş listesi üretir. Bakım işleri düzenli olarak şunları işaretler: hiçbir üst amaca bağı kalmamış işler, uzun süredir ilerlemeyen işler, yalnız başka bakım işlerine hizmet eden işler. Her işaret Batu'ya değil, koordinasyon rolüne bir karar olarak gider; göreve hizmet ettiğini gösteremeyen iş gerekçeyle kapatılır (süreç sınırı, plan K-10).
