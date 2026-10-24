# U12 — Incremental yayın ve geri okuma makbuzu

**2026-09-13 / PUBLISHED TO MAIN — SOURCE CONTENT AND CURRENT ROUTES READ BACK.** Q54 başlangıç planı, U12-A ve U12-B sırayla yayımlandı. Bir önceki kaynak dilimi actual main/ref/content olarak doğrulanmadan sonraki büyük dilime geçilmedi. [STATE](../../STATE.md) U12/v0.25, HERMES bütünü ACTIVE PARTIAL. [A](TOOL-ADMISSION.md), [A kaynakları](TOOL-SOURCES.md), [B](DELEGATION-LIFECYCLE.md), [B kaynakları](DELEGATION-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md).

## Gerçek yayın sırası

| Kapı | Gerçek commit | Doğrulanan kapsam |
|---|---|---|
| Q54 başlangıç planı | `0fd4b597002eb478cd1ed913a588ba44fe70edb3` | Parent ead0d6775bd49808afbf496292f526cae1fb20df. Yalnız RESEARCH-PLAN; actual main/ref, tam metin ve tek-path compare. Sonra A başladı. |
| A araç kabulü | `ef51c3f4b1d4d94038a428fa9bac1a21dfda778f` | Parent bc99f6e9661bcbbaba9fb2db7332ebad16756775; root955b3e68aab87a837fe1380e78f441b9b859fab5. İki yeni evidence+STATE. Nonforce main/ref ve üç dosyanın tam geri okumasından sonra B başladı. |
| B delegation ve current girişler | **`12b7f611a4dc8b07c56d48f615232003825be5fd`** | Parent ef51; root **0707a2a26b4b1c6f0f8fb5483b4a89b58329839c**. Compare13 yol:5 yeni+8 güncelleme, silme/taşıma yok. Ref öncesi main ef51, force=false sonrası actual main12b7. |

Bu makbuz B'nin tamamlanmış içerik doğrulamasından sonra yalnız PUBLICATION dosyasını günceller. Kendi gelecek commit kimliğini tahmin etmez; dönen makbuz commit'i actual main/ref/diff/content ile ayrıca kontrol edilir. Yeni branch/PR/force push veya izin/credential değişikliği yoktur.

## Eşzamanlılık ve korunan çalışmalar

İlk main ead0d677, U11 makbuzu6a9a8c48 sonrasındaki Foundation/harness değişikliklerini taşıyordu; compare'da HERMES/control değişmemişti. Başlangıç planından sonra gelen **bc99f6e9661bcbbaba9fb2db7332ebad16756775**, ayrı harness çalışmasını ve onun katalog satırını güncelledi. Bu commit HERMES araştırmasına atfedilmez. A onun güncel ağacına, B A'nın ağacına kuruldu.

**bc99→12b7 compare:** ahead_by2,behind_by0; toplam **15 farklı yol,7 yeni+8 güncelleme**. Yalnız HERMES paketi ve CATALOG HERMES satırı. Katalog farkı1 addition/1 deletion; yeni HERMES satırı ve diğer çalışmaların bulunduğu tablo1–29 ayrıca geri okundu. Başlangıç planı ayrıca tek-file commit'ti; aradaki diğer study değişikliğini kendi kapsam doğrulamamıza karıştırmadık.

Foundation, soul-context, AGENT/agent-control, explorations, diğer studies, METHOD, notes01–26, U04–U11 bütün evidence/yayınlar ve synthesis01–04 değişen yollar arasında yoktur. B'nin compare'ında A'nın TOOL-ADMISSION ve TOOL-SOURCES dosyaları değişmez. U04-A/B ayrımı ve B'nin33 original dosyası korunur; eski açık doğrulamalar kapatılmaz.

## İçerik geri okuması ve bağlı kimlikler

A geri okuması: TOOL-ADMISSION1–42+43–EOF tam, blob37623ce443477cec37d2e1e20474efebb5c427e2; TOOL-SOURCES tam,2d8047ab738b42c0dab040e695f9cf04d6981da2; A STATE tam,6e3c0b792bd3269f4a48920c63e9aa3411b4b899. Bu kontrol B başlamadan yapıldı.

Aşağıdaki B kimlikleri, main'e bağlı immutable **12b7f611a4dc8b07c56d48f615232003825be5fd** commit'inden gerçek fetch ile alındı. Bunlar GitHub'ın döndürdüğü blob'lardır; bütün dosyaların yerel byte kopyasını ayrıca hash'leyip karşılaştırdığımız iddiası değildir.

| Dosya | Blob ve geri okuma |
|---|---|
| DELEGATION-LIFECYCLE.md | `182b872e1cc4923768663f4cac7b92ca6d0bdc3f`;1–50+51–EOF tam |
| DELEGATION-SOURCES.md | `5faf0501303473e78a6432459352cd16f83f4c3e`;tam; S08–S15 full-read/NOT EXECUTED sınırları |
| CHECKS-NOT-RUN.md | `7c2ab5e742f84f84660303f9f540dbee9836ef3d`;tam; planned controls sonuç yapılmadı |
| Note27 | `04757dfc31d452522871c82c8d661b991e3876a5`;tam |
| STATE | `d17b904170af243666f9faf1e344d749821f77f3`;tam; U12/koruma/Q57/cold-start |
| RESEARCH-PLAN | `046e7d2315c155a398b9be7edc47ae56bce51bd2`;tam;v0.25/incremental/kapsam dengesi |
| INDEX | `0646485bb787c9da57fb33c0c85ca6bd1cee8012`;tam; Note27→A/B/kaynak/NOT RUN ve eski yollar |
| META | `4c6411bdbd366271f6b309c5f05c25451d0a81dd`;tam; candidate/reuse/freshness sınırı |
| CURRENT-RESEARCH-MAP | `6c043ef5948c400a30ea82409ab0ce96cf4c5837`;tam; derived status/geniş kalan aileler |
| OPEN-QUESTIONS | `c367273aa59aa8206f01c53eee5c5d6ee1aeed46`;tam; Q54 source-advanced/Q57 next/eski residual'lar |
| SOURCE-LEDGER | `f1b14187c768e214e97dafbb7c0ed6d722f7cedd`;tam; U12 source-only ve eski raw/source kimlik yolları |
| CATALOG | `e4dd2fb66a69fe976159780f183dab9fdfb6d236`;1–29 tablo; whole-file scope native1/1 diff |
| PUBLICATION hazırlanma kaydı | `9837606cd45af4848c139cd6888579cd729bbbc5`;tam; aşağıda tarihsel olarak korunur |

Native diff/ref ve semantik tam geri okumalar kullanıldı. Bu tur yeni recursive repository hash/link validator veya bağımsız verifier koşusu yapılmadı. Yeni source iddiaları S01–S15 primary path/ref/blob/gövde kapsamlarına bağlıdır; yayın makbuzu onları bağımsız davranış kanıtına dönüştürmez.

## Epistemik sınır ve yeni oturum

**Yeni HERMES behavioral execution yoktur.** Child/tool/file/SessionDB/SQLite/model/provider/credential/native process/OS veya upstream suite çalıştırılmadı. RESULT, PASS skoru veya test arşivi üretilmedi. FULL READ kaynak metni kapsamıdır; full-byte/import/dependency closure değildir. Proposal/result persistence, role-granted authority, fresh context/shared environment, completed/truncated, late steering ve logical-terminal/physical-stop sonuçları kaynak sınırlarıyla okunmalıdır; canlı data-loss/yarış/kalite başarısı gözlemi değildir.

U12, STATE/INDEX→Note27→A/B ve iki kaynak defteri/NOT RUN üzerinden eski sohbet ZIP'ine ihtiyaç olmadan geri kazanılır. Güncel next **Q57 completion→actual host drain/ownership/claim/ack→parent turn**. Ardından kapsam dengesi üzerinden learning/skill-ledger/sync/quality ve UI/install/update/eval aileleri yeniden tartılır. Q54 residual, Q55/Q56, U10 Q49/Q51/Q52, Q40/Q42/Q47/Q48/Q50 ve bütün eski fidelity/quality sınırları açıktır. Dört provisional synthesis korunur; final CORE/Foundation/architecture/adoption yoktur.

---

## B yayını öncesi hazırlanma kaydı — tarihsel

# U12 — Incremental yayın kaydı

**2026-09-13 / B PREPARED — B MAIN/READBACK HENÜZ DOĞRULANMADI.** Güncel yayın hükmü gerçek nonforce ref/content/scope kontrolünden sonra bu dosyanın üstüne yazılacaktır. [STATE](../../STATE.md), [A](TOOL-ADMISSION.md), [A kaynakları](TOOL-SOURCES.md), [B](DELEGATION-LIFECYCLE.md), [B kaynakları](DELEGATION-SOURCES.md), [NOT RUN](CHECKS-NOT-RUN.md).

## Tamamlanmış önceki kapılar

İlk main ead0d6775bd49808afbf496292f526cae1fb20df. U11 makbuzu 6a9a8c48204102d592780971a212b363ec97bc98 sonrasındaki Foundation/harness çalışmaları compare ile ayrıldı; HERMES/control değişmemişti. AGENT ve R01–R09 güncel metinleri tam okundu; source corpus yerine control olarak uygulandı.

Q54 başlangıç planı **0fd4b597002eb478cd1ed913a588ba44fe70edb3**, yalnız RESEARCH-PLAN değişikliği; gerçek main/ref, tam plan ve tek-path compare ile doğrulandı. Sonra A kaynak araştırması yapıldı. Arada gelen bc99f6e9661bcbbaba9fb2db7332ebad16756775, yalnız ayrı harness çalışması/katalog satırını değiştirdi; A bunun üzerine kuruldu.

**A commit ef51c3f4b1d4d94038a428fa9bac1a21dfda778f**, parent bc99f6e9661bcbbaba9fb2db7332ebad16756775, root tree955b3e68aab87a837fe1380e78f441b9b859fab5. Compare yalnız üç yol gösterdi: iki yeni evidence dosyası ve STATE. Nonforce update sonrası actual main ef51 idi. TOOL-ADMISSION1–42+43–EOF tam (blob37623ce443477cec37d2e1e20474efebb5c427e2), TOOL-SOURCES tam (2d8047ab738b42c0dab040e695f9cf04d6981da2), STATE tam (6e3c0b792bd3269f4a48920c63e9aa3411b4b899) geri okundu; ancak sonra B başladı.

B ve güncel girişler ef51 tabanına hazırlanır. U12 source-only'dir; yeni test/RESULT/raw binary yoktur. Eski U04–U11 evidence, METHOD, notes01–26 ve dört synthesis korunur; A'nın özgün iki metni de yeniden yazılmaz. B yayımlanmadan ikinci büyük dilim açılmaz. Main ilerlerse current tree korunarak scope yeniden bağlanmalıdır; force yoktur.
