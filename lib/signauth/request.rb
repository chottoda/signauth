module Signauth
  class Request

    attr_accessor :method
    attr_accessor :host
    attr_accessor :path
    attr_accessor :params
    
    def initialize(signature_version = 1)
      extend(Signature.const_get("Version#{signature_version}"))
      @method = "GET"
      @host   = ""
      @path   = "/"
      @params = {}
    end

  end
end
