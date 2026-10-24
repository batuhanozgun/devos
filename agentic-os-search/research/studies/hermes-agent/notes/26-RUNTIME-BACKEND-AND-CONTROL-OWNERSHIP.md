# 26 — Runtime değişince işin sahibi de değişebilir

**2026-09-12 / U11 / PROVISIONAL SOURCE STUDY.** [STATE](../STATE.md), [PLAN](../RESEARCH-PLAN.md), [A](../evidence/2026-09-12-runtime-backend/RESEARCH.md), [B](../evidence/2026-09-12-runtime-backend/BACKEND-OWNERSHIP.md), [A kaynakları](../evidence/2026-09-12-runtime-backend/SOURCES.md), [B kaynakları](../evidence/2026-09-12-runtime-backend/BACKEND-SOURCES.md), [NOT RUN](../evidence/2026-09-12-runtime-backend/CHECKS-NOT-RUN.md), [PUBLICATION](../evidence/2026-09-12-runtime-backend/PUBLICATION.md). Primary c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a; güncel ürün hükmü değil.

## Native açıklamanın yeni ayrımı

HERMES'te requested model/provider, resolver sonucu, kurulan client ve gerçek tur consumer'ı farklı düzeylerdir. `codex_responses` ordinary HERMES döngüsünde bir model taşımasıdır; `codex_app_server` bütün turu ayrı native çalıştırıcıya verir. Ortak facade admission/lease kapsamı korunurken history, tools, compaction ve control sahipliği değişebilir.

Native factory/ensure/start yolu cwd + güncel input'u taşır; HERMES model/system/history/tool alanlarını ayrı native RPC alanları olarak iletmez. Bu, native config ile aynı modelin seçilemeyeceği veya input'ta başka bağlam bulunmadığı anlamına gelmez. **HERMES etiketiyle native effective runtime'ın aynı olduğuna ayrıca kanıt gerekir.**

Aynı native session nesnesi thread'ini sürdürür; HERMES mesajları ise item-completed olaylarından türetilmiş seçici aynadır. Compaction native thread'dedir; yerel transcript aynı özetle yeniden yazılmaz. Checkpoint-required birleşiminin native girişte reddi gerçek olumlu bir kontrol sınırıdır. Fresh/restart resume eşdeğerliği ayrıca açık kalır.

Ordinary tools parent-agent bağlamı ve batch/executor yolundadır. Native built-ins ile curated Hermes MCP listesi aynı yüzey değildir. MCP listesindeki araçların genel dispatch'i, AIAgent'in bütün per-agent policy veya state bağlamının otomatik taşındığı anlamına gelmez. Server açıklamasında sözü geçen bir yetenek exposed listede bulunmayabilir.

Ordinary fallback; client/model/pool/API/compressor/prompt alanlarını yeniden bağlar. Native wrapper'ın hata/retire/kullanıcıya dönüş önerisi ayrı toparlama yoludur. Native interrupt RPC'si ve hard-close terminate/kill kodu vardır; bunların fiziksel bütün etkileri durdurduğu bu tur ölçülmedi.

## Makbuzların ayrılması

Native kaynakta, assistant metni tamamlandıysa turn/completed bildirimi gelmeden deadline'da terminal cevap kabul edilebilen yol vardır. Projection flush başarısızlığı uyarı üretirken result'taki agent_persisted işareti ve completed hesabı ayrı kalabilir. Bunlar **koşullu kaynak bulguları**dır; gerçek eksik DB geçmişi, canlı kalan iş veya kullanıcı zararı gözlemi değildir.

Native post-turn usage/memory-review/persistence karşılıkları gerçekten bulunur. Dolayısıyla “normal finalizer'a gitmiyor → hiçbir bookkeeping yok” tezi de yanlıştır. Uyumluluk, bir katmanın aynı görünümü sağlamasıyla başka katmanın aynı güvencesi taşıması arasındaki farkı kapatmaz.

## Kanıt, önceki model ve devam

U11'de yeni behavioral execution YOK; kaynak S01–S16 farklı full/selected okuma kapsamlarındadır. RESULT veya test puanı üretilmedi. Başlangıç ve A yayımlanıp geri okunduktan sonra B araştırıldı; güncel yayın PUBLICATION'dadır.

Synthesis02 ordinary-loop ve synthesis04 scheduled-work açıklamalarıyla birlikte okunur; önceki dört synthesis dosyası, notes01–25 ve U04–U10 evidence değişmez. Q53 bounded source açıklaması ilerledi; gerçek runtime binding/control/receipt ölçümleri açık. **İlk yeni geniş soru Q54 tool/delegation sahipliği**, Q55 binding/history/restart ve Q56 terminal/persistence/control residual doğrulamalardır. Nihai CORE veya Foundation/adoption kararı yoktur.
