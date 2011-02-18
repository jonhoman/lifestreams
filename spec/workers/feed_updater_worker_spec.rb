require 'spec_helper'

describe FeedUpdaterWorker do
  let :feed do
    Factory(:feed, :url => "file://" + Rails.root.to_s + "/spec/data/feed-small.rss")
  end

  let :fake_twitter do
    Factory(:twitter_account, :handle => "fake")
  end

  let :pretend_twitter do
    Factory(:twitter_account, :handle => "pretend")
  end

  let :stream do
    Factory(:stream)
  end

  it "checks for updates to feeds" do
    Resque.should_receive(:enqueue)
    
    stream.update_attributes(:twitter_accounts => [fake_twitter])
    FeedUpdaterWorker.perform(feed.id, stream.id)

    feed.reload.new_items?.should be_true
  end

  it "knows when a feed has no updates" do
    rss = Feedzirra::Feed.fetch_and_parse(feed.url)
    rss.entries.each do |rss_item|
      item = Item.create!(:feed_id => feed.id, :title => rss_item.title, :body => rss_item.content, :published_date => rss_item.published, :link => rss_item.url)
    end
    
    FeedUpdaterWorker.perform(feed.id, stream.id)
    feed.reload.new_items?.should be_false
  end

  it "creates items for each new entry in the feed" do
    Resque.should_receive(:enqueue)
    
    stream.update_attributes(:twitter_accounts => [fake_twitter])
    FeedUpdaterWorker.perform(feed.id, stream.id)

    feed.reload.items.count.should == 1
  end

  it "adds new items to the twitter updater queue" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    stream.update_attributes(:twitter_accounts => [fake_twitter])
    FeedUpdaterWorker.perform(feed.id, stream.id)
  end

  it "queues twitter updates for both twitter accounts in the stream" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum)).twice

    stream.update_attributes(:twitter_accounts => [fake_twitter, pretend_twitter])

    FeedUpdaterWorker.perform(feed.id, stream.id)
  end

  context "unparsable feed" do
    before :each do
      bad_feed_url = "http://jonhoman.com"
      feed.update_attributes(:url => bad_feed_url)
    end

    it "throws an error if the feed url cannot be parsed" do
      expect {
        FeedUpdaterWorker.perform(feed.id, stream.id)
      }.to raise_error(FeedUpdaterWorker::UnparsableFeedError)
    end

    it "deactivates the stream if the feed cannot be parsed" do
      expect {
        FeedUpdaterWorker.perform(feed.id, stream.id)
      }.to raise_error(FeedUpdaterWorker::UnparsableFeedError)

      stream.reload.should_not be_active
    end
  end
end
