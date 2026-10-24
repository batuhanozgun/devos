# ECC — Native review, çağıran taraf ve karar kullanımları

2026-09-20 · **B6-T17-C5b / U11-A CONTEXTUAL TRANSFER / C5b-PARTIAL**.

Bu kayıt yalnız Note19/U11-A araştırmasının kullanımlarını çıkarır. Ortak sözlük, yeni review deneyi, kurulu ürün doğrulaması veya mimari karar değildir. [READING.md](READING.md) gerçek okumayı ve yayın durumunu, [TERMS.md](TERMS.md) paket girişini, [global STATE](../../STATE.md) sonraki işi taşır. Dosyanın varlığı U11-B–E veya C5'in tamamlandığı anlamına gelmez.

## 1. Sabit kaynak ve atıf rolleri

Research repository: batuhanozgun/agentic-os-search; bu aktarımın snapshot'ı **0d9430bb2854f72b9861e37802427cafec4c1e74**. Araştırmanın ayrı upstream pin'i **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Bu tur upstream workflow/host/gh kaynakları yeniden okunmadı veya çalıştırılmadı. Araştırma metinleri ve depodaki E08 kanıtı okundu; eski kaynak incelemesi yeni Concepts kaynak incelemesi diye sunulmaz.

| Anahtar | Kaynak | Git blob / kimlik |
|---|---|---|
| N19 | [Note19](../../../research/studies/ecc/notes/19-NATIVE-REVIEW-CALLER-AND-DECISION-BOUNDARIES.md) | 5e9f7a923896a377882e7cb5fb0857fb3804b8cf |
| LA | [U11-A source ledger](../../../research/studies/ecc/evidence/U11-A-SOURCES.md) | 0cff0640065f6343131f361645659d996f90d77c |
| MA | [ROUND-U11-A / MR20](../../../research/studies/ecc/ROUND-U11-A.md) | 316ab5f0e07575b35bcb7ff81dce0b990c871340 |
| PA | [PUBLICATION-U11-A](../../../research/studies/ecc/PUBLICATION-U11-A.md) | cba526815e9d9f8803da50a9349fceda89f43957 |
| ER | [E08 README](../../../research/studies/ecc/evidence/u11-a-review-flow-probe/README.md) | 2edb53a5c12ddbc03f5671bead55cb3cde82dce0 |
| EP | [E08 PRECHECK](../../../research/studies/ecc/evidence/u11-a-review-flow-probe/PRECHECK.md) | 42f3365fc14a8b8f83312352ab0039a43c9ca9f1 |
| EC | [E08 probe.cjs](../../../research/studies/ecc/evidence/u11-a-review-flow-probe/probe.cjs) | 289e2159c9ab5864bbaa8955e5eb95be3ff7ca89 |
| D | ER'deki dört part'tan çözülen run + schema_check JSON | SHA-256 45d8c8f409d51d0c7e01dd63168b833dffd86a9ced844deb700472bba4874f9e; 101725 bayt |

LA içindeki S167 workflow, S23 README, U11A-01 command, U11A-02 pipeline skill, U11A-03/04 feature wrapper, U11A-05 reviewer, U11A-06/07 plugin/package kimlikleri özgün araştırmanın kaynaklarıdır.

Rol anahtarı: **K** araştırmacının pinned koddan raporladığı kullanım/predicate; **P** hedefteki yorumlanacak prosedür; **B** hedef belge beyanı; **Y** araştırma yazarının analizi/koşullu karşı-örneği; **H** araştırmada 2026-09-19 tarihinde aktarılan host/gh dokümanı; **D** bu tur doğrudan okunan saklanmış E08 girdisi/çıktısı; **F** test adaptörü/fixture tanımı. Türkçe açıklamalar extractor paraphrase'idir; doğrudan hedef alıntısı veya bağımsız teknik doğrulama değildir. Birden çok rol varsa olgu ile çıkarımın kanıt sınırı açıklamada korunur.

## 2. Prosedür, betik ve host

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N01 — native review pilot | Review ve verification segmentini yürüten betik. Research–Plan–Implement–Review–Commit bütününün zaten bağlı yürütme grafiği değildir. | N19 §1; LA outer decision / K/B/Y |
| ECC-N02 — /orch-review | Local değişiklik veya PR girdisi toplayıp Workflow çağırmayı, sonucu raporlamayı tarif eden command. Metnin varlığı host'un uyguladığını kanıtlamaz. | N19 §1–2; LA U11A-01 / P |
| ECC-N03 — /orch-add-feature | Kendi operation skill'i üzerinden shared pipeline'a giden temsili feature command/wrapper yolu. Native review script'ine otomatik bağlandığı kabul edilmez. | N19 §1; LA U11A-03/04 / P |
| ECC-N04 — orch-pipeline | Faz seçimi, plan/uygulama/review ve insan kararlarını tarif eden ortak skill. Source-native prosedürdür; çalıştırılmış native pipeline değildir. | N19 §1, §7; LA U11A-02 / P |
| ECC-N05 — Phase5 review | Shared skill'de ordinary code-reviewer veya /code-review adı verilen review aşaması. Ayrı /orch-review komutuyla aynı çağrı yolu sayılmaz. | N19 §1; LA outer decision / P |
| ECC-N06 — interpreted command / skill | Host'un okuyup uygulaması beklenen yönerge yüzeyi. Çalıştırılabilir betik, mekanik Git gate'i veya uygulanmış davranış değildir. | N19 §1, §7; LA U11A-01/02 / P/Y |
| ECC-N07 — external Workflow host | Globals, agent çağrısı, izin ve continuation sağlayan dış yürütme ortamı. ECC dosyasının bulunması kurulum/API uyumunu göstermiyor. | N19 §1, §7; LA W-U11A-HOST / H/Y |
| ECC-N08 — args / supplied review request | Betiğe verilen diff, language ve changedFiles girdisi. Repository/commit veya onaya bağlanmış immutable diff kimliği içermesi gösterilmez. | N19 §2; LA request/host; D scenario.input / K/D |

## 3. İnceleme hedefi ve giriş kapsamı

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N09 — local HEAD-relative diff | Prosedürde yerel değişiklikler için toplanan diff görünümü. Sonraki commit'in veya eşzamanlı değişen dosyaların aynı baytları olduğu ayrıca bağlanmalıdır. | N19 §2; LA U11A-01 / P/Y |
| ECC-N10 — changedFiles | Ayrı toplanabilen değişmiş dosya yolları listesi; betik elemanların string olmasını ister. Diff ile tek atomik snapshot olduğu doğrulanmaz. | N19 §2–3; D malformed_paths / K/P/D |
| ECC-N11 — GitHub PR URL | Komutun kabul ettiği, repository ve son PR numarası içeren hedef ifadesi. Gösterilen sonraki gh çağrıları repository kısmını taşımıyor. | N19 §2; LA U11A-01 / P/Y |
| ECC-N12 — numeric PR selector | URL'den çıkarılan veya doğrudan verilen PR numarası. Numara tek başına repository kimliği değildir. | N19 §2; LA request / P/Y |
| ECC-N13 — --repo | Araştırmada aktarılan gh dokümanındaki açık repository seçimi. İncelenen numeric-only komutlara bu argüman eklenmiş sayılmaz. | N19 §2; LA W-U11A-GH-DIFF / H/P |
| ECC-N14 — GH_REPO | Aktarılan gh environment sözleşmesinin ayrı hedef seçimi. Bu tur kullanıcının environment değeri okunmadı ve gerçek yanlış-PR olayı gözlenmedi. | N19 §2; LA W-U11A-GH-ENV / H/Y |
| ECC-N15 — safe argument restriction | PR girdi biçimini ve shell metakarakterlerini sınırlayan prosedür. Shell açısından sınırlama, istenen repository/revision'a bağlanma ile aynı güvence değildir. | N19 §2; LA request / P/Y |
| ECC-N16 — revision binding | İncelenen baytlar ile sonraki karar/commit arasındaki kimlik bağı sorusu. Bu betikte implemented consent token veya digest olarak bulunmuş mekanizma değildir. | N19 §2, §7; LA delivery/continuation / Y |
| ECC-N17 — nonempty diff admission | Betiğin boş olmayan string kabulü. Unified-diff parse/kimlik doğrulaması değildir; plain non-diff fixture reviewer'a ulaşmıştır. | N19 §2; D nonempty_not_a_diff, empty_diff / K/D |
| ECC-N18 — language input | Bilinen etiketle language specialist seçilmesini sağlayan girdi; command dominant language türetebilir, mixed changes için vermeyebilir. Bütün değişikliğin tek dil olduğu sertifikası değildir. | N19 §3; LA host/selection / K/P |

## 4. Seçim, bulgu ve şema

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N19 — quality dimension | Betiğin her durumda seçtiği correctness/quality inceleme ekseni; kayıtta review:quality çağrısı. Her gerekli uzmanlık kapsamını taşımaz. | N19 §3; D options/labels / K/D |
| ECC-N20 — language dimension | Tanınan language için eklenen specialist ekseni; E08'de lang:typescript. Bir eksen bir bağımsız model veya bağımsız delil kaynağı değildir. | N19 §3; D options/labels / K/D/Y |
| ECC-N21 — security trigger | Diff/path metnindeki lexical seçim predicate'i. Seçtiği security dimension ayrı N76 kaydındadır; auth path kontrolü kuralı gösterir, semantic güvenlik recall/precision ölçmez. | N19 §3; D security_path_selects_extra_dimension / K/D/Y |
| ECC-N22 — selected-dimension coverage | Çalıştırılmak üzere seçilmiş eksenlerin kapsaması. Gerçek değişiklik için gerekli bütün eksenlerin seçilmiş olmasıyla eşit değildir. | N19 §3; LA host/selection / Y |
| ECC-N23 — failedDimensions | Null/rejected selected reviewer sonuçlarının dimension/error kayıtları. Blocking finding dizisinden ayrıdır; findings boşken de aggregate ret yaratabilir. | N19 §5; D reviewer_null/reviewer_rejection / K/D |
| ECC-N24 — incomplete | Seçilen review eksenlerindeki failure'lardan türetilen sonuç bayrağı. False olması tüm gerekli eksenlerin incelendiğini veya verifiers'ın tamamlandığını kanıtlamaz. | N19 §3, §5; D verifier_null / K/D/Y |
| ECC-N25 — finding | title, severity, file ve evidence alanları; opsiyonel line/fix ve severity'ye göre koşullu zorunlu proof taşıyan review kaydı. Kayıt, gerçek ve doğrulanmış defect ile aynı şey değildir. | N19 §3–4; D Review schema / K/D/Y |
| ECC-N26 — severity | CRITICAL/HIGH/MEDIUM/LOW önem etiketi; birleşmede daha sıkı etiket korunur. Fiilî impact ölçümü veya proof'un korunduğu anlamına gelmez. | N19 §3–4; D Review schema, merge cases / K/D |
| ECC-N27 — evidence | Finding içindeki offending snippet/exact-location string'i; yakalanan şema minLength=1 ister. Metin eşliği semantic issue kimliği değildir. | N19 §3–4; D Review schema / K/D/Y |
| ECC-N28 — proof | HIGH/CRITICAL için şemanın varlığını istediği string alanı. Yakalanan şemada nonempty/impact doğrulaması yoktur; talimatın somut kanıt istemesi ayrı katmandır. | N19 §3; D Review schema/prompts / K/P/D |
| ECC-N29 — reviewer reporting threshold | Prompt'un yalnız >80% emin olunan sorunları raporlama talimatı. Kalibre edilmiş olasılık, numeric finding field'i veya model uyum ölçümü değildir. | D distinct Review prompts; N19 §3 / P/D/Y |

## 5. Birleştirme ve iddianın korunması

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N30 — dedup key | Ordinary evidence-based yolda file + normalized evidence anahtarı. Line numarasını içermemesi aynı snippet'in farklı yerlerini birleştirebilir; semantic aynı sorun kanıtı değildir. | N19 §4; LA finding composition; D same_snippet_different_locations / K/D/Y |
| ECC-N31 — normalized evidence | Whitespace collapse ve lowercase ile elde edilen eşleştirme metni. Kaynak anlamının veya sorun kimliğinin doğrulanması değildir. | N19 §4; LA S167 / K/Y |
| ECC-N32 — dimension | Finding'in geldiği ilk ekseni taşıyan tekil alan. Birleşmiş kaynak eksenlerinin dimensions listesi ayrı N77 kaydındadır; iki alan aynı nesne değildir. | N19 §4; D merge outcomes / K/D |
| ECC-N33 — severity promotion during merge | Aynı anahtarda daha ağır severity'ye yükseltme. U10 registry promotion veya beceri değişikliği kabulü değildir; burada finding alanı değişir. | N19 §4; D medium_then_critical_same_evidence / K/D/Y |
| ECC-N34 — first-finding field retention | Birleşmede ilk title/proof/fix/location gibi diğer alanların korunması. Sonraki ağır bulgunun gerekçesi seçilmez veya birleştirilmez. | N19 §4; D ordered merge cases / K/D |
| ECC-N35 — proof-preservation boundary | Ayrı ayrı şemaya uygun iki bulgu birleşirken ağır bulgunun proof'unun kaybolabilmesi. E08'de gözlenen bilgi aktarımı sorunudur; gerçek vulnerability miss iddiası değildir. | N19 §4; EP criteria3/4; D ordered merge cases / D/Y |
| ECC-N36 — merged-record validation | Birleşmiş kaydın ayrıca şemadan geçirilmesi sorusu. İncelenen betik bunu yapmıyor; ilk yanıtların geçmesi birleşik kaydın geçmesini sağlamıyor. Yeni kontrol eklenmedi. | N19 §4; LA finding composition; D schema_check / K/D/Y |
| ECC-N37 — raw finding count | Birleşme öncesi sağlanan bulgu sayısı. Bağımsız hata, trial veya olay sayısı değildir. | D outcome.stats.raw; N19 §4 / D/Y |
| ECC-N38 — unique finding count | Dedup sonrası kalan kayıt sayısı. Semantic olarak ayrı gerçek kusur sayısı veya tam kapsam ölçütü değildir. | D outcome.stats.unique; N19 §4 / D/Y |
| ECC-N39 — reviewer verdict | Tek reviewer yanıtının APPROVE/CHANGES_REQUESTED alanı. Native aggregate bunu vote olarak taşımayıp findings/failures üzerinden yeniden karar verir. | N19 §6; D reviewer_negative_verdict_empty_findings / K/D |

## 6. Verifier, sonuç etiketleri ve failure

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N40 — adversarial verifier | Ağır finding'i supplied diff karşısında sorgulayan ayrı çağrı/prompt rolü. Ayrı model veya epistemik bağımsızlık zorlanmış değildir; rol adı bunu kanıtlamaz. | N19 §3, §6; D Verify prompts/options / K/P/D/Y |
| ECC-N41 — diff-only evidence scope | Verifier'a yalnız verilen diff ile hükmetme ve unapplied PR dosyası diskte yok diye refute etmeme talimatı. İlk quality reviewer'ın surrounding workspace/caller okumasıyla aynı kanıt kapsamı değildir. | N19 §3; LA U11A-05/S167; D Verify prompts / P/D |
| ECC-N42 — isReal | Verifier yanıtının boolean alanı. Prompt belirsizlikte low-confidence true ister; true her zaman güçlü doğruluk hükmü diye okunamaz. | N19 §6; D Verify schema/prompts, verifier_low_true / K/P/D/Y |
| ECC-N43 — confidence | Verifier'ın 0–1 numeric alanı; false için 0.8 eşiği refutation kararında kullanılır. Sayının varlığı kalibrasyon veya bağımsız ölçüm değildir. | N19 §5–6; D Verify schema/prompts / K/P/D/Y |
| ECC-N44 — unverified | Null/error verifier sonrası korunmuş blocker standing'i. Sonuçta isReal=false/confidence=0 placeholder görülebilir; bu kesin refutation değildir. | N19 §5; D verifier_null/verifier_error / K/D |
| ECC-N45 — uncertain | False fakat confidence<0.8 olan sonucun blocking tutulması ve ilgili sayaç. Bütün epistemik belirsizliği kapsamaz; low-confidence true başka sayaca gider. | N19 §5–6; D verifier_low_false/verifier_low_true / K/D/Y |
| ECC-N46 — confirmed | Unverified olmayan isReal=true sonuçlarının sayıldığı alan. E08 confidence0.2/true için de artırır; kesin doğrulanmış veya kalibre edilmiş bulgu diye çevrilmez. | N19 §6; D verifier_low_true / K/D/Y |
| ECC-N47 — refuted | Yeterince güvenli false sonucu ile advisory'ye indirilen finding standing'i. Fixture'ın stipulated refutation'ı gerçek defect'in çürütüldüğü bağımsız kanıt değildir. | N19 §5; D verifier_confident_false / K/D/Y |
| ECC-N48 — blocking findings | Ağır ve confirmed/unverified/uncertain standing'lerinde korunan sonuç dizisi. Selected reviewer failure'ları ayrıca failedDimensions'tadır; aynı veri nesnesi değildir. | N19 §5–6; D outcomes / K/D |
| ECC-N49 — advisory findings | Sonuçta blocking olmayan, normal düşük/orta bulguları veya verifier'ın refute ettiği ağır bulguları taşıyabilen dizi. Yalnız refuted kayıtlarla eşit değildir. | D distinct_evidence_preserved/verifier_confident_false; N19 §4–5 / D/K |
| ECC-N50 — aggregate APPROVE | Blocking finding ve failed selected dimension kalmadığında betiğin verdiği karar. Her reviewer'ın olumlu oy verdiği, tam review coverage veya kullanıcının commit onayı değildir. | N19 §5–7; D reviewer_negative_verdict_empty_findings / K/D/Y |
| ECC-N51 — aggregate CHANGES_REQUESTED | Blocking bulgular veya failedDimensions nedeniyle dönen sonuç. Native script'in Git değişikliğini mekanik durdurduğu ya da insan kararı verdiği anlamına gelmez. | N19 §5, §7; D reviewer_null / K/D/Y |
| ECC-N52 — no-fallback review instruction | Workflow tool error'ını bildirme ve sessizce el yapımı temiz review'a geçmeme command talimatı. Bu bir prosedür kanıtıdır, host compliance deneyi değildir. | N19 §5; LA U11A-01 / P |
| ECC-N53 — untrusted diff/finding text | Yakalanan prompt'larda analiz nesnesi sayılan, içine gömülü yönergeleri izlememe talimatıyla çevrelenmiş metin. Prompt-injection'a karşı ölçülmüş dayanıklılık değildir; bu dosyanın talimatı da değildir. | D Review/Verify prompts / P/D/Y |
| ECC-N54 — conservative blocking / reporting certainty | Sonucun işlemi durdurması ile rapor etiketinin kanıta dair kesinlik iddiası ayrı sorulardır. Low-confidence true blocking kalırken confirmed sayılabilir. | N19 §6; D verifier_low_true / Y/D |

## 7. İnsan kararı, devam ve dağıtım

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N55 — Gate1 / plan approval | Shared pipeline'ın implementasyondan önce kullanıcıya plan onaylatma yükümlülüğü. İncelenen metinlerde revision-bound consent token veya çalışan approval service değildir. | N19 §7; LA U11A-02 / P/Y |
| ECC-N56 — Gate2 / commit confirmation | Git commit öncesi insan teyidi ve unresolved HIGH/CRITICAL'ların giderilmesi koşulu. Native script APPROVE sonucu bu insan teyidinin yerine geçmez. | N19 §7; LA outer decision / P/Y |
| ECC-N57 — planning-document handoff | Fazlar arasında taşınan plan belgeleri. Belgenin bulunması alıcının aynı revision'ı kullandığını veya kararın kalıcı uygulandığını kanıtlamaz. | N19 §7; LA U11A-02 / P/Y |
| ECC-N58 — task_list | Pipeline handoff'unda adı geçen görev listesi artefaktı. Burada genel task ontology veya durable scheduler kimliği tanımlanmaz. | N19 §7; LA U11A-02 / P, adlandırılmış |
| ECC-N59 — fix-and-re-review loop | Bulgu sonrası düzeltip yeniden değerlendirme sorumluluğu. Native betik kendi başına otomatik fix/commit/interactive approval veya durable approval kaydı üretmez. | N19 §7; LA outer decision / Y/K |
| ECC-N60 — launch permission mode | Araştırmada tarihli host dokümanından aktarılan workflow başlatma izni/prompt koşulu. Bir review sonucunun veya sonraki commit'in insan onayıyla eşit değildir. | N19 §7; LA W-U11A-HOST / H/Y |
| ECC-N61 — same-session resume | Tarihli host sözleşmesinde aynı oturum içindeki workflow devamı. ECC'nin kalıcı review/consent mekanizması diye sunulmaz; bu tur canlı resume denenmedi. | N19 §7; LA W-U11A-HOST / H |
| ECC-N62 — completed start-order prefix replay | Host continuation açıklamasının tamamlanmış başlangıç-sıralı prefix ile sınırlı replay kapsamı. U10 Node tool-response replay ile aynı mekanizma değildir; SDK uyumu ayrıca açıktır. | N19 §7; LA W-U11A-HOST / H/Y |
| ECC-N63 — session-exit restart boundary | Aktarılan host sözleşmesinde oturumdan çıkış sonrasında fresh start. Her host/sürüm için evrensel kayıp veya ECC cross-session recovery kanıtı değildir. | N19 §7; LA W-U11A-HOST / H/Y |
| ECC-N64 — plugin-root workflow discovery | Host'un aktarılan varsayılan dizin keşfi. Manifest'te explicit workflows alanı olmamasından doğrudan unsupported hükmü çıkarmayı engeller; installed discovery ispatı değildir. | N19 §8; LA U11A-06/W-U11A-HOST / H/K/Y |
| ECC-N65 — npm files selection | Package manifest'inin seçtiği dağıtım dosyaları; root workflows listede değildir. Gerçek pack/installation koşulmadı; Git checkout/plugin dağıtımıyla aynı kanal değildir. | N19 §8; LA U11A-07 / K/Y |
| ECC-N66 — scriptPath | Command'ın native workflow dosyasına verdiği literal konum. Her installed-plugin/CWD yerleşiminde doğru çözülmüş path veya kullanılabilir runtime kanıtı değildir. | N19 §8; LA delivery / P/Y |

## 8. E08'in kaynak-içi kanıt ve test dili

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N67 — adapted local execution / E08 | Export-to-const + AsyncFunction ve supplied globals ile pinned body'nin tek tarihsel koşusu; 18 controlled scenario. Native Workflow/model testi veya 18 bağımsız deney değildir. | N19 §9; ER/EP/EC; D run metadata / F/D/Y |
| ECC-N68 — ordered Promise.all adapter | Fixture'ın parallel(thunks) yerine kullandığı sıralı sonuç modeli. Native host completion/result ordering'i doğrulanmış değildir. | N19 §4; EC; D adapter / F/D |
| ECC-N69 — supplied agent reply | Fake agent çağrısına verilen deterministic response/null/rejection. Gerçek model üretimi, gerçek bug veya model kalite ölçümü değildir. | EC run; D calls / F/D |
| ECC-N70 — proof-sensitive fake verifier | Prompt'ta STRONG_PROOF marker'ı var mı sorusuna göre true/false veren kontrol. Dayanağın aktarımını sınar, diff'in semantic doğruluğunu değerlendirmez. | N19 §4; EP criteria4; EC byProof; D ordered cases / F/D |
| ECC-N71 — schema-valid supplied response | Yakalanan source schema'ya Draft7 ile uyan non-null fixture yanıtı. 38 yanıtın geçmesi birleşmiş kaydın, native host'un veya kanıtın doğruluğunu doğrulamaz. | N19 §9; ER; D schema_check / D/Y |
| ECC-N72 — order/key counter-controls | Reversed order, farklı evidence ve farklı file kontrolleri. Birleşme kaynaklı aktarım kaybını her verifier'ın hep başarısız olduğu iddiasından ayırır; gerçek dünya frequency ölçmez. | EP criteria3; D ordered/distinct/different-file cases / F/D/Y |
| ECC-N73 — four-part raw transport | Tek gzip/base64 JSON kaydının dört sıralı parçası. Dört ayrı koşu veya bağımsız destek değildir; whitespace packing semantik veri kopyasıdır. | ER decoding; PA correspondence; D / F/D |
| ECC-N74 — read-only evidence recovery | Mevcut parçaları Git hash ile eşleyip decode etme, stored schema/results'i okuma ve schema check'i tekrarlama. Target betiği yeniden koşmak veya bağımsız bilimsel doğrulama değildir. | ER decoder; bu turdaki D correspondence / D/Y |
| ECC-N75 — publication error / experiment outcome | Tarihsel eksik transport ve etkisiz retry, kanıtın yayın hatasıdır; target senaryosunun başarısız koşusu diye sayılmaz. İlk hata ve düzeltilmiş kayıt ayrı korunur. | MA operational mistakes; PA corrections1/2; ER history / Y |

## 9. Kaynak tarafından kapsam kontrolü

N19 §1 → N01–N08; §2 → N09–N18; §3 → N19–N29/N40–N41/N76; §4 → N30–N38/N67–N72/N77; §5 → N23–N24/N43–N52; §6 → N39–N50/N54; §7 → N55–N63; §8 → N64–N66; §9 → N67–N75 ve aşağıdaki açık sınırlar. LA actual reading/producer-consumer/dates/evidence sınırları, MA araştırma seçimi ve PA yayın düzeltmeleri tam okundu; bunlar birbirinden bağımsız product evidence sayılmadı.

E08'in yedi dosyasının gerçek directory listesi alındı. README, PRECHECK ve probe tam okundu. Dört part'ın yereldeki tam baytları Git blob kimlikleriyle eşleşti; ordered decode 101725 bayt ve ER'deki SHA-256 ile eşleşti. D'nin metadata ve 18 senaryosunun girdileri, bütün replies/errors/logs/outcomes okundu. Tekrarlanan içerikler kaybolmadan 8 farklı prompt, 2 farklı schema ve 6 farklı schema-hariç call-options temsili okunup scenario/call bağlantıları kontrol edildi. schema_check içindeki 38 kayıt okundu; mevcut yanıtlarla Draft7 yeniden kontrolünde 38/38 valid bulundu. Bu read-only content/schema kontrolü yeni E08 koşusu değildir. İlk geniş ekran çıktısında görünmeyen başlık/ilk üç senaryo ve schema kuyruğu daha küçük gösterimlerle tamamlandı; ilk truncated görünüm tam okuma sayılmadı.

E08 prompt'larındaki agentType/phase/label ve güvenlik yönergeleri source-role/actor/observation metadatası olarak korundu. OWASP, TypeScript, gh, JSON Schema, AsyncFunction ve hash adları bu çalışmada genel sözlük araştırmasına dönüştürülmedi. Örnek dosya adları, STRONG_PROOF marker'ı ve fixture patch'i gerçek ürün kusuru gibi kavramlaştırılmadı.

## 10. İlişki, yorum ve karşı-kontrol izi

C4'teki ECC-R13–R18, U07'nin erken review işaretleridir. N serisi bunları U11-A caller/consumer/E08 araştırmasıyla ayrıntılandırır; eski kaynak sınırı geriye dönük yeni kanıtla değiştirilmez. Özellikle failedDimensions ile blocking finding aynı array değildir: reviewer_null sonucunda blocking boşken incomplete=true ve CHANGES_REQUESTED vardır. R16'nın geniş durdurucu standing açıklaması typed blocking dizisinin tanımı olarak kullanılmamalıdır; N23 ve N48–N51 somut ayrımı taşır.

APPROVE sözcüğünün reviewer yanıtı (N39), aggregate sonuç (N50) ve dış insan onayı (N55–N56) kullanımları ayrı adreslendi. Birinin kabulü diğerine yetki vermez. Low-confidence true örneğinde confirmed ile uncertain sayaçları farklıdır; blocker korunuyor diye raporun epistemik anlamı gereğinden güçlü çevrilmedi.

E08 kaydı ile N19 arasında bu tur maddi sonuç çelişkisi saptanmadı. İki açıklık özellikle eklendi: unverified sonuçtaki false/0 placeholder refuted değildir (N44); advisory yalnız refuted dizisi değildir, ordinary MEDIUM da taşıyabilir (N49). Bunlar raw record'daki gözlemlerin aktarımıdır, yeni ürün teşhisi değildir. Birleştirme bulgusu bütün review'u fail-open ilan etmek için kullanılmadı; gerçek null/error/uncertainty guards korunur.

U10'un registry promotion, Node receipt verification ve tool-response replay kullanımları burada severity promotion, verifier çağrısı veya host prefix replay ile eş anlamlı yapılmadı. Kaynaklar arası olası karşılaştırma işaretleri ortak referans veya mimari kabul değildir.

### İlk readback sonrası kayıt ayrımı

İlk yayın 091d7c932da64c474b678dbe249e5785a8bbb520 içinde N21 seçim predicate'i ile seçilen ekseni, N32 ise tekil kaynak alanı ile birleşmiş listeyi aynı ID altında taşıyordu. Anlamlar açıklanmış olsa da ayrı adreslenmiyordu. N21 yalnız trigger'a, N32 yalnız dimension alanına daraltıldı; N76 ve N77 eklendi. N25'te proof'un koşula bağlı zorunluluğu aynı satırda açıklaştırıldı; N28 zaten bu koşulu taşıyordu. N19/N20/N22/N30/N33–N38 ve bölüm-kayıt eşlemesi kontrol edildi; başka kullanım anlamının değişmesi gerekmedi. Bu extractor kayıt düzeltmesidir; yeni ECC bulgusu veya kaynak değişikliği değildir.

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-N76 — security dimension | N21 predicate'i eşleştiğinde seçilen security review ekseni; E08'de review:security ve ecc:security-reviewer çağrı etiketi. Seçim kuralının kendisi değildir ve fiilî security coverage'ı doğrulamaz. | N19 §3; D security_path_selects_extra_dimension options / K/D |
| ECC-N77 — dimensions | Birleşmiş finding'in kaynak eksenlerini tutan liste/birleşim. Tekil dimension alanından ayrıdır; tüm kaynak title/proof/fix/location içeriklerini birleştiren kanıt deposu değildir. | N19 §4; D ordered merge outcomes / K/D |

## 11. Kapanış sınırı

U11-A'nın dört araştırma dosyası ve E08'in yedi mevcut dosyasından source-local aktarım yapılmıştır. Yayın/readback ve local/global current durum ayrıca kapatılır; bu metin kendi sonraki commit'ini veya henüz yapılmamış kontrolü iddia etmez. 77 ID, 77 bağımsız kavram/kanıt veya ilerleme yüzdesi değildir.

Q04h2'nin exact repo/revision/consent, host/API/schema/parallel/permission, installed discovery/pack, semantic dedup/reviewer calibration, gerekli review coverage, live remediation/commit enforcement/cross-session recovery soruları çözülmedi. Kaynağın tanımladığı sınırı korumak, otomatik yeni Concepts deney borcu üretmez. Upstream test, native Workflow, agent/model/provider, gh/PR seçimi, installation, Git commit veya remediation çalıştırılmadı. E04/E07 ve iki E05 geçmişi korunur, E06 excluded kalır. Sıradaki Concepts kaynak ailesi U11-B'dir; U11-B–E/C5c/C6/B7/B8 bu dosyayla yapılmış sayılmaz.
