# EV-C01-014 · W-C01-23: row 16, the second model's free tier: its terms and published limits (read 2026-10-11)

**What this is.** The record W-C01-23 asks for: plan C01 row 16 with B2 = (1), judged point by point against W-C01-23's acceptance block. Row 16 is a reading row. It needs no probe setup, so the PC-21 note under C01 changes nothing in it, except that item 9's claim form applies to every fact taken from documentation. Here the "platform" is the provider of B2, Google's Gemini API. Only the provider's public pages were read. No account, project, key or request was used, and nothing was tested.

## Evidence envelope (plan Section 8 item 9)

| Field | Value |
|---|---|
| Source commit | `main` `f957519e4afc5fc11241f7ea1b7b2dd350503527` (PR #221), at which W-C01-23's block is in force and this record is written. Plan line numbers below are at this commit |
| Deployment configuration | None of DevOS's. No Google account, project or Gemini key exists for DevOS; the key is created in C11 (plan Section 12 item 5, line 1225). The pages were read anonymously, by plain HTTPS GET (`curl`, `?hl=en`, no sign-in, no cookie), from the working session's cloud container (`session_01XyxvJd3RayQk4HCrjurbVH`) through its outbound proxy. A signed-in account may see more (G7) |
| Criterion version | W-C01-23's acceptance block, `plan/work/W-C01-23.md` blob `ccac67b57052e6847bc034ea88ca3c1a3aa23ed6` at `f957519`. The block's text dates from `62f9e46` (2026-10-06 14:12Z); the re-plan (`44cef4e`, W-C01-31) changed only `depends_on`. Read with plan C01 row 16 (line 959) and the PC-21 note under C01 (lines 963-972) |
| Input | The provider's pages G1 to G7 below. The texts they are weighed against: plan 5.8 (lines 579, 583), plan 11.2, B2 (line 1189) and its Turkish original (line 1438), and the block's three fixed fail results |
| Actual observation | Points 1 to 4 below: what the pages state, quoted, and what they do not state |
| Raw evidence ID | The seven fetches in "Sources" (address, HTTP status, server time, `Last-Modified` header, the page's own date). The pages' HTML is not byte-stable: a second fetch of G1 differed in page furniture, while its article text was identical. So no hash is given. Quotes are verbatim from each page's article text. The pages state their content is licensed under CC BY 4.0 "except as otherwise noted" |
| Independence level | A reading of the provider's documentation by the executor's producer subagent (same session, fresh context; declared, Ek A 5.3). Not independently tested. Judged by a fresh-context checker (W-C01-23's acceptance) |

## Sources (all read 2026-10-11; times are the server's `Date` header)

| ID | Page (official, `ai.google.dev` or `developers.google.com`) | The page's own date | `Last-Modified` | Read |
|---|---|---|---|---|
| G1 | Gemini API Additional Terms of Service, https://ai.google.dev/gemini-api/terms | "Effective March 23, 2026"; "Last updated 2026-04-28 UTC" | 2026-04-28 03:23:11Z | 12:31:18Z |
| G2 | Rate limits, https://ai.google.dev/gemini-api/docs/rate-limits | "Last updated 2026-10-09 UTC" | 2026-10-09 22:11:39Z | 12:31:19Z |
| G3 | Gemini Developer API pricing, https://ai.google.dev/gemini-api/docs/pricing | "Last updated 2026-10-09 UTC" | 2026-10-09 22:11:39Z | 12:31:19Z |
| G4 | Billing, https://ai.google.dev/gemini-api/docs/billing | "Last updated 2026-09-28 UTC" | 2026-09-28 23:10:37Z | 12:31:20Z |
| G5 | Google APIs Terms of Service, https://developers.google.com/terms (G1 requires accepting it) | "Last modified: November 9, 2021" | 2025-08-06 20:56:26Z | 12:35:25Z |
| G6 | Available regions for Google AI Studio and Gemini API, https://ai.google.dev/gemini-api/docs/available-regions | "Last updated 2026-04-28 UTC" | 2026-04-28 03:23:11Z | 12:35:26Z |
| G7 | AI Studio's rate-limit view, https://aistudio.google.com/rate-limit (G2 links to it) | — | — | 12:35:42Z: HTTP 302 to `accounts.google.com/ServiceLogin` |

**Against the earlier reading.** The phase-A research run read G1 and G2 on 2026-10-06 (`evidence/C01/phase_a/raw/04_research_C.md`:73-79). G1 is unchanged since (the same "updated 2026-04-28"). G2 has changed: it read "updated 2026-09-02" then and reads "Last updated 2026-10-09" now. What changed is not known, since no copy of the earlier version was kept. That reading was recorded after this block was fixed (`f2c8412`, 2026-10-06 16:10Z, against `62f9e46` at 14:12Z), so the fail results below were fixed before any C01 reading of the pages.

## How the criterion is read

- **"published limits"** are what the provider publishes on its official pages. The numbers a signed-in project shows in AI Studio are not published. They are the limits "of the real key", which the row moves to C11.
- **"the models that 5.8's two jobs would use"**: plan 5.8 names no model (line 583). So point 4 (iii) is read for every text model the free tier offers (G3), and the choice of model is left to the stages that use them (C08 builds the gateway; C11 runs the two jobs).
- **"a use beyond the one B2 = (1) weighed"**: B2's weighed use, verbatim: "content sent on the free tier may be used in Google's product development. So only fake data and content that will go into public repositories is sent; the private library is never sent" (line 1189); Turkish original: "ücretsiz katmanda gönderilen içerik Google'ın ürün geliştirmesinde kullanılabilir" (line 1438). Plan 5.8 gives its source as "[Verified: Google developer forum and pricing pages]" (line 579). Every use of content that G1 and G5 state is compared with it in point 4 (ii).

## Point 1. The free tier's current terms, including the use of the content sent

Met: read from G1 (page dated 2026-04-28, effective 2026-03-23) and G5 (dated 2021-11-09), on 2026-10-11.

- **What counts as the free tier.** "Any Services that are offered free of charge like direct interactions with Google AI Studio or unpaid quota in Gemini API are unpaid Services (the "Unpaid Services")." And: "Your access to Gemini API is a "Paid Service" only when accessing the API through a Cloud Project associated with an active billing account." (G1, "Unpaid Services"; "Paid Services")
- **Use of the content sent.** "When you use Unpaid Services, including, for example, Google AI Studio and the unpaid quota on Gemini API, Google uses the content you submit to the Services and any generated responses to provide, improve, and develop Google products and services and machine learning technologies, including Google's enterprise features, products, and services, consistent with our Privacy Policy." (G1, "Unpaid Services", "How Google Uses Your Data")
- **Human review.** "To help with quality and improve our products, human reviewers may read, annotate, and process your API input and output. Google takes steps to protect your privacy as part of this process. This includes disconnecting this data from your Google Account, API key, and Cloud project before reviewers see or annotate it. Do not submit sensitive, confidential, or personal information to the Unpaid Services." (G1, same section)
- **The licence.** G1: the licence granted under G5's "Submission of Content" "also extends, to the extent required under applicable law for our use, to any content (e.g., prompts, including associated system instructions, cached content, and files such as images, videos, or documents) you submit to the Services and to any generated responses." G5, section 5 b: "For the sole purpose of enabling Google to provide, secure, and improve the APIs (and the related service(s)) and only in accordance with the applicable Google privacy policies, you give Google a perpetual, irrevocable, worldwide, sublicensable, royalty-free, and non-exclusive license to Use content submitted, posted, or displayed to or from the APIs through your API Client. "Use" means use, host, store, modify, communicate, and publish."
- **Region.** "If you're in the European Economic Area, Switzerland, or the United Kingdom, the terms under "How Google uses Your Data" in "Paid Services" apply to all Services, including Google AI Studio and unpaid quota in the Gemini API". (G1) Batu's local time is UTC+3 ("11:07 his time" for 08:07Z, `plan/decisions/D-021.md`:17), which points to Türkiye. That is an inference, not shown. On it, the unpaid terms above apply to him.
- **Who may use it.** "You must be 18 years of age or older to use the APIs." "Use of Google AI Studio and Gemini API is for developers building with Google AI models for professional or business purposes, not for consumer use." "You may only access the Services (or make API Clients available to users) within an available region." (G1, "Age Requirements", "Use Restrictions") G6 lists "Türkiye" among the available regions.
- **Not stated** in G1: how long unpaid content is kept. Paid content is logged "for a limited period of time" for abuse detection; no period is given for unpaid content.

## Point 2. The free tier's published limits

The reading is met, on G2, G3 and G4. The free tier's numbers could not be checked in C01, and that part moves to C11 (point 3; note N-164 on `plan/work/C11.md`).

What the provider publishes about the free tier's limits:
- "Rate limits depend on a variety of factors (such as your usage tier) and can be viewed in Google AI Studio." "Specified rate limits are not guaranteed and actual capacity may vary." (G2, "Gemini API rate limits")
- "Rate limits are applied per project, not per API key. Requests per day (RPD) quotas reset at midnight Pacific time." "Rate limits are more restricted for experimental and preview models." They are "usually" measured as requests per minute, input tokens per minute and requests per day. (G2, "How rate limits work")
- The Free tier's qualification is "Active project or free trial", with billing tier cap "N/A". Its spend-based limit is "N/A". (G2, "Usage tiers", "Spend-based rate limits"; the same table in G4)
- "New accounts begin on the Free Tier, which allows access to certain models in the Gemini API and AI Studio, up to the models' free tier rate limits." (G4, "About billing and tiers")
- "Rate limits are subject to change." (G3, "Notes")

**Not published:** any number for the free tier. G2 has five tables: the spend-based limits, the usage tiers, and the Batch API's enqueued tokens for Tiers 1 to 3. None gives the Free tier's requests or tokens for any model. The page's raw HTML holds no such table. G7, where G2 sends readers, redirects to Google's sign-in.

**Could not check:** the free tier's requests per minute and per day, and tokens per minute, for any model. The components are an AI Studio project under a signed-in Google account. They cannot be stood in for in C01: DevOS has no Google account, and creating the project and key is Batu's step in C11 (Section 12 item 5). Batu signing in now would bring his C11 account step forward, and it would save no time on the critical path, since nothing relies on these limits before C11. So the part moves to C11, where its components exist (the paragraph after the probe setup, line 940; the block's could-not-check rule). Its fail path, result (iii) below, is applied there before C11 tasks 3 to 6 rely on the second model (N-164).

## Point 3. The real key's limits: moved to C11

Met. Note N-164 on `plan/work/C11.md`, which C11's work list reads, records that the real key's limits are observed when the key exists (plan Section 12 item 5), before any work relies on them. It carries point 2's unpublished numbers with them. It names the work its fail path comes before: C11 task 3 (capacity), task 4 (cost and limits), task 5 (provider independence) and task 6 (frame review by the second model) (plan lines 1108-1111). No work before C11 uses the second model, since the key does not exist before then. C08 builds the gateway (task 1, line 1079), and without a key nothing can be sent through it.

## Point 4. The fixed fail results

**(i) Using the free tier needs a payment method, a fee or a billing account: not met, on the documentation.**
- The free tier's qualification is "Active project or free trial" (G2, G4). "New accounts begin on the Free Tier" (G4). The API is a paid service "only when accessing the API through a Cloud Project associated with an active billing account" (G1). Moving to a paid tier means "linking a billing account and prepaying to add a minimum of $5" (G4, "Set up billing to access the Paid Tier").
- So, on the documentation, using the free tier needs none of these. Guaranteed by platform (documented in G1, G2 and G4, read 2026-10-11); not independently tested.
- Two consequences for C11, carried by N-164: whether creating the key asks for a payment method is observed when Batu creates it; and the key's project must have no active billing account, or every request would be a paid service: a paid feature, which goes to Batu as his decision (`CLAUDE.md`, "Money").

**(ii) The terms allow the content sent a use beyond the one B2 = (1) weighed: not met.** This is a judgment, weighed use by use against B2's text, and it is the decision-critical point of this record:
- **Product use.** "provide, improve, and develop Google products and services and machine learning technologies" (G1) is the use B2 names: "may be used in Google's product development". The source plan 5.8 cites is the pricing page, and G3 still answers its row "Used to improve our products" with "Yes" for the free tier and "No" for the paid tier, in each of the 80 rows that carry it.
- **Human review** is stated for the same purpose, "To help with quality and improve our products" (G1). It is how that use is carried out, not a new use. B2 already limits what is sent to fake data and content that will go into public repositories. A human who reads such content learns nothing beyond fake data or what the public will see.
- **The licence** (G5 5 b; extended by G1) includes "publish", but only "For the sole purpose of enabling Google to provide, secure, and improve the APIs". Its purpose stays within B2's weighed use. Its duration ("perpetual, irrevocable") does not change what may be sent.
- **Responses.** G1 names "any generated responses" too. B2 names only "content sent". DevOS's responses are generated from content B2 allows, so their use adds nothing B2 did not weigh.
- **Who may use it.** "for professional or business purposes, not for consumer use" (G1) is a condition on who uses the service and why. It is not a use of the content. B2 did not weigh it. DevOS calls the API from a system Batu builds, which is "developers building with Google AI models", not consumer use. Whether his purpose is "professional or business" is a fact only he can state, and he accepts the terms when he creates the key. N-164 gives him the condition with his C11 step. If it does not hold for him, B2 returns to him as his decision before the key is used.
- **"Do not submit sensitive, confidential, or personal information"** (G1) narrows what may be sent. It does not widen the use. B2 allows "content that will go into public repositories", and such content can hold personal information (names, account names, and Batu's own words, which decision records keep verbatim). So the gateway's check must keep personal information out as well. That narrows what is sent within B2's "only", needs nothing from Batu and costs nothing. It is carried to C08, which builds the gateway, by note N-165 on `plan/work/C08.md`.
- **Conditional.** If the checker or the executor holds that human review, or the licence's "publish", is a use beyond the one B2 weighed, result (ii) is met. Then the fail path applies: a plan-change record and a decision of Batu's with its cost (the paid tier: a billing account, a prepayment of at least $5 as G4's setup section gives it, then per-token fees, G3; or B2 (3)). That decision is not drafted here.

**(iii) The published limits, for the models the two jobs would use, are lower than 5.8 assumes ("a few dozen requests a day on some models"): could not check in C01.** No number is published (point 2), so neither "lower" nor "not lower" can be judged. Moved to C11 with point 2's numbers. There, the models the two jobs use are named, their limits are read in AI Studio for the key's project, with their date, and this result is judged before C11 tasks 3 to 6 rely on them (N-164).

**Also recorded (no fail result): which models the free tier offers** (G3, dated 2026-10-09). Text models marked "Free of charge" on the free tier's standard row: Gemini 3.8 Flash ("Our most intelligent Flash model"), 3.6 Flash, 3.5 Flash-Lite, 3.1 Flash-Lite, 3 Flash Preview, 2.5 Pro, 2.5 Flash, 2.5 Flash-Lite and Gemma 4. Marked "Not available" on the free tier: Gemini 3.1 Pro Preview (the newest Pro), Omni Flash and its preview, and the image models listed. The paid tier lists "Access to Google's most advanced models", and the free tier "Limited access to certain models". This does not undo B2's weighed gain: B2 (1)'s gain is a different model family's view, and B2 (2) already weighed "Stronger model" as the gain of paying. The model is named, from the list read again then, in C11 (N-164) and when C08 sets the gateway's model (N-165).

## Facts taken from the documentation (PC-21 item 9)

Each of these is guaranteed by platform (documented in the page named, read 2026-10-11); not independently tested:
- Unpaid content and responses are used "to provide, improve, and develop Google products and services and machine learning technologies"; human reviewers may read them; personal information is not to be sent (G1, page dated 2026-04-28).
- The API is a paid service only through a project with an active billing account. The free tier qualifies with "Active project or free trial". Moving to the paid tier means linking a billing account and, as G4's setup section gives it, prepaying at least $5 (G1; G2, dated 2026-10-09; G4, dated 2026-09-28).
- No numeric free-tier limit is published. Limits are per project, shown in AI Studio, "not guaranteed", and "more restricted for experimental and preview models". The daily quota resets at midnight Pacific time (G2; G3, dated 2026-10-09).
- Use is for "professional or business purposes, not for consumer use", from age 18, within an available region; Türkiye is one (G1; G6, dated 2026-04-28).
- The free tier's text models, and the models it does not offer (G3).

**Qualifiers.** PC-21 item 9's listed qualifiers concern the Claude Code platform's environments. They bear on none of these facts, except the last one in its general form: these readings are repeated when the provider changes its pages (plan 0.3 item 12), at key creation at the latest (N-164). The provider's own qualifiers are kept above: limits "not guaranteed", "actual capacity may vary", "subject to change"; prices "may make changes ... effective 30 days after they are posted" (G1, "Payment Terms"). Terms are accepted per account, so what binds DevOS is the version Batu accepts in C11.

## Result

Row 16's C01 part is met. The terms and the published limits were read from the provider's official pages, each with its own date and the date of reading (points 1 and 2). The parts C01 cannot observe are recorded as moved to C11, with the work their fail path comes before (points 2 and 3; N-164):
- the real key's limits, which the row moves;
- the free tier's numbers, which are not published (could not check).

None of the three fixed fail results is met in C01. Result (i) is not met on the documentation and is observed again at key creation. Result (ii) is not met, on the judgment in point 4 (ii), with its conditional. Result (iii) could not be checked and moves to C11. So no plan change follows from row 16 now, and no decision goes to Batu. The terms add one design input that is not Batu's: no personal information goes through the gateway (N-165, C08).

**Limits of this record.** It reads documentation only. A signed-in account may see other terms or limits. The key's own terms are those Batu accepts in C11. Pages can change after 2026-10-11: G2 and G3 changed on 2026-10-09.
