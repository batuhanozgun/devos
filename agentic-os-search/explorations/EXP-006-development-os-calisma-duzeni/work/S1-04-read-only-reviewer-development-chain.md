# S1-04 — Salt-okur inceleme kapasitesinin geliştirme zinciri

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Aşağıdaki "sonraki adım", "dönüş" veya benzeri ifadeler üretildiği turun tarihsel dönüş noktasını kaydeder. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Üst iş:** [S1](S1-role-responsibility-consolidation.md) · [WORK](../WORK.md)  
**Tarih:** 26 Eylül 2026.  
**Durum:** Bir örnekte sorumluluk eşlemesi ve tartışılabilir görevlendirme taslağı. Adaydır; uygulanmış mekanizma, doğrulanmış rol düzeni veya kullanıcı kabulü değildir.  
**Başlangıç:** araştırma deposu `15d030440bb04f27852395674eb5010c49a4e04c`.

## 1. Yetkilendirilmiş soru ve somut örnek

Kullanıcı, ana yönün net olduğunu, somut sonuçları doğru kabul etmeden değerlendirebileceğimizi belirterek devam istedi. Önceki STATE/HANDOFF'un belirlediği sınırlı G1 örneği açıldı; bütün S1 veya bütün M1–M9 geliştirme eşlemesi yapılmadı.

**Örnek gereksinim:** SOUL, salt-okur inceleme gereken bir işe inceleyici bağladığında, inceleyici belirlenmiş ürün sürümünü ve bu incelemenin ölçütlerini değiştirmeden okuyup bulgu üretebilsin. Bulgusunu teslim edebilsin; yetkisi yetersizse veya gerekli gözleme ulaşamıyorsa bunu açık bıraksın.

Bu gereksinim bu örneğin çalışma varsayımıdır; bütün inceleyicilerin her işte yazamaz olması kararı değildir. Ürüne yazamamak, ayrı ve izinli bir rapor yolunun da yasak olması anlamına gelmez. Uygulamayı çalıştırmanın gerekli olduğu inceleme için güvenli ayrı çalışma kopyası veya farklı görevlendirme gerekebilir; bu tur yöntem seçilmedi.

**Düzey:** İnceleyici, ileride SOUL'un oluşturacağı/bağlayacağı roldür. Aşağıda eşlenen taraflar, bu kapasiteyi SOUL için geliştiren Development OS sorumluluklarıdır. Bir deneme inceleyicisini elle doğru ayarlamak, SOUL'un sonraki inceleyicileri doğru kurabildiğini tek başına göstermez.

## 2. Kaynakların gerçekten gösterdiği

**Mevcut aday tanımları:** B1/R1, davranış ve kontrol gereğini üretirken uygulamayı B5/B6'ya bırakır. B3/R7 rol sözleşmesini ve oluşum gereğini; R9 yetki ilişkisini taşır. B5/R13 ortam çözümünü tasarlar; R14 kurulmuş ortamın gerçek hazırlık ve işletimini yönetir. B6/R16–R17 ilişki ve kontrol kapsamını ele alır. B7/R20 parçaları kendi başına üretmediğini, ilgili sorumluları çağırdığını açıkça söyler. Bu tanımlar üretimin düşünülmediğini değil, özel kod/bağlantı üretiminin açık taşıyıcısının bu zincirde gösterilmediğini destekler.

**Superpowers'ın sabit kaynak sürümü:** Üretici şablonu işi uygulama, test yazma/çalıştırma, kendi kontrolünü yapma ve raporlama yüklerini açıkça aynı üretim görevine verir. İnceleme bulgusu sonrası düzeltme yine bu göreve döner; ayrı incelemeyi koordinatör başlatır. Bu, teknik üretimin tasarım veya kurulum adı altında kaybolmaması için somut örnektir. Kaynağın bütün talimatları, model seçimi ve raporun kanıt olarak kullanılış biçimi DevOS'a benimsenmedi; canlı çalışma sınanmadı.

**Keel'in sabit kaynak sürümü:** `rol-ac.sh` kayıtlı rolü ve profili kontrol edip rol durumunu dosyaya yazar; aynı damgayı tekrar yazmaz, farklı profil/rolün üzerine geçişi reddeder. Dosyanın yorumları tüketicileri `file-guard.sh`, `kapanis.sh` ve `acilis.sh` olarak belirtir. `file-guard.sh` giriş sözleşmesi ise yazma araçlarına ilişkin engel, soru ve serbest geçiş yollarını ayrı tarif eder. Yalnız rol damgasını yazan betiği üretmek, engelleme ve sonraki tüketici bağlantısını tamamlamaz.

**Kaynak sınırı:** Keel'in bu sürümündeki `rol-ac.sh` yorumları otomatik temizlik yolunun kaldırıldığını belirtir. S1-03'te kullanılan tarihsel rol-mekaniği kaydındaki önceki açılış temizliği tarifi, bu sürümün güncel davranışı olarak alınmadı. Bu fark ayrı bakım işi başlatmadı; sürüm bağının önemini gösterir. Koruma betiğinin tamamı ve alt bağımlılıkları okunmadı/çalıştırılmadı. Burada Keel güvenlik garantisi, bütün yazma yollarının kapalı olduğu veya bugünkü çalıştırma ortamının davranışı doğrulanmış değildir.

## 3. Örneğin DevOS geliştirme zinciri — aday eşleme

Tablo bir kadro ataması değil, mevcut aday kapsamlarıyla gerekçeli karşılaştırmadır. Bir satırdaki destekleyici roller eşit ve belirsiz ortak sahipler sayılmaz; somut geliştirme işi açıldığında teslim sorumlusu ayrıca atanmalıdır.

| Halka ve başarı yönü | Somut çıktı ve sonraki tüketici | Mevcut aday karşılığı | Gerekli bilgi/yetki ve sınama |
|---|---|---|---|
| **1. İnceleme gereğini ve sınırını belirlemek:** hangi durumda ne korunmalı? | Korunacak ürün/ölçüt/sürüm, izinli okuma ve raporlama, yasak değişiklik, yetersizlik halinde davranış. Çözüm tasarımına gider. | **R7** rol gereği; **R1** ortak davranış girdisi; **R9** yetki sınırına katkı. | Üst amaç ve inceleme ihtiyacı bilinmeli. Salt-okurluk gerekçesi ve hangi incelemeleri olanaksızlaştırabileceği sorgulanmalı; bütün rollere genellenmemeli. |
| **2. Gerçekleştirme yolunu araştırıp tasarlamak:** gereği hangi uygulanabilir düzen karşılar? | Hazır kabiliyet kullanma, uyarlama veya yeni mekanizma seçenekleri; seçimin gerekçesi, bağlantı ve koruma kapsamı. Üretim görevine gider. | **R13** ortam çözümü; **R16** rol–iş–ürün/sürüm bağı; **R17** kontrol kapsamı katkısı. | Gerçek araç/ortam davranışı, diğer etki yolları, hata durumları ve kısıtlar bilinmeli. Belge vaadi çalışırlık kanıtı sayılmaz. R13'ün bütün gerekli uygulama uzmanlığını zaten taşıdığı varsayılmaz. |
| **3. Çözümü üretmek veya uyarlamak:** gereği çalışan geliştirme çıktısına dönüştürmek. | Gerekli kod, ayar, rol oluşturma yordamı, bağlantı ve test değişiklikleri; sürüm ve açık eksikler. Kurulum/bütünleştirme sorumlusuna gider. | **G1'in açık noktası.** R14/R20 tanımları bu yükün açık sahibi değildir. Bu örnek için **teknik gerçekleştirme görevlendirmesi** adayı öneriliyor; yeni R kimliği verilmiyor. | Uygulama bilgisi, ilgili asıl kaynaklar, değiştirilebilir geliştirme alanı, yeterli araçlar ve sınırları belirlenmiş değişiklik yetkisi gerekir. Kendi testleri üretim kanıtıdır; bağımsız yeterlik hükmü değildir. |
| **4. Kurmak ve bütünleştirmek:** üretilen parçanın doğru çalışma yoluna gerçekten bağlanması. | Belirli sürümde kurulum, rol başlatma, ürün/rapor yolları ve kontrol bağlantısı; kurulumun eksik kalan kısımları. Sınama görevine gider. | **R14** fiilî ortam kurma/hazırlık; birden çok parça varsa **R20** kurulumun koordinasyonu. | Yalnız dosyanın varlığı değil fiilî bağlanma görülmeli. Kurulum ayarı ile yeni bağlantı kodu üretmek ayrılmalı; yeni kod gerekiyorsa 3. halkaya açık iş olarak dönülmeli. |
| **5. Sınamak ve kapsamlı hüküm vermek:** güvence ve işe yararlılık birlikte destekleniyor mu? | İddia–senaryo–kanıt–hüküm bağı; başarılı, başarısız ve sınanamayan durumlar. Teknik teslim veya düzeltme kararına gider. | **R24/R25** sınama tasarımı ve yürütümü için yeniden kullanım adayı; **R15** gerçek etki; **R18** birleşik hüküm. **R2** yalnız davranış iddiası da sınanacaksa. | Bu yerel geliştirme örneğine uyarlama önerisidir; B9'un bütünü buraya taşınmaz. Üreticinin açıklamasından ayrı ürün/ölçüt ve uygun gözlem gerekir. Test yolu kendi yanlışını da ayırt edebilmeli. |
| **6. Kusur varsa teşhis edip doğru halkaya dönmek:** rastgele aynı işlemi tekrarlamamak. | Neden adayı, değişmesi gereken gereksinim/tasarım/uygulama/kurulum/test ve yeniden sınama kapsamı. İlgili geliştirme işine gider. | **R3** teşhis; ilgili tasarım veya gerçekleştirme sorumlusu düzeltme. İş sırası için R11'in desteği gerekebilir. | Ayrı hakem adı nedensel yeterlik yaratmaz. Alan bilgisi ve nedenleri ayırt eden kanıt gerekir. Üretici kendi değişikliğine bağımsız nihai hüküm vermez. |

M1/M4/M6 gibi mekanik sorumluluk kümeleri geliştirme çıktısının gerekli işlevlerini gösterir; tablodaki üretim sorumlusunun yerine geçmez. Bu tablo onları kesin yazılım modüllerine veya ayrı kişilere dönüştürmez.

## 4. Tartışılabilir görev kartı — teknik gerçekleştirme

Bu kartın amacı yeni unvan icat etmek değil, 3. halkada görünmeyen yükü görünür kılmaktır.

**Başarı yönü:** Verilmiş amaç ve sınırlar içinde, gereken mekanizmayı kullanılabilir ve sınanabilir geliştirme çıktısına dönüştürmek. Kod miktarı, olumlu rapor veya işi her koşulda kapatma başarı ölçütü değildir.

**Bu örnekte görevi:** Seçilen çözüm için gereken rol oluşturma yordamını, araç/izin ayarını, bağlantı kodunu veya kontrol betiğini üretmek/uyarlamak; kendi geliştirme testlerini yapmak; eksik kalan davranışı dürüstçe teslim etmek. Hazır kabiliyet yeterliyse yeni kod yazmak zorunlu değildir; gerçek ayarı ve bağlantıyı üretme sorumluluğu yine vardır.

**Girdisi:** Gereksinimin gerekçesi; korunacak hedef/sürüm; izinli davranış; çözüm kararı ve açık sorular; gerçek ortam bilgisi; mevcut kod ve testler; ilgili araştırmaya/asıl belgeye erişim; değişiklik yetkisi. Rol adı bu bilgi ve yeterliği kendiliğinden sağlamaz. R5 bağlam desteği ve R8 yeterlik incelemesi gerekirse kullanılabilir; kaynakları sunmak uzmanlık kanıtı değildir.

**Yetki sınırı:** Belirlenmiş geliştirme alanını değiştirebilir. İncelenecek ürünün kabul ölçütünü, yetki sınırını veya bağımsız değerlendirme kanıtını kendi başarısı için değiştiremez. Tasarım uygulanamıyor ya da yanlış görünüyorsa bunu gerekçesiyle geri açar; gereği sessizce gevşetmez. Olağan uygulama kararları kapsam içindeyse kendisine bırakılabilir; gerçek kapsam/yetki değişikliği ilgili karar yoluna gider, otomatik müşteriye teknik soru olarak yüklenmez.

**Teslimi:** Sürümlü gerçek değişiklik, nasıl bağlanacağı, çalıştırdığı testlerin komutu/sonucu, hangi gereği karşıladığı ve neyin hâlâ açık olduğu. Bağımsız doğrulama varmış gibi yalnız kendi testini göstermez.

**Tetik ve dönüş:** Açık üretim/uyarlama işi ve yeterli girişler oluştuğunda görevlendirilir. Kurulum/sınama bulgusu geldiğinde ilgili değişiklik için yeniden çağrılabilir. Bulgudan sonraki düzeltme aynı üretim sorumluluğunun devamı olabilir; değişen sürüm yeniden sınanır.

**Önemli düzey ayrımı:** Bu kodu yazan DevOS aktörünün yazma yetkisi olması, SOUL'da oluşturulacak salt-okur inceleyicinin yazabilmesi anlamına gelmez. Geliştirme yetkisi ile oluşturulan rolün işletim yetkisi farklı bağlardır.

## 5. Bu yük hangi mevcut rolle birleşebilir?

- **R13 ile tasarım–gerçekleştirme birlikteliği:** Mevcut R13'e kod üretimini olmuş bitmiş sorumluluk diye ekleyemeyiz. Fakat aynı somut görevlendirme, yeterli uzmanlık ve araçla bir sınırlandırılmış çözümü tasarlayıp üretebilir. Tasarım ve üretim aynı üst sonuca hizmet edebilir; birden fazla faaliyet otomatik çatışan motivasyon değildir. Kendi tasarımını koruma baskısı ayrıca sınanmalı.
- **R14'ün genişletilmesi:** Küçük kurulum ayarı/bağlantısı mevcut işletim yüküyle birlikte taşınabilir. Yeni mekanizmanın geliştirilmesi ise açık çıktı, yeterlik ve değişiklik yetkisi eklenmeden bu role yüklenmemeli. Bugünkü hazırlığı koruma ile yeni sürüm geliştirme gerekirse ayrı görevlendirmelere ayrılır.
- **R20'nin genişletilmesi:** Üreticiyi devreye almak ve eksik geliştirme işini izlemek koordinasyona uygundur. Bu, R20'nin kendisinin kodu ürettiğini göstermez. R20 üretim de yapacaksa o etkin görev ve yeterlik ayrıca görünür olmalı; koordinatör her uzmanlığın örtük sahibi yapılmamalı.

**Bu örnek için öneri:** Teknik gerçekleştirme yükünü sorumluluk haritasında ayrı görünür tut; kimin taşıyacağını ilgili uzmanlık ve kapsamla eşleştir. Tasarım/uyarlama/düzeltme gerektiğinde aynı geliştirme görevlendirmesinde birleşebilir. Bağımsız yeterlik hükmü bu başarı beklentisine katılmaz. Bu, yeni kalıcı aile, R26 veya ayrı ajan kararı değildir.

## 6. Öneriyi yanlışlayacak sınamalar — henüz koşulmadı

| Durum | Beklenen gözlem / yanlış sonuç |
|---|---|
| İnceleyici hedefi okuyup ayrı kanaldan bulgu teslim ediyor. | Meşru inceleme tamamlanabilmeli. Her işlemi engelleyen düzen, yalnız hedef değişmedi diye başarılı sayılmaz. |
| İzin dışı hedef değişikliği deneniyor. | Seçilen kapsamın gerçek erişim yollarında değişiklik oluşmamalı; yalnız engel mesajı değil hedefin durumu da incelenmeli. Bir yolun deneyi bütün yolların kanıtı değildir. |
| Gerekli kontrol/rol bağı eksik veya yanlış. | Güvenli olduğu doğrulanmayan inceleme yolu sessizce etkinleştirilmemeli; eksiklik açık kalmalı. Bu teknik tepki bu örnek için adaydır. |
| SOUL aynı kapasiteyle yeni bir inceleyici oluşturuyor. | Önceden elle hazırlanmış örneğin dışında rol, hedef, bağlam ve sınırların tekrar doğru kurulduğu sınanmalı. Böylece oluşturma tarifi ile kurulmuş rol arasındaki aktarım da sınanır. |
| İnceleyici bulgusu düzeltmeye yol açıyor. | Düzeltme açık üretim görevine gider; yeni sürüm eski hükmü otomatik devralmaz. İnceleyici rolünün yetkisi sırf düzeltme yararlı diye sessizce genişlemez. |
| Kontrol kodu bilerek bozulan güvenli test örneği. | Sınama düzeninin ilgili bozukluğu yakalayabilmesi gerekir. Bu kasıtlı bozma üretim sistemine uygulanmaz. |

Mekanik engelin işlemesi aktörün iyi akıl yürüttüğünün; aktörün yazmayı hiç denememesi de mekanik engelin işleyeceğinin tek başına kanıtı değildir. İddialar ayrı sınanır. Raporu üretememe, yanlış hedefe bakma veya sonucun sonraki işte kullanılmaması da bu zinciri başarısız kılabilir.

## 7. Sonuç ve dönüş noktası

**S1-04-A1:** G1 bir örnekte somutlaştırıldı: gereksinim, tasarım, fiilî üretim/uyarlama, kurulum ve sınama arasındaki teslimler gösterildi. Fiilî üretim için açık görevlendirme gereği korunuyor; yeni kişi/ajan gereği çıkarılmadı.

**S1-04-A2:** Teknik gerçekleştirme görev kartı, mevcut adayları koşullu genişletmeyi veya daha sonra ortak geliştirme ailesinde değerlendirmeyi tartışılabilir hâle getiriyor. Üretim ve kendi kontrolü birlikte olabilir; bağımsız hüküm aynı değildir.

**S1-04-A3:** Geliştirilen mekanizma, onu işleten DevOS görevi ve SOUL'un daha sonra oluşturduğu inceleyici aynı nesne değildir. Örneğin sınaması yalnız elle kurulmuş tek rolü değil, oluşturma/bağlama aktarımını da kapsamalı.

Bu ilk harita bütün G1'i, S1'i veya M1–M9 geliştirme kapsamını kapatmaz. Adayı kullanıcıya sun; sonraki düzeltmesini önce al. Devamda aynı gerçekleştirme sorumluluğunun başka bir B alanında da aynı başarı yönünü taşıyıp taşımadığı karşılaştırılabilir. Bu, henüz genel aile birleştirmesi veya mimari kararı değildir.

## 8. Okuma izi ve kanıt sınırı

STATE/HANDOFF/WORK/ACTORS ve S1 güncel içerikleri okundu; S1'in kesilen sonu ayrıca getirildi. S1-01 1–100 ve 101–240 ile tam okundu. S1-02/S1-03'ün bu konuşmada zaten bulunan kaynak metinleri değerlendirme girdisi olarak korundu; bu tur yeni tam okuma diye kaydedilmedi. Kontrol protokolleri araştırma kanıtı değildir.

| Kaynak | Bu turdaki okuma / kimlik |
|---|---|
| [B1](B1-common-intellectual-baseline.md) | Seçici 100–240; `b53c22d17ce40525b3a9f59792c5d1e29315e4ae`. |
| [B3](B3-actors-capacity.md) | Seçici 175–300; `b1a3866b7df8975106f07323daf655018263cdae`. |
| [B5](B5-environment-capacity.md) | Seçici 105–215; `6177f92dd0c19b1861de87a6afffa80a1e238ff5`. |
| [B6](B6-cross-ground-integration.md) | Seçici 180–325; `b8504f86bfb40698c45101b537858691d17adbd0`. |
| [B7](B7-system-formation.md) | Seçici 215–310; `1abd037320085fe83d81d5d658aa59162d234b58`. |
| [B9](B9-integration-and-testing.md) | Seçici 270–370; `a177e6951558bfab8120c9221469ae81eacf3a53`. |
| Superpowers `skills/subagent-driven-development/implementer-prompt.md` | Tam; ref `b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, blob `5c8ecd61fba036263bf88d0af24d47125780efa0`. |
| Keel `tools/guard/rol-ac.sh` | Tam; ref `669c5445cf34dcf15ed4f4d435b5f3657077550a`, blob `d04c99533def7a18394383bbb26d788ea334633a`. |
| Keel `tools/guard/file-guard.sh` | Seçici: 1–170 isteği kesildi; başlangıç sözleşmesi 1–27 yeniden getirildi. Tam dosya okuma veya etkinlik doğrulaması değildir. Aynı ref; blob `67abfd4ffdb4ae31eb82af6c64351d8170356884`. |

Asıl kaynak yolları: https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/subagent-driven-development/implementer-prompt.md ; https://github.com/batuhanozgun/keel/blob/669c5445cf34dcf15ed4f4d435b5f3657077550a/tools/guard/rol-ac.sh ; https://github.com/batuhanozgun/keel/blob/669c5445cf34dcf15ed4f4d435b5f3657077550a/tools/guard/file-guard.sh .

Yeni canlı model/Keel/DevOS deneyi, mekanizma uygulaması veya güncel sağlayıcı davranışı doğrulaması yapılmadı. Kaynaklarda talimat yazması etkinliğin kanıtı yapılmadı. İlk R/M adayları, B dosyaları, DECISIONS, Foundation ve kaynak depolar değiştirilmedi.
