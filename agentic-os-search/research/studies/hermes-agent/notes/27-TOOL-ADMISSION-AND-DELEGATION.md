# 27 — Araç çağrısından alt ajana: kabul, yetki ve sonuç sahipliği

**2026-09-13 / U12 / SOURCE-ONLY, PROVISIONAL.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [STATE](../STATE.md), [PLAN](../RESEARCH-PLAN.md), [A: araç kabulü](../evidence/2026-09-13-tool-delegation/TOOL-ADMISSION.md), [B: delegation](../evidence/2026-09-13-tool-delegation/DELEGATION-LIFECYCLE.md), [A kaynakları](../evidence/2026-09-13-tool-delegation/TOOL-SOURCES.md), [B kaynakları](../evidence/2026-09-13-tool-delegation/DELEGATION-SOURCES.md), [NOT RUN](../evidence/2026-09-13-tool-delegation/CHECKS-NOT-RUN.md), [PUBLICATION](../evidence/2026-09-13-tool-delegation/PUBLICATION.md).

## Native açıklamanın ilerlemesi

Ordinary HERMES aracının adı/şeması, oturumda görünmesi, mevcut çağrının kabulü, gerçek handler etkisi ve sonucun kayıt olması aynı şey değildir. A; pre-effect proposal kaydı, middleware sonrası son argüman policy'si, batch/executor ve post-effect sonuç kaydını bağlar. Bir kapının başarısı diğerini kanıtlamaz; açık kayıt arızasında sonraki işleri durdurmak önceki etkileri geri alma değildir.

Delegation bu zincir üzerinde yalnız farklı bir fonksiyon değil, yeni çalışan ve kontrol ilişkisi kurar. Gerçek factory yeni konuşma/bütçe, seçili goal/context/prefill, araç kısıtları, profile/runtime ve child-owned kayıt sorumluluğu oluşturur. Rol, depth ve çalışma ayarından gelir; modelin legacy rol/bütçe talebi gerçek yetkinin tek kaynağı değildir. Orchestrator rolü delegation'ı ayrıca verebilir; bu host grant, basit alt-küme mirasından farklıdır.

**Yeni konuşma, tam yalıtılmış ortam değildir.** Child task-cwd kaydı ayrı olsa da container/workspace paylaşılabilir; worktree isteği koşulludur ve kurulamama shared workspace'e dönebilir. Parent transcript'i aktarılmayan worker yine görev bağlamı, prefill ve dosyalarla bilgi kullanır. Actual ilk request veya OS izolasyonu bu tur ölçülmedi.

Sync tool sonucu ile detached handle ayrı sözleşmelerdir. Grup, birlikte sonuç teslimi için join birimidir; görev bağımlılık sırası değildir. Aynı çağrının unit'leri bir slot paylaşabilir; slot, unit ve çalışan child sayısı eşit değildir. Origin child kurulmadan yakalanır; kontrol için parent nesne bağına ek durable lineage ve uygun UI çağrılarında exact transport/session-record kimliği vardır.

## Sonuç ve durdurmada dikkat edilmesi gereken ayrımlar

Structured hata, yalnız dolu özet bulunduğu için başarıya çevrilmez. Buna rağmen bütçesi tükenmiş ama kullanılabilir özet vermiş child, `status=completed` yanında `exit_reason=max_iterations` ve `truncated=True` taşıyabilir. JSON Schema doğrulaması görev doğruluğu değildir; schema da child summary'sini doğrulanması gereken self-report olarak tanımlar.

Uzun özetin baş/son görünümü ve full-output spill dosyası ayrı bilgi taşıyıcılarıdır. Summary budget, memory/hook aktarımından önce uygulanır; sonraki tüketici her durumda orijinal tam özeti almaz. Steering queued ile applied, stop requested ile ceased, async stalled terminali ile physical worker exit ayrı olaylardır. Timeout sırasında child.close'un future bitişine bırakılması gerçek sahiplik mekanizmasıdır, evrensel bitiş garantisi değil.

Detached completion DB'ye yazılıp shared queue'ya yayınlanır; restart recovery bazı kaydedilmiş child sonuçlarını koruyup bilinmeyenleri unknown yapabilir. Bu yeniden çalıştırma değildir. Claim/ack/drop ve interim failure/final result ayrımları vardır; **parent'ın gerçek tur kabulü hâlâ ayrı kaynak bağlantısıdır**.

## Kapsam ve devam

A önce main'e yazılıp gerçek ref/tam içerikten doğrulandı, sonra B açıldı. Yeni HERMES import/çalıştırma, model, araç, DB veya upstream test koşusu yoktur. Full/selected okumalar kendi kaynak defterlerindedir; kaynak kontrolü ve repository readback ampirik ürün doğrulaması değildir.

Bu not synthesis02 ordinary turn, synthesis03 devam ve synthesis04 scheduled-work ile birlikte okunacak source amendment'tır; önceki dört synthesis dosyasını değiştirmez, final CORE veya Foundation/adoption oluşturmaz. **Q54 source-advanced; ilk sonraki dar soru Q57 completion→actual host drain/ownership/claim/ack→parent turn.** Sonra kalan aileler için kapsam dengesi yeniden değerlendirilir. Q55/Q56 ve bütün önceki runtime/fidelity/quality sınırları açık kalır.
