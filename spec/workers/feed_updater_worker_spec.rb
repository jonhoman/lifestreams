require 'spec_helper'

describe FeedUpdaterWorker do
  it "checks for updates to feeds" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"), :new_items => true) # make new_items? true to cause test to fail

    rss = RSS::Parser.parse(open(feed.url), false)

    # Create all the items for the feed so checking for updates works properly
    rss.items.each do |item|
      Item.create!(
        :title => item.title, 
        :body => item.description, 
        :published_date => item.pubDate.to_s,
        :link => item.link,
        :feed_id => feed.id
      )
    end
    
    FeedUpdaterWorker.perform(feed.id)
    feed.reload.new_items?.should be_false
  end
end
