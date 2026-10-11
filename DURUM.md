# DevOS kurulum durumu

**Senden beklenen:** Şu kararlar senin: `D-028` (C01 rutininin sıradaki çalışmasını (P4; 13. satırın denetlenemeyen iki kısmı, W-C01-46), yarın 11:07'yi beklemeden bugün, rutinin sayfasında bir kez Run now'a basarak başlatmak). Cevabını [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna yaz.

**Son güncelleme:** 11 Ekim 2026, 22:12 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C01 (Platform doğrulaması).

**Sıradaki işler:** başlatılabilir: `W-C01-46`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "uyarı düzeyinde" düzeyinde (haftalık pencere); pencere 17 Ekim 2026, 20:00 (Türkiye saati) tarihinde yenileniyor.

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

P1, P2 ve P3 bitti. 5., 6., 7., 8. ve 10. satırlar kabul edildi; 13. satırın kaydı kabul edildi (satır karşılanmadı, planlanan yolla ilerliyor). Guard işi kabul edildi. 
10. satır: bir oturum, kullanım payının ne kadarını harcadığını göremiyor; bu oranı yalnız sen kullanım sayfanda görüyorsun. Planın öngördüğü yol uygulandı: kapasite tahminle hesaplanacak, belirsizliği kayda geçecek (PC-36). Senden bir şey istemiyor. 
Düzeltme: ECC eklentisinin kancaları yalnız bu oturumda bir şey yapmıyor. Depo ayarının işe yarayıp yaramadığı, oturum yeniden başlayınca görülecek. Yaramazsa eklentiyi hesap ayarlarından kapatmayı sana ayrıca soracağım. 
Haftalık kullanım uyarı düzeyinde: 17 Ekim 20:00'ye kadar yalnız hafif işler sürüyor (D-002). 
**Senden beklenen (D-028):** P4 hazır; rutinin sayfasında bir kez **Run now**'a basar mısın? Basmazsan yarın 11:07'de kendiliğinden çalışır.
