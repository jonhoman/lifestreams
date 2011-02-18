require 'spec_helper'

describe TwitterUpdaterWorker do
  use_vcr_cassette "twitter", :record => :new_episodes

  before(:each) do
    @mash = Hashie::Mash.new
    @mash.id_str = "1234"
    @item = Item.create!(:title => "Hello, World!", :body => "My First Post", :link => "http://google.com")
  end

  let :twitter_account do
    Factory(:twitter_account)
  end
  
  it "shares the new item" do
    Twitter.should_receive(:update).and_return { @mash }
    TwitterUpdaterWorker.perform(@item.id, twitter_account.id)

    @item.reload.shared.should be_true
  end

  it "store the status id on the item" do
    Twitter.should_receive(:update).and_return { @mash }
    TwitterUpdaterWorker.perform(@item.id, twitter_account.id)

    @item.reload.status_id.should == "1234"
  end

  it "throws an error if the account is unauthorized" do
    Twitter.should_receive(:update).and_raise(StandardError.new)

    expect {
      TwitterUpdaterWorker.perform(@item.id, twitter_account.id)
    }.to raise_error(Twitter::Unauthorized)
  end

  it "deactivates the twitter account if unauthorized" do
    Twitter.should_receive(:update).and_raise(StandardError.new)

    expect {
      TwitterUpdaterWorker.perform(@item.id, twitter_account.id)
    }.to raise_error(Twitter::Unauthorized)

    twitter_account.reload.should_not be_active
  end
end
