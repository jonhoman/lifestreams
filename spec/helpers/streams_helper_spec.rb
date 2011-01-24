require 'spec_helper'

describe StreamsHelper do
  before(:each) do
    @stream = Factory(:stream)
  end

  describe "determine selected feed" do
    it "returns nil if no feed selected for a stream" do
      determine_selected_feed.should be_nil
    end

    it "returns the feed id if a feed is selected for a stream" do
      @stream.feed = Factory(:feed)
      determine_selected_feed.should_not be_nil
    end
  end

  describe "determine selected stream" do
    it "returns nil if no twitter account selected for a stream" do
      determine_selected_twitter_account.should be_nil
    end

    it "returns the twitter account id if a twitter account is selected for a stream" do
      @stream.twitter_account = Factory(:twitter_account)
      determine_selected_twitter_account.should_not be_nil
    end
  end
end
