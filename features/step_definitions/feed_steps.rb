Given /^I have a feed I want to edit$/ do
 @feed = Feed.create!(:name => "Jon's Feed", :url => "http://example.org/feed", :user_id => @user) 
end

