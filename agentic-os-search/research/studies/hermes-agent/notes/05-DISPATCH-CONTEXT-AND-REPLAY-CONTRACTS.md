# U01-DOC — Dispatch, bağlam ve yeniden kullanım sözleşmeleri

**Tarih:** 2026-09-08. **Statü:** DOCUMENTATION-BOUND RECONNAISSANCE / SOURCE VERIFICATION OPEN.  
**Birincil kod pin'i değişmedi:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Bu notun yeni dış kanıtı ise o commit'e bağlanamamış resmî web belgeleridir.  
**Kaynak rotası:** [W01–W08, okuma derinliği ve erişim kaydı](../evidence/2026-09-08-doc-contracts/READING-AND-ACCESS.md). Eski kod/bileşen kanıtı: [02](02-BACKGROUND-LEARNING.md), [03](03-SKILL-CURATION.md), [04](04-SKILL-WRITE-TRANSACTION-AND-APPROVAL.md). Güncel iş otoritesi [STATE](../STATE.md).

## 1. Bu turun gerçek ilerlemesi ve sınırı

Amaç, U01B'deki dar bileşen sonuçlarını gerçek review/foreground/curator çağrısına bağlamaktı. Pinned `run_agent.py` 1–190 isteği iki ayrı denemede GitHub 429 / `gitmon ... too-many-processes` döndürdü; kaynak içeriği gelmedi. Yerel kaynak arşivi isteği de DNS çözümlemesinde başarısız oldu. Bu nedenle **gerçek caller zincirinin yeni kod okuması bu tur ilerlemedi**. Araç hatası ürün kusuru veya kalıcı erişim yokluğu değildir.

Erişilebilir resmî kullanıcı/geliştirici belgeleri, aynı mekanizmanın sözleşme tarafını genişletmek için incelendi. Sonuç yeni bir native alt-sistem sentezi değil; hangi geçişlerin ayrı doğrulanması gerektiğini netleştiren sınırlı sözleşme notudur. `U01-DOC`, mevcut `U01-C` curator birimini veya sıradaki kaynak işini yeniden adlandırmaz.

Burada **DOC OBSERVATION**, belgenin gerçekten o açıklamayı içerdiğini; **OPEN**, bunun pinned kodda/çalışan sistemde doğrulanmadığını; **INFERENCE**, açıkça belirtilen gözlemlerden çıkardığımız araştırma sonucunu ifade eder. Yeni ürün/test yürütmesi yoktur. Web erişim tarihi yayın tarihi, crawl etiketi commit kimliği değildir. Belgelerin birbirleriyle ve pin ile atomik sürüm eşitliği kurulmadı.

## 2. Araç görünürlüğü ile etkili çağrı yetkisi farklı yüzeyler

**DOC OBSERVATION — W01:** Tools Runtime belgesi kayıt, schema üretimi, `check_fn` ile erişilebilirlik filtrelemesi, toolset seçimi ve dispatch'i ayırıyor. Agent-local state gerektiren `memory`, `todo`, `session_search` ve `delegate_task` için özel yollar tarif ediyor. **DOC OBSERVATION — W02:** Agent Loop, aynı araçların genel registry yolundan önce ele alınabildiğini; tekli ve çoklu tool çağrılarının farklı yürütme düzenlerini anlatıyor.

**INFERENCE:** Bir aracın model şemasında bulunması veya çıkarılması, bütün gerçek çağrı yollarının hangi kontrolü kullandığını tek başına cevaplamaz. Önceki review notundaki advertised-tool/cache parity ile dispatch whitelist ayrımı bu nedenle doğru araştırma birimidir; fakat yeni belgeler o whitelist'in uçtan uca doğrulandığı anlamına gelmez.

**OPEN:** W03'ün built-in/plugin araçlar için genel pre-tool kapsama anlatımı ile W01/W02'nin özel yolları nasıl birleşiyor? İki rakip açıklama açık kalır: özel yollar aynı kontrolü başka callsite'ta uygular; yahut bazı yollar farklı bir kontrol kapsamı taşır. Belgede tek ortak şema görünmemesinden bypass sonucu çıkarılamaz. Önce caller → özel/genel dispatch → worker/context → mutator izi gerekir.

## 3. Hata yanıtı üretmek, önceki etkiyi geri almak değildir

**DOC OBSERVATION — W01:** Registry ve dış dispatch için exception'ı JSON hata yanıtına çeviren iki katman tarif ediliyor. **Önceki bileşen kanıtı — 04 §2:** U01B, alt mutator istisnasında daha önceki dosya etkisinin kaldığı dar yolu gösterdi; dış caller henüz çalıştırılmadı.

**INFERENCE:** Dış wrapper'ın hatayı yakalaması, iç işlemin telafisini yaptığına kanıt değildir. Ancak belgede telafi anlatılmaması da telafi bulunmadığına kanıt değildir. İki ayrı soru korunmalı: model hangi sonucu alır; disk, snapshot, pending, ledger/cache ve diğer etkiler hangi durumda kalır?

**Ayırıcı kontrol:** Aynı sentetik çok-işlemli yazım, normal başarısız sonuç ve fırlatılan istisna ile gerçek dispatch üzerinden sınanmalı; tool sonucu ile bütün ilgili durumlar birlikte okunmalı. Caller ek rollback yapıyorsa U01B'nin ürün düzeyine taşınması değişir. Sadece `error` alanını kontrol eden bir assertion bunu ayırt etmez. Bu kontrol henüz tasarımdır, koşulmuş test değildir.

## 4. Gözlem, engelleme, onay ve hata politikası tek şey değil

**DOC OBSERVATION — W03:** Hooks belgesi observer, transform ve directive/control rollerini ayırıyor. `pre_approval_request`/`post_approval_response` gözlem yüzeyleri; `pre_tool_call` ise engelleme veya mevcut onay kapısına yönlendirme kararı tüketebiliyor. Onay olayı, bildirim gönderilememesi gibi henüz karar olmayan sonuçlar da taşıyabiliyor. Shell-hook hata politikası varsayılan fail-open; `fail_closed` yalnız desteklenen pre-tool olayında tarif ediliyor. Geçerli boş JSON, bu kipte bile engelleme kararı değildir.

**INFERENCE:** Hook'un adı veya yapılandırmada bulunması, hangi etkiyi durdurabildiğini söylemez. Çöken bir gözlemciden sonra işe devam etmek ile çöken bir zorunlu denetçiden sonra işe devam etmek aynı başarı ölçütüne sahip değildir. Bununla birlikte bu belgeden genel bir güvenlik sertifikası ya da bütün hook'ların fail-open olduğu sonucu çıkmaz.

**Önemli kapsam sınırı:** Buradaki command/execute-code onay olayları, `pending/skills` veya `pending/memory` replay'inin aynı olayı ürettiğini kanıtlamaz. U01B'nin pending onayıyla bu akış, isim benzerliği nedeniyle birleştirilmeyecek. Hook, kontrol kararı, kararın insana teslimi ve kalıcı yazı ayrı bağlanacak.

## 5. Origin, profile, session ve izolasyon birbirinin yerine geçmez

**DOC OBSERVATION — W06:** Profile bir Hermes durum dizini olarak tarif ediliyor; çalışma dizini ve sandbox'tan açıkça ayrılıyor. Aynı yerel kullanıcı yetkileriyle profile dışındaki dosyalara erişim, profile ayrımıyla engellenmiş sayılmıyor. Aynı Hermes home'u paylaşan ajan süreçleri için ayrıca bellek karışması uyarısı var.

**Önceki gözlem — 02/04:** Review origin'i bir ContextVar etiketi; pending kaydın origin'i payload dışında; fork bazı parent depolarını paylaşabiliyor. Bunlar mevcut pinned bulgulardır, bu tur yeniden yürütülmedi.

**INFERENCE:** Kaynağın köken etiketi, yazının nereye gittiği ve yazmaya kimin yetkili olduğu ayrı sorulardır. Profile ayrımı çalışma durumunu bölümlendirebilir; kooperatif bir namespace düzenini işletim sistemi erişim sınırı diye adlandıramayız. Tersinden, profile bir sandbox olmadığı için state bölümlemesini değersiz saymak da yanlıştır.

**OPEN:** Gerçek review/curator/foreground ve pending apply yollarında origin ile profile seçimi hangi noktada kurulur, worker'a taşınır ve sıfırlanır? Kullanıcının onayından sonra foreground yetkisiyle uygulama bilinçli politika olabilir. İhlal hükmü için öneren/onaylayan/uygulayan ilişkisi ve gerçek hedef dizin gösterilmelidir. İnceleme izi kimlik/metaveriyle kurulmalı; credential içeriği toplanmamalıdır.

## 6. Belleğin kalıcılaşması ile modele görünür olması ayrılıyor

**DOC OBSERVATION — W04:** Kullanıcı belgesi bellek dosyalarının oturum başında frozen snapshot olarak prompt'a alındığını, yazıların diskte ve tool sonucunda canlı olabildiğini anlatıyor. **DOC OBSERVATION — W05:** Prompt Assembly, cached prompt ile API-call-time eklerini ayırıyor; snapshot'ın yeni oturum yanında açık invalidation/rebuild, örneğin compression-triggered rebuild ile değişebileceğini de belirtiyor.

**CROSS-DOC QUESTION:** “Oturum içinde hiç değişmez” biçimindeki sade anlatım ile rebuild istisnasının gerçek kapsamı pinned caller'da çözülmeli. Burada bir runtime bug veya hangi belgenin tarihsel olarak daha yeni olduğu gösterilmiş değildir.

**INFERENCE:** Bir yazının başarısını en az dört gözlemle ayırmak yararlı: kalıcı dosya, mevcut bellek nesnesi, kurulmuş system prompt ve bir sonraki gerçek API isteği. Yeni memory dosyası var diye mevcut isteğin onu gördüğü; eski prompt var diye yazının kaybolduğu söylenemez. Kullanıcı tarafından yanlış varsayımın düzeltilmesi senaryosu, sıradan başarılı ekleme senaryosundan daha ayırt edici olur: eski ve yeni bilginin hangi görünümde ne zamana kadar kaldığı gözlenmelidir.

## 7. Oturum kimliği, bağlam sürümü ve çalışma sonu farklıdır

**DOC OBSERVATION — W08:** Compression belgesi hem aynı session ID üzerinde in-place compaction hem eski dönen-ID yolu tarif ediyor; in-place yolda system prompt yeniden kurulurken önceki mesajlar arşivlenmiş görünümde kalabiliyor. **DOC OBSERVATION — W03:** Hook kataloğu turn finalization ile gerçek session teardown/reset olaylarını ayırıyor; `on_session_end` adını yalnız gerçek oturum kapanışı gibi okumamak gerekiyor.

**INFERENCE:** Session ID'nin değişmemesi bağlamın değişmediğine, bir “end” olayı ise bütün çalışanların bittiğine kanıt değildir. Araştırmada ID, prompt/bağlam revizyonu, turn sonucu ve teardown ayrı takip edilmelidir. Bunlar önerilen SOUL ontolojisi değil, HERMES'in iddialarını sınamak için yerel kontrol lensidir.

**OPEN:** Review tetikleyicisinin bu olaylardan hangisine bağlandığı, tekrarlı finalize/reset/compaction sonrasında mükerrer veya atlanan review oluşup oluşmadığı kodda izlenecek. Adlandırma farkı tek başına böyle bir arıza bulunduğu anlamına gelmez.

## 8. Geçmiş kaydı ile modelin gördüğü temsil eşitlenemez

**DOC OBSERVATION — W07:** Session Storage, stored `content` ile gönderilen içerik farklı olduğunda `api_content` yan alanını; arama, raw retrieval ve API replay için farklı yüzeyleri anlatıyor. SQLite yazma contention'ı için transaction/retry düzeni de tarif ediliyor. **DOC OBSERVATION — W08:** Compression belgesinde özet üretme hatasının bazı yollarda özet olmadan orta bağlamın düşmesine gidebildiğine ilişkin açık uyarı var. Bu uyarı bizim tekrarladığımız deney değildir; olay sıklığı doğrulanmadı.

**INFERENCE:** Diskte geri bulunabilir geçmiş, bir review fork'un veya sonraki model isteğinin aynı kanıtı gördüğünü göstermez. Dolayısıyla “kaynak saklandı”, “gerektiğinde getirilebilir”, “gerçekten getirildi”, “karar için yeterli temsil kaldı” farklı değerlendirmelerdir. Önceki aynı-model/farklı-model digest sorusu, bu yeni görünüm ayrımlarına bağlanmalıdır.

Profile'ın paylaşılan bellek uyarısı ile DB'nin çok süreçli erişim desteği otomatik bir çelişki değildir: bir DB'nin yazı çakışmasını yönetmesi, bütün home altındaki bellek dosyalarını ve agent-local cache'leri birlikte koordine ettiğini kanıtlamaz. Bu ayrımı çözmek için MemoryStore ve gerçek dosya kilitleri gerekir.

## 9. Sıradaki kaynak turunun ayırıcı kontrolleri

Aşağıdakilerin hepsi **PLANNED / NOT RUN**. Her kontrol kendi kod ref'i, gerçek caller'ı, sentetik fixture'ı ve durum readback'iyle yürütülmeden sonuç sayılmayacak.

| Kontrol | Ayıracağı iki olasılık | Asgari gözlem |
|---|---|---|
| K01 Özel/genel tool yolu | Ortak kontrol başka callsite'ta var / kapsam gerçekten farklı | Memory, skill ve güvenli sıradan tool için call trace; pre-hook/whitelist sonucu; handler'a ulaşıldı mı? |
| K02 Dış exception wrapper | Hata yalnız temsil ediliyor / telafi de yapılıyor | Normal hata ve exception sonrası yanıt + disk/snapshot/yan kayıt durumu. |
| K03 Worker/context aktarımı | Origin/profile korunuyor / bazı geçişte farklılaşıyor | Tekli/çoklu dispatch, fork ve pending apply için köken + resolved home + aktör/oturum ilişkisi. |
| K04 Onay semantiği | İstek/bildirim/karar/uygulama ayrılıyor / tek başarıya indirgeniyor | Terminal approval ile memory/skill pending ayrı; notify failure/deny/timeout/apply-failure yolları. |
| K05 Bellek görünürlüğü | Cache/rebuild sözleşmesi geçerli / güncelleme başka anda görünür | Yazı öncesi/sonrası dosya, store, cached prompt ve gönderilen istek; rebuildsiz, compression ve yeni session varyantı. |
| K06 Lifecycle tetikleyicisi | Turn bitişi ve teardown farklı ele alınıyor / bazı çağrı karıştırıyor | Review trigger/cancel/finalize sayımı ve side-effect zamanı; isim veya ID diff'i tek oracle değil. |
| K07 Replay ve kanıt | Saklanan/gönderilen/aranan temsil ayrımı korunuyor / yük taşıyan içerik düşüyor | Benzersiz sentetik düzeltmenin raw/archive/search/replay/review görünümlerinde izi. |
| K08 Sıkıştırma hatası | İstek güvenli biçimde erteleniyor/korunuyor / kritik bağlam düşebiliyor | Özetleyici başarısızlığı ve sınır koşulu; context before/after ve açık hata sinyali. |
| K09 Curator batch raporu | Nested operations anlaşılabilir temsil ediliyor / düz yorum eksik kalıyor | Aynı işlem flat/batch; gerçek tool sonucu, curator raporu, pending preview ve ledger karşılaştırması. |

Bir başarısız fixture veya kasıtlı hata sonucu, tek başına ürünün genel arıza oranı değildir. Negatif ve olumlu kontrol birlikte tutulmalı; ilk sonuç görüldükten sonra kabul kuralı değiştirilirse yeni koşu gerektiği kaydedilmelidir.

## 10. Plan etkisi ve bounded sonuç

U01'in gerçek caller/dispatch/context zinciri **hâlâ ilk kaynak işi**. Yeni not bu işi tamamlamadı; yalnız K01–K09 ile kontrol sorularını keskinleştirdi. F01/F02/F03/F05/F06/F08/F11 için sözleşme yönlendirmesi genişledi; bu ailelerin kod kapsamı veya kapanışı yükseltilmedi. Önceki U01B'nin 10 tanılayıcı durumu içeren deneyi yeniden yapılmadı; yeni runtime kanıtı yok.

Erişim yeniden mümkün olduğunda önce primary pin'deki `run_agent.py` ve onun gerçek forwarding/import yolları; ardından `model_tools.py`, registry, özel memory çağrısı, review/curator entry ve pending apply bağları okunur. Yeni web belgesinde adı geçen modül pinned ağaçta yoksa yokluğu varsaymak veya pin'i sessizce değiştirmek yerine sürüm ilişkisi araştırılır. MemoryStore, ledger/backup/restore/sync ve sonraki kullanım sırası korunur; geniş gateway/UI/provider/kurulum/eval aileleri kapsamdan düşmez.

Savunulabilir ilerleme: öğrenmeyi tek “yazdı/hatırladı” olayı olarak değil; teklif, yetki, etki, kalıcılık, görünürlük, geri çağırma ve gelecek görevde yarar bakımından ayrı sınayacak sözleşme/karşı-sınama yüzeyi oluştu. Bu ayrımların bir kısmı önceki kod notlarından gelir, bu tur belgelerle genişletildi. **Henüz savunulamaz:** bütün zincirin doğru çalıştığı, HERMES'in öğrenme kalitesinin doğrulandığı, native sistem modelinin tamamlandığı veya SOUL/Development OS için benimseme kararı verildiği.
