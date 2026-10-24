# A2 — D030 ve ana durum/devir girişleri

**Tarih:** 29 Eylül 2026. **Kapsam:** A2'nin ana girişler alt kümesi; A2'nin tamamı ve depo geneli denetim henüz kapanmadı.

## Yetki ve başlangıç

[REQUEST.md](REQUEST.md) §3.1, §3.2 ve §3.5 ile kullanıcının “devam et” mesajı bu bakım turunun yetkisidir. Yazma yalnız `batuhanozgun/agentic-os-search` içindedir. DevOS kurulmaz; dış plan değiştirilmez veya kopyalanmaz; başka depoya yazılmaz.

Tur başlangıcında main, önceki A1 commit'i `ab8ef329aa4841fae2b836c91e74e68ad1c4c9e5` olarak geri okundu. Araya başka commit girmemişti. Asıl karşılaştırma tabanı `8cd01e4afdcd0d37960b05930c91e1244678be6e` değişmez.

## Yapılan değişiklikler — tam liste

Aşağıdaki 13 dosyanın eski gövdesi yerinde korunur. Değişiklik biçimi yalnız başa tarihli statü/yönlendirme ekidir; DECISIONS ekinde ayrıca istenen D030 yer alır. Dosya taşıma veya silme yoktur.

| Dosya | Başlangıç blob'u | Gerekçe |
|---|---|---|
| `explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md` | `d66e375f33dc4258331f8334322319236c2ae2ae` | D030; D027/D029 ortam kararının geçersizliği ve yeni salt-okuma/devir sınırı; eski kararlar aynen kalır |
| `explorations/EXP-006-development-os-calisma-duzeni/STATE.md` | `7825de8725235777a3a74edadeef78c7faa73084` | Eski Codex/P5 current durumunu tarihsel ayırmak; erişilemeyen paketi doğrulanmış yeni erişim gibi sunmamak |
| `explorations/EXP-006-development-os-calisma-duzeni/HANDOFF.md` | `226fa127e83ae517d7f5a96c069c86320a56fb92` | Yeni oturumun S00 kurulumunu yeniden devralmasını önlemek; Research bakımına ve dış plana ayrı yönlendirme |
| `explorations/EXP-006-development-os-calisma-duzeni/INDEX.md` | `e2dd56b5fad7792b7bf11e6a86bca1f70c87d248` | Eski mandatory okuma/kurulum yolunu yalnız tarihsel inceleme olarak ayırmak |
| `explorations/EXP-006-development-os-calisma-duzeni/WORK.md` | `a5c6ae311671eff69a5a97888126c485cf964b70` | V1.9/S00–S12 haritasını güncel iş olmaktan ayırmak; türetim ve kanıt içeriğini korumak |
| `explorations/EXP-006-development-os-calisma-duzeni/work/p5/CODEX_START.md` | `1d1d82d55c274b392cada86122a0b84049f957ab` | Doğrudan açılabilen eski başlangıç talimatına açık çalıştırılmama notu; §3'te tek tek sayılmamış ek düzeltme |
| `development-os/INDEX.md` | `e39c764dd6f912ad06662ffee639880a8e1a1129` | DEVOS-002'nin güncel kurulum gibi devralınmasını önlemek |
| `development-os/attempts/001/WORK.md` | `8773527388e5b19b9b41a277dd8010a360ab26b3` | Eski 001→002 geçişini tarihsel ayırmak; bağlı mesajların yeni yetki olmadığını belirtmek |
| `development-os/attempts/002/README.md` | `65f07f842a5fa879944625c130d7e617834a5d3b` | Eski varsayım denetimini yeniden başlatmamak; özgün kullanıcı sözlerini ve ortam gözlemlerini korumak |
| `research/soul-context/README.md` | `0d177a158b6d0baee1b1857646eb8e9f2eb649b7` | Araştırma bağlamı ile canlı deneme yönetimini ayırmak |
| `research/soul-context/INDEX.md` | `d874d644a700b3a9b84a97ce4144e16c687b28a6` | DEVOS-001'e eski güncel yönü tarihsel ayırmak; araştırma geri çağırma yollarını korumak |
| `research/soul-context/STATE.md` | `309efdcd0090bd55c9378388170ead4a286e4008` | Eski `soul-development-os3_claudecode` hedefini güncel yön olmaktan çıkarmak |
| `research/soul-context/repos/soul/README.md` | `ba9bae70d9ece54f6b5fcc0094348ebaddc64ac7` | `soul` okuma defterini tarihsel deneme olarak açıklaştırmak; yeni ürün `soul-system` bağlantısını göstermek |

Bakım belgeleri: `REPOSITORY-TRANSITION.md` ilerleme/tek devam noktası için güncellenir; bu `A2-CORE.md` dosyası değişiklik ve denetim kaydı olarak eklenir. `MOVES.md` değişmez: hâlâ taşıma yoktur. Kök README'nin A1 uyarısı, tüm deponun henüz düzeltilmediğini doğru biçimde söylemeye devam eder.

## Yapılan kontrol ve sınırı

13 dosyalık içerik adayı: `0145e4074b4444b413b87d390a523de9981cd0d2`, tree `b8630ff8c75e5e35ce9f178df869c14385467aab`. Bu bir yayın öncesi doğrulama commit'idir; main'e ayrıca bağlandığı iddia edilmez.

GitHub compare ve commit patch okuması: başlangıca göre **13 dosya, 160 ek satır, 0 çıkarılan satır**. Her dosyanın farkı başındaki yeni bloktur; eski gövde içinde değişiklik yoktur. İlk yayımlanmamış taslakta görülen bir istemdışı sözcük değişimi ve iki dosya-sonu satırsonu farkı yayın öncesinde giderildi; başarısız taslak tamamlanmış iş sayılmadı. Bu kontrol bağımsız içerik/Claude davranış testi değildir.

Yeni D030 bağlantıları açık HTML kimliğine bağlanır. Yeni göreli bağlantıların hedefleri mevcut STATE/HANDOFF/DECISIONS, görev kaydı ve bakım planıdır. Eski gövdedeki bağlantılar değiştirilmedi; bunların depo genelindeki tam denetimi A4/A5'in işidir.

Yapılan 13 kaynak dosyası tam içerikleriyle okundu; kesilmiş araç çıktıları gerekli aralıklarla tamamlandı. `work/P5-01-codex-build-installation-package.md` de tam okundu, fakat bu alt kümede değiştirilmedi; A2'nin kalanına bırakıldı. Bu tur eski rapor ZIP'leri doğrulanmadı, A3 arşivi oluşturulmadı ve bütün repository dosyaları taranmış sayılmaz.

`AGENT.md`, `agent/**`, Foundation, studies, concepts, yayınlar, kaynak kullanıcı mesajları ve diğer araştırma gövdeleri bu alt kümenin değişiklik listesinde yoktur. `soul` kaynak defterinin araştırma gövdesi de yalnız başındaki statü eki dışında aynı kalır. Geçmişteki bulgunun epistemik statüsü, sadece kaydın tarihsel olması nedeniyle değiştirilmez.

## Yeni okuyucu için sınırlı yürüyüş

- EXP-006 INDEX/STATE/HANDOFF/WORK açılışları → D030 → dışarıdaki tek kurulum planı. Eski S00 haritası yeni talimat değil.
- Doğrudan CODEX_START açılışı → çalıştırılmama notu → aynı D030 ve dış plan.
- Development OS INDEX, 001 WORK ve 002 README → tarihsel deneme; bakımın devamı kurulum devamından ayrı.
- SOUL Context girişleri ve `repos/soul` → tarihsel kaynak ile yeni `soul-system` ürünü ayrı.

Bu, metin/yönlendirme incelemesidir; gerçek Claude kurucusuyla davranış deneyi yapılmadı. Alt dosyaya doğrudan girişte kalan riskler kapatılmadan tüm A2 başarılı ilan edilmez.

## Tek devam noktası

**A2'nin kalan doğrudan girişlerini kapat:** P4/P5 teslim/devir kayıtları; DEVOS-001 BRIEF/METHOD/EXCHANGE/REVIEW ve gerekirse doğrudan mesaj girişleri; `research/soul-context/current/` eski devirleri; `research/INDEX.md`, `explorations/INDEX.md` ve ilgili katalog yönlendirmeleri. Önce yeni main delta/yazar kontrolü, sonra dosya bazında tam okuma ve yalnız gerekli statü/yön düzeltmesi. A2 kapanmadan A3'ü tamamlanmış gösterme.

Son yayın commit'i ve main eşliği, bu belge oluşturulduktan sonraki GitHub geri okumasıyla teyit edilir; yalnız tree veya commit nesnesi yaratılması main yayını sayılmaz.
