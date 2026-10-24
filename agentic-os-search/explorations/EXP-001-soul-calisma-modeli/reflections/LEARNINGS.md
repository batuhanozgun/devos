# EXP-001 — Öğrenme kayıtları

**Rol:** Kaynak diyaloğun yerine geçmeyen, kaynaklara bağlı yeniden kullanım yüzeyi. **Statü:** Konuşmada geliştirilmiş ilkeler ve tasarım hipotezleri; Foundation'a terfi, benimsenmiş SOUL mimarisi veya gerçek ajan başarımı iddiası değildir.

Her kayıt, önceki yaklaşımı, onu değiştiren örneği, ulaşılan ayrımı ve kullanım sınırını korur. İlgili kaynaklar kullanıcı U ve assistant S kimlikleriyle verilir. Özgün eserler ayrı tarihsel kesitlerdir; sonraki görüşlerle geriye dönük değiştirilmez.

## L01 — Asıl deneme, uygulama değil araştırmanın davranışa dönüşmesiydi

**Başlangıç:** Bir form ve dashboard uygulamasının Work/Information olarak nasıl işletileceği soruldu. İlk cevap işi kayıt altına alma ve gereksinimi netleştirme üzerinde durdu.

**Değiştiren bilgi:** Kullanıcı, uygulamanın hedef değil bir inceleme örneği olduğunu açıkladı. “Hava bugün çok…” benzetmesiyle konuşma, araştırma ve SOUL tanımının LLM'de hangi yönelimi ve çıktıyı doğurduğunu görmek istedi.

**Kazanım:** Bu denemeyi bir ürün geliştirme projesi gibi okumak yanlış olur. Kullanıcı, doğru cevap yarışmasından çok birlikte düşünerek bir çalışma anlayışı oluşturmayı yetkilendirdi.

**Sınır:** Bu bir token katkı ölçümü veya model içi nedensel izleme değildir. Anlatılan gerekçeler gözlenebilir karar/çıktı düzeyindedir.

**Kaynak:** [U001–U002](../sources/conversation/USER-MESSAGES.md#u002), [S001](../sources/conversation/assistant/S001.md), [S002](../sources/conversation/assistant/S002.md). Konsolidasyon §§1–2.

## L02 — Araştırma ayrımı, işletim kuralı ve anlık durum ayrı girdilerdir

**Başlangıç:** Araştırmayı okuyan modelin uygun çalışma düzenini kendiliğinden üreteceği örtük varsayılabilirdi.

**Örnek:** “Talep bulunması üstlenme değildir” bir araştırma ayrımıdır. “Üstlenme kararı olmadan yürütülüyor diye kaydetme” bu ayrımdan yararlanılarak benimsenebilecek işletim kuralıdır. “Talep geldi, karar yok” ise anlık durumdur.

**Kazanım:** Bulgunun davranışa dönüşmesinde bilinçli bir tasarım tercihi bulunur. Bu tercih, araştırmanın kaçınılmaz sonucu veya source metnin otomatik yetkisi değildir.

**Sınır:** Bu nedenle araştırma dosyası, sırf okunması istendiği için agent-control olamaz. EXP-001 içindeki bütün kural örnekleri de tarihsel tasarım malzemesidir.

**Kaynak:** [S002](../sources/conversation/assistant/S002.md), [S003](../sources/conversation/assistant/S003.md), [S013](../sources/conversation/assistant/S013.md). Konsolidasyon §2.2; Atlas I05/I06 ve M02.

## L03 — A–B–C dönüşümü zihin okuma veya sınırsız kapsam genişletme değildir

**Başlangıç:** A kullanıcının söylediği, B zihnindeki istek, C yeterli çalışma tanımı olarak adlandırıldı.

**Örnek:** “Roman yaz” bir hikâyeyi ifade etmek, bir dosya üretmek, yayımlanmak, okura ulaşmak veya kariyere adım atmak anlamına gelebilir. Yayıncılık ve dağıtımın fark edilmesi bütün bunların otomatik üstlenilmesini gerektirmez.

**Kazanım:** C, kullanıcının gizli doğru niyetinin tahmini değil; kaynak talep, edinilen bilgiler, amaç ve gerçek koşullarla birlikte geliştirilmiş mevcut anlayıştır. Birden fazla makul C adayı olabilir. A korunur; B hakkındaki çıkarımlar açık statü taşır.

**Sınır:** Daha geniş amacı bilmek, bütün kariyer veya ticari faaliyetin proje kapsamına alınması değildir. Kullanıcının genel ifadeleri evrensel “kullanıcı hep az bilir” yasası olarak kabul edilmez.

**Kaynak:** [U004–U005](../sources/conversation/USER-MESSAGES.md#u004), [S004](../sources/conversation/assistant/S004.md), [S005](../sources/conversation/assistant/S005.md), [S017](../sources/conversation/assistant/S017.md). Konsolidasyon §§3–4.

## L04 — C tamamlandıktan sonra başlayacak tek bir yürütme evresi yoktur

**Başlangıç:** S005 sonunda “artık yeterince anladım, keşiften execution'a geçebilirim” sorusu genel bir kapı gibi kuruldu.

**Düzeltme:** Kullanıcının çizimi ve roman örneği, bazı işlerin C'nin kalan belirsizliklerinden etkilenmeden başlayabileceğini; işin içinden gelen bilgilerin C'yi değiştirebileceğini gösterdi.

**Kazanım:** Başlanabilirlik belirli iş ve kapsam için değerlendirilir. Keşif, karar hazırlığı ve araştırma da Work'tür. Doğru soru bütün C'nin bitmesi değil, şimdi yapılacak sınırlı işin hangi koşullarda makul olduğudur.

**Sınır:** Talebin sisteme gelmesi her durumda yürütme taahhüdü veya her işin otomatik başlaması değildir. “Work A geldiği anda başlıyor” şeklindeki tarihsel ifade bu sınıra göre okunur. Bir işi incelemeye başlamak ile teslimini üstlenmek ayrıdır.

**Kaynak:** [U006](../sources/conversation/USER-MESSAGES.md#u006), [S005](../sources/conversation/assistant/S005.md), [S006](../sources/conversation/assistant/S006.md), [S007](../sources/conversation/assistant/S007.md). Özgün çizim; konsolidasyon §§5–7; Atlas M05/M07/M10.

## L05 — C'nin zenginliği, belirsizlik ve seçenek alanı aynı büyüklük değildir

**Başlangıç:** A > C, A ≈ C veya A < C ifadeleriyle ilerledikçe belirsizliğin azalması sezgisi dile getirildi.

**Kazanım:** Bunlar aynı ölçekte sayısal değişkenler olarak tanımlanmadı. C'nin içerik zenginliği artarken bazı belirsizlikler azalabilir. Yeni bilgi yeni seçenekler veya sorunlar da açabilir; istikrar matematiksel ve monoton bir garanti değildir.

**Sınır:** Dönem, yayın, okur veya ortam değişimi “geç kaldık, C artık değişemez” gerekçesiyle dışlanamaz. Kaynak ifadeleri düzeltme izleriyle birlikte korunur.

**Kaynak:** [U006](../sources/conversation/USER-MESSAGES.md#u006), [S006](../sources/conversation/assistant/S006.md). Konsolidasyon §5 ve Ek A.

## L06 — Değişen bilgi bütün çıktıyı değil belirli kullanım iddiasını etkileyebilir

**Örnek:** Dört sentetik yanıt içinde H1'in payı 3/12 seçim veya 3/4 yanıt olarak hesaplanabilir. K1'in tekrar gönderimi H3'ü 2/4'ten 3/5'e çıkarır; yeni kişi olmadığı halde yüzde değişir.

**Kazanım:** Aritmetik doğruluk ile sayılan nesnenin uygunluğu farklıdır. Tekrar gönderim bulgusu W-01'in hesaplarını tamamen çöpe atmaz; kişi bazlı yorumunu kabul politikasına bağlar. W-02'nin üç farklı seçim kuralları ilerlerken raporda sayılabilirlik kararı açık kalabilir.

**Sınır:** K1–K4 gerçek kullanıcı değildir; gerçek form/test/ajan çalıştırılmadı. E-posta adresi tek başına gerçek kişi tekilliği kanıtı diye seçilmedi. Bir tek karşı örnek kapsamlı güvenilirlik doğrulaması değildir.

**Kaynak:** [U007](../sources/conversation/USER-MESSAGES.md#u007), [S007](../sources/conversation/assistant/S007.md). Konsolidasyon §8; Atlas demo adımları, I04/D-02 ve M14–M19.

## L07 — Ürün çıktısı, gerçek kullanım sonucunu tek başına sağlamaz

**Örnek:** Sıfır yanıt “hiç kimse bu hareketi seçmedi” değildir. Kod yazılmış olsa da topluluk raporu için gerçek katılım gerekir.

**Kazanım:** Boş durumun doğru gösterimi, sayılan kümenin açıklanması ve ilk gerçek katılımın sorumluluğunun bilinmesi amaçtan doğan ayrı ihtiyaçlardır. İlk katılımı fark etmek otomatik reklam/PR görevi yaratmaz.

**Sınır:** Topluluk tercihleri tıbbi güvenlik veya hareketlerin üstünlüğü olarak sunulmaz. Uygulama kapsamı gerçek kişisel veri toplamaya veya yayın yapmaya bu prova içinde genişletilmedi.

**Kaynak:** [S007](../sources/conversation/assistant/S007.md), [S005](../sources/conversation/assistant/S005.md). Konsolidasyon §§4,8.

## L08 — Proje dosyalarının arkasındaki çalışma bilgisi ve işletim gizli bırakılmamalı

**Başlangıç:** Demo altı proje dosyası gösterdi. Kullanıcı bunları üreten ve kullanan aktörlerin başvurduğu muhakeme düzeninin görünmediğini fark etti.

**Kazanım:** Proje bilgisi, çalışma yönergeleri, alan bilgisi ve bunları fiilen kullandıran ortam ayrı sorumluluklardır. Dosya isimleri öneri olarak görünür kılındı; bu bir nihai klasör mimarisi değildir. Kayıt alanlarının biçiminden öte anlamı da gerekir.

**Sınır:** “C₂ ve D-02'yi üreticiye gösteriyorum” cümlesinde aktarımı anlatıcı sağladı. Bu, gerçek runtime'ın güncellemeyi iletip aktörün kullandığının kanıtı değildir. Aynı dosyanın varlığı, bulunması, çağrıya konması ve uygulanması ayrı koşullardır.

**Kaynak:** [U008](../sources/conversation/USER-MESSAGES.md#u008), [S008](../sources/conversation/assistant/S008.md), [S009](../sources/conversation/assistant/S009.md). Konsolidasyon §§9–11; Atlas kayıtlar R01–R21 ve Q05.

## L09 — Sabit mesleki standart, değişken ürün kapsamı ve uzman katılımı

**Başlangıç:** Ortamın hacmine ilişkin farkındalık S010'da maliyet/karmaşıklık yakınması gibi yorumlandı.

**Düzeltme:** Kullanıcı ev, gökdelen, köpek kulübesi ve hazır alet çantası benzetmeleriyle mesleki ciddiyetin ölçekten bağımsızlığını anlattı. Ürün animasyonu azaltılabilir; çalışma disiplini, kaynak tutumu ve sorumluluk aynı nedenle azaltılamaz.

**Kazanım:** Gerekli uzmanlık değerlendirmesinin atlanmaması; bu değerlendirmenin sonucunda katılım veya çalışma kapsamının sınırlı olabilmesi. Ölçeklendirme kültürün yerine değil, kültürün içinden çıkan bir karardır.

**Sınır:** Her projeye aynı ajan sayısı veya aynı belgeler zorunlu kılınmadı. Mimarlık örneği bir meslek yetkisi veya yapı güvenliği tavsiyesi değil, kullanıcının çalışma felsefesini anlatan analojidir. Kullanıcı kodlamayı küçümsemedi; daha öngörülebilir gördüğünü açıkladı.

**Kaynak:** [U010–U011](../sources/conversation/USER-MESSAGES.md#u011), [S010](../sources/conversation/assistant/S010.md), [S011](../sources/conversation/assistant/S011.md). Konsolidasyon §§12–14 ve Ek A.

## L10 — Uzmanlık sorumluluğu, atanmış görevden önce de gereklidir

**Başlangıç:** İşleri koordinatörün eksiksiz keşfedip sonra uzmanlara dağıtması ima edilebilirdi.

**Kazanım:** Hangi işlerin gerekli olduğunu bulmak için de uzmanlık gerekir. Bir rol, yalnız verilen görevi yapan üretici değil, kendi açısından eksik gereksinimi veya yanlış ayrıştırmayı ortaya çıkaran katılımcı olabilir. Süregelen sorumluluk, sürekli çalışan bir oturumla aynı değildir.

**Sınır:** Rol etiketi yeterlilik, meşru yetki veya başarı garantisi yaratmaz. Öneri üretmek ortak duruma kabul yetkisi değildir. İlk uzmanlık katılımını kimin başlatacağı Atlas Q01'de açık kaldı.

**Kaynak:** [S009](../sources/conversation/assistant/S009.md), [U011](../sources/conversation/USER-MESSAGES.md#u011), [S011](../sources/conversation/assistant/S011.md). Konsolidasyon §§14–15; Atlas M04/M08 ve Q01/Q06.

## L11 — Yeni çağrıda bütün mesleği yeniden öğretmek değil, işe katılım bağlamını kurmak

**Başlangıç:** Kullanıcı, ajanın insan uzman gibi kalıcı yaşam öyküsü belleği olmadığı için eğitimi ve deneyimi her defasında yeniden edinmesi gerektiğini düşündü.

**Ayrım:** Genel parametreli kapasite, güncel kaynak erişimi, mesleki çalışma standardı, dışarıda korunan deneyim ve projeye özgü güncel durum aynı katman değildir. Yeni çağrıda genel eğitim silinmiş sayılmaz; belirli proje ve kurum bağlamı ise kendiliğinden taşınmış sayılamaz.

**Kazanım:** Uzmanlığı çağırmak, sadece “sen uzmansın” istemi değil, doğru güncel bağlam, araç, yetki sınırı ve deneyimle sorumluluğu üstlenebilir hale getirmektir. İşin başlanabilirliği ile aktörün işe hazır oluşu ayrılır.

**Sınır:** Dış bellekte saklanan öz değerlendirme doğrulanmış deneyime otomatik dönüşmez. Hafıza erişilebilirliği ve kullanımı ayrı incelenir; belirli bir bellek ürünü seçilmedi.

**Kaynak:** [U011](../sources/conversation/USER-MESSAGES.md#u011), [S011](../sources/conversation/assistant/S011.md). Konsolidasyon §§14–16; Atlas actor/readiness görünümleri ve Q10.

## L12 — Mekanizma görünümü, ideal işleyişi açar; onu gerçek kılmaz

**Başlangıç:** Kullanıcı §2.2'yi okurken dosyalara başvuran ve dallanan işlemleri program akışına benzetti.

**Kazanım:** Şemanın ana nesnesi her dosya değil; tetikleyici, girdi, sorumluluk, çıktı, koşul ve etki taşıyan işlem olmalı. Kaynak, talimat, anlık durum ve araç etkisi ayrı gösterilmeli. Geçişin kuralı ile değerlendirmenin doğruluğu aynı kesinlik değildir.

**Sınır:** Harita deterministikmiş gibi ideal davranışı inceleyebilir; model içinin tüm hesaplarını veya gerçek yürütme garantisini göstermez. “Kaydet” ile “kaydedildiği doğrulandı” ayrıdır. Atlas JSON'u SOUL'un kabul edilmiş veri modeli değildir.

**Kaynak:** [U013](../sources/conversation/USER-MESSAGES.md#u013), [S013](../sources/conversation/assistant/S013.md), [S014](../sources/conversation/assistant/S014.md), [S015](../sources/conversation/assistant/S015.md). Atlas v0.1 işlem/ilişki sözleşmeleri ve açık mekanizmalar.

## L13 — Yaşayan katmanlı plan, yerel iş seçiminin eksik kalan tamamlayıcısıdır

**Başlangıç:** Atlas işi keşfetme, seçme ve yeniden değerlendirme düzenini gösterdi; bütün projenin hiyerarşik planını aynı ayrıntıda göstermedi.

**Örnek:** Roman için 1–6 ana işler; yalnız 1'in 1.1–1.5 olarak açılması; çalışırken 6'ya not bırakma; 3 ve 4'ü yeniden sıralama. Başka dala not bırakmak, o işe başlamayı veya mevcut odağı terk etmeyi gerektirmiyor.

**Kazanım:** Bütün plan, bulunduğu dal, mevcut iş, üst amaç, ilerideki işler ve geri dönüş noktası birlikte recover edilebilmeli. Yakın işler ayrıntılı, uzak işler genel kalabilir. Hiyerarşi, sıra, gerçek bağımlılık, koşullu alternatif ve gelecek notu aynı ilişki değildir.

**Sınır:** S016'daki kapsam değerlendirmesi Atlas v0.1 için kısmi karşılık buldu: I03, M05/M07, M15–M17, I04, M02/M20/I11 ve Q07; birleşik proje planı modeli açık kaldı. Bu, Foundation'da planlama araştırılmadığı anlamına gelmez. Atlas v0.2 bu tur üretilmedi.

**Kaynak:** [U016](../sources/conversation/USER-MESSAGES.md#u016), [S016](../sources/conversation/assistant/S016.md), [U017](../sources/conversation/USER-MESSAGES.md#u017), [S017](../sources/conversation/assistant/S017.md).

## L14 — C keşfi, plan üretimi ve gerçek çalışma birbirini besler

**Kazanım:** C'yi netleştirirken bulunan koşullar aynı anda plan adaylarına veya karar ihtiyacına işaret edebilir. Fakat her koşul görev değildir; önceden sağlanan koşul yeni iş doğurmayabilir, alternatif yola ait iş koşullu kalabilir. C, plan ve gerçek Work ayrı ama birbirini değiştiren yüzeylerdir.

**Uzmanlık:** Bir dalı yürütecek uzman ayrıntılandırmaya katılabilir; bütünlüğü koruma sorumluluğu yine gerekir. Alt işlerin tamamlanması üst sonucun sentezini veya kabulünü otomatik sağlamaz: romanın mesajı/dönemi/hisleri belirlenmişken konu metnini birleştirmek hâlâ iş olabilir.

**Sınır:** WBS, HTN, rolling wave veya CMMN burada incelenecek dayanaklardır, seçilmiş SOUL metodu değildir. SAP/Asana/Jira/Trello ürün seçimi yapılmadı. Yeni odaklı araştırma önerisi yalnız açık sorudur.

**Kaynak:** [U017](../sources/conversation/USER-MESSAGES.md#u017), [S017](../sources/conversation/assistant/S017.md). Work sentezi ve deferred-relations kaynak yolları için [RESEARCH-REFERENCES](../sources/RESEARCH-REFERENCES.md).

## L15 — Denemenin birikimi kaynak, eser, yorum ve yetki ayrımıyla korunur

**Kazanım:** Kullanıcı bu oturumu gelecekte daha ayrıntılı denemelere zemin olacak antrenman olarak tanımladı. Konsolidasyon, Atlas, özgün diyalog ve sonraki eleştiri aynı şey değil. Aynı düşüncenin tekrarı bağımsız doğrulama değildir; bir arşiv kaydı mimari kabul oluşturmaz.

**Sınır:** Bu sayfa yeni çalışma talimatı veya proje çapında kabul kaydı değildir. Gelecekte bir tasarım kararı bu öğrenmeleri kullanırsa kendi yetkili kararını ve gerekçesini ayrıca kaydeder.

**Kaynak:** [U018](../sources/conversation/USER-MESSAGES.md#u018), [S018](../sources/conversation/assistant/S018.md), [U019](../sources/conversation/USER-MESSAGES.md#u019). [Paket STATE](../STATE.md).
