# Tarihsel başlangıç metni — ÇALIŞTIRILMAZ

**29 Eylül 2026 / D030:** Aşağıdaki Codex/S00 başlangıç mesajı yürürlükten kalkmıştır. Yeni bir Codex veya Claude oturumuna kurulum görevi olarak verilmez. DevOS'un kurucusu ve ortamı **Claude Code cloud**; tek geçerli plan [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devirdeki sürüm **2.1**'dir.

Yetki izi: [EXP-006 D030](../../DECISIONS.md#d030--claude-code-cloud-kurulum-devri). Bu depo Claude Code ve DevOS için salt okunur araştırma kütüphanesidir. Aşağıdaki komutlar, zorunlu okumalar ve API/servis tercihleri yalnız eski paketin değiştirilmemiş tarihsel içeriğidir; bugünkü uygulama veya yetki kaynağı değildir.

---

## 28 Eylül 2026 kaydı — aşağıdaki metin güncel kurulum talimatı değildir

# Codex’e verilecek başlangıç metni

Bu paketi **DevOS’u inşa etmek** için kullan. DevOS’un bilişsel runtime’ı da Codex olacak. SOUL’un provider bağımsızlığı bir ürün hedefidir; bu inşa sırasında SOUL’un ilk gerçek işini/backlog’unu seçme. Paket bir build specification/runbook’tur, kurulmuş sistem değildir.

Önce paketteki `README.md`, `provenance/P4_v4.md`, `docs/` rehberi ve `phases/registry.json` ile `builder/AGENTS.md` kaynaklarını oku. P4’ün bütün 31 bölümü mandatory başlangıç kaynağıdır. Sonraki stage’de ilgili doküman/sözleşmeye derinleş. Bağlı Research repo erişimi varsa güncel EXP-006 STATE/INDEX/HANDOFF ve P5 kaydını geri oku; bu paketteki tarihsel metinler current yetkiyi değiştirmez. Güncel control kuralları targetın kendi geçerli hiyerarşisinden gelir.

Paket kökünde şu yerel komutları çalıştır:

```sh
python tools/verify_package.py
python tools/check_blueprint.py
python -m unittest discover -s tests -v
```

Bu sonuçları “DevOS testleri geçti” diye sunma; teslimat araçları ve kayıt yapısı denetlenmiş olur. Gerçek app/migration/provider/behavior testlerini stage şartnamelerine göre oluşturup hedefte çalıştıracaksın.

**S00’dan başla.** Hedef repository ve yazma yetkisi verilmemişse eksik olan bu bilgiyi sor; başka repoyu varsayılan target seçme. Hedef verilmişse remote/dal/izin ve mevcut talimatları doğrula. Kirli çalışma alanını silme. `builder/BUILD_STATE.template.json` ve deployment karar template’ini targettaki build alanında başlat; mevcut kayıt varsa üzerine boş template kopyalama.

C01–C08’i actual gözlem ve owner kararlarıyla çöz. Teknik seçimleri önce sen araştırıp gerekçeli öneri üret; kullanıcıyı altyapı uzmanı oracle yapma. Bütçe/veri/servis/yayın izinleri olmadan ücretli kaynak yaratma, gerçek korpus gönderme, key üretme veya production yazma. Sırları sohbetten isteme; bağlı güvenli setup/secret yönetimi yolunu kullan.

P5 referans yolu: typed application + PostgreSQL canlı state + özel body store + ayrı protected publisher/authority fence + managed Codex harness. Provider/host seçimi ancak C kapıları ve actual sınamalarla sabitlenir. Native childlar application function tools taşımaz, MCP kapsamını miras alır; bağımsız yetki/bilgi isteyen rolleri ayrı root session/environment ile bağla. Hosted/API yönerge değişimi yeni session gerektirir. Bu yeni P5 teknik ayrımlarını P4’te zaten kabul edilmiş eski kararlar gibi anlatma.

Her stage spesifik çıktısını, actual positive/negative testlerini, exit/log/source/target/criterion kimliğini ve open riskleri kaydet. Dependency grafiğine göre izinli bağımsız işler paralel yürüyebilir; kritik engeli başka işte ilerledim diye tamamlanmış yapma. State ve handoff yeni oturumda aynı amacı ve gerçek next’i geri kurdurmalı.

S12’ye kadar sistemi kapsamı belirli inşa/commissioning kanıtıyla hazırla. P6 planını ayrı teslim et; genel SOUL yeterliği, gerçek kullanıcı kabulü veya farklı sağlayıcıda çalıştırma sonuçlarını üretmeden başarılı sayma. İlk başlangıç çıktın: doğrulanmış kaynak/target/yetki, açılabilecek aşamalar, gerçek engeller ve ilk scoped inşa işi.
