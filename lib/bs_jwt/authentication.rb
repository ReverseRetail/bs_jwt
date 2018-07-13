# frozen_string_literal: true

module BsJwt
  class Authentication
    attr_accessor :roles, :display_name, :token, :expires_at, :email, :user_id, :issued_at

    def self.from_jwt_payload(payload, jwt_token)
      new(
        roles: payload['https://buddy.buddyandselly.com/roles'],
        display_name: payload['nickname'],
        token: jwt_token,
        expires_at: Time.at(payload['exp']),
        email: payload['name'],
        user_id: payload['sub'],
        issued_at: Time.at(payload['iat'])
      )
    end

    def initialize(attributes = {})
      attributes = attributes.with_indifferent_access
      @roles = attributes[:roles] || []
      @display_name = attributes[:display_name]
      @token = attributes[:token]
      @expires_at = attributes[:expires_at]
      @email = attributes[:email]
      @user_id = attributes[:user_id]
      @issued_at = attributes[:issued_at]
    end

    def has_role?(role) # rubocop:disable Naming/PredicateName
      roles.include?(role)
    end

    def expired?
      Time.now >= expires_at
    end

    def to_h
      instance_values
    end
  end
end
