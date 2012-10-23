require 'securerandom'

module Signauth
  class Credentials
    attr_reader :access_key_id
    attr_reader :secret_access_key

    def initialize(key = random(20), secret = random(40))
      raise ArgumentError, "invalid key"    if key.nil? || key.empty?
      raise ArgumentError, "invalid secret" if secret.nil? || secret.empty?
      @access_key_id     = key
      @secret_access_key = secret
    end

    def to_h
      {
        "access_key_id"     => access_key_id,
        "secret_access_key" => secret_access_key
      }
    end

    private
    def random(size)
      SecureRandom.base64(size)
    end

  end
end
