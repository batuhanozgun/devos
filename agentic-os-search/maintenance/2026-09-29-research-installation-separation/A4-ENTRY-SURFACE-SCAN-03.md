# A4 — giriş/durum yüzeyleri taraması 03

**1 Ekim 2026 / REPO-SEPARATION-20260929.** Bu kayıt, A4 içerik/statü denetiminde geniş giriş-yüzeyi taramasını kaydeder. Araştırma içeriğini yeniden değerlendirmez ve DevOS için yeni iş üretmez.

## 1. Kapsam

Güncel main `9689e08985c85f3edbb2899b2da5dcdbf3acc0f7` üzerindeki kesilmemiş root tree'den şu basename'lere sahip izlenen dosyalar seçildi:

- `README.md`
- `INDEX.md`
- `STATE.md`
- `HANDOFF.md`
- `WORK.md`
- `PLAN.md`
- `CURRENT-SURFACES.md`
- `NEXT-RESEARCH-HANDOFF.md`

Maintenance ve archives bu giriş kümesinden çıkarıldı. A2/A4'te zaten sonuçlandırılmış `research/soul-context/current/**`, `development-os/**` ve EXP-006 yüzeyleri tekrar açılmadı. Geriye **299 giriş/durum yüzeyi** kaldı.

Her dosyanın **ilk 100 satırı** doğrudan okundu. Bu, dosyanın tam gövdesinin okunduğu anlamına gelmez.

## 2. Risk filtresi

Giriş pencerelerinde şu eski-yön göstergeleri arandı:

`Codex`, `DEVOS-001`, `DEVOS-002`, bağımsız `P5`, bağımsız `S00`, `soul-production`, `soul-development-os`, `builder`, `target repository`, `hedef repo`.

**37 dosyada en az bir eşleşme** çıktı. Eşleşmeler bağlamından değerlendirildi; dört sınıfta toplandı:

1. **Açık tarihsel/kurulum-dışı ayrım:** kök, explorations ve soul-context girişleri eski yönün bugünkü DevOS yetkisi olmadığını girişte söylüyor.
2. **Araştırma kapsam yasağı:** Foundation dosyalarındaki Codex/DevOS atıfları çoğunlukla araştırmayı bu ürünlerden geriye doğru tanımlamama kuralıdır.
3. **Araştırma-içi kimlik çakışması:** Foundation'daki `P1–P5`, Superpowers'taki `S00–S36` gibi adlar Codex P5/S00 kurulum paketleri değildir.
4. **Kaynak/mekanizma adı veya sınır ifadesi:** studies içindeki Codex, builder ve Development OS atıfları incelenen kaynağı, karşılaştırma nesnesini veya “bu kapsam dışında” sınırını adlandırır; uygulama yetkisi vermez.

Bu kümede yeni bir kaynak statü düzeltmesi gerekmedi.

## 3. Özellikle kontrol edilen sınırlar

- Foundation kök STATE, “next logical work” ile “next authorized phase”ı ayırıyor ve DevOS/SOUL design/implementation aşamasının aktif olmadığını açıkça söylüyor.
- ECC, Hermes, Superpowers ve diğer studies girişlerindeki current/next ifadeleri kendi araştırma paketlerinin statüsüdür; DevOS canlı durumu değildir.
- EXP-002/004/005 girişleri yeni DevOS implementasyonu başlatmadıklarını veya kapanmış/iptal edilmiş olduklarını açıkça sınırlar.
- `research/soul-context/repos/**` girişlerindeki eski repo adları source-ledger/tarihsel kaynak kimliğidir.

## 4. Kanıt sınırı ve devam

Bu çalışma **299 dosyanın ilk 100 satırını** kapsar; tam gövde yokluk kanıtı değildir. A2/current, development-os ve EXP-006'nın önceki tam/daraltılmış denetimleri kendi kayıtlarıyla korunur.

**Kaynak dosya değişikliği: 0.** Bir eşleşmenin bulunmaması, dosyanın daha aşağı gövdesinde riskli ifade olmadığı anlamına gelmez.

Sıradaki A4 işi:

1. bu 299 giriş yüzeyinin daha geniş Markdown göreli-link kümesini root tree'ye karşı kontrol etmek;
2. giriş penceresi dışında kalabilecek başlık-dışı eski-yön ifadelerini hedefli sorgu/dosya okumalarıyla daraltmak;
3. ardından A4 kapsamını kapatmaya yeterli olup olmadığını değerlendirmek.

A3'ün iki kaynak erişim açığı ve A5 bekleme durumu değişmez.
