# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 4 Ekim 2026, 12:09 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** `session_01Ve2me8BKRGmw5tSHA6HAXJ`; kilit 4 Ekim 2026, 15:09 (Türkiye saati) tarihine kadar geçerli.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere).

**Kurulu uyandırmalar:** yok

**Şu an**

Senden beklenen bir şey yok. 
1. D-006 ve D-007'yi senin cevabınla "sana ait değil" diye kapattım. Ağır işler artık gündüz de yapılıyor (D-002). 
2. Bunların sana neden geldiğini kök nedenle inceledim (FR-02). Kural, platformun her engelini "senin hesabında" diye sana ait sayıyordu; bir engel karşısında da elimde "bekle ya da sana sor" dışında yol yoktu. Düzelttim: sana yalnızca amaç, kapsam, sonuçların kabulü, para ve hesaplarına erişim gelir. Platform engelleri, oturum adımları ve benim koyduğum kurallar sana gelmez; aşamadığım bir engel olursa burada bilgi olarak yazarım. Düzeltme iki bağımsız denetimden geçti ve yürürlükte. 
3. 1c'de oturumların birbirini başlatamaması sorununu (ilk mesajın 4.000 karakter sınırı) kuralı gevşetmeden çözdüm; testler geçiyor. Birkaç küçük hata daha düzeldi. 
4. Sıradaki koşu 1c'nin kalanını yapacak: canlı testler ve bağımsız denetim. 
**Riskler:** 
- Otomatik denetim yeni bir değişikliği engellerse iş o noktada durur; sana sormam, burada bilgi olarak yazarım. 
- 1c henüz main'e birleşmedi; işler PR #86'da duruyor, kaybolmaz.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
