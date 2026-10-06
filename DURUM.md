# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-013` (Hesabına bağlı servislerin adları devos'un açık geçmişinde (OI-012, L-147): kabul mü, geçmişi yeniden yazmak mı, depoyu geçmişsiz yeniden kurmak mı), `D-014` (Araştırma kütüphanesini C04'ten önce doğrudan okumak ve hangi koşullarla (D-011'in yerine geçer)). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 6 Ekim 2026, 03:16 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi).

**Sıradaki işler:** `W-C00-08`, `W-C00-10`, `W-C00-15` sürüyor. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere).

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

Senden beklenen: iki karar, D-014 ve D-013 (D-011'in yerine geçtiler; D-011'e cevap gerekmez). Ayrıntı ve adımlar "Batu'dan beklenenler" issue'sunda. 
1. D-014: Kütüphaneni C04'ten önce okuyayım mı? Önerim (a): üç koşulla şimdi oku. Koşullar: kütüphanede push e-postalarını açman, bir kez kısa bir Auto penceresi, C04'e kadar yalnız birebir kopya kontrolünü kabul etmen. 
2. D-013: Hesabına bağlı servislerin adları açık deponun eski kayıtlarında kalıyor; bir kısmını bugün ben yeniden yazmıştım, güncel dosyalardan temizledim. Önerim (a): kabul. 
3. C00'ın karar adımı sürüyor: plan değişiklikleri denetimden geçti ve ana dala girdi; denetçinin istediği iki küçük düzeltme yapılıyor. Açık depoya yazılanı kodla denetleyen ara kontrol kabul edildi ve devrede (D-014 (a) için gereken ilk güvence bu). Mekanizmasız karşılaştırma denemesi (W-C00-15) başladı: önce görevler ve başarı ölçütleri yazılıp kaydediliyor, sonra çalıştırılacak; kütüphanesiz. 
**D-014'e cevap gelmezse:** kütüphane bağlanmaz; incelemenin ve karşılaştırma denemesinin kütüphane kısmı bekler, C00 kapanamaz; diğer işler sürer. **D-013'e cevap gelmezse:** hiçbir iş beklemez.
