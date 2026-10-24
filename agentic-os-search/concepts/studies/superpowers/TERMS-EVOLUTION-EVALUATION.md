# Superpowers — Skill yazımı, değerlendirme ve değişiklik kabulü

2026-09-20, **B6-T8 / U06-KAYNAK-KAYDI-TAMAM / PAKET-KISMİ**. [TERMS.md](TERMS.md)'nin bağlı parçasıdır. Önceki [ENTRY](TERMS-ENTRY.md), [WORK](TERMS-WORK.md) ve [VERIFICATION-DELIVERY](TERMS-VERIFICATION-DELIVERY.md) kayıtları korunur. Güncel kapsam ve devam [READING.md](READING.md)'dedir. Bu dosya genel değerlendirme kuramı, yeni ürün araştırması, model kampanyası veya ortak tanım değildir.

## 1. Kaynak kimlikleri ve açıklamanın statüsü

Araştırma deposu `batuhanozgun/agentic-os-search`; sabit araştırma/P2 ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**, paket tree **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**. Bu turun başlangıç main'i **66e98e215cbeac398e6dfa7b710ef016eca9ce88**. Önceki concepts kapanışıyla fark yalnız ECC dosyalarındaydı; araştırma ve mevcut concepts kaynakları değişmedi.

| Kod | Sabit araştırma kaynağı | Rol |
|---|---|---|
| A | [U06A-skill-authoring-and-change-admission.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U06A-skill-authoring-and-change-admission.md) | Yazım, davranış ölçütleri ve katkının kabul sürecine alınması; §1–10 tam okundu. |
| LA | [SOURCE-LEDGER-U06A.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U06A.md) | S58–S69, D01–D03 ve tarihli X07 atfının kimlik/okuma sınırları; tam okundu. |
| B1 | [U06B1-evaluation-evidence-and-verdict.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U06B1-evaluation-evidence-and-verdict.md) | Senaryo/karşılaştırma, etkileşim, kanıt ve nihai hüküm; §1–10 tam okundu. |
| LB1 | [SOURCE-LEDGER-U06B1.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U06B1.md) | D02 tamamlama ve D04–D27; dış kaynakların kısmi/tam statüleri korunur; tam okundu. |
| B2 | [U06B2-assessor-contracts-and-evidence-qualification.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/notes/U06B2-assessor-contracts-and-evidence-qualification.md) | Rapor üreticisi, kabul, yayın, kullanım hesabı ve geçmiş raporlar; §1–10 tam okundu. |
| LB2 | [SOURCE-LEDGER-U06B2.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/SOURCE-LEDGER-U06B2.md) | D28–D37, G01–G09 ve S70; tarih/sürüm/kanıt sınırlamaları; tam okundu. |
| S01 | [S01-skill-evolution-and-evaluation.md](https://github.com/batuhanozgun/agentic-os-search/blob/75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847/research/studies/superpowers/syntheses/S01-skill-evolution-and-evaluation.md) | Aynı kaynakların bağımlı sentezi; giriş ve §1–7 tam okundu, ayrı bağımsız destek değildir. |

Bu yedi araştırma dosyasının okunması, atfedilen bütün dış kodların veya özel deney kayıtlarının bu tur okunması değildir. Dış ana hedef **obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797** (manifest bağlamı 6.3.0); ayrı lab **prime-radiant-inc/superpowers-evals@e64684cd1fa270c464ac797747e45bbe8d127e8b**; araştırmanın incelediği tarihsel assessor **prime-radiant-inc/gauntlet@db6c8e0fcf80889aa6d9631c99adec698f6c0caa**. `25a2e3e00431f8d8eb63781162ccb974d43d5405` ayrı delta kaydıdır; daha sonraki raporlarda anılan sürümler bu kaynak pinlerinin yerine geçmez.

Türkçe açıklamalar kaynak bağlantılı parafrazdır. Ana ürüne atfedilen talimat, lab/assessor kodunun araştırmadaki anlatımı, dış yazarın geçmiş deney raporu, araştırmacı sentezi ve yeni çıkarım açıklaması ayrı tutulur. SP kimlikleri görünür P2-T3/P2-T5 adresleridir; kavram sayacı değildir. Aynı satırdaki ayrı ifadeler eş anlamlı ilan edilmez. Yeni U06-* adresleri yalnız bu kaynaktaki ek kullanımları adresler.

Kullanıcı okuma anındaki anlam seçimlerini denetleyemediğinden önemli yorum/dayanak/belirsizlik görünürdür. Ortak sözcükler ortak anlamı garanti etmez; kullanıcı onayı, kaynak kullanımı ve çıkarıcının yorumu teknik doğruluk yerine konmaz. Hiçbir ürün/model/deney çalıştırılmadı; kaynak talimatları etkin kontrol yapılmadı.

## 2. Skill'in yazılması ve müdahale biçimleri

| Adres / özgün ifade | Bu araştırmadaki kullanım | Kaynak rolü ve sınır |
|---|---|---|
| SP02 — Skill, yazım bağlamı | Yeniden kullanılabilir teknik, örüntü veya başvuru içeriği; gelecekteki aktörün çalışma biçimine müdahale. | A §2; S01 §1. ENTRY/SP02'ye ek bağlam: tek başarılı oturumun hikâyesiyle veya model ağırlıklarındaki kapasiteyle eşitlenmez. |
| SP04 — Skill description, yazım bağlamı | Skill'in ne zaman yüklenmesi gerektiğini belirten keşif açıklaması; prosedürün gövdesini ikame etmemesi istenir. | A §3/S58. Hosta gerçekten sunulması ve gövdenin çağrılması ENTRY'nin ayrı sorularıdır. Yerel trigger-only tercihi evrensel biçim standardı yapılmaz. |
| SP80 — Skill authoring / writing-skills | Yeniden kullanılabilir yönlendirmeyi yazma/değiştirme faaliyeti ve bunu anlatan özel skill. | A §2–5. Dosyanın yazılması davranış etkisinin gösterilmesi değildir. |
| SP81 — Intervention layer | Müdahalenin skill, proje talimatı, çalıştırılabilir kontrol veya ayrı plugin içinde yapılmasını ayıran araştırma açıklaması. | A §2. Kaynağın seçim düzeni, benimsenmiş SOUL taksonomisi değil. |
| SP82.a/b/c — Prohibition / rationalization counter / red flags | .a açık yasak; .b kuralı atlama gerekçesine karşı açıklama; .c uyarı işaretleri. | A §4. Bilinen kuralın baskıyla atlanmasına yönelik biçimler; her çıktı kusuru daha fazla yasak gerektirmez. |
| SP83 — Positive recipe | İstenen çıktının parçalarını ve sırasını olumlu biçimde tarif etme. | A §4. Çıktı biçimlendirmesi için anlatılır; genel doğruluk veya fayda garantisi değil. |
| SP84 — Required field / slot | Tekrarlı unutulan unsur için şablonda zorunlu alan. | A §4. Alanın dolması değerinin doğru veya yeterli olması değildir. |
| SP85 — Conditional rule / observable predicate | Davranışı gözlenebilir koşula bağlayan kural ve o koşulu ayırt eden önerme. | A §4. İlgili durum ve nesneye doğru bağlanması ayrıca gerekir. |
| SP86 — Micro-test | Yeni bağlamlarda gerçekçi çevre talimatları, yönlendirmesiz koşul, tekrarlı varyantlar ve işaretlenmiş eşleşmelerin elle kontrolüyle dar yazım sınaması. | A §5. En az beş tekrar yerel sezgisel kuraldır; istatistiksel garanti veya tam pressure testinin yerine geçen kanıt değildir. |
| SP87 — Academic test | Skill'in anlaşılması/hatırlanması için soru ve alıntı istemleri. | A §5–6. Sorular uyarıcıdır; verilmiş cevap veya gözlenmiş davranış değil. |
| SP88 — Pressure test / pressure scenario | Zaman, geçmiş emek, sosyal etki veya otorite baskısı altında seçim/gerekçelerin sınanması. | A §5–6/S59. Senaryo, gerçek kullanıcı durumu veya başarılı sınama sonucu değildir. |
| SP89 — Meta-testing | Başarısız seçim sonrası, ifadenin nasıl değiştirileceğine ilişkin aktör geri bildirimi. | A §5. Yazım hipotezi sağlar; bağımsız neden teşhisi veya kuralın meşruluğu kanıtı değildir. |

**U06-A01.a/b/c — Biçim şartı / vendor recommendation / local method preference:** A §3 ve LA/X07, tarihli dış biçim belgesi, kopyalanmış sağlayıcı tavsiyesi ve yerel trigger-only tercihini ayırır. Bir alanın uzunluk şartıyla bütün frontmatter hakkında yazılmış cümle aynı koşul yapılmaz; örnek adın yazımı otomatik standart uygunluğu sayılmaz. Bu tur güncel standardı veya vendor politikasını doğrulamadık; kaynak atfını ve kendi nitelemesini taşıdık.

**U06-A02.a/b/c — Scenario stimulus / expected outcome / historical reported outcome:** A §6'nın akademik/baskı dosyaları uyarıcı; worked variant belgesi planlanmış karşılaştırma ve beklenen sonuç; CREATION-LOG ise 2025-10-03 tarihli yazar anlatısıdır. Bunlar tamamlanmış sayısal sonuç kümesi veya bu pin'de yeniden koşu sayılmaz. A/S64'te dört senaryo/NULL/dört varyant bulunması kazanan gözlendi demek değildir.

Skill description içindeki bir/two reviews anekdotu güncel tek görev reviewer'ı/iki hüküm düzenini değiştirmez. Güncel dosya eski olayı örnekleyebilir. A §4'teki ikna/psikoloji oranları ve yazım karşılaştırmaları dayanak koşuları geri kazanılmamış yazar iddialarıdır; burada etkinlik oranına dönüştürülmedi. Kullanıcı yararı sınırı, mevcut assistant için sahte otorite veya kanıt üretme izni değildir.

Disiplin-belgesindeki reference test etmeme ifadesi, başka belgede reference retrieval/application testleri istenmesini otomatik yasaklamaz; kapsamlar ayrı kaydedilir. Aynı senaryolara göre tekrar yazım meşru geliştirme kanıtıdır, bağımsız genelleme değil. Kontrol koşulu sorunu göstermiyorsa o görünmeyen soruna yönlendirme yazmama talimatı da korunur (A §5).

## 3. Karşılaştırma koşulları ve aktörler

| Adres / ifade | Yerel karşılık | Dayanak ve sınır |
|---|---|---|
| SP90 — No-guidance control / NULL control | Yönlendirme bulunmayan karşılaştırma koşulu; yönlendirmenin katkısını sorgular. | A §2/§5–6. Önceki iyi sürüme üstünlükle aynı soru değil. |
| SP91 — Before/after / prior-version comparison | Mevcut skill'in önceki ve değiştirilmiş sürümlerinin karşılaştırılması. | A §2; S01 §1. Model/görev/bağlam/araç/ölçüt değişimi yalnız yazım etkisine yüklenmez. |
| SP92 — Arm / stock–treatment | Seçili senaryonun karşılaştırılan yapılandırılmış koşulları; aynı bildirilen ayarlar içinde primary pin veya açık none. | B1 §2/D10/D15–17. YAML eşleşmesi gerçekleşmiş deney eşdeğerliği değildir. |
| SP93.a/b/c — Explicit none / explicit root / unspecified | .a yöntem kullanılmaması; .b belirli kaynağın kullanımı; .c eski/çevreden devralınabilen yol. | B1 §2. Belirtmemek açık none değildir; projected environment ve staging/flag davranışları bu ayrımı taşır. |
| SP94.a/b — Scenario / suite | .a görev, hazırlık ve değerlendirme bağlamı; .b senaryo/karşılaştırma/tekrar düzeni. | B1 §1–3. Seçili suite'deki iki tekrar tanımı, iki gözlenmiş koşu değildir. |
| SP95.a/b — User brief / private rubric | .a etkileşime verilen görev metni; .b sonraki değerlendirmeye verilen ölçütler. | B1 §4. Metnin projeksiyonla ayrılması bütün dosya/host erişiminin yalıtılması değildir. |
| SP96 — Subject | Görevi yapması ve çıktı üretmesi değerlendirilen aktör. | B1 §3–4. Assessor ile aynı mantıksal rol değil. |
| SP97.a/b — User-like interlocutor / converse | .a kullanıcı benzeri etkileşimi yürüten rol; .b bu rolün çağrıldığı işlem. | B1 §4. Gerçek insanın onayı veya bağımsız oracle olarak kaydedilmez. |
| SP98.a/b — Assessor / assess | .a kanıt ve rubric üzerinden sonradan değerlendiren rol; .b değerlendirme çağrısı. | B1 §4; B2 §3. İki evaluator rolü aynı ayarlı modeli kullanabilir; rol/çağrı ayrımı bağımsız model sayısı değildir. |

**Kaynak sistemleri ayrıdır:** Ana katkı belgesi Drill, ayrı lab README'si Quorum adını kullanır (A §8/LA). Salt ad farkından kesin yeniden adlandırma/bozukluk çıkarmadık. B1 §2, seçili treatment'ın primary b36e0829'a açıkça bağlı olduğunu gösteren yapılandırmayı anlatır; A'nın ilk kısmi README sınırı tarihsel kalır. B2 §2/LB2 ise belirli rapor için tarihsel Gauntlet kimliğini çözer. Bütün raporlar aynı Evals/Gauntlet sürümünde çalışmış değildir.

**Sonuç odaklı seçili örnek:** conversation-code-review, önemli kusurları ve sonuçlarını kanıta bağlı anlatan teslim edilmiş inceleme ister; belirli skill, araç, alt aktör veya runtime testini zorunlu kılmaz. Koşullu risk veya eksik bağlamı sorgulama uygun olabilir; desteklenmeyen ilave iddia olumsuz değerlendirilebilir. Sırf ret etkileşimi bitirebilir, ama görevi karşılamaz (B1 §3). Ana yazımın seçim/uyum sınamalarını bütün lab'ın amacı yapmayız.

Bu senaryodaki deterministik oracle yalnız belirli dosyanın hash ile korunmasını sınar; inceleme bulgularının doğruluğunu veya bütün workspace'in değişmezliğini değerlendirmez. Model/credential selector'ları kaynak yapılandırma adlarıdır; güncel ürün bulunabilirliği veya yeni erişim kurulumu iddiası değildir.

## 4. Etkileşim, kanıt ve nihai hüküm

| Adres / ifade | Araştırmadaki kullanım | Dayanak ve sınır |
|---|---|---|
| SP99 — Visible endpoint / completed conversation | Görünür teslim veya ret ile etkileşimin sonunun kaydı. | B1 §5. Teslimin doğru olduğu veya değerlendirmeden geçtiği anlamına gelmez. |
| SP100.a/b/c — Capture / native logs / normalized trajectory | .a etkileşim kaydı; .b ortamın kendi günlükleri; .c normalleştirilmiş eylem/gözlem dizisi. | B1 §5. Hepsi aynı veya kayıpsız temsil kabul edilmez; bütün normalizer'lar kaynak araştırmada incelenmiş değil. |
| SP101 — Output snapshot / evidence/output | Çalışma dosyalarından kurallarla seçilip alınan çıktı kopyası. | B1 §5. Git/dependency ağaçları dışarıda; belirli symlink kopyalama/yol koşulları var. Aktörün görebildiği her şeyin birebir kopyası değil. |
| SP102 — Evidence index | Saklanmış kanıt yollarının indeksi. | B1 §5; B2 §3. İndekslenen küme, bütün gerekli bilginin toplandığını kanıtlamaz. |
| SP103.a/b/c — Precondition / pre-check / post-check | .a uygunluk koşulu; .b etkileşim öncesi; .c etkileşim sonrası kontrol. | B1 §3/§5–7. Seçili post-check kopyada çalışır; her checker'a karşı değişmez snapshot garantisi kurulmaz. |
| SP104 — Expected-check manifest | Beklenen aşama, ad, negation, argüman ve çokluk kayıtlarını karşılaştıran kontrol listesi. | B1 §6. Multiset karşılaştırması var; null/wildcard argüman ve isteğe bağlı eski manifest yolu kapsamı sınırlar. Script'ten türetilen beklenti bağımsız oracle doğruluğu değildir. |
| SP105.a/b — Assertion failure / checker crash | .a koşulun karşılanmaması; .b kontrol aracının başlayamaması veya çalışamaması. | B1 §6. Negatif iş sonucu ile ölçüm arızası ayrı kayıtlardır. |
| SP106 — Verdict composition / composer | Assessor, kontrol ve yürütme kayıtlarını nihai sonuca bağlayan mekanizma. | B1 §7–8. Alan tutarlılığı, her hükmün anlamca doğru olduğunu yeniden değerlendirmez. |
| SP107.a/b/c — Pass / fail / indeterminate | .a ölçütlere göre olumlu; .b belirli olumsuz değerlendirme; .c nihai hükmün kurulamaması. | B1 §7. Hata/eksiklik öncelikleriyle iş başarısızlığı ve ölçüm süreci arızası ayrılır; negatif ham kayıtlar kaybolmaz. |

B1'in somut geçişleri: geçerli capture/rendered kayıt ve içinde gerçekten bulunan alıntı kontrol edilir; sonra native kayıtlar ve seçili çıktı korunur, post-check ve assessor sonucu birleştirilir. Alıntının bulunması yanıtın yeterli veya doğru olduğunu kanıtlamaz. Buna karşılık kayıtların gerçekten alınması salt subject beyanına güvenmekle eşitlenmez.

**U06-B01 — Assessment attempt / report admission / final eligibility:** Bazı post-check hataları veya manifest uyuşmazlığı sonrasında assessor yine çağrılabilir; hata nihai sonucu indeterminate tutar. Rehberdeki daha genel değerlendirme yapılmama cümlesiyle kod yolu arasındaki fark korunur (B1 §8). Denenmiş değerlendirme, oluşmuş rapor ve nihai hükmün kullanılabilirliği aynı olay değildir; kaynak bozuk kontrollerin pass'e çevrildiğini söylemiyor.

Manifest bulunmayan eski yol ve deterministik post-check olmadan assessor pass'inin kullanılabildiği yol açık kapsam seçimleridir. Sıfır kontrol her zaman hata yapılmaz; sıfırdan bağımsız kontrol güvencesi de çıkarılmaz. Kaynakların ham görünür çıktı/kopya/önkoşul ayrımları ilk ENTRY/SP36–38'in yerel deney diliyle eş anlamlılaştırılmaz.

## 5. Assessor'ın rapor ve erişim sözleşmesi

| Adres / ifade | Yerel karşılık | Dayanak ve sınır |
|---|---|---|
| SP108.a/b — Criterion row / canonical criterion text | .a ayrıştırılmış her ölçüt için bir rapor satırı; .b sıraya göre kaynaktan bağlanan ölçüt metni. | B2 §3/G03/G07. Markdown bullet/continuation/heading kuralı var; bütün doğal dil gereksinimlerini çıkaran sistem değil. |
| SP109.a/b/c — Read-before-cite / pending / exposed | .a referans verilmeden önce başarılı okumanın önceki model çağrısına ulaşması; .b bekleyen ve .c ulaşmış okumalar. | B2 §3/G04. Aynı yanıtta okuma ve rapor, o rapora yeni kaynağı önceceden görünür yapmaz; başarısız okuma kabul kümesine girmez. |
| SP110 — Scoped reader / indexed read-only tools | İndeksli, göreli/normalize/uygun dosyaları okuyan araçlar ve rapor sunumu ile sınırlı model-arayüzü. | B2 §3/G04–05. Bilinmeyen araç dispatch'te reddedilir, yeni assessment boş geçmişle başlar. WORK/SP33.d'deki salt read-only talimatından daha somut kod kontrolüdür; bütün OS sandbox'ı veya epistemik bağımsızlık değildir. |
| SP111.a/b — Format repair / native criteria | .a tanınan markup içinden JSON ölçüt satırlarını kurtarma; .b doğrudan beklenen alanda sunulan satırlar. | B2 §4. Native alan önceliklidir; kurtarılan satırlar aynı doğrulamaya tabidir. Fail'i pass'e çevirme veya modelden hükmünü değiştirmesini isteme değildir. |
| SP112 — Strict report-tool schema | Ayrı G09 delta'sında sağlayıcıya gönderilen daha sıkı giriş şeması bilgisi. | B2 §2; LB2/G09. Belirli direct API-key yoluna koşullu; bütün sağlayıcıların canlı desteği doğrulanmadı. Eski parser/repair ile aynı kontrol veya aynı kaynak sürümü değil. |
| SP113.a/b — Syntactic coverage / semantic coverage | .a gerekli satır/alanların bulunması; .b açıklamaların gerçekten verilen ölçütleri karşılaması. | B2 §3; S01 §3. Araştırmanın analitik ayrımı; biçim kontrolü anlam doğruluğunu tek başına kurmaz. |

Üretici modelin kendi criterion metnini veya overall status'ünü vermesini engeller; durum satır hükümlerinden hesaplanır. Observation, basis, limitations ve kaynak alanları dolu olmalıdır. Bu kod düzeyindeki kontroller yok sayılmaz. Fakat dolu gerekçe yanlış olabilir; okunmuş kaynak iddiayı desteklemeyebilir; mevcut satır yanlış yükümlülüğü cevaplayabilir. Test kaynağının tekrarlanan geçerli satırlara izin vermesi otomatik hata değildir: ayrı ölçütler kanıt paylaşabilir. Tekrarı kabul/yasaklamak da tek başına anlam yeterliliği sağlamaz.

Repair tanınmış temsil kurtarımıdır; keyfî bozuk metni yorumlama değildir. Yalnız ilk tanınan blok alınırken kalan metin muhafaza edilebilir; tüm çoklu-blok niyeti çözülmez. Sentez metni kalmayan onarım reddedilir, onarım olayı/reason görünür tutulur. Bu incelemenin dayanağı araştırmanın kod/test aktarımıdır; G08 veya parser bu tur çalıştırılmadı.

## 6. Yayın, kullanım hesabı ve değişikliğin kabulü

| Adres / ifade | Araştırmadaki kullanım | Dayanak ve sınır |
|---|---|---|
| SP114.a/b — Completion marker / result digest | .a koşu ve kabul edilmiş sonuçla bağlı tamamlanma işareti; .b sonuç dosyasının içerik özeti. | B2 §5. Sonuç dosyasını bağlar, bütün özgün çalışma alanını veya hükmün doğruluğunu değil. |
| SP179 — No-replace completion marker | Sonuç yazımı ve event/usage finalization sonrasında, mevcut işaretin üzerine yazmadan yayınlanan marker. | B2 §5/G06. Rapor üretilmesi tek başına tamamlanmış yayın değildir; yayın hatası ayrı yol üretir. |
| SP115.a/b — Usage accounting / reconciliation | Mantıksal istek/yanıt ile fiziksel admission, settlement ve kullanım kayıtlarının hesabı ve uzlaştırılması. | B2 §5/D29. Bilinen kullanım tutulabilir; toplamın eksiksizliği ayrı niteliktir. |
| SP116.a/b — reportEligible / accounting complete | .a raporun kullanılabilirliği; .b kullanım/maliyet kapsamının tamlığı. | B2 §5. Fiyatı bilinmeyen retry her durumda raporu geçersiz kılmaz; bozuk kimlik veya bitmemiş mantıksal geçmiş farklıdır. |
| SP117.a/b — Instrument improvement / behavioral improvement | .a ölçme/rapor işleme aracındaki iyileşme; .b işi yapan aktörün/yöntemin sonucundaki iyileşme. | S01 §5; B2 §4/§6. Kabul edilen rapor sayısının artışı otomatik treatment faydası değildir. |
| SP118.a/b — Grader calibration / human gold | Değerlendiricinin ne ölçüde doğru hüküm verdiğinin sınanması ve insan referansı bağlamları. | B2 §8/D37. Kaynak bunları gerçekleştirilmiş ortak kalibrasyon olarak sunmuyor; agent audit insan referansıyla eşit değil. |
| SP119 — Contribution admission | Gerçek sorun, alternatifler, ortam/model bilgisi, önce/sonra kanıtı ve insan diff incelemesiyle katkı önerisinin kabul sürecine alınması. | A §7/S60/S62. Son maintainer kabulü veya release değildir; kutu işaretlemek gerçek incelemeyi kanıtlamaz. |
| SP120.a/b — Maintainer acceptance / release | .a önerinin bakım sorumlularınca kabulü; .b dağıtılan sürüme ulaşması. | A §7; B2 §8; S01 §2. Kişisel skill, PR açılması veya eval merge'i aynı geçiş değil. |
| SP121.a/b — Static CI / live campaign | .a statik/tür/birim/senaryo doğrulama; .b gerçek aktörlü değerlendirme koşuları. | B2 §8/D36/S70. Workflow metnini okumak CI koşusu değildir; ana pin'de tracked workflows yokluğu dış/manual kapıların yokluğunu göstermez. |

**U06-B02.a/b/c — Declared / materialized / actually loaded identity:** B1'in bildirilen treatment kimliği, B2 §7'deki full-SHA worktree materialization ve aktörün gerçekten gördüğü/kullandığı içerikle ayrı tutulur. Genel baseline/candidate helper'ı her stock koşusunun runtime yolu değildir. Snapshot kayıtları gözlenen kimlikleri kayıtlı referanslarla karşılaştırır. Full hash, uygun directory, HEAD ve olağan Git status kontrolleri gerçek kaynak mekanizmalarıdır; bütün ignored girdilerin yokluğu veya modelin niyetli skill kullanımı değildir. Oluşturma başarısızlığından sonra cleanup sonucu raporlanır; otomatik başarılı cleanup varsayılmaz. LB2/D35 ownership-aware lock ve stale-lock mekanizmalarını adlandırır; burada ayrıca concurrency testi veya genel kilit teorisi çıkarılmadı.

Katkı kuralları, yeni host/harness entegrasyonu için belirli bir istekle temiz oturum transcript'i ister. Bu dar giriş senaryosu bütün host/workflow davranışını kanıtlamaz. dev/main dağıtım ayrımı ana kaynağın tarihli sözleşmesidir, bugün bütün repository'ler için kural değildir. Geliştirme-only lab, dağıtılan plugin'in zorunlu runtime bağımlılığı sayılmadı.

## 7. Geçmiş raporların niteleyicileri

B2/D30'un raporuna göre retained-submission repair daha fazla eski raporu işleyebilmiş, sonraki yeni koşuda da raporlar kabul edilmiş; bazıları hâlâ repair gerektirmiştir. Kaynak, küçük all-pass örneğin fail-side ayrımını veya treatment/control faydasını gösteremediğini açıkça belirtir. Eski başarısızlıklara göre parser geliştirme, sonraki fresh run ve yöntemin gerçek iş faydası farklı kanıt sınıfları olarak korunur.

B2/D31 başka vakalarda kanıt başarıyla okunmuş ve native pass verilmiş olsa da aşırı geniş güvenlik çıkarımları raporlar. İki bütün incelemedeki hatalar assessor-only tekrarında bildirilirken izole iddia/yeniden yazım örnekleri beklenen etiketleri almıştır. Bu, format/görünürlük koşullarının semantik doğruluk için yeterli olduğu iddiasına karşı raporlanmış malzemedir. Özel asıl incelemeleri bu tur edinmedik; genel hata oranı veya context length kök nedeni çıkarmadık. Birden fazla değişken birlikte değiştiği kaynağın kendi sınırıdır.

Aynı D31'de bilinen fiyatlı ara toplamın downstream okuyucuda tam toplam sanılması ve sonradan tamlık niteliğinin düzeltilmesi anlatılır. Bilinen miktarı korumakla eksiksiz saymak farklıdır; bilinmeyen sıfır değildir. Tarihsel yayının değiştirilmemesi, düzeltmenin sonraki tüketici yorumunda yapılması ayrı tutulur.

B2/D37'nin kaynakta seçilerek okunmuş sonraki kaydı, dosya/başlık tarihi ile gerçek koşu tarihini ayırır; çalıştırılabilir kontrollerin geçmesiyle bazı composed failure'ların ve kalibrasyon belirsizliğinin birlikte kaldığını bildirir. Bu, eski başarılı smoke'u sonraki genel güvenilirlik kanıtı yapmayı önler. Kaynak araştırmanın D37 okuması kısmi, özel kanıtı doğrulanmamıştır; bütün belge veya bugünkü latest çalışma diye aktarılmadı. Bu paragraf sayısal bir yeniden analiz veya yeni deney değildir.

## 8. Kaynak-içi ilişki görünümü

S01 §1–7 üç bağlantılı süreç anlatır: **yöntemi geliştirme**, **hazırlanmış görev/aktörün değerlendirilmesi**, **değişikliği kabul edip dağıtma**. Bunlar zorunlu üç servis veya her kullanıcı işinden sonra otomatik çalışan kendini geliştirme sistemi değildir.

Yerel ilişki: gözlenen sorun → uygun müdahale ve yazım → karşılaştırma koşulları → hazırlanmış kaynak/ortam → etkileşim ve korunmuş kanıt → ölçüt raporu → temsil/yayın/kullanım hesabı kontrolleri → nihai sonuç → ayrıca gerekçelendirilmiş değişiklik/yayın kararı. Dallanma, erken hata ve ayrı sorumluluklar vardır; tek atomik transaction olarak sunulmaz.

S01'in subject identity, observation, report representation, publication, execution/accounting ve inference başlıkları analitik bakışlardır; zorunlu altı-katman mimarisi değildir. İyi tanımlanmış kontrol, başarısızlık kayıtları ve olumlu sınama önerileri birlikte korunur. Daha fazla yasak veya daha çok reviewer'ın her durumda yararı olduğu sonucu çıkarılmaz.

## 9. Pilot bağı, kapsam kontrolü ve devam

Görünür P2-T3/P2-T5'in SP80–SP121/SP179 kayıtları A/B1/B2/LA/LB1/LB2/S01 ile karşılaştırıldı. SP02/SP04 yazım bağları önceki ENTRY karşılığını silmeden eklendi; tarihsel iki-review anekdotu WORK/SP33'ü değiştirmedi. SP110 somut araç-dispatch kontrolü WORK'teki salt read-only talimatından ayrıldı. SP112'nin sürüm/sağlayıcı koşulu daha açık taşındı. SP119 için işe/kabul sürecine alınma ile son kabul arasındaki fark, önceki admitted-task düzeltmesiyle tutarlıdır; farklı süreçleri eş anlamlılaştırmaz.

Bu tur kapsamı maddi biçimde tersine çeviren yeni bir anlam saptanmadı; kayıtlar kaynakta bulunan ek koşullar ve ayrı adreslerle derinleştirildi. Alanlar (`criteria`, `observation`, `basis`, `limitations`, `references`, `status`, `reportEligible`, `complete`), özel işlem/senaryo adları ve ortam selector'ları yalnız yerel kullanımlarıyla korunur. Yeni genel tanım verilmez. Verbatim pilot arşivi değildir; kaynak kontrollü kalıcı aktarım ve eski adreslerin devamıdır.

A, B1 ve B2'nin onar bölümünden; üç kaynak kaydının tablo, tarih/sürüm ve okuma sınırlamalarından; S01'in giriş ve yedi bölümünden bu dosyaya dönülerek kapsam kontrolü yapıldı. Kaynak içindeki eski partial/next sözleri üretim tarihine aittir. U06'nın daha derin soru ve açık sınırları yeni araştırma borcu yapılmadı. U07 destek/vendor/rendering/dağıtım dosyaları, S05/S06 ve U08 zinciri bu dosyanın tamamlanmasıyla kapanmaz.

Kontrol aynı assistant'ın kaynak/pilot karşılaştırmasıdır; bağımsız doğrulama, yeni model/ürün koşusu veya sıfır atlama garantisi değildir. **Sıradaki iş U07-A görsel yardımcı ve U07-B dağıtım/sürüm kullanımlarının kalıcı aktarımıdır; ardından paket-geneli kapsam kontrolü.** Ortak referans değerlendirmesi başlamadı.
