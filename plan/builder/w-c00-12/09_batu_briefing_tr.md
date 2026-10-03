# Batu için kısa bilgilendirme: çalışma düzenimin yeniden tasarımı (W-C00-12)

**Durum:** taslak, bağımsız dış denetim (R-W12-1) sonucuna göre güncellenecek. **Yazan:** çalışma oturumu `session_01Wj4JDduaDRVnBvQJ86b5bm`, 3 Ekim 2026.

## Senden beklenen

**Hiçbir şey.** Bu tasarımda senin vermen gereken bir karar ya da hesabında yapman gereken bir ayar yok. Bir karar gerekirse [Batu'dan beklenenler](https://github.com/batuhanozgun/devos/issues/6) issue'suna, Ek E biçiminde gelir.

## Ne değişiyor (senin açından)

Birinci madde dışındakiler **henüz tasarım**: dış denetimden geçip uygulanana ve testleri geçene kadar eski düzen geçerli.

1. **Yeni oturumu ben başlatıyorum.** Bir çalışma oturumunun bağlamı dolunca bir sonrakini kendisi başlatıyor; bu 3 Ekim'de ilk kez gözlendi (`evidence/C00/probes/T-C1_successor_run.md`). Sen komut yazmıyorsun.
2. **Sürekli açık "dağıtıcı" oturumu kaldırılıyor.** Hiç gerçek bir işi olmadı. Yerine her oturum, beklediği şey için (kullanım sınırının yenilenmesi, senin cevabın) kendine bir uyandırma kuruyor.
3. **Cevabını daha çabuk görüyorum.** Senden bir karar beklerken 6 saatte bir issue'ya bakıyorum; cevabın kaydedilmeden oturum duramıyor. 2 Ekim'deki cevabın 35 saat kaydedilmeden kalmıştı; tasarımda bu bir kontrolle engelleniyor.
4. **`DURUM.md` elle yazılmıyor, kayıtlardan üretiliyor.** Böylece eski kalamıyor; en üstte her zaman "Senden beklenen" satırı var.
5. **Kendi işimi kendim onaylamıyorum.** Önemli değişiklikler hangi dosyaya dokunduğuna bakılarak otomatik "yüksek etkili" sayılıyor ve ayrı bir oturumun onayı olmadan birleşemiyor.

## Bilmen gereken sınırlar

- Bütün denetçiler hâlâ benimle aynı model ve aynı hesap. Gerçek bağımsızlık C03'teki denetim ortamıyla geliyor (senin D-003 kararın bunu kabul ediyor).
- Bir oturum tamamen ölürse (silinir ya da arşivlenirse) onu şimdilik hiçbir şey yeniden başlatmıyor. Bunu `DURUM.md`'deki "Son güncelleme" saatinin eskimesinden görürsün. Bu bir kez bile olursa bağımsız bir bekçi eklenecek.
- Tasarım, eski düzenden daha fazla otomatik kontrol içeriyor. Bağımsız eleştirmen ilk sürümü gereksiz büyük buldu; yedi mekanizma ertelendi, üçü çıkarıldı. Dış denetimden özellikle "bu kadarı orantılı mı" sorusunu yanıtlaması istendi.

## Ayrıntı isteyersen

- Karşılaştırma ve her farkın gerekçesi: `plan/builder/w-c00-12/06_counter_design_comparison.md`
- Sistemin "program haritası" ve geçmiş hataların yeri: `plan/builder/w-c00-12/07_mechanism_map.md`
- 24 maddelik girdi listenin her maddesine verilen karar: `plan/builder/w-c00-12/08_oi011_dispositions.md`
