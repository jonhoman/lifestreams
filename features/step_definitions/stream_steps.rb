Given /^I have a stream I want to edit$/ do
  @stream = Factory(:stream, :user_id => @user.id, :feed_id => @feed.id, :twitter_accounts => [@twitter_account])
end

When /^I change the stream name to "([^"]*)"$/ do |name|
  fill_in("Stream Name", :with => name)
end

Then /^the stream should not be active$/ do
  @stream.reload.should_not be_active
end
