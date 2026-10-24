# U09 — Planlanan çalıştırma, tetikleme kabulü ve yeniden kurma

**2026-09-12 / PINNED SOURCE STUDY — NO NEW BEHAVIORAL EXECUTION.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. Bu, güncel ürün veya bütün HERMES hakkında bir güvenilirlik hükmü değildir. [SOURCES](SOURCES.md) tam/seçili okumaları, [CHECKS-NOT-RUN](CHECKS-NOT-RUN.md) gerçek yapılmamış deneyleri, [PUBLICATION](PUBLICATION.md) repository yayınını taşır.

## 1. Amaç, devralma ve bu turun gerçek ilerlemesi

Kullanıcının kabul ettiği sıra önce U08 yayınını tamamlamak, ancak gerçek geri okumadan sonra araştırmaya devam etmekti. U08 içerik commit'i `e30f6ee6a027ec247fd3dff6cb28f9a3d7ade1ca`, doğrulanmış yayın makbuzu `c370cbc88823f7ee4d07aa6c97b75cf509129254` ile bu kapı geçildi. Aradaki Foundation commit'leri korundu; eski B/D/L deneyleri tekrar edilmedi. U09 araştırma tabanı ikinci commit'tir. U08 yayını yeni bir HERMES davranış deneyi değildir.

Kayıtlı Q47 sorusu: aynı kalıcı iş, onun belirli bir zamanda planlanmış çalıştırılması, gelen tetikleme ve kabul edilen deneme hangi kimliklerle ayrılıyor? U08'in teslim/iptal araştırmasını tekrar büyütmek yerine bu yeni bağlantı incelendi. Q49'un gerçek run_job/betik/ajan bağlamı bir sonraki kaynaktır; bu tur onun bütün iç yürütmesi araştırılmış sayılmaz.

**Ana bulgu:** dış zamanlayıcıya kayıt açarken kullanılan iş+zaman anahtarı, geri dönen tetiklemenin agent tarafındaki kabulüne aynı kimlikle bağlanmıyor. İncelenen sabit sürümde aktif çalışma hakkı ve iş durumu kontrol ediliyor; fakat bunlar tamamlanmış eski bir occurrence'ın tekrarını ayırt eden kalıcı kimlikle eşdeğer değil. Bunu gerçek üretimde ikinci çalıştırma gözlemi olarak değil, kaynakla bağlanmış kabul sınırı olarak kaydediyoruz. [S01–S09]

## 2. Aynı isim altında toplanmaması gereken kimlikler

| Nesne | İncelenen temsil | Neyi tek başına kanıtlamaz? |
|---|---|---|
| Kalıcı iş | profile kapsamındaki job.id ve jobs.json kaydı | Belirli bir gün/saatteki tek occurrence |
| Planlanan zaman | next_run_at; dış provision'da fire_at | O zamana ait çağrının kabulde gerçekten karşılaştırılması |
| Dış kayıt tekrar anahtarı | Chronos dedup_key = job_id:fire_at | Geri dönüşte aynı occurrence'ın ikinci kez kabul edilmeyeceği |
| Çalışma hakkı | fire_claim.by = makine/işlem bilgisi + her edinimde yeni UUID; at | Hakkı temizlenmiş eski occurrence'ın hatırlanması |
| Çalıştırma denemesi | execution_id, provider kaynağı ve audit kaydı | Kullanıcı işinin başarılı olması veya HTTP yanıtının exact denemeyi göstermesi |
| Tek-seferlik bütçe | repeat.completed / repeat.times | Başarılı sonuç ya da benzersiz occurrence kimliği |
| HTTP sonuç etiketi | accepted / duplicate / gone / gateway_stopped | Tek başına tamamlanma, teslim veya bütün redlerin aynı nedeni |

Bu tablo Foundation ontolojisi değildir; okunmuş native sözleşmelerin sorumluluk ayrımıdır. Aynı iş ID'si birçok denemede kullanılabilir. Aynı callback'e her seferinde yeni execution_id üretilmesi de onu farklı, meşru bir occurrence yapmaz. [S01,S02,S03,S06,S08]

## 3. Planın dışarıya taşınması ve dönüşte daralması

Chronos `_arm_one_shot`, işin next_run_at alanını fire_at olarak gönderir; dedup_key iş ID'si ile bu zamanın birleşimidir. `_nas_client.provision`, bu alanları ve callback adresini NAS'a ileten gerçek çağırandır. Wire belgesi NAS'ın agent+job anahtarıyla kayıt tutup yeni zamanı eskisinin yerine koymasını tarif eder. **Bu dış servis davranışı belgelenmiş kontrattır; NAS implementasyonu veya canlı servis bu tur incelenmedi.** [S03,S04,S07]

İçeri gelen sözleşme body'de job_id ile fire_at taşıyabilir. Buna rağmen sabit gateway `_handle_cron_fire`, body'den yalnız job_id seçer ve provider.claim_fire'a yalnız bu ID'yi geçirir. fire_at'ı beklenen zamanla eşleştiren parametre yoktur. Hosted dashboard yolu da farklı bir telafi eklemiyor: `cron_fire_webhook` profili iş kimliğinden bulur; `_forward_cron_fire_to_gateway` gateway'e yeni JSON olarak yalnız job_id ve mevcut Bearer başlığını gönderir. Helper yorumundaki byte-preserved sözü bütün request body'nin korunduğu anlamında kullanılamaz. [S06,S08,S09]

Verifier, token'ın yapılandırılmış audience/key ve purpose koşullarını denetler. Bu kimlik doğrulama, tetiklemenin belirli bir planlanmış zamana ait olduğunu doğrulamakla aynı işlem değildir. Buradaki araştırma geçerli kimlik doğrulamasından geçen çağrılar arasındaki iş/zaman eşlemesiyle ilgilidir; yetkisiz çağrı üretilebildiği veya bir istismar gösterildiği iddia edilmez. PyJWT, JWKS, token oluşturma veya canlı kimlik doğrulama bu tur çalıştırılmadı. [S05,S06,S08]

## 4. Kabulden önce gerçekte hangi kontroller var?

Base provider `claim_fire` önce claimed bir execution kaydı oluşturur. Sonra gerçek jobs.claim_job_for_fire işlevini çağırır. Başarılı dict sonucuna execution_id eklenir; kayıt hatası veya başarısız claim ayrı failure yollarıdır. Chronos bu claim işlevini override etmez; after-run re-arm için fire_claimed'i override eder. Dolayısıyla ortak kabul işlevi bu dış provider için de yük taşıyan gerçek yoldur. [S02,S03]

İncelenen `claim_job_for_fire` şu sınırları uygular: bulunmayan iş; gerçek terminal durum; açıkça force verilmediyse disabled/paused iş; hâlâ canlı fire_claim. İşlem profile+job kapsamlı fire fence altında yürür. `_with_job` yalnız job ID ile kaydı bulup callback'i çağırır; `load_jobs` kayıtları yükler, due-scan yapmaz. `is_job_runnable` enabled ve pause işaretlerini denetler. Bu yardımcıların hiçbiri incelenen kabul zincirine next_run_at <= now karşılaştırması eklemez. [S01]

Kabul edilirse her edinim için yeni owner token yazılır. Recurring işte next_run_at ileri hesaplanıp kaydedilir. Bu işlem atomik sahiplik ve stale-owner koruması bakımından anlamlıdır; ancak **gelecek zamanın kaydedilmesi, sonraki kabulün o zamanı kontrol ettiği anlamına gelmez**. Per-job fence alınamazsa False dönmesi de eski occurrence'ın tanındığı anlamına gelmez. [S01]

Bu açıklama concurrency'nin bütün platform/dosya sistemi koşullarını kanıtlamaz. U07'nin genel jobs lock'unun degraded mode'u ile fire fence'in fail-closed davranışı ayrımı korunur. Burada güçlü sonuç zaman/occurrence kabulündedir; tüm dış araç etkileri için exactly-once hükmü verilmez.

## 5. Belge–kod farkını ayıran koşullu durum izi

Wire belgesi, ilk çalışma tamamlandıktan sonra gelen eski callback'in de claim/time-advance nedeniyle düşeceğini söyler. Aynı belgede yalnız job_id'nin kullanıldığı da açıkça yazılıdır. Kodun kabul ve kapanış yolları birlikte okunduğunda bu geniş açıklama desteklenmiyor. [S01,S07]

Aşağıdaki sıra **kaynak çıkarımıdır; çalıştırılmış deney veya ölçülmüş zaman çizelgesi değildir**:

| Adım | Açık koşul ve kaynakta karşılığı |
|---|---|
| T0 | Sağlam kayıtta enabled, unpaused, terminal olmayan recurring bir iş bulunur; tekrar bütçesi bitmemiştir. |
| T1 | İlk kabul fire_claim ve bir execution_id oluşturur. Hâlâ canlı aynı claim varken gelen ikinci istek reddedilebilir. |
| T2 | İlk turun normal mark_job_run yolu başarıyla kalıcılaşır. `_record_run_outcome` fire_claim'i temizler; `_advance_after_run` işi scheduled ve next_run_at'ı gelecekte bırakabilir. |
| T3 | Eski occurrence'a ilişkin geç bir çağrı yeniden geçerli kimlik doğrulamasından geçer. Dashboard/gateway zinciri bu çağrının eski fire_at bilgisini kabul ölçütüne taşımaz. |
| T4 | Yeni claim mevcut iş durumuna ve canlı hakkın bulunmasına bakar. T2'de hak temizlenmiş ve iş hâlâ runnable ise, dosya/ledger/fence işlemleri de başarılı olduğunda yeni bir claim edinilebilir; gelecekteki next_run_at bu işlevde ret nedeni değildir. |

Dolayısıyla **ilk iş sürerken çakışmayı engellemek ile ilk iş bitince eski tetiklemeyi tanımak farklı korumalardır**. Belgedeki “tamamlandıktan sonra da claim kaybedilir” genellemesi, incelenen agent-side kodla bağdaşmaz. Bu hüküm, dış NAS'ın hangi retry'ları gerçekten gönderdiğini veya sonraki worker'ın hangi araç etkilerini ürettiğini kanıtlamaz. T4'te kabul edilmiş snapshot, tam ikinci işin başarıyla yürütüldüğü anlamına gelmez. [S01–S04,S06–S09]

Aleyhte koşullar ayrıca korunur: canlı claim varsa ret; iş paused/disabled ise ret; tek-seferlik iş terminal kalmışsa ret; bütçe dolup terminalleşmiş recurring işte ret; verifier/ledger/fence/route hatası varsa başka sonuç. Dış servis hiç geç çağrı göndermeyebilir veya kendi kayıt neslini kontrol edebilir. Bu nedenle “her tekrar iki kez çalışır” ya da “HERMES üretimde çift çalıştırıyor” sonucu çıkarılmadı.

Nedensel ayrım: yakın kabul nedeni, temizlenmiş claim ile runnable kaydın yeniden geçebilmesidir. Bunu mümkün kılan bağlantı eksikliği, outward job+time kimliğinin inbound kabul koşuluna taşınmamasıdır. Kaynakta kullanılan aktif-owner kontrolü, geçmiş occurrence kontrolünün görevini üstlenmez. Bu bir source açıklamasıdır; upstream düzeltme tasarımı veya uygulanmış çözüm değildir.

## 6. Built-in zaman kontrolü ve manuel yolları genellememek

Built-in due-scan'de gerçek bir zaman kapısı vardır: `_evaluate_due_job`, next_run_at'ı çözüp gerektiğinde onardıktan sonra gelecekteyse False döndürür. Recurring kaçırılmış çalışmaları, manuel işaretleri, eski cron zamanını ve once grace/bütçe durumlarını ayrı ele alır. `_get_due_jobs_locked` bu seçiciyi her runnable aday için çağırır. Bu kapı, doğrudan external claim yoluna sırf aynı jobs modülünde bulunduğu için eklenmiş sayılamaz. [S01; U07 tick caller reuse]

Planlanmış zaman ile gerçek dispatch zamanı ayrıca last_dispatch kaydında tutulabilir. Bu gözlem kaydı görünürlük sağlar; tek başına inbound occurrence idempotency anahtarı değildir. Ticker'ın önceden next_run ilerletmesi, onun due-scan çağıran bağlamında değerlendirilmelidir.

Manuel yüzeyler de eşdeğer değildir. Gateway jobs/run yolu `trigger_job` üzerinden işi bir sonraki tick için now zamanına ve geçici manual_run_prompt'a bağlar. Dashboard trigger yolu provider.fire_due'yu doğrudan çağırır; paused iş için destek varsa explicit force kullanır. `force=True`, okunmuş claim işlevinde gerçek terminal veya canlı claim kontrolünü kaldırmaz. Bu, manuel şimdi-çalıştır ile dış planlanmış tetiklemenin aynı zaman sözleşmesine sahip olmadığını gösterir. [S01,S06,S08,S09]

`rearm_oneshot` yeni once zamanı doğrular, canlı run/fire claim üzerine yazmayı reddeder, repeat.completed'ı sıfırlar, schedule'ı değiştirir ve aynı job ID'sini etkinleştirir. Bu açık kullanıcı yeniden kurması yeni bir occurrence niyetidir; fonksiyon yeni bir job ID veya kabulde kullanılacak occurrence token üretmez. Böyle bir yeniden kurma sonrası eski callback'in yeni planı tüketip tüketmediği tam uçtan uca deneyle sınanmalıdır; normal terminal one-shot reddini yok saymıyoruz. [S01]

## 7. HTTP makbuzunun gerçekte söylediği

| Yol / yanıt | Kaynağın taşıdığı anlam | Daha güçlü fakat taşınmayan anlam |
|---|---|---|
| Gateway split provider / 202 accepted | claim_fire await'i tamamlanmış; exact snapshot background fire_claimed'e devredilir | Ajan başladı/bitti, çıktı doğru, teslim gerçekleşti |
| Gateway legacy single-phase / 202 | fire_due background göreve verilmiştir | Aynı split yoldaki gibi durable claim zaten alındı |
| Gateway / 200 duplicate | claim_fire None döndü | Mutlaka aynı occurrence daha önce çalıştı; missing/paused/terminal/fence reddi bu etikete de gelebilir |
| Dashboard / 200 gone | Profil/iş aramasında hedef bulunmadı | İşin semantik olarak tamamlandığı kesin |
| Dashboard / 200 gateway_stopped | Ulaşılamayan gateway için kalıcı operator-stop işareti görüldü; retry kesilir | Bu occurrence yürütüldü veya sonucu teslim edildi |
| Dashboard/gateway / 503 | Geçici erişim/admission sorunu; dashboard Retry-After taşıyabilir | Hiçbir önceki çağrı hiçbir etki üretmedi |

Bu yüzden HTTP 2xx tek başına tek bir “başarılı iş” sınıfı değildir. Hosted forwarder response'u aktarır; body'ye job_id ekleyebilir. Kabul yanıtı exact execution_id'yi dışarıya döndürmediği için bu makbuzdan o denemenin sonraki sonucu doğrudan geri kurulmuş sayılmaz. [S02,S06,S08,S09]

## 8. Test karşı okuması ve doğrulama sınırı

`tests/gateway/test_cron_fire_webhook.py` kaynak kodu incelendi; çalıştırılmadı. Spy/Blocking provider'lar claim sonucu olarak kendi dict'lerini döndürür. Barrier testi, 202'nin claim işlevi dönmeden verilmemesini; başka testler ret, reservation ve live-adapter aktarımını denetler. Bunlar anlamlı handler-oracle'larıdır; **gerçek jobs.json/ledger üzerinden tamamlanmış occurrence tekrarını sınayan bir test oldukları söylenemez**. Dosya/suite dışında böyle testlerin hiç bulunmadığı iddia edilmez. [S10]

Bu tur yeni HERMES kurulumu, provider/NAS/JWT çağrısı, gerçek API sunucusu, SessionDB/cron store koşusu veya yeni B/D/L testleri yoktur. Büyük parent'lar yerelde full-byte/AST closure ile materyalize edilmedi. Aynı karar mantığını küçük fake'e kopyalayıp elde edilen kabulü gerçek HERMES sonucu diye sunmak yerine açık NOT RUN kaydı tutuldu. Source-only birim için uydurma RESULT.json veya başarı sayacı üretilmedi.

Default-branch search, daha yeni `a84a2223f82c3d9906fd4a9d778a188774e7a08e` üzerinde occurrence/manual ile ilgili yeni isimler ve test yolları gösterdi. Bunlar yalnız navigation/freshness uyarısıdır: bu tur o sürümün tam davranışı doğrulanmadı, primary yükseltilmedi ve “güncel sürümde düzeldi” denmedi. Public issue arama sonuçları da bağımsız saha kanıtına çevrilmedi. [SOURCES]

## 9. Kapsam kapanışı ve sonraki iş

Q47 için bounded kaynak açıklaması ilerledi: provision kimliği, iki inbound hop, provider claim, generic store yardımcıları, active claim/normal finish, due-scan ve explicit re-arm bağlandı. Belge–kod farkının tam yeri ve rakip koşullar gösterildi. Gerçek late-callback/NAS/multi-process/clock/fault deneyleri açık kaldı; bütün scheduler ailesi tamamlanmadı.

**İlk sonraki geniş birim Q49:** kabul edilmiş scheduled snapshot, shared run_job'da hangi script/no_agent/monitor/agent yoluna ve hangi profile/model/tools/session/history'ye dönüşür? Q47'nin yeni gerçek-runtime kontrolleri, Q40/Q42 ve Q48/Q50 ile birlikte ayrı doğrulama hattında tutulur. Bütün olası hata matrisini bitirmek geniş native açıklamanın ön koşulu değildir. Üç provisional merkezi synthesis ve eski evidence değişmedi; bu birim final CORE, Foundation kararı veya SOUL/Development OS benimsemesi değildir.
