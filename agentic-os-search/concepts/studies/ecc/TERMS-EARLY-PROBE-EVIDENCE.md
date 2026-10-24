# ECC — Erken deney düzeneği ve kanıt kullanımları

2026-09-23 · **C6b / E01–E05 driver ve ham-kanıt okuması tamamlandı; iki E05 kimliği ayrı tutuldu. C6 ve ECC Concepts paketi PARTIAL.**

Bu dosya mevcut araştırmanın deney betiklerinde ve kayıtlarında kullanılan ifadeleri taşır; ECC ürününde yeni bir modül keşfi veya yeni deney değildir. PE kimlikleri araştırma düzeneğinin kullanımlarını adresler. Ürün kullanımları mevcut S/W/L kayıtlarında korunur. [READING](READING.md) dosya/sürüm hesabını, [TERMS](TERMS.md) kullanım girişini, [global STATE](../../STATE.md) güncel işi taşır.

## 1. Kaynak ve roller

Okuma snapshot'ı: **batuhanozgun/agentic-os-search@7ce22d478071be0863e7677bae280e2d648736d6**. Araştırmanın ayrı upstream hedefi: **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Bu tur upstream modülleri edinilmedi, import edilmedi veya çalıştırılmadı. Aşağıdaki araştırma dosyaları doğrudan tam okundu:

| Anahtar | Kaynak ailesi / dört dosya |
|---|---|
| D1/P1/R1/A1 | [E01 betik](../../../research/studies/ecc/evidence/u01-a-cache-probe/run-cache-probe.py), [plan](../../../research/studies/ecc/evidence/u01-a-cache-probe/PROBE-PLAN.json), [sonuç](../../../research/studies/ecc/evidence/u01-a-cache-probe/RESULTS.json), [README](../../../research/studies/ecc/evidence/u01-a-cache-probe/README.md) |
| D2/P2/R2/A2 | [E02 betik](../../../research/studies/ecc/evidence/u03-a-work-item-probe/run-probe.js), [plan](../../../research/studies/ecc/evidence/u03-a-work-item-probe/PROBE-PLAN.json), [sonuç](../../../research/studies/ecc/evidence/u03-a-work-item-probe/RESULTS.json), [README](../../../research/studies/ecc/evidence/u03-a-work-item-probe/README.md) |
| D3/P3/R3/A3 | [E03 betik](../../../research/studies/ecc/evidence/u03-b-worker-probe/run-probe.py), [plan](../../../research/studies/ecc/evidence/u03-b-worker-probe/PROBE-PLAN.json), [sonuç](../../../research/studies/ecc/evidence/u03-b-worker-probe/RESULTS.json), [README](../../../research/studies/ecc/evidence/u03-b-worker-probe/README.md) |
| D4/P4/R4/A4 | [E04 betik](../../../research/studies/ecc/evidence/u05-b-evaluation-probe/probe.cjs), [plan](../../../research/studies/ecc/evidence/u05-b-evaluation-probe/PLAN.md), [lossless gzip sonuç](../../../research/studies/ecc/evidence/u05-b-evaluation-probe/results.json.gz), [README](../../../research/studies/ecc/evidence/u05-b-evaluation-probe/README.md) |
| D5N/P5N/R5N/A5N | [Node E05 betik](../../../research/studies/ecc/evidence/u06-a-config-probe/probe.cjs), [plan](../../../research/studies/ecc/evidence/u06-a-config-probe/PLAN.md), [lossless XZ sonuç](../../../research/studies/ecc/evidence/u06-a-config-probe/results.json.xz), [README](../../../research/studies/ecc/evidence/u06-a-config-probe/README.md) |
| D5C/P5C/R5C/A5C | [conversation-E05 reconciliation](../../../research/studies/ecc/evidence/u06-a-conversation-record/README.md) + exact [tar.xz](../../../research/studies/ecc/evidence/u06-a-conversation-record/original-evidence.tar.xz) içindeki probe.py/PLAN.md/results.json/README.md/stderr.txt; bunlar repo'da ayrı leaves değildir |

Göreli bağlantı güncel dosyaya gider; okunmuş içerik snapshot ve READING'deki blob ile sabittir. D = incelenen araştırma driver'ı; P = kayıtlı deney planı; R = kayıtlı ham sonuç; A = araştırmacının açıklama metni. D5C/P5C/R5C/A5C exact archive-member recovery'dir; yeni execution değildir. Türkçe açıklamalar yeni extractor yorumudur. Betik kodu, plan, sonuç ve README dört bağımsız deney değildir. S/W dosyaları da tam okunarak aşağıdaki kaynak noktalarıyla karşılaştırıldı.

## 2. Kaynak kimliği, fixture ve başarı ölçütü

| Kullanım | Bu bağlamdaki anlam ve sınır | Dayanak |
|---|---|---|
| ECC-PE01 — `git_blob / gitBlob / source identity guard` | Üç driver, yürütmeye verilecek upstream dosyaların baytlarını Git blob çerçevesiyle hash'leyip sabit kimlikle karşılaştırır; farklıysa hedef çağrısından önce reddeder. Bu, seçilmiş dosya kimliğidir; bütün bağımlılıkların veya deneyin bilimsel geçerliliğinin doğrulanması değildir. | D1 main/source döngüsü; D2 main/assert; D3 main/SOURCES döngüsü |
| ECC-PE02 — `presence-only baseline` | E01 C0; boş skills dizini, dummy içerikler ve yalnız version taşıyan sentetik kök package.json ile referansların varlık/tür yüzeyini sınar. Kabul edilmesi geçerli kurulmuş cache veya çalışır hook anlamına gelmez. | D1 fixture_notes ve dosya kurulumu; P1 C0; R1 C0; A1 Execution |
| ECC-PE03 — `expected_exit_from_source` | Kaynak incelemesinden beklenen checker process kodu. C1 için 0 öngörülmesi, eksik hook'un kabul edilmesini istenen güvence yapmaz. | P1 C0–C2; D1 observed; R1 cases |
| ECC-PE04 — `integrity_criterion` | P1'de tam referans-varlığı denetiminden beklenen normatif karşılık. C1 eksik referansla reddedilmelidir; bu alan checker'ın kendi uyguladığı kural değildir. | P1 C1; A1 Target and hypothesis |
| ECC-PE05 — `matches_source_prediction` | E01'de gözlenen exit ile PE03'ün eşitliğidir. Eksik hook'u kaçıran C1 için de true olur; bütünlük güvencesinin karşılandığı anlamına gelmez. | D1 observed ve son koşul; R1 C1; PE03/PE04 |

## 3. Store double ve gözlem kapsamı

| Kullanım | Bu bağlamdaki anlam ve sınır | Dayanak |
|---|---|---|
| ECC-PE06 — `fakeStore` | E02'de list/get/upsert işlemlerini kopyalanmış bellek içi kartlarla sağlayan deney bileşeni. Gerçek helper çalışmasına veri sağlar; SQLite, foreign key, authentication veya concurrent writer uygulaması değildir. | D2 fakeStore; P2 environment; A2 |
| ECC-PE07 — `newest-first input order` | E02 C5'te giriş dizisinin sırası yeni-kayıt-önce sorgu sonucunu temsil eder; double yalnız slice(0, limit) döndürür. Gerçek SQL sıralama veya pagination çalıştırılmış değildir. | D2 fakeStore/listWorkItems ve C5; R2 C5 |
| ECC-PE08 — `calls` | Double'ın list/get çağrılarını ve limit/id argümanlarını kaydeden iz. Helper'ın hangi veriyi istediğini gösterir; kullanıcıdaki veritabanı erişim günlüğü değildir. | D2 fakeStore; R2 cases.observation.calls |
| ECC-PE09 — `writes` | Double'ın upsert ile aldığı nesnelerin kopyaları. C3'te boş kalması bu ret yolunda store yazısının olmadığını gösterir; SQL commit, kalıcılık veya sistem genelinde etkisizlik değildir. | D2 upsertWorkItem ve C3; R2 C3 |
| ECC-PE10 — `criterionMatched / expectationMatched / matched` | E02'de assertion'ın hata vermemesi; E03'te ortak status/exit + vaka extra koşulu; E04'te check callback'i; Node/Python E05'te driver-local exit/stdout/stderr kontrollerinin uyuşması. Aynı aile etiketi farklı dar oracle'ları niteliyor; ürün güvenliği veya bütün kaydedilmiş alanların otomatik doğrulanması değildir. | D2–D5; R2–R5 cases |

## 4. Sahte sağlayıcı, process ve plan kaydı

| Kullanım | Bu bağlamdaki anlam ve sınır | Dayanak |
|---|---|---|
| ECC-PE11 — `deterministic fake codex` | E03'te PATH'in önüne konan, stdin/argv kaydedip belirtilmiş çıktı dosyasını ve exit kodunu üreten araştırmacı programı. Codex reasoning, seçenek geçerliliği, sandbox veya araç yetkisini emüle etmez. Gerçek Bash/Node/Git işlemleriyle aynı kanıt rolünde değildir. | D3 fake.write_text ve env; A3 What actually ran |
| ECC-PE12 — `fakeCall` | Sahte programın aldığı argümanlar ve prompt'un kaydı; missing-task C4'te null. Model adı veya kısıt cümlesinin bu kayıtta bulunması gerçek sağlayıcının bunları kabul ettiği/uyguladığı anlamına gelmez. | D3 log/fakeInvoked; R3 C0–C4 |
| ECC-PE13 — `wrapperExit` | E03'te Bash wrapper process'inin çıkış kodu; fake provider'ın koduyla aynı alan değildir. C3'te fakeExit=7 iken wrapperExit=1; failed status, ham handoff ve stderr ayrıca okunur. | D3 process.returncode; P3 C3; R3 C3 |
| ECC-PE14 — `planSha256 / plan_sha256` | E01/E03/E04/E05 kayıtlarında plan baytlarının özeti. İçerik kimliğini kaydeder; driver'ın planın bütün koşullarını executable oracle olarak tükettiğini veya planın kronolojisini tek başına kanıtlamaz. E02 plan hash'i README/publication yüzeyinde tutulur. | D1/D3/D4/D5; R1/R3/R4/R5; A2 |
| ECC-PE15 — `planUnchanged` | E03 driver'ın çalışma başı ve sonunda plan dosyası baytlarını eşit bulması. Vaka specifications ve check'ler driver'da ayrıca yazılıdır; unchanged=true bunların plana semantik eşliğini sınamaz. | D3 specifications ve result; R3 planUnchanged |
| ECC-PE16 — `tempFilesAfterWrapper` | E03'te her wrapper çağrısı sonrası özel TMPDIR'in çocuk adları. Beş kayıt boş liste taşır; bütün filesystem veya üretilmiş handoff/status'un silindiği, hiç etki oluşmadığı ya da crash recovery'nin sınandığı anlamına gelmez. | D3 temp.iterdir; R3 C0–C4 |
| ECC-PE17 — `criteriaMatched / expectationsMatched` | Driver-local PE10 kontrollerinin toplamı. E02=6, E03=5, E04=9, main-path E05=15 ve conversation-E05=16 matching case kaydeder. Bağımsız tekrar sayısı, güvenlik/kalite başarı oranı veya product acceptance skoru değildir. | D2–D5; R2–R5; A1–A5 |

## 5. Vaka → mevcut kullanım ve yeni açıklık

| Kayıtlı vaka | Karşılaştırılan kullanım | Kontrol sonucu |
|---|---|---|
| E01 C0 | S12/S14; PE01/PE02 | Seçilmiş referans varlığı ile çalışır içerik ayrımı korunuyor. |
| E01 C1 | S13/S14; PE03–PE05 | Eksik hook ve exit0 birlikte; prediction match, istenen bütünlük değildir. |
| E01 C2 | S12/S14 | Eksik MCP gerçek olumsuz kontrol; checker her durumda kör diye genellenmiyor. |
| E02 C0 | W01/W02/W05; PE06/PE09 | Owner/running değişimi ve bir double yazısı; çalışan agent kanıtı değil. |
| E02 C1 | W07/W11 | Blocked kart seçilip running olur; blockedBy örnek metadata olarak zaten doğru sınırlanmış. |
| E02 C2 | W03/W06 | Explicit owner değişimi ve eski session linkinin korunması; concurrent yarış koşulmuş değil. |
| E02 C3 | W05/W06; PE09 | Already-done reddi ve sıfır double yazısı olumlu sınır olarak korunuyor. |
| E02 C4 | W09/W10 | Ready lane'e taşımak open yapar; owner/session kalır; bağımsız karar veya yeni process yok. |
| E02 C5 | W07/W08; PE07/PE08 | Limit100 dışındaki critical seçilmez; array düzeni gerçek SQL testi sayılmıyor. |
| E03 C0 | W42–W45/W47/W48/W50 | Exact heading/bullet içerik ayrıştırılıyor; successful-report metni fake tarafından sağlanmış. |
| E03 C1 | W45/W50/W51 | Completed ile failed-verification metni birlikte; parser negatif metni koruyor. |
| E03 C2 | W47–W49/W51 | Ham numbered/prose metin kalır; üç parsed array boş; boşluk risksiz iş demek değil. |
| E03 C3 | W46/W52; PE13/PE16 | Failed/generic handoff, kaybolan partial final output ve korunmuş stderr ayrı. |
| E03 C4 | W46; PE12 | Eksik task ile fake çağrılmadan ret. Mesajdaki unreadable sözcüğü ayrı unreadable-file vakası koşulduğunu göstermiyor. |

P1/P2/P3'ün tüm vaka açıklamaları, driver fixture/çağrı/check gövdeleri ve R1/R2/R3'ün bütün raw alanları karşılaştırıldı. Kayıtlı 3/6/5 vaka örtüşmeleri sonuç okumasıdır; bu tur assertions yeniden koşturulmadı. E03'te C0'ın otomatik extra koşulu validation alanını sınarken diğer parsed alanlar raw kayıtta ayrıca görülebiliyor. Kayıt kapsamı ile otomatik assertion kapsamı eşitlenmedi.

Plan tüketimi farklıdır: D1 plan cases dizisini okur ve expected exit kullanır; D2 plan dosyasını çalıştırmada okumaz, koşullar kodda yer alır; D3 planı hash/eşlik için okur fakat specifications/check'leri ayrı kodlar. Bu fark planların yanlış olduğu sonucu değildir; source-to-record karşılaştırmasının neden yalnız hash veya toplam PASS sayısından oluşamayacağını açıklar.

## 6. E04/E05 ham kayıt ve recovery kullanımları

| Kullanım | Bu bağlamdaki anlam ve sınır | Dayanak |
|---|---|---|
| ECC-PE18 — `source_before / source_after / sourcesUnchanged` | E04 ve iki E05 driver'ında seçilmiş upstream file blob/hash kimliklerinin run öncesi/sonrası aynı kalması. | Seçilmiş source bytes'ın driver tarafından değişmediğini gösterir; bütün dependency/environment closure'ını veya bilimsel geçerliliği doğrulamaz. D4/D5, R4/R5. |
| ECC-PE19 — synthetic outcome fixture | E04'te success/failure, task, variant ve amendmentId alanlarını araştırmacı fixture'ı üretir. | Evaluator gerçek helper'dır fakat input outcome'ları bağımsız task oracle'ından gelmez. D4 record/base/amended; P4; R4. |
| ECC-PE20 — exact compressed stdout carrier | E04 `results.json.gz` ve Node E05 `results.json.xz`, tarihsel stdout'un lossless compressed carrier'larıdır. | Compression yeni run veya semantic validation değildir; hash/decompression correspondence raw record identity sağlar. R4/R5N, A4/A5N. |
| ECC-PE21 — decoded result identity | E04 gzip 29,810-byte JSON SHA-256 `38c73a…`; Node E05 XZ 1,065,861-byte JSON SHA-256 `a63c2e…`; C6b read-only decode bunlarla eşleşti. | Decompression/readback historical execution'ı reperform etmez ve timestamp'i bağımsız authenticate etmez. |
| ECC-PE22 — E05 oracle triple | E05 case oracle'ı expected exit + stdout formu + case-specific stderr condition'ından oluşur. | Üç koşulun match'i host enforcement, filesystem effect veya bütün güvenlik özelliklerini doğrulamaz. D5N/D5C; P5N/P5C. |
| ECC-PE23 — fixture invariant | Protected fixture bytes'ın unchanged kalması, allowed new path'in absent kalması ve conversation E05'te dangling symlink'in korunması gibi post-run checks. | Probe'un proposed Write/Edit'i uygulamadığını destekler; tüm filesystem/process side effects yokluğu değildir. R5N/R5C. |
| ECC-PE24 — `aliasIdentity` | Node E05 alias ve protected path'in aynı realpath/inode'a işaret ettiğini fixture düzeyinde kaydeder. | Guard'ın alias üzerinden gerçek host write'ını kabul ettiği veya object-level bypass yaşandığı anlamına gelmez. D5N/R5N; L62. |
| ECC-PE25 — oversized input recipe | Conversation E05, >1MiB input'u tam raw string yerine deterministic generation recipe + byte count + SHA-256 ile temsil eder. | Lossless reconstruction için evidence formatıdır; runner'ın input'u eksiksiz işlediği anlamına gelmez. D5C/R5C. |
| ECC-PE26 — shared-source / distinct-campaign identity | Main-path Node E05 ile conversation Python E05 aynı dört pinned upstream blob'a bağlanır fakat driver, plan, case seti, timestamp ve result identity'si ayrıdır. | Aynı kaynak closure'ı bunları aynı experiment veya bağımsız replication yapmaz. A5C; R5N/R5C. |
| ECC-PE27 — case-local ID | `C05` gibi case IDs campaign-local'dır: Node E05 C05 alias symlink iken conversation E05 C05 pyproject exclusion'dır. | Case numarası campaign qualifier olmadan stable semantic identifier değildir. P5N/P5C. |
| ECC-PE28 — main-path E05 identity | Node `probe.cjs`, 15 case, 04:48:43Z run, XZ raw stdout identity. | Conversation-E05'nin 16 case setiyle pool edilmez. D5N/R5N/A5N. |
| ECC-PE29 — conversation-bundle E05 identity | Python `probe.py`, 16 case, 04:49:24Z run; five-member recovered archive içindeki results identity. | Main-path E05'nin continuation'ı veya ek 16 independent trials değildir. D5C/R5C/A5C. |
| ECC-PE30 — re-containerized historical archive | `original-evidence.tar.xz`, conversation attachment'taki beş experiment member'ı değişmeden yeniden containerize eden recovery artifact. | Original outer ZIP'in tamamı veya yeni research execution değildir. A5C. |
| ECC-PE31 — archive member correspondence | PLAN/README/probe/results/stderr member size ve SHA-256'larının reconciliation record'la eşleşmesi. | Member integrity/correspondence, historical runtime environment veya result truth'un bağımsız doğrulaması değildir. R5C/A5C. |
| ECC-PE32 — campaign stderr vs child stderr | Conversation E05 `stderr.txt` campaign-level boşken case results içindeki child stderr block/diagnostic metinlerini taşıyabilir. | “stderr empty” bütün nested processes diagnostic üretmedi demek değildir. R5C. |
| ECC-PE33 — plan-as-record vs executable criterion source | E04 ve E05 driver'ları plan hash'ini kaydeder fakat vaka/check definitions driver code'da ayrıca bulunur; E01 bunun tersine plan cases'ini runtime'da okur. | Prospective plan yararsız değildir; yalnız plan hash'inden semantic criterion execution sonucu çıkarılmaz. D1/D4/D5; PE14. |
| ECC-PE34 — read-only evidence recovery | C6b'de gzip/XZ/tar-XZ bytes exact Git blob kimliği üzerinden decode edildi, JSON/archive members okundu, driver veya target code yeniden koşulmadı. | Recovery yeni evidence campaign veya independent replication değildir. |

## 7. E04/E05 vaka ve L-kayıt etkisi

**E04:** C00–C08 raw JSON; L45–L55 ve L46'nın single-failure/repeated-rationale sınırıyla uyumlu. Duplicate observation ID, unmatched task labels, optional amendment selector ve one-failure proposal raw kayıtta görünür. Yeni driver okuması `PLAN.md` içeriğini runtime oracle olarak tüketmiyor; yalnız hash'ini kaydediyor. E04 ürün-kullanım kayıtlarını değiştirmeyi gerektiren maddi çelişki göstermedi.

**Main-path Node E05:** C00–C14 raw stdout/stderr ve source/fixture fields okundu. L58–L68'in mevcut çekirdeği korunur; C6b raw/source karşılaştırmasıyla L105–L114 eklendi. Özellikle alias target identity, ENOTDIR, non-string path exception, profile/hook selection ve same-content refusal daha açık adreslendi.

**Conversation E05:** C00–C15 archive member'larından tam okundu. Main-path ile ortak source blobs korunur fakat C05 ve sonraki case mapping aynı değildir. Multipurpose pyproject, oversized/minimal interaction, hook-ID exclusion, managed-disabled + explicit-enabled override ve invalid-profile fallback L refinements'ini destekler. İki E05'nin case sayıları toplanmaz ve duplicate evidence gibi “31 test” oluşturulmaz.

## 8. Yorum izi ve sınır

Bu tam okumalar S12–S14, W01–W11 ve W42–W52'nin temel anlamını değiştirmeyi gerektiren maddi çelişki göstermedi. W11 zaten blockedBy'nin deney metadata'sı olduğunu söylüyordu; bu tur eski hata düzeltilmiş gibi raporlanmıyor. S/W metinleri korunmuştur. W37/W39 setup/rollback, W53–W55 canlı pane/liveness ve diğer memory/SQL iddiaları E03/E02 tarafından doğrulanmış gibi genişletilmedi.

Yeni PE kayıtları, önceden ayrı kullanım adresi verilmeyen araştırma-düzeneği ifadelerini görünür kılar. Düzeltme, C6a'daki üç betiğin FULL okuma açığının kapanmasıdır; ilk araştırma sonuçlarını yeniden üretme veya 15 TERMS dosyasının tamamını doğrulama değildir. Kaynak betiklerindeki kimlik kontrolleri bu tur yürütülmedi; görülen kod ile tarihsel sonucu karşılaştırdık. Gerçek upstream bytes/SDK/host kabulünü ayrıca sertifikalamadık.

C6a'nın U/R açıklarının E01–E05 driver'ları ve üç kullanılabilir compressed E04/E05 taşıyıcısı bu kapsamda kapanır; E06 excluded, iki E05 ve E07/E08/E09/E10 ayrı kalır. E10'un güncel recovery yönlendirmesi yalnız source-context olarak görüldü, burada uygulanmadı. Kök/history/inventory, U13 ve sonraki kaynak delta'sı ile paket-geneli semantik kontrol hâlâ C6 işidir.

Batu okuma anındaki anlam seçimlerini denetleyemediği için dayanak ve sınırlar görünür tutulur. Ortak sözcükler ortak anlamı garanti etmez; özellikle prediction, criterion, plan, success ve completed etiketleri ilgili nesne/ölçütle okunur. Kaynak, araştırmacı/extractor yorumu ve kullanıcı onayı teknik doğrulama bakımından ayrı kalır.
