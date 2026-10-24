# Araştırma / kurulum ayrımı — depo bakım çalışması

**Kimlik:** REPO-SEPARATION-20260929  
**Durum:** TAMAMLANDI — A1, A2, A4 ve A5 tamam. A3 arşivi **6/7 aileyle kısmi**; SOUL ve DevOS raporu arşivlendi. Yalnız P5 S00–S12 kalıcı açık kaynak erişim sınırı olarak taşınıyor. Depo yönlendirme/ayrım bakımı tamamlandı; yeni özgün kaynak gelmedikçe bu bakım için sıradaki aktif iş yok.
**Güncelleme:** 1 Ekim 2026. **Yazar:** ChatGPT, Batu'nun açık yetkisiyle.  
**Kaynak:** [Görev belgesinin değiştirilmemiş kopyası](maintenance/2026-09-29-research-installation-separation/REQUEST.md). İş, kullanıcının isteğiyle turlara bölünmüştür.

Bu dosya yalnız `agentic-os-search` deposunu güncelleme çalışmasının planı, ilerleme kaydı ve devir noktasıdır. Yeni DevOS kurulum planı, SOUL iş listesi, mimari veya agent-control dosyası değildir. Bu sürüm ilerleme ve devir kısmını günceller; önceki kayıt `9689e08985c85f3edbb2899b2da5dcdbf3acc0f7` commit'inde, blob `b0c733c887a76e96c35452fe52509efe645139cc` olarak korunur.

## 1. Amaç ve yetki

Depoyu ilk kez okuyan Claude Code kurucusu araştırma kütüphanesini tarihsel DevOS kurulum kayıtlarından ayırabilmeli; eski Codex/P5/DEVOS-001/002 yönlerini güncel kurulum işi sanmamalıdır. Araştırma içeriği, özgün kararların tarihçesi ve kanıt sınırları korunur.

DevOS'un geçerli yönü **Claude Code cloud**; kurulum planının tek evi [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), görevde belirtilen devir sürümü **2.1**'dir. Planın kopyası bu depoya konulmaz. Yeni ürün deposu `batuhanozgun/soul-system`; eski `batuhanozgun/soul` ve görevde sayılan diğer deneme depoları değiştirilmez. [D030](explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri) bu yetki/statü değişimini taşır.

Yazma yalnız `batuhanozgun/agentic-os-search` içindedir. `AGENT.md` ve `agent/**` değiştirilmez. Başka depolara, Supabase projelerine, hesaplara veya erişim ayarlarına yazılmaz. Kurulum yapılmaz. Aktif araştırma paketlerinin kendi durumları korunur; bunlar Claude Code için kurulum talimatı değildir.

`batuhanozgun-devos` makine hesabının teknik yazma imkânı yazma yetkisi değildir. Bu hesapla ilişkilendirilmiş commit görülürse düzeltmeden önce Batu'ya bildirilir. Her yayın öncesi main delta ve yazar kontrolü yenilenir. Hesap erişimini kaldırma bu bakımın işi değildir.

Görev kaynağındaki tarihli platform karşılaştırmaları kullanıcıdan alınan bağlamdır; bu bakım onları yeni teknik yeterlik veya fiyat doğrulaması olarak onaylamaz. Verilmiş platform kararı yeniden açılmaz.

## 2. Ayrımın tasarımı

**Yerinde statü ve yönlendirme ayrımı; toplu taşıma yok.**

- Foundation, studies, concepts ve kavramsal explorations kendi yerinde kalır; araştırma anlamı değişmez.
- Eski kurulum/planlama ve devir dosyalarının başına tarihli statü notu konur; eski gövde, kaynak kullanıcı sözleri ve test/öneri sınırları korunur. “Tarihsel” statü, bulguyu hipoteze veya öneriyi karara dönüştürmez. Yeni ortamın da Claude olması eski bir Claude taslağını etkinleştirmez.
- Kök ve alan girişlerinde araştırma, tarihsel kurulum, kontrol ve yayın ayrılır. Doğrudan alt dosya açılışları da incelenir; kök uyarısı tek başına son kabul değildir. Araştırma dizinindeki güncel araştırma rotaları topluca tarihsel ilan edilmez.
- Eski rapor/paket kopyaları [archives/devos-pre-claude-2026-09-29/](archives/devos-pre-claude-2026-09-29/README.md) altındadır. Beş geri kazanılmış ailenin 19 özgün dosyası doğrulanmış repository ZIP'inde, Academy ayrıca bağımsız dosyadadır. SOUL ve DevOS bağımsız özgün dosya olarak ayrıca eklendi. **Eksiksiz arşiv değildir:** yalnız P5 S00–S12 erişimi açık. ZIP üyesi ile bağımsız repository yolu ayrı kaydedilir; özgün gövdeler değişmez.
- [MOVES.md](MOVES.md) gerçekleşen taşımaları tutar. **Taşıma yok.** Kopya ve kaynak bağı ayrı kaydedilir. Çok dosyalı taşıma gerekirse uygulamadan önce Batu'ya kısa plan sunulur.

## 3. Beş iş paketi ve kapanış koşulları

Paket gerektiğinde birkaç tur sürer; numarası otomatik tur sayısı değildir. Her tur doğrulanmış sonucu ve tek devam noktasını kaydeder.

| Paket | İş ve kapanış koşulu | Durum |
|---|---|---|
| **A1 — Başlangıç ve kalıcı plan** | Görev, başlangıç kimlikleri, yazar sınırı, dış plan adresi, kök yönlendirme; uzak yayın ve geri okuma | **TAMAM:** `ab8ef329aa4841fae2b836c91e74e68ad1c4c9e5` |
| **A2 — Karar ve güncel yönler** | D030; EXP-006 ve deneme/bağlam girişleri; doğrudan eski devirler; eski kurulum bu yollardan güncel diye devralınamıyor | **BELGE DÜZEYİNDE TAMAM:** §4.10–4.11 ve A2-CLOSE. Depo geneli yokluk veya bağımsız kurucu davranışı iddiası değildir |
| **A3 — Rapor ve paket arşivi** | Yedi kaynak ailesini gerçek gövde ve kimlikle arşivle; farklı P5 paketlerini karıştırma; erişilemeyeni yeniden üretme | **KISMİ / TEK KALICI AÇIK SINIR:** §5.2. Altı aile arşivde; yalnız P5 S00–S12 bulunamadı. K paketi onun yerine geçmez |
| **A4 — Depo geneli tarama** | Bütün izlenen yollar, metinler ve gerekli belge/ZIP içleri; riskli eşleşmeler için düzeltme veya gerekçeli koruma; okunmayan kapsam açık | **TAMAM:** §6.22–6.23 / A4-ENTRY-BODY-SCAN-04. 299/299 entry/state yüzeyinin giriş penceresi ve kalan gövde risk taraması, genişletilmiş link kontrolü ve archive/ZIP disposition'ı kapandı; actionable yeni kaynak/link düzeltmesi yok. Bu, bütün study yapraklarının semantik yeniden-okuması değildir |
| **A5 — Son karşılaştırma ve teslim** | Başlangıçtan son commit'e fark; silme/taşıma/gövde ve bağlantı denetimi; yeni okuyucu yürüyüşü; tam değişiklik/gerekçe listesi | **TAMAM:** [A5-FINAL-DELIVERY](maintenance/2026-09-29-research-installation-separation/A5-FINAL-DELIVERY.md). 1 Ekim kapanış düzeltmeleri uygulandı; yalnız P5 S00–S12 açık sınır olarak taşınır |

## 4. A2 — tamamlanan alt kümeler ve kapanış

### 4.1 Ana girişler ve D030

[A2-CORE](maintenance/2026-09-29-research-installation-separation/A2-CORE.md) 13 dosyayı, başlangıç blob'larını ve gerekçeleri listeler. **Yayımlanmış commit:** `8612f1320dbfeeef089964d4c48025051f1bb0e6`. Kaynak dosyalarının farkı 160 ek satır, 0 çıkarılan satırdır. Aynı kayıttaki `0145e407...` yalnız içerik doğrulama adayıdır; yayın kimliğiyle karıştırılmaz.

D030; EXP-006 STATE/HANDOFF/INDEX/WORK/DECISIONS ve eski CODEX_START; development-os INDEX/001 WORK/002 README; soul-context README/INDEX/STATE/repos-soul girişleri bu kümededir. D027/D029'un ortam kararı geçersiz kılındı; özgün gövdeler ve yüksek kalite/sağlayıcı bağımsızlığı hedefinin tarihçesi korundu.

### 4.2 Doğrudan teslim, mesaj ve alan girişleri

[A2-DIRECT-ENTRIES](maintenance/2026-09-29-research-installation-separation/A2-DIRECT-ENTRIES.md) ikinci kümenin tam listesini, kaynak blob'larını, okuma ve kontrol sınırını taşır. **Yayımlanmış commit:** `f690aa6bf5398d90bef2b7ee0b1b74ff52ba96c7`.

EXP-006 P4-01–P4-05 ve P5-01 (6); DEVOS-001 BRIEF/METHOD/EXCHANGE/REVIEW (4) ve R-001–R-006 (6); eski Claude hazırlığı WORK/TASK (2); research/INDEX, explorations/INDEX ve CATALOG (3): **21 dosya**. Her birinde yalnız başlangıçta 6 ek satır; toplam 126 ek satır, 0 çıkarılan satır. İçerik doğrulama adayı `ac026aba9de076dbf0181c748b51a1a279c01783`, tree `93f422340cec206ca4efd802d3d77c50aa1a8f2e`, gerçek yayınla aynı kavram değildir.

Bu iş statü/yönlendirmedir; rapor gövdelerinin arşivlenmesi veya içlerindeki test iddialarının yeniden doğrulanması değildir. S paketi ile K paketi ayrı kimlikler olarak kalır.

### 4.3 Eski current envanteri ve sekiz ana devir girişi

[A2-CURRENT-INVENTORY](maintenance/2026-09-29-research-installation-separation/A2-CURRENT-INVENTORY.md), `research/soul-context/current/` altındaki **41 başlangıç dosyasının** yol/blob/boyut listesini taşır: 2 kök, 13 brief, 4 Claude hazırlık, 22 review/kanıt dosyası. Önceki kesilmiş envanter sorunu, kök dizin ve üç ayrı recursive alt-ağaç okumasıyla kapatıldı. Envanter tamlığı içerik okuma tamlığı değildir. Bu dosyanın tarihli tablo ve ilerleme notları kendi turlarının anlık görüntüsüdür; güncel toplam ve devam burada tutulur.

Sekiz kaynak dosyası işlendi: COORDINATION-TRANSFER-PLAN ve DEVELOPMENT-OS-BOOTSTRAP; dört brief (COORDINATION-HANDOFF, DESIGN-01, DEVOS-AGENT-CONTROL, DEVOS-CONSTRUCTION-PLAN); OWNER-CONTEXT ve SOURCE-REGISTER. Ayrıca yeni `current/README.md` eklendi. **Gerçek yayın commit'i `cd35ef63d9a80dd6ff224726d2b083fa386a3c59`**.

İçerik doğrulama adayı `ff395e0eefbbc8b1e4de7af609ada4bfa84be1e9`, tree `1407d2d265f88c1773256a681df056cb799b0592`: sekiz kaynakta toplam 48 ek satır, 0 çıkarılan satır; yeni README 22 satır. İlk adayın iki dosya-sonu farkı düzeltilmeden yayına alınmadı.

### 4.4 Son dokuz brief

[A2-BRIEFS](maintenance/2026-09-29-research-installation-separation/A2-BRIEFS.md) dokuz dosyanın tam listesini, başlangıç blob'larını, gerekçeleri ve kontrol sınırını taşır. Envanterin **03–05 ve 10–15** satırlarıdır: COORD-01/02/03, G0-D1, G1, G1-R1, Stage-1, Stage-1A ve Stage-2/G0. **Gerçek yayın commit'i `9620dfdeda71f25580f6945c2bb3a11c19b78703`**.

Dokuz dosyanın tamamı sabit başlangıç commit'inden okundu. Düzeltilmiş içerik doğrulama adayı **`3a371a2b653b6eb37b0c78cd5921b8f24e3c510f`**, tree **`7cf7d124d62e06cc2a6f112dd9efafde0745755c`**, parent `cd35ef63d9a80dd6ff224726d2b083fa386a3c59`: her dosyada yalnız başlangıçta 6 ek satır, **toplam 54 ek satır ve 0 çıkarılan satır**. Tam birleşik diff'te bütün hunk'lar dosya başındadır; özgün gövdeler korunur. İlk yayımlanmamış `2369810...` adayındaki dört son-satır-sonu farkı giderildi.

Bu tur sonunda `briefs/` grubunun 13 dosyasının doğrudan giriş statüsü ele alınmış, current alanının 41 başlangıç dosyasından 19'u işlenmiş ve 22 review/kanıt dosyası açık kalmıştı. Bu tarihli sonuç, aşağıdaki yeni incelemelerin yerine geçmez.

### 4.5 İlk altı review/kanıt kaydı

[A2-REVIEWS](maintenance/2026-09-29-research-installation-separation/A2-REVIEWS.md)'ın korunmuş ilk küme bölümü, envanterin **20–25** satırlarının tam okumasını, beş not ve bir gerekçeli koruma kararını, kaynak kimliklerini ve doğrulama sınırını taşır. Direction, G0 ve Stage-1 çiftleridir; toplam başlangıç gövdesi **91.072 byte**. **Gerçek yayın commit'i `4e1eaee7f2e888cc8b51e67ace2edd2aebf9fef6`**.

Beş not; ham opening vision'ın eski Routing gate'ini, ham Codex tasarım cevabını ve üç REVIEW dosyasındaki eski güncel/sonraki önerileri tarihsel bağlama alır. G0 `EVIDENCE-EXTRACTS.md` ilk paragrafta zaten tarihli seçili kanıt olduğunu, talimat veya canlı durum olmadığını açıkça belirttiği için değiştirilmedi. Yeni not eklememek de gerekçeli inceleme sonucudur.

Düzeltilmiş içerik adayı **`50e4dcd27ac8a9025d4778a1148c8eb6c321ac8c`**, tree **`eb90660ac6aade7e7fc892d03467e3c18090a1af`**, parent `9620dfdeda71f25580f6945c2bb3a11c19b78703`: beş dosyada yalnız başa toplam **30 ek satır, 0 çıkarılan satır**. Özgün gövdeler ve dosya sonları korundu. Ham aktarımların eski hash/satır kimliklerinin not hariç gövdeye ait olduğu ve öneksiz sabit kaynak bağlantıları açıkça yazıldı.

Bu kümenin sonunda current alanında **25/41**, reviews grubunda **6/22** başlangıç dosyası sonuçlandırılmıştı. Önceki denetim kayıtları tarihli tutulur; her tur yeni bir yetkili durum kaynağına dönüştürülmez. Yeni platform, eski deney veya bağımsız Claude davranış doğrulaması yapılmadı.

### 4.6 Stage-1A ve COORD zinciri — dokuz kayıt

[A2-REVIEWS](maintenance/2026-09-29-research-installation-separation/A2-REVIEWS.md)'ın ikinci küme bölümü, envanterin **26–34** satırlarının tam listesini, başlangıç blob'larını, gerekçelerini ve okuma/denetim sınırlarını taşır. Stage-1A yanıtı ve incelemesi; collaboration incelemesi; COORD-01 yanıtı ve incelemesi; COORD-02'nin üç kaydı; COORD-03 incelemesi: **dokuz dosya, 101.729 byte özgün kaynak metadata toplamı**. **Gerçek yayın commit'i `67fd24ec4574dbb3d5024cd9acd10d522ee11d00`**, bu turun başında uzak main/ref ve commit nesnesinden doğrulandı.

Kaynakların tamamı bu turun sabit başlangıcı `4e1eaee7f2e888cc8b51e67ace2edd2aebf9fef6` üzerinden okundu. Kaynak-only doğrulama adayı **`8e1f747fc64aed68710b0d867f53dcf86241b99b`**, tree **`0bf08586887d3da5fa23e111fc4aec087fc0a1f5`**, parent aynı başlangıçtır. Her dosyada yalnız altı satırlık başlangıç notu; **toplam 54 ek satır ve 0 çıkarılan satır**. Birleşik patch ve dosya farklarında özgün gövde/EOF değişikliği yoktur.

Eski kontrol taslakları ve G0 önerisi güncel talimat olmaktan ayrıldı. COORD-02'nin ilk dosya talebi → kimlik çözümü → yeni oturum raporu → COORD-03 erişim/bellek sınırı zinciri, eski kaynakları yeniden yazmadan doğrudan girişlerden bulunur. Sonradan karşılanmış eski bir talep, yeni eksik iş sanılarak tekrar açılmaz. Gözlem/aktarım/yorum ayrımları ve platformdan bağımsız ilkeler korunur.

Bu kümenin sonunda reviews **15/22**, current başlangıç envanteri **34/41** sonuçlandırılmıştı. Bu sayılar dosya inceleme kapsamıdır; bütün A2, arşiv, depo geneli tarama veya hedef sistem yeterliği değildir. Önceki altı kaynak ve başlangıç envanteri o tur yeniden düzenlenmedi. Yeni bir bakım alt sistemi veya DevOS iş listesi oluşturulmadı; mevcut bakım kaydı ve plan ilerletildi.

### 4.7 D1, G1, yöntem ve DevOS-02 — son yedi kayıt

[A2-REVIEWS-CLOSE](maintenance/2026-09-29-research-installation-separation/A2-REVIEWS-CLOSE.md), başlangıç envanterinin **35–41** satırlarının tam okumasını, dört not ve üç gerekçeli korumayı, kaynak kimliklerini ve kontrol sınırını taşır. D1 kanıt/inceleme çifti, G1'in iki Markdown kaydı ve Python örneği, yöntem incelemesi, DevOS-02/RPD incelemesi: **yedi dosya, 88.517 byte özgün kaynak metadata toplamı**. **Gerçek yayın commit'i `bc015e2f97beb9c281bd54a071916324459bc502`**, bu turun başlangıcında uzak main'den doğrulandı.

Bu küme sabit başlangıç **`67fd24ec4574dbb3d5024cd9acd10d522ee11d00`** üzerinden okundu. Doğrulanmış kaynak adayı **`62b69e4e91e6d99e468fac9a6e818f634f790b99`**, tree **`19841993cceb2eec63457d7170ef246af7cd5bc5`**, parent aynı başlangıçtır. Dört inceleme dosyasında yalnız başa toplam **24 ek satır, 0 çıkarılan satır** vardır. İlk adayda saptanan iki son-LF farkı yayın öncesinde giderildi. İki kanıt seçkisi ve sentetik Python dosyası mevcut statü açıklıkları yeterli olduğu için değiştirilmedi; Python çalıştırılmadı.

D1→G1 sonucu ve G1→yöntem askıya alma zinciri doğrudan girişte bulunur. DevOS-02 kaydındaki “tek güncel sözleşme”, RPD01/AGENTS değişikliği ve eski hedefe çalışma grant'ı bugünkü yetkiden ayrıldı. RPD kavramı ve platformdan bağımsız güvence/muhakeme içeriği korunur; eski deney veya kontrol görevi uygulanmaz.

**Yeni toplam:** reviews **22/22**, current başlangıç envanteri **41/41** dosya statü bakımından sonuçlandırıldı. Reviews grubunda toplam 18 not, 4 gerekçeli koruma vardır. Sonradan eklenen current README başlangıç sayısına dahil değildir. Bu, bütün depo taramasının veya A2'nin tamamlandığı anlamına gelmez. Önceki kaynaklar ve tarihli denetim kayıtları yeni bir bulgu olmadan yeniden düzenlenmedi.

Kaynak doğrulama adayı tek başına main yayını değildir. Dört kaynak, bu yeni kapanış denetim kaydı ve kök bakım planı aynı nihai ağaçta yayımlanır; gerçek ref ve dosya geri okuması ayrıca doğrulanır. Nihai research alt ağacı kaynak adayındaki `be054da53003bfa4bf9baac4dfae19ee3c8c8acb` ile aynı kalmalı; kontrol dosyaları, silme/taşıma sınırı ve başka çalışma korunmalıdır.

### 4.8 DEVOS-001 reading — dört kayıt

[A2-READING](maintenance/2026-09-29-research-installation-separation/A2-READING.md), dört dosyanın tam listesini, başlangıç kimliklerini, statü gerekçelerini ve doğrulama sınırını taşır. COVERAGE, F00-CONTEXT-AND-USE, F08-FOUNDATION-FRAME ve F08-RECONCILIATION tam okundu; **4/4** sonuçlandırıldı. Bu grup current 41/41 sayısının dışındadır; sayılar birbiriyle toplanmaz. **Gerçek yayın commit'i `85700994390f7f0532678f759754cdd7f0b87ab2`**, bu turun başlangıcında uzak main/ref ve commit nesnesinden doğrulandı.

Başlangıç **`bc015e2f97beb9c281bd54a071916324459bc502`**. Doğrulanmış kaynak adayı **`0d8e4c6ef22df5ebe03e4e124f27f88364dff798`**, tree **`35536add43596d4a004af71be54826b9ecae52d7`**, aynı parent: yalnız dört dosyanın başına **24 ek satır, 0 çıkarılan satır**. F08'in ilk adayda düşen son LF'si yayından önce geri kondu. Özgün gövdeler, kaynak yorumları ve epistemik sınırlar aynen korundu.

F08'in eski tamlık beyanı mevcut düzeltme ekine; eski seri Foundation okuma yönleri de sonraki COVERAGE yöntem kaydına bağlandı. Bu tarihsel sıra güncel DevOS kurulumuna veya Foundation'ın kendi işlerine talimat vermez. Araştırma katkıları geçersiz sayılmadı. Yeni notların dokuz göreli bağlantısı çözüldü; hedefler ve D030 kimliği doğrudan okundu. Eski bütün gövde bağlantılarının denetimi A4/A5'tedir.

Kaynak adayı yayın değildir. Nihai commit yalnız dört reading kaydı, A2-READING ve bu planın ilerleme/devrini kapsar; development-os alt ağacı kaynak adayındaki `e3a104adc534aa5f4caf10f4252b000aae94731b` ile aynı kalmalıdır. Yayın öncesi main/yazar kontrolü ve yayın sonrası ref/dosya geri okuması ayrı yapılır. Önceki kapanmış dosyalar yeniden düzenlenmedi.

### 4.9 EXP-006 P1/P2/P3 — üç doğrudan giriş

[A2-P1-P3](maintenance/2026-09-29-research-installation-separation/A2-P1-P3.md), üç dosyanın tam listesini, başlangıç kimliklerini, gerekçelerini ve doğrulama sınırını taşır. P1-01, P2-01 ve P3-01 baştan sona okundu; **3/3** statü bakımından sonuçlandırıldı. Bu sayılar önceki current veya reading gruplarının paydasını değiştirmez. **Gerçek yayın commit'i `94799de0cd4ccf1396ad047a505162a2be2b2ca5`**, bu turun başlangıcında uzak main/ref ve commit nesnesinden doğrulandı.

Başlangıç **`85700994390f7f0532678f759754cdd7f0b87ab2`**. Kaynak doğrulama adayı **`4ef54ef101d2c866c619ef28f10882c775476a66`**, tree **`9e7412528e707ffb2784c841876ce0a7f9fecdd8`**, aynı parent: yalnız üç kaynağın başına **18 ek satır, 0 çıkarılan satır**. Birleşik diff ve üç patch okundu; özgün gövde ve dosya sonları korundu.

P1'in zaten Claude'u konu alması eski seçenekleri güncel yapmıyor. P2'nin ilk 16 sözleşmesi aday statüsünde; P3'te genişleyen G/Y profilleriyle tarihsel bağı görünür. P3'te D021'in sınırlı kullanıcı kabulü, bakım ve H1–H6 yükleri korunurken eski P4'e geçiş güncel görevden ayrıldı. Yeni notların yedi göreli bağlantısı çözüldü, D030 kimliği ayrıca okundu. Geçmiş platform ve deney beyanları yeniden doğrulanmış sayılmadı.

Kaynak adayı main yayını değildir. Nihai commit yalnız bu üç kaynak, A2-P1-P3 ve kök bakım planını kapsar; explorations alt ağacı kaynak adayındaki `e7d395aeb8d7afa73323af66f96003453559ecf3` ile aynı kalmalıdır. Yayın öncesi main/yazar kontrolü ve yayın sonrası ref/dosya geri okuması ayrı yapılır.

### 4.10 ACTORS ve Context — son iki doğrudan giriş

[A2-CLOSE](maintenance/2026-09-29-research-installation-separation/A2-CLOSE.md), iki dosyanın tam okumasını, bir statü notunu, bir gerekçeli korumayı ve A2 kapanış değerlendirmesini taşır. ACTORS'ın ilk rol taslağını “current tasarım” diye gösteren başlığı ve eski P3–P5 sırası tarihsel statüye bağlandı. Context'in mevcut Authority notu zaten kronoloji ile güncel yetkiyi ayırdığı; yönlendirdiği STATE/HANDOFF/WORK de D030'u taşıdığı için Context değiştirilmedi. **Gerçek yayın commit'i `58eaaf5f1dfe2f22deecdc07420deb503e95f7d6`**, A3 başlangıcında uzak main/ref'ten doğrulandı.

Başlangıç **`94799de0cd4ccf1396ad047a505162a2be2b2ca5`**. Doğrulanmış kaynak adayı **`bea42b62c23723f61d7624a9c034598d54725020`**, tree **`e1d3760f1efa397b1ae599b1cebb3c22b9cb8e2e`**, aynı parent: yalnız ACTORS başında **6 ek satır, 0 çıkarılan satır**. İlk adayda düşen bölüm boş satırı ve son LF yayından önce geri kondu. Context blob'u `d368b3cb9ce90a2279fff077da4125557ce71551` olarak korunur. Yeni notun üç göreli bağlantısı çözüldü; D030 kimliği ve Context'in üçlü durum/devralma yolu doğrudan okundu.

Kaynak adayı main yayını değildir. Nihai yayın yalnız ACTORS, A2-CLOSE ve bu planın ilerleme/devrini içerir. Yayın öncesi main/yazar kontrolü, yayın sonrası ref/dosya geri okuması ve kontrol kimliklerinin korunması ayrıca denetlenir. Yeni bir kurulum veya araştırma görevi başlatılmaz.

### 4.11 A2 kapanışı ve açık kalan kapsam

**A2 belge düzeyinde tamamlandı.** D030, kök/alan girişleri, eski deneme/devir/mesajlar, current başlangıç envanteri 41/41 (reviews 22/22 dahil), DEVOS-001 reading 4/4, P1/P2/P3 3/3 ve son ACTORS/Context 2/2 dosya sonuçları A2-CLOSE'daki kapanış tablosunda bağlandı. Örtüşen gruplar toplanarak yeni toplam üretilmedi. Önceki tamamlanmış kaynaklar sırf tur değişti diye yeniden düzenlenmedi.

Bu kapanış mevcut doğrudan giriş ölçütüne ilişkindir; bağımsız Claude davranış deneyi değildir. B/S1/history/sources dahil bütün kalan içeriklerin, arama sonucunda başlık dışından girişin ve eski gövde bağlantılarının kapsamlı taraması A4'te; başlangıçtan bütün fark ve yeni okuyucu değerlendirmesi A5'tedir. **“Eski yönü güncel gösteren hiçbir kayıt kalmadı” henüz söylenemez.** Bu kalan yükler A2 kapanışıyla kaldırılmadı.

**Tek sonraki iş A3'tür:** §5'teki yedi kaynak ailesinin gerçek gövde/kimlik ve erişim envanteri; ardından özgün kopyaların statü yan kayıtlarıyla arşivlenmesi. A3, A4 ve A5 sırası korunur. Eski Python/deney kaydı bulmak çalıştırma talimatı değildir.

## 5. A3 kaynak matrisi ve doğrulanmış ZIP erişimi

**Güncel düzeltme:** Matris 1 Ekim sonucunu taşır. §5.1 ve aşağıdaki önceki yükleme/arama sonuçları kendi tarihli kapsamlarıyla korunur; SOUL ve DevOS engelinin kapanışı §5.2’dedir. Önceki 5/7 ve iki-engel kayıtları güncel durum değildir.

[A3-INTAKE](maintenance/2026-09-29-research-installation-separation/A3-INTAKE.md), ilk kaynak erişiminin ve kimlik denetiminin tarihli kaydıdır. İlk yayın `323e38d288b6760ab70e15744c86678fcbc9d125` yalnız Academy gövdesini ve yan kayıtları getirdi. `0548bd4a55ef3b87fbb3674cf075c2f6d8e639ec` aktarım engelini ve tek ZIP yükleme yolunu kaydetti. **Bu iki kayıttaki yayın bekleme durumu, aşağıdaki doğrulanmış yüklemeyle aşılmıştır.** Yükleme doğrulaması `b0339e77713c2182988e635859ed6d6d79b19cb7` turuna aittir; 30 Eylül erişim değerlendirmesi §5.1’de, 1 Ekim kapanışı §5.2’dedir.

Batu'nun `93216f73ea565ed3ba22e4ba0e18e2144e1368c4` commit'i [A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip](archives/devos-pre-claude-2026-09-29/A3_Dogrulanmis_Tarihsel_Kaynaklar_2026-09-30.zip) dosyasını özel arşive ekledi. Uzak yol, **20.275.988 byte** boyut ve **`547522120893c25d5c709deb5c0e18f57ebe7806`** Git blob kimliği, yerelde gerçek byte'ları açılan özgün ZIP ile eşleşti. Yerel SHA-256 **`8b06cb2b3dca5875cab0ad72595701e3e0d4d756d0c80fa2f49041df48aa9b17`**. 19 özgün dosyanın her birinin boyut/SHA-256/Git blob kimliği yeniden doğrulandı; toplam 21 üye benzersiz ve güvenli, CRC geçerli.

| Kaynak | Statü | Gerçek erişim / kalan iş |
|---|---|---|
| P4 v3 | Tarihsel; uygulama kaynağı değil | Dört özgün dosya repository ZIP'inde doğrulandı; bağımsız repository dosyaları oluşturulmadı |
| P4 v4 | Tarihsel; mimari kaynak; Codex ortam kararı geçersiz | Dört özgün dosya repository ZIP'inde doğrulandı; bağımsız repository dosyaları oluşturulmadı |
| P5 K00–K15 | Tarihsel; rol/veri modeli aktarımının kaynağı | Beş özgün dosya repository ZIP'inde doğrulandı; S ailesinin yerine geçmez |
| P5 S00–S12 | Tarihsel; senaryolar gelecekte sınav fikri olabilir | Eski teslimin beklenen kimlikleri kayıtlı; özgün gövdeler hâlâ bulunamadı. Yüklenen ZIP bu paketi içermez |
| P5 v2 Codex arayüzü | Tarihsel; veri modeli aktarımının kaynağı | Beş özgün dosya repository ZIP'inde doğrulandı; bağımsız repository dosyaları oluşturulmadı |
| SOUL ve DevOS | Tarihsel kaynak; SOUL tanımı yeni planda güncellendi | [Kullanıcının sağladığı özgün rapor](archives/devos-pre-claude-2026-09-29/soul-and-devos/SOUL_ve_DevOS.md) bağımsız dosya olarak arşivde; kimlik §5.2’de |
| SOUL Academy | Keşif notu; karar veya doğrudan iş açma yetkisi değil | Özgün gövde hem repository ZIP'inde hem bağımsız Markdown dosyasında; iki kopya aynı kimlikte |

[Arşiv README](archives/devos-pre-claude-2026-09-29/README.md) yükleme kanıtını ve erişim biçimini; [SOURCE-IDENTITIES](archives/devos-pre-claude-2026-09-29/SOURCE-IDENTITIES.json) sürüm 3 ise bütün dosyaların özgün kimliklerini ve kesin ZIP üye yollarının kuralını taşır. ZIP’teki 19 dosya için üye yolu `archive_container.member_prefix + artifact.path`’tir; 19 eşleşme gerçek ZIP’te denetlendi. SOUL ve DevOS bu kuralın dışında bağımsız repository yoluyla kayıtlıdır. Bağımsız repository yolu yalnız gerçekten oluşturulduğu yerde ayrıca belirtilir. ZIP içindeki eski kimlik listesi güncel envanterin üstüne yazılmaz.

**Doğrulama sınırı:** Uzak ikili dosya bu tur yeniden indirilmedi; uzak Git nesne kimliği ve boyut, yerelde açılan özgün byte'larla eşleştirildi. Önceki A3-INTAKE'in 14 teslim girdisi ve 349 iç manifest girdisi denetimleri kendi tarihli sonuçlarıdır; bu tur yeni hedef testi gibi sayılmaz. Tarihsel kod/testler çalıştırılmadı; PDF görünümü, kaynak iddiaları, tam aktarım sadakati veya Claude'un hedefte içe alma davranışı doğrulanmış değildir.

**Yükleme engeli kapalı; iki kaynak erişim engeli açık.** Beş geri kazanılmış aile için yeniden yükleme veya ayrı dosya üretimi beklenmez. S00–S12 ve SOUL ve DevOS için mevcut kapsamın ek erişim incelemesi §5.1'de sonuçlandırıldı; kaynaklar geri kazanılmış veya arşiv eksiksiz tamamlanmış sayılmadı.

Aktarım sadakatinin tamamının doğrulandığı iddia edilmez. Dış değerlendirme yalnız [devos/plan/Inceleme_Degerlendirmesi_ChatGPT.md](https://github.com/batuhanozgun/devos/blob/main/plan/Inceleme_Degerlendirmesi_ChatGPT.md) üzerinden bulunur; burada kopyalanmaz ve yeni karara bağlanmaz. Tamamlanmış A2 dosyaları yeniden düzenlenmez.

### 5.1 Kalan iki kaynak — erişim incelemesi ve engel kararı

[A3-ACCESS-GAPS](maintenance/2026-09-29-research-installation-separation/A3-ACCESS-GAPS.md), ek aramanın tam kapsamını, okunan/kısmen okunan yüzeyleri ve yanlış ikameyi engelleyen kimlik ayrımını taşır. Konuşmanın **72 dosyalık metadata envanteri** tamamlandı; yerelde **67 dosya ve 7 farklı ZIP'in 376 üye girdisi** kimlik/başlık keşfi için tarandı. S'nin dört beklenen artefakt kimliğiyle eşleşme bulunmadı. Library'de son 100 kaydın metadata sayfası, hedefli içerik aramasının iki sayfası ve bir SOUL adayının ilgili başlıkları incelendi; Library'nin bütünü veya tüm commit geçmişi okunmuş sayılmaz.

Aynı adlı P5 rehberinin erişilen gövdesi K00–K15'tir. `Pasted markdown(9).md` başlıklı Library kaydı ise `SOUL — Canonical Concept Context for an AI` metnidir; istenen raporun bölüm atıflarıyla eşleşmedi. Hiçbiri eksik kaynak yerine alınmadı. Kaynakların hiçbir yerde bulunmadığı, hiç üretilmediği veya silindiği sonucu çıkarılmadı.

**A3 sonucu: 5/7 aile arşivde; 2/7 aile erişim engeliyle açık.** Mevcut somut ipuçlarıyla erişim incelemesi sonuçlandı; REQUEST §3.4'teki iki arşiv yükü kaldırılmadı. Yeni özgün dosya, kesin kaynak referansı veya yeni erişim kapsamı geldiğinde yalnız bu iki kaynak için A3 yeniden ilerletilir. Sonuçsuz sorgular döndürülmez ve Batu'dan aynı doğrulanmış ZIP yeniden istenmez.

**Sıradaki yetkili iş A4'tür.** Bu, aşağıdaki §6'nın erişilemeyen arşiv ile bağımsız yönlendirme işini ayıran mevcut kuralına dayanır. A3'ün engel değerlendirmesi yapılmıştır; eksiksiz arşiv kabulü verilmemiştir. A4/A5 bu iki kaynağın içeriği hakkında hüküm üretmez ve son teslimde erişim açıkları görünür kalır. Bu tur A4 veya A5 yürütülmedi.

### 5.2 1 Ekim — SOUL ve DevOS arşivlendi

Batu’nun beş maddelik kapanış düzeltmesi ve bu devam konuşmasında verdiği `SOUL_ve_DevOS.md`, istenen raporun kaynak kimliği için açık kullanıcı teyididir. Özgün 147.006 byte aynen arşivlendi; SHA-256 `0f8221445a59eccf1a52efa3d2fe3c7fac642d1370aff99acdc1894fbcfdc3c2`, Git blob `bcf79ccfcc21e1b8c294bd60cc17b065ce19e15a`. Mevcut ZIP ve önceki özgün kaynaklar değiştirilmedi.

**Güncel arşiv 6/7; tek kalıcı açık sınır P5 S00–S12.** K00–K15 ikame değildir. Bu sınır ancak yeni özgün kaynak veya somut erişim kanıtıyla yeniden ele alınır; arşiv eksiksiz ilan edilmez.

## 6. Denetim ve son teslim yükü

Başlangıç: **`8cd01e4afdcd0d37960b05930c91e1244678be6e`**. [BASELINE.json](maintenance/2026-09-29-research-installation-separation/BASELINE.json) başlangıç tree/blob ve istek hash'ini taşır. A1 kök README'nin eski gövdesini aynı blob ile denetim kopyasında korudu. A2 dosya taşımadı veya silmedi.

Her tur ve yayın öncesi main ilerlediyse delta/yazarlar incelenir; başka çalışmanın değişikliği geri alınmaz. Yayın force push olmadan yapılır. Çakışan güncelleme sessizce ezilmez. Makine hesabı commit'i görülürse kullanıcıya bildirimden önce düzeltme yapılmaz. Bu turun başlangıcı `b0339e77713c2182988e635859ed6d6d79b19cb7`; önceki doğrulanmış yayından sonra gözlenen main farkı yoktu. Aynı sabit ref üzerindeki author/committer makine hesabı sorguları boştu; bu bütün dal/kimliklerde yokluk iddiası değildir.

A4 taraması en az `Codex`, `güncel`, `current`, `sıradaki`, `next`, `DEVOS-001`, `DEVOS-002`, P4/P5 ve eski hedef repo adlarını kapsar. Sonuçlar tam izlenen yol envanteriyle karşılaştırılır. Eşleşme hata veya aramada bulunmama yokluk kanıtı değildir: tarihsel alıntılar, gerçek eski kanıt ve aktif araştırmanın kendi sonraki işi gerekçeyle korunabilir. Pasif arşiv içeriği talimat diye uygulanmaz.

A5: sıfır silinen dosya; değişmeyen kontrol blob/tree kimlikleri; araştırma gövdelerinin korunması; yalnız gerekçeli statü/yön farkları; varsa taşımada eski/yeni byte eşliği ve link düzeltmesi; gerçek kaynak erişimi; tam değişiklik/ekleme/taşıma listesi; görev §3 dışında yapılanların gerekçesi; commit bağlantıları; kalan ifadelerin nedeni ve erişim açıkları.

Tam tarama ve arşiv erişimi yapılmadığı için **“eski yönü güncel gösteren hiçbir kayıt kalmadı” henüz söylenemez**. Erişilemeyen arşiv ilgili paketi açık bırakır; bağımsız yönlendirme düzeltmesini engellemez. Yeni teknik/ürün kararı üretmek, eski planı kurmak veya paket uydurmak çözüm değildir.

### 6.1 A4 — ilk tarama ve bekleyen yayının sonuçlandırılması

Başlangıç `23b589703f0849c77a91e7b8c182ce16f8a38748`; root tree `fc2458047c8a6b6fcfeda076aeaecf3e093957a5`. [A4-INITIAL-SCAN](maintenance/2026-09-29-research-installation-separation/A4-INITIAL-SCAN.md) §1–§6 önceki hazırlama turunu; **§7 bu yayına geçişi** taşır. Eski NOT_PUBLISHED cümleleri tarihli hazırlama kaydıdır; yeniden yükleme veya yeni yayın işi açtırmaz. [A4-SCOPED-INVENTORY](maintenance/2026-09-29-research-installation-separation/A4-SCOPED-INVENTORY.json), aynı başlangıçtaki 69 yol/mode/type/blob/boyut ve sekiz tam okuma kararını koruyan şema 2'dir. Dönüşümün özgün kayıtla eşliği denetlendi; kaynak kimliği ve sınırlar içinde kayıtlıdır.

`development-os/` 19/19 ve EXP-006 50/50 dosyasının başlangıç envanteri, yapraklardan yeniden kurulan iki Git ağacıyla eşleşti; bir yaprağın çıkarılması eşitliği bozdu. Bu 69 dosyanın tamamının gövdesinin okunması veya bütün repository envanterinin tamamlanması değildir. Sekiz tam okuma önceki hazırlama turuna aittir; bu yayında yeni sekiz okuma yapılmış sayılmaz.

Dört history dosyası için hazırlanan statü ve sabit tarihsel kaynak notları uygulandı. Kaynak-only doğrulama adayı `22da50718d9933da33661cbdf46ff2ce50cee442`, tree `978f5257fbbf208629e888eed3b8287f0f289a81`: yalnız **39 başlangıç satırı**, 0 çıkarılan satır; özgün gövde ve son-LF'ler korunur. Bu aday tek başına main yayını değildir; dört kaynak, iki bakım kaydı ve bu plan aynı nihai ağaçta yayımlanır. Yeni kaynak blob'ları A4-INITIAL-SCAN §7'de bulunur; yayın sonrası ref/dosya geri okuması ayrıca yapılır.

GitHub yazma işlemleri bu tur çalıştı. Main başlangıçta değişmemişti; makine hesabı author/committer sorguları boştu. İlk adayın iki son-LF farkı yayın öncesinde giderildi. Araştırma, kontrol ve arşiv gövdeleri değişmedi; dosya silinmedi veya taşınmadı. Gövde içindeki bütün tarihsel bağlantılar sağlam ilan edilmez; eski dizin bağlamındaki aynı gövdeye dönüş yolu gösterildi.

**Bu alt kümenin işi, dört tarihsel girişin ayrıştırılmasıdır; A4 genel kabulü değildir.** B/S1 gövdeleri, diğer alanların envanter ve içerikleri, gerekli ZIP/belge içleri ve kapsamlı bağlantı denetimi açık. A3 iki erişim engeliyle kısmi; A5 bekliyor.

### 6.2 A4 — envanterin genişletilmesi ve aktif araştırma sınırı

Başlangıç main **`36255c146241f0d05ed8f4672f7cbf7c35752af5`**, root tree `195e2f97bf456c8cd50f96cb8c5191092ada62cb`; önceki yayınla fark gözlenmedi. [A4-PATH-INVENTORY](maintenance/2026-09-29-research-installation-separation/A4-PATH-INVENTORY.json) bu sabit sürümde **207 açık dosya kimliği ve sekiz henüz açılmamış alt ağacı** taşır. Önceki 69 dosya tekrar yeni sayılmaz; bu tur 138 ek dosya envantere girdi. [A4-INVENTORY-EXPANSION](maintenance/2026-09-29-research-installation-separation/A4-INVENTORY-EXPANSION.md) yöntem, kapsam, üç giriş okuması, değişiklik gerekçesi ve sınırları taşır.

Concepts 75, publications 26, maintenance 16, agent 9 ve archives 4 dosyanın yaprak envanterleri tamamdır; önceki development-os 19 ve EXP-006 50 de güncel başlangıç kimlikleriyle birleştirildi. Kökün dört, explorations kökünün üç ve research kökünün bir dosyası toplamı 207'ye getirir. EXP-001–005 ile research/soul-context, soul-foundations ve studies alt ağaçları henüz açılmadı. Bunların hash'lerinin bilinmesi içerideki yolların görülmesi değildir. **Tam repository envanteri ve tam gövde taraması hâlâ açıktır.**

Kök README, concepts INDEX ve publications/linkedin README tam okundu. Yalnız concepts INDEX'e altı başlangıç satırı eklenir: aktif terim araştırmasının okuma/current yönleri ChatGPT araştırmasına aittir; Claude kurucusunun talimatı değildir. Araştırmanın yöntemi, sonuçları, kendi yetkisi veya durumu değişmez ve tarihsel ilan edilmez. Özgün 5.801 byte gövde aynen korunur; yeni gövde 6.719 byte, blob `e204ebd05dd4868e64c4616c0a9b67521f91ad00`. Diğer iki giriş mevcut ayrımları yeterli olduğu için korunur. Bu, 207 dosyanın içerik bakımından tamamlandığı anlamına gelmez.

Düz yaprak listesi ve sekiz açık alt-ağaç kimliği birlikte başlangıç root tree'sini yeniden üretti; 207 ayrı yaprak çıkarma, sekiz alt-ağaç çıkarma ve üç yol/mode/blob bozma kontrolünde eşitlik bozuldu. Bu yalnız envanter/kayıt denetimidir; tarihsel deneyler veya Claude davranış testleri değildir. Kontrol ve arşiv gövdeleri korunur, silme/taşıma yapılmaz. A4-SCOPED-INVENTORY ve A4-INITIAL-SCAN önceki tarihli kayıtlar olarak değişmeden kalır. Yeni envanter yayın öncesi snapshot'tır; bu turun dört-yol yayın farkı ayrıca değerlendirilir.

### 6.3 A4 — EXP-001–005 envanteri

Başlangıç main **`d5cbe13f8d38066f1d5d138022dff28b443a58bf`**, root tree **`61fd18514effa53efe68092a4bfed91aedb85d95`**. Önceki yayınla fark gözlenmedi; aynı ref üzerinde makine hesabı author ve committer sorguları boştu. [A4-EXPLORATIONS-INVENTORY](maintenance/2026-09-29-research-installation-separation/A4-EXPLORATIONS-INVENTORY.md) tam kapsamı, yayın kümesini, doğrulama sınırını ve kalan işi; [A4-EXP001-005-INVENTORY](maintenance/2026-09-29-research-installation-separation/A4-EXP001-005-INVENTORY.json) kesin yaprak kimliklerini ve birleşim tarifini taşır.

EXP-001 **66**, EXP-002 **38**, EXP-003 **29**, EXP-004 **75**, EXP-005 **21**: toplam **229 yeni açılan dosya**. Beş alt ağacın kökü yapraklardan yeniden hesaplandı ve uzak Git tree kimlikleriyle eşleşti. Her bir yeni yaprağın çıkarıldığı 229 olumsuz kontrolde eşitlik bozuldu. Bu, metadata doğrulamasıdır; **yeni araştırma gövdesi okuması 0**. PDF, ZIP, HTML, görsel ve tarihsel kod içerikleri incelenmiş veya çalıştırılmış sayılmaz.

Önceki 207-yaprak envanteri değiştirilmeden sabit sürümüyle yeniden kullanılır. `d5cbe13` yayınının iki değişen ve iki eklenen dosyası yeni JSON'daki `snapshot_upserts` alanındadır. **207 + önceki yayının 2 ek dosyası + 229 = 438 açık dosya kimliği.** Explorations'ın tamamı 282 dosya yoluyla envanterlidir. Bu birleşim bütün repository'nin toplam sayısı değildir; research altında üç opak alt ağaç kalır. Önceki 207 dosyanın root denetimi önceki turun sonucudur; bu dilimde birleşik root yeniden hesaplanmış sayılmaz.

Yeni JSON **28.701 byte**, Git blob **`2b72cac6c98844e55ec5275a4cfedf976eec213b`**; uzak oluşturma sonucu yerel dosya kimliğiyle eşleşti. Bu kimlik tek başına main yayını değildir. İki yeni bakım kaydı ve bu plan aynı nihai ağaçta yayımlanır; yayın öncesi main/delta ve yayın sonrası ref/dosya geri okuması ayrı yapılır. Araştırma, kontrol, önceki envanterler, arşiv ve MOVES değişmez; silme veya taşıma yapılmaz. Yeni kapsam yayın öncesi snapshot'tır; bu turun kendi bakım farkları sonraki envanter güncellemesine aittir.

**A4 açık, A5 bekliyor, A3 iki erişim engeliyle kısmi.** Beş envanterin tamamlanması, bu paketlerin içerik/statü/bağlantı denetiminin tamamlandığı anlamına gelmez. §6.1–6.2 ve eski raporlardaki sekiz frontier ifadesi kendi tarihli snapshot'larına aittir; bugünkü kalan envanter yükü üç araştırma alanıdır.

### 6.4 A4 — context envanterinin tamamlanması ve Foundation başlangıcı

Başlangıç main **`2dbf81a5ae66ea0482371725e40a4b8a84802979`**, root tree **`938fa623d9ffbec64f89a2713ee636d6eb574c7d`**. Önceki yayından fark gözlenmedi; aynı ref üzerindeki makine hesabı author/committer sorguları boş döndü. [A4-RESEARCH-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-RESEARCH-INVENTORY.md) kapsamı ve doğrulama sınırını; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-RESEARCH-INVENTORY.json) kesin yaprakları, yayın farklarını ve kalan alt ağaçları taşır.

Context'in **60/60 dosya yolu** açıldı. Foundation'da altı kök dosya, `00_context/` içindeki bir ve `01_verticals/actors/` içindeki 20 dosya, toplam **27 yol** kayıtlıdır. Context kökü 60 yapraktan; Foundation kökü 27 yaprak ve 11 opak alt ağaçtan yeniden üretildi ve uzak kimliklerle eşleşti. 87 ayrı yaprak çıkarma ve 11 opak sınır çıkarma kontrolü eksikliği yakaladı. Bu metadata denetimidir; **yeni araştırma gövdesi okuması 0**. A2'nin eski current incelemeleri yeniden yapılmış sayılmaz.

Önceki 438 açık yola `2dbf81a` yayınının iki yeni bakım dosyası ve bu dilimin 87 yolu eklenir: **527 açık dosya kimliği**. Bütün repository sayısı değildir. Kalan iki üst alan Foundation ve studies'dir; Foundation'ın ayrıntılandırılmasıyla 11 Foundation alt ağacı ve bir studies ağacı, toplam 12 opak sınır kayıtlıdır. Bu yeni kapsam açmak değil, önceki açık kapsamı ayrıntılandırmaktır. Birleşik repository kökü bu tur yeniden hesaplanmadı.

Yeni JSON **14.762 byte**, blob **`a908c77955190588cd199a2cc436342a20949e7a`**; uzak oluşturma kimliği yerelde doğrulanan dosyayla eşleşti. Bu tek başına main yayını değildir. Yalnız iki yeni bakım kaydı ve bu planın ilerleme/devralması yazılır; araştırma, kontrol, arşiv ve önceki envanterler değişmez; silme/taşıma yoktur. Bu turun yayın farkı snapshot'tan sonradır. **A4 açık; A5 bekliyor; A3 iki erişim engeliyle kısmi.**

### 6.5 A4 — Foundation dikeyleri ve yeterlilik envanteri

Başlangıç main **`ac7e4549ee87b35d84a3f34b86e5f48912549cb3`**, root tree **`47a16b3c9a41c9350668fbda81535bb7538fa6d5`**. Önceki yayından fark gözlenmedi; aynı ref üzerindeki makine hesabı author/committer sorguları boştu. [A4-FOUNDATION-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-FOUNDATION-INVENTORY.md) kapsam ve denetim sınırını; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-FOUNDATION-INVENTORY.json) tam yolları, önceki sürüm bağı ve yayın farklarını taşır.

Bu dilimde **173 yeni yol** kaydedildi: records-artifacts 66, work-environment 30, work 17, adequacy 22 ve ground-deepening'in altı kök dosyası ile actors/work blokları 38. Önceki actors dikeyinin 20 dosyasıyla **`01_verticals/` 133/133 dosya** olarak tamamdır. Bu araştırmanın tamamlanması değil, yol envanteri sonucudur. Foundation'ın önceki 27 yolu ile toplam **200 açık dosyası** ve **sekiz opak alt ağacı** vardır; studies ayrıca opaktır.

200 yaprak ve sekiz opak sınırdan Foundation kökü yeniden üretildi: `0f9513f91bba76f1e52c955ddcb6270908c11939`. Git nesne kodlaması Python ve `git hash-object` ile karşılaştırıldı. Her bir 200 yaprak çıkarma, sekiz opak sınır çıkarma ve iki yol/blob bozma kontrolünde kök eşitliği bozuldu. Boyutlar API metadata'sıdır; bu denetim dosya gövdesi, anlam veya okuyucu davranışı doğrulaması değildir. **Yeni araştırma gövdesi okuması 0**; eski betikler çalıştırılmadı. Büyük deepening metadata yanıtı sonuna kadar açıldı, ancak environment/information yaprakları bu dilimin kalıcı envanterine alınmış ve doğrulanmış sayılmaz.

Birleşim **527 + önceki yayının 2 yeni bakım dosyası + 173 = 702 açık repository yolu**. Bütün repository sayısı değildir; birleşik repository kökü yeniden hesaplanmadı. Yeni JSON **24.141 byte**, blob **`e2939212e1095881e5bac5c7ea2b22565f56332b`** olarak yerelde hesaplandı; uzak oluşturma ve yayın geri okuması ayrı doğrulanır. Bu yayın yalnız iki yeni bakım kaydı ve mevcut planı kapsar; önceki envanterler, araştırma, kontrol, arşiv ve MOVES korunur; silme/taşıma yoktur. Yeni kayıtların kendi yayın farkı bu snapshot'tan sonradır.

**Tek sonraki giriş: `research/soul-foundations/03_ground-deepening/grounds/environment`.** Ardından information ve kalan Foundation sınırları, sonra studies gelir. A4'ün tam içerik/bağlantı ve gerekli arşiv içi taraması ile A5 açık; A3'ün iki erişim engeli korunur.

### 6.6 A4 — Environment envanteri ve önceki yayınla uzlaşma

Başlangıç main **`5566cbeecd5b818b5673c0687bbc07ed08631801`**, root tree **`1661760d0ab0a4b626961193cb4fae7c2131777d`**. Önceki konuşmanın `ac7e454` üzerindeki “135 dosya yayın bekliyor” kaydı canlı durum değildi: aradaki tek commit 173 dosyalık envanteri ve planı zaten yayımlamıştı. Author/committer `batuhanozgun`; bu sabit ref üzerindeki makine hesabı sorguları boştu. ZIP'in 15 manifest üyesi doğrulandı; dört alandaki 135 yolun kimlikleri, yayımlanmış 173 yolun ilgili alt kümesiyle uyumlu. Eski değişiklik tanımı yeniden uygulanmadı; ek 38 derinleştirme yolu geri alınmadı. 5566cbe bu turun yayını sayılmaz.

[A4-ENVIRONMENT-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-ENVIRONMENT-INVENTORY.md) uzlaştırma, kapsam ve kontrol sınırını; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-ENVIRONMENT-INVENTORY.json) kesin yolları ve sabit önceki envanterle birleşimi taşır. `03_ground-deepening/grounds/environment` **208/208 dosya**, API boyut toplamı **1.168.031 byte**, kök dahil **48 dizin** ile tam envanterlidir. Yapraklardan yeniden üretilen kök `0a3666bc4f96403d7ef3523fa0614004293fdcb9` ile eşleşti; 208 ayrı yaprak çıkarma ve iki yol/blob bozma kontrolü eksikliği yakaladı.

Foundation'ın **408 açık dosyası + yedi opak alt ağacı**, `0f9513f91bba76f1e52c955ddcb6270908c11939` kökünü yeniden üretti. Yeni yaprakların her biri ve kalan yedi sınır çıkarıldığında eşitlik bozuldu. Birleşik kayıt **702 + önceki yayının 2 ek dosyası + 208 = 912 açık repository yolu** taşır; bütün depo sayısı değildir. Birleşik repository kökü yeniden hesaplanmadı. **Yeni araştırma gövdesi okuması 0**; metadata denetimi içerik, bağlantı veya bağımsız okuyucu sınaması değildir.

Yeni JSON **30.774 byte**, blob **`0b3afb1662f3e0cd64753f90fbba83279a9e4224`**; uzak blob kimliği yerel dosyayla eşleşti. Bu tek başına main yayını değildir. Yalnız iki yeni bakım kaydı ve mevcut planın durum/ilerleme/devralması yazılır; önceki envanterler, araştırma, kontrol, arşiv ve MOVES korunur. Dosya silinmez veya taşınmaz. Yayın öncesi main/delta, yayın sonrası ref ve üç dosya kimliği ayrıca denetlenir. **A4 açık; A5 bekliyor; A3 iki kaynak erişim engeliyle kısmi.**

### 6.7 A4 — Information envanterinin ilk dilimi

Başlangıç main **`d45441970fbec9b022fea59253f6ef85e8e183b3`**, root tree **`92cbb172af53f65027d6ca90763c443ce0d2d4d2`**. Önceki doğrulanmış yayından fark gözlenmedi; aynı ref üzerindeki makine hesabı author/committer sorguları boştu. [A4-INFORMATION-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-INVENTORY.md) kapsamı ve denetim sınırını; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-INVENTORY.json) kesin yolları, önceki sürüm bağını ve yayın farklarını taşır.

Information alanında **157 yeni yol** kaydedildi: kök ve synthesis 19; informational-dynamics kökü ve synthesis 19; derivation-transformation alt dizinleriyle 96; formation-acquisition alt dizinleriyle 23. Son iki alan tam yaprak envanterlidir. Toplam **145 Markdown, 6 JSON, 6 Python; 869.925 API byte**. **Yeni araştırma gövdesi okuması 0**, tarihsel betik çalıştırma 0. Information bütünü tamamlanmadı: selection-exposure ve informational-state opak sınır olarak korunur. Büyük recursive görünüm ve kısmen görülen selection-exposure yanıtı tamamlanmış sayılmadı.

157 yaprak ve iki opak sınır, Information kökü **`57e5859ade346c254e49172028909434af87a460`** ile eşleşti. 20 dizinin Git nesne hesabı `git hash-object` ile karşılaştırıldı. 157 ayrı yaprak çıkarma, iki sınır çıkarma ve iki yol/blob bozma kontrolü eksikliği yakaladı. Aynı yazarın deterministik metadata denetimidir; API boyutları tree hash'ine bağlı değildir. Foundation ve birleşik repository kökleri bu dilimde yeniden hesaplanmadı; içerik, bağlantı, arşiv içi veya bağımsız okuyucu doğrulaması yapılmadı.

Birleşim **912 + önceki yayının 2 yeni bakım dosyası + 157 = 1.071 açık repository yolu**; Foundation **408 + 157 = 565 açık yol**. Bunlar bütün depo veya okunmuş belge sayısı değildir. Sekiz Foundation sınırı ve studies ile toplam dokuz opak sınır kalır; önceki Information sınırının ikiye açılması yeni kapsam değildir. Yeni JSON **22.858 byte**, blob **`5cf56029f4102165c7183666a879b28a1507db44`**; uzak oluşturma kimliği yerel dosyayla eşleşti. Yalnız iki yeni bakım kaydı ve bu planın durum/ilerleme/devralması yayımlanır; önceki envanterler, araştırma, kontrol, arşiv ve MOVES korunur; silme/taşıma yoktur. Aday diff, yayın öncesi main ve yayın sonrası ref/dosya geri okuması ayrı denetlenir. Bu yayının farkları snapshot'tan sonradır. **A4 açık; A5 bekliyor; A3 iki erişim engeliyle kısmi.**

### 6.8 A4 — Information'ın kalan iki alanının envanteri

Başlangıç main **`03a02cf7cff2eb6078eb65a8d80a3138d24c9ab4`**, root tree **`373aff9da4b1e0cf2097d90e47b28cc78a67ca35`**. [A4-INFORMATION-REMAINDER-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-REMAINDER-INVENTORY.md) kapsam ve kontrol sınırını; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-INFORMATION-REMAINDER-INVENTORY.json) tam yeni yolları taşır.

**81 yeni yol:** selection-exposure 62, informational-state 19. **Information 238/238 yol; Foundation 646 açık yol; birleşik kapsam 1.154 açık repository yolu.** Bunlar tam depo veya okunmuş belge sayısı değildir. Altı Foundation sınırı ve studies kalır. Yeni araştırma gövdesi okuması ve tarihsel betik çalıştırması **0**.

Bu yayın yalnız iki yeni bakım kaydı ve bu planın ilerleme/devralmasını değiştirir. Araştırma, kontrol, önceki envanterler, arşiv ve MOVES korunur; silme/taşıma yoktur.

### 6.9 A4 — Top-level adequacy rerun envanteri

Başlangıç main **`a2fd011deb320dfc82e05154613d75d55e0c94a3`**, root tree **`3418d97c15f4d28dd01b20f14cb189ea991c21a9`**. [A4-TOP-LEVEL-ADEQUACY-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-TOP-LEVEL-ADEQUACY-INVENTORY.md) kapsam ve denetim sınırını; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-TOP-LEVEL-ADEQUACY-INVENTORY.json) kesin 16 yolu taşır.

`04_top-level-adequacy-rerun` **16/16 Markdown dosyası** ve **125.095 API byte** ile envanterlidir. Git kökü `5c5afe1cd2ee72b613d99589ef8b76cf03a43c2a` doğrudan girişlerden yeniden üretildi; 16 eksiltme ve bir blob bozma kontrolü eşitliği bozdu. Yeni araştırma gövdesi okuması ve tarihsel betik çalıştırması **0**.

Birleşik kapsam **1.154 + önceki yayının 2 yeni bakım dosyası + 16 = 1.172 açık repository yolu**; Foundation **646 + 16 = 662 açık yol**. Tam depo sayısı değildir. Beş Foundation sınırı ve studies kalır.

### 6.10 A4 — Relation / control / composition envanteri

Başlangıç main **`3ac5da9b161ecc5f2a3529cdfb4d8ffd391a34dd`**, root tree **`1dc8365b9535bc4fdd82da99bde9de49bd400f26`**. [A4-RELATION-CONTROL-COMPOSITION-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-RELATION-CONTROL-COMPOSITION-INVENTORY.md) kapsamı; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-RELATION-CONTROL-COMPOSITION-INVENTORY.json) kesin 198 yolu taşır.

`05_relation-control-composition` **198 dosya** ve **1.293.969 API byte** ile envanterlidir. Kesilmemiş recursive Git tree ve yeniden kurulan doğrudan kök aynı `81e9db36f1b14d2248e99660350734c30d501d8d` kimliğini verdi; bir kök girişi eksiltme ve bir blob bozma kontrolü eşitliği bozdu. Yeni araştırma gövdesi okuması ve tarihsel betik çalıştırması **0**.

Birleşik kapsam **1.172 + önceki yayının 2 yeni bakım dosyası + 198 = 1.372 açık repository yolu**; Foundation **662 + 198 = 860 açık yol**. Tam depo sayısı değildir. Dört Foundation sınırı ve studies kalır.

### 6.11 A4 — Integration frontier review envanteri

Başlangıç main **`da49df7f09f84b01e9dddf4d04bcc5c03779a732`**, root tree **`f658edbab2308e150253250d8e99d0b3f2389e76`**. [A4-INTEGRATION-FRONTIER-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-INTEGRATION-FRONTIER-INVENTORY.md) kapsamı; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-INTEGRATION-FRONTIER-INVENTORY.json) kesin 18 yolu taşır.

`06_integration-frontier-review` **18 dosya** ve **58.726 API byte** ile envanterlidir. Kesilmemiş recursive Git tree ve yeniden kurulan doğrudan kök aynı `f34589cde45cd8d7fb8d93cdd4ec81d62a52781d` kimliğini verdi; bir kök girişi çıkarma ve bir blob bozma kontrolü eşitliği bozdu. Yeni araştırma gövdesi okuması ve tarihsel betik çalıştırması **0**.

Birleşik kapsam **1.372 + önceki yayının 2 yeni bakım dosyası + 18 = 1.392 açık repository yolu**; Foundation **860 + 18 = 878 açık yol**. Tam depo sayısı değildir. Üç Foundation sınırı ve studies kalır.

### 6.12 A4 — Selection dynamics integration review envanteri

Başlangıç main **`ccb8f2ecb36a243dcced2b1b203b8cfbe224872c`**, root tree **`be65636549f51fbd2667ee9fcbc7e6c58516d7a9`**. [A4-SELECTION-DYNAMICS-INVENTORY.md](maintenance/2026-09-29-research-installation-separation/A4-SELECTION-DYNAMICS-INVENTORY.md) kapsamı; [JSON envanteri](maintenance/2026-09-29-research-installation-separation/A4-SELECTION-DYNAMICS-INVENTORY.json) kesin 14 yolu taşır.

`07_selection-dynamics-integration-review` **14 dosya** ve **85.504 API byte** ile envanterlidir. Kesilmemiş recursive Git tree ve yeniden kurulan doğrudan kök aynı `c88b8399a330f56533c1ef1f452712e0cc2c72f2` kimliğini verdi; bir kök girişi çıkarma ve bir blob bozma kontrolü eşitliği bozdu. Yeni araştırma gövdesi okuması ve tarihsel betik çalıştırması **0**.

Birleşik kapsam **1.392 + önceki yayının 2 yeni bakım dosyası + 14 = 1.408 açık repository yolu**; Foundation **878 + 14 = 892 açık yol**. Tam depo sayısı değildir. İki Foundation sınırı ve studies kalır.

### 6.13 A4 — Foundation sufficiency/reuse envanteri

`08_foundation-sufficiency-reuse-review` **13/13 dosya** ile envanterlidir. Git kökü `dbdafeb7b08274073f103f61a90c2a0c9c318c3b` yeniden üretildi; eksiltme ve blob bozma kontrolleri hatayı yakaladı. Yeni araştırma gövdesi okuması ve betik çalıştırması **0**. Birleşik kapsam **1.423 repository yolu**, Foundation **905 yol**. Foundation'da yalnız history opak kalır; studies ayrıca açıktır.

### 6.14 A4 — Foundation history envanteri

`research/soul-foundations/history` **26/26 dosya** ile envanterlidir. Git kökü `151fb029cdc58085ee71f0f470efe89af712971f` yeniden üretildi; eksiltme kontrolü hatayı yakaladı. Birleşik kapsam **1.451 repository yolu**, Foundation **931 yol**. **Foundation yol envanteri tamamlandı.** Yeni araştırma gövdesi okuması **0**.

### 6.15 A4 — Studies ve yol envanteri kapanışı

`research/studies` **928/928 dosya** ile envanterlidir. Pinned snapshot birleşik yol kapsamı **2.381 dosya**; Foundation **931**, studies **928**. Artık opak araştırma alt ağacı yoktur. Bu yalnız yol/kimlik envanteri kapanışıdır; içerik/statü/bağlantı ve arşiv içi denetim açık kalır. Yeni araştırma gövdesi okuması ve betik çalıştırması **0**.

### 6.16 A4 — Yön/statü içerik taraması 01

[A4-DIRECTIONAL-SCAN-01](maintenance/2026-09-29-research-installation-separation/A4-DIRECTIONAL-SCAN-01.md), `Codex`, `DEVOS-001/002`, `P5`, `güncel/current`, `sıradaki/next` sorgularının ilk yüksek-riskli giriş kümesini ve disposition'larını taşır. Kök, development-os, soul-context ve EXP-006 girişleri eski yönü bugünkü kurulumdan önce açıkça ayırdığı için yeni kaynak düzeltmesi gerekmedi. Foundation, ECC ve kapanmış explorations içindeki kendi current/next dili araştırma statüsü olarak gerekçeli korunur.

Bu ilk arama turu repository-wide yokluk kanıtı değildir; sonuç limiti ve giriş-penceresi okuma sınırı görünür tutuldu. Kalan riskli eşleşmeler ile bağlantı ve archive/ZIP kontrolleri açıktır.

### 6.17 A4 — Yön/statü içerik taraması 02

[A4-DIRECTIONAL-SCAN-02](maintenance/2026-09-29-research-installation-separation/A4-DIRECTIONAL-SCAN-02.md), A2 dışındaki daraltılmış Codex/P5/eski hedef repo sorgularını ve doğrudan açılabilir EXP-006 P4/P5 girişlerini taşır. P4-01/P4-05/P5-01/CODEX_START dahil riskli doğrudan dosyalar zaten özgün gövdeden önce D030/tarihsel statü notu taşıyor. A2'nin current 41/41 sonucu yeniden açılmadı. Bu turda kaynak dosya değişikliği gerekmedi.

### 6.18 A4 — bağlantı ve arşiv içi kontrol 01

[A4-LINK-ARCHIVE-CHECK-01](maintenance/2026-09-29-research-installation-separation/A4-LINK-ARCHIVE-CHECK-01.md), 17 yüksek-riskli girişteki **182/182** göreli link yolunun güncel root tree'de bulunduğunu; güncel devos/plan, soul-system, tarihsel soul ve D030 hedeflerinin erişilebilir olduğunu kaydeder.

A3'teki doğrulanmış ZIP'in yerel byte kimliği yeniden eşleşti. 16 iç ZIP dahil 1.062 üye, 994 metin-benzeri dosya veri olarak tarandı; özgün tarihsel gövdelerde eski current/next/Codex/P5 dili beklendiği gibi vardır. Kaynaklar değiştirilmez; arşiv README ve SOURCE-IDENTITIES bu malzemenin uygulama kaynağı olmadığını ve eski başlangıç metinlerinin çalıştırılmamasını belirtir. A3'ün iki erişim açığı değişmez.

### 6.19 A4 — Giriş/durum yüzeyleri taraması 03

[A4-ENTRY-SURFACE-SCAN-03](maintenance/2026-09-29-research-installation-separation/A4-ENTRY-SURFACE-SCAN-03.md), A2/A4'te zaten sonuçlandırılan alanlar dışındaki **299 giriş/durum yüzeyinin ilk 100 satırını** eski-yön göstergeleri açısından doğrudan tarar. **37 dosyada** eşleşme çıktı; tamamı açık tarihsel ayrım, araştırma kapsam yasağı, araştırma-içi P1–P5/S00 kimlikleri veya kaynak/mekanizma adı olarak gerekçeli korundu. **Yeni kaynak düzeltmesi 0.**

Bu kapsam tam gövde taraması değildir. Daha aşağı satırlardaki başlık-dışı ifadeler ve 299 giriş yüzeyinin daha geniş göreli-link kümesi açık kalır.

### 6.20 A4 — Genişletilmiş giriş-yüzeyi link taraması 02

[A4-ENTRY-LINK-SCAN-02](maintenance/2026-09-29-research-installation-separation/A4-ENTRY-LINK-SCAN-02.md), lexicographic ilk **42/299 giriş/durum yüzeyinde 513/513 göreli Markdown linkinin çözüldüğünü** kaydeder. Kırık hedef bulunmadı. Bu kısmi sonuçtur; 257 yüzey açık kalır ve link varlığı hedef anlamını doğrulamaz.

### 6.21 A4 — Genişletilmiş giriş-yüzeyi link taraması 03

[A4-ENTRY-LINK-SCAN-03](maintenance/2026-09-29-research-installation-separation/A4-ENTRY-LINK-SCAN-03.md), aynı sabit snapshot ve parser kuralıyla **299/299 yüzeyde 1.799 göreli Markdown linkini** disposition eder. İlk 42 dosyadaki 513/513 sonucu yeniden üretildi; kalan 257 dosyada 1.286 link bulundu. Toplam **1.792 link mevcut snapshot yoluna doğrudan çözüldü**.

Tek istisna kümesi, Hermes'in `PREPARED_NOT_PUBLISHED` delivery payload'ındaki `repo-updates/STATE.md` dosyasındaki yedi hedef-konum göreli linktir. `publication_manifest.json`, bu staging dosyasının gelecekte package-root `STATE.md` konumuna kopyalanacağını açıkça eşler; bu nedenle linkler staging konumundan canlı navigation değildir. Payload hash'lerini ve tarihsel teslim kanıtını bozmamak için kaynak değiştirilmedi. **Actionable kırık link: 0.** Bu sonuç link hedefinin varlık/disposition denetimidir; hedef içeriğinin anlamca doğru veya güncel olduğunu tek başına kanıtlamaz.

### 6.22 A4 — Giriş penceresi dışı gövde taraması 04

[A4-ENTRY-BODY-SCAN-04](maintenance/2026-09-29-research-installation-separation/A4-ENTRY-BODY-SCAN-04.md), aynı 299 entry/state yüzeyinin **101. satır ve sonrasını** A4-ENTRY-SURFACE-SCAN-03'teki eski-yön göstergeleriyle doğrudan tarar. Yalnız **iki satır** eşleşti: `research/INDEX.md` içindeki genel target-repository continuity ilkesi ve ECC `INDEX.md` içindeki U19-D Codex/Git-helper test kaydı. İkisi de DevOS kurulum yönü değildir; kaynak değişikliği yapılmadı.

Supplemental GitHub code-search toplamları, ilk yön taramasındaki 50-sonuç sınırının gerçek olduğunu doğruladı; kapanış yokluk iddiasını bu aramaya dayandırmaz. Buna karşılık daha özgül tarihsel kimliklerin bütün dosya listeleri (DEVOS-001/002, soul-production, soul-development-os ailesi, P5-1.0.0, CODEX_START) tam döndü ve A2'de statülendirilen alanlar, maintenance/root açıklamaları, study/concepts araştırma kayıtları veya kapalı exploration kaynakları dışında yeni bir canlı kurulum otoritesi göstermedi.

### 6.23 A4 kapanışı

A4'ün amacı bütün araştırmayı yeniden okumak veya 928 study yaprağının bulgularını yeniden doğrulamak değildi. Kapanış; **yol kapsamı + yüksek-riskli doğrudan alanların A2 tam/daraltılmış okumaları + repository-wide risk aramaları + 299 entry/state yüzeyinin giriş penceresi ve kalan gövdesi + link disposition'ı + gerekli archive/ZIP taraması** birlikte değerlendirildiğinde, DevOS kurucusunu eski Codex/P5/DEVOS yönüne taşıyan yeni bir actionable kaynak sorunu kalmamasına dayanır.

Arama eşleşmesi yokluğu tek başına kanıt sayılmadı; package-local current/next dili ve kaynak/mekanizma adları araştırma anlamı olarak korundu. Okunmamış research leaf gövdeleri “yeniden doğrulanmış” sayılmaz. A3'ün iki erişim engeli kapanmamıştır ve A5 tesliminde açık sınır olarak taşınacaktır.

## 6.24 A5 — son karşılaştırma ve teslim

[A5-FINAL-DELIVERY](maintenance/2026-09-29-research-installation-separation/A5-FINAL-DELIVERY.md), başlangıç `8cd01e4` ile A4 kapanışını ve A5 router düzeltmelerini karşılaştırır. Final compare öncesi 141 yol: 58 added, 83 modified, 0 deleted, 0 renamed; yalnız kök README'de 12 satır eski yönlendirme metni değiştirilmişti. A5 final kaydıyla toplam değişen/eklenen yol 142 olur. Gerçek taşıma ve silme yoktur; `AGENT.md` / `agent/**` değiştirilmemiştir.

Yeni-okuyucu yürüyüşü, kök README'deki stale “tarama açık” ve arşiv README'deki stale “sıradaki iş A4” cümlelerini yakaladı; ikisi final statüye getirildi. A3 5/7 arşiv kapsamı ve iki erişim engeli son teslimde açık sınır olarak korunur.

## 6.25 1 Ekim — beş maddelik kapanış düzeltmesi

Başlangıç `59b8b8edda8e993cbc0a01980dea998d4e94ac73`. SOUL ve DevOS arşivi ve kimlik kaydı tamamlandı; S00–S12 sınırı korundu. Foundation STATE ve 08 DISCUSSION-HANDOFF başına D030’a kısa tarihli not eklendi, özgün gövdeler korundu. Baseline README başına 13 göreli linkin `8cd01e4` depo köküne göre olduğunu açıklayan snapshot notu eklendi; gövde korunur.

Kullanıcının aktardığı Claude salt-okuma denetimi ve tüm-repo otomatik `Codex / current / next / güncel / sıradaki` taraması [A5 §10](maintenance/2026-09-29-research-installation-separation/A5-FINAL-DELIVERY.md#10-1-ekim--beş-maddelik-kapanış-düzeltmesi) içinde kaynak statüsüyle kaydedildi. Bu tur bağımsız yeniden tarama veya 928 studies yaprağının yeniden okuması değildir. Bildirilen iki Foundation yönlendirmesi bu tur kapatıldı; baseline link bağlamı açıklandı.

## 7. Kapanış ve koşullu yeniden açılma

**Aktif bakım işi yok.** Kullanıcının beş kapanış düzeltmesi uygulanmıştır. A1/A2/A4/A5 ve kapanış düzeltmeleri tamamlandı; A3 6/7 aileyle kısmi kalır. Tek kalıcı açık sınır **P5 S00–S12 özgün paketinin erişilememesidir**; K00–K15 paketi bunun yerine geçmez.

Yeni özgün S kaynağı, kesin kaynak referansı veya gerçekten yeni erişim kapsamı gelirse yalnız bu arşiv kalemi yeniden açılır. Yeni somut erişim olmadan sonuçsuz aramalar tekrarlanmaz. 928 studies yaprağı yeniden okunmadı; kullanıcı tarafından aktarılan tüm-repo otomatik tarama teslim kaydında atıf olarak korunur.

Yeni oturum eski COORD/G0/G1 brief’inden, EXP-006 S00’ından, DEVOS-001/002 görevinden veya dış DevOS kurulumundan başlamaz. Bu bakımın güncel devam kaydı bu dosyadır; önceki tarihli denetimlerdeki “sonraki” ifadeleri kendi turlarına aittir. Kontrol katmanı değişmedi; başka depoya yazılmadı; dosya silinmedi veya taşınmadı.
