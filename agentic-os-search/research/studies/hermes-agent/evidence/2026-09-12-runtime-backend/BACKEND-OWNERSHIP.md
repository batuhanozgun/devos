# U11-B — Model taşıması ile bütün ajan turunun devri

**2026-09-12 / PINNED SOURCE STUDY — YENİ DAVRANIŞ KOŞUSU YOK.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` / manifest 0.21.0. [A araştırması](RESEARCH.md), [A kaynakları](SOURCES.md), [B kaynakları](BACKEND-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md), [PUBLICATION](PUBLICATION.md). Güncel çalışma otoritesi [STATE](../../STATE.md); bu dosya runtime güvenilirlik sertifikası değildir.

## 1. Araştırma sorusu ve devralma

Q53-A, istenen model/sağlayıcının çözümlenmiş runtime, istemci kurulumu ve gerçek tur dalıyla aynı şey olmadığını gösterdi. A önce `e562de82ab4ea33872e55d501c8b59f26b441fa8` commit'iyle main'e yayımlandı; gerçek ref, araştırma/kaynak metinleri ve STATE'in güncel bölümü geri okundu. Ancak bundan sonra B açıldı. Başlangıç kaydı `d3a4baeeb7afd97d38588c674c4842f01e87c6f0` idi. Bu kayıtlar yeni HERMES davranış deneyleri değildir.

B'nin sorusu: **Normal HERMES model–araç döngüsü yerine bütün tur başka bir çalıştırıcıya verildiğinde, hangi sorumluluklar ortak kalır, hangileri yer değiştirir?** İncelenen karşılaştırma ordinary model-call yolu ile `codex_app_server` yoludur. Bütün provider kataloğu, bütün dış backend'ler veya kurulu Codex sürümü hakkında genelleme yapılmaz.

Kanıt statüsü: işlev gövdelerinde görülen çağrı/alan/branch `kaynak gözlemi`; bunların birbirine bağlanmasıyla çıkan koşullu sonuç `kaynak çıkarımı`dır. Aşağıdaki hiçbir sıra gerçek provider, subprocess, ağ, SessionDB veya model isteği çalıştırılmış gibi okunmamalıdır.

## 2. Sorumluluk tablosu

| Sorumluluk | Ordinary HERMES yolu | Codex app-server yolu | Sınır |
|---|---|---|---|
| Dış tur kabulü | TurnFacade admission ve lease çerçevesi | Aynı dış facade içinden native dala geçiş | Native dal bütün dış kabulü atlıyor değildir. |
| Model isteği | HERMES request assembly/middleware ve API helper'ı | Native session'ın thread/start ve turn/start RPC'leri | Aynı AIAgent/client etiketi aynı consumer değildir. |
| Model–araç döngüsü | HERMES while/retry/tool-dispatch döngüsü | Ayrı app-server süreci | Native iç implementasyon bu çalışmada yürütülmedi. |
| Geçmiş ve sıkıştırma | HERMES mesajları/context engine ve ilgili transport | Native thread; HERMES'te olaylardan türetilen ayna kayıt | Ayna transcript authoritative native thread değildir. |
| Araçlar | Ajanın tool-dispatch/batch/executor yolu | Native araçlar, native eklentiler ve seçili Hermes MCP araçları | Araç listesi, politika ve parent-agent bağlamı eşit varsayılamaz. |
| Fallback | Ordinary retry içinde etkin runtime alanlarının değiştirilmesi | İncelenen wrapper'da hata/retirement ve kullanıcıya dönüş önerisi | Metinsel öneri otomatik fallback değildir. |
| Interrupt | İstek abort hook'u, tool-worker/child sinyalleri | Özel event üzerinden turn/interrupt RPC'si | İstek kabulü fiziksel etkilerin durması değildir. |
| Kapanış | Request/agent/task sahipliğine bağlı cleanup | Native session/client close ve subprocess terminate/kill yolu | Bütün süreç ağacının ve dış etkinin bittiği ölçülmedi. |
| Sonuç kaydı | Normal finalizer/persistence | Projected mesajları append/flush ve uyumlu result dict | Aynı result şekli aynı terminal veya kalıcılık kanıtı değildir. |

Tablo kaynak sınırlarına bağlı bir native sistem açıklamasıdır; Foundation ontolojisi veya SOUL bileşen tasarımı değildir. [S03–S15]

## 3. Ordinary model yolu gerçek tüketiciye bağlandı

`turn_api_call.perform_api_call`, `run_llm_execution_middleware` içinden streaming veya non-streaming helper'ı seçer; model isteği aktifken redirect ile yarışmayı ayrı bracket içinde ele alır. `run_agent.py` içindeki gerçek forwarder'lar bu helper'ları `chat_completion_helpers.py` işlevlerine bağlar. Non-streaming dispatch'in sıradan Chat Completions dalı, request-local istemcinin `chat.completions.create(**api_kwargs)` çağrısına ulaşır. Anthropic, Responses, Bedrock ve MoA için farklı dallar vardır; yalnız bu ayrımın görülmesi onların bütün semantiğinin doğrulandığı anlamına gelmez. [S09,S12,S13]

`codex_responses`, bu ordinary model taşıma akışı içinde Codex Responses stream helper'ına gider. Buna karşılık `codex_app_server`, A'da gösterilen erken dönüşle bütün turu native session'a verir. İsim benzerliği aynı yürütme sahibi demek değildir.

Aynı ordinary yolu içinde de iş parçacığı düzeni değişebilir. `should_use_direct_api_call`, uygun Chat Completions cron/delegated-child yollarında isteği başka request worker'ı açmadan conversation thread'inde çalıştırır. Streaming varyant da bu durumda isteği inline, izlemeyi ayrı monitor thread'inde yürütebilir. Bu değişim model–araç döngüsünü Codex'e devretmek değildir: HERMES döngüsü, request durumu ve tool consumer'ları yerinde kalır. [S12]

## 4. Native çağrıya gerçekte ne taşınıyor?

`_ensure_codex_session`, native session'ı AIAgent üzerinde lazy olarak tutar. İncelenen factory çağrısı cwd, approval callback/routing ve UI event callback'ini geçirir. `agent.model`, HERMES sistem mesajı, tool schema listesi veya bütün `messages` dizisini ayrı parametreler olarak geçirmez. Ardından `run_codex_app_server_turn`, `run_turn(user_input=user_message)` çağırır. [S05]

Tam okunan `CodexAppServerSession` içinde yeni thread, initialize sonrasında yalnız cwd taşıyan `thread/start` ile açılır. Tur isteğinde thread kimliği ve metne çevrilen güncel input vardır. Bu iki RPC'de açık model, HERMES sistem mesajı veya eski transcript alanı gönderilmiyor. Session'ın client factory çağrısı da codex binary/home seçimini geçirir; üst agent'ın modelini komut satırı argümanına dönüştürmez. Tam client kodunda normal spawn komutu app-server'dır; bazı ortam koşulları sandbox argümanları ekler. [S06,S07]

**Kaynak çıkarımı:** HERMES'te seçili model/bağlam etiketinin görünmesi, aynı seçimin native model isteğine açıkça bağlandığının kanıtı değildir. Native runtime kendi config/auth/proje bağlamıyla uyumlu bir değer kullanıyor olabilir. Güncel user_message, örneğin cron prompt'u, zaten uygulama bağlamı içerebilir. Bunları yok sayarak “native sistem hiç bağlam almıyor” veya “kesin yanlış modeli çalıştırıyor” denemez. Doğrulanmayan şey, HERMES'in ayrı tuttuğu model/system/history alanlarının bu native sınırdan aynı sözleşmeyle geçmesidir.

Native usage dönüşünün HERMES muhasebesinde agent.model/provider etiketleriyle işlenmesi de gerçek native modelin bağımsız ölçümü değildir. Hatalı fatura veya yanlış kullanım kaydı gözlenmedi; etiket–gerçek runtime bağı ölçüm sorusudur. [S05–S07]

Zengin input ayrı bir temsil sınırına takılır: `_coerce_turn_input_text` metin parçalarını birleştirir, görüntü parçaları için işaret metni üretir. Bu giriş yolu görüntünün kendisini native wire'a taşımakla eşdeğer değildir. Başka native görüntü araçları bulunması, bu input dönüşümünün kayıpsız olduğunun kanıtı sayılmaz. [S06]

## 5. İki geçmiş: authoritative thread ve HERMES aynası

Aynı native session nesnesi thread kimliğini koruyarak sonraki turlarda yeniden kullanır. Buna karşılık incelenen yeni session factory/ensure_started yolu yeni thread açar; HERMES transcript'ini native thread'e yükleyen veya kalıcı bir eski native ID'yi resume eden çağrı bu yolun parçası değildir. Bütün gateway/CLI cache, yeniden kurma ve restore çağıranları taranmadığı için bunun her HERMES yeniden başlatmasındaki son davranış olduğu ileri sürülmez. [S05,S06]

`CodexEventProjector`, sadece tamamlanmış item bildirimlerini kalıcı mesaj şekillerine çevirir. Deltalar görünüm içindir. Tool biçimli native item'lar, assistant tool_call + tool-result çifti olarak yazılır; HERMES bunları yeniden çalıştırma talebi olarak dispatch etmez, mesajlara ekler ve saklamaya çalışır. Bu, native etkilerin sonradan temsil edilmesidir. [S05,S08]

Temsil seçicidir: file-change kaydı tüm değişmiş dosya içeriğini değil yolları/türleri ve durumu taşır; MCP/dynamic sonuçlar ve bilinmeyen item'lar belirli uzunluklarda kesilebilir. Bu nedenle normal şekilli transcript, native thread'in eksiksiz veya tersine çevrilebilir bir kopyası değildir. Kaydın öğrenme/review girdisi olması değerli olabilir; görünüm sadakati ile öğrenme kalitesi ayrı sorulardır.

Sıkıştırmanın sahibi de farklıdır. Native compaction bildirildiğinde HERMES compressor/accounting/event durumunu günceller, fakat kendi transcript satırlarını native özetle yeniden yazmaz. Native thread authoritative kalır. Bunun gerçek bir güvenlik karşılığı vardır: `compression_checkpoint_required` açıkça True ise native tur girişinde, truthful pre-compaction sınırı sağlanamadığı gerekçesiyle bu birleşim reddedilir. Bu olumlu kontrol, bütün native kontrol eşdeğerliğini kanıtlamaz; ancak “erken dönüş her korumayı atlıyor” tezini sınırlar. [S05,S06]

## 6. Araç erişimi ve politika aynı katmanda kalmıyor

Ordinary tarafta gerçek `_execute_tool_calls`, batch planlayıcı üzerinden sequential/concurrent executor'ları seçer. Ajan bağlamı gereken `delegate_task` dispatch'i parent_agent'i geçirir; top-level ve nested delegation'ın çalışma biçimini ayrı seçer. Bu consumer'ın varlığı gözlendi, delegation'ın tam yaşam döngüsü henüz araştırılmadı. [S13]

Native döngünün Hermes'e geri çağrı yüzeyi farklıdır. Tam `hermes_tools_mcp_server.py`, tanımlı bir EXPOSED_TOOLS listesi ile o süreçte gerçekten kayıtlı tool schema'larının kesişimini yayınlar. Handler, genel handle_function_call'a gider; aynı AIAgent nesnesinin parent bağlamını geçirmez. `delegate_task`, `memory`, `session_search` ve `todo` bu listede yoktur. Bu yalnız söz konusu Hermes MCP yüzeyinin sınırıdır; Codex'in kendi planı, başka eklentileri veya başka bilgi araçlarının evrensel yokluğu değildir. [S15]

Maddi bir temsil farkı da aynı dosyada görülür: server instructions metni delegation/memory/cross-session search gibi yetenekleri anlatırken gerçek exposed liste bunları dışarıda bırakır. **Yetenek açıklaması, kayıtlı tool listesi değildir.** Gerçek server'ı başlatıp hangi SDK sürümünde hangi araçların göründüğünü ölçmedik; bu source-level açıklama–liste farkıdır.

Native command/file approval istekleri Hermes callback'ine bağlanabilir; callback yokken incelenen routing varsayılanı decline'dır. Explicit bypass ayrı kaynaktan okunur. Permission escalation istekleri decline edilir, bilinmeyen metotlar hata alır. Ancak bunlar **native server'ın gerçekten approval isteği gönderdiği durumların** handler'larıdır; bütün native operasyonların önce bu kapıya geleceği gösterilmemiştir. Session'ın tuttuğu permission-profile alanı bu thread/start payload'ında gönderilmiyor; native config ve sandbox uygulaması ayrıca doğrulanmalıdır. “Hiç güvenlik yok” ve “Hermes politikası her native aracı aynı biçimde yönetiyor” sonuçları ikisi de fazla güçlüdür. [S05–S07,S15]

## 7. Fallback yalnız model adı değiştirmek değil

Ordinary `try_activate_fallback`, uygun adayın provider client'ını çözüp model/provider/requested-provider/base-url/api-mode alanlarını değiştirir. Credential pool'u yeni sağlayıcıya bağlama, client/headers/timeout bilgisi, transport cache, prompt-cache politikası, compressor model/context sınırı, reasoning ayarı ve provider'a ait extra_body anahtarları da yeniden ele alınır. Model kimliği prompt'ta güncellenir; eski sağlayıcıya ait stale streak temizlenir. Aynı logical tur, caller'ın request/prompt yeniden kurma yoluyla devam edebilir. [S04,S12,S13]

Bu işlem, eski konuşmanın otomatik silinmesi veya yeni kullanıcı işi açılması olarak temsil edilmez. Öte yandan mutator'ın birçok adımda alan değiştirmesi, bunların tek atomik rollback sözleşmesi taşıdığını da göstermez. Başarısız geçiş ortası, credential-path farkları ve sonraki tur primary restore işlevinin tam gövdesi açık sınırdır. Primary snapshot ve restore forwarder'ının görülmesi bütün geri dönüşün test edildiği anlamına gelmez.

Native whole-turn wrapper'ında aynı ordinary fallback çağrısı görülmez. Yakalanan run_turn hatası başarısız result üretir ve kullanıcıya default runtime'a dönme önerisi taşır; retirement işaretiyle session kapatılabilir. Factory/ensure çağrısı bu try bloğunun dışındadır, dolayısıyla bütün kuruluş hataları da aynı return sözleşmesinde değildir. Otomatik model-provider fallback, native session'ın atılıp sonraki tur yeniden açılması ve kullanıcıya runtime değiştirme önerisi farklı toparlama işlemleridir. [S05]

## 8. İptal ve kaynak ömrü

Ortak InterruptControl, uygun native api_mode için session'ın özel interrupt hook'unu çağırır. Session kendi event'ini kontrol ederek turn/interrupt RPC'sini gönderir; hata/timeout yolları vardır. Bu, dış sürecin bütün araç etkilerini durdurduğunun makbuzu değildir. Ordinary istekte kayıtlı abort hook'u ve request-local client/soket sahipliği devrededir; tool-worker ve child sinyalleri de farklı kapsamları taşır. [S06,S12,S14]

Ordinary request cleanup'ında yabancı thread'in abort etmesiyle sahibi olan worker'ın client'ı kapatması ayrılır. Bu kaynak disiplini, bütün worker'ların hemen bitmesinin ampirik doğrulaması değildir. Native client'ın close'u terminate/wait ve gerekirse kill/wait uygular. Agent.close gerçek kaynak kapısında native session.close'a da ulaşır. Dolayısıyla native erken dönüşten “child hiç kapanmaz” sonucu çıkmaz; fakat soft-release/cached-agent ömrü, süreç ağacı ve tamamlanmış dış yan etkiler ayrıca sınanmalıdır. [S07,S12,S13]

Native sessiz-kalma watchdog'u ve son süre, ordinary request stale detector'ıyla aynı kontrol değildir. Her ikisinin bulunması, bütün risklerin aynı şekilde yakalandığı veya aynı anlamda cancellation ürettiği anlamına gelmez.

## 9. Sonuç, terminal bildirim ve kalıcı kayıt üç ayrı sınır

Tam native session kaynak kodu, son sürede tamamlanmış assistant metni varsa, hata/interrupt yoksa ve turn/completed gelmemişse bu metni terminal cevap olarak kabul edebilen yolu içerir. Caller'ın completed alanı daha sonra interrupt/error değerlerinden türetilir. **Metnin tamamlanması ile native turn lifecycle bildirimi aynı olay değildir.** Burada gerçek bir süreçte devam eden iş gözlenmedi; yalnız hangi eksik makbuzun hangi koşullarda kabul edildiği gösterildi. [S05,S06]

İkinci ayrım persistence tarafındadır. `_persist_projected_messages`, projection yoksa veya DB yoksa dönebilir; flush exception/False durumunda uyarı verir. Başarılı native sonuç sözleşmesinin `agent_persisted=True` alanı ve completed hesabı ise flush başarısından bağımsız kurulabilir. Koşullu kaynak sonucu: **persist edenin agent olarak işaretlenmesi, bütün satırların gerçekten kalıcılaştığına dair ayrı bir başarı makbuzu değildir.** Bu tur gerçek DB kaybı, gateway'in yeniden yazmayı atlaması veya sonraki oturumda eksik geçmiş ölçülmedi. Bunların tüketicileriyle uçtan uca kontrolü NOT RUN'dadır. [S05]

Native tarafta post-turn işlevleri vardır: usage, compaction işaretleri, skill sayacı, uygun durumda external-memory sync ve review çağrıları. Bunlar uyumluluk sağlayan gerçek mekanizmalardır. Ancak ortak result şekli, aynı öğrenme girdisini veya aynı güvence düzeyini otomatik üretmez. [S05,S08]

## 10. Önceki sentezlere karşı okuma ve kapanış

Synthesis02 ordinary-loop açıklaması olarak kalır; U11 bu modelin native backend'e otomatik genellenemeyeceği gerçek branch'i açar. Synthesis04'teki fresh cron agent ve çok-kanallı bağlam açıklaması korunur; native consumer'a ayrı alanların gerçekten ulaşıp ulaşmadığı yeni binding sorusudur. Önceki dört sentez değiştirilmez; bu not onlarla birlikte okunacak kaynak amendment'ıdır, yeni completed CORE değildir.

Q53'ün bounded source hedefi ilerledi: seçim→dispatch, ortak kabul, iki history sahibi, tool/callback ayrımı, fallback, interrupt, cleanup ve receipt sınırları açıklanabilir. **Tam runtime closure yoktur.** S01–S16'ın tamamı full-file veya çalıştırılmış değildir; kapsamları ayrı defterlerdedir. Yeni test, fake-backed behavioral başarı, provider call veya bağımsız replication üretilmedi.

**Sonraki geniş kaynak birimi Q54:** ordinary tool/delegation kabulünden parent/child yetki-bağlamına, sonuç dönüşüne ve cancel/cleanup sorumluluğuna kadar gerçek zincir. Native MCP'nin stateless yolu karşı sınır olarak kullanılır; bütün Codex eklenti ekosistemi açılmaz. Q55 native model/system/history/restart binding ve Q56 native terminal/persistence/control makbuzu, ayrıca ölçüm gerektiren residual sorulardır. Bütün Q40/Q42/Q47/Q48/Q50 ve eski quality/fidelity soruları açık kalır.
