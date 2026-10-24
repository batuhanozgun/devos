# U14-B — Güncelleme, korunmuş durum ve yeniden etkinleştirme

**2026-09-13 / Q58-B / PINNED SOURCE STUDY, NOT EXECUTED.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest0.21.0. [A kurulum](INSTALL-AND-ACTIVATION.md), [A kaynakları](INSTALL-SOURCES.md), [B kaynakları](UPDATE-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md). Bu çalışma actual installer/updater, process/DB/model veya test koşusu değildir. Kaynak sözleşmesi, kaynakta uygulanan kontrol ve gözlenmiş saha sonucu ayrı tutulur.

## 1. Kapsam ve A'dan devir

U14-A `c0d6418817e512137567e32c8d5aeabdb006f8f3` main'e bağlandı; actual ref, üç-path compare ve A araştırması/kaynakları/STATE tam içerikleri geri okundu. Ancak sonra B başladı. A'nın iki metni burada değiştirilmez. Bu dilim yeni bir installation değil, **mevcut kurulumu değiştirme yetkisi → eski durumun korunması → kaynak/bağımlılık geçişi → yeni çalışanın etkinleşmesi → değişimin raporlanması** zincirini inceler.

Q58'in geniş açıklama hedefi yalnız risk listesi değildir. HERMES'in kendini değiştirirken hangi nesneyi yerinde değiştirdiği, hangisini yeniden başlattığı, hangisinin kalıcı verisini koruduğu ve hangi işlemi başka yöneticiye bıraktığı açıklanmalıdır. Normal Git update yolu, image/package refusal ve kesilmiş dependency/restart işi karşı okunur; Windows/Nix/desktop ekosisteminin tamamı otomatik kapsam değildir.

## 2. Aynı komut her kurulumda aynı değişimi yapamaz

`main.py::cmd_update` önce `_update_preflight_handled` ile yönetilen ortam, read-only plan, install-method kabulü ve check kipini ayırır. `--plan`, image/package refusal'dan önce envanteri raporlayabilir; apply yerine geçmez. `--check` de yalnız yerel Git durumunu evrensel update authority saymaz. [S05-B,S07,S08]

`evaluate_update_admission`, baked image provenance marker varsa önce onu değerlendirir. Marker mevcut fakat bozuksa yerinde değişim izni vermek yerine refusal döndürür; geçerli marker manager yolunu gösterir. Ardından Docker/Nix/apt heuristikleri vardır. Ancak bu **her türlü bilinmeyende fail-closed** teoremi değildir: marker okuyucu exception'ında heuristiklere dönülür; o katman da sonuç vermezse None/eligible olabilir. Alt provenance authenticity ve install-method detection gövdeleri bu B'de tam araştırılmadı. [S08]

Ret, amaç başarısızlığıyla aynı nesne değildir: `UpdateRefusal` kodu, açıklaması ve önerilen başka güncelleme mekanizması; CLI'da exit2 ve best-effort refused receipt taşır. Bu, kurulumun değişimini image veya paket yöneticisinin üstlenmesi gerektiğine dair native sorumluluk sınırıdır. Kullanıcıya canlı update komutu çalıştırma tavsiyesi verilmedi; yalnız inspected implementation anlatılır.

## 3. Güncelleme kilidi ile toparlama kilidi aynı garanti değildir

Apply sargısı `UpdateLock` alır; kendinden önceki updater'ın markeri varsa holder bildirimiyle reddedebilir. Process-home kullanılması, context-local profile'ın Rust/Electron ile farklı dosyaya bakmasını önlemeyi amaçlar. Parent handoff PID'si veya process ancestry, çocuğun aynı orchestrating claim altında çalışmasına izin verir. Release yalnız kendi marker PID'sini gördüğünde kaldırmaya çalışır. [S05-B,S13]

**Alt mekanizma sınırı:** `acquire` önce marker'ı okur, sonra normal `Path.write_text` ile yazar. Arada exclusive create veya atomic compare-and-swap yoktur. İki kabulün aynı eski/boş görünümü okuyup iki kez olumlu dönmesi kaynak interleaving'iyle mümkündür; actual concurrent updater koşusu yapılmadı. Marker yazılamazsa da True dönülebilir. Ayrıca yaş tavanını aşan marker, PID canlı olsa bile eski kabul edilebilir. Bu nedenle isim/docstring'deki cross-process mutual exclusion ifadesi koşulsuz atomik kilit ispatı değildir. [S13]

Buna karşılık `_early_recovery._claim_recovery_lock` ayrı dosyayı O_CREAT|O_EXCL ile oluşturur: normal creation yarışında daha güçlü farklı bir mekanizma. Fakat o da stale-age temizliği ve bazı OSError koşullarında unlocked devam içerir. İki dosyanın ikisine de lock denmesi aynı failure/ownership sözleşmesini taşıdıklarını göstermez. Bütün Rust/Electron katmanları ve OS/file-lock davranışı bu kaynak okumasıyla doğrulanmış değildir. [S14]

## 4. Değişimden önce ne korunuyor?

Update options, ortam yeniden kurulmadan önce etkin lazy özellikleri ve explicit tool dependencies'i yakalamaya çalışır; sürüm metni de pull öncesinde alınır. Runtime inventory ise var olan süreç/profil/supervisor/code identity iş listesidir. Bu discovery başarısızsa None veya boş görünüm gelebilir; görünmemesi hiçbir özellik/süreç olmadığına otomatik kanıt değildir. [S07,S12]

Yedekleme default quick snapshot, full veya off olarak çözülür. Quick yol seçili kritik veriyi ve sibling profile snapshot'larını çağırır; büyük dosyalar için boyut sınırı vardır. Full kip buna ayrıca home arşivi ekler. **Backup başarısızlığı veya explicit off güncellemeyi mutlaka durdurmaz.** Receipt'teki backup=false, bütün değişim reddedildi anlamına gelmez. [S09]

Checkout dirty dosyaları, yerel commit geçmişi ve kullanıcı home verisi farklı koruma nesneleridir. Stash/park/restore/discard politikası birincisini, branch/merge/rescue-ref ikincisini, home snapshot/DB restore üçüncüsünü ele alır. Bir stash SHA'sı bütün kullanıcı verisinin yedeği; snapshot ID'si bütün source/runtime değişiminin geri alınabilirliği değildir. B'nin backup/restore anlatımı caller ve seçili guard düzeyindedir; tam backup serializer veya dosya içeriği doğrulanmadı. [S07,S09]

## 5. Git işlemi başarılı mı, doğru çalışma ağacı mı etkin?

Update, scoped fetch ve branch durumundan sonra current checkout planı kurar. Park edilmiş branch için contents/policy değerlendirmesi; izin varsa target'a geçiş veya in-place merge, güvensizse ret vardır. Detached HEAD özel ele alınır. Fork'ta origin'e göre sıfır fark bulunması official upstream'in kontrol edildiği anlamına gelmez; upstream sync HEAD'i ilerletirse dependency/restart aşamalarına düşmesi için fark yeniden hesaba katılır. [S07]

Fast-forward olmazsa farklı durumlar ayrılır: custom branch'e merge ile local commits korunmaya çalışılır; aynı branch divergence reset yoluna gidebilir; ortak atası olmayan history için rescue ref denenir. Rescue yazı hatası kaynakta nonfatal olabilir ve açık uyarı üretir. Bu nedenle “yerel değişiklikler korundu” ifadesi hangi alan, koşul ve geri-dönüş nesnesinin mevcut olduğu belirtilmeden genellenemez. [S07]

Pulled critical dosyalarda syntax guard ve pre-pull SHA'ya rollback girişimi bulunur. Kontrol sınırlı dosya kümesini derler; eksik path atlanabilir. Syntax parse, bütün imports/dependencies veya ürün davranışı değildir. `_verify_head_after_pull` ayrıca no-op HEAD'i ve yanlış branch'i reddeder; komut exit0'ı tek başına code-updated makbuzu yapmaz. [S07]

Bu rollback Git ağacına aittir. Daha önceki kullanıcı verisi, helper yan etkileri, yeniden çözülmüş paketler ve çalışan process'ler üzerinde tek atomik geri dönüş kurulduğu gösterilmedi. Stash restore ve code validation farklı sıra/koşullar taşır; B bütün restore guard'larını yeniden sınamadı.

## 6. Diskte yeni kod, bellekte eski çalıştırıcı

Updater pull'u gerçekleştiren eski Python process'inde çalışmaya devam eder. Yeni dosyalar yüklenirken eski sys.modules graph'ının etkisi bu yüzden maddidir. Kod selected cache/bytecode sweep, runtime-module reload ve family purge uygular; updater'ın kendi lock/receipt/plan class state'ini taşıyan module ailesini purge'den özellikle korur. Running frame'lerin eski module nesnelerini tutabileceği de kaynakta açıktır. [S07,S09]

Bu koruma yalnız cache temizliği değildir: **değişimi yöneten kontrol durumu ile değiştirilen uygulama kodunun farklı yaşam ömürleri** vardır. Receipt singleton'ının veya plan class identity'sinin yanlışlıkla yeniden yaratılmaması amaçlanır. Ancak seçili purge/reload bütün process graph'ının atomik yenilendiği anlamına gelmez. Gateway/serve uzun yaşayan process'lerinin ayrıca restart edilmesi bundandır. Gerçek eski/yeni modül karışımı bu tur gözlenmedi.

## 7. Dependency aşaması ve üç ayrı yarım iş

Post-pull dependency consumer; venv ownership preflight, loaded-native self-lock deferral, core marker, actual reinstall veya dar diff-based skip, core/console kontrolleri, lazy refresh ve tool/memory-provider restoration sırasını taşır. Install-defining dosyalar değişmediyse editable reinstall atlanabilir; yine verifier yardımcıları çağrılır. Bunların exact dependency çözümü bu B'de çalıştırılmadı. [S12]

Native self-lock yüzünden kod değişmişken dependency yazımı ertelenebilir. Bu ret “hiçbir şey değişmedi” demek değildir; `.update-incomplete` sonraki yeni process'e kalan işi taşır. Core completion sonrası bu işaret temizlenir; lazy refresh ayrı `.lazy-refresh-incomplete` işaretiyle izlenir. Pull sonrası fleet restart ihtiyacı ise ayrı `fleet_restart_pending` durumudur. Core import probe'unun iyi olması bu diğer iki yükümlülüğü otomatik kapatmaz. [S07,S10,S12,S14]

`_early_recovery` main'in üçüncü-taraf importlarından önce çalışır. Marker yoksa hızlı çıkar; source manifest yoksa o yolu üstlenmez. Core marker'ın sahibi hâlâ canlıysa rakip update'i çalıştırmaz; sahibi yoksa pending core helper'ını, bu girişin kendisi update olsa da çağırabilir. Lazy marker'da update argv'si farklı davranır: aktif update'in işini erken import-probe'uyla yeniden sahiplenmez. Normal lazy repair belirli modül/attribute ve cert bundle probe'larını kullanır; repair sonrası tekrar sınar. [S14]

Önemli comment/gövde farkı: genel docstring “marker VE broken import probe” çerçevesi verir, fakat **pending core install dalı bu dar probe'u beklemeden** bütün core-install helper'ını çağırır. Bu, self-lock nedeniyle henüz kurulmamış değişimi yalnız eski paketlerin import olmasına bakarak atlamamayı sağlar. Bounded retry cap ve farklı post-import recovery'ye bırakma vardır; helper success veya marker unlink fiziksel bütün kurulum doğruluğu sayılmadı. `_install_repair.run_core_install` ve post-import tam recovery ayrıca açık alt sınırlardır.

## 8. Her başarısız kontrol aynı güncelleme kararını üretmiyor

Critical syntax ve current HEAD kontrolleri bazı yollarda akışı keser. Buna karşılık dependency refresh sonundaki critical-module import sorunu uyarı olarak kalabilir; rollback yapılmaz. Import probe'unu başlatamayan bazı hata yolları da failure sözlüğü üretmeyebilir. Tek bir “health check” başlığında bu farklı ret/uyarı/grace yollarını eşitlemiyoruz. [S07,S12]

Next-runtime SQLite probe'unda sonuç alınamazsa completion'a izin veren grace dalı bulunur; olumlu tanınan uyumsuzluk başka davranır. Fleet'te version unknown satırı da yalnız raporlanıp tek başına ret üretmez. Buna karşılık **gateway beklenirken hiçbir fleet satırı gelmemesi** ayrı üst kontrolle incomplete sayılabilir. Bilinmeyenin nasıl ele alınacağı kaynakta aynı sisteme yayılmış tek sabit kural değildir. Burada SQLite vulnerability veya güncel ürün security hükmü vermiyoruz; kontrolün return semantics'i incelenmiştir. [S09–S11]

## 9. Değişen kodun çalışan hizmete devri

Normal update, pre-update runtime inventory ve restart öncesi PID görünümünü tutar; platformun declared supervisor'ı, mapped manual process ve yetkisi sınırlı serve/dashboard yollarını ayrı ele alır. Restart denemesi, denetimli replacement ve bilinçli manual stop farklı outcome kayıtlarıdır. Exception sonrası fresh-child recovery'de de attempted ile verified ayrı tutulur. Alt systemd/launchd/Windows servis uygulamalarının tamamı okunmuş değildir. [S07,S10]

`collect_fleet_versions` gerçek consumer'ı active gateway control socket identity'sini tercih eder; olmazsa runtime status dosyası ve PID liveness kullanır. Runtime'ın code_sha değeri current checkout SHA'sıyla karşılaştırılır. Eksik SHA unknown, farklı SHA stale; update öncesinde vardı fakat replacement yoksa belirli koşullarda down satırı kurulur. Bare PID snapshot'ının incarnation sınırı korunur; socket cevabı ve dosya kaydı eş güçte veya bütün fonksiyonel health kanıtı sayılmaz. [S11]

Üst verifier, gerektiğinde bounded settle penceresiyle yeniden gözler. Stale/down, beklenirken boş matrix ve planlanan ama outcome'da hesaba katılmamış runtime incomplete üretir. **“Eski process artık yok” tek başına başarılı restart değildir**: önceden vardıysa replacement doğrulaması gerekir. Serve/dashboard eski-generation survivor'ları gateway matrix'ine karıştırmadan ayrı hesaba katılır. Bu native kontrol, yalnız restart komutu exit0'ına güvenmekten daha geniştir. Gerçek process veya network sağlığı bu tur sınanmadı. [S10,S11]

## 10. Banner, otomasyon exit-code'u ve kalıcı makbuz ayrı tüketicilerdir

Gateway-mode update marker'ı restart'tan önce yazılabilir; restart updater'ın process grubunu kapatabileceği için erken bir faz sonucu taşır. Sonraki fleet phase olumsuz sonucu ayrıca işleyebilir. Bu erken marker'ı bütün update'in son durumuyla özdeşleştirmiyoruz. [S07]

`_print_update_summary`, Node refresh başarısızlığında partial metni basabilir; fakat return boolean'ı yalnız desktop rebuild ve SQLite koşuluna bağlıdır. `node_failures` bazı sonraki işlemleri etkiler, fakat bu boolean'da yoktur. Ayrıca `_verify_fleet_after_update` receipt'i restart.incomplete **veya** update_complete=False ile partial yaparken sys.exit1 kapısını yalnız restart.incomplete'a bağlar. Dolayısıyla koşullara göre **partial receipt ile normal command return**, ya da **partial uyarıyla success receipt** kaynak zinciri içinde ayrışabilir. Bu actual yanlış güncelleme/ekran gözlemi değildir; ilgili dal girdilerinin gerçekleşmesi ayrıca ölçülmelidir. [S09,S10,S05-B]

Receipt katmanı steps/skips ve pre/post kimlikleri saklar; outcome'u bütün step boolean'larını kendisi toplayarak değil çağıranın hükmünden alır. `finalize_update_receipt` singleton'ı dosya yazısından önce çıkarır. Yazı başarısızsa None döner; normal command-boundary safety net artık açık receipt bulamayabilir. Versioned receipt yazılması ve `latest.json` pointer yazılması da ayrı adımlardır. **Bir kez finalize hakkı ile makbuzun kalıcı olarak yayımlanması aynı garanti değildir.** Bütün dosya/OS failure'ları bu tur çalıştırılmadı. [S11]

Bu sınırlar olumlu mekanizmaları silmez: açık refused/partial durumları, pre/post SHA, skipped nedenleri, attempted/verified restart ayrımı ve survivor/fleet karşı okuması gerçekten vardır. Fakat bunların isimleri ve log metinleri tam, atomik, her ortamda doğrulanmış update başarısı değildir.

## 11. Kullanıcı durumunun devamı ve öğrenme kütüphanesine bağlantı

Update maintenance; aktif home ve sibling state.db'leri integrity açısından inceleyen, uygun snapshot varsa restore deneyen kaynakları çağırır. Foreign holder ve in-process connection guard'ları bulunur; unknown scan veya recovery exception farklı best-effort davranabilir. Geçerli snapshot'a dönmek daha yeni kullanıcı olaylarının kayıpsız korunduğunu kendiliğinden göstermez. Source rollback, data restore ve process restart üç ayrı işlemdir. [S09]

Bundled skills sync, profile skills seeding, eksik profile env backfill, config migration, memory-provider uyarlama ve curator bildirimleri de update'in parçasıdır. Bunların bir kısmı summary'den önce, diğer self-heal/notice işleri sonra yürür; bir kısmının hatası devamı kesmez. **Kod güncellemesi kullanıcı bilgi ve yetenek kütüphanesinin yaşamına dokunur.** Ancak burada `sync_skills` ve curator'ın aşağıdaki gerçek corpus/update/delete/rollback işlemleri incelenmiş sayılmaz. Çağıranın “user-modified kept” etiketi kendi başına bütün özelleştirmelerin korunması kanıtı değildir. [S09]

Bu yeni ilişki Q58'in F04'e doğal dönüş noktasıdır: kurulum/update'in dağıttığı beceriler ile ajanın ürettiği/düzenlediği beceriler aynı origin, authority ve eşitleme kurallarıyla mı yaşar? Bir sonraki çalışma bunu native kaynaklardan ayırmalıdır; yalnız diğer dillerdeki “memory” veya tek dosya eşitlenmesiyle açıklanmamalıdır.

## 12. Karşı okuma, çıkış ve kalan alan

Tek güncelleme transaction'ı çerçevesi bu kaynağı eksik açıklar. Daha uygun geçici native açıklama; install authority, Git/venv/data değişimi, onarım işaretleri, supervisor handoff, model-visible/CLI-visible sonuç ve kalıcı makbuzun ayrı ama bağlı geçişleridir. Bu evrensel ontoloji veya SOUL mimarisi önerisi değildir.

Q58'in normal install/activation, actual update ve farklı refusal/interruption yolları kaynakla bağlandı. Method/pin/kapsam korunur. Bütün updater helpers, Docker/Nix/Powershell/Tauri parity, full dependency graph, actual DB/snapshot/first request ve güvenilirlik kapanmadı. Yeni HERMES import/behavioral execution veya ürün testi yoktur; lock yarışı, partial outcome ve failed receipt bu tur gözlenmiş saha olayı değildir.

**Sonraki geniş kaynak adayı Q59:** install/update/startup beceri eşitlemesi → bundled/user/agent-created origin ve manifest/ledger → user edit/deletion/restore → sonraki skill keşfi/tüketimi; curator aynı yaşam zincirinde bounded olarak izlenir. U13 kapsam kararıyla birlikte değerlendirilir. Eval/future-task quality ayrı açık aile kalır; bütün update fault matrisini tüketmek Q59'un ön koşulu yapılmaz. Önce bu B main'e yayımlanıp geri okunur; sonra current plan/rotalar uzlaştırılır.
