# Taslak 08 — Entelektüel miras

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../08-entelektuel-miras.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1890
- Üst sınır: 2800

---

Bir agent’a bütün araştırma repository’sine erişim vermekle onu gerçekten o araştırmayla donatmış oluyor muyuz?

Bence hayır.

Diyelim memory konusunda aylarca çalıştık. Persistence, retrieval, provenance, stale bilgi, continuity, change impact… hepsi repository’de.

Yeni agent geliyor.

Memory problemi veriyoruz.

Agent kendi training bilgisinden “RAG + vector DB” diye gayet düzgün bir cevap veriyor.

İki klasör ötede aynı problemi çok daha derin ele aldığımız araştırma duruyor.

Teknik olarak erişebiliyor.
Ama gidip bakmak aklına gelmiyor.

Burada “bilginin adresini bilmek” ile “o bilgiyle yetişmiş olmak” arasında bir fark görüyorum.

Gerçek hayatta mimarı çağırdığımızda “kitaplığın şurada, ihtiyaç olursa oku” demiyoruz. Mimar eğitimin, deneyimin ve eski hataların bir kısmını zaten probleme bakışına taşımış geliyor.

Agentic sistemlerde de reusable knowledge’ın yalnız archive olarak kalmaması gerekiyor.

Ama bu “bütün araştırma sonuçlarını system prompt’a yazalım” demek değil.

Daha değerli olan bazen sonuçtan çok lens:

“Bu ayrımı unutma.”
“Şu failure mode’u kontrol et.”
“Bu varsayımı sessiz kabul etme.”
“Burada özgün kaynağa dön.”

Yani agent bootstrap’ında yalnız role-specific knowledge değil, ortak bir reasoning heritage olabilir.

Verification agent her seferinde maker-checker problemini sıfırdan keşfetmek zorunda kalmaz.
Researcher kaynak ile çıkarımı ayırmayı doğal çalışma biçimi olarak taşır.
Planner belirsizliği task adıyla kapatmanın riskini bilir.

Tabii miras dogma olmamalı.

Araştırma yanlış, eski veya bağlama özel olabilir. Kritik hükümde kaynak hâlâ recover edilebilmeli.

Bence iyi yapı iki şeyi aynı anda istiyor:

Araştırılmış dersler agent’ın hangi soruları soracağını şekillendirsin.

Ama “neden böyle düşünüyoruz?” sorusunun cevabı da kaynağa kadar geri gidebilsin.

Kütüphane yetmiyor.

Biraz da o kütüphaneyle yetişmiş agent’lar gerekiyor.
