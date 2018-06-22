# frozen_string_literal: true

module BsJwt
  FactoryBot.define do
    factory :authentication, class: Authentication do
      expires_at { 1.hour.from_now }
      buddy_id 222
      user_id 'auth0|7de348e3e208cd26b54696b'
    end
  end
end
