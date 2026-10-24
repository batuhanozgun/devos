# S1-01 — Üretim, inceleme ve düzeltme sorumlulukları

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst çalışma:** [S1](S1-role-responsibility-consolidation.md) · [WORK](../WORK.md)  
**Tarih:** 25 Eylül 2026.  
**Durum:** İlk sınırlı inceleme tamamlandı; aşağıdaki sonuçlar adaydır. S1'in bütünü, rol birleştirmeleri ve mimari kabul edilmiş değildir.  
**Araştırma deposu başlangıcı:** `0f1f6d618a27df332c6c1fd3b46c5002191052cd`.

## 1. Hangi soruyu cevaplıyoruz?

Development OS'un SOUL'u geliştirmesinde üretme, inceleme, kusuru teşhis etme, düzeltme, bulgu hakkında karar verme ve sonucu bütünleştirme sorumlulukları nasıl ayrılmalı? R1–R25 adaylarından hangileri ortak bir ailede düşünülebilir; hangi ayrımlar kaybolmamalı?

Bu çalışma SOUL'un gelecekteki müşteri işini işletmiyor. Örnek geliştirme sistemlerinin mekanizmalarını kullanarak **SOUL'u geliştirecek tarafın sorumluluklarını** inceliyor. Kaynaktaki bir rol adı otomatik DevOS rolü değildir.

Karşılaştırma ölçütleri: incelenen nesne ve sürüm, üretilecek çıktı, gerekli uzmanlık ve bilgi, yetki, hata kaynağı, sonraki tüketici ve devir yükü. Daha az rol adı üretmek başarı ölçütü değildir.

## 2. Kaynakların kendi bağlamlarında gösterdikleri

### K1 — Superpowers: tek inceleyici, iki ayrı hüküm

Araştırmanın S03/S04 sentezleri ve U03 notu, sabit kaynak sürümündeki görev inceleyicisinin hem gereksinime uygunluk hem kod kalitesi hükmü verdiğini açıklıyor. Asıl `task-reviewer-prompt.md` tam yeniden okundu: bu açıkça tek görev inceleyicisidir; daha sonra bütün dal için ayrı kapsamlı inceleme vardır.

İnceleyici görev açıklaması, genel kısıtlar, üretici raporu ve belirli başlangıç–bitiş sürümlerinin farkını kullanır. Üretici açıklamasını doğrulanmış saymaması istenir. Verilen farktan doğrulayamadığı gereksinimleri açıkça geri döndürür; koordinatörün bunları çözmesi beklenir.

**Gösterdiği:** Farklı değerlendirme soruları aynı inceleme görevlendirmesinde taşınabilir; yerel incelemenin kapsayamadığı sorunun sonraki sorumlusu gerekir.

**Göstermediği:** İki hüküm iki bağımsız kanıt değildir. Aynı görev açıklamasını paylaşan üretici ve inceleyici aynı eksikliği paylaşabilir. Salt-okunur talimatı, gerçek araç yetkisinin kaldırıldığının kanıtı değildir. Bu tur canlı aktör çalıştırılmadı.

### K2 — Superpowers: düzeltme, üretim sorumluluğuna geri dönüyor

Asıl üretici şablonu, üreticinin değişikliği gerçekleştirmesini, test etmesini, kendi kontrolünü yapmasını ve raporlamasını ister. İnceleme bulguları geldiğinde aynı üreticinin yeniden çağrılıp düzeltmesi olağan yoldur; gerekli olduğunda yeni ve daha yeterli bir üreticiye geçilir.

SDD'nin seçilmiş asıl bölümleri, eksik bağlam, yetersiz kabiliyet, fazla büyük iş ve yanlış planı farklı tepkilere bağlar. Aynı başarısız denemeyi değişiklik yapmadan tekrarlama önerilmez. Düzeltmenin ardından değişen kod için test kanıtı ve sınırlı yeniden inceleme istenir.

**Gösterdiği:** Düzeltme için her zaman ayrı kalıcı bir rol gerekmeyebilir. Fakat düzeltme yapmak, kusurun giderildiğini göstermek değildir.

Kaynağın üç/beş tur gibi sınırları burada benimsenmedi. Kaynaktaki sınırın varlığı, kalan kusurun önemsiz veya yanlış olduğunu kanıtlamaz.

### K3 — Superpowers: bulgu ile bulgu hakkında karar ayrı

Kaynakta koordinatör, yerel inceleyicinin göremediği plan ve işler arası bağlamı taşır; doğrulanamayan gereksinimleri, planla çatışmaları ve ertelenen bulguları ele alır. Kararın gerekçesi ve yanlışsa maliyeti kayıt ve teslim boyunca korunmalıdır.

Bununla birlikte görev inceleyicisindeki planın zorladığı kusur için insan kararı ifadesi ile SDD'deki koordinatör kararı ifadesi arasında araştırmanın açık tuttuğu yetki birleşimi sorusu vardır. Bu çalışma kaynağı sessizce uzlaştırmaz veya kaynakta evrensel bir çözüm bulunduğunu iddia etmez.

**Gösterdiği:** Bulguyu ortaya koymak, nedenini araştırmak, hangi işin değişeceğine karar vermek ve müşteri adına artık riski kabul etmek aynı yetki değildir.

**Göstermediği:** Yetkili kişinin hükmü teknik doğruluk kanıtı değildir. Kaynağın insana bıraktığı teknik değerlendirme yükü bizim müşteri modelimize otomatik taşınamaz.

### K4 — gstack: inceleme ve düzeltme aynı çalışma yolunda da bulunabiliyor

Sabit sürümün teslim yeterliği sentezi ve asıl `qa/SKILL.md.tmpl` seçilmiş bölümleri farklı bir düzen gösteriyor: `/qa` gözlem, sınıflandırma, sınırlı düzeltme, kayıt ve yeniden sınamayı bir arada tarif eder; `/qa-only` ile farkı özellikle belirtilir.

Asıl şablon, uygulanmış fakat bütünüyle doğrulanamamış düzeltmeyi doğrulanmış düzeltmeden; geri alınmış ve ertelenmiş sonuçları da bunlardan ayırır. Son inceleme, değişikliklerden sonraki duruma bakar.

**Gösterdiği:** Her koşulda inceleyen ile düzeltenin farklı fiziksel aktör olması tek mümkün düzen değildir. Korunacak temel ayrım, eylem ve kanıtın kapsamıdır.

**Göstermediği:** Aynı aktörün yeniden sınaması bağımsız doğrulama olmaz. Şablonun öngördüğü davranış bu tur çalıştırılmadı; şablon, üretilmiş etkin talimat ve gerçek çalışan ortam aynı şey değildir. gstack'ın tur sınırları, puanları veya kullanıcıya bıraktığı kararlar benimsenmedi.

## 3. İlk aday konsolidasyon sonuçları

### S1-01-A1 — İnceleme ve doğrulama ortak bir rol ailesi olabilir

**R2, R6, R8, R12, R15 ve R18**, ortak bir inceleme/doğrulama ailesinin farklı uzmanlık ve iddia kapsamları olarak ele alınabilir. Eski kimlikler ve B bağlantıları korunur:

| Aday | Korunacak özel soru |
|---|---|
| R2 | SOUL aktörü beklenen ortak çalışma davranışını gösteriyor mu? |
| R6 | Kullanılan bilginin kaynağı, yeterliği, güncelliği ve kullanımı iddiayı taşıyor mu? |
| R8 | Belirli aktör, belirli rol ve görev için yeterli mi? |
| R12 | Yapılan iş hedefe ilerliyor mu; kapanış hangi ölçüte göre geçerli? |
| R15 | Gerçek ortamda iddia edilen değişiklik oluşmuş mu? |
| R18 | Bu kanıtlardan çıkarılan birleşik sistem hükmü destekleniyor mu? |

**Bir ailede toplamak, tek genel inceleyiciye bütün uzmanlığı atamak değildir.** Görev bazında yeterli bilgi, uygun yöntem, gerçek gözlem erişimi, kapsam ve gereken bağımsızlık gösterilmelidir. Bunlar sağlanmıyorsa farklı inceleme görevlendirmeleri veya uzmanlık desteği gerekir.

R1 bu aileye taşınmaz: ortak çalışma tabanını tasarlama sorumluluğudur. R24 değerlendirme yöntemini tasarlar; R25 sınama çalışmasını yürütür. Bunlar bu tur doğrulayıcı hükmüyle birleştirilmedi.

### S1-01-A2 — Üretim ve düzeltme aynı sorumluluk ailesinde ele alınabilir

Olağan düzeltme, ilgili ürünü geliştirme işinin devamıdır. Ayrı bir kalıcı düzeltici, her kusur için zorunlu değildir. Aynı veya başka bir yeterli aktör, açık görevlendirmeyle bu işi taşıyabilir.

Ancak inceleyici değişiklik yapmaya başladığında o değişiklik bakımından **üretici konumuna da geçer**. Eski sürümün olumlu hükmü yeni sürüme otomatik geçmez. Bağımsız güvence gereken durumda yalnız düzeltmeyi yapanın kendi kontrolüyle kapanış yapılamaz. Bu, her küçük düzenlemede ayrı ajan zorunluluğu değildir; iddianın riskine ve kanıt ihtiyacına bağlıdır.

### S1-01-A3 — Teşhis, düzeltme ve teknik karar ayrı sorumluluklar olarak korunmalı

R3'ün sorusu, görülen problemin hangi neden veya ilişkiden doğduğu ve neyin yeniden araştırılması gerektiğidir. R3'ü her alanın her problemini bilen bir üst uzman sayamayız; alan bilgisine ve ayırt edici denemelere erişmesi gerekir.

Düzeltici değişikliği uygular. Teknik karar sorumlusu, verilen yetki içinde hangi gereksinim, plan veya uygulamanın değişeceğini ve hangi açık bulgunun hangi şartla erteleneceğini belirler. Aynı aktör bazı işleri taşıyabilir; ama bulgu, teşhis, karar ve uygulama ayrı kayıtlanmalıdır.

R11/R17/R20 adaylarıyla bu karar sorumluluğunun kesin eşlemesi sonraki dilime açık bırakıldı. Yeni bir üst yönetici rolü ilan edilmedi. Yetki dışındaki kapsam, değer tercihi veya risk kabulü müşteriye döner; sıradan teknik teşhis yükü müşteriye bırakılmaz.

### S1-01-A4 — Yerel düzeltme, bütünleştirme başarısını kanıtlamaz

Üretici raporu, yerel inceleme, değişen parçanın testi, bütünleştirilmiş sonucun sınanması ve müşteri kabulü farklı sonuçlardır. Bunların hepsini her işte aynı yoğunlukta uygulamak gerekmeyebilir; ama birinin kanıtı diğerinin yerine kendiliğinden geçmez.

Her devirde en az gerektiği ölçüde şu ilişki korunmalı: **hangi gereksinim ve sürüm → hangi değişiklik → hangi test veya gözlem → hangi bulgu → hangi karar → hangi yeni sürüm ve yeniden sınama**.

### S1-01-G1 — Üretim/uygulama sorumluluğunun kapsamı yeterince açık değil

Bu tur [ACTORS](../ACTORS.md) tam, B1'in davranış–aktarım–kontrol–rol bölümleri ile B5 ve B7'nin tasarım/kurulum rol bölümleri seçici incelendi.

Somut zincir: B1/R1 mekanik uygulamayı B5/B6'ya bırakıyor. B5/R13 ortam gereksinimi tasarlıyor, R14 kurulumu ve hazırlığı yönetiyor; M4/M5 gerçek teknik işleri tarif ediyor. B7/R20 ise parçaları kendi başına üretmediğini, ilgili sorumluları çağırdığını söylüyor.

Buradan **üretim hiç düşünülmedi** sonucu çıkmaz: B'lerde geliştirme ve kurulum yükleri var. Fakat gerekli kodu, bağlantıyı veya prosedürü üretecek taraf ile hazır mekanizmayı kurup kullanacak taraf aynı açıklıkta ayrılmamış. Dolayısıyla mevcut kayıttan her mekanizmanın geliştirme sorumlusunu güvenle çıkaramıyoruz.

**Aday düzeltme:** S1'in sonraki diliminde tasarım → üretim/uyarlama → bütünleştirme → sınama zincirini açıklaştır. M1–M9'u geliştirecek ve bakımını yapacak sorumluluğu göster. Mevcut bir rolü genişletmek, ortak bir geliştirme ailesi kurmak veya alanlara göre ayırmak açık seçeneklerdir; otomatik R26 eklenmedi.

Ayrıca bazı aday açıklamaları, DevOS'un SOUL'u geliştirmesi ile gelecekteki SOUL'un bir müşteri işini işletmesini aynı düzeyde anlatabiliyor. Her üretim eşlemesinde nesne açıkça belirtilmeli. Bu bir kapsam denetimi ihtiyacıdır; bütün B haritasını geçersiz sayma kararı değildir.

## 4. Bu kümedeki aktör neye ihtiyaç duyar?

| Sorumluluk | Bilgi/yöntem ve erişim ihtiyacı | Üretilen somut sonuç |
|---|---|---|
| Üretim ve düzeltme | Gereksinim, mevcut ürün, alan bilgisi, uygulama araçları, izinli değişiklik kapsamı ve ilgili test yöntemi. | Gerçek değişiklik, sürümü, test sonucu ve kalan belirsizlik. |
| İnceleme ve doğrulama | İddiaya uygun uzmanlık, asıl ürün ve kaynaklar, doğru sürüm, ölçüt ve ilgili hatayı ayırt edebilecek gözlem. | Desteklenen, başarısız ve sınanamayan iddiaları ayıran bulgu. |
| Teşhis | Sorunu yeniden gözleme imkânı, geçmiş girişimler, ilgili alan kaynakları ve alternatif nedenleri ayıran yöntem. | Nedensel açıklama adayı ve bunu ayırt edecek ya da onaracak iş. |
| Teknik karar ve yönlendirme | Üst gereksinim, işler arası bağımlılık, yetki sınırı, seçenekler ve artık risk. | Gerekçeli karar, etkilenen iş, taşıyıcı ve dönüş noktası. |

Araştırmalar bu ihtiyaçların bilgi kaynağıdır; dosyanın bulunması aktörün bilgiyi edinmiş veya kullanmış olması değildir. Örneğin yalnız üretici raporunu vermek bağımsız inceleme girdisini karşılamaz; asıl ürüne gerektiğinde dönüş yolu gerekir.

## 5. Masa başı karşı örnekler ve sınırlar

Aşağıdakiler yeni deney veya ölçülmüş başarı değildir; önerinin zayıf yorumlarını sınayan düşünsel karşı örneklerdir:

- Altı inceleme adı tek genel role indirgenir ama alan bilgisi sağlanmazsa, ad sayısı azalırken gereken yeterlik de kaybolur. A1 bunu kabul etmez.
- Altı ayrı inceleyici aynı eksik görev özetini alırsa, sayı artışı ortak bilgi açığını gidermez.
- İnceleyici düzeltme yapar ve eski sürümün olumlu raporunu kullanırsa, yeniden sınama bağı kopar.
- Koordinatör bütçe bittiği için kusuru ertelerse, bu teknik doğruluk kanıtı olmaz; artık risk ve karar yetkisi açık kalır.
- M1–M9'a teknik görev yazılır ama onları geliştirecek taraf gösterilmezse, mekanizma listesi uygulanabilir bir geliştirme düzeni oluşturmaz.

Bu iki örnek sistem rol ailelerinin tek doğru veya en küçük düzenini kanıtlamaz. Güncel ürün uygunluğu, maliyet üstünlüğü, canlı DevOS başarısı ve bağımsız doğrulama elde edilmedi. Kaynak karşılaştırması ve aday konsolidasyon aynı assistant tarafından yapıldı.

## 6. Okuma izi

Kontrol protokolleri araştırma kanıtı değildir. Önceki turda okunmuş katalog, paket META/STATE/CORE ve kapanış sınırları korundu; bu tur aşağıdaki derinleşmeler yapıldı.

| Kaynak | Bu turdaki kapsam / kimlik |
|---|---|
| [Superpowers S03](../../../research/studies/superpowers/syntheses/S03-intent-planning-and-context-handoff.md) | Tam; blob `f69f5c99aefa2a6a13b4233ae49afd73dc2ce0ca`. |
| [Superpowers S04](../../../research/studies/superpowers/syntheses/S04-execution-verification-and-delivery.md) | Tam; blob `54c77cc04e9d7f88900918f8ee63dd07dadb0e54`. |
| [U03 ve kaynak kaydı](../../../research/studies/superpowers/notes/U03-delegation-review-and-acceptance.md) | U03 tam `4dfe415cf35386650a30fa7104e5537355276977`; SOURCE-LEDGER-U03 tam `76075ba19f8012d9d2b582887a22c9edf2362d2d`. Eski deneyler yeniden koşulmadı. |
| [Asıl görev inceleyicisi](https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/subagent-driven-development/task-reviewer-prompt.md) | Tam; `ce796948232b6ae5fb65fd2d1f2f864530201a2e`. |
| [Asıl üretici](https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/subagent-driven-development/implementer-prompt.md) | Tam; `5c8ecd61fba036263bf88d0af24d47125780efa0`. |
| [Asıl SDD](https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/subagent-driven-development/SKILL.md) | Seçici, satır 240–505; `aac35b91c07af15eca580a205eb0c894b86e87c8`. Dosyanın tamamı bu tur yeniden okunmadı. |
| [gstack CORE](../../../research/studies/gstack/CORE.md) ve [INDEX](../../../research/studies/gstack/INDEX.md) | Tam; `94f1457fc536602cb22c4979577ff9e1d4660c5e` / `8655b315a07d85278f2ad9e6fc1973d8fe580e39`. |
| [gstack teslim yeterliği sentezi](../../../research/studies/gstack/syntheses/review-qa-ship-delivery-qualification.md) | `00ef4ae84ce23bb7e59043f269ae950778f5f24d`; ilk yanıt kesildi, 330–550 ile aşağıdaki bölümler geri getirildi. Bu dilimde kullanılan inceleme/düzeltme/sınama/yetki bölümleri okundu; tam dosya okuması iddia edilmez. |
| [Asıl gstack QA şablonu](https://github.com/garrytan/gstack/blob/0d1bd5616c0ef096bb7ccee336f63c60ee408618/qa/SKILL.md.tmpl) | Seçici, satır 1–345; `d15a0c5d151ec6a8b15cd3a31dc96430ddb91909`. Dahil edilen bütün şablon parçaları, etkin kurulum veya testler çalıştırılmadı. |
| [DevOS B1](B1-common-intellectual-baseline.md), [B5](B5-environment-capacity.md), [B7](B7-system-formation.md) | B1'in görünen sorumluluk/rol bölümleri seçici; B5 105–215, B7 215–310. R13/R14/M4/M5 ile R19/R20/M7 sınırları kontrol edildi. B1–B9 tam yeniden okundu denmez. |

Asıl dış kaynaklar sabit araştırma sürümlerinden okundu; bugünkü ürünlerin son sürümü veya kurulu davranışı doğrulanmış sayılmaz.

## 7. Dönüş ve sonraki dilim

Bu turun teslimatı A1–A4 aday ayrımları ile G1 sorumluluk açıklığıdır. R1–R25/M1–M9 ilk türetim kayıtları silinmez; bu sonuçlar onların üstüne izlenebilir bir değerlendirme olarak eklenir. Kullanıcı kabulü varsayılmaz.

**Önerilen sonraki S1 dilimi:** Tasarım–üretim–bütünleştirme zincirinde DevOS'un fiilî geliştirme sorumluluğunu netleştirmek; özellikle B1/B2/B5/B6'daki aktarım noktaları ve R14/R20'nin kurma/işletme sınırlarını incelemek. Bu kapsam bitmeden bütün rol ailelerini veya ajan sayısını kesinleştirme.
