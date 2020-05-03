# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateUser, type: :mutation do
  describe '.resolve' do
    let(:user) { build(:user) }
    let(:create_user) { GraphqlApiSchema.execute(query) }

    let(:query) do
      <<~GQL
        mutation {
          createUser (input: {
            name: "#{user.name}",
            authProvider: {
              credentials: {
                email: "#{user.email}",
                password: "#{user.password}"
              }
            }
          }
          ) {
            name
            email
          }
        }
      GQL
    end

    it 'creates user' do
      expect { create_user }.to change { User.count }.from(0).to(1)

      expect(create_user['data']['createUser']).to eq(
        {
          'name' => 'El User',
          'email' => 'example@user.com'
        }
      )

      expect(User.last).to have_attributes(
        name: user.name,
        email: user.email
      )
    end
  end
end
