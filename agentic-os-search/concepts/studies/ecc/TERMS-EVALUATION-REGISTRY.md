# ECC — Recorded evaluation and registry uses

2026-09-20 · B6-T17-C5a · **U10-A CONTEXTUAL TRANSFER / C5 PARTIAL**.

Bu dosya yalnız U10-A / Note17 araştırmasındaki kullanımları taşır. U10-B Node capsule ailesi, U05-B skill evaluator ve U09 session-state yönetimiyle aynı mekanizma sayılmaz. Ortak sözlük, yeni benchmark, ürün doğrulaması veya mimari karar değildir. Güncel Concepts işi [READING.md](READING.md) ve [global STATE](../../STATE.md) içindedir.

## 1. Kaynak ve atıf anahtarı

Research repository snapshot: **753a4c6696740664d359a293ee8d300a45ade6d8**. Araştırmanın incelediği ayrı upstream pin: **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Bu tur upstream kodu/SDK yeniden okunmadı veya çalıştırılmadı; aşağıdaki dört araştırma dosyası tam okundu. Araştırma yazarının kaynak okuma ve test beyanı, Concepts extractor'ın yeni upstream okuması değildir.

- [N17 — Note17](../../../research/studies/ecc/notes/17-RUST-EVALUATION-REGISTRY-AND-USE.md), blob `f7b0101fa995e136e07a42515e4c47900fae3aea`.
- [LA — U10-A source ledger](../../../research/studies/ecc/evidence/U10-A-SOURCES.md), blob `1196baf186518d978222585e97feac38eac196bb`.
- [MA — MR18](../../../research/studies/ecc/ROUND-U10-A.md), blob `bef1db911120e428f5f9037952fd6d43deaa5af9`.
- [PA — Publication receipt](../../../research/studies/ecc/PUBLICATION-U10-A.md), blob `165a7cfd6078224b0ad65e724999c58974205319`.

Sabit kaynaklara dönüş için yukarıdaki yollar aynı repository'nin belirtilen snapshot'ında açılır. LA içindeki S218 = harness_eval.rs; S186 = main.rs; S190 = store.rs; S187/S195 = launcher/config; S219/S220 = sürüme bağlanmış rusqlite kaynağı. Bunlar özgün araştırmanın kaynak kimlikleridir, yeni Concepts kimlikleri değildir.

**Atıf rolleri:** `K` araştırma yazarının pinned koddan raporladığı kullanım/predicate; `B` araştırmada aktarılan hedef belge beyanı; `Y` araştırma yazarının karşılaştırma veya sınır yorumu; `T` yalnız incelenmiş test tasarımı. Bütün Türkçe açıklamalar bu turdaki kaynak-bağlı paraphrase'dir; doğrudan hedef alıntısı veya bağımsız teknik doğrulama değildir. Bir satırdaki K/Y karışımı, mekanizma ile ondan çıkarılan sınırı ayrı tutar.

## 2. Candidate kimliği ve kayıt

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-E01 — recorded-evidence registry | Operatörün sağladığı aday ve ölçüm kayıtlarını karşılaştırıp etkin kayıt seçimini yöneten sistem. Deney üreten veya kendi başına canlı öğrenme yapan sistem diye tanımlanmaz. | N17 §1–2; MA actual source trace / Y |
| ECC-E02 — CandidateSpec | Canonical JSON değeri ile trace/evidence referanslarından oluşan aday artefaktı. JSON'un kabulü, bunun çalıştırılabilir Config veya uygulanabilir harness değişikliği olarak doğrulanması değildir. | N17 §2–3; LA S218 / K |
| ECC-E03 — canonical JSON | Nesne anahtarları recursive canonicalization'dan geçirilmiş aday temsili. Biçimsel kararlılık, aday davranışının doğruluğunu kanıtlamaz. | N17 §3; LA S218 / K/Y |
| ECC-E04 — trace reference | CandidateSpec'e verilen trace bağlantı dizgesi. Yapıcı referansın içeriğini indirmez veya yazarını doğrulamaz. | N17 §3; LA candidate binding / K |
| ECC-E05 — evidence reference | Adayla ilişkilendirilen evidence bağlantı dizgesi. Dizgenin hash kapsamına girmesi referans verilen kanıtın sabit, doğru veya yeterli olması değildir. Run için verilen evidence reference da kendi kabul koşuluyla taşınır. | N17 §3, §6; LA candidate/admission / K/Y |
| ECC-E06 — normalized reference list | Trim, sort ve dedup sonrası referans listesi; boş referanslar reddedilir, boyut/sayı sınırları uygulanır. Aynı kaynağın birden çok yazımını bağımsız kanıta dönüştürmez. | N17 §3; LA S218 / K |
| ECC-E07 — v2 content address | Canonical JSON ve normalize referans dizgelerinin SHA-256 kimliği. Referans değişince config aynı kalsa da kimlik değişebilir; kimlik referent içeriğini kendiliğinden bağlamaz. | N17 §3; LA S218/S190 / K/Y |
| ECC-E08 — legacy v1 identity | Yalnız canonical configuration'ı adresleyen eski aday kimliği. v2 ile aynı hash kapsamına sahipmiş gibi okunmaz. | N17 §3; LA candidate / K |
| ECC-E09 — v2 alias | Normalize v2 kimliğini mevcut legacy fiziksel satıra bağlayan göç kaydı. Eski foreign key/audit kimliklerinin korunması ile yeni alias'ın dönmesi birbiriyle çelişmek zorunda değildir. | N17 §3; LA S190 / K/Y |
| ECC-E10 — physical candidate id | Store çözümlemesinin ulaştığı gerçek satır kimliği. Gösterilen alias ile her durumda aynı dizge değildir. | N17 §3, §6; LA admission / K |
| ECC-E11 — idempotent candidate registration | Aynı içerik/kimlik tekrar kaydedildiğinde uyumlu kaydı koruma; çakışan içerik aynı aday diye sessizce kabul edilmez. Eşzamanlı promotion garantisi değildir. | N17 §3, §10; LA S190 / K/T |
| ECC-E12 — immutability triggers | Candidate, alias, evaluation ve audit satırlarında kapsanan UPDATE/DELETE işlemlerini engelleyen veritabanı kontrolleri. Şema değiştirilemez veya dosya değiştirilemez anlamına gelmez. | N17 §3, §8; LA audit / K/Y |

## 3. Kaydedilmiş ölçüm, pairing ve kabul ölçütü

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-E13 — RecordedEvidence | Evaluator adı, score kayıtları ve candidate-keyed health assertion içeren sınırlı ölçüm dosyası girdisi. Ölçümlerin bu CLI tarafından üretildiği anlamına gelmez. | N17 §2, §4; LA evaluation / K |
| ECC-E14 — recorded-v1 | Shipped CLI/store yolunun kabul ettiği kayıtlı evaluator adı. Her evaluator implementasyonunun bu yolda kullanılabildiği sonucu çıkarılmaz. | N17 §2, §4; LA S218/S190 / K |
| ECC-E15 — RecordedEvaluator | Sağlanan map'ten score ve health değerlerini getiren evaluator implementasyonu. Canlı model çağrısı veya bağımsız kalite ölçümü yapıldığı iddiası değildir. | N17 §2, §4, §7; LA evaluation / K |
| ECC-E16 — Evaluator trait | Evaluation için extension arayüzü. Trait'in varlığı canlı, bağımsız veya shell-command evaluator'ın shipped CLI'da mevcut olduğunu göstermez. | N17 §2; LA S218 / K/Y |
| ECC-E17 — requested seed | Run çağrısının açıkça seçtiği score lookup anahtarı. Boş, duplicate veya 10.000'den fazla seed listesi reddedilir; farklı anahtarlar bağımsız deneyler değildir. Dosyanın bütün skorlarını kullanma zorunluluğu gösterilmez. | N17 §4; LA evaluation / K/Y |
| ECC-E18 — paired sample | Aynı istenmiş seed için candidate ve baseline değerlerinin eşleştirilmiş kaydı. Eş görev koşulları, dataset sürümü veya tarafsız örneklem bu eşlemeden tek başına çıkmaz. | N17 §4; LA S218 / K/Y |
| ECC-E19 — candidate score | Her istenmiş seed için sağlanan aday skoru; mevcut, finite ve 0–1 aralığında olmalıdır. Dış dünyada ölçülmüş görev başarısı bu doğrulamanın kapsamı değildir. | N17 §4; LA S218 / K |
| ECC-E20 — baseline score | Aynı seed için karşılaştırmanın referans adaya atadığı sağlanmış değer. Baseline'ın current registry choice olması ayrıca admission aşamasında kontrol edilir. | N17 §4, §6; LA evaluation/admission / K |
| ECC-E21 — PromotionPolicy | Minimum sample count, mean delta ve win-rate eşiklerinin birlikte sağlanmasını isteyen aritmetik kabul kuralı. İstatistiksel anlamlılık veya bağımsız performans doğrulaması değildir. | N17 §4; LA S218 / K/Y |
| ECC-E22 — minimum sample count | Pair sayısı için pozitif alt eşik. Satır sayısının yeterli olması bağımsız veya temsili örneklem yeterliliğini kanıtlamaz. | N17 §4; LA S218 / K/Y |
| ECC-E23 — mean delta | Candidate aritmetik ortalaması eksi baseline ortalaması. Kabul eşiğinin finite olması gerekir fakat pozitif olması zorunlu değildir; eşik eşitliği geçer. | N17 §4; LA S218 / K |
| ECC-E24 — win rate | Candidate score'un baseline'dan kesin olarak büyük olduğu pair'lerin oranı. Beraberlik win değildir; eşik 0–1 aralığındadır ve eşitlik kabul edilir. | N17 §4; LA S218 / K |
| ECC-E25 — Comparison | Ortalamalar, delta, win rate ve başarısız eşikleri birlikte taşıyan sonuç. Genel bir ürün kalite notu değildir. | N17 §4; LA S218 / K/Y |
| ECC-E26 — saved criteria / preregistered criteria | Policy ve seed seçiminin Run ile kaydedilmesi, skorlar görülmeden önce sabitlendiğinin kanıtı değildir. Bu, araştırma yazarının iki kanıt statüsünü ayırmasıdır; yeni bir ECC kontrolü değildir. | N17 §4; MA method choice / Y |

## 4. İlk aktivasyon, promotion ve failure sonuçları

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-E27 — ActivateInitial / initial activation | İlk mevcut adayı default slot'a operatör seçimiyle yerleştiren transaction. Paired-score veya health gate çalıştırmaz; zaten etkin slot varsa reddeder. | N17 §2, §5; LA admission / K |
| ECC-E28 — activation reference | İlk aktivasyonda zorunlu, boyutu sınırlı ve boş olmayan referans. Adının approval olması yetkili kişinin onayını doğrulamaz. | N17 §5; LA S190 / K/Y |
| ECC-E29 — default active slot | Registry'nin etkin adayı tuttuğu slot/pointer. Worker'ın yüklediği runtime config ile aynı nesne değildir. | N17 §5–6, §9; LA admission/use / K/Y |
| ECC-E30 — current baseline | Promotion transaction'ı içinde active slot'tan kontrol edilen mevcut aday. Eski baseline girdisi kabul edilmez. | N17 §6; LA S190 / K |
| ECC-E31 — conditional pointer update | Default slot ve expected stored baseline predicate'ine bağlı, changed-row count'un bir olması beklenen UPDATE. Note15'teki session writer ile aynı mutation sözleşmesi değildir. | N17 §6; LA admission / K/Y |
| ECC-E32 — promotion transaction | Provisional pointer update, health kontrolü, gerekli restoration, evaluation ve audit insertion'ını tek transaction'da birleştiren işlem. Dış callback etkilerinin rollback'ini veya her crash kipini kanıtlamaz. | N17 §6–7; LA S190/S220 / K/Y |
| ECC-E33 — promotion_rejected | Aritmetik policy geçmediğinde eski pointer korunurken kaydedilen audit olayı; health callback çalışmaz. Her invalid invocation'ın bu kaydı ürettiği anlamına gelmez. | N17 §6; LA admission / K |
| ECC-E34 — promoted | Policy geçip candidate ile uyumlu health true döndüğünde kaydedilen event/outcome. Etkin registry seçiminin değişmesidir; live deployment değildir. | N17 §6, §9; LA admission / K/Y |
| ECC-E35 — promotion_rolled_back | Policy sonrası uyumlu health false durumunda aynı transaction içinde baseline'ın geri getirilmesiyle kaydedilen olay. Çalışan agent'ın önce değiştirildiği varsayılmaz. | N17 §6–7; LA admission / K/Y |
| ECC-E36 — health_check_error_rolled_back | Callback error veya snapshot ile uyuşmazlık halinde registry restoration ve ilgili kayıt. Stock CLI'da gerçekten canlı health deneyi yapıldığını göstermez. | N17 §6–7; LA admission / K |
| ECC-E37 — early invalid/stale input error | Malformed evidence, invalid score/policy, missing candidate veya stale baseline'ın evaluation/audit pair eklenmeden dönmesi. CLI initialization/migration veya önceki candidate kayıtları için no-effect iddiası değildir. | N17 §6; LA admission / K/Y |
| ECC-E38 — HarnessPromotionOutcome | promoted, rolled_back ve failures gibi alanları olan structured return. Handled rejection normal process exit ile dönebilir; exit zero promotion kanıtı değildir. | N17 §6; LA S186/S190 / K/Y |

## 5. Health, audit ve gerçek kullanım

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-E39 — health_evidence_snapshot | Schema version, evaluator, candidate id ve asserted health içeren canonical health kaydı. Stock CLI'da callback ile aynı sağlanmış health map'inden gelir. | N17 §7–8; LA evaluation/audit / K |
| ECC-E40 — health_check callback | Generic store'un çağırdığı true/false/error üretebilen kontrol noktası. Stock RecordedEvaluator yalnız kayıtlı candidate değerini getirir; generic interface bağımsız live probe demek değildir. | N17 §6–7; LA admission / K/Y |
| ECC-E41 — post-promotion health | Provisional pointer UPDATE'den sonra fakat commit'ten önceki kontrol sırası. Ayrı normal SQLite bağlantısının bu uncommitted pointer'ı gördüğü veya worker'ın adayı çalıştırdığı anlamına gelmez. | N17 §7; LA dependency/admission / K/Y |
| ECC-E42 — registry reversal | Baseline pointer'ın aynı transaction içinde geri getirilmesi. Runtime rollout reversal ile eş anlamlı değildir. | N17 §7; MA actual source trace / Y |
| ECC-E43 — health digest | Canonical health JSON'un SHA-256 kimliği; evaluation/audit sağlık alanlarının karşılığını sınamada kullanılır. Sağlık assertion'ının gerçekliğini bağımsız ölçmez. | N17 §8; LA audit / K/Y |
| ECC-E44 — audit verifier | Canonicalization/digest, candidate çözümü, assertion/status/event uyumu ve linked evaluation sağlık alanlarını kontrol eden okuma yolu. Deneyi yeniden koşmaz, referansları indirmez veya her comparison'ı yeniden hesaplamaz. | N17 §8; LA S190 / K |
| ECC-E45 — legacy-unverifiable | Geçmiş satırların eksik health kanıtını uydurmadan kabul edilebildiği özel standing. Başarılı audit read bütün tarihin eşit kanıt tamlığında olduğu anlamına gelmez. Initial activation ve arithmetic rejection'ın no-health istisnaları ayrıca korunur. | N17 §8; LA audit / K/Y |
| ECC-E46 — active_harness_id | İncelenen store'da cfg(test) ile sınırlanmış convenience getter. Üretim launcher'ının registry seçimini kullandığına kanıt değildir. | N17 §9; LA use boundary / K |
| ECC-E47 — config/profile-based launcher | Config::load, stored session profile, agent_program ve command builder üzerinden worker hazırlayan incelenmiş production yol. Bu yolda registry candidate JSON'unun uygulanması gösterilmez; custom executable ihtimali dışlanmaz. | N17 §9; LA S186/S187/S195; S10 / K/B |
| ECC-E48 — registry admission / runtime adoption / effectiveness | Kaydın kabulü, adayın çalışan sisteme uygulanması ve uygulamanın yararının gösterilmesi farklı araştırma sorularıdır. Başarılı promotion ilkini taşır, diğer ikisini kendiliğinden kapatmaz. | N17 §1, §9–11; MA / Y |
| ECC-E49 — concurrent-registration test | Temporary SQLite ve iki connection/barrier ile idempotent kayıt koşulunu sınayan upstream test tasarımı. Araştırmada koşulmadı; concurrent promotion veya canlı health testi değildir. | N17 §10; LA inspected tests / T |
| ECC-E50 — declared-version transaction contract | Lock'taki rusqlite 0.40.2 ile version-tag transaction kaynağı üzerinden uncommitted drop/default rollback açıklaması. Registry crate checksum eşliği veya kurulmuş binary doğrulaması değildir. | LA S219/S220 + dependency; N17 §6, §11 / K/Y |

## 6. Kaynak tarafından kapsam kontrolü

N17 §1–2 → E01/E02/E13–E16/E27/E29/E48; §3 → E02–E12; §4 → E13–E26; §5 → E27–E29; §6 → E30–E38/E50; §7 → E39–E42; §8 → E12/E43–E45; §9 → E46–E48; §10 → E49 ve test sınırları; §11 → aşağıdaki açık sınır ve geçiş. LA'nin exact source identities, full/selected/incidental/test-not-run ayrımı, dependency binding ve claim bindings'i bu kayıtların kaynak rolünü kontrol etmek için okundu. MA/PA tarihsel yöntem ve yayın karşılığıdır; source bulgularını bağımsız desteklemez.

Kaynak/bağımlılık adları (SHA-256, serde_json, SQLite, rusqlite), kod locator'ları ve örnek reference scheme'leri kendi bağlamında korundu; bu dosyada genel sözlük tanımları yapılmadı. Publication commitleri ve dosya boyutları kavram kimliği veya ürün başarı metriği yapılmadı.

## 7. Önceki kayıtlarla ilişki ve yorum izi

- ECC-R09'un U07 aşamasındaki README düzeyi evaluation-registry işareti E01–E50 ile body/consumer araştırmasının aktarımına bağlandı. Önceki işaret silinmedi; daha derin kaynak katmanı eklendi.
- ECC-L35–L57'nin skill outcome/amendment evaluator'ı ile E13–E45'in Rust recorded evaluator'ı farklı kaynak yollarıdır. Aynı evaluation/promotion sözcükleri nedeniyle verdict veya evidence scope taşınmadı.
- ECC-R74/R75/R107/R125–R127'nin session-state ve stale-attempt açıklaması E30–E32 için varsayılan kusur kabul edilmedi. N17 aktif-baseline koşulu ve transaction'ı ayrı pozitif mekanizmalar olarak raporluyor.
- Maddi anlam açıklığı: promotion/rollback burada registry pointer kapsamındadır. Bu, önceki her promotion veya rollback kaydının anlamını değiştiren global karar değildir.

Bu ilişkiler çapraz-kayıt geri çağırma bağlantılarıdır, ortak tanım/eş anlamlılık kabulü değildir.

## 8. Kapanış sınırı

U10-A araştırmasının dört dosyasından bağlamlı aktarım yapılmıştır; C5a'nın U10-B ve yayın/handoff kontrolleri henüz bu dosyanın yaratılmasıyla tamamlanmış olmaz. Global C5 ve C6 açık kalır. Q06d1b'nin measurement/reference provenance, preregistration/statistical validity, independent health, concurrent promotion/crash, privileged tamper, custom consumer ve runtime adoption soruları çözülmedi. E04/E07/E06 statüleri değişmedi. Yeni Rust/SQLite/model/provider çalıştırılmadı; aynı assistant'ın kaynak-kayıt karşılaştırması bağımsız doğrulama değildir.
