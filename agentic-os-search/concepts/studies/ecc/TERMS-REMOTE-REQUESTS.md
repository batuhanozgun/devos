# ECC — Remote request, dispatch ve sonuç kullanımları

2026-09-20 · **B6-T17-C5b / U11-C CONTEXTUAL TRANSFER / C5b-PARTIAL**.

Bu dosya Note21/U11-C araştırmasının kaynak-içi kullanımlarını taşır. Genel terim araştırması, canlı endpoint testi, güvenlik sertifikası veya ortak mimari kararı değildir. RD öneki adresleme içindir; kabul edilmiş kavram sınıfı değildir. Gerçek okuma/yayın durumu [READING.md](READING.md), giriş [TERMS.md](TERMS.md), güncel iş [global STATE](../../STATE.md) içindedir.

## 1. Kaynak kimliği ve roller

Research repository snapshot: **batuhanozgun/agentic-os-search@f0d9ae31062459cf7b2cd982eaf484cbdfc336e8**. Araştırmanın ayrı upstream pin'i: **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Aşağıdaki dört araştırma dosyası tam okundu. İçlerinde atfedilen Rust, SQLite, HTTP ve test kaynakları bu Concepts turunda yeniden okunmuş veya çalıştırılmış sayılmaz.

| Anahtar | Kaynak | Git blob |
|---|---|---|
| N21 | [Note21](../../../research/studies/ecc/notes/21-REMOTE-INTAKE-DISPATCH-AND-RESULT-BOUNDARIES.md) | 2f854ecb06772115c16a8e7b0a023b1b64ea4818 |
| LC | [U11-C source ledger](../../../research/studies/ecc/evidence/U11-C-SOURCES.md) | cd6f2381455a17fde44426a73c43fbce09d56be5 |
| MC | [ROUND-U11-C / MR22](../../../research/studies/ecc/ROUND-U11-C.md) | a4540413a09855d45dfa741815e2061052251500 |
| PC | [PUBLICATION-U11-C](../../../research/studies/ecc/PUBLICATION-U11-C.md) | 49b523036d24050b966228c8961f72e0b3bde98f |

Göreli bağlantılar güncel dosyayı açar; exact içerik yukarıdaki snapshot ve blob ile bağlanır. LC'nin C/M/S/D/TYPES/COM/TEST kısaltmaları sırasıyla main, manager, store, daemon, tipler, comms ve test kaynaklarını adresler; özgün araştırmanın U11C-* locator'larıdır.

**Rol anahtarı:** K = araştırmacının pinned koddan raporladığı kullanım/predicate; Y = araştırmacının açıklaması veya koşullu çıkarımı; T = incelenmiş fakat çalıştırılmamış test tasarımı; H = araştırmada 2026-09-19 tarihinde aktarılan dış sözleşme. Türkçe metinler extractor paraphrase'idir; doğrudan ürün tanımı veya bağımsız teknik doğrulama değildir. Y ile işaretlenen daha güçlü güvence soruları uygulanmış ECC alanı veya benimsenmiş SOUL gereksinimi sayılmaz.

## 2. Talebin alınması ve kabul

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD01 — RemoteDispatchRequest | Kalıcı remote talep kaydı; status, sonuç oturumu/eylemi, error ve dispatch zamanı taşır. Tekil accepted task output veya çalışan session'ın kendisi değildir. | N21 §1, §8; LC TYPES/S / K/Y |
| ECC-RD02 — remote intake service / Serve | HTTP bağlantılarını kabul edip talep kaydeden ayrı servis yolu. Dispatcher'ı kendi içinde çalıştırmaz; servisin açık olması taleplerin yürütüleceğini göstermez. | N21 §1; LC intake / K |
| ECC-RD03 — remote run | Operatörün pending talepleri işlemek için çağırdığı CLI girişidir. HTTP kabulünden ayrı işlem ve doğru store/config eşleşmesi gerektirir. | N21 §1, §7–8; LC C/M / K/Y |
| ECC-RD04 — daemon remote pass | Daemon'ın schedule geçişinden sonra, backlog koordinasyonundan önce yaptığı remote dispatch geçişi. Intake servisinin yaşam döngüsüyle aynı değildir. | N21 §1; LC D / K |
| ECC-RD05 — POST /dispatch | Task içeren remote talebin HTTP kabul yolu. Başarılı kabul session readiness veya iş sonucu değildir. | N21 §2; LC C / K |
| ECC-RD06 — POST /computer-use | Goal, URL ve context'ten task metni/defaultlar hazırlayan talebin kabul yolu; aynı dispatcher'a gider. Browser, hesap veya device erişimi sağlamış sayılmaz. | N21 §2, §6; LC M / K/Y |
| ECC-RD07 — request_kind | Remote talebin tür etiketi; computer-use adı capability veya başarılı computer-use execution kanıtı değildir. | N21 §6; LC TYPES/M / K/Y |
| ECC-RD08 — HTTP 202 / pending acceptance | Kayıt eklenip geri okunduktan sonra pending durumuyla gönderilen kabul yanıtı. Dispatcher çalışması veya tamamlanma sözü değildir; yalnız acceptance olması kendi başına kusur sayılmaz. | N21 §2; LC C/S ve W-U11C-HTTP / K/H/Y |
| ECC-RD09 — GET /health / ok | Queue, dispatcher veya harness kontrol etmeden constant ok döndüren endpoint. Operasyonel iş sağlığı ya da output quality kontrolü değildir. | N21 §2, §8; LC intake/consumers / K/Y |
| ECC-RD10 — insertion–readback–response sequence | Kalıcı ekleme, sonraki geri okuma, serialization ve yanıt yazımı sırası. Sonraki hata, önceki talep kaydını otomatik geri almaz. | N21 §2; LC intake / K/Y, koşullu |
| ECC-RD11 — caller idempotency key | Aynı mantıksal isteğin retry'ını tanımaya ilişkin daha güçlü bağ sorusu. İncelenen schema böyle bir caller key taşımıyor; tekrar POST yeni auto-increment kayıt oluşturabilir. | N21 §2; LC S / Y, koşullu |

## 3. Kimlik doğrulama, kaynak kabulü ve hata yanıtları

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD12 — configured bearer match | POST route'larında JSON yorumu/persistence öncesi supplied Authorization ile configured bearer'ın exact karşılaştırılması. Gerçek kontroldür; named-user veya per-target grant modeli değildir. | N21 §2–3; LC C / K/Y |
| ECC-RD13 — requester | HTTP talebinde saklanan TCP peer IP. Bir proxy'yi gösterebilir; doğrulanmış bireysel kullanıcı veya token sahibi kimliği değildir. | N21 §3; LC target/authority / K/Y |
| ECC-RD14 — local CLI trust boundary | HTTP bearer kontrolünden ayrı, CLI'nın doğrudan store'a talep yazabildiği güven sınırı. HTTP kontrolünün bütün talep üreticilerinde çalıştığı kabul edilmez. | N21 §3; LC C/M / K/Y |
| ECC-RD15 — 401 | Yanlış HTTP credential için ret yanıtı. Kimlik doğrulama öncesindeki bağlantı/body okuma maliyetinin de engellendiğini göstermez. | N21 §2–3; LC intake / K/Y |
| ECC-RD16 — 400 | Empty task veya unresolved target gibi belirtilen geçersiz girdiler için yanıt. Bütün parse/constructor hatalarının aynı kodla döndüğü sonucu çıkarılmaz. | N21 §2; LC C/M / K |
| ECC-RD17 — malformed-JSON 500 | Malformed JSON'un dış handler'a yayılan hatayla 500 olarak raporlanması. Her 500 öncesinde kayıt oluştuğu veya hiçbir etki olmadığı anlamına gelmez. | N21 §2; LC intake / K/Y |
| ECC-RD18 — read_http_request | Route'a özgü authentication'dan önce headers ve declared body'yi okuyan özel parser. Tam HTTP uyumu veya bounded kaynak tüketimi sertifikası değildir. | N21 §3; LC C / K/Y |
| ECC-RD19 — Content-Length body | Parser'ın beyan edilen uzunluğa göre biriktirdiği request body. Header-size kontrolü bu body için açık byte üst sınırı değildir. | N21 §3; LC intake / K |
| ECC-RD20 — header-size check | Header okumasındaki boyut kontrolü. Body limiti, bağlantı deadline'ı veya bütün intake için kaynak kabul politikası yerine geçmez. | N21 §3; LC C / K/Y |
| ECC-RD21 — synchronous connection handling | Servisin kabul edilen bağlantıları synchronous işlemesi. Deadline yokken stalled read sonraki bağlantıları geciktirebilir; bu kaynak çıkarımı, yapılmış DoS deneyi değildir. | N21 §3; LC C; W-U11C-RUST / K/H/Y |
| ECC-RD22 — accepted-stream deadline | İncelenen fonksiyonlarda ayarlanmayan read/write timeout veya genel request deadline'ı. Dış proxy/firewall/tunnel korumalarının yokluğu ya da gerçek etki büyüklüğü buradan çıkarılmaz. | N21 §3; LC C ve omissions / Y/H |
| ECC-RD23 — bind address | CLI'da default loopback olup başka adres kabul eden listener seçimi. Her deployment'ın yalnız local erişime açık olduğunu kanıtlamaz. | N21 §3; LC intake / K/Y |
| ECC-RD24 — application transport | İncelenen fonksiyonların plain TCP/HTTP taşıması; bu fonksiyonlarda TLS yapılandırılmaması. Dış encrypted tunnel/proxy yokluğu veya bütün kurulumlar için açık ağ teşhisi değildir. | N21 §3; LC omissions / K/Y |
| ECC-RD25 — actor/grant binding | Talebi token identity/scope/expiry/grant version ile bağlama sorusu. İncelenen kayıtta bunlar saklanmıyor; sonraki dispatcher HTTP credential'ı yeniden kontrol etmiyor. Bu, zorunlu multi-tenant IAM tasarımı kabulü değildir. | N21 §3, §9; LC target/authority / Y/K |

## 4. İstenen hedef, lead ve gerçek alıcı

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD26 — target_session_id | Intake'ta çözümlenip saklanan istenen session hedefi. Dispatch bunu lead olarak kullanır; fiilî alıcının aynı session olması gerekmez. | N21 §4; LC target/authority / K/Y |
| ECC-RD27 — exact/prefix session lookup | İlk exact/prefix match ile session çözümleme. Kısa/boş prefix'in her durumda unique olduğu gösterilmez; exact existing id yararlı pozitif durumdur. | N21 §4; LC C/S / K/Y |
| ECC-RD28 — lead | assign_session_in_dir_with_runner_program'a hedef olarak verilen, delegeleri incelenen session. Lead'in mevcut olması kontrol edilir; belirli active state zorunluluğu bu fonksiyonda gösterilmez. | N21 §4; LC M / K |
| ECC-RD29 — result_session_id | Routing sonrası gerçekten seçilen/oluşturulan session'a kalıcı bağlantı. Requested target'tan farklı olabilir; aynı session çok talep alabileceğinden tekil accepted-work receipt değildir. | N21 §1, §4, §8; LC S/M / K/Y |
| ECC-RD30 — request working directory | Constructor'ın kendi CWD'sinden kaydettiği path. Remote client's directory veya immutable repository revision değildir. Yeni delegated session bu path'i kullanabilir. | N21 §4; LC target/selection / K/Y |
| ECC-RD31 — retained delegate directory | Mevcut delege yeniden kullanıldığında korunan kendi directory'si. Request'in stored directory'sine göre yeniden kurulduğu varsayılmaz. | N21 §4, §6; LC M / K/Y |
| ECC-RD32 — grouping context | Request/session routing'de taşınan açıklayıcı task/group etiketleri. Authenticated repository identity veya tekil request-result eşliği değildir. | N21 §4, §8; LC target/authority / K/Y |
| ECC-RD33 — ON DELETE SET NULL | Native request schema'nın target session silinince foreign key'i null yapması. Dangling reference'ı önleyebilir; istenen hedefin kaybolduğuna ilişkin niyeti ayrı korumaz. | N21 §5; LC S; W-U11C-SQL / K/H/Y |
| ECC-RD34 — None target / untargeted branch | Mapper'ın null'ı None yapmasıyla seçilen yeni top-level-session yolu. Hiç hedef istenmemesi ve hedefin sonradan kaybolması aynı representation'a düşebilir. | N21 §5; LC target deletion / K/Y |
| ECC-RD35 — target-deletion timing | Başarılı deletion sonrası fresh read null görebilir; deletion öncesi Some-target snapshot tutan dispatcher ise lead lookup hatasına gidebilir. Her silmenin yeni iş başlatacağına ilişkin genel hüküm değildir. | N21 §5; LC S/M / Y, koşullu |
| ECC-RD36 — handoff-derived children | Lead'in geçmiş handoff ilişkilerinden türetilen delegate adayları. Aynı harness ve seçili state/backlog ölçütleriyle incelenir; desired profile/environment equality kontrolü değildir. | N21 §4, §6; LC M/S / K/Y |
| ECC-RD37 — delegate selection score | Unread handoff counts ve lexical context-graph match üzerinden seçime katkı. Görevin semantic uygunluğu veya execution-policy uyumu doğrulaması değildir. | N21 §6; LC selection / K/Y |
| ECC-RD38 — profile_name | Request constructor'ının doğrulayabildiği execution profile adı. Adın geçerli olması, reused session'a aynı ayarların uygulanmasını garanti etmez. | N21 §2, §6; LC M / K/Y |
| ECC-RD39 — ReusedIdle | Uygun idle delegate'e task handoff gönderilerek dönülen assignment sonucu. Existing session yeniden yapılandırılmaz veya requested profile/worktree/directory ile eşitliği kontrol edilmiş sayılmaz. | N21 §6; LC M / K/Y |
| ECC-RD40 — ReusedActive | Uygun active delegate'e handoff gönderilerek dönülen ayrı assignment sonucu. Mesajın kaydı actual recipient uptake veya requested policy'nin uygulanması değildir. | N21 §6, §8; LC M/COM / K/Y |
| ECC-RD41 — new-session profile resolution | Yeni child/top-level admission yollarında normal queue/profile resolution ve session-profile persistence kullanımı. Reuse'daki sınırlama nedeniyle bütün dallarda profil yok sayılıyor denmez. Queue admission yine readiness değildir. | N21 §6–7; LC selection/outcome / K/Y |

## 5. Öncelik ve handoff sınırı

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD42 — remote request priority | Pending query'nin descending priority, ardından creation/id sıralamasına verdiği girdi. Batch selection önceliğidir; bütün sonraki mesajlara taşınmış öncelik değildir. | N21 §6–7; LC selection / K/Y |
| ECC-RD43 — Normal handoff priority | send_task_handoff'un ürettiği mesajın Normal önceliği. Critical request önce seçilse de bu mesaj Normal olabilir; inbox'ın priority sıralaması ayrı consumer'dır. | N21 §6; LC M/S/COM / K/Y |
| ECC-RD44 — send_task_handoff | Lead/task context'iyle structured mesaj üreten helper; remote request id/requester'ı mesajda taşımıyor. Request metadata'sı ile recipient message metadata'sı aynı kapsam değildir. | N21 §6; LC selection / K |
| ECC-RD45 — comms::send | Structured mesajı serialize edip store'a kaydeden yol. Worker input stream'ine yazma veya alıcı acknowledgment'ını bekleme işlemi değildir. | N21 §8; LC COM/consumers / K/Y |
| ECC-RD46 — message-before-projection | send_message'ın mesajı graph/board projection'dan önce eklemesi. Sonraki projection hatası mevcut handoff'u silmiş sayılmaz; bu tur böyle bir hata koşulmadı. | N21 §7; LC S / K/Y, koşullu |

## 6. Request durumu, sonuç ve yeniden deneme

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD47 — Pending | Pending selector'ın tekrar seçebildiği talep durumu. Başlangıç kabulünü veya saturation nedeniyle beklemeyi taşıyabilir; her iki neden ayrı durable açıklamayla kayıtlı olmayabilir. | N21 §2, §7; LC outcome / K/Y |
| ECC-RD48 — Dispatched | Yeni session/reused delegate admission sonrası sonuç session/action/time ile yazılan request durumu. Ready harness, okunmuş mesaj veya completed task değildir. | N21 §7–8; LC S/TYPES / K/Y |
| ECC-RD49 — Failed | Routing/admission hatası kaydedilebildiğinde error ile yazılan durum. Sonraki pending sorgusundan dışlanır; otomatik retry veya önceki etkilerin compensation'ı değildir. | N21 §7; LC outcome / K/Y |
| ECC-RD50 — DeferredSaturated | Target team doygunken current call'un döndürdüğü sonuç; request Pending kalır. Ayrı durable deferral reason, backoff zamanı veya yeni persistent status diye okunmaz. | N21 §7; LC M/S / K/Y |
| ECC-RD51 — result_action | Kalıcı talepte tutulan routing/admission eyleminin karşılığı. Aday atama sonucunun etiketidir; işin kalite/başarı verdict'i değildir. | N21 §1, §7–8; LC S / K/Y |
| ECC-RD52 — dispatch timestamp | Başarılı routing sonucuyla saklanan zaman. Tekil görevin alıcı tarafından okunma, tamamlanma veya kabul zamanı değildir. | N21 §1, §7–8; LC S / K/Y |
| ECC-RD53 — error field | Başarısız request için saklanan hata açıklaması. Gecikmiş failure writer önceki result id/action/time'ı temizlemediğinde diğer alanlarla farklı geçmişleri taşıyabilir. | N21 §7; LC S / K/Y, koşullu |
| ECC-RD54 — same-id retry | Failed request'i aynı kimlikle yeniden deneme sorusu. İncelenen CLI add/list/run/serve sunar, ayrı same-id retry işlemi gösterilmez; external record yönetimi dışlanmaz. | N21 §7; LC C/omissions / Y/K |
| ECC-RD55 — saturated-prefix fairness | Kalıcı doygun yüksek öncelikli prefix'in limited pending batch'i tekrar doldurabilmesi. Pending retention, düşük sıradaki taleplerin sıra alacağını kanıtlamaz. | N21 §7; LC outcome / Y, koşullu |
| ECC-RD56 — per-request failure isolation | Ordinary routing hatası başarıyla Failed olarak kaydedilince sonraki request'e devam edilebilmesi. Note20'nin ilk hatada duran scheduler loop'uyla aynı değildir. | N21 §7; LC outcome; MC discriminators / K/Y |
| ECC-RD57 — acknowledgement-write failure | Routing/message etkisinden sonra success/failure kaydının hata vermesiyle pass'in durması. Önceki etkiler korunabilir, complete partial outcome vector veya rollback garanti değildir. | N21 §7; LC outcome / K/Y, koşullu |
| ECC-RD58 — id-only result update | Result writer'larının request id ile, expected Pending/attempt owner veya affected-row denetimi olmadan güncellemesi. Pending snapshot bir claim değildir; competing dispatchers'ın tek işi sahiplenmesini sağlamaz. | N21 §7; LC S/M / K/Y |
| ECC-RD59 — mixed result history | Gecikmiş competing failure'ın status/error'ı değiştirip eski successful result alanlarını bırakabilmesi. Conditional interleaving'dir; çalıştırılmış race veya ölçülmüş duplicate oranı değildir. | N21 §7; LC outcome / Y |

## 7. Operatör görünümü, tüketim ve kabul

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD60 — default remote list | Yalnız Pending kayıtların operatör görünümü. Bir talebin görünümden çıkması dispatched veya failed olabilir; başarı kanıtı değildir. | N21 §8; LC consumers / K/Y |
| ECC-RD61 — list --all | Processed/failed talepleri de görünür kılabilen liste seçimi. Listeleme talebi yeniden dispatch etme veya sonuç kabulü değildir. | N21 §8; LC C / K |
| ECC-RD62 — JSON request view | Compact text list'ten daha fazla alan açan temsil. Daha zengin görünüm alttaki alanların accepted-work receipt'e dönüşmesi değildir. | N21 §8; LC consumers / K/Y |
| ECC-RD63 — printed routing outcomes | Remote Run'un yazdırdığı sonuçlar; daemon wrapper'ı routed actions'ı sayar. Yönlendirme raporu, her recipient'ın işi bitirdiğine ilişkin rapor değildir. | N21 §8; LC C/D / K/Y |
| ECC-RD64 — inbox read marker | Limited recent inbox görünümü hazırlanırken recipient'ın unread mesajlarını printing öncesi read işaretleme. Read flag başarılı iş veya mesajın kişi/model tarafından işlendiği acknowledgment değildir. | N21 §8; LC S/consumers / K/Y |
| ECC-RD65 — backlog handoff consumption | Handoff'u başka atamaya yönlendirip routing sonrası read işaretleyebilen control yolu. Consumption burada output acceptance değildir; daha derin U11-D aktarımı bu dosyayla tamamlanmaz. | N21 §8; LC consumers / K/Y |
| ECC-RD66 — per-request completion | RemoteDispatchStatus'ta ayrı Completed state'i bulunmaması ve writer'ın belirli request'i verified output/caller ack'e bağlamaması sınırı. External consumer'ın ekleyemeyeceği iddia edilmez. | N21 §8–9; LC TYPES/consumers / Y/K |

## 8. Test ve dış sözleşmelerin anlamı

| ID / özgün ifade | Bu bağlamdaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-RD67 — critical-targeted priority test | Injected runner ve temporary repo/store üzerinden priority selection, dispatch status ve result id kontrol eden test tasarımı. Araştırmada incelendi, çalıştırılmadı; live HTTP/recipient testi değildir. | N21 §9; LC TEST / T |
| ECC-RD68 — source=http test label | Untargeted test'in doğrudan DB'ye yazdığı provenance etiketi. Testin network request gönderdiğini veya authentication'ı sınadığını göstermez. | N21 §9; LC tests; MC evidence / T/Y |
| ECC-RD69 — computer-use defaults test | Config/default ve rendered task fields'i kontrol eden üçüncü test tasarımı. Fiilen browser capability veya computer-use başarısı ölçülmez; koşulmadı. | N21 §9; LC TEST / T |
| ECC-RD70 — dated external contract | Araştırmanın SQLite FK, Rust socket, RFC9110 ve bearer reference okumaları. Installed binary/deployment doğrulaması değildir; bearer referansı ECC'yi OAuth server yapmaz. Bu tur dış belgeler yeniden doğrulanmadı. | LC primary external contracts; PC boundaries / H/Y |

## 9. Kaynak tarafından kapsam ve ilişki kontrolü

N21 §1 → RD01–RD04/RD29; §2 → RD05–RD17; §3 → RD12–RD25/RD70; §4 → RD26–RD32/RD36; §5 → RD33–RD35; §6 → RD06–RD07/RD31/RD36–RD44; §7 → RD46–RD59; §8 → RD29/RD45/RD60–RD66; §9 → RD67–RD70 ve açık sınır; §10 → aşağıdaki ilişkiler. LC kaynak kimlikleri, fresh/retained/selected/incidental kapsam, üç test ve tarihli sözleşmeler bakımından tam okundu. MC yöntem/kanıt tercihi, PC yayın karşılığı ve geçmiş payload düzeltmesidir; aynı iddiaya dört bağımsız destek değildir.

Kaynağın zinciri: **HTTP/CLI intake → kalıcı request → ayrı pending selection → lead üzerinden reuse/new-child veya top-level admission → kalıcı routing result → CLI/inbox/backlog tüketicisi**. Kimlik doğrulama, kaynak tüketimi, hedef seçimi ve outcome acceptance bu zincirde farklı sınırlardır. No target ile disappeared target aynı None'e indirgenebilir; farklı kökenler ortak representation kullanıyor diye niyetler eşitlenmez.

Pozitif kontroller açık tutuldu: gerçek bearer karşılaştırması ve invalid input reddi; insertion sonrası readback; exact existing target seçimi; yeni session için profile resolution; pending retention; explicit Failed kaydı ve per-item continuation; kalıcı result-session bağlantısı; processed talepleri gösteren operatör yolu. Daha güçlü guarantee yokluğu, bütün sistemi etkisiz veya 202 yanıtını protokol hatası saymak için kullanılmadı.

**Önceki kayıtlarla bağ:** SC53–SC54 scheduler'ın returned association/durable provenance ayrımıdır. Remote RD29 kalıcı sonuç oturumu bağlantısı gerçekten taşır; scheduler'ın eksikliği remote'a aynen aktarılmaz. SC44 ilk-error batch davranışı da RD56'ya taşınmaz. R100 same-id resume, RD39/RD40 delegate reuse ile aynı işlem değildir. E30–E32 registry transaction'ı RD58 request writer'ının sahiplik güvencesi olarak kullanılamaz. N55/N56 insan onayı, RD08 HTTP acceptance veya RD48 Dispatched ile aynı karar değildir. Bunlar kaynak-içi geri çağırma bağlantılarıdır, B8 ortak tanım kabulü değildir.

**Yorum sınırı:** hedef silinmesi örneği başarılı eligible deletion, native schema/FK ve fresh read koşuluyla taşındı; eski Some snapshot'ın failure karşılığı da korundu. Valid profile name ile reused effective policy ayrı tutuldu; gerçek privilege escalation iddiası üretilmedi. Read marker, routing receipt ve verified output aynı başarı etiketiyle çevrilmedi. Önceki TERMS kayıtlarını değiştirmeyi gerektiren maddi çelişki bu kaynak karşılaştırmasında saptanmadı; belirsizlikler ürün araştırmasıyla kapatılmadı.

HTTP/Rust/SQLite adları, source locator'ları ve status kodları bağlamlarında korundu; genel teknoloji sözlüğü yapılmadı. MC/PC'deki eski arama/indirme/payload sorunları güncel erişim arızası veya target davranış kanıtı sayılmadı. U11-C yeni deney içermiyor; eski E08/E07 veya sonraki E09 bu unit'in deneyi değildir.

## 10. Kapanış ve açık sınır

U11-C'nin dört araştırma dosyasından kaynak-bağlı aktarım kaydedildi. Bu dosyanın varlığı yayın/readback tamamlanması veya C5b/C5/C6 kapanışı değildir. RD01–RD70 adreslenebilir kullanım/ilişki kayıtlarıdır; 70 bağımsız kavram/kanıt veya başarı yüzdesi değildir.

Q04e2b'nin installed HTTP/transport/resource behavior, actor/grant/target/revision binding, migrated schema, idempotency/concurrency, profile/environment compatibility, full tests ve authenticated per-request worker acknowledgement/acceptance sınırları açıktır. Kaynakta tanımlanan belirsizlikler otomatik yeni Concepts deney borcu veya benimsenmiş SOUL gereksinimi olmaz. Yeni endpoint, HTTP request, Rust/SQL/test/model/provider, installation veya upstream mutation yapılmadı. E06 excluded, diğer geçmiş deneyler kendi kapsamlarında kalır.

Sıradaki Concepts kaynak ailesi **U11-D — Note22/backlog coordination and consumption**; onun gövdesi bu aktarımda okunmadı. U11-E, U12, C6 ve B7/B8 açık kalır.
