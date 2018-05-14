# frozen_string_literal: true

require 'bs_jwt/version'
require 'bs_jwt/railtie' if defined?(Rails)

##
# Module BS::JWT
# Used to decode, verify, and process JSON Web Tokens (JWTs) issued by Auth0
# in applications developed and used at the company Reverse-Retail GmbH
# (www.buddyandselly.com), Hamburg, Germany.
# BS stands for Buddy&Selly.
#
# The purpose of this library is to avoid code duplication among different
# Rails apps, such as Buddy, B&S Inventory, or B&S Packing.

module BsJwt
  class BaseError < RuntimeError; end

  class KeyMissing < BaseError; end
  class ConfigMissing < BaseError; end
  class VerificationError < BaseError; end
  class NetworkError < BaseError; end

  mattr_reader :auth0_domain
  mattr_writer :jwks_endpoint, :jwks_key

  DEFAULT_ENDPOINT = '/.well_known/jwks.json'

  class << self
    def process_jwt(jwt)
      return false unless (decoded = verify_and_decode(jwt))
      process_payload(decoded)
    end

    def process_auth0_hash(auth0_hash)
      unless auth0_hash.is_a?(Hash)
        raise ArgumentError, 'Auth0 Hash must be an instance of Hash'
      end
      jwt = auth0_hash.dig('credentials', 'id_token')
      process_jwt(jwt)
    end

    def verify_and_decode(jwt)
      return false unless jwt.is_a?(String)
      JSON::JWT.decode(jwt, jwks_key)
    rescue JWT::VerificationError, JWT::DecodeError
      false
    end

    # Fetches and overwrites the JWKS 
    def update_jwks
      check_config
      @jwks_key = fetch_jwks
    end

    def jwks_key
      @jwks_key || update_jwks || raise(KeyMissing, 'Fetching JWKS key failed')
    end

    def auth0_domain=(new_val)
      new_val = 'https://' + new_val unless new_val =~ %r{^https?\:\/\/}
      @auth0_domain = new_val
    end

    private

    def check_config
      %i[auth0_domain].each do |key|
        val = send(key)
        next if val && (val.respond_to?(:empty?) && !val.empty?) # present
        raise ConfigMissing, "#{key} is not set"
      end
    end

    def jwks_endpoint
      @jwks_endpoint || DEFAULT_ENDPOINT
    end

    def fetch_jwks(domain: auth0_domain, endpoint: jwks_endpoint)
      url = [domain, endpoint].join
      res = Faraday.get(url)
      # raise if response code is not HTTP success
      # Faraday's exception should fall through
      raise NetworkError unless res.success?
      JSON::JWK::Set.new(JSON.parse(res.body))
    end
  end
end
