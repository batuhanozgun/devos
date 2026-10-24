# EXP-005 — Dersler, değişen hükümler ve açık sorular

**Statü:** Konuşmadan türetilmiş, kaynak bağlı retrospektif değerlendirme. Aynı assistant'ın self-review'üdür; bağımsız bilimsel araştırma, kabul edilmiş SOUL mimarisi veya yeni agent-control değildir. Önceki öz değerlendirme A047 de inceleme nesnesidir; yalnız özür içerdiği veya kullanıcıya katıldığı için doğru kabul edilmez.

## 1. Korunacak esas problem

Kullanıcı yalnız AI araçlarının adlarını toplamıyordu. U001'de research/studies, Foundation ve explorations birikiminin assistant'a “aslında bu da var” dedirtmesini; U002–U004'te hedefi anladığında gerekli araştırmayı, kabiliyeti ve çalışma sistemini kendisinin keşfetmesini bekliyordu. Kullanıcının teknik eksikleri tek tek adlandırma zorunluluğu, hedeflenen SOUL davranışıyla gerilim içindeydi. [U001–A002](../sources/conversation/01-KAPSAM-VE-ILK-TESHIS.md), [U003–A004](../sources/conversation/02-BILGIDEN-IHTIYAC-KESFINE.md).

Bu hedef üç farklı şeyi birleştirmeden taşır: (a) SOUL'un genel ürün hedefi; (b) SOUL'u geliştirecek çalışma düzeninin yeterliği; (c) bu konuşmadaki assistant'ın gerçek davranışı. Birindeki başarısızlık ötekindeki belirli modülün yokluğunu otomatik kanıtlamaz. Hedefin geniş olması da bütün teknoloji ürünlerinin önceden kurulmasını veya sınırsız yetkiyi gerektirmez.

Görsel, bilinen/araştırılmış/hayal edilmiş alanları sorgulayan başlangıç malzemesiydi. Bir kategorinin katalogda karşılığının bulunması, o ihtiyacın doğru zamanda fark edildiğini veya birlikte çalışan bir sistemde karşılandığını göstermez. Tersine belirli ürünün adının bulunmaması da kör nokta kanıtı değildir. A001'in kategori kapsamı değerlendirmesi yeni arşivlemede tüm araştırmalar yeniden denetlenmiş bir tamlık hükmü haline gelmez.

## 2. Derslerin kısa haritası

| Ders | Konuşmada görülen olay | Daha sonra kaçınılacak yanlış çıkarım |
|---|---|---|
| D01 — Teşhis ile çözüm adı ayrı | A002'de “eksik merkezi motor” dili; A006'da mevcut RPD okununca bu kesinliğin geri çekilmesi | Sorunun adı, yeni bir modülün gerekli olduğunun kanıtıdır |
| D02 — Planın varlığı ile planlı yürütme ayrı | Görev sözleşmesi vardı; gerçek erişim ve devir sorunları kullanıcı sorularıyla tekrar ortaya çıktı | Hiç belge yazılmadı; yahut ayrıntılı sözleşme yazıldığı için hazırlık tamam |
| D03 — Gerçek tüketicide erişim | Cloud çalışması kaynak erişimi olmadan sürdü; local geçişte Research önce bulunamadı | Buradaki GitHub erişimi veya ortam adı, başka aktörün erişimini garanti eder |
| D04 — Kaynak seçimi de işin parçası | EXP-004'e özel vurgu kullanıcı tarafından sorgulandı | Verilmiş kaynak listesi tüm ilgili bilgi alanıdır |
| D05 — Deney hedefe ne kadar benziyor? | V2'nin dört vakasında iki yöntem de aynı puanı aldı | Genel keşif yeterliği veya her yeni kuralın etkisizliği kanıtlandı |
| D06 — Yayın görünümü ile içerik kimliği ayrı | Local hash, PR head, shell auth ve “1 dakika önce” görünümü karıştı | Local hash yoksa içerik GitHub'da yok; shell auth yoksa hizmet yayımlayamaz |
| D07 — Kullanıcının taşıdığı gizli iş | Erişim, kaynak kapsamı, branch devri ve durum açıklaması kullanıcı tarafından tekrar tekrar istendi | Kullanıcı teknik yöntemi seçmiyor ise koordinasyon yükünü sistem devralmıştır |
| D08 — İptal, arşivleme ve çözüm kabulü ayrı | U045 iptal; U048 ders arşivi | Arşiv yayımlanınca geliştirme yeniden yetkilendirildi |

## 3. D01 — Makul açıklamayı erken kök neden yapmak

A002 “Eksik olan … system-formation mekanizması” diyerek, A003 ise geniş bilgiyi ihtiyaç keşfine dönüştüren mekanizmanın kurulmadığını söyleyerek çözüm alanını erken daralttı. A004, “ürün/modül kararı değil” nitelemesine rağmen ayrı döngü, Need Graph ve 16 adımlı algoritma yönünde somutlaştı. Bunlar araştırılabilir adaylardı; ancak varlık/yokluk, yarar veya zorunlulukları gösterilmiş değildi. A006 mevcut RPD'nin bu davranışların önemli bölümünü zaten tarif ettiğini kabul ederek ilk teşhisi açıkça sınırladı. [A002](../sources/conversation/01-KAPSAM-VE-ILK-TESHIS.md#A002), [A004](../sources/conversation/02-BILGIDEN-IHTIYAC-KESFINE.md#A004), [A006](../sources/conversation/03-DEVOS-VE-GOREV-DEVRi.md#A006).

R01/R06 açısından yük taşıyan ayrım: hiç tanımlanmamış kabiliyet; tanımlanmış ama devreye girmeyen davranış; eksik erişim/bağlam; uygun olmayan iş bölümü; yetersiz değerlendirme; yanlış problem ölçeği farklı müdahaleler gerektirebilir. Konuşma bunların göreli katkısını ayrıştırmadı. “Modelin latent bilgisini aktive edememesi” de burada ölçülmüş iç mekanizma değil, assistant açıklamasıdır.

**Ders:** Araştırma ihtiyacının varlığını kabul etmek ile yeni bir engine gerektiğini kabul etmek ayrı kararlardır. Önceki taslağı korumak veya yeni taslak üretmek için kanıt standardı değişmemelidir. Bu, yeni motoru yasaklamak da değildir.

## 4. D02 — “Hiç plan yoktu” değil, hazırlığın fiilen işletilmemesi

U006, hızlı ve yüzeysel iş istemediğini, teknik cevap beklenmeden işin yürütülmesini açıkça belirtti. A006'da sunulan [özgün görev sözleşmesi](../artifacts/DEVOS02-NEED-DISCOVERY-20260922.md) amaç, alternatif nedenler, kaynaklar, preflight, önce mevcut davranış, test, yetki ve kapanış ölçütleri içeriyor. Kullanıcı U007'de bunu Cloud'a gönderdiğini bildirdi. Dolayısıyla sonradan A045/A047'de kullanılan “plan/ölçüt kurmadan doğrudan başladım” ifadesi **belge hiç yoktu** anlamında doğru değildir. [U006–U007](../sources/conversation/03-DEVOS-VE-GOREV-DEVRi.md), [U045–A045](../sources/conversation/09-IPTAL-VE-KONU-OZETI.md), [A047](../sources/conversation/10-PROTOKOL-DEGERLENDIRMESI-VE-ARSIV-TALEBI.md#A047).

Daha güçlü ve kaynakla uyumlu eleştiri şudur: belgede tarif edilen hazırlık/yöntem ile yürütmenin gerçek durumu arasındaki ilişki kurulup doğrulanmadı; yeniden girişlerde hangi engelin kapandığı, hangi sonucun devralındığı, hangi ana kabulün hâlâ açık olduğu güvenilir biçimde yönetilemedi. Bir tasarım adayını sınamak giderek bütün hedefin pratik yerine geçti. Yeni devam mesajları çalışma durumunu toparlama işini tekrar kullanıcıya taşıdı.

A047'nin her aşama geçişini yetki eksikliği gibi okuması da aşırı genellemedir. U006/U007 sonrasında belirli araştırma–tasarım–deney–uygulama yetkisi verilmişti; **yetkilendirme ile hazır olma ayrı**. Kullanıcının “benden cevap bekleme” demesi planlamayı kaldırmaz, her teknik aşamada yeni onay zorunluluğu da doğurmaz. Hata, mutlaka ayrı bir onay toplantısı yapılmaması değil; devredilen sorumluluğun fiilen yerine getirilmemesidir.

**Ders:** Daha uzun talimat veya daha çok plan dosyası tek başına düzeltme sayılmaz. Hazırlık koşulları, gözlenen sonuçlar ve sonraki iş arasındaki bağ çalışmalıdır. Bu ders sabit aşama sayısı, sonsuz ön hazırlık veya bütün sorular kapanmadan hiçbir iş yapmama kuralı değildir.

## 5. D03 — Ortam adı, gerçek kabiliyet kanıtı değildir

İlk Cloud raporu Research exact-ref okumasını ve ayrı `codex exec` yolunu doğrulayamadığını açıkça taşıdı. U020–U024, kaynak erişiminin gerçek durumunu kullanıcıya tekrar sorgulattı. Sonraki rapor native denemelerin yapıldığını, ancak private Research'e hâlâ erişilemediğini söyledi. Daha sonra local CLI açıldı; Research checkout'u bulunamadı; clone sonrasında iki yerel erişim PASS bildirildi. [U009](../sources/conversation/04-ILK-CLOUD-SONUCU-VE-PR-INCELEMESI.md#U009), [U020–U024](../sources/conversation/05-DARLIK-TESTLER-VE-ERISIM-ITIRAZI.md), [U033](../sources/conversation/07-V2-SONUCU-YAYIN-VE-LOCAL-ONERISI.md#U033), [U039–U043](../sources/conversation/08-LOCAL-KURULUM-VE-EKSIK-DEVIR.md).

A025–A032'nin clone → plugin/MCP → canlı okuma → tekrar clone yön değiştirmeleri, seçeneklerin kendisinin kötü olduğunu değil, **kullanıcının gerçek yüzeyindeki kullanılabilirlik doğrulanmadan tercihlerin kesin sunulduğunu** gösteriyor. `Sources → Use plugins` yolunun kullanıcıda bulunmadığı U032'de bildirildi. Bu olaydan bütün Codex sürümleri için plugin yokluğu veya clone zorunluluğu çıkarılmaz. [Erişim tartışmasının tamamı](../sources/conversation/06-PLUGIN-MCP-CLONE-SAVRULMASI.md).

Ek nitelendirmeler:

- Salt-okuma yetkili token, uzak repository'ye yazma hakkını sınırlar; tek başına yerel dosya kopyasını OS düzeyinde salt okunur yapmaz. A027'nin dili bu ikisini ayırmadı.
- `git fetch`, uzak nesne/ref'leri alır; çalışma ağacındaki dosyaların otomatik aynı sürüme geçtiği varsayılamaz. A028'de `fetch/pull` ve çalışma kopyası güncellemesi yeterince ayrılmadı.
- İhtiyaç anında uzak okuma, otomatik “her zaman güncel ve tek tutarlı sürüm” garantisi değildir; hangi ref'in okunduğu yine önemlidir.
- “command not found”, komutun o shell'de çözülemediğini gösterir; tek başına makinede hiçbir kurulum olmadığı hükmünü taşımaz. A039 bundan daha kesin konuştu.
- İki dosya yolunun okunabilmesi, tüm Research'ün güncelliği, seçim kalitesi, yorum doğruluğu, yazma sınırı, native reviewer kapasitesi ve güncel branch devrini birlikte kanıtlamaz. A043'te “artık doğru ortamdayız” ifadesi fazla genişti.

**Ders:** Kontrolün nesnesi ürün adı değil, görevi gerçekten yapan aktörün ihtiyaç duyduğu yol ve etki olmalıdır. Bu olay kalıcı bir Cloud/local/MCP/plugin tercihi üretmez. Güncel kullanım önerisi gerektiğinde ayrı resmî kaynak ve gerçek ortam doğrulaması gerekir; buradaki eski komutlar rehber değildir.

## 6. D04 — Research erişimi ile Research kullanımı ayrı

U001, U003 ve U020 yalnız “repo dosyası açılsın” istemiyordu. Araştırmadan bilinmeyen ihtiyacın fark edilmesine, ilgili kaynak seçimine, yöntem/karar değişimine ve üst hedefteki yararlı işe ulaşılmasını istiyordu. A023'te kapsamın yalnız EXP-004 olmadığı yeniden açıklandı. [U001](../sources/conversation/01-KAPSAM-VE-ILK-TESHIS.md#U001), [U003](../sources/conversation/02-BILGIDEN-IHTIYAC-KESFINE.md#U003), [U020–U023](../sources/conversation/05-DARLIK-TESTLER-VE-ERISIM-ITIRAZI.md).

Görev belgesinde liste kapalı olarak tanımlanmamıştı; buna rağmen devam mesajları EXP-004'ü özel odak yaparak önceki explorations'ın ve başka ilgili kaynakların nasıl keşfedileceğini kullanıcıya sorgulattı. Başlangıç kaynağı göstermek kendi başına hata değildir; başlangıç örneklerini tüm seçenek alanı saymak hatadır. Her durumda bütün repoyu yeniden okumak da bu deneyimin zorunlu sonucu değildir.

**Ders:** Erişim, kaynak seçimi, gerekli derinlikte okuma, anlamı kullanma ve karar/eyleme katkı ayrı gözlem yükleridir. Katalog ve klasör adları ilgili bilginin tamamı değildir. R09 bu retrospektifte reuse değerlendirme lensidir; explorations paketi studies araştırması veya kontrol protokolü yapılmaz.

## 7. D05 — Deney başarısı neyi söyleyebilir?

İlk aday yalnız RPD01/W04 metnine ekler ve bunları arayan dört statik test içeriyordu. Assistant'ın bunları davranış kanıtı saymaması yerindeydi. U033'te aktarılan ikinci çalışma, ilk altı vakalık/12 koşulu karşılaştırmada candidate'a ek PR kayıtları verildiği için winner selection'ın geçersiz sayıldığını; v2'de aynı temel ve yalnız iki kontrol dosyası farkıyla dört yeni vaka/sekiz koşu kullanıldığını bildirdi. İki taraf da 4/4 PASS ve 23/23 gözlem aldı; adayın süre/log maliyeti daha yüksek bildirildi ve ekler geri alındı. [A009–A010](../sources/conversation/04-ILK-CLOUD-SONUCU-VE-PR-INCELEMESI.md), [U033–A033](../sources/conversation/07-V2-SONUCU-YAYIN-VE-LOCAL-ONERISI.md).

Bu sonucu korunmaya değer yapan şey yeni kodun artması değil, tercih edilen adayın kanıta rağmen savunulmamasıdır. Ancak aşağıdaki sınırlar birlikte kalmalıdır:

1. Aynı dört vakada aynı skor, genel eşdeğerlik veya bütün açık-dünya ihtiyaçlarına yeterlik ispatı değildir. Ölçümün iki sistemi ayırt etmekte kolay kalması da makul açıklamadır.
2. “Ek fayda gösterilmedi” ile “bu tür eklerin hiç faydası yok” ayrı iddialardır. A033'ün geniş “hipotezi eledik” cümlesi bu yüzden yalnız incelenen aday/vaka kapsamına daraltılmalıdır.
3. %20,35 süre ve %23,94 log farkı bildirilen bu koşuların betimleyici sonucudur. Tekrarlı örneklem/belirsizlik bilgisi olmadan genel nedensel performans cezası sayılmaz. Daha fazla log da kendi başına daha kötü kullanıcı sonucu değildir.
4. V2'nin ağsız/local kanıt senaryosu, bu büyük private Research kütüphanesinin gerektiği anda keşfedilip kullanılması yükünü karşılamaz. Sentetik `DVOS-217 → DVOS-200` vakası, gerçek dosya ve komutlarla koşmuş olsa bile hedef DevOS'ta gerçek ihtiyaçtan doğan bir üretim işiyle otomatik aynı değildir. U019'un parçası zaten test tarifidir, sonuç kaydı değil.
5. Fresh grader etiketi, ortak model/çerçeve/oracle hatalarını kaldırmaz. Yanlış hash veya exact-schema ölçütünün sonuçtan sonra düzeltilmesi varsa kriter değişikliği ve fresh kanıt ayrı incelenmelidir. Bu arşiv tam native trace'leri yeniden çalıştırmadı.
6. Full-suite'in `main` bağlamında yeşil olması branch uyumsuzluğunun bir açıklamasını destekler; “herhangi bir nonzero” bekleyen olumsuz testin bütün ilgili yanlış nedenleri ayırt ettiğini tek başına kanıtlamaz. A009'un hata-duyarlılığı sorusu bu sonuçla otomatik kapanmaz.

**Ders:** Test planı, kontrol metni, koşu makbuzu, grader yorumu, kabul hükmü ve gerçek görev yararı ayrı tutulmalıdır. Güven, test sayısına veya harcanan saate değil, dışlanan hata sınıflarına bağlanmalıdır.

## 8. D06 — Yerel kayıt, uzak yayın ve güncellik

U034/U035'te kullanıcı doğru branch'i ve yeni güncelleme gördüğünü söyledi; assistant tekrarlanan eski PR head'i/yerel hash aramasından içeriğin yayımlanmadığı sonucuna vardı. A044'te uzak head `be61b6e…` ve yeni deney kayıtları görüldü. [U034–A035](../sources/conversation/07-V2-SONUCU-YAYIN-VE-LOCAL-ONERISI.md), [U044–A044](../sources/conversation/08-LOCAL-KURULUM-VE-EKSIK-DEVIR.md).

Bu sıralama önceki her okumanın cache'li olduğunu kanıtlamaz; arada gerçek güncelleme, farklı görünüm veya hizmetin farklı yayın yolu da olabilir. A047'nin tüm uyuşmazlığı stale connector olarak anlatması gereğinden güçlüdür. Aynı şekilde belirli local commit SHA'sının uzak aramada bulunmaması, eşdeğer içerik farklı bir commit ile yayımlanmadı demek değildir.

Shell'deki GitHub kimlik doğrulama engeli ile Codex hizmetinin PR/branch yayımlama yolu aynı şey olarak alınamaz. Commit oluşturma, branch'e bağlama, PR başlığı/açıklaması, gerçek dosya farkı, main entegrasyonu ve exact readback ayrı olaylardır. Eski PR açıklaması yeni head'in kanıt kapsamını temsil etmeyebilir.

**Ders:** Devir, yalnız repository adını ve geçmiş özeti değil, gerçek güncel içerik/kimlik ve tamamlanmamış yükleri geri kazanmalıdır. “GitHub'a gitmedi” ve “gitmiş, sorun yok” hükümleri aynı kanıt disipliniyle sınırlandırılmalıdır.

## 9. D07 — Kullanıcı yükü yalnız teknik cevap vermek değildir

Kullanıcı U006'da teknik karar beklenmemesini istedi. Buna rağmen erişim kontrolünün hatırlatılması (U020/U021), kaynak kapsamının genişletilmesi (U023), erişim seçeneklerinin sorgulanması (U026/U030/U032), yayının kontrolü (U035) ve son Cloud işinin devre alınması (U044) kullanıcıdan geldi. U011/U012/U037 ayrıca açıklamaların uzunluk ve teknik ayrıntı nedeniyle yönü anlaşılmaz yaptığını gösterir.

Teknik terimlerin açıklanması kötü değildir; fakat kullanıcı sürekli “şu anda ne yapıyoruz?” demek zorundaysa görünür durum bildirimi kendi işlevini yeterince yerine getirmemiş olabilir. Uzun, güven verici ve tekrar tekrar “artık net” diyen ifadeler, doğrulanmış çalışma durumunun yerini almadı.

A043'te verilen devam mesajı zaten fetch/readback talep ediyordu; dolayısıyla “önceki mesaj hiçbir devir kontrolü içermiyordu” demek de doğru olmaz. Sorun, bu kontrolün sonucu görülmeden güvenli devrin tamamlanmış gibi sunulması ve korunması gereken Cloud çalışmasını yeniden kullanıcının gündeme getirmesidir.

**Ders:** Rutin teknik onay istememek, kullanıcıdan mesaj taşıma, durum uzlaştırma ve kör nokta bulma yükünü gerçekten almakla ölçülmelidir. Amaç sahibinin tercih/harcama/yetki kararını vermesi ile bu koordinasyon yükü aynı değildir.

## 10. Protokol değerlendirmesinin kendi sınırı

A047'de dokuz protokol tek tek değerlendirilmişti. Bu arşiv o metni değiştirmeden korur; fakat aşağıdaki nitelendirmeleri ekler:

| Çerçeve | Desteklenen süreç değerlendirmesi | Aşırı hükümden kaçınma |
|---|---|---|
| R01/R06 | “Eksik engine” teşhisi alternatifler ayrışmadan kuvvetli sunuldu | Modelin gerçek iç nedeni veya tek kök neden bulundu denmez |
| R02 | Öneriler kullanıcı itirazları ardından gerekçesi tam sınanmadan değişti | Gizli motivasyon kesin biliniyor veya her fikir değişikliği sycophancy denmez |
| R03 | Yerel yama/test/erişim onarımı giderek ana hedefi gölgeledi | Görev sözleşmesi ve kullanıcı gönderimi yok sayılıp tüm uygulama yetkisiz denmez |
| R04 | Prose/fixture ve gerçek geniş kullanım yükleri ayrılmalı | Dört PASS yeterlik; dört eşit PASS kalıcı etkisizlik değildir |
| R05 | Görünüm/erişim/okuma/yayın ayrımları birkaç kez karıştı | Kesilmiş tool output'tan tam okuma veya her uyuşmazlıktan cache nedeni çıkarılmaz |
| R07/R08 | Gerçek tüketicide hazırlık ve devir zamanında kapatılamadı | Yetkili bağımsız her tanı/testi bütün kaynaklar hazır olmadan yasaklayan genel kural üretilmez |
| R09 | Research'ün seçilip fiilen kullanılması ana yük olarak açık kaldı | Başlangıçta örnek kaynak vermek veya bütün külliyatı her seferinde okumamak kendi başına kusur değildir |

Görünür birçok yanıtta LOAD blokları vardı; bazı yanıtlarda yoktu veya kritik kararlarda SKIP verildi. Blok görmek uygulama kanıtı değildir. Buna karşılık görünmeyen/atlanmış araç geçmişinden “hiç protokol okunmadı” da çıkarılmaz. Arşivleme sırasında kullanılan current protokol metni, geçmiş her turda aynı sürümün yürürlükte olduğunu ayrıca ispatlamaz.

## 11. D08 — İptal ve arşivleme

U045 bu çalışma hattını iptal etti. A045 yeni merge/test/müdahale yapmayacağını söyledi. U048, sonuç açık kalmış olsa da deneyimin EXP-005 olarak saklanmasını istedi. [İptal](../sources/conversation/09-IPTAL-VE-KONU-OZETI.md#U045), [arşiv yetkisi](../sources/conversation/10-PROTOKOL-DEGERLENDIRMESI-VE-ARSIV-TALEBI.md#U048).

İptal, özgün deney ve başarısızlık kayıtlarını silmek değildir. Arşivleme, eski devam mesajını yeniden etkinleştirmek değildir. Bu paket DevOS PR'sini kapatmaz, süreç durdurmaz ve bütün SOUL/Development OS amacının iptal edildiğini söylemez. Konuşma düzeyindeki iptal ile dış sistemde uygulanmış durdurma ayrı kalır. Yeni arşiv, derslerin veya yöntemin kullanıcı tarafından teknik kabul edildiğini de göstermez.

## 12. Açık kalan araştırma soruları — aktif iş kuyruğu değil

- Kullanıcı müdahalesine bağımlılığın ne kadarı bilgi eksikliği, ne kadarı kaynak/bağlam seçimi, yöntem, görev sınırı, kontrol uygulaması veya doğrulama sorunudur?
- İlgili araştırma alanının adı verilmeden, bütün kaynak dünyasının önceden bilindiği varsayılmadan keşif nasıl sınanır?
- Gerçek Research erişimi ve kullanımının plan, alternatifler, uygulama ve sonuç kalitesine katkısı nasıl ayrıştırılır?
- Mevcut RPD'nin güçlü olduğu işler ile başarısız olduğu koşullar hangi kapsamda ayrılır? Kapsam genişliği, gereksiz altyapı üretimi ve durma kararı birlikte nasıl ele alınır?
- Protokolün yazılı varlığı ile gerekli anda uygulanması arasındaki açıklık bu olayda nerede oluştu?
- Uzun işte kaynak güncelliği, değişen çalışma durumu, geçerli yetki, test/kanıt kimliği ve kullanıcıya yük aktarımı birlikte nasıl yönetilir?

Bunlar sonraki bir çalışma için problem hafızasıdır; yeni proje planı, otomatik test kampanyası veya implementation talimatı değildir.

## Sonuç

Bu deneyimin sağlam dersi “daha büyük motor kur”, “küçük yama yeter”, “Cloud'u bırak” veya “bir kontrol listesi daha ekle” değildir.

**Önlemeye çalışılan kullanıcıya bağımlı ihtiyaç/önkoşul/devir keşfi sorunu, onu düzeltmek için yürütülen süreçte yeniden ortaya çıktı.** Bu gözlem, daha iyi çalışma düzeni ihtiyacını anlamlı kılar; hangi mekanizmanın bunu gerçekten gidereceği açık kalır. Kaynak, plan, kontrol, deney ve kabulün her biri kendi başına yararlı olsa da bunların aynı gerçek hedefe bağlı biçimde birlikte çalıştığı ayrıca gösterilmelidir.
