drop function app_public.create_contact_request;

drop type create_contact_request_result;

drop table app_hidden.contact_requests;

drop schema app_public, app_hidden, app_private;

do $$
begin
  drop role if exists user_admin;
  drop role if exists user_staff;
  drop role if exists user_authed;
  drop role if exists user_guest;
exception when others then
end
$$;
