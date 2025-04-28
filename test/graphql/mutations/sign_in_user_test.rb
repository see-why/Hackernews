require "test_helper"

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    query = <<~GRAPHQL
      mutation SignInUser($credentials: AUTH_PROVIDER_CREDENTIALS!) {
        signInUser(input: {
          credentials: $credentials
        }) {
            user {
              name,
              email
            },
            token
        }
      }
    GRAPHQL

    HackernewsSchema.execute(
      query,
      variables: args,
      context: { current_user: user }
    )
  end

  test "sign in a user" do
    user = users(:one)

    result = perform(credentials: {
      email: user.email,
      password: "password"
    })

    assert_nil result["errors"]
    assert result["data"]["signInUser"]
    assert_equal result["data"]["signInUser"]["user"]["email"], "mystring@example.com"
    assert_equal result["data"]["signInUser"]["user"]["name"], "MyString"
    assert result["data"]["signInUser"]["token"]
  end
end
