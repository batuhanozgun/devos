> **29 Eylül 2026 — tarihsel rapor teslim kaydı; güncel kurulum talimatı değildir.** Aşağıdaki v2 önerileri, hedef seçimleri ve sonraki iş ifadeleri kendi dönemine aittir. DevOS'un bugünkü kurulum ve çalışma ortamı Claude Code cloud; tek geçerli kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır (devir sürümü 2.1). Eski Claude tasarımının aynı ortam adını taşıması onu yeniden etkinleştirmez.
>
> [D030](../DECISIONS.md#d030--claude-code-cloud-kurulum-devri) yetki/statü geçişini, [depo bakım planı](../../../REPOSITORY-TRANSITION.md) ChatGPT'nin bu depodaki devamını taşır. Claude Code ve DevOS bu depoyu yalnız okur. Özgün metin, kaynak kimlikleri ve kanıt sınırları aşağıda değiştirilmeden korunur; bu not yeni mimari kabulü, yeniden test veya arşiv erişimi doğrulaması değildir.

---

# P4-02 — SOUL'dan türetilmiş DevOS raporu, ikinci yazım

**Tarih:** 27 Eylül 2026. **Statü:** RAPOR TESLİMATI HAZIR / YENİ MİMARİ ÖNERİ / HEDEFTE KURULMADI.
**Üst iş:** [WORK/P4](../WORK.md). **Araştırma tabanı:** `e3856a4760d74feab1b702023e5573ec6fe10f0b`.

## 1. Yetki ve neden yeniden yazıldı?

Kullanıcı önce 200 sayfalık bütünleşik rapor istedi. İlk rapor konuşmada teslim edildi; repository'ye raporun tamamı yüklenmedi. Ardından memory, context engineering, graph engineering ve harness üzerine konuşuldu. Assistant'ın graph ihtiyacını önce eksiklik, sonra yalnız seçenek diye değişken biçimde anlatması kullanıcıda diğer tasarım tercihlerinin de yetersiz tutulduğu kaygısını doğurdu.

Son açık kullanıcı yönü: raporu yüzeysel tarayıp küçük düzeltmeler yapmak değil, **SOUL'un ne olacağına göre DevOS'un nasıl olması gerektiğini baştan türetmek ve raporu yeniden yazmak**. Bu yeniden yazım yetkisidir; belirli bir veritabanı, topoloji veya tüm yeni mimari tercihlerinin kullanıcı kabulü değildir. Gereksiz karmaşıklığı otomatik üstün sayma yetkisi de değildir.

Eski 200 sayfanın tamamı sıralı okundu. Yeni metin eski rapora graph eki değildir; gereksinim, mimari, rol, iş, bilgi, bağlam, ilişki, kontrol, yayın, kurtarma ve değerlendirme bölümleri yeniden kurulmuştur. Eski rapordaki her hükmün yanlış veya yüzeysel olduğu iddia edilmez.

## 2. Teslim edilen artefaktlar ve erişim sınırı

| Artefakt | Kimlik |
|---|---|
| `EXP-006_DevOS_SOUL_Odakli_Mimari_v2_200_Sayfa.pdf` | Tam 200 sayfa; SHA-256 `b330c0f4f930b9ad303259ed6be84d85310e6576e58b14a729d3109f34544748` |
| `EXP-006_DevOS_v2_Kaynak_Paketi.zip` | 23 dosya; SHA-256 `11856f6804fbb065bdecdf20d7a7193231cbf34fd6d5781bc0a7ebc5849a7acd` |
| ZIP içindeki `source/DevOS_v2.md` | Tek düzenlenebilir rapor gövdesi; SHA-256 `45259ee104d31bffbbb1b83fc59b24aa308d1032cf1d8160373525174f68b8f3` |

**Dosyaların evi bu konuşmanın teslim ekleridir. Bu repository kaydı PDF/ZIP'nin kendisi değildir.** Binary dosyalar veya 200 sayfalık Markdown gövdesi bu commit ile GitHub'a yüklenmedi. Hash bir erişim yolu veya tam metin yerine geçmez. Başka oturumda ayrıntılı rapor çalışılacaksa eklerin gerçek dosyası recover edilmeli; erişilemiyorsa kullanıcıdan bu isimli kaynak ZIP/PDF istenmelidir. Bu özetten eksik bölümler yeniden uydurulmaz.

Kaynak paketi: rapor Markdown'ı, 52 kaynaklık katalog, PDF üreticisi, PostgreSQL DDL taslağı, graph/API/context sözleşmeleri, doldurulmuş context örneği, Python/SQLite referans modeli ve gerçek QA çıktıları. Font dosyası içermez.

## 3. SOUL hedefinden çıkan yeni mimari öneri

SOUL yalnız yazılım görevi yapan bir ajan değil; gerekli işi keşfetmesi, işe özgü çalışma sistemi oluşturması, araştırmayı kullanması, uzun/bileşik çıktıları değerlendirmesi ve yöntemlerini gerekçeli biçimde uyarlaması hedeflenen yapıdır. DevOS bunları geliştirecek ve sınayacak kapasiteye göre tasarlanır. Gerçek SOUL backlog'u bu raporda assistant tarafından seçilmez.

Yeni yazımın başlıca önerileri:

- **Bilişsel ekip ile mekanik kontrol ayrımı:** Claude cloud'da işbirliği; kimlik, yetki, kayıt geçişleri ve publication için korunan deterministik hizmetler. Rol talimatı yaptırım değildir.
- **Takım ağırlıklı işbirliği profili:** Süren G koordinasyonu ve uzman etkileşimleri için takım; odaklı görevler için hedefte desteklendiği gösterilen alt ajan yolları. Eski alt-ajan başlangıç tercihi ayrıcalıklı tutulmadı. Gerçek cloud yeterliği hâlâ koşuldur.
- **Nesne bazlı veri otoritesi:** PostgreSQL canlı Work/Request/assignment/review/grant/publication ve typed relation kayıtlarının otoritesi; Git ürün ile yayımlanmış rol/yöntem/politika içeriklerinin sürüm otoritesi; hash'li kaynak/kanıt gövdeleri ayrı korunur. Markdown çalışma görünümleri türetilmiştir. Aynı nesne için bağımsız iki yazma otoritesi kurulmaz.
- **Birinci sınıf graph engineering:** Türlendirilmiş nesne/ilişki, revision ve scope bağları, ALL/ANY destek grupları, invariant'lar, readiness/provenance/impact/context sorguları, transaction ve concurrency kuralları. Yalnız büyük veri olursa düşünülecek eklenti değildir. Graph traversal bilinmeyen ilişkileri keşfetmiş veya etkilenen her kararı otomatik yanlışlamış sayılmaz.
- **Memory ve context engineering:** Kabul/güncelleme/arşiv/yeniden kullanım yaşam döngüsü; exact/lexical/semantic/graph birleşik erişim; kullanım yükümlülüklerinden context paketi derleme, manifest, gerçek dispatch, kullanım ve yenileme. Token azaltma gerekli bilgiyi çıkarmak için gerekçe değildir.
- **Korunan yayın ve recovery:** Shared Claude VM dışında scoped publisher; read-set ve revision denetimi, claim generation/fencing, transactional outbox/inbox, idempotency ve DB–Git uzlaştırması. DB ve Git tek atomik transaction değildir.
- **G/Y ve içerik–düzen sınırı korunur:** 16 ilk sözleşme G/Y farkıyla 18 hedef profili olarak açıklanır; bu 18 sürekli çalışan agent değildir. DR07 bakım yapar, domain doğruluğunu sahiplenmez.
- **Değerlendirme programı genişletildi:** Mekanik testlerin yanında ipucusuz iş keşfi, context yeterliği, ortak körlük, uzun eser/bütünleşme ve yöntem aktarımı sınanır. Düzgün kayıt veya geçen unit test SOUL yeterliği değildir.

**Güvenlik sınırı:** Aynı cloud runtime'ında paylaşılan credential varsa, ayrı agent adlarını bağımsız güvenlik principal'ı saymayız. Host tarafından gösterilmiş kimlik bağlama yoksa tek RuntimePrincipal sınırı kabul edilir. Yüksek etkili kontrol/politika değişimi için ayrı güvenilir doğrulama/owner yolu gerekir; rutin bütün katkılar insan kapısına çevrilmez.

## 4. Gerçek test ve belge kontrolü

**Çalıştırıldı:** Yerel Python/SQLite referans modelinde 40 adlandırılmış test geçti. Bir test 27 üçlü girdi üzerinde ALL/ANY modlarını ayrı sonlu oracle ile karşılaştırır. Birinde sekiz SQLite bağlantısı yarışında tek claim kazananı gözlendi. Hard-cycle, read-set, assignment generation ve context-hash kontrolleri ayrı ayrı kaldırıldığında dört ilgili test de hata yakaladı.

**Sınır:** Aynı yazarın model ve testleri; bağımsız doğrulama değildir. PostgreSQL DDL, Claude cloud, HTTP/MCP kimlik doğrulaması, gerçek Git yayını/timeout, sandbox, üretim restore, büyük graph benchmark ve bilişsel görev kalitesi test edilmedi. Referans modelde principal ve external observation fixture girdileridir. Kod üretim güvenlik sistemi değildir.

**PDF kontrolü:** 200 sayfa, 52 kaynak, 180 kaynak referansı, 214 yer imi ve 248 bağlantı. Metin sınırı/eksik karakter/kaynak kimliği/iç link kontrolleri geçti. Bütün sayfalar temas sayfalarında ve seçilmiş yoğun sayfalar yüksek çözünürlükte görsel kontrol edildi. Bu belge düzeni kontrolüdür; tüm teknik iddiaların bağımsız ispatı değildir.

## 5. Kaynak ve önceki çalışma bağı

P1–P4-01, ACTORS ve kabul edilmiş D001–D022 sınırları provenance olarak korundu. SOUL hedefi için EXP-002 konsolidasyonu, EXP-004 MS01 ve G01–G07 açıklıkları, EXP-006 Context; Foundation Work/Actors/Information/Revision/Reuse; ilgili studies ve güncel birincil teknik belgeler kullanıldı. Tam kaynak/okuma kapsamı rapor s.195–200 ve `source/catalog.json` içindedir. Bütün repository veya tüm dış literatür yeniden tam okundu iddiası yoktur.

[P4-01](P4-01-cloud-runtime-and-workspace-design.md) artık **önceki teknik baseline**'dır. Ana alt-ajan tercihi, Git'in canlı iş kayıtlarını taşıması ve izin matrisi üzerinden devam yönü yeni raporun yerine current kabul edilmez. P2/P3 kavramsal sonuçları korunur; yeni fiziksel bağlama için v2 gerekir.

## 6. Current devam ve yetki

**Bu turun teslimatı:** Yeniden yazılmış 200 sayfalık rapor, kaynaklar/sözleşmeler ve sınırlı gerçek test paketi. Rapor hazırdır; mimari veya hedef sistem kabul edilmiş değildir.

**Sonraki mantıksal iş:** Kullanıcı v2'yi değerlendirdikten sonra rapordaki uygulama/qualification programını gerçek hedef repo, cloud erişimi ve dış kontrol hizmeti koşullarına bağlamak. Eski P4-01'in izin-matrisi next'ine sessiz geri dönülmez. Yeni genel kontrol döngüsü de gerekçesiz açılmaz.

P4 mimari değerlendirme aşamasında kalır. P5 gerçek DevOS kurulumu ve P6 hedef kabulü yapılmadı. Bu metnin GitHub'a kaydı da önerilen DevOS publication mekanizmasının testi değildir.
