require 'spec_helper'

describe Stream do
  let :user do
    Factory(:user)
  end

  let :feed do
    Factory(:feed)
  end

  let :twitter_account do
    Factory(:twitter_account)
  end

  let :stream do
    Factory(:stream, :user_id => user.id, :feed_id => feed.id, :twitter_account_id => twitter_account.id)
  end

  it "is valid with valid attributes" do
    stream.should be_valid
  end

  it "is not valid without a name" do
    stream.name = nil
    stream.should_not be_valid
  end
end
