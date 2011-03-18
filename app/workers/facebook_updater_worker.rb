class FacebookUpdaterWorker

  def self.perform(item_id, facebook_account_id)
    item = Item.find(item_id)
    account = FacebookAccount.find(facebook_account_id)

    client = OAuth2::Client.new(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET'], :site => 'https://graph.facebook.com')

    access_token = OAuth2::AccessToken.new(client, account.access_token)
    puts access_token.post 'me/feed', :message => "New Blog Post: #{item.link}"
  end
end
