# Development OS — tarihsel denemelerin dizini

**29 Eylül 2026:** DEVOS-001 ve DEVOS-002 bu depodaki tarihsel denemelerdir; güncel kurulum işi değildir. DevOS'un kurulacağı ve çalışacağı ortam **Claude Code cloud**, geçerli planın tek evi [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devirdeki sürümü **2.1**'dir. Yetki kaydı: [EXP-006 D030](../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri).

Bu alan denemelerin konuşma, okuma, yöntem, kanıt ve derslerini korur; çalışan DevOS'un canlı durumunu tutmaz. Claude Code ve DevOS ekibi yalnız okur. Aşağıdaki eski “yeni oturumun girişi”, mesaj görevleri, hedef depo ve next ifadeleri yeniden yürütme yetkisi değildir. Güncel Research bakım işi [REPOSITORY-TRANSITION](../REPOSITORY-TRANSITION.md)'dadır.

Tarihsel kaynaklara giriş: [001 WORK](attempts/001/WORK.md), [002 README](attempts/002/README.md). Bir denemenin tarihsel olması onun deney sonuçlarını yeni test, önerilerini kabul veya açıklarını çözülmüş hale getirmez.

---

## 24 Eylül 2026 kaydı — aşağıdaki metin güncel kurulum talimatı değildir

# Development OS — çalışma sistemi kurma denemeleri

Bu alan Development OS'u kuracak çalışma düzenine ilişkin denemeleri birbirinden ayrı tutar. Araştırma arşivi, agent-control veya kabul edilmiş SOUL mimarisi değildir.

**Güncel çalışma: DEVOS-002. Varsayım denetimi ve ortam uygunluğu değerlendirmesi sürüyor; kurulum yönlendirmesi duruyor. Çalışan Development OS veya kabul edilmiş SOUL mimarisi yok.**

| Deneme | Durum | Güncel giriş |
|---|---|---|
| DEVOS-002 | Son kullanıcı kısıtı: SSH yok; mevcut Mac + Claude Cloud, gerekli olmayan yürütme yükü Mac'e verilmemeli. ECC'nin gerçek yerleşimi ve yeterliği doğrulanmış değil. Önceki çelişen ortam hükümleri güncel kayıtta ayrıştırıldı. | [002 güncel konuşma ve varsayım denetimi](attempts/002/README.md) |
| DEVOS-001 | Research tarafındaki devam duraklatıldı. Eski okumalar, mesajlar ve bulgular korunuyor. Claude'un canlı çalışması bu kayıtla durdurulmuş sayılmaz. | [001 WORK](attempts/001/WORK.md) |

## Yeni oturumun girişi

AGENT/tetiklenen kontrol → bu INDEX → 002 README'nin tamamı → kullanıcının yeni mesajı üzerinden devam.

002 README güncel amaç, yetki, gözlenen ortam, kaynak kontrolleri, açık varsayımlar ve sonraki sorumluluğu taşır. Önceki birikimli kayıt immutable bağlantıyla korunur; tarihsel `Resolved` veya next-step ifadeleri güncel talimat değildir. Kullanıcıya yeniden kurulum tıklamaları yaptırmak varsayılan devam değil.

002 için 001'in BRIEF/METHOD/COVERAGE zinciri zorunlu başlangıç değildir. Eski D1/D2 tasarımı, toplu okuma kuyruğu veya R-006 yazışması otomatik sürdürülmez.

## Ayrılık ve kaynaklar

001'in planı, izinleri, bekleyen mesajları, hedef repo adresi ve seçilmemiş mekanizma adayları 002'ye miras değildir. Gerekli olursa geçmiş malzeme kaynak olarak ele alınabilir; aktarım veya benimseme kararı verilmedi. 003 açılmadı.

Foundation, studies, concepts, explorations ve publications korunur. Kontrol alanı değişmez. Kullanıcı Claude için yeni repo açacağını bildirdi; adı/adresi verilmedi. 002 sırasında research reposunda kullanıcı aracılı cloud preflight yapıldı; bu, research deposunu implementasyon deposuna veya tamamlanmış Development OS'ye dönüştürmez. 001'deki dış Claude oturumuna müdahale edilmedi.
