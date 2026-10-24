# U13-B — Önceden sabitlenen dar diagnostic ölçütü

**2026-09-13 / SPEC BEFORE EXECUTION.** Bu dosya koşu sonucu değildir. [A source research](RESEARCH.md), [SOURCES](SOURCES.md), [STATE](../../STATE.md). Önce A/SPEC gerçek main'den geri okunur; sonra yerel koşu yapılabilir.

## Nesne ve oracle

Pinned TUI notification wrapper'ları ile prompt admission/scheduling arasındaki dönüş sözleşmesi. Seçilecek gerçek işlev gövdeleri: session_notifications `_notif_release_turn`, `_notif_submit`, `_notif_dispatch_event`; prompt_turn `_admit_prompt_turn`, `_run_prompt_submit`, `_dispatch_followup_turn`; async_delegation `complete_event_delivery`/`_event_delivery` gerekirse. Bunlar connector metninden manuel, açık seçki olarak aktarılır. Full parent-file byte/AST fidelity iddiası yoktur; alınan seçki hash'i yalnız o seçkiyi sabitler. Önceden okunan source'la second-pass karşılaştırma bağımsız replication değildir.

Ayırıcı invariant I1: no-exception ile True scheduling aynı şey değildir; kaynak False döndüğünde bu selected notification yolunun kalıcı ack istemesi gözlenirse **ACK_WITHOUT_SCHEDULE** raporlanır. Bu ürün-wide data-loss ispatı değil, caller/return kompozisyonu bulgusudur. I2: caller yerel running yerini aldıysa durable claim reddinde o yerin serbest bırakılıp bırakılmadığı ayrı ölçülür. I3: exception, False ve claim None ayrılmalıdır.

## Sabit vakalar

- D01: normal kabul ve schedule. Thread.start karşılığı çağrıldı mı, ack/release sayısı, running kaydedilir. Model çalıştırılmaz.
- D02: active-session admission açık ret. Gerçek `_admit_prompt_turn`/`_run_prompt_submit` False yolu; schedule=0 iken ack isteniyor mu?
- D03: session closing. Ret, schedule ve ack ayrı kaydedilir.
- D04: admission sonrası farklı live session nesnesi kayıtlı. Son schedule guard False; ack davranışı ayrı kaydedilir.
- D05: durable claim None. Submit hiç çağrılmamalı; yerel running true kaldı mı?
- D06: submit exception. Release ve local running cleanup; ack yokluğu, D02'den farklı olmalı.
- D07: postturn followup gerçek helper'ı False dönüşünde on_done mı on_error mı çağırıyor?
- D08: interim empty claim. Wrapper complete çağrısı ile gerçek empty-token helper'ın durable ack callback'ini çağırmaması ayrılır.

En az iki duyarlılık kontrolü: N01 test kopyasında False'u exception/refusal olarak ilet; D02'de ACK_WITHOUT_SCHEDULE artık oluşmamalı. N02 claim None dalına local-release eklenmiş test kopyası; D05'te running residue değişmeli. Bunlar upstream fix veya yeterli remediation doğrulaması değildir; oracle değişen davranışı ayırt ediyor mu kontrolüdür.

## Çevre ve kanıt sınırı

Yerel Python; gerçek locks/list/counter kontrolü, injected module/globals/agent/session-slot/thread-constructor/ack callbacks. Thread constructor karşılığı gerçek model worker'ını çalıştırmaz. Gateway kurulumu, SessionDB/SQLite, network/OS restart, gerçek credential, upstream suite veya başka araştırma koşusu yoktur. Ack callback'i gerçek DB update yerine gözlem sayacı: yalnız **ack requested** hükmü. Genel teslim/veri kaybı/kalite iddiası üretilmez.

Özgün seçki, harness, ham RESULT/stdout/stderr, input/case kimliği, hash manifesti ve başarısız ilk hazırlık varsa onun kaydı saklanır. Sonuçlara göre başarı kriteri gevşetilmez. Bulgular invariant ihlalini açık raporlayabilir; bütün vakaların koddan beklenen izi üretmesi ürün PASS skoru sayılmaz. Runtime/source/publish doğrulamaları ayrı kalır.
