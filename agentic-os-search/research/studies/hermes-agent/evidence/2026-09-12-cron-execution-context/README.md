# U10 — Cron execution/context kanıt paketi

**2026-09-12.** [RESEARCH](RESEARCH.md) native açıklama; [SOURCES](SOURCES.md) pinned kapsam; [SPEC](SPEC.md) önceden sabit ölçüt; [RESULT](RESULT.json) özgün yeni koşu; [MANIFEST](MANIFEST.json) byte kimlikleri; [NOT RUN](CHECKS-NOT-RUN.md) sınırlar. Güncel yayın hükmü [PUBLICATION](PUBLICATION.md)'dadır.

`diagnostic-evidence.tar.xz`, tam original scheduler_prompt.py ve MIT notice, SPEC/probe, 10 sentetik input dosyası ve kayıtlı mtimelar, seçilen tam metinler, explicit mutant'lar, log/RESULT ve başarısız attempt-00 kaydını taşır. Target module full-byte; yalnız _inject_context_from çağrıldı. Root/import seams sentetik, file selection/read native. AIAgent/run_job/script/monitor/SQLite/network/provider/full product çalıştırılmadı.

Tek başarılı run: UTC 2026-09-12T07:25:53.109130+00:00–07:25:53.118497+00:00. Altı descriptive expectation, üç dar negative control; eski testler tekrar edilmedi. İlk probe parse hatası ve tek-satır sözdizimi düzeltmesi HARNESS-REVISION'da korunur. Bağımsız replication veya kalite oranı değildir.

## Yeniden üretim sınırı

Ham arşivi ayrı ve boş bir çalışma dizinine çıkar. `python verify_evidence.py` mevcut bytes/recorded outputs bağını read-only kontrol eder; target çalıştırmaz. `python probe.py` ise yeni dosya ve yeni RESULT/INPUTS üretir: sadece bir kopyada, ayrı Python process'inde çalıştır; özgün arşiv ve kayıtların üzerine yeni run yazma. Import seams sys.modules üzerinde kurulur; normal HERMES process'ine import edilmemeli. Model key/credential/full ürün kurulumu gerektirmez; ağ ve subprocess audit ile reddedilir. Böyle bir yeni koşu ayrı tarih/kimlikle kaydedilmelidir.

Bu repo yayın turunda reproduction amacıyla target yeniden koşulmaz. Hash/tar/link/remote-ref kontrolleri aktarım sadakatidir, aynı source iddiasının bağımsız veya whole-product doğrulaması değildir.
