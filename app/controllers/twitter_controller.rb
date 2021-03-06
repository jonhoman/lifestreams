class TwitterController < ApplicationController
  before_filter :authenticate_user!, :only => :connect

  def connect
    consumer = TwitterController.consumer
    
    request_token = consumer.get_request_token(:oauth_callback => ENV['TWITTER_CALLBACK_URL'])
   
    set_session_info(request_token)

    redirect_to request_token.authorize_url
  end

  def callback
    request_token = OAuth::RequestToken.new(TwitterController.consumer,
                                             session[:request_token],
                                             session[:request_token_secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

    @account = current_user.twitter_accounts.build(
      :access_token => access_token.token, 
      :access_token_secret => access_token.secret, 
      :handle => access_token.params[:screen_name])

    notice = @account.save ? 'You successfully authorized your Twitter account.' : 
                             'There was an issue authorizing your Twitter account. Please try again.'

    redirect_to user_root_path, :notice => notice
  end

  def set_session_info(request_token)
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
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
