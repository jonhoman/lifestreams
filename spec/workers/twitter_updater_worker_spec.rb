require 'spec_helper'

describe TwitterUpdaterWorker do
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
end
