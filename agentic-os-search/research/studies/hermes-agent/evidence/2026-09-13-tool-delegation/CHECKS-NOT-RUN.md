# U12 — Çalıştırılmamış ayırıcı kontroller

**2026-09-13 / NOT RUN.** U12-A/B kaynak araştırmasıdır; aşağıdaki satırlar PASS veya gerçekleşmiş koşu değildir. [A](TOOL-ADMISSION.md), [B](DELEGATION-LIFECYCLE.md), [A kaynakları](TOOL-SOURCES.md), [B kaynakları](DELEGATION-SOURCES.md), [STATE](../../STATE.md).

| Alan | Gerçek ayırıcı ölçüm | Korunan sınır |
|---|---|---|
| Q54 visibility/admission | Actual registry scope/generation, loaded concrete/deferred names, disabled toolsets, final JSON/schema ve handler kabulü ayrı kaydedilsin | Registry entry veya schema varlığı bütün per-agent yetkiyi kanıtlamaz |
| Q54 policy composition | Batch planındaki path'ler ile middleware/pre-hook sonrası gerçek path'ler, lock/scope/authorization ve actual file effects karşılaştırılsın | Son-argüman policy ile önceki paralellik rezervasyonu otomatik eşdeğer değil; gerçek yarış gözlenmedi |
| Q54 proposal/effect/result | Actual DB-backed proposal flush False/None/exception, handler side effect, result flush ve sonraki segment/model çağrısı birlikte ölçülsün | Pre-effect ret ve post-effect belirsizlik ayrı; synthetic result fiziksel rollback değildir |
| Q54 child authority | Parent enabled/disabled, composite expansion, depth/role-granted delegation, exact final child tools ve gerçek dispatch kontrol edilsin | “Daima parent alt kümesi” ve “role grant izinsiz bypass” genellemeleri ikisi de kanıtlanmadı |
| Q54 context/budget/runtime | Parent transcript/prefill/task context ve child ilk request; fresh iteration budget, pinned route/capabilities/fallback; native varyant ayrıca ölçülsün | Constructor argümanı modelin gördüğü exact wire veya toplam alt-ağaç bütçesi değildir |
| Q54 workspace/DB | Child task cwd/container alias; başarılı/başarısız worktree kurulumu; parent db_path ile gerçek registry handle/lifetime karşılaştırılsın | Yeni session ID bütün FS/OS izolasyonu veya bağımsız DB connection garantisi değildir |
| Q54 output/quality | Failed/interrupted/budget-exhausted/schema-invalid sonuçlar; correction turu history/timeout/budget; summary trim/spill ve memory/hook/parent tüketicisi ayrı gözlensin | schema_valid, status=completed veya dolu özet görev/yan etki doğruluğu değildir |
| Q54 control/lifetime | Parent rebuild/rotation ile list/steer/stop ownership; exact UI transport/record; late steer; sync/detached/capacity fallback interruption; worker exit ve close sırası | queued/interrupt_requested/stalled/live-registry drop fiziksel durma veya uygulanmış düzeltme makbuzu değildir |
| Q54 async accounting | Group/unit/slot/child sayısı, concurrent submit, partial acceptance, finalizing/stalling ve error yolları gerçek kaynaklarla izlensin | Tek kapasite parametresi evrensel global child limit olarak doğrulanmadı |
| Q57 completion acceptance | Actual completion producer→queue→host drain→current ownership→claim→parent turn kabulü→ack/DB readback. Normal, restored, eski hedef, interim child failure ve claim-expiry ayrı | Kalıcı sonuç veya queue.put, parent'ın sonucu gerçekten tükettiği anlamına gelmez; bu ilk sonraki dar kaynak birimi |

Diagnostic gerekirse exact source/bağımlılık, önceden oracle ve dar güvenli çevre kurulmalıdır. Kendi fake'inin “başarılı” dönüşünü gerçek kabul ölçütü yapma. Full ürün, gerçek model/provider/credential veya harici backend koşusu mevcut yetkiden türetilmez. Kaynak açıklamasının genişlemesi bütün fault matrisinin bitmesine bağlanmaz.

Q55 native model/system/history/restart ve Q56 terminal/persistence/control; U10 Q49 full run_job, Q51 selector→request/quality, Q52 detection→handling; Q40/Q42/Q47/Q48/Q50 ile diğer eski fidelity/quality/whole-worker sınırları korunur. U04-A/B ve U06/U07/U08/U10 deneyleri yeniden koşulmadı. Yeni kaynak okuması eski deneyi bağımsız tekrar veya daha geniş güvence yapmaz.
