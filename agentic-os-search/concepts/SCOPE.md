# Concepts — Seri çıkarım kapsamı

Kapsam sürümü: S1, 2026-09-19. Yöntem: v0.3-working. Bu dosya B5'in kaynak kapsamı ve iş sırası kaydıdır; araştırma bulgusu, ortak kavram şeması veya bütün dosyaların okunmuş olduğu iddiası değildir. Güncel etkin iş STATE.md'de, paket içi gerçek okuma ve çıkarım durumu ilgili READING.md'dedir.

## 1. Sabit kaynak evreni

Repository: batuhanozgun/agentic-os-search. Kaynak commit: **9b46155e904560c90b89e657f3d0d4e00e2e46cf**. Kapsam: bu commit'teki **research/studies/** ağacının tamamı; yalnız tamamlanmış araştırmalar veya katalogda öne çıkarılmış dosyalar değil.

- Studies Git tree: **f51a44bf86ca25a0025f248e5116faae1ed3933a**.
- [Sabit kaynak dizini](https://github.com/batuhanozgun/agentic-os-search/tree/9b46155e904560c90b89e657f3d0d4e00e2e46cf/research/studies).
- [Kanonik, yapraklara kadar genişletilebilir dosya manifesti](https://api.github.com/repos/batuhanozgun/agentic-os-search/git/trees/f51a44bf86ca25a0025f248e5116faae1ed3933a?recursive=1).

Dosya evreni Git ağaçlarıyla hiyerarşik olarak sabitlenir. Aşağıdaki her tree kimliği, yalnız klasör adını değil o sürümdeki bütün alt dizin/dosya yollarını, kiplerini ve içerik kimliklerini bağlar. Büyük özyinelemeli yanıtın kesilmiş bir ekran görüntüsü tam liste yerine kullanılmaz. Paket işlenirken kendi ağacı kesintisiz genişletilir; bütün yapraklar yerel READING.md envanterinde tek tek karşılık bulur. Böylece global dosyada yüzlerce yolun ikinci, zamanla ayrışan bir kopyası tutulmaz; kapsamdan tek bir alt dosya dahi örtük biçimde çıkarılmaz.

B5'te kökün bütün 34 girdisi (31 dizin + 3 dosya) doğrudan alındı. Aşağıdaki yol/kip/SHA kayıtlarından Git tree nesnesi yerelde yeniden hesaplandı ve f51a44bf… ile tam eşleşti. Carbon videos ağacının üç girdisi de aynı yolla 95119e3a… ile eşleşti. Bu mekanik kontrol aktarılmış kapsam kimliklerini doğrular; dosya içeriklerinin okunmasını, bütün iç başlıkların anlaşılmasını veya araştırmanın teknik doğruluğunu doğrulamaz. Bütün korpus için yaprak dosya sayısı ya da okuma yüzdesi ilan edilmez.

## 2. Birimler, sahiplik ve çift saymama

31 fiziksel kök dizin: 29 ayrı araştırma paketi, bir koleksiyon, bir emekli taşınma dizini. Koleksiyonun üç video dosyası ayrı yerel çıkarım alanlarına sahiptir. Dolayısıyla çalışma kaydı **33 çıkarım birimi** içerir: 29 kök araştırma + 1 koleksiyon düzeyi + 3 video. Bu sayı 33 bağımsız kanıt veya 33 tamamlanmış çalışma demek değildir.

Bir fiziksel dosyanın çıkarım sahibi en özel kayıtlı kaynak önekidir. Carbon koleksiyonunun kendi dosyaları koleksiyon düzeyinde; videos/<id>/ altındakiler ilgili videoda işlenir. Koleksiyonun çocuklara atfı, çocuğun dosyalarını ikinci kez bağımsız destek yapmaz. Sonradan başka bir iç araştırma sınırı bulunursa sahiplik gerekçeli biçimde ayrıntılandırılır; eski kapsamdan dosya düşürülmez.

work-management-project-control ile openproject, flowable, beads, openspec, spec-kit, leantime, gastown ve erpnext arasındaki bağ karşılaştırmalı araştırma ilişkisidir. Fiziksel olarak kardeş paketlerdir; birinin okunması diğerini tamamlamaz. Benzer biçimde bir pakette gstack/Hermes/Foundation atfı bulunması, atfedilen korpusun burada yeniden okunmuş olduğu anlamına gelmez.

## 3. Kök manifesti

Yollar research/studies/ tabanına göredir. Tüm dizinlerin kipi 040000; üç dosyanın kipi 100644'tür. Her tree, /git/trees/<SHA> uç noktasından gerektiğinde alt ağaçlara ayrılarak genişletilir. Tablo, kaynak evreninin sürümlü manifestidir; sıralama veya ilerleme tablosu değildir.

| Yol | Tür | Git kimliği |
|---|---|---|
| CATALOG.md | kütüphane desteği / blob | d6eaabdda63a86f2318453e0850b689f900b85d4 |
| INDEX.md | kütüphane desteği / blob | d036c4844fb3bb9264f5951d680ad1a5f5c33545 |
| PACKAGE-CONTRACT.md | kütüphane desteği / blob | 78b2e385d81cc3f918f415326555be4e5a5f6cbb |
| agent-memory-providers | tree | 2824fd177d9aafbe4123a0298c8198099975cf3a |
| agentic-ai-systems-roadmap | tree | 01ebba4f55dc467917f22c6031214745e48856c2 |
| ai-knowledge-strategies | tree | fe7c1fb59098c25e764ee221ca51277916d28627 |
| ai-memory | tree | cb80d48ff991ace584ee854246437821d6f536fe |
| anthropic-ai-native-sdlc-playbook | tree | 52c9854c87e3464a3dc6440aacd6874597ca478c |
| beads | tree | 6f956131a8f3892c03bad379072e8f9b4df5de42 |
| context-memory-harness-engineering | tree | e32d7736c4a3b31f123ab84eaafe053b0b2ca08e |
| context-mode | tree | 20d58eb5885181b49d42f859350097818f6219ef |
| deepseek-harness | tree | fa2a539703c78d3d0186d1468c61a2b07732bc7f |
| ecc | tree | 98869311544972e79703a5fbb2ac70a46412fcfa |
| erpnext | tree | 7459e2aac20a052aba864fb8acad5ad34308ac90 |
| flowable | tree | 1aff03918bfdd7453c222ccd59913d6aedf7a357 |
| gastown | tree | 1f0dee524005f7286cf477becf512b0ec5779552 |
| gstack | tree | 0a89c7d971fe3bdcb517b8317a172e8bd64f2364 |
| hands-on-large-language-models | tree | 555ef58fb54f2108d209c0c8dbca5bf3af1a0c72 |
| harness-engineering-and-evolution | taşınma desteği / tree | efbd3a1fe7c217dbd4ae9f54299ddc78bdb36b6d |
| hermes-agent | tree | f3a79c733afffd41a64df6eff7f790aeb929212c |
| i-have-adhd | tree | 6309b9091b3e4a85a4ae5ff4d57d807efc57ffd4 |
| leantime | tree | 912fe9f492426926a52e0f499376979312ef8600 |
| llm-wiki | tree | 80fb9c7310259287e908ca726838a9229809c0ea |
| mattpocock-skills | tree | e40c85114a5d2e9225720ba4b553d90244d803cb |
| multi-agent-patterns | tree | 7335832f5ce33cd5e9306b5c04d19a840208cace |
| openproject | tree | 51ff7d23fdf3e1ed5d4781fed8670fd89bf06d9d |
| openspec | tree | 18b047e83a901f608509a677c5e0b996be1bb3f6 |
| openviking | tree | 9e2c3a7c89656c61620e22d124d49b5129d8d843 |
| public-apis | tree | a7560c3a2a54c7901b37622fba3d94de4bae6aef |
| recursive-prerequisite-discovery | tree | 4673f46465704c080b2d5072ce0f71527ebdf284 |
| spec-kit | tree | 168ee6b4eed8d2f6ab445250124c07bb7b8cf12b |
| superpowers | tree | 56c19a5e2c0deb7b0f5164aac818ed2ba98baf12 |
| the-carbon-layer | koleksiyon / tree | b6bbd96d68dffc29491a257b07e6da3f0998988a |
| work-management-project-control | tree | 083ac583757e006822c01131a3a8d77bb0d35f23 |

### Carbon çocuk manifesti

Ara dizin the-carbon-layer/videos tree: **95119e3aa346696bd23b53c02fa945af383b0ad2**. Gerçek kök/güncel META/STATE ve video dizini birlikte kontrol edildi.

| Kaynak öneki | Tree |
|---|---|
| the-carbon-layer/videos/mQfTdNVCOB0-harness-engineering | d7a4e84b327fe7f206550c67dfb6c2f418c4a230 |
| the-carbon-layer/videos/-01_NB4SbBY-agent-sandboxing | c31b62f2a8777f26cbcd40552e073452ddce6b0e |
| the-carbon-layer/videos/PxuMqeIqCEo-agent-memory | 7b6cb737e90d6c0c7c396af37adf9e442f864f7b |

Koleksiyon düzeyi, bu üç önekin dışında kalan bütün dosyaları içerir; örneğin kendi yöntem, katalog, göç ve syntheses girişleri. Çocukların mevcut araştırma olgunlukları farklıdır. Birinci çocuğun eski adı başka paket yaratmaz.

## 4. Seri sıra ve iki ayrı durum

Aşağıdaki araştırma durumları, S1 snapshot'ındaki CATALOG.md beyanlarının kısaltılmış keşif gösterimidir; bütün paketlerin META/STATE dosyalarının bu tur tek tek okunup doğrulandığı iddia edilmez. İşlenecek her pakette güncel META/STATE/INDEX ve sürüm farkı önce geri kazanılır. Kaynak araştırma durumu yalnız kendi canonical yüzeyinden alınır. Bu tablo onun yerine geçmez.

Concepts sütunu S1 başlangıcını gösterir: ilk iki paket yalnız konuşma pilotu tamamlanmış, diğerlerinin çıkarımı başlamamıştır. Kalıcı ilerleme kendi READING.md'sinde ve global STATE'de izlenir; bu başlangıç tablosu ikinci current-state kopyası değildir. Sıra kavram hiyerarşisi değildir: önce erişilebilir pilotlar aktarılır, sonra kaynak ilişkili kümeler ele alınır; gerekçeli değişiklik STATE'de gösterilebilir.

| Sıra | Kaynak birim | Kaynak araştırmanın keşif durumu | S1 başlangıcında concepts |
|---|---|---|---|
| 01 | context-memory-harness-engineering | bounded complete; değerlendirme bekliyor | P1 kapalı; kalıcı aktarım ilk iş |
| 02 | superpowers | bounded complete / user accepted | P2 kapalı; kalıcı aktarım bekliyor |
| 03 | ai-knowledge-strategies | bounded complete | başlamadı |
| 04 | multi-agent-patterns | exploratory assessment complete | başlamadı |
| 05 | anthropic-ai-native-sdlc-playbook | bounded complete | başlamadı |
| 06 | gstack | bounded complete; kayıtlı revalidation sınırı var | başlamadı |
| 07 | hermes-agent | active / partial | başlamadı |
| 08 | ecc | active / partial; eşzamanlı değişiyor | başlamadı |
| 09 | work-management-project-control | bounded complete / review ready | başlamadı |
| 10 | openproject | bounded source slice complete | başlamadı |
| 11 | flowable | bounded source slice complete | başlamadı |
| 12 | beads | bounded source slice complete | başlamadı |
| 13 | openspec | bounded source slice complete | başlamadı |
| 14 | spec-kit | bounded source slice complete | başlamadı |
| 15 | leantime | bounded source slice complete | başlamadı |
| 16 | gastown | bounded source slice complete | başlamadı |
| 17 | erpnext | bounded source slice complete | başlamadı |
| 18 | recursive-prerequisite-discovery | bounded assessment; özgün kaynak erişim sınırı var | başlamadı |
| 19 | hands-on-large-language-models | bounded repository research complete | başlamadı |
| 20 | public-apis | bounded general assessment | başlamadı |
| 21 | agentic-ai-systems-roadmap | discussion-open seed | başlamadı |
| 22 | the-carbon-layer — koleksiyon düzeyi | active collection | başlamadı |
| 23 | the-carbon-layer/videos/mQfTdNVCOB0-harness-engineering | open / partial | başlamadı |
| 24 | the-carbon-layer/videos/-01_NB4SbBY-agent-sandboxing | first investigation complete / suitable | başlamadı |
| 25 | the-carbon-layer/videos/PxuMqeIqCEo-agent-memory | first investigation complete / review ready | başlamadı |
| 26 | agent-memory-providers | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 27 | ai-memory | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 28 | context-mode | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 29 | deepseek-harness | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 30 | i-have-adhd | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 31 | llm-wiki | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 32 | mattpocock-skills | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |
| 33 | openviking | planned; araştırma başlamadı | mevcut kayıtların çıkarımı bekliyor |

Planlı paketler kapsam dışı değildir. Var olan kayıtlar tam okunur ve içerdiği kullanımlar uygun statüyle çıkarılır; yapılmamış araştırma yerine dış hedef yeniden araştırılmaz. Mevcut dosyaların çıkarımının kapanması o araştırmanın yapılmış olduğu anlamına gelmez. Yeni bulgular sonra delta olarak ele alınır.

## 5. Ortak destek ve taşınma kayıtları

CATALOG.md (1–45, 46–70, 71–EOF), INDEX.md ve PACKAGE-CONTRACT.md B5'te tam okundu. Kütüphane yönlendirme/sınıflandırma dilidir; ikinci bağımsız araştırma veya bütün paketlerin içerik okuması değildir. Katalog ile gerçek kök manifesti karşılaştırıldı: 30 güncel kök paket, üç çocuk satırı ve katalogda ayrı araştırma yapılmayan emekli yol açıklanıyor.

Library INDEX'in Superpowers satırındaki active/partial ifadesi, katalog ve paketin kabul edilmiş STATE'inden eski. Bu SCOPE onu current authority saymaz; paket durumu önceliklidir. Özgün studies dosyaları bu iş için yeniden yazılmadı.

Emekli harness-engineering-and-evolution dizininin dokuz dosyası gerçek ağaçta korunur: 00-WHY-THIS-RESEARCH.md, BRIDGE-QUESTIONS.md, INDEX.md, META.md, METHOD.md, README.md, RESEARCH-PLAN.md, SOURCE-LEDGER.md, STATE.md. README tam okundu; yönlendirme rolü koleksiyon META/STATE ve library INDEX ile tutarlı. Diğer sekiz pointer'ın tam içerik kontrolü Carbon okumasında yapılacak ve koleksiyon READING'ine destek kapsamı olarak yazılacak. Bu kayıtlar atılmadı; ayrıca ikinci terim paketi oluşturulmayacak.

Kaynak medyanın Git dışında tutulduğu yerlerde mevcut kayıt ile gerçek medya ayrı tutulur. Carbon META/STATE özgün medyanın önceki konuşma varlığı olduğunu ve gelecekte erişimin garantili olmadığını söylüyor. Medya hash'i, tam video/ses erişimi değildir. Paket işlenirken eldeki temsil ve erişilemeyen gerekli malzeme açıkça kaydedilir; gerekirse ilgili kapsam açık kalır. Dış bağlantıların tümünü yeniden araştırma yetkisi doğmaz.

## 6. Pilotların sürüm ve aktarım kaydı

P1 özgün kaynak commit'i **ac64fb9223cfa797e7eaabcdcbbf8bac3cc3ef0a**. Bu ref'teki paket contents yanıtının sekiz path/blob kaydı, S1'in e32d7736… ağacındaki sekiz dosyayla aynı. Bu kapsamda kaynak delta'sı yok. Pilotun P1-T1/T2/T3 ekleri ve düzeltmeleri korunarak aktarılır; kalıcı dosyanın varlığı veya tamamlanması ayrıca yerel READING'de gösterilir.

P2 özgün kaynak commit'i **75bc6787844e9b1a8fed76ff5cfa4ca8ce63d847**. Pilotun kaydettiği 56c19a5e… paket ağacı S1'de aynı; 52 dosyalık pilot kapsamı değişmemiştir. P2-T1–T5 çıktıları ve bütün ek/düzeltmeler aktarımda birlikte ele alınacak. Bugün dış Superpowers sürümünün güncelliği veya ürün davranışı yeniden doğrulanmış değildir.

Pilotların tamamlanmış oluşu kalıcı B6 aktarımını yapılmış göstermez. Aynı içerik sırf yeni aşama diye yeni bir ürün araştırmasına dönüştürülmez. Özgün konuşma metni erişilemiyorsa gerekli kullanımlar sabit kaynak üzerinden yeniden çıkarılır ve bu yeniden üretim açıklanır; STATE özetiyle terim listesi uydurulmaz.

## 7. Değişen korpus ve geçiş kontrolü

S1, kapsamı izlenebilir kılan başlangıç sürümüdür; kütüphaneyi sonsuza kadar dondurma veya sonradan eklenenleri dışlama kararı değildir. Her paket başında ve kapanışında main ile kayıtlı kaynak tree/blob'ları karşılaştırılır. Yeni, değişmiş, silinmiş veya taşınmış yollar ayrı delta kaydına alınır. Kaynak değişikliği ilgili kullanıma ve eski çıkarımın geçerliliğine etkisiyle işlenir. Aynı isimli yeni içerik eski okuma olarak gösterilmez.

Özellikle ECC eşzamanlı araştırmadır. Başka oturumun yazdığını geri almak, onun state'ini concepts adına değiştirmek veya eski dosyanın üstüne kontrolsüz yazmak yoktur. Yayın sırasında S1 sonrası delta varsa current STATE'de açıkça kaydedilir; o delta sonraki paket/güncelleme işine bağlanır.

B7 öncesinde S1 ile güncel studies ağacının tamamı yeniden karşılaştırılır. 33 birimin her birinin kapsanan dosya/temsil ve kullanım durumu, kök destek/pointer dosyaları, olası yeni çocuklar ve yeni paketler hesaba katılır. Açık kaynak okuması veya aktarım eksiği varsa B8 başlamaz. Bütün kayıtları birlikte okumak ortak referans aşamasının başlangıcıdır; SCOPE veya çalışma sırası hiçbir ortak terim anlamını kabul etmez.

## 8. B5'in teslim sınırı

B5 kaynak evrenini, sahipliği, geri çağrılabilir tam dosya manifestlerini, pilot deltalarını ve seri sırayı kurdu. Her paket içindeki bütün yaprak adlarının global metne ikinci kez açılması ve içeriklerinin okunması yapılmış sayılmıyor; kaynak manifesti ile yerel okuma/çıkarım ayrı yüzeylerdir. B6 yerel READING envanteri kurulmadan o paketi tamamlandı işaretleyemez.

Bu kayıt aynı assistant'ın kaynak/ağaç karşılaştırması ve mekanik tree aktarım kontrolüdür; bağımsız kavram doğrulaması veya yeni-oturum davranış testi değildir. Araştırma, agent-control, Foundation ve mimari sınırları değişmedi.
