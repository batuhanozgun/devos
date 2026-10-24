# U01-M4 — Bellek değişikliği ile stored prompt seçimi

2026-09-10. PINNED SELECTED SOURCE + BOUNDED EXECUTION; full request/CLI/gateway/compression doğrulaması değildir. [RESEARCH](../evidence/2026-09-10-prompt-restore/RESEARCH.md), [SOURCES](../evidence/2026-09-10-prompt-restore/SOURCES.md), [SPEC](../evidence/2026-09-10-prompt-restore/SPEC.md), [RESULT](../evidence/2026-09-10-prompt-restore/RESULT.json), [probe](../evidence/2026-09-10-prompt-restore/probe.py), [PUBLICATION](../evidence/2026-09-10-prompt-restore/PUBLICATION.md).

## Yeni açıklama

`_restore_or_build_system_prompt`, geçmiş ve kullanılabilir/uyumlu DB sistem mesajı varsa o metni yeniden seçebilir; yeni store'un bellek görünümü ayrı kalır. Runtime karşılaştırıcısı model/provider/cwd/platform'u kontrol eder, o işlev içinde memory revision karşılaştırılmaz. `invalidate_system_prompt` cache'i temizleyip store'u yeniden yükler; tek başına DB stored mesajını değiştirmez. Gerçek compression caller'ının sonraki işlemi ayrıca belirleyicidir.

Koşu UTC `2026-09-10T16:11:51.320434+00:00`. Beş exact archived M2 modülü + yeni kaynaktan altı manually selected definition, sentetik DB/agent/reduced builder ve açık callback taklitleriyle kullanıldı. V01–V08: başarılı onaydan sonra eski DB prompt'unun seçimi; no-history/null/read-error ve runtime mismatch rebuild; reload/invalidate/explicit persist ayrımı; onaylı silme; writer ve DB arızaları; kontrollü capability-refresh/failure dalları. Sekiz grubun beklentileri eşleşti. Full-source pre-import ve local-selection identity reddi; ayrı always-true/false comparator mutantları yanlış seçime duyarlılığı gösterdi.

Bu çalışma yeni bir deney içerir; AP arşiv kapanışıyla karıştırılmaz. Dosyaların yayımlanması ise deneyin yeniden yürütülmesi veya ek davranış doğrulaması değildir. Eski N/A/SA/AP paketleri yeniden koşulmadı; M2 setup/helper'ı ve fault modeli ortak olduğu için independent corroboration sayılmaz. Selected file hash, tam parent byte fidelity değildir. Full prompt builder, actual SQLite, real Bot Chat probe, UI/cache/compression/request ve provider çalıştırılmadı. V04 invalidate→restore sırası harness tarafından kuruldu; actual compression bug'ı değildir.

## Açık halka ve sentez

Gerçek loop seçiciyi turn_context'e verir, ardından ayrı request/preflight/retry fazlarına geçer. İlgili phase gövdelerine erişim 429 nedeniyle kapanmadı; selected cached prompt son outbound request diye adlandırılmadı. Q07/Q22 bounded olarak ilerledi, end-to-end hâlâ OPEN.

[İlk geçici öğrenme/değişim sentezi](../synthesis/01-LEARNING-AND-CHANGE-PROVISIONAL.md) bu sonucu eski notlarla birleştirir ve açık kenarı gösterir. [Kapsam değerlendirmesi](../inventory/SCOPE-REVIEW-2026-09-10.md) gereğince şimdi genel turn/context/session ve geniş topoloji kontrolüne geçilir. Visibility eksikleri bunun içindeki yük taşıyan köprülerdir; aynı küçük testler çoğaltılmaz. İş otoritesi [STATE](../STATE.md), plan v0.13.
