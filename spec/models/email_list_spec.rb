require 'spec_helper'

describe EmailList do
  let :user do
    Factory(:user)
  end

  let! :email_list do
    Factory(:email_list, :user_id => user.id)
  end

  it "is valid with valid attributes" do
    email_list.should be_valid
  end

  it "is invalid without a name" do
    email_list.name = nil
    email_list.should_not be_valid
  end

  describe ".user" do
    it "returns all email lists associated with a user" do
      EmailList.user(user.id).count.should == 1
    end

    it "does not return other users' feeds" do
      email_list2 = Factory(:email_list, :user_id => email_list.user_id + 1) 

      EmailList.user(user.id).count.should == 1
    end
  end
end
