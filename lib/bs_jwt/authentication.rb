module BsJwt
  class Authentication

    attr_accessor :roles, :display_name, :token, :expires_at, :buddy_id, :email

    def initialize(roles: [], display_name: nil, token: nil, expires_at: nil, buddy_id: nil, email: nil)
      @roles = roles
      @display_name = display_name
      @token = token
      @expires_at = expires_at
      @buddy_id = buddy_id
      @email = email
    end

    def has_role?(role)
      roles.include?(role)
    end

    def expired?
      Time.now >= expires_at
    end
  end
end
