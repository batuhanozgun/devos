# ECC — Execution profile ve harness tüketicisi kullanımları

2026-09-20 · **B6-T17-C5c / U12-A CONTEXTUAL TRANSFER / C5c-PARTIAL**.

Bu dosya Note24/U12-A araştırmasındaki kullanımları kendi bağlamında kaydeder. Genel harness/permission sözlüğü, yeni host testi veya ortak mimari kararı değildir. EP öneki yalnız kullanım adresidir. [READING.md](READING.md) gerçek okumayı ve devamı, [TERMS.md](TERMS.md) kullanım girişini, [global STATE](../../STATE.md) güncel işi taşır. Dosyanın varlığı tek başına yayın kapanışı değildir.

## 1. Sabit kaynak ve atıf rolleri

Research repository snapshot: **batuhanozgun/agentic-os-search@df7b81a8f0bdb045d7307e63fdf306d0eaf9e843**. Araştırmanın ayrı upstream pin'i **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Aşağıdaki dört araştırma dosyası tam okundu. İçlerindeki upstream kod, test ve host dokümanı atıfları bu Concepts turunda yeniden okunmuş veya çalıştırılmış sayılmaz.

| Anahtar | Kaynak | Git blob |
|---|---|---|
| N24 | [Note24](../../../research/studies/ecc/notes/24-EXECUTION-PROFILES-AND-HARNESS-CONSUMERS.md) | 2d228fca57f5fcdc8bbbce955fcde4a4a03b42f9 |
| LA | [U12-A source ledger](../../../research/studies/ecc/evidence/U12-A-SOURCES.md) | befcad04dfc6f00d2210b0f9c67a43239b6925ce |
| MA | [ROUND-U12-A / MR25](../../../research/studies/ecc/ROUND-U12-A.md) | baca22dc3226d07f42e7a50bd4a4dd15e7669ee2 |
| PA | [PUBLICATION-U12-A](../../../research/studies/ecc/PUBLICATION-U12-A.md) | 0d53d1a221414ee75ee8405c44870fbb71f93abf |

Göreli bağlantılar current dosyayı açar; exact içerik yukarıdaki snapshot'ta aynı yol ve blob ile bağlanır. LA'nın U12A-M/S/T/CFG/R/UI/C/TEST kimlikleri manager, store, session tipleri/seçim, config, runtime, TUI, CLI ve command-test kaynaklarıdır. Bu kimlikler özgün araştırmanın locator'larıdır; yeni Concepts upstream keşfi değildir.

**Roller:** K = araştırmacının pinned koddan raporladığı kullanım/predicate; Y = araştırmacının açıklaması, ayrımı veya koşullu karşı-örneği; T = araştırmada incelenmiş fakat çalıştırılmamış test tasarımı; H = araştırmada **2026-09-19** tarihinde aktarılan dış host/process sözleşmesi. Türkçe açıklamalar yeni extractor paraphrase'idir. Dated host açıklaması güncel kurulu sürüm doğrulaması değildir. Daha güçlü güvenceyi anlatan Y kaydı implemented ECC alanı veya benimsenmiş SOUL gereksinimi sayılmaz.

## 2. Yapılandırma, çözülmüş profil ve yürütme kimliği

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP01 — execution profile | Model, araç/izin, dizin, bütçe ve ek prompt gibi tercihleri yeniden kullanılabilir biçimde taşıyan ortak yapı. Aynı field shape, bütün harness'larda aynı anlam veya enforcement sağlamaz. | N24 §1; LA selection/storage / K/Y |
| ECC-EP02 — effective profile selection | Normal creation'da explicit, inherited-name veya global-default profile çözümleme. Template'in farklı default kuralları TL27–TL35'te korunur; tek evrensel selection yolu ilan edilmez. | N24 §1; LA M/CFG / K/Y |
| ECC-EP03 — scalar override | Profil inheritance sırasında child scalar değerlerinin parent karşılıklarını değiştirebilmesi. Listelerin birleşmesi veya host policy precedence ile aynı işlem değildir. | N24 §1; LA CFG / K |
| ECC-EP04 — merge_unique / list composition | Profil listelerini tekrar eden girdiler olmadan birleştirme. Allow/deny çatışmasının her host'ta nasıl çözüleceğini belirleyen ortak izin kuralı değildir. | N24 §1; LA CFG / K/Y |
| ECC-EP05 — empty child list | Inheritance içinde boş child listesinin parent listesini silmemesi. Açık bir reset/erase işlemi veya ilerideki malformed-JSON fallback'i değildir. | N24 §1; LA CFG / K/Y |
| ECC-EP06 — appended prompt composition | Parent/child appended prompt metinlerinin birleştirilmesi. Sonradan native flag ile mi task text içinde mi taşınacağı ayrı consumer seçimidir. | N24 §1; LA CFG / K/Y |
| ECC-EP07 — profile.agent | Queue'nun mevcutsa effective session harness'ını seçmek için kullandığı profil değeri. Seçilmiş model veya kurulu executable'ın sürüm kimliği değildir. | N24 §1; LA M / K/Y |
| ECC-EP08 — stored session harness | Effective harness seçiminin session record'da saklanması. Ayrı profile object içinde aynı değerin tekrar bulunması gerekmez; executable bytes/policy identity değildir. | N24 §1; LA selection/storage / K/Y |
| ECC-EP09 — get_session_profile / agent=None | Diğer resolved alanları okuyan profile reader'ın agent=None döndürmesi; effective harness zaten session'da ayrı saklanır. Bu None tek başına seçim kaybı diye yorumlanmaz. | N24 §1; LA S / K/Y |
| ECC-EP10 — worker startup profile read | Worker başlangıcında saklanmış session profile'ının okunması. Yalnız named config entry'ye bakıldığı veya her alanın host tarafından uygulanacağı sonucu çıkmaz. | N24 §1; LA M/S / K/Y |
| ECC-EP11 — loaded Config | Program ve adapter seçiminde kullanılmaya devam eden yapılandırma. Stored profile ile aynı snapshot veya immutable executable binding değildir. | N24 §1; LA M/CFG / K/Y |
| ECC-EP12 — execution identity | Executable, host version, çevre config'i, environment ve pluginler bakımından daha güçlü eşlik sorusu. Stored profile bu bütünü dondurmuş sayılmaz; yeni bir implemented identity field'i değildir. | N24 §1, §7; LA selection/correspondence / Y |

## 3. Built-in tarifler ve native/text aktarım

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP13 — built-in command recipe | ECC builder'ın belirli harness için ürettiği argv ve task aktarım tarifi. Gerçek host'un o sürüm/değerleri kabul ettiği veya policy'nin etkili olduğu kanıtı değildir. | N24 §2; LA native translation / K/Y |
| ECC-EP14 — Claude built-in path | Model, allowed/disallowed tool rules, permission mode, ek dizinler, dolar bütçesi ve appended system prompt'u native seçeneklerle ileten print-mode yolu. token_budget bu dalda argv'ye veya task projection'a eklenmez; ayrı ECC tüketicisi EP44/EP47'dir. | N24 §2, §5; LA M/TEST / K/Y |
| ECC-EP15 — Codex built-in path | exec, workspace-write, çalışma dizini ve no-color tarifi; model/ek dizinler native aktarılır. Araç listeleri, permission mode, bütçeler ve appended prompt task string bölümleridir; bütün alanlar native policy değildir. | N24 §2; LA M/TEST / K/Y |
| ECC-EP16 — OpenCode built-in path | run/directory/title tarifiyle model native aktarılır; diğer mevcut profil alanları task text'e taşınır. Bu Rust komut tarifi generated plugin/discovery/event ailesinin araştırması değildir. | N24 §2, §8; LA native translation/next / K/Y |
| ECC-EP17 — Gemini built-in path | Prompt-mode tarifiyle model ve comma-joined include-directories native aktarılır; araç/izin/bütçe/ek prompt task text olur. Native izin mekanizmalarının host'ta bulunmadığı sonucu çıkmaz. | N24 §2–3; LA native translation / K/Y |
| ECC-EP18 — native argument emission | Bir profil değerinin command option olarak üretilmesi. Kurulu binary'nin parse/compatibility kabulü veya bütün policy katmanlarının sonucu değildir. | N24 §2; LA native translation / K/Y |
| ECC-EP19 — unsupported-field task projection | Native eşlemesi bulunmayan alanların intent kaybolmasın diye görev metnine aktarılması. Yararlı bir metinsel aktarım olabilir; native permission control veya ölçülmüş prompt obedience değildir. | N24 §2; LA M/TEST / K/Y |
| ECC-EP20 — task-renderer headings | System instructions ve ECC execution profile gibi başlıkların task argument içinde karakterler olarak bulunması. Başlık adı ayrı host system-prompt kanalı veya permission configuration yaratmaz; iki örnek başlık eş anlamlı kavram ilan edilmez. | N24 §2; LA native translation / K/Y |

## 4. Permission ve directory alanlarının tüketiciye bağlı anlamı

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP21 — allowed-tools preapproval | Araştırmanın tarihli Claude dokümanında araç kullanımı için ön-izin anlamı. Exclusive tool inventory değildir; ECC'nin bu alanı üretmesi diğer bütün araçların kaldırıldığını göstermez. | N24 §3; LA W-U12A-CLAUDE / H/K/Y |
| ECC-EP22 — tools availability option | Aynı dokümanda araç kullanılabilirliğini belirleyen ayrı tools seçeneği; incelenen ECC Claude dalı bunu üretmiyor. EP21'in başka adı veya bu tur kurulu host testi değildir. | N24 §3; LA W-U12A-CLAUDE/M / H/K |
| ECC-EP23 — disallowed-tools native control | Claude yolunda üretilen ayrı deny kuralı. Allowed-tools'un inventory olmaması bu kontrolün yokluğu değildir; başka harness'ta aynı profil listesi text olabilir. | N24 §2–3; LA M/W-U12A-CLAUDE / K/H/Y |
| ECC-EP24 — native permission-mode delivery | Claude yolunda profil permission mode değerinin native option'a geçirilmesi. Değerin iletilmesi bütün host policy katmanlarının doğrulandığı anlamına gelmez. | N24 §2–3; LA M/W-U12A-CLAUDE / K/H/Y |
| ECC-EP25 — Permission mode: plan text | Codex yolunda plan değerinin task metnine yazılması. Built-in sandbox seçimini read-only yapmıyor; modelin talimata uyması veya dış policy ayrı olasılıklardır. | N24 §3; LA M/W-U12A-CODEX / K/H/Y |
| ECC-EP26 — workspace-write recipe | Pinned Codex builder'ın sabit sandbox seçimi. Tarihli host dokümanındaki read-only seçimiyle aynı değildir; EP25'in yanında bulunması canlı yazma eylemi gözlemi sayılmaz. | N24 §2–3; LA native semantics / K/H/Y |
| ECC-EP27 — native add-dir | Tarihli Codex sözleşmesinde ana workspace yanında writable directories'i genişleten seçenek. Sadece context metadatası veya ek bağlam cümlesi olarak okunmaz. | N24 §3; LA W-U12A-CODEX / H/K/Y |
| ECC-EP28 — Additional context dirs text | Fallback renderer'ın dizinleri doğal dil içinde taşıması. Aynı path'in native erişim seçeneği olarak verilmesiyle aynı işlem veya yetki etkisi değildir. | N24 §3; LA native translation/semantics / K/Y |
| ECC-EP29 — OpenCode permission configuration | Araştırmanın tarihli OpenCode native permission configuration atfı; allow/ask/deny anlamlarıyla ayrı host kontrol yüzeyi. ECC adapter'ındaki eksik aktarım bu host kontrolünün yokluğu değildir; Gemini yüzeyi EP84'tedir. | N24 §3; LA W-U12A-OPENCODE / H/Y |

## 5. Configured runner ve eşleme sözleşmesi

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP30 — harness_runners | Program seçimi ve command construction'da built-in dallardan önce bakılan configured eşleme alanı. Aynı known harness key'i olsa da configured yol seçilebilir. | N24 §4; LA configured replacement / K |
| ECC-EP31 — configured recipe replacement | Configured entry'nin native tarifi genişletmek yerine tamamen değiştirmesi. Yalnız executable replacement veya önceki sandbox argümanlarını otomatik devralma değildir. | N24 §4; LA M/CFG / K/Y |
| ECC-EP32 — unknown-harness extension | Configured entry sayesinde unknown harness için program/komut sağlanabilmesi. Gerçek bir extension point'tir; executable readiness veya capability negotiation değildir. | N24 §4; LA M/T / K/Y |
| ECC-EP33 — program | Configured runner'ın çalıştırılacak program girdisi. program=codex seçmek tek başına built-in command recipe veya onun sandbox argümanlarını devralmaz; ayrı başlangıç argümanları EP83'tedir. | N24 §4; LA configured replacement / K/Y |
| ECC-EP34 — mapping-presence support | Optional field flag ayarının mevcut olmasından support çıkarılması. Executable'ın o seçeneği desteklediğini sorgulama veya version negotiation değildir. | N24 §4; LA configured replacement / K/Y |
| ECC-EP35 — absent-flag fallback | Native flag eşlemesi yoksa desteklenmeyen alanın task text'te korunması. Alanı doğrudan düşürmek veya native enforcement sağlamak değildir. | N24 §4; LA M/TEST / K/Y |
| ECC-EP36 — incorrect or empty-but-present flag | Flag mevcut sayıldığı için text fallback'i bastırıp geçersiz veya farklı yorumlanmış argv oluşturabilen girdi. Host reddedebilir; sessiz kabul veya privilege escalation varsayılmaz. | N24 §4; LA configured replacement / Y/K, koşullu |
| ECC-EP37 — append_system_prompt_flag | Configured runner'ın appended prompt için native flag iletim ayarı. Varsayılan inline davranışıyla beraber aynı metin iki yerde bulunabilir. | N24 §4; LA M/CFG / K |
| ECC-EP38 — inline_system_prompt_for_task | Default true olduğunda appended prompt'u task text'e de ekleyen seçenek. Native flag varsa çift aktarım oluşabilir; ismi bütün inline yolları tek başına kapatma güvencesi değildir. | N24 §4; LA configured replacement / K/Y |
| ECC-EP39 — native append plus inline=false | Native append flag yapılandırılmışken inline=false ile task içindeki bu tekrarın önlenmesi. Native kanalın gerçekten host tarafından kabulü ayrıca doğrulanmamıştır. | N24 §4; LA M / K/Y |
| ECC-EP40 — no append flag plus inline=false | Native append flag yoksa inline=false olsa da metinsel fallback'in prompt'u koruması. EP39 ile aynı dal değildir; evrensel disable-inline olarak okunmaz. | N24 §4; LA M / K/Y |
| ECC-EP41 — separate argv construction | Builder'ın argümanları shell string interpolation yerine ayrı vermesi. Bir shell yorumlama sınıfını bu sınırda önler; configured program'ın kendi komut yorumunu veya sandbox'ı denetlemez. | N24 §4; LA M; W-U12A-PROCESS / K/H/Y |
| ECC-EP42 — trusted adapter boundary | Operatörün configured mapping'ine bırakılan executable/flag tercihleri. Sandbox veya otomatik capability doğrulama hizmeti değildir; kötü niyetli operatör öncülü kurulmaz. | N24 §4; LA configured replacement / Y |

## 6. Bütçe alanları, gerçek caller ve örneklenmiş denetim

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP43 — profile.max_budget_usd | Claude native print-mode budget seçeneğine; diğer built-in'lerde task text'e aktarılabilen profil dolar sınırı. Configured runner native mapping verebilir; ECC enforcer bu per-profile USD alanını karşılaştırmıyor. | N24 §5; LA budgets / K/H/Y |
| ECC-EP44 — profile.token_budget | Session profile'ında saklanan ve ayrı ECC enforcer'ın recorded usage ile karşılaştırdığı token sınırı. Native token flag yokluğundan evrensel olarak kullanılmadığı sonucu çıkmaz. | N24 §2, §5; LA budgets / K/Y |
| ECC-EP45 — aggregate global token limit | Config'teki aggregate token sınırının ECC tarafında kontrolü. Tek profile ait token bütçesi veya provider ön-harcama izni değildir. | N24 §5; LA M / K/Y |
| ECC-EP46 — aggregate global USD limit | Config'teki toplam maliyet sınırının ayrı kontrolü. Her profile.max_budget_usd için uygulanmış bireysel tavanın yerine geçmez. | N24 §5; LA budgets / K/Y |
| ECC-EP47 — enforce_budget_hard_limits | Recorded global token/USD ve per-session profile token değerlerini kontrol edip seçilmiş session'lar için stop çağıran gerçek consumer. Adındaki hard_limits atomik pre-spend kontrolü veya kanıtlanmış termination deadline'ı değildir. | N24 §5; LA M/UI/C / K/Y |
| ECC-EP48 — recorded usage | Enforcer'ın gördüğü, metriklerde temsil edilmiş kullanım. Sağlayıcıdaki bütün gerçek harcama veya güncel/tam billing görünümü kendiliğinden değildir. | N24 §5; LA budgets / K/Y |
| ECC-EP49 — runtime metric import | Değişmiş metric dosyalarını okuyup denetimin tükettiği kaydı güncelleme. Metric completeness, her harcamanın yakalanması veya bağımsız ölçüm doğrulanmış değildir. | N24 §5; LA UI/C / K/Y |
| ECC-EP50 — TUI tick consumer chain | app → dashboard.tick → sync_from_store → sync_runtime_metrics → import/enforcer yolu. Gerçek çağrı zinciridir; yalnız tanımlanmış ama hiç tüketilmeyen budget alanı diye anlatılmaz. | N24 §5; LA UI / K |
| ECC-EP51 — CLI metric-refresh consumer | sync_runtime_session_metrics'in metrics import sonrası ilgili denetimleri çağırması. Runtime output loop'uyla aynı sürekli gözetim yolu veya bütün CLI işlemlerinin özelliği değildir. | N24 §5; LA C / K/Y |
| ECC-EP52 — selected pause states | Eşik için stop hedefi olarak Pending, Running ve Idle kayıtlarının seçilmesi. Yalnız o anda çalışan process listesi veya bütün session state'leri değildir. | N24 §5; LA M / K/Y |
| ECC-EP53 — worktree-preserving stop | Bütçe denetiminin worktree'yi koruyan stop yolunu çağırması. İstenen durdurma, bütün process tree'nin sonlandığı receipt veya işin kabulü değildir; önceki lifecycle sınırları korunur. | N24 §5; LA M/R / K/Y |
| ECC-EP54 — sampled usage control | Kullanım kayda geçtikten ve caller denetimi çağırdıktan sonra threshold kontrolü. Provider-side atomic pre-spend authorization'dan ayrıdır; overshoot miktarı bu araştırmada ölçülmedi. | N24 §5; LA budgets / Y/K |
| ECC-EP55 — tick-skipping interaction modes | TUI etkileşim dallarının tick'i atlayabilmesi. Event-poll interval bu nedenle garantili budget enforcement deadline değildir. | N24 §5; LA UI / K/Y |
| ECC-EP56 — global-total population | Store'un döndürdüğü session'lardan oluşturulan toplamların kontrol paydası. Yeni tanımlanmış bir billing window veya bütün provider muhasebesi diye genişletilmez. | N24 §5; LA M / K/Y |
| ECC-EP57 — zero threshold | İlgili eşik sıfır olduğunda o kontrolün disabled oluşu. Sıfır harcamaya izin veren enforce edilmiş tavan diye okunmaz. | N24 §5; LA budgets / K/Y |
| ECC-EP58 — Stale exclusion | Stale durumunun bu enforcer'ın pause için seçtiği state'ler dışında kalması. Template kapasite hesabının Stale'i saymasıyla çelişki değildir; farklı consumer nüfuslarıdır. | N24 §5; LA M; TL37 / K/Y |
| ECC-EP59 — budget-control coverage | Çağrının yapılması, usable/current recorded usage, seçilmiş state ve gerçek termination bağımlılıkları. Gerçek consumer'ın varlığı bu koşulların her deployment'ta sağlandığını doğrulamaz. | N24 §5, §8; LA budgets/residuals / Y |

## 7. Saklanan listeler ve sessiz boş değer dönüşümü

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP60 — profile-list serialization | Normal writer'ın allow/deny/directory vektörlerini geçerli JSON olarak saklaması. Malformed-list karşı-örneği normal writer'ın bozuk JSON ürettiği iddiası değildir. | N24 §6; LA S / K/Y |
| ECC-EP61 — unwrap_or_default decoding | Reader'ın ilgili JSON listesi çözülemezse default empty vector kullanması. Başarılı profile object dönüşü, bütün restriction alanlarının sağlam geri kazanılması değildir. | N24 §6; LA S / K/Y |
| ECC-EP62 — malformed deny-list counterpart | Bozuk stored deny JSON → boş deny listesiyle okunabilen profil → deny flag/directive omission zinciri. Malformed veri gerektirir; corruption/migration/exploit bu tur çalıştırılmadı. | N24 §6; LA failure/correspondence / Y/K, koşullu |
| ECC-EP63 — decoded-empty versus explicit-empty | Hata fallback'iyle boşalan liste ile gerçekten boş kaydedilmiş listenin aynı sonuç vektörüne dönüşmesi. İki köken aynı izin niyeti veya aynı okuma başarısı değildir. | N24 §6, §8; LA S/M / Y |
| ECC-EP64 — empty-vector omission | Builder'ın boş liste için ilgili native flag veya text directive üretmemesi. Bu olağan builder kuralı malformed reader çıktısını da tüketebilir; kendiliğinden intentional permission change değildir. | N24 §6; LA S/M / K/Y |
| ECC-EP65 — name validation versus stored-list decoding | Geçersiz named profile'ın reddi ile bozuk serialized listenin boş dönüşü farklı failure sınıfları. Birinin refusal davranışı diğerine taşınmaz. | N24 §6; LA failure/correspondence / Y/K |

## 8. Environment etiketleri ve capability keşfi

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP66 — shared environment labels | Session/harness/directory/package-manager/plugin-root bilgisini cooperating bileşenlere taşıyan environment değerleri. Tek başına authenticated execution identity değildir. | N24 §7; LA M / K/Y |
| ECC-EP67 — configured runner.env override | Shared environment'dan sonra uygulanan configured eşlemelerin önceki değerleri değiştirebilmesi. Metadatanın protected identity invariant olduğu varsayılmaz. | N24 §7; LA failure/correspondence / K/Y |
| ECC-EP68 — explicit runtime session_id | Runtime DB writer'ın environment label'dan ayrı explicit session_id argümanına dayanması. Runner.env etiketi değişti diye runtime'ın aynı yeni label'a yazdığı sonucu çıkmaz. | N24 §7; LA R/M / K/Y |
| ECC-EP69 — correlation-label divergence | Configured environment etiketi ile runtime kayıt hedefinin ayrışabilmesi. Operator-controlled karşılıktır; saldırı veya gözlenmiş telemetry mix-up değildir. | N24 §7; LA failure/correspondence / Y/K |
| ECC-EP70 — inherited child environment | Builder'ın inherited environment'ı temizlememesi. Explicit map listesi bütün child environment'ın sanitize edildiğini göstermez; parent credentials bu araştırmada incelenmedi/kullanılmadı. | N24 §7; LA W-U12A-PROCESS/M / K/H/Y |
| ECC-EP71 — get_envs accessor | Command üzerinde explicit environment eşlemelerini inceleme yüzeyi. Parent'tan inherited bütün değerlerin dökümü veya gerçek child execution deneyi değildir. | N24 §7–8; LA PROCESS/TEST / H/T/Y |
| ECC-EP72 — marker-based auto harness selection | Repository marker path'leri ve configured-runner presence ile harness adayını seçme. Installation, version veya capability readiness testi değildir. | N24 §7; LA T / K/Y |
| ECC-EP73 — configured-runner presence | Auto-selection'ın başlatılabilir aday değerlendirmesinde kullanabildiği configuration varlığı. Geçerli program, doğru flag veya başarılı spawn kanıtı değildir. | N24 §7; LA T / K/Y |
| ECC-EP74 — program-selection refusal | Daha sonraki program seçiminde empty configured program veya unsupported native type'ın reddedilmesi. Önceki marker detection'dan ayrı kontroldür; geçmesi process creation başarısını garanti etmez. | N24 §7; LA M/T / K/Y |
| ECC-EP75 — plugin-root discovery | Executable/compile-time-path ancestor'larında iki marker file arayıp bulunduğunda path export etme. İçerik/sürüm doğrulaması, plugin activation veya worker'ın bütün hook'ları tüketmesi değildir. | N24 §7; LA M / K/Y |
| ECC-EP76 — CLAUDE-prefixed compatibility variables | Uyum amacıyla exported Claude-prefixed environment etiketleri. Non-Claude executable'ı Claude host'a dönüştürmez veya o host'un permission sözleşmesini kazandırmaz. | N24 §7; LA M / K/Y |
| ECC-EP77 — active capability versus detected root | Bulunan directory/marker/runner ile gerçekten çalışıp seçilmiş entegrasyon arasındaki ayrım. Genel capability ontolojisi veya bütün custom-host consumer'larının yokluğu sonucu değildir. | N24 §7–8; LA selection/correspondence / Y |

## 9. Test ve dış sözleşme dili

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP78 — command representation tests | Command argv/env accessor'ları üzerinden beklenen native/configured temsilleri sınayan test kaynakları. Serialization regression yakalayabilir; gerçek host parser/policy/model/spend testi değildir. Araştırmada incelendi, koşulmadı. | N24 §8; LA TEST / T/Y |
| ECC-EP79 — Claude token-budget fixture | token_budget içerip native token flag beklemeyen command-test girdisi. Ayrı ECC token consumer'ının yokluğu veya canlı budget başarısı kanıtı değildir. | LA test oracles; MA evidence / T/Y |
| ECC-EP80 — Codex plan/deny fixture | workspace-write ile plan/deny text'in beraberliğini açıkça bekleyen command testi. Beklenti, read-only host enforcement oracle'ı değildir; çalıştırılmış host sonucu sayılmaz. | N24 §8; LA TEST; MA evidence / T/Y |
| ECC-EP81 — configured-runner mapping tests | Cursor/unknown program lookup, configured flag mapping ve unsupported-field projection'ı inceleyen test kapsamı. Bir host kurulumu veya bütün arbitrary mappings için conformance testi değildir; koşulmadı. | LA exact TEST/test oracles / T/Y |
| ECC-EP82 — dated host/process contract checks | Claude/Codex/OpenCode/Gemini ve Rust Command için araştırmanın 2026-09-19 tarihli sözleşme okumaları. Option anlamını sınırlar; installed binary, exact build, güncel ürün sertifikası veya Concepts'in yeni web araştırması değildir. | LA dated primary contracts; PA standing / H/Y |

## 10. Kaynak tarafından kapsam kontrolü

N24 §1 → EP01–EP12; §2 → EP13–EP20/EP43–EP44; §3 → EP21–EP29/EP84; §4 → EP30–EP42/EP83; §5 → EP43–EP59; §6 → EP60–EP65; §7 → EP66–EP77; §8 → EP78–EP82 ve aşağıdaki ilişki/açık sınırlar. LA'nın table/producer-consumer/dış sözleşme/test/retrieval kapsamı ayrıca okundu. Özellikle command fixture'larının gerçek host çağrısı olmadığı, TUI/CLI consumer'larının gerçekten bulunduğu ve test arama eksiklerinin yokluk kanıtı olmadığı korundu.

Kayıtlar doğal dilde geçen her sözcüğe tanım üretmez. Print/exec/run/prompt-mode, no-color/title, directory/package-manager etiketleri ve Cursor örneği ilgili recipe/discovery/test bağlamlarında korunur; bağımsız ürün sözlüğüne çevrilmez. Marker file adları, field spelling'leri veya genel izin öncelikleri kaynakta açıklanmayan ayrıntılarla doldurulmadı. OpenCode ve Gemini'nin farklı kontrol yüzeyleri EP29/EP84; runner'ın program ve başlangıç argüman girdileri EP33/EP83 ile ayrı adreslenir.

MA'nın yöntem seçimi, LA'nın önceki kaynak kapsamı ve PA'nın yayın karşılığı aynı iddiaya bağımsız destekler değildir. PA'da ilk catalogue adayının scope-clean oluşu o tarihsel yayın sonucudur; önceki text-emission hatalarının evrensel çözümü veya bu turun yayın başarısı diye aktarılmaz. Eski concurrent Concepts değişiklikleri bugünkü kaynak araştırma yetkisi değildir. Bu unit yeni deney içermiyor; E08/E07 veya sonraki Python E09 burada host/profile deneyi sayılmaz.

## 11. İlişkiler ve maddi yorum sınırları

Kaynağın ana zinciri **profile composition/selection (EP01–EP07) → session harness + stored profile (EP08–EP10) → loaded Config üzerinden native/configured recipe (EP11, EP13–EP42) → argv/env/task representation → actual host consumer** şeklindedir. Ayrı **metric import → ECC budget enforcer → stop** kolu EP43–EP59'dadır. Bu ayrım, bir field'in native argümana dönüşmemesinden hiçbir tüketicisinin olmadığı sonucuna atlamayı engeller; host acceptance/actual enforcement tamamlanmış sayılmaz.

**Önceki kayıtlara bağ:** TL27–TL35 seçimin caller'a bağlı sınırını taşır; EP01–EP12 profilin saklanması ve worker tarafından okunmasını ayrıntılandırır. TL35 artık U12-A'nın kaynak cevabına ulaşır; bu, açık Q02a2 host-enforcement sorusunun kapandığı anlamına gelmez. RD38–RD41 valid profile ile reused effective policy'yi ayırır; burada builder incelenmesi o reuse yoluna profil uygulaması eklemez.

TL37 template capacity hesabında Stale'i sayar; EP52/EP58 bütçe pause hedeflerinde onu dışarıda bırakır. Farklı consumer nüfusları aynı population gibi okunmaz. R88'in effectful observer işareti EP50'nin gerçek tick/enforcer zinciriyle ayrıntılanır; R71 heartbeat task progress'e veya budget deadline'a dönüşmez. R95/R96 stop/cleanup sınırı EP53'teki worktree-preserving stop için korunur. BC45'in history-based cooloff'u EP55'in tick-skipping interaction yolu değildir; benzer gecikme sözcükleri farklı nedenleri birleştirmez.

**İki karşı yönde aşırı yorum önlendi:** native token flag yok → token alanı her yerde etkisiz sonucuna gidilmedi; ayrı gerçek ECC consumer'ı kaydedildi. Enforcer var → her profilin dolar tavanı uygulanıyor sonucuna da gidilmedi; per-profile USD karşılaştırmasının bu consumer'da bulunmadığı korunur. Aynı şekilde get_session_profile agent=None, seçim kaybı değil ayrı session alanıyla birlikte okunur. Hata fallback'inden boş deny listesi, normal writer'ın oluşturduğu geçerli profil gibi genellenmez.

Bu tur önceki kullanım dosyalarını yeniden yazmayı gerektiren maddi çelişki saptanmadı. Yeni kaynak, önceki selection/enforcement işaretlerini kapsamları içinde ayrıntılandırır. Koşullu malformed-list, custom-flag ve environment-label karşılıkları gözlenmiş exploit veya gerçek yetkisiz aksiyon olarak sunulmadı. Metinsel intent korunması, native mapping, extension point, normal serialization, program refusal ve gerçek bütçe caller'ları olumlu mekanizmalar olarak görünür kalır.

### İlk source/readback kontrolü sonrası adresleme düzeltmesi

İlk yayın **f1dc83651f57fcdaff1074cd0339717624d58fdb**, EP29'da iki ayrı host'un izin yüzeyini, EP33'te program ve base_args girdilerini aynı kullanım adresinde taşıyordu. Metin farklarını açıklıyordu; fakat ayrı adresleri yoktu. N24 §3–4 ve LA'nın dated-contract/configured-replacement bölümleriyle karşılaştırıldı: EP29 OpenCode'a, EP33 program'a daraltıldı; EP84 Gemini, EP83 base_args olarak eklendi. §10'daki ortak olumsuz yükleme dayanan sıkıştırılmış cümle de açık adreslerle değiştirildi. EP16/EP17/EP30–EP36/EP74/EP81 ve kaynak eşlemesi kontrol edildi; bu kayıtların açıklamalarını değiştirmek gerekmedi. Önceki TERMS veya source-study değiştirilmedi. Bu, extractor kayıt düzeltmesidir; yeni host bulgusu değildir.

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-EP83 — base_args | Configured runner için başlangıç argümanları. program=codex ile [exec] verilmesi, ayrıca yazılmamış built-in sandbox seçeneğini devralmaz; program seçiminin kendisi EP33'tür. | N24 §4; LA configured replacement / K/Y |
| ECC-EP84 — Gemini approval-mode/policy surface | Araştırmanın tarihli Gemini approval-mode ve policy-engine atıfları. Host'un kendi kontrol yüzeyidir; ECC'nin text fallback'i bu policy'nin yüklenmesi veya uygulanması değildir. OpenCode configuration EP29'da ayrı tutulur. | N24 §3; LA W-U12A-GEMINI / H/Y |

## 12. Kapanış ve açık sınır

**ECC-EP01–EP84**, 84 adreslenebilir kullanım kaydıdır; bağımsız kavram, kanıt veya başarı yüzdesi değildir. U12-A'nın dört araştırma dosyasından bağlamlı aktarım yapıldı. Yayın/readback ve local/global current durum ayrı kapatılır; dosya tek başına C5c/C5/C6/ECC completion değildir.

Q02a2'nin installed binary/API/config/flag correspondence, effective host tools/policy, arbitrary aliases/mappings, parent environment ve plugin activation, malformed/migrated state, metric freshness/overshoot/Stale/termination, actual prompt obedience ve accepted output sınırları açık kalır. Bunlar yeni Concepts deney borcu veya benimsenmiş SOUL gereksinimi değildir. Yeni build/test/fixture, host/model/provider, credential, installation, live runtime veya upstream mutation yapılmadı. E06 excluded; önceki deneyler ve iki E05 geçmişi ayrı kapsamlarıyla korunur.

Batu okuma anındaki anlam seçimlerini denetleyemediği için önemli dayanak, yorum ve belirsizlik bu kayıtta izlenebilir tutulur. Ortak sözcükler ortak anlamı garanti etmez; kaynak kullanımı, araştırmacı yorumu, extractor açıklaması ve kullanıcı onayı birbirinin teknik doğrulaması değildir.

Sıradaki Concepts kaynak ailesi **C5c / U12-B1–B2 — generated OpenCode entry ve installation/loading/tool-result** kapsamıdır. Note25 ilk gövde okumasıdır; Note26 onu tamamlar. U12-C/Python, C6 ve B7/B8 bu dosyayla tamamlanmış sayılmaz.
