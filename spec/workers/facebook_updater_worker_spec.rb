require 'spec_helper'

describe FacebookUpdaterWorker do
  use_vcr_cassette "facebook", :record => :new_episodes

  let :item do
    Factory(:item, :title => "Hello, World!", :body => "My First Post", :link => "http://google.com")
  end

  let :facebook_account do
    Factory(:facebook_account, :access_token => "159708614082645|0f0b41318da90504409c7450-100002177187657|L1B6C40hS_vqS9ap-bLBnQMisJU")
  end

  it "publishes a status update" do
    FacebookUpdaterWorker.perform(item.id, facebook_account.id)
  end
end
