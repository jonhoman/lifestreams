require 'spec_helper'

describe FeedWorker do
  it "stores the name of the feed" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"))

    FeedWorker.perform(feed.id)
    feed.reload.name.should == "JonHoman.com"
  end

  it "stores the build date of the feed" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"))

    FeedWorker.perform(feed.id)
    feed.reload.last_build_date.should == Time.parse("Sun, 19 Dec 2010 16:35:26 UTC +00:00")
  end

  it "creates Items for every item in the feed" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"))

    FeedWorker.perform(feed.id)
    feed.reload.items.count.should == 5
  end
  it "retries if it cannot connect to URL" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"))
    FeedWorker.should_receive(:open).and_raise(StandardError.new("Unable to connect to the internetz"))
    FeedWorker.should_receive(:open).and_return { open(feed.url) }

    FeedWorker.perform(feed.id)
    feed.reload.name.should == "JonHoman.com"
  end

  it "explodes if retry fails" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"))
    FeedWorker.should_receive(:open).twice.and_raise(StandardError.new("Unable to connect to the internetz"))

    expect {
      FeedWorker.perform(feed.id)
    }.to raise_error(FeedWorker::MaxRetriesError)
  end

end
