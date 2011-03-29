require 'spec_helper'

describe Feed do
  use_vcr_cassette "feed"

  let :user do
    Factory(:user)
  end

  let! :feed do
    Factory(:feed, :user_id => user.id)
  end
  
  let :item do
    Factory(:item)
  end

  let! :stream do
    Factory(:stream, :user_id => user.id, :feed_id => feed.id)
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
    it "returns all feeds associated with a user" do
      Feed.user(user.id).count.should == 1
    end

    it "does not return other users' feeds" do
      feed2 = Factory(:feed, :user_id => feed.user_id + 1) 

      Feed.user(user.id).count.should == 1
    end
  end

  describe "#deactivate_stream" do
    it "deactivates associated streams on feed deletion" do
      feed.destroy

      stream.reload.should_not be_active
    end
  end

  describe "#recent_items" do
    it "returns items" do
      feed.items << item
      feed.recent_items.first.class.should == Item
    end

    it "returns at most 3 items" do
      items = []
      5.times { |n| items << Factory(:item, :title => n, :published_date => DateTime.now - n.days) }
      feed.update_attributes! :items => items
      feed.recent_items.count.should == 3
    end
  end
  
  describe "#determine_feed_url" do
    it "returns the feed url for a given url" do
      expected_rss_url = "http://tanyahoman.com/feed/"
      feed.url = "http://tanyahoman.com"

      feed.determine_feed_url.should == expected_rss_url
    end
  end
end
