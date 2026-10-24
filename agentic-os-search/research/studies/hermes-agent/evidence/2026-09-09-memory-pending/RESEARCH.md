# U01-M2 — Belleğin kalıcı durumu, canlı görünümü ve bekleyen onayın yaşam döngüsü

**Araştırma tarihi:** 2026-09-09. **Statü:** PINNED SOURCE + BOUNDED FIVE-FULL-MODULE EXECUTION. **Bütün HERMES doğrulaması:** yapılmadı.

Birincil pin `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Kaynak/derinlik otoritesi [SOURCES.md](SOURCES.md), deney ölçütü [SPEC.md](SPEC.md), ham gözlem [RESULT.json](RESULT.json), düzenek [probe.py](probe.py). Bu rapor yeni deneyin yorumudur; ayrı [review kaynak notu](REVIEW-ADMISSION.md) statik kalır.

## 1. Hangi soruyu ilerlettik, hangisini ilerletemedik?

V0.7'nin ilk işi önceki worker-policy deneyinin elle aktarılmış executor/plugins tanımlarını iki tam orijinale karşı AST ile karşılaştırmaktı. Bu iş **tamamlanmadı**: iki büyük dosyanın tam, doğrulanmış yerel kopyaları elde edilmedi ve mevcut `verify_excerpts.py` çalıştırılmadı. GitHub içerik okuması mümkündü; bu nedenle genel kaynak yokluğu veya kalıcı erişim imkânsızlığı iddiası yoktur. Doğrudan indirme yollarındaki başarısızlık ve tam yerel capture'ın tamamlanmaması ayrı kaydedilir.

Gerçek review kaynaklarında ilerleme sağlandı: fork'un ana ajanın toolset parametrelerini miras alması, ayrı whitelist kurulumu, AIAgent constructor yönlendirmesi ve `_load_tools` içindeki geçerli-ad kümesi üretimi okundu. Bu statik ilerleme, önceki seçili işlev deneyini tam entegrasyon testine yükseltmez.

Tek whitelist konusu bütün HERMES çalışmasını tüketmesin diye, mevcut planın sınırlı yön değiştirme seçeneği kullanılarak zaten açık olan bellek M01/M02 ve ortak pending replay sorularına geçildi. Burada büyük dosyalardan seçilmiş işlevler yerine **beş tam kaynak modülü** çalıştırılabildi. Sıra değişikliği ilk işin tamamlandığı anlamına gelmez. Gerçek CLI/gateway/profile bağlantıları da bu deneyin sınırının dışındadır.

## 2. Yürütme nesnesi ve kanıt sınırı

M2-S01 MemoryStore, S02 memory tool, S03 ortak pending komutları, S04 write_approval ve S05 skill_provenance tam dosyaları Git blob kimlikleriyle doğrulandı. M2-S06 lisansı aynı paket içinde korundu. Yürütülen kaynak gövdeleri değiştirilmedi.

Taklit sınırlar açıktır: geçici home, boolean-only config, registry kayıt alıcısı ve hata biçimleme, olmayan terminal onay kanalı, zararsız sentinel tarayıcısı ve `utils.atomic_write_text` yerine kullanılan standart kütüphane temp/rename yazıcısı. Hata senaryosunda bu son yazıcı hedef dosyayı değiştirmeden OSError üretir. Dolayısıyla gerçek yardımcı fonksiyonun bütün hata türleri veya elektrik kesintisi/çökme dayanıklılığı sınanmadı.

Fixture dizinindeki bellek/pending dosyaları gerçektir. MemoryStore'un Linux `fcntl` kilit dalı değiştirilmedi. Fakat N06 iki eski store görünümünün **sıralı** kullanımını sınar; gerçek çok-yazarlı yarış veya bütün platformların kilit güvencesi değildir. Ürün kurulumu, hesap/credential, provider/model isteği, ağ veya gerçek kullanıcı profili kullanılmadı.

Koşu UTC `2026-09-09T08:10:46.824877+00:00`–`2026-09-09T08:10:46.849596+00:00`, Python 3.13.5/Linux. On iki tanılayıcı beklenti karşılandı. Bunlar ürün PASS puanı değil, aşağıdaki ayrımları gözleyen senaryolardır. Önceden yazılmış SPEC, kaynak okumasından sonra oluşturulmuştur: keşifseldir, bağımsız holdout değildir. Aynı araştırmacının tasarımı ve değerlendirmesi ortak hata kaynakları taşır.

## 3. Dosya, canlı store ve prompt snapshot'ı farklı durumlar

**Kaynak:** S01 `load_from_disk`, `_mutate`, `format_for_system_prompt`. **Yürütme:** N01, N02, N04, N06.

N01'de Alpha kaydı Beta ile değiştirildi. Gerçek tool başarılı döndü; dosya ve canlı entries Beta oldu. Önceden oluşturulmuş system-prompt snapshot'ı Alpha kaldı. Açık `load_from_disk` çağrısı sonrasında snapshot da Beta oldu. Bu, normal yazımla snapshot'ın ayrılmasının yalnız doküman ifadesi olmadığını gösterir.

N02'de aynı değişiklik sırasında yazıcı hedefe dokunmadan hata verdi. `_write_file` bu OSError'ı RuntimeError'a çevirdi; doğrudan memory tool hata yükseltti. **Disk Alpha iken canlı entries Beta, snapshot Alpha kaldı.** Nedensel kaynak bağlantısı `_mutate` içindeki sıra ile uyumludur: önce yeni entries nesneye atanır, ardından dosya yazılır. Aynı fonksiyonda yazı hatasında eski entries'ye dönüş yapılmaz.

Bu gözlem önceki 07/M01 sorusunu statik adaydan dar, çalıştırılmış kanıta taşır. Fakat “kullanıcıya başarı denildi” sonucu çıkmaz: doğrudan tool yükseltti; N09'daki ortak command da başarısızlığı raporladı. **Hatanın doğru raporlanması ile bütün bellek görünümlerinin tutarlı kalması farklı özelliklerdir.**

N02'de explicit reload canlı görünümü yeniden Alpha yaptı. Hatasız yeniden deneme dosyayı Beta'ya taşıdı. N09'da sonraki mutasyonun diskten tekrar okuması üzerinden yeniden deneme de başarılı oldu. Bu toparlanma yolları var; ayrışmanın her gerçek caller'da kullanıcı tarafından görülme süresi veya etkisi ölçülmüş değildir.

N04'te tek son kaydın açık single remove ile silinmesinden sonra snapshot eski kaldı. Dolayısıyla yalnız ekleme değil silme/düzeltme de görünürlük araştırmasında gereklidir. Bu deney `format_for_system_prompt` çıktısını ölçtü; hazırlanmış AIAgent prompt'u veya sağlayıcıya giden gerçek isteği ölçmedi.

## 4. Belleğin olumlu korumaları aynı deneyde görülüyor

**Kaynak:** S01 `_mutate`, `_read_raw_checked`, `apply_batch`, `_apply_batch_op`. **Yürütme:** N03–N06, N10.

N03'te limit sekiz karakterken önce Beta ekleyip Alpha'yı kaldıran batch başarılı oldu: geçici toplam sınırı aşsa da **son durum** bütçeye uygundu. Ardından ekleme ve bulunamayan kaydı kaldırma içeren batch hiçbir yeni yazı yapmadan reddedildi. Çalışma listesindeki ara değişiklik diske uygulanmadı. Bellek batch'i ile eski skill batch'inin snapshot/rollback yaklaşımı aynı transaction modeli değildir.

N04'te batch'in son girdiyi kaldırıp tüm belleği boşaltması reddedildi; açık single remove yolu bunu yaptı. Bu davranış bilinçli farklı kabul kurallarını gösterir. “Silme hiçbir zaman mümkün değil” veya “her batch keyfî biçimde boşaltabilir” denmez.

N05'te diskte geçersiz UTF-8 byte'ları bırakıldı. Add bile dosyayı varsayılan boş görünümden yeniden yazmadı: hata döndü, byte'lar korundu, yazıcıya girilmedi. Append yolunda drift kontrolünün atlanması, okunamayan dosya kontrolünün de atlandığı anlamına gelmez.

N06'da ayrı ayrı Alpha'dan yüklenmiş iki store kullanıldı. Birincisi Beta ekledikten sonra ikinci stale store Gamma ekledi; mutasyonun diskten yeniden okuması sayesinde Alpha/Beta/Gamma korundu. İkinci store'un snapshot'ı hâlâ ilk Alpha görünümüydü. Bu, yeniden okumanın sıralı örnekteki etkisini gösterir; bir kilit stres testi değildir.

N10'da onay aşamasına gelmeden fixture'ın **sunulan live store** memory_enabled bayrağı kapatıldı. Gerçek replay target denetimi yazıyı reddetti, pending kaydı korudu. Gerçek config dosyasındaki değişikliğin canlı store'a ne zaman taşındığı sınanmadı; bu nedenle “her UI config değişimini anında uygular” güvencesi verilmez.

## 5. Parametre eşdeğerliği ile kontrol eşdeğerliği aynı değil

**Kaynak:** S02 `memory_tool` alias normalleştirmesi; S01 `apply_batch` ön taraması ve uygulama; `load_from_disk` snapshot taraması. **Yürütme:** N07.

Aynı zararsız sentinel üç biçimde verildi. Single-op `new_text` üst düzeyde content'e çevrildi ve taklit tarayıcı reddetti. Batch `content` alanı da aynı tarayıcıya ulaşıp reddedildi. Batch `new_text` ise uygulama sırasında kabul edilmesine rağmen önceki `content`-odaklı taramaya girmedi; kayıt diske ve canlı entries'ye yazıldı.

Böylece 07/M02'deki kontrol kapsamı farkı, gerçek parser/store yolunda fakat **sentetik denetçiyle** ayırt edildi. Zararlı metin kullanılmadı ve gerçek Hermes tehdit kuralları sınanmadı. Bu sonuç otomatik olarak uygulanabilir saldırı veya bütün bellek güvenliği açığı değildir.

Aynı testte explicit reload yapıldı. Load-time tarama sentinel'i buldu, snapshot'ta `[BLOCKED: ...]` ile maskeledi; ham dosya ve canlı liste, kullanıcı silebilsin diye onu korudu. Yani farklı evredeki koruma da çalıştı. Bu karşı-kontrol dışarıda bırakılsaydı ilk gözlem yanlış biçimde “her reddedilmesi gereken kayıt modele ulaşır” sonucuna yükseltilebilirdi. Bu tur gerçek modele hiçbir istek gönderilmedi.

Açık soru: gerçek schema/transport, doğrudan tool sonucu, current entries gibi diğer görünümler, load-time kontrol ve prompt rebuild birlikte hangi erişilebilir sınırı oluşturuyor? Yalnız alias farkından uçtan uca zarar hükmü verilmez.

## 6. Teklif, uygulanabilirlik, uygulama ve temizleme ayrı aşamalar

**Kaynak:** S02 `_apply_write_gate` / `apply_memory_pending`, S04 stage/list/discard, S03 `handle_pending_subcommand` / `_approve` / `_apply_one`. **Yürütme:** N08–N12.

N08'de background_review kökeniyle bellek değişikliği önerildi. Onay kapısı pending JSON üretti; bellek dosyası değişmedi. Gerçek ortak listeleme `[auto]` gösterdi. Sonrasında fixture'ın foreground bağlamında ortak approve komutu çalıştı: payload gerçek store'a uygulandı, pending silindi, dosya/canlı entries değişti, snapshot eski kaldı. Gerçek provenance fonksiyonu yazıcı girişinde foreground döndürdü.

Böylece **önerinin kökeni ile uygulayan çağrının bağlamı** bu dar zincirde ayrıldı. Metadata origin'inin replay'de yeniden bağlanmaması kaynakla uyumludur. Ancak insan onayı sonrası mevcut caller yetkisiyle uygulama tasarım tercihi olabilir. Gerçek onaylayan kişi, UI yetkilendirmesi, profil seçimi veya ihlal bu deneyde doğrulanmadı.

N09'da pending uygulanırken yazıcı hatası eklendi. Ortak command `Approved 0` ve hata metni verdi; pending kaydı silinmedi. Disk/canlı entries ayrışması buna rağmen oluştu. Başarılı retry dosyayı güncelledi ve kaydı kaldırdı. “Başarısız işlemin kaydı tutulur” ile “başarısız işlem bütün canlı durumu geri alır” ayrı sözleşmelerdir.

N11'de yazı başarılı olduktan sonra yalnız ilgili pending dosyasının unlink'i hata verdi. S04 hatayı loglayıp False döndürdü; S03 bu dönüşü başarı sayımına katmadığı için kullanıcı metni **Approved 1**, gerçek pending sayısı **1** kaldı. Etki gerçekleşmişti; inceleme kuyruğundan çıkarma gerçekleşmemişti. İkinci onayda add'in duplicate kontrolü aynı kaydı bir daha eklemedi ve unlink düzeldiğinde pending temizlendi.

Bu durum genel exactly-once güvencesi veya tüm tekrarların zararlı olduğu iddiası değildir. Olumlu add idempotence örneği ile kuyruk temizleme başarısızlığı birlikte tutulur. Replace/remove/batch için stale replay, süreç çökmesi ve farklı UI'lerdeki sonuçlar açık kalır. UI yalnız “Approved” metnine bakarsa kaydın kapandığını varsayabilir; bu bir sonraki gerçek caller araştırmasının sorusudur, test edilmiş UI kusuru değildir.

N12'de biçim olarak liste olan fakat bilinmeyen action içeren batch onay için saklanabildi. Gerçek apply aşaması işlemi reddetti, dosya değişmedi ve pending korundu. Bu da **staged success'in semantik uygulanabilirlik doğrulaması olmadığını** gösterir. Bütün batch denetimlerinin staging'den önce olduğu varsayılmamalıdır.

## 7. Yerel mekanizma modeli ve araştırmaya etkisi

Yeni kanıt şu yerel zinciri ayrıştırıyor:

`öneri girdisi → kapı kararı → pending kaydı → onay komutu → target/işlem doğrulaması → diskten yeniden okuma → canlı aday → dosya yazımı → sonuç raporu → pending temizleme → snapshot yenileme → gerçek sonraki kullanım`.

Bu adımların hepsi tek bir başarılı commit veya tek bir success alanıyla temsil edilmiyor. Bazı sınırlar güçlü: bozuk dosyayı koruma, başarısız semantik batch'te no-write, target bayrağını tekrar kontrol etme, diskten yeniden okuma ve hata sonucunda pending'i koruma. Bazıları ayrışabiliyor: write failure sonrası disk/live; success report ile pending cleanup; kabul edilen parametre alias'ı ile pre-scan; file/live update ile frozen snapshot.

Bu HERMES-native bir mekanizma okumasıdır. Yeni Foundation taxonomy'si, SOUL mimarisi, Development OS uygulama kararı veya HERMES benimsemesi değildir. Öğrenilmiş bilginin gelecekteki görev kalitesini artırdığına dair deney yapılmadı.

## 8. Devam ve kapanış sınırı

Bu on iki senaryoyu yeniden sayıca büyütmek ilk yüksek değerli hareket değil. Sonraki anlamlı kaynak zinciri gerçek CLI/gateway pending caller'ının hangi live/fresh store'u, hangi aktif home/profili ve hangi onaylayan bağlamını kullandığıdır. Ardından compression/rebuild/reload ve gerçek gönderim hazırlığıyla dosya/live/snapshot/istek ayrımı bağlanmalıdır. N09/N11 artık bu uçların hata senaryolarını seçmek için somut girdidir.

D2-FIDELITY ve full worker integration açık ve ayrı takip edilir. Üretim yetki açığı, current upstream davranışı veya bu bulgunun tasarıma dayanak olması tartışılacaksa bu açık doğrulamaya geri dönülmeden iddia yükseltilmez. Araştırma genel mekanizma öğrenimi kapsamında ilerlerken bu tek konu sonsuz yan dala dönüşmez. Ledger/backup/restore/sync, skill/cache yükleme, curator batch/report/cron ve F01–F12 genişliği korunur.

Bu turun teknik sonucu yeni ve çalıştırılmıştır; canonical yayın durumu ayrıca değerlendirilmelidir. Dosyanın yerel varlığı veya ZIP'e konması, main'de yayımlandığı anlamına gelmez.
