# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :votes, [ Types::VoteType ], null: false
    field :links, [ Types::LinkType ], null: false
  end
end
