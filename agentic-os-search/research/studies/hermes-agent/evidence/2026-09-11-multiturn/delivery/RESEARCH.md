# U04 — Kalıcı işten çok turlu yürütmeye: devam, bekleme, durma ve kabul

**Araştırma tarihi: 2026-09-11. Statü: yeni kaynak incelemesi + sınırlı çevrimdışı deney + geçici alt-sistem açıklaması. GitHub yayını henüz yapılmadı.**

Hedef `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; manifest 0.21.0. Bu bir güncel sürüm, kurulu ürün veya üretim güvenilirliği değerlendirmesi değildir. Başlangıç canonical araştırma kaydı `13e00420d27547998475ac3d1bcd0d4a492f2229`, plan v0.15. [Kaynak defteri](SOURCES.md), [önceden sabitlenen deney ölçütleri](evidence/SPEC.md), [ham sonuç](evidence/RESULT.json), [ara sentez](SYNTHESIS.md).

## 1. Soru ve araştırmanın önceki katmanlarla ilişkisi

U02 normal ajan turunun bağlam, model–araç yinelemesi, kayıt ve teslim sınırlarını açmıştı. U03, kalıcı Kanban görevini o görevi yürüten denemeden ayırdı; claim/run kimliği ve transaction içindeki kabul üzerinde sınırlı kanıt üretti. U04'ün sorusu bunların arasındadır: **Kalıcı bir iş hangi mekanizmayla yeniden ajan turuna dönüşür; o mekanizma hangi durumda devam etmemelidir?**

Başlangıçta dört rakip açıklama açık tutuldu: her tur aynı kalıcı görevin devamı olabilir; yeni deneme olabilir; yalnız aynı konuşmadaki yeni bir değerlendirme olabilir; belirli aralıklarla yinelenen bağımsız bir yoklama olabilir. Kaynak, bunları tek bir otomasyon döngüsüne indirgememeyi gerektiriyor. Kanban goal-mode, oturuma bağlı `/goal`, `/loop` ve `/heartbeat` farklı kayıtları, tetikleme nedenlerini ve sonlanma kurallarını kullanıyor. Kanban'ın claim heartbeat'i de sonuncuyla aynı mekanizma değil. [S01–S07]

Araştırma nesnesi bir hata listesi değildir. Normal ilerlemenin nasıl çalıştığı, kontrolün hangi geçişi koruduğu ve farklı kaynak/nesne ömürlerinin nasıl birleştiği esas açıklamadır. Yeni deneylerde zararlı yük, gerçek model, gerçek kullanıcı hesabı, worker süreci veya dış sistem etkisi kullanılmadı.

## 2. Kanban goal-mode: kalıcı görev, belirli run, birden fazla ajan turu

### Başlangıç ve çağırıcı

U03'te açılan dispatcher, goal-mode görev için quiet CLI yolunu seçer. Bu turun CLI okuması, ilk `agent.run_conversation` çağrısından sonra `_run_kanban_goal_loop_q` yoluna geçildiğini gösterdi. Böylece `run_kanban_goal_loop` içine girildiğinde bir tur zaten harcanmıştır: yerel `turns_used` sayacı 1'den başlar. Bu sayaç oturum `/goal` kaydındaki `GoalState.turns_used` değildir. Aynı yardımcı işlevin yeni çağrısı yeni yerel sayacı başlatır; bundan task'ın bütün retry bütçelerinin sıfırlandığı sonucu çıkarılmaz. [S01/S02; U03]

CLI köprüsü task ID ve run ID'yi ortamdan okur; görev başlığı ve gövdesinden değerlendirme hedefini kurar. Sonraki tur çağrısı aynı `cli.agent` üzerinden yapılır, CLI konuşma geçmişi parametre olarak verilir ve compaction ajan session ID'sini değiştirdiyse CLI session ID'si eşitlenir. **Bu dar köprü, bütün conversation-history nesne sahipliğini veya her yeniden başlatmada eksiksiz history devamını kanıtlamaz.** Dönen mesajların asıl saklama/yeniden yükleme zinciri ayrı araştırma sınırıdır. [S02]

Durum callback'i yalnız `tasks.status` okumaz; `goal_run_status(task_id, expected_run_id)` çağırır. Engelleme callback'i de `block_task(..., expected_run_id=worker_run_id)` kullanır. Normal ID aktarımı ile eksik/bozuk ortam ID'si nedeniyle `None` kullanılan uyumluluk dalı aynı yetki güvencesi değildir. Sırf task kimliği aynı diye eski run yeniden yetkili sayılmaz. [S02/S07; U03]

### İşin güncel durumu mu, bu çalıştırmanın sonucu mu?

`goal_run_status`, beklenen run için kaydedilmiş terminal sonucu önce yorumlar. Eski uygulayıcı run `review_requested` olarak kapanmış ve inceleyen yeni run görev kartını tekrar `running` yapmış olsa bile eski döngüye `review` dönebilir. Reclaim gibi bir kapanış veya farklı current-run kimliği ise `superseded` üretir. Bu ayrım, eski çalışanın halefinin hâlâ çalışmasını kendi devam izni sanmasını önler. [S07]

G02 ve G03 bunu seçili gerçek okuyucu ve gerçek geçici SQLite kayıtlarıyla ayırdı: review devrinde eski döngü değerlendirme yapmadan çıktı; reclaim edilmiş eski run, yeni run çalışıyor olsa da devam etmedi. Task/run kayıtlarını hazırlayan ve devreden SQL burada **deney fixture'ıdır**; gerçek dispatcher/claim/review transition'ları yeniden çalıştırılmadı. [G02/G03]

Bu nedenle terminal sonucun yardımcı değerlendiriciden önce ele alınması otomatik bir doğrulama kusuru değildir. İncelemeye devredilen veya sahipliği sona eren çalışana tekrar iş yaptırmamak da gerekli bir kontrol olabilir. Buna karşılık terminal kabulün anlamsal kalitesi ayrı kalır; geçerli run sonucu tek başına doğru iş üretildiğini göstermez.

### Döngünün karar sırası

İlgili normal sıra:

`bu run'ın durumunu oku → terminal/devir/superseded ise dur → son yanıtı değerlendir → devam veya kapanış istemi üret → yeni tur öncesi bütçeyi denetle → ajanı çalıştır → tekrar durumu oku`.

Değerlendirici `done` dediğinde kart doğrudan tamamlanmaz. Döngü çalışandan `kanban_complete` veya uygun review handoff'u ister. Bir kez kapanış için uyarılmış çalışan hâlâ terminal kayıt üretmemiş ve tekrar `done` kararı alınmışsa döngü engelleme yoluna gider. Değerlendiricinin görüşü, çalışan bildirimi ve veritabanının kabulü ayrı kalır. G04 normal finalize→receipt yolunu; G05 kapanış yapılmayan karşı yolu ayırdı. [S01; G04/G05]

Bu Kanban döngüsünde `wait`, `continue` olarak yorumlanır. Oturum `/goal` mekanizmasının bekleme bariyeri burada kurulmaz. Ayrıca yardımcı değerlendiricinin parse/transport hata bayrakları okunur, fakat oturum GoalManager'ındaki ayrı hata sayaçları bu işlevde kullanılmaz. G06 seçilmiş üç turluk bütçede iki ek tur; G07 parse-failure fixture'ıyla beş turluk bütçede dört ek tur gözledi. Bu değerler ürünün varsayılanı değil, deneyde ayırt etmek için seçilmiş bütçelerdir. [S01; G06/G07]

### Engellendi sonucu hangi durumu bildiriyor?

Kanban döngüsünün `_block` yardımcısı callback'i çağırıp istisnayı loglar; callback'in dönüş değerini ve sonraki veritabanı durumunu doğrulamaz. CLI callback'i de low-level block işlemini çağırır fakat boolean sonucu üst döngüye kabul belgesi olarak taşımaz. [S01/S02]

G08'de engelleme callback'i `False` döndü; G09'da istisna üretti. Her iki durumda döngü `blocked_unachievable` sonucu verdi, ama ayrı SQLite bağlantısının gördüğü görev `running` kaldı. Bu bir **döngü sonlanma nedeni ile kalıcı geçişin kabulü arasındaki sınır**dır; HERMES'in her engellemesi başarısızdır veya üretimde bu arıza görülmüştür denmiyor. [G08/G09]

CLI'nin quiet dış işlevi ayrıca goal-loop dönüş nesnesini kullanmadan ilerler; çıkış kodunu ilk `run_conversation` sonucundan türetir. Böylece process exit code, goal-loop outcome ve task/run receipt aynı başarı değişkeni değildir. Gerçek worker process bu tur çalıştırılmadı. [S02]

### Sahiplik kaybı ile fiziksel durma aynı an mı?

Döngü durum kontrolünü değerlendirici çağrısından önce yapar; değerlendirici döndükten sonra yeni tur çağrısından hemen önce ikinci bir durum okuması bu işlevde yoktur. G10, sahipliği fixture judge çağrısının içinde A'dan B'ye devretti. Ardından bir zararsız callback turu çalıştı; sonraki durum okuması `superseded` döndürünce döngü durdu. B'nin kaydı değişmeden kaldı. [S01/S07; G10]

Bu deney, seçilen sıralamada mümkün olan ek turu gösterir. Canlı OS sinyali, gerçek concurrent worker veya dış araç etkisi göstermez. Gerçek sistemin kesinti kontrolleri bu yolu daha önce durdurabilir; U03'teki expected-run-ID tüketimi belirli kalıcı task değişikliklerini de reddedebilir. **Sonuç kabulünü engellemek ile dış etki oluşmadan çalışmayı fiziksel olarak durdurmak ayrı güvencelerdir.**

## 3. Oturuma bağlı `/goal`: hedef, kriter, bekleme ve karar durumu

GoalManager ayrı bir `GoalState` taşır; kalıcı anahtar `goal:<session_id>` ve depo profilin SessionDB yüzeyidir. Hedef, durum, tur bütçesi, değerlendirme gerekçesi, sonradan eklenmiş kriterler, isteğe bağlı completion contract, deterministic gate tanımları ve bekleme bilgileri bu durumda bulunur. Kanban board'unun task/run şeması kullanılmaz. [S01]

Hedefe ait contract beş metin alanı taşır: outcome, verification, constraints, boundaries, stop_when. Bunlar devam istemi ve judge girdisi oluşturulurken kullanılır. **Metinde scope belirtilmesi, bütün araç etkilerinin aynı scope altında işletim sistemi düzeyinde sınırlandığının kanıtı değildir.** Bu çalışma contract'ın bağlama nasıl taşındığını açıklıyor, bütün enforcement zincirini değil.

`evaluate_after_turn`, aktif olmayan hedefi devam ettirmez. Mevcut bekleme bariyeri sürüyorsa yeni judge çağrısı veya tur sayacı artışı yapmaz. Diğer yolda turu sayar, varsa kalite kapılarını çalıştırır, ardından judge'a geçer. Kalite kapısının hatası judge'ı atlayıp somut çıktı içeren bir düzeltme istemi üretebilir; tekrar/bütçe sınırı duraklatabilir. [S01]

Kapı yürütmesi gerçek shell komutu olabilir; bu araştırmada o komutlar çalıştırılmadı. Gate'in “değişmedi” kararı için kullanılan fingerprint `git HEAD + git status --porcelain` temellidir. Bu, her kirli dosyanın tam içerik sürümünü bağlayan hash değildir. Aynı statüdeki dosya içeriği değişikliklerinin etkisi ayrı, sınanmamış bir soru olarak kaydedildi; bu yan dal genel süreklilik araştırmasını durdurmadı.

Judge sonuçlarının GoalManager'daki etkisi Kanban'dan farklıdır. `done` hedef durumunu done yapar; `blocked` hedefi paused yapar; `wait` bir bariyer kurar. Parse hataları ve transport hataları ayrı sayılır; ilgili eşikler veya genel tur bütçesi hedefi duraklatabilir. Bu paused/done durumlarının persist edilmesi ayrıca best-effort kayıt yardımcısına bağlıdır. [S01]

Bekleme pid'ye, process-registry session'ının çıkış/tetik olayına veya zamana bağlanabilir. Delegation nedeniyle kurulan süreli beklemede aktif batch sayısının düşmesi daha erken çözülme nedeni olabilir. Pid/session bariyeri için bir yaş sınırı vardır. “Bekle” kararı alınan değerlendirme turu sayılmıştır; bariyer altında sonraki kontrol yeni tur tüketmez. İsimdeki session'ın burada konuşma oturumu değil process-registry kaydı olabileceği özellikle ayrılmalıdır.

CLI idle hook'u bariyerin kalkmasını ayrıca denetleyip normal girdi kuyruğuna devam istemi koyar. Demek ki **kayıtlı bir bekleme koşulu ve bu koşulu yeniden kontrol eden canlı host** birlikte gerekir. Manager tek başına zamanlayıcı değildir. Gerçek kullanıcı mesajı kuyruğu önceliklidir; Ctrl+C sonrasındaki CLI post-turn yolunda hedef duraklatılır. [S03]

## 4. Judge'ın gerçekten hangi kanıta eriştiği

`judge_goal` tam bir bağımsız iş denetçisi gibi sunulmamalıdır. İncelenen çağrı hedef metni ile son görünür cevaptan istem kurar; varsa criteria/contract, çalışan süreç özeti ve aktif delegation bilgileri eklenir. Hedef yaklaşık 2.000, son yanıt 4.000 karakterle sınırlandırılır; contract/subgoal bloklarında da ayrı kesme sınırları vardır. Tam araç izi, dosyalar veya canlı dünya kendiliğinden okunmaz. [S01]

Bu, judge'ın hiç yararlı olmadığı anlamına gelmez. Devam gereği, açıklanmış engel ve görünür teslim için sınırlı bir karar girdisi sağlayabilir. Fakat “teslim gerçekten var” diye talimat verilmesi ile onun varlığının bağımsız ölçülmesi aynı şey değildir. Deterministic gate'ler farklı kanıt üretir; her çağırıcı aynı gate'leri çalıştırmaz.

U03'te incelenen tool `_goal_gate`, goal-mode completion/review öncesinde koşullu başka bir judge çağrısıdır. Yardımcı model erişilemez veya çağrı hata verirse handoff'a izin veren yollar bulunur; erişilebilir judge'ın `continue` hükmü ise reddedilir. Outer goal-loop'un her terminal sonucu yeniden değerlendirmemesi, tool yolunda hiç değerlendirme yok anlamına gelmez. Tersine tool kapısının varlığı da her low-level veya manuel çağırıcıyı kapsadığı anlamına gelmez. [S01/S02/S08; U03]

## 5. `/loop`: süreli yeniden giriş ve açık bitiş nedenleri

LoopManager `loop:<session_id>` kaydında istem, sabit veya kendini ayarlayan aralık, tick sayısı, `--times`, `--until`, üst bütçe, route ve `awaiting_response` taşır. İlk tick oluşturma anında due olabilir; sonraki tick normalde önceki turun bitiminden itibaren planlanır. Uyanma, yeni görev devralma ile aynı olay değildir. [S04]

`fire_tick` sayacı ve awaiting durumunu cevabı almadan kaydeder; host daha sonra istemi enjekte eder. Enjeksiyon başarısızlığında `abandon_tick` telafi yoludur. Buradaki yardımcı state işaretini dağıtık exactly-once worker claim'i saymıyoruz; gerçek kayıt ve eşzamanlı host yolları ayrıca gerekir.

`complete_tick` sırasıyla şunlara bakar: cevapta `LOOP_COMPLETE` işareti; varsa `--until` için judge; istenen tekrar adedi; yapılandırma bütçesi; yeni aralığın hesaplanması. İşaretin regex'i ayrı satır arar; dokümanın “cevabın sonunda” ifadesinden daha geniş bir satır eşleşmesi kullanır. [S04]

İşaret ilk kontrol olduğu için her kapanışta `--until` judge'ı zorunlu olarak çalışmaz. `--times` adedine ulaşıldığında done, “istenen N tekrar yapıldı” anlamına gelebilir; hedef koşulun gerçekten sağlandığıyla aynı şey değildir. Yapılandırmanın azami tick sayısı ise paused üretir. **Aynı status etiketi ancak stop reason ile birlikte yorumlanabilir.**

Kendini ayarlayan aralıkta artış, normalize edilmiş yanıtların digest eşitliğine dayanır. Bu, dış dünyanın değişmediğinin bağımsız ölçümü değildir. Metin değişmeyince aralık uzayabilir, değişince kısalabilir. Bu davranış keşif maliyetini azaltma mekanizması olarak açıklanabilir; anlamsal ilerleme metriği olarak değil.

CLI idle yolunda aktif ve beklemeyen `/goal`, `/loop` tick'ine öncelik alır. Park edilmiş veya duraklatılmış hedef loop'u aynı biçimde engellemez. Slash-command loop'ları ayrıca model cevabı almadan tamamlanmış tick sayılabilir; bu yol sıradan agent-turn post-hook'una gitmediğinden host onu ayrıca kapatır. [S03/S04]

## 6. `/heartbeat`: bir görevin bittiğine karar vermeyen düzenli giriş

HeartbeatState yalnız prompt, interval, active/paused/cleared, ilk/son zaman ve fire_count gibi alanları taşır; `heartbeat:<session_id>` olarak saklanır. İncelenen manager'da judge veya done sonucu yoktur. Bir hatırlatmaya verilen cevabın “iş yok” demesi, düzenli talimatın kendisini otomatik silmez. [S05]

İlk ateşleme interval sonradır. Geçmişte kaçırılan aralıklar tek tek geriye doğru çalıştırılmaz; due olduğunda zaman çıpası şimdiye alınarak bir giriş üretilir. H01/H02/H03 ilk gecikme, kaçırılan aralıkların birleştirilmesi ve yeni nesnede kalıcı sayacın okunmasını ayırdı. H04 pause/resume'daki yeni zaman çıpasını; H05/H06 başarısız enjeksiyonun geri alınmasını ve araya giren pause'un korunmasını sınadı. [H01–H06]

Tam kaynak dosyasının Git kimliği birebir doğrulandığı halde çalışma bütünüyle gerçek uygulama değildir: saat kontrollü, depolama erişimi gerçek geçici SQLite'a bakan azaltılmış bir adaptördür. Test gerçek SessionDB init/migration/profil veya gateway yarışı çalıştırmaz.

Bu mekanizma Kanban'ın `heartbeat_claim` yoluyla çalışma hakkını uzatması değildir. İlki oturuma yeni istem üretir; ikincisi görev/run sahipliğinin yaşam süresini ve canlılık kaydını etkiler. Aynı kelime kullanıldığı için iki farklı etki alanını birleştirmiyoruz. [S05/S07/S08; U03]

## 7. Kalıcı kayıt, canlı izleyici ve yeniden başlatma

Gateway'in heartbeat watch tablosu bellekte tutulur. `_register_heartbeat_watch` kaynak açıklaması, ayar veritabanında kalırken yeniden çalıştırmanın kullanıcının `/heartbeat` ile tekrar temas etmesine bağlı olduğunu açık eder. Poller, kayıtlı watch'lardan idle oturumu seçer; uygun adapter ve boş kuyruk koşuluyla due istemini geçirir. Başlatılmayan ateşleme için abandon yolu vardır. **Ayarın kalıcı olması, servisin her yeniden başlamasında otomatik ateşlemenin kurulmasıyla aynı değildir.** [S06]

Gateway `/loop` izleyicisi ise aktif `loop:*` kayıtlarını tarar; route olmayan CLI/TUI kayıtlarını kendi host'larına bırakır. Çalışan oturum, devam eden tick ve aktif unparked goal gibi koşullar yeni tick'i erteleyebilir. Bu, heartbeat'in bellekteki watch listesinden farklı bir yeniden keşif yoludur. Ancak `awaiting_response` ile işaretlenmiş yarım kalmış tick'in bütün crash/restart telafileri bu tur kapatılmadı. [S06]

Default-branch araması daha yeni multi-profile scan açıklaması gösterdi; primary pin'de okunan watcher aynı kod değildir. Bu yeni arama sonucu sabit sürüme mal edilmedi. Pinned watcher'ın hangi profil kapsamı altında başlatıldığının tamamı da yalnız bu dosyadan çıkarılmadı.

Post-turn goal ve loop hook'ları, sonuç metnini kimi durumda doğrudan result'tan, kimi durumda event üzerindeki streamed-final-response alanından alır. Bildirim teslimi için post-delivery callback kullanılabilir. Yorumlardaki “AFTER delivery” ifadesini, bütün actual outer caller/adapter sırası kapanmadan evrensel zamanlama kanıtı yapmıyoruz. [S06]

## 8. Session aktarımındaki yeni ölçülmüş sınır

H07'de `set_meta` hatası enjekte edildi. Tam heartbeat modülünün `set` işlemi canlı active durum döndürdü, ama taze manager kalıcı kayıt bulamadı. H08 normal old→new aktarımda yeni active kaydı ve eski cleared kaydını gördü. H09'da yalnız yeni session anahtarına yazma başarısız kılındı: migration yardımcısı True döndü; yeni anahtar oluşmadı; eski anahtar cleared oldu. [S05; H07–H09]

Yakın mekanizma: `save_heartbeat` depolama istisnasını yakalayıp çağırıcıya başarısızlık sonucu taşımıyor; migration yardımcısı child save'den sonra old clear yapıyor ve True dönebiliyor. Buradaki hata yalnız “SQLite başarısız oldu” değildir; **yardımcının dönüş sözleşmesi ile ona güvenen aktarım sırası** sonucu değiştiriyor. Gerçek SessionDB hatasının sıklığı veya actual compaction çağırıcılarının telafisi ölçülmedi.

Benzer best-effort save/migrate biçimleri goals ve loops kaynaklarında görülüyor, fakat H09 onların çalıştırılmış kanıtı değildir. Her biri gerçek kayıt/lineage consumer'ıyla ayrıca bağlanmalıdır. Bu bulgu bütün araştırmayı arıza avına kilitlemek için değil, bir sonraki geniş kayıp/geri yükleme çalışmasının ayırt edici sorusunu belirlemek için kullanılıyor.

## 9. Kanıt gücü ve karşı okuma

Bu tur G01–G12 ve H01–H09 olmak üzere 21 tanılayıcı durum çalıştırıldı. Bütün önceden yazılmış beklentiler eşleşti. Bu ifade ürünün 21 testi geçtiği veya güvenilirlik yüzdesi olduğu anlamına gelmez. Üç negatif kontrol, kaynak byte değişikliği, kaldırılmış run-ID dalı ve yanlış WAIT yorumu için düzeneğin hata duyarlılığını gösterir; diğer yanlışları yakalayacağını ispatlamaz. [SPEC/RESULT]

Heartbeat'in **tam** dosya byte kimliği upstream blob ile eşleşiyor. Kanban loop ve run-status dosyaları **manuel seçkilerdir**; tam upstream parent byte/AST sadakati açık kalır. Task state yazımları, judge, model turu, `get_task`, saat ve SessionDB adaptörü fixture'dır. SQLite dosyası ve taze bağlantıdan readback gerçektir. Gerçek model kalitesi, kaynak güvenliği, process iptali veya platform teslimi sınanmamıştır.

En önemli rakip açıklamalar korunur: daha üst kesinti katmanı G10'daki ek turu önleyebilir; callback sonucu bozuk görünse de başka bir recovery işlemi daha sonra task'ı düzeltebilir; migration hatasını ayrı session-state onarımı telafi edebilir; frontend/workflow varyantları farklı bir kabul sınırı koyabilir. Mevcut deney bu ihtimalleri dışlamaz. Fakat onları okumadan “başka katman mutlaka halleder” diyerek gözlenen sınırı kapatmak da doğru değildir.

## 10. Sentez ve sonraki birim

Geçici modelde iki farklı soru birlikte taşınıyor: **Ne zaman yeniden çalışmalıyım?** ve **hangi çalıştırmanın hangi sonucu kabul edilmeli?** Judge, sayaç veya saat birinci soruya girdi olabilir. Task/run kimliği, kayıt transaction'ı, callback sonucu ve host admission ikinci sorunun farklı bölümleridir. Bunlar tek boolean veya evrensel goal-loop içinde erimiyor.

Bounded U04, Kanban çok turlu çağırıcıyı diğer session manager'larla anlamlı biçimde karşılaştıracak kaynak/deney bağlantısını kurdu. U03'ün bütün kaynak sadakati ve full runtime açıkları kapanmadı; yeni alt-sistem sentezi de nihai HERMES CORE veya dört-alan/SOUL mimarisi değildir.

İlk sonraki araştırma: **gerçek SessionDB/state_meta işlemleri, compaction/session aktarımı ve host yeniden başlatıldığında yeniden etkinleştirme**. Amaç aynı H09'u çoğaltmak değil; kayıt başarı/hata sözleşmesini actual DB'den çağırıcıya bağlamak, child/parent kaydının ne zaman kabul edildiğini ve canlı watcher/queue'nun nasıl recover edildiğini açıklamak. Ardından scheduler/cron ve delegation/backends gibi geniş ailelerin sırası bu modelle yeniden değerlendirilebilir. GitHub yayını kapanmadan bu paket canonical v0.16 sayılmaz.
