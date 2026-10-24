# S1-15 — Araştırma / Keşif / Sentez ailesinin sınanması

> **Authority notu:** Bu dosya retained S1 analytical slice'ıdır; current sequencing authority değildir. Current yön için `../STATE.md → ../HANDOFF.md → ../WORK.md → S1-role-responsibility-consolidation.md` yolunu kullan.

**Tarih:** 26 Eylül 2026.  
**Başlangıç:** `batuhanozgun/agentic-os-search@6c5623fb8bf95da66523f6490cfa096702afdcca`.  
**Statü:** Bounded kaynak karşılaştırması ve kavramsal sınama tamamlandı; **F8 ayrı aday familya olarak modele eklendi**. Nihai organizasyon, fiziksel ajan veya kullanıcı kabulü değildir. S1'in bütünü kapanmadı.  
**Kanıt sınırı:** Aynı assistant'ın nitel model karşılaştırmasıdır; önkayıtlı deney, bağımsız hakem, canlı agent testi veya sekiz familyanın optimal olduğunun kanıtı değildir.

## 1. Soru ve aday sonuç

S1-14 üç seçeneği açık bırakmıştı: araştırma yalnız familyalar arası yöntem/kabiliyet mi; F1 tasarım ailesinin uzmanlığı mı; yoksa ayrı başarı yönü mü?

Burada incelenen, **SOUL'u geliştiren DevOS'un araştırma sorumluluğu**dur. Gelecekte SOUL'un müşterisine araştırma yapması veya bugünkü Research deposunun organizasyonu doğrudan DevOS kadrosu sayılmaz. Mevcut araştırma paketleri, tasarımdan ayrı bilgi teslimatının örnekleridir.

**Aday sonuç:** Araştırma bir yöntem olarak bütün ailelerde kullanılabilir; fakat araştırmanın kendisi esas teslimat olduğunda ayrı bir başarı yönünü temsil etmek yararlıdır:

> **F8 — Araştırma / Keşif / Sentez:** Yetkilendirilmiş bir soruda neyin bilindiğini, hangi açıklama veya seçeneklerin desteklendiğini ve neyin hâlâ bilinmediğini kaynak, gözlem ve uygun incelemeyle ortaya koymak; kullanılabilir, izlenebilir ve sınırları açık bir bilgi sonucu teslim etmek.

Bu iki seçenek birbirini dışlamaz: **araştırma yöntemi** ile **araştırma sorumluluğu** ayrı düzeylerdir. Ayrı familya aynı modelin araştırma ve tasarım yapmasını yasaklamaz; ayrı süreç, servis veya sürekli çalışan araştırma ajanı gerektirmez.

Yeni bir isim veya rapor dosyası bulunması gerekçe sayılmadı. Esas çıktı/bitiş koşulu; mevcut familyayı genişletme ihtiyacı; bilgi üretimi ile bağımsız güvence ayrımı; farklı DevOS alanlarında tekrar; küçük işte gereksiz bölünme riski karşılaştırıldı. Bu ölçütler nitel model karşılaştırmasıdır, puan veya deneysel üstünlük üretmez.

## 2. Kaynak karşılaştırması

### K1 — İş yönetimi araştırması tasarım kararı vermeden kapanmış

[STATE](../../../research/studies/work-management-project-control/STATE.md), [METHOD](../../../research/studies/work-management-project-control/METHOD.md) ve [U10 closure](../../../research/studies/work-management-project-control/10-CLOSURE-EVALUATION.md) tam okundu. Paketin teslimatı farklı iş-kontrol yaklaşımlarının kaynaklı karşılaştırmasıdır; kapanış ürün seçimi veya DevOS mimarisi değildir.

**Katkı:** DevOS B4'ün kullanabileceği bilgi teslimatı, kurulacak çözümü seçmeden tamamlanabilir. **Sınır:** Paketin varlığı bütün bulgularını veya F8'i bağımsız doğrulamaz. Sekiz dış ürünün güncel davranışları bu tur yeniden araştırılmadı; paket kendi amacı ve teslimatı için doğrudan örnektir.

### K2 — Superpowers spike: kod araç, cevap teslimat

[Superpowers S03](../../../research/studies/superpowers/syntheses/S03-intent-planning-and-context-handoff.md) tam; ardından sabit `b36e0829c6d0140e93cfef2ca599b1b07d4a7797` sürümündeki [brainstorming/SKILL.md](https://github.com/obra/superpowers/blob/b36e0829c6d0140e93cfef2ca599b1b07d4a7797/skills/brainstorming/SKILL.md) 1–170 seçici okundu.

Kaynak, spike yolunu yapılabilirlik sorusu olarak ayırıyor: sonucu bulgu/öneri, kodu geçici deneme sayıyor. Kalıcı uygulama otomatik devam değil. Aynı skill bounded ve architectural yolları da barındırıyor.

**İki yönlü katkı:** Araştırma ile tasarımın bitiş koşulları ayrılabilir; ancak aynı skill farklı yollar taşıyabildiği için ayrı fiziksel araştırmacı zorunlu değildir. Dosya/skill paketlemesi bizim familya sınıflandırmamızı belirlemez. **Sınır:** Kaynağın insan kapıları veya uygulama kuralları benimsenmedi; canlı davranış değil belge sözleşmesi okundu.

### K3 — Araştırma sonucu ile sonucunun değerlendirilmesi

Anthropic'in 13 Haziran 2025 tarihli [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system) yazısı 26 Eylül 2026'da doğrudan okundu. Yazı, bulgularla araştırma yönünü uyarlayan, alt araştırmaları sentezleyen ve kaynaklı cevap veren düzeni anlatıyor. Çıktıların doğruluk, kaynak ve kapsam bakımından değerlendirilmesi ayrıca ele alınıyor.

**Katkı:** Bilgi üretimi ile bu çıktıya ilişkin güvence ayrı sorumluluklar olarak temsil edilebilir. **Sınır:** Ajan sayısı, performans ölçümleri, güncel ürün uygunluğu veya bağımsızlık iddiaları benimsenmedi. Bu dış örnek F8'i ya da multi-agent seçimini kanıtlamaz; yeni ürün araştırması açılmadı.

### K4 — Her keşif F8 değildir

[RPD ASSESSMENT](../../../research/studies/recursive-prerequisite-discovery/ASSESSMENT.md) içindeki kaynak kimliği ve yöntem açıklaması seçici okundu. Kayıt ihtiyaç/koşul/yöntem/karar/eylem ayrımını ve önkoşul keşfini anlatıyor; özgün eklerin pakette bulunmadığını belirtiyor.

**Katkı:** Mevcut bilgiyle gerekli Work'ü/önkoşulu keşfetmek F1 veya başka bir rolün işi olabilir. Ayrı bir bilgi sorusu doğarsa F8 aday olur. **Sınır:** Bu değerlendirme asıl eklerin yerine geçirilmedi; RPD'nin özgün metni veya etkinliği yeniden doğrulanmadı, tarihsel target işleri devralınmadı.

## 3. Rakip modeller

| Seçenek | Gücü | Mevcut modelde sınırı | Sonuç |
|---|---|---|---|
| **A — Yalnız ortak yöntem/kabiliyet** | Her küçük arama için ayrı görev üretmez; bütün roller araştırabilir. | Esas teslimatı kaynaklı bilgi olan bağımsız işin sahibini ve tamamlanma koşulunu tek başına açıklamaz. | Yöntem düzeyinde korunur; tek başına sorumluluk modeli olarak yeterli değil. |
| **B — F1 specialization** | Araştırma ile tasarım birlikte yürütülebilir; küçük işte aynı görevlendirme uygun olabilir. | F1'in current çıktısı uygulanabilir/sınanabilir tasarımdır. Sırf açıklama, karşılaştırma veya negatif yapılabilirlik sonucunu kapsamak için F1'in başarı yönü genişletilmelidir. | Somut birliktelik mümkün; bütün araştırmaları F1'e yerleştirmek tercih edilmedi. |
| **C — Ayrı F8 + ortak araştırma kabiliyeti** | Bilgi teslimatını tasarım/uygulama ve güvenceyle karıştırmadan açıkça görevlendirir. | Ayrı ajan sanılırsa devir yükü; her arama F8 yapılırsa gereksiz iş üretir. | Mevcut familya ayrıntı seviyesinde tercih edilen aday. |

### Güçlü karşı seçenek: F5'i genişletmek

F5'in kanıta dayalı hüküm amacı ile F8'in bilgi üretimi arasında gerçek ortaklık vardır. F5 de yeni soru sorabilir, karşı kaynak arayabilir ve kriteri eleştirebilir; onu yalnız checklist çalıştıran role daraltmak yanlış olur.

**Geniş bir epistemik çalışma ailesi altında araştırma ve güvence specialization'ları kurmak mantıken mümkündür.** Aynı kaynaklar bunun yanlış olduğunu kanıtlamaz.

Current modelde ayrı F8 tercihinin gerekçesi: araştırma görevlendirmesi cevabı/açıklama modelini üretme; assurance görevlendirmesi belirli iddia/hedef için güvenin dayanağını sınama sorumluluğu taşır. Araştırmacının kendi sonucunu kontrol etmesi değerlidir ama bağımsız güvence değildir. F8 bu iki teslimat ve epistemik konumu görünür tutar; mevcut tasarım/üretim/teşhis/güvence ayrıntı seviyesiyle uyumludur.

Bu, **tek doğru sınıflama veya gösterilmiş davranış üstünlüğü değildir**. Birleşik üst aile aynı ayrımları daha anlaşılır ve etkili korursa yeniden değerlendirilebilir; sekiz sayısını korumak gerekçe olamaz.

## 4. Somut sınır vakaları

Masa başı karşı örneklerdir; koşulmuş deney değildir. K1/K2 kaynak örnekleri; diğerleri ayrımları sınayan DevOS görev uyarlamalarıdır.

| İş / esas teslimat | Birincil aday | Korunan ayrım |
|---|---|---|
| B4 için iş-kontrol geleneklerini ve sınırlılıklarını açıklamak; ürün seçmemek | **F8** | Araştırma tamamlanması ≠ tasarım seçimi. |
| B5'te bağlantının yapılabilirliğini geçici denemeyle araştırmak | **F8** | Prototip F2 alt işi olabilir; araştırma, tutulacak ürün olmadan tamamlanabilir. |
| B2 için kurulacak bilgi yaşam-döngüsü düzenini tasarlamak | **F1** | Araştırma kullanması bütün tasarımı F8 yapmaz. |
| Belirli sürümün salt-okur kontrol iddiasını ölçüt/kanıtla sınamak | **F5** | Kanıt toplamak otomatik F8 değildir. |
| Gerçek stale-context vakasında neden ve geri dönüş işini bulmak | **F6** | Investigation yöntemi teşhis/recovery yönünü kaldırmaz. Bu tur gerçek bir vakaya nedensel teşhis konmadı. |
| Bilinen current dosyaları bulup aktöre yeterli context sunmak | **F3** | Retrieval, yeni bilgi sorusu çözmedikçe F8 değildir. |
| B3 için rol bağlamlarının hangi koşullarda sonuçları değiştirdiğini araştırmak | **F8** | Deney tasarımı/üretimi/yürütümü/incelemesi alt katkılardır; zorunlu ayrı aktörler değil. |
| Yeni bulgunun ortak tabana kalıcı değişiklik olarak aktarılmasını değerlendirmek | **F7** | Bilgi üretimi ≠ adaptation; fiilî değişim F1/F2/F3'e gidebilir. |
| Mevcut bilgiyle gerekli Work'ü/önkoşulu keşfedip yaşayan planı kurmak | **F1** | “Keşif” adı bütün Work formation'ı F8'e taşımaz. |

Aynı nesneye farklı sorularla bakmak duplicate ownership değildir. Aynı exact teslimata belirsiz iki birincil sorumlu atamak ise hâlâ sorundur; familya tablosu bunu tek başına çözmez.

## 5. F8 aday sözleşmesi ve coverage etkisi

**Başarı:** Kaynak/gözlem/akıl yürütmeyle soruyu aydınlatmak; desteklenen bulgu, sınır ve açık soruları sonraki işin kullanabileceği biçimde teslim etmek. Çok kaynak, çok sayfa, mutlaka yenilik/çözüm, mevcut tasarımı haklı çıkarma veya sürekli yeni araştırma açma başarı değildir.

S1-14'teki “belirsizliği azaltmak” ifadesi tek başına dar kalır. İyi araştırma görünmeyen belirsizliği veya yanlış kurulmuş soruyu ortaya çıkarabilir. Buna karşılık gerekçesiz “bilmiyoruz” demek de başarı değildir.

Bir F8 görevlendirmesi gerektiği ölçüde şunları taşımalı:

- **Soru/üst iş:** Hangi DevOS işi için hangi bilgi eksik; bilgi hangi kararı veya çalışmayı etkileyebilir?
- **Exact nesne:** Soru, alan/hedef, beklenen bilgi teslimatı, scope ve gerektiğinde zaman/sürüm; alternatifler ve henüz yapılmayacak kararlar.
- **Bilgi/yeterlik:** Araştırma rotaları, alan bilgisi ve uygun inceleme/deney yöntemi. Kaynağa erişmek uzmanlık kanıtı değildir.
- **Araç/yetki:** İzinli okuma, arama, analiz veya probe kapsamı. Credential, ücretli deney, ürün değişikliği veya kapsam genişletme yetkisi kendiliğinden doğmaz.
- **Teslim:** Cevap/sentez; kaynak ve yeni çıkarım ayrımı; karşı kanıt; negatif/sonuçsuz bulgu; kapsam ve unknown'lar; gerektiğinde seçeneklerin koşulları.
- **Bitiş:** Yetkili soru/kapsam yeterince karşılandı mı, ek bilginin karar değeri var mı, yoksa erişim/bütçe yüzünden mi kesildi? Kesinti çözülmüş soru değildir; daha çok bilgi mümkün diye otomatik devam edilmez.
- **Tetik/devir:** Bilgi açığı veya yeni kanıt; sonucu tüketen Work/rol; gereken F5 incelemesi; gerekirse F3 kayıt bakımı ve F7 adaptation değerlendirmesi.

Araştırmacı kendi kaynak/çıkarım kontrolünü yapar; F5 var diye bunu ihmal etmez. Ayrı assurance ihtiyacı claim/risk/bağımsızlık koşullarına bağlıdır; her küçük araştırma için ayrı fiziksel hakem şartı değildir.

**Model etkisi:** F1–F7 ve R1–R25/M1–M9 yeniden numaralanmadı. Araştırma yapan bütün eski roller F8'e taşınmaz. İlk listede bağımsız araştırma teslimatı ayrıca birincil rol olarak adlandırılmamıştı; otomatik R26 atanmadı.

Olası specialization yüzeyleri kavramsal/karşılaştırmalı, mekanizma/yapılabilirlik ve ampirik incelemedir. Bunlar kesin, ayrık alt aileler değildir; aynı soru birkaçını gerektirebilir.

**B1–B9 projeksiyonu:** B1/B3 davranış ve rol soruları; B2 bilgi mekanizmaları; B4 iş-kontrol yaklaşımları; B5/B6 kabiliyet/kontrol ilişkileri; B7 oluşum seçenekleri; B8 adaptasyon kanıtı; B9 yöntem/oracle bilgisi gerektiğinde F8 katkısı isteyebilir. Bu, dokuz yeni araştırma işi, B10 veya yeni SOUL modülü açmaz. F8, F2 realization ve F3 Information/Actor-Role Lifecycle Operations açıklarını kapatmaz.

## 6. Okuma izi

Bu konuşmada daha önce tam okunan AGENT/gerekli protokoller, B1–B9, S1-01–S1-13, katalog ve ilgili META içerikleri korundu. S1-14'ün önceki turda üretilmiş tam metni konuşmada mevcuttu; bu tur yeni tam canonical okuma gibi sayılmadı. Main başlangıç başı son yayınla aynı bulundu. Güncellenmiş STATE/HANDOFF/WORK/ACTORS/S1 master yeniden canonical okundu; S1 master'ın kesilen sonu 90–220 ile tamamlandı. Bu tur ek yüklenen R02 control dosyası araştırma kanıtı değildir.

| Kaynak | Bu tur kapsam / blob |
|---|---|
| Work-management STATE | Tam; `d8e30d5a0eb26e056ff0a476147d448c6c8853c9` |
| Work-management METHOD | Tam; `57250152be488c0b6b1d021acdcb6b8332ec29d7` |
| Work-management U10 closure | Tam; `e140a0cac67d41af1d3b45dfdddf1eccedfcc860` |
| Superpowers S03 | Tam; `f69f5c99aefa2a6a13b4233ae49afd73dc2ce0ca` |
| Asıl Superpowers brainstorming | Seçici 1–170; ref `b36e0829c6d0140e93cfef2ca599b1b07d4a7797`, blob `b56a3b5ed6ea0d6216501e0e401ecb00a1b4675f` |
| RPD ASSESSMENT | Kaynak-kimliği/yöntem açıklaması seçici; 1–150 isteği sonlarda kesildi. Tam dosya veya özgün ek okuması iddia edilmez. |
| Anthropic araştırma-sistemi yazısı | Yukarıdaki birincil web yazısının metni; yayın 2025-06-13, erişim 2026-09-26. Diagram/kurulum incelenmedi. |

S1-14'ün metadata düzeyindeki reuse'u bütün kaynakların derin incelemesi gibi gösterilmedi. Gstack/Hermes/ECC programları yeniden açılmadı; Foundation ve studies değiştirilmedi. Yardımcı web kaynağı burada tutulur; her alıntı için yeni study açılmadı.

## 7. Sonuç ve dönüş

**A1:** Araştırma hem ortak yöntem hem ayrı teslimat/sorumluluk olabilir.

**A2:** Mevcut familya ayrıntı seviyesinde **F8 Araştırma/Keşif/Sentez** ayrı aday olarak tercih edildi. Genişletilmiş F5 alternatifi mantıken mümkün kalır; sekiz familya zorunluluğu veya davranış üstünlüğü kanıtlanmadı.

**A3:** Esas teslimat, exact soru ve bitiş koşulu belirleyicidir. Her arama/inceleme F8 değildir; aynı aktör farklı işleri taşıyabilir.

**A4:** Araştırmacı bulgusu bağımsız assurance, tasarım/adoption veya kalıcı adaptation değildir. Gerekçeli yeni belirsizlik de geçerli araştırma sonucu olabilir.

**A5:** Research-family sorusu bu kapsamda cevaplandı; S1 kapanmadı. Sıradaki mantıksal S1 işi **F2 realization kapsamını ve F3'ün iki açık lifecycle specialization'ını mevcut sorumluluklarla netleştirmek**. Gerekçeyle birleştir/ayır; her boşluğa yeni familya/ajan ekleme.

Bu turun yetkili işi S1-15'ti; sonuç kullanıcıya döndürülür. Sonraki specialization dilimi henüz yürütülmedi. Kullanıcının devam yönüyle oradan ilerlenir; tam effective-assignment düzeni, agent sayısı, topology, host/runtime veya mimari bu tur başlatılmadı.
