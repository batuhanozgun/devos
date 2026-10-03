# DevOS kurulum durumu

**Son güncelleme:** 3 Ekim 2026, 21:20 (Türkiye saati) · **Son nabız:** 2 Ekim 2026, 09:48 (Türkiye saati): dağıtıcı ve zamanlayıcı bilerek kapalı; yeniden tasarım bağımsız olarak denetlenene kadar nabız yok

**Şu an:** Çalışma düzenimin bütüncül yeniden tasarımı (W-C00-12) sürüyor. Bu çalışma oturumu (`session_01Wj4JDduaDRVnBvQJ86b5bm`) işi yeni bir oturuma devrediyor. Senin bir şey yapmana gerek yok.

**Aşama:** C00 (başlangıç kontrolleri), beklemede; yalnız W-C00-12 yürüyor.

**En son yapılanlar**
1. Tasarımın tamamı bağımsız dış denetime gitti ve **geçemedi** (`evidence/C00/reviews/R-W12-1.md`). Denetçi yaklaşımı doğru buldu, ama yedi engelleyici hata gösterdi. En önemlisi: "sürekli açık dağıtıcıya gerek yok" kararım "hiç oturum ölmedi" varsayımına dayanıyordu; oysa 3 Ekim'de bir oturum hesap sorunuyla durdu ve ancak sen yazınca devam etti. Ayrıca tasarım tek seferde kurulmak için fazla büyük.
2. Her bulgu kabul edildi; düzeltme planı yazıldı (`plan/builder/w-c00-12/10_r-w12-1_dispositions.md`). Yeni plan: önce küçük bir ilk parti kurulacak, C00'ın ağır işleri ondan sonra başlayacak; geri kalanlar ihtiyaç doğunca eklenecek.
3. Eski iki denetim raporunun `main`'e hiç kopyalanmadığı ortaya çıktı; şimdi kopyalandı.

**Sırada:** Yeni oturum tasarımı tek, tutarlı bir metin olarak yeniden yazacak, her mekanizmaya test tanımlayacak ve dar bir yeniden denetime gönderecek.

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok. (Bağımsız bekçi için hesabından bir dosya eklemen gerekebilir; gerekirse issue'ya adım adım gelecek.)

**Kullanım:** "İzinli" düzeyde; beş saatlik pencere 3 Ekim 23:10'da (Türkiye saati) yenileniyor.

**Bilmen gereken riskler**
- Bir oturum ölürse onu şimdilik hiçbir şey fark etmiyor; "Son güncelleme" saatinin eskimesinden görürsün. Düzeltme planında bunun için bağımsız bir bekçi var.
- Bağımsız denetim ortamı henüz yok; denetçiler aynı model, ayrı oturumlar.
