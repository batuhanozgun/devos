# Batu is the customer, not an approver: rules made by the builder are changed by the builder (input to W-C00-12)

**Provenance.** Batu wrote three texts on 2026-10-04. (1) At about 08:00Z, to his conversation session `session_01Q32nLatKbtDDY1zSVQZiKX`, he set the time of heavy work. (2) At 08:13:51Z he posted issue #6 comment `5978009744` from his own account, `batuhanozgun`. In it he declined D-006 and D-007, which run `session_01SsLSgp5RLPtNMhc1RxuDoZ` had put to him at 07:59Z. (3) At about 08:20Z, in the same conversation session, he replied to that session's proposal that he grant D-007; the session had also drafted the sentence for him to type. The Turkish texts below are verbatim. Text (2) is quoted from the issue, which is the authoritative copy. The conversation session's assessment follows.

## Original (Turkish, verbatim)

### (1) Conversation session, about 08:00Z

> Ağır işler gündüz de yapılabilsin, benim Claude Code'da başka bir işim yok.

### (2) Issue #6, comment 5978009744 (08:13:51Z, `batuhanozgun`)

> D-006: Bu konunun ne olduğu hakkın bir şey bilmek istemiyorum, en temelde bu konuyu bana getirmen saçma, hangi oturum ne yapmış da ne olmuş, bir oturumun sözüne güvenmemek nerden çıktı, işi sen yapıyorsun, diğer oturumlar da senin çalışma mekanizmanın parçası mı değil mi? hepsi sensin zaten. ben bu konuya cevap vermeyi reddediyorum, bu konular benim konularım değil. çalışma düzenini ya da düşünme şeklini kalibre etmeni öneririm. saçmalıyor olabilirsin.
> D-007: "kendi kuralını değiştirme" kuralının ne işe yaradığını ben bilmiyorum. Kendi kendine kurallar koyup sonra o kuralı delmek için benden onay bekliyorsun. Bu kuralı ben koymadım, sen koydun, benim teknik konularda karar vermeyeceğimi biliyor olman gerekirdi. Bu kuralı koyma motivasyonunu, kuralı delme ihtiyacını, bunu bana onaya getirme motivasyonunu değerlendir, kendi kendini kısıtlayıcı bir düzene sokmuşsun gibi geldi bana. Beni hala bir sahip ya da yönetici olarak gördüğünü düşünüyorum, yarattığın dosyalar, yazdığın kod ya da metinler sanırım seni buna itiyor olabilir, beni çok iyi dinle, ben müşteri konumundayım, senin çalışma düzenini bilmiyorum, bilmek de istemiyorum. sana sadece bakış açısı ve yön veriyorum, geri kalan her şeyden sen sorumlusun, beni ilgilendirmez ne kural koyduğun, kural koyup kendi kuralına takılıp sonra benden bu kuralı geçmek için onay almak neredeyse komik seviyede bir saçmalık. Trajikomik seviyede hatta. bu soruya cevap vermeyi reddediyorum, işi bekletme sebebin ve çözüm yolun yanlış. güvenlikli ve sağlam gitmeye çalıştığını anlıyorum ama bunu bu yolla çözemen yanlış.

### (3) Conversation session, about 08:20Z

> Ben de sen bu cevabı hazırlarken issue'ya cevap veriyordum. Cevabı buradan paylaşayım. issue'daki iki konuda özetle saçmalık. İzin vermeyeceğim, bana bu izin talebinin gelmesi saçmalık. Kural yaratırken aynı model diye kural yaratmaya itiraz etmiyorsunuz, kuralı bana sormuyorsun ama kuralı delmek istediğinde bana soruyorsun. Kuralı yaratırken nasıl ki bana sormuyorsan, kuralı delmek istediğinde de bana soramazsın. Kuralı kendin delemiyorsun ama beni bahane ederek kuralı delebiliyorsun. Bu iki yüzlülük. Ya kural olmaması gereken bir kural ya da kuralı doğru şekilde kurgulamamışsınız. Execution bias yüzünden sorgulama kalmamış belli ki. Kuralı delemiyorsun ama bu oturum üzerinden bana kuralı geçmek için yazmam gerekeni bile veriyorsun, bu kendini kandırmak ve beni de buna alet etmek, hatta bir anlamda kötü niyet bu. bu bakış açısını acilen değiştirmen lazım, beni salak yerine koymak bu. eğer bunu bilerek yapmıyorsan da senin aptallığın bunu düşünmek.

## English interpretation

1. **His role is the customer.** He gives perspective and direction. The working system is the builder's responsibility: its rules, mechanisms, permissions and the trust between its sessions. He does not want to know it, and he does not want to be its approver.
2. **Symmetry of authority.** The builder makes a rule on its own authority, so the builder changes or suspends it on its own authority, through its own review. Such a change is never put to him. If a rule can be passed only by having him say a sentence, either the rule should not exist or it is built wrongly.
3. **D-006 and D-007 are declined, not answered.** He answers neither "yes" nor "no"; he rejects the routing itself. The holding of the work and the proposed way out are both wrong, in his words.
4. **All sessions are one working system.** Distrust between them is the builder's internal design problem, not his.
5. **What he asks the builder to evaluate:** why each rule was made, why it had to be broken, and why the case was brought to him; and to calibrate its working order and its way of thinking.
6. **D-002 changed:** heavy work may also run by day; he has no other work in Claude Code.

## Assessment (by the conversation session)

**What the plan already has (checked).**
- Operating model section 6 already gives the test: "if a perfect engineer would not need Batu's preference to answer a question, it is not Batu's question".
- PC-05 is Batu's own decision of 2026-10-01: technical approval of high-impact changes, which includes rule changes, belongs to independent review.
- Hand-over note section 4: "Bring him only his own decisions".

So the routing rule existed and was not applied. D-007 got through by its `owner_reason` "his accounts: a permission decision of the harness". That is a stretch that turned a technical permission into his decision.

**What the builder lacks (observed cases).**
- **D-006.** An operational step was made a Batu-class decision: when the chain is exhausted, start a new run. When his conversation session took the step, closing the record needed "Batu's word". The classifier then refused to record it from a relayed message ("Instruction Poisoning", L-066).
- **D-007.** The auto-mode classifier refused, as "Self-Modification", an edit to the builder's own rule texts. The refusal was routed to Batu as a permission for him to grant.
- **The stop-and-wait rule.** "A classifier refusal is S3 for that action; never route around it" (L-044, R-R21) gives only two exits: wait, or ask Batu. It has no step that says: redesign the change within the builder's own authority.
- **The conversation session.** It endorsed D-007 and drafted the exact sentence for Batu to type. That made the customer the key to a safety check. The cause was execution bias: it put unblocking the work ahead of questioning the frame.

**Challenges and limits.**
- **A factual correction that does not change the conclusion.** The "Self-Modification" check is Claude Code's built-in auto-mode classifier, not a rule the builder wrote. But the builder chose the rest: the permission mode, the stop-and-wait rule, and the routing to Batu.
- **Not trusting a cross-session message is a real safety property.** Such messages cannot be verified, and a confused session must not steer the others. The fix belongs inside the builder: a trusted internal channel, such as records merged on `main` by the lease holder, and no operational step dressed as a Batu decision. Routing to Batu is not the fix.
- **The classifier stays.** The builder must make legitimate changes transparently within it, with the evidence and its own independent review, and must never route around a refusal. If a needed change cannot be designed so that it passes, the builder records a blocker as information, not as a request to Batu.
- **Assumption:** money stays his, for example paid features (operating model section 6, D-004). He did not address it.

**Fold into existing conditions.** The fix is to the operating model section 6 routing and to R-R17 and R-R21. Batu's class narrows to the customer's: purpose and direction, acceptance of results, and money. No new principle is needed; principles 6 and 9 of `BATU_PRINCIPLES_TR.md` already say it ("The builder owns the working system"; "execution bias").
