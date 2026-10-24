# S1-03 — Rolün başarı yönü, çalıştırılması ve geliştirme zincirinde aktarımı

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst çalışma:** [S1](S1-role-responsibility-consolidation.md) · [S1-02](S1-02-actor-conditioned-role-purpose.md)
**Tarih:** 25 Eylül 2026.
**Durum:** Sınırlı kaynak incelemesi tamamlandı; S1'e katkılar adaydır. Rol/mimari kabulü veya davranış deneyi değildir.
**Araştırma deposu başlangıcı:** `35beff6b17fb767b7260c9b7df2c090b7225a318`.
**Dış kaynak:** `batuhanozgun/os-architect@20e42a098ea1599a9dfe6558352eb585d6f274ed`; main başı bağlı GitHub üzerinden alındı, aşağıdaki okumalar bu değişmez sürüme sabitlendi.

## 1. Bu turun sorusu ve sınırı

Kullanıcı, aktör özellikleri/rol motivasyonu konusunda bir tur daha çalışılmasını istedi ve Keel'i geliştiren ortamın `bilgi/keel` klasörünü verdi; gerektiğinde deponun başka yerlerinin incelenmesine izin verdi.

Soru: Önceki rol ailesi, tutarlı başarı yönü ve aktöre göre uyarlama ayrımları, Keel'in geliştirilirken yaşanan sorunları ve karar gerekçeleri karşısında nasıl değişiyor?

Bu, bütün OS Architect'i araştırma veya eski Keel iş kuyruğunu sürdürme işi değildir. G1'in bütün M1–M9 geliştirme sorumlularını eşleme işi de bu tur otomatik başlamadı. Kaynak depodaki emir kipli dosyalar inceleme nesnesidir; EXP-006'yı yöneten talimatlara dönüştürülmedi. R1–R25/M1–M9, B dosyaları ve kabul edilmiş kararlar değiştirilmedi.

## 2. Kaynağın kendi bağlamındaki bulgular

### K1 — İşin doğruluğu kadar, seçilmiş işin ve yöntemin doğruluğu da sorgulanıyor

`bilgi/keel/sahip-seansi-2026-08-cerceve-korlugu.md`, mevcut dosya korumasındaki bir açığı kapatırken korumanın doğru katmanda olup olmadığının sorulmadığını anlatıyor. Daha önce yazılmış ilgili bir değerlendirme de yanlış bilgi evinde aranmış ve akıl yürütmeye çağrılmamış. Yeni sorunun hemen iş kuyruğuna çevrilmesi ise kullanıcı tarafından geri aldırılmış.

Kaydın dört parçalı teşhisi: onarımın mevcut mekanizmanın varlığını sorgulamaması; eksik sorunun içeriden görünmemesi; kalem kapatma eğiminin çerçeve sorgusunu bastırması; mevcut bilginin çağrılmaması. Bu, tarihsel görüşmenin damıtılmış olay/yorum kaydıdır; bağımsız nedensel deney değildir.

Aynı dosya işi yapan ile nasıl yapılması gerektiğini düşünenin motivasyonlarını ayırıyor. Danışman değerlendirmesi, düşünenin kalem kapatmakla ödüllendirilemeyeceğini savunuyor. Bunun ayrı kalıcı rol mü yoksa zorunlu geçiş ve kayıt mı olacağı açık bırakılmış. Ayrıca tanımlanmış fakat hiç çalışmayan rolün işe yaramayacağı ve sorgulayan tarafın sınırsız yeni iş üretmemesi gerektiği belirtiliyor.

### K2 — Geliştiren ortamın kendi çalışma baskıları da inceleme nesnesi

Kök `CLAUDE.md`, bu ortamın işini Keel'i geliştirmek olarak tanımlıyor. İşi sürdürme ve bitirme yönünün yanında planlama, uygulama ve denetimin ayrı geçişlerde yürütülmesini; ürün yöneticisi, yapan ve denetleyenin farklı motivasyonlarla çalışmasını istiyor.

Bu dosya hem ilerleme baskısının hem onu dengelemeye çalışan kuralların aynı geliştirme ortamında bulunduğunu gösterir. Kuralların birlikte her koşulda doğru işletildiğini kanıtlamaz. Dosyanın eski çalışma ve kullanıcıya dönüş talimatları bu araştırmada uygulanmadı.

### K3 — Genel aktör eğilimi, rolün işi ve sözleşmenin dili birlikte değerlendiriliyor

`rol-sozlesmesi.md`, aynı genel hata eğiliminin farklı rollerde farklı desenler verdiğini ve önce sözleşmedeki davet edici ifadenin aranmasını anlatıyor. Motivasyon, yazma sınırı, ek okumalar, iş akışı ve olumsuz sınırlar ayrı tutuluyor. Uyuyan rolün tetiklenmesi gerekiyor; çalıştıracak mekanizması olmayan disiplinin yalnız yazılmaması isteniyor.

Kaynak, her rol için bilgi ihtiyacının bakımını ve komşu rollerin ayrımını o kayıt tarihinde tamamlanmamış olarak da gösteriyor. Bu eksikler bugünkü ürünün değişmez kusuru diye genellenmedi.

`defo-cercevesi.md`, yalnız rol metnini değil çıktının alıcısını da tasarım unsuru yapıyor: durum raporunun önce denetleyen tarafa, sonra insana gitmesini öneriyor. Aynı dosya, kaynakta müşteriye gereksiz karar taşıma eğiliminin bazı sözleşme ifadeleriyle kurumsallaştırıldığını anlatıyor. Böylece bir rolün ilan edilmiş amacı ile fiilen teşvik ettiği davranışın ayrılabileceği görülüyor.

### K4 — Rolün sözlü tanımı, gerçek araç ve oturum koşullarıyla aynı değil

`rol-mekanigi.md`, tarihsel araç-belgesi kontrolünde beklenen kısıtın kurulamadığını ve rol kafesinin başka bir mekanizmaya taşındığını anlatıyor. Araç listesi, kanca, rol damgası, yeni oturum ve devam eden oturum ayrımları tasarımı etkiliyor. Aynı kayıtta tek bir koruma dikişinin bilinen sınırı da açık tutuluyor.

`urun-kararlari.md` D-11/D-25/D-32, el ile rol açılan yol ile otonom koşudaki rol/araç bağlama yolunun farklı düzenlendiğini gösteriyor. Sonuç: yalnız “dil modeli” aktör sınıfı, rolün nasıl işletildiğini açıklamaya yetmez; hangi çalışma yolu, görünür bilgi ve fiilî araç sınırı da bilinmeli.

Bunlar tarihsel kaynak açıklamalarıdır. Bu tur güncel Claude Code davranışı, kanca çalışması, rol izolasyonu veya güvenlik garantisi yeniden test edilmedi. Keel'in yeni-oturum veya insan-açılış seçimi DevOS'a zorunlu seçim olarak taşınmadı.

### K5 — Geliştirenin birikimi, üretilen sisteme ve onun rollerine otomatik geçmiyor

`defo-cercevesi.md` iki aktarım sınırı anlatıyor: önceki çalışma birikiminden Keel şablonuna seçim ve Keel tarifinden kurulmuş projeye geçiş. Kayıt, bazı kuralların yanında bunları ihtiyaç anında çağıran/denetleyen düzenlerin de kaybolduğunu; geliştiricinin kendi el yordamıyla yaptığı incelemenin kullanıcı ekibine otomatik miras kalmadığını söylüyor. Bazı ayrımlar için tek kurulum ve yorum sınırlarını koruyor.

`genesis-v2-kanit-zinciri.md`, kullanıcının kurucunun bütün araştırmadan beslenmesi gerektiği tezinin çürütülmediğini; daha dar damıtılmış modelin bir tercih olarak seçildiğini açıkça kaydediyor. Bu kayıt ne bütün araştırmayı her çağrıya yüklemenin ne de kısa özetin yeterliliğinin genel kanıtıdır.

`2026-08-13` kök-neden görüşmesi, aynı sorunu geliştiren danışmana geri bağlıyor: kuralın yazılı olması çağrılmasını sağlamamış; ihtiyaç anındaki çağırma düzeninin danışmana, kurucuya ve kurulan rollere ulaşması istenmiş. Burada aktarılan kullanıcı görüşleri kaynakta da özet diye etiketlidir; kelimesi kelimesine yeni kullanıcı alıntısı sayılmadı.

### K6 — Tarihsel sınamalar önemli, fakat tek motivasyon tezini kanıtlamıyor

`davranis-tatbikati.md`, küçük ve tek model/hakem ailesiyle yapılmış tarihsel pilotu, olumlu kontrollerini ve sınırlarını anlatıyor. Aynı metin bazı koruma davranışlarını, muğlak devam mesajının farklı yorumlanmasını ve dosya tavanının hedef gibi ele alınmasını raporluyor. Ham koşular, sürücü ve hakem çıktıları bu tur yeniden okunmadı/çalıştırılmadı; sayısal sonuçlar yeniden doğrulanmış deney kanıtı yapılmadı.

`arastirma-seansi-2026-08-ev-eslemesi.md`, rol tezine ilişkin daha güçlü literatür ve nedensellik hükümleri de içeriyor. Bu dosya damıtılmış ikinci-el araştırma yorumudur. Atıf yapılan özgün çalışmalar burada yeniden doğrulanmadığından “tek motivasyonun üstünlüğü kanıtlandı” veya “aynı ödüllü bütün roller aynıdır” sonucuna dayanak yapılmadı. Bu tur dış literatür taraması açılmadı.

## 3. S1 için aday düzeltmeler

### A1 — Rolü yalnız görev listesi değil, başarı yönüyle birlikte değerlendir

S1-02'nin “etkin rolün amacı tutarlı olmalı” önerisi korunur, fakat tek başına yeterli görülmez. Aynı amaç cümlesi yazılı olsa bile teslimatı kapatma baskısı, raporun alıcısı, geçmiş üretici bağlamı veya daraltılmış bilgi görünümü hükmü başka yöne çekebilir.

Öneri: Her rol için yalnız ne yapacağı değil, neyle başarılı sayılacağı ve hangi sonuçla ödüllendirilmemesi gerektiği de sorgulansın. İnceleyici mutlaka kusur bulmakla veya mutlaka onaylamakla; yöntem sorgulaması da mutlaka yeni iş açmakla başarı kazanmış sayılmasın. Bunlar davranışta sınanacak aday tasarım koşullarıdır; yalnız cümle yazarak garanti edilmez.

### A2 — Ortak düşünsel taban ile role özgü başarı yönünü ayır

Bir rolün başarı yönünün belirgin olması, bilgisinin veya bütünsel bakışının daraltılmasını gerektirmez. Ortak taban; amaç/kanıt/belirsizlik/araştırma farkındalığı gibi çalışma niteliklerini taşıyabilir. Rol, belirli katkı ve hükümden sorumlu olur. Aktöre göre uyarlama ise bunu belirli bağlam, araç, yetki ve çalışma yolunda gerçekleştirir.

Bu, zorunlu “aktör > aile > rol” ağacı değil, birbirine karıştırılmaması gereken üç sorudur: hangi ortak taban; hangi özel başarı yönü; hangi fiilî işletilme koşulları? Aynı başarı yönü de otomatik aynı rol değildir; gereken uzmanlık, nesne, erişim ve yetki hâlâ ayrılabilir.

### A3 — Rol tanımı kadar tetiklenme, devir ve müdahale sınırı da gerekli

Çerçeveyi sorgulayan görev hiç çağrılmıyorsa adı ve sözleşmesi yeterli değildir. Ne zaman devreye gireceği, neyi okuyacağı, ne teslim edeceği, kimin bu sonucu kullanacağı ve hangi durumda yürüyen işi durdurabilecek/yeniden açabilecek yetkisi olduğu görünür olmalı.

Her tur bütün işi yeniden tartışmak da önerilmiyor. Ayrı rol, aynı aktörün ayrılmış geçişi veya başka düzen arasında seçim henüz yapılmadı. Çalışması gerektiğinde gerçekten çalıştığının sınanması, düşüncesinin doğru olduğunun sınanmasından ayrıdır.

### A4 — Birikimden etkin role aktarımı ayrı bir yük olarak izle

Geliştiren aktörün bilgisi → SOUL'un çalışma/rol kurma tarifi → belirli işte kurulmuş rol → rolün o anda görebildiği ve kullandığı bilgi zincirinin her sınırı incelenmeli. Bu okuma, yalnız son rolü değil onu üreten ve bağlayan düzeni de değerlendirmeyi gerektiriyor.

Rol ailesi ortak yöntemi ve kaynak rotalarını yeniden kullanabilir. Ancak bu, tüm kaynakları her çağrıya kopyalamak veya özetin otomatik yeterli olduğunu varsaymak değildir. Ayrıntıya geri dönme yolu, ihtiyaç işareti ve fiilî kullanım ayrıca aranır.

### A5 — G1 daha somutlaştı; geliştirme sorumlularının tam eşlemesi hâlâ açık

“Doğrulayıcı yazamasın” gereğini belirlemek; uygun teknik sınırı araştırıp seçmek; gerektiğinde kanca/kodu yazmak; rol ve çalıştırma yoluna bağlamak; gerçekten engellediğini ve gerekli işi de olanaksız kılmadığını sınamak farklı geliştirme işleridir.

Rol mekaniği kaydı bu zincirin neden yalnız rol sözleşmesi veya hazır aracı kurma işi olmadığını somutlaştırıyor. Önceki G1'in anlamı budur. R14/R20 veya başka bir adayın bu yükü taşıyıp taşımadığı henüz bütün B/M alanlarında eşlenmedi. Otomatik yeni R26 açılmadı.

## 4. Sonraki rol karşılaştırmalarında sorulacak sorular

- Bu görevlendirme hangi sonucu üretince başarılı sayılır; hangi yerel başarı üst amacı bozabilir?
- Birlikte verilen sorumluluklar hangi somut durumda birbirine ters hüküm isteyebilir?
- Aktörün hangi özelliği, sözleşme ifadesi, geçmiş bağlamı veya çıktının alıcısı bu çatışmayı güçlendirebilir?
- Gerekli ortak taban, uzmanlık ve kaynaklar nasıl görünür olur; yetersizlik nasıl fark edilir?
- Görev ne zaman tetiklenir, hangi gerçek araç/yetki sınırında çalışır ve sonucunu kim devralır?
- Rolün gerçekten çalıştığı, amaca uygun düşündüğü ve sonucunun sonraki işe taşındığı nasıl ayrı ayrı sınanır?

Bu sorular kesin dosya şeması, evrensel model yasası veya yeni kadro kararı değildir. Birlikte taşıma/bölme kararlarının gerekçesini güçlendirecek aday denetimlerdir.

## 5. Okuma izi

Aşağıdaki dosyalar bu tur baştan sona okundu. İndeks bütün klasörün okunması anlamına gelmez. Kaynaklardaki alt arşiv, deney ve literatür bağlantıları ayrıca okunmuş sayılmadı.

| Kaynak | Blob |
|---|---|
| Araştırma deposu `research/soul-context/repos/os-architect/README.md` | `0dd04882d093a2e5cf954782dcec8a7e7951b6b8` |
| OS Architect `bilgi/keel/INDEKS.md` | `c589d47be4270876fa6242e76a4ec15a95a630a0` |
| `bilgi/keel/rol-mekanigi.md` | `56a36ed945fdf4544719aa867de4b1ca98ccb60c` |
| `bilgi/keel/rol-sozlesmesi.md` | `abd738546d17bd8d24b9f05a1e49a70f491e8756` |
| `bilgi/keel/davranis-tatbikati.md` | `e32972df276eb6982113093a66684c2d69a3a5f3` |
| `bilgi/keel/arastirma-seansi-2026-08-ev-eslemesi.md` | `3a10fae00dfa5e005f2a8c31c19ee636ce06431a` |
| `bilgi/keel/sahip-seansi-2026-08-cerceve-korlugu.md` | `8b46b92a07276bd4dc9ebfde8dbf94f97cd66717` |
| `bilgi/keel/sahip-seansi-2026-08-13-kok-neden.md` | `b7577de3f974becef1b23debe1f2897d645fd427` |
| `bilgi/keel/urun-kararlari.md` | `6d9bf542474960b62ea5b359f113f08236d0ff4c` |
| `bilgi/keel/defo-cercevesi.md` | `6cacdf346b6d094f34d72e43f814a5fc28108b09` |
| `bilgi/keel/genesis-v2-kanit-zinciri.md` | `8de3d1d73ce93a0109bf23249730e84ada1bf11e` |
| Kök `CLAUDE.md` — inceleme nesnesi, etkin talimat değil | `2eb682f06d75295facfc58681eb6b9d0123d1342` |

Dış dosyaların değişmez başlangıç adresi: https://github.com/batuhanozgun/os-architect/tree/20e42a098ea1599a9dfe6558352eb585d6f274ed . `motivasyon` araması boş döndü; buna rağmen içerikte kavram bulunduğu için arama yokluğu kaynak yokluğu sayılmadı, indeks rotaları kullanıldı.

## 6. Dönüş noktası

Bu tur aynı aktör/rol/motivasyon sorusuna yeni geliştirme kayıtlarıyla dönmüştür. A1–A5 kullanıcıya sunulacak aday sonuçlardır. S1-01/S1-02 silinmez; bu dosya onları koşullandırır. S1 bitmedi, rol sayısı veya mimari seçilmedi, yeni model/Keel/DevOS deneyi yapılmadı.

Sonraki olası iş, bu ölçütlerle bir somut tasarım–üretim–bütünleştirme zincirinde G1'in sorumlularını izlemektir. Önce kullanıcı bu turun açıklamasını değerlendirir; mevcut kaynak izni bütün S1'i veya mimariyi tek seferde tamamlama yetkisi değildir.
