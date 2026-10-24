# Bellek — Bağlamlı kullanım kayıtları

**B6-T2 / D2-KAYNAK-ÇIKARIMI-TAMAM / PAKET-KISMİ.** Tarih: 2026-09-19. Bu dosya [TERMS.md](TERMS.md)'nin bellek parçasıdır; ayrı araştırma veya ortak sözlük değildir. Gerçek okuma, kaynak tarafından kapsam kontrolü ve sonraki iş [READING.md](READING.md)'dedir. Yöntem [v0.3-working](../../METHOD.md), global kapsam [S1](../../SCOPE.md).

## 1. Kaynak, ifade statüsü ve yeniden üretim sınırı

**D2:** [02-AGENT-MEMORY-ENGINEERING.md](https://github.com/batuhanozgun/agentic-os-search/blob/ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a/research/studies/context-memory-harness-engineering/02-AGENT-MEMORY-ENGINEERING.md). Repository: batuhanozgun/agentic-os-search. Sabit ref: ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a. Blob: 6203b06fe56cad61354e9093d0b404a1ee3592c7. D2'nin araştırma tarihi 2026-09-03; B6-T2 güncel dış literatür/API veya ürün davranışı doğrulaması değildir.

D2 bu tur 1–220, 221–440, 441–660, 661–880 ve 881–EOF aralıklarıyla tam okundu. Okuma sırasında kullanım notları tutuldu; ardından §1–30'dan kalıcı kayda kapsam kontrolü yapıldı. D0/D1, ana TERMS'te kaynakları tanımlanmış gerekçe ve context dosyalarıdır. D3/D4'ün kalıcı aktarımı henüz tamamlanmadı.

**Bu bellek kaydı sabit kaynaktan yeniden üretimdir; eski pilot yanıtının birebir aktarımı değildir.** P1-T1–T3'ün özgün bellek dökümü bu turun erişilebilir konuşma görünümünde yoktur. [P1 kapanış STATE'i](https://github.com/batuhanozgun/agentic-os-search/blob/53c29b54a355742960f466a06a5d9bba0a42f412/concepts/STATE.md) yöntem/okuma ve düzeltme bağlamını taşır, terim arşivi olmadığını açıkça söyler. METHOD §8'in kaynak kontrollü yeniden üretim yolu kullanıldı; STATE özetinden anlam veya numara eşleşmesi üretilmedi.

Eski **K03/K04/K08 ve M01–M28** adresleri silinmiş veya sıfır kullanım sayılmış değildir. Bu dosyanın D2-* adresleri onlarla doğrulanmış birebir eşleşme iddiası taşımaz. K03'ün yaşam döngüsü kullanımı tarihsel kapanışta; K08'in tekil kayıt kullanımı B6-T1 devam notunda anılır. Bunlar aşağıdaki U01/U03/U04 ile konu bağlantısıdır, özgün satır metninin kurtarıldığı iddiası değil. Eski yanıt sonradan erişilirse kimlik eşleştirmesi ayrıca yapılabilir; D2'nin bugünkü kaynak kapsamı bu eşleştirmeyle karıştırılmaz. P1'in tamamlanmış pilot statüsü korunur.

**Okuma anahtarı:** Atıf = önceki araştırmanın dış kaynağa atfettiği açıklama; araştırma = önceki yazarın tanımı/sentezi/önerisi/sorusu; yeni yorum = bu çıkarımın ayrıca belirtilen açıklaması. Aşağıdaki karşılıklar kaynak bağlantılı Türkçe parafrazdır, doğrudan alıntı değildir. Atfedilen kaynaklar bu tur yeniden okunmadı. Aynı satırdaki .a/.b adresleri farklı kullanımları korur; eş anlamlılık veya zorunlu ontoloji kurmaz. Kimlik sayısı kavram sayısı değildir.

## 2. Araştırma nesnesi, disiplin ve tekil kayıt

| Kimlik / özgün ifade | Bu bağlamdaki karşılık | Kaynak rolü ve sınır |
|---|---|---|
| D2-U01 — Agent memory / memory systems; state over time | Bilgi ve deneyimin zaman içinde yazılması, yönetilmesi ve okunmasıyla ilgili araştırma nesnesi/yaşam döngüsü. | D2 §1–3; write–manage–read döngüsü S1'e atıf. Tekil veri tabanı veya zorunlu ürün bileşeni tanımı değil. |
| D2-U02 — Memory Engineering | Bellek sistemlerinin bilinçli tasarım, yaşam döngüsü, doğrulama ve yönetimini adlandırmak için kullanılan pratik disiplin etiketi. | D2 §2, §26/F-MEM-01, §28–29/S9: önceki araştırmanın emerging/henüz yerleşmemiş değerlendirmesi. Etiketin bugünkü yaygınlığı burada yeniden ölçülmedi. |
| D2-U03 — Agent Memory Engineering | Hangi bilginin iç/dış bellek zeminine yazılacağını, temsilini, doğrulamasını, birleştirilmesini, güncellenmesini, değiştirilmesini/unutulmasını, geri çağrılmasını ve bağlama hangi bilgi statüsüyle taşınacağını tasarlama disiplini. | D2 §3: önceki araştırmanın açıkça genişletilmiş tanımı; S1'in birebir tanımı değil. Faaliyet, tasarlanan sistem ve saklanan tekil kayıt ayrılır. |
| D2-U04 — Memory kaydı / this memory | Kaynaktan türemiş, özetlenmiş, kullanıcı iddiasından gelmiş veya eski durumu temsil eden tekil saklı içerik; kimlik/tür/kaynak/zaman alanlarıyla söz konusu edilebilen kayıt. | D2 §6, §16, §23. Tekillik bağlamdan açıklanıyor; kaynak evrensel bellek nesnesi şeması vermiyor. U01/U03 ile aynı sözcüğün aynı ölçekteki kullanımı değil. |

D2 §3'ün storage ≠ memory correctness, retrieval ≠ recall correctness, recall ≠ context use ve retention ≠ truth ayrımları aşağıdaki yaşam döngüsü ve değerlendirme kayıtlarıyla birlikte okunur. Bunlar saklama veya retrieval'ın gereksizliği değil, tek başlarına yeterlilik sağlamadıkları yönündeki araştırma açıklamasıdır.

## 3. Yaşam döngüsü ve işlem seçenekleri

| Kimlik / özgün ifade | Bu bağlamdaki karşılık | Kaynak / ifade niteliği |
|---|---|---|
| D2-U05 — Observe / candidate formation | .a observation: olay/araç sonucu/kullanıcı sözü/karar/sonuçla karşılaşma; .b memory candidate: bunun kalıcı belleğe aday olup olmadığına karar verilmesi. | D2 §4.1, araştırmanın işlem ayrımı. Her gözlem otomatik kayıt değildir. |
| D2-U06 — Write / encode | Adayın belirli bir temsil biçimiyle yazılması. Aşağıdaki D2-REP adresleri biçim seçeneklerini ayrı tutar. | D2 §4.2. Bir temsilin seçilmiş veya uygulanmış olduğu söylenmiyor. |
| D2-U07 — Validate / qualify | Yazılan içeriğin kullanıcı iddiası, kaynak gözlemi, model çıkarımı, kabul edilmiş karar, hipotez veya geçici plan oluşunu ayırma. | D2 §4.3, §7. Niteleme ile gerçekten doğrulanmış olma aynı şey değil; D2-Q kayıtları statü seçenekleri. |
| D2-U08 — Consolidate / organize | Deneyimleri düzenleme ve daha üst düzey yansıtma/soyutlamalara dönüştürme. | D2 §4.4, §14: Generative Agents/S2 ve survey/S5 atıfları; kayıplı dönüşüm ve false synthesis riski önceki araştırmanın değerlendirmesi. |
| D2-U09 — Update / supersede / contradiction handling | .a update: değişen bilgiyle kaydı güncelleme; .b supersede: öncekinin yerini alan kayıt/statü ilişkisi; .c contradiction handling: çelişen kayıtları ele alma. | D2 §4.5, §8. Knowledge updates S3'e atfedilir; somut politika seçimi açık. D2-UP seçeneklerine bak. |
| D2-U10 — Retain / expire / forget | .a retain: içeriği tutma; .b expire: geçerlilik/kullanım süresinin sona ermesi; .c forget: artık tutulmaması veya kullanılmaması yönündeki işlem alanı. | D2 §4.6, §15–16. Kaynak bütün silme biçimleri için tek mekanizma tanımlamaz; U29/U31 bu sınırı taşır. |
| D2-U11 — Read / retrieve | Mevcut sorgu/durum altında hangi belleğin geri çağrılacağı. | D2 §4.7, §9. D2-R ölçütleri birbirine indirgenmez; tek sıralama algoritması verilmemiş. |
| D2-U12 — Inject / use | Geri çağrılan içeriğin mevcut model bağlamına girmesi ve kullanılması yönündeki geçiş. | D2 §4.8, §23; araştırma açıklaması. Getirilmiş olma, seçilme ve modelin doğru kullanması ayrı; U36'daki seçime bak. |

### Temsil, statü ve yönetim seçenekleri

Bu listeler D2'nin kendi seçenek dilini kaydeder; uygulanmış veri modeli değildir. Ayrı adresler aynı kavram oldukları varsayılmadan geri bulunmalarını sağlar.

| Adres grubu | Ayrı özgün ifadeler ve kaynakta taşıdıkları rol | Kaynak |
|---|---|---|
| D2-REP | REP01 raw episode: ham olay/deneyim; REP02 normalized fact: normalize edilmiş olgu; REP03 decision record: karar kaydı; REP04 procedure: prosedür; REP05 summary: özet; REP06 relation edge: ilişki kenarı; REP07 embedding/index entry: gömme/indeks girdisi; REP08 structured state: yapılandırılmış durum. REP07.a embedding ve REP07.b index entry aynı teknik nesne ilan edilmez. | §4.2, yazma biçimleri listesi; her birinin genel teknik tanımı verilmez. |
| D2-Q | Q01 user claim; Q02 observed source fact; Q03 model inference; Q04 accepted decision; Q05 hypothesis; Q06 temporary plan. Kaydın nereden geldiği/ne statüde tutulduğu ayrımı. | §4.3, §7; accepted veya observed etiketleri bizim yeni onayımız/bağımsız gözlemimiz değil. |
| D2-UP | UP01 overwrite: üzerine yazma; UP02 version: sürümleme; UP03 temporal interval: zaman aralığıyla temsil; UP04 conflict set: çelişkili kayıtları küme olarak taşıma; UP05 invalidate: geçersizleştirme. | §4.5: yeni bilgi karşısında sorulan alternatifler, seçilmiş tek update politikası değil. |
| D2-R | R01 semantic relevance; R02 recency; R03 temporal validity; R04 work/actor scope; R05 exact key; R06 causal/relational relevance; R07 current goal. R06.a nedensel ve R06.b ilişkisel ilgi aynı ölçüt ilan edilmez. | §4.7: çağırma/seçim boyutları. Benzerlik, yenilik, geçerlilik ve yetkili kapsam ayrı. |

## 4. Bellek/state sınıfları ve otorite

| Kimlik / özgün ifade | Bu bağlamdaki karşılık | Kaynak / sınır |
|---|---|---|
| D2-U13 — Episodic memory | Belirli geçmiş etkileşim, eylem/gözlem dizisi (trajectory) veya olayın bilgisi. | D2 §5.1; Reflexion'ın episodic buffer kullanımı S6'ya atıf. API 401/token scope cümlesi açıklayıcı örnek, gerçek bu-tur gözlemi değil. |
| D2-U14 — Semantic / fact memory | Tekil olaydan soyutlanmış, daha genel bilgi. | D2 §5.2: araştırma sınıflaması. Bir cümlenin fact olarak yazılması doğruluğunu kendiliğinden sağlamaz. |
| D2-U15 — Procedural / workflow memory | Bir işin nasıl yapılacağına ilişkin bilgi. | D2 §5.3; workflow knowledge/environment gotchas S7'ye atıf. Örnek release sırası genel veya bize verilmiş talimat değil. |
| D2-U16 — Working/session state | Mevcut işin ilerleme, plan, bekleyen çağrı, hesap notu ve geçici hipotezleri. | D2 §5.4. Kalıcılık süresi uzun dönem olgu belleğinden farklı olabilir; long-term belleğe otomatik terfi yok. |
| D2-U17 — Canonical operational/project state | Repo/veri tabanı/source-of-truth üzerinden otorite taşıyan güncel iş/proje durumu. | D2 §5.5, §21–22: araştırmanın proje açısından eklediği sınıf. Sırf agent'ın hatırladığı içerikle aynı statüye konmuyor. |
| D2-U18 — Source of truth / authority precedence | .a source of truth: yetkili kaynağın referans rolü; .b candidate precedence: güncel otoritatif kaynak/durumun doğrulanmış türetilmiş bellekten, onun da doğrulanmamış/heuristic bellekten önce gelmesi önerisi. | D2 §6, §18.8, §21. Aday epistemik sınır, uygulanmış evrensel öncelik algoritması veya yeni mimari kararı değil. |
| D2-U19 — Write / management / read / context-use correctness | Dört ayrı doğruluk yüzeyi: neyin yazıldığı, nasıl yönetildiği, neyin çağrıldığı ve bağlamda nasıl kullanıldığı. | D2 §7; .a write, .b management, .c read, .d context-use. Kaynaktaki çarpım gösterimi bağımlılık anlatımıdır; ölçülmüş olasılık/başarı formülü sunulmuyor. |
| D2-U20 — Temporal update / conflict | .a farklı zamanlarda değişen doğru değer; .b aynı geçerlilik aralığında uyuşmayan kaynakların yaratabileceği gerçek çatışma. | D2 §8. Bölge ve owner örnekleri örnektir; her değer farkı çelişki, her yeni kayıt doğru güncelleme sayılmaz. |

### Zaman ve kayıt alanları

Bu alanlar D2 §8 ve §23'ün listelerindendir. Açıklamalar alan adlarının o bağlamdaki rollerini belirtir; mevcut bir JSON/API sözleşmesi veya zorunlu SOUL şeması oluşturmaz.

| Adres / özgün alan | Yerel rol ve ayrım | Kaynak |
|---|---|---|
| D2-T01 — observed_at | Gözlemin ne zaman yapıldığı. | §8; olgunun geçerli olduğu zamanla birleştirilmez. |
| D2-T02 — valid_from; D2-T03 — valid_to | Bilginin geçerlilik aralığının başlangıç ve bitişi. | §8; iki ayrı alan. |
| D2-T04 — created_at | Bellek kaydının oluşturulma zamanı. | §23; T01 ile eşit oldukları belirtilmiyor. |
| D2-T05 — valid_time | Bağlama aktarımda geçerlilik zamanı bilgisinin taşınması. | §23; T02/T03'le ilişkili, aynı alan biçimi ilan edilmez. |
| D2-MD01 — source identity; D2-MD02 — source authority | Hangi kaynak olduğu ile o kaynağın otoritesi. | §8; kimlik tek başına doğruluk/otorite değil. |
| D2-MD03 — supersedes; D2-MD04 — superseded_by | Yerini aldığı kayıt ile onun yerini alan kayda ilişkin ters yönlü ifadeler. | §8 ve §23. Kaynak sürüm ilişkilerini anıyor; uygulanmış referans kısıtı gösterilmiyor. |
| D2-MD05 — confidence/status; D2-MD06 — confidence / verification status | Güven/statü ve doğrulama niteliğini taşımaya yönelik alan adları. MD05.a confidence, MD05.b status; MD06.a confidence, MD06.b verification status ayrı adreslerdir. | §8 ve §23. Sayısal eşik veya evrensel statü kümesi verilmez; iki bağlamın aynı şema olduğu varsayılmaz. |
| D2-MD07 — work/project scope; D2-MD08 — actor/work scope | Kaydın ilgili olduğu iş/proje veya aktör/iş kapsamı. | §8 ve §23; §16 tenant scope'u da sorgular. Kapsam bilgisi izin uygulamasının kanıtı değil. |
| D2-MD09 — memory_id; D2-MD10 — memory_type | Tekil bellek kaydının kimliği ve türü. | §23; seçilmiş kimlik formatı veya taxonomy yok. |
| D2-MD11 — epistemic_status; D2-MD12 — source_refs | Kaydın bilgi bakımından statüsü ve dayandığı kaynak referansları. | §23; D2-Q sınıflarıyla ilişkili, uygulama eşleştirmesi kurulmamış. |

## 5. Yakın mekanizmaların D2 içindeki kullanımları

| Kimlik / özgün ifade | D2'deki rol | Kaynak / atıf sınırı |
|---|---|---|
| D2-U21 — RAG | Bazı bellek düzenlerinde dış, parametrik olmayan kanıt/bellek içeriğini getirip bağlama besleyen okuma mekanizması. | §9, §26/F-MEM-06; önceki ai-knowledge-strategies araştırmasına dayanan sentez. Yazma, yönetim, süre, izin ve güncelleme yaşam döngüsünün tamamıyla eşit değil. |
| D2-U22 — Knowledge Graph | İlişki ağırlıklı kalıcı bilginin aday temsil zemini. | §10, §26/F-MEM-07; önceki KG araştırmasına atıf. Edge ≠ fact, çıkarılmış/tahmin edilmiş ilişkinin statüsü ve graph miss ≠ absence ayrımları korunur. Örnek Actor/Decision/Fact kenarları benimsenmiş şema değil. |
| D2-U23 — CAG / prompt cache / KV cache | .a CAG, .b prompt cache, .c KV cache: araştırmada tekrarlanan hesaplama/bağlamın yeniden kullanımıyla ilişkilendirilen adlar. KV cache için model/prefix/runtime kimliğine bağlılık ve invalidation ihtiyacı belirtilir. | §11, §26/F-MEM-08; önceki CAG araştırması. Kaynak bunları bu bölümde ayrıntılı karşılaştırmaz; eş anlamlı ilan edilmez. Persistent computational state, semantic fact store veya source authority ile aynı değil. |
| D2-U24 — Long Context | Aynı inference bölümü içindeki geniş mevcut çalışma kümesi. | §12, §26/F-MEM-09. Zaman içindeki survival/update/read problemiyle karşılaştırılır; büyük pencere kalıcı bellek yaşam döngüsünün tamamı değil. |
| D2-U25 — Virtual context / hierarchical memory | Sınırlı hızlı bağlam ile daha büyük harici bellek arasında veri hareketiyle bağlam sınırını yönetme. | §12 ve §29/S4, MemGPT'ye atıf. İşletim sistemi benzetmesi kesin uygulama reçetesi değil. |
| D2-U26 — Parametric memory / Fine-Tuning / parametric adaptation | .a model ağırlıklarına ilişkin memory adlandırması; .b ağırlıkları değiştiren fine-tuning; .c memory-like persistence sağlayabilen parametrik uyarlama. | D2 §13. Araştırmanın operational bellek yaşam döngüsüyle ayırdığı yüzey; internal/external geniş D2 §3 tanımıyla kapsam farkı bu kullanım dosyasının §10'unda ayrıca açık tutulur. |
| D2-U27 — External memory | Kaynak kimliği taşıyabilen, incelenebilen, sürümlenebilen, güncellenebilen/silinebilen harici içerik. | §13: karşılaştırmalı araştırma anlatımı. Özellikle olabilir niteleyicisi korunur; her harici deponun bu özellikleri sağladığı doğrulanmıyor. |
| D2-U28 — Reflection memory / verbal reflection | Gözlem veya görev geri bildiriminden model yorumu yoluyla türetilip saklanan düşünsel ders/yansıtma. | §14, §4.4, §29/S2/S6. Fayda açıklaması dış çalışmalara atıf; yanlış nedensel ders, aşırı genelleme, self-assessment ve tekrar güçlenme riskleri araştırma değerlendirmesi. |

D2'nin bu bağlantıları, RAG/KG/CAG/Fine-Tuning/Long Context paketlerinin kendi concepts çıkarımını tamamlamaz. Ana TERMS'teki context kullanımlarına ek bir kaynak bağlamıdır; G01–G06'nın D4 üzerinden yapılacak paket-geneli aktarımının yerine geçmez.

## 6. Unutma, erişim ve geri besleme

| Kimlik / özgün ifade | Yerel karşılık | Kaynak / sınır |
|---|---|---|
| D2-U29 — Selective forgetting / expiration; retention policy | Bellek sınıfına göre tutma/sona erdirme/unutma kararlarını seçici yürütme; gereksiz saklamayı tek amaç yapmama. | §15, §4.6. Privacy/minimization, stale/revoked/superseded içerik, düşük değerli gürültü ve bütçe gerekçeleri; kritik nadir ders, provenance chain veya karar gerekçesi kaybı karşı riskleri birlikte korunur. |
| D2-U30 — Privacy / access control / read-write policy | Kaydın sahibi, Work/tenant/Actor kapsamı, kaynağı, süresi, yazmada hassas içerik filtresi ve okumada güncel izin soruları. | §16. Şifreli saklama tek başına bütün politika sorusunu çözmüş sayılmaz. Bu tur hukuki uyum veya çalışan güvenlik sistemi doğrulanmadı. |
| D2-U31 — Source deletion / derived copies / use path | .a kaynağın silinmesi; .b ondan türetilmiş kopyaların durumu; .c iptal edilmiş/yerine yenisi geçmiş belleğin kullanım yolundan çıkarılması. | §16, §18.9, §27.7. Kaynak bunları farklı sorularda ele alır. Kullanımdan çıkmış olmanın bütün kopyaların silindiğini göstermediği ayrımı bu sorulara bağlı yeni açıklamadır; belirli ürün hakkında gözlem değildir. |
| D2-U32 — Memory poisoning / self-reinforcement / pseudo-evidence | .a memory poisoning: bölüm başlığındaki risk adı; .b self-reinforcement: model çıkarımının yazılıp tekrar okunarak kendi eski çıkarımını güçlendirmesi; .c pseudo-evidence: desteklenmemiş model inancının kanıt görünümü kazanması. | §17. Gövdede açıklanan somut yol bu geri besleme döngüsüdür; bütün poisoning tekniklerinin genel tanımı yerine geçirilmez. Aday statü-ayrımı kuralı öneridir, uygulanmış savunma değil. |

## 7. Değerlendirme dili — önerilmiş sorular, çalıştırılmış testler değil

D2 §18'in açılışında S3/LongMemEval'e atfedilen beş yetenek adı ayrı kaynak rolündedir: **D2-E-SRC01 extraction; SRC02 multi-session reasoning; SRC03 temporal reasoning; SRC04 knowledge updates; SRC05 abstention.** Aşağıdaki daha geniş on bir başlık ise önceki araştırmanın SOUL/Development OS için önerdiği matrise aittir; hepsi S3'ün birebir test listesi gibi sunulmaz.

| Kimlik / özgün başlık | Kaynağın sorguladığı özellik | Nokta |
|---|---|---|
| D2-E01 — Write precision | Saklanmaması gereken içerik belleğe yazıldı mı? | §18.1 |
| D2-E02 — Write recall | Saklanması gereken kritik olay kaçtı mı? | §18.2 |
| D2-E03 — Update correctness | Yeni olgu öncekini doğru biçimde geçersiz kıldı/yerine geçti mi? | §18.3 |
| D2-E04 — Temporal reasoning | Farklı zamanların durumları karıştırılıyor mu? | §18.4 |
| D2-E05 — Contradiction handling | Çelişen kaynaklar tek olguymuş gibi birleştiriliyor mu? | §18.5 |
| D2-E06 — Retrieval / recall | İlgili kayıt doğru zamanda bulunuyor mu? | §18.6 |
| D2-E07 — Abstention | Bellekte bilgi yokken sistem bilmediğini söyleyebiliyor mu? | §18.7 |
| D2-E08 — Authority precedence | Eski bellek güncel canonical durumu geçersiz kılıyor mu? | §18.8 |
| D2-E09 — Forgetting / deletion | İptal edilmiş/yerine yenisi geçmiş içerik gerçekten kullanım yolundan çıkıyor mu? | §18.9; U31.a/b fiziksel kopya sorularıyla eşit ölçüm değil. |
| D2-E10 — Privacy/access | Bellek tenant veya aktör sınırından yanlış yere sızıyor mu? | §18.10 |
| D2-E11 — Downstream decision impact | Doğru bilginin geri getirilmesi fiilî iş kararını iyileştiriyor mu? | §18.11 |

Adların precision, recall veya correctness olması, D2'nin sayısal formül/eşik/bağımsız oracle kurduğu anlamına gelmez. Bu tur hiçbir bellek benchmark'ı, model koşusu, silme veya erişim testi yürütülmedi.

## 8. Oturum, proje kullanımı ve iki farklı handoff

| Kimlik / özgün ifade | Bu bağlamdaki karşılık | Kaynak / sınır |
|---|---|---|
| D2-U33 — Sessions / session persistence | Önceki konuşma öğelerini getirip sonraki tura ekleme ve yeni öğeleri saklama; history stored + replayed örneği. | §19 ve §29/S8: araştırmanın OpenAI Agents SDK'ya tarihli atfı. API bugün yeniden doğrulanmadı; history pruning, fact update, stale instruction, otorite ve türetilmiş olgu doğruluğu ayrıca açık. |
| D2-U34 — Aday SOUL bellek rolleri | .a Work continuity: karar/ilerleme/açık iş; .b environment experience: gotchas, tool quirks, hata örüntüleri; .c task-specific procedural knowledge; .d actor/project scoped durable facts; .e verification learning: önceki hataları yakalayan testlere dair öğrenme. | §20. Beş potansiyel rol; yetki/mahremiyet ve verifier ritualization riskleri koşul olarak korunur. Kurulmuş SOUL modülleri değil. |
| D2-U35 — Repo canonical state / opaque model memory | İncelenebilir, sürümlü, farkı görülebilir, kaynak bağlantılı repo durumunun opak model belleğiyle karşılaştırılması. | §21: 2026-09-03 tarihli proje yorumu. Repo içindeki source evidence/current state/historical state/hypotheses/rejected work/protocols/synthesis tek otorite sınıfı veya tek havuz yapılmıyor. Bugünkü ürün kurulumunun denetimi değil. |
| D2-U36 — Memory–context handoff boundary | Bellek okuma sonucunun kimlik/tür/statü/kaynak/zaman/kapsam/doğrulama bilgisiyle context builder'a sunulması. | §23; D2-T/MD alanlarına bak. Kaynak daha güvenli olabilir diyor; güvenlik garantisi vermiyor. Buradaki handoff bilgi/metadata geçişidir, otomatik olarak aktör veya iş sorumluluğu devri değildir. |
| D2-U37 — Memory policy / operational execution surface | Bellek politikasının hangi olayda ve hangi yürütme yolunda işletileceği; harness'in bu işletim yüzeyi olabilmesi. | §24. Politika tanımı ile gerçek uygulanması ayrıdır; D3'ün bütün harness açıklaması bu bölümden kurulmaz. |

**Context builder seçenekleri, D2 §23:** D2-CB01 include; CB02 exclude; CB03 retrieve source; CB04 compare with canonical state; CB05 compress; CB06 ask clarification. Bunlar bağlama alma, dışlama, kaynağa dönme, güncel durumla karşılaştırma, sıkıştırma ve netleştirme seçenekleridir; sabit zorunlu yürütme sırası değil.

**Yaşam döngüsünün işletim soruları, D2 §24:** D2-EX01 event/write trigger; EX02 write before/after verifier; EX03 tool-result auto-persist; EX04 session-end handoff; EX05 each-turn/on-demand recall; EX06 access-control uygulama yeri; EX07 failure rollback. Önerilen sorulardır; tüm mekanizmaların mevcut olduğu veya çalıştığı gösterilmiyor. EX04'ün oturum sonu devam aktarımı ile U36'nın bellekten bağlama bilgi aktarımı aynı handoff anlamı diye birleştirilmez.

### D2 §22'nin aday proje sınıfları

Aşağıdaki tablo D2'nin araştırma çerçevesini aktarır. Sütunlardaki high/qualified/medium gibi etiketler yazarın koşullu otorite değerlendirmeleridir; bizim verdiğimiz kabul veya güvenlik puanları değildir. D2 bunu implementation schema saymaz.

| Adres / kaynak sınıfı | Aday kalıcılık | Kaynağın otorite nitelemesi | Kaynakta ana risk |
|---|---|---|---|
| D2-P01 — Current Work/authorization | Canonical repository state | high | stale read |
| D2-P02 — Accepted decision | Karar/durum artefaktı ve kaynak referansları | high/qualified | decision context loss |
| D2-P03 — Research finding | Sürümlü, kanıt destekli dosya | qualified | synthesis overreach |
| D2-P04 — Session scratch | Geçici/kısa ömürlü | low | accidental promotion |
| D2-P05 — Agent reflection | Faydalıysa türetilmiş kalıcı not | low until verified | self-reinforcement |
| D2-P06 — Tool/environment gotcha | Aday öğrenilmiş prosedür | medium after validation | obsolete workaround |
| D2-P07 — User/project stable preference | İlgili kişi/proje kapsamıyla sınırlandırılmış bellek | context-dependent | privacy/staleness |
| D2-P08 — Historical state | Arşiv | historical only | current contamination |

D2-P07'nin özgün ifadesi scoped memory'dir; kapsamın genişliğini değil, ilgili kişi/proje ile sınırlandırılmasını anlatır. P02'de accepted bir kararın kaynak tarafından kabul edilmiş olarak nitelenmesi, bu concepts kaydının karar verdiği anlamına gelmez.

## 9. Adlandırılmış fakat genel tanımı kurulmamış kullanımlar

D2 §1/§28'de Vector database/Vector DB, chat history, model weights ve repository memory soruları geçer. Vector DB seçilmiş default değildir. Her soru başlığından yeni genel tanım üretilmez. D2'nin LLM, agent, inference, token, ACI, model capability, verifier, tenant ve schema adlarını kullanması bunların tamamının bağımsız genel sınırını kurduğu anlamına gelmez; açıklanmış yerel rolleri yukarıda, geri kalan kapsamları açık tutulur.

**D2-N01 — Karar/tanı dili (§25):** memory engineering lens'i; context/retrieval, harness/ACI, model/adaptation, source correctness ve verification alternatif problem alanları. Bunlar kaynağın ayrım önerisi; bu tur gerçek bir sistem arızası teşhis edilmedi.

**D2-N02 — Açık tasarım soruları (§27):** .a memory promotion gate ve human/verifier/source-backed seçenekleri; .b episodic→semantic consolidation; .c reflection verification status; .d temporal version model; .e downstream derived-copy deletion; .f Work/Actor access scope; .g recall ranking/signals; .h fail-visible retrieval miss; .i canonical-state conflict gate; .j latency/token budget ile task value; .k local benchmark scenarios; .l model upgrade sonrası öğrenilmiş prosedürün eskimesi; .m poisoning/self-reinforcement testleri; .n fine-tuning/external-memory capability boundary. D2 §27'nin 16 sorusu bu adresler ve U13–U37 ile karşılanır; uygulanmış gate/test veya bu tur açılmış yeni araştırma işi değildir. Örneğin ilk iki soru bellek sınıfı ihtiyacı ve canonical/derived ayrımıdır; U13–U18 ve P01–P08'e bağlıdır.

**D2-N03 — Kaynak adları ve kullanım rolleri (§29):**

| D2'nin atıf kimliği | Kaynak adı | D2'nin atfettiği rol / sınır |
|---|---|---|
| S1 | Memory for Autonomous LLM Agents: Mechanisms, Evaluation, and Emerging Frontiers | Write–manage–read, filtreleme/çelişki/latency/privacy/forgetting; kaynak survey/preprint diye nitelenir. |
| S2 | Generative Agents: Interactive Simulacra of Human Behavior | Memory stream, reflection, dynamic retrieval/planning. |
| S3 | LongMemEval: Benchmarking Chat Assistants on Long-Term Interactive Memory | Extraction, çok oturumlu/zamansal akıl yürütme, güncelleme ve abstention; indexing/retrieval/reading. |
| S4 | MemGPT: Towards LLMs as Operating Systems | Virtual context ve hiyerarşik veri hareketi. |
| S5 | From Storage to Experience: A Survey on the Evolution of LLM Agent Memory Mechanisms | Storage→reflection→experience abstraction çerçevesi. |
| S6 | Reflexion: Language Agents with Verbal Reinforcement Learning | Ağırlık güncellemesi olmadan sonraki denemeleri etkileyen episodic reflective text. |
| S7 | LongMemEval-V2: Evaluating Long-Term Agent Memory Toward Experienced Colleagues | Static state, dynamic state, workflow knowledge, gotchas, premise awareness adları. Bu dosyada her birinin biçimsel genel tanımı yok; sayı/leaderboard iddiası taşınmıyor. |
| S8 | OpenAI Agents SDK — Sessions | Önceki öğeleri getirme/ekleme ve yeni öğeleri saklama örneği; bütün bellek kuramı değil. |
| S9 | Building a Memory-First Agent Harness | Practitioner terminoloji örneği; standardizasyon kanıtı değil. |
| S10 | Mevcut ai-knowledge-strategies paketinin RAG/KG/Fine-Tuning/CAG/Long Context dosyaları | Önceki proje araştırmasına atıf; bağımsız dış doğrulama veya o paketin bu tur tam okuması değil. |

Bu atıfların bibliyografik ayrıntıları ve dış adresleri sabit D2 §29'dadır. D2'nin S1 numarası global SCOPE/S1 ile aynı kimlik türü değildir. F-MEM-01–11 (§26) önceki araştırmanın bulgu kimlikleridir; bu dosyanın kullanım adresleri veya yeni bulguları değildir. Kaynaktaki high confidence etiketleri yeni doğrulama sonucu sayılmaz. §28'in uygulama/benchmark/taxonomy sınırları ve §30'un tarihsel handoff'u korunur.

## 10. Kaynak-içi ilişki görünümü ve açık kapsamlar

**Olay → aday → temsil/statüyle yazma → düzenleme/güncelleme/tutma → geri çağırma → context builder seçimi → modelde kullanım.** D2 §4, §7, §23–24. Bu, kaynağın yaşam döngüsü açıklamasıdır; aşamaların her sistemde tek sıra/tek modül olduğu veya hiçbir geri besleme bulunmadığı sonucu çıkarılmaz. Reflection'ın tekrar yazılması ayrıca U28/U32'deki geri besleme yoludur.

**Aynı memory sözcüğü farklı nesneleri anlatır.** U01 yaşam döngüsü/sistem nesnesi, U03 tasarım disiplini, U04 tekil kayıt, U13–U17 sınıflar, U26 parametrik kullanım, U33 oturum kalıcılığı örneğidir. Bunlar burada tek kapsayıcı kabul edilmiş tanıma indirgenmez.

**İç/dış bellek kapsamı açık tutulur.** D2 §3'ün geniş tanımı internal ve external zeminleri içerirken §13 operasyonel bellek yaşam döngüsünü parametrik uyarlamayla aynılaştırmaz. Yeni çıkarım açıklaması: yazarın geniş tanımı ile pratik mühendislik karşılaştırması farklı kapsamda okunmalıdır; bu iki pasajdan bütün internal memory biçimlerinin external memory olduğu veya parametric memory'nin her anlamda kapsam dışı olduğu sonucu verilmez. Genel sınır çözülmedi.

**Kalıcılık ile otorite tek eksen değildir.** D2 §5.5/§22 canonical state'i bellek/state sınıfları arasında sayar; §6/§21 onu türetilmiş/öğrenilmiş bellekle aynı otorite sınıfına koymaz. Yeni çıkarım açıklaması: bir kaydın zaman içinde sürmesi ile hangi durumda yetkili referans olduğu farklı sorular olarak okunabilir. Bu, kaynağın tamamen biçimselleştirdiği bir ontoloji değil; görünür kapsam gerilimini koruyan açıklamadır. Bütün canonical state bellektir veya hiçbir canonical state bellek değildir kararı burada verilmez.

**Bellekten bağlama handoff, tek başına iş/aktör devri değildir.** D2 §23'teki bilgi/statü aktarımı ile §24'te sorulan session-end handoff ayrı bağlamlarda adreslendi. Ana TERMS'teki C07/C14/C27 bu bellek okuma/seçim/statü geçişine ilişkilidir; H17'nin eski metni kurtarılmış gibi gösterilmez. D3'ün diğer handoff kullanımları daha sonra kendi kaynağıyla okunacak.

**Doğru çağırma, doğru karar veya silme garantisi değildir.** D2 §7/§18/§16. Yanlış yazılmış kaydı başarıyla bulmak yazma hatasını çözmez; doğru kaydı bulmak downstream karar etkisini tek başına ölçmez; use path'ten çıkarma bütün türetilmiş kopyaların silinmesini kanıtlamaz. İlk ikisi kaynağın doğrudan ayrımları, sonuncusu kaynakta ayrı sorulan kullanım/silme kapsamlarını birleştirmeyen yeni açıklamadır.

D2 §20–22'nin SOUL/Development OS ifadeleri aday proje rolleri ve tarihli repo yorumlarıdır; bugün kurulmuş ürün, kabul edilmiş mimari veya yeni çalışma yetkisi değildir. D2 §30'un next Harness ifadesi tarihsel kaynak handoff'udur; bizim sonraki işimiz yalnız güncel concepts STATE/READING'den alınır.

## 11. Değişiklik ve tamamlanma sınırı

B6-T1 context kayıtları yeniden numaralanmadı veya ortak tanıma çevrilmedi. Bu dosya D2'den yeni kalıcı kaynak kontrollü çıkarımdır. Kaynak noktaları, atıf/araştırma/yeni yorum ayrımı; tekil kayıt, zaman alanları, doğrulama dili, koşullu proje sınıfları ve iki handoff kullanımı açıklaştırıldı. Önceki pilotta not edilmiş tekil memory, canonical-state gerilimi ve bilgi/metadata devri burada kaynaktan yeniden ele alındı; özgün pilot satırlarını aynen aktardığımız söylenmiyor.

**Yayın geri okumasındaki sınırlı düzeltme:** U13'ün trajectory karşılığı eylem/gözlem dizisi olarak açıklaştırıldı; P07'de scoped memory için kapsam genişliğini çağrıştırabilecek ifade yerine kişi/proje ile sınırlandırılma yazıldı; U26'daki yerel §10 atfı D2 §10 ile karışmayacak biçimde belirtildi. Eski kaynak anlamı veya kayıt kimlikleri değiştirilmedi; bu bir bağımsız doğrulama değil, aktarım açıklığı kontrolüdür.

**Tamamlanan:** D2'nin bu sürümündeki §1–30 kullanım/ilişki dökümü ve kaynak tarafından kapsam kontrolü. **Tamamlanmayan:** bütün CMH paketinin kalıcı aktarımı, D3/D4 ve paket-geneli son kontrol; eski pilot kimliklerine birebir eşleştirme; bütün studies çıkarımı veya ortak tanımlar. Kaynağın tanımlamadığı genel anlamı açık bırakmak okuma eksikliği değildir.

Kontrol aynı assistant'ın kaynak karşılaştırmasıdır; bağımsız inceleme, ürün çalıştırma veya doğal-dil anlamları için hatasızlık sertifikası değildir. Somut bir atlama bulunursa ilgili kayıt yeniden açılır. Kaynak araştırmanın kendi completion/adoption durumu değişmedi.
