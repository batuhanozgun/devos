# EXP-001 → EXP-002 — Toplu okuma ve sonraki konuşmaya devir

**Amaç:** Kullanıcının EXP-002 U005/U019'da istediği birikimli okumayı mümkün kılmak. Bu belge proje-work retrieval rehberidir; agent-control, araştırma yetkisi veya Development OS başlatma mesajı değildir.

**Seri durumu:** EXP-001 ve EXP-002 kendi kaynaklarıyla ayrı paketlerdir. EXP-002 `builds_on` EXP-001; yeni görüşler eskilerin içine işlenmez. Yeni bir EXP, devralma/sorgulama/düzeltme ilişkisini kendi kaydında gösterir.

## 1. Önce hangi tür okuma istendiğini ayır

Bir konu hatırlanacaksa kütüphane [CATALOG](../../CATALOG.md) ve paket TOPIC-MAP yeterli giriş olabilir. Kullanıcı iki konuşmayı **baştan sona tam okumayı** istiyorsa katalog, konsolidasyon veya bu devir metni tek başına yeterli değildir. Aşağıdaki kaynak diyalog sırası o görev içindir.

## 2. EXP-001'i kendi sırasıyla oku

Başlangıç: [EXP-001 INDEX](../../EXP-001-soul-calisma-modeli/INDEX.md) ve [STATE](../../EXP-001-soul-calisma-modeli/STATE.md). Bunlar arşiv kapsamı ve epistemik sınırı verir.

Ardından [EXP-001 kaynak diyalog INDEX'i](../../EXP-001-soul-calisma-modeli/sources/conversation/INDEX.md): U001/S001 → U002/S002 → … → U018/S018 → U019. Kullanıcı metinleri [USER-MESSAGES](../../EXP-001-soul-calisma-modeli/sources/conversation/USER-MESSAGES.md), 18 assistant yanıtı `assistant/S001.md`–`S018.md` içindedir. Bu kesim 19 kullanıcı + 18 assistant mesajıdır.

Sonra [LEARNINGS](../../EXP-001-soul-calisma-modeli/reflections/LEARNINGS.md), [EVOLUTION](../../EXP-001-soul-calisma-modeli/reflections/EVOLUTION.md), [OPEN-QUESTIONS](../../EXP-001-soul-calisma-modeli/reflections/OPEN-QUESTIONS.md) kaynak sonrası okunur. Böylece arşiv yorumunun konuşmayı nasıl türettiği görülebilir.

**Eser derinliği:** Diyaloğun tamamını okumak, ayrıca bütün eserleri tam incelemekle aynı değildir. Eserler görev için yük taşıyorsa [eser INDEX'inden](../../EXP-001-soul-calisma-modeli/artifacts/INDEX.md) özgün konsolidasyon Markdown'ına ve Atlas'ın incelenebilir kaynak/model dosyalarına gidilir. Konsolidasyon uzmanlık sürekliliğine kadarki kesittir; Atlas sonrası yaşayan plan tartışmasını içerdiği varsayılmaz. PDF/HTML/ZIP veya çizim okunmadıysa okunmuş diye işaretlenmez.

## 3. EXP-002'yi kendi sırasıyla oku

[EXP-002 INDEX](../INDEX.md) / [STATE](../STATE.md) → [kaynak diyalog INDEX'i](../sources/conversation/INDEX.md). Yine U001/S001 → … → U018/S018 → U019 sırası izlenir. Burada da 19 kullanıcı + 18 assistant kaynak mesajı vardır.

İki paket toplam **74 kaynak mesajı** içerir. Paketler aynı U/S kimliklerini kullandığı için atıflar `EXP-001/U011` ve `EXP-002/U012` gibi paketle birlikte düşünülür. Tool logları ve sonradan yapılan yayın işlemleri bu sayıya dahil değildir.

Kaynaklardan sonra [konsolidasyon](../artifacts/CONSOLIDATION.md), [LEARNINGS](../reflections/LEARNINGS.md), [EVOLUTION](../reflections/EVOLUTION.md), [TERMS](../reflections/TERMS.md), [OPEN-QUESTIONS](../reflections/OPEN-QUESTIONS.md) ve [QUALIFICATIONS](../reflections/QUALIFICATIONS.md) okunabilir. QUALIFICATIONS, geçmişte kullanıcı tarafından kabul edilmiş ilave metin değildir; arşivleme sırasında eklenmiş eleştirel nottur.

## 4. İki denemenin bağını yeniden kur

[PREDECESSOR-EXP001](../sources/PREDECESSOR-EXP001.md) devralma haritasını verir. Özellikle şu izler karşılaştırılabilir:

- EXP-001 uzmanlık sürekliliği/mesleki standart → EXP-002 ortak entelektüel taban ve rol profili.
- EXP-001 C ↔ plan ↔ Work → EXP-002 ilk sistemin de anlamaya katılması ve ihtiyaçla yeniden düzenlenmesi.
- EXP-001 dosya/aktarım/kullanım ayrımı → EXP-002 araştırmanın varlığı ile kullanma eğilimi ayrımı.
- EXP-002 rol amacı + uzmanlık + ortak taban → ileride değerlendirilecek aktör hazırlığı düşüncesi.
- EXP-002 Development OS bootstrap ilişkisi → sohbetin gerçek geliştirme düzenine hazırlık olması.

Tekrarlanan görüşün kanıtı artmış sayılmaz. Yeni karşı örnek eski kaynağı silmez; yeni EXP'de gerekçeli `questions`, `revises` veya `contrasts_with` bağıyla korunabilir.

## 5. Okumadan sonra ne devredilir?

Devralınabilir malzeme; mevcut taslak tanım, kullanıcının kalite beklentisi, birbirinden ayrılmış kavramlar, örnekler, açık sorular ve geri dönülmesi gereken kaynaklardır. “Tek terminal amaç”, baz SOUL bileşen listesi veya SOUL-native tabanın aktarımı uygulanmış/kanıtlanmış sayılmaz.

Konuşmaya devam kararı, araştırma yönü değiştirme kararı ve Development OS kurulumuna geçme kararı ayrı aşamalardır. U017'nin “bu değerlendirme araştırmaya yön vermek zorunda değil” sınırı korunur.

## 6. Development OS'a gerçekten geçilecekse

Yeni kullanıcı yönü ve actual current durum birlikte ele alınır. [SOUL Context girişinden](../../../research/soul-context/INDEX.md) [STATE'e](../../../research/soul-context/STATE.md), orada adlandırılan gerçek hedef repository'nin güncel yetki/iş/kanıt yüzeylerine gidilir. Bu arşiv eski Codex çalışmasını yok saymaz; aynı işi baştan başlatmaz; araştırma snapshot'ını canlı hedef durumunun yerine geçirmez.

Bu aşamaya geçilmeden yalnız toplu okuma ve sohbet yapılabilir. Okuma rehberinin varlığı kurulum görevi yaratmaz.

## 7. Okuma kapsamının kaydı

Tam okuma iddiasında hangi kaynak dosyalarının ve hangi eserlerin okunduğu ayrılmalıdır. Kesilmiş çıktı, erişilemeyen dosya veya yalnız özet görülen bölüm, tam kaynak gibi gösterilmez. Eksik parça hafızadan tamamlanmaz. Kullanıcının istediği toplu okuma bu ayrımı koruduğunda sonraki konuşma gerçekten birikimli olabilir.
