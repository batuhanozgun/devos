# U01-D3 — Yayın ve süreklilik kaydı

**Tarih:** 2026-09-09. **Hazırlık tabanı:** `9a95b2cf1f8a0460ac6128e1409bf54aa3191022`.

Yeni kaynak/deney dilimi bu kez doğrudan repository yayınına hazırlanmıştır; eski ZIP'in yeniden aktarımı veya eski C/V koşularının tekrarı değildir. Yeni kanıt klasörü `evidence/2026-09-09-review-middleware/`, canonical giriş `notes/10-REVIEW-ADMISSION-AND-MIDDLEWARE-FAILURES.md`.

## Bütünlük

MANIFEST, 19 içerik dosyasının byte boyutu, SHA-256 ve Git blob kimliğini taşır; manifest dahil 20 core dosya. Yerel bu 20 dosyadan hesaplanan recursive Git tree `ce3c4892a2286454c04b511b6a29c5e06834725d` ile GitHub create/readback aynı kimliği verdi. Bu PUBLICATION dosyası o core tree kontrolünden sonra eklenir; bu yüzden manifestin kapsamına dahil değildir.

Exact middleware kaynağı `897e4afc07ba0d78ba928baf39a8573422b648be`, 9277 byte; kaynak ve sonuçlar değiştirilmeden korunur. Core tree bütünlüğü, davranışın tam ürüne genellendiği veya büyük E01/E02 orijinallerinin doğrulandığı anlamına gelmez.

MW01–MW08 koşusu UTC `2026-09-09T08:12:19.368928+00:00`; range checker `2026-09-09T08:13:01.073141+00:00`, Python 3.13.5/Linux. Eski U01B/transport/U01B2/C/V koşuları ve orijinal full-file verify_excerpts.py tekrarlanmadı/çalıştırılmadı. İlk ad-hoc range eşitliği SPEC'ten önce; yeni middleware kriterleri kendi ilk koşusundan önce yazıldı.

## State uzlaştırması

STATE/plan v0.8/META/INDEX/OPEN-QUESTIONS/SOURCE-LEDGER ve yalnız katalogdaki HERMES satırı güncellenir. Önceki 01–09 notları ve eski evidence klasörleri korunur; control/Foundation/context/Codex/başka study değişmez. Q26 full-runtime ve full-fidelity açık kalırken ilk aktif kaynak işi actual pending CLI/gateway/onaylayan/profil/store'a geçirilir. Bu sınırlı geçişin gerekçesi 10/RESEARCH §8 ve plandadır; araştırma bütünü kapanmış sayılmaz.

## Yayın doğrulaması

Git nesne yazıları tek başına main yayını sayılmaz. Yayın kimliği bu dosyanın Git commit geçmişinde ve main ref'inde doğrulanır; force kullanılmadan güncel parent ile ilerlenir. Candidate diff'in yalnız yukarıdaki kapsamı taşıması, main ref ve STATE/10/ham sonuç readback'i final kapanış koşuludur. Hazırlık tree kimliği commit kimliği değildir.
