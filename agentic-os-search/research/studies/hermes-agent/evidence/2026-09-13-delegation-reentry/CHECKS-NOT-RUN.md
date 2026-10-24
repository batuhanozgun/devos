# U13 — Açık kalan doğrulamalar

**2026-09-13 / NOT RUN — aşağıdakiler sonuç veya PASS değildir.** [A](RESEARCH.md), [B](DIAGNOSTIC.md), [SPEC](SPEC.md), [MANIFEST/raw](MANIFEST.json). D01–D08/N01–N02 yalnız manuel işlev seçkisi ve injected çevredir.

| Açık ölçüm | Neden B bunu kapatmıyor? |
|---|---|
| Tam parent-file byte/AST ve gerçek dependency closure | Üç dosyadan manuel seçki; yerel hash yalnız seçki kimliği. Tam upstream modülleri import edilmedi |
| Gerçek `_notif_handle_event`→slot→claim race ve başka release yolları | Başlangıç running=True caller precondition olarak verildi; gerçek poller/concurrency çalıştırılmadı |
| Actual SessionDB/SQLite claim expiry/complete rowcount/DB failure | Ack sayaçtır; durable update'in gerçekten yazılması ve dönen False'un telafisi gözlenmedi |
| CLI ack→volatile pending input→staging arasındaki süreç kesilmesi | Kaynakla koşullu pencere; OS crash ve başka recovery yolları sınanmadı |
| TUI schedule→thread scopes→facade lease→first model request→terminal | Thread.start gözlemci, target yürütülmedi; model/SDK/credential/gateway yok |
| Normal/restored/expired/interim tüketimin tam host entegrasyonu | Source trace ilerledi; D08 yalnız boş-token helper'ı, actual restore/age/queue/DB değil |
| Messaging adapters ve API self-wake | Pinned CLI/TUI sonuçları bütün gateway/platformlara genellenemez; mutable docs başka sürüm olabilir |
| Task-specific context ve notification formatting→model-visible payload | Formatter source + önceki producer karşı okuması; lossless bütün bağlam veya gerçek omission/quality ölçümü değil |
| Heartbeat source karşı örneği | Bool tüketimi/abandon koddan görüldü; bu tur heartbeat runtime deneyi yok |

D02/D03/D04/D07 seçkide I1, D05 seçkide I2 ihlalini gösterir; N01/N02 test değişikliği duyarlılığıdır, ürün remediation doğrulaması değildir. Source/publish/original hash kontrolleri runtime güvenliğine yükseltilmez.

Q54 residual ve Q55/Q56 native binding/persistence; Q40/Q42 actual DB/quiet/startup, Q47 timing/store, Q48/Q50 transport/cancel, U10 Q49/Q51/Q52 ve bütün önceki quality/fidelity soruları açık. Full ürün/model/credential/OS kurulumu veya upstream patch mevcut yetkiden çıkarılmaz. Sonraki geniş Q58 kaynak araştırması bu borçları bitirme koşuluna bağlı değildir.
