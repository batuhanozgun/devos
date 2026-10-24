# U01B — Beceri yazımı, onay temsili ve geri alma

**Kaynak tarihi / pin:** 2026-09-07 / `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.  
**Statü:** SOURCE-GROUNDED PARTIAL MECHANISM + BOUNDED COMPONENT PROBE. Bütün HERMES veya öğrenme kalitesi doğrulaması değildir.  
**Köken:** Daha önce sohbet eki olarak teslim edilen çalışmanın repository için düzenlenmiş sentezi. [Aktarım kaydı](../evidence/2026-09-07-u01b/PUBLICATION.md). Bu yayın yeni deney sayılmaz.  
**Kaynaklar:** [S01–S06 defteri](../evidence/2026-09-07-u01b/SOURCES.md). [Deney düzeni](../evidence/2026-09-07-u01b/component-probe/README.md), [ham sonuç](../evidence/2026-09-07-u01b/component-probe/RESULT.json).

## 1. Soru, kapsam ve araştırma modeli

HERMES deneyimden bir beceri değişikliği önerdiğinde kullanıcı neye onay verir, gerçekten ne uygulanır ve hata olursa hangi durum korunur?

`öneri → pending işlem → kullanıcıya gösterilen temsil → uygulama → dosya durumu → geri alma → iz/önbellek/paylaşım → sonraki kullanım`.

Önceki [arka plan review notu](02-BACKGROUND-LEARNING.md) üretim ve guard kesitini; [curator notu](03-SKILL-CURATION.md) oluşmuş kütüphanenin bakımını inceler. Bu not ikisini ikame etmez; aralarındaki yazma/onay işlemini açar. Sabit dosya sayısı yerine davranış zinciri araştırılır. Diğer büyük kaynak aileleri korunur; çalışma yalnız hata avına dönüşmez. Dört-alan projeksiyonu ve SOUL/Development OS mimarisi henüz türetilmez.

S01 skill mutator, S02 batch, S03 upstream batch testi, S04 approval ve S05 ortak komut işleyicisi tam okunmuş kaynaklardır. İki küçük hedef modül (S02/S04) exact Git blob doğrulamasından sonra açık dependency stub'larıyla sentetik dosyalarda yürütülmüştür. Kaydedilen koşu Python 3.13.5/Linux, UTC `2026-09-07T09:35:13.772427+00:00`. Gerçek HERMES kurulumu, provider/ağ çağrısı, kullanıcı profili, upstream suite veya bağımsız araştırmacı koşusu yoktur. Deney ilk kaynak keşfinden sonra tasarlanmıştır; holdout değildir.

## 2. F01 — Hata sonucu, istisna ve kurtarma hatası farklıdır

**OBSERVATION:** S01'in advertised çağrı biçimi `operations` dizisidir; eski flat biçim kabul edilir. S02 hedef beceri dizinlerini snapshot'lar. Normal `success:false` veya bozuk JSON sonucu geri alma çağırır. Aynı dosyayı yıkıcı biçimde tekrar ezmeye karşı preflight vardır; delete ancak tek başına çağrılabilir. S03 normal hata, birden çok skill ve restore hatası için test kodu içerir; bu upstream test dosyası çalıştırılmadı.

**COMPONENT RESULT:** B01'de iki işlem uygulandı. B02/B03'te normal hata/bozuk JSON üzerine ilk değişiklik geri alındı. B04'te taklit ikinci mutator `OSError` fırlatınca ilk değişiklik kaldı, batch snapshot'ı temizlendi ve istisna dış harness'e ulaştı. B05'te geri yüklemenin kendisine hata verildiğinde yarı uygulanmış canlı dosya ve snapshot korundu.

**Neden:** `_skill_manage_batch` içinde alt mutator çağrısı JSON parse try bloğunun dışındadır. Dış gövde `try/finally` kullanır; bu istisna için rollback yapan `except` yoktur. `rollback_failed` false kalınca finally snapshot'ı temizler. S01 `_guarded_write` ve handler dispatch kesiti dosya işlemlerini genel bir exception-to-result sarmalayıcısıyla çevirmemektedir.

**Sınır:** Bu, exact bileşenin daha güçlü 'bütün hataları atomik geri alır' iddiasına karşı örnektir. Gerçek dış caller'ın ek koruması, üretim olay sıklığı veya tüm ürünün davranışı belirlenmiş değildir. 'Geri alma yok' da yanlıştır: olumlu kontrol ve restore-failure koruması ayrıca gözlenmiştir.

## 3. F02 — Onay önizlemi işlem diliyle aynı kapsamda değil

**OBSERVATION:** S02 batch'i `action:batch` ve `operations` ile tek pending kaydı olarak saklar. S05 `/skills diff` yolunda kaydı S04 `skill_pending_diff` fonksiyonuna verir; bu fonksiyon batch içeriğini açmaz. S01 `_act_patch`, `action:patch` + `content` biçimini tam yeniden yazım olarak kabul ederken önizlem patch'i `old_string/new_string` üzerinden kurar.

**COMPONENT RESULT:** D01 normal flat hedefli patch'in eski/yeni satırlarını gösterir. D02 aynı değişikliğin batch biçiminde yalnız `(batch on '')` döndürür. D03 farklı tam içerik içeren `patch + content` için `(no textual change)` döndürür.

**Sınır:** Bu ortak önizleme fonksiyonu ve ona bağlanan komut yolu hakkındadır. Her UI'nin aynı temsili kullandığı, kullanıcının gerçekten yanıltıldığı veya yetkisiz yazma olduğu gösterilmedi. Önizlemin düz `str.replace` yöntemi ile mutator'ın fuzzy matching çağrısı da farklıdır; fuzzy engine'in bütün varyantları bu deneyde sınanmadı. Onay kapısının varlığı, onay nesnesinin doğru gösterildiğini kanıtlamaz.

## 4. F03 — Dönen pending kimliği geri bulunabilir kayıt değildir

**OBSERVATION:** S04 `stage_write` önce `.json.tmp` yazıp `os.replace` ile son `.json` adına geçirir. Hata loglanır ama record yine döner. S01 `_run_write_gate` bu kimlikle `success:true, staged:true` yanıtı kurar. Listeleme `.json` dosyalarını tarar.

**COMPONENT RESULT:** D04 normal kaydı listeden/kimliğiyle geri bulur. D05 sentetik rename hatasında yine kimlik döndürür; kayıt `get_pending` ve listede bulunmaz, bir geçici dosya kalır. Dolayısıyla 'hiç byte kalmadı' değil, 'normal onay yolunda geri çağrılabilir kayıt oluşmadı' sonucu geçerlidir.

**Sınır:** Gerçek disk doluluğu veya bütün kullanıcı yüzeyleri sınanmadı. İzinsiz hedef değişikliğini önlemek ile onay bekleyen işi sürdürülebilir biçimde saklamak ayrı başarı ölçütleridir.

## 5. F04 — Dizin rollback'i bütün etkilerin rollback'i değildir

**OBSERVATION:** S01 `_record_success` her başarılı tekli işlem sonrası best-effort ledger, prompt-cache invalidation, curator kullanım/sahiplik ve koşullu debounced sync yollarını çağırır. Batch her alt işlemde bu yoldan geçer; snapshot/rollback yalnız skill dizinlerini kapsar.

**COMPONENT RESULT:** B02/B03'te dosya geri alınırken harness'in sentetik dosya-dışı olay listesi kaldı. Bu gerçek ledger veya network/sync deneyi değildir; batch'in kendi sınırını görünür kılar.

**INFERENCE / OPEN:** Dosya atomikliği, audit bütünlüğü, önbellek ve dış paylaşım ayrı incelenmelidir. Audit'in eski girişimi koruması doğru ve bilinçli olabilir; silinmemesi tek başına kusur değildir. Gerçek iz attempted/applied/reverted ayrımını taşıyor mu, sync ara durumu görebiliyor mu, timer profile context'i nasıl alıyor soruları açık. Dış paylaşım yarışı veya sızıntı kanıtlanmadı.

## 6. F05 — Önerenin kökeni ve onay verenin yetkisi ayrı

**OBSERVATION:** Pending record origin'i payload dışında taşır. S05 `_apply_one` yalnız payload'ı `apply_skill_pending`e iletir; S01 replay fonksiyonu gate-bypass ContextVar'ını ayarlar. Bu dar yolda record origin'ini yeniden bağlama görünmez. Önceki H05/H06'da sahiplik/guard davranışı mevcut background/foreground bağlamını kullanır.

**OPEN:** İnsan onayından sonra foreground sahipliği bilinçli tercih olabilir; bütün caller/UI bağlamları okunmadan yetki ihlali veya evrensel köken kaybı denmez. Öneren, onaylayan, uygulayan ve sonraki özerk değişikliğe yetkili aktör ayrı izlenmelidir.

## 7. Deneyi yorumlama ve yeniden kullanım sınırı

B01–B05 normal/istisna/restore yollarını; D01–D05 önizlem ve pending saklamayı sınar. 10 tanılayıcı assertion'ın karşılanması HERMES conformance PASS'i değildir: bazı assertion'lar özellikle kusur sınırını görünür kılar. Fixture'lar gözlemden sonra temizlenir; B05'te kalan snapshot sayısı temizleme öncesidir. Ham logdaki yerel yollar eski araştırma ortamına aittir, kullanıcı makinesi değildir.

Kaynak tazeliği yalnız S01/S02/S04'ün `7874ef9f62b9b533f8d3da6107eb2a52f4be252f` gözleminde aynı blob taşımasıyla sınırlı kontrol edilmiştir. Bütün HEAD, bağımlılık kapanışı veya kurulu release revalidation'ı değildir.

SOUL/Development OS için şimdilik candidate input: onay temsilini gerçek etkiye bağlamak; hangi etkilerin gerçekleştiğini/geri alındığını ayırmak; kayıt kimliğiyle kalıcılığı ve metin değişikliğiyle öğrenme kalitesini karıştırmamak; farklı hata yollarını ayrı sınamak. Bu ilkeler yeni Foundation düğümü, protokol veya zorunlu yazılım bileşeni olarak kabul edilmez.

## 8. Devam

S01/S02'nin okunması gerçek review → tool invoke → exception handling zincirini kapatmaz. Sıradaki kaynak işi caller/dispatch ve origin/profile aktarımıdır; ardından memory mutator, ledger/restore/sync ve sonraki skill/cache yüklemesi. U01-C curator raporunun batch diliyle ilişkisi de bu zincire bağlanmalıdır. Gerçek gelecek görevde kalite artışı açık kalır; gateway/cron/provider/UI/delegation/install aileleri kapsamdan çıkarılmaz. Güncel plan ve yetki için [STATE](../STATE.md) esas alınır.
