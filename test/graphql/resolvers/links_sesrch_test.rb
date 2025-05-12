require "test_helper"

module Resolvers
  class LinksSearchTest < ActiveSupport::TestCase
    def find(user: nil, **args)
      query = <<~GRAPHQL
        query allLinks($filter: LinkFilter) {
          allLinks(filter: $filter) {
            id
            url
            description
          }
        }
      GRAPHQL

      HackernewsSchema.execute(
        query,
        variables: args,
        context: { current_user: user, session: {} }
      )
    end

    # those helpers should be handled with something like `factory_bot` gem
    def create_user
      User.create name: "test", email: "test@example.com", password: "123456"
    end

    def create_link(**attributes)
      Link.create! attributes.merge(user: create_user)
    end

    test "filter option" do
      link1 = create_link description: "test1", url: "http://test1.com"
      link2 = create_link description: "test2", url: "http://test2.com"
      link3 = create_link description: "test3", url: "http://test3.com"
      _ = create_link description: "test4", url: "http://test4.com"

      result = find(
        filter: {
          descriptionContains: "test1",
          OR: [ {
            urlContains: "test2",
            OR: [ {
              urlContains: "test3"
            } ]
          }, {
            descriptionContains: "test2"
          } ]
        }
      )

      assert_equal result.to_h["data"]["allLinks"].map { |link| link["description"] }, [ "test1", "test2", "test3" ]
    end
  end
end
