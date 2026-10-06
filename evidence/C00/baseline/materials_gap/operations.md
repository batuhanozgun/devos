> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Operations

## On-call

One engineer is on call each week. When a session fails, the on-call engineer reads its run record to find out why. The on-call guide asks for the run records of the last 7 days to be available; in the last six months no one has needed an older one.

## Usage and billing

When a session ends, the dispatcher copies the token counts from the end line of its run record into the usage database. Invoices to the product teams and the monthly cost report are built from the usage database only.

## Backups

The dispatcher database and the usage database are backed up every night. The run store is not backed up.

## Releases

A Brindle release needs the replay suite to pass (`replay_suite.md`).

## Maintenance jobs

Maintenance jobs run as systemd timers on `disp-1`, as the user `brindle`, and log to the systemd journal. Current jobs:

| Job | When | What it does |
|---|---|---|
| `queue-vacuum` | daily, 02:30 UTC | compacts the dispatcher database |
| `cert-check` | daily, 07:00 UTC | warns the on-call engineer about TLS certificates that expire within 21 days |

A job that deletes data must have a `--dry-run` mode, which prints what it would delete, and must run in dry-run mode for at least one day before it is enabled (`policy_notes.md`, 2026-04-14).

## Alerts

Disk alerts for every volume of `disp-1` go to the on-call engineer.
