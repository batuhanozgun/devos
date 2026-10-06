> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Brindle: overview

Brindle is the AI-assisted development system that the platform team runs for four product teams (about 30 engineers). Engineers file work items; Brindle's agent sessions work on them and open pull requests, which engineers review.

## Parts

- **Dispatcher.** One process on the host `disp-1`. It keeps the queue of work items, starts agent sessions and checks the periodic triggers (`scheduler.md`). Its state is a local SQLite database, `/srv/brindle/dispatcher.db`; the main tables are `queue` (work items waiting or running) and `sessions` (one row per session).
- **Agent sessions.** Each session works on one work item or does one periodic task, in a sandboxed container on `disp-1`. A session runs for at most 6 hours; the dispatcher stops it at that limit. About 12,000 sessions start in a month.
- **Run store.** `/srv/brindle/runs`, a volume of its own on `disp-1`. Every session writes one run record there (`run_records.md`).
- **Usage database.** Token counts per session, used for invoices and for the monthly cost report (`operations.md`).
- **Replay suite.** Tests the agent prompts against recorded sessions before a release (`replay_suite.md`).
- **Maintenance jobs.** Small jobs that run as systemd timers on `disp-1` (`operations.md`).

## Teams and growth

Brindle started with the platform team in March 2026. The other three product teams joined during August. No further teams will join this year.

## Documents in this folder

| File | What it covers |
|---|---|
| `overview.md` | this page |
| `run_records.md` | the run record format and life cycle |
| `storage_report.md` | the run store's disk usage |
| `operations.md` | on-call, billing, backups, releases, maintenance jobs |
| `replay_suite.md` | the replay suite |
| `scheduler.md` | periodic triggers |
| `policy_notes.md` | the platform team's decisions |
| `brindle.toml` | an excerpt of the dispatcher's configuration |
