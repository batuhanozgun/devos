*Filed verbatim from the researcher's final report for W-C01-41 (fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH, 2026-10-10; read only; taken with tools/subagent_audit.py last; DISCIPLINES OK).*

**Question.** What do Claude's plans, prices and account ownership rules say about row 17's account-change option? This feeds W-C01-41's `batu` decision record. I read everything on 2026-10-10 around 23:20Z, as raw page text. The Claude Code docs pages (code.claude.com/docs/en/…) and the pricing page show no last-updated date. Help-center dates given below are each article's own.

## Disciplines (D1–D9)
D1: yes: I kept four options open (no change, a second account, Team, Enterprise) and marked as inference that a second account separates anything, since that rests on account scope rather than a stated cross-account limit.
D2: uncertain: the item leans toward "second account", so I reported the evidence against it (GitHub's free machine-account limit, Team having no network secrets) as fully as the evidence for it.
D3: yes: I gave one numbered answer per question and stayed at plans, prices, ownership and documentation (D-017).
D4: no
D5: yes: I read raw pages rather than search summaries, and one summary turned out wrong (it said Team needs five members; the article says two).
D6: no
D7: no
D8: yes: I confirmed `main` is at `aeb94f8` and read W-C01-41, EV-C01-003 and Appendix E section 3 before the web reading.
D9: uncertain: prices and terms need current primary sources (D9 item 4), so I did not consult the library; this is new research with candidate status.

## Findings (stated unless marked)

**1. Plans and prices**
- Cloud sessions "are available on Pro, Max, and Team plans, and for Enterprise users with premium seats or Chat + Claude Code seats" (claude-code-on-the-web).
- "Routines are available on Pro, Max, Team, and Enterprise plans", and they "are in research preview" (routines).
- claude.com/pricing (excludes tax; "subject to change"):
  - Pro: $20 a month billed monthly, or $17 a month billed annually ($200 up front).
  - Max: "From $100", monthly billing only. Support article 11049741 (updated 2026-10-07) gives Max 5x at $100 and Max 20x at $200.
  - Team, "for teams of 2 to 150": Standard seat $25 monthly or $20 annual; Premium seat $125 or $100. Article 9266767 (updated 2026-10-07): "Team plans require a minimum of two members."
  - Enterprise: "US$20/seat/month, billed annually", plus usage at API rates.
- Extra usage is now called "usage credits" (article 12429409, updated 2026-10-08). He turns it on with "Enable", a payment method and prepaid funds, and it is "charged separately". The routines page says that without it, "additional runs are rejected until your usage window resets". No page says "off by default"; that it is off until he turns it on is my inference from those steps.

**2. What belongs to the account**
- "Routines belong to your individual claude.ai account. They are not shared with teammates" (routines).
- "Environments you create are personal to your account" (cloud-environments).
- On sessions: "you can only pull a cloud session into your terminal when you are authenticated to the same account", and they share "rate limits with all other Claude and Claude Code usage within your account". If you have "signed in to a different Claude account or organization", the session "wasn't found" (ultrareview).
- Not stated: no sentence says one account's sessions cannot reach another account's sessions or routines. That a second account's are outside the first is my inference from this account scope.

**3. What a second account would involve**
- **Subscription and limits:** it needs its own plan. Since usage is counted per account, its limits would be separate (inference).
- **GitHub connection:** each Claude account connects its own GitHub, through the GitHub App or `/web-setup`. The token is stored "encrypted with your claude.ai account" (web-quickstart). Nothing I read says whether one GitHub account may connect to two Claude accounts.
- **Reusing `batuhanozgun-devos`:** GitHub's terms (effective 2026-04-27) say "Multiple users may direct the actions of a machine account", so reuse is allowed. They also say "no more than one free machine account in addition to your free Personal Account".
  - A routine's actions "appear as you" (routines). If both accounts share the machine account, GitHub would show both accounts' work as one identity (inference).
  - A separate GitHub identity would have to be a paid account or his personal account (inference).
- **One person, two accounts:**
  - The Consumer Terms (effective 2025-10-08) say nothing either way; they only forbid making an account "available to anyone else".
  - Article 8287232 (updated 2026-08-17) allows "a maximum of three Claude accounts" per phone number.
  - The Usage Policy in force since 2025-09-15 bars multiple accounts only for listed abusive purposes. The version due to take effect 2026-11-12 adds "create multiple accounts" for those same purposes.
  - In my reading, none of these addresses a separation like DevOS's.

**4. Team or Enterprise**
- Environments and routines stay personal to each member. Session visibility is "Private" or "Team".
- Owners can create environments "shared with every member", and can turn routines off "for all members".
- Against: network secrets "aren't available on Team or Enterprise plans yet". For self-hosted environments: "Dispatch has no per-environment access control: any member of your Anthropic organization can dispatch a session to any of its environments" (self-hosted-environments-deploy).
- Nothing documented separates members beyond the per-account scope above.
- Cost: Team at two Standard seats starts at $50 a month ($40 annual). Enterprise is seat price plus API-rate usage.

**5. A documented per-environment limit that would make a second account unnecessary**
None is stated. This agrees with EV-C01-003 section 2 item 1. My search of the full documentation text found only the self-hosted line above, which states the opposite. Owners' organization switches act on all members, not per environment.

## Options a decision record could offer Batu
- **A. No change.** $0. Separation rests on the guard alone (EV-C01-003). DevOS keeps using his account's limits alongside his other work.
- **B. A second individual account for the audit and exam environments.** Pro $20, or Max $100 or $200, a month.
  - His main account is unchanged, and DevOS's audit and exam use leaves his limits (inference).
  - He keeps a second login and connects GitHub to it.
  - Reusing `batuhanozgun-devos` means GitHub sees one identity. A separate identity costs a paid GitHub account, or means using his personal one.
- **C. Team, two seats.** From $50 a month. Network secrets are lost. Whether his Max account is affected was not read.
- **D. Enterprise.** Per seat plus usage-based cost, bounded only by the spend limits admins set.

## Open
- Not read: GitHub's paid-account prices; what Team Owners can see of members' sessions; whether a Max account can coexist with a Team membership.
- The pages are undated and routines are a research preview, so this should be read again when the platform changes.
- At the start I ran `mkdir -p` on the session scratchpad. No file was written.

## For the decision
These findings leave EV-C01-003's design unchanged. They supply the costs for B to D, and the GitHub-identity cost that B carries.

Guard denials: none.
