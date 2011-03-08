Given /^I have a stream I want to edit$/ do
  @stream = Factory(:stream, :user_id => @user.id, :feed_id => @feed.id, :twitter_accounts => [@twitter_account])
end

When /^I change the stream name to "([^"]*)"$/ do |name|
  fill_in("Stream Name", :with => name)
end

Then /^the stream should not be active$/ do
  @stream.reload.should_not be_active
end

Then /^the twitter account should be selected$/ do 
  page.should have_css("select#twitter_account option[selected]")
end

Then /^my stream shouldn't have twitter accounts$/ do
  stream = Stream.last
  stream.should have(0).twitter_accounts
end

