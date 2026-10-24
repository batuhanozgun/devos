# EXP-001 — Açık sorular ve yeniden kullanım eşikleri

**Bu dosya yürütme kuyruğu değildir.** Kaydetmek; araştırma başlatmak, yetki vermek veya mekanizma seçmek değildir. Güncel arşiv görevi STATE'tedir.

## O01 — Yaşayan katmanlı plan

SOUL, değişen C'ye bağlı olarak bütünü görünür tutan, uzmanlarca kademeli ayrıntılandırılan bir planı nasıl oluşturup sürdürmeli? Yakın dal ayrıntılanırken uzak iş, koşullu alternatif, aktif odak ve başka dala bırakılan not nasıl korunmalı?

Kaynak: [U016](../sources/conversation/USER-MESSAGES.md#u016), [U017](../sources/conversation/USER-MESSAGES.md#u017), [S016](../sources/conversation/assistant/S016.md), [S017](../sources/conversation/assistant/S017.md). Atlas I03/M05/M07/M15–17/M20 ve Q07 kısmi dayanak. WBS, rolling wave, HTN, CMMN ve koordinasyon birincil kaynakları mevcut Work defterinden geri çağrılabilir. Ürün araştırması daha sonra aranan işlevlere göre yapılabilir. Yeni araştırma bu arşivleme turunda başlatılmadı.

## O02 — C, koşul, yöntem ve plan geçişi

C keşfinden hangi durumda yeni iş, hangi durumda mevcut koşul, hangi durumda owner kararı, hangi durumda koşullu plan dalı çıkar? C sabitken sıranın değişmesiyle amacın değişmesi nasıl ayrılır? Alt çıktıların birleştirilmesi ve üst hedefin kabulü nasıl temsil edilir?

Kaynak: S003, S005, S017; [L02/L03/L14](LEARNINGS.md).

## O03 — İlk uzmanlık katılımı ve rolün hazır oluşu

Uzmanlığın gerektiğini anlayabilmek için zaten uzmanlık gerekiyorsa başlangıç sorumluluğu nasıl sağlanır? Rolün kalıcı sorumluluğu ile kısa ömürlü çağrı arasındaki bağ nasıl kurulur? Bir modelin rolü taşıyabildiğine hangi evidence yeterli olur?

Kaynak: U011/S011; Atlas Q01/Q06. Rol etiketi, tool erişimi ve authority birbirinin yerine geçmez.

## O04 — Değişiklik önerisinin ortak duruma kabulü

Öneriyi hazırlayan, inceleyen, kabul eden ve yazan sorumluluklar nasıl ayrılır? Eşzamanlı öneri, eski girdi sürümü, ret ve kısmi kabul nasıl ele alınır? Bu tur belirli bir transaction/store/lease sistemi seçmez.

Kaynak: S008/S009/S013; Atlas Q02/Q04.

## O05 — Etki izleme ve gerçekten görünür olan bağlam

Bir C değişikliğinin hangi çıktı iddiasını ve hangi işi etkilediği nasıl bulunur? Geçersizleşen sonuç kayda geçtiğinde devam eden aktör bu bilgiyi gördü mü, kullandı mı? Bütün projeyi yeniden yapmakla değişikliği kaçırmak arasındaki kapsam nasıl belirlenir?

Kaynak: S007 D-02 ve W-02 devir örneği; Atlas Q03/Q05. Anlatıcı tarafından gösterilmiş aktarım gerçek runtime kanıtı değildir.

## O06 — İnceleme, kabul ve kısmi etki

Hangi test hangi iddiayı gerçekten sınar? Güçlü bir ikinci rol ortak hataları nasıl dışlar? Araç hatasında gerçekleşmiş kısmi etki, tekrar deneme, telafi ve onarım nasıl ayrılır?

Kaynak: S007/S013; Atlas Q08/Q09. Atlas arayüzünün test edilmesi bu soru alanlarını doğrulamaz.

## O07 — Deneyim ve kaynak yönetimi

Deneyim ne zaman doğrulanmış, yeniden kullanılabilir bilgi olur? Kapsam, kaynak, tazelik ve unutma/değiştirme koşulları nasıl taşınır? Dış araştırma repository'sine başvurmakla yerel işletim kuralını değiştirmek nasıl ayrılır?

Kaynak: U008, U011 ve S008/S011; Atlas Q10/Q12. Uzak repo bağımlılığı veya otomatik kaynak güncellemesi benimsenmedi.

## O08 — Planın ve devamın canlılığı

Hazır işler arasından seçim, odak korunması, başka dal notunun doğru zamanda yeniden değerlendirilmesi ve kesintiden dönüş nasıl işletilir? Kullanıcının yazmamasını sonsuz yürütme yetkisi saymadan devam hangi olayla başlar?

Kaynak: U016/S016/S017; Atlas Q07/Q11.

## O09 — Gerçek sistem denemesi

Aynı çalışma anlayışı başka model/bağlam/uzun oturum/araç koşullarında hangi davranışı üretir? Bu deneme öğretici fakat kalıcı ajan takımı veya tam harness testi değildir. Gelecek değerlendirme tek güzel örnek yerine hata yolları, gereksiz iş, atlanan koşul, kaynak kullanımı, devir ve toplam kullanıcı yükünü inceleyebilir.

## Arşivlemeye ilişkin açık işler

Bunlar yukarıdaki araştırma sorularından ayrıdır: özgün büyük dosyaların remote payload olarak aktarılması, gerekirse ham platform export'u ile görünür aktarımın karşılaştırılması, tarihsel citation işaretlerinin kesin bağları erişilebildiğinde tamamlanması. Güncel durum [STATE](../STATE.md) ve [WORK-PLAN](../WORK-PLAN.md) içinde.
