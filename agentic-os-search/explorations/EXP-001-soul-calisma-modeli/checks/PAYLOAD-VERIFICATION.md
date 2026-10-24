# EXP-001 — Kullanıcı yüklemesinin içerik kimliği denetimi

**Tarih:** 2026-09-10.  
**Hüküm:** 32/32 beklenen dosya doğru yolda ve özgün içerikle eşleşen Git kimliğinde. Eksik yol: 0; içerik/yol uyuşmazlığı: 0.  
**İddianın kapsamı:** Dosya aktarım bütünlüğü. Diyalogun ham platform kaynağına sadakati, Atlas UI'sinin yeni bir çalıştırması veya SOUL etkinliği değildir.

## 1. Bağımsızlaştırılan kaynak ve hedef

Önceden hazırlanmış ve kullanıcıya verilen kaynak:

- `EXP001_Artefakt_Tamamlama_Paketi.zip` — 3.416.116 byte.
- SHA-256: `054983b46aaa6ac33b226445ce194c1125ff89e5a7a1e4bdbc11cb579783a5a2`.
- İç PAYLOAD-MANIFEST.json SHA-256: `f694d43923ec28e190f985aa30de6b9eefbe739bd00f0c773695785ee1a9e42c`.
- Manifest önceden her payload için yol, boyut, SHA-256 ve Git blob SHA-1 taşıyordu. Hedef yükleme görüldükten sonra beklenen içerikler değiştirilmedi.

Denetlenen GitHub hedefi:

- Repository: `batuhanozgun/agentic-os-search`.
- Kullanıcı yükleme commit'i: `a3987312bbfbb8aa0fbf4ea6fd8a1113d467f415`.
- Ebeveyn: `26067fc364f9813683aa5c4ebc6435279eeceb8e`.
- Root tree: `9309246f6b1fc1a7d766104399112f82d2e99315`.
- Explorations tree: `47824f1ed6607e73f7cefb17fec5cb4f268d3aca`.
- EXP-001 tree: `242d576756d3e026e2d6459163ac02e6a367b939`.

Main ref'i, commit→tree bağı ve ilgili alt ağaçlar GitHub connector'üyle okundu. Parent→upload compare tam olarak 32 beklenen yeni dosyayı gösterdi; başka dosyada değişiklik yoktu. Yalnız ZIP adının bulunmasına veya kullanıcı beyanına dayanılmadı.

## 2. Yerel kaynak denetimi

ZIP CRC kontrolü sağlam. Manifestin ve 32 payload'ın byte içerikleri yerel özgün ZIP'ten okundu. Her dosya için boyut, SHA-256 ve `SHA1("blob " + byte_length + NUL + bytes)` yeniden hesaplanıp önceden verilmiş manifestle karşılaştırıldı: 32/32 eşleşme. Toplam 6.176.086 byte.

Ardından gerçek kaynak byte'larından Git tree nesneleri yeniden hesaplandı: dosya modu, dosya adı ve blob kimliği; alt dizinlerde bunlardan oluşan tree kimliği; Git'in isim sırasına göre dizilmiş binary kayıtlar. Dosyalar yeniden üretilmedi veya metin normalizasyonuna sokulmadı. Modlar payload için 100644, dizinler için 40000 olarak hesaplandı.

## 3. Remote kimlikleriyle eşleşen kapsam

Yollar paket köküne göredir. Aşağıdaki kimliklerin her biri hem yerel hesapta hem GitHub'dan okunan snapshot'ta aynıdır.

| Alt ağaç / dosya | Kapsadığı dosya | Eşleşen Git kimliği |
|---|---:|---|
| artifacts/consolidation-v0.1 | 2 | 988c190920f721ba99085f8e3a35c34bfeac4a24 |
| artifacts/mechanism-atlas-v0.1 | 29 | 5288bf7583f4e7af3e4c6006eeca509b850ce061 |
| artifacts/mechanism-atlas-v0.1/source | 26; üst satırın içinde | a3dcce0f21849f6e4d37365446a2d429993c6fd6 |
| artifacts/mechanism-atlas-v0.1/source/dayanak | 1; source içinde | 102e3b7f7f54208a9ae2c6ef2051909251cd16e3 |
| artifacts/mechanism-atlas-v0.1/source/gorseller | 14; source içinde | 3a6fd6255a9f31398980a94af627a04939f889c4 |
| sources/original-sketch.png | 1; 602.469 byte | 076fa2228dcd344a020852ab62d7865ad3d642af |

Toplam: 2 + 29 + 1 = **32 dosya**. İç içe alt ağaçlar ikinci kez sayılmadı.

Altı özgün dosyanın blob kimlikleri ayrıca SOURCE-MANIFEST'teki beklenen değerlerle eşleşir. Kaynak ZIP'inden çıkarılmış 26 dosyanın tamamını source tree eşitliği kapsar. `source/MANIFEST.sha256` içeriği remote'dan ayrıca okunarak kaynak bütünlük listesinin ulaşılabilirliği görüldü. GitHub alt ağaç kimlikleri içerik adresleme varsayımı altında hem ad/yol/mod hem byte kimliğini bağlar; yalnız boyut veya varlık kontrolü değildir.

İlgili API yolları, yukarıdaki repository altında `git/commits/<commit>`, `git/trees/<tree>` ve `compare/<parent>...<upload>` biçimindedir. Rapor geçici indirme token'ı içermez.

## 4. Hata duyarlılığı

Konsolidasyonun yerel kontrol kopyası üzerinde üç negatif probe yapıldı; özgün kaynaklar değiştirilmedi:

- Bir dosyaya tek byte eklendi: tree kimliği beklenenden farklı çıktı.
- Bir dosya çıkarıldı: tree kimliği beklenenden farklı çıktı.
- Bir dosyanın adı değiştirildi: tree kimliği beklenenden farklı çıktı.

Bu, denetimin yanlış içerik, eksik dosya ve yanlış yol örneklerine duyarlı olduğunu gösteren dar mekanik kontroldür. Güvenlik sertifikasyonu veya bağımsız ikinci-araştırmacı deneyi değildir.

## 5. Önceki plandan yöntem farkı ve kalan sınır

Önceki aktarım metni tüm remote byte'ların yeniden indirilip SHA-256 hesaplanmasını öngörüyordu. Bu ortamdan doğrudan standart HTTPS erişimi tekrar `Temporary failure in name resolution` verdi. Bu nedenle **tam remote binary indirme + SHA-256 hesaplaması yapılmadı**.

Onun yerine, önceden kayıtlı ve özgün byte'lardan yeniden hesaplanan Git içerik kimlikleri GitHub'dan gelen pinned ağaç/blob kimlikleriyle karşılaştırıldı. Başarı ölçütü doğru içeriklerin doğru yollara gitmesidir; dosya sayısına gevşetilmedi. Ancak doğrulama yolu birebir indirilen binary SHA-256 ölçümüyle eşitmiş gibi sunulmaz. Kontrol GitHub API/Git nesne kimliklerinin doğruluğuna ve hash eşitliğinin standart içerik-kimliği varsayımına dayanır; bağımsız taşıma yolu denetimi değildir.

Bu yeterli aktarım kanıtıyla önceki pending/PARTIAL payload eksiği kapatılır. Herhangi bir sonraki tam-download denetimi ayrıca raporlanabilir; şu anda yapılmış sayılmaz ve aynı dosyaları yeniden yüklemeyi gerektirmez.

## 6. Süreklilik ve kapsam

Metadata kapanışı, kullanıcı yükleme commit'inden sonraki ayrı bir olaydır. INDEX/STATE/WORK-PLAN/SOURCE-MANIFEST, eser yönlendirmeleri ve kapsam/aktarım kayıtları gerçek sonuca göre güncellenir. Özgün 32 dosya, görünür diyalog mesajları, reflection metinleri, agent-control, Foundation ve araştırmalar yeniden yazılmaz.

Bu kayıt arşivdeki kaynak kesimini genişletmez ve yeni araştırma/Atlas v0.2/SOUL/Development OS işi başlatmaz.
