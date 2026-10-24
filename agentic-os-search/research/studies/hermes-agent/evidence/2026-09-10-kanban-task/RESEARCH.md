# U03 — Kalıcı iş, çalıştırma sahipliği ve kabul sınırı

**Özgün çalışma: 2026-09-10. Bu okunabilir kayıt: 2026-09-11 yayın kurtarması.** Bu metin, önceki turda gerçekten getirilen sabit kaynak seçkileri ile kurtarılan deney paketini birleştirir; daha önce yazılmış ve şimdi aynen kurtarılmış bir araştırma metni olduğu iddia edilmez. Yeni kaynak araştırması, yeni HERMES koşusu veya bağımsız tekrar doğrulaması değildir. Primary pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`; [SOURCES](SOURCES.md), [SPEC](SPEC.md), [kayıtlı sonuç görünümü](RESULT-SUMMARY.json), [özgün ham paket](original-evidence.tar.xz).

## 1. Tek görev, birden fazla deneme

İncelenen Kanban yolu sohbet oturumundan ayrı kalıcı bir board veritabanı kullanır. `tasks` işi, `task_runs` o işi yürütme denemelerini, `task_events` geçişleri, `task_links` bağımlılıkları, comments/attachments ise bilgi ve teslim bağlarını taşır. Task üzerindeki `current_run_id`, halen etkin denemeyi gösterir. Yeni bir claim yeni run açabilir; aynı görev kimliğinin korunması eski çalışanın halen yetkili olduğu anlamına gelmez. [U03-S01]

Bu model bütün normal HERMES konuşmalarının zorunlu görev modeli değildir. Araç yüzeyi dispatcher çalışanı veya açıkça Kanban araç kümesi etkin profil için görünür olabilir. Board koordinasyonu ile profil-özel yapılandırma/bellek de aynı depolama alanı değildir. [U03-S01/S04]

## 2. Oluşturma ve çalıştırılabilirlik

`create_task` başlığı ve seçili girdileri doğrular, ebeveynleri bağlar ve oluşturma olayını kaydeder. `initial_status="running"` parametresinin adına bakarak yeni kartın gerçekten running olduğunu söylemek yanlıştır: incelenen `_initial_task_status` normalde ready veya ebeveynler bekleniyorsa todo üretir; blocked ve triage ayrı park yollarıdır. Görev oluşturma ile çalıştırma sahipliğini alma ayrı geçişlerdir. [U03-S01]

`recompute_ready` bağımlılıklar ve belirli block/failure durumları üzerinden adayları yeniden değerlendirir. Daha önemlisi, gerçek `claim_task` girişinde ebeveynler tekrar kontrol edilir. Bir başka yazar kartı ready yapmış olsa bile tamamlanmamış ebeveyn claim'i reddettirebilir. Completion da ebeveyn koşuluna yeniden bakar. Sadece erken bir hazır etiketi sonraki bütün geçişlerin yetkisi değildir. [U03-S01; K04]

Idempotency anahtarının incelenen oluşturma yolunda transaction öncesi sorgulanması ile claim'in transaction içindeki compare-and-swap işlemi aynı güvence değildir. Kaynak iki durumu farklı ele alır; burada eşzamanlı task creation deneyi veya bütün girişlerde exactly-once hükmü yoktur. [U03-S01]

## 3. Claim, dispatcher ve çalışan kimliği

`_claim_and_open_run`, uygun durum ve boş claim koşuluyla kartı running yapar, run kaydı açar, active pointer'ı ve claimed olayını aynı yazma transaction'ında bağlar. `write_txn` BEGIN IMMEDIATE kullanır; iç içe composition ancak açık savepoint izniyle yapılır. Transaction sınırı retry'si gövdenin yeniden çalıştırılmasıyla karıştırılmamalıdır. K02, iki thread ve ayrı gerçek SQLite bağlantısı altında tek claim/run kaydedildiğini bildirir; gerçek çok-process dispatcher testi değildir. [U03-S01/S02; K01/K02/K08]

Dispatcher yalnız ready etiketine bakıp süreç açmaz: profilin çalıştırılabilirliği, kapasite, yeniden başlatma engelleri, workspace hazırlığı ve claim de devrededir. Normal spawn yolu task ID, run ID, claim lock, board veritabanı ve workspace bağlarını alt sürece geçirir. Sürecin başlatılabilmesi başarı sayılıp önceki failure sayacını sıfırlamaz. [U03-S03]

Tool handler'ın çalışanı kendi task'ıyla sınırlaması, alt-agent bağlamını reddetmesi ve `_worker_run_id` üzerinden completion'a expected ID vermesi ayrı katmandır. Low-level `complete_task(expected_run_id=None)` operator-style kullanımını kabul edebilir. K07 bu düşük seviyeli sınırı gösterir; normal dispatcher'ın ID'yi vermediğini veya bütün yetki kontrollerinin etkisiz olduğunu göstermez. [U03-S01/S04; K07]

## 4. Tamamlandı metni, kabul edilmiş görev ve doğru iş farklıdır

`_handle_complete` girdiyi/çalışan bağını hazırlayıp `complete_task` sonucunu tüketir. İncelenen completion transaction'ı task'ı done yapar, claim alanlarını temizler, etkin run'ı completed olarak kapatır ve completed olayını yazar. Expected run verilmişse SQL güncellemesi current run eşleşmesini de ister. K03'te A geri alındıktan sonra B claim alır; A'nın geç completion'ı reddedilir, B korunur ve B tamamlayabilir. Gerçek worker öldürülmesi bu deneyin parçası değildir. [U03-S01/S04; K03]

Bunlar mekanik kabul kurallarıdır; teslimin gerçekten kullanıcı amacını karşıladığını ölçen evrensel bir oracle değildir. Created-card kontrolleri, artifact koruma ve review yolları başka özellikleri korur. Goal-mode tool yüzeyindeki judge koşulludur; erişilemez veya arızalı judge için devamı mümkün kılan dallar vardır. Judge'ın varlığı veya yeni bir reviewer run açılması epistemik bağımsızlık/kalite ispatı değildir. [U03-S01/S04]

`request_review` implementer/reviewer kökenini ve run bağını kaydeder; review claim ayrı deneme açar. `request_changes` çalıştırmanın gerçekten review'dan geldiğini kontrol edip kayıtlı implementer'a geri yönlendirir. Bu yollar kaynakta incelendi; K setinde gerçek review/goal judge çalıştırılmadı. [U03-S01/S04]

## 5. Transaction içindeki arıza ile sonrasındaki arıza

K05'in kayıtlı fault'u artifact-staging callback'inde, task UPDATE'ten sonra fakat commit'ten önce oluşur. Seçili transaction kodu geri alır: kart running, run açık, completion olayı yoktur; düzeltilmiş callback ile tekrar denenebilir. Gerçek artifact kopyalayıcı çalıştırılmadığı için dosya+DB bütünlüğünün tamamı buradan doğrulanamaz. [K05; U03-S01/S02]

K06'da fault, task/run/completed olayı commit edildikten sonra ayrı child-promotion callback'inde oluşur. Çağırıcı exception görürken yeniden açılan SQLite bağlantısı done ve completed kaydını görür; tekrar completion False döner. Bu, yalnız hata mesajının durumun geri alındığını göstermediğini ayırt eden kontrollü bir sonuçtur. Gerçek üretim arızası/frekansı veya bütün post-commit telafi yolları hakkında hüküm değildir. [K06]

Normal kaynak completion'dan sonra failure reset, bağımlı işleri yeniden değerlendirme, workspace cleanup ve observer çağrılarını ayrı aşamalarda yapar. K seti bu gerçek yardımcıların tümünü çalıştırmadı. Bu yüzden 'task committed', 'caller success', 'bağımlı işler uyandı', 'artifact erişilebilir' ve 'kullanıcıya teslim edildi' aynı kapanış değildir. [U03-S01/S03/S04]

## 6. Başarısızlık ve yeniden deneme

Kaynakta dead-worker, stale claim, heartbeat, timeout ve orphan reconciliation farklı durumları ele alır. Running kartı bırakıp rc=0 ile çıkan çalışan, görev completion'ı olarak kabul edilmez; protocol-violation muhasebesi ve sınırlı yeniden deneme yolu vardır. Kota nedeniyle dönüş ise ayrı işlenir. Bu ayrım, 'process başarılı çıktı' ile 'task kabul edildi' arasındaki farkı genel tur sentezine bağlar. [U03-S03]

Otomatik reclaim'in bazı yolları yerel çalışanın gerçekten sonlanmadığı durumda claim'i bırakmayı erteler. Manuel reclaim ve diğer watchdog yollarının bütün koşulları aynı değildir; bir yoldaki kontrol bütün cancellation yollarına genellenemez. K03 yalnız sentetik no-process termination bağıyla manuel reclaim/yeniden claim/late completion zincirini sınar. OS sinyali, canlı worker, otomatik watchdog veya üretim concurrency koşusu yoktur. [U03-S01/S03; K03]

`block_task` tek bir insan-bekleme etiketi değildir: dependency için todo, diğer belirli tekrarlar için blocked/triage yolları bulunur. Review'dan gelen işin hangi faza döneceği için event/run kökeni kullanılır. Block recurrence ile dispatcher failure sayacı ayrı tutulur. Bütün bu yolların aynı success/terminal semantiği taşıdığı varsayılmamalıdır. [U03-S01/S03]

## 7. Görevden sonraki çalışana bilgi nasıl taşınıyor?

`build_worker_context`, görev gövdesi, attachments, geçmiş denemeler, tamamlanmış ebeveyn handoff'ları, profilin yakın geçmişi ve comments üzerinden sınırlı bir görünüm oluşturur. Liste/metin sınırları ve yaş bilgisi, depolanan her bilginin modele eksiksiz ve güncel olarak aktarıldığı anlamına gelmediğini açık eder. Kaynakta ebeveyn sonuçları point-in-time snapshot olarak işaretlenir. [U03-S01]

Dolayısıyla kalıcı görev belleği, çalışan sürecin belleği ve modele taşınan görev görünümü farklı yüzeylerdir. Araştırmanın önceki prompt/sidecar/oturum ayrımı burada task/run/handoff düzeyinde başka bir devam mekanizmasına bağlanır. Bu bir cross-module çıkarımdır; her sonraki işin kalitesinin arttığı gösterilmemiştir.

## 8. K01–K08 kanıtının gerçek sınırı

Özgün RESULT.json, koşu zamanını `2026-09-10T20:06:13.848575+00:00` olarak taşır. Sekiz ana durumun beklentiyle eşleştiği; yerel kaynak değişikliği, run-ID koşulunun kaldırılması ve rollback yerine commit mutantının ilgili kontrollerce ayırt edildiği kayıtlıdır. Negatif kontrollerin kapsamı bu değişikliklerle sınırlıdır. Arşivde tam ham gözlemler, fixture'lar ve mutant gövdelerini kuran kod birlikte korunur.

Seçkiler manuel aktarılmıştır. Yerel dosya hash'leri doğrulandı; tam upstream parent byte/AST sadakati doğrulanmış değildir. DDL azaltılmış fixture'dır; init/migration, delegated-child/profile guard, artifacts, hooks ve bazı recovery/fan-out yardımcıları taklittir. Model/provider, gerçek uygulama, worker/dispatcher process, OS termination ve notification çalıştırılmamıştır. Dosyaların parse edilmesi veya hash eşleşmesi yeni behavior kanıtı değildir.

İlk çağrının metadata toplarken `platform.platform()` üzerinden uname başlatmaya kalktığını hata günlüğü kaydeder. Düzenek kendi process yasağına takılmıştır. İki script arasındaki tek farkın `platform.platform()` yerine `sys.platform` olduğu kurtarmada doğrulandı. Kayıtlı sonuç düzeltilmiş çağrıya aittir; ilk çağrının görünmeyen vaka sonuçları bağımsız kanıt sayılmaz.

## 9. Araştırmanın devamı

Bu yayın eski çalışmayı görünür kılar; yeni HERMES genel CORE veya üçüncü tamamlanmış alt-sistem sentezi değildir. İlk iki provisional sentez korunur. Bir sonraki teknik çalışma, mevcut Kanban kabul modelini gerçek goal-loop/worker devamına bağlamak ve goal/loop/heartbeat'in aynı mı farklı mı süreklilikler taşıdığını kaynak üzerinden ayırt etmektir. Full-parent seçki sadakati, daha güçlü runtime/güvenlik iddiaları için açık doğrulama borcudur; bütün araştırmayı aynı sekiz dar senaryoyu çoğaltmaya kilitlemez. Ayrıntılı yetki ve sıra [STATE](../../STATE.md), [plan](../../RESEARCH-PLAN.md) ve [açık sorulardadır](../../OPEN-QUESTIONS.md).
