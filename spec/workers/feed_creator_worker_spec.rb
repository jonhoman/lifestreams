require 'spec_helper'

describe FeedCreatorWorker do
  let :feed do
    #feed inline
    Factory(:feed, :url => "file://" + Rails.root.to_s + "/spec/data/feed.rss")
  end

  let :fake_entry do
    e = Feedzirra::Parser::RSSEntry.new
    e.published = Time.now.to_s
    e.title = "Title"
    e.content = "Content"
    e.url = "URL"
    e
  end

  let :fake_feed do
    f = Feedzirra::Parser::RSS.new 
    f.title = "JonHoman.com" 
    f.last_modified = Time.now
    f.entries << fake_entry
    f
  end

  it "stores the name of the feed" do
    FeedCreatorWorker.perform(feed.id)
    feed.reload.name.should == "JonHoman.com"
  end

  it "stores the build date of the feed" do
    FeedCreatorWorker.perform(feed.id)
    feed.reload.last_build_date.should == Time.parse("Mon, 10 Jan 2011 19:00:48 UTC +00:00")
  end

  it "creates Items for every item in the feed" do
    FeedCreatorWorker.perform(feed.id)
    feed.reload.items.count.should == 5
  end

  it "retries if it cannot connect to URL" do
    Feedzirra::Feed.should_receive(:fetch_and_parse).and_raise(StandardError.new("Unable to connect to the internetz"))
    Feedzirra::Feed.should_receive(:fetch_and_parse).and_return { fake_feed }

    FeedCreatorWorker.perform(feed.id)
    feed.reload.name.should == "JonHoman.com"
  end

  it "explodes if retry fails" do
    Feedzirra::Feed.should_receive(:fetch_and_parse).twice.and_raise(StandardError.new("Unable to connect to the internetz"))

    expect {
      FeedCreatorWorker.perform(feed.id)
    }.to raise_error(FeedCreatorWorker::MaxRetriesError)
  end

end
