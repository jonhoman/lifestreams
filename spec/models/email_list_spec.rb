require 'spec_helper'

describe EmailList do
  let :user do
    Factory(:user)
  end

  let :another_user do
    Factory(:user, :email => "another_email@example.com")
  end

  let! :email_list do
    Factory(:email_list, :user_id => user.id)
  end

  let! :account do
    Factory(:twitter_account, :user_id => user.id)
  end

  let! :stream do 
    Factory(:stream, :user_id => user.id)
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
      Factory(:email_list, :user_id => another_user.id) 

      EmailList.user(user.id).count.should == 1
    end
  end

  describe ".create_recipients_from_file" do
    it "returns text for recipients" do
      file = File.new(Rails.root.to_s + "/features/uploaded-files/recipients.txt")

      EmailList.create_recipients_from_file(file).should_not be_nil
    end
  end

  describe "#deactivate_stream" do
    context "one email list" do
      before(:each) do
        stream.email_lists << email_list
      end

      it "deactivates associated streams" do 
        email_list.deactivate_stream

        stream.reload.should_not be_active
      end

      it "deactivates associated streams on twitter account deletion" do 
        email_list.destroy

        stream.reload.should_not be_active
      end
    end
    context "two email lists" do
      before(:each) do
        stream.email_lists << email_list
        stream.email_lists << email_list
      end

      it "does not deactivate associated streams on twitter account deletion" do 
        email_list.destroy

        stream.reload.should be_active
      end
    end
    context "one email list and a twitter_account" do
      before(:each) do
        stream.email_lists << email_list
        stream.twitter_accounts << account
      end

      it "does not deactivate associated streams on twitter account deletion" do 
        email_list.destroy

        stream.reload.should be_active
      end
    end
  end
end

# == Schema Information
#
# Table name: email_lists
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  recipients_text :text
#

