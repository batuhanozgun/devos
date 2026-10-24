# A4 — yön/statü içerik taraması 01

**1 Ekim 2026 / REPO-SEPARATION-20260929.** Bu kayıt yol envanteri sonrasında başlayan repository-wide içerik/statü taramasının ilk kümesidir. Araştırma sonuçlarını yeniden değerlendirmez; DevOS kurucusunun eski yönü güncel sanması riskini sınar.

## 1. Tarama yöntemi ve sınır

Default branch üzerinde `Codex`, `DEVOS-001`, `DEVOS-002`, `P5`, `güncel`, `sıradaki`, `next`, `current` sorguları çalıştırıldı. Arama sonuçları yokluk kanıtı değildir; bu tur yalnız yüksek-riskli giriş yüzeyleri ve doğrudan durum dosyalarının giriş pencereleri okunarak disposition verildi. Tam gövde, bütün eşleşmeler ve bağlantı hedefleri bu kayıtla tamamlanmış sayılmaz.

## 2. Gerekçeli korunan girişler

Aşağıdaki yüzeylerde eski DevOS yönü doğrudan girişten önce açıkça tarihsel/kurulum-dışı olarak ayrılmıştır; yeni değişiklik gerekmedi:

- `README.md`
- `development-os/INDEX.md`
- `research/INDEX.md`
- `research/soul-context/README.md`
- `research/soul-context/INDEX.md`
- `research/soul-context/STATE.md`
- `research/soul-context/current/README.md`
- `development-os/attempts/001/WORK.md`
- `development-os/attempts/002/README.md`
- `explorations/EXP-006-development-os-calisma-duzeni/WORK.md`
- `explorations/EXP-006-development-os-calisma-duzeni/HANDOFF.md`

Bu dosyalardaki daha aşağı tarihsel `current`, `next`, Codex/P5/DEVOS ifadeleri statü notundan sonra kaynak olarak korunur; yeniden yürütme yetkisi değildir.

## 3. Aktif araştırma olduğu için korunan current/next dili

Şunlar DevOS kurulum yönü değil, kendi araştırma paketlerinin güncel durumudur ve topluca tarihsel ilan edilmemelidir:

- `research/soul-foundations/STATE.md` ve `INDEX.md`: Foundation için current research posture ve next logical/authorized ayrımı; ayrıca hiçbir DevOS/SOUL design/implementation phase'in aktif olmadığını açıkça söylüyor.
- `research/studies/ecc/INDEX.md` / `PLAN.md`: ECC study'nin kendi ACTIVE/PARTIAL araştırma durumu ve seçilmiş fakat NOT STARTED U20-C/Q09 hazırlığıdır; adoption/implementation yetkisi olmadığını kendi girişinde sınırlar.
- `explorations/EXP-004-*/STATE.md`: CLOSED; otomatik sonraki Work veya implementasyon yetkisi olmadığını açıkça taşır.
- `explorations/EXP-005-*/STATE.md`: exploration-local durumdur; DevOS canlı durumundan ayrıdır.

Bu ayrımlar görevde korunması istenen araştırma anlamıyla uyumludur; sırf `current` veya `next` kelimesi geçtiği için değişiklik yapmak araştırma içeriğini bozardı.

## 4. Sonuç ve açık kapsam

**Bu ilk kümeye kaynak dosya değişikliği yapılmadı.** Arama eşleşmelerinin önemli bir bölümü A2'de statü notu almış tarihsel dosyalar, maintenance kayıtları veya aktif araştırmanın kendi durum dilidir. Arama yalnız ilk 50 sonucu döndürdüğü için bütün repository content scan tamamlanmış değildir.

Sıradaki içerik işi: arama sonuçlarının kalan riskli doğrudan dosyalarını ve başlık dışı eski yön ifadelerini daraltmak; ardından bağlantı hedefi taraması ve gerekli archive/ZIP içi kontrol. Her eşleşme ya düzeltme ya da gerekçeli koruma alacak.
