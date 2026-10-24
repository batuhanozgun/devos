# A4 — giriş penceresi dışı gövde taraması 04

**1 Ekim 2026 / REPO-SEPARATION-20260929. TAMAM.** Bu kayıt, A4-ENTRY-SURFACE-SCAN-03'te seçilen 299 giriş/durum yüzeyinin ilk 100 satır dışında kalan gövdesindeki eski-yön risk taramasını ve A4 kapanış yeterlilik kontrolünü kaydeder.

## Sabit kaynak ve kapsam

İçerik snapshot'ı: `8f9984f895398ca5cf7c7efa46dc53f2fe1dc1ed`  
Root tree: `c8b76c287941fb56975b077104ebd87f78cee4c3`

Seçim A4-ENTRY-SURFACE-SCAN-03 ile aynıdır: basename'i README/INDEX/STATE/HANDOFF/WORK/PLAN/CURRENT-SURFACES/NEXT-RESEARCH-HANDOFF olan, maintenance ve archives dışında kalan; A2'de ayrıca sonuçlandırılmış `research/soul-context/current/**`, `development-os/**` ve EXP-006 yüzeylerini tekrar etmeyen **299 dosya**.

Bu tur yalnız her dosyanın **101. satırı ve sonrasını** doğrudan taradı. İlk 100 satır daha önce A4-ENTRY-SURFACE-SCAN-03'te okunmuştu.

## Risk filtresi

Aynı eski-yön göstergeleri kullanıldı:

- `Codex`
- `DEVOS-001`
- `DEVOS-002`
- bağımsız `P5`
- bağımsız `S00`
- `soul-production`
- `soul-development-os`
- bağımsız `builder`
- `target repository`
- `hedef repo`

## Sonuç

299 yüzeyin 101. satır ve sonrasında yalnız **iki eşleşen satır** bulundu.

1. `research/INDEX.md:104` — “target-repository truth” ifadesi cross-project continuity notlarının hedef repository'nin canonical state'ini kopyalamaması gerektiğini söyleyen genel bir çalışma ilkesidir. Eski bir DevOS hedef reposunu current ilan etmez.
2. `research/studies/ecc/INDEX.md:120` — “Codex/Git helper tests” ifadesi U19-D'nin test-source inspection sınırıdır ve aynı cümle bunun installed host veya actual commit/push execution olmadığını açıkça söyler. ECC study bulgusudur; DevOS kurulum yönü değildir.

**Kaynak dosya değişikliği: 0.**

## Search-limit karşı kontrolü

İlk A4 repository-wide search'inin “ilk 50 sonuç” sınırına güvenilmedi. GitHub code-search toplamları ayrıca kontrol edildi; örneğin `Codex` 301, `P5` 84, `S00` 168 eşleşen dosya döndürdüğü için generic search absence'ın yokluk kanıtı olamayacağı doğrulandı.

Daha özgül tarihsel kimlikler için sonuç sayısı 100'ün altında kaldığından bütün dosya yolları alındı:

- `DEVOS-001`: 39 dosya — maintenance, soul-context, EXP-006, development-os ve kök bakım/açıklama yüzeyleri.
- `DEVOS-002`: 14 dosya — maintenance, EXP-006, development-os, root/catalog açıklamaları.
- `soul-production`: 13 dosya — maintenance, soul-context ve `research/INDEX.md`.
- `soul-development-os`: 66 dosya — ağırlıkla soul-context/development-os/maintenance; kalanlar study/concepts referansları veya EXP-002/004/005 kaynak/artefaktlarıdır. Bu exploration paketlerinin entry/state yüzeyleri kapanmış/tarihsel sınırı taşır.
- `P5-1.0.0`: 6 dosya — maintenance ve EXP-006.
- `CODEX_START`: 13 dosya — maintenance, archive, EXP-006, CATALOG ve REPOSITORY-TRANSITION.
- `soul-development-os_02`: 14 dosya — maintenance, A2-statülendirilmiş soul-context, bir RPD candidate study ve EXP-005 tarihsel kaynak/artefaktları.
- `soul-development-os2-claudecloud`: 1 dosya — görev kaydı.
- `soul-development-os3_claudecode`: 12 dosya — A2-statülendirilmiş development-os/soul-context kayıtları ve maintenance.

Bu sınıflandırma her generic `Codex/current/next` eşleşmesinin semantiğini yeniden doğrulamaz; amacı eski DevOS yönü için özgül kimliklerin A2 ve araştırma/tarihsel sınırlarının dışına kaçıp kaçmadığını kontrol etmektir.

## A4 kapanış değerlendirmesi

A4 için birlikte mevcut olan kanıt:

- bütün tracked research yolu envanteri;
- A2'nin yüksek-riskli current/development-os/EXP-006 doğrudan okumaları ve statü notları;
- iki repository-wide yön/statü sorgu kümesi;
- 299 entry/state yüzeyinin ilk 100 satırının doğrudan okunması;
- aynı 299 yüzeyin 101. satır ve sonrasının bu kayıtla taranması;
- 299 yüzey / 1.799 göreli Markdown link disposition'ı;
- 17 yüksek-riskli girişin link kontrolü;
- A3 archive/ZIP içindeki text-like malzemenin statü kontrolü.

Bu kombinasyonda yeni actionable eski-yön veya kırık-link sorunu kalmadı. A4 bu nedenle kapanabilir.

**Sınır:** Bu, Foundation/studies/concepts/explorations altındaki bütün araştırma yapraklarının satır satır yeniden okunduğu, bulgularının yeniden doğrulandığı veya `current/next` kelimelerinin her kullanımının tek tek yeniden sınıflandırıldığı anlamına gelmez. Araştırma paketlerinin kendi current/next dili korunur; search result absence tek başına yokluk kanıtı olarak kullanılmaz.

A3 5/7 aileyle kısmi ve iki kaynak erişim engeliyle açık kalır. Sıradaki iş A5 son karşılaştırma ve teslimdir.
