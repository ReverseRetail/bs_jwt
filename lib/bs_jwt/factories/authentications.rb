# frozen_string_literal: true

module BsJwt
  FactoryBot.define do
    factory :authentication, class: Authentication do
      expires_at { 1.hour.from_now }
      sequence(:buddy_id)
      user_id "auth0|#{SecureRandom.hex(8)}"
      email 'test@buddyandselly.com'
      display_name 'Max Mustermann'
    end
  end
end
