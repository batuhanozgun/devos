# U01-D3 — Review kabulü, kaynak seçkisi ve middleware hata sınırları

**Tarih:** 2026-09-09. **Pin:** `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.
**Statü:** PINNED SOURCE TRACE + MANUAL-RANGE AST CROSS-CHECK + EXACT MIDDLEWARE COMPONENT EXECUTION.
**Tam ürün / güvenlik / öğrenme kalitesi doğrulaması değildir.** Kaynak/sınır otoritesi [J defteri](SOURCES.md); yeni ham sonuçlar [middleware](MIDDLEWARE-RESULT.json) ve [seçki](RANGE-FIDELITY.json).

## 1. Bu tur hangi boşluğu ilerletti?

Önceki U01-D2, gerçek executor ve whitelist tüketicisinden elle aktarılmış seçili işlevleri çalıştırmıştı. Tam dosya sadakati ve gerçek review kurulumunda başka bir kontrolün bu sonucu engelleyip engellemediği açık kalmıştı. Bu tur üç farklı iş yapıldı; statüleri birleştirilmeyecek:

- E01/E02'nin yeniden okunan sabit kaynak aralıkları eski seçkilerle karşılaştırıldı. 22 tanım AST düzeyinde eşleşti; bu tam-original doğrulama değil.
- Gerçek review constructor/fork, geçerli-ad kümesinin üretimi, aradaki tool-round ve Relay adapter kaynakları incelendi. Bu statik bağlantı araştırmasıdır.
- Tam dosya kimliği doğrulanmış gerçek middleware modülünde sekiz yeni hata/çağrı senaryosu çalıştırıldı. Çevredeki registry ve callbacks sentetiktir; eski C/V koşularının tekrarı değildir.

Ana araştırma HERMES'i anlamaktır. Bu notun amacı açık bir güvenlik kusuru iddiasını zorla doğrulatmak, upstream onarımı önermek veya projeyi sadece hata avına çevirmek değildir.

## 2. Seçki sadakati: olumlu ama daha dar bir kontrol

**OBSERVED CHECK:** J01/J02'nin sabit pin'den tekrar alınan aralıklarından karşılaştırma dosyaları oluşturuldu. Eski worker-policy seçkilerinin kendi blob kimlikleri doğrulandı. 15 executor ve 7 plugins tanımı, docstring/decorator dahil, konum bilgileri dışarıda bırakılarak AST ile karşılaştırıldı; hepsi eşleşti. Bir directive literal'inin kasıtlı değiştirilmesi karşılaştırmayı başarısız kıldı.

**AÇIK SINIR:** Büyük orijinallerin tamamı yerelde otomatik alınamadı. Yeni aralıklar da assistant tarafından transkribe edildi; eski ve yeni kopyanın ortak hata riski var. Bu yüzden `verify_excerpts.py` için gereken tam-original Git blob kontrolü ve onun tam kaynak koşusu yapılmış sayılmaz. İlk ad-hoc eşitlik SPEC yazılmadan önce görülmüştü; kayıtlı checker keşifsel cross-check'tir, bağımsız veya ön-kayıtlı holdout değil. Bu ayrımlar ham JSON'a da yazıldı.

**SONUÇ:** Eski deneydeki seçili algoritmaların yanlış kopyalandığı açıklamasına karşı daha fazla destek elde edildi. Fakat bunun gücü tam byte-orijinal karşılaştırması veya tam ortam entegrasyonundan düşüktür. Eski kanıt değiştirilmedi; onun kapsamı geriye dönük büyütülmedi.

## 3. Gerçek review kurulumu iki ayrı araç kümesi kullanıyor

**SOURCE OBSERVATION — J03:** `_fork_init_kwargs`, parent'ın `enabled_toolsets` ve `disabled_toolsets` değerlerini yeni AIAgent constructor'ına geçiriyor. `build_cache_parity_fork` bu constructor'dan sonra review kökenini, paylaşılan built-in memory store'u, persistence detachment'ı ve aynı-model durumunda cached prompt'u kuruyor. `_review_tool_whitelist` ise memory/skills araçları, read_file/search_files ve yapılandırılmış ekstralardan ayrı bir dispatch listesi üretiyor. `_run_review_fork`, bu listeyi kendi thread'inde kurup conversation çağrısının sonunda temizliyor.

**SOURCE OBSERVATION — J04:** `_load_tools`, seçilmiş toolset'lerden şemaları alıp `valid_tool_names` kümesini doğrudan bu şemaların adlarından oluşturuyor. İncelenen review kurulumunda bu küme dar review whitelist'iyle kesiştirilerek yeniden atanmış değil. Upstream, geniş advertised tools[] listesini prompt-cache eşliği için koruduğunu açıkça anlatıyor; ileri sürdüğü maliyet yüzdeleri bu tur doğrulanmadı.

**SINIRLI ÇIKARIM:** “Gerçek constructor belki zaten dar review adlarını üretip sorunu baştan engelliyor” rakip açıklaması, incelenen standart kurulum yolunda destek bulmuyor. İki liste aynı soruyu cevaplamıyor: birincisi tanınan/advertised araçlar, ikincisi bu bakım işi için dispatch izni. Parent'ın geniş bir araç kümesine sahip olmadığı durumda elbette fark küçülebilir; opsiyonel plugin/runtime değişimleri ayrıca değerlendirilmeli.

Bu, modelin mutlaka yasak bir çağrı üreteceğini, her aracın sonraki güvenlik kontrollerini aşacağını veya bu davranışın üretimde gerçekleştiğini göstermez. Review'un ayrıca non-interactive dangerous-command auto-deny callback'i vardır. Beceri mutator'ının kendi origin/read-before-write/ownership guard'ları da ayrı kalır. Tek whitelist'in aktarım sınırı, bütün güvenlik mekanizmalarının yokluğu değildir.

## 4. Tool-round'un yeni görünür halkası: kabul, kalıcılık ve yürütme

**SOURCE OBSERVATION — J05:** `run_tool_round` önce gerçek name/JSON validator'ını çağırır; mixed batch'te tanınmayan adları hata sonucuna çevirip yürütmeden çıkarır. Sonra assistant tool-call mesajını oluşturup tool etkisinden **önce** session flush yapar. Flush açıkça başarısızsa veya exception üretirse dispatch'e geçmez. Kullanıcıya interim mesajı ancak bu kontrolden sonra yansıtır.

Yürütme sonrası ayrı persistence-failure işareti sonraki model isteğini ve sonraki akışı durdurabilir. Ancak bu ikinci noktada tool etkisi daha önce gerçekleşmiş olabilir. “Sonuç kalıcılaştırılmadı” ile “tool hiç çalışmadı” aynı durum değildir. Review'un persistence-disabled ayarı ayrıca farklı bir bağlamdır; normal session durability sözleşmesini birebir review'a taşıyamayız.

**SINIR:** Bu modül bu tur tam okundu, çalıştırılmadı. Gerçek DB arızası deneyi veya bütün `_execute_tool_calls` bağımlılık kapanışı yok. İncelenen round modülünde ayrıca review whitelist rebind'i görülmedi; görülmeyen başka modüller için yokluk hükmü verilmez.

## 5. Relay dalı, tek bir sabit yürütme yolu varsayımını sınırlıyor

**SOURCE OBSERVATION — J06:** `relay_tools.execute`, runtime/session yoksa veya managed execution etkin değilse callback'i doğrudan çağırıyor. Managed dalda ise ContextVar kopyası, managed callback guard ve async session çalıştırması devreye giriyor. Callback'in kendi hatası ile callback başarılı olduktan sonraki Relay postprocessing hatası ayrı işleniyor; bazı postprocessing hatalarında elde edilmiş asıl sonuç korunuyor.

**SINIRLI ÇIKARIM:** “Relay her zaman ek whitelist kurar” veya “Relay hiçbir koşulda sonucu değiştiremez” denemez. Adapter içinde böyle bir whitelist kurulumu görünmüyor, fakat `relay_runtime`/`relay_llm` ve gerçek managed runtime burada kapatılmadı. U01-D2'nin sentetik Relay'i gerçek managed execution'a genellenmiyor. Konfigürasyona bağlı dallanma, tam erişilebilirlik hükmünün neden hâlâ koşullu olduğunu açıklar.

## 6. Gerçek middleware modülünün sekiz tanılayıcı sonucu

J07 tam 9277 byte kaynak olarak, beklenen Git blob'uyla eşleştirildi. İlk transkripsiyondaki eksik boş satır importtan önce yakalanıp canonical kaynağa dönülerek düzeltildi. Sonra SPEC yazıldı ve gerçek `run_tool_execution_middleware` / `_run_execution_chain` çalıştırıldı. Registry storage, callback'ler ve handler sentetik; handler yalnız bellekte işaretleyici üretir.

| Durum | Gerçek middleware sonucu | Handler girişi |
|---|---|---|
| MW01 — middleware yok | Girdi ve sonuç normal geçti. | 1 |
| MW02 — middleware `next_call` öncesinde exception | Uyarı loglandı; zincirin sonraki kısmına devam edildi. | 1 |
| MW03 — middleware next'i çağırmadan sonuç döndü | Short-circuit sonucu korundu. | 0 |
| MW04 — downstream handler exception | Orijinal exception dışarı çıktı; otomatik tekrar olmadı. | 1 |
| MW05 — next başarılı, sonra middleware exception | İlk başarılı handler sonucu geri döndü; yeni çağrı yapılmadı. | 1 |
| MW06 — başarılı next'ten sonra ikinci next girişimi | İkinci çağrı engellendi; uyarı loglandı; dışarı ilk başarılı sonuç döndü. | 1 |
| MW07 — dış callback argüman değiştirdi, iç callback erken hata verdi | İç hata atlandı; handler değiştirilmiş girdiyi bir kez aldı. | 1 |
| MW08 — next öncesi özel BaseException | Abort dışarı çıktı; skip-and-continue uygulanmadı. | 0 |

Sekiz beklenti karşılandı. Ek bozuk kaynak kopyası gerçek import guard'ı tarafından reddedildi; o modül import edilmedi. Bunlar ürün PASS testleri veya hata sıklığı değildir. Kaynak informed, keşifsel ve küçük durum kümesidir. C01–C14/V01–V05 yeniden çalıştırılmadı.

### 6A. Olumlu mekanizma

Middleware, downstream başarısını hatırlayarak bazı üst katman hatalarında tool'u tekrar çalıştırmıyor. Alt çağrının exception'ını kendi callback hatasından ayırıyor. Tek kullanımlık `next_call` sınırı tekrarlı etkiyi önlüyor. Bu, yalnız yorum değil, belirtilen gerçek modülde gözlenmiş davranıştır.

### 6B. Kontrol rolü ile hata politikası aynı tasarım kararı değil

Kendi hatasını next'ten önce veren callback skip-and-continue oluyor. Bir eklenti yalnız kolaylaştırıcı/advisory ise bu liveness tercihi anlamlı olabilir. Aynı extension noktası zorunlu authorization denetçisi olarak kullanılacaksa erken hata sonrasında devam etmek farklı bir güvence doğurur. Bu not gerçek bir zorunlu eklentinin hatalı yapılandırıldığını iddia etmez; **callback rolü ile error contract'ının birlikte değerlendirilmesi gerektiğini** gösterir. Eklenti short-circuit ederek engelleyebilir; bütün callback'ler ve bütün exception tipleri “fail-open” diye tek etiketlenmez.

### 6C. Eski duplicate-callback ifadesine önemli kapsam düzeltmesi

U01-D2, seçili executor'ın ikinci authorized callback girişinde hata verdiğini göstermişti. Yeni gerçek middleware katmanında, ikinci `next_call` teşebbüsünün kendi RuntimeError'ı ilk next başarılıysa dışarı yeniden fırlatılmayabiliyor; ilk sonuç korunuyor. İki sonuç çelişmek zorunda değil: farklı katmandaki farklı tekrar kapıları inceleniyor. Ortak güvence tek handler etkisidir; dışarı exception çıkacağı garantisi değildir.

Bu nedenle yalnız exception/no-exception veya `dispatched` alanı değil; callback giriş sayısı, kabul/ret kararı, handler girişi, elde edilmiş sonuç ve log birlikte okunmalı. Handler giriş sayısı bu fixture'ın etki oracle'ıdır; gerçek dosya/network/ledger atomikliği hakkında tek başına güvence vermez.

## 7. Q26/Q29 için güncel hüküm ve kalan kanıt

**Desteklenen:** standart review kurulumu parent toolset'lerini ve schema-derived valid names'i koruyor; dar review yetkisi ayrı thread-local listede kuruluyor. Önceki seçili worker deneyi, liste taşınmadığında kendi gerçek tüketicisinin bunu görmediğini göstermişti. Yeni range cross-check seçkilerin sadakatini sınırlı olarak destekliyor. Gerçek round ve middleware kaynakları ana hattaki açıklanmamış geçişlerin bir kısmını açıyor.

**Henüz desteklenmeyen:** bütün PluginManager/Relay/AIAgent/executor bağımlılıklarıyla üretim yolunun eksiksiz koşulduğu; every caller için aynı erişilebilirliğin geçerli olduğu; zarar veya olay oranı; bütün onay/guardrail/skill kontrollerinin aşıldığı; genel HERMES güvenlik ya da öğrenme kalitesi hükmü.

Tam orijinal E01/E02 hash + AST kontrolü hâlâ açık; bu tur sınırlı range karşılaştırması onun yerine gizlice geçirilmedi. Tam runtime claim gerektiğinde gerçek konfigürasyon, plugin registries, review/fork kurulumu ve zararsız handler ile daha üst sınama gerekir. Yeni bağımlılık elde edilmeden aynı sentetik C/V fixture'larını çoğaltmak bu kanıtı üretmez.

## 8. Çalışma yönü ve durma ölçütü

U01-D'nin bütünü kapanmış değildir. Fakat mekanizma artık named source/caller/worker/control/error ayrımlarıyla savunulabilir bir kısmi açıklamaya sahip. Plan v0.7'nin izin verdiği sınırlı geçiş uygulanır: **Q26'nın güçlü entegrasyon hükmü açık tutulur; sıradaki aktif kaynak işi gerçek CLI/gateway pending onayı ve profil/store bağlamıdır.** Bu bir “güvenlik sorusu çözüldü” kararı değil, aynı dalın HERMES'in geri kalanını tüketmesini önleyen araştırma sıralamasıdır.

Sıradaki soru: `/memory` veya `/skills` pending onayını gerçek kullanıcı yüzeyinde hangi aktör, hangi aktif home/profil ve hangi canlı/yeni store üzerinden uygular? Ortak D17/D15 dosyası UI caller'ı yerine geçmez. U01B2 default_name replay, preview/hedef sürümü ve rollback/diğer-yazar soruları buna bağlanır. Ardından memory M01/M02, ledger/backup/sync, skill/cache ve curator batch/report/cron gelir.

F01–F12 geniş kapsamı, önce HERMES-native model sonra dört-alan/SOUL/Development OS değerlendirmesi sırası korunur. Bu tur kurulum, provider/credential kullanımı, upstream değişikliği, Codex işi, Foundation veya mimari/adoption çalışması yapmaz. Sonuçların repoya kaydı ayrı olarak ref/content readback ile kapanmalıdır.
