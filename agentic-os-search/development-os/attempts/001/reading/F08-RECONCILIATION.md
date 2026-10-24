> **30 Eylül 2026 — tarihsel F08 karşı okuması ve tamlık düzeltmesi.** Aşağıdaki S07 eksik okuma düzeltmesi ve beş katkı korunur; özgün F08'in ilk tamlık beyanı bu ekle birlikte okunmalıdır. Son paragraftaki `01_verticals` görevi ve karşı okuma durumu eski denemeye aittir; sonraki yöntem değişikliği [COVERAGE](COVERAGE.md)'dadır. Bu ek bugünkü kurulum veya okuma kuyruğu değildir.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); Claude Code ve DevOS bu depoyu yalnız okur. Aşağıdaki kaynak kimlikleri özgün, öneksiz metinleri tanımlar. Geçmiş düzeltmeyi korumak yeni bir bağımsız doğrulama veya eski işi sürdürme yetkisi değildir.

---

# F08 — karşı okuma sonucu, eksik aralık ve katkı ekleri

**Tarih / aktör:** 24 Eylül 2026 / Research–ChatGPT.
**Güncel okuma yolu:** bu ek → [özgün F08](F08-FOUNDATION-FRAME.md). Özgün kaydın 20 katkısı korunur; bu ek onun tamlık beyanını ve S07 okuma defterini düzeltir. Aynı kaynağın ikinci bağımsız doğrulaması veya yeni mimari değildir.

## Alınan karşı okuma ve gerçek kapsam

Claude'un [C-005](https://github.com/batuhanozgun/soul-development-os3_claudecode/blob/9866feb1127313394a3d1bd50bfd4b862a91567f/coordination/devos-001/outbox/C-005.md) mesajı ve [F08-karsi-okuma.md](https://github.com/batuhanozgun/soul-development-os3_claudecode/blob/9866feb1127313394a3d1bd50bfd4b862a91567f/coordination/devos-001/reading/karsi-okuma/F08-karsi-okuma.md) tam okundu. Karşı okuma blob'u `5995056e8ad68744913e9f9857107601153ff85b`; incelediği F08 blob'u `f5d1edfb3f8f02d387717d0e1a9aa62380366b88`.

S01–S15 kimlikleri özgün F08 kaynak defteridir, kaynak ref'i `dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb`. Aynı konuşmada tam görülmüş kaynak gövdeleri yeniden kullanıldı. S07 CASE-AUDIT'in 85–son aralığı ayrıca canonical kaynaktan getirildi; dosya 95 satır ve 91–95 aralığında Cross-case assessment var.

**Düzeltme:** Önceki '1–90 ile dosya sonuna kadar / 13 dosyanın tamamı' beyanı doğru değildi. S07'nin son beş satırı önceki okumada yoktu; şimdi okundu. İlk kaydın tamlık ifadesi geri çekilir; 08'in 13 dosyasındaki gerekli aralıkların okunması bu tamamlamadan sonra kapanır. Kaynak anlamının bütün olası kullanımını eksiksiz çıkardığımız iddiası verilmez.

## E1–E4 karşılığı ve yeni katkılar

### F08-21 — Bilgi yeterliği, keşfedilebilirliği ve fiilen uygulanması ayrı
**Kaynak:** S01 Important correction; S03 Original research and later discussion; S14 §§2–3.
Soru-bankası tartışmasında üretim araştırması vardı, fakat assistant onu uygulamadan örneği tamamlandı saydı; kullanıcı üretim tarafını geri getirdi. Bu, 'hangi üretim soruları gerekli?' listesinin yanında ayrı bir kullanım başarısızlığı gözlemidir. Bilginin doğru olması, bulunması ve işe etki etmesi birbirinin yerine geçmez.
**Olası katkı:** kurulacak düzende araştırma biriktirme ile karar anında kullanma ayrı yükümlülükler olarak düşünülür; kullanıcı gizli eksik-bulucu yapılmaz. Kaynak bu olaya tek kök neden veya sınanmış teknik çözüm atamıyor. İlgili: F08-01/08/12. **E1 kabul edildi.**

### F08-22 — Çalışmanın kapanışı için ölçütü ve dönüş ürününü başta belirtmek
**Kaynak:** S05 §§3–4 ve §6; S06 §7.
08, yeni değerlendirmeden önce beş tamamlanma koşulu, açık başarısızlık koşulu ve iki dönüş ürününü belirlemişti: gerekçeli sınırlı tamamlanma veya onu engelleyen somut eksik. Yalnız dosya/yüzde bitirme ölçütü değildi; anlam ayrımları, rakip çerçeveler, kaynak erişimi ve kalan sorumluluklar birlikte değerlendirildi.
**Olası katkı:** büyük işin evreleri neden bittiğini ve hangi üst işe ne götürdüğünü gösterebilir. Bu araştırma pratiği örneğidir; aynı assistant'ın ölçüt/değerlendirmesi bağımsız doğrulama değildir ve bütün işe tek eşik dayatmaz. İlgili: F08-13/17/19. **E2 kabul edildi.**

### F08-23 — Kullanıcı sözünün kaydı ile yorumun ve yetkinin ayrılması
**Kaynak:** S01 Latest position; S05 §1; S14 §4; S15 Cold-entry recovery checks.
Kaynak kullanıcı sözünü alıntılar, ardından neyi desteklediğini ve neyi yetkilendirmediğini açıklar. Yön desteğini bilimsel iddia kabulüne veya uygulama iznine büyütmez; yaşanmış tartışmayı da yok saymaz.
**Olası katkı:** amaç, iş yetkisi ve karar dayanağı üretim boyunca taşınır; kullanıcıya tekrar tekrar aynı teknik sorular sorulmaz. OWNER benzeri taşıyıcı bir seçenek olabilir, kaynak zorunlu dosya adı seçmiyor. İlgili: F08-10/11/20. **E3 kabul edildi.**

### F08-24 — Devam kaydını, yeni okuyucunun cevaplaması gereken sorularla kontrol etmek
**Kaynak:** S14 §1; S15 Before the update / Cold-entry recovery checks / Limits.
08 sonrası tartışma kalıcı kayda işlenmeyince yeni giriş eski 'değerlendirme bekleniyor' noktasına dönüyordu. Düzeltmede, sıradaki iş, geçmiş yayın, kullanıcı düzeltmesi, kabul ve yetki sınırı gibi dokuz sorunun geri bulunabilmesi kontrol edildi.
**Olası katkı:** oturum devrinin ürünü sadece 'sonraki adım' değil, doğru amaç ve gerekçenin yeniden kurulabilmesidir. Bu örnek aynı oturumdaki manuel kontroldür; bağımsız yeni aktör davranışı diye sunulmaz. İlgili: F08-11/20. **E4 kabul edildi.**

### F08-25 — Bütünsel örnekleri farklı hata/açıklama aileleri olarak korumak
**Kaynak:** [S07, 91–95](https://github.com/batuhanozgun/agentic-os-search/blob/dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb/research/soul-foundations/08_foundation-sufficiency-reuse-review/CASE-AUDIT.md#L91-L95), bu tur yeni okunan bölüm.
C1/C4 kaynak ve kayıt başarısını büyütmeye; C2/C6 sabit amaç/tek ölçüt varsayımına; C3/C5 kapasite, envanter ve planı uçtan uca yapılabilirlik saymaya karşı farklı karşılaştırmalar sağlar. Vakalar geleceğin bütün alanlarını temsil eden örneklem veya ağacın tek en iyi olduğunun ispatı değildir.
**Olası katkı:** toplu değerlendirmede yalnız son görünür kusur değil, üretim sisteminin farklı çalışma durumları birlikte geri çağrılır. Örnekler hazır test paketi veya seçilmiş mimari değildir. İlgili: F08 §4 örnek tablosu ve F00-05.

F08-01'in üretim listesine S14 §2'deki revizyon ve yayımlama da dahildir. Aynı bölümdeki 'inceleme yapıldı ama ilgili hatayı kaçırdı' ve 'usul yeniden yazıldı ama kalıcı davranış etkisi gösterilmedi' örnekleri de F08-09/12 ile birlikte korunur.

## Kapanış sınırı

Bildirilen dört maddi eksik ve son kaynak aralığı işlendi. Özgün F08 tarihsel ilk çıkarım olarak değiştirilmedi; güncel COVERAGE bu eki önce okutuyor. Bu yeni ekin karşı aktörce yeniden okunması henüz teyitsiz; yeni sonsuz inceleme kuyruğu açılmaz. Research'ün sıradaki özgün kaynak okuması F00 sonrasında 01_verticals'tır.
