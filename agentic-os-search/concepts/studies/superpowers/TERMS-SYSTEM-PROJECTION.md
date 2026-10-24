# Superpowers — Bütünsel model, proje-karşılaştırmalı dil ve kapanış

2026-09-20, **B6-T10 / U08-KAYNAK-KAYDI-TAMAM / PAKET-KAPANIŞI-KAYNAK-KONTROLLÜ**. [TERMS.md](TERMS.md)'nin bağlı parçasıdır. Önceki ENTRY, WORK, VERIFICATION-DELIVERY, EVOLUTION-EVALUATION ve RUNTIME-DISTRIBUTION kayıtları korunur. Bu dosya S05/S06 ve U08-A/B/C'nin araştırma-sentez dilini kaydeder; ürünün resmî sözlüğü, Foundation kararı, SOUL/Development OS mimarisi veya diğer studies için tamamlanmış çıkarım değildir.

## 1. Kaynak kapsamı ve yeniden üretim statüsü

Araştırma deposu `batuhanozgun/agentic-os-search`; sabit araştırma/P2 ref'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**; Superpowers paket tree'si **56c19a5e2c0deb7b0f5164aac818ed2ba98baf12**. Dış hedef ayrı kimliktir: `obra/superpowers@b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, manifest bağlamı 6.3.0.

| Kod | Kaynak | Bu kayıttaki rol |
|---|---|---|
| S05 | `syntheses/S05-native-system-model.md` | Bütün sistemin dört analitik görünümü, iki döngüsü, composition register'ı, yetki ve handoff nitelemeleri. Tam okundu. |
| S06 | `syntheses/S06-project-facing-contribution-and-comparison.md` | Foundation ve seçilmiş comparator kayıtlarıyla proje-yüzlü katkı dili. Tam okundu; atfedilen diğer studies bu nedenle concepts açısından tamamlanmış sayılmaz. |
| U08-A | `SOURCE-LEDGER-U08A.md` | S02–S05 üretim/provenance, issue #2203 kaydı ve native-model challenge sınırları. Tam okundu. |
| U08-B | `SOURCE-LEDGER-U08B.md` | Foundation/project snapshot, gstack/Hermes/Flowable seçici reuse ve S06 provenance. Tam okundu. |
| U08-C | `SOURCE-LEDGER-U08C.md` | Freshness, final source-side challenge, issue #2202 ve bounded closure kaydı. Tam okundu. |

Bu beş dosyanın okunması onların atıf verdiği Foundation, gstack, Hermes, Flowable veya dış issue kaynaklarını bu tur tam okuduğumuz anlamına gelmez. S06'nın karşılaştırma dili **Superpowers araştırmasının araştırmacı sentezidir**; comparator studies'in concepts çıkarımı ayrıca kendi paketlerinde yapılacaktır.

P2 pilotunun tarihsel **SP150–SP160** grubunun varlığı önceki concepts durum kayıtlarında korunmuş olsa da, özgün satır metinleri kalıcı repoda bulunmuyor ve bu tur aktif bağlamda güvenilir biçimde geri getirilemiyor. Bu yüzden eski SP150–SP160 kimliklerine tek tek anlam ataması **uydurulmadı**. METHOD §8'e uygun biçimde aşağıdaki U08-R adresleri sabit kaynaktan yeniden çıkarıldı. Ana TERMS, tarihsel SP150–SP160 grubunu bu kaynak-kontrollü yeniden üretime bağlar; birebir legacy-row eşleşmesi iddia etmez.

İki çalışma riski burada da geçerli: okuma anındaki anlam seçimleri kullanıcı tarafından anlık denetlenemediğinden dayanak ve yorum sınırı görünür tutulur; aynı sözcük ortak anlamı garanti etmediğinden kullanıcı onayı, kaynak kullanımı ve extractor yorumu teknik doğruluk yerine konmaz.

## 2. Bütünsel açıklamanın araştırma dili

| Adres / özgün ifade | Bu araştırmadaki kullanım | Kaynak rolü ve sınır |
|---|---|---|
| U08-R01 — Native whole-system model / analytical views | Availability/runtime/distribution, intent/planning/context handoff, execution/verification/delivery ve skill evolution/evaluation görünümlerinin aynı kaynak ailesini açıklamak için birlikte kullanılması. | S05 §1. Dört bağımsız program, ürün modülü veya zorunlu SOUL bileşeni değil. |
| U08-R02 — Development-work loop | İsteğin uygun çalışma yoluna alınması; gerektiğinde spec/plan, görev, uygulama, inceleme, düzeltme ve teslim yoluyla ilerlemesi. | S05 §3. Her istek tek lineer SDLC veya mutlaka SDD değildir. |
| U08-R03 — Method-change loop | Gözlenen işten yöntem değişikliği ihtiyacına, skill müdahalesi/değerlendirme/admission ve dağıtıma uzanan ayrı süreç. | S05 §3; S01. Her işten otomatik öğrenen self-improvement servisi değildir. |
| U08-R04 — Composition register | Farklı skill/rol/rota talimatlarının görünürdeki gerilimlerini scope, actor, stage ve object üzerinden sınıflandıran araştırmacı tablosu. | S05 §6. Evrensel precedence engine veya ürün runtime kaydı değil; bazı gerilimler açık bırakılır. |
| U08-R05 — Stage- and action-dependent authority | Intent approval, controller ruling, task acceptance, publication izni ve maintainer acceptance gibi yetkilerin farklı eylem/nesnelere bağlı olması. | S05 §5. Tek bir global approval veya role-rank kuralı çıkarılmaz. |
| U08-R06 — Qualification at handoff | Bir üreticinin sınırlı ama yararlı sonucunun tüketici tarafından daha geniş bir hükme yükseltilmemesi gereksinimini anlatan sentez teması. | S05 §7. Ölçülmüş yaygınlık veya tek kök neden iddiası değil. |
| U08-R07 — Present / meaning / authority / realized effect | Ne bulunduğu/gözlendiği, bunun bu iş için ne anlama geldiği, sonraki eylemi kimin yetkilendirebildiği ve fiilen ne olduğunun ayrı tutulması. | S05 §7. Zorunlu dört alanlı veri şeması veya yeni proje ontolojisi değil. |
| U08-R08 — Light process / light coordination | Daha az hazırlık artefaktının controller context'i, toplam maliyet, insan kesintisi veya kaliteyi otomatik azaltmadığını anlatan ayrım. | S05 §8 ve I01/I02. Issue raporu benchmark veya neden kanıtı değildir. |
| U08-R09 — Countermodel check | Prompt-only, universal-injector, all-SDD, same-version/same-payload gibi aşırı açıklamaları daha az merkezi kaynak aileleriyle sınama. | S05 §9; U08-C. Aynı assistant'ın source-directed challenge'ı; bağımsız doğrulama değil. |

S05'in “portable development methodology” formülasyonu ana TERMS/SP01'i daha bütünlüklü açıklayan araştırmacı sentezidir; yeni bir ürün sınıfı kabulü değildir. Controller'ın semantik koordinasyon rolü WORK kayıtlarındaki somut görev/brief/review ilişkileriyle bağlanır; bu dosyada ikinci bir ürün-native controller tanımı oluşturulmaz.

## 3. Proje-yüzlü araştırma dili

| Adres / ifade | Yerel kullanım | Dayanak ve sınır |
|---|---|---|
| U08-R10 — Candidate means, not goal | Superpowers'ın SOUL hedefinin kendisi değil, Development OS ve daha genel target reasoning için aday mekanizma/countercase kaynağı olması. | S06 §2. Adoption veya ürün sıralaması değil. |
| U08-R11 — Selected-task coverage / pursuit-prerequisite coverage | Seçilmiş planın görevlerinin kapsanması ile hedef için gerekli bütün iş/prerequisite'ların keşfedilmiş olması arasındaki fark. | S06 §3; Foundation Work reuse. Superpowers incident'i olarak gözlenmiş eksik görev iddiası değil. |
| U08-R12 — Common adequate and available view | Bir aktörün görevi için yeterli olan ve aynı aktör tarafından gerçekten erişilebilir ortak nitelikli görünüm. | S06 §4; Foundation Information reuse. Herkese tüm geçmişi verme kuralı değil. |
| U08-R13 — Established complementary side information | Kompakt handoff'un ancak tüketicinin gerçekten sahip olduğu ve güvenilir biçimde erişebildiği tamamlayıcı bilgiyle yeterli olabilmesi. | S06 §4. Varsayılan özel bellek veya başka aktörün bilgisi otomatik complement sayılmaz. |
| U08-R14 — Competence / participation / authority / technical reach / accountability | Bir aktörün yapabilmesi, sürece katılması, karar verebilmesi, etki üretebilmesi ve sonuçtan sorumlu olması arasındaki ayrımların karşılaştırmada kullanılması. | S06 §5; Foundation Actors reuse. Superpowers'ın resmî rol taksonomisi değil. |
| U08-R15 — Qualified completion / progress standing | Complete/green ifadesinin belirli nesne, ölçüt, artık risk, kanıt ve yetkilendirilmiş sonraki eylemle birlikte yorumlanması. | S06 §6. Evrensel tek durum şeması değil. |
| U08-R16 — Exact binding / criterion-relative standing / realized control / propagation | Bir sonuç veya kararın doğru nesne/sürüme bağlanması, hangi kritere göre durduğu, kontrolün gerçekten uygulanması ve etkisinin sonraki yüzeylere taşınması için kullanılan Foundation-karşılaştırma dili. | S06 §6 ve Foundation reuse. Ürün-native alanlar değil. |
| U08-R17 — Returned influence / persistent adaptation | Geri beslemenin sonraki davranışı gerçekten değiştirip değiştirmediği ve bu değişimin kalıcı/yararlı olup olmadığına ilişkin karşılaştırma dili. | S06 §8; Foundation reuse. Skill dosyasının değişmesi veya metric'in değişmesi tek başına bunu kanıtlamaz. |
| U08-R18 — Realized consumer path | Kaynak/paket/dosya mevcudiyetinden, belirli tüketicide gerçekten etkin ve uygulanabilir duruma uzanan yol. | S06 §7; S02. Genel deployment standardı değil. |
| U08-R19 — Selective comparator / functional comparison | gstack, Hermes ve Flowable'ın bütün ürün olarak sıralanması yerine belirli işlev/kanıt soruları için karşılaştırılması. | S06 §9–10. Bu üç study'nin concepts çıkarımı tamamlandı anlamına gelmez. |

S06'daki gstack “downstream consequence”, Hermes “library use vs outcome evaluation” ve Flowable “persisted transition vs persisted description” karşılaştırmaları Superpowers'ın proje-yüzlü araştırma dilidir. Comparator kaynaklarında hangi terimlerin nasıl kullanıldığı, kendi concepts paketlerinde yeniden ele alınacaktır.

## 4. Kapanış ve freshness dili

| Adres / ifade | Bu araştırmadaki kullanım | Sınır |
|---|---|---|
| U08-R20 — Bounded explanatory completion | Belirlenmiş kaynak/model sorusu için yeterli açıklamanın kurulması ve açık empirical/adoption sınırlarının korunması. | U08-C §6 ve kaynak STATE/CLOSURE-AUDIT. Universal correctness veya product certification değil. |
| U08-R21 — Source-side challenge / reverse-source check | Sentezin daha az merkezi kaynaklar, route-specific ayrımlar ve sıkıştırma hataları karşısında yeniden kontrolü. | U08-A §5; U08-C §3. Bağımsız reviewer değil. |
| U08-R22 — Freshness equality | U08-C'de 2026-09-18 günü upstream main ref'inin araştırma pin'iyle aynı olduğunun kaydı. | O tarihe ve o ref'e bağlı; bugünkü upstream/installed-host için otomatik güncellik garantisi değil. |
| U08-R23 — Route-specific delegation / return responsibility | Paralel dispatch, SDD ve alt-aktör kurallarının rota kapsamına bağlı değerlendirilmesi. | U08-C/S39/S30. Bütün agent sistemlerinin genel no-child veya re-delegation kuralı değil. |

U08-C'nin issue #2202/#2203 kayıtları participant report statüsünde tutulur; exact incident, platform kuralı veya product-wide hata oranına yükseltilmez. AGENTS.md alias ve RELEASE-NOTES kısmi okuması araştırmanın closure challenge kaydıdır; yeni product concept üretme zorunluluğu yoktur.

## 5. Kaynak-içi ilişki görünümü

Araştırmanın bütünsel açıklaması iki bağlantılı fakat ayrı döngü taşır:

**çalışma döngüsü:** uygun kaynak/yöntem → intent/plan/context → görev/uygulama → review/verification → nitelendirilmiş kabul → insanın entegrasyon/delivery kararı → gerçek etki ve korunmuş kayıtlar.

**yöntem-değişikliği döngüsü:** gözlenen sorun → müdahale seçimi/yazım → kontrollü değerlendirme → kanıt/hüküm → insan/maintainer kabulü → dağıtılmış yeni prosedür → sonraki işte ancak gerçekten etkinleşirse yeni davranış.

S05 bu döngülerin otomatik self-improvement sistemi olmadığını açık bırakır. S06 ise çalışma hedefi bakımından şu ek kontrolü getirir: seçilmiş görevleri iyi yürütmek, hedef için gerekli bütün işi keşfetmiş olmakla; uygun artefakt üretmek de gerçek tüketicinin yeterli ve erişilebilir bağlama sahip olmasıyla aynı değildir.

Bu görünüm bir Development OS/SOUL mimarisi değildir. İlk aşamanın amacı, araştırmanın kendi ilişki düzenini kaybetmeden taşımaktır.

## 6. Pilot bağı ve kaynak-kontrollü yeniden üretim

P2-T4/T5'in bütünsel/proje-karşılaştırmalı grubunun tarihsel aralığı **SP150–SP160** olarak kayıtlıdır. Özgün satır metni erişilemediğinden bu dosya exact legacy-row correspondence üretmez. Bunun yerine S05/S06/U08-A/B/C'den doğrudan çıkarılmış U08-R kayıtları kullanılır. Böylece:
- eski grubun varlığı ve kapsamı kaybolmaz;
- tek tek SP kimliğine hafızadan anlam uydurulmaz;
- kaynakta bulunan ek kullanım ve qualifier'lar da görünür olur.

Bu, METHOD §8'in kaynak kontrollü regeneration yoludur. Gelecekte özgün P2 satırları güvenilir biçimde geri kazanılırsa birebir correspondence ayrıca eklenebilir; mevcut kapanış bunun için varsayım yapmaz.

S05 §1–10, S06 §1–11 ve U08-A/B/C'nin bütün bölümleri kaynak kaydına geri dönülerek kontrol edildi. Bu kaynaklarda açıklanmış kullanımlar için somut aktarım eksiği bulunmadı. Başka studies/Foundation'a yapılan atıflar o korpusların concepts çıkarımı değildir. Kaynak soruları Q13/Q20/Q24/Q47 ve empirical sınırlar açık statüleriyle kalır; ilk aşama bunları genel araştırma borcuna çevirmez.

Bu kayıt aynı assistant'ın source/pilot/kalıcı çıktı karşılaştırmasıdır; bağımsız doğrulama, sıfır atlama garantisi, ürün etkinlik sertifikası veya ortak referans kabulü değildir.
