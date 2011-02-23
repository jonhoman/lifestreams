require 'spec_helper'

describe TwitterAccount do
  let :user do
    Factory(:user)
  end

  let :account do
    Factory(:twitter_account, :user_id => user.id)
  end

  let! :stream do 
    Factory(:stream, :user_id => user.id)
  end

  it "is valid with valid attributes" do
    account.should be_valid
  end

  it "is not valid without an access token" do
    account.access_token = nil
    account.should_not be_valid
  end

  it "is not valid without an access token secret" do
    account.access_token_secret = nil
    account.should_not be_valid
  end

  it "is not valid without a twitter handle" do
    account.handle = nil
    account.should_not be_valid
  end

  it "has a reference to a user" do
    account.user_id.should == user.id
  end

  it "returns all accounts associated with a user" do
    account2 = Factory(:twitter_account, :user_id => account.user_id + 1) 

    TwitterAccount.user(user.id).count.should == 1
  end

  describe "#deactive_stream" do
    before(:each) do
      stream.twitter_accounts << account
    end

    it "deactivates associated streams" do 
      account.deactivate_stream

      stream.reload.should_not be_active
    end

    it "deactivates associated streams twitter account deletion" do 
      account.destroy

      stream.reload.should_not be_active
    end
  end
end
