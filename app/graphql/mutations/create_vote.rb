module Mutations
  class CreateVote < BaseMutation
    argument :link_id, ID, required: false

    type Types::VoteType

    def resolve(link_id: nil)
      link = Link.find(link_id)
      return unless link

      Vote.create!(
        link: link,
        user: context[:current_user]
      )
    end
  end
end
