# J kaynak defteri — review kabulü ve gerçek middleware

**Tarih:** 2026-09-09. **Research tabanı:** `9a95b2cf1f8a0460ac6128e1409bf54aa3191022`.
**Upstream:** `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`.

J kimlikleri yalnız U01-D3 dilimine aittir; eski H/S/W/D/E defterleri korunur. FULL READ içerik okumadır; EXECUTED yalnız aşağıda açıkça belirtilen modüldür. Her kaynak için canonical bağlantı `https://github.com/NousResearch/hermes-agent/blob/c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a/<path>` biçimindedir. Satır aralıkları bu pin'e aittir.

| ID | Path | Git blob | Bu tur okuma / yürütme |
|---|---|---|---|
| J01 | agent/tool_executor.py | 799199c10f9930da77c01da2324373614b27cb78 | SELECTED tekrar: 236–290, 430–570, 596–784, 778–895. 15 eski tanım, yeniden transkribe edilmiş aralıklarla AST karşılaştırıldı. Tam yerel dosya hash kontrolü ve tam modül yürütmesi YOK. |
| J02 | hermes_cli/plugins.py | da8d7e2c68b2346e6ecc15567d755d96085ef767 | SELECTED tekrar: 1700–1885; whitelist setter/consumer/directive çözümü. 7 tanım için aralık-temelli AST cross-check. Tam PluginManager/discovery yürütülmedi. |
| J03 | agent/background_review.py | 0e8e76ae235450f3e896a86951409cf82b7cca1e | SELECTED tekrar: 1–220 ve özellikle 600–1040 içindeki _fork_init_kwargs, build_cache_parity_fork, _review_tool_whitelist, _run_review_fork, auto-deny. 221–450 prompt isteği kesildi; o bölüm bu tur FULL sayılmaz. Yeni review yürütmesi yok. |
| J04 | agent/agent_init.py | 562dfcc32866840ab9c84244595927239b790bd7 | SELECTED: 1–180, 480–720, 920–1280; yük taşıyan _load_tools, şemadan valid_tool_names, session/memory/client sırası. Bütün constructor ve provider kurulumu çalıştırılmadı. |
| J05 | agent/turn_tool_round.py | daa009ac80bba9c2cb7eab5da0babae2cc117be0 | FULL READ: 1–200 + 201–EOF; validate/filter, persist-before-execute, sonuç/persistence/guardrail/compression yolları. NOT EXECUTED. |
| J06 | agent/relay_tools.py | 44d06a1653b8e52b68cbc972ee539c3949cb2918 | FULL READ: execute, unmanaged/managed dalları, callback-error ve postprocessing ayrımı. Relay runtime/relay_llm bağımlılık kapanışı ve yürütme yok. |
| J07 | hermes_cli/middleware.py | 897e4afc07ba0d78ba928baf39a8573422b648be | FULL READ: 1–220 + 221–EOF, son bölüm yeniden okundu. Tam 9277 byte Git blob eşleşmesi; EXECUTED, MW01–MW08. Plugin kayıt nesnesi ve callbacks/handler sentetik. |
| J08 | LICENSE | 75410e73319c72cd3e991a501c5455eb78f38375 | Önceki repo'ya yayımlanmış arşivden exact lisans kopyası; blob tekrar eşleşir. J07 ve karşılaştırma seçkileriyle korunur. |

## Kaynak seçkilerinin karşılaştırma anlamı

Eski `2026-09-08-worker-policy/excerpts/` dosyaları research ref'inde sırasıyla `027023684d477e9919613492e991d0ec706a3a0f` ve `980c7edb1d9a0f402b3d58302c6844c32f392c36` kimliğindedir. Bu tur yerel ZIP kopyaları bu kimliklerle doğrulanmıştır.

`canonical-ranges/` adı, tamamlanmış canonical modül anlamına gelmez: dosyalar J01/J02'nin GitHub bağlantısından yeniden okunan sabit aralıklarının **manuel transkripsiyonudur**. Modül importları ve bazı yorumlar yoktur; karşılaştırılan tanımlardaki docstring/decorator/gövde korunmuştur. Bu dosyalar import edilmez, AST olarak okunur. Tam upstream dosyalarıyla byte eşitliği iddia edilmez.

15 executor + 7 plugins tanımı AST düzeyinde eşleşti. Bir tanımda sentetik AST değişikliği negatif kontrol tarafından yakalandı. İki kopya da aynı assistant'ın transkripsiyonundan geçtiği için ortak hata riski vardır. Eski `verify_excerpts.py` tam hash-doğrulanmış E01/E02 dosyalarıyla **çalıştırılmadı**. Ad-hoc eşitlik gözlemi SPEC'ten önceydi; kayıtlı yeniden kontrol keşifsel niteliğini korur. Yüksek kapsamlı tam-fidelity iddiası kapanmadı.

## Exact middleware ve deney sınırı

İlk yerel J07 transkripsiyonu bir boş satır eksikti (9276 byte, blob `8589ca95e122de26ebea69cf0c62acf5962b00f9`). Importtan önce yakalandı; canonical 212–EOF aralığı yeniden okunup boş satır düzeltildi. Nihai 9277 byte dosya beklenen `897e4afc...` ile eşleşti; beklenen kimlik değiştirilmedi. MW01–MW08 ancak bundan sonra ve SPEC yazıldıktan sonra çalıştırıldı.

Gerçek `run_tool_execution_middleware` ve `_run_execution_chain` kullanılır. `hermes_cli.plugins.get_plugin_manager` açık fake registry döndürür. Callback'ler ve terminal handler yalnız bellekte işaretleyici üretir. Bu düzen config/discovery, gerçek zorunlu policy eklentisi, worker, AIAgent, provider, gerçek dosya mutasyonu veya onay arayüzünü çalıştırmaz. Sonuç yalnız bu gerçek modülün belirtilen callback sözleşmesine aittir.

## Erişim / freshness

Upstream path ve raw içerik GitHub bağlantısından okundu. Büyük modüllerin otomatik yerel byte materyalizasyonu doğrudan URL denemelerinde DNS; web açılışında cache miss; download aracında önceden web erişimi koşuluyla engellendi. Bu, pinned kaynakların GitHub'dan okunamadığı anlamına gelmez. Engeller ve scope değişimi [ACCESS.md](ACCESS.md)'dedir.

Default-branch kod araması `9e0dc4319ae2d59c60f5226b5c0af58d17755bfa` ref'li navigasyon sonuçları verdi. Yalnız J04/J05 dosyalarını bulmak için kullanıldı; yük taşıyan kaynaklar tekrar primary pin'den açıldı. Yeni HEAD doğrulaması yapılmadı; iki sürüm birleştirilmedi. W belgeleri eski unpinned statüsünü korur.
