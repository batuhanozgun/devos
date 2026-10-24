# U05 — Sonraki doğrulama tasarımı (NOT RUN)

2026-09-11. Bu dosya deney sonucu, SPEC'i uygulanmış probe veya test sayacı değildir. [RESEARCH](RESEARCH.md) source-only'dir. Kontroller, bir sonraki izinli teknik birimde kaynak ve araç koşulları uygunsa ele alınacak falsifiable hedeflerdir. Yeni model/provider/credential, ürün kurulumu, ağ/izin ayarı veya upstream mutation yetkisi vermez.

## Kabul edilebilir kanıt kurulumu

Primary commit'ten alınan gerçek caller/facade/DB/consumer kimlikleri kaydedilmeli; local source byte/AST sadakati özellikle yürütülen gövdelerde doğrulanmalı. Geçici DB ve ayrı HERMES_HOME kullanılmalı. Model yanıtı kontrol edilirse hangi sınırda taklit edildiği açık olmalı; **admission veya history-reload davranışını testin kendisi üretmemeli**. Gerçek SQLite kullanan dar adapter'ın actual SessionDB olmadığı yazılmalı. Beklenen sonuçlar koşudan önce sabitlenmeli, tüm ham mesaj/history/receipt ve hatalar saklanmalı. Upstream'in kendi test beklentisi bağımsız oracle değildir.

| Kontrol | Koşul ve ayırt edici gözlem | Taşımadığı hüküm |
|---|---|---|
| Quiet ordinary next-turn | İki continuation, no contention/no rotation; H0, first result messages, DB rows, second admission history ve actual next-consumer mesajları ayrı kaydedilsin. P1/A1'in hangi sınırda var/yok olduğu görülsün. | Disk kaybı veya bütün CLI/gateway yolları. |
| Waited reload | Başka holder transcript'i ve mümkünse compression tip'i değiştirsin; admission beklemeden önce/sonra history ve resolved ID ölçülsün. Reload edinmeden önce gerçekleşmemeli. | Clock/callback ile waited=True koymak gerçek contention testi değildir. |
| Immediate rotated recovery | Bekleme olmadan stale parent ile giriş; transitive tip, loaded history, ikinci tip doğrulaması, cached prompt ve flush identity izlenmeli. | Unreadable/ambiguous tüm lineage varyantları. |
| Lease failure/abort | DB busy veya interruption sonrası gerçek conversation-loop consumer çağrı sayısı, early result, holder cleanup ve sonraki tur etkisi kaydedilsin. | Boolean veya API-count alanını kendi fake'imiz döndürürse gerçek non-execution ispatı olmaz. |
| Holder/fork/root fence | Parent ve compression child aynı root için; explicit fork ayrı anahtar için yarışsın. Successor holder geldikten sonra eski refresher/release/flush sonucu ölçülsün. | Transcript fencing, bütün araç etkilerinin exactly-once olması değildir. |
| Loop migration storage fault | Gerçek SessionDB'de child-save ve old-clear ayrı fault noktaları; agent DB ile helper DB path/profile kimliği, iki key ve transcript lineage önce/sonra snapshot'ları tutulmalı. | Eski B:H09 reduced fixture'ını tekrar koşmak bu kontrolü yerine getirmez. |
| Restart before/after tick admission | DB awaiting_response=False/True; fire-save, adapter admission, turn persist, post-turn complete arasındaki kesintiler ayrı. Yeni process'te gerçek startup watcher ve adapter kullanımı gözlensin. | Manager'ı yeniden kurmak process restart + driver recovery değildir. |
| Heartbeat reactivation | Persisted state ile boş watch; gerçek /heartbeat registration, rotation rebind ve source route yeniden kurulsun; hangi olayın firing'i canlandırdığı kaydedilsin. | DB'de JSON bulunması otomatik çalışabilirlik değildir. |

## Önce kapanması gereken kaynak eksikleri

`hermes_state_messages.py` 210–375 continuation (önceki 429), actual resolve_resume_session_id/get_messages_as_conversation ve bunların flush consumer'ları; `gateway/run_startup.py` watcher launch; command/adapter/FIFO admission/receipt; gerekiyorsa actual CLI resume/history propagation. Bunlar kaynakları eksik bir fake ile doldurularak completed sayılmaz.

İki rakip açıklama canlı tutulur: ordinary quiet caller history devretmiyor olabilir; alt actual consumer başka bir koşulla telafi ediyor olabilir. Restart'ta awaiting_response scan'i durdurabilir; başka startup/command consumer'ı kaydı toparlıyor olabilir. Kontrolün amacı seçilen açıklamayı onaylamak değil, bu geçişleri ayırmaktır.
