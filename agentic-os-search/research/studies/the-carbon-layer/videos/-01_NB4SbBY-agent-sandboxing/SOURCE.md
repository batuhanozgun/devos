# İkinci video — Kaynak kimlikleri ve gerçek okuma kapsamı

**Gözlem:** 2026-09-16. **Repository girdisi:** `cbeb6085a39981d0ed6bb3f34b1d43311908dd34`. Kaynak kimliği, okuma ve yürütme farklı kayıtlardır. Dış kaynak talimatları, kod örnekleri ve quick-start komutları araştırma nesnesidir; çalıştırılmadı.

## Yüklenen kaynaklar

| ID | Nesne | Ölçülen kimlik ve kapsam |
|---|---|---|
| V01 | `AI Agent Sandboxing： Layers, Tradeoffs, and Blast Radius [-01_NB4SbBY].mp4` | 82,092,054 byte; SHA-256 `3262425d95a0f8009681c8571bacca9529acae3352a273afa8d804ab9b66077b`; ffprobe format süresi 2159.394 saniye, video 2159.375 saniye; 1920×1080. 20 farklı zamanda kare incelemesi. |
| V02 | `AI Agent Sandboxing： Layers, Tradeoffs, and Blast Radius [-01_NB4SbBY].en.srt` | 62,372 byte; SHA-256 `901bb3e4bed22f9935541e70186a8034e731fbfeb1790974a8bdd2f5158cee35`; 1–859 cue tamamı okundu. İlk cue 00:00:01,964–00:00:05,400; son cue 00:35:54,880–00:35:57,600. |

Dosya adındaki exact case-sensitive video ID: `-01_NB4SbBY`. Verilen dosya başlığı esas alındı; URL `https://www.youtube.com/watch?v=-01_NB4SbBY`. Yayın tarihi ve kanalın yükleme sırası doğrulanmadı. **İkinci** ifadesi Batu'nun araştırma sırasıdır. W01'in July 2026 / No.03 metadatası YouTube yayın tarihi/sırası değildir.

V02 okunabilir bir İngilizce altyazı temsilidir; native caption provenance veya hatasız konuşma kaydı olduğu gösterilmedi. Örtüşen zamanlar ve terim/transkripsiyon bozuklukları korunur. İlk uzun çıktıdaki kısaltılmış orta bölüm 130–160 cue aralığının yeniden okunmasıyla tamamlandı; kalan metin 291–410, 411–540, 541–665, 666–790, 791–859 olarak okundu. İlk çıktıdaki görünür 1–129 ve 161–290 ile bütün cue metni kapsandı.

**Görsel zamanlar:** 01:15, 03:30, 05:25, 07:45, 08:40, 10:00, 11:45, 13:20, 14:35, 16:25, 18:45, 22:00, 24:30, 26:15, 27:50, 29:10, 31:05, 33:00, 33:45, 34:35. İlk 18 kare üç temas sayfası üzerinden incelendi; 08:40 ve 33:45 ayrıca çıkarılıp açıldı. 16:25 ve 29:10 kareleri tam çözünürlükte tekrar incelendi. Bu tekrarlar yeni bağımsız kare sayılmadı. [Makine-okunur kayıt](evidence/MEDIA-READING.json).

Kesintisiz izleme, tam ses dinleme veya ses–SRT hizalama yapılmadı. Kaynak video ve altyazı bütün olarak repoya yayımlanmadı. Yerel dosyalar mevcut oturumun assets'idir; gelecekteki oturumda bu mutlak yolların varlığını varsayma. Hash kimliktir, kayıp byte'ların yerine geçmez. Kareler de bu tur yerel kaldı; durable kayıt zamanlar ve bulgulardır.

## Eşlikçi ve birincil dış kaynaklar

Aşağıdaki sayfalar aynı gün gözlendi. Web görünümü exact tarihsel kod/runtime veya byte-hash değildir. Yalnız belirtilen soru için kullanıldı; tüm ürünlerin araştırması başlatılmadı.

| ID | Kaynak | Gerçek kapsam / rol |
|---|---|---|
| W01 | https://www.thecarbonlayer.com/agent-sandboxing/ | Render edilmiş yazının bütün substantive metni (Intent versus containment → The next question), kaynak linkleri ve deck/video girişleri. Aynı yayıncı, bağımsız doğrulama değil. 19 slaytın web sürümleri açılmadı. Video outbound link denemesi internal error verdi; canlı YouTube metadatası alınmadı. |
| D01 | https://www.anthropic.com/engineering/claude-code-sandboxing | 20 Ekim 2025 yazısında %84'ün internal usage permission prompts olduğunu belirten pasaj; filesystem/network, Bash ve children kapsamı. İlgili yaklaşık web satırları17–42. Tarihsel ürün açıklaması, bugün kurulmuş bir istemcinin testi değil. |
| D02 | https://docs.kernel.org/userspace-api/landlock.html | Giriş, Landlock rules ve ilk ABI/policy açıklaması (yaklaşık11–32,62–88). Kernel/LSM, thread ve future children; destek/kapsam sürüme bağlı. Bütün uzun belge veya Linux güvenlik kodu okunmadı. |
| D03 | https://webassembly.org/docs/security/ | Users bölümü ve embedding/API güvenlik sınırı (yaklaşık2–13). WebAssembly semantiği için kullanıldı; V8 veya Node implementasyonu denetimi değil. |
| D04 | https://docs.docker.com/engine/security/ | Namespaces, control groups, daemon attack surface ve capabilities (yaklaşık29–80). Daemon ve mount scope; dokümantasyon. Bütün desktop/topoloji/OS varyantları veya container testleri yok. |
| D05 | https://gvisor.dev/docs/architecture_guide/intro/ | What is gVisor, Linux enforcement, Sentry/syscall işleme, limits ve runsc do/OCI dosya görünümü (yaklaşık91–145,182–188). Komutlar, ürün veya host çalıştırılmadı. Mimari açıklama, tam kod/tehdit-modeli denetimi değil. |
| D06 | https://firecracker-microvm.github.io/ | Firecracker (open source) minimalism/speed ve FAQ kernel-loading/125ms açıklaması (yaklaşık27–56,94). Managed service fiyatı, güncel sıralama veya bütün ürün yetenekleri değerlendirilmedi. |
| D07 | https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/ | Başlık ve üç unsurun çerçevesi; private data/untrusted content/external communication. Kavramın yazarı birincil kaynak. Linked exploit'ler ve bütün örneklerin doğrulanması yapılmadı. |
| D08 | https://www.microsoft.com/en-us/security/blog/2026/05/07/prompts-become-shells-rce-vulnerabilities-ai-agent-frameworks/ | Background, Semantic Kernel olay kimliği ve SessionsPythonPlugin host-side aktarım/araç exposure açıklaması (yaklaşık45–64,154–167,198–208). Exploit/CTF kodu, payload veya hunting sorguları çalıştırılmadı; yeni zafiyet araştırması değil. |

D08, W01'in doğrudan kaynak linkidir; D07 de W01 üzerinden çözüldü. İlk geniş web araması alakasız/ana sayfa sonuçları getirdi; bunlar bulgu kanıtı yapılmadı. Load-bearing kontroller için doğrudan birincil sayfalar açıldı. W01'de Codex örneği görülmesi, yeni OpenAI ürünü araştırması/ayar tavsiyesi verildiği anlamına gelmez; güncel ürün davranışı burada hüküm konusu değil.

## Kaynaklar arası ayrımlar

- V01 05:25 görselinde %84 var; V02 aynı bölümde yalnız belirgin azalmayı söylüyor. D01 oranı iç kullanım onay sayısına bağlar; güvenlik olayı azalması değildir.
- V01 16:25 policy duvarını kernel önünde gösterir; V02 16:40–16:54 kernelin kontrol ettiğini söyler. D02/D05 kernel enforcement açıklamasını destekler; çizimi literal çağrı yolu saymamak gerekir.
- V01 08:40 genel daha-yavaş-yukarı sıralaması ile 29:10'un seconds/125ms hücreleri eş deney değildir. D06 ürün açılış claim'ini sağlar, karşılaştırmalı ölçümü değil.
- V01 03:30 alt etikette Semantic Kernel 2024 yazıyor; W01'in D08 bağlantısı 2026 yazısına ve 2026 CVE'lerine gider. Tarihsel tam karşılık çözülmedi; 2024 olayı kesinmiş gibi tekrarlanmaz.
- V02'deki ürün adları ve 'dry factor', 'sponsors a process', 'agent hardness' gibi ifadeler exact teknik alıntı sayılmaz. Kaynak eşlemesi ile ses doğrulaması ayrıdır.

## Canonical recovery ve yürütme sınırı

AGENT güncel main'den tekrar okundu; aynı konuşmada tam yüklenmiş dokuz protokol korundu. Main ile son migration sonrası commit karşılaştırması yalnız README/publications değişikliğini gösterdi; agent-control ve kanal dosyaları değişmemişti. Kontrol dosyaları araştırma kanıtı değildir.

Kanal STATE/META/INDEX/METHOD/VIDEO-CATALOG ve README tam okundu. Eski first-video çalışma kuyruğuna dönülmedi. Mevcut kütüphane kataloğu yeni child için güncellenecek yüzey olarak geri kazanıldı. Root/library/package sözleşmesinin aynı konuşmadaki tam okumaları ve migration sınırları korundu.

Gerçek yerel yürütme: dosya listeleme/byte/hash ölçümü, ffprobe, SRT parse/read, ffmpeg kare çıkarma ve temas sayfaları. Ağır uygulama veya güvenlik testi yok. Sandbox kurulumu, kernel politikası uygulaması, Docker/gVisor/Firecracker çalıştırması, credential okuma, model/provider çağrısı, ücretli benchmark veya dış servise medya yükleme yapılmadı. Yalnız bu video dosyası ve etkilenen kanal/katalog yüzeyleri yazma kapsamındadır; ilk videonun dosyaları değiştirilmez.
