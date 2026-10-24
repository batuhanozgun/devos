# Taslak 01 — Roman analojisi

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [01-roman-analojisi-kullanici-talebinden-yasayan-is-tanimina.md](../01-roman-analojisi-kullanici-talebinden-yasayan-is-tanimina.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 2348
- Üst sınır: 2800

---

Agentic yapılar üzerine çalışırken roman örneği kafama takıldı.

Kullanıcı “bir roman yazmak istiyorum” diyor. Cümle açık gibi. Ama gerçekten yapılacak iş bu mu?

Roman yazıldıktan sonra ne olacak? Word dosyası olarak masaüstünde mi kalacak? Basılacak mı? Yayıncı mı bulunacak? Dağıtım, fiyatlama, reklam işin parçası mı? Belki hiçbirisi değil; kullanıcı gerçekten yalnızca kendisi için yazıyordur.

Buradaki mesele AI gizli niyet okusun değil. Tam tersine, ilk prompt'u yapılacak işin tamamı sanmasın.

Tek chat'te bunun sonucu kötü bir cevap olabilir. Agentic bir yapıda daha tehlikeli. Planner prompt'u task'lara böler, Researcher araştırır, Writer yazar, Verifier da verilen kriterlere göre kontrol eder.

Herkes kendi işini doğru yapar.

Sistem yine de yanlış işi son derece düzgün üretmiş olabilir.

O yüzden prompt ile executable work arasında bir discovery katmanı gerekiyor gibi geliyor bana. Adına work discovery dersin, intent discovery dersin, çok önemli değil. Sistem bir yerde “Bu talebin sonunda gerçekte neyin doğru hale gelmesi gerekiyor?” sorusunu taşımalı.

Ama burada başka bir tuzak var.

Buradan “Her şeyi tamamen anlamadan execution'a geçme” sonucu çıkarmak da bence yanlış.

Romanın ilk bölümünü yazmak için dağıtım şirketinin kim olduğunu bilmeye gerek yok. İlk bölümü değiştirecek kritik şeyler yeterince netse Writer başlayabilir.

Asıl ilginç taraf bundan sonra başlıyor.

Başta “dağıtımcı bul” diye task açmış olabiliriz. Bir süre sonra yayıncı bulunur ve dağıtımı zaten onun yaptığı ortaya çıkar. O task tamamen yok olur.

Roman yazılırken hedef kitle değişir, editoryal plan değişir, belki daha önce düşünmediğimiz bir uzman agent'a ihtiyaç doğar.

Yani execution yalnız işi ilerletmiyor, yeni bilgi de üretiyor. Yeni bilgi de dönüp yapılacak işi değiştiriyor.

Bu yüzden agentic sistemde planı başlangıçta çizilip kilitlenen bir task graph gibi düşünmek bana eksik geliyor. Daha çok çalışan sistemin yaşayan state'i gibi.

Raw user request ayrı durmalı. Current work definition ayrı durmalı. İlki kaynaktır; ikincisi çalıştıkça değişebilir.

Bence agentic yapılardaki büyük risklerden biri AI'ın yanlış cevap vermesi değil.

Yanlış işi, doğru rollerle, doğru sırayla, başarıyla tamamlaması.

Prompt başlangıç noktasıdır; iş tanımı değil. İş tanımı da execution başlamadan önce sonsuza kadar sabitlenen bir şey değil.
