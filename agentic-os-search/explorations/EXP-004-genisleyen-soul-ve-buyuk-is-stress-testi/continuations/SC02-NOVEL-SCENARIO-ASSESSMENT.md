# EXP-004 / SC02 — İkinci senaryo adayı: roman

**Tarih:** 2026-09-21. **Tür:** T11 sonrası senaryo seçimi değerlendirmesi; türetilmiş çalışma kaydıdır, assistant yanıtının tam transkripti değildir. **Durum:** Roman assistant tarafından önerilen öncelikli aday; ayrıntılı ikinci vaka/T12 henüz yürütülmedi. Gerçek roman, canlı ajan deneyi, araç seçimi veya SOUL mimarisi üretilmedi.

## 1. Güncel kullanıcı yönü — kaynak alıntısı

Aşağıdaki metin bu turdaki görünür kullanıcı mesajıdır; eski U001–U016 kaynak arşivine yeni sıra numarası verilmiş değildir:

> Hem fikirim alternatif ber senaryo düşünmemizi istiyorsun. Bir yazılım senaryosu olmamasına dikkat ediyorum akternatif üretirken çünkü bence konuştuğumuz şeyler kutunun dışından bakınca daha net ortaya çıkıyor. O yüzden daha çok akıl yürütme, reasoning gerektiren ve işin başından sonuna kadar bütünsel takip edilmesini gerektiren işler bulmaya çalışıyorum, benim aklıma roman yazmak geliyor, soul’dan bir roman yazması istendiğini düşündüm, konu var, karakter var, romanın yönü var, baştan sona roman bir bağlam aslında ama roman bir oturuma alınamayacak kadar büyük bir metin o yüzden işi yönetme konusunda da bence iyi bir test olabilir. Ayrıca roman yazmak için hazırlık da çok önemli. Sen de düşün ben böyle bir resim çizdim diye kabul etme hemen.

Yetki: yazılım dışı alternatifleri ve roman adayının test değerini bağımsız değerlendirmek. Bu öneri bütün roman parametrelerinin veya bir çalışma yönteminin kabul edildiği anlamına gelmez. Sırf konu aynı diye romanı yazmaya, yayıncılık girişimi kurmaya veya yeni geniş araştırma kampanyasına geçilmez.

## 2. Önceki noktadan devir

T1–T11, soru-bankası programı üzerinde iş keşfi, aktör/bağlam, gerçek etki, kabul, süreklilik, değişim, ortak koşullar ve yeterli dayanakla ilerleme sorunlarını açmıştı. T11 sonrasında aynı modelin başka alana taşınması önerildi; bu not o seçimin değerlendirmesidir.

EXP-001'de roman zaten açıklayıcı örnek olarak vardı. Özellikle S016, bütün planı korurken mevcut dalı ayrıntılandırma ve başka dala gelecekte değerlendirilecek not bırakmayı tartışıyordu. Bu yeni değerlendirme romanı ilk kez keşfedilmiş saymaz. Yeni amaç, o örneği bu kez anlatısal bütünlük, yaratıcı karar ve değerlendirme sınırları bakımından karşı-test adayı yapmaktır. Önceki roman/yayıncılık konuşmasındaki olası ticari genişlemeler bugünkü kullanıcı yetkisi değildir.

## 3. İki çerçeve sınırı

Yazılım dışı iş seçmek, o işin her yazılım işinden daha çok akıl yürütme gerektirdiğini kanıtlamaz. Buradaki yararı, kod/dosya/test-suite/deploy alışkanlıklarından uzaklaşıp modelin başka başarı koşullarına uyumunu sınamaktır.

Romanın hiçbir modele tek çağrıda sığamayacağı varsayılmaz. Metin uzunluğu, ek araştırma/taslak geçmişi ve seçilen çalışma bağlamı henüz sabit değil. Deney koşulu olarak her oturumda tüm roman ve tüm geçmiş hazır tutulmayabilir; ilgili asıl bölümlere geri erişim açık kalmalıdır. Uzun bağlama sığma, ilgili bilgiyi doğru kullanma, oturumlar arası devam ve eserin bütününü değerlendirme ayrı sorulardır. Eski modellerdeki long-context bulguları güncel tüm modellere doğrudan taşınmaz.

## 4. Roman neden güçlü aday?

### Yerel parçalar ile bütün eser

Birbirinden ayrı 30 iyi bölümün toplamının hedeflenen romanı oluşturduğu varsayımı sınanabilir. Olaylar çelişmeyebilir ama karakter dönüşümü hazırlıksız, gerilim yanlış yerde, üslup dağınık veya finalin duygusal karşılığı zayıf olabilir. Bunlar gerçekleşmiş bulgular değil, gelecekteki karşı durumlar. Soru-bankasında da bütünsel kalite vardı; burada parça-bağımsızlığına daha kuvvetli baskı kurulabilir.

### Kurmaca olay, inanç, anlatım ve okur görünümü

Bir anlatıda kabul edilmiş olayla karakterin inandığı, anlatıcının söylediği, belirli bölümde okura açılan bilgi ve okurun fiilen çıkardığı sonuç ayrılabilir. Örneğin olay dünyasında bir mektup bilerek saklanmışken karakter onu kaybolmuş sanabilir; metin çelişkisi gibi görünen fark amaçlı olabilir. Gerçek bir zaman/kimlik hatasının sonradan keyfî biçimde 'yaratıcı belirsizlik' diye korunması da karşı hata olur. Her kurmacada tek ve tüm ayrıntıları belirlenmiş bir gizli doğru dünya zorunlu tutulmaz; belirsizliğin tasarlanmış olması ile yazarın henüz karar vermemesi ayrılır.

### Üç farklı sıra

Romanı üretme sırası, kurmaca olayların zamanı/nedensel ilişkileri ve okura anlatılma sırası tek görev listesine indirgenmemeli. Önce final taslağı yazılabilir, geçmişteki olay geç bölümde açıklanabilir. Birinin düzenlenmesi diğerini otomatik aynı sıraya koymamalıdır. Bunlar ayrı veri tabanları veya graph motorları önerisi değildir.

### İleri üretim kadar geriye etkili yeniden yazım

Geç bölümde karakterin motivasyonunu değiştiren aday, erken sahnelerin sözlerini değiştirmeden onların anlamını ve gerekçesini bozabilir. Etki yalnız aynı adın geçtiği bölümlerde değildir. Yeni sürümde kalan, değişen, atılmış alternatifler ve onlara ait özetler karışmamalıdır. Sadece sonraki bölümü üretmek yeterli test olmaz; büyük revizyon mutlaka sınama baskısı olmalıdır.

### Metnin kendisi ile onun özetinin ayrımı

Olay özeti olay bilgisini taşıyabilir; anlatım sesi, ima, ritim veya motifin tam etkisinin yerine geçtiği varsayılmaz. Süreklilik için temsil yararlıdır ama gerekince asıl metne dönülür. Tam metin okunmadan yalnız başarılı özetlerin değerlendirilmesi romanın edebi niteliğini doğrulamaz. Bütünsel okuma tek çağrı zorunluluğu değildir; kapsama ve okuma sırası korunarak yapılması gereken ayrı değerlendirmedir.

### Denetim ve yaratıcı bütünlük

Çok rolün olması çok ayrı yazar sesi gerektirmez. Araştırma, süreklilik ve eleştiri ayrılabilir; taslak üretimi tek veya birden fazla aktörle yürütülebilir. Her bölümü farklı aktöre atamak varsayılan yapılmaz. Tek yaratıcı sorumlu rolü bir adaydır, zorunlu mimari değildir.

## 5. Hazırlık önemli ama hazır planın yürütülmesine indirgeme riski var

Başarı ölçütü bütün hikâyenin yazımdan önce kilitlenmesi olmamalı. Hazırlık; yaratıcı amaç, hedeflenen okuma deneyimi, verilen sınırlar, dünya/alan araştırması, bakış açısı, ilk çatışma ve geçici taslak gibi ihtiyaca göre unsurlar içerebilir. Bazı kararlar yazımın kendisiyle keşfedilebilir. Ayrıntılı plan ve keşfederek yazım alternatifleri değerlendirme dışında bırakılmaz; birinin evrensel üstünlüğü iddia edilmez.

Plan değiştiğinde üretim otomatik hata sayılmamalı; yaratıcı amacın değişmesi, yöntemin değişmesi ve eserin değişmesi ayrı değerlendirilir. T11'in bitirebilme sorusu burada yeniden sınanabilir: sonsuz hazırlık veya revizyon ile gerekçeli editoryal kapanış ayrılır.

## 6. Değerlendirmeyi üç ayrı soruda tutma önerisi

- Belirgin koşul/tutarlılık kontrolü: kurulan dünya ve anlatım rejimi altında gerçekten hata olan yaş, zaman, bilgi edinme veya sürüm çatışması.
- Editoryal değerlendirme: sahne işlevi, karakter gerekçesi, ritim, anlatıcı sesi, tema ve bütünlük. Tek doğru test sonucu varsayılmaz; gerekçe metindeki karşılıklara bağlanır.
- Okur deneyimi: amaçlanan merak, duygu ve yorumun gerçek okuma sırasında oluşup oluşmadığı. Planı bilen bir LLM'nin okur taklidi, planı görmemiş insanların deneyimini ölçmüş sayılmaz.

Bu üçü tek PASS bayrağına veya keyfî yüzde puanına eritilmez. Öznel boyut olması gerekçeli değerlendirmeyi imkânsız kılmaz; kriter, bakış açısı, anlaşmazlık ve kanıt sınırı korunur. Her belirsizliği silen veya bütün anlatıcıları aynı üsluba sokan 'düzeltme' de başarısızlık olabilir.

## 7. Alternatif senaryolarla karşılaştırma — assistant değerlendirmesi

| Aday | Özellikle sınayacağı ihtiyaç | Bu turdaki konumu |
|---|---|---|
| Romanı geliştirmek, yazmak ve bütünsel revizyonla tamamlamak | Yaratıcı hedef, uzun erimli anlatı/bağlam, metinden keşif, öznel/editoryal değerlendirme, parça-bütün etkisi | İkinci vaka için öncelikli öneri |
| Belgelere dayalı bir araştırma kitabı hazırlamak | Çelişen dış kanıt, soruşturma yönünü değiştirme, iddia ve kaynak desteği | Güçlü alternatif; önceki kanıt/kabul ağırlığına daha yakın |
| Bir müze sergisini tasarlayıp açmak | Anlatı yanında fiziksel alan, dış taraf, tedarik, teslim zamanı, geri alınması güç etkiler | Metin dışı ayrı bir sonraki karşı-test adayı; bu tur başlatılmaz |

Bunlar performans sıralaması, sektör araştırması veya sayısal ölçüm değildir. Mevcut testten farklı hata yüzeyi üretme bakımından akıl yürütülmüş karşılaştırmadır. Roman da soru bankası gibi metin/artefakt ağırlıklı kalır; dış dünyadaki bağımsız aktörleri ve fiziksel etkileri tek başına güçlü sınamaz. Romanı her şeyi kapsayan nihai SOUL sınavı yapmamak gerekir.

## 8. Önerilen ama henüz işletilmeyen test çerçevesi

Çok oturumlu, bütünlük isteyen özgün roman; konu/yön/başlangıç karakterleri kısmen verilebilir. Teslimat adayı, başlangıç amacıyla ilişkisi açıklanabilen ve bütünsel editoryal değerlendirmeden geçmiş roman metnidir. Basım, dağıtım, reklam ve satış otomatik kapsama dahil edilmez; kullanıcı bunları daha sonra ayrıca isteyebilir.

Örnek baskılar: birden fazla bakış açısı veya zaman düzlemi; bölümler arası geç ortaya çıkan bilgi; taslak tamamlanmadan büyük bir motivasyon/yapı değişikliği; oturum/aktör devri; eski sürüm özetinin yanlış yönlendirmesi; yerelde iyi fakat bütünde uygunsuz sahne. Bunlar bütün romanların zorunlu özellikleri değildir. Sayfa, bölüm, kelime sayısı, tür ve ayrıntılı olay örgüsü bu tur seçilmedi.

İlk sınama için önerilen soru: 'SOUL, yaratıcı amacı yeterince belirlerken keşif alanını kapatmadan ve bütün romanı önceden dondurmadan ilk yazılabilir çalışmayı nasıl oluşturur?' Bu soru T12 olarak çalıştırılmadı. Bu tur senaryo uygunluğu ve test basınçlarını kullanıcıya döndürür.

## 9. Kaynaklar ve gerçek okuma derinliği

Başlangıç main `9316a7bbf669c2fa9d648cbe3db0af17bf051e3e`.

- EXP-004 STATE (`027587e09d8125450bb59b6a48316caeb66930a5`) ve INDEX (`2fdfa24cf955e82e80a3a89a891faceb4358cd44`): bu tur tam geri okuma. T11'in tam notu ve görünür cevabı aynı konuşmada önceki turda okunmuş/üretilmişti; yeni turda yeniden tam not okunduğu iddia edilmez.
- EXP-001 STATE (`709780f16ca747125d03fb84b75c7408eb4bee39`) ve TOPIC-MAP (`af3c40519e9889e9b20726f83a874cccb8d2fc6c`): tam. USER-MESSAGES'ta başlangıçtan U005/U006 dahil görülen kesim, sonrası kesilmiş; bütün kullanıcı korpusu tam okundu denmez. S016 (`dba5d60052ec02b5f1bc7d8f46110654a38f71ce`) tam. Roman/yaşayan plan izi geri çağrıldı, Atlas dosyaları/PDF'leri yeniden incelenmedi.
- Context/Memory/Harness META (`55e8d5abe294e9c9b4ae0cd121c1cea3a74b7007`) tam; bu konuşmada daha önce görülen studies katalog rotasından seçildi. Kalıcılık/bağlam/kullanım ayrımı için retrieval ve reuse sınırı; bütün study veya yeni upstream denetimi değildir.
- Yang ve diğerleri, [Re3](https://arxiv.org/abs/2210.06774), 2022 v3: başlık/abstract kapsamı doğrudan açıldı. Genel plan + mevcut hikâye durumu + yeniden değerlendirme/tutarlılık düzenlemesi; iki bin kelimeyi aşan hikâyeler. Tam roman/modern model/SOUL başarısına genellenmez; bütün paper veya uygulama incelenmedi.
- Yang ve diğerleri, [DOC](https://arxiv.org/abs/2212.10077), 2023 v3: abstract doğrudan. Ayrıntılı hiyerarşik taslak ve ona bağlı üretim, birkaç bin kelimelik hikâyeler; insan değerlendirmesi. Sonuçlar belirli deneylerle sınırlı, yüzde kazanımları veya tüm roman ölçeğine üstünlük bu değerlendirmede kullanılmadı. DOC benimsenmedi.
- Liu ve diğerleri, [Lost in the Middle](https://arxiv.org/abs/2307.03172), 2023 v3: abstract doğrudan. İncelenen modellerde çok-belgeli soru yanıtlama/anahtar-değer retrieval ve bilgi konumu hassasiyeti; roman kalitesi, güncel model kapasitesi veya tüm sistemler için sonuç değildir.
- Kukkonen, [Plot](https://www-archiv.fdm.uni-hamburg.de/lhn/node/115.html), 2014, Living Handbook of Narratology: özellikle Definition/Explication ve anlatı düzeni/okur ilerleyişi bölümleri, web görünümünde satır 43–66 ve 89–117. Olay/düzenleme, gerekçe/sonuç ve okurun değişen beklentileri için kavramsal dayanak. Bibliyografyadaki bütün kaynaklar veya tek evrensel roman kuramı doğrulanmadı.

Dar dış kaynak kontrolüdür; yeni candidate study veya kapsamlı otomatik roman yazımı literatür taraması değildir. Kontrol protokolleri araştırma delili yapılmaz. Bu nottaki roman karşı durumları ve alternatif karşılaştırması yeni exploration çıkarımlarıdır; kaynakların ampirik sonucu diye sunulmaz.

## 10. Kayıt sınırı

Bu not, current STATE ve INDEX'i günceller. T1–T11, korunmuş 31 mesajlık kaynak kesimi, manifest, onarım kayıtları, önceki EXP'ler, Foundation, studies, concepts ve agent-control değişmez. Yeni not kaynak transkripti sayımını artırmaz. Kütüphane girişlerindeki T1–T11 sayısı hâlâ doğru; yeni test yürütülmedi, güncel yön package STATE/INDEX'tedir. Git yayını ve geri okuma, modelin veya roman yazımının doğrulandığı anlamına gelmez.
