> **29 Eylül 2026 — tarihsel kaynak, okuma ve erişim kaydı.** Aşağıdaki tam/kısmi okuma, ZIP aktarımı, W01 ve platform gözlemleri 23 Eylül'deki hazırlığa aittir. Bunlar bugünkü okuma, dosya erişimi, kurucu yeterliği veya yeni görev kanıtı değildir; özgün kimlikler ve kanıt sınırları aynen korunur.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır. DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Eski kaynak kaydı kurulum veya eski W01'i yeniden başlatma talimatı değildir.

---

# Kaynak, okuma, erişim ve kanıt kaydı

**Bağ:** CC-DEVOS-PREP-20260923. **Kayıt:** 23 Eylül 2026. Bu dosya retrieval/kanıt kaydıdır; kaynakları veya hedef repository'nin actual state'ini ikame etmez.

## 1. Araştırma başlangıç ref'i ve katmanlar

Research başlangıç ref'i: `cee38caa970399fa4bf267cb484331e0c50164c9`.

`AGENT.md` / `agent/**`: Research assistant'ının kontrol katmanı. Bu conversation'da dokuz protokol tam yüklenmiştir; bu tur AGENT yeniden okundu, blob `aea3dd845e0f0bbcfb34465edb23782e99f95c80`. RPD özgün metni Research kontrol dosyası yapılmadı. Claude'a aktarılan bu görev de bütün Research kontrollerinin körlemesine kopyalanması talimatı değildir.

`research/soul-context/`: tarihsel bağlam ve bu sınırlı hazırlık/devrin kaydı. `research/soul-foundations/`: first-principles zemin. `research/studies/`: seçici aday mekanizma/kanıt kütüphanesi. `explorations/`: kaynak diyalog, taslak ve dersler. `concepts/`: ayrı terim çıkarımı programı; tasarım yetkisi veya bitmiş evrensel sözlük değildir.

## 2. RPD — bu conversation'da tamamlanan tam okuma

Research paketindeki üç dosyanın tamamı okundu; büyük ASSESSMENT görünümünün kesilen sonu ayrı aralıkla tamamlandı:

| Kaynak | Git blob | Statü |
|---|---|---|
| `research/studies/recursive-prerequisite-discovery/META.md` | `68fd539f3b24c70ad987241d183c4f301488b9ac` | Paket kimliği, kullanımı ve kaynak sınırı |
| aynı dizin / `ASSESSMENT.md` | `ffd95e71c6f49192d3cdf6ffc2a4d13b1b7a10d0` | Kavramsal yöntem / tasarım önerisi / prototip / tarihsel grant ayrımı |
| aynı dizin / `MECHANICAL-OBSERVATIONS.md` | `cd774e84478c93a40909d5db44bd76b4f6c013a6` | Tarihsel sentetik mekanik test ve iki sınır probe'u; gerçek RPD-agent etkinliği değil |

Özgün kaynaklar Library'den geri kazanıldı ve önceki turda baştan sona okundu. Bu tur runtime dosya byte'ları yeniden hash kontrolünden geçti:

| Özgün dosya | Byte | SHA-256 | Okuma |
|---|---:|---|---|
| `ozyinelemeli_onkosul_kesfi_kavramsal_temel.md` | 78259 | `9af3e87eea0e589ea2f5f14e863de6cafdabf68ed585efd0214603492c096e09` | 26 bölüm + kaynaklar; 550/550 dosya satırı |
| `RPD_Sureklilik_Tasarimi_v0_1.md` | 46733 | `7fc37d3fb3ca7777517691112439bad9718346e5c063c4cee34f31066d1a8121` | 22 bölüm + kaynaklar; 392/392 dosya satırı |

Bu iki orijinal byte bu Research yayınında repository'ye yüklenmiş değildir. Kullanıcıya sunulan **CC-DEVOS-PREP-20260923-transfer.zip** içindeki `sources/rpd/` altında değiştirilmeden taşınırlar. ZIP yalnız bu yeni devir paketidir; 8 Eylül tarihli `RPD_Sureklilik_Paketi_v0_1.zip` veya onun 24 dosyalık prototipi değildir. ZIP'in varlığı Claude'un onu aldığını, okuduğunu ya da yeni bir oturumda geri bulacağını göstermez. W01 kendi aldığı byte'ları doğrular ve kaynakların hedefte nerede korunduğunu bildirir.

Kayıp `SKILL.md v0.1.1-draft` geri üretilemez; bu görev onu gerektirmez. İki özgün metnin kaynakça listelerini okumak, oradaki bütün dış belgelerin tam okunması değildir. Kod/test prototipi bu tur yeniden çalıştırılmadı. Özgün tasarımın HEAD/lease/writer topolojisi benimsenmedi.

## 3. Önceki kaynakların bu conversation'daki gerçek okuma kapsamı

- `research/INDEX.md`, `research/soul-context/INDEX.md` ve STATE: tam okuma; yeni hedef eski `_02` operasyonuna tabi değil. Bu tur INDEX/STATE/README yeniden doğrudan okundu. Önceki state blob `7868131b3e94dd88a48a5a73c6ef9bc31b882fee`, index blob `4568f0a28dfd3e80c5f69e82d5f15f89a2864f92`; tarihsel exact sürümleri Git'te korunur.
- `research/soul-foundations/STATE.md` ve `08_foundation-sufficiency-reuse-review/` içindeki DISCUSSION-HANDOFF, INDEX ve REUSE tam okundu. Bütün Foundation corpus'u bu conversation'da yeniden tam okunmuş değildir. Katkı: yapısal araştırma kapsamı mühendislik yeterliği değildir; kaynak birimi zorunlu servis değildir.
- `research/studies/CATALOG.md` tam okundu; RPD, Anthropic SDLC, context-memory-harness, Superpowers META'ları tam görüldü. Aynı toplu sonuçtaki gstack/work-management META görünümlerinde truncation vardı; bunlar için bu conversation'da tam okuma iddiası yapılmaz. İlgili gerçek tasarım kararı öncesinde gerektiği derinlikte recovery yapılır. Katkı: hazır ürün seçmek değil; bilgi/iş/rol/ortam ve denetim seçeneklerini buldurmak.
- `explorations/INDEX.md`, CATALOG ve EXP-001/002 INDEX–STATE–TOPIC-MAP yolları okundu. EXP-001 kullanıcı kaynağında özellikle U008–U015, EXP-002'de U010–U019 doğrudan görüldü. EXP-001 U011'in kapsam/standart ve EXP-002'nin ortak entelektüel taban ayrımı bu çalışmayı değiştirdi.
- EXP-004 STATE ve T11 gerekli tamamlayıcı aralıklarla okundu. Bütün MS01/T1–T15/SY01/DQ01–DQ04 korpusu bu conversation'da tam okunmuş değildir; bütün taslağı benimseme yapılmaz. Katkı: kademeli iş ile eksik güvenceli kapanış ayrımı.
- EXP-005 INDEX/STATE, LESSONS-AND-OPEN-QUESTIONS ve ilgili kaynak diyalog kesimleri okundu. 95 mesajın tümü bu conversation'da baştan sona okunmuş sayılmaz. Özellikle `sources/conversation/05-DARLIK-TESTLER-VE-ERISIM-ITIRAZI.md` U011–U016 ve derslerin D01–D08 ayrımları kullanıldı. Katkı: yeni motor teşhisi peşinen değil; kaynak erişimi/kullanımı, hazırlık, deney ve devir aynı üst hedefe bağlanmalı.

Kaynak seçimi bütün bilgi dünyasının sınırı değildir. İlerideki sentez, bu haritanın vermediği anlamı varmış gibi kullanamaz. Gereken tam okuma bitmezse kaldığı yer, henüz okunmayanlar ve hangi hükmün beklediği kaydedilir.

## 4. Güncel resmî platform kontrolü — belgelenmiş olan, actual cloud kanıtı değil

23 Eylül 2026'da Research şu resmî belgeleri açtı; ilgili bölümler kontrol edildi, tam dokümantasyon veya gerçek kullanıcı oturumu denetimi yapılmadı:

- https://code.claude.com/docs/en/claude-code-on-the-web — cloud çalışma yüzeyi ve yürütme bağlamı için birincil giriş.
- https://code.claude.com/docs/en/cloud-environments — ağ, environment variables ve setup gibi ortam koşullarının yapılandırma yüzeyi; kullanıcıdaki gerçek ayarlar buradan çıkarılmaz.
- https://code.claude.com/docs/en/memory — talimat bağlamı ile enforcement ayrımı; AGENTS doğrudan yüklemesinin sürüm/ortam/talimat dosyası koşulları.

Memory belgesinin açılan AGENTS bölümünde doğrudan destek v2.1.277+ olarak tarif edilir; varsayılan seçimde üst/current dizindeki CLAUDE.md veya CLAUDE.local.md varlığı etkili olabilir, bazı oturumlarda destek yoktur. Önceki sohbetin genel "AGENTS doğrudan okunur" ifadesi bu nedenle kullanıcının cloud ortamına koşulsuz taşınamaz. `AGENT.md` tekil adı otomatik giriş kabul edilmez. Bunlar W01'de doğru yükleme yolunu gözlemek için soru doğurur; burada ayar kurulumu önerilmez.

## 5. Gerçek tüketicide açık kalan kanıtlar

Claude'un yeni görevi alması; cloud working tree/commit/uzak ref ilişkisi; Research ve ek kaynakların exact okunması; erişimden gerçek yorum/karar değişimine geçiş; kayıtların yeni oturumda geri kazanılması; actual instruction/hook/skill/subagent koşulları; özel veri/credential/harcama sınırları.

Research'ün GitHub erişimi Claude erişiminin kanıtı değildir. Kullanıcıya verilen ZIP kalıcı Git erişiminin yerine geçmez. Hedefin runtime kanıtı gelmeden tabloların dolmasıyla hazır hükmü üretilmez.
