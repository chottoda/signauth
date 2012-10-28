module Signauth
  module Signature
    module Version1
      include Base

      def add_authorization!(credentials)
        params['access_key_id']     = credentials.access_key_id
        params['signature_version'] = version
        params['signature_method']  ||= 'HMAC-SHA-256'

        params.delete('signature')
        params['signature'] = signature(credentials)
        params
      end

      def authenticate(&block)
        raise ArgumentError, "Block required" unless block_given?

        access_key_id = params['access_key_id']
        raise Erros::MissingAccessKeyId, 'must provide access_key_id parameter' if access_key_id.nil?

        credentials = yield(access_key_id) 
        begin
          given = params.delete('signature')
          validate_signature(given, signature(credentials))
        ensure
          params['signature'] = given
        end
        true
      end

      protected

      def version
        "1"
      end

      def algorhyzhm
        params['signature_method']
      end

    end
  end
end
