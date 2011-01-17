class TwitterUpdaterWorker
  @queue = :twitter_updating

  def self.perform(item_id, twitter_account_id)
    item = Item.find(item_id)
    twitter_account = TwitterAccount.find(twitter_account_id)

    Rails.logger.debug "Twitter Account info: #{twitter_account.access_token} : #{twitter_account.access_token_secret}"

    TwitterUpdaterWorker.configure(twitter_account.access_token, twitter_account.access_token_secret)

    result = Twitter.update("Blog Post: #{item.title}") 

    item.update_attributes!(:shared => true, :status_id => result.id_str)
  end

  def self.configure(oauth_token, oauth_token_secret)
    Twitter.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = oauth_token
      config.oauth_token_secret = oauth_token_secret
    end
  end
end
