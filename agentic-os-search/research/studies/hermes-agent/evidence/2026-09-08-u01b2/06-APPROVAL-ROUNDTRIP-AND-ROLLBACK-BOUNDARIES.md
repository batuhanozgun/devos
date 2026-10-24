# U01B2 — Onay kaydının yeniden uygulanabilirliği ve geri almanın sınırları

**Tarih:** 2026-09-08. **Statü:** ARCHIVED-SOURCE-BOUND / EXPLORATORY TWO-MODULE COMPONENT EVIDENCE.  
**Birincil HERMES pin'i:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, değişmedi.  
**Kaynak erişim biçimi:** Research repository'nin `a218acfc20e7ece488709e00a9762166ec970fba` commit'inde saklanan, önceki U01B çalışmasına ait iki exact kaynak modülü. Bu tur upstream HEAD veya pin bağımlılık kapanışı yeniden doğrulanmadı.  
**Birim ilişkisi:** 04 notundaki U01B'yi genişletir; U01-C curator'ı, 05 belge notunu veya gerçek caller çalışmasını ikame etmez.  
**Önerilen kanıt rotası:** `../evidence/2026-09-08-u01b2/README.md` → `SPEC.md`, `probe.py`, `RESULT.json`, `STDOUT.txt`, `STDERR.txt`. Yayın durumu teslim paketindeki `PUBLICATION-HANDOFF.md` dosyasındadır; bu metin tek başına main'e yayın kanıtı değildir.

## 1. Bu turun kapsamı neden değişti?

Yetkili sonraki kaynak işi gerçek review/foreground/curator → tool dispatch → hata işleme → pending apply zinciriydi. Canonical research main bu tur başında `a218acfc...` idi; önceki STATE/plan ile uyumluydu. Pinned `run_agent.py` 1–190 isteği bu tur bir kez GitHub 429 / `gitmon ... fail-fast:network` döndürdü. İçerik gelmedi. Aynı engelli isteği tekrar tekrar denemek, başka endpoint ile sınırlamayı dolanmak veya belge anlatımını kod yerine koymak yoluna gidilmedi.

Buna karşılık kullanıcının research reposunda zaten saklanmış iki kaynak modülü erişilebilirdi. Kaynaklar yeniden tam okundu, yerel dosyaya aktarıldı ve Git blob hash'leri karşılaştırıldı. Kayıtlı pin bağlantısının ötesinde yeni upstream güncellik iddiası yapılmadı.

Çalışma, aynı yetkili mekanizmanın erişilebilir küçük kesitine indirildi: **bir batch girişinin onay kaydına dönüşmesi, kayıtlı payload'ın aynı bileşene geri verilmesi ve hata sonrası disk durumu**. Bu, genel caller işinde ilerleme değil; dar bileşen kanıtında ilerlemedir. Yeni dış belge taraması teknik bulgu dayanağı olarak kullanılmadı.

## 2. Gerçek kaynak, taklit bağımlılık ve deney ayrımı

| Yerel ID | Gerçek modül | Arşiv/Git blob | Tam okuma / yük taşıyan aralık |
|---|---|---|---|
| B | `tools/skill_manager_batch.py` | `9f38adff284eede4234948f67e99a43752c0926e` | 1–192; validation 18–57, snapshot/restore 60–110, batch 113–192 |
| W | `tools/write_approval.py` | `f1e99b46e934595c002c2bc659143fcbc1f9fe8d` | 1–291; config 43–59, store 64–136, origin/gate 141–211, diff 252–281 |

Arşiv: `research/studies/hermes-agent/evidence/2026-09-07-u01b/component-probe/upstream/`. Önceki ledger'da bunlar S02 ve S04/H07 olarak kayıtlıdır; yeni bir H-ID verilmez.

Gerçek HERMES olmayan bağımlılıklar: config okuma, home/profile resolver, origin ContextVar sağlayıcısı, inline approval callback, preflight guard, registry hata helper'ı, single-operation mutator ve iki modülü birleştiren `_run_write_gate` adapter'ı. Taklit mutator yalnız geçici fixture dosyalarında basit metin değişikliği yapar; gerçek skill mutator'ın fuzzy patch, ownership, cache, ledger veya sync etkilerini taklit ederek doğrulanmış saymaz.

`component_reentry`, kayıttan `operations` ve varsa `name` alıp batch girişine veren **deney tarafı yeniden-giriş işlevi**dir. Gerçek `apply_skill_pending`, CLI/gateway onayı veya production dispatcher değildir. Bekleyen kaydı tüketmez; başarılı T01 sonunda pending sayısının bir kalması bu nedenle ürün kusuru olarak yorumlanmaz.

SPEC, ilk koşudan önce yazıldı. Çalışma statik inceleme sonrasında tasarlanmış keşifsel bir deneydir, holdout değildir. Python 3.13.5 / Linux koşusu UTC `2026-09-08T15:48:02.995262+00:00` başladı. On iki tanılayıcı senaryo çalıştı; G01 içinde on gate varyantı vardır. Bütün gözlem assertion'ları sağlandı. Bu ifade HERMES conformance PASS'i veya araştırma tamamlanması değildir. Testte kurulum, provider/ağ çağrısı, gerçek profil, hesap ya da credential kullanılmadı. Gerçek kaynak modülleri değiştirilmedi.

## 3. Onay kararı, pending kayıt ve gerçek etki ayrı geçişlerdir

**SOURCE OBSERVATION / B 129–155, W 170–185:** Batch önce biçim/ön kontrol yapar; gate sonucu staging ise snapshot veya alt işlem başlatmadan döner. `evaluate_gate` yalnız karar nesnesi üretir. Kalıcı kaydı `stage_write` oluşturur; caller'ın bu adımı gerçekten çağırması gerekir.

**EXECUTED / G01, T01, T05:** Gate-on skills yolu inline callback çağırmadan stage kararı verdi. `evaluate_gate` çağrıları tek başına hiçbir pending dosyası oluşturmadı. Gerçek batch closure'ı ile gerçek store'un taklit adapter üzerinden bağlandığı T01'de bir pending kayıt oluştu; mutator çağrısı ve snapshot kökü sayısı sıfır, canlı dosya başlangıç durumundaydı. Geçersiz batch girişi T05'te gate'e veya store'a ulaşmadan reddedildi.

**Yorum:** Burada işleyen bir geciktirme/ön kontrol düzeni var. Ancak üç ayrı iddia korunmalı: 'stage kararı üretildi', 'kayıt kalıcılaştırıldı', 'hedef değiştirildi'. Önceki U01B'deki disk arızası sonucu yeniden koşturulmadı; bu olumlu kayıt koşusu o arıza sınırını ortadan kaldırmaz.

## 4. Üst düzey hedef adı kabul ediliyor, fakat batch payload'ına taşınmıyor

**SOURCE OBSERVATION / B 31–34, 113–153:** `_validate_batch_ops`, işlem içindeki `name` eksikse `default_name` kullanır. Çözülen hedefler `names` listesine alınır. Buna karşılık batch'in `_staging` closure'ı `{action: batch, operations: operations}` döndürür. Ham işlemler normalleştirilmez, `default_name` payload'a eklenmez. İnsan-okur özet ise çözülen hedef adını içerir.

**EXECUTED / T01–T04:**

| Girdi / kip | Gözlem |
|---|---|
| Her işlemde açık `name`, gate açık | Bir kayıt oluştu; kayıtlı payload ile deney tarafı yeniden-giriş başarılıydı. |
| İşlemde `name` yok, `default_name=alpha`, gate kapalı | Batch çözülen adı taklit mutator'a verdi; dosya değişti. |
| Aynı default-name girişi, gate açık | Kayıt kabul edildi; özet `alpha` içerdi, payload'da hedef adı yoktu. |
| Bu kaydın payload'ı tek başına geri verildi | `operations[0] needs a 'name'` hatası; mutator hiç çağrılmadı. |
| Deney girdisindeki işlemlere ad açıkça eklendi | Aynı iki modülle kayıt ve yeniden-giriş başarılı oldu. |

**Sınırlı bulgu:** Batch'in kendi ürettiği seri hale getirilebilir payload, kabul ettiği default-name girişinin anlamını tek başına korumuyor. Aynı hedefin açıklama metninde bulunması, makinenin kullandığı işlem alanında bulunmasıyla eşdeğer değil. Explicit-name kontrolü ve yalnız girdi normalleştirmesi müdahalesi, sonucu genel bir writer arızasından ayırdı.

**Kapatılmayan soru:** Gerçek üst caller bu girdi biçimini ulaştırıyor mu; `_run_write_gate` veya gerçek replay katmanı hedefi başka yerde zenginleştiriyor mu? Bu kodlar okunamadığı için bütün üründe başarısız onay, yetkisiz işlem veya yaygın arıza iddiası yoktur. Deney adapter'ı eksik caller kanıtı yerine geçmez. Kullanıcı özetini parse etmek bir çözüm önerisi olarak kabul edilmedi; upstream onarımı yapılmadı.

## 5. Gate bypass, batch'in bütün kontrollerini bypass etmek değildir

**SOURCE OBSERVATION / B 137–141:** Validation ve background preflight, gate-bypass kontrolünden önce gelir.

**EXECUTED / T06:** Bypass ContextVar'ı true iken reddeden sentetik preflight çağrıldı ve mutator'a ulaşılmadı. Bypass'ın önceden true olması çağrı tarafından false'a çevrilmedi. R02/R03'te batch'in kendi ayarladığı token normal hata ve istisna sonrasında önceki false durumuna döndü.

**Sınır:** Bu, kontrolün çağrı sırası ve token-restoration davranışıdır; gerçek ownership/pinned/read-before-write guard politikasının doğruluğu değildir. T01'de background origin'den foreground origin'e geçişi harness yaptı. Gerçek approval caller'ın origin'i kaybettiği veya bilinçli değiştirdiği bu deneyle gösterilmedi.

**Araştırma sonucu:** Onay vermek, origin atamak ve belirli gate'i atlamak üç ayrı işlem olarak incelenmeli. İnsan onayı sonrasında farklı guard davranışı, gerçek politika okunmadan ne otomatik ihlal ne otomatik doğru tasarım sayılır.

## 6. Aynı pending kaydı, farklı canlı dosyada farklı önizlem üretiyor

**SOURCE OBSERVATION / W 252–281:** `skill_pending_diff` edit önizlemini o anda bulunan dosyadan kurar. `stage_write` bu örnekte payload, özet, origin ve zaman taşır; kendi eklediği zorunlu bir hedef-içerik hash'i yoktur.

**EXECUTED / D01:** Aynı edit kaydının byte hash'i değişmeden tutuldu. İlk diff `BASELINE → PROPOSED`, canlı dosyaya ayrı fixture değişikliği yapıldıktan sonraki diff `EXTERNAL-WRITER → PROPOSED` oldu. Yazı uygulanmadı.

**Yorum:** Kayıt kimliği, önizlemin dayandığı hedef sürümünün kimliği değildir. Canlı hedefe göre güncel diff üretmek yararlı olabilir; bu davranış tek başına kusur değildir. Ama 'öneri anındaki değişiklik', 'son gösterilen değişiklik' ve 'uygulanan değişiklik' eşitliğini kanıtlamaz. Gerçek UI'nin önizlemi ne zaman yenilediği ve apply-time stale-target kontrolü hâlâ açık. Bu deneyden gerçek bir yarış veya yanlış onay olayı çıkarılamaz.

## 7. Snapshot, telafi ve başka yazarlara karşı izolasyon ayrı özelliklerdir

**EXECUTED / R01:** Snapshot kopyası sentetik hata verdiğinde batch yapılandırılmış hata döndürdü, taklit mutator çağrılmadı, başlangıç dosyası korundu ve geçici snapshot kökü temizlendi. Bu, incelenen yolda 'yedek alınamadan değişikliğe başlama' davranışı olmadığını gösteren olumlu kontroldür.

**EXECUTED / R02:** İkinci işlem normal başarısız sonuç döndürdüğünde ilk değişiklik geri alındı. Kaynak B 164–178 bunu rollback'e bağlar.

**EXECUTED / R03:** İkinci işlem istisna fırlattığında ilk değişiklik kaldı, snapshot kökü temizlendi, gate-bypass token'ı sıfırlandı ve istisna harness'e ulaştı. Alt mutator çağrısı JSON-parse try bloğunun dışındadır; dış yapı `try/finally` kullanır. Bu, önceki U01B sonucunun yeni fixture'daki tekrarıdır; farklı araştırmacı doğrulaması değildir. Gerçek dış caller'ın telafi yapıp yapmadığı açık kalır.

**EXECUTED / R04:** İlk batch yazısından sonra, ikinci işlem hata döndürmeden hemen önce bağımsız bir fixture olayı dosyaya `EXTERNAL-WRITER` yazdı. Batch'in normal rollback'i başlangıç snapshot'ını geri koydu; araya giren yazı korunmadı. Bu gerçek çok-thread koşusu değil, kontrollü ve deterministik bir işlem sıralamasıdır. Kaynak B 60–110, geri alma için dosyaları snapshot içeriğiyle değiştirir.

**Sınırlı sonuç:** İncelenen bileşenin snapshot telafisi, böyle bir araya-girişe karşı diğer yazının korunmasını tek başına sağlamıyor. Bu durumun HERMES'te gerçekten erişilebilir olması için dış kilit, sıraya koyma, tek-yazıcı veya başka koordinasyon yollarının onu engellememesi gerekir. O bağımlılıklar okunmadı. Dolayısıyla 'üretimde veri kaybı kanıtlandı' değil, 'caller izolasyonunun yük taşıdığı bir karşı-sınama var' sonucu geçerlidir.

Hata yanıtı, bypass token temizliği, snapshot temizliği ve dosya telafisi farklı sonuçlardır. Birinin başarılı olması ötekiler hakkında otomatik güven üretmez.

## 8. Farklı arızalar gate kararını farklı değiştiriyor

**EXECUTED / G01:** Foreground memory için kullanıcı `deny` yanıtı blocked; callback yokluğu, bilinmeyen yanıt ve callback'in kendisinin istisnası stage; `once` veya `session` yanıtı allow üretti. Config okuma istisnası ise allow verdi. Skills ve background-memory yolları inline callback'i çağırmadı.

Bu, W 43–51 ve 170–211 içinde doğrudan görülen farklı hata politikalarının bileşen düzeyinde gözlemidir. Config bu modülde isteğe bağlı yazı-onayı tercihi olarak tanımlanır; sonuç buradan genel güvenlik açığına yükseltilmez. Öte yandan zorunlu insan onayına dayanacak bir kullanım kararı verilirse config-load başarısızlığı artık karar-kritik bağımlılık olur ve gerçek caller üzerinden incelenmesi gerekir. Gate'e gelmeden çalışan diğer kontroller bu deneyde değerlendirilmedi.

## 9. Yerel mekanizma modeli ve kanıt sınırı

Bu kesitte savunulabilen geçişler:

`işlem girdisi → hedef çözümleme / ön kontrol → gate kararı → ayrı pending yazımı → kayıtlı payload → yeni bağlamda tekrar ön kontrol → snapshot → alt işlemler → hata türüne göre telafi/temizlik`.

Bu bir HERMES-native genel sistem sentezi değil, iki modüllü küçük mekanizma açıklamasıdır. Özellikle şu boşluklar kapanmadı:

- Gerçek review/curator/foreground girişleri ve dispatch/caller bağlantısı.
- `_run_write_gate`, `apply_skill_pending`, UI önizlem/onay ve pending tüketimi.
- Origin/profile/thread aktarımı ve gerçek guard politikaları.
- Memory mutator, trigger/cancellation, gerçek store kilitleri.
- Audit/ledger, cache, ownership, backup, sync ve sonraki oturumda kullanım.
- Gelecek görevde kalite artışı, gateway/provider/cron/UI/kurulum/eval aileleri.

05 notundaki K01–K09 kontrolleri bütün ürün düzeyinde kapanmış sayılmaz. Bu tur ilgili sorular için yalnız dar gözlem ekler. Foundation, SOUL/Development OS mimarisi, benimseme veya kurulum kararı üretilmedi.

## 10. Sıradaki iş ve durma gerekçesi

İlk kaynak işi değişmedi: sabit pin'deki gerçek caller/dispatch/context ve U01-C curator bağlantısı. Bu turda ortaya çıkan en somut iki ek takip noktası: batch'e `default_name` ile girişin gerçek üretim/replay rotası; snapshot/rollback sırasında diğer yazarları dışlayan kontrolün gerçek yeri.

Erişim yeniden sağlandığında önce bu caller'lar; ardından ledger/store/sync ve sonraki kullanım. Geniş F01–F12 kapsamı korunur. Upstream erişimi açık değilken aynı iki modül üzerinde yeni varyantları sınırsız çoğaltmak ya da yeni belgelerle ilerleme görüntüsü üretmek varsayılan devam yolu olmayacak. Bu dar birim kayıtlandıktan sonra asıl bağımlılığın erişimi yeniden değerlendirilmelidir.

Kaynak erişim hatası ve araştırma bulgusu ayrı tutulur. Mevcut turdaki araştırma teslimi ile repository yayını da ayrı tutulur; canonical STATE güncellendiği ayrıca doğrulanmadan yayın kapanışı iddia edilmez.
