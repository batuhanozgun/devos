# DevOS çalışma düzeni: karşılaştırmalı araştırma

**Tarih:** 29 Eylül 2026 · **Soru:** "Ekip ofiste, denetçi ayrı" düzeni (A1 sürüm 2) sağlam bir temele mi dayanıyor, yoksa uydurma bir yapı mı? Bilinen yaklaşımlarla karşılaştırıldığında nerede uyuşuyor, nerede ayrışıyor, neyi düzeltmek gerekiyor?

**Yöntem:** Anthropic'in kendi yayınları ve ürün belgeleri, bağımsız uygulayıcı ve araştırma kaynakları ve `agentic-os-search` kütüphanesindeki çalışmalar (multi-agent-patterns, gastown, beads, hermes-agent, ecc, harness-engineering-and-evolution) incelendi. Kaynakların güncel ve birincil olmasına öncelik verildi. İkincil kaynaklar öyle belirtildi.

---

## 1. Kısa hüküm

Düzenin çekirdeği uydurma değil. Sektörde ve Anthropic'te bugün en çok doğrulanmış kalıbın bir uygulaması: **bir koordinatör + dar kapsamlı işçiler + üretimden ayrı bir değerlendirici + oturum dışında tutulan kalıcı durum + oturumlar arası yapılandırılmış devir.** Aynı kalıp, bağımsız olarak Anthropic'in uzun süreli uygulama geliştirme düzeninde, Claude Code Projects'te, Cognition'ın "gerçekten çalışan" çoklu ajan düzenlerinde ve Gas Town'da görülüyor.

Ama araştırma, düzenin **altı yerde düzeltilmesi** gerektiğini gösterdi (Bölüm 4). Bunların en önemlisi: paralel alt ajanlar yalnız okuma, araştırma ve inceleme yapmalı; bir ürünü yazan her zaman tek olmalı.

---

## 2. Karşılaştırılan yaklaşımlar

| Yaklaşım | Özü | DevOS düzeniyle ilişkisi |
|---|---|---|
| **Anthropic, "Building effective agents"** (Aralık 2024) | Beş kalıp: zincirleme, yönlendirme, paralelleştirme, koordinatör-işçi, üretici-değerlendirici. "Basit başla; karmaşıklığı yalnız sonucu gösterilebilir biçimde iyileştiriyorsa ekle." | Çalışma oturumu koordinatör-işçi; denetim ortamı üretici-değerlendirici. **Uyarı:** 18 rol ve çok sayıda kayıt ailesi, "basit başla" ilkesine karşı gerekçelendirilmeli |
| **Anthropic, çoklu ajanlı araştırma sistemi** (Haziran 2025) | Ana ajan + paralel alt ajanlar geniş araştırmada tek ajandan belirgin biçimde iyi; ama kabaca 15 kat token harcıyor. Alt ajanlara ayrıntılı görev tanımı (amaç, çıktı biçimi, kaynaklar, sınırlar) verilmeli; sonuçlar kalıcı bir yere yazılmalı ki "kulaktan kulağa" bozulma olmasın | Araştırma rolü (DR16) için doğrudan uygun. **Eksik:** alt ajan görev tanımı standardı |
| **Anthropic, uzun süreli ajanlar için düzen** (Kasım 2025) | Bir başlatıcı ajan ortamı ve iş listesini kurar; sonraki oturumlar her seferinde bir parça ilerler, temiz durumda bırakır, ilerleme dosyası ve commit'lerle devreder | DevOS'un oturum döngüsü ve kapanış disipliniyle birebir uyumlu |
| **Anthropic, uzun süreli uygulama geliştirmede düzen tasarımı** (Mart 2026) | Planlayıcı + üretici + ayrı değerlendirici. Bağlamı sıfırlayıp yapılandırılmış devir belgesiyle devam etmek, tek oturumda sıkıştırmaya güvenmekten iyi sonuç verebiliyor. **İlke:** "Düzenin her parçası, modelin tek başına yapamadığı bir şeye dair bir varsayım taşır; bu varsayımlar sınanmalı, çünkü yanlış olabilir ve model geliştikçe eskir." Yeni modelle bazı parçalar kaldırılıp düzen sadeleşmiş | Üretici-değerlendirici ayrımı uyumlu. **İki ders:** (1) çok uzun tek oturuma değil, parçalı iş + yapılandırılmış devre güvenilmeli; (2) her mekanizmanın dayandığı varsayım yazılmalı ve düzenli olarak "hâlâ gerekli mi?" diye sınanmalı. Bu, çerçeve körlüğü mekanizmasının ta kendisi |
| **Claude Code dynamic workflows** (Mayıs 2026) | Claude görev için bir yönetim betiği yazar, çok sayıda paralel alt ajan çalıştırır, her bulguyu bağımsız doğrular; ilerleme kaydedilir, kesilen iş kaldığı yerden sürer. Normal oturumdan belirgin biçimde fazla kullanım harcar | Büyük tarama işleri (kütüphane denetimi, geniş araştırma) için oturum içi bir araç adayı. Bulut oturumunda çalışıp çalışmadığı C01'de sınanmalı |
| **Claude Code Projects** (Eylül 2026) | Koordinatör konuşması + işçi oturumlar + ortak proje hafızası | Aynı kalıbın ürünleşmiş hali. Tek ortam kullandığı için yetki ayrılığını kendisi sağlamıyor; DevOS'ta yetki ayrılığı zaten ortam dışı anahtarlarla sağlanıyor |
| **Cognition, "Don't Build Multi-Agents"** (2025) ve **güncellemesi** (Nisan 2026) | Paralel yazan ajanlar birbirinden habersiz örtük kararlar verir ve ürün tutarsızlaşır. Güncelleme: işe yarayan kalıplar, **birden çok ajanın zekâ kattığı ama yazmanın tek kanaldan yapıldığı** düzenler; "tek bir ana döngü durumu taşır, alt ajanlar dar kapsamlı ve durumsuzdur" | **En önemli düzeltme kaynağı.** DevOS'ta paralel alt ajanlar yazma yapmamalı; her ürünün tek bir yazarı olmalı |
| **MAST: çoklu ajan sistemleri neden başarısız olur** (NeurIPS 2025) | 7 çerçeve ve binlerce iz üzerinde 14 başarısızlık türü, üç sınıf: tanım sorunları (~%42), ajanlar arası uyumsuzluk (~%37), doğrulama eksikliği (~%21). Çoklu ajan sistemlerinin tek ajana göre kazancı çoğu zaman küçük; başarısızlıkların çoğu model değil tasarım kaynaklı | DevOS'un mekanizmaları bu üç sınıfa karşılık vermeli (Bölüm 3). Roller varlıklarını kanıtla hak etmeli |
| **Loop engineering** (Haziran 2026'da adlandı) | Bir döngünün dört parçası: tetik, hedef, doğrulayıcı, durdurma kuralları. Üreten ile denetleyen ayrı; her döngüde üst sınır, bütçe ve "ilerleme yok" tespiti. **Açık uçlu işlerde darboğaz model değil doğrulayıcıdır** | Tetik (routine), durum (veritabanı), doğrulayıcı (denetim) var. **Eksik:** döngü başına bütçe, üst sınır ve ilerleme yok tespiti. Doğrulayıcı darboğazı, planın U-2 açık sorunuyla aynı şey |
| **Graph engineering** (2026 ortası) | İş akışını açık bir durum makinesi olarak kurmak: düğümler, geçişler, paylaşılan durum, kontrol noktaları, insan onayı için duraklamalar. "Koordinatör planlar, atar, birleştirir; her işi kendisi yapmaz." "Yalnız birbirinden bağımsız işler paralel çalışmalı" | DevOS karma bir düzen: denetim ve yetki geçişleri veritabanında belirlenimci bir durum makinesi; düğümlerin içindeki düşünme işi ajana bırakılmış. Bu ayrım bilinçli olarak korunmalı |
| **Gas Town** (kütüphane çalışması) | Aktör kimliği ile çalışan oturum ayrı ömürlerdedir; iş kaydı ile yönetim ayrı katmanlardır; birleştirme ayrı bir sıra rolüyle (Refinery) yapılır; izleyici roller (Witness, Deacon) canlılığı denetler; iş gönderimi ortam kapasitesine bağlıdır | "Rol ≠ oturum" kararını doğruluyor. Birleştirmenin tek sırada yapılması ve kapasiteye duyarlı gönderim DevOS'a uygun |
| **Hermes Agent** (kütüphane çalışması) | Zamanlanmış iş bir zincir: tanım → belirli çalıştırma → deneme → bağlamın yeniden kurulması → yürütme → teslim. Her halkanın başarısı diğerini kanıtlamaz; "tetik sayısı ≠ ajan çalışması ≠ teslim edilen rapor" | Routine çalıştırmaları için kayıt ayrımını doğruluyor (niyet, oturum, sonuç ayrı) |
| **ECC** (kütüphane çalışması) | Tek bir denetleyici değil; yöntemler, kurulum, yürütme ve kayıt parçalarının seçilen birleşimi. Bazı geçişler kod, bazıları ajanın yorumladığı yönerge | ECC'yi kurmak bir çalışma sistemi kurmak değildir. C00'daki seçici karşılaştırma doğru yaklaşım. İki bağımsız inceleyici, üretici-değerlendirici döngüsü ve döngü tasarım denetimi parçaları aday |
| **Eski `soul` deposundaki DevOS denemesi** (Ağustos 2026) | Roller: tasarımcı/üretici, araştırmacı, doğrulayıcı, karşı inceleyici, bütünleştirici, insan sahibi. "Doğrulayıcı aynı eylemde onarmaz"; doğrulama tam hedef ve sürüme bağlıdır; oturumun tek bir birincil sorumluluğu vardır | Uyumlu. "Doğrulayıcı onarmaz" kuralı denetim ortamına açıkça yazılmalı |

---

## 3. MAST başarısızlık sınıfları ve DevOS'taki karşılıkları

| Sınıf | Tipik başarısızlık | DevOS'taki karşılık | Açık kalan |
|---|---|---|---|
| **Tanım sorunları** | Görevin ya da rolün yanlış tanımlanması; role uymama; adımların tekrarı; sonlanma koşulunu bilmeme | Rol sözleşmeleri, iş kaydında amaç zinciri ve durma kuralı, gizli sınav | Döngü başına üst sınır ve ilerleme yok tespiti eksik |
| **Ajanlar arası uyumsuzluk** | Bağlam kaybı; bilgiyi aktarmama; diğer ajanın katkısını yok sayma; akıl yürütme ile eylem uyumsuzluğu; görevden sapma | Katkı ve kullanım kayıtları, ortak durum veritabanı, amaç denetimi | Paralel yazarların örtük kararları (Cognition) için tek yazar kuralı eksik |
| **Doğrulama eksikliği** | Erken bitirme; eksik ya da yanlış doğrulama | Ayrı denetim ortamı, olumsuz ve olumlu kontrol, gizli sınav | Açık uçlu işlerde güçlü bir doğrulayıcı yok (U-2) |

Bir de MAST'ın ölçmediği sınıf: **sessiz başarısızlık.** Hiçbir kontrolün kırmızı yanmadığı, ama sistemin sahibini haftalarca yanlış yönde çalıştırdığı durumlar. Buna karşı düzenli örneklem denetimi ve amaç denetimi gerekir.

---

## 4. Araştırmadan çıkan düzeltmeler

1. **Tek yazar kuralı.** Çalışma oturumunda paralel alt ajanlar yalnız okuma, araştırma, analiz ve inceleme yapar. Bir ürüne (kod, belge, tasarım) aynı anda yalnız bir yazar yazar. Birbirinden gerçekten bağımsız ürünler paralel yazılabilir, ama ortak kararlar önce açıkça yazılmış olmalı. Birleştirme tek bir sırada yapılır. (Cognition 2025–2026; graph engineering; Gas Town Refinery)
2. **Uzun oturum değil, parçalı iş ve yapılandırılmış devir.** Bir çalışma oturumu işi parçalara böler; her parça temiz bağlamlı bir alt ajana ya da bir sonraki oturuma yapılandırılmış bir devir kaydıyla geçer. Uzun bir oturumun bağlam sıkıştırmasına güvenilmez. (Anthropic, Mart 2026 ve Kasım 2025)
3. **Alt ajan görev tanımı standardı.** Her alt ajan görevi şunları taşır: amaç ve bağlı olduğu karar, beklenen çıktı biçimi, kullanılacak kaynaklar ve araçlar, sınırlar (ne yapmayacağı), emek bütçesi, sonucun yazılacağı yer. (Anthropic, Haziran 2025)
4. **Döngü denetimleri.** Her iş döngüsünün bir üst sınırı, bir bütçesi ve "ilerleme yok" tespiti vardır; tetiklenince iş durur ve kayda geçer. (Loop engineering)
5. **Mekanizma varsayım envanteri.** DevOS'un her mekanizması, modelin tek başına yapamadığı hangi şeyi telafi ettiğini yazar. Bu varsayımlar düzenli olarak ve model değiştiğinde sınanır; gereksizleşen mekanizma kaldırılır. Bu, çerçeve körlüğüne karşı mekanizmanın parçasıdır. (Anthropic, Mart 2026)
6. **Başarısızlık sınıflaması ve sessiz başarısızlık denetimi.** Her olay MAST sınıflarına göre de etiketlenir; ayrıca yeşil görünen işlerden düzenli örneklem alınıp denetlenir.

Ek olarak: **dynamic workflows** büyük tarama işleri için C01'de denenecek; **"doğrulayıcı aynı eylemde onarmaz"** kuralı denetim ortamına eklenecek.

---

## 5. Kaynakların birbiriyle çeliştiği yer ve DevOS'un tavrı

- **Anthropic** çoklu ajanın geniş araştırmada açıkça işe yaradığını söylüyor; **Cognition** paralel yazmanın kırılgan olduğunu söylüyor. İkisi çelişmiyor, farklı iş türlerinden söz ediyor: okuma ve araştırma paralelleşir, yazma paralelleşmez. DevOS bu ayrımı kural olarak alır.
- **Loop engineering** tek döngüyü, **graph engineering** açık akış şemasını öne çıkarıyor. DevOS ikisini katmanlara ayırır: yetki ve denetim geçişleri açık durum makinesi (veritabanı), düşünme işi ajan döngüsü.

---

## 6. Hâlâ açık olan

- **Doğrulayıcı darboğazı:** Araştırma ve tasarım gibi açık uçlu işlerde güçlü, otomatik bir doğrulayıcı yok. Kaynakların hepsi bunu en zor sorun olarak görüyor. DevOS'ta bağımsız denetim, gizli sınavlar, ikinci model ailesi ve Batu'nun uzman olduğu alanlardaki değerlendirmesi bu açığı daraltır ama kapatmaz (U-2).
- **Rol ve kayıt sayısı:** 18 rol ve çok sayıda kayıt ailesi, "basit başla" ilkesine karşı her biri için gerekçelendirilmeli. Roller ihtiyaç doğdukça etkinleşiyor; kayıt ailelerinin başlangıç kapsamı C00'daki bağımsız karşı tasarımda ayrıca sorgulanacak.
