# U01-M — Bellek değişikliği, onay replay'i ve görünürlük

**Tarih:** 2026-09-08. **Statü:** PINNED SOURCE-GROUNDED PARTIAL MECHANISM; bu not için yeni memory runtime deneyi yok.
**Pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.
**Kaynak rotası:** [D defteri](../evidence/2026-09-08-context-transfer/SOURCES.md), özellikle D03/D13–D17/D19. [06 çağrı/aktarım](06-CALLER-DISPATCH-AND-CONTEXT-TRANSFER.md) bu notun dış yürütme bağını taşır.

## 1. İncelenen mekanizma

Önceki notlar beceri mutasyonunu ve genel bellek kontratını anlatıyordu. Bu tur `tools/memory_tool.py`, `tools/memory_tool_store.py`, ortak pending komutları ve turn context/replay kesiti incelendi.

```text
agent-local memory çağrısı                         D03/D15
  → store ve target etkinlik kontrolü              D15
  → doğrudan mutasyon veya pending öneri            D15
      pending apply → aynı store işlemleri         D17/D15
  → hedef dosya kilidi + diskten yeniden okuma      D16
  → eşleme / bütçe / drift / içerik kontrolleri     D16
  → canlı entries + atomik dosya yazımı             D16
  → sabit prompt snapshot'ından ayrı canlı durum   D16
  → prompt restore/build + gerçek istek görünümü   D13/D14, kısmi
```

Burada dosyanın okunması bütün bellek, thread, profil ve model yaşam döngüsünün kapanışı değildir. Yeni transport deneyi D16 MemoryStore'u veya D15 memory_tool'u çalıştırmadı.

## 2. Doğrudan yazım ve onay önerisi ayrı yollar

D15 store yoksa, target geçersizse veya ilgili bellek alanı kapalıysa yazıyı reddeder. Tekil add/replace/remove yolunda temel parametre kontrolü onay kapısından önce yapılır. Batch yolunda list biçimi kontrol edildikten sonra gate çağrılır; bütün işlemlerin semantik doğrulaması `MemoryStore.apply_batch` içindedir. Dolayısıyla 'her bozuk batch pending olmadan reddedilir' genellemesi kurulamaz.

`_gate_or_stage` gate modülü yüklenemezse doğrudan devam eden bir fallback taşır. Gate karar verdiğinde allow/blocked/staged yolları ayrıdır; staged sonuç pending kimliği döndürür. Bu, önceki U01B'deki kimlik ile kalıcılık ayrımını ortadan kaldırmaz. D15'in varlığı gerçek disk arızası dağılımı veya bütün UI temsillerinin doğrulandığı anlamına gelmez.

`load_on_disk_store` config'teki limit/flags ile yeni store kurup yüklemeyi amaçlar; config hatasında varsayılan store'a dönebilir. Bu nedenle normal config yolu ile config failure yolu aynı kısıtı mutlaka uygular denmez. Gerçek kullanıcı profili/config hatası bu tur sınanmadı.

## 3. Kaybetmeden güncelleme için somut korumalar var

D16 `_mutate` hedefi çözer, ayrı `.lock` dosyası üzerinden kilit alır ve mutasyon öncesinde diski yeniden okur. Bellek dosyasının kendisinden ayrı lock kullanılması, dosyanın atomik olarak değiştirilmesiyle kilidin birlikte kullanılabilmesini sağlar. `fcntl` veya `msvcrt` varsa ilgili dal kullanılır; ikisi de yoksa kilitsiz devam dalı vardır. Bu, tüm platformlarda evrensel kilit garantisi değildir.

Existing-but-unreadable dosya boş kabul edilip üzerine yazılmaz. `_read_raw_checked` katı UTF-8/BOM işleme yoluyla decode hatasını da başarısız okuma sayar. Replace/remove/batch için aynı raw görünümden parse ve drift kontrolü yapılır. Round-trip farkı veya sınırı aşan dış içerik tespit edilirse backup girişimi ve refusal vardır. Backup'ın başarısız olabileceği de hata mesajında ayrı taşınır. Append-only add, drift guard'ını atlar ama okunamayan mevcut dosya korumasını atlamaz.

**Sınırlı olumlu sonuç:** Kaynak yalnız 'hatırla' prompt'u sunmuyor; diskten yeniden okuma, eşzamanlı yazım koordinasyonu, belirsiz eşleşmeyi reddetme ve dış düzenlemeyi koruma mekanizmaları var. Bu mekanizmaların bulunması tüm concurrent/profile varyantlarında doğru çalıştıklarını kanıtlamaz.

## 4. Bellek batch'i ile skill batch'i aynı transaction değil

D16 batch, diskteki entries'den ayrı bir `working` liste üzerinde işlemleri uygular; bütün semantik kontroller ve son char budget geçmeden commit yoluna girmez. Ara add sınırı aşsa bile sonraki remove/replace ile son durum limite uyuyorsa final-budget yaklaşımı bunu temsil edebilir. Eşleşmeyen veya bozuk işlemde no-commit sonucu vardır. Önceden dolu belleğin son girdisini batch içinde silerek boşaltma reddedilir; bilinçli son girdiyi silme için tekil remove yolu ayrıdır.

Buna karşılık önceki 04 notunun skill batch'i alt dosya işlemleri ve snapshot/rollback kullanıyordu. İki araca da 'batch' denmesi aynı atomiklik/failure davranışını taşıdıkları anlamına gelmez. Bu tur belleğin normal/hata yolları yürütülmedi; karşılaştırma kaynak temellidir.

## 5. Disk, canlı store ve prompt üç farklı durum

D16 `load_from_disk` canlı entries'yi yüklerken `_system_prompt_snapshot` da üretir. `format_for_system_prompt` bu snapshot'ı döndürür. Normal `_mutate` snapshot'ı güncellemez. Bu, dosya ve canlı entries değişirken önceden hazırlanmış prompt görüntüsünün sabit kalabilmesini açıklar.

D13 devam eden oturumda uygun cached/persisted prompt'u yeniden kullanabilir. D14 cached prompt yoksa restore/build çağırır; wire görünümünü kurarken cached system ile ephemeral ekleri ayrı tutar. Ancak compression/invalidation sonrası MemoryStore reload'unun bütün çağrı yolları bu tur kapanmadı. 05/K05'in 'hangi rebuild'de yeni bilgi görünür?' sorusu kısmen ilerledi, tamamen cevaplanmadı.

**Yeni hata adayı — M01:** `_mutate`, başarılı aday entries'yi nesneye atadıktan sonra `_write_file` çağırır. Yazma exception'ında aynı fonksiyonda önceki canlı entries'yi geri yükleme görünmez; dosya ve canlı nesne ayrışabilir. Sonraki mutasyon yeniden disk okuduğundan bu ayrışmanın kendiliğinden düzelebileceği yol da vardır. Bu statik karşı-sınama adayıdır; gerçek disk arızası veya kullanıcıya yanlış başarı gösterildiği iddia edilmez. Dış caller hatayı ayrıca raporlayabilir.

Ayırıcı deney: önce/sonra dosya byte'ları, canlı entries, frozen snapshot, tool sonucu; sonra yeniden yükleme/sonraki mutasyon. Yalnız exception görülmesini doğrulamak yeterli değildir.

## 6. Aynı anlamdaki parametreler aynı taramadan geçiyor mu?

Tekil add/replace yeni içeriği tarar. D16 `apply_batch` ön taraması `content` alanını inceler; daha sonraki uygulama `content` veya `new_text` alias'ını kabul eder. Bu pin'de **parametre-normalleştirme ile kontrol kapsamı arasında statik fark adayı** vardır (M02).

Bu not zararlı payload üretmez veya korumayı aşan gerçek ajan deneyi yapmaz. Ayrıca load-time tarama snapshot'ta tehdit eşleşen girdiyi placeholder ile değiştirirken live/raw girdiyi kullanıcı silebilsin diye korur. Dolayısıyla tek ön-tarama farkından 'her kötü içerik sistem prompt'una ulaşır' sonucu çıkarılamaz. Güvenli bir sentinel ve taklit tarayıcıyla alias eşdeğerliği sınanmalı; ardından gerçek tarayıcı ve load-time sınırı ayrı değerlendirilmelidir.

## 7. Pending replay: veri kökeni ile uygulama yetkisi ayrı

D17 `_apply_one`, pending kaydın yalnız `payload` alanını D15 `apply_memory_pending`e veya skill apply fonksiyonuna aktarır. Memory replay target etkinliğini tekrar kontrol eder, ardından store işlemini doğrudan çağırır; onay gate'ini yeniden sormaz. Ortak komut işleyicisi exception'ı başarısız sonuç olarak raporlar. Başarılı apply için pending silme çağrısı vardır; apply ve silme tek atomik storage transaction gibi gösterilmemelidir.

Pending record'un `origin` alanı listede otomatik değişiklik etiketi için kullanılabilir; bu ortak apply fonksiyonu o origin'i yeniden bağlamaz. Ancak insan onayı sonrası foreground/current caller yetkisiyle uygulama bilinçli bir politika olabilir. Bunun ihlal olup olmadığına karar vermek için onaylayan kullanıcı, gerçek UI/caller, aktif profil, hedef store ve sonraki ownership etkisi birlikte görülmelidir.

**Açık sınır:** Ortak dosyanın docstring'inin 'CLI live store, gateway fresh store' açıklaması actual CLI/gateway callsite'ının yerine geçmez. Bu tur o kullanıcı yüzeyleri kapatılmadı. `web_server_memory.py` adıyla açılan D21 dosyası ise provider dashboard/configuration helpers içerir; pending approval caller'ı değildir. Dosya adına dayanarak UI zinciri tamamlandı denmez.

## 8. Saklanan mesaj ile modele gönderilen mesajın bağı şimdi kodda görünür

D14 `compose_user_api_content` bellek prefetch ve plugin bağlamını görünür kullanıcı metnine ekleyen API görünümünü kurar. Prologue bunu `api_content` yan alanına işleyip kalıcılaştırma yoluna verir. `build_api_messages`, mesajları yapısal olarak kopyalar, geçmiş ve mevcut user/assistant satırlarında uygun yan alanı wire content'e geçirir; display metaverisini provider kopyasından çıkarır.

**Sınırlı sonuç:** Görünür transcript ile gönderilen içerik farkı yalnız doküman ifadesi değil, source-level representation mekanizmasıdır. Bunun tüm transport, compression, search ve review fork'larında eksiksiz korunduğu henüz doğrulanmadı. Dış memory prefetch hatalarının bastırıldığı yollar da vardır; 'provider kurulu' olmak her istekte ilgili kanıtın bulunduğunu göstermez.

## 9. Bir sonraki kaynak/deney dilimi

Önce 06'nın actual executor/whitelist sorusu zararsız bir sınamayla bağlanmalı. Bellek tarafında ise gerçek pending UI/caller ve profil/store bağlama; ardından M01 disk/store/prompt readback'i, M02 alias kontrolü ve compression/invalidation sonrası reload izlenmeli. Sonra ledger/backup/restore/sync ve curator'ın batch raporu birleştirilir.

Bu not U01'e somut mekanizma ekledi, fakat bütün öğrenme döngüsünü veya gelecekteki iş kalitesini doğrulamadı. Elde edilen ayrımlar candidate research girdisidir; Foundation düğümü, kabul edilmiş SOUL mimarisi veya Hermes benimseme kararı değildir.
