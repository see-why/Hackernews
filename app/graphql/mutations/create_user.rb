module Mutations
  class CreateUser < BaseMutation
    argument :name, String, required: true
    argument :eamil, String, required: true

    type Types::UserType

    def resolve(name: nil, email: nil)
      User.create!(
        name: name,
        email: email,
      )
    end
  end
end
