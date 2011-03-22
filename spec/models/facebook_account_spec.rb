require 'spec_helper'

describe FacebookAccount do
  let :user do
    Factory(:user)
  end

  let! :facebook_account do
    Factory(:facebook_account, :user_id => user.id)
  end

  let :list do
    Factory(:email_list, :user_id => user.id)
  end

  let! :stream do 
    Factory(:stream, :user_id => user.id)
  end

  describe ".user" do
    it "returns all facebook accounts associated with a user" do
      FacebookAccount.user(user.id).count.should == 1
    end

    it "does not return other users' feeds" do
      Factory(:facebook_account, :user_id => facebook_account.user_id + 1) 

      FacebookAccount.user(user.id).count.should == 1
    end
  end

  describe "#deactivate_stream" do
    context "one facebook account" do
      before(:each) do
        stream.facebook_accounts << facebook_account
      end

      it "deactivates associated streams on facebook account deletion" do 
        facebook_account.destroy

        stream.reload.should_not be_active
      end
    end
    context "two facebook accounts" do
      before(:each) do
        stream.facebook_accounts << facebook_account
        stream.facebook_accounts << facebook_account
      end

      it "does not deactivate associated streams on facebook account deletion" do 
        facebook_account.destroy

        stream.reload.should be_active
      end
    end
    context "one facebook account and an email list" do
      before(:each) do
        stream.facebook_accounts << facebook_account
        stream.email_lists << list
      end

      it "does not deactivate associated streams on facebook account deletion" do 
        facebook_account.destroy

        stream.reload.should be_active
      end
    end
  end
end
