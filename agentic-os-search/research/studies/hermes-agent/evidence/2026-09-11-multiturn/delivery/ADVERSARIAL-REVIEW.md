# U04 — Açıklamanın karşı okuması

2026-09-11; aynı araştırma ajanının eleştirel incelemesi, bağımsız denetim değildir.

| Yanlış genelleme adayı | Ayırıcı kanıt / düzeltme |
|---|---|
| Kanban terminal state önceyse hiç kabul kontrolü yoktur. | Own-run review/superseded çıkışı yetki devrini korur; tool `_goal_gate` ayrı koşullu katmandır. Bütün terminal durumları yeniden yargılamak eski run'a yetki döndürebilir. |
| Judge done dediğinde task done olur. | S01 ve G04/G05: önce finalize istemi, sonra ayrı receipt. |
| Döngü blocked sonucu verdiğinde DB kesin blocked'dır. | G08/G09 callback false/exception, DB running. |
| Sahiplik kontrolü her dış etkiyi fiziksel olarak durdurur. | G10 judge sırasında transferden sonra bir harmless callback turu; actual OS/AIAgent katmanı henüz sınanmadı. |
| `/goal` ve Kanban aynı WAIT/hata bütçesini paylaşır. | Kanban WAIT→continue, error flags sayılmıyor; GoalManager barrier ve ayrı counter kullanıyor. |
| `/loop --until` tüm durmaların tek zorunlu kabul koşuludur. | Marker öncelikli; --times kapanışı ayrı. Kaynak sırası var, canlı model koşusu yok. |
| State dosyada olduğundan gateway yeniden başlatmada otomatik aynı işi yürütür. | Pinned heartbeat watcher bellekte; loop için farklı persisted scan var. Yarım kalan tick/recovery açık. |
| Migration True döndüğünden child kalıcıdır. | Full-file heartbeat H08 normal karşı H09 selective write failure. Actual SessionDB koşulunun sıklığı veya telafisi açık. |
| Bir tam modül byte-match olduysa bütün deney gerçek HERMES'tir. | Yalnız heartbeat; clock ve DB adapter taklit. Kanban seçkilerinin full-parent fidelity'si açık. |
| 21 matched case ürün başarı yüzdesidir. | Sabit deney sorularının beklentisi; semantic quality/full product/independent replication yok. |

Dar seçkiler için daha güçlü source fidelity borcu korundu. Kaynakta gördüğümüz kontrolleri “ürün bozuk” veya “güvenlik doğrulandı” sonucuna yükseltmedik. Yeni kod seçkileri daha önceki K setiyle bağımsız corroboration olarak toplanmadı. Test kaydı/probe/input/SPEC kimlikleri birlikte saklandı.

Düzeltme önerileri actual upstream'e uygulanmadı. Failing-save acknowledgement, ownership recheck veya watcher-recovery tasarımı makul tasarım soruları olsa da bu çalışma bir implementasyon yetkisi değildir.
