# ECC — Scheduled-work, admission ve retry kullanımları

2026-09-20 · **B6-T17-C5b / U11-B CONTEXTUAL TRANSFER / C5b-PARTIAL**.

Bu dosya Note20/U11-B araştırmasındaki kullanımları çıkarır. Yeni scheduler araştırması, canlı zamanlanmış iş, ortak sözlük veya mimari karar değildir. [READING.md](READING.md) gerçek okumayı ve devamı, [TERMS.md](TERMS.md) kullanım girişini, [global STATE](../../STATE.md) programın güncel işini taşır. SC öneki yalnız kayıt adresidir; kabul edilmiş kavram sınıfı değildir.

## 1. Sabit kaynak ve atıf rolleri

Research repository snapshot: **batuhanozgun/agentic-os-search@04213d5be3d7655fcd55ee20d9f60be3cd44a8c5**. Bu araştırmanın ayrı upstream pin'i: **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Aşağıdaki dört research dosyası tam okundu; içlerindeki upstream kod, cron dokümanı veya testler bu Concepts turunda yeniden okunmuş/çalıştırılmış sayılmaz.

| Anahtar | Kaynak | Git blob |
|---|---|---|
| N20 | [Note20](../../../research/studies/ecc/notes/20-SCHEDULED-WORK-ADMISSION-AND-RETRY.md) | e68ea0b092977a3095f6bb9ff03565805fe3ae73 |
| LB | [U11-B source ledger](../../../research/studies/ecc/evidence/U11-B-SOURCES.md) | c9f6a215be774677cc542fe5208abfddb3934141 |
| MB | [ROUND-U11-B / MR21](../../../research/studies/ecc/ROUND-U11-B.md) | d7bd6db15497d8f52a7658b616a2776f42b8208b |
| PB | [PUBLICATION-U11-B](../../../research/studies/ecc/PUBLICATION-U11-B.md) | c4feb89ba203732990d37e7d9efdfddf4aa768a8 |

Göreli bağlantılar güncel dosyayı açar; exact içerik, aynı yolun yukarıdaki repository snapshot'ında açılmasıyla elde edilir. LB'deki U11B-C/M/S/D sırasıyla main/manager/store/daemon; U11B-T scheduling test; DEP1/DEP2 Cargo manifest/lock kimlikleridir. Bunlar özgün araştırmanın locator'larıdır, yeni Concepts kaynak keşfi değildir.

**Rol anahtarı:** K = araştırmacının pinned koddan raporladığı kullanım/predicate; Y = araştırmacının mekanizma açıklaması veya koşullu karşı-örneği; T = incelenmiş fakat çalıştırılmamış test tasarımı; H = araştırmada tarihli olarak aktarılan bağımlılık sözleşmesi. Türkçe karşılıklar extractor paraphrase'idir; doğrudan ürün tanımı veya bağımsız doğrulama değildir. Y satırlarındaki ayrım/eksiklikler uygulanmış ECC alanı ya da önerilmiş SOUL mekanizması sayılmaz.

## 2. Tekrarlayan talimat, kayıt ve ortam

| ID / ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-SC01 — recurring launch instruction | İleride tekrar seçilip session admission yoluna verilecek kalıcı çalıştırma talimatı. Tamamlanan/accepted task sonuçlarını bekleyen bir iş döngüsü olarak tanımlanmaz. | N20 §1; MB actual result / K/Y |
| ECC-SC02 — due occurrence | Tekrarlayan talimatın belirli vadesine karşılık gelen tekil çalıştırma örneği; vadesinin gelmesi yürütüldüğü anlamına gelmez. Schedule kaydı, session id, wrapper veya tamamlanmış görevle aynı nesne/kimlik değildir; incelenen yol ayrı kalıcı occurrence kimliği kurmuyor. | N20 §1, §5, §8; LB advance / Y |
| ECC-SC03 — scheduled-task row | Expression, task, agent, optional profile name, directory, grouping, worktree flag ve zaman alanlarını taşıyan kayıt. Her gerçekleşmenin sonucunu ve session bağını tutan olay geçmişi değildir. | N20 §2, §8; LB U11B-S / K |
| ECC-SC04 — Schedule Add | Explicit agent veya configured default ile worktree/grouping/profile girdilerini manager'a veren CLI komutu. Komutun kabulü ileride aynı ortamın mevcut olmasını garanti etmez. | N20 §2; LB U11B-C / K |
| ECC-SC05 — create_scheduled_task | CWD/label/agent/profile girdilerini hazırlayıp bir future occurrence hesapladıktan sonra kayıt ekleyen manager yolu. Invalid veya o anda future date'i olmayan expression normal creation yolunda reddedilir. | N20 §2; LB creation / K |
| ECC-SC06 — canonicalized agent | Add girdisindeki explicit/default agent seçiminin manager tarafından normalize edilmiş karşılığı. Kurulu executable, canlı model veya provider doğrulaması değildir. | N20 §2; LB U11B-C/M / K/Y |
| ECC-SC07 — saved profile name | Schedule'a kaydedilen optional profil adı; explicit ad creation'da doğrulanır. Profilin bütün resolved değerleri schedule içinde dondurulmuş değildir. | N20 §2; LB creation / K |
| ECC-SC08 — resolve_launch_profile | Dispatch sırasında saved name'i yeniden çözen veya isim yoksa dispatcher's default profile'ını kullanan seçim. Schedule kimliği aynıyken effective ayarlar değişebilir. | N20 §2; LB U11B-M / K/Y |
| ECC-SC09 — retained daemon Config | Daemon'ın run girişinde aldığı ve döngü boyunca tuttuğu yapılandırma. Dosyayı değiştirmek çalışan daemon'ın anında reload yaptığı anlamına gelmez; yeni CLI/daemon invocation farklı config yükleyebilir. | N20 §2; LB creation / K/Y |
| ECC-SC10 — working directory | Creation anında yakalanıp schedule'a yazılan caller CWD'si. Kalıcı path string'i immutable repository revision veya kullanılabilir environment kimliği değildir. | N20 §2; LB creation / K/Y |
| ECC-SC11 — project group | Schedule/session için taşınan project grouping etiketi. Kaynak, bu etiketi tekil occurrence veya yürütme sahipliği kimliği olarak kullanmıyor. | N20 §2, §8; LB creation/tests / K/Y |
| ECC-SC12 — task group | Ayrı task grouping etiketi. Benzer task metniyle birlikte bulunsa da unique durable occurrence-to-session bağı değildir; project group ile eş anlamlı kabul edilmez. | N20 §2, §8; LB creation/tests / K/Y |
| ECC-SC13 — worktree flag | Çalıştırmada worktree talep edilip edilmediğini taşıyan schedule tercihi. Worktree kapasitesi veya worktree'nin şimdiden yaratılmış olması değildir. | N20 §2, §4; LB admission / K |

## 3. Zaman hesabı ve seçilmiş iş kümesi

| ID / ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-SC14 — cron expression | Schedule'ın gelecekteki zamanlarını tanımlayan parser girdisi. İncelenen ECC yolu beş, altı veya yedi alanlı biçimleri kabul eder; bunların tamamına genel cron standardı tanımı verilmez. | N20 §3; LB timing / K |
| ECC-SC15 — five-field normalization | Beş alanlı girdiye başta sıfır seconds alanı ekleme dönüşümü. Kullanıcının yerel saat dilimini kendiliğinden ekleyen bir dönüşüm değildir. | N20 §3; LB parse_cron_schedule / K |
| ECC-SC16 — six-field form | Beş alan için yapılan eklemeden ayrı, parser'a verilen altı alanlı biçim. Kaynakta bu biçimin her alanına ayrıntılı genel tanım verilmediği için dış bilgiyle tamamlanmadı. | N20 §3; LB timing / K, adlandırılmış |
| ECC-SC17 — seven-field form | Yıl kısıtı da koyabilen kabul edilmiş biçim; finite-date örneğinin girdisi. Her yedi alanlı ifadenin aynı sona erme koşulunu taşıdığı varsayılmaz. | N20 §3, §6; LB dependency / K/H |
| ECC-SC18 — UTC scheduling | Creation ve next-occurrence hesabında kullanılan zaman temeli. İncelenen schema'da schedule başına local-timezone alanı gösterilmez; kullanıcıya yerel saat yorumu atanmaz. | N20 §3; LB timing/dependency / K |
| ECC-SC19 — captured pass now | run_due_schedules_with_runner_program'ın geçiş başında aldığı tek now değeri. Bütün seçilmiş satırların last_run_at ve next-time hesabında kullanılır; her gerçek spawn/yazım anı değildir. | N20 §3; LB U11B-M / K |
| ECC-SC20 — next_run_at | Due selection'ın okuduğu ve admission sonrasında yeniden hesaplanıp yazılan vade alanı. Yeni zaman eski vadeden veya task completion'dan değil captured pass now sonrasından hesaplanır. | N20 §3, §5; LB timing/advance / K |
| ECC-SC21 — last_run_at | Admission dönüşünden sonra schedule'a kaydedilen captured pass timestamp. Gerçek harness başlangıcı, tamamlanma zamanı veya accepted output kanıtı değildir. | N20 §3, §8; LB advance / K/Y |
| ECC-SC22 — due-row snapshot | next_run_at <= captured now koşuluyla okunmuş schedule kayıtları. Seçilmiş snapshot exclusive row claim değildir ve sonra silinen satırın cached içeriğini taşıyabilir. | N20 §3, §7; LB timing/admission / K/Y |
| ECC-SC23 — due-selection order | next_run_at, sonra id sıralaması ve LIMIT ile seçilen küme. Sıra, her due schedule'ın sonunda çalıştırılacağına ilişkin fairness garantisi değildir. | N20 §3, §7; LB timing/failure / K/Y |
| ECC-SC24 — coalescing consequence | Birden çok geçmiş vade kaçırıldığında seçilmiş schedule için bir admission yapıp pass now sonrasına gitme davranışının araştırmacı açıklaması. Her missed firing için launch üretmez; vaat edilmiş catch-up'ın başarısız olduğu iddia edilmez. | N20 §3; MB actual result / Y |
| ECC-SC25 — heartbeat_interval_secs | Daemon'ın session/schedule/remote/backlog/merge/prune/activation işlemlerinden sonra uyuduğu aralık. Bütün döngünün süresi veya cron başlatma gecikmesinin üst sınırı değildir. | N20 §3; LB U11B-D / K/Y |
| ECC-SC26 — CLI run-due | Due schedule dispatch için operatörün çağırabildiği ayrı giriş. Daemon döngüsünün tek çağıran olduğunu varsaymaya izin vermez. | N20 §1, §3, §7; LB U11B-C / K |
| ECC-SC27 — daemon scheduled dispatch | Daemon döngüsünün schedule geçişini bekleyerek yürüttüğü yol. Tek daemon içinde sequential oluşu bütün CLI/daemon çağrıları için singleton sahiplik değildir. | N20 §3, §7; LB U11B-D / K/Y |

## 4. Admission, kapasite ve hazır olma

| ID / ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-SC28 — max_parallel_sessions as due limit | Daemon'ın due query'ye verdiği batch sınırı. Bu çağrı zincirinde mevcut Pending/Running işleri düşen global concurrency reservation olarak kullanılmıyor; diğer ECC yollarına genellenmez. | N20 §4; LB admission / K/Y |
| ECC-SC29 — CLI per-pass limit | CLI run-due'nun bir geçişte dispatch edeceği en fazla due schedule sayısı; default 10. Daemon alanıyla aynı ayar veya global live-work sınırı değildir. | N20 §4; LB U11B-C / K |
| ECC-SC30 — global concurrency reservation | Araştırmanın batch limit'ten ayırdığı daha güçlü eşzamanlı-iş kabul güvencesi. İncelenen scheduled-admission zincirinde live-session sayısından kapasite ayıran kontrol kurulmuş sayılmaz. | N20 §4; LB admission / Y |
| ECC-SC31 — per-schedule non-overlap | Aynı schedule'ın önceki session'ı bitmeden yenisini kabul etmeme güvencesi. Bu zincirde böyle bir kontrol gösterilmez; worktree queue'su bu kontrolün yerine geçmez. | N20 §4; LB admission / Y |
| ECC-SC32 — pending worktree request | Talep edilen worktree için attached-worktree kapasitesi dolu olduğunda saklanan bekleyen environment/launch isteği. Pending session vardır ama bu branch'te runner başlamamıştır. | N20 §4; LB admission / K |
| ECC-SC33 — Ok(session_id) admission | Queue/create yolunun id ile başarılı dönüşü. Hem worktree bekleyen Pending kaydı hem immediate wrapper admission'ını kapsayabilir; id dönmesi aynı readiness sonucu değildir. | N20 §4–5; LB admission/advance / K/Y |
| ECC-SC34 — wrapper spawn PID | Immediate branch'te wrapper spawn'ın PID döndürdüğüne ilişkin kontrol. Harness-ready acknowledgment, accepted task veya wrapper ile child'ın aynı process olduğu kanıtı değildir. | N20 §4; LB admission; önceki R63–R67 / K/Y |
| ECC-SC35 — harness readiness | Schedule admission'dan ayrı, gerçek harness'ın hazır hale gelmesi sorusu. Bu scheduler dönüşü bunu beklemez; sonraki lifecycle başka kaynak kapsamıdır. | N20 §1, §4; LB admission / Y |
| ECC-SC36 — session profile persistence | Dispatch'te çözülen launch profile'ın yaratılan session için ayrıca saklanması. Schedule'ın kendi profil snapshot'ını taşıdığı veya bütün gelecek occurrence'ların aynı ayarları kullanacağı anlamına gelmez. | N20 §2; LB creation/advance / K/Y |

## 5. İlerletme, hata, yeniden deneme ve silme

| ID / ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-SC37 — admission-before-advancement | Due snapshot → session/queue/spawn → next-time calculation → schedule update → returned outcome sırası. Session/profile/queue/OS ve schedule etkileri caller'da tek transaction değildir. | N20 §5; LB advance / K/Y |
| ECC-SC38 — record_scheduled_task_run | last_run_at ve next_run_at alanlarını schedule id ile güncelleyen writer. Expected-old-due, owner token veya claim-state predicate'i taşıdığı gösterilmez. | N20 §5; LB U11B-S / K |
| ECC-SC39 — affected-row count | Schedule writer'ın kontrol etmediği UPDATE satır sayısı. Silinmiş schedule için sıfır satır güncellense de Ok dönebilmesi, kalıcı advancement'ın gerçekten gerçekleştiğiyle aynı değildir. | N20 §5, §7; LB advance / K/Y |
| ECC-SC40 — occurrence-specific idempotent claim | Admission etkisini aynı tekil vadenin tekrar seçimine bağlayabilecek sahiplik/idempotency güvencesi. Araştırma mevcut schema/caller'da bu bağı kurmuyor; yeni uygulanmış alan veya tasarım önerisi değildir. | N20 §5, §7; LB failure / Y |
| ECC-SC41 — queue admission failure | Id dönmeden queue/create yolunun error vermesi; schedule ilerlemez. Hata noktasına göre daha önce session/worktree etkileri oluşmuş olabilir; error no-effect demek değildir. | N20 §5; LB failure / K/Y, conditional |
| ECC-SC42 — post-admission advancement failure | Queue başarılı olduktan sonra next-time veya schedule write hatası. Önceden admitted work varken eski row due kalıp sonraki pass yeniden admission yapabilir. | N20 §5; LB failure / Y, conditional |
| ECC-SC43 — later harness failure | Schedule ilerletildikten sonra lifecycle içinde oluşan failure. Bu caller bunu occurrence-specific retry'ye çevirmiyor; bütün ECC retry yollarının yokluğu iddia edilmez. | N20 §5; LB advance/failure / K/Y |
| ECC-SC44 — first-error batch propagation | Loop'taki ilk queue/time/update hatasında Err ile çıkma. Önceki başarılı etkiler korunur, sonraki due satırlar o pass'te işlenmeyebilir. | N20 §5, §7; LB failure / K/Y |
| ECC-SC45 — persistently failing earliest row | Sıralamada öne gelen satırın tekrar tekrar hata vermesiyle sonraki due işlerin ulaşılamaması karşı-örneği. Bu yolda per-schedule backoff/failure state yazılmıyor; gerçek starvation oranı ölçülmedi. | N20 §7; MB actual result / Y, conditional |
| ECC-SC46 — competing dispatch snapshots | CLI ve daemon gibi iki caller'ın advancement öncesi aynı due satırı okuyup ayrı session id'leri admit edebilmesi. Tek daemon'ın sequential döngüsü bu interleaving'i dışlamaz; concurrency deneyi yapılmadı. | N20 §7; LB admission/failure / Y, conditional |
| ECC-SC47 — finite schedule | İzin verilen son tarihi bulunan schedule. Creation'da geleceği olması, final admission sonrasında bir sonraki tarihin de bulunacağını garanti etmez. Bu nesne, son vade sonrası işlem sorumluluğundan ayrıdır; terminal handling SC61'dedir. | N20 §6; LB dependency / K/H/Y |
| ECC-SC48 — no-future error | after(...).next() gelecekte tarih bulamadığında ECC'nin ürettiği hata. Final occurrence admit edildikten sonra oluşursa eski next_run_at korunabilir; database outage varsayımı gerekmez. | N20 §6; LB failure/dependency / K/H/Y, conditional |
| ECC-SC49 — schedule removal | Schedule satırını silerek sonraki fresh due query'den çıkarma. Önceden seçilmiş snapshot'ı veya yaratılmış session'ı iptal etme işlemi değildir. | N20 §7; LB positive scope / K/Y |
| ECC-SC50 — removal-after-selection | Snapshot alındıktan sonra row silinirse cached task'ın yine admit edilip update'in sıfır satırda Ok dönebilmesi. Ordinary removal'ın future-selection etkisini geçersiz kılan genel hüküm değildir. | N20 §7; LB failure / Y, conditional |
| ECC-SC51 — revocation of admitted work | Seçimden/admission'dan geçmiş işin yürütme hakkı ve etkilerini geri çekme sorusu. Schedule row deletion bu sorumluluğu otomatik yerine getirmez. | N20 §7, §10; LB failure / Y |

## 6. Operatörün gördüğü sonuç ve kanıt kapsamı

| ID / ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-SC52 — ScheduledRunOutcome | schedule_id, session_id, task, expression ve next time taşıyan dönüş kaydı. Kalıcı schedule row'un kendisi veya kabul edilmiş task sonucu değildir. | N20 §5, §8; LB U11B-M / K |
| ECC-SC53 — returned schedule/session association | Başarılı bütün çağrıda CLI'nın yazdırdığı outcome vector'ündeki schedule-to-session bağı. Daemon wrapper'ı success'te uzunluğu loglar; returned relation otomatik durable relation değildir. | N20 §8; LB advance / K/Y |
| ECC-SC54 — durable occurrence/result provenance | Belirli gerçekleşme, yaratılan session, failure reason ve accepted result ilişkisinin kalıcı hesabı sorusu. İncelenen schedule tablosu last/next timestamps tutar; benzer task/grouping unique bağın yerine geçmez. External/custom log ihtimali dışlanmaz. | N20 §8; LB advance / Y |
| ECC-SC55 — partial-effect reporting boundary | Geç satır hatasında önceki başarılı işlerin outcome vector'ünün caller'a dönmemesi; buna rağmen kayıt/etkilerinin kalması. Rapor eksikliği rollback veya hiç iş yapılmadığı anlamına gelmez. | N20 §5, §8; LB failure / K/Y |
| ECC-SC56 — logged schedule-pass error | Daemon'ın schedule geçiş hatasını loglayıp diğer kategorilere devam etmesi ve sonraki döngüde yeniden denemesi. Bütün daemon'ın durması veya occurrence-specific retry/backoff değildir. | N20 §7; LB failure/positive scope / K/Y |
| ECC-SC57 — scheduling test | Temporary Git/store'a doğrudan due kayıt ekleyip internal dispatcher, grouping, outcome ve zaman ilerlemesini kontrol eden upstream test tasarımı. Araştırmada incelendi, çalıştırılmadı; finite/concurrent/removal karşı-örneklerinin deneyi değildir. | N20 §9; LB U11B-T / T |
| ECC-SC58 — fake runner | Scheduling testinde gerçek harness yerine verilen executable; logda task metni aranır. Harness readiness veya model/task quality oracle'ı değildir; helper'ın tam audit'i de yapılmış sayılmaz. | N20 §9; LB test/acquisition accounting / T |
| ECC-SC59 — version-labelled cron contract | Lock'ta cron 0.17.0 beyanı ve araştırmada 2026-09-19'da aynı version etiketli latest doküman/iterator kaynağı. Immutable registry bytes veya installed binary karşılığı doğrulanmış değildir; Concepts yeni dependency doğrulaması yapmadı. | LB DEP1/DEP2/W-U11B-CRON; PB evidence limits / H |
| ECC-SC60 — valid native-created record boundary | Normal creation'dan geçmiş schedule kayıtlarının incelemenin ana girdi alanı oluşu. map_scheduled_task, bütün migrations/malformed timestamps veya arbitrary custom controllers tamamlanmış sayılmaz. | N20 §9–10; LB acquisition/tests / Y |
| ECC-SC61 — terminal schedule handling | İzin verilen vadeler tükendiğinde schedule'ı nasıl sonuçlandıracağına ilişkin işlem/durum-geçişi sorusu. İncelenen yolda ayrı exhausted/completed-schedule transition gösterilmez; finite schedule'ın kendisiyle aynı nesne değildir. | N20 §6, §10; LB failure/dependency / Y |

## 7. Kaynak tarafından kapsam kontrolü

N20 §1 → SC01–SC03/SC33–SC35; §2 → SC03–SC13/SC36; §3 → SC14–SC27; §4 → SC28–SC35; §5 → SC37–SC44/SC52/SC55; §6 → SC17/SC47–SC48/SC59/SC61; §7 → SC22–SC23/SC44–SC51/SC56; §8 → SC21/SC52–SC55; §9 → SC57–SC60; §10 → SC61 ve aşağıdaki ilişki/açık sınır hesabı. LB'nin exact-source, full/selected/incidental, dependency, test ve producer-consumer kapsamları da tam okundu. MB araştırma seçimi ve PB publication tarihi aynı mekanizmanın bağımsız destekleri değildir.

Source note/ledger bu unit için yeni deney olmadığını açıkça söylüyor. Eski E08/E07, yeni scheduling test sonucu olarak kullanılmadı. Testin temporary Git/store içermesi onu bu tur yapılmış bir runtime deneyi haline getirmez. Örnek */15 ifadesi, source locator'ları, Rust hata yayılımı işareti ve SHA/commit değerleri bağlamlarında korundu; genel teknoloji veya cron sözlüğü üretilmedi. Yalnız adlandırılan biçimler dış kaynak tanımıyla tamamlanmadı.

## 8. İlişki ve yorum izi

Normal yol: **SC04–SC05 creation → SC03 kayıt → SC19/SC22 due selection → SC32–SC34 admission → SC20/SC21 advancement → SC52–SC53 response**. Bu görünüm kaynağın kendi zinciridir, evrensel scheduler mimarisi değildir. Sonraki harness lifecycle'ı bu dönüşün içine sıkıştırılmaz.

Önceki R59–R78 ve R90–R104 kayıtları session, Pending, wrapper/child, output ve stop/resume hakkındadır. SC02 occurrence onların yeni adı değildir. SC33'ün queue dönüşü eski R61/R90'ın Pending worktree sınırıyla ilişkilidir. SC10'un path'i R98–R101 resource/native-context ayrımını kaldırmaz. R125–R127 eski-attempt finalizer'ı ile SC46 iki due snapshot'ın ayrı admission'ı farklı hata yollarıdır; birinin kaynak açıklaması diğerinin çalıştırılmış kanıtı sayılmaz.

U10 registry'nin conditional pointer transaction'ı (E30–E32), scheduled-task writer'a taşınmadı: SC38 ilgili writer'ın daha dar id-based update sözleşmesidir. Aynı update/acceptance sözcükleri aynı güvence değildir. N55/N56 insan onayıyla SC33 session admission da aynı karar değildir.

Önemli olumlu karşılıklar korundu: creation invalid/no-future girdiyi reddeder; explicit profile doğrulanır; worktree talebi kaybolmadan Pending queue'da tutulabilir; başarılı advancement eski due kümesinden çıkarır; removal sonraki fresh query'yi etkiler; daemon pass hatası yüzeye çıkar. Daha güçlü exactly-once, non-overlap veya task acceptance bulunmaması bütün mekanizmayı etkisiz ilan etmek için kullanılmadı.

Bu çıkarım önceki kaydı geriye dönük yeniden tanımlamıyor. last_run_at özellikle **captured pass time** olarak tutuldu: yazma anı veya gerçek process start değildir. Finite-date örneği kaynakta koşullu karşı-örnektir; bu tur gözlenmiş duplicate job gibi anlatılmadı. Kullanıcı onayı veya extractor'ın anlaşılır bulması, teknik doğrulama yerine geçmez.

### İlk readback sonrası açıklık

İlk yayın a07d95af0af34858055cec2f118ecf4940b8214f içinde SC47 finite schedule ile terminal handling'i aynı adreste tutuyordu. N20 §6/§10 nesne ile sonrasında gereken işlemi ayırıyor: SC47 schedule'a daraltıldı, SC61 terminal handling olarak eklendi. SC02'nin gerçekleşme sözcüğü de due olmayı fiilen yürütülmüş olmakla karıştırmasın diye açıklaştırıldı. SC17, SC19–SC24, SC37, SC42, SC48 ve kaynak-kayıt eşlemesi kontrol edildi; diğer kullanım açıklamalarını değiştirmek gerekmedi. Bu extractor kaydı düzeltmesidir, yeni ECC bulgusu veya source-study değişikliği değildir.

## 9. Kapanış ve açık sınır

U11-B'nin dört mevcut araştırma dosyasından source-local aktarım kaydedildi. Yayın/readback ve yerel/global devam durumu ayrı kontrol edilir; dosyanın oluşması C5b/C5/C6 kapanışı değildir. SC01–SC61 adreslenebilir kullanım/ilişki kayıtlarıdır, 61 bağımsız kavram veya deney değildir.

Q04e1b'deki runtime timing, malformed/migrated kayıtlar, filesystem/config/binary correspondence, multi-dispatch güvenliği, terminal schedule handling, cancellation/backoff/fairness, durable occurrence linkage ve actual result acceptance açık kalır. Bunlar yeni Concepts deney borcu veya benimsenmiş düzeltme değildir. Yeni Rust/SQL/test/model/provider, canlı schedule, installation veya upstream mutation yapılmadı. E08/E07 ve iki E05 geçmişi kendi kapsamındadır, E06 excluded kalır. Sıradaki kaynak U11-C remote intake/routing/result ailesidir; henüz bu dosyayla okunmuş veya aktarılmış sayılmaz.
