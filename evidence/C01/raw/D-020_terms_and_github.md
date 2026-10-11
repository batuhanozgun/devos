*Filed verbatim from the researcher's final report for W-C01-41 / D-020 (fresh-context subagent of working session session_01XyxvJd3RayQk4HCrjurbVH, 2026-10-11; read only; taken with tools/subagent_audit.py last; DISCIPLINES OK). Asked before Batu answered D-020; he chose (a), so it bears on D-020 only if D-020 is reopened.*

# W-C01-41 / D-020 researcher report: several Claude accounts for one person, and one GitHub account across several Claude accounts

**Question.** D-020 asks Batu where the working, audit and exam environments should live: (a) all in his account, or (b)/(c) partly or wholly in one or two further Pro accounts, or (d)/(e) an organization. Two facts were missing:
1. Do Anthropic's terms and help center allow one person to hold more than one Claude account, including more than one paid subscription?
2. Can one GitHub account be connected to more than one Claude account for cloud sessions, and what do GitHub's terms say about machine accounts and about one person holding several accounts?

**How I read.** Everything was read on 2026-10-11 as raw page text: help-center pages with the HTML stripped, Claude Code docs as their `.md` source, and GitHub docs through the docs article-body API. Search summaries were not used as evidence. Help-center dates below are each article's own last-modified date. The code.claude.com pages carry no date. `main` was at `d4b9fe5`.

## Disciplines (D1–D9)
D1: yes: I kept "allowed", "not prohibited" and "not stated" apart, and kept in a low-probability coupling (a ban on one account reaching the others) because it would change the "effect on your other work" lines.
D2: uncertain: D-020 recommends (c), so I reported the evidence that cuts against extra accounts (the broader 2026-11-12 Usage Policy wording, the ban-circumvention rule, the unresolved GitHub question) as fully as the evidence for them.
D3: yes: I answered only the two bounded questions and the requested check of D-020's lines, and I recommend no option.
D4: no
D5: yes: search summaries disagreed about article 8287232, so I read raw text, and before any "not stated" I scanned all 361 English help-center articles and all 222 Claude Code docs pages.
D6: no
D7: no
D8: yes: I confirmed `main` at `d4b9fe5` and read D-020 and the earlier W-C01-41 researcher report (`/home/user/devos/evidence/C01/raw/W-C01-41_account_options.md`), and built on that report rather than repeating it.
D9: uncertain: terms and product behaviour need current primary sources (D9 item 4) and the task bars the library, so I did not consult it; this is new research with candidate status, read 2026-10-11.

## Findings

### Q1. More than one Claude account, and more than one paid subscription

**Answer.** Anthropic's help center and docs treat one person holding more than one Claude account as normal, and allow at most three accounts per verifying phone number. No source says either way whether one person may hold more than one paid (Pro) subscription. The stated bans are on sharing an account, on creating or using several accounts for listed abusive purposes, and on getting around a ban with another account.

**Per-phone limit (stated).** Article 8287232, "Verify your phone number", updated 2026-08-17 (https://support.claude.com/en/articles/8287232-verify-your-phone-number):
- "We only allow a maximum of three Claude accounts to be verified with the same phone number."
- "There isn't a way to change your phone number associated with your Claude account once it has been verified."
- Freeing a number means logging in to one of the accounts and asking Support to unlink it.

**One person with several accounts, described as normal (stated).**
- Article 15520349, Cowork on web, desktop and mobile, 2026-10-06: "If you use Claude at work and at home and want them separate, use a separate account for each. Shared logins aren't supported."
- Article 15672559, monthly recap, 2026-07-09, a Free/Pro/Max feature: "If you use more than one Claude account, each account's recap covers that account only."
- Article 15402193, 2026-09-25: "someone has two Claude accounts: a personal account using their personal email, and a work account using their work email."
- Article 9450526, data export, 2026-07-08: "we don't support migrating data between personal accounts."
- https://code.claude.com/docs/en/authentication: "To stay signed in to multiple accounts at once, such as work and personal accounts, give each account its own configuration directory."
- https://code.claude.com/docs/en/errors, on an account hold: "If you have another Claude account or an API key that isn't affected by the hold, you can keep working while the hold is resolved".

**Bans and conditions (stated).**
- Consumer Terms, effective 2025-10-08 and still current (https://www.anthropic.com/legal/consumer-terms):
  - "You may not share your Account login information, Anthropic API key, or Account credentials with anyone else. You also may not make your Account available to anyone else."
  - "You agree to provide correct, current, and complete Account information".
  - Section 3: you must not abuse or disrupt the Services, "including, for example, … bypassing any of our systems or protective measures."
- Usage Policy in force, effective 2025-09-15 (https://www.anthropic.com/legal/archive/22742366-2ef0-4c7a-a833-6523f10d3944):
  - "Coordinate malicious activity across multiple accounts to avoid detection or circumvent product guardrails…"
  - "Circumvent a ban through the use of a different account, such as the creation of a new account, use of an existing account…"
  - "Utilize automation in account creation".
  - Its bypass clause is limited to bypassing restrictions "for the purposes of instructing the model to produce harmful outputs".
- Usage Policy effective 2026-11-12, already published at https://www.anthropic.com/legal/aup:
  - "Coordinate malicious activity across multiple accounts, or create multiple accounts, to avoid detection, circumvent product guardrails, or generate identical or similar inputs that otherwise violate our Usage Policy"
  - "Intentionally bypass or interfere with capabilities, restrictions, or guardrails established within our products, including by circumvention of the account sign-up or log-in process … without prior authorization from Anthropic"
- Article 13189465, log in, 2026-05-19: "Subscription plans can only be used by subscribers, and the usage included in these plans is designed to support ordinary use of native Anthropic applications, including the Claude web, desktop, and mobile applications and Claude Code."
- Article 12109679, 2026-03-16, quotes the sign-up error "The email you used is either associated with an existing account or an account that was active within the last 30 days".

**Interpretation and inference (labelled).**
- *Interpretation:* further Pro accounts held and used only by Batu fit the "more than one Claude account" pattern above. The ban on sharing is not engaged, because nobody else uses them.
- *Inference:* each further personal account needs its own email address. This rests on the 12109679 error message, and on same-email coexistence being described only for a personal account paired with a Team or Enterprise account (13189465, 9267400). It is not stated as a rule.
- *Interpretation:* no source names usage limits as "product guardrails", "restrictions" or "protective measures". It is not stated whether paying for several subscriptions to get more total usage could be read under the broader 2026-11-12 wording.
- *Interpretation:* the ban-circumvention rule ties the accounts together. If any one of his accounts were banned, going on with another one would be "use of an existing account". Separate accounts therefore do not separate enforcement risk. No source says whether a hold or ban on one account extends to others verified with the same phone number.

**Counter-evidence and ambiguity.**
- 8287232's error FAQ says "already three other Claude accounts", which reads as if a fourth were possible; its limit sentence says three. I take the limit sentence.
- Most of the examples are a work/personal pair, often a personal account plus a Team or Enterprise account. None describes one person with three personal paid accounts. The monthly-recap line is the one that applies to personal plans specifically.
- Article 8452276 (2026-03-16) describes moving to a new email by cancelling, unlinking the phone number and deleting the old account. That is a replace path, not a keep-both path, but it forbids nothing.

**Not stated, and where I looked.** No sentence permits or forbids one person holding more than one paid subscription. There is no per-person limit, only the per-phone one. Nothing addresses buying several subscriptions to get more usage. I looked in:
- the Consumer Terms and both Usage Policy versions;
- a sentence scan of all 361 English articles in `support.claude.com/sitemap.xml` for multiple, second, separate, additional or other accounts or subscriptions, "per person", sharing, and circumvent/evade;
- a scan of all 222 pages in `code.claude.com/docs/llms.txt` for multiple-account sentences and for limit circumvention;
- the usage-limit articles 11647753 (2026-10-08) and 9797557 (2026-09-22).

### Q2. One GitHub account connected to more than one Claude account

**Answer.** Not stated. The Claude Code docs describe the GitHub connection only from the Claude account's side, as one connection per Claude account. They say nothing about whether the same GitHub account, or the same Claude GitHub App installation, can be connected to a second Claude account at the same time, or whether doing so cuts off the first.

**What the Claude Code docs say (stated).**
- https://code.claude.com/docs/en/web-quickstart:
  - "Connecting GitHub is a one-time step."
  - "When you connect, Claude also links the GitHub accounts you own to your Claude organization, if they have the Claude GitHub App installed."
  - The `/web-setup` token: "Anthropic stores it encrypted with your claude.ai account".
  - "If you already connected GitHub in the browser, `/web-setup` warns you that continuing replaces that connection for your cloud sessions."
- https://code.claude.com/docs/en/claude-code-on-the-web, "GitHub authentication options", gives two routes:
  - the GitHub App: "Authorize the Claude GitHub App";
  - `/web-setup`, which sends "your local `gh` CLI token to your Claude account" and reaches "Any repository your `gh` token can access, whether or not the Claude GitHub App is installed". Threads in a project still need the Claude GitHub App.
- https://code.claude.com/docs/en/admin-setup, Team and Enterprise only: "Unlinking leaves the Claude GitHub App installed on GitHub, and the account is linked again the next time one of its owners connects GitHub to Claude."
- https://code.claude.com/docs/en/claude-projects: "the GitHub App can be installed on GitHub without being linked to the account you connected to Claude."
- GitHub's side, https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/token-expiration-and-revocation: "There is a limit of ten tokens that are issued per user/application/scope combination". This sits under a heading about OAuth apps.

**Inference.**
- On GitHub's side, one user can hold several tokens for the same app. Nothing GitHub documents here forces one Claude account per GitHub account. Whether Anthropic's side enforces one-to-one is not documented.
- The `/web-setup` route carries the GitHub CLI's token rather than a Claude-app authorization. No doc says that token, or that GitHub user, cannot be sent to a second Claude account.
- Only an actual attempt would settle this. That is an account action, so I did not try it.

**Not stated, and where I looked.** I scanned all 222 docs pages for sentences pairing GitHub with Claude account, another, multiple, same, different, already, disconnect, revoke, reconnect or switch, and separately for "another/different/multiple … account". I also read help-center article 10167454 on the GitHub integration (2026-09-02) and ran the full help-center scan above. Some search hits pointed to GitHub issues in another repository, or to mirrors of them; I did not open them, because the task bars that.

**GitHub's terms (stated).** Terms of Service, effective 2026-04-27 (https://docs.github.com/en/site-policy/github-terms/github-terms-of-service):
- "Accounts registered by "bots" or other automated methods are not permitted. We do permit machine accounts:"
- "A machine account is used exclusively for performing automated tasks. Multiple users may direct the actions of a machine account, but the owner of the Account is ultimately responsible for the machine's actions. You may maintain no more than one free machine account in addition to your free Personal Account."
- "One person or legal entity may maintain no more than one free Account (if you choose to control a machine account as well, that's fine, but it can only be used for running a machine)."
- "Your login may only be used by one person — i.e., a single login may not be shared by multiple people."

"Types of GitHub accounts", undated (https://docs.github.com/en/get-started/learning-about-github/types-of-github-accounts):
- machine users are accounts created "to automate activity on GitHub";
- "If you're currently using more than one personal account that you created for yourself, we suggest combining the accounts."

**Interpretation.** Batu alone directing `batuhanozgun-devos` from several Claude accounts stays within both "multiple users may direct" and the one-person login rule, provided the account is used only for automated tasks. The limits apply only to free accounts, so a further machine account would have to be paid. The "combining" line is a suggestion, not a rule.

## For the decision
Nothing here changes an option, a price or the option list. Checked against D-020's lines:
- **Line 9 (P4) and line 26 (option c's phone caveat):** confirmed as written. Two setup facts are not in the record: the verifying phone number can never be changed afterwards (stated), and each further account will need its own email address (inference).
- **Line 30 (GitHub note):**
  - The machine-account quote and the one-free-machine-account limit are confirmed verbatim.
  - "What no one has read yet is whether one GitHub account can be connected to more than one Claude account" can now say: read on 2026-10-11, not stated in the docs.
  - The "possible extra cost" condition therefore stays open until it is tried at C02. GitHub's own token model does not force one-to-one (inference), and `/web-setup` is a second connection route (inference).
- **Lines 19 and 21 ("adds accounts to your name"):** options (b) and (c) rest on "not prohibited" plus help-center wording that treats several accounts per person as normal. No source states that several paid subscriptions per person are allowed.
- **Lines 24–26 (effect on his other work):**
  - The new Usage Policy takes effect on 2026-11-12, probably before C02. Its "create multiple accounts … to … circumvent product guardrails" and its broader "bypass … restrictions" do not name usage limits. Lines 25–26 still present separate limits as an effect, and a reader could weigh that effect against this wording.
  - Under the ban-circumvention rule, a ban on any one of his accounts would bar using the others (interpretation). Account separation does not separate enforcement risk.
- **(d) and (e):** unaffected.

## Open
- **Not read:** GitHub's paid-account prices; any GitHub App-specific limit on user tokens (only the OAuth-app sentence was read); the Claude GitHub App's page on github.com; third-party pages and issue hits from search (seen only as search summaries, not used as evidence).
- **Freshness:** the docs pages are undated; several help articles changed within the last week; the Usage Policy changes on 2026-11-12. Read again before C02.
- **Noticed, outside the question:** Consumer Terms section 3 bars access "through automated or non-human means … Except … where we otherwise explicitly permit it". I did not analyse this.
- **Method:** Bash was used only to read pages with `curl`, piped to text filters; no file was written.

## Guard denials
none

**Sources** (all read 2026-10-11)
- [Verify your phone number (8287232)](https://support.claude.com/en/articles/8287232-verify-your-phone-number)
- [Consumer Terms](https://www.anthropic.com/legal/consumer-terms)
- [Usage Policy, effective 2026-11-12](https://www.anthropic.com/legal/aup)
- [Usage Policy, effective 2025-09-15](https://www.anthropic.com/legal/archive/22742366-2ef0-4c7a-a833-6523f10d3944)
- [13189465 Log in](https://support.claude.com/en/articles/13189465-log-in-to-your-claude-account)
- [9267400 Move personal account](https://support.claude.com/en/articles/9267400-move-your-personal-claude-account-to-a-team-or-enterprise-organization)
- [15520349 Cowork](https://support.claude.com/en/articles/15520349-use-claude-cowork-on-web-desktop-and-mobile)
- [15672559 Monthly recap](https://support.claude.com/en/articles/15672559-see-your-monthly-recap)
- [15402193 Verified-domain connectors](https://support.claude.com/en/articles/15402193-restrict-verified-domain-connectors-to-your-enterprise)
- [9450526 Export](https://support.claude.com/en/articles/9450526-export-your-claude-data)
- [12109679 New account after deletion](https://support.claude.com/en/articles/12109679-creating-a-new-account-after-deletion)
- [8452276 Change email](https://support.claude.com/en/articles/8452276-how-do-i-change-the-email-address-associated-with-my-account)
- [10167454 GitHub integration](https://support.claude.com/en/articles/10167454-use-the-github-integration)
- [Help-center sitemap](https://support.claude.com/sitemap.xml)
- [web-quickstart](https://code.claude.com/docs/en/web-quickstart)
- [claude-code-on-the-web](https://code.claude.com/docs/en/claude-code-on-the-web)
- [admin-setup](https://code.claude.com/docs/en/admin-setup)
- [claude-projects](https://code.claude.com/docs/en/claude-projects)
- [authentication](https://code.claude.com/docs/en/authentication)
- [errors](https://code.claude.com/docs/en/errors)
- [Claude Code docs index](https://code.claude.com/docs/llms.txt)
- [GitHub Terms of Service](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service)
- [Types of GitHub accounts](https://docs.github.com/en/get-started/learning-about-github/types-of-github-accounts)
- [GitHub token expiration and revocation](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/token-expiration-and-revocation)
