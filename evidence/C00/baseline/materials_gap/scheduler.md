> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Periodic triggers

Besides work items, the dispatcher starts **periodic sessions** for recurring tasks. Each trigger has a key and a period.

| Trigger key | Period | Due from | What the session does |
|---|---|---|---|
| `weekly-digest` | ISO week (`2026-W40`) | Monday 06:00 UTC | posts the week's merged work to each team's channel |
| `stale-branches` | ISO week | Sunday 03:00 UTC | deletes branches merged more than 14 days ago |
| `dep-update` | month (`2026-10`) | 1st, 04:00 UTC | opens one pull request per repository that updates its dependencies |
| `cost-report` | month | 2nd, 07:00 UTC | emails the month's cost report to the budget owner |
| `licence-scan` | quarter (`2026-Q4`) | first Monday of the quarter, 05:00 UTC | opens an issue for every dependency whose licence changed |
| `access-review` | quarter | first working day of the quarter, 08:00 UTC | sends each team lead the list of accounts with access to the team's repositories, to re-confirm |

## How a trigger starts a session

Every 15 minutes the dispatcher checks each trigger. A trigger whose "due from" time in the current period has passed starts a periodic session, unless the period's work is already done.

**Is the period's work done?** At each check the dispatcher reads the session header of every record in the run store, in every date directory, however old, looking for one whose `trigger` is this trigger's key and whose `period` is the current period. If it finds one, the period's work is done or under way, and nothing starts; if it finds none, it starts the session. By design, these headers are the only record of a period's work: a header it cannot read, or a session that failed before writing one, counts as none, so a new session starts, as intended.

Each check that finds a period's work done or under way starts nothing, even if that period's session has since failed or been killed: the on-call engineer then starts it again with `brindle periodic retry <trigger-key>`, which starts a new periodic session for the current period at once, skipping the check above, and needs nothing but the trigger key.

Periodic sessions are few, about a dozen a month. They take their data from the repositories, except `cost-report`, which takes it from the usage database, and their run records are like any other (`kind` is `periodic`).
