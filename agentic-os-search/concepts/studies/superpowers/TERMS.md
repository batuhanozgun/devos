# Superpowers — Bağlamlı kullanım kayıtları

2026-09-20, **B6-T10 / KALICI-AKTARIM-TAMAM / PACKAGE-COMPLETE**. Giriş, plan/görevlendirme/inceleme, test/doğrulama/teslim, skill yazımı/değerlendirme, görsel yardımcı/dağıtım ve bütünsel/proje-karşılaştırmalı sentez grupları kayıtlıdır. **[TERMS-ENTRY.md](TERMS-ENTRY.md), [TERMS-WORK.md](TERMS-WORK.md), [TERMS-VERIFICATION-DELIVERY.md](TERMS-VERIFICATION-DELIVERY.md), [TERMS-EVOLUTION-EVALUATION.md](TERMS-EVOLUTION-EVALUATION.md), [TERMS-RUNTIME-DISTRIBUTION.md](TERMS-RUNTIME-DISTRIBUTION.md) ve [TERMS-SYSTEM-PROJECTION.md](TERMS-SYSTEM-PROJECTION.md) bu dosyayla birlikte tam okunur.** Gerçek 52 dosyalık kapsam ve kapanış [READING.md](READING.md)'dedir. Yöntem [v0.3-working](../../METHOD.md); global kapsam [S1](../../SCOPE.md); güncel çalışma yetkisi [concepts/STATE.md](../../STATE.md).

Bu dosya araştırmanın terimleri ne için kullandığını kaydeder. Terimin genel doğrusu, güncel ürün rehberi, kurulmuş sistem, benimsenmiş mimari veya bütün araştırmaların ortak sözlüğü değildir. CMH'nin kapanmış çıkarımı yeniden açılmadı; onun şeması bu pakete dayatılmadı. ENTRY/WORK/VERIFICATION-DELIVERY/EVOLUTION-EVALUATION içindeki önceki next ifadeleri tarihsel checkpoint'lerdir. Güncel karşılıklar §4/§11 ve bağlı parçalardadır; eski kullanım gövdeleri sırf tarihsel durum cümlelerini silmek için yeniden yazılmadı. ENTRY/SP02 ve SP04'ün yazım ayrıntıları EVOLUTION-EVALUATION §2'de, U07'ye bırakılan erişim/dağıtım ayrımları yeni RUNTIME-DISTRIBUTION parçasındadır.

## 1. Kaynak ve aktarım kimlikleri

- Araştırma repository'si: **batuhanozgun/agentic-os-search**.
- Sabit kaynak/pilot ref'i: **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**.
- Kaynak yolu: **research/studies/superpowers/**.
- Paket tree: **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**; 19 kök dosya, 11 mekanizma notu, 6 sentez ve 16 betik/sonuç dosyası = 52.
- B6-T5 başlangıç main'i **1108a483a811c3d5e22595f99179e51da8479f16**, kök → research → studies ağaçlarından aynı paket kimliğiyle doğrulanmıştı. B6-T6 başlangıcı **4b8c87486cebf0b80cac5dba39699e72e09ccc2f**; B6-T7 başlangıcı **1bdd7066bff2eadcddc0237c926f7f1daef1f376**; B6-T8 başlangıcı **66e98e215cbeac398e6dfa7b710ef016eca9ce88**; B6-T9 başlangıcı **5229f57b304ed246bbdb471f5091827c68123f01**. Önceki concepts kapanışlarıyla karşılaştırmalarda Superpowers kaynakları değişmedi; ECC/katalog ve yeni study yollarının farkları ayrı tutulur.
- Araştırmanın incelediği dış ürün: **obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797**, manifest bağlamı 6.3.0. Bu araştırma ref'iyle aynı kimlik değildir.
- Araştırmadaki ayrı lab **prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b**; tarihsel assessor **prime-radiant-inc/gauntlet@db6c8e0fcf80889aa6d9631c99adec698f6c0caa** ve ayrı **25a2e3e00431f8d8eb63781162ccb974d43d5405** deltası. Bu kaynak kimlikleri her raporun gerçek runtime'ı veya son kullanıcı kurulumunun zorunlu bileşenleri değildir. Bu tur dış kaynak doğrulaması yapılmadı.

Kaynak araştırmanın kendi durumu **BOUNDED-COMPLETE / USER-EVALUATED / ACCEPTED**. Bu, P2 concepts pilotunun kapanmasıyla veya bu kalıcı aktarımın tamamlanmasıyla aynı durum değildir. Kaynak not/sentez/CORE içindeki eski ACTIVE/PARTIAL/pending sözleri araştırmanın üretim anına aittir; güncel kaynak STATE bunları açıklamaktadır.

## 2. Açıklama ve kimlik anahtarı

Türkçe karşılıklar kaynak bağlantılı parafrazdır. Kaynak içinde ürün talimatı, kod gözleminin anlatımı, araştırmacının yerel deneyi, kamuya açık rapor, sentez ve proje yorumu birlikte bulunabilir. Söyleyen kaynak/rol ile ifadenin tanım, talimat, gözlem veya yorum oluşu ayrı belirtilir. Bir atfı okumak, atfedilen dış dosyayı bu tur okumuş olmak değildir.

SP01–SP179 görünür P2-T1–T5 pilot kayıtlarının adresleridir; bağımsız kavram sayısı değildir. Seçili parçalarda pilot kimlikleri korunur; farklı kullanım/nesne varsa alt adres verilir. Aynı satırdaki karşılaştırma eş anlamlılık kabulü değildir. Henüz aktarılmayan kimlikler yok sayılmaz veya hafızadan tanımlanmaz. P2'nin görünür metni bu turlarda erişilebilirdi; yalnız durum özetinden kayıt uydurulmadı. Bağlı dosyalardaki U02/U03/U04/U05/U06/U07/S03 ek adresleri ilgili kaynakta bulunan yerel kullanımları taşır; yeni evrensel terim tanımı değildir.

İki neden çalışma boyunca görünür tutulur: kullanıcı okuma anındaki anlam seçimlerini denetleyemediği için önemli dayanak/yorum/belirsizlik/değişiklik izlenebilir olmalı; aynı sözcük ortak anlamı garanti etmediği için kullanıcı onayı, kaynak kullanımı ve çıkarıcı yorumu teknik doğruluk yerine konmamalı.

## 3. Genel görünüm ve araştırmanın kendi dili

Bu bölümün kaynakları aşağıdaki sabit araştırma dosyalarıdır:

[CORE](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/CORE.md), [METHOD](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/METHOD.md), [META](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/META.md), [STATE](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/STATE.md), [INDEX](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/INDEX.md), [PLAN](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/PLAN.md), [CLOSURE-AUDIT](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/CLOSURE-AUDIT.md). Hepsi B6-T5'te tam geri okunmuştu; atıf verdikleri bütün mekanizmalar bununla tamamlanmış sayılmadı.

| Pilot adresi / ifade | Araştırmadaki kullanım | Kaynak rolü ve sınır |
|---|---|---|
| SP01 — Superpowers | Skill/rol sözleşmeleriyle ifade edilen, host aktörleri ve araçlarınca yorumlanan, adapter'lar, dosya/Git yardımcıları ve isteğe bağlı görsel runtime ile desteklenen geliştirme yöntemi; yöntemin geliştirilmesi/değerlendirilmesi/dağıtılması ayrı süreç. | CORE §1/§6 ve META. Araştırmacının bütün açıklaması; ne yalnız prompt listesi ne kendi başına eksiksiz otonom runtime. Yeni genel agent tanımı değil. |
| SP177a — Semantic synthesis pyramid | Kaynak ve mekanizma okumalarından alt sistem/sistem açıklamasına ve yoğun CORE'a ilerleyen araştırma/yazım düzeni. | Kaynak METHOD giriş ve §3–4. Ürün bileşeni veya concepts'in yeni yöntemi değil. |
| SP177b — Evidence graph | Aynı kaynağın birden çok mekanizma ve senteze bağlanabildiği, kimlik ve sınırlamaları taşıyan kanıt ilişkisi. | Kaynak METHOD §4. Okuma hiyerarşisiyle aynı tür yapı değil; sentez tekrarı bağımsız destek olmaz. |
| SP177c — CORE | Alt araştırmayı kasıtlı olarak yoğunlaştıran kısa sonuç belgesi. | CORE giriş; METHOD §3.F. Kayıplı üst görünüm, alt kaynakların yerine geçmez. |
| SP178a — external-target | Araştırma nesnesinin belirli bir dış yapı olduğunu gösteren study sınıfı. | Kaynak META. Superpowers'ın kendi mimari modülü veya ürün kategorisi değil. |
| SP178b — BOUNDED-COMPLETE | Belirlenen kaynak ve açıklama sorusu için araştırmanın kapanış durumu. | Kaynak STATE; CLOSURE-AUDIT §1/§8. Bütün tarih/host davranışı veya ürün etkinliği doğrulanmış değil. |
| SP178c — USER-EVALUATED / ACCEPTED | Kullanıcının sınırlı araştırma teslimini ve amacına hizmetini değerlendirmiş/kabul etmiş olması. | Kaynak STATE, owner evaluation bölümü. Her kaynağın insan tarafından okunması, yeniden deney veya ürünün benimsenmesi iddiası değil. |

**Diğer yönetim/kanıt dili:** Kaynak METHOD §5'in target claim, instruction contract, implementation observation, local execution observation, host/model behavior, effectiveness ayrımı bu çıkarımda ürün terimleriyle karıştırılmaz. SOURCE-LEDGER'ın S/E kimlikleri dış kaynak/deney kayıtları; notlardaki F/Q kimlikleri araştırma bulgusu/sorusu; CLOSURE-AUDIT'teki LC1/LC2 final kaynak kontrolü açıklıklarıdır. SP kullanım adreslerinin yerine geçmezler.

CLOSURE-AUDIT §3–4 ve CORE §3/§7'nin route-specific alt aktör kuralı ve dört durma sınıfı WORK'te U02/U03 kaynaklarıyla korunmuştu. Koşullu cleanup sınırı U05 kaynaklarıyla TERMS-VERIFICATION-DELIVERY §7'ye bağlıdır. Güncel kapanışın eski notlardan daha sonra gelmesi, eski yerel deneyin başka sürümde yeniden çalıştırıldığı anlamına gelmez.

## 4. Kalıcı gruplar ve açık aktarım

| Grup | Güncel durum / adresler |
|---|---|
| Giriş, skill seçimi, host aktarımı | [TERMS-ENTRY.md](TERMS-ENTRY.md): SP02–SP29, SP35–SP38, SP12a/b, SP161–SP166. B6-T5 kaydı; kullanım gövdesi korunuyor. |
| Plan, çalışma alanı, görevlendirme ve inceleme | [TERMS-WORK.md](TERMS-WORK.md): SP30–SP34, SP39–SP61, SP167–SP170; SP28'in yeni aşama bağları ve yerel ekler. B6-T6 kaydı korunuyor. |
| Test, teşhis, doğrulama ve teslim/koruma | [TERMS-VERIFICATION-DELIVERY.md](TERMS-VERIFICATION-DELIVERY.md): SP62–SP79, SP171–SP174 ve yerel ekler. B6-T7 kaydı korunuyor. |
| Skill yazımı, değerlendirme ve kabul | [TERMS-EVOLUTION-EVALUATION.md](TERMS-EVOLUTION-EVALUATION.md): SP80–SP121/SP179; SP02/SP04 yazım bağları ve U06 ekleri. B6-T8 kaydı korunuyor. |
| Görsel yardımcı ve dağıtım | [TERMS-RUNTIME-DISTRIBUTION.md](TERMS-RUNTIME-DISTRIBUTION.md): SP122–SP149/SP175–SP176, SP28.visual ve U07 ekleri. İki not, iki kaynak kaydı ve dört betik/sonuç B6-T9'da karşılaştırıldı. |
| Araştırmanın bütün/kanıt dili | Bu dosya: SP01 ve SP177a–c/SP178a–c. Kök belgelerin araştırma/kanıt statüsü burada korunur. |
| Bütünsel ve proje-karşılaştırmalı sentez | [TERMS-SYSTEM-PROJECTION.md](TERMS-SYSTEM-PROJECTION.md): tarihsel SP150–SP160 grubu kaynak-kontrollü regeneration ile U08-R01–R23 olarak karşılanır; exact legacy-row eşleşmesi iddia edilmez. S05/S06/U08-A/B/C B6-T10'da tam okundu. |

B6-T5'te 15, T6'da sekiz, T7'de dokuz, T8'de yedi, T9'da sekiz ve T10'da beş kaynak tam geri kazanıldı: **52/52**. Envanterde B6 geri kazanımı bekleyen dosya kalmadı. S05/S06/U08-A/B/C bütünsel/proje dilini ve kapanış provenance'ını tamamlar; onların başka studies/Foundation'a atıfları o korpusların concepts çıkarımı değildir. Tam okuma ve aynı-assistant kaynak kontrolü bağımsız doğrulama anlamına gelmez.

## 5. Kaynak-içi ilişki görünümü

Giriş modeli: **ortak yöntem içeriği → hosta özgü keşif/taşıma → görünür talimat → mevcut isteğe uygun çağırma → host araçlarıyla eylem → sonuç**. Her ok zorunlu ayrı bileşen, tek sıra veya mekanik garanti değildir. N01/N01B ve S02 farklı yolların aynı işlevi değişik biçimde taşıdığını anlatır.

Planlı SDD tarafı: **uygun anlaşma → spec/plan ve ortak kısıtlar → yürütmeye alınmış görev ve erişilebilir brief → uygulayıcı raporu → inceleme ve kapsamın sonuçlandırılması → düzeltme veya gerekçeli açık-bulgu kararı → nitelendirilmiş sonuç kabulü → insanın entegrasyon seçimi → gerçekleşen etki ve korunan kayıtlar**. Yürütmeye alınma ile sonucun kabulü farklıdır. U04/U05, test geçmişi/ayırt etme/uygulanabilirlik ile merge/yayın/temizlik/koruma ayrımlarını bu ilişkiye bağlar. Üç giriş yolu tek yazılı-plan/SDD hattına indirgenmez.

Prosedürün yeniden eklenmesi, etkin dosya sürümünün yenilenmesi ve işin kabul/plan/kanıt durumuyla geri kazanılması ayrı sorulardır. U02/U03 gerçek ledger, brief, rapor ve commit referanslarını anlatır. U05 bunların hangisinin hangi temizlikten sonra kaldığını ayırır. Bundan bütün devam sorunlarının çözüldüğü veya hiç kurtarma mekanizması bulunmadığı sonucu çıkarılmaz.

U06/S01, işte kullanılan yöntemin değiştirilmesini ayrıca açar: **gözlenen sorun → uygun müdahale/yazım → karşılaştırma ve hazırlanmış aktör → etkileşim/kanıt → rapor ve nihai sonuç → ayrıca insan/bakım sorumlusu kabulü ve dağıtım**. Yöntem geliştirme, değerlendirme ve kabul/dağıtım bağlantılı fakat ayrı süreçlerdir. Daha fazla raporun işlenebilmesi, yöntemin daha iyi iş üretmesiyle aynı sonuç değildir. Kaynaklar bunu her iş sonrası otomatik öğrenme veya tek atomik pipeline olarak göstermiyor.

U07/S02 dağıtım bağlantısını ayrıntılandırır: **kaynak/kanal → oluşturulmuş veya edinilmiş paket → kurulu içerik → host/modül/oturum etkinleşmesi → keşif/yükleme → kullanım**. Kaynak etiketi, assembly girdileri, artifact digest ve etkin prosedür kimliği farklıdır. Görsel kanal da erişim, tıklama, seçili durum ve insan kararını ayırarak planlama konuşmasını tamamlar; kendi başına onay motoru olmaz. Bu görünümler CMH'nin üçlü düzeninin dayatılması veya mimari kabulü değildir.

## 6. B6-T5 — Korunan aktarım kaydı

P2-T1 ve P2-T5'in görünür ilgili satırları kaynakla karşılaştırılmıştı. Bootstrap istisnası ve hook/event-registration ayrımı erken satıra taşındı. İki wrapper, mapping'in iş düzeni etkisi, cache/registration/session/message ömürleri, marker ile gerçek gövde, procedure re-entry/work recovery ve ölçüt-bağımlı PASS kayıt içinde görünürdür.

ENTRY §6'nın başlığındaki ilk pilot ifadesi o tur P2 pilotu diye düzeltilmişti; kullanım anlamı değişmedi. B6-T5'in 15 tam geri okuması [yerel checkpoint'te](https://github.com/batuhanozgun/agentic-os-search/blob/53cc0647266228e3f5446bbe69a6d55b573a19a4/concepts/studies/superpowers/READING.md) korunur. Eski U02-next ifadesi bugünkü sıranın yerine geçmez.

## 7. B6-T6 — Korunan aktarım kaydı

Görünür P2-T2 ile P2-T5'in kapanış ekleri N02/N03, kaynak kayıtları ve dört deney dosyası üzerinden karşılaştırıldı. SP28 aşama/nesneyle açıldı; task/step, worktree/scratch, brief/yeterli bağlam, rapor/kabul, tek reviewer/iki hüküm, deferred/parked/complete ve farklı inceleme uçları ayrı tutuldu. SDD alt aktör sınırı bütün paralel yollara genişletilmedi. Kaynaktaki dört durma sınıfı kısa sürüm anlatımıyla daraltılmadı.

SP167–SP170 kapanış ekleri ilgili yere dahil edildi. U02'nin plan adı/yolu/sürümü ve U03'ün commit farkı/çalışma kopyası gözlemleri eski kayıtla birlikte korundu. Geri çağırma güçlüğü gerçek kanıt yokluğuyla eşitlenmedi; gözlenen yardımcı davranışı gerçek model kararı gibi aktarılmadı. Maddi bir anlam tersine dönüşü saptanmadı; amaç/nesne ve koşul nitelemeleri daha ayrı adreslendi. [B6-T6 yerel checkpoint](https://github.com/batuhanozgun/agentic-os-search/blob/d34605f570906a674f53b9372f6cad7b66013f2c/concepts/studies/superpowers/READING.md) o turun kapsam hesabını korur.

## 8. B6-T7 — Korunan aktarım kaydı

SP62–SP79 ve SP171–SP174, P2-T2/P2-T5'in görünür açıklamalarıyla N04/N05/L04/L05 ve E09/E11 betik-sonuçlarına karşı kontrol edildi. Kaynaktaki şartlar korundu: mental mutation fiilî mutation motoru değil; gerekçeli süre beklemesi yasak değil; occurrence ile yeni belirli işlemin tamamlanması ayrı; source-string ile çalıştırılmış çıktının assertion'ı aynı değil; same-message ile reused-evidence bileşimi tamamen çözülmedi; cleanup koruması reddi tetikleyen koşullara bağlı.

Yeni parçanın yayın geri okumasında yürütmeye alınmış görev ile kabul edilmiş sonuç ayrımı netleştirildi ve WORK'te bulunmayan SP70 atfı gerçek WORK §4/SP33 → yeni SP70 bağlantısıyla düzeltildi. Bu ana ilişki görünümü de aynı ayrımı taşır. Kaynak dosyaları veya önceki kullanım gövdeleri değiştirilmedi. [B6-T7 yerel checkpoint](https://github.com/batuhanozgun/agentic-os-search/blob/f18fc9b53f6508f663139c1400d1cd08596c8685/concepts/studies/superpowers/READING.md) kaynak/bölüm hesabını korur; eski U06-next ifadesi güncel değildir.

## 9. B6-T8 — Korunan aktarım kaydı

P2-T3/P2-T5'in SP80–SP121/SP179 kayıtları, U06'nın üç notu/üç kaynak kaydı/S01 üzerinden kontrol edildi. SP02/SP04'ün yazım/keşif bağları eklendi. Ana ürün, ayrı lab, tarihsel assessor, source-only kontroller ve dış yazarların raporları aynı sistem veya aynı kanıt sınıfı yapılmadı.

Korunan önemli ayrımlar: müdahale/kurala ekleme; uyarıcı/beklenen/gözlenmiş sonuç; yönlendirmesiz/önceki sürüm karşılaştırması; bildirilen/hazırlanmış/gerçekten yüklenmiş içerik; completed conversation/nihai verdict; assertion failure/checker crash; satır/alan kapsamı ile anlam yeterliliği; rapor repair'i ile hüküm değişimi; sonuç yayını ile hüküm doğruluğu; reportEligible ile maliyet tamlığı; instrument ve behavioral improvement; katkı sürecine alınma/son kabul/release.

SP110'un sınırlı araç-dispatch mekanizması WORK/SP33.d'nin yalnız talimat düzeyindeki read-only yüzeyiyle birleştirilmedi. SP112'nin sağlayıcı-yolu/sürüm koşulu korundu. Bu, bütün read-only sistemler için yeni bir kategori kararı değil; kaynak bağlamlarının ayrılmasıdır. Olumlu kontroller ve raporlanmış karşı örnekler birlikte tutuldu. Genel etkinlik, hata oranı veya özel raporlarda yeni kök neden çıkarılmadı. [B6-T8 yerel checkpoint](https://github.com/batuhanozgun/agentic-os-search/blob/825d3195d09ef2ea7a1739c8809c698fe2c4e158/concepts/studies/superpowers/READING.md) yedi okuma ve U06 bölüm hesabını korur; eski U07-next cümlesi tarihsel kalır.

## 10. B6-T9 — Korunan aktarım kaydı

P2-T4/T5'in SP122–SP149/SP175–SP176 kayıtları U07-A/B, iki kaynak kaydı ve dört deney dosyasıyla karşılaştırıldı. SP28.visual; process marker/watchdog; session/project scope; event/selected state; source/channel/artifact/activation ve audit/check/mutation ayrımları yeni parçada kayıtlı. Kayıtlı client ve JSON-only deneyler yeniden çalıştırılmadı. Renderer'ın süreç yürütmediği, şablon varlığının rol çağrısı olmadığı ve kopya yazım rehberinin güncel vendor politikası sayılmadığı korundu.

Yeni koşul açıklıkları occupied-port/explicit-token, lexical tmp cleanup, default choice/value ve full-history/last-click ayrımlarıdır. Önceki ana kullanımı tersine çeviren bir fark saptanmadı. S02/S03 tam yeniden erişildi; S01/S04'ün mevcut gerçek metinleriyle U07 bağlantıları kontrol edildi. Sentezler bu nedenle yeni bağımsız destek veya yeni dosya sayısı yapılmadı.

**Bu T9 kaydı U07 kapanış checkpoint'idir.** S05/S06/U08 ve paket-geneli kapanış B6-T10'da tamamlanmıştır; buradaki eski next cümlesi güncel yetki değildir.


## 11. B6-T10 — Bütünsel aktarım ve paket kapanışı

S05/S06 ile SOURCE-LEDGER-U08A/B/C tam okundu. Bunların ürün-native mekanizma açıklamalarıyla araştırmacı sentez/proje-reuse dili birbirinden ayrıldı. S05'in native whole-system model, development-work loop, method-change loop, composition register, stage/action-dependent authority ve handoff qualification dili; S06'nın selected-task/pursuit coverage, common adequate-and-available view, side information, authority/capability ve adaptation dili [TERMS-SYSTEM-PROJECTION.md](TERMS-SYSTEM-PROJECTION.md)'de kaynak-kontrollü olarak kaydedildi.

Tarihsel P2 grubunun SP150–SP160 aralığı biliniyor fakat özgün satır metni durable repoda bulunmadı. METHOD §8 gereği eski kimliklere hafızadan birebir anlam atanmadı. U08-R01–R23 kaynak-regeneration adresleri oluşturuldu; exact legacy correspondence açıkça **unknown/not asserted** kaldı. Bu, pilot kapsamını yok saymak veya kaynakta bulunmayan anlam üretmek yerine kullanılan kontrollü fallback'tir.

Paket-geneli adres hesabı:
- SP01 ve araştırma/kanıt dili: bu ana dosya;
- SP02–29/SP35–38/SP161–166: ENTRY;
- SP30–34/SP39–61/SP167–170: WORK;
- SP62–79/SP171–174: VERIFICATION-DELIVERY;
- SP80–121/SP179: EVOLUTION-EVALUATION;
- SP122–149/SP175–176: RUNTIME-DISTRIBUTION;
- tarihsel SP150–160 grubu: SYSTEM-PROJECTION üzerinden kaynak-kontrollü regeneration.

Bu adresleme kavram sayısı veya ortak ontology değildir. Aynı terimin birden çok bağlamı alt adreslerle korunabilir.

Kaynak taraflı final kontrolde 52/52 package dosyasının okuma statüsü açıklanmış, bütün kaynak grupları kalıcı kayıtlara bağlanmış ve bu tur başlangıcında sabit Superpowers package tree'sinin current main ile değişmediği doğrulanmıştır. Önceki T5–T9 coverage tabloları, deney kayıtları ve düzeltmeler korunur. Somut açık aktarım eksiği bulunmadı. Kaynağın açık soruları, dış bağımlılıklarının kısmi okumaları ve ürün etkinliği sınırları belirsizlik olarak kalabilir; bunlar bu ilk-aşama çıkarımını sınırsız genel araştırmaya dönüştürmez.

Bu nedenle **Superpowers için B6 kalıcı bağlamlı kullanım çıkarımı kapanmıştır.** Kapanış, incelenen araştırma paketinin kullanım/ilişki aktarımı içindir; güncel upstream ürün sertifikası, bağımsız doğrulama, bütün AI terminolojisi için tanım veya Development OS/SOUL mimari kararı değildir. Sonradan somut atlama ya da anlam bozulması bulunursa ilgili kayıt yeniden açılabilir.
