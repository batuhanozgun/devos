# Taslak 13 — Yatay ve dikey genişleme

- Durum: LinkedIn post taslağı; yayımlanmış içerik değildir.
- Kaynak: [kaynak analoji](../13-yatay-ve-dikey-genisleyen-soul.md)
- Genel üslup rehberi: [BATU-YAZIM-REHBERI.md](../../../BATU-YAZIM-REHBERI.md)
- LinkedIn yayın rehberi: [LINKEDIN-YAYIN-REHBERI.md](../../LINKEDIN-YAYIN-REHBERI.md)
- Post gövdesi karakter sayısı: 1876
- Üst sınır: 2800

---

Agentic sistemlerde “yeni capability ekledik” cümlesi bana artık tek başına pek bir şey söylemiyor.

Mesela sisteme Security Agent ekledik.

Dikey olarak büyüdük: daha önce yapamadığımız bir şeyi artık yapabiliyoruz.

Güzel.

Ama Security Agent yeni dosyalar okuyacak, bulgular yazacak, kararları etkileyecek, belki tool kullanacak.

O zaman başka sorular çıkıyor:

Memory onun ürettiğini biliyor mu?
Verifier çıktısını görüyor mu?
Authority sınırı var mı?
Work graph’ta yeri ne?
Session değişince state’i recover ediliyor mu?
Başka agent’ların context’ine gerekli bulgular taşınıyor mu?

Bunlar yoksa capability var ama sisteme gerçekten entegre olmamış olabilir.

Ben buna yatay ve dikey genişleme gibi bakıyorum.

Dikey:
Yeni agent, tool, yöntem, uzmanlık.

Yatay:
Mevcut memory, context, provenance, verification, authorization ve continuity mekanizmalarının bu yeni yüzeyi de kapsaması.

Agentic mimariler bazen diyagramda çok güzel büyüyor. Yeni kutu çiziyoruz, bir ok bağlıyoruz, tamam.

Asıl maliyet çoğu zaman kutunun kendisinde değil, sistemin geri kalanının o kutunun varlığını öğrenmesinde.

Bir browser tool eklemek de aynı.

“Artık web’e erişiyoruz” diyebilirsin.

Peki web’den gelen bilgi hangi provenance ile kaydedilecek? Stale olup olmadığı nasıl anlaşılacak? Hangi agent bu kaynağa güvenebilir? Dış veri bir kararı değiştirirse impact nasıl taşınacak?

Capability addition ≠ system integration.

Bir de “sistem büyür” framing’inin kendisi tehlikeli.

Her ihtiyaca yeni agent, yeni tool, yeni dosya eklemek zorunda değiliz. Bazen doğru hareket iki rolü birleştirmek, eski mekanizmayı kaldırmak veya mevcut capability’nin kapsamını değiştirmek.

Yani iyi agentic sistem sadece genişlememeli.

İhtiyaca göre yeniden şekillenebilmeli.

Yeni kutu çizmek kolay.

Zor olan, kutu geldikten sonra sistemin geri kalanının hâlâ aynı sistem olarak çalışmasını sağlamak.
