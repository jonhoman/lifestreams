Given /^I have a twitter account$/ do
  @twitter_account = Factory(:twitter_account, :user_id => @user.id)
end

