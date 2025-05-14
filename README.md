# Chill Hackernews

This is a Hackernews API server built with Ruby on Rails and GraphQL.

## Prerequisites

- **Ruby version**: `3.4.1`
- **Rails version**: `8.0.1`
- **Database**: SQLite3 (default)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/hackernews.git
   cd hackernews
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   bin/rails db:create db:migrate db:seed
   ```

4. Start the Rails server:
   ```bash
   bin/rails server
   ```

5. Visit the app in your browser:
   ```
   http://localhost:3000
   ```

## Running Tests

To run the test suite:
```bash
bin/rails test
```

## Example GraphQL Requests

### Create a Link
```graphql
mutation {
  createLink(input: { description: "A great link", url: "http://example.com" }) {
    link {
      id
      description
      url
    }
  }
}
```

### Sign In a User
```graphql
mutation {
  signInUser(input: { credentials: { email: "test@example.com", password: "123456" } }) {
    user {
      id
      name
      email
    }
    token
  }
}
```

### Fetch All Links
```graphql
query {
  allLinks {
    id
    description
    url
  }
}
```

## Services

- **GraphQL API**: Used for querying and mutating data.
- **Authentication**: Handled using `has_secure_password` and session tokens.

## Deployment Instructions

1. Ensure all dependencies are installed on the server.
2. Set up the database:
   ```bash
   bin/rails db:setup
   ```
3. Precompile assets:
   ```bash
   bin/rails assets:precompile
   ```
4. Start the Rails server in production mode:
   ```bash
   bin/rails server -e production
   ```

## Notes

- This app uses `bcrypt` for password hashing.
- The GraphQL playground is available at `/graphql` when running in development mode.
