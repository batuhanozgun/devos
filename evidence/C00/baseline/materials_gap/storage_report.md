> SYNTHETIC TEST DATA: made up for a test. Brindle and every team, host, name, number and date in this file are fictional; no personal or business data.

# Run store: storage report, 2026-09-30

Prepared by the on-call engineer for work item BR-212.

- **Volume:** `/srv/brindle/runs` is its own volume of 1,024 GiB. It holds only run records.
- **Used on 2026-09-30 at 06:00 UTC:** 891 GiB (87%).
- **History:** the run store moved to this volume on 2026-03-02; the oldest record is from that day. No record has been deleted since.

## Space used, by month of session start

| Month | GiB |
|---|---|
| 2026-03 | 4 |
| 2026-04 | 9 |
| 2026-05 | 21 |
| 2026-06 | 46 |
| 2026-07 | 98 |
| 2026-08 | 293 |
| 2026-09 | 420 |
| **Total** | **891** |

## Daily volume

Over the last 28 days, new records added 14.0 GiB a day on average. The platform team plans with about 15 GiB a day for the rest of the year.

## Growing the volume

A larger volume would be new paid storage, which the policy notes rule out this year (`policy_notes.md`, 2026-08-19).
