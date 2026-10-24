# EXP-003 — Yayın ve doğrulama kaydı

**18 Eylül 2026. Durum: MAIN YAYINI TAMAMLANDI / sınırlı arşiv kontrolleri gerçekleştirildi.**

## Yayın kimlikleri

| Yüzey | Kimlik |
|---|---|
| Başlangıç main | `7d312c9e6dd26ec8393b5f4d94e99950775b16bf` |
| Çalışma dalı | `archive/exp-003-memory-20260918` |
| Kaynak kesimi tamamlanmış commit | `3e3169305a545eb87694a269bc6318576a3ddb39` |
| Tam arşiv payload head | `c413707c064fcb544660c9845fafa871465a37be` |
| Birleştirme öncesi main | `5ff9b169bf600f049086a8812f35bb9ed0894124` |
| Pull request | [#17](https://github.com/batuhanozgun/agentic-os-search/pull/17) |
| Gerçek merge commit | `c5342f8b4c2b7ee471b9da8078d6fc7c371c0531` |
| Merge tree | `d8a5e187693727afe3751d1bc94eb3663475913d` |

GitHub gerçek merge sonucunu `merged: true` olarak verdi. Exact expected-head kontrolü `c413707c064fcb544660c9845fafa871465a37be` ile kullanıldı. İlk PR oluşturma cevabındaki mergeable=false, sonraki metadata okumasında true oldu; bu geçici metadata değeri çakışma kanıtı sayılmadı.

## Gerçekleştirilen kontroller

### 1. Kaynak kesimi ve kimlik

Bağlı GitHub aracıyla 11 kullanıcı mesajı tek kaynak dosyasına, 10 assistant cevabı ayrı kaynak dosyalarına yazıldı. Toplam 21 mesaj/11 kaynak dosyası/125.688 byte. Kaynak commit'inde conversation dizini ve assistant tree'si geri okundu; [SOURCE-MANIFEST](../SOURCE-MANIFEST.json) bu byte boyutlarını ve Git blob kimliklerini taşır.

Main yayını sonrasında conversation dizini tekrar açıldı. USER-MESSAGES blob'u `8e3db60c0347235ec3e239f53b9977daa99d4a3c`; on assistant kaynağının tree'si `df8a7689652ede7b08af1d54d353526eb70a0e34` olarak aynı kaldı. Böylece kaynak dosyalarının yayında değişmediği kimlik düzeyinde doğrulandı. Bu, kaynak mesajlarının platform export'uyla byte-perfect eşitlik deneyi değildir.

### 2. Metin geri okuması

Exact payload `c413...` üzerinde paket INDEX, QUALIFICATIONS, CONSOLIDATION ve USER-MESSAGES açılış/son aralıkları geri okundu. Konsolidasyonun ilk araç görünümü kesildiği için 63–95 satır aralığı ayrıca alındı ve son hedef/sınır bölümü tamamlandı. Kullanıcı metninde ilk exploration-olmama sınırı ve U011'in gelecekteki hedef/arşivleme yönü görüldü.

Main üzerinde CATALOG ve CUMULATIVE-READING ayrıca açıldı: EXP-003 girişi ve üç denemedeki 37+37+21=95 mesajlık sıralı yol mevcut. Payload-head→merge karşılaştırmasında yalnız eşzamanlı studies/Superpowers farkları çıktı; geri okunan EXP metinlerinin birleşme sırasında değişmediği doğrulandı.

Bütün 29 dosyanın her gövdesini uzaktan baştan sona ikinci kez okuma veya bağımsız link-crawler deneyi yapılmadı. Kontrol kapsamı kaynak/tree kimlikleri, değişen yollar ve belirtilen kritik metinlerle sınırlıdır.

### 3. Kapsam ve eşzamanlı çalışma

Başlangıç main→payload karşılaştırması tam olarak 31 değişen yol gösterdi: 29 yeni EXP-003 dosyası ve iki explorations giriş dosyası. Arşiv sırasında main, Superpowers'ın sekiz studies yolundaki çalışmasıyla `5ff9...` sürümüne ilerledi; bu yollar bizim değişiklik kapsamımızla kesişmedi.

`5ff9...`→gerçek merge `c534...` karşılaştırması yine yalnız bu 31 exploration yolunu gösterdi. `c413...`→`c534...` karşılaştırması yalnız sekiz studies/Superpowers yolunu gösterdi. Birleşme böylece hem yeni arşivi hem diğer oturumun güncellemesini korudu. Eski EXP kaynakları, Foundation, studies, concepts ve agent-control bu iş tarafından değiştirilmedi.

### 4. Durum kapanışı

Bu yayın kaydı, STATE ve WORK-PLAN, gerçekleşmiş main yayını ve yukarıdaki kontrolleri yansıtan üç dosyalı kapanıştır. Kaynak metinler veya sentezler bu kapanışta yeniden yazılmadı. Bu kayıt kendi commit kimliğini kendisine bağlamaz; sonraki terminal geri okuma konuşmanın araç kanıtında kalır.

Kullanıcıdan upload veya merge beklenmez. Çalışma dalı yayımlanmış geçmişi taşır; bekleyen araştırma veya alternatif canonical state değildir. Branch silme/genel temizlik, force push ve koruma ayarı değişikliği yapılmadı.

## Kanıt sınırı ve araştırma durumu

Bu kontroller aynı assistant'ın arşivleme ve repository doğrulamasıdır; bağımsız transkripsiyon, bilimsel tekrar veya canlı memory-system deneyi değildir. Manifest dosya kimliğini bağlar; doğal-dil doğruluğunu, gelecekte anlaşılmayı veya teknik iddiaların geçerliliğini kanıtlamaz. Kaynak gövdeleri ham platform export'u değildir; [TRANSCRIPTION-NOTE](TRANSCRIPTION-NOTE.md) sunum farkını ve dışarıda bırakılanları açıklar.

Bu tur Karpathy Gist'inin tam kaynak/revision incelemesini veya bütün studies'in birincil kaynak denetimini tamamlamaz. S009/S010 yüzdeleri geri çekilmiştir; 'araştırma doyumu', 'daha iyi yapı' ve 'açıkları içermeyen sistem' gerçekleşmiş sonuç olarak ilan edilmez. Yeni memory araştırması, mimari seçimi, uygulama veya mevcut target/Codex işi başlatılmadı.
