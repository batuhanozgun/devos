# ECC — Template çözümleme ve başlatma kullanımları

2026-09-20 · **B6-T17-C5b / U11-E CONTEXTUAL TRANSFER**.

Bu dosya Note23/U11-E araştırmasındaki kullanımları kendi bağlamlarında kaydeder. Genel template/workflow sözlüğü, yeni ürün deneyi veya ortak mimari kararı değildir. TL öneki yalnız kullanım adresidir. Gerçek okuma ve devam [READING.md](READING.md), kullanım girişi [TERMS.md](TERMS.md), programın güncel işi [global STATE](../../STATE.md) içindedir. Dosyanın yaratılması tek başına yayın kapanışı değildir.

## 1. Kaynak kimliği ve roller

Research repository snapshot: **batuhanozgun/agentic-os-search@eb7754b34953b57b9c1aeb92ef4885993ded7ca2**. Ayrı upstream research pin: **affaan-m/ECC@8321021c54d670126ce3b2969d5deb880b4b0c2a**. Aşağıdaki dört araştırma dosyası bu tur tam okundu; atfedilen upstream kod, test ve dış dokümanlar yeniden okunmuş/çalıştırılmış sayılmaz.

| Anahtar | Kaynak | Git blob |
|---|---|---|
| N23 | [Note23](../../../research/studies/ecc/notes/23-TEMPLATE-RESOLUTION-AND-LAUNCH-COMPOSITION.md) | 104258ce88a8e069ab80d73a33927c1094dc57ba |
| LE | [U11-E source ledger](../../../research/studies/ecc/evidence/U11-E-SOURCES.md) | b80b462f40875998e0a3fa4666c4ba907cd1f072 |
| ME | [ROUND-U11-E / MR24](../../../research/studies/ecc/ROUND-U11-E.md) | 46979375752f77736c1e3d93cdd4170c59dacaf0 |
| PE | [PUBLICATION-U11-E](../../../research/studies/ecc/PUBLICATION-U11-E.md) | 42b1897d4f1f328e79e79cfc0f06a1813723a860 |

Göreli bağlantılar current dosyayı açar; exact içerik aynı yolun yukarıdaki snapshot ve blob kimliğiyle bağlanır. LE içindeki U11E-M/CFG/C/W/README, manager/config/CLI/worktree/README kaynaklarını; CFGTEST/MTEST test kapsamlarını adresler. Bunlar özgün araştırmanın locator'larıdır.

**Rol anahtarı:** K = araştırmacının pinned koddan raporladığı kullanım/predicate; B = araştırmada aktarılan hedef belge beyanı; Y = araştırmacının açıklaması, ayrımı veya koşullu çıkarımı; T = incelenmiş fakat çalıştırılmamış test tasarımı; H = araştırmada tarihli olarak aktarılan dış sözleşme. Türkçe açıklamalar yeni extractor paraphrase'idir; doğrudan ürün tanımı veya bağımsız doğrulama değildir. Eksik daha güçlü bağları anlatan Y satırları implemented ECC alanı veya benimsenmiş SOUL gereksinimi sayılmaz.

## 2. Template, parametre ve gerçek bağlam

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL01 — orchestration template | Çözümlenmiş görev metni, profil/harness, grouping ve worktree tercihleriyle birden fazla yeni session kabulünü tarif eden yeniden kullanılabilir açıklama. Completion-aware workflow engine veya her adımı dependency-DAG node'u yapan bir yapı değildir. | N23 §1; LE joined mechanism / K/Y |
| ECC-TL02 — alpha control-plane scaffold | ECC2 README'nin kendi olgunluk/purpose çerçevesi. Bitmiş evrensel orchestration ürünü beyanı değildir; bu ifade mevcut template kodunun yokluğu kanıtı da yapılmaz. | N23 §1; LE README / B/Y |
| ECC-TL03 — feature_development | Planner/reviewer task metinleri, ortak değişkenler, reviewer profili ve farklı worktree tercihleri taşıyan config test template'i. Çalıştırılmış feature geliştirme veya başarılı plan/review akışı değildir. | N23 §1, §7; LE CFGTEST / T |
| ECC-TL04 — Template CLI | Template seçimi, optional source ve değişken map'ini manager'a taşıyan caller. Bir workflow sonucu veya modelin yönergeyi uyguladığının kanıtı değildir. | N23 §1–2; LE C / K |
| ECC-TL05 — --var / key=value parsing | İlk equals işaretinde ayrılan ve iki yanı trim edilen key/value girdisi; delimiter veya dolu taraf yoksa reddedilir. Genel expression evaluator veya kaynak doğrulama mekanizması değildir. | N23 §2; LE C/input / K |
| ECC-TL06 — repeated-key overwrite | Aynı değişken anahtarı tekrar verilince önceki map değerinin üzerine yazılması. Birden fazla değerin birleşmesi veya uyuşmazlık çözüm kararı değildir. | N23 §2; LE input/resolution / K |
| ECC-TL07 — build_template_variables | Otomatik task/project/cwd/source alanlarını yalnız map'te yoklarsa dolduran helper. Explicit değişken metni üretilen fallback'i geçersiz kılabilir; metin authenticated environment fact değildir. | N23 §2; LE M / K/Y |
| ECC-TL08 — task variable | Substitution için kullanılan map değeri; --task ile gelen metni override edebilir. Diğer fallback grouping'in hâlâ ayrı task argument/source üzerinden gelmesiyle aynı nesne değildir. | N23 §2; LE input/binding / K/Y |
| ECC-TL09 — project variable | Map'teki explicit veya otomatik doldurulmuş proje metni. Bu metnin gerçek repository, revision veya kaynak kimliğini doğruladığı kabul edilmez. | N23 §2; LE binding / K/Y |
| ECC-TL10 — cwd variable | Template içine yerleştirilebilen çalışma dizini metni. Değiştirilmesi actual launch directory'yi değiştirmez; TL13 ayrı yürütme girdisidir. | N23 §2; LE binding / K/Y |
| ECC-TL11 — source_* variables | Source session'dan fallback olarak doldurulabilen fakat explicit map girdileriyle override edilebilen metinler. Authenticated origin veya immutable source-session snapshot değildir. | N23 §2; LE M/binding / K/Y |
| ECC-TL12 — source-session fallback | Task/grouping ve source metinlerinin optional source session'dan alınması. Source'un directory, stored profile veya revision'ının yeni session'lara miras kalması değildir. | N23 §2–3; LE binding/profiles / K/Y |
| ECC-TL13 — invoking-process working directory | Her yeni step session'ının launch için kullandığı çağıran process'in current directory'si. Source session'ın directory'sinden veya cwd değişkeninin metninden ayrıdır. | N23 §2; LE binding / K |

## 3. Çözümleme ve başlatmadan önceki kontroller

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL14 — resolve_orchestration_template | Template, değişkenler ve step alanlarını launch öncesinde çözen config yolu. Başarılı çözümleme görevlerin yürütülmesi veya etkilerin atomik olması değildir. | N23 §2; LE CFG / K/Y |
| ECC-TL15 — unknown-template refusal | Adı bulunmayan template'in resolver tarafından reddedilmesi. Bu pre-effect kontrol bütün sonradan oluşacak launch hatalarını dışlamaz. | N23 §2; LE input/resolution / K |
| ECC-TL16 — empty-step-list refusal | Step listesi boş template'in reddedilmesi. Step sayısının pozitif olması her task'ın anlamlı veya nonempty olduğu kontrolü değildir. | N23 §2; LE CFG / K/Y |
| ECC-TL17 — recognized placeholder grammar | Helper'ın tanıdığı placeholder biçimi; tanınan bir anahtar eksikse hata üretir. Her brace-benzeri dizge bu gramerde değildir; farklı syntax literal kalabilir. | N23 §2; LE input/resolution / K |
| ECC-TL18 — interpolate_required_string | Tanınan eksik değişkeni yakalayan required-string helper'ı. Ortaya çıkan task metninin boş olmamasını veya semantic geçerliliğini zorunlu kılmıyor; required etiketi daha güçlü çevrilmez. | N23 §2; LE CFG / K/Y |
| ECC-TL19 — optional-string normalization | Optional substitution sonucunu trim edip blank ise None'e çevirme. Literal boş string ile opsiyonun bulunmamasını aynı karar girdisine dönüştürebilir; TL18'in kontrolüyle aynı değildir. | N23 §2; LE input/resolution / K/Y |
| ECC-TL20 — all-step resolution before admission | Bütün step'lerin template'in ilk yeni session etkisinden önce çözümlenmesi. Son step'teki eksik tanınan değişken ilk admission'ı önleyebilir; bütün launch etkilerinin rollback'i değildir. | N23 §2, §6; LE input/partial failure / K/Y |
| ECC-TL21 — inherited project default | Önce top-level'da render edilen project değerinin step override yokken yeniden helper'dan geçebilmesi. Direct step değeriyle aynı sayıda substitution yapıldığı varsayılmaz. | N23 §2; LE input/resolution / K/Y |
| ECC-TL22 — inherited task_group default | Top-level task_group değerinin miras alınırken ikinci render'a girebilmesi. Project ile aynı field değildir; iki alan benzer çağrı düzeni taşır. | N23 §2; LE input/resolution / K |
| ECC-TL23 — explicit step override | Step'in kendi project/task_group değerinin o step'te render edilmesi. Top-level'dan önceden render edilmiş değeri miras alma yoluyla eşdeğer değildir. | N23 §2; LE CFG / K/Y |
| ECC-TL24 — double-processing counterpart | project='{{area}}', area='billing' örneğinde inherited '{{project}}' değerinin billing'e, direct step ifadesinin tek pass sonunda '{{area}}' literaline varabilmesi. Helper bileşiminden koşullu kaynak çıkarımıdır; bu tur çalıştırılmadı. | N23 §2; LE input; W-U11E-REGEX / K/H/Y |
| ECC-TL25 — resolved step | Task, agent/profile, grouping ve worktree seçimleri çözülmüş step açıklaması. Kabul edilmiş session, çalışmış task veya predecessor output'u değildir. | N23 §1–3; LE CFG/M / K/Y |
| ECC-TL26 — profile inheritance cycle check | İsimli profillerin inheritance çözümlemesinde döngüyü reddeden kontrol. Pre-effect config güvencesidir; host'un profil kısıtlarını uyguladığını göstermez. | N23 §2, §7; LE CFG/CFGTEST / K/T/Y |

## 4. Agent varlığı, profil seçimi ve miras sınırı

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL27 — named step profile | Resolved step'te profile adı varsa session creation'a verilen öncelikli profil. Agent alanının ayrıca bulunması bu adlandırılmış seçimi ortadan kaldırmaz. | N23 §3; LE profiles / K |
| ECC-TL28 — resolved agent presence | Profile yokken step'te agent bulunup bulunmamasına dayanan seçim koşulu. Agent'ın cfg.default_agent'tan farklı olması aranmaz; aynı adı açıkça vermek de koşulu karşılar. | N23 §3; LE M / K/Y |
| ECC-TL29 — inherited template-level agent | Template-level default'tan step'e miras kalan agent'ın resolved agent olarak present sayılması. Kullanıcının her step'e ayrı yazması gerekmeden TL28 dalını etkiler. | N23 §3; LE profiles / K |
| ECC-TL30 — cfg.default_agent_profile resolution | Global default profilin launch loop öncesinde çözülmesi. Bütün step'ler explicit alternatif seçse bile invalid global default bu çözümlemede launch'ı durdurabilir. | N23 §3; LE profiles / K/Y |
| ECC-TL31 — None profile for explicit agent | Resolved profile yok fakat agent varsa global default profilin atlanıp lower queue'ya None verilmesi. Queue default'u sonradan geri eklemiyor; bu, host'ta hiçbir bağımsız kısıt yok demek değildir. | N23 §3; LE profiles / K/Y |
| ECC-TL32 — omitted-agent-and-profile default | İki alan da yoksa configured global default profilin kopyalanıp kullanılması. Aynı default agent adını explicit vermeyle eşdeğer değildir; explicit named profile pozitif ayrı yoldur. | N23 §3; LE profiles / K/Y |
| ECC-TL33 — profile agent override | Lower queue helper'da profile'ın kendi agent değerinin ayrı agent argument'ına üstün gelmesi. Alanların birlikte var olması ikisinin eşzamanlı uygulanması değildir. | N23 §3; LE profiles / K |
| ECC-TL34 — source-profile inheritance boundary | --from-session anchor/grouping bağının source session'ın stored profile'ını fetch edip miras almaması. Mevcut profile selection ile source-policy continuity aynı güvence değildir. | N23 §3; LE binding/profiles / K/Y |
| ECC-TL35 — selected/persisted profile | Launch sırasında seçilip session için kaydedilen profil. Native flags/text/custom runner üzerinden gerçekten enforce edilme sorusu ayrıdır; U12-A bu başka consumer kapsamıdır. | N23 §3, §7–8; LE profiles/next / K/Y |

## 5. Kapasite ve sıralı admission

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL36 — template max_parallel_sessions check | Mevcut sayılan session'ları limitten düşüp bütün step sayısını kalan kapasiteyle karşılaştıran kontrol. Scheduler'ın yalnız due-batch limit kullanımıyla aynı değildir. | N23 §4; LE capacity / K/Y |
| ECC-TL37 — counted session population | Pending, Running, Idle ve Stale kayıtlarının kapasite hesabına girmesi. Yalnız live process sayısı veya bütün completed görev nüfusu değildir. | N23 §4; LE capacity / K |
| ECC-TL38 — remaining slots | Limitten mevcut sayılan session'lar düşülerek elde edilen gözlenmiş boş slot sayısı. Bir miktardır; yetersizliğinde bütün template'i reddetme işlemi TL74, reservation sınırı TL39'dadır. | N23 §4; LE capacity / K/Y |
| ECC-TL39 — observed capacity versus reservation | Read/check ile sonraki session insert'leri arasındaki sahiplik ayrımı. İki caller aynı boşluğu görebilir; lower queue bu kontrolü multi-caller claim'e çevirmiyor. Koşullu karşı-örnektir, oversubscription testi değildir. | N23 §4; LE capacity / Y/K |
| ECC-TL40 — source anchor in capacity | Önceden var olan source session'ın sayılan nüfusa girdiği durumda kapasiteyi tüketmesi. Anchor kullanmak otomatik ücretsiz slot veya dışsal bir kimlik demek değildir. | N23 §4; LE capacity / K/Y |
| ECC-TL41 — worktree capacity | Session-budget kontrolünden ayrı çalışma ortamı kapasitesi. Session slot'u olması hemen worktree, ready harness veya sırayla tamamlanma sağlamaz. | N23 §4; LE capacity / K/Y |
| ECC-TL42 — Pending worktree step | Worktree isteyen bir step'in runner başlamadan Pending kayda/queue'ya kabul edilip başarıyla dönmesi. Sonraki worktree=false step'in launch etmesini engellemek zorunda değildir. | N23 §4; LE capacity / K/Y |
| ECC-TL43 — ordered per-step admission | Loop'un her queue/admission çağrısını await ederek sonraki step'e geçmesi. Await edilen olay önceki process completion, output doğrulaması veya insan kabulü değildir. | N23 §4–5; LE binding / K/Y |

## 6. Anchor, handoff ve predecessor ayrımı

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL44 — common anchor | Step handoff'larının ortak source'a bağlandığı ilişki düzeni. Otomatik step1→step2→step3 dependency zinciri değildir. | N23 §5; LE binding / K/Y |
| ECC-TL45 — --from-session handoff source | Source verilmişse bütün yeni step'lerin handoff aldığı session. Origin/grouping ilişkisi execution policy veya revision mirası sağlamaz. | N23 §3, §5; LE binding / K/Y |
| ECC-TL46 — first-created standalone anchor | Source yokken ilk yaratılan step'in anchor olması; sonraki step'ler ondan handoff alır. İlk anchor'a bu template tarafından inbound handoff yazılmaz; ilişki bütün run provenance'ı değildir. | N23 §5–6; LE binding/discovery / K/Y |
| ECC-TL47 — direct new-session creation | Template'in step'leri assignment/delegate reuse selector'ından geçirmeden yeni session olarak oluşturması. Anchor etiketi o başka selector'ın ownership veya seçim kontrollerini bu yola eklemez. | N23 §5; LE binding / K/Y |
| ECC-TL48 — task through launch path | Yeni child'ın görev metnini initial launch yolundan alması. Ek handoff kaydının actual consumption/acknowledgement'ı değildir. | N23 §5; LE binding; BC20 / K/Y |
| ECC-TL49 — additional template handoff | Launch girdisinden ayrı oluşturulan mesaj/ilişki kaydı. Optional backlog controller ile etkileşimi BC21–BC26'nın enabled-automation/consumer sınırlarıyla okunur; her template'in tekrar iş ürettiği söylenmez. | N23 §5; LE binding; N22 bağlantısı / K/Y |
| ECC-TL50 — predecessor completion | Sonraki step'ten önce önceki process'in bitmesini bekleme sorusu. İncelenen loop admission dönüşünü bekler, process bitişini değil. Biten işin çıktısının kabul edilmesi TL73'te ayrı tutulur. | N23 §5; LE binding / Y/K |
| ECC-TL51 — output-dependent variable | Önceki step sonucuyla sonraki girdiyi üretme sorusu. Task substitution baştan tamamlandığından bu path içinde launch sonrası predecessor output'una bağlı yeniden substitution gösterilmez. | N23 §2, §5; LE binding / Y/K |
| ECC-TL52 — planner/reviewer step names | Kaynak fixture'ındaki rol açıklayıcı adlar. Reviewer adının bulunması planner'ın accepted plan'ını bekleyen mekanik gate kurmaz. | N23 §1, §5, §7; LE CFGTEST / T/Y |

## 7. Sonuç, kısmi etki ve yeniden deneme

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL53 — TemplateLaunchOutcome | Bütün launch çağrısı başarılı bittiğinde döndürülen toplu admission sonucu. Per-step accepted output veya immutable template-run kaydı değildir. | N23 §6; LE M/discovery / K/Y |
| ECC-TL54 — CLI template summary | Yalnız bütün çağrı başarılı döndükten sonra yazdırılan özet. Özet dönmemesi önceki session/profile/message/log kayıtlarının da yok olduğu anlamına gelmez. | N23 §6; LE C/discovery / K/Y |
| ECC-TL55 — immutable template-run id | Tek template yürütmesini ve step'lerini kalıcı ilişkilendirme sorusu. İzlenen writer böyle bir run id saklamıyor; session id veya anchor ile eşitlenmez. | N23 §6; LE discovery/retry / Y/K |
| ECC-TL56 — complete resolved-input record | Bütün çözümlenmiş girdilerin o run için değişmez saklanması sorusu. Per-session profile/task izleri complete template input provenance yerine geçmez. | N23 §6; LE discovery/retry / Y/K |
| ECC-TL57 — next-step resume checkpoint | Başarısız step'ten devamı belirleyecek kalıcı ilerleme noktası sorusu. İncelenen retry, checkpoint'ten devam etmek yerine yeniden resolution/admission yapar. | N23 §6; LE discovery/retry / Y/K |
| ECC-TL58 — post-admission failure | Loop başladıktan sonra queue, anchor resolution veya handoff/projection işlemlerinin hata verebilmesi. Pre-effect validation'ın varlığı bu sonraki etkileri geri almaz. | N23 §6; LE partial failure / K/Y |
| ECC-TL59 — missing partial-outcome return | Sonraki error'da birikmiş önceki admission sonuçlarının normal dönüş olarak verilmemesi. Partial report yokluğu daha önceki etkilerin yokluğu değildir. | N23 §6; LE partial failure/discovery / K/Y |
| ECC-TL60 — template-wide rollback | Önceki step'lerin etkilerini topluca geri alma sorumluluğu. Bu loop'ta gösterilmez; tek session'a ait cleanup TL64 ile aynı işlem değildir. | N23 §6; LE partial failure / Y/K |
| ECC-TL61 — worktree_branch_prefix | Worktree branch adı için kullanılan config girdisi; normalize sonrası boş olması ilgili validator tarafından reddedilir. Her no-worktree veya capacity-wait dalının aynı anda kontrol ettiği varsayılmaz. | N23 §6; LE W / K/Y |
| ECC-TL62 — branch_name_for_session | Worktree create yolunda boş prefix'i Git branch validation öncesinde reddeden helper. Bu gerçek ret, önceki template step'lerinin compensation'ı değildir. | N23 §6; LE W / K |
| ECC-TL63 — later-worktree-step countercase | İlk no-worktree step başarıyla admit edilmişken ikinci worktree step'in boş prefix nedeniyle hata vermesi; yeterli session ve mevcut worktree kapasitesi koşullarıyla. Worktree doluysa ikinci step queue'ya gidebilir. Kaynak çıkarımıdır, çalıştırılmış incident değildir. | N23 §6; LE partial failure; ME discriminators / Y |
| ECC-TL64 — individual queue cleanup | Wrapper-start error'da o session'ı Failed işaretleyip worktree'sini kaldırma girişimi. Cleanup başarısı veya önceki template step'lerinin geri alındığı garanti değildir. | N23 §6; LE partial failure / K/Y |
| ECC-TL65 — fresh template retry | Resolution, kapasite kontrolü ve yeni session creation'ın tekrar çağrılması. Önceki step'leri yeniden yaratabilir veya kalan counted session'lar nedeniyle daha başta kapasite reddi alabilir; checkpoint resume değildir. | N23 §6; LE discovery/retry / K/Y |
| ECC-TL66 — later harness failure | Wrapper admission'ından sonra gerçek harness'ta oluşan hata. Template komutunun başarılı admission dönüşüne senkron olarak taşındığı garanti değildir; accepted work ile eşitlenmez. | N23 §6; LE discovery/retry / K/Y |

## 8. Test ve dış sözleşme dili

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL67 — template resolver tests | Planner/reviewer alanlarının çözümlemesi ve required variable eksikliğinin reddi için config testleri. Araştırmada incelendi, koşulmadı; dependency order, rollback veya task quality testi değildir. | N23 §1, §7; LE CFGTEST / T/Y |
| ECC-TL68 — CLI variable-map tests | Template argümanı, map oluşturma ve invalid entry reddini sınayan test tanımları. Gerçek ortam bağlama veya başarılı çok-adımlı yürütme kanıtı değildir; koşulmadı. | N23 §7; LE C / T |
| ECC-TL69 — profile inheritance/cycle tests | Profile inheritance ve cycle kontrolünün ilgili test tanımları. Template launch'ın uçtan uca koşusu veya host enforcement doğrulaması değildir. | N23 §2, §7; LE CFGTEST / T/Y |
| ECC-TL70 — unsupported-profile-fields projection test | Configured runner için desteklenmeyen profil alanlarının task text'te görünmesini bekleyen ilgili test. U12-A consumer inquiry'sine işarettir; text'in enforce edildiği veya U12-A'nın burada tamamlandığı anlamına gelmez. | N23 §7; LE MTEST/test limits / T/Y |
| ECC-TL71 — dated regex replacement contract | Araştırmada 2026-09-19'da regex 1.13.1 etiketiyle görülen replace/replace_all sözleşmesi. Helper-call yorumunu destekleyen tarihli kayıttır; ECC Cargo.lock/crate/binary karşılığı veya bu turun yeni doküman doğrulaması değildir. | N23 §2; LE W-U11E-REGEX / H/Y |

## 9. Kaynak tarafından kapsam kontrolü

N23 §1 → TL01–TL04/TL52/TL67; §2 → TL05–TL26/TL51; §3 → TL27–TL35; §4 → TL36–TL43/TL74; §5 → TL43–TL52/TL73; §6 → TL20/TL53–TL66; §7 → TL67–TL71; §8 → ilişki görünümü ve açık sınırlar. LE U11E-W'nin dependency-sync warning karşılığı TL72'dir. Aynı kullanıma birkaç kaynak noktası yeni kavram veya bağımsız kanıt değildir.

LE'nin actual-source/full/selected/incidental/retained/test ayrımları, joined mechanism, regex sözleşmesi ve retrieval sınırları tam okundu. ME yöntem ve discriminator seçimini; PE yayın karşılığını ve reddedilmiş aday/concurrency tarihini taşır. Bunlar aynı ürün iddiasına dört bağımsız destek değildir. Tarihsel catalogue text-emission hataları target mekanizma hatası veya bu turun yayın arızası sayılmadı; eski rejected Git objects yeni branch/merge işi değildir.

Kaynak testlerinin planner/reviewer örneği bir fixture olarak korundu. Örnek değerler, role adları, Rust hata yayılımı işareti, method/source locator'ları ve commitler genel teknoloji sözlüğüne çevrilmedi. Başka bir dependency'nin veya isimli fonksiyonun yalnız anılması full body okuması sayılmadı. U11-E source-only inquiry'dir; eski E08/E07 veya sonraki Python E09 template deneyi değildir.

## 10. İlişki, karşılıklar ve yorum izi

Kaynak akışı iki düzeyi ayırır: **caller/map/context (TL04–TL13) → loop öncesi bütün-template hazırlığı ve kapasite kontrolleri (TL14–TL26, TL30, TL36–TL40, TL74) → her step için profil seçimi / admission / anchor-handoff (TL27–TL35, TL41–TL49) → başarılı toplu summary (TL53–TL54)**. Global default profilin önceden çözülmesi, her step'in loop içindeki effective profil seçimiyle aynı işlem değildir; hazırlık grubundaki her işlemin kendi arasındaki satır sırası bu özetle ilan edilmez. TL58–TL66, etkiler başladıktan sonraki hata ve retry sınırını taşır. Bu görünüm evrensel workflow mimarisi değildir.

**Olumlu güvenceler ayrı korundu:** unknown template/empty list/recognized missing variable reddi; isimli profile doğrulama ve cycle kontrolü; bütün step'lerin önceden çözülmesi; mevcut session'ları düşen gerçek kapasite kontrolü; explicit profile seçimi; Pending worktree retention; individual cleanup girişimi; alttaki session/profile/message/log kayıtlarının varlığı. Daha güçlü accepted multi-step outcome yokluğu, yeniden kullanılabilir setup işlevini değersiz veya başarısız vaat saymak için kullanılmadı.

**Önceki kayıtlarla sınır:** SC28 scheduler'ın batch limit'idir; TL36 gerçekten mevcut sayılan session'ları düşer. Template'in bu olumlu kapasite kontrolü yine TL39'un concurrency reservation'ı değildir. RD39/RD40 delegate reuse, TL47 direct creation ile aynı işlem değildir. RD38 valid-name/effective-policy ayrımı TL35 ile ilişkilidir, fakat TL31'in explicit-agent/default-profile seçimi ayrı kaynak predicate'idir. N55/N56 insan plan/commit onayı TL73'teki bulunmayan predecessor-output gate'inin yerine geçmez.

BC20/BC21 launch input ve companion handoff ayrımı TL48/TL49'da korunur. BC22 repeated forwarding yalnız kendi enabled automation/consumer koşullarıyla geçerlidir; template'in zorunlu davranışı diye genellenmez. SC53, RD29 ve TL55 farklı kalıcı ilişki kapsamlarıdır: remote result_session_id gerçekten vardır; bundan immutable template-run id çıkarılmaz. O serisinin response replay'i, TL65 fresh creation retry değildir.

**Maddi anlam seçimleri:** explicit default agent ile alanı boş bırakmak eşitlenmedi; cwd metni gerçek çalışma dizini yapılmadı; all-step validation all-effect atomicity'ye çevrilmedi; common anchor predecessor dependency sayılmadı. Nested interpolation örneğinin inherited/direct çağrı farkı korundu, genel recursive-template semantics üretilmedi. İlk kaynak karşılaştırmasında önceki TERMS'i yeniden yazmayı gerektiren maddi çelişki saptanmadı. Bu hüküm hatasız/evrensel extraction garantisi değildir; somut source delta veya atlama bulunursa ilgili kayıt yeniden ele alınır.

### İlk source/readback kontrolünün düzeltmesi

İlk yayın **a7fbf6a67dfba609c6651c619c2346b6bd067f99** ilişki özetinde profile selection'ı kapasite ve admission'dan önce tek bir faz gibi gösteriyordu. N23 §3 ve LE profiles, global default hazırlığı ile step başına loop içi seçimi ayırır; ilişki görünümü buna göre düzeltildi. TL27–TL35'in kendi kullanım metinleri zaten bu ayrımı taşıyordu ve değiştirilmedi; TL20/TL36–TL43 ile ilişki kontrol edildi.

Aynı karşılaştırmada TL38'de slot miktarı ile ret işlemi, TL50'de process bitişi ile çıktı kabulü ayrı adreslenmediği için ayrıldı: TL38 miktar/TL74 ret; TL50 completion/TL73 accepted predecessor output. İlişkili TL36/TL39/TL43/TL51/TL52/TL59/TL60 ve N55/N56 yönlendirmesi kontrol edildi. LE U11E-W'deki yalnız uyarı veren dependency-sync sonucu ilk dökümde adreslenmemişti; TL72 eklendi. Kaynak araştırma veya önceki TERMS değişmedi. Bunlar extractor aktarım/kapsam düzeltmeleridir, yeni ürün bulguları değildir.

| ID / özgün ifade | Bu araştırmadaki karşılık ve sınır | Dayanak / rol |
|---|---|---|
| ECC-TL72 — dependency-sync warning | Worktree başarıyla oluşturulduktan sonraki dependency-sync failure'ın warning-only ele alınması. Worktree creation başarısı bütün dependency hazırlığının başarılı olduğu anlamına gelmez; branch-prefix refusal ile aynı error sınıfı değildir. | LE exact sources, U11E-W / K/Y |
| ECC-TL73 — accepted predecessor output | Önceki step çıktısını inceleyip kabul ölçütüyle sonraki step'e dayanak yapma sorusu. Process bitişi TL50'den ayrıdır; incelenen loop böyle bir acceptance testi/output binding yapmıyor. | N23 §5; LE binding / Y/K |
| ECC-TL74 — insufficient-slot refusal | Gözlenen remaining slots bütün template step'lerine yetmediğinde loop öncesi ret işlemi. Miktarın kendisi TL38'dir; gerçek pre-effect koruma reservation veya bütün concurrency koşullarının kontrolü değildir. | N23 §4, §6; LE capacity / K/Y |

## 11. Kapanış ve açık sınır

**ECC-TL01–TL74**, 74 adreslenebilir kaynak-bağlı kullanım kaydıdır; bağımsız kavram, deney veya ilerleme yüzdesi değildir. Bu dört dosyanın aktarımı U11-E'yi kapsar. U11-A–D'nin korunmuş aktarımıyla birlikte C5b/U11 source-family dilimi tamamlanabilir; final readback ve current READING/TERMS/STATE ayrıca kapanır. Bu dosya tek başına package-wide C6 veya ECC research closure değildir.

Q04e4b; host/process readiness/completion, concurrent reservation, crash/retry/idempotency, immutable template-run provenance, arbitrary/migrated configuration, literal/nested interpolation intent, repository/revision/policy correspondence ve accepted multi-step outcomes bakımından açık kalır. Bunlar otomatik yeni Concepts deney borcu veya benimsenmiş SOUL gereksinimi değildir. Yeni template/Rust/SQL/worker/model/provider/test/installation/upstream işlemi yapılmadı; önceki evidence sınıfları ve E06 exclusion korundu.

Batu okuma anındaki anlam seçimlerini denetleyemediğinden önemli dayanak ve yorum sınırları görünür tutulur. Ortak sözcükler ortak anlamı garanti etmez; kaynak kullanımı, araştırmacı yorumu, extractor açıklaması ve kullanıcı onayı birbirinin teknik doğrulaması değildir.

Sıradaki Concepts işi **C5c / U12-A — execution profiles ve harness consumers**, Note24'tür. U12-A/B1/B2/C, C6 ve B7/B8 bu dosyayla okunmuş/tamamlanmış sayılmaz.
