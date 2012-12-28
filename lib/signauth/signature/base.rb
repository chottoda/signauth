require 'uri'
require 'cgi'

module Signauth
  module Signature
    module Base

      protected
      ISO8601 = "%Y-%m-%dT%H:%M:%SZ" #http://www.w3.org/TR/NOTE-datetime

      def algorhyzhm
        'HMAC-SHA-256'
      end

      def signature(credentials)
        Signer.sign(credentials.secret_access_key, string_to_sign, algorhyzhm)
      end
      
      def string_to_sign
        [
          method.to_s.upcase,
          host.to_s.downcase,
          CGI.escape(path.to_s),
          params.sort.collect { |n, v| encoded(n, v) }.join('&'),
        ].join("\n")
      end

      def encoded(name, value)
        "#{CGI.escape(name.to_s)}=#{CGI.escape(value.to_s)}"
      end

      def validate_timestamp(timestamp, skew)
        begin
          time = Time.iso8601(timestamp)
        rescue => e
          raise Errors::InvalidTimestamp, "#{e.class}-#{e.message}"
        end

        current_time = Time.now
        if (time.to_i - current_time.to_i).abs >= skew
          raise Errors::RequestTimeTooSkewed,
            "Timestamp expired: Given timestamp (#{timestamp}) "\
            "not within #{skew}s of server time (#{current_time.utc.strftime(ISO8601)})"
        end
        true
      end

      def validate_signature(given, computed)
        unless Signer.slow_string_comparison(given, computed)
          raise Errors::SignatureDoesNotMatch,
            "Invalid signature: should have sent "\
            "Base64(#{algorhyzhm}(secret, #{string_to_sign.inspect}))"\
            ", but given #{given}"
        end
      end

    end
  end
end
