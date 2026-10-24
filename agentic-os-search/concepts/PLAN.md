# Concepts — Hazırlık ve yürütme planları

Sürüm: v0.3-working, 2026-09-19. B1/B2 ve B3/B4 tamamlandı; B5 kapsam kaydı oluşturuldu ve B6 kalıcı aktarımı başladı. Güncel tamamlanma/yetki yalnız STATE.md'dedir. Bu plan eski concepts çalışmasının devamı değildir. Kaynak yetki ORIGIN.md/U01–U05 ve sonraki devam/kapsam açıklamaları; gerekçe CHARTER.md. İki pilotun tamamlanması ortak terim tanımı, bağımsız yöntem doğrulaması veya mimari kabul değildir.

## Plan A — Repo hazırlığı

Bu bölüm hazırlanmış düzenin tarihsel plan kaydıdır; tekrar yürütme talimatı değildir. Gerçek durum ve yeniden açmayı gerektiren değişiklik varsa STATE.md'den alınır.

### A1. Yeni başlangıcı ve kapsamı kaydet

ORIGIN.md kaynak kullanıcı mesajlarını, CHARTER.md amaç ve iki riskin nedenlerini taşır. Hazırlıkta METHOD.md ve bu plan taslak statüsündeydi. STATE.md hazır olanla yapılmamış işi ayırır; INDEX.md yeni oturum girişidir.

U05 talebiyle hazırlığın pilotlardan önce kalıcılaştırılması yetkilendirildi. Bu, ilk taslaktaki bütün yazıları denemeler sonrasına bırakma sırasının yalnız hazırlık bakımından değişmesiydi; iki deneme, yöntem değerlendirmeleri ve seri çıkarımın daha sonra başlaması korundu. Hazırlık yazma yetkisi, yapılmamış denemeyi tamamlandı işaretleme yetkisi değildi.

### A2. Eski etkin yönlendirmeleri kaldır

Hazırlık değişiklik kapsamı: README.md; research/INDEX.md; research/studies/INDEX.md; research/studies/CATALOG.md; research/studies/PACKAGE-CONTRACT.md içindeki concepts bölümleri. Araştırma satırları, bulguları, mevcut araştırma yetkileri ve paket durumları bu nedenle değiştirilmez.

Kontrol değişikliği yalnız concepts için yapılmıştı: AGENT.md'de R09 sorusunun bu ayrı programı açıkça kapsaması; agent/protocols/candidate-research-library.md içindeki concepts istisnasının yeni aşama sırası, iki riskin görünürlüğü ve giriş okumalarıyla uyumlandırılması. Genel candidate-study kuralları ve R01–R08 korundu. Bu tarihsel kayıt yeni kontrol mutation'ı yetkilendirmez.

Eski concepts dosyaları geri getirilmez. Araştırmalardaki aynı adlı dış dosyalar veya sözcükler topluca silinmez. Tarihsel konuşma/kanıt kayıtları, zaten tarihsel statüleri korunarak bırakılır; güncel yöntemin kaynağı sayılmaz. Başlangıç taraması ve koruma sınırı SETUP-REVIEW.md'de raporlanır.

### A3. Yayın ve devralma kontrolü

Mevcut main üzerinde SHA kontrollü, sınırlı dosya güncellemeleri kullanılır; yeni branch veya geçmişi yeniden yazma yoktur. Eşzamanlı değişiklik varsa son içerik geri kazanılmadan üstüne yazılmaz. Yeni çalışma dosyaları giriş yönlendirmelerinden önce yayınlanır. Kesinti varsa STATE hazırlığı tamamlandı göstermez.

Son karşılaştırmada yalnız izin verilen dosyaların değiştiği; eski etkin yöntem parçalarının kaldırıldığı; yeni bağlantıların çözüldüğü; amaç/taslak/yetki/durum ayrımlarının tutarlı olduğu kontrol edilir. Bu inceleme statik ve aynı assistant tarafından yapılan bir kontroldür; gerçek yeni-oturum davranış başarısı veya bağımsız doğrulama değildir.

## Plan B — Çalışmanın uygulanması

| Adım | Yapılacak iş | Çıkış koşulu |
|---|---|---|
| B1 — İlk deneme | research/studies/context-memory-harness-engineering araştırmasının gerçek dosya envanteri ve tam okuması; kullanımları sohbet içinde gösterme. | Dosya/temsil kapsamı açık; kullanım ve yorum izleri görünür; kapanış kapsamı aşmıyor. |
| B2 — İlk değerlendirme | Şema, kaynak atfı, belirsizlik, okuma devamı, eski-yeni yorum ilişkisi ve kullanıcıya açıklanabilirliği değerlendirme. | Ne değişti/ne korunuyor ve neden belli; başarısız ölçütler silinmemiş. |
| B3 — İkinci deneme | research/studies/superpowers araştırmasında yöntemi aynı disiplinle, sohbet içinde uygulama. | Farklı korpusta sınama; gereken tüm okumalar ve kaynak tarafından kullanım kapsamı kontrolü tamamlanmış. |
| B4 — İkinci değerlendirme | Yöntemi yeniden değerlendirme, gerekli değişiklikler ve kalıcı çıkarım düzeni kararı. | Gerçek pilot sonuçları ve yöntem dersleri devralınabilir; sonraki değişmiş yöntem geriye dönük bağımsız doğrulanmış sayılmıyor. |
| B5 — Seri çıkarım hazırlığı | Studies'in gerçek paket/dosya envanteri, koleksiyon/alt çalışma/taşınma ilişkileri ve güncelleme takibi; concepts/SCOPE.md oluşturma. | Katalogla yetinilmeyen kaynak-sürümlü kapsam ve net sıra. |
| B6 — Araştırma bazında çıkarım | Her araştırmayı tam okuyarak concepts/studies/<araştırma-yolu>/ içinde kullanımları ve okuma/yorum değişimlerini kaydetme. | Tüm paketler hesaba katılmış; kaynaklar, okumalar, belirsizlikler ve delta kontrolleri açık. |
| B7 — Küresel geçiş kontrolü | Yeni/değişmiş/okunamamış kapsamı kontrol etme; bütün çıkarımların ortak okumaya hazır olup olmadığını değerlendirme. | METHOD §5 koşulları karşılanmış; tamamlanmamış kapsam sessizce kapatılmamış. |
| B8 — Ortak değerlendirme | Bütün concepts çıkarımlarını okuma; anlam/sınırları ayırma, gerekirse alt kavram ve ad önerme; örnek/karşı örnekle referansı sınama. | Kaynak kullanımından ayrı, gerekçeli ve sınırları açık yerel referans; çözülmeyen ayrımlar görünür. |

B1/B3 paket seçimleri bu konuşmada çalışma sırası olarak benimsendi; kaynakların tanımlarının doğru kabulü değildir. Her iki pilot kendi kaynak kapsamıyla kapandı; bu, diğer araştırmaların çıkarımına veya ortak sözlüğe ilişkin tamamlanma değildir.

## Pilotların statüsü ve aktarım sınırı

Pilotlar tek tura zorlanmadı. İlk pilot sekiz dosyada P1-T1–T3, ikinci pilot 52 dosyada P2-T1–T5 boyunca yürütüldü. İkinci pilotun son turu yeni bir ürün araştırması değil, kaynak tarafından döküme kontrol, ekler ve B4 değerlendirmesidir. Ayrıntılı okuma ve yayın kayıtları STATE'in değişmez checkpoint bağlantılarındadır.

Pilotların özgün terim çıktıları sohbet içinde kalır. Mevcut STATE/PLAN/METHOD yüzeylerine durum ve yöntem değişikliği kaydetmek, kalıcı TERMS üretimini başlatmaz. Yeni oturumda görünür sonuç erişilemiyorsa STATE özetinden terim listesi uydurulmaz; gereken içerik sabit kaynaktan yeniden çıkarılır ve bu yeniden üretim olarak belirtilir.

Kalıcı aktarım B6'da kaynak sürümü ve bütün pilot ek/düzeltmeleriyle birlikte kontrol edilerek yapılır. Erişilebilir, değişmemiş ve gerçekten okunmuş içerik sırf yeni aşamaya geçildi diye mekanik olarak yeniden araştırılmaz. Aktarım yapılmadan kalıcı dosya var veya seri çıkarım tamamlandı denmez.

İki pilot farklı çalışma düzenlerini sınadı; iki çalışmadan ortak terim tanımları üretmedi. B8 bütün kapsamın çıkarımı ve B7 bitmeden başlayamaz. B8'in ayrıntılı kayıt düzeni şimdiden dondurulmaz.

## B5'in somut işi ve kalıcı düzen

1. Güncel research/studies/ ağacını ve katalogu birlikte kontrol et. Her fiziksel dosya, paket ve iç içe çalışma kapsam hesabına girer; klasör adına bakarak bağımsız araştırma varsayılmaz.
2. concepts/SCOPE.md içinde kaynak ref'i, paket yollarını, koleksiyon/alt çalışma/taşınma ilişkilerini, kendi araştırma durumlarını ve concepts çıkarım durumlarını ayrı kaydet. Planlı araştırma, mevcut dosya okuması ve bitmiş dış yapı bilgisi aynı durum değildir.
3. Pilot kaynak sürümleri ile yeni main arasındaki ilgili değişiklikleri çıkar. Yeni/değişmiş içerik pilotların eski kayıtlarına sessizce eklenmez; hangi kayıtların yeniden değerlendirilmesi gerektiği belirlenir.
4. İş sırasını kaynak ilişkileri ve mevcut kapsamla belirle. Salt popüler terim veya hazır ürün listesi başlangıç filtresi yapılmaz. B5'in envanteri henüz B6'nın bütün paketlerinin tam okuması sayılmaz.
5. B6'da her paket için READING.md ve TERMS.md oluştur. READING dosya/sürüm/okuma/kapsam kontrolünü; TERMS kullanım/sınır/kaynak/yorum değişimini ve kısa ilişki görünümünü taşır. Büyürse parçalar giriş dosyasına bağlı bölünür. Global STATE bu kayıtları tekrarlamaz; aktif iş ve devam yolunu gösterir.

Bu yerleşim kararı B4 sonucudur; SCOPE veya araştırma bazlı dosyalar B4 turunda oluşturulmadı. B5/B6 mevcut kullanıcı planının yetkili devamıdır; aynı amacın tekrar onaylatılması gerekmez. Maddi amaç/kapsam/aşama değişikliği ayrıca değerlendirilir. Genel tanım araştırması, dış ürün kurulumu, canlı deney, mimari/adoption ve kontrol katmanı değişikliği bu yetkiye dahil değildir.

## Değerlendirme ölçütleri ve B4 sonucu

Değişmeyen ölçütler: kaynak tarafındaki okumadan çıkarıma geri kontrol; atlanan jargon/kullanım; özgün anlamın yorumla karışması; eşit olmayan anlamların birleştirilmesi; aynı kaynağın tekrarının bağımsız delil sayılması; değişen yorumun ilgili kayıtlara yayılmaması; basitleştirmede ayrım kaybı; yeni oturumda belirsizlik veya devam noktası kaybı. Terim sayısı tek başına başarı değildir.

P2-T5, ana ilişki düzenini korurken bazı kapsam açıklıklarını ve daha az görünür teknik adları ekledi. Bootstrap istisnası, hook/registration ayrımı ve SDD'ye özgü alt aktör kuralı ilgili aktör/rota sınırıyla korundu. Dosya/alan adı, ürün/bağımlılık adı, araştırma dili ve yalnız adlandırılmış fakat genel tanımı verilmemiş kullanımlar ayrı ele alındı. Bu, bütün kavramların çözüldüğü iddiası değildir.

METHOD §8 dört uygulama açıklığını taşır: kaynak rolü ile ifade niteliği; farklı kullanımların ayrı adreslenmesi; etiketin nitelediği nesne/koşul; yalnız adı geçen içeriğin kapsam hesabı. V0.3-working seri çıkarımda kullanılacak başlangıçtır; aynı pilotlar onu bağımsız doğrulamış sayılmaz. Yeni bir üçüncü pilot veya evrensel ontoloji çalışması açılmadı.

Sohbet içi kayıtlar çok turlu ve parçalıydı; bu pilotların bilinçli sınırıydı. Seri aşamada kaynakla bağlı kalıcı kullanım dosyaları ve yerel okuma kaydı seçilmesinin nedeni bu devralma yükünü azaltmaktır. Dosya yerleşimi gerçek yeni-oturum başarısı, insan teknik incelemesi veya drift'in ortadan kalktığına dair deney yerine geçmez.

## Revizyon kaydı

- R0, 2026-09-19: U01 sonrası iki taslak plan ve iki farklı araştırmada konuşma içi deneme sırası.
- R1, 2026-09-19: U04 sonrası yorum izi/okuma izi ayrımı, iki nedenin her tur görünürlüğü ve kullanıcının teknik oracle olmaması gereksinimleri.
- R2, 2026-09-19: U05 ile repo hazırlığı pilotlardan önce yetkilendirildi; o checkpoint'te yöntem taslak, pilotlar bekliyordu. Eski etkin yönlendirmeler kaldırıldı. Bu tarihsel durum yeni next değildir.
- R3, 2026-09-19: P1-T3/B2 ile kullanım–ilişki beraberliği, kaynak/yorum statüleri, niteleyiciler, kaynak tarafından kapsam hesabı ve kaynakla sınırlı durma ölçütü v0.2-draft'a eklendi.
- R4, 2026-09-19: P2-T5/B4 ile ikinci pilotun 52 dosyalık kaynak kapsamı kontrolü kapatıldı; METHOD v0.3-working ve kalıcı SCOPE/READING/TERMS düzeni seçildi. B5 sıradadır; kalıcı terim envanteri ve ortak referans başlamadı. Bu karar, yöntem değişikliklerinin bağımsız doğrulandığı veya kullanıcı tarafından ayrıca teknik olarak onaylandığı iddiası değildir.
- R5, 2026-09-19, yürütme kaydı: SCOPE/S1 gerçek studies kök ve alt paket ağaçlarıyla kaynak evrenini/sahipliğini bağladı; dosyaların eksiksiz yaprak envanteri her yerel READING'de açılır. B5 kapsam ve sıra hazırlığı teslim edildi. B6-T1 ilk pilotun context bölümünü kaynak kontrolüyle TERMS'e, sekiz dosyalık kapsamı ve açık aktarımı READING'e kaydetti. Yöntem v0.3-working değişmedi; kalıcı ilk paket hâlâ kısmi, diğer seri paketler ve B7/B8 bekliyor. Ayrıntılı current state global STATE ve yerel READING'dedir.
