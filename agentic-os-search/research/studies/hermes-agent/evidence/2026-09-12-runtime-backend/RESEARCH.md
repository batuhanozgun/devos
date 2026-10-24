# U11 — Runtime seçimi ve yürütme sahipliği

**2026-09-12 / Dilim A / PINNED SOURCE STUDY.** Primary `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Yeni davranış koşusu yoktur. [STATE](../../STATE.md) çalışma otoritesi; [SOURCES](SOURCES.md) kaynak kapsamıdır. Bu dosyanın A checkpoint'i sonraki dilimden önce main'e kaydedilir; ref/content doğrulanmadan yayımlandığı iddia edilmez.

## 1. Amaç ve devralınan sınır

U10, kabul edilen cron işinin yeni AIAgent ve çeşitli kalıcı bilgi kanallarıyla yürütülmesini açıklamıştı; gerçek provider/backend sahipliği Q53 olarak açıktı. Burada soru bir provider listesini çıkarmak değil, **seçim bildiriminin gerçek model–araç yürütmesine hangi geçişlerle dönüştüğü**dür. U10'un selector deneyi bu yeni yolları test etmiş sayılmaz.

Kullanıcı önce anlamlı başlangıç kaydı ve main geri okuması, sonra küçük araştırma dilimleri düzenini onayladı. Başlangıç checkpoint'i `d3a4baeeb7afd97d38588c674c4842f01e87c6f0` olarak main'den okundu. Önceki main `595d9ebb24302e271b9f84cc86d0debbd74dc790` içindeki Foundation/roadmap değişiklikleri korunur. Bu çalışma yalnız HERMES araştırmasıdır; harici hedefin kodunu değiştirmez, credentials veya gerçek provider kullanmaz.

## 2. Birbirinden ayrılması gereken seçimler

| Düzey | Kaynakta taşıyıcı | Tek başına göstermediği |
|---|---|---|
| İstenen sağlayıcı/model | requested_provider, target_model, model config | Son çözümlenen endpoint, kimlik kaynağı veya çağırıcı |
| Çözümlenmiş runtime | provider, api_mode, base_url, api_key, source; bazen pool/command/args | Gerçek isteğin veya araç etkisinin gerçekleşmesi |
| Ajanın etkin yönlendirmesi | agent.provider, agent.model, agent.api_mode; init-time normalization/upgrade | Bütün tur boyunca değişmeden kalması |
| Kurulan istemci | client / _anthropic_client / _client_kwargs | O istemcinin ana turda gerçekten kullanılması |
| Turun gerçek yürütme dalı | conversation_loop içindeki api_mode kapısı | Aynı alt runtime'ın aynı kontrol, history veya cleanup semantiği |

Bu native ayrımlar Foundation sınıflandırması veya SOUL mimari kararı değildir. Aynı AIAgent sınıfından kurulmak aynı model–araç döngüsünde çalışmak demek değildir. [S01–S04]

## 3. Resolver, yalnız bir model adını kopyalamıyor

`resolve_runtime_provider`, requested-provider çözümlemesi ve disabled-provider kontrolünden sonra `_ladder_rungs` içinden ilk dolu sonucu seçer. Sıra lazy değerlendirilir: önceki yol sonuç verirse sonraki yol çalıştırılmaz. Named-custom/özel sağlayıcı yolları; explicit key/base-url; credential pool; OAuth ve registry yolları farklı dallardır. `target_model`, API biçimi hesaplarında persisted default yerine kullanılabilir. Bu, her alt kimlik okuyucusunun veya config önceliğinin burada tam doğrulandığı anlamına gelmez. [S01]

Kaynak URL tanıma, kalıcı API modu ve sağlayıcı eşleşmesini ayrı tutar. Örneğin `_configured_api_mode` eski bir provider'a ait modu yeni provider'a sessizce taşımamaya çalışır. API modu `codex_responses` olduğunda bu, `codex_app_server` ile aynı çalışma türü değildir: birincisi model taşıma biçimi olabilir; ikincisi aşağıda görülen whole-turn devrini seçer.

`_maybe_apply_codex_app_server_runtime`, yalnız openai/openai-codex ve açık model.openai_runtime seçimi için bir yeniden yazma tanımlar. **Bu yardımcıya bakarak bütün resolver yollarının aynı seçimi uyguladığını iddia etmiyoruz.** Bu dilimde onun `_resolve_runtime_from_pool_entry` çağrısı doğrudan görüldü. Explicit Codex ve singleton OAuth builders ise kendi sonuçlarını doğrudan codex_responses ile oluşturur. Dış çağıranın ayrıca override yapması, hangi credential yolunun gerçekten seçilmesi ve diğer resolver collaborator'ları ayrı doğrulama gerektirir. Dolayısıyla buradaki gözlem bir credential-path farkıdır; bütün kullanıcı konfigürasyonlarında app-server seçiminin bozuk olduğuna dair runtime hükmü değildir. [S01]

## 4. Ajan kurulumu ile gerçek dispatch arasındaki fark

`init_agent`, runtime alanlarını atar; `_resolve_api_mode` ve `_finalize_routing` çağrılarını yapar; callbacks/control state kurulmasından sonra `_build_client`, fallback zinciri, tools, session ve memory/config/context-engine aşamalarına geçer. Sonraki `_snapshot_primary_runtime` yalnız model adı değil provider/requested-provider/base-url/api-mode/client-kwargs/request-overrides ve compressor alanlarını da kaydeder. [S02]

`_resolve_api_mode`, açık tanınan modu önce kabul eder. `_finalize_routing`, belirli koşullarda chat-completions'tan Responses'a yükseltme yapabilir ve bu durumda önceden ısıtılmış transport cache'ini temizler. ACP scheme ve açık API modu gibi istisnalar vardır. Bu nedenle init'in ilk alanını veya ilk cache nesnesini son yönlendirme sanmak doğru değildir.

**Ayırıcı kaynak gözlemi:** `_build_client`, Anthropic/MoA/Bedrock dışındaki dalda `_init_openai_client` çağırır; bu kararın kendisi codex_app_server için ayrı whole-turn consumer değildir. Asıl ayrım conversation-loop'ta ortaya çıkar. Böylece bir OpenAI-wire client'ın kurulmuş olması, ana tur model isteğinin onun üzerinden yapılacağının yeterli kanıtı değildir. Bu bir kaynak kontrol-akışı çıkarımıdır; kurulum veya provider çağrısı çalıştırılmadı. [S02,S04]

## 5. Aynı dış kabul, iki farklı iç yürütme

`TurnFacadeMixin.run_conversation` dış çerçevesi durable turn admission, relay/accounting kapsamı ve lease/refresher temizliğini sarar; iç `conversation_loop.run_conversation` işlevini çağırır. Api-mode ayrımı bu dış kabulün içinde gerçekleşir. Dolayısıyla native backend'e gitmek, kaynaktan görülen bütün HERMES kabul mekanizmalarının atlandığı demek değildir. [S03]

İç işlev, credential-refresh girişimi ve `build_turn_context` sonrasında `_LoopState` kurar. Ardından:

- `agent.api_mode == codex_app_server` ise `_run_codex_app_server_turn` çağrısının sonucunu doğrudan döndürür.
- Diğer dallar normal HERMES yinelemesine girer: iteration hazırlığı, request assembly/preflight, retry, model-response normalleştirme, tool round veya final text, ardından normal finalizer.

Facade içindeki `_run_codex_app_server_turn` forwarder'ı `agent.codex_runtime.run_codex_app_server_turn` işlevini gösterir. **Native dal normal while-loop ve onun sonundaki finalize_turn satırına bu yoldan ulaşmaz.** Bunun native tarafta hiçbir denk kontrol veya kayıt olmadığı anlamına gelmediği özellikle korunmalıdır; Dilim B'nin konusu tam bu karşılıklardır. [S03,S04]

Bu kaynak, synthesis02'nin ordinary-loop açıklamasını yanlışlamıyor: sentez kendisini zaten ordinary gateway/loop ile sınırlıyordu. Yeni bulgu o sınırın gerçek branch'ini yerleştiriyor. Aynı dış oturum ve ajan sınıfını kullanmak iç history/compaction/tool/cancel sahipliğinin de aynı kalmasını gerektirmiyor.

## 6. Dilim A'nın çıkışı ve karşı sınama

A için amaç config→runtime→init→gerçek dispatch ayrımını açmaktı; selected kaynaklarla bu bağlantı kurulmuştur. Şu güçlü genellemeler reddedilir: provider ismi yürütme sahibidir; client constructor'ı actual request makbuzudur; codex_responses ile codex_app_server aynı yoldur; ayrı native dal bütün HERMES admission'ını atlar; normal finalizer'a gitmeyen dalın kendi cleanup'ı yoktur.

Son ikisi ters yönlü aşırı genellemeyi engeller. Normal ortak katmanlar da gerçek farklı katmanlar da açıklamanın parçasıdır. Bu tur canlı HTTP, kimlik çözümleme, dış süreç veya model çalıştırılmadı; state-machine test sonucu üretilmedi. İncelenen config/checkpoint helper'larının varlığı bütün çağırıcı/kapsam etkinliğine yükseltilmedi.

**A yayımlanıp geri okunduktan sonraki Dilim B:** `agent/codex_runtime.py`, native session/client ve projector → doğrudan model transportu → history/compaction, tool ownership, fallback, interruption ve cleanup. Her native davranış gerçek consumer'ına bağlanır. Q40/Q42/Q47/Q48/Q50 ile U10 Q49/Q51/Q52 ve bütün eski quality/fidelity sınırları açık kalır. Q53'ün tamamı A ile kapanmaz.
