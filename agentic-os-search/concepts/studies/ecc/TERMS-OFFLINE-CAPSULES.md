# ECC — Offline capsule, replay and receipt uses

2026-09-20 · B6-T17-C5a · **U10-B CONTEXTUAL TRANSFER / C5 PARTIAL**.

Bu dosya Note18/U10-B'nin kaynak-içi kullanım dökümüdür. [Rust registry kaydı](TERMS-EVALUATION-REGISTRY.md) veya önceki skill evaluator ile ortak tanım üretmez. Kaynak belirsizliğini yeni ürün araştırmasıyla doldurmaz; yeni test/deney yapılmadı. Güncel okuma ve devam [READING.md](READING.md), giriş [TERMS.md](TERMS.md).

## 1. Kaynak kimliği ve roller

Research repository snapshot: **753a4c6696740664d359a293ee8d300a45ade6d8**. Araştırmanın ayrı upstream pin'i: **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Bu tur aşağıdaki dört araştırma dosyası tam okundu; ledger'daki upstream kod/test/Node belgesi okumaları Concepts tarafından yeniden yapılmış sayılmaz.

- [N18 — Note18](../../../research/studies/ecc/notes/18-OFFLINE-CAPSULES-REPLAY-AND-RECEIPT-SCOPE.md), blob `d0372662e450a2021e637c5b11bd461f2a3e283f`.
- [LB — U10-B source ledger](../../../research/studies/ecc/evidence/U10-B-SOURCES.md), blob `5e3d6a06eea2989c40b641f0153341c63ee7640c`.
- [MB — MR19](../../../research/studies/ecc/ROUND-U10-B.md), blob `9f762ee370604778572593de0a27f089f3b18973`.
- [PB — Publication receipt](../../../research/studies/ecc/PUBLICATION-U10-B.md), blob `b3e69fec21917f42c1b9d47ff140d3758bd17a03`.

Kaynak bağlantıları okunabilir current yollardır; kesin içerik için aynı yollar belirtilen repository snapshot'ında açılır. LB'nin S221 canonical, S222 envelope, S223 capsule, S224 replay, S225 receipt, S226 retrospective, S227 retired entrypoints, S228 architecture, S229 example ve S230–S236 test kaynaklarını adreslemesi özgün araştırmanın kaynak hesabıdır.

**Rol anahtarı:** `K` araştırma yazarının pinned koddan raporladığı kullanım/predicate; `B` aktarılan hedef belge beyanı; `Y` araştırma yazarının sınır/karşı-örnek yorumu; `T` incelenmiş fakat çalıştırılmamış test tasarımı; `P` hedefteki yorumlanacak procedure. Türkçe karşılıklar yeni extractor paraphrase'idir, kelimesi kelimesine hedef tanımı veya bağımsız doğrulama değildir. Yalnız adı sayılan etiketlerin genel anlamı dışarıdan doldurulmadı.

## 2. Capsule ve kayıt şeması

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-O01 — local evidence utilities | Seçilmiş olay/yanıt kayıtlarını koruyan, inceleyen, replay/receipt/report üreten Node yardımcıları. Canlı aday performansını ölçen veya registry seçimini aktive eden Rust mekanizması değildir. | N18 §1; MB actual trace / Y/B |
| ECC-O02 — event envelope | Kimlik, sequence, timestamp, declared effect class, predecessor hash ve izinli payload taşıyan typed kayıt zarfı. Kayıt şeklinin geçerliliği olayın doğru raporlandığını kanıtlamaz. | N18 §2; LB S222 / K/Y |
| ECC-O03 — capsule | Metadata ve journal'ı birlikte yöneten, projection/export işlemleri olan yerel kanıt paketi. İçindeki sıralı journal'ın kendisiyle veya bir çalışma ortamıyla aynı nesne değildir; journal ayrı ECC-O69 kaydındadır. | N18 §1–5; LB S223 / K/Y |
| ECC-O04 — plan lineage | Günlük girdisine verilen beş lineage etiketinden plan. Kaynak burada etiketi adlandırır; evrensel plan nesnesi şeması veya bağımsız event stream tanımlamaz. | N18 §2; LB S222 / K, adlandırılmış |
| ECC-O05 — attempt lineage | Aynı günlükteki attempt etiketi. Rust execution-attempt sahiplik nesnesiyle aynı sözleşme kabul edilmez. | N18 §2; LB S222 / K, adlandırılmış |
| ECC-O06 — interaction lineage | Aynı günlükteki interaction etiketi. Etiketin varlığı bütün etkileşimlerin otomatik yakalandığı anlamına gelmez. | N18 §2, §6; LB journal/replay / K/Y |
| ECC-O07 — environment lineage | Aynı günlükteki environment etiketi. Caller'ın yazdığı entry gerçek ortamın otomatik snapshot'ı değildir. | N18 §2; LB S222/S229 / K/Y |
| ECC-O08 — strategy lineage | Aynı günlükteki strategy etiketi. Kaynak burada etiketi sayar; kendiliğinden öğrenilmiş veya benimsenmiş strateji değildir. | N18 §2; LB S222 / K, adlandırılmış |
| ECC-O09 — effect_class | Caller'ın beyan ettiği etki sınıfı. OS izni veya fiilen ölçülmüş yan etki sınıfı değildir; örnekte sayılan sınıflara dışarıdan genel anlam atanmadı. | N18 §2, §6; LB S222/S224 / K/Y |
| ECC-O10 — scalar payload / declared fields | İzinli scalar tipler ve status/score/verdict gibi caller-supplied alanlar. Type-valid değer bağımsız pass/fail veya score doğrulaması değildir. | N18 §2; LB S222 / K/Y |
| ECC-O11 — strict envelope validation | Varsayılan unknown-key reddi, retained değer doğrulaması ve accessor/unsupported-shape descriptor kontrolleri. Arbitrary JavaScript/proxy davranışının genel güvenlik kanıtı değildir. | N18 §2; LB S221/S222 / K |
| ECC-O12 — non-strict append | Bilinmeyen alanları düşürebilen açık kip. Persisted schema'yı genişletmez ve kalan alanların geçersiz değerlerini kabul etmez. | N18 §2; LB S222 / K |
| ECC-O13 — canary patterns | Tanınan secret-like dizgeleri reddedebilen payload kontrolü. Bütün hassas içeriklerin temizlendiğini veya ayrı fixture dosyalarının aynı kontrolden geçtiğini göstermez. | N18 §2, §6; LB S222/S224 / K/Y |
| ECC-O14 — canonical JSON helper | Seçilmiş JSON anahtarlarını, own prototype-like adlar dahil, koruyan canonicalization yardımcısı. Strict envelope allowlist'i veya tüm olası JS nesneleri için tekil identity garantisi değildir. | N18 §2; LB S221/S222 / K/Y |

## 3. Append, bütünlük ve checkpoint

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-O15 — cooperative append lock | .append.lock'u wx/exclusive create ile alan yerel işbirlikçi-yazar kontrolü. Var olan lock yaşına bakmadan busy döner; automatic stale-lock delete/wait/retry değildir. | N18 §3; LB S223 / K |
| ECC-O16 — reload under lock | Append öncesi journal ve metadata'yı diskten yeniden doğrulayıp sequence/predecessor türetme. Preopened nesnenin cached counter'ı yazma otoritesi değildir. | N18 §3; LB S223 / K/Y |
| ECC-O17 — short-write / fsync handling | Kısa yazıları döngüyle tamamlama, journal fsync ve descriptor close sırası. Her filesystem/crash koşulunda tam başarı garantisi değildir. | N18 §3; LB S223/S232 / K/T |
| ECC-O18 — replacement-lock preservation | Release sırasında açık descriptor kimliği ile path karşılaştırılıp tespit edilen farklı lock'un korunması. Hostile filesystem containment veya universal lock ownership değildir. | N18 §3; LB S223 / K/Y |
| ECC-O19 — partial tail | I/O hatası sonrası kalan yarım entry baytları. Sonraki append bozuk kuyruğu yeniden doğrulayıp reddeder; sessiz düzeltme yapıldığı anlamına gelmez. | N18 §3–4; LB S223 / K |
| ECC-O20 — ambiguous acknowledgement | Tam entry yazıldıktan sonra fsync/close/release hatasıyla caller'ın exception alabilmesi. Exception hiçbir şey yazılmadı veya rollback oldu demek değildir. | N18 §3; MB / Y, conditional |
| ECC-O21 — logical retry duplication | Aynı logical event tekrar denendiğinde yeni sequence ile ikinci geçerli entry oluşabilmesi. Diskten yeniden yükleme exactly-once veya semantic dedup değildir. | N18 §3; LB journal / Y, conditional |
| ECC-O22 — metadata-bound capsule verification | UTF-8/newline/envelope/hash/sequence/predecessor/canonical bytes kontrollerine metadata-entry identity bağını ekleyen readCapsule yolu. Lower-level journal-only check ile aynı kapsam değildir. | N18 §4; LB S223 / K |
| ECC-O23 — valid shorter prefix | Complete trailing entries çıkarılsa da kalan zincirin kendi içinde geçerli olabileceği kaynak karşı-örneği. Standalone verify haricî expected count/root olmadan tam tarih iddiasını taşımaz; bu tur silme deneyi yapılmadı. | N18 §4; LB history witness / Y |
| ECC-O24 — receipt checkpoint | Önceden retained receipt'in named count/root/digest beklentisi. Daha kısa veya başka prefix'i ayırt edebilir; beklenen checkpoint'in bağımsız muhafazası/imzası kendiliğinden sağlanmaz. | N18 §4, §7; LB S225 / K/Y |
| ECC-O25 — stale_checkpoint | Named prefix doğruyken journal'ın checkpoint'ten ileride olması için ayrı verifier standing'i. Geçerli geçmiş checkpoint, güncel checkpoint ve corruption aynı sonuç değildir. | N18 §4; LB S225/S231 / K |
| ECC-O26 — projection | Verified snapshot'tan türeyen identity, entry count, final sequence/root, raw journal digest ve declared label counts. Deterministik türetim task success veya eksiksiz gözlem değildir. | N18 §5; LB S223 / K/Y |
| ECC-O27 — exportBundle | Kaynakta projection yazıp capsule.json, journal.ndjson ve projection.json'u kopyalama. Workspace, fixture directory, evaluated artifact veya receipt otomatik dahil değildir. | N18 §5; LB S223/S229 / K |
| ECC-O28 — quiescent capsule | Küçük ve yazım yapılmayan kapsülde sequential export için maddi kullanım koşulu. Append lock; create/read/project/receipt/export işlemlerine ortak snapshot kilidi sağlamaz. | N18 §3, §5; LB S228 / B/K |

## 4. Record ve replay

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-O29 — FixtureStore | Tool adı/argüman canonical hash'iyle adreslenen response ve hash kayıt deposu. Capsule gibi immutable geçmiş değildir. | N18 §6; LB S224 / K |
| ECC-O30 — fixture key | Tool name + arguments kimliği. Implementation version, environment revision, time veya external data version bu key'e dahil değildir. | N18 §6 identity/freshness; LB S224 / K |
| ECC-O31 — record mode | Caller'ın trusted implementation'ını gerçekten çağırıp response'u kaydeden ve event callback'i üretebilen kip. Candidate gate'in kapalı olması bu yolun kod çalıştırmadığı anlamına gelmez. | N18 §6; LB replay / K |
| ECC-O32 — replay mode | Declared tool/effect/fixture correspondence kontrolünden sonra implementation çağırmadan kayıtlı response'u döndüren kip. Ortamın eski durumunu geri yüklemez. | N18 §6; LB S224 / K/Y |
| ECC-O33 — no live fallback | Eksik/bozuk/uyuşmayan fixture'da fail etme; beklenmedik live implementation çağrısına dönmeme. Bu wrapper'ın kabul edilmiş replay yolu için gerçek korumadır, arbitrary caller JS sandbox'ı değildir. | N18 §6; LB S224 / K/Y |
| ECC-O34 — SE2 default maximum | Replayer'ın varsayılan declared-effect üst sınırı; trusted record caller farklı maximum yapılandırabilir. Kaynak bu adın tüm sistemler için etki tanımını vermiyor. | N18 §6; LB S224 / K |
| ECC-O35 — SE3 replay refusal | Maximum yükseltilse bile declared SE3 tool için replay reddi. Kaynakta bu sınıfın genel etkisel tanımı burada yeniden kurulmadı. | N18 §6; LB S224 / K |
| ECC-O36 — SE4 replay refusal | Maximum yükseltilse bile declared SE4 tool için ayrı replay reddi. SE3 ile aynı sınıf olduğu kabul edilmez; yalnız aynı ret predicate'i kapsamındadır. | N18 §6; LB S224 / K |
| ECC-O37 — replayed response / original effect | Eski ok yanıtını döndürmek, o yanıtın ilk üretildiği dosya/DB/worktree/remote etkiyi yeniden yaratmak değildir. Etkiyi tekrar ateşlememek ile environment restoration ayrılır. | N18 §6; MB / Y |
| ECC-O38 — re-record overwrite | Aynı fixture key'i yeniden record ederek eski yanıtın üzerine yazma. Versioned immutable history veya tekrarlı örneklem mantığı değildir. | N18 §6; LB S224 / K |
| ECC-O39 — onCall | Örneğin capsule append'e bağladığı event callback'i. Unknown tool/missing fixture/implementation/storage error callback'ten önce olabilir; effect, saved fixture ve capsule ack tek atomic transaction değildir. | N18 §6 event gaps; LB S224/S229 / K/Y |
| ECC-O40 — fixture privacy boundary | Raw response fixture'larının envelope allowlist/canary filtresinden ayrı saklanması. Capsule payload kontrolü fixture içeriğine taşınmaz; export'tan dışlanmak güvenli içerik sertifikası değildir. | N18 §6; LB S224 / K/Y |

## 5. Receipt ve koşullu doğrulama

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-O41 — buildReceipt | Root/count, journal/projection identity, optional artifact/gate digests ve receipt body hash'ini kurar. Döndürmeden verified projection yazar; output receipt path yokluğu read-only olduğu anlamına gelmez. | N18 §7; LB S225 / K |
| ECC-O42 — verifyReceipt | Receipt/journal/checkpoint ve saved projection'ı fresh derivation ile karşılaştıran read-only doğrulama. Eksik veya forged projection'ı onarmaz. | N18 §7; LB S225 / K |
| ECC-O43 — receipt body hash | Receipt'in kendi gövdesinin içerik kimliği. O gövdedeki beyanların doğruluğu veya yazarın yetkisi değildir. | N18 §7; LB S225 / K/Y |
| ECC-O44 — signature verifier callback | Haricî verifier callback verildiğinde etkinleşen signature kontrolü. Signature field tek başına kontrolü başlatmaz; CLI bu callback için seçenek sunmaz. | N18 §7; LB receipt chain / K |
| ECC-O45 — artifact witness | Doğrulamaya artifact bytes/digest sağlanırsa receipt'teki digest ile yapılan karşılaştırma. Receipt'te non-null digest bulunması external artifact'in verilmesini zorunlu kılmaz. | N18 §7; LB S225 / K |
| ECC-O46 — external gate receipt | Caller object'i sağladığında yapılan compatibility hashing/verdict taşıma. Nesnenin current disabled gate tarafından üretildiğini veya adayı kabul ettiğini doğrulamaz. | N18 §7; LB S225 / K/Y |
| ECC-O47 — generic ok | Zorunlu verifier kontrollerinin ve istenmiş optional kontrollerin başarılı sonucu. Atlanmış optional kontrollerin dökümünü sağlamaz; tüm witness'ların kontrol edildiği anlamına gelmez. | N18 §7; MB discriminators / K/Y |
| ECC-O48 — PROMOTE in supplied gate object | Synthetic/caller-supplied gate receipt içinde hash'lenebilen verdict. Candidate execution veya gerçek promotion'ın gerçekleştiği kanıtı değildir. | N18 §7; LB S231 / K/T |
| ECC-O49 — checked signature | İstenen key/verifier ile gerçekten kontrol edilmiş imzanın signer-bytes bağı. Görev başarısının doğru ölçümü veya organizational approval authority ayrıca kanıt ister. | N18 §7; LB S231 / Y/T |
| ECC-O50 — receipt over refused execution | Örneğin unavailable candidate execution, static inspection ve synthetic replay kayıtları üzerinde ürettiği geçerli receipt. Utility başarısı aday başarısına çevrilmez. | N18 §1, §9; LB S229 / K/Y |

## 6. Grouping, procedure ve unavailable gate

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-O51 — retrospective grouping | En çok 100 explicit capsule directory'yi tek declared task family için yeniden project edip gruplama. Invalid capsule/mixed family raporu reddeder; uygun olmayan girdileri sessizce düşürmez. | N18 §8; LB S226 / K |
| ECC-O52 — run_id / capsule_id pair | Grouping'de kopya identity hesabının birlikte kullandığı alan çifti. Tek tek eş anlamlı kimlikler veya bağımsız trial kanıtı değildir. | N18 §8; LB S226 / K/Y |
| ECC-O53 — duplicate projection match | Aynı identity pair'i ancak verified projection hash de aynıysa bir kez sayma. Farklı ID'lerin bağımsız ölçüm olduğu sonucunu sağlamaz. | N18 §8; LB S226 / K/Y |
| ECC-O54 — conflicting checkpoints | Aynı identity için uyuşmayan verified projection'ların reddi. En yeniyi/iyiyi sessizce seçmez. | N18 §8; LB S226 / K |
| ECC-O55 — declared harness version | Raporda grouping için kullanılan beyan edilmiş version etiketi. Çalıştırılmış binary veya configuration içeriği doğrulaması değildir. | N18 §8; LB S226 / K/Y |
| ECC-O56 — report_only | Capsule/entry/lineage/effect counts üreten; payload score/verdict/pass-fail/duration/cost'u kasıtlı kullanmayan rapor standing'i. Performance veya promotion sonucu değildir. | N18 §8; LB S226 / K |
| ECC-O57 — limited report disclosure | Payload/path/raw ID'leri çıkarsa da family/version labels ve linklenebilir digest'leri koruyan rapor. Universal anonymization değildir. | N18 §8; LB S226 / K/Y |
| ECC-O58 — runGate refusal | Supported containment backend olmadığı için public candidate gate'in candidate/config execution öncesi unconditional refusal'u. Mevcut olmayan unsafe execution gözlemi değildir. | N18 §1, §9; LB S164/S166 / K |
| ECC-O59 — runVariant refusal | Variant execution public girişinin ayrı refusal'u. Directly imported trusted example solve test'i bu yolu etkinleştirmez. | N18 §9; LB S166/S234/S235 / K/T |
| ECC-O60 — static candidate inspection | Pure inspection/result/baseline-validation yardımcıları ve statik aday bilgisi. Çalışan public execution gate veya containment backend değildir; yardımcı varlığı çağrıldığını kanıtlamaz. | N18 §1, §9; LB S166 / K/Y |
| ECC-O61 — retired child/preload entrypoints | effect-fence.js ve gate-child.js'in aynı refusal stub blob'una bağlanan iki giriş yolu. İki dosya bağımsız destek veya etkin OS backend değildir. | N18 §9; LB S227 / K |
| ECC-O62 — static candidate digest | Statik candidate incelemesinin adreslediği nesnenin digest'i. Single-file receipt artifact digest veya fixture response hash ile aynı nesneye ait sayılmaz. | N18 §9; LB S166/S229 / K/Y |
| ECC-O63 — receipt artifact digest | Receipt'e dışarıdan bağlanan artefaktın, örnekte tek dosyanın, içerik kimliği. Capsule/export'ın bütün çalışma ortamını içerdiğini göstermez. | N18 §5, §7, §9; LB S225/S229 / K |
| ECC-O64 — fixture response hash | Fixture'da saklanan yanıtın hash'i; tool/arg correspondence ile birlikte kontrol edilir. Current world, implementation veya environment freshness değildir. | N18 §6, §9; LB S224 / K/Y |
| ECC-O65 — evaluation-driven development | eval-harness skill'inin code/model/human graders ile anlattığı yorumlanacak daha geniş çalışma prosedürü. Node local utility'nin executable davranışı veya gerçekleştirilmiş deney değildir. | N18 §9; LB U10B-P1 / P |
| ECC-O66 — harness-optimizer | Audit/tests, reversible configuration changes ve human-sensitive review isteyen agent prosedürü. Otomatik receipt-to-deployment köprüsü olarak gösterilmez. | N18 §9; LB U10B-P3 / P |
| ECC-O67 — harness-audit | Ayrı deterministic scorecard script'ine yönlendiren command/procedure. O engine'in tam scoring/caller araştırması U10-B ile yapılmış sayılmaz. | N18 §9; LB U10B-P2 / P |
| ECC-O68 — inspected cryptographic/contention tests | Kaynakta real Ed25519, child contender, injected I/O ve simulated Windows gibi farklı test tasarımları bulunması. Bunların hiçbiri bu araştırma/Concepts turunda koşulmadı; hepsi mock veya hepsi live-validated diye birleştirilmez. | N18 §3, §7; LB S230–S236; MB evidence decision / T |

## 7. Kaynak tarafından kapsam kontrolü

N18 §1 → O01/O50/O58; §2 → O02–O14/O69; §3 → O15–O21/O28/O68; §4 → O22–O25/O69; §5 → O03/O26–O28/O63; §6 ve alt başlığı → O29–O40/O64; §7 → O41–O50/O68; §8 → O51–O57; §9 → O50/O58–O67; §10 → aşağıdaki açık sınır. LB exact identities, body/test coverage, producer-consumer binding ve external-contract sınırlarını korur. MB/PB yöntem ve yayın tarihidir, bağımsız product evidence değildir.

Dosya/API adları, NDJSON/UTF-8/SHA-256/Ed25519 gibi teknik adlar bağlamda korunur; burada genel teknoloji tanımı araştırılmaz. Five lineage labels ve SE sınıfları için kaynakta olmayan anlamlar eklenmedi. Optional signature/artifact/gate kontrolünün istenmediği durum ile istendiği halde başarısız olması ayrıldı.

## 8. İlişki ve açıklık kaydı

- ECC-R10'un U07'deki offline capsule işareti O02–O28/O41–O50 ile ayrıntılandı. Capsule bir reproducible workspace değildir.
- ECC-R11'in kısa static-gate kullanımı O60 ile okunmalıdır: statik helper/inspection ile O58/O59 public execution refusal'u ayrı yollardır. Bu açıklama C4'teki R12 refusal sınırını kaldırmaz.
- ECC-E01–E50 Rust registry, ECC-L35–L57 skill evaluator ve bu Node evidence utility ailesi birbirine eşitlenmedi. Aynı evaluation sözcüğü aynı producer, oracle veya consumer demek değildir.
- Replay yanıtının korunması, worktree/resource identity'nin korunması değildir; ECC-R98–R101 ile kurulabilen bağlantı karşılaştırma işaretidir, ortak mimari kararı değildir.
- Maddi doğrulama açıklığı: generic ok yerine hangi zorunlu ve optional witness kontrollerinin gerçekten yapıldığı korunmalıdır. Bu, kaynağın açık API kapsamıdır; kullanıcı onayı veya extractor açıklığı eksik witness'ın yerine geçmez.

### C5a ilk readback düzeltmesi — capsule ile journal

İlk yayın `4f002b274c7542c1861c392282e8fbc90195f464` içinde O03, capsule/journal adlarını tek kullanım gibi birleştirdi. N18 §2, §4 ve §5 ile karşılaştırma bu kısaltmanın package ile içindeki stream ayrımını gizlediğini gösterdi. O03 yalnız capsule'a daraltıldı; journal O69 olarak ayrı adreslendi. O22 metadata-bound okuma, O26 projection, O27 export ve O41/O42 receipt kayıtları bu ayrımla kontrol edildi; bunlar zaten ayrı nesne/işlemleri tarif ettiğinden metinleri değiştirilmedi. Kaynak veya eski C4 kayıtları bu düzeltme için yeniden yazılmadı.

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-O69 — journal | Capsule içindeki journal.ndjson: beş lineage etiketinin tek global sequence, predecessor hash ve entry hash zincirinde tutulduğu kayıt stream'i. Metadata, projection, receipt veya bütün capsule paketiyle aynı nesne değildir. | N18 §2–5; LB S222/S223 / K |

## 9. Kapanış sınırı

U10-B'nin dört araştırma dosyası üzerinden source-local aktarım yapılmıştır. Bu dosyanın yaratılması final yayın/handoff doğrulaması değildir; yerel/global durum ayrıca güncellenir. Q06d2b'deki complete capture, implementation/environment/time binding, witness/key authority, fixture privacy, async/custom tool, concurrent create/export/crash, hostile filesystem ve actual adoption soruları çözülmedi. U11–U12, C6 ve B7/B8 bu dosyayla başlamış/tamamlanmış olmaz. Upstream test, örnek, model veya candidate gate çalıştırılmadı. Kaynak-kayıt eşleştirmesi aynı assistant kontrolüdür, bağımsız doğrulama değildir.
