# DevOS kurulum durumu

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Son güncelleme:** 5 Ekim 2026, 23:02 (Türkiye saati). Bu sayfa `tools/records.py durum` ile durum dosyasından (`plan/ledger.md`) üretilir; elle yazılan tek kısım "Şu an" bölümüdür.

**Aşama:** C00 (Başlangıç, işlev karşılaştırması ve planın bağımsız incelemesi).

**Sıradaki işler:** başlatılabilir: `W-C00-03`, `W-C00-06`, `W-C00-07`, `W-C00-08`, `W-C00-09`. Ayrıntı: `plan/ledger.md`, bölüm 2.

**Kullanım:** "izinli" düzeyinde (beş saatlik pencere).

**Çalışma oturumu:** Kurulumu tek bir çalışma oturumu yürütüyor. Kullanım limiti dolarsa, limit sıfırlandıktan sonra o oturuma yazacağın "devam" mesajı işi kaldığı yerden sürdürür.

**Şu an**

Senden beklenen: çalışma oturumunu açman. 
1. Kurulumun yeni düzeni canlıda (D-010): tek bir çalışma oturumu planı adım adım işletecek, işi rol tanımlı alt ajanlara dağıtacak; kurucunun eski oturum zinciri kaldırıldı. Bağımsız inceleme (R-TRANS-1) ikinci turda PASS verdi. 
2. Yapman gereken (bir kez): claude.ai/code'da yeni bir oturum aç; ortam devos-kurulum, yalnız devos deposu, Accept edits, Opus 5.5. İlk mesaj olarak plan/Ek_F_Baslangic_Mesaji.md'deki /goal metnini olduğu gibi yapıştır. 
3. Sonrası: yalnız senin kararların (o oturuma yazarsın) ve kullanım limiti sıfırlanınca bir "devam" mesajı. Konuşma oturumu bu devirle kapanıyor. 
**Riskler:** 
- Tek oturumun özetlemeyle uzun süre plandan kopmadan çalışacağı varsayım; ilk özetlemede gözlenecek. 
- /goal'un uygulamadan yazılarak çalıştığı ilk kez görülecek; çalışmazsa çalışma oturumu sana yazar.
