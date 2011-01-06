require 'spec_helper'

describe TwitterUpdaterWorker do
  before(:each) do
    @mash = Hashie::Mash.new
    @mash.id_str = "1234"
    @item = Item.create!(:title => "Hello, World!", :body => "My First Post")
  end
  
  it "shares the new item" do
    Twitter.should_receive(:update).and_return { @mash }
    TwitterUpdaterWorker.perform(@item.id)

    @item.reload.shared.should be_true
  end


  it "store the status id on the item" do
    Twitter.should_receive(:update).and_return { @mash }
    TwitterUpdaterWorker.perform(@item.id)

    @item.reload.status_id.should == "1234"
  end

  context "hit twitter" do
    it "updates the user's timeline" do
      TwitterUpdaterWorker.perform(@item.id)

      TwitterHelper.user_status.should == "Blog Post: #{@item.title}"

      # delete status update so subsquent tests don't fail
      TwitterHelper.cleanup(@item.reload.status_id)
    end
  end
end

class TwitterHelper
  class << self
    def user_status
      #TODO create twitter username from user
      Twitter.user_timeline("life_streams").first.text
    end

    def cleanup(status_id)
      Twitter.client.status_destroy(status_id)
    end

    private 

    def configure() 
      Twitter.configure do |config|
        config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
        config.oauth_token        = ENV['DEFAULT_OAUTH_TOKEN']
        config.oauth_token_secret = ENV['DEFAULT_OAUTH_TOKEN_SECRET']
      end
    end
  end
end
