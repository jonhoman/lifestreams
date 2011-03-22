module StreamsHelper
  def get_bitly_clicks(url)
    Bitly.use_api_version_3
    bitly = Bitly.new(ENV['BITLY_LOGIN'], ENV['BITLY_API_KEY'])
    
    url ? bitly.clicks(url).user_clicks : 0
  end
end
