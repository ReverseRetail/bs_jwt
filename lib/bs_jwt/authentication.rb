# frozen_string_literal: true

module BsJwt
  class Authentication
    attr_accessor :roles, :display_name, :token, :expires_at, :buddy_id, :email, :user_id

    def self.from_jwt_payload(payload, jwt_token)
      new(
        roles: payload['https://buddy.buddyandselly.com/roles'],
        display_name: payload['nickname'],
        token: jwt_token,
        expires_at: Time.at(payload['exp']),
        buddy_id: payload['https://buddy.buddyandselly.com/buddy_id'],
        email: payload['name'],
        user_id: payload['sub']
      )
    end

    def initialize( # rubocop:disable Metrics/ParameterLists
      roles: nil, display_name: nil, token: nil, expires_at: nil, buddy_id: nil, email: nil, user_id: nil
    )
      @roles = roles || []
      @display_name = display_name
      @token = token
      @expires_at = expires_at
      @buddy_id = buddy_id
      @email = email
      @user_id = user_id
    end

    def has_role?(role) # rubocop:disable Naming/PredicateName
      roles.include?(role)
    end

    def expired?
      Time.now >= expires_at
    end
  end
end
