require "test_helper"

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    query = <<~GRAPHQL
      mutation CreateLink($description: String!, $url: String!) {
        createLink(input: {
            description: $description, url: $url
          }) {
            id
            url
            description
          }
      }
    GRAPHQL

    HackernewsSchema.execute(
      query,
      variables: args,
      context: { current_user: user }
    )
  end

  test "create a new link" do
    result = perform(
      url: "http://example.com",
      description: "description",
    )

    assert_nil result["errors"]
    assert result["data"]["createLink"]
    assert_equal result["data"]["createLink"]["description"], "description"
    assert_equal result["data"]["createLink"]["url"], "http://example.com"
  end
end
