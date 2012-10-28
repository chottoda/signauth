module Signauth
  class Request

    attr_accessor :method
    attr_accessor :host
    attr_accessor :path
    attr_accessor :params
    attr_accessor :headers
    
    def initialize(signature_version = 0)
      extend(Signature.const_get("Version#{signature_version}"))
      @params  = {}
      @headers = {}
    end

  end
end
