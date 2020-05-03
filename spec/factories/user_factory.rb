# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name     { 'El User' }
    email    { 'example@user.com' }
    password { 'password' }
  end
end
