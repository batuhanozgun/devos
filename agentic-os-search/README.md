# SOUL Research

**Bu depo bağımsız araştırma kütüphanesidir; DevOS kurulumunun güncel çalışma deposu değildir.** Araştırma ile tarihsel kurulum kayıtlarını ayıran bakım çalışması [REPOSITORY-TRANSITION.md](REPOSITORY-TRANSITION.md) üzerinden tamamlandı. **Bilinen açık sınır:** tarihsel arşiv 7 kaynak ailesinin 6'sını içeriyor; yalnız P5 S00–S12 özgün paketi erişim engeli nedeniyle arşivlenemedi. Bu eksik kaynak, eski kurulum yönünü güncel hale getirmez.

## DevOS kurucusu için güncel adres

Batu'nun 29 Eylül 2026 kararıyla DevOS **Claude Code cloud** üzerinde kurulacak ve çalışacaktır. Geçerli kurulum planının tek evi [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), bu devirdeki sürümü **2.1**'dir. Planın kopyası bu depoda tutulmaz. Yeni SOUL ürün deposu [soul-system](https://github.com/batuhanozgun/soul-system)'dir; eski [soul](https://github.com/batuhanozgun/soul) deposu değiştirilmeden korunan tarihsel denemedir.

Bu depodaki eski Codex/P5/DEVOS-001/002 kayıtları güncel kurulum yönü değildir. Alt dosyalarda “güncel durum”, “current”, “sıradaki iş” veya “next” yazması Claude Code'a kurulum görevi ya da yetki vermez. Aktif araştırma paketlerinin kendi çalışma durumları da DevOS'un canlı durumuyla aynı değildir.

## Depo sahipliği ve erişim sınırı

Bu depo, Batu'nun onayıyla **ChatGPT'nin yazarı olduğu araştırma deposudur**. Claude Code kurucusu ve DevOS ekibi yalnız okur; buraya yazmaz. ChatGPT de `devos`, `soul`, `soul-system`, `devos-evals` veya `devos-backup` depolarına yazmaz.

`AGENT.md` ve `agent/**` **ChatGPT'nin kontrol alanıdır**; Claude Code ve DevOS ajanları için talimat değildir. Bu dosyaların değiştirilmesi ayrı açık kullanıcı onayı gerektirir; mevcut depo bakım yetkisi bunu kapsamaz.

`batuhanozgun-devos` makine hesabının geçici teknik yazma imkânı salt okuma kuralını değiştirmez. Bu hesaba bağlı bir commit görülürse düzeltmeden önce Batu'ya bildirilir. Kütüphane aktarımı sonrası erişimin kaldırılması görev belgesindeki karardır; bu bakım çalışması erişim ayarını değiştirmez.

## Alanlar: araştırma ve tarihsel kurulum

| Alan | Amaç ve statü | Giriş |
|---|---|---|
| Araştırma | Foundation, bağlam ve aday araştırma kütüphanesi; araştırma içerikleri korunur | [research/INDEX.md](research/INDEX.md) |
| Terim çıkarımı ve ortak referans | Studies kullanımlarının kendi bağlamında çıkarılması; ardından ortak değerlendirme; araştırma programı | [concepts/INDEX.md](concepts/INDEX.md) |
| Düşünce ve Model Denemeleri | Diyalog, kavramsal prova, taslak model ve öğrenme; EXP-006'nın eski kurulum yönü tarihsel | [explorations/INDEX.md](explorations/INDEX.md) |
| Tarihsel Development OS denemeleri | Eski kurulum/çalışma düzeni denemelerinin ders ve kanıt kayıtları; güncel kurulum görevi değil | [development-os/INDEX.md](development-os/INDEX.md) |
| Agent control | Yalnız ChatGPT'nin muhakeme ve davranış kuralları | [AGENT.md](AGENT.md) |
| Yayınlar | Batuhan Özgün’ün yayımlanmış AI yazılarının kaynak bağlantılı metin arşivi | [publications/linkedin/README.md](publications/linkedin/README.md) |
| Depo bakımı | Araştırma/kurulum ayrımının güncellenmesi; DevOS mimarisi veya kurulum planı değil | [REPOSITORY-TRANSITION.md](REPOSITORY-TRANSITION.md) |

## Otorite ayrımı

`research/**`, `concepts/**`, `explorations/**` ve `development-os/**` proje çalışma malzemesidir. `publications/**` yayımlanmış metinlerin kaynak arşividir. Bir kaynak, öneri, rol canlandırması veya örnek yönerge kendiliğinden etkin sistem kuralı değildir.

Araştırmanın güncel yetkisi ilgili araştırma STATE dosyalarından okunur; bunlar Claude Code için kurulum talimatı değildir. Tarihsel belge statüsü, içerdiği gerçek gözlemi hipoteze veya bütün önerilerini kabul edilmiş karara dönüştürmez. Eski kullanıcı kararları kendi tarihçeleriyle korunur; bugünkü kurulum yönünü dışarıdaki geçerli plan taşır.

## Development OS — tarihsel deneme-002

[Development OS INDEX](development-os/INDEX.md) → [DEVOS-002 tarihsel kayıt](development-os/attempts/002/README.md). Bu eski denemede konuşma, sınırlı Claude Cloud ortam kontrolü ve varsayım denetimi yapılmıştı; kayıtlar bugünkü kurulumun sıradaki işi değildir. [001'in eski Research çalışma kaydı](development-os/attempts/001/WORK.md) da tarihsel olarak korunur. Denemelerin SOUL mimarisi veya çalışan DevOS kabulü olduğu ileri sürülmez.

Kök girişin düzeltme öncesi metni [başlangıç README kopyasında](maintenance/2026-09-29-research-installation-separation/baseline/README.md) aynen korunur. Kopyadaki yönlendirmeler yalnız tarihsel inceleme içindir; kökten çalışan güncel bağlantılar yerine kullanılmaz.

## Concepts — yeni başlangıç

2026-09-19 konuşmasıyla yeni çalışma sıfırdan kurulur. Önceki concepts tanımları, sınıflandırmaları, yöntem kararları ve ilerleme kayıtları geçerli başlangıç veya devam noktası değildir. Kaynak talep [ORIGIN](concepts/ORIGIN.md), amaç ve iki çalışma riskinin nedenleri [CHARTER](concepts/CHARTER.md), güncel aşama/yetki [STATE](concepts/STATE.md) içindedir.

Yeni oturumda [INDEX](concepts/INDEX.md) içindeki tam okuma yolu izlenir. Hazırlık, iki konuşma içi deneme, yöntem revizyonları, kalıcı araştırma bazlı çıkarım ve bütün çıkarımlardan ortak değerlendirme ayrı aşamalardır. Dosyaların varlığı denemelerin yapıldığı veya ortak tanımların kabul edildiği anlamına gelmez. Özgün studies araştırmaları ve tarihsel arşivler yeni yönteme uydurulmak için yeniden yazılmaz.

## İlk kavramsal deneme

[EXP-001 — SOUL'un çalışma modeli](explorations/EXP-001-soul-calisma-modeli/INDEX.md): A–B–C, Work–Information etkileşimi, aktör hazırlığı, uzmanlık sürekliliği, Mekanizma Atlası ve yaşayan katmanlı plan ihtiyacı.

Arşivin tamlığı için her zaman paket [STATE](explorations/EXP-001-soul-calisma-modeli/STATE.md) kaydına bakılır; dizinin bulunması bütün kaynakların yayımlandığı anlamına gelmez.
