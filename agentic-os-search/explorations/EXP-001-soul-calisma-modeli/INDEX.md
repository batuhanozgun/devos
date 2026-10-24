# EXP-001 — SOUL'un çalışma modeli

**Tür:** Kavramsal diyalog + sentetik rol demosu + mekanizma modelleme provası.  
**Kaynak oturum:** 10 Eylül 2026; kesin mesaj saatleri üretilmemiştir.  
**Amaç:** Araştırmaların, kullanıcının düşünme yaklaşımının ve LLM'in birlikte nasıl bir SOUL çalışma anlayışı ortaya çıkarabildiğini görmek; sonraki denemeler için ayrıntılı ve geri çağrılabilir kaynak bırakmak.  
**Arşiv durumu:** [STATE.md](STATE.md) — tanımlı diyalog kesimi, retrieval ve 32 eser/kaynak dosyası yayımlandı; Git içerik kimlikleri doğrulandı.  
**Aktarım planının kapanışı:** [WORK-PLAN.md](WORK-PLAN.md).

Bu çalışma bitmiş SOUL, onaylanmış mimari, ürün implementasyonu veya bağımsız ajan benchmark'ı değildir. Uygulama ve roman örnekleri çalışma modelini düşünmek için kullanıldı. Konsolidasyon ve Atlas gerçek eserlerdir; onların içindeki ajan hareketleri sentetiktir.

## Hangi soruyla geri geldin?

| İhtiyaç | Okuma yolu |
|---|---|
| “Hani konuşmuştuk ya” / belirli örneği hatırlama | [TOPIC-MAP](retrieval/TOPIC-MAP.md) → ilgili U/S mesajı |
| Konuşmayı sıra ile okumak | [Diyalog INDEX](sources/conversation/INDEX.md) → U001/S001 ... U019 |
| Neler öğrendik, hangi sınırlarla? | [LEARNINGS](reflections/LEARNINGS.md) — 15 kaynak bağlantılı kayıt |
| Hangi düşüncemiz neden değişti? | [EVOLUTION](reflections/EVOLUTION.md) — 13 değişim evresi |
| Neler hâlâ açık? | [OPEN-QUESTIONS](reflections/OPEN-QUESTIONS.md) — araştırma soruları, yürütme yetkisi değil |
| Konsolidasyon / Atlas / çizim | [Eser INDEX](artifacts/INDEX.md) → özgün dosyalar ve [manifest](SOURCE-MANIFEST.json) |
| Foundation ve studies dayanakları | [RESEARCH-REFERENCES](sources/RESEARCH-REFERENCES.md) |
| Arşivin kapsamı ve sadakati | [ARCHIVE-COVERAGE](checks/ARCHIVE-COVERAGE.md), [TRANSCRIPTION-NOTE](checks/TRANSCRIPTION-NOTE.md) |
| Yüklenen 32 dosya nasıl doğrulandı? | [PAYLOAD-VERIFICATION](checks/PAYLOAD-VERIFICATION.md) |
| Önceki dosya aktarım eksiğine ne oldu? | [PAYLOAD-TRANSFER](checks/PAYLOAD-TRANSFER.md) — kapanmış aktarım tarihçesi |

## Kaynak ve eser kesimleri

Görünür diyalog arşivi 19 kullanıcı mesajı (U001–U019) ve ilk 18 substantive assistant cevabını (S001–S018) içerir. U019 ilk arşivleme turunun yetkisidir. Sonraki aktarım/yükleme olayları checks kayıtlarında tutulur; özgün diyalog kesimine karıştırılmaz. Ham platform export'u değildir; aktarım sınırı sadakat notunda açık kalır.

Konsolidasyon v0.1 uzmanlık sürekliliğine kadar oluşan görüşleri bütünlüklü metne çevirir. Atlas v0.1 sonraki mekanik modelleme konuşmasının eseridir. Atlas sonrası yaşayan katmanlı plan tartışması U016–U017/S016–S017 ve reflection dosyalarında ayrıca korunur; özgün eserlere sonradan işlenmez.

## Yeniden kullanım sınırı

A–B–C, C–Work etkileşimi, iş ve aktör hazır oluşu, kaynak/yorum/kural ayrımı, mesleki standart, harness ve yaşayan plan burada çalışma hipotezleri/ilkeleri olarak bulunur. Gelecek deneme veya yetkili tasarım bunları sorgulayabilir; aynı fikrin tekrar edilmesi bağımsız doğrulama değildir.

Bu paketin arşivlenmesi Foundation'ın kabul/yetki durumunu, Development OS görevini veya SOUL mimarisini değiştirmez. `AGENT.md` ve `agent/**` değiştirilmemiştir.
