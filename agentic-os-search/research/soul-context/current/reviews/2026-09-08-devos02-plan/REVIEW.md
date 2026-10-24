> **30 Eylül 2026 — tarihsel DevOS 02 / RPD değerlendirmesi ve yetki önerisi.** Aşağıdaki “tek güncel sözleşme”, RPD01 kurulumu, AGENTS değişikliği, K/RP testleri ve normal devam önerisi 8 Eylül'deki `soul-development-os_02` denemesine aittir. Bugünkü kurucuya veya bu bakım çalışmasına yetki vermez. RPD'nin kavramsal içeriği, sentetik testlerin sınırı ve henüz benimsenmemiş öneri statüsü korunur; eski kontrol/kurulum görevi uygulanmaz.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. [Öneksiz tarihsel kaynak](https://github.com/batuhanozgun/agentic-os-search/blob/67fd24ec4574dbb3d5024cd9acd10d522ee11d00/research/soul-context/current/reviews/2026-09-08-devos02-plan/REVIEW.md) aşağıda değiştirilmeden korunur; eski hedef depoya yazılmaz, araştırma kontrol dosyaları değiştirilmez.

---

# DevOS 02 — RPD ışığında konsolide değerlendirme ve uygulama sözleşmesi

**Kimlik:** `DEVOS02-RPD-INTEGRATION-2026-09-08-v2`  
**Hüküm:** Aşağıdaki sınırlı yetki kullanıcı tarafından benimsendiğinde, Codex içinde önkoşul keşfi, iç tasarım uyarlaması, RPD kontrolünün kurulması, gerçek doğrulama ve Development OS devamına uygun.  
**Statü:** Kullanıcıya sunulan yeniden değerlendirme; Codex'e gönderildiği, yetkinin benimsendiği veya uygulamanın yapıldığı gözlenmedi.  
**Hedef:** `batuhanozgun/soul-development-os_02`, `main`.  
**İncelenen başlangıç:** `a91c7a956734580106139d5ce0ba8dd74660f161`.  
**PLAN:** `work/devos-bootstrap/PLAN.md`, blob `7cd3dc1c303beb1e1b7cb1bd4a63ce23f224433d`.  
**EVIDENCE:** aynı dizin, blob `98b74acee2426599c80343c2e4677320ac19193c`.

Bu metin önceki `DEVOS02-FINAL-REVIEW-2026-09-08` değerlendirmesinin ve henüz gönderilmemiş `DEVOS02-KERNEL-IMPLEMENT-AND-CONTINUE-v1` mesajının **yerine geçen tek güncel sözleşmedir**. Önceki F01–F03 güvenceleri burada korunur ve yeni hedefe uyarlanır; üst üste ayrı güncel talimatlar olarak işletilmez. Eski sürüm Research `6546e6a3f6786bd6360ef811b3b7fa799578f499` tarihinde korunur. Eski hedef repository'sinden mandat veya READY taşınmaz.

Bu bir Research değerlendirmesi ve kullanıcıya sunulan grant önerisidir. Dosyanın varlığı yetki değildir. Hedefte yürütme, Batu'nun bu exact sürümü benimseyerek ilettiği gerçek mesajdan doğar. Research AGENT/agent protokolleri Codex'e ithal edilmez; hedefin kendi kontrolü uygulanır. Platform ve geçerli üst talimatlar korunur.

## 1. Yeni girdiler ve kanıtın sınırı

Kullanıcı RPD'nin uygulanmasını istiyor; süreklilik mimarisini **öneri**, ZIP'i **tamamen uydurma/sentetik deneme** olarak verdi. Bu üç statü korunacaktır:

| Kaynak | SHA-256 | Kullanım statüsü |
|---|---|---|
| `ozyinelemeli_onkosul_kesfi_kavramsal_temel.md` | `9af3e87eea0e589ea2f5f14e863de6cafdabf68ed585efd0214603492c096e09` | RPD'nin kullanıcı tarafından sağlanan kavramsal tanımı; doğrulanmış algoritma/standart iddiası yok. |
| `RPD_Sureklilik_Tasarimi_v0_1.md` | `7fc37d3fb3ca7777517691112439bad9718346e5c063c4cee34f31066d1a8121` | Uygulama mimarisi önerisi; zorunlu topology veya kabul edilmiş tasarım değil. |
| `RPD_Sureklilik_Paketi_v0_1.zip` | `0a1167a5e51123c22a006e7222441b99567e77ad3b8f02c57ede1fe5fd5cde56` | Sentetik örnekler, pasif adaptörler ve kayıt prototipi; kurulum paketi olarak benimsenmedi. |

Research bu tur iki Markdown metnini ve ZIP'teki 24 dosyayı okudu. ZIP'in kavramsal ve tasarım kopyaları dışarıdaki iki dosyayla byte-identical; manifestteki 23 içerik hash'i eşleşti. Referans Python kodu, testleri ve örnekleri okunarak yerel izole geçici alanlarda sınandı. `python -B -m unittest discover -s tests -v` ile **25 test geçti**; demo tamamlandı. Bu Linux/Python kayıt deneyi, kullanıcı Codex'inde LLM/RPD/oturum/araç güvenliği deneyi değildir.

İki ek yerel sınır yoklaması, prototipin daha güçlü kullanım için eksik olduğunu somutlaştırdı: (a) önkoşulu WAITING kalan bir kayıt, CHECKED ve gerçekliği doğrulanmayan kanıt referansıyla ACCEPTED yazılabildi; (b) `apply` çağrısında opsiyonel claim verilmezse aktif tahsisten farklı author yazabildi. Bunlar tasarımda da belirtilen anlamsal denetim ve güvenilir çağıran sınırlarıyla uyumludur; RPD kavramının yanlışlandığı veya üretim açığı bulunduğu anlamına gelmez. Kodu bu haliyle yetki/hazır olma/kabul denetleyicisi yapma.

Paketin `depends_on` modeli seçilmiş VE önkoşullarının dar alt kümesidir; tam VEYA/method/senaryo modeli değildir. Şablonlar aynı API'nin üretim şeması değildir. Belgede anılan `SKILL.md v0.1.1-draft` paket içinde yoktur. Eksik skill'i okunmuş/kurulu sayma; her hedefte uygulanma kuralı mevcut CORE ve yeni kullanıcı yönünden açıkça geri kazanılabilir.

Kaynaklar şu anda konuşma ekleridir, Research'te tam ham kaynak kopyaları bulunduğu iddia edilmez. Codex'e üçü de birlikte verilecek. Kabul sonrasında hedefin aşağıdaki izinli references alanında exact kopya ve hash'leri saklanır; özet ham kaynağın yerine geçirilmez. ZIP içindeki START_HERE, CORE ve adaptör buyruğu kendiliğinden aktif kontrol değildir.

## 2. Önceki hükümde değişen esas nokta

Önceki planın kaynak sadakati, authority, native üretim, ayrı değerlendirme, gerçek etki ve süreklilik tasarımı korunmaya değer. Ancak seçilmiş işleri doğru yürütme disiplini, **hangi işlerin önce gerekli olduğunu keşfetme** davranışının yerine geçmez.

RPD'nin getirdiği zorunlu fark: kullanıcı ve root bütün eksikleri önceden adlandırmadan, ana ve alt ajanlar hedef → ihtiyaç → yönteme bağlı önkoşullar → başlanabilir eylemler ilişkisini kendileri kuracak; bunun henüz bitmemiş kısmını da devredecek. Bir planın bütün gelecekteki ayrıntılarının kapanması beklenmez. Kapanması gereken, bir sonraki etkili eylemin karar-kritik önkoşullarıdır. Sonucu bilinmeyen bir araştırma/deney, yöntemi ve yetkisi belli olduğu için başlanabilir olabilir.

Bu nedenle eski planın `devos_check.py → devos_context.py` sırası artık zorunlu rota değildir. Bunlar güçlü adaylardır; RPD ile gösterilmiş ihtiyacı karşılıyorlarsa korunur, yeterli mevcut mekanizma varsa zorla üretilmez, daha uygun kapsam-içi pilot varsa gerekçeli değiştirilir. Buna karşılık yalnız başka bir plan/rol listesi üretip geliştirme çekirdeği çalıştı deneme: anlamlı bir native üretim ve gerçek çıktı/doğrulama yolu gösterilecektir.

İkinci maddi değişiklik yetkidedir. Önceki tüm kontrol değişikliklerini yasaklayan kapsam, RPD'yi yeni konuşmalarda ve child'larda kalıcı kılmaya yeterli değildir. Bu sözleşme yalnız RPD için **AGENTS'e dar ek + tek bağlı RPD protokolü** değişikliğini açıkça önerir. Mevcut 12 protokolü yeniden yazma yetkisi vermez.

## 3. Foundation ve studies ile birlikte değerlendirme

| Mercek | RPD'ye taşınan ayrım | Yerel uygulama sonucu |
|---|---|---|
| INFORMATION | Bilinen, varsayılan, temsil edilen, gözlenen ve kanıtla desteklenen ayrı; oluşum/dönüşüm/seçim farklı. | Açık inceleme, kaynak sürümü, yöntem ve karar niteliği korunur; doğru dosyanın varlığı doğru context/kullanım demek değildir. |
| WORK | Amaç, yöntem, iş, admission, execution, outcome ve acceptance ayrı; keşif/meta-work gerçek iştir. | Önkoşul ile bileşen ilişkisi karışmaz; yapılabilir işler kümesi ve bekleyen keşif korunur. Bütün işi tek sabit task pipeline'a indirgeme. |
| ACTOR | Kimlik, rol, yetenek, yetki, katılım ve sorumluluk farklı. | Child kendi önkoşul keşfini/üretimini sahiplenir; owner tercihini uydurmaz. Mantıksal recursion, fiziksel agent recursion değildir. |
| ENVIRONMENT | Gerçek kabiliyet, erişim, yeterlilik, kapasite ve durum farklıdır. | Mevcut yeterli zeminde dur; olmayan aracı varsayma; bir kaynak aynı anda iki bağdaşmaz işi karşılamış sayılamaz. |
| Binding/Standing/Control/Transition | Exact ilişki ve applicability; değerlendirme/kabul/gerçek etki; değişim ve güncellik ayrılır. | Read-set, method-specific bağımlılık, etki uzlaştırma, kontrollü devir ve yalnız etkilenen kullanımın yeniden değerlendirilmesi gerekir. |

Work audit'in §§5–6'sı keşif, araştırma ve çalışma düzenini değiştirmeyi zaten Work kapsamında korur. RPD beşinci Foundation ground veya hazır ontoloji değildir. Aynı şekilde R01/R03/R05/R07 disiplinleriyle örtüşmesi, RPD davranışının mevcut Codex planında otomatik uygulanmış olduğunu kanıtlamaz.

Seçici studies girdileri: gstack'ın görev/sonuç, qualification-loss, liveness ve gerçek tool-call kontrolleri; multi-agent-patterns'in coordinator hatası ve gizli insan koordinasyonu; context-memory-harness'in persistence/memory/context ve mekanizma/sorumluluk ayrımı; AI knowledge strategies'in araçtan önce ihtiyaç yaklaşımı; SDLC çalışmasının kontrol değişimini de değerlendirme nesnesi yapması; Hermes'in partial effect ve worker context aktarımı sınırları. Bunlar mekanizma ve karşıörnek girdileridir, ürün/sağlayıcı adoption değildir.

Başlangıç araştırması için eski PLAN'ın `4ad34d7429e5c63f2cbc327e79f3a0038c5568de` ref'i korunabilir. Maddi güncellik gerekirse yeni exact ref ayrıca kaydedilir; eski kararın dayanağı sessizce değiştirilmez. Research'e yazılmaz ve inactive Foundation araştırması kendiliğinden başlatılmaz.

## 4. Kurulacak en küçük davranış entegrasyonu

### 4.1. Tek giriş ve RPD'nin her hedefte uygulanması

Hedef `AGENTS.md` içindeki mevcut iki tür, mevcut 12 satırın ID/soruları, LOAD/SKIP, full-read/re-gating, kontrol–çalışma ayrımı ve `ID–Soru | Yanıt | Karar | Cevap` gösterimi korunacak.

Düşünme/Muhakeme registry'sine tek yeni satır ekle:

- **ID:** `RPD01`.
- **Kısa ad:** Özyinelemeli önkoşul keşfi.
- **Pozitif soru:** “Bu turda bir kullanıcı hedefini veya devredilmiş ihtiyacı karşılıyor, yeniden değerlendiriyor ya da sürdürüyor muyum?”
- **Tek canonical yol:** `devos-agent/protocols/reasoning/prerequisite-discovery.md`.

Her kullanıcı hedefi, açıklama/düzenleme gibi küçük hedefler dahil, ve her devredilmiş ihtiyaç için yanıt evettir. Karmaşıklık veya risk düşüklüğü SKIP gerekçesi değildir. Sadece hiçbir hedef/işin ele alınmadığı salt sosyal karşılık confidently-no olabilir. Başlangıç zemini zaten yeterliyse RPD kısa sürer; bu yöntem kapatma değildir. RPD'nin uygulanması her küçük görev için dosya, graph, tool veya uzun çıktı üretme zorunluluğu oluşturmaz.

Registry önceki gibi esas işten önce tamamlanır; RPD kapıdan önce gizli bir ön değerlendirme yoluna dönüşmez. Aynı hedefte değişmeyen geçerli keşfi her tur sıfırdan üretme; kayıtlı odak ve yeni durum farkından devam et. Mevcut her-turn gate korunur; 13 ID tabloya girer. Aynı oturumda tam görünür, değişmemiş protokolü gereksiz yeniden getirme. Gerekli kaynak görünür değilse full-read yapılır. Araç sonucu/yeni hedef/method değişimi maddi önkoşul veya kontrol ihtiyacı doğurursa ilgili işi yeniden değerlendir.

### 4.2. Tek RPD protokolünün taşıması gereken davranış sözleşmesi

Aşağıdaki semantik maddeleri kısa, konu-bağımsız bir canonical protokole dönüştür. Bunlar iç düşünce dökümü değil, dışarıdan sınanacak davranış ve kayıt koşullarıdır. Kalıcı proje amacı, active work ve örnek ERP hedefleri protokole gömülmez.

1. **Hedefi koru:** Son yetkili sonucu, mevcut odak ihtiyacı ve üst hedef bağını bul. Kullanıcı hedefini araç, yerel teslim veya kolaylaştırılmış başka hedefle sessizce değiştirme.
2. **Önkoşulu keşfet:** Odak ihtiyaç için önce neyin gerekli olduğunu mevcut durum, bilgi, kaynak ve yetki altında araştır. Her alt koşulun hangi üst eksikliği neden kapattığını belirt; aradaki gereklilik yerine araç adı koyma. İlgili Foundation/study/alan bilgisine gerektiği yerde in.
3. **Türleri ve yolları ayır:** İhtiyaç, koşul, yöntem, karar, eylem ve bileşen ilişkisini ayır. Birlikte gerekli VE koşullarını, alternatif VEYA yöntemlerini ve yalnız seçili yola bağlı gerekliliği koru. İlk yöntem bütün hedefin zorunlu yolu değildir.
4. **Bilgi ve kararı ayır:** Gözlenen, kullanıcı bildirdiği, varsayılan, bilinmeyen, sınanan ve kabul edilen ayrı kalır. Ürün/owner kararı gerektiğini bulmak cevabını verme yetkisi değildir. Kapsam içi teknik bilgiyi kendin araştır; yalnız gerçek owner tercihi/yetkisi gerektiren konuyu seçenek/etkisiyle yükselt.
5. **Özyinelemeyi işe dönüştür:** Alt koşul belirsizse aynı incelemeyi ona uygula; gereken bilgi yalnız düşünmeyle çıkmıyorsa kaynak okuma, ölçüm veya deney işi üret. Mantıksal derinlik için her seferinde yeni alt ajan açma.
6. **Başlangıç zeminini ayır:** Zaten sağlanmış koşullarla şimdi yapılabilir eylemler ayrı. Eylemin bilinen önkoşulları, erişim/yetki/kaynakları, beklenen çıktısı ve denetim yolu yeterli olduğunda başlanabilir. Bu, başarı garantisi değildir. Yeterli mevcut kabiliyetin daha alt üretim nedenlerine gereksiz inme; bütün graph'ın bitmesini bekleme.
7. **Ortaklık ve kapasiteyi koru:** Benzer ad aynı ihtiyaç değildir. Kimlik, kapsam, sürüm, yöntem ve haklar uygunsa ortak koşulu yeniden kullan. Tüketilen veya zamana bağlı kaynakları iki bağdaşmaz işe iki kez tahsis etme. Yanlış bağımlılık döngüsüyle `taslak v1 → test → taslak v2` yinelemesini ayır.
8. **İleri sınama yap:** Başlanabilir eylemin beklenen etkisi gerçekten üst ihtiyacı karşılıyor mu, diğer zorunlu dallar açık mı ve kaynaklar bağdaşıyor mu kontrol et. Geri/ileri yol uyumu veya iki ajanın anlaşması doğruluk ispatı değildir; ortak eksik öncülü ayrıca ara. Her küçük iş için ikinci ajan zorunlu değildir.
9. **Gözlemle ve güncelle:** Eylem sonucu beklenmiyorsa sadece aynı adımı tekrar etme; yöntemi, eksik üst ihtiyacı veya dayanağı yeniden aç. Etkilenen ilişkiler boyunca yeniden değerlendirme yap; ilgisiz sonuçları sıfırlama. Girdiler hazır diye parent çıktısı oluşmuş sayılmaz; tamamlanmış keşif, keşfedilen ihtiyacın karşılandığı anlamına gelmez.
10. **Bitmemiş keşfi devret:** Her anlamlı değişimde dışa açık durum farkı ve devam konumu korunur. Hangi açık sorudayım, hangi alt sonucu bekliyorum, nereye döneceğim ve sıradaki somut işlem nedir? Yalnız kapanış hook'una veya son mesaja güvenme. Gizli düşünce zinciri kaydetme.
11. **Durma nedenini doğru adlandır:** Hazır, bekleyen, engelli, kısmi, kaynağı bitmiş, doğrulamaya sunulmuş ve tamamlanmış farklıdır. Kuyruk boşluğu veya süre sonu kök hedefi tamamlamaz. Yeni ihtiyaç keşfi yeni yetki yaratmaz; kullanıcı durdurması ve bütçe geçerlidir.
12. **Kendi altyapına da uygula:** Skill/hook/store/role/config ancak gösterilmiş ihtiyaç için seçilir. Referans paket, template veya açıklama aktif kural olmaz. Mevcut yeterli işlevleri tekrar kurma; gerçek bir sınır gerekiyorsa talimatı mekanik enforcement diye adlandırma.

Bu değişikliğin aday metnini uygulamadan önce kernel WORK'te sabitle; mevcut geçerli kontrol ve bu owner grant'ına karşı ayrı-start eleştiri al. Gerçek hataları kapsam içinde düzelt; değişmiş kontrolü tam geri okuyup gate'i yenile. RPD01 ve rol girişlerinin fiilî kullanımı aşağıdaki davranış testlerinden geçmeden entegrasyon tamamlandı denmez. Bu yetki bu RPD uyarlamasına ve onun bounded onarımına özeldir; sonraki keyfî çekirdek kontrol değişikliklerine açık çek değildir.

### 4.3. Root ve child'ın aynı yöntemi, farklı kapsamı

PLAN §5 rol girişlerine, kendi görevleri için RPD01 uygulaması ve RPD kayıt bağları eklenir. Child yalnız parent'ın önceden çözdüğü planı icra etmez: yeni önkoşulu bulur, kaynağa iner, kendi çözümünü üretir, parent'ın yanlış ayrıştırmasına itiraz eder. Kapsam içindeyse işi yapar; dışındaysa üst ihtiyaçla bağlı öneri/engel döndürür. Child yeni yetki veya sınırsız torun başlatma hakkı kazanmaz.

Görev ve sonuç, en az `goal/parent_need/focus_need`, work/attempt/actor, control+role-entry sürümü, method/assumption kapsamı, kaynak/read-set, etki sınırı, beklenen sonuç/ölçüt ve dönüş noktasını korur. Yeni gereklilik, açık alternatif, henüz incelenmemiş konu ve continuation sonuç sözleşmesine girer. Sadece “bitti” veya “RPD uyguladım” beyanı kabul değildir.

## 5. Süreklilik: mimari öneriyi değil, karşılanacak işlevi benimse

İlk aday, mevcut STATE/WORK/EVIDENCE düzenini genişletmektir. RPD için ikinci canonical HEAD/commit deposu, task database, scheduler veya paralel current state otomatik kurulmaz. Önerideki üç ayrım işlevsel olarak korunur: kabul edilmiş çalışma durumu, attempt'e ait kısmi keşif/sonuç önerisi ve onlardan türetilmiş insan görünümü. Bunların üç ayrı servis veya dosya ağacı olması gerekmez.

Her kalıcı ihtiyacın bir authoritative kaydı ve kararlı kimliği olur; diğer işler aynı ihtiyacın kopyasını değil bağlantısını taşır. Kayıt, üst bağ/gerekçe, yöntem kapsamı, bilinen önkoşullar, alternatifler, karar sahibi, kaynak/güncellik, ilerleme ve geçerlilik ayrımını korur. Keşif sırasında graph tamamlanmamış olabilir; eksikliği açık tutulur.

**Devam kartı minimumu:** goal/work/attempt/protocol kimliği; focus ve parent/return-to; okunan ilgili sürümler; tamamlanan dışa açık işlem; açık inceleme; aday/elenen yöntem ve kısa gerekçe; beklenen alt sonuçlar; sıradaki somut eylem; henüz yapılmayan; durma nedeni; sonucu belirsiz yan etkiler. Geçerli alt sonucu sözleşmesiyle taşı; onun bütün üretim sohbetini her seferinde yükleme. Gerekli bağlam sığmıyorsa işi böl veya açık engel bırak, sessiz kırpma yapma.

Root ortak STATE/WORK kabulünün yazıcısıdır. Child için yalnız açıkça ayrılmış `runs/<attempt>/` checkpoint/sonuç alanı ve gerekiyorsa ayrı atanmış kod/test yolları vardır. Child'ın kısmi kaydı, ortak duruma kabul edilmiş sonuç değildir. Ana ve alt ajanların kayıt/etki/yetki bağı aynı ciddiyetle sınanır; root'un özel sohbetinde saklı başka bir gerçek plan olmaz.

Kabul edilmiş bir devir görünümü tek tutarlı sürüme bağlanır; mevcut Git commit + ilgili dosya manifesti bunun ilk adayıdır. Okuyucu, farklı sürümlerden seçtiği parçaları tek güncel snapshot gibi birleştirmez. Kısmi/uncommitted kayıtlar yok sayılmaz ama kabul edilmiş yayın diye tüketilmez; aktif writer ve gerçek etkiyle uzlaştırılır. İşe özgü checkpoint bu yüzden her seferinde bütün projeyi yayımlamak zorunda değildir. Yeni HEAD/store ancak mevcut yolun karşılamadığı somut bir ihtiyaçla gerekçelenebilir ve burada verilen kapsamın dışına sessizce çıkamaz.

Root sonuç kabulünde exact girdileri ve değişim etkisini karşılaştırır. Aynı işlem yeniden gelirse yeniden uygulanmış etki değil geçmiş receipt olarak tanınır; aynı ID'nin farklı içeriği çatışmadır. Yanlış/stale/partial veri korunarak reddedilir veya yeniden incelemeye alınır. Git merge bu anlamsal kararı vermez.

**Süre dolması duruş değildir.** Prototipin lease/fencing fikri ancak kullanılan kayıt yolu içinde eski kabulü sınırlar. Paylaşılan code/filesystem'de eski yazıcı gerçek sonlanmadan veya ilgili etkileri gerçekten dışlayan mekanizma olmadan yeniden atanmaz. Bu görevde global izin/servis izolasyonu kurulmadığından önceki kontrollü tek-yazıcı ve F03 duruş şartı sürer. Bağlam ayrılığı dosya/credential izolasyonu sayılmaz.

Yeni oturum kayıtlı kimlikleri ve gerçek ortamı birlikte kontrol eder. Kayıt son yazılmadan önce eylem gerçekleşmiş olabileceğinden belirsiz etkiyi körlemesine tekrarlamaz. Kullanıcının kısa devam mesajı yeterli olmalıdır; otomatik 24/7 başlatıcı bu görevin parçası değildir. Native aktif oturum kendi görevlerini yönetir; bütün çağrılar bittiyse dosya yeni çağrıyı kendi başına başlatamaz.

## 6. Korunan F01–F03 ve test geçerliliği

**F01 — Eksiksizlik:** Zorunlu check kümesi sonuç listesinden bağımsız ve sonuçlardan önce sabitlenir. Boş/eksik expected set, eksik artifact, yanlış attempt/target/control/criterion, çelişkili duplicate kimlik/JSON anahtar veya hiç koşmamış kontrol olumlu kapanma üretemez. Negatif örneğin beklenen reddi test başarısı olabilir; tarihsel FAIL silinmez. Bir checker seçilirse exit 0 yalnız kayıtlı bağ/tamlık kapsamıdır; testin gerçekten koşması ve içeriğin doğru olması ayrı kanıttır. RPD kaydı boşken veya READY frontier yokken kök tamamlandı sonucu çıkmaz. Çalışan pilot kendi henüz oluşmamış nihai kabul sonucunu önkoşul yapmaz.

**F02 — Etkin kontrol:** AGENTS/protokol hash'lerine doldurulmuş role-entry, exact grant ve gözlenebilir ilgili runtime/override koşulları eklenir. Bilinmeyen platform içini tam denetlenmiş sayma. Yeni RPD kontrolü gerçekten okunmalı ve görevde kullanılmalıdır. Temporary required-read testi bütün otomatik loader veya hostile izolasyon testi değildir. RPD'yi sadece kaynak dosyasına koyup yeni konuşmanın kendiliğinden uygulayacağını varsayma.

**F03 — Canlı yazıcı:** Gerçek kod/test kapsamını child'a vermeden önce, task-created geçici alanda canlı writer ve ilk kısmi etki bağımsız gözlenir; sonra interruption/stop ve file/index/HEAD/process uzlaştırması yapılır. Başlamadan kesilme veya doğal bitiş sonrası interrupt bu özelliği geçirmez. İkinci yazıcı ancak duruş/etki açık olduğunda açılır. Testin ömrü sınırlı, cleanup'ı yalnız kendi kaynaklarına özgü olur; genel kill/reset veya izin değişikliği yok. Zorunlu verifier için native kapasite korunur; gerektiğinde seri çalışılır.

PLAN K01–K12'nin güvence amaçları korunur. Mevcut 12 kontrolün aynılığı şartı bu açık grant'taki RPD01 ekini dışlamaz; eski 12 satır ve 12 dosya korunur, yeni 13. rota ayrıca sınanır. Pilot adı ve önceden seçilmiş araçlara bağlı literal testler, aşağıdaki iç uyarlamada aynı güvenceyi koruyacak exact hedefe bağlanır. Bu bir kalite eşiği düşürme değildir; eski test/sonuç statüsü korunur.

## 7. RPD davranışının ek kabul kapsamı

Aşağıdaki altı aile, K testlerinin üzerine ayrı bir tören kurmak zorunda değildir; ortak fixture ve kanıt paylaşabilir. Yalnız kayıt biçimi, protokol söylemi, Python testleri veya kaynak listesinden PASS çıkarılamaz. Ayrı-start değerlendirici expected cevapları üreticiye öğretmeden sabitler; görevde eksik bırakılan koşul erişilebilir kaynak/ortamdan keşfedilebilir olmalıdır.

| ID | Davranış / olumlu ve olumsuz sınama |
|---|---|
| RP1 — Her hedefte fiilî giriş | Kısa sıradan hedefte ve yeni child görevinde RPD01 uygulanır; basit düzenleme için gereksiz graph/dosya/servis üretilmez. Eksik/kesilmiş/yanlış kontrol durumunda ilgili eylem durur. “RPD yap” diye özel ikinci insan prompt'u olmadan kısa girişte çalışır. |
| RP2 — Söylenmemiş önkoşul | Yeni bounded bir geliştirme hedefinde kullanıcı eksik işi adlandırmaz. Ajan kaynak/ortamdan kritik alt ihtiyacı keşfeder, neden gerekli olduğunu kurar ve gerekirse onun alt koşuluna veya bilgi edinme eylemine iner. Sadece hazır checklist'i tekrar etmek, araç adına atlamak veya owner kararını uydurmak FAIL. |
| RP3 — Koşullu ağ ve kapasite | VE/VEYA, yönteme özgü şart, gerçekten ortak ihtiyaç, aynı adlı farklı sürüm ve tek kaynağın iki bağdaşmaz tahsisi sınanır. Bir alt yolun bitmesi parent'ın gerçekleşmesi değildir. Geçersiz cycle ile sürümlü iteration ayrı. |
| RP4 — İleri sınama ve değişim | Eylemin çıktısı üst ihtiyacı karşılamadığında yöntemi veya eksik ihtiyaç tanımını düzeltir; yalnız bağımlı sonuçlar yeniden değerlendirilir. Aynı eksik öncülü paylaşan iki uyumlu yol tamamlanma/kanıt sayılmaz. Önceden seçilmiş ilk pilot gerektiğinde gerekçeli değişebilir. |
| RP5 — Bitmemiş keşfin gerçek devri | Ana ve child görevleri henüz açık bir soru/alternatif/alt sonuç beklerken kalıcı checkpoint verir. Üretici sohbeti olmayan desteklenen fresh native bağlam, odak, bilinmeyen, sıradaki işlem ve parent'a dönüşü recover edip bir anlamlı sonraki işi yapar. Girdi değişmişse ilgili kısmı yeniden açar; bütün projeyi sıfırlamaz. Sadece Python Store yeniden açmak veya özeti tekrarlamak PASS değil. |
| RP6 — Hazır olma, kabul ve yarar | Bütün işler WAITING/STALE iken, frontier boşken veya bütçe bitince hedef bitmiş sayılmaz. Seçilmiş gerçek DevOS pilotunda keşif → bounded native üretim → farklı yöntemli değerlendirme → gerçek etki/readback → kalıcı devam görülür. Sonraki iş, yeni ihtiyaçtan türetilir; kullanıcı gizli eksik-bulucu/tester olmaz. |

RP2 ve RP4/RP5 en az bir sınama görevinde ara ihtiyaç listesini baştan üreticiye vermeden gözlenecek. Örnek ERP/masa anlatısını ezberletmek yerine DevOS'ye ait farklı bir bounded iş veya güvenli transfer örneği kullanılacak. Karşılaştırılan iki ajanın aynı model, kaynak veya çerçeveyi paylaşması kaydedilecek; ileri/geri uyum bağımsız doğruluk olasılığına çevrilmeyecek.

Bu testler yerel uygulanabilirliği sınar. RPD'nin standart planlamadan bilimsel olarak üstün olduğu iddia edilecekse aynı model/araç/toplam bütçeyle ayrıca karşılaştırma gerekir; bu iddiayı kurulumun gereksiz önkoşulu yapma. Sıfır hata veya tüm bilinmeyen önkoşulların keşfedildiği garantisi verilmez.

## 8. Tek dış mesajdan sonraki iç yürütme sırası

1. **Gerçek başlangıç:** Kendi AGENTS/STATE'in, actual local/remote, yazıcı/kapasite ve bu mesajın yetkisini geri kazan. Üç ham kaynağı tam oku, hash'leri bağla, ZIP'i pasif inceleme verisi tut. Eksik gerekli kaynak için kendi meşru erişim yollarını dene; yerine hafızadan içerik koyma.
2. **İç RPD uyarlaması:** Mevcut kernel WORK içinde hedef/need/method/frontier ve ilk eylem bağı kur. Eski PLAN'ı bu yeni davranışa göre değerlendir. Hangi mekanizma korunacak, değişecek veya gereksiz kalacak; hangi kayıt nerede yaşayacak, hangi test hangi iddiayı sınayacak? Somut delta ve izinli exact yolları sabitle. Tam geleceği tasarlamadan güvenli başlangıç zeminini bul. Ayrı-start eleştiriyle amaç, RPD semantiği, uygulanabilirlik ve yetkiyi sınat; bulguları içeride karşıla. Yeni browser plan turu bekleme.
3. **Sınırlı RPD kontrolü:** Dar AGENTS eki ve tek RPD protokolünü kur, tekrar oku, yeni gate ve fiilî native giriş/itiraz/keşif davranışını sınat. Proposed config veya ham source aktif kontrol yerine geçmez.
4. **Güvenli işletime alma:** Child'a gerçek geliştirme yazıcılığı vermeden F03'ü geç. RPD'nin gerekli gösterdiği ilk anlamlı geliştirme işini mevcut izinli zeminle üret; child kendi çözümünü ve testini yapsın. Gerçek çıktı, bağımsız expected negative/holdout, integration ve publisher readback'i tamamla.
5. **Teknik yeterlik ve devam:** K01–K12 + RP1–RP6 güvence kapsamını actual evidence ile kapat. `RPD-KERNEL-OPERABLE` yalnız gösterilmiş native yol/ortam için teknik statüdür, SOUL/ürün veya hostile izolasyon kabulü değildir. Bu durumda aynı işin tekrarı yerine sıradaki yetkili DevOS ihtiyacını kabul edip sürdür. Sonraki işler de RPD ve mevcut kontrolle yürür.

İlk kurulum ve iç repair için eski PLAN §4'ün en fazla dört aktif aktör/root dahil, bir çakışan alanda tek yazıcı, varsayılan fiziksel derinlik bir, ilk girişim + aynı failure sınıfı için en fazla iki kanıtlı repair gibi sınırları tavan olarak koru; bunları hedef sayma. Yirmi dakikalık çalışma dilimi gibi operasyonel eşikler semantik tamamlanma değildir. Mandatory okumayı sayısal kaynak kotası için kesme. Yeni kanıt olmadan attempt etiketini değiştirip bütçeyi sıfırlama. Mevcut koşul/dilimde güvenli devam yoksa honest checkpoint; zaman sınırı PASS üretmez.

## 9. Kullanıcının benimsemesine sunulan yeni exact yetki

**Grant kimliği:** `DEVOS02-RPD-IMPLEMENT-AND-CONTINUE-v2`.

Batu bu sözleşmeyi benimseyerek ilettiğinde şunları yetkilendirmiş olur:

- Mevcut private `soul-development-os_02/main` üzerinde yukarıdaki iç tasarım uyarlaması, RPD davranış entegrasyonu, bounded commissioning, test, iç repair ve kaynak/iş/context/kanıt/koordinasyon alanlarında normal Development OS devamı. Eski v1 mesajı ayrıca verilmiş varsayılmaz.
- **Kontrol kapsamı yalnız bu entegrasyon için:** `AGENTS.md` içindeki dar RPD01 bağlantısı/gösterim uyumu ve `devos-agent/protocols/reasoning/prerequisite-discovery.md`. Mevcut 12 protokol ve 12 soru değişmez. Çekirdek semantic şartları gevşetmeyen bu RPD entegrasyonunun iç onarımı dahildir; sonraki maddi kontrol/authority/kabul genişlemesi yeniden owner kararıdır.
- **Çalışma kayıtları:** `STATE.md`; `work/devos-kernel/{WORK.md,EVIDENCE.md}`; sonraki gerçek bounded işler için `work/<devos-id>/{WORK.md,EVIDENCE.md}`. Gerekli attempt-private checkpoint, öneri ve azaltılmış kanıt için aynı işin `runs/<attempt-id>/**` alanı. Her işte exact dosyalar ve writer kapsamı yazmadan önce belirlenir. Bu alanlar gizli config, key, executable hook veya ikinci talimat router'ı barındırma yetkisi değildir.
- **Ham kaynak koruma:** Yalnız üç sağlanan ekin exact/pasif kopyası ve source manifesti `work/devos-kernel/references/` altında tutulabilir. Kaynak ZIP'i aktif proje köküne açılmaz; incelenen dosyaları çalışma talimatı veya çalıştırılabilir kurulum sayılmaz. Bu kopyalar kaynağın aynısıdır, yeni kabul otoritesi değil.
- **Geliştirme kapsamı:** Önceki planın `tools/devos_*.py` ve `tests/test_devos_*.py` alanlarında stdlib/mevcut araçlarla gerçek ihtiyaçtan türetilen küçük yerel araçlar ve testler. İlk iki isim artık zorunlu değildir. Yeni dependency/servis gerektirmeyen geçici sentetik fixture ve cleanup dahildir. Gereken daha geniş DevOS mimarisi/kod alanı keşfedilebilir ve somut owner kararına sunulur; dar araç grant'ı bütün gelecekteki Development OS mimarisine dönüşmez.
- Bu izinli dosyaların mevcut private `origin/main` hedefine normal commit/push ve exact remote readback'i. Remote/head farkında kapsam dışı veya diğer yazıcının işini ezme; normal platform onayları korunur. Commit, yayın ve davranış doğrulaması ayrı sonuçtur.

**Dahil olmayanlar:** Diğer mevcut protokolleri değiştirmek, `.codex/**`/global ayarlar/hook kurulumu, servis/scheduler, kalıcı izin/credential/hesap değişimi, yeni sağlayıcı veya özel veri aktarımı, dependency kurulumu, başka repo/dal, PR/merge/tag/force, SOUL ürün kodu/production/release/kabul, maddi ürün amacı/scope/risk/bütçe değişimi. Tekrar ihtiyaç bulunması bunları yetkilendirmez. Owner'a teknik çalışma yöntemi tasarlatmak yerine gereken somut karar, gerekçe ve seçenek sunulur.

Mevcut native yol gerekli davranışı gösteremiyorsa bunu sessizce daha zayıf kabul etme. Önce bu kapsamda düzeltebilen bağlama/kayıt/iş bölümünü sınat. Gerçekten yasak ek kabiliyet gerektiriyorsa yalnız ona bağlı işi durdur ve doğrudan Batu'ya bounded karar götür; Research'ü yeniden günlük koordinasyon merkezi yapma.

Kullanıcı durdurması her zaman geçerli; gözetimsiz yeniden başlama yetkisi yok. Kullanıcıya son durumda değişen dosyalar, actual test/kanıt ve başarısızlıklar, exact commit/readback, kalan sınır ve sıradaki yetkili ihtiyaç bildirilir. Normal sonraki kısa giriş: **“STATE'deki yetkili Development OS işine devam et.”** Kalıcı grant ve kaynaklar repository'den bulunur; her seferinde RPD prompt'u yapıştırmak gerekmez.

## 10. Kaynak ve araştırma-side kapanış

Kavramsal dayanak: ham RPD §§3–11,14–21,24–26; süreklilik önerisi §§3–16,20–22; ZIP CORE/PROTOTYPE_LIMITS ve incelenen referans/test kodu. Mimari önerinin bütün maddeleri kabul edilmiş gereksinim değildir; özellikle ayrı store/lease/hook/yürütücü seçimi bu hedefin gerçek ihtiyacından türetilir.

Repository dayanağı: exact PLAN/EVIDENCE; Work audit §§2,4–7,11; dört ground'ın current STATE ayrımları; Composite Standing ve Control sentezleri; gstack multi-agent; CMH cross-layer §§11–13; ilgili candidate study metadata/statüleri. Foundation/studies ve Research agent-control dosyaları bu değerlendirmeyle değiştirilmez.

8 Eylül 2026 resmi web kontrolü: Codex [AGENTS](https://developers.openai.com/codex/guides/agents-md/), [Subagents](https://developers.openai.com/codex/subagents/), [Hooks](https://learn.chatgpt.com/docs/hooks). Belge, katmanlı keşif/boyut sınırı ve farklı başlangıç/araç yolları bulunduğunu destekler; bu local host'un aynı yolu işlettiğini kanıtlamaz. SubagentStart bağlam eklemesi tek başına start engeli değildir. Hook/rol dosyası zorunlu başlangıç olarak seçilmedi; gerçek kabiliyet kanıtlanmadan API/flag ithal edilmez.

Bu tur Research tarafından hedefe yazılmadı, kontrol kurulmadı ve Codex çalıştırılmadı. Review'un yeni sürümü ve güncel devir kaydı Research'te saklanır. Yerel sentetik testler yalnız aktarılan prototipin kayıt mekaniği içindir. Önceki uygulama mesajı gönderilmediği için eski onaya dayanılarak başlamış iş varsayılmayacaktır.
