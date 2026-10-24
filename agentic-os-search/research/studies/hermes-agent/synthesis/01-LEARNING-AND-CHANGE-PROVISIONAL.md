# HERMES — Öğrenme ve değişim alt-sistemi: ilk geçici sentez

**2026-09-10 / PROVISIONAL NATIVE SUBSYSTEM MODEL.** Kaynak pin `c4a5deeffa959f8ebc891e02c5bcf767aff1dd2a`. Bu model bütün HERMES'in nihai açıklaması, bağımsız güvenlik denetimi, öğrenme kalitesi verdict'i veya SOUL mimarisi değildir. Mevcut U01 mekanizma notlarından türetilir; yeni saha deneyi sayılmaz.

## 1. Modelin merkezinde ne var?

HERMES'in incelenmiş öğrenme/değişim kesiti, tek bir 'öğren' işlemi değil, **konuşma kanıtından öneri üretme, öneriyi bir değişikliğe dönüştürme, kalıcı bilgiyle oturum görünümünü bağlama ve kütüphaneyi sürdürme** yollarından oluşur. Bu yollar aynı agent/store/profile kimliğini her aşamada aynı biçimde kullanmaz.

Native bileşenler: background review fork; curator automatic maintenance ve optional model consolidation; skill/memory mutators ve write-approval queue; CLI/gateway pending handlers; MemoryStore; session stored/cached system prompt; skill usage/lifecycle, ledger ve cron referansları. İsimler HERMES'in incelenmiş kaynaklarından gelir; dört Foundation alanı bu modele şablon yapılmamıştır.

## 2. Mevcut kanıtın taşıdığı geçişler

| Geçiş | HERMES'teki mekanizma | Kanıt / açık sınır |
|---|---|---|
| Konuşmadan review girdisine | Snapshot/digest ve cache-parity fork; farklı auxiliary model daha farklı görünüm alabilir. | [02](../notes/02-BACKGROUND-LEARNING.md): kaynak. Tüm trigger/quality yolları açık. |
| Review girdisinden değişiklik önerisine | Ayrı review agent, origin, advertised schema ve ayrı izin kümesi; bazı store/state paylaşımı. | [02](../notes/02-BACKGROUND-LEARNING.md), [06](../notes/06-CALLER-DISPATCH-AND-CONTEXT-TRANSFER.md), [09](../notes/09-WORKER-POLICY-EXECUTION-BOUNDARY.md), [10](../notes/10-REVIEW-ADMISSION-AND-MIDDLEWARE-FAILURES.md). Full worker yetkisi Q26 açık. |
| Öneriden doğrudan yazıya veya bekleyen kayda | Config/caller'a bağlı approval gate, payload/origin/summary; memory ve skill replay. | [04](../notes/04-SKILL-WRITE-TRANSACTION-AND-APPROVAL.md), [07](../notes/07-MEMORY-STORE-AND-PENDING-REPLAY.md), [08](../notes/08-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md), [11](../notes/11-MEMORY-STATE-AND-PENDING-LIFECYCLE.md). Bileşen kaynak/koşu; tüm caller eşdeğerliği değil. |
| Kullanıcı komutundan pending uygulamasına | CLI live/fresh store; gateway fresh store; ingress, canonical command policy ve runtime home ayrı. | [12](../notes/12-UI-PROFILE-AND-APPROVAL-CALLERS.md), [13](../notes/13-PENDING-CALLER-EVIDENCE-RECONCILIATION.md), [14](../notes/14-AP-DELIVERY-RECONCILIATION.md). Kaynak trace + ayrı policy koşuları; actual UI yürütmesi değil. |
| Apply'den disk ve canlı duruma | MemoryStore ve mutator, dosya işlemi, hata ve pending cleanup. | [11/M2](../notes/11-MEMORY-STATE-AND-PENDING-LIFECYCLE.md): normal/arıza/silme/cleanup sınırlı kanıt. Bir başarı metni bütün durumları tek commit yapmaz. |
| Diskten oturum mesajına | Frozen memory block, prompt build; alternatif olarak uyumlu stored prompt restore. | **[15/M4](../notes/15-MEMORY-PROMPT-RESTORE-BOUNDARIES.md)**: exact memory modülleri + selected restore/invalidation koşusu. Full builder/DB/caller değil. |
| Oturum mesajından son isteğe ve kullanımına | Turn context → iteration/request assembly → provider aşamaları. | M4 ana döngü source bağı; phase gövdeleri/cache/compression/alternatif runtime ve actual prepared request **AÇIK**. Modelin doğru kullanımı ölçülmedi. |
| Skill kütüphanesinden bakım/birleştirmeye | Yaş/kullanım/pin/cron temelli lifecycle; optional LLM consolidation ayrı yol. | [03](../notes/03-SKILL-CURATION.md): statik mekanizma. Otomatik arşivleme ile LLM guard yolu aynı varsayılmaz. |
| Değişiklikten rapor, geri alma ve görev sürekliliğine | Snapshot, lifecycle/ledger ve rapor içinden cron reference rewrite bağlantıları. | [03](../notes/03-SKILL-CURATION.md), [08](../notes/08-APPROVAL-ROUNDTRIP-AND-ROLLBACK-BOUNDARIES.md). Dosya rollback'i bütün yan kayıtlar/sync/reuse için garanti değil; önemli köprüler açık. |

Bu tablo bütünlüğü iddia etmez: bir satırın source-backed olması yanındaki açık kenarı tamamlamaz. A/SA/AP aynı modülün örtüşen koşullarıdır; üç bağımsız doğrulama olarak ağırlıklandırılmaz.

## 3. Uçtan uca açıklama: bir ders adayının başına ne gelir?

Bir konuşma bittiğinde review, o konuşmanın belirli bir temsilinden tekrar kullanılabilir bir memory/skill değişikliği önerebilir. Girdi seçimi zaten ilk dönüşümdür: farklı modeller aynı ayrıntılı kanıtı görmeyebilir. Review'un ayrı örnek olması bütün depoların veya etki yetkisinin bağımsız olduğu anlamına gelmez.

Öneri yazma yoluna geldiğinde origin/ownership/read-before-write ve approval kapıları devreye girebilir. Bu kontrollerin nesneleri farklıdır: path'in okunmuş olması içerik sürümüne bağlı onay değildir; bir command ailesine erişim kayıt başına sahiplik değildir; gate'in kapalı olması bütün üst yetkilendirmelerin kapalı olması değildir. Bunlar yalnız terminoloji değil, kaynakta farklı alan/çağrı/karar noktalarıdır.

Yazı uygulandığında dosya, canlı store, bekleyen kayıt ve hata raporu ayrı değişebilir. Memory deneyleri hem çalışan korumaları hem kısmi sonuçları taşır. Kullanıcının 'onaylandı' mesajı alması, pending dosyasının temizlendiği veya tüm canlı görünümlerin yenilendiği anlamına otomatik gelmez.

Sonraki kullanıma geçişte yeni bir nesne sınırı daha vardır: store'un frozen block'u ve oturumun tam sistem mesajı. M4, fresh store yeni bilgiyi biçimleyebilse bile uyumlu stored prompt seçilebildiğini sınırlı bileşimde gösterdi. Yeniden build edilecek yollar da vardır. Gerçek UI akışında hangi geçişin tetiklendiği, ne zaman kalıcı mesajın değiştiği ve son request'in ne taşıdığı henüz bütünüyle bilinmez.

Skill tarafında buna ek olarak kullanım/yaş politikası, arşivleme, optional consolidation, güncelleme bastırması ve görev referansları devrededir. Dolayısıyla 'öğrenme' yalnız yeni dosya yazma değil; erişilebilirliği ve sonraki işlerin referanslarını sürdürme problemidir. İncelenen kullanım sayıları, öğrenilen dersin doğruluğunu veya gelecekteki başarıyı ölçmez.

## 4. Modelin anlamlı sınırları

**Bilgi ömrü ile oturum görünümü farklıdır.** Bir bilginin kalıcı dosyada bulunması, belirli bir turun onu taşıdığı anlamına gelmez. Silme de yalnız disk değil, türetilmiş görünümler bakımından ayrıca sorulur. Bu, HERMES'in her tur eski bilgi gönderdiği iddiası değildir.

**Kontrolün yerini ve nesnesini birlikte belirtmek gerekir.** Şema doğrulama araç adını, worker policy çağrı iznini, gateway admission kullanıcı kabulünü, command gate komut ailesini denetler. Bunların biri diğerinin otomatik telafisi değildir; gerçek path gerektiğinde takip edilir. Q26 tam-runtime sorusunun açık olması bütün incelemeyi hükümsüz kılmaz, ama bütün yetki güvenliği sonucunu engeller.

**Geri alma kapsamı, değiştirilmiş durum kümesine göre sorulur.** Dosya snapshot'ını geri koymak ledger/sync/cache/cron ve başka yazarların etkilerini otomatik geri almaz. Kaynakta bu yüzeylerin bağlantıları vardır; tam atomiklik veya kayıpsızlık doğrulanmadı.

**Öğrenme faydası halen ayrı bir son kenardır.** Değişiklik yapılması, sonra kullanılması ve daha iyi sonuç üretmesi üç farklı kanıt gerektirir. Henüz ölçmediğimiz kaliteyi sistem bileşenlerinin varlığından çıkarmıyoruz.

## 5. En güçlü karşı okuma

Bu model bir kalıcı yazı yolunu ayrıntılı görüp HERMES'i bundan ibaret sanma riski taşır. Genel work/session çekirdeği, tool/provider/backend/delegation, gateway/scheduler, diğer arayüzler ve install/eval yaşam döngüsü yeterince geniş incelenmemiştir. Bunlardan biri farklı bir execution/visibility mekanizması getirirse model değişmelidir.

Diğer güçlü alternatif: gerçek compression/eviction/restore caller'ı, selected M4 deneyindeki eski-DB yolunu kullanılmadan önce telafi edebilir. Bu olasılık korunur. M4/V04'ü gerçek compression bug'ı veya sürekli bayatlık olarak yorumlamak modelin kendi kanıt sınırını ihlal eder.

Daha geniş audit/ownership kaydı başka yüzeylerde bulunabilir. Ortak pending kaydında ayrı approved_by alanını görmemek sistem çapında denetim izi yokluğu değildir. Benzer biçimde chosen tests'te kalite ölçmemek repository'nin hiçbir yerinde eval bulunmadığını göstermez.

## 6. Bundan sonraki araştırmayı nasıl yönlendirecek?

İlk aktif iş, genel turn/context/session çekirdeğiyle birlikte kaynak-topolojiyi genişletmek: bilinen ailelerin alt ağaçlarını ve yük taşıyan geçişlerini seçici olarak haritalamak. İlk route M4-S03'ün gerçek loop'undan turn_context/request/compression ve gateway cache yaşam döngüsüne gider; eksik görünürlük bağı bu geniş modelin içinde kapanır veya koşullu kalır.

Sonra ledger/backup/restore/sync ve skill yeniden yükleme/curator report/cron köprüleri hangi açıklamayı değiştirdiklerine göre seçilir. Diğer F01–F12 aileleri yalnız 'ileride' etiketiyle belirsiz bırakılmayacak; envanter/kanıt/eksik geçiş ayrımı tutulacak. Aynı dar onay testlerini çoğaltmak yerini bu kapsam karşı okumasına bırakır.

Bu sentez ilk üst katmandır, nihai CORE değildir. Yeni kanıtla bölünebilir/değişebilir; source→not→sentez ilişkileri korunur. Foundation'a bir düğüm veya Development OS'ye bir dependency önermez.
