# frozen_string_literal: true

require 'bs_jwt/version'
require 'bs_jwt/authentication'
require 'bs_jwt/railtie' if defined?(Rails)
require 'json/jwt'
require 'faraday'
require 'active_support/core_ext'

##
# Module BsJwt
# Used to decode, verify, and process JSON Web Tokens (JWTs) issued by Auth0
# in applications developed and used at the company Reverse-Retail GmbH
# (www.buddyandselly.com), Hamburg, Germany.
# BS stands for Buddy&Selly.
#
# The purpose of this library is to avoid code duplication among different
# Rails apps, such as Buddy, B&S Inventory, or B&S Packing.
module BsJwt
  class BaseError < RuntimeError; end

  class ConfigMissing < BaseError; end
  class VerificationError < BaseError; end
  class NetworkError < BaseError; end
  class InvalidToken < BaseError; end

  mattr_accessor :auth0_domain

  DEFAULT_ENDPOINT = '/.well-known/jwks.json'

  class << self
    def verify_and_decode_auth0_hash!(auth0_hash)
      raise ArgumentError, 'Auth0 Hash must be an instance of Hash' unless auth0_hash.is_a?(Hash)

      jwt = auth0_hash.dig('credentials', 'id_token')
      verify_and_decode!(jwt)
    end

    def verify_and_decode_auth0_hash(auth0_hash)
      raise ArgumentError, 'Auth0 Hash must be an instance of Hash' unless auth0_hash.is_a?(Hash)

      jwt = auth0_hash.dig('credentials', 'id_token')
      verify_and_decode(jwt)
    end

    def verify_and_decode!(jwt)
      raise InvalidToken, 'token is nil' if jwt.nil?

      decoded = JSON::JWT.decode(jwt, jwks_key)
      Authentication.from_jwt_payload(decoded, jwt)
    rescue JSON::JWT::Exception
      raise InvalidToken
    end

    def verify_and_decode(jwt)
      return if jwt.nil?

      decoded = JSON::JWT.decode(jwt, jwks_key)
      Authentication.from_jwt_payload(decoded, jwt)
    rescue JSON::JWT::Exception
      nil
    end

    def jwks_key
      @jwks_key ||= update_jwks
    end

    private

    # Fetches and overwrites the JWKS
    def update_jwks
      check_config
      fetch_jwks
    end

    def check_config
      %i[auth0_domain].each do |key|
        val = send(key)
        next if val && (val.respond_to?(:empty?) && !val.empty?) # present

        raise ConfigMissing, "#{key} is not set"
      end
    end

    def fetch_jwks(domain: auth0_domain)
      url = [domain, DEFAULT_ENDPOINT].join
      url = 'https://' + url unless url =~ %r{https?://}
      res = Faraday.get(url)
      # raise if response code is not HTTP success
      # Faraday's exception should fall through
      raise(NetworkError, 'Fetching JWKS key failed') unless res.success?

      JSON::JWK::Set.new(JSON.parse(res.body))
    end
  end
end
