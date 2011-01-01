require 'spec_helper'

describe FeedUpdaterWorker do
  it "checks for updates to feeds" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed-small.rss"))
    rss = RSS::Parser.parse(open(feed.url), false)
    Resque.should_receive(:enqueue)
    
    FeedUpdaterWorker.perform(feed.id)
    feed.reload.new_items?.should be_true
  end

  it "knows when a feed has no updates" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed-small.rss"), :new_items => true) # set new items to true so we know the code changes it
    rss = RSS::Parser.parse(open(feed.url), false)
    rss.items.each do |rss_item|
      item = Item.create!(:feed_id => feed.id, :title => rss_item.title, :body => rss_item.description, :published_date => rss_item.pubDate.to_s, :link => rss_item.link)
    end
    
    FeedUpdaterWorker.perform(feed.id)
    feed.reload.new_items?.should be_false
  end

  it "creates items for each new entry in the feed" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed-small.rss"))
    rss = RSS::Parser.parse(open(feed.url), false)
    Resque.should_receive(:enqueue)
    
    FeedUpdaterWorker.perform(feed.id)
    feed.reload.items.count.should == 1
  end

  it "adds new items to the twitter updater queue" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed-small.rss"))
    rss = RSS::Parser.parse(open(feed.url), false)
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum))

    FeedUpdaterWorker.perform(feed.id)
  end
end
