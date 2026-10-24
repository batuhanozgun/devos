# İkinci video — Agent sandboxing, katmanlar ve etki alanı

**Tarih:** 2026-09-16. **Video:** `-01_NB4SbBY`, *AI Agent Sandboxing: Layers, Tradeoffs, and Blast Radius*. **Statü:** kaynak incelemesi ve sınırlı birincil-kaynak çapraz kontrolü; çalışan bir sandbox'ın güvenlik testi değil. V01 yüklenen video, V02 yüklenen SRT; W01 eşlikçi yazı; D01–D08 dış birincil kaynaklardır. Kimlikler, bağlantılar ve okuma kapsamı [SOURCE](SOURCE.md) içindedir.

## 1. Kaynağın sorusu ve iddiası

Video, bir coding agentın terminalde dosya değiştirmesi, test çalıştırması ve paket kurmasıyla başlıyor. Sorusu yalnız yanlış cevap değil, yanlış eylemin nerelere ulaşabileceği: yanlış dizinin silinmesi, gereksiz yere bir sır dosyasının okunması, paket kurulum betiği veya README içindeki kötü niyetli yönlendirme. Başlangıçtaki üç soru: agent nerede çalışıyor; neye dokunabilir; insan veya politika durdurana kadar ne kadar şey yapabilir? [V02, 00:03–02:03, cues2–47]

Kaynağın ana ayrımı **intent / containment**. Talimat, agentın ne yapmasını istediğimizi söyler. Sınırlandırma, başka bir şey yapmaya çalışırsa neyin gerçekten engelleneceğini belirler. Dolayısıyla daha iyi yazılmış bir prompt, işletim sistemi veya runtime tarafından uygulanmış erişim kuralıyla aynı güvence değildir. Bu ayrım zaten videonun tezidir; bizim yeni icadımız olarak sunulmamalıdır. [V02 02:03–02:59, cues48–71]

Buradaki *blast radius*, bu bağlamda bir hatanın veya ele geçirilmiş iş yükünün erişebileceği zarar alanıdır. Video teknoloji prestijinden değil, sınırlandırılmak istenen arızadan başlamayı öneriyor. Amaç mümkün olan en büyük izolasyonu her işe koymak değil, gereken işi yapılabilir tutarken belirlenen zararı sınırlayan düzeni seçmek. Bu bir seçim ilkesi; videoda ölçülmüş evrensel maliyet optimizasyonu değildir. [V02 06:31–09:09; 26:50–30:23]

## 2. İçerik haritası ve gerçek kapsam

Zamanlar bölüm girişleri için yaklaşık SRT çıpalarıdır; doğrulanmış YouTube chapter metadata'sı değildir.

| Zaman | Videodaki konu | İncelemede korunması gereken ayrım |
|---|---|---|
| 00:03–02:59 | Terminalde eylem, üç soru, intent/containment | Talimat ile uygulanan engel |
| 02:59–04:31 | Dilin araç çağrısına ve host eylemine dönüşmesi | Model çıktısı ile aracın güvenli işlemesi |
| 04:31–06:31 | Onay yorgunluğu; önceki harness videosuna bağ | Onay sayısı ile güvenlik sonucu |
| 06:31–09:07 | Beş izolasyon yaklaşımı | Açıklama sırası ile evrensel ürün sıralaması |
| 09:07–11:05 | Yerel coding ve OS sandbox varsayılanları | Mekanizma adı ile gerçek politika |
| 11:05–12:36 | Ortak dosya okuma örneği ve syscall | Aynı path ile aynı nesne |
| 12:36–15:11 | Runtime: V8 isolate / WebAssembly | Host API'sinin yokluğu ile izin reddi |
| 15:11–17:49 | OS sandbox: Seatbelt, bubblewrap, Landlock, seccomp | Süreç kısıtı; gerçek kernel ve kalıtım |
| 17:49–20:24 | Container, namespaces, cgroups | Ayrı görünüm ile ayrı kernel |
| 20:24–23:19 | gVisor / Sentry | Uygulama çağrısını ele alma ile host'a aynen aktarma |
| 23:19–25:48 | MicroVM / Firecracker / KVM | Guest sınırı ile dışarı bağlanan kaynaklar |
| 25:48–30:21 | Aynı isteğin beş sonucu; kullanım durumu seçimi | İzolasyon ile operasyon maliyeti |
| 30:21–32:00 | Beş ortak ilke | Dosya, ağ, credentials, çocuk süreçler, kullanım kolaylığı |
| 32:00–34:23 | Araç yüzeyi ve sandbox'ın çözmediği şeyler | Yerel containment ile yetkili uzak API eylemi |
| 34:23–35:58 | Sonuç ve önceki videoyla eşleştirme | İş yapmaya yeterli alan; hasarı sınırlayan sınır |

V02'nin 859 cue'sunun tamamı okundu. Bazı cue zamanları örtüşüyor; bunlar 859 bağımsız önerme veya ses doğrulaması sayılmaz. V01'den 20 farklı zamanda alınmış kareler incelendi. Kesintisiz video izleme, bütün sesin dinlenmesi veya tam ses–altyazı hizalaması yapılmadı. Metin erişilebilirliği ile bu farklı kapsamlar birbirine yükseltilmedi. [SOURCE; evidence/MEDIA-READING.json]

## 3. Aynı dosya isteği neden beş kez anlatılıyor?

Kaynak, `/etc/passwd` okuma isteğini kullanıyor. Altyazı bunun modern sistemlerde genellikle parola hash'lerini taşımadığını da belirtiyor; örnek bir host dosyasına erişimin ne anlama geldiğini göstermek için seçilmiş. Bu dosyanın adı, SOUL için kendiliğinden zorunlu engelleme listesi oluşturmaz. [V02 11:12–11:38]

| Kaynağın katmanı | Örnekteki sonuç | Örneğin varsayımı ve sınırı |
|---|---|---|
| **L1 Runtime isolation** | Dosya okuma işlemi sunulmamıştır; çağrılabilecek API yoktur. | Host gerçekten dosya API'si sunmamış olmalıdır. V8 adı tek başına güvenli bir ürün belirtmez. |
| **L2 OS sandbox** | Gerçek kernel üzerindeki politika erişimi reddeder. | İlgili nesne/işlem reddedilen kapsamda olmalıdır. Her OS sandbox bütün host okumalarını reddetmez. |
| **L3 Container** | Okuma başarılı olabilir, fakat container görünümündeki dosya okunur. | Host dosyası aynı yere bağlanmışsa veya geniş mount verilmişse bu varsayım değişir. |
| **L4 User-space kernel** | İstek Sentry tarafından ele alınır; sandbox görünümü ve yapılandırma belirleyicidir. | Host kernel tamamen yok olmaz; gVisor'ın kendi sınırlı host işlemleri vardır. |
| **L5 MicroVM** | İstek guest kernel ve guest dosya sistemi içinde işlenir. | Host kaynaklarının açıkça bağlanması ve dış yetkiler ayrıca değerlendirilmelidir. |

[V02 12:36–26:50; V01 13:20, 16:25, 18:45, 22:00, 24:30, 26:15]

Bu anlatımın öğretici sonucu, yalnız 'okuma geçti / geçmedi' gözleminin izolasyonu açıklamaya yetmemesidir. Hangi dosyanın, hangi sistem görünümünde, hangi aracı katmanla okunduğu önemlidir. Container'ın kendi dosyasını okuyabilmesi host'a kaçış kanıtı değildir. Bir OS sandbox'ın ilgili dosyayı reddetmesi de izin verilen başka eylemlerin güvenli olduğunu göstermez. Bunlar tablonun koşullarından çıkardığımız analitik sonuçlardır; burada dosya okuma deneyi yapılmadı.

### L1: Gücü hiç vermemek

Kaynak, dar bir JSON dönüşümü veya sınırlı host işlevleriyle çalışan plugin için runtime izolasyonunu anlamlı buluyor. Aynı yaklaşımın bütün repository, shell, paket yöneticisi ve test altyapısını kullanan işlerde kullanışlılığı azaltabileceğini söylüyor. Host'un ne sunduğu merkezi soru. V8 isolate, Node ortamı ve V8'in memory-corruption amaçlı heap sandbox'ı aynı nesne olarak anlatılmıyor; videonun 14:46 civarındaki ayrımı koruduk. [V02 cues301–365]

**Dış kontrol D03:** WebAssembly'nin güvenlik açıklaması, modülün uygun API'lerden ve embedding politikalarından bağımsız bir dış dünya yetkisi taşımadığını destekliyor. Bu, herhangi bir JS çalıştırma API'sini veya bütün V8 embedding'lerini onaylamaz. V8 implementasyonu bu tur ayrıca incelenmedi.

### L2: Normal süreci gerçek kurallarla çalıştırmak

Videonun yerel coding gerekçesi ergonomi: mevcut proje, testler, bağımlılıklar ve araçlara yakın kalırken erişimi sınırlamak. Seatbelt ile Linux araçlarını tek implementasyon saymıyor; bubblewrap görünümü, Landlock erişim kurallarını, seccomp syscall filtrelerini örnekliyor. Sorular mekanizma isminden çok ağ varsayılanı, okuma/yazma kapsamı, çocuk süreçler ve görev bazlı gevşetme üzerinde. [V02 cues218–261, 366–427]

**Dış kontrol D02:** Landlock belgeleri bunu kernel güvenlik mekanizması olarak tanımlıyor; uygulanan kuralların ilgili thread ve gelecekteki çocuklarını kısıtlamasını açıklıyor. Destek ve kapsam ABI'ye bağlı. Bu belge Seatbelt, bubblewrap veya herhangi bir güncel coding ürününün tüm çalışma yollarının doğrulandığı anlamına gelmez. Kod veya sandbox kurulumu yapılmadı.

### L3: Ayrı görünüm, kaynak kontrolü, paylaşılan kernel

Kaynağın anlatımında namespaces görünümü; cgroups CPU, bellek ve benzeri kaynak kontrolünü sağlar. Tekrar üretilebilir iş ortamı, gerekli dizinin bağlanması ve görev sonu atılabilirlik faydalardır. Geniş host mount'ları, Docker socket, privileged çalışma ve açık ağ ise örneğin koruma varsayımlarını değiştirebilir. [V02 cues428–491]

**Dış kontrol D04:** Docker'ın güvenlik belgesi namespaces, cgroups, daemon erişimi ve capabilities'i ayrı başlıklarla ele alıyor; daemon kontrolü ve host dizini paylaşımının riskini destekliyor. Ana çıkarım, ürün adından yapılandırılmış sınır sonucu çıkarılamayacağıdır. Linux Docker host modeli, her masaüstü veya uzak kurulumun fiziksel topolojisini tek başına tarif etmez.

### L4: Sentry yalnız bir izin listesi değildir

Video, uygulamanın Linux arayüzünün önemli bölümünün user-space kernel içinde ele alınmasını açıklıyor; karşılığında uyumluluk ve syscall yoğun işlerde maliyet soruları doğuyor. Tercih, container benzeri iş akışı ile daha az doğrudan host-kernel teması arasındaki ihtiyaca bağlı sunuluyor. [V02 cues492–559]

**Dış kontrol D05:** gVisor belgeleri Sentry'yi uygulama kerneli olarak ayırıyor: iş yükünün syscall'ı host'a aynen geçirilmez; gerektiğinde Sentry kendi sınırlı host işlemlerini yapar. Belge ayrıca `runsc do` kolaylık yolunda host dosya sistemine salt-okunur erişimin geniş olabildiğini, normal OCI görünümünü yapılandırmanın belirlediğini söylüyor. Bu somut örnek, 'L4 seçtik, hangi dosyayı gördüğü artık önemsiz' çıkarımını engeller. O komut çalıştırılmadı; belgeyi ürün testi saymıyoruz.

### L5: Guest kernel, ama bütün riskleri kapatan son nokta değil

Kaynak, ayrı guest kernel ve donanım sanallaştırmasını anlatıyor. Kullanıcıdan gelen güvenilmeyen kod ve çok kiracılı ürün için microVM'i aday görüyor; image, ağ, temizlik, kaynak muhasebesi ve girdi/çıktı aktarımının işletme yükünü de koruyor. [V02 cues560–616]

**Dış kontrol D06:** Firecracker'ın kendi açıklaması KVM tabanlı microVM mekanizmasını ve 125 ms'nin altındaki açılış iddiasını içeriyor. Bu tek ürünün açılış iddiasıdır; bütün işi hazır hâle getirme süresi, bizim ölçümümüz veya tüm microVM'lerin değeri değildir. Videonun katmanlar arası hız sıralamasını aşağıdaki sebeple kabul etmiyoruz.

## 4. Seçim: kaynak ne öneriyor, biz neyi seçmiş değiliz?

Videonun önerileri koşullu: küçük dar-arayüz işi için runtime; kendi bilgisayarında coding için aracın yerel OS sandbox'ını anlamak; güvenilen iç otomasyon için sertleştirilmiş container; kullanıcı kodu/çok kiracılı işte gVisor, yönetilen sandbox veya microVM değerlendirmek. 'Daha güçlü ama sürekli devre dışı bırakılan sınır' ile kullanılabilirliği korunan sınır arasında bir trade-off kuruyor. [V02 26:50–30:21]

Bu önerilerdeki güvenilen kod kabulü iş bazında sınanmalıdır: bir projenin sahibi güvenilir olabilirken kurulum zinciri veya içeri alınan dış metin farklı güven düzeyindedir. Bu son cümle, açılıştaki paket/README örnekleriyle seçim tablosunu birlikte okumamızdan çıkan koşullu araştırma sorusudur; kullanıcının projesinde olay gözlemi değildir.

Biz SOUL için L2, L3 veya L5 seçmedik. İşin gerçek kaynakları, dış servisleri, kimlik bilgileri, izinleri ve zarar toleransı olmadan ürün tercihi yapmak bu videonun kendi seçim mantığını da atlar. Kaynağın beş katmanı öğretici bir harita; zorunlu beş servis, tek doğrusal güvenlik puanı veya Foundation hiyerarşisi değildir.

## 5. Onay yorgunluğu ve beş ortak ilke

04:31–06:31'de rutin işlemleri art arda onaylamanın önemli kararlara ayrılacak dikkati azaltabileceği savunuluyor. 05:25 karesindeki **%84**, altyazının yalnız dramatik azalma diye anlattığı nicel iddiayı ekliyor. **D01 kontrolü:** Anthropic'in 20 Ekim 2025 yazısı bunu kendi iç kullanımındaki permission-prompt azalması olarak bildiriyor. Bu %84 daha az güvenlik olayı, %84 risk azalması veya her kullanıcı için beklenen sonuç değildir. Videonun bundan çıkardığı 'onaylar eksik containment'ı telafi ediyordu' açıklaması, ayrı bir yorumdur; oran tek başına nedeni ispatlamaz.

Kaynağın son beş ilkesi: kapalı varsayılanlarla başlamak; dosya ve ağı birlikte ele almak; çocuk süreç ağacını kapsamak; sınırı etki alanına göre seçmek; güvenli yolu kolaylaştırmak. Network kapalı olması serbest yazmanın zararını kaldırmaz: kaynak, daha sonra daha yüksek yetkiyle çalışacak kodun değiştirilmesini de anıyor. Böylece olay anındaki sızıntıyla gelecekteki eylemi etkileyen değişiklik ayrı kalıyor. [V02 30:21–32:00; V01 31:05]

31:00 civarındaki SRT 'dry factor' gibi bozuk bir ifade içeriyor. Eşlikçi yazı bunu Simon Willison'ın *lethal trifecta* yazısına bağlıyor; D07'deki üç unsur özel veri, güvenilmeyen içerik ve dış iletişim. Bunun yazılı kaynak eşlemesi olduğunu kaydettik; sesi dinleyerek ifadeyi düzelttiğimizi iddia etmiyoruz.

## 6. Sandbox'ın çözmediği kritik durum

32:00–34:23'te video araçları saldırı yüzeyi olarak ele alıyor. Dar araç listesi, sınırlı sözleşme ve eylemden önce parametre kontrolü önerisi sandbox'a alternatif değil, onun önündeki bir sorumluluk olarak anlatılıyor. [V02 cues766–795]

Ardından kendi karşı örneğini veriyor: agentın geçerli üretim API anahtarı ve izinli bağlantısı varsa, normal HTTPS çağrısıyla üretim verisini silebilir. Yerel dosya sistemi sınırı bu iş yetkisini tek başına değerlendirmez. Bunun için host-kernel kaçışı gerekmez. Kaynak bunu üç soruyla topluyor: model neyi çağırabilir; araç/credential neye erişebilir; yürütme hangi sistem kaynaklarına dokunabilir? [V02 cues796–839; V01 33:45]

Bu örnek 'ağ filtresi hiçbir işe yaramaz' demek değildir. İletişim engelliyse örneğin koşulu değişir. İzin verilen dış servis üzerinde hangi işleme yetki verildiği, salt dosya politikasıyla aynı soru değildir. Anahtarların kapsamı, araç kaydı, audit ve anlamlı sınır geçişlerindeki onaylar videonun tamamlayıcı önerileridir.

**Dış kontrol D08:** Eşlikçi yazının bağladığı Microsoft araştırması, Semantic Kernel'de host üzerinde çalışan dosya-aktarım yardımcılarının model-callable olmasının sınırı aşan bir yol oluşturduğunu anlatıyor. Kaynağın tasarım dersiyle uyumlu; sandbox kerneli kırılmadan host-side araç yanlışlığı önem kazanabilir. Detaylı exploit veya ürünümüzün etkilenme değerlendirmesi yapılmadı. Yazı 2026 tarihlidir; 03:30 slaytındaki 2024 etiketinin tarihsel karşılığını doğrulamıyor.

## 7. Kaynakları sessizce düzeltmeden korunan üç sorun

**Kernel nerede?** 16:25 slaytı policy engelini kernel kutusunun önüne çizip kernel işlemesinden önce durdurma dili kullanıyor. Altyazı ise 16:40–16:54'te gerçek kernelin politikayı kontrol ettiğini söylüyor. D02 ve D05 OS güvenlik denetiminin kernel içinde olmasını destekliyor. Slaytı birebir bir kernel çağrı yolu gibi kullanmak yanıltıcıdır. Belirli bir kontrolün hassas işleme geçmeden durdurması ile isteğin kernel'e hiç girmemesi aynı şey değildir.

**Hız sırası:** 08:40 slaytı yukarıda daha yavaş açılış genellemesi yapıyor; 29:10 matrisi container/gVisor için saniyeler, microVM için yaklaşık 125 ms gösteriyor. D06 bu sayının belirli ürün bağlamını açıklıyor; eş koşullu karşılaştırma sunmuyor. Hız, maliyet ve izolasyonu tek monotone sıralama gibi taşımıyoruz.

**Örnek ile evrensel garanti:** L1'de hiç file API olmaması, L2'de ilgili yolun reddi, L3'te host mount olmaması, L5'te dış kaynak bağlantıları gibi koşullar sonucunu değiştirir. Kaynağın kendi son API karşı örneği de katman numarasından tüm etki alanının türetilemeyeceğini gösteriyor.

Bunlar anlatımın bütününü değersizleştirmez. Faydalı mekanizma haritasını, teknik çizim veya hızlı tablonun taşıyamadığı daha güçlü iddialardan ayırır. Daha ayrıntılı ters kontrol ve kapsam: [REVIEW](evidence/REVIEW-AND-LIMITS.md).

## 8. Bounded sonuç ve dönüş noktası

Bu videonun kaynak incelemesi şu cevabı üretiyor: **Sandbox seçimi, hangi teknoloji daha güçlü sorusundan önce, hangi eylemin hangi kaynak ve yetki sınırında durdurulması gerektiği sorusudur.** Anlamlı bir değerlendirme hem normal işin yapılabilmesini hem yanlış eylemin nerede kalacağını açıklamalıdır.

Beş yaklaşım, ortak dosya örneği, varsayılanlar, süreç ağacı, onay ergonomisi, araç yüzeyi ve dış API sınırı incelendi. Tam ses doğrulaması ve güncel ürünlerin konfigürasyon/kaçış testleri yapılmadı. Kaynak incelemesinin tamamlanması çalışan bir güvenlik çözümünün onayı değildir.

Sonraki iş bu sonucu kullanıcıyla değerlendirmektir. Bu dosya yeni bir benchmark, geniş CVE araştırması, bütün sandbox ürünlerinin karşılaştırması veya ilk videonun U05'ini otomatik başlatmaz. Gerçek bir tasarım kararında gerekecek doğrulamalar, [PLAN](RESEARCH-PLAN.md) içinde açık fakat otomatik sıraya alınmamış işler olarak tutulur. [Proje açısından ilk değerlendirme](SOUL-DEVOS-ASSESSMENT.md) aday soruları ayrıca taşır.
