# EXP-006 — güncel statü

**29 Eylül 2026 / D030 / KURULUM DEVREDİLDİ:** DevOS'un kurulacağı ve çalışacağı ortam **Claude Code cloud**'dur. Geçerli kurulum planının tek evi [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devirdeki sürümü **2.1**'dir. [D030](DECISIONS.md#d030--claude-code-cloud-kurulum-devri), D027 ve D029'un Codex ortam/kurucu kararını geçersiz kılar; eski kararların tarihçesi silinmez.

Bu depo gizli araştırma kütüphanesidir. Claude Code ve DevOS yalnız okur; buradaki eski current/next/S00 ifadeleri kurulum görevi vermez. ChatGPT'nin bu devirdeki işi [depo bakım çalışması](../../REPOSITORY-TRANSITION.md) ile sınırlıdır. Yeni ürün deposu [soul-system](https://github.com/batuhanozgun/soul-system); eski `soul` tarihsel denemedir.

**Kanıt ve erişim sınırı:** Kurulumun devredilmiş olması kurulmuş veya kabul edilmiş DevOS demek değildir. Canlı kurulum ilerlemesi bu STATE'te tutulmaz. Aşağıdaki 74 sayfalık paket ve QA ifadeleri önceki teslim kaydının beyanlarıdır; paket bu tur bulunmuş, arşivlenmiş veya yeniden doğrulanmış sayılmaz. K00–K15 paketiyle S00–S12 paketi ayrı kimliklerdir. Gerçek arşiv erişimi bakım planının A3 aşamasında kapatılır.

---

## 28 Eylül 2026 kaydı — aşağıdaki metin güncel kurulum talimatı değildir

# EXP-006 — STATE

**Durum:** AÇIK / P5 CODEX İNŞA VE KURULUM PAKETİ HAZIR / GERÇEK KURULUM BAŞLAMADI.
**Güncelleme:** 28 Eylül 2026. **Üst plan:** [WORK](WORK.md) v1.9.
**Üst amaç:** SOUL'u geliştirecek ekibin çalışma düzenini SOUL'un gerektirdiği gerçek kabiliyetlerden türetmek.
**Current teslim:** [P5-01](work/P5-01-codex-build-installation-package.md), paket release `P5-1.0.0`. P4 v4 mimari kaynaktır; P5 paketi onun uygulanacak inşa şartnamesidir. Rehberin hazır olması DevOS'un kurulması veya P6 kabulü değildir.

## Son kullanıcı yönü

D029 ile kullanıcı P5'e geçilmesini, yüksek kaliteli kurulum/inşa paketini ve Codex'in hem builder hem DevOS'un bilişsel çalışma ortamı olmasını istedi. SOUL'un Codex/Claude Code'dan bağımsız çalışabilmesi korunacak ürün hedefidir; bugün gösterilmiş taşınabilirlik değildir. İlk gerçek SOUL işlerini kurulacak ekip keşfeder. Bu hazırlık turunda gerçek target repo, ücretli kaynak, API key veya servis oluşturulmadı.

## Hazır olan ve yapılmayan

Paket: 74 sayfalık rehber; S00–S12 arasında 13 bağımlı inşa aşaması; 18 rol profili, 6 ortak çalışma protokolü ve 7 yöntem/skill metni; 30 mantıksal veri ailesi ve 33 komut sözleşmesi; 67 hedef senaryosu; Codex başlangıç metni, pasif builder talimatı ve durum şablonları. Bunlar yeni P5 şartnamesidir; P4'te bütün dosya düzeninin zaten kabul edilmiş olduğu söylenmez.

**Gerçek yerel QA:** Paket araçlarının 50 adlandırılmış testi geçti. 33 komut şeması alt kontrolleri ayrıca gerçek hedef testi sayılmaz. PDF'de 1345/1345 beklenen metin birimi bulundu; geometri/glif/bağlantı ve görsel kontroller yapıldı. Kaynak ZIP yeniden açıldı; 124 manifest üyesinin boyut/hash'i eşleşti. V4 kaynak paketinin 95 manifest girdisi ayrıca doğrulandı.

**Çalıştırılmadı:** 67 hedef senaryosunun tamamı NOT_RUN. Gerçek Codex API/root/child, PostgreSQL, Supabase, protected remote publisher, credential/fence, restore ve bilişsel yeterlik deneyi yoktur. P4'ün önceki 53 testi bu tur yeniden koşulmuş sayılmaz. Yeni 50 test paket/kanıt araçlarınındır. Aynı assistant'ın üretim ve sınamasıdır; bağımsız doğrulama değildir.

## P5 teknik seçimlerinin statüsü

Referans yol typed DevOS application/control plane + PostgreSQL canlı state + özel kaynak/kanıt deposu + ayrı korunan publisher ve geri yüklenen DB'den bağımsız authority fence + Codex harness adapter'ıdır. Provider/host/region/bütçe fiilen seçilmedi; Supabase kabul edilmiş sağlayıcı değildir.

Native child'ların application function tools kullanamaması ve MCP erişim kapsamını miras alması nedeniyle P5, farklı yetki veya gerekli bilgi izolasyonu isteyen rolleri ayrı root session/uygun environment'a bağlar. Aynı güven sınırındaki yardımcı işler native child olabilir. Bu teknik seçim actual S02/H-AUTH sınamasına tabidir. Codex uygulaması ile API üzerinde çalışan DevOS aynı hesap/maliyet kurulumu sayılmaz.

## Gerçek kaynak erişimi

**Current ZIP:** `EXP-006_P5_Codex_Insa_ve_Kurulum_Paketi.zip`, 4209549 byte; SHA-256 `40aee0e270e683b12ee7316406dfb2254a7bf64d8aeffcf215dcd6b54b62c36b`.

PDF/Markdown/başlangıç metni kimlikleri ve QA kapsamı P5-01'de. Tam 125 dosyalık paket konuşma teslim ekindedir; bu repository commit'i tam paketi içermez. [Codex başlangıç metni](work/p5/CODEX_START.md) repository'de ayrıca korunur; tek başına paket yerine geçmez. P5 ZIP içinde exact P4 v4 Markdown ve orijinal kaynak ZIP'si vardır. Hash erişim yolu değildir; ayrıntılı devam gerçek paket veya hash-eşit gövdelere dayanır.

## Sonraki sorumluluk

AGENT → [INDEX](INDEX.md) → STATE → [HANDOFF](HANDOFF.md) → WORK → DECISIONS → P5-01 → gerçek P5 paketi.

**Şimdi:** Hazır P5 paketini kullanıcıya teslim etmek. **Codex'e devrin ilk işi:** `CODEX_START.md` ile S00 kaynak/hedef/yetki preflight'ı. Target repository verilmemişse başka repository seçilmez. C01–C08 gerçek erişim ve owner kararlarıyla çözülür; sırlar sohbetten istenmez. Teknik keşif builder'a, bütçe/veri/yetki/kabul kararları owner'a aittir.

P5 rehberi tamamlandı; actual inşa ilerlemesi henüz S00 bile çalışmış sayılmaz. P6 planı S12 çıktısıdır; P6 kabulü veya ilk SOUL backlog'u bu teslimle başlamaz. Research agent-control, Foundation, studies ve diğer çalışmalar değişmedi.
