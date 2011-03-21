require 'spec_helper'

describe StreamsHelper do
  before(:each) do
    @stream = Factory(:stream)
  end

  describe "determine_selected_feed" do
    use_vcr_cassette "feed", :record => :new_episodes

    it "returns nil if no feed selected for a stream" do
      determine_selected_feed.should be_nil
    end

    it "returns the feed id if a feed is selected for a stream" do
      @stream.feed = Factory(:feed)
      determine_selected_feed.should_not be_nil
    end
  end

  describe "determine_selected_twitter_account" do
    it "returns nil if no twitter account selected for a stream" do
      determine_selected_twitter_account.should be_nil
    end

    it "returns the twitter account id if a twitter account is selected for a stream" do
      @stream.twitter_accounts << Factory(:twitter_account)
      determine_selected_twitter_account.should_not be_nil
    end
  end

  describe "determine_selected_email_list" do
    it "returns nil if no twitter account selected for a stream" do
      determine_selected_email_list.should be_nil
    end

    it "returns the twitter account id if a twitter account is selected for a stream" do
      @stream.email_lists << Factory(:email_list)
      determine_selected_email_list.should_not be_nil
    end
  end

  describe "get_bitly_clicks" do
    use_vcr_cassette "bitly_clicks", :record => :new_episodes

    it "returns the number of clicks for the given bitly hash" do
      get_bitly_clicks("fXEv5E").should == 0
    end

    it "returns 0 when given a nil bitly hash" do
      get_bitly_clicks(nil).should == 0
    end
  end
end
