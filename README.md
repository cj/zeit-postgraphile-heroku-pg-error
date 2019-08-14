# zeit_postgraphile_heroku_pg_error_postgres:

## Using Docker

- npm run dev
- in a seperate console run `npm run db:migrate`
- visit http://localhost:3000

## How to setup Heroku

- create a heroku database Standard-0 tier database.
- goto the credentials tab https://devcenter.heroku.com/articles/heroku-postgresql-credentials
- add `user_admin`, `user_guest`, `user_staff`, `user_authed`
- create a file locally called `.env.local`
- add the Heroku variable DATABASE_URL
- run `npm run db:migrate`

## Using Heroku (locally)

- run `next dev`
- visit http://localhost:3000/api/graphqi

## Using Heroku (Zeit now)

- add the @database-url by running `now secret add database-url REPLACE_WITH_THE_CONTENTS_OF_DATABASE_URL_FROM_HEROKU`
- run `now`
