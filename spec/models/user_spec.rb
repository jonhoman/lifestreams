require 'spec_helper'

describe User do
  let :user do
    Factory(:user)
  end

  let :facebook_account do
    Factory(:facebook_account, :user_id => user.id)
  end

  let :email_list do
    Factory(:email_list, :user_id => user.id)
  end

  let :feed do
    Factory(:feed, :user_id => user.id)
  end

  let :stream do
    Factory(:stream, :user_id => user.id)
  end

  let :twitter_account do
    Factory(:twitter_account, :user_id => user.id)
  end

  it "retrieves its facebook accounts" do
    user.facebook_accounts.should include facebook_account
  end

  it "retrieves its email lists" do
    user.email_lists.should include email_list
  end

  it "retrieves its feeds" do
    user.feeds.should include feed
  end

  it "retrieves its streams" do
    user.streams.should include stream
  end

  it "retrieves its twitter accounts" do
    user.twitter_accounts.should include twitter_account
  end
end
