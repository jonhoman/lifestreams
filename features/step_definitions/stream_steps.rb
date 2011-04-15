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
  check "my facebook account"
  check "example email list"
  click_button "Create Stream"
end

When /^I fill in the stream information with included categories$/ do
  fill_in "Stream Name", :with => "Test Stream"
  check "example feed"
  check "example feed 2"
  check "test"
  check "different_handle"
  check "my facebook account"
  check "example email list"
  fill_in "Only include these categories:", :with => "tech"
  click_button "Create Stream"
end

When /^I leave the name blank$/ do
  check "example feed"
  check "test"
  click_button "Create Stream"
end

When /^I change the stream name to "([^"]*)"$/ do |name|
  fill_in("Stream Name", :with => name)
end

When /^I edit my stream to have no destinations$/ do
  visit(edit_stream_path(Stream.last))
  uncheck "test" 
  click_button "Update Stream"
end

When /^I edit my stream's name$/ do
  visit(edit_stream_path(Stream.last))
  fill_in "Stream Name", :with => "Real Stream"
  click_button "Update Stream"
end

When /^I delete my stream$/ do
  click_link "Delete Stream"
end

Then /^the stream should not be active$/ do
  @stream.reload.should_not be_active
end

Then /^my stream shouldn't have any destinations$/ do
  stream = Stream.last
  stream.should have(0).twitter_accounts
  stream.should have(0).facebook_accounts
  stream.should have(0).email_lists
end

Then /^my stream's name should have changed$/ do
  page.should have_content "Real Stream"
end

Then /^my stream is removed$/ do
  page.should_not have_content "example stream"
  Stream.count.should be_zero
end

Then /^my stream has a feed and a twitter account$/ do
  stream = Stream.last
  stream.should have(1).feed
  stream.should have(1).twitter_accounts
end

Then /^I should see the categories I chose$/ do
  page.should have_content "cat1, cat2"
end
