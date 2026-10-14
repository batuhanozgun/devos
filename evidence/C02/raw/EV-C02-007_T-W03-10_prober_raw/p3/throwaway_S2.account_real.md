| object | migration (version name) | probe-kind name scan |
|---|---|---|
| function devos_api.deployment_drift(expected jsonb) | 20261012184638 deployment_drift | - |
| function w03_fixture_probe.f() | NO ACCOUNT | PROBE-KIND NAME |
| role w03_fixture_probe_role | NO ACCOUNT | PROBE-KIND NAME |
| schema devos_api | 20261012184638 deployment_drift | - |
| schema devos_private | 20261012184638 deployment_drift | - |
| schema w03_fixture | 20261012231841 w03_fixture_apply | - |
| schema w03_fixture_probe | NO ACCOUNT | PROBE-KIND NAME |
| table devos_private.function_deployment | 20261012184638 deployment_drift | - |
| table w03_fixture.apply_check | 20261012231841 w03_fixture_apply | - |
| table w03_fixture_probe.token_hashes | NO ACCOUNT | PROBE-KIND NAME |
| view w03_fixture.apply_check_view | 20261012231841 w03_fixture_apply | - |
| view w03_fixture_probe.token_hashes_view | NO ACCOUNT | PROBE-KIND NAME |
objects=12 unaccounted=5 ['function w03_fixture_probe.f()', 'role w03_fixture_probe_role', 'schema w03_fixture_probe', 'table w03_fixture_probe.token_hashes', 'view w03_fixture_probe.token_hashes_view'] probe-kind names=['function w03_fixture_probe.f()', 'role w03_fixture_probe_role', 'schema w03_fixture_probe', 'table w03_fixture_probe.token_hashes', 'view w03_fixture_probe.token_hashes_view']
account step result: RED (an object without an account)
break check on planted objects with no migration: flagged 5/5 -> the step catches them
