# HERMES — Kalıcı iş ve devamlılık: üçüncü geçici sentez

**2026-09-11 / PROVISIONAL HERMES-NATIVE SUBSYSTEM MODEL.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. [U03](../evidence/2026-09-10-kanban-task/RESEARCH.md) ve [U04](../evidence/2026-09-11-multi-turn-continuity/RESEARCH.md) dayanağı; [U04 SOURCES](../evidence/2026-09-11-multi-turn-continuity/SOURCES.md) kapsamı. Bu dosya yeni bağımsız kanıt, nihai CORE, Foundation modeli veya SOUL mimarisi değildir. Önceki [synthesis/02](02-TURN-CONTEXT-AND-SESSION-PROVISIONAL.md) iç tur/oturum modelini genişletir, [synthesis/01](01-LEARNING-AND-CHANGE-PROVISIONAL.md) öğrenme/değişim modelini korur.

## 1. Ana model

HERMES'te bir işi zaman içinde sürdürmek tek bir döngüyle açıklanmıyor. İncelenen yollar üç farklı sorumluluğu birleştiriyor: **kalıcı işin kaydı ve hangi çalıştırmaya ait olduğu; başka bir ajan turu gerekip gerekmediği; o turu gerçekten başlatacak host/tetikleyici.** Bunlara hangi bilginin yeni tura taşınacağı ve sonucun kimin tarafından kabul edileceği ekleniyor.

Bu yüzden kalıcı bir kaydın varlığından otomasyonun halen etkin olduğu, bir worker'ın durmasından işin başarıyla bittiği veya aynı session ID'den aynı bağlamın kullanıldığı sonucu çıkarılamaz. Bu ayrımlar soyut uyarı değil, U03/U04'te farklı alan ve consumer'lara bağlanmıştır.

## 2. Devam mekanizmalarının doğal ayrımı

| Mekanizma | Niyet/durum nerede? | Çalıştırma ve durma ilişkisi | Kanıt sınırı |
|---|---|---|---|
| Kanban task/run/claim | Paylaşılan board DB; task birden çok run taşır | Dispatcher admission/claim; worker terminal transition; recovery yeni deneme açabilir | U03 source + selected/SQLite K; full dispatcher/OS/artifact açık |
| Kanban goal-mode | Board run kimliği + worker içi yerel tur sayacı | İlk quiet turdan sonra continuation/finalize; own-run terminal/superseded ile durma | U04 actual caller kaynak + selected G; gerçek worker çalıştırılmadı |
| Session goal | SessionDB goal:<sid>; optional contract, gates, waits | Post-turn gate/judge; pause/done/park; host devamı kuyruğa verir | S01/S03/S06 source; gerçek judge/gate/driver çalıştırılmadı |
| Session loop | SessionDB loop:<sid>; cadence/tick/awaiting/route | Due tick, response marker/until/repetition cap; tekrar zamanlama | S04/S06 source; restart/in-flight recovery açık |
| Session heartbeat | SessionDB heartbeat:<sid> + canlı driver watch | Due idle prompt; missed intervals coalesce; pause/clear | Tam S05/H diagnostics; driver koşusu değil |

Aynı yardımcı değerlendiriciyi kullanmak eşdeğerlik yaratmaz. Kanban helper WAIT'i CONTINUE yapar; session goal park eder. Session goal gate/failure counter taşır; Kanban helper farklı bütçeyle sınırlanır. Loop'un belirli tekrar sayısı için done olması ile hedefin semantik başarısı ayrı kabul koşullarıdır. Kanban canlılık heartbeat'i bu tablodaki session heartbeat ile birleştirilmez.

## 3. Başlangıçtan kabul edilmiş sonuca

Kalıcı Kanban görevi için source-backed omurga şöyledir: görev/dependency → çalıştırılabilir aday → claim/run → workspace/profile/board bağlama → ilk agent turu → seçilmişse goal-mode devamı → complete/block/review/changes tüketicisi → task/run/event kaydı → sonraki işler/temizlik/bildirim.

Her ok bir transaction değildir. U03 commit sonrası callback hatasının task'ı geri almadığı sınırını gösterdi. U04 başka bir ayrım ekledi: goal helper'ın block sonucu, kalıcı `block_task` başarısının yukarı taşınmış receipt'i olmayabilir. Süreç çıkış kodu, loop outcome, board current state ve semantic quality birbirinin yerine kullanılamaz.

Judge DONE, Kanban'da worker'a finalize istemi üretir; doğrudan task done yazmaz. Review'a devretme ve changes_requested de mevcut worker için doğru durma olabilir, fakat kalıcı işin tamamlandığı anlamına gelmez. Böylece 'devam etme' kararının yalnız başarısızlık değil, meşru sorumluluk devri olduğu görülür.

## 4. Kimlikler ve ömürler

Task ID işin sürekliliğini; run ID belirli denemeyi; claim çalışma hakkını; session ID konuşmayı; turn ID yeni giriş/yürütmeyi taşır. User turn bütçesi, goal turn bütçesi, loop tick bütçesi ve worker max-runtime aynı sayaç değildir. Bunları tek bir 'run' terimine sıkıştırmak hem acceptance hem maliyet açıklamasını bozar.

Bir run superseded olduğunda baştaki goal status kontrolü devamı keser. G06, kontrolle sonraki callback arasında judge zamanı bulunduğunu gösterdi. Bu pencerede yeni callback'e geçilmesini engelleyen gerçek lower-layer lease/authorization ayrı incelenmelidir; sentetik interleaving üretim exploit'i değildir.

Aynı agent nesnesi/same-session, bütün sonraki çağrıların yeni transcript'i taşıdığının kanıtı değildir. S02'nin history aktarımına karşı S10 facade'de admission.conversation_history substitution bulundu. Gerçek admission/history consumer okunmadan ne kayıpsızlık ne kayıp hükmü tamamlanır.

## 5. Durmak ve yeniden uyanmak farklı başarı ölçütleri

Session goal'un waiting durumu pause veya done değildir. Host bariyerin kalkmasını gözlemleyip yeni istemi vermelidir. Loop'ta fire_tick sonrası awaiting_response, başlatılacak işin tamamlanmasını bekleyen ayrı durable durumdur. Heartbeat'te fire sayacı, istemin gerçekten yürütülmesine göre daha erken ilerler; abandon bazı başlamamış fire'ları geri alabilir.

Gateway'de loop watcher persisted state'i route bilgisiyle tararken heartbeat watch listesi bellekte tutulur. Bu inspected-driver farkı, kayıt kalıcılığı ile restart'ta sürücünün yeniden kurulmasını ayırır. Bütün product startup'ları veya platformlar hakkında evrensel resume hükmü çıkarılmaz.

H04: save failure'da canlı heartbeat sayacı ilerlerken disk eski kalabildi. H05: önceden yüklenmiş iki manager iki istem üretebildi; durable count=1 kaldı. Bunlar manager/local-state sınırlarıdır, gerçek gateway duplicate delivery kanıtı değil. Dolayısıyla serialize eden host, persistence receipt ve dispatch acceptance bu modelde açık bağlantılar olarak görünmelidir.

## 6. Devam kararı ne kadar güvenilir?

Judge'ın giriş görünümü sınırlı goal/last-response metnidir; opsiyonel contract/process/delegation bilgisi eklenebilir. Bütün dosyaların bağımsız incelendiği varsayılmaz. Deterministik gate daha somut bir oracle olabilir, ancak doğru kriteri test ettiği ve doğru revision'a bağlandığı ayrıca gerekir. U04, gate komutunun etkinliğini veya gerçek model kalitesini ölçmedi.

Bu yüzden dört ayrımı koruyoruz: kayıtta done, çalıştırmanın durması, üretimin belirtilen kriteri karşılaması ve kullanıcıya doğru teslim. Aynı anda gerçekleşmeleri istenebilir; aynı boolean olmaları gerekmez. Bu model HERMES'in bütün işleri doğru tamamladığına veya tamamlayamadığına karar vermez; hangi kanıtın hangi hükmü taşıdığını gösterir.

## 7. Karşı okuma ve açık kenarlar

En güçlü karşı açıklama, incelediğimiz component boşluklarının actual host/lease/DB consumer tarafından sınırlanmasıdır. S10 bunun somut örneğidir: source wrapper'da görünmeyen history düzeltmesi admission katmanına devredilmiş olabilir. Full runtime olmadan bu telafiyi ne var sayar ne yok sayarız.

Goal/loop/heartbeat'in copy-child/clear-parent migration yardımcıları best-effort'tur; lower save hata bildirimleri ve actual SessionDB publication okunmadan atomik transfer iddiası yok. Gateway route/profile scoping, pending queue cancellation, in-flight tick recovery, task ownership ile session lease ilişkisi açık. Cron, delegation ve process scheduling'in bütün yolları bu tabloya otomatik ithal edilmez.

## 8. Araştırmayı nasıl yönlendiriyor?

U04, sırf aynı küçük helper'larda yeni senaryo üretmek yerine karşılaştırmalı bir açıklama kazandırdı. Şimdi ilk değerli çalışma: **devam kaydı → actual session lease/history seçimi → rotation/restart sonrası driver/queue yeniden bağlama**. Başlangıç S10 admit_durable_turn_lease ve onun actual consumer'larıdır; erişim açılırsa primary yeniden okunur. Ölçüt bir normal devam ve bir kesinti/rotation yolunda saklanan niyetin hangi bağlamla gerçek çalışmaya geçtiğini açıklamaktır.

Bu aşama tüm HERMES tamamlanması değildir. Provider/runtime/backend, delegation/cancel, scheduler/cron/delivery, memory-skill ledger/sync/quality, alternatif UI ve install/eval aileleri açık kalır. Foundation/dört-alan projeksiyonu ve SOUL/Development OS benimsemesi bu geçici modele dayanarak otomatik başlamaz.
