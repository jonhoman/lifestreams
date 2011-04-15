Given /^I have a twitter account$/ do
  @twitter_account = Factory(:twitter_account, :user_id => @user.id)
end

When /^I delete my twitter account$/ do
  click_link "Delete Twitter Account"
end

Then /^my twitter account should be removed$/ do
  page.should_not have_content "test"
  TwitterAccount.count.should be_zero
end
