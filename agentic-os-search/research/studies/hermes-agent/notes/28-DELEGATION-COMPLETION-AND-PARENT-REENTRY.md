# 28 — Alt ajan sonucu ne zaman ana konuşmanın işi olur?

**2026-09-13 / U13 / Q57 source-advanced + bounded manual-selection diagnostic.** Primary c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a / manifest0.21.0. [STATE](../STATE.md), [PLAN](../RESEARCH-PLAN.md), [A araştırması](../evidence/2026-09-13-delegation-reentry/RESEARCH.md), [SOURCES](../evidence/2026-09-13-delegation-reentry/SOURCES.md), [B diagnostic](../evidence/2026-09-13-delegation-reentry/DIAGNOSTIC.md), [SPEC](../evidence/2026-09-13-delegation-reentry/SPEC.md), [MANIFEST/raw](../evidence/2026-09-13-delegation-reentry/MANIFEST.json), [NOT RUN](../evidence/2026-09-13-delegation-reentry/CHECKS-NOT-RUN.md), [PUBLICATION](../evidence/2026-09-13-delegation-reentry/PUBLICATION.md).

## Native modelin yeni bağlantısı

U12 alt ajanı kurup sonucunu kalıcı kayda/kuyruğa kadar izlemişti. U13 gerçek CLI ve TUI/desktop tüketicilerini parent history ve `run_conversation` girişine bağlar. Kayıtlı sonuç, sahiplik, delivery claim, yerel turn-slot, thread scheduling, facade lease ve model turunun bitişi ayrı olaylardır. Doğru oturuma ait olmak onun o anda çalışma hakkını kazandığını göstermez.

CLI, sonucu `_pending_input` kuyruğuna koyduktan sonra ack ister; gerçek `chat` credential/init ve agent kabulü daha sonradır. TUI poller/after-turn yardımcıları ise `_run_prompt_submit` dönüşünden sonra ack ister. Alt işlev bool döndürse de bu iki wrapper False'u tüketmeyebilir. Aynı “delivered” kaydı farklı host'larda farklı kabul eşiğine bağlanır; modelin sonucu kullanmasıyla eşitlenmez.

## Seçki çalıştırmasının gerçek katkısı

Önceden main'e yazılan SPEC'ten sonra sekiz seçilmiş işlev, injected oturum/claim/thread/ack çevresinde çalıştırıldı. D02/D03/D04/D07'de scheduling yokken ack-request; D05'te claimNone sonrası local-running residue gözlendi. D06 exception yolu release yaparken D08 interim boş token final ack'ini tüketmedi. İki test-kopyası değişikliği ilgili ihlal sinyallerini değiştirdi.

Bu tam HERMES modülü/DB/model deneyi değildir: manual parent-file fidelity açık, Thread target çalıştırılmadı, ack gerçek SQL değil sayaçtı. Bulgular source composition'u ayırır; gerçek veri kaybı, ürünün takılması, yanıt kalitesi veya bütün host'ların davranışı değildir. Aynı pinned heartbeat yolu False'u açıkça kontrol edip fire'ı geri alır; bu kaynak karşı örneği genellemeyi sınırlar.

## Bilgi ve yeniden başlatma

Restore pending sonucu tekrar tüketiciye sunabilir, önceki işi yeniden yürütmez. Restored provenance ve pozitif sahiplik; interim notice ile final unit farklı token/dedup koşulları taşır. Kullanıcıya kısa status görünmesi actual model admission değildir. Model bildirimi de tüm child transcript'inin kopyası değildir; üst goals/context ve summary/metadata'dan üretilir. Task-specific context, parent'ın eski çağrısı ve başka kayıtlar ayrı bilgi taşıyıcılarıdır.

## Kapsam ve devam

[A/SPEC](../evidence/2026-09-13-delegation-reentry/RESEARCH.md) yayımlanıp geri okundu; sonra B koşulup özgün kanıtları yayımlandı. [Kapsam değerlendirmesi](../inventory/SCOPE-REVIEW-2026-09-13-U13.md) ardından yapıldı. Q57'nin normal consumer oku ilerledi; actual DB/OS/claim expiry/first-request ve adapter/API doğrulamaları açık kaldı.

**İlk sonraki geniş soru Q58: kurulum→etkin runtime→güncelleme/activation kimliği.** Öğrenme/skill-ledger/sync ve eval/quality aileleri korunur; bütün teslim fault uzayı bitirilmeden geniş kaynak açıklamasına dönülür. Bu not synthesis02/03/04 ve U11/U12 ile birlikte okunacak amendment'tır; dört provisional sentezi değiştirmez, final CORE/Foundation/adoption değildir.
