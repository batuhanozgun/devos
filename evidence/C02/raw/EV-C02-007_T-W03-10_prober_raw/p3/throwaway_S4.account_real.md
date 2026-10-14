| object | migration (version name) | probe-kind name scan |
|---|---|---|
| extension pgcrypto | NO ACCOUNT | - |
| function devos_api.deployment_drift(expected jsonb) | 20261012184638 deployment_drift | - |
| function public.w03_fixture_probe_public_f() | NO ACCOUNT | PROBE-KIND NAME |
| schema devos_api | 20261012184638 deployment_drift | - |
| schema devos_private | 20261012184638 deployment_drift | - |
| schema w03_fixture | 20261012231841 w03_fixture_apply | - |
| table devos_private.function_deployment | 20261012184638 deployment_drift | - |
| table public.w03_fixture_probe_public_t | NO ACCOUNT | PROBE-KIND NAME |
| table w03_fixture.apply_check | 20261012231841 w03_fixture_apply | - |
| view public.w03_fixture_probe_public_v | NO ACCOUNT | PROBE-KIND NAME |
| view w03_fixture.apply_check_view | 20261012231841 w03_fixture_apply | - |
objects=11 unaccounted=4 ['extension pgcrypto', 'function public.w03_fixture_probe_public_f()', 'table public.w03_fixture_probe_public_t', 'view public.w03_fixture_probe_public_v'] probe-kind names=['function public.w03_fixture_probe_public_f()', 'table public.w03_fixture_probe_public_t', 'view public.w03_fixture_probe_public_v']
account step result: RED (an object without an account)
break check on planted objects with no migration: flagged 4/4 -> the step catches them
