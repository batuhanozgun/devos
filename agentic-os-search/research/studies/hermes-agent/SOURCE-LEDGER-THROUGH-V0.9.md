# Hermes Agent — Birikimli kaynak ve yürütme defteri

**Son ek: 2026-09-09 / U01-M2 bellek/pending tesliminin yayını; U01-D3 review-admission, range cross-check ve exact middleware kanıtı korunur.** Birincil pin `NousResearch/hermes-agent@c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` değişmedi. Current çalışma otoritesi STATE; defter kanıt/okuma rotasıdır.

FULL tam kaynak okuması; SELECTED belirtilen kesit/sembol; LISTED yalnız topoloji. Hiçbiri kendi başına execution değildir. Eski tam okumalar veya deneyler yeni turda yeniden yapılmış sayılmaz. Tam upstream modül kimliği, manuel excerpt/range kimliği ve çalışma kapsamı ayrı tutulur.

## H-kaynakları — önceki birikimli kayıt korunur

Primary pin'e göre yollar ve kimlikler:

| ID | Yol | Blob SHA | Önceki birikimli okuma |
|---|---|---|---|
| H01 | README.md | c05112266746ff99a3326a62c38c33fbc08ecd23 | FULL, ilk + curator |
| H02 | website/docs/developer-guide/architecture.md | 3640103c3de97ed7c01a3862b76b35371f9d5f06 | FULL, ilk + curator |
| H03 | website/docs/user-guide/features/memory.md | 0c03f4e8cb897bbfd0af29375d7a245fa5751499 | FULL, ilk tur |
| H04 | agent/background_review.py | 0e8e76ae235450f3e896a86951409cf82b7cca1e | FULL; caller turu D18, J03/M2-R01 selected tekrar |
| H05 | tools/skill_manager_guards.py | 06df3cd695592fd2e582b49ce391d76fd137da3b | FULL, ilk + curator |
| H06 | tools/skill_provenance.py | 3df9cf143045644310fa7d27a65666c8c23caf95 | FULL; D19 + dar execution; ayrı M2-S05 koşusu aşağıda |
| H07 | tools/write_approval.py | f1e99b46e934595c002c2bc659143fcbc1f9fe8d | FULL; U01B/S04 + dar execution; ayrı U01B2 ve M2-S04 arşiv/koşu kapsamları aşağıda |
| H08 | hermes_cli/write_approval_commands.py | 150b72dfd17696ab7a64f97057b7405128f5b352 | FULL; S05/D17 statik; M2-S03'te tam shared command yürütüldü, actual UI değil |
| H09 | tests/run_agent/test_background_review_toolset_restriction.py | 3175aa394ce4aaa3258243cec82c546cdad73ba1 | FULL / TEST SOURCE INSPECTED |
| H10 | tests/tools/test_write_approval.py | 44db64514921b1cb892e16e913bffa641acb2947 | FULL / TEST SOURCE INSPECTED |
| H11 | pyproject.toml | 12c672ff3cdacd9d045d60d1cc4248e0aeba6f72 | SELECTED manifest/dependency, curator 1–115 |
| H12 | agent/memory_manager.py | 44ca6f930e884a9667b54fce6e380d04bd001886 | SELECTED 1–120; D15/D16 farklı dosyalardır |
| H13 | SECURITY.md | cea2a9a2e8869ac7a4b7307332b974a27e9fd27a | FULL, ilk + curator |
| H14 | AGENTS.md | aecd44860c669bbb997e90b11112dab540042f97 | FULL, araştırma nesnesi |
| H15 | agent/AGENTS.md | 7fb81c5a66a5eb944cabdd7a5a8a015a5a3621b4 | FULL, araştırma nesnesi |
| H16 | skills/AGENTS.md | 27e47db7b607a59f40652959ade4d51bf105016c | FULL, araştırma nesnesi |
| H17 | website/docs/user-guide/features/curator.md | 66dd545cc7e611c06095690b9d36404ffc35047e | FULL |
| H18 | agent/curator.py | 670abfb71d923918f53698226abdb7f494e11b57 | FULL, ardışık 200 satırlık aralıklar/EOF |
| H19 | tools/skill_usage.py | 48d7edc9d3cc636a5c8762304b870fd0a6d8e20d | FULL |
| H20 | tests/agent/test_curator.py | dd4fd558093485e672cd3cf77dc4d29793282b8b | SELECTED 1–440 / TEST SOURCE INSPECTED |
| H21 | package.json | 406b73b205a32c1ddc7fd1dabfb02250efa5407f | FULL; Node manifest Python release'i değil |
| H22 | tools/skill_manager_tool.py | 81d64b909b6b482654060b38b63802460b63314b | FULL via U01B/S01; eski orta aralık eksikliği kapanmış |

[U01B aktarım öncesi ayrıntılı defter](https://github.com/batuhanozgun/agentic-os-search/blob/000f691b9a94607c9a8219961b4618eda0f1014f/research/studies/hermes-agent/SOURCE-LEDGER.md), [v0.5 tam defter](https://github.com/batuhanozgun/agentic-os-search/blob/a218acfc20e7ece488709e00a9762166ec970fba/research/studies/hermes-agent/SOURCE-LEDGER.md), [v0.7 defteri](https://github.com/batuhanozgun/agentic-os-search/blob/9a95b2cf1f8a0460ac6128e1409bf54aa3191022/research/studies/hermes-agent/SOURCE-LEDGER.md) ve [bu yayın öncesi v0.8 defteri](https://github.com/batuhanozgun/agentic-os-search/blob/c0ef2374a34cbb30f5f58a28333f89254931b00f/research/studies/hermes-agent/SOURCE-LEDGER.md) tarih/ref/aralık ve erişim olaylarını korur. Tarihsel 'yalnız statik', 'H22 eksik' veya 'caller erişilemiyor' ifadeleri current birikimli durum değildir.

## U01B S-kaynakları ve ilk dar deney

[U01B/SOURCES.md](evidence/2026-09-07-u01b/SOURCES.md) exact path/ref/blob/aralık ve eski execution kaydıdır. S-ID'leri yereldir.

- S01 = H22, tam skill mutator.
- S02 = tools/skill_manager_batch.py, blob `9f38adff284eede4234948f67e99a43752c0926e`, FULL + exact modül/sentetik bağımlılık deneyi.
- S03 = tests/tools/test_skill_manage_batch.py, blob `7e1c105339c347c950e0cf764d0043f106c9d239`, FULL / TEST SOURCE INSPECTED; çalıştırılmadı.
- S04 = H07; S05 = H08.
- S06 = LICENSE, blob `75410e73319c72cd3e991a501c5455eb78f38375`, FULL ve kaynak kopyalarıyla korunmuş.

[Eski probe](evidence/2026-09-07-u01b/component-probe/README.md) → harness/RESULT/stdout/stderr/upstream/lisans. UTC `2026-09-07T09:35:13.772427+00:00`, Python 3.13.5/Linux. İki exact modül + sentetik bağımlılıklar, 10 tanılayıcı durum. Ürün conformance veya bağımsız araştırmacı tekrarı değil. Bu tur yeniden çalıştırılmadı. [Yayın aktarımı](evidence/2026-09-07-u01b/PUBLICATION.md) deneyden ayrı olaydır.

## Tree, yöntem ve freshness geçmişi

T00 root tree `f54f5e9d2682bf11f164de7b34ee10ec121b6434`; T01 apps tree `d6ec471bf1d4acfb42fef4b82b22ce91a2c50437`: non-recursive listeler. Primary committer zamanı `2026-09-07T08:37:43Z`. T03 d8a077... root gözlemi. Recursive tam envanter/LOC veya Gstack büyüklük kıyası yoktur.

Curator ref'i `d8a07768c5ee59afae62e9fb51d45e1e30aa74da` primary'den bir commit ilerideydi; yalnız contributor/pt_input_extras/kitty-keypad testi ve iki CLI belge yolu değişmişti. İlgili kaynaklar aynı blob'larla uzlaştırıldı. U01B'nin `7874ef9f62b9b533f8d3da6107eb2a52f4be252f` gözleminde yalnız S01/S02/S04 aynı blob taşıyordu. Bunlar bütün sonraki HEAD'lerin veya kurulu release'in doğrulanması değildir.

G01 Gstack METHOD `dc003b3f74115667a05787a847eadb10876784c8`; G02 META `f2ad498742f026aa84578e82ec7fd0cf6843da65`, önceki FULL okumalar: yöntem girdisi, Hermes teknik kanıtı değil. Canonical agent-control dosyaları corpus'a katılmaz.

## W01–W08 — ayrı unpinned belge katmanı

[Okuma/erişim defteri](evidence/2026-09-08-doc-contracts/READING-AND-ACCESS.md) URL/tarih/bölüm ve sınırları; [05 notu](notes/05-DISPATCH-CONTEXT-AND-REPLAY-CONTRACTS.md) belge kontratı/karşı-sınama tasarımını taşır.

| ID | Resmî belge |
|---|---|
| W01 | Tools Runtime |
| W02 | Agent Loop Internals |
| W03 | Event Hooks |
| W04 | Persistent Memory |
| W05 | Prompt Assembly |
| W06 | Profiles |
| W07 | Session Storage |
| W08 | Context Compression and Caching |

W gözlemleri commit/blob'a bağlanmadı. H03 ile W04 aynı nesne sayılmaz. Belge turundaki iki `run_agent.py` path 429'u ve container DNS hatası tarihsel erişim sonucudur; o tur yeni caller kodu veya execution yoktu. K01–K09 o tarihte NOT RUN idi; güncel kısmi kaynak/probe durumları RESEARCH-PLAN v0.9'da ayrılır.

## D01–D22 — pinned caller / worker / memory kaynakları

[Tam D defteri](evidence/2026-09-08-context-transfer/SOURCES.md) exact path/blob ve FULL/SELECTED/EXECUTED derinliğini taşır. [06](notes/06-CALLER-DISPATCH-AND-CONTEXT-TRANSFER.md) caller/transfer; [07](notes/07-MEMORY-STORE-AND-PENDING-REPLAY.md) memory/replay bulgularını içerir.

Caller turu `a218acfc...` research state'inden başladı. Path isteği yine 429 verdi; primary tree/blob API kaynak getirdi. Root'a ek agent/tools/hermes_cli non-recursive topolojisi görüldü; D09/D10/D19 yerel kopyaları ve LICENSE Git blob hash'leriyle doğrulandı. Bir source-transcription uyuşmazlığı execution öncesinde yakalanıp canonical blob yeniden alınarak düzeltildi; doğrulama eşiği değiştirilmedi.

[Transport probe](evidence/2026-09-08-context-transfer/README.md): UTC `2026-09-08T15:57:15.365904+00:00`, Python 3.13.5/Linux. Üç exact modül, sentetik callback API/profil marker/allowlist; P01–P07. Gerçek executor/PluginManager/AIAgent/MemoryStore ve profil resolver bu koşuda yoktur. Yedi beklenti matched; product conformance NOT ASSESSED. [Ham sonuç](evidence/2026-09-08-context-transfer/RESULT.json), [harness](evidence/2026-09-08-context-transfer/harness.py), [kimlik manifesti](evidence/2026-09-08-context-transfer/MANIFEST.json).

## U01B2 — ayrı arşiv kaynaklı deney ve sonradan yayın

[08 canonical giriş](notes/08-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md) → [özgün rapor](evidence/2026-09-08-u01b2/06-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md), [SOURCES.json](evidence/2026-09-08-u01b2/SOURCES.json), [RESULT](evidence/2026-09-08-u01b2/RESULT.json), [SPEC](evidence/2026-09-08-u01b2/SPEC.md), [probe](evidence/2026-09-08-u01b2/probe.py), [yayın](evidence/2026-09-08-u01b2/PUBLICATION.md).

U01B2 dilimi research `a218acfc...` arşivinden S02 ve S04/H07'yi FULL yeniden okudu; blob'lar `9f38adff284eede4234948f67e99a43752c0926e` ve `f1e99b46e934595c002c2bc659143fcbc1f9fe8d`. Yeni H-ID veya upstream güncellik doğrulaması değildir. Kaynak lisansı aynı `75410e...` blob'udur.

Koşu UTC `2026-09-08T15:48:02.995262+00:00`, Python 3.13.5/Linux; 12 tanılayıcı senaryo, G01 içinde 10 gate varyantı. Gerçek iki modül ile sentetik config/profile-origin/callback/guard/mutator/adapter/reentry. R03 önceki exception sınırının yeni fixture tekrarı; R04 deterministik araya-giren yazı, gerçek thread yarışı değildir. Gerçek production replay, kilitler, UI, ledger/sync veya kalite deneyi yapılmadı. HARNESS-CHECK yalnız değiştirilmiş kaynak kimliğinin execution öncesi reddini sınar.

U01B2 ZIP aktarımında 14 manifest girdisi byte/SHA-256 ile kontrol edildi; MANIFEST dahil 15 özgün dosya korundu. Deney tekrarlanmadı. İlk hazırlık tabanı `29ab9b816843bab6f9e5f5b5815590fbac2b1713`; eşzamanlı farklı dosya değişimleri yayın kaydında uzlaştırıldı. NOT PUBLISHED/caller erişimi ifadeleri kendi tarihsel turuna aittir. Yerel D01 senaryosu D kaynak defterinin D01'iyle karıştırılmaz.

## E01–E07 / U01-D2 — source-selected worker-policy entegrasyonu

[09 giriş](notes/09-WORKER-POLICY-EXECUTION-BOUNDARY.md) → [tam araştırma](evidence/2026-09-08-worker-policy/RESEARCH.md) → [ayrıntılı E defteri](evidence/2026-09-08-worker-policy/SOURCES.md). Bu tablo eski D kimliklerinin yerine geçmez.

| E-ID | Primary kaynak ve blob | Gerçek derinlik |
|---|---|---|
| E01 | agent/tool_executor.py — 799199c10f9930da77c01da2324373614b27cb78 | Blob yanıtı alındı, seçili shared/sequential/worker/commit kaynakları incelendi. Yalnız elle aktarılmış excerpts/tool_executor.selected.py tanımları yürütüldü; tam modül ithali/hash-verified execution değil. |
| E02 | hermes_cli/plugins.py — da8d7e2c68b2346e6ecc15567d755d96085ef767 | Seçili whitelist/directive kaynakları; yalnız excerpts/plugins.selected.py yürütüldü. Tam PluginManager/discovery değil. |
| E03 | tools/thread_context.py — d8c37af8f5a529680e81e867177140e41c4c6656 | FULL READ + tam Git blob eşleşmesi + EXECUTED; callback API sentetik. |
| E04 | tools/daemon_pool.py — 5682a8f6ae103a421c1081b69ee6f9272957acdf | FULL READ + tam Git blob eşleşmesi + EXECUTED; CPython iç API bağımlılığı. |
| E05 | agent/tool_dispatch_helpers.py — f994ecfab247490695d75211f93f55688166dc6d | Seçili planner/admission/path rezervasyonu/NEVER_PARALLEL incelendi; modül çalıştırılmadı. Harness yalnız kaynak sabitini taşıdı. |
| E06 | agent/turn_tool_validation.py — db3e89334ebb4302f55357e8063c28f5758becd5 | FULL READ + tam Git blob eşleşmesi + V01–V05'te EXECUTED; holder/message helpers sentetik. |
| E07 | LICENSE — 75410e73319c72cd3e991a501c5455eb78f38375 | Önceki arşivden alınan lisansın blob kimliği tekrar eşleşti; kaynaklarla korunuyor. |

**İlk koşu:** [RESULT](evidence/2026-09-08-worker-policy/RESULT.json), C01–C14, UTC `2026-09-08T19:31:50.677314+00:00`. **Ek koşu:** [VALIDATION-RESULT](evidence/2026-09-08-worker-policy/VALIDATION-RESULT.json), V01–V05, UTC `2026-09-08T19:36:58.555297+00:00`. Kayıtlı ortam Python 3.13.5/Linux. Tam name-validator eklenmesi bütün review inşasını veya gerçek ad-kümesi üretimini yürütmez.

**Gerçek kimlik ret kontrolü:** [IDENTITY-CHECK](evidence/2026-09-08-worker-policy/IDENTITY-CHECK.json), UTC `2026-09-08T19:36:24.270992+00:00`. Değiştirilmiş geçici kaynak kopyası gerçek harness doğrulayıcısıyla upstream importtan önce reddedildi. İlk RESULT alanındaki basit hash eşitsizliği bundan farklıdır; eski sonuç değiştirilmedi.

Manuel E01/E02 seçkileri added imports/scaffolding ve kendi kimlikleriyle tutulur; bunların SHA-256'sı upstream tam dosya hash'i değildir. `verify_excerpts.py` orijinal tam E01/E02 ile AST kontrolü için hazırdır, fakat o kontrol NOT RUN. Runtime çevresindeki Relay/middleware/lifecycle/guardrail/approval/agent/profile/UI/config taklitleri SOURCES/README/harness'te açık. Tam ordinary/concurrent loop, gerçek review/AIAgent/PluginManager, provider/credential/network ve gerçek zararlı araç yürütülmedi.

**2026-09-09 D2 yayını:** [PUBLICATION](evidence/2026-09-08-worker-policy/PUBLICATION.md) ve [TRANSFER-CHECK](evidence/2026-09-08-worker-policy/TRANSFER-CHECK.json). ZIP CRC ve 25 manifest girdisi doğrulandı; manifest dahil 26 özgün dosyanın Git tree kimliği yerel exact byte'lar ve GitHub readback arasında aynı çıktı: `d6ea71085c402744afbf80b1f9f4553eb97fbdb4`. Bu içerik aktarımıdır; hiçbir eski deney, kaynak AST kontrolü veya current upstream araştırması o yayında yeniden yapılmadı. NOT PUBLISHED/NOT APPLIED/eski plan metinleri tarihsel teslim olarak korunur.

## J01–J08 / U01-D3 — source trace ve exact middleware

[10 giriş](notes/10-REVIEW-ADMISSION-AND-MIDDLEWARE-FAILURES.md) → [J defteri](evidence/2026-09-09-review-middleware/SOURCES.md) → [tam araştırma](evidence/2026-09-09-review-middleware/RESEARCH.md). Ayrıntılı satır aralıkları, source identity ve actual/synthetic ayrımı J defterindedir.

| J-ID | Pinned kaynak / blob | Derinlik |
|---|---|---|
| J01 | agent/tool_executor.py — 799199c10f9930da77c01da2324373614b27cb78 | SELECTED tekrar; 15 eski tanımın manuel-range AST cross-check'i. Tam yerel original yok. |
| J02 | hermes_cli/plugins.py — da8d7e2c68b2346e6ecc15567d755d96085ef767 | SELECTED tekrar; 7 tanım için aynı sınırlı karşılaştırma. |
| J03 | agent/background_review.py — 0e8e76ae235450f3e896a86951409cf82b7cca1e | SELECTED fork kwargs/build/whitelist/run; eski H04 full okuma yeniden ilk-full sayılmaz. |
| J04 | agent/agent_init.py — 562dfcc32866840ab9c84244595927239b790bd7 | SELECTED _load_tools/schema-derived valid names ve init/persistence/memory kesitleri. NOT EXECUTED. |
| J05 | agent/turn_tool_round.py — daa009ac80bba9c2cb7eab5da0babae2cc117be0 | FULL READ validate/filter/persist/dispatch/post-result; NOT EXECUTED. |
| J06 | agent/relay_tools.py — 44d06a1653b8e52b68cbc972ee539c3949cb2918 | FULL READ managed/unmanaged/callback-error/postprocessing; runtime bağımlılıkları ve koşusu açık. |
| J07 | hermes_cli/middleware.py — 897e4afc07ba0d78ba928baf39a8573422b648be | FULL READ + 9277 byte tam Git blob doğrulaması + MW01–MW08 EXECUTED. Registry/callback/handler sentetik. |
| J08 | LICENSE — 75410e73319c72cd3e991a501c5455eb78f38375 | Aynı exact kaynak lisansı korundu. |

**Range cross-check:** [RANGE-FIDELITY](evidence/2026-09-09-review-middleware/RANGE-FIDELITY.json), UTC `2026-09-09T08:13:01.073141+00:00`; 22 eşleşme ve AST değişikliğini yakalayan negatif kontrol. Yeni pinned aralıklar da manuel transkripsiyondur; ortak hata riski vardır. Tam büyük-original hash + eski verify_excerpts.py NOT RUN statüsü değişmedi. Ad-hoc ilk eşitlik SPEC öncesiydi; keşifsel kontrol.

**Middleware koşusu:** [MIDDLEWARE-RESULT](evidence/2026-09-09-review-middleware/MIDDLEWARE-RESULT.json), UTC `2026-09-09T08:12:19.368928+00:00`, Python 3.13.5/Linux. Sekiz durum ve gerçek pre-import bozuk-kaynak ret kontrolü; [kod](evidence/2026-09-09-review-middleware/middleware_probe.py), [SPEC](evidence/2026-09-09-review-middleware/SPEC.md). J07'nin ilk eksik boş satır kimlik hatası importtan önce canonical kuyruğa dönülerek düzeltildi; beklenen hash değiştirilmedi. Eski deneyler tekrarlanmadı; yeni fake registry tüm PluginManager değildir.

**Aktarım:** [MANIFEST](evidence/2026-09-09-review-middleware/MANIFEST.json) 19 içerik girdisi/manifest dahil 20 core dosya; core Git tree `ce3c4892a2286454c04b511b6a29c5e06834725d` yerel bytes ve uzak readback arasında eşleşti. [PUBLICATION](evidence/2026-09-09-review-middleware/PUBLICATION.md) core'dan sonra eklenir. Identity, range fidelity ve product behavior birbirine eşitlenmez.

## M2-S/R / U01-M2 — geri kazanılan bellek ve pending yürütmesi

[11 giriş](notes/11-MEMORY-STATE-AND-PENDING-LIFECYCLE.md) → [M2 defteri](evidence/2026-09-09-memory-pending/SOURCES.md), [tam araştırma](evidence/2026-09-09-memory-pending/RESEARCH.md), [N01–N12](evidence/2026-09-09-memory-pending/RESULT.json). M2 kimlikleri önceki H/S/D/E/J veya senaryo kimliklerini yeniden numaralandırmaz.

| M2-ID | Primary kaynak / blob | Yürütme sınırı |
|---|---|---|
| M2-S01 | tools/memory_tool_store.py — 457594444311af31c837dcdd74cd1c55f2b47b3c | FULL exact modül/N koşusu; utils writer ve scanner taklit. Önceki D16 statik kaydından ayrı. |
| M2-S02 | tools/memory_tool.py — 8028ffd88a91b1625e1f1cebe500c37c6e6842a7 | FULL exact modül/N koşusu; home/config/registry taklit. Önceki D15. |
| M2-S03 | hermes_cli/write_approval_commands.py — 150b72dfd17696ab7a64f97057b7405128f5b352 | FULL exact shared command, supplied fixture store; actual CLI/gateway caller değil. Önceki H08/S05/D17. |
| M2-S04 | tools/write_approval.py — f1e99b46e934595c002c2bc659143fcbc1f9fe8d | FULL exact arşiv modülü, gate/stage/list/apply cleanup; home/config/callback taklit. Yeni upstream sürümü değil. |
| M2-S05 | tools/skill_provenance.py — 3df9cf143045644310fa7d27a65666c8c23caf95 | FULL exact ContextVar modülü; record origin ve writer current origin ayrı. |
| M2-S06 | LICENSE — 75410e73319c72cd3e991a501c5455eb78f38375 | Aynı MIT kaynak lisansı korunur. |

**Koşu:** UTC `2026-09-09T08:10:46.824877+00:00`–`2026-09-09T08:10:46.849596+00:00`, Python 3.13.5/Linux. [SPEC](evidence/2026-09-09-memory-pending/SPEC.md), [probe](evidence/2026-09-09-memory-pending/probe.py), [kaynak kimlikleri](evidence/2026-09-09-memory-pending/SOURCE-IDENTITY.json), [stdout](evidence/2026-09-09-memory-pending/stdout.txt), [stderr](evidence/2026-09-09-memory-pending/stderr.txt). Source-informed, same-researcher keşifsel koşu; SPEC ilk koşudan önce yazılmıştır. On iki tanılayıcı beklenti ve gerçek pre-import hash guard bozma reddi kayıtlı; ürün PASS değildir.

Pre-commit writer failure disk/live/snapshot ayrımı; alias pre-scan ve explicit load-time masking; shared pending stage/apply/failure/cleanup sınırları yürütüldü. Gerçek dosyalar geçici fixture içinde; Linux fcntl dalı gerçek olsa da N06 sıralı stale-store örneği. N10 supplied-store flag, N11 add idempotence örneğidir. Actual threat scanner, utils.atomic_write_text, gerçek profil/config refresh/UI/request/yarış davranışı doğrulanmadı.

**Ayrı statik M2-R01–R05:** background_review, run_agent forwarding, agent_init/_load_tools, executor bridge/scope ve cli_commands_mixin imports/helpers. Kesin aralık/truncation sınırları M2 defterinde; gerçek CLI pending callsite'ına ulaşıldığı iddia edilmez. Moving-branch search navigasyondu; primary pin yerine kullanılmadı. Bu kaynak notu J çalışmasının bağımsız tekrarı değildir; 22-range AST veya middleware koşusunu ikame etmez.

**Bu yayın:** [PUBLICATION](evidence/2026-09-09-memory-pending/PUBLICATION.md), [TRANSFER-CHECK](evidence/2026-09-09-memory-pending/TRANSFER-CHECK.json). Teslimin 20 manifest girdisi byte/SHA-256/Git blob ile doğrulandı; manifest dahil 21 özgün dosya korunur. 18 özgün evidence dosyasının hesaplanan ve geri okunan Git tree kimliği `8fd2e95ccbdecf60f00b6342464a042952a346c6`. Ek üç özgün dosya evidence/delivery altında tarihsel yollarıyla saklanır; current not 11'dir. Yeni yayın metadata'sı özgün manifest dışındadır. Hiçbir eski deney, tam-original verifier veya current upstream kontrolü yeniden yapılmadı. Hazırlık tabanı c0ef2374... içindeki D3 ve plan v0.8 korunarak v0.9'a ilerlenir.

## Güncel açık kapsam

Tam E01/E02 fidelity ve gerçek review/ordinary dispatch/PluginManager/Relay entegrasyonu ileri doğrulama olarak açık. İlk aktif kaynak işi actual pending CLI/gateway/onaylayan/profil/store; sonra gerçek prompt/request readback, curator nested batch/report, ledger/backup/restore/sync, cancellation/shared-store, search/archive ve F01–F12 kalan alanlar. M01/M02 bounded N kanıtı artık kayıttadır; onları NOT RUN sayıp başa dönme. Sıra gerekçesi v0.9 plan, 10 §8 ve M2 yayın kaydındadır. Current upstream ve kurulu release doğrulanmadı; eski notlar/deneyler korunur ve bütün sonuçlar tek ürün PASS sayısına çevrilmez.
