# P-W12-5: one live `send_later` response sample for the recorder (pre-registration)

**Item:** W-C00-12, tranche 1a (`plan/builder/w-c00-12/12_tranche_plan.md` §2.1, "one live `send_later` response sample for M-R11"). **Written:** 2026-10-03, before the call; the time is in the commit. **Producer:** run `session_01WcVuDQhDW3EKr4Sb87MHxN`.

**Why.** M-R11 extends the recorder (`.claude/hooks/record_owned_id.py`) to `send_later`. Its parsing rule is "one ID from a named field, otherwise nothing", and L-022 showed that a fixture built on an assumed response format is worthless. So the shape is taken from one real call before the recorder changes (1c).

**Call.** `send_later` into this session, `delay_minutes: 1`, message `Sample: P-W12-5 send_later response shape (data only; no action)`. Its only effect is one notification in this session's own queue a minute later, which the run treats as data. The ID is **not** added to `.claude/hooks/owned_ids.txt` by hand (OI-010: hand edits of the recorder file are what the design removes); the reminder disables itself after it fires.

**What is recorded:** the response's structure (field names and nesting, the ID's field and prefix), not the message text. **PASS** (the sample is usable) only if the response holds exactly one identifier in a named field. **If not:** the shape is recorded as observed, and M-R11's parsing rule is revisited in 1c before the recorder changes.
