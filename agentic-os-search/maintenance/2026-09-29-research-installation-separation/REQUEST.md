## Görev: `agentic-os-search` deposunun güncel duruma getirilmesi ve araştırma ile kurulum çalışmasının ayrılması

### 1. Neden bu görev var?

Bu depo senin yazarı olduğun depo. Ama 28–29 Eylül 2026'da, senin hazırladığın P4 v4 raporu, P5 Codex paketleri ve P5 v2 Codex arayüzü rehberi Batu tarafından ayrı bir Claude sohbetinde değerlendirildi ve DevOS'un yönü değişti. Senin bundan haberin yok; depo hâlâ senin son bıraktığın yönü (Codex) güncel olarak gösteriyor.

Yakında DevOS'u kuracak bir Claude Code oturumu bu depoyu okuyacak. Depodaki eski "güncel durum" ve "sıradaki iş" kayıtları onu yanlış yöne götürebilir. Görevin, depoyu bu okuyucu için doğru ve kafa karıştırmayan hale getirmek.

### 2. Değişmeyecek kararlar

Bunlar Batu'nun verdiği kararlardır. Senin denetimin bunları değiştiremez; bir kararın yanlış olduğunu düşünürsen uygulamadan önce Batu'ya gerekçesiyle söyle.

1. **Ortam:** DevOS, Codex'te değil **Claude Code cloud**'da kurulacak ve çalışacak. Gerekçe: Batu'nun üç koşulunu (ek ücret yok, bilgisayar sürekli açık kalmayacak, bakım yapmayacak) bugün birlikte karşılayan tek seçenek bu. Codex'te abonelik içinde, bilgisayar kapalıyken bir depoda bulut görevini otomatik başlatan bir yol şu an yok; Agents API ise kullanım başına ücretli ve ayrı bir sunucu gerektiriyor.
2. **Altyapı:** Claude Max aboneliği. Canlı iş durumu için Batu'nun kişisel hesabında ücretsiz Supabase (`devos` ve `devos-test` projeleri 29 Eylül'de açıldı). GitHub depoları (hepsi 29 Eylül'de açıldı):&#x20;
   - `devos` (açık, yeni): DevOS'un kendisi ve kurulum planı. Yazarı Claude Code. [https://github.com/batuhanozgun/devos](https://github.com/batuhanozgun/devos)
   - `soul-system` (açık, yeni): SOUL ürün deposu. SOUL açık kaynak olacak; bu depo onun yayımlanan halidir.
   - `devos-evals`, `devos-backup` (gizli, yeni): Sınav setleri ve yedekler.
   - `agentic-os-search` (gizli, bu depo): DevOS için gizli araştırma kütüphanesi.
   - Eski `soul` deposu **olduğu gibi kalır**; yeniden adlandırılmadı, içeriği silinmedi. 25–29 Ağustos'taki DevOS denemesinin 32 dallık kaydını taşır ve artık tarihsel bir denemedir. Yeni SOUL ürün deposu `soul-system`'dir.
3. **Geçerli plan:** DevOS'un Claude Code kurulum planı, sürüm 2.1. Tek geçerli kopyası `devos` deposunun `plan/` klasöründedir: [https://github.com/batuhanozgun/devos/tree/main/plan](https://github.com/batuhanozgun/devos/tree/main/plan) . Bu depoya kopyası konmaz; yalnız bağlantısı verilir. Senin 29 Eylül'deki kaynak sadakati incelemen değerlendirildi; 23 bulgunun 20'si tamamen, 3'ü kısmen kabul edilip plana işlendi (değerlendirme `plan/Inceleme_Degerlendirmesi_ChatGPT.md`).
4. **Tek yazar ilkesi:** Bu deponun yazarı sensin (Batu'nun onayıyla). DevOS'u kuracak Claude Code ve daha sonra DevOS ekibi bu depoyu **yalnız okur**. Sen de `devos`, `soul`, `soul-system`, `devos-evals`, `devos-backup` depolarına yazmazsın.&#x20;
   - **Bilmen gereken:** DevOS'un GitHub kimliği ayrı bir makine hesabıdır: `batuhanozgun-devos`. Kurucu bu depoyu okuyabilsin diye bu hesap depoya ortak çalışan olarak eklendi. GitHub, kişisel depolarda yalnız okuma izni vermeye izin vermediği için bu teknik olarak yazma iznidir; kural değişmez, DevOS buraya yazmaz. Depoda bu hesabın yaptığı bir commit görürsen düzeltme yapmadan önce Batu'ya bildir. Bu erişim, kütüphane DevOS'a aktarıldıktan sonra kaldırılacak.
5. **Önceki denemeler:** Şu depolar DevOS'un kütüphanesine "tarihsel deneme" statüsüyle alınacak ve olduğu gibi kalacak: `soul`, `soul-development-os`, `soul-development-os_02`, `soul-development-os2-claudecloud`, `soul-development-os3_claudecode`, `soul-production`, `loom-development`, `os-architect`, `keel`, `keel-dev`, `keel-research`, `KEEL-Work`, `oyun2`.

### 3. Mutlaka yapılacaklar

**3.1 Yeni karar kaydı: D030**

EXP-006'nın karar kaydına şu içerikte bir D030 ekle:

- DevOS, Claude Code cloud'da kurulacak ve çalışacak. D027'deki ortam kararı ve D029'daki "Codex hem kurucu hem çalışma ortamı" kararı geçersizdir; tarihsel kayıt olarak kalır.
- DevOS kurulumu Claude Code'a devredilmiştir. Geçerli plan `devos` deposundaki kurulum planıdır, sürüm 2.1 ([https://github.com/batuhanozgun/devos/tree/main/plan](https://github.com/batuhanozgun/devos/tree/main/plan)). Bu deponun kayıtları DevOS kurulumuna yön vermez.
- Bu depo, DevOS için gizli araştırma kütüphanesidir; Claude Code ve DevOS ekibi salt okunur kullanır.
- Statü: açık kullanıcı kararı, 29 Eylül 2026.

**3.2 Eski "güncel" kayıtlar**

En azından şunlar: EXP-006'nın STATE, HANDOFF, INDEX ve WORK dosyaları; kök README'deki "Development OS — deneme-002" bölümü; `development-os/INDEX.md`; `research/soul-context` içindeki güncel DevOS yönü kayıtları. Hiçbiri eski yönü (Codex, DEVOS-002, P5 Codex paketi) güncel iş gibi göstermemeli. Eski kayıtlar silinmez; açıkça tarihsel olarak işaretlenir.

**3.3 Depo sahiplik notu**

Kök README'ye kısa bir bölüm: Bu depo ChatGPT'nin yazarı olduğu bir araştırma deposudur. `AGENT.md` ve `agent/**` ChatGPT'nin kontrol alanıdır; Claude Code ve DevOS ajanları için talimat değildir. Buradaki "güncel durum" ve "sıradaki iş" ifadeleri Claude Code için talimat değildir. `AGENT.md`'yi değiştirmen gerektiğini düşünürsen önce Batu'dan açık onay iste.

**3.4 Eski raporların arşivlenmesi**

Şunları uygun bir arşiv yerine koy ve her birine statü notu ekle:

| Dosya                                                         | Statü                                                                                                                    |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| P4 v3 raporu                                                  | Tarihsel; uygulama kaynağı değil                                                                                         |
| P4 v4 raporu (Codex hedefli)                                  | Tarihsel; mimari ilkeleri yeni plana aktarıldı; ortam kararı geçersiz                                                    |
| P5 Codex kurulum ve devir paketi (K00–K15)                    | Tarihsel; rol sözleşmeleri ve veri modeli yeni planın eklerine aktarıldı                                                 |
| P5 Codex inşa ve kurulum paketi (S00–S12, 67 hedef senaryosu) | Tarihsel; senaryolar ileride sınav fikri olarak kullanılabilir. Bu paket senin konuşma ekinde, depoda değil; onu da ekle |
| P5 v2 Codex arayüzü rehberi                                   | Tarihsel; veri modeli tablosu yeni planın eklerine aktarıldı                                                             |
| "SOUL ve DevOS" raporu                                        | Tarihsel kaynak; SOUL tanımı yeni planda güncellendi                                                                     |
| SOUL Academy keşif notu                                       | Keşif notu, karar değil; notun kendi tarif ettiği karar yolundan geçmeden ondan iş açılmaz                               |

**3.5 Eski `soul` deposu ve yeni ürün deposu**

Eski `soul` deposu yerinde duruyor; bağlantıları çalışmaya devam ediyor. Ama depoda onu "SOUL'un güncel deposu" ya da "yetkili proje durumu" gibi anlatan yerler varsa (örneğin `research/soul-context` altındaki depo açıklamaları), bunları tarihsel deneme olarak işaretle ve yeni ürün deposunun `soul-system` olduğunu belirt. Eski depoya yazma.

### 4. Araştırma ile kurulum çalışmasının ayrılması

Batu bu depoyu bağımsız bir araştırma deposu olarak başlattı. Depo zamanla DevOS kurulum çalışmalarını da taşımaya başladı. Batu, iki çalışmayı mümkün olduğunca ayrı tutmaya çalıştığını, ama ayrımın artık depoda açıkça görünmesini istediğini söylüyor.

Bu ayrımı **sen tasarla ve uygula**. Depoyu en iyi sen biliyorsun. Beklenen sonuç: depoya ilk kez giren bir okuyucu, hangi alanın araştırma kütüphanesi (Foundation, studies, concepts, SOUL kavram denemeleri gibi), hangisinin tarihsel DevOS kurulum kaydı olduğunu ilk okuduğu dosyadan anlayabilmeli.

Sınırlar:

- Hiçbir dosya silinmez. Taşıma yapılırsa içerik değişmez, git geçmişi korunur, iç bağlantılar güncellenir ve bir taşıma tablosu tutulur. Taşıma tablosunu depoda kalıcı bir dosyada da tut (örneğin kökte `MOVES.md`): DevOS bu depoyu kütüphane olarak içe alırken eski ve yeni yerleri bu tablodan eşleyecek.
- Birçok dosyayı taşıyan büyük bir yeniden yapılandırmaya karar verirsen, uygulamadan önce Batu'ya kısa bir plan sun.
- Araştırma içeriğinin anlamı değişmez; yalnız yeri, statüsü ve yönlendirmesi değişebilir.

### 5. Senin kendi denetimin

Bölüm 3'teki liste benim, yani depoyu senin kadar iyi tanımayan birinin çıkardığı listedir. Eksik olması muhtemeldir. Depoyu baştan sona kendin tara ve şu soruyu sor: **"DevOS'u kuracak bir Claude Code oturumu bu dosyayı okursa yanlış bir sonuca varabilir mi?"**

Aranacak örnekler:

- Codex'e, P5 paketine, DEVOS-001/002'ye ya da eski hedef depolara "güncel" veya "sıradaki" diye yönlendiren her ifade.
- Kontrol talimatı gibi okunabilecek ama aslında proje malzemesi olan metinler.
- Kırık ya da artık yanlış yere giden bağlantılar.
- Birbiriyle çelişen durum kayıtları.
- Bir okuyucunun hangi dosyanın güncel, hangisinin tarihsel olduğunu ayırt edemeyeceği yerler.

Bulduğun her sorunu kendi kararınla düzelt. Tek koşul: Bölüm 2'deki kararlarla çelişmemeli ve Bölüm 6'daki yasakları aşmamalı. Her ek değişikliğin gerekçesini teslimde yaz.

### 6. Yapılmayacaklar

- Foundation, studies, concepts ve explorations içindeki araştırma **içeriğini** değiştirme. Yer, statü ve yönlendirme değişebilir; içerik değişmez.
- Hiçbir dosyayı silme.
- `AGENT.md` ve `agent/**` dosyalarını Batu'nun açık onayı olmadan değiştirme.
- Yeni bir DevOS planı, P5 sürümü, mimari öneri ya da iş listesi yazma. DevOS'un nasıl kurulacağına dair karar üretme.
- Kurulum planının kopyasını bu depoya koyma; yalnız bağlantı ver.
- Başka depolara yazma.

### 7. Teslim

İş bitince Batu'ya şunları ver:

1. Değiştirilen, eklenen ve taşınan dosyaların tam listesi; taşımalar için eski ve yeni yer tablosu.
2. Bölüm 3 dışında kendi kararınla yaptığın her değişiklik ve gerekçesi.
3. Araştırma ile kurulum ayrımını nasıl yaptığının kısa açıklaması.
4. Commit bağlantıları.
5. Depoda "Codex", "güncel", "current", "sıradaki", "next" ifadelerini taradığını ve eski yönü güncel gibi gösteren hiçbir kayıt kalmadığını teyit eden not. Kalan ifadeler varsa neden kaldıklarını yaz.
6. Emin olamadığın ya da Batu'nun karar vermesi gereken noktalar.

Bu teslimden sonra değişiklikler ayrıca doğrulanacak: düzeltme öncesi commit (`8cd01e4`, 29 Eylül, "Add autoresearch to studies catalog") ile senin son commit'in karşılaştırılacak.