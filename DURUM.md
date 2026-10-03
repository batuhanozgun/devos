# DevOS kurulum durumu

**Son güncelleme:** 3 Ekim 2026, 22:10 (Türkiye saati) · **Son nabız:** 2 Ekim 2026, 09:48 (Türkiye saati): dağıtıcı ve zamanlayıcı bilerek kapalı; yeniden tasarım kabul edilene kadar nabız yok

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Şu an:** Çalışma düzenimin yeniden tasarımı (W-C00-12) sürüyor. Bu çalışma oturumu (`session_01XUsVQowRbLJdC1E8gFvxZq`) işi yeni bir oturuma devrediyor. Senin bir şey yapmana gerek yok.

**Aşama:** C00 (başlangıç kontrolleri), beklemede. C00'ın ağır işleri ancak W-C00-12 kabul edildikten sonra başlıyor.

**En son yapılanlar**
1. Denetçinin bulduğu hatalara göre tasarım **tek ve tutarlı bir metin** olarak yeniden yazıldı. Her mekanizmanın bir testi var (`plan/builder/w-c00-12/11_test_register.md`). Kurulum dört adıma bölündü, her adımın kendi testleri ve denetimi var (`plan/builder/w-c00-12/12_tranche_plan.md`).
2. 3 Ekim'de duran oturum artık hesaba katılıyor. GitHub'da saatte bir çalışan bağımsız bir bekçi, iş durursa sana issue üzerinden haber verecek.
3. Bağımsız bir eleştirmen taslağı inceledi ve 16 sorun buldu; hepsi düzeltildi. Bunlardan biri benim tahminle yazdığım bir sayıydı (ölçülmemişti); artık ölçülmüş değer kullanılıyor.

**Sırada:** Yeniden denetim **şartlı olarak geçti** (`evidence/C00/reviews/R-W12-2.md`). Denetçi altı düzeltme istedi; her biri ilgili kurulum adımı birleşmeden önce yapılacak ve o adımın denetçisi kontrol edecek. Yeni oturum önce bu düzeltmeleri yapacak, sonra kurulumun ilk adımına geçecek.

**Kullanım:** "İzinli" düzeyde; beş saatlik pencere 3 Ekim 23:10'da (Türkiye saati) yenileniyor.

**Bilmen gereken riskler**
- Bekçi henüz kurulmadı. Bir oturum şimdi ölürse onu "Son güncelleme" saatinin eskimesinden görürsün.
- Bağımsız denetim ortamı henüz yok; denetçiler aynı model, ayrı oturumlar.
