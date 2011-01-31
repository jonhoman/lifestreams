Given /^an item has clicks$/ do
  @feed.items.first.update_attributes!(:bitly_hash => 'fXEv5E')
end

