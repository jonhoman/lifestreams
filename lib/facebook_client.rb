class FacebookClient

  class << self
    def status_update(item, access_token)
      self.init(access_token)

      @access_token.post 'me/feed', :message => "New Blog Post: #{item.title} #{item.link}"
    end
    
    def init(access_token)
      @client = OAuth2::Client.new(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET'], :site => 'https://graph.facebook.com')
      @access_token = OAuth2::AccessToken.new(@client, access_token)
    end
  end

end
