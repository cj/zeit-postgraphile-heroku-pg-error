// @ts-ignore
const { DATABASE_URL } = process.env

const defaultConfig = {
  client: 'pg',
  connection: DATABASE_URL,
  pool: {
    min: 2,
    max: 10,
  },
  migrations: {
    tableName: 'knex_migrations',
    extension: 'ts',
    directory: 'graphql/db/migrations',
  },
}

module.exports = {
  development: { ...defaultConfig },
  staging: { ...defaultConfig },
  test: { ...defaultConfig },
  production: { ...defaultConfig },
}
