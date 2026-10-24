# U04 — Bir işi sürdürmek, bir turu yeniden başlatmak ve sonucu kabul etmek

**2026-09-11 / PINNED SOURCE STUDY + BOUNDED DIAGNOSTIC.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [SOURCES](SOURCES.md) kimlik/okuma/yürütme kapsamını, [SPEC](SPEC.md) önceden sabitlenmiş ayırıcıları, [tam arşiv](diagnostic-evidence.tar.xz) ham kanıtı verir. Bu araştırma HERMES-native açıklamadır; Foundation ontolojisi, SOUL mimarisi veya ürün onayı değildir.

## 1. Soru: bir sonraki tur neden ve kimin adına başlar?

U02 bir turun yürütme omurgasını, U03 kalıcı task/run/claim ve sonuç kabulünü açmıştı. Aradaki yük taşıyan soru, bir görevin ardışık turları nasıl yönettiğiydi. Yeni kaynaklar tek bir evrensel devam motoru yerine farklı kimlik, durum ve durma kuralları gösteriyor. Ortak `judge_goal` kullanımı aynı lifecycle sözleşmesi anlamına gelmiyor. [S01–S06; reused U02/U03]

| Yol | Devamı taşıyan nesne | Sonraki çalışmayı ne başlatır? | Durma neyi anlatır? |
|---|---|---|---|
| Klasik Kanban worker | Kalıcı board task + belirli run/claim | Dispatcher çalıştırmayı başlatır; yeni run recovery/yeniden claim konusu | DB terminal handoff, süreç çıkışı ve iş kalitesi ayrı |
| Kanban goal-mode | Aynı task/run'a bağlı worker; süreç içi yerel tur sayacı | İlk quiet turdan sonra callback döngüsü | Worker terminal/devir durumu, superseded, budget veya callback hatası |
| Oturum `/goal` | `goal:<session_id>` GoalState | Tur sonu gate/judge kararı ve host kuyruğu; parkın kalkması | GoalState done, paused veya waiting; Kanban task geçişi değildir |
| Oturum `/loop` | `loop:<session_id>` LoopState | Zamanı gelen tick + host uygunluğu | Marker, isteğe bağlı until judge, istenen tekrar sayısı veya backstop |
| Oturum `/heartbeat` | `heartbeat:<session_id>` HeartbeatState + canlı driver watch | Aralık dolması ve host'un boş olması | Recurring ayarın pause/clear edilmesi; semantik completion judge yok |

Tablo ad benzerliğinden türetilmedi: ilgili state sınıfları, callback'ler ve çağırıcılar karşılaştırıldı. Kanban heartbeat_claim/heartbeat_worker canlılık sinyali, son satırdaki tekrar istemi değildir. Klasik ve goal-mode, aynı board'un farklı çalışma seçenekleridir; bütün sohbetler task değildir.

## 2. Kanban'da gerçek çağrı bağı

U03'te `_worker_argv` goal_mode için quiet `-Q` kolunu seçiyordu. S02'de actual quiet caller ilk `agent.run_conversation` çağrısını yapar; ardından HERMES_KANBAN_GOAL_MODE=1 ise `_run_kanban_goal_loop_q` çalışır. Wrapper task/run kimliklerini environment'tan alır, kartın title+body metnini bir kez okur ve `run_kanban_goal_loop` için üç callback kurar. [S02; U03-S03]

`run_turn` aynı agent nesnesini çağırır. `task_status_fn` yeni board bağlantısıyla `goal_run_status(task_id, worker_run_id)` okur. `block_fn`, `block_task(...expected_run_id=worker_run_id)` çağırır. Böylece dış döngünün kimliği yalnız sabit task ID değildir: önceki denemenin bitişi veya sahiplik kaybı belirli run açısından değerlendirilir. U03'ün kaynak kaydı, tamamlanan/devir veren eski run'ın kendi terminal görünümü ile başka nedenle superseded olmasını ayırır. [S02; reused U03]

Normal kaynak yolu ile eksik/bozuk environment ayrı tutulur: raw RUN_ID çözülemezse wrapper uyarıp None bırakabilir. Bu, normal dispatcher'ın ID'yi vermediğinin kanıtı değildir; tüm alternate caller'lar Q39'da açık kalır.

## 3. Değerlendirici kararı ile kalıcı görev kabulü birbirine eşit değil

Helper ilk yanıtı zaten harcanmış bir tur olarak sayar. Önce task status okunur: done, blocked, review veya changes_requested ilgili sonucu döndürür; judge'a ve yeni tura girmez. Beklenmeyen/superseded durum durdurur. Sonra son yanıt goal metnine göre judge'a gider. [S01/S02]

Judge CONTINUE ise yeni somut adım isteyen user-role continuation verilir. DONE ise kart doğrudan done yapılmaz: çalışana terminal bildirimini yapması için finalize nudge gönderilir. Bir sonraki status okuması terminal sonucu taşıyorsa döngü durur. Judge tekrar DONE der ama worker terminal geçişi yapmamışsa block denenir. BLOCKED kararı da başarı değil, ayrı block girişimidir. WAIT bu helper'da CONTINUE'ya çevrilir; GoalManager'ın park mekanizması kullanılmaz. [S01]

G01–G03/G07/G09 bu sözleşmeleri kontrollü olarak ayırdı: dört terminal türünde ekstra çağrı yok; normal devam ve finalize istemi farklı; max_turns=1 ek tur harcamıyor; WAIT bir continuation üretiyor; iki DONE yalnız bir finalize turundan sonra block girişimine gidiyor. Bunlar gerçek judge kalitesi veya board sonucu değil, sentetik callback sonucunun tüketilmesidir.

### Kabul bildirimindeki ikinci sınır

Helper'ın `_block` yardımcısı callback'in dönüş değerini kullanmaz; exception'ı loglayıp yakalar. Bu yüzden `blocked_budget` sonucu, callback'in kalıcı block'u başarıyla uyguladığına dair receipt değildir. S02 callback'i de `block_task` dönüşünü üstüne taşımaz. Quiet wrapper helper'ın result sözlüğünü kullanmaz; programın çıkış kodu ilk ajan çağrısının result'ından hesaplanır. İlk tur başarılı, sonraki goal devamı durmuş olabilir; bu tek başına exit-code'a yansımayabilir. Dispatcher'ın task durumunu ayrıca okuması bu ayrımı önemlidir. [S01/S02; U03]

G04'te callback False döndürdüğünde veya exception attığında sentetik görev running kaldı; helper `blocked_budget` döndürdü. G10 reader/run hatasında `stopped` verdi. Buradan üretimde hata oranı veya bütün sistemin yanlış başarı bildirdiği sonucu çıkmaz. Kanıt, döngü sonucu ile kalıcı geçişin ayrı okunması gerektiğini gösterir.

## 4. Sahiplik kontrolünün ne zaman yapıldığı

G05'te baştaki status `superseded` ise ne judge ne run callback'i çalıştı. Bu işleyen sınırdır. G06'da ise status running okunduktan sonra, judge callback'i sırasında durumu superseded yaptık. Helper sonraki status kontrolünden önce bir run callback'i çağırdı; sonraki kontrol durdurdu. [S01; G05/G06]

Bu bir gerçek worker yarışı veya dış etki gösterimi değildir: kontrollü callback sıralaması, yalnız helper'ın kontrol zamanını açar. Gerçek agent girişindeki session lease, araçların own-run kontrolleri veya OS interruption başka sınırlar olabilir. Önceden yapılan bir sahiplik kontrolünü çağrı boyunca kesintisiz yetki garantisi saymamak gerekir. Bu alanı tüm güvenlik denetimine çevirmeden açık bağımlılık olarak kaydediyoruz.

G08'de parse/transport failure bayrakları CONTINUE yanında geldiğinde ayrı erken-pause sayacı işletilmedi; altı turluk bütçe son sınırlayıcı oldu. Bu helper'ın flags'i `_parse_failed`/`_transport_failed` olarak tüketmemesiyle uyumludur. Oturum GoalManager'ında farklı politika vardır.

## 5. Oturum `/goal`: hedef durumu, doğrulama ve park

GoalManager kalıcı GoalState tutar. Kontratın outcome/verification/constraints/boundaries/stop_when alanları ve subgoal'lar isteğe bağlıdır. Kullanıcının eklediği shell quality gate'ler varsa judge'dan önce çalışırlar; başarısızlığın çıktısı devam istemine taşınır ve retry/budget sınırı vardır. Bu tur gate komutu çalıştırılmadı. [S01]

Park koşulu sürüyorsa evaluate yeni tur saymaz ve judge çağırmaz. Judge WAIT bir process-registry session, PID veya zaman bariyeri kurabilir. Delegasyon tamamlanması ya da belirli parkların yaş sınırı bariyeri kaldırabilir. Judge BLOCKED → paused, DONE → GoalState done; parse ve transport hataları ayrı sayaçlarla otomatik pause'a gidebilir. Bu durumların hiçbirisi kendiliğinden Kanban kartını done yapmaz. [S01]

CLI post-turn hook'u kuyruktaki gerçek kullanıcı mesajına öncelik verir; Ctrl+C'de aynı işi otomatik geri kuyruğa koymak yerine goal'u pause eder. Boş yanıtı judge'a göndermez. Idle hook park kalkınca devamı kuyruğa koyabilir. Gateway tarafında aynı manager'ın kararı adapter FIFO üzerinden sentetik istem olarak verilir; status notice için delivery-sonrası callback ayrı düzenlenir. Hesaplama zamanı ile status bildirimi teslimini eşitlemiyoruz; bütün host/adapter çağrı sırası bu tur çalıştırılmadı. [S03/S06]

### Judge neyi görüyor?

`judge_goal`, goal metninin ilk 2,000 karakterini ve son yanıtın ilk 4,000 karakterini; verilmişse sınırlanmış kontrat/subgoal, background process ve delegasyon bilgilerini kullanır. Tam transcript'i veya gerçek dosyaları kendiliğinden inceleyen bağımsız bir oracle değildir. Kanban helper goal_text+last_response ile çağırır; session manager daha zengin seçenekleri geçirebilir. [S01]

Deterministik gate'in varlığı da seçilen testin amaca yeterli olduğunu ispatlamaz. S01'de başarısız gate tekrarını azaltmak için HEAD + git status --porcelain özeti fingerprint olarak kullanılır. Bu tam dosya içeriği kimliği değildir; aynı dirty durumunda değişen içerikler farklı sonuç üretse bile aynı özete sığabilir. Bu tur bunun gerçek görev etkisi sınanmadı; güçlü verification hükmünden önce ayrı soru olarak tutuldu.

## 6. `/loop`: bir hedef tamamlatmaktan farklı bir tekrar sözleşmesi

LoopManager'ın state'i tick, cadence, next_due_at, awaiting_response, times, until ve gateway route taşır. Fire, tick'i ve provisional next_due'yu kaydeder; complete/abandon çağrısını bekler. Başlatma ile yürütülmüş tur ve tamamlanmış tick aynı olay değildir. [S04]

Tamamlama sırası maddidir: önce ajanın LOOP_COMPLETE işareti; sonra isteğe bağlı until judge; sonra kullanıcının istediği tekrar sayısı; sonra genel tick bütçesi; sonra yeni zamanlama. İşaret yolu judge'dan önce gelebilir. N tekrarın done olması, izlenen dış durumun istenen sonuca geldiğini zorunlu kılmaz; yalnız o tekrar sözleşmesi bitmiş olabilir. Config backstop ise done değil pause üretir. [S04]

Self-paced aralık benzer yanıtlar geldiğinde büyür, değiştiğinde küçülür. Bu yanıt temsiline dayalı bir cadence kararıdır; dış dünya gerçekten değişmediğini ölçen bir garanti değildir. Aktif ve park edilmemiş goal, loop tick'ine öncelik taşır. CLI slash-command loop'u model yanıtına gitmediği için ayrı immediate-completion yolu kullanır. [S03/S04]

Loop state'in saklanması tek başına restart recovery'nin tamamlandığını göstermez: awaiting_response true kalmış kayıt, entry/source rebinding ve canlı driver'ın yeniden kurulması ayrıca gerekir. U04 full driver/crash deneyi değildir.

## 7. `/heartbeat`: kayıt, canlı nesne ve tetikleyici

HeartbeatState daha küçük bir recurring istem kaydıdır: prompt, interval, active/paused/cleared, created/last_fired ve count. Semantik done/judge sözleşmesi taşımaz. Zamanı gelince due_prompt canlı sayacı ilerletip kaydetmeyi dener ve istemi döndürür; kaçırılmış aralıklar geçmişten N istem biriktirmek yerine tek fire'a birleşir. [S05]

H01 normal set/load/due davranışını, H02 pause/resume/clear'ı, H03 ise sadece son fire halen aynıysa abandon ile geri alma ve araya girmiş pause'u korumayı gösterdi. Bunlar tam S05 kaynak modülü ve gerçek geçici SQLite adapter üzerinden gerçekleşti; saat sentetikti.

H04'te yalnız adaptör set_meta yazısına hata enjekte ettik. due_prompt istem döndürdü ve canlı nesnede fire_count=1 oldu; yeni manager diskten fire_count=0 yükledi. Kaynak hata loglar ama save fonksiyonu receipt döndürmez. Bu ölçüm, gerçek üretim kaybının sıklığını veya tüm SessionDB arızalarını açıklamaz; live/durable ayrımını doğrular.

H05'te aynı kaydı önceden yükleyen iki ayrı manager ardışık due_prompt çağrılarında iki istem üretti; disk sayacı 1 kaldı. Burada paralel thread bile gerekmedi: bayat yerel görünüm yeterliydi. Bu component seviyesinde global atomic claim olmadığını gösterir; gerçek driver'ın aynı oturuma böyle iki manager sürdüğünü göstermiyor. Driver serialization/lease koruması ayrıca incelenmelidir.

## 8. Kalıcı ayar ile yeniden başlayan otomasyon ayrı

İncelenen gateway driver heartbeat için bellekte `_heartbeat_watch` tutar. Source/session bilgisi buraya kaydedildiğinde poller başlar; yalnız state_meta kaydının bulunması bu watch'ı otomatik kurmaz. İlgili kaynak yorumunda da restart sonrası tekrar kayıt gereği açıkça belirtilir. Buna karşılık loop watcher kalıcı `loop:*` satırlarını tarar; route varsa, awaiting/due/host uygunluğu sağlanırsa adapter'a gider. [S06]

Bu farkı 'loop her crash'te kesin devam eder, heartbeat asla devam etmez' diye genellemiyoruz. Tam startup, farklı profile depoları, route/session değişimi, adapter kabulü ve in-flight recovery yolları açık. Daha sınırlı doğru sonuç, tekrar niyetinin kalıcılığı ile onu çalıştıracak driver'ın bulunmasının farklı gereklilikler olduğudur.

Goal/loop/heartbeat migration yardımcıları yeni session'a kopyalama ve eski kaydı clear etme çağrılarını ayrı yapar. Save yardımcıları yazma hatalarını yukarı receipt olarak taşımayabilir. Normal best-effort migration kodunun varlığı tek atomik, kayıpsız transfer ispatı değildir. H04 yalnız heartbeat save sınırını çalıştırdı; gerçek rotation sırasında goal/loop/migration kaybı gösterilmiş değildir. [S01/S04/S05]

## 9. Aynı session ID, aynı history demek mi?

S02 quiet goal wrapper aynı `cli.conversation_history` girdisini tekrar verir ve sonucu yazdırır; result history'yi açıkça bu listeye atadığı görülmez. S08 prologu çağıranın listesini kopyalar. Buradan doğrudan 'HERMES çok turlu geçmişi kaybediyor' sonucuna atlamak yanlış olur: yeni açılan S10 facade, lease admission'dan dönen `conversation_history` ile girdiyi değiştirebilir. Ayrıca rotation recovery ayrı bir yoldur. [S02/S08/S10]

Bu, önceki dar görünüme karşı gerçek bir karşı açıklamadır. Sonraki yük taşıyan consumer `agent/turn_facade_lease.py` 429 ile okunamadı. Normal/history refresh ve gerçek SessionDB tüketicisi kapanmadan 'aynı nesne/same-session' yorumunu kayıpsız bağlam kanıtı yapmıyoruz. Yeni AIAgent/lease modeli çalıştırılmadı.

## 10. Yeni kanıtın ölçüsü

Önceden saklanmış SPEC blob'u `ee17ae74098f941b70e07bcf496d6d9be0206892` sonradan sonuçlara göre değiştirilmedi. Yeni probe tek kayıtlı koşuda G01–G10 ve H01–H05 gruplarını çalıştırdı. Terminal grupları birden çok alt durum taşır; 15 sayısı araştırma ilerleme veya ürün test kapsamı yüzdesi değildir.

Negatif kontroller: superseded kontrolünü açan mutant G05 oracle'ına, tekrarlı finalize kontrolünü kaldıran mutant G09 oracle'ına takıldı; bir byte değiştirilen tam heartbeat dosyası gerçek pre-import kimlik denetçisi tarafından reddedildi. Mutantlar orijinal source'u değiştirmedi. Bu kontroller aynı araştırmacının düzenekleridir, bağımsız replication değildir ve tüm hata sınıflarına duyarlılık ispatlamaz.

Tam S05 kimliği upstream blob'la eşleşti; manuel Kanban seçkisinin yerel hash'i sadece o seçkiyi sabitledi. SQLite adapter gerçek dosyaya yazar ama HERMES SessionDB/init/profile/driver değil. Kanban durumları, judge, callbacks, saat ve fault'lar sentetik. Model/provider/network/process/gerçek hesap/OS signal ve eski suite'ler çalıştırılmadı. Tam gözlemler ve fixtures arşivde; browsing summary onları ikame etmez.

## 11. Ara sentez ve sonraki açıklama boşluğu

[Üçüncü geçici sentez](../../synthesis/03-PERSISTENT-WORK-AND-CONTINUATION-PROVISIONAL.md), U02 iç turu U03 task kabulü ve U04 devam/uyanma yollarıyla birleştirir. HERMES'in kalıcı iş açıklaması genişledi; bütün runtime veya kalite hükmü oluşmadı.

Sıradaki en yüksek değerli sınırlı bağlantı: **session-bound devamın gerçek SessionDB/turn-lease/history ve rotation/restart driver'ına bağlanması**. Bir devam istemi kuyruğa alındıktan sonra hangi history seçilir; in-flight tick durumu nasıl recover edilir; yeni session'a aktarılan kayıt ile yeni driver ilişkisi nasıl kabul edilir? İlk giriş S10'un admit_durable_turn_lease çağrısı, sonra gerekli SessionDB ve ilgili driver startup/recovery consumer'ıdır. Bu sıra yalnız erişilemeyen dosyayı tekrar istemek için değil, kalıcılık ile gerçekten yeniden çalışabilme arasındaki açığı kapatmak için seçilmiştir. Ardından task cancellation/delegation, scheduler/cron, provider/backend ve geniş F01–F12 yeniden önceliklenir.
