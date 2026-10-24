# 20 — Session lease, history ve yeniden çalışabilme

**2026-09-11 / U05 / SOURCE-ONLY PROVISIONAL.** [STATE](../STATE.md), [kaynaklar](../evidence/2026-09-11-session-lease-recovery/SOURCES.md), [tam inceleme](../evidence/2026-09-11-session-lease-recovery/RESEARCH.md), [NOT RUN kontroller](../evidence/2026-09-11-session-lease-recovery/CHECKS-NOT-RUN.md). Primary `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Yeni HERMES koşusu yok; U04-A/B ve üç merkezi sentez korunur.

## U04'ten ne devralındı, ne değişti?

A ve B zaten main'de ayrı yayınlardı. B'nin 33 özgün dosyası yeniden gönderilecek iş değildir. V0.17 yalnız yayın uzlaştırmasıydı; bu tur kullanıcının açık devam isteğiyle Q40 ve gerekli Q41/Q42 source consumer'ları araştırıldı. Önceki turn_facade_lease erişim engeli açıldı; araştırmanın sonunda hermes_state_messages'ın devamı 429 aldı. Tüm eski doğrulama sınırları korunur.

## Ana mekanizma

Bir devam prompt'unun varlığı, bir sonraki turun çalışabileceği anlamına gelmez. İncelenen native zincirde en az dört ayrı koşul var: **conversation üzerinde çalışma hakkı; uygun transcript görünümü; devam-state'inin doğru session key'inde bulunması; onu yeniden çalıştıran driver/route'un canlı olması.** Bu yeni bir Foundation taxonomy veya tamamlanmış sistem modeli değil, kaynakta farklı işlemlerle yürütülen yükümlülüklerin açıklamasıdır.

**Çalışma hakkı:** durable session lease compression lineage kökünde alınır. Parent/child ID değişse bile ortak kök, claim/refresh/release transaction'larında çözülür; holder niteleyicisi eski sahibin yeni lease'yi temizlemesini sınırlar. Timeout/abort asıl turn'a girmeden 'mesaj işlenmedi' sonucu döndürür. Lease yenilemesi ilerleme değildir; watchdog başka sorunu gözetir. Gerçek process/OS/araç etkisi fencing'i test edilmedi. [U05-S01–S04]

**History:** admission yalnız gerçekten bekledikten sonra resume ID/history reload yapar; immediate edinmede caller girdisi korunur. Rotation recovery ayrıca prolog öncesinde tip/history yükleyip yeniden doğrular. Quiet Kanban caller ise dönen messages listesini history olarak devralmaz; ID sync yalnız ID'dir. No-wait/no-rotation koşulunda prolog'un ayrı listesinde önceki turun yeni mesajlarının taşınmaması source-level olarak açıklanır. Bu **DB silinmesi veya bütün üründe kanıtlanmış history-loss bug'ı değildir**; actual next-request/SessionDB testi açık. [U05-S01,S02,S05–S07]

**State aktarımı:** transcript child publication gerçek DB'de tek transaction kullanır. Goal/heartbeat/loop taşıma onun ardından ayrı best-effort çağrılardır. Loop helper'ı child save → parent clear yapar; save hataları gizlenebilir. Gerçek set_meta cursor desteklese de bu çağrı cursor geçirmez, yazılar ayrı transaction'lardır. Helper True, child durable receipt değildir. Bu gerçek-writer source bağı B:H09'u production fault testi yapmaz. [U05-S03,S04,S07,S08]

**Driver:** gateway loop DB'deki aktif loop'ları route bilgisiyle tarar; heartbeat watch ise bellek içidir. Loop awaiting_response bayrağı restore edilir, scan onu atlar; due zamanının geçmesi bayrağı temizlemez. Complete/abandon/resume gibi açık geçişler vardır. Actual startup watcher, adapter kabulü ve heartbeat rotation rebind bu tur kapanmadı. [U05-S08,S09]

## Önceki sentezlere etkisi

Synthesis/03'te korunmuş 'admission caller history'sini telafi edebilir' karşı açıklaması artık **waited reload veya ayrı rotation recovery koşullarıyla** okunmalıdır; evrensel bir history-tazeleme güvencesi değildir. Synthesis/02'nin session ownership→context→persist ayrımı daha somut consumer'lara bağlandı. Dosyaların geçmiş metinleri değiştirilmedi; bu not güncel source amendment'tır. Yeni dördüncü completed sentez, nihai CORE, dört-alan projection veya adoption kararı yoktur.

Q40 source açıklaması derinleşti, actual selector/history receipt açık. Q41 transcript/state transaction ayrımı açıldı, gerçek migration fault/profiles açık. Q42 driver türleri ve in-flight gate açıldı, actual restart/adapter recovery açık. Q43 session lease ile task-run sahipliğini karıştırmadan lower fence'e devam etmeli. Q38 selected-parent fidelity, Q26/Q29 full-worker/original ve Q07/Q22 wire/variants değişmedi.

## Sonraki sınır

İlk sonraki: actual `hermes_state_messages` selector/guard ve quiet next-history consumer; ardından gateway startup/adapter ile saved in-flight loop ve heartbeat watch reactivation. [Kontrol tasarımı](../evidence/2026-09-11-session-lease-recovery/CHECKS-NOT-RUN.md) henüz uygulanmadı. Aynı G/H fixture'larını çoğaltmak bu sınırı kapatmaz. Bu bounded consumer kesitinden sonra F01–F12 geniş haritası yeniden önceliklendirilir; bütün araştırma yalnız lease veya güvenlik borcuna daraltılmaz.
