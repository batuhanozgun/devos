# Analojiler — çalışma metinleri

Bu klasör, SOUL Research konuşmalarında Batu'nun kullandığı analojiler ve bunlardan hareketle bu konuşmada hazırlanmış uzun açıklama metinlerini taşır.

Bu dosyalar LinkedIn postlarının kaynak metinleridir; kaynak metinler korunur, post taslakları ayrı tutulur.

**Dosya numaraları aynı zamanda önerilen yayın/anlatım sırasıdır.** Sıra, okuyucuyu kullanıcı talebinden Work discovery'ye; oradan planlama, Actor tasarımı, memory/context ve son olarak harness/yaşayan sistem düşüncesine taşıyacak şekilde düzenlenmiştir.

## Güncel çalışma durumu

İlk 14 taslak, Batu'nun kaynak analojilerin derinliğini ve etkisini yeterince taşımadıkları yönündeki değerlendirmesi sonrasında yeniden yazım açısından gözden geçirilmektedir. Tamamlanmış yayın metinleri sayılmazlar.

**Roman v2 — üslup için olumlu geri bildirim, kapanış revizyonu değerlendirmede.** Batu, `d2467c0db5867289f6b1fd3c8216fcd0e7bc8293` commit'indeki gövdenin üslubunu çok iyi bulduğunu, kanalın bulunduğunu ve biraz daha rahat kullanılabileceğini belirtti. Bu, o sürüme ilişkin kalibrasyon geri bildirimidir; assistant metnini özgün yazar corpus'una dönüştürmez veya bütün yazılara aynı anlatım kalıbını dayatmaz.

Son talep, sorunu anlayan okuyucunun çözümü ayrıca araştırabileceği somut bir başlangıç elde etmesidir. [Roman analojisi — ikinci yazım](posts/01-roman-analojisi-v2.md) aynı dosyada güncellendi: ilk dört paragraf aynen korundu; kapanışta görev–gerekçe örneği, araştırılabilecek yöntem adları, Flowable CMMN'deki “Exit criterion (exit sentry)” bölümünün örnekle ilişkisi ve doğrudan doküman bağlantısı bulunuyor. Bağlantı post gövdesine dahildir; yalnız editoryal kaynak notunda bırakılmamıştır. Flowable tek başına anlamsal değerlendirme ve dış agent durdurma sorununu çözen, seçilmiş ürün gibi sunulmaz. Yeni kapanışın değerlendirmesi ve nihai yayın onayı bekleniyor.

Önceki v2 gövdeleri Git geçmişinde, [ilk roman taslağı](posts/01-roman-analojisi.md) ayrı dosyada korunur. 02–14 numaralı postlar bu aşamada yeniden yazılmamıştır; kaynak metinlere dokunulmamıştır.

Batu'nun son yönlendirmesi: Her yazının konusu kadar neden anlatılmak istendiği ve nasıl ortaya çıktığı da kendi bağlamında anlaşılmalıdır. Bilgi paylaşımı, merak, deneyim veya itiraz aynı anlatım kalıbına zorlanmaz. Üslubun her özelliği her yazıda bulunmak zorunda değildir. Kaynak konuşmalar yazma gerekçesini anlamak için kullanılır; Batu adına yaşanmamış olay, duygu veya motivasyon uydurulmaz. Bu yönlendirme, aşağıdaki rehberlerde yer alan örnek akışları zorunlu şablon olarak uygulamak anlamına gelmez.

Üslup rehberindeki assistant üretimi “Batu'ya yakın” örnekler, Batu'nun özgün yazılarına eşdeğer kanıt değildir. Olumlu geri bildirim alan roman sürümü, doğrudan Batu'nun yazdığı [LLM Düşünmez makalesine](../articles/2026-09-11-llm-dusunmez-zaxzf.md) ve özgün roman konuşmasına dönülerek hazırlanmıştır. Rehbere uygunluk tek başına üslubun yakalandığını göstermez. Diğer assistant üretimi LinkedIn yazıları üslup corpus'una alınmaz.

## LinkedIn'e dönüştürme çalışma kuralı

Her LinkedIn uyarlamasında iki rehber birlikte okunacaktır:

- genel üslup: [Batu Yazım Rehberi](../../BATU-YAZIM-REHBERI.md)
- LinkedIn serisinin amaç/kapsam/agentic anlatı yönü: [LinkedIn AI Yayın Rehberi](../LINKEDIN-YAYIN-REHBERI.md)

Çalışma biçimi:

- uzun kaynak metin korunur, post üretimi kaynak metnin yerine geçmez;
- post taslakları [posts/](posts/) altında tutulur;
- 2.800 karakter sınırı ve Batu'nun vereceği diğer post kriterleri uygulanır;
- SOUL'a özgü fikir, LinkedIn okuyucusunun anlayacağı genel AI/agentic/harness problemine çevrilir;
- analoji yalnız soyut fikir olarak kalmaz; agentic sistemde hangi mekanizmaya karşılık geldiği görünür hale getirilir;
- rehberler mekanik şablon değildir; öncelik düşünce akışının, doğal sesin ve yayın amacının birlikte korunmasıdır.

## Post taslakları — yayın sırası

1. [Roman analojisi — ikinci yazım](posts/01-roman-analojisi-v2.md) · [Önceki taslak](posts/01-roman-analojisi.md)
2. [İlk Work: işi keşfetmek](posts/02-ilk-work-isi-kesfetmek.md)
3. [Evrensel küme / bilinmeyen bilinmeyenler](posts/03-evrensel-kume.md)
4. [Yaşayan katmanlı plan](posts/04-yasayan-katmanli-plan.md)
5. [Ev, gökdelen, köpek kulübesi ve uzman routing'i](posts/05-ev-gokdelen-kopek-kulubesi.md)
6. [Builder–Verifier ayrımı](posts/06-builder-verifier-ayrimi.md)
7. [Futbolcu kartı ve ortak entelektüel taban](posts/07-futbolcu-karti.md)
8. [Entelektüel miras](posts/08-entelektuel-miras.md)
9. [Dosya mı hafıza, bilgi mi?](posts/09-dosya-mi-hafiza.md)
10. [İnsan hatırlar, LLM yeniden bulur](posts/10-insan-hatirlar-llm-bulur.md)
11. [“Hava bugün çok…” ve context aktivasyonu](posts/11-hava-bugun-cok.md)
12. [Agentic sistemi program gibi düşünmek](posts/12-program-gibi-sistem.md)
13. [Yatay ve dikey genişleme](posts/13-yatay-dikey-genisleme.md)
14. [Roket kademesi gibi ayrılmayan sistem](posts/14-roket-kademesi.md)

## Kaynak metinler — aynı anlatım sırası

1. [Roman analojisi — kullanıcı talebinden yaşayan iş tanımına](01-roman-analojisi-kullanici-talebinden-yasayan-is-tanimina.md)
2. [İlk Work işi yapmak değil, yapılacak işi keşfetmektir](02-ilk-work-yapilacak-isi-kesfetmektir.md)
3. [Görsel / evrensel küme analojisi](03-gorsel-evrensel-kume-analojisi.md)
4. [1–6'dan 1.1–1.5'e: yaşayan katmanlı plan](04-yasayan-katmanli-work-plani.md)
5. [Ev, gökdelen, köpek kulübesi ve alet çantası](05-ev-gokdelen-kopek-kulubesi-alet-cantasi.md)
6. [Builder–Verifier ayrımı](06-builder-verifier-ayrimi.md)
7. [Futbolcu kartı analojisi](07-futbolcu-karti-analojisi.md)
8. [Entelektüel miras](08-entelektuel-miras.md)
9. [Dosya mı hafıza, bilgi mi?](09-dosya-mi-hafiza-bilgi-mi.md)
10. [İnsan hatırlar, LLM yeniden bulmak zorundadır](10-insan-hatirlar-llm-yeniden-bulmak-zorundadir.md)
11. [“Hava bugün çok…” analojisi](11-hava-bugun-cok-analojisi.md)
12. [SOUL'u bir program gibi düşünmek](12-soulu-bir-program-gibi-dusunmek.md)
13. [Yatay ve dikey genişleyen SOUL](13-yatay-ve-dikey-genisleyen-soul.md)
14. [Roket kademesi gibi ayrılmayan SOUL](14-roket-kademesi-gibi-ayrilmayan-soul.md)

## Kaynak sınırı

Kaynak metinler bu ChatGPT konuşmasında hazırlanmış anlatılardır; kaynak fikirlerin önemli bölümü repository'deki EXP-001–EXP-005 görünür kullanıcı konuşma kayıtlarından geri alınmıştır. Bunlar kabul edilmiş SOUL mimarisi değildir. Post taslakları da yayımlanmış LinkedIn içerikleri değildir.
