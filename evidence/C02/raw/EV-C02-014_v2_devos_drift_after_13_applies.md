# deployment_drift in devos after each of 13 applies (CHK-C02-115 condition C1 (b))

Source: the GitHub Actions job log of the `devos (compare, decide, apply)` job of each run, read on 2026-10-19 with the GitHub MCP tool `get_job_logs` (return_content, tail of the log; each tail reached to the job's end, "Cleaning up orphan processes"). Job ids from `actions_list` `list_workflow_jobs` of each run.

For each run: the two lines that step "(8) deployment_drift in devos again after an apply" printed after its `env:` block, and the `W03REPORT` line the next step ("report (names, versions, counts and statuses only)") printed. The lines are verbatim, with their runner timestamps. Nothing inside a line is changed or withheld. The step (8) lines are the "reads in devos" and "comparison in devos" lines that come directly after the step whose script holds the comparison and whose `env:` holds `EXPECTED`, and directly before the report step's `##[group]Run import json, os`; step (5) prints lines of the same form, but before the decide step, not before the report step. In each of these 13 logs, step (7) "apply to devos" printed `cli: Applying migration <version>_<name>.sql...` and `apply: exit 0` before step (8) (seen in full in the first seven logs; for the last six only the tail from step (8)'s env block onward was read).

Note on the W03REPORT line: its `listing_count` is the count of step (4) (before the apply), so it is lower than the `listing=` count of step (8)'s reads in the runs that added objects; its `result` and `applied_versions` are those of step (8) (the report step uses AFTER_RESULT and AFTER_APPLIED when an apply ran).

## 1. Run 39168107613, devos job 117795322089 (commit 9638f1d, adds 20261018203001)

```
2026-10-18T21:30:39.6152042Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=14 listing=52 objects complete=True
2026-10-18T21:30:39.6152713Z comparison in devos: result=no_difference call=ok
2026-10-18T21:30:39.6463361Z W03REPORT {"project":"devos","event":"push","run_id":"39168107613","commit":"9638f1d3d8c28aadbea4b23925325ef516ae5a3c","head":"yes","credential_present":"yes","connection":"yes","listing_count":"46","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 2. Run 39173293073, devos job 117810780527 (commit d032a84, adds 20261018214501)

```
2026-10-18T22:41:36.8361461Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=15 listing=59 objects complete=True
2026-10-18T22:41:36.8362371Z comparison in devos: result=no_difference call=ok
2026-10-18T22:41:36.8778207Z W03REPORT {"project":"devos","event":"push","run_id":"39173293073","commit":"d032a8475b19e11a1cf9971852f4abb36883d0fd","head":"yes","credential_present":"yes","connection":"yes","listing_count":"52","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 3. Run 39176641206, devos job 117820635594 (commit 4f01115, adds 20261018230001)

```
2026-10-18T23:28:43.9957669Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=16 listing=65 objects complete=True
2026-10-18T23:28:43.9959070Z comparison in devos: result=no_difference call=ok
2026-10-18T23:28:44.0379634Z W03REPORT {"project":"devos","event":"push","run_id":"39176641206","commit":"4f011151c46d9837d085a4b5198f9c6780458ab9","head":"yes","credential_present":"yes","connection":"yes","listing_count":"59","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 4. Run 39180667406, devos job 117832634901 (commit 5b96842, adds 20261018235501)

```
2026-10-19T00:25:38.8315387Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=17 listing=70 objects complete=True
2026-10-19T00:25:38.8316277Z comparison in devos: result=no_difference call=ok
2026-10-19T00:25:38.8730386Z W03REPORT {"project":"devos","event":"push","run_id":"39180667406","commit":"5b968424cc639867ccf3e2a2c159ec6e7d30fb84","head":"yes","credential_present":"yes","connection":"yes","listing_count":"65","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 5. Run 39183483857, devos job 117841157971 (commit 6fd25a2, adds 20261019010001)

```
2026-10-19T01:03:33.6084574Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=18 listing=74 objects complete=True
2026-10-19T01:03:33.6085558Z comparison in devos: result=no_difference call=ok
2026-10-19T01:03:33.6507942Z W03REPORT {"project":"devos","event":"push","run_id":"39183483857","commit":"6fd25a2c94826bf74bee27582acb199dc404bde5","head":"yes","credential_present":"yes","connection":"yes","listing_count":"70","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 6. Run 39186788629, devos job 117850940450 (commit 0cf5946, adds 20261019030001)

```
2026-10-19T01:46:15.1015814Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=19 listing=81 objects complete=True
2026-10-19T01:46:15.1017009Z comparison in devos: result=no_difference call=ok
2026-10-19T01:46:15.1472208Z W03REPORT {"project":"devos","event":"push","run_id":"39186788629","commit":"0cf59466158c62901cc236fb71d243325b8692f6","head":"yes","credential_present":"yes","connection":"yes","listing_count":"74","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 7. Run 39191130767, devos job 117864124777 (commit 4e2c6f2, adds 20261019050001)

```
2026-10-19T02:42:04.5803146Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=20 listing=85 objects complete=True
2026-10-19T02:42:04.5804049Z comparison in devos: result=no_difference call=ok
2026-10-19T02:42:04.6242942Z W03REPORT {"project":"devos","event":"push","run_id":"39191130767","commit":"4e2c6f2dbdfb03354a3a79a15ea463e5bedc0a84","head":"yes","credential_present":"yes","connection":"yes","listing_count":"81","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 8. Run 39196182415, devos job 117879414798 (commit 6ec7a53, adds 20261019080001)

```
2026-10-19T03:45:53.2294056Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=21 listing=86 objects complete=True
2026-10-19T03:45:53.2294918Z comparison in devos: result=no_difference call=ok
2026-10-19T03:45:53.2692933Z W03REPORT {"project":"devos","event":"push","run_id":"39196182415","commit":"6ec7a53d2866d0cb4229aa073ca82b88098b7409","head":"yes","credential_present":"yes","connection":"yes","listing_count":"85","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001","20261019080001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 9. Run 39197995876, devos job 117884935927 (commit cec8182, adds 20261019100001)

```
2026-10-19T04:09:28.7157494Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=22 listing=92 objects complete=True
2026-10-19T04:09:28.7158790Z comparison in devos: result=no_difference call=ok
2026-10-19T04:09:28.7598950Z W03REPORT {"project":"devos","event":"push","run_id":"39197995876","commit":"cec8182bfb4b84ef1aa4b4b9138f6b00761c42c0","head":"yes","credential_present":"yes","connection":"yes","listing_count":"86","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001","20261019080001","20261019100001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 10. Run 39201042839, devos job 117893961446 (commit 9399614, adds 20261019120001)

```
2026-10-19T04:45:39.0599693Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=23 listing=98 objects complete=True
2026-10-19T04:45:39.0600369Z comparison in devos: result=no_difference call=ok
2026-10-19T04:45:39.0892584Z W03REPORT {"project":"devos","event":"push","run_id":"39201042839","commit":"9399614d3e4aa7cf01f0197e0a690998cd0f1567","head":"yes","credential_present":"yes","connection":"yes","listing_count":"92","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001","20261019080001","20261019100001","20261019120001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 11. Run 39206131027, devos job 117909421762 (commit 90d316c, adds 20261019140001)

```
2026-10-19T05:45:36.2230073Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=24 listing=104 objects complete=True
2026-10-19T05:45:36.2231470Z comparison in devos: result=no_difference call=ok
2026-10-19T05:45:36.2741634Z W03REPORT {"project":"devos","event":"push","run_id":"39206131027","commit":"90d316ceda9a817998ebd34289a414169d8705a4","head":"yes","credential_present":"yes","connection":"yes","listing_count":"98","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001","20261019080001","20261019100001","20261019120001","20261019140001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 12. Run 39209315850, devos job 117919284316 (commit 23e2d22, adds 20261019160001)

```
2026-10-19T06:21:36.8274837Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=25 listing=106 objects complete=True
2026-10-19T06:21:36.8275815Z comparison in devos: result=no_difference call=ok
2026-10-19T06:21:36.8633326Z W03REPORT {"project":"devos","event":"push","run_id":"39209315850","commit":"23e2d22d09842eda08b7021aa867bdde4a3c3958","head":"yes","credential_present":"yes","connection":"yes","listing_count":"104","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001","20261019080001","20261019100001","20261019120001","20261019140001","20261019160001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## 13. Run 39242176833, devos job 118026026650 (commit 48d5857, adds 20261019180001)

```
2026-10-19T11:07:58.1773657Z reads in devos (one read-only REPEATABLE READ transaction): function_exists=True history_table_exists=True history_rows=26 listing=106 objects complete=True
2026-10-19T11:07:58.1774563Z comparison in devos: result=no_difference call=ok
2026-10-19T11:07:58.2201463Z W03REPORT {"project":"devos","event":"push","run_id":"39242176833","commit":"48d5857b3c8cb7741fa760efadd3377db86887cf","head":"yes","credential_present":"yes","connection":"yes","listing_count":"106","result":"no_difference","differences":[],"applied_versions":["20261012184638","20261012231841","20261012232112","20261012232113","20261014170201","20261014170202","20261014170203","20261014170204","20261014170205","20261014182601","20261014190401","20261014190402","20261017230001","20261018203001","20261018214501","20261018230001","20261018235501","20261019010001","20261019030001","20261019050001","20261019080001","20261019100001","20261019120001","20261019140001","20261019160001","20261019180001"],"apply_step":"success","apply":"yes","reason":"only migrations on main, not applied: 1","first_migration_exception":"not_taken","result_before_apply":"differences"}
```

## Summary

| # | run | devos job | reads complete | comparison | history_rows | last applied version |
|---|---|---|---|---|---|---|
| 1 | 39168107613 | 117795322089 | True | no_difference, call=ok | 14 | 20261018203001 |
| 2 | 39173293073 | 117810780527 | True | no_difference, call=ok | 15 | 20261018214501 |
| 3 | 39176641206 | 117820635594 | True | no_difference, call=ok | 16 | 20261018230001 |
| 4 | 39180667406 | 117832634901 | True | no_difference, call=ok | 17 | 20261018235501 |
| 5 | 39183483857 | 117841157971 | True | no_difference, call=ok | 18 | 20261019010001 |
| 6 | 39186788629 | 117850940450 | True | no_difference, call=ok | 19 | 20261019030001 |
| 7 | 39191130767 | 117864124777 | True | no_difference, call=ok | 20 | 20261019050001 |
| 8 | 39196182415 | 117879414798 | True | no_difference, call=ok | 21 | 20261019080001 |
| 9 | 39197995876 | 117884935927 | True | no_difference, call=ok | 22 | 20261019100001 |
| 10 | 39201042839 | 117893961446 | True | no_difference, call=ok | 23 | 20261019120001 |
| 11 | 39206131027 | 117909421762 | True | no_difference, call=ok | 24 | 20261019140001 |
| 12 | 39209315850 | 117919284316 | True | no_difference, call=ok | 25 | 20261019160001 |
| 13 | 39242176833 | 118026026650 | True | no_difference, call=ok | 26 | 20261019180001 |

In each run the version that ends `applied_versions` is the one the same job's step (5) reported as `on_main_not_applied` (env `RESULT_JSON` of the report step) and step (7) applied.
