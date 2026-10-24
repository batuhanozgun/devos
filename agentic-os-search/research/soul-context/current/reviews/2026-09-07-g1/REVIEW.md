> **30 Eylül 2026 — tarihsel G1 değerlendirmesi ve G1-R1 onarım önerisi.** Aşağıdaki native sonuçlar, sentetik parser testleri ve çalıştırılmamış gerçek ajan/pilot ayrımı 7 Eylül'deki denemeye aittir. R1 önerisinin sonradan askıya alındığı [yöntem değerlendirmesinde](../2026-09-07-method/REVIEW.md) kayıtlıdır; eski onarım veya deney yeniden başlatılmaz.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Aşağıdaki geçmiş test beyanları yeni hedefin yeterlik kanıtı değildir; özgün bulgular ve yetki sınırları değiştirilmeden korunur.

---

# G1 — Kanıt değerlendirmesi ve sınırlı devam önerisi

**Review ID:** DEVOS-G1-REVIEW-2026-09-07  
**Statü:** STATIC AUDIT COMPLETE; NATIVE PROGRESS SUPPORTED; LAUNCHER CONFIGURATION DEFECT REPRODUCED IN SYNTHETIC REGRESSION; ACTUAL AGENT/PILOT STILL UNTESTED  
**Yetki:** Research-side inceleme ve öneri; yeni Codex görevi, işletim kabulü veya ürün mimarisi değildir.

## 1. Hüküm

G1, önceki D1 ile aynı yerde aynı nedenle durmadı. Seçili native dosya kontrolleri bu kez beklenen sınırı gösteriyor. Mevcut blocker, bu sınırları kullanacak gerçek alt oturumu başlatmadan önce özel yardımcı kodun MCP yapılandırmasını yanlış üretmesi.

Öneri: yeni bir genel sandbox araştırması veya Development OS tasarımı açmak yerine **G1-R1: dar yardımcı düzeltmesi, model çağırmadan regresyon, gerçek başlangıç/araç kapısı ve ancak kapı geçerse mevcut G1 pilotunun devamı**. Değişmemiş kanıt atılmaz; fakat yeni yol/ayar/araç bağımlılıkları eski PASS ile otomatik onaylanmaz. G1-R1 açık kullanıcı benimsemesi olmadan başlamaz.

## 2. Kaynak ve doğrulama kapsamı

`EVIDENCE-EXTRACTS.md` tam arşivin kimliğini, seçili kaynakları ve kontrol sınırlarını taşır. ZIP 123604 byte, SHA-256 `b448be458f6a78e0268240a0b4f648a76359bef2f884cfc6d2c71731225db1c9`; 74 dosya/73 manifest girdisi. Ayrı rapor ve amaç notu ZIP kopyalarıyla byte olarak aynı; checksum eşleşiyor.

Bu asistan arşiv/CRC/hash, plan–intent–komut–profil–sonuç, fixture hash geçişleri, kaynak kimlikleri ve eski G0/D1/C1 karşılaştırmalarını yeniden hesapladı. Bundled script'ler veri olarak okundu; çalıştırılmadı. Yerel Mac, gerçek alt Codex veya bütün config/yan etki alanı yeniden denetlenmedi.

Karşılaştırılan görev: `CODEX-G1-PURPOSE-PILOT.md`, ref `4580f72421f7be5e081eb8770c40e4dd82ca8342`, blob `b6e235b5a4cb0c54624ac10d86dc137da652cda4`. Kaynak izin/ölçüt ayrımları değiştirilmedi. Current STATE'teki eski 'proposed/not dispatched' kaydı, kullanıcının bu dönüşü ve kaynaklı izin beyanıyla sonuç-alındı aşamasına güncellenir; görev tekrar gönderilmez.

## 3. Ne ilerledi, ne ilerlemedi?

11 native kontrolün sınıflandırması kayıtlarıyla tutarlı: gerekli okumalar/yalnız yazıcı çıktısı başarılı, izin dışı okumalar ve korunan girdiye yazmalar engellenmiş. Glob deny kullanan yeni süreç profili, D1'in exact deny sonucundan farklı ve olumlu sınırlı kanıt sağlıyor. Bu karşılaştırma bütün ortamların genel güvenlik kanıtı değildir.

Gerçek agent-shell, etkili instruction/tool görünümü ve kaynaklı pilot çalışmadı. İki `debug prompt-input` çağrısı model başlamadan config hatasıyla sonlandı. 0/8 gerçek model çağrısı, P0/P1 yok, T1–T4/R(P1) yok. `PURPOSE-CONTINUATION-TR.md`, doğru ayrımları taşıyan koordinatör notudur; bağımsız kaynak seçimi veya iki fresh-session deneyi yerine geçmez.

Eski adayın/kanıtların korunması ve durma kaydı olumlu, fakat SOUL veya Development OS kabulü değildir. Sonuç dilinde 'yerel komut kontrolleri geçti' ile 'ajan için birleşik kapı geçti' ayrılmalıdır.

## 4. Doğrudan hata ve tekrar yolu

Hatalı yardımcı, TOML tablo başlıklarını regex ile sunucu adları sanıyor. `[mcp_servers.node_repl.env]` → `node_repl.env` → `mcp_servers.node_repl.env.enabled=false` üretiyor. Böylece sunucu aç/kapa bayrağı, metin değerleri beklenen environment map'ine yazılıyor. Bu, rapordaki ikinci hata ve korunmuş kodla doğrudan uyumlu.

Önceki quote hatası farklı ama ilişkili sınırdır: config dosyasındaki TOML anahtar yazımı ile CLI `-c` yol yazımı aynı parser değildir. Exact sürümün `codex-rs/utils/cli/src/config_override.rs` dosyası, value tarafını TOML olarak ayrıştırırken key tarafını esasen korur. Bu kaynak, quote kaldırma gerekçesini destekler; her olası sunucu isminin CLI'da güvenle yazılabildiğini kanıtlamaz.

Daha derin, sınırlı engineering bulgusu: yardımcı discovery/argument transformation için ayrı sentetik test olmadan canlı yapılandırmaya uygulanmış; ilk düzeltme yalnız ilk hata metnini kapatmış. G0'daki beş sabit ad listesini körlemesine geri getirmek de current coverage'ı ispatlamaz. Asıl ayrım, gerçek üst-seviye sunucu kimlikleri ile onların env/tool alt tablolarıdır.

Önerilen düzeltme, standart TOML ayrıştırması veya gerçekten desteklenen yapılandırılmış kimlik keşfiyle doğrudan `mcp_servers` çocuklarını seçmek; nested değerleri değiştirmemek; yoktan fallback sunucu yaratmamak; CLI argümanlarını ayrı doğrulamak. Açıkça bozuk/kararsız girdi sessiz regex fallback veya daha geniş erişimle onarılmaz. Kullanıcının config'i silinmez/değiştirilmez.

## 5. Burada gerçekleştirilen sentetik karşı-kontrol

Bu dizindeki `PARSER-REGRESSION.py` yeni araştırma-tarafı yardımcı testidir; G1 kaynak paketinin parçası veya kurulmuş çözüm değildir. Eski regex false positive'ı yeniden üretildi. Standart `tomllib` ile yalnız doğrudan çocuk seçen aday yöntemin 14 testinin tamamı geçti.

Vakalar: nested env/tool tabloları; tırnaklı @/slash ve tek-tırnaklı ad; inline table; yorumlar; çok satırlı string içindeki sahte başlık; MCP yokluğu; hatalı TOML; yanlış table türü; mevcut disabled server; literal noktalı/boş adın doğrulanmamış CLI yazımını reddetme; sentetik env değerini çıktıya taşımama.

Bu çalıştırma config dosyası, subprocess, network, credential veya proje dosyası kullanmadı. Regresyon script'i belirli bir güvenli aday yazım altkümesi gösterir, evrensel launcher değildir. Gerçek ayarların bütün kaynaklarını, plugin/managed etkileri, Codex'in birleşmiş ayarını veya gerçek agent isolation'ını doğrulamaz. Codex kaynak/testi eleştirebilir; onu talimat veya zorunlu yeni dependency yapmamalı.

## 6. Bizim görev sınırımızın da düzeltilmesi gerekiyor

G1'in 'tek teknik başlatma/profil düzeltmesi' hükmü açıktı. Codex'in bunu aşıp devam etmemesi uygundu. Şimdi ona 'bunu kendin halletmeliydin' demek verilen sözleşmeyle çelişirdi.

Ancak bu sayacın tasarımı kaba: henüz modele/özel veriye gitmeyen deterministik yardımcı kod düzeltmesi ile erişim sınırı/ölçüt değişikliğini aynı sepete koyuyor. Burada yalnız ikinci sözdizimi kusuru yüzünden kullanıcı yeniden teknik relay olmak zorunda kaldı. Bu bir güvenlik kapısını kaldırma gerekçesi değil; **sınırlı mühendislik serbestliği ile yetki genişlemesini ayrı sınırlama** gerekçesi.

Sonraki öneri bu nedenle geçmiş izni değiştirmez. Açıkça benimsenirse offline düzeltmeye kısa zaman bütçesi, model-free render'a sonlu çağrı bütçesi verir; gerçek model ve etki limitlerini korur. Salt kendi yardımcı kodunu düzeltme sayısı yeni ürün fazı olmamalı. Koruma kriteri ihlali, belirsiz authority veya yeni bağımlılık ihtiyacı ise hâlâ durma nedenidir.

Bu değişiklik, bu çalışma için bir task-budget önerisidir; araştırma agent-control katmanına yeni kural eklenmemiştir. Önceki görevleri yazan asistanın bu review'ı da yapması, bütünüyle bağımsız hakemlik iddiasını sınırlar.

## 7. Sonraki işin anlamlı çıktısı

G1'in asıl amacı değişmez: SOUL ürün amacı / Development OS görevi / anlık iş ayrımını kaynaklarla geri kazanıp iki taze oturumda kullanılabilir iş ve devir üretmek. Kontrol dosyalarını artırmak veya başka bir sandbox raporu bitiş hedefi değildir.

G1-R1, yardımcı düzeltmesinden sonra gerekli gerçek-yol kapısı geçerse G1 §§5–7'ye aynı sınırlı görev içinde devam etmeyi önermelidir. AGENTS byte'ları ve C1/G0/D1/G1 eski kanıtları korunur. Yeni STATE/iş değişiklikleri yalnız ayrı G1 adayı üzerindedir; eski PASS yeni adaya limitsiz taşınmaz. Koordinatör amaç notu pilotun beklenen cevabı olarak enjekte edilmez.

Yalnız daha çok ayrıntı mümkün diye genel hata ayıklama açılmamalı. Tam etkin sınır kanıtı mevcut araçlarla sağlanamazsa etkilenen geçiş açık kalır; güvenceyi sessiz kaldırmak veya kendi kontrolünü başarılı ilan etmek yoktur.

## 8. Seçici birincil kaynaklar ve sınırlar

- G1 uploaded `REPORT-TR.md`, `PURPOSE-CONTINUATION-TR.md`, scripts/controls/native records; ayrıntılı kimlikler `EVIDENCE-EXTRACTS.md`.
- G1 brief, exact ref/blob yukarıda. Önceki direction review ve purpose, G1'in hash'li kaynak snapshot'larından da geri kazanılabilir.
- `openai/codex` commit `3d2ee51ca2d5db578f328aa75e20aa22c0197c9a`, `codex-rs/utils/cli/src/config_override.rs`, blob `61177dd76567f347ee4509da27722c27a459b6bd`: canonical GitHub üzerinden bu tur tam okundu. Yerel binary'nin exact source-build bağı olduğu ileri sürülmez.
- OpenAI, `https://learn.chatgpt.com/docs/config-file/config-reference`, 2026-09-07: `mcp_servers.<id>.enabled` boolean, `mcp_servers.<id>.env` string map; MCP guide'daki diğer configuration/plugin kaynakları ayrı yüzeydir.
- Python, `https://docs.python.org/3/library/tomllib.html`, 2026-09-07: standart TOML parsing ve decode error davranışı. Örneğin kurulmuş runtime'a aktarılması ayrıca sınanır.
- Context-memory-harness study catalog/META yalnız ilgili reuse lens'i olarak geri çağrıldı. Bu review yeni candidate study/temel araştırma/ürün mimarisi oluşturmaz.

Güncel dispatch/sonuç STATE'te, önerilen devam `../../briefs/CODEX-G1-R1-LAUNCHER-CONTINUATION.md` dosyasındadır. Henüz repair grant veya operating acceptance yoktur.
