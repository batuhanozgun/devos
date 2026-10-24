# U12-B — Görev devrinde aktör, bağlam, sonuç ve kontrol sahipliği

**2026-09-13 / Q54-B / PINNED SOURCE STUDY — yeni behavioral execution YOK.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`, manifest 0.21.0. [A: araç kabulü](TOOL-ADMISSION.md), [A kaynakları](TOOL-SOURCES.md), [B kaynakları](DELEGATION-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md), [PUBLICATION](PUBLICATION.md). Current work authority [STATE](../../STATE.md). Kaynak gözlemi, kaynaklar arası çıkarım ve gerçek koşu farklı statülerdir; bu dosyada sonuncusu yoktur.

## 1. Araştırma sorusu ve incremental devralma

A, araç şemasından gerçek handler ve sonuç kaydına kadar ordinary yolu açtı. `ef51c3f4b1d4d94038a428fa9bac1a21dfda778f` main/ref, tam A araştırması/kaynakları ve STATE geri okunduktan sonra B başladı. A metinleri burada değiştirilmez. Başlangıç planı `0fd4b597002eb478cd1ed913a588ba44fe70edb3`, A'nın parent'ı başka harness çalışmasını koruyan `bc99f6e9661bcbbaba9fb2db7332ebad16756775` idi.

B'nin sorusu yalnız “HERMES alt ajan açabiliyor mu?” değildir: **Yeni çalışan hangi yetki ve bilgiyle kurulur, kimin işi olarak izlenir, hangi sonucu kime döndürür ve durdurma/temizlik sorumluluğu nerede kalır?** Normal tek çocuk ve batch yolları, sync ve detached dönüşler, kontrol ve kalıcı sonuç kayıtları kaynakla bağlandı. Bütün gateway/CLI yeniden-kabul veya canlı child yürütmesi kapanmış sayılmaz.

## 2. Bir fonksiyon çağrısından yeni çalışana

| Geçiş | İncelenen gerçek sorumluluk | Ayrı tutulacak nesne |
|---|---|---|
| Modelin delegation çağrısı | Ordinary AIAgent intercept'i `parent_agent=self` geçirir | Araç isminin registry'de bulunması canlı parent bağlamı değildir |
| Spawn kabulü | Parent zorunluluğu, action, pause, depth, görev/şema ve runtime çözümlemesi | Control action kabulü yeni child yaratma yetkisi değildir |
| Child kurulumu | Config/depth ile rol, toolsets, model route, prompt, session ve bütçe | Parent'ın kopyalanması veya OS izolasyonu değildir |
| Gerçek çalışma | Task/cwd seeding, canlı kayıt, child.run_conversation, sonuç çözümleme | spawn_requested görünümü ilk model isteği değildir |
| Sonuç dönüşü | Sync tool sonucu veya detached unit'in completion kaydı | Handle, özet ve kullanıcı işinin doğrulanması farklıdır |
| Devam/iptal/kapanış | Parent/registry sahipliği, steering, timeout, deferred close | İstek kabulü, mantıksal terminal ve fiziksel durma farklıdır |

Bu native mekanizma tablosu Foundation sınıflandırması veya kabul edilmiş SOUL mimarisi değildir. U11'in native stateless MCP karşı sınırı, ordinary parent-bound yolun neden yalnız generic handle_function_call ile açıklanamayacağını gösterir. [S08–S15; U11 S13/S15]

## 3. Yetki modelin görev metninden türemiyor

`delegate_task` parent_agent olmadan reddeder. `list/steer/stop` kontrol eylemleri spawn pause/depth kapısından önce ayrı hatta işlenir; pause yeni iş açmayı durdurur, var olan bütün çocukları otomatik kesmez. Spawn için parent depth, yapılandırılmış max_spawn_depth ile karşılaştırılır. [S08,S14]

Caller'ın verdiği max_iterations yerine `delegation.max_iterations` okunur. Model-facing role alanı legacy uyumluluk için kabul edilse de gerçek child rolü **depth + orchestrator_enabled** ile kurulur. Model çağrılarında top-level background seçimi ordinary parent intercept'ince belirlenir; nested orchestrator çağrısı sync kalır. Direct Python helper'ın varsayılan sync davranışı aynı giriş yolu değildir. Modelden gelen gizli ACP command/args alanları ayrıca ayıklanır; trusted config başka kanaldır. [S08; U11 run_agent consumer]

Toolsets parent'ın seçimine/araçlarına dayanır, blocked araçlar ve parent disabled listesi ayrıca uygulanır; karma bundle içindeki adları çıkarmak için disabled-toolset katmanı korunur. **Ama bu koşulsuz “çocuk her zaman parent'ın tam alt kümesidir” teoremi değildir:** effective orchestrator rolünde delegation yeniden eklenir ve parent'ın delegation-disabled girdisi kaldırılır. Kaynak bunu role-granted yetki olarak açıklar. Bu host policy tercihini modelin kendiliğinden yetki yükseltmesi veya canlı bypass kanıtı olarak sunmuyoruz. [S09]

Yetki sınırı yalnız tool listesi de değildir. Worker'ın noninteractive tehlikeli-komut onay callback'i varsayılan deny, açık delegation ayarında once olabilir. Bu, callback'e gerçekten gelen operasyonların davranışıdır; bütün araçların aynı kapıya uğradığını veya dosya/süreç izinlerinin bu listeyle kapatıldığını kanıtlamaz. [S11,S12]

## 4. Fresh child, boş veya tamamen yalıtılmış child demek değil

Gerçek factory yeni AIAgent kurar: goal/context'ten üretilen odak prompt'u, parent prefill mesajları, selected toolsets ve runtime alanları geçer. `skip_context_files=True`, `skip_memory=True`, clarify_callback=None ve platform=subagent belirtilir. Gerçek worker, `child.run_conversation(user_message=goal, task_id=child_task_id, ...)` çağırır; parent conversation_history listesini ona geçirmez. [S08,S11]

Dolayısıyla temel çalışma yeni konuşmadır; gereken bilgi görev/context üzerinden açık aktarılmalıdır. Fakat “parent geçmişini replay etmiyor” ifadesi “hiç bilgi miras almıyor” değildir: prefill, görev bağlamı, dosyalar, runtime ve gerekirse diğer provider/backend mekanizmaları hâlâ vardır. Skip bayrakları da bütün yan bilgi kanallarının evrensel kapatılması diye genişletilemez. Gerçek ilk model request bu tur ölçülmedi.

Bütçe açısından önemli caller farkı: constructor'a parent.iteration_budget değil **iteration_budget=None** geçer; AIAgent'in yeni bütçe oluşturma yoluyla child kendi sınırını alır. Genel init'in shared-budget kabul edebilmesi, bu delegation caller'ının onu kullandığı anlamına gelmez. Bir parent bütçesinin bütün alt ağacın toplam hesaplama maliyetini sınırladığı söylenemez. [S08; U11 init_agent]

Subagent ID, child task ID, child session ID, parent session ID, delegation call/unit ID ve slot key farklı işlevler taşır. Child task-cwd kaydı parent'tan başlatılıp ayrı tutulabilir, fakat container alias parent'a bağlanır. Git worktree ayrımı opt-in ve local/git koşulludur; kurulamama durumunda shared workspace'e dönüş bulunur. **Yeni konuşma veya yeni task_id, ayrı dosya sistemi/container makbuzu değildir.** Worktree'nin gerçek oluşturma/finalize/merge uygulaması burada bütünüyle açılmadı. [S08,S11]

## 5. Runtime ve kayıt sahipliği yeniden bağlanır

Child model/provider/base_url, delegation ayarı veya parent mirasıyla çözülür. Base URL mirasında yalnız yüzeydeki alan değil canlı client/kwargs adresi de dikkate alınır. Açık provider pini, parent'ın ACP komutunu, fallback zincirini ve belirli yönlendirme filtrelerini temizleyebilir; farklı provider veya dual-wire Nous modelinde API modu yeniden türetilir. Böylece pin, yalnız bir etiket olarak kalmaması için consumer'a taşınır. [S12]

Provider/base_url override olduğunda parent endpoint-trust capabilities haritası otomatik miras alınmaz. Custom credential pool eşleşmesinde yalnız provider="custom" adı değil endpoint kimliği aranır. Bunlar gerçek kaynak korumalarıdır; tüm config, auth ve model kabul yollarının çalıştırılarak doğrulanması değildir. Hiçbir gerçek kimlik bilgisi okunmadı veya kullanılmadı.

Parent'ın SessionDB'si varsa child için parent'ın db_path'iyle registry.acquire çağrılır; construction failure'da release, child kapanışında ownership bayrağıyla release/close vardır. Bu kaynak **child'ın kayıt kaynağı ve serbest bırakma sorumluluğunu** açıklar. Alttaki registry'nin fiziksel bağlantı paylaşımını incelemeden comment'teki “dedicated” kelimesini bağımsız SQLite connection kanıtına yükseltmiyoruz. Detached ledger ise kendi profile state.db accessor'ını kullanır; her özel parent DB yolu ile eşdeğerlik ayrıca doğrulanmalıdır. [S08,S15]

## 6. Senkron ve detached çalışma farklı sahiplik sözleşmeleridir

Sync çağrı kendi çocuklarının sonuçlarını toplar ve JSON tool sonucu döndürür. Çoklu çocuklar tamamlandıkça gözlenebilir, fakat sonuç listesi task_index sırasıyla düzenlenir. Parent kesintisiyle henüz bitmeyenler için synthesized interrupted sonuçlar üretilebilir. Bu kayıt, worker'ın gerçekten çıkmış olduğunu tek başına kanıtlamaz. [S10]

Detached yol için önce dönüş hedefi belirlenir. `async_delivery_supported` olumluysa normal route; false olsa bile originating API session ID varsa self-wake yolu seçilebilir. Yalnız uygun hedef yoksa sync'e dönülür; probe exception'ı da ayrı davranır. Bu nedenle “stateless ise her zaman sync” yorumunu uygulamanın evrensel hükmü saymadık. [S10]

Bir `group`, **birlikte sonuç döndürme birimidir**, yürütme dependency'si değildir. Aynı group çocukları kendi aralarında join edilir; ungrouped çocuklar ayrı unit olur. Aynı çağrının unit'leri bir async slot paylaşır; çalışan child sayısı, unit sayısı ve kapasite slotu sayısı eşit değildir. Config'teki tek sayıdan bütün süreçte aynı anda çalışan çocuk sayısına evrensel üst sınır çıkarmıyoruz. [S08,S10,S15]

Background devrinde çocuklar parent'ın doğrudan interrupt listesinden çıkarılır, async registry'ye ayrı interrupt closure verilir. İlk kabul reddinde sync fallback, daha sonraki unit reddinde inline alt sonuç yolu bulunur. Bu geçişlerde sahiplik ve iptal kapsamını yeniden doğrulamak gerekir; kapasite reddi ile child'ın hiç kurulmamış olması aynı olay değildir. AIAgent nesneleri dispatcher'a gelmeden önce kurulmuştur. [S08,S10]

## 7. Kimin çocuğu, kimin düzeltmesi?

Origin routing ve UI authority child construction'dan **önce** yakalanır; çünkü construction session bağlamını değiştirebilir. Canlı kayıt owner_agent_session_id, UI session, transport ve session-record nesnelerini ayrı taşır. Parent'ın aynı Python nesnesi kalması zorunlu tek sahiplik kanıtı değildir: kontrol ya weakref ancestry ile ya da durable session/compression lineage eşleşmesiyle kurulabilir. [S10,S11,S14]

Gateway steering helper'ında owner session verildiyse ayrıca exact transport ve live session-record identity aranır. Trusted in-process helper'ın owner parametresi olmadan çalışabilmesiyle dış RPC'nin aynı yetkiyi taşıdığını varsaymıyoruz; gerçek bütün UI girişleri bu tur taranmadı. Model-facing control önce kendi spawn-tree sahipliğini sınar. [S14]

Steering kabulü, uygulanmış düzeltme değildir. Registry lock, kabul ile child'ın son steering kapanışını sıralar. Kapanış kazandıysa yeni istek reddedilir; kabul kazandı ama child'ın tüketeceği sınır kalmadıysa exact metin `missed_steer` olarak sonuçta korunur. Stop dönüşü de `interrupt_requested` biçimindedir, “bütün etkiler durdu” biçiminde değil. [S11,S14]

## 8. Sonuç özetinin niteliği ve kabul sınırı

Structured interrupted/failed/error alanları, bir metnin mevcut olmasından önce değerlendirilir. Buna rağmen başarısızlık alanı olmayan, bütçesi tükenmiş ve kullanılabilir özet üretmiş child için parent-visible `status=completed` ile `exit_reason=max_iterations` ve `truncated=True` birlikte bulunabilir. **Tek status veya UI işareti, görevin bütün kabul koşullarının sağlandığı anlamına gelmez.** [S11]

Output schema istenmişse final metin doğrulanır; uygun koşullarda bir correction turu açılabilir. Bu biçim doğrulaması doğru araştırma sonucu, gerçek upload veya doğru dosya etkisi deneyi değildir. Correction çağrısı ilk `await_child` future-timeout sargısından sonra yapılır; bütün correction bütçesi, history ve lifecycle eşdeğerliği burada kapanmış sayılmadı. Model-facing schema'nın kendisi child summary'lerini self-report olarak adlandırıp dış etkiler için bağımsız handle doğrulaması ister; bu kuralın yazılı olması kullanıcı uygulamasında yerine getirildiğinin kanıtı değildir. [S08,S11]

Parent'a tam child transcript'i normal tool dönüşü olarak verilmez; summary'ye tool_trace, tokens, exit reason, error, worktree ve canlı log yolları gibi seçili metadata eşlik edebilir. Dolayısıyla “yalnız özet” açıklaması pratik bir özetlemedir, payload'ın tek string olduğu iddiası değil. [S08,S11,S13]

Summary budget, parent'ın kalan bağlamından ve statik tavanından hesaplanır. Uzun metin baş/son bölümleriyle kısaltılır; tam metin spill dosyasına yazılmaya çalışılır. Yazılamazsa bu kayıp açık bildirilir. **Sıra önemlidir:** `_finalize_child_results` önce summary budget uygular; sonra memory.on_delegation ve subagent_stop hook'ları çalışır. Bu tüketiciler her durumda orijinal uzun özeti değil, sınırlandırılmış görünümü alabilir. Kalıcı dosyaya pointer bulunması da onun sonraki model tarafından gerçekten okunduğunun kanıtı değildir. [S13]

## 9. Canlılık, mantıksal terminal ve fiziksel kapanış

Sync child heartbeat'i iteration/tool/last_activity değişimini izleyip parent'ın canlılık saatini besler. Donmuş child'da heartbeat durur; bu işlevin kendisi child thread'ini öldürmez. Default child wall-clock timeout yoktur; yapılandırılmış timeout ayrı sınırdır. Model bekleme heartbeat'i teknik canlılık olabilir, görevde anlamsal ilerleme oracle'ı değildir. [S11,S12]

Timeout halinde stop istenir; worker hâlâ child kaynaklarını kullanıyorsa close onun future-done callback'ine bırakılır ve transport drain girişimleri yapılır. Bu, final DB yazısı sırasında başka thread'in kaynağı kapatması riskine karşı bir sahiplik disiplinidir. Done-callback varlığı, worker'ın mutlaka kısa sürede biteceği garantisi değildir. [S11]

Async monitor başka bir mekanizmadır: ilerleme belirteci donunca stalling, interrupt closure ve grace window; runner yine dönmezse synthesized stalled terminali üretilebilir. Sonradan gelen runner sonucu ikinci finalization hakkını kazanamaz. **Mantıksal sonuç seçilmiş olması, fiziksel worker veya önceki araç etkilerinin ortadan kalkmış olduğu anlamına gelmez.** Bu tur gerçek thread/OS çökmesi veya yan etki yarışı koşulmadı. [S15]

Canlı child registry'den çıkarılma, async result ledger'daki terminal, parent lifecycle event'i ve child.close farklı anlara/sahiplere bağlıdır. Recent-attribution kuyruğu canlı kayıttan ayrı tutulabilir. “Listede görünmüyor” ifadesi bütün sonucu kaybettik veya bütün alt süreçler bitti anlamına gelmez. [S11,S14,S15]

## 10. Kalıcı sonuçtan parent'a dönüşe kadar kalan bağlantı

Async `_dispatch`, memory admission, durable dispatch kaydı ve executor submit'i sıralar; bunlar tek DB transaction değildir. `_finalize` önce o unit'in terminal yayın hakkını memory lock altında alır, ardından `_push_completion_event` sonucu **DB'ye yazdıktan sonra** shared completion queue'ya koyar. Sonuç kaydı, queue publication ve üst tüketicinin kabulü ayrı eşiklerdir. Hata yollarını tek bir başarısız/başarılı boolean'ı altında birleştirmiyoruz. [S15]

Grouped unit henüz bitmemişken tamamlanan çocuk sonuçları best-effort kaydedilebilir. Owner process kaybolursa recovery, bilinen çocuk sonuçlarını korur ve kalanları unknown yapar; bu kayıt yeni child yürütmesini otomatik başlatmaz. Pending completion'ların restart'ta restore edilmesi de önceki çalışmayı yeniden yapmak değildir. Restore etiketi, age/retention sınırları ve sahiplik filtreleme gereksinimi vardır. [S15]

Kalıcı sonuç tüketimi claim ID ile yarışan tüketiciler arasında sınırlandırılabilir; başarılı ack aynı pending claim'i arar. Release/retry exhaustion/drop, delivered'dan farklıdır. Legacy event için kayıt bulunmaması ayrı uyumluluk yolu taşır. Bir çocuğun erken hata bildirimi, son unit sonucuyla aynı delegation ID'yi kullanabilir ama final claim/ack'i tüketmemelidir; kaynak bunu ayrı event türü niteliğiyle ayırır. [S10,S15]

**Burada açık kalan yük taşıyan bağ:** gerçek CLI/gateway/API drain, sahiplik filtresi ve claim'in hangi noktada ack edildiği; ardından hangi parent agent turunun hangi geçmişle gerçekten kabul edildiği. Helper adını veya queue.put başarısını “parent sonucu kullandı” kanıtı yapmadık. Sync yolun parent tool-result dönüşü kaynakla bağlanmıştır; detached uçtan uca yeniden kabul henüz aynı derinlikte değildir.

## 11. Önceki açıklamaya katkı ve devam

A/B birlikte, ordinary araç çağrısından yeni aktör yaratmaya ve farklı sonuç taşıyıcılarına geçen zinciri açar. U11'in native MCP parent-context farkı somutlaşır. Synthesis02 ordinary tur, synthesis03 kalıcı iş/devam ve synthesis04 scheduled-work ile ilişki kurulur; bu dosyalar değiştirilmez. `delegate_task` ne Kanban'ın kalıcı göreviyle ne de cron'un yeni çalıştırmasıyla özdeşleştirilir.

İki aşırı genelleme birlikte reddedilir: “yalıtılmış context her kaynakta izolasyondur” ve “aynı kaynaklar paylaşılıyor, demek ki ayrı yetki/kayıt kontrolü yoktur”. Factory, scope, role, runtime pin, sonuç şeması, live registry, async ledger ve cleanup farklı sorumluluklardır. Olumlu mekanizmalar ve açık sınırlar açıklamanın birlikte parçasıdır.

**Q54 SOURCE ADVANCED, runtime/quality closure değil.** B'nin sekiz dosyası tam metin olarak okundu; onların tüm bağımlılıkları veya gerçek HERMES kurulumu çalıştırılmadı. Yeni test/RESULT, ürün puanı veya bağımsız replication yoktur.

**İlk sonraki dar kaynak birimi Q57:** shared async-delegation completion → gerçek host drain → current ownership/claim/ack → parent turn admission/context. S15'teki producer ve delivery helper'larından actual caller'lara dönülür; en az bir normal consumer ve materially farklı restored/expired/interim event yolu izlenir. Sonra kapsam haritasına dönülerek kalan learning/skill-ledger/sync/quality ve UI/install/update/eval aileleri yeniden önceliklendirilir. Her fault varyantını bitirmek geniş araştırmanın ön koşulu yapılmaz. Q55/Q56, U10 Q49/Q51/Q52 ve eski doğrulama sınırları açık kalır.
