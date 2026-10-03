# DevOS kurulum durumu

**Son güncelleme:** 3 Ekim 2026, 20:37 (Türkiye saati) · **Son nabız:** 2 Ekim 2026, 09:48 (Türkiye saati): dağıtıcı ve zamanlayıcı bilerek kapalı; yeniden tasarım bağımsız olarak denetlenene kadar nabız yok

**Şu an:** Çalışma düzenimin bütüncül yeniden tasarımı (W-C00-12) sürüyor. Çalışma oturumu: `session_0143r88Vc9e5RbsQmqjYWgwa`. Senin bir şey yapmana gerek yok.

**Aşama:** C00 (başlangıç kontrolleri), beklemede; yalnız W-C00-12 yürüyor.

**En son yapılanlar**
1. İki kararın kayda geçti: kullanım politikası (D-002) ve bağlantı engelinin kalan riski (D-003), ikisi de (a). Cevabını 2 Ekim sabahı vermiştin; kayda geçmesi gecikti, bu bir bulgu olarak yazıldı (`plan/ledger/C00-log.md`, L-036).
2. Bir deneme oturumu üç şeyin bulut oturumlarında çalıştığını gösterdi: oturum açılışında otomatik çalışan kanca, depodaki beceriler ve rol tanımları. Yeni tasarım bunlara dayanabilir (`evidence/C00/probes/P-W12-1_cloud_loading.md`).
3. Benim taslağımı görmeyen ayrı bir oturum kendi karşı tasarımını hazırlıyor. Ben de kurulumun bütünü için neyin gerektiğini baştan sona çıkardım (`plan/builder/w-c00-12/01_goal_down.md`).

**Sırada:** Tasarımın ilk iki parçası taslak olarak yazıldı: kayıtlar ve hafıza (`plan/builder/w-c00-12/02_memory.md`), iş listesinin yaşayan yapısı (`plan/builder/w-c00-12/03_work_model.md`). Sıradaki parça: rollerin düzeni (kim üretir, kim kabul eder, her rol hangi bilgiyle donatılır).

**Senden beklenen:** Hiçbir şey. [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'sunda açık karar yok.

**Kullanım:** "İzinli" düzeyde; beş saatlik pencere 3 Ekim 23:10'da (Türkiye saati) yenileniyor.

**Bilmen gereken riskler**
- Bağımsız denetim ortamı henüz yok; önemli değişiklikleri aynı modelden ama ayrı oturumlar inceliyor.
- Bu oturumda bir saat içinde dört kez ölçmek yerine tahmini değer yazdım (saat, boyut); hepsi `main`'e girmeden düzeltildi. Yeni tasarım bu tür değerleri komutla üretmeyi zorunlu kılmalı.
