Given /^I configure two twitter accounts$/ do
  @twitter_account = Factory(:twitter_account, :user_id => @user.id)
  @twitter_account2 = Factory(:twitter_account, :handle => "different_handle", :user_id => @user.id)
end

Given /^I configure my twitter account$/ do
  @twitter_account = Factory(:twitter_account, :user_id => @user.id)
end

Given /^another user configures a twitter account$/ do
  @twitter_account2 = Factory(:twitter_account, :handle => "different_handle", :user_id => @user.id + 1)
end

Given /^I add a feed$/ do
  VCR.use_cassette("feed", :record => :new_episodes) do
    @feed = Factory(:feed, :user_id => @user.id)
  end
end

Given /^I add a feed that has items$/ do
  Given 'I add a feed'
  @feed.items << Factory(:item)
end

Given /^I add (\d+) items to my feed$/ do |item_count|
  item_count.to_i.times do |n|
    @feed.items << Factory(:item, :title => "example item #{n + 1}") 
  end
end

Given /^I add a stream$/ do
  @stream = Factory(:stream, :user_id => @user.id)
end

Given /^I add an email list$/ do
  @email_list = Factory(:email_list, :user_id => @user.id)
end

Given /^I add my feed to my stream$/ do
  @stream.update_attributes! :feed => @feed
end

Given /^I add my twitter account to my stream$/ do
  @stream.update_attributes! :twitter_accounts => [@twitter_account]
end

Given /^I add my feed and my twitter account to my stream$/ do
  @stream.update_attributes! :feed => @feed, :twitter_accounts => [@twitter_account]
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
  @stream.update_attributes! :twitter_accounts => []
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

Then /^I should see my email list$/ do
  Then 'I should see "example email list"'
end

Then /^I should see items$/ do 
  page.should have_selector('ul#item_list li')
end

Then /^I should see at most (\d+) items$/ do |item_count|
  page.should have_selector('ul#item_list li', :maximum => item_count.to_i)
end

