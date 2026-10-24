# 29 — Kurulum, değişim ve etkin çalışan sistem

**2026-09-13 / U14 / SOURCE-ONLY, PROVISIONAL.** Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a` / manifest0.21.0. [STATE](../STATE.md), [PLAN](../RESEARCH-PLAN.md), [A kurulum/activation](../evidence/2026-09-13-install-update/INSTALL-AND-ACTIVATION.md), [B update/recovery](../evidence/2026-09-13-install-update/UPDATE-AND-RECOVERY.md), [A kaynakları](../evidence/2026-09-13-install-update/INSTALL-SOURCES.md), [B kaynakları](../evidence/2026-09-13-install-update/UPDATE-SOURCES.md), [NOT RUN](../evidence/2026-09-13-install-update/CHECKS-NOT-RUN.md), [PUBLICATION](../evidence/2026-09-13-install-update/PUBLICATION.md).

## Native açıklamaya eklenen yaşam döngüsü

Önceki notlar bir çalışanın turunu, kalıcı işini, devamını, zamanlamasını, runtime'ını ve delegation'ını açıyordu. U14 bu çalışanın **hangi kaynak ve kurulumdan ortaya çıktığını, sonra kendisi değiştirilirken nasıl devam ettiğini** ekler. Kaynak checkout'u, kurulu paket/dependency graph, user home/profile, PATH'teki komut, bellekteki module graph ve uzun yaşayan process birbirinin yerine kullanılamaz.

A: source/build biçimi→code/data/command layout→checkout ref ve local-change politikası→venv/lock-first veya fallback çözümleme→interpreter/shim→profile/config→command entry. Staged installer'ın ok+skipped sonucu veya core-only fallback, bütün özelliklerin ve servislerin etkinliği değildir. Package manifest veya source pin argümanı actual resolved install identity'nin yerine geçmez.

B: install-method yetkisi→runtime/env envanteri ve backup→Git source değişimi→dependency/core-lazy recovery→supervisor restart→actual fleet identity→sonuç makbuzu. Image/package yönetimindeki refusal ile mutable checkout update aynı yetki değildir. Source rollback, user-data restore ve process restart tek transaction değildir.

## Koruma ve sınırlar birlikte

HERMES'in kaynakta gerçek olumlu kontrolleri var: no-op HEAD reddi; selected syntax/import kontrolü; değişim sırasında updater'ın kendi receipt/lock/plan kimliğini koruma; core/lazy/fleet için ayrı yarım-iş işaretleri; restart sonrası current/stale/down/unknown ve expected-versus-observed runtime karşılaştırması. Önceden çalışan process'in artık görünmemesi, replacement doğrulanmadan başarı sayılmamalıdır; bu ayrım gerçek consumer'a bağlandı.

Ancak bütün kontrol isimleri aynı güvenceyi taşımaz. UpdateLock normal read→write claim'i atomik değil ve I/O failure'da unlocked devam edebilir; early-recovery kilidinin normal yolu O_EXCL kullanır ama onun da grace kolları vardır. Yedekleme ve bazı health/probe adımları best-effort'tur. Banner, automation exit-code'u, gateway marker ve kalıcı receipt farklı fazları özetleyebilir. Receipt singleton'ının bir kez finalize edilmesi, dosyasının kesin yazıldığı anlamına gelmez.

Bu sınırlardan **actual yarış, veri kaybı, başarısız kurulum veya yanlış çalışan servis gözlemi** üretilmedi. U14'te yeni behavioral execution yoktur; native source control-flow ve koşullu kaynak çıkarımı vardır. Full/selected okumalar kaynak defterlerinde açık, tüm dependencies/local byte/OS/provider doğrulaması değildir.

## Araştırmanın yönüne etkisi

[U13 kapsam değerlendirmesi](../inventory/SCOPE-REVIEW-2026-09-13-U13.md) henüz açıklanmamış F12 install/change yaşamına geçmeyi seçmişti. U14 bu boşluğa normal ve farklı refusal/recovery yollarını ekledi. Şimdi her update fault'unu tüketmek yerine **Q59 skill-library lifecycle**: dağıtılan, kullanıcının değiştirdiği ve ajanın ürettiği becerilerin manifest/ledger/sync/restore/discovery yaşamı. Kurulum/update/startup kaynaklarının gerçekten bu kütüphaneyi değiştiren çağıranları bulundu; alt sync/curator mekanizmaları yapılmış sayılmadı.

Eval/future-task quality ve önceki runtime/fidelity residual'ları açık kalır. Dört provisional synthesis ve notes01–28 değiştirilmez; note29 birlikte okunacak kaynak ekidir, final CORE veya Foundation/SOUL mimari kararı değildir. U13 source/manual diagnostic tekrar yapılmadı; yalnız eksik final publication makbuzu uzlaştırıldı. U14 başlangıç/A/B dilimleri sırayla main'e bağlanıp geri okunarak ilerledi.
