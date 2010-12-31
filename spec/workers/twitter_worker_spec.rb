require 'spec_helper'

describe TwitterWorker do
  xit "updates twitter account with item data" do
    item = Item.create!(:title => "Hello, World!", :body => "My First Post")

    TwitterWorker.perform(item.id)
    item.shared.should be_true
  end
end
