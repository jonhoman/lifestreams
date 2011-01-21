require 'spec_helper'

describe Feed do
  let :user do
    Factory(:user)
  end

  let!(:feed) do
    Factory(:feed, :user_id => user.id)
  end

  it "is valid with valid attributes" do
    feed.should be_valid
  end

  it "is not valid without a name" do
    feed.name = nil
    feed.should_not be_valid
  end

  it "is not valid without a url" do
    feed.url = nil
    feed.should_not be_valid
  end

  it "is not valid with a bad url" do
    feed.url = "asdf"
    feed.should_not be_valid
  end
  it "has a reference to a user" do
    feed.user_id.should == user.id
  end

  describe ".user" do

    it "returns all accounts associated with a user" do
      Feed.user(user.id).count.should == 1
    end

    it "does not return other users' feeds" do
      feed2 = Factory(:feed, :user_id => feed.user_id + 1) 

      Feed.user(user.id).count.should == 1
    end
  end
end
