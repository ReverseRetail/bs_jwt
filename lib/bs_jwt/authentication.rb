module BsJwt
  class Authentication

    attr_accessor :roles, :display_name, :token, :expires_at, :buddy_id, :email, :user_id

    def initialize(roles: nil, display_name: nil, token: nil, expires_at: nil, buddy_id: nil, email: nil, user_id: nil)
      @roles = roles || []
      @display_name = display_name
      @token = token
      @expires_at = expires_at
      @buddy_id = buddy_id
      @email = email
      @user_id = user_id
    end

    def has_role?(role)
      roles.include?(role)
    end

    def expired?
      Time.now >= expires_at
    end
  end
end
