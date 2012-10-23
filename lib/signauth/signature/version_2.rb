require 'time'

module Signauth
  module Signature
    module Version2
      include Version1
      
      #http://www.w3.org/TR/NOTE-datetime
      ISO8601 = "%Y-%m-%dT%H:%M:%SZ"

      def add_authorization!(credentials)
        params['timestamp'] = Time.now.utc.strftime(ISO8601)
        super
      end

      def authenticate(credentials, skew = 15*60)
        validate_timestamp(skew)
        super(credentials)
      end

      protected
      
      def validate_timestamp(skew)
        begin
          timestamp = Time.iso8601(params['timestamp'])
        rescue => e
          raise Errors::InvalidTimestamp, "#{e.class}-#{e.message}"
        end

        if (timestamp.to_i - Time.now.to_i).abs >= skew
          raise Errors::RequestTimeTooSkewed,
            "Timestamp expired: Given timestamp (#{timestamp.utc.strftime(ISO8601)}) "\
            "not within #{skew}s of server time (#{Time.now.utc.strftime(ISO8601)})"
        end
        true
      end

    end
  end
end
