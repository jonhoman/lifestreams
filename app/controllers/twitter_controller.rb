class TwitterController < ApplicationController
  def connect
    @consumer = TwitterController.consumer
    @request_token = @consumer.get_request_token(:oauth_callback => 'http://127.0.0.1:3000/oauth/callback')
    
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.token

    redirect_to @request_token.authorize_url
  end

  def self.consumer
    OAuth::Consumer.new ENV['TWITTER_CONSUMER_KEY'], 
      ENV['TWITTER_CONSUMER_SECRET'], 
      {
        :site => 'https://api.twitter.com/',
        :request_token_path => '/oauth/request_token',
        :access_token_path => '/oauth/access_token',
        :authorize_path => 'oauth/authorize'

      }
  end
end
