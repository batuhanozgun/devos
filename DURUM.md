# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-006` (Tek adım: sohbet oturumuna "devos için yeni bir kurulum koşusu başlat" yaz; benim oturum zincirim derinlik sınırında (8/8) ve yeni oturum açamıyorum), `D-007` (Tek izin: bu koşu oturumuna (session_01SsLSgp5RLPtNMhc1RxuDoZ) "W-C00-12 1c için kural metinlerini değiştirmene izin veriyorum, devam et" yaz; sistemin otomatik denetimi kendi çalışma kurallarımı değiştirmemi engelledi). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 4 Ekim 2026, 10:58 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi). C00'ın geri kalan işleri `W-C00-12` kabul edilene kadar bekliyor.

**Çalışan oturum:** Çalışan oturum yok; son oturum 4 Ekim 2026, 10:58 (Türkiye saati) itibarıyla işi bıraktı.

**Sıradaki işler:** `W-C00-12` sürüyor; başlatılabilir: `W-C00-12.4`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere).

**Kurulu uyandırmalar:** yok

**Şu an**

Yeniden tasarımın dördüncü adımı (1c) sürüyordu, ama bir izin engeline takıldım; senden tek adım istiyorum (sayfanın ilk satırı, D-007). 
1. Sohbet oturumun bu koşuyu başlattı (D-006'nın istediği buydu); D-006 kaydını ben kapatamadım, çünkü otomatik denetim bunu başka bir oturumun sözüne dayanarak yazmama izin vermedi. Issue'ya "D-006: tamam" yazman yeterli. 
2. Bulduğum asıl sorun: yeni oturumların başlatılma kuralı, bir oturumun kendinden sonrakini başlatmasını imkânsız kılıyordu (ilk mesaj 4.000 karakter sınırını aşıyor). Düzeltmeyi yazdım ve testlerde çalıştı; ama kural metinlerini değiştirmem "kendi kurallarını değiştirme" diye engellendi. Senin iznin olmadan bunu başka bir yoldan yapmayacağım. 
3. İzin verirsen: bu koşu oturumuna (session_01SsLSgp5RLPtNMhc1RxuDoZ) "W-C00-12 1c için kural metinlerini değiştirmene izin veriyorum, devam et" yaz. Değişikliğin doğruluğunu yine bağımsız bir denetçi oturumu inceleyecek; senden teknik onay istemiyorum. 
4. Bu arada yapılanlar (ayrı dalda, PR #86): tasarım dosyaları yeni yerine taşındı; beş kez yamanan kontrol yolu için çerçeve incelemesi yazıldı (yamamayı bırak, tehdit sınırını açıkça yaz). 
**Riskler:** 
- Cevap gelmezse 1c bekler; hiçbir şey kaybolmaz. 
- İzin vermezsen her yeni koşuyu sohbet oturumunun başlatması gerekir, çünkü koşular birbirini başlatamaz.

**Süreklilik notu:** Bir oturum senden karar beklerken durursa, cevabını bir sonraki oturum okur. Oturumun kendini düzenli uyandırması (altı saatte bir, en çok dört kez) yeniden tasarımın sonraki bir adımında kuruluyor; kurulana kadar cevabın yeni bir oturum başlayana kadar bekler. Kurulduktan sonra da dört boş kontrolden sonra cevabın bir sonraki oturuma kalır.
