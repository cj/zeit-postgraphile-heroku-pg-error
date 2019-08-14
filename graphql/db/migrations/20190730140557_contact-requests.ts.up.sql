create schema app_public;
create schema app_hidden;
create schema app_private;

do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'user_admin') then
    create role user_admin;
  end if;
end
$$;
grant user_admin to postgres;

do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'user_staff') then
    create role user_staff;
  end if;
end
$$;
grant user_staff to postgres, user_admin;

do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'user_authed') then
    create role user_authed;
  end if;
end
$$;
grant user_authed to postgres, user_admin, user_staff;

do $$
begin
  if not exists (select 1 from pg_roles where rolname = 'user_guest') then
    create role user_guest;
  end if;
end
$$;
grant user_guest to postgres, user_authed;


-- table grants for rbac
-- grant access to schemas for each role
grant usage on schema public to user_guest, user_authed, user_admin, user_staff;
grant usage on schema app_public to user_guest;
grant usage on schema app_hidden to user_authed, user_staff;
grant usage on schema app_private to user_admin;

create table app_hidden.contact_requests(
  id serial primary key,
  email text not null check (email ~* '^.+@.+\..+$'),
  message text not null,
  phone text check (phone ~* '[0-9]{10}') default null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table app_hidden.contact_requests enable row level security;

grant all on table app_hidden.contact_requests to user_admin;

comment on table app_hidden.contact_requests is E'@omit';

create type create_contact_request_result as (
  id integer,
  email text,
  message text,
  phone text,
  created_at timestamptz
);

/* https://stackoverflow.com/questions/2044787/returning-a-custom-type-from-a-postgresql-function */
create or replace function app_public.create_contact_request(
  email text, message text, phone text default null
)
returns create_contact_request_result
as $$
declare result create_contact_request_result%rowType;
begin
  insert into app_hidden.contact_requests as cr(email, message, phone)
  values (email, message, phone)
  returning cr.id, cr.email, cr.message, cr.phone, cr.created_at
  into result;

  return result;
end;
$$ language plpgsql security definer;

comment on function app_public.create_contact_request is E'@resultFieldName result';

grant execute on function app_public.create_contact_request(text, text, text) to user_guest;
-- give access to all user data to admin
create policy admin_select_contact_requests on app_hidden.contact_requests for all to user_admin using (true);
