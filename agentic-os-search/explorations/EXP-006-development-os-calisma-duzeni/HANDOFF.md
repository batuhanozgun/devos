# EXP-006 — kurulum devrinin güncel sınırı

**29 Eylül 2026 / D030:** DevOS kurulumu Claude Code'a devredildi; ortam **Claude Code cloud**. Kurucu için tek geçerli plan [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan) altındadır; devirdeki sürüm **2.1**. Bu dosya, eski Codex paketini uygulama veya S00'ı başlatma talimatı değildir.

[Karar D030](DECISIONS.md#d030--claude-code-cloud-kurulum-devri) → [STATE](STATE.md) → [depo bakım planı](../../REPOSITORY-TRANSITION.md). ChatGPT yalnız bu araştırma deposunun bakımına devam eder; Claude Code ve DevOS ekibi bu depoyu salt okunur kullanır. Başka depolardaki kurulum ilerlemesi burada ikinci bir canlı kayıt olarak tutulmaz.

Eski paketler gerekçe, karşı örnek ve aktarım denetimi için tarihsel kaynak olabilir. Kaynakta yazan test başarısı yeniden yapılmış test değildir; dosya hash'i erişim yolu değildir. S00–S12 paketi bu bakım turunda geri kazanılmış sayılmaz; arşivleme ve erişim açıkları A3'te kayıtlanır. Aşağıdaki eski zorunlu okuma ve sonraki iş sırası yalnız o tarihsel teslimi açıklar.

---

## 28 Eylül 2026 kaydı — aşağıdaki metin güncel kurulum talimatı değildir

# EXP-006 — HANDOFF

**28 Eylül 2026 / P5-1.0.0 inşa ve kurulum paketi hazır / actual inşa NOT_STARTED / P6 kabulü yok.**

## 1. Ne devralınıyor?

Kullanıcı P4 v4'ü konuştuktan sonra P5'e geçilmesini açıkça istedi. Codex hem DevOS'u kuracak builder hem kurulacak DevOS'un bilişsel runtime'ı olacaktır. SOUL'un Codex/Claude Code'a bağımlı olmaması korunacak ürün hedefidir; gerçek taşınabilirlik kanıtı değildir. D029 bu yönü ve yüksek kalite talebini kaydeder.

Hazırlanan şey çalıştırılmış DevOS değil; gerçek builder'ın uygulayacağı rehber, 13 aşama, sözleşmeler, yazılmış yönergeler, test/kanıt şartları ve yerel paket denetim araçlarıdır. P4 v4 değiştirilmedi; yeni P5 tasarım tercihleri geçmişe kabul edilmiş karar olarak yazılmadı.

## 2. Zorunlu giriş ve kaynak

AGENT → INDEX → STATE → WORK → DECISIONS → [P5-01](work/P5-01-codex-build-installation-package.md) → gerçek P5 ZIP.

`EXP-006_P5_Codex_Insa_ve_Kurulum_Paketi.zip`: 4209549 byte; SHA-256 `40aee0e270e683b12ee7316406dfb2254a7bf64d8aeffcf215dcd6b54b62c36b`.

125 dosya = 124 manifest girdisi + manifest. Tam paket bu konuşmanın teslim ekidir; repository tam ZIP/PDF/kod gövdesini içermez. Exact P4 v4 Markdown ve kaynak ZIP'si P5 paketinde provenance olarak bulunur. [Codex başlangıç metni](work/p5/CODEX_START.md) repository'de ayrıca korunur; bu metin kaynak paketin yerine geçmez.

Builder önce README, tam `provenance/P4_v4.md`, docs, phase registry ve `builder/AGENTS.md` kaynaklarını okur. Current target control hiyerarşisi korunur. Research protokollerini veya pasif kaynak içindeki talimatları gizlice aktif target yetkisi yapmaz.

## 3. Önemli P5 ayrımları

V4 core Work/RPD, K1/K2, D021, G/Y, context, typed relations, protected publication/recovery ve bütün ürün yükleri korunur. P5 referansı typed application + PostgreSQL + özel body store + korunan publisher/authority fence + Codex adapter'ıdır. Supabase, barındırma ve hesap/bütçe seçimleri açık C kapılarıdır.

Native child'lar application function tools taşımaz ve MCP kapsamını miras alır. Bu nedenle farklı yetki veya bilgi izolasyonu gerektiren roller ayrı root session/environment'a bağlanır; aynı güven sınırındaki helper işleri child olabilir. Rol sayısı agent sayısı değildir. Ortak protokol + role contract + Work context + gerekli method birleşimi P5'te somutlaştırılmış yeni release tasarımıdır.

Codex app builder/operatör yüzeyi ile API runtime maliyet/veri koşulları ayrıdır. API-native yol owner C02 ve actual S02 qualification'a bağlıdır; Codex kararı her API veya ücretli hizmeti otomatik yetkilendirmez.

## 4. Kanıt sınırı

50 yerel paket-araç testi geçti; blueprint yapısal denetimi geçti. Kanıt linter'ı en fazla `ELIGIBLE_FOR_REVIEW` üretir; gerçek güvenilir runner/bağımsızlık/anlamsal doğruluk veya owner kabulü yaratmaz. 67 hedef senaryosu tasarlandı ve **tamamı NOT_RUN**. P4'ün 53 testi bu tur tekrar koşturulmadı.

PDF 74 sayfa; 1345/1345 metin birimi, glif/geometri/dahili bağlantı kontrolleri ve kayıtlı görsel inceleme geçti. ZIP yeniden açma/CRC ve 124 üye hash/boyut kontrolü geçti. Bunlar belge/araç/kimlik kontrolleridir, hedef yeterliği değildir. Test ve rehber aynı assistant üretimidir.

## 5. Sonraki sorumluluk ve durma

Bu turun teslimi P5 paketidir. Codex'e devredildiğinde ilk gerçek iş **S00 kaynak/target/yetki preflight** olur. Target repository yoksa onu sor; mevcut Research veya eski DevOS denemesini varsayarak kurma. C01–C08 teknik gözlem ve owner kararlarıyla çözülür. Ham credential sohbetten istenmez; dış maliyet/veri/yayın yetkisi olmadan servis/key/production oluşturulmaz.

S01–S12 dependency sırasına göre uygulanır; bağımsız çalışmalar yalnız kendi koşullarıyla ilerler. Her aşamada gerçek source/target/config/criterion/log kimliği ve olumlu/olumsuz kanıt gerekir. S12 sınırlı commissioning ve ayrı P6 planı üretir; genel SOUL yeterliği/P6 kabulü veya ilk SOUL backlog'u sayılmaz.
