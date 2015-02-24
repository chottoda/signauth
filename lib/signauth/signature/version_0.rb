module Signauth
  module Signature
    module Version0
      include Base

      def add_authorization!(credentials, scheme = 'signauth')
        access_key_id = credentials.access_key_id
        signature     = signature(credentials)

        headers['Authorization'] = authorization(scheme, access_key_id, signature)
      end

      def authenticate(&block)
        raise ArgumentError, "Block required" unless block_given?

        scheme, access_key_id, given = authorization_parts 
        raise Errors::MissingSecurityHeader if scheme.nil? || access_key_id.nil? || given.nil?

        credentials = yield(access_key_id, scheme)
        validate_signature(given, signature(credentials))
        true
      end

      private
      
      def authorization(scheme, access_key_id, signature)
        "#{scheme} #{access_key_id}:#{signature}"
      end

      def authorization_parts
        match_data = headers['HTTP_AUTHORIZATION'].match(/^(\S+) (\S+):(\S+)/)
        return nil unless match_data
        match_data[1, 3]
      end

    end
  end
end
