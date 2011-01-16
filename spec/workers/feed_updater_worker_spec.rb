require 'spec_helper'

describe FeedUpdaterWorker do
  let :feed do
    Factory(:feed, :url => "file://" + Rails.root.to_s + "/spec/data/feed-small.rss")
  end

  let :twitter_account do
    Factory(:twitter_account)
  end

  it "checks for updates to feeds" do
    Resque.should_receive(:enqueue)
    
    FeedUpdaterWorker.perform(feed.id, twitter_account.id)
    feed.reload.new_items?.should be_true
  end

  it "knows when a feed has no updates" do
    rss = Feedzirra::Feed.fetch_and_parse(feed.url)
    rss.entries.each do |rss_item|
      item = Item.create!(:feed_id => feed.id, :title => rss_item.title, :body => rss_item.content, :published_date => rss_item.published, :link => rss_item.url)
    end
    
    FeedUpdaterWorker.perform(feed.id, twitter_account.id)
    feed.reload.new_items?.should be_false
  end

  it "creates items for each new entry in the feed" do
    Resque.should_receive(:enqueue)
    
    FeedUpdaterWorker.perform(feed.id, twitter_account.id)
    feed.reload.items.count.should == 1
  end

  it "adds new items to the twitter updater queue" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    FeedUpdaterWorker.perform(feed.id, twitter_account.id)
  end
end
