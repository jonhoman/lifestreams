class FacebookUpdaterWorker
  @queue = :facebook

  class << self

    def perform(item_id, facebook_account_id)
      item = Item.find(item_id)
      account = FacebookAccount.find(facebook_account_id)

      unless item.bitly_url && item.bitly_url.present?
        item.update_attributes :bitly_url => create_bitly_link(item.link)
      end

      FacebookClient.status_update(item, account.access_token)
    end

    def create_bitly_link(link)
      Bitly.use_api_version_3
      bitly = Bitly.new(ENV['BITLY_LOGIN'], ENV['BITLY_API_KEY'])
      url = bitly.shorten(link)
      url.short_url
    end
  end
end
