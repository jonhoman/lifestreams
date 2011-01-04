class TwitterUpdaterWorker
  @queue = :twitter_updating

  def self.perform(item_id)
    item = Item.find(item_id)

    Twitter.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['DEFAULT_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['DEFAULT_OAUTH_TOKEN_SECRET']
    end

    result = Twitter.update("Blog Post: #{item.title}") 
    
    item.update_attributes!(:shared => true, :status_id => result.id_str)
  end
end
