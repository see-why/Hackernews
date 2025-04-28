require "test_helper"

class Mutations::CreateUserTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    query = <<~GRAPHQL
      mutation CreateUser($name: String!, $authProvider: AuthProviderSignupData) {
        createUser(input: {
          name: $name,
          authProvider: $authProvider
        }) {
          name,
          email,
          password
        }

      }
    GRAPHQL

    HackernewsSchema.execute(
      query,
      variables: args,
      context: { current_user: user }
    )
  end

  test "create a new User" do
    result = perform(
      name: "Cyril Iyadi",
      authProvider: {
        credentials: {
          email: "iyadicy@gmail.com",
          password: "P@ssw0rd1"
        }
      }
    )

    assert_nil result["errors"]
    assert result["data"]["createUser"]
    assert_equal result["data"]["createUser"]["name"], "Cyril Iyadi"
    assert_equal result["data"]["createUser"]["email"], "iyadicy@gmail.com"
    assert result["data"]["createUser"]["password"]
  end
end
