# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :mutation do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:sign_in_user) { GraphqlApiSchema.execute(query) }

    let(:query) do
      <<~GQL
        mutation {
          signinUser (
            input: {
              credentials : {
                email: "#{user.email}",
                password: "#{user.password}"
              }
            }
          ) {
            token
            user {
              name
              email
            }
          }
        }
      GQL
    end

    it 'sign in user' do
      expect(sign_in_user['data']['signinUser']['token']).to be

      expect(sign_in_user['data']['signinUser']['user']).to eq(
        {
          'name' => 'El User',
          'email' => 'example@user.com'
        }
      )
    end
  end
end
