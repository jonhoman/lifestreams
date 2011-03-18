require 'spec_helper'

describe FacebookUpdaterWorker do
  use_vcr_cassette "facebook", :record => :new_episodes

  let :item do
    Factory(:item, :title => "Hello, World!", :body => "My First Post", :link => "http://google.com")
  end

  let :facebook_account do
    Factory(:facebook_account)
  end

  let :client do
    OAuth2::Client.new(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET'], :site => 'https://graph.facebook.com')
  end

  let :access_token do
    OAuth2::AccessToken.new client, facebook_account.access_token
  end

  it "publishes a status update" do
    access_token.should_receive(:post)
    FacebookUpdaterWorker.perform(item.id, facebook_account.id)
  end
end
