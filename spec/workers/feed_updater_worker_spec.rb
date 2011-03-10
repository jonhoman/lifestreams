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
    Factory(:stream, :feed => feed, :twitter_accounts => [fake_twitter])
  end

  let :email_list do
    Factory(:email_list, :recipients_text => "jon@jonhoman.com")
  end

  let :another_email_list do
    Factory(:email_list, :recipients_text => "jonphoman@gmail.com")
  end

  it "checks for updates to feeds" do
    Resque.should_receive(:enqueue)

    expect {
      FeedUpdaterWorker.perform(stream.id)
    }.should change { feed.items.count }
  end

  it "knows when a feed has no updates" do
    rss = Feedzirra::Feed.fetch_and_parse(feed.url)
    rss.entries.each do |rss_item|
      item = Item.create! :feed_id => feed.id, 
                          :title => rss_item.title, 
                          :body => rss_item.content, 
                          :published_date => rss_item.published, 
                          :link => rss_item.url
    end
    
    expect {
      FeedUpdaterWorker.perform(stream.id)
    }.should_not change { feed.items.count }
  end

  it "adds the category(ies) of the article to the item" do
    Resque.should_receive(:enqueue)
    
    FeedUpdaterWorker.perform(stream.id)

    feed.reload.items.first.categories.should include("tech")
    feed.reload.items.first.categories.should include("personal")
  end

  it "adds new jobs to the twitter updater queue" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    FeedUpdaterWorker.perform(stream.id)
  end

  it "queues twitter updates for both twitter accounts in the stream" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum)).twice

    stream.twitter_accounts << pretend_twitter

    FeedUpdaterWorker.perform(stream.id)
  end

  it "add new jobs to the email list queue" do
    Resque.should_receive(:enqueue).with(EmailWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    stream.update_attributes! :twitter_accounts => [], :email_lists => [email_list]

    FeedUpdaterWorker.perform(stream.id)
  end

  it "add new jobs to the email list queue for each email list" do
    Resque.should_receive(:enqueue).with(EmailWorker, an_instance_of(Fixnum), an_instance_of(Fixnum)).twice

    stream.update_attributes! :twitter_accounts => [], :email_lists => [email_list, another_email_list]

    FeedUpdaterWorker.perform(stream.id)
  end

  it "add new jobs to the both queues" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))
    Resque.should_receive(:enqueue).with(EmailWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    stream.update_attributes! :email_lists => [email_list]

    FeedUpdaterWorker.perform(stream.id)
  end

  context "unparsable feed" do
    before :each do
      bad_feed_url = "http://jonhoman.com"
      feed.update_attributes(:url => bad_feed_url)
    end

    it "throws an error if the feed url cannot be parsed" do
      expect {
        FeedUpdaterWorker.perform(stream.id)
      }.to raise_error(FeedUpdaterWorker::UnparsableFeedError)
    end

    it "deactivates the stream if the feed cannot be parsed" do
      expect {
        FeedUpdaterWorker.perform(stream.id)
      }.to raise_error(FeedUpdaterWorker::UnparsableFeedError)

      stream.reload.should_not be_active
    end
  end
end
