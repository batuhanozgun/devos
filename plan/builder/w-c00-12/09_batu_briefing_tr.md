# Batu için kısa bilgilendirme: çalışma düzenimin yeniden tasarımı (W-C00-12)

**Durum:** taslak (3. sürüm). Dar yeniden denetimin (R-W12-2) sonucuna göre son hâlini alacak. **Yazan:** çalışma oturumu `session_01XUsVQowRbLJdC1E8gFvxZq`, 3 Ekim 2026.

## Senden beklenen

**Şimdilik hiçbir şey.** İleride iki şey gelebilir; ikisi de [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna, Ek E biçiminde gelir:
1. Bağımsız bekçi dosyasını ben depoya ekleyemezsem, onu senin GitHub web arayüzünden eklemen gerekecek. Adım adım yazılmış olarak gelir.
2. Duran bir oturumun otomatik yeniden başlatılması için bir anahtar (muhtemelen ücretli) gerekir. Bu senin kararın (D-004). Cevap gelene kadar varsayılan: otomatik yeniden başlatma yok, bekçi sana haber verir.

## Ne değişiyor (senin açından)

Birinci madde bugün çalışıyor. Diğerleri **tasarım**: denetimden geçip parça parça kurulana ve testleri geçene kadar eski düzen geçerli.

1. **Yeni oturumu ben başlatıyorum.** Bir çalışma oturumu işini devrederken sıradakini kendisi başlatıyor. Bu iki kez gözlendi (`evidence/C00/probes/T-C1_successor_run.md`). Sen komut yazmıyorsun.
2. **Sürekli açık "dağıtıcı" oturumu kaldırılıyor, yerine bağımsız bir bekçi geliyor.** 3 Ekim'de bir oturum hesap sorunuyla durdu ve ancak sen yazınca devam etti. İlk tasarımım bunu hesaba katmamıştı; denetçi yakaladı. Artık iki katman var:
   - her oturum, beklediği her şey için kendine bir uyandırma kuruyor;
   - GitHub'da saatte bir çalışan küçük bir bekçi, iş durmuşsa sana issue üzerinden telefonuna haber veriyor.

   Bekçi işi kendisi yeniden başlatamıyor. Haber geldiğinde yeni bir oturum açman gerekiyor.
3. **Cevabını daha çabuk görüyorum.** Senden karar beklerken 6 saatte bir issue'ya bakıyorum. Cevabın kaydedilmeden oturum duramıyor; issue okunamazsa da duramıyor.
4. **`DURUM.md` elle yazılmıyor, kayıtlardan üretiliyor.** En üstte her zaman "Senden beklenen" satırı var.
5. **Kendi işimi kendim onaylamıyorum.** Önemli dosyalara, bir belgenin geçerlilik durumuna ya da bir işin kabul şartına dokunan her değişiklik otomatik olarak "yüksek etkili" sayılıyor. Böyle bir değişiklik, ayrı bir oturumun onayı olmadan birleşemiyor.
6. **Hepsi birden kurulmuyor.** Önce küçük bir ilk parti kuruluyor (dört adımda, her adım ayrı denetimle). C00'ın ağır işleri bundan sonra başlıyor. Diğer yirmi kadar mekanizma, ancak gerçekten ihtiyaç doğarsa ekleniyor.

## Bilmen gereken sınırlar

- Bütün denetçiler hâlâ benimle aynı model ve aynı hesap. Gerçek bağımsızlık C03'teki denetim ortamıyla geliyor (D-003 kararın bunu kabul ediyor).
- Bir oturum tamamen ölürse bekçi sana en geç birkaç saat içinde haber veriyor. Bu süre, kilidin dolma süresi (en çok 3 saat 15 dakika) artı bir saat. Yeniden başlatmak sana kalıyor (2. maddedeki D-004 kararı bunu değiştirebilir).
- Bekçinin kendisi de durabilir: GitHub, 60 gün hareketsiz kalan depolarda zamanlanmış işleri kapatıyor. Bu, `DURUM.md`'de risk olarak yazıyor.

## Ayrıntı istersen

- İlk partinin içeriği ve sırası: `plan/builder/w-c00-12/12_tranche_plan.md`
- Her mekanizma ve testi: `plan/builder/w-c00-12/11_test_register.md`
- Sistemin "program haritası" ve geçmiş 40 hatanın yeri: `plan/builder/w-c00-12/07_mechanism_map.md`
- 24 maddelik girdi listenin her maddesine verilen karar: `plan/builder/w-c00-12/08_oi011_dispositions.md`
