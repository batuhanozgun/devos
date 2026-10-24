# U13-B — Başlatma reddi, onay isteği ve yerel çalışma yeri

**2026-09-13 / MANUAL SOURCE-SELECTION DIAGNOSTIC.** [A araştırması](RESEARCH.md), [kaynaklar](SOURCES.md), [önceden yayımlanmış SPEC](SPEC.md), [MANIFEST](MANIFEST.json), [derived summary](RESULT-SUMMARY.json), [tam ham arşiv](diagnostic-evidence.tar.xz). Tam HERMES uygulaması veya tam orijinal modül koşusu değildir.

## 1. Neyin gerçekten çalıştırıldığı

A ve SPEC, **2ef205a9bf13d166c15a630e4320dd73eb190fb2** ile main'e bağlandı. Actual main/ref, A metni1–44+45–EOF, SOURCES, SPEC ve STATE tam geri okunduktan sonra B başladı. SPEC blob'u **ca736ff806d10e940b832b176a045401aeb301ad** değişmedi.

Üç upstream dosyadan sekiz işlevin gövdesi connector metninden manuel seçki olarak materyalize edildi. S04 notification release/submit/dispatch, S05 admit/followup/run_prompt_submit ve S01 complete_event/_event_delivery helper'larıdır. Source metadata kendi dosyalarında ve NOTICE'da bulunur. **Tam parent dosyaların byte/AST sadakati doğrulanmadı.** Seçkilerin hash eşleşmesi yalnız gerçekten çalıştırılan metni sabitler; whole-parent fidelity borcunu kapatmaz.

Gerçek Python control flow, dict/list, kilitler ve işlev çağrıları kullanıldı. Active-session slot ve delivery claim sonuçları kontrollü karşılıklardır. Thread constructor/start bir gözlemciyle değiştirildi: nested model worker gövdesi metinde korunur ama hiç çalıştırılmaz. Ack callback'i yalnız bir sayaçtır; gerçek SQL veya kalıcı delivered row yoktur. Başlangıç running=True, A'da görülen gerçek caller'ın önkoşuludur; `_notif_handle_event` bu deneyde çalıştırılmış değildir.

Ölçütler ve INPUTS koşudan önce sabitlendi; PRE-RUN-IDENTITY zamanlı kaynak/input/probe hash'lerini taşır. Bir kayıtlı invocation, **2026-09-13T04:01:40.644076+00:00–04:01:40.658275+00:00**, Python3.13.5/Linux. Öncesinde yalnız syntax compile yapıldı; başarısız eski davranış koşusu yoktur. Tam sonuç SHA256 **20e39d3c07c6d61a2e5e3dea7344baf62af52b6ffd6d9f59911ab1cce93e93f1**.

## 2. Sonuçlar

| Vaka | Seçki üzerinde ölçülen | Yorum |
|---|---|---|
| D01 normal | scheduling spy1, ack-request1, submit=True | Normal bağlantı mevcut; bu modelin çalıştığı değil schedule isteğinin gözlendiği demek |
| D02 aktif-session hakkı reddi | scheduling0, submit=False, ack-request1 | Alt ret exception olmadığı için üst caller ack yoluna girdi |
| D03 kapanan session | scheduling0, submit=False, ack-request1 | Aynı sonuca ayrı gerçek erken-ret branch'iyle ulaşıldı |
| D04 admission sonrası live session replacement | constructor1 fakat scheduling0, submit=False, ack-request1 | Son kimlik guard'ı çalıştı; ret üst makbuza taşınmadı. Replacement kontrollü, gerçek yarış değil |
| D05 delivery claim None | submit0, scheduling0, ack0; running=True kaldı | Bu selected seam'de caller'ın aldığı yer serbest bırakılmadı; whole-product deadlock kanıtı değil |
| D06 submit exception | ack0, release1, running=False | Exception telafisi var; no-exception False ile aynı davranış değil |
| D07 postturn followup reddi | scheduling0, submit=False, on_done1/on_error0, ack-request1 | İkinci gerçek caller helper'ı da bool'u tüketmedi; callback fixture, bütün postturn loop değil |
| D08 interim empty token | scheduling1, complete wrapper1, durable-ack callback0 | Boş-token helper, early notice'ın final delivery ack'ini tüketmesini önledi |

**D02/D03/D04/D07, SPEC'in I1 şartını seçki sınırında ihlal etti; D05, I2 yer bırakma şartını ihlal etti.** Beklenen source izlerinin karşılanması bu ihlalleri PASS'a dönüştürmez. Burada ürün başarı puanı yoktur. D01/D06/D08 karşı durumları, testin yalnız hata üretecek biçimde kurulduğu yanlış izlenimini önler.

## 3. Hata-duyarlılığı ve nedensel sınır

N01 yalnız test kopyasında `_notif_submit` False dönüşünü açık refusal/exception'a çevirir: D02'nin schedule0 durumunda ack0/release1 oluştu; I1 sinyali değişti. N02 yalnız test kopyasında claim None dalında local release ekler: D05 running=False oldu. Korunan seçkiler veya upstream değiştirilmedi. Bu iki kontrol oracle'ın ilgili branch değişimini ayırt edebildiğini gösterir; yeterli ürün düzeltmesini, crash güvenliğini veya bağımsız replication'ı kanıtlamaz.

Yakın mekanizma yalnız “hata döndü” değildir: alt katman **False** ile scheduling reddini anlatırken üst katman yalnız **exception** yolunu başarısızlık sayıyor. İkinci sınır, yerel running sahipliğinin durable claim'den önce alınması ve claim None dalında release edilmeyişidir. Gerçek kullanımda bunun zarar oluşturması için ilgili ret/yarışın gerçekten oluşması, ack'in DB'ye yazılması ve başka telafinin yeterli olmaması gerekir. Bu downstream koşullar burada ölçülmedi; veri kaybı veya süresiz takılma gözlemi iddiası yoktur.

## 4. Kaynağa karşı ikinci okuma ve güçlü karşı örnek

Koşudan sonra S04'ün113–247 ve385–430, S05'in90–149 ve738–862 aralıkları doğrudan tekrar açıldı; ilgili branch, release, bool ve schedule sırası seçkilerle karşı okundu. Bu aynı araştırmacının second pass'idir; whole-file hash veya bağımsız doğrulama değildir. Yeni specimen veya kriter değişikliği yapılmadı. License tam metni yeniden okunup yerel Git blob'u **75410e73319c72cd3e991a501c5455eb78f38375** ile eşleştirildi; bu match yalnız lisansa aittir.

**Karşı örnek:** aynı S04 dosyasındaki `_maybe_fire_tui_heartbeat_tick`, `_run_prompt_submit` dönüşünü bool olarak alır; başlatılmadıysa local yeri bırakıp `mgr.abandon_fire()` çağırır. Bu source branch'i yeni çalıştırılmadı ama genellemeyi sınırlar: “HERMES bütün sentetik devam retlerini yok sayıyor” doğru değildir. U06'nın messaging gateway heartbeat status/resume açıklamasına veya eski restart borçlarına yeni product-wide verdict verilmez; host ve sürüm kapsamı ayrı kalır.

## 5. Transfer, kullanma ve devam

11 regular dosyalı ham arşiv; üç selected source, lisans, notice, prereg input/hash kaydı, harness, tam RESULT ve stdout/stderr içerir. Arşiv yeniden açılıp bütün üyeler yerel dosyalarla byte düzeyinde eşleştirildi. Arşiv Git blob'u **798d00149d800ad52fb604a36dca70e1b384e995**, GitHub create_blob dönüşüyle eşleşti. Bu içerik kimliği henüz main yayın makbuzunun yerine geçmez.

Yeni SQLite/SessionDB/model/provider/credential, gerçek TUI/gateway, OS crash, ağ veya upstream test suite çalıştırması yok. A source sonuçları, B seçki gözlemi, ham paket aktarımı ve final publication ayrı statülerdir. Exact iddia için SPEC→MANIFEST→archive source/INPUTS/probe/full RESULT/log yolu izlenir; RESULT-SUMMARY yalnız derived view'dur.

B main'e yazılıp geri okunduktan sonra **kapsam dengesi değerlendirmesi** gelir. Q57 normal CLI/TUI consumer oku kaynakla ilerlemiştir; bütün adapter/API, DB ack başarısı, gerçek ilk model girdisi, claim expiry/crash ve full-parent fidelity açık kalır. Bu sınırlı ihlaller bütün geniş HERMES araştırmasını sonsuz fault kampanyasına çevirmemelidir.
