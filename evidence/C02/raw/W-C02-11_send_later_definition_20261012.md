# W-C02-11: `send_later`'s own tool definition, as the working session sees it (CHK-C02-018 C2)

- **What:** the input parameter names and the description of `mcp__claude-code-remote__send_later`, exactly as the working session's own tool definition presents them (`session_01XyxvJd3RayQk4HCrjurbVH`; read the way CTL was read: names and text only, no call).
- **When:** 2026-10-12, about 18:15Z, at `main` `db2ebd9` (no bridge in the live tree).
- **Label:** observed, as the session's own report of its tool definition (a self-report); what the platform does with the call beyond this text is not observed here.

## Description, verbatim

> Schedule a message to be delivered back into THIS SESSION at a future time. The message arrives as an ordinary user turn, so you can use it to remind yourself to resume work, check on something, or continue after a delay. Delivery survives container restarts. Granularity is one minute — the scheduler polls every minute, so sub-minute precision is not available. This is a thin wrapper over create_trigger (a self-bind + run_once_at Routine); the returned trigger_id can be passed to delete_trigger to cancel before it fires, and the Routine disables itself after firing once.

## Input parameters, verbatim (name, type, description)

- `at` (string): "RFC3339 timestamp for the fire time (e.g. 2026-04-20T17:00:00Z). Seconds are truncated. Must be in the future. Mutually exclusive with 'delay_minutes' — set exactly one."
- `delay_minutes` (integer, minimum 1): "Fire this many minutes from now. Minimum 1. Mutually exclusive with 'at' — set exactly one."
- `initiation` (string, one of `human_request`, `human_schedule`, `own_followup`, `own_initiative`): "Who wanted this message scheduled. Defaults to own_followup (your own check-in on in-flight work); pass human_request when a person asked you to remind them or to come back at a set time."
- `message` (string): "The text to deliver as a user turn. Write it assuming your current conversation context — this session continues, it does not start fresh."
- `name` (string), in a code span so that GitHub does not link its example number: `"Short human-readable label for this reminder as it appears in the user's Routines list (e.g. \"Re-check PR #123 CI\"). A few words, one line. Optional — omit and one is derived from the message."`
- Required: `message`.

## What it shows

No parameter names a session, a routine or a recipient other than the calling session: the five are a time (`at` or `delay_minutes`), a provenance label (`initiation`), the text (`message`) and a list label (`name`). The description says the message is delivered "back into THIS SESSION" and that the call is "a self-bind + run_once_at Routine". So, by its own definition, `send_later` cannot be aimed at another session; CHK-C02-018 C2's test is met. Its description also says the returned `trigger_id` "can be passed to delete_trigger to cancel", which the bridge denies (N-250).
