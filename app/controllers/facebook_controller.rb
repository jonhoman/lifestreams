class FacebookController < ApplicationController

  def connect
    ap redirect_uri
    redirect_to client.web_server.authorize_url(:redirect_uri => redirect_uri, :scope => 'offline_access')
  end

  def callback
    access_token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri)
    #user = JSON.parse(access_token.get('/me'))

    @account = FacebookAccount.new(
      :access_token => access_token.token,
      :user_id => current_user.id)

    notice = @account.save ? 'You successfully authorized your Facebook account.' : 
                             'There was an issue authorizing your Facebook account. Please try again.'

    redirect_to user_root_path, :notice => notice
  end

  def client
    OAuth2::Client.new(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET'], :site => 'https://graph.facebook.com')
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/facebook/callback'
    uri.query = nil
    uri.to_s
  end
      
end