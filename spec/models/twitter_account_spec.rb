require 'spec_helper'

describe TwitterAccount do
  let :user do
    Factory(:user)
  end

  let :valid_params do
    { 
      :handle => "test", 
      :access_token => "asdf", 
      :access_token_secret => "asdf",
      :user_id => user.id
    }
  end

  let :account do
    TwitterAccount.create!(valid_params)
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
end
