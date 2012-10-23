require 'openssl'
require 'base64'

module Signauth
  module Signer
    extend self

    def sign(secret, string_to_sign, digest_method = 'sha256')
      Base64.encode64(hmac(secret, string_to_sign, digest_method)).strip
    end

    def hmac(key, value, digest = 'sha256')
      OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new(digest), key, value)
    end

  end
end
