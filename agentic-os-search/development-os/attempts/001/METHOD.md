> **29 Eylül 2026 — DEVOS-001'in tarihsel çalışma yöntemi; etkin kontrol veya güncel iş sırası değildir.** Aşağıdaki tasarım turları, Foundation okuma paylaşımı ve R-006 devri eski denemenin yöntemidir. Araştırma kullanımına ilişkin dersler kaynak olarak kalır; eski yöntemin varlığı onu yeni kurulumun yöntemi yapmaz.
>
> Güncel yetki/statü [D030](../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır. DevOS'un tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devir sürümü 2.1, ortamı Claude Code cloud'dur. Claude Code ve DevOS bu depoyu yalnız okur. ChatGPT'nin bakım devamı [REPOSITORY-TRANSITION](../../../REPOSITORY-TRANSITION.md)'dadır; aşağıdaki “Yeni oturum” rotası tarihsel inceleme içindir.

---

# DEVOS-001 — tasarım ve ihtiyaç odaklı kaynak kullanımı

**Sürüm:** 2 / 24 Eylül 2026. Bu denemenin çalışma yöntemi; agent-control veya seçilmiş mimari değil.
[Amaç/yeni kullanıcı sözü](BRIEF.md) · [Güncel iş](WORK.md) · [Okuma kapsamı](reading/COVERAGE.md).

## 1. Esas değişiklik

Foundation'ın bütün dosyalarını yeniden okumak tasarımın önkoşulu değildir. Kullanıcı bütünsel çalışma düzeni tasarımına geçilmesini, Foundation'ın gerektiğinde drill-down ile kullanılmasını istedi. Önceki P1→P2→P3 sırasının tasarıma giriş kapısı bu kapsamda kaldırıldı. Okuma durumları geriye dönük TAM yapılmaz.

Kaynak yaklaşımı: Foundation [REUSE](../../../research/soul-foundations/08_foundation-sufficiency-reuse-review/REUSE.md) sorudan ilgili araştırmaya, oradan hedefte gerekçeli seçime gider. Genel sonuçlar başlangıç verir; gerekli ayrıntıyı garanti etmez. Önceki yazarlık bugünkü doğru hatırlama veya karar yeterliği sayılmaz.

## 2. Bütünsel tasarım nesnesi

Bir dosya veya kontrol değil, Development OS'u üretecek çalışma düzeni tasarlanır. Şu sorular birlikte ele alınır:

| Yön | Tasarımda cevaplanacak soru |
|---|---|
| Work | Hedef nasıl açılır; eksik işler/önkoşullar nasıl keşfedilir; işler nasıl planlanır, önceliklenir, sahiplenilir, yürütülür, değerlendirilir ve geri açılır? |
| Actors | Hangi sorumluluk ve uzmanlık gerekir; işi kim devralır; yetki, yeterlik, kapasite, koordinasyon ve devir nasıl işler? |
| Information | Hangi bilgi gerekir; kaynak nasıl bulunur, anlamı korunur, doğru işe/aktöre hazırlanır ve yeni bilgiyle revize edilir? |
| Environment | Bu iş hangi gerçek ortamda, hangi araç/erişim/kapasite ve kalıcılıkla yapılabilir; eksik kabiliyet nasıl sağlanır? |
| Birlikte işleyiş | Bu koşullar aynı işte nasıl birleşir; karar uygulamaya, sonuç değerlendirmeye ve sonraki işe nasıl döner? |

Bunlar dört zorunlu servis, klasör veya ajan değildir. Örnek sistemler önce kendi bütünü içinde anlaşılır. Mevcut Claude dosyaları, E19 veya M1–M3 varsayılan mimari olmaz.

## 3. Her tasarım turu

1. Bütün yapı içindeki mevcut tasarım sorusunu ve beklenen değişikliği seç. Son mesajdaki küçük kusur otomatik sıradaki iş olmaz.
2. Güncel genel çerçeveyi, kapsam haritasını ve ilgili studies/explorations kayıtlarını kullan. Başka alanlardan eksik fikir gelip gelmediğini de kontrol et; yalnız seçilmiş çözümü doğrulayan kaynak arama.
3. Kararı etkileyen belirsizlik, kaynaklar arası çatışma, ayrıntılı mekanizma veya doğruluk iddiası varsa özgün Foundation/study metnine gerekli derinlikte in. Drill-down yalnız arıza olduktan sonra değil, yük taşıyan seçimden önce yapılır. Gereken metnin tam okunması atlanmaz; bütün arşiv otomatik yüklenmez.
4. Gereksinim, alternatif, mekanizma adayı ve eksik hedef kanıtını ayır. Kullanılacak dış ürünün güncel davranışı önemliyse kendi birincil kaynağını ayrıca doğrula.
5. Kaynak/versiyon, çıkarılan anlam, etkilediği tasarım kararı, sınır ve geri dönüşü mevcut kayda yaz. Eski kaynak kaydını yeniden uzun uzun üretme. Gerçek okunmuş aralık ve okuyucu COVERAGE'de doğru kalsın.
6. Turun çıktısı bütünsel tasarımın bir ilerlemesi olsun: sorumluluk, iş akışı, bilgi/ortam bağı, alternatif karşılaştırması veya somut karar. Yeni genel yöntem, test projesi veya özet külliyatı açmak varsayılan çıktı değildir.

## 4. Kayıtlar ve paralel çalışma

Mevcut F00/F08/ek ile Claude'un paket/birim kayıtları korunur. Bunların kapsamlı ortak değerlendirilmesi iptal edilmedi; tasarımın başlaması bütün Foundation dosyalarının yeni bir kez okunmasına bağlanmıyor. Kayıtları okuma ve karşılaştırma turlar boyunca tasarımla birlikte yürür. Paket yönlendirmesini okumak tüm birim kayıtlarının tam okuması değildir.

Studies/concepts ve E23'teki soul-context/publications/explorations işlerinin tamamlanma ve erişim açıkları hedefteki gerçek kayıtlarla takip edilir. Devam eden okumalar kaybedilmez. Salt eski sırayı yetiştirmek için yeni bir toplu Foundation okuma kampanyası başlatılmaz. Research ve Claude, ihtiyaç duyulan kaynak sorusunu ve paylaşımı kendi aralarında çözer.

## 5. Tasarım çıktısı ve karar koşulu

Beklenen çıktı, Development OS'u kurma talebinin başlangıcından araştırma, karar, uygulama, değerlendirme, kesinti ve yeniden planlamaya kadar nasıl yürütüleceğini gösteren bütünsel çalışma modeli ve gerekçeli seçeneklerdir. Yalnız dikkat listesi ya da dosya ağacı değildir. Roller, işler, bilgi akışları, gerçek ortam, devir ve karar yetkileri aynı yürüyüşte görünür olmalı.

Nihai seçim için seçimi taşıyan kaynak ve alternatifler gerçekten incelenmiş, ilgili kayıtların anlam/kanıt sınırı korunmuş, ortam gereksinimleri ile bilinmeyenler açık olmalı. 'Bütün dosyalar okundu' da 'bunları ben yazmıştım' da tek başına seçim gerekçesi değildir. Uygulama için gerekli plan ve yetki ayrıca ele alınır.

## 6. Devam ve tarihçe

Yeni oturum: BRIEF → WORK → bu METHOD → COVERAGE → aktif tasarım sorusunun kaydı/kaynağı. Eski `01_verticals'ı sırayla bitir` devamı artık aktif görev değildir. Foundation kaynaklarının değişen sürümleri karar etkisine göre kontrol edilir; kaynak tabanı `dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb` envanter kimliği olarak korunur.

[V1 tam okuma/çıkarım yöntemi](https://github.com/batuhanozgun/agentic-os-search/blob/3c809d9691643b6183bc035cd344f12efb3f4c87/development-os/attempts/001/METHOD.md) tarihsel kalır. Kaynak, yorum, yeni yerel deney, okuyucu kimliği ve gerçek okuma aralığını ayırma disiplini korunur; V1'in seri giriş kapısı uygulanmaz. R-001–R-005 değiştirilmez; yeni yön R-006 ile aktarılır.
