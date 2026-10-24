> **29 Eylül 2026 — DEVOS-001'in tarihsel amaç ve yetki kaydı.** Aşağıdaki “güncel yön”, hedef depo ve “yetkili iş” ifadeleri 24 Eylül'deki denemeye aittir; bugünkü kurucuya görev vermez. Kullanıcının özgün mesajı ve o dönemdeki yorum/sınırlar değiştirilmeden korunur.
>
> Güncel geçiş [D030](../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek plan [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Research'ün bu devirdeki devamı [depo bakım planıdır](../../../REPOSITORY-TRANSITION.md), eski D1/D2 tasarımı veya Claude yazışması değildir.

---

# DEVOS-001 — amaç, kullanıcı yönü ve sınırlar

**Güncel yön:** 24 Eylül 2026; Foundation'ı ihtiyaç odaklı kullanarak bütünsel çalışma düzeni tasarımına geçiş.
**Hedef:** Claude Code / `batuhanozgun/soul-development-os3_claudecode`.
[Yönetim](WORK.md) · [Yöntem](METHOD.md) · [Kapsam](reading/COVERAGE.md) · [İletişim](EXCHANGE.md).

## Korunan amaç

Development OS'u kurabilecek bilgi, iş, aktör ve ortam düzenini hazırlamak. Batu'ya araştırmayı yeniden okuma, teknik eksik bulma veya sürekli koordinatörlük yükü bırakmamak. Tasarım nesnesi Development OS'un kendisinden önce onu araştıracak, tasarlayacak, kuracak ve geliştirecek çalışma düzenidir. Dosya onarımı, E19 ve mesajlaşma bu amaç değildir.

## En son kullanıcı yönü — aynen

> Sen foundation’ı tam okuma yapmadan zaten ilerleyemez misn? Sen yazdım zaten onları, nasıl ir çalışma yapısı kurulması lazım alamasına geç, bunu yaparken foundation’ı gerektiğinde drill down yap. Olmaz mı?

Bu turdaki yöntem kararı: Research bütünsel tasarımı başlatır; Foundation'ın baştan sona yeniden okuması önkoşul olmaktan çıkar. Karar için gerekli derin kaynak okuması devam eder. Önceki yazarlık, bugünkü bağlamın eksiksizliği veya kaynak doğruluğu için kanıt sayılmaz.

Önceki tam kullanıcı yönü ve denemenin açılış kaynakları [3c809d BRIEF](https://github.com/batuhanozgun/agentic-os-search/blob/3c809d9691643b6183bc035cd344f12efb3f4c87/development-os/attempts/001/BRIEF.md)'te aynen korunur. 23 Eylül'deki kapsamlı okuma talebi yok sayılmadı; 24 Eylül'de Foundation yeniden-okumasını tasarıma giriş koşulu yapan sırası değiştirildi.

## Değişen ve değişmeyen

Değişen: önce bütün Foundation okuma/çıkarımı bitsin, sonra tasarım başlasın kapısı. Tasarım ile kaynak incelemesi artık birlikte ilerler.

Korunan: bütünsel bakış; dört zemin ve aralarındaki ilişkiler; maddi fikir ve örneklerin kaynak-bağlı kayıtları; studies/concepts/explorations birikiminin değerlendirilmesi; öneri, karar ve uygulamanın ayrılığı. Her kayıt karşılaştırmalı değerlendirmeye geri çağrılabilir kalır; yazılmış dosya, Research tarafından okunmuş dosya sayılmaz.

## Roller ve yetki

Research bütün tasarımın tutarlılığını, kendi kaynak kullanımını, alternatifleri ve denemenin devamını yönetir. Claude kendi kayıtları, örnek sistemler ve gerçek ortamından tasarıma katkı ve karşı görüş getirir; teknik yöntemi Batu'ya seçtirmez. Son paylaşım WORK'tedir.

Yetkili iş: bütünsel tasarım, hedefli kaynak okuması, gerekli karşı inceleme ve kalıcı kayıt. Nihai yapı bu mesajla seçilmiş değildir. Kurulum, geniş deney, yeni depo, izin genişletme ve otomasyon başlatılmaz. Agent-control ve özgün araştırma sonuçları değiştirilmez.
