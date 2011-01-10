require 'spec_helper'

describe User do
  let :user do
    Factory(:user)
  end

  it "has a reference to twitter accounts" do
    user.twitter_accounts.count.should == 0 
  end

  it "returns the correct number of twitter accounts" do
    TwitterAccount.create!( 
      :handle => "test", 
      :access_token => "asdf", 
      :access_token_secret => "asdf", 
      :user_id => user.id ) 

    user.twitter_accounts.count.should == 1
  end
end
