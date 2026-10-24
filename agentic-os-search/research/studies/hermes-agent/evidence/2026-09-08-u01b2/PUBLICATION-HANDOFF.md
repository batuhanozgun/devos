# U01B2 — yayın durumu ve aktarım kaydı

## Gerçek durum

**UNPUBLISHED / REPOSITORY CONTINUITY OPEN.** Bu teslim paketi üretilmiş ve bir bileşen koşusu gerçekten çalıştırılmıştır. Bu turun yeni araştırması GitHub main'e yazılmadı. Plan v0.6 canonical olarak yayımlanmadı; canonical araştırma planı v0.5 olarak kaldı.

Tur başı ve tur sonu `main`: `a218acfc20e7ece488709e00a9762166ec970fba`. Bu mevcut commit önceki U01-DOC turuna aittir; U01B2'nin yayın commit'i değildir.

Bu tur GitHub araç keşfinde `create` sorgusu sonuç vermedi. Tam keşif 48 eylem sundu; file/tree/commit/ref yazma eylemi yoktu. Plugin araması GitHub'ın kurulu ve etkin olduğunu gösterdi; başka uygun bağlantı önerilmedi. Yerel `gh` bulunmadı; `git` bulunması doğrulanmış authenticated write yolu olarak kabul edilmedi. Başarısız bir write API çağrısı ya da kullanıcı izin hatası gözlenmiş gibi anlatılmıyor: yazma eylemi sunulmaması gözlendi. Sebebi belirlenmedi. Kimlik bilgisi aranmadı ve erişim sınırlaması aşılmadı.

Dolayısıyla bu ZIP bir kurtarma/aktarım teslimidir. Canonical repo state'inin alternatifi veya kalıcı yeni çalışma yeri değildir. Yeni oturum yalnız main'i okursa bu turun yeni bulgularını göremez; R07 sürekliliği henüz kapanmadı.

## Paket içeriğinin önerilen repository yerleşimi

| Teslim dosyası | Önerilen repository yolu |
|---|---|
| `06-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md` | `research/studies/hermes-agent/notes/06-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md` |
| `README.md`, `SPEC.md`, `probe.py`, `RESULT.json`, `STDOUT.txt`, `STDERR.txt`, `HARNESS-CHECK.json`, `SOURCES.json`, `ACCESS-LOG.json` | `research/studies/hermes-agent/evidence/2026-09-08-u01b2/` |
| Bu yayın kaydı | Aynı kanıt dizininde tarihsel `PUBLICATION.md`; yayımlandıktan sonra bu tarihsel yayın-yok ifadesi güncel STATE yerine kullanılmamalı. |

Standalone `upstream/` kopyaları önceki U01B arşiviyle aynı blob'lardır. Repository'de yeniden kopyalamak gerekli değildir; probe'nin varsayılan yolu önceki arşive gider. Standalone README'de kökteki rapor/yardımcı dosya yolları repository yerleşimine göre yeniden bağlanmalıdır. `MANIFEST.json` bu teslimin byte bütünlüğü içindir; farklı repo yerleşiminin tamamlanmasını doğrulamaz.

## Yayın için gerekli current-state delta

Yazma olanağı olduğunda önce güncel canonical AGENT ve tetiklenen protokoller, ardından güncel araştırma state'i geri kazanılmalı. Aşağıdaki delta eski dosyaların üstüne körlemesine yazılmamalı; o andaki main ile birleştirilmeli.

- **STATE:** U01B2'nin archived-source-bound iki-modüllü yeni koşusunu ekle. Gerçek caller işi hâlâ açık/son upstream isteğinde engellenmiş; araştırma tamamlanmadı. Tarihsel upstream 429 kalıcı erişim yokluğu değildir. Önceki U01B ve U01-DOC kanıtını koru. Gerçek yayın kimliği oluştuğunda onu kaydet.
- **META:** Yeni deney kapsamını ve default-name/serialized-payload, live-preview/target-version, compensation/isolation ayrımlarını aday reuse olarak ekle. Foundation/adoption statüsünü değiştirme.
- **INDEX:** 06 notuna, yeni kanıt girişi ve koşuya route ekle. 04/05 eski bulgularını güncel kanıt diye yeniden numaralandırma.
- **RESEARCH-PLAN:** v0.6 ancak gerçekten birleştirildiğinde kullanılmalı. U01B2'yi sınırlı tamamlanan çalışma dilimi olarak göster; ilk gerçek caller işi yerinde kalsın. Yeni iki ayırıcı takip: gerçek default_name üretim/replay rotası ve rollback sırasında diğer yazarları dışlayan mekanizma. F01–F12 geniş kapsamı koru.
- **SOURCE-LEDGER:** S02 ve S04/H07 aynı arşiv blob'ları bu tur FULL yeniden okundu; yeni H-ID veya upstream freshness üretme. Yeni koşunun tarihi, iki gerçek modül ve açık taklitler; 12 senaryo, G01 altındaki 10 varyant; HARNESS-CHECK'in yalnız kaynak-kimliği negatif kontrolü olduğu kaydedilmeli.
- **OPEN-QUESTIONS:** Q03/Q05/Q06/Q17/Q19 için yalnız ilgili dar evidence ilerlemesini ekle. Default-name payload yeterliliğini ayrı bounded açık soru olarak ekle. Gerçek caller/lock/UI/quality sorularını kapatma.
- **CATALOG:** Yalnız Hermes satırındaki yeni component evidence ve reuse sinyalini güncelle; diğer studies'e dokunma.

Mümkün olduğunda tek atomic tree/commit, force olmadan ref güncellemesi ve main üzerinden geri okuma ile yayın kapanışı yapılır. Yanlış branch, başka study, Foundation, context/Codex veya agent-control değişimi bu paketin kapsamı değildir.

## Bir sonraki araştırma sorumluluğu

Önce bu araştırma kanıtının canonical yayını tamamlanmalı. Ardından upstream erişimi yeniden değerlendirilmeli; sabit pin'deki gerçek caller/dispatch/context zinciri ve U01-C curator bağlantısı açılmalı. Yeni dar sonuçlar bunu ikame etmez. Caller kaynakları erişilemiyorken aynı iki modüldeki varyantları veya belge notlarını sınırsız çoğaltmak devam ölçütü değildir.

Bu teslim kurulum, provider çağrısı, Codex görevi, kullanıcı hesabı işlemi, upstream düzeltme/issue veya SOUL/Development OS mimari benimsemesi yetkisi yaratmaz.
