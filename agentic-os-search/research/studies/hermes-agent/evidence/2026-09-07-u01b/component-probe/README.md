# U01B bileşen deneyi

Bu klasör daha önce sohbet eki olarak teslim edilmiş araştırma kanıtının repository kopyasıdır; kurulum paketi değildir. Yayın ve kaynak aktarımı kaydı [../PUBLICATION.md](../PUBLICATION.md)'dedir.

`python component_probe.py` yalnız iki küçük, tam okunmuş ve Git blob'u doğrulanmış upstream modülü sentetik bağımlılıklarla çalıştırır. Python 3.10+ gerekir; kayıtlı koşu 3.13.5/Linux'tur. Standart kütüphane dışında kurulum gerektirmez. İnternet, gerçek HERMES, provider, config veya credential kullanmaz. Yeni koşu varsayılan RESULT.json'u değiştirir; eski kanıtı korumak için `--output NEW-RESULT.json` kullanılabilir.

- `upstream/`: immutable pin'den tam modüller ve MIT lisansı.
- `component_probe.py`: araştırma asistanının deney düzeni; gerçek single-op mutator/guard/profile resolver yerine açık taklitler kullanır.
- `RESULT.json`: gözlemler, kaynak kimlikleri, çalışma zamanı ve sınırlar.
- `STDOUT.txt`, `STDERR.txt`: ilk koşunun çıktıları. Stderr'deki sentetik hata logları beklenen deney girdileridir.

10 assertion'ın karşılanması bir HERMES PASS raporu değildir. Normal rollback kontrolü ile istisna, önizlem ve pending sınırları aynı raporda ayrı gösterilir. Özellikle B04'teki istisna kasıtlı olarak taklit single-op bağımlılığından gelir. Gerçek mutator'ın veya bütün dispatch zincirinin uçtan uca koşusu yapılmadı. D03 gerçek preview fonksiyonunu sınar; gerçek tam yeniden yazım bu testte uygulanmaz, mutator dispatch'i ayrı kaynak okumasına dayanır.

Fixture'lar gözlemden sonra temizlenir. B05'in korunmuş snapshot gözlemi fixture temizlenmeden önceki duruma aittir. Deney ilk keşiften sonra tasarlandığı için bağımsız holdout veya farklı araştırmacı doğrulaması değildir. Bu aktarım turunda deney tekrar çalıştırılmadı; eski zaman damgası yeni bir koşu gibi sunulmaz.
