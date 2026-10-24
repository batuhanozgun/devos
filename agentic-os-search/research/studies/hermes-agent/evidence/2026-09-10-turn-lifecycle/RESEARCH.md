# U02 — Bir girişin HERMES turuna, kalıcı duruma ve teslimata dönüşmesi

**2026-09-10 / PINNED SOURCE TRACE AND PROVISIONAL SYSTEM INFERENCE.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Kaynak kimlikleri ve FULL/SELECTED kapsamı [SOURCES](SOURCES.md). Bu tur yeni HERMES testi, ürün kurulumu, model/provider çağrısı veya upstream değişikliği yapılmadı. Kayıt, U01/M4'ün tekrar deneyi değil; gerçek genel yürütme akışının daha geniş okumasıdır.

## 1. Araştırma sorusu ve analiz birimi

Soru: Bir iş girdisi nereden itibaren işlenmiş sayılır; hangi bağlamla hangi döngüye girer; araç etkisi, kayıt, yanıt, teslim ve sonraki iş birbirine nasıl bağlanır?

Tek bir `run()` çerçevesi yetersizdir. Normal gateway yolunda dış mesaj/oturum yönlendirmesi, bir kullanıcı turu, o turdaki model–araç yinelemesi ve aynı model isteğinin yeniden denemeleri ayrıdır. Kanban terminal araçları ile `/goal`, `/loop`, `/heartbeat` göç yolları ise turdan daha uzun ömürlü iş durumlarının varlığını gösterir. Bu son alanların bütün uygulaması incelenmiş değildir. Bir konuşma oturumunu evrensel bir Work/task nesnesi ilan etmiyoruz. [C01/C03/C11/C12/C13/C17/C18]

## 2. Normal gateway girişinden çalışma sahipliğine

Önceki 12/13 notlarının normal external-message kabulü, canonical komut ve busy/idle seçimi bu çalışmanın girişidir; bütün adapter/auth yolları yeniden doğrulanmadı. Yeni `_handle_message_with_agent` zinciri session resolve → `_hmwa_prepare_turn` → `_run_agent` → sonucu şekillendirme → transcript yayını → delivery kararını doğrudan bağlar. Bir slash komutunun ajanı çağırmadan sonuçlanabildiği önceki ayrım korunur. [C18; eski UI/M3-S]

`_hmwa_prepare_turn`, konuşma reset/start durumunu tüketir, task-local ortam bağlamını kurar ve değişmeyen session context metnini yeniden kullanabilir. Yeni oturumun kanal/konuya bağlı becerisi ayrıca yüklenebilir. Ardından **resolved session_id için turn lease alınır**; durable active-turn işareti bundan sonra yazılır. Böylece yalnız kuyruğa gelmiş ama işlem sırası alamamış mesajın işlenmeye başlamış gibi recover edilmesi önlenmek istenir. Lease registry mevcut olmadığında helper no-op'tur; tüm ortamlarda aynı kilidin kurulduğu genellenmez. [C18:340–485,1680–1930]

Geçmiş yükleme `TranscriptReadError` verirse ajan boş listeyle başlatılmaz; kullanıcıya okunamayan oturum açıklaması döndürülür. Sonra session hygiene, yeni mesajın medya/metin hazırlanması ve tek-turluk notlar gelir. Bu sıra, okunamayan geçmiş ile gerçekten yeni konuşmayı ayrı tutar. [C18]

Çalışmanın run_generation değeri `/stop` veya yeni çalışma tarafından geçersizleştirilebilir. Sonuç döndüğünde generation artık güncel değilse normal delivery/persistence yoluna alınmaz; token'a bağlı release/rebind eski temizliğin yeni run'a ait hakkı bırakmasını önlemeye çalışır. **Bu sonuç-kabul sınırıdır; eski işin bütün harici etkilerini geri aldığı veya her thread'i fiziksel olarak durdurduğu iddiası değildir.** [C14/C18]

## 3. Ajan nesnesi oturumun kendisi değildir

Gateway `run_sync`, session/channel/global model-runtime çözümlemesini, tur ayarlarını, agent cache lookup/build'i, callbacks ve history seçimini birleştirir. Cache imzası model/runtime/araç/yapılandırma/kimlik girdilerini içerir. Uyumlu cache girdisi yeniden kullanılabilir; mevcut DB message_count ile kayıttaki sayının farklı olması veya sonlanmış session'a bağlı eski girdinin görülmesi yeniden kurulum yollarındandır. Kullanıcı kimliği ve alias'ı imzada yer alır; bunun tüm bellek sağlayıcılarının kimlik izolasyonunu doğruladığı söylenmez. [C14/C15/C18]

Cache'den bir ajanı atmak, konuşma durumunu temizleyen `/new` benzeri sınırla aynı değildir. `_clear_conversation_scope` ve per-running-agent cleanup ayrıdır. Yeniden kullanılan ajan için callback, reasoning ve request override'ları her tur güncellenir. History seçimi ayrıca aynı session'a bağlı canlı geçmişi tercih edebilen `_select_cached_agent_history` yardımcısına gider; bu yardımcının bütün karar koşulları bu tur okunmadı. [C14/C15]

`run_sync` gerçek `agent.run_conversation` çağrısını approval callback ve contextvar session key kapsamında yapar. Çalışma ortasında session ID değişirse host, dönen sonuç başarısız bile olsa yeni bağı takip etmek zorundadır. Aynı ID'de compaction yapılabildiği için yalnız `old_id != new_id` kontrolü yetmez; `compacted_in_place` ve `history_offset` ayrıca taşınır. [C15:1291–EOF]

## 4. Bir kullanıcı turunun prologu

`build_turn_context` şu tür işleri bir kez tur başında yapar: rotated-session recovery ve log kimliği; task/turn ID bağlama; per-turn sayaç/bütçe temizliği; önceki history'nin ve yeni gerçek kullanıcı mesajının yerleştirilmesi; todo/usage bağlamı; cache'den prompt seçimi veya restore/build; DB session varlığını sağlama; turn-start compaction; eklenti/harici bellek bağlamı; kullanıcı sidecar'ını yazma; erken persistence. Bu sıralama, tüm alt helper'ların doğrulandığı anlamına gelmez. [C01/R01]

`_cached_system_prompt` boş değilse mevcut metin seçilebilir; boşsa R01'deki restore/build çağrılır. M4'ün compatible stored-prompt yolu bu gerçek prologa bağlıdır. Ancak sonraki compaction, engine seçimi ve request-only ekler hâlâ sonucu değiştirebilir. “Yeni AIAgent her şeyi mutlaka taze kurar” da “bir cache varsa hiçbir şey yenilenmez” de doğru genel modeller değildir. [C01/R01/R02/C13]

Erken kullanıcı persistence'ı, araç öncesi persistence ile aynı hata sözleşmesi değildir. Prolog bazı hataları loglayıp ilerler. Araç round'unda açık False ayrı olarak durdurucudur. Bu farkı tek bir fail-closed/fail-open etiketiyle bütün ürüne yaymamak gerekir. [C01/C09/C16]

## 5. Bağlam bir metin değil, birkaç görünümün birleşimidir

**Kalıcı transcript:** kullanıcıya ait temiz metin ve kayıt metadatası.
**Replay sidecar (`api_content`):** temiz metinden farklı gönderim bağlamı gerektiğinde saklanan metin; gösterimle tekrar gönderimi ayırır.
**Sistem mesajı:** built-in memory/USER blokları, kurulum/kimlik/yönlendirme ve oturumda dondurulan bölümler.
**Tur bağlamı:** pre_llm_call eklenti çıktıları, tek kullanımlık gateway notları ve harici memory prefetch; çoğunlukla güncel kullanıcı satırına bağlanır.
**Gönderim kopyası:** her yinelemede yapısal olarak kopyalanan ve provider için düzenlenen mesajlar. [C01/C04/C06/C16/R02]

`build_api_messages` iç içe list/dict yapısını kopyalar; UI-only metadata'yı ayırır, güncel ve geçmiş sidecar'ları uygular, `active_system_prompt` ile ephemeral system ekini birleştirir. Ardından `assemble_api_request` prefill, context-engine seçimi, temizleme, mesaj dizisi onarımı ve cache decoration uygular. MoA ekleri ve request-pressure tahmini burada ayrı rol taşır. [C01/C04]

**Built-in kalıcı bellek ile harici memory provider'ın tur başı çağrısı aynı yenileme kanalı değildir.** Sistem mesajı eski olabilirken güncel kullanıcı bağlamına yeni bir dış hatırlama eklenebilir; bunun gerçekten olduğu belirli config/path ayrıca gerekir. Transcript, snapshot ve son wire payload birebir eşit kabul edilmez. [C01/R02]

## 6. Yineleme ve API denemesi ayrı kontrol döngüleridir

Normal `run_conversation` faz omurgası: begin_iteration → prepare_iteration → assemble_api_request → preflight gate → API retry loop → response/restart dispatch → tool round veya text-response yolu. `codex_app_server` özel dalında gerçek tur dış thread sahibine devredilebilir; aşağıdaki yerel loop her backend'in evrensel açıklaması değildir. [R01/C03/C07/C08]

Yineleme başında interrupt/redirect ve bütçe kontrolleri yapılır. `/steer` uygun son tool sonucuna eklenir; uygun taşıyıcı yoksa bekleyen duruma bırakılabilir. Request-pressure kapısı yalnız ham mesaj uzunluğunu değil kurulmuş istek kopyasını değerlendirmeye çalışır. Bunun kapsamı sonraki provider çeviricisinin veya middleware'in bütün değişiklikleriyle evrensel bir üst sınır ispatı değildir. [C03/C04/C05]

API retry aşamasında her deneme mevcut provider'a göre reasoning echo/cache biçimini yeniden düzenler; `_build_api_kwargs` provider biçimini üretir; request middleware'i payload'ı değiştirebilir. pre_api_request hook'u bu noktadaki kwargs'ı gözler. Execution middleware ve transport sonra gelir. **İlk API-message kopyasını doğrudan son ağ isteği diye adlandırmıyoruz.** `_build_api_kwargs` altındaki bütün transportlar ve son ağ byte'ları bu tur kapanmadı. [C06/C07]

Başarılı HTTP/SDK dönüşü henüz kullanılabilir model çıktısı değildir. Response shape, API-mode'a bağlı finish_reason, kesilme ve usage ayrı işlenir. Redirect ile yanıt kesişirse eski yanıt atılıp düzeltilmiş mesajlarla yeniden başlama yolu vardır. Compaction/fallback/re-direction bütçe iadesi ve re-anchoring gerektirebilir; truncation başka devam yoludur. Bütün error-classifier/backoff dalları değil bu dispatch sınırları incelendi. [C03/C07/C08]

## 7. Modelin araç istemesi ile dış etki arasında ne var?

C09 actual round sırası: tool validation → delegation cap/dedup → assistant tool-call kaydı → mixed-invalid çağrılar için hata karşılıkları → **session flush** → interim gösterim → `_execute_tool_calls` → result-persistence/guardrail değerlendirmesi → post-tool compaction → yeni yineleme.

C16 bu flush'ın gerçek sözleşmesini açıklar: persistent DB path'inde yeni satırlar hazırlanır, `append_messages_batch` çağrılır ve başarıdan sonra kalıcılaşma marker'ları eşitlenir; hata sınıflanır, özel compression-tip adoption bir kez denenebilir, sonunda False döner. Kayıttan izole ajan veya DB yokluğu **None** döndürür. C09 yalnız `is False` olduğunda çalıştırmayı durdurur. Dolayısıyla doğru hüküm “normal DB-backed path'te doğrulanmış append hatası etkiden önce durdurulur”; “her tool daima önce DB'ye yazılır” değildir. [C09/C16]

Araç sonucu kaydedilemezse dış etki gerçekleşmiş olabilir; round bunu modelin sonraki girdisi olarak güvenle kullanmayıp durur. Bu, harici sistemi geri alan transaction değildir. Dedupe, transcript marker'ı ve handler çağrısı; dış API'nin exactly-once sonucu veya yan etkilerin tamamının rollback'iyle eşdeğer değildir. Eski Q26 worker-policy ve U01B rollback sınırları korunur. [C09/C16; önceki 04/08/09/10]

## 8. Modelin metin döndürmesi neden bitiş olmayabilir?

`finish_text_response` boş/yalnız düşünme çıktısını, yalnız devam vaadini, yarıda kalmış parçayı ve tool_calls finish işaretine rağmen boş çağrı listesini farklı toparlanma yollarına ayırır. Gerçek final kabulünden önce optional verify-on-stop, pre_verify ve kanban terminal-tool gate'leri vardır. Bunlar modele ek bir deneme yaptırabilir; “bu kapı var, öyleyse yanıt bağımsız doğrulandı” sonucu yoktur. [C10/C11]

Kanban nudge'ı mevcut history'de `kanban_complete` veya `kanban_block` adına bakar. Bu küçük helper **başarılı bir board transaction receipt'i kontrol etmez**. Board'un actual completion/acceptance ve dispatcher doğrulaması başka yerdedir; burada bug hükmü değil yetki sınırı tanımlanır. [C17]

Bütçe bittiğinde pending verification cevabı geri verilebilir veya ayrı toolsuz özet istenebilir. Kanban worker'ın bütçeyi tüketmesi ayrıca `timed_out` kaydı yoluna bağlanır. Demek ki “model durdu”, “kullanıcıya bir şey döndü”, “worker süreci çıktı” ve “iş tamamlandı” ayrı iddialardır. [C12/C17]

## 9. Sonlandırma, kalıcılık ve teslim

Regular loop finalizer'ı trajectory, task cleanup, transcript tail shaping, persist, açıklamalar/output transforms, result assembly, bekleyen steer ve review/hook işlemlerini yürütür. Bazı early-return yolları loop'tan daha önce çıkar; “her olası çıkış bu finalizer'dan geçer” denmez. [R01/C12]

`completed` döngü durumundan üretilir; kullanıcı amacının sağlandığını ölçen genel bir oracle değildir. Cleanup hataları ayrıca taşınabilir. Finalizer ve `_persist_session` çağrılarının yalnız exception yakalaması, alttaki False sonucunun her yerde aynı şekilde yükseltildiği anlamına gelmez. Yeni fault injection/SQLite koşusu yapılmadı; statik sözleşme ayrımı korunur. [C12/C16]

Response transform ve bazı footer'lar transcript persistence'tan sonra uygulanır. Son kullanıcı metni ve kayıt metni kasıtlı olarak farklı olabilir; result'ın transformed/pre_transform alanları bunu taşır. Gateway de streamed/already_sent/body/media/footer kararlarını ayırır; dönen None, otomatik “hiç yanıt verilmedi” değildir. [C12/C15/C18]

Review ile delivery ilişkisi de iki olaydır: finalizer review'u return'den önce başlatabilen çağrıyı içerir; gateway'in review bildirim callback'i bildirimi ana teslim sonrası release'e kadar tutar. **Bildirim sırası, bütün review hesaplamasının ancak son delivery'den sonra başladığının kanıtı değildir.** `on_session_end` isimli lifecycle hook'u burada tur sonunda çağrılırken memory-provider shutdown/session kaynak kapatma CLI/gateway'e bırakılır. İsimden nesne ömrü çıkarılmamalıdır. [C12/C15]

## 10. M4'ün açık bıraktığı normal compaction bağlantısı

Yeni C13 ile önemli karşı açıklama doğrudan açıldı:

`admitted compaction → _rebuild_system_prompt_at_boundary → invalidate/cache clear + MemoryStore.load_from_disk → tool-schema refresh attempt → _build_system_prompt → same bytes ? preserve identity : use rebuilt → commit_compaction → return new_system_prompt`.

**Keep-prompt yolu yalnız yeniden oluşturulmuş metin eskisiyle byte olarak aynıysa eski nesneyi korur.** Önceki M4/V04'ün deneyci tarafından kurulan invalidate→restore sırası, bu normal caller'ın sırası değildir. M4 sonucu kendi dar kapsamıyla geçerlidir; buradan gerçek compaction'ın sürekli eski DB prompt'unu geri yüklediği sonucu çıkarılamaz. [C13/R02; 15/M4]

Normal in-place dalda transcript archive/compact çağrısını ayrı `update_system_prompt` izler. Rotation dalında child yayınına yeni prompt verilir. Bu iki DB işleminin bütün hata durumlarında aynı atomik sınırı taşıdığı varsayılmaz; SQLite internals ve fault paths ayrıca gerekir. Ayrıca `commit_memory_session` rebuild'den sonra gerçekleşen ayrı bir çağrıdır: “compaction'ın herhangi bir anındaki bütün yeni bellek bu build'e mutlaka girmiştir” denmez. [C13]

C01/C04, dönen active prompt'un gönderim mesajlarına taşındığı normal bağlantıyı açar; C06/C07 sonraki middleware/transport sınırlarını gösterir. Q07/Q22 artık yalnız selector hipotezi değildir: **normal refresh path ve API-message taşıyıcısı kaynakta bağlanmıştır.** Gerçek CLI/gateway onayından sonra kaç tur/zaman geçtiği, bütün compression/engine/provider varyantları ve son network payload hâlâ ölçülmemiştir. UI approval kendisi her zaman invalidation yapar gibi yeni bir iddia yoktur.

## 11. Bu turdan çıkan model ve sıradaki araştırma

Yeni [çekirdek sentezi](../../synthesis/02-TURN-CONTEXT-AND-SESSION-PROVISIONAL.md), [ilk öğrenme sentezini](../../synthesis/01-LEARNING-AND-CHANGE-PROVISIONAL.md) sınar. [Kapsam haritası](../../inventory/CORE-COVERAGE-2026-09-10.md) dosya sayısını tamamlanma saymaz; gerçek mekanizmaları açıklanmış, bağlı ama açık ve sadece keşfedilmiş olarak ayırır.

En yüksek sonraki bilgi değeri: **turun üstündeki kalıcı iş ve session authority**. Kanban'da task kabulü/claim/terminal receipt ile `/goal`, `/loop`, `/heartbeat` sürdürme mekanizmaları birden fazla turu nasıl birleştirir? Resolved-session lease ve DB publication bu üst işin tamamlanmasına nasıl bağlanır? Bunlar yalnız yeni ve ilginç oldukları için değil, tek turdan genel iş yürütme modeline geçişi değiştirdikleri için önceliklidir. Önce kanban normal create/claim/run/complete-or-block yolu ve actual terminal-state consumer okunmalı; bütün task sistemleri tek şemaya zorlanmamalıdır.

Bununla birlikte kalıcı transcript/SessionDB archive/append/restore işlemlerinin normal ve kesinti yolları sınırlı executable kanıt için adaydır. Tüm alt katmanlar okunmadan bir helper testi bütün state lifecycle'ın yerine geçirilmez. Provider/backend/delegation, cron/teslim, skill-ledger/sync ve diğer UI/install/eval aileleri haritada açık tutulur. SOUL/Development OS mimarisi veya benimseme yetkisi verilmiş değildir.
