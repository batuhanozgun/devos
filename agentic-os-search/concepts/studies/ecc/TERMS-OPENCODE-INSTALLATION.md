# ECC — OpenCode kurulum, yükleme ve araç sonucu kullanımları

2026-09-21 · **B6-T17-C5c / U12-B2 CONTEXTUAL TRANSFER / C5c-PARTIAL**.

Bu dosya Note26/U12-B2 araştırmasındaki kullanımları kaynak bağlamlarında taşır. OD öneki yalnız adreslemedir; ortak kavram sınıfı değildir. [READING.md](READING.md) okuma ve aktarım durumunu, [TERMS.md](TERMS.md) kullanım girişini, [global STATE](../../STATE.md) güncel işi taşır. Yeni kurulum, ürün araştırması veya mimari kabul yapılmaz.

## 1. Kaynak kimliği ve roller

Research snapshot: **batuhanozgun/agentic-os-search@2db53e57c4dba096a6a803433cfee9d7d99b2c90**. Ayrı ECC pin'i **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Host karşılaştırması **anomalyco/opencode v1.4.3 / 877be7e8e04142cd8fbebcb5e6c4b9617bf28cce**; nested lock etiketiyle ilişkilidir, registry/kurulu sürüm eşliği değildir. İndeksin **07756cee15788a54506031462794ad645719b028** gözlemi ayrı kalır.

| Anahtar | Tam okunan araştırma dosyası | Git blob |
|---|---|---|
| N26 | [Note26](../../../research/studies/ecc/notes/26-OPENCODE-INSTALLATION-LOADING-AND-TOOL-RESULTS.md) | 46576b4c8c7df5c2b2eefbe2288b00c493e67bb5 |
| LB2 | [U12-B2 source ledger](../../../research/studies/ecc/evidence/U12-B2-SOURCES.md) | 39b5e39d01d8b0dcaad4fb5d1930f668031ef416 |
| MB2 | [ROUND-U12-B2 / MR27](../../../research/studies/ecc/ROUND-U12-B2.md) | ded88f931216d522b8a77f15c84bfe2379607b2a |
| PB2 | [PUBLICATION-U12-B2](../../../research/studies/ecc/PUBLICATION-U12-B2.md) | c1979d0faf434bfdcbf781368868e651e1fa7fde |

Göreli bağlantılar güncel dosyayı açar; exact içerik yukarıdaki snapshot/blob ile belirlenir. LB2'nin B2-* locator'ları ECC kaynaklarını, H2-* locator'ları versioned host'u, retained B1/H1 locator'ları önceki source kapsamını gösterir. Bu Concepts turunda atfedilen upstream kod, test ve dış dokümanlar yeniden okunmuş/çalıştırılmış sayılmaz.

**Roller:** K = araştırmacının pinned ECC kodundan raporladığı kullanım; V = versioned host kaynağından raporladığı sözleşme; B = kaynak belge/yorum beyanı; Y = araştırmacının açıklaması veya koşullu çıkarımı; T = incelenmiş fakat çalıştırılmamış test tasarımı. Türkçe açıklamalar extractor paraphrase'idir; doğrudan ürün tanımı veya bağımsız teknik doğrulama değildir. Note, ledger, round ve receipt bağımsız dört destek sayılmaz.

## 2. Paket, seçilen giriş ve kurulum kökü

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD01 — nested-package entry | İç paketin main alanından dist/index.js seçilebilen nested/local-directory yolu. Plugin-only entry, geniş komut/agent/yönerge katalogunu kendiliğinden kurmaz. | N26 §1; LB2 H2-SHARED, retained B1-PACKAGE/ENTRY / K/V/Y |
| ECC-OD02 — reference ./plugins route | Kaynak config'in ./plugins ifadesinin config dosyasına göre çözülüp directory index'e gitmesi. Bu kaynak-plugin yoludur; dist/index.js seçimi değildir. | N26 §1; LB2 CONFIG/H2-CONFIG/SHARED / K/V |
| ECC-OD03 — managed OpenCode home install | Adapter'ın .opencode çocuklarını seçilen config köküne, planner/apply üzerinden yerleştirmesi. Kopyalanmış source ve dist aynı yerde bulunabilir; hangi girişin yükleneceği ayrı karardır. | N26 §1; LB2 MODULES/PLAN/APPLY / K/Y |
| ECC-OD04 — bare root package entry | Pinned root manifestte installer bin/files/prepack bulunurken nested compiled entry'ye main/exports bağı olmaması. Host nested manifesti özyinelemeli devralmaz; her importer veya yayımlanmış paketin başarısızlığı iddia edilmez. | N26 §1; LB2 ROOT/H2-SHARED / K/V/Y |
| ECC-OD05 — package contents versus entry selection | Pakette .opencode dosyalarının bulunmasıyla paket adı çözülürken bunların giriş seçilmesinin ayrılması. İçeriğin paketlenmesi, yüklenen runtime kimliği değildir. | N26 §1, §8; LB2 joined claims / Y |
| ECC-OD06 — separate indexed root entry | 07756cee root header'ının explicit compiled-entry beyanı. B1'den korunan dar farklı-sürüm gözlemidir; 8321021 pin'ine aktarılmış düzeltme veya release kanıtı değildir. | N26 §1; LB2 retained B1/freshness / K/Y |
| ECC-OD07 — OPENCODE_CONFIG_DIR | Hedef config root seçiminde ilk kullanılan explicit ortam girdisi. Desteklenen path'in lifecycle bakımından legacy root'tan farklı olması ayrıca kontrol edilmelidir; bu eşitsizlik burada varsayılmaz. | N26 §2, §5; LB2 PATH / K/Y |
| ECC-OD08 — XDG_CONFIG_HOME/opencode | Explicit OpenCode root yoksa kullanılan ikinci kök yolu. Seçilen home altındaki fallback ile aynı girdi değildir. | N26 §2; LB2 PATH / K |
| ECC-OD09 — home .config/opencode fallback | Önceki kök girdileri yoksa seçilmiş home'a göre kullanılan config yolu. Normal disjoint-root karşılığıdır; bütün explicit kurulumlar bu konumu kullanmaz. | N26 §2, §5; LB2 PATH / K/Y |

## 3. Request, materialization ve sonradan değişen bağımlılıklar

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD10 — normalized install request | CLI girdisinin manifest/legacy seçimi, consent ve planlama tarafından tüketilen biçime getirilmesi. Preview veya normalize edilmiş talep, gerçek apply etkisi değildir. | N26 §1–3; LB2 REQUEST/RUNTIME/CLI / K/Y |
| ECC-OD11 — module selection | Manifest planında explicit/ordered modüllerin ve adapter scaffold'un seçilmesi. Bir modül adı bütün davranışların veya bağımlılıklarının incelendiği anlamına gelmez. | N26 §1, §3; LB2 MANIFEST/MODULES / K/Y |
| ECC-OD12 — platform-configs | .opencode ağacının ait olduğu install-module ownership etiketi. hooks-runtime ile aynı modül değildir; consent classifier bu ayrımı tüketir. | N26 §1, §3; LB2 MODULES / K |
| ECC-OD13 — registry-called build precheck | Registry'nin operation planning öncesi adapter'ın compiled entry/directory kontrollerini gerçekten çağırması. Yalnız mevcut helper değildir; yine de transitive imports veya callback uyumunu ölçmez. | N26 §2; LB2 REGISTRY, retained B1-ADAPTER / K/Y |
| ECC-OD14 — validation-code exemption | Caller'ın ilgili validation code'u açıkça muaf tutabildiği yol. Precheck'in bütün çağrılarda koşulsuz zorunlu olduğu kabul edilmez. | N26 §2; LB2 REGISTRY / K/Y |
| ECC-OD15 — recursive materialization | Native-root içeriğini göreli konumları koruyan somut operasyonlara açma. Plan üretimi tek başına dosyaların yazıldığı veya host'un yüklediği anlamına gelmez. | N26 §1–2; LB2 PLAN / K/Y |
| ECC-OD16 — copy-file operation | Plan/apply'daki belirli kaynaktan hedefe kopyalama işlemi ve managed ownership kaydı. Bütün kurulum veya callback registration ile aynı nesne değildir. | N26 §2, §5; LB2 PLAN/APPLY/MIGRATION / K/Y |
| ECC-OD17 — materialization exclusions | Planner'ın belirli runtime/generated state ve cache yollarını kopyalama kapsamından dışlaması. Paketleme dışlama dosyası OD90 ayrı seçicidir; generated dist'in bütünü atılıyor sonucu çıkarılmaz. | N26 §2; LB2 PLAN / K/Y |
| ECC-OD18 — last-copy-wins | Generic ve OpenCode-specific kopyalar aynı hedefe yönelirse son kopyanın tutulması. Superseded kopyanın owner olarak kaydını önler; eşzamanlı yazma kilidi değildir. | N26 §2; LB2 PLAN / K/Y |
| ECC-OD19 — guarded apply | Path/symlink kontrollerinden sonra ordinary copy veya explicit transform yapıp state/digest yazan uygulama yolu. Bütün ownership/concurrency helper'ları bu unit'te yeniden doğrulanmış değildir. | N26 §2; LB2 APPLY/SAFETY / K/Y |
| ECC-OD20 — installed content digest | Apply'ın yazdığı dosya içeriğini kayda bağlayan digest. Sonraki host değişikliğini, yüklenen entry'yi veya dosyanın cleanup sonrası kaldığını garanti etmez. | N26 §2, §5; LB2 APPLY / K/Y |
| ECC-OD21 — Markdown relative-link rewriting | Uygulanabilir Markdown dosyalarındaki göreli referans dönüşümü. OpenCode JSON plugin hedefini ./dist/plugins'e çevirmekle aynı transform değildir. | N26 §2; LB2 APPLY / K/Y |
| ECC-OD22 — unchanged OpenCode plugin reference | İzlenen apply yolunun JSON'daki ./plugins referansını dist'e yeniden hedeflememesi. Dist precheck'i geçti diye compiled route seçilmiş sayılmaz. | N26 §1–2; LB2 CONFIG/APPLY / K/Y |
| ECC-OD23 — config-relative file references | Host'un prompt/command/file referanslarını config kaynağının konumuna göre çözmesi. Metinlerin konumunu korumak yararlıdır; tüm Node/Bun importları için uyumluluk kanıtı değildir. | N26 §2; LB2 H2-CONFIG/PATHS / V/Y |
| ECC-OD24 — host dependency installation | Writable config dizininde host'un package.json'a kendi sürümünde @opencode-ai/plugin ekleyip dependency installation çalıştırabilmesi. ECC'nin kopyalama işlemi veya nested lock kimliği değildir. | N26 §2; LB2 H2-CONFIG / V/Y |
| ECC-OD25 — post-copy dependency mutation | ECC digest yazdıktan sonra host'un package/dependency içeriğini değiştirebilmesi. Root development dependency, nested lock ve host-resolved paket tek frozen environment değildir. | N26 §2; LB2 joined claims / K/V/Y |

## 4. Consent kaydı ve classifier'ın kapsamı

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD26 — --no-hooks / noHooks | CLI anahtarının parse sonucundaki seçenekle taşınması. Aynı seçeneğin iki temsili burada birlikte adreslenir; bütün otomatik host davranışlarının kapandığı anlamı eklenmez. | N26 §3; LB2 REQUEST / K/Y |
| ECC-OD27 — hookConsent=declined | Normalization'ın ürettiği ve kaydedilen ret kararı. Kararın kapsamı, işlemleri hook sayan classifier'a bağlıdır; hiç plugin kodu yüklenmez kanıtı değildir. | N26 §3; LB2 REQUEST/CONSENT / K/Y |
| ECC-OD28 — withHookConsent | Runtime'ın plan/işlem zincirini consent semantiğiyle saran gerçek çağrısı. Yalnız seçenek adının bulunmasıyla sınırlı değildir; filtre kapsamını genişletmez. | N26 §3; LB2 RUNTIME / K/Y |
| ECC-OD29 — isHookRuntimeOperation | Ownership ve belirli hooks/Cursor/Claude-settings yollarıyla hook operasyonu sınıflandıran predicate. platform-configs altındaki OpenCode plugin kopyaları bu tanınan kümeye girmiyor. | N26 §3; LB2 CONSENT / K/Y |
| ECC-OD30 — classified hook stripping | Classifier'ın hook saydığı operasyonların declined halinde kaldırılması. Gerçek pozitif kontroldür; sınıflandırılmayan otomatik callback'leri de kaldırdığı varsayılmaz. | N26 §3; LB2 CONSENT / K/Y |
| ECC-OD31 — explicit hooks-runtime conflict refusal | Explicit hooks-runtime seçimiyle --no-hooks birlikte verilince ret. platform-configs seçiminin aynı ret dalına girdiği söylenmez. | N26 §3; LB2 REQUEST / K |
| ECC-OD32 — retained automatic-plugin counterpart | platform-configs korunursa plugin kopyalarının declined kararına rağmen kalabilmesi. After-hook etkisi installation/dependencies/loading ve kendi profile/disabled koşullarına bağlıdır; canlı consent bypass deneyi değildir. | N26 §3; LB2 joined claims; OC40/OC41/OC46 / K/V/Y, koşullu |

## 5. Origin, export ve kayıtlı fonksiyon kimliği

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD33 — local plugin scan | Host'un plugin/plugins dizinlerindeki direct .ts/.js dosyalarını bulması. Paket içindeki her dosyanın recursive taranması veya tek plugin kimliği değildir. | N26 §4; LB2 H2-CONFIG / V |
| ECC-OD34 — configured plugin path | Config'deki plugin yolunun ayrıca çözülmesi. Tarama yoluyla aynı dosyaya ulaşabilir; her configured path ayrı factory demek değildir. | N26 §4; LB2 H2-CONFIG/SHARED / V/Y |
| ECC-OD35 — local file-URL origin | Host config dedup'un local köken için kullandığı dosya URL'si. Re-export edilen fonksiyonun semantik kimliği değildir. | N26 §4; LB2 H2-CONFIG/SHARED / V/Y |
| ECC-OD36 — deduplicatePluginOrigins | Aynı index.ts'e resolved config ve tarama üzerinden ulaşılmasını birleştirebilen origin kontrolü. index.ts ile ecc-hooks.ts farklı URL olduğunda bunları birleştirmez. | N26 §4; LB2 H2-CONFIG / V/Y |
| ECC-OD37 — per-module duplicate-export Set | Tek modül içindeki eşdeğer export'ların tekrar uygulanmasını önleyen Set. Ayrı modüllerden gelen aynı factory'yi global olarak tekilleştiren kontrol değildir. | N26 §4; LB2 retained H1-DISPATCH / V/Y |
| ECC-OD38 — two hook records from one factory | Barrel ve implementation modülü ayrı origin olarak yüklenip initialize olursa aynı factory'nin iki hook kaydı oluşturabilmesi. Callback kendi predicate'lerine bağlıdır; ölçülmüş çift çalışma değildir. | N26 §4; LB2 joined claims / K/V/Y, koşullu |
| ECC-OD39 — nested-package-only loading | Default-only nested entry'nin tek başına internal source directory taraması istememesi. Çift-origin örneğinin anlamlı karşılığıdır; bütün olası config birleşimleri için tek-instance garantisi değildir. | N26 §4; LB2 retained B1-ENTRY / K/V/Y |
| ECC-OD40 — tools/index.ts barrel | Sekiz aracın named re-export yüzeyi. Plugin-only entry veya plugin'in iki araçlık map'i değildir; import/registration kapsamı ayrıdır. | N26 §4, §6; LB2 TOOLINDEX / K/Y |
| ECC-OD41 — local-file tool registration | Host'un direct tool dosyaları ve barrel export'larından callable kimlikleri üretmesi. README'deki araç adıyla veya plugin-map key'iyle birebir eşlik varsayılmaz. | N26 §4; LB2 retained H1-TOOLS / V/Y |
| ECC-OD42 — plugin-map tool registration | Plugin'in tool map'inden alınan tanımların kayıt yolu. Local-file kaydından ayrı kaynaktır; aynı görünen ad tek instance veya aynı callable ID kanıtı değildir. | N26 §4; LB2 retained H1-TOOLS; OC10/OC58 / K/V/Y |

## 6. Cleanup, sahiplik ve lifecycle rolü

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD43 — OpenCode legacy cleanup | Yeni kurulumdan sonra eski managed içeriği seçip temizleyen helper. Her eski dizini veya kullanıcı dosyasını topluca silen işlem değildir. | N26 §5; LB2 MIGRATION / K/Y |
| ECC-OD44 — recorded root/target identity | Canonical/legacy state'in kayıtlı root ve target bakımından doğrulanması. İki rolün farklı fiziksel köke ait olduğunun doğrulanmasıyla aynı değildir. | N26 §5; LB2 MIGRATION / K/Y |
| ECC-OD45 — managed copy-file candidate | Yalnız kullanılabilir hash taşıyan managed copy-file kayıtlarının cleanup adayı oluşu. Bütün dosyalar veya bütün operasyon türleri aday değildir. | N26 §5; LB2 MIGRATION / K |
| ECC-OD46 — recorded-digest match | Mevcut dosyanın kayıtlı digest ile karşılaştırılması. Dosyanın lifecycle rolünün gerçekten legacy olduğu sonucunu tek başına vermez. | N26 §5; LB2 MIGRATION / K/Y |
| ECC-OD47 — current-source-digest match | Mevcut dosyanın güncel kaynak içeriğiyle de karşılaştırılması. Recorded digest'ten ayrı karşılaştırmadır; aynı-root halinde yeni kopya iki eşleşmeyi de sağlayabilir. | N26 §5; LB2 MIGRATION / K/Y |
| ECC-OD48 — regular-file identity | Cleanup'ın dosya türü/kimliğini doğrulaması. Sabit regular file koşulu, canonical ve legacy rollerinin ayrıldığı anlamına gelmez. | N26 §5; LB2 MIGRATION/SAFETY / K/Y |
| ECC-OD49 — trusted-root confinement | Realpath/containment ile işlemin izin verilen kökte tutulması. İki lifecycle rolü aynı kökteyse yanlış rol seçimini engellemez; bu örnek path escape değildir. | N26 §5; LB2 SAFETY / K/Y |
| ECC-OD50 — quarantine/restore deletion path | Silme etrafında karantina ve gerektiğinde restore koruması kullanan cleanup yolu. Rolü yanlış belirlenmiş fakat hash kontrollerini geçen dosya için genel iptal garantisi değildir. | N26 §5; LB2 MIGRATION / K/Y |
| ECC-OD51 — modified/unverifiable retention | Değişmiş veya doğrulanamayan managed içeriğin korunması. Same-root karşı-örneği her dosyanın veya arbitrary kullanıcı verisinin silindiği anlamına genişletilmez. | N26 §5; LB2 MIGRATION / K/Y |
| ECC-OD52 — post-state-write cleanup | Cleanup'ın yeni install-state yazımından sonra çağrılması. Önceki write/digest başarısı, bütün lifecycle'ın son sonucu değildir. | N26 §5; LB2 APPLY/MIGRATION / K/Y |
| ECC-OD53 — derived HOME/.opencode legacy root | Helper'ın legacy konumu home'dan sabit türetmesi. Explicit canonical root'un aynı konumu seçemeyeceği kontrolü değildir. | N26 §5; LB2 PATH/MIGRATION / K/Y |
| ECC-OD54 — same canonical/legacy root | Explicit config root=HOME/.opencode, matching homeDir ve başarılı write/state sonrasında yeni içeriğin legacy adayına dönüşebilmesi. Stable regular files/digest eşliği gerekir; yıkıcı fixture çalıştırılmadı. | N26 §5; LB2 joined claims / K/Y, koşullu |
| ECC-OD55 — lifecycle-role collision | Aynı fiziksel konumun current ve legacy olarak tüketilmesiyle güvenli identity kontrollerinin yanlış lifecycle rolünde uygulanması. Integrity kontrolü yokluğu veya saldırgan öncülü değildir. | N26 §5, §7–8; MB2 actual findings / Y |
| ECC-OD56 — empty retained-set state removal | Cleanup sonunda korunacak kayıt kalmazsa aynı state dosyasının da kaldırılabilmesi. Her state'in mutlaka silineceği anlamına gelmez. | N26 §5; LB2 MIGRATION / K/Y, koşullu |
| ECC-OD57 — nonfatal cleanup warning | Retained içerik veya cleanup sonucu nedeniyle uyarının dış apply başarısını zorunlu bozmaması. Uyarı yokluğu ya da varlığı surviving payload için yeterli oracle değildir. | N26 §5; LB2 APPLY/MIGRATION / K/Y |
| ECC-OD58 — applied:true | Outer apply'ın cleanup veya nonfatal warning sonrasında da döndürebildiği başarı alanı. Yeni dosyaların hâlâ yerinde olması, plugin yüklenmesi veya accepted outcome garantisi değildir. | N26 §5; LB2 APPLY / K/Y |
| ECC-OD59 — disjoint default roots | Normal .config/opencode ile legacy .opencode konumlarının farklı olması. Aynı-root collision koşulunu kurmayan pozitif karşılıktır; tüm migration garantilerinin sertifikası değildir. | N26 §5; LB2 PATH / K/Y |

## 7. Araç adı, üretilen kanıt ve yapılmış etki

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD60 — changed-files tracked report | B1'in module-local map'ini path/tree/JSON olarak gösteren araç. N26'daki karşılaştırmada complete Git/session history değildir; consumer ve optional-store sınırları OC61–OC78'de korunur. | N26 §6; LB2 retained B1 / K/Y |
| ECC-OD61 — dependency-analyzer inventory | package.json dependency/dev/peer girdilerinin envanteri ve heuristic öneriler. Current latest, vulnerability, unused veya düzeltme analizi yapılmış sayılmaz. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD62 — outdated=false initialization | Dependency kayıtlarının başlangıçta false işaretlenmesi. Güncel sürüm karşılaştırmasının sonucu veya hiç eski paket yok ölçümü değildir. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD63 — unpopulated security analysis | Vulnerability analiziyle doldurulmayan security yüzeyi. Zero vulnerable özeti incelenmiş advisory sonucu değildir. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD64 — unused=0 | Sabit sıfır unused sayısı. Kullanılmayan bağımlılık analizi yapıldığını veya yokluğunu göstermez. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD65 — dependency success:true | Başarıyla parse edilmiş manifest için dönen başarı alanı. OD62–OD64 defaultları actual vulnerability/version/unused kontrollerine dönüşmez; öneri metni OD91'de ayrı tutulur. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD66 — analysisType | Returned object'teki analiz türü etiketi. Adının bulunması istenen analizin gerçekten koştuğunu göstermez. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD67 — fixMode / fix intent | Girdi/çıktıda taşınan düzeltme isteği veya etiketi. Dependency değiştiren implemented effect bu araçta gösterilmez. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD68 — depth option boundary | Dependency-analyzer'da depth adının bulunmasına rağmen buna bağlı implemented analysis effect gösterilmemesi. Git aracının ayrı depth kontrolüne genellenmez. | N26 §6; LB2 DEPS/GIT / K/Y |
| ECC-OD69 — first-50 presentation cap | Dependency listesinin elli kayıtla sınırlandırılması, summary'nin bütün parsed envanteri sayması. Aynı payda veya elli doğrulanmış paket değildir. | N26 §6; LB2 DEPS / K/Y |
| ECC-OD70 — run-tests command suggestion | Package/framework ipuçlarından test komutu hazırlayıp döndürme. Test process'i, PASS veya yeni coverage üretimi değildir. | N26 §6; LB2 RUN / K/Y |
| ECC-OD71 — format-code command recommendation | Formatter algılama/default üzerinden komut önerme; bu rol kaynakta açıkça belirtilir. Dosyaları formatladığı veya executable kurulu olduğu sonucu değildir. | N26 §6; LB2 FORMAT / K/B/Y |
| ECC-OD72 — lint-check command recommendation | Linter algılama/default üzerinden komut önerme. Lint/fix execution değildir; komut üretme amacı tek başına bug diye sınıflandırılmaz. | N26 §6; LB2 LINT / K/B/Y |
| ECC-OD73 — first usable coverage report | Belirtilen seçeneklerdeki ilk kullanılabilir mevcut raporun seçilmesi. Yeni test koşusu veya current revision'a bağlı measurement değildir. | N26 §6; LB2 COVERAGE / K/Y |
| ECC-OD74 — line-percentage threshold | Parse edilen raporun line yüzdesini supplied threshold ile karşılaştırma. Rapor güncelliği, kaynağı ve gerçek test coverage'ının yeniden ölçümü ayrı sorulardır. | N26 §6; LB2 COVERAGE / K/Y |
| ECC-OD75 — unfamiliar-JSON empty result | Geçerli fakat parser'ın tanımadığı JSON'un empty summary karşılığına düşebilmesi. Yeni measurement veya bütün rapor biçimlerinin kabulü değildir. | N26 §6; LB2 COVERAGE / K/Y, koşullu |
| ECC-OD76 — git-summary execution | Git'i ayrı argümanlarla gerçekten çağıran implementation. Diğer araçların command-only rolü bu yola taşınmaz; bu Concepts turunda Git aracı çalıştırılmadı. | N26 §6; LB2 GIT / K/Y |
| ECC-OD77 — Git ref/depth guards | Git çağrısı için bounded depth ve ref doğrulaması. Gerçek pozitif kontrollerdir; komutun başarılı çıktısı veya current repository cleanliness oracle'ı değildir. | N26 §6; LB2 GIT / K/Y |
| ECC-OD78 — Git error-to-empty conversion | Git helper'ın command error'ı boş metne çevirmesi. Başarıyla alınmış boş status ile hata kökeni aynı temsil olur. | N26 §6; LB2 GIT / K/Y |
| ECC-OD79 — status=clean substitution | Boş metin için caller'ın clean kullanması. OD78 nedeniyle bu alan her zaman başarılı temiz-status sorgusu anlamına gelmez; mevcut repo hakkında cleanliness hükmü verilmez. | N26 §6; LB2 GIT / K/Y |
| ECC-OD80 — security-audit file/regex scan | Seçilmiş path/extension'larda secret ve code pattern tarayan gerçek bounded analiz. Sadece envanter değildir; tam güvenlik veya haricî advisory taraması da değildir. | N26 §6; LB2 SECURITY / K/Y |
| ECC-OD81 — pending dependency-audit command | Security-audit'ın çalıştırmadığı dependency komutunu açıkça pending göstermesi. Yapılmış dependency scan değildir; dependency-analyzer'ın default-zero sonucuyla aynı kanıt statüsü değildir. | N26 §6; LB2 SECURITY / K/Y |
| ECC-OD82 — ignored individual-file read errors | Bazı dosya okuma hatalarının scan sırasında atlanması. No findings, her aday dosyanın okunduğu veya güvenli olduğu anlamına gelmez. | N26 §6; LB2 SECURITY / K/Y |

## 8. Loader, bağımlılık ve test kapsamları

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD83 — staged loader errors | Host loader'ın install, entry, compatibility ve module-load hata aşamalarını ayırması. Bir hata etiketi bütün failure/recovery yollarının aynı olduğu anlamına gelmez. | N26 §7; LB2 H2-LOADER/SHARED / V/Y |
| ECC-OD84 — optional local wait callback | Yerel yükleme retry'ı için sağlanması gereken optional wait callback. Genel otomatik in-process repair veya başarılı yeniden yükleme garantisi değildir. | N26 §7; LB2 H2-LOADER / V/Y |
| ECC-OD85 — caller without retry hook | B1 server caller'ının OD84'teki optional callback'i sağlamaması. Loader'da retry kodu varlığı bu caller'da retry çalıştığını göstermez. | N26 §7; LB2 retained H1-DISPATCH / V/Y |
| ECC-OD86 — failed-dist-build route scope | Eski dist'in compiler lookup öncesi silinmesi compiled yolu etkileyebilir; source-plugin yolu ayrıdır. OC79–OC81 bulgusundan bütün active plugin yolları durur sonucu çıkarılmaz. | N26 §7; LB2 retained B1-BUILD / K/Y |
| ECC-OD87 — required static tool imports | Main plugin'in changed-files ve dependency-analyzer'a statik bağı; local barrel'ın daha geniş import yüzeyi. Missing unrelated barrel dependency ile optional store eksikliği aynı failure değildir. | LB2 finite tool-subtree/retained B1 / K/Y |
| ECC-OD88 — optional-feature degradation | B1'in tracking store'u eksikken guarded/lazy davranışı. Missing required imports, dependency-install failure veya callback mismatch için genel fallback değildir. | N26 §7; LB2 finite tool-subtree; OC71–OC78 / K/Y |
| ECC-OD89 — retained B1 test-oracle scope | Explicit generated-file import ve direct callback testlerinin devralınması. Bare-root resolution, consent kapsamı, same-root cleanup veya actual-origin dedup'u doğrulamaz; B2'de test koşulmadı. | N26 §7; LB2 evidence limits; MB2 verification / T/Y |

## 8A. Ayrı adreslenen paketleme ve öneri kullanımları

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-OD90 — .opencode/.npmignore exclusions | node_modules ve bun.lock için paketleme dışlamaları. Planner'ın runtime/cache filtresi OD17 ile aynı seçici değildir; npm pack bu tur çalıştırılmadı. | LB2 fresh ECC coverage, B2-IGNORE / K/Y |
| ECC-OD91 — no-critical-issues recommendation | Dependency-analyzer'ın ölçülmemiş zero/default özetle üretebildiği öneri metni. success:true alanından ayrı kullanıcıya dönük hükümdür; yapılmış security analizi diye okunmaz. | N26 §6; LB2 DEPS / K/Y |

## 9. Kaynaktan kayda kapsam kontrolü

N26 §1 → OD01–OD06/OD10–OD16; §2 → OD07–OD25; §3 → OD12/OD26–OD32; §4 → OD33–OD42; §5 → OD43–OD59; §6 → OD60–OD82/OD91; §7 → OD52–OD58/OD83–OD89; §8 → aşağıdaki ilişkiler ve açık sınırlar. LB2'deki .npmignore OD90'da, finite tool/barrel import farkı OD40/OD87'de, H2 loader'ın optional retry koşulu OD84/OD85'te ayrıca hesaba katıldı.

LB2'nin full/selected/retained kapsamları özgün araştırmanın okuma hesabıdır. Bu tur dört research dosyası FULL okunmuştur; bütün upstream install/default helpers, tüm config şemaları, diğer host'lar veya bütün prompt/command kataloğu yeniden okunmuş sayılmaz. Sekiz direct tool ve barrel tamamlığı B1+B2 kaynak araştırmasına aittir; yeni compiler/generated-byte/installation eşliği değildir.

MB2, son cleanup tüketicisinin incelenmesinin önceki installation açıklamasını nasıl değiştirdiğini kaydeder; bu tarihsel araştırmacı değişimi OD52–OD55'te korunur, yeni extractor deneyi diye sunulmaz. PB2'deki C0NSENT→CONSENT locator düzeltmesi bulguyu değiştirmeyen tarihsel atıf düzeltmesidir. Catalogue, concurrency, read-call ve DNS kayıtları yayın/erişim tarihidir; bugünkü target davranışına veya kontrol talimatına dönüştürülmez. Tarihli web discovery, versioned source'u current v2 davranışıyla değiştirmez.

## 10. İlişki görünümü ve yorum izi

Kurulum/kullanım zinciri: **request/module selection → adapter precheck/root → somut copy/transform planı → apply/digest/state → post-apply cleanup ve host config/dependency/loading yolları → callback/tool consumer**. Cleanup ile host yüklemenin tek senkron transaction olduğu veya bu özetin her dağıtım için tek zaman çizelgesi kurduğu iddia edilmez. Dosyanın yazılması, yerinde kalması, doğru entry'nin seçilmesi ve consumer etkisi ayrı geçişlerdir.

Consent zinciri: **--no-hooks → declined → classifier → sınıflandırılmış operasyonların kaldırılması**. OD32, classifier kapsamının dışında kalan bir automatic callback kaynağını gösterir; gerçek kontrollerin tümünün yokluğu değildir. OD35/OD36 file-origin tekilleştirmesi ile OD37 export tekilleştirmesi farklı kimlik alanlarında çalışır. OD54/OD55'te doğru path/hash, doğru lifecycle rolü yerine geçmez.

Araçların kanıt türü korunur: dependency inventory; test/format/lint command recommendation; mevcut coverage report comparison; gerçek Git query implementation; bounded security scan. Bu türler tek success/PASS hükmünde birleştirilmez. Eksik uygulanmış analiz sonucundaki sıfır ile ölçülmüş sıfır; boş başarılı status ile hatadan üretilmiş boş metin ayrıca ayrıdır.

**B1 ve önceki kayıtlarla bağ:** OC82–OC87'nin preparation sorusu OD13 ile actual caller'a bağlanır; daha güçlü import/host conformance otomatik oluşmaz. OC88–OC92'nin açık materializer/package yolu OD01–OD25 ile ayrıntılanır. OC07 barrel, OD35–OD38'in ayrı origin'lerden gelen factory örneğine katılır. OC46'nın çalışan after-hook'u OD32/OD38 için anlamlı conditional consumer'dır; OC21/OC24 callback replacement bulgusu değişmez. OC11'in sadece registration düzeyindeki dependency-analyzer işareti OD61–OD69 ile implementation anlamına kavuşur; OC10 iki araçlık plugin map'i sekiz araçlık katalog sayılmaz. EP11/EP12 stored config/execution identity ayrımı OD24/OD25'teki host-sonrası değişiklikle ilişkili olsa da aynı mekanizma değildir.

Taslak kaynak-kayıt kontrolünde materialization filtresi ile .npmignore, ayrıca success:true alanı ile öneri metni ayrı adreslendi: OD17/OD90 ve OD65/OD91. İlk remote yayından önce yapılan bu açıklık, eski bir repository kaydının düzeltmesi veya yeni ürün bulgusu değildir.

Bu okumada önceki TERMS metinlerini değiştirmeyi gerektiren maddi çelişki saptanmadı. B1'in tarihsel açık source işi B2'nin mevcut cevabıyla bağlandı; B1 kayıtları geriye dönük değiştirilmedi. Yeni source-local bilgi, önceki read kapsamını genişletilmiş gibi göstermez. Genel kavram kararı veya B8 eş anlamlılık kabulü yapılmadı.

## 11. Kapanış ve açık sınır

**ECC-OD01–OD91**, 91 adreslenebilir kullanım/ilişki kaydıdır; bağımsız kavram/kanıt veya ilerleme yüzdesi değildir. Yeni dosya, dört mevcut B2 research dosyasının aktarımıdır. B1+bu B2 aktarımı Concepts'te U12-B kaynak ailesini kapsar; final yayın/readback/current durum ayrıca doğrulanır. C5c'nin U12-C/E09 işi, C6 ve B7/B8 açık kalır.

Q02b3 actual builds/tarballs/registry, host/Node/Bun/platform, active consent/dedup/cleanup/cache/concurrency, dependency/capture/tool-evidence ve accepted outcomes sınırlarını; Q03c daha geniş installer ownership/repair sorularını korur. Bunlar otomatik yeni Concepts deney borcu veya SOUL gereksinimi değildir. Yeni build/test/install/npm pack, SQL fixture, live host/model/provider, kullanıcı-home mutation veya upstream patch yapılmadı. E06 excluded; E04/E07/E08/E09 ve iki E05 geçmişi kendi kapsamlarında kalır.

Batu okuma anındaki anlam seçimlerini denetleyemediği için önemli dayanak, yorum ve belirsizlikler izlenebilir olmalıdır. Ortak sözcükler ortak anlamı garanti etmez; kaynağın kullanımı, araştırmacı/extractor yorumu ve kullanıcı onayı birbirinin teknik doğrulaması değildir.

Exact next: **C5c / U12-C — Note27 Python provider selection/tool round-trips ve mevcut E09 kanıtının aktarımı**. Bu kaynakların gövdeleri bu B2 turunda okunmadı veya deneyleri yeniden çalıştırılmadı.
