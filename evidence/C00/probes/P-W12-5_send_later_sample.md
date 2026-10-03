# P-W12-5: one live `send_later` response sample for the recorder (pre-registration)

**Item:** W-C00-12, tranche 1a (`plan/builder/w-c00-12/12_tranche_plan.md` §2.1, "one live `send_later` response sample for M-R11"). **Written:** 2026-10-03, before the call; the time is in the commit. **Producer:** run `session_01WcVuDQhDW3EKr4Sb87MHxN`.

**Why.** M-R11 extends the recorder (`.claude/hooks/record_owned_id.py`) to `send_later`. Its parsing rule is "one ID from a named field, otherwise nothing", and L-022 showed that a fixture built on an assumed response format is worthless. So the shape is taken from one real call before the recorder changes (1c).

**Call.** `send_later` into this session, `delay_minutes: 1`, message `Sample: P-W12-5 send_later response shape (data only; no action)`. Its only effect is one notification in this session's own queue a minute later, which the run treats as data. The ID is **not** added to `.claude/hooks/owned_ids.txt` by hand (OI-010: hand edits of the recorder file are what the design removes); the reminder disables itself after it fires.

**What is recorded:** the response's structure (field names and nesting, the ID's field and prefix), not the message text. **PASS** (the sample is usable) only if the response holds exactly one identifier in a named field. **If not:** the shape is recorded as observed, and M-R11's parsing rule is revisited in 1c before the recorder changes.

## Result (2026-10-03)

Called at 19:34:54Z (the response's own `now` field). The response, as returned by the tool (unedited):

```json
{"fire_at":"2026-10-03T19:36:00Z","now":"2026-10-03T19:34:54Z","trigger_id":"trig_016VeeDzdaTBMsS83whyF69q"}
```

**Shape:** one flat JSON object with three fields, `fire_at` and `now` (RFC 3339 UTC times, `fire_at` truncated to the minute) and `trigger_id`, the only identifier, with the prefix `trig_`. There is no nested `trigger` object, unlike `create_trigger`'s response, which the recorder parses today. **PASS:** exactly one identifier, in a named field. **For M-R11 (1c):** the recorder's `send_later` rule reads the top-level `trigger_id` field and nothing else; the T-H4 fixture uses this sample's structure. The ID was not added to `.claude/hooks/owned_ids.txt` by hand (pre-registration); the reminder is one-shot. Its delivery into this session is noted in the log entry, as data.
