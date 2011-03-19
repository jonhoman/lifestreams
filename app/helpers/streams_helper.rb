module StreamsHelper
  def determine_selected_feed
    @stream.feed ? @stream.feed.id : nil
  end

  def determine_selected_twitter_account
    @stream.twitter_accounts.empty? ? nil : @stream.twitter_accounts.map(&:id)
  end

  def determine_selected_email_list
    @stream.email_lists.empty? ? nil : @stream.email_lists.map(&:id)
  end

  def get_bitly_clicks(url)
    Bitly.use_api_version_3
    bitly = Bitly.new(ENV['BITLY_LOGIN'], ENV['BITLY_API_KEY'])
    
    url ? bitly.clicks(url).user_clicks : 0
  end
end
