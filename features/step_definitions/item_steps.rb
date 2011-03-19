Given /^an item has clicks$/ do
  @feed.items.first.update_attributes!(:bitly_url => 'http://bit.ly/fXEv5E')
end

