require "search_object"
require "search_object/plugin/graphql"

class Resolvers::LinksSearch < GraphQL::Schema::Resolver
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Link.all }

  type [ Types::LinkType ], null: false

  # inline input type definition for the advanced filter
  class LinkFilter < ::Types::BaseInputObject
    argument :OR, [ self ], required: false
    argument :description_contains, String, required: false
    argument :url_contains, String, required: false
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: LinkFilter, with: :apply_filter
  option :first, type: GraphQL::Types::Int, with: :apply_first
  option :skip, type: GraphQL::Types::Int, with: :apply_skip

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def normalize_filters(value, branches = [])
    scope = Link.all
    scope = scope.where("description LIKE ?", "%#{value[:description_contains]}%") if value[:description_contains]
    scope = scope.where("url LIKE ?", "%#{value[:url_contains]}%") if value[:url_contains]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end
end
