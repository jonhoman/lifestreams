class TwitterUpdaterWorker
  @queue = :twitter_updating

  class << self
    def perform(item_id, twitter_account_id)
      item = Item.find(item_id)
      twitter_account = TwitterAccount.find(twitter_account_id)

      Rails.logger.debug "Twitter Account info: #{twitter_account.access_token} : #{twitter_account.access_token_secret}"

      TwitterUpdaterWorker.configure(twitter_account.access_token, twitter_account.access_token_secret)

      url = shorten_post_url(item.link)

      result = Twitter.update("New Blog Post: #{item.title} #{url}") 

      item.update_attributes!(:shared => true, :status_id => result.id_str)
    end

    def configure(oauth_token, oauth_token_secret)
      Twitter.configure do |config|
        config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
        config.oauth_token        = oauth_token
        config.oauth_token_secret = oauth_token_secret
      end
    end

    private

    def shorten_post_url(link)
      Bitly.use_api_version_3
      bitly = Bitly.new(ENV['BITLY_LOGIN'], ENV['BITLY_API_KEY'])
      url = bitly.shorten(link)
      url.short_url
    end
  end
end
