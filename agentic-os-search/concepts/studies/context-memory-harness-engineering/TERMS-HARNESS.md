# Harness — Bağlamlı kullanım kayıtları

**B6-T3 / D3-KAYNAK-KAYDI-TAMAM / PAKET-KISMİ.** Tarih: 2026-09-19. Bu dosya [TERMS.md](TERMS.md)'nin harness parçasıdır; ayrı araştırma, genel harness araştırması veya ortak sözlük değildir. Yerel okuma ve devam kaydı [READING.md](READING.md), yöntem [v0.3-working](../../METHOD.md), global kapsam [SCOPE.md](../../SCOPE.md).

## 1. Kaynak, aktarım ve açıklama anahtarı

**D3:** [03-HARNESS-ENGINEERING.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/03-HARNESS-ENGINEERING.md). Repository: batuhanozgun/agentic-os-search. Ref: **ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a**. Blob: **53f3cbcfbc934155553c9ae6c4ff931126b00876**. Araştırma tarihi 2026-09-03. Bu tur 1–220, 221–440, 441–660, 661–880, 881–EOF (istek üst sınırı 1100) tam geri okundu; okurken kullanım notları tutuldu, sonra §1–31'den kayıtlara kapsam kontrolü yapıldı.

Bu turun konuşma görünümünde P1-T1 ve P1-T3'ün harness kayıtları mevcuttur. K05–K07 ve H01–H27 üst kimlikleri bu görünür kayıtlarla ve D3 ile karşılaştırılarak korunur. Alt adresler aynı satırdaki ayrı anlamları bulmaya yarar; kimlik sayısı kavram sayısı değildir. Önceki B6-T2'nin bellek yanıtına erişim sınırı tarihsel kayıttır; burada değiştirilmez. H17'nin D2 bağlantısı, bellek parçasının eski pilotla tümüyle eşleştirildiği iddiası değildir. H22'nin D4'e ait cache kısmı aşağıda açıkça bekleyen kapsam olarak ayrılır.

**Atıf:** araştırmanın adlandırılmış dış kaynağa atfettiği açıklama. **Araştırma:** önceki yazarın tanımı, sentezi, önerisi, sorusu veya tarihli proje yorumu. **Yeni açıklama:** bu aktarım sırasında görünür kılınan, ayrıca belirtilmiş bağlamsal ayrım. Tablolar kaynak bağlantılı Türkçe parafrazdır; doğrudan alıntı veya dış kaynağın bu tur okunmuş olduğu iddiası değildir. Birlikte gösterilen adlar otomatik eş anlamlı değildir.

Kullanıcı okuma anındaki anlam seçimlerini denetleyemediği için önemli yorum, dayanak ve belirsizlikler görünür tutulur. Ortak sözcükler aynı anlamı garanti etmez; kullanıcı onayı, kaynak kullanımı ve çıkarıcının yorumu teknik doğruluğun yerine geçmez. Kaynak dosyasının güven etiketleri yeni doğrulama sonucu değildir.

## 2. Harness, mühendislik faaliyeti ve amaçlanan özellikler

| Kimlik / özgün ifade | Bu araştırmadaki kullanım | Kaynak rolü ve sınır |
|---|---|---|
| K05 — Harness | LLM'yi dış dünyayla döngü, araçlar, bağlam yönetimi, güvenlik kontrolleri, orkestrasyon ve genişletme olanakları üzerinden bağlayan çalışma zamanı yapısı. | D3 §2 ilk paragraf, S1'e atıf. Kod çalışmasının kapsamı coding-agent sistemleridir; bütün agent alanları için standart tanım yapılmıyor. |
| K06 — Harness engineering | Modelin yararlı iş yapabilmesi için ortam, araçlar, soyutlamalar, repo bilgisi, geri bildirim, gözlenebilirlik ve uygulanabilir yapısal kısıtları tasarlama yönündeki daha geniş operasyonel faaliyet. | D3 §2 ikinci paragraf, S2'ye atfedilen çerçeve. Bir kurumun deneyimi bütün üretim sistemleri için genel yasa değil. |
| K07.a — Harness Engineering, araştırmanın tanımı | Model kapasitesini güvenilir, sınırlandırılmış ve durumu geri kazanılarak sürdürülebilir işe dönüştürmek için döngü, arayüz, bağlam/bellek bağlantıları, yetki, orkestrasyon, doğrulama, gözlenebilirlik ve iş kayıtlarını tasarlama ve yeniden ayarlama disiplini. | D3 §2: önceki araştırmanın kendi genişletilmiş tanımı. P1-T3 düzeltmesi korunur: reliable/bounded/recoverable tasarım amacıdır; herhangi bir harness'in bunu sağladığına ilişkin test sonucu değil. |
| K07.b — Harness Engineering, kapanıştaki nesne anlatımı | Aynı başlık altında model dışı işletim/kontrol zemininin ve taşıdığı mekanizmaların anlatılması. | D3 §31: araştırmanın kapanış ifadesi. Faaliyetin adıyla faaliyet nesnesi anlatılıyor. Bu kapsam kayması kaydedilir; iki anlamın aynı olduğu veya kesin kaynak hatası bulunduğu ilan edilmez. |

D3 §1 ve §3, nesneyi yalnız model/prompt/araç listesiyle veya yalnız framework/SDK seçimiyle sınırlamaz. Hangi araç, ne zaman görünürlük, izin, yan etki, doğrulama ve yeniden devam gibi sorular da açılır. Bu sorular genel bir işletim sistemi ürününün tanımı değildir. Kaynaktaki operating system around the model sözü, problem alanını anlatan benzetme/çerçevedir.

## 3. İşletim, araçlar, roller ve bağlam

| Kimlik / ifade | Bağlamdaki karşılık | Kaynak ve niteleyici |
|---|---|---|
| H01.a — Agent loop | Gözlem/bağlam → modelin akıl yürütme/kararı → eylem/araç/yanıt → sonucu gözleme → devam/durma dizisi. | D3 §4.1, araştırmanın minimum döngü anlatımı. Her uygulamanın bütün adımları aynı biçimde gerçekleştirdiği söylenmez. |
| H01.b — Lifecycle | Döngünün kaç tur süreceği, ne zaman duracağı, kesintiye veya başarısızlığa nasıl karşılık vereceğiyle ilgili yürütme anlamları. | D3 §4.1; H20 ve H21 ile ayrıntılanır. |
| H02 — Tool / Agent-Computer Interface (ACI) | Araç kümesi, şema, geri bildirim biçimi, keşif, eylem ayrıntısı, hata iletisi ve ortam erişiminin modele sunulma düzeni. | D3 §4.2 ve §7, S3'e atfedilen arayüz örnekleri. Kısa arama çıktısı, sınırlı dosya görünümü ve hatalı düzenlemeyi reddetme, araştırmada performansla ilişkilendirilir; bu tur yeni karşılaştırma yok. |
| H03.a — Environment legibility | Ortamın iç yapısı, araçları ve sonuçlarının aktör tarafından anlaşılabilir olması. | D3 §6, S2 deneyimi ve araştırmanın açıklaması. Modelin genel kapasitesiyle aynı özellik değil. |
| H03.b — Operability | Ortam üzerinde gereken işlemleri gerçekleştirebilme olanağı. | D3 §6–7. Görmek, işlem yapmak ve doğrulamak birbirini otomatik sağlamıyor. Burada belirli bir sistem arızasına yeni neden teşhisi yapılmadı. |
| H04 — Orchestration | Tek/çok aktörlü işin rol, görev, aktarım ve yürütme düzeni. | D3 §4.5, §5, §25. Yalnız çok aktör veya bütün harness anlamına gelmiyor; H23 yerel örüntü adlarını taşır. |
| H18.a — Context plumbing | Bağlamı kuran mekanizmanın ne zaman çalışacağı, kaynak/araç bulunabilirliği, bütçe, sıkıştırma eşiği ve sonuçların kırpılması gibi bağlantı/işletim işleri. | D3 §13 ve §4.3. Plumbing tek biçimsel bileşen adı olarak tanımlanmıyor; bağlam kalitesini tasarlama ile işletme ilişkisi anlatılıyor. |
| H18.b — Memory plumbing | Bellek yaşam döngüsünün tetiklenmesi ve işletimle bağlanması. | D3 §14 ve §4.4. H19 ile bellek politikasının çalışma zamanına bağlanması; yalnız bir MEMORY.md dosyasının varlığı yeterli sayılmıyor. |
| H23.a — Manager + subagents / manager-as-tools | Yöneten aktör–alt aktör ilişkisi ve SDK'ya atfedilen araç olarak yönetme örüntüsü. | D3 §4.5, §25, §30/S8. İki ifadenin tüm kapsamları eşitlenmiyor. |
| H23.b — Parallel workers | Paralel çalışanlar için kullanılan rol/düzen adı. | D3 §4.5; §25 koordinasyon maliyeti ve ortak yanlış varsayım riskini korur. Ayrı bağlam, bağımsız kanıt demek değil. |
| H23.c — Planner / generator / evaluator | Planlama, üretme ve değerlendirme rolleri üzerinden kurulan örüntü. | D3 §4.5 ve §11, S5'e atıf. Örüntünün adı, bütün rollerde doğru davranış garantisi değil. |
| H23.d — Initializer / incremental coding agent | İlk ortam/özellik durumunu hazırlama ile sınırlı artımlarla çalışma rolleri. | D3 §12, S6'ya atıf. Gelecek oturumun ilerleme/commit kayıtlarından devam etmesiyle ilişkilendirilir. |

D3 §4.3'te retrieval, compaction, tool-result shaping, source ordering ve subagent context isolation tekrar geçer. Context parçasındaki C11/C16/C17/C15/C18 ile kaynak-içi bağlantı kurulur; D3'ün atfı yeni bağımsız destek sayılmaz. Role-specific contexts (§4.5) aktöre göre bağlam ayrımıdır; kaynağın bunları nasıl kurduğuna ilişkin genel algoritma verilmez.

## 4. Süreklilik, devir ve iş kayıtları

| Kimlik / ifade | Bağlamdaki karşılık | Kaynak / sınır |
|---|---|---|
| H05 — Handoff, oturumlar arası iş devamı | İş ilerlemesi, karar ve yapılacakların harici kayıtlardan yeni oturumda geri kazanılması. | D3 §12, S6'ya atıf; §4.4 ve §21.5. Daha büyük bağlam penceresiyle aynı süreklilik mekanizması değil. |
| H06 — Handoffs, orkestrasyon örüntüsü | SDK'nın sunduğu örüntüler arasında geçen aktarım adı. | D3 §25 ve §30/S8. Bu dosyada bütün API sözleşmesi anlatılmıyor; H05'le veya H17'yle tam eş anlamlılık kurulamaz. |
| H17 — Bellek–bağlam handoff'u, ilişkili D2 kaydı | Bellek okuma sonucunun kimlik, kaynak, zaman ve statü bilgisiyle bağlamı kuran mekanizmaya aktarılması. | D2 §23; kalıcı karşılığı için TERMS-MEMORY/D2-U36. P1-T3'te H17 olarak ayrılmış konu korunur; D3'ün yeni dış kaynak bulgusu değil. |
| H13.a — Work artefacts | Plan, ilerleme dosyası, karar, repo durumu, özellik kontrol listesi ve kanıt/devir kayıtları. | D3 §4.9 ve §12. Dosyanın varlığı onun doğru veya güncel olduğunu göstermiyor. |
| H13.b — System of record | İş ve bilgi kayıtlarının başvurulabilir düzeni. | D3 §8, S2'ye atfedilen repo örneği. Tek bir artefaktla bütün kayıt düzeni aynı nesne değil. |
| H19.a — Read/write triggers | Belleğin hangi olayda okunup yazılacağına ilişkin tetikleyiciler. | D3 §4.4 ve §14; uygulama politikası seçilmemiş. |
| H19.b — Verification-before-persist | Kalıcılaştırma öncesinde doğrulama konumlandırılması. | D3 §14, araştırmanın işletim örneği. Adı, doğrulamanın gerçekten veya uygun ölçütle yapıldığını kanıtlamıyor. |
| H19.c — Lifecycle hooks | Yaşam döngüsü olaylarıyla bağlanabilen işlemleri anlatan SDK kaynak kullanım adı. | D3 §30/S8. Kaynak tanıtımında geçer; burada bütün olay listesi veya güncel API doğrulanmıyor. |
| H20 — Yaşam döngüsü kontrol adları | .a max turns; .b stop conditions; .c timeout; .d retry; .e interruption; .f escalation. Tur sınırı, durma koşulu, zaman aşımı, yeniden deneme, kesinti ve başka karar/yürütme yoluna taşıma olarak anılırlar. | D3 §3, §4.1, §4.7 ve §21.5. Tek bir varsayılan politika veya ortak sayısal eşik seçilmiş değil. |
| H21 — Durumu koruma ve geri kazanma | .a checkpoint; .b persist; .c resume; .d recovery; .e rollback. Durum kaydı/saklama, devam ve hata sonrası geri kazanma/geri alma işleri. | D3 §4.1, §4.4, §12, §21.5. Kaynak bütün teknik uygulamaları ayrı tanımlamıyor; konuşma geçmişini tekrar yüklemeye indirgenmiyor. |
| H22.a — Model/version binding | Hangi model/adaptor ve sürümün kullanılacağının yönlendirilmesi veya bağlanması. | D3 §15. Modelin değiştirilmesiyle harici çalışma düzeninin aynı olması karıştırılmıyor. |
| H22.b — Rollout / rollback | .1 rollout: model/uyarlama kullanımının dağıtım yolu; .2 rollback: o değişiklikten geri dönme. | D3 §15. H21.e'nin genel hata-kurtarma bağlamıyla aynı kullanım sayılmıyor. |
| H22.c — Cache identity / invalidation | Eski pilot satırında H22 ile birlikte geçen, D4'e dayanan kullanım. | D3'ten tamamlanmış sayılmıyor. D4 §7 kalıcı aktarımında ayrıca kontrol edilecek; ilgili D2-U23 kaydı D3 kanıtı yapılmıyor. |

**Handoff tek bir nesne aktarmıyor:** H05 devam eden iş durumunu, H06 SDK orkestrasyonunu, H17 bellek okuma sonucunun bilgi/statü geçişini anlatıyor. D3 §10 ayrıca aktarım sırasında politikanın devam edip etmediğini soruyor; sorunun sorulması uygulanmış politika devri demek değil.

## 5. Yetki, kısıt ve doğrulama

| Kimlik / ifade | Bağlamdaki karşılık | Kaynak / sınır |
|---|---|---|
| H07 — Guardrails | .a input, .b output, .c tool kontrolleri. | D3 §10 ve §30/S4, tarihli SDK atfı. Agent düzeyindeki kontrolün her araç/aktör yolunda otomatik çalışmadığı aktarılıyor; bugün API yeniden doğrulanmadı. |
| H08.a — Reasoning capability | Akıl yürütme/eylem üretme kapasitesi. | D3 §19, araştırmanın ayrımı. |
| H08.b — Action authority | İlgili eylemi yapmaya yetkili olma. | D3 §19. Bir eylemi istemek veya yapabilmek tek başına yetki kazandırmıyor. |
| H09 — Sandboxing | Dosya sistemi/ağ erişimi bakımından sınırlama ve yalıtım bağlamında kullanılan mekanizma adı. | D3 §4.6 ve §19. Bütün sandbox çeşitleri veya güvenlik özellikleri tanımlanmıyor; context isolation ile otomatik eşleştirilmez. |
| H14.a — Prose preference / explicit protocol | Tercihin metinle anlatılması ile açık bir prosedür/kural olarak yazılması. | D3 §9. Bunlar kaynağın karşılaştırdığı kontrol biçimleri; araştırma metinleri mevcut assistant'a yeni talimat değildir. |
| H14.b — Runtime guard/check | Çalıştırma sırasında uygulanabilen kontrol. | D3 §9. Kontrolün doğru şeyi ölçmesi ve gereken yerde çalışması ayrı sorular. |
| H14.c — Deterministic invariant enforcement | Yapısal/değişmez koşulların mekanik kontrollerle uygulanması. | D3 §9, S2 linter/test deneyimi. Kaynağın sıralaması uygulama gücü bakımındandır, mutlak doğruluk hiyerarşisi değildir. |
| H24 — Yetki ve etki sınırları | .a allowed tools; .b approval gates/human approval; .c least privilege; .d credentials/tool scope; .e irreversible action boundaries/side effects; .f cross-tenant separation. | D3 §4.6 ve §19. Araç, onay, en az yetki, kimlik bilgisi kapsamı, geri alınamaz etki ve kiracı ayrımıyla ilgili adlar; hepsi her harness'te uygulanmış sayılmaz. |
| H25.a — Function-tool invocation | Araç kontrolünün etrafında çalıştığı çağrı yolu olarak verilen SDK örneği. | D3 §10, S4'e atıf. |
| H25.b — Hosted/builtin tool | Farklı yürütme yolu kullanıp kullanmadığı sorgulanan araç ailesi. | D3 §10. Kaynağın sorusu tek başına güncel ürün davranışına kesin hüküm değil. |
| H10.a — Verification | Üretilen işin ilgili ölçüt ve kanıta karşı değerlendirilmesi. | D3 §4.7 ve §11, araştırmanın sorumluluk alanı. |
| H10.b — Evaluator | Çalışan uygulamayı kabul ölçütlerine karşı sınayan aktör. | D3 §11, S5'e atfedilen Playwright örneği; aynı aktarımda kaçırma ve yanlış onay sınırları da var. |
| H10.c — Oracle / error sensitivity | Değerlendirme dayanağının uygunluğu ve ilgili yanlışı ayırt edebilmesi. | D3 §11. Değerlendiren aktör eklemek bu koşulları kendiliğinden sağlamıyor. |
| H26.a — Rework loop | Kontrolün ardından işi yeniden ele alma/düzeltme döngüsü. | D3 §4.7. Her başarısız durumda aynı uygulama seçilmiş değil. |
| H26.b — Acceptance criteria | İşin kabulünde kullanılacak ölçütler. | D3 §4.7 ve §11. Ölçütün varlığı, başarı veya doğru ölçüt olduğu iddiası değil. |
| H26.c — Deterministic checks | Mekanik sınamalar. | D3 §4.7 ve §9; çalıştırılmış bu-tur testler değil. |

D3 §9, bütün ince niyet/araştırma çerçevesi/belirsizlik kararlarının mekanik kurala çevrilebildiğini söylemez. Model değerlendirmesi gerektiren alanları görünür bırakma önerisi korunur. §10'un yan etkinin kontrolden önce oluşması ve çıktı kontrolünün dış etkiyi geri alıp alamaması soruları, kontrolün varlığı ile gerçek koruma kapsamını ayırır.

## 6. Gözlenebilirlik, bakım ve model bağımlılığı

| Kimlik / ifade | Bağlamdaki karşılık | Kaynak / sınır |
|---|---|---|
| H11.a — Observability, aktör olanağı | Aktörün ortam sonuçlarını görebilmesi. | D3 §18.1. Kendi sonucunu görmek doğru yorumladığını göstermiyor. |
| H11.b — Observability, inceleme/teşhis olanağı | İnceleyen kişinin hatayı bağlam, bellek, araç, model, kontrol veya orkestrasyon aşamaları bakımından ayırabilmesi. | D3 §18.2. İz kaydı tek başına nedensel teşhis veya bağımsız doğrulama değil. |
| H12 — Tracing / logs / metrics | .a çağrı/olay izleri; .b günlükler; .c ölçümler. LLM çıktıları, araç çağrıları, handoff, guardrail sonuçları, özel olaylar ve maliyet/token bilgileriyle ilişkilendirilir. | D3 §4.8, §18, §30/S2/S7. Aynı veri türü veya aynı kapsam değiller; her gerekli olayın kaydedildiği söylenmiyor. |
| H15 — Component ablation | Bileşen çıkarıldığında başarı, hata sınıfı, maliyet ve gecikmenin nasıl değiştiğini inceleme. | D3 §16, §21.2 ve S5'e atfedilen sadeleştirme. Bu tur deney yürütülmedi. |
| H16 — Model-harness mismatch | Eski model zayıflığını telafi eden gereksiz karmaşıklığın sürmesi veya yeni modelin hata biçimlerinin kaçırılması. | D3 §17, §20.J, araştırmanın hata adı ve S5'e atfedilen model değişimi örneği. Her bileşenin artık gereksiz olduğu sonucu değil. |
| H27.a — Architecture invariants / dependency directions / logging conventions | Yapı, bağımlılık yönleri ve günlükleme için korunması istenen kurallar. | D3 §5, §9, S2'ye atıf. |
| H27.b — Custom linters | Belirli yapısal kuralları sınayan mekanik araçlar. | D3 §5 ve §9; H14.c ile aynı kaynak ilişkisinin örneği. |
| H27.c — Doc gardening / freshness / ownership / cross-link checks | Belge bakımını, güncelliği, sorumluluğu ve çapraz bağlantıları ele alan işlemler. | D3 §5 ve §8, S2'ye atıf. Bilginin repo içinde bulunması ile gerekli durumda yüklenmesi ayrılır. |
| H27.d — Entropy/drift | Düşük kaliteli örüntülerin çoğalması, belge veya kuralların eskimesi bağlamındaki bozulma. | D3 §20.I, araştırmanın hata sınıfı. Fiziksel entropi ölçümü olarak kullanılmıyor. |

D3 §16 karmaşıklığın token, gecikme, koordinasyon ve hata ayıklama yükünü artırabileceğini; §17 model değişince yeniden değerlendirme, bileşen çıkarma ve gerekirse sadeleştirme/ekleme yolunu anlatır. Kaynaktaki Opus 4.6/sprint decomposition örneği tarihli S5 atfıdır, bugünkü model ürününe dair yeni doğrulama değildir. Her bileşenin varsayımı olduğu ifadesi S5'e atfedilen ders olarak tutulur; bütün mümkün harness bileşenleri için bu tur ispat edilmiş önerme yapılmaz.

## 7. Kaynağın hata adları

D3 §20'nin on sınıfı, önceki araştırmanın ayrıştırma önerisidir; eksiksiz evrensel hata taksonomisi veya bu tur gözlenen arızalar değildir.

| Adres / özgün başlık | D3'te açıklanan hata |
|---|---|
| D3-F01 — Perception/context failure | Gerekli kaynağın görünmemesi veya fazla gürültü. |
| D3-F02 — Tool/interface failure | Olanak bulunmasına rağmen arayüz/araç gözleminin yetersizliği. |
| D3-F03 — Authority failure | İzin verilmeyen eylemin yapılabilmesi veya gerekli eyleme erişilememesi. |
| D3-F04 — Orchestration failure | Yanlış iş bölümü, yinelenen iş, devirde kayıp veya kontrolsüz paralellik. |
| D3-F05 — Memory/state failure | İlerleme kaybı veya eski durumla devam. |
| D3-F06 — Verification failure | Yanlış şeyi ölçen test, kaçıran evaluator veya eksik kontrol kapsamı. |
| D3-F07 — Stop/retry failure | Premature completion, infinite loop, retry storm ve maliyetin kontrolsüz büyümesi. |
| D3-F08 — Observability failure | Hatanın görünmemesi veya kaynaklarının ayrıştırılamaması. |
| D3-F09 — Entropy/drift failure | Repo/süreç içinde kalitesiz örüntülerin çoğalması ve belge/kural eskimesi. |
| D3-F10 — Model-harness mismatch | H16'nın model–çevre düzeni uyumsuzluğu. |

## 8. Değerlendirme dili

D3 §21'deki sorular araştırmacının önerdiği değerlendirme düzenidir. Burada eşiği belirlenmiş ve çalıştırılmış bir benchmark olarak sunulmaz.

| Adres / özgün ifade | Kaynağın sorduğu soru |
|---|---|
| D3-E01 — Baseline | Aynı modelle daha yalın çalışma düzenindeki sonuç nedir? |
| D3-E02 — Component ablation | Bileşen çıkarılınca başarı, hata, maliyet ve gecikme nasıl değişir? H15'e bağlı. |
| D3-E03 — Negative tests | Hatalı araç girdisi, izin ihlali, eski durum, eksik kanıt, evaluator'ın kaçırdığı hata ve retry sorunu ayırt edilebiliyor mu? |
| D3-E04 — Coverage | Kontrol hangi yürütme kiplerinde çalışmıyor? |
| D3-E05 — Recovery | Hata sonrasında geri alma, devam, üst karar yoluna taşıma veya devir gerçekleşebiliyor mu? |
| D3-E06 — Model-version portability | Aynı düzen yeni modelde yarar mı, ek yük mü getiriyor? |
| D3-E07 — Cost-adjusted value | Kalite katkısı, maliyeti işin değeri bakımından haklı çıkarıyor mu? |

D3 §21.7'nin 20x maliyet/2x kalite değerleri açıklayıcı koşuldur; ölçülmüş ürün sonucu veya eşik değildir. End-to-end success rate adı tek başına bütün hata yüzeylerini temsil eden ölçüt sayılmıyor. D3 §11'de evaluator'ın yakaladığı ve kaçırdığı örnekler aynı atıf bağlamıyla korunur; sadece olumlu kısmı alınmaz.

## 9. Proje ve başka alanlarla ilişkili kullanım

**D3-P01 — SOUL / task-specific working system / harness configuration (§22):** araç, ortam erişimi, bağlam/bellek stratejisi, doğrulama yoğunluğu, aktör/yetki sınırı, orkestrasyon, durma/üst karar koşulu ve model kapasitesi seçimiyle ilişkilendirilen gelecekteki sistem oluşturma hedefi. Kaynak bunu research implication olarak niteler. Sabit harness template veya fixed workflow system karşı örneği, bütün işlerde aynı düzenin uygunluğunu sorgular; SOUL'un tanımı veya kabul edilmiş tasarımı burada yeniden verilmez.

**D3-P02 — Development OS / repository-level control representation / runtime enforcement capacity (§23):** araştırma tarihindeki ChatGPT tarayıcı, proje talimatları ve GitHub düzenine ilişkin karşılaştırma. Okunup uygulanmasına bağlı reasoning controls ile deterministik çalışma zamanı kısıtları ayrılır. Kaynağın mevcut haliyle ifadesi 2026-09-03'e aittir; Development OS'nin bugün inşa edilmiş olduğu sonucu değildir. Bu dosya AGENT/protokolleri araştırma kanıtı olarak kullanmaz; yalnız D3'ün tarihli proje yorumunu aktarır.

**D3-P03 — Repository-local / agent-readable / progressively disclosed çalışma bilgisi (§24):** repo durumunu OpenAI deneyiminin kayıt, kısa harita, kademeli erişim, sürümlü plan ve bakım uygulamalarıyla karşılaştıran yedi satırlık analoji. Kaynak bağımsız gelişim ve dış destek ifadeleri kullanır; bunlar önceki araştırmanın değerlendirmesidir. Benzerlik mimari doğrulaması değildir, burada bağımsızlık deneyi yapılmaz.

**D3-P04 — Decomposition/control topology (§25):** kaç aktör bulunduğundan ziyade iş bölümü ve kontrol düzeninin belirli işe katkısını sorgulayan ifade. Manager-as-tools, subagents ve evaluator örüntülerini tek doğru mimaride birleştirmez. Context handoff loss, duplicate work, shared assumptions, authority confusion, coordination cost ve false verifier independence kaynakta karşı riskler olarak korunur.

Fine-Tuning/model adaptation (§15) model katmanında; harness'in seçme, sürüm bağlama, değerlendirme eşiği veya dağıtım işlemleri harici işletim tarafında anlatılır. Seçilen şey ile onu seçen/işleten düzen aynı nesne değildir. Bu, D4'teki bütün mekanizma karşılaştırmasının yerine geçmez.

## 10. Yalnız adlandırma, açık soru ve kaynak rolleri

D3 §1–3 model, LLM, agent system, agent framework, SDK, prompt, tool calling, raw intelligence, abstraction ve operating system adlarını kullanır. Bu dosya hepsinin bağımsız genel tanımını kurmaz. Kod örneklerinin veya AGENT.md/AGENTS.md/MEMORY.md/docs gibi dosya adlarının geçmesi, onların gerçek içeriklerini okumak veya mevcut kontrol olarak uygulamak değildir.

D3 §13'ün context builder, source availability, max budget, compaction threshold, aktarım ve trimming; §14'ün write trigger, checkpoint, recall timing, access control ve cleanup/forgetting jobs adları H18–H21 ve context/bellek kayıtlarına bağlanır. Source §30/S8'de dynamic instructions, §30/S9'da simplest-sufficient-system principle ve workflow/agent patterns yalnız kaynak kullanım tanıtımı düzeyindedir; ayrıntılı yeni tanım verilmez.

**D3-N01 — Karar/tanı alanları (§26):** güvenilir yürütme, araç anlaşılabilirliği, ortam görünürlüğü, devam, QA, izin, politika uygulaması, durma ve maliyet sorunları harness açısından sorgulanır. Model kapasitesi, otoritatif kaynak yokluğu, belirsiz amaç/ölçüt veya ortamın fiziksel olanaksızlığı gibi alternatifler de korunur. Bu tur gerçek bir arıza teşhis edilmedi veya çözüm seçilmedi.

**D3-N02 — Açık sorular (§28):** minimum sorumluluk kümesi; model değerlendirmesi/mekanik kısıt ayrımı; araç edinme/keşif; arayüz benchmark'ı; bağlam/belleğin lifecycle olaylarına bağlanması; aktör yetkisi–araç izni; riske bağlı stop/retry/escalation; verification topology; multi-agent maliyet katkısı; component ablation; model güncellemesi; tarayıcı/runtime kapsamı; repo/session state sözleşmesi; izlerden kararların geri kazanılması; doc drift saptama; prompt injection'dan bağımsız izin uygulaması. On altı soru, kaynağın açık araştırma dilidir; otomatik yeni iş, uygulanmış gate veya tamamlanma engeli değildir.

| D3 kaynak kimliği | Kaynak adı ve D3'teki rol | Korunan atıf sınırı |
|---|---|---|
| S1 | Harness Engineering: Anatomy, Architecture, and Evolution of Coding Agents — A Source-Code Study of Eleven Systems; model+harness ve runtime kapsamı. | Kaynakta yeni preprint/coding-agent odaklı diye niteleniyor. |
| S2 | OpenAI, Harness engineering: leveraging Codex in an agent-first world; ortam, repo, bakım, mekanik kısıt ve gözlenebilirlik. | Kurum içi ürün/takım deneyimi; evrensel yasa değil. |
| S3 | SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering; araç/geri bildirim tasarımı. | D3'ün performans iddiası bu kaynağa atıftır; bu tur tekrar deney yok. |
| S4 | OpenAI Agents SDK, Guardrails; kontrol aileleri ve kapsam. | 2026-09-03 okumasına ait framework örneği. |
| S5 | Anthropic, Harness design for long-running application development; roller, evaluator sınırları, ablation ve model bağımlılığı. | Mühendislik vaka çalışması; maliyet/başarı genellenmiyor. |
| S6 | Anthropic, Effective harnesses for long-running agents; oturumlar arası devam ve ilerleme kayıtları. | Kaynağa atfedilen örüntü; SOUL uygulaması doğrulanmıyor. |
| S7 | OpenAI Agents SDK, Tracing; çağrı/olay izleri. | Tarihli framework örneği. |
| S8 | OpenAI Agents SDK, Agents; manager-as-tools, handoffs, lifecycle hooks, dynamic instructions. | Bütün API bu dosyada yeniden açıklanmıyor. |
| S9 | Anthropic, Building effective agents; yeterince yalın düzen, workflow/agent örüntüleri ve araç tasarımı. | Kaynak tanıtımı; ayrı derin araştırma açılmadı. |

Bibliyografik ayrıntılar ve dış adresler sabit D3 §30'dadır. F-HRN-01–11 (§27) araştırmanın bulgu kimlikleri ve önceki anlatımın tekrarıdır; kullanım kimliklerimiz veya yeni bağımsız kanıt değildir. Kaynağın tarihsel tamamlanma/sonraki nesne bilgisi (§31), güncel concepts STATE/READING'nin yerine geçmez.

## 11. Kaynak-içi ilişki görünümü ve durma sınırı

D3 §4'ün dokuz aday alt sistemi sırasıyla şu kayıtlara bağlanır: döngü H01/H20; ACI H02/H03; bağlam H18.a ve C kayıtları; oturum/bellek H18.b/H19/H21 ve D2; orkestrasyon H04/H23; yetki H07/H08/H09/H24/H25; doğrulama H10/H26; gözlenebilirlik H11/H12; iş kayıtları H13/H05. Bunlar zorunlu, tamamen ayrık dokuz modül değil; araştırmanın tekrarlayan sorumluluk alanlarıdır.

**Model kapasitesi ile çevredeki işletim düzeni** D3'ün temel ayrımıdır. Kaynak, bu düzen içinde araç/ortam arayüzü, bağlam/bellek işlemleri, eylem sınırları, inceleme ve devam kayıtlarını birbirine bağlar. Context ve memory yönetimi geniş harness içinde işletilebilir; ayrı mühendislik soruları olmaları, birbirinden kopuk eş düzey mimari katmanlar oldukları anlamına gelmez (§13–15).

**Faaliyet–nesne ve amaç–sonuç ayrımı** K05–K07'de açık kalır. §2'deki tasarım disipliniyle §31'in işletim zemini anlatımını sessizce eşitlemedik. Güvenilir/bounded/recoverable hedefleri gerçekleşmiş özellik olarak yazılmadı.

**Politika → gerçek yürütme → gözlem → değerlendirme → yeniden ayarlama** bağlantısı §9–11/§13–18'de bulunur. Bu oklar yeni bir zorunlu durum makinesi değildir. Kuralın yazılması, kontrolün her yolda çalışması, sonucun görülmesi ve ölçütün uygunluğu ayrı sorular olarak korunur. Model değişince bileşen katkısının yeniden sorgulanması kaynağın önerisidir; bu tur yeni optimizasyon işi değildir.

Bütün D3 kullanımlarının kaynak taraflı kontrolü tamamlanmıştır. H17 ilişkisi D2'den; H22.c ve genel G/X ilişkilerinin bazıları D4'ten gelecektir. Dolayısıyla D3 bölümünün kapanışı, bütün CMH paketinin veya bütün pilotun birebir arşivinin kapanışı değildir. Sonraki genel harness araştırması mevcut kaynak aktarımını değiştirmeyecekse bu aşamaya eklenmez.

## 12. Aktarım/değişiklik izi

B6-T3, görünür P1-T1/T3 harness dökümlerindeki K05–K07/H01–H27 adreslerini D3'e karşı kontrol ederek kalıcılaştırdı. K07'nin amaç nitelemesi korundu; §31'deki nesne anlatımı K07.b olarak ayrıca adreslendi. H11'in iki gözlenebilirlik rolü, H13'ün artefakt/kayıt düzeni ve H21/H22'nin iki rollback bağlamı ayrı adreslerle görünürdür. H19.c kaynak tanıtımındaki lifecycle hooks düzeyinde tutuldu; H22.c'nin D4 bağı atlanmadı. H17, D2-U36'ya yerel konu bağlantısıdır; D2'nin eski pilot kimliklerine tümüyle eşlendiği söylenmez.

Context ve bellek kullanım gövdeleri değiştirilmedi. Araştırmanın güven etiketleri ve tarihli proje yorumları yeni teknik doğrulama sayılmadı. D3-F/E/P/N adresleri kaynak hata/değerlendirme/proje/soru dilini erişilebilir yapar; yeni genel kavram, yapılmış test veya benimsenmiş mimari oluşturmaz.

Bu kontrol aynı assistant'ın kaynak ve görünür pilot karşılaştırmasıdır; bağımsız inceleme, runtime deneyi veya bütün doğal-dil anlamlarının hatasızlık sertifikası değildir. Somut aktarım eksiği sonradan bulunursa ilgili kayıt yeniden açılır. Kaynak araştırma ve diğer studies durumları değiştirilmez.
