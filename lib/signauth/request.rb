module Signauth
  class Request

    attr_reader :method
    attr_reader :host
    attr_reader :path
    attr_reader :params
    
    def initialize(method, host, path, params, signature_version = 1)
      sig_version = params['signature_version'] ||= signature_version
      extend(Signature.const_get("Version#{sig_version}"))
      @method = method
      @host   = host
      @path   = path
      @params = params.dup
    end

  end
end
