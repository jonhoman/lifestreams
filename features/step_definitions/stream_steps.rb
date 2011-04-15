Given /^I want to create a new stream$/ do
  click_link "Add new Stream"
end

Given /^I have a stream I want to edit$/ do
  @stream = Factory(:stream, :user_id => @user.id, :feeds => [@feed], :twitter_accounts => [@twitter_account])
end

When /^I fill in the stream information$/ do
  fill_in "Stream Name", :with => "Test Stream"
  check "example feed"
  check "example feed 2"
  check "test"
  check "different_handle"
  check "Facebook Account"
  check "example email list"
  click_button "Create Stream"
end

When /^I change the stream name to "([^"]*)"$/ do |name|
  fill_in("Stream Name", :with => name)
end

Then /^the stream should not be active$/ do
  @stream.reload.should_not be_active
end

Then /^my stream shouldn't have twitter accounts$/ do
  stream = Stream.last
  stream.should have(0).twitter_accounts
end

