require 'spec_helper'

describe FeedUpdaterWorker do
  it "checks for updates to feeds" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed-small.rss") )

    rss = RSS::Parser.parse(open(feed.url), false)
    
    FeedUpdaterWorker.perform(feed.id)
    feed.reload.new_items?.should be_true
  end

  it "creates items for each new entry in the feed" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed-small.rss") )

    rss = RSS::Parser.parse(open(feed.url), false)
    
    FeedUpdaterWorker.perform(feed.id)
    feed.reload.items.count.should == 1
  end
end
