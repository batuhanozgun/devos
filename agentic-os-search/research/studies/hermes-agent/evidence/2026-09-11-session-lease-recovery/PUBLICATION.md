# U05 — Yayın ve geri okuma kaydı

**2026-09-11. Bu kayıt yayın doğrulamasıdır; HERMES davranış testi değildir.** [Araştırma](RESEARCH.md), [kaynak sınırları](SOURCES.md), [henüz çalıştırılmamış kontroller](CHECKS-NOT-RUN.md), [güncel STATE](../../STATE.md).

## Doğrulanan içerik yayını

- Repository: `batuhanozgun/agentic-os-search`.
- Başlangıç ve yayın öncesi tekrar okunan main: `ac3cac0139dbfd6bd86773549c93172abcea4484`.
- Başlangıç tree: `64c7b22abb209feda50cc51e1612b4f2600d124b`.
- U05 içerik commit'i: **`88ee2d6b19688fc26b46a31b4202779676f79b60`**.
- İçerik tree: `e5dcdbc36324ba969882ef281558d0d0d4f6122a`.
- Commit parent'ı başlangıç main'dir. Native compare sonucu ahead_by=1, behind_by=0; merge-base başlangıç commit'i.
- Main ref **force=false** ile ilerletildi. Ardından `git/ref/heads/main` tekrar okundu ve gerçek ref'in içerik commit'ini gösterdiği görüldü. Yeni branch/PR veya force push kullanılmadı.

Bu dosya yukarıdaki doğrulanmış içerik commit'inin ardından eklenen yayın makbuzudur; kendi gelecek commit kimliğini önceden bildiğini iddia etmez. Sonraki oturum bu dosyanın commit'ini ve ancestry'yi Git'ten ayrıca okuyabilir.

## Kapsam karşılaştırması

Başlangıç → içerik commit native karşılaştırmasında **12 dosya** değişti: beş yeni U05 dosyası, altı mevcut HERMES giriş kaydı ve CATALOG'daki tek HERMES satırı. Silinen veya yeniden adlandırılan dosya yoktur.

Yeni dosyalar:

- `research/studies/hermes-agent/notes/20-SESSION-LEASE-HISTORY-AND-RECOVERY.md`
- `research/studies/hermes-agent/evidence/2026-09-11-session-lease-recovery/SOURCES.md`
- `research/studies/hermes-agent/evidence/2026-09-11-session-lease-recovery/RESEARCH.md`
- `research/studies/hermes-agent/evidence/2026-09-11-session-lease-recovery/CHECKS-NOT-RUN.md`
- `research/studies/hermes-agent/inventory/LEASE-RECOVERY-COVERAGE-2026-09-11.md`

Güncellenen HERMES girişleri: `STATE.md`, `META.md`, `INDEX.md`, `RESEARCH-PLAN.md`, `OPEN-QUESTIONS.md`, `SOURCE-LEDGER.md`. Plan v0.18, Q40–Q43'ün source ilerlemesi, U05 cold-start yolu ve açık next-consumer/restart soruları bu girişlerde kayıtlıdır.

**Korunanlar:** AGENT/agent-control, Foundation, diğer araştırma dosyaları, research/root ve studies INDEX, HERMES METHOD, notes/01–19, önceki bütün evidence ve merkezi synthesis/01–03 karşılaştırmanın değişen yollarında yoktur. Önceki coverage dosyaları değiştirilmedi; U05 ayrı kapsam eklemesidir. Bu makbuzun eklenmesi içerik commit'ine göre yalnız bu yeni dosyayı eklemeyi amaçlar; son ref/diff geri okuması ayrıca yapılır.

U04-B `delivery/` dizini içerik commit'inde tekrar sorgulandı; native subtree **`d01c92f7414713300934be3bb4e3d40ac57631b3`**, önceki özgün teslim kimliğiyle aynı kaldı. A/B kayıtları yeniden gönderilecek iş sayılmadı; aynı G/H numaraları birleştirilmedi. Bu koruma kanıtı eski deneylerin bağımsız tekrarlandığını veya gerçek ürün kapsamının büyüdüğünü göstermez.

## Katalog byte kontrolü

Başlangıç CATALOG blob'u `c1e48cc7ffd0ef8eb83992001bf1917ada2696d8`. İlk yerel aktarımda gstack seçim maddesindeki bir virgül/boşluk yanlış kopyalandığı için hash eşleşmedi; bu yerel kopya yayımlanmadı. Dosya doğrudan immutable blob üzerinden yeniden okundu, aktarım düzeltildi ve UTF-8 byte'larından Git blob SHA-1 yeniden hesaplanarak başlangıç kimliğiyle eşleşti.

Tek HERMES satırı değiştirildikten sonra hesaplanan CATALOG blob'u **`5158f67e0269eaeeebd0b2e89ea5cc6bc1de7677`** oldu. İçerik commit'inden dönen gerçek CATALOG blob'u aynıydı. HERMES satırı çıkarıldığında before/after kalan byte'ları eşit; native compare CATALOG için **1 addition / 1 deletion** gösterdi. Gstack veya başka aday satırı/rehber maddesi değiştirilmedi.

## İçerik geri okuması

Ref'in main'e bağlanması tek başına yeterli sayılmadı. Aşağıdaki dosyalar içerik commit'inden doğrudan path/ref ile geri okundu; söz konusu readback'lerde beklenen U05 içeriği ve açık sınırlar görüldü. Stored-response paging yerine doğrudan canonical dosya okumaları kullanıldı.

| Dosya | Geri okunan blob | Kapsam |
|---|---|---|
| STATE.md | `cc06eaed5d000c852995afd27225498e4a845765` | Tam metin; v0.18, yetki, U04 koruma, U05 cold-start ve ilk sonraki iş. |
| notes/20-SESSION-LEASE-HISTORY-AND-RECOVERY.md | `df516c1fecb150e2578447da08fba040592dfaa5` | Tam metin. |
| U05/SOURCES.md | `1250ee0b53f218064723b80ef5e5fa6ce14fc891` | Tam metin; FULL/SELECTED/PARTIAL, source429, execution ayrımı. |
| U05/RESEARCH.md | `886b4b18ab945c50b1ae10f822ff009d64fe89fc` | 1–64 ve 65–EOF, aralıksız tam metin. |
| U05/CHECKS-NOT-RUN.md | `6fc886bf5a991173730ceb6872765ab96124bb86` | Tam metin; kontrollerin henüz koşulmadığı açık. |
| inventory/LEASE-RECOVERY-COVERAGE-2026-09-11.md | `1de65f278c9dfe4dba80d82b785d210a0366a7f0` | Tam metin; soru kimlikleri, geniş kapsam ve açık sınırlar. |
| research/studies/CATALOG.md | `5158f67e0269eaeeebd0b2e89ea5cc6bc1de7677` | 18–20 satırları + tam dosyayı bağlayan yerel/native blob eşleşmesi. |

Diğer mutable giriş dosyalarının yazımı native tree/commit ve karşılaştırmada görülür; bu tablo onların tümünü yeniden tam okuduğunu iddia etmez. Eski dosyaların korunması bu tur onların bütün içeriğinin yeniden araştırılması demek değildir.

## Araştırma ile yayın doğrulamasının sınırı

U05, actual admission/root-lease/quiet-history/rotation/meta-writer/driver kaynaklarını inceledi. **Yeni HERMES execution, actual SessionDB fault injection, process restart, model/provider çağrısı veya upstream test koşusu yapılmadı.** Source açıklamasının derinleşmesi bu kanıt türlerini yaratmaz. Yerel katalog hash/diff kontrolü de HERMES testi değildir.

`hermes_state_messages.py` 210–375 erişimi 429 ile durdu; actual resume/history projection ve guard'ın kalanı, next-request trace, startup/adapter kabulü ve in-flight recovery açık. Bunlar tamamlandı olarak kaydedilmedi. Primary kaynak pin'i değişmedi; whole-system completion, Foundation projection, SOUL/Development OS mimarisi veya adoption kararı verilmedi.
