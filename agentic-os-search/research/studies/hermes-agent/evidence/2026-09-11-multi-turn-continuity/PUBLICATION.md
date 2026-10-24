# U04 — Yayın sözleşmesi ve kanıt kimliği

2026-09-11. Bu dilim eski kayıt kurtarması değil, yeni kaynak incelemesi ve yeni sınırlı deneydir. [SPEC](SPEC.md), deneyden önce `ee17ae74098f941b70e07bcf496d6d9be0206892` blob'u olarak kaydedildi. Çalıştırma `2026-09-11T06:10:29.139368+00:00` zamanlı ham RESULT.json'u üretti. stdout 15 grubun eşleşmesini; stderr H04'ün bilinçli write failure'ını taşır. Test kriteri sonuca göre gevşetilmedi; bu koşuda setup düzeltmesi veya eski suite rerun yoktur.

## Byte koruması

Arşiv 14,308 byte, SHA-256 `90228e3c0697b4461a6658865881196ca7b404f363fba06222489eb54cc497d7`, Git blob `89b1c87027f7e794133697ff07259474591affa4`. create_blob dönüşü yereldeki kimlikle eşleşti. Dokuz member [MANIFEST](MANIFEST.json)'te. Ham sonuç/probe/source/logların hiçbiri browsing görünümüne indirgenerek silinmedi. RESULT-SUMMARY türetilmiş, ayrıntıları eksiltilmiş bir gezinme dosyasıdır; exact claim için raw archive açılır.

Tam heartbeat ve lisans kimlikleri primary ile eşleşti. Seçili Kanban dosyasının yerel kimliği yalnız o araştırma artefaktını sabitler. Paketleme ve SHA doğrulaması yeni behavioral replication değildir.

## Main ve eşzamanlı çalışma

İlk main `13e00420d27547998475ac3d1bcd0d4a492f2229` idi. Çalışma sırasında `e335438fb1cf97539c429c585775cd84394eb3b0` oldu; compare yalnız Foundation değişiklikleri gösterdi. İlk yayın ağacı `67b9af7fb879174a5f3d9997d3e701201575318b` tabanından kuruldu. Foundation/control/exploration/context/diğer studies değiştirilmez; yalnız HERMES study ve catalog'un HERMES satırı.

Bir blob/tree/commit oluşturmak main yayını değildir. Yayınlayan tur aday diff'i kontrol eder, final main parent'ını yeniden okur, değiştiyse scoped değişiklikleri güncel parent'a bağlar; ref force olmadan ilerletilir. Ardından main, STATE, synthesis/03, sonuç/manifest ve archive blob geri okunur. Gerçek yayın commit'i bu içerik kendi kendisinin commit ID'sini tahmin ederek değil, Git referansı/readback ile kanıtlanır.

### Yayın yolu değişikliği — aynı turdaki somut gözlem

Ana dal Foundation kayıtlarıyla ilerlemeye devam etti. Scope karşılaştırmaları HERMES dışındaki değişiklikleri koruyarak aday ağacın sırasıyla yeni parent'lara bağlandığını gösterdi. `570a02c202832eed0e17f3eb628ea240f3ebc0d6` ve `6c3816d3ec3c095eaa62cd9a9ac3fd83b14e9c87` adayları için iki gerçek `update_ref(force=false)` çağrısı `422 Update is not a fast forward` döndürdü. Bu, bu turda çalışan GitHub yazma aracının eşzamanlı HEAD değişiminde reddedilmesidir; geçmiş `Resource not found` olaylarıyla aynı kök neden olduğu iddia edilmez.

Sınırsız client-side HEAD takibi yerine `research/hermes-u04-20260911-6c3816d` adlı yayın branch'i, son tam aday `6c3816d3ec3c095eaa62cd9a9ac3fd83b14e9c87` üzerinden oluşturuldu. Bu branch için main hedefli pull request ve GitHub'ın anlık server-side merge yolu kullanılacaktır; auto-merge/background işi, force push veya koruma ayarı değişikliği yoktur. PR açılması da tek başına yayın değildir: değişen dosyalar tekrar kontrol edilir, merge çağrısı exact PR head'e bağlanır ve başarı main/content readback ile doğrulanır. PR'nin merge kaydı nihai yayın receipt'idir. Önceki referanssız aday commit'ler ayrı araştırma ilerlemeleri veya başka yayımlanmış sürümler değildir.

## Devam

[STATE](../../STATE.md) ve plan v0.16 yeni çalışmayı, önceki K recovery'sinden ayırır. 01–17 notları, syntheses/01–02 ve eski evidence korunur. Yeni 18/U04 ve synthesis/03 geçicidir; native CORE/dört-alan/adoption tamamlanmış değildir. İlk teknik devam: gerçek session lease/history/SessionDB ile rotation/restart sırasında devam kaydı ve driver'ın yeniden kurulması. 429 kaynak sınırı kaydedilmiştir; eski sohbet ZIP'i gerekmez.
