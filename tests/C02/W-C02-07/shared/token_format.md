# The two DevOS token formats: literal markers and patterns (fixed before the build)

Synthetic test data (plan Section 8 item 13): this file holds no token, no key and no example of either format. It names two fixed markers and the patterns that find them. Every string of either format that a test or a check needs is made at run time, labelled synthetic, and never written to a file.

**What this fixes.** EV-C02-003 §1.3 and §1.7 decide the structure of both DevOS tokens: a fixed class marker, then a random part drawn from the database's cryptographic random source at the strength of a 256-bit key, in a URL-safe alphabet. They leave the literal markers to W-C02-07, "when it writes its scan" (§1.3; EV-C02-003 §0 row 2). This file fixes them. W-C02-07 phase B, Group D, wrote it (README section 7; GROUPS.md section 2, Group D). It is the only file in the repository besides `shared/scan_patterns.json` that writes the markers (README section 6).

**Who takes them from here.**
- W-C02-09: `devos_private.issue_env_token` and `claim` produce tokens of exactly these forms, and the derivation (`devos_private.caller_role_class`) refuses any other string as `malformed`.
- W-C02-11: the guard's stop of both formats in URLs and outbound text (EV-C02-003 §1.6, §1.7).
- W-C02-12 point 9: the scan of the repository, branches, issue #6 and the records.
- The session's own format scan (EV-C02-003 §3.2), which counts the environment token's format only.
- The executor's count-only log check (EV-C02-003 §14, part 2).
- W-C02-07's own scan, `T-W07-7SCAN`.

## 1. The environment token

| Part | Fixed form |
|---|---|
| Marker | `dvenv1_` (7 characters: `dv` for DevOS, `env` for environment token, `1` for the format's version, `_` as separator). Lower case. The same for every role class (§1.3: "the same for every token") |
| Random part | Exactly 43 characters of the URL-safe base64 alphabet `A`–`Z`, `a`–`z`, `0`–`9`, `-`, `_`, with no padding. It encodes 32 bytes (256 bits) drawn from the database's cryptographic random source (§1.3) |
| Whole token | Marker followed by the random part: 50 characters, nothing before or after |

## 2. The claim token

| Part | Fixed form |
|---|---|
| Marker | `dvclm1_` (`clm` for claim token). Different from the environment token's marker (§1.7) |
| Random part | As section 1: 43 URL-safe base64 characters from 32 random bytes, the same generator (§1.7) |
| Whole token | 50 characters |

## 3. The patterns

**Well-formed (exact).** A string is of the format only if the whole string matches. The derivation uses the environment pattern to tell `malformed` from the rest. The issuer's own result must match it.

| Format | Python `re` (whole string, `re.fullmatch`) | PostgreSQL (`~`, anchored) |
|---|---|---|
| Environment token | `dvenv1_[A-Za-z0-9_-]{43}` | `^dvenv1_[A-Za-z0-9_-]{43}$` |
| Claim token | `dvclm1_[A-Za-z0-9_-]{43}` | `^dvclm1_[A-Za-z0-9_-]{43}$` |

**Finder (for scans and stops).** It finds a whole token, a token inside other text, and a cut copy that keeps at least 16 characters of its random part. The marker is matched in any case, so a copy turned to upper case is found as well. No left boundary is required, so a token glued to other text is found too.

| Format | Python `re` (`re.search` / `re.finditer`) |
|---|---|
| Environment token | `(?i:dvenv1_)[A-Za-z0-9_-]{16,}` |
| Claim token | `(?i:dvclm1_)[A-Za-z0-9_-]{16,}` |

`shared/scan_patterns.json` carries the same four patterns, keyed `env_token_exact`, `claim_token_exact`, `env_token_find` and `claim_token_find`. If the two files ever differ, this file holds, and `T-W07-7SCAN` gives COULD NOT CHECK until they agree (its case `7SCAN-pf3`).

## 4. What the derivation calls `malformed`, and the other reason codes

These are the reason codes of EV-C02-003 §15 and Appendix B 3.27, taken in this order on the value `request.headers` gives for the header `x-devos-env-token`. `T-W07-6TK` tests them.

| Reason code | When |
|---|---|
| `header_unreadable` | `request.headers` is unset, empty or not a JSON object, so the header cannot be read (EV-C02-003 §15: "for example through Realtime or Storage, which never set `request.headers`") |
| `missing` | `request.headers` is a JSON object without the key `x-devos-env-token`, or with that key set to JSON `null` |
| `empty` | the value is the empty string |
| `malformed` | the value does not match the environment token's exact pattern (section 3). This covers a claim token sent as an environment token, a token cut or lengthened by one character, a token with padding (`=`) or with spaces inside or around it, a marker of another version, and the marker in another case |
| `unknown` | the value is well formed, and no `env_tokens` row has its hash |
| `revoked` | the value is well formed, and the one row with its hash has `revoked_at` set |

## 5. Why these markers

- **Short, fixed and of no other system.** `dv…1_` is used by none of the formats the guard already masks (`gh?_`, `github_pat_`, `sk-`, `Bearer`), nor by Supabase's keys (`sb_publishable_`, `sb_secret_`) or a JWT (`eyJ`).
- **A version in the marker.** A later change of format gets a new marker (`…2_`), and the old one stays findable.
- **One marker for every role class.** A marker per role class would tell an observer which role a leaked token holds (EV-C02-003 §1.3, alternatives).
- **Two markers, one per kind.** A leaked string says which kind of credential to revoke. The session's scan does not count its own claim tokens (§1.7, alternatives).
- **Alternatives weighed.**
  - Hex for the random part (64 characters): also URL-safe, but longer for the same strength.
  - A marker that ends in `-` or `.`: `-` is inside the alphabet, so it gives no gain over `_`; `.` makes the string look like a JWT or a host name to other tools.
  - A long readable marker (`devos_env_token_v1_`): the word `token` followed by `_` is harmless to the guard, but in prose and logs it reads like a field name. Some log formats would then print `devos_env_token_v1_…: ` style keys, which the guard's `REDACT` would partly mask. Not chosen.

## 6. Checked against the guard's existing patterns

`.claude/hooks/tool_allowlist.py` lines 416 to 418, `REDACT`, at `main` `db2ebd9`. The check was run by the test designer on 2026-10-12 in a scratch directory outside the repository. It made 400,000 synthetic tokens at run time, 200,000 of each format, and printed none of them.
- **The markers themselves:** no pattern of `REDACT` matches either marker. A whole token standing alone, in quotes or in a URL query is matched only by the chance of the next item.
- **The random part, by chance:** in 7.5 of every 100,000 tokens, an unrelated pattern matched inside the random part (a `sk-` or `gh?_` sequence followed by enough alphabet characters). The fraction was observed on that run.
- **A token after the word `token`:** `REDACT`'s last pattern, `(?i)(token|secret|password|passwd|api[_-]?key)(\s*[=:]\s*)\S+`, masks any token printed after `token:` or `token=`. That includes a header line `x-devos-env-token: …`, which every request that carries it would show if printed.

**What follows for W-C02-11 (an interface, named here, built there).** The guard's stop of both formats must match the finder patterns of section 3 on the raw text, before `REDACT` masks anything. It must not depend on `REDACT`. Otherwise the two cases above hide a token from the stop: the header line always, and a token whose random part holds a masked sequence by chance. W-C02-11's planted synthetic case should include a header line of that form. This file does not test W-C02-11. W-C02-11's own tests do (GROUPS.md section 3, the row "The guard's stop of strings of the token formats").

## 7. Rules for every other file

- No file holds a string of either format, or an example of one. The markers appear only here and in `shared/scan_patterns.json`, and never followed by 16 or more alphabet characters.
- A test that needs a well-formed token gets one at run time from `issue_env_token` or `claim` (README section 6). A malformed one is made by cutting or altering an issued one at run time. An unknown one is made by changing one character of an issued token's random part at run time.
- A test that checks an issued token's form reads the exact pattern from `shared/scan_patterns.json` at run time (`bin/idc_real_path.py` does). An SQL file checks only the shape that needs no marker: the same prefix for every role class, followed by 43 characters of the alphabet (`w07_idc_identity_chain.sql`, case `IDC-f1`).

## 8. Not covered

- That W-C02-09's issuer uses the database's cryptographic random source. A string of the right shape can come from a weak source. W-C02-09's record shows the function's text, and its checker reads it.
- Encodings. A token held only in base64, URL-encoded with `%5F` for `_`, or split across lines, is not found by the finder patterns. EV-C02-003 §3.2's "Limits" say the same of the session's scan.
- Whether the marker's choice is final for C03 and C04's leak check. Those stages use this file, and a change of format is a new version (section 5).
