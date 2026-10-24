# U12-A — Araç görünürlüğünden yetkilendirilmiş yürütmeye

**2026-09-13 / Q54-A / PINNED SOURCE STUDY; yeni behavioral execution YOK.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` (manifest 0.21.0). [Kaynak kapsamı](TOOL-SOURCES.md), [STATE](../../STATE.md), [PLAN](../../RESEARCH-PLAN.md). Bu ilk dilim, görev devrinin child yaşam döngüsünü yapılmış saymaz. Kaynak gözlemi ve kaynaklar arası çıkarım, actual runtime sonucu değildir.

## 1. Soru ve giriş

U11, aynı ajan arayüzünün ordinary HERMES döngüsüyle native whole-turn çalıştırıcıyı gizleyebildiğini ayırdı. Q54-A bu kez ordinary yolda bir araç talebinin hangi kapılardan gerçek handler'a ulaştığını ve sonucunun nasıl kayıt olduğunu araştırır. Bir araç adı, schema, registry kaydı, mevcut çağrı izni, etki ve sonuç makbuzu aynı nesne değildir.

Başlangıç planı `0fd4b597002eb478cd1ed913a588ba44fe70edb3` main/ref, tam metin ve sadece plan değiştiğini gösteren compare ile geri okundu. Sonra kaynak araştırması başladı. Hazırlık sırasında gelen `bc99f6e9661bcbbaba9fb2db7332ebad16756775`, yalnız ayrı harness çalışması/katalog satırını değiştirdi; A bu güncel tabanı korur. Araştırma başarı ölçütü dosya veya test adedi değil, proposal→policy→handler→result bağının açıklanmasıdır.

## 2. Kaynakla bağlanan normal omurga

**Tool discovery/registration → oturuma sunulan tanımlar → modelin çağrı teklifi → isim/JSON kontrolü → çağrı kaydının kalıcılaştırılması → batch planı → middleware ve son argüman politikası → gerçek handler → sonuç dönüştürme/kaydı → görünüm ve sonraki model girdisi.** [S01–S07]

Bu bir transaction değildir. Bazı araçlar generic registry yerine canlı AIAgent, context engine veya memory-provider tüketicisine gider. Native MCP yüzeyi bu normal yolun bütünüyle eşdeğeri değildir; U11 karşı sınırı korunur. Yanlış bir argümanın model tarafından yazılması, handler'ın mutlaka çalıştığı anlamına gelmez; öte yandan handler'ın dönmüş olması da sonraki bütün kayıtların başarılı olduğu anlamına gelmez.

## 3. Görünürlük, kullanılabilirlik ve gerçek registration

`model_tools.get_tool_definitions`, enabled/disabled toolsets, registry entries ve check_fn'leri kullanır; sonra dinamik şema düzeltmeleri, sanitization ve gerekirse Tool Search daraltması uygular. Açık boş enabled listesiyle None aynı değildir. Disabled platform bundle'ların yalnız non-core farkının çıkarılması gibi özel semantik vardır. Registry scope/generation, profil, config fingerprint ve delegated/dispatcher bağlamı cache anahtarına girer. [S04,S05]

Builtin keşfi import sırasında registry.register çağrılarını yükler; MCP keşfi ise bu importun içinde değil host başlangıçlarının sorumluluğundadır. `ToolEntry`, schema ve gerçek handler'ı birlikte taşır. `get_definitions` yalnız talep edilen ve check_fn'i geçen entry'leri gösterirken `dispatch` aktif entry'yi alıp handler'a gider. Dispatch gövdesi kendi başına aynı availability check'ini veya bütün per-agent allowlist'i yeniden yürütmez. **Bu, ordinary yolun izinsiz çağrı yaptığı kanıtı değildir:** ordinary isim kabulü agent.valid_tool_names katmanında, özel bridge scope'u ayrıca uygulanır. [S03–S05]

Availability probe'larının TTL ve son-başarılı-sonuç toleransı taşıması, listelenmiş bir aracın tam şu anda başarıyla çalışacağının makbuzu olmadığını da gösterir. Yalnız comment'teki süre/olay anlatımı bağımsız saha deneyi sayılmadı. Plugin override/restore kayıtları handler kimliği ve scope'u ayrı korur; bunların bütün kötü niyetli plugin/host uzayını güvenceye aldığı araştırılmadı.

## 4. Model teklifi birkaç farklı kontrolden geçer

`validate_tool_calls`, aynı çağrı kimliklerini ayrıştırır, isimleri geçerli adlara karşı onarmayı dener ve unknown-name çağrılarını ayırır. Karışık batch'te geçerli çağrılar korunurken geçersizler tool-role hata kaydı alır; bütün batch'in unknown olması farklı retry/partial-exit yoludur. JSON normalleştirme ve kesilmiş argüman reddi başka aşamadır. [S03]

Önemli kapsam ayrımı: JSON olarak parse edilebilen liste üst doğrulamadan geçebilir; executor `_parse_tool_arguments` aşamasında gerçek dict zorunluluğu vardır. **Sözdizimi geçerliliği, beklenen nesne biçimi ve araca özgü şema/semantik uygunluk eşitlenmez.** Generic handler girişinde ise başka bir argüman-coercion katmanı bulunur; aynı helper farklı entrypoint'ten çağrıldığında aynı kontrollerden geçmiş varsayılmaz. [S01,S03,S04]

Tool Search, somut şemaları görünümden erteleyebilir. `tool_call` köprüsünü çözmek, oturumun bütün registry'ye erişmesi anlamına gelmez: executor underlying adı oturumun scoped deferrable listesine ve somut deferred şemaya karşı sınar. Generic bridge girişinde de aynı yönde ayrı kontrol vardır. Orijinal transcript call kimliği korunurken sonraki policy gerçek underlying araç ve argümanlarla çalışır. [S01,S04]

## 5. Etkiden önce hangi kayıt garanti edilmeye çalışılıyor?

`run_tool_round`, doğrulanmış/ayıklanmış çağrı bloğunu mesajlara ekleyip `_flush_messages_to_session_db` çağırır. Açık False veya exception durumunda tur başarısızlık yoluna döner; `_execute_tool_calls` çağrısına geçmez. Interim görünüm de bu append'ten sonra üretilir. Bu, restart yapan bir aracın izsiz çalışmasını önlemeye yönelik gerçek source kapısıdır. [S02]

Ancak gate'in sınırı korunmalıdır: kontrol **False kimliği** üzerindedir. No-DB/review gibi yolların None anlamı, gerçek kalıcı writer'ın sözleşmesine aittir; bu dilim bütün alt DB yollarını tekrar çalıştırmadı. Ayrıca burada kalıcılaştırılan model teklifi, daha sonra middleware'in değiştirdiği son argümanların bağımsız effect receipt'i değildir. Son argümanlar ayrı `_ToolCallRef` ve hook trace üzerinden taşınır. [S01,S02; eski U02/U05/U06]

## 6. Policy son argümanlara bağlanır; her kontrol aynı arıza politikasına sahip değildir

Executor'da Relay/request middleware ve execution middleware'den sonra `_authorized_dispatch` çağrılır. Yerel lock/state, bu invocation içindeki gerçek dispatch callback'inin ikinci kez çağrılmasını reddeder. **Bu yalnız yerel callback tekrarını sınırlar; yeniden başlatma, başka tool_call_id veya dış serviste exactly-once garantisi değildir.** `dispatched` alanı policy'den önce set edilir; `blocked` ayrıca tutulur. Bu nedenle bu alan tek başına gerçekleşmiş etki sayacı değildir. [S01]

Gerçek policy sırası scope block → plugin pre-hook (argüman değiştirebilir) → son argümanlar üzerinde guardrail.before_call → kabul edilirse checkpoint/görünüm hazırlığı ve handler'dır. Plugin hook hatası fail-open olabilir. Generic model_tools yolu, gerektiğinde ACP edit approval'ını ayrıca uygular; bu guard hata verirse write_file/patch reddedilebilir. Optional checkpoint işlemleri de best-effort'tur. **“Guard var” cümlesi hangi entrypoint, son argüman, exception ve etkinin korunduğunu tek başına söylemez.** [S01,S04]

Concurrent authorization lock'unun timeout'u, policy callback'ini atlamaz; callback'i seri sıra olmadan yürütür. Bu seçim interleaved prompt riskini kabul ederek kilit sahibinin batch'i sonsuza kadar durdurmasını önlemeye çalışır. Batch süresinden yalnız gerçek insan-onay beklemesi çıkarılır; keyfi hook/lock residence süresi aynı sayılmaz. Bunlar kod gözlemidir, canlı onay akışının testi değildir. [S01]

## 7. Batch planı, paralellik ve zaman sınırı

Planner, bilinen parallel-safe araçları ve path-scoped dosya işlemlerini ayırır. Reader-reader örtüşmesi kabul edilebilir; writer ile örtüşen path yeni segment sınırı yaratır. Bilinmeyen kapsam, çözülemeyen bridge ve interaktif clarify sıralı bariyerdir. Sonuçlar concurrent tamamlanma zamanına göre değil, orijinal çağrı sırasıyla mesaja eklenir. [S01,S07]

Buradan bütün koşullarda serializable dosya etkisi hükmü çıkmaz: planner başlangıç çağrı argümanlarını, daha sonraki policy ise değiştirilebilen son argümanları görür. Bu dilimde rewrite sonrası path rezervasyonlarının yeniden planlandığı kanıtlanmadı; alt dosya kilitleri ve ortam kapsamı ayrıca incelenmelidir. Bu bir açık kompozisyon kontrolüdür, gerçekleşmiş yarış veya exploit gösterimi değildir.

Sequential sıradan araç worker'ı ve concurrent batch farklı durma yapıları taşır. Delegate genel sequential deadline'dan muaftır, kendi child lifecycle denetimi sonraki dilimdir. Timeout/interrupt sonrası çalışan future için cancel istemi, tid sinyali ve nonjoining daemon-pool kapanışı bulunur. Concurrent start-order gate abandon ile henüz dispatch edilmemiş bekleyenleri kesebilir. **Zaten başlamış etkilerin durması, future.cancel veya timeout metniyle kanıtlanmış değildir.** [S01]

## 8. Somut ordinary örnek: read_file

`tools/file_tools.py` gerçek registry kaydı read_file'ı `_handle_read_file` ile bağlar; handler task_id veya default değerini `read_file_tool`'a taşır. Bu işlev pagination ve task path çözümlemesi, ilgili cihaz/özel dosya/okuma kontrolleri, belge veya metin dalı, negative cache/dedup, `_get_file_ops(task_id).read_file` çağrısı, uzunluk/redaction ve kayıt adımlarını yürütür. [S06]

Bu normal metin yolunun backend çağrısına kadar izlenmesidir; ShellFileOperations'ın bütün host/container/remote iç uygulaması çalıştırılmış değildir. Task kimliğinin yalnız etiket değil path/environment seçim girdisi olduğu görülür. Aynı path string'inin process cwd veya task cwd'de aynı dosya olduğuna otomatik hüküm verilmez.

Tekrarlı okuma stub'u veya char-budget kesimi, dosyanın tamamını modele yeniden vermekle aynı değildir. Kaynak compaction sonrası ilk yeni-generation okumasını ayrıca gözetir. Bu açıklama metin aracı normal yoluyla sınırlıdır; bütün belge extractor'ı, hassas-yol koruması veya read-before-write doğruluğu genel olarak test edilmiş değildir. Araştırmacının kendi okuma araçlarıyla HERMES'in read_file uygulaması da aynı araç değildir.

## 9. Etkiden sonra kayıt, temsil ve görünüm

Generic handler sonucu normalize edilir; post hook, transform hook, uzun sonuçların ayrı dosyaya taşınması, multimodal uyarlama, hint/risk ekleri ve turn budget katmanları sonraki temsili değiştirebilir. Orijinal handler sonucu, saklanan tool message ve UI preview zorunlu olarak aynı metin değildir. [S01,S04,S05]

Executor sonuç mesajını append edip flush eder; açık başarısızlıkta `_incremental_persistence_failed` set edilir. Sequential sonraki araçlar ve segmentler durabilir; outer turn sonraki model isteğine gitmez. Concurrent kardeşlerin bazı etkileri o sırada zaten gerçekleşmiş olabilir. Sonuç flush'ının başarısızlığı geçmiş etkileri geri alan bir transaction değildir. [S01,S02]

`tool.completed` görünüm olayı bu flush'tan sonradır; `post_tool_call` gözlem hook'u daha önce olabilir. Tek bir “completed event” başlığı altında ikisini eşitlememek gerekir. Timeout sonucu `effect_disposition=unknown` taşıyabilir; hiç başlamayan/skipped çağrı başka temsil alır. Gerçek native/DB/worker gözlemi olmadan bu kayıtları fiziksel etki kesinliği saymıyoruz.

## 10. Karşı okuma ve sonraki kapı

Normal zincirde gerçek olumlu kontroller bulunur: session-scoped bridge, son-argüman policy, pre-effect proposal kaydı, post-result durma, start-order abandon ve human-wait ayrımı. Bunları görmezden gelmek yanlış olur. Aynı zamanda constructor/schema, callback once, timeout veya ortak result shape üzerinden evrensel güvenlik/kalıcılık hükmü çıkmaz.

**Bu dilimde yeni import, HERMES module execution, SessionDB, tool handler, dış süreç, model/provider veya upstream test koşusu yapılmadı.** Kaynakla ifade edilen sınırlar canlı veri kaybı/çift etki/başarı oranı değildir. Kontrollerin kapsamını ampirik kapatmak gerekirse exact caller, son argümanlar, registry generation/profile, actual effect ve receipt birlikte ölçülmelidir.

**A gerçek main/ref/content olarak yayımlanıp geri okunduktan sonraki iş Q54-B:** `_dispatch_delegate_task` → `tools/delegate_tool.py` ve gerçek child factory/return/cancel consumer'ları. Parent bağlamını taşımayan native MCP karşı sınırı korunacak; child kabulü, background handle, çalışma bitişi ve parent'ın sonucu tüketmesi ayrı araştırılacak. A'nın kaynak metinleri B sırasında yeniden yazılmaz.
