require 'spec_helper'

describe TwitterUpdaterWorker do
  before(:each) do
    @item = Item.create!(:title => "Hello, World!", :body => "My First Post")
  end
  
  it "shares the new item" do
    TwitterUpdaterWorker.perform(@item.id)

    @item.reload.shared.should be_true
  end

  it "updates the user's timeline" do
    TwitterUpdaterWorker.perform(@item.id)

    TwitterHelper.user_status.should == "Blog Post: #{@item.title}"
  end

  it "store the status id on the item" do
    TwitterUpdaterWorker.perform(@item.id)

    @item.reload.status_id.should_not be_nil
  end

  after(:each) do
    TwitterHelper.cleanup(@item.reload.status_id)
  end
end

class TwitterHelper
  def self.user_status
    Twitter.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['DEFAULT_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['DEFAULT_OAUTH_TOKEN_SECRET']
    end

    #TODO create twitter username from user
    Twitter.user_timeline("life_streams").first.text
  end

  def self.cleanup(status_id)
    Twitter.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['DEFAULT_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['DEFAULT_OAUTH_TOKEN_SECRET']
    end

    Twitter.client.status_destroy(status_id)
  end
end
