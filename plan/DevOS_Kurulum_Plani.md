# DevOS Kurulum Planı (Claude Code)

**Sürüm:** 2.1 · **Tarih:** 29 Eylül 2026 · **Durum:** Plan. Hiçbir bileşen kurulmadı; hedef ortamda hiçbir test çalıştırılmadı.

Bu sürüm 2.0'ın yerine geçer. 2.1'de değişenler:

- **Çalışma düzeni yeniden kuruldu** ("ekip ofiste, denetçi ayrı"): Roller oturum değil sorumluluk paketidir; rollerin çoğu bir çalışma oturumunun içinde alt ajan olarak çalışır. Yalnız yetki ayrılığı gerektiren işler (bağlayıcı inceleme ve kabul, kural değişikliği, sınav) ayrı ortamlarda ve ayrı anahtarlarla yapılır. Routine'ler yalnız oturum başlatmak için kullanılır. Önceki düzen, P4 ve P5'ten sorgulanmadan taşınmış bir öncüle ("her rol ayrı oturumdur") dayanıyordu ve günde 15 routine çalışması sınırına takılıyordu.
- **İki bağımsız incelemenin** (ayrı bir Claude sohbeti ve ChatGPT) kabul edilen bulguları işlendi: connector'lar üzerinden kural kapısını atlama, açık depoya ilk yazımdan önce sızıntı kontrolü, kimlik zinciri, kurtarmada eski yolların kapatılması, sınav yürütme yolu, yedek biçimi ve diğerleri.
- **Karşılaştırmalı araştırmanın** düzeltmeleri işlendi: tek yazar kuralı, parçalı iş ve yapılandırılmış devir, alt ajan görev tanımı, döngü sınırları, mekanizma varsayım envanteri, başarısızlık sınıflaması ve sessiz başarısızlık denetimi.
- **Çerçeve körlüğüne karşı mekanizma** eklendi (Bölüm 6.12).
- Batu'nun K6 ve K7 kararları işlendi.

Değerlendirme ve araştırma belgeleri: `Inceleme_Degerlendirmesi_Claude.md`, `Inceleme_Degerlendirmesi_ChatGPT.md`, `Uyandirma_ve_Kapasite_Arastirmasi.md`, `Calisma_Duzeni_Karsilastirmali_Arastirma.md` (C00'da `devos/plan/` altına alınır).
---

## 0. Belge hakkında

### 0.1 Okuyucular

- **Batu:** Bölüm 1, 3, 11 ve 12 yeterli. Bölüm 11 senden beklenen kararları, Bölüm 12 senin yapacağın işleri içerir.
- **Kurucu Claude Code oturumu:** Belgenin tamamını ve bütün ekleri okur, C00'dan başlar.

### 0.2 Statü etiketleri

Her önemli ifade şu etiketlerden birini taşır. Kullanıcı kararı, teknik öneri, doğrulanmış bilgi ve varsayım birbirine karıştırılmaz.

| Etiket | Anlamı |
|---|---|
| **[Batu kararı]** | Batu'nun açıkça verdiği karar. Değiştirilmesi Batu'nun kararını gerektirir |
| **[Öneri]** | Bu planın teknik önerisi. Gerekçesi yazılıdır; daha iyisi gösterilirse değişir. Batu'nun sessizliği bir öneriyi karara çevirmez |
| **[Doğrulandı]** | Birincil ya da güvenilir bir kaynakta okunmuş bilgi. Kaynağı ve tarihi yazılıdır. Hesapta denenmiş olmayabilir |
| **[Doğrulama bekliyor]** | Çözümü tasarlanmış, ama hedef hesapta ya da gerçek kullanımda henüz gösterilmemiş |
| **[Varsayım]** | Kanıtı olmayan, geçici olarak kabul edilen bilgi. Hangi aşamada sınanacağı yazılıdır |
| **[Açık sorun]** | Çözümü henüz bulunmamış ya da yalnız kısmen bulunmuş tasarım sorunu. Bölüm 10'da ayrıca listelenir |

### 0.3 Bu planın uyduğu ilkeler [Batu kararı]

1. Kalite kolaylık ya da ucuzluk uğruna düşürülmez. Varsayılan emek ve derinlik yüksektir; daha azı gerekçeyle yapılır.
2. Pahalı ya da karmaşık olan daha iyi sayılmaz. Aynı gereksinimi aynı kalitede karşılayan daha sade çözüm tercih edilir.
3. Ücret, farklı bir araç ya da bir kısıtın değişmesi gerekiyorsa bu Batu'ya kazancı, gerekçesi, alternatifi ve bedeliyle sunulur. Masraf ne Batu adına kabul edilir ne de ihtiyaç sessizce budanır.
4. Gereksinim sıralamak yetmez; her gereksinimi karşılayan mekanizma, parçaların birlikte çalışması, koşullar, başarısızlık hali ve sınama yolu yazılır.
5. Teknolojiden değil ihtiyaçtan başlanır. Maddi alternatifler seçimden önce karşılaştırılır.
6. Tasarlanmış ama doğrulanmamış olan ile çözümü bulunmamış olan açıkça ayrılır. Çözülmemiş bir tasarım sorunu "kurulumda sınanacak" diye çözülmüş gösterilmez.
7. Testlerin sayısı değil neyi kanıtladığı önemlidir. Her test yanlış çözümü yakalamalı, doğru çözüme izin vermeli ve iddia edilen kabiliyeti gerçekten temsil etmelidir.
8. Aşamalı çalışılır ama hedef küçültülmez. Kritik belirsizlikler, onlara bağlı büyük işlerden önce ele alınır.
9. Eksikleri bulmak planı hazırlayanın ve kurucunun sorumluluğudur; Batu'ya yalnız ona ait kararlar, gereken bilgiyle birlikte gelir.
10. Asıl ölçüt, DevOS'un SOUL'u gerçekten geliştirebilmesidir. Daha çok kayıt ve kontrol, SOUL'un ilerlediği anlamına gelmez.
11. **Çerçeve körlüğü DevOS'un ve SOUL'un en büyük tehlikesidir.** Bir tasarım bir sınıra takılıp çözüm olarak yeni mekanizmalar üretmeye başladığında, önce çerçevenin kendisi sorgulanır. Teknik kararlar, etkileri büyük olsa da, gerekçesiyle ekip tarafından verilir; Batu'ya yalnız ona ait kararlar gelir. **[Batu, 29 Eylül 2026]**
12. **Güncel platform okuması:** Planın dayandığı her platform davranışı, resmî belgenin güncel sürümünden ve tarihiyle okunur; ikincil kaynak "doğrulandı" sayılmaz. **[2.0 incelemesinden çıkan ders]**
13. **Etki kanalı envanteri:** Ajanın dünyada etki üretebildiği her kanal (veritabanı, GitHub, connector'lar, ağ, ikinci model, zamanlanmış işler) tek listede tutulur; her biri için sınır ve olumsuz test yazılır. **[2.0 incelemesinden çıkan ders]**

### 0.4 Belge ailesi

| Belge | İçerik | Kim okur |
|---|---|---|
| Bu plan (`DevOS_Kurulum_Plani.md`) | Ne kurulacak, neden, nasıl, hangi sırayla, neyle kanıtlanacak | Kurucu; Batu seçili bölümleri |
| **Ek A** (`Ek_A_Rol_Sozlesmeleri.md`) | 18 rol sözleşmesi, rol paketleri, rol hazırlama protokolü | Kurucu |
| **Ek B** (`Ek_B_Veri_Modeli.md`) | Veri modeli: kayıt aileleri, alanlar, durum geçişleri, kurallar, API fonksiyonları | Kurucu |
| **Ek C** (`Ek_C_Testler.md`) | F01–F08 ve diğer karşı örneklerin hata sınıfı düzeyindeki testleri | Kurucu |
| **Ek D** (`Ek_D_Dusunme_Protokolleri.md`) | Dokuz düşünme protokolünün `CLAUDE.md`'ye uyarlanmış metni | Kurucu |
| **Ek E** (`Ek_E_Iletisim.md`) | Batu ile iletişim kuralları | Batu ve kurucu |
| **Ek F** (`Ek_F_Baslangic_Mesaji.md`) | Kurucunun başlangıç mesajı | Batu ve kurucu |
| **Ek G** (`Ek_G_Isleyis_Kurallari.md`) | Ayrıntılı işleyiş kuralları: bağlam bayatlaması, ilişki sorgularının tamlığı, yayın kesintileri, bileşik ürünler, yeniden açma ve iptal, bozulma halleri | Kurucu |
| Değerlendirme ve araştırma belgeleri | İki bağımsız incelemenin değerlendirmesi; çalışma düzeni, uyandırma ve kapasite araştırması; karşılaştırmalı araştırma | Kurucu |
| Hazırlık planı | Kurucu başlamadan önce yapılacaklar (H0–H10) | Batu ve bu sohbet |
| ChatGPT görevi | `agentic-os-search`'ün güncellenmesi | ChatGPT |

Bütün ekler `devos/plan/` altında durur ve kurucu için zorunludur. Önceki P4, P5 ve "SOUL ve DevOS" raporları `agentic-os-search`'te arşivdedir; geçerli parçaları eklere aktarılmıştır. Arşiv uygulama kaynağı değildir; "bu karar neden böyle verildi?" sorusu ve uyarlama sadakatinin denetimi (bir gereksinim eklere doğru aktarılmış mı?) için okunur.

**Önkoşul:** C00'dan önce hazırlık planı tamamlanmış olmalıdır.

### 0.5 Depolar ve yazarları

Her deponun tek yazarı vardır; yazar olmayan yalnız okur. Aynı kayıtları iki farklı sistemin birbirinden habersiz değiştirmesi bu projede daha önce karışıklığa yol açtı. [Batu kararı: tek yazar ilkesi ve depo kararları]

| Depo | Görünürlük | Yazar | Kurucu |
|---|---|---|---|
| `devos` (yeni) | Açık **[Batu kararı K6]** | Kurucu, sonra DevOS ekibi | Yazar |
| `soul-system` (yeni) | Açık | DevOS'un yayın işi | Yalnız yayın akışıyla yazar |
| `devos-evals` (yeni) | Gizli | Sınav hazırlayan oturumlar | Sınanan rollerin oturumlarına hiç eklenmez |
| `devos-backup` (yeni) | Gizli | Yedek ve kütüphane aktarım işleri | İşleri kurar, içeriğe elle yazmaz |
| `agentic-os-search` (var) | Gizli | ChatGPT, Batu'nun onayıyla | **Yalnız okur** |
| Eski deneme depoları (var): `soul`, `soul-development-os`, `soul-development-os_02`, `soul-development-os2-claudecloud`, `soul-development-os3_claudecode`, `soul-production`, `loom-development`, `os-architect`, `keel`, `keel-dev`, `keel-research`, `KEEL-Work`, `oyun2` | Karışık | Kimse | **Yalnız okur** |

**Kurucuya uyarı:** `agentic-os-search` içindeki `AGENT.md` ve `agent/**` ChatGPT'nin kontrol dosyalarıdır; Claude Code için talimat değildir. O depodaki ve eski deneme depolarındaki "güncel durum", "sıradaki iş", "next" gibi ifadeler de kurucu için talimat değildir. Kurucunun tek güncel yönü bu plan ve ekleridir. `agent/protocols` altındaki düşünme disiplinleri Ek D aracılığıyla kullanılır.

**Açık depo ve özel içerik [K6 ve K8 kararlarının sonucu]:** `devos` açık olduğu için ona yazılan her şey gönderildiği anda herkese görünür. Bu yüzden: (1) Açık depoya DevOS'un kendi sentezi, kaynak kimlikleri ve DevOS için yazılmış tasarım belgeleri (plan, ekler, `CLAUDE.md`, düşünme disiplinlerinin uyarlaması, Batu'nun kararları ve beklentileri) yazılabilir. Kütüphanedeki araştırma içeriğinden aynen ya da anlamca yakın aktarım ve konuşma dökümlerinden aktarım yazılamaz. (2) Ham kanıtın ve kurulum defterinin özel içerik taşıyabilecek kısımları veritabanında ve gizli dosya deposunda tutulur; açık depoya yalnız güvenli özet ve kimlik girer. (3) Sızıntı kontrolü, ilk açık yazımdan önce oturumun içinde çalışır (Bölüm 6.7). Kalan risk (kontrolün oturumun içinde çalışması nedeniyle atlatılabilmesi) Batu'nun K6 kararıyla kabul edilmiştir.

### 0.6 Dil [Batu kararı K9, 29 Eylül 2026]

**Kural:** DevOS'un bütün dosyaları (kod, yorumlar, belgeler, `CLAUDE.md`, rol ve yöntem metinleri, sınavlar), veritabanı kayıtları, commit ve PR metinleri, iç iş kayıtları ve ajanlar arası bütün iletişim **İngilizcedir**. Batu ile iletişim — karar mesajları, raporlar, kullanım kılavuzu ve Batu'ya giden her metin — **Türkçedir**.

**Sonuçları:**

1. **Plan paketi:** Bu plan ve ekleri şu an Türkçedir. C00'ın ilk işi, plan paketini İngilizceye çevirmek ve çevirinin sadakatini bağımsız bir oturuma inceletmektir. Çeviri bir yeniden yazım değildir: çeviri sırasında fark edilen iyileştirmeler ayrı öneri olarak kaydedilir. İnceleme geçene kadar Türkçe metin bağlayıcıdır; geçtikten sonra İngilizce metin tek bağlayıcı metindir ve Türkçe sürümler depodan kaldırılır (Batu'daki kopya okuma amaçlıdır). Batu'ya dönük Türkçe bir özet (genel resim, Batu'nun kararları ve yapacakları) DevOS tarafından ayrıca tutulur.
2. **Batu'nun sözleri:** Batu'nun kararları, kısıtları ve beklentileri kayda hem **Türkçe aslıyla** hem **İngilizce yorumuyla** girer. Batu'ya bir karar sunulurken Türkçe metin İngilizce kayıttan üretilir ve ilgili yerlerde Batu'nun kendi Türkçe ifadesi gösterilir. Yorum ile asıl arasında anlam farkı fark edilirse bu bir bulgudur.
3. **Arama:** Kütüphanenin büyük kısmı Türkçedir; ajanlar İngilizce çalışır. Bu yüzden kütüphane aramaları gerektiğinde iki dilde yapılır ve C04'teki arama ölçüsü diller arası soruları (İngilizce soru, Türkçe kaynak) ayrıca ölçer. Çok dilli anlam modelinin önemi bu kararla artar.
4. **Karar issue'ları:** Batu'ya atanan karar issue'ları Türkçe; aynı kararın veritabanı kaydı İngilizcedir.
5. **SOUL:** SOUL'un kodu ve belgeleri de DevOS'un ürettiği dosyalar olarak İngilizcedir. SOUL'un son kullanıcılarla hangi dillerde konuşacağı ayrı bir ürün kararıdır ve SOUL gereksinim kaydına açık soru olarak girer.

---

## 1. Hedef

### 1.1 SOUL [Batu kararı]

> SOUL, kullanıcının uzmanlığının yetmediği işlerde bu açığı kapatan; işi, bilgiyi, aktörleri ve çalışma koşullarını keşfedip bir çalışma sistemi halinde birleştiren ve yöneten; kullanıcıyı yalnız onun karar vermesi gereken yerlerde, karar verebileceği kadar bilgilendirerek sürece katan; gerektiğinde kendi çalışma kapasitesini kontrollü biçimde uyarlayan bir yapıdır.

"Bilgilendirmek", ders anlatmak değildir. Kullanıcı bir amaç, tercih ya da bütçe belirlerken işin gerekleri hakkında eksik bilgiye sahip olabilir. SOUL bu kısıtları sabit girdi saymaz: işin gereğiyle çelişen bir kısıtta kaliteli seçeneği, amacını, faydasını, bedelini ve alternatifini sunar; kararı kullanıcı verir. SOUL açık kaynak olacak ve başkaları kendi hesaplarıyla kurabilecek. [Batu kararı]

### 1.2 DevOS

DevOS, SOUL'u geliştiren çalışma sistemidir. SOUL için hangi işin gerektiğini kendisi keşfeder, araştırır, tasarlar, uygular ve sınar. SOUL'un ilk gerçek işini ne Batu ne de bu plan seçer; kurulan ekip bulur.

DevOS aynı zamanda **SOUL'un ilk örneğidir**: konusu önceden belli olan bir SOUL. Bu yüzden:

1. DevOS'un bağlam, hafıza, bilgi bulma, iş takibi ve sınama katmanı atılacak bir iskele değil, SOUL çekirdeğinin ilk halidir.
2. DevOS'un SOUL'u geliştirmekteki başarısı ya da başarısızlığı, SOUL yönteminin ilk kanıtıdır.

### 1.3 Üç aşama

| Aşama | Ne oluyor? | Kim çalışıyor? |
|---|---|---|
| **A. Kurulum** | DevOS kuruluyor (C00–C12) | Kurucu Claude Code oturumu |
| **B. DevOS'un çalışması** | DevOS ekibi SOUL'u geliştiriyor | DevOS rolleri: çoğu çalışma oturumunda alt ajan olarak; bağlayıcı inceleme ve sınav ayrı ortamlarda. Oturumları routine'ler başlatır |
| **C. SOUL'un çalışması** | SOUL kullanıcıların işlerini yapıyor; başkalarının hesaplarında da | SOUL'un kendi ajanları |

Araştırma kütüphanesine erişim: **A'da** kurucu depoları doğrudan okur. **B'de** ekip aynı bilgiye, depolar açılarak değil, bilginin aktarıldığı kütüphanede arama yapılarak ulaşır; böylece arama, otorite statüsü ve gizlilik kuralları çalışır. **C'de** SOUL bu depolara bağlı değildir; SOUL'un ihtiyaç duyduğu bilgiyi DevOS, SOUL'un kendi ürününe ve kütüphanesine uygun biçimde koyar.

### 1.4 DevOS'un başarısı neyle ölçülür? [Batu kararı]

Veritabanının çalışması, rol dosyalarının bulunması ya da görevlerin aktarılması tek başına başarı değildir. DevOS şu kabiliyetleri gerçek işte gösterdiğinde başarılıdır:

1. Doğru işi keşfetmek.
2. İyi araştırmak.
3. Gerekçeli karar vermek.
4. Hatalarını sınamak ve genel kuralına kadar götürmek.
5. Uzun ve bileşik işleri bütünlüğünü kaybetmeden sürdürmek.
6. Araştırma birikimini gerçekten kullanmak.
7. Bunları Batu'nun mesaj taşımasına ya da teknik bakım yapmasına ihtiyaç duymadan yapmak.

Bölüm 4 her kabiliyetin mekanizmasını, Bölüm 8 bunların nasıl sınanacağını, Bölüm 10 hangilerinin henüz tam çözülmediğini anlatır.

---

## 2. Kabul edilmiş kriterler

Bu 34 madde planın sözleşmesidir. Her aşama hangi maddeleri karşıladığını gösterir (Bölüm 9).

**SOUL (ürün)**

1. **Tanım:** Bölüm 1.1. [Batu kararı]
2. **Açık kaynak:** Başkaları kendi hesaplarıyla kurabilir; SOUL, Batu'nun altyapısına bağımlı değildir. [Batu kararı]
3. **Kullanıcı verisi:** Kullanıcının kendi alanında kalır; ortak öğrenmeye özel bilgi sızmaz. [Batu kararı]
4. **Sağlayıcı bağımsızlığı:** SOUL, Claude dışındaki bir modelle de çalışabilecek biçimde tasarlanır ve bu gerçek bir sınamayla gösterilir (C11). Gösterilene kadar iddia edilmez. [Batu kararı]

**DevOS (çalışma sistemi)**

5. **Bulunabilirlik:** Her bilginin katalog kaydı ve üç tür araması vardır: kelime, anlam, ilişki.
6. **Farkındalık:** Her ajan işe o anki durum özetiyle başlar.
7. **Kaynağa bağlılık:** Her iddia kaynaklıdır; çelişkiler işaretlidir; inceleme farklı bir bilgi görünümüyle yapılır.
8. **Makine kuralları:** Kuralları ajan değil sistem uygular.
9. **Sensiz akış:** Roller Batu olmadan birbirine bağlanır; katkılar gerçekten kullanılır.
10. **Kesinti:** Yarım iş kayıttan devam eder; eski yetki geri gelmez.
11. **Ölçek:** Binlerce dosyada, her şeyi okumadan çalışır.
12. **Çıkmaz yollar:** Başarısız denemedeki bilgi korunur, başarısızlık nedeni kaydedilir.
13. **Esnek roller:** Yeni rol kurulabilir, yeterliği sınanır, gerekmediğinde bırakılır.
14. **Kullanıcı modeli:** Batu'nun neyi bildiği ve neye onun karar vermesi gerektiği takip edilir.
15. **Emek:** Güvenceler her işte tamdır. Emek derinliği varsayılan olarak yüksektir; azaltma gerekçeli ve başka bir rolün onayıyladır. Kullanıcı uzmanlığı araştırmayı kısaltabilir, ama değişebilir bilgilerin doğrulanmasını, alternatif taramasını ve yüksek etkili kararlarda dış kaynak araştırmasını kaldırmaz.
16. **Kısıtlar sorgulanabilir:** İşin gereğiyle çelişen kısıtta kaliteli seçenek, amacı, faydası, bedeli ve alternatifi sunulur.
17. **Güncel araştırma:** Model bilgisine körü körüne güvenilmez; değişebilir bilgi doğrulanır.
18. **Amaçtan kopmama:** Ana hedef düzenli denetlenir; her yeni süreç parçası SOUL'un ilerlemesine hizmet ettiğini gösterir.
19. **Öğrenme:** Dersler kaydedilir, uygun olan seçilir; yöntem değişiklikleri eski iyi davranışı bozmadan sınanır.
20. **Test verisi:** Kişisel ve iş verisi testlerde hiç kullanılmaz; yalnız sahte veri. DevOS'un kendi araştırma kütüphanesi ölçümlerde kullanılabilir. **[Batu kararı K7, 29 Eylül 2026]**
28. **Hata ile yetenek eksikliği ayrılır:** Her hata belirti, hata sınıfı ya da yetenek eksikliği olarak sınıflandırılır; onarım ve regresyon testi bulunan en genel düzeyde yapılır.
29. **Dış kaynak birikimi zorunludur:** Yüksek etkili kararlarda başka alanlardaki bilinen çözümler ve karşı örnekler araştırılır.
30. **Ölçüm bağımsızdır:** Yeterlik, sınanan rolün göremediği sınavlarla ölçülür; hiçbir rol kendi değişikliğini onaylayamaz.
31. **Özel kaynak korunur:** Gizli kütüphanedeki içerik açık depolara taşınmaz.
32. **Ortak düşünme standardı ve rol hazırlama:** Her rol, uzmanlığı ne olursa olsun aynı ortak düşünme tabanını taşır. Yeni bir rol yalnız bir ad ve görev cümlesiyle değil; bilgi haritası, yöntemler, araçlar, bilinen hata sınıfları, örnekler ve gizli sınavla hazırlanır; bu hazırlık her oturum açılışında, katkı talebinde ve kesintiden dönüşte yeniden kurulur. İşin küçüklüğü uzman değerlendirmesini atlama gerekçesi değildir; değerlendirme sonucunda az iş yapılabilir. **[Batu kararı, 29 Eylül 2026]**
33. **SOUL'daki ajan kalitesi bir alt sınırdır, tavan değil:** SOUL'un kendi ajanları ve SOUL'un bir iş için oluşturduğu ya da sonradan eklediği ajanlar en az DevOS rolleri kadar yüksek bir düşünme standardı taşır. SOUL'un ajanları nasıl hazırlayacağı ve bu kaliteyi nasıl koruyacağı, DevOS'un kendi yönteminin kopyalanmasıyla değil, DevOS'un araştırma, tasarım ve sınama işiyle bulunur; DevOS'un bugünkü rol hazırlama yöntemi bu işin çıkış noktası ve karşılaştırma ölçütüdür. SOUL için daha iyi bir yöntem bulunursa bunun daha iyi olduğu aynı tür gizli sınavlarla gösterilir ve DevOS kendi rollerini de bu yöntemle iyileştirmeyi değerlendirir. **[Batu kararı, 29 Eylül 2026]**
34. **Çerçeve körlüğüne karşı mekanizma:** DevOS, dayandığı öncülleri açıkça yazar, bir tasarım bir sınıra takıldığında önce çerçeveyi sorgular ve büyük tasarım kararlarında mevcut tasarımı görmeyen bağımsız bir karşı tasarımla karşılaştırma yapar (Bölüm 6.12). Bu aynı zamanda SOUL'a aktarılacak bir gereksinimdir. **[Batu, 29 Eylül 2026]**

**Ortam ve Batu'nun rolü** [Batu kararı]

21. **Rol:** Amaç, karar, kabul. Mesaj taşımak ve bakım yapmak yok.
22. **Bilgisayar kapalıyken çalışır.**
23. **Telefon:** Claude uygulaması ve kesin ulaşan bir yedek kanal; kararlar tek listede, sade Türkçe, kısa seçenekli.
24. **Kendi bakımı:** Yedek, izleme ve denetim düzenli çalışır; çözülemeyen karar listesine düşer.

**Altyapı**

25. **Claude:** Max 200 $ planı. Ekstra kullanım kapalı. Ortam ayarlarında Anthropic API anahtarı yok. [Batu kararı]
26. **Canlı durum:** Batu'nun kişisel Supabase hesabı. Ajanlar kısıtlı yetkiyle, gizli anahtar özelliği üzerinden erişir; Supabase MCP çalışan sistemde kullanılmaz. [Batu kararı: Supabase; plan seviyesi Bölüm 11'de yeniden karara sunuldu]
27. **GitHub:** Bölüm 0.5'teki depolar. Dal koruması yöneticileri de kapsar; her PR'da otomatik kontroller; gizli bilgi taraması açık; tetikler dış hesaplardan gelen olaylara cevap vermez. [Batu kararı: depolar; ayrıntılar Öneri]

(21–27 numaraları önceki sürümlerle uyum için korunmuştur.)

---

## 3. Genel resim (Batu için)

DevOS'un parçaları:

| Parça | Ne yapar? | Benzetme |
|---|---|---|
| **Claude Code cloud** | Ajanların düşündüğü, araştırdığı, yazdığı yer | Ofis |
| **Çalışma oturumu** | Günde birkaç kez açılır; koordinatör ajan işin gerektirdiği rolleri alt ajan olarak çalıştırır; roller arası devir oturumun içinde olur | Ofiste çalışan ekip |
| **Denetim ve sınav oturumları** | Ayrı anahtarlarla bağlayıcı incelemeyi, kabulü, kural değişikliği incelemesini ve sınavları yapar | Dışarıdan gelen denetçi |
| **Routines** | Hiçbir oturum açık değilken oturum başlatır; günde birkaç kez | Sabah açılan kapı |
| **Supabase** | Canlı iş kayıtları, kurallar, arama kütüphanesi; kimin ne yapabileceğine karar verir | Kayıt defteri, kapı görevlisi ve kütüphane |
| **GitHub** | Üretilen her şey; her değişiklik kontrollerden geçmeden ana ürüne girmez | Arşiv ve kalite kontrol |
| **Karar kanalı** | Senden karar gerektiğinde telefonuna bildirim gelir; cevabını güvenli bir yoldan verirsin | Senin masan |

**Bir günün akışı:** Sabah bir çalışma oturumu açılır → koordinatör durum özetini okur, hazır işleri seçer → işin gerektirdiği rolleri (keşif, araştırma, tasarım, üretim) kendi paketleriyle alt ajan olarak çalıştırır; araştırma ve inceleme paralel yürür, bir ürünü aynı anda tek bir ajan yazar → sonuçlar kayda geçer, değişiklikler PR olarak gönderilir → denetim oturumu gelir, bağlayıcı incelemeyi ve kabulü yapar → senden karar gerekiyorsa telefonuna gelir → cevabın bir sonraki oturumda işlenir.

**Senin görmediğin ama sürekli çalışan işler:** yedekleme, kütüphanenin güncel tutulması, takılan işlerin tespiti, kullanım takibi, tekrarlayan hata örüntülerinin taranması, amaç denetimi, sessiz başarısızlık örneklemesi.

---
## 4. İhtiyaçtan çözüme: kabiliyetler ve mekanizmaları

Her kabiliyet için: hangi ihtiyacı karşıladığı, hangi mekanizmayla karşılandığı, gereken koşullar, başarısızlık halinde ne olacağı, nasıl sınanacağı ve statüsü. Ayrıntılı kurallar Ek B (veri modeli), Ek D (düşünme disiplinleri) ve Ek G'dedir.

### K-1 Doğru işi keşfetmek

**İhtiyaç:** Bir amaçtan, onu gerçekleştirmek için gereken işe gitmek. Açıkça söylenmemiş ama maddi önkoşulları bulmak; yöntem değişince ortadan kalkan önkoşulları evrensel gereklilik sanmamak; gereksiz hazırlık yığmamak; ne zaman durulacağını bilmek.

**Mekanizma:**

1. **İhtiyaç kaydı** (`Need` / `Inquiry`, Ek B): Her ihtiyaç şunları taşır: bağlı olduğu üst amaç, beklenen değer, hedefin mi yoksa seçilen yöntemin mi gereği olduğu, destekleyen ve karşı kanıt, açık varsayımlar, alternatif yollar, başlanabilirlik ve sonucun döneceği yer (`return_to`).
2. **Keşif protokolü** (DR01 rolü, `methods/rpd.md`): (a) Ham talep ile onun güncel yorumu yan yana yazılır. (b) **Alternatif araştırması:** Hedefe giden farklı yöntemler aranır ve her yöntemin önkoşulları ayrı çıkarılır. Araştırmadan sonra tek uygulanabilir yol kalırsa bu gerekçesiyle yazılır; seçenek alanı henüz bilinmiyorsa iş "açık keşif" durumunda kalır. Sabit sayıda alternatif üretmek zorunlu değildir; uydurma alternatif üretmek hatadır. (c) **Kapsama taraması:** `agentic-os-search`'teki Foundation araştırmasının çalışma sistemi alanları (iş, bilgi, aktörler, ortam ve bunların bileşimleri) sistemli bir soru listesine çevrilir: "Bu alanda bu iş için eksik bir koşul var mı?" Liste C05'te bir kez türetilir ve sürümlenir. (d) **Geçmiş taraması:** Aynı yol daha önce denendi mi? Çıkmaz yol kayıtları (`DeadEnd`) ve eski deneme depoları aranır. (e) Önkoşullar üç sınıfa ayrılır: hedefin gereği, seçilen yöntemin gereği, yalnız faydalı. (f) Başlanabilir en dar bilgi edinme işi belirlenir.
3. **Gereksiz önkoşul freni:** Her önkoşul "hangi karar ya da eylem bu olmadan yanlış olur?" sorusunu cevaplamak zorundadır. Cevaplayamayan önkoşul reddedilir. Veritabanı bir **biçim kapısı** uygular: cevap alanı boş bir önkoşul kaydı kabul edilmez. Veritabanı cevabın anlamlı olduğunu denetleyemez; içerik örneklem incelemesiyle ve denetim oturumunda değerlendirilir.
4. **Çerçeve incelemesi:** Keşfi yapmamış, temiz bağlamlı bir inceleme (bağlayıcı olmayan işlerde çalışma oturumunda bir alt ajan; yüksek etkili işlerde denetim oturumu) keşif sonucunu, ham talebi ve kullanılmayan alternatifleri görür. Sorusu: "Problem yanlış mı çerçevelendi? Bu iş, doğru olduğu için mi, yoksa kolay ölçüldüğü için mi seçildi?"
5. **Durma kuralı:** Kalan belirsizlik şu anki yetkili eylemi maddi biçimde değiştirmiyorsa ilerlenir. Bütçenin ya da bağlamın bitmesi "hazır olundu" demek değildir.

**Koşullar:** Kütüphanenin içe alınmış olması (C04); rollerin ve yöntemlerin kurulmuş olması (C05).

**Başarısızlık halinde:** C07 bilişsel kapısı başarısız olursa Bölüm 6.11'deki sistem incelemesi yapılır. "Bir ajan daha ekleyelim" ya da "promptu uzatalım" düzeltme sayılmaz.

**Sınama:** Gizli sınav setinde iki tür görev: (1) içinde açıkça söylenmemiş maddi bir önkoşul gizlenmiş görevler (bulunmalı), (2) ek önkoşul gerektirmeyen görevler (gereksiz hazırlık üretilmemeli). İkisi birlikte ölçülür; yalnız birincisi ölçülürse her şeye önkoşul ekleyen bir sistem başarılı görünür. Ayrıca C07'deki gerçek görev.

**Statü:** Mekanizma **[Öneri]**. Kapsama taramasının gerçekten bilinmeyen eksikleri yakalayıp yakalamadığı **[Açık sorun: U-1]**.

### K-2 İyi araştırmak

**İhtiyaç:** Belirsizliği uygun kaynaklarla azaltmak; güncel olmayan bilgiyi, yalnız ikincil kaynağa dayanmayı ve niteleyici kaybını önlemek; sonucun gerçekten bir kararda kullanılması.

**Mekanizma** (DR16 rolü, Ek D'deki kaynak-özet ve varsayım disiplinleri):

1. **Soru çerçevesi:** Araştırma hangi kararı etkileyecek, neyi bilmek o kararı değiştirir? Bunu yazmayan araştırma işi açılamaz.
2. **Kaynak sırası:** Önce gizli kütüphane (Foundation, aday çalışmalar, önceki denemeler); sonra birincil ve güncel kaynaklar (resmî belgeler, standartlar, kaynak kod); ikincil kaynaklar yalnız birincilin olmadığı yerde ve öyle işaretlenerek.
3. **Güncellik kuralı:** Zamanla değişebilecek bilgi (ürün özelliği, fiyat, sınır, sürüm) ancak tarihli ve birincil kaynakla kayda girer.
4. **Karşı kanıt adımı:** Her bulgu için karşı kanıt aranır ve aramanın sonucu yazılır ("bulunamadı" da bir sonuçtur).
5. **Dış alan araştırması:** Yüksek etkili kararlarda başka alanlardaki bilinen çözümler aranır (kriter 29); uygulanabilirlikleri ayrıca değerlendirilir, popüler oldukları için benimsenmez.
6. **Çıktı biçimi** (`Finding`, Ek B): iddia, kaynak kimliği ve pasajı, niteleyiciler ("yalnız şu koşulda"), güven düzeyi, açık sorular.
7. **Tüketim kaydı:** Araştırmayı isteyen taraf, sonucu nasıl kullandığını (`UseReceipt`) yazar: kullanıldı, koşullu kullanıldı, kullanılmadı (neden), yeni soru açtı.
8. **Araştırma incelemesi:** Ayrı bir oturum bulguları kaynağına dönerek kontrol eder; özellikle niteleyici kaybını ve kaynağın gerçekten iddiayı destekleyip desteklemediğini.

**Sınama:** Gizli sınav setinde bilinçli tuzaklar: eskimiş bilgi, düşürülmüş niteleyici, birbiriyle çelişen iki kaynak, yalnız ikincil kaynakla desteklenen iddia. Her tuzağın yakalanma oranı ve doğru bulguların gereksiz reddedilmemesi birlikte ölçülür. Gerçek kullanımda (C07) araştırmanın bir kararı görünür biçimde değiştirmesi, sınırlaması ya da gerekçelendirmesi.

**Statü:** Mekanizma **[Öneri]**. Araştırma kalitesini genel olarak ölçen otomatik bir ölçüt yok **[Açık sorun: U-2]**.

### K-3 Gerekçeli karar vermek

**İhtiyaç:** Kararların alternatifleri tartılarak, varsayımları açık, geri alınabilirliği bilinerek verilmesi; aynı tartışmanın yeni bilgi olmadan tekrar açılmaması; yeni bilginin eski kararı koruma içgüdüsüyle dışlanmaması.

**Mekanizma:**

1. **Karar kaydı** (`Decision`, Ek B). Üç sınıf: rutin, yüksek etkili, Batu'ya ait.
2. **Yüksek etkili kararlar için biçim kapısı:** Alternatif araştırmasının sonucu (karşılaştırılan seçenekler ya da tek uygulanabilir yol kaldıysa gerekçesi), karşılaştırma ölçütleri, kanıt bağlantıları, açık varsayımlar, geri alınabilirlik değerlendirmesi ve yeniden açma koşulları girilmeden karar "kabul" durumuna geçemez. Alanların içeriğinin kalitesi denetim oturumunda değerlendirilir.
3. **Karar öncesi geri çağırma:** Yeni bir karar açılmadan önce ilgili eski kararlar aranır. Eski karar yalnız yeni maddi bilgiyle ya da değişen hedefle yeniden açılır.
4. **Karar incelemesi:** Yüksek etkili kararlar denetim ortamında, kararı hazırlamayan bir oturumca incelenir.
5. **Batu'ya ait kararlar:** Bölüm 4 K-11'deki karar kanalı ve Ek E biçimiyle gelir.

**Sınama:** Veritabanı kuralı testleri: eksik alanlı yüksek etkili karar reddedilir, eksiksiz karar kabul edilir; kural bilerek kaldırıldığında test başarısız olur (Bölüm 8). Gizli sınavda: ilk bakışta çekici görünen seçeneğin daha kötü olduğu bir karar görevi.

**Statü:** **[Öneri]**; kuralın veritabanında çalışması **[Doğrulama bekliyor: C02]**.

### K-4 Hataları sınamak ve genel kuralına götürmek

**İhtiyaç:** Hatayı görünen yerinden onarıp bırakmamak; tek seferlik hata ile tekrarlayan yetenek eksikliğini ayırmak; testlerin gerçekten yanlışı yakalaması.

**Mekanizma:**

1. **Sınama tasarımı** (DR04): Her test bir iddiaya bağlıdır ve iki kontrol taşır: yanlış çözümü yakalayan olumsuz kontrol ve doğru çözüme izin veren olumlu kontrol (Bölüm 8).
2. **Kusur sınıflandırması** (kriter 28): belirti, hata sınıfı, yetenek eksikliği. Hata sınıfında genel kural açıkça yazılır ve regresyon testi sınıf düzeyinde kurulur.
3. **Sistem incelemesi:** Nedeni aranırken önce sistem incelenir: model mi, bağlam mı, kaynak mı, araç mı, rol tanımı mı, yöntem mi, iş dağılımı mı, doğrulama mı? "Ajan hatası" hükmü bu inceleme yapılmadan verilmez.
4. **Bağımsız inceleme:** Bağlayıcı hükümler denetim ortamında, farklı bilgi görünümüyle çalışan bir oturumca verilir. Aynı modelin aynı öncüllerle tekrar bakması bağımsız doğrulama sayılmaz. Doğrulayıcı aynı eylemde onarım yapmaz; onarım ayrı bir iştir.
5. **Tek olaydan aday:** Tek bir güçlü olay yetenek eksikliği **adayı** olarak kaydedilebilir. Kesinleşmesi olay sayısıyla değil, yeniden üretim, nedensel ayrım ve karşı örnekle olur.
6. **Başarısızlık sınıflaması:** Her olay ayrıca çoklu ajan başarısızlık sınıflarından birine bağlanır: tanım sorunu, ajanlar arası uyumsuzluk, doğrulama eksikliği (Bölüm 6.11).

**Sınama:** Veritabanı kurallarında bozma testi (her kural bilerek bozulur, ilgili test başarısız olmalı). Academy notundaki "sistemik hata genelleme" sınavı: farklı soyutlama düzeylerinde anlatılmış hatalar verilir; doğrudan neden, sistem nedeni, ortak kural ve belirti onarımı ile sınıf onarımı ayrımı ölçülür.

**Statü:** **[Öneri]**. Genellemenin kalitesi **[Açık sorun: U-2]** kapsamında.

### K-5 Uzun ve bileşik işleri bütünlüğüyle sürdürmek

**İhtiyaç:** Parçalar tek tek iyi olsa da bütünün yanlış kalmaması; tasarım değişince ürünün de değişmiş sanılmaması; uzun sürede amacın kaybolmaması.

**Mekanizma:**

1. **Üç hal ayrı tutulur** (`Assembly`, Ek B): tasarım hali (niyet), çalışma hali (gerçekleşmiş birleşim), teslim hali (kabul edilmiş ürün). Birinin değişmesi diğerinin değiştiği anlamına gelmez.
2. **Tam kimlikli anlık görüntü:** Her inceleme, hangi parçanın hangi sürümünün incelendiğini kaydeder; eski bir incelemenin sonucu yeni sürüme sessizce taşınmaz.
3. **İki ayrı okuma:** Tasarımı bilen inceleme (uygulama tasarıma uyuyor mu) ile yalnız ürünü okuyan inceleme (okur ürünün kendisinden ne görüyor). İkisi tek puana indirgenmez.
4. **Etki analizi:** İlişki sorguları etkilenebilecek parçaları bulur, ama kayıtlı olmayan anlam ilişkilerini bulamaz. Bu yüzden büyük değişikliklerde etkilenen parçalar ayrıca okunur (Ek G).
5. **Amaç denetimi:** Düzenli aralıklarla açık işlerin ana hedefle bağı denetlenir; bağı kopmuş işler işaretlenir.

**Sınama:** C11'deki uzun senaryo; gizli sınavda tasarım değiştiği halde parçaları eski kalan bir ürün.

**Statü:** **[Öneri]**. Bütün ürünün kalitesini değerlendirme **[Açık sorun: U-2]** kapsamında.

### K-6 Araştırma birikimini gerçekten kullanmak

**İhtiyaç:** Yaklaşık 2.300 dosyalık araştırma kütüphanesi ve eski denemeler içinde doğru bilgiyi, her şeyi okumadan bulmak; bilginin statüsünü (temel, aday, tarihsel, keşif) bilmek; bulunan bilginin gerçekten kullanılması.

**Mekanizma:**

1. **İçe alma:** Gizli `devos-backup` deposundaki zamanlanmış bir iş, `agentic-os-search`'ü salt okunur anahtarla okur ve değişen dosyaları parçalara bölerek Supabase'e aktarır. Eski deneme depoları (bütün dallarıyla) C04'te bir kez aktarılır. Kaynak depolara hiçbir şey yazılmaz. İş gizli bir depoda çalışır, çünkü açık depolardaki iş kayıtları herkese görünür.
2. **Katalog:** Her parça bir katalog kaydı alır: kaynak dosya ve sürüm, otorite statüsü (Bölüm 6.6), gizlilik sınıfı, dil.
3. **Üç arama:** (a) **Kelime araması:** PostgreSQL tam metin arama; Türkçe için Türkçe kök ayırıcı, İngilizce için İngilizce, teknik terimler için dile bağlı olmayan yapılandırma. (b) **Anlam araması:** Bölüm 5.4'te seçilen çok dilli açık modelle üretilen vektörler (pgvector). (c) **İlişki sorgusu:** Kayıtlar arası türlendirilmiş bağlar. Sonuçta hangi yoldan bulunduğu ve kaynağın statüsü görünür.
4. **"Nerede bulurum" rehberi:** Katalogdan otomatik üretilir: hangi soru türü hangi kayıt ailesinde, hangi aramayla cevaplanır.
5. **Bağlam paketi:** Bilgiyi kullanacak taraf zorunlu ihtiyaçlarını yazar (`ContextRequest`); paketi hazırlayan bu listeyi kısaltamaz; her ihtiyaç kaynak ve pasajla karşılanır (`ContextPackage`); oturuma gerçekte ne gittiği kaydedilir (`DispatchReceipt`). Bayatlama kuralları Ek G'dedir.
6. **Bilinmeyen ihtiyaç kontrolü:** Her pakete iş türüne göre "gözden kaçmış olabilecekler" listesi ve üreticinin görmediği açıdan bir eksiklik taraması eklenir.
7. **Kaynak gövdesine dönüş:** Arama sonucu kaynağın kendisi değildir. `devos_api.read_source(kaynak, sürüm, aralık)` ile kaynağın tam gövdesi ya da istenen aralığı okunabilir (Ek D, D5). Depolar B aşamasında doğrudan açılmaz; bu fonksiyon onların yerini tutar.
8. **Rol bilgi haritaları:** Her rolün paketinde, alanıyla ilgili kütüphane bölümleri ve "ne zaman bakılır" ipuçları (Ek A 3.2).
9. **Kullanım ölçüsü:** Kütüphaneden gelen bilginin bir kararı değiştirdiği, sınırladığı ya da gerekçelendirdiği durumlar raporlanır. Atıf sayısı ölçü değildir.

**Sınama:** **Arama ölçüsü:** Ayrı bir oturum, gerçek kütüphaneden en az 50 Türkçe ve İngilizce soru ile her birinin doğru kaynaklarını hazırlar; bu liste gizli tutulur. Liste ikiye ayrılır: **ayar soruları** (model, parça boyutu ve birleşim ayarının seçimi için) ve **son değerlendirme soruları** (seçim bittikten sonra bir kez kullanılır; seçimi etkilemez). Kelime, anlam ve birleşik arama ilk 10 sonuçta doğru kaynağın bulunma oranıyla ölçülür. Başarı eşiği ölçümden önce yazılır. Ayar sorularındaki sonuç seçim kanıtıdır; kabul son değerlendirme sorularına göre verilir. Ayrıca niteleyicisi düşürülmüş özet testi ve eksik paketin reddi.

**Statü:** Mekanizma **[Öneri]**. Anlam modeli ve ayarı **[Doğrulama bekliyor: C04 ölçümü]**. Bir paketin anlamca yeterli olup olmadığının otomatik ölçümü **[Açık sorun: U-4]**.

### K-7 Sensiz akış

**İhtiyaç:** Roller arası talep ve cevabın Batu mesaj taşımadan akması; bilgisayar kapalıyken işin sürmesi; katkıların gerçekten kullanılması; bütün bunların günde 15 routine çalışması sınırı altında ve kaliteden taviz vermeden yapılması.

**Öncül denetimi:** 2.0'daki düzen, "her rol ayrı bir oturumdur ve her devir sistemin kendini yeniden uyandırmasını gerektirir" öncülüne dayanıyordu. Bu öncül P4 ve P5'in süreç tasarımından sorgulanmadan taşınmıştı ve routine sınırına takıldı. Rol bir sorumluluk ve bir pakettir; oturum bir çalışma yeridir. Bağımsızlığın iki türü ayrılır: **düşünme bağımsızlığı** (temiz bağlam, farklı bilgi görünümü, farklı talimat) alt ajanlarla sağlanabilir; **yetki bağımsızlığı** (kendi değişikliğini onaylayamama, sınav cevaplarını görememe, kontrol kurallarını değiştirememe) veritabanının doğrulayabildiği ayrı bir kimlik ister. Ayrıntı: `Uyandirma_ve_Kapasite_Arastirmasi.md`.

**Mekanizma:**

1. **Üç ortam:** Çalışma, denetim ve sınav (Bölüm 6.3). Routine'ler yalnız bu ortamlarda oturum başlatır; roller arası devir için kullanılmaz (Bölüm 6.4).
2. **Çalışma oturumu:** Koordinatör ajan (DR06-G ve DR06-Y) durum özetini okur, hazır işleri seçer ve işin gerektirdiği rolleri kendi paketleriyle alt ajan olarak başlatır (Bölüm 6.5). Roller arası talep ve katkı oturumun içinde dakikalar sürer; her katkı ve kullanımı veritabanına yazılır.
3. **Tek yazar kuralı:** Paralel alt ajanlar yalnız okuma, araştırma, analiz ve inceleme yapar. Bir ürüne aynı anda tek bir yazar yazar. Gerçekten bağımsız ürünler paralel yazılabilir, ancak ortak kararlar önce açıkça yazılmış olmalıdır. Birleştirme tek bir sırada yapılır.
4. **Parçalı iş ve yapılandırılmış devir:** Bir oturum işi parçalara böler; her parça temiz bağlamlı bir alt ajana ya da bir sonraki oturuma yapılandırılmış devir kaydıyla geçer. Uzun bir oturumun bağlam sıkıştırmasına güvenilmez.
5. **Denetim oturumu:** Bağlayıcı hükümleri, kabulleri ve yüksek etkili değişikliklerin incelemesini yapar. Çalışma oturumlarının sonrasına zamanlanır.
6. **Üstlenme ve süre:** Üstlenilen işin süresi vardır; oturum yaşadığını düzenli bildirir. Süre dolarsa iş yeniden atanır; eski oturumun geç gelen sonucu aday kanıt olarak saklanır.
7. **Döngü sınırları:** Her iş döngüsünün bir üst sınırı, bir emek bütçesi ve "ilerleme yok" tespiti vardır. Tetiklenince iş durur, nedeni kayda geçer ve koordinatör ya da Batu'ya ait kararsa Batu bilgilendirilir.
8. **Kilitlenme tespiti:** Birbirini bekleyen işler zinciri düzenli taranır.
9. **Kullanım takibi:** Routine çalışmaları, oturum süreleri ve kullanım payı kaydedilir; kapasite yetmezse kalite değil hız düşer ve bu Batu'ya görünür olur.

**Koşullar:** Routines **[Doğrulandı: code.claude.com/docs/en/routines ve Anthropic duyurusu, Eylül 2026]**: Max'te günde 15 çalışma; tek seferlik zamanlanmış çalışmalar sınıra sayılmıyor ama bulut oturumunun içinden oluşturulamıyor; hesaptaki bütün connector'lar varsayılan olarak ekleniyor; GitHub bağlantısı 72 saatten uzun koparsa routine kendini kapatıyor; araştırma önizlemesi. Bir bulut oturumunun kuyruk işleyerek ne kadar süre çalışabildiği **[Doğrulama bekliyor: C01]**.

**Başarısızlık halinde:** Oturumlar beklenenden kısa çalışırsa yedek routine bütçesinden ek çalışma oturumu açılır. Kapasite yine yetmezse seçenekler bedelleriyle Batu'ya gelir (U-5).

**Sınama:** C06: A → B → A zinciri Batu'dan mesaj almadan tamamlanır; oturum işin ortasında kesilir, bir sonraki oturum doğru yerden devam eder; aynı katkı iki kez gelir, bir kez tüketilir; iki paralel alt ajan aynı ürüne yazmaya çalışır, ikincisi reddedilir; "ilerleme yok" durumu tespit edilir.

**Statü:** **[Öneri]**; oturum süresi ve alt ajan davranışı **[Doğrulama bekliyor: C01, C06]**.

### K-8 Kesinti ve kurtarma

**İhtiyaç:** Yarım işin kayıttan devam etmesi; tamamlanmış işin ya da dış etkinin tekrarlanmaması; yedekten dönüşte geri alınmış bir yetkinin ya da eski sistemin etki üretmemesi.

**Mekanizma:**

1. **İşlem kimliği:** Her dış etki tam niyetiyle kayda geçer; aynı kimlikle farklı niyet çatışma olarak reddedilir (F01).
2. **Gözlem geçmişi:** "Uygulandı" gözlemi sonraki "bilinmiyor" gözlemiyle silinmez (F07).
3. **Oturum kapanış disiplini ve yapılandırılmış devir:** Bölüm 6.5.
4. **Yedek:** Bölüm 5.7.
5. **Geri yükleme:** (a) Eski projedeki bütün routine'ler durdurulur ve eski ortam belirteçleri iptal edilir. (b) Yedek yeni bir Supabase projesine yüklenir. (c) Geri yüklenen veritabanındaki bütün aktif üstlenmeler iptal edilir; yetki dönemi artırılır. (d) Ortamlar, routine'ler ve GitHub kontrolleri yeni projeye yeniden bağlanır (Batu'nun adımları Bölüm 12'de). (e) Yayın denetimi güncel yetkiyi yeni projeden okur; eski bir oturumun açtığı PR bu denetimden geçemez. (f) Açık dış etkiler GitHub'daki gerçek durumla karşılaştırılır. (g) Sistem kademeli açılır: önce okuma, sonra aday üretimi, en son yayın.

**Sınama:** C09 tatbikatı: eski sistem erişilebilir bırakılarak `main`'e etki denemesi reddedilir; yeni sistemde doğru iş ilerler; en az bir ortam gerçekten yeni projeye yeniden bağlanır.

**Statü:** **[Öneri]**; **[Doğrulama bekliyor: C09]**.

### K-9 Güven sınırları ve gizlilik

**İhtiyaç:** Kuralların aşılamaz olması; ajanın yetkisinin işi kadar olması; özel içeriğin açık depolara sızmaması; dışarıdan gelen içeriğin talimat olarak işlenmemesi.

**Mekanizma:**

1. **Kural kapısı:** Ajanlar veritabanına yalnız `devos_api` fonksiyonları üzerinden erişir; tablolara doğrudan yazamaz.
2. **Kimlik zinciri:** (a) Her ortamın bir **ortam belirteci** vardır; veritabanı rol sınıfını buradan çıkarır. (b) Bir işi üstlenen oturuma yalnız ona dönen tek seferlik bir **üstlenme belirteci** verilir; o işle ilgili her etki bu belirteci ister. Aynı ortamdaki başka bir oturum başkasının üstlenmesiyle işlem yapamaz. (c) Oturum kimliği ve rol adı beyana dayanır ve öyle etiketlenir; yetki kararı bunlara dayanmaz. (d) Oturum içindeki alt ajanlar aynı kimliği paylaşır; yetki ayrılığı gerektiren hiçbir iş oturum içinde yapılmaz.
3. **Anahtar kuralı:** Ajan ortamlarında Supabase'in gizli (servis) anahtarı hiçbir zaman bulunmaz; bu anahtar erişim kurallarını atlar. Ortamlara yalnız herkese açık anahtar ve ortam belirteci verilir (Bölüm 6.3).
4. **Etki kanalı envanteri:** Veritabanı, GitHub, connector'lar, ağ, ikinci model ve zamanlanmış işler tek listede; her birinin sınırı ve olumsuz testi var. **Connector'lar:** Hesaptaki connector'lar routine'lere varsayılan olarak ekleniyor ve yazma dahil izinsiz kullanılabiliyor **[Doğrulandı: routines belgesi]**. Bu yüzden (a) her routine'den bütün connector'lar çıkarılır; (b) depodaki izin kuralları connector araçlarının çağrılmasını engeller. İki katman C01 ve C03'te sınanır.
5. **Açık depoya yazım:** Her gönderimden, PR'dan ve issue ya da yorum yazımından önce oturumun içinde koda dayalı bir sızıntı kontrolü çalışır (Claude Code kancası ve git'in gönderim öncesi kancası). PR üzerindeki kontrol ikinci katmandır. Kalan risk Bölüm 0.5'te.
6. **Türetilmiş içerik:** Özel kaynaktan öğrenmek ile özel içeriği açıklamak ayrıdır. Açık depoya DevOS'un kendi sentezi, kaynak kimlikleri ve DevOS'un tasarım belgeleri girer; kütüphanedeki araştırma içeriğinden aynen ya da anlamca yakın aktarım ve konuşma dökümlerinden aktarım girmez (K8).
7. Tek yazar ilkesi (Bölüm 0.5).
8. Açık depolarda dışarıdan açılan issue ve PR'lar hiçbir routine'i tetiklemez; dış içerik ajanlar için yalnız veridir.
9. Kurucunun Supabase bağlantısı yalnız okuma kipinde ve tek projeyle sınırlıdır; çalışan sistem Supabase MCP'sini kullanmaz.
10. Kimlik ayrımı: Bölüm 5.5.

**Sınama:** C03'teki olumsuz testler, her birinin "doğru yetkiyle doğru iş" karşılığıyla.

**Statü:** **[Öneri]**; **[Doğrulama bekliyor: C01, C03]**. Tamamen farklı sözcüklerle yeniden anlatılmış özel içeriğin yakalanması **[Açık sorun: U-6]**.

### K-10 Öğrenme ve kendini geliştirme

**İhtiyaç:** Derslerin kalıcı olması ve doğru yerde seçilmesi; yöntem değişikliklerinin eski iyi davranışı bozmaması; kendi kendine onay verilmemesi; sürecin kendi amacına dönüşmemesi; modeller geliştikçe gereksizleşen mekanizmaların kaldırılabilmesi.

**Mekanizma:** Öğrenme kayıtları (gözlem, olay, bulgu, örüntü, hata sınıfı, yetenek eksikliği adayı ve kesinleşmiş yetenek eksikliği, iyi ve kötü örnek, sınav, yöntem, öneri); düzenli yetenek eksikliği taraması; yöntem değişikliği akışı (öneri → gizli sınavla ölçme → denetim ortamında onay → etkinleşme → izleme → gerekirse geri alma); süreç sınırı: her yeni kural, kayıt ya da süreç hangi SOUL ilerlemesine hizmet ettiğini göstermek zorunda; **mekanizma varsayım envanteri** (Bölüm 6.12): her mekanizma modelin tek başına yapamadığı hangi şeyi telafi ettiğini yazar ve bu varsayım düzenli olarak ve model değiştiğinde sınanır.

**Sınama:** C10.

**Statü:** **[Öneri]**.

### K-11 Batu ile etkileşim

**İhtiyaç:** Batu'nun yalnız kendisine ait kararlarla, karar verebileceği bilgiyle karşılaşması; kısıtlarının sorgulanabilmesi; telefondan çalışabilmesi; teknik yük taşımaması.

**Mekanizma:**

1. **Karar kaydı ve biçimi** (Ek E): ne soruluyor, neden Batu'ya soruluyor, seçenekler (her biri için amaç, fayda, bedel), öneri ve gerekçesi, karar için bilinmesi gerekenler, cevap verilmezse ne olur.
2. **Karar kanalı:** Bölüm 5.5'teki seçime göre.
3. **Kullanıcı modeli** (`UserModel`): Batu'nun uzman olduğu alanlar (finans, raporlama, SAP, Fabric, Power BI), bilgisinin sınırlı olduğu alanlar, ona ait karar türleri.
4. **Kısıt sorgulama:** Her kısıt (`Constraint`) sorgulanabilir statüdedir. Koordinatör her iş planlanırken ve denetim oturumu her incelemede, işin gereğinin bir kısıtla çelişip çelişmediğine bakar; çelişki bulununca karar kaydı açılır.
5. **Emek politikası:** Bölüm 6.10.
6. **Dil:** Batu ile Türkçe, sistemin içinde İngilizce (Bölüm 0.6).
7. **Batu'nun onayının kapsamı:** Teknik doğruluğu denetim ortamı belirler. Batu'ya yüksek etkili değişikliklerde amaç ve risk açısından sade bir kabul sorusu gelir (Ek E biçimi). Batu'nun onay sayısı C06–C07'de ölçülür; onayın biçimsel bir imzaya dönüşmesi izlenir.

**Sınama:** C06 karar akışı; C07'de kısıtla çelişen bir durumun doğru sunulması; Ek E'ye uyumun Batu tarafından değerlendirilmesi.

**Statü:** **[Öneri]**.

---

## 5. Teknoloji seçimleri: ihtiyaç, alternatifler, seçim

Her bileşen için önce ihtiyaç, sonra seçimden önce değerlendirilen alternatifler, sonra seçim ve statüsü.

### 5.1 Bilişsel çalışma ortamı

**İhtiyaç:** Ajanların güçlü muhakemeyle çalışması; bilgisayar kapalıyken çalışabilmesi; ek ücret ve bakım gerektirmemesi; telefondan izlenebilmesi.

| Seçenek | Değerlendirme |
|---|---|
| Claude Code cloud | Max planına dahil; bilgisayar kapalıyken çalışıyor; telefondan izlenebiliyor; routine'lerle uyandırılabiliyor |
| Codex (uygulama ve bulut) | Abonelik içinde, bilgisayar kapalıyken belirli bir depoda bulut görevini otomatik başlatan yol 28 Eylül itibarıyla yoktu (kullanıcı hata kaydı ve belgeler) |
| Codex Agents API | Kullanım başına ücretli; ayrıca kendi sunucunuzu gerektiriyor |
| Yerel Claude Code | Bilgisayarın açık kalmasını gerektiriyor (kriter 22'yi bozuyor) |
| Kendi sunucusunda ajan çerçevesi | Sunucu maliyeti ve bakım gerektiriyor |

**Seçim:** Claude Code cloud. **[Batu kararı]** Gerekçesi bu konuşmada karşılaştırılarak kuruldu.

### 5.2 Uyandırıcı ve çalışma düzeni

**İhtiyaç:** Açık oturum yokken oturum başlatmak; roller arası devirlerin Batu olmadan akması; günde 15 routine çalışması sınırı altında yeterli kapasite.

| Seçenek | Değerlendirme |
|---|---|
| **Routines yalnız oturum başlatmak için + roller oturum içinde alt ajan** | Günde birkaç oturumla yetinir; yetki ayrılığı ayrı ortamlarla korunur. **Seçilen** |
| Her devir için routine tetiği (2.0'daki düzen) | Günde 15 çalışmaya sığmaz; yanlış öncüle dayanıyordu |
| Claude Code Projects (Eylül 2026, beta) | Koordinatör + işçi oturumlar; günde 200 yeni oturum. Tek ortam kullandığı için yetki ayrılığını sağlamaz; hesaptaki bütün connector'ları alır; Batu'nun hesabında henüz açık olmayabilir. Çalışma ortamını hızlandıran isteğe bağlı bir katman olarak C01'de değerlendirilir |
| Claude Code dynamic workflows (Mayıs 2026) | Oturum içinde çok sayıda paralel alt ajanı bir betikle yönetir; büyük tarama işleri için aday. Bulutta çalışması C01'de sınanır |
| GitHub Actions ile ek işçi | Gizli depoda dakika sınırı; açık depoda iş kayıtları herkese açık. Şimdilik kullanılmıyor |
| Ücretli ek kullanım | Yalnız ölçümden sonra ve bedeliyle Batu'ya karar olarak |

**Seçim:** **[Öneri; teknik karar verildi]** Ayrıntı: `Uyandirma_ve_Kapasite_Arastirmasi.md` ve `Calisma_Duzeni_Karsilastirmali_Arastirma.md`. Yetki her zaman anahtardan gelir, oturumun açılış yolundan değil; bu yüzden Projects ya da dynamic workflows eklense de güvenlik modeli değişmez.

### 5.3 Canlı durum ve kural kapısı

**İhtiyaç:** Aynı işin iki kez alınmasını engelleyen işlemler; kuralların sistem tarafından zorlanması; ilişki sorguları; kelime ve anlam araması; dosya deposu; zamanlanmış işler; oturumdan anahtar eklenmiş HTTP isteğiyle erişim; olay olduğunda dışarıya HTTP çağrısı.

| Seçenek | Güçlü yanı | Zayıf yanı |
|---|---|---|
| Yalnız Git (dosyalar, issue'lar) | Ek bileşen yok; geçmiş kendiliğinden tutulur | Aynı anda üstlenmeyi ve kuralları zorlayamaz; sorgu ve arama zayıf |
| **Supabase** | PostgreSQL, satır bazlı erişim, HTTP API, fonksiyonlar, anlam araması (pgvector), dosya deposu, zamanlanmış işler, dışarıya HTTP çağrısı tek pakette | Ücretsiz planda bir hafta kullanılmayan proje uyuyor, otomatik yedek yok, veritabanı 500 MB **[Doğrulandı: supabase.com/pricing]** |
| Neon | Boşta kalınca kapanıp bağlantıda kendiliğinden açılıyor; ücretsiz planda 6 saatlik geri alma geçmişi; 0,5 GB **[Doğrulandı: neon.com/docs]** | HTTP API, dosya deposu, zamanlanmış işler ve dışarıya çağrı için ek bileşenler gerekiyor; parça sayısı artıyor |
| Cloudflare Workers + Durable Objects | Güçlü eşzamanlılık denetimi; ücretsiz planda kullanılabilir **[Doğrulandı: developers.cloudflare.com]** | Kural kapısı kendi yazılan sunucusuz koddur; PostgreSQL'in sorgu, erişim kuralı ve arama olanakları yok; anlam araması ayrı hizmet gerektirir |

**Seçim:** Supabase. **[Öneri; Batu kabul etti]** Gerekçe: gereksinimlerin tamamını en az parçayla karşılayan seçenek bu.

**Plan seviyesi yeniden karara sunuldu (Bölüm 11, B1).** Önceki kararda ücretsiz plan seçilmişti. Bu sürümde kapasite tahmini yapıldı ve ücretsiz planın bir gereksinimi kısabileceği görüldü:

- Kütüphane metni: `agentic-os-search`'ün ana dalında yaklaşık 18,5 MB metin; eski deneme depoları (dallarıyla) sıkıştırılmış halde yaklaşık 22 MB.
- Tahmini parça sayısı 30–50 bin. Anlam vektörleri, arama dizinleri ve kelime araması dizinleriyle birlikte veritabanında yaklaşık 250–400 MB. **[Varsayım: C04'te ölçülecek]**
- Buna DevOS'un kendi kayıtları, olay geçmişi ve sınav sonuçları eklenecek.

Ücretsiz planın 500 MB sınırı ilk aylarda dolabilir. Bu durumda ya anlam araması kütüphanenin bir kısmına uygulanır (kriter 5 ve 11'den taviz) ya da plan yükseltilir. Pro planı (aylık 25 $'dan) 8 GB veritabanı, günlük yedek ve uyumayan proje sağlıyor **[Doğrulandı: supabase.com/pricing]**. Seçenekler ve önerim Bölüm 11'de.

### 5.4 Anlam araması modeli

**İhtiyaç:** Büyük ölçüde Türkçe, kısmen İngilizce bir kütüphanede anlamca ilgili içeriği bulmak; özel içeriği dışarıya göndermemek.

| Seçenek | Değerlendirme |
|---|---|
| Supabase'in yerleşik `gte-small` modeli | Ek ücretsiz ve Edge Functions içinde hazır **[Doğrulandı: supabase.com/docs, şu an desteklenen tek yerleşik model]**. Ancak İngilizce için eğitilmiş bir model; Türkçe kütüphanede zayıf kalması beklenir **[Varsayım: C04'te ölçülecek]** |
| Dış hizmetlerin gömme API'leri | Çok dilli ve kaliteli; ama ya ücretli ya da ücretsiz katmanda gönderilen içerik sağlayıcının ürün geliştirmesinde kullanılabiliyor. Özel kütüphane için kriter 31'i bozar |
| Açık kaynaklı çok dilli model, kendi işlerimizde çalıştırılan | İçerik dışarıya çıkmaz; ek ücret yok. İçe alma sırasında gizli `devos-backup`'taki işte, arama sırasında oturumun kendi makinesinde çalışır |

**Seçim:** Açık kaynaklı çok dilli bir model. **[Öneri]** Aday modeller C04'te, Bölüm 4 K-6'daki gizli arama ölçüsüyle karşılaştırılır ve ölçüme göre seçilir; `gte-small` da karşılaştırmaya dahil edilir. Modelin oturum makinesine indirilebilmesi ve Actions süre sınırları **[Doğrulama bekliyor: C01]**.

### 5.5 Karar kanalı ve sistem kimliği

**İhtiyaç:** Batu'nun kararlarının gerçekten Batu'dan geldiğinin bilinmesi; yüksek etkili değişikliklerin Batu'nun onayı olmadan ana ürüne girmemesi; telefondan kolay kullanım.

**Sorun:** Claude Code'un GitHub'da yaptığı commit'ler ve açtığı PR'lar Batu'nun kişisel GitHub kimliğiyle görünüyor **[Doğrulandı: ikincil kaynak, builder.io, routines rehberi]**. Bunun üç sonucu var: GitHub, sistemin yaptığıyla Batu'nun yaptığını ayırt edemez; GitHub kişinin kendi PR'ını onaylamasına izin vermediği için Batu sistemin PR'larını GitHub'ın kendi onay düzeniyle onaylayamaz; issue'lara yazılan bir "cevabın" Batu'dan mı sistemden mi geldiği bilinemez. Bu, çözülmesi gereken bir tasarım sorunudur; "sonra sınanır" diye bırakılamaz.

| Seçenek | Güçlü yanı | Zayıf yanı |
|---|---|---|
| **(a) Sistem için ayrı GitHub makine hesabı** | GitHub'ın kendi onay düzeni (zorunlu inceleme, kod sahibi onayı) tam çalışır; Batu telefondaki GitHub uygulamasından onaylar; özel arayüz yazılmaz. GitHub kişi başına bir ücretsiz makine hesabına izin veriyor **[Doğrulandı: GitHub Hizmet Şartları]** | Claude'un GitHub bağlantısı makine hesabına geçer; bu Batu'nun diğer Claude Code projelerini de etkiler: o depolara makine hesabının ortak çalışan olarak eklenmesi gerekir ve oradaki commit'ler de makine hesabıyla görünür |
| (b) Karar paneli (Supabase kimlik doğrulaması + sistemin yazamadığı ayrı bir depoda küçük bir sayfa) | Diğer projeleri etkilemez | GitHub'ın onay düzeni yine kullanılamaz; bütün onaylar özel bir sayfadan geçer; bu sayfanın kendisinin korunması ve güncellenmesi ayrı bir sorun |
| (c) Belirsizliği kabul etmek | Hiçbir ek iş yok | Kriter 8 ve 21'i bozar; reddedildi |

**Önerim (a).** Daha az özel parça ve daha güçlü bir koruma sağlıyor. Diğer projelere etkisi tek seferlik bir ayar (hazırlıkta makine hesabının o depolara ortak çalışan olarak eklenmesi). Karar Batu'nun, çünkü diğer projelerini etkiliyor (Bölüm 11, B3). (a) seçilmezse (b) uygulanır.

**Bildirim:** Karar gerektiren her şey GitHub'da Batu'ya atanmış bir issue olarak açılır. (a) seçilirse issue'yu makine hesabı açtığı için Batu bildirim alır; (b) seçilirse issue'lar Batu'nun kendi kimliğiyle açılır ve GitHub kişiye kendi eylemleri için bildirim göndermeyebilir. Bu, (a)'yı destekleyen ek bir nedendir. **Yedek kanal ölçülebilir tanımlıdır:** belirli sürede açılmayan karar ikinci kanaldan (Claude uygulaması bildirimi ya da e-posta) yinelenir; süre Ek E'de.

### 5.6 Yayın ve ürün deposu

**İhtiyaç:** Hiçbir değişikliğin kontrollerden geçmeden ana ürüne girmemesi; yüksek etkili değişikliklerde Batu'nun onayı; "PR açıldı" ile "gerçekten girdi"nin ayrılması.

**Seçim:** GitHub PR akışı: routine'ler varsayılan olarak yalnız `claude/` ile başlayan dallara gönderim yapabiliyor **[Doğrulandı: ikincil kaynak]**; `main` dalı korunur ve kurallar yöneticileri de kapsar; zorunlu kontroller (testler, şema, bağlantılar, katalog kaydı, sızıntı kontrolleri, gereken işlerde bağımsız inceleme hükmü); yüksek etkili dosyalarda Batu'nun onayı (B3'e göre GitHub onayı ya da karar paneli); rutin değişikliklerde kontroller geçince otomatik birleşme; niyet ve gözlem kayıtları. **[Öneri]** Alternatif yok denecek kadar dar: GitHub platformun zorunlu parçası.

### 5.7 Yedek ve felaket kurtarma

**İhtiyaç:** Veri kaybında en fazla ne kadar işin kaybolacağının bilinmesi ve kabul edilebilir olması; Supabase hesabına bir şey olursa bile verinin kurtarılabilmesi.

**Seçim:** **[Öneri]**

1. **Neyin yedekleneceği:** DevOS'un kendi kayıtları (işler, kararlar, katkılar, olaylar, inceleme ve sınav kayıtları, öğrenme kayıtları) ve dosya deposundaki kaynak ve kanıt gövdeleri. **Yeniden üretilebilir veri yedeklenmez:** anlam vektörleri ve kütüphanenin içe alınmış kopyası yerine kaynak commit'i ve model sürümü kaydedilir; geri yüklemede yeniden üretilir.
2. **Olay kaydının saatlik aktarımı** gizli `devos-backup`'a. Olaylardan yeniden kurma sözleşmesi (hangi olay hangi durumu nasıl yeniden kurar) C09'da yazılır ve sınanır. "En fazla bir saatlik kayıp" bu sınanana kadar **hedeftir**, sonuç değil.
3. **Günlük tam aktarım:** Yukarıdaki kapsamla, sıkıştırılmış olarak.
4. **Saklama yeri ve bütçe:** Boyut ve Actions dakika bütçesi C04'ten önce hesaplanır. GitHub dosya ve depo sınırlarına ya da ayda 2.000 ücretsiz dakikaya yaklaşılırsa seçenekler (seyrekleştirme, başka saklama yeri, ücretli plan) bedeliyle Batu'ya gelir. Dakikalar biterse aktarımın durduğu fark edilmelidir; bu, bağımsız izleme yolunun işidir (Ek G, G7).
5. **Aylık geri yükleme tatbikatı.**

Saniye düzeyinde geri alma (aylık 100 $'lık ek) önerilmiyor; saatlik olay kaydı gösterildiğinde gereksizdir.

### 5.8 İkinci model ailesi

**İhtiyaç:** Kriter 4'ün sınanması; bütün ajanların aynı model ailesinden olmasının yarattığı ortak kör noktaların azaltılması.

| Seçenek | Değerlendirme |
|---|---|
| Google Gemini API ücretsiz katmanı | Ücretsiz, kullanım sınırlı; ücretsiz katmanda gönderilen içerik Google'ın ürün geliştirmesinde kullanılabiliyor **[Doğrulandı: Google geliştirici forumu ve fiyat sayfaları]**. Bu yüzden yalnız sahte veri ve açık depolara girecek içerik gönderilebilir |
| Ücretli bir ikinci sağlayıcı | Daha güçlü modeller ve veri güvencesi; kullanım başına ücret |
| Hiçbiri | Kriter 4 sınanamaz; ortak kör nokta riski azaltılmaz |

**Önerim:** Gemini ücretsiz katmanı; iki iş için: C11'deki sağlayıcı bağımsızlığı sınaması ve yüksek etkili, açık depolara girecek kararlarda ikinci görüş. Özel kütüphane içeriği hiçbir durumda gönderilmez: giden her istek tek bir fonksiyondan geçer, sızıntı kontrolünden geçer ve kayda girer. Ücretsiz kotanın düşük olabileceği (bazı modellerde günde birkaç düzine istek) kapasite planına girer. Karar Batu'nun (Bölüm 11, B2).

### 5.9 Hesaptaki eklentiler, beceriler ve connector'lar

Hesap düzeyinde etkinleştirilmiş beceriler bulut oturumlarına yükleniyor. Hesap eklentilerinin (ECC dahil) bulut oturumlarına kendiliğinden yüklenip yüklenmediği konusunda kaynaklar çelişiyor: DEVOS-002'deki belge okuması yüklendiğini, güncel resmî belgeler ise yüklenmediğini söylüyor. **[Doğrulama bekliyor; kaynaklar çelişiyor: C01]** Kancalar depodan ve kuruluş ayarlarından geliyor. Connector'lar için Bölüm K-9.

ECC kararı C00'da şu ölçütlerle verilir: hangi DevOS ihtiyacını karşılıyor, planın tasarımından iyi mi, DevOS kurallarıyla çatışıyor mu, bulutta gerçekten yükleniyor mu. Toptan benimsenmesi istenmedi (önceki D018 kararı). Aday parçalar: iki bağımsız inceleyici, üretici-değerlendirici döngüsü, döngü tasarım denetimi. **[Öneri: seçici kullanım]**

---
## 6. Hedef mimari

Bu bölüm sistemin tam halini tarif eder. Kurulum aşamaları (Bölüm 9) bunu riske göre sıralar; hiçbir aşama "şimdilik hafif hali, sonra gerçeği" mantığıyla kurulmaz.

### 6.1 `devos` deposunun düzeni

```text
devos/
  CLAUDE.md                 # ortak kurallar (Ek D) + oturum disiplini + giriş yönlendirmesi
  .claude/agents/           # rol tanımları (Ek A); kısa, paketi açılışta yükler
  .claude/protocols/        # dokuz düşünme disiplininin tam metni (Ek D)
  .claude/settings.json     # izin kuralları (connector araçlarının engellenmesi) ve kancalar (açık depoya yazım öncesi sızıntı kontrolü)
  methods/                  # çalışma yöntemleri (keşif, araştırma, sınama, karar vb.)
  plan/                     # bu plan, Ek A–G, değerlendirme ve araştırma belgeleri, aşama kayıtları
  supabase/migrations/      # sürümlü SQL değişiklikleri
  supabase/functions/       # Edge Functions (kontrol uçları, ikinci model geçidi)
  pipelines/                # içe alma, gömme üretimi, yedek ve sızıntı kontrolü kodu
  .github/workflows/        # PR kontrolleri ve sürüm yayını
  .github/CODEOWNERS        # yüksek etkili dosyalar
  tests/                    # birim, veritabanı, akış, güvenlik, geri yükleme, arama ölçüsü, davranış
  evidence/                 # her aşamanın güvenli özet kanıtı ve kanıt kimlikleri (ham kanıt veritabanında ve gizli dosya deposunda)
  product/soul/             # SOUL ürünü (sürümde soul-system deposuna yayımlanır)
  sources/INDEX.md          # kütüphane kaynaklarının kimlik listesi (içerik değil)
```

`.claude/settings.json` ve `.claude/protocols/` yüksek etkili dosyalardır; değişiklikleri denetim ortamının incelemesinden ve Batu'nun kabulünden geçer. Oturum içinde bu dosyaların düzenlenmesini engelleyen bir kanca da vardır. **[Öneri]**

### 6.2 Supabase: canlı durum ve kural kapısı

- **Şemalar:** `devos_private` (bütün tablolar, dışarıya kapalı) ve `devos_api` (yalnız fonksiyonlar). Ajanlar yalnız `devos_api` fonksiyonlarını çağırabilir.
- **Kural kapısı:** Her durum geçişi bir veritabanı fonksiyonudur. Fonksiyon, ortam belirtecinden rol sınıfını, üstlenme belirtecinden işi, güncel yetkiyi, sürümü, önkoşulları ve gereken kanıtı aynı işlem içinde denetler. Reddedilen geçiş gerekçesiyle kaydedilir. Her geçiş aynı işlemde bir olay kaydı üretir (F06).
- **Veritabanı rol sınıfları:** `devos_calisma`, `devos_denetim`, `devos_sinav`, `devos_ci`, `devos_ingest`, `devos_backup` (salt okuma + yalnız "aktarıldı" işareti), `devos_kurulum` (yalnız kurulum süresince). Ayrıntı Ek B.
- **Kayıt aileleri:** Ek B.
- **Zamanlanmış işler:** hazır iş taraması, süresi dolmuş üstlenmelerin tespiti, kilitlenme taraması, bayat kayıt ve bağlantı denetimi, amaç denetimi, yetenek eksikliği taraması, kullanım takibi, sessiz başarısızlık örneklemesi için iş açma.
- **Dışarıya çağrı:** Olağan akışta veritabanı routine tetiklemez; oturumlar zamanlanmıştır. Yalnız acil durumlar (Batu'nun beklenen kararı geldi ve iş bekliyor; kurtarma) yedek bütçeden API tetiği kullanır; her tetik niyet, dönen oturum kimliği ve sonuçla kaydedilir.
- **Arama:** Tam metin arama, pgvector ile anlam araması, ilişki sorguları; kaynak gövdesi okuma (`read_source`). Etkilenen kayıt sorgusu benzersiz kayıtları ve tamlık bilgisini döndürür; devam sorgusu aynı anlık görüntüye bağlıdır ya da açıkça yeniden başlar (Ek G).
- **Dosya deposu:** Büyük kaynak ve kanıt gövdeleri gizli alanlarda.
- **İki proje:** Canlı proje `devos` (ref `zyqgltzfzkdvrmvxlamz`, `https://zyqgltzfzkdvrmvxlamz.supabase.co`, us-east-1) ve test projesi `devos-test` (ref `cqbzxexxwrrbrlszoseg`, us-east-1). 29 Eylül 2026'da ücretsiz planda açıldı. Herkese açık anahtarlar gizli bilgi değildir ve kurucu onları proje panelinden ya da Supabase bağlantısından okur.
- **Veritabanı değişiklikleri** yalnız `supabase/migrations/` altındaki sürümlü dosyalarla uygulanır. Kurucunun Supabase bağlantısı salt okuma kipinde ve tek projeyle sınırlıdır.

### 6.3 Claude Code cloud ortamları ve anahtar akışı

**Ortamlar:**

| Ortam | Ne zaman kurulur | Ne yapar | Yetkisi | Yapamaz |
|---|---|---|---|---|
| `devos-kurulum` | Hazırlıkta | Kurucu | C02'den sonra kurulum işlemleri | Kurulum bitince kapatılır |
| `devos-calisma` | C02–C03 | Koordinasyon, keşif, araştırma, tasarım, üretim, bilgi düzeni, teşhis; roller alt ajan olarak | İş açma ve üstlenme, katkı ve aday yazma, `claude/` dallarına gönderim, PR açma | Bağlayıcı hüküm, kabul, sürüm etkinleştirme, kural değişikliği, sınav cevaplarına erişim |
| `devos-denetim` | C02–C03 | Bağlayıcı inceleme (DR13-G, DR13-Y), kabul önerisi, kural ve kontrol değişikliği incelemesi, yüksek etkili birleşmelerde yetki kontrolü, kurtarma aşamalarının ilerletilmesi | Hüküm ve kabul yazma | Ürün üretme, sınav cevaplarına erişim, onardığı şeyi onaylama |
| `devos-sinav` | C05 | Sınav setlerini tutar, sınav görevlerini sıradan iş olarak açar, sonuçları puanlar | Sınav kayıtları, `devos-evals` | Ürün üretme, hüküm yazma |

**Anahtar düzeni:** Her ortama Supabase'in **herkese açık anahtarı** ve ayrı bir başlıkta taşınan bir **ortam belirteci** verilir. Veritabanı belirtecin yalnız özetini saklar; her `devos_api` fonksiyonu rol sınıfını buradan çıkarır. Supabase'in gizli (servis) anahtarı hiçbir ajan ortamına konmaz.

**Belirteç nasıl üretilir?** Kurucu, belirteç üreten bir veritabanı fonksiyonu yazar ama çalıştıramaz (yetkisi yoktur). Batu, Supabase panelinin SQL ekranında kurucunun verdiği tek satırı çalıştırır; fonksiyon rastgele bir belirteç üretir, özetini kaydeder ve belirteci bir kez gösterir. Batu belirteci yalnız ilgili Claude ortamının ayar alanına yapıştırır. Kurucu değeri hiç görmez; yalnız belirtecin var olduğunu ve beklenen yetkiyle çalıştığını sınar. Belirteç sohbete, oturum kaydına ya da depoya yazılmaz; yazılırsa iptal edilip yenilenir.

**Connector'lar:** Hiçbir DevOS routine'inde connector bulunmaz; depodaki izin kuralları connector araçlarını ayrıca engeller (K-9).

**Ağ:** Her ortam Supabase adresine ve GitHub'a erişir; araştırma yapan çalışma ortamı geniş internet erişimine ihtiyaç duyar. **[Doğrulama bekliyor: geniş erişim ile belirteç eklemenin birlikte çalışması, C01]**

**Oturum ömrü:** Bulut oturumunun kum havuzu turlar arasında duraklatılabiliyor; geri gelemezse yeni bir kopyadan devam ediyor ve kaydedilmemiş değişiklikler kaybolabiliyor. Bu yüzden ilerleme sık aralıklarla veritabanına ve dala yazılır; hiçbir iş uzun süre arka planda çalışan bir sürece güvenmez.

### 6.4 Routines

- Routine'ler yalnız oturum başlatır. Başlangıç bütçesi (günde 15 çalışma sınırı içinde; C01'deki oturum süresi ölçümüne göre gerekçeyle değişir):

| Ortam | Günlük çalışma | Zamanlama |
|---|---|---|
| Çalışma | 3 | Batu'nun yoğun saatleri dışında (gece, sabah erken, akşam) |
| Denetim | 3 | Her çalışma oturumundan sonra |
| Sınav | 1 | Gece, yalnız sınav gerektiğinde |
| Yedek | 8'e kadar | Oturumlar kısa kalırsa ek çalışma oturumu; acil karar ya da kurtarma |

- Routine'leri Batu, kurucunun hazırladığı bilgilerle (ad, ortam, depo, başlangıç talimatı, zamanlama) Claude arayüzünden oluşturur ve her birinden bütün connector'ları çıkarır. API tetiği yalnız yedek bütçe için eklenir.
- Tetik metni oturuma güvenilmeyen veri olarak iletilir; başlangıç talimatı onu yalnız bir iş kimliği olarak kullanır ve asıl bilgiyi veritabanından okur. **[Doğrulandı: routines belgesi]**
- Her oturum açılışta kendini kaydeder (ortam, routine, başlangıç). Acil tetiklerde niyet, dönen oturum kimliği ve sonuç kaydedilir; cevap kaybolursa önce oturumun varlığı kontrol edilir, kör tekrar yapılmaz.
- GitHub bağlantısı 72 saatten uzun koparsa routine kendini kapatır; bu, bağımsız izleme yoluyla fark edilir (Ek G, G7).

### 6.5 Oturum içi düzen

1. **Açılış:** `session_brief(rol)` (Ek D, D8): amaç zinciri, kuyruk, son kararlar, son oturumdan beri değişenler, açık itirazlar, bekleyen Batu kararları, rol paketleri ve mesleki kayıtlar. Durum tutarsızsa etkilenen işe başlanmaz.
2. **Üstlenme:** İş üstlenilir; üstlenme belirteci alınır.
3. **Bağlam:** Bağlam paketi istenir; zorunlu ihtiyaçları karşılanmamış paketle başlanmaz.
4. **Parçalama:** Koordinatör işi parçalara böler; her parça için hangi rolün, hangi paketle çalışacağını belirler.
5. **Alt ajan görev tanımı:** Her alt ajan görevi şunları taşır: amaç ve bağlı olduğu karar, beklenen çıktı biçimi, kullanılacak kaynaklar ve araçlar, sınırlar (ne yapmayacağı), emek bütçesi, sonucun yazılacağı kayıt. `CLAUDE.md`'yi yüklemeyen yerleşik yardımcılar rol işi için kullanılmaz.
6. **Tek yazar:** Paralel alt ajanlar okur, araştırır, analiz eder, inceler; bir ürünü aynı anda tek bir alt ajan yazar. Ortak kararlar yazmadan önce kayda geçer.
7. **Yazma:** Sonuçlar kurallı fonksiyonlarla yazılır; dosya değişiklikleri açık depoya yazım öncesi kontrolden geçip PR olarak gönderilir.
8. **Kullanım kaydı:** Her katkının nasıl kullanıldığı ya da neden kullanılmadığı yazılır.
9. **Döngü sınırları:** Üst sınır, bütçe ve "ilerleme yok" tespiti (K-7).
10. **Disiplin denetim izi:** Dokuz düşünme sorusunun her iş ve tur başındaki sonucu (yüklendi ya da atlandı ve neden), disiplin sürümü ve iş kimliği veritabanına yazılır (Ek D).
11. **Kapanış ve yapılandırılmış devir:** Açık sorular, alternatifler, beklenen alt sonuç, dönüş noktası, gerçekleşen ve bilinmeyen dış etkiler, kullanılan kaynaklar, tek bir sonraki sorumluluk. Yeni bir oturum yalnız kayıtlardan doğru devam edebilmeli.

### 6.6 Bilgi katmanı: kaynakların otorite statüleri

| Kaynak | Statü | Nasıl kullanılır |
|---|---|---|
| `agentic-os-search/research/soul-foundations` | Yeniden kullanılabilir temel | Gereksinimlerin gerekçesi; hedefe uygulanırken ayrıca değerlendirilir; K-1'deki kapsama taramasının kaynağı |
| `agentic-os-search/research/studies` | Aday bilgi | Dış kaynak birikimi; kendi başına karar değildir |
| `agentic-os-search/research/soul-context` | Bağlam | Projenin geçmişi |
| `agentic-os-search/agent/protocols` | Ortak kural girdisi | Ek D'nin kaynağı |
| `agentic-os-search/explorations` | Keşif, karar değil | Fikir ve gerekçe kaynağı; iş açma yetkisi vermez |
| `agentic-os-search/development-os` ve EXP-006 kayıtları | Tarihsel kayıt | Önceki denemelerin dersleri |
| Arşivdeki P4, P5, "SOUL ve DevOS" raporları | Tarihsel kaynak | Geçerli parçaları eklere aktarıldı |
| SOUL Academy keşif notu | Keşif notu, karar değil | Notun tarif ettiği karar yolundan geçmeden ondan iş açılmaz |
| Eski deneme depoları | Tarihsel deneme | Önceki denemelerin dersleri ve karşı örnekleri; içlerindeki "güncel" ifadeler geçersizdir |

Kütüphaneden gelen her kayıt "özel" gizlilik sınıfı taşır. Kütüphane depolarının kendi canlı durum kayıtları DevOS'un canlı durumu değildir; DevOS'un canlı durumu yalnız Supabase'tedir.

**Üç ayrı alan:** Her kayıt ya da ifade için **kaynak türü** (temel, aday, tarihsel, keşif), **ifadenin epistemik statüsü** (gerçek gözlem, kullanıcı kararı, çıkarım, hipotez, öneri) ve **bugünkü işlem yetkisi** (iş açabilir mi, talimat mı, yalnız bilgi mi) ayrı tutulur. Eski bir gerçek gözlem, tarihsel bir belgede durduğu için "yalnız fikir"e dönüşmez; eski bir karar ise tarihsel olduğu için bugün talimat sayılmaz.

### 6.7 Güven sınırları

- Ajanlar yalnız `devos_api` fonksiyonlarını çağırabilir; tablolara yazamaz.
- Yetki ortam belirtecinden ve üstlenme belirtecinden gelir; rol adı ve oturum kimliği beyandır (K-9).
- **Yetki ayrılığı ortam düzeyindedir:** Çalışma ortamının ürettiğini yalnız denetim ortamı bağlayıcı biçimde inceleyebilir ve kabul edebilir; sınav cevaplarını yalnız sınav ortamı görebilir; kural ve kontrol değişikliğini çalışma ortamı önerir, denetim ortamı inceler, Batu kabul eder. Bu ayrımlar veritabanında zorlanır. Oturum içindeki ayrımlar (örneğin iki alt ajan arası) beyana dayalıdır ve öyle etiketlenir.
- **Doğrulayıcı onarmaz:** Denetim oturumu bulduğu sorunu aynı eylemde düzeltmez; düzeltme çalışma ortamında ayrı bir iştir.
- **Yüksek etkili değişiklikler** (kurallar, rol tanımları, veritabanı şeması, güvenlik ve yayın ayarları, `.claude/settings.json`, karar kanalı): denetim ortamının teknik incelemesi + Batu'nun amaç ve risk açısından kabulü.
- **Dış etkileşim:** Dışarıdan açılan issue ve PR'lar hiçbir routine'i tetiklemez; dış içerik ajanlar için yalnız veridir.
- **Açık depoya yazımdan önce sızıntı kontrolü** (oturum içinde, koda dayalı): (1) eklenen metin gizli kütüphanenin parmak izleriyle karşılaştırılır; uzun eşleşme gönderimi durdurur; (2) anlam vektörü karşılaştırılır; eşiğin üstündeki yakınlık gönderimi incelemeye düşürür. Kontrol dala gönderim, PR gövdesi, yorum ve issue yazımını kapsar. Denetim kaydına eşleşen metnin kendisi yazılmaz. PR üzerindeki aynı kontrol ikinci katmandır. Eşik C03'te bilinen örneklerle ayarlanır.
- **Etki kanalı envanteri:** Bölüm 0.3 madde 13; her kanalın olumsuz testi C03'te.
- Gizli bilgi taraması açıktır.

### 6.8 Yayın

1. Oturum değişikliği kendi dalına, açık depoya yazım öncesi kontrolden geçirerek gönderir ve PR açar.
2. PR açılmadan önce niyet kaydı (`Operation`) oluşturulur.
3. Zorunlu kontroller çalışır.
4. **Birleştirme tek bir sıradadır:** Birleştirmeyi bir yayın işi yapar; birleştirmeden hemen önce veritabanındaki güncel yetkiyi ve dönemi yeniden okur. Kontrolün geçtiği an ile birleşme anı arasındaki pencere ölçülür ve yazılır; bu pencerede yetki iptal edilirse birleştirme yapılmaz. Zorunlu kontroller birleşme anında kendiliğinden yeniden koşmadığı için bu yeniden okuma gereklidir.
5. Rutin değişiklikler kontroller ve yeniden okuma geçince birleşir; yüksek etkili değişikliklerde denetim ortamının hükmü ve Batu'nun kabulü de gerekir.
6. Birleşmeden sonra gerçekleşen sonuç gözlem (`Observation`) olarak yazılır; geçmiş gözlem silinmez (F07).

`main` dalı korunur; kurallar yöneticileri de kapsar. Otomatik birleşmenin oturumun GitHub bağlantısıyla çalışıp çalışmadığı **[Doğrulama bekliyor: C01]**. Yayın kesintileri Ek G'de.

### 6.9 Karar kanalı

- Her karar önce veritabanında bir `Decision` kaydıdır; Ek E biçimiyle yazılır.
- Her karar, Batu'ya atanmış bir GitHub issue'su olarak da açılır; bildirim GitHub uygulamasıyla telefona gelir.
- **B3 = (a) makine hesabı ise:** Batu cevabı issue'ya kendi hesabıyla yazar ya da PR'ı kendi hesabıyla onaylar. Sistem, cevabın Batu'nun hesabından geldiğini denetler.
- **B3 = (b) karar paneli ise:** Batu cevabı, Supabase kimlik doğrulamasıyla giriş yaptığı küçük bir sayfadan verir; sayfa sistemin yazamadığı ayrı bir depoda durur.
- Belirli sürede açılmayan karar ikinci kanaldan yinelenir (Bölüm 5.5).
- Cevaplanmayan kararlar için Ek E'deki "cevap verilmezse ne olur" kuralı uygulanır.

### 6.10 Kullanıcı modeli, kısıtlar ve emek derinliği

- **Kullanıcı modeli:** Batu'nun uzman olduğu alanlar, bilgisinin sınırlı olduğu alanlar ve ona ait karar türleri. Batu'nun kendi söylediklerinden ve kararlarından güncellenir.
- **Kısıtlar:** Batu'nun koyduğu her kısıt sorgulanabilir statüdedir. İşin gereğiyle çelişki tespit edilince otomatik karar kaydı açılır: kaliteli seçenek, amacı, faydası, bedeli, kısıt altında yapılabilecek en iyi şey.
- **Emek politikası:** Her iş yüksek emek derinliğiyle açılır. Azaltma gerekçeyle ve denetim ortamının onayıyla yapılır; kullanıcı uzmanlığı meşru bir gerekçedir. Uzman değerlendirmesi hiçbir işte atlanmaz; değerlendirme sonucunda az iş yapılabilir (kriter 32). Üç adım hiçbir işte kaldırılamaz: değişebilir bilgilerin doğrulanması, alternatif araştırması, yüksek etkili kararlarda dış kaynak araştırması. Veritabanı bunun **biçim kapısını** uygular (adımın kaydı olmadan ilerlenemez); adımın gerçekten ve iyi yapıldığı denetim oturumunda ve örneklem incelemesinde değerlendirilir.

### 6.11 Hata, hata sınıfı ve yetenek eksikliği

Her kusur kaydı üç soruyla kapatılır: tek seferlik belirti mi, aynı genel kuralı ihlal eden bir hata sınıfı mı, yoksa bir rolün farklı işlerde tekrarlayan yetenek eksikliği mi? Hata sınıfında kural yazılır ve regresyon testi sınıf düzeyinde kurulur. Yetenek eksikliği tek bir güçlü olaydan **aday** olarak kaydedilebilir; kesinleşmesi yeniden üretim, nedensel ayrım ve karşı örnekle olur. Onarım rolde yapılır (bağlam, yöntem, araç, rol tanımı ya da model) ve gizli sınavla ölçülmeden etkinleşmez. Sık görülen bir hata, sırf sık olduğu için doğru teşhis edilmiş sayılmaz; aynı modeli kullanan roller aynı kör noktayı paylaşabilir.

**Çoklu ajan başarısızlık sınıfları:** Her olay ayrıca üç sınıftan birine bağlanır: **tanım sorunu** (görev ya da rol yanlış tanımlanmış, sonlanma koşulu bilinmiyor), **ajanlar arası uyumsuzluk** (bağlam ya da bilgi aktarılmamış, katkı yok sayılmış, görevden sapılmış), **doğrulama eksikliği** (erken bitirme, eksik ya da yanlış doğrulama). Sınıfların dağılımı düzenli raporlanır; hangi mekanizmanın hangi sınıfta zayıf kaldığını gösterir.

**Sessiz başarısızlık denetimi:** Hiçbir kontrolün alarm vermediği ama işin yanlış yöne gittiği durumlar için, "tamamlandı" ve "geçti" sayılmış işlerden düzenli örneklem alınır ve denetim ortamında baştan değerlendirilir.

### 6.12 Çerçeve denetimi ve mekanizma varsayım envanteri

**Neden:** Çerçeve körlüğü DevOS'un ve SOUL'un en büyük tehlikesidir (Bölüm 0.3, madde 11). Bu planın 2.0 sürümü de bir çerçeve körlüğü yaşadı: "her rol ayrı oturumdur" öncülü sorgulanmadan taşındı ve tasarım bir sınıra takılınca yeni mekanizmalar üretmeye başladı.

**Mekanizma:**

1. **Öncül envanteri:** Her büyük tasarım (mimari, yöntem, rol düzeni, önemli karar) dayandığı öncülleri tek tek yazar: öncül, nereden geldiği (kullanıcı kararı, kaynak, önceki tasarım, varsayım), hâlâ geçerli mi, "bugün sıfırdan seçseydik yine bunu seçer miydik?" testi.
2. **Sıkışma sinyali:** Bir tasarım bir sınıra, çelişkiye ya da tekrarlayan soruna takılıp çözüm olarak yeni mekanizma, kural ya da istisna üretmeye başladığında çerçeve denetimi zorunludur: sınırı yaratan öncül hangisi, o öncül gerçekten gerekli mi? Veritabanında bir iş aynı konuda ikinci düzeltme mekanizmasını önerdiğinde bu denetim işi kendiliğinden açılır.
3. **Bağımsız karşı tasarım:** Büyük tasarım kararlarında, mevcut tasarımı görmeyen ve yalnız amacı, kısıtları ve kriterleri bilen temiz bağlamlı bir oturum kendi tasarımını çıkarır; ikisi karşılaştırılır. Fark, karar kaydında gerekçesiyle kapatılır.
4. **Mekanizma varsayım envanteri:** DevOS'un her mekanizması, modelin tek başına yapamadığı hangi şeyi telafi ettiğini yazar. Bu varsayım düzenli olarak ve model ya da platform değiştiğinde sınanır: mekanizma kaldırılınca sonuç kötüleşiyor mu? Kötüleşmiyorsa mekanizma kaldırılır.
5. **Teknik kararların sahibi:** Çerçeveden çıkıldığında görülen teknik düzeltme, etkisi büyük olsa da gerekçesiyle ekip tarafından verilir; Batu'ya yalnız ona ait kararlar gelir.

**SOUL gereksinimi:** Aynı kabiliyet SOUL için de gereksinimdir: SOUL'un kullanıcı adına kurduğu çalışma sistemleri de kendi öncüllerini yazmalı ve sıkışma sinyalinde çerçevelerini sorgulamalıdır. DevOS bunu SOUL gereksinim kaydına ilk kayıtlardan biri olarak girer.

**Sınama:** C00'da bu planın kendisine uygulanır (bağımsız karşı tasarım). C07'de ekibin bir sıkışma anında çerçeveyi sorgulayıp sorgulamadığı gözlenir. Gizli sınavda: sorgulanmadan taşınmış bir öncül yüzünden bir sınıra takılan bir tasarım görevi.

**Statü:** **[Öneri]**. Bir çerçeve körlüğünün yakalanacağını güvenceye alan bir yöntem yoktur **[Açık sorun: U-1 ile birlikte]**.

---

## 7. Roller, ortak kurallar ve yeterlik

### 7.1 Kaynaklar

1. **Ek A: 18 rol sözleşmesi.** P4 v4 §29 ve yüklenen P5 paketinin (K00–K15) rol dosyalarından çıkarılıp Claude Code'a uyarlanır. P5'in S00–S12 sürümüne erişilemedi; rol sözleşmeleri için gerekli değildi. Kaynaklar arasındaki farklar Ek A'da kayıtlıdır.
2. **Ek D: Dokuz düşünme protokolü** (`agentic-os-search/agent/protocols` kaynaklı): karar-kritik varsayımlar, kanıt dışı etkiden bağımsız muhakeme, amaç hizalaması ve uçtan uca doğrulama, doğrulama bağımsızlığı, kaynak-özet ayrımı, nedensel derinlik, çalışma sürekliliği, çalışma öncesi durum kontrolü, aday araştırma kütüphanesinin kullanımı. ChatGPT'ye özgü kısımlar çıkarılır, disiplinlerin kendisi korunur.
3. **ECC'den seçilen parçalar** (C00 kararına göre).

### 7.2 Claude Code'a yerleşim

- Ortak kurallar ve oturum disiplini → `CLAUDE.md`.
- Rol profilleri → `.claude/agents/` altında alt ajan tanımları; her tanım rolün sorumluluğunu, devredemeyeceği sınırı, çıktı biçimini ve çalıştığı ortamı taşır. Rollerin çoğu çalışma oturumunda koordinatörün başlattığı alt ajanlar olarak çalışır; yetki ayrılığı gerektirenler denetim ve sınav ortamlarında. **[Doğrulama bekliyor: bulut oturumunda yüklenme, C01]**
- Düşünme disiplinlerinin tam metinleri → `.claude/protocols/`; izin kuralları ve kancalar → `.claude/settings.json`.
- Yöntemler → `methods/`; bir işe hangi yöntemin uygulanacağı işin kaydında belirtilir.
- Agent teams ve dynamic workflows temel alınmaz; tek oturum içinde yararlı olduğu yerde (örneğin büyük tarama işleri) yardımcı olarak kullanılabilir. Tek yazar kuralı bu araçlarda da geçerlidir.

### 7.3 Yeterlik profili ve gizli sınavlar

Her rol için bir yeterlik profili tutulur: hangi iş türünde, hangi model ve ayarlarla, hangi bilgi ve araçlarla, hangi sınavdan geçerek yeterli bulunduğu; bilinen sınırları; ne değişirse yeniden sınanacağı.

- **Sınav nasıl yürür:** Sınav setleri sınav ortamında hazırlanır ve `devos-evals`'te durur. Sınav ortamı, sınav görevini veritabanına sıradan bir iş olarak koyar; çalışma ortamı onu normal iş gibi yürütür ve görevin sınav olduğunu bilmek zorunda değildir. Sınav ortamı sonucu cevap anahtarıyla puanlar. Sınanan rol cevap anahtarına hiçbir yoldan ulaşamaz: `devos-evals` yalnız sınav routine'ine bağlıdır ve sınav kayıtlarını yalnız sınav ortamının anahtarı okuyabilir.
- **İnceleme rollerinin sınavı:** Denetim ortamındaki rollerin sınav görevleri de sınav ortamından gelir; denetim ortamı kendi sınavını hazırlayamaz.
- Her sınav seti hem yanlış hem doğru yapılmış örnekler içerir.
- Sınav setleri düzenli yenilenir; sınavda iyileşip gerçek işte iyileşmeyen rol "sınava göre öğrenme" olarak kaydedilir.
- Rolün kendi değerlendirmesi ipucudur, kanıt değildir.
- Ölçülen düşünme yetenekleri: problemi yeniden çerçeveleme, sorgulanmamış öncülü fark etme, genel kuralı bulma, hatayı sınıfına götürme, alternatifleri karşılaştırma, dış kaynaktan doğru aktarım, kanıt kalitesini değerlendirme, gereksiz mekanizma üretmeme.

### 7.4 Rol yaşam döngüsü ve başlangıç kümesi

Yeni bir rol, bir uzmanı işe hazırlar gibi hazırlanır: ihtiyaç ve sistem incelemesi → sözleşme → uzmanlık paketi → mesleki süreklilik düzeni → gizli sınav → bağımsız inceleme → Batu'nun kabulü → izleme ve gerektiğinde emeklilik (Ek A Bölüm 6).

**Başlangıç kümesi:** 18 rol sözleşmesi korunur, ama roller ihtiyaç doğdukça etkinleşir. Paket, sınav ve yeterlik profili rol etkinleşirken hazırlanır. Başlangıç kümesi C07'nin gerektirdiği rollerle sınırlıdır: DR01, DR02, DR06-G, DR06-Y, DR08, DR13-G, DR13-Y, DR16 ve üretim gerekiyorsa DR05. Diğerleri gerçek bir ihtiyaç doğduğunda aynı protokolle etkinleşir. Her rol varlığını kanıtla hak eder; etkin bir rolün katkısı ölçülemiyorsa bu bir bulgudur.

---

## 8. Sınama ilkeleri: testler neyi kanıtlar?

1. **Her test bir iddiaya bağlıdır.** Testin adı değil, hangi iddiayı sınadığı kaydedilir.
2. **Olumsuz ve olumlu kontrol:** Her test hem yanlış çözümü yakalamalı hem doğru çözüme izin vermelidir. Her şeyi reddeden bir kontrol güvenli görünür ama işe yaramaz.
3. **Bozma testi:** Veritabanı kuralları ve kontroller için her kural bilerek bozulur; ilgili test başarısız olmalıdır. Başarısız olmuyorsa test kuralı sınamıyordur.
4. **Temsil:** Sınanan şey iddia edilen kabiliyeti gerçekten temsil etmelidir. Örneğin "doğru işi bulur" iddiası, önceden bilinen cevabı ipucuyla veren bir görevle sınanamaz.
5. **Bütünleşme:** Parçalar ayrı ayrı geçerken bütün sistem başarısız olabilir. Her aşamanın sonunda o ana kadar kurulanlar birlikte bir senaryoda sınanır; C11 bütünleşik sınamadır.
6. **Önceden yazılan ölçüt:** Bilişsel kapıların ve arama ölçüsünün başarı ölçütleri sonuç görülmeden yazılır. Sonuç görüldükten sonra ölçüt gevşetilirse eski sonuç geçersiz sayılır ve sınama yeni veriyle tekrarlanır.
7. **Bağımsızlık düzeyi açıkça yazılır:** Aynı oturumun kendi testi, aynı modelin ayrı oturumu, farklı bilgi görünümüyle ayrı oturum, farklı model ailesi, Batu'nun uzman incelemesi. Bir sonucun hangi düzeyde doğrulandığı kanıt kaydında durur ve iddia buna göre sınırlanır.
8. **Kanıt kaydı:** Her sonuç ham haliyle kanıt deposunda (özel içerik taşıyabilecek ham kanıt veritabanında ve gizli dosya deposunda; açık depoda güvenli özet ve kimlik); yapılmamış iş, denenmemiş davranış ya da açık soru başarı gibi sunulmaz.
9. **Ortak kanıt zarfı:** Her kanıt şunları birlikte taşır: kaynak commit'i, dağıtım yapılandırması, ölçüt sürümü, girdi, gerçek gözlem, ham kanıt kimliği, bağımsızlık düzeyi. Farklı sürümde ya da farklı hedefte alınmış bir "geçti" kaydı yeni kurulumu kapatamaz.
10. **Kanıt katmanları ayrıdır:** Yapısal bir testin (örneğin veritabanının zorunlu alanı denetlemesi) geçmesi, anlamsal bir yeterliği (örneğin özetin niteleyiciyi doğru taşıması) kapatmaz. Her test hangi katmanı ölçtüğünü yazar.
11. **Ayar ve son değerlendirme ayrıdır:** Bir seçimi yapmak için kullanılan örnekler, o seçimin son değerlendirmesinde kullanılmaz.
12. **Biçim kapısı içerik güvencesi değildir:** Veritabanının "alan dolu mu?" denetimi adımın yapıldığını değil, kaydının girildiğini gösterir; testler "dolu ama anlamsız" örneği de içerir ve içerik örneklemle değerlendirilir.

---
## 9. Kurulum aşamaları

**Sıralama ilkesi:** En belirsiz ve yanlış çıkarsa en pahalıya patlayacak şey en önce sınanır. Her aşama nihai kalitede kurulur; hiçbiri sonradan atılacak bir ara çözüm değildir. Bilişsel kapı (C07), altyapının sonuna değil, sınanabileceği en erken yere konmuştur.

**Kurulum defteri:** Supabase kurulana kadar (C02 sonu) ilerleme `plan/ledger.md`'de tutulur (özel içerik olmadan; kanıt kimlikleriyle). C02 sonunda veritabanına aktarılır. Aktarımın kabulü: tekrar çalıştırıldığında çoğalma yok; yarıda kesilirse kaldığı yerden devam ediyor; kayıtların bağları ve sürümleri eşleşiyor; aktarımdan sonra `ledger.md` yetkili yazma yüzeyi değil (dosyada açık bir devir işareti, sonraki yazma denemesi kontrolde reddediliyor).

**Her aşamanın kapanışı:** Kabul koşulları sonuç görülmeden yazılır; kanıt ortak kanıt zarfıyla kaydedilir (Bölüm 8); aşama kapanışı denetim ortamında gözden geçirilir.

**Aşamaların özeti:**

| Aşama | Tamamladığı | Açık bıraktığı ve nerede kapanacağı |
|---|---|---|
| C00 | Hazırlığın doğrulanması, ECC kararı, planın bağımsız incelemesi ve bağımsız karşı tasarım | — |
| C01 | Planın dayandığı platform bilgilerinin hesapta gözlenmesi; önce oturum süresi, connector'lar, anahtarlar | Başarısız satırlar planı burada değiştirir |
| C02 | Veri modeli, kural kapısı, kimlik zinciri, F01–F08 regresyonları, defter aktarımı | Karar kanalının arayüzü (C06) |
| C03 | Güven sınırları ve etki kanallarının olumsuz testlerle gösterilmesi | Sızıntı eşiği ayarı kütüphane içe alındıktan sonra (C04) |
| C04 | Kütüphane, üç arama, kaynak gövdesi okuma, bağlam paketi, anlam modeli seçimi | Paketin anlamca yeterliği (U-4) |
| C05 | Ortak kurallar, başlangıç rol kümesi, yöntemler, sınav düzeni | Rollerin gerçek işteki başarısı (C07) |
| C06 | Çalışma düzeni, denetim, karar kanalı | Kapasite yeterliği (C11, U-5) |
| C07 | İlk gerçek döngüde bilişsel kapı | Genel kalite ölçümü (U-2) |
| C08 | Model erişim ara katmanı, yayın, bütün ürün, SOUL deposu | SOUL'un ilk kullanılabilir sürümü DevOS'un işidir |
| C09 | Kesinti, yedek, geri yükleme ve yeniden bağlama | — |
| C10 | Öğrenme, amaç denetimi, süreç sınırı, varsayım envanteri | — |
| C11 | Bütünleşik sınama, gözetimsiz çalışma, kapasite, sağlayıcı bağımsızlığı | — |
| C12 | Devir ve kabul dosyası | Bölüm 10'daki açık sorunların son durumu |

### C00 — Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi

**Amaç:** Hazırlığın gerçekten tamamlandığını görmek; ECC'nin hangi parçalarının kullanılacağına karar vermek; planın kendisini çerçeve körlüğüne karşı sınamak.

**Yapılacaklar:**

0. **Plan paketinin çevirisi (Bölüm 0.6):** Plan, Ek A–G ve gerekçe belgeleri İngilizceye çevrilir; ayrı bir oturum çeviriyi Türkçe asılla bölüm bölüm karşılaştırır; farklar düzeltilir; sonra İngilizce metin bağlayıcı olur.
1. **Hazırlık doğrulaması:** Yeni depolar ve Supabase projeleri mevcut mu? Claude GitHub uygulaması gereken depolarda kurulu mu? B3'e göre makine hesabı kurulmuş mu? `agentic-os-search`'te D030 kaydı var mı ve depo eski yönü güncel olarak göstermiyor mu? Eksik varsa kurucu işe başlamaz; eksiği Batu'ya karar biçiminde bildirir.
2. **Okuma:** Plan, Ek A–G ve değerlendirme ile araştırma belgeleri baştan sona okunur.
3. **ECC işlev karşılaştırması:** Her bileşen DevOS ihtiyaçlarıyla tek tek karşılaştırılır. Sonuç: benimsenecek, devre dışı bırakılacak ve kararsız kalan parçaların listesi.
4. **Bağımsız plan incelemesi:** Planı yazanın gerekçelerini görmemiş ayrı bir oturum planı yalnız kriterlere ve kaynaklara göre eleştirir; Foundation'ı, aday çalışmaları ve eski deneme depolarını da tarar; daha önce denenip başarısız olmuş bir yolun tekrar önerilip önerilmediğine bakar.
5. **Bağımsız karşı tasarım (Bölüm 6.12):** Mevcut planı görmeyen ve yalnız SOUL'un amacını, Batu'nun kararlarını, kriterleri ve platform bilgilerini bilen bir oturum DevOS için kendi çalışma düzenini ve veri modelinin kapsamını tasarlar. İki tasarım karşılaştırılır; özellikle kayıt ailelerinin ve rollerin kapsamı "basit başla" ilkesine göre sorgulanır.
6. **Öncül envanteri:** Planın dayandığı öncüller tek tek yazılır ve sıfırdan seçim testine sokulur.
7. Sonuçlar karara bağlanır; plan gerekirse güncellenir (Bölüm 14).

**Kabul:** ✔ Çevirinin sadakat incelemesi geçmiş; çeviri sırasında önerilen değişiklikler ayrı kayıtlı. ✔ Hazırlık listesinin her maddesi kanıtla doğrulanmış. ✔ ECC tablosu, bağımsız inceleme, karşı tasarım karşılaştırması ve öncül envanteri kayıtlı; her bulgunun karşılığı yazılı. ✘ Kurucu kütüphane depolarına hiçbir şey yazmadı. ✘ Hiçbir gizli bilgi depoda, ortam değişkeninde ya da sohbette görünmüyor.

**Kriterler:** 18, 21, 25–27, 29, 34.

### C01 — Platform doğrulaması

**Amaç:** Planın dayandığı her platform bilgisini, pahalı kurulumdan önce Batu'nun gerçek hesabında gözlemek. İlk dört satır diğerlerinden önce yapılır; çünkü çalışma düzeninin tamamı onlara bağlıdır.

| # | Sınanan | Başarı koşulu | Başarısız olursa |
|---|---|---|---|
| 1 | **Oturum süresi ve parçalı iş** | Bir routine'in başlattığı bulut oturumu kuyruktan birden fazla işi yürütebiliyor; ne kadar süre çalıştığı, kum havuzunun duraklatılıp duraklatılmadığı ve yapılandırılmış devirle bir sonraki oturumun doğru devam ettiği gözleniyor | Çalışma oturumu sayısı yedek bütçeden artırılır; gerekirse seçenekler bedeliyle karara |
| 2 | **Connector engeli** | Connector'ları çıkarılmış bir routine'de ve depo izin kurallarıyla, hiçbir connector aracı çağrılamıyor | Hesap düzeyinde seçenekler Batu'ya (diğer sohbetlerine etkisiyle) |
| 3 | **Ortam belirteci** | Belirteç Supabase isteğine ayrı bir başlıkla ekleniyor; oturum belirteci hiçbir yoldan göremiyor; veritabanı rol sınıfını doğru çıkarıyor | Kimlik doğrulayan bir Edge Function kapısı |
| 4 | **Alt ajanlar** | `.claude/agents/` tanımları bulutta yükleniyor; rol paketi açılışta yüklenebiliyor; `CLAUDE.md`'yi yüklemeyen yerleşik yardımcılar belirleniyor | Rol metinleri oturumda açıkça yüklenir; yükleme kanıtı kaydedilir |
| 5 | Günlük routine sınırı | Hesaptaki gerçek değer, sayma biçimi ve sıfırlanma saati | Bütçe tablosu (Bölüm 6.4) güncellenir |
| 6 | Bildirim | GitHub bildirimi geliyor; B3'e göre kendi eylemleri için bildirim davranışı; ikinci kanal | Yedek kanal değiştirilir |
| 7 | Anlam modeli | Aday çok dilli model oturumda ve Actions işinde çalışıyor ve süre sınırına sığıyor | Model küçültülür ya da içe alma seyrekleştirilir; kalite etkisi ölçülüp karara |
| 8 | Yayın zinciri | Dala gönderim + PR + zorunlu kontroller + yayın işinin yetkiyi yeniden okuyup birleştirmesi + yöneticileri kapsayan koruma | Eksik halkaya göre yeniden tasarım |
| 9 | Tek depolu oturum | Tek depolu oturumda izin kuralları ve kancalar uygulanıyor; açık depoya yazım öncesi kontrol çalışıyor | Kontrol yalnız PR katmanında kalır; kalan risk Batu'ya |
| 10 | Kullanım gözlemi | Bir oturumun kullanım hakkına etkisi ve Batu'nun kendi kullanımıyla paylaşım gözlenebiliyor | Kapasite tahminle yapılır; belirsizlik kaydedilir |
| 11 | Kimlik | B3 (a) ise: sistemin commit, PR ve yorumları makine hesabıyla görünüyor; Batu'nun onayı GitHub'da alınabiliyor. B3 (b) ise: karar paneli girişi yalnız Batu'nun hesabıyla çalışıyor | Diğer seçeneğe geçilir |
| 12 | Depo erişim sınırı | Çalışma ve denetim oturumları `devos-evals`'i hiçbir yoldan okuyamıyor | Sınavlar Supabase'te yalnız sınav ortamının okuyabildiği şemaya taşınır |
| 13 | Eklenti ve beceri envanteri | Oturuma yüklenen bütün eklenti, beceri, alt ajan ve kancalar listeleniyor | Karara; gerekirse hesap düzeyinde kapatma |
| 14 | Dynamic workflows ve Projects | Bulut oturumunda dynamic workflows çalışıyor mu; Projects hesapta açık mı, açıksa koordinatör kullanıcı mesajı olmadan sıradaki işi başlatıyor mu | İsteğe bağlı katmanlar kullanılmaz |
| 15 | Kütüphane aktarımı | `devos-backup`'taki iş kütüphane depolarını salt okunur anahtarla okuyabiliyor; iş kayıtlarına içerik düşmüyor | Aktarım yöntemi yeniden tasarlanır |
| 16 | İkinci model (B2 onaylanırsa) | Ücretsiz katmanın gerçek sınırları ve koşulları | Bedeliyle karara |

**Kabul:** ✔ Her satırın sonucu ortak kanıt zarfıyla kayıtlı. ✔ Başarısız her satır için plan değişikliği kararı alınmış. ✘ Hiçbir sınama ücretli bir özelliği açmadı.

**Kriterler:** 17, 22, 23, 25–27.

### C02 — Veri modeli, kural kapısı ve kimlik zinciri

**Yapılacaklar:**

1. Ek B'deki şema, sürümlü SQL olarak; önce test projesinde.
2. Bütün durum geçişleri `devos_api` fonksiyonları olarak; her geçiş aynı işlemde olay üretir.
3. Kimlik zinciri: ortam belirteci, üstlenme belirteci, belirteç üreten fonksiyon (Bölüm 6.3).
4. Erişim kuralları ve rol sınıfları; tablolara doğrudan yazım kapalı.
5. Biçim kapıları (K-1, K-3, emek politikası); ortam düzeyindeki yetki ayrılığı kuralları.
6. Ek C'deki testler gerçek PostgreSQL'de; eşzamanlılık testleri.
7. Üç çalışma ortamı ve belirteçleri (Batu, Bölüm 6.3 akışıyla).
8. Kurulum defterinin aktarımı (Bölüm 9 girişindeki kabul koşullarıyla).

**Kabul:** ✔ Ek C testleri geçiyor; her kural bilerek bozulduğunda ilgili test başarısız oluyor. ✘ Hiçbir rol tablolara doğrudan yazamıyor. ✘ Her ortamın gerçek belirteciyle başka ortamın yetkisini gerektiren işlem reddediliyor. ✘ Başka oturumun üstlenmesiyle ve sahte oturum kimliğiyle işlem reddediliyor. ✘ Biçim kapıları boş alanları reddediyor; "dolu ama anlamsız" örnekler örneklem incelemesine düşüyor. ✔ Eksiksiz kayıtlar kabul ediliyor. ✔ Defter aktarımının dört kabul koşulu sağlanıyor.

**Kriterler:** 8, 10, 12, 14–16, 28, 30.

### C03 — Güven sınırları ve etki kanalları

**Sınamalar:** (1) Her ortamın belirteci yalnız kendi rol sınıfının fonksiyonlarını çağırabiliyor. (2) Kasıtlı saldırı görevi: bir ajan kuralı atlamanın yolunu arıyor; bulamamalı. (3) **Etki kanalı envanterindeki her kanal için olumsuz test:** connector araçları çağrılamıyor; ajan ortamında gizli anahtar yok; ikinci model geçidi dışından istek gönderilemiyor. (4) Dışarıdan açılmış bir issue hiçbir routine'i tetiklemiyor ve içindeki talimat uygulanmıyor. (5) Yönetici hesabıyla bile kontrolleri geçmemiş değişiklik `main`'e girmiyor. (6) **İlk açık yazımdan önce sızıntı kontrolü:** kütüphaneye yerleştirilmiş sahte "gizli" bir metnin aynen ve yeniden anlatılmış biçimleri, dala gönderimde, PR gövdesinde ve yorumda durduruluyor; denetim kaydına eşleşen metin yazılmıyor. (7) `.claude/settings.json` oturum içinde düzenlenemiyor. (8) Yedek rolü yalnız okuyabiliyor.

**Kabul:** ✘ Bütün olumsuz sınamalar reddedildi. ✔ Her birinin "doğru yetkiyle doğru iş" karşılığı başarılı; örneğin DevOS'un kendi sentezi ve kaynak kimliği açık depoya girebiliyor.

**Kriterler:** 8, 27, 30, 31.

### C04 — Bilgi, arama ve bağlam

**Yapılacaklar:**

1. İçe alma işleri: `agentic-os-search` sürekli, eski deneme depoları bir kez; kaynak türü, epistemik statü, işlem yetkisi ve gizlilik sınıfıyla.
2. **Arama ölçüsü:** Ayrı bir oturum, gerçek kütüphaneden en az 50 soru ve doğru kaynaklarını hazırlar; ayar soruları ve son değerlendirme soruları ayrılır; soruların en az üçte biri diller arasıdır (İngilizce soru, Türkçe kaynak). Başarı eşiği ölçümden önce yazılır.
3. **Anlam modeli seçimi:** Aday modeller (en az iki çok dilli açık model ve karşılaştırma için `gte-small`) ayar sorularıyla denenir; seçim bittikten sonra son değerlendirme sorularıyla bir kez ölçülür.
4. `read_source`, "nerede bulurum" rehberi, `session_brief()`, bağlam paketi akışı.
5. Sızıntı kontrolü için parmak izleri ve anlam eşiğinin ayarı.
6. **Kapasite ölçümü:** Veritabanı boyutu, bellek kullanımı ve arama gecikmesi. Plan sınırına yaklaşılıyorsa kapsam daraltılmadan önce Batu'ya karar olarak gelir. Yedek boyutu ve Actions dakika bütçesi de burada hesaplanır.

**Kabul:** ✔ Son değerlendirme soruları önceden yazılan eşiği geçiyor. ✘ Niteleyicisi düşürülmüş özet (anlamsal katman) ve zorunlu ihtiyacı karşılanmamış paket (yapısal katman) reddediliyor; iki katman ayrı raporlanıyor. ✔ Ajan, "Önceki DevOS denemelerinde Claude cloud hakkında ne öğrenildi?" gibi sorulara doğru kaynaktan cevap buluyor ve gerektiğinde kaynağın gövdesini okuyor. ✘ Keşif notundan doğrudan iş açılamıyor. ✔ Durum özeti son oturumdan beri değişenleri eksiksiz gösteriyor.

**Kriterler:** 5–7, 11, 17, 31.

### C05 — Ortak kurallar, roller ve yöntemler

**Yapılacaklar:**

1. `CLAUDE.md` ve `.claude/protocols/` (Ek D), `.claude/agents/` (başlangıç rol kümesi, Ek A ve Bölüm 7.4), `methods/`, `.claude/settings.json`.
2. Başlangıç kümesindeki her rolün paketi (Ek A Bölüm 3); bilgi haritaları katalogdan yeniden türetilir ve arama ölçüsüyle sınanır.
3. **Kapsama listesi:** Foundation'ın çalışma sistemi alanlarından K-1'deki keşif soru listesi türetilir ve sürümlenir.
4. **Sınav düzeni:** Sınav ortamı başlangıç kümesi için sınav setlerini hazırlar; sınavlar Bölüm 7.3'teki gibi sıradan iş olarak yürür.
5. Mekanizma varsayım envanterinin ilk hali (Bölüm 6.12).

**Kabul:** ✔ Her rol gizli sınavında "devredemeyeceği sınır" maddesine uyuyor. ✘ Sınava gizlenmiş tuzakları (kısıtla çelişen iş, eskimiş bilgi, düşmüş niteleyici, gizli önkoşul, sorgulanmamış öncül) yakalıyor. ✔ Doğru yapılmış örnekleri gereksiz yere reddetmiyor. ✔ Yeni bir rol hazırlama protokolüyle kurulup sınanabiliyor; rol paketi onu hazırlamayan bir oturumca incelenmiş. ✔ Dokuz düşünme sorusunun denetim izi veritabanında görülüyor.

**Kriterler:** 7, 13, 15–17, 28–30, 32.

### C06 — Çalışma düzeni, denetim ve karar kanalı

**Yapılacaklar:** K-7'deki düzenin tamamı; routine'lerin Batu tarafından oluşturulması (connector'lar çıkarılmış); talep-katkı-kullanım akışı; tek yazar kuralı; döngü sınırları; denetim oturumunun bağlayıcı incelemesi; karar kanalı ve yedek kanal; takılı iş ve kilitlenme taraması.

**Kabul:** ✔ A → B → A zinciri Batu'dan mesaj almadan tamamlanıyor. ✔ B'nin katkısı A'nın kararında görünür biçimde kullanılıyor ya da kullanılmama gerekçesi yazılı. ✘ Oturum kesildiğinde tamamlanmış katkı tekrar üretilmiyor; bir sonraki oturum doğru yerden devam ediyor. ✘ Aynı ürüne ikinci bir yazar reddediliyor. ✘ "İlerleme yok" durumu tespit ediliyor ve iş duruyor. ✔ Karar telefona ulaşıyor; belirli sürede açılmazsa ikinci kanaldan yineleniyor; cevapla iş devam ediyor. ✘ Batu dışından gelen "cevap" kabul edilmiyor. ✔ Batu'nun onay sayısı ve onaylarının biçimselleşip biçimselleşmediği ölçülmeye başlanıyor.

**Kriterler:** 9, 10, 21–23.

### C07 — İlk gerçek döngü: bilişsel kapı

**Amaç:** DevOS'un varlık gerekçesini ilk kez gerçek işte sınamak.

**Görev:** Ekibe SOUL'un amacı, kütüphane, geçmiş dersler ve kısıtlar verilir. Ekip, SOUL'u geliştirmek için ilk gerçek işi kendisi keşfeder, gerekçelendirir ve yürütmeye başlar.

**Ölçütler (sonuç görülmeden sabitlenir):**

1. **Kontrollü sınavda:** Görevin içine önceden gizlenmiş maddi bir eksik bulunuyor. **Gerçek görevde:** ekibin bulduğu eksiklikler ve yanlış varsayımlar kaydediliyor; "eksik bulunamadı" tek başına başarısızlık sayılmıyor, ama bulunanların maddi olup olmadığını teknik açıdan denetim ortamı, amaç ve değer açısından Batu ayrı ayrı değerlendiriyor.
2. İşe katkısı olmayan önkoşul ve hazırlık yığılmıyor.
3. Araştırma bir kararı görünür biçimde değiştiriyor, sınırlıyor ya da gerekçelendiriyor.
4. Batu mesaj taşımıyor; yalnız kendisine ait kararlara cevap veriyor.
5. Kısıtla çelişen durum Batu'ya kaliteli seçenek, amaç, fayda, bedel ve alternatifle sunuluyor.
6. Bir yerel hata belirtiden hata sınıfına ya da yetenek eksikliğine kadar götürülüyor.
7. Yüksek etkili bir kararda kütüphanedeki aday çalışmalar ya da güncel dış kaynaklar araştırılıyor ve karara yansıyor.
8. Kütüphaneden gelen bilginin bir kararı değiştirdiği, sınırladığı ya da gerekçelendirdiği durumlar raporlanıyor; atıf sayısı ölçü değil.
9. Bir sıkışma anında ekip önce çerçeveyi sorguluyor (Bölüm 6.12).

**Başarısız olursa:** Sistem incelemesi (Bölüm 6.11); düzeltme ilgili katmanda; sınama yeni bir görevle tekrarlanır. C08 ve sonrası, C07 geçilmeden SOUL ürünü üzerinde büyük işe başlamaz.

**Kriterler:** 1, 9, 14–16, 18, 28, 29, 34.

### C08 — Model erişim ara katmanı, yayın, bütün ürün ve SOUL deposu

**Yapılacaklar:**

1. **Model erişim ara katmanı:** SOUL ürününün model çağrılarının tek bir katmandan geçmesi; Claude ayağı abonelik içindeki oturumla (ortamda API anahtarı yok, kriter 25), ikinci model ayağı ikinci model geçidiyle.
2. Bölüm 6.8'in tamamı; bileşik ürün takibi; tek sıralı birleştirme; etiketlenen sürümün `soul-system`'e aktarılması; açık kaynak hazırlığı: kurulum belgesi ve lisans kararı (MIT ile Apache 2.0 karşılaştırmasıyla Batu'ya); yayın kesintisi senaryoları (Ek G).

**Kabul:** ✔ Niyet ve gözlem kayıtları tutarlı. ✘ Kontrolsüz ya da onaysız değişiklik birleşmiyor; kontrol ile birleşme arasında iptal edilen yetki birleşmeyi durduruyor. ✘ Birleşme cevabı kaybolursa değişiklik ikinci kez uygulanmıyor. ✔ Deneme sürümü `soul-system`'e yalnız ürün dosyalarıyla aktarılıyor. ✔ Başka bir test hesabı yalnız kurulum belgesini izleyerek SOUL'un o ana kadarki halini kurabiliyor.

**Kriterler:** 2, 4, 27. (Kriter 3, SOUL'un ortak öğrenme düzeni DevOS'un sonraki işi olduğu için SOUL gereksinim kaydına devredilir.)

### C09 — Kesinti, yedek, geri yükleme ve yeniden bağlama

**Yapılacaklar:** Bölüm 5.7'deki yedek (yeniden üretilebilir veri hariç; gövdeler dahil); olaylardan yeniden kurma sözleşmesi; yedek rolü; geri yükleme yöntemi (K-8) ve test projesinde tatbikatı; kesinti senaryoları (oturumun iş ortasında kapanması, Supabase'e erişimin kesilmesi, kullanım sınırının dolması, routine'in kendini kapatması, Actions dakikalarının bitmesi).

**Kabul:** ✔ Yedek test projesinde eksiksiz açılıyor; olaylardan yeniden kurma sözleşmesiyle kayıp süresi ölçülüyor ve hedefle karşılaştırılıyor. ✘ Eski sistem erişilebilir bırakıldığında `main`'e etki denemesi reddediliyor; eski belirteçler çalışmıyor. ✔ En az bir ortam yeni projeye gerçekten yeniden bağlanıyor ve doğru yeni iş ilerliyor. ✔ Her kesinti senaryosunda iş doğru yerden devam ediyor; tamamlanmış dış etki tekrarlanmıyor. ✔ Aktarımın durması bağımsız izleme yoluyla fark ediliyor. ✔ Yedekler açık depolarda değil.

**Kriterler:** 10, 24.

### C10 — Öğrenme, amaç denetimi, süreç sınırı ve varsayım envanteri

**Yapılacaklar:** Öğrenme kayıtları ve yöntem kütüphanesi; yöntem değişikliği akışı; yetenek eksikliği taraması; amaç denetimi; süreç sınırı; çıkmaz yol kayıtlarının kullanımı; mekanizma varsayım envanterinin sınanması; sessiz başarısızlık örneklemesi.

**Kabul:** ✔ Bir ders yeni bir görevde doğru yerde seçiliyor, uygun olmadığı yerde seçilmiyor. ✘ Eski iyi davranışı bozan yöntem değişikliği etkinleşmiyor. ✘ Çalışma ortamı kendi değişikliğini onaylayamıyor. ✔ Bilerek yerleştirilmiş tekrarlayan hata örüntüsü yetenek eksikliği olarak yakalanıyor; tek seferlik hata aday olarak kalıyor. ✔ Hedeften saptırılmış sahte iş amaç denetiminde yakalanıyor. ✘ Çıkmaz yol tekrar denenmeden önce hatırlatılıyor. ✔ Süreç sınırı: SOUL ilerlemesine hizmet ettiğini gösteremeyen yeni bir süreç önerisi reddediliyor. ✔ Bir rol, kullanılmadığı gösterildiğinde gerekçesiyle emekliye ayrılabiliyor ve geçmişi korunuyor. ✔ En az bir mekanizmanın varsayımı sınanmış ve sonucu kayıtlı.

**Kriterler:** 12, 13, 18, 19, 28, 30, 34.

### C11 — Bütünleşik sınama, gözetimsiz çalışma, kapasite ve sağlayıcı bağımsızlığı

**Yapılacaklar:**

1. Birden fazla işin aynı anda yürüdüğü; kaynak değişikliği, gecikmiş katkı, oturum kesintisi ve Batu kararı içeren uzun bir senaryo.
2. **Gözetimsiz çalışma:** DevOS en az yedi gün boyunca, Batu yalnız kendisine gelen kararlara cevap vererek çalışır; düzenli işler (yedek, içe alma, amaç denetimi, örneklem) aksamadan yürür.
3. Kapasite gözlemi: aynı kalite hedefiyle bir günde ne kadar iş ilerliyor, nerede tıkanıyor; Batu'nun kendi Claude kullanımına etkisi.
4. Maliyet ve sınır gözlemi.
5. **Sağlayıcı bağımsızlığı (B2 onaylanırsa):** SOUL ürününün sınanan kısmı, model erişim ara katmanı üzerinden ikinci modelle sahte veriyle çalıştırılır. Sınanan kısmın asgari kapsamı sonuç görülmeden yazılır; boşa yakın bir ürün üzerinde geçen sınama kriter 4 için kanıt sayılmaz.

**Kabul:** ✔ Uzun senaryo Batu'nun yalnız kendi kararlarıyla tamamlanıyor. ✔ Yedi günlük gözetimsiz çalışmada düzenli işler aksamadı; aksayan varsa fark edildi ve kaydedildi. ✔ Kapasite ve sınır raporu sade dille Batu'ya sunuluyor. ✔ SOUL'un sınanan kısmı ikinci modelle, kodunda Claude'a özgü değişiklik yapılmadan çalışıyor. ✘ Ürün kodunda ara katman dışında Claude'a özgü bir çağrı yok.

**Kriterler:** 2, 4, 9–11, 22–26.

### C12 — Devir

**Yapılacaklar:** Kurulum işlerinin kapanması ya da gerekçesiyle DevOS kuyruğuna devri; Batu için sade Türkçe, telefona göre kullanım kılavuzu; kabul dosyası: her kriter hangi kanıtla, hangi bağımsızlık düzeyinde karşılandı, hangisi kısmen, hangisi açık; Bölüm 10'daki açık sorunların son durumu; `devos-kurulum` ortamının kapatılması.

**Kabul:** ✔ Batu kılavuzla DevOS'u telefondan kullanabiliyor. ✔ Kabul dosyası her kriter için kanıt bağlantısı taşıyor. ✘ Kurulumun bitmesi SOUL'un bitmesi ya da DevOS'un yeterliğinin kanıtlanması olarak sunulmuyor.

---
## 10. Açık sorunlar ve doğrulama bekleyenler

### 10.1 Çözümü tasarlanmış, doğrulaması bekleyenler

Bunların çözümü bu planda tasarlanmıştır; hedef hesapta henüz gösterilmemiştir. Her biri C01 tablosunda ya da ilgili aşamanın kabul koşullarında sınanır ve başarısız olursa ne yapılacağı yazılıdır: çalışma düzeni ve routine bütçesi (K-7, 6.4), ortam belirteci ve kimlik zinciri (6.3, K-9), connector engeli, alt ajanların ve rol paketlerinin yüklenmesi, açık depoya yazım öncesi sızıntı kontrolü, sınav yürütme yolu (7.3), yayın zinciri ve birleşmede yetkinin yeniden okunması (6.8), kimlik ayrımı (B3), anlam modelinin oturumda ve işlerde çalışması, yedek biçimi ve olaylardan yeniden kurma (5.7), geri yüklemede eski yolların kapatılması ve yeniden bağlama (K-8), bağımsız izleme yolu (Ek G, G7).

Tasarımı bir ölçüme bağlı olanlar: bulut oturumunun gerçek süresi (C01 #1); yedek boyutu ve Actions dakika bütçesi (C04). Ölçüm tasarımı değiştirirse değişiklik Bölüm 14'e göre yapılır.

### 10.2 Çözümü bulunmamış ya da yalnız kısmen bulunmuş sorunlar

Bunlar "kurulumda sınanacak" diye çözülmüş sayılmaz. Her biri için ne olduğu, neyin eksik kaldığı, nasıl ele alındığı, neyin ona bağlı olduğu ve çözülemezse ne olacağı yazılıdır.

| # | Sorun | Var olan | Eksik olan | Ele alınışı | Bağlı olanlar | Çözülemezse |
|---|---|---|---|---|---|---|
| U-1 | **Bilinmeyen ihtiyacın keşfi:** Ajanın bilmediğini bilmemesi | İki yöntem karşılaştırması, Foundation kapsama listesi, geçmiş taraması, çerçeve incelemesi (K-1) | Hiçbir listede olmayan bir ihtiyacın bulunacağını güvenceye alan bir mekanizma; güvenilir bir ölçü | Gizli sınavlarda gömülü eksikler (C05); C07'deki gerçek görev; sonradan ortaya çıkan her kaçırılmış ihtiyaç ayrı kayıt olarak tutulur ve yetenek eksikliği analizine girer | SOUL'un temel değeri; C08 ve sonrasındaki büyük ürün işleri C07'yi bekler | DevOS çalışır ama "doğru işi bulur" iddiası kanıtın düzeyiyle sınırlandırılır; Batu'ya açıkça bildirilir |
| U-2 | **Araştırma, karar ve ürün kalitesinin ölçülmesi (doğrulayıcı darboğazı).** Karşılaştırmalı araştırmadaki bütün kaynaklar açık uçlu işlerde darboğazın model değil doğrulayıcı olduğunu söylüyor | Tuzaklı gizli sınavlar, bağımsız inceleme, Batu'nun uzman olduğu alanlarda incelemesi, ikinci model (B2) | Genel kaliteyi ölçen otomatik bir hakem | Her iş için önceden yazılan ölçütler; kör karşılaştırmalar; sonuçların sonradan izlenmesi (geri alınan kararlar, yeniden yapılan işler) | Kalite iddiaları | Kalite iddiaları kanıtın bağımsızlık düzeyiyle sınırlı kalır |
| U-3 | **Aynı model ailesinin ortak kör noktaları** | Farklı bilgi görünümleri, gizli sınavlar, ikinci model, Batu incelemesi | Batu'nun uzman olmadığı alanlarda bağımsız insan uzman | İkinci modelin yüksek etkili kararlarda kullanılması (B2) | Yüksek etkili kararlar | Bu alanlardaki kararlara "bağımsız insan doğrulaması yok" notu düşülür |
| U-4 | **Bağlam paketinin anlamca yeterliği** | Zorunlu ihtiyaç listesi, niteleyici testleri, inceleme, bilinmeyen ihtiyaç kontrolü | Paketin anlamca yeterli olduğunu otomatik ölçen bir yöntem | Örneklem denetimleri; inceleme rolünün paket eleştirisi; kaçırılan bilgi kayıtları | Bütün roller | Kaçırılan bilgi kayıtlarının oranı izlenir ve raporlanır |
| U-5 | **Kullanım sınırları altında yeterli kapasite** | Çalışma düzeni (routine yalnız oturum başlatır), bütçe tablosu, kullanım takibi, oturumların Batu'nun yoğun saatleri dışına konması | "Her işte yüksek emek" kararının Max sınırlarına sığıp sığmadığı; DevOS'un Batu'nun kendi Claude kullanımını ne kadar etkileyeceği; bulut oturumunun gerçek süresi | C06–C07'den itibaren ölçüm; C11 raporu | Hız ve kapsam | Seçenekler Batu'ya sunulur: daha yavaş ilerleme, belirli işler için ücretli kullanım, gerekçeli emek ayarı. Kalite sessizce düşürülmez |
| U-6 | **Özel içeriğin yeniden anlatılarak sızması** | Aynen kopyalama ve anlam benzerliği kontrolleri, kural, inceleme | Tamamen farklı sözcük ve yapıyla yeniden anlatılmış içeriğin güvenilir tespiti | Açık depoya yalnız kaynak kimliğiyle birlikte özet yazma zorunluluğu; düzenli örneklem denetimi | Kriter 31 | Kalan risk Batu'ya açıkça bildirilmiştir; kütüphanede gerçekten gizli kalması gereken bir bölüm varsa o bölüm ajanların erişiminden tamamen çıkarılabilir (Batu kararı) |
| U-7 | **Çerçeve körlüğü** | Öncül envanteri, sıkışma sinyali, bağımsız karşı tasarım, mekanizma varsayım envanteri (Bölüm 6.12) | Bir çerçeve körlüğünün yakalanacağını güvenceye alan bir yöntem | C00'da planın kendisine uygulanır; C07'de gözlenir; her yakalanan ya da sonradan fark edilen çerçeve hatası kaydedilir | Bütün tasarım kararları | Sonradan fark edilen her çerçeve hatası bir sistem incelemesi başlatır; oran raporlanır |

---

## 11. Batu'nun kararları

### 11.1 Verilmiş kararlar

**29 Eylül 2026 eklenenler:** K6 — `devos` açık kalır; özel içeriğin kazara açığa çıkma riski, koda dayalı ön kontrollerle azaltılmış haliyle kabul edildi. K7 — "yalnız sahte veri" kuralı kişisel ve iş verisini kapsar; DevOS'un kendi araştırma kütüphanesi ölçümlerde kullanılabilir. Kriter 32, 33 ve 34 kabul edildi. Teknik kararlar (çalışma düzeni dahil) ekip tarafından gerekçesiyle verilir. **B1 = (2):** C04 ölçümüne kadar ücretsiz plan; ölçüm sınıra yaklaşıldığını gösterirse kapsam daraltılmadan önce karar Batu'ya gelir. **B2 = (1):** Gemini API ücretsiz katmanı; yalnız açık içerik, tek geçitten. **B3 = (a):** Sistem için ayrı GitHub makine hesabı. **K8 = (a):** DevOS için yazılmış tasarım belgeleri (plan, ekler, `CLAUDE.md` ve düşünme disiplinlerinin uyarlaması) ve Batu'nun kararları ile beklentileri açık depoda durur. **K9:** DevOS'un bütün dosyaları, kayıtları ve kendi içindeki iletişimi İngilizcedir; Batu ile iletişim Türkçedir (Bölüm 0.6).

SOUL tanımı; SOUL'un açık kaynak olması; DevOS'un Claude Code cloud'da çalışması; Max 200 $ planı, ekstra kullanımın kapalı olması, ortamda Anthropic API anahtarı olmaması; Supabase'in kişisel hesapta kullanılması; depoların herkese açık olabilmesi; yeni depolar (`devos`, `soul-system`, `devos-evals`, `devos-backup`) ve eski depolara dokunulmaması; eski deneme depolarının kütüphaneye alınması; eski raporların ChatGPT tarafından arşivlenmesi ve deponun kurucu başlamadan hemen önce düzeltilmesi; tek yazar ilkesi; güvencelerin her işte tam, emek derinliğinin varsayılan olarak yüksek olması; testlerde yalnız sahte veri; telefondan kullanım; Academy notunun karar değil keşif notu olması; bu planın uyduğu ilkeler (Bölüm 0.3).

### 11.2 Verilmiş kararların seçenekleri (kayıt için)

Aşağıdaki üç karar 29 Eylül 2026'da verildi (Bölüm 11.1). Seçenekler, kararın hangi bilgiyle verildiğini göstermek için korunur.

**B1 — Supabase plan seviyesi.** Ücretsiz planın 500 MB veritabanı sınırı, kütüphanenin tamamına anlam araması uygulanırsa ilk aylarda dolabilir (Bölüm 5.3).

| Seçenek | Aylık | Kazancı | Kaybı |
|---|---|---|---|
| (1) Ücretsiz planda kalmak | 0 $ | — | Sınır dolunca anlam araması kütüphanenin bir kısmıyla sınırlı kalır; bu kriter 5 ve 11'den tavizdir |
| (2) C04'teki ölçüme kadar ücretsiz plan, sonra ölçüme göre karar | 0 $, sonra muhtemelen 25 $ | Para, gerçek boyut ölçülmeden harcanmaz. C00–C03 arasında veri küçüktür, kalite etkisi yoktur | Ölçüm sınırı aşacağını gösterirse geçiş kurulumun ortasında yapılır |
| (3) Canlı projeyi şimdi Pro'ya almak; test projesi ayrı ücretsiz bir organizasyonda | 25 $ | 8 GB veritabanı, günlük yedek, uyumayan proje; boyut kaygısı olmadan kurulum | Aylık 25 $ |

**Önerim (2), şu kuralla:** Ücretsiz plana sığmak için hiçbir kapsam daraltılmaz. C04'te ölçüm sınırın yaklaşacağını gösterirse, kapsam daraltılmadan önce karar sana gelir. Kendi tahminim, ölçümün Pro'ya geçişi gerektireceği yönünde; (3)'ü seçmen de tamamen makul.

**B2 — İkinci model ailesi (Google Gemini API ücretsiz katmanı).**

| Seçenek | Kazancı | Kaybı |
|---|---|---|
| (1) Evet | Kriter 4 gerçekten sınanır; yüksek etkili ve açık depolara girecek kararlarda farklı bir modelin görüşü ortak kör noktaları azaltır | Ücretsiz bir Google hesabı anahtarı gerekir; ücretsiz katmanda gönderilen içerik Google'ın ürün geliştirmesinde kullanılabilir. Bu yüzden yalnız sahte veri ve açık depolara girecek içerik gönderilir; özel kütüphane hiçbir zaman gönderilmez |
| (2) Ücretli bir ikinci sağlayıcı | Daha güçlü model, veri güvencesi | Kullanım başına ücret |
| (3) Hayır | — | Kriter 4 sınanamaz; ortak kör nokta riski azaltılamaz |

**Önerim (1).**

**B3 — Sistemin GitHub kimliği.** Bölüm 5.5'teki sorun.

| Seçenek | Kazancı | Kaybı |
|---|---|---|
| (a) Sistem için ayrı GitHub makine hesabı | GitHub'ın kendi onay düzeni tam çalışır; onayları telefondaki GitHub uygulamasından verirsin; özel arayüz yazılmaz | Claude'un GitHub bağlantısı makine hesabına geçer; bu, diğer Claude Code projelerini de etkiler. O projelerin depolarına makine hesabının ortak çalışan olarak eklenmesi gerekir (hazırlıkta yapılabilir) ve oradaki commit'ler de makine hesabı adına görünür |
| (b) Karar paneli | Diğer projelerin etkilenmez | Bütün onaylar özel bir sayfadan verilir; GitHub'ın kendi onay düzeni kullanılamaz; sayfanın güvenliği ve güncellenmesi ayrı bir iştir |

**Önerim (a).** Daha az özel parçayla daha güçlü bir koruma sağlıyor. Diğer projelerine etkisi tek seferlik bir ayar; AI commit'lerinin ayrı bir hesapta görünmesi o projelerde de ayırt ediciliği artırır. Ayrıca (a)'da karar issue'larını makine hesabı açtığı için bildirimler sana güvenilir biçimde ulaşır; (b)'de issue'lar senin kimliğinle açılacağından GitHub sana kendi eylemin için bildirim göndermeyebilir.

---

## 12. Batu'nun yapacakları

Zamanı gelince kurucu her birini adım adım yazar. Anahtar ve belirteç gibi gizli bilgiler hiçbir zaman sohbete yazılmaz.

**Hazırlıkta** (hazırlık planına göre): B1–B3 kararları; B3 (a) seçilirse makine hesabının açılması ve Claude'un GitHub bağlantısının ona geçirilmesi; Claude GitHub uygulamasının gereken depolara kurulması; kurucu ortamının açılması; ekstra kullanımın kapalı olduğunun kontrolü; kurucunun Supabase bağlantısının salt okuma ve tek projeyle sınırlanması; telefon uygulamaları; ChatGPT'ye düzeltme görevinin verilmesi; GitHub erişim anahtarının silinmesi; kurucunun başlatılması.

**Kurulum sırasında:**

1. **C02:** Üç çalışma ortamını açmak; her biri için Supabase panelinde kurucunun verdiği tek SQL satırını çalıştırıp çıkan belirteci ilgili ortamın ayar alanına yapıştırmak.
2. **C04:** Kütüphane aktarımı için yalnız okuma yetkili bir GitHub anahtarı oluşturup `devos-backup`'ın gizli ayarlarına girmek.
3. **C06:** Routine'leri oluşturmak; her birinden bütün connector'ları çıkarmak; yedek bütçe için API tetiği anahtarını Supabase'in gizli ayarlarına girmek.
4. **C09:** Yedek rolünün bağlantı bilgisini `devos-backup`'ın gizli ayarlarına girmek. Geri yükleme gerekirse: eski routine'leri durdurmak, yeni proje için belirteçleri yeniden üretip ortamlara, routine'lere ve GitHub kontrollerine girmek.
5. **C11 (B2 onaylanırsa):** Gemini API anahtarını oluşturup ikinci model geçidinin gizli ayarına girmek.
6. **Gerekirse:** C00 ya da C01'de çatışan bir eklenti ya da connector çıkarsa onu hesap ayarlarından kapatmak (diğer sohbetlerine etkisi sana önceden yazılır).
7. **Her zaman:** Karar listesine düşen kararlara cevap vermek; yüksek etkili değişiklikleri amaç ve risk açısından kabul etmek ya da reddetmek.
8. **C07:** Ekibin bulduğu ilk işi ve eksiklikleri amaç ve değer açısından değerlendirmek.

**Anahtar envanteri:** Kurucu C00'da tek bir envanter tutar: her anahtar ve belirteç için sahibi, durduğu yer, yetkisi ve iptal yolu (değerlerin kendisi değil). Envanterde en az şunlar bulunur: üç ortam belirteci, kurulum ortamının belirteci, CI rolünün anahtarı, içe alma rolünün anahtarı, yedek rolünün bağlantı bilgisi, kütüphane okuma anahtarı, yayın işinin `soul-system` yetkisi, routine API tetik anahtarı, (B2) Gemini anahtarı.

**Kurulumdan sonra:** Amaç ver, karar ver, kabul et.

---

## 13. Riskler

| Risk | Olası etkisi | Azaltma |
|---|---|---|
| Routines araştırma önizlemesinde; biçim ve sınırlar değişebilir | Sensiz akış bozulur | Tetik tek fonksiyonda; iş kayıtları Supabase'te; zamanlanmış yedek çalışma; değişiklik günlüğü bakım işlerince izlenir |
| Günlük routine sınırı (Max'te 15) | İş hacmi sınırlanır | Routine'ler yalnız oturum başlatır; roller oturum içinde; yedek bütçe; C01'de gerçek değer |
| Max kullanım sınırları | Hız düşer | U-5; kapasite raporu; seçenekler Batu'ya |
| Claude uygulaması bildirimleri güvenilmez olabilir | Kararlar gecikir | GitHub uygulaması birincil kanal |
| Supabase plan sınırları | Kapsam daralır | B1; C04 ölçümü; kapsam daraltılmadan önce karar |
| Oturum içindeki alt ajanlar aynı kimliği paylaşıyor | Oturum içinde gerçek yetki ayrımı yok | Yetki ayrılığı gerektiren işler ayrı ortamlarda; oturum içi ayrımlar "beyana dayalı" etiketli |
| Paralel yazan alt ajanların örtük kararları | Tutarsız ürün | Tek yazar kuralı; ortak kararlar yazmadan önce kayıtta; tek sıralı birleştirme |
| Connector'lar üzerinden kural kapısının atlanması | Veritabanına kuralsız yazım; Batu adına e-posta ya da dosya işlemi | Routine'lerden connector'ların çıkarılması; depo izin kuralları; C01 ve C03 testleri |
| DevOS'un Batu'nun kendi Claude kullanımıyla aynı sınırları paylaşması | Batu'nun işi yavaşlar ya da DevOS durur | Yoğun saatler dışına zamanlama; kullanım takibi; gerekirse karar |
| Routine'in GitHub bağlantısı koparsa 72 saat sonra kendini kapatması | Sistem sessizce durur | DevOS'tan bağımsız izleme yolu (Ek G, G7) |
| Açık depoda sızıntı (K6 kararıyla kabul edilen kalan risk) | Özel içerik görünür olur ve geri alınamayabilir | İlk yazımdan önce koda dayalı kontrol; türetilmiş içerik kuralı; ham kanıt açık depoda değil |
| Gizli depolarda (`devos-evals`, `devos-backup`) dal koruması yok (GitHub Free) | Bu depolara yazma yetkisi olan bir oturum geçmişi değiştirebilir | `devos-evals` yalnız sınav routine'ine, `devos-backup` yalnız yedek işlerine bağlı; Claude GitHub uygulaması `devos-backup`'a kurulmaz; değişiklikler git geçmişinde izlenir; gerekirse GitHub Pro kararı Batu'ya |
| Çeviri kayması (plan paketinin çevirisi ya da Batu'nun Türkçe ifadelerinin İngilizce yorumu) | Talimat ya da karar anlamı değişir | Bağımsız sadakat incelemesi; Batu'nun sözlerinin aslıyla birlikte saklanması; sunumda aslının gösterilmesi |
| Türkçe kütüphanede İngilizce arama | Kaynaklar bulunamaz | İki dilde arama; diller arası arama ölçüsü; çok dilli anlam modeli |
| Beta ve önizleme özelliklerine bağımlılık (routines, Projects, dynamic workflows) | Davranış değişebilir | Yetki anahtardan gelir, açılış yolundan değil; isteğe bağlı katmanlar zorunlu değil; değişiklikler bakım işlerince izlenir |
| Aynı model ailesinin ortak kör noktaları | İnceleme üreticinin hatasını tekrarlar | U-3; B2 |
| Platform özellikleri hızla değişiyor | Plan eskir | [C01] doğrulamaları; bakım işleri değişiklikleri izler |
| Bu planın ve ekibin çerçeve körlüğü | Yanlış öncül bütün kurulumu etkiler | Bölüm 6.12; C00 bağımsız inceleme ve karşı tasarım; C07; U-7 |
| Açık depolarda yabancıların içerik eklemesi | İçerik yoluyla talimat sokulması | Dış etkileşim kısıtı, tetik filtresi, dış içeriğin veri sayılması |
| Hesap eklentilerinin kendiliğinden yüklenmesi | Çatışan hook ya da becerilerin davranışı değiştirmesi | C01 envanteri, C00 kararı; eklenti sürümü değişince ilgili sınavlar yeniden koşulur |
| Özel içeriğin sızması | Özel konuşma ve notların açılması | Bölüm 6.7; U-6 |
| Kurucunun eski kayıtlardan etkilenmesi | Eski "sıradaki iş" ifadesini talimat sanması | ChatGPT düzeltmesi ve doğrulaması; Bölüm 0.5 uyarısı; tek yazar ilkesi |
| Araştırma deposunun yeniden eskimesi | İki sistemin bilgisi yine ayrışır | D030; DevOS'un canlı durumu yalnız Supabase'te; "güncel" iddialı yeni kayıtlar bakım işlerince işaretlenir |
| Sınava göre öğrenme | Sınavda iyileşme, gerçek işte iyileşmeme | Sınavların yenilenmesi; gerçek iş sonuçlarıyla karşılaştırma |
| Her hatayı "eksik beceri" sayma | Gereksiz mekanizma ve süreç şişmesi | Süreç sınırı; tek seferlik ile tekrarlayan hatanın ayrılması |
| Anlam modelinin Türkçe kalitesi | Arama zayıf kalır | C04 ölçüsü; birleşik arama; ölçüme göre model seçimi |
| Makine hesabına geçişin diğer projelere etkisi (B3 a) | Diğer projelerde erişim kesintisi | Hazırlıkta makine hesabının bütün ilgili depolara eklenmesi ve kontrolü |

---

## 14. Planın değişme kuralları

Plan şu durumlarda yeniden açılır: bir sıkışma sinyali çerçeve denetimi gerektirirse (Bölüm 6.12); C01'de bir satır başarısız olursa; C03'te bir kuralın aşılabildiği gösterilirse; C04'te arama ölçüsü eşiği geçemezse; C07 başarısız olursa; platform özelliği değişirse; Batu'nun bir kararı değişirse; Bölüm 10.2'deki bir sorun için daha iyi bir çözüm bulunursa.

Değişiklikler sessizce yapılmaz: eski hali, yeni hali, gerekçesi ve etkilenen aşamalar kaydedilir. Bir aşamanın kabul koşulu sonuç görüldükten sonra gevşetilemez; gevşetilmesi gerekiyorsa eski sonuç geçersiz sayılır ve sınama yeni koşulla tekrarlanır. Bir öneri, bu planda yazılmış olduğu için korunmaz; daha iyisi gösterilirse değişir.
