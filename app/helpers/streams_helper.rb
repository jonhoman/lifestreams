module StreamsHelper
  def determine_selected_feed
    @stream.feed ? @stream.feed.id : nil
  end

  #TODO return all account ids
  def determine_selected_twitter_account
    @stream.twitter_accounts.empty? ? nil : @stream.twitter_accounts.map(&:id)
  end

  def get_bitly_clicks(hash)
    Bitly.use_api_version_3
    bitly = Bitly.new(ENV['BITLY_LOGIN'], ENV['BITLY_API_KEY'])
    
    hash ? bitly.clicks(hash).user_clicks : 0
  end
end
