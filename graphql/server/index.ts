import postgraphile from 'postgraphile'

export const config = {
  api: {
    bodyParser: false,
  },
}

const { DATABASE_URL, DATABASE_POOL_MIN, DATABASE_POOL_MAX } = process.env

const dbConfig = {
  connectionString: DATABASE_URL,
  min: DATABASE_POOL_MIN ? parseInt(DATABASE_POOL_MIN, 10) : 2,
  max: DATABASE_POOL_MAX ? parseInt(DATABASE_POOL_MAX, 10) : 2,
}

const schema = 'app_public'

const options = {
  // Routes/UI
  graphqlRoute: '/api/graphql',
  graphiqlRoute: '/api/graphqi',
  graphiql: true,
  enhanceGraphiql: true,
  ignoreRBAC: false,
  pgDefaultRole: 'user_guest',
}

const server = postgraphile(dbConfig, schema, options)

export default server
