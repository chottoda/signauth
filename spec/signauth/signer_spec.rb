require 'spec_helper'

describe Signauth::Signer do
  describe "#sign" do
    let(:secret) { "secret" }
    let(:string_to_sign) { "string to sign" }
    subject {  Signauth::Signer.sign(secret, string_to_sign) }

    it { should eq "fis5QmLSbj+hOfuCgndTJdCdp81sZh0GwayU7Y+5Cnw=" } 
  end
end
