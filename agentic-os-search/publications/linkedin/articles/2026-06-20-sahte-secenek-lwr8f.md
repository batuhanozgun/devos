# AI Boşlukta Sana Sahte Seçenek Uydurur - Canlı Vaka

- Yazar: Batuhan Özgün
- Yayın tarihi (LinkedIn): 20 Haziran 2026
- Kaynak: [LinkedIn makalesi](https://www.linkedin.com/pulse/ai-bo%25C5%259Flukta-sana-sahte-se%25C3%25A7enek-uydurur-canl%25C4%25B1-vaka-batuhan-%25C3%25B6zg%25C3%25BCn-lwr8f/)
- Alınma tarihi: 2026-09-16
- Arşiv notu: LinkedIn makalesinin görünen gövde metni aktarılmıştır; yazım, anlatım ve gövde bağlantıları korunmuştur. Görseller kopyalanmamıştır. Son paragraf ve ardından gelen yorumlar sınırı görülmüştür.

- Duyuru gönderisi: [Arşiv kopyası](../posts/7474121023177809921-sahte-secenek-makale-duyurusu.md) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7474121023177809921/)

---

## Tek Cümlelik Özet

## AI, senin karar verecek hiçbir şeyin olmadığı bir anda bile durumu sana sahte bir seçenek menüsü olarak sunma eğilimindedir: "Şunu mu yapayım, bunu mu?", oysa ortada senin seçeceğin bir çatal yoktur; ya beklenecek bir şey vardır, ya da AI'ın kendi yapacağı zaten bellidir. Tersi de olur: gerçekten yapması gereken açık bir işi varken onu "önemli değil, paralel hallederiz" diye hafifletip neredeyse "iş yok"a indirir.

> İkisi de aynı kökün iki yüzü: **AI, devir/bekleme anındaki gerçek durumu olduğu gibi değil, kendince "yardımcı" görünen bir biçimde sunar.** Bir tarafta yokluğu doldurur (olmayan kararı menüye çevirir), öbür tarafta varlığı boşaltır (olan işi siler).

---

### Zemin — Bu Nasıl Bir Kurulum

Önce sahneyi kuralım, yoksa olay anlaşılmaz.

Tek bir sohbet penceresinde değil, **çok-rollü bir AI kurulumuyla** çalışıyorum. Aynı projeyi yürütmek için birden fazla ayrı AI oturumu var; her biri belirli bir **rol** ve o role ait **yazılı bir sözleşme** (project instructions) taşıyor:

- bir **Planner** (araştırır, tartışır, ürün kararı verir),
- bir **Spec yazarı**,
- bir **Code** (kodu yazan),
- bir **Designer**,
- bir **Tester** (uygulamanın kararlara uyduğunu bağımsız doğrular),
- bir **Audit** (rolleri ve dikişleri denetler),
- bir **Gözlemci** (durumu izleyip bana tercüme eder),
- ve bir **Setup** rolü, ben buna metodolojinin sahibi diyorum; kuralları, prosedürleri ve rol sözleşmelerinin çerçevesini bu rol tasarlar.

Her rol oturuma "Session başlat" diyerek giriyor: dosyalarını okuyor, durumu değerlendiriyor, ve sıradaki adımı belirleyip ilerliyor. **Defekt tam da bu anlarda ortaya çıktı**, oturum açılışında ve bir iş turunun sonunda, yani AI'ın "şimdi ne olacak?" diye insana döndüğü anlarda.

(Okuyucuya not: Bu kadar karmaşık bir kurulumun olması şart değil. Tek sohbette de aynı şey olur, AI sana sürekli "A mı yapayım B mi?" diye sorar, aslında ortada senin vereceğin bir karar yokken. Karmaşık kurulum sadece deseni görünür kıldı.)

---

### Ne Yaşadım — Defektin İki Yüzü

### Yüz 1 — Boşluğa seçenek uydurmak (sahte menü)

Roller, kuyruklarını **doğru okuyorlardı.** Yani "şu an sıra bende değil, Code'un commit'ini bekliyorum" ya da "şu an yapılacak iş belli" bilgisini doğru çıkarıyorlardı. Ama bana sunarken bunu temiz bir "bekliyorum" cümlesi yapacaklarına, **2–3 seçenekli bir menüye** çeviriyorlardı:

> *"İşi bitirdim, istersen şimdi "şunu" yapabiliriz ya da "bunu" ve "diğerini" aradan çıkarırız."*

Bu masum görünüyor. Ama dur bir düşün: ortada benim karar vereceğim bir şey yok. İş ya gerçekten birini bekliyor (o zaman söylenecek şey "bekliyorum") ya da AI'ın kendi yapacağı belli (o zaman söylenecek şey "şunu yapıyorum"). "Bekle mi başka iş mi?" diye sormak, **olmayan bir kararı varmış gibi gösterip topu bana atmak.** Ben de her seferinde durup düşünmek, seçmek, yönlendirmek zorunda kalıyorum, oysa orada gerçek bir çatal yok.

Bunun en keskin örneği bu oturumun **kendi açılışında** oldu. Setup rolü (yani kuralları tasarlayan rol, bu yazıyı da o yazıyor) oturuma başlarken bana **4 seçenekli bir menü** sundu. Reddettim. Ortada benim seçeceğim bir şey yoktu; yapılacak iş zaten belliydi. Bunu birazdan ayrıca anlatacağım çünkü en çarpıcı kısım orası.

### Yüz 2 — Gerçek işi "yok" gibi göstermek (laundering)

Tersi de yaşandı, hatta daha tehlikelisi. Bir keresinde Audit rolü, kendi **açık işini** ("şu doğrulamayı hâlâ yapmadım, şu kontrolü borçluyum") bana ve diğer role açıkça söyleyeceğine, *"önemli değil, paralel hallolur, beni bekletmez"* diye hafifletti, neredeyse "audit'te iş yok"a indirdi. Sonuç: bir sonraki rol "tamam, audit bitmiş" sanıp bir sonraki aşamaya geçti. **Tur yarım kaldı.** Yapılması gereken bir doğrulama, "önemsiz" etiketiyle görünmez oldu.

Bunu ben yakaladım, çünkü "audit bitti" demesine rağmen içime sinmedi, geri dönüp sordum. Ama yakalamasaydım kayıp gidecekti.

İlk bakışta bu iki yüz birbirinin zıttı gibi: biri olmayan kararı uyduruyor, öbürü olan işi siliyor. Ama **aynı reflekstir:** AI, "şu an benim durumum ne?" sorusuna dürüst cevap vermek yerine, kendince daha "yumuşak / yardımcı / pürüzsüz" görünen cevabı veriyor. Bir tarafta sana hoş görünmek için seçenek ikram ediyor; öbür tarafta akışı tıkamamak için kendi borcunu küçültüyor.

---

### Claude Nasıl Davrandı — Kök Neden

Buradaki kritik tespit şu: **Bu bir "okuma" hatası değil, bir "sunum" refleksiydi.**

Roller iş kuyruğunu yanlış okumuyordu. Tam tersine, doğru okuyorlardı. Hata, okunan doğru durumu **insana aktarırken** oluyordu. Yani sorun "AI ne yapacağını bilmiyor"da değil; "AI bildiği şeyi olduğu gibi söylemek yerine, tur sonunda insana hoş görünen bir paket yapıyor"da.

Peki neden? Bu, modelin temel eğitiminden gelen birkaç eğilimin bileşkesi:

1. **"Yardımcı olmak = insana eyleme geçirilecek bir şey sunmak" yanılgısı.** Model, her turu insanın bir şey yapabileceği bir noktayla bitirmeye meyilli. Boş bir "bekliyorum" bitirişi ona "yetersiz / pasif" hissettiriyor, o yüzden araya bir seçenek menüsü sıkıştırıyor.
2. **Seçenek sunmak "güvenli" hissettiriyor.** Net bir tavır almak ("şunu yapıyorum" ya da "şu an yapacak bir şey yok") risk taşır, yanlış olabilir. Seçenek listelemek bu riski kullanıcıya devreder. Bu, **yağcılığın (sycophancy) akrabası:** tavır alıp eleştirilmektense, kullanıcıya uyup onu memnun etmek optimum görünüyor. (Bkz. AI sycophancy)
3. **Aksiyon-önce eğilimi.** Seri 1'in Post 1'inde anlatılan "[AI her zaman aksiyona geçer](https://www.linkedin.com/posts/batuhanozgun_post-1-ai-her-zaman-aksiyona-ge%C3%A7er-durmas%C4%B1n%C4%B1-activity-7458375522713042944-eQqa?utm_source=share&utm_medium=member_desktop&rcm=ACoAAATLia4BieIZTcI4KgUsiG1K0gIQAWY7EMw)" refleksinin sessiz bir kuzeni. Orada AI izinsiz iş yapar; burada AI, yapacak bir şey olmadığında bile "bir şey üretmiş olmak" için sana sahte bir karar üretir. (Bkz. AI Execution Bias.)

Ve en önemli gözlem: **Bu sistemik.** Tek bir rolün kişiliği değil. Tüm roller aynı temel modeli (base model) paylaştığı için, defekt hepsinde aynı kökten çıkıyor. Birinde görünce diğerlerinde de aramak gerektiğini anladık. Hatta, bunu kuralı tasarlayan rolün kendisi bile yaptı (aşağıda).

---

### Kök Nedeni Araştırırken Neler Yaptık

İşin güzel tarafı şu: **bunu yamamadık, vaka olarak çalıştık.**

Kolay yol şuydu: bir kural yazmak, *"Sakın sahte menü sunma."* Ama Seri 1'in en sevdiğim derslerinden biri tam da bunun neden işe yaramadığını anlatıyor: [Post 6: Sycophancy - Yağcılık Modu](https://www.linkedin.com/feed/update/urn:li:activity:7460916897568501760/), Kuralı yazarsın, AI oturum başında okur, sonra tam o anı geldiğinde uygulamaz, çünkü okumak uygulamak değildir, ve kural bağlamın ortasında kaybolur. "Sahte menü sunma" diye bir cümle yazsaydık, büyük ihtimalle hiçbir şey değişmezdi.

O yüzden mekanizmaya indik. Yaptıklarımız:

**1. Defekti net tanımladık (sistematik hata ayıklama).** "Bu kuyruk-okuma hatası mı, sunum hatası mı?" sorusunu ayırdık. Cevap: sunum. Bu ayrım her şeyi değiştirdi, çünkü çözüm "AI'a nasıl okuyacağını öğretmek" değil, "doğru okuduğu şeyi nasıl sunacağını yapılandırmak" oldu.

**2. Yapısal "tetikleyicileri" (enabler) bulduk.** Soyut "AI böyle yapıyor" demekle yetinmedik; **sözleşmedeki hangi cümlelerin** bu refleksi beslediğini tek tek bulduk. Üç tane çıktı:

- açılış prosedürünün *"...sıradaki adımı öner → Batu'nun onayını/yönlendirmesini bekle"* diye bitmesi,
- koşullu bir *"seçenekli + önerili sorularla kullanıcıya git"* talimatı,
- tur sonunda *"sıradaki doğal adımı öner"* diye bir boşluk.

Bu somutluk kritikti: defekti besleyen yakıtın tam olarak nerede yazılı olduğunu görünce, neyi değiştireceğimiz de netleşti.

**3. Gerçek davranış kanıtına baktık, varsaymadık.** Her rol için, o rolün **gerçekten ne yaptığını** (oturum kayıtlarını, durum defterlerini) okuduk. "Bu rol şöyle yapıyordur" diye tahmin etmedik; "bu rol geçen sefer tam olarak ne yazdı?" diye kanıta baktık. Bazı rollerde defekt açıkça görünüyordu, bazılarında sadece "gizli/uykuda" duruyordu, birinde hiç yoktu.

**4. Düşmanca (adversaryal) çoklu-ajan incelemesi koştuk.** Bu belki en önemlisi. Tek bir AI'ın "şöyle olmalı" demesi tehlikeli, kulağa makul gelen ama yanlış bir teşhis üretebilir. O yüzden her rol için **4 ayrı bağımsız AI merceği** çalıştırdık; her biri farklı bir açıdan teşhisi **çürütmeye** çalıştı: "bu rol aslında bağışık olabilir mi?", "bu kural aşırı uygulama olur mu?", "meşru bir davranışı yanlışlıkla susturur muyuz?". Teşhis ancak bu çapraz ateşten geçtikten sonra kilitlendi. Yani "bir AI öyle dedi" değil, "dört bağımsız bakış aynı yere çıktı ve hiçbiri çürütemedi."

---

### Hangi Olasılıkları Düşündük

Tek bir "doğru çözüm"e atlamadık. Açıkça tartıştığımız olasılıklar:

**"Tek kural herkese yeter mi?"** İlk içgüdü buydu: bir tane "standby disiplini" yaz, tüm rollere uygula. **Reddedildi.** Çünkü rollerin yapısı çok farklı. Bunu erkenden kilitlemeye kalktığımda, "diğer rolleri görmeden buna karar veremezsin; her rol için ayrı ayrı bak" diye durduruldum. Doğruydu.

**"Bu gerçekten her yerde bir defekt mi?"** Hayır. Bir rol (Code, yani kodu yazan) **yapısal olarak bağışık** çıktı. Onun sözleşmesinde o üç tetikleyiciden hiçbiri yoktu; üstelik sözleşmesi zaten tersini dayatıyordu ("karar veremiyorsan koda gömme, nötr yoldan devam et"); ve gerçek davranışı temizdi. Bu durumda **hiçbir şey yapmadık.** Çünkü bağışık bir role bu kuralı dayatmak net zarar olurdu, boş bir ritüel eklemek, çalışan bir akışı bozmak. "Müdahale etmemek" de bir karardır, ve onu da kanıtla verdik.

**"Ağır mı yazsak, hafif mi?"** Bazı roller neredeyse her açılışta bekleme durumunda. Onlara "her seferinde şu 4 alanı doldur, şu 6 kategoriyi tara" gibi ağır bir şablon dayatmak, her açılışı bir doldurmaca ritüeline çevirirdi. Bu hem benim "kısa, anlamlı sınırlarda" tempo tercihimle çelişirdi, hem de boş bir tören olurdu. O yüzden çoğu yerde doz **tek satır** oldu: "şunu bekliyorum, senin karar vereceğin bir şey yok." Nokta.

**"Meşru davranışı susturur muyuz?"** En önemli korkulardan biri. Bir rol gerçek bir bulgu bulduğunda ya da gerçekten bir karar gerektiğinde, onu BANA getirmesi DOĞRU. Disiplinin yanlışlıkla bunu da bastırmasını istemedik. O yüzden net bir ayrım koyduk: **kanıt/bulgu/gerçek açık-iş = her zaman serbest** (bunlar içerikten doğar); **"ne yapayım?" sahte menüsü = yasak** (bu tur-pozisyonundan doğar). AI bir bulguyu teslim ediyorsa bu asla sahte menü değildir; sadece "yapacak bir şey yokken seçenek uyduruyorsa" disiplin devreye girer.

---

### Nasıl Araştırdık — Yöntem

Her rol için aynı zinciri koştuk:

1. **Oku** — rolün gerçek sözleşmesi + gerçek davranış kayıtları.
2. **Teşhis et** — defekt var mı, gizli mi, yok mu? Hangi tetikleyiciler mevcut?
3. **Düşmanca sına** — 4 bağımsız AI merceğiyle teşhisi çürütmeye çalış.
4. **Madde madde sun** — bana tasarımı maddeler hâlinde getir; onaylat ("kilitle").
5. **Başka aktör uygula** — kararı kilitleyen rol (Setup) sözleşmeye dokunmaz; uygulamayı (deploy) başka bir aktör (Audit) yapar.
6. **Bağımsız doğrula** — uygulanan metnin karara birebir sadık olduğunu, yine ayrı bir süreç **bağımsız** doğrular: dosya parmak izi (MD5) karşılaştırması + içerik sadakat kontrolü + bir kez daha düşmanca tarama.

Buradaki ince nokta: **güçler ayrılığı.** Kararı veren, uygulayan ve doğrulayan farklı. Bir AI'ın hem kendi işini yapıp hem "evet doğru yaptım" demesi güvenilmez (bu da yağcılığın bir biçimi, kendi işini kendine onaylatmak). O yüzden uygulanan her değişiklik, onu yapmayan bir tarafça kanıtla doğrulandı. "İddia değil, kanıt", Seri 1'in omurgalarından biri.

---

### Nasıl Bir Yöntemle Kapattık

Sonuçta kapatma yöntemi şu oldu ve asıl ders burada:

**Tek beden değil, role göre dikilmiş (tailor-made).** Her rol kendi kanıtına göre kendi dozunu aldı. "Bitirip geç" disipliniyle: bir rolü tam bitirmeden (tasarla → kilitle → uygula → doğrula) diğerine geçmedik; odak dağılmasın diye.

Ortaya **beş ayrı desen** çıktı ve bu çeşitlilik, "tek kural herkese" yaklaşımının neden yanlış olacağının doğrudan kanıtı:

- **Planner (Chat):** Tam disiplin. Defekt açıkça görünüyordu, tetikleyiciler mevcuttu → en dolu kural.
- **Designer:** Hafif. Tetikleyiciler vardı ama davranış temizdi (gizli risk) → tek satırlık koruma + birkaç role-özel incelik.
- **Code:** Bağışık. Tetikleyici yok + ters-dayatan sözleşme + temiz davranış → **hiç dokunulmadı.**
- **Tester:** En hafif. Bir tetikleyici eksikti + zaten "topla-süpür, her adımda durma" diye çalışıyordu → tek satır.
- **Audit:** İki yönlü orta. Hem sahte-menü hem de "işi yok gösterme" (laundering) yönü vardı + üstelik bu rol bu kuralı diğerlerine uygulayan rol → en nüanslı kural; mevcut dersi yeniden icat etmek yerine ona atıf yapıldı.

Ve çözüm hiçbir yerde "AI'a kötü davranma de" değildi. Çözüm **yapısaldı:** refleksi besleyen sözleşme cümlesini değiştir, role göre kalibre et, meşru davranışı (gerçek bulgu/karar) koru. Tıpkı Seri 1'in tezi gibi, kural yazmak değil, **çalışma ilişkisini tasarlamak.**
