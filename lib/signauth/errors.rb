module Signauth
  module Errors
    class MissingSecurityHeader < StandardError; end
    class MissingAccessKeyId < StandardError; end
    class SignatureDoesNotMatch < StandardError; end
    class InvalidTimestamp < StandardError; end
    class RequestTimeTooSkewed < StandardError; end
  end
end
