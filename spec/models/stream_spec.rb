require 'spec_helper'

describe Stream do
  use_vcr_cassette "stream", :record => :new_episodes

  let :user do
    Factory(:user)
  end

  let :feed do
    Factory(:feed)
  end

  let :twitter_account do
    Factory(:twitter_account)
  end

  let :facebook_account do
    Factory(:facebook_account)
  end

  let :email_list do
    Factory(:email_list)
  end

  let :stream do
    Factory(:stream, :user_id => user.id, :feed_id => feed.id)
  end

  it "is valid with valid attributes" do
    stream.should be_valid
  end

  it "is not valid without a name" do
    stream.name = nil
    stream.should_not be_valid
  end

  describe "#total_destination_count" do
    it "return the total number of destinations" do
      stream.total_destination_count.should be_zero

      stream.twitter_accounts << [twitter_account]
      stream.facebook_accounts << [facebook_account]
      stream.email_lists << [email_list]
      stream.total_destination_count.should == 3
    end
  end
end
