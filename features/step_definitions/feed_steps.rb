Given /^I have a feed I want to edit$/ do
 @feed = Feed.create!(:name => "Jon's Feed", :url => "http://example.org/feed", :user_id => @user.id)
end

When /^change the feed name to "([^"]*)"$/ do |name|
  fill_in("Feed Name", :with => name)
end

