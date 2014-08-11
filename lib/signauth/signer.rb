require 'openssl'
require 'base64'

module Signauth
  module Signer
    extend self

    def sign(secret, string_to_sign, algorithm = 'HMAC-SHA-256')
      Base64.encode64(hmac(secret, string_to_sign, algorithm)).strip
    end

    def hmac(key, value, algorithm = 'HMAC-SHA-256')
      digest = digest_name(algorithm)
      OpenSSL::HMAC.digest(OpenSSL::Digest.new(digest), key, value)
    end

    def slow_string_comparison(given, computed)
      return false if given.nil? || computed.nil? || given.length != computed.length
      match = true
      computed.chars.each_with_index{|c, i| match &= c == given[i] }
      match
    end

    private

    def digest_name(algorithm)
      ALGORITHM_DIGEST_MAPPING[algorithm]
    end

    ALGORITHM_DIGEST_MAPPING = {
      "HMAC-MD5"     => "md5",
      "HMAC-SHA-1"   => "sha1",
      "HMAC-SHA-224" => "sha224",
      "HMAC-SHA-256" => "sha256",
      "HMAC-SHA-384" => "sha384",
      "HMAC-SHA-512" => "sha512",
    }
  end
end
