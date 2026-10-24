# EXP-006 — karar sicilinin güncel statüsü

**Güncelleme: 29 Eylül 2026.** Bugünkü kurulum yönü aşağıdaki D030'dur. Eski D001–D029 kayıtları, kaynak mesajları ve teknik önerilerin tarihçesi değiştirilmeden altta korunur. Tarihsel kayıt olmak, önceki bütün ilkelerin reddedildiği veya eski test beyanlarının yeniden doğrulandığı anlamına gelmez.

<a id="d030--claude-code-cloud-kurulum-devri"></a>
## D030 — Claude Code cloud kurulum devri

**Statü:** Açık kullanıcı kararı, **29 Eylül 2026**. Kaynak: [Batu'nun depo güncelleme görevi, §2 ve §3.1](../../maintenance/2026-09-29-research-installation-separation/REQUEST.md).

- DevOS, **Claude Code cloud**'da kurulacak ve çalışacaktır. **D027'deki ortam kararı ve D029'daki “Codex hem kurucu hem çalışma ortamı” kararı geçersizdir; tarihsel kayıt olarak kalır.** D029'daki yüksek kalite ve SOUL'un sağlayıcı bağımsızlığı hedefi bu ortam değişikliğiyle geri alınmış sayılmaz. Eski D011'in bütün döneme özgü kurulum adımları da otomatik yeniden etkinleşmez.
- DevOS kurulumu **Claude Code'a devredilmiştir**. Geçerli planın tek evi [batuhanozgun/devos — plan/](https://github.com/batuhanozgun/devos/tree/main/plan), devirdeki sürümü **2.1**'dir. Bu deponun kayıtları DevOS kurulumuna yön vermez; plan kopyası burada tutulmaz.
- `agentic-os-search`, DevOS için **gizli araştırma kütüphanesidir**. Claude Code kurucusu ve DevOS ekibi burayı **salt okunur** kullanır. Yazarı Batu'nun onayıyla ChatGPT'dir; ChatGPT `devos`, `soul`, `soul-system`, `devos-evals` ve `devos-backup` depolarına yazmaz.
- Yeni SOUL ürün deposu [soul-system](https://github.com/batuhanozgun/soul-system)'dir. Eski [soul](https://github.com/batuhanozgun/soul) ve diğer önceki deneme depoları olduğu gibi kalan tarihsel kaynaklardır.

**Kararın kanıt sınırı:** Bu kayıt kullanıcı yetki/statü değişimini yansıtır; yeni kurulumun başladığını, platform iddialarının bu tur yeniden doğrulandığını, hedef sınamalarının geçtiğini veya P6 kabulünün verildiğini söylemez. Research'ün bu devirdeki sonraki işi [depo bakım planındadır](../../REPOSITORY-TRANSITION.md); eski S00 ya da DEVOS-001/002 işi değildir. `AGENT.md` ve `agent/**` bu kararla değişmez ve Claude için talimat olmaz.

---

## 28 Eylül 2026 karar kaydı — aşağıdaki current/next ifadeleri o tarihe aittir

# EXP-006 — DECISIONS

**Rol:** Kullanıcıyla netleşmiş çalışma kararlarını/kısıtları candidate fikirlerden ayırmak.
**Güncelleme:** 28 Eylül 2026, P5 devam yetkisi ve inşa/kurulum paketi teslimi.
**Current:** P5 rehber/kaynak paketi hazır; actual inşa başlamadı. [STATE](STATE.md) ve [P5-01](work/P5-01-codex-build-installation-package.md) current durumu taşır.
**Sınır:** Kaynak kararı teknik gerçeğe, dosya kimliği yeterlik kanıtına dönüşmez. D001–D028'in tarihsel “bu tur/son yön” ifadeleri kendi kaynak turuna aittir. D011'in Claude hedefi D027 ile superseded'dır; D029 latest continuation'dır.

| ID | Karar / çalışma anlaşması | Statü |
|---|---|---|
| **D001** | EXP-006'nın üst amacı, SOUL'u yaratmak için Development OS'un nasıl bir çalışma düzeni olması gerektiğini konuşarak ortaya çıkarmaktır. | accepted working direction |
| **D002** | Şimdilik iki geniş aktör sınıfıyla ilerlenir: **insan** ve **yapay zekâ**. Alt ajan/model/oturum örnekleri otomatik yeni aktör sınıfı sayılmaz. | accepted working simplification |
| **D003** | İnsan/müşteri rolünün çekirdeği **yetki + kabul** olarak tutulur; teknik keşif ve koordinasyon yükü varsayılan olarak müşteriye bırakılmaz. | accepted working distinction |
| **D004** | Development OS yapay zekâ rolleri jenerik adlarla önce üretilmez; **Work'ten ve onun doğurduğu sorumluluklardan türetilir.** | accepted method |
| **D005** | Work keşfinde RPD kullanılır; ihtiyaç/iş önce, sorumluluk/rol sonra, mekanizma/araç en son gelir. | accepted method; D011'in belirlediği Environment önce tanınır, ayrıntılı çözüm seçimi ihtiyaçla karşılaştırılır |
| **D006** | EXP-001/002/004 okumalarından çıkan kapsamlı SOUL hedef tanımı bu aşama için **yeterince somut çalışma hedefi** kabul edilir; nihai SOUL tanımı/mimarisi olduğu iddia edilmez. | accepted stage gate |
| **D007** | B1–B9, SOUL modül listesi değil Development OS'un SOUL üzerinde yapacağı birinci seviye Work alanları olarak kullanılır. | working map accepted for continuation; taxonomy not final |
| **D008** | Her B dalı şu sırayla açılır: Work → gerekli DevOS kabiliyet/sorumlulukları → bunları taşıyan AI rolü / mekanik sorumluluk / insan sınırı → daha sonra sistem yapısı. | accepted method |
| **D009** | EXP-006, yalnız konuşma arşivi olarak büyütülmeyecek; fresh-session devrini sağlayacak WORK/ACTORS/DECISIONS/HANDOFF ve aktif Work dosyalarıyla yaşayan çalışma yüzeyine dönüştürülecek. | explicitly accepted |
| **D010** | EXP-006 cevapları ana sonucu örnekler, geçmiş özeti veya uzun muhakeme anlatısıyla gömmeyecek. Varsayılan çıktı kısa sonuç, gerekiyorsa karar-kritik belirsizlik ve plan içindeki tek devam noktasıdır. Ayrıntı repoda tutulur; kullanıcı ayrıca istediğinde açılır. | explicitly accepted communication rule; U002-A ile pekiştirildi |
| **D011** | DevOS, SOUL'u yaratmak için **Claude Code cloud** ortamında çalışacak. Tasarımdan önce bu Environment'ın gerçek imkân/sınırları Anthropic'in birincil kaynaklarıyla öğrenilecek. | explicit user constraint/direction; U002-A/B |
| **D012** | SOUL'un ilk ve sonraki işlerini kurulacak DevOS ekibi keşfedecek, değerlendirecek, planlayacak ve yürütecek. Assistant'ın işi bu ekibin çalışacağı düzeni ortaya koymaktır; ekibe hazır SOUL backlog'u seçmek değildir. | explicit scope boundary; U002-A ve önceki geçiş düzeltmesi |
| **D013** | Roller birbirinden bilgi, araştırma, değerlendirme veya kontrol isteyebilmeli; talep doğru çalışmaya ve geri dönüp kullanılan sonuca bağlanmalı. Mesajlaşma/repository veya başka bir yöntem seçimi açık. | explicit communication requirement; U002-B |
| **D014** | Normal çalışma akışında her rolü/sonraki işi Batu'nun elle tetiklemesi gerekmemeli. Gerektiğinde müdahale, başlangıç/yeniden başlatma ve yetki/kabul mümkündür; sonsuza kadar insan-bağımsız çalışma istenmiyor. | explicit autonomy boundary; U002-B/C |
| **D015** | SOUL ürün çıktıları ile DevOS'un kendi iş/bilgi/karar/devam kayıtları ayrı amaçlarla, ilişkileri korunarak yönetilecek. Fiziksel repository/dosya şeması henüz seçilmedi. | explicit requirement; U002-A |
| **D016** | Foundation, özellikle WORK ve INFORMATION, bakış açısını ve gereklilik keşfini besleyecek; studies bu çerçeveyle okunarak uygulama örnekleri/sınırları sağlayacak. | explicit research-use direction; U002-A |
| **D017** | Claude incelemesinden önce mevcut EXP-006'ya bağlı, yeni oturum/turlarda devralınabilir bütünsel plan kalıcılaştırılacak. Üst harita baştan görünür olacak; turlar ayrıntıyı açacak veya gerekçeli revizyon yapacak. | explicit planning/persistence authorization; U002-A/C |
| **D018** | Kanon/v2 karşılaştırmasının amacı manuel tetikleme farkıdır. `loopinance_v2`nin bütün düzeni veya ECC'nin DevOS'a aynen alınması istenmedi. | explicit example/adoption boundary; U002-C |
| **D019** | Alt ajan/takım ve bütünleşik teknik seçim P4'te değerlendirilecek; kullanıcı bu ayrımı anladığını belirterek P2'ye devam edilmesini istedi. | explicit sequencing confirmation; 27 Eylül 2026; belirli topoloji veya henüz üretilmemiş rol taslağı onayı değil |
| **D020** | P3'te araştırma örnekleri/metodolojileriyle derinleşilecek; assistant hemen karar vermek yerine bir başlangıç yapısı sunacak ve kullanıcıyla bu baz üzerinde değerlendirecek. | explicit discussion/return boundary; 27 Eylül 2026; P3-01 önerisinin kabulü değil |
| **D021** | İçerik sahibi ne söylendiğini ve gerekçesini; çalışma düzeni tarafı dosya/kayıtların yerini, statüsünü, kaynak/sürüm ilişkilerini, bulunabilirliğini, bakımını, devrini ve yeniden kullanımını taşır. Düzen tarafı anlamı yeterince anlayabilmeli, fakat ürün kararını üstlenmemeli. Düzen yalnız görsel klasör temizliği değildir. | Kullanıcının “aynı fikirdeyim” yanıtıyla kabul edilmiş sorumluluk sınırı; 27 Eylül 2026. Ayrıntılı şema, tüm P3 kuralları veya fiziksel ayrı ekip onayı değil. |
| **D022** | P3 tasarım devrine hazır sonucu ve P4 devam noktası sunulduktan sonra kullanıcının “devam et” yönü P4 bütünleşik teknik tasarımını açar. | 27 Eylül 2026, aşama yetkisi; P4-01 tercihinin kullanıcı kabulü, P3'ün bütün ayrıntılarına formal onay veya P5 kurulum izni değildir. |
| **D023** | Rapor yüzeysel tarama/küçük eklerle değil, SOUL'un ne olacağına göre DevOS gereksinimleri yeniden türetilerek baştan yazılacak; gerekli kalite uygulama kolaylığı lehine düşürülmeyecek. | Açık kullanıcı yeniden yazım yönü; v2 teslimi P4-02'de. Yeni teknoloji/mimari kabulü veya karmaşıklığın üstünlüğü değil. |
| **D024** | V2 yapı stres testine alınacak ve rapor **sayfa sınırı olmadan** yeniden hazırlanacak. Önceki 200 sayfa koşulu kaldırıldı. | Açık kullanıcı talebi; görünür kaynak P4-03 §1. Eksiklerin sayfa sınırından kaynaklandığının kanıtı veya v3 başarısı değil. |
| **D025** | Yarım kalan stres testi/yeniden yazıma yeni oturumda devam edilecek; mevcut tur repository durumunu ve kaynak devrini hazırlayıp duracak. | Son açık kullanıcı yönü; P4-03 §1. Bu tur yeni stres testi/rapor çalışması veya P5 kurulumu yapılmaz. |
| **D026** | Yeni oturumda eklenen gerçek devir paketi üzerinden aynı P4 sayfa sınırsız stres testi ve rapor çalışmasına devam edilecek. | 28 Eylül 2026 açık devam talebi; P4-04 §1. D025'in önceki turda durması tamamlandı. Yeni mimari kabulü, P5/P6 veya SOUL backlog seçimi yetkisi değil. |
| **D027** | DevOS'u yaratacak hedef Environment artık **Codex** olacak; Claude Code cloud current hedef olmaktan çıkar. | 28 Eylül 2026 açık kullanıcı kararı. D011 tarihsel provenance olarak korunur fakat current Environment kararı açısından superseded'dır. Codex içindeki exact Agents API/CLI/hosted/self-hosted topolojisini tek başına kabul etmez. |
| **D028** | Önce P4 dokümanı Codex kararına göre yeniden hazırlanacak; bunun ardından P5 kurulum rehberi Codex'e göre hazırlanacak. | 28 Eylül 2026 açık sequencing direction. V4 rapor teslimi P5 kurulumu değildir; P5 ayrı çalışma aşamasıdır. |
| **D029** | P5 inşa/kurulum paketi hazırlığına geçilecek. Codex hem DevOS'u kuracak hem kurulan DevOS'un bilişsel çalışma ortamı olacak. SOUL'un Codex/Claude Code'a bağımlı olmaması korunacak ürün hedefi; gerekli kalite kolaylık lehine düşürülmeyecek. | 28 Eylül 2026 açık kullanıcı yönü; P5-01 §1. Gerçek çapraz-provider yeterlik kanıtı, belirli API/host/PG sağlayıcısı kabulü, açık uçlu maliyet/veri/yayın izni veya bu tur P6 kabulü değildir. |

D011–D018 [U002](sources/U002-cloud-plan-and-autonomy.md)'ye; D019 P1 açıklamasından sonraki devam yönüne; D020 ilk P3 isteğine dayanır. D021 kaynak açıklama/kabulü [P3-01 §1](work/P3-01-work-information-discussion.md#1-kullanıcı-yönü-ve-önerinin-sınırı)'de, D022 P3→P4 devam bağlamındadır. D023 [P4-02 §1](work/P4-02-soul-derived-report-v2.md#1-yetki-ve-neden-yeniden-yazıldı), D024/D025 [P4-03 §1](work/P4-03-unbounded-stress-test-handoff.md#1-kullanıcı-yönü--görünür-konuşma-kaynağı) ile izlenir. D023–D025 kayıtlarının eklenme tarihi 28 Eylül 2026'dır; daha önceki mesajlara kesin zaman damgası uydurulmaz. D026'nın görünür kaynak ifadesi P4-04 §1'de korunur. D027–D028 bu konuşmadaki açık Environment değişikliği ve sıralama yönüdür; P4-05'te kaydedilir. D029'un görünür talebi P5-01 §1'dedir.

## Teknik öneriler — kullanıcı kararları değildir

P4-01 eski baseline; v2/v3 ortak mimari ve yerel testler P4-02/P4-04'te; P4 v4 Codex bağlaması P4-05'tedir. **Current P5-1.0.0 paketi** bu kaynağı inşa şartnamesine çevirir. Ayrı root/child yetki sınırı, 6 ortak protokol + 18 rol + 7 method birleşimi, typed application, PostgreSQL referansı, body store/publisher/fence ve release/test düzeni P5 teknik tercihleridir. Bunları kullanıcıya önceden kabul ettirilmiş P4 kararları gibi sunma.

Supabase, actual hosting/region, API hesabı/veri işleme/maliyet, publish target ve recovery toleransları C01–C08 ile çözülür. Codex seçimi yalnız masaüstü uygulamayı kurmanın bütün API runtime'ı hazır ettiği anlamına gelmez. D013/D015 içindeki eski “seçimi açık” ifadeleri tarihsel kullanıcı sınırını taşır; current teknik tasarım bundan ayrıdır.

## Kanıt ve current devam

P4'ün 40/53 test ve mutation kayıtları kendi tarihsel koşularıdır; bu P5 turunda yeniden koşulmadı. P5'in 50 yerel paket-araç testi geçti. 67 hedef senaryosu tasarlandı, hiçbiri çalıştırılmadı. Şema, rol metni ve manifest gerçek platform/DB/güvenlik/bilişsel yeterlik kanıtı değildir. Teknik testlerin yazarı ve rehberin yazarı aynı assistant'tır.

**Plan v1.9 / P5 PAKETİ HAZIR / ACTUAL İNŞA BAŞLAMADI.** Codex devri S00'dan kaynak/target/yetkiyi doğrulayacak. P6 veya ilk SOUL backlog'u başlamadı. Tam paket konuşma ekinde, current kayıt ve başlangıç metni repository'dedir. Research agent-control değişmedi.
