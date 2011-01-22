Given /^I configure my twitter account$/ do
  @twitter_account = Factory(:twitter_account, :user_id => @user.id)
end

Given /^another user configures a twitter account$/ do
  @twitter_account2 = Factory(:twitter_account, :handle => "different_handle", :user_id => @user.id + 1)
end

Given /^I add a feed$/ do
  @feed = Factory(:feed, :user_id => @user.id)
end

Given /^I add a feed that has items$/ do
  Given 'I add a feed'
  @feed.items << Factory(:item)
end

Given /^I add a stream$/ do
  @stream = Factory(:stream, :user_id => @user.id)
end

Given /^I add my feed and my twitter account to my stream$/ do
  @stream.update_attributes! :feed => @feed, :twitter_account => @twitter_account
end

Given /^I create a stream with a feed and a twitter account$/ do
  And 'I add a feed that has items'
  And 'I configure my twitter account'
  And 'I add a stream'
  And 'I add my feed and my twitter account to my stream'
end

Given /^I remove the feed from the stream$/ do
  @stream.update_attributes! :feed => nil
end

Given /^I remove the twitter account from the stream$/ do
  @stream.update_attributes! :twitter_account => nil
end
Then /^I should see my feed$/ do
  Then 'I should see "example feed"'
end

Then /^I should see my configured twitter account$/ do
  Then 'I should see "test"'
end

Then /^I should not see the other user's twitter account$/ do
  Then 'I should not see "different_handle"'
end

Then /^I should see my stream$/ do
  Then 'I should see "example stream"'
end

