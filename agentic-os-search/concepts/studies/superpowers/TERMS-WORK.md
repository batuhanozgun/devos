# Superpowers — Plan, çalışma alanı, görevlendirme ve inceleme

2026-09-19, **B6-T6 / U02-U03-KAYNAK-KAYDI-TAMAM / PAKET-KISMİ**. [TERMS.md](TERMS.md)'nin bağlı parçasıdır; genel terim araştırması veya yeni Superpowers değerlendirmesi değildir. Güncel kapsam ve devam [READING.md](READING.md)'dedir. Önceki giriş kayıtları [TERMS-ENTRY.md](TERMS-ENTRY.md) ile birlikte korunur.

## 1. Kaynak, aktarım ve açıklama sınırı

Araştırma deposu: `batuhanozgun/agentic-os-search`; sabit kaynak/P2 ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**; paket tree **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**. B6-T6 başlangıç main'i **4b8c87486cebf0b80cac5dba39699e72e09ccc2f**. Araştırmanın dış hedefi ayrı kimliktir: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest bağlamı 6.3.0. Bu tur dış hedefin güncel dosyaları, host sözleşmeleri veya model davranışı araştırılmadı.

| Kod | Sabit araştırma kaynağı | Rol |
|---|---|---|
| N02 | [U02-approval-plan-workspace-handoff.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U02-approval-plan-workspace-handoff.md) | Onay, plan, çalışma alanı ve görev bağlamı; §1–11 tam okundu. |
| N03 | [U03-delegation-review-and-acceptance.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U03-delegation-review-and-acceptance.md) | Rol, inceleme, düzeltme ve nitelendirilmiş kabul; §1–11 tam okundu. |
| L0 | [SOURCE-LEDGER.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER.md) | Önceki tur tam okunan kayıt; S28–S36/E05–E06 bağları bu tur kullanıldı. |
| L03 | [SOURCE-LEDGER-U03.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U03.md) | S37–S43/E07–E08, ayrı Git belge atıfları ve yürütme sınırları; tam okundu. |
| E05-R/O | [U02 betiği](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U02-handoff-probes.py) / [sonucu](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U02-handoff-probes-results.json) | Araştırmacının betiği ve geçmiş sentetik gözlemi; ikisi tam okundu, çalıştırılmadı. |
| E07-R/O | [U03 betiği](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U03-review-probes.py) / [sonucu](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/evidence/U03-review-probes-results.json) | Aynı ayrım; gerçek reviewer/model çıktısı veya bu tur yapılmış deney değil. |
| S03 | [S03-intent-planning-and-context-handoff.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/syntheses/S03-intent-planning-and-context-handoff.md) | Bağımlı araştırma sentezi; §1–7 tam okundu. U05/U07/U08 kaynaklı ek bağlar sonraki gruplarla ayrıca kapanacak. |

P2-T1/T2/T5'in görünür SP kayıtları ve düzeltmeleri kaynaklarla karşılaştırıldı. Türkçe açıklamalar kaynak bağlantılı parafrazdır. **Ürüne atfedilen talimat**, **araştırmanın kod/gözlem aktarımı**, **araştırmacının yorum veya ölçütü** ve **yeni kapsam açıklaması** birbirinin yerine kullanılmaz. Kaynakta OBSERVATION bulunması, dış kodu bu tur okumuş/çalıştırmış olduğumuz anlamına gelmez. SP kimlikleri kullanım adresidir; ayrı kavram veya bağımsız kanıt sayacı değildir.

Kullanıcı okuma anındaki anlam seçimlerini denetleyemediğinden önemli yorum/dayanak/belirsizlik görünürdür. Ortak sözcükler ortak anlamı garanti etmez; kullanıcı onayı, kaynak kullanımı ve çıkarıcının yorumu teknik doğruluk yerine konmaz.

## 2. Onay, çalışma yolu ve planın gerekçesi

| Adres / ifade | Kaynağın bu bağlamdaki kullanımı | Kaynak rolü ve sınır |
|---|---|---|
| SP28.a — Giriş onayı | Spike önerisi, kısa bounded tasarım veya architectural tasarım/spec için ilgili aşamada istenen insan onayı. | N02 §2/§4; ENTRY/SP28'in devamı. Spike onayı kodu tutma veya sonraki uygulamaya otomatik izin değildir. |
| SP28.b — Execution approach choice | Planlamanın sonunda yürütme yaklaşımının seçilmesi. | N02 §2. Belirli plan özetine/digest'ine bağlı makinece denetlenen onay token'ı olarak tanımlanmıyor. |
| SP28.c — Worktree / main üzerinde çalışma onayı | Yeni çalışma kopyası oluşturma tercihiyle main/master üzerinde uygulama izni farklı kararlar. | N02 §5; S03 §5. Yeni worktree'yi reddetmek diğer izni otomatik vermez. |
| SP30 — Subagent-driven development / SDD | Yazılı planın controller, uygulayıcı ve inceleme rolleriyle yürütüldüğü özel prosedür. | N02 §2–4; N03 §2–6. Bütün Superpowers isteklerinin veya bütün paralel çalışmanın genel adı değil. |
| U02-U01 — executing-plans | Kaygıları başlangıçta bildirip engel/belirsizlik/tekrarlı doğrulama sorunu halinde durmayı söyleyen alternatif plan yürütme skill'i. | N02 §2, L0/S31. Alt aktör olanağı varsa SDD'ye yönlendirme de var; iki rota tek yetki sözleşmesi yapılmaz. Checkpoint sözü sabit batch büyüklüğü veya her batch sonunda zorunlu insan kontrolü tanımlamıyor. |
| SP39 — Spec / specification | SDD'de planın gerekçelendiği bağlayıcı gereksinim/tasarım belgesi. | N02 §2–4; S03 §2. Planla aynı nesne değil. Spec yolu, spec'in değişmez sürüm kimliği değildir. |
| SP40 — Implementation plan | Spec bağlantısı, ortak kısıtlar, dosyalar, arayüzler, görevler, testler ve uygulama adımlarıyla yürütmeyi hazırlayan belge. | N02 §3–4; S03 §2. Biçimce dolu plan, doğru/güncel gereksinim garantisi değil. |
| SP41 — Global Constraints | Görevler boyunca korunması istenen proje çapındaki gereksinimler. | N02 §3/§7. Plan başlığında bulunması görev brief'ine otomatik taşınması değil. |
| SP42.a/b — Consumes / produces interfaces | .a görevin dayandığı girdi/arayüz; .b diğer işlere sunduğu çıktı/arayüz. | N02 §3; S03 §2. Görevler arası bağlar, yalnız dosya listesi değil. |
| SP43.a/b — Task / step | .a kendi test ve anlamlı inceleme sınırı olan teslim edilebilir iş; .b bunun içindeki uygulama adımı. | N02 §3. İki–beş dakika örneği step'e aittir; bütün task'lar için süre kotası değildir. |
| SP44.a — Ruling | Controller'ın spec'e dayanarak verdiği karar; karar, gerekçe ve yanlışsa maliyeti kaydedilir. | N02 §2/§3; N03 §4–5. Atanmış karar rolü doğru hüküm garantisi değildir. |
| SP44.b — Provisional ruling | Spec yokken/erişilemiyorken bunun not edilmesiyle geçici statü taşıyan hüküm. | N02 §3. Plan dosyasının yokluğunu mekanik reddetmeyle aynı davranış değil. |

**Dört durma sınıfı korunur:** N02 §2 ve S03 §4, SDD için yıkıcı/geri alınamaz işlemleri, güvenlik açısından hassas eylemleri, normalde onay gerektiren dış etkileri ve tahminsiz ilerleme yolu bırakmayan bozuk planı sayar. CORE/CLOSURE-AUDIT LC2'nin kısa sürüm anlatımına ilişkin düzeltmesi bu tam kapsamla taşınır. Yalnız geri alınamaz işte durma diye kısaltılmaz. Bunlar incelenen ürünün talimatlarıdır, mevcut assistant için yeni kontrol değildir.

N02 §3'te spec kapsamı, placeholder ve tip tutarlılığı kontrolü plan yazarının öz incelemesidir. SDD girişinde her görev ve ortak dosya/arayüz paylaşan çiftler için ledger satırı istenmesi de farklı bir kayıt yükümlülüğüdür. Salt clean hükmü bu kayıtların yerine konmaz. Kaynak bunları bağımsız teknik doğrulama olarak kanıtlamaz.

## 3. Çalışma alanı, görev bağlamı ve kanıt taşıyıcıları

| Adres / ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| SP45 — Git worktree | Seçilmiş Git çalışma kopyası; mevcut olanı kullanma, host aracı/Git ile oluşturma veya yerinde çalışma seçenekleri var. | N02 §4–5. Ayrı HEAD/index bağlamı güvenlik sandbox'ı veya ayrı aktör yetkisi değildir; Git bilgisi kaynağın tarihli belge atfıdır. |
| SP46 — SDD scratch workspace | Çalışma kopyası kökü ve plan basename'i üzerinden oluşturulan geçici brief/rapor/kayıt dizini. | N02 §4/§6. Worktree'nin kendisi değil; plan basename'i tam yol veya sürüm kimliği değildir. |
| SP47 — Progress ledger | Plan yolu, görev tamamlanma durumu, düzeltme turu, commit ve kararların devam için kaydı. | N02 §6; N03 §5. Kayıt yorumlanır; helper tamamlanmayı veya plan değişiminden sonra hükmün geçerliliğini doğrulamıyor. |
| SP48 — Task brief | İstenen görev başlığı ve gövdesini taşıyan dosya. | N02 §7; S03 §3. task-brief betiğiyle üretilen bölüm, bütün gerekli görevlendirme bağlamının otomatik karşılığı değil. |
| SP49 — Implementer report | Yapılan iş, test/komut/çıktı, sorun ve düzeltme girişimlerini taşıyan, yeni girişimlerle genişletilebilen rapor. | N03 §2/§5. Raporun korunması inceleme sonucunun güncelliğini veya kabulü göstermiyor. |
| SP50 — Review package | Verilen commit uçları arasındaki commit listesi, dosya istatistiği ve net farkı taşıyan inceleme paketi. | N03 §7; L03/S34. Gerçek görev başlangıcını helper keşfetmez; rapordaki testle bu aralığın kimlik bağını kendisi doğrulamaz. |
| SP51.a — BASE | Görevlendirme öncesi kaydedilen inceleme başlangıcı. | N03 §7. Geçerli herhangi bir commit, doğru görev başlangıcı değildir. Genel HEAD~1 örneği SDD'nin çok-commitli görev kuralını ikame etmez. |
| SP51.b — HEAD | İncelenen durumun son commit ucu. | N03 §7. Çalışma kopyasındaki kaydedilmemiş değişikliklerin tamamını temsil ettiği varsayılmaz. |
| SP51.c — FIX_BASE | Bir önceki incelemenin gördüğü HEAD; düzeltme paketinin başlangıcı. | N03 §7. Yeni bütün-sistem incelemesiyle aynı kapsam değil. |
| SP167 — Artifact materialization | Uygun plan/spec içeriğinin işi yapacak aktörün çalışma alanında gerçekten erişilebilir olması. | N02 §8; S03 §5. Başka checkout'ta kaydetmek, yeni worktree'ye gelmiş olmak değildir. |

**U02'nin kaynakla sınırlı gözlemleri:** E05-R/O'nun on üç vakasında plan yokluğu exit 2, görev yokluğu exit 3 ile reddediliyor; farklı basename'ler farklı scratch üretiyor; seçili görev ve fenced örnek korunup komşu görev dışarıda kalıyor. Öte yandan aynı basename'li iki farklı yol aynı scratch'e düşüp ilk brief'in üstüne yazabiliyor. Aynı yoldaki plan değişince sentetik completion satırı korunabiliyor. Bunlar helper kimliği/sunum sınırlarıdır; canlı controller'ın yanlış görevi kabul ettiği gözlenmiş değildir.

**Kalıcılık ile aktarım:** Kayıtlı eşleştirilmiş örnekte yalnız kaydedilmiş plan yeni HEAD worktree'sinde yok, commit edilmiş plan ise var. Bu, her planın mutlaka commit edilmesini burada evrensel koşul yapmaz: mevcut worktree'yi kullanma, kopyalama veya açık erişilebilir yol da araştırmanın saydığı olası yollardır. Gereken şey uygun içeriğin gerçek tüketiciye ulaşmasıdır (N02 §8).

**Test temizliği ile dosya temizliği:** clean baseline, başlangıç testlerinin durumudur; unrelated tracked/untracked değişikliklerin bulunmadığına eşdeğer değildir (N02 §5). N02 §9/E05'in diğer örneğinde seçilen .worktrees yok sayılmamışken alternatif worktrees yolunun ignored olması birleşik OR kontrolünü başarılı yapabiliyor. Both/neither kontrolleriyle beraber tutulur. Bu yeni olay teşhisi veya gerçek kullanıcı dosyasının yanlış commit edildiği iddiası değil; seçilen nesne ile kontrolün sınadığı nesneyi ayıran tarihsel örnektir.

## 4. Roller, inceleme kapsamı ve belirsizliği sonuçlandırma

| Adres / ifade | Kaynağın anlattığı rol/durum | Dayanak / sınır |
|---|---|---|
| SP31 — Controller | Spec/plan, ortak kısıt ve arayüz seçimi; brief/rapor yolu, BASE, kararlar, kapsam açıkları, bulgular ve sonraki iş aktarımı. | N02 §2–7; N03 §2–5; S03 §3. Yalnız sıraya koyan dispatcher değil. Bağlam sağlama, reviewer sonucunu önceden yönlendirme yetkisi değildir. |
| SP32.a — Implementer | Brief, verilen bağlam, çalışma dizini ve rapor sözleşmesiyle uygulama/test/rapor yapan rol. | N03 §2. Öz incelemesi dış görev incelemesini ikame etmez. |
| SP32.b/c — DONE / DONE_WITH_CONCERNS | .b incelemeyi başlatan bitirme beyanı; .c kaygıyı sınıflandırıp işlemeyi gerektiren dönüş. | N03 §4. İkisi de tek başına kabul edilmiş görev değildir. |
| SP32.d/e — BLOCKED / NEEDS_CONTEXT | Engel veya bağlam ihtiyacı; ek bilgi, farklı kapasite, bölme ya da kaydedilmiş plan düzeltmesi gibi değişmiş karşılık istenir. | N03 §4. Aynı koşulla tekrar deneme, engeli gidermenin yerine konmaz. |
| SP33.a — Task reviewer | Bir kez farkı okuyup gereksinime uyum ve kalite için iki hüküm veren tek görev inceleyicisi. | N03 §2/S37. İki ölçüt, iki okuma aşaması ve iki bağımsız aktör aynı şey değil. |
| SP33.b/c — Spec verdict / quality verdict | .b gereksinime uyum; .c kod kalitesi hakkında ayrı hükümler. | N03 §2–3. Aynı brief, seçilmiş globals ve rapor ortak bağımlılıklardır; iki hüküm bağımsız test yeniden koşusu değildir. |
| SP33.d — Read-only review | Checkout, index, HEAD ve dal durumunu değiştirmeme talimatı. | N03 §3/S37/S41. Şablonun bunu yazması teknik izin sınırı kurulduğunu kanıtlamaz. |
| SP52 — Cannot verify from diff | Gereksinimin eldeki farktan doğrulanamaması. | N03 §3. Gereksinimin karşılanmadığı veya önemsiz olduğu kararı değil; kapanıştan önce ayrıca ele alınır. |
| SP53 — Coverage resolution | Diff dışındaki gereksinimi controller'ın daha geniş bağlamla sonuçlandırması. | N03 §3/S30. Doğrulanmış açık düzeltmeye gider; yerel olumlu hüküm bütün gereksinim kapsamını otomatik kapatmaz. |
| SP54.a/b/c — Critical / Important / Minor | Bulguların nasıl işleneceğini etkileyen önem sınıfları. | N03 §4. Critical/Important düzeltmeye, Minor ledger üzerinden sonraya taşımaya bağlanır; evrensel severity standardı kurulmaz. |
| SP168.a/b — Diff-first / focused source recovery | .a incelemeye farktan başlama; .b kesik işlev veya belirli çapraz risk için ilgili kaynağa dönme. | N03 §3. Bütün sistemi yeniden okuma değil; olmayan diff için Git fallback'i ayrıca var. |
| SP169a — Context isolation | Görevli aktörlerin çalışma bağlamlarını ayırma. | N03 §3/§6. Aynı eksik brief ortak kör nokta kalabilir. |
| SP169b — Shared-state independence | İşlerin ortak durum veya sıralı bağımlılık taşımaması bakımından ayrılması. | N03 §6. Ayrı context, ortak dosya/araç yalıtımı veya kilit mekanizması değildir. |

Kaynak, implementer raporunu ve gerekçelerini doğrulanmamış iddia olarak incelemeyi, beklenen bulguyu bastırmamayı ve olumlu severity'yi önceden atamamayı ister. Bunlar yararlı talimatlardır; gerçekleşmiş bağımsızlık deneyi değildir. Mevcut iyi test kanıtını kullanmak verimli olabilir; tekrar koşmak da yanlış oracle'ı kendiliğinden düzeltmez. Bu grubun kanıt tekrar kullanımı açıklaması, U04'ün test kronolojisi/geçerlilik/güncellik incelemesini yapılmış göstermez.

## 5. Düzeltme, açık bulgu ve tamamlanma

| Adres / ifade | Yerel anlam | Dayanak / sınır |
|---|---|---|
| SP55 — Fix round | Bulguyu düzeltme, kapsayan test/komut/çıktı sunma ve yeniden inceleme turu. | N03 §4. Düzeltme denemesi, bulgunun giderildiği sonucu değildir. |
| SP56.a — Scoped re-review | Eski bulgular ve fix diff'teki yeni bozulmayı sınayan dar inceleme. | N03 §2/§4. Kapsam dışı başka gözlemler ayrı tutulur; yeni bütün sistem incelemesi değil. |
| SP56.b/c — ADDRESSED / NOT ADDRESSED | Önceki her bulgunun giderilme durumuna ilişkin hüküm. | N03 §2/§4, S38. Girişim veya rapor beyanıyla eşitlenmez. |
| SP57 — Deferred finding | Minor bulgunun ledger'a alınıp sonraki incelemeye taşınması. | N03 §4. Yanlış veya yok sayılmış bulgu demek değil. |
| SP58 — Parked finding | Tartışmalı veya ilerlemede belirleyici olmadığına hükmedilen bulgunun gerekçeli ruling ile açık bırakılması. | N03 §4. Salt tur sınırına varmak bulgunun yanlışlığına kanıt üretmez. |
| SP59 — Unblocking decision | İlerlemeyi engelleyen gerçek sorun karşısında devamı mümkün kılacak açık kararın verilmesi ve ileri taşınması. | N03 §4. Maddi kusuru sessizce görünmez yapmak değildir. |
| SP34 — Qualified completion | Clean review veya kayıtlı parked bulgularla iş akışında tamamlanma kararı. | N03 §4. Bütün kusurların giderilmesi, herkesin uzlaşması veya entegrasyon kabulüyle eşit değil. |
| SP60 — Final whole-branch review | Bütün görevlerden sonra dal/entegrasyon/mimari kapsamına ve deferred/parked kayıtlara bakan inceleme. | N03 §2/§4. Kendisi merge yapmaz veya insanın bitiş seçiminin yerine geçmez. |
| SP61.a — Parallel dispatch | Bağımsız problem alanlarına odaklı eşzamanlı görevlendirme. | N03 §6/S39. Bağımsızlık yalnız farklı görev numarasıyla kurulmaz; sonrasında çakışma kontrolü/entegrasyon testleri istenir. |
| SP61.b — Batching | Küçük, aynı biçimli işleri tek görevlendirmede toplama. | N03 §6/S30. Eşzamanlı uygulayıcı çalıştırmakla aynı düzen değil. |

N03 §4'te 1–3. düzeltme turları normalde aynı uygulayıcıyla; 4–5 yeni ve daha kapasiteli uygulayıcıyla anlatılır. Host resume sağlayamıyorsa rapor üzerinden yeni çalışan kullanılabilir. Beş-tur sınırı doğruluğu kanıtlamaz; tekrar düzeltmeden açık hükme geçiştir. Son bütün-dal incelemesindeki bir düzeltme dalgası ve bir dar yeniden inceleme, görev turlarının aynısı değildir. Kalan maddi bulguların insana ulaşması istenir; bunun fiilî teslim/koruma boyutu U05'te ayrıca aktarılacak.

**Alt aktör kuralı rota sınırında kalır:** SDD uygulayıcı/reviewer şablonları yeni alt aktör açmayı yasaklar. CORE/CLOSURE-AUDIT LC1'in kaynak kontrolü, bağımsız parallel-dispatch skill'inde aynı açık yasağın bulunmadığını belirtir. Bütün Superpowers veya bütün hostlar için zorunlu terminal-agent topolojisi çıkarılmaz. Gerçek paralellik/çatışma oranı ölçülmedi.

## 6. İnceleme paketi ve araştırmanın sınama dili

E07-R/O'nun dokuz vakası ve N03 §7–10 birlikte okundu. Dört olumlu helper kontrolü; iki aralık/çalışma durumu gözlemi; bir dar dosya-kapsam negatif kontrolü ve iki başarısız sözlü-oracle uyum ölçütü ayrı kaldı. Yedi PASS, iki oracle-health FAIL; yeni koşumuz veya genel başarı oranı değil.

**Aralık nesnesi:** Kaydedilmiş görev-öncesi BASE iki değişikliği getiriyor; ilk uygulama commit'ini BASE vermek geçerli ama daha dar paket üretiyor. Önceki incelenmiş HEAD'den fix paketi yalnız düzeltmeyi içeriyor. Eksik plan/çözülemeyen BASE reddediliyor. Bu sonuçlar helper'ın verilen aralığı işlemesiyle aralığın gerçek görevi kapsamasını ayırır; geçerli dar aralığı kabul etmesi tek başına helper kusuru değildir.

**U03-U01 — Committed diff / working-copy state:** Aynı sabit commit uçlarında üretilen paket, tracked/staged/untracked değişikliklerden sonra aynı kalıyor ve yardımcı bu çalışma durumunu koruyor. İncelenen commit farkı ile testin çalıştığı dosya durumu bu nedenle farklı nesneler olabilir. Canlı reviewer'ın eski kanıtı kabul ettiği gözlenmiş değil. Commit listesi/erişilebilirlik ile uçlar arasındaki net fark ayrımı L03'ün tarihli Git belge atıflarıdır; bu tur Git davranışı için yeni dış araştırma yapılmadı.

| Adres / ifade | Araştırmadaki kullanım | Sınır |
|---|---|---|
| SP170a — Description / keyword test | Yöntemin tarifini veya belli ifadeleri tanıma/hatırlama sınaması. | N03 §8/S42. Kaynak kendisini davranışsal drill testi olarak sunmuyor. |
| SP170b — Behavioral drill | Gerçek davranışı sınamaya dönük ayrı senaryo yolu olarak anılıyor. | N03 §8/L03. Bu kayıtta senaryonun adı, koşulmuş veya geçilmiş deney değildir. |
| U03-U02 — Verbal-oracle alignment | Bir metin eşleşme koşulunun anlattığı güncel aktarım biçimini ayırt etmesi. | N03 §8; E07-R/O, literal case-insensitive grep ve iki sentetik yanıt. Yeni bir genel oracle tanımı değil. |

Literal koşul, oluşturulmuş kısa by-file yanıtını reddedip doğrudan prompt'a yapıştırmayı anlatan yanıtı kabul ediyor. Bunlar model çıktısı değil. Daha uzun doğru yanıt ilgili kelimeleri içerse kabul edilebilir; bütün doğru yanıtların reddedildiği, upstream CI'ın kırmızı olduğu veya bütün değerlendirmelerin bozuk olduğu sonucuna gidilmez. Yanıt dosyası yerine prompt'a yapıştırma ölçütüyle güncel dosya aktarımının uyuşması ayrı değerlendirme konusudur.

SP35–38'in fixture/criterion/observed/result ayrımları korunur. Bu iki betikte `kind` alanı mechanism, representation/identity/handoff/scope observation, health challenge ve negative-control rollerini ayırır. `result`, `exit`, `same_workspace`, `completion_marker_preserved`, `packet_unchanged`, `accepted` gibi alanlar yalnız belirtilen nesne/koşula aittir; bir PASS bütün sistemi nitelemez. Sentineller, örnek plan adları ve geçici dizinler bağımsız kavram değil, testin ayırdığı durumu taşıyan değerlerdir.

## 7. Açık bileşimler ve kaynak-içi ilişki görünümü

**Açık sınırlar:** Q13 yeniden kapsam/onay ile SDD ruling'i; Q20 reviewer/genel talimattaki insan kararı ile özel controller kararı; Q14 değişmiş planla eski tamamlanma; Q18 raporlanmış test/ortam/kod kimliği; Q22 re-review'a ortak kısıt aktarımı. Kaynaklar her birleşimi çözen genel bir mekanizma vermiyor. Q24'ün yeni test/mevcut kanıt tarafı U04'te ayrıca ele alınacak. Bu sorular yeni deney, ürün düzeltmesi veya genel kavram araştırması yükümlülüğü değildir.

N03 §9'daki genel incelemede unfixed Important ile devam etmeme ve SDD'nin parked completion yolu, kaynakta nitelendirilmiş özel/genel birleşim sınırıdır. Aynı şekilde genel final-review şablonunun alanları, SDD'nin istediği ledger ve hazırlanmış paket girdilerini otomatik taşımıyor; controller bunları birleştirir. Makul açıklama, uygulanmış evrensel öncelik kuralı olarak kaydedilmez.

**İlişki:** uygun çalışma anlaşması → spec/plan ve ortak kısıtlar → kullanılabilir çalışma alanı/brief → uygulayıcı raporu → yerel inceleme ve kapsamın tamamlanması → düzeltme veya gerekçeli açık-bulgu kararı → nitelendirilmiş görev kabulü. Bu özellikle planlı SDD yolunun araştırma görünümüdür; her istek için zorunlu tek hat veya otomatik durum makinesi değildir. Sonraki insan entegrasyonu/gerçek teslim ve korunan kanıt U05 grubunda devam eder.

**S03-U01 — Process weight / coordination:** S03 §6 daha az hazırlık artefaktı, daha az insan kesintisi, daha küçük controller bağlamı, daha düşük toplam maliyet ve daha iyi teslimin farklı amaçlar olduğunu anlatır. Issue #2203'ün kullanıcı anlatımı ve host-policy açıklaması atıf statüsünde kalır; transcript/bağımsız performans kanıtı olarak kullanılmaz. Ayrı U08-A kaynak kaydı bu sentezdeki kamu raporunun sonraki kapsam kontrolüne dahildir. S03'ün U07 görsel/dağıtım bağlantılarını veya S05/S06'ya yönlendirmelerini bu parça tamamlamaz.

## 8. Aktarım ve durma sınırı

SP30–SP61'in görünür P2-T2 açıklamaları N02/N03 ile karşılaştırıldı; P2-T1'in erken rol görünümü tek başına kopyalanmadı. SP28 yeni aşama/izin bağlamlarıyla ayrıldı; P2-T5'in SP167–SP170, SDD'ye özgü no-child ve dört durma sınıfı dahil edildi. SP171–SP174 U04/U05'e aittir ve bu grubun kaydıyla tamamlanmış sayılmaz. Yeni U02/U03/S03 adresleri, kaynakta bulunan ek kullanımları adresler; yeni evrensel kavram ilan etmez.

Maddi koruma: spec/plan ile yol/sürüm ayrımı; task/step; worktree/scratch; brief ile yeterli context; rapor ile kabul; tek reviewer/iki hüküm; okunamayan kanıt ile gerçek yokluk; dar diff ile bütün görev; düzeltme turu ile giderilmiş bulgu; deferred/parked ve nitelendirilmiş complete; bağlam ayrımı ile ortak kaynak bağımsızlığı. Mevcut ENTRY/SP23–24'ün giriş katmanı sınırı, artık somut ledger/rapor mekanizmalarıyla bağlandı; önceki açıklama no-recovery iddiasına çevrilmedi.

N02 §1–11, N03 §1–11, ilgili L0/L03 kaynak listeleri ve iki betik/sonuç çiftinden kullanım hesabı yapıldı. S03 tam okundu fakat başka gruba dayanan kullanımlar kendi kaynaklarına bağlanarak açık bırakıldı. Kayıtlı deneyler yeniden çalıştırılmadı; kaynak talimatları benimsenmedi. Bu aynı assistant'ın kaynak/pilot karşılaştırmasıdır, bağımsız doğrulama veya sıfır atlama garantisi değildir. Sonraki iş U04'ün test/teşhis/doğrulama ve U05'in teslim/koruma aktarımıdır; bu grubu genel planlama/inceleme araştırmasıyla uzatmak değildir.
