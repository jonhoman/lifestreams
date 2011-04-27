require 'spec_helper'

describe Recipient do
  let :recipient do
    Factory(:recipient)
  end

  it "has its hash value stored upon creation" do
    recipient.hash_value.should_not be_nil
  end

  describe "to_s" do
    it "returns the concatentation of the id and email address" do
      recipient.to_s.should == "#{recipient.id}#{recipient.email_address}"
    end
  end
end
