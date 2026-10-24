# ECC — OpenCode giriş, callback ve araç tüketicisi kullanımları

2026-09-21 · **B6-T17-C5c / U12-B1 CONTEXTUAL TRANSFER / C5c-PARTIAL**.

Bu dosya Note25/U12-B1 araştırmasındaki kullanımları kendi kaynak bağlamlarında taşır. Yeni OpenCode araştırması, build/host testi veya ortak kavram kabulü değildir. OC öneki yalnız kullanım adresidir. Gerçek okuma ve devam [READING.md](READING.md), kullanım girişi [TERMS.md](TERMS.md), güncel yetki [global STATE](../../STATE.md) içindedir.

## 1. Sabit kaynak ve roller

Research snapshot: **batuhanozgun/agentic-os-search@25c2e6615990c4ad9a8acdd508ae5a6acab95b5d**. Ayrı ECC research pin'i **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Aşağıdaki dört research dosyası bu tur tam okundu; içlerinde atfedilen upstream kod, host kaynakları, testler ve dokümanlar bu Concepts turunda yeniden okunmuş veya çalıştırılmış sayılmaz.

| Anahtar | Kaynak | Git blob |
|---|---|---|
| N25 | [Note25](../../../research/studies/ecc/notes/25-OPENCODE-CALLBACK-CONTRACTS-AND-GENERATED-ENTRY.md) | 2d2bed97f3189db10e5ac6665086c69e3d0f6367 |
| LB1 | [U12-B1 source ledger](../../../research/studies/ecc/evidence/U12-B1-SOURCES.md) | 377906978b712c37381ab91586cd6f1c99e292d3 |
| MB1 | [ROUND-U12-B / MR26](../../../research/studies/ecc/ROUND-U12-B.md) | ef7630af230b2117013d31f84df41feae87a8239 |
| PB1 | [PUBLICATION-U12-B1](../../../research/studies/ecc/PUBLICATION-U12-B1.md) | 744d87b284f3aa177bff67b76c12fb814ed0bd7b |

Göreli bağlantılar current dosyaya gider; exact içerik yukarıdaki snapshot ve blob ile bağlanır. LB1'in B1-* kimlikleri ECC kaynakları; H1-* kimlikleri **anomalyco/opencode@877be7e8e04142cd8fbebcb5e6c4b9617bf28cce / v1.4.3** karşılaştırması; W-B1-DOC ise araştırmanın 2026-09-19 tarihli doküman okumasıdır. İndeksin **07756cee15788a54506031462794ad645719b028** sürümü ayrıca sınırlı bir gözlemdir. Bu kimlikler aynı build/kurulum veya current latest diye birleştirilmez.

**Rol anahtarı:** K = araştırmacının pinned ECC kodundan raporladığı kullanım; V = seçilmiş versioned host kaynağından raporladığı sözleşme; B = hedef belge/yorum beyanı; Y = araştırmacının açıklaması veya koşullu çıkarımı; T = incelenmiş, çalıştırılmamış test tasarımı; H = tarihli dış doküman atfı. Türkçe metinler extractor paraphrase'idir; kaynak rolü teknik doğruluk sertifikası değildir. Aynı note/ledger/round/receipt bağımsız dört kanıt sayılmaz.

N25'in U12-B PARTIAL ifadesi **B1'in tarihsel source checkpoint'i** içindir. Güncel source-study Notes25–26 ile B2'yi de yayımlamıştır; bu Concepts turu yalnız B1'i aktarır. B2 gövdesi burada okunmuş sayılmaz ve araştırmanın eski next-work metni yeni source-study yetkisi yaratmaz.

## 2. Giriş, paketleme ve ayrı sürüm bağlamları

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC01 — executable TypeScript adaptation | OpenCode uyarlamasının çalıştırılabilir plugin/tool kodu olması. Yalnız kopyalanmış prosedür değildir; kaynakta bulunması kurulu host'ta çalıştığını göstermez. | N25 §1; LB1 ENTRY/HOOKS / K/Y |
| ECC-OC02 — nested package main | İç paketin generated dist girişine yönelen main alanı. Loader'ın o yolu gerçekten seçtiği veya published bytes'ın mevcut olduğu kanıtı değildir. | N25 §1; LB1 PACKAGE / K |
| ECC-OC03 — nested package exports | İç paketin export çözümleme eşlemesi. main alanından ayrı package-resolution yüzeyidir; explicit-file import testi bare package çözümlemesini doğrulamaz. | N25 §1, §7; LB1 PACKAGE/BUILDTEST / K/Y |
| ECC-OC04 — NodeNext compiler configuration | Entry/plugins/tools kaynaklarını NodeNext/ES2022 JavaScript, declarations ve source maps çıktısına bağlayan derleyici yapılandırması. Bu tur derleme yapıldığı veya host arayüzüne uyulduğu sonucu değildir. | N25 §1; LB1 TSC / K/Y |
| ECC-OC05 — generated dist payload | Derleme yolunun hedeflediği üretilmiş dosyalar. Authored TS, paketlenmiş artefakt ve yüklenmiş runtime ile aynı nesne değildir; bytes bu tur üretilmedi. | N25 §1, §7; LB1 BUILD/PACKAGE / K/Y |
| ECC-OC06 — plugin-only default entry | Nested entry'nin yalnız plugin fonksiyonunu dışa vermesi. Export tarayan loader'ın tool tanımlarını plugin sanmasını önleyen tasarım tercihi; bütün katalogun kurulması değildir. | N25 §1; LB1 ENTRY / K/B/Y |
| ECC-OC07 — plugin barrel | Hook plugin'ini yeniden dışa veren ara modül. Event/callback biçimlerini host sözleşmesine çeviren compatibility wrapper değildir. | N25 §3; LB1 BARREL / K/Y |
| ECC-OC08 — enabling the plugin | Plugin'i etkinleştirme yolu. Geniş command/agent/instruction katalogunun ayrıca kurulmasıyla aynı teslimat değildir. | N25 §1; LB1 README/ENTRY / B/K |
| ECC-OC09 — wider catalog installation | Komut, agent ve yönerge malzemelerinin ayrı dosya/config yollarıyla sağlanması. Plugin entry'nin yüklenmiş olması katalogun tümünü kurmuş sayılmaz. | N25 §1; LB1 README / B/Y |
| ECC-OC10 — plugin tool map | Plugin dönüşündeki changed-files ve dependency-analyzer kayıtları. Genel README listesi veya top-level module exports ile aynı registration yüzeyi değildir. | N25 §1, §6; LB1 HOOKS / K |
| ECC-OC11 — dependency-analyzer registration | Bu checkpoint'te plugin map içinde görülen ikinci tool kaydı. Implementation/consumer ayrıntısı burada kapanmış değildir; adı kaynakta var diye gövde bilgisi eklenmez. | N25 §1; LB1 HOOKS / K, kayıt düzeyi |
| ECC-OC12 — compaction catalog text | Compaction dizgesinde araç/prosedür adlarının listelenmesi. Metinsel liste, tool registration veya host'un o context'i tüketmesi değildir. | N25 §1–2; LB1 README/HOOKS / B/K/Y |
| ECC-OC13 — root prepack | Root paketleme hazırlığının scripts/build-opencode.js çağrısı. Nested package scriptleriyle aynı build ortamı varsayılmaz; npm pack bu tur çalışmadı. | N25 §1; LB1 ROOT/BUILD / K |
| ECC-OC14 — root TypeScript resolution | Root build helper'ın TypeScript'i root bağlamında bulması. Nested lock'taki compiler sürümünün bu yola otomatik uygulandığı gösterilmez. | N25 §1, §7; LB1 BUILD/ROOT/LOCK / K/Y |
| ECC-OC15 — nested build script | İç paketin kendi derleme girişidir. Root prepack yolu veya gerçek başarılı derleme kaydı değildir. | N25 §1; LB1 PACKAGE / K |
| ECC-OC16 — nested prepublishOnly | İç paketin yayın öncesi script girişidir. build scriptinden ayrı yaşam-döngüsü çağıranıdır; yayımlanmış artefakt kanıtı değildir. | N25 §1; LB1 PACKAGE / K |
| ECC-OC17 — root dependency declarations | Araştırmada root manifestten raporlanan plugin 1.18.25 / TypeScript 6.0.3 beyanları. Nested lock çözümlemesi veya test edilmiş kurulum değildir. | N25 §1; LB1 ROOT / K |
| ECC-OC18 — nested lock version labels | İç lock'taki plugin/SDK 1.4.3 ve TypeScript 5.9.3 kayıtları. Root beyanlarıyla tek environment yapılmaz; registry bytes veya installed host eşliği doğrulanmış değildir. | N25 §1–2; LB1 LOCK / K/Y |
| ECC-OC19 — versioned host comparator | Nested lock etiketi nedeniyle seçilen OpenCode v1.4.3 / 877be7e kaynak karşılaştırması. Current latest, indirilen registry paketi veya kullanıcının kurulumu olduğu söylenmez. | N25 §2; LB1 versioned consumer / V/Y |
| ECC-OC20 — indexed revision observation | 07756cee sürümünün root header'ında .opencode/dist/index.js main/exports bulunması. Ayrı dar gözlemdir; ECC pin'ine taşınmış düzeltme, repin veya current-release hükmü değildir. | N25 §7; LB1 discovery/freshness / K/Y |

## 3. Callback çağrısı, dönüş değeri ve mutable output

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC21 — host trigger loop | Handler'ı fn(input, output) ile çağırıp await eden, replacement dönüşünü kullanmadan supplied output'u döndüren versioned dispatcher. Tool execute wrapper'ının sözleşmesi değildir. | N25 §2; LB1 H1-DISPATCH / V |
| ECC-OC22 — callback input | Host'un callback'e ilk argüman olarak verdiği nesne. İkinci output nesnesinden ayrıdır; before/after için aynı args konumu varsayılmaz. | N25 §2, §4; LB1 H1-TYPES / V |
| ECC-OC23 — mutable callback output | Callback'in host'a etkisini taşıması için alanlarını değiştirdiği supplied ikinci nesne. Yeni nesne döndürmek bu nesneyi değiştirmiş sayılmaz. | N25 §2; LB1 H1-DISPATCH/TYPES / V/Y |
| ECC-OC24 — returned replacement object | ECC handler'ın kurup döndürdüğü env/context/approval nesnesi. Çağrı başarıyla bitse bile OC21 bu replacement'ı tüketmez; tüm host davranışı yok olmuş sayılmaz. | N25 §2; LB1 HOOKS/H1-DISPATCH / K/V/Y |
| ECC-OC25 — `Promise<void>` hook contract | Karşılaştırılan host arayüzünde ilgili handler'ların dönüş sözleşmesi. Local broad typing veya plugin factory'nin bütünüyle aynı imza değildir. | N25 §2, §5; LB1 H1-TYPES / V |
| ECC-OC26 — shell.env returned map | ECC shell.env handler'ının döndürdüğü environment map. Host'un supplied output.env alanına yazılmasıyla aynı işlem değildir. | N25 §2; LB1 HOOKS / K/Y |
| ECC-OC27 — output.env | Host'un başlangıçta env:{} olarak verdiği mutable alan. shell.env'den dönen bağımsız map otomatik olarak buraya birleşmez. | N25 §2; LB1 H1-DISPATCH/SHELL / V |
| ECC-OC28 — Bash shellEnv consumer | Trigger sonucu extra.env alanını environment'a birleştiren gerçek downstream consumer. ECC-specific eklerin gelmemesi default environment'ın yokluğu değildir. | N25 §2; LB1 H1-SHELL / V/Y |
| ECC-OC29 — returned compaction context | ECC'nin context:string içeren dönüş alanı. Host'un mutable context dizisine katkı yapılması değildir; bütün conversation context'inin kaybı iddia edilmez. | N25 §2; LB1 HOOKS/H1-COMPACT / K/V/Y |
| ECC-OC30 — compaction_prompt | ECC'nin döndürdüğü prompt alan adı. Host'un output.prompt alanıyla aynı adres veya tüketilmiş prompt değildir. | N25 §2; LB1 HOOKS / K/Y |
| ECC-OC31 — output.context | Versioned compaction caller'ının context:[] ile başlatıp prompt kurarken kullandığı mutable dizi. Returned context:string ile farklı şekil ve aktarım yoludur. | N25 §2; LB1 H1-COMPACT / V |
| ECC-OC32 — output.prompt | Host'un başlangıçta undefined verip compaction prompt üretiminde kullandığı alan. compaction_prompt adlı ayrı dönüş bu alanı değiştirmez. | N25 §2; LB1 H1-COMPACT / V/Y |
| ECC-OC33 — returned approval object | ECC permission.ask handler'ının approved/reason içeren dönüş nesnesi. Generic trigger üzerinden applied host permission decision değildir; permission bypass gözlemi de değildir. | N25 §2; LB1 HOOKS/H1-DISPATCH / K/V/Y |
| ECC-OC34 — permission output.status | Host sözleşmesindeki ask/deny/allow değerli mutable durum alanı. approved adlı dönüş alanı veya insan onayıyla eşitlenmez. | N25 §2; LB1 H1-TYPES / V |
| ECC-OC35 — permission invocation boundary | Uyumsuzluğun incelenen trigger üzerinden hook çağrılması koşuluna bağlı kapsamı. Her permission call-site veya current engine incelenmiş, canlı ret/aşım gözlenmiş değildir. | N25 §2; LB1 joined results/limits / Y |

## 4. Event aboneliği ve before/after alanları

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC36 — hook.event({event}) | Versioned bus'ın event için çağırdığı hook girişi. Event türlerinin plugin dönüşüne top-level fonksiyon adları olarak eklenmesinden farklı registration sözleşmesidir. | N25 §3; LB1 H1-DISPATCH / V |
| ECC-OC37 — event.type branch | Event callback içinde session.idle gibi türlere göre ayrım yapılan documented desen. Event adı tek başına abonelik oluşturmaz. | N25 §3; LB1 W-B1-DOC/H1-DISPATCH / H/V/Y |
| ECC-OC38 — top-level event-type keys | ECC'nin file.edited, session.created/idle/deleted, file.watcher.updated ve todo.updated fonksiyonlarını doğrudan döndürmesi. Bu adlar incelenen bus yolunda event aboneliği değildir. | N25 §3; LB1 HOOKS / K/V/Y |
| ECC-OC39 — event compatibility bridge | Top-level event fonksiyonlarını host'un event callback'ine çevirebilecek ara bağ. Takip edilen plugin/barrel bunu sağlamaz; tüm alternatif dağıtımlarda yokluk iddiası değildir. | N25 §3; LB1 BARREL/HOOKS / Y/K |
| ECC-OC40 — local hook-profile predicate | ECC'nin hook içinde çalışmayı seçen profil koşulu. Gerçek yerel kontrol olabilir; çağrılmayan handler'ı host'a kaydetmez. | N25 §3; LB1 HOOKS / K/Y |
| ECC-OC41 — disabled-hook predicate | Belirli hook davranışını devre dışı bırakan yerel kontrol. Registration ve delivery gereğini ortadan kaldırmaz; profile seçimiyle aynı alan ilan edilmez. | N25 §3; LB1 HOOKS / K/Y |
| ECC-OC42 — tool.execute.before input | Host'un before için tool/session/call kimliklerini verdiği input şekli. Args bu input'ta değildir; after input'unun kopyası sayılmaz. | N25 §4; LB1 H1-TYPES / V |
| ECC-OC43 — before output.args | Before sözleşmesinde tool argümanlarının bulunduğu ikinci nesne alanı. ECC'nin input.args okumasıyla farklı konumdur. | N25 §4; LB1 H1-TYPES/HOOKS / V/K |
| ECC-OC44 — optional local ToolInput.args | ECC'nin tek ToolInput parametresinde optional okuduğu args alanı. Contract-conforming before çağrısında eksik kalıp branches'i atlayabilir; bu bir açık contract error olmak zorunda değildir. | N25 §4; LB1 HOOKS / K/Y |
| ECC-OC45 — pending write classification | Before handler'ın hedefin önceden varlığını kaydetmeye çalıştığı ara durum. Args konumu uyuşmazsa bu kayıt oluşmayabilir; sonraki tracking'in tümünün yokluğu değildir. | N25 §4; LB1 HOOKS / K/Y, koşullu |
| ECC-OC46 — tool.execute.after input.args | Genuine after hook'ta ECC'nin okuduğu konumda verilen args. Post-edit/write tracking için olumlu bağdır; before uyumsuzluğu bu yolu otomatik geçersiz kılmaz. | N25 §3–4; LB1 HOOKS/H1-TYPES / K/V/Y |
| ECC-OC47 — modified fallback | Eşleşen pending before kaydı yoksa after'ın write olayını modified diye kaydetmesi. Yeni dosya izlenebilir ama türü bu birleşimde yanlış sınıflanabilir; dosya deneyi yapılmadı. | N25 §4; LB1 joined results / K/Y, koşullu |
| ECC-OC48 — documentation warning | Creation'ı block ettiğini söyleyen yorumdan farklı olarak branch'in yalnız log uyarısı üretmesi. Uyarının doğru iletilmesi enforced denial değildir. | N25 §4; LB1 HOOKS / K/B/Y |
| ECC-OC49 — post-tool strict typecheck branch | Çalışan after-hook bağlamında args alabilen TypeScript kontrol dalı. Gerçek formatter/test execution veya her Bash/permission davranışı bu checkpoint'te doğrulanmadı. | N25 §3–4; LB1 HOOKS / K/Y |

## 5. Testin kullandığı arayüz ile host arayüzü

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC50 — direct callback-return oracle | Hook testlerinin shell.env dönüş map'ini ve permission dönüşündeki approved alanını doğrudan sınaması. Supplied host output mutasyonunu sınamayan bu beklenti host katkısını kanıtlamaz; test koşulmadı. | N25 §5; LB1 HOOKTEST / T/Y |
| ECC-OC51 — direct lifecycle invocation | Testin session.created/deleted adlı fonksiyonları kendisinin çağırması. Host event bus üzerinden bu fonksiyonlara ulaşıldığını göstermez. | N25 §5; LB1 HOOKTEST / T/Y |
| ECC-OC52 — missing-store test design | Generated helper dizinini yeniden adlandırıp plugin init ve seçilmiş handler'ların çağrılabilirliğini sınayan test. Kurulu host/module cache recovery deneyi değildir; bu tur uygulanmadı. | N25 §5; LB1 HOOKTEST / T |
| ECC-OC53 — explicit-dist build test | Generated dosyayı explicit path ile import edip default export, hook ve tool şekillerini kontrol eden test. Bare package resolution veya gerçek host dispatch testi değildir; koşulmadı. | N25 §5, §7; LB1 BUILDTEST / T/Y |
| ECC-OC54 — npm dry-run path assertions | Build testinin paket yol beklentileri. Araştırmada test tanımı görülmüştür; npm pack/dry-run bu tur veya source inquiry'de yapılmış değildir. | LB1 BUILDTEST; MB1 verification; PB1 standing / T/Y |
| ECC-OC55 — `Promise<Record<string,unknown>>` | ECC factory'nin geniş yerel dönüş tipi. Bu tip içinde strict compilation, SDK Plugin/Hooks uyumunu kanıtlamaz. | N25 §5; LB1 HOOKS/test limits / K/Y |
| ECC-OC56 — SDK Plugin factory contract | Host SDK'sının plugin factory için yayımladığı sözleşme. ECC'nin geniş Record dönüş açıklamasıyla aynı type constraint değildir. | N25 §5; LB1 H1-TYPES / V/Y |
| ECC-OC57 — Hooks shape | Factory'nin döndürdüğü hook map'i için host arayüzü. Factory ile aynı nesne değildir; anahtar/handler sözleşmelerinin local property-existence kontrolünden ayrıldığı yüzeydir. | N25 §2, §5; LB1 H1-TYPES / V/Y |

## 6. Gerçek araç sonucu ve değişiklik kaydı

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC58 — ToolRegistry | Plugin tool map tanımlarını alıp execute çağrısını saran versioned host tüketicisi. Lifecycle trigger'dan ayrı yoldur. | N25 §6; LB1 H1-TOOLS / V |
| ECC-OC59 — fromPlugin returned-string consumption | Wrapper'ın def.execute dönüş string'ini output olarak kullanması. Callback replacement'ının atılması bu return yoluna genellenmez. | N25 §6; LB1 H1-TOOLS / V/Y |
| ECC-OC60 — tool-result truncation | Wrapper'ın araç çıktısını gerekirse kısaltması. Dönüşün tüketilmesi bütün metnin aynen aktarılması garantisi değildir; gerçek çıktı bu tur üretilmedi. | N25 §6; LB1 H1-TOOLS / V/Y |
| ECC-OC61 — changed-files execute | Store'daki tracked kayıtları sorgulayıp raporlayan kayıtlı araç yolu. Bağımsız Git taraması veya tüm session yazımlarının tespiti değildir. | N25 §6; LB1 TOOL/STORE / K/Y |
| ECC-OC62 — recordChange | After-hook'tan gelen dosya değişikliğini module-local store'a kaydetme işlemi. Algılanmayan başka yazımları kendi başına keşfetmez. | N25 §6; LB1 HOOKS/STORE / K |
| ECC-OC63 — module-local Map | Değişiklikleri tutan süreç/modül içi map. Persistent ledger veya session-key partition değildir; gerçek host instance izolasyonu sınanmadı. | N25 §6; LB1 STORE / K/Y |
| ECC-OC64 — worktreeRoot | Aynı store'un tek root değeri. Her session'a ayrı çalışma alanı kimliği veya immutable Git revision değildir. | N25 §6; LB1 STORE / K/Y |
| ECC-OC65 — initStore | Root'u değiştiren fakat map'i temizlemeyen başlangıç işlemi. Yeniden init, önceki değişiklik listesinin sıfırlandığı anlamına gelmez. | N25 §6; LB1 STORE / K/Y |
| ECC-OC66 — last-type overwrite | Aynı path için recordChange'in son türü öncekinin yerine yazması. Append-only change history veya tüm olay sırası değildir. | N25 §6; LB1 STORE / K/Y |
| ECC-OC67 — unused session context | Tool'a verilen context'in sorguyu session bazında ayırmak için kullanılmaması. Araç parametresinin varlığı state partition sağlamaz. | N25 §6; LB1 TOOL / K/Y |
| ECC-OC68 — No files changed in this session | Map boşken kullanılan çıktı ifadesi. Tam session incelemesinde hiç dosya değişmediğine dair doğrulanmış yokluk hükmü değildir. | N25 §6; LB1 TOOL/STORE / K/B/Y |
| ECC-OC69 — rendered change report | Tracked map'ten filtrelenmiş path listesi, tree veya JSON görünümü üretme. Bunlar aynı kaydın temsilleridir; bağımsız kapsam/kanıt veya Git snapshot değildir. | N25 §6; LB1 TOOL/STORE / K/Y |
| ECC-OC70 — session-deleted cleanup invocation | Testin doğrudan çağırabildiği cleanup yolu. Gerçek host'un session.deleted event'inin ona ulaştığı veya map'in session sonunda temizlendiği kanıtı değildir. | N25 §3, §5–6; LB1 HOOKS/HOOKTEST / K/T/Y |

## 7. Optional store ve hata sonrası kullanılabilirlik

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC71 — lazy optional-store initialization | Plugin initialization sırasında dynamic import hatasını yakalayan optional feature yolu. Store eksikliği tüm module evaluation'ını zorunlu çökertmez; bütün bağımlılıkların sağlamlığı değildir. | N25 §6; LB1 HOOKS / K/Y |
| ECC-OC72 — synchronous/async logging guard | Initialization hata tanılamasında sync/async logging karşılığını gözeten koruma. Başka logger/host arızalarının tümünü kapatan garanti değildir. | N25 §6; LB1 HOOKS / K |
| ECC-OC73 — optional store access | Sonraki store çağrılarının optional erişimle korunması. Handler'ın ayakta kalması tracking'in başarıyla gerçekleştiği anlamına gelmez. | N25 §6; LB1 HOOKS / K/Y |
| ECC-OC74 — lazy tool import | changed-files'ın store'u ayrıca lazy yüklemesi. Plugin initialization fallback'iyle ilişkili fakat ayrı çağrı/hata sınırıdır. | N25 §6; LB1 TOOL / K |
| ECC-OC75 — type-only import distinction | MR26'nın gerçek lazy/type-only importları gördükten sonra static import fallback'i bozuyor şüphesini korumaması. Bu tarihsel yorum güncellemesidir; yeni extractor keşfi veya bug düzeltmesi değildir. | MB1 actual inquiry; LB1 TOOL / K/Y |
| ECC-OC76 — invocation-time store error | Araç çağrısında store yüklenemediğinde verilen specific hata. Plugin'in genel startup başarısızlığıyla aynı olay değildir. | N25 §6; LB1 TOOL / K/Y |
| ECC-OC77 — rejected local-promise reset | Tool import reddinden sonra yerel promise'in temizlenip yeniden denemeye izin verilmesi. Gerçek module-loader cache onarımı veya başarılı in-process recovery garantisi değildir. | N25 §6; LB1 TOOL / K/Y |
| ECC-OC78 — loader-cache recovery boundary | Retry fırsatı ile alttaki module cache/dependency durumunun gerçekten düzelmesi ayrımı. Bu source checkpoint cache/platform/host recovery'yi sınamadı. | N25 §6, §8; LB1 remaining responsibility / Y |

## 8. Build hazırlığı ve henüz aktarılmamış dağıtım yolu

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OC79 — remove-dist-before-compiler ordering | Root build'in TypeScript'i bulmadan eski dist'i kaldırması. Build'e başlama, son çalışan payload'ın korunması değildir. | N25 §7; LB1 BUILD / K/Y |
| ECC-OC80 — compiler-resolution failure | OC79 sonrasında compiler bulunamazsa eski dist'in zaten kaldırılmış olabilmesi. Source ordering karşılığıdır; bozuk build deneyi yapılmadı. | N25 §7; LB1 BUILD / K/Y, koşullu |
| ECC-OC81 — staged atomic payload swap | Başarılı yeni payload hazır olana kadar eski payload'ı koruyacak daha güçlü değişim sorusu. İncelenen build böyle staged swap kurmuyor; yeni çözüm benimsenmedi. | N25 §7; LB1 BUILD / Y/K |
| ECC-OC82 — OpenCode-home preparation validation | Adapter'ın generated entry ve iki dizin için type/existence kontrolü. Yararlı precheck'tir; yüklenebilir bütünlük veya callback conformance sertifikası değildir. | N25 §7; LB1 ADAPTER / K/Y |
| ECC-OC83 — dist/index.js file check | Entry path'inin dosya oluşunun sınanması. İçeriğin güncel/doğru veya bütün imports'un çözülebilir olduğunu göstermez. | N25 §7; LB1 ADAPTER / K |
| ECC-OC84 — dist/plugins directory check | Plugins path'inin directory oluşunun sınanması. İçinin boş olmaması veya gerekli helper'ların bulunması aynı koşul değildir. | N25 §7; LB1 ADAPTER / K/Y |
| ECC-OC85 — dist/tools directory check | Tools path'inin directory oluşunun sınanması. Kayıtlı bütün araçların materialize edilip çalışabildiği kanıtı değildir. | N25 §7; LB1 ADAPTER / K/Y |
| ECC-OC86 — missing versus filesystem fault | ENOENT/ENOTDIR benzeri preparation eksiklerinin genuine system errors'dan ayrılması. Bütün I/O hataları yanlışlıkla missing sayılmış değildir. | N25 §7; LB1 ADAPTER / K/Y |
| ECC-OC87 — transitive-import completeness | Entry'nin bağımlı modüllerine kadar payload yeterliliği sorusu. Üç path/type kontrolü bunu yürümüyor; empty helper directory şekil kontrolünü karşılayabilir. | N25 §7; LB1 ADAPTER/remaining / Y/K |
| ECC-OC88 — native-root sync-root-children | Generic adapter helper'ın seçtiği planning biçimi. Gerçek managed materializer/config rewrite zinciri bunun adına bakarak tamamlanmış sayılmaz. | N25 §7; LB1 HELPERS / K/Y |
| ECC-OC89 — install/plan delegation | Install-executor'ın actual plan modülüne devretmesi. B1'de fark edilen ayrı source responsibility; modülün tam yolu/işleyişi tahminle doldurulmaz. | N25 §7–8; LB1 EXECUTOR/remaining / K/Y |
| ECC-OC90 — install/apply delegation | Executor'ın materialization için ayrı apply modülünü kullanması. Planlamayla aynı işlem değildir; B2 body closure burada yapılmış sayılmaz. | N25 §7–8; LB1 EXECUTOR/remaining / K/Y |
| ECC-OC91 — relative ./plugins reference | Kaynak OpenCode config'indeki relative plugin hedefi. Nested exports'un dist hedefi veya kurulumdan sonra yeniden yazılmış path ile kendiliğinden eşit değildir. | N25 §7; LB1 CONFIG / K/Y |
| ECC-OC92 — bare package resolution | Paket adı üzerinden hangi entry'nin seçildiği sorusu. Explicit dist import testinin doğrudan sınamadığı ve B1'den B2'ye kalan kaynak sorumluluğudur. | N25 §7–8; LB1 PACKAGE/ROOT/BUILDTEST / Y/K/T |

## 9. Kaynaktan kayda kapsam kontrolü

N25 §1 → OC01–OC20; §2 → OC19/OC21–OC35; §3 → OC07/OC36–OC41/OC46/OC49/OC70; §4 → OC42–OC49; §5 → OC25/OC50–OC57; §6 → OC58–OC78; §7 → OC02–OC03/OC13–OC20/OC79–OC92; §8 → aşağıdaki açık-sorumluluk ayrımı. LB1'in source table, host table, joined results, discovery/freshness, test ve remaining responsibility bölümleri tam okundu. MB1'in terk edilmiş static-import şüphesi OC75'te ayrıca izlenir.

Kaynak kodu raporu, versioned host sözleşmesi, hedef README/yorumları ve test beklentileri aynı rol değildir. B1-ROOT/B1-CONFIG/B1-EXECUTOR ve bazı host kaynaklarının selected kapsamı full audit'e yükseltilmez. B1-TOOL yalnız changed-files gövdesini kapatır; dependency-analyzer veya bütün tool katalogu kapanmış sayılmaz. Dönüşte anılan araç listesi ve compaction metni ayrı tutulur.

Normal karşılıklar da korunur: executable adaptation, plugin-only export, gerçek after-hook args, tool.execute return tüketimi, lazy optional-store davranışı ve missing/system-error ayrımı. Callback mismatch, plugin bütünüyle işe yaramaz veya host'un ortamı/hafızası kaybolur hükmüne çevrilmedi. Permission sonucu ilgili trigger kapsamıyla sınırlıdır.

PB1'in catalogue newline düzeltmesi, non-force publication ve concurrent Concepts değişimleri tarihsel yayın hesabıdır; target callback arızası veya bu turun yeni mutation testi değildir. SHA/path/version/test adları ve örnek event anahtarları teknik ayrımlarında korunur; her örnek için genel teknoloji tanımı üretilmez. Bu dört dosya yeni deney içermiyor; E08/E07 veya sonraki Python E09 bu plugin'in deneyi yapılmaz.

## 10. İlişki ve yorum izi

**İki farklı tüketim sözleşmesi:** OC21 callback'i await eder, fakat OC24 replacement'ı kullanmaz; OC23 supplied output değişikliği yük taşır. OC58/OC59 araç yolu ise execute dönüşünü kullanır. Aynı return/başarı sözcükleri iki yolda aynı etkiyi taşımaz. Event dağıtımı OC36/OC37 üzerinden ayrıca bağlanır; top-level OC38 fonksiyonları bu bağın yerine geçmez.

**Çalışan ve kopuk halkalar birlikte:** OC42–OC45 before sınıflandırmasını sınırlarken OC46/OC62 after kaydı çalışabilir. OC47 yeni yazılmış dosyanın modified diye kaydedilmesi olasılığıdır; hiç tracking yok demek değildir. OC63–OC69 yalnız yakalanmış map'in raporudur. OC70 cleanup'ın testte çağrılması, bus subscriber eksikliğini gidermez. OC71–OC77 optional özelliği kaybetme ile bütün plugin startup'ının kaybını ayırır.

**Önceki kayıtlarla bağ:** EP16'nın Rust OpenCode command recipe'si bu executable plugin ailesinin başka adlandırması değildir. EP18 native argüman üretimi/consumer kabulü ve EP19 text projection ayrımları burada callback/output'a benzer soru yöneltir, fakat aynı hata kanıtı değildir. R19 generated runtime işareti OC04/OC05/OC79 ile ayrıntılanır; byte üretmek yüklenmiş callback demek değildir. R41/R76/R77 veya RD64/BC63'teki session/projection/mark-read kavramları OC63 module-local Map'e otomatik partition ya da kalıcılık kazandırmaz. Bunlar B8 ortak tanım kararları değil, kapsamı belirtilmiş geri çağırma bağlantılarıdır.

**Bu turun anlam seçimi:** B1'in tarihsel PARTIAL durumunu current source-study'ye geri taşımadım. B2 bugün mevcut ayrı bir araştırma çıktısıdır; Concepts aktarımı sıradadır. Ayrıca MB1'deki static-import şüphesinin kaynak okumayla terk edilmesini yeni extractor düzeltmesi gibi sunmadım. Önceki TERMS dosyalarını yeniden yazmayı gerektiren maddi çelişki bu karşılaştırmada saptanmadı. Somut atlama/yanlış atıf bulunursa ilgili kayıt açılır; salt aynı kelimeye bakarak eş anlamlılık kurulmaz.

## 11. Kapanış ve açık sınır

**ECC-OC01–OC92** adreslenebilir kaynak-bağlı kullanım kayıtlarıdır; 92 bağımsız kavram, deney veya ilerleme yüzdesi değildir. U12-B1'in dört research dosyasından aktarım yapıldı. Yayın/readback ve current READING/TERMS/STATE ayrıca kontrol edilir; bu dosyanın varlığı C5c/C5/C6 veya whole ECC kapanışı değildir.

**B2 kaynak devamı ile daha güçlü doğrulama farklıdır:** N25/LB1/MB1/PB1'de root/nested package, managed install, config rewriting, loader ve import/tool zinciri henüz yapılmamış source work idi. Concepts bunu yalnız canlı test eksiği diye dışlamaz; mevcut Note26/U12-B2 sıradadır. Q02b3 ise gerçek build/tarball/registry-source eşliği, cache/platform/multi-project/host davranışı ve efficacy sınırlarını taşır. Bu sınırlar otomatik yeni Concepts deneyi veya SOUL gereksinimi değildir.

Yeni compiler/test/fixture, npm pack, installation, plugin/host/model/provider veya upstream mutation yapılmadı. Yerel Markdown/ID/bağlantı kontrolleri varsa yalnız yayın idaresidir, ECC deneyi değildir. E06 excluded; diğer deneylerin ve iki E05'in ayrı geçmişleri korunur.

Batu okuma anındaki anlam seçimlerini denetleyemediğinden önemli dayanak, yorum ve belirsizlikler adreslenir. Ortak sözcük ortak anlamı garanti etmez; kaynak kullanımı, araştırmacı yorumu, extractor açıklaması ve kullanıcı onayı birbirinin teknik doğrulaması değildir.

Exact next: **C5c / U12-B2 — Note26 installation/loading/tool-result**. U12-C/Python, C6 ve B7/B8 daha sonra gelir; bu dosyayla tamamlanmış sayılmaz.
