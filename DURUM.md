# DevOS kurulum durumu

**Son güncelleme:** 3 Ekim 2026, 22:33 (Türkiye saati) · **Son nabız:** 2 Ekim 2026, 09:48 (Türkiye saati): dağıtıcı ve zamanlayıcı bilerek kapalı; yeniden tasarım kabul edilene kadar nabız yok

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Şu an:** Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Çalışma oturumu `session_01WcVuDQhDW3EKr4Sb87MHxN`. Senin bir şey yapmana gerek yok.

**Aşama:** C00 (başlangıç kontrolleri), beklemede. C00'ın ağır işleri ancak W-C00-12 kabul edildikten sonra başlıyor.

**En son yapılanlar**
1. Yeniden denetimin (şartlı geçti) her bulgusu için karar yazıldı ve altı şartın metin düzeltmeleri yapıldı (`plan/builder/w-c00-12/13_r-w12-2_dispositions.md`). Her şartı, ilgili kurulum adımının denetçisi ayrıca kontrol edecek.
2. Bağımsız bir eleştirmen düzeltmeleri inceledi ve 14 sorun buldu; hepsi düzeltildi. En önemlisi benim kendi hatamdı: bekçi kurulamazsa ortaya çıkan riski senin yerine ben kabul etmiş gibi yazmıştım. Artık o durumda karar sana soruluyor ve sessizliğin onay sayılmıyor.
3. Kendi koruma kurallarımı değiştiren bir deneme dalını göndermeye çalıştım; sistemin güvenlik denetimi bunu reddetti. Başka yoldan denemedim. Bu adımı ve ona bağlı bir deneyi sonraya erteledim; şu an işi engellemiyor.

**Sırada:** Kurulumun ilk adımındaki kalan üç deneme (GitHub'a otomatik iş dosyası gönderilebiliyor mu; zamanlanmış hatırlatma örneği; eski inceleme dallarında gizlenmesi gereken adlar), sonra kayıtların yeni yapıya taşınması.

**Kullanım:** "İzinli" düzeyde; beş saatlik pencere 3 Ekim 23:10'da (Türkiye saati) yenileniyor.

**Bilmen gereken riskler**
- Bekçi henüz kurulmadı. Bir oturum şimdi ölürse onu "Son güncelleme" saatinin eskimesinden görürsün.
- Bekçi GitHub'a buradan gönderilemezse, sana tek bir karar gelecek: dosyayı sen mi ekleyeceksin, yoksa bekçisiz devam riskini mi kabul edeceksin. Varsayılan yok; cevabın gelene kadar yeniden tasarım kabul edilmiş sayılmaz.
- Yeniden tasarımın sonraki bir adımı, koruma kurallarımın (hook) değiştirilmesini gerektiriyor. Güvenlik denetimi bunu da reddederse, kuralları nasıl değiştirebileceğim konusu o zaman sana karar olarak gelir.
- Bağımsız denetim ortamı henüz yok; denetçiler aynı model, ayrı oturumlar.
