# Taslak 06 — Builder–Verifier ayrımı

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../06-builder-verifier-ayrimi.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1928
- Üst sınır: 2800

---

Agentic sistemlerde builder ile verifier’ı neden ayırmak gerektiğini düşünürken aklıma çok basit bir gerilim takıldı.

Bir agent’a “bu yazılımı yap” diyorsun. Doğal yönü işi bitirmek: çözüm seçiyor, kod yazıyor, hataları düzeltiyor, çalışan bir şey ortaya çıkarmaya çalışıyor.

Sonra aynı agent’a “şimdi hiçbir şeye güvenme, yaptığının neden yanlış olabileceğini bul” diyorsun.

İkisi de gerekli. Ama aynı çalışma amacı değil.

Builder’ın başarı işareti çalışan ürün.
Verifier’ın başarı işareti ise gerekirse “hayır, bu bitmedi” diyebilmek.

Bence agentic yapılarda kritik ayrım burada. “Aynı model ikisini de yapabilir mi?” sorusu çok önemli değil. Tabii ki yapabilir. Aynı LLM bir oturumda builder, başka bir oturumda verifier olabilir.

Asıl soru şu: O anda hangi rolün terminal amacını taşıyor?

Builder kendi kodunu test etsin, kendi hatasını arasın. Buna itirazım yok. Ama self-check ile independent verification aynı şey değil.

Çünkü builder çözümü üretirken bazı varsayımlar seçti, bir yola yatırım yaptı, kendi kararlarının bağlamını taşıyor. Sonra aynı context içinde ondan tamamen bağımsız bir göz gibi davranmasını bekliyoruz.

Bu bazen çalışır. Ama sistem tasarımı olarak “umarım kendini yeterince sert eleştirir” bana zayıf geliyor.

Maker-checker ayrımı da burada anlam kazanıyor.

İlla iki farklı model gerekmiyor. İki ayrı role, ayrı context’e, ayrı başarı kriterine hatta bazen ayrı authority’ye ihtiyaç olabilir.

Builder’ın işi üretmek.
Verifier’ın işi builder’ı mutlu etmek değil; yapılan iş hakkında güven üretmek.

Verifier hata bulduğu için iş uzuyorsa başarısız olmadı. Tam tersine, gerçek bir hata bulduysa görevini yaptı.

Bence multi-agent sistemlerde rol isimlerinden önce bakılması gereken şey bu:

Aynı agent’a kaç fonksiyon verdiğimiz değil, aynı çalışma anında birbirine ters kaç amaç verdiğimiz.

Aynı model birçok rol oynayabilir.

Ama builder mı verifier mı olduğu o anda belirsiz kalmamalı.
