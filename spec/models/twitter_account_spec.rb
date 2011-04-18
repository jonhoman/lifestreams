require 'spec_helper'

describe TwitterAccount do
  let :user do
    Factory(:user)
  end

  let :account do
    Factory(:twitter_account, :user_id => user.id)
  end

  let :list do
    Factory(:email_list, :user_id => user.id)
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

  it "returns all accounts associated with a user" do
    account2 = Factory(:twitter_account, :user_id => account.user_id + 1) 

    user.twitter_accounts.count.should == 1
  end

  describe "#deactivate_stream" do
    context "one twitter account" do
      before(:each) do
        stream.twitter_accounts << account
      end

      it "deactivates associated streams on twitter account deletion" do 
        account.destroy

        stream.reload.should_not be_active
      end
    end
    
    context "two twitter accounts" do
      before(:each) do
        stream.twitter_accounts << account
        stream.twitter_accounts << account
      end

      it "does not deactivate associated streams on twitter account deletion" do 
        account.destroy

        stream.reload.should be_active
      end
    end
    
    context "one twitter account and an email list" do
      before(:each) do
        stream.twitter_accounts << account
        stream.email_lists << list
      end

      it "does not deactivate associated streams on twitter account deletion" do 
        account.destroy

        stream.reload.should be_active
      end
    end
  end
end

# == Schema Information
#
# Table name: twitter_accounts
#
#  id                  :integer         not null, primary key
#  handle              :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  access_token        :string(255)
#  access_token_secret :string(255)
#  user_id             :integer
#  active              :boolean         default(TRUE)
#

