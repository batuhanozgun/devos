# U01B2 — yeniden uygulanabilirlik ve geri alma bileşen kanıtı

**Bu paket HERMES kurulumu değildir.** İki gerçek, Git blob'u doğrulanmış kaynak modülü; sentetik bağımlılıklar ve geçici dosyalarla inceler. Ana çağrı zinciri veya tüm ürün testi değildir.

## Çalıştırma

Standalone teslimin kökünde:

```sh
python probe.py --source-dir upstream --output NEW-RESULT.json
```

Repository'de önerilen `evidence/2026-09-08-u01b2/` yerleşiminden:

```sh
python probe.py --output NEW-RESULT.json
```

İkinci komut önceki `2026-09-07-u01b/component-probe/upstream/` arşivini kullanır. Kaynak hash'i farklıysa çalışmayı reddeder; mevcut result dosyasını ezmez. Python 3.10+ ve standart kütüphane yeterli; kayıtlı koşu 3.13.5/Linux. Yeni koşu yeni kanıttır, eskisinin tarihini değiştirmez.

## Dosyalar

- `SPEC.md`: ilk koşudan önce belirlenmiş gözlem ölçütleri.
- `probe.py`: deney düzeneği; gerçek caller değildir.
- `RESULT.json`: 2026-09-08 UTC 15:48:02'de başlayan koşunun ham kayıtları.
- `STDOUT.txt`, `STDERR.txt`: aynı koşunun çıktıları. Callback hatası kasıtlı fixture girdisidir.
- `upstream/`: standalone teslimde önceki arşivden doğrulanan exact kaynaklar ve MIT lisansı. Repository yayınında yeniden kopyalamak yerine önceki arşiv kullanılır.
- `06-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md`: bulgular ve kapsamları.
- `PUBLICATION-HANDOFF.md`: gerçek yayın durumu ve güvenli entegrasyon için gereken delta.

## Sınırlar

G01 ve T01–T06, D01, R01–R04 olmak üzere 12 senaryo; G01 içinde 10 gate varyantı. Bunlar ürün kabul testleri değildir. Bazı assertion'ların sağlanması özellikle bir sınırın gözlenmesi demektir. Kod ve SPEC SHA-256'ları RESULT içinde bulunur. Kaynak Git blob'ları önceki arşivle aynıdır:

- batch: `9f38adff284eede4234948f67e99a43752c0926e`
- write approval: `f1e99b46e934595c002c2bc659143fcbc1f9fe8d`

Config, profil/köken sağlayıcısı, callback, guard, single-op mutator ve iki modülü bağlayan adapter taklittir. Provider, credential, kurulu HERMES, gerçek kullanıcı dosyaları veya upstream suite kullanılmaz. Production locking/concurrency ve gerçek replay test edilmedi. T01'de origin'i harness değiştirir; bu bir ürün köken-kaybı bulgusu değildir. Pending tüketimi test edilmediği için kayıt o senaryonun sonunda kalır. R03 önceki bulgunun yeni fixture tekrarı; R04 gerçek thread yarışı değil kontrollü işlem sıralamasıdır.

## Deney düzeneğinin kimlik kontrolü

`HARNESS-CHECK.json`, kaynak kopyasına kasıtlı bir byte-değişikliği eklendiğinde probe'nin modülleri çalıştırmadan ve sonuç dosyası oluşturmadan reddettiğini kaydeder. Bu kontrol içerik-kimliği korumasını sınar; HERMES davranışını, bağımsız doğrulamayı veya tüm ortam izolasyonunu kanıtlamaz.
