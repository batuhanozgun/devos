# A4 — genişletilmiş giriş-yüzeyi link taraması 03

**1 Ekim 2026 / REPO-SEPARATION-20260929. TAMAMLANMIŞ LINK DİLİMİ.** Bu kayıt, A4-ENTRY-SURFACE-SCAN-03'te tanımlanan 299 giriş/durum yüzeyinin göreli Markdown link denetimini kapatır.

## Sabit kaynak ve yöntem

Kaynak commit: `8f9984f895398ca5cf7c7efa46dc53f2fe1dc1ed`  
Root tree: `c8b76c287941fb56975b077104ebd87f78cee4c3`

Seçim kuralı A4-ENTRY-SURFACE-SCAN-03 ve A4-ENTRY-LINK-SCAN-02 ile aynıdır. Maintenance, archives, daha önce sonuçlandırılmış `research/soul-context/current/**`, `development-os/**` ve EXP-006 yüzeyleri bu 299'luk kümenin dışındadır.

Markdown inline-link hedefleri çıkarıldı. URL/mailto/tel/data/javascript ve yalnız dosya-içi anchor'lar repository path denetiminin dışında bırakıldı. Query/fragment çıkarıldı; relative path kaynak dosya dizinine göre normalize edildi ve sabit root tree'deki yol kümesiyle karşılaştırıldı.

## Reproduction check

Önceki checkpoint'in lexicographic ilk **42 dosyası** aynı parser ile yeniden tarandı:

- link: **513**
- mevcut hedef: **513**
- çözülemeyen hedef: **0**

Bu, yeni dilimin A4-ENTRY-LINK-SCAN-02 ile aynı ölçüm semantiğini kullandığına dair sınırlı reproduction check'tir.

## Kalan 257 yüzey

Lexicographic 43. dosyadan 299. dosyaya kadar:

- dosya: **257**
- göreli Markdown linki: **1.286**
- mevcut snapshot yoluna doğrudan çözülen: **1.279**
- fiziksel staging konumundan çözülemeyen aday: **7**

Toplam 299 yüzey:

- göreli Markdown linki: **1.799**
- mevcut snapshot yoluna doğrudan çözülen: **1.792**
- staging-semantics incelemesine alınan: **7**

## Yedi staging-relative linkin disposition'ı

Yedi adayın tamamı tek dosyadadır:

`research/studies/hermes-agent/evidence/2026-09-11-multiturn/delivery/repo-updates/STATE.md`

Aday hedefler `notes/...18...`, `evidence/2026-09-11-multiturn/{RESEARCH,SOURCES,COVERAGE}.md`, `evidence/.../{SPEC.md,RESULT.json}` ve `synthesis/03-...` yollarıdır.

Aynı delivery paketinin `publication_manifest.json` dosyası:

- statüyü **`PREPARED_NOT_PUBLISHED`** olarak kaydeder;
- `repo-updates/STATE.md` → `research/studies/hermes-agent/STATE.md` hedef eşlemesini açıkça verir;
- repo-update payload dosyalarının hash'lerini saklar.

Dolayısıyla bu yedi link, delivery klasöründeki staging kopyasının kendi fiziksel konumuna göre yazılmış canlı repository navigation linkleri değildir; hedef package-root konumuna göre hazırlanmış payload içeriğidir. Staging kopyasını linkleri çalıştırmak amacıyla değiştirmek hem hazırlanmış payload semantiğini hem kayıtlı hash kimliğini bozar. Bu nedenle **gerekçeli koruma** uygulanır; publication gerçekleşmiş veya hedef içerikler güncelmiş gibi bir iddia üretilmez.

## Sonuç ve sınır

**Actionable kırık göreli Markdown linki: 0.**

Bu sonuç yalnız bu 299 giriş/durum yüzeyindeki göreli Markdown linklerinin path/disposition kontrolüdür. Linkin varlığı, hedef içeriğinin doğru, güncel veya semantik olarak doğru hedef olduğunu tek başına kanıtlamaz. Delivery/staging linklerinin canlı navigation olmadığı ayrıca görünür tutulur.

Genişletilmiş giriş-yüzeyi link taraması kapanmıştır. A4'ün sıradaki işi, aynı 299 yüzeyin ilk 100 satırının dışında kalabilecek başlık-dışı eski-yön ifadelerini hedefli sorgu ve doğrudan okumalarla daraltmaktır. A3'ün iki erişim açığı ve A5 bekleme durumu değişmez.
