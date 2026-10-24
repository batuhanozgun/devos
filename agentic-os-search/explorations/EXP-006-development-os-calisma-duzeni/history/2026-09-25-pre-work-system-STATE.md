> **30 Eylül 2026 — tarihsel STATE ve eski sonraki iş; güncel kurulum talimatı değildir.** Aşağıdaki çalışma yönü 25 Eylül 2026 anlık görüntüsüne aittir. [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri) sonrasında DevOS kurulumunun tek geçerli planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır; buradaki eski yetki ve sonraki iş devralınmaz.
>
> Özgün gövde değiştirilmeden korunur; tarihsel bulgu ve kalite gereksinimleri topluca geçersiz sayılmaz. Göreli bağlantıları eski konumuyla okumak için [aynı gövdenin sabit tarihsel sürümünü](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/STATE.md) kullanın. Bu da tarihsel kaynaktır, güncel talimat değildir. Kaynak eşliği ve bağlantı sınırı [history girişinde](README.md#historical-source-map) açıklanır.

---

# EXP-006 — Güncel durum ve konuşma planı

**Açılış:** 25 Eylül 2026.  
**Durum:** OPEN / DIALOGUE IN PROGRESS.  
**Kaynak yetki:** [U001](sources/U001.md).  
**Üst amaç:** SOUL'u geliştirecek Development OS'un nasıl bir çalışma düzeni olması gerektiğini karşılıklı konuşarak ortaya çıkarmak.  
**Şimdiki soru:** Development OS'un SOUL'u yaratmak için yaptığı Work nedir; bu Work'ten hangi yapay zekâ rolleri türemelidir?

## Kullanıcı tarafından verilmiş yön

Kullanıcı beş gerekçe sundu: insanın tek başına dosya üretim yükü; kod üretme ihtiyacı; dosyaların ne olacağı/içeriği hakkında düşünce ortaklığı; konuşmaları aşan bilgi ve okuma sürekliliği; çalışma sırasında büyüyen planın, ana ve alt işlerin yönetimi. Foundation'ın dört zemini SOUL kadar onu üretme faaliyeti için de önemlidir.

Bunlar bu konuşmanın başlangıç girdileridir. Kullanıcının gstack/piramit örneği seçilmiş bilgi mimarisi değildir. “Sen ya da Claude Code” ifadesi iki ürünün birlikte kullanılmasını zorunlu kılan karar değildir.

Yetkilendirilen aşama: repodan seçici yararlanarak diyalog ve düşünce geliştirme; önce aktörler. SOUL implementasyonu, Development OS kurulumu, ECC benimseme, runtime/hosting/iletişim yöntemi veya bütün bir görev şeması henüz seçilmedi.

## İlk assistant katkısı — öneri, kullanıcı kararı değil

1. Bu gerekçeler düşünme/üretme ve sürekliliği olan bir çalışma düzenine ihtiyaç gösterir; ayrı ve büyük bir yazılım ürününün önceden tamamlanması gerektiğini tek başına göstermez.
2. Aktör ile rol ayrılmalı. Araştırma, tasarım, yazma, planlama, kayıt ve değerlendirme sorumluluklarının her biri otomatik olarak ayrı aktör gerektirmez. Bu dar konuşmada önce geliştirme işine katılan ana taraflar sayılır; Foundation'ın bütün paydaş alanının tüketildiği iddia edilmez.
3. Kullanıcı ve bir yapay çalışma ortağı, gerekçelerden çıkan başlangıç ikilisidir. Bu, iki aktörün bütün geliştirmeye yeterli olduğunun gösterilmesi değildir. Yapay çalışma ortağı yalnız yazıcı/kodlayıcı olarak düşünülmez; ihtiyaç keşfi ve tartışmaya da katılmalıdır.
4. Ayrı bir değerlendiren/sorgulayan yapay aktör üçüncü adaydır. Kullanıcının üçüncü maddesi tek başına ikinci AI aktörü gerektirmez: düşünce ortaklığı ilk AI ile de kurulabilir. Ayrı değerlendiricinin gerekliliği, hangi hatayı nasıl yakalayacağı ve sürekliliği ayrıca konuşulmalıdır.
5. İnsan amaç/tercih ve anlam değerlendirmesine katılır; kod bilmediğini söylediği kullanıcıyı sistemin teknik doğruluğunu garanti eden son kontrol noktası saymak uygun başlangıç değildir. Yetki ve teknik yeterlik birbirine geçirilmez.
6. ChatGPT/Claude Code adlarından sabit “biri düşünür, öteki uygular” dağılımı veya bağımsız doğrulama sonucu çıkarılmaz. Aynı modelin farklı rollerdeki çalışmaları ile ayrı ürün adları, aktör/rol/bağımsızlık bakımından ayrıca ayrıştırılacaktır.

**Güncel aktör çerçevesi:** Kullanıcı iki aktörle ilerlemeyi seçti: **insan** ve **yapay zekâ**. Alt ajanlar veya farklı model/oturum örnekleri şimdilik yeni aktör sınıfları sayılmıyor; ihtiyaç olursa bu ayrım yeniden açılabilir. Roller aktörlerden ayrı ve Work'e göre türetilecek.

## Çalışma planı ve sonraki yetkili hareket

- Başlangıç: U001'in görünür kaynak aktarımını korumak ve bu pakete keşif yolu açmak.
- Şimdiki iş: aktörleri ve onları ayırma gerekçelerini kullanıcıyla konuşmak. Özellikle çalışma ortağı ile ayrı değerlendirme sorumluluğu arasındaki ayrımı açmak; önceden çok-ajanlı kadro kurmamak.
- Sonraki yetkili hareket: kullanıcının bu çerçeveye cevabından devam etmek; maddi değişen görüşleri öneri/itiraz/kabul ayrımıyla korumak.
- Yeni soru ortaya çıkarsa konuşmanın çalışma planına eklenebilir; bu, otomatik uygulama veya ayrı araştırma kampanyası yetkisi değildir.

## Diğer çalışmalarla sınır

EXP-001–005 düşünce ve ders girdileridir; eski görevler otomatik yeniden başlamaz. [DEVOS-002](../../development-os/attempts/002/README.md) ayrı denemenin kendi kayıt alanıdır; EXP-006 onu silmez, tamamlandı saymaz veya kurulumunu sürdürmez. Bu konuşmanın devamı önce buradaki aktör sorusudur, 002'nin eski next-step'i değildir. Foundation, studies, concepts ve agent-control durumları bu paketle değiştirilmez.

## Arşiv kapsamı ve sınırlamalar

Başlangıç kaynak kapsamı yalnız U001'dir. Assistant önerileri yukarıda türetilmiş çalışma notudur; nihai yanıtın birebir transkripti, tüm ara bildirimler veya araç günlükleri arşivlenmiş değildir. Bu paket henüz kapanmış/tam konuşma arşivi değildir. Önceki explorations topluca tam okunmadı; gerçek seçici okuma kapsamı [INDEX](INDEX.md)'tedir. Canlı çok-aktör yürütmesi, ortam yeterliği veya bağımsız değerlendirme testi yapılmadı.


## İlk netleşen rol ayrımı — insan / müşteri

Kullanıcı ile yapılan tartışmada, insan aktörünün **müşteri** rolündeki çekirdeği iki başlıkta netleşti:

- **Yetki:** Yapay zekânın hangi amaç ve sınırlar içinde hareket edebileceğinin meşru kaynağı insandır. Bu, insanın bütün önemli kararları tek tek vermesi gerektiği anlamına gelmez; Development OS mümkün olduğunca bu karar yükünü üstlenebilir, fakat kendi yetkisini kendisi üretemez.
- **Kabul:** Ortaya çıkan sonucun teknik olarak doğrulanması ayrı bir konudur; “bu benim ihtiyacımı karşılıyor ve teslimi kabul ediyorum” hükmü müşteride kalır.

Önceki “amaç, tercih, yön, kapsam, trade-off” gibi başlıklar müşteri rolünün ayrı ayrı devredilemez sorumlulukları olarak tutulmuyor. Bunların büyük bölümü Development OS tarafından hazırlanabilir, çözümlenebilir veya kararlaştırılabilir; kritik sınır yetkinin kaynağı ve nihai kabul makamıdır.

Bu, insan aktörünün bütün olası rollerinin tanımı değildir. Partner, yönetici, uzman, sahip/principal benzeri başka insan rolleri ayrıca tartışılabilir. `EXP-006_Context` kullanıcıyla içeriği birlikte kararlaştırılana kadar boş tutulacaktır.


## RPD ile Work keşfine geçiş — 25 Eylül 2026

Kullanıcı, yapay zekâ rollerini jenerik adlarla çıkarmak yerine önce Development OS'un yaptığı işi tanımlamayı istedi. Bu nedenle konuşma Actors'tan Work keşfine geçti; roller daha sonra Work–Actors ilişkilerinden türetilecek.

Yöntem olarak Özyinelemeli Önkoşul Keşfi (RPD) kullanılacak. Kullanıcının bu turda yeniden sağladığı `ozyinelemeli_onkosul_kesfi_kavramsal_temel.md` ve `RPD_Sureklilik_Tasarimi_v0_1.md` tam kaynak olarak okundu; Research'teki `research/studies/recursive-prerequisite-discovery/META.md`, `ASSESSMENT.md` ve ilgili 2026-09-08 RPD entegrasyon sözleşmesi de geri çağrıldı. RPD burada doğrulanmış standart değil; hedeften gerekli koşullara ve başlanabilir işe doğru ilerleyen çalışma yöntemi olarak kullanılacak. Süreklilik tasarımı hazır Development OS mimarisi olarak ithal edilmeyecek.

**Kök hedef:** Development OS, müşterinin yetki sınırları içinde çalışarak SOUL'u ortaya çıkarabilecek bir çalışma düzeni olmalıdır.

**Çalışma kuralı:** Development OS tek turda tamamlanmaya çalışılmayacak. Önce kök hedefin hemen altındaki gereklilikler çıkarılacak; kullanıcıyla değerlendirildikten sonra seçilen gerekliliklere katman katman inilecek. Erken rol, araç, dosya yapısı, çoklu-agent veya runtime seçimi yapılmayacak.

**Sonraki yetkili hareket:** kök hedef için ilk önkoşul katmanını kullanıcıyla tartışmak. `EXP-006_Context` hâlâ boş tutulacaktır.


## EXP-001–004 kaynak görünürlük turu — SOUL hedefini somutlaştırma

Development OS Work keşfinin ilk dalı olan “neyin yapılması gerektiğini belirlemek” için EXP-001–004 paketlerinin dosya ağaçları ve yönlendirici yüzeyleri incelendi. Bu tur kaynak seçimi içindir; dört konuşmanın tamamı veya bütün artefaktlar tam okunmuş sayılmaz.

İlk harita:
- **EXP-001:** A–B–C, C↔Work, planı üreten sistem, aktör hazırlığı/uzmanlık sürekliliği, harness ve yaşayan plan. Büyük konsolidasyon ve Mekanizma Atlası var; yaşayan plan tartışması konsolidasyondan sonra U016–U017/S016–S017'de devam ediyor.
- **EXP-002:** SOUL'un yalnız sonuç üretmeyip gerekli çalışma sistemini kurması/işletmesi/değerlendirmesi/uyarlaması; baz SOUL ile işe göre oluşturulan düzen; ortak entelektüel taban; Development OS'a geçiş fikri.
- **EXP-003:** ek hafıza, bilgi varlığı/bulunabilirliği/kullanımı, seçici erişim, değişiklik etkisi ve araştırmayla daha sağlam bilgi düzeni. SOUL'un genel hedef tanımına destekleyici, Information ağırlıklı paket.
- **EXP-004:** büyük ve uzun iş stress testi; Work discovery, rol→Actor, context, gerçek etki, qualification/kabul, recovery ve controlled adaptation; MS01 adıyla somut çalışma sistemi taslağı, iki senaryo yürüyüşü, araştırma→mekanizma eşlemesi ve G01–G07 açık kapasite yükleri. Güncel paket kapanmış kavramsal teslimattır; nihai mimari değildir.

**Henüz karar verilmedi:** hangi dosyaların tam okunacağı. Sonraki hareket kullanıcıyla ilk tam-okuma setini seçmektir. Kaynak sadakati için türetilmiş konsolidasyonlardan çıkarılan yük taşıyan tanımlar daha sonra ilgili U/S özgün mesajlarına geri bağlanacaktır. `EXP-006_Context` boş tutulmaya devam eder.


## SOUL hedefi için tam okuma — 25 Eylül 2026

Kullanıcıyla seçilen tam okuma seti canonical main'den eksiksiz okundu:

1. EXP-001 `artifacts/consolidation-v0.1/SOUL_Calisma_Anlayisi_Konsolidasyon_v0_1.md` — blob `d7a6a6dbcffc3700e04e7afa91163c24536343fb`, 778 satır.
2. EXP-002 `artifacts/CONSOLIDATION.md` — blob `b94a81ffff09f60146139adf59475f1ff4fcda76`, 116 satır.
3. EXP-004 `artifacts/MS01-SOUL-WORKING-SYSTEM-DRAFT.md` — blob `782ee291c0c4da0ab79b2689854ceffbda07c168`, 166 satır.
4. EXP-004 `artifacts/MS01-COVERAGE-AND-OPEN-MECHANISMS.md` — blob `64870a8b7032e0efed165ded8dfa0d3947e997ae`, 122 satır.
5. EXP-004 `artifacts/MS01-RESEARCH-TO-MECHANISM-MAP.md` — blob `fbae5dc1aa542170aa9cf13b235f0377d6b66ca1`, 175 satır.

Yük taşıyan SOUL tanımı/baz yapı noktaları için EXP-002'nin özgün kullanıcı mesajları ile S006/S011/S012/S014/S018 ve EXP-004 kullanıcı U007/U010 gibi doğrudan kaynak yüzeylerine geri dönüldü. Böylece konsolidasyon yorumları tek başına kaynak kabul edilmedi.

**Okumanın amacı:** Development OS'un yaratması gereken SOUL'u kısa slogan değil, Work keşfinde kullanılabilecek kadar somut ve kapsamlı bir hedef olarak tanımlamak.

**Güncel çalışma sonucu:** kapsamlı bir aday SOUL hedef tanımı bu okumalardan sentezlenmektedir; henüz kullanıcı tarafından kabul edilmiş tanım veya mimari değildir. Sonraki yetkili hareket bu tanımı kullanıcıya sunup birlikte irdelemektir. `EXP-006_Context` yalnız kullanıcıyla önceden onaylanan bağlam metnini taşır; bu yeni sentez oraya otomatik yazılmamıştır.


## Development OS → SOUL ilk Work haritası adayı — 25 Eylül 2026

Kullanıcı, kapsamlı SOUL hedef tanımını bu aşama için yeterince somut kabul etti ve RPD'nin ikinci kök işine geçmeyi onayladı: **bu hedef için gereken işleri keşfetmek**. Bu turda rol, agent sayısı, dosya yapısı veya araç seçimi yapılmayacak; yalnız birinci seviye Development OS Work aileleri çıkarılacak.

İlk aday harita:

1. **SOUL-native entelektüel/çalışma tabanını geliştirmek:** ihtiyaç keşfi, sistem görüşü, araştırmayı kullanma, kanıt/varsayım ayrımı, belirsizlik, profesyonel çalışma standardı ve gerektiğinde derin bilgiye dönme davranışlarını oluşturmak ve sınamak.
2. **Information kapasitesini geliştirmek:** kalıcı bilgi/records, memory, context formation, retrieval, kaynak/provenance, sürüm/güncellik, değişiklik etkisi ve bilginin ilgili aktöre gerçekten kullanılabilir biçimde taşınması.
3. **Actors kapasitesini geliştirmek:** rol ve aktör oluşturma/bağlama; competence/capability, authority/permission/obligation, delegation/representation, insan müşterinin yetki+kabul ilişkisi, aktör yaşam döngüsü ve yeterlik değerlendirmesi.
4. **Work kapasitesini geliştirmek:** amaçtan ihtiyaç/Work keşfi, yöntem ve karar ihtiyaçları, yaşayan plan/frontier, bağımlılık/koordinasyon, yürütme durumu, tamamlanma/verification/acceptance ayrımı, değişiklik ve rework.
5. **Environment kapasitesini geliştirmek:** runtime, araçlar, çalışma alanı/sandbox, veri ve kaynak erişimi, credentials/network/tool availability, gerçek effect yolları, gözlenebilirlik ve fiilî actionability.
6. **Dört zeminin birleşim ve kontrol mekanizmalarını geliştirmek:** Information–Actors–Work–Environment ilişkilerini; readiness, context, authority, assignment, effect, verification, acceptance, change impact ve transition sınırlarını birlikte doğru işletmek.
7. **System-formation / işe göre genişleme kapasitesini geliştirmek:** verilen amaç için hangi çalışma düzeninin gerektiğini keşfetmek; gerekli aktör, rol, bilgi düzeni, yöntem, araç, environment ve kontrolleri seçip kurmak/değiştirmek; sabit tek yapı uygulamamak.
8. **Süreklilik, değişim, recovery ve öğrenme kapasitesini geliştirmek:** oturum/aktör kaybında Work'ü kaybetmemek; stale/partial/unknown effect durumlarını uzlaştırmak; yeni bilgi ve sonuçlarla yalnız etkilenen parçaları yeniden açmak; yöntem ve birikimi koşullu biçimde güncellemek.
9. **Bütün SOUL'u entegre etmek ve gerçek görevlerde yeterliğini sınamak:** parçaların birlikte çalışmasını göstermek; farklı alan/ölçeklerde hedef→çalışma sistemi→gerçek etki→kanıt→kabul zincirini sınamak; yalnız mekanizma açıklaması veya aynı-model self-review ile SOUL tamamlandı dememek.

Bu liste **aday birinci seviye Work haritasıdır**, kabul edilmiş Development OS planı veya SOUL modül mimarisi değildir. Foundation'ın dört ground'u yazılım modülü olarak varsayılmıyor; 2–5 numaralı iş aileleri bu problem zeminlerinde gerekli SOUL kapasitesini geliştirme işlerini temsil ediyor. 6–8 özellikle ground'lar arası ilişki ve zamansal davranışın tek ground'a indirgenemediği için ayrı aday işler olarak tutuluyor.

Sonraki hareket: kullanıcıyla bu ilk Work haritasının doğru soyutlama seviyesinde olup olmadığını, eksik/fazla/örtüşen dalları tartışmak; kabul edilen haritadan sonra tek tek dallara RPD ile inmek. Yapay zekâ rollerine henüz dönülmeyecek; roller yeterli Work resmi oluştuktan sonra türetilecek.


## B2 — Information kapasitesi açılımı ve ilk rol türetimi

B2 için EXP-003 konsolidasyonu, Context/Memory/Harness sentezi ve Foundation Information yüzeyleri yeniden kullanıldı. Temel ayrım: storage, discovery/retrieval, selection, exposure/context ve demonstrated use aynı başarı değildir; canonical state ile derived/learned memory aynı authority class'ında tutulmamalıdır.

B2 altında dokuz sorumluluk alanı çıkarıldı: bilgi sınıfları/otorite; provenance ile formation/acquisition; revision/currentness; discoverability; Work/Actor/use-conditioned selection; gerçek context formation; exposure ile use ayrımı; erişim/görünürlük sınırı; information failure diagnosis.

İlk aday taşıyıcılar:
- **R4 Information Steward / Bilgi Yaşam Döngüsü Tasarımcısı**
- **R5 Context & Retrieval Curator / Bağlam Kurucusu**
- **R6 Information Integrity Reviewer / Bilgi Yeterliği Doğrulayıcısı**
- **M2 Information persistence/retrieval/exposure mekanik sorumluluğu**

B1'deki **R3 Davranış Teşhisçisi / Değişiklik Analisti** B2 failure'larını da cross-domain teşhis edecek şekilde genişlemeye adaydır; yeni kopya teşhis rolü yaratılmadı.

Bu rol adları henüz nihai Development OS organizasyonu değildir. B3–B9 ilerledikçe birleşme/ayrılma yeniden değerlendirilecek. Ayrıntı authoritative working surface olarak `EXP-006_Work_Map.md` içinde tutulur.
