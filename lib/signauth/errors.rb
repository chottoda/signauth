module Signauth
  module Errors
    class SignatureDoesNotMatch < StandardError; end
    class InvalidTimestamp < StandardError; end
    class RequestTimeTooSkewed < StandardError; end
  end
end
