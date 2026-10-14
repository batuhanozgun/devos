| object | migration (version name) | probe-kind name scan |
|---|---|---|
| function w03_fixture_probe.f() | NO ACCOUNT | PROBE-KIND NAME |
| role w03_fixture_probe_role | NO ACCOUNT | PROBE-KIND NAME |
| schema w03_fixture_probe | NO ACCOUNT | PROBE-KIND NAME |
| table w03_fixture_probe.token_hashes | NO ACCOUNT | PROBE-KIND NAME |
| view w03_fixture_probe.token_hashes_view | NO ACCOUNT | PROBE-KIND NAME |
objects=5 unaccounted=5 ['function w03_fixture_probe.f()', 'role w03_fixture_probe_role', 'schema w03_fixture_probe', 'table w03_fixture_probe.token_hashes', 'view w03_fixture_probe.token_hashes_view'] probe-kind names=['function w03_fixture_probe.f()', 'role w03_fixture_probe_role', 'schema w03_fixture_probe', 'table w03_fixture_probe.token_hashes', 'view w03_fixture_probe.token_hashes_view']
account step result: RED (an object without an account)
break check on planted objects with no migration: flagged 5/5 -> the step catches them
