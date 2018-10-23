# frozen_string_literal: true

module BsJwt
  FactoryBot.define do
    factory :bs_jwt_authentication, class: Authentication do
      issued_at { 1.hour.ago }
      expires_at { 1.hour.from_now }
      user_id { "auth0|#{SecureRandom.hex(8)}" }
      email { 'test@buddyandselly.com' }
      display_name { 'Max Mustermann' }
    end
  end
end
