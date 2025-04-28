# frozen_string_literal: true

module Types
  class AuthProviderCredentialsInputInputType < Types::BaseInputObject
    graphql_name "AUTH_PROVIDER_CREDENTIALS"

    argument :name, String, required: false
    argument :eamil, String, required: false
    argument :password, String, required: false
  end
end
