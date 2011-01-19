Given /^I have a stream I want to edit$/ do
  @stream = Factory(:stream, :user_id => @user.id, :feed_id => @feed.id, :twitter_account_id => @twitter_account.id)
end

When /^I change the stream name to "([^"]*)"$/ do |name|
  fill_in("Stream Name", :with => name)
end

