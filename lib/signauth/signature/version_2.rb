require 'time'

module Signauth
  module Signature
    module Version2
      include Version1

      def add_authorization!(credentials)
        params['timestamp'] = Time.now.utc.strftime(ISO8601)
        super
      end

      def authenticate(skew = 15*60, &block)
        validate_timestamp(params['timestamp'], skew)
        super(&block)
      end

      protected

      def version
        "2"
      end

    end
  end
end
