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
    Factory(:stream, :twitter_accounts => [fake_twitter])
  end

  it "checks for updates to feeds" do
    Resque.should_receive(:enqueue)

    expect {
      FeedUpdaterWorker.perform(feed.id, stream.id)
    }.should change { feed.items.count }
  end

  it "knows when a feed has no updates" do
    rss = Feedzirra::Feed.fetch_and_parse(feed.url)
    rss.entries.each do |rss_item|
      item = Item.create!(:feed_id => feed.id, :title => rss_item.title, :body => rss_item.content, :published_date => rss_item.published, :link => rss_item.url)
    end
    
    expect {
      FeedUpdaterWorker.perform(feed.id, stream.id)
    }.should_not change { feed.items.count }
  end

  it "adds new items to the twitter updater queue" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    FeedUpdaterWorker.perform(feed.id, stream.id)
  end

  it "queues twitter updates for both twitter accounts in the stream" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum)).twice

    stream.twitter_accounts << pretend_twitter

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
