require 'spec_helper'

describe FeedWorker do
  it "stores the name of the feed" do
    feed = Feed.create!(:url => (Rails.root.to_s + "/spec/data/feed.rss"))
    feed.name.should be_nil

    FeedWorker.perform(feed.id)
    feed.reload.name.should == "JonHoman.com"
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
