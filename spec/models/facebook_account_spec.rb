require 'spec_helper'

describe FacebookAccount do
  let :user do
    Factory(:user)
  end

  let! :facebook_account do
    Factory(:facebook_account, :user_id => user.id)
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
end
