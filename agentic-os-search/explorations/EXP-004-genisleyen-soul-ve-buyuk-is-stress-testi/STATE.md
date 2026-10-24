# EXP-004 — STATE

**Güncelleme:** 2026-09-21, kullanıcı değerlendirmesiyle bounded exploration kapanışı.
**Güncel durum:** **EXP-004 / BOUNDED-COMPLETE / USER-EVALUATED / CLOSED.** Kullanıcı somut taslağın açıklanması ve durum değerlendirmesinden sonra EXP-004'ün kapatılmasını açıkça istedi. Korunan sonuç **MS01 — SOUL Çalışma Sistemi Taslağı v0.1, Checkpoint B + araştırma–mekanizma Açıklama C**'dir. Kavramsal exploration teslimatı tamamlanmış olarak kabul edildi; taslağın epistemik statüsü geçici mekanizma önerisidir. Nihai SOUL mimarisi veya gerçekleştirilmiş SOUL yeterliği kabul edilmedi.
**Güncel yetki:** Verilmiş kapanış kararını ve sonraki explorations için yeniden kullanım yolunu kaydetmek. EXP-004 içinde aktif araştırma, bekleyen kullanıcı değerlendirmesi veya otomatik sonraki Work yoktur. Yeni ürün, gerçek roman/öğrenci/okur deneyi, model/provider koşusu veya implementasyon yetkisi oluşmaz.
**Paket:** [Araştırma→mekanizma ve somut bileşim](artifacts/MS01-RESEARCH-TO-MECHANISM-MAP.md), [MS01 ana taslak — B](artifacts/MS01-SOUL-WORKING-SYSTEM-DRAFT.md), [banka yürüyüşü — A](artifacts/MS01-QUESTION-BANK-WALKTHROUGH.md), [roman yürüyüşü — B](artifacts/MS01-NOVEL-WALKTHROUGH.md), [kapsama/birleşim/açıklar/kaynaklar — B](artifacts/MS01-COVERAGE-AND-OPEN-MECHANISMS.md).
**Sonraki sorumluluk:** Bu tamamlanmış birikimi sonraki, ayrıca yönlendirilmiş explorations içinde uygun kaynak ve statüyle geri çağırmak. Şimdi yeni EXP, DQ05, genel karşılaştırma kampanyası veya implementasyon başlatılmaz.

## 0. Kullanıcı değerlendirmesi ve kapanış

**Kaynak:** Bu konuşmadaki 2026-09-21 tarihli kullanıcı mesajı; aşağıdaki doğrudan alıntı, eski U001–U016/S001–S015 kaynak kesimine eklenmiş yeni bir transkript değildir:

> Evet, bence de dördüncü konuşmada bir seviye daha ileri taşıdık konuyu. exp-004 konusunu kapatabilirsin. daha sonraki explorations konuşmalarında bu konuşmanında büyük yararı olacak.

**Karar kapsamı:** EXP-004'ün, araştırma bağlantıları açıklanmış somut MS01 taslağıyla tamamlanması ve daha sonraki düşünce/model çalışmalarında kullanılmak üzere korunması. Kullanıcının olumlu değerlendirmesi bütün teknik iddiaların bağımsız doğrulaması, P1–P9'un nihai mimari olarak benimsenmesi, kaynak ürünlerin kurulması veya G01–G07 yeterlik açıklarının kapanması değildir.

**Korunan teslimat kimliği:** MS01 ana taslak/roman/birleşim Checkpoint B yayını `397a00042171eee39e38ad2b27d4ba72894d4043`; soru-bankası Checkpoint A yayını `a0f3ab5f450b28d908a5a89d15a626637e322bfe`; araştırma–mekanizma Açıklama C yayını `2db53e57c4dba096a6a803433cfee9d7d99b2c90`. Bu kapanış ana çıktıların içeriğini yeniden yazmaz. Onlardaki `REVIEW READY`, kullanıcı değerlendirmesi bekleme ve sıradaki iş ifadeleri yazıldıkları checkpoint'e aittir; bugünkü paket durumu bu STATE'tir.

G01–G07 sonraki çalışmalar için açık araştırma/kanıt yükleri olarak korunur, EXP-004'ün aktif kuyruğu değildir. Kapanmış bir çalışma yeniden kullanılabilir ve sorgulanabilir; yeniden kullanım eski testleri otomatik tekrar etme veya bütün taslağı benimseme anlamına gelmez.

## 1. Amaç ve sınır

EXP-004, Foundation/studies birikimiyle SOUL'un büyük, uzun, çok aktörlü ve baştan tam bilinmeyen bir işi nasıl üstleneceğini düşünür. Kullanıcının drift itirazı ve [RV01](reflections/RV01-DIRECTION-REVIEW-AND-MECHANISM-TARGET.md) sonucunda kapanış çıktısı yalnız dikkat maddeleri değil, adlandırılmış parçaları ve işleyişi bulunan bir SOUL taslağı olarak belirginleştirildi.

B'de bu çıktı bir değerlendirme adayına ulaştı; C araştırma–mekanizma bağlantısını ve somut bileşimi açıkladı. O checkpoint'lerin sınırlı self-review ve kaynak karşılaştırması, yukarıdaki kullanıcı kapanış kararından ve bağımsız teknik doğrulamadan ayrıdır. Taslak adları Concepts ortak tanımı veya Foundation ground'larının servis listesi değildir. Gerçek SOUL/Development OS, roman, yıllık soru-bankası veya canlı model/okur/öğrenci deneyi yapılmadı. Esas çalışma EXP-004 içinde korundu; kapanışta ayrıca explorations kütüphanesinin yalnız bu pakete ait keşif/yönlendirme bilgisi güncellenir. Foundation, studies, concepts, diğer EXP paketleri ve agent-control korunur.

## 2. MS01 A'dan B'ye somut durum

A'da Host Runtime, Bootstrap Actor B0, Working State, başlangıç yöntem/araç ve owner/operator yetkisi kuruldu. K1 Mission Interpreter/Discovery Driver; K2 Work Coordinator; K3 Context Builder; K4 Capability Binder/Method Selector; K5 Domain Workbench; K6 Run Controller/State Committer/Effect Broker; K7 Change & Recovery Manager aynı işlev kimlikleriyle korunur.

P1 model yönlendirmesi/host yaptırımı; P2 mission başına tek mantıksal commit yolu/paralel candidate üretimi; P3 aktör–yöntem–bilgi–ortam ortak uygulanabilirliği; P4 start/result/effect sınırları; P5 library ile etkin configuration ayrımı korunur. Yedi zorunlu agent/process seçilmedi.

B'de P6 Work kipi/etkisine bağlı admission; P7 exact sıralı Assembly Snapshot ve Design/working assembly/Delivery Baseline ayrımı; P8 kaynak-bağlı süren Reading Pass ve farklı bilgi kipleri; P9 tekil yöntem yerine birlikte çalışan konfigürasyon incelemesi eklendi. Narrative Ledger, Scene Brief ve Revision Package ek servisler değil mevcut kayıt/Work sözleşmelerinin alan görünümleridir.

Roman yürüyüşü ilk keşif sahnesini, yazımdan doğan aday fikri, A/B motivasyon revizyonunu, bilgi aktarım boşluğunu, kaynak boyunca/ilişkili okuma düzenini, editoryal seçimi ve kesintiden dönüşü aynı K1–K7 içinde bağladı. Tam roman olmadığı için bütünsel kabul ve teslim son dalları koşullu tarif edildi; yapılmış veya olumlu sonuçlanmış sayılmadı.

Banka yürüyüşü Checkpoint A olarak değişmeden kaldı; iç örnek dilim ile yıllık hedef ve öğrenci sonucu ayrımı sürer. O dosyanın «roman sonraki iş» cümleleri tarihsel A yönüdür. MS01 B ve C'deki değerlendirme bekleme ifadeleri de artık tarihsel checkpoint'tir; güncel kapanış bu STATE'te kayıtlıdır.

İki senaryonun sınırlı birleşim/sadeleştirme incelemesi ve T1–T15/DQ01–DQ04 karşılıkları kapsam dosyasında bulunur. G01 keşif, G02 context/anlamsal etki, G03 gerçek host/etki/recovery, G04 qualification, G05 ilerleme/kapasite, G06 yöntem birleşimi/transfer, G07 gerçek uzun-eser üretme/değerlendirme yeterliği açık kalır. G07'nin kurgusal yürüyüş alt-işinin tamamlanması gerçek kapasite açığını kapatmaz.

## 2A. Açıklama C — araştırmadan bu SOUL'a

Yeni [eşleme](artifacts/MS01-RESEARCH-TO-MECHANISM-MAP.md) dokuz kullanım hattını somutlaştırır: RPD inquiry/return_to; Beads kalıcı iş/frontier/claim; Superpowers controller/task brief/review/ledger; OpenSpec proposed/current/yaşayan plan; gstack qualification/teslim ile araç öncesi hook; Hermes kısa skill indeksi/seçilmiş yükleme; Context/Memory/Harness ve Re3/DOC üretim bağlamı; Leantime hedef/teslimat ayrımı. Her hatta kaynak mekanizma, K1–K7 karşılığı, amaç/çıktı, uyarlama ve taşınmayan özellik ayrıdır.

Foundation girdileri, Work/Actors/Environment, Information/Selection, Binding/Standing, Revision ve Transition/Persistent Adaptation üzerinden hangi somut kayıt ve geçişin anlamını değiştirdikleriyle açıklanır. Araştırma dalı servis sayılmaz. Assembly Snapshot, Reading Pass, B0/grant ve ortak commit gibi yerel bağlantılar tek bir üründen kopyalanmış veya bilimsel olarak yeni bulunmuş sayılmaz.

Somut okuma için host/ortak yazıcı, B0 koordinatör, ayrı üretim–inceleme bağlamları, kalıcı çalışma/kaynak deposu, indeksli yöntemler ve gerçek owner katkısı bir örnek bileşim olarak verildi. Belirli ürün/model/DB veya evrensel agent sayısı seçilmedi. Hermes indeks→tam yükleme ve gstack PreToolUse bağlantıları bu tur primary kaynakla daha açık eşleştirildi; bu ayrıntıların geçmişte aynı açıklıkta kurulduğu iddia edilmez.

Gas Town Hook'u aktöre bağlı iş kuyruğu, MS01 before_effect hook'u çağrı öncesi müdahale noktasıdır; isim benzerliğiyle aynı sayılmadı. Gas Town topolojisi alınmadı. Beads ready ile OpenSpec artifact ready da ayrı tutuldu. Yeni T16, DQ05 veya A/B yürüyüşlerini tekrar çalıştırma yoktur; bu kaynak haritası gizli implementasyon kararı değildir.

## 3. Korunan birikim ve kaynak statüsü

T1–T15/SC02, SY01, DQ01–DQ04 ve RV01 tamamlanmış önceki kavramsal girdilerdir; yeniden yapılacak iş değildir. MS01 bunları kaynak transkripti veya gerçek deney sonucu yapmaz. T sayısı T1–T15 olarak kalır.

Korunmuş kaynak arşivi U001–U016 / S001–S015, 31 görünür mesaj ve 16 dosyadır; kümülatif kaynak adresi 126. [Diyalog INDEX](sources/conversation/INDEX.md), [manifest](SOURCE-MANIFEST.json), [aktarım sınırı](checks/TRANSCRIPTION-NOTE.md). İlk yoğunlaştırmalar ayrı tarihsel dizinde; sonra görünen özgün yanıtlardan tam aktarım yapılmıştır. T08 türev notu S015 özgün yanıtıyla aynı belge değildir. Platform export'u veya bağımsız transkripsiyon doğrulaması iddiası yoktur.

Arşiv onarımı kapalıdır: PR #31, merge `b949fe66454a1943ac9c99827e79f68f962658be`, kapanış `e372ed7558b0b0ebbf388c864b0733382d1418ba`. [PUBLICATION](checks/PUBLICATION.md) bu onarımın tarihsel kaydı, MS01 veya kullanıcı kapanışının yayını değildir. MS01 ve bu kapanış kaynak sayısını artırmaz; kaynak/manifest/onarım dosyaları değişmez.

## 4. Yayın ve kanıt sınırı

MS01 A yayını `a0f3ab5f450b28d908a5a89d15a626637e322bfe`; B yayını `397a00042171eee39e38ad2b27d4ba72894d4043`; C yayını `2db53e57c4dba096a6a803433cfee9d7d99b2c90`. RV01 yayını `0dd58080eeea4ee8c7eaaaef0902d02fce825edc`. Önceki ana yayınlar: SY01 `000786d1f7742ac87937017ac9cea18a5e329865`; DQ01 `06dcefc2f192cb0cd4eb216d3f3194c2bfa48269`; DQ02 `3a9359a8bdf75203358dcda5b2fcdb2fb3eac3ef`; DQ03 `97627337ad622b715f3a9c562d62bb11ecda5d31`; DQ04 `49029c8ed9027745850627a529290e079c1f09a4`.

B'nin ana taslağı, roman/kapsam dosyaları, banka A ve C eşlemesi korunur. C'nin yazma kapsamı araştırma–mekanizma eşlemesi ile STATE/INDEX'ti. [Kapanış öncesi C STATE](https://github.com/batuhanozgun/agentic-os-search/blob/2db53e57c4dba096a6a803433cfee9d7d99b2c90/explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/STATE.md), [B STATE](https://github.com/batuhanozgun/agentic-os-search/blob/397a00042171eee39e38ad2b27d4ba72894d4043/explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/STATE.md), [A STATE](https://github.com/batuhanozgun/agentic-os-search/blob/a0f3ab5f450b28d908a5a89d15a626637e322bfe/explorations/EXP-004-genisleyen-soul-ve-buyuk-is-stress-testi/STATE.md) ve önceki uzun girişler kendi immutable ref'lerinden korunur. Önceki kaynak ve araştırmalar yeniden yazılmadı.

C'de ilgili repository bulguları ve gstack/Superpowers/Hermes'in dar primary kaynakları geri açıldı; Re3/DOC HTML yöntem metni yeniden karşılaştırıldı. Tam/seçici okuma sınırları eşleme §7'de; A/B'nin önceki okumaları kendi kayıtlarında. Hiçbir model/runtime/DB/hook/test suite çalıştırılmadı.

**Kapanış güncellemesinin başlangıç main'i:** `d7e7a0caf051cd9e70193a5ae62383333a3cb7f2`. C sonrasında yalnız ECC paketindeki iki dosyanın değiştiği ref karşılaştırmasında görüldü; bu çalışma onları geri almaz veya değiştirmez. Kapanış yazımı yalnız bu STATE, paket INDEX ve explorations/INDEX–CATALOG içindeki EXP-004 yönlendirmeleridir. Yeni araştırma veya yöntem deneyi yapılmaz. Bu STATE kendi gelecekteki commit/readback başarısını önceden ilan etmez; yayın kontrolleri teknik güvence, içerik doğruluğu veya yeterlik kanıtı değildir.

## 5. Sonraki explorations için yeniden kullanım

**Paket kapanmıştır; sıradaki aktif EXP-004 işi yoktur.** Sonraki konuşma önce buradaki kabul kapsamını geri kazanır, sonra ihtiyacına göre [INDEX](INDEX.md) üzerinden MS01 ana taslağına, araştırma–mekanizma eşlemesine, iki yürüyüşe ve kapsama/açıklar kaydına gider. Birikimin bütününü ilk kez devralan çalışma için SY01 ve DQ01–DQ04'ün tam okuma rotası korunur; ilgili asıl T/kaynak ve research primary yüzeyine iddianın gerektirdiği derinlikte dönülür. Aynı konuşmada tam okunmuş değişmemiş kaynaklar yeniden okunmuş gibi raporlanmadan kullanılabilir.

Daha sonraki exploration, bu paketten hangi mekanizmayı veya ayrımı devraldığını, hangi açık soruyu yeniden ele aldığını ve neyi değiştirdiğini kaynak/sürüm bağıyla belirtebilir. MS01'i tekrar baştan üretmek, eski testleri bekleyen iş saymak veya bütün K1–K7/P1–P9'u dokunulmaz mimari kabul etmek gerekmez. Yeni görüşler eski konuşma kayıtlarını sessizce yeniden yazmaz.

Kalan G01–G07, sonraki somut araştırma veya geliştirme kararları için yeniden çağırma noktalarıdır; bu kapanışı iptal eden gizli tamamlanmamış teslimatlar değildir. Yeni bir exploration, mevcut paketi yeniden açma, gerçek deney veya Development OS/SOUL implementasyonu ancak sonraki açık kullanıcı yönüyle başlar. Bu turda yeni konu veya aşama seçilmedi.
