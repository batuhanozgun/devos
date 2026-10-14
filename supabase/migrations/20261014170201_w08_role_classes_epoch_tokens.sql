-- DevOS schema (W-C02-08), not a fixture. Part 1 of 5: the role classes, the global authority epoch and EnvToken's table.
-- Sources: plan/work/W-C02-08.md points 3 and 5; Appendix B principles 8 and 9, section 2 and the line under its activation
-- table, 3.27; evidence/C02/EV-C02-003_identity_chain_and_environments.md sections 1.1, 1.4, 1.7 and 4.1;
-- evidence/C02/EV-C02-002_data_model_choices.md DM-01; PC-43 place 7. Record: evidence/C02/EV-C02-012_schema_roles_access.md.
-- No credential, token or hash value is written here; no token is issued here (B:46; EV-C02-001 M24).

-- The role classes (B section 2; B:100). A role class is a value carried by an environment token (env_tokens.role_class),
-- derived by devos_private.caller_role_class (W-C02-09), never a database role or login (EV-C02-003 sections 1.1 and 1.2 (e)).
-- devos_ingest arrives in C04 (B:100; EV-C02-002 DM-21), by a migration that adds its value.
create type devos_private.role_class as enum (
  'devos_calisma', 'devos_denetim', 'devos_sinav', 'devos_kurulum', 'devos_ci', 'devos_backup');
comment on type devos_private.role_class is
  'DevOS role classes (Appendix B section 2): values carried by environment tokens, not database roles (EV-C02-003 1.1)';

-- The global authority epoch (B principle 9; EV-C02-002 DM-01): one row, distinct from a claim's own authority_epoch field.
-- revoke_env_token (W-C02-09) increments it under an update lock; every effect's re-check reads it for share.
create table devos_private.global_authority_epoch (
  singleton boolean primary key default true check (singleton),
  epoch bigint not null default 1 check (epoch >= 1),
  changed_at timestamptz not null default now()
);
insert into devos_private.global_authority_epoch (singleton, epoch) values (true, 1);
comment on table devos_private.global_authority_epoch is
  'The one global authority_epoch counter (Appendix B principle 9; EV-C02-002 DM-01); one row';

-- EnvToken (B 3.27): only the token's hash is kept; the token exists only in its environment's network secret.
-- token_hash is the SHA-256 of the whole token, in lower-case hexadecimal (EV-C02-003 section 1.7). No authority_epoch
-- field (PC-43 place 7; EV-C02-003 section 1.4). A token is verified while revoked_at is empty.
create table devos_private.env_tokens (
  id uuid primary key default gen_random_uuid(),
  role_class devos_private.role_class not null,
  token_hash text not null unique check (token_hash ~ '^[0-9a-f]{64}$'),
  issued_at timestamptz not null default now(),
  revoked_at timestamptz check (revoked_at is null or revoked_at >= issued_at)
);
comment on table devos_private.env_tokens is 'EnvToken (Appendix B 3.27): hashes of issued environment tokens only';
