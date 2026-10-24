# U10 — Zamanlanmış işin yürütme ve bilgi bağlamına dönüşmesi

**2026-09-12 / PINNED SOURCE STUDY + BOUNDED NATIVE SELECTOR EXECUTION.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. Araştırma tabanı `938359a1c4b0a01dd7bab5f4647e0474872b2078` (U09/v0.22). [SOURCES](SOURCES.md) kaynak kapsamını; [SPEC](SPEC.md), [RESULT](RESULT.json), [MANIFEST](MANIFEST.json) yeni koşuyu; [CHECKS-NOT-RUN](CHECKS-NOT-RUN.md) kapanmayan sınırları taşır. Yayın hükmü yalnız [PUBLICATION](PUBLICATION.md)'dadır. Buradaki kaynak açıklaması güncel ürün/kurulu binary veya bütün HERMES güvencesi değildir.

## 1. Soru, devralma ve kapsam

Kullanıcının devam yetkisiyle kayıtlı Q49 araştırıldı: kabul edilmiş scheduled snapshot, hangi koşullarda betik çalıştırır veya ajan kurar; hangi model, araç, profil, çalışma dizini ve bilgiyle ilerler? U08/U09 yayınları zaten tamamlanmıştı. Bu tur onların yeniden aktarımı veya eski deneylerin tekrarı yapılmadı. Yeni araştırma U10'dur.

Araştırma sadece hata bulmaya indirgenmedi. Normal agent yolu, ajan açmayan script yolu, izleyici/wake gate, bağlam oluşturma, runtime seçimi ve sonuç/persistence tüketicileri birbirine bağlandı. Kritik alt sınırlara kadar inildi; bütün provider/backend/işletim sistemi ekosistemi veya gerçek model isteği çalıştırılmadı. HERMES dışındaki çalışma alanları ve upstream kod değişmedi.

**Ana sonuç:** scheduled job, tek bir uzun yaşayan sohbetin her seferinde yeniden çağrılmasıyla açıklanmıyor. İncelenen normal yol, ayrı deneme/oturumla bir çalışma kuruyor; süreklilik ise önceki çıktı dosyası, iş not defteri, yerleşik/harici bellek, prefill ve proje bağlamı gibi ayrı kanallardan geliyor. Bu kanalların kaydedilme, seçilme ve başarıyla ilişkilendirilme ölçütleri aynı değil. [S01–S07,S09]

## 2. Kabul edilmiş snapshot'tan gerçek çalışmaya

`run_one_job`, yoksa execution kaydı oluşturur; koşulları sağlanan detached-worker yoluna devir mümkün olmakla birlikte, bu turun ana incelemesi shared local body ve onun altındaki `run_job`'dır. Aktif fire sahibinin ilk doğrulaması ve heartbeat'i, önceki Q47 kabulünden ayrı bir yürütme giriş kapısıdır. `_run_one_job_body`, finite one-shot dispatch hakkını önce tüketir; in-process yol claimed→running geçişini kazanamazsa user script/agent işine girmez. Job ID, execution ID ve aktif owner bu yüzden eşit nesneler değildir. [S01]

Body, profile secret scope ve terminal policy scope kurar; kapsam yalnız ajan turunu değil çıktı kaydını, teslimi, bookkeeping'i ve temizliği de sarar. `run_job`'a exact execution ID, varsa geçici ek prompt ve cancellation birleşimi geçer. Dönen `(success, output_document, final_response, error)` tuple'ı doğrudan kullanıcı kabulü değildir. Body daha sonra ownership/interruption/boş yanıt kontrolleri ve owner-fenced terminal kayıtları uygular. Bu kaynak sırası gerçek tam-host koşusu olarak sunulmaz. [S01]

## 3. Modeli hiç çağırmayan ve çağırabilen yollar

| Dal | Model öncesi davranış | Sonucun niteliği |
|---|---|---|
| `no_agent` + script | Betik doğrudan işin kendisi; başarılı stdout teslim adayı, boş stdout veya exact wake false sessiz sonuç | AIAgent import/kurulumuna geçmeden dönen script sonucu; yeni cron agent session açıldığı varsayılmaz |
| Agent job + boş görev içeriği | Kullanılabilir prompt/skill/script yoksa block/pause | Tekrar tekrar boş iş başlatmayı azaltan operasyonel ret; pause yazısının başarısı ayrıca mümkündür/başarısız olabilir |
| Monitor | Kaynak hatası error; değişmemiş içerik no_change + SILENT; ilk/değişmiş içerik prompt'a eklenir | Tetikleme olmuş olması modelin çalıştığı anlamına gelmez |
| Agent job + pre-run script | Betik bir kez çalışır; cached sonuç prompt builder'a verilir; başarılı exact wake false modelden önce döner | Başarısız veri toplama script'i ise Script Error bağlamıyla ajana kadar gidebilir; no_agent hata yolu ile eşdeğer değildir |
| Normal agent | Prompt/gate/config/runtime aşamalarından sonra yeni ajan ve worker | Model/araç çalışması; eski konuşmanın otomatik replay'i değil |

`_parse_wake_gate` yalnız son boş-olmayan satırın JSON nesnesinde `wakeAgent` değeri gerçek boolean false ise uyanmayı bastırır. Diğer yazımların otomatik aynı anlama geldiğini varsaymıyoruz. Bu parser kaynakta okundu; yeni deney yalnız geçmiş çıktı seçicisidir. [S01,S02,S03,S05]

Genel “model çağrısı yok” ifadesi bu erken-return dallarındaki AIAgent turunun açılmamasını anlatır. Monitor URL veya script kendi dış etkilerini üretebilir; betiğin internali başka hizmet çağırabilir. Dolayısıyla erken gate bütün sistemin hiçbir ağ/yan etki üretmediği güvencesi değildir.

## 4. Çalışma dizini, profil ve otorite

`_CronRunScope`, `job.origin` alanını mevcut kullanıcı göndericisi gibi taşımıyor. Chat/platform alanlarını boşaltıp cron delivery hedefini ayrı değişkenlerde tutuyor; non-dispatcher context, ambient Kanban görevinin ilgisiz bir cron işi tarafından kapatılmasını önlemeye yönelik. Stateless/async_delivery=False beyanı, cron turu bittikten sonra sahipsiz kalabilecek async alt-ajan sonucuna karşı inline delegation yolunu istemektedir. Alt delegation implementasyonu ve gerçek etki koruması bu tur bütünüyle sınanmadı. [S01]

Bu iç session scope, agent yolunda erken gate'lerden sonra kurulur; no_agent ve monitor erken dönüşleri onu kullanmaz, fakat shared body'nin dış profile kapsamındadır.

Tool task ID'si `cron:<job>:<execution-or-UUID>` iken konuşma session ID'si `cron_<job>_<saniye-hassasiyetli-zaman>` biçiminde kuruluyor; usage audit ayrıca bir fire UUID üretir. Bu farklı kimliklerin hepsini tek “run ID” sanmamak gerekir. Çakışma/yeniden başlatma deneyi yapılmadı; biçimden evrensel benzersizlik veya gerçek çakışma hükmü çıkarılmadı.

**Kaynakla belirlenen varyant farkı:** no_agent, çözümlenmiş job.workdir'i script helper'a verir; monitor_script de workdir geçirir. Agent job'ın pre-run script çağrısı ise workdir argümanını geçirmez. Gerçek script helper onu iş kaydından kendisi doldurmaz; Popen cwd'si `workdir or path.parent` olur. Böylece konfigüre edilmiş agent workdir'i ile onun veri-toplayan pre-run script'inin cwd'si aynı olmayabilir. Sonraki ajan task-cwd'sinin kurulması daha önce çalışmış betiğe geriye dönük kapsam sağlamaz. Bu doğrudan kaynak bağlantısıdır, gerçek subprocess cwd koşusu değildir. [S01,S03,S05]

Script dosyasının home/scripts altında kalmasını denetleyen path/symlink kontrolü, script'in çalışınca bütün etkilerinin o dizinde kalması demek değildir. Interpreter seçimi, subprocess ortamı ve process-tree stop ayrı mekanizmalardır; alt `build_subprocess_env`/OS containment bütünü burada doğrulanmadı.

## 5. Model ve araç seçimi tek bir sabit alan değil

Cron config her koşuda okunabilir. Per-job model ve provider pinleri, cron fleet varsayılanları, global/env çözümleme ve runtime resolver ayrı katmanlardır. `_resolve_job_runtime`, effective target model ve varsa explicit base_url ile resolver'ı çağırır; auth veya tanınmış geçici ağ çözümleme hatalarında fallback provider **ve modelini birlikte** değiştirebilir. Bu yüzden job.model metnini gerçek kullanılan backend/modelin bağımsız makbuzu saymıyoruz. Global model/env alt helper'ının bütün varyantları veya gerçek credential/provider çağrısı bu turun kapanışı değildir. [S01]

Drift guard, job'ın oluşturulma snapshot'ları ile pinlenmemiş primary seçimleri karşılaştırır; fallback'in kendisini her durumda drift saymaz. Credential-exfil guard ile config preflight da aynı ret politikası değildir: base_url override doğrulaması gerektiğinde fail-closed; preflight ise ancak açık misconfiguration gördüğünde bloklar, kendi hatalarında fail-open davranır. Fallback varsa missing-primary-key probe'u bloklamayabilir. Delivery yapılandırmasını okumak, gerçek gönderimin başarısını doğrulamaz. [S01,S02,S06]

Araç allowlist'i de tek başına nihai araç listesi değildir. Per-job toolsets, uygun koşullarda etkin MCP araç aileleriyle birleştirilebilir; `no_mcp` ve açık MCP seçimleri ayrı davranır. Config disabled-toolsets üstüne messaging/clarify ve varsayılan cronjob engelleri eklenir. Platform toolset çözümleme hatası None/default'a dönebilir. Gerçek init, `model_tools.get_tool_definitions` consumer'ını çağırır; alt registry/plugin/permission kapanışı bu parametre listesinden çıkarılmaz. “Cron yeniden planlayamaz” türü bir güvenlik hükmü de verilmez; kaynak bu varsayılanı loop-prevention olarak tanımlar. [S01,S07]

## 6. Sürekliliği taşıyan ayrı bilgi kanalları

| Kanal | Gerçek seçim/kapsam | Sınır |
|---|---|---|
| Current prompt ve extra run context | İş metni, o çağrıya verilen geçici ek bilgi | Job tanımına yazılmaması transcript/output'ta hiç saklanmayacağı anlamına gelmez |
| `context_from` / `self` | İlgili profile output dizinindeki en yeni mtime'lı `.md`; ilk 8.000 karakter | Transcript replay değil; success/dependency barrier veya kalite seçicisi değil |
| Job notepad | Profile-local SQLite, `(job_id,key)` kayıtları prompt'a render edilir | Boş/okunamayan not defteri boş bölüm olabilir; eski transcript'i geri getirmez |
| Prefill messages | Config/env'den list biçiminde priming messages | Önceki cron çalışmasının otomatik transcript'i olarak adlandırılmaz |
| Yerleşik bellek | Cron skip_memory=False; config flags uygunsa store diskteki bilgiyi yükler | Her ayarda bütün bilgilerin yüklenmesi veya doğru kullanımı garantisi değil |
| Harici memory provider | Configured/available provider, session/profile bağlamıyla initialize edilir | Gerçek provider çağrısı ve kapsam güvenilirliği sınanmadı |
| SOUL/proje context | identity yüklemesi açık; proje context dosyaları configured workdir'e bağlı | Context dosyası talimatı bu araştırmacının agent-control kuralı değildir |

Bu tablo yalnız constructor argümanından türetilmedi: AIAgent.__init__ → init_agent → `_init_session_state`, `_load_tools`, `_init_memory` bağlantıları ve helper gövdeleri okundu. Actual cron worker `agent.run_conversation(prompt, task_id=...)` çağrısına önceki conversation_history listesini geçirmiyor. Genel turn/admission/transport varyantları U02/U05 ve açık Q40 ile ayrıca ilişkilidir; “her koşulda sıfır bağlam” veya bütün ilk provider request'inin görüldüğü iddiası yok. [S01,S02,S04,S07,S09]

`skip_background_review=True`, otomatik review fork'unu bastırır; bellek okumayı veya bütün tool kaynaklı bilgi değişikliklerini kapattığı söylenemez. Yeni ephemeral ajan ile kalıcı bilginin kullanılması birbiriyle çelişmez.

## 7. Yeni deney: en yeni çıktı, en yararlı önceki sonuç olmayabilir

Tam orijinal `cron/scheduler_prompt.py` (Git blob `91d673649d6dca8ba3120d10671a8966e67a01ce`, 16.049 byte) connector metninden materyalize edildi; Git blob kimliği birebir eşleştirildi. Yalnız `_inject_context_from` çağrıldı. Dosya seçme/glob/stat/read/mtime gerçek; output-root resolver ve kullanılmayan import namespace'leri sentetik. Bunlar hangi dosyanın seçileceğine veya çıktı metnine karar vermiyor. Gerçek scheduler, SQLite, script subprocess, AIAgent, provider ve ağ koşulmadı. [SPEC/RESULT/MANIFEST]

| Vaka | Önceden belirlenen ayırıcı | Gözlenen |
|---|---|---|
| C01 | İki anlamlı çıktıdan yeni olan seçilsin | Yeni içerik seçildi, eski seçilmedi; self etiketi ve unchanged job doğrulandı |
| C02 | Yeni no_change belgesi eski raporun önüne geçebilir mi? | Yeni sessiz-çalışma kaydı enjekte edildi; önceki rapor diskte kaldı ama seçilmedi |
| C03 | Yeni dosya boşsa eski dolu dosyaya dönülür mü? | Dönülmedi; injected=False ve current prompt değişmedi |
| C04 | Uzun Prompt, sonraki Response bölümünü kesebilir mi? | İlk 8.000 karakter alındı; final-answer işareti raw'da mevcutken seçilen metinde yoktu |
| C05 | Yeni FAILED belge filtrelenir mi? | Hata belgesi seçildi, daha eski başarılı rapor seçilmedi |
| C06 | Önceki işe ait çıktı yoksa bekleme bariyeri oluşur mu? | Seçici current prompt'ı değiştirmeden dönüyor; bu helper önceki işi beklemiyor |

C02'nin gerçek caller bağlantısı ayrıca kaynakta izlendi: `_apply_monitor_gate`, no_change için bir output document üretir; `_run_one_job_body` bu tuple'ı alır; `_save_compose_deliver` önce output'u kaydeder, daha sonra SILENT nedeniyle teslimi bastırabilir. C04'ün full-document biçimi, `_run_doc_header` ile tam Prompt'ın yazılması ve run_job'ın bunun ardına Response bölümünü eklemesi sırasına dayanır. **Koşulmuş selector sonucu ile koşulmamış enclosing scheduler bağlantısı ayrı statülerdir.** Gerçek sonraki model isteğinde hatalı cevap, bütün geçmiş kaybı veya kullanıcı başarısızlığı ölçülmedi.

N00 değiştirilmiş source'u normal loader'da import öncesi reddetti. N01 dosya sırasını ters çeviren source mutant, C01 oracle'ında; N02 limiti 16.000 yapan mutant, C04 oracle'ında reddedildi. Bunlar testlerin ilgili davranış farkına duyarlı olduğunu gösterir; doğru ürün tasarımını veya bağımsız replication'ı değil. Altı vaka expectation_met, fixture'lar değişmedi, audit violation yok. SPEC/source/oracles sonuçtan sonra gevşetilmedi.

İlk attempt-00 probe'unda son print satırının kapanış işareti eksikti; Python parse aşamasında durdu, target import/fixture/vaka başlamadı. Yalnız print sözdizimi düzeltildi. Özgün probe/stdout/stderr ve değişiklik kaydı raw arşivde korunur. Bir başarılı behavioral run vardır; başarısız hazırlık yeşil teste çevrilmedi.

## 8. Monitor: gözlenmiş değişiklik ile başarıyla ele alınmış değişiklik

`check_monitor` yeni hash ve snapshot'ı **ajan başlamadan önce** kaydetmeye çalışır. Kaynağın değişmemesi sonraki model turunu bastırabilir; önceki ajan turunun gerçekten başarılı olup olmadığı bu kararın girdisi değildir. Kaynak bunu, başarısız ajanın aynı değişiklik için sonsuz tekrar uyandırılmasını önleyen bir detection-time tercihi olarak açıklar. [S03]

Bu yüzden “bu içerik gözlendi”, “ajan bunun üzerinde çalıştı”, “iş başarılı oldu” ve “kullanıcı sonucu aldı” ayrı eşiklerdir. İlk hash kaydı başarılı, sonraki model/preflight/teslim başarısız ise aynı içeriğin bir sonraki turda bastırılması kaynakla açıklanabilir. Fakat gerçek bu sıra üzerinde arıza deneyi yapılmadı. Snapshot dosyası ve jobs.json güncellemesi de ayrı best-effort yazılardır; partial-write/interleaving ve recovery açık sınırdır.

Hash, monitor source helper'ından gelen string'in UTF-8 temsiline uygulanır. Script helper çıktıyı strip/redact eder; URL okuyucusu boyut sınırından sonra decode eder. Dolayısıyla “exact output” bütün dış kaynağın sınırsız ham gerçekliğiyle karıştırılmaz. C02 selector testi monitor persistence'ını test etmiş değildir.

## 9. Sonuç, persistence ve yaşam süresi

Model turu failed/completed işaretleriyle değerlendirilir; ancak nonfailed max_iterations sonunda dolu fallback özet varsa `completed=False` olmasına rağmen cron başarı yoluna geçebilir. Kullanıcı görevinin anlamsal kabulü ile operasyonel rapor üretimi aynı oracle değildir. Boş yanıt için body'nin sonraki soft-failure kontrolü ayrıca vardır. Session end_reason da ayrı sınıflamadır: yalnız tanınan interrupted/error/empty durumları downgrade eder; probe hatası/unknown statü fail-open kalabilir. [S01]

SessionDB açma aşaması kendi süresi dolunca caller None ile devam edebilir. Bunun bütün ajan ömrü boyunca DB erişimi olmayacağı anlamına gelmediği ayrıca kaynakta görüldü: `AIAgent._get_session_db_for_recall` uygun koşullarda daha sonra store'u açabilir. Scheduler init timeout'u, bütün sonraki lazy recall erişimleri için toplam süre sınırı değildir. Bu yolların gerçekten tetiklendiği veya yazma başarısı bu tur ölçülmedi. [S01,S09]

Inactivity watchdog'un worker Future'ı ile kaynak temizliği farklı ömürler taşır. `defer_teardown_to_running_worker`, run_job bitmiş olsa da worker sürüyorsa SessionDB/agent teardown'u Future tamamlanmasına bağlar. Böylece caller'ın timeout/return anı gerçek çalışan thread'in durduğu anlamına gelmez. Bu mekanizma kaynakla okundu; yeni U08 benzeri thread/cancel deneyi yapılmadı. Yeni selector koşusu burada genel güvence oluşturmaz. [S01,S08]

## 10. Karşı okuma, birleşim ve araştırma yönü

En güçlü karşı açıklamalar saklanır: boş/sessiz son çıktı bazı işler için doğru bağlam olabilir; işin not defteri/belleği/explicit prompt'ı gereken bilgiyi ayrıca taşıyabilir; caller ve sonraki model seçilen bilgiyi yeterli bulabilir. Gösterilen şey seçicinin kalite/success/response-aware olmayışı ve kesin davranışıdır; bütün continuity'nin bozuk olduğu değil. Model kalitesi veya toplam hata oranı çıkarılmadı.

Monitor'un detection-time checkpoint'i hata olmanın zorunlu göstergesi değil, tekrar maliyeti ile başarısız işlemi yeniden ele alma arasında farklı bir tercihtir. Profil/sender ayrımı ve scoped cleanup gibi olumlu mekanizmalar da açıklamanın parçasıdır. Her davranış aynı tek güvenlik/başarı boolean'ına indirgenmedi.

U07–U10 artık scheduled-work için ilk geçici bütünleştirmeyi destekliyor: [synthesis04](../../synthesis/04-SCHEDULED-WORK-AND-CONTEXT-PROVISIONAL.md). Bu yeni bağımsız kanıt veya completed CORE değildir. Üç eski sentez değişmedi; 04 normal scheduled-work zincirini, gerçek/synthetic/source-only ayrımlarını ve açıklanmamış kenarları görünür kılar.

**İlk sonraki geniş kaynak birimi Q53:** seçilen provider/model/api_mode, gerçek in-process model transportuna veya harici/native backend'e nasıl dönüşür; o backend context/history, fallback, cancellation ve kaynak ömrünün hangi kısmına sahip olur? Başlangıç runtime_provider resolver ve agent_init routing/client consumer'larıdır. En az normal doğrudan yol ile bir maddi farklı backend karşılaştırılmalı; tüm provider kataloğu veya bütün platformlar kör taranmamalı. Q49'un full-host/ilk request/quality borçları ile yeni Q51 selector ve Q52 monitor validation'ları ayrı tutulur. Cron'un bütün hata matrisini bitirmek geniş araştırmanın ön koşulu değildir.
