> **30 Eylül 2026 — tarihsel DEVOS-001 / F08 ilk kaynak çıkarımı.** Aşağıdaki ilk tamlık beyanı ve S07 okuma satırı tek başına geçerli değildir: eksik son aralık ve katkılar [F08-RECONCILIATION](F08-RECONCILIATION.md)'da düzeltilmiştir. Eski P1 ve sonraki okuma yönü bugünkü görev değildir; daha sonraki yöntem değişikliği [COVERAGE](COVERAGE.md)'dadır. Araştırma katkıları korunur, eski hazırlık yeniden açılmaz.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); Claude Code ve DevOS bu depoyu yalnız okur. [Öneksiz ilk kayıt](https://github.com/batuhanozgun/agentic-os-search/blob/bc015e2f97beb9c281bd54a071916324459bc502/development-os/attempts/001/reading/F08-FOUNDATION-FRAME.md) aşağıda aynen korunur; eski blob/satır kimlikleri bu notu kapsamaz.

---

# F08 — çalışma sisteminin bütünü için Foundation çerçevesi

**Kayıt türü:** özgün Research dosyalarından kaynak-bağlı fikir/örnek çıkarımı; yapı seçimi değil.
**Okuyucu/yazar:** Research / ChatGPT, 23 Eylül 2026.
**Kaynak ref:** `batuhanozgun/agentic-os-search@dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb`.
**Kapsam:** Foundation kök STATE/INDEX + 08 paketinin 13 dosyasının tamamı bu tur doğrudan okundu. 08 altındaki bütün doğrudan ağaç üyeleri aşağıda hesaba katıldı. Alt araştırma dalları, defterlerin işaret ettiği birincil literatür ve bütün Foundation bu okumayla tamamlanmış sayılmaz.
**Durum:** bu kümenin kaynak okuması ve ilk çıkarımı tamam; karşı aktör okuması / içerik eksikliği kontrolü BEKLİYOR. Genel P1 AÇIK.
**Ana rota:** [COVERAGE](COVERAGE.md) → özgün kaynaklar. Bu kayıt ilk genişlik çerçevesidir; sonraki ayrıntılı kayıtların yerine geçmez.

## 1. Kaynak ve okuma defteri

Aşağıda F = `research/soul-foundations/`; P = `F/08_foundation-sufficiency-reuse-review/`. Bütün yollar yukarıdaki sabit ref'tedir. [Özgün paket](https://github.com/batuhanozgun/agentic-os-search/tree/dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb/research/soul-foundations/08_foundation-sufficiency-reuse-review).

| ID | Yol | Git blob | Okuma / kaynak rolü |
|---|---|---|---|
| S01 | F/STATE.md | 6d1c3db664bb154546cb6c0bf5edc6da5275dcf8 | Tam; current research purpose/authority |
| S02 | F/INDEX.md | f72d7f30159f1b3dcfbd5f37caf67933cf0b92fd | Tam; kaynak yönlendirmesi |
| S03 | P/STATE.md | e83a30b124c337714f8539ccf0f6d8ecc2454f7b | Tam; paket durumu |
| S04 | P/INDEX.md | 14dba4ddf33641e844ca2a838254772d3572535c | Tam; paket yönlendirmesi |
| S05 | P/PLAN.md | 1187a25836db547c24dd08f90f82912d6da6cdba | Tam; tarihsel soru, ölçüt ve kapsam |
| S06 | P/SYNTHESIS.md | 4e162b0476d17322fb8cefb69d411e4fa1f444b0 | Tam; 1–100 isteğiyle dosyanın sonuna kadar geldi |
| S07 | P/CASE-AUDIT.md | 95e3b1403117ea32cbcde4fdfb9f19263ef47ffd | Tam; 1–90 isteğiyle C1–C6'nın tamamı, dosya sonu |
| S08 | P/RIVALS-AND-REUSE.md | ecead748106c832ca80d99df2a07876e6d66f9f7 | Tam; alternatif çerçeveler ve kapsam |
| S09 | P/COMPLETION-AND-RESIDUALS.md | 13f27678a44622f526b987cb6adfbaaca07e0cd3 | Tam; araştırma derinliği ve kalan işler |
| S10 | P/REUSE.md | b92c29d85055c70536392c0804a7a621efc9caff | Tam; soru→araştırma→hedef uygulama rotası |
| S11 | P/SOURCE-LEDGER.md | 633d4a228e26ced9fe110c53f672c69fedb80e35 | Tam; eski okuma ve dış kaynak kapsamı, o kaynakları bu tur okuma değil |
| S12 | P/PUBLICATION.md | c3f2fb9da4d35df10ef7522520d87d6cbfe5bff2 | Tam; tarihsel yayın kanıtı |
| S13 | P/CURRENT-SURFACES.md | 7f305811e27d0dd3202f2305ef807eb924109d45 | Tam; içerik kimliklerinin kapsamı |
| S14 | P/DISCUSSION-HANDOFF.md | e95cf01635d328ae4d5db414ba5a9c4d70a42fb7 | Tam; sonraki owner tartışması ve üretim tarafı düzeltmesi |
| S15 | P/COLD-START-CHECK-2026-09-17.md | b271b077e8a1b887081425981e38f08c9b2f25b8 | Tam; tarihsel manuel devam kontrolü, bağımsız deney değil |

P ağaç kimliği: `dbdafeb7b08274073f103f61a90c2a0c9c318c3b`; 13/13 doğrudan dosya okundu. S01–S02 paket dışı iki ebeveyn girişidir. Bu oran yalnız bu paketin dosya okumasıdır; bütün repo veya anlam kapsamının yüzdesi değildir.

## 2. Kaynağın kendi bütünsel modeli

08, çalışan bir ürün veya kod mimarisi sunmuyor. Dört zemin ile bileşim araştırmasının, çalışma sistemi ihtiyaçlarını düşünmek için yeterince gelişmiş ve geri çağrılabilir bir bilgi temeli olup olmadığını ele alıyor. Kaynakta Foundation ne boş bir kontrol listesi ne de tüm mühendislik cevaplarını veren reçete. Gerçek hedef, uzmanlık, örnek sistemler ve hedefteki kanıtla birlikte kullanılıyor (S06 §§1–2; S10).

Bütünsel anlatım: gerçek ortam ve koşullar altında, farklı amaç ve yetkileri olan aktörler bir işi keşfeder, kabul eder, planlar, yürütür, değerlendirir ve gerekirse değiştirir. Bunu bilgi temsilleriyle yaparlar. Temsilin anlamı, hangi nesne/sürümü anlattığı, kimi hangi kullanımda desteklediği ve gerçekte oluşan etkiyle bağı korunmalıdır. İş, bilgi, aktör ve ortam birbirinden bağımsız dört kutu değil; binding, standing, control ve transition sorularıyla birlikte incelenen yönlerdir (S06 §§2–5).

08'in altı örneği karşılaştırmalı düşünce vakasıdır. Gösterdikleri çalışma biçimleri/yanlış çıkarımlar yararlı girdidir; kurulmuş SOUL veya Claude davranışı diye okunmaz. Sonraki soru-bankası tartışması ayrıca üretim sistemini görünür kılar; ilk altı vakaya geriye dönük eklenmiş bağımsız deney değildir (S07; S14).

## 3. Katkı kayıtları — henüz benimsenmiş tasarım değil

### F08-01 — Ürünü değil, ürünü üretecek işi de modellemek

**Kaynak:** S01 “Important correction”; S14 §§2–3.

Soru bankası örneğinde ilk inceleme çıktı, öğrenci, kullanım ve etkilere yoğunlaşıp üretimi yeterince açmadı. Kullanıcının itirazından sonra araştırma/yazım, planlama ve parçalama, atama, yetkinlik/yetki, öncelik, bağımlılık ve eşzamanlılık, bilgi akışı, araç/kapasite/erişim, inceleme, teslim, devir ve üretim sisteminin kendisini değiştirme ele alındı.

**Somut örnek:** bütün atanmış işler başarılı olabilir ama hiç atanmadığı için gerekli bir iş eksik kalabilir. Yetkin bir yazar gerekli bilgiye/erişime sahip olmayabilir. Yeni sürüm onaylanmış olsa bile eski sürüm yayımlanabilir. Bunlar yalnız çıktı incelemesiyle kapanmaz.

**Olası katkı:** çalışma yapısı için yalnız “ne üreteceğiz?” değil “işi kim keşfedecek, kim yapacak, nasıl koordine edilecek, hangi bilgi ve ortamla, nasıl devredilecek?” sorularını birlikte taşıyan bir üretim modeli girdisi. Bu, taslak M1–M3'ten daha geniştir. **Sınır:** belirtilen üretim olayları analitik örneklerdir; hazır mekanizma veya kanıtlanmış verim artışı değildir.

### F08-02 — Work: sabit görev listesi yerine amaç ve ilerleyen keşif

**Kaynak:** S06 §2/§3; S07 C2/C6; S10 Work rotası.

Work; amaç/pursuit, işe alma, yöntem, bağımlılık, yürütme/koordinasyon, değerlendirme, kurtarma ve süren/açık uçlu işi birlikte kapsıyor. Bir evrede anlamlı çıktı, sorunun daha iyi kurulması veya değerlendirilen taslak olabilir. Yerel iş bitişi bütün amacın gerçekleşmesi değildir.

**Olası katkı:** Development OS'u kurma işinin araştırma→karar→kurulum gibi farklı ürünleri ve geri dönüşleri olmalı; başlangıçta her alt işin bilindiği varsayılmamalı. İşin durumuyla temsil edilen plan ayrılmalı. **Sınır:** bunun hangi graph, tracker veya workflow ile yapılacağını 08 seçmiyor; Work'ün alt kaynakları ve studies'teki uygulamalar sonraki kayıtlardır.

### F08-03 — Actors: kişi/ajan sayısından önce sorumluluk ve yetkinlik

**Kaynak:** S06 §2/§4; S07 C2/C3; S08 §4.

Aktörler yalnız AI ajanları değildir. İş yapanlar, karar verenler, etkilenen fakat işi yapmayanlar, sürekli sorumluluk taşıyanlar ve vekalet/katılım ilişkileri ayrılır. Yapabilmek, atanmış olmak, yetkili olmak ve sonuçtan sorumlu olmak birbirinin yerine geçmez.

**Olası katkı:** araştırmacı, planlayıcı, uygulayıcı, uzman, değerlendirici, kullanıcı gibi rol ihtiyacı çıkarılabilir; her rolün ayrı model/ajan olması peşinen belirlenmez. Bir aktörün eksik bilgisi veya kapasitesi rol dağılımının gerçek koşuludur. **Sınır:** 08 belirli bir organizasyon şeması veya ideal ajan sayısı vermiyor.

### F08-04 — Environment: yalnız araç listesi değil, gerçekleşebilir koşullar

**Kaynak:** S06 §2; S07 C3/C5; S10 Environment rotası.

Environment, gerçek domain ile çalışmayı mümkün kılan koşulları kapsar. Teknik çalışma ortamı özel bir profildir. Kaynak varlığı kadar konum, durum, erişim, uyumluluk, kapasite, zaman aralığı ve çakışan kullanım önemlidir.

**Olumlu örnek:** jeneratör doğru yerde, bağlı, uyumlu, yakıtlı ve gereken anda boşsa hizmete olanak sağlar. Aynı envanter satırı bu koşullar yokken aynı sonucu desteklemez. **Olası katkı:** Claude/Research kabiliyetleri, oturumlar, araçlar, kaynak erişimi ve yayın imkanları adlarıyla değil gerçek kullanım koşullarıyla ele alınmalı. **Sınır:** bu örnekten özel bir bulut/yerel ortam veya ürün seçilmiyor.

### F08-05 — Information: kayıt, dönüşüm ve kullanıma sunma birlikte

**Kaynak:** S06 §2; S10 soru tablosu; S11 exact routes.

Bilginin durumu/temsil kipi ile oluşumu, yeniden ifadesi, çıkarıma dayanak olması, revizyonu ve seçilip belirli tüketiciye açılması ayrılır. Records kalıcılık profilidir; bilgi alanı yalnız dosya/bellek depolamaya indirgenmez. Bir ifade gerçek, hipotez, soru, kurgu veya geçmiş beyan olarak farklı kullanılabilir.

**Olası katkı:** okumadan doğan bilgi, karar dayanağı, iş durumu, gözlenen ortam ve kullanıcı sözü aynı statüde saklanmamalı. Dönüşüm hangi anlamı koruduğunu, erişim hangi kullanımda yeterli olduğunu taşımalı. **Sınır:** dizin, veritabanı veya RAG seçimi çıkmıyor; Formation/Derivation/Selection alt araştırmalarına inilmesi gerekiyor.

### F08-06 — Dört zemini bağlayan işleyiş

**Kaynak:** S06 §§2–5; S07 C1–C5; S10 Composition satırı.

Binding hangi aktör/iş/bilgi/ortam nesnesinin hangi sürüm ve kapsamla ilişkili olduğunu; standing ilgili koşullara göre ne durumda olduğunu; control hangi etkiyi hangi yetki/kural altında yönettiğini; transition gerçek değişme/yayılma ve bunun gözlenmesini soruyor. Nedensel katkı ile geri bildirim/kalıcı uyarlama ayrıca ayrılıyor.

**Olası katkı:** sonraki yapı seçenekleri tek tek parçalar listesi değil, bir talebin alınmasından işte etki oluşturmasına, değerlendirilmesine ve devamına kadar yürüyüşle açıklanmalı. **Sınır:** bunların her biri zorunlu servis, dosya veya agent değil. 08'i okumuş olmak alt bileşim araştırmasını okumuş olmak değildir.

### F08-07 — Tek tek hazır parçalar birleşince hazır sistem olmayabilir

**Kaynak:** S07 C3.

A bir işi B'den isteyebilir; B kaynak değiştirebilir; fakat izin başka işe ait olabilir. Gerekli kaynaklar ayrı zamanlarda erişilebilir veya aynı tükenmiş kapasiteyi kullanıyor olabilir. Bilgi iki kişide bulunup hiçbir izinli yöntem onu gerekli karar noktasında birleştiremeyebilir.

**Olası katkı:** iş hazırlığı, aktöre/göreve/yönteme ve birleşik koşullara bağlı değerlendirilmeli. Eksik bilgiye daha fazla izin; eksik kapasiteye daha fazla talimat yazmak yanlış müdahaledir. **Sınır:** RPD katkısı burada kaynak defterindeki analitik aktarım düzeyinde; RPD'nin özgün metin ve araştırması ayrıca okunacak.

### F08-08 — Yeterli bilgi ile tüketiciye açık bilgi aynı tanığa bağlanmalı

**Kaynak:** S07 C1/C3; S10 Selection satırı.

Kaynakta yeterli bilgi olmasıyla karar veren aktörün yeterli bilgiye erişebilmesi farklıdır. Farklı yerlerde bulunan iki olanağın aynı kullanımda birlikte gerçekleşmesi ayrıca gerekir. Uygun on-demand erişim, baştan her şeyi context'e doldurmadan ihtiyacı karşılayabilir.

**Olası katkı:** her rolün göreve hazırlanması ve gerekli bilgiyi keşfetmesi için erişim/kullanım ilişkisi kaydedilebilir; envanter büyüklüğü başarı olmaz. **Sınır:** gereken bilginin kendiliğinden bulunması veya iyi bir retrieval ürününün seçimi bu üst sonuçta çözülmüş değil.

### F08-09 — Kanıtın çoğalması ile belge çoğalması ayrı

**Kaynak:** S07 C1; S06 §3.

Tek bileşen testinden türemiş on iki doğru rapor, on iki bağımsız gözlem değildir. Aynı rapor, “bu bileşen bu testten geçti mi?” sorusunda yeterli olup “bütün sistem kullanıma hazır mı?” sorusunda yetersiz kalabilir. Yayın alındısı okuma/anlama/kabul değildir.

**Olası katkı:** araştırma kayıtları, çıkarımlar ve değerlendirmeler dayandığı gözlemin kapsamını korumalı. Yeni rapor yerine gerçekten gereken kaynak veya sistem kanıtı seçilmeli. **Sınır:** her işi sonsuz test etmeye veya mevcut E19'u ana hedefe dönüştürmeye gerekçe değildir.

### F08-10 — Amaç/ölçüt seçimi teknik optimizasyondan önce gelir

**Kaynak:** S07 C2; S06 §4; S08 §4–5.

Aynı verim optimumu, farklı kabul edilmiş erişim veya hizmet koşulları altında uygun veya uygunsuz olabilir. Etkilenen fakat üretime katılmayan taraflar vardır. Daha çok olgu, kimin değerlerinin öncelikli olması gerektiğini tek başına çözmez.

**Olası katkı:** görev hedefi, başarı ölçütü, gerçek kullanıcı tercihi ve assistant'ın teknik yöntemi ayrılmalı; sistem tek evrensel skora veya tek aktörün varsayılan yetkisine indirgenmemeli. **Sınır:** burada evrensel etik teori veya yönetim modeli kurulmadı.

### F08-11 — Devam için sadece son durum değil, gerekçe ve gelecekteki revizyon ihtiyacı

**Kaynak:** S07 C4; S10 Revision rotası; S14 §1.

Geçmiş onay, tarihsel açıklama için doğru kalırken bugünkü farklı işi yetkilendirmeyebilir. Kısa bir görünüm bugünkü yanıtı koruyup gelecekte yeni girdiye göre karar değiştirmek için gereken dayanağı kaybedebilir. Kaynak güncellemesi tüketicide tutulan kopyayı otomatik güncellemez.

**Olası katkı:** kalıcı kayıt, hangi işte neden alınmış karar olduğunu ve yeniden neye dönüleceğini taşımalı. Tarihsel bilgi silinmeden güncel işteki rolü ayrılmalı. **Sınır:** bu, belirli SHA checker veya otomatik STATE üreticisinin zorunlu olduğu anlamına gelmez.

### F08-12 — Geri bildirim, gerçekten kullanılmış deneyim ve kalıcı değişim

**Kaynak:** S07 C4; S06 §2–3; S10 son soru.

Ders dosyası yazılması, deneyimin sonraki kararda etkili olmasını; etkili olması da kalıcı davranış değişimi ve faydayı kendiliğinden göstermez. Aynı çıktı üretmek de hiç öğrenme olmadığı anlamına gelmez.

**Olası katkı:** gelecekteki çalışma düzeninde gözlem→değerlendirme→sonraki karara geri dönüş→gerekli kalıcı güncelleme bağı aranmalı. Bunu sadece 'learnings' klasörü diye adlandırmak yetmez. **Sınır:** kalıcı öğrenmenin taşıyıcısı ve etkisi alt araştırma ve hedef kanıtıyla belirlenecek.

### F08-13 — Açık uçlu işte meşru ara sonuç ve ana amaca dönüş

**Kaynak:** S07 C6; S06 §3/§5.

Yazar veya araştırma ekibi, başlangıçta tamamlanmış spesifikasyon olmadan çalışabilir. İnceleme evresi daha iyi soru veya değerlendirilen taslakla meşru biçimde biter. Aynı çıktı tamamlanmış ürün sözleşmesini karşılamaz. Amaç geliştirme ile zor görevi daha kolay bir hedefe sessizce çevirme ayrı.

**Olası katkı:** bugünkü kapsamlı okuma meşru hazırlık işidir; somut kayıt ürettiğinde ilerler. Kayıtların tamamı oluşunca toplu değerlendirmeye, oradan yapı kararına döner; okumak yeni nihai hedef olmaz. **Sınır:** evrensel keşif-tamamlandı testi veya başlangıçta tüm işi bilme koşulu yok.

### F08-14 — Süreç/amaçtan giriş ve araştırma ağacından giriş birlikte kullanılabilir

**Kaynak:** S08 §2; S06 §5.

Amaç, katılımcılar, kısıtlar ve yöntemlerden başlayan giriş pratikte araştırma ağacını sırayla doldurmaktan daha uygun olabilir. Keşif ve yeniden çerçeveleme, sabit plan→execute→done sırasına sığmayabilir. Dört zemin bu girişin altında önemli ayrımları sağlar.

**Olası katkı:** sonra kurulacak düzen kullanıcıya dört araştırma formu doldurtmak zorunda değil; hedefe yönelik normal iş girişi ile gerekli arka bilgi/rol/ortam yapısı ayrılabilir. **Sınır:** 08 hangi girişin pratikte üstün olduğuna dair karşılaştırmalı deney yapmadı; bugün seçim yok.

### F08-15 — Graph ifade gücü, doğru ihtiyacı keşfetme güvencesi değildir

**Kaynak:** S08 §3.

Yeterince zengin entity/event/relation modeli örnekleri temsil edebilir. Fakat hangi rol, kapsam ve kanıt ayrımının keşfedileceğini depolama biçimi belirlemez. Dört zeminli ağaç da sadece başlıkları bulunduğu için bu keşfi garanti etmez.

**Olası katkı:** work graph, tablo, belge veya veritabanı seçeneklerini ihtiyaç ve mekanizma üzerinden kıyaslama girdisi. **Sınır:** graph ya da Markdown baştan doğru/yanlış seçilmez. Gelecek source-native örnekler gerçek işlemler ve trade-off'larla açılacak.

### F08-16 — Merkezi olmayan bilgi ve karar ilişkilerini korumak

**Kaynak:** S08 §4; S06 §4.

İncelenen kurumsal karşı çerçeve aktör, konum, bilgi, kontrol, sonuç ve maddi/topluluk/kural koşullarını birlikte ele alıyor. Bu, dış tasarımcının her şeyi bilen ve bütün kararları verme yetkisi olan tek merkez sayılmasına karşı basınç sağlıyor.

**Olası katkı:** Research ile Claude'un bilgi, üretim ve karar sorumlulukları ayrılabilir; tek plan görünümü bütün yetkileri bir kişiye aktarmamalı. **Sınır:** kaynak, Ostrom metninin revize taslağından seçili bölüm kullanmış; bu tur o dış PDF okunmadı. Merkezi ya da çok-merkezli mimari benimsenmedi.

### F08-17 — Bilgi temeli, örnek sistem, kavramsal deneme ve mühendislik kanıtı ayrı katkılar

**Kaynak:** S06 §1/§8; S09 kalan sorumluluklar; S10.

Foundation ayrım, karşı örnek, gerekçe koşulu ve ihtiyaç sorusu sağlar. Studies mekanizma/kapasite/uygulama örneği, hatta bir şeyi kurmama nedeni sağlayabilir. Explorations taslak model ve düşünce denemeleri taşır. Gerçek hedefin ortamı, kaynakları ve etkileri ayrıca kurulmalıdır.

**Olası katkı:** bütün korpustan çıkarılan kayıtlar bu farklı rolleriyle toplu değerlendirmeye girer. Hiçbiri tek başına reçete değildir; kullanılmayan kaynak atılmaz. **Sınır:** temel araştırmanın kapanışı, bütün hedef gereksinimleri veya mühendislik yeterliğinin tamamlandığı anlamına gelmez.

### F08-18 — Kaynaklı kararın geri okunabilir izi

**Kaynak:** S10 “A minimal use record”; S11; S13.

Maddi kullanımlarda hedef soru, exact araştırma iddiası/yol/sürüm, uygulanabilirlik ve karşı örnek, etkilediği ihtiyaç/seçim ve eksik hedef kanıtı geri kazanılabilir tutulur. Bir iddiaya çok sayıda dosya linki vermek, hangi anlamın hangi kararı taşıdığını açıklamaz.

**Olası katkı:** bu çıkarımın kendisi kaynak görüşü ile olası katkıyı ayırır. Sonraki yapı kararında kayıtlar yalnız bibliyografya değil, alternatifleri değerlendirme dayanağı olabilecek. **Sınır:** bu yöntem kaydı modelin gizli düşünce zinciri veya zorunlu evrensel schema değildir.

### F08-19 — Bilinmeyenlerin türünü ayırıp doğru işe dönmek

**Kaynak:** S09 kalan beş sorumluluk ve reopening; S08 §7.

Yapısal araştırma açığı, hedefe özgü ihtiyaç/kanıt, uzman mühendislik, bağımsız etkinlik değerlendirmesi ve kaynak/koruma bakımı ayrı işlerdir. Her açık yeni Foundation dalı değildir; her yeni ürün veya terim de tüm araştırmayı yeniden açmayı gerektirmez. Somut yanlış iddia/kayıp ayrım varsa etkilenen yere dönülür.

**Olası katkı:** bütün okuma sonunda eksik kalan cevaplar 'hepsi var' diye doldurulmaz; doğru sorumluluğa atanabilir. Tüm korpusu okuma işi, bütün dünyadaki bilginin bitirilmesi işine dönüşmez. **Sınır:** kapanış, bağımsız tamlık veya evrensel geçerlilik kanıtı değildir.

### F08-20 — Tarihsel bağlam ve güncel yön aynı kayıt değildir

**Kaynak:** S12–S15; S08 §6.

08'in yayın, sonra kullanıcıyla değerlendirme ve üretim düzeltmesi ayrı olaylar. Eski 'değerlendirme bekleniyor' başlığı yeni tartışmayı temsil etmeyebilir; eski bulgunun kendisi buna rağmen korunur. Başlangıç yönünü ve tarihsel bilimsel kanıtı ayrı tutmak, önceki çalışmayı tekrar başlatmadan kullanmayı sağlar.

**Olası katkı:** okumada kabul edilmiş, önerilmiş, tarihsel ve hâlâ açık malzeme karıştırılmamalı. **Sınır:** bu katkı tekil dosya onarımını yeni ana iş yapmaz. S15'in manuel geri-okuması bağımsız taze aktör deneyi değildir.

## 4. Birlikte korunacak örnek aileleri

S07'nin C1–C6 örnekleri üstteki kayıtlarda ayrıntılandı; toplu tasarım değerlendirmesinde unutulmaması için şu eşlemeyle geri bulunur:

| Örnek aile | Katkı kayıtları | Pozitif çalışma karşılığı |
|---|---|---|
| C1 kanıttan karara | F08-05/06/09 | Dar soruyu yeterli kanıtla sonuçlandırmak, başka iddia için gerekli kanıtı ayırmak |
| C2 değişen/çoğul amaç | F08-02/03/10/16 | Olgusal incelemeyi sürdürebilirken gerçek tercih kararını doğru yetkide tutmak |
| C3 dağıtık kapasite/yetki | F08-03/04/06/07/08 | Yetkili, kapasitesi ve kullanılabilir bilgisi aynı işte birleşen yol oluşturmak |
| C4 devam/tarih/uyarlama | F08-11/12/20 | Geçmişi koruyup bugünkü işte doğru dayanak ve gelecek revizyon imkanını kullanmak |
| C5 fiziksel/gerçek koşullar | F08-04/06 | Planı bitirmek ile hizmeti fiilen üretmek için gereken koşulları ayrı yönetmek |
| C6 keşif/yaratıcılık | F08-02/13/14 | Bounded keşif çıktısı üretip değişen bilgiyle üst amaca dönmek |

S14'ün soru-bankası üretimi ayrıca F08-01'dedir; altı vaka sayısına karıştırılmaz. Bu örnekler test paketi olarak kurulmadı, yapıya aday bilgi olarak kaydedildi.

## 5. Kayıt kalitesi ve açık kalanlar

Bu kayıtta bütün paket dosyaları hesaba katıldı; tekrar eden yayın/authority ifadeleri yeni bağımsız fikir diye çoğaltılmadı. Kaynaktaki bütün temel olumlu işleyiş, altı örnek ailesi, alternatif çerçeveler, üretim düzeltmesi, reuse ve residual ayrımları ilk çıkarıma alındı. Bu, tüm olası yorumların eksiksizliğine ilişkin garanti değil; ikinci okuyucu maddi atlama bulursa kayıt kaynakla revize edilir.

**Henüz okunmayan zorunlu alt alanlar:** 00_context, önceki dört dikey, Work/Actors/Environment/Information'ın bütün özgün araştırmaları, Formation/Derivation/Selection, bileşim dalları, 04/06/07 ve tarihsel/alignment/repair dosyaları. Bu kayıt onların route ve üst sonucunu bilir; gövdelerini okumuş saymaz. Studies ve explorations özgün mekanizma/topoloji kayıtları ayrıca gelecek.

**Sonraki Research işi:** Foundation kalan kök README/RESEARCH-USE-ALIGNMENT'ı ve 00_context dosya ağacını aç; 00_context'i tam okuyup ilk amaç/üretim gerekçesi kaydını çıkar; ardından 01_verticals'a geç. Başlangıçtaki 08 kümesi kendi kapsamıyla bitti; aynı kümede yeni test/karşılaştırma kampanyası açma. Karşı okuma bu paketin kuyruğundadır, sonraki kaynak okumasını gereksiz bekletmez.
