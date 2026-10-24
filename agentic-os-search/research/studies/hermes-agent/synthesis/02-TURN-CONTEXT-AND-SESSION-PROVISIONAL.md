# HERMES — Genel yürütme çekirdeği: tur, bağlam ve oturum

**2026-09-10 / PROVISIONAL NATIVE CORE MODEL, U02.** Primary pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Kaynak defteri](../evidence/2026-09-10-turn-lifecycle/SOURCES.md), [mekanizma incelemesi](../evidence/2026-09-10-turn-lifecycle/RESEARCH.md), [kapsam haritası](../inventory/CORE-COVERAGE-2026-09-10.md). Bu sentez kaynak okumalarından türetilmiştir; yeni HERMES yürütmesi veya bağımsız ürün doğrulaması değildir.

## 1. Tek bir döngü değil, iç içe yaşam döngüleri

HERMES'in incelenen genel çekirdeği “prompt'u modele gönder, tool çağır, tekrar et”ten daha geniştir. Çekirdeğin içinde model–araç döngüsü vardır; çevresinde ise **hangi girdinin hangi oturuma ait olduğu, o oturum üzerinde kimin çalışabileceği, hangi görünümün gönderileceği, hangi etkinin kayda geçirilmiş sayıldığı ve sonucun hangi kullanıcıya teslim edileceği** yönetilir.

| Düzey | Taşıdığı süreklilik | Bir alt düzeyin bitmesi neyi kanıtlamaz? |
|---|---|---|
| Kalıcı iş / amaç | Kanban task ve run, goal/loop/heartbeat gibi tur-üstü mekanizmalar; tamamı henüz açılmadı. | Tek model yanıtı işin kabul koşulunun sağlandığını göstermez. |
| Konuşma oturumu | Transcript, saklanmış sistem mesajı, active session binding, model ve bağlam durumu. | Bir turun bitmesi oturumun kapanması değildir. |
| Kullanıcı/olay turu | Girdi, task/turn kimlikleri, tur bağlamı, interruption ve sonuç. | Başarılı araç çağrısı kullanıcının bütün isteğini bitirmez. |
| Model–araç yinelemesi | Hazırlanmış mesaj görünümü, cevap/araçlar, yeniden devam kararı. | Sağlayıcıdan byte gelmesi kullanılabilir cevap değildir. |
| API denemesi | Provider/transport kwargs, backoff/fallback ve request-level kesinti. | Retry başarısı dış araç etkileri için exactly-once garantisi değildir. |

Bu tablo HERMES'e dış ontoloji dayatmaz. Kaynakta farklı kimlik, sayaç, çağrı ve kalıcılık kuralları kullanan birimleri görünür kılar. Kanban/task alanı yalnız giriş bağlantılarıyla keşfedildi; bu sentez onu ayrıntılı araştırmış saymaz. [C01/C03/C07/C08/C11/C12/C17/C18]

## 2. Bir normal gateway işi nasıl ilerliyor?

**Girdi ve sıra alma.** Dış mesajın kabulü ve slash/busy ayrımından sonra gerçek agent yolu, kaynağın oturum bağını çözer. Task-local profile/session bağlamı hazırlanır. Aynı resolved session ID üzerindeki load-history → run → flush aralığını turn lease ile sıralama yolu bulunur. Okunamayan transcript boş geçmişe çevrilmez. Ancak bu normal yol bütün adapter'ların veya doğrudan API girişlerinin evrensel temsili değildir. [C18; önceki 12/13]

**Çalışacak ajanın seçimi.** Oturumun kendisi ile onu o anda yürüten Python ajan nesnesi ayrıdır. Gateway uygun cache girdisini kullanabilir, değiştirilmiş çalışma imzasında yenisini oluşturabilir. Callback ve bazı request ayarları her tur yeniden bağlanır. Cache eviction kaynak boşaltma olabilir; `/new` gibi konuşma sınırı başka işlemle temizlenir. [C14/C15]

**Tur bağlamının kurulması.** Gerçek kullanıcı metni history'ye yerleştirilir; log/task/turn kimlikleri, bütçeler ve runtime durumu hazırlanır. Uygun sistem mesajı seçilir, gerekiyorsa compaction çalışır. Eklenti notları ve harici bellek sorgusu güncel kullanıcı bağlamına eklenebilir. Bu eklerin gösterim metniyle karışmaması için ayrı sidecar tutulur. [C01/C02/R01/R02]

**Model–araç döngüsü.** Her yineleme mesajların ayrı kopyasını kurar; context engine, prefill, temizleme ve cache biçimi uygulanır. İstek boyutu değerlendirilir. Model çağrısı, kendi yeniden deneme/fallback sınırına girer. Araç istenirse doğrulama ve kayıt sırasından sonra yürütülür; sonuç yeni yinelemenin girdisi olur. Metin çıkarsa durma kapıları devamı isteyebilir. [C03–C11]

**Kapanış ve teslim.** Düzenli finalizer kayıt, kaynak temizleme, transcript sonunun tutarlılığı, yanıt dönüştürme ve sonuç alanlarını yönetir. Gateway kendi session binding/history offset durumunu günceller, eski generation sonucunu reddeder ve stream/media/normal metin teslimini ayırır. Bazı erken çıkış yolları düzenli finalizer'dan önce döner; dolayısıyla tek evrensel “sonunda her şey garanti temizlenir” iddiası yoktur. [C12/C15/C18]

## 3. Model hangi bilgiyi gerçekten görüyor?

En önemli temsil ayrımı, **saklanan konuşma ile gönderilen istek kopyasının aynı nesne olmaması**dır. Temiz kullanıcı metni, `api_content` tekrar-gönderim metni, belleğin oturum görünümü, tam sistem mesajı ve o turdaki harici recall/eklenti bilgileri birlikte değerlendirilir.

Örneğin kullanıcı kısa bir mesaj göndermiş olabilir. Gateway, önceki kesinti veya kanal hakkında yalnız modelin kullanacağı bir not ekleyebilir. Bu notu kullanıcının kendi cümlesi gibi kaydetmek ile modelin geçmiş isteğini aynı bağlamla tekrar oluşturabilmek farklı gereksinimlerdir. HERMES sidecar ve gönderim kopyasını bu iki amaç için ayırır. Bunun her medya/provider biçiminde kayıpsız olduğu doğrulanmış değildir. [C01/C04/C16]

Sistem prompt'u önbellekte korunurken harici bellek sağlayıcısının tur başı çıktısı yeni kullanıcı bağlamına eklenebilir. Böylece “bellek her tur güncellenir” veya “bellek yalnız oturum başında okunur” gibi tek cümleler sistemin bütün kanallarını anlatmaz. Hangi bellek, hangi görünüm, hangi çağırıcı sorulmalıdır. [C01/R02]

İstek hazırlama da tek noktada bitmez. Iteration'ın mesaj kopyasından sonra provider kwargs kurulur; request middleware'i onu değiştirebilir; execution middleware ve transport ayrı rol taşır. Bu tur normal kaynak bağlantısı API-message assembly'ye ve sonraki aşama çağrılarına kadar kurulmuştur. Gerçek son network içeriği ölçülmemiştir. [C04/C06/C07]

## 4. Bellek görünürlüğündeki eski boşluk nasıl daraldı?

M4, yeni MemoryStore'un güncel bilgiyi taşısa bile uyumlu eski DB sistem mesajının seçilebildiğini göstermişti. O deney gerçek compression caller sırasını kurmuyordu.

Yeni gerçek kaynak şunu ekliyor: **normal kabul edilmiş compaction sınırında HERMES cache'i geçersizleştirir, belleği diskten yeniden yükler, sistem mesajını gerçekten yeniden oluşturur; yalnız yeni metin eskisiyle birebir aynıysa eski nesne kimliğini korur.** Yeni mesaj normal commit yoluna ve çağırıcıya dönen active prompt'a verilir. [C13/R02]

Dolayısıyla bir sonraki tur için üç önemli normal olasılık vardır: mevcut cached prompt'un yeniden kullanımı; yeni ajanla compatible stored prompt'un restore edilmesi; kabul edilmiş bir refresh/compaction yoluyla yeni mesajın kurulması. Gerçek seçenek; çağırıcı, history, runtime ve compaction koşullarına bağlıdır. Sadece `approve` başarı metnine veya yeni nesne kurulmasına bakarak seçilemez. [C01/C13/C15/R01]

Bu normal-path bağlantısı M4'ü iptal etmez; onu doğru çalışma sırasına yerleştirir. Her yazının anında görünür olduğunu, bütün compaction arızalarının giderildiğini veya son provider isteğinin ölçüldüğünü söylemez. In-place transcript commit'iyle prompt update'i ayrı çağrılardır; rotation farklı publication yolu kullanır. Özellikle hata ve eşzamanlılık için daha güçlü kanıt gerekir. [C13]

## 5. Güvenilirlik mantığı: kontrolün adından çok koruduğu geçiş

**Geçmişi kaybetmeme:** unreadable transcript ile empty session ayrılır; eski çalışanın yeni generation sonucuna müdahalesi sınırlandırılır. [C14/C18]

**İz bırakmadan araç etkisi üretmeme:** normal DB-backed tool round açık append hatasında etkiden önce durur. Kayıttan ayrılmış review/no-DB dalı None döndürür; kuralın kapsamı bütün ajanlara otomatik yayılmaz. Etki sonrası sonuç-kayıt arızası farklıdır ve geçmiş etkileri geri alma anlamına gelmez. [C09/C16]

**Sonsuz toparlanmaya kapılmama:** retry, compaction, intent/empty response ve stop-gate devamları kendi bütçe/karar alanlarını kullanır. Pending verification cevabı bütçe sonu geri verilebilir; doğrulama kesin bitene kadar sınırsız devam sözleşmesi yoktur. [C03/C08/C10/C11/C12]

**Eski bağlamı yeni sanmama:** compaction adayının sadece üretilmesi yeterli değildir; no-progress/empty/superseded kontrolleri, kabul sınırı ve DB yayını vardır. Aynı ID korunabilse de gerçek context sınırı oluşabilir. [C13/C15]

Bunlar yalnız hata avı değil, HERMES'in devam edebilirlik ve doğruluk arasında nerede trade-off yaptığına dair mekanizma açıklamalarıdır. Hiçbiri bütün ürün için üretim güvenilirliği puanı değildir.

## 6. Tamamlanma tek bir boolean değildir

`completed` regular loop'un son durumunu anlatır; dış işin kabul ölçütü değildir. Bir cevap stream üzerinden gösterilmiş, sonra persistence veya cleanup başarısız olmuş olabilir. Gateway `already_sent` ise gövdeyi yeniden göndermeyebilir; None dönüşü “yanıt yok” değildir. Son yanıt transform'u kalıcı transcript'ten sonra da olabilir. [C12/C15/C18]

Kanban worker'ın board üzerinde complete/block bildirimi beklenmesi ve budget-exhausted durumunun ayrı kayda gönderilmesi bu ayrımı somutlaştırır. Küçük stop helper yalnız terminal araç adına bakar; actual task kabulünü ve başarı receipt'ini başka katmanlar belirlemelidir. Bu katmanların incelemesi bir sonraki yük taşıyan sorudur. [C12/C17]

Review konusunda da hesaplamanın başlatılması ile kullanıcıya bildiriminin teslimi ayrıdır. Gateway bildirimi ana teslimden sonraya bekletebilir; bundan bütün review hesaplamasının ancak o anda başladığı sonucu çıkmaz. `on_session_end` adlı hook'un tur sonunda çağrılması da gerçek session nesnesinin her tur kapandığı anlamına gelmez. [C12/C15]

## 7. Karşı okuma ve araştırmanın yeni sınırı

Model ağırlıkla ordinary loop ve normal gateway path'idir. Doğrudan CLI'nin bütün host döngüsü, API/ACP/TUI/desktop, native app-server, MoA'nın iç planlaması ve plugin-owned context mekanizmaları aynı şekilde kapatılmadı. Aynı ortak çekirdeğe bağlanmaları aynı semantics garantisi değildir.

Bu tur yöntemsel kazanım, U01'in dar yazı/onay kesitinden çıkarak **girdi → oturumda çalışma sahipliği → bağlam görünümü → model/araç etkisi → kayıt → teslim → sonraki tur** ilişkisini açıklamaktır. İlk öğrenme sentezi bu genel çekirdeğin değişim yollarından birine yerleşti; HERMES bundan ibaret değildir.

Sıradaki en güçlü adım, **birden fazla turu iş/amaç olarak birleştiren kalıcı durum**: önce kanban'ın task/claim/run/terminal-state zinciri, ardından goal/loop/heartbeat ve session persistence sınırları. Bu seçim önceki sabit sırayı ataletle sürdürmek değil, yeni kaynakta ortaya çıkan tur-üstü kontrol katmanını açıklama gereğidir. Ledger/sync, tool/provider/backend/delegation, scheduler/diğer UI/install/eval genişliği kaybolmaz. [Kapsam haritası](../inventory/CORE-COVERAGE-2026-09-10.md)

Bu ikinci üst katman hâlâ provisional'dır. Nihai HERMES CORE, dört-alan projeksiyonu, SOUL mimarisi veya adoption kararı değildir.
