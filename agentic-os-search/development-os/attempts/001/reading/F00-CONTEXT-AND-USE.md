> **30 Eylül 2026 — tarihsel DEVOS-001 / F00 kaynak okuması ve katkı kaydı.** Aşağıdaki altı katkı araştırma girdisi olarak korunur; P1 yükümlülüğü, karşı okuma açığı ve sıradaki `01_verticals` okuması eski denemeye aittir. Seri tam okuma şartının daha sonra kaldırılması [COVERAGE](COVERAGE.md)'da kayıtlıdır; bu belge eski işi yeniden başlatmaz.
>
> Güncel devir [D030](../../../../explorations/EXP-006-development-os-calisma-duzeni/DECISIONS.md#d030--claude-code-cloud-kurulum-devri)'dadır: tek kurulum planı [devos/plan/](https://github.com/batuhanozgun/devos/tree/main/plan) (devir sürümü 2.1); Claude Code ve DevOS bu depoyu yalnız okur. Kaynak/yorum/yetki ayrımları ve özgün gövde değişmez. Bu not Foundation'ın kendi araştırma durumunu değiştirmez ve eski DEVOS-001 yetkisini etkinleştirmez.

---

# F00 — başlangıç bağlamı ve araştırmanın çalışma yapısında kullanımı

**Tarih / okuyucu:** 24 Eylül 2026 / Research–ChatGPT.
**Tür:** P1 kaynak okuması ve katkı kaydı; yapı seçimi değildir.
**Kaynak:** `batuhanozgun/agentic-os-search@dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb`.
**Kapsam:** üç dosya tam okundu. `00_context` ağacı `349911b392ba647c891af3332d6f27554978fe89`, recursive liste kesilmedi ve yalnız README.md içeriyor. Bu nedenle 00_context için 1/1; bütün Foundation için tamamlanma değildir.

## Kaynak defteri

F = `research/soul-foundations/`. Bağlantılar sabit kaynak sürümünedir.

| ID | Dosya | Blob | Okuma / rol |
|---|---|---|---|
| S01 | [F/README.md](https://github.com/batuhanozgun/agentic-os-search/blob/dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb/research/soul-foundations/README.md) | 7e39c8789f8d76b1a6efc5c9c503095c1f0b7f2e | Tam; güncel araştırma yönü ve bütün yapı |
| S02 | [F/RESEARCH-USE-ALIGNMENT.md](https://github.com/batuhanozgun/agentic-os-search/blob/dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb/research/soul-foundations/RESEARCH-USE-ALIGNMENT.md) | e3a2b788acd19ae2cbe230953476265831753e12 | Tam; kullanıcıyla doğrulanan araştırma amacı ve kullanım sınırı |
| S03 | [F/00_context/README.md](https://github.com/batuhanozgun/agentic-os-search/blob/dc76496e2ea87a08b60f88ea8ec2731c6a4b5cbb/research/soul-foundations/00_context/README.md) | f3b25187808b4d0b01cd78b408c7528db3323bc8 | Tam; tarihsel başlangıç bağlamı, önceki repolara kaynak rotası |

Bu tur S03'ün yönlendirdiği soul-context gövdeleri, eski birincil repolar ve 01_verticals okunmadı. F08 kayıtları ve bu dosyalar aynı kavramlara değinse de ayrı kaynak okuması korunur; tekrar eden fikir yeni bağımsız kanıt sayılmaz.

## Kaynağın bütünsel modeli

S03, önceki repo çalışmalarını son mimari olarak değil, ayrı araştırmaları başlatan zayıf bir problem sinyali olarak kullanıyor. O dönemin üç araştırma yönü (records/artifacts, work, actors) tarihsel başlangıçtır; bugünkü dört zeminin eksik listesi veya yeniden başlatma talimatı değildir.

S01–S02, sonraki araştırmanın Environment, Information, Work, Actors ve bunların bileşimini açtığını gösteriyor. Bu bilgi; hedefin gerçek işi, aktörleri, ortam koşulları, studies örnekleri ve hedefte elde edilen kanıtla birlikte kullanılacak. Dört ayrı kutu doldurmak ya da terimleri dosya/servis adına çevirmek yerine bütün çalışma döngüsünün gereksinimlerini düşünmeye yarıyor.

## Katkılar

### F00-01 — Önceki yapı araştırma girdisidir, varsayılan mimari değildir
**Kaynak:** S03, Current carry-forward / Canonical source / Transition condition.
Önceki denemenin kayıt, iş ve aktör ayrımları yeni soru açmaya yeterli olabilir; tamlık, indirgenemezlik veya mekanizma üstünlüğü kanıtı değildir. Exact eski iddia için context defteri ve birincil kaynağa dönülür.
**Olası katkı:** Claude'un mevcut repo düzeni ve önceki Development OS girişimleri, seçenekleri daraltan otomatik başlangıç değil; gerekçe ve sınırlarıyla karşılaştırma girdisi olur. İlgili: F08-17/19. Yeni bir sistem seçilmedi.

### F00-02 — Teknik örnekler ihtiyaç modelini de değiştirebilir
**Kaynak:** S02, Technology-noncommitted is not technology-blind.
Önce ürüne bağlanmamak, teknik bilgiyi dışlamak değildir. Örnekte görülen gerçek kapasite, kısıt veya başarısızlık ihtiyaç sorusunu değiştirebilir, yeni bir seçenek açabilir veya bir Foundation ayrımını yeniden sorgulatabilir.
**Olası katkı:** P2'de Foundation→studies tek yönlü özellik eşlemesi değil, iki yönde karşılaştırma yapılır. Örneğin bir rol için tasarlanan bilgi yolu, gerçek ortamda yoksa yalnız rol tanımı yeterli olmaz. Bu örnek Research yorumudur; kaynak belirli bir ürün seçmiyor. İlgili: F08-04/07/17.

### F00-03 — Sorumluluk ve katılım ihtiyacı, ajan sayısından önce gelir
**Kaynak:** S02, Actors are not synonymous with AI agents; S01 retained structure.
İşi yapan, karar veren, sonucu alan ve etkilenip işi yapmayan taraflar ayrıdır. Bir AI ajanı aynı anda bilgi kullanır, iş yapar ve ortam koşullarına bağlıdır; tek bir zemine hapsedilmez.
**Olası katkı:** araştırma, planlama, uygulama, değerlendirme ve devam sorumluluklarının ne gerektirdiği çıkarılır; bunların kaç ayrı ajan/araç/insanla karşılanacağı sonraki seçimdir. Yetki veya bilginin farklı aktörlerde bulunması tek ortak kapasite gibi toplanmaz. İlgili: F08-03/06/16.

### F00-04 — Tam korpus hazırlığı ile her işte tam korpusu yüklemek farklıdır
**Kaynak:** S02, Specialization is not exhaustive form filling; S01 What Foundation is for / Selection.
Kaynağın bütün tarihçesini her bağlama koymak zorunlu değildir. Hangi kullanımda hangi ayrıntı, gerekçe, sürüm ve karşı örneğin gerektiği ayrıca belirlenir; bir dosyanın ilgili olması, seçilen bilgi kümesinin yeterli olması değildir.
**Olası katkı:** bugünkü kullanıcı emrindeki bütün okuma tamamlanır; sonradan kurulacak sistemde aktörün işine uygun bağlam ve ayrıntıya dönüş yolu tasarlanır. Bu ayrım P1 tam okuma yükümlülüğünü azaltmaz. İlgili: F08-05/08/11.

### F00-05 — Bulgu, gereksinim, mekanizma ve hedef kanıtı ayrı ama bağlıdır
**Kaynak:** S02, Agreed meaning / Structural coverage / Research-to-design / Completion and later use.
Araştırma boş kontrol listesi değildir: gerekçeleri ve karşı örnekleri kararları sınırlayabilir. Bununla birlikte bir ihtiyaç için araştırma rotası bulunması; gerçek gereksinimi, mekanizmayı, uygulanabilirliği ve sonucu kurmaz. Çalışma gerçek koşullarda ihtiyaçları netleştirir, yöntemleri (yeni mekanizma eklememek dahil) karşılaştırır, seçer ve sınar.
**Olası katkı:** her sonraki yapı kararı bir kayıt dayanağı, hedef ihtiyacı ve eksik gerçek kanıtıyla bağlanır. AGENTS.md/RAG/graph/memory adı tek başına çözüm değildir. Bu bir uygulama seçimi değil, ileride kayıtları birlikte okuyabilmek için ilişki girdisidir. İlgili: F08-17/18/19.

### F00-06 — Araştırmanın nasıl değiştiği de geri kazanılabilir olmalı
**Kaynak:** S03'ün üç tarihsel yönü; S01 Research progression and retained structure / History; S02 Original discussion record / Confirmation.
Eski bağlam, bağımsız dikeyler, yeterlik değerlendirmesi, dört zemin derinleşmesi, bileşim ve son bütünleşme ayrı araştırma evreleridir. Records'un Information içinde profil olarak kalması veya Work/Actors'ın zengin iç harita taşıması, bütün alanları aynı tür ağaç veya bileşene zorlamamayı gösterir. Eski yönün o tarihteki gerekçesi korunur; yeni yönün yerine kullanılmaz.
**Olası katkı:** alternatif düzenler değerlendirilirken yalnız son özet değil, değişimin gerekçesi ve reddedilen güçlü alternatifler bulunabilir olur. İlgili: F08-14/15/20. Kaynaktaki tarihsel 'yeni hedef yetkilenmedi' sınırı bugünkü DEVOS-001 yetkisini iptal etmez; farklı çalışmanın kendi tarihidir.

## Durum ve sonraki okuma

Kaynak okuması ve altı katkı kaydı tamam; karşı aktör okuması açık. F08 ile örtüşen ayrımlar açık bağlantılarla gösterildi, kayıt sayısı bağımsız bulgu sayısı değildir.
Sıradaki Research kaynağı: `01_verticals` ağacının dosya bazlı envanteri ve bütün dikeylerin sırayla tam okunması. F08 veya F00'daki bir ilke, alt kaynakların okunmasının yerine geçmez.
