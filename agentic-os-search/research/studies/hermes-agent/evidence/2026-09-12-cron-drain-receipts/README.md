# U08 — Kaynak ve deney paketi

2026-09-12 / U08 yayın checkpoint’i. Güncel ref/content doğrulaması PUBLICATION üst bölümündedir; ham kayıtlardaki local/unpublished alanları ilk teslim tarihçesidir. [RESEARCH](RESEARCH.md), [SOURCES](SOURCES.md), [SPEC](SPEC.md), [RESULT](RESULT.json), [MANIFEST](MANIFEST.json), [NOT RUN](CHECKS-NOT-RUN.md), [PUBLICATION](PUBLICATION.md).

Native source consumer araştırması gateway housekeeping→cron queue→sender→CLI status yolunu açar. Yeni küçük diagnostic yalnız tam `agent/async_utils.py` çalıştırır. B02 gerçek yerel etki sonrası cancel=True; B03 terminal hata sonrası cancel=False. Gerçek ağ/host/SessionDB/fallback/duplicate ölçümü yoktur.

`diagnostic-evidence.tar.xz` içindeki `diagnostic/` özgün source, SPEC, probe, INPUTS, stdout/stderr, RESULT, effect dosyaları ve runtime excerpt/fingerprint kayıtlarını taşır. Kaynak MIT, CPython excerpt'leri kendi lisans bildirimiyle saklanır. N00 identity, N01/N02 observation-validator kontrolleridir. Arşiv/publication doğrulaması yeni test koşusu değildir.

## Yeniden üretim sınırı

Bu araştırma, yeniden çalıştırılmadan source/SPEC/probe/RESULT hash'leri ve local effect dosyalarıyla denetlenebilir. Diagnostic'i yeniden çalıştırmak ayrıca yeni bir recorded run üretir; eski dosyaların üzerine yazılmaz.

Bağımsız test dizinine yalnız `source/`, `SPEC.md`, `probe.py`, `INPUTS.json` kopyalanıp Python 3.13.5 ile `python probe.py` çalıştırılabilir. Önce mevcut kaynak/spec/probe hash bağları kontrol edilmelidir. `run-01` daha önce varsa probe onu overwrite etmez. Bağımlılıklar stdlib'dir; full Hermes kurulumu gerekmez. Ağ/subprocess audit olayları yasaklı, bütün etkiler test dizinindedir. Yerel event loop socketpair'i dış ağ gönderimi değildir.

Sonuçlar source pin ve gerçek runtime'a bağlıdır; başka Python sürümünde aynı sonucu varsayma. B02 barrier ve timeout=0 nedensel sırayı ayırır, gerçek 60 saniyelik transport zamanlamasını ölçmez. Runtime thread'leri aynı process içinde finally ile sonlandırılır.
