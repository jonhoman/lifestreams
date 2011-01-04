require 'spec_helper'

describe TwitterUpdaterWorker do
  it "shares the new item" do
    item = Item.create!(:title => "Hello, World!", :body => "My First Post")
    Twitter.should_receive(:configure) 
    Twitter.should_receive(:update).with("Blog Post: #{item.title}")

    TwitterUpdaterWorker.perform(item.id)
    item.reload.shared.should be_true
  end

  it "should update twitter with item info" do
    item = Item.create!(:title => "Hello, World!", :body => "My First Post")
    
    TwitterUpdaterWorker.perform(item.id)
  end

  xit "should have updated the user's timeline" do
    item = Item.create!(:title => "Hello, World!", :body => "My First Post")
   
    # check timeline before and after update???
    
    TwitterUpdaterWorker.perform(item.id)

  end
end