# ECC — Python provider, araç döngüsü ve devam kullanımları

2026-09-21 · **B6-T17-C5c / U12-C CONTEXTUAL TRANSFER**.

Bu dosya Note27/U12-C araştırmasındaki kullanımları kendi bağlamlarında taşır. PY öneki kullanım adresidir; ortak kavram sınıfı değildir. [READING.md](READING.md) gerçek okuma ve kanıt kapsamını, [TERMS.md](TERMS.md) kullanım girişini, [global STATE](../../STATE.md) current/next işi taşır. Dosyanın varlığı tek başına yayın veya paket kapanışı değildir.

## 1. Kaynak kimliği ve açıklama rolleri

Research snapshot: **batuhanozgun/agentic-os-search@c0fd473bd3d39ff69371261c1de93afe0af8ad9c**. Ayrı ECC pin'i **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Araştırmanın OpenAI SDK karşılaştırması **v1.30.0 / e2214ce7243c027c4e04e39b5a11986d5e361e37**; index934195f ayrı keşif sürümüdür. Bunlar kurulu SDK, current servis veya birlikte sınanmış ortam değildir.

| Anahtar | Bu tur tam okunan repository kaynağı | Git blob |
|---|---|---|
| N27 | [Note27](../../../research/studies/ecc/notes/27-PYTHON-PROVIDER-SELECTION-AND-TOOL-ROUNDTRIPS.md) | 325d4234370b2019974969b6517c883b2bf3fad4 |
| LC | [U12-C sources](../../../research/studies/ecc/evidence/U12-C-SOURCES.md) | 900f277fead1d75a581f4e034da59a103cb88dc1 |
| MC | [ROUND-U12-C / MR28](../../../research/studies/ecc/ROUND-U12-C.md) | 6c36398267263e5335efe10885dbec1c5a1e0965 |
| PUB | [PUBLICATION-U12-C](../../../research/studies/ecc/PUBLICATION-U12-C.md) | 72ad93a2c1ed9757ea5ec493c70a1623ea7d94d4 |
| ER | [E09 README](../../../research/studies/ecc/evidence/u12-c-python-flow-probe/README.md) | e4e5feb757c062f0899f099c439e4b9a3c20bb46 |
| PC | [E09 PRECHECK](../../../research/studies/ecc/evidence/u12-c-python-flow-probe/PRECHECK.md) | e77ffb78644e74a8db4a884ae1a53164aa19e552 |
| E09 | [Düzeltilmiş encoded bundle](../../../research/studies/ecc/evidence/u12-c-python-flow-probe/E09.zip.b64) | 02441842546271f10050f0f5d4257235b972f113 |

E09'un beş üyesi de kurtarılıp tam okundu: probe.py, results.json, MANIFEST.json, exit-code.txt ve boş stderr.txt. ZIP SHA256 **f70acdf4df1fd04e1c446f2813d704f3bff5428945e9684acf4fff620e31e08b**; betik **0808157f0756bf039f0bfcd7d783dbcbdf13b4017ccd780e74a6b0c6f9cd0744**; sonuç **d7900dddbca2e682644b3693a22e8b9a447d494509f8fe94f8217451934be285**. Kurtarma/okuma yeni deney değildir. Original types/executor kaynakları ZIP içinde yoktur; bu tur yeniden getirilmedi, import edilmedi veya çalıştırılmadı.

**Roller:** K = önceki araştırmacının pinned koddan raporladığı kullanım; V = versioned SDK kaynak sözleşmesi; H = araştırmanın 2026-09-20 tarihli dış API dokümanı atfı; B = kaynakta kullanılan mesaj/beyan; T = incelenmiş, koşulmamış upstream test; E = kayıtlı E09 betiği/ham sonucu; Y = bağlamlı açıklama veya çıkarım. Türkçe metinler yeni extractor paraphrase'idir; aynı rol etiketi evrensel doğruluk vermez. E, bu tur gözlenmiş yeni target execution demek değildir. Kaynak, araştırmacı yorumu ve bu yeni temsil ayrı kalır.

Göreli bağlantılar current dosyaya gider; exact içerik yukarıdaki snapshot ve blob'dur. C-* / T-* / X-* / W-* locator'ları LC içinde tanımlıdır. Onları göstermek atfedilen bütün upstream dosyaları veya dokümanları bu tur tekrar okumak değildir.

## 2. Paket, giriş ve çağıranın kurduğu bileşim

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY01 — `llm-abstraction` | Kaynakta 0.1.0 olarak tanımlanan ayrı Python paketi. Rust ECC2, Node araçları ve pluginlerle aynı repoda bulunması tek entegre runtime kurmaz. | N27 §1; LC C-PACKAGE / K/Y |
| ECC-PY02 — `llm-select` | Provider/model tercihlerini seçtiren CLI girişi. Seçim yazarıdır; kendisi generate çağırmaz veya yönetilen agent başlatmaz. | N27 §1; LC C-SELECTOR / K/Y |
| ECC-PY03 — `python -m llm` | Aynı etkileşimli seçiciye giden modül giriş yolu. Library generate veya ReAct çalıştırılmasıyla aynı giriş değildir. | N27 §1; LC C-MAIN / K/Y |
| ECC-PY04 — `gui helper` | Dışa verilen, seçiciyi çağıran yardımcı. İsmi ayrı masaüstü uygulaması veya otomatik model çalışması kanıtı değildir. | N27 §1; LC C-EXPORT / K/Y |
| ECC-PY05 — `generate` | Library caller'ın provider ve LLMInput ile doğrudan çağırabildiği senkron üretim arayüzü. Selector'ın kendiliğinden devamı değildir. | N27 §1, §5; LC C-INTERFACE / K/Y |
| ECC-PY06 — `ReActAgent` | Sağlanan provider'ı tekrar çağırıp dönen kayıtlı araçları yürüten ayrı public helper. Tam kalıcı iş yönetimi veya görev-kabul sistemi olduğu varsayılmaz. | N27 §1, §5–6; LC C-EXECUTOR / K/Y |
| ECC-PY07 — `caller-owned composition` | Selector, provider, prompt helper ve executor'ın çağıran tarafından birleştirilebilmesi. Birlikte kullanılabilir olmaları otomatik bütünleşme anlamına gelmez. | N27 §1, §3 / Y |
| ECC-PY08 — `eager provider imports` | Paket girişinin SDK tabanlı provider'ları da erken import etmesi. Yerel model seçimi, normal import yolundaki SDK önkoşullarını tek başına kaldırmaz. | N27 §1; LC C-EXPORT/PROVIDERS / K/Y |
| ECC-PY09 — `wheel / dependency declarations` | src/llm paketleme hedefi, Python>=3.11 ve SDK alt sınırları gibi metadata. Kurulmuş wheel, başarılı import veya uyumlu constructor deneyi değildir. | N27 §1, §7; LC C-PACKAGE / K/Y |

## 3. Kaydedilen seçim ile tüketilen seçim

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY10 — `default selector menu` | Üç provider ve sabit model adları sunan menü. Canlı servis/model kataloğu veya bütün registry varyantlarının listesi değildir. | N27 §2; LC C-SELECTOR / K/Y |
| ECC-PY11 — `provider registry` | Resolver tarafında altı provider varyantını destekleyen kayıt/seçim alanı. Selector menüsüyle aynı küme değildir; ToolRegistry de başka bir kayıt alanıdır. | N27 §2; LC C-PROVIDERS/RESOLVER / K/Y |
| ECC-PY12 — `.llm.env` | Çağıranın current directory'sine provider/model tercihlerini yazan dosya. Yazılmış çiftin tamamının sonraki request'te tüketildiği kanıtı değildir. | N27 §2 / K/Y |
| ECC-PY13 — `LLM_PROVIDER` | Explicit seçim yokken environment veya saved dosyadan okunabilen provider tercihi. Model seçimiyle aynı alan değildir. | N27 §2; LC C-RESOLVER / K/Y |
| ECC-PY14 — `LLM_MODEL` | Selector'ın kaydettiği genel model tercihi; get_provider bunu model girdisi olarak aktarmıyor. İncelenen generate gövdelerinin tükettiği input.model veya provider-specific env ile eşitlenmez. | N27 §2 / K/Y |
| ECC-PY15 — `persist=True` | Seçicinin bu Python process'inin environment'ını da değiştirmesi. Başka bir process'in veya üst shell'in değerleri benimsediği anlamına gelmez. | N27 §2 / K/Y |
| ECC-PY16 — `printed shell exports` | Başka shell'de uygulanabilecek export talimatının yazdırılması. Talimatın görüntülenmesi uygulanmış environment değişikliği değildir. | N27 §2 / K/Y |
| ECC-PY17 — `Ready to use` | Seçicinin kullanıcıya yazdığı hazır olma ifadesi. Endpoint, credentials, model availability veya başarılı generation kontrolü değildir. | N27 §2 / K/B/Y |
| ECC-PY18 — `get_provider precedence` | Explicit argument → nonempty LLM_PROVIDER env → saved provider → claude varsayılanı. Somut provider çözümleme sırasıdır; model propagasyonu aynı zincirle kurulmuş değildir. | N27 §2; LC C-RESOLVER / K/Y |
| ECC-PY19 — `provider-name normalization` | Environment/saved provider adlarının resolver için normalleştirilmesi. Geçersiz türün ret işlemi PY106'da ayrı tutulur; normalleştirme canlı capability kontrolü değildir. | N27 §2; LC C-RESOLVER / K/Y |
| ECC-PY20 — `LLMInput.model` | Generate'in açıkça tüketebildiği model girdisi. Saved LLM_MODEL'den ayrı; açık model sağlamak source karşı-örneğinin olumlu karşılığıdır. | N27 §2–3 / K/Y |
| ECC-PY21 — `provider-default model` | Input model yoksa adapter'ın kendi default/env seçimi. Saved openai/gpt-4o sonrası model=None çağrısında request'in gpt-4o-mini seçebilmesi kaynaktaki koşullu örnektir; canlı yanlış-model olayı değildir. | N27 §2 / K/Y; koşullu |

## 4. Ortak tipler ve isteğe bağlı yardımcılar

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY22 — `LLMInput` | Mesajlar, model, tools ve seçenekleri taşıyan ortak girdi. Bir alanın burada bulunması her adapter'da aynı seçenek veya kontrol olarak uygulanmasını sağlamaz. | N27 §1, §3; LC C-TYPES / K/Y |
| ECC-PY23 — `LLMOutput` | Metin, tool calls, kullanım ve durma nedeni gibi normalize edilmiş dönüş alanları. Kendiliğinden kabul edilmiş iş veya kalıcı execution receipt değildir. | N27 §3–6; LC C-TYPES / K/Y |
| ECC-PY24 — `Message` | Generic conversation/history kaydı. Bunun serializer'ı, her provider'ın native sonraki-istek biçimini otomatik sağlamaz. | N27 §4; LC C-TYPES / K/Y |
| ECC-PY25 — `ToolDefinition` | İsim, açıklama ve parametre şemasını taşıyan araç tanımı. Callable'ın gerçekten hangi argümanları kabul edeceği veya request-specific authority ayrı sorulardır. | N27 §4–5; E09 cases2–4 / K/Y |
| ECC-PY26 — `ToolCall` | İsim, call id ve arguments taşıyan çağrı kaydı. Aracın tanımı, çalıştırılma yetkisi veya sonucu değildir. | N27 §4–5; E09 probe:92–95 / K/Y |
| ECC-PY27 — `ToolResult` | Executor'ın call id, content ve is_error ile ürettiği sonuç kaydı. History'ye dönüştürülürken bütün yapısal alanları korunmuş sayılmaz. | N27 §5–6; E09 case7 / K/Y |
| ECC-PY28 — `LLMInput.to_dict` | Metadata'yı temsile birleştirebilen serileştirme yardımcısı. Adapter'lar gerçek request parametrelerini kendileri kurar; bu sözlük doğrudan network payload diye okunmaz. | N27 §3; LC C-TYPES / K/Y |
| ECC-PY29 — `input.stream` | Ortak tipteki streaming seçeneği. İncelenen generate gövdeleri streaming uygulamıyor; ReAct yeniden kurduğu input'ta bu tercihi taşımıyor. | N27 §3; LC joined findings / K/Y |
| ECC-PY30 — `input.metadata` | Ortak girdi/temsil metadata'sı. Generate request'lerinin elle kurulması ve ReAct yeniden-yapımı nedeniyle otomatik aktarılmış kontrol değildir. | N27 §3 / K/Y |
| ECC-PY31 — `ModelInfo` | Statik model bilgi kaydı. Uzak model kataloğu veya güncel limit doğrulaması değildir; listeyi sunan list_models işlemi PY107'de ayrıdır. | N27 §3, §7; LC C-TYPES/INTERFACE / K/Y |
| ECC-PY32 — `supports_tools` | Arayüzün capability bildirim metodu. Bu loop onu execution admission gate olarak sorgulamıyor; bildirimin varlığı araç yetkilendirmesi değildir. | N27 §3; LC C-INTERFACE / K/Y |
| ECC-PY33 — `supports_vision` | Ayrı capability bildirim metodu. Canlı görsel yetenek testi veya loop'ta uygulanan seçim filtresi değildir. | N27 §3; LC C-INTERFACE / K/Y |
| ECC-PY34 — `PromptBuilder` | Çağıranın isteğe bağlı kullanabildiği system/tool-text ve input hazırlama yardımcısı. Provider/ReAct kendiliğinden bunu çağırmaz. | N27 §3; LC C-PROMPT / K/Y |
| ECC-PY35 — `user_template` | Builder'da saklanan alan. Build içinde ek etkili dönüşüm olduğu yalnız bu field'in varlığından çıkarılmaz. | N27 §3; LC C-PROMPT / K/Y |
| ECC-PY36 — `tool_format` | Builder'ın ayrı saklanan biçim alanı. Araç biçimine otomatik uygulanmış dönüşüm veya native wire uyumu değildir. | N27 §3; LC C-PROMPT / K/Y |
| ECC-PY37 — `named-template registry` | Doğrulaması bulunan in-memory isimli template kayıt yardımcısı. Otomatik provider invocation veya önceki ECC orchestration-template launch yolu değildir. | N27 §3; LC C-TEMPLATES / K/Y |

## 5. Provider'a özgü request ve response yolları

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY38 — `OpenAI adapter request` | Senkron chat completions; model/temperature, optional max_tokens ve native tool definitions ile request kurulması ve text/calls/usage/finish reason okunması. Kaynak davranışıdır, yapılmış API çağrısı değildir. | N27 §3; LC C-OPENAI / K/Y |
| ECC-PY39 — `OpenAI tool-argument decoding` | Boş olmayan bozuk JSON tool arguments için decode hatası. Aşağıdaki tolerant raw/value yollarıyla aynı hata davranışı değildir. | N27 §3; LC C-OPENAI / K/Y |
| ECC-PY40 — `Claude system/cache projection` | System mesajlarını ayrı cached text block'a ayıran aktarım. Non-system history'nin native tool-result biçimine çevrilmesini sağlamaz. | N27 §3–4; LC C-CLAUDE / K/Y |
| ECC-PY41 — `adaptive thinking branch` | Model adı koşuluna göre request'e düşünme ayarının eklenmesi. Gerçek model reasoning niteliği veya güncel servis desteği doğrulanmış değildir. | N27 §3; LC C-CLAUDE / K/Y |
| ECC-PY42 — `native tool-definition conversion` | Claude ve diğer adapter'ların tanımları ilk request'in biçimine dönüştürmesi. Response veya sonraki conversation history dönüşümünden ayrı sorumluluktur. | N27 §3–4; LC C-CLAUDE; T-PROVIDER / K/Y |
| ECC-PY43 — `tool-response normalization` | Provider response'undaki tool_use/call alanlarının ortak ToolCall'a çevrilmesi. Geri gönderilecek history'nin native sözleşmeye uygunluğu bununla kapanmaz. | N27 §3–4; LC provider bodies / K/Y |
| ECC-PY44 — `Ollama /api/chat request` | Configured URL'ye urllib POST, timeout=60 ve stream=False ile gönderim yolu; nondefault temperature seçeneği koşullu eklenir. Bu gövde source olarak incelenmiş, servis çalıştırılmamıştır. | N27 §3; LC C-OLLAMA / K/Y |
| ECC-PY45 — `Ollama input.tools omission` | Bu adapter request'ine ortak tools alanının gönderilmemesi. Ollama'nın bütün sürümlerinde tool support olmadığı sonucu değildir. | N27 §3; LC C-OLLAMA / K/Y |
| ECC-PY46 — `Ollama max_tokens omission` | Ortak max_tokens alanının bu request'e aktarılmaması. Request'teki araç tanımı eksikliğiyle aynı field değildir; gerçek token tüketimi ölçülmedi. | N27 §3; LC C-OLLAMA / K/Y |
| ECC-PY47 — `Astraflow global variant` | OpenAI-compatible request yolunun global env/endpoint varsayılanlı varyantı. CN varyantı PY108'de ayrı adreslenir; current hizmet veya ticari katalog doğrulaması değildir. | N27 §3; LC C-ASTRAFLOW / K/Y |
| ECC-PY48 — `raw argument wrapper` | Tolerant adapter parser'ının malformed JSON'u raw içerik olarak koruması. İçeriğin tool schema'ya uyduğu veya çağrılabilir kwargs olduğu onayı değildir. | N27 §3; LC C-ASTRAFLOW/C-ATLAS / K/Y |
| ECC-PY49 — `value argument wrapper` | Geçerli fakat object olmayan JSON'un value sarmalayıcısıyla korunması. Parse başarısı, beklenen argüman sözlüğünün doğrulandığı anlamına gelmez. | N27 §3; LC C-ASTRAFLOW/C-ATLAS / K/Y |
| ECC-PY50 — `Atlas 512-token minimum` | Adapter'ın 512'den küçük max_tokens isteğini 512'ye yükseltmesi. Kaynaktaki reasoning-budget gerekçesi kullanıcının küçük üst sınırını etkili kılmaz; gerçek harcama gözlenmedi. | N27 §3; LC C-ATLAS / K/Y |
| ECC-PY51 — `empty/filtered response diagnostic` | Provider constants dosyasında bulunan response tanı metni. Tanı sabiti gerçek sağlayıcı nedeninin ölçümü veya otomatik recovery değildir. | LC C-CONSTANT; T-PROVIDER / K/T/Y |

## 6. Araç sonucunun sonraki isteğe dönüşü

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY52 — `assistant tool-call history` | ReAct'in tool-call response'unu assistant Message olarak history'ye eklemesi. Generic geçmiş kaydı, native request acceptance değildir. | N27 §4; E09 case2 / K/E/Y |
| ECC-PY53 — `role=tool history` | Araç content'i ve call id'sinin tool rolüyle sonraki input'a eklenmesi. Claude'un native user/tool_result yapısıyla aynı rol/biçim değildir. | N27 §4; E09 cases2,7 / K/E/Y |
| ECC-PY54 — `type:function requirement` | Versioned OpenAI input type'ındaki zorunlu alan. Kaydedilmiş generic assistant call bu alanı taşımıyor; dar shape kontrolü API rejection deneyi değildir. | N27 §4; LC X-OPENAI-TOOL; E09 case8 / V/E/Y |
| ECC-PY55 — `JSON-string function.arguments` | Aynı native sözleşmede arguments'ın JSON metni olması. E09 generic serializer'da Python dict gözlenir; object içeriği ile wire encoding ayrı tutulur. | N27 §4; LC X-OPENAI-TOOL; E09 case8 / V/E/Y |
| ECC-PY56 — `Claude assistant tool_use block` | Araştırmanın 2026-09-20 tarihli sözleşmesindeki assistant content biçimi. Generic assistant.tool_calls alanının başka adı değildir. | N27 §4; LC W-CLAUDE / H/Y |
| ECC-PY57 — `Claude user tool_result block` | Aynı sözleşmede tool_use_id ile user content'e konan sonuç bloğu. Generic role=tool mesajı bunu oluşturmuş sayılmaz. | N27 §4; LC W-CLAUDE / H/Y |
| ECC-PY58 — `tool_call_id / call correlation` | Generic sonuç mesajını belirli çağrıya bağlayan kimlik. E09 normal/error history'de korunur; kalıcı attempt kimliği, yetki veya native biçim uyumu değildir. | N27 §4–6; E09 cases2,7 / K/E/Y |
| ECC-PY59 — `whole-conversation conversion` | İlk tanım/response yanında devam history'sinin de hedef provider biçimine çevrilmesi sorumluluğu. Birinci request testi tek başına bunu doğrulamaz. | N27 §4; LC joined findings / Y |

## 7. Registry, kabul ve yürütme

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY60 — `ToolRegistry` | Araç adını callable ve definition ile bağlayan yerel kayıt. Provider registry'den ve request'te advertised tools kümesinden ayrıdır. | N27 §5; E09 probe:77–86 / K/E/Y |
| ECC-PY61 — `ToolExecutor` | İsim üzerinden callable bulup func(**arguments) çağıran executor. Stored JSON schema'yı veya input.tools listesini ayrıca admission kuralı olarak kullanmıyor. | N27 §5; E09 cases3–4 / K/E/Y |
| ECC-PY62 — `advertised tools` | Belirli LLMInput'ta provider'a sunulan tanımlar. Bu helper'da yalnız bunlar çalıştırılabilir şeklinde request-specific allowlist değildir. | N27 §5; E09 case3 / K/E/Y |
| ECC-PY63 — `registered-but-unadvertised call` | Scripted provider'ın input.tools boşken kayıtlı record'ı çağırmasıyla list append oluşan E09 karşılığı. Gerçek modelin bunu isteme sıklığı veya production exploit değildir. | N27 §5; E09 case3 / E/Y |
| ECC-PY64 — `unknown-name rejection` | Kayıtlı olmayan aracın callable yürütülmeden error ToolResult üretmesi. Gerçek olumlu sınırdır; registered araç için talebe özel izin kontrolüyle aynı değildir. | N27 §5; E09 case3 / K/E/Y |
| ECC-PY65 — `declared JSON schema` | Parametre integer/required/additionalProperties gibi tanım kısıtları. Stored definition'ın varlığı executor'ın bu şemayı uyguladığı anlamına gelmez. | N27 §5; E09 case4 / K/E/Y |
| ECC-PY66 — `strict:true in definition` | E09 ham tanım/istek kayıtlarında görülen strict etiketi. Aynı case4'te string callable'a ulaştığı için bu label yerel executor şema denetimi diye okunmaz. | E09 results:case4.definition; probe:70–74,125–131 / E/Y |
| ECC-PY67 — `Python invocation admission` | func(**arguments) çağrısının gerçek Python imzasına göre sonuç vermesi. String kabul eden callable çalışabilir; missing required Python argument ayrı hata oluşturur. | N27 §5; E09 case4 / K/E/Y |
| ECC-PY68 — `ToolResult.is_error` | Unknown-name veya callable exception sonucundaki yapısal hata alanı. Diagnostic text'ten ve sonraki history mesajının alanlarından ayrıdır. | N27 §5–6; E09 cases3–4,7 / K/E/Y |
| ECC-PY69 — `synchronous tool execution` | Executor'ın ordinary callable'ları senkron çağırması. Async ReAct.run etiketi await-aware tool scheduling veya sandbox oluşturmaz. | N27 §5; LC C-EXECUTOR / K/Y |
| ECC-PY70 — `async ReAct.run` | Async olarak sunulan fakat içinde synchronous generate/tool çağıran helper girişi. Genel provider concurrency, cancellation veya runtime yetki sistemi kanıtı değildir. | N27 §5 / K/Y |
| ECC-PY71 — `registry as trusted capability set` | Caller'ın bütün registry'yi bilinçli güven kümesi sayabileceği alternatif kullanım çerçevesi. Request-specific authority açığı otomatik production güvenlik ihlali diye sınıflandırılmaz. | N27 §5 / Y |

## 8. Durma, son etki ve yeniden deneme

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY72 — `normal local tool round trip` | E09 case2'de advertised kayıtlı araç etkisi, ikinci input'ta result/id ve scripted final response. Pozitif local flow'dur; SDK/API veya gerçek görev kalitesi testi değildir. | N27 §6; E09 case2 / E/Y |
| ECC-PY73 — `no-tool response return` | Dönen output'ta tool call yoksa response'un iletilmesi. stop_reason=length de dönebilir; otomatik task-acceptance kontrolü değildir. | N27 §6; E09 case1 / K/E/Y |
| ECC-PY74 — `max_iterations` | Provider-loop geçiş sayısının sınırı. Son iterasyondaki tool etkilerini önleyen effect budget veya görev tamamlanma ölçüsü değildir. | N27 §6; E09 case5 / K/E/Y |
| ECC-PY75 — `last-iteration effect` | max_iterations=1 iken record'ın append yapıp limit sonucunun ardından dönmesi. Durma nedeni, önceki etkinin geri alındığı anlamına gelmez. | N27 §6; E09 case5 / E/Y |
| ECC-PY76 — `Max iterations reached output` | Content/stop_reason taşıyan sentetik sınır sonucu. Case5 dönüşünde tool result, transcript veya accumulated usage bulunmaz; bunların hiç oluşmadığı sonucu çıkarılmaz. | N27 §6; E09 case5 / K/E/Y |
| ECC-PY77 — `local history` | Helper içinde biriken assistant/tool mesajları. Bu akışta kullanıcıya dönen durable continuation checkpoint değildir. | N27 §4, §6; E09 cases2,5 / K/E/Y |
| ECC-PY78 — `later provider exception` | Tool etkisinden sonraki scripted generate çağrısının hatasının dışarı yayılması. Önceki in-memory etki varlığını korur; bütün provider arızaları için ölçülmüş davranış değildir. | N27 §6; E09 case6 / E/Y |
| ECC-PY79 — `fresh retry from original input` | Aynı ilk input ile yeni loop başlatmanın etkiyi tekrar üretebilmesi. Case6'nın iki çağrısı tek E09 run'ı içindedir; ayrı deney veya idempotent resume değildir. | N27 §6; E09 case6 / E/Y |
| ECC-PY80 — `no_internal_retry check` | E09 case6'daki yerel scripted request sayısını niteleyen kontrol adı. Bütün SDK/HTTP dependency'lerde toplam retry sıfır sonucu değildir. | E09 probe:140–152/results:case6; N27 §7 / E/Y |
| ECC-PY81 — `error text/id retention` | Tool hatasının diagnostic içeriği ve call id'sinin history'ye taşınması. Yapısal is_error düşse bile bütün hata bilgisinin kaybı değildir. | N27 §6; E09 case7 / K/E/Y |
| ECC-PY82 — `structural error projection loss` | ToolResult.is_error alanının generic history'de bulunmaması. Text diagnostic'in korunmasıyla birlikte okunur; silent success genellemesi yapılmaz. | N27 §6; E09 case7 / K/E/Y |
| ECC-PY83 — `accepted scripted result` | Case2'de ScriptedProvider'a önceden verilen final content. 'accepted' sözcüğü bağımsız kalite, kullanıcı onayı veya gerçek iş kabulü değildir. | E09 probe:107–114/results:case2.output / E/Y |

## 9. Config, bağımlılık uyumu ve hata sınıflandırması

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY84 — `validate_config` | Cloud key veya Ollama base URL truthiness kontrolü; generate/ReAct otomatik çağırmıyor. True değeri authentication, reachability veya model availability doğrulaması değildir. | N27 §7; LC C-INTERFACE/provider bodies / K/Y |
| ECC-PY85 — `openai>=1.30.0` | Paketin izin verdiği dependency alt sınırı. Bu aralık içindeki her SDK sürümünün kullanılan constructor'a uyduğu kanıtı değildir. | N27 §7; LC C-PACKAGE / K/Y |
| ECC-PY86 — `_enforce_credentials=False` | OpenAI-backed constructor'lara gönderilen argüman. Seçilmiş v1.30.0 signature bu argümanı veya catch-all kwargs kabul etmiyor; karşılık kaynak düzeyindedir, kurulu SDK deneyi değildir. | N27 §7; LC X-OPENAI-CLIENT / K/V/Y |
| ECC-PY87 — `OpenAI v1.30.0 comparator` | e2214ce sürümündeki constructor ve input type incelemesi. Açık lower-bound karşı-örneğidir; bütün daha yeni SDK'lar veya güncel servisler hakkında hüküm değildir. | N27 §4, §7; LC primary contracts / V/Y |
| ECC-PY88 — `constructor versus generate error boundary` | Constructor hatalarının adapter generate try/except dışında kalması. Generation error mapping bütün initialization arızalarını ele almış sayılmaz. | N27 §7 / K/Y |
| ECC-PY89 — `exception-text classification` | 401/authentication, 429/rate_limit veya context+length metinlerine göre hata sınıfı seçme. Etiket gerçek remote nedenin bağımsız teşhisi değildir. | N27 §7; LC provider bodies / K/Y |
| ECC-PY90 — `Ollama connection→AuthenticationError` | connection içeren hata metninin authentication sınıfına eşlenmesi. Bağlantı sorunu ile kimlik doğrulama nedeninin eşitliği kanıtlanmış değildir. | N27 §7; LC C-OLLAMA / K/Y |
| ECC-PY91 — `unmatched error propagation` | Eşleşmeyen hata dışarı yayılır; tanınan wrapper'lar cause bilgisini korur. Provider-switch fallback, durable retry veya rollback bunun otomatik sonucu değildir. | N27 §7 / K/Y |
| ECC-PY92 — `SDK-internal retries` | Bu yerel provider/loop gövdelerinden ayrı dependency davranışı. ECC'de retry state görülmemesi SDK'nın hiç yeniden denemediğini göstermez. | N27 §6–7 / Y |

## 10. Test, arşiv ve kanıt kapsamı

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY93 — `T-RESOLVER oracle` | Saved LLM_MODEL bulunan fixture'da provider class/precedence kontrolü. Sonraki request modelinin propagated olduğunu sınamıyor; upstream test incelenmiş, koşulmamıştır. | N27 §2, §8; LC T-RESOLVER / T/Y |
| ECC-PY94 — `T-PROVIDER fake SDK clients` | İlk request tool definitions ve response kenarlarını permissive fake clients ile sınayan testler. Native follow-up history veya API acceptance testi değildir; koşulmadı. | N27 §4, §8; LC T-PROVIDER / T/Y |
| ECC-PY95 — `T-EXECUTOR pinned scope` | Kayıtlı executor/registry/batch testleri; pin'li dosyada ReAct testi yok. Yeni indexed testler bu eski scope'a eklenmez; bütün repository test-yokluğu hükmü değildir. | N27 §8; LC T-EXECUTOR / T/Y |
| ECC-PY96 — `E09 preregistration` | 97ab9354 commit'inde run öncesi sekiz koşul ve olumlu karşılıkların yazılması. Kriter metni kendi başına gerçekleşmiş sonuç veya bilimsel bağımsızlık değildir. | PC; MC E09; E09 MANIFEST / E/Y |
| ECC-PY97 — `minimal package containers` | Original types/executor'ı package __init__ ve SDK importları dışında yükleyen deney düzeni. Normal installed-package/import uyumu bu deneyin kapsamına girmez. | PC; E09 probe:26–48 / E/Y |
| ECC-PY98 — `ScriptedProvider` | Önceden verilen LLMOutput/hata dizisini döndüren senkron deney sağlayıcısı. Gerçek model davranışı veya branch frekansı değildir. | E09 probe:58–68; ER / E/Y |
| ECC-PY99 — `deep-copied request snapshot` | Provider'a gelen input'un o anda derin kopyalanması. Sonraki history mutasyonunun önceki gözlemi değiştirmesini önleyen deney kaydı; ürünün durable log'u değildir. | E09 probe:63–65; MC E09 / E/Y |
| ECC-PY100 — `in-memory effect` | Deney araçlarının yalnız listeye değer eklemesi. [7] ve [7,7] yerel gözlemlerdir; production transaction veya dış sistem değişikliği değildir. | PC; E09 cases2–6 / E/Y |
| ECC-PY101 — `narrow message-shape checker` | Yalnız type=function ve arguments'ın string olmasını sınayan case8 checker. Complete OpenAI schema, SDK parser veya remote rejection oracle'ı değildir. | E09 probe:170–181; PC case8 / E/Y |
| ECC-PY102 — `corrected positive fixture` | Case8'de aynı serialized call'a type ve JSON-string arguments eklenen karşılık. ECC source patch'i veya çalışmış API düzeltmesi değildir. | E09 probe:170–181/results:case8 / E/Y |
| ECC-PY103 — `all_predictions_match` | Bir run'daki sekiz controlled case'in önceden belirtilmiş kontrollerle uyuşması. Sekiz bağımsız başarı, ECC doğruluğu veya güvenlik başarı oranı değildir. | E09 results; PC criteria; ER / E/Y |
| ECC-PY104 — `E09 lossless carrier` | Düzeltilmiş base64/ZIP'in probe, raw results, stderr, exit-code ve manifesti taşıması. Upstream source snapshots içermez; identity bilgisi yeni source body okuması değildir. | ER; PC; PUB E09 preservation / E/Y |
| ECC-PY105 — `publication correction versus rerun` | İlk yanlış encoded yüklemenin byte eşliğiyle düzeltilmesi. Deney tekrarı, sonuç değişikliği veya criterion uyarlaması değildir. | MC publication; PUB E09 correction / Y |

## 11. Taslakta ayrı adreslenen kullanımlar

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-PY106 — `invalid provider-type refusal` | Resolver'ın geçersiz provider türünü hata ile reddetmesi. Ad normalleştirmesinden ayrı sonuçtur; sessiz provider fallback veya bütün config hataları için aynı ret değildir. | N27 §2; LC C-RESOLVER / K/Y |
| ECC-PY107 — `list_models` | Provider'ın statik model listesini sunan yöntemi. ModelInfo veri kaydından ve canlı servis katalog sorgusundan ayrıdır. | N27 §3, §7; LC C-INTERFACE / K/Y |
| ECC-PY108 — `Astraflow CN variant` | Global varyantla ortak adapter biçiminde fakat ayrı env/endpoint varsayılanları taşıyan CN seçimi. Aynı etkin endpoint veya kurulum diye birleştirilmez. | N27 §3; LC C-ASTRAFLOW / K/Y |

## 12. E09 vaka hesabı ve kaynak tarafından kapsam kontrolü

E09 **2026-09-20'de kaydedilmiş tek run / sekiz controlled case** olarak kalır. Bu tur betik yeniden çalıştırılmadı. Arşiv bütünlüğü kontrolü, recorded-result okuması ve JSON iç tutarlılığı kontrolü yeni davranış deneyi veya bağımsız doğrulama değildir.

| Ham sonuç vakası | İlgili kullanım kayıtları | Taşınan sınır |
|---|---|---|
| 1_no_tool_return | PY73 | length durma nedeni aynen döner; task acceptance değildir. |
| 2_known_tool_round_trip | PY52/PY53/PY58/PY72/PY83 | Gerçek yerel effect/history yolu; scripted final text gerçek iş kabulü değildir. |
| 3_advertised_vs_registered | PY60–PY64 | Registry membership ve advertised list farklıdır; unknown-name kontrolü korunur. |
| 4_schema_vs_python_call | PY65–PY68 | strict/schema beyanı yerel schema admission değildir; Python imzası ayrı hata üretir. |
| 5_last_iteration_effect | PY74–PY77 | Son geçişte etki oluşur; sentetik çıktı result/history/usage taşımaz. |
| 6_error_and_fresh_retry | PY78–PY80 | İlk etki kalır, fresh retry tekrarlar; iki loop çağrısı tek deney içindedir. |
| 7_error_projection | PY68/PY81/PY82 | Diagnostic ve id korunur; structural is_error history'de yoktur. |
| 8_message_contract_shape | PY54/PY55/PY101/PY102 | İki-alan shape checker ve corrected fixture; API acceptance değildir. |

N27 §1 → PY01–PY09; §2 → PY10–PY21/PY93/PY106; §3 → PY22–PY51/PY107/PY108; §4 → PY52–PY59/PY94/PY101–PY102; §5 → PY60–PY71; §6 → PY72–PY83; §7 → PY84–PY92/PY107; §8 → PY93–PY105 ve açık sınırlar. LC'nin finite20-file, tests, external contracts, E09 ve indexed-revision kapsamı; MC'nin yöntem/deney seçimi ve PUB'ın yayın/transfer düzeltmesi ayrıca okundu. Dört research anlatısı aynı ürüne bağımsız dört destek sayılmaz.

Empty cli/__init__.py, docstring-only core/__init__.py, export modülleri, static model adları, örnek endpoint/limitler ve dependency metadata kendi rollerinde hesaplanır; doğal dildeki her sözcüğe bağımsız kavram tanımı üretilmez. Yalnız adı verilen alan veya kaynakta tanımlanmayan teknik ayrıntı dışarıdan genel bilgiyle doldurulmaz. Sabit kaynakta anılan model/hizmet adları güncel ürün önerisi değildir.

PC'nin prediction'ları betik ve raw checks ile karşılaştırıldı. Probe'un original source hash guard'ı, import bypass'ı, deep-copy kaydı, list-only effect'i ve iki-field checker'ı görüldü. Ham results.json içindeki bütün vakalar ve metadata okundu; betik/result/manifest hashleri ve ZIP CRC doğrulandı. Bu yol representation/integrity hatalarını azaltır; model frekansı, installed SDK uyumu, native API acceptance veya production yetki sınırını doğrulamaz.

## 13. İlişki görünümü, yorum ve düzeltme izi

Kaynakta üç ayrı giriş korunur: **selector → saved/env/printed preferences**; **library caller → provider + LLMInput → generate**; **caller → ReActAgent → provider output → registered executor → generic history → sonraki provider request**. İlk tercih dosyasının varlığı diğer iki yolun bütün ayarları tükettiğini göstermez. Optional PromptBuilder/template registry bu yolların zorunlu basamağı değildir.

Araç yolunda **definition → advertised list**, **registry → callable lookup**, **schema → Python invocation**, **ToolResult → history**, **history → provider-native wire** ayrı ilişkilerdir. Native ilk-request tool tanımı, response normalizasyonu ve sonraki-request dönüşümü birbirinin yerine geçmez. Son çağrı veya limit çıktısı da kalıcı etkileri geri almış sayılmaz.

Önceki TL35 ve EP01–EP19 representation/consumer ayrımları yeni Python kullanımını anlamaya yardımcı olur; fakat Rust profile/harness ile Python provider/model aynı nesne değildir. TL65 fresh template retry ile PY79 fresh loop retry farklı üretici ve etki alanlarına aittir. OC21/OC59 callback/tool-return farkı, Python history'nin native request'e dönüşmesini otomatik doğrulamaz. OD65/default-zero ve OD79/error-empty, burada PY103 prediction-match veya PY83 scripted kabul metniyle aynı başarı sözleşmesi değildir. Bunlar ortak tanım/B8 kararı değil, kapsamı belirtilmiş geri çağırma bağlarıdır.

**Ham kanıtın bu turdaki anlam katkısı:** PY66'daki strict:true ve PY83'teki accepted scripted result doğrudan arşivde görülerek daraltıldı. İlki executor şema kontrolü, ikincisi bağımsız iş kabulü olarak okunmadı. PY80 no_internal_retry adı da yalnız o scripted loop kontrolüyle tutuldu; SDK'nın kendi retry davranışına genellenmedi. Kaynak araştırmada zaten korunan olumlu round-trip, unknown-name ve error-text yolları kaybolmadı.

**Taslakta açıklık:** Normalization/invalid-type refusal, ModelInfo/list_models ve Astraflow global/CN varyantları ilk çalışma listesinde birlikte gösterilmişti. İlk repository yayını öncesinde PY19/PY106, PY31/PY107 ve PY47/PY108 ile ayrı adreslendi. Bu, daha önce yayımlanmış kaydı değiştirmek veya yeni ürün bulgusu değildir. Önceki TERMS dosyalarında düzeltme gerektiren maddi çelişki bu kaynak karşılaştırmasında saptanmadı.

E09'un tarihsel yanlış encoded yüklemesi ile bu turun raw kurtarması ayrı olaylardır. Bu tur indirme yardımcısının URL-view önkoşulu ve bir urllib DNS hatası ham bytes sağlamadı; bağlı GitHub yanıtının tam base64 içeriği response recovery ile alındı. Yerel aktarımın **8801-byte Git blob** eşliği, decode sonrası **6598-byte ZIP** ve üye hash/CRC kontrolleri sağlandı. Bağımsız yeni target run veya sonuç düzeltmesi yapılmadı.

## 14. Kapanış ve açık sınır

**ECC-PY01–PY108**, 108 adreslenebilir kullanım kaydıdır; bağımsız kavram, deney veya başarı yüzdesi değildir. Altı repository metni, bir encoded carrier ve içindeki beş üyenin bağlamlı aktarımı U12-C'yi kapsar. C1–C4/C5a/C5b/U12-A–B2 önceki kayıtlarıyla birlikte ilk U10–U12 C5 source-family dilimi tamamlanabilir; current READING/TERMS/STATE ve yayın kontrolü ayrıca kapatılır. ECC package-wide C6 tamamlanmış sayılmaz.

Q02c2; normal wheel/import/SDK/API kabulü, canlı multi-turn/model/credential/catalogue, budget/streaming, async/cancellation, request-specific authority/schema isolation, durable/idempotent recovery ve accepted task outcome bakımından açık kalır. Bunlar yeni Concepts deneyi veya benimsenmiş SOUL gereksinimi değildir. No-tool return, source-interface varlığı, truthful hash ve eight-case prediction match bu güçlü iddiaları doğrulamaz. E06 excluded; E04/E07/E08/E09 ve iki E05 geçmişi ayrı kalır.

Batu okuma anındaki anlam seçimlerini denetleyemediğinden önemli dayanak ve yorum değişiklikleri izlenebilir tutulur. Ortak sözcükler ortak anlamı garanti etmez; kaynak kullanımı, önceki araştırmacı yorumu, extractor açıklaması ve kullanıcı onayı teknik doğruluk bakımından ayrı kalır.

**Sıradaki Concepts işi C6: güncel paket envanteri, korunmuş tam okuma/yorum geçmişi, bütün TERMS ve kaynak delta'sının reconciliation'ı.** U13-A'nın yeni yayımlanmış dosyaları da bu hesaba girer; mevcut araştırmayı Concepts'e aktarmak, U13-B teknik araştırmasını yürütmek değildir. Genel ortak referans/B8, Foundation veya SOUL mimarisi bu dosyayla başlamaz.
