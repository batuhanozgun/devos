# HERMES — Kalıcı iş ve yeniden çalışma: üçüncü geçici alt-sistem sentezi

**2026-09-11 / PROVISIONAL NATIVE SUBSYSTEM MODEL.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [Mekanizma araştırması](RESEARCH.md), [kaynak ve kapsam](SOURCES.md), [deney](evidence/RESULT.json). Bu yerel teslim GitHub'a yayımlanmış sayılmaz.

## 1. Çekirdek açıklama

HERMES'te bir işin sürekliliği yalnız konuşmayı saklamaktan veya modeli yeniden çağırmaktan oluşmuyor. İncelenen kaynaklar üç ayrı geçişi birbirine bağlar:

**Kalıcı iş/talimat → yeni çalıştırma gerekçesi → host tarafından kabul edilen ajan turu.**

Turdan sonra da üç ayrı soru vardır: sonuç bu çalıştırmaya mı aittir; kalıcı kayıt hangi duruma geçti; sonraki tur gerekli midir? Judge, saat ve tekrar sayacı yeni çalışma gerekçesi üretebilir. Run kimliği, state kaydı ve host kuyruğu başka sınırları korur. Birinin varlığı diğerinin yerine geçmez.

Bu model bütün konuşmaları Kanban görevine veya bütün zamanlamaları tek GoalState'e indirgemez. İncelenen dört native yol farklı sürekliliklerdir. [S01–S08]

## 2. Dört yolun taşıdığı süreklilik

| Yol | Korunan nesne / kayıt | Yeni turu doğuran neden | Durmanın anlamı |
|---|---|---|---|
| Kanban goal-mode | Board task ve onun belirli run'ı; döngünün yerel sayacı ayrıca | İlk worker turundan sonra task/run hâlâ sürüyorsa judge yönlendirmesi | Own-run terminal receipt, review devri, sahiplik kaybı, engel veya bütçe; hepsi işin doğru tamamlanması demek değildir. |
| Oturum `/goal` | `goal:<session_id>`: hedef, kriter, contract, gate, bütçe, bekleme | Post-turn gate/judge kararı veya bekleme bariyerinin çözülmesi | Done hedef hükmü; paused engel/hata/bütçe/insan müdahalesi; kayıt başarısı ayrıca gerekir. |
| Oturum `/loop` | `loop:<session_id>`: istem, cadence, tick, route, in-flight işareti | İlk due zaman ve sonraki zamanlamalar | İşaret, until hükmü, istenen tekrar adedi veya güvenlik bütçesi. N tekrarın bitmesi dış koşulun sağlanması değildir. |
| Oturum `/heartbeat` | `heartbeat:<session_id>`: düzenli talimat, aralık, son ateşleme | Idle host'ta aralığın dolması | Manager'da anlamsal done yok; pause/clear düzenli talimatı durdurur. |

Kanban claim heartbeat'i tablodaki son satır değildir. O, yeni istem üretmek yerine belirli işin çalışma hakkını/canlılığını yeniler. Ortak isim, ortak yetki veya ortak kayıt ömrü demek değildir. [S05/S07/S08]

## 3. Kalıcı görev aynı kalsa da çalışanın yetkisi aynı kalmayabilir

U03 task ile run'ı ayırmıştı. U04, bu ayrımın gerçek çok turlu çalışmayı durdurmada kullanıldığını açıyor. Eski run review için kapanınca halef run görevi çalıştırıyor olabilir. Eski döngü `goal_run_status` üzerinden kendi handoff sonucunu görür; halefinin running etiketini kendi devam izni saymaz. Reclaim edilmiş eski run için superseded sonucu başka bir durma nedenidir. [S02/S07; G02/G03]

Böylece iki olumlu kontrol birlikte anlaşılır: iş kimliği kaybolmadan başka çalışana geçebilir; eski çalışan aynı kalıcı kimliğe bakarak görevi devralmış sayılmaz. Ancak check'in zamanı da önemlidir. Judge sırasında sahiplik değiştiğinde seçili döngü bir ek zararsız tur başlatabildi; sonra durdu. Bu kaynak/deney sınırı, gerçek process iptali ve dış etkilerin engellenmesiyle aynı güvenceyi taşımıyor. [G10]

## 4. Değerlendirme, karar ve kabul neden ayrılıyor?

Kanban'da judge'ın done hükmü kartı kendiliğinden kapatmıyor; çalışandan kalıcı kapanış/handoff isteniyor. Bu, “model söyledi” ile “işlem kabul edildi” ayrımını koruyan bir tasarım. Buna karşılık döngünün block sonucu callback'in gerçekten kabul edildiğini doğrulamıyor. Deneyde callback başarısızken döngü blocked sonucu verdi ve görev running kaldı. [G04/G05/G08/G09]

Dolayısıyla döngü sonucu, task/run receipt, process exit ve kullanıcıya teslim farklı kaynaklardan okunmalıdır. Tek bir alanı bütün işin başarı ölçütü yapmak açıklamayı bozuyor. Bu sentez yeni bir evrensel kabul katmanının bütün ürün boyunca uygulandığını ileri sürmez.

Judge'ın girdisi de sınırlı: hedef ve son cevabın kesilmiş görünümü, isteğe bağlı ek kriter/süreç bilgisi. Kaynakta “kanıt ara” talimatı bulunması gerçek dosyanın veya dünyanın ölçüldüğünü göstermez. `/goal` gate'leri ayrı bir ölçüm yüzeyi sağlayabilir, fakat bütün yollar o gate'lerden geçmez. [S01/S08]

## 5. Beklemek ile yeniden yoklamak aynı strateji değil

Oturum GoalManager beklemeyi pid, process-registry trigger veya zamana bağlayabilir. Bariyer altında yeni değerlendirme/tur tüketilmez; canlı host bariyerin çözülmesini izlemelidir. Kanban goal-loop ise WAIT'i CONTINUE yapar. `/loop` zamanlaması yeniden yoklamaya; heartbeat düzenli talimatla geri dönmeye hizmet eder. Birini diğerinin davranış garantisi saymak bütçe ve bekleme semantiğini yanlış gösterir. [S01/S03/S04/S05]

Kendini ayarlayan `/loop` aralığı benzer cevap metinlerinde uzayabilir. Bunun ölçtüğü şey yanıt benzerliğidir, dış dünyanın değişmezliği veya yapılan işin doğruluğu değildir. Bir otomasyonun daha seyrek çalışması tek başına daha iyi karar verdiği anlamına gelmez.

## 6. Sürekliliğin kalıcı ve canlı parçaları

Bir manager'ın durumu saklanabilir, fakat onu çalıştıracak watcher veya route henüz kurulmamış olabilir. Pinned gateway heartbeat watch'ı bellekte tutar; yeniden başlatmada kayıt kalabilse de ateşlemenin yeniden kaydı gerekir. Loop watcher aktif kayıtları tarayan farklı bir keşif yolu kullanır. Yarım kalmış tick, eksik route ve profiller arası kapsamın bütün yeniden başlatma yolları ayrıca araştırılmalıdır. [S06]

Session ID değişimi de yalnız etiket değiştirme değildir. Yeni oturuma manager state aktarımı, eskiyi pasifleştirme ve canlı host'un yeni kimliği izlemesi birlikte gerekir. Tam heartbeat modülünün kontrollü depolama hatasında migration True dönerken child kayıt oluşmadı ve parent cleared oldu. Bu, H09'un gerçek adapter/fixture sınırında ölçülmüş sonucudur; üretim olayına veya bütün manager'ların çalıştırılmış arızasına genellenmez. [H08/H09]

**Kalıcı tanım, kalıcı kabul ve tekrar çalışabilir hale getirme farklı kapanışlardır.** Bu ilişki, önceki öğrenme/değişim sentezindeki “dosyada var” ile “sonraki istekte kullanıldı” ayrımını görev sürdürme katmanına bağlar.

## 7. Sentezin karşı okuması ve sınırı

Bu model source-backed bir alt-sistem açıklamasıdır. Bir full heartbeat modülü ve iki manuel Kanban seçkisiyle sınırlı yürütme yapılmıştır; full SessionDB, worker, OS iptali, gerçek judge, bütün frontend'ler veya son platform teslimi çalıştırılmamıştır. G/H deneyleri bağımsız üçüncü taraf doğrulama değildir.

Olumlu normal kontroller; own-run devri, superseded durması, finalize sonrası terminal okuma, heartbeat gecikmesi, coalescing, reload ve abandon/pause yarışını ayırdı. Negatif sonuçlar yalnız aynı mekanizmaların sınırlarıdır; HERMES'i salt kusur listesiyle tanımlamak doğru değildir.

Üst kesinti/recovery katmanları bazı açık durumları telafi edebilir. Bunların gerçekten nerede devreye girdiği okunmadan telafi varmış veya yokmuş denmez. Daha yeni default-branch davranışları bu sabit sürüme eklenmez. Diğer UI/native/backend yolları açıklamayı bölebilir veya genişletebilir.

## 8. Sonraki açıklama boşluğu

İlk yüksek-değerli birim artık **gerçek oturum deposu, manager state aktarımı ve yeniden etkinleştirme**dir. Kayıt yardımcısının başarı/hata sözleşmesi, child/parent yazımlarının sınırı, session lineage, devam eden tick'in recover edilmesi ve host'un yeni oturuma bağlanması actual consumers üzerinden incelenmelidir.

Amaç H09 benzeri hataları sınırsız çoğaltmak değil; “iş kaldığı yerden devam edebilir” hükmünün hangi kayıt ve canlı tetikleme koşullarına dayandığını açıklamak. Sonra scheduler/cron, delegation, provider/backend, skill-ledger/sync ve diğer açık aileler kapsam değerine göre seçilir.

Bu üçüncü geçici katman HERMES'in nihai CORE'u, tamamlanmış Information–Work–Actors–Environment projeksiyonu, SOUL mimarisi veya benimseme kararı değildir.
