# Taslak 12 — Agentic sistemi program gibi düşünmek

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../12-soulu-bir-program-gibi-dusunmek.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1740
- Üst sınır: 2800

---

LLM agent sistemlerini doğal dille anlattığımızda bazı şeyler kulağa doğru geliyor ama çalışıp çalışmayacağı belli olmuyor.

Mesela:

“Yeni talebi kaydet ama henüz üstlenilmediyse aktif iş gibi gösterme.”

Güzel kural.

Peki sistemde gerçekten ne oluyor?

Talep geldi.
Kaydedildi.
Değerlendirildi mi?
Üstlenildi mi?
Work’e dönüştü mü?
Planın içinde mi?

Bir cümle yazınca aslında birkaç ayrı state ortaya çıkıyor.

Burada agentic sistemi bazen bir program mimarisi gibi düşünmek işime yarıyor.

LLM deterministik değil, tabii ki function call gibi çalışmıyor. Aynı context aynı cümleyi garanti etmiyor.

Ama etrafındaki çalışma sistemi o kadar belirsiz olmak zorunda değil.

Hangi state okunacak?
Hangi role hangi bilgi gösterilecek?
Kim karar verebilir?
Verifier ne zaman devreye girecek?
Verification başarısızsa work nereye dönecek?
Hangi kayıt güncellenecek?

Bunların bazıları açık sözleşmeler olabilir.

Bence harness’in değerli taraflarından biri burada.

Reasoning’i if/else’e çevirmek değil; olasılıksal reasoning’in çalıştığı yolu incelenebilir hale getirmek.

Çünkü “agent doğru değerlendirsin” mekanizma değil.

“Şu durumda bu kayıtları oku, bu authority sınırında seçenek üret, şu gate geçmeden execution başlatma, verdict şu state’i değiştirir” dediğinde artık sistem davranışı konuşmaya başlıyoruz.

Yazılım mimarisinde input’un hangi modülden geçtiğini, hangi koşulda branch değiştirdiğini çizebiliyoruz.

Agentic sistemde de en azından state, context, role, authority ve control akışını çizebilmeliyiz.

Çıktının tam cümlesini bilemeyebiliriz.

Ama o cümlenin hangi çalışma mekanizmasının içinde üretildiğini bilebiliriz.

Bence “agent iyi düşünsün” ile “agent’ın iyi düşünebileceği sistem kurulsun” arasındaki fark burada.
