# EXP-004 / DQ02 — Keşif yöntemini seçmek ve ortak körlükleri sınamak

**Tarih:** 2026-09-21. **Tür/statü:** DQ01 sonrasındaki kaynak-beslemeli kavramsal devam; karşılaştırmalı çıkarımlar, çalışma hipotezleri ve ileride sınanacak davranış ihtiyaçları. Tam konuşma transkripti, T16 koşusu, canlı deney, kabul edilmiş mimari veya kurulmuş SOUL yeterliği değildir.

**Başlangıç main:** `06dcefc2f192cb0cd4eb216d3f3194c2bfa48269`. **Yetki özeti:** Kullanıcı önceki cevapta repository araştırmalarının kullanımını sordu; doğrudan kullanımın ağırlıkla EXP-004 ve seçici RPD olduğu açıklandı. Ardından kavramsal çalışmaya devam yönü verdi. Bu tur ilgili Foundation ve studies sonuçlarını doğrudan karşılaştırır; yazma yalnız EXP-004 içindedir. Önceki dar kullanımın nedeninin bağlam dolması olduğu doğrulanmış bir teşhis değildir. Foundation/studies araştırmaları yeniden açılmaz; ürün veya benchmark kampanyası başlatılmaz.

## 1. Devralınan açık soru ve bu turun cevabı

[DQ01](DQ01-UNSIGNALED-NEED-DISCOVERY-AND-CAPABILITY-QUALIFICATION.md), işaret edilmemiş ihtiyacı keşfetmeyi ve karşılayabilme iddiasını ayırdı. Açık kalan soru: SOUL bir alanda yeterliği belirsizken hangi keşif/değerlendirme yaklaşımını seçer; seçilen yolların aynı körlüğü paylaşmasını makul maliyet altında nasıl sınar?

**Yeni çalışma hipotezi:** SOUL'un ilk seçim birimi bütün işi çözeceği varsayılan yöntem veya uzman etiketi değil, mevcut amaç ve kullanım açısından gerekçelendirilebilen bir bilgi edinme/inceleme adımı ya da birbirini tamamlayan sınırlı adımlar olabilir. Seçim, hangi belirsizliği veya görünmeyen ilişki alanını açabileceğini, hangi sonucun hangi kararı değiştireceğini, fiilen uygulanabilirliğini ve neyi gösteremeyeceğini taşımalıdır. Yeni bulgu yalnız alt görevi değil, ilk soru ve yöntem seçimini de değiştirebilir.

Bu tek zorunlu pipeline değildir. Keşif, üretim ve değerlendirme iç içe ilerleyebilir. Her basit işte ayrı araştırma dosyası veya yeni aktör kurulması gerekmez. Aşağıdaki açıklama, bu davranışın gerçekten başarılabildiği iddiası değildir.

## 2. Araştırmalar düşünceyi nerede değiştirdi?

| Doğrudan geri çağrılan çalışma | Bu soruya taşıdığı ayrım | DQ02'de değişen vurgu |
|---|---|---|
| Foundation Formation / Acquisition, F2 | Kayıtları işlemiş olmak bütün ilgili kaynakları gözlemek değildir; aynı kayda dönüşen alternatifler hedefe göre ayırt edilemeyebilir. | Kontrol sayısından önce gözlem fırsatını ve ayırt edilecek farkı soruyoruz. Bilinmeyen kapsam için tamamlık yüzdesi üretmiyoruz. |
| Foundation Selection/Dynamics, I1–I4 | Yeterli bir görünümün varlığı ile herhangi bir görünümün erişilebilirliği yetmez; uyumlu ortak görünüm veya izinli strateji gerekir. Sistem içindeki parçaların toplamı tek tüketicinin gerçek bilgisi değildir. | Bir yöntemin, kaynağın ve aktörün ayrı ayrı varlığından uygulanabilir inceleme çıkarmıyoruz. Aynı gerçek çalışma yolunda birleşebilmelerini soruyoruz. Bu kapasite birleşimine aktarım bizim çıkarımımızdır. |
| Work Management / Project Control, METHOD ve U10 | Farklı iş koşulları farklı yönetim temsilleri gerektirebilir; görev listesi, başlama, kabul ve sonuç ayrı. Araştırma bütün yöntemlerin birleştirilmesini önermiyor. | Evrensel keşif ağacı seçmek yerine mevcut işin belirsizliğine göre yöntem seçimini, geçici keşiften sonuca dönüşü ve bekleyen sorumluluğu öne alıyoruz. |
| gstack testing/eval sentezi ve özgün structural floor testi | Test varlığı, seçimi, yürütmesi ve oracle kapsamı aynı şey değildir. Okunan floor kaynak dosyası dosya/biçim kontrolleri yapar, LLM davranışı çalıştırmaz. | Keşif yöntemini yazmak veya test adını kaydetmek yerine gerçekten hangi davranışın ve hangi sonucun değerlendirildiğini koruyoruz. |
| Hermes U15 / Note30 ve özgün skill_view wrapper'ı | Başarılı yükleme kullanım sayacını artırabilir; bu görevde etkili kullanım veya kalite ölçümü değildir. | Yöntem/skill edinme, çağrıya ulaşma, fiilî uygulama ve yararlı sonuç ayrı kabul yükleri olarak kalıyor. |
| Aynı oturumda seçici okunmuş RPD değerlendirmesi | Hedefin gereği ile yolun gereği; bitmemiş keşif ile sonuç; başlangıç zemini ile hazır ürün farklı. | Yeni belirsizlik otomatik yeni altyapı gereği yapılmıyor; keşif ana ihtiyaca dönmek zorunda. Özgün RPD ekleri bu tur da geri edinilmedi. |

Bu kaynaklar eşit türde kanıt değildir. Foundation'ın sonlu yapıları doğal dil yeterliği deneyi değildir; studies sentezleri asıl dış kaynağın yerine geçmez. gstack ve Hermes'in yük taşıyan iki dar kod noktası bu nedenle kendi araştırma pin'lerinden yeniden açıldı. Güncel ürün davranışı, bütün bağımlılıklar veya gerçek model başarısı doğrulanmış sayılmaz. Ayrıntılı kapsam §12'dedir.

Foundation [DISCUSSION-HANDOFF](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md) ayrıca önceki soru-bankası tartışmasında üretim tarafının eksik ele alındığını, sahibin müdahalesinin gerektiğini kaydeder. Bu türetilmiş konuşma kaydı, bilgi mevcutken onu zamanında kullanmanın ayrı sorun olduğunu gösteren proje içi örnektir; bütün nedeni belirleyen bağımsız deney değildir. Müdahaleyi SOUL'un kendiliğinden keşif başarısı diye sayamayız.

## 3. İki farklı keşif durumu: henüz soru yok ve ayırt edilecek soru var

**Henüz hangi sorunun eksik olduğunu bilmiyoruz.** Yalnız mevcut soru listesiyle aramak, liste dışındaki koşulları bulmaya yetmeyebilir. Aday başlangıç; amaçlanan sonucun üretim, kullanım, etkileşim ve değişim içinde nasıl oluşacağını incelemek, mevcut planın açıklamadığı bağlantıları aramak ve ilgili alan kaynaklarına bu ihtiyaç üzerinden dönmektir. Foundation burada karşı bakış sağlayabilir; bütün gelecekteki ihtiyaçları kapsadığı varsayılmaz. İlgili bir alan kaynağı veya yetkin kişi soruyu değiştirebilir; fakat erişimi ve katkısı gerçekten mevcut olmalıdır.

**Artık bir belirsizlik veya rakip açıklama var.** Bu kez daha hedefli sorulabilir: Hangi gözlem veya inceleme bu açıklamaları birbirinden ayırabilir? Aynı yanlış/sağlam varyanta aynı cevabı verecek bir yol, o ayrım için yeterli değildir. F2'nin sonlu argümanı bunu bildirir; gerçek alandaki bütün olası durumları ve gözlem modelini bildiğimiz sonucunu vermez.

Bu iki durum zorunlu aşamalar değildir. Kaynak boyunca okuma yeni soruyu doğurur; hedefli karşılaştırma ilk çerçevenin yanlış olduğunu gösterebilir; üretim sırasında daha önce düşünülmemiş bir koşul açılabilir. Bütün hipotezleri baştan listelemek gerekmediği gibi, açık uçlu keşfin her tur sınırsız sürmesi de gerekmez.

**Aday duruş:** Bilinen belirsizliklere yönelik incelemenin yanında, mevcut çerçevenin dışını açabilecek orantılı bir kaynak/kullanım karşılaşmasına yer bırak. Bunun kapsamı etki, değişiklik, alan tanışıklığı ve kaynakla gerekçelendirilir; sabit yüzde, evrensel kontrol listesi veya bütün alanları tarama kuralı seçilmez. Henüz bilinmeyenlerin tamamı için ölçülmüş kapsama sahipmiş gibi konuşulmaz.

## 4. Yöntem seçimini somutlaştıran soru

Bir aday için şu ilişki açıklanabilir:

> Bu inceleme, şu amaç/kullanım bakımından şu belirsizliği azaltabilir veya şu görünmeyen ilişki alanını açabilir; şu sonuçta mevcut kararı koruruz, şu sonuçta kaynak/yöntem/kapsamı değiştiririz; eldeki aktör, bilgi, ortam ve yetki bunu şu sınırda yapmaya elverişlidir.

Bu bir kayıt şeması değil, kararın gerekçe yüküdür. İhtiyaç zaten açık ve mevcut yöntem yeterliyse araştırmayı yeniden kurmaya gerek yoktur.

İlk adımın tam işe yeterliği kanıtlanmış olmak zorunda değildir; DQ01'in denemeye değer aday ile kullanıma kabul ayrımı sürer. Bununla birlikte bir inceleme sırf keşif diye etkisiz/zararsız sayılmaz: özel metni dışarı göndermek, gerçek insanlardan katkı istemek, bütçe kullanmak veya üretim durumunu değiştirmek ayrıca izin ve koşul gerektirebilir. Gerçekte erişilemeyen uzman, araç veya veri yapılabilir planın parçası sayılmaz.

Selection I1/I2'den aktardığımız birleşim sınırı önemlidir: uygun metin bir yerde, uzman başka yerde, yöntem üçüncü yerde bulunabilir; bunları bir araya getiren izinli ve zaman bakımından mümkün yol yoksa inceleme henüz uygulanabilir değildir. Tersine, tüketicinin mevcut geçerli bilgisi yeterliyse her şeyi yeniden göndermek gerekmez. Bu, ayrı bir zorunlu entegrasyon servisi veya merkezi üst-ajan gerektirmez.

## 5. Roman üzerinden sınırlı yöntem karşılaştırması

Aşağıdaki koşullar bu turun düşünsel örneğidir; mevcut roman veya kabul edilmiş yeni yaratıcı yön değildir. T12–T15'in kaynak/karakter/okur/tercih sınırları korunur. Küçük pasajları yeniden çalıştırıp işaretlenmemiş keşif başarısı iddia edilmiyor.

Varsayalım yaratıcı amaç, Derya'nın ilişkisindeki dönüşümün anlaşılabilir olması, buna karşılık ahlaki hükmün okura açık bırakılması. İlk bütünsel incelemede henüz belirli kusur işaretlenmemiş olsun. Bu iki amaç örnek öncüllerdir; gerçek kullanıcı adına tercih uydurulmaz.

| Aday inceleme | Ne kazandırabilir? | Neye yetmez / hangi ortak körlük kalabilir? |
|---|---|---|
| Planı ve karakter gerekçelerini bilen plan–metin karşılaştırması | Niyet edilen değişimin gerçekten yazılı olup olmadığı, sürüm uyuşması ve açık tutarlılık sorunları için dayanak | Yazarın bildiğini metin tek başına sunuyormuş gibi değerlendirebilir; gerçek ilk okur etkisini ölçmez. |
| Gerekçeleri otomatik doğru saymadan, asıl metni anlatı sırasıyla ve metin dayanağıyla inceleme | Yalnız metinden hangi yorumun desteklendiği, nerede başka pasaj gerektiği ve okura ne zaman ne sunulduğu için farklı inceleme yolu | Aynı modelin alan varsayımları kalabilir. Finali bilen aynı aktöre «unutmuş gibi oku» demek gerçek bilgi izolasyonu değildir. |
| Uygun ve mevcut insan editör/okur katkısı | Metin dışındaki farklı alan bilgisi veya gerçekten gözlenen okuma tepkisi | Bir kişinin tercihi hedef kitle geneli veya zorunlu estetik doğru değildir; erişim, kapsam, maliyet ve karar yetkisi ayrıca gerekir. |

Bu yollar üç zorunlu ajan veya sabit sıra değildir. Hangi hüküm için hangisinin gerekli olduğu ayrıdır. İlk iki yol aynı kaynağa bakabilir ama farklı çıkarımı sınayabilir. Üçüncü yolun mevcudiyeti varsayılamaz; yoksa ilk ikinin sonucunu insan deneyimi diye yükseltmeyiz.

Kurulu durumda aday başlangıç: yaratıcı amaç ve incelenecek metin/sürümü bağla; eldeki kaynakla plan–metin dayanağını ve metnin kendi sunduğu ilişkiyi incele; bulunan somut boşlukta hedefli karşılaştırma yap. Sorun gerçekte gerekçe eksikliği ise ilgili revizyon adayı üretilebilir. Sorun yalnız tercih farkıysa fazladan açıklama eklemek zorunlu değildir. İlişki metinde başka geçerli yoldan kurulmuşsa gereksiz onarım yapılmaz. Gerçek okur etkisine ihtiyaç kalıyorsa onun kanıtı ve yetkisi ayrıca açık olur.

Buradaki yeni soru, yalnız «Derya ne biliyor?» değildir: **Seçtiğimiz inceleme, hedeflediğimiz edebî iddiayı hangi dayanakla değerlendirebilir?** Yazılı plana uygunlukla bütünsel estetik/okur başarısını eşitlemeyen seçim gerekir.

## 6. Ortak körlük yalnız aynı model kullanmak değildir

Keşfi ve değerlendirmeyi aynı eksik soru listesine, aynı özetin düşürdüğü ayrımlara veya aynı başarı ölçütüne bağlamak, farklı aktörler olsa bile ortak hata yaratabilir. Kaynak sayısı da köken sayısı değildir: iki yazı aynı özgün açıklamayı yeniden üretmiş olabilir.

İnceleme yolları arasında sorulabilecek pratik karşılaştırma: **Bir yolun kaçırabileceği şu ilgili yanlışı diğer yol neden görebilsin?** Fark; kaynak temasında, problem çerçevesinde, elde edilen gözlemde, kullanılan çıkarım yönteminde veya gerçek sonuçla karşılaştırmada olabilir. «Başka model», «başka rol» ve «yeni oturum» tek başına bu sorunun cevabı değildir.

Bunun tersi de yanlış: aynı kaynaktan veya aynı modelden gelen her ikinci değerlendirme yararsız değildir. Kaynakta bulunan ama çıkarılmamış ilişki farklı muhakemeyle görülebilir. F2'nin ayırt edilemezlik sınırı, gerçekten kaybolmuş bilgi ile kullanılmamış bilginin aynı olmadığını gösterir. Mantıksal kanıt veya uygun deterministik kontrolün değeri için mutlaka başka model gerekmez.

Huang ve diğerlerinin ICLR 2024 çalışmasının abstract'ı dış geri bildirimsiz öz-düzeltmenin incelenen reasoning koşullarında zorlanabildiğini bildiriyor. Wu ve diğerlerinin EMNLP 2024 ProCo abstract'ı, anahtar koşulu maskeleyip yeniden tahmin ettiren farklı doğrulama düzeninde incelenen görevlerde iyileşme bildiriyor. Bu kaynaklar aynı koşullarda doğrudan karşılaştırmalı yeniden deneyimiz değildir; tam yöntem/sonuç tablosu yeniden incelenmedi. Dar sonuç: ne «bir daha düşün her zaman yeter» ne de «aynı modelle hiçbir düzeltme olamaz» evrensel kuralı çıkarılmalı. ProCo seçilmedi; 2024 sonuçları 2026 modelleri veya uzun roman için genellenmedi.

**Bağımsızlık burada mutlak bir sertifika değil, ilgili hata yollarının ne kadar ayrıştığına ilişkin sınırlı gerekçedir.** Gerçek ayrışma kurulamıyorsa inceleme yine yararlı olabilir; güven iddiası self-review/cross-check sınırını aşmamalı. Daha fazla onay aynı eksik varsayımı ortadan kaldırmaz.

## 7. Öğrenme ve yöntem edinme iddiasını kaynakla daraltmak

Hermes'in araştırma pin'inde `_skill_view_with_bump`, başarılı `skill_view` sonucundan sonra `bump_view` ve `bump_use` çağırır. Bu kaynakta ölçülen olayın başarılı yükleme olduğunu doğrudan gösterir; modelin yöntemi o işte doğru uyguladığını ölçen bir kalite oracle'ı değildir. Repeat-view dedup yolu ayrıca vardır; bütün araç/harness davranışı bu seçili okumayla doğrulanmaz.

gstack'in araştırma pin'indeki `skill-coverage-floor.test.ts`, dosya varlığı, frontmatter, başlık, gövde ve çözülmemiş şablon gibi biçim özelliklerini kontrol eder. Kaynağın kendisi bunun file-IO ve LLM'siz structural floor olduğunu belirtir. Bu test yararlıdır; yanlışlık, ondan keşif veya yazım davranışı yeterliği çıkarmaktır. Sentezdeki daha geniş seçme/çalıştırma/oracle ayrımları kaynak araştırmasının bulgularıdır; bu tur bütün test altyapısı yeniden çalıştırılmadı.

SOUL için çıkarım: yöntem bulunması, kabulü, görünür hale gelmesi, gerekli koşullarda uygulanması ve amaçlanan sonuca katkısı ayrı sınanır. Bu ayrımların her biri için yeni fiziksel nesne oluşturmak şart değildir. Mevcut iş kaydı ve sonuç kanıtı yeterli olabilir. Dar olumlu sonuç, yeni alan veya kullanımda sınırsız yeterlik haline gelmez.

## 8. Gelecekteki sınama hangi hatayı üretmemeli?

Keşif kapasitesini sınarken beklenen kusuru baştan söylemek keşfi kolaylaştırır; fakat hiçbir amaç, kaynak veya alan koşulundan çıkarılamayan gizli bir kabul kuralı koymak da adil keşif sınaması değildir. **Gizlenen şey kusurun yeri/cevabı olabilir; kabulün meşru dayanağı tamamen yok edilemez.** Kaynak yetersizliğini doğru bildirmek de uygun sonuç olabilir.

Yalnız hata konmuş örnekleri kullanmak, her yerde hata ilan eden sistemi ödüllendirebilir. Sağlam fakat alışılmadık çözüm, kasıtlı yaratıcı belirsizlik, alternatif yolla karşılanan koşul ve bilgi yetersizliği durumları da düşünülmelidir. Bunlar DQ02'nin tasarım baskılarıdır; bu tur hazırlanmış bağımsız holdout veya çalıştırılmış test seti değildir.

Anthropic'in 9 Ocak 2026 tarihli eval rehberi, başarılı/başarısız durumları dengeli kapsama, grader'ı göreve göre seçme, geçerli alternatif yolları gereksiz cezalandırmama ve sonuçla işlem izini ayırma yönünde uygulama deneyimi bildirir. Buradaki kullanım sınırlı destekleyici karşılaştırmadır; rehberin önerileri SOUL'a aynen benimsenmez ve sağlayıcı deneyimi bağımsız doğrulama değildir.

Bir değerlendiricinin tanıdığı bozuk örneği reddetmesi sınırlı hata duyarlılığı gösterebilir; bilinmeyen gereksinimleri bulmayı göstermeyebilir. Ayrıca aynı örneğe bakarak yöntemi değiştirdikten sonra o örneği yeni bağımsız doğrulama gibi sayamayız. Bu konuşmada açıklanan karşı durumlar daha sonra gizli test diye sunulmaz.

## 9. Maliyet, ilerleme ve meta-döngüyü sınırlama

T11/DQ01'in sınırları sürer. Her yöntemin doğruluğunu kanıtlayan yeni bir yöntemi sonsuza kadar aramak yerine, bir sonraki meşru etki için gereken dayanak değerlendirilir. Yeterli kanıt varsa ilerlenir; kritik eksik varsa etkisi gerçekten ayrılabilen işler sürdürülebilir. Bölünebilirlik veya yetki yoksa kapsam kendiliğinden daraltılmaz.

Aday öncelik sorusu: Şimdi yapılabilir incelemelerden hangisi karar açısından önemli belirsizliği anlamlı biçimde azaltabilir veya mevcut çerçevenin dışındaki önemli bir koşulu ortaya çıkarabilir? Cevap nitel olabilir; ölçülmüş olasılık yokken beklenen fayda skoru uydurulmaz. Tek tek etkisiz görünen iki tamamlayıcı adım birlikte değerli olabileceği için yalnız bir-adım kazancı zorunlu kural yapılmaz.

İnceleme maliyeti, gecikme ve üretimin beklemesi birlikte düşünülür. Aynı kanıtla aynı soruyu tekrar açmak ilerleme değildir. Buna karşılık gerçekten yeni karşı kanıt, sırf önceki kapanışı bozuyor diye atlanmaz. Keşfin hangi ana ihtiyaca döneceği, açık kalırsa sonraki sorumluluğun ne olacağı ve hangi yeni koşulda tekrar bakılacağı recoverable kalmalıdır.

Bu tur yöntemlerin maliyetini ölçmedi; algoritma, eşik, agent sayısı veya kaynak oranı seçmedi. «Makul maliyet» sözü yapılabilirliğin kanıtı değildir; gelecekte gerçek çalışma kanıtı ister.

## 10. Başlangıç yeterliği ve üç düzey

Tam alan uzmanlığı olmadan sınırlı öğrenmeye başlamak mümkün bir seçenek olabilir. Fakat amaç/kullanımı kısmen anlayabilme, güvenilir kaynağa ulaşabilme, kaynak statülerini ayırabilme, uygun ilk incelemeyi seçebilme ve iddia sınırını koruyabilme kapasitesi kendiliğinden oluşmuş sayılmaz. Bir alandaki bilinmeyenleri araştıracak kişi/sistem o alanın hiçbir ayrımına erişemiyorsa her şeyi kendi başına güvenilirce keşfetmesi varsayılamaz.

Buradan «bütün uzmanlık baştan hazır olmalı» sonucu da çıkmaz. Başlangıç düzeni dar bir görev ailesinde ve görünür insan/araç desteğiyle kurulabilir; bunun hangi koşullarda genişletileceği ayrıca değerlendirilir. İnsan katkısı gerekiyorsa sağladığı uzmanlık, erişim, maliyet ve karar rolü görünür olur. Kullanıcıdan amaç/tercih/yetki istemek ile kullanıcıya gizli teknik araştırmayı yaptırmak aynı değildir.

Kullanıcı işinde doğru ihtiyaç ve yeterli sonuç; SOUL'da işe uygun inceleme/üretim/değerlendirme yolunu kurma; Development OS'da bu kapasiteyi geliştirme ve sınama yükü ayrı kalır. Development OS'un bir yöntemi açıklaması SOUL'un onu yapabildiğini göstermez. SOUL'un bir yerel başarısı bütün alanlar için sertifika değildir. Bu tur baz SOUL mimarisi veya Development OS bootstrap'ı seçilmedi.

## 11. Sonuç ve açık sonraki soru

**Bu tur ilerletilen:** Yöntem seçiminin nesnesi somutlaştırıldı; soru açan keşif ile rakipleri ayıran inceleme ayrıldı; farklı kanıt yolları hata gerekçesine bağlandı; aynı-model incelemeye ilişkin iki aşırı hüküm sınırlandı; yöntemin edinilmesi ile gerçek kullanım/yarar kaynak düzeyinde ayrıldı; gizli kusur ile gizli kabul kuralı farkı korundu. Bunlar yeni evrensel ontoloji veya başarıyla çalışmış süreç değildir.

**Açık kapasite:** İlk anlamlı bakışı ve incelemeyi zamanında seçmek, bunun mevcut imkânlara uygunluğunu değerlendirmek, yeni bulguyu doğru üst karara taşımak ve ne zaman yeterli olacağını gerçek kullanımda kalibre etmek. Bu turun daha geniş kaynak kullanımı, asistanın veya SOUL'un bu kapasitede güvenilir olduğuna bağımsız kanıt sayılmaz.

**Sonraki mantıklı dar kavramsal soru:** Yeni keşif yalnız bir görev ekletmek yerine başlangıçtaki iş anlayışını, başarı ölçütünü veya seçilmiş yöntemi yanlış gösterirse SOUL neyi yeniden açmalı; geçerli işleri koruyarak hangi kararı, kimin yetkisiyle yeniden ele almalı? T13'ün eser içi revizyonu ve T15'in tercih ayrımı tekrar edilmeyecek; daha üst iş/başarı çerçevesinin değişmesi ile yerel onarım farkı hedeflenecek. Ayrı deney kampanyası, mimari seçimi veya uygulama bu soru üzerinden otomatik açılmaz. DQ02'nin sınırlı sonucu önce kullanıcıya döndürülür.

## 12. Kaynaklar ve gerçek okuma kapsamı

Repository okumalarının ref'i, aksi belirtilmedikçe başlangıç main'idir. Aynı oturumda önceki turda tam okunan AGENT/protokoller davranış için etkin kaldı; agent-control araştırma delili yapılmadı. Güncel main DQ01 yayınıyla aynı bulundu. Kaynak arşivi ile çalışma notları ayrıdır.

| Kaynak | Bu turdaki okuma/kullanım ve sınır |
|---|---|
| EXP-004 STATE / INDEX | Tam: STATE 1–24,25–68,69–115,116–EOF; INDEX 1–52,53–EOF. Blob'lar `1930e44659568c27d4d27f2f176b6602b8a875be` / `eb1e215a6a3bed2296b05466c4c6b43931cb5537`. Current yetki ve DQ01'den devam; kaynak konuşma değildir. |
| DQ01 / SY01 / T2,T3,T10,T11,T14 / RPD | DQ01 ve SY01 bu aynı oturumda önceki turda tam; diğerleri önceki kayıtlı seçici kapsamlarıyla kullanıldı, bu tur yeniden tam açılmadı. DQ01 §10 gerçek önceki okuma derinliğini korur. Özgün RPD ekleri edinilmedi. |
| [Foundation STATE](../../../research/soul-foundations/STATE.md), [DISCUSSION-HANDOFF](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/DISCUSSION-HANDOFF.md), [REUSE](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md) | Üçü tam; blob'lar `6d1c3db664bb154546cb6c0bf5edc6da5275dcf8`, `e95cf01635d328ae4d5db414ba5a9c4d70a42fb7`, `b92c29d85055c70536392c0804a7a621efc9caff`. Genel Foundation araştırması açılmadı. Handoff tam kaynak transkripti değildir. |
| [Formation INDEX](../../../research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/formation-acquisition/INDEX.md), [STATE](../../../research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/formation-acquisition/STATE.md), [F2](../../../research/soul-foundations/03_ground-deepening/grounds/information/informational-dynamics/formation-acquisition/F2-COVERAGE-DISTINGUISHABILITY-AND-MISSINGNESS.md) | Tam. F2 blob `7c2e3c2bc141304cdc7a33a0cc6e33aaf5113b9d`. §2'nin açık argümanı ve §§1,3,5'in kapsam sınırları kullanıldı. Original checks çalıştırılmadı; F2'nin bütün dış literatürü yeniden incelenmedi. |
| [Selection/Dynamics SYNTHESIS](../../../research/soul-foundations/07_selection-dynamics-integration-review/SYNTHESIS.md) | Tam; `c2b1138ee898d9be8c829c5aa0f160c86eb58aba`. Özellikle §§2–4 ve I1–I4. Tarihsel pending etiketi güncel Foundation STATE'teki kabul altında okundu. Sonlu koşullardan doğal dil/aktör başarısı çıkarılmadı. |
| Studies CATALOG | Aynı oturumun önceki 1–53 keşif görünümü; tamamı bu tur yeniden taranmadı. Yeni seçimler o görünüm ve REUSE yönlendirmelerinden yapıldı. Bütün kütüphane okundu denmez. |
| [Work Management META](../../../research/studies/work-management-project-control/META.md), [STATE](../../../research/studies/work-management-project-control/STATE.md), [METHOD](../../../research/studies/work-management-project-control/METHOD.md), [U10](../../../research/studies/work-management-project-control/10-CLOSURE-EVALUATION.md) | Dördü tam; U10 `e140a0cac67d41af1d3b45dfdddf1eccedfcc860`. Sekiz ürünün current source/kurulum/etkinlik denetimi yapılmadı; yöntem koşulluluğu ve non-collapse sınırları yeniden kullanıldı. |
| [gstack META](../../../research/studies/gstack/META.md), [INDEX](../../../research/studies/gstack/INDEX.md), [STATE](../../../research/studies/gstack/STATE.md), [testing/eval synthesis](../../../research/studies/gstack/syntheses/testing-eval-routing-compliance-flake-lifecycle.md) | META/INDEX tam; STATE 1–110 seçici; synthesis §§1–16 görüldü, §17 başında kırpıldı. Tam synthesis veya bütün study okuma iddiası yok. |
| gstack özgün `test/skill-coverage-floor.test.ts` | `garrytan/gstack@0d1bd5616c0ef096bb7ccee336f63c60ee408618`; 1–180 isteği EOF'a kadar tam metin, blob `4f75e370b09c01098fb711ca4332f1370e1e5a10`. Dosya/biçim kontrolü doğrudan görüldü. Test ve import bağımlılıkları çalıştırılmadı; current main değil. |
| [Hermes META](../../../research/studies/hermes-agent/META.md), [Note30](../../../research/studies/hermes-agent/notes/30-SKILL-LIBRARY-LIFECYCLE.md), [DISCOVERY-SOURCES](../../../research/studies/hermes-agent/evidence/2026-09-13-skill-library/DISCOVERY-SOURCES.md) | Üçü tam; Note30 `26b9773cce8e3bb40cbc845df1b538f735fc698d`, source ledger `5cfd289067f265b5b4d376b2acecceb8708cecd2`. Q60 veya Hermes araştırması devralınmadı; bütün STATE/METHOD/PLAN yeniden okunmadı. |
| Hermes özgün `tools/skills_tool.py` | `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; 620–760 isteği EOF'a kadar seçici; blob `ed7b318df13336abf34acd0ed4b6896f85d8e854`. `_skill_view_with_bump` kaydı doğrudan görüldü; whole-file/skill_usage/runtime/dependency closure veya görev kalitesi deneyi yok. |

### Dar yeni dış kaynaklar — erişim 2026-09-21

- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents), 2026-01-09: resmî HTML'nin dönen metni 14–304; özellikle grader türleri, capability/regression ayrımı, dengeli vakalar ve sonuç/yol §§24–38,56–125,233–271. Sayfanın son bölümleri/bağlı örnekleri/görselleri tam incelenmedi. Ürün/model skorları kullanılmadı; birinci taraf yöntem deneyimi diye tutuldu.
- [Huang ve diğerleri, Large Language Models Cannot Self-Correct Reasoning Yet](https://arxiv.org/abs/2310.01798v2), ICLR 2024, v2 2024-03-14: abstract ve kayıt doğrudan okundu. PDF, deney tabloları, kod ve bütün yöntem tam okunmadı.
- [Wu ve diğerleri, Large Language Models Can Self-Correct with Key Condition Verification](https://arxiv.org/abs/2405.14092v3), EMNLP 2024, v3 2024-10-03: abstract ve kayıt doğrudan okundu. PDF/kod/tablolar tam incelenmedi; mekanizma benimsenmedi. Bu iki eski paper güncel model karşılaştırması değildir.

İlk web araması ilgisiz sonuçlar da getirdi; onlar kanıt olarak kullanılmadı. Dış tarama bu karşılaştırmanın dar destek kontrolüdür; yeni studies paketi veya genel self-correction araştırması başlatılmaz. Bu kayıt kaynak okumalarının varlığını gösterir; bağımsız kavramsal doğruluk sertifikası değildir.

## 13. Süreklilik

Dar yayın kapsamı: bu DQ02 notu, EXP-004 STATE ve INDEX. DQ01, SY01, T1–T15, SC02, özgün konuşmalar/manifest, onarım kayıtları, önceki EXP'ler, Foundation, studies, concepts ve agent-control korunur. T testi sayısı, 31 mesajlık kaynak kesimi ve 126 kümülatif kaynak adresi değişmez. DQ02 kaynak transkripti değildir.

Bu not kendi gelecekteki commit'ini veya yapılmamış uzak geri okumayı başarılı saymaz. Yayın/diff/readback ayrı teknik kontrollerdir; yöntem etkinliği veya bağımsız SOUL davranış doğrulaması değildir.
