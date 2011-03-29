require 'spec_helper'

describe StreamsHelper do
  before(:each) do
    @stream = Factory(:stream)
  end

  describe "get_bitly_clicks" do
    use_vcr_cassette "bitly_clicks"

    it "returns the number of clicks for the given bitly hash" do
      bitly_hash = "fXEv5E"

      get_bitly_clicks(bitly_hash).should == 0
    end

    it "returns 0 when given a nil bitly hash" do
      get_bitly_clicks(nil).should == 0
    end
  end
end
