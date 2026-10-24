# İkinci video — Kapsam ve dönüş planı

**v0.2 / 2026-09-16.** Kullanıcı uygunluk değerlendirmesi kaydedildi; araştırma veya test kapsamı genişlemedi. Bu video kendi kaynak sorusuyla yönetilir. Aşağıdaki maddeler video numarası veya ilk videonun U birimleri değildir.

## Gerçek ilerleme

| İş | Durum | Teslimat / sınır |
|---|---|---|
| Kaynak alımı ve kimlik | Tamam | Exact MP4/SRT, hash/süre, seçili video ID; yayın tarihi açık |
| Kaynağın bütün kullanılabilir metni ve gerekli görseller | Tamam, belirtilen derinlikte | 859 cue tam okuma,20 kare; tam ses hizalaması değil |
| Kaynak açıklaması, mekanizmalar ve sınırlı teknik kontrol | Tamam | RESEARCH;5 mekanizma ve dosya örneği; araç/credential sınırı; seçilmiş birincil kontroller |
| İlk SOUL/DevOS ilgi değerlendirmesi | Tamam, aday statüsünde | ASSESSMENT; canlı proje/architecture incelemesi değil |
| Karşı okuma | Tamam, aynı araştırmacı | REVIEW; çizim/metrik/scope sorunları; bağımsız güvenlik testi değil |
| Kullanıcı değerlendirmesi ve devam seçimi | Alındı: araştırma uygun bulundu | Batu repodan okuduğunu bildirdi ve üçüncü video PxuMqeIqCEo'yu seçti. Bu dosyada yeni teknik iş seçilmedi. |

## Açık doğrulamalar: otomatik yapılacaklar listesi değil

**Exact konuşma iddiası gerekli olursa:** tartışmalı zaman aralığının sesini gerçek byte'larla karşılaştır; altyazı/companion bunu ikame etmez. Bunun dışındaki bütün sesi yeniden çözümleme bu aşamanın zorunlu önkoşulu değildir.

**Gerçek bir sandbox/policy seçimi istenirse:** önce işin korunan kaynaklarını, normal operasyonlarını, dış servis/credential'larını ve ortamını netleştir. Yalnız ilgili ürün/sürüm/ABI/host/tool yollarını araştır. Önceden seçilmiş layer veya bütün seçenekleri inceleme mecburiyeti yoktur.

**Güvenlik doğrulaması istenirse:** exact hedef ve policy, normal/olumsuz örnekler, beklenen ret/erişim sınırı, child/host-side/outbound yollar, kaynak tüketimi ve oracle baştan tanımlanır. Yetki ve güvenli ortam olmadan kuruluma, exploit'e, ücretli benchmark'a veya production eylemine geçilmez. Yeni test tarihsel video örneğini bağımsız yeniden üretmiş sayılmaz.

**Katman performansı karar taşıyacaksa:** aynı normal iş, konfigürasyon ve başlangıç/bitiş ölçümü gerekir. Slayttaki genel saniyeler ile Firecracker açılış sayısı yeterli değildir. Böyle bir performans tercihi bugün yapılmadı.

## Genişlemeyi sınırlayan karar

İlk inceleme için bu soruların koşullu bırakılması yeterlidir; mekanizmaları açıklamak için bütün sandbox ürünlerini çalıştırmak gerekmiyor. Semantic Kernel, gVisor ve Firecracker bu dosyada belirli iddiaların kaynaklarıdır; bağımsız kampanyalara dönüştürülmedi. Meta-Harness'in ilk dosyadaki açık işleri bu videonun dependency'si yapılmadı.

Kullanıcı mevcut kaynak araştırmasını uygun buldu ve üçüncü videoyu seçti. İkinci videonun açık sınırları burada kalır; uygunluk değerlendirmesi onları kapatmaz. Araştırma-kapsam tamamlanması ile ses/ürün doğrulaması ve benimsenmiş mimari farklı statülerdir. Yeni teknik birim yalnız seçilmiş bir soruyla açılır.
