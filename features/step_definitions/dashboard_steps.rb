Given /^I configure my twitter account$/ do
  @twitter_account = Factory(:twitter_account, :user_id => @user.id)
end

Given /^another user configures a twitter account$/ do
  @twitter_account2 = Factory(:twitter_account, :handle => "different_handle", :user_id => @user.id + 1)
end

Then /^I should see my configured twitter account$/ do
  Then 'I should see "test"'
end

Then /^I should not see the other user's twitter account$/ do
  Then 'I should not see "different_handle"'
end


