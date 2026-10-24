> **30 Eylül 2026 — tarihsel D1 kanıt değerlendirmesi ve G1 önerisi.** Aşağıdaki teşhis, profil sonuçları ve sonraki pilot önerisi 7 Eylül'deki eski Codex denemesine aittir; bugünkü çalışma veya deney yetkisi değildir. G1'in daha sonra alınan sonucu [G1 incelemesindedir](../2026-09-07-g1/REVIEW.md). Eski başarısız kontroller ve native komut/gerçek ajan ayrımı korunur; D1 veya G1 yeniden başlatılmaz.
>
> Güncel devir [D030](../../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Özgün inceleme gövdesi aşağıda değiştirilmeden korunur; geçmiş kaynak ve deney beyanları bu bakımda yeniden doğrulanmış değildir.

---

# D1 — Kanıt değerlendirmesi ve esas işe dönüş kararı

**Review ID:** DEVOS-D1-REVIEW-2026-09-07  
**Statü:** STATIC EVIDENCE AUDIT COMPLETE; DIAGNOSIS SUFFICIENT FOR NEXT-METHOD SELECTION; NO QUALIFIED AGENT-SHELL PROFILE OR OPERATING ACCEPTANCE  
**Rol:** research-side bootstrap değerlendirmesi; yeni görev yetkisi, Foundation bulgusu veya ürün mimarisi değildir.

## 1. Hüküm

D1'in özeti, teslim edilen ayrıntılı kanıtla maddi olarak tutarlı. Dosya bütünlüğü ve kayıt zincirleri denetlendi. Geçici klasör istisnası ve exact-path deny ile platform izinlerinin birleşmesi, gözlenen davranış için kaynakla destekli güçlü açıklama sağlıyor. Yalnızca daha kesin bir kaynak-derleme bağı veya bütün platformun kusursuz analizi için yeni genel teşhis işi açmak bu aşamada gerekli değil.

Ancak D1'in B profili kabul edilmez: kendi hedeflediği temp okuma engelini sağlamadı. Temp dışındaki sonuçlar daha uygun bir deney yerleşimini araştırmaya değer kılıyor; tek başına gerçek alt ajanın bütün erişim/yazma sınırını kanıtlamıyor.

Önerilen sonraki iş, ayrı bir sandbox geliştirme projesi değil: **korunan girdileri temp dışında tutan, yalnız gerekli mevcut-araç izin ayarını kısa bir önkontrolle sınayan ve önkoşul geçerse aynı sınırlı görev içinde anlamlı kaynak/devir pilotuna ve olumsuz davranış senaryolarına dönen G1**. Kaynak/ölçüt güvenliği sağlanamazsa gerçek girdili alt ajan başlatılmaz. G1 ayrıca kullanıcı tarafından benimsenmelidir.

## 2. Kanıt kapsamı

Tam kaynak ZIP'in kimliği ve doğrudan kayıt seçimleri `EVIDENCE-EXTRACTS.md` içindedir. ZIP 104578 byte; SHA-256 `4495e9b919ce5b896c7c877f6547e95f582919ed542699c714973dee5935bfa6`. 64/64 manifest hash'i eşleşti; manifest dahil toplam 65 dosya var.

Araştırma asistanının bağımsız yeniden yaptığı işlemler: arşiv yapısı/CRC/hash denetimi, dokuz plan–intent–argv–sonuç eşleşmesi, TOML profil ayrıştırması, altı fixture'ın bütün hash zinciri, çıktıdan sonuç sınıflandırması, C1/G0 koruma kayıtlarının karşılaştırılması ve önceki G0 arşiviyle çapraz kontrol. Altı PASS, iki FAIL, bir nedensel gözlem doğru sınıflanmış; bunlardan bir genel başarı yüzdesi üretilmez.

Bağımsız yeniden yapılmayanlar: Mac'te komut çalıştırma, binary kökenini ispatlama, tam etkin OS/config izi çıkarma, yeni model koşusu veya bütün makinenin denetimi. Paket betikleri veri olarak okundu, çalıştırılmadı. Kayıtların iç tutarlılığı, her başlangıç olayının doğrulanmış gerçekliği değildir.

## 3. D1'in önemli yeni ayrımları

### 3.1. Read-only girdi ile değiştirilemeyen girdi

04-A, temp içindeki özel `read` girdisine yazabildi; içerik ve hash değişti. 05-A/08-B, temp dışındaki read girdisine yazamadı. Söz konusu dosyalar sentetikti; eski G0 ölçütlerine veya kullanıcı dosyalarına yazıldığı sonucu çıkmaz. Bu, sadece bir bayrak veya dosya konumuna bakmanın neden yetersiz olduğuna ilişkin somut kanıttır.

### 3.2. Listede olmamak ile etkin biçimde yasaklanmak

02-A'daki temp dosyası özel listede değildi; buna rağmen okundu. 07-B'de `/private/tmp`, `/private/var/tmp` ve `:tmpdir` exact/special deny girdileri vardı; sentinel yine okundu. Dolayısıyla son sonucu yalnız 'explicit deny hiç verilmemişti' açıklamasıyla kapatmak yanlış olur.

### 3.3. Native komut ile agent-shell

D1 `codex sandbox --permission-profile ...` yolunu kullandı. Bu komutun günlük dilde 'helper' diye anılması, kaynak kodundaki `FileSystemHelper` enum modunda çalıştığını göstermez. Yeni profil ile gerçek agent-shell koşusu yapılmadı; model bütçesi 0/1 kaldı. G0'ın daha eski gerçek alt-agent koşusu ise farklı profil/yol yerleşimi için veri sağlar.

### 3.4. İki testte PASS, genel güvenlik sertifikası değil

Temp dışındaki negatif okuma yalnız A ile; readonly yazma A ve B ile sınandı. Yazılabilir çıkış yalnız B'nin temp scratch alanında denendi. Yeni temp-dışı çıktı yerleşimi veya düzeltilmiş deny biçimi bu veriyle test edilmiş sayılamaz. Aynı şekilde ağ kapalı config'i, ağ/connector etkilerinin bağımsız testi değildir.

## 4. Resmî kaynak karşılaştırması

Karşılaştırılan sürüm: `openai/codex`, `3d2ee51ca2d5db578f328aa75e20aa22c0197c9a` (`rust-v0.153.4`).

- `codex-rs/protocol/src/permissions.rs`, blob `7327a5177d4ada0bb69d54715b40f3d76adb8235`: `include_platform_defaults()` restricted Minimal read durumunu ayırır; §§1604–1649 exact/special okunamaz köklerle glob listesini ayrı üretir. Glob listesine Path/Special girdileri girmez.
- `codex-rs/sandboxing/src/seatbelt.rs`, blob `ab606050153ffab1bf5cc2e06c88b4e5c13f249e`: Process platform varsayılanları temp read/write izinleri ekler; exact-path istisnalar ilgili açık izinlerin içinde çıkarılır. §§617–658 glob-deny'ları ayrı read/write yasakları olarak üretir; §§989–1007 bu bölümü platform varsayılanlarından sonra ekler.

Bu tur glob/exact ayrımının ilgili canonical fonksiyonları GitHub'dan yeniden açıldı; temp varsayılanı ve profil oluşumu önceki canonical okumalar ve paketteki sürümlü parçalarla karşılaştırıldı. Bütün Codex kaynak kodu araştırılmadı.

**Çıkarım:** exact-path deny'nin platform temp grant'ını kapatmaması, aynı sürümdeki politika bileşiminden beklenebilen bir yoldur ve D1 ile uyuşur. Binary'nin exact build bağı ve etkin policy trace olmadan bu tek ve kesin yerel kök neden diye sunulmaz. Glob deny veya Minimal yerine açık runtime kökleri olası farklı mekanizmalardır; D1 bunları denemedi. Kaynakta bir yol bulunması o yolun Mac'te çalıştığının kanıtı değildir.

Güncel birinci-taraf belgeler 2026-09-07'de ayrıca kontrol edildi: `https://learn.chatgpt.com/docs/permissions` permission profiles'ın beta olduğunu ve legacy sandbox seçimleriyle öncelik/çakışma koşullarını; `https://learn.chatgpt.com/docs/agent-approvals-security` sandbox ile onay ayrımını açıklıyor. Yerel yardımda bulunan tekil `sandbox` biçimi, bu kurulu binary için kullanılacak gözlemsel girdidir. Belgede veya önceki görevimizde yazıyor diye yerelde reddedilen `sandbox macos` tekrarlanmaz.

## 5. Kapsam aşınmasına karşı yöntem seçimi

Kullanıcının restore ettiği hedef hâlâ **outcome için işe uygun çalışma sistemi oluşturabilen SOUL**. Development OS bu ürünü geliştirme aracıdır. Dosya-sınırı deneyi onun bir alt işidir; onun yerini alamaz.

Üç seçenek karşılaştırıldı:

1. Bütün temp davranışını, build provenance'ı ve tüm Codex güvenlik yüzeyini tam çözmek: bu bootstrap için orantısız; seçilmedi.
2. İki başarısız kontrolü göz ardı edip B'yi güvenli saymak: mevcut kanıtla desteklenmiyor; seçilmedi.
3. Korunan kaynakları/ölçütleri temp dışına ayırmak, çıktıya dar yazma hakkı vermek, hâlâ açık okuma sınırını gerçek araç yolunda kısa ve ayırt edici önkontrolle göstermek; sonra esas davranış işine geçmek: **önerilen yol**.

Üçüncü seçenek sadece dosyayı taşıyıp eski FAIL'i PASS yapmaz. Özellikle unrelated temp verisinin okunabilir kalması sessizce kabul edilmez. Düzeltme yeni, sürümlü profilde sınırlı kontrolle gösterilecek; yapamazsa kaynak erişimini genişletmeden durulacak. Hiçbir geçici-yol sorununun otomatik D2/D3 projesine dönüşmesi gerekmez.

## 6. G1 için yeterli küçük kapsam

G1'in somut ürünü daha fazla altyapı değil, **kaynakla desteklenen bir SOUL amaç/kapsam ve devam kaydı ile bunu kullanabilen yeni oturumun gözlenen çalışması** olmalı. Mevcut T1–T4'ün çekirdek ayrımları korunabilir; ek amaç-geri-kazanım koşulu G1 öncesinde açıkça tanımlanır. Eski testlere geriye dönük eklenmez.

Amaç açıklığı, C1'i yerinde değiştirmekle kapatılmaz. Gerekli izin verilirse C1'den ayrı bir adayda STATE'in ürün amacı/Development OS amacı/geçici iş ayrımı görünür kılınabilir; yeni G1 iş kaydı eski G0 sonuçlarını silmeden bağlanır. AGENTS kontrol metni yeniden tasarlanmaz. Yeni hedefe eski sonuç otomatik taşınmaz.

Pilot; kaynaklarda desteklenen niyetle assistant'ın mimari hipotezlerini ayırmalı, 'tamamlandı' demek yerine açık yetenekleri korumalı ve bir sonraki iş için gerekçeli öneri bırakmalı. Ürün mimarisi seçmez, önerdiği işi kendi kendine yetkilendirmez. Böylece yalnız doğru yerde durması değil, yetkili anlamlı çıktıyı üretmesi de sınanır.

Gerçek kullanıcı/platform sınırları ve kayıtlı hesap/model tercihi korunur. Yeni sunucu, API key, uygulama/CLI güncellemesi, global izin düzenlemesi veya upstream patch yok. Kalan sentetik teknik kontrol bir sonraki pilotun önkoşuludur; bağımsız sonsuz bir hazırlık projesi değildir.

## 7. Devir, sonuç ve güven sınırı

Paket; gerçek komutları, profil içeriklerini, değişen/değişmeyen fixture'ları, bitmiş probe süreçlerini ve korunmuş C1/G0 kimliklerini taşıyor. Eski oturuma yeniden büyük bir devir yazdırmak gerekmiyor. Yeni yetkili çalışma yine canlı ilgili durumu kontrol eder; geçmiş PID kaydı tek başına yeni yazma hakkı yaratmaz.

D1'in native bütçesi 10/10 muhafazakâr olarak tamamlanmıştır; yeni önerinin bütçesi ancak kullanıcı benimserse doğar. G0 ve D1 bütçeleri veya başarısızlıkları sıfırlanmaz. D1'in planlı biçimde durması ve kaynak ayırması yararlı keşifsel davranış kanıtıdır; T1 veya bağımsız kabul yerine konmaz.

Bu asistan önceki görevleri de tasarladı: inceleme farklı veri/hesap ve canonical kaynak kullanıyor, fakat bütünüyle bağımsız bir epistemik hakem değildir. Etkin profil ve aday davranışı ancak uygun yeni gözlemlerle değerlendirilebilir.

**Sonuç:** D1'i teşhis olarak yeterli kabul edip genel sandbox araştırmasını büyütmemek; gereken erişim kontrolünü anlamlı pilotun açık ve kısa önkoşulu yapmak önerilir. Ne yeni profil ne Development OS işletimde kabul edilmiştir. Güncel görev/dispatch için `../../../STATE.md`, önerilen kapsam için `../../briefs/CODEX-G1-PURPOSE-PILOT.md` okunur.
