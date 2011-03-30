require 'spec_helper'

describe FeedUpdaterWorker do
  let(:feed) { Factory(:feed, :url => "file://" + Rails.root.to_s + "/spec/data/feed-small.rss") }

  let(:fake_twitter) { Factory(:twitter_account, :handle => "fake") }

  let(:pretend_twitter) { Factory(:twitter_account, :handle => "pretend") }

  let(:stream) { Factory(:stream, :feeds => [feed], :twitter_accounts => [fake_twitter]) }

  let(:email_list) { Factory(:email_list, :recipients_text => "jon@jonhoman.com") }

  let(:another_email_list) { Factory(:email_list, :recipients_text => "jonphoman@gmail.com") }

  let(:facebook_account) { Factory(:facebook_account) }

  it "checks for updates to feeds" do
    Resque.should_receive(:enqueue)

    expect {
      FeedUpdaterWorker.perform(stream.id, feed.id)
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
      FeedUpdaterWorker.perform(stream.id, feed.id)
    }.should_not change { feed.items.count }
  end

  it "adds the category(ies) of the article to the item" do
    Resque.should_receive(:enqueue)
    
    FeedUpdaterWorker.perform(stream.id, feed.id)

    ["tech", "personal"].each do |category|
      feed.reload.items.first.categories.should include(category)
    end
  end

  it "adds new jobs to the twitter updater queue" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "queues twitter updates for both twitter accounts in the stream" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum)).twice

    stream.twitter_accounts << pretend_twitter

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "add new jobs to the email list queue" do
    Resque.should_receive(:enqueue).with(EmailWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    stream.update_attributes! :twitter_accounts => [], :email_lists => [email_list]

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "add new jobs to the email list queue for each email list" do
    Resque.should_receive(:enqueue).with(EmailWorker, an_instance_of(Fixnum), an_instance_of(Fixnum)).twice

    stream.update_attributes! :twitter_accounts => [], :email_lists => [email_list, another_email_list]

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "add new jobs to the facebook queue" do
    Resque.should_receive(:enqueue).with(FacebookUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    stream.update_attributes! :twitter_accounts => [], :facebook_accounts => [facebook_account]

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "add new jobs to the both queues" do
    Resque.should_receive(:enqueue).with(TwitterUpdaterWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))
    Resque.should_receive(:enqueue).with(EmailWorker, an_instance_of(Fixnum), an_instance_of(Fixnum))

    stream.update_attributes! :email_lists => [email_list]

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end
  
  it "does not queue twitter updates when the item's category isn't in stream's categories" do
    Resque.should_not_receive(:enqueue)

    no_match = "fake_category"
    stream.update_attributes! :included_categories => no_match

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "queues twitter updates when the item's category is in stream's categories" do
    Resque.should_receive(:enqueue)

    category_match = "personal"
    stream.update_attributes! :included_categories => category_match 

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end

  it "queues twitter updates when the item's category is one of stream's categories" do
    Resque.should_receive(:enqueue)

    category_match = "fake_category,faker_category,personal"
    stream.update_attributes! :included_categories => category_match 

    FeedUpdaterWorker.perform(stream.id, feed.id)
  end
  context "unparsable feed" do
    before :each do
      bad_feed_url = "http://jonhoman.com"
      feed.update_attributes(:url => bad_feed_url)
    end

    it "throws an error if the feed url cannot be parsed" do
      expect {
        FeedUpdaterWorker.perform(stream.id, feed.id)
      }.to raise_error(FeedUpdaterWorker::UnparsableFeedError)
    end

    it "deactivates the stream if the feed cannot be parsed" do
      expect {
        FeedUpdaterWorker.perform(stream.id, feed.id)
      }.to raise_error(FeedUpdaterWorker::UnparsableFeedError)

      stream.reload.should_not be_active
    end
  end
end
