> **30 Eylül 2026 — tarihsel G0-D1 yerel sınır teşhisi görevi.** Aşağıdaki macOS/Codex profilleri, sentetik probe'lar, model koşusu ve bütçeler eski denemenin kapsamıdır; güncel Claude cloud yeterliği veya yeni test izni değildir. Tarihli hipotez, gözlem ve yapılmamış deney ayrımları korunur; eski teşhis yeniden yürütülmez.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: DevOS Claude Code cloud'da kurulacak ve çalışacak; tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1). Claude Code ve DevOS bu depoyu yalnız okur. Bakımın devamı [REPOSITORY-TRANSITION](../../../../REPOSITORY-TRANSITION.md)'dedir; aşağıdaki T1–T4 devamı değildir.

---

# G0-D1 — Yeni oturumda dar dosya sınırı teşhisi

**Brief ID:** DEVOS-G0-D1-2026-09-06  
**Statü:** PROPOSED / READY FOR EXPLICIT USER ADOPTION. Kullanıcı bu sürümü açıkça gönderip benimsediğinde yalnız aşağıdaki teşhis ve sentetik önkontroller yetkilendirilir.  
**Aşama:** G0 sonucunun ardından sınırlı ortam teşhisi; G0'ın otomatik yeniden başlatılması, T1–T4, R(C1) veya işletim kabulü değil.  
**Güncel research-side checkpoint:** `../../STATE.md`.

## 1. Amaç ve başlangıç durumu

G0 üç aday belgeyi hazırladı, fakat bir sentetik dosyanın beklenen okuma sınırının dışında okunabildiği başlatma kontrolünden sonra durdu. T1–T4 ve ayrı teknik değerlendirme başlamadı. Bu görev mevcut adayın tasarımını tekrar yapmak için değildir.

Hedef: gözlenen okumayı açıklayan politika/çalıştırma yolunu dar biçimde ayrıştırmak ve gelecekteki deneyin ihtiyaç duyduğu okuma ve salt-okunur girdi sınırları için mevcut araçlarla çalışan küçük bir yolu kanıtlamak veya tam olarak hangi koşulun sağlanamadığını göstermek.

- Repository: `batuhanozgun/soul-development-os`.
- Beklenen çalışma kopyası: `/Users/Batu/Documents/Codex/SOUL-Development-OS-Repo`.
- Son bildirilen yerel dal: `bootstrap/starter-contract-g0`.
- C0: `ccd12326a06d2d3323126fde32c616b774ec7675`.
- C1: `66e97050dd141f688fa4da8b26ac3823b020af37`.
- C1 dosyalarından research tarafında hesaplanan tree: `37b60cde322a54012a023b521a2c214028e61e9e`.
- Son gözlenen uzak main: `3776384a7789ccf1959b99bba92c8cf1b3131f81`.
- G0 kanıt dizini: `/Users/Batu/Documents/Codex/SOUL-Development-OS-Run-Evidence/G0-20260906T184203Z-hw893ewz/`.
- ZIP: `G0-EVIDENCE-66e97050.zip`; SHA-256 `79848c0ad7a9247f8c8bad350ac03c7d7bb66d81a7163d6abda2a2cecf07ff07`.

Bunlar geri kazanılacak kimliklerdir, canlı durumun yerine geçmez. Bu oturum yeni G0-D1 teşhis koordinatörüdür; bağımsız R(C1) veya T1 deneme aktörü değildir. C1'in yüklenmesi işletim kabulü vermez. Bu görevin yetkisi yalnız gerçek kullanıcı benimsemesinden gelir.

## 2. Gerekli okuma ve devir

Verilen research ref'inden bu brief'i, `current/reviews/2026-09-06-g0/REVIEW.md` ve `EVIDENCE-EXTRACTS.md` dosyalarını tam oku. Güncel `research/soul-context/STATE.md` dosyasını ayrıca kontrol et. Bütün tarihsel tasarım konuşmasını veya araştırma korpusunu yeniden toplama. Research `AGENT.md`/`agent/**` dosyalarını kendi talimat kaynağına dönüştürme.

Yerelde C1'in `STATE.md`, `work/BOOTSTRAP-001.md` ve G0 `evidence/REPORT-TR.md`, `evidence/R-C1-NOT-RUN.md` kayıtlarını incele. Yerel paket düzeni farklıysa ZIP içindeki manifest ve gerçek dosya yollarını kullan; bulunmayan içeriği varsayma. Hash/ref uyuşmazlığını açıklamadan hedefi değiştirme.

Default dizin, origin, branch, HEAD, çalışma ağacı ve gerekli önceki süreç durumunu gözlemle. Yanlış dizini gizlemek için başka projeye geçme, clone/init/reset yapma. Eski yazıcı ya da ilgili alt süreç hâlâ aynı alanlarda çalışıyorsa çakışan eylemi başlatma. Tüm kullanıcının süreçlerini veya kişisel dosyalarını tarama. G0 devir kaydında tek model süreci için exit/wait gözlemi vardır; bunu canlı makinenin tamamına genelleme.

C1'deki aktif-kapanış ifadesi snapshot zamanına aittir; dış teslim ve devir sonradan turun durduğunu bildirir. Bu zamanlama farkını düzeltmek için C1'e yazma. Mevcut görevle yalnız yeni teşhis kaydı tut.

## 3. Araştırmadan gelen hipotez — doğrulanacak, sonuç olarak kopyalanmayacak

G0'ın gerçek komutunda `default_permissions="g0-limited"`, `:minimal="read"` ve iki özel read girdisi var. Sentinel `/private/tmp/devos-bootstrap-g0-hw893ewz/withheld/sentinel.txt` altında; ona explicit deny verilmemiş. Komutta `--sandbox` yok. Prompt-render gerçek yürütmenin bütün OS politikasını ispatlamaz.

Resmî `openai/codex` etiketi `rust-v0.153.4` şu commit'e çözülüyor:

`3d2ee51ca2d5db578f328aa75e20aa22c0197c9a`.

İlgili kaynaklar:

- `codex-rs/protocol/src/permissions.rs`: `include_platform_defaults()`, blob `7327a5177d4ada0bb69d54715b40f3d76adb8235`.
- `codex-rs/sandboxing/src/seatbelt.rs`: `MACOS_PROCESS_PLATFORM_DEFAULTS`, `MacosSeatbeltProfile`, `create_seatbelt_command_args_with_profile()`, blob `ab606050153ffab1bf5cc2e06c88b4e5c13f249e`.

Bu sürümde restricted `:minimal` okuması platform varsayılanlarını açabiliyor. Normal macOS süreçleri için geçici klasörlerde ek read/write izinleri var; filesystem helper ayrı modda. Bu, sentinel'in niçin okunduğunu güçlü biçimde açıklıyor. Yereldeki gömülü binary'nin aynı build/kod yolunu kullandığı ve tam etkin politika henüz doğrulanmadı.

Yalnız sentinel'i taşıyıp bütün deney sınırını geçti sayma: G0'daki sabit girdiler ve diğer deney kopyaları da `/private/tmp` altında. Source code'daki write izni, gerçekleşmiş yetkisiz yazma kanıtı değildir; kontrollü sentetik girdide ayrıca sınanacak risktir.

İlgili güncel resmî belgeler: `https://learn.chatgpt.com/docs/permissions` ve `https://learn.chatgpt.com/docs/agent-approvals-security`. İsimlendirilmiş profil/legacy sandbox önceliğini ve gerçek sürümün desteklediği native sandbox komutunu doğrula. Gerekirse kaynak koduna GitHub üzerinden seçici dön; bütün Codex reposunu araştırmaya başlama.

## 4. İzin verilen ve verilmeyen etkiler

İzin verilen yeni yazma alanları yalnız:

1. `/Users/Batu/Documents/Codex/SOUL-Development-OS-Run-Evidence/` altında bu işe ait yeni, çakışmayan `G0-D1-*` dizini;
2. `/private/tmp/` altında yeni, çakışmayan `devos-g0-d1-*` sentetik deneme dizini.

Fiziksel yolları ve symlink durumunu kontrol et. G0'ın mevcut dizinlerini yeniden kullanma, silme veya değiştirme. D1 için sentetik izinli/izin dışı/readonly girdiler, dar yardımcı betikler ve kanıt dosyaları oluşturabilirsin. Bu dosyalar yeni kalıcı Development OS mimarisi değildir.

Mevcut CLI'ın sürüm/help ve yalnız ilgili hassas olmayan etkin config/policy seçimlerini okuyabilir, desteklenen process-local daraltmalarla native sandbox önkontrolü çalıştırabilirsin. Gerekli platform onayını mevcut dar onay yolundan iste; onayı atlamak için Full Access veya sandbox bypass kullanma. Başlatıcının onayı ile alt komutun korunma biçimi aynı şey değildir; neyin sandbox'a girdiğini göster.

Yasaklar:

- C0/C1 veya gerçek repository dosyalarını değiştirmek; branch/commit/reset/merge/push/PR/issue/release yapmak;
- G0 raporu, ZIP'i, kriterleri veya eski başarısızlık kaydını yeniden yazmak;
- `~/.codex`, global AGENTS/override, kalıcı config/izin, hesap veya credential değiştirmek/kopyalamak;
- paket/CLI güncellemek, servis/sunucu/VM satın almak, yeni API key/faturalama açmak;
- kullanıcının kişisel dosyalarını sentetik negative control yerine kullanmak;
- gerçek dış yazma, veri sızdırma veya başka kullanıcı süreçlerine müdahale;
- T1–T4, R(C1), B0/A, ürün veya otomatik self-development başlatmak.

CLI'ın kaçınılmaz runtime yan etkilerini 'hiçbir yere yazılmadı' diye gizleme. Genel kullanıcı ayarları bilerek değiştirilmez; tam runtime before/after envanteri yapılmadıysa kapsamı açık bırak.

## 5. Küçük nedensel ve sınır kontrolü

Önce G0 kayıtlarından config, olası legacy önceliği, process/helper ayrımı ve sentinel'in effective grant ile ilişkisini çıkar. Yerel yardım destekliyorsa birincil yol mevcut `codex sandbox macos` ile sentetik native komut testidir; sırf dosya okuma kontrolü için tekrar tekrar model çalıştırma.

En fazla iki process-local profil varyantı ve toplam on native probe komutu kullan. Bunlar harcama/iş sınırıdır, genel doğrulama standardı değildir. Aynı anda yalnız bir probe; her birine en fazla 60 saniye. Beklenti, profil girdileri, fiziksel yol, dosya hash'i ve test amacı koşudan önce D1 kanıtına yazılır.

Gerekli ayrımlar:

- İzinli sentetik okuma gerçekten başarılı mı?
- Önceki gibi özel listede bulunmayan ama platform geçici istisnasına düşen dosya neden okunabilir? Bu örnek, dar sınırın PASS'i değil nedensel karşılaştırmadır.
- Platform/runtime izin köklerinin dışında ve izinli bir üst klasöre düşmeyen sentetik okuma engelleniyor mu?
- Sürüm destekliyorsa explicit deny ile sentetik geçici yolun erişimi gerçekten kapanıyor mu?
- Okunmasına izin verilen, değiştirilememesi gereken sentetik girdi üzerinde write girişimi engelleniyor ve hash korunuyor mu? Gerekirse gelecekteki salt-okunur kaynak düzenini temp dışındaki izinli D1 alanında sınayabilirsin.

İstemeden izinli üst kökün altına yerleştirilmiş negative örneği 'kapsam dışı' sayma. Kriteri adayın çıktısından üretme. Eski G0 FAIL sonucu yeni açıklama veya yeni ölçütle geriye dönük PASS olmaz.

Sentetik readonly dosyada yazma başarılı olursa bu yalnız sentetik dosyada kaydedilecek kontrol başarısızlığıdır; gerçek G0 veya kullanıcı dosyalarında deneme yapma. Bir yasak yazma/okuma kontrolü başarısızken o profile geniş kaynak erişimli model görevi verme.

Native komut desteği veya nested sandbox kısıtı gerçek platform kapısına takılırsa yalnız izinli yol ve hassas olmayan hata kanıtını incele. Kurulum, genel izin artışı veya güvenlik bypass ile çözmeye çalışma. İlgisiz sonsuz hata ayıklama yerine tamamlanan statik teşhis ile tam blocker'ı teslim et.

## 6. Gerçek araç yoluna son sınırlı kontrol

Native helper sonucu gerçek agent-shell yürütme yoluyla eş tutulmaz. Yerel helper kontrolleri gerekli sınırlı koşulları destekliyorsa ve gerçek yürütme farkını sınamak gerekiyorsa, en fazla **bir** fresh alt Codex koşusu yapılabilir.

Bu koşu yalnız yeni D1 sentetik girdilerini okur; gerekli tek sentetik write probe varsa yalnız bu dosyaya yöneltilir. Gerçek C1/G0/kişisel içerik verilmez. Aday root'unun dışında başlar. Mevcut ChatGPT hesabı ve gözlemlenebilir `gpt-6-astra / ultra` eşlemesi kullanılır. Yeni API/credential, model fallback veya izin genişletme yoktur. Parametrelerin gönderilmesi kesin backend snapshot bilgisi değildir.

Bu model koşusu en fazla 10 dakika, eşzamanlı en fazla birdir. Süre aşımında yalnız bu görevce başlatılan kontrollü süreç durdurulur; sonucu ve exit bilgisi tutulur. İkinci model denemesi veya sonucu geçirene kadar onarım yoktur. Yapılamazsa `ÇALIŞTIRILAMADI` ve nedeni yazılır.

G0 bütçesi geçmişte 1 gerçek/2 muhafazakâr startup ve kullanılmış tek teknik düzeltmeyle kalır. Bu brief'i kullanıcının ayrıca benimsemesi D1'in yukarıdaki yeni sınırlı bütçesini verir; G0 kaydı sıfırlanmaz.

Okuma sınırı, yazma sınırı, otomatik talimat yüklemesi ve diğer araçların etkileri ayrı sonuçlardır. Hiçbir araç adının görünmemesini amaç yerine koyma. Gerekli yolların güvenli biçimde daraltıldığı gösterilemiyorsa bu belirsizliği raporla; dosya testinden bütün connector güvenliği hakkında hüküm çıkarma.

## 7. Teslim ve dönüş noktası

Türkçe sonuç ve D1 dizininde paylaşılabilir küçük kanıt paketi üret:

1. G0 kanıtından bilinen, resmî kaynakta görülen ve D1'de gerçekten gözlenen ayrımı.
2. Gerçek binary/sürüm, ilgili config seçimi ve process/helper politika yolu; görülmeyen build provenance açık kalır.
3. Test başına başlangıç/izin/beklenti/çıktı/exit/önce-sonra hash, negatif kontroller dahil.
4. Öncelikli açıklama desteklendi mi; alternatiflerden hangileri dışlanamadı?
5. Hangi küçük kaynak/scratch yerleşimi ve process-local profil ihtiyaç duyulan sınıra yeterli olabilir? Bu bir sonraki deney önerisidir; G0 dosyalarına uygulama.
6. Korunan C1/G0/main kimlikleri, D1'in kendi mutation listesi, bitmiş/aktif/belirsiz kendi süreçleri ve devir.
7. Tek sonraki öneri: T1–T4'ün ayrıca yetkilendirilecek devamı için sınır yeterli mi, yoksa tam olarak hangi koşul açık?

Gizli chain-of-thought, token, bütün kişisel config veya ilgisiz dosyaları kaydetme. Kaynak/script kapsamını açık tut; bir helper script'i varsayılan güvenilir sayma. Yapılmış ve yapılmamış testleri ayır. Sonucu sohbette özetle; küçük sanitised kanıt paketini kullanıcıya ver. GitHub'a otomatik yayınlama.

Gerekli ayrımlar yeterince gösterildiğinde veya sınırdaki blocker kesinleştiğinde dur. Daha fazla ayrıntı mümkün diye bu işi genel sandbox geliştirmesine dönüştürme. T1–T4 ya da kabul aşamasına kendiliğinden geçme.
