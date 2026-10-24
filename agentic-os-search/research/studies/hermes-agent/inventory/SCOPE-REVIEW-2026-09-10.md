# HERMES — Kapsam, kanıt ve bir sonraki birimin gerekçesi

2026-09-10 / RESEARCH-PROCESS ASSESSMENT. Taban `634ab66f195130d551d58dfc062639e0feec23fa`. Kullanıcı durum değerlendirmesini ve aşağıdaki devamı kabul etti. Bu dosya yeni upstream bulgusu veya tamamlanma yüzdesi değildir. [Amaç](../00-WHY-THIS-RESEARCH.md), [yöntem](../METHOD.md), [eski plan](https://github.com/batuhanozgun/agentic-os-search/blob/634ab66f195130d551d58dfc062639e0feec23fa/research/studies/hermes-agent/RESEARCH-PLAN.md), [ilk envanter](STRUCTURE.md) ve not/kanıt router'ları temel alınır.

## 1. Asıl soru ve mevcut dengesizlik

Araştırma nesnesi yalnız öğrenme güvenliği değildir: HERMES bir ajanı nasıl çalıştırıyor, sürdürüyor ve değiştiriyor? Kanıtların çoğu U01 review/curator/skill-onay/memory/worker ve UI çağırıcıları çevresinde derindir. A1 alt envanter ve diğer ailelerin açıklaması kısmi; HERMES-native alt-sistem sentezi henüz yoktu. Bu dağılım, ilk öğrenme kesitinin verimsiz olduğunu göstermez; yerel derinliğin bütün araştırma kapsamının yerine geçmemesini gerektirir.

Kaynak dosyasını listelemek, içeriğini okumak, mekanizmayı açıklamak ve davranışı çalıştırmak ayrı statülerdir. Plan sürümü, not sayısı ve senaryo toplamı ilerleme yüzdesi değildir. Yayın/uzlaştırma araştırma sürekliliğini sağlar ama yeni mekanizma kanıtı üretmez.

## 2. Eksikleri tek kategoriye koyma

| Sınıf | Örnek ve kanıt rotası | Karar etkisi |
|---|---|---|
| Açıklanmış fakat kapsamı sınırlı mekanizma | 02 review fork/snapshot; 03 bakım-consolidation ayrımı; 11 disk/live/frozen; 12/13 normal CLI-gateway store seçimi | Ara senteze koşullarıyla girebilir. Full product run yokluğu bunları değersiz yapmaz. |
| Açıklama zincirini kesen köprü | Q07/Q22 onaydan prompt/request'e; Q15/Q16 curator report/cron; ledger/restore/sync ve skill yeniden yükleme | İlk alt-sistem modelinin sürekliliği için yüksek öncelik. |
| Daha güçlü hüküm için ileri doğrulama | Q26/Q29 whole worker; gerçek UI fault injection; actual scanner; bütün concurrency/platform varyantları | Güvenlik/adoption/genelleme iddiası yük taşıdığında veya yeni kaynak erişiminde açılır. Bütün diğer araştırmanın ön koşulu değildir. |
| Henüz yeterince keşfedilmemiş aile | Session search/restore, provider/backend/delegation, scheduler, diğer UI, install/update/eval | Kapsam haritasında görünür tutulur; U01 kapanışından sonra değil, ilk ara sentezden sonra seçici topoloji taramasıyla önceliklendirilir. |
| Yayın borcu | Üçüncü AP teslimi | Yeni araştırmadan önce özgün bytes ve kaynak kimliğiyle kapatılır; tekrar test kotası üretmez. |

Açık soru kaydı bir kusur listesi değildir. Bir sorunun OPEN olması, ilk aşamada hiçbir şey bilinmediği anlamına gelmez; bilinen alt kapsam ve daha güçlü açık iddia birlikte tutulur.

## 3. Alternatif sonraki adımlar

| Seçenek | Kazanç | Sınır / neden şu anda değil? |
|---|---|---|
| Aynı A/SA/AP veya N senaryolarını çoğaltmak | Yeniden üretim ve regression sinyali | Şu an eksik olan yeni çağrı geçişini veya geniş kapsamı açmaz. |
| Q26 tam worker doğrulamasına bütün çabayı bağlamak | Güçlü izin hükmünün güvenini artırabilir | Tam original/bağımlılık şartları açık; mevcut hedef bir security certification değildir. Tüm çalışmayı buna kilitlemek orantısız. |
| Hemen bütün sistemi/4 alanı sentezlemek | Okunabilir tek açıklama | Bilinen geniş bölgeleri varsayımla doldurma ve ilk kesiti evrenselleştirme riski yüksek. |
| Derhal geniş envantere geçip U01'i bırakmak | Omission riskini azaltır | Birikmiş store/UI kanıtının en yakın kullanım köprüsünü açıklamasız bırakır. |
| AP kapanışı → bounded visibility → geçici alt-sistem sentezi → geniş topoloji kontrolü | Mevcut kanıtın anlamlı zincire dönüşmesi ve kapsam dengesinin geri kazanılması | Her alt adım açık sınır ve çıkış ölçütü taşır; sınırsız yeni hata dalına dönüşmez. Seçilen sıra budur. |

Bu sıra eski planı korumak için değil, sonuç değiştirme gücü ve mevcut kanıtın yeniden kullanım değeri nedeniyle seçildi. Yeni source başka kritik köprü gösterirse sıra gerekçesiyle revize edilebilir.

## 4. Visibility biriminin kabul ölçütü

Soru: kabul edilip diske yazılmış bilgi, mevcut CLI veya cached gateway ajanında hangi geçişte model için hazırlanan bağlama girer?

İzlenecek ayrı durumlar: pending payload; disk; live store; frozen snapshot; DB stored prompt; cached prompt; hazırlanmış messages/request. İlk somut kaynak `_restore_or_build_system_prompt`; bağlantılar invalidate/rebuild, compression/keep-prompt ve cache reuse/eviction.

Karşı olasılıklar açık: her tur reload, koşullu invalidation, yeni store ile eski stored prompt restore, CLI live ve gateway fresh apply nesnelerinin farklı ömrü. Her biri farklı sonuç verebilir; apply mesajı tek başına oracle değildir.

Ölçüm mümkünse zararsız çevrimdışı sınırda durur. Upstream gerçek işlevler, seçili/transkribe gövdeler ve sentetik DB/config/caller bileşenleri ayrı listelenir. Normal değişiklik, silme, yazma hatası, prompt restore ve explicit rebuild için hangi durumun gerçekten sınandığı kaydedilir. Negative control ölçülen özellik yanlış olduğunda kırmızı verebilmelidir. Bütün kombinasyonları sayısal kota olarak koşmak gerekmez.

Çıkış: hangi çağrının hangi görünümü yenilediğini ve bilinmeyen geçişin tam yerini kaynak/koşu ile açıklayabilmek. Tam gerçek outbound request'e erişilemezse selected prepared-messages deneyini onun yerine adlandırma. Kurulum/provider/credential sınırları aşılmaz.

## 5. Ara sentez ve genişlemeye dönüş

Geçici sentez, öneri üretimi → yetki/onay → değişiklik → görünürlük/yeniden kullanım → bakım/geri alma ilişkisini, her kenarın kanıt statüsüyle kurmalıdır. Henüz açılmamış ledger/sync/curator bağlantıları boş kenar olarak görünür; model bunları garanti saymaz. Bu HERMES'in nihai veya Foundation modeli değildir.

Ara sentezden sonra F01–F12 içinde kaynak-topoloji kontrolü yapılır: özellikle genel turn/context/session çekirdeği, tool/provider/backend/delegation, gateway/scheduler ve dağıtım/eval bölgeleri. Amaç bütün dosyaları kör okumak değil, hangi açıklanmamış mekanizmanın geçici modeli değiştireceğini bulmak. Ledger/skill-cache/curator araştırması bu çerçeveye bağlanır; U01'in bütün residual'ları kapanana kadar genişlik ertelenmez.

## 6. Dondurulmayan iddialar

Kalıcılaşma ≠ erişilebilirlik ≠ isteğe girme ≠ model tarafından doğru kullanım ≠ gelecek görevde fayda. Kullanım sayısı veya yazı değişimi kalite oracle'ı değildir. Tek caller davranışı bütün gateway/CLI/platformlara, in-process policy OS containment'a yükseltilmez. Görünürlük köprüsü çözülse dahi öğrenme kalitesi ve bütün HERMES kapanışı otomatik gerçekleşmez.
