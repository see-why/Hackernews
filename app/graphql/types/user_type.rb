# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :votes, [ Types::Votes ], null: false
    field :links, [ Types::Links ], null: false
  end
end
