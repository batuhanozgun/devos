# DevOS: Batu için özet

Bu metin senin için hazırlanmış bir özettir. Bağlayıcı metin İngilizce plandır: `plan/DevOS_Kurulum_Plani.md` ve ekleri (Ek A–G). Plandan sonra verdiğin kararların kayıtları `plan/decisions/` altındadır; onlar da İngilizcedir. Bu özet ile İngilizce metin arasında herhangi bir fark olursa İngilizce metin geçerlidir. Tarih: 5 Ekim 2026. Kaynak: `main` dalındaki `8349242` commit'i (plan sürüm 2.1; İngilizce çevirinin sadakat incelemesi geçtikten sonra). Bu özeti planın kuralı gereği DevOS tutar (Bölüm 0.6 madde 1).

Tırnak içindeki ve alıntı biçimindeki Türkçe metinler plandan ya da kayıtlardan aynen alınmıştır. Plandan alınanlar senin kararlarının aslıdır; "senin sözlerin", "senin sözün", "onayın" ya da "cevabın" diye verilenler kendi sözlerindir; karar kayıtlarının Türkçe başlıkları ise kurucunun yazdığı başlıklardır. Alıntılarda geçen "Batu" sensin.

---

## Genel resim

### SOUL

Senin tanımın (Bölüm 1.1, Batu kararı):

> SOUL, kullanıcının uzmanlığının yetmediği işlerde bu açığı kapatan; işi, bilgiyi, aktörleri ve çalışma koşullarını keşfedip bir çalışma sistemi halinde birleştiren ve yöneten; kullanıcıyı yalnız onun karar vermesi gereken yerlerde, karar verebileceği kadar bilgilendirerek sürece katan; gerektiğinde kendi çalışma kapasitesini kontrollü biçimde uyarlayan bir yapıdır.

> "Bilgilendirmek", ders anlatmak değildir. Kullanıcı bir amaç, tercih ya da bütçe belirlerken işin gerekleri hakkında eksik bilgiye sahip olabilir. SOUL bu kısıtları sabit girdi saymaz: işin gereğiyle çelişen bir kısıtta kaliteli seçeneği, amacını, faydasını, bedelini ve alternatifini sunar; kararı kullanıcı verir. SOUL açık kaynak olacak ve başkaları kendi hesaplarıyla kurabilecek.

### DevOS

DevOS, SOUL'u geliştiren çalışma sistemidir. SOUL'un hangi işlere ihtiyacı olduğunu kendisi bulur; araştırır, tasarlar, uygular ve sınar. SOUL'un ilk gerçek işini ne sen ne bu plan seçer; kurulan ekip bulur (Bölüm 1.2).

DevOS aynı zamanda SOUL'un ilk örneğidir: konusu önceden bilinen bir SOUL. Bu yüzden bağlam, bellek, bilgi bulma, iş takibi ve sınama katmanı atılacak bir iskele değil, SOUL çekirdeğinin ilk biçimidir. DevOS'un SOUL'u geliştirmedeki başarısı ya da başarısızlığı, SOUL yönteminin ilk kanıtıdır.

### Üç aşama (Bölüm 1.3)

- **A. Kurulum (C00–C12):** DevOS kurulur. Kurucu Claude Code oturumu çalışır ve araştırma kütüphanesini doğrudan okur.
- **B. DevOS çalışırken:** DevOS ekibi SOUL'u geliştirir. Rollerin çoğu çalışma oturumunda alt ajan (bir oturumun içinde belirli bir rolle çalışan yardımcı ajan) olarak çalışır; bağlayıcı inceleme ve sınavlar ayrı ortamlardadır; oturumları routine'ler (zamanlanmış başlatıcılar) açar. Ekip bilgiye depoları açarak değil, bilginin aktarıldığı kütüphanede arayarak ulaşır.
- **C. SOUL çalışırken:** SOUL kullanıcıların işini yapar, başkalarının hesaplarında da. Bu depolara bağlı değildir; DevOS, SOUL'un ihtiyaç duyduğu bilgiyi SOUL'un kendi ürününe ve kütüphanesine uygun biçimde koyar.

### Başarı neyle ölçülür (Bölüm 1.4, Batu kararı)

> Veritabanının çalışması, rol dosyalarının bulunması ya da görevlerin aktarılması tek başına başarı değildir. DevOS şu kabiliyetleri gerçek işte gösterdiğinde başarılıdır:
>
> 1. Doğru işi keşfetmek.
> 2. İyi araştırmak.
> 3. Gerekçeli karar vermek.
> 4. Hatalarını sınamak ve genel kuralına kadar götürmek.
> 5. Uzun ve bileşik işleri bütünlüğünü kaybetmeden sürdürmek.
> 6. Araştırma birikimini gerçekten kullanmak.
> 7. Bunları Batu'nun mesaj taşımasına ya da teknik bakım yapmasına ihtiyaç duymadan yapmak.

### DevOS'un parçaları (Bölüm 3)

- **Claude Code cloud — ofis:** Ajanların düşündüğü, araştırdığı ve yazdığı yer.
- **Çalışma oturumu — ofiste çalışan ekip:** Günde birkaç kez açılır. Koordinatör ajan işin gerektirdiği rolleri alt ajan olarak çalıştırır; roller arası devir oturumun içinde olur.
- **Denetim ve sınav oturumları — dışarıdan gelen denetçi:** Ayrı anahtarlarla bağlayıcı incelemeyi, kabulü, kural değişikliklerinin incelemesini ve sınavları yapar.
- **Routine'ler — sabah açılan kapı:** Açık oturum yokken oturum başlatır; günde birkaç kez.
- **Supabase — kayıt, kapıcı ve kütüphane:** Canlı iş kayıtları, kurallar, arama kütüphanesi; kimin neyi yapabileceğine karar verir.
- **GitHub — arşiv ve kalite kontrol:** Üretilen her şey burada; kontrollerden geçmeyen değişiklik ana ürüne girmez.
- **Karar kanalı — senin masan:** Senden karar gerektiğinde telefonuna bildirim gelir; cevabını güvenli bir yoldan verirsin.

### Bir günün akışı

1. Sabah bir çalışma oturumu açılır.
2. Koordinatör durum özetini okur ve hazır işi seçer.
3. İşin gerektirdiği rolleri (keşif, araştırma, tasarım, üretim) kendi paketleriyle alt ajan olarak çalıştırır. Araştırma ve inceleme paralel yürür; bir ürünü aynı anda tek ajan yazar.
4. Sonuçlar kaydedilir; değişiklikler PR (değişikliğin ana ürüne alınmak üzere sunulması) olarak gönderilir.
5. Denetim oturumu gelir; bağlayıcı incelemeyi ve kabulü yapar.
6. Senden karar gerekiyorsa telefonuna gelir; cevabın sonraki oturumda işlenir.

Görmediğin ama sürekli çalışan işler: yedekler, kütüphanenin güncel tutulması, takılan işlerin fark edilmesi, kullanım takibi, tekrar eden hata kalıplarının taranması, amaç denetimi, sessiz hata örneklemesi.

### Kurulum şu an nasıl yürüyor (Bölüm 9)

Kurulumu tek bir çalışma oturumu yürütür (senin D-010 kararın, aşağıda). Oturum planı kendisi okur, plan sırasındaki sonraki adımı alır, işi rol tanımlı alt ajanlara ve workflow'lara (birden çok alt ajanı birlikte yürüten iş akışı) verir ve `main`'e (deponun ana dalı; tek doğru kaynak) yalnız kendisi yazar. C03'e kadar bağlayıcı onayı, işi yapmamış ve taze bağlamla bakan bir Denetçi alt ajanı verir ve kararında bağımsızlık düzeyini yazar; C03'ten sonra bu onay denetim ortamında verilir. Durum her zaman Türkçe `DURUM.md` sayfasında günceldir.

---

## Senin kararların

Burada yalnız senin verdiğin kararlar var. Teknik kararları ekip gerekçesiyle verir. `K1`–`K9` biçimindeki numaralar yalnız senin kararlarındır; `B1`–`B3` de senin kararlarındır. `PC-` ile başlayanlar kurucunun plan değişiklikleri, `D-` ile başlayanlar karar kayıtlarıdır (`plan/decisions/`).

### Temel kararların (Bölüm 11.1)

> SOUL tanımı; SOUL'un açık kaynak olması; DevOS'un Claude Code cloud'da çalışması; Max 200 $ planı, ekstra kullanımın kapalı olması, ortamda Anthropic API anahtarı olmaması; Supabase'in kişisel hesapta kullanılması; depoların herkese açık olabilmesi; yeni depolar (`devos`, `soul-system`, `devos-evals`, `devos-backup`) ve eski depolara dokunulmaması; eski deneme depolarının kütüphaneye alınması; eski raporların ChatGPT tarafından arşivlenmesi ve deponun kurucu başlamadan hemen önce düzeltilmesi; tek yazar ilkesi; güvencelerin her işte tam, emek derinliğinin varsayılan olarak yüksek olması; testlerde yalnız sahte veri; telefondan kullanım; Academy notunun karar değil keşif notu olması; bu planın uyduğu ilkeler (Bölüm 0.3).

Bunların plandaki ayrıntısı:

- **SOUL (Bölüm 2, kriter 1–4):** Tanım ve başarı ölçütü yukarıda. "**Açık kaynak:** Başkaları kendi hesaplarıyla kurabilir; SOUL, Batu'nun altyapısına bağımlı değildir." "**Kullanıcı verisi:** Kullanıcının kendi alanında kalır; ortak öğrenmeye özel bilgi sızmaz." "**Sağlayıcı bağımsızlığı:** SOUL, Claude dışındaki bir modelle de çalışabilecek biçimde tasarlanır ve bu gerçek bir sınamayla gösterilir (C11). Gösterilene kadar iddia edilmez."
- **Senin rolün ve ortam (kriter 21–24):** "**Rol:** Amaç, karar, kabul. Mesaj taşımak ve bakım yapmak yok." "**Bilgisayar kapalıyken çalışır.**" "**Telefon:** Claude uygulaması ve kesin ulaşan bir yedek kanal; kararlar tek listede, sade Türkçe, kısa seçenekli." "**Kendi bakımı:** Yedek, izleme ve denetim düzenli çalışır; çözülemeyen karar listesine düşer."
- **Claude (kriter 25; Bölüm 5.1):** "**Claude:** Max 200 $ planı. Ekstra kullanım kapalı. Ortam ayarlarında Anthropic API anahtarı yok." Çalışma yeri: "**Seçim:** Claude Code cloud. **[Batu kararı]**"
- **Supabase (kriter 26; Bölüm 5.3):** Canlı durum "Batu'nun kişisel Supabase hesabı"nda tutulur. Supabase seçimi plandaki öneriydi; sen kabul ettin. Plan seviyesi ayrıca sorulmuştu: B1, aşağıda.
- **Depolar (Bölüm 0.5; kriter 27):** "Her deponun tek yazarı vardır; yazar olmayan yalnız okur." Yeni depolar: `devos` (açık), `soul-system` (açık), `devos-evals` (gizli), `devos-backup` (gizli). Araştırma kütüphanesi `agentic-os-search`'ün yazarı "ChatGPT, Batu'nun onayıyla"dır; kurucu yalnız okur. Eski deneme depolarına kimse yazmaz. Depolar senin kararındır; dal koruması, otomatik kontroller gibi GitHub ayrıntıları ise plandaki öneridir.
- **Özel içerik (Bölüm 10.2, U-6):** Özel içeriğin başka sözcüklerle yeniden anlatılarak sızma riski için: "Kalan risk Batu'ya açıkça bildirilmiştir; kütüphanede gerçekten gizli kalması gereken bir bölüm varsa o bölüm ajanların erişiminden tamamen çıkarılabilir (Batu kararı)".
- **İlkeler (Bölüm 0.3):**

> 1. Kalite kolaylık ya da ucuzluk uğruna düşürülmez. Varsayılan emek ve derinlik yüksektir; daha azı gerekçeyle yapılır.
> 2. Pahalı ya da karmaşık olan daha iyi sayılmaz. Aynı gereksinimi aynı kalitede karşılayan daha sade çözüm tercih edilir.
> 3. Ücret, farklı bir araç ya da bir kısıtın değişmesi gerekiyorsa bu Batu'ya kazancı, gerekçesi, alternatifi ve bedeliyle sunulur. Masraf ne Batu adına kabul edilir ne de ihtiyaç sessizce budanır.
> 4. Gereksinim sıralamak yetmez; her gereksinimi karşılayan mekanizma, parçaların birlikte çalışması, koşullar, başarısızlık hali ve sınama yolu yazılır.
> 5. Teknolojiden değil ihtiyaçtan başlanır. Maddi alternatifler seçimden önce karşılaştırılır.
> 6. Tasarlanmış ama doğrulanmamış olan ile çözümü bulunmamış olan açıkça ayrılır. Çözülmemiş bir tasarım sorunu "kurulumda sınanacak" diye çözülmüş gösterilmez.
> 7. Testlerin sayısı değil neyi kanıtladığı önemlidir. Her test yanlış çözümü yakalamalı, doğru çözüme izin vermeli ve iddia edilen kabiliyeti gerçekten temsil etmelidir.
> 8. Aşamalı çalışılır ama hedef küçültülmez. Kritik belirsizlikler, onlara bağlı büyük işlerden önce ele alınır.
> 9. Eksikleri bulmak planı hazırlayanın ve kurucunun sorumluluğudur; Batu'ya yalnız ona ait kararlar, gereken bilgiyle birlikte gelir.
> 10. Asıl ölçüt, DevOS'un SOUL'u gerçekten geliştirebilmesidir. Daha çok kayıt ve kontrol, SOUL'un ilerlediği anlamına gelmez.
> 11. **Çerçeve körlüğü DevOS'un ve SOUL'un en büyük tehlikesidir.** Bir tasarım bir sınıra takılıp çözüm olarak yeni mekanizmalar üretmeye başladığında, önce çerçevenin kendisi sorgulanır. Teknik kararlar, etkileri büyük olsa da, gerekçesiyle ekip tarafından verilir; Batu'ya yalnız ona ait kararlar gelir. **[Batu, 29 Eylül 2026]**
> 12. **Güncel platform okuması:** Planın dayandığı her platform davranışı, resmî belgenin güncel sürümünden ve tarihiyle okunur; ikincil kaynak "doğrulandı" sayılmaz. **[2.0 incelemesinden çıkan ders]**
> 13. **Etki kanalı envanteri:** Ajanın dünyada etki üretebildiği her kanal (veritabanı, GitHub, connector'lar, ağ, ikinci model, zamanlanmış işler) tek listede tutulur; her biri için sınır ve olumsuz test yazılır. **[2.0 incelemesinden çıkan ders]**

Ek E'deki açık talebinin ilk maddesi (Ek E Bölüm 5, 29 Eylül 2026; öbür üç maddesi yukarıdaki ilkelerde, 0.3 madde 1, 2 ve 6'da var):

> Kalite kolaylık ya da ucuzluk uğruna düşürülmez. "Şimdilik bu yeter", "bunu basitleştirelim", "uygulayıcı sonra çözer" yaklaşımlarıyla gerekli kapasite azaltılmaz.

### 29 Eylül 2026'da eklenenler (Bölüm 11.1)

- **K6:** "`devos` açık kalır; özel içeriğin kazara açığa çıkma riski, koda dayalı ön kontrollerle azaltılmış haliyle kabul edildi."
- **K7 (kriter 20):** "**Test verisi:** Kişisel ve iş verisi testlerde hiç kullanılmaz; yalnız sahte veri. DevOS'un kendi araştırma kütüphanesi ölçümlerde kullanılabilir."
- **Kriter 32, 33 ve 34 kabul edildi** (Bölüm 2):
  - "**Ortak düşünme standardı ve rol hazırlama:** Her rol, uzmanlığı ne olursa olsun aynı ortak düşünme tabanını taşır. Yeni bir rol yalnız bir ad ve görev cümlesiyle değil; bilgi haritası, yöntemler, araçlar, bilinen hata sınıfları, örnekler ve gizli sınavla hazırlanır; bu hazırlık her oturum açılışında, katkı talebinde ve kesintiden dönüşte yeniden kurulur. İşin küçüklüğü uzman değerlendirmesini atlama gerekçesi değildir; değerlendirme sonucunda az iş yapılabilir."
  - "**SOUL'daki ajan kalitesi bir alt sınırdır, tavan değil:** SOUL'un kendi ajanları ve SOUL'un bir iş için oluşturduğu ya da sonradan eklediği ajanlar en az DevOS rolleri kadar yüksek bir düşünme standardı taşır. SOUL'un ajanları nasıl hazırlayacağı ve bu kaliteyi nasıl koruyacağı, DevOS'un kendi yönteminin kopyalanmasıyla değil, DevOS'un araştırma, tasarım ve sınama işiyle bulunur; DevOS'un bugünkü rol hazırlama yöntemi bu işin çıkış noktası ve karşılaştırma ölçütüdür. SOUL için daha iyi bir yöntem bulunursa bunun daha iyi olduğu aynı tür gizli sınavlarla gösterilir ve DevOS kendi rollerini de bu yöntemle iyileştirmeyi değerlendirir."
  - "**Çerçeve körlüğüne karşı mekanizma:** DevOS, dayandığı öncülleri açıkça yazar, bir tasarım bir sınıra takıldığında önce çerçeveyi sorgular ve büyük tasarım kararlarında mevcut tasarımı görmeyen bağımsız bir karşı tasarımla karşılaştırma yapar (Bölüm 6.12). Bu aynı zamanda SOUL'a aktarılacak bir gereksinimdir."
- "Teknik kararlar (çalışma düzeni dahil) ekip tarafından gerekçesiyle verilir."
- **B1 = (2), Supabase plan seviyesi:** "C04 ölçümüne kadar ücretsiz plan; ölçüm sınıra yaklaşıldığını gösterirse kapsam daraltılmadan önce karar Batu'ya gelir." Kuralı: "Ücretsiz plana sığmak için hiçbir kapsam daraltılmaz." (Bölüm 11.2)
- **B2 = (1), ikinci model ailesi:** "Gemini API ücretsiz katmanı; yalnız açık içerik, tek geçitten." Gönderilen içerik Google'ın ürün geliştirmesinde kullanılabileceği için "yalnız sahte veri ve açık depolara girecek içerik gönderilir; özel kütüphane hiçbir zaman gönderilmez" (Bölüm 11.2).
- **B3 = (a):** "Sistem için ayrı GitHub makine hesabı." Hesap `batuhanozgun-devos`; yazma erişimi `devos`, `soul-system`, `devos-evals`. Kurucu C00–C04 arasında kütüphaneyi doğrudan okuduğu için `agentic-os-search`'e de erişimi var; GitHub bunu teknik olarak yazma yetkisi olarak veriyor, ama kural değişmez: "DevOS bu depoya hiçbir şey yazmaz." Güvenceler: kurucunun talimatı; makine hesabının bu depoda yaptığı her commit'i sana bildiren, DevOS'tan bağımsız bir izleme yolu; kütüphane C04'te aktarılıp doğrulandıktan sonra erişimin kaldırılması (Bölüm 0.5). Karar issue'larını makine hesabı açtığı için bildirimler sana güvenilir biçimde ulaşır (Bölüm 11.2).
- **K8 = (a):** "DevOS için yazılmış tasarım belgeleri (plan, ekler, `CLAUDE.md` ve düşünme disiplinlerinin uyarlaması) ve Batu'nun kararları ile beklentileri açık depoda durur." Açık depoya yazılamayanlar: "Kütüphanedeki araştırma içeriğinden aynen ya da anlamca yakın aktarım ve konuşma dökümlerinden aktarım" (Bölüm 0.5).
- **K9, dil:** "DevOS'un bütün dosyaları, kayıtları ve kendi içindeki iletişimi İngilizcedir; Batu ile iletişim Türkçedir (Bölüm 0.6)." Sonuçları: kararların kayda hem Türkçe aslıyla hem İngilizce yorumuyla girer; sana giden Türkçe metin İngilizce kayıttan üretilir ve ilgili yerlerde kendi Türkçe ifaden gösterilir; sana atanan karar issue'ları Türkçedir. Planın İngilizce çevirisi sadakat incelemesinden geçtiği için artık tek bağlayıcı metin İngilizcedir; Türkçe sürümler depodan kaldırılır, sendeki kopya okuma amaçlıdır.

### 1 Ekim 2026'da verdiklerin (Bölüm 11.1, Bölüm 9)

- **PC-02, dal yönetimi:** "dal açmak, `main`'e almak ve silmek kurucunun yönetimindedir; birleştirme için Batu'dan onay istenmez." Senin sözün: "Repolardaki branch yaratmak, branch'ı main'e taşımak, silmek hepsi senin yönetiminde olsun." Kurucunun sınırları: kütüphane depolarına hiç dokunmaz; `main`'e yalnız PR ile girer, dal korumasını kapatmaz ve atlatmaz; her birleştirmeyi ve dal silmeyi deftere yazar; her duruştan önce işi `main`'e alır.
- **PC-04, kurucunun çalışma düzeni:** Kurucunun kendi çalışma düzenini tasarlayıp sınaması. Beklentilerin 1–5 geçerlidir: (1) sen mesaj taşıyıcı değilsin; (2) sana yalnız senin kararların gelir, yüksek etkili değişikliklerin teknik onayı bağımsız incelemeden gelir ve plan buna göre değişir; (3) kurucu her adımda seni beklemez, senin işlerin toplu gelir; (4) "bitti" kanıta dayanır, senin onayın teknik doğruluğun kanıtı değildir; (5) her zaman güncel bir Türkçe durum sayfası. Kurucunun o zamanki düzeni PC-06 ile kaldırıldı; beklentilerinin tek istisnası D-010'dadır (aşağıda). (Kaynak: PC-04 kaydı; C00 günlüğü L-015.)
- **PC-05, teknik onay sende değil:** "Batu'ya teknik onay sorusu gelmez. Batu'ya yalnız ona ait kararlar gelir: amaç, kapsam, maliyet, hesaplarını ve diğer işlerini etkileyen seçimler ve kabul. Bir değişiklik bunlardan birine dokunuyorsa (örneğin bir kısıtı ya da maliyeti değiştiriyorsa) o yönüyle Ek E biçiminde karar olarak gelir." (Bölüm 4 K-11 madde 7)
- **PC-01:** Kurulum aşamalarının `/goal` (oturuma verilen ve sağlanana kadar oturumu sürdüren hedef) ile ve üç duruş koşuluyla, aşama başına bir `/goal` olarak yürümesi. 5 Ekim'de bunun senin kararın olmadığını belirttin; PC-06 ile kurulumun tamamı için tek `/goal` geldi.

### 5 Ekim 2026: D-010

"Kurulum, işi rol tanımlı alt ajanlara ve workflow'lara dağıtan tek bir çalışma oturumunda yürür; kurucunun eski çalışma düzeni kaldırılır; bütün kurulum için tek /goal". Onayın: "Onaylıyorum, 34, 35 ve 36 da tamam" ve "Üç madde mantıklı ... İtirazım yok" (sözlerinin aslı: `briefs/conversation/KARAR_OZETI_2026-10-05_TR.md`).

- Kurucunun eski düzeni (oturum zinciri, ardıl koşular, ayrı inceleme oturumları) yenisinin yanında tutulmadan kaldırıldı.
- Onaydan sonra eklenenler: E1, PC-01 senin kararın değil. E2, kurulumun tamamı için tek `/goal`.
- E3, yazdığın yerler: oturumu bir kez açıp ilk mesajı yapıştırmak; kendi kararlarını cevaplamak; kullanım sınırı sıfırlandıktan sonra bir "devam" mesajı. İlk sıfırlamada oturum kendiliğinden sürerse "devam" gerekmez; bu mesaj sana ağır gelirse otomatik mod seçeneği yeniden sana gelir.
- Onayladığın özetin 34. maddesi: Geçişin bir kez bağımsız incelenmesi için konuşma oturumunun yaklaşık bir dakika otomatik moda alınması; D-008'e tek seferlik istisna.
- 35. madde: PC-04 ve PC-05'teki kendi kısımlarına dokunanlar dahil PC-06 plan değişiklikleri. Örneğin C03'e kadar bağlayıcı onayı, bağımsızlık düzeyini yazan taze bağlamlı Denetçi alt ajanı verir.
- 36. madde: Workflow'ların ve paralel alt ajanların ortak kullanımdan daha çok harcaması.
- Bu karardaki ilkelerin (`plan/Installation_Working_Order.md` bölüm 1, özetin 3–9. maddeleri):

> 3. "Kendi kendine ilerlemek" = plana sadık kalarak son adıma kadar gelip DevOS'u kurmak; çalışırken "şu dosyaya yazayım mı, bunu okuyabilir miyim" diye sormadan çalışmak.
> 4. Kurulumun iki temeli: (a) işi planlanan adımlara göre ilerletmek; (b) plandan kopmadan, drift yaşamadan, nerede kaldığını unutmadan ilerlemek.
> 5. Batu teknik karar vermez. Teknik kararları kurucu, araştırmaya ve kanıta dayanarak verir. Batu'nun sözleri teknik şartname değildir; örneğin "ayrı oturum" ya da "o işi yapmamış bir oturum" derken teknik olarak ayrı bir oturumu kastetmedi.
> 6. Akıl yürütme ilkesi: anomaliler (ör. oturumun ölmesi; "olursa yapacak bir şey yok") standart akışla karıştırılmaz; ikisini karıştırmak kararları baltalar. Standart akışta düzenli yaşanacaklar (ör. kullanım limiti) ise standart akışın parçası olarak tasarlanır.
> 7. Akıl yürütme ilkesi: her yan dal kapanır ve ana iş hattına dönülür (madde 2).
> 8. Batu ile iletişim: kısa cevaplar; adım adım birlikte; konuyu dağıtmamak; soru sorarak konuyu dağıtmamak.
> 9. Önce çalışma oturumunun nasıl çalışacağı belirlenir ("kurulumun kurulması"), sonra kurulur; C00'a bundan önce dönülmez. "Kurmak"tan anlaşılan konuştukça netleşebilir; bu özet o yüzden değişebilir.

### Karar kayıtlarındaki diğer kararların

- **D-002, kalıcı kullanım politikası** (2 Ekim; cevabın "D-002: a, D-003: a"): Kullanım durumu serbestken iş sürer; uyarı durumunda yalnız hafif iş yapılır; sınıra ulaşılınca iş durur. 4 Ekim'de gece tercihini kaldırdın: "Ağır işler gündüz de yapılabilsin, benim Claude Code'da başka bir işim yok." D-010'dan sonra en çok iki paralel inceleme sınırı artık yok (ek kullanımı 36. madde ile kabul ettin) ve sınır sıfırlanınca iş senin "devam" mesajınla sürer.
- **D-003, kalan risk** (2 Ekim; aynı cevap): Connector'ları (hesabındaki posta, takvim, dosya gibi bağlantıları) engelleyen kanca (her araç çağrısına izin veren ya da onu reddeden küçük program), kurucunun kendisinin değiştirebildiği bir programdır. Bu kalan riski denetim ortamı kurulana kadar (C02–C03) kabul ettin; C03'te ya da kancanın bilerek atlatıldığı görülürse yeniden değerlendirilir. Kabulünün, açık deponun geçmişinde görülen bir açığı (OI-012) da kapsayıp kapsamadığı henüz sana sorulmadı; sonraki toplu sorularında teyit için sorulacak.
- **D-008, izin modu, model ve efor** (4 Ekim): "Oturumlar otomatik moddan çıkar: her araç çağrısına yazılı bir kural dosyası ayrıntılı gerekçesiyle izin verir ya da reddeder; kurucunun açtığı her oturum Opus 5.5 ve ultracode eforuyla çalışır". Senin sözlerin: "denetim yapılamıyor sistemde, bu sorunu çöz"; "auto mode'da çalışmayalım". Oturumlar "Accept edits" modunda çalışır; kanca her reddinde neyin denendiğini, hangi kuralın durdurduğunu, kuralın neden var olduğunu ve onun yerine ne yapılacağını yazar. Önemli değişiklikler bağımsız incelemeden geçmeye devam eder. Karar vermeden önce sana söylenen bedeller: (1) Claude Code'un otomatik denetleyicisinin kimsenin listelemediği tehlikelere karşı genel koruması gider, yalnız kurucunun yazdığı kurallar kalır; (2) eksik bir kural, liste tamamlanana kadar işi ilk boşlukta durdurur. Ayarlar depoda olduğu için bu depoda kendi açtığın oturumlara da uygulanır; kendi oturumun için uygulamada başka mod seçebilirsin, kanca her modda çalışır. Tek istisnası D-010'un 34. maddesidir.
- **Artık geçerli olmayanlar:** D-001 ("Hafif işlerle ilerle.") yerini D-002'ye bıraktı. D-009, D-010 ile geri çekildi; cevap gerekmez. Ama ayrı bir oturum başlatma ihtiyacı C01'de geri gelir: Accept edits'teki oturum yeni oturum başlatamadığı için bu, o zaman sana tek ve dar bir soru olarak gelir. D-006 ve D-007'yi reddettin: sana sorulmaları yanlıştı. Kurucunun oturumları tek bir sistemdir; kurucunun yaptığı ya da dayandığı bir kural veya izin kurucunundur, sana sorulmaz.

### Açık karar: D-011 (senin cevabını bekliyor)

"Çalışma oturumunun kütüphaneye erişimi: platform araştırma kütüphanesini oturuma yalnız bir kişinin onayıyla ekliyor; Accept edits (D-008) bu onayı veremiyor". Soru: Bu çalışma oturumu, kütüphaneyi eklemek için bir kez kısa bir süre Auto modda çalışabilir mi (D-008'e tek seferlik istisna)?

- **(a) Önerilen:** Bir kez kısa Auto penceresi: sen izin modunu Auto'ya alıp oturuma "auto" yazarsın; oturum yalnız ekleme çağrısını yapar (reddedilirse tekrar denemez); sen yeniden Accept edits'e dönersin.
- **(b)** Accept edits kalır; C04'ten önce kütüphane doğrudan okunmaz. Plan değişikliği gerekir ve soru C04'te geri gelir.
- **(c)** Bu oturum bundan sonra Auto'da çalışır; D-008 bu oturumun bütün işi için tersine döner.

Ek F'de (sürüm 2.0) oturumun kütüphaneyi sonra, yalnız okuma için kendisinin ekleyeceği yazıyordu; bu yanlıştı. Cevap gelmezse kütüphane gerektirmeyen işler sürer; C00 adım 4'ün kütüphane kısmı bekler, bu yüzden C00 kapanamaz. Sessizliğin onay sayılmaz. Ayrıntı: `plan/decisions/D-011.md`.

---

## Senin yapacakların (Bölüm 12)

Zamanı gelince kurucu her birini sana adım adım yazar. Anahtar ve token (bir sisteme giriş yetkisi veren gizli değer) gibi gizli bilgiler hiçbir zaman sohbete yazılmaz.

**Hazırlıkta** (hazırlık planına göre; C00'dan önce tamamlanmış olması gerekir, Bölüm 0.4):

- B1–B3 kararları.
- B3 (a) seçildiği için makine hesabını açmak ve Claude'un GitHub bağlantısını ona taşımak.
- Claude GitHub uygulamasını gereken depolara kurmak.
- Kurucu ortamını oluşturmak.
- Ekstra kullanımın kapalı olduğunu kontrol etmek.
- Kurucunun Supabase bağlantısını yalnız okumaya ve tek projeye sınırlamak.
- Telefon uygulamaları.
- ChatGPT'ye düzeltme görevini vermek.
- GitHub erişim anahtarını silmek.
- Kurucuyu başlatmak.

**Kurulumu başlatmak ve sürdürmek** (Bölüm 9 madde 1; D-010; Ek F): Çalışma oturumunu Claude uygulamasından bir kez açıp Ek F'deki ilk mesajı yapıştırırsın. Sonra yalnız iki yerde yazarsın: sana ait kararların cevabı ve kullanım sınırı sıfırlandıktan sonra bir "devam" mesajı. Aşama geçişlerinde senden bir şey beklenmez.

**Kurulum sırasında:**

1. **C02:** Üç çalışma ortamını oluşturmak; her biri için kurucunun verdiği tek satırlık SQL'i Supabase panelinde çalıştırmak ve çıkan token'ı o ortamın ayar alanına yapıştırmak.
2. **C04:** Kütüphane aktarımı için yalnız okuma yetkili bir GitHub anahtarı oluşturup `devos-backup`'ın gizli ayarlarına girmek. İçe alma doğrulandıktan sonra makine hesabını `agentic-os-search`'ün ortak çalışanlarından çıkarmak.
3. **C06:** Routine'leri oluşturmak; her birinden bütün connector'ları kaldırmak; yedek bütçe için API tetik anahtarını Supabase'in gizli ayarlarına girmek.
4. **C09:** Yedek rolünün bağlantı bilgilerini `devos-backup`'ın gizli ayarlarına girmek. Geri yükleme gerekirse: eski routine'leri durdurmak, yeni proje için token'ları yeniden üretip ortamlara, routine'lere ve GitHub kontrollerine girmek.
5. **C11 (B2 onaylandıysa; B2 = (1) verildi):** Gemini API anahtarını oluşturup ikinci model geçidinin gizli ayarına girmek.
6. **Gerekirse:** C00 ya da C01'de çakışan bir plugin ya da connector çıkarsa onu hesap ayarlarından kapatmak (diğer sohbetlerine etkisi sana önceden yazılır).
7. **Her zaman:** Karar listesine düşen kararları cevaplamak; yüksek etkili değişiklikleri amaç ve risk açısından kabul ya da reddetmek (teknik onay sana gelmez; PC-05).
8. **C07:** İlk işi ve ekibin bulduğu eksikleri amaç ve değer açısından değerlendirmek.

**Anahtar listesi:** Kurucu C00'da her anahtar ve token için sahibini, nerede durduğunu, yetkilerini ve iptal yolunu (değerlerini değil) tek listede tutar.

**Kurulumdan sonra:** Amaç vermek, karar vermek, kabul etmek.

---

## Sana nasıl gelinir (Ek E)

Sana Türkçe, sade, kısa, her mesajda tek konuyla ve telefonda okunur biçimde yazılır; bir teknik terim gerekiyorsa ilk geçtiği yerde bir cümleyle açıklanır. Sana yalnız sana ait kararlar gelir, her biri aynı biçimde: ne soruluyor, neden sana soruluyor, seçenekler (her biri için amaç, fayda, bedel ve alternatif), öneri ve gerekçesi, bilmen gerekenler ve cevap vermezsen ne olacağı; teknik onay sorusu gelmez ve sessizliğin onay sayılmaz. Kararların ve yapman gereken işler toplanıp tek bir GitHub issue'sunda ("Batu'dan beklenenler", #6) adım adım iletilir; anahtar ya da şifre senden sohbette istenmez ve durum her zaman Türkçe `DURUM.md` sayfasında günceldir.
