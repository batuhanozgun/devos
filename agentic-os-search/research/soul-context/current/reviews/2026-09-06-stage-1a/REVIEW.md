> **30 Eylül 2026 — tarihsel Stage-1A değerlendirmesi ve G0 önerisi.** Aşağıdaki aday desteği, kesinti düzeltmesi ve deney sırası 6 Eylül'deki Codex denemesine aittir; bugün kurulacak DevOS'un kapsamını veya çalışma yetkisini belirlemez. Bırakma kaydı olmadan kesinti karşı örneği ve aday/deney/kabul ayrımları kaynak olarak korunur.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Kaynak yanıtın eski byte/satır/hash kimlikleri eklenen not hariç özgün gövdeye aittir; G0 önerisi yeniden uygulanmaz.

---

# S1A — Somut başlangıç sözleşmesi değerlendirmesi

**Review ID:** DEVOS-S1A-REVIEW-2026-09-06  
**Tarih:** 2026-09-06  
**Hüküm:** READY TO PROPOSE A BOUNDED LOCAL EXPERIMENT WITH ONE EXPLICIT RECOVERY AMENDMENT; NOT OPERATIONALLY ACCEPTED  
**Rol:** Research-side bootstrap danışmanlığı. Foundation bulgusu, kalıcı agent-control, verilmiş G0 yetkisi veya çalışan Development OS sertifikası değildir.

## 1. İnceleme nesnesi ve kanıt sınırı

Kullanıcının ikinci `Yapıştırılan markdown.md` eki baştan sona okundu. Bu S1A yanıtıdır; aynı isimli önceki S1 ekiyle karıştırılmamalıdır. [CODEX-RESPONSE.md](CODEX-RESPONSE.md) kaynak metnin değiştirilmemiş kopyasıdır.

- Ek kimliği: `file_00000000b580820abc23d3af95bc942f`.
- UTF-8 boyutu: 24.164 byte; 417 satır; sonunda newline yok.
- SHA-256: `a3247befbe5e5648d1bda6fb6a2a8f5bb69ed9fab574142916b0c6255773cf5e`.
- Git blob: `7486c3c1034eec067186d1fdc3e5c2cadc61d52a`.
- Koruma commit'i: `5596ee7cd9c50734016eaae5e6669cb58aa00579`.
- GitHub readback aynı blob kimliğini döndürdü. Bu byte-sadakat kontrolüdür, kaynakta iddia edilen bütün eylemlerin doğrulanması değildir.

İlk üç fenced block sırasıyla aday `AGENTS.md`, `STATE.md`, `work/BOOTSTRAP-001.md` metinleridir. Dördüncü block yalnız CLI örneğidir. Block gövdesinin kapanış fence'inden önceki newline'ı dahil alındığında:

| Aday | Byte | Git blob |
|---|---:|---|
| AGENTS.md | 6578 | `4817bda880f5872f146dcad31d59efa71ebf1597` |
| STATE.md | 1327 | `2a01fbeade6474186ceb760840da61a091c9aac8` |
| work/BOOTSTRAP-001.md | 9216 | `b62ad2e2d8a83fa988cb7aa3f9f1495d4d21c12d` |

Bunlar kurulmuş dosyaların hash'leri değil, kaynak metinden hesaplanan taslak kimlikleridir. G0'ın benimsediği dar düzeltme ve gerçek yetki alanlarının doldurulması yeni aday kimlikleri üretecektir.

Karşılaştırılan görev: `DEVOS-BOOTSTRAP-S1A-2026-09-06`, ref `45a807ed3fe934c5aba19a840c953a3dee30669b`, brief blob `4eb655c6e67287ae21cde28bdbaec434f7e1a138`. Önceki S1 review ve research-side STATE ile birlikte değerlendirildi. Codex'in bütün kaynak okumaları, yerel CLI yardım çıktısı ve yerel no-mutation beyanı bağımsız yeniden çalıştırılmadı.

## 2. Sonuç: yeni bir genel tasarım turu gerekmiyor

S1A istenen somutlaştırmayı büyük ölçüde karşılıyor: gerçek aday metinler, geçici yetki ile işletim kabulünün ayrımı, sürüme bağlı değerlendirme yolu, tek-yazıcı kapsamı, dört deney ailesi ve platform önkoşulları artık görünür.

Üç belge yüzeyini ve mevcut Git araçlarıyla kaynak/devir pilotunu korumak makul. Yeni kalıcı denetleyici, protokol klasörü, yönetici ajan veya scheduler eklemek için bu inceleme gerekçe üretmiyor.

**Öneri:** aşağıdaki dar kesinti düzeltmesi ve yürütme sınırları kullanıcı tarafından benimsenirse tek bir G0 işiyle yerel aday hazırlama + sınırlı deney + ayrı teknik değerlendirme yapılabilir. Daha geniş işletim kabulü ve ürün çalışması ayrı kalır. Bu rapor G0 vermez.

## 3. Önceki dört açıklığın durumu

| Önceki konu | S1A'da görülen cevap | İnceleme hükmü |
|---|---|---|
| C1 — gerçek düşünme sözleşmesi | Amaç/yöntem, karar-kritik varsayım, kaynak, alternatif, yetki, iş seçimi, doğrulama, devir için davranış hükümleri var | İlk sınırlı deney için yeterince somut; uygulanacağı henüz ölçülmedi |
| C2 — ilk B0/yetki | G0 → C0 → deney → C1 → R(C1) → ayrı insan kabulü → kayıt A | Daireselliği azaltan uygulanabilir aday; gerçek G0 ve kabul henüz yok |
| C3 — reviewer başlangıcı | Aday dışında yeni CLI, sürümlü adayı veri olarak okuma; global talimat ve connector sınırlarının ayrıca kontrolü | Tasarım cevabı yeterli; gerçek yerel başlatma/izolasyon G0 içindeki yürütme önkoşulu |
| C4 — tek yazıcı/devir | Kopya/iş/yol kapsamı, kayıt sorumlusu, beklenmedik değişiklikte sınırlı durma var | Normal devir açıklanmış; bırakma kaydı üretilemeyen kesintide dar bir açıklık kalıyor |

Codex, Issues'ın zorunlu olarak ikinci authority yaratacağı genellemesini düzeltiyor ve yeni bağlam denetleyicisinden vazgeçiyor. Bu değişiklikler tek başına bağımsız düşünme kanıtı değildir; gerekçeleri mevcut ihtiyaçla uyumludur. Aynı şekilde ayrı protokol klasörü olmaması düşünme disiplini yokluğu değildir. AGENTS adayının 6578 byte olması tek başına yükleme/etkinlik garantisi de değildir.

## 4. Tek gerekli metin düzeltmesi: bırakma kaydı olmadan kesinti

Kaynak AGENTS adayında şu cümle var:

> Kapsam, yazıcı durup devri veya bırakmayı kaydedene kadar başka yazıcıya verilmez.

Normal devirde anlaşılır. Ancak yazıcı devir kaydını yazamadan kapanırsa, cümle harfi harfine uygulanınca işi devralacak yetkili yol yoktur. Kaynaktaki T3 de yeni yazıcıyı kayıtlı devirden sonra başlatır; bu nedenle bu özel kesinti durumunu dışlamaz.

Bu bir gözlenmiş runtime arızası değil, aday metnin liveness/continuity karşı örneğidir. Tek-yazıcı güvenliğini terk etmek gerekmez. G0'a dahil edilmek üzere önerilen dar replacement:

> Normal devirde kapsam, yazıcı durup devri veya bırakmayı kaydedene kadar başka yazıcıya verilmez. Yazıcı bu kaydı bırakamadan kesilirse, önceki yazıcının artık çalışmadığı gözlemle doğrulandıktan, gerçek çalışma durumu incelendikten ve mevcut yetki kaynağının izin verdiği yeniden atama kaydedildikten sonra devralınabilir. Sessizlik veya geçen süre tek başına durma kanıtı değildir. Bunlar doğrulanamıyorsa çakışabilecek yazmayı durdur.

Yeni kilit servisi gerekmiyor. T3'e tek bir ayırt edici varyant eklemek yeterli: devir kaydı yok, önceki kontrollü test süreci durmuş, gerçek ara çıktı mevcut. Devralan keyfi hak edinmemeli; G0'ın sınırlı yeniden-atama kuralını kullanmalı. Canlı süreç yerine fixture kullanılırsa simülasyon olduğu açıkça kalmalı.

## 5. Deneye geçerken tamamlanacak sınırlar — yeni mimari araştırma değil

### Yetki alanlarını gerçek duruma geçirmek

Taslakların `ÖNERİ`, `G0 BEKLİYOR`, `Aktif yürütme: yok` alanları S1A teslimatı için doğruydu. Gerçek G0 verilirse bunlar yalnız o mesajın kapsamı ve gerçekleşen aşama kadar güncellenmeli. S1A'nın tarihsel read-only yetkisi korunmalı; yeni G0'ın yerine geçmemeli. İşletim kabulü ve B0 yine verilmemiş kalır.

Henüz commit yokken G0 aday metnin kaynak blob'unu/sürümünü benimseyebilir. C0 oluşunca o metinle eşleşmesi kaydedilir. Commit oluşmadan onun hash'ini yazma veya dosyanın kendi commit kimliğini içinde taşımaya zorlama. Aynı şekilde ileride A'daki salt kayıt/durum farkı kontrol edilir; davranış/yetki/ölçüt değişikliği gizlice kayıt değişikliği sayılamaz.

### Deney kopyasının kimliği

STATE'teki beklenen ana dizin, izole deney kopyasının fiziksel diziniyle aynı olmayacaktır. G0'ın önceden belirlenmiş `deney yolu → kaynak repo + C0/sürüm` eşlemesi bunu açıkça yetkilendirmelidir. Yanlış çalışma kopyasını gizlemek için sessizce cd etmek başka, ilan edilmiş deney kopyasında çalışmak başkadır. Kullanıcının asıl dosyaları olumsuz fixture olarak bozulmamalı.

### CLI ve model gerçekliği

S1A'daki `codex exec` örneği başlatma taslağıdır; yerelde çalıştırılmadığı açıkça söylenmiştir. Resmi kaynaklar dış dizinde başlama, global talimatların varlığı ve ephemeral davranışıyla ilgili sınırları destekliyor [O1–O3]. Yalnız `--sandbox read-only` bütün connector/MCP etkilerini kapattığı anlamına gelmez; bunların ayrı kontrolleri vardır [O3–O4]. G0 önkoşul kontrolü bu sınırı gözlemlemelidir.

Masaüstünde seçilen modelin yeni CLI sürecine otomatik taşındığını varsayma. Etkin model/reasoning bilgisi gözlenmeli. Bu tur açılan config belgesindeki effort değerlerinde `ultra` listelenmedi; bu yokluk masaüstü raporunu çürütmez ve `xhigh = ultra` eşitliği kurmaz. Gerçek kurulu sürümün desteği belirleyici. Desteklenmeyen seçeneği sessizce başka model/effort'a çevirme [O4].

### Kanıt ve kaynak erişimi

`--ephemeral` rollout dosyalarının tutulmamasını amaçlar [O2]; deney sonucu kaybolmamalı. Yetkili başlatıcı, başlangıç parametreleri, hedef kimlikleri, gerekli komut/araç sonuçları, exit durumu, final yanıtlar ve diff'leri sınırlandırılmış deney çıktı alanında saklamalı. Gizli chain-of-thought, auth/config dökümleri ve secret'lar kaydedilmez.

Mevcut kayıtlı CLI kimlik doğrulaması kullanılabilirliği ayrıca gözlenir; belge, exec'in kayıtlı CLI auth'unu kullandığını söylüyor [O2]. Yeni anahtar, API faturalaması, paket kurulumu veya genel izin artışı bu deneyin sessiz yan etkisi olmamalı. Alt oturumun web/GitHub okuması masaüstü oturumundan varsayılmaz. Kaynaklar yalnız snapshot ile kullanılabildiyse live-read iddiası kurulmaz.

## 6. Test planının yeterliliği ve sınırı

T1–T4, başlangıç/izin/beklenti/oracle/kanıt yapısını sağlıyor. Bunları koşmadan önce bütün fixture değerleri, hedef sürümleri ve ölçütler sabitlenmeli. Sonuç görülünce kötü koşuyu örneklemden çıkarmak veya kriteri değiştirmek kabul edilmez. Bir teknik başlatma hatası `ÇALIŞTIRILAMADI`; davranışın kriteri ihlali `BAŞARISIZ` olmalı.

T1 kaynak/karar/devir pilotu bu bootstrap için anlamlıdır: gerçek bir araştırma girdisinin neyi yetkilendirip yetkilendirmediğini çözer ve devam kaydı üretir. Bunun başarısı genel yazılım geliştirme veya bütün SOUL kabiliyetlerini doğrulamaz. T4 aday-dışı incelemenin ölçüt bütünlüğünü sınar; her prompt-injection saldırısına dayanıklılık ispatı değildir.

G0/grant ve ortam konumu gibi meşru başlangıç girdileri verilebilir. Ancak yeni oturuma uzun çözüm/reasoning brief'ini tekrar yapıştırıp sonra repository'den tek başına devam ettiğini iddia etme. Yetkiyi bildiren kısa başlangıç ile işi nasıl çözeceğini anlatan yardım ayrılmalı. Mümkün olan instruction-load izleri kaydedilmeli; görünmüyorsa davranıştan çıkarım ile doğrudan yükleme kanıtı ayrılmalı.

Kesinti, yanlış öncül ve bayat kaynak sonuçları bütün kapsamı kanıtlamasa da sonraki yatırım kararını bilgilendirebilir. Bu bir protokol-benefit ablation'ı veya model benchmark'ı değildir.

## 7. Doğrudan karşı-kontroller ve sınırlar

- Review başlangıcında research `main`: `45a807ed3fe934c5aba19a840c953a3dee30669b`. Bu, Codex'in zaman-bağlı source-ref ifadesiyle tutarlı.
- `soul-development-os` branch API: yalnız `main`, HEAD `3776384a7789ccf1959b99bba92c8cf1b3131f81`, `protected: false`. Aynı commit'in önceki tree incelemesi yalnız `.gitkeep` gösteriyordu. Bu yeni yerel dosya oluşmadığını kanıtlamaz.
- Yerel CLI, global instructions, auth, model snapshot ve testler bu asistan tarafından Mac'te çalıştırılmadı.
- Önceki review ve görevleri yazan asistan bu review'ı da yapıyor. Source readback ve karşı örnek incelemesi var; bütünüyle bağımsız epistemik değerlendirme veya runtime re-performance iddiası yok.
- R09 kapsamında önceki context-memory-harness ve multi-agent/Control/Standing ayrımları seçici review bağlamı olarak korundu. Bu tur yeni bir candidate study veya Foundation araştırması açılmadı; önceki araştırmanın tam yeniden yürütüldüğü iddia edilmiyor.

## 8. Kaynaklar

- **S:** [S1A source response](CODEX-RESPONSE.md), yukarıdaki hash ve sınırlarla.
- **B:** [S1A brief](../../briefs/CODEX-STAGE-1A-STARTER-CONTRACT.md), yukarıdaki pinned ref/blob.
- **R:** [Previous S1 review](../2026-09-06-stage-1/REVIEW.md), C1–C4 ve test sınırları.
- **O1:** https://learn.chatgpt.com/docs/agent-configuration/agents-md — 2026-09-06, How Codex discovers guidance. Global/project keşfi ve run başında yükleme.
- **O2:** https://learn.chatgpt.com/docs/non-interactive-mode — 2026-09-06, Basic usage, Permissions, Authenticate in automation. Ephemeral, stdout ve kayıtlı auth.
- **O3:** https://learn.chatgpt.com/docs/agent-approvals-security — 2026-09-06, defaults/protected paths ve approvals. `.git` koruması nedeniyle yerel commit ayrıca platform onayı gerektirebilir; bypass önerilmiyor.
- **O4:** https://learn.chatgpt.com/docs/config-file/config-reference — 2026-09-06, `apps.*`, `mcp_servers.*`, model ve reasoning alanları. Seçeneklerin belgede bulunması yerelde etkin olduklarının kanıtı değildir.

Bu dış kaynaklar yalnız ilgili platform iddialarının seçici kontrolüdür; ek metnin sessizce düzeltilmiş sürümü değildir.

## 9. Sonraki iş

Hazırlanacak tek teklif: `DEVOS-BOOTSTRAP-G0-2026-09-06`, [G0 brief](../../briefs/CODEX-STAGE-2-G0-EXPERIMENT.md).

Kapsam: tek yerel aday branch'i; üç belge; yukarıdaki tek recovery düzeltmesi; gerçek yetki/deney kayıtları; sınırlı ve sıralı T1–T4; aday dışı teknik değerlendirme. Uzak yazma, main'e kabul/merge, ürün çalışması, paket/altyapı satın alma, kalıcı izin değişimi ve geniş işletim kabulü yok.

Kullanıcı G0'ı göndermeden kuruluma başlanmaz. Gönderirse her rutin alt adım için yeniden tasarım/onay turu açılmaz; gerçek platform engeli veya anlamlı kriter ihlali görünür kılınır. Başarısız koşullar korunur. Sınırda aday ve eksik kanıt döndürülür; kendini başarılı göstermek için kontrol gevşetilmez.

Bu review mevcut adayın değiştirilmemiş kaynak kopyasını, test önerisini ve henüz verilmemiş yetkiyi birbirine karıştırmaz. Güncel checkpoint `../../../STATE.md` içindedir.
