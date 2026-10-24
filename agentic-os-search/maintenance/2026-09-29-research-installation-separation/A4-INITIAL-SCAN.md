> **Güncel yayın devamı §7’dedir.** Aşağıdaki §1–§6 önceki hazırlama turunun değişmemiş kaydıdır; eski bekleme ifadeleri güncel iş değildir.

# A4 — ilk tarama, tarihsel girişler ve yayın sınırı

**30 Eylül 2026 / REPO-SEPARATION-20260929.** Bu kayıt depo bakımıdır; DevOS kurulum planı veya mimari karar değildir. İlk hazırlanma durumu: **NOT_PUBLISHED**. Ana dal yayını ayrıca doğrulanmalıdır.

## 1. Dayanak ve sabit başlangıç

Başlangıç main `23b589703f0849c77a91e7b8c182ce16f8a38748`, root tree `fc2458047c8a6b6fcfeda076aeaecf3e093957a5`. REQUEST §5 ve REPOSITORY-TRANSITION §6–§7 kapsamında A4 başlatıldı. Kök bakım planı ve A3-ACCESS-GAPS tam okundu. A3 beş erişilebilir ve iki engelli kaynak ailesiyle kısmi kaldı; S00–S12 veya SOUL ve DevOS yerine belge üretilmedi. A2'nin tamamlanmış girişleri yeniden düzenlenmedi.

## 2. Envanterin gerçek kapsamı

| Alan | Yaprak dosya | Yeniden hesaplanan ve uzakta eşleşen Git ağacı |
|---|---:|---|
| development-os/ | 19 | e3a104adc534aa5f4caf10f4252b000aae94731b |
| explorations/EXP-006-development-os-calisma-duzeni/ | 50 | aaaa2f0764b42c896315ed7b2fbb5d013da27e7f |

69 yol/mode/blob/boyut kaydı A4-SCOPED-INVENTORY.json içindedir. Envanter ağaç kimliği, yapraklardan alt dizinler yeniden kurularak hesaplandı. Bir dosya çıkarılan olumsuz kontrolde eşitlik bozuldu. Kimlik denetimi yol/mode/blob kümesini bağlar; boyutlar GitHub metadata'sından alınmıştır, 69 gövdenin byte'ları bu tur yeniden indirilip ölçülmüş değildir.

Kök recursive ağaç API'den `truncated=false` döndü, ancak dev araç görünümü yerel tam dosya manifestine dönüştürülüp bütün yapraklarla mutabık kılınmadı. Bu nedenle **deponun tam envanteri veya tam taraması tamamlandı denmez**. Research kökü ve explorations kökü alt-ağaç seçimi için okundu. Diğer araştırma alanlarının gövdeleri bu tur taranmış sayılmaz.

## 3. Tam okunan sekiz kaynak ve sonuçları

| Dosya | Sonuç | Gerekçe |
|---|---|---|
| `explorations/EXP-006-development-os-calisma-duzeni/history/README.md` | PREPEND_PENDING | Tarihsel statü zaten açık; eski “Current authority” yolunu güncel DevOS yetkisinden ayıran not ve üç sabit kaynak bağlantısı eklenir. |
| `explorations/EXP-006-development-os-calisma-duzeni/history/2026-09-25-pre-work-system-INDEX.md` | PREPEND_PENDING | Doğrudan açıldığında güncel okuma yolu gibi görünür; STATE/Context/Work Map ve araştırma bağlantıları taşınan dosyanın eski göreli tabanındadır. |
| `explorations/EXP-006-development-os-calisma-duzeni/history/2026-09-25-pre-work-system-STATE.md` | PREPEND_PENDING | Güncel durum başlığı, OPEN durumu, sonraki yetkili hareket ve artık mevcut olmayan EXP-006_Work_Map.md yetki anlatımı tarihsel anlık görüntüye bağlanır. |
| `explorations/EXP-006-development-os-calisma-duzeni/history/2026-09-25-pre-split-WORK-MAP.md` | PREPEND_PENDING | Şimdi yalnız B1 açılacaktır ifadesi ve ilk rol akışları tarihsel aday modeldir; güncel ürün iş listesi veya rol topolojisi olarak devralınmaz. |
| `explorations/EXP-006-development-os-calisma-duzeni/sources/U001.md` | KEEP | Konuşmacı, tarih, kaynak türü ve aktarım sınırı başta açık; kullanıcı sözleri yeni talimat değil tarihsel alıntıdır. Yazım korunur. |
| `explorations/EXP-006-development-os-calisma-duzeni/sources/U002-cloud-plan-and-autonomy.md` | KEEP | 27 Eylül kullanıcı aktarımı açıkça etiketli; üç mesaj kod bloklarında, eski URL yazımları özellikle korunmuş. Sonraki STATE/HANDOFF/DECISIONS yönleri D030 ile güncellenmiş; kaynak gövdesi yeniden yazılmaz. |
| `development-os/attempts/001/evidence/W02-D01/probe.py` | KEEP | Sabit eski repo/commit ve sentetik tanılama kapsamı açık; komut örnekleri log verisi. Eski kod çalıştırılmadı; kullanım örneği yeni yürütme yetkisi sayılmadı. |
| `development-os/attempts/001/evidence/W02-D01/result.json` | KEEP | Tarih, kaynak kimliği, sentetik veri ve sınırlamalar mevcut. Eski üç başarısız örnek gizlenmedi; yeni test başarısı gibi sunulmadı. |

İlgili source okuma izleri: GitHub sonuçları 800 (history README), 802 (INDEX), 808–810 (STATE, kesilen sınır tamamlandı), 811–817 (WORK-MAP, baştan sona), 803–804 (U001/U002), 806–807 (iki sentetik kanıt dosyası). D030'nun ilk 40 satırı, hedef anchor ve yetki sınırı için ayrıca okundu; karar sicilinin tamamı bu tur yeniden tam okunmuş sayılmaz. Önceki protokol ve plan okumaları bu sekiz kaynak sayısına katılmadı.

## 4. Tarihsel bağlantı çözümü

INDEX dosyasının history konumundaki doğrudan `STATE.md`, `EXP-006_Context`, `EXP-006_Work_Map.md`, `sources/U001.md` linkleri o klasörde bulunmuyor. İlgili history envanteri yalnız üç snapshot ve README içeriyor. Diğer eski göreli araştırma bağlantıları da özgün dizin bağlamından çıkmış durumdadır; hepsinin hedefi bu tur tek tek sınanmadı.

INDEX'in path-geçmişinde `d37cd1876fb4089541061ce2f832950cf46f59e6` koruma commit'i ve parent `8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e` bulundu. Bu parent'ın özgün EXP-006 dizininde üç eski kaynak aşağıdaki aynı kimliklerle gözlendi:

| Snapshot | Özgün konum | Git blob | Byte |
|---|---|---|---:|
| `history/2026-09-25-pre-work-system-INDEX.md` | [INDEX.md](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/INDEX.md) | `e27aacbf86992c150e96665af3dffba4c18a3f23` | 5510 |
| `history/2026-09-25-pre-work-system-STATE.md` | [STATE.md](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/STATE.md) | `c074998b3c3a874b09ba3c0c19317dc62f336b05` | 16438 |
| `history/2026-09-25-pre-split-WORK-MAP.md` | [EXP-006_Work_Map.md](https://github.com/batuhanozgun/agentic-os-search/blob/8e2d34ce14ec93d12af58ff52046ec6c4cc15d6e/explorations/EXP-006-development-os-calisma-duzeni/EXP-006_Work_Map.md) | `bfdc8c64896e34126cdbe8058cb6c0493c442631` | 29860 |

Bu, aynı gövdeyi eski göreli dizin tabanında açmak için kanıtlı dönüş yoludur; “eski metindeki bütün bağlantılar sağlamdır” hükmü değildir. Tarihsel kaynağın kendi `\n` yazımı ve eski yönleri korunur. Yeni notlar hem bu dönüşü hem güncel D030/harici plan sınırını taşır. Snapshot içi linkleri veya araştırma metnini yeniden yazmak yerine gövde dışı yönlendirme kullanıldı.

## 5. Değişiklik ve kanıt sınırı

Dört kaynak dosyası yalnız UTF-8 önek byte'ları eklenerek değiştirilmeye adaydır. `new_bytes = prefix_bytes + original_bytes`. Üç snapshot için altışar satır; history README için tarihsel kimlik eşlemesi içeren önek. İki bakım kaydı (bu dosya ve 69 yol envanteri) eklenir; kök planın ilerleme/devri güncellenir. Hiçbir kaynak dosyası silinmez, taşınmaz veya gövde içinde yeniden yazılmaz. U001/U002, probe.py/result.json, araştırma alanları, yüklenen arşiv, SOURCE-IDENTITIES, MOVES ve kontrol dosyaları korunur.

Çıkarımlar belge düzeyindedir. Yeni bir bağımsız Claude okuyucu deneyi, PDF denetimi, eski kod çalıştırması, yeni DevOS yeterlik ölçümü veya genel kök-neden araştırması yapılmadı. Aynı yazarın incelemesi bağımsız doğrulama değildir. Git ağacı denetimi yalnız envanter iddiasını sınar.

## 6. Yayın durumu ve devralma

Hazırlama sırasında GitHub okuması çalışırken önceki yazma eylemleri keşifte sunulmadı. create_tree/create ve update_ref aramaları yazma şeması getirmedi; kurulu GitHub eklentisi araması ek yazma yolu sağlamadı. Terminal GitHub/Raw erişimi ad çözümlemesinde başarısız oldu. Bu, deponun salt okunur yapılandırıldığı veya kalıcı olarak yazılamadığı iddiası değildir; bu turda çalışan yazma yolu yoktur.

**Bu tur uzak main değiştirilmedi.** NOT_PUBLISHED işaretli dış teslim paketi canonical repo planının yerini almaz; yazma imkânı olduğunda aynı başlangıca bağlı değişiklikler doğrulanıp tek yayın olarak uygulanır. Önce güncel main/delta ve yazar kontrolü yapılır. Makine hesabı commit'i görülürse Batu'ya bildirilmeden düzeltme yapılmaz. Güncel main değişmişse hazırlanmış dosyalar körlemesine basılmaz; etkilenen kayıtlar uzlaştırılır. Kaynakların eski blob'u eşleşmeden önek uygulanmaz. Yayından sonra ref, dört kaynak gövdesinin öneksiz eşliği, iki yeni kayıt ve kök devam yolu geri okunur.

**Tek devam:** önce bu bekleyen ilk A4 güncellemesinin yayın/geri okumasını sonuçlandır; sonra planın kalan tam envanter ve içerik taramasını sürdür. EXP-006 work/ içindeki B1–B9 ve S1 kayıtları 69-yol envanterinde yer alır ama bu tur gövde bakımından okunmadı. Diğer repo alanları, kapsamlı iç bağlantı taraması, gerekli ZIP/belge içerikleri ve A5 açık. A3'ün iki erişim engeli korunur; aynı ZIP tekrar istenmez.


## 7. Yayın devamı — önceki engelin aşılması

**30 Eylül 2026, sonraki tur.** §1–§6 ve envanterdeki `at_preparation` alanları önceki hazırlamanın tarihli kaydıdır; bu bölüm onların yayın bekleme durumunun yerine geçer. Güncel tek devam noktası [kök bakım planındadır](../../REPOSITORY-TRANSITION.md). Eski NOT_PUBLISHED cümlesinden yeni yükleme veya yeniden hazırlık işi çıkarılmaz.

Güncel main hâlâ `23b589703f0849c77a91e7b8c182ce16f8a38748` idi. Aynı ref üzerinde makine hesabı için author ve committer sorguları boş döndü; bu, bütün dallarda veya alternatif kimliklerde yokluk iddiası değildir. Kontrol girişi ve bakım planı canonical sürümden okundu. Yerel ZIP'in 8 manifest girdisinin tamamı boyut/SHA-256 ile eşleşti; kayıt denetleyicisi iki alt ağacı yeniden kurdu ve yaprak çıkarma olumsuz kontrollerinde eşitlik bozuldu. Tarihsel araştırma veya deney kodu çalıştırılmadı.

GitHub create_tree/create_commit işlemleri bu tur çalıştı. Kaynak-only doğrulama adayı `22da50718d9933da33661cbdf46ff2ce50cee442`, tree `978f5257fbbf208629e888eed3b8287f0f289a81`, parent yukarıdaki başlangıçtır. Tam birleşik fark yalnız dört kaynakta **39 başlangıç satırı eklenmesi, 0 çıkarılan satır** gösterdi; gövdelerde veya dosya sonlarında fark kalmadı. İlk yayımlanmamış `b4d4854de270bb2630e2962985ef06860e5674bc` adayında görülen iki son-LF kaybı bu adayda giderildi. Aday commit bir main yayını değildir; nihai yayın aşağıdaki bakım kayıtlarıyla aynı ağaçta yapılır.

| Kaynak (`history/` altında) | Doğrulanmış yeni Git blob | Byte |
|---|---|---:|
| `2026-09-25-pre-work-system-INDEX.md` | `c084ad013751a3b834c5f9bfa226e8ab30402e50` | 6468 |
| `2026-09-25-pre-work-system-STATE.md` | `e69da7b9d57c9e35ffdc1b8152df1759feba25f4` | 17405 |
| `2026-09-25-pre-split-WORK-MAP.md` | `708504323690847456fa29e7514eece8ed6cddbc` | 30833 |
| `README.md` | `f0bde6c011e2c8268bfbc16f38c186185c8e8020` | 3414 |

Dört yeni boyutun her biri, bekleyen değişiklik tanımındaki özgün boyut + UTF-8 önek boyutuyla eşleşti; toplam önek 5.426 byte. Yeni yönlendirmeler D030, history kaynak haritası, bakım planı ve aynı gövdenin sabit eski konumlarını gösterir. İç gövde linklerinin tamamı sağlam ilan edilmez; §4'teki sınır sürer.

**Bekleyen paketle iki kayıt farkı:** Dört kaynak öneği aynen uygulandı. Bakım raporuna bu yayın devamı eklendi; kök planın yayın/sonraki iş bilgisi buna göre güncellendi. Envanter ise aynı 69 yol/mode/type/blob/boyut ve sekiz okuma/koruma kararını koruyan daha küçük şema 2 ile yayımlandı; kaynak araştırma değişmedi. Özgün envanter 27.252 byte, SHA-256 `89ab9481219484b09a4032ffcd667c2624435c582eb2f4a35a2211d0fe824b02`; yeni envanter 11.535 byte, SHA-256 `6af078a8dd4f8e9c6d67da7761bc7a5d28cac73610ad735d6c15b73525b34d58`, Git blob `40f848a289e734d71cb127cf83b37541a6b20792`. Dönüşümün yol/kimlik/boyut eşliği yerelde karşılaştırıldı; uzak blob aynı çıktı. `PREPEND_PENDING` ve eski kaynak hash'leri başlangıç anını anlatır; bu tablodaki yeni hash'lerin veya güncel durumun yerine kullanılmaz.

**Yayın kapsamı aynı yedi yoldur:** dört history kaynağı; bu rapor; A4-SCOPED-INVENTORY.json; REPOSITORY-TRANSITION.md. Araştırma, kontrol, arşiv gövdeleri veya başka depolar değiştirilmez; silme/taşıma yapılmaz. Nihai aday farkı, main ilerlemesi/yazarlar ve yayın sonrası ref/dosya geri okuması ayrıca kontrol edilir. Aynı yazarın belge incelemesi bağımsız Claude okuyucu sınaması değildir.

**Devam:** İlk dört statü/yön düzeltmesinden sonra A4'ün tam repository envanteri ve kalan içerik/bağlantı taraması. 69 yol ve önceki sekiz tam okuma yeni turda yapılmış ek okuma sayılmaz. EXP-006 B/S1 gövdeleri, diğer alanlar ve gerekli ZIP/belge içleri henüz taranmış değildir. A4 ve A5 kapanmadı; A3'ün iki kaynak erişim engeli korunur.
